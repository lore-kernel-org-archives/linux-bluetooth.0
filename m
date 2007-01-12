Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 12 Jan 2007 16:25:10 +0100
From: Stefan Seyfried <seife@suse.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20070112152510.GB18535@suse.de>
References: <200701081837.04388.dgollub@suse.de>
	<20070108184701.GA12689@jh-mbp>
	<200701090041.54299.dgollub@suse.de>
MIME-Version: 1.0
In-Reply-To: <200701090041.54299.dgollub@suse.de>
Subject: Re: [Bluez-devel] Should hcid wait for dbus daemon?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Ping! :-)

Any opinions on that approach? This fixes the hotplug issue for our users,
but i want to stay as close to upstream as possible :-)

On Tue, Jan 09, 2007 at 12:41:53AM +0100, Daniel Gollub wrote:
> On Monday 08 January 2007 19:47, Johan Hedberg wrote:
> > Sounds like a useful feature. It should be quite simple to implement too
> > since most of the required code already exists due to the dbus restart
> > detection support. Feel free to provide a patch for it :)
> How often should the daemons try to connect? Or infinitely?
> If not infinitely, then configurable by command line parameter or fixed?
> =

> Attachted is a _simple_ proof of concept patch which . It retries every 5 =

> seconds. After #12 unsuccessfully dbus connect, it gives up and abort (as =

> before).
> =

> Daniel

> Index: common/dbus.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/bluez/utils/common/dbus.c,v
> retrieving revision 1.2
> diff -u -p -r1.2 dbus.c
> --- common/dbus.c	13 Nov 2006 07:58:40 -0000	1.2
> +++ common/dbus.c	8 Jan 2007 22:52:18 -0000
> @@ -39,6 +39,7 @@
>  #include "list.h"
>  =

>  #define DISPATCH_TIMEOUT	0
> +#define MAX_DBUS_RETRY		12
>  =

>  static int name_listener_initialized =3D 0;
>  =

> @@ -485,13 +486,27 @@ static void dispatch_status_cb(DBusConne
>  =

>  DBusConnection *init_dbus(const char *name, void (*disconnect_cb)(void *=
), void *user_data)
>  {
> +	int retry =3D 0;
>  	struct disconnect_data *dc_data;
>  	DBusConnection *conn;
>  	DBusError err;
>  =

>  	dbus_error_init(&err);
>  =

> -	conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, &err);
> +	do {
> +		if (dbus_error_is_set(&err))
> +			dbus_error_free(&err);
> +
> +		conn =3D dbus_bus_get(DBUS_BUS_SYSTEM, &err);
> +		if (conn)
> +			break;
> +
> +		if (!retry)
> +			info("Can't connect to DBUS. Will retry %i times.", MAX_DBUS_RETRY);
> +
> +		usleep(5000000);

here, a
		sleep(5);
might be easier to read :-)

> +		retry++;
> +	} while (!conn && retry < MAX_DBUS_RETRY);
>  =

>  	if (dbus_error_is_set(&err)) {
>  		error("Can't connect to system message bus: %s", err.message);
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
