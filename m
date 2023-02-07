Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82469C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 01:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjBGB2H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 20:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBGB2F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 20:28:05 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CA12C640
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 17:28:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h24so20305197lfv.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 17:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=etRg2es5YcQvfpAUqfJ4d11wf4/wyrHxBOp8wk3//AA=;
        b=QWJDQ7rtGe91sh+PfRKaDN2DkpKmdg5shNmv7WlQf64gPMqV91JuxcKxwj/pXaDSeb
         SwHYRpGZ0xgdtYjJlPDelCAJWqtLGQMzF5HP75VJPlQXIFSKu3AdhAdh3hjKJvfeBC8I
         LOn24HHsnPWxPheCmhyrQ34P/ci/0O+X71ixsq+YgSBS4O3VWNoDnFcHW3mw6lr8vy8J
         c9eLhUyb78TABWsV4mdN7+/Am2nljPP79jjzajYaGkH9kj+LYBQNFYXYeMGAxhToTOZS
         6sRmshBzui5HyQAdQWw7n7X15PLVxiTOwAl6tTTfVTgNhYVw3Ev2fF2g1F0ZTLmwjgGC
         UPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etRg2es5YcQvfpAUqfJ4d11wf4/wyrHxBOp8wk3//AA=;
        b=gWinzMstkXpwtV0QqAmKOEBArKYDU4rcxQ4Im3UNWojnsFAHqmpT1ts5U87qoVXg6q
         8g9mGnCHeFejAVUWJ7rrU2kDh4pIynCN2CyP6bVb2fnpvvxnGF3WOdoS/BpjiA5qaMqA
         YQTxW8DA/9vxrSDSp78UqBSX/7xeev7n0yPtScTx7nsF4EwQYxOEgMu2cxENkGN/jmcn
         BNw4c0ABt52bJe/Bqi299il/ilvDzVAEWFr1FcpHfH0AiWhqTFv0RaoUskLZtSOoeXGE
         TGvgeiVtKWyumsWUcboFvMJJAx6jBctG4XkNuUpe9Wyq0KVW5rnXAA3mhTTsNbx7vMsN
         hC9g==
X-Gm-Message-State: AO0yUKWXVvM211itS0rrclIrkrLWiIHGY6PwNrDIy468z+OTv1ikEr5y
        CJjFCjqidl3wgbeUviOYSuLc3cd8Mg8gGJG1z12tn1FF
X-Google-Smtp-Source: AK7set9jaB2dEU4mi/lmYnFx0jxipS53CBv6xN9a+cHmtVCkvnTLqGug+fNxRQJMwP+dLS2Dl9GbmfWi3j0r2fy6KdE=
X-Received: by 2002:a05:6512:40d:b0:4d8:5137:a89d with SMTP id
 u13-20020a056512040d00b004d85137a89dmr163420lfk.176.1675733282591; Mon, 06
 Feb 2023 17:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20230127205205.20235-1-pav@iki.fi> <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
 <89c50cadaefa56c85346ad7f2cd86eab756f3987.1675103676.git.pav@iki.fi>
In-Reply-To: <89c50cadaefa56c85346ad7f2cd86eab756f3987.1675103676.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Feb 2023 17:27:51 -0800
Message-ID: <CABBYNZ+VXvRHP1h9W6_EhdVOx+He+=yCdoTC2619q74+Uvn8vA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 8/8] bap: handle adapters that are not CIS Central /
 Peripheral capable
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Jan 30, 2023 at 11:06 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> When BT adapter is not CIS Peripheral capable, use the shared/bap code
> in its central-only mode, and don't register anything in the local GATT
> database.
>
> When BT adapter is not CIS Central capable, ignore the remote device
> GATT database, so that we work purely in peripheral mode.
>
> If BT adapter supports neither feature, don't do anything with BAP.
> ---
>  profiles/audio/bap.c   | 18 ++++++++++++++++--
>  profiles/audio/media.c | 11 ++++++-----
>  2 files changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> index e5ffb7230..28c0d139a 100644
> --- a/profiles/audio/bap.c
> +++ b/profiles/audio/bap.c
> @@ -1254,6 +1254,8 @@ static int bap_probe(struct btd_service *service)
>         struct btd_adapter *adapter = device_get_adapter(device);
>         struct btd_gatt_database *database = btd_adapter_get_database(adapter);
>         struct bap_data *data = btd_service_get_user_data(service);
> +       struct bt_bap_db *ldb;
> +       struct gatt_db *device_db;
>         char addr[18];
>
>         ba2str(device_get_address(device), addr);
> @@ -1264,17 +1266,29 @@ static int bap_probe(struct btd_service *service)
>                 return -ENOTSUP;
>         }
>
> +       if (!btd_adapter_cis_central_capable(adapter) &&
> +           !btd_adapter_cis_peripheral_capable(adapter)) {
> +               DBG("BAP requires CIS features, unsupported by adapter");
> +               return -ENOTSUP;
> +       }
> +
>         /* Ignore, if we were probed for this device already */
>         if (data) {
>                 error("Profile probed twice for the same device!");
>                 return -EINVAL;
>         }
>
> +       if (btd_adapter_cis_central_capable(adapter))
> +               device_db = btd_device_get_gatt_db(device);
> +       else
> +               device_db = NULL;
> +
>         data = bap_data_new(device);
>         data->service = service;
>
> -       data->bap = bt_bap_new(btd_gatt_database_get_db(database),
> -                                       btd_device_get_gatt_db(device));
> +       ldb = bt_bap_get_local_db(btd_gatt_database_get_db(database),
> +                               btd_adapter_cis_peripheral_capable(adapter));

Don't really like the idea of having an API to access the bt_bap_db,
can we just pass NULL to ldb as before? We can work out internally in
bap.c to handle this properly.

> +       data->bap = bt_bap_new(ldb, device_db);
>         if (!data->bap) {
>                 error("Unable to create BAP instance");
>                 free(data);
> diff --git a/profiles/audio/media.c b/profiles/audio/media.c
> index d68085514..6f83b03b5 100644
> --- a/profiles/audio/media.c
> +++ b/profiles/audio/media.c
> @@ -1105,8 +1105,9 @@ static void bap_debug(const char *str, void *user_data)
>  static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
>                                                                 int *err)
>  {
> +       struct btd_adapter *adapter = endpoint->adapter->btd_adapter;
>         struct btd_gatt_database *database;
> -       struct gatt_db *db;
> +       struct bt_bap_db *ldb;
>         struct iovec data;
>         char *name;
>
> @@ -1116,7 +1117,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
>                 return false;
>         }
>
> -       database = btd_adapter_get_database(endpoint->adapter->btd_adapter);
> +       database = btd_adapter_get_database(adapter);
>         if (!database) {
>                 error("Adapter database not found");
>                 return false;
> @@ -1128,8 +1129,6 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
>                 return false;
>         }
>
> -       db = btd_gatt_database_get_db(database);
> -
>         data.iov_base = endpoint->capabilities;
>         data.iov_len = endpoint->size;
>
> @@ -1141,7 +1140,9 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
>                 return false;
>         }
>
> -       endpoint->pac = bt_bap_add_pac(db, name, type, endpoint->codec,
> +       ldb = bt_bap_get_local_db(btd_gatt_database_get_db(database),
> +                               btd_adapter_cis_peripheral_capable(adapter));
> +       endpoint->pac = bt_bap_add_pac(ldb, name, type, endpoint->codec,
>                                         &endpoint->qos, &data, NULL);
>         if (!endpoint->pac) {
>                 error("Unable to create PAC");
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
