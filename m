Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B414EC4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2024 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966023; cv=none; b=Do4pYxDBNoAnCzTjbNJUUzg7LdndbkATMqfGhVhXJ91CaNNPcAiQFpAMAyjEDHPeDI3pyhWycyOgiJmYDewOqme/KhodpxFtFn5alv7ZAiahwLMNTrHhNq10ClZW50K/xFSYbB7ZXiXuCCpmL2EdE9wpm6xtb14Hcc9BH8S3Moo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966023; c=relaxed/simple;
	bh=E/V5Iu8cgTRqo+gvoaIU1thup31/ux/xTIEGUvDWtUk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vd4mlW6u0qnDOJaZ7CFUyWfkQdpX2hlskotvdrq8LUrLL8XcRpDAuxeV7DXfHnllGo0JqwjFjJwOplX+VqWjxLqjJcs4ZeEQfn8u7II728uqCzw4VLkjjFIX21viX7ihJliXBLGdxCS08bgHt5q7C9/7Fq7r8OhOFpCstY0Hhxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp5+lUXI; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp5+lUXI"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6ad74e5afeaso3330026d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2024 00:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716966021; x=1717570821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ys2hzVeAcHYIF7tC7vnLO8VCbW4738d9bMtfZ2W8Fdk=;
        b=Dp5+lUXI27Pw7/p1IhofcSIt9CUVdExpeHTuDIi5NiiNTvDYaH9qOVgRjbW3/qE3wP
         WYPwQoqhH9rV33pwl1aQpH6mzx+FM6yXtbpAGQwbOeqoyXSN65ZNHSRHn1PT1EcJHyd2
         UtQ83C1iL6SrYs0eKp0lNouTAiKwpsuVNJBFr/nCoFvRdU3XMGMk088rrfADMjoW+K5L
         JmA/G4bwdviE3XC+5Kc0sE29wXqakVd3339OOnmVZJmIBDN3jIzU1xUsiVa1UEaPYvGF
         AC9T1vcpKWd1bxFanxxZaHmDWJJqicig/ugF8U89BwOJpOzgaUOwxt4CpkmbY50ikzBe
         IU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716966021; x=1717570821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ys2hzVeAcHYIF7tC7vnLO8VCbW4738d9bMtfZ2W8Fdk=;
        b=ugVwD3W3XJInkZjdVRryPu9+ipNsbwC5pa3ZY/zYT1EmWwWksz/z7qupt6LYSVMXGY
         W/U1aVw+4N2MRGGYZ+vpnX0IlUSGAGoelMteZMApWqmG6Y3g2pOimizNysfZ+hMnFMfm
         p+3zIPL3DhUcc3pIxY0wTlU/WgrGQksLO6ID0v+sxRN32iYhzD1Sd2om/6Kgi623MzZr
         ypZbfLVNVIbDe9ZrVcvsjeyhOsH2moQgqYxacDMaO6udXpnhqhdBgSuhtsYzOzlMz6R3
         5KbiyO2WeLpUsNQbNbboduOZJFpTC9lLyiqJbK5IlmfHxWoLq4yWw/SJkjVVtjrq3Tae
         g6oQ==
X-Gm-Message-State: AOJu0YyhN363ePuVVvM1+3Zox4dK5WQ6YYqLRMWXGfzGZjoeRQBNCzk0
	OAweRtvmjtSwpuKyFZsLh+F4VPH9uSAZaHeOXB1j9oFYy5T2gX9crwvO/w==
X-Google-Smtp-Source: AGHT+IE7p7aUmm4D3A/so5ELvaM8FygvobtjEBSUUdO/YvTRoKZ0qH0s+YWfkAqeHunUt3CbMFiA8w==
X-Received: by 2002:ad4:5baa:0:b0:6ab:9c77:c32c with SMTP id 6a1803df08f44-6ad9f95bb25mr19550376d6.10.1716966020645;
        Wed, 29 May 2024 00:00:20 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.132.21])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad7ecca507sm28363876d6.6.2024.05.29.00.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 00:00:20 -0700 (PDT)
Message-ID: <6656d284.050a0220.dbc5d.954b@mx.google.com>
Date: Wed, 29 May 2024 00:00:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3141308348065615810=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btusb: MediaTek ISO data transmission support
In-Reply-To: <20240529062946.5655-2-chris.lu@mediatek.com>
References: <20240529062946.5655-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3141308348065615810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=856834

---Test result---

Test Summary:
CheckPatch                    PASS      3.24 seconds
GitLint                       PASS      0.93 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      31.63 seconds
CheckAllWarning               PASS      33.70 seconds
CheckSparse                   PASS      39.37 seconds
CheckSmatch                   FAIL      35.82 seconds
BuildKernel32                 PASS      29.92 seconds
TestRunnerSetup               PASS      540.99 seconds
TestRunner_l2cap-tester       PASS      19.01 seconds
TestRunner_iso-tester         PASS      34.07 seconds
TestRunner_bnep-tester        PASS      5.24 seconds
TestRunner_mgmt-tester        FAIL      113.73 seconds
TestRunner_rfcomm-tester      PASS      7.74 seconds
TestRunner_sco-tester         PASS      15.45 seconds
TestRunner_ioctl-tester       PASS      8.25 seconds
TestRunner_mesh-tester        PASS      7.00 seconds
TestRunner_smp-tester         PASS      7.33 seconds
TestRunner_userchan-tester    PASS      5.39 seconds
IncrementalBuild              PASS      43.27 seconds

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
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 492, Passed: 487 (99.0%), Failed: 3, Not Run: 2

Failed Test Cases
LL Privacy - Add Device 4 (2 Devices to AL)          Failed       0.170 seconds
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.173 seconds
LL Privacy - Add Device 7 (AL is full)               Failed       0.202 seconds


---
Regards,
Linux Bluetooth


--===============3141308348065615810==--
