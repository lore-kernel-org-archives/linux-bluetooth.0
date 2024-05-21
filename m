Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF202142E83
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303397; cv=none; b=iO07bZdW7qA3TgCfN/MBiTjJq8Xq6bFUjkFQSTnvvLawFowUS3Y2OJl4SZpEALZ1gaRUWiNmxqlk6mJheRcq5ebMDh7cEI8gwkT4oNlzrzORCqerqmPSzYgPH9eWn2hMh6/CrjvkuSpXHy1rOzVkMp+haT7L0UW1xzc1xcXz7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303397; c=relaxed/simple;
	bh=+nEhBev9eoNnJPMI7BgUvmdGh4rdsvmVaolSGUfDZrk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NIrOz70Z9fbE2VtymfSZcXtzroiByIHva5zpCUHxka6DF3WE1rhsiHLhSiVDHcXFCL7x2PHde5Xl9LXADRq8FVGUP+sAqNOai61aWnuRyj5a8X62AP+8uZ3J0p5JpkTiBE0u66ao/iPcmNv39VGMhOFiURDV8BBC41Gu8x1O5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDK7aFph; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDK7aFph"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-60585faa69fso3090807a12.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716303395; x=1716908195; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=emVv7PKTbfVwwtHz3IQzpAHDH0NYC7np6RYSGCBAR7o=;
        b=bDK7aFphZO5bCr5TpdlL8SxIXaGmAp+CxVdniyHe8VBLwGaCqRy3t8iU+gpCBgGfgX
         uwsuIvbfKg3zuHACtgTG8MorxzR1XoLEW/2S2j39tPBJ2x4M6+kaxIwiAqXOsb6i2CZ8
         OQU23X4QNMMpCL6QfqxjXHVdcf/rpEw1W7gei6HfwqFK6v/11cQAuO10ei0W4h6+MoYI
         28ynEDdqZ16NW8MIV18EDKg2dZb9561cBMHX5hTmTF0mw8MZf0YdMIdvlLTZIsvaGiXR
         9y2xGx2jpn5wI7Nx8Z5ANFqFKzH9p01Jb5P/+DPzK0B7+cSZ8f9fU3ZKoHw1Wlym5b2w
         MZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716303395; x=1716908195;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emVv7PKTbfVwwtHz3IQzpAHDH0NYC7np6RYSGCBAR7o=;
        b=evSOCJ5hle4RC9wkTFPvGKCryonCUL6vpx8Z/QjZ8OS6y2K5/UYc63kHvgJc3Tq8No
         MaeVwOzpfGPgEsFI3KsmPqq3wz+SVX0tZXMi6Nlxxt2m2pBRhfE14eQHjSHYWP791Osm
         7f7j0JzRJs1Kerx4qzqLP1hRYuCnFruhrDun52O3QeESPT6Jkuw+fSTDJghW+H924tDt
         xtt/jC87mKxQtqr8iwFwedm+vO8xvPnSwr2V3C1k+8mX2WBqqH6hx2vm9LmHWDH+zwI1
         IO4U5n+4eP7iN69O2Bq3aG/O7B8jI/f2I8k4FvG6iTdyssv3LHoIXsfTFj6UFxWE+r86
         WaXw==
X-Gm-Message-State: AOJu0YwmzhSzp2UOEfPyIgBRN8NB/qYdjzV0KbnusOCJeiqc2KF8uNz4
	z0GmkArZkw+86fdgVSPCvulUwQyc16kuteKUj5iEyMGXa5DBnn6u5RN/Yw==
X-Google-Smtp-Source: AGHT+IFkRE0cp1V+MSgQi1jFDDHZ1897kg76OURHBGvyI4hdrE2FQ3kyjzLwpKR5s/epd6CSHrDgSw==
X-Received: by 2002:a17:902:a50f:b0:1f3:b38:aaee with SMTP id d9443c01a7336-1f30b38ac34mr34110535ad.24.1716303394816;
        Tue, 21 May 2024 07:56:34 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.187.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fb50915esm44504945ad.217.2024.05.21.07.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:56:34 -0700 (PDT)
Message-ID: <664cb622.170a0220.45e79.af47@mx.google.com>
Date: Tue, 21 May 2024 07:56:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2468408592538222395=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
In-Reply-To: <20240521143521.1568672-1-luiz.dentz@gmail.com>
References: <20240521143521.1568672-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2468408592538222395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854750

---Test result---

Test Summary:
CheckPatch                    PASS      0.70 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      29.69 seconds
CheckAllWarning               PASS      32.80 seconds
CheckSparse                   PASS      37.95 seconds
CheckSmatch                   FAIL      36.20 seconds
BuildKernel32                 PASS      28.97 seconds
TestRunnerSetup               PASS      522.85 seconds
TestRunner_l2cap-tester       PASS      18.20 seconds
TestRunner_iso-tester         PASS      32.42 seconds
TestRunner_bnep-tester        PASS      4.81 seconds
TestRunner_mgmt-tester        PASS      109.52 seconds
TestRunner_rfcomm-tester      PASS      7.41 seconds
TestRunner_sco-tester         PASS      16.32 seconds
TestRunner_ioctl-tester       PASS      7.81 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.84 seconds
TestRunner_userchan-tester    PASS      4.98 seconds
IncrementalBuild              PASS      27.71 seconds

Details
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


---
Regards,
Linux Bluetooth


--===============2468408592538222395==--
