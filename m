Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4287C480DC3
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865572; cv=none; b=NvBPr1ys/eUspN8FSWNX/o8sY3bFFce7mB8txleYsU5m2/xsLYM5P2zEbchZ0HU+kgnhkca3v/0Cac1vSD5MED38vBrHh6s8mNqijfzWYLCcuV4Vx6HJZKVAX7NdN93+tWPz7rUCMjIIpumsTbcEcdKf3YlUroQlryqEkc6OrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865572; c=relaxed/simple;
	bh=zYo0VYHnbWKwJhRKmX8hnM5lHl6rLvsYXF5nE3ty9O8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mgffDM7MMIOdnuYRx5vU2uzBa92K0EYuaxp8TrvMh0jmHhHGety5FLi9z7BSHQfa6KrfxUb4imnlreDPHG60UK7bzJVxAlk8qJD7X7nnVVVwupnDkDatFxWePsI+DGHwgsHVhnShOIECOciEDlUdzM5E0ZP6kc2vymm1WBrwLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DStIyFdl; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DStIyFdl"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso4313918eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791865570; x=1792470370; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ic5Kl4EsefMU5356mFleXN1Y7T+Y7j8kxxP+cp8Tj+U=;
        b=DStIyFdl9o+TQYPlJ7zBHvLv5cxvZWIExirWT+SB+z3bYzGFnSx1Vz4fC5qaG08tBi
         LxOCWSfkYdYRd2c02hbfbjV/Q828zEDnu7W7i9mmnvjzH9VcaToTCv1F91xy7INPb4tA
         6kxa3+cOvasys64N2BPW5aHddNI3E2klMIRVXpkjT8xzum3NA0vFtC8VOTe/vpqxmCqk
         wP+/lPW8Duqf4aHR8BgTrUka8UPoRUiZAvxOf3as+BouCDdtDsRAvOd78VM8Rte9JL4F
         jyOwtpW0Ak7Zx9qSjR8mVoPoT1pFCrB24NsC83EhlP4Tg9gdqKJoctp7lzgQAXzmIeJX
         0ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791865570; x=1792470370;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ic5Kl4EsefMU5356mFleXN1Y7T+Y7j8kxxP+cp8Tj+U=;
        b=ylg0B1qoFu3IULxMuKtneXjrmFf69G3Dc+j0UEqNV3XQE8eXlYm7XFvikQX0TuqfLM
         BwwY0Hh42bDPhOr0ZbB21qfwAzgkXXlKXPXFcEYBHh+9sC+a/2wQHFNs1+5+/Nf1/rpz
         K8dpx9Oa0gw9oMgG65B+NMZ5wY+rGVwO1AZiGMzehtVjc+CJhJZDgmOrkrWq5LrauG0+
         1ebDtlr4ozg19I/o3yl090AujcyLsFwDQ2n/K1iwS5ttcCVRd1ipw4gxzJv6lXjpqdYk
         S3x5iHNPlKIRkEPkRM4txY3b+ag0LRXy9Eh61Gmd+8ts2SKqvEcZjUZWwnJmHysfxeLf
         7s5w==
X-Gm-Message-State: AFq9FYKOpjXbpNWH1LGv89WkBCiKgBSYp2eKrApOKDjDq8mcCFVaUtNa
	dKHS+2m+tR1vZ2e4RGR8Sml2c2dN4kh2FiEIWLbwOj7HvL9l/zoyBY2yxwZc6w==
X-Gm-Gg: AYBFou0Crg4B2AaWPqB9DzDIO+oEyQVm786JwVGoTDRHl+s5yviHkSJuaD1Fk/1Q9bk
	eWlN0rwydeZJ/tmI68EWgHLDpTKlTuDXu1NgUPlRdx67QfxsypwIsJzXHfosZoK11zJA+XaYNGj
	DpSiihc0DttvTAii7RlPcY/fq9ha0tJ0wrNlK9LU6IhZKtgvUOwovtv/oXrk3+3x6Pi9BKC+VWx
	uHPsTl6p+f5bI5wQN/Zytdwk+KGlv2qYB+A8SDY9oVaaeEDAzl0xnfA7GdXC7QyJpwvm3YR2kLh
	tWuZ6g2AwebnnJxIHTMXA7ixIvVCQbbu1lxYGH8/UotRi9DGw35nh+qfifft8jPEk3dFDQWeop8
	ESfceUszfd9Wkgp7XS/uNnR1Pl7/aTJdtcwvpZF2y7+DB9XyJECeNeXEaG37t6OsDv1YR9LTYrE
	V4o3Y17wdmViDNYHda9eeOt4PZVSv85+6zUs7amICoAMP1y748Y4NLYGcFTTbf/wUtYwjQrZsoB
	ly7CQc=
X-Received: by 2002:a05:7300:ce94:b0:353:5b04:8d19 with SMTP id 5a478bee46e88-3537e03a67amr16056503eec.9.1791865569683;
        Mon, 12 Oct 2026 21:26:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.193.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d20dsm42467431eec.12.2026.10.12.21.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 21:26:09 -0700 (PDT)
Message-ID: <6acdb2e1.7736d04f.192043.3de1@mx.google.com>
Date: Mon, 12 Oct 2026 21:26:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0040475283396983910=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] Bluetooth: l2cap: honor local LE connection interval range
In-Reply-To: <20261013033118.501182-1-cochcoder@proton.me>
References: <20261013033118.501182-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0040475283396983910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1184338/

---Test result---

Test Summary:
CheckPatch                    PASS      0.60 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      29.43 seconds
CheckAllWarning               PASS      33.15 seconds
CheckSparse                   PASS      35.82 seconds
BuildKernel32                 PASS      29.12 seconds
CheckKernelLLVM               PASS      32.99 seconds
TestRunnerSetup               PASS      699.77 seconds
TestRunner_l2cap-tester       PASS      12.84 seconds
IncrementalBuild              PASS      28.11 seconds



https://github.com/bluez/bluetooth-next/pull/909

---
Regards,
Linux Bluetooth


--===============0040475283396983910==--
