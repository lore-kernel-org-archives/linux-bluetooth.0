Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20D2E65B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901977; cv=none; b=ZLin94OgAzKT4ZMGAcNtEIxY8z+4ULqG2Wi5qbrlWZbFfQCaPFVB3MOetT+YI2hp/HPY8U1ix2KUddgpXSAs8l8/5w91viLEDYHjfc1DvBxNeLSpByUrYIusLlXgDqMfJM2S3ul8pqYL9eXVDkOuNbtdVs0Vv/+fPihllT5I8lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901977; c=relaxed/simple;
	bh=M3BW9/8cgGA/t1tEEpBAUyVm2UtMMdB8BPheO+Au8ik=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K0VULt04ITxJjMyJeqvw5MBSomjn2vpAV4I+akA0xDODWwkhTD8t4tzMHe3qk+Zse6y19253x7enXAdodNjE1/CQNlw13wvw4kFYNwjziFk1YuoTfyaasf+6FCGAijZ9Cn32CkQj0X/b18HyTdf5TV+6eE7u6LVxdVBB/NvJUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klu7S78q; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klu7S78q"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso711067b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 16:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715901975; x=1716506775; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cPsAE7Z0w6ay7IC6zGbm1SdaBMOX+IS9kEk6eeUXKiM=;
        b=klu7S78qfIxhCynztCe9kDPMHUbXxNqBzWegJAOrznEOeAbIdQJV4mEIUFXqsDHWa0
         w4EE3xfuWi3uAyCrGRrubk0II0zo5lgllg3YvRAsyMZ3D8dBXCpWPYtS4HdxtT94vLb+
         +n7eUjLMiyvnyTI0zw72Xf7ewsWYcdEcVs0d0GVtP1wjse3TGOAicmucdFYhR+3ezbiP
         H9tMW3MfIeOFpKR+8m61H7EbRxRWxvR9Ldi//3d8r5cF6T776e79AhmX/vEvQ7TnIRJh
         WmF+EGaw8z26J4J49hBsH0BfotXfx4w2EwMicjZZpJDc3IN4QargejmDFFNMXy6000EF
         Wn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715901975; x=1716506775;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPsAE7Z0w6ay7IC6zGbm1SdaBMOX+IS9kEk6eeUXKiM=;
        b=wmGSwRzc7m/lb8Byycl9IwqDcSDXPTVPZMNDyWMSagJope2S89K2dsDeDs9gWPwumF
         /7xaEIhWvkkmYWsvgcR5sCMyp69hoPFBqDVpESm+2/7cOHBUv4GJXseubav1y1/URFVo
         gf6Y33FDouO2pUZ6ZK0rpH/SoVTJe3LqZaChpVxehmKRtWkygdKjJB+U2Gz5reu6Vro6
         lEPnyR65vaCLyiMKPRFncNcDIalMQZB12g5qFYD0F++BoIc8u+s07/O0TQLu1jgKmfuQ
         oYgYj6FBsztpXp8wFZpSRLMoApwfE4sOxzxtDVvWtHnydx478eJMXuttuK81/W4HEoju
         JD9w==
X-Gm-Message-State: AOJu0YzETtsr9sUrKGKOW5bIDw32/kTWSGajIrE1ryuR8FuConAXwNMX
	GMwDjTai+HBXASUL+uNstyhcxguUUBO5j4t6+qco/QBDPSrdZinxqCJ/WA==
X-Google-Smtp-Source: AGHT+IEG/xcU6A/uQnFSR/jy6Gpa6CO02thhA4gSQ4u9FnCxtujn4VmDI6Nm0LbrRiOw1RryTOhnow==
X-Received: by 2002:a05:6a00:1409:b0:6f3:e9bd:62cb with SMTP id d2e1a72fcca58-6f4e02f5ef5mr25472293b3a.23.1715901975069;
        Thu, 16 May 2024 16:26:15 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.46.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a86a4fsm13659630b3a.63.2024.05.16.16.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 16:26:14 -0700 (PDT)
Message-ID: <66469616.050a0220.fdb50.3eba@mx.google.com>
Date: Thu, 16 May 2024 16:26:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3800966842282554708=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arun@asymptotic.io
Subject: RE: ASHA plugin
In-Reply-To: <20240516193836.228281-2-arun@asymptotic.io>
References: <20240516193836.228281-2-arun@asymptotic.io>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3800966842282554708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=853816

---Test result---

Test Summary:
CheckPatch                    FAIL      2.51 seconds
GitLint                       PASS      1.20 seconds
BuildEll                      PASS      24.67 seconds
BluezMake                     PASS      1701.60 seconds
MakeCheck                     PASS      13.66 seconds
MakeDistcheck                 PASS      180.90 seconds
CheckValgrind                 PASS      252.23 seconds
CheckSmatch                   PASS      358.06 seconds
bluezmakeextell               PASS      122.36 seconds
IncrementalBuild              PASS      7788.71 seconds
ScanBuild                     WARNING   1025.11 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v6,1/5] src/shared: Add initial implementation for an ASHA profile
WARNING:BLOCK_COMMENT_STYLE: Block comments use a trailing */ on a separate line
#210: FILE: src/shared/asha.c:51:
+						 * work */

/github/workspace/src/src/13666505.patch total: 0 errors, 1 warnings, 632 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13666505.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v6,3/5] test: Add a script to test ASHA
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#104: FILE: test/simple-asha

/github/workspace/src/src/13666507.patch total: 1 errors, 0 warnings, 162 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13666507.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/media.c:1048:7: warning: Use of memory after it is freed
                if (req->cb != pac_select_cb) {
                    ^~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============3800966842282554708==--
