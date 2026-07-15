Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABAE438474
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117961; cv=none; b=Ze71ZebAFwu6FoOx+2Ju2ep9ye1ywvjBn8JTqiYDAp0v1GrHEQDxL9aUTWa2H+UIOzUpTBCsVZYvR6XUP0SbO+uYjetbytC4bvR9gXKzCMBwj/oMt3a+veRODnFiArBF3wDn7HeKLbkxqaJ0YhYiuPrh3zMvqbKeaftDJFB8t8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117961; c=relaxed/simple;
	bh=XS+HXdcqVya7QYrEOlwGLsZZLvZJ9zGG/aGa/WrwTMw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=B8mKf0Wp/hoFFFPuPbxEtwbwect7pGl4GY8QoSncn4PXe2RiM1iFZ1uRkabSoY7vFSuCuz0QccI72o4UEtXe4T5ysCOyPKuDzMHfa+eNgNuFqThd05dRLgA2JO3BWoW+GabZXTq4/GHNSwE7UID7GEsgGwEPfJgHP5CkaxtPcvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfTBMJss; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfTBMJss"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso1911815a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 05:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784117958; x=1784722758; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6ULlQ5kzbkrS0EPi6GH/5TN5XrJz4reifXy53xmNR3o=;
        b=OfTBMJssSGlbRCOVua2pARcyasUFgAMGcij4nYMbizH94NIIRPaPHVCacrzkyJzb27
         eRRAUMouJ6A2BBGVLOxCWhMe2SDjJXTZ2UeEp6Huqlp8kBSNZzLewsXStdi0SA8udGL1
         /fKrHDISKms3Bo3LZjQbpkSFtlFn8Gf2inT/J72EbgBcLj1dyP1kUWPEdf0dCU5jPD2W
         wykIc1XC26crHUOtr8seQdJZK61sOgvYjlmrt0vpkph1dN9VblkAKJ3TvBtOtgB3jq0M
         Opjr5T1gMXnC9K6+uZO40rnFZ7fdYzXwZAZtyEFoiNXeRSR/tRNYVC/yFIvkL3CxXytI
         Tc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784117958; x=1784722758;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ULlQ5kzbkrS0EPi6GH/5TN5XrJz4reifXy53xmNR3o=;
        b=gAB790fo4Hy8bpt42t9QT06JFT6RdK1wW8X3xsvRry1HJAeQmhHvLm79JJmua7Y5Gv
         zbTCu0rSPYD5MD1JiE5y1ofkheJRWKaE9kDyH2g+vWwPzaaOT7ILH+N+zzkndsEFMCu2
         02ElJzL9UUMxA/z6Aj3I90o/iB+dIObQEnFXohkq/b2Z2q/lGkwIejzCvYqVDA5xfO+1
         Ve5jHUiphYEo1Eo34hqK4QhugArFsicn/Iy6RdxdI7uzXLKVTMzZeS7jE6uvheVaWrZj
         OIrMyWspNZYWK/3GVMfvcs+NcEreWy8JT0YYvsSJyP0Bg6QahgbzIiBFR3UkvLzmLLEe
         fFrw==
X-Gm-Message-State: AOJu0Ywk5MFyimlnvLGj4HXAQ4mamzxctNpuheHXHD7xrwSA7WNq93jw
	NDvjnc6/KLVgV6z6IOBYVzfjhD4IvlmARl04gTZYVx+bvmWwtODin5VGzPHEvA==
X-Gm-Gg: AfdE7clAnMG7G1BRjFKZZqnAYcKv4MFYNPZHDci3gwqW2BKhVaWp1pFKu5u/Erd25k8
	3brXw3J4KuLd653rQRHslXQ0xT1oWRoOSa5YUus54qTLAdV+B/hBqgWPj2bfAEtd7RbYEwmkMQe
	pNmzQyHCkPTKyF4puhg2/l5Yc0VjX5ngNuGgZ7Bj5j+C1m+ofroPrrl2/jksNsYtps3AQ5xHWyC
	Rr/Vb8ymeekyS2ygciSFWtPQoPa3OB/RhLJmHid8lAXH90e1VxoFqibdlzgYfHob2Ug6bIhFDID
	6ilcyh/416JOf/KyKv7rEPT/D4oz+BQjwExLvJwoWkaylp+0Yr2LpT0jqFrzH22Xbz6uXdGktLC
	xfvT7PSmVvHgv4RW02X0J0vlboP2uYsnvepcd1v0H7/xLXFah+mImMTTI0qAQBtGYm0UTQQ++87
	UVlhOkzO3bvQ6Q9lQkaCpL
X-Received: by 2002:a17:90b:590c:b0:37e:1bc4:b6ae with SMTP id 98e67ed59e1d1-38dc73bdd28mr16527861a91.8.1784117958325;
        Wed, 15 Jul 2026 05:19:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.46.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fc28dsm1224572eec.2.2026.07.15.05.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:19:17 -0700 (PDT)
Message-ID: <6a577ac5.7270d2fd.33a4d0.6532@mx.google.com>
Date: Wed, 15 Jul 2026 05:19:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2325619320776751157=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260715112048.1448868-2-chris.lu@mediatek.com>
References: <20260715112048.1448868-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2325619320776751157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1128086

---Test result---

Test Summary:
CheckPatch                    PASS      3.67 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.15 seconds
GitLint                       FAIL      1.35 seconds
SubjectPrefix                 PASS      0.48 seconds
BuildKernel                   PASS      19.87 seconds
CheckAllWarning               PASS      22.18 seconds
CheckSparse                   PASS      21.36 seconds
BuildKernel32                 PASS      21.82 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      365.28 seconds
IncrementalBuild              PASS      34.11 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v11,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()

1: T1 Title exceeds max length (87>80): "[v11,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()"
[v11,3/7] Bluetooth: btmtk: Improve BT firmware logging

14: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
15: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
17: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v11,7/7] Bluetooth: btmtk: Add MT7928 support

28: B1 Line exceeds max length (92>80): "[ 6931.197167] usb 1-3: New USB device found, idVendor=0e8d, idProduct=7935, bcdDevice= 1.00"
33: B1 Line exceeds max length (97>80): "[ 6931.213478] Bluetooth: hci1: Loading CBMCU firmware: mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
34: B1 Line exceeds max length (98>80): "[ 6931.215214] Bluetooth: hci1: CBMCU HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260601T161751+"
36: B1 Line exceeds max length (99>80): "[ 6931.643916] Bluetooth: hci1: Loading BT firmware: mediatek/mt7928/BT_RAM_CODE_MT7935_1_1_hdr.bin"
37: B1 Line exceeds max length (93>80): "[ 6931.650467] Bluetooth: hci1: BT HW ver: 0x7935, SW ver: 0x0000, Build Time: 20260527000816"
39: B1 Line exceeds max length (115>80): "[ 6935.039833] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/443

---
Regards,
Linux Bluetooth


--===============2325619320776751157==--
