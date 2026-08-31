Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CB54CF7D
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191512; cv=none; b=nOgWd4FB8AhVcqtVUCLyIMez8HlXt/m43jNSn6HrwfbQFPAC1VitKBHr5faIgKPJ386BFHB2nf7ITyZguay4PDKo7rmVzOYbMNs5XDjBPqLnj2h2D2/4fFskOmEoQ/X+9Juf6jQVziCl4HvhVgaWdupBK2/mz/jTYUeIYskrx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191512; c=relaxed/simple;
	bh=u/TNMp0/DSCWNneqCVYvJb/72H/taxhFlLeMKNcnStk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=d+YieHrLyw+L3C6U/9JpknTHUF6ufYghtDk8IuXk7ror8TNWbeIc3gg9784W/SVkz/vb/HAzblnh5ZyZeZjcFvoeyTe4gVckTBhThT3JKtzX9HybXd7Zg/Z54Ja3lWA0blluPxXzLMAWtePu7kxRQGMUMKFTGP5ZpEujvFDFEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR2kVdYm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR2kVdYm"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52d7ef16f91so24725931cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788191509; x=1788796309; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=53I74dhUEYqZWR6j6AAqdTVGJ+A+I9KQTv6sCqLiImg=;
        b=VR2kVdYm/LBEkwF0M62MJ9qkDgiS0FJmH6xjuox3qqxoRLBRFAd9PxapvVC0eLxymx
         gpp4/Qo2S5kVoqMJeqoT0oFl9XXCImglMlgk0KSoc32jRCXzGrqS8FYH38nXj45lm5pu
         hga0+iBuSjN9DsF05s50iMC8KWNS5Rn0Lf9G5XtQ5fs0hrLVSxxhtOC3Xvq4do1NnPBT
         r2BvhWxAmrLwpwP51jaL+L3zmzELzW+K0LD6YEhXmgTkl6c+zPi5MBm+7+AJcwtx9T8B
         v49bCU27dOHfOhCzHNq4ErW6lmtmenK/hm629inj7UuYF1aHg82VOjLWlENzpN5PeiWa
         5xEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191509; x=1788796309;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=53I74dhUEYqZWR6j6AAqdTVGJ+A+I9KQTv6sCqLiImg=;
        b=Q9nh5gg2/+pBl6O8o+nmntP94u/nYLDZ4X7P1PGplLs8359mICz7+bxXzfxjtBGlSw
         i7NiAsz8WZI4V2h0UwzHiLxxm9hwgNyUYeuXIIrydXvvnD/PHPCCwxFvbiFJZcOjWtuJ
         fuIR8eQMhcX0GX/0Ax2a8Mq38rtFTEGnJ5lQ+fc59yVQJObZfw3ePXSZMHcU7B6xwh7k
         M50obvDJYk0mrg5kh9ipA3NePmyHHtk0DjjOk2kXGRb+wsGYVk1zdXHAT7f9XNumLESI
         VAeGa5j7qDPJkBM7QISk5qHMITCNbYl6Nv1Ibx408hZXND2y7MneMkfw6etCRR5DHk85
         XRpQ==
X-Gm-Message-State: AFuF++lzlG8jFfiq4lcUcsr+4lbVDogxQof7Km2B59X4+5blYtxrtQ+N
	X0LSue2RHO/t4buYuWexGArbwV07A1sN9mb3lUi6Jc85sm4Toht13dqw0JEDlIO0
X-Gm-Gg: AR+sD11Ort/1NgtYA7knZjW1vRZj1Z6ZRgCwga9cv770T9tEulMx3kWD92oc5CS/uIk
	rZatKwLqjNmIV3a9S7GHXlMHHNLnGyzldzr4m5eH0X/3VUJtOZpnOTGzH476yNKW4eADga99N1K
	ABnHCDCNKle/iIDbrJm8B2v1qI5COOYLh/thA0wU1TqTo23JfWwBbkHJ/D4cKez+vAJeYzsEyky
	LlSqFcje2YF1/nwyzB85yG2n07McsofPg/8Jdt53affcJh5tADZ7xDaHCELnsgXEYqJ0pRyjsw/
	9ZAIdjrmRGQ466gyUgk2VvANh140dswjwVyovGPhDeBilJpGTr/o5XpeWlho854qCmDv/EKq9eE
	X9niPfc7tyB2AHUR1Ye3ayrCq2TD47CelCIwdpr9nHzp48h8kTOMkNRLKPSFXK9dl3ZkPpCFUik
	PWVwEKJZf5s6/7Kuz1YqwzXa6kHPOPjB44BES+ezEdol0hfajMTkE1Ce1RxhgbZM3oCaT2xnvUu
	dR8kaUS
X-Received: by 2002:a05:622a:30c:b0:52f:a2c0:1451 with SMTP id d75a77b69052e-52fb93d17e4mr303720061cf.7.1788191509328;
        Mon, 31 Aug 2026 08:51:49 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.102.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce415902dsm90580896d6.0.2026.08.31.08.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:51:48 -0700 (PDT)
Message-ID: <6a95a314.54d7c073.a4fd4.a8a1@mx.google.com>
Date: Mon, 31 Aug 2026 08:51:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0350070684381758101=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] transport: Fix use-after-free when replacing a linked transport's owner
In-Reply-To: <20260831144556.128154-1-frederic.danis@collabora.com>
References: <20260831144556.128154-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0350070684381758101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154589

---Test result---

Test Summary:
CheckPatch                    FAIL      0.49 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.25 seconds
BluezMake                     PASS      543.86 seconds
MakeCheck                     PASS      3.71 seconds
MakeDistcheck                 PASS      157.00 seconds
CheckValgrind                 PASS      153.91 seconds
CheckSmatch                   PASS      300.67 seconds
bluezmakeextell               PASS      97.70 seconds
IncrementalBuild              PASS      581.65 seconds
ScanBuild                     PASS      917.67 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] transport: Fix use-after-free when replacing a linked transport's owner
WARNING:BAD_SIGN_OFF: Non-standard signature: Assisted-by:
#87: 
Assisted-by: Claude:claude-sonnet-5

ERROR:BAD_SIGN_OFF: Unrecognized email address: 'Claude:claude-sonnet-5'
#87: 
Assisted-by: Claude:claude-sonnet-5

/github/workspace/src/patch/14778073.patch total: 1 errors, 1 warnings, 29 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14778073.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2463

---
Regards,
Linux Bluetooth


--===============0350070684381758101==--
