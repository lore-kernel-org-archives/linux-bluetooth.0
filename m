Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3923B2D18
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285043; cv=none; b=LFLUTC6tfIEDr3tIcJOqYDg7zG5GcShLvzRq0Th0mfJ++SfNF8Yo4GNlcLGtUiDzd2n6d9q+1DmjQh+UvZD9GybVEaG2jlgL78c68JQEC4LZESLK5hJyvMXRY6iOCTM+P2gKNkltrtvoCJ8pByHZhjNJ808F8pX6cFAVUQiFcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285043; c=relaxed/simple;
	bh=4l7PtLj2waUDUglDz096oFprGLVSaWjqfASupEobiUQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FlJ3MjAVyq3rRbVP9bUE5oHticHfYUcwNnJflw4saJVjoSQJxcQIepxoq4nUNe6IuO2LhLToBxt1fDYZl6h938CyggrtnWxEAx9eTi1svipbXicFmtd8Ltxcz1ktngiC92ngQOC9xOC/JeWQnr21GGctYPBpQ4/sQydUPdaURXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYMe58Cm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYMe58Cm"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cedda2ce6fso40689705ad.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784285042; x=1784889842; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VOB5dqK0ScXDtyNmnjCs4b/rNjq3w3SuuK50Sy9Xg0o=;
        b=nYMe58Cmy253iujLcJdPZtVTYlK6j1VsCe2hhdQoLIk1l96B2R/wZC1vfB9Osv9BHp
         CXN0Vfj/wvtGcFTGZq9Ly8pO9cUHY5grf/jVc4t0kyWnt/+AeH6Kot/OG26uyrz8PYym
         E9+KK4fodg4ug475VBJs7hYpHd6TggDRc1umXVEiDWZEV0jbhulcM62qt4KRjdvtyr9a
         jM/XxeYIiKj7eiEjhsZW0M44RndmH0TBqixsws2x5qFdMTBZUWYzdkuagsjoi49ECTpn
         WwALlDRtJK2y6P9eU7cvh5QtF76bq+mPuHXHQKIybWb6eoElZITqCf1gvZb9pTFTUEm8
         SQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784285042; x=1784889842;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VOB5dqK0ScXDtyNmnjCs4b/rNjq3w3SuuK50Sy9Xg0o=;
        b=eL4IYnPeMItHkVVMnyFtXE1HwiF1TLpgS1JgRghgS+3QNADrOjLDzeV4P8I3v8Te+r
         6r34cemDWGESP3YIED8eyEJ2gXd/Is8sA0C/6jguSRqIJDdCoBbzB0+WDydsoYQ2Ce8l
         p5+qlXkorRSZLu9hCN0ok2zOSlS6yef3ro+OrtsMZzoaIsDyzwSdQF3ZmcftTn6i6G5v
         fsGP/jxycaQO6vrADV8YAM0NLQxppVWoe5zsNQqNHghmVuQ+7IX3n7wIYCJzDoeCdxCF
         Mqqk0zk0wx7ZuiLOrsUUsdYBQ8+cPcBmuXNjzWnvT8GpJTHZO5KLspatA1NYmjD+vp4A
         qsGg==
X-Gm-Message-State: AOJu0YygxYXcNM6hFPBe8YCMkQoFDTx/QfgBqvXOy4O1q0/IOBW/zgD8
	a9A/Gn+1SyQ4a3zvXYVR9X7wOKeFmIRJza4mlxkRU0btyb1myxqJZdm8Ex96Kw==
X-Gm-Gg: AfdE7clMkaWfpE+kqSyt0AKViSANiG6wYVf0qUxva/cZrBENE9BLKHP6Jx2mrHNNhed
	iPZznl89Ix3MimM3NENisqmyGDcS+EaeRT/Jw9Kb0Wi/mzsgEMEQpdwK3BZ5gS48HTJ977Gre+2
	23pE60gxelarnAxGdd9QVDPST6ZtSFo1FruiAKdioSREv6XiAl5NyiC6zMgd36dGnAJuy2a6iud
	ZHZ5/rXk2m6kj1rl1UcaXbnhczP0WOwUW6T7TnaZyesEfdrMOdzFKEZAP1QCiR8vVlI4FUU/EqU
	9tK47urC5g5DWN8vb382P5N+mJVCol+Ng026EfNSliUU0v9uMGeKx7c3mvL/d55VHpelqUbj65f
	3WbICtmWk0Xa5Gx5HxMSXPu9WERNSRpBFvtl/+RnNAh9vLJzhKygY4A4J6Lc+Y1iyrnV/d5QQ1a
	QgyG58U/tBuA==
X-Received: by 2002:a17:902:c941:b0:2cb:14b3:4cfe with SMTP id d9443c01a7336-2cf34a0774cmr22689665ad.45.1784285041862;
        Fri, 17 Jul 2026 03:44:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.156.141.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347119dfsm8354935ad.56.2026.07.17.03.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 03:44:01 -0700 (PDT)
Message-ID: <6a5a0771.52749c36.3482b9.bbef@mx.google.com>
Date: Fri, 17 Jul 2026 03:44:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8817032192704330898=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260717083936.2923891-2-chris.lu@mediatek.com>
References: <20260717083936.2923891-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8817032192704330898==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1129429

---Test result---

Test Summary:
CheckPatch                    FAIL      4.29 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       FAIL      1.45 seconds
SubjectPrefix                 PASS      0.44 seconds
BuildKernel                   PASS      27.05 seconds
CheckAllWarning               PASS      30.15 seconds
CheckSparse                   PASS      28.77 seconds
BuildKernel32                 PASS      26.82 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      502.67 seconds
IncrementalBuild              PASS      38.23 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v16,1/7] Bluetooth: btmtksdio: Fix SKB handling issues in TX path
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#111: 
Reported-by: Sashiko <sashiko-review@kernel.org>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>

total: 0 errors, 1 warnings, 103 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14693204.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v16,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()

1: T1 Title exceeds max length (87>80): "[v16,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()"
[v16,5/7] Bluetooth: btmtk: Improve BT firmware logging

14: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
15: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
17: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v16,7/7] Bluetooth: btmtk: Add MT7928 support

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


https://github.com/bluez/bluetooth-next/pull/449

---
Regards,
Linux Bluetooth


--===============8817032192704330898==--
