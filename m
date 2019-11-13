Return-Path: <SRS0=sa5O=ZF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2455C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 11:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA57222CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Nov 2019 11:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uP0aHdfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfKMLrK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:47:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40037 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfKMLrK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Nov 2019 06:47:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id 22so1482408oip.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2019 03:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QFpRVAgu0f6EbmXQj8RhV5UqoMyRBwZ4Ty9fHXr+Nzc=;
        b=uP0aHdfEjJ02Nv5DZPAWXLjRYy2/MmcTVnFC2BUHpbYgtOQbGiYQKunAKkroUsD9oX
         AM2jtYe4lgnKVekypuSnjRbovkwZArDC0MuY3Jo57NNPg9+Wti5ACPxu/u2H29TIYj0S
         xCQ9grZQqm0UNfvFHoROvnpS3TqelV5rcoiy6XN7O+kC/3vPlpCOw13LDLSfkJ8n4F28
         JQ/KrzPGjd8YjBPwseA6cbxxsGmzBrNnBq1eX6RkFU0U9deNN8XagS7nz24wc/5xRY8I
         28+6sFGlvq8PROHfZU+4RDhL9Gwqgitvcq0bWHQCZVumCvBhP2QSbVQQ5oFEHksJwa5B
         2/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QFpRVAgu0f6EbmXQj8RhV5UqoMyRBwZ4Ty9fHXr+Nzc=;
        b=b38FjdA7zZXHWeOL/LNsHhqyohcnJSaU4efYvUm92t5l6opOkNjd+Z8BQpxl/ZPWQ4
         F6nA0RyDHlvxF8ZFMvC1JBE8F1AylY9AwyUVe6Lb1YZ0iLqcEdDibsiyxpgKnvhHWjo7
         S5jAOhEEI7GYn3Nbu5H5OQciroDTEVot2+vHSlQJwXsvSR3TUQ+HDiDcYTl70CkWHHY3
         zNqgyax8IAmvMcJSblSMkr0hQ580MI/QhyS7lILUw/XgvqYTykd7eFWnfAX4CO3P/zf6
         Ck/mPqVj2bjQ6/25nNdQmI8ALlVuvqXyc2DmM77PY/OLY3O8PHICr8JuEuccS/GwJphE
         bgHg==
X-Gm-Message-State: APjAAAVo1VShLc8Sp9MIQuCOc0kiq2Qx5dXmsNVFmF8L7Ew3JesMxT4d
        DA3UErZzVvL/7tvqjAyopurgcGizi8iDvir56vqyCZcTxcs=
X-Google-Smtp-Source: APXvYqycrHJHdWNqQQHzgu81H4ZNEXPiW2XxtoYCUn33PAeGe0cC7Z1Lza5R1O5oNiE7i5SstvAlo/TGVr9zL0e+Wps=
X-Received: by 2002:aca:da06:: with SMTP id r6mr2626985oig.82.1573645628330;
 Wed, 13 Nov 2019 03:47:08 -0800 (PST)
MIME-Version: 1.0
References: <1573566995-8482-1-git-send-email-simon.mikuda@streamunlimited.com>
In-Reply-To: <1573566995-8482-1-git-send-email-simon.mikuda@streamunlimited.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Nov 2019 13:46:54 +0200
Message-ID: <CABBYNZKh-Mn0o4zi7FprFnb3ykc95-TB6aZu1GkexU1Df7U2jA@mail.gmail.com>
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

Hi,

On Tue, Nov 12, 2019 at 3:59 PM Simon Mikuda
<simon.mikuda@streamunlimited.com> wrote:
>
> When advertisement is unregistered during MGMT_OP_ADD_ADVERTISING it will
> crash in add_adv_callback because struct btd_adv_client no longer exist.
>
> This is seen also in debug log from bluetoothd:
> bluetoothd[29698]: src/advertising.c:register_advertisement() RegisterAdv=
ertisement
> bluetoothd[29698]: src/advertising.c:client_create() Adding proxy for /or=
g/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:register_advertisement() Registered =
advertisement at path /org/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:parse_service_uuids() Adding Service=
UUID: 180D
> bluetoothd[29698]: src/advertising.c:parse_service_uuids() Adding Service=
UUID: 180F
> bluetoothd[29698]: src/advertising.c:parse_manufacturer_data() Adding Man=
ufacturerData for ffff
> bluetoothd[29698]: src/advertising.c:parse_service_data() Adding ServiceD=
ata for 9999
> bluetoothd[29698]: src/advertising.c:parse_data() Adding Data for type 0x=
26 len 3
> bluetoothd[29698]: src/advertising.c:refresh_adv() Refreshing advertiseme=
nt: /org/bluez/example/advertisement0
> bluetoothd[29698]: src/advertising.c:unregister_advertisement() Unregiste=
rAdvertisement
> bluetoothd[29698]: src/advertising.c:add_adv_callback() Advertisement reg=
istered: =EF=BF=BD
> Segmentation fault (core dumped)
>
> Signed-off-by: Simon Mikuda <simon.mikuda@streamunlimited.com>
> ---
>  src/advertising.c | 34 ++++++++++++++++++++++++++--------
>  1 file changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 3ed1376..f53c14c 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -73,6 +73,7 @@ struct btd_adv_client {
>         uint16_t discoverable_to;
>         unsigned int to_id;
>         unsigned int disc_to_id;
> +       unsigned int add_adv_id;
>         GDBusClient *client;
>         GDBusProxy *proxy;
>         DBusMessage *reg;
> @@ -117,6 +118,15 @@ static void client_free(void *data)
>                 g_dbus_client_unref(client->client);
>         }
>
> +       if (client->reg) {
> +               g_dbus_send_message(btd_get_dbus_connection(),
> +                               dbus_message_new_method_return(client->re=
g));
> +               dbus_message_unref(client->reg);
> +       }
> +
> +       if (client->add_adv_id)
> +               mgmt_cancel(client->manager->mgmt, client->add_adv_id);
> +
>         if (client->instance)
>                 util_clear_uid(&client->manager->instance_bitmap,
>                                                 client->instance);
> @@ -765,7 +775,8 @@ static uint8_t *generate_scan_rsp(struct btd_adv_clie=
nt *client,
>         return bt_ad_generate(client->scan, len);
>  }
>
> -static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_=
t func)
> +static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_=
t func,
> +                                               unsigned int *mgmt_id)
>  {
>         struct mgmt_cp_add_advertising *cp;
>         uint8_t param_len;
> @@ -774,6 +785,7 @@ static int refresh_adv(struct btd_adv_client *client,=
 mgmt_request_func_t func)
>         uint8_t *scan_rsp;
>         size_t scan_rsp_len =3D -1;
>         uint32_t flags =3D 0;
> +       unsigned int mgmt_ret;
>
>         DBG("Refreshing advertisement: %s", client->path);
>
> @@ -822,13 +834,17 @@ static int refresh_adv(struct btd_adv_client *clien=
t, mgmt_request_func_t func)
>         free(adv_data);
>         free(scan_rsp);
>
> -       if (!mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTISING,
> -                               client->manager->mgmt_index, param_len, c=
p,
> -                               func, client, NULL)) {
> +       mgmt_ret =3D mgmt_send(client->manager->mgmt, MGMT_OP_ADD_ADVERTI=
SING,
> +                       client->manager->mgmt_index, param_len, cp,
> +                       func, client, NULL);
> +
> +       if (!mgmt_ret) {
>                 error("Failed to add Advertising Data");
>                 free(cp);
>                 return -EINVAL;
>         }
> +       if (mgmt_id)
> +               *mgmt_id =3D mgmt_ret;
>
>         free(cp);
>
> @@ -845,7 +861,7 @@ static gboolean client_discoverable_timeout(void *use=
r_data)
>
>         bt_ad_clear_flags(client->data);
>
> -       refresh_adv(client, NULL);
> +       refresh_adv(client, NULL, NULL);
>
>         return FALSE;
>  }
> @@ -948,7 +964,7 @@ static void properties_changed(GDBusProxy *proxy, con=
st char *name,
>                         continue;
>
>                 if (parser->func(iter, client)) {
> -                       refresh_adv(client, NULL);
> +                       refresh_adv(client, NULL, NULL);
>                         break;
>                 }
>         }
> @@ -980,6 +996,8 @@ static void add_adv_callback(uint8_t status, uint16_t=
 length,
>         struct btd_adv_client *client =3D user_data;
>         const struct mgmt_rp_add_advertising *rp =3D param;
>
> +       client->add_adv_id =3D 0;
> +
>         if (status)
>                 goto done;
>
> @@ -1059,7 +1077,7 @@ static DBusMessage *parse_advertisement(struct btd_=
adv_client *client)
>                 goto fail;
>         }
>
> -       err =3D refresh_adv(client, add_adv_callback);
> +       err =3D refresh_adv(client, add_adv_callback, &client->add_adv_id=
);
>         if (!err)
>                 return NULL;
>
> @@ -1449,7 +1467,7 @@ void btd_adv_manager_destroy(struct btd_adv_manager=
 *manager)
>
>  static void manager_refresh(void *data, void *user_data)
>  {
> -       refresh_adv(data, user_data);
> +       refresh_adv(data, user_data, NULL);
>  }
>
>  void btd_adv_manager_refresh(struct btd_adv_manager *manager)
> --
> 2.7.4

Applied, thanks.

--=20
Luiz Augusto von Dentz
