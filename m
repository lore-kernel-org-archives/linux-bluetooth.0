Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BD1377EBC
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 12:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318101; cv=none; b=RpR5GDLpyx7SmFlyWoQvYZtIVlwsSgDnWUdrgw17s1kR47n9KDuChRcDiCMANQndeaYzuyogI6XpHrbCmpq+GrKO1xVd3+mi68WRkqd1r/XQjesay6ZH6/Vi8xrdYCbYgpnDf7+O7pdES5gfC91rpxI5fN0eN+Tk392MJO/1N8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318101; c=relaxed/simple;
	bh=BchNmrth7XqX8ZRRjagEdisLS8GYnFxNrn92eQfuKQc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kCKLgciZrmLB9agjo3nqaJG7coBWIq96VddtPgp12Jh0KRBEcM+9xE31hwxX58qy6sNPNeaRoT4foOV4XxxtQh0Qy7ADpB4XcYNhhOAt0/R3IEQ+IHbjOLHzJBl09j0h50VcMs+QWvmwBbn/lVa9GKA/Lru82ATOOB1Gpsmvd78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X81fezXx; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X81fezXx"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8cd45d4b7e2so22206826d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780318099; x=1780922899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IJHwUnUYjZcoONn0cxUNOdOQJ1/2sVGlUR31Iq6QtWs=;
        b=X81fezXx6S2e7cX8Ha1VuHSfrkA1LKR56on0mk1TyiL1iUR1/Swq2VpuRdj6TdjIyq
         KyuzSr4d9Vq3miOwBORyAH+w9uKL665lldCgrE3WcWXis3p3xVzVDbiFbKvWGSDyFWb0
         gM8VT/IZNr4r7f9WyseM9szQjNfPfoAMcUxO+ANJaa858vdJBE/PkuBye+Do3Ciy+X7j
         kCnadOUQ33U+xge59xlbh0wVxm6pk0WoWQuG783eTcEtkfy7J5sPfPqaY2Au3D2g9ySQ
         XB2w6dC99vbIs8xBP/MJqtlQOzXTktnqRg7Xk2rMRYrdiQL5Njt8GrTAJxdE6LHx28u9
         t36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318099; x=1780922899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJHwUnUYjZcoONn0cxUNOdOQJ1/2sVGlUR31Iq6QtWs=;
        b=lJWFNM/fqKh6agD0dx+CVoiFCd5uVR9apU+Hkd7rL9jzFcUQJwsLhM9QlTkn4HIPZ2
         cfFddcss+A/scEoquh/gDplF3AloXNv2O+Dyq25yDO1mat657snqW36QlXvJkg6to2Ci
         Taz2cPW1xCebR/sJHGnjSBBjmAvIZtSU1sOpLBuQsIgkRMPWMvsYh7l+aU1d34hdjuuP
         C/d662ke3Eo4VOY8DdOq/oS3oSXgE5cVFmZv6yHeNH0t2T6Y1D/7rI5Tagq2LxJtpWcy
         uX3Uz46MmRz8tu221abl+ZH6vsFYKWD9CDXqaJ4BFYwimaZbgCXnGuZDNeacAIzu3HLY
         DmLw==
X-Gm-Message-State: AOJu0Yx1RAT2o+/CIlUbVXf+sR6tVTpoTmQQLxyi1/IAnJWKhtMSngmi
	TxITSVqn6wD3nhzJhQOXRe72MLu6z8f1tOSnnOsqSz3CmMYnr/TfjJDYokz/Kw==
X-Gm-Gg: Acq92OH0bDM6dg5UAZZw2Odmfy2u6AOBA3dSvGgkabJFvHFDZIXp9VTaAR1e3KD58uN
	S3Hphbm/jtR59f/5tOtxkXoTSesqTMIe1YyFyfMXRysAV18Hb94VdsVlhQjLvGwgft7c1ahKzDT
	iIWEHHi9vnoytjHdMRZyU07Yhmz8yooUtf1eCyB/0qrxjuq0a32CVRJ1BEJqoA7dx+KP5ZpuDOU
	ACWBppsUNhfh5akiHo6d+7WEIN6REcp1FD7LYYdRDpFipgJRy2KEVy2IQ71nzwAirPcF9GMGt9f
	2HJ5YJcfxS/soXeLJVap6CfCF314wo83Ro3Jo9HpUzcCvbEynWdFKblV1RxnQwABsa9H9txJc0Z
	qkgw4rBnzSps7dpaSGWl0M3evzKuqLTqdBbRyHv/J06q1yxZH1nILYpIvHWvtE7sMQ0TQAR3r4a
	PVcpZ6ye1RzVmhHNTVa+ilFbs1guABIKoretcZCyIV63U+F+omXQ==
X-Received: by 2002:a05:6214:268c:b0:8cc:58f2:339f with SMTP id 6a1803df08f44-8ccefd3873cmr199811946d6.16.1780318098946;
        Mon, 01 Jun 2026 05:48:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.47.224])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea08b749sm92624296d6.19.2026.06.01.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:48:18 -0700 (PDT)
Message-ID: <6a1d7f92.362730bf.3416eb.6c2c@mx.google.com>
Date: Mon, 01 Jun 2026 05:48:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8262898630175347638=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: hci_qca: fix NULL pointer dereferences for non-serdev devices
In-Reply-To: <20260601-fix_none_serdev-v1-1-8d0497ba83b0@oss.qualcomm.com>
References: <20260601-fix_none_serdev-v1-1-8d0497ba83b0@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8262898630175347638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1103979

---Test result---

Test Summary:
CheckPatch                    PASS      1.39 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.64 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      26.00 seconds
CheckAllWarning               PASS      29.06 seconds
CheckSparse                   PASS      27.65 seconds
BuildKernel32                 PASS      25.56 seconds
TestRunnerSetup               PASS      563.62 seconds
IncrementalBuild              PASS      29.33 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: hci_qca: fix NULL pointer dereference in qca_setup() for non-serdev device

1: T1 Title exceeds max length (91>80): "[1/2] Bluetooth: hci_qca: fix NULL pointer dereference in qca_setup() for non-serdev device"
[2/2] Bluetooth: hci_qca: fix NULL pointer dereference in qca_dmp_hdr() for non-serdev device

1: T1 Title exceeds max length (93>80): "[2/2] Bluetooth: hci_qca: fix NULL pointer dereference in qca_dmp_hdr() for non-serdev device"


https://github.com/bluez/bluetooth-next/pull/266

---
Regards,
Linux Bluetooth


--===============8262898630175347638==--
