Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1252D50285
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Jan 2025 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179944; cv=none; b=oWy4azZscr7mHQkszERBXb6Q+ibhmOrFWyQ3UpQ9/ZLpH7Cv1l5KJUnw0243Cjo2EnEAKG3sDeyKAfSodRARH75qisG1d14wthYSaFyR5hOAPBAHUgf0/6t6r5vg8xLP6fPBVKFO1glD/9+eiwaMv4quMpcRZXEuYoe601arcuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179944; c=relaxed/simple;
	bh=OihynEtN0E74jr0Aa9mI/5O/aqQJfmkJAOX4az09YqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6VVnCNRL5W6zbrpPpEHC+Hr7Z19eXrXsF+nH00U9BP12Vt29oDGdnRb+VZZYuesS5l1Ink+g71BBjSG0Q3GJoFQZzFjLbDNYShaFMSLnuq8ZDTeqZmlamRDdv4BiGff338apJwj/FGNpigV25SHqeWA8iRAmI40LaIc37AqlL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcn/TxfP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcn/TxfP"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3003943288bso167163201fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2025 08:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736179941; x=1736784741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6liZHpReyPEAYcttqZnsiJmON8oLXoIXAKOhn8qdhc=;
        b=mcn/TxfPZuMr/3QIcN+9kACnFt9i5lMogCKPnRdTtVMu7tCbIpti2rhMYUJSmZ4gQW
         fgD7kSCBI7W2wM9lbwdl4VMFUsJMcIph0N2jIOz2/ea3EKLMMVBPALluAWIaQO613ynu
         cqxPvEQh8oWbab3ymtspEq6VYLPEuKs1vLYd9p5xmMnNScK6LfC1y932x0F5HW/D28BK
         k6qt1ar618ktoNkE7wzzA5U2YkiN0w962hseekCQphLs3m+Bl8xa2HVOtGIOdOzFugC5
         3itId5U8B1xzBknxaHHKJ/OUYXi7WD2vrZz/lhF0miZsB6vGM72zNzweq2lQuURo5HPF
         jRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736179941; x=1736784741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6liZHpReyPEAYcttqZnsiJmON8oLXoIXAKOhn8qdhc=;
        b=PS62DFQ03ZwrB7B5yjobtge21LqD4SbsLFpnJN+HDRN+yzQBeNmfDdRhb+fzg4/1KD
         JopPcUvzYzuImGo/p1HdTmKPvw3+2Eyk8g2/Jf+FMp5E9hdxv8eycK61gq7l2ph9zyOM
         AJXD89xY+EtBkrKym6MJ9v2oejK3uwqGj9yaq/PxeSIUvWpkIetexw+ZSzFSZTP5KwJR
         DyB18BgKTB3hO45U8dsXPPp4BBgCZNdYtVDhdBEjWgWU2HjVxPCwrrej9p+30mQLLF2O
         UFWyWQXa6Wm8S8NuEhmN00ZY/L1NYN7JEGej7Z6qxQsRZt+yqAhYF2AEFk/0gP4d2NHo
         1Lzw==
X-Gm-Message-State: AOJu0Yz7GkTNtEdEHqt7idVZww3K24MPTCC9DrXiBFNOuroCWmedkwXt
	1u2vvcXrmCmodHs1U0YaqCBjDqXoFTHzjFdgAlQ8YJKsm+/Dq2AMbvrjSwTfeLtRKHvk8UqPY/E
	7ECJhRnUiwnJR0JGJk8ZNgHXUUtATNNli
X-Gm-Gg: ASbGncuMq3k7XghyPTxRWH4/8mKRiI4C/TWwoRXWg8UrJdruKs/4km52ZuEkcyqWGAI
	+W73xXBp+WmiJSxd7M4T7Z36pZKvRwcYXyhz6
X-Google-Smtp-Source: AGHT+IGpiA2kjp+2h236NGeMbzmkuJV/XbA7S/DjbcFUSQBPjygqEoW6jN0V+e1/6FYglj9Dm8qO9OaCz0RYuuxrQZY=
X-Received: by 2002:a05:651c:1401:b0:302:40ec:a1bb with SMTP id
 38308e7fff4ca-30468575de1mr138701081fa.21.1736179940822; Mon, 06 Jan 2025
 08:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106-upstream-v1-1-a16879b78ffd@amlogic.com>
In-Reply-To: <20250106-upstream-v1-1-a16879b78ffd@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 6 Jan 2025 11:12:08 -0500
Message-ID: <CABBYNZJzjKQFA7gaQ2m+PEO_vbMgAZ4wy4fp--Rc4JFAQqAU_A@mail.gmail.com>
Subject: Re: [PATCH BlueZ bluez] bap: fixed issue of muting music silent after
 pause and resume.
To: yang.li@amlogic.com
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Sun, Jan 5, 2025 at 9:50=E2=80=AFPM Yang Li via B4 Relay
<devnull+yang.li.amlogic.com@kernel.org> wrote:
>
> From: Yang Li <yang.li@amlogic.com>
>
> CIS sink need caching the Codec Configured when releasing by Pixel,
> state machine is releasing -> Codec. If streamming -> idle, CIS sink
> was silent after resume music.

You need to work on the commit message, perhaps quote the spec if
there is a description of the state transition.

> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
>  src/shared/bap.c | 43 +++++++++++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 167501282..a7f5dec92 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1063,6 +1063,28 @@ static void stream_notify_metadata(struct bt_bap_s=
tream *stream)
>         free(status);
>  }
>
> +static void stream_notify_release(struct bt_bap_stream *stream)
> +{
> +       struct bt_bap_endpoint *ep =3D stream->ep;
> +       struct bt_ascs_ase_status *status;
> +       size_t len;
> +
> +       DBG(stream->bap, "stream %p", stream);
> +
> +       len =3D sizeof(*status);
> +       status =3D malloc(len);

Just use a stack variable instead of using malloc.

> +
> +       memset(status, 0, len);
> +       status->id =3D ep->id;
> +       ep->state =3D BT_BAP_STREAM_STATE_RELEASING;
> +       status->state =3D ep->state;
> +
> +       gatt_db_attribute_notify(ep->attr, (void *) status, len,
> +                                       bt_bap_get_att(stream->bap));
> +
> +       free(status);
> +}
> +
>  static struct bt_bap *bt_bap_ref_safe(struct bt_bap *bap)
>  {
>         if (!bap || !bap->ref_count || !queue_find(sessions, NULL, bap))
> @@ -1634,7 +1656,7 @@ static bool stream_notify_state(void *data)
>         struct bt_bap_stream *stream =3D data;
>         struct bt_bap_endpoint *ep =3D stream->ep;
>
> -       DBG(stream->bap, "stream %p", stream);
> +       DBG(stream->bap, "stream %p status %d", stream, ep->state);
>
>         if (stream->state_id) {
>                 timeout_remove(stream->state_id);
> @@ -1655,6 +1677,9 @@ static bool stream_notify_state(void *data)
>         case BT_ASCS_ASE_STATE_DISABLING:
>                 stream_notify_metadata(stream);
>                 break;
> +       case BT_ASCS_ASE_STATE_RELEASING:
> +               stream_notify_release(stream);

Ok, I see where this is going, but the spec doesn't actually mandate
to send releasing or caching the codec configuration:

https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/23166=
-ASCS-html5/out/en/index-en.html#UUID-c37600a3-4541-1926-2f13-eb29057e41d5_=
N1661459513418

Perhaps you are saying that we need to send Releasing at least? There
is also the thing that I don't understand is why would someone send
release command and get rid of QoS/CIG while keeping the Codec
Configuration?

> +               break;
>         }
>
>         return false;
> @@ -1936,9 +1961,7 @@ static uint8_t stream_disable(struct bt_bap_stream =
*stream, struct iovec *rsp)
>         /* Sink can autonomously transit to QOS while source needs to go =
to
>          * Disabling until BT_ASCS_STOP is received.
>          */
> -       if (stream->ep->dir =3D=3D BT_BAP_SINK)
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
> -       else
> +       if (stream->ep->dir =3D=3D BT_BAP_SOURCE)

Don't think this is correct, why are you taking away the setting to
QoS like it is documented?

>                 stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
>
>         return 0;
> @@ -2068,17 +2091,11 @@ static unsigned int bap_ucast_metadata(struct bt_=
bap_stream *stream,
>
>  static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec=
 *rsp)
>  {
> -       struct bt_bap_pac *pac;
> -
>         DBG(stream->bap, "stream %p", stream);
>
>         ascs_ase_rsp_success(rsp, stream->ep->id);
>
> -       pac =3D stream->lpac;
> -       if (pac->ops && pac->ops->clear)
> -               pac->ops->clear(stream, pac->user_data);

Hmm, I think we do depend on clear to be called to tell the upper
stack the transport is being released, or you did test this with the
likes of pipewire and found that is not really required?

> -       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> +       stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
>
>         return 0;
>  }
> @@ -6172,8 +6189,10 @@ static bool stream_io_disconnected(struct io *io, =
void *user_data)
>
>         DBG(stream->bap, "stream %p io disconnected", stream);
>
> -       bt_bap_stream_set_io(stream, -1);
> +       if (stream->ep->state =3D=3D BT_ASCS_ASE_STATE_RELEASING)
> +               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>
> +       bt_bap_stream_set_io(stream, -1);
>         return false;
>  }
>
>
> ---
> base-commit: dfb1ffdc95a00bc06d81a75c11ab5ad2e24d37bf
> change-id: 20250106-upstream-1ec9ae96cda4
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>
>


--=20
Luiz Augusto von Dentz
