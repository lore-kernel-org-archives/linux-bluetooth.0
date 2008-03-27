Return-Path: <cyrus@holtmann.org>
Message-ID: <47EBEB82.4050509@wurmsdobler.org>
Date: Thu, 27 Mar 2008 18:46:26 +0000
From: Peter Wurmsdobler <peter@wurmsdobler.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <47EBC8ED.1010301@wurmsdobler.org>
	<0FA03047-ABCC-476A-824D-BA5A2D1831FE@holtmann.org>
In-Reply-To: <0FA03047-ABCC-476A-824D-BA5A2D1831FE@holtmann.org>
Subject: Re: [Bluez-users] Could not find org.bluez interface
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello Marcel,

> might be, but I don't have enough information to tell you. Can you get  
> the full error message. Or test it with a simple Python script.
Unfortunately I cannot really provide that much information, as the 
single error message comes from QTopia. So it is not a bluez issue, but 
I hope to get some hints.

Digging into the Qtopia 4.3 code, I see that the private part of the 
constructor of QBluetoothLocalDeviceManager contains a new 
QDBusInterface with the parameters mentioned before. Adding some log 
messages reveals:

Bluetooth : new QDBusInterface("org.bluez", "/org/bluez", 
"org.bluez.Manager", dbc);

Bluetooth : QDBusAbstractInterfacePrivate::QDBusAbstractInterfacePrivate 
dynamic

Bluetooth : QDBusAbstractInterfacePrivate::QDBusAbstractInterfacePrivate 
service =  "org.bluez"

Bluetooth : QDBusConnectionPrivate::getNameOwner:  service = "org.bluez"

Bluetooth : QDBusConnectionPrivate::getNameOwner:  message = 
QDBusMessage(type=MethodCall, service="org.freedesktop.DBus", 
path="/org/freedesktop/DBus", interface="org.freedesktop.DBus", 
member="GetNameOwner", signature="", contents=(QString("org.bluez")) )

Bluetooth : QDBusAbstractInterfacePrivate::QDBusAbstractInterfacePrivate 
currentOwner isEmpty, error = 
"org.freedesktop.DBus.Error.NameHasNoOwner"
Could not find org.bluez interface

Maybe you have an idea what is going wrong, and I will continue to dig 
deeper.

Regards,
peter


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
