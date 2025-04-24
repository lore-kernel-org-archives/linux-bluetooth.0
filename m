Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0227456
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506670; cv=none; b=tLKuyCX6FYdcfA3I2Gv1eR4QWgix9brOtZbMxK5d5qaSlnnDSAQQBqSqHfOeyMsN1q0eD5L/8Wn4rkGajeL/uE9EC2FhL3s3ox9AUwtmWqMwXXIMu+8kYQ0q3tH17h94nhnnwRFcnFCcGohyzB+iriMPM8zOCEyQe97kgDfsa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506670; c=relaxed/simple;
	bh=wpuPeSF/+YzBIR9Ua8B7L62adsfNiEp6tlfeb0vGGik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fu5r8UNXXowjRHJCmA2v66zuUalKUOkAVhY4XDPBBx2DtKr6mNE0AKAr6ACQlfhwOzNspFB/9a7e8KkSZ9a/GcBWmUjlZNI5Qdae1aCPnokM2rJ4n15jNnFhWwU+YtmTkV3M/I+EgbjJCegNx8GBPYY0YCtxFvfBE4iDpYd79rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBXXt1sb; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBXXt1sb"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30db2c2c609so14836441fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745506667; x=1746111467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyE0Ed7WyAl/gYNQc6mNm69apIZW/8shPqN/X7/6+GI=;
        b=NBXXt1sbDu/mDWTiNu0zOgAwD99Nwxga+x0wM0xhOWeunPveWjT8Hmk6p4knxVp0FL
         WpG26OoAgV9pnlGwjO/lwNqBItsidalaVqEk51JvfLYrs7M5ayUS4MaMsCUGDbzsIh2m
         upAgGoNzCdf5jMSNQbjJ1giWw/V2aDo3QjKiE3/5pn86VxHHDuWyOj1lj6zcz86lbUfk
         KtfWIHr95ELHS2tTl61PvmsNMQ9RJbBARwp13GhHBF7YlSAVNS11vlQ9cIb/Yh79MjXg
         38qRf0CXvokgmCqKYuu/tNfzYk1FwLb7rvu0DTIRQGBoq+zU+ohCsqxv9HFnk7ppKPWG
         q+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745506667; x=1746111467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyE0Ed7WyAl/gYNQc6mNm69apIZW/8shPqN/X7/6+GI=;
        b=bhaYj9u3HQBtQhQRYtk06fY5TYFrpdtVV2WD3EAyC7MNw4l5XSDRc3k/7/YRhyWIfv
         gJKMLMefn0XebcqIu2unBcWgTcZqQQ08pFBWsZoL1OmivbXZzr9wwxBDx5rev5ldgE08
         BbTbKo+D9ODQR3TVsFaydcBzbCZxYDOrIc2s/lbRY+JVnbKlyrTKMw0kq1X+HdRzHuPz
         RFFJE3QWPIP1gsLfZ200CvPFTpNgNL8DU6EzDJbeytmOF2GbIILEeWYRlqr3fYsMCaAg
         tNlsgP6bh5CmftmXjGsidK1eIls0tEOIC70RzQspq/JYCriCY4I29AxVnxzsbq4ewluw
         ZsLw==
X-Gm-Message-State: AOJu0YwEaDkrSp70jow2yzM7JrjNW36RyCIAxJpSKh/wwyCSFPN9zPy6
	jeYx5i6jtxVMCHcgPnD+fR6T1UugHUo/otW3SeYJ+660EV9yj9voq/rJxR1U/vkl5MM+XA6Y6B2
	/iU009DeAltY6ui2wYMrgAQDufSxlyw==
X-Gm-Gg: ASbGncv3qhfi3OWZDunptWBxHu7EezQA0AxQsbtUJZs7ihzNMWRtg/AcRYTu9/xRpwp
	iCdZiypokBuiojSPvWqeaz22m9P+1ZILOuXK00QT2MA2i8gznJKhynFHRqkKyPT6pJZXht+9lWe
	7wy21CR3pjjpSnxy5aqXO3
X-Google-Smtp-Source: AGHT+IGCNkI5I7RMuuKgK8/2wMCsprrWbXLysK9Ks8DqRmswjf+GUkcErsTwqHiq6VOBJEZTQ2DgwYKxLwmPZNYHyG0=
X-Received: by 2002:a2e:a10d:0:b0:30b:d156:9e7e with SMTP id
 38308e7fff4ca-3179e0f994bmr12843711fa.2.1745506666976; Thu, 24 Apr 2025
 07:57:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424144831.95766-1-ludovico.denittis@collabora.com> <20250424144831.95766-7-ludovico.denittis@collabora.com>
In-Reply-To: <20250424144831.95766-7-ludovico.denittis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 24 Apr 2025 10:57:34 -0400
X-Gm-Features: ATxdqUHTWMDwxcJzSH5E2_aU5EpBQCdJprVnpddbC5HWyUKSlRYpeoQWpba8ySU
Message-ID: <CABBYNZKZoBaw_MzRqmR3CUv+=rw_U=Uo25engjsFG=9u-jU8XQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 6/7] adapter: Set server security level in load_devices()
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ludovico,

On Thu, Apr 24, 2025 at 10:50=E2=80=AFAM Ludovico de Nittis
<ludovico.denittis@collabora.com> wrote:
>
> After loading known devices from storage, change the security level if
> we have a device with `CablePairing`.
> This will allow it to successfully establish a connection.
> ---
>  src/adapter.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index fd425e6d2..8d875013c 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -68,6 +68,7 @@
>  #include "adv_monitor.h"
>  #include "eir.h"
>  #include "battery.h"
> +#include "profiles/input/server.h"
>
>  #define MODE_OFF               0x00
>  #define MODE_CONNECTABLE       0x01
> @@ -5090,6 +5091,12 @@ free:
>                 g_key_file_free(key_file);
>         }
>
> +       if (btd_adapter_has_cable_pairing_devices(adapter)) {
> +               DBG("There is at least one known cable paired device, set=
ting the "
> +                       "listening input server security level accordingl=
y");
> +               server_set_cable_pairing(&adapter->bdaddr, true);
> +       }

This creates a dependency on the input which is a plugin that can be
excluded/not loaded at runtime, so we can't really do this at daemon
core.

>         closedir(dir);
>
>         load_link_keys(adapter, keys, btd_opts.debug_keys);
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
