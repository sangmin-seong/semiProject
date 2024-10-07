-------------------------------------------------------------
/* SPRING 계정 접속 후 테이블, 시퀀스 생성 */

/* 강의실(CLASS) 테이블 생성*/
CREATE TABLE "CLASS"(
	"CLASS_NO"      NUMBER,
	"TRINNER_NO"    NUMBER,
	"THUMBNAIL_IMG" VARCHAR2(300),
	"CLASS_CODE"		NUMBER,
	
	CONSTRAINT "CLASS_PK"         PRIMARY KEY("CLASS_NO")
);


COMMENT ON COLUMN "CLASS"."CLASS_NO"       IS '강의실 번호(PK)';
COMMENT ON COLUMN "CLASS"."TRINNER_NO"     IS '강사 번호';
COMMENT ON COLUMN "CLASS"."THUMBNAIL_IMG"  IS '썸네일';
COMMENT ON COLUMN "CLASS"."CLASS_CODE"     IS '강의번호';

CREATE TABLE "TRAINNER_CLASS"(
	"CLASS_CODE"		NUMBER,
	"CLASS_TITLE"		VARCHAR2(300),
	"CLASS_DETAIL"	VARCHAR2(300),
	"CLASS_HITS"		NUMBER,
	"UPLOAD_DATE"	DATE DEFAULT CURRENT_DATE,
	"BILLING_DATE"	DATE DEFAULT CURRENT_DATE,
	
	CONSTRAINT "TRAINNER_CLASS_PK" PRIMARY KEY("CLASS_CODE")
);


COMMENT ON COLUMN "TRAINNER_CLASS"."CLASS_CODE"    IS '강의번호(PK)';
COMMENT ON COLUMN "TRAINNER_CLASS"."CLASS_TITLE"   IS '강의제목';
COMMENT ON COLUMN "TRAINNER_CLASS"."CLASS_DETAIL"  IS '강의내용';
COMMENT ON COLUMN "TRAINNER_CLASS"."CLASS_HITS"    IS '조회수';
COMMENT ON COLUMN "TRAINNER_CLASS"."UPLOAD_DATE"   IS '게시일';
COMMENT ON COLUMN "TRAINNER_CLASS"."BILLING_DATE"  IS '수정일';

/* 회원(MEMBER) 테이블 생성*/
CREATE TABLE "MEMBER"(
	"MEMBER_NO"       NUMBER,
	"MEMBER_EMAIL"    VARCHAR2(50)  NOT NULL,
	"MEMBER_PW"       VARCHAR2(100) NOT NULL,
	"MEMBER_NICKNAME" NVARCHAR2(10) NOT NULL,
	"MEMBER_TEL"      CHAR(11)      NOT NULL,
	"MEMBER_ADDRESS"  NVARCHAR2(150),
	"PROFILE_IMG"     VARCHAR2(300),
	"ENROLL_DATE"			DATE DEFAULT CURRENT_DATE,
	"MEMBER_DEL_FL"		CHAR(1) DEFAULT 'N',
	"AUTHORITY_MEMBER"				NUMBER DEFAULT 1,
	
	CONSTRAINT "MEMBER_PK"         PRIMARY KEY("MEMBER_NO"),
	CONSTRAINT "MEMBER_DEL_FL_CHK" CHECK("MEMBER_DEL_FL" IN ('Y','N')),
	CONSTRAINT "AUTHORITY_MEMBER_CHK"     CHECK("AUTHORITY_MEMBER" IN ('1','2'))
);


-- COMMENT 추가
COMMENT ON COLUMN "MEMBER"."MEMBER_NO"       IS '회원번호(PK)';
COMMENT ON COLUMN "MEMBER"."MEMBER_EMAIL"    IS '회원 아이디(ID)';
COMMENT ON COLUMN "MEMBER"."MEMBER_PW"       IS '회원 비밀번호';
COMMENT ON COLUMN "MEMBER"."MEMBER_NICKNAME" IS '회원명';
COMMENT ON COLUMN "MEMBER"."MEMBER_TEL"      IS '회원 전화번호(-제외)';
COMMENT ON COLUMN "MEMBER"."MEMBER_ADDRESS"  IS '회원 주소';
COMMENT ON COLUMN "MEMBER"."PROFILE_IMG"     IS '프로필 이미지 경로';
COMMENT ON COLUMN "MEMBER"."ENROLL_DATE"     IS '가입일';

COMMENT ON COLUMN "MEMBER"."MEMBER_DEL_FL"    IS '탈퇴여부(Y,N)';
COMMENT ON COLUMN "MEMBER"."AUTHORITY_MEMBER" IS '회원권한(1:일반, 2:관리자)';



-- 회원 결제 클래스 테이블
CREATE TABLE "MEMBER_CLASS"(
	"MEMBER_NO"         NUMBER,
	"CLASS_CHARGE_DATE" DATE DEFAULT CURRENT_DATE,
	"CLASS_CODE"        NUMBER,
	
	CONSTRAINT "MEMBER_CLASS_PK"     PRIMARY KEY("MEMBER_NO")
);

COMMENT ON COLUMN "MEMBER_CLASS"."MEMBER_NO"       		IS '결제한 회원번호(PK)';
COMMENT ON COLUMN "MEMBER_CLASS"."CLASS_CHARGE_DATE"    IS '결제한 날짜';
COMMENT ON COLUMN "MEMBER_CLASS"."CLASS_CODE"       	IS '결제한 수업번호';

-- 회원번호 시퀀스 생성
CREATE SEQUENCE SEQ_MEMBER_NO NOCACHE;


/* 강사(TRAINNER) 테이블 생성*/
CREATE TABLE "TRAINNER"(
	"TRAINNER_NO"           NUMBER,
	"TRAINNER_EMAIL"        VARCHAR2(50)  NOT NULL,
	"TRAINNER_PW"           VARCHAR2(100) NOT NULL,
	"TRAINNER_NICKNAME"     NVARCHAR2(10) NOT NULL,
	"TRAINNER_TEL"          CHAR(11)      NOT NULL,
	"TRAINNER_ADDRESS"      NVARCHAR2(150),
	"PROFILE_IMG"    		VARCHAR2(300),
	"QUALIFICATION"         VARCHAR2(500),
	"ENROLL_DATE"			DATE DEFAULT CURRENT_DATE,
	"TRAINNER_DEL_FL"		CHAR(1) DEFAULT 'N',
	"AUTHORITY_TRAINNER"	NUMBER DEFAULT 1,
	
	CONSTRAINT "TRAINNER_PK"         		PRIMARY KEY("TRAINNER_NO"),
	CONSTRAINT "TRAINNER_DEL_FL_CHK"        CHECK("TRAINNER_DEL_FL" IN ('Y','N')),
	CONSTRAINT "AUTHORITY_TRAINNER_CHK"     CHECK("AUTHORITY_TRAINNER" IN ('1','2'))
);


-- COMMENT 추가
COMMENT ON COLUMN "TRAINNER"."TRAINNER_NO"        IS '강사번호(PK)';
COMMENT ON COLUMN "TRAINNER"."TRAINNER_EMAIL"     IS '강사 아이디(ID)';
COMMENT ON COLUMN "TRAINNER"."TRAINNER_PW"        IS '강사 비밀번호';
COMMENT ON COLUMN "TRAINNER"."TRAINNER_NICKNAME"  IS '강사명';
COMMENT ON COLUMN "TRAINNER"."TRAINNER_TEL"       IS '강사 전화번호(-제외)';
COMMENT ON COLUMN "TRAINNER"."TRAINNER_ADDRESS"   IS '강사 주소';
COMMENT ON COLUMN "TRAINNER"."PROFILE_IMG"        IS '프로필 이미지 경로';
COMMENT ON COLUMN "TRAINNER"."QUALIFICATION"      IS '강사 자격정보';
COMMENT ON COLUMN "TRAINNER"."ENROLL_DATE"        IS '가입일';
COMMENT ON COLUMN "TRAINNER"."TRAINNER_DEL_FL"    IS '탈퇴여부(Y,N)';
COMMENT ON COLUMN "TRAINNER"."AUTHORITY_TRAINNER" IS '권한(1:강사, 2:관리자)';


/* 관리자(MANAGER) 테이블 생성*/
CREATE TABLE "MANAGER"(
	"MANAGER_NO"         NUMBER,
	"MANAGER_EMAIL"      VARCHAR2(50)  NOT NULL,
	"MANAGER_PW"         VARCHAR2(100) NOT NULL,
	"MANAGER_NICKNAME"   NVARCHAR2(10) NOT NULL,
	"MANAGER_TEL"        CHAR(11)      NOT NULL,
	"MANAGER_ADDRESS"    NVARCHAR2(150),
	"PROFILE_IMG"    	 VARCHAR2(300),
	"ENROLL_DATE"		 DATE DEFAULT CURRENT_DATE,
	"MANAGER_DEL_FL"	 CHAR(1) DEFAULT 'N',
	"AUTHORITY_MANAGER"	 NUMBER DEFAULT 1,
	"AUTHORITY_MEMBER"	 NUMBER DEFAULT 2,
	"AUTHORITY_TRAINNER" NUMBER DEFAULT 2,
	
	CONSTRAINT "MANAGER_PK"         				  PRIMARY KEY("MANAGER_NO"),
	CONSTRAINT "MANAGER_DEL_FL_CHK" 				  CHECK("MANAGER_DEL_FL" IN ('Y','N')),
<<<<<<< HEAD
	CONSTRAINT "AUTHORITY_MANAGER"               CHECK("AUTHORITY_MANAGER" IN ('1','2')),
	CONSTRAINT "AUTHORITY_TRAINNER"               CHECK("AUTHORITY_TRAINNER" IN ('1','2')),
	CONSTRAINT "AUTHORITY_MEMBER"                 CHECK("AUTHORITY_MEMBER" IN ('1','2'))
=======
	CONSTRAINT "AUTHORITY_MANAGER_CHK"               CHECK("AUTHORITY_MANAGER" IN ('1','2'))
	CONSTRAINT "AUTHORITY_TRAINNER_CHK"               CHECK("AUTHORITY_TRAINNER" IN ('1','2'))
	CONSTRAINT "AUTHORITY_MEMBER_CHK"                 CHECK("AUTHORITY_MEMBER" IN ('1','2'))
>>>>>>> 19d0c1594787ea753adf44847aa40c541ff828b4
);


-- COMMENT 추가
COMMENT ON COLUMN "MANAGER"."MANAGER_NO"         IS '관리자 번호(PK)';
COMMENT ON COLUMN "MANAGER"."MANAGER_EMAIL"      IS '관리자 아이디(ID)';
COMMENT ON COLUMN "MANAGER"."MANAGER_PW"         IS '관리자 비밀번호';
COMMENT ON COLUMN "MANAGER"."MANAGER_NICKNAME"   IS '관리자명';
COMMENT ON COLUMN "MANAGER"."MANAGER_TEL"        IS '관리자 전화번호(-제외)';
COMMENT ON COLUMN "MANAGER"."MANAGER_ADDRESS"    IS '관리자 주소';
COMMENT ON COLUMN "MANAGER"."PROFILE_IMG"        IS '프로필 이미지 경로';
COMMENT ON COLUMN "MANAGER"."ENROLL_DATE"        IS '가입일';
COMMENT ON COLUMN "MANAGER"."MANAGER_DEL_FL"     IS '탈퇴여부(Y,N)';
COMMENT ON COLUMN "MANAGER"."AUTHORITY_MANAGER"  IS '관리자권한';
COMMENT ON COLUMN "MANAGER"."AUTHORITY_MEMBER"   IS '회원권한';
COMMENT ON COLUMN "MANAGER"."AUTHORITY_TRAINNER" IS '강사권한';


SELECT 
	EMP_ID,
	EMP_NAME,
	SALARY
FROM EMPLOYEE;











INSERT INTO BOARD_TYPE VALUES(1, '공지사항');
INSERT INTO BOARD_TYPE VALUES(2, '자유게시판');
INSERT INTO BOARD_TYPE VALUES(3, '정보게시판');
COMMIT;

------------------------------------------------------

/* 게시글 번호 시퀀스 생성 */
CREATE SEQUENCE SEQ_BOARD_NO NOCACHE;

/* PL/SQL을 이용해서 BOARD 테이블에 샘플 데이터 삽입 */
BEGIN 
	FOR I IN 1..2000 LOOP
		INSERT INTO "BOARD"
		VALUES(
			SEQ_BOARD_NO.NEXTVAL,
			SEQ_BOARD_NO.CURRVAL || '번째 게시글',
			SEQ_BOARD_NO.CURRVAL || '번째 게시글 내용입니다.',
			DEFAULT, DEFAULT, DEFAULT, DEFAULT,
			1, 
			CEIL( DBMS_RANDOM.VALUE(0,3) )
		);
	END LOOP;
END;



SELECT COUNT(*) FROM BOARD;

COMMIT;

-- 게시판종류별 샘플 데이터 개수 확인
SELECT BOARD_CODE, COUNT(*)
FROM BOARD
GROUP BY BOARD_CODE
ORDER BY BOARD_CODE ASC;

---------------------------------
/* 댓글 번호 시퀀스 생성 */
CREATE SEQUENCE SEQ_COMMENT_NO NOCACHE;



/* 댓글 테이블("COMMENT")에 샘플 데이터 삽입 */
BEGIN
	FOR I IN 1..3000 LOOP
		INSERT INTO "COMMENT"
		VALUES(
			SEQ_COMMENT_NO.NEXTVAL,
			SEQ_COMMENT_NO.CURRVAL || '번째 댓글',
			DEFAULT, DEFAULT,
			1,
			CEIL( DBMS_RANDOM.VALUE(0, 1999) ),
			NULL
			);
	END LOOP;
END;

SELECT COUNT(*) FROM "COMMENT";

COMMIT;


-- 게시글 번호 2000번에 작성된 댓글 개수 조회
SELECT BOARD_NO, COUNT(*) 
FROM "COMMENT"
GROUP BY BOARD_NO
ORDER BY BOARD_NO;


/* 특정 게시판(BOARD_CODE)에
 * 삭제 되지 않은 게시글 목록 조회
 * 
 * - 조회된 행 번호, : ROWNUM 또는 ROW_NUMBER() 이용
 *   게시글 번호, 제목, 조회수, 작성일 : BOARD 테이블 컬럼
 *   작성자 닉네임 : MEMBER 테이블에서 MEMBER_NICKNAME 컬럼
 *   댓글수 : COMMENT 테이블에서 BOARD_NO 별 댓글 수(COUNT)
 *   좋아요 갯수 : BOARD_LIKE 테이블에서 BOARD_NO 별 댓글 수(COUNT)
 * 	 
 * - 작성일은 몇 초/분/시간 전 또는 YYYY-MM-DD형식으로 조회
 * 
 * - 가장 최근 글이 제일 처음 조회
 *   (SEQ_BOARD_NO를 이용, 내림차순 정렬)
 */

-- ROW_NUMBER() OVER (ORDER BY BOARD_NO ASC) AS "RNUM"
 -->  BOARD_NO 오름차순으로 정렬 후 조회된 행의 번호를 지정

-- 상관 서브쿼리 해석 순서
-- 1) 메인 쿼리 1행 해석
-- 2) 서브 쿼리에서 메인 쿼리 1행 조회 결과를 이용 -> 해석
-- 3) 다시 메인 쿼리 해석


SELECT
	ROW_NUMBER() OVER(ORDER BY BOARD_NO ASC) AS "RNUM",
	BOARD_NO,
	BOARD_TITLE,
	READ_COUNT,
	MEMBER_NICKNAME,
	(SELECT COUNT(*)
	 FROM "COMMENT" C
	 WHERE C.BOARD_NO = B.BOARD_NO ) AS "COMMENT_COUNT",
	 
	(SELECT COUNT(*)
	 FROM "BOARD_LIKE" L
	 WHERE L.BOARD_NO = B.BOARD_NO ) AS "LIKE_COUNT",
	 
	CASE 
		WHEN CURRENT_DATE - BOARD_WRITE_DATE < 1 / 24 / 60
		THEN FLOOR ( (CURRENT_DATE - BOARD_WRITE_DATE)
									* 24 * 60 * 60) || '초 전'
		
		WHEN CURRENT_DATE-BOARD_WRITE_DATE < 1 / 24
		THEN FLOOR ( (CURRENT_DATE - BOARD_WRITE_DATE)
									* 24 * 60 ) || '분 전'

		WHEN CURRENT_DATE - BOARD_WRITE_DATE < 1
		THEN FLOOR ( (CURRENT_DATE - BOARD_WRITE_DATE)
									* 24) || '시간 전'
									
		ELSE TO_CHAR(BOARD_WRITE_DATE, 'YYYY-MM-DD')
		
	END AS BOARD_WRITE_DATE
	 
FROM
	"BOARD" B
JOIN
	"MEMBER" M ON(B.MEMBER_NO = M.MEMBER_NO)
WHERE
	BOARD_DEL_FL = 'N'
AND
	BOARD_CODE = 1	
ORDER BY RNUM DESC
;

INSERT INTO "BOARD"
VALUES(
	SEQ_BOARD_NO.NEXTVAL,
	SEQ_BOARD_NO.CURRVAL || '번째 게시글',
	SEQ_BOARD_NO.CURRVAL || '번째 게시글 내용 입니다',
	DEFAULT, DEFAULT, DEFAULT, DEFAULT,
	1, 
	1
);




SELECT *
FROM "BOARD";

INSERT INTO "BOARD"
		VALUES(SEQ_BOARD_NO.NEXTVAL, #{boardTitle}, #{boardContent},
						DEFAULT, DEFAULT, DEFAULT, DEFAULT,
						#{memberNo}, #{boardCode}					 );


SELECT SEQ_BOARD_NO.NEXTVAL FROM DUAL;

-- -----------------------------------------------------------------
-- 이미지 번호 생성용 시퀀스
CREATE SEQUENCE SEQ_IMG_NO NOCACHE;

/* 여러 행을 한 번에 INSERT하는 방법
 * 
 * 1. INSERT ALL 구문
 * 2. INSERT + SUBQUERY(사용!)
 * 
 * 
 * [문제점] 위에 두 방법 다 SEQUENCE를 직접 사용할 수 없다(불가!!!)
 * 
 * 
 * */


-- SEQ_IMG_NO 시퀀스의 다음 값을 반환하는 함수 생성
CREATE OR REPLACE FUNCTION NEXT_IMG_NO

-- 반환형
RETURN NUMBER

-- 사용할 변수
IS IMG_NO NUMBER;

BEGIN 
	SELECT SEQ_IMG_NO.NEXTVAL 
	INTO IMG_NO
	FROM DUAL;

	RETURN IMG_NO;
END;




INSERT INTO BOARD_IMG
(
	SELECT
		NEXT_IMG_NO(),
		'/images/board',	'원본명',	'변경명', 	1,	2000
	FROM DUAL
	
	UNION ALL
	
	SELECT
		NEXT_IMG_NO(),
		'/images/board',	'원본명',	'변경명',	1,	2000
	FROM DUAL
);

ROLLBACK;











