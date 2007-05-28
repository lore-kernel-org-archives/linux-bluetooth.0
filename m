Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20070528015018.GA30960@localdomain>
References: <20070528015018.GA30960@localdomain>
Date: Mon, 28 May 2007 10:34:16 +0200
Message-Id: <1180341256.21432.94.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] MS Mouse + Internal Dell adaptor
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

Hi Cameron,

> I have a Dell Inspiron 8500 running Ubuntu Feisty which has an internal
> bluetooth adaptor. This adaptor is a v1.1 adaptor.
> 
> Some time ago, I purchased a MS bluetooth mouse (Microsoft IntelliMouse
> Explorer for Bluetooth) and I had no luck getting it working with the
> internal bluetooth adaptor. Since then, I've used the supplied dongle
> and accepted that the mouse would not work (a v1.2 mouse) with the
> internal adaptor.
> 
> Just now, I experimented again, and it still does not work. By "not
> work" I mean that I can scan it (hcitool scan), connect to it 
> (hidd --connect / --search), but the movement is very jerky and delayed.
> i.e. there would be at least a three second lag and the mouse pointer
> will jump from one end of the screen to the other.
> 
> However, I just noticed that while I am running a scan or inquiry
> (hcitool scan / inq), the mouse works properly! When the scan finishes,
> it goes back to being jerky / laggy.
> 
> Does this symptom ring any bells with anyone here? And any ideas how to
> make the mouse work permanently with the internal adaptor?

the Ubuntu kernel has automatic sniff mode on by default. You might
wanna switch that off via /sys/class/bluetooth/hci0/idle_timeout. Simply
echo 0 into that file.

Some Bluetooth 1.1 chips behave strange with the Bluetooth HID devices
and their usage of sniff mode. I have seen that before. You might also
check with Dell if you can get a firmware update for your adapter.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
