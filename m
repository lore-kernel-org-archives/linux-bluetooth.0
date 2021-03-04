Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A11C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 22:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE5B6500F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 22:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCDWtk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 17:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhCDWtj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 17:49:39 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0643C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 14:49:39 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id h22so28999629otr.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 14:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enXQih70u40ZK69urxmu8ILEAfUN29+KhOqXNbnMTrY=;
        b=JDdVEH7js76apcj2PiMeGhdZ1NRS/gP17511JNUyso7jFIlIYnwW6sbAtmh55ajOM/
         qohzB3w3vkiR22wuM/5mOrkbJQBAIS/AyOJr8fFEowMfISkUj5C5jeWHQbO4syIxjOWi
         US1TPrDoIutbN7C/P1Ika7ActxNmbFYwTeudY3aq56XCRwMxJPehfobohR5/lrzRxLQ+
         AEtHNvTzDBbTZiiX+qXbVP8exgzkp8oWvdn/NxDa/jdLoUPgsyo5wBUZMScHpaIpOqvo
         W8feQF+CLZMRt/RXX3exFdygqqJQGlVH6FWWw/4u0n3OSrAWXvSzgFpS4tt/8ZfQQIZ3
         bZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enXQih70u40ZK69urxmu8ILEAfUN29+KhOqXNbnMTrY=;
        b=mDRR5+TYsLbB/YcKDBvvAaggpeOBbvLmJtDpsnxRu8u1OdTZaGyFFCLlwTKyZ8inFV
         WbQ0jnRd/Vel6yimKOS/lFG0InBYYuy4NbRh2ZFwVsZBqRBxzcprB4gf6lxNYM0/kTKB
         DcAb46jFf1bhWi3k1GBzHJkR7PxWB2TrFYMIkp/QBkiXIT54omequQ+oYgv62EgfIr8/
         yBibDoc+cts4MSDOBZfQX2akivtyHeKh/O/NDZ6ey7r4b4rVaaaB/FomF8E0VPr7MIFU
         uCablfLhncfghyVwuzmKl3Hh/hE/ER0+uK6pydtNnzYF3JMuJTmD9Tv7aqH3xKM0jKMp
         NPFA==
X-Gm-Message-State: AOAM5338HY90TTR8PDO52a5tRDmFUql8r3Zd+bfWJxm0owMBGNlRFfgx
        xRjRoS+F6ezt6OoYw3Yr5tyn9baUeWV6COS41biBnxXNiNs=
X-Google-Smtp-Source: ABdhPJwUW0vvxCtFQH2iD6hE2kXFrNyRvr9y+7KmRF87LK7cCd3oXGD4d2WJi0BRZq6cM2MCrNAWTiXcLZQHQ3IGGIg=
X-Received: by 2002:a9d:69c6:: with SMTP id v6mr5458949oto.371.1614898179018;
 Thu, 04 Mar 2021 14:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20210304202452.1998022-1-danielwinkler@google.com> <20210304122005.Bluez.v2.1.I1411482bfff45aecdec1bc8c895fc7148ee3f50c@changeid>
In-Reply-To: <20210304122005.Bluez.v2.1.I1411482bfff45aecdec1bc8c895fc7148ee3f50c@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 4 Mar 2021 14:49:27 -0800
Message-ID: <CABBYNZJoGGuiCMhV-NLQ=XmwXiJdguShA_Q9wah+qx7Fz2pwGw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/3] advertising: Generate advertising data
 earlier in pipeline
To:     Daniel Winkler <danielwinkler@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Daniel,

On Thu, Mar 4, 2021 at 12:25 PM Daniel Winkler <danielwinkler@google.com> wrote:
>
> This change moves the advertising data generation to the beginning of
> the registration pipeline. This is necessary for the following patch,
> which will need to know whether the scan response data is existent so
> that the parameter request can be populated correctly.
>
> Reviewed-by: Alain Michaud <alainm@chromium.org>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
>
> ---
>
> Changes in v2: None
>
>  src/advertising.c | 79 +++++++++++++++++++++++++----------------------
>  1 file changed, 42 insertions(+), 37 deletions(-)
>
> diff --git a/src/advertising.c b/src/advertising.c
> index 15a343e52..f3dc357a1 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -80,6 +80,10 @@ struct btd_adv_client {
>         uint32_t flags;
>         struct bt_ad *data;
>         struct bt_ad *scan;
> +       uint8_t *adv_data;
> +       uint8_t *scan_rsp;
> +       size_t adv_data_len;
> +       size_t scan_rsp_len;

I'm debating if we should really just encode it early or we could just
introduce something like bt_ad_length so we don't have to have copies
of the same data in 2 different formats since bt_ad already represents
that.

>         uint8_t instance;
>         uint32_t min_interval;
>         uint32_t max_interval;
> @@ -141,6 +145,16 @@ static void client_free(void *data)
>         bt_ad_unref(client->data);
>         bt_ad_unref(client->scan);
>
> +       if (client->adv_data) {
> +               free(client->adv_data);
> +               client->adv_data = NULL;
> +       }
> +
> +       if (client->scan_rsp) {
> +               free(client->scan_rsp);
> +               client->scan_rsp = NULL;
> +       }
> +
>         g_dbus_proxy_unref(client->proxy);
>
>         if (client->owner)
> @@ -915,6 +929,22 @@ static int refresh_extended_adv(struct btd_adv_client *client,
>                 flags |= MGMT_ADV_PARAM_TX_POWER;
>         }
>
> +       client->adv_data = generate_adv_data(client, &flags,
> +                                               &client->adv_data_len);
> +       if (!client->adv_data ||
> +               (client->adv_data_len > calc_max_adv_len(client, flags))) {
> +               error("Advertising data too long or couldn't be generated.");
> +               return -EINVAL;
> +       }
> +
> +       client->scan_rsp = generate_scan_rsp(client, &flags,
> +                                               &client->scan_rsp_len);
> +       if (!client->scan_rsp && client->scan_rsp_len) {
> +               error("Scan data couldn't be generated.");
> +               free(client->adv_data);
> +               return -EINVAL;
> +       }
> +
>         cp.flags = htobl(flags);
>
>         mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
> @@ -1222,11 +1252,6 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
>         const struct mgmt_rp_add_ext_adv_params *rp = param;
>         struct mgmt_cp_add_ext_adv_data *cp = NULL;
>         uint8_t param_len;
> -       uint8_t *adv_data = NULL;
> -       size_t adv_data_len;
> -       uint8_t *scan_rsp = NULL;
> -       size_t scan_rsp_len = -1;
> -       uint32_t flags = 0;
>         unsigned int mgmt_ret;
>         dbus_int16_t tx_power;
>
> @@ -1248,23 +1273,8 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
>
>         client->instance = rp->instance;
>
> -       flags = get_adv_flags(client);
> -
> -       adv_data = generate_adv_data(client, &flags, &adv_data_len);
> -       if (!adv_data || (adv_data_len > rp->max_adv_data_len)) {
> -               error("Advertising data too long or couldn't be generated.");
> -               goto fail;
> -       }
> -
> -       scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
> -       if ((!scan_rsp && scan_rsp_len) ||
> -                       scan_rsp_len > rp->max_scan_rsp_len) {
> -               error("Scan data couldn't be generated.");
> -               goto fail;
> -       }
> -
> -       param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
> -                                                       scan_rsp_len;
> +       param_len = sizeof(struct mgmt_cp_add_advertising) +
> +                       client->adv_data_len + client->scan_rsp_len;
>
>         cp = malloc0(param_len);
>         if (!cp) {
> @@ -1273,15 +1283,11 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
>         }
>
>         cp->instance = client->instance;
> -       cp->adv_data_len = adv_data_len;
> -       cp->scan_rsp_len = scan_rsp_len;
> -       memcpy(cp->data, adv_data, adv_data_len);
> -       memcpy(cp->data + adv_data_len, scan_rsp, scan_rsp_len);
> -
> -       free(adv_data);
> -       free(scan_rsp);
> -       adv_data = NULL;
> -       scan_rsp = NULL;
> +       cp->adv_data_len = client->adv_data_len;
> +       cp->scan_rsp_len = client->scan_rsp_len;
> +       memcpy(cp->data, client->adv_data, client->adv_data_len);
> +       memcpy(cp->data + client->adv_data_len, client->scan_rsp,
> +                       client->scan_rsp_len);
>
>         /* Submit request to update instance data */
>         mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_DATA,
> @@ -1305,12 +1311,6 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
>         return;
>
>  fail:
> -       if (adv_data)
> -               free(adv_data);
> -
> -       if (scan_rsp)
> -               free(scan_rsp);
> -
>         if (cp)
>                 free(cp);
>
> @@ -1454,6 +1454,11 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
>         if (!client->scan)
>                 goto fail;
>
> +       client->adv_data = NULL;
> +       client->scan_rsp = NULL;
> +       client->adv_data_len = 0;
> +       client->scan_rsp_len = 0;
> +
>         client->manager = manager;
>         client->appearance = UINT16_MAX;
>         client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
> --
> 2.30.1.766.gb4fecdf3b7-goog
>


-- 
Luiz Augusto von Dentz
