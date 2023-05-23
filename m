Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA9C7EE2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 16:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbjEWQqw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbjEWQqu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 12:46:50 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A975DD
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 09:46:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso128656e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684860403; x=1687452403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8kLVOayCShBWkTKiyIgFTcxbnu2XCKI+Ifugm1M5h8=;
        b=ha4QUZV/bjMe149NqPSDf9BaxcKbroA8Tf+j6nvS6nWjolfzi/tc7lO3A43WtEs7R9
         dYyACywcOiZObBYml7pf2MHl0nQ/IxCovhuNuEnEBCfbzl7+LM9b9LHGwo8a7bFYWRpV
         zPqIggIEyYVjZic36xGhioocAGrgg0ypZapSZ2PqV/rZHdYx4vYkCkw3/FsidCQGqEzi
         VofTkxDUWyGtSq10cdz6kDa9Y1VxWYtidwYRvZJAI+peZzeHeygb/5gbyFxotR0/+DZf
         UcSieHmU5Cmf35TO24xK04MYiOS4bU9QY1WLKJNgY8LNjCLfhWtF6ww/C7CZa5/IH6AO
         aXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860403; x=1687452403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8kLVOayCShBWkTKiyIgFTcxbnu2XCKI+Ifugm1M5h8=;
        b=fKx8Y0BMdQbI+4AHDmw2W39RKzsd1gaxL7KGjtPi9GjfOOesYFmPlAoVIzEGi+H2WK
         Q+Z8wd+Sg1K2ejxYqKQWKlTYYGDGozEM8wYBDI4GL+KhcpCrDOcOtPnunzX01DbAdvIQ
         PCJkMpjQJFCNzwgcUeDsN0/1MFPzm/1TkXgHhZlpB+FnTzRl8IbVyNDTZMrF2Famvisj
         Swq6NKGEODEBVJrQbO/pr2JkbhQUy4wVuRXhf88bEObopv2Vfnmn+kAgpw3HL5pCFKfQ
         rpdvK3gHqGXJIAfNZmtDmLVNzuzrVpIpUzMLrPlkqo8WVHZX4TrVCH0Y/XbiBzp+WFUE
         Rl1g==
X-Gm-Message-State: AC+VfDw51bq+S796KhdmhaxoPBm5mDNaNsUwAzZTV+JBXPfarmHvg3gx
        NRbSRfFeINjnw/6xruucXsLXc4tFoG8kRBt8e1Y=
X-Google-Smtp-Source: ACHHUZ5zfKqRlxMZhYHaxdyz32w/oMIPYwBfwJxivk/zW8y9e+k9FdNpXqrG4KweC90XuHVfgaJQ2HwefaJPaKMbeIQ=
X-Received: by 2002:ac2:43ba:0:b0:4f4:aea9:2a2f with SMTP id
 t26-20020ac243ba000000b004f4aea92a2fmr1915692lfl.57.1684860402444; Tue, 23
 May 2023 09:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230523143504.3319-1-iulia.tanasescu@nxp.com> <20230523143504.3319-7-iulia.tanasescu@nxp.com>
In-Reply-To: <20230523143504.3319-7-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 23 May 2023 09:46:29 -0700
Message-ID: <CABBYNZL0mFVGLJ6nms3BVLK-uGND70tGHQiA-HuUCrc8RRiMNg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 6/6] bap: Add initial support for BAP broadcast source
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia, Silviu,

On Tue, May 23, 2023 at 7:49=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
>
> This adds initial support for BAP broadcast source.
>
> ---
>  profiles/audio/bap.c       | 460 ++++++++++++++++++++++++++++++++-----
>  profiles/audio/media.c     | 129 +++++++++--
>  profiles/audio/transport.c |  51 ++--
>  src/shared/bap.c           | 324 +++++++++++++++++++-------
>  src/shared/bap.h           |  81 +++++--
>  unit/test-bap.c            |  83 +++----
>  6 files changed, 886 insertions(+), 242 deletions(-)

Please split these changes into shared/bap.*, unit/test-bap.c and
profiles/audio/*.

> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index 8f12fc410..3858eb1d9 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -82,13 +82,25 @@ struct bap_data {
>         unsigned int pac_id;
>         struct queue *srcs;
>         struct queue *snks;
> +       struct queue *broadcast;

Lets rename broadcast to bcast to make it shorter.

>         struct queue *streams;
>         GIOChannel *listen_io;
>         int selecting;
> +       void *user_data;
>  };
>
>  static struct queue *sessions;
>
> +static bool bap_data_set_user_data(struct bap_data *data, void *user_dat=
a)
> +{
> +       if (!data)
> +               return false;
> +
> +       data->user_data =3D user_data;
> +
> +       return true;
> +}
> +
>  static void bap_debug(const char *str, void *user_data)
>  {
>         DBG_IDX(0xffff, "%s", str);
> @@ -167,8 +179,10 @@ static gboolean get_uuid(const GDBusPropertyTable *p=
roperty,
>
>         if (queue_find(ep->data->snks, NULL, ep))
>                 uuid =3D PAC_SINK_UUID;
> -       else
> +       if (queue_find(ep->data->srcs, NULL, ep))
>                 uuid =3D PAC_SOURCE_UUID;
> +       else
> +               uuid =3D BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID;

How about using BAA_SERVICE_UUID here?

>         dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &uuid);
>
> @@ -253,6 +267,8 @@ static int parse_properties(DBusMessageIter *props, s=
truct iovec **caps,
>                                 struct iovec **metadata, struct bt_bap_qo=
s *qos)
>  {
>         const char *key;
> +       struct bt_bap_io_qos io_qos;
> +       bool broadcast =3D false;
>
>         while (dbus_message_iter_get_arg_type(props) =3D=3D DBUS_TYPE_DIC=
T_ENTRY) {
>                 DBusMessageIter value, entry;
> @@ -282,17 +298,27 @@ static int parse_properties(DBusMessageIter *props,=
 struct iovec **caps,
>                         if (var !=3D DBUS_TYPE_BYTE)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->cig_id)=
;
> +                       dbus_message_iter_get_basic(&value, &qos->ucast.c=
ig_id);
> +               } else if (!strcasecmp(key, "BIG")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value, &qos->bcast.b=
ig);
>                 } else if (!strcasecmp(key, "CIS")) {
>                         if (var !=3D DBUS_TYPE_BYTE)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->cis_id)=
;
> +                       dbus_message_iter_get_basic(&value, &qos->ucast.c=
is_id);
> +               } else if (!strcasecmp(key, "BIS")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value, &qos->bcast.b=
is);
>                 } else if (!strcasecmp(key, "Interval")) {
>                         if (var !=3D DBUS_TYPE_UINT32)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->interva=
l);
> +                       dbus_message_iter_get_basic(&value, &io_qos.inter=
val);
>                 } else if (!strcasecmp(key, "Framing")) {
>                         dbus_bool_t val;
>
> @@ -301,7 +327,7 @@ static int parse_properties(DBusMessageIter *props, s=
truct iovec **caps,
>
>                         dbus_message_iter_get_basic(&value, &val);
>
> -                       qos->framing =3D val;
> +                       qos->ucast.framing =3D val;
>                 } else if (!strcasecmp(key, "PHY")) {
>                         const char *str;
>
> @@ -311,42 +337,91 @@ static int parse_properties(DBusMessageIter *props,=
 struct iovec **caps,
>                         dbus_message_iter_get_basic(&value, &str);
>
>                         if (!strcasecmp(str, "1M"))
> -                               qos->phy =3D 0x01;
> +                               io_qos.phy =3D 0x01;
>                         else if (!strcasecmp(str, "2M"))
> -                               qos->phy =3D 0x02;
> +                               io_qos.phy =3D 0x02;
>                         else
>                                 goto fail;
>                 } else if (!strcasecmp(key, "SDU")) {
>                         if (var !=3D DBUS_TYPE_UINT16)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->sdu);
> +                       dbus_message_iter_get_basic(&value, &io_qos.sdu);
>                 } else if (!strcasecmp(key, "Retransmissions")) {
>                         if (var !=3D DBUS_TYPE_BYTE)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->rtn);
> +                       dbus_message_iter_get_basic(&value, &io_qos.rtn);
>                 } else if (!strcasecmp(key, "Latency")) {
>                         if (var !=3D DBUS_TYPE_UINT16)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->latency=
);
> +                       dbus_message_iter_get_basic(&value, &io_qos.laten=
cy);
>                 } else if (!strcasecmp(key, "Delay")) {
>                         if (var !=3D DBUS_TYPE_UINT32)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->delay);
> +                       dbus_message_iter_get_basic(&value, &qos->ucast.d=
elay);
>                 } else if (!strcasecmp(key, "TargetLatency")) {
>                         if (var !=3D DBUS_TYPE_BYTE)
>                                 goto fail;
>
>                         dbus_message_iter_get_basic(&value,
> -                                                       &qos->target_late=
ncy);
> +                                                       &qos->ucast.targe=
t_latency);
> +               } else if (!strcasecmp(key, "Encryption")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.encry=
ption);
> +                       DBG("Got Encryption for bcast");
> +                       broadcast =3D true;
> +               } else if (!strcasecmp(key, "Options")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.optio=
ns);
> +               } else if (!strcasecmp(key, "Skip")) {
> +                       if (var !=3D DBUS_TYPE_UINT16)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.skip)=
;
> +               } else if (!strcasecmp(key, "SyncTimeout")) {
> +                       if (var !=3D DBUS_TYPE_UINT16)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.sync_=
timeout);
> +               } else if (!strcasecmp(key, "SyncCteType")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.sync_=
cte_type);
> +               } else if (!strcasecmp(key, "MSE")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.mse);
> +               } else if (!strcasecmp(key, "Timeout")) {
> +                       if (var !=3D DBUS_TYPE_UINT16)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.timeo=
ut);
>                 }
>
>                 dbus_message_iter_next(props);
>         }
>
> +       if (broadcast)
> +               memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
> +       else
> +               memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
> +
>         return 0;
>
>  fail:
> @@ -456,8 +531,8 @@ static DBusMessage *set_configuration(DBusConnection =
*conn, DBusMessage *msg,
>         }
>
>         /* Mark CIG and CIS to be auto assigned */
> -       ep->qos.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> -       ep->qos.cis_id =3D BT_ISO_QOS_CIS_UNSET;
> +       ep->qos.ucast.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> +       ep->qos.ucast.cis_id =3D BT_ISO_QOS_CIS_UNSET;
>
>         if (parse_properties(&props, &ep->caps, &ep->metadata, &ep->qos) =
< 0) {
>                 DBG("Unable to parse properties");
> @@ -508,6 +583,8 @@ static void ep_free(void *data)
>
>         util_iov_free(ep->caps, 1);
>         util_iov_free(ep->metadata, 1);
> +       if (bt_bap_stream_get_type(ep->stream) =3D=3D BT_BAP_STREAM_TYPE_=
BROADCAST)
> +               util_iov_free(&ep->qos.bcast.bcode, 1);
>         free(ep->path);
>         free(ep);
>  }
> @@ -551,6 +628,11 @@ static struct bap_ep *ep_register(struct btd_service=
 *service,
>                 i =3D queue_length(data->srcs);
>                 suffix =3D "source";
>                 break;
> +       case BT_BAP_BROADCAST_SOURCE:
> +               queue =3D data->broadcast;
> +               i =3D queue_length(data->broadcast);
> +               suffix =3D "broadcast";
> +               break;
>         default:
>                 return NULL;
>         }
> @@ -609,12 +691,14 @@ static void bap_config(void *data, void *user_data)
>
>         ep->id =3D bt_bap_stream_config(ep->stream, &ep->qos, ep->caps,
>                                                 config_cb, ep);
> -       if (!ep->id) {
> -               DBG("Unable to config stream");
> -               util_iov_free(ep->caps, 1);
> -               ep->caps =3D NULL;
> -               util_iov_free(ep->metadata, 1);
> -               ep->metadata =3D NULL;
> +       if (bt_bap_stream_get_type(ep->stream) =3D=3D BT_BAP_STREAM_TYPE_=
UNICAST) {
> +               if (!ep->id) {
> +                       DBG("Unable to config stream");
> +                       util_iov_free(ep->caps, 1);
> +                       ep->caps =3D NULL;
> +                       util_iov_free(ep->metadata, 1);
> +                       ep->metadata =3D NULL;
> +               }
>         }
>
>         bt_bap_stream_set_user_data(ep->stream, ep->path);
> @@ -650,6 +734,7 @@ done:
>
>         queue_foreach(ep->data->srcs, bap_config, NULL);
>         queue_foreach(ep->data->snks, bap_config, NULL);
> +       queue_foreach(ep->data->broadcast, bap_config, NULL);
>  }
>
>  static bool pac_found(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> @@ -666,8 +751,13 @@ static bool pac_found(struct bt_bap_pac *lpac, struc=
t bt_bap_pac *rpac,
>                 return true;
>         }
>
> -       /* TODO: Cache LRU? */
> -       if (btd_service_is_initiator(service)) {
> +       if (bt_bap_pac_get_type(lpac) !=3D BT_BAP_BROADCAST_SOURCE) {
> +               /* TODO: Cache LRU? */
> +               if (btd_service_is_initiator(service)) {
> +                       if (!bt_bap_select(lpac, rpac, select_cb, ep))
> +                               ep->data->selecting++;
> +                       }
> +       } else {
>                 if (!bt_bap_select(lpac, rpac, select_cb, ep))
>                         ep->data->selecting++;
>         }
> @@ -698,11 +788,17 @@ static struct bap_ep *bap_find_ep_by_stream(struct =
bap_data *data,
>  {
>         struct bap_ep *ep;
>
> -       ep =3D queue_find(data->snks, match_ep_by_stream, stream);
> -       if (ep)
> -               return ep;
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_UNIC=
AST) {
> +               ep =3D queue_find(data->snks, match_ep_by_stream, stream)=
;
> +               if (ep)
> +                       return ep;
>
> -       return queue_find(data->srcs, match_ep_by_stream, stream);
> +               return queue_find(data->srcs, match_ep_by_stream, stream)=
;
> +       } else if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TY=
PE_BROADCAST) {
> +
> +               return queue_find(data->broadcast, match_ep_by_stream, st=
ream);
> +       } else
> +               return NULL;
>  }
>
>  static void iso_connect_cb(GIOChannel *chan, GError *err, gpointer user_=
data)
> @@ -734,11 +830,11 @@ static void bap_iso_qos(struct bt_bap_qos *qos, str=
uct bt_iso_io_qos *io)
>         if (!qos)
>                 return;
>
> -       io->interval =3D qos->interval;
> -       io->latency =3D qos->latency;
> -       io->sdu =3D qos->sdu;
> -       io->phy =3D qos->phy;
> -       io->rtn =3D qos->rtn;
> +       io->interval =3D qos->ucast.io_qos.interval;
> +       io->latency =3D qos->ucast.io_qos.latency;
> +       io->sdu =3D qos->ucast.io_qos.sdu;
> +       io->phy =3D qos->ucast.io_qos.phy;
> +       io->rtn =3D qos->ucast.io_qos.rtn;
>  }
>
>  static bool match_stream_qos(const void *data, const void *user_data)
> @@ -749,10 +845,10 @@ static bool match_stream_qos(const void *data, cons=
t void *user_data)
>
>         qos =3D bt_bap_stream_get_qos((void *)stream);
>
> -       if (iso_qos->ucast.cig !=3D qos->cig_id)
> +       if (iso_qos->ucast.cig !=3D qos->ucast.cig_id)
>                 return false;
>
> -       return iso_qos->ucast.cis =3D=3D qos->cis_id;
> +       return iso_qos->ucast.cis =3D=3D qos->ucast.cis_id;
>  }
>
>  static void iso_confirm_cb(GIOChannel *io, void *user_data)
> @@ -941,6 +1037,70 @@ static void bap_connect_io(struct bap_data *data, s=
truct bap_ep *ep,
>         bt_bap_stream_io_connecting(stream, g_io_channel_unix_get_fd(io))=
;
>  }
>
> +static void bap_connect_io_broadcast(struct bap_data *data, struct bap_e=
p *ep,
> +                               struct bt_bap_stream *stream,
> +                               struct bt_iso_qos *qos, int defer)
> +{
> +       struct btd_adapter *adapter =3D device_get_adapter(data->device);
> +       GIOChannel *io =3D NULL;
> +       GError *err =3D NULL;
> +       bdaddr_t dst_addr =3D {0};
> +       char addr[18];
> +       struct bt_iso_base base;
> +
> +       /* If IO already set and we are in the creation step, skip creati=
ng it again */
> +       if (bt_bap_stream_get_io(stream) && (defer =3D=3D true))
> +               return;
> +
> +       if (ep->io_id) {
> +               g_source_remove(ep->io_id);
> +               ep->io_id =3D 0;
> +       }
> +       base.base_len =3D ep->caps->iov_len;
> +
> +       memset(base.base, 0, 248);
> +       memcpy(base.base, ep->caps->iov_base, base.base_len);
> +       DBG("ep %p stream %p defer %s", ep, stream, defer ? "true" : "fal=
se");
> +       ba2str(btd_adapter_get_address(adapter), addr);
> +
> +       /* Just create socket and advance to the configured state (when d=
efer =3D true) */
> +       if (defer =3D=3D true) {
> +               io =3D bt_io_connect(bap_connect_io_cb, ep, NULL, &err,
> +                               BT_IO_OPT_SOURCE_BDADDR,
> +                               btd_adapter_get_address(adapter),
> +                               BT_IO_OPT_DEST_BDADDR,
> +                               &dst_addr,
> +                               BT_IO_OPT_DEST_TYPE,
> +                               BDADDR_LE_PUBLIC,
> +                               BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> +                               BT_IO_OPT_QOS, qos,
> +                               BT_IO_OPT_BASE, &base,
> +                               BT_IO_OPT_DEFER_TIMEOUT, defer,
> +                               BT_IO_OPT_INVALID);
> +
> +               if (!io) {
> +                       error("%s", err->message);
> +                       g_error_free(err);
> +                       return;
> +               }
> +
> +               ep->io_id =3D g_io_add_watch(io, G_IO_HUP | G_IO_ERR | G_=
IO_NVAL,
> +                               bap_io_disconnected, ep);
> +
> +               ep->io =3D io;
> +
> +               bt_bap_stream_io_connecting(stream, g_io_channel_unix_get=
_fd(io));
> +       } else { /* Advance stream state to Streaming */
> +               io =3D ep->io;
> +//             de-comment when streaming state is working in kernel
> +//             bt_io_broadcast_stream(&err, g_io_channel_unix_get_fd(io)=
,
> +//                             BT_IO_OPT_DEST_BDADDR, device_get_address=
(ep->data->device),
> +//                             BT_IO_OPT_DEST_TYPE, device_get_le_addres=
s_type(ep->data->device),
> +//                             BT_IO_OPT_QOS, qos,
> +//                             BT_IO_OPT_INVALID);

If code is not ready then Id just remove it and leave a TODO.

> +       }
> +}
> +
>  static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *s=
tream,
>                                                 struct bt_iso_qos *qos)
>  {
> @@ -987,20 +1147,44 @@ static void bap_create_io(struct bap_data *data, s=
truct bap_ep *ep,
>         if (!queue_find(data->streams, NULL, stream))
>                 queue_push_tail(data->streams, stream);
>
> -       if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) {
> -               error("bt_bap_stream_get_qos_links: failed");
> -               return;
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_UNIC=
AST) {
> +               if (!bt_bap_stream_io_get_qos(stream, &qos[0], &qos[1])) =
{
> +                       error("bt_bap_stream_get_qos_links: failed");
> +                       return;
> +               }
>         }
>
>         memset(&iso_qos, 0, sizeof(iso_qos));
> -       iso_qos.ucast.cig =3D qos[0] ? qos[0]->cig_id : qos[1]->cig_id;
> -       iso_qos.ucast.cis =3D qos[0] ? qos[0]->cis_id : qos[1]->cis_id;
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BROA=
DCAST) {
> +               if (defer =3D=3D true) {
> +                       iso_qos.bcast.big =3D ep->qos.bcast.big;
> +                       iso_qos.bcast.bis =3D ep->qos.bcast.bis;
> +                       iso_qos.bcast.sync_interval =3D ep->qos.bcast.syn=
c_interval;
> +                       iso_qos.bcast.packing =3D ep->qos.bcast.packing;
> +                       iso_qos.bcast.framing =3D ep->qos.bcast.framing;
> +                       iso_qos.bcast.encryption =3D ep->qos.bcast.encryp=
tion;
> +                       memcpy(iso_qos.bcast.bcode, ep->qos.bcast.bcode.i=
ov_base, 16);
> +                       iso_qos.bcast.options =3D ep->qos.bcast.options;
> +                       iso_qos.bcast.skip =3D ep->qos.bcast.skip;
> +                       iso_qos.bcast.sync_timeout =3D ep->qos.bcast.sync=
_timeout;
> +                       iso_qos.bcast.sync_cte_type =3D ep->qos.bcast.syn=
c_cte_type;
> +                       iso_qos.bcast.mse =3D ep->qos.bcast.mse;
> +                       iso_qos.bcast.timeout =3D ep->qos.bcast.timeout;
> +                       memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,=
 sizeof(struct bt_iso_io_qos));
> +               }
> +       } else {
> +               iso_qos.ucast.cig =3D qos[0] ? qos[0]->ucast.cig_id : qos=
[1]->ucast.cig_id;
> +               iso_qos.ucast.cis =3D qos[0] ? qos[0]->ucast.cis_id : qos=
[1]->ucast.cis_id;
>
> -       bap_iso_qos(qos[0], &iso_qos.ucast.in);
> -       bap_iso_qos(qos[1], &iso_qos.ucast.out);
> +               bap_iso_qos(qos[0], &iso_qos.ucast.in);
> +               bap_iso_qos(qos[1], &iso_qos.ucast.out);
> +       }
>
>         if (ep)
> -               bap_connect_io(data, ep, stream, &iso_qos, defer);
> +               if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_T=
YPE_BROADCAST)
> +                       bap_connect_io_broadcast(data, ep, stream, &iso_q=
os, defer);
> +               else
> +                       bap_connect_io(data, ep, stream, &iso_qos, defer)=
;
>         else
>                 bap_listen_io(data, stream, &iso_qos);
>  }
> @@ -1039,12 +1223,14 @@ static void bap_state(struct bt_bap_stream *strea=
m, uint8_t old_state,
>                         }
>
>
> -                       /* Wait QoS response to respond */
> -                       ep->id =3D bt_bap_stream_qos(stream, &ep->qos, qo=
s_cb,
> -                                                                       e=
p);
> -                       if (!ep->id) {
> -                               error("Failed to Configure QoS");
> -                               bt_bap_stream_release(stream, NULL, NULL)=
;
> +                       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_=
STREAM_TYPE_UNICAST) {
> +                               /* Wait QoS response to respond */
> +                               ep->id =3D bt_bap_stream_qos(stream, &ep-=
>qos, qos_cb,
> +                                                                        =
       ep);
> +                               if (!ep->id) {
> +                                       error("Failed to Configure QoS");
> +                                       bt_bap_stream_release(stream, NUL=
L, NULL);
> +                               }
>                         }
>                 }
>                 break;
> @@ -1055,6 +1241,12 @@ static void bap_state(struct bt_bap_stream *stream=
, uint8_t old_state,
>                 if (ep)
>                         bap_create_io(data, ep, stream, false);
>                 break;
> +       case BT_BAP_STREAM_STATE_STREAMING:
> +               if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_T=
YPE_BROADCAST) {
> +                       if (ep)
> +                               bap_create_io(data, ep, stream, false);
> +               }
> +               break;
>         }
>  }
>
> @@ -1074,6 +1266,20 @@ static void pac_added(struct bt_bap_pac *pac, void=
 *user_data)
>         bt_bap_foreach_pac(data->bap, BT_BAP_SINK, pac_found, service);
>  }
>
> +static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
> +{
> +       struct btd_service *service =3D user_data;
> +       struct bap_data *data;
> +
> +       if (bt_bap_pac_get_type(pac) =3D=3D BT_BAP_BROADCAST_SOURCE) {
> +               DBG("pac %p", pac);
> +
> +               data =3D btd_service_get_user_data(service);
> +
> +               bt_bap_foreach_pac(data->bap, BT_BAP_BROADCAST_SOURCE, pa=
c_found, service);
> +       }
> +}
> +
>  static bool ep_match_pac(const void *data, const void *match_data)
>  {
>         const struct bap_ep *ep =3D data;
> @@ -1114,6 +1320,38 @@ static void pac_removed(struct bt_bap_pac *pac, vo=
id *user_data)
>         ep_unregister(ep);
>  }
>
> +static void pac_removed_broadcast(struct bt_bap_pac *pac, void *user_dat=
a)
> +{
> +       struct btd_service *service =3D user_data;
> +       struct bap_data *data;
> +       struct queue *queue;
> +       struct bap_ep *ep;
> +
> +       DBG("pac %p", pac);
> +
> +       data =3D btd_service_get_user_data(service);
> +
> +       switch (bt_bap_pac_get_type(pac)) {
> +       case BT_BAP_SINK:
> +               queue =3D data->srcs;
> +               break;
> +       case BT_BAP_SOURCE:
> +               queue =3D data->snks;
> +               break;
> +       case BT_BAP_BROADCAST_SOURCE:
> +               queue =3D data->broadcast;
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       ep =3D queue_remove_if(queue, ep_match_pac, pac);
> +       if (!ep)
> +               return;
> +
> +       ep_unregister(ep);
> +}
> +
>  static struct bap_data *bap_data_new(struct btd_device *device)
>  {
>         struct bap_data *data;
> @@ -1122,6 +1360,7 @@ static struct bap_data *bap_data_new(struct btd_dev=
ice *device)
>         data->device =3D device;
>         data->srcs =3D queue_new();
>         data->snks =3D queue_new();
> +       data->broadcast =3D queue_new();
>
>         return data;
>  }
> @@ -1154,6 +1393,14 @@ static bool match_data(const void *data, const voi=
d *match_data)
>         return bdata->bap =3D=3D bap;
>  }
>
> +static bool match_data_bap_data(const void *data, const void *match_data=
)
> +{
> +       const struct bap_data *bdata =3D data;
> +       const struct btd_adapter *adapter =3D match_data;
> +
> +       return bdata->user_data =3D=3D adapter;
> +}
> +
>  static void bap_connecting(struct bt_bap_stream *stream, bool state, int=
 fd,
>                                                         void *user_data)
>  {
> @@ -1178,26 +1425,49 @@ static void bap_connecting(struct bt_bap_stream *=
stream, bool state, int fd,
>
>         g_io_channel_set_close_on_unref(io, FALSE);
>
> -       /* Attempt to get CIG/CIS if they have not been set */
> -       if (ep->qos.cig_id =3D=3D BT_ISO_QOS_CIG_UNSET ||
> -                               ep->qos.cis_id =3D=3D BT_ISO_QOS_CIS_UNSE=
T) {
> -               struct bt_iso_qos qos;
> -               GError *err =3D NULL;
> +       if (bt_bap_stream_get_type(ep->stream) =3D=3D BT_BAP_STREAM_TYPE_=
UNICAST) {
> +               /* Attempt to get CIG/CIS if they have not been set */
> +               if (ep->qos.ucast.cig_id =3D=3D BT_ISO_QOS_CIG_UNSET ||
> +                                       ep->qos.ucast.cis_id =3D=3D BT_IS=
O_QOS_CIS_UNSET) {
> +                       struct bt_iso_qos qos;
> +                       GError *err =3D NULL;
> +
> +                       if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
> +                                               BT_IO_OPT_INVALID)) {
> +                               error("%s", err->message);
> +                               g_error_free(err);
> +                               g_io_channel_unref(io);
> +                               return;
> +                       }
>
> -               if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
> -                                       BT_IO_OPT_INVALID)) {
> -                       error("%s", err->message);
> -                       g_error_free(err);
> -                       g_io_channel_unref(io);
> -                       return;
> +                       ep->qos.ucast.cig_id =3D qos.ucast.cig;
> +                       ep->qos.ucast.cis_id =3D qos.ucast.cis;
>                 }
>
> -               ep->qos.cig_id =3D qos.ucast.cig;
> -               ep->qos.cis_id =3D qos.ucast.cis;
> -       }
> +               DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
> +                                               ep->qos.ucast.cig_id, ep-=
>qos.ucast.cis_id);
> +       } else if (bt_bap_stream_get_type(ep->stream) =3D=3D BT_BAP_STREA=
M_TYPE_BROADCAST) {
> +               /* Attempt to get BIG/BIS if they have not been set */
> +               if (ep->qos.bcast.big =3D=3D BT_ISO_QOS_BIG_UNSET ||
> +                                       ep->qos.bcast.bis =3D=3D BT_ISO_Q=
OS_BIS_UNSET) {
> +                       struct bt_iso_qos qos;
> +                       GError *err =3D NULL;
> +
> +                       if (!bt_io_get(io, &err, BT_IO_OPT_QOS, &qos,
> +                                               BT_IO_OPT_INVALID)) {
> +                               error("%s", err->message);
> +                               g_error_free(err);
> +                               g_io_channel_unref(io);
> +                               return;
> +                       }
> +
> +                       ep->qos.bcast.big =3D qos.bcast.big;
> +                       ep->qos.bcast.bis =3D qos.bcast.bis;
> +               }
>
> -       DBG("stream %p fd %d: CIG 0x%02x CIS 0x%02x", stream, fd,
> -                                       ep->qos.cig_id, ep->qos.cis_id);
> +               DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
> +                                               ep->qos.bcast.big, ep->qo=
s.bcast.bis);
> +       }
>  }
>
>  static void bap_attached(struct bt_bap *bap, void *user_data)
> @@ -1345,6 +1615,68 @@ static int bap_disconnect(struct btd_service *serv=
ice)
>         return 0;
>  }
>
> +static int bap_adapter_probe(struct btd_profile *p,
> +                               struct btd_adapter *adapter)
> +{
> +       struct btd_device *device =3D btd_adapter_get_device(adapter, BDA=
DDR_ANY, BDADDR_LE_PUBLIC);
> +       struct btd_gatt_database *database =3D btd_adapter_get_database(a=
dapter);
> +       struct btd_service *service =3D service_create(device, p);
> +       struct bap_data *data;
> +       char addr[18];
> +
> +       ba2str(device_get_address(device), addr);
> +       DBG("%s", addr);
> +
> +       if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
> +               error("BAP requires ISO Socket which is not enabled");
> +               return -ENOTSUP;
> +       }
> +
> +       data =3D bap_data_new(device);
> +       data->service =3D service;
> +
> +       data->bap =3D bt_bap_new(btd_gatt_database_get_db(database),
> +                                       btd_device_get_gatt_db(device));
> +       if (!data->bap) {
> +               error("Unable to create BAP instance");
> +               free(data);
> +               return -EINVAL;
> +       }
> +
> +       bap_data_add(data);
> +
> +       if (!bt_bap_attach_broadcast(data->bap)) {
> +               error("BAP unable to attach");
> +               return -EINVAL;
> +       }
> +
> +       data->state_id =3D bt_bap_state_register(data->bap, bap_state,
> +                                               bap_connecting, data, NUL=
L);
> +       data->pac_id =3D bt_bap_pac_register(data->bap, pac_added_broadca=
st,
> +                                               pac_removed_broadcast, se=
rvice, NULL);
> +
> +       bt_bap_set_user_data(data->bap, service);
> +       bap_data_set_user_data(data, adapter);
> +       return 0;
> +}
> +
> +static void bap_adapter_remove(struct btd_profile *p,
> +                                       struct btd_adapter *adapter)
> +{
> +       struct bap_data *data =3D queue_find(sessions, match_data_bap_dat=
a, adapter);
> +       char addr[18];
> +
> +       ba2str(btd_adapter_get_address(adapter), addr);
> +       DBG("%s", addr);
> +
> +       if (!data) {
> +               error("BAP service not handled by profile");
> +               return;
> +       }
> +
> +       bap_data_remove(data);
> +}
> +
>  static struct btd_profile bap_profile =3D {
>         .name           =3D "bap",
>         .priority       =3D BTD_PROFILE_PRIORITY_MEDIUM,
> @@ -1353,6 +1685,8 @@ static struct btd_profile bap_profile =3D {
>         .device_remove  =3D bap_remove,
>         .accept         =3D bap_accept,
>         .disconnect     =3D bap_disconnect,
> +       .adapter_probe  =3D bap_adapter_probe,
> +       .adapter_remove =3D bap_adapter_remove,
>         .auto_connect   =3D true,
>  };
>
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index 6ce668e31..4c7402fe9 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -6,7 +6,7 @@
>   *  Copyright (C) 2006-2007  Nokia Corporation
>   *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
>   *  Copyright (C) 2011  BMW Car IT GmbH. All rights reserved.
> - *
> + *  Copyright 2023 NXP
>   *
>   */
>
> @@ -748,7 +748,11 @@ static int parse_select_properties(DBusMessageIter *=
props, struct iovec *caps,
>                                         struct bt_bap_qos *qos)
>  {
>         const char *key;
> +       struct bt_bap_io_qos io_qos;
> +       uint8_t framing =3D 0;
> +       bool broadcast =3D false;
>
> +       memset(&io_qos, 0, sizeof(io_qos));
>         while (dbus_message_iter_get_arg_type(props) =3D=3D DBUS_TYPE_DIC=
T_ENTRY) {
>                 DBusMessageIter value, entry;
>                 int var;
> @@ -777,17 +781,27 @@ static int parse_select_properties(DBusMessageIter =
*props, struct iovec *caps,
>                         if (var !=3D DBUS_TYPE_BYTE)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->cig_id)=
;
> +                       dbus_message_iter_get_basic(&value, &qos->ucast.c=
ig_id);
> +               } else if (!strcasecmp(key, "BIG")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value, &qos->bcast.b=
ig);
>                 } else if (!strcasecmp(key, "CIS")) {
>                         if (var !=3D DBUS_TYPE_BYTE)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->cis_id)=
;
> +                       dbus_message_iter_get_basic(&value, &qos->ucast.c=
ig_id);
> +               } else if (!strcasecmp(key, "BIS")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value, &qos->bcast.b=
is);
>                 } else if (!strcasecmp(key, "Interval")) {
>                         if (var !=3D DBUS_TYPE_UINT32)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->interva=
l);
> +                       dbus_message_iter_get_basic(&value, &io_qos.inter=
val);
>                 } else if (!strcasecmp(key, "Framing")) {
>                         dbus_bool_t val;
>
> @@ -796,7 +810,7 @@ static int parse_select_properties(DBusMessageIter *p=
rops, struct iovec *caps,
>
>                         dbus_message_iter_get_basic(&value, &val);
>
> -                       qos->framing =3D val;
> +                       framing =3D val;
>                 } else if (!strcasecmp(key, "PHY")) {
>                         const char *str;
>
> @@ -806,42 +820,106 @@ static int parse_select_properties(DBusMessageIter=
 *props, struct iovec *caps,
>                         dbus_message_iter_get_basic(&value, &str);
>
>                         if (!strcasecmp(str, "1M"))
> -                               qos->phy =3D 0x01;
> +                               io_qos.phy =3D 0x01;
>                         else if (!strcasecmp(str, "2M"))
> -                               qos->phy =3D 0x02;
> +                               io_qos.phy =3D 0x02;
>                         else
>                                 goto fail;
>                 } else if (!strcasecmp(key, "SDU")) {
>                         if (var !=3D DBUS_TYPE_UINT16)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->sdu);
> +                       dbus_message_iter_get_basic(&value, &io_qos.sdu);
>                 } else if (!strcasecmp(key, "Retransmissions")) {
>                         if (var !=3D DBUS_TYPE_BYTE)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->rtn);
> +                       dbus_message_iter_get_basic(&value, &io_qos.rtn);
>                 } else if (!strcasecmp(key, "Latency")) {
>                         if (var !=3D DBUS_TYPE_UINT16)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->latency=
);
> +                       dbus_message_iter_get_basic(&value, &io_qos.laten=
cy);
>                 } else if (!strcasecmp(key, "Delay")) {
>                         if (var !=3D DBUS_TYPE_UINT32)
>                                 goto fail;
>
> -                       dbus_message_iter_get_basic(&value, &qos->delay);
> +                       dbus_message_iter_get_basic(&value, &qos->ucast.d=
elay);
>                 } else if (!strcasecmp(key, "TargetLatency")) {
>                         if (var !=3D DBUS_TYPE_BYTE)
>                                 goto fail;
>
>                         dbus_message_iter_get_basic(&value,
> -                                                       &qos->target_late=
ncy);
> +                                                       &qos->ucast.targe=
t_latency);
> +               } else if (!strcasecmp(key, "Encryption")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.encry=
ption);
> +                       broadcast =3D true;
> +               } else if (!strcasecmp(key, "Options")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.optio=
ns);
> +               } else if (!strcasecmp(key, "Skip")) {
> +                       if (var !=3D DBUS_TYPE_UINT16)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.skip)=
;
> +               } else if (!strcasecmp(key, "SyncTimeout")) {
> +                       if (var !=3D DBUS_TYPE_UINT16)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.sync_=
timeout);
> +               } else if (!strcasecmp(key, "SyncCteType")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.sync_=
cte_type);
> +
> +               } else if (!strcasecmp(key, "SyncInterval")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.sync_=
interval);
> +               } else if (!strcasecmp(key, "MSE")) {
> +                       if (var !=3D DBUS_TYPE_BYTE)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.mse);
> +               } else if (!strcasecmp(key, "Timeout")) {
> +                       if (var !=3D DBUS_TYPE_UINT16)
> +                               goto fail;
> +
> +                       dbus_message_iter_get_basic(&value,
> +                                                       &qos->bcast.timeo=
ut);
> +               } else if (!strcasecmp(key, "BroadcastCode")) {
> +                       if (var !=3D DBUS_TYPE_ARRAY)
> +                               goto fail;
> +
> +                       parse_array(&value, &qos->bcast.bcode);
>                 }
>
>                 dbus_message_iter_next(props);
>         }
>
> +       if (broadcast) {
> +               memcpy(&qos->bcast.io_qos, &io_qos, sizeof(io_qos));
> +               qos->bcast.framing =3D framing;
> +
> +       } else {
> +               memcpy(&qos->ucast.io_qos, &io_qos, sizeof(io_qos));
> +               qos->ucast.framing =3D framing;
> +       }
> +
>         return 0;
>
>  fail:
> @@ -875,8 +953,8 @@ static void pac_select_cb(struct media_endpoint *endp=
oint, void *ret, int size,
>         memset(&qos, 0, sizeof(qos));
>
>         /* Mark CIG and CIS to be auto assigned */
> -       qos.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> -       qos.cis_id =3D BT_ISO_QOS_CIS_UNSET;
> +       qos.ucast.cig_id =3D BT_ISO_QOS_CIG_UNSET;
> +       qos.ucast.cis_id =3D BT_ISO_QOS_CIS_UNSET;
>
>         memset(&caps, 0, sizeof(caps));
>         memset(&meta, 0, sizeof(meta));
> @@ -1166,15 +1244,13 @@ static bool endpoint_init_pac(struct media_endpoi=
nt *endpoint, uint8_t type,
>
>         endpoint->pac =3D bt_bap_add_vendor_pac(db, name, type, endpoint-=
>codec,
>                                 endpoint->cid, endpoint->vid, &endpoint->=
qos,
> -                               &data, metadata);
> +                               &data, metadata, &pac_ops, endpoint);
>         if (!endpoint->pac) {
>                 error("Unable to create PAC");
>                 free(metadata);
>                 return false;
>         }
>
> -       bt_bap_pac_set_ops(endpoint->pac, &pac_ops, endpoint);
> -
>         DBG("PAC %s registered", name);
>
>         free(name);
> @@ -1193,6 +1269,11 @@ static bool endpoint_init_pac_source(struct media_=
endpoint *endpoint, int *err)
>         return endpoint_init_pac(endpoint, BT_BAP_SOURCE, err);
>  }
>
> +static bool endpoint_init_broadcast_source(struct media_endpoint *endpoi=
nt, int *err)
> +{
> +       return endpoint_init_pac(endpoint, BT_BAP_BROADCAST_SOURCE, err);
> +}
> +
>  static bool endpoint_properties_exists(const char *uuid,
>                                                 struct btd_device *dev,
>                                                 void *user_data)
> @@ -1295,6 +1376,18 @@ static bool experimental_endpoint_supported(struct=
 btd_adapter *adapter)
>         return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
>  }
>
> +static bool experimental_broadcaster_ep_supported(struct btd_adapter *ad=
apter)
> +{
> +
> +       if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET))
> +               return false;
> +
> +       if (!btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_BROADCAST=
ER))
> +               return false;
> +
> +       return g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL;
> +}
> +
>  static struct media_endpoint_init {
>         const char *uuid;
>         bool (*func)(struct media_endpoint *endpoint, int *err);
> @@ -1308,6 +1401,8 @@ static struct media_endpoint_init {
>                                 experimental_endpoint_supported },
>         { PAC_SOURCE_UUID, endpoint_init_pac_source,
>                                 experimental_endpoint_supported },
> +       { BROADCAST_AUDIO_ANNOUNCEMENT_SERVICE_UUID, endpoint_init_broadc=
ast_source,
> +                       experimental_broadcaster_ep_supported },
>  };
>
>  static struct media_endpoint *
> diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
> index 9172d167e..a055e4f05 100644
> --- a/profiles/audio/transport.c
> +++ b/profiles/audio/transport.c
> @@ -5,6 +5,7 @@
>   *
>   *  Copyright (C) 2006-2007  Nokia Corporation
>   *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright 2023 NXP
>   *
>   *
>   */
> @@ -525,6 +526,13 @@ static void media_owner_add(struct media_owner *owne=
r,
>         owner->pending =3D req;
>  }
>
> +static void *get_stream_bap(struct media_transport *transport)
> +{
> +       struct bap_transport *bap =3D transport->data;
> +
> +       return bap->stream;
> +}
> +
>  static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
>                                         void *data)
>  {
> @@ -540,15 +548,22 @@ static DBusMessage *acquire(DBusConnection *conn, D=
BusMessage *msg,
>                 return btd_error_not_authorized(msg);
>
>         owner =3D media_owner_create(msg);
> +       if (bt_bap_stream_get_type(get_stream_bap(transport)) =3D=3D BT_B=
AP_STREAM_TYPE_BROADCAST) {
> +               req =3D media_request_create(msg, 0x00);
> +               media_owner_add(owner, req);
> +               media_transport_set_owner(transport, owner);
> +       }
>         id =3D transport->resume(transport, owner);
>         if (id =3D=3D 0) {
>                 media_owner_free(owner);
>                 return btd_error_not_authorized(msg);
>         }
>
> -       req =3D media_request_create(msg, id);
> -       media_owner_add(owner, req);
> -       media_transport_set_owner(transport, owner);
> +       if (bt_bap_stream_get_type(get_stream_bap(transport)) =3D=3D BT_B=
AP_STREAM_TYPE_UNICAST) {
> +               req =3D media_request_create(msg, id);
> +               media_owner_add(owner, req);
> +               media_transport_set_owner(transport, owner);
> +       }
>
>         return NULL;
>  }
> @@ -828,7 +843,7 @@ static gboolean qos_exists(const GDBusPropertyTable *=
property, void *data)
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
>
> -       return bap->qos.phy !=3D 0x00;
> +       return bap->qos.ucast.io_qos.phy !=3D 0x00;
>  }
>
>  static gboolean get_cig(const GDBusPropertyTable *property,
> @@ -838,7 +853,7 @@ static gboolean get_cig(const GDBusPropertyTable *pro=
perty,
>         struct bap_transport *bap =3D transport->data;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> -                                                       &bap->qos.cig_id)=
;
> +                                                       &bap->qos.ucast.c=
ig_id);
>
>         return TRUE;
>  }
> @@ -850,7 +865,7 @@ static gboolean get_cis(const GDBusPropertyTable *pro=
perty,
>         struct bap_transport *bap =3D transport->data;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE,
> -                                                       &bap->qos.cis_id)=
;
> +                                                       &bap->qos.ucast.c=
is_id);
>
>         return TRUE;
>  }
> @@ -862,7 +877,7 @@ static gboolean get_interval(const GDBusPropertyTable=
 *property,
>         struct bap_transport *bap =3D transport->data;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
> -                                                       &bap->qos.interva=
l);
> +                                                       &bap->qos.ucast.i=
o_qos.interval);
>
>         return TRUE;
>  }
> @@ -872,7 +887,7 @@ static gboolean get_framing(const GDBusPropertyTable =
*property,
>  {
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
> -       dbus_bool_t val =3D bap->qos.framing;
> +       dbus_bool_t val =3D bap->qos.ucast.framing;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
>
> @@ -885,7 +900,7 @@ static gboolean get_phy(const GDBusPropertyTable *pro=
perty,
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
>
> -       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.ph=
y);
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.uc=
ast.io_qos.phy);
>
>         return TRUE;
>  }
> @@ -896,7 +911,7 @@ static gboolean get_sdu(const GDBusPropertyTable *pro=
perty,
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
>
> -       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->qos.=
sdu);
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &bap->qos.=
ucast.io_qos.sdu);
>
>         return TRUE;
>  }
> @@ -907,7 +922,7 @@ static gboolean get_retransmissions(const GDBusProper=
tyTable *property,
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
>
> -       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.rt=
n);
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &bap->qos.uc=
ast.io_qos.rtn);
>
>         return TRUE;
>  }
> @@ -919,7 +934,7 @@ static gboolean get_latency(const GDBusPropertyTable =
*property,
>         struct bap_transport *bap =3D transport->data;
>
>         dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16,
> -                                                       &bap->qos.latency=
);
> +                                                       &bap->qos.ucast.i=
o_qos.latency);
>
>         return TRUE;
>  }
> @@ -930,7 +945,7 @@ static gboolean get_delay(const GDBusPropertyTable *p=
roperty,
>         struct media_transport *transport =3D data;
>         struct bap_transport *bap =3D transport->data;
>
> -       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->qos.=
delay);
> +       dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32, &bap->qos.=
ucast.delay);
>
>         return TRUE;
>  }
> @@ -1478,13 +1493,6 @@ static void bap_connecting(struct bt_bap_stream *s=
tream, bool state, int fd,
>         bap_update_links(transport);
>  }
>
> -static void *get_stream_bap(struct media_transport *transport)
> -{
> -       struct bap_transport *bap =3D transport->data;
> -
> -       return bap->stream;
> -}
> -
>  static void free_bap(void *data)
>  {
>         struct bap_transport *bap =3D data;
> @@ -1555,7 +1563,8 @@ struct media_transport *media_transport_create(stru=
ct btd_device *device,
>                         goto fail;
>                 properties =3D a2dp_properties;
>         } else if (!strcasecmp(uuid, PAC_SINK_UUID) ||
> -                               !strcasecmp(uuid, PAC_SOURCE_UUID)) {
> +                               !strcasecmp(uuid, PAC_SOURCE_UUID) ||
> +                               !strcasecmp(uuid, BROADCAST_AUDIO_ANNOUNC=
EMENT_SERVICE_UUID)) {
>                 if (media_transport_init_bap(transport, stream) < 0)
>                         goto fail;
>                 properties =3D bap_properties;
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 6131c3128..54d72cf35 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -4,6 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> + *  Copyright 2023 NXP
>   *
>   */
>
> @@ -120,6 +121,8 @@ struct bt_bap_db {
>         struct bt_ascs *ascs;
>         struct queue *sinks;
>         struct queue *sources;
> +       struct queue *broadcast_sources;
> +       struct queue *broadcast_sinks;
>  };
>
>  struct bt_bap_req {
> @@ -622,6 +625,18 @@ static struct bt_bap_endpoint *bap_endpoint_new(stru=
ct bt_bap_db *bdb,
>         return ep;
>  }
>
> +static struct bt_bap_endpoint *bap_endpoint_new_broacast(struct bt_bap_d=
b *bdb)
> +{
> +       struct bt_bap_endpoint *ep;
> +
> +       ep =3D new0(struct bt_bap_endpoint, 1);
> +       ep->bdb =3D bdb;
> +       ep->attr =3D NULL;
> +       ep->dir =3D BT_BAP_BROADCAST_SOURCE;
> +
> +       return ep;
> +}
> +
>  static struct bt_bap_endpoint *bap_get_endpoint(struct queue *endpoints,
>                                                 struct bt_bap_db *db,
>                                                 struct gatt_db_attribute =
*attr)
> @@ -644,6 +659,26 @@ static struct bt_bap_endpoint *bap_get_endpoint(stru=
ct queue *endpoints,
>         return ep;
>  }
>
> +static struct bt_bap_endpoint *bap_get_endpoint_broadcast(struct queue *=
endpoints,
> +                                               struct bt_bap_db *db)
> +{
> +       struct bt_bap_endpoint *ep;
> +
> +       if (!db)
> +               return NULL;
> +
> +       if (queue_length(endpoints) > 0)
> +               return queue_peek_head(endpoints);
> +
> +       ep =3D bap_endpoint_new_broacast(db);
> +       if (!ep)
> +               return NULL;
> +
> +       queue_push_tail(endpoints, ep);
> +
> +       return ep;
> +}
> +
>  static bool bap_endpoint_match_id(const void *data, const void *match_da=
ta)
>  {
>         const struct bt_bap_endpoint *ep =3D data;
> @@ -861,15 +896,15 @@ static void stream_notify_qos(struct bt_bap_stream =
*stream)
>         status->state =3D ep->state;
>
>         qos =3D (void *)status->params;
> -       qos->cis_id =3D stream->qos.cis_id;
> -       qos->cig_id =3D stream->qos.cig_id;
> -       put_le24(stream->qos.interval, qos->interval);
> -       qos->framing =3D stream->qos.framing;
> -       qos->phy =3D stream->qos.phy;
> -       qos->sdu =3D cpu_to_le16(stream->qos.sdu);
> -       qos->rtn =3D stream->qos.rtn;
> -       qos->latency =3D cpu_to_le16(stream->qos.latency);
> -       put_le24(stream->qos.delay, qos->pd);
> +       qos->cis_id =3D stream->qos.ucast.cis_id;
> +       qos->cig_id =3D stream->qos.ucast.cig_id;
> +       put_le24(stream->qos.ucast.io_qos.interval, qos->interval);
> +       qos->framing =3D stream->qos.ucast.framing;
> +       qos->phy =3D stream->qos.ucast.io_qos.phy;
> +       qos->sdu =3D cpu_to_le16(stream->qos.ucast.io_qos.sdu);
> +       qos->rtn =3D stream->qos.ucast.io_qos.rtn;
> +       qos->latency =3D cpu_to_le16(stream->qos.ucast.io_qos.latency);
> +       put_le24(stream->qos.ucast.delay, qos->pd);
>
>         gatt_db_attribute_notify(ep->attr, (void *) status, len,
>                                         bt_bap_get_att(stream->bap));
> @@ -898,8 +933,8 @@ static void stream_notify_metadata(struct bt_bap_stre=
am *stream)
>         status->state =3D ep->state;
>
>         meta =3D (void *)status->params;
> -       meta->cis_id =3D stream->qos.cis_id;
> -       meta->cig_id =3D stream->qos.cig_id;
> +       meta->cis_id =3D stream->qos.ucast.cis_id;
> +       meta->cig_id =3D stream->qos.ucast.cig_id;
>
>         if (stream->meta) {
>                 meta->len =3D stream->meta->iov_len;
> @@ -1245,6 +1280,36 @@ static void bap_stream_state_changed(struct bt_bap=
_stream *stream)
>         bt_bap_unref(bap);
>  }
>
> +static void stream_set_state_broadcast(struct bt_bap_stream *stream, uin=
t8_t state)
> +{
> +       struct bt_bap_endpoint *ep =3D stream->ep;
> +       struct bt_bap *bap =3D stream->bap;
> +       const struct queue_entry *entry;
> +
> +       ep->old_state =3D ep->state;
> +       ep->state =3D state;
> +
> +       bt_bap_ref(bap);
> +
> +       for (entry =3D queue_get_entries(bap->state_cbs); entry;
> +                                                       entry =3D entry->=
next) {
> +               struct bt_bap_state *state =3D entry->data;
> +
> +               if (state->func)
> +                       state->func(stream, stream->ep->old_state,
> +                                       stream->ep->state, state->data);
> +       }
> +
> +       /* Post notification updates */
> +       switch (stream->ep->state) {
> +       case BT_ASCS_ASE_STATE_IDLE:
> +               bap_stream_detach(stream);
> +               break;
> +       }
> +
> +       bt_bap_unref(bap);
> +}
> +
>  static void stream_set_state(struct bt_bap_stream *stream, uint8_t state=
)
>  {
>         struct bt_bap_endpoint *ep =3D stream->ep;
> @@ -1381,6 +1446,11 @@ static void ep_config_cb(struct bt_bap_stream *str=
eam, int err)
>         if (err)
>                 return;
>
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BROA=
DCAST)     {
> +               stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_CO=
NFIG);
> +               return;
> +       }
> +
>         stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>  }
>
> @@ -1560,20 +1630,20 @@ static uint8_t ascs_qos(struct bt_ascs *ascs, str=
uct bt_bap *bap,
>
>         memset(&qos, 0, sizeof(qos));
>
> -       qos.cig_id =3D req->cig;
> -       qos.cis_id =3D req->cis;
> -       qos.interval =3D get_le24(req->interval);
> -       qos.framing =3D req->framing;
> -       qos.phy =3D req->phy;
> -       qos.sdu =3D le16_to_cpu(req->sdu);
> -       qos.rtn =3D req->rtn;
> -       qos.latency =3D le16_to_cpu(req->latency);
> -       qos.delay =3D get_le24(req->pd);
> +       qos.ucast.cig_id =3D req->cig;
> +       qos.ucast.cis_id =3D req->cis;
> +       qos.ucast.io_qos.interval =3D get_le24(req->interval);
> +       qos.ucast.framing =3D req->framing;
> +       qos.ucast.io_qos.phy =3D req->phy;
> +       qos.ucast.io_qos.sdu =3D le16_to_cpu(req->sdu);
> +       qos.ucast.io_qos.rtn =3D req->rtn;
> +       qos.ucast.io_qos.latency =3D le16_to_cpu(req->latency);
> +       qos.ucast.delay =3D get_le24(req->pd);
>
>         DBG(bap, "CIG 0x%02x CIS 0x%02x interval %u framing 0x%02x "
>                         "phy 0x%02x SDU %u rtn %u latency %u pd %u",
> -                       req->cig, req->cis, qos.interval, qos.framing, qo=
s.phy,
> -                       qos.sdu, qos.rtn, qos.latency, qos.delay);
> +                       req->cig, req->cis, qos.ucast.io_qos.interval, qo=
s.ucast.framing, qos.ucast.io_qos.phy,
> +                       qos.ucast.io_qos.sdu, qos.ucast.io_qos.rtn, qos.u=
cast.io_qos.latency, qos.ucast.delay);
>
>         ep =3D bap_get_local_endpoint_id(bap, req->ase);
>         if (!ep) {
> @@ -2204,6 +2274,8 @@ static struct bt_bap_db *bap_db_new(struct gatt_db =
*db)
>         bdb->db =3D gatt_db_ref(db);
>         bdb->sinks =3D queue_new();
>         bdb->sources =3D queue_new();
> +       bdb->broadcast_sources =3D queue_new();
> +       bdb->broadcast_sinks =3D queue_new();
>
>         if (!bap_db)
>                 bap_db =3D queue_new();
> @@ -2379,6 +2451,16 @@ static void bap_add_source(struct bt_bap_pac *pac)
>                                 iov.iov_len, NULL);
>  }
>
> +static void bap_add_broadcast_source(struct bt_bap_pac *pac)
> +{
> +       queue_push_tail(pac->bdb->broadcast_sources, pac);
> +}
> +
> +static void bap_add_broadcast_sink(struct bt_bap_pac *pac)
> +{
> +       queue_push_tail(pac->bdb->broadcast_sinks, pac);
> +}
> +
>  static void notify_pac_added(void *data, void *user_data)
>  {
>         struct bt_bap_pac_changed *changed =3D data;
> @@ -2400,10 +2482,12 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct g=
att_db *db,
>                                         uint8_t id, uint16_t cid, uint16_=
t vid,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata)
> +                                       struct iovec *metadata,
> +                                       struct bt_bap_pac_ops *pac_ops,
> +                                       void *user_data)
>  {
>         struct bt_bap_db *bdb;
> -       struct bt_bap_pac *pac;
> +       struct bt_bap_pac *pac, *pac_brodcast_sink;
>         struct bt_bap_codec codec;
>
>         if (!db)
> @@ -2429,11 +2513,17 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct g=
att_db *db,
>         case BT_BAP_SOURCE:
>                 bap_add_source(pac);
>                 break;
> +       case BT_BAP_BROADCAST_SOURCE:
> +               bap_add_broadcast_source(pac);
> +               pac_brodcast_sink =3D bap_pac_new(bdb, name, type, &codec=
, qos, data, metadata);
> +               bap_add_broadcast_sink(pac_brodcast_sink);
> +               break;
>         default:
>                 bap_pac_free(pac);
>                 return NULL;
>         }
>
> +       bt_bap_pac_set_ops(pac, pac_ops, user_data);
>         queue_foreach(sessions, notify_session_pac_added, pac);
>
>         return pac;
> @@ -2443,10 +2533,12 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db =
*db, const char *name,
>                                         uint8_t type, uint8_t id,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata)
> +                                       struct iovec *metadata,
> +                                       struct bt_bap_pac_ops *pac_ops,
> +                                       void *user_data)
>  {
>         return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, =
qos,
> -                                                       data, metadata);
> +                                                       data, metadata, p=
ac_ops, user_data);
>  }
>
>  uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
> @@ -2471,6 +2563,21 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pa=
c *pac)
>         }
>  }
>
> +uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream)
> +{
> +       if (!stream)
> +               return BT_BAP_STREAM_TYPE_UNKNOWN;
> +
> +       if ((bt_bap_pac_get_type(stream->lpac) =3D=3D BT_BAP_SINK) ||
> +               (bt_bap_pac_get_type(stream->lpac) =3D=3D BT_BAP_SOURCE))
> +               return BT_BAP_STREAM_TYPE_UNICAST;
> +       else if ((bt_bap_pac_get_type(stream->lpac) =3D=3D BT_BAP_BROADCA=
ST_SOURCE) ||
> +                       (bt_bap_pac_get_type(stream->lpac) =3D=3D BT_BAP_=
BROADCAST_SINK))
> +               return BT_BAP_STREAM_TYPE_BROADCAST;
> +       else
> +               return BT_BAP_STREAM_TYPE_UNKNOWN;
> +}
> +
>  static void notify_pac_removed(void *data, void *user_data)
>  {
>         struct bt_bap_pac_changed *changed =3D data;
> @@ -2529,6 +2636,9 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
>         if (queue_remove_if(pac->bdb->sources, NULL, pac))
>                 goto found;
>
> +       if (queue_remove_if(pac->bdb->broadcast_sources, NULL, pac))
> +               goto found;
> +
>         return false;
>
>  found:
> @@ -3280,13 +3390,13 @@ static void ep_status_qos(struct bt_bap *bap, str=
uct bt_bap_endpoint *ep,
>         if (!ep->stream)
>                 return;
>
> -       ep->stream->qos.interval =3D interval;
> -       ep->stream->qos.framing =3D qos->framing;
> -       ep->stream->qos.phy =3D qos->phy;
> -       ep->stream->qos.sdu =3D sdu;
> -       ep->stream->qos.rtn =3D qos->rtn;
> -       ep->stream->qos.latency =3D latency;
> -       ep->stream->qos.delay =3D pd;
> +       ep->stream->qos.ucast.io_qos.interval =3D interval;
> +       ep->stream->qos.ucast.framing =3D qos->framing;
> +       ep->stream->qos.ucast.io_qos.phy =3D qos->phy;
> +       ep->stream->qos.ucast.io_qos.sdu =3D sdu;
> +       ep->stream->qos.ucast.io_qos.rtn =3D qos->rtn;
> +       ep->stream->qos.ucast.io_qos.latency =3D latency;
> +       ep->stream->qos.ucast.delay =3D pd;
>
>         if (ep->old_state =3D=3D BT_ASCS_ASE_STATE_CONFIG)
>                 bap_stream_config_cfm(ep->stream);
> @@ -3861,6 +3971,25 @@ clone:
>         return true;
>  }
>
> +bool bt_bap_attach_broadcast(struct bt_bap *bap)
> +{
> +       struct bt_bap_endpoint *ep;
> +
> +       if (queue_find(sessions, NULL, bap))
> +               return true;
> +
> +       if (!sessions)
> +               sessions =3D queue_new();
> +
> +       queue_push_tail(sessions, bap);
> +
> +       ep =3D bap_get_endpoint_broadcast(bap->remote_eps, bap->ldb);
> +       if (ep)
> +               ep->bap =3D bap;
> +
> +       return true;
> +}
> +
>  static void stream_foreach_detach(void *data, void *user_data)
>  {
>         struct bt_bap_stream *stream =3D data;
> @@ -4065,7 +4194,10 @@ void bt_bap_foreach_pac(struct bt_bap *bap, uint8_=
t type,
>                                                         func, user_data);
>         case BT_BAP_SOURCE:
>                 return bap_foreach_pac(bap->ldb->sinks, bap->rdb->sources=
,
> -                                                       func, user_data);
> +                                                          func, user_dat=
a);
> +       case BT_BAP_BROADCAST_SOURCE:
> +               return bap_foreach_pac(bap->ldb->broadcast_sources, bap->=
ldb->broadcast_sinks,
> +                                                               func, use=
r_data);
>         }
>  }
>
> @@ -4178,42 +4310,49 @@ unsigned int bt_bap_stream_config(struct bt_bap_s=
tream *stream,
>         if (!bap_stream_valid(stream))
>                 return 0;
>
> -       if (!stream->client) {
> -               stream_config(stream, data, NULL);
> -               return 0;
> -       }
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_UNIC=
AST) {
> +               if (!stream->client) {
> +                       stream_config(stream, data, NULL);
> +                       return 0;
> +               }
>
> -       memset(&config, 0, sizeof(config));
> +               memset(&config, 0, sizeof(config));
>
> -       config.ase =3D stream->ep->id;
> -       config.latency =3D qos->target_latency;
> -       config.phy =3D qos->phy;
> -       config.codec =3D stream->rpac->codec;
> +               config.ase =3D stream->ep->id;
> +               config.latency =3D qos->ucast.target_latency;
> +               config.phy =3D qos->ucast.io_qos.phy;
> +               config.codec =3D stream->rpac->codec;
>
> -       iov[0].iov_base =3D &config;
> -       iov[0].iov_len =3D sizeof(config);
> +               iov[0].iov_base =3D &config;
> +               iov[0].iov_len =3D sizeof(config);
>
> -       if (data) {
> -               if (!bap_print_cc(data->iov_base, data->iov_len,
> -                                       stream->bap->debug_func,
> -                                       stream->bap->debug_data))
> -                       return 0;
> +               if (data) {
> +                       if (!bap_print_cc(data->iov_base, data->iov_len,
> +                                               stream->bap->debug_func,
> +                                               stream->bap->debug_data))
> +                               return 0;
>
> -               config.cc_len =3D data->iov_len;
> -               iov[1] =3D *data;
> -               iovlen++;
> -       }
> +                       config.cc_len =3D data->iov_len;
> +                       iov[1] =3D *data;
> +                       iovlen++;
> +               }
>
> -       req =3D bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen, func, us=
er_data);
> +               req =3D bap_req_new(stream, BT_ASCS_CONFIG, iov, iovlen, =
func, user_data);
>
> -       if (!bap_queue_req(stream->bap, req)) {
> -               bap_req_free(req);
> -               return 0;
> -       }
> +               if (!bap_queue_req(stream->bap, req)) {
> +                       bap_req_free(req);
> +                       return 0;
> +               }
>
> -       stream->qos =3D *qos;
> +               stream->qos =3D *qos;
>
> -       return req->id;
> +               return req->id;
> +       } else if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TY=
PE_BROADCAST) {
> +               stream->qos =3D *qos;
> +               return 0;
> +       } else {
> +               return 0;
> +       }
>  }
>
>  static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> @@ -4274,7 +4413,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_b=
ap *bap,
>                 if (rpac)
>                         type =3D rpac->type;
>                 else if (lpac) {
> -                       switch(lpac->type) {
> +                       switch (lpac->type) {
>                         case BT_BAP_SINK:
>                                 type =3D BT_BAP_SOURCE;
>                                 break;
> @@ -4339,6 +4478,10 @@ bool bt_bap_stream_set_user_data(struct bt_bap_str=
eam *stream, void *user_data)
>
>         stream->user_data =3D user_data;
>
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BROA=
DCAST)
> +               stream->lpac->ops->config(stream, stream->cc, &stream->qo=
s,
> +                                                               ep_config=
_cb, stream->lpac->user_data);
> +
>         return true;
>  }
>
> @@ -4369,15 +4512,15 @@ unsigned int bt_bap_stream_qos(struct bt_bap_stre=
am *stream,
>
>         /* TODO: Figure out how to pass these values around */
>         qos.ase =3D stream->ep->id;
> -       qos.cig =3D data->cig_id;
> -       qos.cis =3D data->cis_id;
> -       put_le24(data->interval, qos.interval);
> -       qos.framing =3D data->framing;
> -       qos.phy =3D data->phy;
> -       qos.sdu =3D cpu_to_le16(data->sdu);
> -       qos.rtn =3D data->rtn;
> -       qos.latency =3D cpu_to_le16(data->latency);
> -       put_le24(data->delay, qos.pd);
> +       qos.cig =3D data->ucast.cig_id;
> +       qos.cis =3D data->ucast.cis_id;
> +       put_le24(data->ucast.io_qos.interval, qos.interval);
> +       qos.framing =3D data->ucast.framing;
> +       qos.phy =3D data->ucast.io_qos.phy;
> +       qos.sdu =3D cpu_to_le16(data->ucast.io_qos.sdu);
> +       qos.rtn =3D data->ucast.io_qos.rtn;
> +       qos.latency =3D cpu_to_le16(data->ucast.io_qos.latency);
> +       put_le24(data->ucast.delay, qos.pd);
>
>         iov.iov_base =3D &qos;
>         iov.iov_len =3D sizeof(qos);
> @@ -4448,7 +4591,7 @@ unsigned int bt_bap_stream_enable(struct bt_bap_str=
eam *stream,
>                                         bt_bap_stream_func_t func,
>                                         void *user_data)
>  {
> -       int ret;
> +       int ret =3D 0;
>
>         /* Table 3.2: ASE state machine transition
>          * Initiating device - client Only
> @@ -4456,12 +4599,17 @@ unsigned int bt_bap_stream_enable(struct bt_bap_s=
tream *stream,
>         if (!bap_stream_valid(stream) || !stream->client)
>                 return 0;
>
> -       ret =3D bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, fun=
c,
> -                                                               user_data=
);
> -       if (!ret || !enable_links)
> -               return ret;
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_UNIC=
AST) {
> +               ret =3D bap_stream_metadata(stream, BT_ASCS_ENABLE, metad=
ata, func,
> +                                                         user_data);
> +               if (!ret || !enable_links)
> +                       return ret;
>
> -       queue_foreach(stream->links, bap_stream_enable_link, metadata);
> +               queue_foreach(stream->links, bap_stream_enable_link, meta=
data);
> +       } else if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TY=
PE_BROADCAST) {
> +               stream_set_state_broadcast(stream, BT_BAP_STREAM_STATE_ST=
REAMING);
> +               return ret =3D 1;
> +       }
>
>         return ret;
>  }
> @@ -4640,6 +4788,15 @@ unsigned int bt_bap_stream_release(struct bt_bap_s=
tream *stream,
>
>         bap =3D stream->bap;
>
> +       /* If stream is broadcast, no BT_ASCS_RELEASE is required */
> +       if (bt_bap_stream_get_type(stream) =3D=3D BT_BAP_STREAM_TYPE_BROA=
DCAST) {
> +               if (!bap_stream_valid(stream)) {
> +                       stream_set_state_broadcast(stream, BT_BAP_STREAM_=
STATE_IDLE);
> +                       stream =3D NULL;
> +               }
> +               return 0;
> +       }
> +
>         /* If stream does not belong to a client session, clean it up now=
 */
>         if (!bap_stream_valid(stream)) {
>                 stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> @@ -4675,8 +4832,11 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_=
stream *stream)
>
>         if (stream->ep->dir =3D=3D BT_BAP_SOURCE)
>                 return pacs->source_loc_value;
> -       else
> +       else if (stream->ep->dir =3D=3D BT_BAP_SINK)
>                 return pacs->sink_loc_value;
> +       else
> +               // TO DO get the location values from metadata for brodca=
st source and sink
> +               return stream->bap->ldb->pacs->source_loc_value;
>  }
>
>  struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
> @@ -4781,8 +4941,8 @@ int bt_bap_stream_io_link(struct bt_bap_stream *str=
eam,
>                 return -EALREADY;
>
>         if (stream->client !=3D link->client ||
> -                       stream->qos.cig_id !=3D link->qos.cig_id ||
> -                       stream->qos.cis_id !=3D link->qos.cis_id)
> +                       stream->qos.ucast.cig_id !=3D link->qos.ucast.cig=
_id ||
> +                       stream->qos.ucast.cis_id !=3D link->qos.ucast.cis=
_id)
>                 return -EINVAL;
>
>         if (!stream->links)
> @@ -4819,7 +4979,7 @@ static void bap_stream_get_in_qos(void *data, void =
*user_data)
>         struct bt_bap_qos **qos =3D user_data;
>
>         if (!qos || *qos || stream->ep->dir !=3D BT_BAP_SOURCE ||
> -                                               !stream->qos.sdu)
> +                                               !stream->qos.ucast.io_qos=
.sdu)
>                 return;
>
>         *qos =3D &stream->qos;
> @@ -4830,7 +4990,7 @@ static void bap_stream_get_out_qos(void *data, void=
 *user_data)
>         struct bt_bap_stream *stream =3D data;
>         struct bt_bap_qos **qos =3D user_data;
>
> -       if (!qos || *qos || stream->ep->dir !=3D BT_BAP_SINK || !stream->=
qos.sdu)
> +       if (!qos || *qos || stream->ep->dir !=3D BT_BAP_SINK || !stream->=
qos.ucast.io_qos.sdu)
>                 return;
>
>         *qos =3D &stream->qos;
> diff --git a/src/shared/bap.h b/src/shared/bap.h
> index e9f769d0e..3b07df158 100644
> --- a/src/shared/bap.h
> +++ b/src/shared/bap.h
> @@ -4,6 +4,7 @@
>   *  BlueZ - Bluetooth protocol stack for Linux
>   *
>   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> + *  Copyright 2023 NXP
>   *
>   */
>
> @@ -14,8 +15,14 @@
>  #define __packed __attribute__((packed))
>  #endif
>
> -#define BT_BAP_SINK                    0x01
> +#define BT_BAP_SINK                            0x01
>  #define        BT_BAP_SOURCE                   0x02
> +#define        BT_BAP_BROADCAST_SOURCE 0x03
> +#define        BT_BAP_BROADCAST_SINK   0x04
> +
> +#define BT_BAP_STREAM_TYPE_UNICAST             0x01
> +#define        BT_BAP_STREAM_TYPE_BROADCAST    0x02
> +#define        BT_BAP_STREAM_TYPE_UNKNOWN              0x03
>
>  #define BT_BAP_STREAM_STATE_IDLE       0x00
>  #define BT_BAP_STREAM_STATE_CONFIG     0x01
> @@ -49,17 +56,46 @@ struct bt_ltv {
>         uint8_t  value[0];
>  } __packed;
>
> -struct bt_bap_qos {
> +struct bt_bap_io_qos {
> +       uint32_t interval;      /* Frame interval */
> +       uint16_t latency;       /* Transport Latency */
> +       uint16_t sdu;           /* Maximum SDU Size */
> +       uint8_t  phy;           /* PHY */
> +       uint8_t  rtn;           /* Retransmission Effort */
> +};
> +
> +struct bt_bap_ucast_qos {
>         uint8_t  cig_id;
>         uint8_t  cis_id;
> -       uint32_t interval;              /* Frame interval */
>         uint8_t  framing;               /* Frame framing */
> -       uint8_t  phy;                   /* PHY */
> -       uint16_t sdu;                   /* Maximum SDU Size */
> -       uint8_t  rtn;                   /* Retransmission Effort */
> -       uint16_t latency;               /* Transport Latency */
>         uint32_t delay;                 /* Presentation Delay */
>         uint8_t  target_latency;        /* Target Latency */
> +       struct bt_bap_io_qos io_qos;
> +};
> +
> +struct bt_bap_bcast_qos {
> +       uint8_t  big;
> +       uint8_t  bis;
> +       uint8_t  sync_interval;
> +       uint8_t  packing;
> +       uint8_t  framing;
> +       uint8_t  encryption;
> +       struct iovec bcode;
> +       uint8_t  options;
> +       uint16_t skip;
> +       uint16_t sync_timeout;
> +       uint8_t  sync_cte_type;
> +       uint8_t  mse;
> +       uint16_t timeout;
> +       uint8_t  pa_sync;
> +       struct bt_bap_io_qos io_qos;
> +};
> +
> +struct bt_bap_qos {
> +       union {
> +                       struct bt_bap_ucast_qos ucast;
> +                       struct bt_bap_bcast_qos bcast;
> +               };
>  };
>
>  typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data)=
;
> @@ -98,28 +134,32 @@ struct bt_bap_pac_qos {
>         uint32_t ppd_max;
>  };
>
> +struct bt_bap_pac_ops {
> +       int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> +                       struct bt_bap_pac_qos *qos,
> +                       bt_bap_pac_select_t cb, void *cb_data, void *user=
_data);
> +       int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
> +                       struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
> +                       void *user_data);
> +       void (*clear)(struct bt_bap_stream *stream, void *user_data);
> +};
> +
>  struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
>                                         const char *name, uint8_t type,
>                                         uint8_t id, uint16_t cid, uint16_=
t vid,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata);
> +                                       struct iovec *metadata,
> +                                       struct bt_bap_pac_ops *pac_ops,
> +                                       void *user_data);
>
>  struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
>                                         uint8_t type, uint8_t id,
>                                         struct bt_bap_pac_qos *qos,
>                                         struct iovec *data,
> -                                       struct iovec *metadata);
> -
> -struct bt_bap_pac_ops {
> -       int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> -                       struct bt_bap_pac_qos *qos,
> -                       bt_bap_pac_select_t cb, void *cb_data, void *user=
_data);
> -       int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
> -                       struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
> -                       void *user_data);
> -       void (*clear)(struct bt_bap_stream *stream, void *user_data);
> -};
> +                                       struct iovec *metadata,
> +                                       struct bt_bap_pac_ops *pac_ops,
> +                                       void *user_data);
>
>  bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *o=
ps,
>                                         void *user_data);
> @@ -130,6 +170,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
>
>  uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
>
> +uint8_t bt_bap_stream_get_type(struct bt_bap_stream *stream);
> +
>  struct bt_bap_stream *bt_bap_pac_get_stream(struct bt_bap_pac *pac);
>
>  /* Session related function */
> @@ -149,6 +191,7 @@ struct bt_bap *bt_bap_ref(struct bt_bap *bap);
>  void bt_bap_unref(struct bt_bap *bap);
>
>  bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client);
> +bool bt_bap_attach_broadcast(struct bt_bap *bap);
>  void bt_bap_detach(struct bt_bap *bap);
>
>  bool bt_bap_set_debug(struct bt_bap *bap, bt_bap_debug_func_t cb,
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index bf525742d..8d1b3fd52 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -377,11 +377,11 @@ static void test_client_config(struct test_data *da=
ta)
>                                                         "test-bap-snk",
>                                                         BT_BAP_SINK, 0x0f=
f,
>                                                         0x0001, 0x0001,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       NULL, data->caps,=
 NULL, NULL, NULL);
>                 else
>                         data->snk =3D bt_bap_add_pac(data->db, "test-bap-=
snk",
>                                                         BT_BAP_SINK, LC3_=
ID,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       NULL, data->caps,=
 NULL, NULL, NULL);
>                 g_assert(data->snk);
>         }
>
> @@ -391,11 +391,11 @@ static void test_client_config(struct test_data *da=
ta)
>                                                         "test-bap-src",
>                                                         BT_BAP_SOURCE, 0x=
0ff,
>                                                         0x0001, 0x0001,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       NULL, data->caps,=
 NULL, NULL, NULL);
>                 else
>                         data->src =3D bt_bap_add_pac(data->db, "test-bap-=
src",
>                                                         BT_BAP_SOURCE, LC=
3_ID,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       NULL, data->caps,=
 NULL, NULL, NULL);
>                 g_assert(data->src);
>         }
>  }
> @@ -712,12 +712,15 @@ static void test_disc(void)
>  #define QOS_BALANCED_2M \
>         { \
>                 .target_latency =3D BT_BAP_CONFIG_LATENCY_BALANCED, \
> -               .phy =3D BT_BAP_CONFIG_PHY_2M, \
> +               .io_qos.phy =3D BT_BAP_CONFIG_PHY_2M, \
>         }
> -
> +#define QOS_UCAST \
> +{\
> +       .ucast =3D QOS_BALANCED_2M, \
> +}
>  static struct test_config cfg_snk_8_1 =3D {
>         .cc =3D LC3_CONFIG_8_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -727,7 +730,7 @@ static struct test_config cfg_snk_8_1 =3D {
>
>  static struct test_config cfg_snk_8_2 =3D {
>         .cc =3D LC3_CONFIG_8_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -737,7 +740,7 @@ static struct test_config cfg_snk_8_2 =3D {
>
>  static struct test_config cfg_snk_16_1 =3D {
>         .cc =3D LC3_CONFIG_16_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -747,7 +750,7 @@ static struct test_config cfg_snk_16_1 =3D {
>
>  static struct test_config cfg_snk_16_2 =3D {
>         .cc =3D LC3_CONFIG_16_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -757,7 +760,7 @@ static struct test_config cfg_snk_16_2 =3D {
>
>  static struct test_config cfg_snk_24_1 =3D {
>         .cc =3D LC3_CONFIG_24_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -767,7 +770,7 @@ static struct test_config cfg_snk_24_1 =3D {
>
>  static struct test_config cfg_snk_24_2 =3D {
>         .cc =3D LC3_CONFIG_24_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -777,7 +780,7 @@ static struct test_config cfg_snk_24_2 =3D {
>
>  static struct test_config cfg_snk_32_1 =3D {
>         .cc =3D LC3_CONFIG_32_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -787,7 +790,7 @@ static struct test_config cfg_snk_32_1 =3D {
>
>  static struct test_config cfg_snk_32_2 =3D {
>         .cc =3D LC3_CONFIG_32_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -797,7 +800,7 @@ static struct test_config cfg_snk_32_2 =3D {
>
>  static struct test_config cfg_snk_44_1 =3D {
>         .cc =3D LC3_CONFIG_44_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -807,7 +810,7 @@ static struct test_config cfg_snk_44_1 =3D {
>
>  static struct test_config cfg_snk_44_2 =3D {
>         .cc =3D LC3_CONFIG_44_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -817,7 +820,7 @@ static struct test_config cfg_snk_44_2 =3D {
>
>  static struct test_config cfg_snk_48_1 =3D {
>         .cc =3D LC3_CONFIG_48_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -827,7 +830,7 @@ static struct test_config cfg_snk_48_1 =3D {
>
>  static struct test_config cfg_snk_48_2 =3D {
>         .cc =3D LC3_CONFIG_48_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -837,7 +840,7 @@ static struct test_config cfg_snk_48_2 =3D {
>
>  static struct test_config cfg_snk_48_3 =3D {
>         .cc =3D LC3_CONFIG_48_3,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -847,7 +850,7 @@ static struct test_config cfg_snk_48_3 =3D {
>
>  static struct test_config cfg_snk_48_4 =3D {
>         .cc =3D LC3_CONFIG_48_4,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -857,7 +860,7 @@ static struct test_config cfg_snk_48_4 =3D {
>
>  static struct test_config cfg_snk_48_5 =3D {
>         .cc =3D LC3_CONFIG_48_5,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -867,7 +870,7 @@ static struct test_config cfg_snk_48_5 =3D {
>
>  static struct test_config cfg_snk_48_6 =3D {
>         .cc =3D LC3_CONFIG_48_6,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>  };
>
> @@ -899,7 +902,7 @@ static struct test_config cfg_snk_48_6 =3D {
>
>  static struct test_config cfg_src_8_1 =3D {
>         .cc =3D LC3_CONFIG_8_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -909,7 +912,7 @@ static struct test_config cfg_src_8_1 =3D {
>
>  static struct test_config cfg_src_8_2 =3D {
>         .cc =3D LC3_CONFIG_8_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -919,7 +922,7 @@ static struct test_config cfg_src_8_2 =3D {
>
>  static struct test_config cfg_src_16_1 =3D {
>         .cc =3D LC3_CONFIG_16_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -929,7 +932,7 @@ static struct test_config cfg_src_16_1 =3D {
>
>  static struct test_config cfg_src_16_2 =3D {
>         .cc =3D LC3_CONFIG_16_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -939,7 +942,7 @@ static struct test_config cfg_src_16_2 =3D {
>
>  static struct test_config cfg_src_24_1 =3D {
>         .cc =3D LC3_CONFIG_24_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -949,7 +952,7 @@ static struct test_config cfg_src_24_1 =3D {
>
>  static struct test_config cfg_src_24_2 =3D {
>         .cc =3D LC3_CONFIG_24_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -959,7 +962,7 @@ static struct test_config cfg_src_24_2 =3D {
>
>  static struct test_config cfg_src_32_1 =3D {
>         .cc =3D LC3_CONFIG_32_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -969,7 +972,7 @@ static struct test_config cfg_src_32_1 =3D {
>
>  static struct test_config cfg_src_32_2 =3D {
>         .cc =3D LC3_CONFIG_32_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -979,7 +982,7 @@ static struct test_config cfg_src_32_2 =3D {
>
>  static struct test_config cfg_src_44_1 =3D {
>         .cc =3D LC3_CONFIG_44_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -989,7 +992,7 @@ static struct test_config cfg_src_44_1 =3D {
>
>  static struct test_config cfg_src_44_2 =3D {
>         .cc =3D LC3_CONFIG_44_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -999,7 +1002,7 @@ static struct test_config cfg_src_44_2 =3D {
>
>  static struct test_config cfg_src_48_1 =3D {
>         .cc =3D LC3_CONFIG_48_1,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -1009,7 +1012,7 @@ static struct test_config cfg_src_48_1 =3D {
>
>  static struct test_config cfg_src_48_2 =3D {
>         .cc =3D LC3_CONFIG_48_2,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -1019,7 +1022,7 @@ static struct test_config cfg_src_48_2 =3D {
>
>  static struct test_config cfg_src_48_3 =3D {
>         .cc =3D LC3_CONFIG_48_3,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -1029,7 +1032,7 @@ static struct test_config cfg_src_48_3 =3D {
>
>  static struct test_config cfg_src_48_4 =3D {
>         .cc =3D LC3_CONFIG_48_4,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -1039,7 +1042,7 @@ static struct test_config cfg_src_48_4 =3D {
>
>  static struct test_config cfg_src_48_5 =3D {
>         .cc =3D LC3_CONFIG_48_5,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -1049,7 +1052,7 @@ static struct test_config cfg_src_48_5 =3D {
>
>  static struct test_config cfg_src_48_6 =3D {
>         .cc =3D LC3_CONFIG_48_6,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>  };
>
> @@ -1141,7 +1144,7 @@ static void test_scc_cc_lc3(void)
>
>  static struct test_config cfg_snk_vs =3D {
>         .cc =3D IOV_NULL,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .snk =3D true,
>         .vs =3D true,
>  };
> @@ -1155,7 +1158,7 @@ static struct test_config cfg_snk_vs =3D {
>
>  static struct test_config cfg_src_vs =3D {
>         .cc =3D IOV_NULL,
> -       .qos =3D QOS_BALANCED_2M,
> +       .qos =3D QOS_UCAST,
>         .src =3D true,
>         .vs =3D true,
>  };
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
