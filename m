Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INwbYi2Y"
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C2A4
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 16:43:28 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77f035e4dabso147910185a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Dec 2023 16:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701737008; x=1702341808; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9GCZf8fDJZ0g0wpK01ZBJ/w7bZuHJPDm5B+ynVFqVkU=;
        b=INwbYi2YjKtoRFcArV0EONeCOWEMstA429KTXkpbEv61VDJcxVs5tvKEFBcbv1Nc9C
         d0jUhotU3BkWBenG60gVdIgcC9Oh6ayeSqftM4twmWjIJa4B6oIibMDHPUbNy0dit32V
         t4ljj9fjeFuGnpQvoiP2FGO6hk4LTsU1ibNPrEc00uEAoOKfcsEfG6+5NPRzFxoz3Kpr
         mQgTcPuFmvyizgavEJJBSBmlTH+15Mm2yROQG6B+ezUI/h5Aqq7Ge+XIocGHbeVYboK4
         Ca2vx9ruJFunFNqyC/Rw4bymv9T4Yl8WPKjFh0SNXVr1JBAG+ukBTtfGOHd0fYEoDnpA
         LWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701737008; x=1702341808;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GCZf8fDJZ0g0wpK01ZBJ/w7bZuHJPDm5B+ynVFqVkU=;
        b=MjAo/nHD1oUQpj6tamfyqpjIRUhSV4xGwoxdspVUyye8YF7S2un12pGr2ON14qO6BX
         prMk/VUBJpLavR9Wz2uaLCxZimmCUXeC1Qghe1VHQxqdeNI5Zi6ccHexgjgxCnKIVKo8
         BakcW2RwD3DxoVo7qAARrv5LSi8AlZ/QFZRPGcBEXEexRREj0xvyayiipMN0kP3LYeMm
         40Ncf08H1ao5jdjD30Wf/2TyeX8bo8VA3LoRZwIQcgFvLNKCY0d9ER6fC8bEhunELv3w
         9Qd0Ev6IsFRTV/nQ9s5wajLMfi3aLJlWs2raXHF9r9ScDCdIbbj2sWHR/+cOVExwMtjG
         d3Iw==
X-Gm-Message-State: AOJu0Yx9v9KgcnzvPJT1nk7aQT3CQ3L74rICfg5fIEM5Uh+Ol8wdAvTQ
	lI22r/GAhmoh0McMwUV60XVZCJGPWLU=
X-Google-Smtp-Source: AGHT+IFIHGovK++DxCVMywM8mNUDOlzPJ9a2TC37NX1qpQmpD94k+gqerBwr/7EvAsCnLjCxCG0ApA==
X-Received: by 2002:a05:620a:2b89:b0:77e:fba3:4f11 with SMTP id dz9-20020a05620a2b8900b0077efba34f11mr472885qkb.103.1701737007809;
        Mon, 04 Dec 2023 16:43:27 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.146])
        by smtp.gmail.com with ESMTPSA id br30-20020a05620a461e00b0077d742fb27esm4663490qkb.49.2023.12.04.16.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:43:27 -0800 (PST)
Message-ID: <656e722f.050a0220.c7ae0.2309@mx.google.com>
Date: Mon, 04 Dec 2023 16:43:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2024084228074363705=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/8] shared/lc3: Add QoS definitions
In-Reply-To: <20231204221527.2990674-1-luiz.dentz@gmail.com>
References: <20231204221527.2990674-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2024084228074363705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=806820

---Test result---

Test Summary:
CheckPatch                    FAIL      5.64 seconds
GitLint                       PASS      2.80 seconds
BuildEll                      PASS      24.28 seconds
BluezMake                     PASS      734.05 seconds
MakeCheck                     PASS      11.65 seconds
MakeDistcheck                 PASS      160.10 seconds
CheckValgrind                 PASS      222.68 seconds
CheckSmatch                   PASS      327.47 seconds
bluezmakeextell               PASS      102.44 seconds
IncrementalBuild              PASS      5000.55 seconds
ScanBuild                     WARNING   976.07 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v3,2/8] test-bap: Introduce QoS tests for LC3
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#78: 
  Verify that a Unicast Client IUT can initiate a Config QoS operation for the

/github/workspace/src/src/13479151.patch total: 0 errors, 1 warnings, 992 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13479151.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,3/8] test-bap: Add SCC Config QoS, VS tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
  Verify that a Unicast Client IUT can initiate a Config QoS operation for a

/github/workspace/src/src/13479149.patch total: 0 errors, 1 warnings, 54 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13479149.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,4/8] test-bap: Add SCC Enable tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
  Verify that a Unicast Client IUT can initiate an Enable operation for an ASE

/github/workspace/src/src/13479150.patch total: 0 errors, 1 warnings, 116 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13479150.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,5/8] test-bap: Add SCC Disable tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
  Verify that a Unicast Client IUT can initiate a Disable operation for an ASE

/github/workspace/src/src/13479152.patch total: 0 errors, 1 warnings, 177 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13479152.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,7/8] test-bap: Add SCC Release tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
  Verify that a Unicast Client IUT can release an ASE by initiating a Release

/github/workspace/src/src/13479154.patch total: 0 errors, 1 warnings, 333 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13479154.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v3,8/8] test-bap: Add SCC Update Metadata tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#81: 
  The IUT successfully writes to the ASE Control Point characteristic with the

/github/workspace/src/src/13479155.patch total: 0 errors, 1 warnings, 151 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13479155.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:4696:23: warning: Access to field 'type' results in a dereference of a null pointer (loaded from variable 'lpac')
                if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
                                    ^~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2024084228074363705==--
