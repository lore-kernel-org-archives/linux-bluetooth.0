Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3623C1970
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031159; cv=pass; b=Jvb1enaNFOpKSwMsjUzEuqhx80pzm8ACrlj+kDviklBcOenjDgrzarb6prFH+2lvobWN3VeaPGP0BQ19IqQzQnBMhR5f9d+IwTbinv1U7w7/tVY90nfUJRx+0shX3/nuhxXLfRohQs6NdpVWifhdg1nDhFReDOov75bWbUVA1Ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031159; c=relaxed/simple;
	bh=l0WEVJOAAz2+/S9Vh7cOFAE9h17yqh5sJj/ydlnXqSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFXTaHAYtM9Qb53Op0vU2BFffypfqvcSLXkb20rwVMCoXDITCvB/znWU8JTBtWzTD3/HDcvIB4wsac8oO/emHzHu9VTovaQSvDWvQoZMeS/CBnxerplAcECkul3owPz3KuTsfcmQWlAVmlEUvgnEnRyFqnEr2QCv+emblri8ln0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMADW2mE; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMADW2mE"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad9fabd08so6409845d50.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 06:52:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772031157; cv=none;
        d=google.com; s=arc-20240605;
        b=RaxPgoPfIuDO+L+jFEnFglaNlnEuZcgnxRepY5RkxVeJmmfJHaihHDpqJn52+GUiNK
         xIlt+aSujoA9c2+9dLEH+3+gWgS2Y0a0voNDWgvv8I9VZmd/oUaN0/ZHoEMq0GtOLVZb
         W2RVaHbLuQvPHc3lFyasL/zmxd+U8moA43tswmEDX13g5Suge9V1AVz4wNYcA7qek9dS
         Qpy5zYGs+WwQCwBJuoiO289jfdyb+4sb8oyHdiEECEEZh/lGlj79iiiRBvM5t6ZF3zHA
         dVYRpg++cC4NxV3BpjYvinZvHTWfYILj+mipiTKq4Ls9Eu1yfylJ9+5mg7a4NVHCxfcK
         MoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H370T692C8J4mC9fihv3LA5xcC8pzSMj5VapjTHH14g=;
        fh=3vCSbKDpVSeNBgeQYcQRRdY50507ZYFO5BE2JEAefWw=;
        b=CKvFdGLyrXsOlMF0MgM1EwlNtZW2ffMJr3K0lbWJr8GCFl0inVN0X4j31eez0OTSxC
         I1A6HmgVD6AT65KE4lk7uJB+h8qigqlcGgyxVPMfxYW4gJG86gjNF8VUeghjPaUfA4b4
         FHDe2oLrC88FCBFZswjy/qbbjniEsKVzhrS41A8ikw/KN7gLsc5vBHCsHpQgcH2XxauJ
         LS6je1JkHk6lCVi7WLVfpPIfZw9h2H7e4h5RZSroQd4gURM3gQ76EuK5MjwlQm6YEljK
         nLRw8c2Sil7VBjMM/O7ZeQsLQl+jSdGDcVCyq+kZCnuZAX4cyYnQB+tK+23Ug5N2m/a9
         bOAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772031157; x=1772635957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H370T692C8J4mC9fihv3LA5xcC8pzSMj5VapjTHH14g=;
        b=nMADW2mEQ5CuwoOgr8rrWmsoGBCZhq/ZThK0/Cywt1l9xYyve+08MpRDIVLThwztE3
         f6Kj1u/ik/NYEy+rmeO4jRhxFQr7BWZ7zzKkV6X+aA3oSPwZk6S4KZ+/AzHaj7tchQwD
         byjZCICz0BrscGbc5enL/b16yU+2I+AZnaOFwQhf8EnO357EAFHnc8g9pQQnlEos8UTy
         SpcwKFjy3/D1nh4eNhuGyPPMwBnKzDskV3kou+9/ng0MJmWo6WhDw7VyK+cr8fOf4UIo
         R6z3YdPOGKbywkmrqKS2VfWdPGoW/xnrdhrP73e3jGQmz3bwbtJGUi0fqhasejAQzo6P
         dQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772031157; x=1772635957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H370T692C8J4mC9fihv3LA5xcC8pzSMj5VapjTHH14g=;
        b=s9nOyoOPjjhJ7R2dpBofoZ9iURu7gax7chGi5ODTnvxT1InfYh76FkyfjQjUSaksPo
         v8XkXJ7QeDJZabdeDrY6shLPAoutRrlj7D1ygd2pDccbFjRpKqOL0C7DZrW+r1YDtHwF
         0q8d3uNnxWxJJXT8DCl5iqF4EJkWfvDC1McG9FmZEJuJ7GbQPKVzrV8TjMKZnNh9X82x
         B1sAM+udAHQ4/k09mBDU+C/mnLGeNwy/sDvix7RierqENg8boWGvzjWot/J2tAvbtg8y
         kMNAYBaMIFyPHQh+dJGmmQR6xqOhPY9yHGh+EQILX16zn48Pp2gGkz7U3RS7yJcG2+LT
         Fa6w==
X-Gm-Message-State: AOJu0YwIDWCQKtl3hf5Uz+NM/3yqCXeyS4w68Zt6XTVIRtmrD1eOFJt9
	eZovS151xER4K+rZevyuminN0BQM3GQphm47C57vtOfMtj/hL+Mr6NJRb+Bmu6/OTN5iSmD+z11
	zbGRUFmgEYJU2y9XzycOMv/1HkA2IEp4=
X-Gm-Gg: ATEYQzx5K7sfGkXr/uwflkhPb5yXBbU4hkSHzHxG2HnMe8ZMew4wxS54IqtvYxDKz6Y
	B17wk4HDM9M3eZp96Blz8ciWyGXUoAPhC9AEfDRTFUl9fwthYzB1qzNelsqVovhRXRPs1AYxA9k
	kSYObjbh9XT2Vz8J9OtpurjgH+wMZlobDI2ZHLAL1vWN7y6UQBEhJlXBp6HkJ1Wv9Y8TmgozqNO
	nlKpXXArjedDwCDPxVuNV7QT95n/gnyBp0Z1BRWQmhGxaIipDH37IPHHGOndphH+VOXT+1F49Hb
	U8v6evprjW1rmp/waqxVcClp91a6OGWw/cRK8NOSaHRrclzN9BxfbUNjJV1dx41vQpenHQ==
X-Received: by 2002:a05:690e:e87:b0:649:b9f4:c536 with SMTP id
 956f58d0204a3-64c7906aedemr12734802d50.73.1772031156989; Wed, 25 Feb 2026
 06:52:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122063640.310090-1-jinwang.li@oss.qualcomm.com>
In-Reply-To: <20260122063640.310090-1-jinwang.li@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 25 Feb 2026 09:52:26 -0500
X-Gm-Features: AaiRm52uzq68vKhOiMtq89dOSDVSlU0GCTCwJQo8k6ismoMlmnuK4biI3IS8Y78
Message-ID: <CABBYNZKuA3pK4rrsN0UxuyqR=Xc+ELBHz4fZpX7ckpDAS5qYTA@mail.gmail.com>
Subject: Re: [PATCH v1] device: Initialize device volume with a valid value
To: Jinwang Li <jinwang.li@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, cheng.jiang@oss.qualcomm.com, 
	quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com, 
	shuai.zhang@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jinwang,

On Thu, Jan 22, 2026 at 1:44=E2=80=AFAM Jinwang Li <jinwang.li@oss.qualcomm=
.com> wrote:
>
> When AVRCP is connected earlier than AVDTP, this invalid device volume
> causes the A2DP sink to reject the peer's registration for the
> EVENT_VOLUME_CHANGED notification. As a result, subsequent attempts to
> set the volume fail.
>
> Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume =
properly")
> Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
> ---
>  src/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/device.c b/src/device.c
> index af8df5f29..cd0b8802e 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -4948,7 +4948,7 @@ static struct btd_device *device_new(struct btd_ada=
pter *adapter,
>                 return NULL;
>
>         device->tx_power =3D 127;
> -       device->volume =3D -1;
> +       device->volume =3D 127;

This represents the volume of the remote end. Why would we initialize
with max volume if we don't know its volume? I guess this depends on
the role though since transport_a2dp_src_init and
transport_a2dp_snk_init do initialize the volume with -1 and 127
respectively, so as a sink perhaps it would be correct to initialize
with max volume so we may need to replicate the same behavior.

>         device->wake_id =3D -1U;
>
>         device->db =3D gatt_db_new();
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
