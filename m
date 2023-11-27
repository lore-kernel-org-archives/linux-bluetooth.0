Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ACj7Ym"
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227B64231
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 06:32:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c88750e7d1so51816871fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701095575; x=1701700375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VI+Y6sYlx/gHN5sBMb+YMVrW06HbN7IUVUPH4JfST3c=;
        b=S5ACj7YmgxnhxyHawQyc+LP6Z16txyfwp1qgzfvxeS50isf8OvzNHjgKTTXbTfCsLX
         cPWKqHHrIOR5O/G5EA9H8xpyYmA/pkzbgJmrWrYLSea0RCCiKyKUU+wKAtgp0vHs0m6D
         IyPJ87yrtiWh9kkb8mIRVR3fQfya3JgY9cpRFmr2hWbhVNF0gmgrq9MgTstoOqKrJf7d
         OC1+F0mrFfGY1Ta+30R7Mma7J4NCP/1wkA/SVKrvddM5LkxSnmcqPd6f3kh7qdolsjLJ
         4nULAahX5ngU86t0TrIJdcj+6qsIhUlbzL5TYoRytPG7FM75iGYrT7zezx3X/TcCyD7h
         U+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095575; x=1701700375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VI+Y6sYlx/gHN5sBMb+YMVrW06HbN7IUVUPH4JfST3c=;
        b=S/XnvFjAokaH0V4td9faPXrYq7Pi2qhz9OVNPmQ+AuwnFXLBjtoc9aDqoUYhyO7mJ+
         cq7VbEKBcgIgu8ChZ5xQPWxWkC6QzU6uB7Sp5Y97wL6WU7Fu/oSm/LvW0xP/6mi7ehBm
         5tGVvOtyanM8hhSX2aR/f9wVEFCmpuc3bnAP0j/ZQzDX99htVHXe4l+VhiXvAwm2w3nB
         tEmd6W4TKPBH97yAbp7QwxGVo77hSBDNXLZjln8xUAsl3g1LXf6XQtWv0o0xtxoBJWgA
         +qxtjV/o924VhzrfzY8iVNsegCXh4ODoVFmSEpR/VATm+b1kkb87L+V9YuRQ7/kfMmHl
         ZFGw==
X-Gm-Message-State: AOJu0YxhrVSLSBORvO8fFbAIg2M5ke1NEtepA2rnEXyWuLL68T9zdRPo
	FrqrGo2/dX95S1S2HSp8HG3jdnDs6WkenWgjFys=
X-Google-Smtp-Source: AGHT+IFEQtngbkQmSwNwmHEr1XYbE2NGngkHBWiKCFDm9RXTWg2JeYHgj4Y6UxLlEIQurnEcKyBrTG2Ot03wF20ga4U=
X-Received: by 2002:a2e:9e0a:0:b0:2c5:98b:8bdb with SMTP id
 e10-20020a2e9e0a000000b002c5098b8bdbmr7169141ljk.49.1701095574442; Mon, 27
 Nov 2023 06:32:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231123215935.73501-1-silviu.barbulescu@nxp.com> <20231123215935.73501-4-silviu.barbulescu@nxp.com>
In-Reply-To: <20231123215935.73501-4-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Nov 2023 09:32:41 -0500
Message-ID: <CABBYNZKm1eyinhbww0vOneVYo8Xe3wN6R2henzxBUWUR1S=gTg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v6 3/5] Add support for multiple BISes
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com, 
	andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Thu, Nov 23, 2023 at 5:00=E2=80=AFPM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Add support for bcast multiple BISes
>
> ---
>  profiles/audio/bap.c | 581 +++++++++++++++++++++++++++++++------------
>  src/shared/bap.c     | 223 ++++++++++++++---
>  src/shared/bap.h     |  35 ++-
>  unit/test-bap.c      |  12 +-
>  4 files changed, 643 insertions(+), 208 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index c279b5b0e..14efa97d8 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -97,6 +97,35 @@ struct bap_data {
>         void *user_data;
>  };
>
> +#define DEFAULT_IO_QOS \
> +{ \
> +       .interval       =3D 10000, \
> +       .latency        =3D 10, \
> +       .sdu            =3D 40, \
> +       .phy            =3D 0x02, \
> +       .rtn            =3D 2, \
> +}
> +
> +static struct bt_iso_qos default_qos =3D {
> +       .bcast =3D {
> +               .big                    =3D BT_ISO_QOS_BIG_UNSET,
> +               .bis                    =3D BT_ISO_QOS_BIS_UNSET,
> +               .sync_factor    =3D 0x07,
> +               .packing                =3D 0x00,
> +               .framing                =3D 0x00,
> +               .in                     =3D DEFAULT_IO_QOS,
> +               .out                    =3D DEFAULT_IO_QOS,
> +               .encryption             =3D 0x00,
> +               .bcode                  =3D {0x00},
> +               .options                =3D 0x00,
> +               .skip                   =3D 0x0000,
> +               .sync_timeout           =3D 0x4000,
> +               .sync_cte_type          =3D 0x00,
> +               .mse                    =3D 0x00,
> +               .timeout                =3D 0x4000,
> +       }
> +};
> +
>  static struct queue *sessions;
>
>  static bool bap_data_set_user_data(struct bap_data *data, void *user_dat=
a)
> @@ -254,7 +283,11 @@ static gboolean get_device(const GDBusPropertyTable =
*property,
>         const char *path;
>
>         if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SOURCE)
> -               path =3D adapter_get_path(ep->data->adapter);
> +               /*
> +                *Use remote endpoint path as fake device path
> +                *for the remote broadcast source endpoint
> +                */
> +               path =3D ep->path;

Actually we should omit the Device property if that doesn't really exist.

>         else
>                 path =3D device_get_path(ep->data->device);
>
> @@ -379,101 +412,203 @@ static int parse_array(DBusMessageIter *iter, str=
uct iovec *iov)
>         return 0;
>  }
>
> -static bool parse_base(void *data, size_t len, util_debug_func_t func,
> -               uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numB=
is,
> -               struct bt_bap_codec *codec, struct iovec **caps,
> -               struct iovec **meta)
> +static void cleanup_subgroup(struct bt_bap_base_subgroup *subGroup)
> +{
> +       if (!subGroup)
> +               return;
> +
> +       if (subGroup->meta)
> +               util_iov_free(subGroup->meta, 1);
> +
> +       if (subGroup->caps)
> +               util_iov_free(subGroup->caps, 1);
> +
> +       while (!queue_isempty(subGroup->bises)) {
> +               struct bt_bap_bis *bis =3D queue_peek_head(subGroup->bise=
s);
> +
> +               if (bis->caps)
> +                       util_iov_free(bis->caps, 1);
> +               queue_remove(subGroup->bises, bis);
> +               subGroup->numBises--;
> +       }
> +       queue_destroy(subGroup->bises, NULL);
> +
> +       if (subGroup)
> +               free(subGroup);

We don't really use camel casing for variables, so let's please use
subgroup or subgrp for shorter.

> +}
> +
> +static bool parse_base(struct bt_bap *bap, void *data, size_t len,
> +               util_debug_func_t func, struct bt_bap_base *base)
>  {
> +       uint8_t numSubgroups;
> +       uint8_t numBis;

Ditto.

>         struct iovec iov =3D {
>                 .iov_base =3D data,
>                 .iov_len =3D len,
>         };
> +       util_debug(func, NULL, "BASE len %ld", len);
> +       if (!base)
> +               return false;
>
> -       uint8_t capsLen, metaLen;
> -       uint8_t *hexstream;
> +       if (!util_iov_pull_le24(&iov, &base->presDelay))
> +               return false;
> +       util_debug(func, NULL, "PresentationDelay %d", base->presDelay);
>
> -       if (presDelay) {
> -               if (!util_iov_pull_le24(&iov, presDelay))
> -                       return false;
> -               util_debug(func, NULL, "PresentationDelay %d", *presDelay=
);
> -       }
> +       if (!util_iov_pull_u8(&iov, &base->numSubgroups))
> +               return false;
> +       util_debug(func, NULL, "NumSubgroups %d", base->numSubgroups);
> +       numSubgroups =3D base->numSubgroups;
>
> -       if (numSubgroups) {
> -               if (!util_iov_pull_u8(&iov, numSubgroups))
> -                       return false;
> -               util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
> -       }
> +       for (int sg =3D 0; sg < numSubgroups; sg++) {
> +               struct bt_bap_base_subgroup *subGroup =3D new0(
> +                                               struct bt_bap_base_subgro=
up, 1);
> +               uint8_t capsLen, metaLen;
> +               uint8_t *hexstream;
>
> -       if (numBis) {
> -               if (!util_iov_pull_u8(&iov, numBis))
> -                       return false;
> -               util_debug(func, NULL, "NumBis %d", *numBis);
> -       }
> +               subGroup->subGroupIndex =3D sg;
>
> -       if (codec) {
> -               codec =3D util_iov_pull_mem(&iov, sizeof(*codec));
> -               if (!codec)
> -                       return false;
> +               util_debug(func, NULL, "Subgroup #%d", sg);
> +               subGroup->bap =3D bap;
> +               subGroup->bises =3D queue_new();
> +
> +               if (!util_iov_pull_u8(&iov, &numBis)) {
> +                       cleanup_subgroup(subGroup);
> +                       goto fail;
> +               }
> +               util_debug(func, NULL, "NumBis %d", numBis);
> +               subGroup->numBises =3D numBis;
> +
> +               memcpy(&subGroup->codec, util_iov_pull_mem(&iov,
> +               sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec)=
);
>                 util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x=
",
> -                               "Codec", codec->id, codec->cid, codec->vi=
d);
> -       }
> +                       "Codec", subGroup->codec.id, subGroup->codec.cid,
> +                               subGroup->codec.vid);
> +               if (!util_iov_pull_u8(&iov, &capsLen)) {
> +                       cleanup_subgroup(subGroup);
> +                       goto fail;
> +               }
>
> -       if (!util_iov_pull_u8(&iov, &capsLen))
> -               return false;
> -       util_debug(func, NULL, "CC Len %d", capsLen);
> +               util_debug(func, NULL, "CC Len %d", capsLen);
>
> -       if (!capsLen)
> -               return false;
> -       if (caps) {
> -               if (!(*caps))
> -                       *caps =3D new0(struct iovec, 1);
> -               (*caps)->iov_len =3D capsLen;
> -               (*caps)->iov_base =3D iov.iov_base;
> -       }
> +               subGroup->caps =3D new0(struct iovec, 1);
> +               util_iov_memcpy(subGroup->caps, iov.iov_base, capsLen);

util_iov_dup is probably more efficient so you don't have to do new0, etc.

> +               DBG("subgroup caps len %ld", subGroup->caps->iov_len);
>
> -       for (int i =3D 0; capsLen > 1; i++) {
> -               struct bt_ltv *ltv =3D util_iov_pull_mem(&iov, sizeof(*lt=
v));
> -               uint8_t *caps;
> +               for (int i =3D 0; capsLen > 1; i++) {
> +                       struct bt_ltv *ltv =3D util_iov_pull_mem(&iov,
> +                                                               sizeof(*l=
tv));
> +                       uint8_t *caps;
>
> -               if (!ltv) {
> -                       util_debug(func, NULL, "Unable to parse %s",
> -                                                               "Capabili=
ties");
> -                       return false;
> +                       if (!ltv) {
> +                               util_debug(func, NULL, "Unable to parse %=
s",
> +                                                       "Capabilities");
> +                               cleanup_subgroup(subGroup);
> +                               goto fail;
> +                       }
> +
> +                       util_debug(func, NULL, "%s #%u: len %u type %u",
> +                                               "CC", i, ltv->len, ltv->t=
ype);
> +
> +                       caps =3D util_iov_pull_mem(&iov, ltv->len - 1);
> +                       if (!caps) {
> +                               util_debug(func, NULL, "Unable to parse %=
s",
> +                                                                       "=
CC");
> +                               cleanup_subgroup(subGroup);
> +                               goto fail;
> +                       }
> +                       util_hexdump(' ', caps, ltv->len - 1, func, NULL)=
;
> +
> +                       capsLen -=3D (ltv->len + 1);
>                 }
>
> -               util_debug(func, NULL, "%s #%u: len %u type %u",
> -                                       "CC", i, ltv->len, ltv->type);
> +               if (!util_iov_pull_u8(&iov, &metaLen)) {
> +                       cleanup_subgroup(subGroup);
> +                       goto fail;
> +               }
> +               util_debug(func, NULL, "Metadata Len %d", metaLen);
>
> -               caps =3D util_iov_pull_mem(&iov, ltv->len - 1);
> -               if (!caps) {
> -                       util_debug(func, NULL, "Unable to parse %s",
> -                                                               "CC");
> -                       return false;
> +               subGroup->meta =3D new0(struct iovec, 1);
> +               subGroup->meta->iov_len =3D metaLen;
> +               subGroup->meta->iov_base =3D iov.iov_base;
> +
> +               hexstream =3D util_iov_pull_mem(&iov, metaLen);
> +               if (!hexstream) {
> +                       cleanup_subgroup(subGroup);
> +                       goto fail;
>                 }
> -               util_hexdump(' ', caps, ltv->len - 1, func, NULL);
> +               util_hexdump(' ', hexstream, metaLen, func, NULL);
>
> -               capsLen -=3D (ltv->len + 1);
> -       }
> +               for (int bis_sg =3D 0; bis_sg < subGroup->numBises; bis_s=
g++) {
> +                       struct bt_bap_bis *bis;
> +                       uint8_t capsLen;
> +                       uint8_t crtBis;
>
> -       if (!util_iov_pull_u8(&iov, &metaLen))
> -               return false;
> -       util_debug(func, NULL, "Metadata Len %d", metaLen);
> +                       if (!util_iov_pull_u8(&iov, &crtBis)) {
> +                               cleanup_subgroup(subGroup);
> +                               goto fail;
> +                       }
> +                       util_debug(func, NULL, "BIS #%d", crtBis);
>
> -       if (!metaLen)
> -               return false;
> -       if (meta) {
> -               if (!(*meta))
> -                       *meta =3D new0(struct iovec, 1);
> -               (*meta)->iov_len =3D metaLen;
> -               (*meta)->iov_base =3D iov.iov_base;
> -       }
> +                       bis =3D new0(struct bt_bap_bis, 1);
> +                       bis->bisIndex =3D crtBis;
>
> -       hexstream =3D util_iov_pull_mem(&iov, metaLen);
> -       if (!hexstream)
> -               return false;
> -       util_hexdump(' ', hexstream, metaLen, func, NULL);
> +                       if (!util_iov_pull_u8(&iov, &capsLen)) {
> +                               cleanup_subgroup(subGroup);
> +                               goto fail;
> +                       }
> +                       util_debug(func, NULL, "CC Len %d", capsLen);
> +
> +                       bis->caps =3D new0(struct iovec, 1);
> +                       bis->caps->iov_len =3D capsLen;
> +                       util_iov_memcpy(bis->caps, iov.iov_base, capsLen)=
;
> +                       DBG("bis caps len %ld", bis->caps->iov_len);
> +
> +                       for (int i =3D 0; capsLen > 1; i++) {
> +                               struct bt_ltv *ltv =3D util_iov_pull_mem(=
&iov,
> +                                                               sizeof(*l=
tv));
> +                               uint8_t *caps;
> +
> +                               if (!ltv) {
> +                                       util_debug(func, NULL, "Unable to=
 parse %s",
> +                                                               "Capabili=
ties");
> +                                       cleanup_subgroup(subGroup);
> +                                       goto fail;
> +                               }
> +
> +                               util_debug(func, NULL, "%s #%u: len %u ty=
pe %u",
> +                                               "CC", i, ltv->len, ltv->t=
ype);
> +
> +                               caps =3D util_iov_pull_mem(&iov, ltv->len=
 - 1);
> +                               if (!caps) {
> +                                       util_debug(func, NULL,
> +                                               "Unable to parse %s", "CC=
");
> +                                       cleanup_subgroup(subGroup);
> +                                       goto fail;
> +                               }
> +                               util_hexdump(' ', caps, ltv->len - 1, fun=
c,
> +                                                                       N=
ULL);
> +
> +                               capsLen -=3D (ltv->len + 1);
> +                       }
> +
> +                       queue_push_tail(subGroup->bises, bis);
> +               }
>
> +               queue_push_tail(base->subgroups, subGroup);
> +       }
>         return true;
> +
> +fail:
> +               while (!queue_isempty(base->subgroups)) {
> +                       struct bt_bap_base_subgroup *subGroup =3D
> +                                       queue_peek_head(base->subgroups);
> +                       cleanup_subgroup(subGroup);
> +                       base->numSubgroups--;
> +               }
> +               util_debug(func, NULL, "Unable to parse %s", "Base");
> +
> +               return false;
>  }
>
>  static int parse_io_qos(const char *key, int var, DBusMessageIter *iter,
> @@ -556,6 +691,16 @@ static int parse_bcast_qos(const char *key, int var,=
 DBusMessageIter *iter,
>                         return -EINVAL;
>
>                 dbus_message_iter_get_basic(iter, &qos->bcast.encryption)=
;
> +       } else if (!strcasecmp(key, "BIG")) {
> +               if (var !=3D DBUS_TYPE_BYTE)
> +                       return -EINVAL;
> +
> +               dbus_message_iter_get_basic(iter, &qos->bcast.big);
> +       }  else if (!strcasecmp(key, "BIS")) {
> +               if (var !=3D DBUS_TYPE_BYTE)
> +                       return -EINVAL;
> +
> +               dbus_message_iter_get_basic(iter, &qos->bcast.bis);
>         } else if (!strcasecmp(key, "Options")) {
>                 if (var !=3D DBUS_TYPE_BYTE)
>                         return -EINVAL;
> @@ -653,10 +798,12 @@ static int parse_qos(DBusMessageIter *iter, struct =
bt_bap_qos *qos,
>
>  static int parse_configuration(DBusMessageIter *props, struct iovec **ca=
ps,
>                                 struct iovec **metadata, struct iovec **b=
ase,
> -                               struct bt_bap_qos *qos)
> +                               struct bt_bap_qos *qos,
> +                               struct bt_bap_base *base_s)
>  {
>         const char *key;
>         struct iovec iov;
> +       base_s->subgroups =3D NULL;
>
>         memset(&iov, 0, sizeof(iov));
>
> @@ -702,14 +849,10 @@ static int parse_configuration(DBusMessageIter *pro=
ps, struct iovec **caps,
>         }
>
>         if (*base) {
> -               uint32_t presDelay;
> -               uint8_t numSubgroups, numBis;
> -               struct bt_bap_codec codec;
> -
>                 util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_le=
n);
> -               parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug=
,
> -                       &presDelay, &numSubgroups, &numBis, &codec,
> -                       caps, NULL);
> +               base_s->subgroups =3D queue_new();
> +               parse_base(NULL, (*caps)->iov_base, (*caps)->iov_len,
> +                                                       bap_debug, base_s=
);
>         }
>
>         return 0;
> @@ -796,12 +939,53 @@ static void bap_io_close(struct bap_ep *ep)
>         ep->cig_active =3D false;
>  }
>
> +static bool match_bis_by_id(const void *data, const void *user_data)
> +{
> +       int32_t bis_id =3D PTR_TO_INT(user_data);
> +       const struct bt_bap_bis *bis =3D data;
> +
> +       return bis->bisIndex =3D=3D bis_id;
> +}
> +
> +static int get_number_bises_in_base(struct queue *subgroups)
> +{
> +       const struct queue_entry *entry;
> +       struct bt_bap_base_subgroup *subgroup;
> +       int nr_bis =3D 0;
> +
> +       for (entry =3D queue_get_entries(subgroups); entry;
> +                                               entry =3D entry->next) {
> +               subgroup =3D entry->data;
> +               nr_bis +=3D subgroup->numBises;
> +       }
> +
> +       return nr_bis;
> +}
> +
> +static int get_number_bcast_source_ep(struct bap_ep *ep)
> +{
> +       const struct queue_entry *entry;
> +       struct bap_ep *current_ep;
> +       int nr_ep =3D 0;
> +
> +       for (entry =3D queue_get_entries(ep->data->bcast); entry;
> +                                               entry =3D entry->next) {
> +               current_ep =3D entry->data;
> +               if (bt_bap_pac_get_type(current_ep->lpac) =3D=3D
> +                                               BT_BAP_BCAST_SOURCE)
> +                       nr_ep++;
> +       }
> +
> +       return nr_ep;
> +}
> +
>  static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage =
*msg,
>                                                                 void *dat=
a)
>  {
>         struct bap_ep *ep =3D data;
>         const char *path;
>         DBusMessageIter args, props;
> +       struct bt_bap_base parse_bap_base;
>
>         if (ep->msg)
>                 return btd_error_busy(msg);
> @@ -832,11 +1016,57 @@ static DBusMessage *set_configuration(DBusConnecti=
on *conn, DBusMessage *msg,
>         }
>
>         if (parse_configuration(&props, &ep->caps, &ep->metadata,
> -                               &ep->base, &ep->qos) < 0) {
> +                               &ep->base, &ep->qos, &parse_bap_base) < 0=
) {
>                 DBG("Unable to parse configuration");
>                 return btd_error_invalid_args(msg);
>         }
>
> +       if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SOURCE) {
> +               unsigned int nr_ep =3D 1;
> +               unsigned int nr_bises;
> +               const struct queue_entry *entry;
> +               struct bt_bap_bis *curent_bis =3D NULL;
> +               struct bt_bap_base_subgroup *subgroup;
> +
> +               for (entry =3D queue_get_entries(parse_bap_base.subgroups=
);
> +                               entry; entry =3D entry->next) {
> +                       subgroup =3D entry->data;
> +                       curent_bis =3D queue_find(subgroup->bises,
> +                                       match_bis_by_id,
> +                                       INT_TO_PTR(ep->qos.bcast.bis));
> +                       if (curent_bis !=3D NULL)
> +                               break;
> +               }
> +
> +               if (curent_bis =3D=3D NULL) {
> +                       DBG("Unable to find BIS");
> +                       return btd_error_invalid_args(msg);
> +               }
> +               util_iov_free(ep->caps, 1);
> +               ep->caps =3D new0(struct iovec, 1);
> +               bt_bap_ltv_merge(ep->caps, subgroup->caps, false);
> +               bt_bap_ltv_merge(ep->caps, curent_bis->caps, false);
> +
> +               nr_ep =3D get_number_bcast_source_ep(ep);
> +               nr_bises =3D get_number_bises_in_base(parse_bap_base.subg=
roups);
> +               if (nr_ep < nr_bises) {
> +                       for (uint8_t i =3D 0; i < nr_bises-1; i++)
> +                               bt_bap_add_vendor_pac_from_pac(ep->lpac);
> +               }
> +       } else if ((bt_bap_pac_get_type(ep->rpac) =3D=3D BT_BAP_BCAST_SOU=
RCE) &&
> +                       (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAS=
T_SINK)) {
> +               util_iov_free(ep->caps, 1);
> +               ep->caps =3D new0(struct iovec, 1);
> +               bt_bap_ltv_merge(ep->caps, bt_bap_pac_get_data(ep->rpac),
> +                                                                       f=
alse);
> +       }
> +       /*
> +        * Kernel uses bis id as advertising handler. To open all BISes f=
rom
> +        * a big on the same advertisng handler set the bis
> +        * to BT_ISO_QOS_BIS_UNSET
> +        */
> +       ep->qos.bcast.bis =3D BT_ISO_QOS_BIS_UNSET;
> +
>         /* TODO: Check if stream capabilities match add support for Laten=
cy
>          * and PHY.
>          */
> @@ -848,7 +1078,7 @@ static DBusMessage *set_configuration(DBusConnection=
 *conn, DBusMessage *msg,
>                                                 config_cb, ep);
>         if (!ep->id) {
>                 DBG("Unable to config stream");
> -               free(ep->caps);
> +               util_iov_free(ep->caps, 1);
>                 ep->caps =3D NULL;
>                 return btd_error_invalid_args(msg);
>         }
> @@ -901,31 +1131,16 @@ static void update_bcast_qos(struct bt_iso_qos *qo=
s,
>                 sizeof(qos->bcast.bcode));
>  }
>
> -static bool match_ep_type(const void *data, const void *user_data)
> -{
> -       const struct bap_ep *ep =3D data;
> -
> -       return (bt_bap_pac_get_type(ep->lpac) =3D=3D PTR_TO_INT(user_data=
));
> -}
> -
>  static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user=
_data)
>  {
> -       struct bap_data *data =3D user_data;
> +       struct bap_ep *ep =3D user_data;
>         struct bt_iso_qos qos;
> -       struct bt_iso_base base;
>         char address[18];
> -       struct bap_ep *ep;
>         int fd;
> -       struct iovec *base_io;
> -       uint32_t presDelay;
> -       uint8_t numSubgroups;
> -       uint8_t numBis;
> -       struct bt_bap_codec codec;
>
>         bt_io_get(io, &err,
>                         BT_IO_OPT_DEST, address,
>                         BT_IO_OPT_QOS, &qos,
> -                       BT_IO_OPT_BASE, &base,
>                         BT_IO_OPT_INVALID);
>         if (err) {
>                 error("%s", err->message);
> @@ -934,29 +1149,15 @@ static void iso_bcast_confirm_cb(GIOChannel *io, G=
Error *err, void *user_data)
>         }
>
>         g_io_channel_ref(io);
> -       btd_service_connecting_complete(data->service, 0);
> +       btd_service_connecting_complete(ep->data->service, 0);
>         DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
>                                         address, qos.bcast.big, qos.bcast=
.bis);
>
> -       ep =3D queue_find(data->bcast, match_ep_type,
> -                       INT_TO_PTR(BT_BAP_BCAST_SINK));
> -       if (!ep)
> -               return;
> -
>         update_bcast_qos(&qos, &ep->qos);
>
> -       base_io =3D new0(struct iovec, 1);
> -       util_iov_memcpy(base_io, base.base, base.base_len);
> -
> -       parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
> -                       &presDelay, &numSubgroups, &numBis,
> -                       &codec, &ep->caps, &ep->metadata);
> -
> -       /* Update pac with BASE information */
> -       bt_bap_update_bcast_source(ep->rpac, &codec, ep->caps, ep->metada=
ta);
>         ep->id =3D bt_bap_stream_config(ep->stream, &ep->qos,
>                                         ep->caps, NULL, NULL);
> -       data->listen_io =3D io;
> +       ep->data->listen_io =3D io;
>
>         bt_bap_stream_set_user_data(ep->stream, ep->path);
>
> @@ -968,25 +1169,39 @@ static void iso_bcast_confirm_cb(GIOChannel *io, G=
Error *err, void *user_data)
>                 return;
>         }
>
> -
>         return;
>
>  drop:
>         g_io_channel_shutdown(io, TRUE, NULL);
> -
>  }
>
>  static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
>  {
>         GError *err =3D NULL;
> +       struct bt_iso_base base;
> +       char address[18];
> +       struct bt_bap_base base_s;
> +       struct bap_data *data =3D user_data;
> +       struct bt_iso_qos qos;
>
> -       if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
> -                               user_data, NULL, &err, BT_IO_OPT_INVALID)=
) {
> -               error("bt_io_bcast_accept: %s", err->message);
> +       bt_io_get(io, &err,
> +                       BT_IO_OPT_DEST, address,
> +                       BT_IO_OPT_QOS, &qos,
> +                       BT_IO_OPT_BASE, &base,
> +                       BT_IO_OPT_INVALID);
> +       if (err) {
> +               error("%s", err->message);
>                 g_error_free(err);
> -               g_io_channel_shutdown(io, TRUE, NULL);
> +               return;
>         }
> +       g_io_channel_ref(io);
> +       data->listen_io =3D io;
> +       btd_service_connecting_complete(data->service, 0);
>
> +       base_s.subgroups =3D queue_new();
> +       parse_base(data->bap, base.base, base.base_len, bap_debug, &base_=
s);
> +
> +       bt_bap_update_bcast_source(NULL, &base_s);
>  }
>
>  static bool match_data_bap_data(const void *data, const void *match_data=
)
> @@ -1082,6 +1297,7 @@ static struct bap_ep *ep_register_bcast(struct bap_=
data *data,
>         case BT_BAP_BCAST_SINK:
>                 err =3D asprintf(&ep->path, "%s/pac_%s%d",
>                                 device_get_path(device), suffix, i);
> +               ep->io =3D data->listen_io;
>                 ep->base =3D new0(struct iovec, 1);
>                 break;
>         }
> @@ -1587,9 +1803,12 @@ static gboolean bap_io_disconnected(GIOChannel *io=
, GIOCondition cond,
>
>         bap_io_close(ep);
>
> -       /* Check if connecting recreate IO */
> -       if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
> -               recreate_cig(ep);
> +       if (bt_bap_stream_get_type(ep->stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_UCAST) {
> +               /* Check if connecting recreate IO */
> +               if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
> +                       recreate_cig(ep);
> +       }
>
>         return FALSE;
>  }
> @@ -1680,7 +1899,7 @@ static void bap_connect_io(struct bap_data *data, s=
truct bap_ep *ep,
>
>  static void bap_connect_io_broadcast(struct bap_data *data, struct bap_e=
p *ep,
>                                 struct bt_bap_stream *stream,
> -                               struct bt_iso_qos *qos)
> +                               struct bt_iso_qos *qos, int defer)
>  {
>         struct btd_adapter *adapter =3D data->user_data;
>         GIOChannel *io =3D NULL;
> @@ -1716,7 +1935,7 @@ static void bap_connect_io_broadcast(struct bap_dat=
a *data, struct bap_ep *ep,
>                         BT_IO_OPT_MODE, BT_IO_MODE_ISO,
>                         BT_IO_OPT_QOS, qos,
>                         BT_IO_OPT_BASE, &base,
> -                       BT_IO_OPT_DEFER_TIMEOUT, false,
> +                       BT_IO_OPT_DEFER_TIMEOUT, defer,
>                         BT_IO_OPT_INVALID);
>
>         if (!io) {
> @@ -1768,42 +1987,28 @@ static void bap_listen_io(struct bap_data *data, =
struct bt_bap_stream *stream,
>  static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep=
 *ep,
>                         struct bt_bap_stream *stream, struct bt_iso_qos *=
qos)
>  {
> -       GIOChannel *io;
>         GError *err =3D NULL;
>         struct sockaddr_iso_bc iso_bc_addr;
>
>         iso_bc_addr.bc_bdaddr_type =3D btd_device_get_bdaddr_type(data->d=
evice);
>         memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
>                         sizeof(bdaddr_t));
> -       iso_bc_addr.bc_bis[0] =3D 1;
>         iso_bc_addr.bc_num_bis =3D 1;
> +       iso_bc_addr.bc_bis[0] =3D strtol(bt_bap_pac_get_name(ep->rpac), N=
ULL, 10);
>
>         DBG("stream %p", stream);
>
> -       /* If IO already set skip creating it again */
> -       if (bt_bap_stream_get_io(stream) || data->listen_io)
> -               return;
> -
> -       io =3D bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL,=
 &err,
> -                       BT_IO_OPT_SOURCE_BDADDR,
> -                       btd_adapter_get_address(ep->data->adapter),
> -                       BT_IO_OPT_DEST_BDADDR,
> -                       device_get_address(data->device),
> -                       BT_IO_OPT_DEST_TYPE,
> -                       btd_device_get_bdaddr_type(data->device),
> -                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> -                       BT_IO_OPT_QOS, &qos->bcast,
> -                       BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
> -                       BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
> -                       BT_IO_OPT_INVALID);
> -       if (!io) {
> -               error("%s", err->message);
> +       if (!bt_io_bcast_accept(ep->data->listen_io, iso_bcast_confirm_cb=
,
> +                               ep, NULL, &err,
> +                               BT_IO_OPT_ISO_BC_NUM_BIS,
> +                               iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_=
BIS,
> +                               iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
> +               error("bt_io_bcast_accept: %s", err->message);
>                 g_error_free(err);
> +               g_io_channel_shutdown(ep->data->listen_io, TRUE, NULL);
>         }
> -       ep->io =3D io;
> -       ep->data->listen_io =3D io;
> -
>  }
> +
>  static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep=
,
>                                 struct bt_bap_stream *stream, int defer)
>  {
> @@ -1838,9 +2043,6 @@ static void bap_create_bcast_io(struct bap_data *da=
ta, struct bap_ep *ep,
>
>         memset(&iso_qos, 0, sizeof(iso_qos));
>
> -       if (!defer)
> -               goto done;
> -
>         iso_qos.bcast.big =3D ep->qos.bcast.big;
>         iso_qos.bcast.bis =3D ep->qos.bcast.bis;
>         iso_qos.bcast.sync_factor =3D ep->qos.bcast.sync_factor;
> @@ -1857,9 +2059,9 @@ static void bap_create_bcast_io(struct bap_data *da=
ta, struct bap_ep *ep,
>         iso_qos.bcast.timeout =3D ep->qos.bcast.timeout;
>         memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
>                                 sizeof(struct bt_iso_io_qos));
> -done:
> +
>         if (bt_bap_pac_get_type(ep->lpac) =3D=3D BT_BAP_BCAST_SOURCE)
> -               bap_connect_io_broadcast(data, ep, stream, &iso_qos);
> +               bap_connect_io_broadcast(data, ep, stream, &iso_qos, defe=
r);
>         else
>                 bap_listen_io_broadcast(data, ep, stream, &iso_qos);
>  }
> @@ -1884,6 +2086,31 @@ static void bap_create_io(struct bap_data *data, s=
truct bap_ep *ep,
>                 break;
>         }
>  }
> +/*
> + * Function  test_linked_streams_state will check if all linked streams
> + * have the test state.
> + * If all streams are in test_state returns true; Else returns false
> + */
> +static bool test_linked_streams_state(struct bt_bap_stream *stream,
> +                                               uint8_t test_state)
> +{
> +       const struct queue_entry *entry;
> +       struct bt_bap_stream *linked_stream;
> +       struct queue *links;
> +
> +       links =3D bt_bap_stream_io_get_links(stream);
> +
> +       if (!links)
> +               return true;
> +
> +       for (entry =3D queue_get_entries(links); entry; entry =3D entry->=
next) {
> +               linked_stream =3D entry->data;
> +               if (bt_bap_stream_get_state(linked_stream) !=3D test_stat=
e)
> +                       return false;
> +       }
> +
> +       return true;
> +}
>
>  static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
>                                 uint8_t new_state, void *user_data)
> @@ -1915,15 +2142,26 @@ static void bap_state(struct bt_bap_stream *strea=
m, uint8_t old_state,
>                 break;
>         case BT_BAP_STREAM_STATE_CONFIG:
>                 if (ep && !ep->id) {
> -                       bap_create_io(data, ep, stream, true);
> -                       if (!ep->io) {
> -                               error("Unable to create io");
> -                               bt_bap_stream_release(stream, NULL, NULL)=
;
> -                               return;
> -                       }
> -
>                         if (bt_bap_stream_get_type(stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_BCAST) {
> +                               bool defer =3D !test_linked_streams_state=
(stream,
> +                                               BT_BAP_STREAM_STATE_CONFI=
G);
> +                               bap_create_io(data, ep, stream, defer);
> +                               if (!ep->io) {
> +                                       error("Unable to create io");
> +                                       bt_bap_stream_release(stream,
> +                                                               NULL, NUL=
L);
> +                                       return;
> +                               }
> +                       } else if (bt_bap_stream_get_type(stream) =3D=3D
>                                         BT_BAP_STREAM_TYPE_UCAST) {
> +                               bap_create_io(data, ep, stream, true);
> +                               if (!ep->io) {
> +                                       error("Unable to create io");
> +                                       bt_bap_stream_release(stream,
> +                                                               NULL, NUL=
L);
> +                                       return;
> +                               }
>                                 /* Wait QoS response to respond */
>                                 ep->id =3D bt_bap_stream_qos(stream, &ep-=
>qos,
>                                                                 qos_cb, e=
p);
> @@ -2237,6 +2475,12 @@ static int bap_bcast_probe(struct btd_service *ser=
vice)
>         struct btd_gatt_database *database =3D btd_adapter_get_database(a=
dapter);
>         struct bap_data *data =3D btd_service_get_user_data(service);
>         char addr[18];
> +       GIOChannel *io;
> +       GError *err =3D NULL;
> +       struct sockaddr_iso_bc iso_bc_addr;
> +
> +       iso_bc_addr.bc_bis[0] =3D 1;
> +       iso_bc_addr.bc_num_bis =3D 1;
>
>         ba2str(device_get_address(device), addr);
>
> @@ -2275,7 +2519,24 @@ static int bap_bcast_probe(struct btd_service *ser=
vice)
>
>         bt_bap_set_user_data(data->bap, service);
>
> -       bt_bap_new_bcast_source(data->bap, device_get_path(device));
> +       DBG("Create PA sync with source");
> +       io =3D bt_io_listen(NULL, iso_pa_sync_confirm_cb, data, NULL, &er=
r,
> +                       BT_IO_OPT_SOURCE_BDADDR,
> +                       btd_adapter_get_address(data->adapter),
> +                       BT_IO_OPT_DEST_BDADDR,
> +                       device_get_address(data->device),
> +                       BT_IO_OPT_DEST_TYPE,
> +                       btd_device_get_bdaddr_type(data->device),
> +                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> +                       BT_IO_OPT_QOS, &default_qos,
> +                       BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
> +                       BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
> +                       BT_IO_OPT_INVALID);
> +       if (!io) {
> +               error("%s", err->message);
> +               g_error_free(err);
> +       }
> +
>         return 0;
>  }
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index d8a3adde6..9593c77cf 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -254,6 +254,8 @@ static struct queue *bap_db;
>  static struct queue *bap_cbs;
>  static struct queue *sessions;
>
> +static bool bt_bap_new_bcast_sink(struct bt_bap *bap);
> +
>  static bool bap_db_match(const void *data, const void *match_data)
>  {
>         const struct bt_bap_db *bdb =3D data;
> @@ -1111,7 +1113,8 @@ static struct bt_bap_stream_io *stream_get_io(struc=
t bt_bap_stream *stream)
>                 return stream->io;
>
>         io =3D NULL;
> -       queue_foreach(stream->links, stream_find_io, &io);
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_UCAS=
T)
> +               queue_foreach(stream->links, stream_find_io, &io);
>
>         return io;
>  }
> @@ -1323,6 +1326,12 @@ static void stream_set_state_broadcast(struct bt_b=
ap_stream *stream,
>
>         bt_bap_ref(bap);
>
> +       switch (stream->ep->state) {
> +       case BT_ASCS_ASE_STATE_QOS:
> +               bap_stream_update_io_links(stream);
> +               break;
> +       }
> +
>         for (entry =3D queue_get_entries(bap->state_cbs); entry;
>                                                         entry =3D entry->=
next) {
>                 struct bt_bap_state *state =3D entry->data;
> @@ -2357,33 +2366,18 @@ static struct bt_bap_pac *bap_pac_find(struct bt_=
bap_db *bdb, uint8_t type,
>         return NULL;
>  }
>
> -static void *ltv_merge(struct iovec *data, struct iovec *cont)
> -{
> -       uint8_t delimiter =3D 0;
> -
> -       if (!data)
> -               return NULL;
> -
> -       if (!cont || !cont->iov_len || !cont->iov_base)
> -               return data->iov_base;
> -
> -       iov_append(data, sizeof(delimiter), &delimiter);
> -
> -       return iov_append(data, cont->iov_len, cont->iov_base);
> -}
> -
>  static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
>                                         struct iovec *metadata)
>  {
>         /* Merge data into existing record */
>         if (pac->data)
> -               ltv_merge(pac->data, data);
> +               bt_bap_ltv_merge(pac->data, data, true);
>         else
>                 pac->data =3D util_iov_dup(data, 1);
>
>         /* Merge metadata into existing record */
>         if (pac->metadata)
> -               ltv_merge(pac->metadata, metadata);
> +               bt_bap_ltv_merge(pac->metadata, metadata, true);
>         else
>                 pac->metadata =3D util_iov_dup(metadata, 1);
>  }
> @@ -2614,6 +2608,20 @@ static void notify_session_pac_added(void *data, v=
oid *user_data)
>         queue_foreach(bap->pac_cbs, notify_pac_added, user_data);
>  }
>
> +struct bt_bap_pac *bt_bap_add_vendor_pac_from_pac(struct bt_bap_pac *pac=
)
> +{
> +       struct bt_bap_pac *new_pac;
> +
> +       new_pac =3D bt_bap_add_vendor_pac(pac->bdb->db, pac->name, pac->t=
ype,
> +                                                       pac->codec.id,
> +                                                       pac->codec.cid,
> +                                                       pac->codec.cid,
> +                                                       &pac->qos, pac->d=
ata,
> +                                                       pac->metadata);
> +       bt_bap_pac_set_ops(new_pac, pac->ops, pac->user_data);
> +       return new_pac;
> +}
> +
>  struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
>                                         const char *name, uint8_t type,
>                                         uint8_t id, uint16_t cid, uint16_=
t vid,
> @@ -2671,7 +2679,7 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *d=
b, const char *name,
>                                         struct iovec *metadata)
>  {
>         return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, =
qos,
> -                                                       data, metadata);
> +                                                   data, metadata);
>  }
>
>  uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
> @@ -2701,6 +2709,14 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pa=
c *pac)
>         }
>  }
>
> +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac)
> +{
> +       if (!pac)
> +               return 0x00;
> +
> +       return pac->data;
> +}
> +
>  uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac)
>  {
>         struct bt_pacs *pacs;
> @@ -2783,12 +2799,26 @@ static void notify_session_pac_removed(void *data=
, void *user_data)
>  bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *o=
ps,
>                                         void *user_data)
>  {
> +       const struct queue_entry *entry =3D NULL;
> +       struct bt_bap_pac *pac_entry;
> +
>         if (!pac)
>                 return false;
>
>         pac->ops =3D ops;
>         pac->user_data =3D user_data;
>
> +       if (pac->type =3D=3D BT_BAP_BCAST_SOURCE) {
> +               for (entry =3D queue_get_entries(pac->bdb->broadcast_sour=
ces);
> +                                       entry !=3D NULL; entry =3D entry-=
>next) {
> +                       pac_entry =3D entry->data;
> +                       if (pac_entry !=3D pac) {
> +                               pac_entry->ops =3D ops;
> +                               pac_entry->user_data =3D user_data;
> +                       }
> +               }
> +       }
> +
>         return true;
>  }
>
> @@ -4471,6 +4501,11 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap,=
 struct bt_bap_pac *pac)
>         return false;
>  }
>
> +char *bt_bap_pac_get_name(struct bt_bap_pac *pac)
> +{
> +       return pac->name;
> +}
> +
>  static bool find_ep_unused(const void *data, const void *user_data)
>  {
>         const struct bt_bap_endpoint *ep =3D data;
> @@ -4591,7 +4626,6 @@ unsigned int bt_bap_stream_config(struct bt_bap_str=
eam *stream,
>                 if (stream->lpac->type =3D=3D BT_BAP_BCAST_SINK) {
>                         if (data)
>                                 stream_config(stream, data, NULL);
> -                       stream_set_state(stream, BT_BAP_STREAM_STATE_CONF=
IG);
>                 }
>                 return 1;
>         }
> @@ -4682,7 +4716,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_b=
ap *bap,
>                         return NULL;
>
>                 bt_bap_foreach_pac(bap, type, match_pac, &match);
> -               if (!match.lpac)
> +               if ((!match.lpac) || (!lpac))
>                         return NULL;
>                 if (!match.rpac && (lpac->type !=3D BT_BAP_BCAST_SOURCE))
>                         return NULL;
> @@ -4699,7 +4733,15 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_=
bap *bap,
>         if (!ep) {
>                 /* Check for unused ASE */
>                 ep =3D queue_find(bap->remote_eps, find_ep_unused, &match=
);
> -               if (!ep) {
> +               if (!ep && lpac->type =3D=3D BT_BAP_BCAST_SOURCE) {
> +                       bt_bap_new_bcast_sink(bap);
> +                       ep =3D queue_find(bap->remote_eps, find_ep_unused=
,
> +                                                               &match);
> +                       if (!ep) {
> +                               DBG(bap, "Unable to find unused ASE");
> +                               return NULL;
> +                       }
> +               } else if (!ep) {
>                         DBG(bap, "Unable to find unused ASE");
>                         return NULL;
>                 }
> @@ -4712,6 +4754,15 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_=
bap *bap,
>         return stream;
>  }
>
> +void bt_bap_stream_foreach_link(struct bt_bap_stream *stream,
> +                       queue_foreach_func_t function, void *user_data)
> +{
> +       if (bt_bap_stream_get_type(stream) =3D=3D
> +                                       BT_BAP_STREAM_TYPE_UCAST)
> +               queue_foreach(bt_bap_stream_io_get_links(stream),
> +                                               function, user_data);
> +}
> +
>  struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream)
>  {
>         if (!stream)
> @@ -4839,7 +4890,16 @@ static void bap_stream_enable_link(void *data, voi=
d *user_data)
>         struct bt_bap_stream *stream =3D data;
>         struct iovec *metadata =3D user_data;
>
> -       bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, NULL, NULL)=
;
> +       switch (bt_bap_stream_get_type(stream)) {
> +       case BT_BAP_STREAM_TYPE_UCAST:
> +               bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata,
> +                                                               NULL, NUL=
L);
> +               break;
> +       case BT_BAP_STREAM_TYPE_BCAST:
> +               stream_set_state_broadcast(stream,
> +                                               BT_BAP_STREAM_STATE_CONFI=
G);
> +               break;
> +       }
>  }
>
>  unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
> @@ -4868,11 +4928,10 @@ unsigned int bt_bap_stream_enable(struct bt_bap_s=
tream *stream,
>         case BT_BAP_STREAM_TYPE_BCAST:
>                 if (!bt_bap_stream_io_dir(stream))
>                         stream_set_state_broadcast(stream,
> -                               BT_BAP_STREAM_STATE_CONFIG);
> +                                               BT_BAP_STREAM_STATE_CONFI=
G);
>                 else if (bt_bap_stream_io_dir(stream) =3D=3D BT_BAP_BCAST=
_SOURCE)
>                         stream_set_state_broadcast(stream,
>                                  BT_BAP_STREAM_STATE_STREAMING);
> -
>                 return 1;
>         }
>
> @@ -4933,17 +4992,27 @@ static void bap_stream_disable_link(void *data, v=
oid *user_data)
>         struct iovec iov;
>         struct bt_ascs_disable disable;
>
> -       memset(&disable, 0, sizeof(disable));
> +       switch (bt_bap_stream_get_type(stream)) {
> +       case BT_BAP_STREAM_TYPE_UCAST:
> +               memset(&disable, 0, sizeof(disable));
> +
> +               disable.ase =3D stream->ep->id;
>
> -       disable.ase =3D stream->ep->id;
> +               iov.iov_base =3D &disable;
> +               iov.iov_len =3D sizeof(disable);
>
> -       iov.iov_base =3D &disable;
> -       iov.iov_len =3D sizeof(disable);
> +               req =3D bap_req_new(stream, BT_ASCS_DISABLE, &iov,
> +                                                       1, NULL, NULL);
>
> -       req =3D bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, NULL, NULL)=
;
> +               if (!bap_queue_req(stream->bap, req))
> +                       bap_req_free(req);
> +       break;
>
> -       if (!bap_queue_req(stream->bap, req))
> -               bap_req_free(req);
> +       case BT_BAP_STREAM_TYPE_BCAST:
> +               stream_set_state_broadcast(stream,
> +                               BT_BAP_STREAM_STATE_RELEASING);
> +       break;
> +       }
>  }
>
>  unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
> @@ -5189,7 +5258,8 @@ bool bt_bap_stream_set_io(struct bt_bap_stream *str=
eam, int fd)
>
>         bap_stream_set_io(stream, INT_TO_PTR(fd));
>
> -       queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_UCAS=
T)
> +               queue_foreach(stream->links, bap_stream_set_io, INT_TO_PT=
R(fd));
>
>         return true;
>  }
> @@ -5210,6 +5280,23 @@ static bool match_name(const void *data, const voi=
d *match_data)
>         return (!strcmp(pac->name, name));
>  }
>
> +void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
> +                                               bool add_delimiter)
> +{
> +       uint8_t delimiter =3D 0;
> +
> +       if (!data)
> +               return NULL;
> +
> +       if (!cont || !cont->iov_len || !cont->iov_base)
> +               return data->iov_base;
> +
> +       if (add_delimiter)
> +               iov_append(data, sizeof(delimiter), &delimiter);
> +
> +       return iov_append(data, cont->iov_len, cont->iov_base);
> +}
> +
>  int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id)
>  {
>         struct bt_bap_req *req;
> @@ -5245,10 +5332,15 @@ int bt_bap_stream_io_link(struct bt_bap_stream *s=
tream,
>         if (queue_find(stream->links, NULL, link))
>                 return -EALREADY;
>
> -       if (stream->client !=3D link->client ||
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BCAS=
T) {
> +               if (stream->qos.bcast.big !=3D link->qos.bcast.big)
> +                       return -EINVAL;
> +       } else {
> +               if (stream->client !=3D link->client ||
>                         stream->qos.ucast.cig_id !=3D link->qos.ucast.cig=
_id ||
>                         stream->qos.ucast.cis_id !=3D link->qos.ucast.cis=
_id)
> -               return -EINVAL;
> +                       return -EINVAL;
> +       }
>
>         if (!stream->links)
>                 stream->links =3D queue_new();
> @@ -5377,7 +5469,9 @@ int bt_bap_stream_io_connecting(struct bt_bap_strea=
m *stream, int fd)
>
>         bap_stream_io_connecting(stream, INT_TO_PTR(fd));
>
> -       queue_foreach(stream->links, bap_stream_io_connecting, INT_TO_PTR=
(fd));
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_UCAS=
T)
> +               queue_foreach(stream->links, bap_stream_io_connecting,
> +                                               INT_TO_PTR(fd));
>
>         return 0;
>  }
> @@ -5433,11 +5527,58 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, =
const char *name)
>         return true;
>  }
>
> +static bool bt_bap_new_bcast_sink(struct bt_bap *bap)
> +{
> +       struct bt_bap_endpoint *ep;
> +
> +       /* Push remote endpoint with direction source */
> +       ep =3D bap_endpoint_new_broadcast(bap->ldb, BT_BAP_BCAST_SOURCE);
> +
> +       if (ep)
> +               queue_push_tail(bap->remote_eps, ep);
> +
> +       ep->bap =3D bap;
> +       return true;
> +}
> +
> +static void bis_to_pac(void *data, void *user_data)
> +{
> +       struct bt_bap_bis *bis =3D data;
> +       struct bt_bap_base_subgroup *subgroup =3D user_data;
> +       struct bt_bap_pac *pac_source_bis;
> +       struct bt_bap_endpoint *ep;
> +       int err =3D 0;
> +
> +       bt_bap_ltv_merge(bis->caps, subgroup->caps, false);
> +       pac_source_bis =3D bap_pac_new(subgroup->bap->rdb, NULL,
> +                               BT_BAP_BCAST_SOURCE, &subgroup->codec, NU=
LL,
> +                               bis->caps, subgroup->meta);
> +
> +       err =3D asprintf(&pac_source_bis->name, "%d", bis->bisIndex);
> +
> +       if (err < 0)
> +               DBG(subgroup->bap, "error in asprintf");
> +
> +               /* Add remote source endpoint */
> +       if (!subgroup->bap->rdb->broadcast_sources)
> +               subgroup->bap->rdb->broadcast_sources =3D queue_new();
> +       queue_push_tail(subgroup->bap->rdb->broadcast_sources, pac_source=
_bis);
> +
> +       queue_foreach(subgroup->bap->pac_cbs, notify_pac_added, pac_sourc=
e_bis);
> +       /* Push remote endpoint with direction sink */
> +       ep =3D bap_endpoint_new_broadcast(subgroup->bap->rdb, BT_BAP_BCAS=
T_SINK);
> +
> +       if (ep)
> +               queue_push_tail(subgroup->bap->remote_eps, ep);
> +}
> +static void parse_bis(void *data, void *user_data)
> +{
> +       struct bt_bap_base_subgroup *subgroup =3D data;
> +
> +       queue_foreach(subgroup->bises, bis_to_pac, subgroup);
> +}
>  void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
> -                                       struct bt_bap_codec *codec,
> -                                       struct iovec *data,
> -                                       struct iovec *metadata)
> +                               struct bt_bap_base *base)
>  {
> -       bap_pac_merge(pac, data, metadata);
> -       pac->codec =3D *codec;
> +       queue_foreach(base->subgroups, parse_bis, NULL);
>  }
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 2c8f9208e..411655801 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -97,6 +97,27 @@ struct bt_bap_qos {
>         };
>  };
>
> +struct bt_bap_base {
> +       uint32_t presDelay;
> +       uint8_t numSubgroups;
> +       struct queue *subgroups;
> +};
> +
> +struct bt_bap_base_subgroup {
> +       uint8_t subGroupIndex;
> +       struct bt_bap *bap;
> +       uint8_t numBises;
> +       struct bt_bap_codec codec;
> +       struct iovec *caps;
> +       struct iovec *meta;
> +       struct queue *bises;
> +};
> +
> +struct bt_bap_bis {
> +       uint8_t bisIndex;
> +       struct iovec *caps;
> +};
> +
>  typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data)=
;
>  typedef void (*bt_bap_destroy_func_t)(void *user_data);
>  typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
> @@ -168,6 +189,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
>
>  uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
>
> +struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
> +
>  uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac);
>
>  uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
> @@ -176,6 +199,8 @@ struct bt_bap_pac_qos *bt_bap_pac_get_qos(struct bt_b=
ap_pac *pac);
>
>  uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
>
> +struct bt_bap_pac *bt_bap_add_vendor_pac_from_pac(struct bt_bap_pac *pac=
);
> +
>  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
>
>  /* Session related function */
> @@ -231,6 +256,7 @@ int bt_bap_pac_get_codec(struct bt_bap_pac *pac, uint=
8_t *id,
>
>  void bt_bap_pac_set_user_data(struct bt_bap_pac *pac, void *user_data);
>  void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
> +char *bt_bap_pac_get_name(struct bt_bap_pac *pac);
>
>  /* Stream related functions */
>  int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> @@ -242,6 +268,9 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap=
 *bap,
>                                         struct bt_bap_qos *pqos,
>                                         struct iovec *data);
>
> +void bt_bap_stream_foreach_link(struct bt_bap_stream *stream,
> +                       queue_foreach_func_t function, void *user_data);
> +
>  struct bt_bap *bt_bap_stream_get_session(struct bt_bap_stream *stream);
>  uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream);
>
> @@ -314,9 +343,9 @@ bool bt_bap_stream_io_is_connecting(struct bt_bap_str=
eam *stream, int *fd);
>
>  bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);
>  void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
> -                                       struct bt_bap_codec *codec,
> -                                       struct iovec *data,
> -                                       struct iovec *metadata);
> +                               struct bt_bap_base *base);
> +void *bt_bap_ltv_merge(struct iovec *data, struct iovec *cont,
> +                                               bool add_delimiter);
>
>  bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pa=
c);
>
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index adade07db..d308d42f9 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -377,11 +377,13 @@ static void test_client_config(struct test_data *da=
ta)
>                                                         "test-bap-snk",
>                                                         BT_BAP_SINK, 0x0f=
f,
>                                                         0x0001, 0x0001,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       NULL, data->caps,
> +                                                       NULL);
>                 else
>                         data->snk =3D bt_bap_add_pac(data->db, "test-bap-=
snk",
>                                                         BT_BAP_SINK, LC3_=
ID,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       NULL, data->caps,
> +                                                       NULL);
>                 g_assert(data->snk);
>         }
>
> @@ -391,11 +393,13 @@ static void test_client_config(struct test_data *da=
ta)
>                                                         "test-bap-src",
>                                                         BT_BAP_SOURCE, 0x=
0ff,
>                                                         0x0001, 0x0001,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       NULL, data->caps,
> +                                                       NULL);
>                 else
>                         data->src =3D bt_bap_add_pac(data->db, "test-bap-=
src",
>                                                         BT_BAP_SOURCE, LC=
3_ID,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       NULL, data->caps,
> +                                                       NULL);
>                 g_assert(data->src);
>         }
>  }
> --
> 2.39.2
>
>


--=20
Luiz Augusto von Dentz
