Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794181631;
	b=m4k2kTtuKHUaKXi/QMYj0lUo5i9zqI/QdAWSem7fo0gvg/JIcqsm6wBUQQwFHMEdPSUP
	 pK/p1025yremZTCERUYDSUrWFwN3EM8o8wScAKZtvnw2/zkGQ/VmV1Lev6sjSont10A2a
	 wzbOFqYFTrssTIAVc38ducYkB4rI6Da9mbVZqJwHKFYse5dnGWjcS4yiSlQ9aoCBQQOgV
	 DTE5QFQqVeQH4UyM1RxljEKb/DMS4T93+B9/eNGOooxSVrkedyyJxgwpsk6GjJoAwNxoU
	 penvntKEisvThNWNaWtgd67AOXMpkQcgwaQZJ7neCdIb2SN5ov7Ex3B1gdz/pZAEdLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794181631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=p5VDpVNl2fFSJ7IHbmZPdOb1rRFliFUw0ohEoGRX+AY=;
	b=HcNLHz83o4I7k0+C/bR4mbFVssk+gD93DySKMBn0Nuaq/R9TE5pldrvf/fTQzGUQ45+5
	 nL8F9E0003e7WcO3zVbUA10WojACJB7GlPZA2Nt4aYntlZ6mVhjpVJ9gRTXI5kYiO0JAc
	 FXzSpiTDAPpPqNUMQPpDculr22702NmyUwI7nB7YWkwDvaNuVBL/xL3mIMqwYg4CXMiAL
	 zpYCVyKvNKmX44shkcdrSFlIKZb+C7eYccLO0Hy/YHbiKluxFU8jHJ+mB96DX6xn8nW8R
	 lsHpEeWjOMLPNrQI6TiKCf6ZoCERJdnpAdeHBxkCsJNqUbbHVj9PD7tBeZXIKGp9DkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=So37GSnV;
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76821606A31C
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 23:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76821606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=So37GSnV
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53ec92375d2so119542b6e.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2026 15:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794181630; x=1794786430; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=p5VDpVNl2fFSJ7IHbmZPdOb1rRFliFUw0ohEoGRX+AY=;
        b=So37GSnV6yu2bzUQW9v4NyvyRDlTwedFEe67pyU/AjGv9LLoxV0RSBgGoIezqvzs6N
         EVD9oQzX+euNh7Zoy3thjGIcXugPJqtDKkXkYrJhTcXx68GmRNX8UFpCx0WVorVPXA+Q
         xy4ixHa6s0Er7mnLUQHvU2VXyyKIeBXxx8qhD41pxTSRws/T3Mxk53VR7/5nao/GdpmY
         S+enxO87taHY7tuQ8qrVuw8BK84EY0LvHVCqXLs5xAyaSCU1Th+BJ4iyjA8Bd28S6L9G
         rJLyS9T1YauNFg4OGWHMYij3ryZvj+0upjpkXXLLuG97Mt4nvVlj28W2I4Kk3C3GZw3V
         HyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794181630; x=1794786430;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=p5VDpVNl2fFSJ7IHbmZPdOb1rRFliFUw0ohEoGRX+AY=;
        b=DY9YowyMWOXgwzXk3WHqt4c7MF2yXWH1RhyvgRQTCnmrOATyvuInPj01xL8gDywI7V
         bkmoU3U4OK5pHyU47GfrkCmwWbdLmL1qM9SKWke0xBlanD3rMIgOgrlEJdADOT/bv4XL
         LRKtc6Dqb5mi3ynQ3tgxf5yGWwoWDY07CLNHl+5YrmD5nVryiOPkqTtYDuOk+oLT5tY2
         LCdq5Wz9VSfGFPqjAlgL4uhZiC6I3Lqth1dUfkwLx86jwsNmRilMec6R9PCjkf65ST+8
         NTCgY0TEIkA+I/tOxhNq+rZzih6bxzoQhiXequJDGVm1ZUk75u0tesXfhsLgm4G53dJG
         zZ0A==
X-Gm-Message-State: APuU4Z/t/pf+HwWn11pCP2+UCGsNzdIZskP4NRUYZ9pRkxa6vv2OgT19
	o4TRpIeeTri9qp1vjP9z3FD0MugS7Uv6fvH2LDEj7ILaBgf9f+v/2qIkYWGb7Q==
X-Gm-Gg: AYBFou2rYtqm5FwcJBgmHkklVPLNLEQTNwrzcMiiA46I5xLmsEGOgN3hbxBXeZvyzWV
	qDy/Ujk5SMqGVa0lHFpcU3yBKP9CKZ9ceV0nCeSFVIf3vM5ec4NMVB3kH7bShuxRngd/BwgV4yf
	nGyhc3C8G5K/syh0nfP/9w17UF80TkmkCEQ0ThyB7IGUaedrGH4Bgp5S7bWC63kahbuod0ReTd6
	5GOZ7601Bw3Hng6fJDCwIod2aiDN45fH4D8AvOLphNOKHsmpUyqaOotokSsbEAaxdjkIorpqFM7
	wjcl7QmgZccqmq39G50MbvNUax5C/OS6xNSMTA8nsDWix9rfCRx4rx2WjGjIU0LDVjtghrlMc6K
	GC88Ef7+8XEKXIzMIbbmU+KLFFjhD5mciXR6ByCb6DEBGDhjuifS4ZmAZZtrCYkDmE5DdCKNefh
	T7t28WTTR4XCO0jrdBLRhUsg8zLcQuLNvZ9yC3+DJc0sVFgJUJsDBk+qrOcYzg6TAgEIz6UphFB
	jeBev+LKQKlf+aygi17hH9guM2mLxX6o+mWGACDlW03ZonZT0ghau7RoY5tdIjD
X-Received: by 2002:a05:6808:4f13:b0:4f5:eaac:517a with SMTP id 5614622812f47-5681406074cmr1779299b6e.1.1794181630316;
        Sun, 08 Nov 2026 15:47:10 -0800 (PST)
Received: from [172.17.0.2] ([135.232.193.39])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813ac62d0sm3094682b6e.2.2026.11.08.15.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 15:47:08 -0800 (PST)
Message-ID: <6af109fc.31957b85.1984ae.4ea9@mx.google.com>
Date: Sun, 08 Nov 2026 15:47:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0976951744007024277=="
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
To: linux-bluetooth@vger.kernel.org, NoahWeinberger2003@proton.me
Subject: RE: Bluetooth: validate retained LE Set Ext Adv Enable command length
In-Reply-To: <DiB5DgYqITLLCcetFLdSxmGUcDfzozcvmS5i8Owo6GfN9hpcRbpu3W2uQPmg_oSz52yjRq9uh49bQtOFPli5RZf0_IrM_S4cqdRQhax-m8g=@proton.me>
References: <DiB5DgYqITLLCcetFLdSxmGUcDfzozcvmS5i8Owo6GfN9hpcRbpu3W2uQPmg_oSz52yjRq9uh49bQtOFPli5RZf0_IrM_S4cqdRQhax-m8g=@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0976951744007024277==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1205518/

---Test result---

Test Summary:
CheckPatch                    FAIL      2.91 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.30 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      30.86 seconds
CheckAllWarning               PASS      35.34 seconds
CheckSparse                   WARNING   37.92 seconds
BuildKernel32                 PASS      30.57 seconds
CheckKernelLLVM               PASS      34.85 seconds
TestRunnerSetup               PASS      743.90 seconds
TestRunner_l2cap-tester       PASS      12.91 seconds
TestRunner_iso-tester         PASS      11.02 seconds
TestRunner_bnep-tester        PASS      3.16 seconds
TestRunner_mgmt-tester        PASS      88.84 seconds
TestRunner_rfcomm-tester      PASS      14.90 seconds
TestRunner_sco-tester         PASS      5.72 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      5.60 seconds
TestRunner_smp-tester         PASS      4.39 seconds
TestRunner_userchan-tester    PASS      3.24 seconds
TestRunner_6lowpan-tester     PASS      4.48 seconds
IncrementalBuild              PASS      29.25 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: validate retained LE Set Ext Adv Enable command length
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#103: 
Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), net/bluetooth/hci_event.c:1669-1735 (hci_cc_le_set_ext_adv_enable).

WARNING: Reported-by: should be immediately followed by Closes: or Link: with a URL to the report
#113: 
Reported-by: Noah Weinberger <noahweinberger2003@proton.me>


ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 2 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14962585.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: validate retained LE Set Ext Adv Enable command length

1: CC1 Body does not contain a 'Signed-off-by' line
23: B1 Line exceeds max length (166>80): "Affected version/commit: mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07), net/bluetooth/hci_event.c:1669-1735 (hci_cc_le_set_ext_adv_enable)."
24: B1 Line exceeds max length (122>80): "Handler is longstanding; the fix class was established this window by ed4d302af7 (CIG params) and 1eb52f35fc (Create CIS)."
27: B1 Line exceeds max length (124>80): "mainline fa4ad798f6f681031775266044ba1b0cf3c670bd (v7.4-rc1, 2026-11-07); every code path cited below was re-verified by the"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1090

---
Regards,
Linux Bluetooth


--===============0976951744007024277==--
