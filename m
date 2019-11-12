Return-Path: <SRS0=2Kq+=ZE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706FBC43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 13:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5DB20679
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Nov 2019 13:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6CWRR5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKLN05 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:26:57 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43957 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfKLN05 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Nov 2019 08:26:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id l20so14717646oie.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2019 05:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Rr4P0MnGa5jxj3NEZPm/k9oyCAG7d4ZUDtLWVxZhj+w=;
        b=d6CWRR5CYdiVfMO4fmPQj00z43EKM893TJ5BTtqMsPY/sF1vO42XDOqu94MNML0TZg
         e2EFb3NfuZxYSBgcVzn4i0nc2cff3+2HLbcKIrOKsXDoSQb8g1Ro/mqE+hycclVmk2Ck
         whGhx3b3oWoC4QbDD/X+H4QX3Vmg1aLiLVi9jm9u+DsENQlvbH1VMhuVs5ZIPWa6YCUj
         U9sCdwbNbhTq05WNG5281Zr4NWFIoc9TIdCkcyTR16IaycnBijUVF8052r/flhOFQu+g
         iJ6sLe0TkYwUAbN+vym0odzlUpAlA64QkM+2xbWBA9AXbNWshnh/ysg78U2IICC0T6hG
         I+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Rr4P0MnGa5jxj3NEZPm/k9oyCAG7d4ZUDtLWVxZhj+w=;
        b=jmLeA2jC6saR/WvigTMeCfcWtAD0nlhZ/HMabgDfwbNoLzcEyGag4bqSm4oarwwVwv
         ep3kk6xQ7u0Dt9I0xSRDOggBg4HqkW0jkd5tfePNmMRNy7UhLo+SZesBQ7PXavi4rtN+
         ClSctdsAYbx1yFLA88Cx93ZzeQUjB3jFdhv2e2ALyYCGx0Np7m/oFRdN/dEHVD/sQhYm
         zxM9yep9ktn5eOlfBPOQzE9Pmv+gSOFTnpwcu84d4gSK4gnAbGEAfilfCd0XdJ2fvXvO
         0wXMUGC82fKs4Q5o9G9EARBvq7H93EAn7EClbw3JJ5bxALcu2VB4MKyLImc7f/AILuoF
         MrpQ==
X-Gm-Message-State: APjAAAU0G9jPNBALEpGwtr11lUgYy9PX2TEYkAB/AlwN6CCIt4QEUNTj
        C9lhR23bQyd1M7F6xkol8lNePA9AALgL9iNZYWE=
X-Google-Smtp-Source: APXvYqzhIl2SIpOWdiQruHlKw3YF+FhxXmq8VtwR88QK24HzeSiDfUcAIcXFMz5GNQWWnRlSXZQcMXSetIo87pt8px4=
X-Received: by 2002:aca:da06:: with SMTP id r6mr3977498oig.82.1573565216086;
 Tue, 12 Nov 2019 05:26:56 -0800 (PST)
MIME-Version: 1.0
References: <cf18270c-aa9f-fe32-ada8-fdf825246840@streamunlimited.com>
In-Reply-To: <cf18270c-aa9f-fe32-ada8-fdf825246840@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 12 Nov 2019 15:26:43 +0200
Message-ID: <CABBYNZJgoZCGOoisxi8hOs8qVnJT7Yj39xNQeMLFRgT8icRi1A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] core/advertising: Fix crash when unregistering
 advertisement too fast
To:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Simon,

On Tue, Nov 12, 2019 at 3:13 PM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> When advertisement is unregistered during MGMT_OP_ADD_ADVERTISING it will
> crash in add_adv_callback because struct btd_adv_client no longer exist.
>
> This is seen also in debug log from bluetoothd:
> bluetoothd[29698]: src/advertising.c:register_advertisement()
> RegisterAdvertisement
> bluetoothd[29698]: src/advertising.c:client_create() Adding proxy for
> /org/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:register_advertisement() Registered
> advertisement at path /org/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:parse_service_uuids() Adding
> ServiceUUID: 180D
> bluetoothd[29698]: src/advertising.c:parse_service_uuids() Adding
> ServiceUUID: 180F
> bluetoothd[29698]: src/advertising.c:parse_manufacturer_data() Adding
> ManufacturerData for ffff
> bluetoothd[29698]: src/advertising.c:parse_service_data() Adding
> ServiceData for 9999
> bluetoothd[29698]: src/advertising.c:parse_data() Adding Data for type
> 0x26 len 3
> bluetoothd[29698]: src/advertising.c:refresh_adv() Refreshing
> advertisement: /org/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:unregister_advertisement()
> UnregisterAdvertisement
> bluetoothd[29698]: src/advertising.c:add_adv_callback() Advertisement
> registered: =EF=BF=BD
> Segmentation fault (core dumped)
>
> Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
> ---
> src/advertising.c | 34 ++++++++++++++++++++++++++--------
> 1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 3ed1376..f53c14c 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -73,6 +73,7 @@ struct btd_adv_client {
> uint16_t discoverable_to;
> unsigned int to_id;
> unsigned int disc_to_id;
> + unsigned int add_adv_id;
> GDBusClient *client;
> GDBusProxy *proxy;
> DBusMessage *reg;
> @@ -117,6 +118,15 @@ static void client_free(void *data)
> g_dbus_client_unref(client->client);
> }
> + if (client->reg) {
> + g_dbus_send_message(btd_get_dbus_connection(),
> + dbus_message_new_method_return(client->reg));
> + dbus_message_unref(client->reg);
> + }
> +
> + if (client->add_adv_id)
> + mgmt_cancel(client->manager->mgmt, client->add_adv_id);
> +
> if (client->instance)
> util_clear_uid(&client->manager->instance_bitmap,
> client->instance);
> @@ -765,7 +775,8 @@ static uint8_t *generate_scan_rsp(struct
> btd_adv_client *client,
> return bt_ad_generate(client->scan, len);
> }
> -static int refresh_adv(struct btd_adv_client *client,
> mgmt_request_func_t func)
> +static int refresh_adv(struct btd_adv_client *client,
> mgmt_request_func_t func,
> + unsigned int *mgmt_id)
> {
> struct mgmt_cp_add_advertising *cp;
> uint8_t param_len;
> @@ -774,6 +785,7 @@ static int refresh_adv(struct btd_adv_client
> *client, mgmt_request_func_t func)
> uint8_t *scan_rsp;
> size_t scan_rsp_len =3D -1;
> uint32_t flags =3D 0;
> + unsigned int mgmt_ret;
> DBG("Refreshing advertisement: %s", client->path);
> @@ -822,13 +834,17 @@ static int refresh_adv(struct btd_adv_client
> *client, mgmt_request_func_t func)
> free(adv_data);
> free(scan_rsp);
> - if (!mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
> - client->manager->mgmt_index, param_len, cp,
> - func, client, NULL)) {
> + mgmt_ret =3D mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
> + client->manager->mgmt_index, param_len, cp,
> + func, client, NULL);
> +
> + if (!mgmt_ret) {
> error("Failed to add Advertising Data");
> free(cp);
> return -EINVAL;
> }
> + if (mgmt_id)
> + *mgmt_id =3D mgmt_ret;
> free(cp);
> @@ -845,7 +861,7 @@ static gboolean client_discoverable_timeout(void
> *user_data)
> bt_ad_clear_flags(client->data);
> - refresh_adv(client, NULL);
> + refresh_adv(client, NULL, NULL);
> return FALSE;
> }
> @@ -948,7 +964,7 @@ static void properties_changed(GDBusProxy *proxy,
> const char *name,
> continue;
> if (parser->func(iter, client)) {
> - refresh_adv(client, NULL);
> + refresh_adv(client, NULL, NULL);
> break;
> }
> }
> @@ -980,6 +996,8 @@ static void add_adv_callback(uint8_t status,
> uint16_t length,
> struct btd_adv_client *client =3D user_data;
> const struct mgmt_rp_add_advertising *rp =3D param;
> + client->add_adv_id =3D 0;
> +
> if (status)
> goto done;
> @@ -1059,7 +1077,7 @@ static DBusMessage *parse_advertisement(struct
> btd_adv_client *client)
> goto fail;
> }
> - err =3D refresh_adv(client, add_adv_callback);
> + err =3D refresh_adv(client, add_adv_callback, &client->add_adv_id);
> if (!err)
> return NULL;
> @@ -1449,7 +1467,7 @@ void btd_adv_manager_destroy(struct
> btd_adv_manager *manager)
> static void manager_refresh(void *data, void *user_data)
> {
> - refresh_adv(data, user_data);
> + refresh_adv(data, user_data, NULL);
> }
> void btd_adv_manager_refresh(struct btd_adv_manager *manager)
>
> --
> 2.7.4

Looks like this patch is mangled, there is no leading tabs for
indentation, etc, check out our HACKING document it contain
instruction on how to produce valid patches:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/HACKING#n95

Sometimes this happens with certain mail server, but you can always
submit the patches with the likes of gmail since for git it doesn't
matter how you submit it since it only cares the author entry we
should be preserved regardless of the mail server you have used.

--=20
Luiz Augusto von Dentz
