Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00500C433E3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B655C2075B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 17:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJIyIqzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbgHQRbM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389263AbgHQQ6R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 12:58:17 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F6C061343
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 09:58:16 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id b22so15374104oic.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiMNDic3Fr3dtj4r7uAD1eVHZ+S58Ejt8jAJ9yNaxDg=;
        b=ZJIyIqzoxc9pxvvi0PmXXi5rrfOWTFXka83ZwMCcVreRNeG5IQowoVKgyE8uDj2qSS
         jJY65Cu2VMCNcZX5HaY/3msj0wbFPTLUfVydWc9wjqwxmty0szcyDKWcYMUgjfwlli9V
         NRaren7WN2zX7j3mxPcBLfoprZ2eqh/q868FfCzPAlDvV9so4XJiQ3R2q9BUKSTnBYXo
         oTECBPBzWS9ZYbiujc8owOyEzKpQpAxYsMm85IocPvxcqXH9JqXSv+gMcsJMeZRrDTlg
         0ekenHqmzjjOtzDQVTlQcoHbax5xRKN/RrFY3uM30bhsBY4A6q7+mzCFvNd4xsPn07F4
         Ylcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiMNDic3Fr3dtj4r7uAD1eVHZ+S58Ejt8jAJ9yNaxDg=;
        b=jcrlkeZ9zaBk21zcDX4olS3W1TlEFUUSGkfTqC8VQPoXZ8vKbV/uxd09FdtrYHcdHb
         AeFIujK+2uue/nYdo/lBfpfVW8EDWLZGlZx5OuOfQl0bhK8swnyNe112EzoBre/n0i85
         uhocVtrdwVIDubWRxvlbNM5ZfOndw8eIS4KL8axLt4toveRCNPuTK6dALJt66glVC0Mn
         zfFNwzaFSxgM0fDyN6BxP7KUUjBvoBuPDzXrbc9kNZxhdO4H04/6EBD4ERJLXV0bk+e3
         dhifdRgRd3mKiU0HYey7joWf48+txYsk3O+tGb2u0ZP1q7h8U/G+u32JkRlQqXKtWIWo
         3+/A==
X-Gm-Message-State: AOAM531d9U5PcShaCXtUWn2jjHTCprts1lpE5tbxxCNQkfIXhoOm6ioj
        0kJO1mZrov2sfnysBGIZ+W24LQFhvaJC8cj2P6A=
X-Google-Smtp-Source: ABdhPJyxRPgIgwZ3dfvBxFzTGe5KFA+ENncz5TUUK4kFTxuYbR4cRtMQoDRnqFMe0bE7vUEV1AFBJ+79+2/byGzZb/M=
X-Received: by 2002:aca:cc50:: with SMTP id c77mr9582912oig.152.1597683495306;
 Mon, 17 Aug 2020 09:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200812121946.Bluez.v1.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
 <CABBYNZKUDn-gWfkZzH4kO5c6kRNMomH9-o8XHJ_Lv+7ujrMNrw@mail.gmail.com> <CAJQfnxFcEqWrGqWCPSL-F4PZRyvwYRSRUcthEOW1Gn4q0bZO1g@mail.gmail.com>
In-Reply-To: <CAJQfnxFcEqWrGqWCPSL-F4PZRyvwYRSRUcthEOW1Gn4q0bZO1g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 17 Aug 2020 09:58:03 -0700
Message-ID: <CABBYNZJu2FQWPFUcJtvb93gp7gbD9_gOk_p2FxNaaBam0tW2VQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: Don't browse SDP if HIDSDPDisable is set
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Mon, Aug 17, 2020 at 12:23 AM Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Luiz,
>
>
> On Sat, 15 Aug 2020 at 02:59, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Tue, Aug 11, 2020 at 9:21 PM Archie Pusaka <apusaka@google.com> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > According to the HID1.1 spec, part 5.3.4.9:
> > > The HIDSDPDisable attribute is a Boolean value, which indicates
> > > whether connection to the SDP channel and Control or Interrupt
> > > channels are mutually exclusive. This feature supports Bluetooth
> > > HID devices that have minimal resources, and multiplex those
> > > resources between servicing the initialization (SDP) and runtime
> > > (Control and Interrupt) channels.
> > >
> > > However, Bluez still tries to connect SDP upon HID connection,
> > > regardless of the existence of the HIDSDPDisable attribute.
> > >
> > > This patch prevents the connection of SDP after HID has been
> > > established, if the device has HIDSDPDisable attribute.
> > >
> > > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > > ---
> > >
> > >  profiles/input/device.c | 2 ++
> > >  src/device.c            | 8 +++++++-
> > >  src/device.h            | 1 +
> > >  3 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > > index 6ec0a4c63..fac8c6896 100644
> > > --- a/profiles/input/device.c
> > > +++ b/profiles/input/device.c
> > > @@ -1373,6 +1373,8 @@ static struct input_device *input_device_new(struct btd_service *service)
> > >         /* Initialize device properties */
> > >         extract_hid_props(idev, rec);
> > >
> > > +       device_set_skip_passive_sdp_discovery(device, idev->disable_sdp);
> >
> > Shouldn't you actually be checking for the presence of HIDSDPDisable,
>
> Yes, the variable idev->disable_sdp stores the presence of
> HIDSDPDisable attribute.

I didn't realize it was already being stored, now it makes sense.

> > I suppose the first time when you pair with it the SDP must be active
> > in order for us to be able to probe the drivers, then once we get the
> > SDP records stored we should inhibit the refresh of the records.
>
> Correct, the first time we pair the device, SDP is still active as
> usual. The additional check is only applied when refreshing the SDP
> records.
>
> >
> > >         return idev;
> > >  }
> > >
> > > diff --git a/src/device.c b/src/device.c
> > > index 2237a7670..a67787a2d 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -195,6 +195,7 @@ struct btd_device {
> > >         bool            le;
> > >         bool            pending_paired;         /* "Paired" waiting for SDP */
> > >         bool            svc_refreshed;
> > > +       bool            skip_passive_sdp_discovery;

Let's have it as refresh_discovery and I'd add support for setting it
globally on main.conf so  we can initialize it with
main_opts.refresh_discovery so we are consistent with the terminology
we have been using.

> > >
> > >         /* Manage whether this device can wake the system from suspend.
> > >          * - wake_support: Requires a profile that supports wake (i.e. HID)
> > > @@ -1472,6 +1473,10 @@ static gboolean dev_property_wake_allowed_exist(
> > >         return device_get_wake_support(device);
> > >  }
> > >
> > > +void device_set_skip_passive_sdp_discovery(struct btd_device *dev, bool skip)
> > > +{
> > > +       dev->skip_passive_sdp_discovery = skip;
> > > +}
> > >
> > >  static gboolean disconnect_all(gpointer user_data)
> > >  {
> > > @@ -1805,7 +1810,8 @@ done:
> > >                                 btd_error_failed(dev->connect, strerror(-err)));
> > >         } else {
> > >                 /* Start passive SDP discovery to update known services */
> > > -               if (dev->bredr && !dev->svc_refreshed)
> > > +               if (dev->bredr && !dev->svc_refreshed &&
> > > +                                       !dev->skip_passive_sdp_discovery)
> > >                         device_browse_sdp(dev, NULL);

Then here just check for dev->refresh_discovery.

> > >                 g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
> > >         }
> > > diff --git a/src/device.h b/src/device.h
> > > index cb8d884e8..5348d2652 100644
> > > --- a/src/device.h
> > > +++ b/src/device.h
> > > @@ -145,6 +145,7 @@ void device_set_wake_override(struct btd_device *device, bool wake_override);
> > >  void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
> > >                              guint32 id);
> > >  void device_set_wake_allowed_complete(struct btd_device *device);
> > > +void device_set_skip_passive_sdp_discovery(struct btd_device *dev, bool skip);

And here we name it device_set_refresh_discovery so plugins can
actually set if the device should have refresh_discovery
enabled/disabled.

> > >
> > >  typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
> > >                                         void *user_data);
> > > --
> > > 2.28.0.236.gb10cc79966-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Archie



-- 
Luiz Augusto von Dentz
