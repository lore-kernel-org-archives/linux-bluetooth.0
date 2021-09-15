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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5295DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD1960F25
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 23:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhIOXlk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhIOXlk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 19:41:40 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA11C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:40:20 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id z62so4440935vsz.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 16:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8BWF5dkSMQUWv7qasJoTqV6khZkJ3+OaDDkrKDxkGA=;
        b=qiqVT+c+cwDayQyXdwDqbWsPfOGV9KTt/Glsr0UdxUcETy0LOfL8ObnPB0mI515UpX
         jlLyNvtjEuyzjEyxRsfZ+amL3zqSlb09tzrwKQjC25yROQ+9sVwbrRw1vFckryGUuSmY
         qDvpT3bX9FVpnH7gAtPbIUJcvx05YyI8VNS6qIg5eQeoXDoPmJnVDhjAi/VwO3F0ir8L
         Fn+XeTMmAPmDnXAV2o05MctohUfVYW8UhRdRvT1fqJ7xZG7ycx+KAUbU7GJFbLkd86eC
         Bnsr7M3hupsaHqZTiN6Z5pWmkKVsaTrFVZSOqXaYP6eWODEeu1I5YAEyvMF8LS08LEKz
         qeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8BWF5dkSMQUWv7qasJoTqV6khZkJ3+OaDDkrKDxkGA=;
        b=qnHeQRKM0uw79NhNYF5BjTJbR9wzMIcBTy9RK3wCb2Ki2EJ3439PJ77sYkvhlHazer
         Vg9X8oYjEKX5B1BCmirAQfvJ9AzcyHGxLPa9VDDlnsCC6OzrQvtxmBm9MA5P1WS7qy7f
         P3jh5bti9ql7TH6OR6MuGcRG4UWFiE/be/sqU7BRnnwVlu9O3i3KX+K/4kAUE0XZ3+2L
         IIZp+xqG+duvpKHmFKP+fLsdpsF1Dv5fdg8ad6A/Skg6nRJ3COPoqiHM57IP+stZKmAg
         oyhxhXT5AwALaadIBPu3V1kVqT07Vc3PK1/8lzgXpqALj3OS25h6c+bS/hxj5RvPirkv
         UxnQ==
X-Gm-Message-State: AOAM531BPm5vIfzffHqvsGHglQFJhcFcX0LKTqqILBeqq+HG/PpzJOpu
        MXdOe9v2u7SKStcil4naHOr2vbSYjmt+puQVtxfbgmTR
X-Google-Smtp-Source: ABdhPJxmDfD1NyyUV3EkivXrQpMXwKYe3R23TTcGI4Zdepfib0jebW4AoXLv4dYBDTQGn96mwmp/a4UjwCLA01yxfZs=
X-Received: by 2002:a05:6102:31a5:: with SMTP id d5mr2266754vsh.23.1631749219714;
 Wed, 15 Sep 2021 16:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
 <CAPHZWUf91fsLi+fz8q3ocrgTfiq=+VFez75RbNQ4ckNL1jOeKw@mail.gmail.com>
In-Reply-To: <CAPHZWUf91fsLi+fz8q3ocrgTfiq=+VFez75RbNQ4ckNL1jOeKw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Sep 2021 16:40:09 -0700
Message-ID: <CABBYNZK8iek+4Osyac=0Q4CU2gBwJvvCoJXh7xOXr2sBm4jzQw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] plugins/admin: add adapter_remove handler
To:     Yun-hao Chung <howardchung@google.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Sep 15, 2021 at 5:32 AM Yun-hao Chung <howardchung@google.com> wrote:
>
> Gentle ping. Thanks.
>
>
> On Mon, Sep 6, 2021 at 2:03 PM Howard Chung <howardchung@google.com> wrote:
> >
> > From: Yun-Hao Chung <howardchung@chromium.org>
> >
> > Currently admin doesn't handle adapter removed callbacks, which causes
> > interfaces AdminPolicySet1 and AdminPolicyStatus1 not being
> > unregistered, which in turns causes these interfaces can not be
> > re-registered once adapter is back.
> >
> > This adds handler for adapter_remove.
> >
> > Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> > tested with following steps
> > 1. rmmod btusb
> > 2. modprobe btusb
> > 3. read allowlist via bluetoothctl
> >
> > Changes in v2:
> > 1. Fix make errors
> >
> >  plugins/admin.c | 35 ++++++++++++++++++++++++++++-------
> >  1 file changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/plugins/admin.c b/plugins/admin.c
> > index 02fec04568ba..82c00cabdb6b 100644
> > --- a/plugins/admin.c
> > +++ b/plugins/admin.c
> > @@ -85,6 +85,17 @@ static void admin_policy_free(void *data)
> >         g_free(admin_policy);
> >  }
> >
> > +static void admin_policy_destroy(struct btd_admin_policy *admin_policy)
> > +{
> > +       const char *path = adapter_get_path(admin_policy->adapter);
> > +
> > +       g_dbus_unregister_interface(dbus_conn, path,
> > +                                               ADMIN_POLICY_SET_INTERFACE);
> > +       g_dbus_unregister_interface(dbus_conn, path,
> > +                                               ADMIN_POLICY_STATUS_INTERFACE);
> > +       admin_policy_free(admin_policy);
> > +}
> > +
> >  static bool uuid_match(const void *data, const void *match_data)
> >  {
> >         const bt_uuid_t *uuid = data;
> > @@ -492,7 +503,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
> >         if (!g_dbus_register_interface(dbus_conn, adapter_path,
> >                                         ADMIN_POLICY_SET_INTERFACE,
> >                                         admin_policy_adapter_methods, NULL,
> > -                                       NULL, policy_data, admin_policy_free)) {
> > +                                       NULL, policy_data, NULL)) {
> >                 btd_error(policy_data->adapter_id,
> >                         "Admin Policy Set interface init failed on path %s",
> >                                                                 adapter_path);
> > @@ -506,7 +517,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
> >                                         ADMIN_POLICY_STATUS_INTERFACE,
> >                                         NULL, NULL,
> >                                         admin_policy_adapter_properties,
> > -                                       policy_data, admin_policy_free)) {
> > +                                       policy_data, NULL)) {
> >                 btd_error(policy_data->adapter_id,
> >                         "Admin Policy Status interface init failed on path %s",
> >                                                                 adapter_path);
> > @@ -574,10 +585,24 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
> >                 unregister_device_data(data, NULL);
> >  }
> >
> > +static void admin_policy_remove(struct btd_adapter *adapter)
> > +{
> > +       DBG("");
> > +
> > +       queue_foreach(devices, unregister_device_data, NULL);
> > +       queue_destroy(devices, g_free);
> > +
> > +       if (policy_data) {
> > +               admin_policy_destroy(policy_data);
> > +               policy_data = NULL;
> > +       }
> > +}
> > +
> >  static struct btd_adapter_driver admin_policy_driver = {
> >         .name   = "admin_policy",
> >         .probe  = admin_policy_adapter_probe,
> >         .resume = NULL,
> > +       .remove = admin_policy_remove,
> >         .device_resolved = admin_policy_device_added,
> >         .device_removed = admin_policy_device_removed
> >  };
> > @@ -597,11 +622,7 @@ static void admin_exit(void)
> >         DBG("");
> >
> >         btd_unregister_adapter_driver(&admin_policy_driver);
> > -       queue_foreach(devices, unregister_device_data, NULL);
> > -       queue_destroy(devices, g_free);
> > -
> > -       if (policy_data)
> > -               admin_policy_free(policy_data);
> > +       admin_policy_remove(NULL);
> >  }
> >
> >  BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
> > --
> > 2.33.0.153.gba50c8fa24-goog
> >

Applied, thanks.


-- 
Luiz Augusto von Dentz
