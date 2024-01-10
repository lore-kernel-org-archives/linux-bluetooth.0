Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC94CDEA
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHy4ov70"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7831aacdaffso353502385a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 09:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704908000; x=1705512800; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t+1WgGxy0NpBvAm4M3Bqllmw416ZcElvcSQdKBt4Occ=;
        b=LHy4ov70rs+ve0KD6Ig4T+OroolgTVqSvWolAUIYIhWHbQqW2ocMF4MBB+XgJsXx2K
         fKW77cIBIS3GA8vKJBndN/7/Bw6eqDqIbh/Jxsq20/U7g1JOeiG12Ezz1iS56BMHccIN
         HNkgRH1OSnOr2paJKYDpEAMtX5pirK6EXIMQYdI13XUKNGD8w9poLVnwakpi3DEBDYLw
         UAbGOFMAoqmbSKAWfmeVqRc4hW4uIwi+yB0bSZCMTywswnqPx+/fuXuTT5O2PO+kxbgi
         W+E5I0Bx1tOxPtn3M2A89i3tHuiSazfkRgqvYObCR0Am6zlPefU6eAfTzFdA8MYgDCAT
         e4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704908000; x=1705512800;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+1WgGxy0NpBvAm4M3Bqllmw416ZcElvcSQdKBt4Occ=;
        b=ZkfETxpO6GyxDe0S0kMdXXBeeotwstSl6zjn86nhwW0eneuNwmm+FJCcMl+Vl09puy
         1KsHUXt/KBdmgs9Lajqywy2nmXL37RPQ2L2uRz93OId2nNs+1ucHix+QDEKg2brGB7oW
         l2QqFIPDrGX255LvEE0odWjt5uF6ZJVeBgJ55XnxfCl49vkFPWij1vMNV11lJrX5VK1c
         TkR3j3/OrjbtEzqImM42g63ltwa12df7vL1TxMqwCsxnLbRknNz+9Rjlco4JBlYQK80k
         7uyoq1wXl/faZQGmv+bLkIPTNS1dqeIKAqVegDtagsnB8VsXSvp7qLWJj3IF5bMIpADb
         DmqA==
X-Gm-Message-State: AOJu0Yzv614izb/QS0vyZBxFfKDTwsegpvGC0Bhbx2yMpV7or094YQhe
	VJIAyndhMrHCKNb7zBTfFPxGbMJebvA=
X-Google-Smtp-Source: AGHT+IHnXbZXX5i9UTe6F3xMZ598orfErJAko/ONF6gIdBk1y/Ed6Tfv4H3uC/KeAI+ZxGrB38zeQQ==
X-Received: by 2002:a05:6214:21ec:b0:681:18d:e55a with SMTP id p12-20020a05621421ec00b00681018de55amr1494971qvj.2.1704908000424;
        Wed, 10 Jan 2024 09:33:20 -0800 (PST)
Received: from [172.17.0.2] ([20.55.214.245])
        by smtp.gmail.com with ESMTPSA id m15-20020ad4504f000000b0067f802d373bsm1846059qvq.89.2024.01.10.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 09:33:20 -0800 (PST)
Message-ID: <659ed4e0.d40a0220.eb3ca.a870@mx.google.com>
Date: Wed, 10 Jan 2024 09:33:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7130062500401211119=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes
In-Reply-To: <20240110161100.106191-2-silviu.barbulescu@nxp.com>
References: <20240110161100.106191-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7130062500401211119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=815783

---Test result---

Test Summary:
CheckPatch                    FAIL      3.16 seconds
GitLint                       PASS      1.34 seconds
BuildEll                      PASS      24.52 seconds
BluezMake                     PASS      701.19 seconds
MakeCheck                     PASS      12.24 seconds
MakeDistcheck                 PASS      161.23 seconds
CheckValgrind                 PASS      222.82 seconds
CheckSmatch                   PASS      330.02 seconds
bluezmakeextell               PASS      106.88 seconds
IncrementalBuild              PASS      1989.15 seconds
ScanBuild                     PASS      945.08 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,2/3] bap.c: Add support for multiple BISes
ERROR:TRAILING_WHITESPACE: trailing whitespace
#319: FILE: profiles/audio/bap.c:537:
+^Istruct update_base_data update_data; $

/github/workspace/src/src/13516293.patch total: 1 errors, 0 warnings, 2441 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13516293.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7130062500401211119==--
