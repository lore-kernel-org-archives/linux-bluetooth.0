Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E7407CCD
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jul 2026 09:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502285; cv=none; b=KvO3vSwv+IqWI7uYIxXZAwM53JkEmfN5P4VLQGPGBnDiVlzswD9+0v/NCDEE1rPllmUJwF9tWe54PPBZhhmp031HxigRhfOCXJEn+XGmMoxq2cZmG37mc8xnPyh+V5V6UQ69jdEqnX3ztcnqa9UjUXb1LPTI9/HQuZMa0EKQ28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502285; c=relaxed/simple;
	bh=G1267up9HlfqHdwsDafvMiqI/2y1OFszjvlEpXJWdM0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LZ3RuN/VpEhMRbyYUENblVEIGrc9zonRtkJy9R+Xavo7Hu141YWfo63ng+Iz8629MhdP/vM8LwcQfxqaFJsq0YcK7SA5RRsLwMybkTLEJQ98VNFiJoDs0SuvOEEzXe31NxAB4Iw6wR8wWVyF4ImSZfzokkcATXHP5UTB1vpdF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkhpXRrV; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkhpXRrV"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0c68aa31so2683931cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jul 2026 02:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783502283; x=1784107083; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jbIlpCjgFyFyepwcYx/piF4CFKvDU9KhD2KdSj6iX+w=;
        b=NkhpXRrVazCUb7yhKPDBkgIgtfyIh2KNe9Wf2gYwf4B8dr2arT7uG+R+4pyim40/YQ
         WZrScs/9rI/W2VRtxyv7dxCWMvzc1ECsYHaCcsnjMnfLfrdWn4zvWtSIfMduXTcaYIge
         igeI2I259RpN0DTdnbjO9tM8rVvBfnphEIPiPVwugipgTiQY3T0ldb8C9YWBN57xYidV
         yU/S3RJRyrjp9wmftpO3JC/1mPsBTBtaJJvlcpDa8wJUDLiSSSj6YylGHvy5ZuC/YxF5
         aRsKkJ7E/F9xAQt6gaxCtrzDrARiyTeuOATNx4spYByTmxLrWuh/Mp39dHk4psFQesVR
         AygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783502283; x=1784107083;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jbIlpCjgFyFyepwcYx/piF4CFKvDU9KhD2KdSj6iX+w=;
        b=aAlu8NOAGATc5+vNrobCEWbrcYTys18wKWEpp1x90ZUgFMwAtFS023lKOxPzSzSbN5
         zrErOZCzqa/RxZ5zgTf09lLZPflKOca9c7Hqf1j4hkwQH9nJIHynBnNz6uYX6Nnv7uj7
         TYmVrhtMo7M4HIwx51JBp/9Egsk6s+pCjjXv+gaENmBELmS235dXvyRnRBbrydWw2EXj
         lu8nGa9yDOHzfRAu+fgctdEOIB69SqTpUz3W/yjar4jKksh6sv6gbmiPZ/VsEdxE5+pm
         0hbDfV2gshoaBA5/eJEAEZZgYt1Og8vMqQftze+j6vmpPL9B3iKVMG5zdm7HExUYJURZ
         LUdQ==
X-Gm-Message-State: AOJu0Yz//nD9AXjc6j3nn4pUPC7fbSPXKByJE2itGbYWBiVifqpeLB6a
	1j3Nz9104uCuds6BVrUNT3Hxl3jPBEYTct+s+JqOF/+VEQQkCQiRw1anHYa7gg==
X-Gm-Gg: AfdE7ckGecJXwkjJKp8NDjFtZMgOtw98I2eN784xoG3Aw1g80qZltZQm1/8NS1yGL1W
	utH87JY5JgOLTLUXCd/MUP49kXrgEyFQXzfcOjCkbr3sPgwvVP+ZxG0N6qRNt3NVqCfWb8+1fa+
	0s0MEmvr2np84Zzdtzp8H7YB5bYiJDBqKWz5jtaq/gC1/WAjMP+/+z4Je66JiofLOmTrac9v3E6
	5PCpEz/Xz+xzaaz571tTH2QJR1BSPtM6ql9IWvk1pMKC4is6Q8UZqtpOZsTpN9t4Jlibmt9gQQI
	tGzyjQ3aMfRy1gAbmr6A+waofyfUnafs7LVrFRQailbannQUofS8xEOs9o2cjzq/ZDZdSjBFQRl
	pXJCz0vEitvl7aE1Dn4z9ktDc2qA4rXYSavNTo/71K7g07qaPvr93V/9UGskiRxZBlzBLVQjWJH
	nP3BIoU6iSE/CtyizfUfFdX+nkkNMDjm+u
X-Received: by 2002:a05:622a:58cd:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51c8b2bdfecmr17281941cf.6.1783502282715;
        Wed, 08 Jul 2026 02:18:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.125.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9b1c4sm180219466d6.48.2026.07.08.02.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:18:02 -0700 (PDT)
Message-ID: <6a4e15ca.46adc49a.f92fe.10b7@mx.google.com>
Date: Wed, 08 Jul 2026 02:18:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5050458006951183472=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, xiuzhuo.shang@oss.qualcomm.com
Subject: RE: [v2] Bluetooth: MGMT: Fix discovery state race against cmd_sync worker
In-Reply-To: <20260708062009.3047447-1-xiuzhuo.shang@oss.qualcomm.com>
References: <20260708062009.3047447-1-xiuzhuo.shang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5050458006951183472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1123569

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.26 seconds
CheckAllWarning               PASS      28.82 seconds
CheckSparse                   PASS      27.61 seconds
BuildKernel32                 PASS      25.34 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      486.94 seconds
TestRunner_mgmt-tester        FAIL      204.24 seconds
TestRunner_mesh-tester        FAIL      24.96 seconds
IncrementalBuild              PASS      24.46 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: MGMT: Fix discovery state race against cmd_sync worker

59: B1 Line exceeds max length (95>80): "   [PATCH v1] Bluetooth: MGMT: Fix discovery state race against cmd_sync worker - Xiuzhuo Shang"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.234 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.045 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds


https://github.com/bluez/bluetooth-next/pull/409

---
Regards,
Linux Bluetooth


--===============5050458006951183472==--
