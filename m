Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7F28EA5A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427972; cv=none; b=NxTL17f9l8HBuIgtyhWsx8sUpIPnxbWl0R8MHjBS6cnAXB3s6LsdIg5Dy7ukVFN9baelIfIfwFCAz78gQGzXUDOPTb6FhjfzMKg+wrcAbOyfGEg90XCI53ylijEBYM5qaPIWOjqlS2ovycwD74f+Z5OsBqKEUh84BxUpPPvobig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427972; c=relaxed/simple;
	bh=34hjiI6SEBXI2XXK35y0aNmL8D0u7H8sxh8kb1597U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTI8BWpDMs1Tq4kpUEEMHWAE55gvJJEZ67tLmiJ/5oymfwQqpl0ay3rvog5ugbMg8gQh4KWPSlUuS8mzxNvB7C5aMO2WekQJI8GhUs8USARPfWXp5fLanVOjhcMI4VpDsH+jim36NO2IXVoUZD3VMk9bjVdX5sITNGu8tLht2O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQ+hqd18; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQ+hqd18"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3105ef2a071so21148851fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750427968; x=1751032768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+UyKCypPqtt0rRxXmsvyv4Y735/VQZTOlDPt1FkZOg=;
        b=MQ+hqd18UNMZNQxkS+UAA1HTzA4Ebr98+pi/rJZxiBHvIhbkLe64zY9fbCM+fxMkLP
         pXVwPOD8APp5rXOoCGPa12+nxDsb/YBlYm0F4xHGzgVYAW0SnBpbx8XvjJIFU/iBAXDi
         dysBoGg7c+zx2fyP09aeHLQWNFuq1Li6kYXkJ+cfpSx2H3/lZrZm3nzhfT6CQstmwr6F
         wdr52G3AOijwNXmbvjYGa6Jckd0M0BnMpQykk4CMmP93G67CJ0dYf3xvZ/ueGJZCcdsU
         Wcmx4ovvkEXM/QiJARQklV4qJOpu2C+258AoZk55Y2VV6RP9CIV3Ih1WiNua2145Lolh
         RmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750427968; x=1751032768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+UyKCypPqtt0rRxXmsvyv4Y735/VQZTOlDPt1FkZOg=;
        b=mtWyrEZVx4FGhLUgLYtOmW/TkIGCcyPmKbyI2buESQxJs/vkUfUcFz48IwKw70f4Fc
         lfeVHcon4PI8lB3CEtUgaJfcW2sjiGqpGE/d0VsvfJk1bNI+hM0EM+Mtb7xgNvPS1hmq
         rQUwToUb7quLRpEXydvy6iPD+xmyvLm9vjdOMF28uwE9/HgofmsQxe+fHKr1GuolyYF9
         /jS55ZIasehS2OiLAbGPWOUTGJ+sVI4uldznBOcTcKDt+ogG16go9imgWeu50jRKyd6z
         BIPMYWaD5VDtZGORUvavjHDwWpJbIVxCti5jn8AruVwJ2o626r9vwaY7ghQ2Yl1hGeHf
         VQfA==
X-Gm-Message-State: AOJu0YxdztFMrhgzyAxa1TSWXRSgV/Y91GrEawQUf8RHIu1PL480FaGM
	MqVRWbMDY+DeV/Xi10F9R3AB3Mk5sOvGZ/y457kLfKESIpiy9GqiI3gNx5ZPVIdaylZlFRU5x72
	g/RW7SXFgbAdPSr8jNDopFdV7tQyfnhp1eVoMlgWCeg==
X-Gm-Gg: ASbGnct7iSErBPvTddG6GAguOSpo8cf+ARZ/3p6ZEOO9V+usf9F138E1xvD67YG3+a6
	0yLlmUoW3rnuA7tAPnCUYok8UnY6//WA0rkPFX6kFxgENMSbigW4Bar83K4YvXfSQMfsab0o9uZ
	uUDEKe2O6bR49267TUPgYgDVRFO/C41sM1/qHLOLUSug==
X-Google-Smtp-Source: AGHT+IG1Wlj2KdCb14tWpnp3C3ItsVO8AyvSJObjiRmOuDD9gWUYB49jGLiypOJC8cw/16zmayQO74C6X9639gdNxLU=
X-Received: by 2002:a2e:ba81:0:b0:32a:8916:55af with SMTP id
 38308e7fff4ca-32b98e38561mr7617281fa.2.1750427967579; Fri, 20 Jun 2025
 06:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620113854.2389729-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250620113854.2389729-1-kernel.org@pileofstuff.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Jun 2025 09:59:15 -0400
X-Gm-Features: AX0GCFvCgrO_4QvSEkrErjP1ApGI8dRifZifE5kYyRA1UDrlfTGwIPyiTd6oIRI
Message-ID: <CABBYNZL7k6_NVpLwzR3MnB3ZN0Zy-W65jMtwFjx9G2moVdHVOQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ RFC] Refactor uid_state handling
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Jun 20, 2025 at 7:39=E2=80=AFAM Andrew Sayers
<kernel.org@pileofstuff.org> wrote:
>
> We talked recently about refactoring logind.{c,h} to fit more neatly
> into the program's wider architecture.  This patch sketches out a
> possible approach.  It compiles, but has not been tested beyond that.
> If I'm on the right track, I'll come back with a proper solution.
>
> The old API provided callbacks on high-level "init" and "exit" events.
> That made sense for the limited case it was used for, but seems
> unlikely to scale if this starts picking up more use cases.  So the
> RFC API just provides a single event that passes a `logind_cb_context`
> struct to callbacks, and provides `LOGIND_USER_IS_ACTIVE(ctxt)` to
> replicate the old behaviour.
>
> The old API invited individual transports/drivers to use it directly,
> which again made sense for version 1, but bypassed `transport.h` and
> `driver.h`.  The RFC API registers callbacks with `driver.h` and
> `transport.h` in a more normal way, and they pass `logind_cb_context`
> straight through to the callbacks.  That means we won't need to do
> much refactoring if the struct changes some day, but also means
> individual transports/drivers need to know about `logind.h`.
> The alternative would look something like this:
>
> --- obexd/client/driver.h
> +++ obexd/client/driver.h
> struct obc_driver {
>         const char *service;
>         const char *uuid;
>         void *target;
>         gsize target_len;
>         void *(*supported_features) (struct obc_session *session);
>         int (*probe) (struct obc_session *session);
>         void (*remove) (struct obc_session *session);
> +       int (*uid_state) (const char *state, const int seats);

Don't think we really need to expose the seat state, etc, instead I
would just have a seated and unseated callback which just indicates to
the driver it can do the likes of RegisterProfile/UnregisterProfile
that way we can restrict the handling of seats just to driver.c and I
don't think we really need it for transport drivers the transports are
usable if there are drivers in obc_session_create:

    driver =3D obc_driver_find(service);
    if (driver =3D=3D NULL)
        return NULL;

So once we integrate the seat logic into the driver.c I assume
obc_driver_find will only return drivers that are seated, so
users/applications on a unseated D-Bus connection won't be able to
create any sessions.

> };
> --- obexd/client/driver.c
> +++ obexd/client/driver.c
> +static void call_cb(gpointer data, gpointer ctxt_)
> +{
> +       struct obc_driver *driver =3D (struct obc_driver *)data;
> +       struct logind_cb_context *ctxt =3D (struct logind_cb_context *)ct=
xt_;
> +       if (driver->uid_state) {
> +               ctxt->res |=3D driver->uid_state(ctxt->state, ctxt->seats=
);
> +       }
> +}
>
> That would have a better best case (fewer `#include logind.h`s strewn
> throughout the code) but a worse worst case (bigger refactoring job if
> we need to pass an extra argument some day).  I think the RFC patch is
> a better balance of risks, but am happy either way.
>
> The RFC patches for `pbap.c` and `bluetooth.c` are designed to show
> the difference between the old and new API.  A proper patch will
> probably get rid of the `_cb()`, `_init()` and `_exit()` functions.
>
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> ---
>  obexd/client/driver.c     |  18 +++++
>  obexd/client/driver.h     |   5 ++
>  obexd/client/pbap.c       |  62 ++++++++++------
>  obexd/plugins/bluetooth.c |  30 ++++++--
>  obexd/src/logind.c        | 152 ++++++++++++++++++--------------------
>  obexd/src/logind.h        |  59 ++++++++++++---
>  obexd/src/main.c          |  12 +++
>  obexd/src/transport.c     |  17 +++++
>  obexd/src/transport.h     |   5 ++
>  9 files changed, 237 insertions(+), 123 deletions(-)
>
> diff --git a/obexd/client/driver.c b/obexd/client/driver.c
> index 195cdd2f1..d5d0fe2ab 100644
> --- a/obexd/client/driver.c
> +++ b/obexd/client/driver.c
> @@ -74,3 +74,21 @@ void obc_driver_unregister(struct obc_driver *driver)
>
>         drivers =3D g_slist_remove(drivers, driver);
>  }
> +
> +static void call_cb(gpointer data, gpointer ctxt)
> +{
> +       struct obc_driver *driver =3D (struct obc_driver *)data;
> +
> +       if (driver->uid_state)
> +               driver->uid_state(((struct logind_cb_context *)ctxt));
> +}
> +
> +static void call_uid_state_cb(gpointer ctxt)
> +{
> +       g_slist_foreach(drivers, call_cb, ctxt);
> +}
> +
> +gboolean obc_driver_init(void)
> +{
> +       return logind_register(call_uid_state_cb) >=3D 0;
> +}
> diff --git a/obexd/client/driver.h b/obexd/client/driver.h
> index cc4cace7b..928c0c558 100644
> --- a/obexd/client/driver.h
> +++ b/obexd/client/driver.h
> @@ -8,6 +8,9 @@
>   *
>   */
>
> +#include "obexd/src/logind.h"
> +struct obc_session;
> +
>  struct obc_driver {
>         const char *service;
>         const char *uuid;
> @@ -16,8 +19,10 @@ struct obc_driver {
>         void *(*supported_features) (struct obc_session *session);
>         int (*probe) (struct obc_session *session);
>         void (*remove) (struct obc_session *session);
> +       void (*uid_state) (struct logind_cb_context *ctxt);
>  };
>
>  int obc_driver_register(struct obc_driver *driver);
>  void obc_driver_unregister(struct obc_driver *driver);
>  struct obc_driver *obc_driver_find(const char *pattern);
> +gboolean obc_driver_init(void);
> diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> index 78c46bf86..dc2a519e5 100644
> --- a/obexd/client/pbap.c
> +++ b/obexd/client/pbap.c
> @@ -146,6 +146,9 @@ static DBusConnection *system_conn;
>  static unsigned int listener_id;
>  static char *client_path;
>
> +static int pbap_init_cb(void);
> +static void pbap_exit_cb(void);
> +
>  static struct pending_request *pending_request_new(struct pbap_data *pba=
p,
>                                                         DBusMessage *mess=
age)
>  {
> @@ -1300,6 +1303,20 @@ static void pbap_remove(struct obc_session *sessio=
n)
>         g_dbus_unregister_interface(conn, path, PBAP_INTERFACE);
>  }
>
> +static gboolean user_was_active =3D FALSE;
> +static void pbap_uid_state(struct logind_cb_context *ctxt)
> +{
> +       gboolean user_is_active =3D LOGIND_USER_IS_ACTIVE(ctxt);
> +
> +       if (user_was_active =3D=3D user_is_active)
> +               return;
> +       user_was_active =3D user_is_active;
> +       if (user_is_active)
> +               pbap_init_cb();
> +       else
> +               pbap_exit_cb();
> +}
> +
>  static DBusMessage *pbap_release(DBusConnection *conn,
>         DBusMessage *msg, void *data)
>  {
> @@ -1452,13 +1469,13 @@ static struct obc_driver pbap =3D {
>         .target_len =3D OBEX_PBAP_UUID_LEN,
>         .supported_features =3D pbap_supported_features,
>         .probe =3D pbap_probe,
> -       .remove =3D pbap_remove
> +       .remove =3D pbap_remove,
> +       .uid_state =3D pbap_uid_state
>  };
>
> -static int pbap_init_cb(gboolean at_register)
> +static int pbap_init_cb(void)
>  {
>         int err;
> -       (void)at_register;
>
>         DBG("");
>
> @@ -1483,7 +1500,7 @@ static int pbap_init_cb(gboolean at_register)
>         return 0;
>  }
>
> -static void pbap_exit_cb(gboolean at_unregister)
> +static void pbap_exit_cb(void)
>  {
>         DBusMessage *msg;
>         DBusMessageIter iter;
> @@ -1491,22 +1508,28 @@ static void pbap_exit_cb(gboolean at_unregister)
>
>         DBG("");
>
> -       if (!at_unregister) {
> -               client_path =3D g_strconcat("/org/bluez/obex/", uuid, NUL=
L);
> -               g_strdelimit(client_path, "-", '_');
> +       client_path =3D g_strconcat("/org/bluez/obex/", uuid, NULL);
> +       g_strdelimit(client_path, "-", '_');
>
> -               msg =3D dbus_message_new_method_call("org.bluez", "/org/b=
luez",
> -                                                       "org.bluez.Profil=
eManager1",
> -                                                       "UnregisterProfil=
e");
> +       msg =3D dbus_message_new_method_call("org.bluez", "/org/bluez",
> +                                               "org.bluez.ProfileManager=
1",
> +                                               "UnregisterProfile");
>
> -               dbus_message_iter_init_append(msg, &iter);
> +       dbus_message_iter_init_append(msg, &iter);
>
> -               dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PA=
TH,
> -                                                               &client_p=
ath);
> +       dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
> +                                                       &client_path);
>
> -               g_dbus_send_message(system_conn, msg);
> -       }
> +       g_dbus_send_message(system_conn, msg);
>
> +       pbap_exit();
> +}
> +
> +int pbap_init(void)
> +{
> +}
> +void pbap_exit(void)
> +{
>         g_dbus_remove_watch(system_conn, listener_id);
>
>         unregister_profile();
> @@ -1524,12 +1547,3 @@ static void pbap_exit_cb(gboolean at_unregister)
>
>         obc_driver_unregister(&pbap);
>  }
> -
> -int pbap_init(void)
> -{
> -       return logind_register(pbap_init_cb, pbap_exit_cb);
> -}
> -void pbap_exit(void)
> -{
> -       return logind_unregister(pbap_init_cb, pbap_exit_cb);
> -}
> diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> index 355921479..ebff88db3 100644
> --- a/obexd/plugins/bluetooth.c
> +++ b/obexd/plugins/bluetooth.c
> @@ -57,6 +57,9 @@ static DBusMessage *profile_release(DBusConnection *con=
n, DBusMessage *msg,
>         return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
>  }
>
> +static int bluetooth_init_cb(void);
> +static void bluetooth_exit_cb(void);
> +
>  static void connect_event(GIOChannel *io, GError *err, void *user_data)
>  {
>         int sk =3D g_io_channel_unix_get_fd(io);
> @@ -381,6 +384,20 @@ static void bluetooth_stop(void *data)
>         profiles =3D NULL;
>  }
>
> +static gboolean user_was_active =3D FALSE;
> +static void bluetooth_uid_state(struct logind_cb_context *ctxt)
> +{
> +       gboolean user_is_active =3D LOGIND_USER_IS_ACTIVE(ctxt);
> +
> +       if (user_was_active =3D=3D user_is_active)
> +               return;
> +       user_was_active =3D user_is_active;
> +       if (user_is_active)
> +               bluetooth_init_cb();
> +       else
> +               bluetooth_exit_cb();
> +}
> +
>  static int bluetooth_getpeername(GIOChannel *io, char **name)
>  {
>         GError *gerr =3D NULL;
> @@ -422,14 +439,14 @@ static const struct obex_transport_driver driver =
=3D {
>         .start =3D bluetooth_start,
>         .getpeername =3D bluetooth_getpeername,
>         .getsockname =3D bluetooth_getsockname,
> -       .stop =3D bluetooth_stop
> +       .stop =3D bluetooth_stop,
> +       .uid_state =3D bluetooth_uid_state
>  };
>
>  static unsigned int listener_id =3D 0;
>
> -static int bluetooth_init_cb(gboolean at_register)
> +static int bluetooth_init_cb(void)
>  {
> -       (void)at_register;
>         connection =3D g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
>         if (connection =3D=3D NULL)
>                 return -EPERM;
> @@ -440,10 +457,9 @@ static int bluetooth_init_cb(gboolean at_register)
>         return obex_transport_driver_register(&driver);
>  }
>
> -static void bluetooth_exit_cb(gboolean at_unregister)
> +static void bluetooth_exit_cb(void)
>  {
>         GSList *l;
> -       (void)at_unregister;
>
>         g_dbus_remove_watch(connection, listener_id);
>
> @@ -467,11 +483,11 @@ static void bluetooth_exit_cb(gboolean at_unregiste=
r)
>
>  static int bluetooth_init(void)
>  {
> -       return logind_register(bluetooth_init_cb, bluetooth_exit_cb);
>  }
>  static void bluetooth_exit(void)
>  {
> -       return logind_unregister(bluetooth_init_cb, bluetooth_exit_cb);
> +       if (user_was_active)
> +               bluetooth_exit_cb();
>  }
>
>  OBEX_PLUGIN_DEFINE(bluetooth, bluetooth_init, bluetooth_exit)
> diff --git a/obexd/src/logind.c b/obexd/src/logind.c
> index b4279b209..a8ea25543 100644
> --- a/obexd/src/logind.c
> +++ b/obexd/src/logind.c
> @@ -27,66 +27,48 @@
>
>  static sd_login_monitor * monitor;
>  static int uid;
> -static gboolean active =3D FALSE;
>  static gboolean monitoring_enabled =3D TRUE;
>  static guint event_source;
>  static guint timeout_source;
>
> -struct callback_pair {
> -       logind_init_cb init_cb;
> -       logind_exit_cb exit_cb;
> -};
> -
>  GSList *callbacks;
>
> -static void call_init_cb(gpointer data, gpointer user_data)
> -{
> -       int res;
> -
> -       res =3D ((struct callback_pair *)data)->init_cb(FALSE);
> -       if (res)
> -               *(int *)user_data =3D res;
> -}
> -static void call_exit_cb(gpointer data, gpointer user_data)
> +static void call_cb(gpointer data, gpointer user_data)
>  {
> -       ((struct callback_pair *)data)->exit_cb(FALSE);
> +       (*((logind_cb *)data))(user_data);
>  }
>
> -static int update(void)
> +static void logind_cb_context_init(struct logind_cb_context *ctxt)
>  {
> -       char *state =3D NULL;
> -       gboolean state_is_active;
> -       int res;
> -
> -       res =3D sd_login_monitor_flush(monitor);
> -       if (res < 0)
> -               return res;
> -       res =3D sd_uid_get_state(uid, &state);
> -       state_is_active =3D g_strcmp0(state, "active");
> -       free(state);
> -       if (res < 0)
> -               return res;
> -
> -       if (state_is_active) {
> -               if (!active)
> -                       return 0;
> -       } else {
> -               res =3D sd_uid_get_seats(uid, 1, NULL);
> -               if (res < 0)
> -                       return res;
> -               if (active =3D=3D !!res)
> -                       return 0;
> +       ctxt->res =3D sd_login_monitor_flush(monitor);
> +       if (ctxt->res < 0)
> +               return;
> +
> +       ctxt->res =3D ctxt->seats =3D sd_uid_get_seats(uid, 1, NULL);
> +       if (ctxt->res < 0)
> +               return;
> +
> +       /*
> +        * the documentation for sd_uid_get_state() isn't clear about
> +        * what to do with the state on error.  The following should
> +        * be safe even if the behaviour changes in future
> +        */
> +       ctxt->state =3D 0;
> +       ctxt->res =3D sd_uid_get_state(uid, (char **)&ctxt->state);
> +       if (ctxt->res <=3D 0) {
> +               free((char *)ctxt->state);
> +               return;
>         }
> -       active ^=3D TRUE;
> -       res =3D 0;
> -       g_slist_foreach(callbacks, active ? call_init_cb : call_exit_cb, =
&res);
> -       return res;
> +
> +       ctxt->res =3D 0;
> +       return;
>  }
>
>  static gboolean timeout_handler(gpointer user_data);
>
>  static int check_event(void)
>  {
> +       struct logind_cb_context ctxt;
>         uint64_t timeout_usec;
>         int res;
>
> @@ -95,9 +77,14 @@ static int check_event(void)
>                 return res;
>         if (!monitoring_enabled)
>                 return 0;
> -       res =3D update();
> -       if (res < 0)
> -               return res;
> +
> +       logind_cb_context_init(&ctxt);
> +       if (ctxt.res)
> +               return ctxt.res;
> +       g_slist_foreach(callbacks, call_cb, &ctxt);
> +       free((char *)ctxt.state);
> +       if (ctxt.res)
> +               return ctxt.res;
>
>         res =3D sd_login_monitor_get_timeout(monitor, &timeout_usec);
>         if (res < 0)
> @@ -154,6 +141,7 @@ static gboolean timeout_handler(gpointer user_data)
>
>  static int logind_init(void)
>  {
> +       struct logind_cb_context ctxt;
>         GIOChannel *channel;
>         int events;
>         int fd;
> @@ -174,11 +162,6 @@ static int logind_init(void)
>                 goto FAIL;
>         }
>
> -       // Check this after creating the monitor, in case of race conditi=
ons:
> -       res =3D update();
> -       if (res < 0)
> -               goto FAIL;
> -
>         events =3D res =3D sd_login_monitor_get_events(monitor);
>         if (res < 0)
>                 goto FAIL;
> @@ -202,7 +185,10 @@ static int logind_init(void)
>  FAIL:
>         sd_login_monitor_unref(monitor);
>         monitoring_enabled =3D FALSE;
> -       active =3D TRUE;
> +       ctxt.state =3D "active";
> +       ctxt.seats =3D 1;
> +       ctxt.res =3D 0;
> +       g_slist_foreach(callbacks, call_cb, &ctxt);
>         return res;
>  }
>
> @@ -219,17 +205,18 @@ static void logind_exit(void)
>         sd_login_monitor_unref(monitor);
>  }
>
> -static gint find_cb(gconstpointer a, gconstpointer b)
> +int logind_register(logind_cb cb)
>  {
> -       return ((struct callback_pair *)a)->init_cb - (logind_init_cb)b;
> -}
> +       struct logind_cb_context ctxt;
>
> -int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
> -{
> -       struct callback_pair *cbs;
> +       logind_cb_context_init(&ctxt);
> +       if (ctxt.res) {
> +               free((char *)ctxt.state);
> +               return ctxt.res;
> +       }
>
>         if (!monitoring_enabled)
> -               return init_cb(TRUE);
> +               goto CALL_CB;
>         if (callbacks =3D=3D NULL) {
>                 int res;
>
> @@ -237,24 +224,23 @@ int logind_register(logind_init_cb init_cb, logind_=
exit_cb exit_cb)
>                 if (res) {
>                         error("logind_init(): %s - login detection disabl=
ed",
>                                 strerror(-res));
> -                       return init_cb(TRUE);
> +                       goto CALL_CB;
>                 }
>         }
> -       cbs =3D g_new(struct callback_pair, 1);
> -       cbs->init_cb =3D init_cb;
> -       cbs->exit_cb =3D exit_cb;
> -       callbacks =3D g_slist_prepend(callbacks, cbs);
> -       return active ? init_cb(TRUE) : 0;
> +       callbacks =3D g_slist_prepend(callbacks, cb);
> +
> +CALL_CB:
> +       cb(&ctxt);
> +       free((char *)ctxt.state);
> +       return ctxt.res;
>  }
> -void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb)
> +void logind_unregister(logind_cb cb)
>  {
>         GSList *cb_node;
>
>         if (!monitoring_enabled)
> -               return exit_cb(TRUE);
> -       if (active)
> -               exit_cb(TRUE);
> -       cb_node =3D g_slist_find_custom(callbacks, init_cb, find_cb);
> +               return;
> +       cb_node =3D g_slist_find(callbacks, cb);
>         if (cb_node !=3D NULL)
>                 callbacks =3D g_slist_delete_link(callbacks, cb_node);
>         if (callbacks =3D=3D NULL)
> @@ -263,20 +249,26 @@ void logind_unregister(logind_init_cb init_cb, logi=
nd_exit_cb exit_cb)
>
>  int logind_set(gboolean enabled)
>  {
> -       int res =3D 0;
> -
> -       if (monitoring_enabled =3D=3D enabled)
> -               return 0;
> -
>         monitoring_enabled =3D enabled;
>         if (enabled) {
> -               active =3D FALSE;
> -               return update();
> +               struct logind_cb_context ctxt;
> +
> +               logind_cb_context_init(&ctxt);
> +               if (ctxt.res)
> +                       return ctxt.res;
> +               g_slist_foreach(callbacks, call_cb, &ctxt);
> +               free((char *)ctxt.state);
> +               return ctxt.res;
>         }
>
> -       active =3D TRUE;
> -       g_slist_foreach(callbacks, call_exit_cb, &res);
> -       return res;
> +       struct logind_cb_context ctxt =3D {
> +               .state =3D "active",
> +               .seats =3D 1,
> +               .res =3D 0
> +       };
> +
> +       g_slist_foreach(callbacks, call_cb, &ctxt);
> +       return ctxt.res;
>  }
>
>  #endif
> diff --git a/obexd/src/logind.h b/obexd/src/logind.h
> index 3cdb03338..243aa17bd 100644
> --- a/obexd/src/logind.h
> +++ b/obexd/src/logind.h
> @@ -8,30 +8,65 @@
>   *
>   */
>
> -typedef int (*logind_init_cb)(gboolean at_register);
> -typedef void (*logind_exit_cb)(gboolean at_unregister);
> +#ifndef OBEXD_SRC_LOGIND_H
> +#define OBEXD_SRC_LOGIND_H
> +
> +struct logind_cb_context {
> +       const char *state;
> +       int seats;
> +       int res;
> +};
> +
> +typedef void (*logind_cb)(gpointer ctxt);
>
>  #ifdef SYSTEMD
>
> -int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb);
> -void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_cb);
> +/*
> + * Register callback and call it with the current state
> + */
> +int logind_register(logind_cb init_cb);
> +/*
> + * Unregister callback but DO NOT call it -
> + * unregistration usually happens when the user is logging out,
> + * and other programs are going away.
> + *
> + * If possible, close resources at exit instead of at unregister.
> + * Otherwise, you will need to explicitly call your callback.
> + */
> +void logind_unregister(logind_cb cb);
> +/*
> + * Override the detected login state
> + */
>  int logind_set(gboolean enabled);
>
> -#else
> +/* Recommended way to detect (in)activity */
> +#define LOGIND_USER_IS_ACTIVE(ctxt) \
> +       (!g_strcmp0(ctxt->state, "active") && !!(ctxt->seats))
>
> -static inline int logind_register(logind_init_cb init_cb,
> -                                       logind_exit_cb exit_cb)
> +#else /* SYSTEMD */
> +
> +static inline int logind_register(logind_cb cb)
>  {
> -       return init_cb(TRUE);
> +       (void)cb;
> +       struct logind_cb_context ctxt =3D {
> +               .state =3D "active",
> +               .seats =3D 1,
> +               .res =3D 0
> +       };
> +       cb(&ctxt);
> +       return ctxt.res;
>  }
> -static inline void logind_unregister(logind_init_cb init_cb,
> -                                       logind_exit_cb exit_cb)
> +static inline void logind_unregister(logind_cb cb)
>  {
> -       return exit_cb(TRUE);
> +       (void)cb;
>  }
>  static inline int logind_set(gboolean enabled)
>  {
>         return 0;
>  }
>
> -#endif
> +#define LOGIND_USER_IS_ACTIVE(...) 1
> +
> +#endif /* SYSTEMD */
> +
> +#endif /* OBEXD_SRC_LOGIND_H */
> diff --git a/obexd/src/main.c b/obexd/src/main.c
> index 6837f0d73..116888a78 100644
> --- a/obexd/src/main.c
> +++ b/obexd/src/main.c
> @@ -34,6 +34,9 @@
>
>  #include "../client/manager.h"
>
> +#include "../client/driver.h"
> +#include "transport.h"
> +
>  #include "log.h"
>  #include "logind.h"
>  #include "obexd.h"
> @@ -279,6 +282,15 @@ int main(int argc, char *argv[])
>         if (option_system_bus)
>                 logind_set(FALSE);
>
> +       if (obc_driver_init() =3D=3D FALSE) {
> +               error("manager_init failed");
> +               exit(EXIT_FAILURE);
> +       }
> +       if (obex_transport_driver_init() =3D=3D FALSE) {
> +               error("manager_init failed");
> +               exit(EXIT_FAILURE);
> +       }
> +
>         DBG("Entering main loop");
>
>         main_loop =3D g_main_loop_new(NULL, FALSE);
> diff --git a/obexd/src/transport.c b/obexd/src/transport.c
> index 527d9ffce..fdd49b7a2 100644
> --- a/obexd/src/transport.c
> +++ b/obexd/src/transport.c
> @@ -79,3 +79,20 @@ obex_transport_driver_unregister(const struct obex_tra=
nsport_driver *driver)
>
>         drivers =3D g_slist_remove(drivers, driver);
>  }
> +
> +static void call_cb(gpointer data, gpointer ctxt)
> +{
> +       struct obex_transport_driver *driver =3D
> +               (struct obex_transport_driver *)data;
> +       if (driver->uid_state)
> +               driver->uid_state(((struct logind_cb_context *)ctxt));
> +}
> +
> +static int call_uid_state_cb(gpointer ctxt)
> +{
> +       g_slist_foreach(drivers, call_cb, ctxt);
> +}
> +
> +gboolean obex_transport_driver_init(void)
> +{
> +}
> diff --git a/obexd/src/transport.h b/obexd/src/transport.h
> index 322d8f526..087d8c211 100644
> --- a/obexd/src/transport.h
> +++ b/obexd/src/transport.h
> @@ -8,6 +8,9 @@
>   *
>   */
>
> +#include "obexd/src/logind.h"
> +struct obex_server;
> +
>  struct obex_transport_driver {
>         const char *name;
>         uint16_t service;
> @@ -15,9 +18,11 @@ struct obex_transport_driver {
>         int (*getpeername) (GIOChannel *io, char **name);
>         int (*getsockname) (GIOChannel *io, char **name);
>         void (*stop) (void *data);
> +       void (*uid_state) (struct logind_cb_context *ctxt);
>  };
>
>  int obex_transport_driver_register(const struct obex_transport_driver *d=
river);
>  void
>  obex_transport_driver_unregister(const struct obex_transport_driver *dri=
ver);
>  const GSList *obex_transport_driver_list(void);
> +gboolean obex_transport_driver_init(void);
> --
> 2.49.0
>


--=20
Luiz Augusto von Dentz
