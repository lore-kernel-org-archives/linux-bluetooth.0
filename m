Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B55F1F76C3
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jan 2025 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736342227; cv=none; b=BR5DH+wJBxGrO6Ua6G6fwShA7weY/0Ql2BCCUIVn5+4zbW5OLuptL11lxLYk2s3ZlItCwV/AkXDy7vhnYQw2trhwybyLdOdimE4WbRT9kFF7NgFuNLCRMCZ0+w8TJRQf83+QoxbdCY7+QxBrquo9c45Br+bK7XcpbYS9WpM1c6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736342227; c=relaxed/simple;
	bh=U+B03xqdiDiyc+zQz5Te6ETE0G10enDUGn99Y3JBVqU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nfrgsLyD/kM9VKzvv9OwNzDZ6OFLQFo8Rrkf3VHpdlof1/RAJhw/cMrGNR0IrwxNsi/na894AaM6pb/LnPKylDT8qvVN2O6X1LyqJWVwO3W0CtANHMBCilGHK/ewJQnN7aaIrWgs//cSBbYoLBsb6FQPN3i6G1Q6Cm9Z69gQQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/aSyg5l; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/aSyg5l"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7ba0fa25f07so763285385a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jan 2025 05:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736342225; x=1736947025; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9QuwgruSf1CIKfAQmZ8IwCclwShvWXOlvNICdgfRM0E=;
        b=V/aSyg5lZeJb94mKZUw7ngjdGbawp213IvvSNl+4/mSKhvcX+Luq81UdUEyXz1iMFf
         pfsjEubughKvTTIeLkPKjgnnOFGl0npjjie7mJvf3T9PoCGmxr1AIoUuaCtuAhP9oXTt
         9ZU/8+zF706L1Km7IdwZ+IIDxRnxWVAIaJdcNlP6VxirIHBBkFingsIUeZeLNO28FWor
         M8d5EreFqS88io3aY3nwOQ/TzqX7SCY2KnHpLkQjCLTdrLDPFheayamoI27jnUHQsx7M
         5f1jVZcWLs5I29fbWVpNt+yvccfckFS8JQW0br6GNLMAUkAnGEon8EO7i7n/Xg9W7tOI
         NOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736342225; x=1736947025;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QuwgruSf1CIKfAQmZ8IwCclwShvWXOlvNICdgfRM0E=;
        b=ElIuMoyR4U35kzwu/wBd26b95QZTKWHUdITrJUr7/X0v0RiCOsNw6R0Xuzaz0Yq794
         E+Kgv2DLMJ+jocsC5oCyF4BRHgUnqcnE1kIzjTMzeGHH5E2fx7PVCoCQzJNNlyChHtX3
         slniv3N3eU6oTuzF19/W53Rc/7yS13jFKZ2518Isju7MmrEWVEX0kj5gBhBnLEuYacan
         fLBAKqCNRcURLklnsBIoia42RtXkGgjHICSKpHfSpF7lZDqCEqctsHwF9hGvLVNgH8CC
         eM3tcDQIhCxG+TgQSMChf+4oT0FThxvPGg3HGFfRDjpziQvDNoFdQPdqjnViXiGczG/a
         GD8w==
X-Gm-Message-State: AOJu0Yz2t4Zp8aMZRLQ+OM4XjWl8Eyy6JUIwpedieup6EW3SA6MH91wC
	Xmib2nM0Ug9UjoOqySLixvl+4tCT8Y6BsRXi2zWt7TEX+SL8T4VI96yDQw==
X-Gm-Gg: ASbGnctDr2NsZ3bUk7H/C5DqmEZ63+780LyfzvXpfAfjmZsQa/eX7BWCQyx1s28MbQg
	IdTwRkNThIFRZMI7Z0Ho9XUEplqAp1I8W0PawZtD1DI2hcQu3nSJv2vEvzilcUVBi1nuF9+JlFE
	lJptNbGO0K3dKNcetp62kyXXT7tiwekBsf3E3CbR+4wbIFDm0VhFiONLFH/TZ8ZZNGwBltYfBq8
	DHEpt7HoVcHokWT6fN1IoIYuBOY+i5TfN4nwoTOmGWc4+2P7L1dapRZrR18vm4=
X-Google-Smtp-Source: AGHT+IFcIjUpMgj6J+/Uv784CfGWk5AZtVZAbu4dLJucuVXD8Z42OlZjZDfM73a3rJXqxBR4/pkXbA==
X-Received: by 2002:a05:620a:1a06:b0:7b6:e931:460a with SMTP id af79cd13be357-7bcd970d4admr393575585a.21.1736342224714;
        Wed, 08 Jan 2025 05:17:04 -0800 (PST)
Received: from [172.17.0.2] ([20.55.223.230])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df7a0sm1676317485a.47.2025.01.08.05.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 05:17:04 -0800 (PST)
Message-ID: <677e7ad0.050a0220.c9379.92d4@mx.google.com>
Date: Wed, 08 Jan 2025 05:17:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4962231862973366486=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chharry@google.com
Subject: RE: [v3,1/3] Bluetooth: Remove the cmd timeout count in btusb
In-Reply-To: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
References: <20250108202442.v3.1.I66a83f84dce50455c9f7cc7b7ba8fc9d1d465db9@changeid>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4962231862973366486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=923368

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      25.01 seconds
CheckAllWarning               PASS      27.16 seconds
CheckSparse                   WARNING   30.79 seconds
BuildKernel32                 PASS      24.60 seconds
TestRunnerSetup               PASS      433.69 seconds
TestRunner_l2cap-tester       PASS      22.60 seconds
TestRunner_iso-tester         PASS      27.70 seconds
TestRunner_bnep-tester        PASS      4.79 seconds
TestRunner_mgmt-tester        FAIL      118.68 seconds
TestRunner_rfcomm-tester      PASS      7.56 seconds
TestRunner_sco-tester         PASS      9.85 seconds
TestRunner_ioctl-tester       PASS      8.09 seconds
TestRunner_mesh-tester        PASS      5.94 seconds
TestRunner_smp-tester         PASS      6.98 seconds
TestRunner_userchan-tester    PASS      5.05 seconds
IncrementalBuild              PENDING   0.97 seconds

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
net/bluetooth/hci_core.c:60:1: warning: symbol 'hci_cb_list_lock' was not declared. Should it be static?
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.171 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4962231862973366486==--
