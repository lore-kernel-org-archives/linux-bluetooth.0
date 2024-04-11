Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F405F873
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850997; cv=none; b=hq6nHqFV+lg7V2a814QSgQui6KcJTOGR67wkLDqG+8n50Kpt4zlRVN0yR4rHhpIXsSQlZeNa7dVA46rBnWbC/AblpdHvFr3v9hPmtSAFA2yQE4ZQxRZCO+GQR9kruUzoN4hTCYPhXM+L2fBEawvlJhim4lmU0vTjZO7BEJMz+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850997; c=relaxed/simple;
	bh=yn/z43lLQlYSFro+VoigIq109abaTHwsZbFtSPPluMY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=V4KiYsDMle9tNDXqss4rBKXfxhtD/JHsekU+9K57BV7pYiugVL0M0KsA3T2r5PxDgBwF0cP5aRBkHYarD7o324ZHzFxPCtmD5Jgrj3IZw/ip+5V1wteBQDWflinp0AQFlqYZbrJ0nykk3O7rgunCQbn8dTk7wfWu54SiLuMACZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bauJCVGs; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bauJCVGs"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ea26393116so27369a34.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712850994; x=1713455794; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xleKWMitFpzeumJ36bh4ufy2LD8AQjS1iZ32Ia4besY=;
        b=bauJCVGsFVwlx+8pX5Oi2Fz0exk8ipa31bjmXBVa+Kwp5W7xdmyiweKTSdSvg62kG1
         qO1BRWNjzXmYnsfXTg0G1qacsJu6IWT+HqkhxlsnVf6u+AAjNVucaFwDA8xQGrIlw1rq
         gLzVFzxXswo8eEgy5xifTyDWHmaPvnQTs8bKCOtAD7haF/sUdt0SMwxpIw1Ujfx1f6t+
         K9t1CsGhXDVi3m+2c4sZgzfTscQgHKFYeL6ydvM2moRvXCME3q8Sps3d2x6l2jlyBT4g
         fvjfpQzUyTh1Oj7rDs3JRvjymrz4SoMfMXJrZEqIn4XHA9xIC0IFN8MVWq1pZ0F7FImQ
         W8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850994; x=1713455794;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xleKWMitFpzeumJ36bh4ufy2LD8AQjS1iZ32Ia4besY=;
        b=v2jZnHItoyILB6Rtlsr2PdthhLpnweUb+cSKL5M4+HcDjcaP/VWhlT0sAaY3aIN5gL
         rvzhKcxCXHjIxsyLkX1vo8d6yai7ycqPZc34foZrOe6dnBEp68Up03xrDHODLQuhvu1a
         8Nd66cZkO+IOllETeTyzGgo7ZSBYSqWjqHcLJLBYrbTPeBIw9BxZ4RU/pXfXpCnF09QN
         d4HdYBjp4k7SmKxk+nj1JT6GQq6uhSa6058aGWBjL+NSjE54V23HQgmw/EwL9VZLZ2OR
         HQAsDSQWkQ3ITKsibiFOcWqzpGjnRMDJglBWQ75jkfMSw+7k581ykvfa/vSeCXMHb8Nz
         T8xg==
X-Gm-Message-State: AOJu0YytNTJgDXnFDwNt3dvhcdR7+zyxaCnw0c8qZ/FcUnoF5io9oWCE
	e5PSGSsSrBQCWbTT9Kem/jr+gfcNrFP7V6aP1Ag5MtFC92HT1jGKsuwrfg==
X-Google-Smtp-Source: AGHT+IHBqNvN0Gy9r7GQEZU+ZG6Uq+4/5pGtsie+T74XYMYt9tf/DVH+k7EAcxzOcktyXvi6DHlqrQ==
X-Received: by 2002:a9d:7457:0:b0:6ea:1365:9fda with SMTP id p23-20020a9d7457000000b006ea13659fdamr2944otk.30.1712850994295;
        Thu, 11 Apr 2024 08:56:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.54.157])
        by smtp.gmail.com with ESMTPSA id a14-20020a05620a124e00b0078d631f35c2sm1183750qkl.24.2024.04.11.08.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:56:34 -0700 (PDT)
Message-ID: <66180832.050a0220.3541e.2815@mx.google.com>
Date: Thu, 11 Apr 2024 08:56:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5599351246336289388=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kovalev@altlinux.org
Subject: RE: [net] Bluetooth: hci_event: fix double hci_conn_drop() when conn->state == BT_CONNECTED
In-Reply-To: <20240411151810.403167-1-kovalev@altlinux.org>
References: <20240411151810.403167-1-kovalev@altlinux.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5599351246336289388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843666

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.38 seconds
CheckAllWarning               PASS      34.43 seconds
CheckSparse                   WARNING   40.40 seconds
CheckSmatch                   FAIL      37.31 seconds
BuildKernel32                 PASS      30.08 seconds
TestRunnerSetup               PASS      542.29 seconds
TestRunner_l2cap-tester       PASS      20.53 seconds
TestRunner_iso-tester         PASS      31.50 seconds
TestRunner_bnep-tester        PASS      4.72 seconds
TestRunner_mgmt-tester        FAIL      116.34 seconds
TestRunner_rfcomm-tester      PASS      7.36 seconds
TestRunner_sco-tester         PASS      15.14 seconds
TestRunner_ioctl-tester       PASS      8.97 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.93 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      29.45 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[net] Bluetooth: hci_event: fix double hci_conn_drop() when conn->state == BT_CONNECTED

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[net] Bluetooth: hci_event: fix double hci_conn_drop() when conn->state == BT_CONNECTED"
69: B3 Line contains hard tab characters (\t): "				hci_conn_timeout+0x16/0x60 [bluetooth]"
71: B3 Line contains hard tab characters (\t): "	rfcomm bnep hci_vhci bluetooth ecdh_generic uinput af_packet"
72: B3 Line contains hard tab characters (\t): "	rfkill joydev hid_generic usbhid hid qrtr intel_rapl_msr"
73: B3 Line contains hard tab characters (\t): "	intel_rapl_common intel_pmc_core kvm_intel nls_utf8 iTCO_wdt"
74: B3 Line contains hard tab characters (\t): "	intel_pmc_bxt iTCO_vendor_support nls_cp866 vfat fat kvm irqbypass"
75: B3 Line contains hard tab characters (\t): "	crct10dif_pclmul crc32_pclmul snd_hda_codec_generic crc32c_intel"
76: B3 Line contains hard tab characters (\t): "	ghash_clmulni_intel ledtrig_audio sha512_ssse3 snd_hda_intel"
77: B3 Line contains hard tab characters (\t): "	sha256_ssse3 sha1_ssse3 snd_intel_dspcfg snd_intel_sdw_acpi"
78: B3 Line contains hard tab characters (\t): "	snd_hda_codec aesni_intel crypto_simd cryptd i2c_i801 snd_hda_core"
79: B3 Line contains hard tab characters (\t): "	psmouse snd_hwdep i2c_smbus xhci_pci pcspkr snd_pcm lpc_ich"
80: B3 Line contains hard tab characters (\t): "	xhci_pci_renesas xhci_hcd tiny_power_button qemu_fw_cfg button"
81: B3 Line contains hard tab characters (\t): "	sch_fq_codel vboxvideo drm_vram_helper drm_ttm_helper ttm vboxsf"
82: B3 Line contains hard tab characters (\t): "	vboxguest snd_seq_midi snd_seq_midi_event snd_seq snd_rawmidi"
83: B3 Line contains hard tab characters (\t): "	snd_seq_device snd_timer snd soundcore msr fuse efi_pstore dm_mod"
84: B3 Line contains hard tab characters (\t): "	ip_tables x_tables autofs4 virtio_gpu virtio_net virtio_dma_buf"
85: B3 Line contains hard tab characters (\t): "	drm_shmem_helper net_failover drm_kms_helper"
87: B3 Line contains hard tab characters (\t): "	virtio_balloon virtio_blk failover ahci libahci libata evdev"
88: B3 Line contains hard tab characters (\t): "	input_leds serio_raw scsi_mod scsi_common virtio_pci"
89: B3 Line contains hard tab characters (\t): "	virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring virtio"
90: B3 Line contains hard tab characters (\t): "	intel_agp intel_gtt"
92: B3 Line contains hard tab characters (\t): "		Not tainted 6.1.85-un-def-alt1 #1"
94: B3 Line contains hard tab characters (\t): "		BIOS 1.16.0-alt1 04/01/2014"
98: B3 Line contains hard tab characters (\t): "		c1 90 0f 1f 44 00 00 8b 87 20 fd ff ff 85 c0 78 07 74 07 c3"
99: B3 Line contains hard tab characters (\t): "		cc cc cc cc <0f> 0b 55 0f b6 87 49 fd ff ff 48 8d af 10 fd"
100: B3 Line contains hard tab characters (\t): "		ff ff 3c 01 74 12 be"
108: B3 Line contains hard tab characters (\t): "						knlGS:0000000000000000"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - FAIL
Desc: Run smatch tool with source
Output:

Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: net/bluetooth/hci_core.o] Error 139
make[4]: *** Deleting file 'net/bluetooth/hci_core.o'
make[3]: *** [scripts/Makefile.build:485: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: net] Error 2
make[2]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bcm203x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bcm203x.o'
make[4]: *** Waiting for unfinished jobs....
Segmentation fault (core dumped)
make[4]: *** [scripts/Makefile.build:244: drivers/bluetooth/bpa10x.o] Error 139
make[4]: *** Deleting file 'drivers/bluetooth/bpa10x.o'
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 488 (99.2%), Failed: 2, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.170 seconds
LL Privacy - Remove Device 4 (Disable Adv)           Timed out    2.410 seconds


---
Regards,
Linux Bluetooth


--===============5599351246336289388==--
