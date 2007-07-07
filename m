Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sun, 8 Jul 2007 00:09:09 +0200
From: Radek (Fotopiper) <fotopiper@o2.pl>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070708000909.7be17b99@localhost>
In-Reply-To: <1183622873.6351.79.camel@aeonflux.holtmann.net>
References: <20070704155527.63ef9dfa@localhost>
	<1183622873.6351.79.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Device class in hcid.conf - Problems setting the
 correct description of the device.
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

On Thu, 05 Jul 2007 10:07:53 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> > 	I've set the class for my Linux devices a while back (a year or two
> > back), but then the list was easily available. Still the operation wasn't
> > fast - the specs describe the class bit by bit... which a bit differs form
> > the way hcid.conf require it to be put.
> > 	Did somebody found a easy way to set up the device class?
> 
> you can use the D-Bus interface. Especially the SetMinorClass() method.

Thank you very much! :)
I'm starting to appreciate Bluez migration to dbus.

For those who are less eager to learn the dbus ;)

$ dbus-send --system --print-reply --dest=org.bluez /org/bluez/hci0
org.bluez.Adapter.SetMinorClass string:"laptop"

hciconfig hci0 class

and input the class into hcid.conf

Or stick with d-bus interface.

My best regards.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
