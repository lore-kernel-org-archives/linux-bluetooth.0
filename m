Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S92I3gHs"
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE20D4B
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 08:43:15 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cf5901b4c8so48770505ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 08:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701189795; x=1701794595; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi4/L3hhYzy45Ithp4XD+k2IIjmo2OZm/ilzTTcNPsc=;
        b=S92I3gHsK4fJco94q0X8gFAJAzXzZBGpYkYiVYGxqsIpEMzrmBJMNrp/VCLCVOhUrV
         4dJiulH2ar8vfqXDxZ7wLchcZDKMrfrtll8jUg8eoTVRWiZdIT+Urc2BMqgyArJLPYp5
         esciPQziEj/Xnvgj/eTPUkO2NP51/w6SIaxyV3GbkSeX/7WAmV1C/+GJG1h5ES/9QS5M
         ENVPiiVCY3ZelP0aMKmdwmlt6uwiIJ+IxSRVa1QeDPRKVCvQ6ez5Ev3D1WJMrCNAL61r
         Hj7O1V3/BNKGC1slNLrubmMPzqn8WLbRPDBvt/BUXzRSQCo2o33kng9VMZ1jAODLbtwb
         W3nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701189795; x=1701794595;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mi4/L3hhYzy45Ithp4XD+k2IIjmo2OZm/ilzTTcNPsc=;
        b=GUx8AOEQiX37YA/bQeZDoJ85BCW/1RWAelYjfdFT3FbCDd1yvjLndAmpAiF7HA9I4P
         YaAVLwgn1vqfI1Emlu5MUWKGssiXv752e7htTmTx6+0BP48DK/3P83UonQ/Vm0tj1IBP
         /svT4EAeXEFVvXyPqhFfhKxzVJu7wkmtgRL4XBN0SBBnL9hyjfTzJieAd7wjsUTzUHr/
         O3JPH3587sPuHCWwpA/RHKCo7dGqHt2kehYT9pNA4GLVeo9K8WOZLf6KY8K4iSrf4QjC
         LVOx9fJPy7+4Wk+AkGqrcqkgE0d3XtxrYcib8kLCgEAM5NK/pNlIVDEYwUvW7NEk82ka
         uU3g==
X-Gm-Message-State: AOJu0YwxJsM7m1LYBWMvs4VurGpFk72kmDiv97D4CyZxIS6JAIzrF4xD
	GyRBNWHHWChUmkg+94hgPVpWPuNA85U=
X-Google-Smtp-Source: AGHT+IHQc/wQoBmoF5FBnEFiAmNjyzAWAqRwTGtLzd8m/L1/uO9cvjuEHbedRWRBb9v1TvbfG+jizg==
X-Received: by 2002:a17:903:22c1:b0:1cf:9902:66c5 with SMTP id y1-20020a17090322c100b001cf990266c5mr19842336plg.36.1701189794772;
        Tue, 28 Nov 2023 08:43:14 -0800 (PST)
Received: from [172.17.0.2] ([13.91.68.210])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902700500b001cfd35ec1d7sm3752768plk.243.2023.11.28.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:43:14 -0800 (PST)
Message-ID: <656618a2.170a0220.21edc.a7a7@mx.google.com>
Date: Tue, 28 Nov 2023 08:43:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3022462599315378653=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] iso-tester: Add tests for GMAP broadcast QoS presets
In-Reply-To: <20231128152832.1730901-1-luiz.dentz@gmail.com>
References: <20231128152832.1730901-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3022462599315378653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=804915

---Test result---

Test Summary:
CheckPatch                    FAIL      1.21 seconds
GitLint                       FAIL      0.84 seconds
BuildEll                      PASS      24.36 seconds
BluezMake                     PASS      583.93 seconds
MakeCheck                     PASS      11.02 seconds
MakeDistcheck                 PASS      150.40 seconds
CheckValgrind                 PASS      211.14 seconds
CheckSmatch                   WARNING   324.86 seconds
bluezmakeextell               PASS      98.70 seconds
IncrementalBuild              PASS      1588.70 seconds
ScanBuild                     PASS      952.09 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,3/3] monitor: Add proper decoding of TLV for BASE
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#100: 
              Codec Specific Configuration: Location: Front Left (0x00000001)

/github/workspace/src/src/13471360.patch total: 0 errors, 1 warnings, 116 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13471360.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,3/3] monitor: Add proper decoding of TLV for BASE

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
26: B3 Line contains hard tab characters (\t): "            Metadata: Context	Conversational (0x0002)"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1860:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============3022462599315378653==--
