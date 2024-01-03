Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCA51EB57
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn8rYAa+"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dc53fc4b0dso2004336a34.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jan 2024 14:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704320903; x=1704925703; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UwEujkwchvSYl8o/O9nWoZMZOW0cVl1cIifuNDBXf4k=;
        b=hn8rYAa+UQr4GDVtP5HwOb5jVkzRv7iVnsEgYJhlNWb/NFgjg9ymNUXfTBO+oXwbm2
         Iuxaf5MNu+B3hdLvG8Kc4Mk/ZyWJEpOMM6FhWbU4ioSRuTswyKC+ifg6s6XmqmR5XFLS
         s0p9YTskMdm0tW/IrtAKU/l++ItMXnQ9NpN+yjYzIJIOQEVAJoZjAvUxGnd0zBQEPd91
         IdHxOEZSDeDkR3g/Z/YEPuIFsM0X1+O6HwP7vfK8DIjMI/SdygPhiIgi+q6qdRJ7smI4
         9jFN2nrnCTJ+yV5750/BVh+GlhfDkVDPGlX4xdSOXbiA79Ac1UAoVpBDcf8idNt81/Ey
         Y6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320903; x=1704925703;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwEujkwchvSYl8o/O9nWoZMZOW0cVl1cIifuNDBXf4k=;
        b=VFikBSp6oVir7SFzmQVD4m9ubj2BbpmqW7kDKGZQe2xio2DfBF/2Hi747DOL5zxuX6
         TnHMvPgm2nUO9XPFO4+d05MFeMnaHKxTYwLAu9M9g+uyXSD15yPRD4vjsMe7t8GKhBeL
         TaqfdoXC5vrL2+wennzwrG/iak5YgbVD9Q2X4WmWYUNj7eN5v4dnnsnu5M/2Ry+xBu0d
         WWYNB1qFxG2fFo3duCvTtDf2s+2QtbRAhnytulLh4Qo+9g2BBSMi4zRZ5w8jKBCrZ4f9
         7zWw5kdq3tpJbIPdFUNnIYx1KjUKPAdsDK0s7vUwQWz7+RR+2OGuYu0swerhfxtcraRm
         7LRw==
X-Gm-Message-State: AOJu0YzAuoeafwxU/3wgNpYTnCBw9qrheBPH5LNu3FWWddgJwKwxp49q
	1LrLqFSCJnaAh7veuczng1TUTJAPZzk=
X-Google-Smtp-Source: AGHT+IEM1XN/4bIsCjUeVzUlAXr9H7GcO+vvbn6BCkuGytdscqOJKs6LM64+QbW/Ow8dmBA7MIsQGA==
X-Received: by 2002:a05:6830:7009:b0:6dc:8d6:ab27 with SMTP id ei9-20020a056830700900b006dc08d6ab27mr12229405otb.61.1704320903644;
        Wed, 03 Jan 2024 14:28:23 -0800 (PST)
Received: from [172.17.0.2] ([20.49.63.241])
        by smtp.gmail.com with ESMTPSA id kk9-20020a05622a2c0900b0042839736d9fsm927589qtb.19.2024.01.03.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:28:23 -0800 (PST)
Message-ID: <6595df87.050a0220.4b183.32e6@mx.google.com>
Date: Wed, 03 Jan 2024 14:28:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5375846284076918848=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/3] audio: transport: Fix crash on A2DP suspend
In-Reply-To: <20240103205124.3839768-1-luiz.dentz@gmail.com>
References: <20240103205124.3839768-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5375846284076918848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=814200

---Test result---

Test Summary:
CheckPatch                    FAIL      1.95 seconds
GitLint                       PASS      0.99 seconds
BuildEll                      PASS      24.60 seconds
BluezMake                     PASS      718.81 seconds
MakeCheck                     PASS      11.85 seconds
MakeDistcheck                 PASS      164.64 seconds
CheckValgrind                 PASS      226.32 seconds
CheckSmatch                   PASS      332.96 seconds
bluezmakeextell               PASS      109.00 seconds
IncrementalBuild              PASS      2001.15 seconds
ScanBuild                     PASS      939.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/3] audio: transport: Fix crash on A2DP suspend
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '052534ae07b8', maybe rebased or not pulled?
#76: 
Commit 052534ae07b8 ("transport: Update transport release flow for

/github/workspace/src/src/13510505.patch total: 0 errors, 1 warnings, 40 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13510505.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,2/3] audio/transport: Refactor transport operations
WARNING:LINE_SPACING: Missing a blank line after declarations
#253: FILE: profiles/audio/transport.c:482:
+	struct a2dp_transport *a2dp = transport->data;
+	return a2dp->volume;

/github/workspace/src/src/13510507.patch total: 0 errors, 1 warnings, 726 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13510507.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5375846284076918848==--
