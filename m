Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D01BED74
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512127; cv=none; b=sDuEIHtM8NsrNwjELDwk87Jst0bWwuFHcx0w1krOJguSohXAGtKlpCrd5VquwstKBVGOSHWSYzlY/fjaLsAZE/Ckh9Lbcu4KcZEzFHNJpR15PsKEUYV2iVxLSSYZJjn9oO2A2SwYnuYvIpoFHSGTwTUqdVp55ZLdHm0dR8cdvJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512127; c=relaxed/simple;
	bh=I/EVp4TZiR8OTln35vMm6hHoxU6T0GwrW0UNOvI5cik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i73gsnvdOTYjh7JZmOmOwasQaZyuISkuKprlJmQYhVhtfy9KixVRPJK8JJ2G52Y4JoXxodcmIoXjsnq0bXkXIcgskLuWrOQtFW3kk2aZ8ZK9EZjrhLMQ7v65SH4/sfBfaLOkS+BTqYvwdVE3NzvISTiOlOeczQwjNxEMDEryEls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EpJy6oa1; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EpJy6oa1"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-233e41de0caso3181220fac.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 14:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714512124; x=1715116924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbllIAN5xE2NiWzInq5JcWusAiQpLXP/Mpzf2+wDG9o=;
        b=EpJy6oa1sIh/R8QjKDO6oLT80FgAAetyXUr7eqUNvfS9UCEoA0rzI0ZnjhqxGjQ2v0
         5DQnxR5c0XIfFsBIB0RXxXLtiQGeLoEn1jbnaPAXsn25yt8Ry7VPEvZd7xGYETX57/qC
         PL2UtCH26zYfrqC9yU05qolNI7w0gmz6UeZ3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714512124; x=1715116924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbllIAN5xE2NiWzInq5JcWusAiQpLXP/Mpzf2+wDG9o=;
        b=BjIrEFxxLkgd3mE2u5A/QUZ5Am34jmpjbuZF22Qr+4J2OgcyGPvgqnu8w0UVZlcY7B
         xyLgV/dGHrsWbv6MrTJCSEEjNQXpHxu9lY7E1rpX4HcPUSYFa7tExW9ECn2VryyA9+0O
         44r8xH4v2KCixoHWcaOY+Xg0OqUpZ218L1Qd5RhnqSbkxJiiihBeEPFLYL8b1KiObJG1
         PrOE0KaNxECanRnhfGkJ6RTz2eV2bJ1sQXA6bbA0wKlOx+dmAIFe5SzIVR3S5VgR1z7H
         fC54xyTxMyhmuuZGTYwfeo9WfKblco/uaYtMu7d9withqHQQmU02jdumiFU7TURUR5wl
         e5hg==
X-Forwarded-Encrypted: i=1; AJvYcCVcp5HtIg2oCktxgG2RlZLZQaRLvoNi7pc2hk3VuqmYBtoVMSHo+Aflzwb5Z5CkI/KUzho/wPm6k6Zow22cMbeP3Qw+4OkE/WRg9A5YIpLc
X-Gm-Message-State: AOJu0YylZ7SZuKU6eOq3iL8As50sz0FOsEqmm1RqCi9T87Rt3s9g+p9S
	9PULejWbcMd6Up+1gS2HIPkQOWPa0b4TETNF4cPBMDMyT9GX4NO8Ml1nqJc/VSs5PafgIQIXfPU
	=
X-Google-Smtp-Source: AGHT+IHE82/sBeSekqxEcz/RUYf9Mh3vjfPZHskTFuqSA/xoj2+xzfm+wpaXGvRaai/jCA0GbcjZKA==
X-Received: by 2002:a05:6870:831e:b0:22e:b3c6:96ff with SMTP id p30-20020a056870831e00b0022eb3c696ffmr711042oae.40.1714512124249;
        Tue, 30 Apr 2024 14:22:04 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a221000b0078d671c943fsm11722993qkh.45.2024.04.30.14.22.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 14:22:03 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439b1c72676so59831cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Apr 2024 14:22:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUM8w6RL8VPS3wex8cw0PTVyMNcIEsn508PdU9y7vaJlbejDdqLg/Nf3LOm7AIbJGUW+udNpX2tkt2ofTeAffGNsLQVrxEoRZiIaPOeHiKy
X-Received: by 2002:a05:622a:44e:b0:43a:f42f:ef0d with SMTP id
 o14-20020a05622a044e00b0043af42fef0dmr20528qtx.23.1714512122930; Tue, 30 Apr
 2024 14:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430170741.15742-1-johan+linaro@kernel.org> <20240430170741.15742-4-johan+linaro@kernel.org>
In-Reply-To: <20240430170741.15742-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Apr 2024 14:21:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XAF1_faO2uRzo0Sm0VOxWmqs7YCT0Ncw=Nv1iSndhBZA@mail.gmail.com>
Message-ID: <CAD=FV=XAF1_faO2uRzo0Sm0VOxWmqs7YCT0Ncw=Nv1iSndhBZA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 30, 2024 at 10:08=E2=80=AFAM Johan Hovold <johan+linaro@kernel.=
org> wrote:
>
> The default device address apparently comes from the NVM configuration
> file and can differ quite a bit between controllers.
>
> Store the default address when parsing the configuration file and use it
> to determine whether the controller has been provisioned with an
> address.
>
> This makes sure that devices without a unique address start as
> unconfigured unless a valid address has been provided in the devicetree.
>
> Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 21 ++++++++++++---------
>  drivers/bluetooth/btqca.h |  2 ++
>  2 files changed, 14 insertions(+), 9 deletions(-)

I can confirm that my sc7180-trogdor-based devices manage to detect
the default address after this series and thus still look to the
device-tree for their address. Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

I'll continue to note that I still wish that detecting the default
address wasn't important for trogdor. I still feel that the fact that
they have a valid BT address stored in their device tree (populated by
firmware) should take precedence. ...but I won't insist.

I'm happy to let Bluetooth/Qualcomm folks decide if they like this
implementation and I don't have tons of Bluetooth context, so I'll not
add a Reviewed-by tag.

-Doug
