Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B664F248871
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Mar 2025 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199358; cv=none; b=CzP2BreDG80LlXTovapmPwClY5t/SXn4GnHge2VBMMLYUF0EOacJIPMpv3Ep2RS5s9RElbyhaO9gNhuk0jLdc9pAYgs2yGgukr9mdC3mSLXff8bNrgkrylalqwA70vQ/4SfOii9qYSiMLDLMqICMNHzB60BqWsMlW90mfBObNzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199358; c=relaxed/simple;
	bh=IdCpdq0fSUS/EG05o2lwadkMJbP67+taV4lR2vP9Ero=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxX7MAFNDcOshdXGs0Cz50ZouNJWURWmEb1EDnHRrcq1hNTM8ACMeT2/PqgVpvDtO+iEa8SSSSoYINQmr1wTTkktjud7CbHdVVQ7E+h2/HEOtVTgasVI1YB/4x6FPpZ18V2pOvUrax3DyI8z6YEn4B9D8OCWW/49zrUbmZM9RWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gh7GN5Oq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gh7GN5Oq"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30761be8fcfso77249861fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Mar 2025 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741199354; x=1741804154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPjsMFw7jIYrn5N7AVDWTcKYcTZfsPEFniwANbqMdwk=;
        b=Gh7GN5Oqt97RQHOG8B/URVSyKprUGozg620VI0fXISYgryGApJhf2WiE8TBGctU9eu
         MZJ2DOYseHLTXwyKf6IIDkt4ubiEVFIR8L/wcNzg/UkL6PvSY6l0aA0VeDViKwNENlC9
         0V0uJyVy2BFqEZ8SxoZE3+U5oIgHXXU3ei+WgYM32F5uZNDXGoA0A0routGtzzJLymAJ
         ew1nHl7Ffy2o7VnaxE16PorufA+q1jkQDmbmHTSRNvSkDIkmc6hanJwAzaCInZtDdS9S
         QGfrYs3HjFdoVD5iKcq/NvnsFzv5Wedkx0NMew/imyTBzwdtaZaZgOXMwZvGInK09Gm2
         izig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199354; x=1741804154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VPjsMFw7jIYrn5N7AVDWTcKYcTZfsPEFniwANbqMdwk=;
        b=FaETyWuVq87xNXaq3EWmdheT0DFuDJNZTEEQO/hN66l/J+n8Qdj41qrV8qrfPnt8TU
         iO6TPgsbRYm2GUTUw1Qt8pPf/XRTGltVV96r3inXuKgZFHn8vitV+TY85XIK9cDLZyfW
         dtjzMh3IC06P3/9vgf5jfVW7nobhQci9fAKI4Ge74+mN5LsfOj0wEDk8+TQh1xaZOuq0
         jydHQzbeeKH+P90vF141ragJNlUOp+2hRnkMuNiZIdCs1DETzbCURI7rlh7dychPM/wc
         8kE66jV4GC0ffPpmHnyAXGywnP5hxM9xTYfEQju96a9QPGOnKIqlJQhLZJoAfUngRG0x
         a0RA==
X-Gm-Message-State: AOJu0Yw5TleJTxfEof/WMMvJ1jqHJ+NaJQCrfwHPKdtEgEYJYYCIVdya
	kF3xaPqqY5PzMWx5J8sPqSzDiyJ+kSwY987HAiopuAWSZnXuUJUWy20vFF5QvWXzhDoqc0qDa/x
	T/g89PcBJjaNmsES5IgrY2OsByhg=
X-Gm-Gg: ASbGncvbg8Xo2zF62jryEabzqXftDIMzCnhfOU65Us/tl/w9Iz+9uEe3ddfewcmESln
	lBCcZURZWE1NDSWu7lVuOD52dOz3zCC8jPs+1PEZM4VeBJRewV5XOdwN62nzVcy4kYmnKlDqkus
	7TFj3Ev8jJnA5iQxGE6YsX1JM3
X-Google-Smtp-Source: AGHT+IFwBxrH4ctN8vHO4XRDi29SHdV3OmUDAPrKjYnzOVbhZ6Lq5tbw3kwYqJTVgIkN0+vgHVAw4okAQDurI8TRI8s=
X-Received: by 2002:a05:651c:2224:b0:309:2283:bea8 with SMTP id
 38308e7fff4ca-30bd7af891fmr17488411fa.34.1741199353304; Wed, 05 Mar 2025
 10:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
In-Reply-To: <1b2a8e408573624a7b5e5e792c7e89c8315811e3.1741190102.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Mar 2025 13:28:59 -0500
X-Gm-Features: AQ5f1JosAUoAAAtqfMX-N3LGsXVI6S0KVIpY4pJ9INFAi-n9Co12o901aCzgE3A
Message-ID: <CABBYNZ+Utz=i7tazocfbsZ_+cYA0SiF57Jrdct9Ngn0AXDVcZw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] btdev: pass sent SCO data to bthost
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Wed, Mar 5, 2025 at 10:58=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Actually send SCO data to the linked connection, if any.
> ---
>  emulator/btdev.c | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/emulator/btdev.c b/emulator/btdev.c
> index ec52c5242..c44b52c49 100644
> --- a/emulator/btdev.c
> +++ b/emulator/btdev.c
> @@ -2807,6 +2807,10 @@ static int cmd_enhanced_setup_sync_conn_complete(s=
truct btdev *dev,
>  done:
>         send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
>
> +       if (conn)
> +               send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE=
,
> +                                                       &cc, sizeof(cc));
> +
>         return 0;
>  }
>
> @@ -2853,6 +2857,10 @@ static int cmd_setup_sync_conn_complete(struct btd=
ev *dev, const void *data,
>  done:
>         send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
>
> +       if (conn)
> +               send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE=
,
> +                                                       &cc, sizeof(cc));

Great work, this might be handy for adding tests for SCO data.

>         return 0;
>  }
>
> @@ -7655,6 +7663,33 @@ static void send_acl(struct btdev *dev, const void=
 *data, uint16_t len)
>         send_packet(conn->link->dev, iov, 3);
>  }
>
> +static void send_sco(struct btdev *dev, const void *data, uint16_t len)
> +{
> +       struct bt_hci_sco_hdr hdr;
> +       struct iovec iov[2];
> +       struct btdev_conn *conn;
> +       uint8_t pkt_type =3D BT_H4_SCO_PKT;
> +
> +       /* Packet type */
> +       iov[0].iov_base =3D &pkt_type;
> +       iov[0].iov_len =3D sizeof(pkt_type);
> +
> +       iov[1].iov_base =3D (void *) (data);
> +       iov[1].iov_len =3D len;
> +
> +       memcpy(&hdr, data, sizeof(hdr));
> +
> +       conn =3D queue_find(dev->conns, match_handle,
> +                                       UINT_TO_PTR(acl_handle(hdr.handle=
)));
> +       if (!conn)
> +               return;
> +
> +       /* TODO: flow control */
> +
> +       if (conn->link)
> +               send_packet(conn->link->dev, iov, 2);
> +}
> +
>  static void send_iso(struct btdev *dev, const void *data, uint16_t len)
>  {
>         struct bt_hci_acl_hdr *hdr;
> @@ -7702,6 +7737,9 @@ void btdev_receive_h4(struct btdev *btdev, const vo=
id *data, uint16_t len)
>         case BT_H4_ACL_PKT:
>                 send_acl(btdev, data + 1, len - 1);
>                 break;
> +       case BT_H4_SCO_PKT:
> +               send_sco(btdev, data + 1, len - 1);
> +               break;

Ive done something very similar but adding support for Sync Flow
Control, might be a good idea to rebase once we are done with enabling
that in the kernel so we can start adding more tests to sco-tester.

>         case BT_H4_ISO_PKT:
>                 send_iso(btdev, data + 1, len - 1);
>                 break;
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
