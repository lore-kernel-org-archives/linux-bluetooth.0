Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46454C9D
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Oct 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174159; cv=none; b=avXUOP++U3rCymvX7JrGXE45MSc3sbZ8hdQmWCjFJxz+BTH5PKZ4BHta/GPgi7/ALUqHOShcNlD5+dXj2ZcAK0meIpeSf38Qo9fQpX1CpirseHWeI7W5WjyR/cosTWmYLlwjL/pC0s+AKxzRWlH9Zu/Kk3qoenFyWOuShQ90MY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174159; c=relaxed/simple;
	bh=mwws8x/esxMoKwe3xnXwM32NV8X6mHPuGnYPXOyFO4w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jZgTPbZUF9tNsu6imZhvglfUGcqlcdKskGcSf8rHotMnZtpY6FKB0tEMWDkBpib7cpJB5kOyYMd6ADiPZmHum+8IIWT+4c5fZ3fDOGxFrZ5HnSc/uyF8g/b0k4MmAe3/JvyWjeS8c3cWiMAPnI0Fdb1SLh6g6IGvLz21yJ4lav4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGzXXXzx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGzXXXzx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb3d2ce75eso38231746d6.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Oct 2024 17:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728174156; x=1728778956; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F+Y4x4xVc/KCoaSDT+0YMONM+DqNzviq9V8y2qu+aLM=;
        b=RGzXXXzxkJ9zOU6Tvs4hq2B4KGbyotkyZIlR31dvWjvbsdpvDelFm+BsQ0lucARP1W
         GgvwvLGxTbzl8/kxCC5iFSqd/FeHNDyyFnihVEtAhyBnt/Vt/5hv+xpU1tdH/Txsadco
         O3hfKJmriX3pViURAFWxNKh6Ne0eXH9obAHbPQ/w5hCatS43BZym0Xe6zip0vTzhN1Kt
         aDHOm/SMe30p0Mz6F6ZMjMs6rAWougwWR5YXoUGGqlsc4u8qNBiggcc/ViIYePTz/rgc
         A/JeetxMz2hQcj2Xd0J6VxDI1VD27e36OtjNcJxTt0r9CZ/rn4NqGHvQtHzv/Ax8Bvei
         fP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728174156; x=1728778956;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+Y4x4xVc/KCoaSDT+0YMONM+DqNzviq9V8y2qu+aLM=;
        b=KNsyUoTyIla9uw0OTLP0vhQTQc4Dr18iXZ8wEd1pkJPLN4w9oBw3At2J8Dzw4OcFXS
         8BkYGWcpRHrYC2FEXseRm0RIb4+hT7HWCvYXCLsFInWluSHkQQ7Jbi+0hSytXI+yPIre
         n6dsHOPdPWt2LiSlWSYXiLCPVR3LgWzfYjes3UL3jVCFU+OjsjHSs0fcA724BtsMT2nw
         RX+ynsLrGU4NZyRjGKmk4LPYK2EZ2rvbVUpvusUlMtg3u3b0Ksy21oOmpisC9S8V7XYY
         Yi2PfOqQ0T3YlGGZDFOuf/EGHWqjbcvTYPN5Kji9ActERIA6QUP/C6g5mM9FPGHGyKOe
         4exw==
X-Gm-Message-State: AOJu0YwhMUZJoNaVVnWjxjcbQeDFI/i6ZxhzeeKi50Z3Ji+fRLpFTdDV
	xkRp4RaNymVjrZFYDai8PLbAf3Z/EzX5Jeq9U2CjP9nYtMY/vXJOd7vGBg==
X-Google-Smtp-Source: AGHT+IEH0GKx6ELfAryRbiLHuOO9Q2YJdIdDeXvqan5+aR39yB99BF5HEG7JAoO1sNDMsbAjj2veEQ==
X-Received: by 2002:a05:6214:3214:b0:6cb:49d2:c700 with SMTP id 6a1803df08f44-6cb9ae038b7mr123987996d6.22.1728174156297;
        Sat, 05 Oct 2024 17:22:36 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.13.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba4754b04sm12499576d6.78.2024.10.05.17.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 17:22:35 -0700 (PDT)
Message-ID: <6701d84b.d40a0220.36b199.3b5e@mx.google.com>
Date: Sat, 05 Oct 2024 17:22:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1152651121883668036=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, marijn.suijten@somainline.org
Subject: RE: audio/avrcp: Determine Absolute Volume support from feature category 2
In-Reply-To: <20241005214321.84250-2-marijn.suijten@somainline.org>
References: <20241005214321.84250-2-marijn.suijten@somainline.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1152651121883668036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=895898

---Test result---

Test Summary:
CheckPatch                    FAIL      1.71 seconds
GitLint                       FAIL      1.26 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      1510.99 seconds
MakeCheck                     PASS      13.50 seconds
MakeDistcheck                 PASS      175.94 seconds
CheckValgrind                 PASS      248.37 seconds
CheckSmatch                   PASS      348.81 seconds
bluezmakeextell               PASS      117.34 seconds
IncrementalBuild              PASS      4140.99 seconds
ScanBuild                     WARNING   1013.06 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v4,1/3] audio/avrcp: Guard SetAbsoluteVolume without target behind config value
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '179ccb936', maybe rebased or not pulled?
#60: 
Commit 179ccb936 ("avrcp: Set volume if volume changed event is

WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#75: 
[1]: https://lore.kernel.org/linux-bluetooth/20211025210206.bkt5wovzmkmt6teg@SoMainline.org/

WARNING:LONG_LINE_COMMENT: line length of 88 exceeds 80 columns
#103: FILE: profiles/audio/avrcp.c:4675:
+		/* If there is no target profile (we didn't create a controller for it),

WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
#104: FILE: profiles/audio/avrcp.c:4676:
+		 * allow the call to pass through if the remote controller registered

WARNING:LONG_LINE: line length of 82 exceeds 80 columns
#111: FILE: profiles/audio/avrcp.c:4683:
+		if (!session->controller || session->controller->version < 0x0104)

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#148: FILE: src/main.c:168:
+static const char *avrcp_options[] = {

/github/workspace/src/src/13823595.patch total: 0 errors, 6 warnings, 103 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13823595.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,2/3] audio/avrcp: Only allow absolute volume call/event on category-2 peers
WARNING:LONG_LINE_COMMENT: line length of 85 exceeds 80 columns
#83: FILE: profiles/audio/avrcp.c:1779:
+	 * The controller on the remote end is only allowed to call SetAbsoluteVolume

WARNING:LONG_LINE: line length of 118 exceeds 80 columns
#87: FILE: profiles/audio/avrcp.c:1783:
+			(btd_opts.avrcp.volume_category && !(session->target->features & AVRCP_FEATURE_CATEGORY_2))) {

WARNING:LONG_LINE_STRING: line length of 84 exceeds 80 columns
#88: FILE: profiles/audio/avrcp.c:1784:
+		error("Remote SetAbsoluteVolume rejected from non-category-2 peer");

WARNING:LONG_LINE_COMMENT: line length of 88 exceeds 80 columns
#100: FILE: profiles/audio/avrcp.c:3781:
+	 * The target on the remote end is only allowed to reply to EVENT_VOLUME_CHANGED

WARNING:LONG_LINE_COMMENT: line length of 82 exceeds 80 columns
#101: FILE: profiles/audio/avrcp.c:3782:
+	 * on our controller if it's at least version 1.4 and a category-2 device.

WARNING:LONG_LINE: line length of 122 exceeds 80 columns
#104: FILE: profiles/audio/avrcp.c:3785:
+			(btd_opts.avrcp.volume_category && !(session->controller->features & AVRCP_FEATURE_CATEGORY_2))) {

WARNING:LONG_LINE_STRING: line length of 87 exceeds 80 columns
#105: FILE: profiles/audio/avrcp.c:3786:
+		error("Remote EVENT_VOLUME_CHANGED rejected from non-category-2 peer");

WARNING:LONG_LINE: line length of 91 exceeds 80 columns
#125: FILE: profiles/audio/avrcp.c:4268:
+	if (!btd_opts.avrcp.volume_category || target->features & AVRCP_FEATURE_CATEGORY_2)

WARNING:LONG_LINE: line length of 126 exceeds 80 columns
#143: FILE: profiles/audio/avrcp.c:4692:
+				(btd_opts.avrcp.volume_category && !(session->target->features & AVRCP_FEATURE_CATEGORY_2))) {

WARNING:LONG_LINE_STRING: line length of 88 exceeds 80 columns
#144: FILE: profiles/audio/avrcp.c:4693:
+			error("Can't send EVENT_VOLUME_CHANGED to non-category-2 peer");

WARNING:LONG_LINE: line length of 84 exceeds 80 columns
#155: FILE: profiles/audio/avrcp.c:4709:
+		if (!session->controller || session->controller->version < 0x0104 ||

WARNING:LONG_LINE: line length of 130 exceeds 80 columns
#156: FILE: profiles/audio/avrcp.c:4710:
+				(btd_opts.avrcp.volume_category && !(session->controller->features & AVRCP_FEATURE_CATEGORY_2))) {

WARNING:LONG_LINE_STRING: line length of 85 exceeds 80 columns
#157: FILE: profiles/audio/avrcp.c:4711:
+			error("Can't send SetAbsoluteVolume to non-category-2 peer");

/github/workspace/src/src/13823593.patch total: 0 errors, 13 warnings, 120 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13823593.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,v4,3/3] audio/avrcp: Determine Absolute Volume support from feature category 2
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#85: 
[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761

WARNING:PREFER_LORE_ARCHIVE: Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html
#86: 
[2]: https://marc.info/?l=linux-bluetooth&m=163463497503113&w=2

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#105: FILE: profiles/audio/avrcp.c:1783:
+			(btd_opts.avrcp.volume_version && session->target->version < 0x0104) ||

WARNING:LONG_LINE_STRING: line length of 101 exceeds 80 columns
#108: FILE: profiles/audio/avrcp.c:1785:
+		error("Remote SetAbsoluteVolume rejected from non-category-2 or non-AVRCP-1.4 peer");

WARNING:LONG_LINE: line length of 105 exceeds 80 columns
#122: FILE: profiles/audio/avrcp.c:4268:
+			(!btd_opts.avrcp.volume_category || target->features & AVRCP_FEATURE_CATEGORY_2))

WARNING:LONG_LINE: line length of 103 exceeds 80 columns
#138: FILE: profiles/audio/avrcp.c:4695:
+				(btd_opts.avrcp.volume_version && session->target->version < 0x0104) ||

WARNING:LONG_LINE_STRING: line length of 105 exceeds 80 columns
#141: FILE: profiles/audio/avrcp.c:4697:
+			error("Can't send EVENT_VOLUME_CHANGED to non-category-2 or non-AVRCP-1.4 peer");

/github/workspace/src/src/13823594.patch total: 0 errors, 7 warnings, 88 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13823594.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,1/3] audio/avrcp: Guard SetAbsoluteVolume without target behind config value

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[BlueZ,v4,1/3] audio/avrcp: Guard SetAbsoluteVolume without target behind config value"
18: B1 Line exceeds max length (92>80): "[1]: https://lore.kernel.org/linux-bluetooth/20211025210206.bkt5wovzmkmt6teg@SoMainline.org/"
[BlueZ,v4,2/3] audio/avrcp: Only allow absolute volume call/event on category-2 peers

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v4,2/3] audio/avrcp: Only allow absolute volume call/event on category-2 peers"
[BlueZ,v4,3/3] audio/avrcp: Determine Absolute Volume support from feature category 2

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "[BlueZ,v4,3/3] audio/avrcp: Determine Absolute Volume support from feature category 2"
28: B1 Line exceeds max length (103>80): "[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761"
30: B1 Line exceeds max length (103>80): "[3]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#755"
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/avrcp.c:1954:2: warning: Value stored to 'operands' is never read
        operands += sizeof(*pdu);
        ^           ~~~~~~~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============1152651121883668036==--
