Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD6B10A24
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716194139; cv=none; b=bYDcLjv0OTZa9jdpCvKdREOqO95Vmfla8IhJpLGBttYAzAnLUz6n2XAz/HkwVFAyeOecvqi8Tqa7R2iz0gLKVdKsZSQHIMZ1WdL5igcYzalMTJmxvJgDPbqW6zAvJffzrgULjW/9Ai+15Xqcj/KmPk0aiX3q9MberY2Db7qsB5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716194139; c=relaxed/simple;
	bh=yM79cb20Ojzl5hHQkjFsU0qrYhIUV86+b8xg/zG9ytU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AgjMP9fl2XESpfhw9NNzcRJlm9XxDVUWjEBgcmQ/zVLfGDCS1PUOY2SFvFEtrgyeO89098B7G7ymWiVfzgVmwhtFLCzvU2EWuUVbFo3lx0UUqtVhgYuCf+u9m5xbcQHcXh9N6J0x2ngWmFbPvLruha8p0LqwDisRQyVl2BcftXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/Osygzk; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/Osygzk"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-69b782287f9so7540376d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716194137; x=1716798937; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QMu4coUjOUxCoEy2aU8gh19L2lOpUS06Opsvto4CeD0=;
        b=Q/OsygzkVrp5tB+Wnv4DpZIXwUk/1Gvz3BXLUj+WHd2fnREHalWO4lM/tQd/vpDnzg
         A1KVkV2HLsklQUdvlpRxzAKxXD8oMqQqsQeXRy7HGezZRhrgnyjU4I33TTQdigUZMIY1
         it8WAIF0bYXCIOftGoUb7Nuoup2l62dqZoWFyENmV6+tHw7sooU3hzEut80EPbC8JTq9
         NFK9QSwbW/xgEUgUuW57ZP2X9H4qicZq6m/sKytQ5E+/RelBbqdcRTXBcfGl9auUeT51
         KNHIwK+gPfwfMUrme5uvUZ5zY7DaiVmETYWCCkXhkmhYlSVnRP0fOetiL0IOto024oet
         ZoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716194137; x=1716798937;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMu4coUjOUxCoEy2aU8gh19L2lOpUS06Opsvto4CeD0=;
        b=BlepbwPrScf8gdhm7mQT5BvpQcSQOS93qEyXKlMnFXVsgixPn7UhyDalXNQ64nb/Nq
         Fke0IXANS2UGJ5cNRGvDxzKcU2CQ55Xij0mMufkv6PLFNTW5NkCN1JIdffh1F5j6CGbp
         ijrL4yLBik/fc7H4iljmP7jrylfYN4fthQk1Z5FipZN6H/0kc9RMwUe3oHaiAaxYWn5p
         55jG8J8x6f8qOaL3OnWS7u99Q3+fKjk+nDTi8PXXavcE2X0wXk6eBoHZujNqa07mbY6X
         m/ykBqC5bojcXxRVmOpN/0/e/Qv7RtgYfVizrshxTOR3r5RBjYbC2xacIq9faBP8PW7+
         t/bA==
X-Gm-Message-State: AOJu0Yx55S2r8QtKoox9HY9sbfOxNW//MeBEHYgV9PCHte0AWX+wW3X6
	PDND33lekgQeTp1xArxWCQbqBZRYWVFSBE9LrWOoi+36V0n/32CLXQgr+w==
X-Google-Smtp-Source: AGHT+IHni0sppgD4SfDiaKQ8a/Ku/PmKt1M86E/6Ok5M3FIMrSuJud84vAldqmWaB2oFq4kqwQ/6ew==
X-Received: by 2002:a0c:f40f:0:b0:6ab:2406:8d0e with SMTP id 6a1803df08f44-6ab2406925emr10726806d6.9.1716194136770;
        Mon, 20 May 2024 01:35:36 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.255])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aa3280f16fsm10554836d6.12.2024.05.20.01.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:35:36 -0700 (PDT)
Message-ID: <664b0b58.d40a0220.16ff4.1f2c@mx.google.com>
Date: Mon, 20 May 2024 01:35:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0108234324128092888=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: Bluetooth: btintel_pcie: Fix the error handling path of btintel_pcie_probe()
In-Reply-To: <692b4749f4267436363a5a8840140da8cd8858a1.1716190895.git.christophe.jaillet@wanadoo.fr>
References: <692b4749f4267436363a5a8840140da8cd8858a1.1716190895.git.christophe.jaillet@wanadoo.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0108234324128092888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=854340

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.48 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      29.78 seconds
CheckAllWarning               PASS      32.49 seconds
CheckSparse                   PASS      37.82 seconds
CheckSmatch                   FAIL      34.83 seconds
BuildKernel32                 PASS      28.79 seconds
TestRunnerSetup               PASS      517.74 seconds
TestRunner_l2cap-tester       PASS      18.11 seconds
TestRunner_iso-tester         PASS      28.22 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        PASS      111.80 seconds
TestRunner_rfcomm-tester      PASS      7.30 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      10.97 seconds
TestRunner_mesh-tester        PASS      5.82 seconds
TestRunner_smp-tester         PASS      6.83 seconds
TestRunner_userchan-tester    PASS      4.95 seconds
IncrementalBuild              PASS      28.29 seconds

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
make[3]: *** [scripts/Makefile.build:485: drivers/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:485: drivers] Error 2
make[1]: *** [/github/workspace/src/src/Makefile:1919: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2


---
Regards,
Linux Bluetooth


--===============0108234324128092888==--
