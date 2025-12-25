Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75553A1E90
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766626424; cv=none; b=CuSw7Nh/2Oqb4yshVrGtXPf2XCTqXijLrkT3UPT+V3e3LW9/Wq7WwnPO9ZofpY8M8aX3dQKNCq95oi92a9e5LsAQ9I9VNS8kVLa/7ETXhln8HWekueoRm+mWaCKQkOKt9nlmoU3oKe8pI7ufEGOyl7FpQpQZwYWnyBfcrp7NXoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766626424; c=relaxed/simple;
	bh=q1tYSW9e67lz9UOOaVOdxIgLfU35WW4MdB/eu9Nvsp0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hOZzH75CUrJb3DXphSNP2SULA/0SU+qAMUpi/Re3az8eaB2uSM5AMzEsZ9vEDyapXa13H1RtMJg6h3ccYf8VTQ3oae1NXbKpUywVwYrmQf8Ucip7iN0uNUQGkGMYeuZTTQKZS0CzkQGelCQbUY8Y5+KhzAFRBC+PMEVldADrmPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOsSuJEK; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOsSuJEK"
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8b2d7c38352so730809285a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 17:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766626421; x=1767231221; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=woqz6UDFRq+YJ4Bd9zFlFhhaqFBRpjlWGYEzfTflIUs=;
        b=WOsSuJEK5sYehfE17S7FRKCeS461otjQrjEtfO30Kc6KPdMfqvB8EzcxEeNR1/p8Iu
         n22Qio/DWEvh4EHN1bDGH7BzoW66R3TlK+oXwXh2wEsStk8hlu+mTNK14t1fql6XyhFJ
         DhWcpqJaWyvZRI+Ng02EXbN69Ea3RQ/g5uLejj6SAnxPn8heDYf/4Mf66QvyawmMj+FE
         12mInozItuYyRWD2LT/EbMqkgLzTFGFE8zWcku5pkdtBrLW+snYq9TOasgzMuCZ7On7q
         jR0Ivq12K/4OdLykfVsDQX6FPpQxM2Vo6hsLpmw79XUIXxoE/XBUKLY1O1B5exnRm9Ha
         rmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766626421; x=1767231221;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woqz6UDFRq+YJ4Bd9zFlFhhaqFBRpjlWGYEzfTflIUs=;
        b=M1A/7ZZwYZHdyltS9ncVffKK29Co9WdrBgY8yZi9GHZieejD/QM510PDBVNXAN7HpY
         f6rM8+F9w0dE4gvs9whmShJ/vWcV9KlI6XLA68P4/OnBNAK2Fv7Ku+uFKqJAvFtuuxUk
         3YFcKdtsyFtrvYN9YzPq/Il0/PqT1udWICj8r+if6t6sgzibKp15hDEdpjpQNuc3znvU
         0keprf2eOagZV/KIiI/WEJ7WudiUDDhFq6iQFFaGDDDIWUeJdHT7KZBFgyNKy6sdQyOm
         n1XcqD0Rm+n5+JnBSxb/o/hvLTf0RMGREnCc8uengPX2fCJTk8HhZRno5tT7ST14JT/p
         qZXQ==
X-Gm-Message-State: AOJu0Yw2qUsrw58Z+CCi7gACvPkMUTOajQIey0rM7rRUg51O+7xnhH+h
	jlGleFU8J/xr0OBqz54ENZU8WjJezPqtvGR0/w+v5F/rs+cEIJgQO/pGpyTWyFAA
X-Gm-Gg: AY/fxX6ILDHaTE+Zdm7Az9YuevUR0dP9Ojxrt6HYdb/gyReGn1DZM+Zv2FXwu6xr9Kc
	CCoGsM6liy6qXeOTh+SmJNWIjHrIfUOza+wAJaFUvn5FcGBWJXriY9eMaMDsgFKlFahHjPolKYq
	je9UgCwH4b5b4XqNxnvk4l4+yP6xU/AgUkziIthwe4hT7WPv9Q13pkKCH/OxEKsrXKBcg84vTRj
	5ifmL1GE+b8Jpl3ZNpy68p8YxbGx0CqWgyjAuS7nR0ntOfZJc/bH91npr3S83tB6x8UczH8zugM
	XcY07Sue9VKIvYj/4VZf1kDp8USc4vNQQzcCftfVLU6w1QnV0oZsHqE5VqnQWem+vl4vGdUR42w
	MmYs8g778GNZdQFVbmLNJ0UTHISpPKFFk6MZFMGwW7ADMLWveYLTO7kVXPSeMFNHAI6ZvnO3+yH
	M2aUU1Y3vRqdAHvMabGkrUFttwEoqc
X-Google-Smtp-Source: AGHT+IHkYsatvotjtFuZlX4/v1a02sXeZAECKRsczguk5Z9dLJSL3dzKzK9YN0VwIavofi7+4qRkJQ==
X-Received: by 2002:a05:620a:1a94:b0:8b2:eefb:c8ab with SMTP id af79cd13be357-8bee6836c1emr3166343585a.19.1766626421506;
        Wed, 24 Dec 2025 17:33:41 -0800 (PST)
Received: from [172.17.0.2] ([145.132.100.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783662sm1471002185a.5.2025.12.24.17.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 17:33:41 -0800 (PST)
Message-ID: <694c9475.050a0220.30d648.465a@mx.google.com>
Date: Wed, 24 Dec 2025 17:33:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7714160666062667743=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, swilczek.lx@gmail.com
Subject: RE: Bluetooth: hci_core: Fix slab-use-after-free in hci_cmd_work
In-Reply-To: <20251224235407.46333-1-swilczek.lx@gmail.com>
References: <20251224235407.46333-1-swilczek.lx@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7714160666062667743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1036498

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.26 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      25.01 seconds
CheckAllWarning               PASS      27.27 seconds
CheckSparse                   WARNING   30.42 seconds
BuildKernel32                 PASS      24.45 seconds
TestRunnerSetup               PASS      547.75 seconds
TestRunner_l2cap-tester       PASS      27.98 seconds
TestRunner_iso-tester         PASS      84.99 seconds
TestRunner_bnep-tester        PASS      6.19 seconds
TestRunner_mgmt-tester        FAIL      116.22 seconds
TestRunner_rfcomm-tester      PASS      9.28 seconds
TestRunner_sco-tester         FAIL      14.26 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        FAIL      11.41 seconds
TestRunner_smp-tester         PASS      8.39 seconds
TestRunner_userchan-tester    PASS      6.48 seconds
IncrementalBuild              PENDING   0.72 seconds

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
Total: 494, Passed: 486 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.106 seconds
LL Privacy - Add Device 3 (AL is full)               Failed       0.196 seconds
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.193 seconds
LL Privacy - Start Discovery 2 (Disable RL)          Failed       0.184 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.052 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============7714160666062667743==--
