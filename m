Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E1FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 08:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4992070A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 08:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VM3ePbN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHDI0R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHDI0Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 04:26:16 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796D4C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2020 01:26:16 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d190so1842202wmd.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2020 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmhpbFxvmBbgjVB2bV0hQ83JX8ki51Di/oiDIdD0E/E=;
        b=VM3ePbN/e5INfOwzMov5hPHI8qXwyNzrfU00D99uNUq5g8N8fSiddQ+Q1YKOTDYOlM
         lJoVOe/sZIyO0p7ePv8H6S6zvCU83OmYknSzIARLgFTaGLekMqjDS7tCmsfjcq3GUwZ3
         UX8I3ZJaE6ynQabGBF+kN2+I2swIMVp++muao/3uZQEQPiOz5vmMKS5jJS74llPNsZrh
         vT7Fw3OYki/MRC8cCHmGgRK23shEqlp6/WZ3jh9bG8iu93YmlgsQEVN3KOGZho1Gg1px
         YI9W9w6DB2k8MshzGl9Wt5CpnTUmZNUqRG/0YUT+dZ2Yo5oSpvfthlxpnxC/OwajdW0q
         1pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmhpbFxvmBbgjVB2bV0hQ83JX8ki51Di/oiDIdD0E/E=;
        b=TJTwF0F3/BFY4I6vHIP3JSNI8F3hnCg/Vz5sLIRV+NmHhcKLzh9QIxvvo6B+o0IS3+
         9A2k9BD0vSbEJjPGPTUyF55ZHiT9O2wWblEQ9QUHjSBCP1WROYlsjC8WJAI41Cyf9xWl
         fGWNBd5ErgJNZUCUcKKrfq0DvuJ/ILqGeTh2PK0qo6a2ZEmZ5EwMk7HGss8BpDrABUF5
         VmcosCM+lh22RaK64PygOx7aHiD4UyJLlBf4ECXsanShLWxN/UnZyf1nm6otv2XYTFCq
         E9HU5wHmP03Xh6OzoPLlGZqkXXHOyiBfZsDTMqqCLuF+Aa+SECd9OhmQ+y8ceGFkaKxQ
         5MxA==
X-Gm-Message-State: AOAM531UVewj+WBbqohReP4U7u8mzSrU2QyzsUrHWgb35Ug9UWS+Z6qI
        26Cu1pq3vT0lid3y2STc+QkIKExzFpeayAmzf9oWMw==
X-Google-Smtp-Source: ABdhPJzxN4iIqZdjFRj0uyx+TuEAxJhistbvKxXRT5tSjRUz7X7Ef5mG/jfNrNe8TvjwpNhyDCs61srirly3IKE6+3I=
X-Received: by 2002:a1c:9e84:: with SMTP id h126mr2790856wme.61.1596529574769;
 Tue, 04 Aug 2020 01:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200708121928.bluez.v2.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
In-Reply-To: <20200708121928.bluez.v2.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
From:   Archie Pusaka <apusaka@google.com>
Date:   Tue, 4 Aug 2020 16:26:03 +0800
Message-ID: <CAJQfnxEBjHMAO=kTqRBExgS40g7=OJbv-NOTE1V=PM=K1sdGcw@mail.gmail.com>
Subject: Re: [bluez PATCH v2] avrcp: include all player settings in notif event
To:     Howard Chung <howardchung@google.com>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bluez maintainers,

Could you take a look at this fix?
Thank you!

Regards,
Archie


On Wed, 8 Jul 2020 at 12:19, Howard Chung <howardchung@google.com> wrote:
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
> Changes in v2:
> - Fixed unused variables
>
>  profiles/audio/avrcp.c | 71 +++++++++++++++++++-----------------------
>  1 file changed, 32 insertions(+), 39 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index e2428250e..a4de7530e 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -369,6 +369,7 @@ static uint32_t company_ids[] = {
>  };
>
>  static void avrcp_register_notification(struct avrcp *session, uint8_t event);
> +static GList *player_list_settings(struct avrcp_player *player);
>
>  static sdp_record_t *avrcp_ct_record(void)
>  {
> @@ -743,6 +744,35 @@ static int play_status_to_val(const char *status)
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
> @@ -751,8 +781,6 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
>         uint8_t code;
>         uint16_t size;
>         GSList *l;
> -       int attr;
> -       int val;
>
>         if (player->sessions == NULL)
>                 return;
> @@ -791,19 +819,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
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
> @@ -1595,7 +1611,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
>         struct btd_device *dev = session->dev;
>         uint16_t len = ntohs(pdu->params_len);
>         uint64_t uid;
> -       GList *settings;
>
>         /*
>          * 1 byte for EventID, 4 bytes for Playback interval but the latest
> @@ -1626,29 +1641,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
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
> 2.27.0.383.g050319c2ae-goog
>
