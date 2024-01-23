Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390B5F561
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706018017; cv=none; b=BvODRfOov+GMlS2qwa8OGJy/aCRtCn7l/aK/uUJryYQVlo6q6b0kPuHMwi+NUydN4yQk+xWxA1zIuWgtUldDKojrhI+if/7jxVYrszYxm14Ckupgh2zuVX3qEAyf7aQTjR/1vFoJuHofEZMv577ml/cifWdPAJacqTFmylyCmyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706018017; c=relaxed/simple;
	bh=aEeWi8BIcABDRn5+RPeIHlSJpZvsFVCRWX+DTengVLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEt+KADFTjPugMu1pyWqV/m2ZkxlGI1LNyVoZzLJAJPl3A5+w2SFW4Slzm4wyHfEsurO7l2RgbHd88Ufn4HrsectpENn5XsHrNmwLiJWYZ3P7Jaon9lteIBwfHOWxky0JwIe0G+11O6g61I1O9XfZfz7A7+iXUN9kpbjYBahNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dpz6Y/ue; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dpz6Y/ue"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf1586ddb0so5346411fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 05:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706018013; x=1706622813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmh+Z2SCU4n2zBpPjfbO0aqjzjwZ1RkD9ug+VJh+cBM=;
        b=Dpz6Y/uecSLs6bEsBFDc4azFlg42FRiALP8arlp3da/teTnksEVMRL6Vrz9CBbqwG5
         kXAaA/WSZevBNe4w1FxQAenLzZBLNueasiF1CP94F1RufHOLUs/tz6aczs5nhnqfEMCO
         EnJ+NxuEXpqIT1wn9GfSYoSWb3NOP9jxYe32ezFobfR42SSApvkH0S9Unz7Ed1LjDjyk
         7JWpullpKrRFwHa0lmS+r19cnDDLtR5qb/ZJH3qyVpKTsGehSsNterMXIhXXSnTHwaKF
         mDluFnB1TunSfqIanQ47joQw7DAtSW5KRkFjZekiX+GZTxoVt23y+hq6GGNdmxjJwbiJ
         Z9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706018013; x=1706622813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmh+Z2SCU4n2zBpPjfbO0aqjzjwZ1RkD9ug+VJh+cBM=;
        b=N9RsSqBIwISeRPU5EHxKMOjT94gSKi+nhYLwU8VoAbFs4B4zDCchehDYTudGTBNvZn
         qePc2W/X4aetl5SJhuQFCKOCe/bYIMAmaVRIw9SdUZXcl/27YTzeNpRsCgagrh7Un4bD
         4TG80D87Zg40wRA+7fzTw+6WXenXv7XWVijcJvYdLhN/mR0tTKW1aR8mmi/eJZsYhkRg
         VKVSAl5NuUmUh6v0+MuhVd0I06HDXdMDluFjNSt0ajXVWv0XF06lDB1Dl/Mih/VKmqjI
         KpQzbvNH37CqNC+S7nxUcPe8lNLUVbMymIZeGr1unIdp+icSkM73etsY2+dOuZL2a40m
         fdMg==
X-Gm-Message-State: AOJu0Ywx14N26wDvTk/GV9vYeLygxgicH4gkJygOjnDMIZ7S1lB2gZjl
	gkwRVzhjgDLGq+tBA8a1GPlkGrVNJ2ftBJHUz1AqfX1/jjSAk1cXtNXlC3slQYgZgw+mwGkiDpI
	daB1pNRMYtrd0DOR9XtJYyQ5qYRvEwHwI
X-Google-Smtp-Source: AGHT+IEB3v9P7yARY1eM+gA1BT8QxVqPpcibF8uBbB5ftkalSKHA2Bk5SXKumsVbE2XxJvfqFKnMh4MapMCFvUXXZZs=
X-Received: by 2002:a2e:80c2:0:b0:2cc:a72c:9d with SMTP id r2-20020a2e80c2000000b002cca72c009dmr2322378ljg.37.1706018013232;
 Tue, 23 Jan 2024 05:53:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123121519.523735-1-frederic.danis@collabora.com> <20240123121519.523735-2-frederic.danis@collabora.com>
In-Reply-To: <20240123121519.523735-2-frederic.danis@collabora.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 23 Jan 2024 08:53:19 -0500
Message-ID: <CABBYNZKMry5Vh5Xu5t7ykoWOo8zjqjVfS+zfYk1fxDomHRpDQg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] device: Update local and remote CSRK on
 management event
To: =?UTF-8?B?RnLDqWTDqXJpYyBEYW5pcw==?= <frederic.danis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On Tue, Jan 23, 2024 at 7:15=E2=80=AFAM Fr=C3=A9d=C3=A9ric Danis
<frederic.danis@collabora.com> wrote:
>
> The local and remote CSRK keys are only loaded from storage during start.
>
> Those keys should be updated on MGMT_EV_NEW_CSRK event to be able to
> perform signed write for GAP/SEC/CSIGN/BV-02-C.
> ---
>  src/adapter.c |  2 ++
>  src/device.c  | 16 ++++++++++++++++
>  src/device.h  |  2 ++
>  3 files changed, 20 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 022390f0d..fb71ef83e 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -8882,6 +8882,8 @@ static void new_csrk_callback(uint16_t index, uint1=
6_t length,
>                 return;
>         }
>
> +       device_set_csrk(device, key->val, key->type & 0x01);
> +
>         if (!ev->store_hint)
>                 return;
>
> diff --git a/src/device.c b/src/device.c
> index 17bcfbc49..34f64ca5b 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1955,6 +1955,22 @@ bool btd_device_get_ltk(struct btd_device *device,=
 uint8_t key[16],
>         return true;
>  }
>
> +void device_set_csrk(struct btd_device *device, const uint8_t val[16],
> +                               bool remote)
> +{
> +       if (remote) {
> +               g_free(device->remote_csrk);
> +               device->remote_csrk =3D g_new0(struct csrk_info, 1);
> +               memcpy(device->remote_csrk->key, val,
> +                      sizeof(device->remote_csrk->key));
> +       } else {
> +               g_free(device->local_csrk);
> +               device->local_csrk =3D g_new0(struct csrk_info, 1);
> +               memcpy(device->local_csrk->key, val,
> +                      sizeof(device->local_csrk->key));
> +       }
> +}
> +
>  static bool match_sirk(const void *data, const void *match_data)
>  {
>         const struct sirk_info *sirk =3D data;
> diff --git a/src/device.h b/src/device.h
> index 8bb38669d..d00c002c3 100644
> --- a/src/device.h
> +++ b/src/device.h
> @@ -134,6 +134,8 @@ void device_set_ltk(struct btd_device *device, const =
uint8_t val[16],
>                                 bool central, uint8_t enc_size);
>  bool btd_device_get_ltk(struct btd_device *device, uint8_t val[16],
>                                 bool *central, uint8_t *enc_size);
> +void device_set_csrk(struct btd_device *device, const uint8_t val[16],
> +                               bool remote);

Looks like there is only one use of this function and it is always set
for the remote, actually the fact that this is on the device object
already means it is for the remote so I wonder if we really need to
store the local as well?

>  bool btd_device_add_set(struct btd_device *device, bool encrypted,
>                                 uint8_t sirk[16], uint8_t size, uint8_t r=
ank);
>  void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr=
_type,
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
