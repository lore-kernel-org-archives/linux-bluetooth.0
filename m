Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1442565357-2552-1-git-send-email-jpawlowski@google.com>
References: <1442565357-2552-1-git-send-email-jpawlowski@google.com>
Date: Sat, 19 Sep 2015 14:32:38 +0300
Message-ID: <CABBYNZ+f1wY+QWTChfHgJ7ShZ2nrkwR=ZQUb5ixSrkb5CeDHHw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] gdbus: add method for immediate property update
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Sep 18, 2015 at 11:35 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> g_dbus_emit_property_changed doesn't send dbus signal immediately. Instead
> it stores changed properties, and schedule signal to be send at
> g_iddle_add. Additionally, if this method is called few times for some
> property, only last value will be sent in property changed signal.
>
> If remote device sends lots of notifications, they're all scheduled to be
> notified using this method. This might result in some notifications being
> lost.
>
> This patch adds new method, that can immediately send property changed
> signal, instead of sheduling it for nearest iddle moment.
> ---
>  gdbus/gdbus.h  | 10 ++++++++++
>  gdbus/object.c | 16 +++++++++++++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index d99c254..74de661 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -35,6 +35,7 @@ typedef enum GDBusMethodFlags GDBusMethodFlags;
>  typedef enum GDBusSignalFlags GDBusSignalFlags;
>  typedef enum GDBusPropertyFlags GDBusPropertyFlags;
>  typedef enum GDBusSecurityFlags GDBusSecurityFlags;
> +typedef enum GDbusPropertyChangedFlags GDbusPropertyChangedFlags;
>
>  typedef struct GDBusArgInfo GDBusArgInfo;
>  typedef struct GDBusMethodTable GDBusMethodTable;
> @@ -115,6 +116,11 @@ enum GDBusSecurityFlags {
>         G_DBUS_SECURITY_FLAG_ALLOW_INTERACTION = (1 << 2),
>  };
>
> +enum GDbusPropertyChangedFlags {
> +       G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH = (1 << 0),
> +};
> +
> +
>  struct GDBusArgInfo {
>         const char *name;
>         const char *signature;
> @@ -300,6 +306,10 @@ void g_dbus_pending_property_error(GDBusPendingReply id, const char *name,
>  void g_dbus_emit_property_changed(DBusConnection *connection,
>                                 const char *path, const char *interface,
>                                 const char *name);
> +void g_dbus_emit_property_changed_full(DBusConnection *connection,
> +                               const char *path, const char *interface,
> +                               const char *name,
> +                               GDbusPropertyChangedFlags flags);
>  gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
>                                 const char *interface, DBusMessageIter *iter);
>
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 96db516..4cf2e2f 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -1720,9 +1720,10 @@ static void process_property_changes(struct generic_data *data)
>         }
>  }
>
> -void g_dbus_emit_property_changed(DBusConnection *connection,
> +void g_dbus_emit_property_changed_full(DBusConnection *connection,
>                                 const char *path, const char *interface,
> -                               const char *name)
> +                               const char *name,
> +                               GDbusPropertyChangedFlags flags)
>  {
>         const GDBusPropertyTable *property;
>         struct generic_data *data;
> @@ -1760,7 +1761,16 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
>         iface->pending_prop = g_slist_prepend(iface->pending_prop,
>                                                 (void *) property);
>
> -       add_pending(data);
> +       if (flags & G_DBUS_PROPERTY_CHANGED_FLAG_FLUSH)
> +               process_property_changes(data);
> +       else
> +               add_pending(data);
> +}
> +
> +void g_dbus_emit_property_changed(DBusConnection *connection, const char *path,
> +                               const char *interface, const char *name)
> +{
> +       g_dbus_emit_property_changed_full(connection, path, interface, name, 0);
>  }
>
>  gboolean g_dbus_get_properties(DBusConnection *connection, const char *path,
> --
> 2.5.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
