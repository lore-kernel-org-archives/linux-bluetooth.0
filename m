Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE52222AA
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515881; cv=none; b=HDap8gszc+j+PiHIHNCNerEiBx3xQ6jxtFVwFmbBW2sXG6lMtv3SqDHoum/9gcaGcIRnXiSYkUkdJGlkoqjpqa1uQjU9HlLLBaKrQP4v1r6xIVcrnPUffjDyHIAtZ4pU2L9QOy/n3HLQZw3uwBR9W2oSMUTgJEuC/oftrN9Whn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515881; c=relaxed/simple;
	bh=vzhRyNi4uTwC2kFUbSR0Z1Q8+n5zipLGy1tzvdlQOJk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dkZDoA3gLalDW0FAF3TNXbmzbmBnkoS3Sv7BfZF4EeXk2NiTAjG5nQxdyh6TcF0pcvd5XulMPnkDIv5iCjRyG0rAasxX3Zx5bnFRpejZiBxz8rN4jDgH2NJQLbkozjoKeqGwCcIkxfJX1eX5AkNvB65PVucN2U4A39Ra2NTX8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY2U9j23; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY2U9j23"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1c7364550so1048876a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 02:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788515879; x=1789120679; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SAdslIHdo5ag5S21L50lO950nUjH2o2YoBqNWjSkVTo=;
        b=MY2U9j23Dk12aUdlfw02uOAS/vpm4Mersgsy/RMP4gLgBCtuV1GOIEKA9BI/+WaTrl
         AwG6x86qD/+nubfoMn5w8yWEwLGXueuf586zHMkVICwLNvHYTt/WdlbSuWVzFvdRLEZF
         XNO5SOQoPY6VsSSU4a5ihuT2yEBbCZPQACia1FgybboT+qW5m4L7kPxfmDPrME1FmPUU
         z9O9NBOocRx4M5WPRN36AnAxIR/QUPo+hhXkGy08DlfavFINycAg19pZ316FSHeSnd5k
         glXPqjLo9V1C21rG3o4FcCEDydV/GaCEWB721xffI0oP64Zme+TAKSk01fY2ZqDkx2vG
         qTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788515879; x=1789120679;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SAdslIHdo5ag5S21L50lO950nUjH2o2YoBqNWjSkVTo=;
        b=nInGk8DIRziN7Ilq/RvQXtH5nMIlXGIMeg5ZJCdtNw2jaRm0MjTHcbj+54fjOescVR
         jKgCNamgcMg/k5ewyqtLgf5sDQ6i3LK7FaQbhIFRs168MJtT+omcQsnyybytr43cZvJG
         5gfEBXgDC6qhojBcPnmL2L010AuASL/a97np3KhqDNZQVgJNJ0lrartclqxnzWi6MM4r
         S+Np4FOhktPY0g+MGJci/rVbg0O4zrgNILgdDHnc1FEoFZS7wHwMrBYxwGOb6VL7SVvc
         gA0tmvIyy2mkW5r/irO3HtWjAFkLJr8sK7w3o1s35Np2vt7IXs7/lP6ma6zSsO4NHJQW
         C+tg==
X-Gm-Message-State: AFuF++l7DnVKsTw9ZZTOaiuDyye8h2CJCeNMIpPyjojGYkRVmI2sPTcG
	JJxFIEhulL79OlWL9FTXI8+n5D6EcA7cUIjmIfZ3ZBsoF5Ibpoglvpaa1CIZDg==
X-Gm-Gg: AYBFou0Y2/i8xpMPNPVDIayMfkwwz6d5j6eL33lkBYUmCGw+Nk6IeUOZSzp4u3lccZ1
	uZgb5Q+e6oVhY55W2hn2YyXKNiaJigIYATRHiYmaMBpJE3Lkm1Df68cEXENU3G5TmObIARnujAV
	ypAUEZ4mWXoGLYQV+8EVQEmUQ7mAXyDjGm5xBkPk0gHqmH/2o7AnrUHVyb7a9n7VOR32C+GGcR2
	1n2jM4GEtMBcE1RpVX+XE8maPlBDXDfVAyOokERblMxiACO37WNWuE3JezYfaJP1LC1u48vdDro
	LkiDn8DZGc5bLDr4yJb6eOxamoAKG5xi6nmeZcpuAFKS5OHzWBIPphHm0fxcCfyobV7uyAqd4kI
	kcQTaDTDkBZ8cc5y1WsDDIVg1c/tD7JAZPIAJBMnCc5YxN6wRXQ1uRZRBO3crhcZZB8rLaexP3I
	NwGb/LVff9f6ZLTTUdghwXvFoxui2sLAdPR4Pz1u5xHe+hUg7yMr8itoxNJpMdlh9UD9kJ
X-Received: by 2002:a05:6a21:2983:b0:3cc:8f53:26c0 with SMTP id adf61e73a8af0-3da3a03ccf1mr7907684637.17.1788515878886;
        Fri, 04 Sep 2026 02:57:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.167.36])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm2025383eec.4.2026.09.04.02.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 02:57:58 -0700 (PDT)
Message-ID: <6a9a9626.ed3fe150.356201.8101@mx.google.com>
Date: Fri, 04 Sep 2026 02:57:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8985723092435351791=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: [v5,1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
In-Reply-To: <dac8ddf07cb1bb79c70d5a516f0ff7baf41eb462.1788507854.git.liujiajia@kylinos.cn>
References: <dac8ddf07cb1bb79c70d5a516f0ff7baf41eb462.1788507854.git.liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8985723092435351791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157702

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      20.55 seconds
CheckAllWarning               PASS      23.31 seconds
CheckSparse                   PASS      22.83 seconds
BuildKernel32                 PASS      21.10 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      368.88 seconds
IncrementalBuild              PASS      22.09 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/705

---
Regards,
Linux Bluetooth


--===============8985723092435351791==--
