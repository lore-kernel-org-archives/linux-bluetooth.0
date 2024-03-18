Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFF55E42
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783508; cv=none; b=AE0jSagIQcRLLHptqkhukO2uNcdn9GxnhnL5zcS8wFqsd8kzZpY4axV1P/9n5K2TNryDRArZ7TQ5kDwaHU8ZSoKVMByFNS0pJNAlegoIfmd0q68bB28zVhx66bTkvp4gcBCvxYwPwtcDdBjzLEDLV3SwaR8cFT2D8/qXDnzBaiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783508; c=relaxed/simple;
	bh=GVlE9G6+hWkhA2ey+er7iMYquoRltEz+dobpXAIZUGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXIoutkrKwzxi+L02ywX98wjNuOWbKUQ2xW2AfLZxYHOcCZxL1hS+eDDcYvHtsmusoLy5+o/EP1+7uvucfrY/f8hjM39HdAkwBHQUpm30CiOL8hRmCTWuavamfBfRi4NjZAMuhbOCYW04XarhDAnszfRn+q4Lr2oQqUgs/wSDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm+2+681; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm+2+681"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d28051376eso75589351fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710783505; x=1711388305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyYrP1E5Ts83b8z/e+7ECzvdaYjijY63GIoKx09GJ4s=;
        b=lm+2+681yP3xXRvbZjquH3oRCuTtKd8jENTRMiZVHNdeDVp7PfnQPWnTNwBifp8JaK
         HqAOUn1tS6kTIxPD8jlcrTzJAVbGQo6S7WgiUalA4OaBOiMpeOLz4w4rL6RhNprGEsi/
         k6/TqpAeHTFnCiNdsHddQc3i1nL7iP6kyObtrCVBCTnj3ElCYNePnEdn3Aiosk0FSlaC
         c4exw/zxyyKQyTZQXuiyv3ZJ37aQcemX3sywSlSm5FD8rXOKRxkwN1k8FbaAv1taTNId
         fkL53KVHElVyhPORxOGxGTjy5VgQF8ljRQeBO5p/LRyR/Am/wxYDnl+TerrWlJPbmT36
         5QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783505; x=1711388305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyYrP1E5Ts83b8z/e+7ECzvdaYjijY63GIoKx09GJ4s=;
        b=XZkUCpqkKwGoePzZJQmH3M1DLNShldjNve8K5y2STp/EUbAI+hxBr5WjnU5q1RzQqA
         VAgP3fBYBTVf1mBwSeDzJmpBc7weHtMsMWjbTRgdH1wITave5FIuQcINVGtTXi6s3gs7
         A9xw2Ff+rw98s60u5FYcjToQl1TECEgYhPg674xCZgP9enRYsc7tkWropDtwU+R4mXIj
         x68PtL3N4OwbTbLUQtWcPYubkP1vr3n3Dt4Fxn+xOLMziUkrwAiq63JIsOBRE+8sjUfH
         645ftUcdj+enscK82Iw79+YxDzOeNCnBm5DT/zLozRihkmEraB3chTtRGrcUDBrZvVMT
         9XbA==
X-Gm-Message-State: AOJu0Yx3QHaUzRPqCjIahDdGUWUG2NsRvFl1kXx+VSahaYXOpqzWBclG
	wED1cOgC1hrJLjrpc5B8xlTjoxRCJ7vgdtGhJUKY1rA2qfJ3Nj2OQTuXAbIUvP8BTouaN+I/qzh
	RTaO5co93ZfevD9jhcYQ6sPI8cnw=
X-Google-Smtp-Source: AGHT+IHM4c/rxbEgkVkGBNopChQiw4QkOGOWZFfPOPaXU6o1ORuALdYDHYQBDW6EBafhA4UgIOSM3Hto7ldHwhtIOHw=
X-Received: by 2002:a2e:8747:0:b0:2d4:8bfe:69b7 with SMTP id
 q7-20020a2e8747000000b002d48bfe69b7mr5302584ljj.46.1710783504328; Mon, 18 Mar
 2024 10:38:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318163853.68598-1-silviu.barbulescu@nxp.com> <20240318163853.68598-4-silviu.barbulescu@nxp.com>
In-Reply-To: <20240318163853.68598-4-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 18 Mar 2024 17:38:10 +0000
Message-ID: <CABBYNZKaxEL5OZud2CVi+2b6r9Oq16gyqR3YOEdnfjSAHO9Q-w@mail.gmail.com>
Subject: Re: [PATCH BlueZ v4 3/5] bap: Broadcast source reconfiguration
 support added
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Mon, Mar 18, 2024 at 4:39=E2=80=AFPM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> If a BIS is reconfigured, the metadata and codec capabilities are updated=
.
> Also, the BASE is updated to reflect the update.
>
> ---
>  profiles/audio/bap.c       | 76 ++++++++++++++++++++++++++++++++++++++
>  profiles/audio/transport.c |  6 ++-
>  src/shared/bap.c           | 11 +++++-
>  3 files changed, 91 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 964ba9c21..e508e03ba 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -580,6 +580,11 @@ static int setup_parse_bcast_qos(struct bap_setup *s=
etup, const char *key,
>                         return -EINVAL;
>
>                 dbus_message_iter_get_basic(iter, &qos->bcast.big);
> +       } else if (!strcasecmp(key, "BIS")) {
> +               if (var !=3D DBUS_TYPE_BYTE)
> +                       return -EINVAL;
> +
> +               dbus_message_iter_get_basic(iter, &qos->bcast.bis);
>         } else if (!strcasecmp(key, "Options")) {
>                 if (var !=3D DBUS_TYPE_BYTE)
>                         return -EINVAL;
> @@ -884,6 +889,53 @@ static void setup_free(void *data)
>         free(setup);
>  }
>
> +static void iterate_setups(struct bap_setup *setup)
> +{
> +       const struct queue_entry *entry;
> +       struct bap_setup *ent_setup;
> +       uint8_t bis_cnt =3D 1;
> +
> +       for (entry =3D queue_get_entries(setup->ep->setups);
> +                               entry; entry =3D entry->next) {
> +               ent_setup =3D entry->data;
> +
> +               if (setup->qos.bcast.big !=3D ent_setup->qos.bcast.big)
> +                       continue;
> +
> +               util_iov_free(ent_setup->base, 1);
> +               ent_setup->base =3D NULL;

I do wonder why we need to store the base as part of the setup? Can't
we just generate it later when it is actually about to be configured
into the socket like I did?

> +               if (setup->qos.bcast.bis =3D=3D bis_cnt) {
> +                       bt_bap_stream_config(ent_setup->stream, &setup->q=
os,
> +                                               setup->caps, NULL, NULL);
> +                       bt_bap_stream_metadata(ent_setup->stream,
> +                                       setup->metadata, NULL, NULL);
> +               }
> +
> +               bis_cnt++;
> +       }
> +}
> +
> +static bool verify_state(struct bap_setup *setup)
> +{
> +       const struct queue_entry *entry;
> +       struct bap_setup *ent_setup;
> +
> +       for (entry =3D queue_get_entries(setup->ep->setups);
> +                               entry; entry =3D entry->next) {
> +               ent_setup =3D entry->data;
> +
> +               if (setup->qos.bcast.big !=3D ent_setup->qos.bcast.big)
> +                       continue;
> +
> +               if (bt_bap_stream_get_state(ent_setup->stream) =3D=3D
> +                               BT_BAP_STREAM_STATE_STREAMING)
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
>  static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage =
*msg,
>                                                                 void *dat=
a)
>  {
> @@ -925,6 +977,30 @@ static DBusMessage *set_configuration(DBusConnection=
 *conn, DBusMessage *msg,
>                 util_iov_free(setup->metadata, 1);
>                 setup->metadata =3D util_iov_dup(
>                                 bt_bap_pac_get_metadata(ep->rpac), 1);
> +       } else if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SOUR=
CE) {
> +               if (setup->qos.bcast.bis !=3D BT_ISO_QOS_BIS_UNSET) {
> +                       if ((setup->qos.bcast.bis > queue_length(ep->setu=
ps)) ||
> +                                       (setup->qos.bcast.bis =3D=3D 0)) =
{
> +                               setup_free(setup);
> +                               return btd_error_invalid_args(msg);
> +                       }
> +
> +                       /* Verify that no BIS in the BIG is in streaming =
state
> +                        */
> +                       if (!verify_state(setup)) {
> +                               setup_free(setup);
> +                               return btd_error_not_permitted(msg,
> +                                               "Broadcast Audio Stream s=
tate is invalid");
> +                       }

I was thinking we could delay the BASE setup until later when the code
actually needs it then the code for stream_get_base can actually
detect what are the streams with the same BIG and generate the BASE
just once.

> +                       /* Find and update the BIS specified in
> +                        * set_configuration command
> +                        */
> +                       iterate_setups(setup);
> +
> +                       setup_free(setup);
> +                       return g_dbus_create_reply(msg, DBUS_TYPE_INVALID=
);
> +               }
>         }
>
>         setup->stream =3D bt_bap_stream_new(ep->data->bap, ep->lpac, ep->=
rpac,
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 122c3339e..a060f8c61 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -1643,8 +1643,12 @@ static void bap_state_changed(struct bt_bap_stream=
 *stream, uint8_t old_state,
>                 bap_update_links(transport);
>                 if (!media_endpoint_is_broadcast(transport->endpoint))
>                         bap_update_qos(transport);
> -               else if (bt_bap_stream_io_dir(stream) !=3D BT_BAP_BCAST_S=
OURCE)
> +               else if (bt_bap_stream_io_dir(stream) !=3D BT_BAP_BCAST_S=
OURCE) {
>                         bap_update_bcast_qos(transport);
> +                       if (old_state =3D=3D BT_BAP_STREAM_STATE_QOS)
> +                               bap_update_bcast_config(transport);
> +               }
> +
>                 transport_update_playing(transport, FALSE);
>                 return;
>         case BT_BAP_STREAM_STATE_DISABLING:
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index fd99cbbca..603d6d646 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -1701,7 +1701,16 @@ static unsigned int bap_bcast_config(struct bt_bap=
_stream *stream,
>                                      struct bt_bap_qos *qos, struct iovec=
 *data,
>                                      bt_bap_stream_func_t func, void *use=
r_data)
>  {
> -       stream->qos =3D *qos;
> +       if (qos) {
> +               stream->qos =3D *qos;
> +               stream->qos.bcast.bcode =3D util_iov_dup(qos->bcast.bcode=
, 1);
> +       }
> +
> +       if (data) {
> +               util_iov_free(stream->cc, 1);
> +               stream->cc =3D util_iov_dup(data, 1);
> +       }
> +
>         stream->lpac->ops->config(stream, stream->cc, &stream->qos,
>                         ep_config_cb, stream->lpac->user_data);
>
> --
> 2.39.2

These changes to shared/bap shall be submitted in a separate patch
with a proper description.


--=20
Luiz Augusto von Dentz
