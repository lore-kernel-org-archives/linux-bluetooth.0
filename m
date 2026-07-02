Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50293D4101
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980491; cv=none; b=u01fU+gfBafrT+sDYICB029foYcXVgk+ubBZdpo1Bj01g2ICLm8cDS7V3o9PzjlID/WRMqGRGJXGhCtUcMsTDAlFWuxT3nORBorRtSpC2/nj/8ANVj87lghvYyIBf0WFn22tYbfsfGCL+zpMPjD9pa5vkDO5aooZr6Mthr9/H30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980491; c=relaxed/simple;
	bh=Kc261p59WWL2ZgVDFZrofMS1apjxCFUT2o62hQCyUBc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K8lJ0Yo/Z3BjI1Bt2Rzupqis0dblKJAc0iV8265+n+2nGpRh1uRnfjDE0P1cejuq2TPmTFVqvuC9LeLw7yyCF7//r6fHy7jZaWZVNVn6s7NiScbrMhN2qxdwaQKofoVTpq2+bISlxxL6rgr+DAMtRiVHa2R/1SpMrR+FJ6XtRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeoDUwwv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeoDUwwv"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so954545a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 01:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782980489; x=1783585289; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/yXY2Yw5l8rSnd+sBEtTZABJ7fEV8DRgHhuMy7Xh/hY=;
        b=MeoDUwwvDsp3a3CYfEgtz40aWTMEyxFiyxVM10r43lhVcluRJGWwwU7eb4NSSojLVX
         /tFkscSNK91uRrZhU8FzhleDRLA1zImFFKUpM2cAjeBmViqA1Ej1vHwNFhiD8xnwmTXo
         dL/Xhyd9RFjcVFqhXzB7h1GdiDS9Pg9tIFRMVbGka+XIzJkEYK6AiUDVRNTbDyjXu4Nl
         SerP1TMAdYRa6j6rWgvG4wQ6REPHMX0J5AV8VSQnhkJA4BfvjbV2iHnQwuh8rt+cp0nE
         jZwzkhRtyxY9rSfrf6ialoO2be3SC3Kdl36aqePGDyzBx7NKnRZQ9Y87nOo8RoOWix1d
         RO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782980489; x=1783585289;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yXY2Yw5l8rSnd+sBEtTZABJ7fEV8DRgHhuMy7Xh/hY=;
        b=AlNEOZZQ8gZUrASrcP7SorsJhzBYj2sMlvy2EyTlIV+SmX6AIJUwV/lhhrZq3KmMsf
         aTaOq5R1DveCDt/Kj2wmts+TYRZP3YXFsGk+OBbwSHNdqon8uq6ozQDN3D2JUGvx4CVz
         kSCV70XKDjr0ggoazVTwZOnr/Bp7YrCqwUUltlqkgUcxUjSIQALHGs17cSMzBT42YcMd
         LfeDbkcFjfPcYAHQ4iBYGAGcl5PGYU1UWIVOKW0f5LpHyf1ShUCvlkYhd/fAU01H8JOJ
         uXi3BGKJqJMoZeIaWetzf9f1aVNM4klFhXK3fHOeIypHkN8l8Id8jXEWzEVrkmc9DmEb
         s7ow==
X-Gm-Message-State: AOJu0YzkVtOyxQe4bOgb011Jc/kgGDSAuEumfmsHgHO2OSTNONN8dhuK
	DDAUyZCaQrv9hF4Zwf48De2W0Y06u5ZZ44RrISyoCbsqyo4TmxDtxu3g1qdclQ==
X-Gm-Gg: AfdE7cmAIbd0HRYgs7o/NPn5ZA9GEwHrA1O86KArz5aT5+/Z2TjRZ2YcCfffrgTVF6Y
	DmchLUZHk+s1FBjzNtaCDjjsIDj2eXj2svyvVH5GvA26iUU5/9cq1/5KZBn/1DUgg2fYNMfJu1Q
	nBYZSFxhubGgJSRtD1/GMNZpivohQ8uEkvLoA/CODkyNIJ613qJpeC4uD77QNK/5I8P5KN0yffC
	vpjPp7X3fOc/ZmISUzRWbQFySjOgyfja3o7FIvE/nvDxaTYPKBeqXlkj6HRgcjaoFGxz+ZV2HH7
	/AY2M/j6T1EV48eBqdRMDtPO66XKM0Vey7EtDzfOIN5lWGeFCFkRJ07DTeH6UJu/wXf8PC0rFB/
	rDfGbFyZ38DAemFvHZqXexmsk5omT4nkCMXfZzFkNR6s7UAaV696nBaJSIZMgT/Lgd51dx+SRT1
	7JgeUEIARzIbvv6eUzFSs=
X-Received: by 2002:a05:6a21:4e03:b0:3bf:a26e:3dbc with SMTP id adf61e73a8af0-3bfed1e3000mr6737291637.19.1782980488716;
        Thu, 02 Jul 2026 01:21:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.53.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc544sm7466882eec.25.2026.07.02.01.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:21:28 -0700 (PDT)
Message-ID: <6a461f88.6cfa33d2.19518c.b2d7@mx.google.com>
Date: Thu, 02 Jul 2026 01:21:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7674534491040893934=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260702072840.1712057-2-chris.lu@mediatek.com>
References: <20260702072840.1712057-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7674534491040893934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1120276

---Test result---

Test Summary:
CheckPatch                    PASS      3.49 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       FAIL      1.17 seconds
SubjectPrefix                 PASS      0.38 seconds
BuildKernel                   PASS      27.62 seconds
CheckAllWarning               PASS      30.50 seconds
CheckSparse                   PASS      29.88 seconds
BuildKernel32                 PASS      27.67 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      514.48 seconds
IncrementalBuild              PASS      58.26 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v8,1/5] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()

1: T1 Title exceeds max length (86>80): "[v8,1/5] Bluetooth: btmtk: Add firmware size validation in btmtk_setup_firmware_79xx()"
[v8,4/5] Bluetooth: btmtk: Improve BT firmware logging

14: B1 Line exceeds max length (92>80): "[  212.878783] Bluetooth: hci1: Loading BT firmware: mediatek/BT_RAM_CODE_MT7922_1_1_hdr.bin"
15: B1 Line exceeds max length (93>80): "[  212.889614] Bluetooth: hci1: BT HW ver: 0x7922, SW ver: 0x008a, Build Time: 20260224103448"
17: B1 Line exceeds max length (115>80): "[  216.048890] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported."
[v8,5/5] Bluetooth: btmtk: Add MT7928 support

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


https://github.com/bluez/bluetooth-next/pull/384

---
Regards,
Linux Bluetooth


--===============7674534491040893934==--
