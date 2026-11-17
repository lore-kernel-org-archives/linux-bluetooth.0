Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920617;
	b=TRrPU/tUMcQMlha0W+rXeTCYvJEXkkGUc5E0oYMPPN31T7GDC+2BP5qCyb3kH5tzw/wN
	 mZYMpBcdcAKoUBF96fFHODxVoDipGf0QDrhLdzTQD1Llvu1V31a9i11wPDG06gwlplw4u
	 oMQz7jmkGuYoxNpaDN8DRYJrz2+oDTQ3ouRAjJpqRaqL0gIkoD48JRnHoOlwgvitxhjhX
	 tnuasrh996oucdMFO2UauPeteqDjLu/1a/ElWSZMu3OZL8q3/zgkDF6DCezBpZfwH//kK
	 FbNVXL2rWdOVBelvhkOjhFQYAELy1COd4o+ZyosFSqlTiPfxxLjqVY7N3Zx3UOefs3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=5U+obujUruSB1soY0TIJd8BHcHtLBILXjdcAE6bO9ZA=;
	b=mwmoipvS/9Dn105xAn9rv60j+GD32uxPrtGq8T/nBFAr3rFO2IvBdO97ZSOrzIo/W/c1
	 fFkV6eBNMSxxZN0wLbpeq/4/HLJPnpLLmE7pbQG2wOQB3cKaTqWm3GFjAdsDUGLqZxyBg
	 bab0T63XDLCwIOEWObeHsB8it84t5ADUQjAW+zsJxz/cxcau0vbCd1f7UDcHqLXyYm3g7
	 BD7NkM5p71Ncgc+7wKUuVin3CIyBu6vvmwSnXKcLR8TxmU8sU8H/YMmTvH+Debg6WaNBh
	 ZzByUsHAvyVeGfhSEfSH4tm2szHejTvEZwZElm0hR7L5xe/DAtQfObx0XOOiCcWr/pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLRi8rVw;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD737606A32A
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 13:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD737606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WLRi8rVw
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-380b40312e2so3671112eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 05:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794920616; x=1795525416; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5U+obujUruSB1soY0TIJd8BHcHtLBILXjdcAE6bO9ZA=;
        b=WLRi8rVwZTzb327m7bLiV7QZOcPDmIqKmA1HNcm3zoHoXf2d2KWAgaQvzOphOuMfSl
         DHtmSR8SUR2YQSUPxKIcYn7CEhGlxQLFFRzok4xiPcPi3pRXwn/N25PyZeV+U1e+Rhkz
         FytnXmiIwlpa+MQ4zBLw3gU49HDSyH24OeE+QVSMYESUe6oaoOhosBfO3Q7Nxkyp9Oof
         R2T1EVt07WAK5A7cczF6EuylpfDwwToQV6VbI03JI+JFQomsPTGo+rP2+ejwZk1aPYTH
         necy/YVz629ROLSBQYyODCdUL7K5mdTYa72ZrZA+X0x/zy1tZib1K29t4qdH8ejpFr/z
         xFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794920616; x=1795525416;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5U+obujUruSB1soY0TIJd8BHcHtLBILXjdcAE6bO9ZA=;
        b=Mi8n4m/AmjBd+dH11kjkrVVBMfPfxLWUZokxunAB54Fnw3MLcAeJ96opJtcRftChoG
         JtmZeZDBZ8BijZ5k7BzlBi5M2q0CRS9wg2Jp5P9QKivuitX7qdjPZ6TCgCL+AoHjpJMr
         DrcMQmUmkWsr8OXWctU2WG5rj1YqtOD6zHcRJzj5QZGWmD1sKZZbAHpSleV2csNKT1ou
         ucCpzQO8nUGs5FkfG0zjXBcNsP0rd/+Z2pCpEkPhHGHqlWSbIJx9RWcFvOfRmCkVEPgQ
         e+1D0kHVcTEclIb+sC6pjkuapPJ5WeH+kMN5DhOX6tv4/TiF3kZU5/+LfWY8TUbBteaq
         jc9g==
X-Gm-Message-State: APuU4Z9IOnV4f78lVxzY1ru+PImzhYo+YIFM4q50ZTX0K0GQW1ucneNI
	Zng70sRYZQ+L74moJmQb78FriaO5ydsfdQBNR5d7WYLAmJJDLfDbZwbbBqifig==
X-Gm-Gg: AZFdTZdQ28u285wXI+0dBRMEhaFjysC7FuRH9kwR/pCtKtc9ZjetfMbBhR/KIL0QHR0
	FpkNPEAXIgOdqJd6hstnDG3sVhheimjn2YGtE2Xc13XLi61qFqRFetbHFXgruWZY9r17qhR1urL
	q8H5zbpfsrw1Q54PCU7o+d5dewAOWm15q1qBxi4k9p+XfCcMxcwnSFG5UYNdnVsJ+kFNzkYtMmm
	A1EOOEc2BwwXobbvnJF6oAaj/hwYz+LBRN685gFcjPMg5HKASaqxZt/zOXoJuAApXm2YCQJC0Hq
	wHQz68Sav2IhzZlP0XaeFb2uKZOtVruHW8hBSKMypGB4RVgjXnQY5YM8/XfXKZOuPg+5lDkr6fv
	F2qj7dy/kRKH3l0s1pxNG9uFiUAVH0xSpJmSvkojSLkXg8Nh9rw6n9mNcX8udAPUnUOZRwujwmo
	txHwvqXXPKkv7rGp8xUH6InovuIiRXq0QSM4UJRLhR2BLWakZ5b8l7ozInQsuQ7VirV/P4jLHEp
	11k4V5FNvYT0lHusMbC7jA1F/0URITCcZScteg6EZyhW8maXUIZUF1Ligd5vg==
X-Received: by 2002:a05:693c:88d7:10b0:36c:bf78:967e with SMTP id 5a478bee46e88-379656c93cbmr12482263eec.10.1794920615607;
        Tue, 17 Nov 2026 05:03:35 -0800 (PST)
Received: from [172.17.0.2] ([134.33.67.166])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379560f5e06sm57341639eec.19.2026.11.17.05.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:03:35 -0800 (PST)
Message-ID: <6afc50a7.453d2d35.f339d.30f8@mx.google.com>
Date: Tue, 17 Nov 2026 05:03:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5937923481164737175=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/1] emulator: Fix version of 6.2 and 7.0 controllers
In-Reply-To: <20261116212805.3083583-1-luiz.dentz@gmail.com>
References: <20261116212805.3083583-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5937923481164737175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1213178/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.36 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      16.24 seconds
BluezMake                     PASS      244.61 seconds
CheckSmatch                   PASS      222.12 seconds
bluezmakeextell               PASS      79.76 seconds
TestFunctional                FAIL      1061.02 seconds
IncrementalBuild              PASS      243.19 seconds
ScanBuild                     PASS      849.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v2,1/1] emulator: Fix version of 6.2 and 7.0 controllers
WARNING:BAD_FIXES_TAG: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> ("<title line>")' - ie: 'Fixes: a938cf48d083 ("emulator/btdev: Add emulation support for HIDS 1.1 SCI commands")'
#125: 
Fixes: a938cf48d083 ("emulator/btdev: Add emulation support for HIDS

/home/runner/work/bluez/bluez/src/patch/14990576.patch total: 0 errors, 1 warnings, 49 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14990576.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2838

---
Regards,
Linux Bluetooth


--===============5937923481164737175==--
