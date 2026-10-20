Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518382;
	b=GQ0eh/Vz5KEUllui9M89sECpRaCxlPly8NhdDkWXMHEmpqHsLlS7TESJA5PnoC5IigKK
	 FkpZ3cTYcW5UluUveRsPgholYIgOGn5hi6m3TRo9JanjsL0unOm305XlK9KuPAfYuedcT
	 pUAZnKme3zVkmFRNxx0v6CzYrdLXpys2pdXSXMCc35o8FPxZIj9WPsbDLnXBEo7TOiDTv
	 ZuGCSZ3Ma0KCWId0IKRnu7MtXaDE248N9phkGz4DXA3inkO+HKYoh9QpzDiOxWJqO6M2L
	 RTjROuKXmd2YoI8CbTgFulFI8PRzbFVQum6kbqxWfmgICN1iiQymIQa9rHepZoELQ/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518382;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Eg+TSetdCSNJZ3aaAdsT3Po1wfzWh1wq7yOQoufmfIs=;
	b=1H53Ctxu00KenzT8S6cS9Na+Bj7Fr7GzRmv2S8cpWP4QkTl9b3tmipfzDq/RNiORxnTn
	 kxCu+sdSBBugszx3T6etVdOBGQ/gJruimUQTXi9ogYEBeM/mtW6N3zUDMhfGpFndjpwxa
	 dwZ+PFi7GDnE8s7d6hVC8RSyUNOuCbvZRJjU7HI5Om2WWuiTp2RZzfQb0JCKbqRokNv+w
	 G7OUEl+JEIGh1goWTsXGrSvmNyGer6atrQoKpAEBndr6zKWRVatragCRWyqGkk2mtTRvp
	 Tqhrf00p4k8+Xscl2j/ail6oCEnGQCG9FpwCBhdSnoQJkyJ64SsYUs6bCvrTSrbxTbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A5H8LqFo;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434C606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 17:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E434C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A5H8LqFo
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso2080942a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Oct 2026 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792518381; x=1793123181; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Eg+TSetdCSNJZ3aaAdsT3Po1wfzWh1wq7yOQoufmfIs=;
        b=A5H8LqFoz/9mzAvvh4274ZIQS6n/O4rK/+M2FvISKlbD9GKzDcLtA2zZH8mmqFWXnK
         /0+cGH+FG/dfAwMm8DY+EfAgqJfNcuWmLdNTF49eq5AgHm5cE7q5e6KWYCccUhX5IoRo
         ZoAcz8xf37Sa0b8Cu2hMjGw8cOg7VYuHNFr6m1m26yDSgodPvgb4aRXxH3DKmD1LiYYo
         HMkto78yhX+tJteRDicKvOdbaJQix0qVliKZbVcgaER9K5bt3Yj5rHl/aJsaZzYeqlX8
         M87vsKApN56QB/TZh7R3FByOet3MmX8M202V7j5bWzgjNX14CAd915az67ViTTguzD/v
         afjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792518381; x=1793123181;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Eg+TSetdCSNJZ3aaAdsT3Po1wfzWh1wq7yOQoufmfIs=;
        b=lCM8ziJxZ7IYOAjkuzCMtuEM23JE9UT2KkqImgiayVX6jj3k3vryW8Wm4RC2TEHOfI
         NEY6vOu0CJ6+k7c7gklxD54XQrCHmkd0VSHGhSaYqauBg6wM3S+uR4JGG8XFtd7jWFpO
         fT3R70DGKrVMLhokMuLkxuoxZDxaz2gLijDkYdgdwUlXJXpXLTKgQnCR4LjzFODn7QN1
         VUT7zWVCuGm81S6LOcyqZ62+K7F4Gy8vghFrUe3W0znFdzSSkSaJgX+0mg/f2y3K57wN
         FNnSxU3zd6TDq2F8LcLDIlXjpr1buIURSglT6ksK+GB1myX+aPaTmlLUiqmzi94nmrsQ
         eEtQ==
X-Gm-Message-State: AFq9FYI7+sp7N5avLmK/hgO5tj5AcnyQ6OSQLxX+oMNc+oxEw0qNjTTT
	eaKtwvV9r+KniRsq5C8TDCPrN3B63Bx1vTulZGHKNk3/u8q9+OmMkUwma5cBVw==
X-Gm-Gg: AYBFou1femmcwfFaYub28sDsE2H++8N0JDWCpuddkLMOvDnRB8c8TPMzflKvKsJxHA6
	73hApKT0oLedKICgrJgilf+bEeyCQynS0TS9ljK2HP+qch4aHKU0+FR9JO0fG61IUtgG3STus7f
	V5HlF+W6IAJoNH1j0qjjVg9A4tS+zf0njpPbhFdtBgNe+Sdtcr5ynRCDFAM9lP+GT4o6x9u7AVC
	DURsbd0dHFBkLtDTba5gZo89LLBTmW3MrH2j9EieWz6xXzabMq78nXdTUv/FxXNcCBGvo1w+PWc
	j9KKgJ2ekzG6qxuHE0/taoe1we4adMZZELSsH+5AquHo27IfnYxozjPjjRsa3qloTUf8ZwRDGUs
	SRSHRLQ/nax+dA5kam5hsnqM8KCqnBbm6EFO2bgZzKqY8shhuAz8RFQqfk7ZZ/kUIHoq2yJRAB8
	bFD844EtHpkqCbTxP8PirQSJkPasuVfPCp1SWd9gk331FL8jhUBx3M2z5NqGZL7KLDAQVqoHo0P
	IJv
X-Received: by 2002:a17:90a:51c2:b0:3ad:1da4:2ddf with SMTP id 98e67ed59e1d1-3ad1da42ee7mr4132394a91.51.1792518381101;
        Tue, 20 Oct 2026 10:46:21 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.63.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8021d29bsm536943a91.4.2026.10.20.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:46:20 -0700 (PDT)
Message-ID: <6ad7a8ec.6129dc48.32da23.44f3@mx.google.com>
Date: Tue, 20 Oct 2026 10:46:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6359469622402766073=="
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
To: linux-bluetooth@vger.kernel.org, thomas.gerner@muenchen-mail.de
Subject: RE: Enable bluetooth on BeagleV-Ahead
In-Reply-To: <20261020132604.90708-2-thomas.gerner@muenchen-mail.de>
References: <20261020132604.90708-2-thomas.gerner@muenchen-mail.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6359469622402766073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1189748/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.16 seconds
VerifyFixes                   PASS      3.32 seconds
VerifySignedoff               PASS      0.23 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 FAIL      0.14 seconds
BuildKernel                   PASS      29.63 seconds
CheckAllWarning               PASS      33.37 seconds
CheckSparse                   PASS      35.85 seconds
BuildKernel32                 PASS      29.33 seconds
CheckKernelLLVM               PASS      33.33 seconds
TestRunnerSetup               PASS      696.58 seconds
TestRunner_l2cap-tester       PASS      12.78 seconds
TestRunner_iso-tester         PASS      10.60 seconds
TestRunner_bnep-tester        PASS      3.05 seconds
TestRunner_mgmt-tester        PASS      87.27 seconds
TestRunner_rfcomm-tester      PASS      4.40 seconds
TestRunner_sco-tester         PASS      5.60 seconds
TestRunner_ioctl-tester       PASS      4.60 seconds
TestRunner_mesh-tester        PASS      5.41 seconds
TestRunner_smp-tester         PASS      4.29 seconds
TestRunner_userchan-tester    PASS      3.14 seconds
TestRunner_6lowpan-tester     PASS      4.34 seconds
IncrementalBuild              PASS      28.77 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,2/2] riscv: dts: thead: Enable bluetooth on BeagleV-Ahead
WARNING: please, no space before tabs
#239: FILE: arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts:397:
+^I^Ishutdown-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>; ^I/* BT-REG-ON */$

total: 0 errors, 1 warnings, 106 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14902974.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,2/2] riscv: dts: thead: Enable bluetooth on BeagleV-Ahead

11: B3 Line contains hard tab characters (\t): "	- use default pinctrl definition for bluetooth in and out pins"
12: B2 Line has trailing whitespace: "	"
12: B3 Line contains hard tab characters (\t): "	"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/968

---
Regards,
Linux Bluetooth


--===============6359469622402766073==--
