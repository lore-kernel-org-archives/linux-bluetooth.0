Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113843370EC
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788719352; cv=none; b=lyCbRpxdxubnlCcHL9hDx0wFKl/GjOZgtKLNZh7RX14NfRcCEPc8n/RSdSY4lQzg9LKcCi2W90wItuZ8mwVBX1Gc9b0MYfchmDFdy6nRJaaRjd0J3LVVS/ffrBWqyi28dhOwHete7lSuet1Dti79Dx9HboVls+HbnAuB/jov5/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788719352; c=relaxed/simple;
	bh=Yn0wz0Cb6xeVjj3qMxX9lYvYMwYjtzWMuKpYo3NIhos=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=diVEfJpcHLEQVN6czSHaWPmOOhqiBLmcIT8YVk0pkfjQ5mhoEK1fSrDnfrD48seXEDwFK7E4FkClgM8vlBfsZFY0rtl6dr7/SXzOZ3aifIpUHEP+oGr0rtmAMuWIwtAbR5wKaLKNKFZWY7gaB+rU7klnVqXTZnbtks2O27txOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGAiL4rM; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGAiL4rM"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9397e2994dcso248812685a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 06 Sep 2026 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788719350; x=1789324150; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l5j0lx5xiMwmUhcfqaPtV5Xn252Dafc00VwIyuDKhcY=;
        b=jGAiL4rMT5+4eEUoAfSObN2DtBsEZYb6sdcmcVAUSU+VvGHk+lNyyNR1QCvMAXOsmm
         y1eMwiPFns76RaoNHZ/SxOl3Pt6nxuvu5jiUenl47GSSmSKmboN/0lpLtI5mlPKyJDfM
         YXwPAnU802Uol8HodIxu5Wx8AonJzxUtRn5P9krGzKIN7rVLMN2dssoK/YBUpHcILocJ
         6FMqlc6wsL0IoT8/w9sap8pK36pQ7I7q3Xhb4uys/EEla0WBpu9WWBEx5BHRnpUsgp0G
         JckmDd9t78+1hcKePhO7IWm0R1IKfaS9pYuMUjXczUshilP0wFBbirMKbl2t5jS2a/YI
         v+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788719350; x=1789324150;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l5j0lx5xiMwmUhcfqaPtV5Xn252Dafc00VwIyuDKhcY=;
        b=JAxI7O/VcDambEeKVZg9Cx3sc833ywdJyWDpIplUNeMQ8cnJe3HHgZapbuBSLzdpxj
         Yi8y5FIRI3esJhIwqXLd1Yz4JFWyfSObeE20zT2p3+OGJ51ypPL5DpN45zA+DfeEwCRQ
         NjSNK3tCJwIlgyaGXWTJU/0CrgvCqjDZJnIs2SOp5/HD7WGkomUXZn3HaRQQ3U8GP7Tv
         9/xu8STqKMXUzwNpkFFl9I83Dvftbr1O1Ma9omTDGgS0e6NLaXeppv+Rv2aWSlmZDdF8
         80QjQXzDFUuBPj7q1EiXNjjXZVPQUEw2y2q149RNasQWCfPBL3/gaNM/yY7KI9I9iFtR
         majw==
X-Gm-Message-State: AFuF++mnQT8WIisuGjvclXISmn+um47XwUeyXdJgcl1pxiX4asOe33xS
	8y2uMATsCVeGrcPuSsdcWeTLP8jLMMQTJ+g45WED7j2E+TnXK/EL/Ob9W4XShA==
X-Gm-Gg: AYBFou29ZFyssin+Zy0pqLbWQaJ2aTiBDqCPwq1HJQ5ZLKgf/wQrmYdiR2Ae0FxhXpN
	r7qmDj4BBlKFT0Ep45GSpgINkwfY52Cm2SoK0G5D1EYEjq37S3PeO+SE/JC7JpDQfCw/mkR/Xdb
	/RMwATJDYAY/C8lGTORqSXhTWB9xNafHZKJbSjVWSN9uSxKXLYsmkK7ZLF9KIoVHikmw/T1Iccv
	Y/U6ofaHxpSfNPB0ga7CNsurB8vkmPFTUtyMJDG1unM81+Sjt7IR43ztpaRwa74H8ugXsvgvBZ/
	9xEdkjaDkGnxAvJjlX1Dg3QoOl227txtKQC0H3vDuqOoff+IE8U1991vfpQtvAr//KE/OmdT8/V
	daWc0GkdXdKEFIFLfMm7iMHOGGjTWDgoLArSZkgEtP1xdNYIXuSWmn2BEKEVdqiYtenlJv7G1yq
	p63xxqCc6zdtxOfLwpxNLorNZFrJ3wTX+U6knOcvhckArYRfQ/aWPoBuJBf047eYF7eso=
X-Received: by 2002:a05:620a:2715:b0:939:8a03:f7e3 with SMTP id af79cd13be357-9398a03ff25mr1485337385a.6.1788719349808;
        Sun, 06 Sep 2026 11:29:09 -0700 (PDT)
Received: from [172.17.0.2] ([68.154.117.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb2fd82sm700942785a.17.2026.09.06.11.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 11:29:09 -0700 (PDT)
Message-ID: <6a9db0f5.7ff333e8.3955c2.8cfd@mx.google.com>
Date: Sun, 06 Sep 2026 11:29:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4420721202464633996=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Functional/integration testing
In-Reply-To: <f5138d545e2edb8cbc0116acdb7c0384ef09f2a8.1788712996.git.pav@iki.fi>
References: <f5138d545e2edb8cbc0116acdb7c0384ef09f2a8.1788712996.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4420721202464633996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1159124

---Test result---

Test Summary:
CheckPatch                    FAIL      4.40 seconds
GitLint                       PASS      3.00 seconds
BuildEll                      PASS      20.48 seconds
BluezMake                     PASS      561.12 seconds
MakeCheck                     PASS      19.92 seconds
MakeDistcheck                 PASS      154.78 seconds
CheckValgrind                 PASS      223.37 seconds
CheckSmatch                   PASS      299.24 seconds
bluezmakeextell               PASS      98.04 seconds
IncrementalBuild              PASS      593.09 seconds
ScanBuild                     PASS      874.61 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v7,2/9] test: add functional/integration testing framework
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#451: FILE: test/test-functional

ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#478: FILE: test/test-functional-attach

/github/workspace/src/patch/14794355.patch total: 2 errors, 0 warnings, 308 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14794355.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2498

---
Regards,
Linux Bluetooth


--===============4420721202464633996==--
