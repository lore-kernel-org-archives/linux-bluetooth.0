Return-Path: <bluez-users-bounces@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Dick <dick@mrns.nl>
Date: Sat, 16 Jun 2007 18:31:52 +0000 (UTC)
Message-ID: <loom.20070616T202746-400@post.gmane.org>
References: <loom.20070613T200722-459@post.gmane.org>
	<1181979586.6846.62.camel@aeonflux.inter-touch.com>
Mime-Version: 1.0
Subject: Re: [Bluez-users] input service trouble
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

Marcel Holtmann <marcel <at> holtmann.org> writes:
> load the hci_usb driver with isoc=0. It seems that you USB host
> controller doesn't really like ISOC URBs.
Thanks, I've disabled isco and the messages are gone.

> > And the module usage count on hidp is high:
> > $ lsmod
> > Module                  Size  Used by
> > hidp                   10816  26 
> Check hcitool con and /sys/class/bluetooth/l2cap for open sockets.
I checked hcitool con and it showed me only the two devices. I can't understand
why hidp has a usage count of 26, usually this is only 2.


> We are at 2.6.22-rc4 and that is the official one with all patches.
> Worth trying that one.
I'll try that if the trouble persists

Again, thanks so far, I will inform you with the results.

greetings,
Dick


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
