Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11814B086
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061131; cv=none; b=hcJs5d40+LeySo1M/aioXItvFWXEz8H0aPdKqRTTcxyclgXiAFvJ4ogWamStR0hRYB8wPDDlfoblbEXsSW94J0Futml3GxoFkr7XQk9NJmw1xZN5H7NRfpiol+fSOm+BQ12PXU18NMIh4QnpHm4prBgNdWoocr2qjOj07ILLbx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061131; c=relaxed/simple;
	bh=ma3KkjWX6NDzygZRbgCm5HEg8q6NeJy/w77N/3RnFoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8QHD+M8HhHVW3cmRhjd9G09i4lTKa+cISxhMiYcD5ITYN3iC/eh4SCr+7tmFbjUiPHGeS0Ot/bz+x6ANkgIfZvD1f6AVqXUwUJV6V609KpCz0EvbyiGWjSYZnogiNHtpC3fKCoXrNr6zPTy4Kw+Mv3F5oTfrk3/bZ+UcEsw1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fppv0WKq; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fppv0WKq"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78ef9ce897bso73867985a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714061127; x=1714665927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqoFEBYGvr1CzCDNq2rYrl60Aa+Kl8xqNL1Vi3kFg0Y=;
        b=fppv0WKqRMT3rC6oLcseokexpckGNZWLv1SSxX5VDihTxnmgBQbpLlrG5EtPGhT70t
         6AuuyyzhNax1mV0CNpCMtDGhbXr0z39nJ3tVTfglYCeIttRTHN7zN87Buz90apf+ojf+
         23ufGtgs/XqNRhrn8UGjC3TbCXpJxxK9oIQFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061127; x=1714665927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqoFEBYGvr1CzCDNq2rYrl60Aa+Kl8xqNL1Vi3kFg0Y=;
        b=k9nlnx0abs6pm/PrQ3sm5It5p7c115eJMRav8ZhM0BvPeRpog9ubv/HPftgPC3J3BK
         ss7bw3lCSyJQL44+6MX1g06V8v3IBv10lNs0P0nDv2KCGC/TKLxG7Nx+6jUqNXlSEFu7
         7ZpLX7cI+G36TM/kX9D3b1EJp4s5/lfZLBLra0hsGGGs1jZjIXuiCwxfr8Y344QQIMut
         O674E7QCgwYqsddurIONH/P50/C6bicN3T5cAgF9guWvjgs8Xos35N221A64YZUWmRT4
         bFsneZ5K/nEczAZljgU4e/6H0CdYd70yU5D006ftZYocgSOsWMNYo4s2I3vaa9ywjOAG
         8Q+g==
X-Forwarded-Encrypted: i=1; AJvYcCVdi7zTxAO2+IyvcOY7qsZItl7tQTgtfxxotm8Sx5FNTU2KGmEaFWMo/4O2fSjPiN/zvaI8OauvxxsS2uJmHd46JF23DuUAtomru/D2CXTW
X-Gm-Message-State: AOJu0YwpRGQgdheLtTQy7wpC0umWD+QChuIlQhOMo1mnpuH5sp8lYmsG
	7lQz4b7u2ZmD0cupvGMuRSiiVJRokD+FnjMJxfbEDGX1rcWYWb2+1d26xmWt4OHeV6pO0uL52gw
	=
X-Google-Smtp-Source: AGHT+IGV8d5mdix+6S6evws5Va8276Jz+DnD6Yfc+BZM3d4z8n979Xl61gGh2nuB5bCqehlp+LT6pQ==
X-Received: by 2002:a05:6214:258a:b0:6a0:7e54:8e5 with SMTP id fq10-20020a056214258a00b006a07e5408e5mr188350qvb.6.1714061127522;
        Thu, 25 Apr 2024 09:05:27 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id e15-20020a0cf34f000000b0069b5ea45d94sm7092723qvm.18.2024.04.25.09.05.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:05:27 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-439b1c72676so472061cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Apr 2024 09:05:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJI+EfnMoOv2kglqk4E0NdFG7ZR9q65ehpkDgv/2Te3UPPO/yF5z61z59aioPOzKmIfXSwhZleCqculaeeZTdV0ph7r668uuErF7t6ltoF
X-Received: by 2002:ac8:6782:0:b0:439:7526:1d80 with SMTP id
 b2-20020ac86782000000b0043975261d80mr330416qtp.22.1714061126221; Thu, 25 Apr
 2024 09:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425075503.24357-1-johan+linaro@kernel.org>
In-Reply-To: <20240425075503.24357-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 09:05:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xztc8iYawafEUHOJ3e9=TrqJ4dgCfw8hC92xL2Dow4vQ@mail.gmail.com>
Message-ID: <CAD=FV=Xztc8iYawafEUHOJ3e9=TrqJ4dgCfw8hC92xL2Dow4vQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix wcn3991 device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 12:56=E2=80=AFAM Johan Hovold <johan+linaro@kernel.=
org> wrote:
>
> Qualcomm Bluetooth controllers may not have been provisioned with a
> valid device address and instead end up using the default address
> 00:00:00:00:5a:ad.
>
> This address is now used to determine if a controller has a valid
> address or if one needs to be provided through devicetree or by user
> space before the controller can be used.
>
> It turns out that the WCN3991 controllers used in Chromium Trogdor
> machines use a different default address, 39:98:00:00:5a:ad, which also
> needs to be marked as invalid so that the correct address is fetched
> from the devicetree.
>
> Qualcomm has unfortunately not yet provided any answers as to whether
> the 39:98 encodes a hardware id and if there are other variants of the
> default address that needs to be handled by the driver.
>
> For now, add the Trogdor WCN3991 default address to the device address
> check to avoid having these controllers start with the default address
> instead of their assigned addresses.
>
> Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
>
> Luiz and Doug,
>
> As the offending commit is now on its way into 6.9, let's just add the
> default address that the Trogdor machines uses to the address check.
>
> We can always amend this when/if Qualcomm provides some more details,
> or, in the worst case, when users report that they need to re-pair their
> Bluetooth gadgets if there are further variations of the default
> address.

I can confirm that this at least gets my boards using their proper BT
address. While I still wonder if this is the best strategy to go with,
I can agree that this is an expedient fix to land it and works:

Tested-by: Douglas Anderson <dianders@chromium.org>

We can continue discussion in response to your original patch [1] to
figure out if this is going to be our long term strategy or not.

[1] https://lore.kernel.org/r/20240416091509.19995-1-johan+linaro@kernel.or=
g
