Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5jdFaos"
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1840C1997
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 05:41:43 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67ad277a06bso11719626d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Dec 2023 05:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702042902; x=1702647702; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xZEW966zH5glqZKngX2bK6yUwAbYSuW2IOYm5kzlYvc=;
        b=S5jdFaosSR2L7SqiKMsniH4TAD1lLM/FXYoN2sp09nQ+cAGR27ZX9K5dHD8ssKeKXD
         OAn3afA2uw2B/nGZ79ezdJYkoDSMMPqENfGEInou/JUOuRDy+ppV7QnAzBsk0k8/ggDa
         cp3Qx/eVjKyEdZstI+9nYtoO5/c9WFDQQxBm6ZCxAM0yEDsqaUPhTKUWHRKlpujlLrwB
         9tDHCTbo40jyDWD1s1NFptK7bBisvzYNa3/Ae70UUCryaMqu6GNngmwDW+iyIHWGiZux
         cQK6TORlXMhlfwo2SD93dq0HIYN0IXGblFPg/6udpE5lzF9OQprlW6yDMO3uRXA/6Wn+
         PSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042902; x=1702647702;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZEW966zH5glqZKngX2bK6yUwAbYSuW2IOYm5kzlYvc=;
        b=CsoE9IwMk/fbWjwFic3IUAmJqT5BrDcDccmUHtVBXF92N9ZE4V8ekbovztNl5IoJZ7
         Alr79oCMTPuFxCMnscFPvpwEgMsSSJST21kC9OlE3HFu+39ePxyNaJCdUGOWSAj8JjL3
         XW9Z7450NSquTzej4iiEWu0HnnHjDuW30yosZSdhfjsV9sVgulCTt92v5wndR2JiAt/3
         tSRvFrkQlze5e6BtZRx9Y6Sf+ljaip3z/BIuxfdWrxTWMfAniyH6bGqNjqbWdf4uFBsj
         nWCApKP1KYuA48nUP0hRbhk4dCCHrUcHlzFFoRkkDbLI/rXBO2upo4MBOFB/yKNv/lMq
         wIbQ==
X-Gm-Message-State: AOJu0YwIbVjcAxVndj5fmzPsb9XprEQ77o1gZ5kR0mfvXrQ9IVoxAqKN
	thJUS5aUPNovlHl+6jnvQ1jAjoTgYI0muQ==
X-Google-Smtp-Source: AGHT+IHpl121zjGtLXlOV7q/79vGIKuHrMoFehBDKjEyaIAFIZD5wN1aqA1sG1j0OJR7KBJFtFqViw==
X-Received: by 2002:a0c:efd0:0:b0:67a:cc22:baac with SMTP id a16-20020a0cefd0000000b0067acc22baacmr4930941qvt.37.1702042902075;
        Fri, 08 Dec 2023 05:41:42 -0800 (PST)
Received: from [172.17.0.2] ([20.125.212.220])
        by smtp.gmail.com with ESMTPSA id t13-20020a0cef4d000000b0067a86ab485bsm807196qvs.15.2023.12.08.05.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:41:41 -0800 (PST)
Message-ID: <65731d15.0c0a0220.4e074.433f@mx.google.com>
Date: Fri, 08 Dec 2023 05:41:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4882958942729175561=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Implementation of AICS service and Unit Test cases
In-Reply-To: <20231208114258.133709-2-mahesh.talewad@nxp.com>
References: <20231208114258.133709-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4882958942729175561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=808228

---Test result---

Test Summary:
CheckPatch                    FAIL      3.21 seconds
GitLint                       FAIL      1.13 seconds
BuildEll                      PASS      24.11 seconds
BluezMake                     PASS      713.67 seconds
MakeCheck                     PASS      12.20 seconds
MakeDistcheck                 PASS      161.09 seconds
CheckValgrind                 PASS      224.75 seconds
CheckSmatch                   PASS      329.37 seconds
bluezmakeextell               PASS      106.51 seconds
IncrementalBuild              PASS      2017.55 seconds
ScanBuild                     PASS      933.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,3/3] unit/test-vcp.c: AICS unit test case implementation
WARNING:TYPO_SPELLING: 'Implementated' may be misspelled - perhaps 'Implemented'?
#113: 
- Implementated 15-Mandatory AICS Unit Test cases.
  ^^^^^^^^^^^^^

/github/workspace/src/src/13485348.patch total: 0 errors, 1 warnings, 1570 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13485348.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/3] - Added AICS Characteristics UUID(s).

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[BlueZ,v2,1/3] - Added AICS Characteristics UUID(s)."
[BlueZ,v2,2/3] - Code Implementation related Service- AICS

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B3 Line contains hard tab characters (\t): "	AICS_v1.0.pdf"
6: B3 Line contains hard tab characters (\t): "	mandatory testcases passed."
[BlueZ,v2,3/3] unit/test-vcp.c: AICS unit test case implementation

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B3 Line contains hard tab characters (\t): "	AICS.TS.p0.pdf"


---
Regards,
Linux Bluetooth


--===============4882958942729175561==--
