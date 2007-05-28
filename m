Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Daniel Gollub <dgollub@suse.de>
To: bluez-devel@lists.sourceforge.net
Date: Mon, 28 May 2007 18:48:09 +0200
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<200705280119.47962.dgollub@suse.de>
	<200705280939.31695.denis.kenzior@trolltech.com>
In-Reply-To: <200705280939.31695.denis.kenzior@trolltech.com>
MIME-Version: 1.0
Message-Id: <200705281848.09618.dgollub@suse.de>
Subject: Re: [Bluez-devel] Suggesting bluez_pinhelper
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Monday 28 May 2007 01:39:31 Denis KENZIOR wrote:
> As part of our work on Qtopia we've wrapped the BlueZ DBUS interface and
> some of the Bluetooth socket types in a nice Qt way. =A0We've also done s=
ome
> work on OBEX support in Qtopia 4.2, with much nicer API in Qtopia 4.3.
>
> Check out http://doc.trolltech.com/qtopia4.2/qtopiabluetooth.html. =A0If
> there are some things which can be used by KDE (beats duplicating effort),
> I can work on separating the Bluetooth classes as a separate Solutions
> package or something. =A0Same goes for OBEX support.

Sounds very interesting! =


I have to take a deeper look on the implementation of the BlueZ DBUS =

interface... is there any plan to wrap also BlueZ Service APIs like the Inp=
ut =

Service? Or is this already done?

Or you going to implement the Authorization Agent as well?

Actually i plan to implement all the services which are available by BlueZ =
... =

So it would be very interesting which BlueZ services get implemented/used b=
y =

Qtopia. Or should it be possible to make use of all services via =

QBluetoothAbstractService?

On which version of BlueZ will be Qtopia 4.3 based? bluez-utils 3.9 like =

Qtopia 4.2?

Are you going to keep the OBEX support or make use of the BlueZ transfer =

service in the future?

A separated package would be great...

best regards,
Daniel

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
