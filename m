Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <a481fbf0706041011y702f79f1odfcfb1946254cfcb@mail.gmail.com>
Date: Mon, 4 Jun 2007 13:11:41 -0400
From: "Raymond Ingles" <sorceror171@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1180970663.13429.56.camel@violet>
MIME-Version: 1.0
References: <20070602184043.594698c5@topolino>
	<1180970663.13429.56.camel@violet>
Subject: Re: [Bluez-users] problems with network via bluetooth
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

On 6/4/07, Marcel Holtmann <marcel@holtmann.org> wrote:

> > if i run in the NB:  hcitool scan
> > correctly get:
> > 11:11:11:11:11:11   paperino-0
>
> this is not a valid MAC address. And PAN/Ethernet will fail with it.

 How does one change the MAC address with a USB bluetooth adapter? (I
understand that you can't change the actual value in the firmware, but
isn't there a way to modify it in software, the way many Ethernet
cards can?)

 I ask because I have a cheap Bluetooth adapter ("Integrated System
Solution Corp. KY-BT100 Bluetooth Adapter" according to lsusb) that
uses that MAC address, too. It works for talking to my Palm Treo, but
it'd be nice to be able to set it to a more conventional, legal value.

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
