Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B064A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 00:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024551; cv=none; b=Ywl6gcKo1wXydE0TOjnjzEdor9EzFzk90xvtL0j3cyti+PdzoWt9T9+decEv50QJ4UFKVRgcm0lmej8pxJ7xBG2ifOVWhxr2hW8WPh8K6X4R8henTOGP5kWQ9k2tQxFi0oMpxbHAdbQYHdaieG1ScwvEgb9uyd5pU5D/tzuEpcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024551; c=relaxed/simple;
	bh=SIGGu7mIblRmp9C0R7PjIpixCMFg0fAidIgtcQxiq80=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hig7r5bWbiu4qPsJo5bX+4TVQ7yAjQm2kMjYQqXmveVGj6vYnOrOrCvAHxx4REvTKGkXLDP/OPg668+8ZCpfjg9B5VjJvM9zg8iZfpfVSsD/HA9VM7lVfdd3FF10zt7e1IjsSdOwOMwnIhe1CePtcmgOD40Xw5oeqglveT/4uQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYQb5nQz; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYQb5nQz"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe53a68b5so9820086d6.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2024 16:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731024548; x=1731629348; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ywv9KEiGxQzCKJfxwF/PZ1QI1apyJhxdT/5LjKpaZ8M=;
        b=cYQb5nQzmDGIrMAQEnmj5OSOxEg4wIxOnf7hcBEw/O0DiwZFEnT6DfGsPBPbQu1hKy
         JU9L2aoDcZXyyRXjqV1Kby3EIm9/L/ftdQWmUMQt4djF56rTwmWfymgks9u1xiSm5XaA
         QcbE1/3woEPdgOvnVViNZDxTz/s8jb/r93gnWPaigAL/n0k+I312v1AezFvaJyFCdrTw
         p2PRqliKWzGshddKsif45APeUCNeyuFQgak6ysfgN3wdCCkoDVBi6xm4d8IsQt37jB/x
         nwL4spkIXyQi+kUW1ldOWRarQ9ljm/D4MLmLrwqwxd4l9FtpJN4a/8gA7S1gGg5Dp64H
         Ni+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731024548; x=1731629348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywv9KEiGxQzCKJfxwF/PZ1QI1apyJhxdT/5LjKpaZ8M=;
        b=Z/w03S7/tC95EJ0+j4AWTOHAsAYUklWx+91kiVzCCv6lujaMQ9fBixy+xLKHnLlmrQ
         3RRrpcTHzD7c7GF+D6nnDfYm46yuPaEZA1OyBMVJKdvqjxomF4pvkAzHxaqKUuAb11bP
         37DeqKFrZDptgEPYcTLyMH7Ss6sfWDXALXeJYSxhoyuorRrysi6P1zKkM/Qd/iV0DLCy
         +r44M8fDvtw5Nn4JjChzWJ/QUGqIPU0TaVVgGm5txocHPwKr5KxydIs4hbYNV034jW6f
         dTWNozc34iNl+2p6l9qeZYkbvlqbY08gp1Y+lRqZwZ9xu4d5kepv9/RY7WFmms0Owz2Y
         UZlg==
X-Gm-Message-State: AOJu0YzLnjKAaSMgkthkV+cmWMxtB1nP6bCeTaKynEVFgfW1Mj/w3PUD
	g0b38WRX3OQ9ZmWwDaYN3AW/7lY2GbnONDNOloniPVGuvsqoeh0yUf98qQ==
X-Google-Smtp-Source: AGHT+IHWXj6ukAisPI6SEO0EmZzyqpxmk/rKQIozXIaFw8UTM4duof0Q0tufaWNYwV6/RSYSYzmLww==
X-Received: by 2002:a05:6214:3217:b0:6cb:edd7:ac32 with SMTP id 6a1803df08f44-6d39e11eb49mr13522286d6.12.1731024548508;
        Thu, 07 Nov 2024 16:09:08 -0800 (PST)
Received: from [172.17.0.2] ([172.183.122.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ed253sm12837556d6.37.2024.11.07.16.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 16:09:08 -0800 (PST)
Message-ID: <672d56a4.d40a0220.386e38.514f@mx.google.com>
Date: Thu, 07 Nov 2024 16:09:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2535069450455730901=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, VAnPushkarev@salutedevices.com
Subject: RE: Introduce option to limit A2DP channels
In-Reply-To: <20241107220121.97417-2-VAnPushkarev@salutedevices.com>
References: <20241107220121.97417-2-VAnPushkarev@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2535069450455730901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=907547

---Test result---

Test Summary:
CheckPatch                    FAIL      1.02 seconds
GitLint                       PASS      0.63 seconds
BuildEll                      PASS      25.51 seconds
BluezMake                     PASS      1739.17 seconds
MakeCheck                     PASS      12.98 seconds
MakeDistcheck                 PASS      178.52 seconds
CheckValgrind                 PASS      252.44 seconds
CheckSmatch                   PASS      356.62 seconds
bluezmakeextell               PASS      122.75 seconds
IncrementalBuild              PASS      3101.50 seconds
ScanBuild                     WARNING   1008.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,1/2] main.conf: Introduce option to limit A2DP channels
WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#140: FILE: src/main.c:173:
+static const char *a2dp_options[] = {

/github/workspace/src/src/13867230.patch total: 0 errors, 1 warnings, 74 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13867230.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[BlueZ,2/2] a2dp: Reject incoming connection when channel limit is exceeded
WARNING:BLOCK_COMMENT_STYLE: Block comments should align the * on each line
#116: FILE: profiles/audio/a2dp.c:721:
+			/* Reject connection from SEP
+			* and clear configuration.

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#118: FILE: profiles/audio/a2dp.c:723:
+			DBG("Reject connection from %s", device_get_path(setup->chan->device));

WARNING:LONG_LINE: line length of 95 exceeds 80 columns
#119: FILE: profiles/audio/a2dp.c:724:
+			a2dp_sep->endpoint->clear_configuration(a2dp_sep, a2dp_sep->user_data);

/github/workspace/src/src/13867231.patch total: 0 errors, 3 warnings, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13867231.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/media.c:1059:7: warning: Use of memory after it is freed
                if (req->cb != pac_select_cb) {
                    ^~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============2535069450455730901==--
