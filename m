Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C5E2F1FE7
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763573470; cv=none; b=ou17o5cYDtx9C0hCTa+EaACnbEunNQSC+LhVWi6EcWwpY7AUpxMFGJ5QGirsYjMwFJynyjdHvYhB5pRzwUqWQsCprrF36vgnoChV2YbItGYNXj6JhiV++rwIY0zshEcgqONMqSSW/NE9CTpp4M3iuNddDz+OlwbGvhplHoajHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763573470; c=relaxed/simple;
	bh=xDRTrNyAxxyeuaHghpbA2wfH98kVlXPgS++3kD6nJTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuFQB/BtCZzThqn3y0y8sDTRWmEryX+NHn3L7AX4DekKujVslnKVTeKxbrLMQ/STi/S2Et8L3OyS0jcTfX/siw+NXS0EYcwuf5GglK0UfFHsZBy3AAXcSxf3x/cuQyTkbkgTH1Dy9lI7fGOiOC4PKbhUA9tD9OK2Wxu8mnz0/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XNuw2tY4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNuw2tY4"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b737cd03d46so4893866b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 09:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763573460; x=1764178260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9shqnQLik0MBvQvkSLKR825xw1M6Btpip0qF9AlI/E=;
        b=XNuw2tY4UP3ztV004e5CgFRs2CNpfxGgTZZaqSVmPTjsZRybBOCgUmqSevTwzp8yUO
         GLSOo0+q685+Us7JgThSYZUHSnAKbK62OKX95fNNb5+SJ1apjUi7nrim/fAOwzFxTblZ
         snpAVGpNmIX1/+XOSKwgoA2T9oQVwH/bGaz2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763573460; x=1764178260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9shqnQLik0MBvQvkSLKR825xw1M6Btpip0qF9AlI/E=;
        b=oAGPn5uEWKFQ3v70CX+TLfyIBeZ1Y52QOKZQGMNsajbvK3QKbqCYUkf2xtqYiNaDWY
         xbfooKsnprHoCOFvE08XUZSz5IbpfvmCwAJYq47fT+XkGFesTUaFBACFnuYqriXitOPE
         KRzttP4qs5HN92OcckILIIogQz6KqGX8p8NU793j3GTJCqRipjvLEqfUw9+C8Cr+6p5d
         zOEq9X6ne8uDsHhR3x2rXPv5baeoP8QuMHhDUJcmzBFjL0wvf5o5WTke7+7sD9OAX9Ji
         tBtTHScBn/4kRXTY5nV+g4/8nGZ3fd29HUVhmvCZa7KZYm4G25AbfD536mJDzFXoCIUg
         nuKA==
X-Forwarded-Encrypted: i=1; AJvYcCVXBni+UbV32/E1xbjcncR3YJ+5honQNTuhxsiPT00+IwZJ4DS562I3D90VnSDAYzurS8GmS/VVE5a/j6kd05I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyhbpW660Nsm84XkdHJpn7bTP/ZtZpb/Lrb1yag98rx1GjWnzc
	48c/JySwbMEmUikqhoEKvBk+SoExatUv+1q9/ZU0G2Lg+PAl0pVLUdx4tfryo8Thtt6lbl1BH7K
	yB67qKd96
X-Gm-Gg: ASbGncuA2E9m7ifsCnr9dH8Lj34WtQXCIcm4dsf44FhwHrxpYvpSThOC8J9VXFnUx5T
	NP2Do50xPAghPHAa7GaGsu+1tXWQ8Oy0EftV8/hfkTAItJCyj/MorCl0UfAMZnbxkuEQHKK2u30
	BnxV9RgIMwSDG1oy/OO79m346cjpzRXZiEFOowNe0GlVR1haXNCKJdDolWA9i1I35AG9KYJfFk1
	sVPuBL7b+MRpHJwAp8KPRl2GrvkFAA4dUMXm5sEleBbK7OAIfFjw5oWfQtO2xs0epxzT89/rHR3
	IhQ4kMUB1mR3yfAoF6+QCgYh6T9tj/XBHT2mhBmmi5TDGhunsilF2uT8dUzlvIOc3ujF6i00wcV
	xUlxMGH7Gaz6/YUk32kzUvQtkXGlb9V6BvVZTevTwnteL/DAMEi6hpJY8VEU0l/QvqaaoWaQjUJ
	OxLffDDSDi5ydIPugLm/Bks8vI/O0RQ1vqVFraOb1xcdEwq2CJ0ZV4TWAldVQm4m1QkV1KPSk=
X-Google-Smtp-Source: AGHT+IFq+l4dL4pPk6Yx4XIs+G+x3EyaPHsmVBdmcju4E9AhONW0hynwXGgfFPu4xhMTYkDNniqKdw==
X-Received: by 2002:a17:906:f59d:b0:b73:8b79:a323 with SMTP id a640c23a62f3a-b738b7a0747mr1727767166b.10.1763573459684;
        Wed, 19 Nov 2025 09:30:59 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fda8da2sm1629953266b.55.2025.11.19.09.30.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 09:30:58 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47790b080e4so29215e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Nov 2025 09:30:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKqY2puhUNNGA2NQvc00dOOlpe97vR4JWuSmGF3URrYWo2LCoVri9zJHHEzCjR35ItmnIFDn9nsIqovYb2eRA=@vger.kernel.org
X-Received: by 2002:a05:600c:4694:b0:477:952d:fc11 with SMTP id
 5b1f17b1804b1-477b8a8eb4bmr414775e9.16.1763573457648; Wed, 19 Nov 2025
 09:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
In-Reply-To: <20251119085354.1.I1ae7aebc967e52c7c4be7aa65fbd81736649568a@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 19 Nov 2025 09:30:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X+mjEYu4WU-0nbHMtW-HAzm6EUeBnZj46g27O3iobKBQ@mail.gmail.com>
X-Gm-Features: AWmQ_bn88skAW9xgPWrFrlEJQJC-r-nYEqb-FQnzB2AAJsIY30EVaWKYqaJSmTs
Message-ID: <CAD=FV=X+mjEYu4WU-0nbHMtW-HAzm6EUeBnZj46g27O3iobKBQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: mediatek: Avoid btusb_mtk_claim_iso_intf()
 NULL deref
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, incogcyberpunk@proton.me, 
	johan.hedberg@gmail.com, regressions@lists.linux.dev, sean.wang@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 19, 2025 at 8:54=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> In btusb_mtk_setup(), we set `btmtk_data->isopkt_intf` to:
>   usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)
>
> That function can return NULL in some cases. Even when it returns
> NULL, though, we still go on to call btusb_mtk_claim_iso_intf().
>
> As of commit e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for
> usb_driver_claim_interface()"), calling btusb_mtk_claim_iso_intf()
> when `btmtk_data->isopkt_intf` is NULL will cause a crash because
> we'll end up passing a bad pointer to device_lock(). Prior to that
> commit we'd pass the NULL pointer directly to
> usb_driver_claim_interface() which would detect it and return an
> error, which was handled.
>
> Resolve the crash in btusb_mtk_claim_iso_intf() by adding a NULL check
> at the start of the function. This makes the code handle a NULL
> `btmtk_data->isopkt_intf` the same way it did before the problematic
> commit (just with a slight change to the error message printed).
>
> Reported-by: IncogCyberpunk <incogcyberpunk@proton.me>
> Closes: http://lore.kernel.org/r/a380d061-479e-4713-bddd-1d6571ca7e86@lee=
mhuis.info
> Fixes: e9087e828827 ("Bluetooth: btusb: mediatek: Add locks for usb_drive=
r_claim_interface()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I have no way to test this commit myself other than to compile it. It
> looks fairly straightforward, though, so I'm hopeful it will fix the
> problem.
>
>  drivers/bluetooth/btusb.c | 5 +++++
>  1 file changed, 5 insertions(+)

Ugh, the bluetooth bot properly told me that my patch doesn't apply to
bt-next. I'll send a v2 right away. Sorry for the noise.

-Doug
