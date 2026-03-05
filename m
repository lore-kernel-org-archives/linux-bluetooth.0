Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE11F4174
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Mar 2026 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735694; cv=none; b=bQaHPrWk67V7T0k13mxfxKnOjuxewX64i+4Rr4y+pMT3tzWLo2T/I6Dun2V4Jlkwat3vGYNyn6OJxU67y/qaRxy/U8nhtJTpGT6l9Jb83jDqc1buzbrHTHF3CqabwwzJroaAvApbVPfzszbArx11Sbyoq5wGK1oqnVwPUuIo7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735694; c=relaxed/simple;
	bh=h+mjXukOUyvGyjxv31ZFDJADakHPM2ESkFn0Dk0p0r0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ct2tKL4QElwvzIQphpZVn53esfpznrIn98ZpfpT5HZsdPyJ83RpZ5FUjJy3d9jLWBwSNwfmkLVnmbgG+ZIlB3lV1ghG2gTLg7XNEa2sKQN1jSq8486QsYpA3RSCEeLDohIid/g4fofuEjO0ZFBlvYW+trMbmJs2OLV8A5ZY+/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrTyMl7I; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrTyMl7I"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2bdfd129c52so5114069eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Mar 2026 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772735692; x=1773340492; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TWmutBtLEdXm6+g/GJSa6+mC3ZmNkjLKRE1j7nKfXpU=;
        b=nrTyMl7Ijlr5S7zvc6Pu/td6qK9Kky/nbEUBLljDmP7zM4SQalVjQ16qKtYsIl5dvF
         HhFaqf9xemInGBWzWW7rsCRHMqSdeYwp9C8DMGxDTyL7d0gPXScWIa1665bDl3KCd6aK
         1VOCxEDKrWufPuEHcwx0vj12Iovc8hdl/xQBBCxXy5J8vezLguNllU9VENZ6mJoeWY/w
         N3YnL3oT5HaAQqi0R/PN5+Ls3JBUuysnfyObih8Mg8TFTnTJyGC02/LVS6PzSgeZOXSB
         URhwN4dH7vapoP9Ikt2T1pLr/Kry9bOrQrSh50/N4Nrp9y1ATb/esvTuCUm+CFobXYh8
         yioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735692; x=1773340492;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWmutBtLEdXm6+g/GJSa6+mC3ZmNkjLKRE1j7nKfXpU=;
        b=bzvzGMkMr3ADnitBLOHyLkb0cW+9ggJxkzNmR2chtly4VshWz3v04ePbH+cjKVJb+4
         KHRu5CwZDUhegWCrBSRTIzi30e6vTEXuxJOsIYx6LFXHriVr4tBssrOVSCw9qRQqxd0U
         d/EpcJfUB3J6DWsKJJUnz58OUswGna1ZtqH1DX7YOzi5jS8+FlwMovAa/qtP6hkJCfbY
         CS0YWeW38/MIeqW+eoCTgMhx/+r/bNvUqB8ia4HXE64buX974wiMRddjh1zWpdefTQZq
         svVZ4oMhHXm9K+7wvW3WYmEI7iyWxsDvCdHMR4L9xU5ttMm7jX1NJh8OkBuMlBacruDZ
         WzFQ==
X-Gm-Message-State: AOJu0YyjkzPwHtoH1tACOQFU+KoIr8FOH8fM6laqV5nMQXya3KccEhAo
	dR6SsNAW8zU/2sD6GquHDKRAO8Ra/LossrnyAW/f4xSQx1oNA+5yVfMpCy/GBQ==
X-Gm-Gg: ATEYQzxk8tkILF947Yc0Ilbzq9W/Hlh1DwVvnSKkOt5LpHEYPIZGz5dHY/Gu/gnwG8V
	3MU9Ub6YIcLhO4kSmdoWeILCbqhqimSU0tdHngUB/Au2RCj8oISRqAczHBtkTfbgIFGCMWhFxhX
	Yfyg1XruSu1W4Cg4xpqwhiH29NnyZ2otlEYnw7/EtOKMCCDwbsRt1PbhjISk6Q2h9aNTotMTfi6
	RXvthPyQOIZ84HWUubtztudPIFjvG1wJBQVpIQ8W0aURp05bEzJj7os8l20BZjW173N4fGqUW5A
	SsYDrfeYn8Su75PU+sDM4p/3+uL0FuJ0U2Zh4cYnUNTlVX4bJfk/mM9Vuo50x0mHHE+3MMhD1wy
	QtTrt8N32O5ItA+L9AIvnSowUfH6pnQa37zuYyGZSy+UMTF6pDlDZpQrhz3kNGFWrYd7jByk22v
	I7MtgX4t0yjxB69GWfpe3hcr1qUQKJRA==
X-Received: by 2002:a05:7301:1e82:b0:2b7:b7e7:9025 with SMTP id 5a478bee46e88-2be311b84e1mr2587257eec.31.1772735691420;
        Thu, 05 Mar 2026 10:34:51 -0800 (PST)
Received: from [172.17.0.2] ([57.151.128.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2f5f1f4dsm3842436eec.25.2026.03.05.10.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:34:50 -0800 (PST)
Message-ID: <69a9ccca.050a0220.146dfc.0be1@mx.google.com>
Date: Thu, 05 Mar 2026 10:34:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0755496282686589293=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, floss@jetm.me
Subject: RE: Bluetooth: Add MediaTek MT7927 (MT6639) support
In-Reply-To: <20260305162928.5E8F11EA006C@mailuser.phl.internal>
References: <20260305162928.5E8F11EA006C@mailuser.phl.internal>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0755496282686589293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1062069

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.46 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      26.02 seconds
CheckAllWarning               PASS      28.87 seconds
CheckSparse                   WARNING   32.14 seconds
BuildKernel32                 PASS      25.35 seconds
TestRunnerSetup               PASS      567.94 seconds
TestRunner_l2cap-tester       PASS      29.42 seconds
TestRunner_iso-tester         FAIL      48.73 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      129.49 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         FAIL      14.84 seconds
TestRunner_ioctl-tester       PASS      10.25 seconds
TestRunner_mesh-tester        FAIL      11.52 seconds
TestRunner_smp-tester         PASS      8.58 seconds
TestRunner_userchan-tester    PASS      6.87 seconds
IncrementalBuild              PENDING   0.53 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btmtk.c:1536:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1537:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1538:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1539:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1540:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1540:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1541:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1542:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1543:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1544:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1545:1: error: bad constant expressiondrivers/bluetooth/btmtk.c:1546:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4681:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4682:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4684:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4685:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4687:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4688:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4690:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4691:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4693:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4694:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4695:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4696:1: error: bad constant expressiondrivers/bluetooth/btusb.c:4696:1: error: bad constant expression
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.114 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.819 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0755496282686589293==--
