Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE333217
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919704; cv=none; b=sN5c5y3HFIvffX8/wVmGJUWNL0QrYWTKEwopld0A4MK9e2Q7SHYGb/a93O6rvBqtrHcUJdoXz/8p0IDhA44kCICtqOqPMB0a5DZ6L9rK33eC+zCofLhD51JUpEg/0mC+BKHm82i21z+TNC7B+h4B81pC8vD4ogxJdsv3Y6Nv//c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919704; c=relaxed/simple;
	bh=MK7YnTrZXkumRnwgauyhkvgXciBsr1N5FG2keIjnIgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKsmkIEOVoPevh2N2o1Bb9Cf+BhxrmgmSHI5efciLW3/TicbOFzMAVq+MPCG/dBRwzStYsgdnF+h88xMydLoDO7u954WDiv2epKs6KaXdT66unTLlWmKl4a33IslF5Aw1G6yyyNpuTjN//16JkuN5Xd2EdHGWKTZkrqp/hw+yyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7n13BH8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7n13BH8"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5101cd91017so3790675e87.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 09:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709919701; x=1710524501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4YNYsr9gWnS3mFq/zvwGqqZs4nvxmI8GdnUy92/mBk=;
        b=P7n13BH8mUs9oqY36DHgDy7hlQoaq/NE7fZwEUSGOUN/dUH0Me2erO07bCBiWe2+BO
         Vmz79JH5AmH8ixk4mTSxnwXqQw1g9y1QuyqRy4i6u9CNiedSJg/CNBkf18w6f6l5wrtI
         VwrIt4aVP6LNUo114UgotQOJCHJFLNymJxTD4B+7ibwJv3xGa/9teId35Zsp+Qz2823K
         soJoKIxCzkFfNf/UCijxqgiRTtnSQgOHIwyquUT6/5CrRO3aviV74bG0Us7dtfbQdYMo
         LnJLfngOg4M0tGDWoFvNSJZk9quTOgJf/re1xRLpFZ2rbRuNmtmQHV5cQzI3gF8bb91n
         J3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709919701; x=1710524501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P4YNYsr9gWnS3mFq/zvwGqqZs4nvxmI8GdnUy92/mBk=;
        b=lBYDg7BiG36UX6rkEL8Q0yi0hxY3oC2XXufHH2gl51OjXgH+RIDGMh/z5FUIbMBrQR
         Y9jru0NAKhoivvvKQqqyJ4nO9XQJy5g4/DADMuFn3nqXHVC6Kel4kbE8BrLhm16o9nLi
         vpmowYHkveaZSLY1I4kKkBUIY7WRoeBTB0g9zqJKm7E3p3PQOsdlGQmFUqPwm4ciWEp3
         +RCgtxW+DoHr1b9P4l7ueuIVTOniL1kR6UZY+Vrgwo+7/VEL65n2cFy02PgDjmz9LfxF
         ZRb/dYbm38WXY2QyZ79u8UOiockHO3Tnc/NJ1EKkEy2trfysBCFr81z1/gial8Gy2CRn
         bH+A==
X-Gm-Message-State: AOJu0YzdZv3M+IP8hAT+zt7fBDOdLJBGOsgIFt9Z+WF5+XZxqOd6Xs19
	oFne4bL+IVwDbiDkhILPyCF8Tpcr0O+K5kHzXT+72rhcFIrirZUMtvC/sdb/jlJNutEBbqvf1AA
	xU4cfUh9utaIJQIlipURKNe+4J+lhDEKm
X-Google-Smtp-Source: AGHT+IHm6/4/ANEsHCST/9XOr/pWKobUKIl/3EVToVm/vGG2CV3coqLbnpsEtMYSedUmap0wxjMZ2fmmcygmH+QIbxk=
X-Received: by 2002:a2e:9c05:0:b0:2d2:4783:872a with SMTP id
 s5-20020a2e9c05000000b002d24783872amr3918398lji.29.1709919700550; Fri, 08 Mar
 2024 09:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308165232.53906-1-silviu.barbulescu@nxp.com> <20240308165232.53906-3-silviu.barbulescu@nxp.com>
In-Reply-To: <20240308165232.53906-3-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 8 Mar 2024 12:41:28 -0500
Message-ID: <CABBYNZ+vH71y1bEhLDtnmsfvMLJ7wUnA60R3-DJ_kB7w2NzgEA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/3] transport: Add support to update the transport configuration
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Fri, Mar 8, 2024 at 11:52=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Add support to update the transport configuration
>
> ---
>  profiles/audio/transport.c | 23 +++++++++++++++++++++++
>  profiles/audio/transport.h |  1 +
>  2 files changed, 24 insertions(+)
>
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 159fbd575..c8492d4a1 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -1483,6 +1483,29 @@ static void bap_update_bcast_qos(const struct medi=
a_transport *transport)
>                         "Configuration");
>  }
>
> +void bap_update_bcast_config(struct media_transport *transport)
> +{
> +       struct bap_transport *bap =3D transport->data;
> +       struct iovec *cc;
> +
> +       cc =3D bt_bap_stream_get_config(bap->stream);
> +
> +       if (((int)cc->iov_len !=3D transport->size) ||
> +               (memcmp(cc->iov_base, transport->configuration,
> +                       transport->size) !=3D 0)) {
> +               free(transport->configuration);
> +               transport->configuration =3D util_memdup(cc->iov_base,
> +                                                       cc->iov_len);
> +               transport->size =3D cc->iov_len;
> +
> +               g_dbus_emit_property_changed(btd_get_dbus_connection(),
> +                       transport->path, MEDIA_TRANSPORT_INTERFACE,
> +                       "Configuration");
> +       }
> +
> +       bap_update_bcast_qos(transport);
> +}
> +
>  static guint transport_bap_resume(struct media_transport *transport,
>                                 struct media_owner *owner)
>  {
> diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
> index b46bc8025..6df419a67 100644
> --- a/profiles/audio/transport.h
> +++ b/profiles/audio/transport.h
> @@ -16,6 +16,7 @@ struct media_transport *media_transport_create(struct b=
td_device *device,
>                                                 uint8_t *configuration,
>                                                 size_t size, void *data,
>                                                 void *stream);
> +void bap_update_bcast_config(struct media_transport *transport);

Lets not bypass layers here, so the config updates probably need to be
pushed thru bt_bap_stream somehow, perhaps via a new callback or a
state change where the transport.c can query the new configuration and
update its D-Bus property.

>  void media_transport_destroy(struct media_transport *transport);
>  const char *media_transport_get_path(struct media_transport *transport);
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
