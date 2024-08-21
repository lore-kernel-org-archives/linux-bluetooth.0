Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8455C13A241
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252529; cv=none; b=LYgWRJ8xbYST2acJuIlWZfgUSakEC8IcPq4ykj76nQTP5HgaIPwj3wzCtSet1Sb1NcrNfFyjB7HYaUFF5ky1ruNMNMaRu04mxdQvB7KvkJ3o++mEJrAe0c21+yscWCT22INcC3jyuP8/iyyasdzZPF86CCykoSMsgsjpkJQsDPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252529; c=relaxed/simple;
	bh=UUOgp2Iiu5XOmqs0Gtm4kb14vP8oM2d9qQJcnentIg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNaBXdU49fJc+9tR0bPjbFSeG/YI3vWTnWJ7IQnyVbMnNiwqnFq/oxieXo3WXXoNUcStMqDdj8FODb0HIAOlrVrxPolbGkP7WgCxb6p3CF6yAWDvLH12L8uU3kKeJW5r1C3UCc5G/DgFI6fc1mhtK5XXaOMiGM0+3IZkpQwPEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMbnydbw; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMbnydbw"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so20067181fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 08:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724252525; x=1724857325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcKoJTP9XaVuIuwyoJRFf6McxTDegRRpO0/3MCk6ohU=;
        b=bMbnydbwWIi/GikR2Ji6Ds7/WTqXsUhzRwKEa8YLf6O53FXacQ7XWuUIHZ7IvXWeWu
         rAP/TGajxHLo1Pzsk6BP6JVHg2jollclbx2PWZ/XGx+2MiWLelVjqTBlazUYWb2FkdD6
         8sWNCCwmipyNJ1JXWmi5QVXAegNo1G8lYDKAo7jlS4gLnaBKsXietZtiSPVG0VsBXXOO
         QJ4WC8WAYFrTRL0ePVxQIrrEUSs46ip50pDco9gJJGNq+VfO890AMLgVa63pw+eB+eOf
         8/j7jqd262ImQ8Fy6NG0rLxxYKVsxKLj1v6wTKTVuS/sY3Hs45fW7gAFs1sMCtB4CCjO
         fuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252525; x=1724857325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcKoJTP9XaVuIuwyoJRFf6McxTDegRRpO0/3MCk6ohU=;
        b=S71z0ERN7dQ5ihyG8xgezZ7BgqaoQvHY68dJHFjfgVSUDvZkLeipC5b/fAfNaMzWil
         NllNaxrX9R/LONdcuPc/8YwSYg8q8fzRbnNgvc8P1lPMoTudZim11ljs6AA6myNpGPB4
         GKzajuNfMf/GIwxj5V9AUGtF+NOAOFsinAwof1pg5Nd47k9+MvuSjBkcWgT5oyE4H4IY
         cba7LdNSGyYt3M49WW1+95tr/5FrAgC7gYPPN52Z3rV4shQ5KynQXOl1u4yN+h4L0j8n
         ZH/se75Z2PsbSrJ7dSqH5bUTsHh/5cCDZztfz4VEQgw9pyLZkglv4wTQyegAUd6WS7O+
         ghvg==
X-Gm-Message-State: AOJu0Yy5uXZHoQ1+tK29HPD1ShV2xGdkgi0/LolOFYLBD155aurSVS2f
	jSYC7D6EozBssLnicRUypUlmJdcyW5R7E0IZlsHUQeZ6VECzMgvCP9J8RmHuZFtpKBKaHmCAB5a
	gzR/I4RpvSvDo4K3anBGQ1qKfkLXi7A==
X-Google-Smtp-Source: AGHT+IGN+QxqGcOEDhNqxhriluze2xmq+70xM6zNswB2JXCG2P+C3qPBJ4FOzpCLQI+8hvzphEAXlVEkjI/RpcHZybI=
X-Received: by 2002:a2e:968c:0:b0:2ef:2bac:bb50 with SMTP id
 38308e7fff4ca-2f3f88642d9mr20272111fa.11.1724252524500; Wed, 21 Aug 2024
 08:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com> <20240821145602.92083-4-iulia.tanasescu@nxp.com>
In-Reply-To: <20240821145602.92083-4-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Aug 2024 11:01:52 -0400
Message-ID: <CABBYNZLamqg6owScao2t=7dDpLkq_41UtNi4Qk2yLG58Ae9eBw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 03/14] shared/bass: Remove io handling
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com, 
	andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Wed, Aug 21, 2024 at 10:56=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> IO procedures should not be handled inside src/shared. The BASS plugin
> should be the one to handle socket operations. This removes IO handling
> from shared/bass.

I'd change this description to say it is the connection procedure that
shall not be handled within shared helpers since that would prevent
unit testing with use of socketpair.

> ---
>  src/shared/bass.c | 312 +---------------------------------------------
>  1 file changed, 2 insertions(+), 310 deletions(-)
>
> diff --git a/src/shared/bass.c b/src/shared/bass.c
> index ce13f2c24..636eb24fd 100644
> --- a/src/shared/bass.c
> +++ b/src/shared/bass.c
> @@ -14,13 +14,9 @@
>  #include <stdbool.h>
>  #include <unistd.h>
>  #include <errno.h>
> -#include <poll.h>
>
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
> -#include "lib/iso.h"
> -
> -#include "btio/btio.h"
>
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
> @@ -29,8 +25,6 @@
>  #include "src/shared/gatt-client.h"
>  #include "src/shared/bass.h"
>
> -#define MAX_BIS_BITMASK_IDX            31
> -
>  #define DBG(_bass, fmt, arg...) \
>         bass_debug(_bass, "%s:%s() " fmt, __FILE__, __func__, ## arg)
>
> @@ -119,35 +113,6 @@ static struct queue *bass_db;
>  static struct queue *bass_cbs;
>  static struct queue *sessions;
>
> -#define DEFAULT_IO_QOS \
> -{ \
> -       .interval       =3D 10000, \
> -       .latency        =3D 10, \
> -       .sdu            =3D 40, \
> -       .phy            =3D 0x02, \
> -       .rtn            =3D 2, \
> -}
> -
> -static struct bt_iso_qos default_qos =3D {
> -       .bcast =3D {
> -               .big                    =3D BT_ISO_QOS_BIG_UNSET,
> -               .bis                    =3D BT_ISO_QOS_BIS_UNSET,
> -               .sync_factor            =3D 0x07,
> -               .packing                =3D 0x00,
> -               .framing                =3D 0x00,
> -               .in                     =3D DEFAULT_IO_QOS,
> -               .out                    =3D DEFAULT_IO_QOS,
> -               .encryption             =3D 0x00,
> -               .bcode                  =3D {0x00},
> -               .options                =3D 0x00,
> -               .skip                   =3D 0x0000,
> -               .sync_timeout           =3D BT_ISO_SYNC_TIMEOUT,
> -               .sync_cte_type          =3D 0x00,
> -               .mse                    =3D 0x00,
> -               .timeout                =3D BT_ISO_SYNC_TIMEOUT,
> -       }
> -};
> -
>  struct bt_bass_src_changed {
>         unsigned int id;
>         bt_bass_src_func_t cb;
> @@ -643,115 +608,6 @@ static bool bass_src_attr_match(const void *data, c=
onst void *match_data)
>         return (bcast_src->attr =3D=3D attr);
>  }
>
> -static gboolean check_io_err(GIOChannel *io)
> -{
> -       struct pollfd fds;
> -
> -       memset(&fds, 0, sizeof(fds));
> -       fds.fd =3D g_io_channel_unix_get_fd(io);
> -       fds.events =3D POLLERR;
> -
> -       if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLERR))
> -               return TRUE;
> -
> -       return FALSE;
> -}
> -
> -static void bass_bis_unref(void *data)
> -{
> -       GIOChannel *io =3D data;
> -
> -       g_io_channel_unref(io);
> -}
> -
> -static void connect_cb(GIOChannel *io, GError *gerr,
> -                               gpointer user_data)
> -{
> -       struct bt_bcast_src *bcast_src =3D user_data;
> -       struct iovec *notif;
> -       int bis_idx;
> -       int i;
> -
> -       /* Keep io reference */
> -       g_io_channel_ref(io);
> -       queue_push_tail(bcast_src->bises, io);
> -
> -       for (i =3D 0; i < bcast_src->num_subgroups; i++) {
> -               struct bt_bass_subgroup_data *data =3D
> -                               &bcast_src->subgroup_data[i];
> -
> -               for (bis_idx =3D 0; bis_idx < MAX_BIS_BITMASK_IDX; bis_id=
x++) {
> -                       if (data->pending_bis_sync & (1 << bis_idx)) {
> -                               data->bis_sync |=3D (1 << bis_idx);
> -                               data->pending_bis_sync &=3D ~(1 << bis_id=
x);
> -                               break;
> -                       }
> -               }
> -
> -               if (bis_idx < MAX_BIS_BITMASK_IDX)
> -                       break;
> -       }
> -
> -       for (i =3D 0; i < bcast_src->num_subgroups; i++) {
> -               if (bcast_src->subgroup_data[i].pending_bis_sync)
> -                       break;
> -       }
> -
> -       /* If there are still pending bises, wait for their
> -        * notifications also before sending notification to
> -        * client
> -        */
> -       if (i !=3D bcast_src->num_subgroups)
> -               return;
> -
> -       /* All connections have been notified */
> -       if (check_io_err(io)) {
> -               DBG(bcast_src->bass, "BIG sync failed");
> -
> -               /* Close all connected bises */
> -               queue_destroy(bcast_src->bises, bass_bis_unref);
> -               bcast_src->bises =3D NULL;
> -
> -               /* Close listen io */
> -               g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
> -               g_io_channel_unref(bcast_src->listen_io);
> -               bcast_src->listen_io =3D NULL;
> -
> -               /* Close pa sync io */
> -               if (bcast_src->pa_sync_io) {
> -                       g_io_channel_shutdown(bcast_src->pa_sync_io,
> -                                       TRUE, NULL);
> -                       g_io_channel_unref(bcast_src->pa_sync_io);
> -                       bcast_src->pa_sync_io =3D NULL;
> -               }
> -
> -               for (i =3D 0; i < bcast_src->num_subgroups; i++)
> -                       bcast_src->subgroup_data[i].bis_sync =3D
> -                               BT_BASS_BIG_SYNC_FAILED_BITMASK;
> -
> -               /* If BIG sync failed because of an incorrect broadcast c=
ode,
> -                * inform client
> -                */
> -               if (bcast_src->enc =3D=3D BT_BASS_BIG_ENC_STATE_BCODE_REQ=
)
> -                       bcast_src->enc =3D BT_BASS_BIG_ENC_STATE_BAD_CODE=
;
> -       } else {
> -               if (bcast_src->enc =3D=3D BT_BASS_BIG_ENC_STATE_BCODE_REQ=
)
> -                       bcast_src->enc =3D BT_BASS_BIG_ENC_STATE_DEC;
> -       }
> -
> -       /* Send notification to client */
> -       notif =3D bass_parse_bcast_src(bcast_src);
> -       if (!notif)
> -               return;
> -
> -       gatt_db_attribute_notify(bcast_src->attr,
> -                                       notif->iov_base, notif->iov_len,
> -                                       bt_bass_get_att(bcast_src->bass))=
;
> -
> -       free(notif->iov_base);
> -       free(notif);
> -}
> -
>  static bool bass_trigger_big_sync(struct bt_bcast_src *bcast_src)
>  {
>         for (int i =3D 0; i < bcast_src->num_subgroups; i++) {
> @@ -766,73 +622,6 @@ static bool bass_trigger_big_sync(struct bt_bcast_sr=
c *bcast_src)
>         return false;
>  }
>
> -
> -static void confirm_cb(GIOChannel *io, gpointer user_data)
> -{
> -       struct bt_bcast_src *bcast_src =3D user_data;
> -       int sk, err;
> -       socklen_t len;
> -       struct bt_iso_qos qos;
> -       struct iovec *notif;
> -       GError *gerr =3D NULL;
> -
> -       if (check_io_err(io)) {
> -               DBG(bcast_src->bass, "PA sync failed");
> -
> -               /* Mark PA sync as failed and notify client */
> -               bcast_src->sync_state =3D BT_BASS_FAILED_TO_SYNCHRONIZE_T=
O_PA;
> -               goto notify;
> -       }
> -
> -       bcast_src->sync_state =3D BT_BASS_SYNCHRONIZED_TO_PA;
> -       bcast_src->pa_sync_io =3D io;
> -       g_io_channel_ref(bcast_src->pa_sync_io);
> -
> -       len =3D sizeof(qos);
> -       memset(&qos, 0, len);
> -
> -       sk =3D g_io_channel_unix_get_fd(io);
> -
> -       err =3D getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
> -       if (err < 0) {
> -               DBG(bcast_src->bass, "Failed to get iso qos");
> -               return;
> -       }
> -
> -       if (!qos.bcast.encryption) {
> -               /* BIG is not encrypted. Try to synchronize */
> -               bcast_src->enc =3D BT_BASS_BIG_ENC_STATE_NO_ENC;
> -
> -               if (bass_trigger_big_sync(bcast_src)) {
> -                       if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
> -                               connect_cb, bcast_src, NULL, &gerr,
> -                               BT_IO_OPT_INVALID)) {
> -                               DBG(bcast_src->bass, "bt_io_bcast_accept:=
 %s",
> -                               gerr->message);
> -                               g_error_free(gerr);
> -                       }
> -                       return;
> -               }
> -
> -               goto notify;
> -       }
> -
> -       /* BIG is encrypted. Wait for Client to provide the Broadcast_Cod=
e */
> -       bcast_src->enc =3D BT_BASS_BIG_ENC_STATE_BCODE_REQ;
> -
> -notify:
> -       notif =3D bass_parse_bcast_src(bcast_src);
> -       if (!notif)
> -               return;
> -
> -       gatt_db_attribute_notify(bcast_src->attr,
> -                                       notif->iov_base, notif->iov_len,
> -                                       bt_bass_get_att(bcast_src->bass))=
;
> -
> -       free(notif->iov_base);
> -       free(notif);
> -}
> -
>  static struct bt_bass *bass_get_session(struct bt_att *att, struct gatt_=
db *db,
>                 const bdaddr_t *adapter_bdaddr)
>  {
> @@ -919,13 +708,7 @@ static void bass_handle_add_src_op(struct bt_bass *b=
ass,
>         uint8_t src_id =3D 0;
>         struct gatt_db_attribute *attr;
>         uint8_t pa_sync;
> -       GIOChannel *io;
> -       GError *err =3D NULL;
> -       struct bt_iso_qos iso_qos =3D default_qos;
> -       uint8_t num_bis =3D 0;
> -       uint8_t bis[ISO_MAX_NUM_BIS];
>         struct iovec *notif;
> -       uint8_t addr_type;
>
>         gatt_db_attribute_write_result(attrib, id, 0x00);
>
> @@ -942,8 +725,6 @@ static void bass_handle_add_src_op(struct bt_bass *ba=
ss,
>
>         queue_push_tail(bass->ldb->bcast_srcs, bcast_src);
>
> -       memset(bis, 0, ISO_MAX_NUM_BIS);
> -
>         bcast_src->bass =3D bass;
>
>         /* Map the source to a Broadcast Receive State characteristic */
> @@ -1025,18 +806,6 @@ static void bass_handle_add_src_op(struct bt_bass *=
bass,
>
>                 util_iov_pull_le32(iov, &data->pending_bis_sync);
>
> -               if (data->pending_bis_sync !=3D BIS_SYNC_NO_PREF)
> -                       /* Iterate through the bis sync bitmask written
> -                        * by the client and store the bis indexes that
> -                        * the BASS server will try to synchronize to
> -                        */
> -                       for (int bis_idx =3D 0; bis_idx < 31; bis_idx++) =
{
> -                               if (data->pending_bis_sync & (1 << bis_id=
x)) {
> -                                       bis[num_bis] =3D bis_idx + 1;
> -                                       num_bis++;
> -                               }
> -                       }
> -
>                 data->meta_len =3D *(uint8_t *)util_iov_pull_mem(iov,
>                                                 sizeof(data->meta_len));
>                 if (!data->meta_len)
> @@ -1051,38 +820,7 @@ static void bass_handle_add_src_op(struct bt_bass *=
bass,
>         }
>
>         if (pa_sync !=3D PA_SYNC_NO_SYNC) {
> -               /* Convert to three-value type */
> -               if (bcast_src->addr_type)
> -                       addr_type =3D BDADDR_LE_RANDOM;
> -               else
> -                       addr_type =3D BDADDR_LE_PUBLIC;
> -
> -               /* If requested by client, try to synchronize to the sour=
ce */
> -               io =3D bt_io_listen(NULL, confirm_cb, bcast_src, NULL, &e=
rr,
> -                                       BT_IO_OPT_SOURCE_BDADDR,
> -                                       &bass->ldb->adapter_bdaddr,
> -                                       BT_IO_OPT_DEST_BDADDR,
> -                                       &bcast_src->addr,
> -                                       BT_IO_OPT_DEST_TYPE,
> -                                       addr_type,
> -                                       BT_IO_OPT_MODE, BT_IO_MODE_ISO,
> -                                       BT_IO_OPT_QOS, &iso_qos,
> -                                       BT_IO_OPT_ISO_BC_SID, bcast_src->=
sid,
> -                                       BT_IO_OPT_ISO_BC_NUM_BIS, num_bis=
,
> -                                       BT_IO_OPT_ISO_BC_BIS, bis,
> -                                       BT_IO_OPT_INVALID);
> -
> -               if (!io) {
> -                       DBG(bass, "%s", err->message);
> -                       g_error_free(err);
> -                       goto err;
> -               }
> -
> -               bcast_src->listen_io =3D io;
> -               g_io_channel_ref(bcast_src->listen_io);
> -
> -               if (num_bis > 0 && !bcast_src->bises)
> -                       bcast_src->bises =3D queue_new();
> +               /* TODO: call BASS plugin callback to establish PA/BIG sy=
nc */
>         } else {
>                 for (int i =3D 0; i < bcast_src->num_subgroups; i++)
>                         bcast_src->subgroup_data[i].bis_sync =3D
> @@ -1122,10 +860,6 @@ static void bass_handle_set_bcast_code_op(struct bt=
_bass *bass,
>  {
>         struct bt_bass_set_bcast_code_params *params;
>         struct bt_bcast_src *bcast_src;
> -       int sk, err;
> -       socklen_t len;
> -       struct bt_iso_qos qos;
> -       GError *gerr =3D NULL;
>         struct iovec *notif;
>
>         /* Get Set Broadcast Code command parameters */
> @@ -1161,37 +895,7 @@ static void bass_handle_set_bcast_code_op(struct bt=
_bass *bass,
>                 return;
>         }
>
> -       /* Try to sync to the source using the
> -        * received broadcast code
> -        */
> -       len =3D sizeof(qos);
> -       memset(&qos, 0, len);
> -
> -       if (!bcast_src->pa_sync_io)
> -               return;
> -
> -       sk =3D g_io_channel_unix_get_fd(bcast_src->pa_sync_io);
> -
> -       err =3D getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
> -       if (err < 0) {
> -               DBG(bcast_src->bass, "Failed to get iso qos");
> -               return;
> -       }
> -
> -       /* Update socket QoS with Broadcast Code */
> -       memcpy(qos.bcast.bcode, params->bcast_code, BT_BASS_BCAST_CODE_SI=
ZE);
> -
> -       if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
> -                               sizeof(qos)) < 0) {
> -               DBG(bcast_src->bass, "Failed to set iso qos");
> -               return;
> -       }
> -
> -       if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
> -               bcast_src, NULL, &gerr,  BT_IO_OPT_INVALID)) {
> -               DBG(bcast_src->bass, "bt_io_bcast_accept: %s", gerr->mess=
age);
> -               g_error_free(gerr);
> -       }
> +       /* TODO: Call BASS plugin callback to sync with required BIS */
>  }
>
>  #define BASS_OP(_str, _op, _size, _func) \
> @@ -1375,18 +1079,6 @@ static void bass_bcast_src_free(void *data)
>
>         free(bcast_src->subgroup_data);
>
> -       if (bcast_src->listen_io) {
> -               g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
> -               g_io_channel_unref(bcast_src->listen_io);
> -       }
> -
> -       if (bcast_src->pa_sync_io) {
> -               g_io_channel_shutdown(bcast_src->pa_sync_io, TRUE, NULL);
> -               g_io_channel_unref(bcast_src->pa_sync_io);
> -       }
> -
> -       queue_destroy(bcast_src->bises, bass_bis_unref);
> -
>         free(bcast_src);
>  }
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
