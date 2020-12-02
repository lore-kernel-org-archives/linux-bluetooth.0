Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD4C64E7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBA32173E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 18:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387828AbgLBS7j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgLBS7j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 13:59:39 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3942EC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 10:58:59 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id x16so5982467ejj.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 10:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c70Or448H1j72K34HLObb+3XE0P2lhA/KhJwfBnlOV0=;
        b=C+Ap+Wexybo2/XtMSHfOEJB/LTVtWuWtwQE4oia542+07ZFfo6MoyKE7+nM4IvsVxV
         LPqHeatdjKQ+bh9LVpzr0PIIP1ZlW2PKwP/m1CAKu80+cKlmL3UH6UsohvQscxgIlh+o
         9PWxbN6//8C5s6zYrAnUAfpZ5ygZf0qzhBa58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c70Or448H1j72K34HLObb+3XE0P2lhA/KhJwfBnlOV0=;
        b=mM9xAr0bYIArd7i4GPQ43yUKePI9Hql16TeSpE7BJq4YS3JH+SpnEnJeLIuvN5QAH6
         x0EJj7BWKEB6ehUPZEliGbe3YzANyTC7BvOQ/PaY458OaCe8FURIhPP467O96ng4dP/h
         o6XHvnRizFGn9C67x8IRklKOLep5AkrpMsGRp+SC64IH8k3piCMSIuJO2s/KTDGfMYM9
         tg+3Qz2qHmbpsiYPjElvU1paNxKU3DezQAlyM0qPL4j6VjZRgFzFjo44q9yD/cO/hBYf
         CgW5FXgu7G5pIbcFx2JogloFnQ1MBaFF/Q9/5YC6B1oFEA+haEiZ+P+S+xz59D3NagXf
         KDDQ==
X-Gm-Message-State: AOAM5335KMkBBI0R/L0maVE6rPIxkgzA6Neg0m/F2t51MgscFNsBUwuo
        xikN/ZdtJIRA/pEKm9fv95z47BAoo3hvhg==
X-Google-Smtp-Source: ABdhPJyk6BEMV8a2BfIwt0ZBMkfU8QIfZZUSjemKMH1uaW26ft6fP2quUgQWJfhFg5flIxnVEuqITA==
X-Received: by 2002:a17:906:6091:: with SMTP id t17mr1182087ejj.476.1606935537438;
        Wed, 02 Dec 2020 10:58:57 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id e12sm590505edm.48.2020.12.02.10.58.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:58:56 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id h21so11323813wmb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 10:58:56 -0800 (PST)
X-Received: by 2002:a1c:68d6:: with SMTP id d205mr4570525wmc.154.1606935535552;
 Wed, 02 Dec 2020 10:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20201202011930.2130671-1-mmandlik@google.com> <20201201171838.bluez.v1.2.Ia29ecb3a2ddfd9e2939c94feca9eca0f06655ad9@changeid>
 <CABBYNZJv4EAvECG7j+fgZCpvp9GYRZ45RWcdB5s-ZaSR_uRvSA@mail.gmail.com>
In-Reply-To: <CABBYNZJv4EAvECG7j+fgZCpvp9GYRZ45RWcdB5s-ZaSR_uRvSA@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 2 Dec 2020 10:58:44 -0800
X-Gmail-Original-Message-ID: <CAO271m=hutVbyDZsaoF3u-qt561atD5SF2THRp4WWVkqYCyhrw@mail.gmail.com>
Message-ID: <CAO271m=hutVbyDZsaoF3u-qt561atD5SF2THRp4WWVkqYCyhrw@mail.gmail.com>
Subject: Re: [bluez PATCH v1 2/3] gdbus: Emit InterfacesAdded/Removed at app
 root path
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Manish Mandlik <mmandlik@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Yun-hao Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

The purpose here is that each application can have its own namespace
(e.g. /my/app, its objects should be in the form of /my/app/...) so
that it doesn't get mixed up with objects of other applications. I see
that there is already a pattern of using D-Bus ObjectManager this way
in bluez (there exists g_dbus_client_new_full to listen to objects in
a subtree), and also it is documented in D-Bus specification
(https://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
so I don't think this violates any D-Bus best practices.

On Wed, Dec 2, 2020 at 9:46 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Manish,
>
> On Tue, Dec 1, 2020 at 5:20 PM Manish Mandlik <mmandlik@google.com> wrote:
> >
> > Bluetoothctl shares the gdbus library implementation with bluetoothd.
> > When bluetoothctl starts, it registers itself with the dbus with root
> > path same as the bluez root path i.e. '/'.
> >
> > When advertisement monitor objects are created or removed,
> > InterfacesAdded/InterfacesRemoved signals are emitted. These signals
> > are emitted at the registered root path by default.
> >
> > However, these signals need to be emitted at the app root path
> > registered using the "RegisterMonitor" method while registering the
> > client app with bluetoothd.
> >
> > This patch adds support in the gdbus library to emit signals at the app
> > root path.
>
> There can only be one root path really to guarantee there is one
> ObjectManager and we don't end up with ObjectManager listing other
> object managers which would likely cause problems.
>
> > Signed-off-by: Manish Mandlik <mmandlik@google.com>
> > Reviewed-by: sonnysasaka@chromium.org
> > Reviewed-by: howardchung@google.com
> > Reviewed-by: mcchou@chromium.org
> >
> > ---
> >
> >  gdbus/gdbus.h  | 15 +++++++++++++++
> >  gdbus/object.c | 39 ++++++++++++++++++++++++++++++---------
> >  2 files changed, 45 insertions(+), 9 deletions(-)
> >
> > diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> > index 28b802296..3bddaf9e6 100644
> > --- a/gdbus/gdbus.h
> > +++ b/gdbus/gdbus.h
> > @@ -210,6 +210,13 @@ struct GDBusSecurityTable {
> >  void g_dbus_set_flags(int flags);
> >  int g_dbus_get_flags(void);
> >
> > +/* Note that, when new interface is registered, InterfacesAdded signal is
> > + * emitted. This signal is by default emitted at root path "/" registered
> > + * while registering a client using g_dbus_client_new(). If this behavior
> > + * is undesired, use g_dbus_register_interface_full() with a desired root
> > + * path to ensure InterfacesAdded / InterfacesRemoved signals get emitted
> > + * at the correct path.
> > + */
> >  gboolean g_dbus_register_interface(DBusConnection *connection,
> >                                         const char *path, const char *name,
> >                                         const GDBusMethodTable *methods,
> > @@ -217,6 +224,14 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
> >                                         const GDBusPropertyTable *properties,
> >                                         void *user_data,
> >                                         GDBusDestroyFunction destroy);
> > +gboolean g_dbus_register_interface_full(DBusConnection *connection,
> > +                                       const char *path, const char *name,
> > +                                       const char *root_path,
> > +                                       const GDBusMethodTable *methods,
> > +                                       const GDBusSignalTable *signals,
> > +                                       const GDBusPropertyTable *properties,
> > +                                       void *user_data,
> > +                                       GDBusDestroyFunction destroy);
> >  gboolean g_dbus_unregister_interface(DBusConnection *connection,
> >                                         const char *path, const char *name);
> >
> > diff --git a/gdbus/object.c b/gdbus/object.c
> > index 50a8b4ff1..0d8a0696e 100644
> > --- a/gdbus/object.c
> > +++ b/gdbus/object.c
> > @@ -38,6 +38,7 @@ struct generic_data {
> >         unsigned int refcount;
> >         DBusConnection *conn;
> >         char *path;
> > +       char *root_path;
> >         GSList *interfaces;
> >         GSList *objects;
> >         GSList *added;
> > @@ -551,9 +552,10 @@ static void emit_interfaces_added(struct generic_data *data)
> >         if (root == NULL || data == root)
> >                 return;
> >
> > -       signal = dbus_message_new_signal(root->path,
> > -                                       DBUS_INTERFACE_OBJECT_MANAGER,
> > -                                       "InterfacesAdded");
> > +       signal = dbus_message_new_signal(
> > +                               data->root_path ? data->root_path : root->path,
> > +                               DBUS_INTERFACE_OBJECT_MANAGER,
> > +                               "InterfacesAdded");
> >         if (signal == NULL)
> >                 return;
> >
> > @@ -953,9 +955,10 @@ static void emit_interfaces_removed(struct generic_data *data)
> >         if (root == NULL || data == root)
> >                 return;
> >
> > -       signal = dbus_message_new_signal(root->path,
> > -                                       DBUS_INTERFACE_OBJECT_MANAGER,
> > -                                       "InterfacesRemoved");
> > +       signal = dbus_message_new_signal(
> > +                               data->root_path ? data->root_path : root->path,
> > +                               DBUS_INTERFACE_OBJECT_MANAGER,
> > +                               "InterfacesRemoved");
> >         if (signal == NULL)
> >                 return;
> >
> > @@ -1026,6 +1029,7 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
> >
> >         dbus_connection_unref(data->conn);
> >         g_free(data->introspect);
> > +       g_free(data->root_path);
> >         g_free(data->path);
> >         g_free(data);
> >  }
> > @@ -1222,7 +1226,8 @@ done:
> >  }
> >
> >  static struct generic_data *object_path_ref(DBusConnection *connection,
> > -                                                       const char *path)
> > +                                                       const char *path,
> > +                                                       const char *root_path)
> >  {
> >         struct generic_data *data;
> >
> > @@ -1237,6 +1242,8 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
> >         data = g_new0(struct generic_data, 1);
> >         data->conn = dbus_connection_ref(connection);
> >         data->path = g_strdup(path);
> > +       if (root_path)
> > +               data->root_path = g_strdup(root_path);
> >         data->refcount = 1;
> >
> >         data->introspect = g_strdup(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE "<node></node>");
> > @@ -1245,6 +1252,7 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
> >                                                 &generic_table, data)) {
> >                 dbus_connection_unref(data->conn);
> >                 g_free(data->path);
> > +               g_free(data->root_path);
> >                 g_free(data->introspect);
> >                 g_free(data);
> >                 return NULL;
> > @@ -1330,6 +1338,19 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
> >                                         const GDBusPropertyTable *properties,
> >                                         void *user_data,
> >                                         GDBusDestroyFunction destroy)
> > +{
> > +       return g_dbus_register_interface_full(connection, path, name, NULL,
> > +                       methods, signals, properties, user_data, destroy);
> > +}
> > +
> > +gboolean g_dbus_register_interface_full(DBusConnection *connection,
> > +                                       const char *path, const char *name,
> > +                                       const char *root_path,
> > +                                       const GDBusMethodTable *methods,
> > +                                       const GDBusSignalTable *signals,
> > +                                       const GDBusPropertyTable *properties,
> > +                                       void *user_data,
> > +                                       GDBusDestroyFunction destroy)
> >  {
> >         struct generic_data *data;
> >
> > @@ -1343,7 +1364,7 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
> >                 return FALSE;
> >         }
> >
> > -       data = object_path_ref(connection, path);
> > +       data = object_path_ref(connection, path, root_path);
> >         if (data == NULL)
> >                 return FALSE;
> >
> > @@ -1811,7 +1832,7 @@ gboolean g_dbus_attach_object_manager(DBusConnection *connection)
> >  {
> >         struct generic_data *data;
> >
> > -       data = object_path_ref(connection, "/");
> > +       data = object_path_ref(connection, "/", NULL);
> >         if (data == NULL)
> >                 return FALSE;
> >
> > --
> > 2.29.2.454.gaff20da3a2-goog
> >
>
>
> --
> Luiz Augusto von Dentz
