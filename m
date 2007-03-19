Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY135-F92F7BB3CB583DBE9AAD04B8710@phx.gbl>
References: <BAY135-F92F7BB3CB583DBE9AAD04B8710@phx.gbl>
Date: Mon, 19 Mar 2007 16:08:47 +0100
Message-Id: <1174316927.3690.13.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] dbus connection failed
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Vincent.

> I am trying to use the DBUS API in my pin exchange script.  I got a DBUS 
> connection error when I execute this line:
> 
>    DBusConnection *conn = dbus_bus_get(DBUS_BUS_SYSTEM, &err);
> 
> When I print out err.message, I got a bunch of non-printable character so I 
> could not quite figure out what the error is.
> 
> However, I took the same DBUS line and put in a stand-alone program and it 
> works fine.
> 
> In my /etc/dbus-1/system.d, there is bluetooh.conf which is identifcal to 
> the config that ships with Bluez.  I even explicitly include bluetooth.conf 
> in my /etc/dbus-1/system.conf file.
> 
> I tried Bluez-Utils 3.7 and 3.9 and with the same results.
> 
> Is there any special trick to connect to DBUS system bus from within Bluez?

take a look at the example code in bluez-utils. I think that
passkey-agent.c is the easiest one.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
