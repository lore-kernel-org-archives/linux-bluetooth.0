Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PANU and "ACL tx timeout"
From: Marcel Holtmann <marcel@holtmann.org>
To: peter@legio.mine.nu
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1789.192.168.1.253.1080351984.squirrel@legio.mine.nu>
References: <1789.192.168.1.253.1080351984.squirrel@legio.mine.nu>
Content-Type: text/plain
Message-Id: <1080418966.2281.82.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 27 Mar 2004 21:22:46 +0100

Hi Peter,

> I am trying to set up a pan network between two usb dongles (belkin FT001
> and bluetake BT007SV). The belkin dongle is run as the network access
> point (NAP) and the bluetake dongle is run as a client. Connecting the two
> devices works just fine. Just browsing around an ftp works fine, the
> trouble is when i try to send/recive 'larger amounts' of data, eg files
> larger than 10k the connection hangs. (I have listed the output from
> /var/log/messages below.) Filetransfer with obex push works flawless. As a
> test i transfered a four megabyte file (with object push) back and fourth
> between the computers without trouble. Just to clearify, the problems
> occur on the computer running as NAP using the belkin FT001 dongle.

exchange the Broadcom based dongle with a CSR based dongle or try to get
a newer firmware for your adapter. It seems that nobody really got PAN
working very stable with a Broadcom adapter. Look at the mailing list
archive for previous posts about this topic.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
