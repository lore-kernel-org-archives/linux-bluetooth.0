Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443334;
	b=eCZLW9ABOTfDpd/C3DNXjbhYPf74s/IOMhQgD9ooYtQsNFVgQyXxPSZh1cL6WeEOBPlu
	 oGLXx1DJkXjBhZwaFh1ZVc5GevMxEMTkZm1LFyCjuc2U9xlkWorblvz1eOP2B0tHC6Ztt
	 01eMLgHpyRxuVRMeyAvHKmJDceIOXSbrVOiKJwOd2J7vg7dLhSPSfJYwIL4cnWZGpFpzV
	 Aakh6GkZiMFIIqca8UOo94/rS/L4qmsfwxOpSMKJr+3Gag/xPiKS0bLlBPmNREXWJ3CCy
	 mKhobKDaFADi3bcp+fsj+QZW52biIlpPuQ18QOdh7jNEivVQ8NmBHOwaK9dDqd+KBEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443334;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ZVJoiznpTbiP+FNs+8v0w3F0wcXINiIsBi4EQAtMxoU=;
	b=Tyxuaxd6Y2yocek+32aJuEHBtXKBHgt1itrCvwbIZVL96dbtIpaWOUkkjiLRP24AbFOx
	 Ws2kDkYf0PRgiD7r1cgLrPpmbMiK7juQi35bTNQsslKu5zh6kNwGU4DfqKkTUneD1S76u
	 j9OuUGyB8Yy20Ec9IPqMqk4ilzzgjhEWf8DAZNomvV/H0sZ8xlRNBwVqB2+4S1UIBwW1Q
	 rkzs7dM6I2bWhOhdCA/wrpCBUqYwdcYko9gUNDTTUY5uu/M2KykqkJvxkLsuL+zjS1g96
	 qY1U6wn0H5yH1FIeO4DEWqxAR1rLQYvlyK8CMvOQC2tTosavD5kXkX1hz+wT5LAhnUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zj2wDE8w;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B474606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B474606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zj2wDE8w
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53665358476so36326821cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443333; x=1795048133; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZVJoiznpTbiP+FNs+8v0w3F0wcXINiIsBi4EQAtMxoU=;
        b=Zj2wDE8wAJMyoShjznBFMKXE3TKxREzYmdiJBv1oLi9Eo4+Zg1dhfYX5zIUkznimJh
         KMUXv1yWqxpfFraLE7r5UNTvleim4L5o8BRoQnu9+bJG9Ks/Gt3iH4wSamBlzDiTECZx
         4iGYGuymqi6MNX89BUJOeyexzvNLZdA5+N4G10VX5kxeLoasfW5FOLOUMEO0vgPEdN+W
         1AVwMT7aGme2pWO75yhvtodvn9QKzzU8cObyQRBLnakKSZNMZ9KFp4h+H+lM0xB7U7dk
         P4MglD00LwxjHLiWnpp9GabVcKCABBZlmoRwPYf/oBE3R9DEI1UD9q8T+uJo7dMXiTYt
         QXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443333; x=1795048133;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZVJoiznpTbiP+FNs+8v0w3F0wcXINiIsBi4EQAtMxoU=;
        b=VoMq4rni9meJ/BQmM89dDy/U1jaqHT75Ly3eEF0d1gI9jcV71vZgQUP6Ummpqt/iJq
         qzPhMUKD/9S+0KuJsadk88MhvPQrdGQRhD26EwX0zxiXpo+66o3C8Xdg7ylqqPR6vtFY
         8PdDGGiyVTmsFpbvUsXt5l6NB7Ur1KQ9FZTO/41TgjLne0Enehwhlo4XLqOS+53b8+mG
         v0gH0Pmg7D+BTUtY60aLZcrli0sEV8/irh4rIElVbezsiHkfh4MmaUCKMXp4wwagXncb
         h+lve+sqiApBugcWHdwLzgUVcJH4k/74EBwjJcalMpjUvZiE/7ctuG/XzxsfxIaMLjpK
         OPAg==
X-Gm-Message-State: APuU4Z/4r+c5c4tgeRZ9WeOzI5RDS0FAx/p9CIoD/uCHkjsfQdWi8dxR
	FXZ84aOnRKESHw9qixLc9z62gpNCYgpIOezOPgHqJ3ZK/6nvwnTApenplxozlg==
X-Gm-Gg: AYBFou11DLBW1714kKt6B/cax4JqXK6zHuS6v63es7ldi8+DzEjMXYGLoTUmHJmLuFV
	b/e47OrzvUQSlqllJASaOwF9VSbIxaaSn6bKx+RpnuKD3OXu2SWgBiU2Wk8AGo0Bl3q1IhInMtA
	wNaFwKPNkWWSH5//P5VzvuHrQZzWvTyrQflhk0CBqCQa42mrGHV7wpAiTBKSnery5bFiL5FFgVY
	NjVyXTBeqtxRSLlRK+GmFEEC5AzHoVBPsl1ZYt0I3ySRglx1HLUo1kSgibKIePeoOb5kFnTx6i9
	dpfmNEBY2Y47sOX09z3IEUwNUM1C1S6Q6Y7ZAoMEN6x0CJUU1uERZL7YhpzCNZ2zA8csc5YWf/D
	gIA1pT23lQt5PrCnu0cPK90s0vIsW1Oljc5G5lXeYxT1oZNtOcBHQRA3U4ntQbMVNzv2f6a4gmV
	PESJ57cq6rPwvyEoCnDtE9vu/w6kaBPiszVqcCDhfxkDsEJ1vSr/VkdovpP36QIyAw/ST2FNghS
	S0ckWXkkZy5xhJaYDFKGvuhgEwvvMpyplJyzleggCP6ERMMmmtgCy/m/Xnwhaw=
X-Received: by 2002:a05:620a:31a3:b0:942:a42a:78a2 with SMTP id af79cd13be357-947afff8738mr699734385a.31.1794443333129;
        Wed, 11 Nov 2026 16:28:53 -0800 (PST)
Received: from [172.17.0.2] ([20.81.246.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e61b8f8sm604415485a.1.2026.11.11.16.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:28:52 -0800 (PST)
Message-ID: <6af50844.8c8d7b34.95489.6e4c@mx.google.com>
Date: Wed, 11 Nov 2026 16:28:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3138686463764192673=="
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
To: linux-bluetooth@vger.kernel.org, amirabudubai@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix size check for receive buffer space
In-Reply-To: <20261111214905.518429-1-amirabudubai@gmail.com>
References: <20261111214905.518429-1-amirabudubai@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3138686463764192673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208782/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.82 seconds
VerifySignedoff               PASS      0.51 seconds
GitLint                       PASS      2.18 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      23.41 seconds
CheckAllWarning               PASS      27.15 seconds
CheckSparse                   PASS      36.28 seconds
BuildKernel32                 PASS      24.00 seconds
CheckKernelLLVM               PASS      24.70 seconds
TestRunnerSetup               PASS      554.55 seconds
TestRunner_l2cap-tester       PASS      13.20 seconds
IncrementalBuild              PASS      22.87 seconds



https://github.com/bluez/bluetooth-next/pull/1116

---
Regards,
Linux Bluetooth


--===============3138686463764192673==--
