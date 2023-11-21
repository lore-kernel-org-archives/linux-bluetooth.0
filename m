Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqcwhxNb"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F79BD40
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 13:32:40 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77891f362cfso18369585a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Nov 2023 13:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700602359; x=1701207159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e1y4C5lM+UmQpNeEFIoeJ5wa4Zz65p+KFUa7Sm1Icek=;
        b=ZqcwhxNbmHr8HPWEtCAuRWDuC6tRyIwVF76g6ndH9qyHNhJgycS+ODU0QrO2/Dq3vv
         WSxgEtRJTYDyon/0B18AyFyCQWdCpNceIFVvv4ymtjeTcXnuJplXqdLybHyzEachTnNf
         39NEaAIwopbhcGn4PZ94xU7EtgQzNQEMuUYk14+fpcVQhh1VIOyIrdf8BGnv5jmFW8WG
         sBUuemrIs42F5vfvag3RTDjIYfU36GnONF5XMhYz+KuKw73Eb2iEcl3PhMNqj1zhV59y
         lyEFjmN3I2ufXSUlTuF0O5S3v7C3i9fmRZm4GGOtMvHS0aBhD3tWnh7+Jy4rmwsr1NQ/
         J+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700602359; x=1701207159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1y4C5lM+UmQpNeEFIoeJ5wa4Zz65p+KFUa7Sm1Icek=;
        b=aOFJW3fdFCEdcgwu4gpN1IHMWVNjNw1L6JScRSjNJL12/gJFU4fbbVI6BLyscPWLRp
         /BiQjfvxh0UtmtHf3OamkDxvsYasMYlhvHZwexGb2sZhvl3vuD2c1MnwNKnURd7wAC1D
         aPT4EZYpWTukaYTH+mHa+ajAJHgM0+mE0iWx4KxGtm1wAZ96vED84Xap87wQoT1fVKWr
         IXcabQ9icQ3GQvJ5XMzGfnqL3sBGLXq54VOEdGOUn4NBzyFhvv1wOmKQXpUy56S8tABN
         Y+ZH1XHev4/fnvZ7mryvpvFtBh+CNA1bI+FSG4Qq/C5++CrM7HgiDcwQemK8UM1AI2J8
         tE/w==
X-Gm-Message-State: AOJu0YwbTzSYRIrqTqcirVp4PrSBT876qTk5iUUFrTQwijwZO9YZuHrf
	oXfdMjQmOLp4w4cHRH1bbenyVhK+PdQ=
X-Google-Smtp-Source: AGHT+IEQ7ZbCf8VE5073smbw0uKno6cM3xExCL7MFHW5+R0kKwiVxljAII57rAREQx3YWPUGIQcF3A==
X-Received: by 2002:a05:620a:4629:b0:778:e431:3ef1 with SMTP id br41-20020a05620a462900b00778e4313ef1mr1056918qkb.32.1700602359088;
        Tue, 21 Nov 2023 13:32:39 -0800 (PST)
Received: from [172.17.0.2] ([20.51.206.102])
        by smtp.gmail.com with ESMTPSA id pb10-20020a05620a838a00b0077703f31496sm3943814qkn.92.2023.11.21.13.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:32:38 -0800 (PST)
Message-ID: <655d21f6.050a0220.4da64.36e8@mx.google.com>
Date: Tue, 21 Nov 2023 13:32:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4829238610572920190=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] shared/util: Add GMAP related UUIDs
In-Reply-To: <20231121201402.617067-1-luiz.dentz@gmail.com>
References: <20231121201402.617067-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4829238610572920190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=802985

---Test result---

Test Summary:
CheckPatch                    FAIL      1.23 seconds
GitLint                       FAIL      0.88 seconds
BuildEll                      PASS      23.95 seconds
BluezMake                     PASS      576.11 seconds
MakeCheck                     PASS      10.52 seconds
MakeDistcheck                 PASS      150.93 seconds
CheckValgrind                 PASS      210.30 seconds
CheckSmatch                   WARNING   316.02 seconds
bluezmakeextell               PASS      97.47 seconds
IncrementalBuild              PASS      1035.37 seconds
ScanBuild                     PASS      939.35 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1,1/2] shared/util: Add GMAP related UUIDs
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#72: 
[1] https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=576496

/github/workspace/src/src/13463536.patch total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13463536.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] shared/util: Add GMAP related UUIDs

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (94>80): "[2] https://www.bluetooth.com/wp-content/uploads/Files/Specification/Assigned_Numbers.pdf?id=3"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/att.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============4829238610572920190==--
