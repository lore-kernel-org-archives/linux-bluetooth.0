Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046442AA9
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782613238; cv=none; b=QIljZu0BMBRouPlP32wM7OQHh7eYhzSe8ZXgPHgb34xJMGsyJIavl0A3e4QJjf8TphzxZT0/IV1dlyz5ucEi7wC6NrGJ18G1KDk4GJEjxv82m8TZZxr0iS627N4Cq5FfsZavxFk4gGSzS3wk5bu0Ydl+tpccaZc095UAaWik+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782613238; c=relaxed/simple;
	bh=qJzJ/SfZEdlRmFnrjy9r8lr/safMkQYvzymsHrntcYs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PbS8zdVOWK14HMs2IQiV4XXh6sVOJp3ca0QTQ996Ac4/uCNXNTY5k5r8h7fTrp3zSy1AM0S4ZWTPM96JE7cYGK9JESVEbZvBFBVrFtRDYtFjCE4wHOMoj9fy5CzdRoNhlGURQzZqpq9tKvhdDFZaR1ie2Q249zJ3vXNsNyQ0ROc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUm+OOLw; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUm+OOLw"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-44841e9f651so1278997fac.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 27 Jun 2026 19:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782613236; x=1783218036; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sytzEk47fvv5d8dqcoxgLmdpR7t+gRePrDOxKiDeiHA=;
        b=gUm+OOLw+dHG7YU/AeEw1X6TjnD3p6kJ3LzS744o3tjK3kR9sHfRe1sR/YccLiUmin
         aVFo2vCq4YsQLqhPy4Xm9SGJnkaFclD4ugepzgASoIbuXZ/03zcaN5tekC5hXtOG03By
         LoCMWJMWOFjL0RLpSplLKMwn+K6/6WjUCn2CFyABO4vxPiE1T/3F8cUAX/xWywKr9r0j
         AgLgz9VvsFUact4sUwF7gud5YCSrSByy2n4ibvm5wz7+Mq2u7Z8H0H9Ds0UtCxlv39cD
         8dFauTVFB26BXg3VBDJy45MTtIcAcOl7LxXZqNgtaPg/lMjuls5GyARZLq20ncQcpPeX
         /NtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782613236; x=1783218036;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sytzEk47fvv5d8dqcoxgLmdpR7t+gRePrDOxKiDeiHA=;
        b=FqqNRtu50GH9aRbL0jIPl27Gjf0BsmyUYX8EYV7zjNL5HwD5r2v3V1BbnnXCuBAeeg
         WD8sq4S8eTFye5kVnsJHw4GJWDcyYhVpHKJIMxr0W4lMygpVgVPnRd9BPtQ3owWYr0AG
         R3JalTaD++Gm+WJ5mqg8JRyIKhFZyKxzh5MgBFFgYdNT6z/WXFbBqEceYsXVBOifFHjo
         DBXzqkvSWB69bX1+IOFBy2dyb+BMu/ZWnsphZIBFi70DRpVvY/p5N9Gy8sBiUYO+pUT4
         z5wcu5i2BZNaK+WnTLr47A5g6S5QHGnaiYJPkjqRTOPa/ku16QR3GQ56PSQsa2pYwqw5
         f7GQ==
X-Gm-Message-State: AOJu0Yx37tkaMK8B0RP8AfzizSOJ5ayXEPp+qdauaQoAiIjizrijVA59
	TrtknkYAbQPfvh9RZoMOUtk7shqWZl8dcrg09C9nxpXoqIWu+DG3oERgGtnQjw==
X-Gm-Gg: AfdE7cl2kCMEgpElxuk8l5dWirbz1Zo4Cw0/LzeBsm/MzT98G4HTT1YXVpRfdgStTGh
	j8PlWfOdOVMY8OzesMQRIh5hTyZBcybAihnObvLTNTfpdT4GAInwhxWDIGMZ5/vtRbjEmfBeciA
	EDMVoHEURWb9I5qZCN2tawdPY79pADbIhuCXEq6XAwXgLcEJFty02YOvVi7Mcw3MJn+jHcAXipi
	NZ3MbBnnbTlWkI6uV8sj+jADTH5lZb/e4GNyLN5/0LRTek4Vx0pjof6/ONJoezePBX1znu64xIF
	AKla00X7GCW1oG8dL/a/NYR+GR5oV7dsizALgn0tKMqRIyrDoegmKrBDlFPkyRJFhXYWiWrjh8W
	mDZ2SXjrCtLuv+91ppOzwv6+fKRKy9rEpC0amNByxjzxDYED8RCiqNaGJkz12G99nPZ+YlIm6/I
	xKqyik6MK17ygoH4Gqm60=
X-Received: by 2002:a05:6870:41c5:b0:448:558c:d835 with SMTP id 586e51a60fabf-448558cefddmr3996323fac.36.1782613236408;
        Sat, 27 Jun 2026 19:20:36 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.86.97])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44748ec8a42sm16331284fac.3.2026.06.27.19.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 19:20:35 -0700 (PDT)
Message-ID: <6a4084f3.6d27ec48.1f3a96.4ecf@mx.google.com>
Date: Sat, 27 Jun 2026 19:20:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6243440455700229938=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alhouseenyousef@gmail.com
Subject: RE: Bluetooth: bnep: pin L2CAP connection during netdev registration
In-Reply-To: <20260628005058.29072-1-alhouseenyousef@gmail.com>
References: <20260628005058.29072-1-alhouseenyousef@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6243440455700229938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117563

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
VerifyFixes                   PASS      0.23 seconds
VerifySignedoff               PASS      0.33 seconds
GitLint                       PASS      0.68 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      25.59 seconds
CheckAllWarning               PASS      28.16 seconds
CheckSparse                   PASS      27.81 seconds
BuildKernel32                 PASS      25.08 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      461.27 seconds
TestRunner_bnep-tester        PASS      19.16 seconds
IncrementalBuild              PASS      24.14 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/360

---
Regards,
Linux Bluetooth


--===============6243440455700229938==--
