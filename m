Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641836;
	b=zTIxXmgCfbMhzmmSPTbRiygGlFCZKzQPotuwliPhZOQfwwhqxt38U6WlxljMGoguJuxt
	 GYZ3MAwtKs2WC0eiLZLVpqy+lYi/SPJ77w5j3ow3Y8pcilkpX2YX9plDJ86Utv4LJvO+t
	 x3/N9UfAEKust6t1bDxQI1ohuZm5VLJk+iS2IPaUgiQgm0xyvoTWkvuMXgX/kIzZQC6DY
	 y3VV93yzKORmqSmeb2GR24U+DC8tubejBjPumfHe6FF8kfKpRGjhdgK18dRYqXBBEE3ov
	 ofD4/5ewozlaG4vp4+fvECEX7xUpFS8zW4ShPIcx5FeXA58sa50r8QL6jz/w/nJvabQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=S48PXidobUBJXbQ7+NcgAGtcRuE9k3EphQdMEiT1PtM=;
	b=la+fqSnsSwImUwF3rqe7WCKIhImiAtDsD3tNucy8qVicekIsZ7CXns1Hm/lyjzlrE3+0
	 Bql/O2h0RzLIwmwtelmRNXHRnv4ujrZbehvp639ZRxsOgkvSZAwhloIPxBLsqyyI8tGkl
	 plSTAin10rapn2PwQBWYR7wJotO926JgN4Qk4pHldIn6VmLDeU+AH5MnuWKJnOrUJQArX
	 zpngZS3DDUgKx98hb7Q8drJb+wkVolhFH2KxLRfKJw1ClVkvU94l+lENq8KE0ux9dshGa
	 V8Szn9IpJPs2PXc3L7/mHYom2GTET5wTiy4mfL3ijQ6t5NLzNPZPPkPZhBd8pJG9DZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SkkTnAL5;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1020606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1020606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SkkTnAL5
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b244fb7fffso6568739c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641835; x=1796246635; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S48PXidobUBJXbQ7+NcgAGtcRuE9k3EphQdMEiT1PtM=;
        b=SkkTnAL5DODE4B4hbK93n19P9ukBC7Mm4Kka5ofcCWLWqizSi+1TUM2/zNBkQhTx0E
         J1vSoMBryBxS11LhzUTl7pyA6K18dA/Wl8jOYhbHNJIpu0XH+X4RbqybK6sgNIAcP9iQ
         FZIjxw00tdq5ibV7TK6pB7hjCWn+e+SD6nmI7CgahsdbP2Ljf1OGS2DQTHCs2r2nigFQ
         czgW8TyUQQV8dNxhaHFKkm9WBfDNr1xz8Gipx2sAnTCumykz9TMK34+cuHH7ZcEmbgBO
         rZ2dZ56rlOkArscQ5B9EBWADIXSsCrDDLQY/EuWEu3ItFHTlCQnAyzELeYwl1pkuMCnf
         +eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641835; x=1796246635;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S48PXidobUBJXbQ7+NcgAGtcRuE9k3EphQdMEiT1PtM=;
        b=q04/LqYWiYk2fU6TvmGpX9krcsjpXWtRJ2GNF8G6A+BKg19Iwc13AuERJ3so8JPGGB
         rjXhxzITygYDQPOYiC2ZZtd3rsrYPaPWsYpPr9Ubh3DEhjSEV2aB+ci51ku+r3akPCU0
         oSbM+2SX08JoMMicjjr82yuAupf7lwk2Oj9iomdKkkRDghNBpB85ho1yQqNxwxS8zIz/
         gDAZmhDXSQqYEV0eLUvHvnwK+yv1QH4MUjc1eOfLGfM1fxFpeDTAuMeDelugp2RtQyKF
         ihl3z5USBTc4yE9W0/CrAvyY1PYpSFSsNOk4znMwMOy4v7kn+yTfQiLtC31Hd1eS53Bm
         i0mQ==
X-Gm-Message-State: APuU4Z+qoKntXvVZxhA+14Vw1U101umx3CaxkVafuHkYbS0286erEd3K
	jSlcV3Nf4P8fBw5yKnz5ccDuk/48/6QSYZFRXJoIkVwzOy8ZN5OA5XsRz8izHg==
X-Gm-Gg: AZFdTZcGQPDuMgpkKr9qpSG0WN3oyb3As4LCwW4FOyvbjK+8AbD0cSXlPmgUCgYXbKu
	zdCjJ6grx07Q7xuMre1LTfs5T856x8u9YLWLUJeRwgKOdEL7Vyk9mQ8X4+BzTY5QfYLLi5J8EOY
	DnulIEGcgVjQxz9/rysWYBwE+8wn/DdcLLB1m8EvOGHLDLTQRA/xQVOnmUvRVjipyeOm1c0tcof
	DUhNoNsmXfFyngAEYH8j+2GhYvnR86NNQNQvGfxTTtQ0fPHA0Ebxe5MK9mEC/YGt3Zo/zDaxpz0
	pCMRp6xTFlcGxU3RMBx9yH1kkJTw4BbFbEv0aoERhN0ZcKc0RfViV6xlhKE75ep8GE7SiASNjag
	ssIYHvRgSpu3ZBMeXtzluO7ekC6RNn5aOhkKtsqc95A3ZrcR+jhSszS1wZwqrqj67KUQlXztPlk
	A1ieyuyFKcPoc+x++kBforITxxcP7UPSjTdk2e2NPCUiVaPGHuSXB55anA8bsgFhWx0g5M54p3M
	n/lB6c6sZ7jNt3Kbgjr6LcmIaecR0VmJeL8/+umd615/DMXmweX99jwON7h
X-Received: by 2002:a05:7022:2209:b0:1b2:43ac:d3a3 with SMTP id a92af1059eb24-1b5568b9e59mr24170153c88.24.1795641834936;
        Wed, 25 Nov 2026 13:23:54 -0800 (PST)
Received: from [172.17.0.2] ([20.171.2.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ffa8csm52446242c88.7.2026.11.25.13.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:23:54 -0800 (PST)
Message-ID: <6b0751ea.bdce4de1.19d37b.c3eb@mx.google.com>
Date: Wed, 25 Nov 2026 13:23:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2036095995477971144=="
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
To: linux-bluetooth@vger.kernel.org, andreiab9019@gmail.com
Subject: RE: Bluetooth: fix bonded LE peripheral reconnect completion and holds
In-Reply-To: <20261125130828.18441-2-andreiab9019@gmail.com>
References: <20261125130828.18441-2-andreiab9019@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2036095995477971144==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222151/

---Test result---

Test Summary:
CheckPatch                    PASS      1.53 seconds
VerifyFixes                   PASS      0.08 seconds
VerifySignedoff               PASS      0.08 seconds
GitLint                       PASS      0.49 seconds
SubjectPrefix                 PASS      0.15 seconds
BuildKernel                   PASS      28.18 seconds
CheckAllWarning               PASS      32.25 seconds
CheckSparse                   WARNING   33.74 seconds
BuildKernel32                 PASS      28.18 seconds
CheckKernelLLVM               PASS      28.36 seconds
TestRunnerSetup               PASS      654.55 seconds
TestRunner_l2cap-tester       PASS      15.70 seconds
TestRunner_iso-tester         PASS      12.73 seconds
TestRunner_bnep-tester        PASS      2.99 seconds
TestRunner_mgmt-tester        PASS      86.99 seconds
TestRunner_rfcomm-tester      PASS      4.29 seconds
TestRunner_sco-tester         PASS      5.40 seconds
TestRunner_ioctl-tester       PASS      4.44 seconds
TestRunner_mesh-tester        PASS      4.34 seconds
TestRunner_smp-tester         PASS      4.23 seconds
TestRunner_userchan-tester    PASS      3.08 seconds
TestRunner_6lowpan-tester     PASS      4.25 seconds
IncrementalBuild              PASS      43.93 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1225

---
Regards,
Linux Bluetooth


--===============2036095995477971144==--
