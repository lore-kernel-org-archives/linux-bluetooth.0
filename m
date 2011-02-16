Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1297798306-32591-1-git-send-email-padovan@profusion.mobi>
References: <1297798306-32591-1-git-send-email-padovan@profusion.mobi>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Wed, 16 Feb 2011 13:28:43 +0100
Message-ID: <AANLkTi=DeXueKxyN23jT3LNd-iqD1mTO+PB-5H4=Scr+@mail.gmail.com>
Subject: Re: [PATCH] Move HealthManager Interface to "/" path
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

2011/2/15 Gustavo F. Padovan <padovan@profusion.mobi>:
> Yeah, this breaks the API, but health is still disabled by default and it
> is not a good idea create a new path only for it. So moving it to "/"

First I'd like to say that I completely agree with this patch, is
something that I've always thought, but when we sent this patches we
used  the other path because is what we agree when we designed the
API, I think that Marcel said something like that the path for
applications will be changed or something like that, but I is possible
that I misunderstood something. The end of this is that we register
HealthManager in path that I'm not completely agree with.

The problem is that the Health API is being alredy used in some
devices, HDP has been quickly integrated in health systems and I don't
know if changing the API now is a good idea. I've received many emails
asking for the API usage from people that was integrating BlueZ on
their systems in order to be able to use HDP.

Some of the devices that integrate BlueZ are also certified, like this:

http://continuaalliance.org/products/certified-products/texasinstrumentsamdm37xlinuxreferenceplatform.html

But it is possible that BlueZ with HDP is integrated in many other
devices and systems that we don't know. So even thinking that the path
change is a good Idea I disagree with this path because it breaks the
API and it's being already in use.

Regards

> ---
>  doc/health-api.txt    |    2 +-
>  health/hdp.c          |    4 ++--
>  test/test-health      |    2 +-
>  test/test-health-sink |    2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/doc/health-api.txt b/doc/health-api.txt
> index 3d0a717..9d5a54d 100644
> --- a/doc/health-api.txt
> +++ b/doc/health-api.txt
> @@ -10,7 +10,7 @@ Health Device Profile hierarchy
>
>  Service                org.bluez
>  Interface      org.bluez.HealthManager
> -Object path    /org/bluez/
> +Object path    /
>
>  Methods:
>
> diff --git a/health/hdp.c b/health/hdp.c
> index d4a2a30..e58bd55 100644
> --- a/health/hdp.c
> +++ b/health/hdp.c
> @@ -2171,7 +2171,7 @@ int hdp_manager_start(DBusConnection *conn)
>  {
>        DBG("Starting Health manager");
>
> -       if (!g_dbus_register_interface(conn, MANAGER_PATH,
> +       if (!g_dbus_register_interface(conn, "/",
>                                        HEALTH_MANAGER,
>                                        health_manager_methods, NULL, NULL,
>                                        NULL, manager_path_unregister)) {
> @@ -2186,7 +2186,7 @@ int hdp_manager_start(DBusConnection *conn)
>
>  void hdp_manager_stop()
>  {
> -       g_dbus_unregister_interface(connection, MANAGER_PATH, HEALTH_MANAGER);
> +       g_dbus_unregister_interface(connection, "/", HEALTH_MANAGER);
>
>        dbus_connection_unref(connection);
>        DBG("Stopped Health manager");
> diff --git a/test/test-health b/test/test-health
> index 28cc894..7820a24 100755
> --- a/test/test-health
> +++ b/test/test-health
> @@ -47,7 +47,7 @@ def enter_mainloop():
>        finally:
>                print "Exiting, bye"
>
> -hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
> +hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/"),
>                                                "org.bluez.HealthManager")
>
>  role = None
> diff --git a/test/test-health-sink b/test/test-health-sink
> index cb9d434..50eb74c 100755
> --- a/test/test-health-sink
> +++ b/test/test-health-sink
> @@ -12,7 +12,7 @@ loop = gobject.MainLoop()
>
>  bus = dbus.SystemBus()
>
> -hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/org/bluez"),
> +hdp_manager = dbus.Interface(bus.get_object("org.bluez", "/"),
>                                                "org.bluez.HealthManager")
>  app_path = hdp_manager.CreateApplication({"DataType": dbus.types.UInt16(4103),
>                                        "Role": "sink"})
> --
> 1.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
