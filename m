Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C997B5811C
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290615; cv=none; b=DC0tPf2ghe+BR8wE3YkLCr1sCK6O6cB3J0MVteXWNQEojaNkT72sVFzoaOBfhNKK6e3BpKE6EqYFhJ2t86+z1XE3q9G6gGNkJjz4sG9ABElN5rutlzcGZUYD+20oY5GfqgVKCEpA75hWhN8EPNUWjgGU/v1e92FkEx74dTddYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290615; c=relaxed/simple;
	bh=9QdeQ8K45oeJoDHQsDh7J5GWQyi1xxU2Uxq5apUqmw4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OhYbRBa6bkC89urqBxFrfeA6IaQzsOrrhGLlmcVDUW5M7HY6MLe/mGrxjJfiUisYs3vHg4AK3D50Q5R0AYHo/pLw/LVle38EoI8hp1qSadveqVNROBOQ3P68LMji9mzLK47BNj3F9Wrfb59nSZYN6Gn1JXhSbovPkNLJYG/MTsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/P0yQeF; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/P0yQeF"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-787ac94bbabso86006685a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Mar 2024 02:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709290612; x=1709895412; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g2HGjZ2QrdzaH1+oelRXgw3T1idDU6h0UzB/dMVzOjA=;
        b=F/P0yQeFILmC1fDaVpU17m+9cl7AGEYeLzp6R5sQw9Apb10ZWgW6oWaVPkzgEP9ZLW
         1pyBpbjiy/FtmAl2Z7T0Ac08N4X2bB4w2EyotN692Wmb1C6kb1/fmEdodC6Zs1Kxa0Wp
         y8/DsXbXgszlvh13oNEHQ/shwd2ez15IRQDFrvdjS5X2v9PLV9k0BijpEGvSENmXiyGF
         aNQihHGXR40ETXfTeov0OVnv+qQioTjtWh4UTuz6gZybbE8rSZ/aXa4i7QsWLlNjuzNe
         ons8dQRLO/VGOYR7pqdz8wWyVIhbEeyjTIQ1rYhBpSivqhssTZ/R66MaN13Al52WM30z
         UJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709290612; x=1709895412;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2HGjZ2QrdzaH1+oelRXgw3T1idDU6h0UzB/dMVzOjA=;
        b=sJ8b0vgmXfnoP/Pg1tx6UELEM29rjHMZGX+Cj1/yOErADJoRvzpUmtK6sxrQ7QhCT1
         6n1go0cBegDBwRSdUEC8r+PGAZXT6io2ANva6DQnCtOnpWEE6zifYjLg0rZropuWUlN4
         hT3dh+5EPW9XFfQ1BcamagHozOvppIQLz1m0jE/7njlSfdRavQ5sjFwkqHv7clUGo3TL
         dVO+S++7uJM57NXQpgfLORJJx9QtIHNTau1cHXiMPO6jqCF441ZcnmJ7ecFSHoMgCD9d
         wlx5Ft+cFNp/hg5ZiGQe6P9YZ36Wc9zY04SNPbkZRo4FQwfkD/+BC5eUAEYV+WvXizBZ
         XZbA==
X-Gm-Message-State: AOJu0YyZWSIf3cu2rwIBbpw7PDv7qEyFwmE0Jehjcds9+QYSFhmU+bFu
	Mh4ZWqnxoYM22hXAoVE5ETQrqbf2UO218zWC9saTTmyCjPuZ+qfMZbDKr6gr
X-Google-Smtp-Source: AGHT+IGtQzoxoTvs31p4Ldwf/lSWo+fPtvvxYHjy07lOCN1jTUK2K3X3ac6JYI6x5wGZ7rxBrXxFtA==
X-Received: by 2002:a05:620a:458e:b0:787:f615:2f69 with SMTP id bp14-20020a05620a458e00b00787f6152f69mr1566444qkb.33.1709290612500;
        Fri, 01 Mar 2024 02:56:52 -0800 (PST)
Received: from [172.17.0.2] ([40.67.133.146])
        by smtp.gmail.com with ESMTPSA id bj13-20020a05620a190d00b007877f52a6b9sm1505164qkb.136.2024.03.01.02.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 02:56:52 -0800 (PST)
Message-ID: <65e1b474.050a0220.5da60.6fb6@mx.google.com>
Date: Fri, 01 Mar 2024 02:56:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4145475443196004398=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel: Add support for downloading secondary boot loader image
In-Reply-To: <20240301102412.11151-1-kiran.k@intel.com>
References: <20240301102412.11151-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4145475443196004398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=831464

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      27.55 seconds
CheckAllWarning               PASS      30.69 seconds
CheckSparse                   PASS      36.37 seconds
CheckSmatch                   PASS      100.65 seconds
BuildKernel32                 PASS      27.86 seconds
TestRunnerSetup               PASS      505.77 seconds
TestRunner_l2cap-tester       PASS      20.20 seconds
TestRunner_iso-tester         PASS      30.84 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        PASS      109.12 seconds
TestRunner_rfcomm-tester      PASS      7.48 seconds
TestRunner_sco-tester         PASS      15.17 seconds
TestRunner_ioctl-tester       PASS      8.11 seconds
TestRunner_mesh-tester        PASS      6.03 seconds
TestRunner_smp-tester         PASS      7.04 seconds
TestRunner_userchan-tester    PASS      5.06 seconds
IncrementalBuild              PASS      27.15 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: btintel: Add support for downloading secondary boot loader image

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
25: B1 Line exceeds max length (84>80): "[   16.571945] Bluetooth: hci0: Bootloader timestamp 2022.46 buildtype 1 build 26590"
27: B1 Line exceeds max length (81>80): "[   16.575002] Bluetooth: hci0: Found device firmware: intel/ibt-0090-0291-02.sfi"
47: B1 Line exceeds max length (83>80): "[   18.529914] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-0090-0291.ddc"
51: B1 Line exceeds max length (81>80): "[   18.537170] Bluetooth: hci0: Firmware timestamp 2024.9 buildtype 0 build 58067"


---
Regards,
Linux Bluetooth


--===============4145475443196004398==--
