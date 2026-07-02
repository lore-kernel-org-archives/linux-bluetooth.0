Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123143E00B5
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989486; cv=none; b=UMaxgNAbwGn/qVej/NKpaK1pCE//d6ASYc0cjOlLm8t1WqSNsPjbBAakGcBKar6R7znnB0W891LYiByxUvXuw9+bf0T8IY9VKWhZym7dF/O342LtSfRBA0IJVogbua3XtcO9q8u4hKXh4yWVvF1QxP8AUJ0/XwIN+y/UVjYASN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989486; c=relaxed/simple;
	bh=470pBquDzBYNHibNiPSjSckPy5Srf1mLMFvLxPxaJRQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Citm847FlRK+6I6aGJ7AiJtIFbEc5RE08PvrhbljgH/I18KiYzUeKps/q8MpEaDwXsNnfitx28Yx4vWf8A3+WPo1nxC2F8imFUNERgcmESLFhIc8vifkRZEEeHuwiYbTRA0pcQhJ59PxRTzy6usFtOJ6u6k0x4BKjnLnTFonYPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYY5+sAV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYY5+sAV"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so842181a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782989483; x=1783594283; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BuDyvbf1sEaxczRAtAObiDK0Dd67qWrfNTqQ2Fhy+1U=;
        b=qYY5+sAVuNKDP3NwGjuwqieqKSguLqAU8xp6zInboMbsiUXcpqiL69DqjOsXURatL1
         Ugbr60R+djYsg2Zyoav3wUF6aS0fv2CpWhH415ynZRt4casmGyrS4Y1MEn+INrCqNjZc
         RhP+FBg8FqYaeOKbXXPFji8+aMgMNVN3usVYlETTKiM2D6vb6wRdxKLSjLyKnPSa94OC
         22h8L7tDVmJn2GItvyZeKhe2YN1wAelORCfSJbYb875s5rK+kykZ5ONd3pyFtDuMQ5Mc
         jZlAtfXJyjOzS4mU1nNnqXt6Vca5179CnzjXz98Te/qiqLKpPXQfMXs/SpnEJY5sJEPS
         l5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989483; x=1783594283;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BuDyvbf1sEaxczRAtAObiDK0Dd67qWrfNTqQ2Fhy+1U=;
        b=NOCwiZcjMK06Tow9PcBDjvog+jwamRm9CZSr0kutcLs0XkNOgNnTf38C62ca7Ca5Dt
         NgHAfkpIWZaXv1Za24iW6TFDKDTMw6xgJrkppfTmrcJhnB+vWdDgcMUp9I1AtR+N2MOV
         /1cZ5ce6/x2W/7PyPuNwokAlmN9thOV1afRUq2BH5LiR77+3YfThmqtS1/UJpqlixX3B
         glGVHwJ59WKM14ZDmWDrk15JR5MG3SNWPMcRI4Fq1mvrOj/mISxosHcdKg6PpPSO2PTu
         BelbYeWoLIkYNuec1u1zUuwyj6cIKNW8uVRAZn/gAzDQTp4PPEfh4A+teFdNQxEFZy7a
         wi3Q==
X-Gm-Message-State: AOJu0YwQaaoVf5KjlRNHO+U+l7h0pJD/pUnobCDo4wIvmoJM7l0AozTo
	fKcrorXHGmxHcBCPKN3RiYm99GoG00YSHlFns5xjfHj73sAaOYZwEOG6v4Upyw==
X-Gm-Gg: AfdE7cm9dGnNPScYlzfxLHtABKD0m03tuCb/z1lkB412fdZynBXiBfV03NycvGfx6Hs
	8ch4tNIrp4Aei1yTy/VltNwpL8bQCPCypW797n3vS9XFels/smGduhoBR6IR8m3J+rhiqwpWFrG
	0B3b73wlfX5IdBypdIuXH89akH6iLBd60aHVAvT/cTgXekzkm/jy4bXZoGFIQK5oZNPqmuOwFXU
	6Ae/LPllA/1o5h6V42i2QlGW2Nd+O+4MGWJYP644Wy+JVG56H2hsp0sTCXU5WWy4tNMUaRrUyEn
	/n3yajyOj2k9scT/5LYFAG46rw5IcNu2ohhArNWEiLznlDau/rcToyEZ6Ma2VnxQsHT4noHIRjh
	gcjkazdZG3/FnNjRg+m9u6vcy4sV8n4HMekjahBn8HvnqOCs+v0QbFw0mqv4AQ2WMu1l1IB6Hyk
	XMqNq5MUyruNmRGRmIWaAXl+Ccpp3A4w==
X-Received: by 2002:a05:6a20:d808:b0:3bf:b228:10ae with SMTP id adf61e73a8af0-3bff402bcd9mr5828945637.5.1782989482952;
        Thu, 02 Jul 2026 03:51:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.163.32.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc3ea61sm8437862eec.30.2026.07.02.03.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:51:22 -0700 (PDT)
Message-ID: <6a4642aa.6c8668f2.74a35.6f8b@mx.google.com>
Date: Thu, 02 Jul 2026 03:51:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1980052525489057280=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260702101437.1787800-2-chris.lu@mediatek.com>
References: <20260702101437.1787800-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1980052525489057280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120412

---Test result---

Test Summary:
CheckPatch                    PASS      3.74 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      1.38 seconds
SubjectPrefix                 PASS      0.46 seconds
BuildKernel                   PASS      24.66 seconds
CheckAllWarning               PASS      27.56 seconds
CheckSparse                   PASS      26.65 seconds
BuildKernel32                 PASS      27.46 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.97 seconds
IncrementalBuild              PASS      32.89 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v9,1/6] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()

1: T1 Title exceeds max length (86>80): "[v9,1/6] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()"
[v9,5/6] Bluetooth: btmtk: Improve BT firmware logging

14: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
15: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
17: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v9,6/6] Bluetooth: btmtk: Add MT7928 support

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


https://github.com/bluez/bluetooth-next/pull/385

---
Regards,
Linux Bluetooth


--===============1980052525489057280==--
