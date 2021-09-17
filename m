Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD860C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 03:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E7A61056
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Sep 2021 03:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbhIQDo5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 23:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbhIQDo4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 23:44:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13DDC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 20:43:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg28so1697749edb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1msLgxMuoUYRkSqjSYW1EJkXemcrpwMnFdbysKXTnYA=;
        b=n4L+ojhzAz44SHcGI1LZP48TzVZ6Z0QfTzW1wuRRIzSpZ5bPY+62rT6msy8cmiF5YX
         iAc7DFdTZgQrM5xR/EhhLLAqp/2IMSl1jaBsC8Nzov/0Yc1NSC+5kb7f1JVOHHTYwY73
         tCJEKbbYJ9KHr1HKItioGCK1WIk/5rkfuebnoKN4H3cDn6uM7olwPcnU5NC4ANgq9ORJ
         0oUa09VL89f3UOQCM3haFSACsLa1tBASZJq2B8zOqy2ZFPxTKSIEPi2RkDEHg/NaLNSh
         LrF+u+QVj4/lX0UdyX++TJYJETS0fIcZBUsuaP34mH75Z0Lu9C7g+KeDQ17qEC+tNJIb
         7p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1msLgxMuoUYRkSqjSYW1EJkXemcrpwMnFdbysKXTnYA=;
        b=0J9IWTE/cTeRBWX2LbZaG77pGCbni77Q54neqpCPVxZMjVFF99f7BzzUVPQQq1LEmu
         z94xlWAIHbTHJuajK5yranF53Mec/G8Qr2jvlupLlUtn9uSeWIIlIFbzPdSMWAxCSmVc
         soXxCfSuLa5/GTbofWL+1xIxL8kK4oR/fDVcji9Fk4glIjmXtaMXQkRyE6g4DoAOG7cK
         4LBjNiCfJ0KrimMfXDpz84LrOfud7rMn/IySKJXJGXo0+jRZo4up4wLY8yYf7Mn4oXi/
         GbzxOE576B4HE+jOQdoApyQxaGe2wgO8dmdy4XXeRyQejNA1CBYTIFvguVHBoLgp+mNj
         CWnA==
X-Gm-Message-State: AOAM531jN5JKSRihfcxRkajf3XbXhFPXSDPfrHqR9N+z81+EWDhj6OkI
        G+r8H5+wAT4rOxa8UxTeaZJ9Xb/h54uQ1jY5qrJzr6kBqao=
X-Google-Smtp-Source: ABdhPJzOanjTgYhcNpb5yeWr1AlDROXoedIEKuDejKT6gBDrpuwTsqWnyeEzTHPV+JHcMbnD3EgMnhSTwAbYwzy5qbc=
X-Received: by 2002:a50:9fcf:: with SMTP id c73mr9927336edf.308.1631850212932;
 Thu, 16 Sep 2021 20:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
 <CAPHZWUf91fsLi+fz8q3ocrgTfiq=+VFez75RbNQ4ckNL1jOeKw@mail.gmail.com>
 <CABBYNZK8iek+4Osyac=0Q4CU2gBwJvvCoJXh7xOXr2sBm4jzQw@mail.gmail.com> <CABBYNZLCR7y5SpcOGX7J+dsNBOEOd9K0w1B3ZsUUk9WZeXncEA@mail.gmail.com>
In-Reply-To: <CABBYNZLCR7y5SpcOGX7J+dsNBOEOd9K0w1B3ZsUUk9WZeXncEA@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Fri, 17 Sep 2021 11:43:21 +0800
Message-ID: <CAPHZWUf1yuWEi3=xBFfw24tmjenSjfO8m6UWr13+5WERhjcyjw@mail.gmail.com>
Subject: Re: [Bluez PATCH v2 1/2] plugins/admin: add adapter_remove handler
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for catching and delivering the fixes.

I didn't consider the multiple adapters case, and I will send out
another patch to fix it.

On Fri, Sep 17, 2021 at 7:50 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Howard,
>
> On Wed, Sep 15, 2021 at 4:40 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Howard,
> >
> > On Wed, Sep 15, 2021 at 5:32 AM Yun-hao Chung <howardchung@google.com> wrote:
> > >
> > > Gentle ping. Thanks.
> > >
> > >
> > > On Mon, Sep 6, 2021 at 2:03 PM Howard Chung <howardchung@google.com> wrote:
> > > >
> > > > From: Yun-Hao Chung <howardchung@chromium.org>
> > > >
> > > > Currently admin doesn't handle adapter removed callbacks, which causes
> > > > interfaces AdminPolicySet1 and AdminPolicyStatus1 not being
> > > > unregistered, which in turns causes these interfaces can not be
> > > > re-registered once adapter is back.
> > > >
> > > > This adds handler for adapter_remove.
> > > >
> > > > Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>
> > > > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > > > ---
> > > > tested with following steps
> > > > 1. rmmod btusb
> > > > 2. modprobe btusb
> > > > 3. read allowlist via bluetoothctl
> > > >
> > > > Changes in v2:
> > > > 1. Fix make errors
> > > >
> > > >  plugins/admin.c | 35 ++++++++++++++++++++++++++++-------
> > > >  1 file changed, 28 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/plugins/admin.c b/plugins/admin.c
> > > > index 02fec04568ba..82c00cabdb6b 100644
> > > > --- a/plugins/admin.c
> > > > +++ b/plugins/admin.c
> > > > @@ -85,6 +85,17 @@ static void admin_policy_free(void *data)
> > > >         g_free(admin_policy);
> > > >  }
> > > >
> > > > +static void admin_policy_destroy(struct btd_admin_policy *admin_policy)
> > > > +{
> > > > +       const char *path = adapter_get_path(admin_policy->adapter);
> > > > +
> > > > +       g_dbus_unregister_interface(dbus_conn, path,
> > > > +                                               ADMIN_POLICY_SET_INTERFACE);
> > > > +       g_dbus_unregister_interface(dbus_conn, path,
> > > > +                                               ADMIN_POLICY_STATUS_INTERFACE);
> > > > +       admin_policy_free(admin_policy);
> > > > +}
> > > > +
> > > >  static bool uuid_match(const void *data, const void *match_data)
> > > >  {
> > > >         const bt_uuid_t *uuid = data;
> > > > @@ -492,7 +503,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
> > > >         if (!g_dbus_register_interface(dbus_conn, adapter_path,
> > > >                                         ADMIN_POLICY_SET_INTERFACE,
> > > >                                         admin_policy_adapter_methods, NULL,
> > > > -                                       NULL, policy_data, admin_policy_free)) {
> > > > +                                       NULL, policy_data, NULL)) {
> > > >                 btd_error(policy_data->adapter_id,
> > > >                         "Admin Policy Set interface init failed on path %s",
> > > >                                                                 adapter_path);
> > > > @@ -506,7 +517,7 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
> > > >                                         ADMIN_POLICY_STATUS_INTERFACE,
> > > >                                         NULL, NULL,
> > > >                                         admin_policy_adapter_properties,
> > > > -                                       policy_data, admin_policy_free)) {
> > > > +                                       policy_data, NULL)) {
> > > >                 btd_error(policy_data->adapter_id,
> > > >                         "Admin Policy Status interface init failed on path %s",
> > > >                                                                 adapter_path);
> > > > @@ -574,10 +585,24 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
> > > >                 unregister_device_data(data, NULL);
> > > >  }
> > > >
> > > > +static void admin_policy_remove(struct btd_adapter *adapter)
> > > > +{
> > > > +       DBG("");
> > > > +
> > > > +       queue_foreach(devices, unregister_device_data, NULL);
> > > > +       queue_destroy(devices, g_free);
> > > > +
> > > > +       if (policy_data) {
> > > > +               admin_policy_destroy(policy_data);
> > > > +               policy_data = NULL;
> > > > +       }
> > > > +}
> > > > +
> > > >  static struct btd_adapter_driver admin_policy_driver = {
> > > >         .name   = "admin_policy",
> > > >         .probe  = admin_policy_adapter_probe,
> > > >         .resume = NULL,
> > > > +       .remove = admin_policy_remove,
> > > >         .device_resolved = admin_policy_device_added,
> > > >         .device_removed = admin_policy_device_removed
> > > >  };
> > > > @@ -597,11 +622,7 @@ static void admin_exit(void)
> > > >         DBG("");
> > > >
> > > >         btd_unregister_adapter_driver(&admin_policy_driver);
> > > > -       queue_foreach(devices, unregister_device_data, NULL);
> > > > -       queue_destroy(devices, g_free);
> > > > -
> > > > -       if (policy_data)
> > > > -               admin_policy_free(policy_data);
> > > > +       admin_policy_remove(NULL);
> > > >  }
> > > >
> > > >  BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
> > > > --
> > > > 2.33.0.153.gba50c8fa24-goog
> > > >
> >
> > Applied, thanks.
> >
> >
> > --
>
> There are actually some problems with these admin plugin:
>
> https://patchwork.kernel.org/project/bluetooth/patch/20210916223825.276530-1-luiz.dentz@gmail.com/
> https://patchwork.kernel.org/project/bluetooth/patch/20210916223825.276530-2-luiz.dentz@gmail.com/
>
> There is also some assumption that there could be only one
> policy_data, when in fact there could be multiple btd_adapter in the
> system so having admin plugin in a system with multiple adapters might
> lead to various problems.
>
>
> --
> Luiz Augusto von Dentz
