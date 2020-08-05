Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73184C433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 19:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A1C2076E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 19:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o44XPh0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgHETvM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgHETuw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 15:50:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8EC061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2020 12:50:52 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id e6so20473090oii.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2020 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uvhSulsTo3IYqkmirIw+uCMi1pBoea9+GY2Ru9yZyY=;
        b=o44XPh0hnxv6lw/4AMZHgdfmf/+lWcU04OKR3IjWzINiSv5taRh+U6neT/ONZz06rJ
         0DL+4vvgGOERkOYfAaokmDH70dpTm0uRANPyh+ZlOLNoIgn8/WquQ8RtmYkFB9F/1Yff
         EyFUGY9EcOoYaC0NJzRMzg9lxCHkOQ+P2TUCdZFXaKX08L1Uai3wZtxmjQ70pu6TP3hO
         dWAIGBQjnX21mfQISf9Es7yqCKGRUBv3+cyGOruzrRSTjbY3weCnKlIXeGyFHHk4q4NM
         heosTO6q/L8I2B6yMazu1M+rhHATol5t9N/WguRMPUM4ymSpBaIwW6YQmKDP25r2F7EA
         XBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uvhSulsTo3IYqkmirIw+uCMi1pBoea9+GY2Ru9yZyY=;
        b=KQCv+PrKyiRW3DTTMj8AWqh39gI3IT7QeOcCfUiqFB6xFZiwzEoi9hdfeMTRk1H6F1
         99XB+vK6BvNttBxXXVmF7wFUIQ9ilgr/mRgpJFwPgPvdZZ4bN4Vb80A3NjPZ4nKyB1VV
         aFPABDd/5CivqRD09At2/9An39dFOoDN/4CQyHvqROVGKfNYa8UhnvWeQZ0pnYBZibY+
         2AiqGXzdGUNLRZI4QRVs4btQp5v2WtccXsbQM1kShStmdI+qdKsYlXSxenr+G08fmmB4
         ZAXCD5CpIY2xShcYUVtO3lAEnDjvpeb5Ta23BwYW8taUWzVgXVB281tQyDE9hrCgnxwH
         UNdA==
X-Gm-Message-State: AOAM531wsvuWE8Gpjs532dAGUI125wsgdn6nhtFoEI5FIURyCcnfGR9w
        tWKAGGtn0KPJPu7rZ0w+0KfRKrtAyH98J+2Y+H0=
X-Google-Smtp-Source: ABdhPJznKOj8VOEhnUGQLG9tX/RNqeFHc58b//dIUARm2o/sHJW+kStwIyCsk09ur2uqfhHAkhcpS21orBtUUj4j2pc=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr3948006oig.152.1596657051339;
 Wed, 05 Aug 2020 12:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200805100342.bluez.v3.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
In-Reply-To: <20200805100342.bluez.v3.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 Aug 2020 12:50:41 -0700
Message-ID: <CABBYNZ+=ZjPe147Jr8vEVCRixjFoq9xMYWObOLYHErGF3e5DCg@mail.gmail.com>
Subject: Re: [bluez PATCH v3] avrcp: include all player settings in notif event
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Tue, Aug 4, 2020 at 7:06 PM Howard Chung <howardchung@google.com> wrote:
>
> According to AVRCP 1.6.2 spec section 6.7.2 table 6.39, all player
> application settings should be returned to the CT and let CT to
> determine which settings have changed. Currently bluez only returns
> the changed attribute instead. This patch also addresses a potential
> issue on which the number of application settings mismatches with
> the actual number returned.
>
> Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> ---
>
> Changes in v3:
> - Rebase to master
>
> Changes in v2:
> - Fixed unused variables
>
>  profiles/audio/avrcp.c | 71 +++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 39 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 4e7ff75c0..5d0256c52 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -370,6 +370,7 @@ static uint32_t company_ids[] = {
>  };
>
>  static void avrcp_register_notification(struct avrcp *session, uint8_t event);
> +static GList *player_list_settings(struct avrcp_player *player);
>
>  static sdp_record_t *avrcp_ct_record(void)
>  {
> @@ -744,6 +745,35 @@ static int play_status_to_val(const char *status)
>         return -EINVAL;
>  }
>
> +static uint16_t player_settings_changed(struct avrcp_player *player,
> +                                               struct avrcp_header *pdu)
> +{
> +       GList *settings = player_list_settings(player);
> +       int size = 2;
> +
> +       for (; settings; settings = settings->next) {
> +               const char *key = settings->data;
> +               int attr;
> +               int val;
> +
> +               attr = attr_to_val(key);
> +               if (attr < 0)
> +                       continue;
> +
> +               val = player_get_setting(player, attr);
> +               if (val < 0)
> +                       continue;
> +
> +               pdu->params[size++] = attr;
> +               pdu->params[size++] = val;
> +       }
> +
> +       g_list_free(settings);
> +
> +       pdu->params[1] = (size - 2) >> 1;
> +       return size;
> +}
> +
>  void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>                                                         const void *data)
>  {
> @@ -752,8 +782,6 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>         uint8_t code;
>         uint16_t size;
>         GSList *l;
> -       int attr;
> -       int val;
>
>         if (player->sessions == NULL)
>                 return;
> @@ -792,19 +820,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>                 size = 1;
>                 break;
>         case AVRCP_EVENT_SETTINGS_CHANGED:
> -               size = 2;
> -               pdu->params[1] = 1;
> -
> -               attr = attr_to_val(data);
> -               if (attr < 0)
> -                       return;
> -
> -               val = player_get_setting(player, attr);
> -               if (val < 0)
> -                       return;
> -
> -               pdu->params[size++] = attr;
> -               pdu->params[size++] = val;
> +               size = player_settings_changed(player, pdu);
>                 break;
>         case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
>                 size = 5;
> @@ -1597,7 +1613,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>         uint16_t len = ntohs(pdu->params_len);
>         uint64_t uid;
>         int8_t volume;
> -       GList *settings;
>
>         /*
>          * 1 byte for EventID, 4 bytes for Playback interval but the latest
> @@ -1628,29 +1643,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>                 len = 1;
>                 break;
>         case AVRCP_EVENT_SETTINGS_CHANGED:
> -               len = 1;
> -               settings = player_list_settings(player);
> -
> -               pdu->params[len++] = g_list_length(settings);
> -               for (; settings; settings = settings->next) {
> -                       const char *key = settings->data;
> -                       int attr;
> -                       int val;
> -
> -                       attr = attr_to_val(key);
> -                       if (attr < 0)
> -                               continue;
> -
> -                       val = player_get_setting(player, attr);
> -                       if (val < 0)
> -                               continue;
> -
> -                       pdu->params[len++] = attr;
> -                       pdu->params[len++] = val;
> -               }
> -
> -               g_list_free(settings);
> -
> +               len = player_settings_changed(player, pdu);
>                 break;
>         case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
>                 len = 5;
> --
> 2.28.0.163.g6104cc2f0b6-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
