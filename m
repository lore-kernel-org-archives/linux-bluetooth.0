Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4121127467F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Jul 2026 06:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220956; cv=none; b=IZ5tpJts2biD+p2QdjgihdX0ro+VmqAYVTK2SCkzYIm36CsXnEbIPHdwr3WE9NXszMsCIvA6dJNij4j48UBvQ8ocE1CmFomUlCzAY0oN79B8mGRxEhdnjJmgq39JWRU8iCXeOEQbAAVhLQxei+bkOG0Wz5R0ANasXPGnZDr0zBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220956; c=relaxed/simple;
	bh=aRl/YoCjbY/ASnZ/usVKzcglCInc4680jCqXriCD+uo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fDfXQbtUku0apS3v86nzNsZUWQ/p6at6YiwVbn9dnuwQG3UuUM9LReJURyNzA72/39gxFI29tMLLMNd5/ecrAUn5T5s/JHCGlKo4zZxE4KVPO/SHg7CifkBffiuwBTjAL852vEXJqBLKSxT/RSRrpeoC9kR7fzKGZtVlWTFVAT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0Z7EUa+; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0Z7EUa+"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-930c0f9c1b1so240736085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 23:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785220954; x=1785825754; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+IedkkqKkr9KH1CcS06K8VuUSHV4pSjckih7qwMD2og=;
        b=D0Z7EUa+2aOV6v1LmgAuJ1ruhEcsOfjLO9TPOvBlmLp6pByiiZVr/BHVm0wGuGVN7w
         vulWFzjI1RTZ6cOBZoLB4b4LwyEp2EjS7X14Ogb+rGOAxLoe5T5moy3IeWfpOfHHCQa6
         fezWKPlrLmMPhbCXOuDX7M2c8Qr7QTdEDnowwEc3hj5ABtqsZ3tcOoqDdw0qd7iWWjNv
         Uo8cGofw8Q7U/WLVAuvriSzeJBNYU1r+aiBke5fY+AN3nzzXkmfhR2kxHWYb8bYrNbmi
         RuSKMnwwrR1tvm2OGvvISTKeVkKKYIkGbYyAg8BaXX7dViEa81O9v3m+o9IVbBXDod2B
         kYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785220954; x=1785825754;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+IedkkqKkr9KH1CcS06K8VuUSHV4pSjckih7qwMD2og=;
        b=WngfejE0F8M9AWAAeyGG5UKmS7iy3wRUm0yvnkAkYpA7i7mWHf3ubdi0JrxLF+A7CG
         rfMfLGbk4nr1uazfYGm0Bv7jftKOpfqVCEOz/RVV8XV0zZBxWPIdhg7XDur0bTnW6RmG
         1+zGqFeVXoH/2MXU6JyC1gfhf7VwLNh6d2d5dwcjMSoXvyftKcxl14HAOW1OKtQnw99Z
         wxFlDnp8k09isdV9q6vKVATQisiRTHrH6Jy9VgaMTzb8LbGSaJPaNlfo4e0N2UYP4mon
         fMFw572Dq27jsizp1KvO631ap324s3hhTtxZ2jX3RTLxsBTYuAUdt5tZw6V5QQ9KmYGj
         8vcA==
X-Gm-Message-State: AOJu0Yz1g6xMN9+/PRHbChnFIft/zbp2a+7ixJBf/2RWE2eswu40O2Fu
	oYUpRDl0yZ98GLYsB6kZTil0BXKPLMhm9adScGI3dTt+d7VzDCe7R1KXZ8W7BA==
X-Gm-Gg: AR+sD11EXK6S9p1rY8G1kT09Vcp2gPHet1nMjoNzdd2ZeHrQdxZu3xt7uip9r+eGOle
	SRjSa1HiRqZ1jB9jGJYhxDeBsMbjPwGph1L9OMDhpYFwrPKZX02RyDHkuVsjDq5Rsg5JkjzQGWl
	UPHvLpi4sRuGjuqnTbfdHExlnow35X3XW22ITJBJ3x1dsSnw8jEAxw3W1wuBZ30tlQ/EGFiEQTA
	7ggxVk0UYwGlJL2nSBNL619ZrKgWvJFKG5zowwzHHAwYpj/K7+XhZkSSWUvdux1t9YHVinp5MMB
	+qJEGu+jMUyAR6VrD9I2kMfMKnC+YgFr7F+EtMBb1zI7G5pm1sPq5XHLU+oD9mGXEIJkKWr3lVe
	TrHg/TKWFJJ4mi5m7m/XoVIPMw6PM7/TN27rjGpDewnV/kgAm1+8C+dWsONF/OC79/HO9NL2rMW
	cwV24dzA==
X-Received: by 2002:a05:620a:7006:b0:915:9fba:8795 with SMTP id af79cd13be357-9330247309cmr95934785a.1.1785220954090;
        Mon, 27 Jul 2026 23:42:34 -0700 (PDT)
Received: from [172.17.0.2] ([4.236.151.6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de519154sm800566685a.5.2026.07.27.23.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 23:42:33 -0700 (PDT)
Message-ID: <6a684f59.9814f051.113136.27d5@mx.google.com>
Date: Mon, 27 Jul 2026 23:42:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4762737857528798369=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, qwe.aldo@gmail.com
Subject: RE: [v2] Bluetooth: SCO: serialise sco_conn lifetime against sco_recv_scodata()
In-Reply-To: <20260728042639.1315193-1-qwe.aldo@gmail.com>
References: <20260728042639.1315193-1-qwe.aldo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4762737857528798369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1135608

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      28.35 seconds
CheckAllWarning               PASS      31.52 seconds
CheckSparse                   PASS      30.02 seconds
BuildKernel32                 PASS      27.63 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      516.14 seconds
TestRunner_sco-tester         PASS      33.81 seconds
IncrementalBuild              PASS      26.03 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/503

---
Regards,
Linux Bluetooth


--===============4762737857528798369==--
