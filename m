Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1064028E8
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263665; cv=none; b=mGA+M9gKkGojbN+awo7ZRSriZNcyGbPDtVKk7dxQbn3jpk6/ER7ydllO6sf9+oSeZU0ePdUXbZzaKdzPGrR+wXuZOQebXyaigFy3VgeesyF8dx3rVSiUpKFEv84DhXFQxEjfx02mRE4r4sigy4b8Q1BiAlOSErlakapdBUHSvEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263665; c=relaxed/simple;
	bh=GVUpIeWDowRbUHNii3yY3mYiRqOwFeAHeG3Hcueiskg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GVuAOHPI2mfr44P4Jf1TSOaMTHalVvuAKxSxHoTBoTQgphIG8CL75w8u9sfe6UQWUNvdzd06AlA9kSfs7snZb11+wSlgkv957nXSuu3MmsKtHRRKu2E5XMKt0Og6Imcl++2K2z3C0BzMLZyy/Y/IEsJsSae644Ac6Ah1iC8h51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWKnvfxX; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWKnvfxX"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be3d681e74so99245985a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 11:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738263663; x=1738868463; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CACrIeXIDr/iS5oNHwKLCkPx0dtymA1IsLmeTV+uzjw=;
        b=EWKnvfxXwXBWeB2rijswOnu90pd0IV6TlidIs+AeSQm6yhyeZtbLaVPqX+ecysdnjs
         3Rsa3XUyF4Y0mKh85tcpzVASK1vpuNrAc9Zkop5EJXFD11N5u3bG27r3z11Utgs4TYp9
         7RPD31211VGRj1BnVUcskcNKv6KmWNpRie5mbOsnWeJxMXLWqvXiAbq08THIgC79cLYa
         vfvOQz3ACnUGXYvAtn95l9wZ8qBvHuoeh0RDoEXt5mXH5Dnx7GjjAnccAengG/AVn/D6
         limcZzOfPz7u0F2AB5lqOoy753zIL/F4OSkB4c2R/gjmK9F9+SmEw3naIti2GOId9lJc
         ucJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738263663; x=1738868463;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CACrIeXIDr/iS5oNHwKLCkPx0dtymA1IsLmeTV+uzjw=;
        b=EST935ZH2t/guF9oZi6P2biw2ilo1aCV1suzb8laCFR+0VO4KezR1d6GvDv+HoLTCf
         BWI0xQGXF6DxkrzFA0QIfPCyk8CciNL+cvJb344h9IExu60K6ZAF6ltYTvw0zwyjYVj8
         Duw3cVic9hMapVXonpxwxCLjUiNrA37ta8vgZWAKfOA2mRnOz4UpA/HJlCJNvnTPFZJW
         xytCTIITetFCRAaTOn2nxfwYECdhTDcf3z0Mue9ScuJQaa2z4zi6h3zPmlAHn7ISrzHo
         cjsg3xmBYhX2FoC9ojUXycGiz3gAphNEG+C7UO5WLEsVpTSboJAcW2r+KKrm/NcLpuUX
         bxaw==
X-Gm-Message-State: AOJu0Yy38PaMtC7VOfS4ivySBvcNNSGhaBpwb/nRiTmVktCxavgVyJBs
	nxspec3ELlBEvHl3C9Y1s6LfGFRyPRQr1k3M8qmvvYHY5e1bqatvJ0WoQw==
X-Gm-Gg: ASbGncuzhS04IwEQzhTWv2V/2oll2tMGzouXVKcT6fq3R32dJTKwnwZJIPqJrV6AXnY
	vfx7L5IZSTnXuYp1dr5FcrQkxBDTCGC17v35hCdoqD9LT2CbYS+VEkA17QvTywaW4zfO33Uh136
	ZtFiNiKomH2d5e3JfUdafH7+RxICQoeigwCUwsRimGEQJmcGlCiQF8gqt2Js+8nP19zxQq8BgIw
	JbGCEOooKhILthjokWljHOW5m3ACfFIrAGCWw2TTCzN/iMsAW/vQHaUteaHQ3olQRzEZZwX1iOI
	WDjteTTf6vSiEOIXYsKj
X-Google-Smtp-Source: AGHT+IHjIzZTH4mxYdLKzJPjCbtnjFuPc9xnyEo3fd2aoRa/KJwKP4RtUfXrer2MNgbKRkh3MR4IPw==
X-Received: by 2002:a05:620a:2992:b0:7b9:a387:3cd8 with SMTP id af79cd13be357-7bffcd956e1mr1060468985a.42.1738263662566;
        Thu, 30 Jan 2025 11:01:02 -0800 (PST)
Received: from [172.17.0.2] ([20.42.48.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a905581sm101094585a.77.2025.01.30.11.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 11:01:01 -0800 (PST)
Message-ID: <679bcc6d.050a0220.1e962e.3674@mx.google.com>
Date: Thu, 30 Jan 2025 11:01:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1316668501349451191=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, avkrasnov@salutedevices.com
Subject: RE: [RESEND,v2] Bluetooth: hci_uart: fix race during initialization
In-Reply-To: <3674b7a9-109e-19d7-4db8-02e9a724c314@salutedevices.com>
References: <3674b7a9-109e-19d7-4db8-02e9a724c314@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1316668501349451191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929318

---Test result---

Test Summary:
CheckPatch                    PENDING   0.24 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      24.52 seconds
CheckAllWarning               PASS      26.96 seconds
CheckSparse                   PASS      30.12 seconds
BuildKernel32                 PASS      24.45 seconds
TestRunnerSetup               PASS      422.74 seconds
TestRunner_l2cap-tester       PASS      20.28 seconds
TestRunner_iso-tester         PASS      29.18 seconds
TestRunner_bnep-tester        PASS      4.83 seconds
TestRunner_mgmt-tester        FAIL      119.73 seconds
TestRunner_rfcomm-tester      PASS      7.42 seconds
TestRunner_sco-tester         PASS      9.31 seconds
TestRunner_ioctl-tester       PASS      8.02 seconds
TestRunner_mesh-tester        PASS      5.96 seconds
TestRunner_smp-tester         PASS      7.02 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.43 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.198 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1316668501349451191==--
