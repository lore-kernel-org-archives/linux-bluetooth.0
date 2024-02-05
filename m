Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775F647F67
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157059; cv=none; b=jNZFvYu+AlJllG6kC137ZMGAvfjHtyrbz7KwUE6loL1G5Po316hHihBHvRw/GcB5b2Nhwf7GVMbvGAKjtRopQG4XrKGJlxPAhAadQpeYPt+O4onNRfHBRHjwF62fPYd88c28lZKJ1J3PTwBBoipLe0PIddbY7+uLhfwVPvNVYjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157059; c=relaxed/simple;
	bh=HlF972iKRzl+SJA8aMQwQaE9BCrPU09GsPju5k5BEp8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DjGnYs6n7kflsFKicu+PBB8Gxam8SIDXV7IXh00FQtspfw0qaHdyxIXLyWvyTee63pmMNXOa4t4BzSow6WUJfV+intOeAURlrVUyu8HPJYMvLDdz73vPO1Gg3iE9KqfYcmG7r3o5RTnb/zxkrDVV9EH+ifJyTkm+lcRHs7MrPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7Xl/uKW; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7Xl/uKW"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42c1eb66355so13328111cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Feb 2024 10:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707157056; x=1707761856; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s8ZI+ga8TQsR8dawU7E3C1li6XYONopC4pygcCxW7O8=;
        b=c7Xl/uKWOJuAngfMLXddUIImWkZ0u163gXut0NKmZGDMrBH5KsmafBri44Y7/1aEpP
         3YEBVmVXqlKF/qEsDlpN/8SGwuC717B3/EZtiDeZx9e7fkioDzAszHUgJ0WG9A4esKeH
         dL364Sl9M4P4NCMYCuL9igsiYCKVaDh3KTTZc8WWjsE0v+yOBHqe+L54+igtltUoJa+z
         ExJe0hMXS4SuE9Za77lp3jpmEd/LTkWpAeRdhFG6WRewyjpaqPbIQTlLOryGncSXS2oc
         xxjURGVGZshaZDw5S9HawN8mlOT4HCUGoaNCF/M946aKrzZQw8zqHgwGc8pyO3036NkF
         y8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157056; x=1707761856;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s8ZI+ga8TQsR8dawU7E3C1li6XYONopC4pygcCxW7O8=;
        b=xGUS+W0Hb+hj+4KhcuWyxfXG2GS8fZdMFkpuRZr5iE+0hygNCz9PlzvsEVKuqJ8kav
         63nKpEK6wrdbjCuBG3P1lQxAAVQPdVjOLrD8TbBR0bJBFDgFd5nAbLoJDX4Ue2SY/lgo
         8qQiuKi7+Po+tS3JvKJA8qT6ZnznHkW8EQWv5DyN9xZdY6VwUD4Ffz9yIw0viD8P3rRq
         OOUFfraVKsfDG26Pr50SuSsyZbjwXyNTBXZKj/IC6uYIwaZ8MIiPj4c/4brWumBT/TaB
         V2laqvwcxTWGNxcS/t8Mazto0mM8FCgr6yrqFs4S+++Huc+oXv3vuwQL5wyUyNRxazzV
         Ae5w==
X-Gm-Message-State: AOJu0YxU5RIZgZzK106kouLuPsnAMeGInfNXdza9Ne2Wd45gwLPTY1c1
	jvBcZF+LIKLaTW2jbFMy3bH5OwHAw+Y330lmgyHrztiEESpTsE4g/XdWn4VK
X-Google-Smtp-Source: AGHT+IH1dX0yqf+C8SmumhjAQMLPBLKThJ9T3aWYp0cOHF42a4Z3pqWQgZh4qQrl1fVOF5PnwNy4xg==
X-Received: by 2002:ac8:4d99:0:b0:42b:fd4a:e13d with SMTP id a25-20020ac84d99000000b0042bfd4ae13dmr136185qtw.55.1707157056219;
        Mon, 05 Feb 2024 10:17:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXzcOrH0QMjU2MTY6HSv+uUp9gwQvwqkT7uAmQlmBu2lhmGi9HQMg6bTYzkiY/B6jcUSVTesi6Q2U8R
Received: from [172.17.0.2] ([20.57.14.19])
        by smtp.gmail.com with ESMTPSA id q17-20020ac87351000000b00427e0e9c22dsm171156qtp.54.2024.02.05.10.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:17:35 -0800 (PST)
Message-ID: <65c1263f.c80a0220.db317.1b95@mx.google.com>
Date: Mon, 05 Feb 2024 10:17:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5329746447943213459=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] monitor: parse Google's Opus A2DP vendor codec capabilities
In-Reply-To: <5ae678a1c4353818744a6bff31b21055371d2592.1707152569.git.pav@iki.fi>
References: <5ae678a1c4353818744a6bff31b21055371d2592.1707152569.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5329746447943213459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823244

---Test result---

Test Summary:
CheckPatch                    FAIL      1.18 seconds
GitLint                       FAIL      0.81 seconds
BuildEll                      PASS      23.99 seconds
BluezMake                     PASS      729.02 seconds
MakeCheck                     PASS      12.14 seconds
MakeDistcheck                 PASS      162.98 seconds
CheckValgrind                 PASS      225.59 seconds
CheckSmatch                   PASS      327.30 seconds
bluezmakeextell               PASS      107.84 seconds
IncrementalBuild              PASS      1360.33 seconds
ScanBuild                     PASS      927.70 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/2] monitor: parse Google's Opus A2DP vendor codec capabilities
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#94: 
      AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 3 nosp 0

/github/workspace/src/src/13545880.patch total: 0 errors, 1 warnings, 78 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13545880.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v2,2/2] client/player: parse Google's Opus A2DP vendor codec capabilities
WARNING:NEW_TYPEDEFS: do not add new typedefs
#197: FILE: profiles/audio/a2dp-codecs.h:436:
+typedef struct {

WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#200: FILE: profiles/audio/a2dp-codecs.h:439:
+} __attribute__ ((packed)) a2dp_opus_g_t;

/github/workspace/src/src/13545881.patch total: 0 errors, 2 warnings, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13545881.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/2] monitor: parse Google's Opus A2DP vendor codec capabilities

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
8: B1 Line exceeds max length (88>80): "      AVDTP: Get All Capabilities (0x0c) Response Accept (0x02) type 0x00 label 3 nosp 0"


---
Regards,
Linux Bluetooth


--===============5329746447943213459==--
