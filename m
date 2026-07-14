Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1B480DE0
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040537; cv=none; b=EAbkP090LrOj13PMvGoWwj7dXfpTPjGgKSpAS+roHP9gd1buWzQxzWlqrEtJTSmn9geA2+0r6a2x36lX+WvVPVD7r7EdkJvCnkr6TmwRrtchj438dIpJUx6Rxp6L4SKKQ8c78AsjnnS1L6al8iqEccwi1NLKN8ZN6ugrDRga0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040537; c=relaxed/simple;
	bh=Ou/wdLv5TDcLxMxH8bSiRviFZm5KITwABLPSbnCK/Oo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ovEogFbSVSfXzLkOJuaqRRNNdtiKEgVuftWAijPAI7ouePJ7fddAUzOa5DmnxuOEtnpJxO1haUEylOwTeL5XNYVQMHbd7BQkmz7gy5X8vuoKz6nPGy6ulaAB8gP2/GTO9nDcJ1cGSlMg1qzxp3YLLKwcx55g/stTu88+94jWQr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BR+sAJTc; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BR+sAJTc"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ff88549786so52982526d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040529; x=1784645329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rxG4VLaCfw9tkl5PzCfhs1IJ+RS+vshziZ64Ri+37eY=;
        b=BR+sAJTcNIXkHA9+oSrE9/ufnS8btsn84n9piA7F3S16CR93+dEr4DyYWj1M4GjhLe
         MKfrtCEwBN5rsdxy6bszF9zgzEf+1CIsTnK6Mwm8i2ubtpFdVVuvgwhn+Ucz69AhHxWn
         DsIYebmPOthpCjYCuBBY5HC4FLT0YQnbuYsOpsfVlT3Rjb9TqRt36hFy9s0VLPrHXV2y
         obv2Ov0KibZ1QgbrF/0xcba5ytisNMSokqEvVAZwQV4a8lZ2ZS8LS4xpnYu889zzpyDg
         APSUxkBnUgn9yxQebvc3K1qKownoOI6bCAfr/NhXt5Qi7D2pDDbWZPx4Z01gjm9zUgfs
         8pRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040529; x=1784645329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rxG4VLaCfw9tkl5PzCfhs1IJ+RS+vshziZ64Ri+37eY=;
        b=MePvXnxAR8PvW6aFQcfyDfPh1cFqShPOwqkCdwfbb4sRzm9Rb/NCNkusaO1ngGwmlI
         as5Q6lb5R9o7vXtvVm+I8MLA+wTCKBf0X8UDgf14MhHIy+nWZIScAwSW7/bXKbN6uotV
         d9qOuyj2gwAFoLNYHFT8S6qVa08iFQ85Nr/xbxzFtl01ZBp8rRTotInbi+xHZbNF2P5l
         VFqATy3rRRjLTDSvkcromdnajnTiDN7cRYUYVPDmVFm6Qjr7s898bi2Ne4SMSQZ8rPj3
         VHZwLMgxwgWtwBAW2rug0egj2ukHMt1UBcM/cLz4z2mPqfxIJuWCFiJ+8j+BwrztgC/p
         dyhA==
X-Gm-Message-State: AOJu0YzNcE0hu0J1aSK0EDh/jndk/4v+N2hrmAklNj9+2uTo9K7WsYu1
	+w1C5uuvJlsTNS5IZM2aY7iWecDq7p4g2jUYEcUKXaKb+6qwKi3D76ZdMxegBw==
X-Gm-Gg: AfdE7ckV1T1mYL74YHOC7pPQ4rGdu0p9IzZGpyDtYgXoRke9WoWXCkfQo0+XnqjIvJx
	reejx1yuVr+iDhzXxaeLs7mLWz58zrbHjQpoFMfe1HyeqtZS40JSs0c3RKVPUIN0GCaemOCJcSz
	i5c7ahQPVkzWI4AdmpVXZ7ygSble0SzsXxyYl2UCfRpLbcu7WV2jhw1kO+Qf4i/4ZkzN0S9zcMF
	/jR2qn7PyGoD/7/kLSW5WOhHgERvopl/bYI8o3q+A66cDz1vZRGJ0/rnai2rw1jaYx1cLHvltFp
	wAyKk85b8U5tKnERRHZBOh1RBCpnoFf52RdgscQtCmrevtVlyJDuLofjuOQwft7ZJn0qGsvTeCW
	nxFsQhqA4VKlGiYWrJqGm53rA74U7Fq3sWY5Vh1GkLBQr68hzwpS1Q+xL47JMWzJSzrxs0tfrL5
	Kx4aUP0atiZb+GSxNblTcIrtSAF+e6RBo=
X-Received: by 2002:a05:6214:2f93:b0:8fd:6e22:c7ec with SMTP id 6a1803df08f44-90402e5d7b2mr162338976d6.61.1784040528624;
        Tue, 14 Jul 2026 07:48:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.198.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm171403176d6.29.2026.07.14.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:48:48 -0700 (PDT)
Message-ID: <6a564c50.63a458f8.2b5973.a6a4@mx.google.com>
Date: Tue, 14 Jul 2026 07:48:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2948033264706890305=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260714123314.814333-2-chris.lu@mediatek.com>
References: <20260714123314.814333-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2948033264706890305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1127419

---Test result---

Test Summary:
CheckPatch                    PASS      5.68 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       FAIL      2.34 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      27.37 seconds
CheckAllWarning               PASS      30.18 seconds
CheckSparse                   PASS      29.83 seconds
BuildKernel32                 PASS      27.06 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      507.71 seconds
IncrementalBuild              PASS      41.14 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v10,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()

1: T1 Title exceeds max length (87>80): "[v10,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()"
[v10,6/7] Bluetooth: btmtk: Improve BT firmware logging

14: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
15: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
17: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v10,7/7] Bluetooth: btmtk: Add MT7928 support

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


https://github.com/bluez/bluetooth-next/pull/437

---
Regards,
Linux Bluetooth


--===============2948033264706890305==--
