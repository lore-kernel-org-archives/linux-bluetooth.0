Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C803FD4
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130361; cv=none; b=p0LFgpRy11Q4BXsbLcr/KCT29vu/apE0gcpZyxLfi+G90Gr1/FyQ79e1kLjVC3pozQuqcw27E756vc64cfeLdX1M9ZC2jTqkEGe9kRFPPqqqSlMRNZNVrJPFCR682oc0wo8Ysm0uaXbB6uj9q4SK9pRVIVIJFxvR8Gv/VAGoftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130361; c=relaxed/simple;
	bh=cZ+rymQC+h79rEV+G1ke5ZARIDfnWwH07Yq4pTM1/w0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N8BNCk3J7r8UYDckj2czePuU/fCCKfGiSGtgfGGD2fJ4oLZl3i/z8e6TMmJT/AOKUdxvfxOG45i3PevF+QxKrnNjYCgvRYRrX3hb5swum/78t5GAw4sqQKhP+Xfc3v6uNI9b6uWZpPvTQYha1aCX6bG92waZUHsd8Qa+VHCa3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAlbUjxZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAlbUjxZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2212a930001so50213275ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 01:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740130359; x=1740735159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1LwOjyeYaBHlQv+8Z9vs8rBmaiT/wLL08CyzdF0EVg=;
        b=NAlbUjxZa4R0isK49rUblxpLg334oCCgI5b7wwToCv98b0ikT9UO8ZfIGfQEvIUnri
         dofcj7wrCYqBFJ4mUeCM4u2R1PW7wpRerQCLkWFmznAacJxfEJThWnmc6atsOCH5c44Z
         2rCU+pyYhz9RQudf4NYyzLP2V8dpN+ioTz21lU0JSjTAcB/QeICFe9rK1guBSPT0OBvY
         sDO9s5XW48Pj7VGRkjwNSQE7Vi6ckn6h7mwr2CT7fbLP34NEoHZiz1AEg4riivhvLb+1
         xU1ZQbAeOhtIHq9XWKHteYDmLydT1orYQbJx0qtTHb9nao7kD1SO3ilz1hFzFHhsP4e9
         Sd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130359; x=1740735159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1LwOjyeYaBHlQv+8Z9vs8rBmaiT/wLL08CyzdF0EVg=;
        b=TLtyouq95S4hijxXZmn4f214DkANlbqlsNWnjBkxhGLSBN48ppHpgKnS4rkxhvjJ9E
         qBuKnkU/8a6z55LoUDMYvFklfCwr21r647qyQxx/yQlRHqQyassorcF5jKJpxoeV6FYh
         vSRGF1wBJFhfYt4VFo7klSEg/Gmc7Wew579sLh8iteCbuID4YGi1uXQPMGfP5fhXWN5w
         AI+IBGD3WChSzShp4yWZ0zYM0HZ9WRjjT+hl/nll9yVloJ9e3FDnxDAztMuonIONSh+F
         y9L1BNQVCNMvoDg9dxjnGGLG89frvXWHz3jvI/na5rZyS0js6XltTOs/rhDE+5lDrd1S
         /7Zw==
X-Gm-Message-State: AOJu0YwLNzEyHKJaa/Hz3MPOF0qKV5/RDLSUXxOyHOajp8WjBn757xrs
	u78efKXmEYcBiFZuih9Qe41r/js/UDdMkQ711kmn0kIf1v3vJzVqKIwhTQ==
X-Gm-Gg: ASbGncsuaE6FBEL5W5lXXXJN3cDPlXfLkWI+nw0McCIF+bRkDc/hyxevgeIKPYzGvAT
	hLKZ5hFVgi7e424DL3bdW86lih51FOCd/xzh+vcKGmf6nRZMzny8ka3OtYZmU/RBa8HyPZi0I+f
	aHg3I1ZW1NrCA/hSvcn/99o/Svxv5cz9Jnzg6nNn9JmRX4T2Ile6JiJ6Lot5sU3gVnQcjAIKreA
	996vkZevmEZKu5kTsRynX3e6NQi9v6HdJRv7wv2Po+BKhbxFrtVAxe6vdNGFwhKbzRWSkk9R5w8
	fo3334xzAo0dINRsEt+omCMGW4s+5dQX
X-Google-Smtp-Source: AGHT+IFoonXx0h9qSTT/fiiuK7P58toHIjBRHoTjEhjQFfuM5kM0CvYDunHs6REzdSrrAzQZLkERyA==
X-Received: by 2002:a05:6a21:58b:b0:1ee:e439:1938 with SMTP id adf61e73a8af0-1eef55b4a09mr4490844637.35.1740130359342;
        Fri, 21 Feb 2025 01:32:39 -0800 (PST)
Received: from [172.17.0.2] ([52.155.58.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e34bsm15593715b3a.108.2025.02.21.01.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:32:38 -0800 (PST)
Message-ID: <67b84836.050a0220.112feb.4e64@mx.google.com>
Date: Fri, 21 Feb 2025 01:32:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2610094751026198641=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, haoxiang_li2024@163.com
Subject: RE: [v2] Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
In-Reply-To: <20250221084947.2756859-1-haoxiang_li2024@163.com>
References: <20250221084947.2756859-1-haoxiang_li2024@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2610094751026198641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=936335

---Test result---

Test Summary:
CheckPatch                    PENDING   0.49 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      24.62 seconds
CheckAllWarning               PASS      26.64 seconds
CheckSparse                   PASS      30.19 seconds
BuildKernel32                 PASS      24.38 seconds
TestRunnerSetup               PASS      428.26 seconds
TestRunner_l2cap-tester       PASS      20.95 seconds
TestRunner_iso-tester         PASS      32.39 seconds
TestRunner_bnep-tester        PASS      4.73 seconds
TestRunner_mgmt-tester        FAIL      123.01 seconds
TestRunner_rfcomm-tester      PASS      12.67 seconds
TestRunner_sco-tester         PASS      9.60 seconds
TestRunner_ioctl-tester       PASS      8.21 seconds
TestRunner_mesh-tester        PASS      6.04 seconds
TestRunner_smp-tester         PASS      7.16 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PENDING   0.79 seconds

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
Total: 490, Passed: 484 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.194 seconds
LL Privacy - Set Device Flag 1 (Device Privacy)      Failed       0.142 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2610094751026198641==--
