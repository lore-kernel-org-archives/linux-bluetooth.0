Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792653873;
	b=rX2GIjm0RK3INJnuwSxUYWcsCkwOI42fsh61Pv+z/PtqIOWzfLjRF4cbLtSAmgqT0IOA
	 X0R79awjBkVBQPtt9kaDUfchs+M901mdKSPwYcntVxCQcc1G250dDyTnq5mFpzxcAi1Ot
	 qOqlvFJJ/vEfg+3BNYI1MWBxn7Lt7eXZVvIv8hOEyoIolPE1XUeE7X2YVqR9djfJSX5Ve
	 jBgzzEXfp79t2zVWEVN/6EraOOz0/8lyoVka7FcE5sF6OYUYRtiW9mlfe7bnmBuWkQRTl
	 OxfaxVAEusLOTv6HC9amk2NoQKb0dTiEOL17q1nkivyhxt0HrDVGO1MsQ84Sq8wLK/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792653873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=jXSxzkB2sjR3pOGRROQjJ86fgtukIAjB0AZzOEMLK0Y=;
	b=VBBC8ZQoypOBRWi4xiQtNA8SMcn8761iu+Yh0Issq3C705qy/H5Ed4fQE4DTUSr+4PNt
	 68j3wOdckVsfbNlQn9y2xvnmkD8QvoXg9T8Qx8mkjX1WF15yIsvylC8FNQqaYbCRLY2wW
	 UGokw0+KvyRyKY9Rp3a8juuhhuFCMwjkYjH5rPxSt3Qfyug8GJBMUlRgJEkvCXqxi/x10
	 5xvEElmu/+N1kaNPc+1T+aFz/ofkcfKjibQwd5fwdD5WO2XrwDjt47OZbz1ffOL07f4K8
	 ofnsTpO2prtzMO6SQd6la/wBRhRBTLDQucH2PU3Xe8AnZV1kuVTYVxq+0HrtJzXBiLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E1q5ooFv;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF4606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 07:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84CF4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E1q5ooFv
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91c11468b5fso16237996d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 00:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792653872; x=1793258672; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jXSxzkB2sjR3pOGRROQjJ86fgtukIAjB0AZzOEMLK0Y=;
        b=E1q5ooFvjwuxLEpdQ24V3ucIWxkY47CwRfMa75DFoadvGnJVJrAdTCgNgY5OEW4L+l
         o6Ii/e1+LIRgYnSGq5wnYU4i6O220zzJRcthWh1E9OCU8KcPocE7ikWh3usbTxsEHtkW
         +xAcN4M7oICoBhtjdvmPb8SY6F1San2Ky44I+RqxU96cjYx5Xsn8qbhsI2FlTT2H3UEn
         MmQfJJg6+o28lZW3SfpW21d4MC8er+X2acRjqZjVEGmygfE3KzYPEY8kS0IuQ0u8pmif
         5bYJ/8YDYT2Ihr8rNEABfZs009fpnEbYSRHpgR0CoKQMph1NT9msarC//HreygaXJIGI
         Puyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792653872; x=1793258672;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jXSxzkB2sjR3pOGRROQjJ86fgtukIAjB0AZzOEMLK0Y=;
        b=cYLujsu+7wmZY62u+zdIdUG/mnGIm36KrAfwr3eU4S7kofbQluDRp4GVzG3eyfY12B
         Twi/2Mgujz/Wth+mKYecUcxMyn02gznkuUpNLLKlPnKT1V3MuLJprbhT7KUTxaTrmkfq
         AiSqp5adK2t72kF3LQ2sUnjpc/43rPuw+yCzil1qJLzH7nQtGda5orFuGGaE2a/Dhqv6
         /yhkBnIMwcnwXkhPQlWZHJy31UclU+8PLZEOe78dz8AagA0Qs+SUMaIoB48HU4HwIS/j
         JFV0dn4TpuD4uaD/lzgn93qJbapA/G042MUdM4QSgscHINM8DJA2BNB1BkOdGxGSP4d2
         fX6g==
X-Gm-Message-State: AFq9FYKwL9fFoItbFvP8HrD3i7QpVtmxzkyrsI/ODotURAyH3hoTaGWA
	Luao2U/EfdcBmIt4Cso8IwWDfhnue88HKOKKEsC689GachcqnBsDW5d1pP9FFA==
X-Gm-Gg: AYBFou3gy4rR3vkM2M9Av2VQ8hL93w7O3jMp6pgiIqfSfQfxbkeokXl3hI8sT1tlyJe
	9rnC1pEMK6K8KQrp2pTzcgcqnY8E2+C+3bDr49eqfFnVbQu+1dW8FmzCvSJ+PhV/EQnJnnBmG7r
	GAIROuFfLAM71qqlgE5fCZdLjKblLAImYwNGFDnNNJ8QcHJBtPuSTKV0TZNkcxwT/IfxT3AgN8m
	ZHei/5/dDy7yZJxl0E4pnmP18r2nc74R208BBDeX2N1XbhMzXr+aOpIJEtusoJGRXy24m5Syeio
	MeiP04yHpYDZQC+Sfx1pxR5mILOxpQnH28MDwYo8PBP12RBGCTyLsiLy9V/W8P1fQrAEgoZD6SF
	gf6wZRkDu7LN+cEwzrqxW2ojgt0qy9Cq7RRZJgocGS8/8CfjmGs4fHfJXjGvcs3oKtPDZbG4Iwd
	Gwb4wNH1+FYD+0CyTr172sak8BIVLJzfaO6vgVY5+m80kWKj19puWyh6dBnSj+upnp5PL18Dn9h
	kfOx1xTvcCxKIG3RDshBSR76/yPyHXXiXiHmYpNAmBMekmieUmnaqgd8KqAeu8=
X-Received: by 2002:a05:620a:6889:b0:93e:e2a4:b0fe with SMTP id af79cd13be357-93f57f645d2mr819626585a.66.1792653872464;
        Thu, 22 Oct 2026 00:24:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.13.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56dd0022sm457273385a.20.2026.10.22.00.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:24:31 -0700 (PDT)
Message-ID: <6ad9ba2f.86577435.86da6.0d85@mx.google.com>
Date: Thu, 22 Oct 2026 00:24:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2521685925103985750=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: fix ISO data reception
In-Reply-To: <20261022032150.2213479-2-chris.lu@mediatek.com>
References: <20261022032150.2213479-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2521685925103985750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1190983/

---Test result---

Test Summary:
CheckPatch                    PASS      3.43 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      1.03 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      29.28 seconds
CheckAllWarning               PASS      34.10 seconds
CheckSparse                   PASS      36.96 seconds
BuildKernel32                 PASS      29.51 seconds
CheckKernelLLVM               PASS      35.31 seconds
TestRunnerSetup               PASS      708.58 seconds
IncrementalBuild              PASS      32.69 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4,3/3] Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD

1: T1 Title exceeds max length (81>80): "[v4,3/3] Bluetooth: btmtk: derive the firmware ISO setting from MTK_ISO_THRESHOLD"


https://github.com/bluez/bluetooth-next/pull/976

---
Regards,
Linux Bluetooth


--===============2521685925103985750==--
