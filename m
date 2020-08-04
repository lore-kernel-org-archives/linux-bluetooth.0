Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32382C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F5A207FC
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 17:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je2SqnLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgHDRHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgHDRHv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 13:07:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD1BC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2020 10:07:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u24so27100830oiv.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2020 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ourZThngvCc0upPjZ1J59KAT7nWgEJLpFvhZJce+3c=;
        b=je2SqnLoGBRd0YmIG4qDEUl7wrvJRSzk0T+CrqOE0pfDNRAa375+3JMMea9NRpKuEX
         tdCApFEsZuy5POzdXRi0hGNu2EUdnPcJPdrlHAqIJcklYh7cZKndjrFq4/wodU8M7JfQ
         vaB3rcnvIKK+wIeXy4pmY+4TBw18STQq66R1n8o6GmtIxC7SeBT6kpeAHQ7QBUQGgN/+
         /qlzIRaX7dsqpmfSNO+3Pl4BuCzkyylKx0s01ax1yB+bTYeGs7ou1/5CenTs5FynHumJ
         ulxC9QbJ37iYNXxQR1VBTxXQHnriCSvPpXeMLOt56mKzTgluA7+44iJ+3BK48QZQyelV
         jy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ourZThngvCc0upPjZ1J59KAT7nWgEJLpFvhZJce+3c=;
        b=OdhRVYCxeWeNUYgZgPMk3tDrO5hqpzMWOFhK7IV9hjbYzgPlWLLm/V3uxRAEMMgnNq
         nSPqFjFNHWPjjE9oACeuD6pYqDX8BHG4Plrtf72fjfYyAsIoUivN8RUu8zSmTuJpuMFG
         voqak39Qw/MPpqGkFQgVMKJ9uEteaArDvMsTbpwAGIqfS5Lg4f16KghL2IA3jSJ7Rh0w
         nrDqL5DM8xoNA9peVUZJmXMxvBf/cX9GCyD7SKm2n6oTwDIW61W6YZzMxTh93F70Aau7
         u+1r8b9Uh58p3/Gka7uj30Fsg/UYaYcfopFyIp/b3lxFdwfZgI+jUlaZ7cmM5JnZzXYV
         yjFg==
X-Gm-Message-State: AOAM5330gd3HIbi5lcZeIiPSLkuSlZ3tMEJhnIk6hVS5ckZJRwZpadu/
        +CXAaexcHXvBUwTQfXmemUWnsshy0gpIHyhmfmI=
X-Google-Smtp-Source: ABdhPJy7w4vlzl/MzpSNr4olIA+PAvwLSuUSWtM97kAlia0mhodBALwk+o4nYFx7HV4paxhbU5swURldJzNlBZHEvAI=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr4010176oig.152.1596560870088;
 Tue, 04 Aug 2020 10:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200708121928.bluez.v2.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
 <CAJQfnxEBjHMAO=kTqRBExgS40g7=OJbv-NOTE1V=PM=K1sdGcw@mail.gmail.com>
In-Reply-To: <CAJQfnxEBjHMAO=kTqRBExgS40g7=OJbv-NOTE1V=PM=K1sdGcw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Aug 2020 10:07:40 -0700
Message-ID: <CABBYNZ+dZsOGQZh6R3wGg3qPUep9tz7BzsDRH4__mbHKcL8P+g@mail.gmail.com>
Subject: Re: [bluez PATCH v2] avrcp: include all player settings in notif event
To:     Archie Pusaka <apusaka@google.com>
Cc:     Howard Chung <howardchung@google.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Tue, Aug 4, 2020 at 1:26 AM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Bluez maintainers,
>
> Could you take a look at this fix?
> Thank you!

Has there been any new version? It looks like CI has caught some
problems with it or that has been resolved by V2?

> Regards,
> Archie
>
>
> On Wed, 8 Jul 2020 at 12:19, Howard Chung <howardchung@google.com> wrote:
> >
> > According to AVRCP 1.6.2 spec section 6.7.2 table 6.39, all player
> > application settings should be returned to the CT and let CT to
> > determine which settings have changed. Currently bluez only returns
> > the changed attribute instead. This patch also addresses a potential
> > issue on which the number of application settings mismatches with
> > the actual number returned.
> >
> > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Fixed unused variables
> >
> >  profiles/audio/avrcp.c | 71 +++++++++++++++++++-----------------------
> >  1 file changed, 32 insertions(+), 39 deletions(-)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index e2428250e..a4de7530e 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -369,6 +369,7 @@ static uint32_t company_ids[] = {
> >  };
> >
> >  static void avrcp_register_notification(struct avrcp *session, uint8_t event);
> > +static GList *player_list_settings(struct avrcp_player *player);
> >
> >  static sdp_record_t *avrcp_ct_record(void)
> >  {
> > @@ -743,6 +744,35 @@ static int play_status_to_val(const char *status)
> >         return -EINVAL;
> >  }
> >
> > +static uint16_t player_settings_changed(struct avrcp_player *player,
> > +                                               struct avrcp_header *pdu)
> > +{
> > +       GList *settings = player_list_settings(player);
> > +       int size = 2;
> > +
> > +       for (; settings; settings = settings->next) {
> > +               const char *key = settings->data;
> > +               int attr;
> > +               int val;
> > +
> > +               attr = attr_to_val(key);
> > +               if (attr < 0)
> > +                       continue;
> > +
> > +               val = player_get_setting(player, attr);
> > +               if (val < 0)
> > +                       continue;
> > +
> > +               pdu->params[size++] = attr;
> > +               pdu->params[size++] = val;
> > +       }
> > +
> > +       g_list_free(settings);
> > +
> > +       pdu->params[1] = (size - 2) >> 1;
> > +       return size;
> > +}
> > +
> >  void avrcp_player_event(struct avrcp_player *player, uint8_t id,
> >                                                         const void *data)
> >  {
> > @@ -751,8 +781,6 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
> >         uint8_t code;
> >         uint16_t size;
> >         GSList *l;
> > -       int attr;
> > -       int val;
> >
> >         if (player->sessions == NULL)
> >                 return;
> > @@ -791,19 +819,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
> >                 size = 1;
> >                 break;
> >         case AVRCP_EVENT_SETTINGS_CHANGED:
> > -               size = 2;
> > -               pdu->params[1] = 1;
> > -
> > -               attr = attr_to_val(data);
> > -               if (attr < 0)
> > -                       return;
> > -
> > -               val = player_get_setting(player, attr);
> > -               if (val < 0)
> > -                       return;
> > -
> > -               pdu->params[size++] = attr;
> > -               pdu->params[size++] = val;
> > +               size = player_settings_changed(player, pdu);
> >                 break;
> >         case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> >                 size = 5;
> > @@ -1595,7 +1611,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
> >         struct btd_device *dev = session->dev;
> >         uint16_t len = ntohs(pdu->params_len);
> >         uint64_t uid;
> > -       GList *settings;
> >
> >         /*
> >          * 1 byte for EventID, 4 bytes for Playback interval but the latest
> > @@ -1626,29 +1641,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
> >                 len = 1;
> >                 break;
> >         case AVRCP_EVENT_SETTINGS_CHANGED:
> > -               len = 1;
> > -               settings = player_list_settings(player);
> > -
> > -               pdu->params[len++] = g_list_length(settings);
> > -               for (; settings; settings = settings->next) {
> > -                       const char *key = settings->data;
> > -                       int attr;
> > -                       int val;
> > -
> > -                       attr = attr_to_val(key);
> > -                       if (attr < 0)
> > -                               continue;
> > -
> > -                       val = player_get_setting(player, attr);
> > -                       if (val < 0)
> > -                               continue;
> > -
> > -                       pdu->params[len++] = attr;
> > -                       pdu->params[len++] = val;
> > -               }
> > -
> > -               g_list_free(settings);
> > -
> > +               len = player_settings_changed(player, pdu);
> >                 break;
> >         case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> >                 len = 5;
> > --
> > 2.27.0.383.g050319c2ae-goog
> >



-- 
Luiz Augusto von Dentz
