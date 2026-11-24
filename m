Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795535512;
	b=RLoLiDBVq34VfghrRgQI1tURzQMOWg0Y8c2ayU8OJHhnoDBgCclOsnchlAecyCm6sClt
	 DKuN8rQsqEQUYzeOKJtaglz6A+YSXTX2pxiQycnkHdHQQewJDASctFeDNO3B632TGQKJi
	 TFCJ4IoewuvJEceY4rARceRPd8JeDel8YdhSWCvxW+4LIJzFh3oHntHPJ7jl2qaq/SG7t
	 AtSTcNtdx/rW22JcE/PMo0TMpxkjM1vwMUYmRSMhXDimvNZkQgjXY/HI47LMiBVwDhtm+
	 nVnuxxulUHqOsWI8WfKPLWdcI7rQeA4OimWvgJiRBhGD/7VSvb2UhQ746msroImLjsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cy/KtHTBG+PUZnxC+4g8mwKSUvHHz6JH3vdHAtn/qOI=;
	b=W4VjETxy/vHGD/eOQfsNvkecnSPK4aoSJ7roMwngGPvZ9wm8GYs2SRgnb+TOAtLJqrmd
	 lMQiBM51cZ5H+6T+uos0iGM/dYR90i9DUboPvGJ0bDq2qza+zhbRJnYX8oFcHu8zppFs8
	 J3xhjJjtrpG79mUQAC5cpxT75JZHmD28yy6lbaXQu3PDk6JyJFSRJsvMUxTvQG3FKMswF
	 oKHjn82/qClpdqn7JG983FQw7DqxpSoZDZftVZgGVCfjuhnAib2Vxw/dq8cYnD8urRIr6
	 nJ4uwQDj3o8RNkxwNhU/F9EWqs75NZ1iy8MUK4fTbI6Hc7zEtUVtmFMt0Qy2Kpm0rWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e88acMWQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11069606A6B7
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11069606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e88acMWQ
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67bee1f693bso3706591d50.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:51:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795535511; cv=none;
        d=google.com; s=arc-20260327;
        b=QmH4U1Gat377cMwjDnpzZDHP5dVxtjntjqeothEL/d43DRjEqb8DEC+dv++xjCoeXH
         DQJohEFYWFZLIPGcPVEVdNSwUD5jeHd2dLPOqJ4yinHpRhHpSpgg5EtpA5WxVwwLNcOz
         +CYYBgb73M59eO1+BwC54kImc83O/LUQf6OGAFjjtyCBRwogPePdAUpyhfDJZLUVXAZy
         223m79XMa9KNO5SzusmrHBFa0m5yopIMoQHHmA6zJ3VV12HhWpcZIAIx7SEKFEEqGPNu
         rU760zhWhcO6OY3Ufw1KpmoyGslN+j9UxGSKNW8XqdOdKSFaoZK+WX+7qB2gjrTMmypj
         zWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cy/KtHTBG+PUZnxC+4g8mwKSUvHHz6JH3vdHAtn/qOI=;
        fh=UA/cNErwqknDfefZj80dwpXzGaUZl6eKpR9TO5+4Joc=;
        b=KfL0fNJptqlKgVhTuskRtS4ULGLnB687FT55GXP5okRNn/QoX9h9DN69GEXoDN1LHN
         5/hXlYNo3bCgaqgaEGFSjDaS5E6ByzhiNlgoizXzFJCiXec7H/KT0+Pu7PGjUyTcYmGj
         +LePostGvTFtCXGrPhmzl3Fj5juSnxjcJOsx8OrY1BZAUoawz2aXNcIsk/Ip9a6zVPpv
         S0B6lrMGRnOMGeCDBRiMrqd3s/Tb0cQ7EAuOVC/lcSgb2Jyn4ZpBxCUI41ZcY7qhz7FQ
         E84Ajca3vW0EZCl48vPj2p/4R7tqGIyun2/ynZYEvYHRiEdrj3QooWteosVEK5Wo1pBP
         OEMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795535511; x=1796140311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cy/KtHTBG+PUZnxC+4g8mwKSUvHHz6JH3vdHAtn/qOI=;
        b=e88acMWQ0Wr8ufS6u+x5O+ZHbHZQSpqZ4qDgTvrYJLjrIq/uc915H1Zte5wg4u6EgP
         aWM89g8bjcA/K0B3smVlukmCGphtoX8MI7hRSbv9ZurU7hcziIe27zZrgHHSp1SPYotw
         erdP4c69GMlXCqeb71wWFzkKaILuLOVixAsySroqVhxoEiNqRJfoZ/b6VC0aAIiT1lCp
         sG72uBvdxBPCtuzSpY98uKepm51HnK8rhdpPB/LzsoIqbSnbyRVvYPjQKoqWNFSb9Zmx
         oHW/PVBOOQpJoDB9hMZJeafNUnF9/h9osyXZ0BEe5BGGF8LW7K299/uOpcIDIdu1XLWh
         /QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795535511; x=1796140311;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cy/KtHTBG+PUZnxC+4g8mwKSUvHHz6JH3vdHAtn/qOI=;
        b=E1gUzY+qR18BnN2a+MQXXxR79uXa4BWQh43pbLUAbBORAy1XRFwnpmtfyCtJjThWMh
         /ajuRZ1jjvfJ7AJqY/HmG8FMvJvnolO0882dKAV2B3K+xlH/PGCIMm9iaUe6cgH4OV0g
         nEH1qSdC03+Ur1cfpfv+sPv31r3IAgT3WPX++f82oIGBLRKKifJgpPMYaUSM7//Qeb25
         K9d1yVy/1iS8QbVVpQYy2fHL40wfoXACXbY6yoa1IH56p7OTq/mwdEBrJny0+DqW89Fr
         Mw2mCxb0AAI5Oc6rj0jX0TUSwH12CqJIkuYXZ4nBYRj0F6TySgXTJd0zoBXoavqkLAR0
         B56g==
X-Gm-Message-State: APuU4Z/0IAtY4o2DNSIMe/pjl0+qlepYLYJD2Tguayhq2MoMR84a4+4Z
	Go0uYNidtyCbEpJHsatbO/B7EE0ZYCL+s59qUlF1p9R9bUubupXB7HJZERU118nCytN7W8CGGgh
	2fPWQgvCf8dpanYqw/2nD6j+qJQ29iihZE/Xb
X-Gm-Gg: AZFdTZeNCy2H0+QrlIuMUVabyB9QurhVfVNwDhDUWgWGJ1Dm46zQgUDKdv6xWnnt7Hx
	3Bo1TlCtj3izgzJ/icZZRthweyiUA/E/HkONwt9e7rQjr90WbFt4yK+bf8kECw8cgFlBPSn2I6B
	gX2UbnafLv+4wN7Vlfj7LmS0BG0GTftT3o4JaufNXhJaMIvIpOa9uX+S0OTyOW2WjgxcwxulDvm
	/qDIULC2worX9bADzYlR236V8IKyaEEkLas0GjeuWf+RCzrxmrQDTSemg0+tSLb2Al3DNpAN0au
	Hyv1kNI37GQo1kocvfe+7kwz17vmrKlfrJCpCzyeHGmvR5eF6N1+lOIiuViSchRlD2oJpBG7flD
	NwizPS8Ok8w9PASP7xD7w40NURbv/+CxnP28SJAo4y1SXs5dgabqagqr3L28IzUe+v2op2YzO8p
	LnLpHQcy21Ri0Ey4k1j+FEahjeixvSGGtkK3uXfKJY4p8Tud3miYn0GsWA
X-Received: by 2002:a05:690e:479f:10b0:676:7f47:5e19 with SMTP id
 956f58d0204a3-67df4498232mr4841604d50.93.1795535511044; Tue, 24 Nov 2026
 07:51:51 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122201519.2859075-1-simon.mikuda@streamunlimited.com> <20261124115545.1890095-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261124115545.1890095-1-simon.mikuda@streamunlimited.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Nov 2026 10:51:38 -0500
X-Gm-Features: Aa3M54pZbEjP9mS713LU1Y5bBws-d2NmIavsZtN_KWcCalimXV5Bd4UBdtDqZD8
Message-ID: <CABBYNZJides4vqWtDC3fJBaN8xDZ79+hHT+X8UdtRq3uuPm4Yw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_event: Don't report a cancelled PA sync as failed
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Tue, Nov 24, 2026 at 6:55=E2=80=AFAM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> Please disregard this patch.
>
> I tested it only on a 6.18 based kernel with one controller (Synaptics).
> On bluetooth-next the patch is not right, and with other controllers it
> can misbehave, e.g. a listener may get no report of the timeout at all.
>
> Sorry for the noise.

Too late, it has already been applied. so we might need to revert it
if it doe make other controller misbehave, that said it is not common
to have controllers sending HCI_ERROR_CANCELLED_BY_HOST.

--=20
Luiz Augusto von Dentz
