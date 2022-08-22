Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C6C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 22:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbiHVWvq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 18:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHVWvp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 18:51:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86950707
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:51:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z6so17286103lfu.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jxp6Iecc1BLqjRuwsMwNFvR6AesoD6usmoO4/02ljss=;
        b=L9Pg9DgkZWFuPu8gJwYQvGopfvjd7z1f+QjUv6xRPnh1+DG7moneXQNX440UFfSzii
         F+fXhpvi2Kyzb55Z2StxU1moYuqtCa0wCgLOM7IUMAIGziShuMvZefUErhIXzQq92hM/
         R8f2mb+ubxS3e6eHYgdbYFfbJTT/+onnOYEvh7G5fkU5zcUMzuykkdcFKpalFQBqVr10
         5PWASMVE+hZupr3IR4c4IE/RKITbHFTBUWyhYX1TUTlXrVfvvAItGuYfRapjFdiQZ80C
         5Yt6nZZaZBw11mQz+nwbHOJsrXFCtmHqkZwet5tg0CKaeN1vxqdqxSDvjNEk3opfJ21z
         mdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jxp6Iecc1BLqjRuwsMwNFvR6AesoD6usmoO4/02ljss=;
        b=2mG/Q+V9ZtaKSR848qgU+fsO6BwglW8GGCLgnrkAg4Fhz/RhpjTc9TvSni08BcXQLr
         zrW0OgjjiWrGX8hqxFeDJsoM9j7WWTowMojDUlvOZmduYWfq0c8FSK+4q2leAgnWnhGP
         E01Sb4rhUvW1tov2PJiaIEnItogqy6/jJIRm/yhwOjvkr9CY7DxxY8/i5YJ7hanFCrJP
         QIxLIeNsw0U9u9jQ4c/r8wU1uJoEbIVEOiOvXN+KNNQvpMcH7jj/ocd8DIDWRRunAR5x
         M75QoghxDk8XwyydkNFebZZm2j7ty8MV9NKorJFwfLC3Rw1nvBwgRfwDekiiGCi5O8fQ
         p+zA==
X-Gm-Message-State: ACgBeo0wg4Gx8S1L8ZyCbng3uHTmqQ2739jNtFuRdm71lx4YlZXFDcek
        O4yp0zzx9aewNd1Ho3d+naZUiOZyyWoOO/LzlnjnFX/I
X-Google-Smtp-Source: AA6agR5aR4/KVXCvW1mcnKWxdX7E4Os+mQAO2JtVTGBS+cwmrFfzUCdm/Iw+JmO3lCgxuv13VttuGc89xcNhMADNCFc=
X-Received: by 2002:a05:6512:238d:b0:492:f11e:ca92 with SMTP id
 c13-20020a056512238d00b00492f11eca92mr698831lfv.26.1661208702155; Mon, 22 Aug
 2022 15:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
In-Reply-To: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 22 Aug 2022 15:51:30 -0700
Message-ID: <CABBYNZJUgTNazWNQUEsVxufkpX5g39iom-DKZqX2eTQQA+RA=A@mail.gmail.com>
Subject: Re: [Bluez PATCH] adapter: Reset pending settings when receiving MGMT error
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Sun, Aug 21, 2022 at 9:54 PM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> We set the pending settings flag when sending MGMT_SETTING_*
> commands to the MGMT layer and clear them when receiving success
> reply, but we don't clear them when receiving error reply. This
> might cause a setting to be stuck in pending state.
>
> Therefore, also clear the pending flag when receiving error.
> Furthermore, this patch also postpone setting the pending flag
> until we queue the MGMT command in order to avoid setting it too
> soon but we return early.
>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>
> ---
>
>  src/adapter.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 8 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index ec26aab1a7..4da1fcc3e5 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -640,14 +640,21 @@ static void new_settings_callback(uint16_t index, uint16_t length,
>         settings_changed(adapter, settings);
>  }
>
> +struct set_mode_data {
> +       struct btd_adapter *adapter;
> +       uint32_t setting;
> +};
> +
>  static void set_mode_complete(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data)
>  {
> -       struct btd_adapter *adapter = user_data;
> +       struct set_mode_data *data = user_data;
> +       struct btd_adapter *adapter = data->adapter;
>
>         if (status != MGMT_STATUS_SUCCESS) {
>                 btd_error(adapter->dev_id, "Failed to set mode: %s (0x%02x)",
>                                                 mgmt_errstr(status), status);
> +               adapter->pending_settings &= ~data->setting;
>                 return;
>         }
>
> @@ -677,6 +684,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>  {
>         struct mgmt_mode cp;
>         uint32_t setting = 0;
> +       struct set_mode_data *data;
>
>         memset(&cp, 0, sizeof(cp));
>         cp.val = mode;
> @@ -699,15 +707,23 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
>                 break;
>         }
>
> -       adapter->pending_settings |= setting;
> -
>         DBG("sending set mode command for index %u", adapter->dev_id);
>
> +       data = g_try_new0(struct set_mode_data, 1);

Use new0 instead of g_try_new0.

> +       if (!data)
> +               goto failed;
> +
> +       data->adapter = adapter;
> +       data->setting = setting;
> +
>         if (mgmt_send(adapter->mgmt, opcode,
>                                 adapter->dev_id, sizeof(cp), &cp,
> -                               set_mode_complete, adapter, NULL) > 0)
> +                               set_mode_complete, data, g_free) > 0) {
> +               adapter->pending_settings |= setting;
>                 return true;
> +       }
>
> +failed:
>         btd_error(adapter->dev_id, "Failed to set mode for index %u",
>                                                         adapter->dev_id);
>
> @@ -718,6 +734,7 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
>                                                         uint16_t timeout)
>  {
>         struct mgmt_cp_set_discoverable cp;
> +       struct set_mode_data *data;
>
>         memset(&cp, 0, sizeof(cp));
>         cp.val = mode;
> @@ -734,11 +751,19 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
>                                                                         mode);
>         }
>
> +       data = g_try_new0(struct set_mode_data, 1);
> +       if (!data)
> +               goto failed;
> +
> +       data->adapter = adapter;
> +       data->setting = 0;
> +
>         if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DISCOVERABLE,
>                                 adapter->dev_id, sizeof(cp), &cp,
> -                               set_mode_complete, adapter, NULL) > 0)
> +                               set_mode_complete, data, g_free) > 0)
>                 return true;
>
> +failed:
>         btd_error(adapter->dev_id, "Failed to set mode for index %u",
>                                                         adapter->dev_id);

Looks like the data pointer is leaked in case it fails to be sent/queued.

> @@ -2877,6 +2902,7 @@ static gboolean property_get_mode(struct btd_adapter *adapter,
>
>  struct property_set_data {
>         struct btd_adapter *adapter;
> +       uint32_t setting;
>         GDBusPendingPropertySet id;
>  };
>
> @@ -2901,6 +2927,8 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
>
>                 g_dbus_pending_property_error(data->id, dbus_err,
>                                                         mgmt_errstr(status));
> +
> +               adapter->pending_settings &= ~data->setting;
>                 return;
>         }
>
> @@ -2969,8 +2997,6 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>
>         mode = (enable == TRUE) ? 0x01 : 0x00;
>
> -       adapter->pending_settings |= setting;
> -
>         switch (setting) {
>         case MGMT_SETTING_POWERED:
>                 opcode = MGMT_OP_SET_POWERED;
> @@ -3024,11 +3050,14 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
>                 goto failed;
>
>         data->adapter = adapter;
> +       data->setting = setting;
>         data->id = id;
>
>         if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
> -                       property_set_mode_complete, data, g_free) > 0)
> +                       property_set_mode_complete, data, g_free) > 0) {
> +               adapter->pending_settings |= setting;
>                 return;
> +       }
>
>         g_free(data);
>
> --
> 2.37.1.595.g718a3a8f04-goog

-- 
Luiz Augusto von Dentz
