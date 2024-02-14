Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6216960BBC
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930699; cv=none; b=N1ZIoQxBV9NOp3m2nztp7XGv/OXjc6wjqkEOv23niCWqo8//ccse8k2POLY9Tg0H4u4LFTED3QY6HmfxpTz4mpvk5H66oHTawn6N+xpOX9reL1r4rE49BG7JQg1q7kw7iQBMvJNa4w85WG8arYuyU9x0Qq7jfTqWENWnXMWfllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930699; c=relaxed/simple;
	bh=tC5GshrpzHC4qfGHqgN4Jcq4osKSA3EmHWigz2BC+p4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AgxQCHmluIjx5RJ/7WFBaaNKAF7leBMbC3Rry6LTPSFD5oNXsHWcPxg8FDgzBjMvEAAuw2eMYwcm82HnLjHD8wCoXapMo8N2n79VI8/akji1STHWXwI+GJfhGqrYUxXAQtjnkfq714PlnhdlhHUpqu+P845OhBigfVZv113XVbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7JMPhK1; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7JMPhK1"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3641bd82979so6694435ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707930697; x=1708535497; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4aQkQCVG9M7CAunxXVw4Cw4yjEq4IPnFWle7W4oOCbI=;
        b=R7JMPhK1Br8EmxCKU2xBBdyk4HWBOR9t4pRgCbDJmCAUV4fsq9VCCvk/Mky6TtW4kU
         04Vi1jwMWeJVo5GPvMOcrKD+HRAru/ZtTLrehnzp9hQyQSFG9FxBKqCnyzcpzVx+mWvZ
         h/060dmBLM0ir+VEzIKxDwox+1EG3qFcEUcr89/TlWwSp+db/sTTxcXwLJWbxGf5zYme
         7a/xf84QA2Tb4FmO6TYdYHRTaxbCSMmNiZAN3vwu5wToePnUg55oHwXNjb1sILkqkRCy
         YImoJrvdgZX++qKsMdluYRR9OohH6Y4TXs4rH0auPvC2nxALxqHMNWeAPBSK61PrnKMf
         qTOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930697; x=1708535497;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aQkQCVG9M7CAunxXVw4Cw4yjEq4IPnFWle7W4oOCbI=;
        b=wQClAwP66Jx1zIP+4piXji6T85pgj8TMj0CrSfv3iFx29DHSQAYkZp0RjM/8QTaN9r
         0tK9T09bt3T9ysuBw9xGDsp92nBzGmg228arklS+p/CdxGQhRmy1Ap+YKb4OGDfF/cgq
         CizCBGjkx97XBokYwOS+aQ07LKc4Gma9ShvQ8xb2CO2azH3//vsLa9Pz8KigH8XyOP9I
         9Kt1Y7q3Ydqby7+kpmun7wnPP39CyA2x8RLU1axoQiqtmLfSGVUxvObMiF7Hb7sFKmDu
         cpq+hGUPxI74LcRXbr8FjgLwc25yvMowuXIBXun/uaaHYru9GxTloE3JM+s/YN+ELHP2
         ppeA==
X-Gm-Message-State: AOJu0Yymau6TXkf1wn2dBPKJf7Y23NvN59iUF17cJ7+lFpNxR5IBBhMF
	02LNXIDHOYk1szs/1S3P+qKShq1lkWNccC+wrNjy8aBovzTP/I832F4mTygQZyQ=
X-Google-Smtp-Source: AGHT+IEtIPGiekrWosh7lgYEGoiOp/X116X+RWJIzzUtgRGxQzWG1hmA3lg3uzX68vwGBE5khRd5ZQ==
X-Received: by 2002:a92:d182:0:b0:363:b362:a2bb with SMTP id z2-20020a92d182000000b00363b362a2bbmr3416104ilz.32.1707930697233;
        Wed, 14 Feb 2024 09:11:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJwlCudy2Hcv/th/P792JH855tL4X5+2y4yYgjsOfofCL503UzR5euKJ+Jmcwr1me2I97PvYybfcyCzBKYXzPBjA==
Received: from [172.17.0.2] ([20.163.86.219])
        by smtp.gmail.com with ESMTPSA id q19-20020a632a13000000b005dc8702f0a9sm3437097pgq.1.2024.02.14.09.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:11:09 -0800 (PST)
Message-ID: <65ccf42d.630a0220.b2b4f.aa5d@mx.google.com>
Date: Wed, 14 Feb 2024 09:11:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5773157436774018044=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [[BlueZ] ] mesh-gatt: Fix JSON files missing from dist
In-Reply-To: <20240214155019.325715-1-hadess@hadess.net>
References: <20240214155019.325715-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5773157436774018044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=826064

---Test result---

Test Summary:
CheckPatch                    FAIL      0.50 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.12 seconds
BluezMake                     PASS      704.47 seconds
MakeCheck                     PASS      11.79 seconds
MakeDistcheck                 PASS      165.83 seconds
CheckValgrind                 PASS      227.25 seconds
CheckSmatch                   PASS      330.46 seconds
bluezmakeextell               PASS      107.33 seconds
IncrementalBuild              PASS      665.70 seconds
ScanBuild                     PASS      956.84 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[[BlueZ] ] mesh-gatt: Fix JSON files missing from dist
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")' - ie: 'Fixes:  ("build: Deprecate meshctl tool")'
#50: 
Fixes: 1f6553edd8a5c ("build: Deprecate meshctl tool")

WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '1f6553edd8a5c', maybe rebased or not pulled?
#50: 
Fixes: 1f6553edd8a5c ("build: Deprecate meshctl tool")

/github/workspace/src/src/13556710.patch total: 0 errors, 2 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13556710.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


Use of uninitialized value $cid in concatenation (.) or string at /usr/bin/checkpatch.pl line 3196.


---
Regards,
Linux Bluetooth


--===============5773157436774018044==--
