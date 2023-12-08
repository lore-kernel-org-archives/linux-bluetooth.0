Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF010E7
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 11:17:43 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 71974240028
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 20:17:40 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4Sn19v0kBYz9rxH;
	Fri,  8 Dec 2023 20:17:38 +0100 (CET)
Message-ID: <fdf1ae0df8028597ad9b4c8551b099a260effc81.camel@iki.fi>
Subject: Re: [PATCH BlueZ v1 2/2] shared/bap: Make bt_bap_select match the
 channel map
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 08 Dec 2023 19:17:37 +0000
In-Reply-To: <CABBYNZJ7T3sXr+o-+sTgu1bGXQD=KAjwdSf9VyoBC5y4GvRtLg@mail.gmail.com>
References: <20231206220325.3712902-1-luiz.dentz@gmail.com>
	 <20231206220325.3712902-2-luiz.dentz@gmail.com>
	 <ddfb204f3692f6a96e4ab0a72553fe9f6f224329.camel@iki.fi>
	 <CABBYNZJ7T3sXr+o-+sTgu1bGXQD=KAjwdSf9VyoBC5y4GvRtLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2023-12-07 kello 22:56 -0500, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Dec 7, 2023 at 1:00=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
> >=20
> > Hi Luiz,
> >=20
> > ke, 2023-12-06 kello 17:03 -0500, Luiz Augusto von Dentz kirjoitti:
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >=20
> > > bt_bap_pac may actually map to multiple PAC records and each may have=
 a
> > > different channel count that needs to be matched separately, for
> > > instance when trying with EarFun Air Pro:
> > >=20
> > > < ACL Data TX: Handle 2048 flags 0x00 dlen 85
> > >       ATT: Write Command (0x52) len 80
> > >         Handle: 0x0098 Type: ASE Control Point (0x2bc6)
> > >           Data: 010405020206000000000a0201030202010304280006020206000=
00
> > >         0000a0201030202010304280001020206000000000a020103020201030428
> > >         0002020206000000000a02010302020103042800
> > >             Opcode: Codec Configuration (0x01)
> > >             Number of ASE(s): 4
> > >             ASE: #0
> > >             ASE ID: 0x05
> > >             Target Latency: Balance Latency/Reliability (0x02)
> > >             PHY: 0x02
> > >             LE 2M PHY (0x02)
> > >             Codec: LC3 (0x06)
> > >             Codec Specific Configuration: #0: len 0x02 type 0x01
> > >               Sampling Frequency: 16 Khz (0x03)
> > >             Codec Specific Configuration: #1: len 0x02 type 0x02
> > >               Frame Duration: 10 ms (0x01)
> > >             Codec Specific Configuration: #2: len 0x03 type 0x04
> > >               Frame Length: 40 (0x0028)
> > >             ASE: #1
> > >             ASE ID: 0x06
> > >             Target Latency: Balance Latency/Reliability (0x02)
> > >             PHY: 0x02
> > >             LE 2M PHY (0x02)
> > >             Codec: LC3 (0x06)
> > >             Codec Specific Configuration: #0: len 0x02 type 0x01
> > >               Sampling Frequency: 16 Khz (0x03)
> > >             Codec Specific Configuration: #1: len 0x02 type 0x02
> > >               Frame Duration: 10 ms (0x01)
> > >             Codec Specific Configuration: #2: len 0x03 type 0x04
> > >               Frame Length: 40 (0x0028)
> > >             ASE: #2
> > >             ASE ID: 0x01
> > >             Target Latency: Balance Latency/Reliability (0x02)
> > >             PHY: 0x02
> > >             LE 2M PHY (0x02)
> > >             Codec: LC3 (0x06)
> > >             Codec Specific Configuration: #0: len 0x02 type 0x01
> > >               Sampling Frequency: 16 Khz (0x03)
> > >             Codec Specific Configuration: #1: len 0x02 type 0x02
> > >               Frame Duration: 10 ms (0x01)
> > >             Codec Specific Configuration: #2: len 0x03 type 0x04
> > >               Frame Length: 40 (0x0028)
> > >             ASE: #3
> > >             ASE ID: 0x02
> > >             Target Latency: Balance Latency/Reliability (0x02)
> > >             PHY: 0x02
> > >             LE 2M PHY (0x02)
> > >             Codec: LC3 (0x06)
> > >             Codec Specific Configuration: #0: len 0x02 type 0x01
> > >               Sampling Frequency: 16 Khz (0x03)
> > >             Codec Specific Configuration: #1: len 0x02 type 0x02
> > >               Frame Duration: 10 ms (0x01)
> > >             Codec Specific Configuration: #2: len 0x03 type 0x04
> > >               Frame Length: 40 (0x0028)
> > >=20
> > > Fixes: https://github.com/bluez/bluez/issues/612
> > > ---
> > >  profiles/audio/bap.c |  6 +--
> > >  src/shared/bap.c     | 87 ++++++++++++++++++++++++++++++++++++++++--=
--
> > >  src/shared/bap.h     |  3 +-
> > >  src/shared/util.c    | 43 ++++++++++++++++++++++
> > >  src/shared/util.h    |  6 +++
> > >  5 files changed, 132 insertions(+), 13 deletions(-)
> > >=20
> > > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> > > index 965d7efe6561..16c5faee45f9 100644
> > > --- a/profiles/audio/bap.c
> > > +++ b/profiles/audio/bap.c
> > > @@ -1290,10 +1290,8 @@ static bool pac_found(struct bt_bap_pac *lpac,=
 struct bt_bap_pac *rpac,
> > >       }
> > >=20
> > >       /* TODO: Cache LRU? */
> > > -     if (btd_service_is_initiator(service)) {
> > > -             if (!bt_bap_select(lpac, rpac, select_cb, ep))
> > > -                     ep->data->selecting++;
> > > -     }
> > > +     if (btd_service_is_initiator(service))
> > > +             bt_bap_select(lpac, rpac, &ep->data->selecting, select_=
cb, ep);
> > >=20
> > >       return true;
> > >  }
> > > diff --git a/src/shared/bap.c b/src/shared/bap.c
> > > index a1495ca84bcc..2450b53232e3 100644
> > > --- a/src/shared/bap.c
> > > +++ b/src/shared/bap.c
> > > @@ -185,6 +185,7 @@ struct bt_bap_pac {
> > >       struct bt_bap_pac_qos qos;
> > >       struct iovec *data;
> > >       struct iovec *metadata;
> > > +     struct queue *chan_map;
> > >       struct bt_bap_pac_ops *ops;
> > >       void *user_data;
> > >  };
> > > @@ -2417,6 +2418,33 @@ static void *ltv_merge(struct iovec *data, str=
uct iovec *cont)
> > >       return iov_append(data, cont->iov_len, cont->iov_base);
> > >  }
> > >=20
> > > +static void bap_pac_foreach_channel(size_t i, uint8_t l, uint8_t t, =
uint8_t *v,
> > > +                                     void *user_data)
> > > +{
> > > +     struct bt_bap_pac *pac =3D user_data;
> > > +
> > > +     if (!v)
> > > +             return;
> > > +
> > > +     if (!pac->chan_map)
> > > +             pac->chan_map =3D queue_new();
> > > +
> > > +     printf("PAC %p chan_map 0x%02x\n", pac, *v);
> > > +
> > > +     queue_push_tail(pac->chan_map, UINT_TO_PTR(*v));
> > > +}
> > > +
> > > +static void bap_pac_update_chan_map(struct bt_bap_pac *pac, struct i=
ovec *data)
> > > +{
> > > +     uint8_t type =3D 0x03;
> > > +
> > > +     if (!data)
> > > +             return;
> > > +
> > > +     util_ltv_foreach(data->iov_base, data->iov_len, &type,
> > > +                             bap_pac_foreach_channel, pac);
> > > +}
> >=20
> > Hmm, I though Supported_Audio_Channel_Counts (0x3) is not a channel
> > mapping, but enumerates what number of channels each PAC supports?
> >=20
> > So e.g. 0x3 =3D supports 1 or 2 channels, and the PAC could be used to
> > configure either case.
> >=20
> >=20
> > IIUC in BAP v1.0.1 Sec. 4.4 the configuration is supposed to work like
> > this:
> >=20
> > 1. From the bits set in PACS Sink/Source Locations, select which
> > channels we are going to configure for sink and source directions.
>=20
> Yep, it is still a wip which I thought it was a good idea to share, so
> not all details have been sorted out.

Right, I missed it's wip.

> > 2. Decide which channel goes to which ASE.
>=20
> Actually the ASE and channels don't need to be in a specific order,
> neither the ASE is location specific.
>=20
> > 3. Supported_Audio_Channel_Counts in PACs limit how many channels we
> > can put on a single ASE.
>=20
> Yep, that indeed is the case, but there is also the 1:1 relationship
> with Locations since in that case AC *(i) case where the Number of
> Channels is set to 0x01 the ChannelAllocation is mandatory in order to
> differentiate the Left and Right stream for example.
>=20
> > 4. The outcome probably should prefer the standard stream
> > configurations defined in BAP.
>=20
> Yep, I'm also planning to implement the streaming test cases which
> includes the AC configuration required, there are quite many though
> but I hope this cover this well enough to fill where the BAP spec is
> quite vague in my opinion.
>
> > 5. For each ASE Config Codec, set the channel bits in
> > Audio_Channel_Allocation to indicate which channels the ASE got.
> >=20
> > From the specification I don't quite see how the PACs play role
> > otherwise in the channel allocation, but maybe I am missing something.
> >=20
> >=20
> > I think there's a difficulty in how to split the work between BlueZ and
> > the sound server here, e.g., if SelectProperties is called many times
> > how can it set the audio channel allocation correctly.
>=20
> Im playing with the idea of adding another field given to
> SelectProperties called ChannelAllocation, which the endpoint can
> choose to use or not, on bluetoothctl I have it detect its presence
> and automatically add it to the configuration LTV, but I need to check
> how that gonna play out with the qualification tests to see if that is
> really the way forward, anyway I don't think solutions using AC *(i)
> are that great in practice since the intention is to hide the number
> of devices involved instead of just using something like a coordinate
> set which are a lot simpler to setup since they actually have only one
> Location bit set you don't even need to bother with Channel Allocation
> at all.

BlueZ could indeed decide the channel allocation for all ASE beforehand
itself, and then do one SelectProperties for each ASE that's going to
be configured, and in Locations (or ChannelAllocation) set only those
bits that were selected for that ASE.

The problem with this is that=C2=A0if there are multiple possible channel
selections (eg. device supports many locations, but in BAP standard
config we can only select two of them). It probably should be the sound
server to decide what to use on per-device basis, probably would need
some DBus API addition.

The good thing would be that the sound server wouldn't need to think
about the ASE configurations.

Not clear how the SetConfiguration() API of remote endpoints would work
here. Maybe it should take no input parameters at all, and would just
restart the SelectProperties dance, to make things simpler?


The other alternative could be to punt it all to the sound server, e.g.
include NumASE input in SelectProperties(), and have it return
configurations and QoS for multiple ASE.

>=20
> >=20
> > > +
> > >  static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data=
,
> > >                                       struct iovec *metadata)
> > >  {
> > > @@ -2426,6 +2454,9 @@ static void bap_pac_merge(struct bt_bap_pac *pa=
c, struct iovec *data,
> > >       else
> > >               pac->data =3D util_iov_dup(data, 1);
> > >=20
> > > +     /* Update channel map */
> > > +     bap_pac_update_chan_map(pac, data);
> > > +
> > >       /* Merge metadata into existing record */
> > >       if (pac->metadata)
> > >               ltv_merge(pac->metadata, metadata);
> > > @@ -2448,10 +2479,9 @@ static struct bt_bap_pac *bap_pac_new(struct b=
t_bap_db *bdb, const char *name,
> > >       pac->type =3D type;
> > >       if (codec)
> > >               pac->codec =3D *codec;
> > > -     if (data)
> > > -             pac->data =3D util_iov_dup(data, 1);
> > > -     if (metadata)
> > > -             pac->metadata =3D util_iov_dup(metadata, 1);
> > > +
> > > +     bap_pac_merge(pac, data, metadata);
> > > +
> > >       if (qos)
> > >               pac->qos =3D *qos;
> > >=20
> > > @@ -2465,6 +2495,7 @@ static void bap_pac_free(void *data)
> > >       free(pac->name);
> > >       util_iov_free(pac->metadata, 1);
> > >       util_iov_free(pac->data, 1);
> > > +     queue_destroy(pac->chan_map, NULL);
> > >       free(pac);
> > >  }
> > >=20
> > > @@ -4505,7 +4536,16 @@ static bool find_ep_pacs(const void *data, con=
st void *user_data)
> > >       if (ep->stream->lpac !=3D match->lpac)
> > >               return false;
> > >=20
> > > -     return ep->stream->rpac =3D=3D match->rpac;
> > > +     if (ep->stream->rpac !=3D match->rpac)
> > > +             return false;
> > > +
> > > +     switch (ep->state) {
> > > +     case BT_BAP_STREAM_STATE_CONFIG:
> > > +     case BT_BAP_STREAM_STATE_QOS:
> > > +             return true;
> > > +     }
> > > +
> > > +     return false;
> > >  }
> > >=20
> > >  static struct bt_bap_req *bap_req_new(struct bt_bap_stream *stream,
> > > @@ -4626,16 +4666,47 @@ static bool match_pac(struct bt_bap_pac *lpac=
, struct bt_bap_pac *rpac,
> > >  }
> > >=20
> > >  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> > > -                     bt_bap_pac_select_t func, void *user_data)
> > > +                     int *count, bt_bap_pac_select_t func,
> > > +                     void *user_data)
> > >  {
> > > +     const struct queue_entry *lchan, *rchan;
> > > +
> > >       if (!lpac || !rpac || !func)
> > >               return -EINVAL;
> > >=20
> > >       if (!lpac->ops || !lpac->ops->select)
> > >               return -EOPNOTSUPP;
> > >=20
> > > -     lpac->ops->select(lpac, rpac, &rpac->qos,
> > > -                                     func, user_data, lpac->user_dat=
a);
> > > +     for (lchan =3D queue_get_entries(lpac->chan_map); lchan;
> > > +                                     lchan =3D lchan->next) {
> > > +             uint8_t lmap =3D PTR_TO_UINT(lchan->data);
> > > +
> > > +             for (rchan =3D queue_get_entries(rpac->chan_map); rchan=
;
> > > +                                     rchan =3D rchan->next) {
> > > +                     uint8_t rmap =3D PTR_TO_UINT(rchan->data);
> > > +
> > > +                     printf("lmap 0x%02x rmap 0x%02x\n", lmap, rmap)=
;
> > > +
> > > +                     /* Try matching the channel mapping */
> > > +                     if (lmap & rmap) {
> > > +                             lpac->ops->select(lpac, rpac, &rpac->qo=
s,
> > > +                                                     func, user_data=
,
> > > +                                                     lpac->user_data=
);
> > > +                             if (count)
> > > +                                     (*count)++;
> > > +
> > > +                             /* Check if there are any channels left=
 */
> > > +                             lmap &=3D ~(lmap & rmap);
> > > +                             if (!lmap)
> > > +                                     break;
> > > +
> > > +                             /* Check if device require AC*(i) setti=
ngs */
> > > +                             if (rmap =3D=3D 0x01)
> > > +                                     lmap =3D lmap >> 1;
> > > +                     } else
> > > +                             break;
> > > +             }
> > > +     }
> > >=20
> > >       return 0;
> > >  }
> > > diff --git a/src/shared/bap.h b/src/shared/bap.h
> > > index 2c8f9208e6ba..470313e66fc0 100644
> > > --- a/src/shared/bap.h
> > > +++ b/src/shared/bap.h
> > > @@ -234,7 +234,8 @@ void *bt_bap_pac_get_user_data(struct bt_bap_pac =
*pac);
> > >=20
> > >  /* Stream related functions */
> > >  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> > > -                     bt_bap_pac_select_t func, void *user_data);
> > > +                     int *count, bt_bap_pac_select_t func,
> > > +                     void *user_data);
> > >=20
> > >  struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
> > >                                       struct bt_bap_pac *lpac,
> > > diff --git a/src/shared/util.c b/src/shared/util.c
> > > index 34491f4e5a56..c0c2c4a17f12 100644
> > > --- a/src/shared/util.c
> > > +++ b/src/shared/util.c
> > > @@ -175,6 +175,49 @@ ltv_debugger(const struct util_ltv_debugger *deb=
ugger, size_t num, uint8_t type)
> > >       return NULL;
> > >  }
> > >=20
> > > +/* Helper to itertate over LTV entries */
> > > +bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *typ=
e,
> > > +                     util_ltv_func_t func, void *user_data)
> > > +{
> > > +     struct iovec iov;
> > > +     int i;
> > > +
> > > +     if (!func)
> > > +             return false;
> > > +
> > > +     iov.iov_base =3D (void *) data;
> > > +     iov.iov_len =3D len;
> > > +
> > > +     for (i =3D 0; iov.iov_len; i++) {
> > > +             uint8_t l, t, *v;
> > > +
> > > +             if (!util_iov_pull_u8(&iov, &l))
> > > +                     return false;
> > > +
> > > +             if (!l) {
> > > +                     func(i, l, 0, NULL, user_data);
> > > +                     continue;
> > > +             }
> > > +
> > > +             if (!util_iov_pull_u8(&iov, &t))
> > > +                     return false;
> > > +
> > > +             l--;
> > > +
> > > +             if (l) {
> > > +                     v =3D util_iov_pull_mem(&iov, l);
> > > +                     if (!v)
> > > +                             return false;
> > > +             } else
> > > +                     v =3D NULL;
> > > +
> > > +             if (!type || *type =3D=3D t)
> > > +                     func(i, l, t, v, user_data);
> > > +     }
> > > +
> > > +     return true;
> > > +}
> > > +
> > >  /* Helper to print debug information of LTV entries */
> > >  bool util_debug_ltv(const uint8_t *data, uint8_t len,
> > >                       const struct util_ltv_debugger *debugger, size_=
t num,
> > > diff --git a/src/shared/util.h b/src/shared/util.h
> > > index 6698d00415de..596663b8519c 100644
> > > --- a/src/shared/util.h
> > > +++ b/src/shared/util.h
> > > @@ -138,6 +138,12 @@ bool util_debug_ltv(const uint8_t *data, uint8_t=
 len,
> > >                       const struct util_ltv_debugger *debugger, size_=
t num,
> > >                       util_debug_func_t function, void *user_data);
> > >=20
> > > +typedef void (*util_ltv_func_t)(size_t i, uint8_t l, uint8_t t, uint=
8_t *v,
> > > +                                     void *user_data);
> > > +
> > > +bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *typ=
e,
> > > +                     util_ltv_func_t func, void *user_data);
> > > +
> > >  unsigned char util_get_dt(const char *parent, const char *name);
> > >=20
> > >  ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags)=
;
> >=20
> > --
> > Pauli Virtanen
>=20
>=20
>=20

