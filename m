Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_uart and Ambicom BT2000E
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Jimenez <djimenez@pobox.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40743AAE.4070808@pobox.com>
References: <40743AAE.4070808@pobox.com>
Content-Type: text/plain
Message-Id: <1081418373.2970.6.camel@pegasus>
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
Date: Thu, 08 Apr 2004 11:59:33 +0200

Hi Daniel,

> In a previous thread Marcell recommended I use serial_cs and hci_uart 
> for my Ambicom PCMCIA bluetooth adaptor.
> 
> I've got serial_cs working, and it's created device /dev/ttyS1.
> 
> I did a hciattach /dev/ttyS1 ericsson and that returned no errors/notices.
> 
> hciconfig hci0 up hangs and does nothing. I can control+c out of it.
> 
> I do notice this in /var/log/messages:
> 
> hcid[6522]: HCI dev 0 registered
> hcid[6437]: HCI dev 0 registered
> hcid[6295]: HCI dev 0 registered
> hcid[7097]: Can't init device hci0. Connection timed out(110)
> hcid[7098]: Can't init device hci0. Connection timed out(110)
> hcid[7099]: Can't init device hci0. Connection timed out(110)

you should check how many hcid you have running. There must only be one.

The other problem is that not every serial based PCMCIA card works right
now with the 2.6 kernel. Some do and some don't and actually this is a
problem in the serial subsystem, but I don't know where.

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
