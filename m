Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CAB1879
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772550; cv=none; b=CMUVJx3F/K1Ts4z34EjD8tgF2+dkzGB6niaUuOP9lgV5+GDl02f8gLLx2JOT4C8xWGSmZwB5rHzGgbIrPd8uv+5rso8tvSwqq9mXrt1z/ma+FOs4xqd22ykWEyyMgQtFC4g5nk3B3H4BazHaUBjqNs5dd8gFs+iwo/lC3s0nZ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772550; c=relaxed/simple;
	bh=xbNFcCE7I2nLqjsA1ik3Ql5RavN+kMf2FR/IxccSlnk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k+AaqJzWtBgptVjjVvXZecOgzLMu60S1NsLOM9yHsC5MRRtc/ShLhyhIWrGLGIzOtqgio5kqVbwo+3kTdm7xs3uLIAbSax+XWqxPdkg2Ho2vgND6EzNrngec72M1AZ6XR2BSWow8CAqQuILtDnqtAxeisc3EZAPm5x5Tn4S6rA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxyi+Eb0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxyi+Eb0"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29b1ee96191so167187a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2024 16:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709772548; x=1710377348; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh/B0Q8DgRREFZ5q1InGyy2T02fEK4MYF707lLeYGHE=;
        b=fxyi+Eb0Oyy7N3LGpP8eCkmE1ho0yM0JKHSXy881YzT6UXBQc10uQrBKRFC+v0bgoq
         DZPnNPexr/TWLFmmuikmNI959yrgL549CzRscWUB41v4u1Kat/H2PSAYR51QuWW6V91H
         Y+bnIn/ZNX46JC9+b14p2jPbJtCINyXIMJqRz3vT96nI6eJE1H2as+boZdnSrcBJnhv9
         gzpkosunycRuhGcxsSyfIq27qm9FeCq5IYQUcoJ7VwkvBAmtRa+PlmdTpMAPgnuxkMc1
         bZJKgS3pZxoN0Cjsvya7G5wf+OwT3y7/ongfuNO+dKWDYc3Jwo7oM/GX2BNLveCIfHOL
         lqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709772548; x=1710377348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vh/B0Q8DgRREFZ5q1InGyy2T02fEK4MYF707lLeYGHE=;
        b=us0TVzHXEwcv7gYkmOaIwDvwGBAnBOG5JNz9DUExC/Jk2fX9L8e/XtLZR+ZQXrpr5N
         ssA42Kcp1ZWdWy63+P4+ueofN4zosWbHWa0w3eFLsRE3DbKFWMz7nBvj96yLHbix0Zd3
         rtS18JI26UYmVcKVpKkNWF5bT003Oq4pRanRSnHWQp46EvO3FXBF/G+6vZ/7q5KF+jsZ
         JzMVdT/y7milKLR/Bj8TkTdT8ch01ZWTvwcySrXbtA68K8VkywKOAEt4ndIBo+ubP4Xi
         mOs+SSFlJxmADsj/Bi1fwu35SP9onqaW4txCoquPpOSH/1jY1Lrkn5Py4HAB8/Bs6s5q
         7Wmg==
X-Gm-Message-State: AOJu0YxZ3GWuwljQneIZKO9w43fTlQTSwbeNR4JeTJXOs86gABK9zeOU
	aySdzve9mQ0urMFcLXTxo6h94fG06Q6XgprhTiefqRADweoeEP6hiEpfmethNl4=
X-Google-Smtp-Source: AGHT+IE2BaH74cH2K+jj9XA+H1/3vS0+NtfD5znVQH4ZOUCQYDLkmkicIaGyaW9WT50jDsvEpArMsA==
X-Received: by 2002:a17:90a:728c:b0:29b:2401:c9d2 with SMTP id e12-20020a17090a728c00b0029b2401c9d2mr12646807pjg.46.1709772547805;
        Wed, 06 Mar 2024 16:49:07 -0800 (PST)
Received: from [172.17.0.2] ([20.168.23.53])
        by smtp.gmail.com with ESMTPSA id cc9-20020a17090af10900b0029ab17eaa40sm326782pjb.3.2024.03.06.16.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:49:07 -0800 (PST)
Message-ID: <65e90f03.170a0220.4d405.2023@mx.google.com>
Date: Wed, 06 Mar 2024 16:49:07 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4083710979462185280=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] shared/lc3: Add definitions for Audio Configurations
In-Reply-To: <20240306230440.3983598-1-luiz.dentz@gmail.com>
References: <20240306230440.3983598-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4083710979462185280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833147

---Test result---

Test Summary:
CheckPatch                    FAIL      3.90 seconds
GitLint                       PASS      0.51 seconds
BuildEll                      PASS      23.88 seconds
BluezMake                     PASS      1625.19 seconds
MakeCheck                     PASS      13.70 seconds
MakeDistcheck                 PASS      173.11 seconds
CheckValgrind                 PASS      242.93 seconds
CheckSmatch                   PASS      343.99 seconds
bluezmakeextell               PASS      116.95 seconds
IncrementalBuild              PASS      2206.43 seconds
ScanBuild                     PASS      952.13 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/2] shared/lc3: Add definitions for Audio Configurations
ERROR:SPACING: space prohibited before that close parenthesis ')'
#178: FILE: src/shared/lc3.h:161:
+	LC3_CONFIG_8(LC3_CONFIG_DURATION_10, LC3_CONFIG_FRAME_LEN_8_2 )

/github/workspace/src/src/13584719.patch total: 1 errors, 0 warnings, 608 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13584719.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4083710979462185280==--
