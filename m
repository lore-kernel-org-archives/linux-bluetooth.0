Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692464;
	b=iPkJ/wTrFoC/ItI0UTXf+A207R7WIBUcT/Kb0GeoJQQ+5MKKDwF3tnvgv8ephE4MF4UQ
	 KRYemaPnFUMhnwq+xkajocPYUSDZyqdKBemNrjJXyCFzqQ2Zpvh7Gul7W8aFE9cReocl5
	 rOjXIu5HIKGXLMn751WpyJuBXDIKFccbdm+sYwQZw1TusijOj3j4ERz8wbHCENRZ4PxNO
	 LX+d6Wiins+Rk9A9y8WPfAIAmg5dHHVwy8pAJZ19x3rDJbXJUJge27hnM5v9k2pNgJZcz
	 DzmpJOanLzGOUzyw6uzzCXIIbcuWAYcapwwjkNmEI/BKROb/eYgVk1dL3wfRwEbN3Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692464;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=BnGCaBH7/BK67ZsAMIdu17Ch+Y9Utf+PsK/TnxOwFTs=;
	b=KdVbX/P98JHwEZw/HF2Pyou5/wvFzMmwIVupWU1ztTDCoE/2HeiKbZyJOHXnwQpbERLg
	 Cah7VkM+Di10ev80754aA7IbMVqTOSYq3EtasjH3DulOnHwjTllvCYaWOORlSNd9X74sa
	 pHsbnr3+7pfSyudMv4romK8jWst8ZVsVu0KzQ9uMX1eogc5wAKkTZmDTsYhbJaxHjKqKd
	 QdKwAj39JzxEnUdsq3uUGeuuh+l2YNJpLTK8HQW1M7aY2Kl8ctH95NQxwXUyBZpBFE/GR
	 Fmf6nuZR0dmNRF2Mq4P6Gx0ZhkFSVPj41bk+svbDIhSypwdDkzjMCBaSP94tK+OwKIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kra5OXIZ;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CF4606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 18:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47CF4606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Kra5OXIZ
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d7e06dbcccso44985eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 11:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792692463; x=1793297263; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BnGCaBH7/BK67ZsAMIdu17Ch+Y9Utf+PsK/TnxOwFTs=;
        b=Kra5OXIZjD9nQKz1g16jXrqYIssqS/gGkxfMkiDI+LARvKsJdQSbHpQVDhpRedFkF1
         81RuBR7Fdt8IrOJl0axu277IMjon73kRMJo+XGtpX/AL2iSU81wtR5R6mm4fEGxEpB7M
         kRAbnRwPW0INUWja49CKjq/3fX7otci5w6SbzyJkztp5T6Eo05TALfG22QiZtbw2kt3h
         PtS4VmK4zvPxALC3/UDxIqqFd6uQGbxdgZT7j8bZ+xmJkJ9iQKm4YtHEDt8X9b0fTcjy
         GVOSCsq4PRMlhsmuTM32xZ1VC67PDeeS4HRzivBc3MgQb1nZw4xmvGSIKT1jXgd+cD2v
         te7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792692463; x=1793297263;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BnGCaBH7/BK67ZsAMIdu17Ch+Y9Utf+PsK/TnxOwFTs=;
        b=AkI13maLpcM1gk15JNswo6mmXK/ZCYujX1LhEQuFusCRQOOeHHdL4Cqj5UFua2F7hd
         ni1n7Uf3fRT2LIwNzBmaJ2mZti+XBFvDNnbGFGMuKmaf44G/zeVkvKQbCCt4diMF3MkE
         oXb0CdtS+zcuzd7gbg1BaJJL77HfqwvNOYTb7JIAdQnXKpG2N7AxgY8BWO3NY8tbTnOD
         vD38KaLS9ljjB9FPeIDNZ2/4Ok8nUZZbH8CvtUSB65a5Odeb9bAQZMX4q2UkKDLQVGnx
         nPQB3o9+UT4NDDGOOKmnh6svwBcSbhTMRq3p1WYlVS4DOdOlmGQBZNfxkCV0MPO1Y0oY
         iYBg==
X-Gm-Message-State: AFq9FYKaZJtpZPGwjCj9LiuBrZC1jNT103lCaFaPWyhRvbTShNXI8T+R
	SxdWp+8k/QKypqHehkEqPfe5k1518q4pORaSesESKftYVkIfz+h2KIv32NezCg==
X-Gm-Gg: AYBFou2UhkmYX/2jJybvDN1x3PnAK+zFxvI4CQnjDB3K+5yrL9mBcUCGmXvNn+mT7lo
	EkU8BIryOV7V1RBmcrqoGCWKIq2sIvoJpnAVsbUiAlfAv8QhM3iQupcds0m7P6TBXBgHLCHjlA1
	h5/ORTUpX/+fN8e23o0jqw2kq8oFHUlSDXESbu08feHtc+BfukJsw6jpeItdWx9XOz2mAb1BXEj
	IG6bIe2I6/LC6WvV+o+cwjt9nVFUyC4AVrW5tzrpy5Q05O9XSVUEYIGQ8Bf8CNfirzxlkiHz4dy
	PeS7aIkjPmybe8HsindHwKOMXCx0akH5rBHWbWxu6OPHyitudZ+8T8Us1rr3nbDT1FkXIokTzim
	ZtiXwu5go3+RuuOSXrxvGjFl47GRMp8sUy2uE0RVt4PFRXVePU22HK6VQoha5pn7jBV9LqEcDmx
	ORWVPy24sn+7hHbhLy7HmEkyT7MISytxH5t+f/Z5pdhcgHcM4UN46iMJG1IR7LzGSgH/yj7SNPR
	v5P0ig2jKSVb4M+CVZZBbK7h34M8v/GqcPOYxs6VhcMpngKk143bQ+LH3Y=
X-Received: by 2002:a05:6820:c0d9:10b0:6dc:beeb:34d5 with SMTP id 006d021491bc7-70b889d7166mr106322eaf.21.1792692463160;
        Thu, 22 Oct 2026 11:07:43 -0700 (PDT)
Received: from [172.17.0.2] ([9.234.6.74])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b86892de3sm544674eaf.1.2026.10.22.11.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:07:41 -0700 (PDT)
Message-ID: <6ada50ed.b31e8986.2e168b.7ad3@mx.google.com>
Date: Thu, 22 Oct 2026 11:07:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5295932867104655963=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pabeni@redhat.com
Subject: RE: [net-next] Bluetooth: btusb: disable by default Qualcomm multi-subsystem
In-Reply-To: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
References: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5295932867104655963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191408/

---Test result---

Test Summary:
CheckPatch                    PASS      1.26 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      19.12 seconds
CheckAllWarning               PASS      21.87 seconds
CheckSparse                   PASS      24.11 seconds
BuildKernel32                 PASS      21.62 seconds
CheckKernelLLVM               PASS      21.40 seconds
TestRunnerSetup               PASS      443.05 seconds
IncrementalBuild              PASS      18.70 seconds



https://github.com/bluez/bluetooth-next/pull/982

---
Regards,
Linux Bluetooth


--===============5295932867104655963==--
