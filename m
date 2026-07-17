Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606882E091E
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784330844; cv=none; b=baYRSl9WXonWHZf6GKxH2f1JpS/2OpHEwyC2Y3N14R5FPDRQkk2vnXgSqpEum9vqDQxpS/qOPBI9XAuUPERBvEShlG74Tn4M75Fupy7aouiiG03agg3VLTexWsgi1OQ5i0kBlBfYTRV/dLaYyVIpqoitH0oDVV3M9txE1TTVmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784330844; c=relaxed/simple;
	bh=ZvifaZ8YirwexEkP87T1SWNMlyBPW4FSJ/O1jQN/7qw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sq3DNKEpLcmNCU1FzxHsa2SPL5BevP1BIeFvvRyh1ZWMtTRCQeY4s2SiVojhwAhYd3smJ+d9EsR5M+Ivh9ZovSQOyRbQGFtitx8QzTM4iifFlXUmdBrM7PpsS1KYcCddyiBmjf8k4Sb3X3r1IUV2dhP8wYq+b4dH2GItEAdt2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wr9x1ciZ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wr9x1ciZ"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a38d83a480so886005eaf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 16:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784330842; x=1784935642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VW/3PMzR+dEcZpUdl+E9Q9aPYArQcmaRDssouwnsKs8=;
        b=Wr9x1ciZCXQZyke0LywMwKyvXa8XIs1/Rkrc49sUoZp0jTxLjTKRIr4xsXr3eulLd2
         V7iSQXkwizHCXXxmXa2b8UNW0oWdn5EFCNlpYV1INhNjNPDaBiRE3JJydeo/rVASJ1IG
         Xzu/KnE9RMv5lq6AERF6Rc5xkN0ROo1TWAd1isDRZxHkYjIl7tQxTsoghnZAsz196I7A
         2MtYpZKudvHvGWZK8s5wsKZRtJB9xaYcGs5/kVLl5RehArgMqkRKLUzGPu87vxU9Yh3J
         2s2ZSWrSzF2LfzujbzyFw3hMNz2irFbzcr3LLWSXZdekQnVX4OXGG1DLQ/ceJZ9l+0ax
         PFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784330842; x=1784935642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VW/3PMzR+dEcZpUdl+E9Q9aPYArQcmaRDssouwnsKs8=;
        b=diiVbnWZdHpqztV1RgbIG9f91YNapX0UjmZ0KxWBncbUSuDgXFUQwBQJpBvZmxjpx9
         /vyYiaj9iSGG47Dt0+QZFITEerHWAXD+m0eWdHZmnJvT3DivaR1yh31ahwwAEcWooyWj
         896YTVOHXPjbXkC6mTmKX1ULw9EeZBSGik280BQk1ip7Iye0JhRdTxpZQ/456mcuVfdL
         A5S+hGG0PmIzN5L2qcA+KOWUToKduHS8JKMYlWhQmi0+rY4QVHid+IFfsOzwrSAA3blv
         ML/bQLpN5OAF8RnBlxw7QCWBh1x0A8sKE6Y3NSGJR8gW7jl6cX/hPq1B3mAXkqDmkyHL
         txzw==
X-Gm-Message-State: AOJu0YzOPS2poIcLBHHCqBPFCOnj/EMgLXQFSjAf+PJ2Fhul+6hxFDVW
	VWvRLCGx98i1MMnYQd1HTIuKQeJPQ1sgFq0ezsLMLqtQ+HVb4FXkLWz35edTpA==
X-Gm-Gg: AfdE7cmvlNOs0/kd++TYAYQD9gYPPfTD7C7Dig2RCXB2KCdehECyvBaHXl65lD1xqUg
	qzggac5ASANVohSSr8HCVRQoVWKmazrU8TtJtf+os1X037G/J5gWx5J5B0WtrOQY7kSRMm89oHN
	cYct5X7mqXl3MBWiT6jPB0+f1uvjT6cd7YJA+NGko9o6c73EWmFw+3HxCUi08O/6dlg/3uI2NWu
	H7jBE4qsFcrg43wRvUhy4jfXHl4UfrVKffNQTu690z0a+v8P0+w5M/1gpBadXd82OW6UiVQ2Gqn
	YOFLYt61l8Qm1f1vMVx/7pKWgV3uP7SAcDUEzy6nY7hu/pQwkNTuOYJqVGeTw9zf5sHW7eZ3OJB
	geSuFXzwa+EoJy3zhEJ0Hld7rxo/3P1eTb862Yh7LrQdMZPEEy1CWhZGnoppzkaNapqVd8f6BSK
	L/jYOcJELVpJwQfqj9BQ==
X-Received: by 2002:a05:6820:1c9d:b0:6a1:3e6b:25b7 with SMTP id 006d021491bc7-6a51d5704d9mr1993854eaf.8.1784330841898;
        Fri, 17 Jul 2026 16:27:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.52.244])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a516c03f36sm2388714eaf.7.2026.07.17.16.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 16:27:21 -0700 (PDT)
Message-ID: <6a5aba59.77a0a7d7.350247.22df@mx.google.com>
Date: Fri, 17 Jul 2026 16:27:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8109106077256994754=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: Replace HCI_VENDOR_PKT usages with HCI_EV_VENDOR
In-Reply-To: <20260717-fix_vendor-v1-1-f22263c1175b@oss.qualcomm.com>
References: <20260717-fix_vendor-v1-1-f22263c1175b@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8109106077256994754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129860

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
VerifyFixes                   PASS      0.15 seconds
VerifySignedoff               PASS      0.20 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.30 seconds
BuildKernel                   PASS      24.91 seconds
CheckAllWarning               PASS      27.22 seconds
CheckSparse                   PASS      26.01 seconds
BuildKernel32                 PASS      23.86 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      453.70 seconds
IncrementalBuild              PASS      28.93 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/452

---
Regards,
Linux Bluetooth


--===============8109106077256994754==--
