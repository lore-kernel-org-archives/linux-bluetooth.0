Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794005451;
	b=YZYslIOWwwPPAb+JHGNfAie9MAcQfzSFRHmq279fDt3AqGcvZu7rToGTv/48k6AYZsfj
	 xwdNUjohiZEoeUq543ZhSU461xcE0Hqlnl28NWuWZrYSc9NbAnxjT2VcR2wZnbE35Zaql
	 1TVPT4SD0e7x+FkkFrm2W+nU3H/IZuxFq32TdRSJRg5nn42HEedfIzC15CZ6PP/WoSZ7V
	 cAb2Z+qB9JHIgPYv+0B87nGYbU2N3kDUg976D0hAV3nqTl1ro9V41eLRpCGcpshvT8XjJ
	 rvsJZYqF+2TMkbwDCMBvizR++sEGo2T3EQ99oGsV/9TVuATA6sK52+7v32LsDv9KHkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794005451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=UFqpnUNvJFxfyxGGxnq6QtdHiJuyH73+yG+vsFys4s8=;
	b=pfYefZkhP+7+bxsHGfeYNoN1SMzuDcYhlU35+1Tvbairg8tGzmwDM28dyk8ElQNXO9wH
	 6mgbHAaKqD1f8I3rLJ8wrLrKXoUVcutCRD+thgqOrUEWy0dD9MKORGRTPMIP04XYW0IoY
	 cfAXrQZ5ZEGine0h3QPtrNldw8c+ZnvRPHdguO1IaddseArLxbr/ofZ2cAchLePKp3jIp
	 onAlIgtcVRKcfHFP6ivtOibwtA+iqQxFq0PNZs5m9SPaeqFVuArkCuW3P6jiqFMjnPr9n
	 FhuHpqlzPh0wM1lkkOw7ltqFU9GS1nwjGOiFXhovp3lQOX540Kk2WkR9uNoGnCiLSlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFuo6UAn;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6E6606A330
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 22:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E6E6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFuo6UAn
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-703be215729so465434eaf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 14:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794005450; x=1794610250; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UFqpnUNvJFxfyxGGxnq6QtdHiJuyH73+yG+vsFys4s8=;
        b=wFuo6UAnrRzP2UrypvWCVNRaaI2iil+XEkWL2eaAsTw4Mwwt7BxyIL4aGZotjBGrqQ
         Qz9PccNDMPprgf+mHiJuwHS+qr/hO4usQFd4/cuRoQcVya8u2hkRx3TM4wbAxNre4fhR
         CaUTE30iQiT6jAlDajTaHOOxrwM+gNR5lCpU/vgj1unCyVR3mt7UklRpTSvmfzV0Krwr
         c98jBZyBT5FViUNmBf2ZDWU3l0KIbUQn92g7xX48o+lEK+KIthGx7Nv+RRODQ8gCqFYk
         6ES+6St4Ib2qMAjmNjhh4v7xUBbmzfUPpgIjRorcx6S2BZBvgDb2XuEE6LRYEqoHvM3y
         6RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794005450; x=1794610250;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UFqpnUNvJFxfyxGGxnq6QtdHiJuyH73+yG+vsFys4s8=;
        b=y5ldmzy/Dsq4ZlxOHbAUdAAW+hFWcYe6h0IlihhmIzMtO3Zm7X94tJQRgxFlqMGbau
         Hq1tFWgTeMJkWOtOePxBNA57Gs+1fgxKd1kCiB2g4WPar9eYGs1aYel3cHC0m5H/V6Af
         JKgIgJhzxI+9ktrrFo1EaKCSXqvsIHfXXxzyk6vac5Pt9Jg3hPcNURLtMYM3jnCvNedv
         vVvWxYopacRoKEOUzP6v+ORP9KHCjIUMyQSozhyvJ+bU5AWu3sOeVFwnhcvsi7tJDzlv
         Mf9FX4RzdxQJRaydzv7MJTG/gAkdiWPsowzDI2fz69uqlcBUslE/hxPH3VflLX5R5quV
         yMUQ==
X-Gm-Message-State: APuU4Z/J+uW2GcHLgjJtZGI01sC0mTrqBwezqykOUDhbkR8Pdo6kXsbO
	EbEr8Q/qenK1WqqABb/mdp1D/gz6W5wD78v2ULE6b4U/dkLVNBzwac6OKQkTCw==
X-Gm-Gg: AYBFou1pz8R15BjGKH53Z4i+g8j+deQyrrI8T2dYg68yO8AtG+0MeuMLGLz4NaLIWpa
	xFyrJNtGPHL8MBW8EF6G9ybNjPaXYD3EabTN9or7LnzWVizgDajrpFPKEhy0ogXbkP+GHU0hEQx
	BIYfdsCPkzc0xxgsSsvUKno1ZjzaIY9HivdBQvQpHBg3O5qpvZyp/Iv52YISDDd/b2hv0ugdp4Z
	mFFDp6hmRE92V8s5US143asKYttfkIS2HJRmSzZle37ar4uTtttNcVFlR5PhaYo0BxfQYqPDMt0
	593wM+VryFTJU4xVbOzIDLG/5TGgvKQgbPexyN51OYu3ehhIcXvotXrPY8R+Hka4EMK3MwHxQX+
	kdvASqB6HxMa3yHFXI/l19HuccKCOpIi4CMQW1fZJXlN7CwpevUUhcjrlC8IrLx4qTFE72ZvYXP
	xlBHbnjj9fS91Xf9KSBrYWPB89QTcyT6P4/J1TMhs+T9Mnbu1mWAZoA1Xu6A3Dsn0vYwuXrJDjx
	uJscoipDgSnhlY9c9NgipvaOX3V73YjzAzy/EZSeakm/d1+bylc/cYvkwPltV0Vj41GeG6q+4VB
	zNeGBl5X
X-Received: by 2002:a05:6820:1690:b0:716:c2df:d9a2 with SMTP id 006d021491bc7-716e78d2c31mr2115220eaf.44.1794005450185;
        Fri, 06 Nov 2026 14:50:50 -0800 (PST)
Received: from [172.17.0.2] ([20.64.107.177])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-716ea0f4d6fsm2524463eaf.8.2026.11.06.14.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 14:50:49 -0800 (PST)
Message-ID: <6aee59c9.389478dd.6b9d6.097e@mx.google.com>
Date: Fri, 06 Nov 2026 14:50:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7640493597430253767=="
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
Subject: RE: Bluetooth: Add support for HDT and EKS
In-Reply-To: <20261106215738.3562688-2-luiz.dentz@gmail.com>
References: <20261106215738.3562688-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7640493597430253767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1204567/

---Test result---

Test Summary:
CheckPatch                    PASS      12.70 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      1.62 seconds
SubjectPrefix                 PASS      0.60 seconds
BuildKernel                   PASS      23.27 seconds
CheckAllWarning               PASS      26.55 seconds
CheckSparse                   WARNING   42.46 seconds
BuildKernel32                 PASS      23.30 seconds
CheckKernelLLVM               PASS      24.11 seconds
TestRunnerSetup               PASS      556.50 seconds
TestRunner_l2cap-tester       PASS      13.25 seconds
TestRunner_iso-tester         PASS      11.52 seconds
TestRunner_bnep-tester        PASS      2.88 seconds
TestRunner_mgmt-tester        PASS      83.85 seconds
TestRunner_rfcomm-tester      PASS      4.09 seconds
TestRunner_sco-tester         PASS      5.14 seconds
TestRunner_ioctl-tester       PASS      4.30 seconds
TestRunner_mesh-tester        PASS      5.15 seconds
TestRunner_smp-tester         PASS      4.03 seconds
TestRunner_userchan-tester    PASS      13.41 seconds
TestRunner_6lowpan-tester     PASS      4.18 seconds
IncrementalBuild              PASS      99.82 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/1082

---
Regards,
Linux Bluetooth


--===============7640493597430253767==--
