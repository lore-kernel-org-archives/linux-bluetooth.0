Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08E14C5AA
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254616; cv=none; b=XlwfGbzaz+OyQliHxXwa6cg4Xl6r/zNu3xSOiswMOdvj4AcEAnAfOR76Vc+LbzWg1EKKlW3G7V0Rq9ZmpNB4ow2tS+PYzY8Nwn5rq6bjC42kYFliA8WGv3ZPbPkguu6qmzxsPltgmGbZk8q9jFAy9BWCwN3oduwTGJ6HocHn1V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254616; c=relaxed/simple;
	bh=bCjfh+vacrRFpjM4/wxEyX5tSWuZxsA2G3cDfExijDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPRXPp3kYKi/IIcHh4z5JCduWjsZ5XlOBd3zcH+GgEUYqKqq1tqnTEa3mYj3OiG9M6oGZ3ROcTxWE+3Qd6Xu7zKcQ1rMdQRw0ok43nM11IL/G6eIx3Q1ujeVOtYrJFBOv/wE8Usg95uO9I9MG/oUf2RNzr4EuiCGRGr7AMhLV7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv1GikPP; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv1GikPP"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso43496411fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724254612; x=1724859412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsTQa8LdBUOUG2emiz6/EjkFgm8Zt7X6nlrTpqx6ZmI=;
        b=Xv1GikPPvGVudQBFq+oYgJWHh7HvZX/wvvOtQgLfn34vFP0AAdNoVCgJQQwpHpSmXa
         bPXMCnLqTc+QL4UULSc6AmxcWKFKUN7QoYt0d1+fsZ1+V0HDr3dHZqxXCiJ8V61+fKd/
         JqKiYVLyMfWZaaA3JhIQcj8UwY9R7tHgs+I1ymXKFMa5Ze3YGMIa74pN7A2U58QGbpbj
         luvpfNuIKJu5ne+QqwEc+AEKS58flAXrBVAX35j6BfRGKnBJJ9NkLbICchwlxUqX4K8B
         dKEVG/1oEb2AGEV0nTZPDZeo53OXdito93E47DisnyxpXgrvPx0ooWQCJVgNY/zGer1H
         z7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724254612; x=1724859412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsTQa8LdBUOUG2emiz6/EjkFgm8Zt7X6nlrTpqx6ZmI=;
        b=W3m4QdPUkShSw2PxVJkhvKbXMXI7c9/b9U85MZZzMLNZWIishTmIFBOOVkh1EefD9f
         +LfTb0u24l9WOICXC3bbUV2XgIF44daNcwVo+A7o+sk2dOSB2KVpEibR376Q8TdR6kOJ
         RaNHhyKLGO4+dMweovRos+rtimpwqEQLOtlCeFFlBNdj91bLk+6VkpVfz0Uz06tLymIr
         wzmahqj4MxYJX5XZGrykHKmuOTmYAeTOqq4nHUGHoM1gdefcnGGBcXSdh6bmPl+52Wel
         CVyJZ1p0FbrJdUiRG1LMKbQtxeCj0Vlst+OlW9Q/fiSeb4parNc+lspYLJF+iwuGYtgi
         vySA==
X-Gm-Message-State: AOJu0YyJXPvjwZAEOPGxGdmmM/zE2oPsRa3yMfgmA4fL8Yz0vnfhiJgd
	QsjiKcsszi3RPuQB1/M8VcqgVNOQxWhy36b3mmob1pOZ/FdWU7rszNwb9JIFlrp8Fk6XeyHkGM4
	xjMDQnmGKGLWqHoSA4BfpIq/rBZz+pg==
X-Google-Smtp-Source: AGHT+IEsnKpwDt7adnY0E3rQ7n9taYc7Lozo0vJOjVLgiZ/6vzgMVw4fNMjD9kDdieRSes1SlqxZ3DUAsmqcrgJ+f28=
X-Received: by 2002:a2e:be0e:0:b0:2f3:e5de:7fc1 with SMTP id
 38308e7fff4ca-2f3f8948bbdmr24889341fa.34.1724254610767; Wed, 21 Aug 2024
 08:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com> <20240821145602.92083-10-iulia.tanasescu@nxp.com>
In-Reply-To: <20240821145602.92083-10-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 Aug 2024 11:36:37 -0400
Message-ID: <CABBYNZL8wKFRm06-Yzsvqahp4=M_nKCfEAfFTd=HL-ODYGkGJQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 09/14] bap: Probe Broadcasters with BASS
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
> After short-lived PA sync, this adds a call to probe the bap session
> with the Broadcaster with BASS.
>
> If the BAP Broadcast Sink has probed the Broadcaster autonomously,
> the short lived PA sync io is closed immediately, since PA sync needs
> to be terminated so other Broadcasters can be probed next. If the BAP
> Broadcast Sink is acting as a Scan Delegator and the probed Broadcaster
> was added by a Broadcast Assistant, PA sync needs to remain active (it
> should be terminated only on Broadcast Assistant command).
>
> This commit updates the way short-lived PA sync is handled in case of
> a Scan Delegator use case: A reference to PA sync io is kept inside
> data->listen_io, to keep the sync active. The PA sync request is also
> kept in progress in the adapter queue, so that no other short-lived PA
> syncs will be attempted. Once the BAP data is freed, the listen_io will
> be closed and the PA sync request will be dequeued and freed as well.
> Then, other Broadcasters will continue to be probed.

This sounds like a bad idea to share the IO handling between different
plugins, either we shall move the PA Sync handling to core or create
its own IO handling in BASS rather than reuse BAP IO handling. Also it
shall be possible to have both a local user and a BASS server attempt
to sync to broadcasters, for the above paragraph it seems to me that
wouldn't be possible? I guess part of the problem is that controller
normally wouldn't support multiple PA Sync thus we have the
short-lived PA syncs to enumerate broadcasters but if BASS want a
long-lived PA sync then it would interfere with BAP, in that case I
rather have the operation going in parallel (short-lived vs long
lived) so it is up to the controller to allow that or not so we can do
the IO handling independently in each plugin.

> This also adds a call to notify BASS about a session with a Broadcaster
> being removed, in bap_bcast_remove.
>
> The bluetoothctl log below shows a Scan Delegator creating a media
> transport for a BIS added by a Broadcast Assistant through the
> Add Source command, and then disconnecting from the Broadcaster:
>
> client/bluetoothctl
> [bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
> [/local/endpoint/ep0] Auto Accept (yes/no): y
> [/local/endpoint/ep0] Max Transports (auto/value): a
> [/local/endpoint/ep0] Locations: 1
> [/local/endpoint/ep0] Supported Context (value): 1
> [bluetooth]# Endpoint /local/endpoint/ep0 registered
> [bluetooth]# advertise on
> [bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
> [00-60-37-31-7E-3F]# [NEW] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA
> [00-60-37-31-7E-3F]# [NEW] Transport
>     /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
> [00-60-37-31-7E-3F]# disconnect 03:E2:C0:11:57:DA
> Attempting to disconnect from 03:E2:C0:11:57:DA
> [00-60-37-31-7E-3F]# [DEL] Transport
>     /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
> [00-60-37-31-7E-3F]# [DEL] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA
>
> The btmon log below shows that after PA sync is established inside
> the BAP plugin, the Scan Delegator sends a GATT notification to
> inform the Broadcast Assistant that PA sync has been established.
> Once the Broadcaster device is deleted, PA sync is terminated and
> the Scan Delegator once again notifies the peer about the update:
>
> > ACL Data RX: Handle 0 flags 0x01 dlen 1
>       ATT: Write Command (0x52) len 23
>         Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
>           Data[21]: 0201da5711c0e203001a2d5602ffff010100000000
>             Opcode: Add Source (0x02)
>             Source_Address_Type: 1
>             Source_Address: 03:E2:C0:11:57:DA
>             Source_Adv_SID: 0
>             Broadcast_ID: 0x562d1a
>             PA_Sync_State: Synchronize to PA - PAST not available
>             PA_Interval: 0xffff
>             Num_Subgroups: 1
>             Subgroup #0:
>               BIS_Sync State: 0x00000001
> < HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044)
>         Options: 0x0000
>         Use advertising SID, Advertiser Address Type and address
>         Reporting initially enabled
>         SID: 0x00
>         Adv address type: Random (0x01)
>         Adv address: 03:E2:C0:11:57:DA (Non-Resolvable)
>         Skip: 0x0000
>         Sync timeout: 20000 msec (0x07d0)
>         Sync CTE type: 0x0000
> > HCI Event: Command Status (0x0f) plen 4
>       LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
>         Status: Success (0x00)
> > HCI Event: LE Meta Event (0x3e) plen 16
>       LE Periodic Advertising Sync Established (0x0e)
>         Status: Success (0x00)
>         Sync handle: 0
>         Advertising SID: 0x00
>         Advertiser address type: Random (0x01)
>         Advertiser address: 03:E2:C0:11:57:DA (Non-Resolvable)
>         Advertiser PHY: LE 2M (0x02)
>         Periodic advertising interval: 10.00 msec (0x0008)
>         Advertiser clock accuracy: 0x07
> > HCI Event: LE Meta Event (0x3e) plen 42
>       LE Periodic Advertising Report (0x0f)
>         Sync handle: 0
>         TX power: 127 dbm (0x7f)
>         RSSI: -64 dBm (0xc0)
>         CTE Type: No Constant Tone Extension (0xff)
>         Data status: Complete
>         Data length: 0x22
>         Service Data: Basic Audio Announcement (0x1851)
>           Presetation Delay: 40000
>           Number of Subgroups: 1
>             Subgroup #0:
>             Number of BIS(s): 1
>             Codec: LC3 (0x06)
>             Codec Specific Configuration: #0: len 0x02 type 0x01
>             Codec Specific Configuration: Sampling Frequency: 16 Khz
>             Codec Specific Configuration: #1: len 0x02 type 0x02
>             Codec Specific Configuration: Frame Duration: 10 ms (0x01)
>             Codec Specific Configuration: #2: len 0x03 type 0x04
>             Codec Specific Configuration: Frame Length: 40 (0x0028)
>             Codec Specific Configuration: #3: len 0x05 type 0x03
>             Codec Specific Configuration: Location: 0x00000001
>             Codec Specific Configuration: Location: Front Left
>               BIS #0:
>               Index: 1
> > HCI Event: LE Meta Event (0x3e) plen 20
>       LE Broadcast Isochronous Group Info Advertising Report (0x22)
>         Sync Handle: 0x0000
>         Number BIS: 1
>         NSE: 3
>         ISO Interval: 10.00 msec (0x0008)
>         BN: 1
>         PTO: 1
>         IRC: 3
>         Maximum PDU: 40
>         SDU Interval: 10000 us (0x002710)
>         Maximum SDU: 40
>         PHY: LE 2M (0x02)
>         Framing: Unframed (0x00)
>         Encryption: 0x00
> bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
>       ATT: Handle Multiple Value Notification (0x23) len 24
>         Length: 0x0014
>         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
>           Data[20]: 0101da5711c0e203001a2d560200010000000000
>           Source_ID: 1
>           Source_Address_Type: 1
>           Source_Address: 03:E2:C0:11:57:DA
>           Source_Adv_SID: 0
>           Broadcast_ID: 0x562d1a
>           PA_Sync_State: Synchronized to PA
>           BIG_Encryption: Not encrypted
>           Num_Subgroups: 1
>           Subgroup #0:
>             BIS_Sync State: 0x00000000
> bluetoothd[70621]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
>       ATT: Handle Multiple Value Notification (0x23) len 24
>         Length: 0x0014
>         Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
>           Data[20]: 0101dd7c8046f72a00f863f00000010000000000
>           Source_ID: 1
>           Source_Address_Type: 1
>           Source_Address: 2A:F7:46:80:7C:DD
>           Source_Adv_SID: 0
>           Broadcast_ID: 0xf063f8
>           PA_Sync_State: Not synchronized to PA
>           BIG_Encryption: Not encrypted
>           Num_Subgroups: 1
>           Subgroup #0:
>             BIS_Sync State: 0x00000000
> < HCI Command: LE Periodic Advertising Terminate Sync (0x08|0x0046) plen =
2
>         Sync handle: 0x0000
> > HCI Event: Command Complete (0x0e) plen 4
>       LE Periodic Advertising Terminate Sync (0x08|0x0046) ncmd 1
>         Status: Success (0x00
> ---
>  profiles/audio/bap.c | 128 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 95 insertions(+), 33 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index a2c5a546d..bf924932a 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -182,6 +182,9 @@ static struct bt_iso_qos bap_sink_pa_qos =3D {
>         }
>  };
>
> +static bool match_service(const void *data, const void *match_data);
> +static void iso_do_big_sync(GIOChannel *io, void *user_data);
> +
>  static bool bap_data_set_user_data(struct bap_data *data, void *user_dat=
a)
>  {
>         if (!data)
> @@ -211,6 +214,8 @@ static void setup_free(void *data);
>
>  static void bap_data_free(struct bap_data *data)
>  {
> +       struct bap_bcast_pa_req *req;
> +
>         if (data->listen_io) {
>                 g_io_channel_shutdown(data->listen_io, TRUE, NULL);
>                 g_io_channel_unref(data->listen_io);
> @@ -230,6 +235,22 @@ static void bap_data_free(struct bap_data *data)
>         bt_bap_state_unregister(data->bap, data->state_id);
>         bt_bap_pac_unregister(data->bap, data->pac_id);
>         bt_bap_unref(data->bap);
> +
> +       if (data->adapter) {
> +               /* If this is a Broadcast Sink session with a Broadcast S=
ource,
> +                * remove any pending PA sync requests from the adapter q=
ueue,
> +                * since the session is about to be deleted.
> +                */
> +               req =3D queue_remove_if(data->adapter->bcast_pa_requests,
> +                                               match_service, data->serv=
ice);
> +               if (req && req->io_id) {
> +                       g_source_remove(req->io_id);
> +                       req->io_id =3D 0;
> +               }
> +
> +               free(req);
> +       }
> +
>         free(data);
>  }
>
> @@ -1004,9 +1025,11 @@ static void iso_bcast_confirm_cb(GIOChannel *io, G=
Error *err, void *user_data)
>
>         DBG("BIG Sync completed");
>
> -       g_io_channel_unref(setup->io);
> -       g_io_channel_shutdown(setup->io, TRUE, NULL);
> -       setup->io =3D NULL;
> +       if (setup->io) {
> +               g_io_channel_unref(setup->io);
> +               g_io_channel_shutdown(setup->io, TRUE, NULL);
> +               setup->io =3D NULL;
> +       }
>
>         /* This device is no longer needed */
>         btd_service_connecting_complete(bap_data->service, 0);
> @@ -1258,9 +1281,25 @@ static gboolean big_info_report_cb(GIOChannel *io,=
 GIOCondition cond,
>         /* Close the io and remove the queue request for another PA Sync =
*/
>         g_io_channel_shutdown(data->listen_io, TRUE, NULL);
>         g_io_channel_unref(data->listen_io);
> -       g_io_channel_shutdown(io, TRUE, NULL);
>         data->listen_io =3D NULL;
>
> +       if (bass_bcast_probe(data->device, data->bap)) {
> +               /* If this Broadcast Source was successfully probed insid=
e
> +                * BASS, it means that the Broadcast Sink acting as a Sca=
n
> +                * Delegator performed short-lived PA sync as a request f=
rom
> +                * a Broadcast Assistant. The Scan Delegator should keep =
PA
> +                * sync active until instructed otherwise by the Assistan=
t.
> +                * Keep a reference to the PA sync io to keep the fd open=
.
> +                */
> +               data->listen_io =3D io;
> +               g_io_channel_ref(io);
> +       } else {
> +               /* Unless it is required by a Broadcast Assistant, PA syn=
c is
> +                * no longer needed at this point, so the io can be close=
d.
> +                */
> +               g_io_channel_shutdown(io, TRUE, NULL);
> +       }
> +
>         /* Analyze received BASE data and create remote media endpoints f=
or each
>          * BIS matching our capabilities
>          */
> @@ -1268,9 +1307,18 @@ static gboolean big_info_report_cb(GIOChannel *io,=
 GIOCondition cond,
>
>         service_set_connecting(req->data.service);
>
> -       queue_remove(data->adapter->bcast_pa_requests, req);
>         req->io_id =3D 0;
> -       free(req);
> +
> +       if (!data->listen_io) {
> +               /* If PA sync has been terminated, dequeue request to be =
able
> +                * to probe other Broadcasters. Otherwise, keep this requ=
est
> +                * in progress to avoid probing other Broadcasters as lon=
g as
> +                * PA is active with the current one. The request will be
> +                * dequeued and freed when the PA sync io will be shutdow=
n.
> +                */
> +               queue_remove(data->adapter->bcast_pa_requests, req);
> +               free(req);
> +       }
>
>         return FALSE;
>  }
> @@ -2236,6 +2284,26 @@ static void setup_accept_io_broadcast(struct bap_d=
ata *data,
>         struct bap_bcast_pa_req *req =3D new0(struct bap_bcast_pa_req, 1)=
;
>         struct bap_adapter *adapter =3D data->adapter;
>
> +       req->type =3D BAP_PA_BIG_SYNC_REQ;
> +       req->in_progress =3D FALSE;
> +       req->data.setup =3D setup;
> +
> +       if (data->listen_io) {
> +               /* If there is an active listen io for the BAP session
> +                * with the Broadcast Source, it means that PA sync is
> +                * already established. Go straight to establishing BIG
> +                * sync.
> +                */
> +               iso_do_big_sync(data->listen_io, req);
> +               return;
> +       }
> +
> +       /* Add this request to the PA queue.
> +        * We don't need to check the queue here, as we cannot have
> +        * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
> +        */
> +       queue_push_tail(adapter->bcast_pa_requests, req);
> +
>         /* Timer could be stopped if all the short lived requests were tr=
eated.
>          * Check the state of the timer and turn it on so that this reque=
sts
>          * can also be treated.
> @@ -2244,15 +2312,6 @@ static void setup_accept_io_broadcast(struct bap_d=
ata *data,
>                 adapter->pa_timer_id =3D g_timeout_add_seconds(PA_IDLE_TI=
MEOUT,
>                                                                 pa_idle_t=
imer,
>                                                                 adapter);
> -
> -       /* Add this request to the PA queue.
> -        * We don't need to check the queue here, as we cannot have
> -        * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
> -        */
> -       req->type =3D BAP_PA_BIG_SYNC_REQ;
> -       req->in_progress =3D FALSE;
> -       req->data.setup =3D setup;
> -       queue_push_tail(adapter->bcast_pa_requests, req);
>  }
>
>  static void setup_create_ucast_io(struct bap_data *data,
> @@ -3030,10 +3089,17 @@ static void iso_do_big_sync(GIOChannel *io, void =
*user_data)
>         const char *strbis =3D NULL;
>
>         DBG("PA Sync done");
> -       g_io_channel_unref(setup->io);
> -       g_io_channel_shutdown(setup->io, TRUE, NULL);
> -       setup->io =3D io;
> -       g_io_channel_ref(setup->io);
> +
> +       if (setup->io) {
> +               g_io_channel_unref(setup->io);
> +               g_io_channel_shutdown(setup->io, TRUE, NULL);
> +
> +               /* Keep a reference to the PA sync io until
> +                * BIG sync is established.
> +                */
> +               setup->io =3D io;
> +               g_io_channel_ref(setup->io);
> +       }
>
>         /* TODO
>          * We can only synchronize with a single BIS to a BIG.
> @@ -3086,14 +3152,14 @@ static void iso_do_big_sync(GIOChannel *io, void =
*user_data)
>         memcpy(&qos.bcast.out, &setup->qos.bcast.io_qos,
>                         sizeof(struct bt_iso_io_qos));
>
> -       if (!bt_io_set(setup->io, &err,
> +       if (!bt_io_set(io, &err,
>                         BT_IO_OPT_QOS, &qos,
>                         BT_IO_OPT_INVALID)) {
>                 error("bt_io_set: %s", err->message);
>                 g_error_free(err);
>         }
>
> -       if (!bt_io_bcast_accept(setup->io,
> +       if (!bt_io_bcast_accept(io,
>                         iso_bcast_confirm_cb,
>                         req, NULL, &err,
>                         BT_IO_OPT_ISO_BC_NUM_BIS,
> @@ -3211,7 +3277,6 @@ static void bap_bcast_remove(struct btd_service *se=
rvice)
>  {
>         struct btd_device *device =3D btd_service_get_device(service);
>         struct bap_data *data;
> -       struct bap_bcast_pa_req *req;
>         char addr[18];
>
>         ba2str(device_get_address(device), addr);
> @@ -3222,17 +3287,9 @@ static void bap_bcast_remove(struct btd_service *s=
ervice)
>                 error("BAP service not handled by profile");
>                 return;
>         }
> -       /* Remove the corresponding entry from the pa_req queue. Any pa_r=
eq that
> -        * are in progress will be stopped by bap_data_remove which calls
> -        * bap_data_free.
> -        */
> -       req =3D queue_remove_if(data->adapter->bcast_pa_requests,
> -                                               match_service, service);
> -       if (req && req->io_id) {
> -               g_source_remove(req->io_id);
> -               req->io_id =3D 0;
> -       }
> -       free(req);
> +
> +       /* Notify the BASS plugin about the removed session. */
> +       bass_bcast_remove(device);
>
>         bap_data_remove(data);
>
> @@ -3393,8 +3450,13 @@ static void bap_adapter_remove(struct btd_profile =
*p,
>         DBG("%s", addr);
>
>         queue_destroy(data->adapter->bcast_pa_requests, free);
> +
> +       if (data->adapter->pa_timer_id)
> +               g_source_remove(data->adapter->pa_timer_id);
> +
>         queue_remove(adapters, data->adapter);
>         free(data->adapter);
> +       data->adapter =3D NULL;
>
>         if (queue_isempty(adapters)) {
>                 queue_destroy(adapters, NULL);
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
