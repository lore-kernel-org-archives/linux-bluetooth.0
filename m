Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77924377563
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510075; cv=pass; b=bDl3xc10/sp6LIgVRE6xmGlewV0XOmKVqGayKnwHpU5AMIOxtWTw5lXJoh621S34R0Mv5EaKcEEM2T3eyVAXzEaNpX5bXorMZWL53rKAkUdu26vEAtsvO6WgJ/C/0n/ApDrl1xBowPWdgNiyk7/scbDdK6GfT6OfvKLGDZdtPU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510075; c=relaxed/simple;
	bh=vD7AonEnJis4H4yYmplk1jKeBBiHyHkWqatkz2fEvwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuGRjQDOhx84avVVjcAiqTn2A9BAPOXdfvenrlX8fDARrvJ+vBy3dRA41v7TtTN/Yan7ToPkly9bJxyKH2reLgTaIeIPfvmEt/Gp/gRSEm0r/fPqFc4q7+nl497aeUOkm9UB0u9OCC0Rv5EHJgV7FkOskM/b98ZieOe6UiCa1Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5acmmuw; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5acmmuw"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7bd8c55c885so42990517b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778510071; cv=none;
        d=google.com; s=arc-20240605;
        b=M2x1lfdQQ8l4nYagBsxFYw3ZnkXCED7yr1BoiGA5nN1fBCsi6QzZhuWjLrSQP8zxL0
         bX1pwGs1RSh3P0Pf9GDOvl9ew/L5ERVpX1juu6sjxXLXgOVsKbreLvpuzlLU9hAxxvcf
         ww62jGBkTXIoMSkarAfIxyd7fFaz3twBhLXlzKsW+X8pu1/Mbyr91Y3trA7HhZxMN+R5
         lrhL6Eux/2xha/yLxr9JylqWFsq91T1PgSb5QPWWULYAVdKZkbIcUagRBmLlc2RVb2Iq
         HJN4bBKrj1pa08/6tWixY8Vxdq1vEvPSPDWhS61wg3qAYh5Nq7AwAp8CjfGphIV8IUmE
         BqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        fh=tlqWOVrmFmv9KXUqVEC/0xz/WZIxP5EozTranj+cRW0=;
        b=IxKMY4YOiHsSMC80O9DTFI8SJHvD1ODsWeczyYjJrUrzs81IH2J1EYOJNZJD0FoUBp
         gekUTR+fYbVwMktK4AX5VPYfce6jrHmIWDoQBA4FFRrCN41lgKTjXGxSWAHjJQZKbblW
         /t86jlC9EkcenIODGsnEHTwlGOF0U6vRD100Rch3xWMJgPFJmLyXB30zhKOhZtAWVeMz
         7WAdIf6W4ijP28jN1tBlW6mXg2e/o87OIei8l6HVSHL9kIdK/z4vrm+yJyivEQCACWvQ
         GlheSPSazSTOeDdqYycBtyhN5V0rMPw2oH4JCmMCAHeptXbkG8mkchX5AgfaF6vVeI/K
         ETIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778510071; x=1779114871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        b=Q5acmmuw9wc8edoPdpXTRIwB3HzpMyeIudW0Ur6smFGRtCXex9lcXNCJEHQ9eBisC2
         OJJsjyxxJeZZLTIHkqIubFD4yul2mCa/jdspskTZwxE3mNC8jZF55CIljIjFjw+66PPX
         ufBLOrpjF2XrNpVGeRVJbp0B4y77uheUB5MKkxLRKdocVLcNMtXXLaygFrzdEM1fetxo
         MJlfxKGffvb52b+X4RGpE8lthQex+Ey0+MEkXvCYQ+jbh0iZd/LB2qZJeggAjsnxPfVe
         0ebDK35wE6quPfMgapxEILmsQTJC90ebkQoQTC/7wq8aY2dccrymOJXQe9egPFlTuuZv
         hUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778510071; x=1779114871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+v2ay7d5zaezO4LQdeMSaE6xJKDm17at2Vx/sGq20mw=;
        b=psyqG9D6HSN7gIUgBd0cpc/sdQoWbY6uWjhBkBQYUCMkfw5Ib1LXBOkG0IV+iKacXZ
         42Q/6fVL5VXSchJkf58n5j/twbsfFRNB/aEjTk0v3nu145+XNcYwPGl8W5TT1eQZBUfn
         3s+1vP7rvOM66GYXMKn9OkH9FDsoIDTfU87b7rgztiI6fEs/XrCW7A7tUEpXCbRuy8M4
         VtGKxnBQ/yQJfh/v9g7oB2T1aHKerlicAE+JXruvaz25zKr8uATP6pJSrgJsxR8ZwZ4p
         0Och0cY0O4Z7KbEnA2h/54g7QVXs0qq+Gk8wdN7tH6MSrm3XZMdEdKCl1SH6Pmd7qAZP
         N4vw==
X-Forwarded-Encrypted: i=1; AFNElJ/hWu+PLpWRaNNHuQDhBWCZfdc07uOG63kot1so3Iuw2qePdbttXa9vmvNSOhMrklvLYzEO9F5ooQ2wjixRFbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd74S/srqf8cMidqd0o+WItuZB7+96pUbGbNwhhqwgtFo2cAiM
	U8LPtT3Y1ADaMmGnYzXvr31MfcrJBmytoQKe5jQvnIYWpDu74k54tEMrvW4YPvKs77GGgYK7cZ+
	R9EFrmMNa9Xz2XaYlkg3IJRFfknrg+/zuZUQhL+QbLQ==
X-Gm-Gg: Acq92OERzDqWGy3O5xPFcKKb+RU+EWevVK1Mc4DoagPcFic4dAr3GojfCwIypkoVOvi
	WPLn6Hi8JiOJDDwf88bZQ7pKBqvzojOsIOrKY3OoVyVquUORzjxtXCZLi+RulEAXSbejeSwdH4f
	AiUbQkbPytAGejN+WSowGSznfehZYx0O9nKXcz0f99ZPGRK6Lop7kMxgW8MZAuy8kwGvV1Q06Fe
	4Ii02CoaiG4AyqI0MPuZPCQSquytIQByTIZf3pkmFK337cLJW8njMIXbPfmE3hA5XEuZ0Bp4NKd
	57iS0oz4jG+AR9C70TY=
X-Received: by 2002:a05:690c:dd3:b0:7ba:d5fb:b543 with SMTP id
 00721157ae682-7bdf5dcc7b4mr242694677b3.13.1778510070862; Mon, 11 May 2026
 07:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776429984.git.u.kleine-koenig@baylibre.com> <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <c830049dcfcd99f005e2ff6742aace9341c61f13.1776429984.git.u.kleine-koenig@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 16:33:52 +0200
X-Gm-Features: AVHnY4Lsmc0xOoSZAdNPsitAF34xmre0WH2Fz_Ejkt7Ep8UMQ1cwv9JaIHq62oo
Message-ID: <CAPDyKFo6nvBCnOHXUSvedaT3Rnob+oF=nZoRoic_EkgFBTxzwg@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] sdio: Add syntactic sugar to store a pointer in sdio_driver_id
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Ulf Hansson <ulfh@kernel.org>, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, linux-mmc@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	linux-mediatek@lists.infradead.org, Ping-Ke Shih <pkshih@realtek.com>, 
	linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Brian Norris <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Apr 2026 at 15:11, Uwe Kleine-K=C3=B6nig (The Capable Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> On all current Linux architectures sizeof(long) =3D=3D sizeof(void *) and
> this is used a lot through the kernel. For example it enables the usual
> practice to store pointers in sdio_driver_id's .driver_data member.
>
> This works fine, but involves casting and thus isn't type-safe.
> Additionally with the CHERI architecture extension there are machines
> with sizeof(void *) > sizeof(long) for with the traditional approach of
> storing a pointer in .driver_data doesn't work.
>
> By replacing the plain unsigned long .driver_data by an anonymous union,
> most of the casting can be dropped and it yields a working solution for
> CHERI.
>
> All users of struct sdio_driver_id are initialized in a way that is
> compatible with the new definition, so no adaptions are needed there.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Feel free to take this via whatever tree makes best sense!

Kind regards
Uffe

> ---
>  include/linux/mod_devicetable.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_deviceta=
ble.h
> index 5b1725fe9707..0eb5d196f5b5 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -414,7 +414,10 @@ struct sdio_device_id {
>         __u8    class;                  /* Standard interface or SDIO_ANY=
_ID */
>         __u16   vendor;                 /* Vendor or SDIO_ANY_ID */
>         __u16   device;                 /* Device ID or SDIO_ANY_ID */
> -       kernel_ulong_t driver_data;     /* Data private to the driver */
> +       union {                         /* Data private to the driver */
> +               kernel_ulong_t driver_data;
> +               const void *driver_data_ptr;
> +       };
>  };
>
>  /* SSB core, see drivers/ssb/ */
> --
> 2.47.3
>
