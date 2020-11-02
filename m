Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F7AC388F9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 17:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAC021D91
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 17:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdA00Ypc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgKBRzr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBRzq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 12:55:46 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B546CC0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 09:55:46 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id 79so5958478otc.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 09:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9J+2kaBauYF/sB5Ci9b7Cub0G0NBKhvBLjAlByvt+IA=;
        b=IdA00YpcWdDeRwoOwNhLzc3LKhjJj7Dx1TVz7CGGxCr5W2RC1lOjUe+FxO2Z5b7Gqq
         skWA9sUzueYWtfjYwDzhmT0hpmuNHFYkjzner7L4DT+JQLA9cFu88M5tkaoXxb0y/8BL
         TGzoD8kK+KMWeAsNYLLBK629QPukwbHh6GDxiUqYXR/Jcyv2vPN50vuOdbf5G1K2A7+4
         07m8OGXymAiIidD8PXidLtclOz1bSmyxdIohx0Ba+y9EPBrGmzyKVMOY7EmelRyyZk4w
         ynwnpvaBhLu6GWt7lc82VFznWvIfpQ33Z+RB9rS9qMSC5iLc5Ho2mRCty6EXjtOEGVay
         teIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9J+2kaBauYF/sB5Ci9b7Cub0G0NBKhvBLjAlByvt+IA=;
        b=G4lAbYdvwI7SPHy+G5fQL2OmB8vvS/qjPIZmV8SmSKa4nqzs65BXGBMm/1+4niWCFO
         kNNdkQww8uhDh5pkId+HNGdFygidg3NhdHeHZ3AYB8xkbZZY2QTgUjdtN9hLaM9SMS06
         zRTqkRrX3cJ+QxayP1NLHM+4dNgHvKKsqINUDf1+KxAIKcAKuzVlcY3C8+N8a3je+iyl
         lF/pr/AKTutfP9jrP6Jj7X6bUleqN+jyQrcEofGlte8WxxzzSIFK/tA8uNz+4JNWXBEE
         jG6ul9NDC4m2cPbik+SsXjAdcA5M8WHWHAu1NB7N4RPbzPjKtkbPA8GKWuSNSgX8FViT
         oBrQ==
X-Gm-Message-State: AOAM530PFkyF33wQHczYDlCEweq10abwwnSGF5hXV/MfB2rR/esiJcid
        gPtvkY8T7g9Qs59Xq9t97P85slN4go1F687LLxg=
X-Google-Smtp-Source: ABdhPJy5jgrtJ3iyEEMjWkDGxr29KjUZtwco0+MYLUrXXx7/nINzAe4owMI8NYHYWhFF+M59yiMIR5sC8gIQJjjnP6Y=
X-Received: by 2002:a9d:1a9:: with SMTP id e38mr5370708ote.240.1604339746018;
 Mon, 02 Nov 2020 09:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
In-Reply-To: <20201030175219.BlueZ.v8.1.Ie670925d87068d24a6e5c2e7dd9dd0e88c89a7da@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 2 Nov 2020 09:55:35 -0800
Message-ID: <CABBYNZLOkKjgroVxCOyzg194iHVR1z6KkxaEoP5k8kLo35C1uQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH v8 1/6] shared/ad: Add support of bt_ad_pattern
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Alain Michaud <alainm@chromium.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Fri, Oct 30, 2020 at 5:56 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> This adds struct bt_ad_pattern and helpers functions to facilitate
> pattern matching.
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> Reviewed-by: Howard Chung <howardchung@google.com>
> ---
>
> Changes in v8:
> - Modify signature of ad_replace_data() to avoid memory copy
>
>  src/shared/ad.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++-
>  src/shared/ad.h |  16 +++++
>  2 files changed, 166 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/ad.c b/src/shared/ad.c
> index a34d7a147..23c8c34f4 100644
> --- a/src/shared/ad.c
> +++ b/src/shared/ad.c
> @@ -31,6 +31,12 @@ struct bt_ad {
>         struct queue *data;
>  };
>
> +struct pattern_match_info {
> +       struct bt_ad *ad;
> +       struct bt_ad_pattern *current_pattern;
> +       struct bt_ad_pattern *matched_pattern;
> +};
> +
>  struct bt_ad *bt_ad_new(void)
>  {
>         struct bt_ad *ad;
> @@ -46,6 +52,65 @@ struct bt_ad *bt_ad_new(void)
>         return bt_ad_ref(ad);
>  }
>
> +static bool ad_replace_data(struct bt_ad *ad, uint8_t type, const void *data,
> +                                                       size_t len);
> +
> +static bool ad_is_type_valid(uint8_t type)
> +{
> +       if (type > BT_AD_3D_INFO_DATA && type != BT_AD_MANUFACTURER_DATA)
> +               return false;
> +       if (type < BT_AD_FLAGS)
> +               return false;
> +
> +       return true;
> +}
> +
> +struct bt_ad *bt_ad_new_with_data(size_t len, const uint8_t *data)
> +{
> +       struct bt_ad *ad;
> +       uint16_t parsed_len = 0;
> +
> +       if (data == NULL || !len)
> +               return NULL;
> +
> +       ad = bt_ad_new();
> +       if (!ad)
> +               return NULL;
> +
> +       while (parsed_len < len - 1) {
> +               uint8_t d_len;
> +               uint8_t d_type;
> +               const uint8_t *d;
> +               uint8_t field_len = data[0];
> +
> +               if (field_len == 0)
> +                       break;
> +
> +               parsed_len += field_len + 1;
> +
> +               if (parsed_len > len)
> +                       break;
> +
> +               d = &data[2];
> +               d_type = data[1];
> +               d_len = field_len - 1;
> +
> +               if (!ad_is_type_valid(d_type))
> +                       goto failed;
> +
> +               if (!ad_replace_data(ad, d_type, d, d_len))
> +                       goto failed;
> +
> +               data += field_len + 1;
> +       }
> +
> +       return ad;
> +
> +failed:
> +       bt_ad_unref(ad);
> +       return NULL;
> +}
> +
>  struct bt_ad *bt_ad_ref(struct bt_ad *ad)
>  {
>         if (!ad)
> @@ -126,7 +191,7 @@ static bool data_type_match(const void *data, const void *user_data)
>         return a->type == type;
>  }
>
> -static bool ad_replace_data(struct bt_ad *ad, uint8_t type, void *data,
> +static bool ad_replace_data(struct bt_ad *ad, uint8_t type, const void *data,
>                                                         size_t len)
>  {
>         struct bt_ad_data *new_data;
> @@ -994,3 +1059,87 @@ void bt_ad_clear_data(struct bt_ad *ad)
>
>         queue_remove_all(ad->data, NULL, NULL, data_destroy);
>  }
> +
> +struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type, size_t offset, size_t len,
> +                                                       const uint8_t *data)
> +{
> +       struct bt_ad_pattern *pattern;
> +
> +       if (!data || !len || offset >= BT_AD_MAX_DATA_LEN ||
> +               len > BT_AD_MAX_DATA_LEN || offset + len > BT_AD_MAX_DATA_LEN) {
> +               return NULL;
> +       }
> +
> +       if (!ad_is_type_valid(type))
> +               return NULL;
> +
> +       pattern = new0(struct bt_ad_pattern, 1);
> +       if (!pattern)
> +               return NULL;
> +
> +       pattern->len = len;
> +       pattern->type = type;
> +       pattern->offset = offset;
> +       memcpy(pattern->data, data, len);
> +
> +       return pattern;
> +}
> +
> +static void pattern_ad_data_match(void *data, void *user_data)
> +{
> +       struct bt_ad_data *ad_data = data;
> +       struct pattern_match_info *info = user_data;
> +       struct bt_ad_pattern *pattern;
> +
> +       if (!ad_data || !info)
> +               return;
> +
> +       if (info->matched_pattern)
> +               return;
> +
> +       pattern = info->current_pattern;
> +
> +       if (!pattern || ad_data->type != pattern->type)
> +               return;
> +
> +       if (ad_data->len < pattern->offset + pattern->len)
> +               return;
> +
> +       if (!memcmp(ad_data->data + pattern->offset, pattern->data,
> +                                                               pattern->len)) {
> +               info->matched_pattern = pattern;
> +       }
> +}
> +
> +static void pattern_match(void *data, void *user_data)
> +{
> +       struct bt_ad_pattern *pattern = data;
> +       struct pattern_match_info *info = user_data;
> +
> +       if (!pattern || !info)
> +               return;
> +
> +       if (info->matched_pattern)
> +               return;
> +
> +       info->current_pattern = pattern;
> +
> +       bt_ad_foreach_data(info->ad, pattern_ad_data_match, info);
> +}
> +
> +struct bt_ad_pattern *bt_ad_pattern_match(struct bt_ad *ad,
> +                                                       struct queue *patterns)
> +{
> +       struct pattern_match_info info;
> +
> +       if (!ad || queue_isempty(patterns))
> +               return NULL;
> +
> +       info.ad = ad;
> +       info.matched_pattern = NULL;
> +       info.current_pattern = NULL;
> +
> +       queue_foreach(patterns, pattern_match, &info);
> +
> +       return info.matched_pattern;
> +}
> diff --git a/src/shared/ad.h b/src/shared/ad.h
> index 83eacab66..13adcb406 100644
> --- a/src/shared/ad.h
> +++ b/src/shared/ad.h
> @@ -68,6 +68,7 @@
>  typedef void (*bt_ad_func_t)(void *data, void *user_data);
>
>  struct bt_ad;
> +struct queue;
>
>  struct bt_ad_manufacturer_data {
>         uint16_t manufacturer_id;
> @@ -87,8 +88,17 @@ struct bt_ad_data {
>         size_t len;
>  };
>
> +struct bt_ad_pattern {
> +       uint8_t type;
> +       uint8_t offset;
> +       uint8_t len;
> +       uint8_t data[BT_AD_MAX_DATA_LEN];
> +};
> +
>  struct bt_ad *bt_ad_new(void);
>
> +struct bt_ad *bt_ad_new_with_data(size_t len, const uint8_t *data);
> +
>  struct bt_ad *bt_ad_ref(struct bt_ad *ad);
>
>  void bt_ad_unref(struct bt_ad *ad);
> @@ -156,3 +166,9 @@ void bt_ad_foreach_data(struct bt_ad *ad, bt_ad_func_t func, void *user_data);
>  bool bt_ad_remove_data(struct bt_ad *ad, uint8_t type);
>
>  void bt_ad_clear_data(struct bt_ad *ad);
> +
> +struct bt_ad_pattern *bt_ad_pattern_new(uint8_t type, size_t offset,
> +                                       size_t len, const uint8_t *data);
> +
> +struct bt_ad_pattern *bt_ad_pattern_match(struct bt_ad *ad,
> +                                                       struct queue *patterns);
> --
> 2.26.2

Applied, thanks.

-- 
Luiz Augusto von Dentz
