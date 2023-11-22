Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBGEJCli"
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01C21B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 12:57:15 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-581ed744114so127193eaf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Nov 2023 12:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700686635; x=1701291435; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx1hq9eu3CUmxAqSvdIvm1XiA/Txf5ZvDVRovdLDyUo=;
        b=lBGEJClid5tieka0ngiED71LYuiiUoX5wt1qEPpVtIe8AZzSExm3pNxu3jMNhnvaTH
         vkW+ZqHizYDCK4TOE0QjvpeR8SHddOqEyO8EsmARdivn595xoydyJesGGDpknG2CNSW5
         SgCZ8mM1lYj06wgO3UYSw3zEH3GIk/mBYQGQaZii3uahbB/2QNV9VCslVUBs3Pr5MWDL
         cf69pGAu9FqoLdNXtVJANQb/28/RcGMa2HnTjypc9h/9bj+xBkaY/w0ygYSMJnCXkt0F
         7u0t/Jj7pEh4sLaBDoZ3tFgb7UGXedY3SKcJnKt0z8X1fRVym4KENCcMKdwQGUcRurQT
         ahQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700686635; x=1701291435;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vx1hq9eu3CUmxAqSvdIvm1XiA/Txf5ZvDVRovdLDyUo=;
        b=vVzt23R1hYMTPH3Tpx+ihjleyvK6yAVawVZS1VPrhl4J6BDdOSKDzWvtA/yywxihCt
         VcCpqfBrr/5XqfhOBrFyqWnL4k7E1aTX4DWUDPvjxJewE7oXexCZvtXPsbVtctGeH3xA
         CvfZ3FGW47U56GmpYAEX8khvxxPA0mADclxWwLwwnQYc2yofYS0eFWqZ0sOtNeE9T2tE
         dFmPNfkxfFp4NY+EmEM+dM66j6t+ZyYA8ID5dSorK4evGRKGCvNUBDZq0wymbKzCOzTl
         ZcrX/u8mn8S0D9pBFwXrFxDFPKGH6IBo0ABBJ+MR3E5v6D7j9BdGDlfwQTH8Ikh8H1CI
         RCbQ==
X-Gm-Message-State: AOJu0YxSamvKZOZAlr0fi7pE4VFfiZ7t5veFRn8/WlaltDbHcj/oOhRt
	lrckg2xhxf277B1O1Wr9K/wVNY1FG1Q=
X-Google-Smtp-Source: AGHT+IFHXgCLcaEI10ltIVS7UiKPDPo144gSr7eQpj8mkJcnGhEo3yTwjWe8QL4dhUwf9WeuNtFewA==
X-Received: by 2002:a05:6358:9226:b0:16b:c6f5:5e3b with SMTP id d38-20020a056358922600b0016bc6f55e3bmr2995396rwb.26.1700686634698;
        Wed, 22 Nov 2023 12:57:14 -0800 (PST)
Received: from [172.17.0.2] ([172.183.122.247])
        by smtp.gmail.com with ESMTPSA id w14-20020ac843ce000000b00419801b1094sm110290qtn.13.2023.11.22.12.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:57:14 -0800 (PST)
Message-ID: <655e6b2a.c80a0220.718a1.0d5a@mx.google.com>
Date: Wed, 22 Nov 2023 12:57:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4002755953550804480=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] shared/util: Add GMAP related UUIDs
In-Reply-To: <20231122190649.879386-1-luiz.dentz@gmail.com>
References: <20231122190649.879386-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4002755953550804480==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=803411

---Test result---

Test Summary:
CheckPatch                    FAIL      2.19 seconds
GitLint                       FAIL      1.61 seconds
BuildEll                      PASS      24.11 seconds
BluezMake                     PASS      556.69 seconds
MakeCheck                     PASS      11.10 seconds
MakeDistcheck                 PASS      149.71 seconds
CheckValgrind                 PASS      209.27 seconds
CheckSmatch                   WARNING   317.26 seconds
bluezmakeextell               PASS      96.60 seconds
IncrementalBuild              PASS      2527.23 seconds
ScanBuild                     PASS      892.97 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/5] shared/util: Add GMAP related UUIDs
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#72: 
[1] https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=576496

/github/workspace/src/src/13465382.patch total: 0 errors, 1 warnings, 18 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13465382.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,5/5] client/player: Add presets from GMAP
ERROR:SPACING: need consistent spacing around '*' (ctx:VxW)
#194: FILE: client/player.c:1525:
+			LC3_7_5_UNFRAMED(2* 75u, 1u, 15u, 10000u)),
 			                  ^

ERROR:SPACING: need consistent spacing around '*' (ctx:VxW)
#198: FILE: client/player.c:1529:
+			LC3_10_UNFRAMED(2* 100u, 1u, 20u, 10000u)),
 			                 ^

/github/workspace/src/src/13465386.patch total: 2 errors, 0 warnings, 105 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13465386.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/5] shared/util: Add GMAP related UUIDs

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


--===============4002755953550804480==--
