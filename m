Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Denis KENZIOR <denis.kenzior@trolltech.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Tue, 29 May 2007 07:11:56 +1000
References: <1180273950.15368.42.camel@gilboa-work-dev.localdomain>
	<200705280939.31695.denis.kenzior@trolltech.com>
	<200705281848.09618.dgollub@suse.de>
In-Reply-To: <200705281848.09618.dgollub@suse.de>
MIME-Version: 1.0
Message-Id: <200705290711.56349.denis.kenzior@trolltech.com>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Daniel,

What are your plans with kdebluetooth?  Are you going to make KDE3 based 
releases or wait until KDE4?  I'm asking since Qtopia Bluetooth is Qt4 based 
and uses Qt DBUS bindings internally to communicate with BlueZ.

> I have to take a deeper look on the implementation of the BlueZ DBUS
> interface... is there any plan to wrap also BlueZ Service APIs like the
> Input Service? Or is this already done?
>

Yes, we're planning Input service for 4.4 and PAN for 4.4.   Actually services 
are probably the least useable by KDE the way they are now.  Mostly because 
we use our own IPC mechanisms, they could probably be easily adapted to any 
IPC mechanism though. 

> Or you going to implement the Authorization Agent as well?

Yes, this only went non-experimental as of 3.10.1, so we're probably going to 
add this in 4.4.

>
> Actually i plan to implement all the services which are available by BlueZ
> ... So it would be very interesting which BlueZ services get
> implemented/used by Qtopia. Or should it be possible to make use of all
> services via
> QBluetoothAbstractService?

The QBluetoothAbstractService is more of a framework class, to help build 
service implementation and insure certain features are supported (starting / 
stopping services mostly)  To use a service you still need to use an 
interface class, very similar to BlueZ.  

>
> On which version of BlueZ will be Qtopia 4.3 based? bluez-utils 3.9 like
> Qtopia 4.2?

This is the most likely case.

>
> Are you going to keep the OBEX support or make use of the BlueZ transfer
> service in the future?

OBEX support in 4.2 is not that great, we improved it considerably in 4.3. It 
wraps OpenOBEX, but makes it very easy to use.  We're planning to implement 
FTP, PUSH, BPP and BIP profiles over OBEX using this infrastructure.  Some 
(PUSH client/server, FTP client) are already done.

>
> A separated package would be great...

OK will try prioritize this :)

Regards,
-Denis

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
