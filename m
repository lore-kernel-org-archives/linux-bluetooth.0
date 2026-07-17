Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB3305E28
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278329; cv=none; b=N4qyHRHKR/qLDVgNjFLOXbqPVAyqZGWfQT2/vUV6+zS+2RuX8GPYhAtM6Qq8l+HPHJo7NIWGKhZI1DnN93rnLukhJhWTXFHL8VnMEUw0/ZDUP19au4RTWkSE3OLyioCyFxg8ZeOsN3O6lPYCQcIlsWetKVO01fMp2Qe4uyaMhEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278329; c=relaxed/simple;
	bh=U5iX0BZFgSIe/k91UXTh12Jei/DVywgLlF+W7ERaCCo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PgqWYdMfXKBMQFqy91chXSozekn7swCGsK1lZa9IVbe98AZvyY53mjlgoyCRG5KcZffNho2UJI97p5mzomawmrxEuPoiE8tpPtO1m4shsPGRJxsCqzdgPBWDDAWs4kZ7xPdYUHnbB45c737eKzvuNCj+gLe4i8jdUhTMej7BjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jy4nmne0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jy4nmne0"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e50c5d14cso515315085a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784278327; x=1784883127; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q4Nj9UcJHMzWAZ1wPI4oRrKrDqeoeJM8Y04wVO1+hLc=;
        b=jy4nmne0U0/XwQKhv1MZadr7PVuKInDsu6PDcOJ9+ampnm2mJbFqOC1/FOeIbO70Zs
         lOCgxe7vy9lyK3qnVWaGD1UMJ1/dx1a4iB0fuWMTqmCAv2SpThPMSq8hGISDFI8iDIIM
         xJZFFpKzCd0FhEfBBXhb8HkTAIynz3MItwqmpIxsFe2r1ibiiOCUVL8kYuPfMlHw8q8a
         xzf5YdXk+MqRzNvdFUWwCn5SETHCIUm2OVVu4fsIFHHzSqXlXU8QRNvc1PJUQ2mcaEa5
         R4LLswawB/tAMNQvTBOWitVsjHVsssfHamiEGGin6Hb1yrhgkpoU5cE5/EKQ7dt8Ay7S
         qctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784278327; x=1784883127;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q4Nj9UcJHMzWAZ1wPI4oRrKrDqeoeJM8Y04wVO1+hLc=;
        b=DbermQZzu/5LW+6RSdKUSVqhVk/QyfottFzycUhHnLEhOHN8o8GZ1oGXd0v+hprHjs
         qBO3cOZn7WKbrc8ZzamiXKmn+ltvQxHncAXHpVJQpL44ACxVF8cizJtq99+q+aF3c4PM
         i5YV+q4q97E5vTQtgPeHNqYhNNilsaKYoICRnPTtW45qpuVcsvifECgi5ZPZaEwCc4R5
         ExRtx6L+30N1Xng4l/RjU/oXDf3r8vAsMNv8C+V1fjHgk62bVrfFYE//a0vMnA2152Fs
         tWTbNcStNdB4lSj5rJmSRoTZX+rU9j3Nw9yBT7cwKdAys/8tNYNdpKELkT3nODU9pU+w
         Fp/w==
X-Gm-Message-State: AOJu0YyMB63bgO9zTODGjRHx5JmDOTbn0MVdIUv0osQHAMtfYCEXHLRl
	thDStjLZbHt7QklTWcEOZ9yYTI7asiZWs/qfFGtHZSCuyROP0EZddkCh0QnBuA==
X-Gm-Gg: AfdE7cmuskVzFjrOA7AgR0fnNdoW8bTEuFjqqmmF9Xs8+ZsgE8oCMsls58pNNJTWkp5
	wTB5VjrFZ2dDTMTArlx2fcNCkIQiiwbAcxYKxU8HhRJABhO+aKCpR0s2iMkWoXeSRKSiG9G6/L8
	6GgIexFyQXlxQ3IcSvWh3kX/EqLyOewFV8vEOfdxnavtgTFAUk70jVST2mZWGuVknEwEk7Qp2ga
	a5dWnrvxqM5sjaPF8dq6Xz2VNIdpooZRgpIizPs/cawqXIvx/QkJwYNhdQIMAdEhTIFy/ehaPVo
	UHr5P0Sw+BdUemMgMrcLLEvo/dWYvsov+5Yas/CmFoKBMuyzLO78OCMacrsE+x1DTvjyfrnVGHh
	iSUbQOlyjtGWoMy5bUL/m3wACDaoU/pN2SBtrdOtAlGTm0zLfVi/BgVoqJjqt9AARHxQPDCtUoa
	Gw+6Bh2dZN
X-Received: by 2002:a05:620a:4110:b0:92e:551d:f1a6 with SMTP id af79cd13be357-930b3f10ba4mr172258985a.32.1784278327275;
        Fri, 17 Jul 2026 01:52:07 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.47.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b51a2e57sm106217085a.0.2026.07.17.01.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:52:06 -0700 (PDT)
Message-ID: <6a59ed36.2224c765.3a73d1.be9c@mx.google.com>
Date: Fri, 17 Jul 2026 01:52:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5887660640391124676=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260717074207.2869999-2-chris.lu@mediatek.com>
References: <20260717074207.2869999-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5887660640391124676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129376

---Test result---

Test Summary:
CheckPatch                    FAIL      5.55 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       FAIL      2.28 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      26.85 seconds
CheckAllWarning               PASS      29.15 seconds
CheckSparse                   PASS      32.43 seconds
BuildKernel32                 PASS      26.43 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      493.62 seconds
IncrementalBuild              PASS      38.33 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v15,1/7] Bluetooth: btmtksdio: Fix SKB handling issues in TX path
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#104: 
Reported-by: Sashiko <sashiko-review@kernel.org>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>

total: 0 errors, 1 warnings, 70 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14693018.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v15,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()

1: T1 Title exceeds max length (87>80): "[v15,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()"
[v15,5/7] Bluetooth: btmtk: Improve BT firmware logging

14: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
15: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
17: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v15,7/7] Bluetooth: btmtk: Add MT7928 support

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


https://github.com/bluez/bluetooth-next/pull/448

---
Regards,
Linux Bluetooth


--===============5887660640391124676==--
