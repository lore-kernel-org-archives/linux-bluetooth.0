Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C3BC64E7B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 23:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448C7217A0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Dec 2020 23:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLBX2c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Dec 2020 18:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgLBX2c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Dec 2020 18:28:32 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A4EC0613D6
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Dec 2020 15:27:46 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id 7so689356ejm.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 15:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sfZwoBa5Jl/I4oO6dixpwD1J152e4PC8cjf9AVuAHY=;
        b=cCGx2e8fAtjT27fyAterWnQ0SdePWH4ywuowniW60cUXaGvnyjkJUENvELyw2jfKLg
         jfBoCoKdfvLAb+rTqDUdwa/SInpWx+RC5UETKYBjAPKB9jS3GsSPi5O3G9XtfAz4Nl8V
         GETxK5R2mzHpXg/1/1oFBxOfVI166zGe2uOqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sfZwoBa5Jl/I4oO6dixpwD1J152e4PC8cjf9AVuAHY=;
        b=KzUL///DlOmDeCkEDeDUEYC3knu6xiO54CEw8qVSAXrKk5rKA5wR4N8csbfXy9PNWc
         jWfUpiVxXYmmEYd2kTTOzDUD1aI++iCyjUt5+fKNsAh3BKAIDIIvRjwf8QmrrX2l+3CG
         TugAZXrrhTYVQH9lujW9uy2eF70g/47ZI2z4r4wOt3VExNWNAzdelfDL47Hsbikgvojc
         Fqd/Bz6PEsAE/NUS9nmoTVIEZuuxmTD4cHfJ4S4WsNx6SIHpF9epCPYmJKise07RzgME
         ca8I3ziW6wUo4kOS7+2KM7c8SLC9/1rEbV8DxL62SkgYNt3IFDZexqBIG1SAh+FigyI3
         6L6g==
X-Gm-Message-State: AOAM531vWl96Pxpl+8cK3pctJx+ilvGAL7OUyOBTk/0fM1Dktbh7veBG
        1k+hRa5j08LBv2LygrSCigTXinTKxHq3hw==
X-Google-Smtp-Source: ABdhPJx95InuttZwi+HPfJtwKS3Mn2CRUCGGPCwgOwQIYPzAtuYgniwePNcvzMgiBTKuQ1fNdjCiUQ==
X-Received: by 2002:a17:906:3c04:: with SMTP id h4mr157098ejg.220.1606951664171;
        Wed, 02 Dec 2020 15:27:44 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id f8sm152377eds.19.2020.12.02.15.27.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 15:27:43 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id 23so5859387wrc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Dec 2020 15:27:43 -0800 (PST)
X-Received: by 2002:adf:c648:: with SMTP id u8mr444597wrg.215.1606951662716;
 Wed, 02 Dec 2020 15:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20201202011930.2130671-1-mmandlik@google.com> <20201201171838.bluez.v1.2.Ia29ecb3a2ddfd9e2939c94feca9eca0f06655ad9@changeid>
 <CABBYNZJv4EAvECG7j+fgZCpvp9GYRZ45RWcdB5s-ZaSR_uRvSA@mail.gmail.com>
 <CAO271m=hutVbyDZsaoF3u-qt561atD5SF2THRp4WWVkqYCyhrw@mail.gmail.com> <CABBYNZJdt1JU2j6FqjLJ6DpFgdgeVQMt-GwYNmCi_RN7UaQC0g@mail.gmail.com>
In-Reply-To: <CABBYNZJdt1JU2j6FqjLJ6DpFgdgeVQMt-GwYNmCi_RN7UaQC0g@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 2 Dec 2020 15:27:31 -0800
X-Gmail-Original-Message-ID: <CAO271mkm1TTLrRS4+1agyOMmKiOH50cMaAWK3YKhSGjSBn-z5g@mail.gmail.com>
Message-ID: <CAO271mkm1TTLrRS4+1agyOMmKiOH50cMaAWK3YKhSGjSBn-z5g@mail.gmail.com>
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

If I understand correctly, your concern is only on the bluetoothctl
part? If so, it is okay for bluetoothd to listen to subtrees for
clients that want to use subtree, is that correct?

On Wed, Dec 2, 2020 at 11:50 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Wed, Dec 2, 2020 at 10:58 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
> >
> > Hi Luiz,
> >
> > The purpose here is that each application can have its own namespace
> > (e.g. /my/app, its objects should be in the form of /my/app/...) so
> > that it doesn't get mixed up with objects of other applications. I see
> > that there is already a pattern of using D-Bus ObjectManager this way
> > in bluez (there exists g_dbus_client_new_full to listen to objects in
> > a subtree), and also it is documented in D-Bus specification
> > (https://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager)
> > so I don't think this violates any D-Bus best practices.
>
> The subtree support is meant for clients that actually want to do this
> in a subtree, rather then using '/', but bluetoothctl is already using
> '/' which would be parent to any subtree you would like to do. So
> while we support client using substres, I don't feel like bluetoothctl
> should use that as we already support adding GATT applications using
> '/' except if you really want to have multiple apps/subtrees but it
> doesn't look like this is the case and anyway when that happen that
> normally involves using different D-Bus connection.
>
> > On Wed, Dec 2, 2020 at 9:46 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Manish,
> > >
> > > On Tue, Dec 1, 2020 at 5:20 PM Manish Mandlik <mmandlik@google.com> wrote:
> > > >
> > > > Bluetoothctl shares the gdbus library implementation with bluetoothd.
> > > > When bluetoothctl starts, it registers itself with the dbus with root
> > > > path same as the bluez root path i.e. '/'.
> > > >
> > > > When advertisement monitor objects are created or removed,
> > > > InterfacesAdded/InterfacesRemoved signals are emitted. These signals
> > > > are emitted at the registered root path by default.
> > > >
> > > > However, these signals need to be emitted at the app root path
> > > > registered using the "RegisterMonitor" method while registering the
> > > > client app with bluetoothd.
> > > >
> > > > This patch adds support in the gdbus library to emit signals at the app
> > > > root path.
> > >
> > > There can only be one root path really to guarantee there is one
> > > ObjectManager and we don't end up with ObjectManager listing other
> > > object managers which would likely cause problems.
> > >
> > > > Signed-off-by: Manish Mandlik <mmandlik@google.com>
> > > > Reviewed-by: sonnysasaka@chromium.org
> > > > Reviewed-by: howardchung@google.com
> > > > Reviewed-by: mcchou@chromium.org
> > > >
> > > > ---
> > > >
> > > >  gdbus/gdbus.h  | 15 +++++++++++++++
> > > >  gdbus/object.c | 39 ++++++++++++++++++++++++++++++---------
> > > >  2 files changed, 45 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> > > > index 28b802296..3bddaf9e6 100644
> > > > --- a/gdbus/gdbus.h
> > > > +++ b/gdbus/gdbus.h
> > > > @@ -210,6 +210,13 @@ struct GDBusSecurityTable {
> > > >  void g_dbus_set_flags(int flags);
> > > >  int g_dbus_get_flags(void);
> > > >
> > > > +/* Note that, when new interface is registered, InterfacesAdded signal is
> > > > + * emitted. This signal is by default emitted at root path "/" registered
> > > > + * while registering a client using g_dbus_client_new(). If this behavior
> > > > + * is undesired, use g_dbus_register_interface_full() with a desired root
> > > > + * path to ensure InterfacesAdded / InterfacesRemoved signals get emitted
> > > > + * at the correct path.
> > > > + */
> > > >  gboolean g_dbus_register_interface(DBusConnection *connection,
> > > >                                         const char *path, const char *name,
> > > >                                         const GDBusMethodTable *methods,
> > > > @@ -217,6 +224,14 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
> > > >                                         const GDBusPropertyTable *properties,
> > > >                                         void *user_data,
> > > >                                         GDBusDestroyFunction destroy);
> > > > +gboolean g_dbus_register_interface_full(DBusConnection *connection,
> > > > +                                       const char *path, const char *name,
> > > > +                                       const char *root_path,
> > > > +                                       const GDBusMethodTable *methods,
> > > > +                                       const GDBusSignalTable *signals,
> > > > +                                       const GDBusPropertyTable *properties,
> > > > +                                       void *user_data,
> > > > +                                       GDBusDestroyFunction destroy);
> > > >  gboolean g_dbus_unregister_interface(DBusConnection *connection,
> > > >                                         const char *path, const char *name);
> > > >
> > > > diff --git a/gdbus/object.c b/gdbus/object.c
> > > > index 50a8b4ff1..0d8a0696e 100644
> > > > --- a/gdbus/object.c
> > > > +++ b/gdbus/object.c
> > > > @@ -38,6 +38,7 @@ struct generic_data {
> > > >         unsigned int refcount;
> > > >         DBusConnection *conn;
> > > >         char *path;
> > > > +       char *root_path;
> > > >         GSList *interfaces;
> > > >         GSList *objects;
> > > >         GSList *added;
> > > > @@ -551,9 +552,10 @@ static void emit_interfaces_added(struct generic_data *data)
> > > >         if (root == NULL || data == root)
> > > >                 return;
> > > >
> > > > -       signal = dbus_message_new_signal(root->path,
> > > > -                                       DBUS_INTERFACE_OBJECT_MANAGER,
> > > > -                                       "InterfacesAdded");
> > > > +       signal = dbus_message_new_signal(
> > > > +                               data->root_path ? data->root_path : root->path,
> > > > +                               DBUS_INTERFACE_OBJECT_MANAGER,
> > > > +                               "InterfacesAdded");
> > > >         if (signal == NULL)
> > > >                 return;
> > > >
> > > > @@ -953,9 +955,10 @@ static void emit_interfaces_removed(struct generic_data *data)
> > > >         if (root == NULL || data == root)
> > > >                 return;
> > > >
> > > > -       signal = dbus_message_new_signal(root->path,
> > > > -                                       DBUS_INTERFACE_OBJECT_MANAGER,
> > > > -                                       "InterfacesRemoved");
> > > > +       signal = dbus_message_new_signal(
> > > > +                               data->root_path ? data->root_path : root->path,
> > > > +                               DBUS_INTERFACE_OBJECT_MANAGER,
> > > > +                               "InterfacesRemoved");
> > > >         if (signal == NULL)
> > > >                 return;
> > > >
> > > > @@ -1026,6 +1029,7 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
> > > >
> > > >         dbus_connection_unref(data->conn);
> > > >         g_free(data->introspect);
> > > > +       g_free(data->root_path);
> > > >         g_free(data->path);
> > > >         g_free(data);
> > > >  }
> > > > @@ -1222,7 +1226,8 @@ done:
> > > >  }
> > > >
> > > >  static struct generic_data *object_path_ref(DBusConnection *connection,
> > > > -                                                       const char *path)
> > > > +                                                       const char *path,
> > > > +                                                       const char *root_path)
> > > >  {
> > > >         struct generic_data *data;
> > > >
> > > > @@ -1237,6 +1242,8 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
> > > >         data = g_new0(struct generic_data, 1);
> > > >         data->conn = dbus_connection_ref(connection);
> > > >         data->path = g_strdup(path);
> > > > +       if (root_path)
> > > > +               data->root_path = g_strdup(root_path);
> > > >         data->refcount = 1;
> > > >
> > > >         data->introspect = g_strdup(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE "<node></node>");
> > > > @@ -1245,6 +1252,7 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
> > > >                                                 &generic_table, data)) {
> > > >                 dbus_connection_unref(data->conn);
> > > >                 g_free(data->path);
> > > > +               g_free(data->root_path);
> > > >                 g_free(data->introspect);
> > > >                 g_free(data);
> > > >                 return NULL;
> > > > @@ -1330,6 +1338,19 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
> > > >                                         const GDBusPropertyTable *properties,
> > > >                                         void *user_data,
> > > >                                         GDBusDestroyFunction destroy)
> > > > +{
> > > > +       return g_dbus_register_interface_full(connection, path, name, NULL,
> > > > +                       methods, signals, properties, user_data, destroy);
> > > > +}
> > > > +
> > > > +gboolean g_dbus_register_interface_full(DBusConnection *connection,
> > > > +                                       const char *path, const char *name,
> > > > +                                       const char *root_path,
> > > > +                                       const GDBusMethodTable *methods,
> > > > +                                       const GDBusSignalTable *signals,
> > > > +                                       const GDBusPropertyTable *properties,
> > > > +                                       void *user_data,
> > > > +                                       GDBusDestroyFunction destroy)
> > > >  {
> > > >         struct generic_data *data;
> > > >
> > > > @@ -1343,7 +1364,7 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
> > > >                 return FALSE;
> > > >         }
> > > >
> > > > -       data = object_path_ref(connection, path);
> > > > +       data = object_path_ref(connection, path, root_path);
> > > >         if (data == NULL)
> > > >                 return FALSE;
> > > >
> > > > @@ -1811,7 +1832,7 @@ gboolean g_dbus_attach_object_manager(DBusConnection *connection)
> > > >  {
> > > >         struct generic_data *data;
> > > >
> > > > -       data = object_path_ref(connection, "/");
> > > > +       data = object_path_ref(connection, "/", NULL);
> > > >         if (data == NULL)
> > > >                 return FALSE;
> > > >
> > > > --
> > > > 2.29.2.454.gaff20da3a2-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
