Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9515D2D0C8B
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419013; cv=none; b=JQK2lI9nERv23vFLMrlik4be5m78IsGj+DXKDL+aAE9hFqMK2uWmYsDwhLqbtaN5O4BRd/L1bIMFtR44FrkgUNHdw4hgdxv/4vFnU7cna7GETapZ82L78gVslATpUWINF3sw/DpS1bsmAGy9iB5zb7vOIWn6JBC6+2vwnpcNJtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419013; c=relaxed/simple;
	bh=eo00bB6EIvt0klMqNW89KDwNREsQIs1h1Y9N4WJjHj8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fwhcJLEhji+eh0EZpBqfA32yubUt3jvC8rj2ayL08YUMHjb3/ciqiLBvgkF055z2xkQpQe1QFTPRWlk16pAFbUVgsDsAwZUI8s3a7LX7LRTWyC+OMU8baJZLrb3E7hR624esUDrB23IJGpPHwvA27QmRdkpktMFLJMwc6350Dvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb95p6pM; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb95p6pM"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-9487e2b9622so325007739f.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 14:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763419010; x=1764023810; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=or70SQ6YkMGAVJzJQja4n81vpHgbOF4ARRpBsRCqYTU=;
        b=nb95p6pMFPb0S36HB7y9+8bl4b7S69wSIBfHQTWsklhiqS+xNj1Ma+rfSE+MneMimC
         RPT53eymzCc3SD7fHyzmuYRVXhUAw5fNKnnWtylxptc04JJdtmeF3+UXawIJmJWxCJ/j
         SFAplbL9AmpT4jDt2Dj19gBIPMgwTm729cxQelodpZ6qB9vC4VRVueIqGa0vWZdADKH4
         RF+42HRgE1gQWapF737mFlY6iWukBj1LR2lJ1O07V+wEETOasx3HrTfncRJLX/dbkGNO
         DJAfPwP0jMBQyAyqhiuM0R7+/n/ltifKCIZXelsBBVclx4CKKPdAWV8yHgfs7qHCfG41
         nkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419010; x=1764023810;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=or70SQ6YkMGAVJzJQja4n81vpHgbOF4ARRpBsRCqYTU=;
        b=je6E4EswqdpW4/jgWDOggS9FJX6givDTOykLwWJZDnDT41MxLfUWJ3S0rUDLFCak1R
         PeYp3NU4Od/ZGDfQXcdz2DQP2Qf2EprUBwT6ptNP8A/P9KGqrciPOLSvJoVJqF2Hyzc7
         YQH4thE+ZOO8a7GLT+5ENn4MjVmRCow+gb9685JUlc3vGXjr40XQXGLVyhZg4Hl64+i3
         qG2GPPI78Tt1n6eQjlLqBSBOtC9cv+UyupS+s2IblRhLpoicuGam3U+p5AuR720nhdw1
         jWGHcE1RYEtrblL1rP71Yo97CCMzCVRE6Qpn1hxbvMSyA6toiujGSfn0jdZnDOBYNowN
         m4Tg==
X-Gm-Message-State: AOJu0Yy9AlbSaZz0d99ZZq1SH+uyAFbbTVK1/4sqOZRFy5gjb2BxEHl2
	Gzrde0bOIm3KkaAAkAcsup37SRuTBsdEAh6Tuak+xE9yKF+hJ36bOo4Oi5Gd3A==
X-Gm-Gg: ASbGnctXlVQFE3D+Df32eUYkdZa5kDkDylVzEIF63+fE6jCqVR+/r+PP7Np/kDxp3kD
	qPZ15V8Bn/7WgYKkRlbjiMQayN8hzBhZjWbns/x7KjyNZ6KXLu8kfMhJbYcn7lfkCukinWR2+b0
	Izdg6V1glZCTDlX6odL7DNcBJb2+psenaLcu+X7ikwDINWb3IQmWWBOx3nR0zNDb/7o8YmF3UOi
	Lw/+PGVvim/4K5MX9nfK2I68AvLF8YUpm3vDNO8Egb6PBme95cjkjO6bCWtCYuxDgkyzCCva0Kx
	gryGS6ZkzLerhziUr0+M9o1L0Jx7w5dWOnpdbvYdJHhYcb7Myo/6jV1cASUdpQg9Ai3JcuYA6eP
	KshTfoZFKVjevYnFNNBHlUhVBo+yaQTsi7Ioskzh4RR5ar/sfTFcseKyRtrVMX+kBYg9QodJYI6
	Eg6RC0W9zvH7qyJF4VWf/D6GLqlfdVbg==
X-Google-Smtp-Source: AGHT+IFN7ylioadPapUuc2uiutvkYSTbENx1/8i5ikKZUGkmLML5vJ3pe82brqszXI/VX3UDbGeb7w==
X-Received: by 2002:a05:6602:2c06:b0:948:cbd2:3b84 with SMTP id ca18e2360f4ac-948e0d87a37mr1553066539f.11.1763419010406;
        Mon, 17 Nov 2025 14:36:50 -0800 (PST)
Received: from [172.17.0.2] ([135.232.176.160])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948fd4c273bsm320195839f.18.2025.11.17.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 14:36:49 -0800 (PST)
Message-ID: <691ba381.050a0220.2fc07c.4e01@mx.google.com>
Date: Mon, 17 Nov 2025 14:36:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8034855797918134001=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] fixup! Bluetooth: hci_core: Fix triggering cmd_timer for HCI_OP_NOP
In-Reply-To: <20251117215103.3990708-1-luiz.dentz@gmail.com>
References: <20251117215103.3990708-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8034855797918134001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1024529

---Test result---

Test Summary:
CheckPatch                    PENDING   0.41 seconds
GitLint                       PENDING   0.24 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.18 seconds
CheckAllWarning               PASS      28.16 seconds
CheckSparse                   WARNING   33.86 seconds
BuildKernel32                 PASS      25.17 seconds
TestRunnerSetup               PASS      546.30 seconds
TestRunner_l2cap-tester       PASS      23.68 seconds
TestRunner_iso-tester         PASS      76.63 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        FAIL      111.67 seconds
TestRunner_rfcomm-tester      PASS      9.09 seconds
TestRunner_sco-tester         PASS      14.16 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        FAIL      11.43 seconds
TestRunner_smp-tester         PASS      8.32 seconds
TestRunner_userchan-tester    PASS      6.54 seconds
IncrementalBuild              PENDING   0.80 seconds

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
net/bluetooth/hci_core.c:85:9: warning: context imbalance in '__hci_dev_get' - different lock contexts for basic blocknet/bluetooth/hci_core.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, include/linux/radix-tree.h, ...):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 487 (98.6%), Failed: 3, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.092 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.194 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.172 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.102 seconds
Mesh - Send cancel - 2                               Timed out    1.999 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8034855797918134001==--
