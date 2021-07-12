Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E51C07E9C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 03:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF2761006
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Jul 2021 03:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbhGLD7V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Jul 2021 23:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhGLD7U (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Jul 2021 23:59:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66E5C0613DD
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jul 2021 20:56:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id c17so31676390ejk.13
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Jul 2021 20:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1s56UC4kjtjCFoBS895Sl/EERGlDZ9HXC5O0BNFvBUs=;
        b=F6QUm+ONfn9bKJy+551C0cgTUNDWd4+NcdYQHUYgzaWcYCo4mjKtBzb/CIJKx6zTIa
         Xbbatwshaqpw/wTJS9AFyg1HJO7LMQ4OAxhQkmWsZ5TmFvEa46xbtEjQ96ipWCnxgFrY
         +jGfcLPQlbIBu+0LEm6t/4XrqJSMrBX1PNkSAahAFjw3/GYja5afz/JvGb1I+De38WTs
         Hv4T+yTrfyMdo5VF4CtC3vAd4HdYiWJF4H95kxTIsvLdUbY9s8fThIYkfw168YvCtLHr
         yXC/8fO7HlvY7c8poSoSonPm9QsVZVjwawNcR6gJt2rYaCsHSWcsZX6zLRofjhayLISc
         i7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1s56UC4kjtjCFoBS895Sl/EERGlDZ9HXC5O0BNFvBUs=;
        b=W0UFk2Ep4U/7+T64Sc5YsSqBz0w1uta249e8cdEBZY6nN50HEy6wZblOomXiSR6gwz
         VU8qlJQLJOE6swJt0tdE+vvvmtZuwIQMTI+ciZlIRD+fILlsqvtZoSq/oWEmzk6A+UBm
         T8Q55fluZMhDZhhOylQnGn+zwHaONsSa9Dt5jjH2JCi8LKvdKbon887nq67SptSNkQ0T
         h+IW9XvFYGmJop47hE7GOfN3DkAmOeebYcurvO+sfna+A/s1Lhpu2t35UKW73rZa+o7Z
         zE29Hc6e3v9vAF/cmzhxRi06ASjePgYC3IrCxt/Hs2Hwvazmgf8DaCpUdb2LW2ybjibJ
         62tA==
X-Gm-Message-State: AOAM530azAwDbI9AWBpJjBXxzPImxB7Qa+gFr4/D+NV0ujEoesdObe5k
        QL0RkO+rW64qzKnCPO9u352vw4AGXHftOM3osrnsqw==
X-Google-Smtp-Source: ABdhPJyIDgUGUoD+4emiSyMWYDnrzU9sj79n8TMxNYpAq91Xd4DkAifIQr4JMVlz4dK4g2zcdp+hOYSWDpkl0TpRxek=
X-Received: by 2002:a17:906:2303:: with SMTP id l3mr8800118eja.419.1626062190066;
 Sun, 11 Jul 2021 20:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
 <20210708142059.Bluez.v1.5.I699a3837a5a18d9f889635300f6c717879f19dd2@changeid>
 <CABBYNZJie9UMrvLkdPPX1rU-7PXy0YHy9DJTrCAikaB_djx4uw@mail.gmail.com>
In-Reply-To: <CABBYNZJie9UMrvLkdPPX1rU-7PXy0YHy9DJTrCAikaB_djx4uw@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Mon, 12 Jul 2021 11:56:19 +0800
Message-ID: <CAPHZWUc1veeRnhhbV-a+Pc1+d6xjXCauA_mrs+rMddn7=MYY7g@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 05/14] core: add device state and state callbacks
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Jul 9, 2021 at 1:34 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Howard,
>
> On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
> >
> > From: Yun-Hao Chung <howardchung@chromium.org>
> >
> > This implements functions to register/unregister state changed callback
> > functions, the functions will be called when a device's state changed.
> > Currently the state only shows initializing, available and removing,
> > which is enough for plugins to register dbus objects upon device
> > creation and unregister it upon device removal.
> >
> > Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> > ---
> >
> >  src/device.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  src/device.h | 13 +++++++++++
> >  2 files changed, 77 insertions(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index e1d82eab0988..0d7444706336 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -81,6 +81,13 @@
> >
> >  static DBusConnection *dbus_conn = NULL;
> >  static unsigned service_state_cb_id;
> > +static GSList *device_state_callbacks;
>
> Use a struct queue instead of GSList.
Will do.
>
> > +
> > +struct device_state_callback {
> > +       btd_device_state_cb     cb;
> > +       void                    *user_data;
> > +       unsigned int            id;
> > +};
> >
> >  struct btd_disconnect_data {
> >         guint id;
> > @@ -272,6 +279,8 @@ struct btd_device {
> >
> >         GIOChannel      *att_io;
> >         guint           store_id;
> > +
> > +       enum btd_device_state_t state;
> >  };
> >
> >  static const uint16_t uuid_list[] = {
> > @@ -4095,6 +4104,23 @@ static void gatt_service_removed(struct gatt_db_attribute *attr,
> >         gatt_services_changed(device);
> >  }
> >
> > +static void device_change_state(struct btd_device *device,
> > +                                       enum btd_device_state_t new_state)
> > +{
> > +       GSList *l;
> > +       struct device_state_callback *cb_data;
> > +
> > +       if (device->state == new_state)
> > +               return;
> > +
> > +       for (l = device_state_callbacks; l != NULL; l = g_slist_next(l)) {
> > +               cb_data = l->data;
> > +               cb_data->cb(device, new_state, cb_data->user_data);
> > +       }
> > +
> > +       device->state = new_state;
> > +}
> > +
> >  static struct btd_device *device_new(struct btd_adapter *adapter,
> >                                 const char *address)
> >  {
> > @@ -4158,6 +4184,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
> >
> >         device->refresh_discovery = btd_opts.refresh_discovery;
> >
> > +       device_change_state(device, BTD_DEVICE_STATE_AVAILABLE);
> > +
> >         return btd_device_ref(device);
> >  }
> >
> > @@ -6839,6 +6867,7 @@ void btd_device_unref(struct btd_device *device)
> >
> >         DBG("Freeing device %s", device->path);
> >
> > +       device_change_state(device, BTD_DEVICE_STATE_REMOVING);
> >         g_dbus_unregister_interface(dbus_conn, device->path, DEVICE_INTERFACE);
> >  }
> >
> > @@ -6980,3 +7009,38 @@ void btd_device_cleanup(void)
> >  {
> >         btd_service_remove_state_cb(service_state_cb_id);
> >  }
> > +
> > +unsigned int btd_device_add_state_cb(btd_device_state_cb cb, void *user_data)
> > +{
> > +       struct device_state_callback *cb_data;
> > +       static unsigned int id;
> > +
> > +       cb_data = g_new0(struct device_state_callback, 1);
> > +       cb_data->cb = cb;
> > +       cb_data->user_data = user_data;
> > +       cb_data->id = ++id;
> > +
> > +       device_state_callbacks = g_slist_append(device_state_callbacks,
> > +                                                               cb_data);
> > +
> > +       return cb_data->id;
> > +}
> > +
> > +bool btd_device_remove_state_cb(unsigned int id)
> > +{
> > +       GSList *l;
> > +
> > +       for (l = device_state_callbacks; l != NULL; l = g_slist_next(l)) {
> > +               struct device_state_callback *cb_data = l->data;
> > +
> > +               if (cb_data && cb_data->id == id) {
> > +                       device_state_callbacks = g_slist_remove(
> > +                                                       device_state_callbacks,
> > +                                                       cb_data);
> > +                       g_free(cb_data);
> > +                       return true;
> > +               }
> > +       }
> > +
> > +       return false;
> > +}
> > diff --git a/src/device.h b/src/device.h
> > index 5f615cb4b6b2..a8424aa4f098 100644
> > --- a/src/device.h
> > +++ b/src/device.h
> > @@ -11,8 +11,18 @@
> >
> >  #define DEVICE_INTERFACE       "org.bluez.Device1"
> >
> > +enum btd_device_state_t {
> > +       BTD_DEVICE_STATE_INITIALIZING,  /* Device object is creating */
> > +       BTD_DEVICE_STATE_AVAILABLE,     /* Device object is registered */
> > +       BTD_DEVICE_STATE_REMOVING,      /* Device object is being removed */
> > +};
>
> I got a bad feeling about adding this sort of state, are you trying to
> cover some use case that we can't do with btd_service_add_state_cb? It
> does seem a lot like it but at device level.
I added this so that the admin plugin can know whenever a device
object is created or removed.
I just learned that we can create a dbus client to listen for new
device objects. If it sounds better, I'll do it in this way.
>
> > +
> >  struct btd_device;
> >
> > +typedef void (*btd_device_state_cb) (struct btd_device *device,
> > +                                       enum btd_device_state_t new_state,
> > +                                       void *user_data);
> > +
> >  struct btd_device *device_create(struct btd_adapter *adapter,
> >                                 const bdaddr_t *address, uint8_t bdaddr_type);
> >  struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
> > @@ -179,3 +189,6 @@ bool btd_device_all_services_allowed(struct btd_device *dev);
> >  void btd_device_update_allowed_services(struct btd_device *dev);
> >  void btd_device_init(void);
> >  void btd_device_cleanup(void);
> > +
> > +unsigned int btd_device_add_state_cb(btd_device_state_cb cb, void *user_data);
> > +bool btd_device_remove_state_cb(unsigned int id);
> > --
> > 2.32.0.93.g670b81a890-goog
> >
>
>
> --
> Luiz Augusto von Dentz
