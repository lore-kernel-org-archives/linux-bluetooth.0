Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA233AA1A2
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064725; cv=pass; b=ueT7UL54sGW4g0eTrhxwWH4oYlbtdbGxc5osYnTw1UnCM+m6Jh2k6Xv5qY12wb7k3dgIDshCbyWn1YRzEjbjpSc/AAJykOAXYnSRb+l9piVxLX4YqnF0ukaumut4hofT8Ii+jpWmPm183J26waABvvVKS/DZaesizHf1P2a7NX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064725; c=relaxed/simple;
	bh=EtrkWeP+OLsAymg2J5Bbk+XSAt7LFp7rtcxvbVM2r3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEmr0/ocOvYRb6s4QHTlFa5YYfnrjLJneMIUiyGY4ONcnm+l9Mjsn7j4jodpuaM4Sm1uyqJGqDcZ0qN5pDtlBltz6Bjeat0Nn0YAAVxe3cB4NxKcGMlWkHPqbDPzcJs4PnzgBbi6o2hQArNp5akA+TbZz+3fT+B2Thl3YGiaJ7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioPEAakg; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioPEAakg"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ca09f2170so11939843d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2026 06:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773064723; cv=none;
        d=google.com; s=arc-20240605;
        b=ff1m7D22p+aIyNnQi7KS/zegOc6pBHn6dw+0uqErsknqbXbXYevivTD0yb73jGmPFV
         Kd7oMxuvIFep9Ez4Im7oW+e7V1IiSaQkh9JhqpjnZRYgXVeKnYOYKAC0Zv7vdzkBI/Il
         nqevmhssrIfobRaFpDjm92qOlpJ27LpU/Gd6pvO4s/DZQ9+fRSqrX/0WHJobUT/7+IQv
         vNecuwtSznRK/QeNW7PifKruKFrrMXVgi2VKAY1u+itUNicY7BSwO0XW2C4dvyQSJw54
         xgP0tZX/xcJxiFcHckeIclzJZVVzRPEtOkX0dRxBTqmBre7SuKsYwPodPGJ0o3ZP2fI0
         SEYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+SxKbeb/GqT+xo6SfU0pHxcbpFCbWvwXyqqR/nlVG5M=;
        fh=cnCUkFdKul/8msqidMCPjntCttawucwJggxjt+YUUrk=;
        b=f3ZoNwXAP7uEsSYtnkZqcLc/KW9foSgfzNRmp302idbC44+lpDfnp5hrdX8eWbB4j0
         YIetO/NHPaRlkCWopog5G2YdCeBATp0yXB37EZfyDw8glYQVkyehEEVjQzjej6MqxrTH
         KYwhwInpN97G6GNxT05px4XZdsSxrXLJ7QKax5FUCRyLkNcMOqHWn06raFOOSzNgYLTX
         SSUCGvHCR6Am1iih+lPewxQcN2yZb8zV2MSIGSvd3uqEs1WiQVWaI8iQOFuIsCf5rEwK
         qagNZMO/hOrx99Q715FMpeoM/UDNb8XsW6OkZpO4Y9yOzt1G3YYM6H8tE4X/tur5fwMb
         vSDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773064722; x=1773669522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SxKbeb/GqT+xo6SfU0pHxcbpFCbWvwXyqqR/nlVG5M=;
        b=ioPEAakg77V+Jm4XtwNZXR1/ucIMSmFCz/Teof7tIBnvnf/G3dLEUIJNFHtEYp411I
         PxRuLjPWWHm7SqUQ6d6MTVyfHMv/jwa4gNIkBCzF4iK1Jl3C5V96TLgTW2BtucolNait
         XLyqVbb2ctvhQajz7eUtkaVpAZlXFVH96ihQUZ7vjcl2Fazz3HBel5G3wzAGLsL3ZO+l
         JIUrw7qAFO8WeK+PWLGkqcBKRZzjXrg3+K+fEkAMShi5PRBGcJJqg8GRjwec4uYiJhmz
         rfL/gGi7cbmmwi8U6IEhZtr6IpgwEIr8PLOLvzvOytPE/3X1DxPZgMO9wq2kyNvH7qcv
         JUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773064722; x=1773669522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SxKbeb/GqT+xo6SfU0pHxcbpFCbWvwXyqqR/nlVG5M=;
        b=JStht0QUQzPz/Gj2NHvatISq3qB/KUoyXEJaSjgHt1WC8kjEMtAx9NtToxGU24raeD
         5WhOWWH6yDWTee3bKYkaDQkYyjmQHTFl7XMedDZE8lOh7JzaOTDRnKchah1nGavOHmMT
         RqTi0Y8QmdrZgx06xAdF+FyPb83rWkKO1k6UFCqzLdaD2JljDerahMVfCv6aigLPxRF1
         ib60lu+/HJC2MRd9O58j3hdeMQk0jyikpFo7cub8oYFnKUC2D2n4d+TsU/ZzqekEehi7
         oc53GiY4NMk+eH1rz1NPH3K3ShxoTpC6Uhfkd5hWCZs7Ne5SipYv1liRRsf0hX9Rdygl
         rToQ==
X-Gm-Message-State: AOJu0YzB125FsM5Swbnfzoye0OEgmudh5jTZfcRuLPGD7W0vc3deVF2+
	wrO2kPZ7+SpVkFLes9ARblFrPzSQxbPS0eoHJ5Hx18qL6IiO1eexoKasU6zekd/L9joGYciP6Z2
	FD2VLi4ylVzN+UpL4ceTOLujwN5wFwZM=
X-Gm-Gg: ATEYQzxcFB+blFaj9T99kOgQWE4cm6ebfGgPIAaQ12qX1o1pHjsU0sQ8uM+1fi+9rPz
	wjyYA+Q6bLchIU5oTY5c763WUxhfvXJyzsmlaQJ0/euvj6x11mVRgeuP75ntme4vVMg0DQWCPpA
	wR52l5YJ8s2eeNBPTTcpF8ET3xbzQ8QLV96hFjBqKkT3pOGfQ4GeP4jvIoJaxTW8NZ657JV62Lh
	iDMk7proYQQ3Tun5/gBy7pYK20SNQe+3QkLPj61o/a3CbinSpQuaNmwK0StDg7GNFerTlyOQ/WR
	sDmj2ESZjv/yb2J8R5hVscHVJzZerEgme0FSiskkm+Dk7f33RLj6o+huljCuFskVq/H+jw==
X-Received: by 2002:a05:690e:b88:b0:64d:29a4:c933 with SMTP id
 956f58d0204a3-64d29a4cc49mr4329083d50.56.1773064722539; Mon, 09 Mar 2026
 06:58:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308124745.19248-1-martinbts@gmx.net> <20260308124745.19248-2-martinbts@gmx.net>
In-Reply-To: <20260308124745.19248-2-martinbts@gmx.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 9 Mar 2026 09:58:31 -0400
X-Gm-Features: AaiRm53EC71XXZTfStBKdjuLiYsiuIQAcmIpAkqfrPZ5j4tUBNvM8W10RkCO-_w
Message-ID: <CABBYNZKbyTFDyogUi_5UGTKgR0syOgPCqgokMJa04vS4G-uUWA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/6] shared/gatt: make secondary discovery optional
To: Martin BTS <martinbts@gmx.net>
Cc: linux-bluetooth@vger.kernel.org, hadess@hadess.net, vi@endrift.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Sun, Mar 8, 2026 at 8:48=E2=80=AFAM Martin BTS <martinbts@gmx.net> wrote=
:
>
> BREAKING CHANGE!
>
> * Remove gatt_client_init from bt_gatt_client_new. Consumers must now
>   call gatt_client_init themselves!
> * Remove mtu paramter from bt_gatt_client_new

Why?

> * Rename gatt_client_init to bt_gatt_client_init and make it public
> * Introduce a new bt_gatt_client field "skip_secondary", default false
> * Introduce public skip_secondary setter
> * If true, skip_secondary makes discover_primary_cb goto done
>   (instead of discoverying secondary services)

Overengineer, this could probably be handled gracefully internally.
Maybe have a short timeout, e.g. 2 seconds, and if the device doesn't
respond, continue as if it was ignored or something like that.

> ---
>  src/shared/gatt-client.c | 22 ++++++++++++++--------
>  src/shared/gatt-client.h |  4 +++-
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
> index df1541b88..7896ed329 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -93,6 +93,7 @@ struct bt_gatt_client {
>         struct queue *notify_chrcs;
>         int next_reg_id;
>         unsigned int disc_id, nfy_id, nfy_mult_id, ind_id;
> +       bool skip_secondary;
>
>         /*
>          * Handles of the GATT Service and the Service Changed characteri=
stic
> @@ -1344,7 +1345,7 @@ secondary:
>          * functionality of a device and is referenced from at least one
>          * primary service on the device.
>          */
> -       if (queue_isempty(op->pending_svcs))
> +       if (queue_isempty(op->pending_svcs) || client->skip_secondary)
>                 goto done;
>
>         /* Discover secondary services */
> @@ -2106,7 +2107,7 @@ done:
>         notify_client_ready(client, success, att_ecode);
>  }
>
> -static bool gatt_client_init(struct bt_gatt_client *client, uint16_t mtu=
)
> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu)
>  {
>         struct discovery_op *op;
>
> @@ -2549,7 +2550,6 @@ fail:
>
>  struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
>                                                         struct bt_att *at=
t,
> -                                                       uint16_t mtu,
>                                                         uint8_t features)
>  {
>         struct bt_gatt_client *client;
> @@ -2561,11 +2561,6 @@ struct bt_gatt_client *bt_gatt_client_new(struct g=
att_db *db,
>         if (!client)
>                 return NULL;
>
> -       if (!gatt_client_init(client, mtu)) {
> -               bt_gatt_client_free(client);
> -               return NULL;
> -       }
> -
>         return bt_gatt_client_ref(client);
>  }
>
> @@ -2592,6 +2587,17 @@ struct bt_gatt_client *bt_gatt_client_clone(struct=
 bt_gatt_client *client)
>         return bt_gatt_client_ref(clone);
>  }
>
> +bool bt_gatt_client_set_skip_secondary(struct bt_gatt_client *client,
> +                                                               bool skip=
)
> +{
> +       if (!client)
> +               return false;
> +
> +       client->skip_secondary =3D skip;
> +
> +       return true;
> +}
> +
>  struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)
>  {
>         if (!client)
> diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
> index 63cf99500..e510ad455 100644
> --- a/src/shared/gatt-client.h
> +++ b/src/shared/gatt-client.h
> @@ -18,9 +18,11 @@ struct bt_gatt_client;
>
>  struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
>                                                         struct bt_att *at=
t,
> -                                                       uint16_t mtu,
>                                                         uint8_t features)=
;
>  struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *clien=
t);
> +bool bt_gatt_client_init(struct bt_gatt_client *client, uint16_t mtu);
> +bool bt_gatt_client_set_skip_secondary(struct bt_gatt_client *client,
> +                                                               bool skip=
);
>
>  struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client)=
;
>  void bt_gatt_client_unref(struct bt_gatt_client *client);
> --
> 2.47.3
>


--=20
Luiz Augusto von Dentz
