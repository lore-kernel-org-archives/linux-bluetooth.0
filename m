Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793176005;
	b=BQ1I1j1Hsqxf/amArQZlIKv2Nf9rCU9/AJCNcQEBPs4aoVTIF26pZ8SwkJlRfHbxgTkl
	 3g0fQ1ogk229c7cIMchYzfedeX70kOCP0GOxLWQpygGPaJCAds31hp0i20U1EZ1ToUJR4
	 F9c5S6Is0V53mjIdDwEfDz/+iwOhUbFBMBBLD7QqQpmWByzFY5cnVtAg1Oq+AJYGfZj4m
	 HpzClrfi7HAk2rF0VeQkXfMA7ZCdGnLLzlnYLWhedCNMdUAwgoMPmDTJ+NhzLXmKS4lxW
	 Av4mhHDKmVT+sFDOXOnt8CWHHi1jPZ4HNTlQZYdjcYKU2n7HU/usq237nKpFF3fAQNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=ZEOIxuoJbBrTydV28loSykp/E/MCfsxI/z6e8M56Nz8=;
	b=QadDs8r2DiLIckLrJeneaQhaUbbkhueuILagoLCYP1gZUeUWAOhSaFSXcCAUlZ+h2NhN
	 EFusYYehq5d3jhmCwqZI94cdn0+HnFTk6P9SdOmyzB/3mAKrJW0Sqtmew8oAdiVwWKLBK
	 iGm4WTJXmzcOCR7HhyC+1E49PkS+WBzkso62ffuGI7ATmYjXPZxqmB76doGNwi6E/m31C
	 BVWEIPZC2GD3Xvm/QEcKd2PK75BrOg6nOVbGHNiPeomAknEz04CdI5/b+2l8u36sPI0QO
	 kRyBZ98+9b4GPqeSVbq6oB0YQNPZs8/18OqnGliWnrr196PzvcB42qfA37R3SwmmZgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DZH7dDDr;
	arc=none smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C5606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 08:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 658C5606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DZH7dDDr
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-486f013db83so258669fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793176004; x=1793780804; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZEOIxuoJbBrTydV28loSykp/E/MCfsxI/z6e8M56Nz8=;
        b=DZH7dDDriMhXAXjtyV8L6otYS9qt0MSQweUnpTP07rw0Zp9Xes/qdKLtKWio7efdcz
         e+hmPXk3AU8npIvR5ACKHF5t9nwQduizLjAGiIH97bH5ashgZuPLjnKnW0Bp0fZQK6NK
         /auM9W6qmMWyMbTLEJTqVR9HHeiNn2tbvpnxFA7bPM74NVG/PL6Co99JyS/CFhRzYAIh
         bc9vAHeRfZni1WC43anWCPfZZROh7BxL/FP1sVq2T0l3gadxfVy7BL+DY1v7GE/DDipV
         3d3tGRzbktVqN+xLVdbG7G1uniL4sZyeszvWpWiMaAdVSTk6BbNtTR/LmGA9F8UT8wLL
         WRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793176004; x=1793780804;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZEOIxuoJbBrTydV28loSykp/E/MCfsxI/z6e8M56Nz8=;
        b=o2Tio7mAOOLbQVgLGyfDsF8wF/eDfaSA+nzEWidCY1RSif2T2p6ooQBNH12CUrO3gZ
         o6VWGHQ6rYo8o4eMO+hO6vFgw8Yi/ES0lN/i8FRbqWt45yogObFpOMKclO2P/CRQAHDU
         PHOrQ4xnBWtgnOOm1oC3HZW+HEzyKs20MV4Bzfu5P6+7hQvx/OGxhAJd+wrkX3ZtD0d+
         U27izRuQ7p96j56889TfFHUF9tcjkFZCvS4qI9ukLLVBFHgTgQTW6/mT8iQFDnfrQWTp
         SfNo1URRiU9lWGHoqiDXW4IdE9h846zR9OtbE1yNc9wB2HsG5GSnkRBDakoabk/I3+HI
         NftQ==
X-Gm-Message-State: AFq9FYI7uoYdxWZQXssglGbmbFXzsoC8phUYiGef4F5VpW/dei1SIzTW
	9HAeJY8f9SMkc1q9UKKNrI7Vj/de9FtNdBJduj3Vink55gNVoYFanOv+dypsxw==
X-Gm-Gg: AYBFou3FXpuNm9ULv30zElrAYrallYAqCpuOoJexL205kCYXlwHW3ncwYAtiPVUkj//
	0bFnJoFgmjUWm5eTLNSqFK4ejy1S/Wng4YEDRY8fNuWsRYUGttBPqodfMruk/TUo4QPJ0OVGNIm
	nJv5KY7fJ1i/TTj7yMYwKNfV8oTCf15LBsv23+3Sc2hAD92UUqwZZoGZJLietugkWF7QCxxyZb4
	MWz4Tj1YkDt1uKURT3yxHX4d8Ww64OL28L8NkGgU9I2WM7DwktPEhRDlpOY/Ah7WymbmVWyZLZ1
	WGJ7mV/UAReUaGm7ghkoDaNPtNgXdSAUH3m25MpBlq5DkwK7PzU6nJTTzBZrv89Y/z+G2U0o2/k
	1f/h1IFEpWgRVOIgc6pUdHnxRZtkH4gjMNOkavDQR4eQudFHQ8+x66rA+n6gXxddeo4n0LKuXol
	L8zK5p8y3uTF5KuXGmy7HKWLIQBJ4O/khAypi97WXipSY0sl/x022mMIu8tnVTUCoczy9uUxK0H
	dNbjEJuYyRzSUYwX3aWFTb6pi78U04eTr2/SYG0J4lOKUy4eFmHYgvcC/Iv5LhzSA==
X-Received: by 2002:a05:6870:e99f:b0:448:908d:27e0 with SMTP id 586e51a60fabf-4a8bb3621bdmr1331586fac.4.1793176004215;
        Wed, 28 Oct 2026 01:26:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.136.241])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b7830e0csm2057741fac.8.2026.10.28.01.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 01:26:43 -0700 (PDT)
Message-ID: <6ae1b1c3.2f5f2073.31b2eb.1edd@mx.google.com>
Date: Wed, 28 Oct 2026 01:26:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7051620494933323952=="
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
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] asha: Defer BR/EDR inquiry while streaming
In-Reply-To: <20261013035348.525335-1-cochcoder@proton.me>
References: <20261013035348.525335-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7051620494933323952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC] asha: Defer BR/EDR inquiry while streaming
   Pull Request: https://github.com/bluez/bluez/pull/2668
   Created:      2026-10-13 04:00:29+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============7051620494933323952==--
