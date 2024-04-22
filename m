Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE6153BF2
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808256; cv=none; b=C6D7JBjx55hVNdsNKXodgzfO2Q4VA2jqaMfRWkiCGMTNh5dRjGLX0RSMevjjD88aaCgB65ekAUqPiI43gRigFEWIGiJyr5v9kT+WtVxcQorv82F8/bjQsFoj8/qSLRLGXEu0c65W+YjrHaDIwIDnXFv+mDukO12xIemFYkHlMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808256; c=relaxed/simple;
	bh=PedKjQ4IchNk0puiU4eLptdz+f6auezzylZJfV3vp0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d88rJ63zgBCYjvKTELmqSv5IlPBOrqZ6+qWYL6WRDTALujtsPmTMJ3XV0P34YytuOGf0dow3CXjBbeGltWrY10Q2D6XhO4P5BvMkBycPS3kr0BL2PX0A/MJCTg956QIrH76BJ37yWaD1ustoZnB9NTChvO7F03EDuxLdsz31tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=To7dC6M/; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="To7dC6M/"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so4314170276.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 10:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713808252; x=1714413052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IPoRNKoBlgwzxEWzxuaC/lQKyisFmyEGkELxXi0f2xY=;
        b=To7dC6M/PmdEevzayY5EkU9GpBjHKe8PW4TALzgY1zmNd89YbjoWzBzVhC+6xt8W5b
         d/C/UOS98N5eqLGk/0ui4dVS11rkxB+ZvJXi1aGj5fc2BeSkBaUC2yCYxlMTTL/zneCX
         0tcecKOXd1keoqHi7NHn8Frkm41nw7meIe6yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713808252; x=1714413052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPoRNKoBlgwzxEWzxuaC/lQKyisFmyEGkELxXi0f2xY=;
        b=orF/LDpkiMF8pfHEMzAlEW6jbmZNrQTobnVOqnUQrKQGSgIff1RJExsKMSEogruN0V
         BBz3jVAgG6axbK9c5slztivX72ziCSAwdnF/7Rk9CsWfkp5sRGV15DFLw1giUy7zyEMo
         irYOnCg4vUSD38JGuEwDsLOQKgQmG8jb6pwC/Wkgi1Enr9KFo4YYblLuTOI9mTGCkPuX
         pl6xkd0fG0kt3bbff1XnQOrcA0NVMHEAtQXtRwltkNRah+I87HcvsRReks60Pxw3gb99
         5e5IAYYeds/5+Ls87l9gSaZ0CwGTJtvGE14cXtgKIgRoMqhcU/wM1x1urE5CcGHto/X4
         Izcw==
X-Forwarded-Encrypted: i=1; AJvYcCUN+LUAOFsBHf211HyNl/L1y/pDhgf0eGnHp8w0r54FZhbj4BCiUAYB0g/LJBhZkbKhiueMdSKdM18J4f+21YEsW7sl29gcGTRn9KTMUh/d
X-Gm-Message-State: AOJu0YyC8L6tb4tac24K+XqRlHZaF4Jx392LwpVah8bmGzQkpEIJKwl2
	p+RYP8ECzEdch6+ntNYLl0eVankWjohqySAsb6O6b0lYyAY9CUQQXHEBvjdkEY7w+1gkE4DA0m8
	=
X-Google-Smtp-Source: AGHT+IFK3MDi3D5qDfca5Grt1nL9++H3ONKFif3bO1cr7tLGM7VfQ7rGl0DkaCk43yKFtibkEGIp7Q==
X-Received: by 2002:a25:ae4b:0:b0:de4:738b:c2e4 with SMTP id g11-20020a25ae4b000000b00de4738bc2e4mr10930442ybe.28.1713808252126;
        Mon, 22 Apr 2024 10:50:52 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id a7-20020a0cca87000000b0069b82585f7bsm4389253qvk.21.2024.04.22.10.50.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:50:51 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-439b1c72676so43121cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 10:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWyAT7YW3pFBXjn6e1/11FeW/7dScVvrq0paPtCqEqh2sIsuQ6Cy8jxWxr/Q/RKFuVPmzQH3JSTYtzG5uvlqGyzF1cD/XGPaLHWHFDT9dIZ
X-Received: by 2002:a05:622a:a097:b0:437:75be:9111 with SMTP id
 jv23-20020a05622aa09700b0043775be9111mr9752qtb.1.1713808250395; Mon, 22 Apr
 2024 10:50:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
In-Reply-To: <20240416091509.19995-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 10:50:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
Message-ID: <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 16, 2024 at 2:17=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Qualcomm Bluetooth controllers may not have been provisioned with a
> valid device address and instead end up using the default address
> 00:00:00:00:5a:ad.
>
> This was previously believed to be due to lack of persistent storage for
> the address but it may also be due to integrators opting to not use the
> on-chip OTP memory and instead store the address elsewhere (e.g. in
> storage managed by secure world firmware).
>
> According to Qualcomm, at least WCN6750, WCN6855 and WCN7850 have
> on-chip OTP storage for the address.
>
> As the device type alone cannot be used to determine when the address is
> valid, instead read back the address during setup() and only set the
> HCI_QUIRK_USE_BDADDR_PROPERTY flag when needed.
>
> This specifically makes sure that controllers that have been provisioned
> with an address do not start as unconfigured.
>
> Reported-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Link: https://lore.kernel.org/r/124a7d54-5a18-4be7-9a76-a12017f6cce5@quic=
inc.com/
> Fixes: 5971752de44c ("Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPER=
TY for wcn3990")
> Fixes: e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD addres=
s missing in dts")
> Fixes: 6945795bc81a ("Bluetooth: fix use-bdaddr-property quirk")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c   | 38 +++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/hci_qca.c |  2 --
>  2 files changed, 38 insertions(+), 2 deletions(-)
>
>
> Matthias and Doug,
>
> As Chromium is the only known user of the 'local-bd-address' property,
> could you please confirm that your controllers use the 00:00:00:00:5a:ad
> address by default so that the quirk continues to be set as intended?

I was at EOSS last week so didn't get a chance to test this, but I
just tested it now and I can confirm that it breaks trogdor. It
appears that trogdor devices seem to have a variant of your "default"
address. Instead of:

00:00:00:00:5a:ad

We seem to have a default of this:

39:98:00:00:5a:ad

...so almost the same, but not enough the same to make it work with
your code. I checked 3 different trogdor boards and they were all the
same, though I can't 100% commit to saying that every trogdor device
out there has that same default address...

Given that this breaks devices and also that it's already landed and
tagged for stable, what's the plan here? Do we revert? Do we add the
second address in and hope that there aren't trogdor devices out in
the wild that somehow have a different default?


-Doug
