Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592E41C0DDB
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727071; cv=none; b=pz974yaL/zE9XUmAJpKQJy+8BIAuXVQq43Jmr1NPrZPB8y5lyjEkj+hf2wHiAcKT8lX+VLxsbnXaIRQLZ7OmK4//6JEefV+xIYj2KuOu22StySeWXBvVFGUdFuP+o1JI0/VCv6KtxexfmXb7dWFXklAA7W45nTTW9cCbHom3Bbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727071; c=relaxed/simple;
	bh=IBYhV4l89Es5djyN+XThe3Uvf6afR54Ux18SoNi+FoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwNCw2qptFq//N6UnC7JoypGvJj2Goexcu4Kx98FACydL2BxNIXBMSz7NO0QFa4uizRdqh/qqGH2UDiCY9LJH9SC5YbmgbL3Hnxg6OA5Q8jcBeQflfMLmK1g8DMWyMkKtHAAnhtzgb9+5gfcIM+NRHhanxmUKRdF3AVaTolVOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cvcy3AJY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cvcy3AJY"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so17017381fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 08:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711727067; x=1712331867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCHnDUMCi9/YCWLxMeyotVlV2Miie9qEAy8Yhd8AU64=;
        b=Cvcy3AJYkESpRtDHvKASgFcqQSD7zBgRiCKOYM3UCpHATok0G/6pzgr/61aXSBQpIK
         WsXHcH+eqpUGzO8qAA0J3NH24pDB/E0mcFV2vWcV5ktTxB+WUlM7bYOUGY+xU3D7tEJx
         sBxsW447y+oVqM2j2waAOQIXWBokFXU4rSR6QHJea1RfRA5kC6+VcR3F7Wth59KQzePh
         oRZjdR3dMXiNpQNt+IpLc5AST3XvKbs+j1ZCH7zDeFoSZ3LN1yEltUdz2UUqShm/w5FO
         H9jTEKjv1AxHu2Dk0Z2IjTkW7ggsBzuwmrCBCxrNQZNpU+Jv5UXrYvioaaVDwc832cZG
         oMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711727067; x=1712331867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCHnDUMCi9/YCWLxMeyotVlV2Miie9qEAy8Yhd8AU64=;
        b=ExRe55pvIPVUP2R5ZoTdislEe4r0fF52t4fQHAmFZhoe4ZZKA+JRFkKeKUHkcaq8mU
         af97nnOhpUbr2dGdebH4laNYolNIxg/PAKJNPRQwC6YcI1A4NAXCrICkXEs+G1VVfNur
         BBVzUjA2njQi+kaso7ApSaWjZH0V4lacSwlO3RAEFbhIySExH4Pb5LfDZl+c6oOEMS/G
         xAUIALM+kZ51MwgBfJNpYHwiKsBSAK5np+e8XuTx/xGPt3Gy+1uVTe+jo2EAHBg5tPcj
         7baf7j4NaNtcniG4xxmLbTDHN689cpCDZn7RzJQhKKqr2e4Pzz+/hadvFpQikgV06Azp
         10zg==
X-Gm-Message-State: AOJu0Yx5nh5xi23F9wEMv4Y8QfiIWyeY7CoHOauuYrvmEyBjf9OS2Q1C
	LwdKTo0QvPlVfxou9K0NrqQhLIhuEj3ni/MDmiyccKnqC91k22xTzBhyuX4xC7OK+47mq7bwCv+
	7t+d3El1Rq18Bl6YtFEAleoXfzUI=
X-Google-Smtp-Source: AGHT+IGlhCzFrxO8cIlICV7o9cftWfJxa5hX79xGRrOd9D4ikH1broMOMp+i6au2zIDGYV9/lgLqdVfrck4rYJXjKvg=
X-Received: by 2002:a2e:aa98:0:b0:2d6:cd05:1895 with SMTP id
 bj24-20020a2eaa98000000b002d6cd051895mr1510205ljb.29.1711727067255; Fri, 29
 Mar 2024 08:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329154000.6056-1-vlad.pruteanu@nxp.com> <20240329154000.6056-2-vlad.pruteanu@nxp.com>
In-Reply-To: <20240329154000.6056-2-vlad.pruteanu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 29 Mar 2024 11:44:14 -0400
Message-ID: <CABBYNZLrtrU25pKg4yqZPdSkmQGSwYFWptc1+VQRZs-_aD_Z=g@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] bap: Remove entry of deleted device from
 bcast_pa_requests queue
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vlad,

On Fri, Mar 29, 2024 at 11:40=E2=80=AFAM Vlad Pruteanu <vlad.pruteanu@nxp.c=
om> wrote:
>
> Currently if Broadcast Source device is removed it's entry in
> bcast_pa_requests remains active. Thus, if the removal is done before
> short_lived_pa_sync is called, crashes such as the one listed below
> can occur. This patch fixes this by removing the deleted devices
> from the queue mentioned above.

Actually we need to redesign these, the list should be per adapter,
not global as it is currently and we probably should stop doing the
enumeration if the user stop scanning.

> =3D=3D105052=3D=3DERROR: AddressSanitizer: heap-use-after-free on address
> 0x60400001c418 at pc 0x55775caf1846 bp 0x7ffc83d9fb90 sp 0x7ffc83d9fb80
> READ of size 8 at 0x60400001c418 thread T0
> 0 0x55775caf1845 in btd_service_get_device src/service.c:325
> 1 0x55775ca03da2 in short_lived_pa_sync profiles/audio/bap.c:2693
> 2 0x55775ca03da2 in pa_idle_timer profiles/audio/bap.c:1996
> ---
>  profiles/audio/bap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 52a9f5e00..8953e9a57 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -2907,12 +2907,23 @@ static int bap_bcast_probe(struct btd_service *se=
rvice)
>         return 0;
>  }
>
> +static bool remove_service(const void *data, const void *match_data)
> +{
> +       struct bap_bcast_pa_req *pa_req =3D (struct bap_bcast_pa_req *)da=
ta;
> +
> +       if (pa_req->type =3D=3D BAP_PA_SHORT_REQ &&
> +               pa_req->data.service =3D=3D match_data)
> +               return true;
> +       return false;
> +}
> +
>  static void bap_bcast_remove(struct btd_service *service)
>  {
>         struct btd_device *device =3D btd_service_get_device(service);
>         struct bap_data *data;
>         char addr[18];
>
> +       queue_remove_if(bcast_pa_requests, remove_service, service);
>         ba2str(device_get_address(device), addr);
>         DBG("%s", addr);
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
