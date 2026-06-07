Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D672877F4
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Jun 2026 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780843616; cv=pass; b=TSNe6ibDztLdwIWzaECaxt8rVS/e8NKBNvpW7X1njTzS5rUallEC9h0IwcxCkBPqypq9I05k9gJfDg+gRIquC3pzLei/e73ZDDQWc/JXZ+mjtYf2sikldoARCb9E6wPf4UGUHnJpXLtbARgVJb+Ch65RCLztN6QLwy8DEvsmYMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780843616; c=relaxed/simple;
	bh=67/c+UTXXnjEz8vO79iapjeh2ti6FtO4f0yz0xLiR1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrnOfcD6CDED5o5HK4puHkiaKTktkhjgIkLIQ3ISt/Hzi0Z0mH7iJ2cyyqje8eMiLJE60OVWGDQAhOP5WQjijKpWnK4JMLDuY6kmqZls7U+DOshxD9ecvvTIvdA3deAOzZQmcTCFxZYLnv+VKnQl6LPT77rCutKusNy1H3Rn9tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eujDGkHU; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eujDGkHU"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6cee520ccso2564632a34.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Jun 2026 07:46:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780843613; cv=none;
        d=google.com; s=arc-20240605;
        b=YwBZopWBw/MM0Qk/ooCBDqci4H47w11tX9c2Pyv3/XJgvu+LRHPhspRYmAfqQCxf/L
         RH3euTBFbyrMdfGhhQKXDmBj5N28BsjhPLJQlO7i/xU8MeKbwsl4ipsWoEpZPHBdyiW1
         7/CyUT84Xfu72V7YRdfS68W8T/gi3Tj+3zldeAuYGM/5VjBjd37Il58hHFubPNJoO0jn
         SRA8sTyJ1iwSUhd08/3QN8Z6IIx+W2zGXjgnn8sTOdU03Gi0eCmq/2rXMjPOPKqbGLBk
         rNMcPk3pvj+0TWV2mmM7/AzEbILeyHWbSQhCGYoYirq983V8/e9vv24ZQ8QM2L8yfLzq
         0KCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+A8HMKtAHcdauOSu0FRjSwzg4vqbLgN0kPIY9AesSXk=;
        fh=2Rq9Hl1Oq0xBMUtCVF0yaz+sdlLaqPDeTIxE9MNFRog=;
        b=H4i1jxXiTKTSbdiAHp52N/7JMkOHPJAVJFdHnxi6YVOtLsTf6DwVj0txzYIz/+6qdH
         jkRuNf09mGpCzX6nFXNohacmyF3jBAtUgqWFnC2BhEWDZWVLckncQNjQ4SJ+3Bl5U4yf
         pa+CWksrNvPxvrjGmg409LFMARvgGmVUNEiDYoHWWYwHpcSHEwuzrTkJ0gSP/bKN2xYQ
         /Pmuuls7NYPGAT5n0qE+jo81jfWwoKivKbFAn5kcMcEAphIo9ry4fqEQ+1n2GqVM8QSB
         SRGEt17o/DhkH1IE766hiS+V2Kpi2tSJQzT4LpiTeBXJ8ORWCrXW3tyYIG1xT7V3Gx4/
         VtmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780843613; x=1781448413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+A8HMKtAHcdauOSu0FRjSwzg4vqbLgN0kPIY9AesSXk=;
        b=eujDGkHUD4+ZvULHFZrMitCwueEBtZ4ti3rrtxD0y6y6cbcFBT6bBGvGF4h4QHAwfD
         KJGkDdsi6NurtuXiM2HPcsM+a7lsOsyikRkm5mtCDQOs6/Eeuogck5I0juDIsD82brdf
         ooOEIGGnAB2KDfB2hZPECswJ81jltwJ6SoTliCfaojSAapCDJBIpqZvoOkIdiycf54wX
         3ZvjgDfdie4bJxvykXpD+GN2o34Bc1fL8ItOZL5fZBGYXdgV2EWKKN76Rkn8wOcZg60L
         a33ZnDGX8GE13iSZgMmVVQigmM02gq4To5iZOwSorewAoPFxNiie9H9Mm5v4C9fH2xrx
         x9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780843613; x=1781448413;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A8HMKtAHcdauOSu0FRjSwzg4vqbLgN0kPIY9AesSXk=;
        b=J+WzDFkm/BC0fqQAljLaZ13Ji/QMW1wpiCQpkPs2VSuuivNSUxtUHhUnkB0MX/QrTy
         96xcGjcGL6dXYyO/IYKwgzVyjIaKJ4yUgZcRH4O/xTiPnEV+BjTI+NeS8+epiVh47i+9
         HGwgbzTnUZvkwH1rDjT3wz65n/s7O4CU51558hE+LfdyEpK+628CYM8WDkuj83KWREAN
         yg0xQUQ/cPmKoq60W9op+UtORbm1QcRz9hGUDBw9ECEoU8+NoHlunqj5W40Ts+CmK1B+
         1HRT4lqNHEeIdhAsMxiK5XfOP5FEu8LT4SNhlu/C6XteApz1sp+CIeCmUXEQI6BYlH+D
         fnkg==
X-Forwarded-Encrypted: i=1; AFNElJ94YCR9cbX4MmEUzqz0hvWEX6uhZay7EPaq/f9YnqcgMDiNhpV5lc+LbygWb6lhl/M731KV/iHiJQ5K/4Bprr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuENCJ5m4RLEZIB61EbihY2qc0vasJ9TG//MHqsohtRyS9u7+s
	G8ibGvlMub5G9l6soRlj/mKgghWZqUmuJfbQwYDMTGZigR/QHQ7uKPc4++02voQ5OBAMP++kQfh
	C3n4zaDj9aQAyXQHO3fl0Dyt6GKItlg==
X-Gm-Gg: Acq92OERdjBu5GvAruV6Jfy1Ccz5fegqtTEVUIjUGjd0Uvby8MtxRxijOZOCDaX3rGJ
	hnxSaXrO0L/HKqMT30tflAVgLKpQkSCqdn65rOwPAsUboKH8MYayDSa8IDG4em3nZtVR5RRQrpA
	VURVHYH78k/X6xOjYsftqq7hnhKGjdOiStIgBTKFyLG1fVWKPmUi1n02vpNl5aeRenSFd6vnlty
	J9925339tdVMFeYkO33AeKyZOKG7NgyCdqRmuCThFYfQ66BVybhj3adYIUeqgsAM4Rdn2AFL6kC
	PwSxfahcgeaqig==
X-Received: by 2002:a05:6830:82b6:b0:7e6:50c4:e954 with SMTP id
 46e09a7af769-7e70f43bc7amr4955151a34.11.1780843612831; Sun, 07 Jun 2026
 07:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJAa45g30APLE4avbWg6EfkcUATR1rDh7a2DOM6dBOYbdF-a1Q@mail.gmail.com>
 <KL1PR03MB59762013DD64C282D57FA37AFA132@KL1PR03MB5976.apcprd03.prod.outlook.com>
 <200a9854dcce8a152b75f1c4497210c146f89cbc.camel@mediatek.com>
 <KL1PR03MB597680711115B27DA7D42571FA132@KL1PR03MB5976.apcprd03.prod.outlook.com>
 <3333c9b420af0b81c0ed21b969ca6e67b9701a84.camel@mediatek.com>
 <CAJAa45h7RC7c2yeF+Z2-VHNcfLOwjM0a0kOZOfOfdMfH9GTF9A@mail.gmail.com> <d5e35fb7ea067f1e66ade131db0f64d1021499f2.camel@mediatek.com>
In-Reply-To: <d5e35fb7ea067f1e66ade131db0f64d1021499f2.camel@mediatek.com>
Reply-To: messinadm@gmail.com
From: Danny Messina <messinadm@gmail.com>
Date: Sun, 7 Jun 2026 14:46:41 +0000
X-Gm-Features: AVVi8Ce2B_LmWASoJL1AW9Bl30Kty0IYlelkGq2oudIoa6fBbAyAfQ2u0y47-OI
Message-ID: <CAJAa45j=RSvQ3fD_KnZvWEXmh1duAsrAwcU0ggsxg43keCQr8w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Fix MT7925 WMT command timeout due to
 sleep protection
To: =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, =?UTF-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>, 
	"marcel@holtmann.org" <marcel@holtmann.org>, 
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	=?UTF-8?B?UGV0ZXIgVHNhbyAo5pu554+G5b2wKQ==?= <Peter.Tsao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"

Hi Chris,

Thanks -- I retested on v7.1-rc and the WMT command timeout no longer
reproduces.

Test setup:
  - Kernel: 7.1.0-rc6 (Fedora, 7.1.0-0.rc6.260604g...fc45)
  - HW: MT7925 (RZ717), BT iface USB 0e8d:0717
  - Firmware build time: 20260414
  - BlueZ: 5.86

Previously (6.18.7) setup failed with -110 on the wmt patch download
and "Execution of wmt command timed out". On 7.1.0-rc6 none of those
appear; hci0 completes setup (AOSP v1.00, MGMT 1.23), bluetoothd runs,
and an MX Ergo S Plus paired and works as a BT HID device. mt7925e
Wi-Fi associates and scans on the same boot.

Your change resolves the timeout. Your change resolves the timeout, so
I'll withdraw my patch as superseded.

Thanks,
Danny
