Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D4A1C280
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjXUJiKA"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cca5d81826so130338771fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705418547; x=1706023347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwuHPp/bYVdno71F55dJMmDfpczRmZFpi1Ss56cFG+A=;
        b=GjXUJiKAnNt1uMa/MI+3o6GeJ8GjRplsb6/faa9q108BHiGHOTt6V4rg7nOswn1Yzw
         fAhl9HewKxuKa0mNJqkOD0ddySDmP1HrQv6lgnmykYUkw+RlW8xqFjHcjRmVDjiWxzCC
         8q02C506NtfeLFWSojxIKAw2zTO2GEY453v4DhEky/Ug6HbQpC3ZPhjbciPJhOIdS/r5
         kZM2oS8pGYyWcodJWayMnev8M3EdxwXVbAvN/Fy3o6/jrB49NJ+I0xLGHUmjPpZXg6/B
         7zRA+DhxFFaVE1tYzvX2J4JRWNTz+p+n5gZrtJW8MHfi2+3q8/BU0btLq7/vPOm25bFl
         5d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418547; x=1706023347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwuHPp/bYVdno71F55dJMmDfpczRmZFpi1Ss56cFG+A=;
        b=fwamWle19nCeddkoKUOAYndcR8rHJAh147aB/uwytlsCB5ivF64Jp87OCTdkgBv44S
         5BAtYzXEnB91qR3lQC0bebrrIFT8Q8jSt8Mbv32FDl5G5hXlGNvvPj9Vg7s4q/9R98Jv
         wsi5iD/H3SQkVdHrnRyikDkeBYEFFy/L2zgmxDuzAk8HTa9jIbCDPUMUQDboMTtqymfE
         GLHF4FCI7ls8hszyHhQ+eMDrvGa9hxUW1WotsEGyUTXAWPpnsbOnf9qrykRENp3VQu9F
         RouSiHIifhAugaxZxPoQ3gWgiw2IJylBa85o+x7vPgjA6Xy4yWcJQKd4IwsvfN2BAc8M
         Cjkg==
X-Gm-Message-State: AOJu0Yx55Fh4kwu/uq3eSSYoIe6gMgGg9r8sNThaNezakGEGv7A3D5gd
	JHTwb4DNgPecT/jGVRQP1BcAw1c2QCxT9L7JAHMhIEa+
X-Google-Smtp-Source: AGHT+IEfauhafxX5+WgVTEN04jIRaePnsukRn+l/In+7JCTc7bWQSgmA044rGtPEcM2Dk3GW5Ci5FCWr5rC6tFgjdCk=
X-Received: by 2002:a2e:b0d9:0:b0:2cc:f31b:56ea with SMTP id
 g25-20020a2eb0d9000000b002ccf31b56eamr3830723ljl.92.1705418546752; Tue, 16
 Jan 2024 07:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112165601.134073-1-silviu.barbulescu@nxp.com> <20240112165601.134073-3-silviu.barbulescu@nxp.com>
In-Reply-To: <20240112165601.134073-3-silviu.barbulescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Jan 2024 10:22:13 -0500
Message-ID: <CABBYNZLqCmCyycWVRNWZ_mL85YkcVpeMBct9tDmi5b_BKQHp3A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 2/2] shared/bap: Code for dynamically generated BASE
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Silviu,

On Fri, Jan 12, 2024 at 11:56=E2=80=AFAM Silviu Florian Barbulescu
<silviu.barbulescu@nxp.com> wrote:
>
> Add code to support dynamically generated BASE from presets
>
> ---
>  src/shared/bap.c | 492 +++++++++++++++++++++++++++++++++++++++++++++++
>  src/shared/bap.h |   2 +
>  2 files changed, 494 insertions(+)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 49eb8d057..fca6ab9cf 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -226,6 +226,7 @@ struct bt_bap_stream {
>         struct bt_bap_stream_io *io;
>         bool client;
>         void *user_data;
> +       struct queue *bcast_links; /* Linked streams from the same BIG */
>  };
>
>  /* TODO: Figure out the capabilities types */
> @@ -255,6 +256,30 @@ struct bt_pacs_context {
>         uint16_t  src;
>  } __packed;
>
> +struct bt_base_data {
> +       uint32_t pres_delay;
> +       struct queue *base_data_subgroup;
> +};
> +
> +struct bt_stream_base_data {
> +       struct queue *ltv_caps;
> +       struct queue *ltv_meta;
> +       struct bt_bap_stream *stream;
> +};
> +
> +struct bt_base_data_subgroup {
> +       uint8_t subgroup_index;

Don't need to repeat the term subgroup if it is already part of the struct =
name.

> +       struct bt_bap_codec codec;
> +       struct queue *ltv_caps;
> +       struct queue *ltv_meta;
> +       struct queue *bises;
> +};
> +
> +struct bt_base_data_bis {
> +       uint8_t bis_index;

Ditto.

> +       struct queue *ltv_caps;
> +};
> +
>  /* Contains local bt_bap_db */
>  static struct queue *bap_db;
>  static struct queue *bap_cbs;
> @@ -826,6 +851,7 @@ static struct bt_bap_stream *bap_stream_new(struct bt=
_bap *bap,
>         stream->rpac =3D rpac;
>         stream->cc =3D util_iov_dup(data, 1);
>         stream->client =3D client;
> +       stream->bcast_links =3D queue_new();

This is not a good practice actually, we would need to have each and
every stream that represents a BIS listing all the BISes linked, so we
might need another structure when we can have more than 2 streams
linked together, that said each BIS will map to a different ISO Handle
so they are not really links like in unicast.

Maybe let me clarify what I intended with the use of stream->link,
that is meant to inform if the stream is linked/multiplexed so when
setting up its IO/socket they should transit its state machine
together, which is normally the case of bidirection IO which can use
the same ISO socket. Now on broadcast that doesn't seem to be the
case, you don't really need to link the IO because broadcast is always
unidirection and in case you want to have multiple channels
multiplexed then they would constitute only 1 bis, so it doesn't look
like we need to link them together.


>
>         queue_push_tail(bap->streams, stream);
>
> @@ -1010,6 +1036,14 @@ static void stream_io_unref(struct bt_bap_stream_i=
o *io)
>         stream_io_free(io);
>  }
>
> +static void bap_stream_unlink(void *data, void *user_data)
> +{
> +       struct bt_bap_stream *link =3D data;
> +       struct bt_bap_stream *stream =3D user_data;
> +
> +       queue_remove(link->bcast_links, stream);
> +}
> +
>  static void bap_stream_free(void *data)
>  {
>         struct bt_bap_stream *stream =3D data;
> @@ -1020,6 +1054,9 @@ static void bap_stream_free(void *data)
>         if (stream->link)
>                 stream->link->link =3D NULL;
>
> +       queue_foreach(stream->bcast_links, bap_stream_unlink, stream);
> +       queue_destroy(stream->bcast_links, NULL);
> +
>         stream_io_unref(stream->io);
>         util_iov_free(stream->cc, 1);
>         util_iov_free(stream->meta, 1);
> @@ -5492,3 +5529,458 @@ void bt_bap_update_bcast_source(struct bt_bap_pac=
 *pac,
>         bap_pac_merge(pac, data, metadata);
>         pac->codec =3D *codec;
>  }
> +
> +static void destroy_ltv(void *data)
> +{
> +       struct bt_ltv *ltv =3D data;
> +
> +       if (!ltv)
> +               return;
> +
> +       free(ltv);
> +}
> +
> +static void destroy_base_data_bis(void *data)
> +{
> +       struct bt_base_data_bis *bis =3D data;
> +
> +       if (!bis)
> +               return;
> +
> +       queue_destroy(bis->ltv_caps, destroy_ltv);
> +       free(bis);
> +}
> +
> +static void destroy_base_data_subgroup(void *data)
> +{
> +       struct bt_base_data_subgroup *subgroup =3D data;
> +
> +       if (!subgroup)
> +               return;
> +
> +       queue_destroy(subgroup->ltv_caps, destroy_ltv);
> +       queue_destroy(subgroup->ltv_meta, destroy_ltv);
> +       queue_destroy(subgroup->bises, destroy_base_data_bis);
> +
> +       free(subgroup);
> +}
> +
> +static void destroy_stream_base_data(void *data)
> +{
> +       struct bt_stream_base_data *sbd =3D data;
> +
> +       if (!sbd)
> +               return;
> +
> +       queue_destroy(sbd->ltv_caps, destroy_ltv);
> +       queue_destroy(sbd->ltv_meta, destroy_ltv);
> +       sbd->stream =3D NULL;
> +       free(sbd);
> +}
> +
> +static void append_ltv_to_base(void *data, void *user_data)
> +{
> +       struct bt_ltv *ltv =3D data;
> +       struct iovec *base_iov =3D user_data;
> +
> +       if (!util_iov_push_u8(base_iov, ltv->len))
> +               return;
> +
> +       if (!util_iov_push_u8(base_iov, ltv->type))
> +               return;
> +
> +       if (!util_iov_push_mem(base_iov, ltv->len - 1, ltv->value))
> +               return;
> +}
> +
> +static void get_ltv_size(void *data, void *user_data)
> +{
> +       struct bt_ltv *ltv =3D data;
> +       uint8_t *length =3D user_data;
> +
> +       *length =3D *length + ltv->len + 1;
> +}
> +
> +static uint8_t get_size_from_ltv_queue(struct queue *ltv_queue)
> +{
> +       uint8_t length =3D 0;
> +
> +       queue_foreach(ltv_queue, get_ltv_size, &length);
> +       return length;
> +}
> +
> +static void generate_bis_base(void *data, void *user_data)
> +{
> +       struct bt_base_data_bis *bis =3D data;
> +       struct iovec *base_iov =3D user_data;
> +       uint8_t cc_length =3D get_size_from_ltv_queue(bis->ltv_caps);
> +
> +       if (!util_iov_push_u8(base_iov, bis->bis_index))
> +               return;
> +
> +       if (!util_iov_push_u8(base_iov, cc_length))
> +               return;
> +
> +       queue_foreach(bis->ltv_caps, append_ltv_to_base, base_iov);

Can you just assign the cc_length at the end so you can use
base_iov->iov_len - 1 directly instead of iterating twice over th
ltv_caps? Btw, we can probably get rid of ltv_caps as well and just
use caps that should be as readable.

> +}
> +
> +static void generate_subgroup_base(void *data, void *user_data)
> +{
> +       struct bt_base_data_subgroup *bds =3D data;
> +       struct iovec *base_iov =3D user_data;
> +       uint8_t cc_length =3D get_size_from_ltv_queue(bds->ltv_caps);
> +       uint8_t metadata_length =3D get_size_from_ltv_queue(bds->ltv_meta=
);
> +
> +       if (!util_iov_push_u8(base_iov, queue_length(bds->bises)))
> +               return;
> +
> +       if (!util_iov_push_u8(base_iov, bds->codec.id))
> +               return;
> +
> +       if (!util_iov_push_le16(base_iov, bds->codec.cid))
> +               return;
> +
> +       if (!util_iov_push_le16(base_iov, bds->codec.vid))
> +               return;
> +
> +       if (!util_iov_push_u8(base_iov, cc_length))
> +               return;
> +
> +       queue_foreach(bds->ltv_caps, append_ltv_to_base, base_iov);
> +
> +       if (!util_iov_push_u8(base_iov, metadata_length))
> +               return;
> +
> +       queue_foreach(bds->ltv_meta, append_ltv_to_base, base_iov);
> +
> +       queue_foreach(bds->bises, generate_bis_base, base_iov);
> +}
> +
> +static struct iovec *generate_base(struct bt_base_data *base)
> +{
> +       struct iovec *base_iov =3D new0(struct iovec, 0x1);
> +
> +       base_iov->iov_base =3D util_malloc(BASE_MAX_LENGTH);
> +
> +       if (!util_iov_push_le24(base_iov, base->pres_delay))
> +               return NULL;
> +
> +       if (!util_iov_push_u8(base_iov,
> +                       queue_length(base->base_data_subgroup)))
> +               return NULL;
> +
> +       queue_foreach(base->base_data_subgroup, generate_subgroup_base,
> +                               base_iov);
> +
> +       return base_iov;
> +}
> +
> +static void get_max_bises_index(void *data, void *user_data)
> +{
> +       struct bt_base_data_bis *bdb =3D data;
> +       uint8_t *bis_index =3D user_data;
> +
> +       if (bdb->bis_index > *bis_index)
> +               *bis_index =3D bdb->bis_index + 1;
> +       else if (bdb->bis_index =3D=3D *bis_index)
> +               *bis_index =3D *bis_index + 1;
> +}
> +
> +static void get_bises_index(void *data, void *user_data)
> +{
> +       struct bt_base_data_subgroup *bds =3D data;
> +       uint8_t *bis_index =3D user_data;
> +
> +       queue_foreach(bds->bises, get_max_bises_index, bis_index);
> +}
> +
> +static uint8_t get_bis_index(struct queue *subgroups)
> +{
> +       uint8_t bis_index =3D 1;
> +
> +       queue_foreach(subgroups, get_bises_index, &bis_index);
> +       return bis_index;
> +}
> +
> +static void add_new_bis(struct bt_base_data_subgroup *subgroup,
> +                       uint8_t bis_index, struct queue *ltv_bis_caps)
> +{
> +               struct bt_base_data_bis *bdb =3D new0(struct bt_base_data=
_bis, 1);
> +
> +               bdb->bis_index =3D bis_index;
> +               bdb->ltv_caps =3D ltv_bis_caps;
> +               queue_push_tail(subgroup->bises, bdb);
> +}
> +
> +static void add_new_subgroup(struct queue *subgroups,
> +                       struct bt_stream_base_data *base_data)
> +{
> +               struct bt_bap_pac *lpac =3D base_data->stream->lpac;
> +               struct bt_base_data_subgroup *bds =3D new0(
> +                                       struct bt_base_data_subgroup, 1);
> +               uint16_t cid =3D 0;
> +               uint16_t vid =3D 0;
> +
> +               bt_bap_pac_get_vendor_codec(lpac, &bds->codec.id, &cid,
> +                               &vid, NULL, NULL);
> +               bds->codec.cid =3D cid;
> +               bds->codec.vid =3D vid;
> +               bds->ltv_caps =3D base_data->ltv_caps;
> +               bds->ltv_meta =3D base_data->ltv_meta;
> +               base_data->ltv_caps =3D NULL;
> +               base_data->ltv_meta =3D NULL;
> +               bds->bises =3D queue_new();
> +               base_data->stream->qos.bcast.bis =3D get_bis_index(subgro=
ups);
> +               add_new_bis(bds, base_data->stream->qos.bcast.bis,
> +                                               queue_new());
> +               queue_push_tail(subgroups, bds);
> +}
> +
> +static bool ltv_match(const void *data, const void *match_data)
> +{
> +       const struct bt_ltv *ltv1 =3D data;
> +       const struct bt_ltv *ltv2 =3D match_data;
> +
> +       if (ltv1->len =3D=3D ltv2->len)
> +               if (ltv1->type =3D=3D ltv2->type)
> +                       if (memcmp(ltv1->value, ltv2->value, ltv1->len - =
1)
> +                                               =3D=3D 0)
> +                               return true;
> +       return false;
> +}
> +

Remove extra empty line here.

> +static bool compare_ltv_lists(struct queue *ltv_list1, struct queue *ltv=
_list2)
> +{
> +       const struct queue_entry *entry;

Missing empty line.

> +       /* Compare metadata length */
> +       if (queue_length(ltv_list1) !=3D queue_length(ltv_list2))
> +               return false;
> +
> +       /* Compare metadata ltvs */
> +       for (entry =3D queue_get_entries(ltv_list1); entry; entry =3D ent=
ry->next) {
> +               struct bt_ltv *ltv =3D entry->data;
> +
> +               if (!queue_find(ltv_list2, ltv_match, ltv))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static struct queue *compare_caps_ltv_lists(
> +               struct queue *subgroup_caps, struct queue *bis_caps)
> +{
> +       struct queue *ltv_caps =3D queue_new();
> +       const struct queue_entry *entry;
> +
> +       /* Compare metadata ltvs */
> +       for (entry =3D queue_get_entries(bis_caps); entry;
> +                                       entry =3D entry->next) {
> +               struct bt_ltv *ltv =3D entry->data;
> +
> +               if (!queue_find(subgroup_caps, ltv_match, ltv))
> +                       queue_push_tail(ltv_caps, ltv);
> +       }
> +
> +       if (queue_isempty(ltv_caps)) {
> +               queue_destroy(ltv_caps, NULL);
> +               return NULL;
> +       } else
> +               return ltv_caps;
> +}
> +
> +static void remove_ltv_form_list(void *data, void *user_data)
> +{
> +       struct bt_ltv *ltv =3D data;
> +       struct queue *ltv_caps =3D user_data;
> +
> +       queue_remove(ltv_caps, ltv);
> +}
> +
> +static void set_base_subgroup(void *data, void *user_data)
> +{
> +       struct bt_stream_base_data *stream_base =3D data;
> +       struct bt_base_data *base =3D user_data;
> +       struct queue *ltv_caps;
> +
> +       if (queue_isempty(base->base_data_subgroup)) {
> +               add_new_subgroup(base->base_data_subgroup, stream_base);
> +       } else {
> +               /* Verify if a subgroup has the same metadata */
> +               const struct queue_entry *entry;
> +               struct bt_base_data_subgroup *subgroup_base =3D NULL;
> +               bool same_meta =3D false;
> +
> +               for (entry =3D queue_get_entries(base->base_data_subgroup=
);
> +                                               entry; entry =3D entry->n=
ext) {
> +                       subgroup_base =3D entry->data;
> +                       if (compare_ltv_lists(subgroup_base->ltv_meta,
> +                                       stream_base->ltv_meta)) {
> +                               same_meta =3D true;
> +                               break;
> +                       }
> +               }
> +
> +               if (!same_meta) {
> +                       /* No subgroup with the same metadata found.
> +                        * Create a new one.
> +                        */
> +                       add_new_subgroup(base->base_data_subgroup,
> +                               stream_base);
> +               } else {
> +                       /* Subgroup found with the same metadata
> +                        * get different capabilities
> +                        */
> +                       ltv_caps =3D compare_caps_ltv_lists(
> +                                       subgroup_base->ltv_caps,
> +                                       stream_base->ltv_caps);
> +
> +                       queue_foreach(ltv_caps, remove_ltv_form_list,
> +                               stream_base->ltv_caps);
> +                       stream_base->stream->qos.bcast.bis =3D get_bis_in=
dex(
> +                               base->base_data_subgroup);
> +                       add_new_bis(subgroup_base,
> +                                       stream_base->stream->qos.bcast.bi=
s,
> +                                       ltv_caps);
> +               }
> +       }
> +}
> +
> +static void set_device_presentation_delay(void *data, void *user_data)
> +{
> +       struct bt_stream_base_data *sbd =3D data;
> +       struct bt_base_data *base =3D user_data;
> +       struct bt_bap_qos *qos =3D &sbd->stream->qos;
> +
> +       if (base->pres_delay < qos->bcast.delay)
> +               base->pres_delay =3D qos->bcast.delay;
> +}
> +
> +static void parse_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
> +                                       void *user_data)
> +{
> +       struct queue **ltv_queue =3D user_data;
> +       struct bt_ltv *q_ltv_elem =3D malloc(sizeof(struct bt_ltv) + l);
> +
> +       q_ltv_elem->len =3D l + 1;
> +       q_ltv_elem->type =3D t;
> +
> +       memcpy(q_ltv_elem->value, v, l);
> +
> +       if (!*ltv_queue)
> +               *ltv_queue =3D queue_new();
> +       queue_push_tail(*ltv_queue, q_ltv_elem);
> +}
> +
> +/*
> + * Extract Codec Specific configurations and Metadata information
> + * that will be use in the BASE creation
> + */
> +static struct bt_stream_base_data *get_stream_base_info(
> +                       struct bt_bap_stream *stream)
> +{
> +       struct bt_stream_base_data *sbd =3D new0(struct bt_stream_base_da=
ta, 1);
> +       struct iovec *stream_caps_iov =3D util_iov_dup(
> +                       stream->cc, 1);
> +       struct iovec *stream_meta_iov =3D util_iov_dup(
> +                       stream->meta, 1);

Not sure why you need to copy these values above, are you going to
change them in-place? If all you do is read/parse then we can use them
as is without copying.

> +       /*
> +        * Copy the Codec Specific configurations from stream
> +        */
> +       if (stream_caps_iov !=3D NULL) {
> +               if (!util_ltv_foreach(stream_caps_iov->iov_base,
> +                               stream_caps_iov->iov_len, NULL,
> +                               parse_ltv, &sbd->ltv_caps)) {
> +                       DBG(stream->bap,
> +                       "Unable to parse Codec Specific configurations");
> +                       goto fail;
> +               }
> +       }
> +
> +       /*
> +        * Copy the Metadata from stream
> +        */
> +       if (stream_meta_iov !=3D NULL) {
> +               if (!util_ltv_foreach(stream_meta_iov->iov_base,
> +                               stream_meta_iov->iov_len, NULL,
> +                               parse_ltv, &sbd->ltv_meta)) {
> +                       DBG(stream->bap,
> +                       "Unable to parse metadata");
> +                       goto fail;
> +               }
> +       }
> +
> +       sbd->stream =3D stream;
> +
> +       util_iov_free(stream_caps_iov, 1);
> +       util_iov_free(stream_meta_iov, 1);
> +
> +       return sbd;
> +
> +fail:
> +       util_iov_free(stream_caps_iov, 1);
> +       util_iov_free(stream_meta_iov, 1);
> +
> +       if (sbd->ltv_caps)
> +               queue_destroy(sbd->ltv_caps, destroy_ltv);
> +
> +       if (sbd->ltv_meta)
> +               queue_destroy(sbd->ltv_meta, destroy_ltv);
> +
> +       free(sbd);
> +
> +       return NULL;
> +}
> +
> +static void get_stream_base_data(void *data, void *user_data)
> +{
> +       struct bt_bap_stream *stream =3D data;
> +       struct queue *streams_base_data =3D user_data;
> +       struct bt_stream_base_data *sbd =3D get_stream_base_info(stream);
> +
> +       if (sbd)
> +               queue_push_tail(streams_base_data, sbd);
> +}
> +
> +/*
> + * Function to update the BASE using configuration data
> + * from each BIS in an BIG
> + */
> +struct iovec *bt_bap_update_base(struct bt_bap_stream *stream)
> +{
> +       struct bt_base_data *base;
> +       struct iovec *base_iov;
> +       struct queue *streams_base_data =3D queue_new();
> +       struct bt_stream_base_data *sbd =3D get_stream_base_info(stream);
> +
> +       /*
> +        * Extract Codec Specific configurations and Metadata information
> +        * that will be use in the BASE creation from all linked BISes
> +        */
> +       queue_foreach(stream->bcast_links, get_stream_base_data,
> +                                               streams_base_data);
> +
> +       queue_push_tail(streams_base_data, sbd);
> +
> +       base =3D new0(struct bt_base_data, 1);
> +       base->base_data_subgroup =3D queue_new();
> +
> +       queue_foreach(streams_base_data, set_device_presentation_delay, b=
ase);
> +
> +       /*
> +        * Create subgroups and BISes in a BASE
> +        */
> +       queue_foreach(streams_base_data, set_base_subgroup, base);
> +
> +       base_iov =3D generate_base(base);
> +
> +       queue_destroy(streams_base_data, destroy_stream_base_data);
> +
> +       queue_destroy(base->base_data_subgroup, destroy_base_data_subgrou=
p);
> +
> +       free(base);
> +
> +       return base_iov;
> +}
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index 51edc08ab..725151fa5 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -88,6 +88,7 @@ struct bt_bap_bcast_qos {
>         uint16_t timeout;
>         uint8_t  pa_sync;
>         struct bt_bap_io_qos io_qos;
> +       uint32_t delay;                 /* Presentation Delay */
>  };
>
>  struct bt_bap_qos {
> @@ -321,3 +322,4 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pa=
c,
>
>  bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pa=
c);
>
> +struct iovec *bt_bap_update_base(struct bt_bap_stream *stream);

This should probably be bt_bap_stream_get_base and I'd change the way
we generate it to not rely on a queue/list internally, but instead do
a lookup by BIG ID to generate the base, also add a check to make sure
the stream is of broadcast type.

> --
> 2.39.2
>


--
Luiz Augusto von Dentz
