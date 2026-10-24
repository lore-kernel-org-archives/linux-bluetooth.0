Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792817983;
	b=LHMQFunpUiz6QWp2BcyWvnRBKptsgQ5QTqt6amYTpzu4rMRRxF36B1WO1iTWt44eu6qO
	 vNCQRFqSbvTT9uAXUIMyEoZsxKfhJDC+acfr0RAi1u98i0jjOaFhsf+N4IE5qXk0y+jc9
	 XkmDR1y+nmdepUgoiOH/KNte328d2+GH/uP4Wy7x6mjNV1EqcESaXm/yEPfBlpuGCCvlj
	 qxZEs7eaSwaC7+oTdCD/kIINcEYQVQFFqIScxVvnf+n8ZbpmJ7GKBpnZXLwCpD+U81gDK
	 E3ZjkBgtkMFoKiylLvdwP3f2qs7tYC4SpGMOj2FaHHXoAVQYtZtOnbnnQCF/zq6IIeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792817983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=jaYtm2rVJHVAvdyzEZ8O2BUdp5q7d+QjfEIHkyFL7l8=;
	b=kjjt0fdW8YJTjGPsm4nyCV3TNd3/8bX74RuR7HBmg4X5NlTMUwrV0/+P5RfdEouVq1Kj
	 6jxJwzuIGrqbuzg550tcZXl623d2E75geF6u8IVYIkkDZZS4Q1gaN9wdqAXtZq1LV0BX1
	 iO2YYEDz0JRJcPW6PRsSgtLXvvPMVc9zakMGgBGowr0kmd33hPINRby44gqAJO2RIWV46
	 H5kC1myCmGXrmJXFImMmI1hdl6ZDP7fp+3qsVhJXWKIHAWRZw1JDkoiEX9B3CwzarTiHl
	 /gq5MYZQd4/yHW1WVt3NRqOA3il6HCfUHevXMdLVlioMqgZofwW8GTGF6bqD2iHjhfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJWaMzta;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4299E606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Oct 2026 04:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4299E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJWaMzta
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b52ba422cso1079466d6.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 21:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792817982; x=1793422782; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jaYtm2rVJHVAvdyzEZ8O2BUdp5q7d+QjfEIHkyFL7l8=;
        b=CJWaMztaW7GwKlsr38SqqQvWg0zRjY+cvuDX2trPL7tYkWlAlTA31cYtc4WY62/lA+
         BQBYK5orGhg/O3cBlvHu7xw2WM9TxorW+/UdFdzbsdS2312VWhCr76BPnf2vRvUWVkw1
         aVcuZVRxsYAy1X++czEFgXWXgkaldYZYuJlKbHg2WlHuiJrVyu071L1PIvmKetbdWATM
         VAFbeC3yk9IXlXhmEPNeg7Fg0ABkmopqxGAcRllAgYeX8jk/pDd8VNf90+mFhJj6S4lO
         lv4r7tj11NWsyRIhDBux2xPc5BwDoiP+5bP3+qr2o2C+Wp2UCSHK65aMOnkMuQD1ls7T
         8uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792817982; x=1793422782;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jaYtm2rVJHVAvdyzEZ8O2BUdp5q7d+QjfEIHkyFL7l8=;
        b=AED3YmniExtNS5XHyUD3MOk9PHStCYqsJdhqpSAA+Zxy2pT20avghg1gFsG1rqBsNH
         2O3BlLP51OUy3JRceUHqfAa1FsBDUj23efzrhTn85dIpSOL7hqG+z8R5lcvv5myLsG00
         urcUkpNhJCs1QXRGte0DkchqNyJhXHtiLjnSGnb/qt3/erHEqIGslX9mAHnpSZQP3z63
         0b/+8CMGgnBsepZclq7MjxJPBUyyvvMv+mYV224FMlVzznw2Bm3pMlslfi7SFl4V3ah3
         utxC32FPrQmQ24kpTBfdIzlS9xdErwGgeYUA4FiliMiCI3Kz4RqnN0TSQyoysmsI8OGK
         N1TQ==
X-Gm-Message-State: AFq9FYIyyU/VBp0NZbomLijVDHWWZuXW710xuRFrJzgmwjNoJPA0JN6y
	tdkf/JKHJQDM5OfGqnVzoJlnYiU1xjrTomfG1LMJFKJmkuTkF1KevfLVRCApvA==
X-Gm-Gg: AYBFou0w1lAAYtxiUGNj6+CTcDKkRhPxJuw9UiA0b1JlYzNmTEPO+SK1097L09R2AA2
	AstmlCFddJF72xWi226cdDBG/pCT6f1x+z9nkDMOmYZTDTKiMV2gcWisTnhS6VJcw8d9iV/J5Gm
	wQyiTuzbGWahTpQFzvf1S7yKRyRS/FvfW2Ky8C7621OQCsN0Q0zXwoCG6NfZJbXxA59jSC7ViYn
	HSzIq2ctGQdKt1nyiN99hK8e67hKBjbn6EDVANhYElVeDw1JJrCWNay8GmsMVzsuXxterjgRfh+
	3O1z1gUZ6ToHa+npbXtuJ2t/ikXzF/kEf/YmwF+5J1pFqbPRbrxsBbCaHXGRiC5PscpnDVVFXC3
	UEQ2tpDoTblRGTI84p11u2XSQ5G4FCdjDG30RBel/YqMZbtoc0UmJhTZ4vFOkyBlI7h6oRgRzIR
	v+a596w6/cNJA9+Xw2tudwDq004tt2CPja2fdifnJj02hiKOI5VV2E3qFk7RRey/ut5aXE7MMSU
	awqy1Oi5dMtxBNMz2/ByRZzafkp82vYcdKruriA/raKiwSfvJMJyrbM2FQYxvAgFw==
X-Received: by 2002:a05:620a:1a05:b0:93f:654e:ddb9 with SMTP id af79cd13be357-940ef8c8221mr135636285a.33.1792817982222;
        Fri, 23 Oct 2026 21:59:42 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.223.244])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a771c9sm93240285a.34.2026.10.23.21.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 21:59:41 -0700 (PDT)
Message-ID: <6adc3b3d.77bb26fa.2b4190.cc80@mx.google.com>
Date: Fri, 23 Oct 2026 21:59:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0050558208357519318=="
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
To: linux-bluetooth@vger.kernel.org, enghitalo@gmail.com
Subject: RE: Test links completing after their connection was aborted
In-Reply-To: <20261008215756.2710812-2-enghitalo@gmail.com>
References: <20261008215756.2710812-2-enghitalo@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0050558208357519318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Test links completing after their connection was aborted
   Pull Request: https://github.com/bluez/bluez/pull/2639
   Created:      2026-10-09 01:29:31+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0050558208357519318==--
