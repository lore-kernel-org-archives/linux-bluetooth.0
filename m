Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0689AC05027
	for <linux-bluetooth@archiver.kernel.org>; Sun, 12 Feb 2023 20:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBLUqC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Feb 2023 15:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBLUqB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Feb 2023 15:46:01 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878BBF759
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 12:45:59 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j17so16287313lfr.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Feb 2023 12:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32u5Yar3f9w7kdF5abx3RTP9tMI0+GyHDet93Gd3CgA=;
        b=lSGdAzOJv0DRlaXGIe54rzbqwcmo1KCbObNVZh7ZkgpRGGMDpsZZEJE7zfU4J4LpLl
         iOEHkuGUI8es4BrUyhXpZgMmIcJs+x7nTanWb6e58XfodIg8tbSawq1b5asLblPuBGY1
         YHQFt3yH9dK3sQVEh3eg9psv+6WIgkN2TptkWxFMAnPr/UGwrA8ha8FTkHJx2RmArNOC
         A8hLXN/7yTQwDhHkWo5MBzl36CqJ0aezz6NFqe0ZrjmjaYHYC0UJp+3/sMrxVuOcwY/w
         FsvscdWgS3aI17YtOQc0Gzj0Lmi0VMXrH4OgOR2aWIvZIwJZoe3BUAS9YsgD+68avFdD
         zT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32u5Yar3f9w7kdF5abx3RTP9tMI0+GyHDet93Gd3CgA=;
        b=3wv2wgo5MnG4tNt1YDiJvSlT2YoxhANBosMdW5w6WUni5sIDXhuT6bK+y0M8xjC/sH
         UnyGPdQJk6ZdEBqR3Bsk05Pu5YD3GC/MWY1YAERMpDs0v9m7Ll2RIQEuYgnkP9cgxOxt
         Zdc7YqnsPydQCnnmW1VjNLLdS7LN1PwsRn8eRqqFlujEWkTndfVceB8bflZu5Jat7g9T
         dDyt/mAZdlbhphsEGXrn0LHBJ3Z0Zr1A3TPRWXEwIyf1/t1ZZ1T2JQLZnGnbNwgGHpxy
         W9CvwAoua9mF32f5v4jZCfLb8DDGZT73BMm2rffn2Ta4C/HMGJuHKNjApr2NOk0Xar3Q
         95Cw==
X-Gm-Message-State: AO0yUKU6J7gGcgwjSafTd99eLXBz3BITERFMvWkinyoO7d8GwpHVCwCk
        5o4TDBeb74RfiFeIDGSL0qqOwLp5kTHBjNXermwjksUH
X-Google-Smtp-Source: AK7set/dMuazgm/hLbygd+yrg3yy+izRABcaiE2kQQ+1vWid3E2QrrEgqjxfe0QYm/DEQvZ7w6ZnvsqKP69uMUhd/Ek=
X-Received: by 2002:ac2:55b7:0:b0:4b5:6dbc:b719 with SMTP id
 y23-20020ac255b7000000b004b56dbcb719mr3813557lfg.270.1676234757671; Sun, 12
 Feb 2023 12:45:57 -0800 (PST)
MIME-Version: 1.0
References: <98ccef96a4b719599c0fb1d085c7239a12d2ed8c.1676226143.git.pav@iki.fi>
In-Reply-To: <98ccef96a4b719599c0fb1d085c7239a12d2ed8c.1676226143.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Sun, 12 Feb 2023 12:45:46 -0800
Message-ID: <CABBYNZLD4CLCRSeKWj=Mb08Q9_TwkOZB0t-mUEpsT0ghDHpWBw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/bap: wait for GATT client ready before
 ASCS/PACS discovery
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sun, Feb 12, 2023 at 10:41 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> BAP client fails to find endpoints if GATT services are not resolved
> when the GATT client is attached to the session.  This condition
> almost always occurs on the first BAP connection to a device between
> bluetoothd restarts, and may occur also otherwise.

Hmm, this shouldn't happen if you have caching enabled, did you
disable it for some reason?

> The BAP client code discovers ASCS/PACS services and characteristics at
> client attach time.
>
> Fix the connection issue by postponing PAC/ASE discovery until the
> GATT client is ready, if it was not ready at attach time.

This should probably be done by the core, it should check if the
services are cached then it can call accept, otherwise it needs to
wait for the client to be ready, perhaps there is something not quite
right with the way to probe services as afaik if we don't have any
cache the driver shouldn't have been called to begin with.

> ---
>
> Notes:
>     Typical bluetoothctl output in the failing case, without this patch:
>
>     $ sudo systemctl restart bluetooth
>     $ bluetoothctl
>     ...
>     [bluetooth]# connect XX:XX:XX:XX:XX:XX
>     Attempting to connect to XX:XX:XX:XX:XX:XX
>     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce34ec4c700
>     Connection successful
>     [NEW] Primary Service (Handle 0x0000)
>             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008
>             00001801-0000-1000-8000-00805f9b34fb
>             Generic Attribute Profile
>     ...
>     [NEW] Descriptor (Handle 0x0000)
>             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0065/char0066/desc0069
>             00002901-0000-1000-8000-00805f9b34fb
>             Characteristic User Description
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001800-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001801-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000180a-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001844-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce34ec4c700
>     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
>     [CHG] Device XX:XX:XX:XX:XX:XX Paired: yes
>     [xxx]# endpoint.list
>     [xxx]# disconnect
>     Attempting to disconnect from XX:XX:XX:XX:XX:XX
>     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: no
>     Successful disconnected
>     [CHG] Device XX:XX:XX:XX:XX:XX Connected: no
>     [bluetooth]# connect XX:XX:XX:XX:XX:XX
>     Attempting to connect to XX:XX:XX:XX:XX:XX
>     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
>     Connection successful
>     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
>     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
>     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0
>     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
>     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
>     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0
>     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
>     [xxx]# endpoint.list
>     Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
>     Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
>     [xxx]#
>
>     Endpoints and transports failed to appear on the first connect to the
>     BAP server, since GATT discovery was not yet completed when the BAP code
>     tried to discover the endpoints. Second connection succeeded.
>     Occasionally, it also happens that endpoints appear but transports do
>     not, but this is hard to reproduce.
>
>     With this patch:
>
>     $ sudo systemctl restart bluetooth
>     $ bluetoothctl
>     ...
>     [bluetooth]# connect XX:XX:XX:XX:XX:XX
>     Attempting to connect to XX:XX:XX:XX:XX:XX
>     [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 0000184e-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 00001850-0000-1000-8000-00805f9b34fb
>     [CHG] Device XX:XX:XX:XX:XX:XX UUIDs: 03b80e5a-ede8-4b33-a751-6ce34ec4c700
>     Connection successful
>     [NEW] Primary Service (Handle 0x0000)
>             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0008
>             00001801-0000-1000-8000-00805f9b34fb
>             Generic Attribute Profile
>     ...
>     [NEW] Descriptor (Handle 0x0000)
>             /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0065/char0066/desc0069
>             00002901-0000-1000-8000-00805f9b34fb
>             Characteristic User Description
>     [CHG] Device XX:XX:XX:XX:XX:XX ServicesResolved: yes
>     [CHG] Device XX:XX:XX:XX:XX:XX Paired: yes
>     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0
>     [NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0
>     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0
>     [NEW] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
>     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1
>     [CHG] Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_sink0/fd1 Links: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_source0/fd0
>     [xxx]#
>
>     Now the first connection works properly.
>
>     On first reading, the spec does not seem to clearly comment if ASEs and
>     PACs could be removed/added by the server while client is connected. If
>     that's allowed, then we'd need some bigger changes here. Regardless,
>     waiting for GATT client ready before first scan seems good also in this
>     case.
>
>  src/shared/bap.c | 93 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 60 insertions(+), 33 deletions(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index 22f2e6714..2d676d96f 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -158,6 +158,7 @@ struct bt_bap {
>         struct bt_att *att;
>         struct bt_bap_req *req;
>         unsigned int cp_id;
> +       unsigned int client_ready_id;
>
>         unsigned int process_id;
>         unsigned int disconn_id;
> @@ -3733,41 +3734,10 @@ static void bap_attach_att(struct bt_bap *bap, struct bt_att *att)
>                                                         bap, NULL);
>  }
>
> -bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client)
> +static void bap_attach_finish(struct bt_bap *bap)
>  {
>         bt_uuid_t uuid;
>
> -       if (queue_find(sessions, NULL, bap)) {
> -               /* If instance already been set but there is no client proceed
> -                * to clone it otherwise considered it already attached.
> -                */
> -               if (client && !bap->client)
> -                       goto clone;
> -               return true;
> -       }
> -
> -       if (!sessions)
> -               sessions = queue_new();
> -
> -       queue_push_tail(sessions, bap);
> -
> -       queue_foreach(bap_cbs, bap_attached, bap);
> -
> -       if (!client) {
> -               bap_attach_att(bap, bap->att);
> -               return true;
> -       }
> -
> -       if (bap->client)
> -               return false;
> -
> -clone:
> -       bap->client = bt_gatt_client_clone(client);
> -       if (!bap->client)
> -               return false;
> -
> -       bap_attach_att(bap, bt_gatt_client_get_att(client));
> -
>         if (bap->rdb->pacs) {
>                 uint16_t value_handle;
>                 struct bt_pacs *pacs = bap->rdb->pacs;
> @@ -3798,7 +3768,7 @@ clone:
>
>                 bap_notify_ready(bap);
>
> -               return true;
> +               return;
>         }
>
>         bt_uuid16_create(&uuid, PACS_UUID);
> @@ -3806,6 +3776,57 @@ clone:
>
>         bt_uuid16_create(&uuid, ASCS_UUID);
>         gatt_db_foreach_service(bap->rdb->db, &uuid, foreach_ascs_service, bap);
> +}
> +
> +static void bap_attach_ready_cb(bool success, uint8_t att_ecode,
> +                                                               void *user_data)
> +{
> +       struct bt_bap *bap = user_data;
> +
> +       bap->client_ready_id = 0;
> +
> +       bap_attach_finish(bap);
> +}
> +
> +bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client)
> +{
> +       if (queue_find(sessions, NULL, bap)) {
> +               /* If instance already been set but there is no client proceed
> +                * to clone it otherwise considered it already attached.
> +                */
> +               if (client && !bap->client)
> +                       goto clone;
> +               return true;
> +       }
> +
> +       if (!sessions)
> +               sessions = queue_new();
> +
> +       queue_push_tail(sessions, bap);
> +
> +       queue_foreach(bap_cbs, bap_attached, bap);
> +
> +       if (!client) {
> +               bap_attach_att(bap, bap->att);
> +               return true;
> +       }
> +
> +       if (bap->client)
> +               return false;
> +
> +clone:
> +       bap->client = bt_gatt_client_clone(client);
> +       if (!bap->client)
> +               return false;
> +
> +       bap_attach_att(bap, bt_gatt_client_get_att(bap->client));
> +
> +       if (bt_gatt_client_is_ready(bap->client)) {
> +               bap_attach_finish(bap);
> +       } else {
> +               bap->client_ready_id = bt_gatt_client_ready_register(
> +                               bap->client, bap_attach_ready_cb, bap, NULL);
> +       }
>
>         return true;
>  }
> @@ -3824,6 +3845,12 @@ void bt_bap_detach(struct bt_bap *bap)
>         if (!queue_remove(sessions, bap))
>                 return;
>
> +       if (bap->client_ready_id) {
> +               bt_gatt_client_ready_unregister(bap->client,
> +                                               bap->client_ready_id);
> +               bap->client_ready_id = 0;
> +       }
> +
>         bt_gatt_client_unref(bap->client);
>         bap->client = NULL;
>
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
