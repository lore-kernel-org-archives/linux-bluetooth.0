Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] DBUS service support - Initial library
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb05042905267bc91413@mail.gmail.com>
References: <e1effdeb05042813004f4609a6@mail.gmail.com>
	 <1114768038.8836.42.camel@pegasus>
	 <e1effdeb05042905267bc91413@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1114778617.8836.88.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Apr 2005 14:43:37 +0200

Hi Claudio,

> Let me try justify why I need a new library.
> 1. A DBUS app should not contain specific bluetooth/Wi-Fi/GPRS connection code.
>     In my opinion, it is better abstract the connection details.
> 2. Features required by DBUS app: signal strength, connection establishment, 
>     disconnection, new device notification(search for service
> frequently), automatic
>     IP assigment(with IP conflict resolution and IP announment),
> device information,
>     active connections, security info, connection lost, ...
>     All these features should be provided by a BlueZ library. At the
> moment, pand
>     and hcitool provide part of these. However, they are command line
> application
>     and a DBUS app should use a workaround approach:  "execv" function
> 3. Consider an embedded device, control connections using a DBUS app 
>     is the better way to this task. Execute a command line app is not
> appropriated
>     to handle this context. An embedded app using  wireless connection
>     should abstract connection establishment/control details.
> 
> This is the scenario that I am working on, if I can't contribute
> developing this library,
> I will try move all these required features to DBUS app level without
> add functions/library
> to BlueZ.

think about adding all you need to pand and then start it for example
with a --dbus option to activate that service via D-Bus.

When writing code use the BlueZ coding style. This means, use tabs. For
the patches, create them with "cvs diff -u" from the BlueZ CVS and make
sure that you executed "make maintainer-clean" first.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
