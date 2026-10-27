Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793136250;
	b=sNpOUP4XRGinT2BdxCeOewenG9N2gT4PfqnwNWrdc/BVUnMAKHIWRvMjf6X/TP6ZU2Ml
	 8fMzry39EiqtnzfqgVl6BRWfGWmk7E2v7nBdWtOjYBViaVo81a1k1JKzeSigdgI0H7J7P
	 zehDK3bDBRbFqf3kGiK9t8UV1QZkQ7BQOzZ2i+n5dHtWvBtm8PpbmugxZsyMYoIO1I2sI
	 kmQ/72rLZnEWtyNVrXmzAvcx+Ke3A5fCdewVhFmzO80YE8c2s/0y47wCwOLjDbFSAe8UI
	 v71w6/tkWvq2WePd8UCGnbfkukCgq5l8OUJUjQXpIm8oUtFx8iXenVo6RFxwA1H64RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=dSqST02Nk0WQDHRYGQyCBobVZM7y/kWy02RiCE6FqSg=;
	b=gixPjzdclR2EKoKtCucmRMMt2/O77eGGh6DBBkKuZ/lwzV4iH+N4TccmK9GsK6Eew7aN
	 EllIbq1iXIdlClblUE32ig1l8ARl65JiImkh2XkGzJBOj6K1bmpWHreUHPOdNsKvzxI7V
	 pDncOWZpFgngWXPkIi1RHmo+idGxPQ5+k/VRxpGhAyAP1Utj80Qn0hEckotJTyQwDtkWg
	 R6tklcNNJwD/6smnKcwXZljIgDWcvfdrW5qXPD0DGu70KVc3cQvk1P3lTdlf2hCnSgvCQ
	 ItV0mXvjpf3HATXlad51wYXLXGPC9SticPgnSH7WkuUca9+XzkDKK01+YLK3MqSCFgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fT7PfORz;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C4606A31D
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 21:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E07C4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fT7PfORz
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so200479fac.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793136249; x=1793741049; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dSqST02Nk0WQDHRYGQyCBobVZM7y/kWy02RiCE6FqSg=;
        b=fT7PfORzHXVSKHyfb3a8/Z7NqWv527urDN6OTDX+J70OKu07WB5p8ko3oznueYiZO1
         3RExY7Kqq6oCv2vjMqQoCu83j6SPfeEzyZJdRs12CJOHkX16D0nOoillebXMf75Ty8Ez
         RFrmCowQj7ZqLD1sBssAo7tqTxtFee+oDtHicfw/WHdRBhHVU+2PFWHi8N57zQnftM42
         wfD/hpxRAGqNkUBlLNp73Gi0ZgzgfiIaD+1/wV7b4YmFxozkl9hX4DYADWY783qQWekS
         tr/P5LH5ABXjhCp6N0TsFxUisVPLfs/Zbw8WyGIaWIqLPGEIA0DfdgZUENshriIqcerG
         z00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793136249; x=1793741049;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dSqST02Nk0WQDHRYGQyCBobVZM7y/kWy02RiCE6FqSg=;
        b=Ch8c+LezymGUaBunJxFbl77ZyIjJ5XYupvhuxDuYk/I0/QszZzmIRxrLcso0x/kTrX
         WqZ1IcJmv5C9n7GQXQpBHWOc5MqwG7xh3gO5YBMd2x6dBry41arO411UbXVhkxTRE0Ub
         RCtR2e9A5VrvXwb52ll+y0YBWDbBYvrLPmjzpsaSAPYvrKJC9+wHkAAh2/I5tergBxHV
         6cUDnbcWbY9q2O13t5t7OGIVjHZWCke6/USBU/PlUlqUIsLlQ1D8zENCv5pMHu9NdeSZ
         eDgrjXvOAmj+9gRrOJnZqjHDSA7YdlaB2CZrqNYIa2NC2smXhTJ1VNSV+dHU5GhxoGqc
         WmRg==
X-Gm-Message-State: AFq9FYJ2DyPWvlOdBodTjidsTONu/nkasgp7hshYC/G94YLzEs+Cu2P8
	B1qdfp5eyGGyveLu8I/6PdC50fRhcgEcEaLlDLc+N/KeW64s0dgsprUgqTx0UA==
X-Gm-Gg: AYBFou0V99bfuMoNKBidMcn8k8s3ZG6dGoCYvBV7oEMnijM1bTePjn4ih4q3/dXqMGA
	uKOHm/dOtVege1z70mRqc0tEOj7ZSZV2wpkcECmanLtHSCn4rQsp7Bwn1eyewZiFkwzPNbH+xAc
	gqQXFhJShVgWmk8HUPa2mF/zoK2ZyWN0RjpDb8AvcISdJUImrOwKz0HgVJlUMv6IDkUq2y+dGP3
	x/xIYAQhcdZoWsNxhMYDzoSn67jE4IXDDqGJ7Vg7Qc9EEy2EnmYSKkwCXKmiw0L/ej7OQe/rcrr
	GXkZEu7RUPptcYbPaAORTOVFMbzKInCzUSQIqNySfFlqoBaP31c5HEQbwZ1FV7ftWRrPsUTAF8P
	QHdq3Lj6YOlO5AAKRq5cxGw66pe7RC0Hzm8H79T7UzJEsh4p9zdmZh1W2NiQyE96V12J2h2P4dp
	6AYQfF26SEHJyeeJ6kfAKe6MLbgo5ZfHAvRnCpE5xEjITY9GoCrgL8Is9o3AphblE6IPn9MUsQy
	R+RA9PXYYJ3cxswZ17mRapuhWdojp3v2X4dTz6JaJeD8auQeWQaiV74ou0Gqk4=
X-Received: by 2002:a05:6870:e089:b0:493:7742:f0f7 with SMTP id 586e51a60fabf-4a8bb5a39fbmr620787fac.11.1793136248785;
        Tue, 27 Oct 2026 14:24:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.246.73])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b790298csm1034550fac.14.2026.10.27.14.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:24:08 -0700 (PDT)
Message-ID: <6ae11678.0327e69c.2d1510.3169@mx.google.com>
Date: Tue, 27 Oct 2026 14:24:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0202558476175033340=="
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
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: Bluetooth: hci_conn: fix SCO connection reuse
In-Reply-To: <20261027165009.2401154-2-yaroslav.voytovych@gmail.com>
References: <20261027165009.2401154-2-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0202558476175033340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194813/

---Test result---

Test Summary:
CheckPatch                    PASS      1.59 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       PASS      0.80 seconds
SubjectPrefix                 PASS      7.43 seconds
BuildKernel                   PASS      19.56 seconds
CheckAllWarning               PASS      23.02 seconds
CheckSparse                   PASS      24.40 seconds
BuildKernel32                 PASS      19.74 seconds
CheckKernelLLVM               PASS      20.25 seconds
TestRunnerSetup               PASS      447.58 seconds
TestRunner_l2cap-tester       PASS      18.63 seconds
TestRunner_iso-tester         PASS      9.25 seconds
TestRunner_bnep-tester        PASS      2.79 seconds
TestRunner_mgmt-tester        PASS      82.86 seconds
TestRunner_rfcomm-tester      PASS      4.12 seconds
TestRunner_sco-tester         PASS      5.04 seconds
TestRunner_ioctl-tester       PASS      4.14 seconds
TestRunner_mesh-tester        PASS      5.02 seconds
TestRunner_smp-tester         PASS      3.92 seconds
TestRunner_userchan-tester    PASS      2.81 seconds
TestRunner_6lowpan-tester     PASS      3.99 seconds
IncrementalBuild              PASS      22.61 seconds



https://github.com/bluez/bluetooth-next/pull/1009

---
Regards,
Linux Bluetooth


--===============0202558476175033340==--
