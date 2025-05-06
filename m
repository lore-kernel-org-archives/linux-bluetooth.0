Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED827875C
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550590; cv=none; b=cvbi8f2zKzyqH+G9Wx3KxZ5GBaRF0uk7j1vV/uIMf7X6qELFmafQ6FgizaYzCgjCnv2+IV75/VwcRD5AyY1TUpiHz6A4zTMkMYTH4tjPjT9+lrtvs2CZaBdtGdiLl9Om41AXkOPupG1FM25qvpDsTxMmc7wqcP+a4EvI6vyTPJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550590; c=relaxed/simple;
	bh=xYU+AjiaUkDOYjA7ynRhUxOzUpWl97rlDe6yxNuLcAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXjqNsXcN0t7jl/34dj0agBgcrYVpzO+c8447BaqfO1t5aE31vs2ERmTeigh+NN6hEfPwE5GUeOsAj68TQZP84AFVqtA0/mZtjD9YX/Ia2MDqObd329xPeCc8KKeAa4uhBS675HBPGL9zYYDdzD5e5ebIvVHG85y930Y512xj8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS2RCg8L; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS2RCg8L"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30f30200b51so60524681fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 May 2025 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746550586; x=1747155386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeHGQi3tCVVrol8SbIveF0AosxGZb3r0Wwo8TIKDHBI=;
        b=cS2RCg8LMW+JqUzd6IudR98Nj79UbU+/dloRlnGUif/A0nsNur5kfd4ShxYLiGSWt8
         cRXcdQYor2V3wZe4qrCEeab+IIpX43FRpYnkNpp0qCnYsgPv+uzlcJ2bfXXAnJUpAyFP
         2jCO59WLyl8+KMYEJO1R6xIY/NsUSOpgbeBKUmfqb6UoUU/fW8gcgYm87XxridXK6h0c
         RScLGupxWS4C0bkSfiadCpJne4Lvb6W/HZpVQgw46oTcYKBs9N0dBoN4BA9xIgUWoE0R
         n5zrmCm/QkXVy9tB6nLwGOGmYTBWSbzGPy/bBiQ08IKMqSCnPAB6YdtRDBUmFN7DGbSv
         vfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550586; x=1747155386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeHGQi3tCVVrol8SbIveF0AosxGZb3r0Wwo8TIKDHBI=;
        b=hUsREQqSXCd74SF6CBLluPs40XDfehznMO/7el+Z0ZXN3WRZfzeQWyI8AXV8ig0Ceh
         v7F8nXva60Rt5cFoNv/kgRpXpYomQR2/oA8Fzc6ffYKm2j9jgOquR5eL/n4oBPewA6FT
         oouEWx8Ui3jn1r2En5zlupLytGkN3a2Oxe7GV8+qRDdPOTA8GMa0l9sWKavMHh0X9uFN
         7smAgcsdGWeDJNaBwwPK5xCMduPOfM/loHHEWfZI8IpSns3s9pNKUpO9vRQrE9GAEp/l
         vIhUaE5exlycQOOG72yU7gjEqprYS4cRoN4Kwbvd9SRzJon+dUW3QnUrs+J1jwIrvICn
         WhsA==
X-Gm-Message-State: AOJu0YywO22dzxfr6idwZj6BqwJJbUiy3LPs4D8IFq3yrrZbVvstD7Uk
	/ciLSfsgoCAS/wc381nU6OTPsmGFTJWKltHTEuolGxqRq1WfYrYT8fUHtq1eT72As8znv6zMa1m
	RK+H4Q0Tdmql5w4bFfgKD31eUogCE7A==
X-Gm-Gg: ASbGncuAPoSuABVVS84tWbPsX4d1yNXGcqOnBdmLhzQrJhDo9wyc9WGHdsV9rtxxlb+
	g4H342GAtOnPkxTAzKe8E9WOVP1wwHA5GNXeUPLrOxeDmerR3jy5caJlcNJjrXbAulJ8f7MgtTM
	7illbm10y8ZjbGibXjPIaK
X-Google-Smtp-Source: AGHT+IGrrJ4v/ZzlHBVjOU37r8n9CyflI+h+l16UUGtQtGJA95QKuY7ilNSylC4II05LRbV99BaVnOme7waxm0neY5A=
X-Received: by 2002:a2e:bc21:0:b0:30b:b956:53c2 with SMTP id
 38308e7fff4ca-32348c46101mr40860851fa.11.1746550586142; Tue, 06 May 2025
 09:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
 <52645e73ab0c6f12d2a29b17259222417cf81a93.1746374514.git.pav@iki.fi>
In-Reply-To: <52645e73ab0c6f12d2a29b17259222417cf81a93.1746374514.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 6 May 2025 12:56:13 -0400
X-Gm-Features: ATxdqUHDjGa5Es2tC5KC8DfbvFLnmgMW0malU3SiKxT9_VN1Jw3iHebMHs7e6ds
Message-ID: <CABBYNZ+C95QEVk3+R__dQrKVoKCgZc8+X25-BCqy9kYvwFk_AQ@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ v2 04/11] shared/bap: fix ucast client ASE usage
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sun, May 4, 2025 at 12:02=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> The ucast client stream design has issues:
>
> * Assuming lpac & rpac pair uniquely identifies a stream.  False for
>   AC6(i) and other multi-stream configs.
>
> * No way for ASE in Config state be configured with different codec.
>
> * Assuming ASE enters idle state at end of stream life cycle.  False for
>   some devices like Sony headsets, which always cache codec config so
>   RELEASING -> CONFIG always, never RELEASING -> IDLE, so ASE never go
>   IDLE again.
>
> * Assuming Unicast Client upper layer always creates streams for all
>   non-idle ASEs.  False, as when switching between duplex & sink-only
>   modes, only some streams shall be used regardless of whether Server is
>   caching config or not.

I think it would make sense to fix these points one by one, or you
tried that and ended up running into some problems?

> In practice, these currently prevent reconfiguring ASEs on devices which
> cache codec config, and multi-stream configs work only accidentally (and
> fail if server does Config codec itself, like some devices do).
>
> Minimally fixed design for Unicast Client streams:
>
> Streams correspond 1-to-1 to ASEs in non-IDLE state.
>
> Track explicitly which streams upper level is using:
>
> - bt_bap_stream_new() always makes new stream with client_active=3Dtrue
> - bt_bap_stream_discard() releases stream and marks client_active=3Dfalse

This perhaps could be done differently, perhaps having a lock flag, so
if the stream is locked it means its configuration cannot be changed.

> Streams (ASEs) with no active client may be reused when upper level asks
> for a new stream.
>
> Streams with no active client may have their lpac changed.  The
> need_reconfig state is a bit ugly, but not really avoidable.

Do we have a situation where client_active=3Dfalse (lock=3Dfalse) and
need_reconfig!=3Dtrue? In other words could we just use the
client_active/lock flag instead of introducing yet another flag?

> Streams with no active client shall be ignored when constructing
> bidirectional CIS pairs.
>
> Streams shall clear transport and detach io on RELEASING. (cf BAP v1.0.2
> =C2=A75.6.6). Also unlink them since QoS is gone at that point.

I'd consider fixing this as a separate patch as well.

> Streams shall have transport only for >=3D QOS state.  (Server streams
> work differently, which makes sense since upper level cannot acquire
> them before they are pending.)

Sounds good, that said we might want to check if there aren't missing
tests that would cover such conditions, there is a whole session of
the BAP testing spec dedicated for streaming configuration (AC-#), if
will probably need some changes to test-bap to create socketpair to
emulate CIS since those tests require CIS/BIS in order to pass.

> ---
>  src/shared/bap.c | 170 +++++++++++++++++++++++++++++++++--------------
>  src/shared/bap.h |   2 +
>  2 files changed, 123 insertions(+), 49 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 976e3c0b1..456450d40 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -296,6 +296,8 @@ struct bt_bap_stream {
>         struct queue *pending_states;
>         bool no_cache_config;
>         bool client;
> +       bool client_active;
> +       bool need_reconfig;
>         void *user_data;
>  };
>
> @@ -1488,6 +1490,13 @@ static void bap_stream_state_changed(struct bt_bap=
_stream *stream)
>                 if (stream->client)
>                         bt_bap_stream_stop(stream, stream_stop_complete, =
NULL);
>                 break;
> +       case BT_ASCS_ASE_STATE_RELEASING:
> +               if (stream->client) {
> +                       bap_stream_clear_cfm(stream);
> +                       bap_stream_io_detach(stream);
> +                       bt_bap_stream_io_unlink(stream, NULL);
> +               }
> +               break;
>         }
>  }
>
> @@ -1898,6 +1907,9 @@ static unsigned int bap_ucast_qos(struct bt_bap_str=
eam *stream,
>         if (!stream->client)
>                 return 0;
>
> +       if (stream->need_reconfig)
> +               return 0;
> +
>         memset(&qos, 0, sizeof(qos));
>
>         /* TODO: Figure out how to pass these values around */
> @@ -2300,7 +2312,6 @@ static unsigned int bap_ucast_release(struct bt_bap=
_stream *stream,
>         /* If stream does not belong to a client session, clean it up now=
 */
>         if (!bap_stream_valid(stream)) {
>                 stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> -               stream =3D NULL;
>                 return 0;
>         }
>
> @@ -2583,6 +2594,9 @@ static int bap_ucast_io_link(struct bt_bap_stream *=
stream,
>                         stream->ep->dir =3D=3D link->ep->dir)
>                 return -EINVAL;
>
> +       if (stream->client && !(stream->client_active && link->client_act=
ive))
> +               return -EINVAL;
> +
>         if (!stream->links)
>                 stream->links =3D queue_new();
>
> @@ -2603,6 +2617,30 @@ static int bap_ucast_io_link(struct bt_bap_stream =
*stream,
>         return 0;
>  }
>
> +static void stream_unlink_ucast(void *data)
> +{
> +       struct bt_bap_stream *link =3D data;
> +
> +       DBG(link->bap, "stream %p unlink", link);
> +
> +       queue_destroy(link->links, NULL);
> +       link->links =3D NULL;
> +}
> +
> +static int bap_ucast_io_unlink(struct bt_bap_stream *stream,
> +                                               struct bt_bap_stream *lin=
k)
> +{
> +       if (!stream)
> +               return -EINVAL;
> +
> +       queue_destroy(stream->links, stream_unlink_ucast);
> +       stream->links =3D NULL;
> +
> +       DBG(stream->bap, "stream %p unlink", stream);
> +       return 0;
> +
> +}
> +
>  static void stream_link(void *data, void *user_data)
>  {
>         struct bt_bap_stream *stream =3D (void *)data;
> @@ -2708,7 +2746,7 @@ static const struct bt_bap_stream_ops stream_ops[] =
=3D {
>                         bap_ucast_release, bap_ucast_detach,
>                         bap_ucast_set_io, bap_ucast_get_io,
>                         bap_ucast_io_dir, bap_ucast_io_link,
> -                       NULL),
> +                       bap_ucast_io_unlink),
>         STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
>                         bap_ucast_get_state,
>                         bap_ucast_config, bap_ucast_qos, bap_ucast_enable=
,
> @@ -2718,7 +2756,7 @@ static const struct bt_bap_stream_ops stream_ops[] =
=3D {
>                         bap_ucast_release, bap_ucast_detach,
>                         bap_ucast_set_io, bap_ucast_get_io,
>                         bap_ucast_io_dir, bap_ucast_io_link,
> -                       NULL),
> +                       bap_ucast_io_unlink),
>         STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
>                         bap_bcast_get_state,
>                         bap_bcast_config, bap_bcast_qos, bap_bcast_sink_e=
nable,
> @@ -5015,6 +5053,8 @@ static void ep_status_config(struct bt_bap *bap, st=
ruct bt_bap_endpoint *ep,
>                 ep->stream->cc =3D new0(struct iovec, 1);
>
>         util_iov_memcpy(ep->stream->cc, cfg->cc, cfg->cc_len);
> +
> +       ep->stream->need_reconfig =3D false;
>  }
>
>  static void bap_stream_config_cfm_cb(struct bt_bap_stream *stream, int e=
rr)
> @@ -5922,43 +5962,6 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap,=
 struct bt_bap_pac *pac)
>         return false;
>  }
>
> -static bool find_ep_unused(const void *data, const void *user_data)
> -{
> -       const struct bt_bap_endpoint *ep =3D data;
> -       const struct match_pac *match =3D user_data;
> -
> -       if (ep->stream)
> -               return false;
> -
> -       if (match->rpac)
> -               return ep->dir =3D=3D match->rpac->type;
> -       else
> -               return true;
> -}
> -
> -static bool find_ep_pacs(const void *data, const void *user_data)
> -{
> -       const struct bt_bap_endpoint *ep =3D data;
> -       const struct match_pac *match =3D user_data;
> -
> -       if (!ep->stream)
> -               return false;
> -
> -       if (ep->stream->lpac !=3D match->lpac)
> -               return false;
> -
> -       if (ep->stream->rpac !=3D match->rpac)
> -               return false;
> -
> -       switch (ep->state) {
> -       case BT_BAP_STREAM_STATE_CONFIG:
> -       case BT_BAP_STREAM_STATE_QOS:
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
>  static bool find_ep_source(const void *data, const void *user_data)
>  {
>         const struct bt_bap_endpoint *ep =3D data;
> @@ -6136,6 +6139,48 @@ static struct bt_bap_stream *bap_bcast_stream_new(=
struct bt_bap *bap,
>         return stream;
>  }
>
> +static bool find_ep_ucast(const void *data, const void *user_data)
> +{
> +       const struct bt_bap_endpoint *ep =3D data;
> +       const struct match_pac *match =3D user_data;
> +
> +       if (ep->stream) {
> +               if (!ep->stream->client)
> +                       return false;
> +               if (ep->stream->client_active)
> +                       return false;
> +               if (!queue_isempty(ep->stream->pending_states))
> +                       return false;
> +
> +               switch (ep->stream->state) {
> +               case BT_BAP_STREAM_STATE_IDLE:
> +               case BT_BAP_STREAM_STATE_CONFIG:
> +               case BT_BAP_STREAM_STATE_QOS:
> +                       break;
> +               default:
> +                       return false;
> +               }
> +       }
> +
> +       if (ep->dir !=3D match->rpac->type)
> +               return false;
> +
> +       switch (match->lpac->type) {
> +       case BT_BAP_SOURCE:
> +               if (ep->dir !=3D BT_BAP_SINK)
> +                       return false;
> +               break;
> +       case BT_BAP_SINK:
> +               if (ep->dir !=3D BT_BAP_SOURCE)
> +                       return false;
> +               break;
> +       default:
> +               return false;
> +       }
> +
> +       return true;
> +}
> +
>  static struct bt_bap_stream *bap_ucast_stream_new(struct bt_bap *bap,
>                                         struct bt_bap_pac *lpac,
>                                         struct bt_bap_pac *rpac,
> @@ -6153,21 +6198,28 @@ static struct bt_bap_stream *bap_ucast_stream_new=
(struct bt_bap *bap,
>         match.lpac =3D lpac;
>         match.rpac =3D rpac;
>
> -       /* Check for existing stream */
> -       ep =3D queue_find(bap->remote_eps, find_ep_pacs, &match);
> +       /* Get free ASE */
> +       ep =3D queue_find(bap->remote_eps, find_ep_ucast, &match);
>         if (!ep) {
> -               /* Check for unused ASE */
> -               ep =3D queue_find(bap->remote_eps, find_ep_unused, &match=
);
> -               if (!ep) {
> -                       DBG(bap, "Unable to find unused ASE");
> -                       return NULL;
> -               }
> +               DBG(bap, "Unable to find usable ASE");
> +               return NULL;
>         }
>
>         stream =3D ep->stream;
> -       if (!stream)
> +       if (stream) {
> +               /* Replace lpac: the stream generally needs to be reconfi=
gured
> +                * after this, otherwise things like codec config not mat=
ch.
> +                */
> +               bap_stream_clear_cfm(stream);
> +               stream->lpac =3D lpac;
> +               util_iov_free(stream->cc, 1);
> +               stream->cc =3D util_iov_dup(data, 1);
> +               stream->need_reconfig =3D true;
> +       } else {
>                 stream =3D bap_stream_new(bap, ep, lpac, rpac, data, true=
);
> +       }
>
> +       stream->client_active =3D true;
>         return stream;
>  }
>
> @@ -6187,6 +6239,26 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_=
bap *bap,
>         return bap_bcast_stream_new(bap, lpac, pqos, data);
>  }
>
> +void bt_bap_stream_discard(struct bt_bap_stream *stream)
> +{
> +       if (!stream || !stream->client)
> +               return;
> +
> +       stream->client_active =3D false;
> +
> +       switch (stream->ep->state) {
> +       case BT_BAP_STREAM_STATE_IDLE:
> +       case BT_BAP_STREAM_STATE_RELEASING:
> +               break;
> +       case BT_BAP_STREAM_STATE_CONFIG:
> +               if (stream->ep->old_state =3D=3D BT_BAP_STREAM_STATE_RELE=
ASING)
> +                       break;
> +               /* Fallthrough */
> +       default:
> +               bt_bap_stream_release(stream, NULL, NULL);
> +       }
> +}
> +
>  struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
>  {
>         if (!stream)
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index d10581428..5949eb4b1 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -183,6 +183,8 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap=
 *bap,
>                                         struct bt_bap_qos *pqos,
>                                         struct iovec *data);
>
> +void bt_bap_stream_discard(struct bt_bap_stream *stream);
> +
>  struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream);
>  uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream);
>
> --
> 2.49.0
>
>


--=20
Luiz Augusto von Dentz
