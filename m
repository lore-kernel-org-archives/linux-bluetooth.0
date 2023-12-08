Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSwkjMwW"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD00E1709
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 19:57:12 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ca0c36f5beso20734491fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 19:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702007831; x=1702612631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKbUf/EVmQcQdS12UEM/2+EXAHHyakHxSmHoatesalA=;
        b=MSwkjMwWI/BnbZIpK6EG3xFLAfNgkJaDCaMOxovRVzQhYpfAN7sTLA53FRvkcxGHLz
         lKhxhOAG7alQOTBBou+T2JEhJpubSmdZYV0eaAfy0QngeIe0UbSf1kfp6YCIuI1jEi7G
         dMSyAnyiYpagiscKjV+lt5rEJBID0DiTv/sq7xuFboLx6LgvuyVJuyR834x8v/zwRI4i
         iP1v1jREsnIOBgwWun3VFIQoTpdCsiv1SlbVExXIxDVe1h27o/+q6iV1f7xeA8HAj4H+
         PVqI1aHhBaHxJbfgQagPhcYmojDsLieOLDCnhicsl2RwCF/6ML8srE/z7gi65Fsdz23x
         a8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702007831; x=1702612631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKbUf/EVmQcQdS12UEM/2+EXAHHyakHxSmHoatesalA=;
        b=rVWOAw1DBjrIWUl3zpnkjuPfEIgF3wKZTqoyz4fim0T0642DKYqp3Seif82h7j4Keu
         1GupLfAYDFMKiDQ9OBgib6FADwqJhrILCX/PWYsJL8SeL5CMa2sn3Jl3omTUmXRNX4r1
         Ltw6SZY5pxHfCpZUbIptZHCncRnOm1c+EiaxtPHG3OhGyLdkDW4vYPxNEpFP7Kb9aQJ+
         cDJJAaAnpo8+JI4GmUfoEeZy+Tl4Iet+cB/E4m0N5QXuhd8Jz6jG5uZrA5wN1VkuzOAj
         O5TEmvg+O4pje2c9ruBVbq0jSQdemCWfi8p89yyCPK7dmhpbV82qhRlIp7vyW0I6RMK2
         iRnA==
X-Gm-Message-State: AOJu0Yz5NvrSDv+gu0aQFmSSQqErjtlrlsjIrI5LH6rPIRhoRAVHsWdK
	147DTMjoVqBqCfTnOYxt5CZXJnv/TBSOSQzgojo3rV1K
X-Google-Smtp-Source: AGHT+IELWKv4bwkVVyiW4RQUx23BnYyehUZs58RbaBEFyG81cATE/pBO/vktHJrc9IYjeP41ASsGW2dAjvdIp9tkJUw=
X-Received: by 2002:a2e:9a8e:0:b0:2c9:f04a:556c with SMTP id
 p14-20020a2e9a8e000000b002c9f04a556cmr2033506lji.71.1702007830645; Thu, 07
 Dec 2023 19:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206220325.3712902-1-luiz.dentz@gmail.com>
 <20231206220325.3712902-2-luiz.dentz@gmail.com> <ddfb204f3692f6a96e4ab0a72553fe9f6f224329.camel@iki.fi>
In-Reply-To: <ddfb204f3692f6a96e4ab0a72553fe9f6f224329.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 7 Dec 2023 22:56:58 -0500
Message-ID: <CABBYNZJ7T3sXr+o-+sTgu1bGXQD=KAjwdSf9VyoBC5y4GvRtLg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/2] shared/bap: Make bt_bap_select match the
 channel map
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Dec 7, 2023 at 1:00=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ke, 2023-12-06 kello 17:03 -0500, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > bt_bap_pac may actually map to multiple PAC records and each may have a
> > different channel count that needs to be matched separately, for
> > instance when trying with EarFun Air Pro:
> >
> > < ACL Data TX: Handle 2048 flags 0x00 dlen 85
> >       ATT: Write Command (0x52) len 80
> >         Handle: 0x0098 Type: ASE Control Point (0x2bc6)
> >           Data: 010405020206000000000a020103020201030428000602020600000
> >         0000a0201030202010304280001020206000000000a020103020201030428
> >         0002020206000000000a02010302020103042800
> >             Opcode: Codec Configuration (0x01)
> >             Number of ASE(s): 4
> >             ASE: #0
> >             ASE ID: 0x05
> >             Target Latency: Balance Latency/Reliability (0x02)
> >             PHY: 0x02
> >             LE 2M PHY (0x02)
> >             Codec: LC3 (0x06)
> >             Codec Specific Configuration: #0: len 0x02 type 0x01
> >               Sampling Frequency: 16 Khz (0x03)
> >             Codec Specific Configuration: #1: len 0x02 type 0x02
> >               Frame Duration: 10 ms (0x01)
> >             Codec Specific Configuration: #2: len 0x03 type 0x04
> >               Frame Length: 40 (0x0028)
> >             ASE: #1
> >             ASE ID: 0x06
> >             Target Latency: Balance Latency/Reliability (0x02)
> >             PHY: 0x02
> >             LE 2M PHY (0x02)
> >             Codec: LC3 (0x06)
> >             Codec Specific Configuration: #0: len 0x02 type 0x01
> >               Sampling Frequency: 16 Khz (0x03)
> >             Codec Specific Configuration: #1: len 0x02 type 0x02
> >               Frame Duration: 10 ms (0x01)
> >             Codec Specific Configuration: #2: len 0x03 type 0x04
> >               Frame Length: 40 (0x0028)
> >             ASE: #2
> >             ASE ID: 0x01
> >             Target Latency: Balance Latency/Reliability (0x02)
> >             PHY: 0x02
> >             LE 2M PHY (0x02)
> >             Codec: LC3 (0x06)
> >             Codec Specific Configuration: #0: len 0x02 type 0x01
> >               Sampling Frequency: 16 Khz (0x03)
> >             Codec Specific Configuration: #1: len 0x02 type 0x02
> >               Frame Duration: 10 ms (0x01)
> >             Codec Specific Configuration: #2: len 0x03 type 0x04
> >               Frame Length: 40 (0x0028)
> >             ASE: #3
> >             ASE ID: 0x02
> >             Target Latency: Balance Latency/Reliability (0x02)
> >             PHY: 0x02
> >             LE 2M PHY (0x02)
> >             Codec: LC3 (0x06)
> >             Codec Specific Configuration: #0: len 0x02 type 0x01
> >               Sampling Frequency: 16 Khz (0x03)
> >             Codec Specific Configuration: #1: len 0x02 type 0x02
> >               Frame Duration: 10 ms (0x01)
> >             Codec Specific Configuration: #2: len 0x03 type 0x04
> >               Frame Length: 40 (0x0028)
> >
> > Fixes: https://github.com/bluez/bluez/issues/612
> > ---
> >  profiles/audio/bap.c |  6 +--
> >  src/shared/bap.c     | 87 ++++++++++++++++++++++++++++++++++++++++----
> >  src/shared/bap.h     |  3 +-
> >  src/shared/util.c    | 43 ++++++++++++++++++++++
> >  src/shared/util.h    |  6 +++
> >  5 files changed, 132 insertions(+), 13 deletions(-)
> >
> > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> > index 965d7efe6561..16c5faee45f9 100644
> > --- a/profiles/audio/bap.c
> > +++ b/profiles/audio/bap.c
> > @@ -1290,10 +1290,8 @@ static bool pac_found(struct bt_bap_pac *lpac, s=
truct bt_bap_pac *rpac,
> >       }
> >
> >       /* TODO: Cache LRU? */
> > -     if (btd_service_is_initiator(service)) {
> > -             if (!bt_bap_select(lpac, rpac, select_cb, ep))
> > -                     ep->data->selecting++;
> > -     }
> > +     if (btd_service_is_initiator(service))
> > +             bt_bap_select(lpac, rpac, &ep->data->selecting, select_cb=
, ep);
> >
> >       return true;
> >  }
> > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > index a1495ca84bcc..2450b53232e3 100644
> > --- a/src/shared/bap.c
> > +++ b/src/shared/bap.c
> > @@ -185,6 +185,7 @@ struct bt_bap_pac {
> >       struct bt_bap_pac_qos qos;
> >       struct iovec *data;
> >       struct iovec *metadata;
> > +     struct queue *chan_map;
> >       struct bt_bap_pac_ops *ops;
> >       void *user_data;
> >  };
> > @@ -2417,6 +2418,33 @@ static void *ltv_merge(struct iovec *data, struc=
t iovec *cont)
> >       return iov_append(data, cont->iov_len, cont->iov_base);
> >  }
> >
> > +static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, ui=
nt8_t *v,
> > +                                     void *user_data)
> > +{
> > +     struct bt_bap_pac *pac =3D user_data;
> > +
> > +     if (!v)
> > +             return;
> > +
> > +     if (!pac->chan_map)
> > +             pac->chan_map =3D queue_new();
> > +
> > +     printf("PAC %p chan_map 0x%02x\n", pac, *v);
> > +
> > +     queue_push_tail(pac->chan_map, UINT_TO_PTR(*v));
> > +}
> > +
> > +static void bap_pac_update_chan_map(struct bt_bap_pac *pac, struct iov=
ec *data)
> > +{
> > +     uint8_t type =3D 0x03;
> > +
> > +     if (!data)
> > +             return;
> > +
> > +     util_ltv_foreach(data->iov_base, data->iov_len, &type,
> > +                             bap_pac_foreach_channel, pac);
> > +}
>
> Hmm, I though Supported_Audio_Channel_Counts (0x3) is not a channel
> mapping, but enumerates what number of channels each PAC supports?
>
> So e.g. 0x3 =3D supports 1 or 2 channels, and the PAC could be used to
> configure either case.
>
>
> IIUC in BAP v1.0.1 Sec. 4.4 the configuration is supposed to work like
> this:
>
> 1. From the bits set in PACS Sink/Source Locations, select which
> channels we are going to configure for sink and source directions.

Yep, it is still a wip which I thought it was a good idea to share, so
not all details have been sorted out.

> 2. Decide which channel goes to which ASE.

Actually the ASE and channels don't need to be in a specific order,
neither the ASE is location specific.

> 3. Supported_Audio_Channel_Counts in PACs limit how many channels we
> can put on a single ASE.

Yep, that indeed is the case, but there is also the 1:1 relationship
with Locations since in that case AC *(i) case where the Number of
Channels is set to 0x01 the ChannelAllocation is mandatory in order to
differentiate the Left and Right stream for example.

> 4. The outcome probably should prefer the standard stream
> configurations defined in BAP.

Yep, I'm also planning to implement the streaming test cases which
includes the AC configuration required, there are quite many though
but I hope this cover this well enough to fill where the BAP spec is
quite vague in my opinion.

> 5. For each ASE Config Codec, set the channel bits in
> Audio_Channel_Allocation to indicate which channels the ASE got.
>
> From the specification I don't quite see how the PACs play role
> otherwise in the channel allocation, but maybe I am missing something.
>
>
> I think there's a difficulty in how to split the work between BlueZ and
> the sound server here, e.g., if SelectProperties is called many times
> how can it set the audio channel allocation correctly.

Im playing with the idea of adding another field given to
SelectProperties called ChannelAllocation, which the endpoint can
choose to use or not, on bluetoothctl I have it detect its presence
and automatically add it to the configuration LTV, but I need to check
how that gonna play out with the qualification tests to see if that is
really the way forward, anyway I don't think solutions using AC *(i)
are that great in practice since the intention is to hide the number
of devices involved instead of just using something like a coordinate
set which are a lot simpler to setup since they actually have only one
Location bit set you don't even need to bother with Channel Allocation
at all.

>
> > +
> >  static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
> >                                       struct iovec *metadata)
> >  {
> > @@ -2426,6 +2454,9 @@ static void bap_pac_merge(struct bt_bap_pac *pac,=
 struct iovec *data,
> >       else
> >               pac->data =3D util_iov_dup(data, 1);
> >
> > +     /* Update channel map */
> > +     bap_pac_update_chan_map(pac, data);
> > +
> >       /* Merge metadata into existing record */
> >       if (pac->metadata)
> >               ltv_merge(pac->metadata, metadata);
> > @@ -2448,10 +2479,9 @@ static struct bt_bap_pac *bap_pac_new(struct bt_=
bap_db *bdb, const char *name,
> >       pac->type =3D type;
> >       if (codec)
> >               pac->codec =3D *codec;
> > -     if (data)
> > -             pac->data =3D util_iov_dup(data, 1);
> > -     if (metadata)
> > -             pac->metadata =3D util_iov_dup(metadata, 1);
> > +
> > +     bap_pac_merge(pac, data, metadata);
> > +
> >       if (qos)
> >               pac->qos =3D *qos;
> >
> > @@ -2465,6 +2495,7 @@ static void bap_pac_free(void *data)
> >       free(pac->name);
> >       util_iov_free(pac->metadata, 1);
> >       util_iov_free(pac->data, 1);
> > +     queue_destroy(pac->chan_map, NULL);
> >       free(pac);
> >  }
> >
> > @@ -4505,7 +4536,16 @@ static bool find_ep_pacs(const void *data, const=
 void *user_data)
> >       if (ep->stream->lpac !=3D match->lpac)
> >               return false;
> >
> > -     return ep->stream->rpac =3D=3D match->rpac;
> > +     if (ep->stream->rpac !=3D match->rpac)
> > +             return false;
> > +
> > +     switch (ep->state) {
> > +     case BT_BAP_STREAM_STATE_CONFIG:
> > +     case BT_BAP_STREAM_STATE_QOS:
> > +             return true;
> > +     }
> > +
> > +     return false;
> >  }
> >
> >  static struct bt_bap_req *bap_req_new(struct bt_bap_stream *stream,
> > @@ -4626,16 +4666,47 @@ static bool match_pac(struct bt_bap_pac *lpac, =
struct bt_bap_pac *rpac,
> >  }
> >
> >  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> > -                     bt_bap_pac_select_t func, void *user_data)
> > +                     int *count, bt_bap_pac_select_t func,
> > +                     void *user_data)
> >  {
> > +     const struct queue_entry *lchan, *rchan;
> > +
> >       if (!lpac || !rpac || !func)
> >               return -EINVAL;
> >
> >       if (!lpac->ops || !lpac->ops->select)
> >               return -EOPNOTSUPP;
> >
> > -     lpac->ops->select(lpac, rpac, &rpac->qos,
> > -                                     func, user_data, lpac->user_data)=
;
> > +     for (lchan =3D queue_get_entries(lpac->chan_map); lchan;
> > +                                     lchan =3D lchan->next) {
> > +             uint8_t lmap =3D PTR_TO_UINT(lchan->data);
> > +
> > +             for (rchan =3D queue_get_entries(rpac->chan_map); rchan;
> > +                                     rchan =3D rchan->next) {
> > +                     uint8_t rmap =3D PTR_TO_UINT(rchan->data);
> > +
> > +                     printf("lmap 0x%02x rmap 0x%02x\n", lmap, rmap);
> > +
> > +                     /* Try matching the channel mapping */
> > +                     if (lmap & rmap) {
> > +                             lpac->ops->select(lpac, rpac, &rpac->qos,
> > +                                                     func, user_data,
> > +                                                     lpac->user_data);
> > +                             if (count)
> > +                                     (*count)++;
> > +
> > +                             /* Check if there are any channels left *=
/
> > +                             lmap &=3D ~(lmap & rmap);
> > +                             if (!lmap)
> > +                                     break;
> > +
> > +                             /* Check if device require AC*(i) setting=
s */
> > +                             if (rmap =3D=3D 0x01)
> > +                                     lmap =3D lmap >> 1;
> > +                     } else
> > +                             break;
> > +             }
> > +     }
> >
> >       return 0;
> >  }
> > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > index 2c8f9208e6ba..470313e66fc0 100644
> > --- a/src/shared/bap.h
> > +++ b/src/shared/bap.h
> > @@ -234,7 +234,8 @@ void *bt_bap_pac_get_user_data(struct bt_bap_pac *p=
ac);
> >
> >  /* Stream related functions */
> >  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> > -                     bt_bap_pac_select_t func, void *user_data);
> > +                     int *count, bt_bap_pac_select_t func,
> > +                     void *user_data);
> >
> >  struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
> >                                       struct bt_bap_pac *lpac,
> > diff --git a/src/shared/util.c b/src/shared/util.c
> > index 34491f4e5a56..c0c2c4a17f12 100644
> > --- a/src/shared/util.c
> > +++ b/src/shared/util.c
> > @@ -175,6 +175,49 @@ ltv_debugger(const struct util_ltv_debugger *debug=
ger, size_t num, uint8_t type)
> >       return NULL;
> >  }
> >
> > +/* Helper to itertate over LTV entries */
> > +bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *type,
> > +                     util_ltv_func_t func, void *user_data)
> > +{
> > +     struct iovec iov;
> > +     int i;
> > +
> > +     if (!func)
> > +             return false;
> > +
> > +     iov.iov_base =3D (void *) data;
> > +     iov.iov_len =3D len;
> > +
> > +     for (i =3D 0; iov.iov_len; i++) {
> > +             uint8_t l, t, *v;
> > +
> > +             if (!util_iov_pull_u8(&iov, &l))
> > +                     return false;
> > +
> > +             if (!l) {
> > +                     func(i, l, 0, NULL, user_data);
> > +                     continue;
> > +             }
> > +
> > +             if (!util_iov_pull_u8(&iov, &t))
> > +                     return false;
> > +
> > +             l--;
> > +
> > +             if (l) {
> > +                     v =3D util_iov_pull_mem(&iov, l);
> > +                     if (!v)
> > +                             return false;
> > +             } else
> > +                     v =3D NULL;
> > +
> > +             if (!type || *type =3D=3D t)
> > +                     func(i, l, t, v, user_data);
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  /* Helper to print debug information of LTV entries */
> >  bool util_debug_ltv(const uint8_t *data, uint8_t len,
> >                       const struct util_ltv_debugger *debugger, size_t =
num,
> > diff --git a/src/shared/util.h b/src/shared/util.h
> > index 6698d00415de..596663b8519c 100644
> > --- a/src/shared/util.h
> > +++ b/src/shared/util.h
> > @@ -138,6 +138,12 @@ bool util_debug_ltv(const uint8_t *data, uint8_t l=
en,
> >                       const struct util_ltv_debugger *debugger, size_t =
num,
> >                       util_debug_func_t function, void *user_data);
> >
> > +typedef void (*util_ltv_func_t)(size_t i, uint8_t l, uint8_t t, uint8_=
t *v,
> > +                                     void *user_data);
> > +
> > +bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *type,
> > +                     util_ltv_func_t func, void *user_data);
> > +
> >  unsigned char util_get_dt(const char *parent, const char *name);
> >
> >  ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags);
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
