Return-Path: <SRS0=IUpk=4A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577EBC352A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 21:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223672467B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 21:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/mJu+Y3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgBLVVp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:21:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34701 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLVVp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Feb 2020 16:21:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id j16so3460411otl.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2020 13:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RwpCBGUid+4H1vqyVrJdgWk8xEuaKpkoA1Bmvp3YEL4=;
        b=K/mJu+Y39Tw1zfQmEiRhzW9vblwuVOlJCkoRuRmDm43UcvpghKX2LEoGLjk6b9bYD/
         dyaD35ciJWAswQMsy4ZV1vojdSIarscmqLP1P1hoBkMNFEUqGXF2GZZJkDYJqQOPdLe/
         jYJ8SNF9LbH69TUhpZxRPI7vpX/XdzTT6pS1jWjalpsSfJ2NktH5+t49athUzPJKe3ZM
         +PU+7wtwzC1n1TVW5t7dS7Bz0dpAnbcK2Xo1StoM3yMa1R6lV+T6QgePvjNkluFdukbE
         NG0yfS6PziSj1noN7oXaosDl72XFn2nw7NqNydoD7/VBRazA+6Fa353MxRXDvJ8YutJ6
         6Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RwpCBGUid+4H1vqyVrJdgWk8xEuaKpkoA1Bmvp3YEL4=;
        b=GRgvuVOy766sMk2etO6Q2UVPhhWdiXReRsLvP/nvnSVy6Kfvxgl3BylZ4l1pmNAonL
         8g5CMOoYq8C/gnCqPgUWILjfxdEssAKfObZAs+AN8j7FDpz45nREwghcB1K60hHVYcob
         n8v2jNq0riJMLkH6sbPVjGtSKH0CtqLmutprB7IU/oyw1foNWbAOHL1bXuIAdt6e62Gi
         j/6XVqG55x/JQQ4w0anoVXubP0Y2WIht98tF0Do3z5VX0yYnhNUDbFxqbgya92H03hHj
         /glcDHjTDdgK9hfUsATlYTsZw1VUvE2CHfS5unoKlBJ6Efp47qKFLWmiYDpDqfjREdE8
         TC6g==
X-Gm-Message-State: APjAAAVNjjHCIt7ayC1zOp3GnmAog0OQ4mH4ihDbBWtpT4azUqtHEFUN
        RHoaXfvCBESXJCeE3sxjF2lJasVfqHUiEhM/fOE=
X-Google-Smtp-Source: APXvYqzXmqFQBeHuq/FkWwvG3L9kA6QwM4fm4PszcbrqjGcx6NS4CN7lVXHhazdfR9oY7BFZx0sqSbPd2gT8a4RceSs=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr10150545otc.146.1581542504544;
 Wed, 12 Feb 2020 13:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20200212212729.Bluez.v2.1.I333a90ad3c75882c6f008c94a28ca7d3e8f6c76e@changeid>
 <CAO1O6sfXYs7iT972XMk=SRLrg-LXtHtDmMnSKTu2FHzMkZeNEw@mail.gmail.com>
In-Reply-To: <CAO1O6sfXYs7iT972XMk=SRLrg-LXtHtDmMnSKTu2FHzMkZeNEw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 Feb 2020 13:21:33 -0800
Message-ID: <CABBYNZL9xhc5Sjoj4xb3vPSq=1XzyzG-mEhH59_5U4-s2_mBtw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] core: Add new policy for Just-Works repairing
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Howard Chung <howardchung@google.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

On Wed, Feb 12, 2020 at 6:00 AM Emil Lenngren <emil.lenngren@gmail.com> wrote:
>
> Hi,
>
> Den ons 12 feb. 2020 kl 14:30 skrev Howard Chung <howardchung@google.com>:
> >
> > From: "howardchung@google.com" <howardchung@google.com>
> >
> > When kernel find out that the incoming Just-Works pairing is
> > initiated by a paired device, it is user space's responsibility to
> > decide the next action.
> >
> > This patch includes the following:
> > - add JustWorksRepairing policy as an option in main.conf
> > - handle the confirmation request from kernel
> >
> > ---
> > The Just-Works repairing policy could be one of the following:
> > - never: default; reject the repairing immediately.
> > - confirm: prompt a confirmation dialog to user.
> > - always: always accept the repairing.
> >
> > Changes in v2:
> > - let RequestAuthorization handle the situation
> > - remove the changes in client/
> >
> >  src/agent.c   | 16 ++++++++++++++++
> >  src/hcid.h    |  8 ++++++++
> >  src/main.c    | 27 +++++++++++++++++++++++++++
> >  src/main.conf |  5 +++++
> >  4 files changed, 56 insertions(+)
> >
> > diff --git a/src/agent.c b/src/agent.c
> > index e0ffcd22f..e013ec85f 100644
> > --- a/src/agent.c
> > +++ b/src/agent.c
> > @@ -773,12 +773,28 @@ int agent_request_authorization(struct agent *agent, struct btd_device *device,
> >                                                 GDestroyNotify destroy)
> >  {
> >         struct agent_request *req;
> > +       DBusError dbus_err;
> >         int err;
> >
> >         err = agent_has_request(agent, device, AGENT_REQUEST_AUTHORIZATION);
> >         if (err)
> >                 return err;
> >
> > +       /* Just-Works repairing policy */
> > +       if (device_is_paired(device, BDADDR_BREDR) ||
> > +                               device_is_paired(device, BDADDR_LE_PUBLIC)) {
> > +               if (main_opts.jw_repairing == JW_REPAIRING_NEVER) {
> > +                       dbus_error_init(&dbus_err);
> > +                       dbus_set_error_const(&dbus_err,
> > +                                       ERROR_INTERFACE ".Rejected", NULL);
> > +                       cb(agent, &dbus_err, user_data);
> > +                       return 0;
> > +               } else if (main_opts.jw_repairing == JW_REPAIRING_ALWAYS) {
> > +                       cb(agent, NULL, user_data);
> > +                       return 0;
> > +               }
> > +       }
> > +
> >         DBG("Calling Agent.RequestAuthorization: name=%s, path=%s",
> >                                                 agent->owner, agent->path);
> >
> > diff --git a/src/hcid.h b/src/hcid.h
> > index adea85ce2..bcd2b9fa1 100644
> > --- a/src/hcid.h
> > +++ b/src/hcid.h
> > @@ -35,6 +35,12 @@ typedef enum {
> >         BT_GATT_CACHE_NO,
> >  } bt_gatt_cache_t;
> >
> > +enum {
> > +       JW_REPAIRING_NEVER,
> > +       JW_REPAIRING_CONFIRM,
> > +       JW_REPAIRING_ALWAYS,
> > +} jw_repairing_t;
> > +
> >  struct main_opts {
> >         char            *name;
> >         uint32_t        class;
> > @@ -58,6 +64,8 @@ struct main_opts {
> >         uint16_t        gatt_mtu;
> >
> >         uint8_t         key_size;
> > +
> > +       jw_repairing_t  jw_repairing;
> >  };
> >
> >  extern struct main_opts main_opts;
> > diff --git a/src/main.c b/src/main.c
> > index 1a6ab36a3..d67f469f1 100644
> > --- a/src/main.c
> > +++ b/src/main.c
> > @@ -93,6 +93,7 @@ static const char *supported_options[] = {
> >         "MultiProfile",
> >         "FastConnectable",
> >         "Privacy",
> > +       "JustWorksRepairing",
> >         NULL
> >  };
> >
> > @@ -193,6 +194,20 @@ static bt_gatt_cache_t parse_gatt_cache(const char *cache)
> >         }
> >  }
> >
> > +static jw_repairing_t parse_jw_repairing(const char *jw_repairing)
> > +{
> > +       if (!strcmp(jw_repairing, "never")) {
> > +               return JW_REPAIRING_NEVER;
> > +       } else if (!strcmp(jw_repairing, "confirm")) {
> > +               return JW_REPAIRING_CONFIRM;
> > +       } else if (!strcmp(jw_repairing, "always")) {
> > +               return JW_REPAIRING_ALWAYS;
> > +       } else {
> > +               return JW_REPAIRING_NEVER;
> > +       }
> > +}
> > +
> > +
> >  static void check_options(GKeyFile *config, const char *group,
> >                                                 const char **options)
> >  {
> > @@ -331,6 +346,18 @@ static void parse_config(GKeyFile *config)
> >                 g_free(str);
> >         }
> >
> > +       str = g_key_file_get_string(config, "General",
> > +                                               "JustWorksRepairing", &err);
> > +       if (err) {
> > +               DBG("%s", err->message);
> > +               g_clear_error(&err);
> > +               main_opts.jw_repairing = JW_REPAIRING_NEVER;
> > +       } else {
> > +               DBG("just_works_repairing=%s", str);
> > +               main_opts.jw_repairing = parse_jw_repairing(str);
> > +               g_free(str);
> > +       }
> > +
> >         str = g_key_file_get_string(config, "General", "Name", &err);
> >         if (err) {
> >                 DBG("%s", err->message);
> > diff --git a/src/main.conf b/src/main.conf
> > index 40687a755..bb5ff5b15 100644
> > --- a/src/main.conf
> > +++ b/src/main.conf
> > @@ -72,6 +72,11 @@
> >  # Defaults to "off"
> >  # Privacy = off
> >
> > +# Specify the policy to the JUST-WORKS repairing initiated by peer
> > +# Possible values: "never", "confirm", "always"
> > +# Defaults to "never"
> > +#JustWorksRepairing = never
> > +
> >  [GATT]
> >  # GATT attribute cache.
> >  # Possible values:
> > --
> > 2.25.0.225.g125e21ebc7-goog
> >
>
> I haven't looked much into this, but have a question. What happens by
> default currently when we have an already bonded device previously
> paired using some MITM-protected mechanism, and suddenly wants to
> re-bond using a less secure mechanism (Just Works)? In my opinion
> denying this should obviously be the default in case no agent is
> available, compared to if pairing a new device then the default should
> be accept.

When no agent is registered we don't set the pairable flag, so it
shouldn't even be able do trigger a new pairing without an agent.

-- 
Luiz Augusto von Dentz
