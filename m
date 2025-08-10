Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B25208961
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754865288; cv=none; b=hRjKBIKhJTaRCAY0TY1O29O1gcOmtWL+i1VidXhW9+comslsn3C7iafcn1hUi3k7GtM/dF27VGQPn8WPb6mIs/RvbZA3WE/SyebjqtTtZOkFaNOug6/KjQp0Pd2lciW7RxwJiZfqgrj+l43Jj0YvWvQXzmhDhOfXRWGvgtzjys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754865288; c=relaxed/simple;
	bh=qbLaUUghG1LZdQ0yZ9q+VYoc1eP77CEdk/poBKhguNs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LeAJwwFLMjrIbR4mNHTbeB+tQlmZ6SsxDXOpj6PoTzdWA2SPEnc59i8F0Zl/7R1uPjFO/7vGPZma0K55C2FJNk+mw4xiRScmGzU8zM2x25W/t4W2A+4n3lkU4+4dEsWKgcIeum3Ht6jN0pmuydX2wqlSZ/lsqSST6FrbgcqJhXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk6J6Ehq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk6J6Ehq"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so4362755a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754865285; x=1755470085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BMLYUwiDvEz+eR8Q1sk+BWOGD9qadmO/5saEMgNLCUA=;
        b=jk6J6Ehq5YMQFXuADdcKY4aPbRwsHZPf/2brGypyFEbQ2SR8WUkaRCDPssitg1XmAh
         8jEIDGWeVvHuLk2VAMBpqbNf0az6GWUyL/symKLN51hUy+/qAzfwOS5Grb90Hh2JH7Wa
         f5wa9lDDLD17mC1DbHC8DoX/CdOCqU94d9vQg/cDlflMrfjVjAXBgfOd4I8Lq5zm9kox
         sg97lALn8WT7mT3gANRj7w7zKV2X5xsxrDxT9pS0HdqmILN1fbFBry63n7243mbAgmxQ
         GkVpbrKtVV9+WhhWGIGUu6RwHLwa5IFdY3i+KxQ7HnIfGKlX5Je3gFfz7pM74LQAQu1+
         1P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754865285; x=1755470085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BMLYUwiDvEz+eR8Q1sk+BWOGD9qadmO/5saEMgNLCUA=;
        b=lspBL9KM9SzfLRCxr5M57REBBbn/q8wVZ7sZ8GTC0d3S7QStr61mSFAR2vB+lg5bck
         Z6+FwlDWM743FP6rHVPncz658N2RrNP9cCu4iIguCPg8q3RS41ySngqKOWmJasdCxF5h
         F2mlk+bCle+8QLSIyFcpZZZ1ur2iPMu/ci0Q3wtbvS7lJ5HjS0EfN2BsxSVTyOYcL3rS
         Cmy0VUS1l2844eogvU+j+1Usc51voqS9aJtpCjLnrlCywlmFYFR8Sxe8uLHIDcULLaeL
         n7Pvbt7RPC4lllbYRYDB6UNT8XcgR7goUd4EFvhtj5BcplNAMR/KLGBQ94Wn2/CF3nnr
         BuGQ==
X-Gm-Message-State: AOJu0YxA36W5uPrfPWNt+UvW1hdRqL0+IYY1P+EbzC/j7EPZzHC8wgjx
	3Eqn6sAm36N+AfXpcfJrvHKTCtZaS4fP6h/8FUkZCkG6Uee3WPijTqQod6eBgQ==
X-Gm-Gg: ASbGnctkHy6VLiGUi+/mXGZps246OIUzbazIR63VQ6nfd0qDa+IBcAucqtip6h959xw
	sN5xT8/fdm9rroWwCUiqYG9IfUekyn0RwP6LwSl8lt2HRLNaFa9P2YyO+vmbFyWfpF16WisB5uJ
	lldCot+dAp+w5b7DJ91EHp8T6ohlXWoKTMDe7viLY3/TvjbdM5fOX4/N3zWOBCcGtyLAV4WXtso
	UcdNr35LixP73GUb9jOEY61ZarOqXykXWDXdnFoZ5QWLsDnXXgBHbI60mLeVmbk1u3VReoHskPm
	Y+T0VgysTsssKEG2TXD5ERSMhq73fBIWrQjKxUV7bF2CUIVSoshK6M2DemyJAgrsIrMHxcL9VwJ
	EjtvIaPjuhajHp7zYmtxbSr3H5iU=
X-Google-Smtp-Source: AGHT+IFHmAxFiJhZUcB78oyOw5gZLh6IfgiY2Ee2Ncf3N6jAq5OOul0F18v7sftzIVBDFOyj7bu9VA==
X-Received: by 2002:a05:6a20:7489:b0:21c:fbf0:21bb with SMTP id adf61e73a8af0-240551620a6mr16227171637.24.1754865285469;
        Sun, 10 Aug 2025 15:34:45 -0700 (PDT)
Received: from [172.17.0.2] ([40.65.58.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f474sm24781007b3a.4.2025.08.10.15.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:34:44 -0700 (PDT)
Message-ID: <68991e84.a70a0220.7e137.b482@mx.google.com>
Date: Sun, 10 Aug 2025 15:34:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5429023499535457386=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, thorsten.blum@linux.dev
Subject: RE: Bluetooth: Annotate struct hci_drv_rp_read_info with __counted_by_le()
In-Reply-To: <20250810215319.2629-2-thorsten.blum@linux.dev>
References: <20250810215319.2629-2-thorsten.blum@linux.dev>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5429023499535457386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989753

---Test result---

Test Summary:
CheckPatch                    PENDING   0.45 seconds
GitLint                       PENDING   0.35 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      23.95 seconds
CheckAllWarning               PASS      26.72 seconds
CheckSparse                   PASS      29.54 seconds
BuildKernel32                 PASS      23.91 seconds
TestRunnerSetup               PASS      478.20 seconds
TestRunner_l2cap-tester       PASS      26.17 seconds
TestRunner_iso-tester         FAIL      32.81 seconds
TestRunner_bnep-tester        PASS      5.91 seconds
TestRunner_mgmt-tester        FAIL      123.24 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         PASS      14.62 seconds
TestRunner_ioctl-tester       PASS      10.00 seconds
TestRunner_mesh-tester        FAIL      11.37 seconds
TestRunner_smp-tester         PASS      8.37 seconds
TestRunner_userchan-tester    PASS      6.04 seconds
IncrementalBuild              PENDING   0.59 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in iso_conn_hold_unless_zero+0x76/0x1c0
Total: 134, Passed: 134 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 482 (98.4%), Failed: 4, Not Run: 4

Failed Test Cases
Add Ext Advertising - Success 22 (LE -> off, Remove) Failed       0.120 seconds
Set Device ID - Power off and Power on               Failed       0.119 seconds
Set Device ID - SSP off and Power on                 Failed       0.126 seconds
LL Privacy - Add Device 2 (2 Devices to AL)          Failed       0.173 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.198 seconds
Mesh - Send cancel - 2                               Timed out    1.997 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5429023499535457386==--
