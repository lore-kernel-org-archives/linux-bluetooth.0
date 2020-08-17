Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B9CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 07:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D2620772
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 07:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfiQf3kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgHQHXz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQHXy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 03:23:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060FFC061388
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 00:23:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so13020697wmi.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOGqHtr5VUN/O/Q25+wJOUQ13DGoVd1SRCXNWEYZZuk=;
        b=XfiQf3kzucTaickG4QyikCvE9Y/1BUDVhlENgRIuTLOxP77k7+BKJxRjJ+YLsU4gOJ
         44XWkbhhBVsKGNx/Tf7SDuj84HPYYH6yu+KqIt1jBD9PErUQG4KJAsgkMITfBv8AFq+6
         T0Y8ck1TmpZpH9xXYJVuD0DCSOYyRIF9T30w45YWvc4G2Fvp+OsO3h+8N1VTj4sUeAAI
         IZznBPhoyoiFREEUgkHygEZim+EBdWq7nFyERLh1cMcY28hcf+loXYWko9BpFG/AxMlu
         FVjOCYhGxxZp+Wvv3KYIHpO6oLtuyI8V4mZettK17N4FL/qgNPKuo0LypXd7AD569oKb
         11CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOGqHtr5VUN/O/Q25+wJOUQ13DGoVd1SRCXNWEYZZuk=;
        b=Co48oc1/zykuPro786BAZwmO60FGfjnm6awpwo95yFoOSMf6cXSkv7Qq8Jf7O5QYOK
         kY2Y43Hn3g9q9a1cueEkkJDVExTKIwZMjjwv7l23B0Xg0cQeayeBdqL2TFAEFc3Kvef8
         Rak0Ftrsjs88pSI7DGqadkwavafhltrg59fzvWqD8AJp1fA98vn63nId4jfLQ9JMgmg6
         EDR3FftnDWKyx3We5/OmAj++KV+O+vIVlGAUwvdr2HAoVDBG775th+SodRaN1+UNNzop
         TNvgZQ6QCBQXylgsAeEFsc/qmdY8BLmUhRtHwXla+AFA3nMByWR7tk35PTuQG9kgottJ
         6JMg==
X-Gm-Message-State: AOAM530SKB9/7iYpvH9ThlBQ3/yZCzJXoJkvfHTt5efewpeuyilK/k5B
        U9dnc14r8vvgRGSqy4QkKt76tYgbG7SVfF/ZfJGEGw==
X-Google-Smtp-Source: ABdhPJxlA48gou57NxM+JSjZXfdSs+iThswkreEWh79QRz1tJ6kAGVTu7KO+OmT/CoTfonuJJh/Wh10qXqPdX7og4Gc=
X-Received: by 2002:a7b:c401:: with SMTP id k1mr12970484wmi.18.1597649032287;
 Mon, 17 Aug 2020 00:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200812121946.Bluez.v1.1.I254123a1c85e8cb22739cbbb1ffa2f56ac41faa8@changeid>
 <CABBYNZKUDn-gWfkZzH4kO5c6kRNMomH9-o8XHJ_Lv+7ujrMNrw@mail.gmail.com>
In-Reply-To: <CABBYNZKUDn-gWfkZzH4kO5c6kRNMomH9-o8XHJ_Lv+7ujrMNrw@mail.gmail.com>
From:   Archie Pusaka <apusaka@google.com>
Date:   Mon, 17 Aug 2020 15:23:41 +0800
Message-ID: <CAJQfnxFcEqWrGqWCPSL-F4PZRyvwYRSRUcthEOW1Gn4q0bZO1g@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] input: Don't browse SDP if HIDSDPDisable is set
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,


On Sat, 15 Aug 2020 at 02:59, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Tue, Aug 11, 2020 at 9:21 PM Archie Pusaka <apusaka@google.com> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > According to the HID1.1 spec, part 5.3.4.9:
> > The HIDSDPDisable attribute is a Boolean value, which indicates
> > whether connection to the SDP channel and Control or Interrupt
> > channels are mutually exclusive. This feature supports Bluetooth
> > HID devices that have minimal resources, and multiplex those
> > resources between servicing the initialization (SDP) and runtime
> > (Control and Interrupt) channels.
> >
> > However, Bluez still tries to connect SDP upon HID connection,
> > regardless of the existence of the HIDSDPDisable attribute.
> >
> > This patch prevents the connection of SDP after HID has been
> > established, if the device has HIDSDPDisable attribute.
> >
> > Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
> > ---
> >
> >  profiles/input/device.c | 2 ++
> >  src/device.c            | 8 +++++++-
> >  src/device.h            | 1 +
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/profiles/input/device.c b/profiles/input/device.c
> > index 6ec0a4c63..fac8c6896 100644
> > --- a/profiles/input/device.c
> > +++ b/profiles/input/device.c
> > @@ -1373,6 +1373,8 @@ static struct input_device *input_device_new(struct btd_service *service)
> >         /* Initialize device properties */
> >         extract_hid_props(idev, rec);
> >
> > +       device_set_skip_passive_sdp_discovery(device, idev->disable_sdp);
>
> Shouldn't you actually be checking for the presence of HIDSDPDisable,

Yes, the variable idev->disable_sdp stores the presence of
HIDSDPDisable attribute.

> I suppose the first time when you pair with it the SDP must be active
> in order for us to be able to probe the drivers, then once we get the
> SDP records stored we should inhibit the refresh of the records.

Correct, the first time we pair the device, SDP is still active as
usual. The additional check is only applied when refreshing the SDP
records.

>
> >         return idev;
> >  }
> >
> > diff --git a/src/device.c b/src/device.c
> > index 2237a7670..a67787a2d 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -195,6 +195,7 @@ struct btd_device {
> >         bool            le;
> >         bool            pending_paired;         /* "Paired" waiting for SDP */
> >         bool            svc_refreshed;
> > +       bool            skip_passive_sdp_discovery;
> >
> >         /* Manage whether this device can wake the system from suspend.
> >          * - wake_support: Requires a profile that supports wake (i.e. HID)
> > @@ -1472,6 +1473,10 @@ static gboolean dev_property_wake_allowed_exist(
> >         return device_get_wake_support(device);
> >  }
> >
> > +void device_set_skip_passive_sdp_discovery(struct btd_device *dev, bool skip)
> > +{
> > +       dev->skip_passive_sdp_discovery = skip;
> > +}
> >
> >  static gboolean disconnect_all(gpointer user_data)
> >  {
> > @@ -1805,7 +1810,8 @@ done:
> >                                 btd_error_failed(dev->connect, strerror(-err)));
> >         } else {
> >                 /* Start passive SDP discovery to update known services */
> > -               if (dev->bredr && !dev->svc_refreshed)
> > +               if (dev->bredr && !dev->svc_refreshed &&
> > +                                       !dev->skip_passive_sdp_discovery)
> >                         device_browse_sdp(dev, NULL);
> >                 g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
> >         }
> > diff --git a/src/device.h b/src/device.h
> > index cb8d884e8..5348d2652 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -145,6 +145,7 @@ void device_set_wake_override(struct btd_device *device, bool wake_override);
> >  void device_set_wake_allowed(struct btd_device *device, bool wake_allowed,
> >                              guint32 id);
> >  void device_set_wake_allowed_complete(struct btd_device *device);
> > +void device_set_skip_passive_sdp_discovery(struct btd_device *dev, bool skip);
> >
> >  typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
> >                                         void *user_data);
> > --
> > 2.28.0.236.gb10cc79966-goog
> >
>
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
