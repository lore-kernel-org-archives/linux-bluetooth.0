Return-Path: <SRS0=4Twx=DT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0508DC433E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 21:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C94D2080D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Oct 2020 21:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="my82YsiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgJLVfP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Oct 2020 17:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgJLVfP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Oct 2020 17:35:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA232C0613D0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 14:35:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j30so17425114lfp.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2020 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRt+Wn2MQ+indt8q3VuBZb4vD23rCO71FV+mQVHd/4I=;
        b=my82YsiX+Jh9/77pYgCEznujCmiMplHOppwJ/+VzRawXM7Vzn+SXmsH+/vscuWAVRP
         cSkR776FU3r1YBA1lQ+4lhyEmK0uU5EREhI4rBSPLPKhfXvO/nLW2JRO1e0gVCFK/gSL
         2fGhuYYIUunBznXuqQkEWzQctG8OQIAOLBiZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRt+Wn2MQ+indt8q3VuBZb4vD23rCO71FV+mQVHd/4I=;
        b=dXWfo1e6LmxsGXsiDUoo8JLzm1tAwUX5dnPaGEV7OGaHPPX/dfacWJ3mX38WmgWV9Q
         3qumCOoherse5OA7VySNYPGNhEw6eXK8dVh2rHSb9rIAE6E+ZWuqa98oRZzDWxUyEwF1
         asQ/Uhuf5umnxMoEnxXDVrzArcvF5JeaStfcKpqEzRWNvSwP1902DOhbpLXzcOhKqwwn
         VBMiBOfvLOXQTXRf9XbgMWMkDIWcGp6JRKhTYWgbzDfuYIPGG+rhxAatKkoGFsMiUA4N
         ODJtdbn6rI2WXy4ChNwqWrriimWW/VjIRloQDS1Y+JrSqktY5Th0BIyCxpF6PgKGs5Xu
         epdQ==
X-Gm-Message-State: AOAM532XEW2k1zgBIzArRHTgWJ5W1GxA7u5yzOviRrviQlx7TXVlQdr7
        ye5lI4l4UpsdDkQcu/rMzTLZZxd99uH2MiQz3vKrLg==
X-Google-Smtp-Source: ABdhPJzMc6cgM1GtFVPN8BiVg6MeUK9XgHWBeBl9BJspkZw8Ud5I+VqIqNgIF/EJ6RtNk5z6TW5MkORigxH/EZDqmmQ=
X-Received: by 2002:a19:ad0a:: with SMTP id t10mr2252528lfc.324.1602538512130;
 Mon, 12 Oct 2020 14:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201006171333.BlueZ.v6.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
 <20201006171333.BlueZ.v6.4.Ibbcb11712b613ef95c31b41207c3ea945c830018@changeid>
 <CABBYNZLPAuK4K3tRnMhon5FSytPbhW8UHKWdQap0n73pXke-5A@mail.gmail.com>
In-Reply-To: <CABBYNZLPAuK4K3tRnMhon5FSytPbhW8UHKWdQap0n73pXke-5A@mail.gmail.com>
From:   Miao-chen Chou <mcchou@chromium.org>
Date:   Mon, 12 Oct 2020 14:35:01 -0700
Message-ID: <CABmPvSE0wyHUc8tj=FnLEvcLQVx+dPyR-XtERda3-WApHASP-g@mail.gmail.com>
Subject: Re: [BlueZ PATCH v6 4/6] adv_monitor: Implement Add Adv Patterns
 Monitor cmd handler
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Howard Chung <howardchung@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Manish Mandlik <mmandlik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On Tue, Oct 6, 2020 at 11:26 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Miao,
>
> On Tue, Oct 6, 2020 at 5:17 PM Miao-chen Chou <mcchou@chromium.org> wrote:
> >
> > From: Howard Chung <howardchung@google.com>
> >
> > - Send the MGMT_OP command to kernel upon registration of a Adv patterns
> > monitor.
> > - Call Activate() or Release() to client depending on the reply from
> >   kernel
> >
> > the call through syslog
> >
> > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  src/adv_monitor.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/adv_monitor.c b/src/adv_monitor.c
> > index fcb127cd4..582cc9a46 100644
> > --- a/src/adv_monitor.c
> > +++ b/src/adv_monitor.c
> > @@ -588,11 +588,59 @@ done:
> >         return monitor->state != MONITOR_STATE_FAILED;
> >  }
> >
> > +/* Handles the callback of Add Adv Patterns Monitor command */
> > +static void add_adv_patterns_monitor_cb(uint8_t status, uint16_t length,
> > +                                       const void *param, void *user_data)
> > +{
> > +       const struct mgmt_rp_add_adv_patterns_monitor *rp = param;
> > +       struct adv_monitor *monitor = user_data;
> > +       uint16_t adapter_id = monitor->app->manager->adapter_id;
> > +
> > +       if (status != MGMT_STATUS_SUCCESS || !param) {
> > +               btd_error(adapter_id, "Failed to Add Adv Patterns Monitor "
> > +                               "with status 0x%02x", status);
> > +               monitor_release(monitor, NULL);
> > +               return;
> > +       }
> > +
> > +       if (length < sizeof(*rp)) {
> > +               btd_error(adapter_id, "Wrong size of Add Adv Patterns Monitor "
> > +                               "response");
> > +               monitor_release(monitor, NULL);
> > +               return;
> > +       }
> > +
> > +       monitor->state = MONITOR_STATE_HONORED;
>
> I would reword this state to ACTIVE instead of HONORED as it seems
> more consistent.
>
Addressed in my local v7. I will send this after we settle down the
discussion on the other thread.

> > +       DBG("Calling Activate() on Adv Monitor of owner %s at path %s",
> > +               monitor->app->owner, monitor->path);
> > +
> > +       g_dbus_proxy_method_call(monitor->proxy, "Activate", NULL, NULL, NULL,
> > +                                       NULL);
> > +
> > +       DBG("Adv Monitor with handle:0x%04x added",
> > +                                       le16_to_cpu(rp->monitor_handle));
> > +}
> > +
> > +static void monitor_copy_patterns(void *data, void *user_data)
> > +{
> > +       struct btd_adv_monitor_pattern *pattern = data;
> > +       struct mgmt_cp_add_adv_monitor *cp = user_data;
> > +
> > +       if (!pattern)
> > +               return;
> > +
> > +       memcpy(cp->patterns + cp->pattern_count, pattern, sizeof(*pattern));
> > +       cp->pattern_count++;
> > +}
> > +
> >  /* Handles an Adv Monitor D-Bus proxy added event */
> >  static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
> >  {
> >         struct adv_monitor *monitor;
> >         struct adv_monitor_app *app = user_data;
> > +       struct mgmt_cp_add_adv_monitor *cp = NULL;
> > +       uint8_t pattern_count, cp_len;
> >         uint16_t adapter_id = app->manager->adapter_id;
> >         const char *path = g_dbus_proxy_get_path(proxy);
> >         const char *iface = g_dbus_proxy_get_interface(proxy);
> > @@ -625,7 +673,24 @@ static void monitor_proxy_added_cb(GDBusProxy *proxy, void *user_data)
> >
> >         queue_push_tail(app->monitors, monitor);
> >
> > +       pattern_count = queue_length(monitor->patterns);
> > +       cp_len = sizeof(struct mgmt_cp_add_adv_monitor) +
> > +                       pattern_count * sizeof(struct mgmt_adv_pattern);
> > +
> > +       cp = malloc0(cp_len);
> > +       queue_foreach(monitor->patterns, monitor_copy_patterns, cp);
> > +
> > +       if (!mgmt_send(app->manager->mgmt, MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
> > +                       adapter_id, cp_len, cp, add_adv_patterns_monitor_cb,
> > +                       monitor, NULL)) {
> > +               error("Unable to send Add Adv Patterns Monitor command");
> > +               goto done;
> > +       }
> > +
> >         DBG("Adv Monitor allocated for the object at path %s", path);
> > +
> > +done:
> > +       free(cp);
> >  }
> >
> >  /* Handles the removal of an Adv Monitor D-Bus proxy */
> > @@ -1036,7 +1101,7 @@ static void adv_match_per_monitor(void *data, void *user_data)
> >         struct adv_monitor *monitor = data;
> >         struct adv_content_filter_info *info = user_data;
> >
> > -       if (!monitor && monitor->state != MONITOR_STATE_HONORED)
> > +       if (!monitor || monitor->state != MONITOR_STATE_HONORED)
> >                 return;
> >
> >         /* Reset the intermediate matched status */
> > --
> > 2.26.2
> >
>
>
> --
> Luiz Augusto von Dentz

Regards,
Miao
