Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7FBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CC6206DA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 17:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptrfQ5Ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgHDRaZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgHDRaY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 13:30:24 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB713C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2020 10:30:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so38207115wrw.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2020 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcMS4tAZxi6H4xHOSqM9jReJTM3G2aGxItAR5kPpiU4=;
        b=ptrfQ5Abp2AwQP1Qpf69hwWx9hcPgweaP03bqx7ijqg0aT/BH/6/YKCKaBqLewwZKD
         nyOH9EVyg4TZLAZwMfQnX8+5+wSlJV6+Av82pi7NK4z58g1FYXPX1zSH9bWQWFFXxvRr
         mVqWOmw6TF+VzG07bSUvlhR9iv4kh9mg5MdkVC/+IBSyjSOITkZVm3k5+cAma180AqdX
         I5nGk7Pf686tX/FY6brwADCGbseARWhjkm7E5P/Gbun+9U332w9iJzNetKDv7Xa2CEv7
         45OHmw7yiDxcIEE+b6cEJkEDI45nWdtvYTACykscClz694ALShGOhvtVJ2jJio3jE6D5
         DBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcMS4tAZxi6H4xHOSqM9jReJTM3G2aGxItAR5kPpiU4=;
        b=gRagKw1OcRctosz/4vSRCYis6Ewc5umP11twNiyLyrQnBNJkK58zCMLUk6a7uMpcDG
         g548PMi8PyXLnqgyhi4AmRczmazuoSqR8ckWC3h4eJoDJVG2tCQtoNr2yzYntFr4y9lX
         GUnNpDVHu3olq6++fUjctiWeJEdKcxpBc0HmyaUCxTCELDlPNmYsrrjOrvT9jo/Kl1ua
         CRrWEZf7hBYOmplHbnD32IuZ39gpe7+Q+ScwKRM6ee8QynAr8fWatuEKc/3deGYaMLpR
         bAr8iQjrJmF/AYvytSYGBm9A1TEq8vf2VSBzhzCB24x3T6uNjnBNapg8zJ+65TDG+X98
         qbhw==
X-Gm-Message-State: AOAM530Km5sf0cpl8Ub0rH0i5Rowd20uEBsCEwe+votipfBbmwMnAxI1
        i1JhrcOxgiDZZ58f6UAeQN4p6hzw+AZNUakkVoj2jg==
X-Google-Smtp-Source: ABdhPJxU0OV+4f3J8HxTYU9IsJ696EFu8RXQI4z+9nJu8vs49J5o22+CIHP2+hzsaIiRh1P8EFYW9sTUPTMecMKQY7k=
X-Received: by 2002:a5d:540c:: with SMTP id g12mr19890425wrv.120.1596562221818;
 Tue, 04 Aug 2020 10:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200708121928.bluez.v2.1.I6076fdf5621a5ce59b7307967a8c997638c1d1c8@changeid>
 <CAJQfnxEBjHMAO=kTqRBExgS40g7=OJbv-NOTE1V=PM=K1sdGcw@mail.gmail.com> <CABBYNZ+dZsOGQZh6R3wGg3qPUep9tz7BzsDRH4__mbHKcL8P+g@mail.gmail.com>
In-Reply-To: <CABBYNZ+dZsOGQZh6R3wGg3qPUep9tz7BzsDRH4__mbHKcL8P+g@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Wed, 5 Aug 2020 01:30:10 +0800
Message-ID: <CAJQfnxGvvfSHS8ZdYcBPN6Me8E4r76YkkDubnB71r_8MXsDSsQ@mail.gmail.com>
Subject: Re: [bluez PATCH v2] avrcp: include all player settings in notif event
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Howard Chung <howardchung@google.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Is this the problem?
https://lore.kernel.org/linux-bluetooth/5f05427c.1c69fb81.f61e.0992@mx.google.com/

If so, that has been resolved in v2.

Regards,
Archie

On Wed, 5 Aug 2020 at 01:07, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Tue, Aug 4, 2020 at 1:26 AM Archie Pusaka <apusaka@google.com> wrote:
> >
> > Hi Bluez maintainers,
> >
> > Could you take a look at this fix?
> > Thank you!
>
> Has there been any new version? It looks like CI has caught some
> problems with it or that has been resolved by V2?
>
> > Regards,
> > Archie
> >
> >
> > On Wed, 8 Jul 2020 at 12:19, Howard Chung <howardchung@google.com> wrote:
> > >
> > > According to AVRCP 1.6.2 spec section 6.7.2 table 6.39, all player
> > > application settings should be returned to the CT and let CT to
> > > determine which settings have changed. Currently bluez only returns
> > > the changed attribute instead. This patch also addresses a potential
> > > issue on which the number of application settings mismatches with
> > > the actual number returned.
> > >
> > > Reviewed-by: Archie Pusaka <apusaka@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Fixed unused variables
> > >
> > >  profiles/audio/avrcp.c | 71 +++++++++++++++++++-----------------------
> > >  1 file changed, 32 insertions(+), 39 deletions(-)
> > >
> > > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > > index e2428250e..a4de7530e 100644
> > > --- a/profiles/audio/avrcp.c
> > > +++ b/profiles/audio/avrcp.c
> > > @@ -369,6 +369,7 @@ static uint32_t company_ids[] = {
> > >  };
> > >
> > >  static void avrcp_register_notification(struct avrcp *session, uint8_t event);
> > > +static GList *player_list_settings(struct avrcp_player *player);
> > >
> > >  static sdp_record_t *avrcp_ct_record(void)
> > >  {
> > > @@ -743,6 +744,35 @@ static int play_status_to_val(const char *status)
> > >         return -EINVAL;
> > >  }
> > >
> > > +static uint16_t player_settings_changed(struct avrcp_player *player,
> > > +                                               struct avrcp_header *pdu)
> > > +{
> > > +       GList *settings = player_list_settings(player);
> > > +       int size = 2;
> > > +
> > > +       for (; settings; settings = settings->next) {
> > > +               const char *key = settings->data;
> > > +               int attr;
> > > +               int val;
> > > +
> > > +               attr = attr_to_val(key);
> > > +               if (attr < 0)
> > > +                       continue;
> > > +
> > > +               val = player_get_setting(player, attr);
> > > +               if (val < 0)
> > > +                       continue;
> > > +
> > > +               pdu->params[size++] = attr;
> > > +               pdu->params[size++] = val;
> > > +       }
> > > +
> > > +       g_list_free(settings);
> > > +
> > > +       pdu->params[1] = (size - 2) >> 1;
> > > +       return size;
> > > +}
> > > +
> > >  void avrcp_player_event(struct avrcp_player *player, uint8_t id,
> > >                                                         const void *data)
> > >  {
> > > @@ -751,8 +781,6 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
> > >         uint8_t code;
> > >         uint16_t size;
> > >         GSList *l;
> > > -       int attr;
> > > -       int val;
> > >
> > >         if (player->sessions == NULL)
> > >                 return;
> > > @@ -791,19 +819,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
> > >                 size = 1;
> > >                 break;
> > >         case AVRCP_EVENT_SETTINGS_CHANGED:
> > > -               size = 2;
> > > -               pdu->params[1] = 1;
> > > -
> > > -               attr = attr_to_val(data);
> > > -               if (attr < 0)
> > > -                       return;
> > > -
> > > -               val = player_get_setting(player, attr);
> > > -               if (val < 0)
> > > -                       return;
> > > -
> > > -               pdu->params[size++] = attr;
> > > -               pdu->params[size++] = val;
> > > +               size = player_settings_changed(player, pdu);
> > >                 break;
> > >         case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> > >                 size = 5;
> > > @@ -1595,7 +1611,6 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
> > >         struct btd_device *dev = session->dev;
> > >         uint16_t len = ntohs(pdu->params_len);
> > >         uint64_t uid;
> > > -       GList *settings;
> > >
> > >         /*
> > >          * 1 byte for EventID, 4 bytes for Playback interval but the latest
> > > @@ -1626,29 +1641,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
> > >                 len = 1;
> > >                 break;
> > >         case AVRCP_EVENT_SETTINGS_CHANGED:
> > > -               len = 1;
> > > -               settings = player_list_settings(player);
> > > -
> > > -               pdu->params[len++] = g_list_length(settings);
> > > -               for (; settings; settings = settings->next) {
> > > -                       const char *key = settings->data;
> > > -                       int attr;
> > > -                       int val;
> > > -
> > > -                       attr = attr_to_val(key);
> > > -                       if (attr < 0)
> > > -                               continue;
> > > -
> > > -                       val = player_get_setting(player, attr);
> > > -                       if (val < 0)
> > > -                               continue;
> > > -
> > > -                       pdu->params[len++] = attr;
> > > -                       pdu->params[len++] = val;
> > > -               }
> > > -
> > > -               g_list_free(settings);
> > > -
> > > +               len = player_settings_changed(player, pdu);
> > >                 break;
> > >         case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
> > >                 len = 5;
> > > --
> > > 2.27.0.383.g050319c2ae-goog
> > >
>
>
>
> --
> Luiz Augusto von Dentz
