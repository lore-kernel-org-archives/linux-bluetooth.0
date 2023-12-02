Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JESykSlY"
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12032D54
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Dec 2023 17:11:05 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35cd1133866so9487235ab.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Dec 2023 17:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701479464; x=1702084264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H9Dw5NusiGrgGojhKc9b8UUCScLlKIat7h9OMX35AGw=;
        b=JESykSlYyNTMGLa94U2ZcSkTxxnBY5eXT7FJd/oXF5ItXmoLjP3mxw62aBzGFah5s2
         LA/CSlTwV0HuZsav1LLYRwrUsSEp887+bWTZsEzGXdo2s0lQfFj95ewgkuMF2y2ITZb5
         RtC4r+26KV6dVYGyHln+FRrpXnivRLqmTD99fEy7/nx8G5wI0xBAea8aR3VOU6IIT2t5
         sobITqOokNbzpjqpw5OzBc4fvioyDDR8KBpK9hu8ZEtJOXRQFQIwdbI6aBia7K0Z0bVc
         EKDITBBGetyvNfAzKyDzl5xDg2XBRN5bak+lIZgwSLpNAF1RiJFDRuwkqQIRj1kn51Dv
         RFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701479464; x=1702084264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H9Dw5NusiGrgGojhKc9b8UUCScLlKIat7h9OMX35AGw=;
        b=RRc8GlWrNZ+F53w1JzSCB2HmqHbNdlx1Ek503oco9PhLcKedI/M3cqCWYTVSPixFIl
         eGJLIaXOIsynLhfggRDTyHLNssaS+Izaz7Ve4NKL/NknpHwHB7WE5GB8rM/pqIhGN6LM
         HO3gYhZD8t3tdc5CeCp68Ko3OSwdEv6HhnhkQF6RdNuXO7LZs40ha2Wsboa9uaDpAwkq
         ndSf7Yx9hFfTpwW+7rwgtWc+3vtKY1NVYwslHcRnNSsD0e7+AkaTCri93wt8elOLaTyM
         NSdfjqqWcZm2UWx/lxtv++BWV6wvngj9lOUNQazQOeDjbaw0wM0IEw1HhgBBNIiyHi2W
         rruw==
X-Gm-Message-State: AOJu0YzJke2iRO2BmCiMjUxvnvCXJT2hNiyK9UOzyjcz31KU3Ri+8VXb
	VfOASWiPfnGHFStpvbAtvzPEcW0ScMo=
X-Google-Smtp-Source: AGHT+IH+K7RL3boFWXq2nEV2UfAiQnI2Es7v/7hyCS9Y5Hl3Azdk9JXCeL21VZqmDJJkaezlnxvZjQ==
X-Received: by 2002:a92:c112:0:b0:35d:5d5a:c438 with SMTP id p18-20020a92c112000000b0035d5d5ac438mr210955ile.8.1701479464100;
        Fri, 01 Dec 2023 17:11:04 -0800 (PST)
Received: from [172.17.0.2] ([13.88.99.131])
        by smtp.gmail.com with ESMTPSA id y9-20020a170902b48900b001c61df93afdsm3957329plr.59.2023.12.01.17.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 17:11:03 -0800 (PST)
Message-ID: <656a8427.170a0220.b0df0.d4bf@mx.google.com>
Date: Fri, 01 Dec 2023 17:11:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7813327711870414792=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/7] shared/lc3: Add QoS definitions
In-Reply-To: <20231201223900.2498565-1-luiz.dentz@gmail.com>
References: <20231201223900.2498565-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7813327711870414792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=806140

---Test result---

Test Summary:
CheckPatch                    FAIL      2.94 seconds
GitLint                       PASS      1.30 seconds
BuildEll                      PASS      24.01 seconds
BluezMake                     PASS      750.28 seconds
MakeCheck                     PASS      12.13 seconds
MakeDistcheck                 PASS      154.37 seconds
CheckValgrind                 PASS      216.03 seconds
CheckSmatch                   PASS      321.31 seconds
bluezmakeextell               PASS      100.98 seconds
IncrementalBuild              PASS      4528.24 seconds
ScanBuild                     WARNING   905.90 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,2/7] test-bap: Introduce QoS tests for LC3
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#78: 
  Verify that a Unicast Client IUT can initiate a Config QoS operation for the

/github/workspace/src/src/13476545.patch total: 0 errors, 1 warnings, 992 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13476545.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,3/7] test-bap: Add SCC Config QoS, VS tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
  Verify that a Unicast Client IUT can initiate a Config QoS operation for a

/github/workspace/src/src/13476543.patch total: 0 errors, 1 warnings, 54 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13476543.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,4/7] test-bap: Add SCC Enable tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
  Verify that a Unicast Client IUT can initiate an Enable operation for an ASE

/github/workspace/src/src/13476544.patch total: 0 errors, 1 warnings, 116 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13476544.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,5/7] test-bap: Add SCC Disable tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
  Verify that a Unicast Client IUT can initiate a Disable operation for an ASE

/github/workspace/src/src/13476546.patch total: 0 errors, 1 warnings, 177 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13476546.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,7/7] test-bap: Add SCC Release tests
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#77: 
  Verify that a Unicast Client IUT can release an ASE by initiating a Release

/github/workspace/src/src/13476548.patch total: 0 errors, 1 warnings, 333 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13476548.patch has style problems, please review.

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


--===============7813327711870414792==--
