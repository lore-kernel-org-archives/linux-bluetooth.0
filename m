Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8F3803D2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784174514; cv=none; b=XuGeAcyNegD6Iq6p1foUcYSqU2CM/d6iVsrQCqdZvGHOglTZgups70yxINJ1yC7a/rzMTdUF7mZGlG0Xo70GtDK2C1VZevJKgPMscaH1+2fVzFPL+M93g+ZcujPl/QuNUNY3vJjON02hjdnVKZ1nXJMw6guy1LxKsAJ9W3ja1c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784174514; c=relaxed/simple;
	bh=9BK4OBNytowFRwIJ4G7mARVrwJTtU50u72rGgKjBJ8A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=akrtBECm6jtagEee+H3JcNTY/PXU0B/ARBHvghjmShcD/xVdnTXZTZHep+P7siilaXTzCniTFlnjXognZhQ70/Hhn1RfUdQ5DzNqxp9K3B8S12C7KCJJ7Sycc5FINOZ5kLRAcy8QiiTYBYhGUVEc08Z4+p3GnsNq9/Fhjl/kjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4H6fVpz; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4H6fVpz"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9217d13c276so435421185a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 21:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784174511; x=1784779311; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tQ82n71IPdWcWnbm2Vh7Nvz8wAIT9UHS5AAU/cpo4g4=;
        b=b4H6fVpzN98EWEXvHby5e91VIFO5wfiAKwsKLq+utPNPGSlz68EpYIEp10XnM3BGTK
         6djrIM/k3s3mDamCscci7ML0rguR9DGSGKevqF9NMUJhGVzlG41vNjM9LEoxK+SVnGUE
         msjPktcq8Cq7PVrqvuQMyyteR0zTl7OF2A+0iCW7BLRnCxuFnkUewMt17NtYUYFvC91D
         1QDKsurY/3FkX8jjvsN3jzQ1KrYV7Jbkbz+xk6Dg6+B/+2kpTFBuLgja6Z43xi0ZyFyW
         sFh9lfJ2QEOyvYFUK7EOvKLA7Hscokl19bJLVsKkFr5wzSDVt/0oSpZs45Sj8cBaSxEA
         BYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784174511; x=1784779311;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tQ82n71IPdWcWnbm2Vh7Nvz8wAIT9UHS5AAU/cpo4g4=;
        b=OQ9svD6IUEQk2vwakaPr5XiUJk28SIA5oi354HpjNNl1dWH2bhihP+8Az68fC/6U9y
         M+9MyT6PJKYdBdPi6UkWBwvQ+F9zKqYthmezaC2Z5n/s2m/pLKGHxWz6utIbj/uW7lM1
         ejawUTkYcil41/XhXMZrlZF963vfvuLjFqMnh+5oJsH4dqlfp/80o6zTmGcngVTKiX1M
         9K6AICeztP47zyHQUILpoP5zabO+D7qqwWJEB4Aot68gqOSmRuyIt795dlXZBR/lIe0v
         UGM8LBDvPvX+BM9dKd92I+GaR9x3io0V1ZTAycx1OBidHhvQoKivaWboNWEC3aClXy10
         ilvQ==
X-Gm-Message-State: AOJu0YxaZyTTIHAM1PNPQHc4eKYVSCXbM/5czsfR5Gj77OmPP5Z6XxTM
	Dw7tTp43PfXYqOAextfH4jzy84Uzd9xdNOvOTWB6/Gws7uQoWFc8fB8lW4mRtg==
X-Gm-Gg: AfdE7cle/oo6+B4/wr2Hfo0Q/u4DeCvJsxKtoyBwdM8kXgLwixU6CDeMy/T/LhJC3j3
	Q/MqDQvH7a3ZRFBkjNnFfQNTKI1daiBlTtt/OsfRGINesdDM4TKBD8NoygqwZ8279jTX8McAm1g
	HP4MiylrVioTW+Es7bTd1yCF09nv96UJnowWr9DfnzQHh1PsKMwKkqB8N+hxqyxFxG8eDJqD1En
	X08XIJgXQgkrQ4Yww1NyPMaCPYkoUzQ3Y3ddOgWOFb0+QrZ5kdWux2M/pLuH0N5PqRCrDIh7N/v
	BTNeRetUm7Le6sSd4y4jlJw4kcKT7bSFPTyhDIhxA/v1bBFukfZBxwhScmbc5fn843ggHJxeqIb
	z/qHTzmp6HdWBrCJbbqCc3LSbfX7fF2ynYu1D2MrIZO8l+DVlazkGMy5eubpUoxivopw5f/Pmgc
	NwpGqurCsfNEzH7wIJTcg=
X-Received: by 2002:a05:620a:4720:b0:92e:c118:18e0 with SMTP id af79cd13be357-93083de95c5mr1164737585a.87.1784174510950;
        Wed, 15 Jul 2026 21:01:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.240.186.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d30f38sm1817617985a.34.2026.07.15.21.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 21:01:50 -0700 (PDT)
Message-ID: <6a5857ae.64b4ec9b.289c9c.b32a@mx.google.com>
Date: Wed, 15 Jul 2026 21:01:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4509035753615821327=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260716015920.1886719-2-chris.lu@mediatek.com>
References: <20260716015920.1886719-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4509035753615821327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1128465

---Test result---

Test Summary:
CheckPatch                    PASS      5.23 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      2.08 seconds
SubjectPrefix                 PASS      0.76 seconds
BuildKernel                   PASS      27.59 seconds
CheckAllWarning               PASS      30.66 seconds
CheckSparse                   PASS      29.66 seconds
BuildKernel32                 PASS      27.08 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      511.83 seconds
IncrementalBuild              PASS      40.27 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v12,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()

1: T1 Title exceeds max length (87>80): "[v12,2/7] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()"
[v12,4/7] Bluetooth: btmtk: Improve BT firmware logging

14: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
15: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
17: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v12,7/7] Bluetooth: btmtk: Add MT7928 support

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


https://github.com/bluez/bluetooth-next/pull/447

---
Regards,
Linux Bluetooth


--===============4509035753615821327==--
