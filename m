Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Apple keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: Radu Maurer <a400@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040213105035.GA10464@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de>
	 <1076451979.2777.21.camel@pegasus> <20040211151146.GA19818@mail.gmx.de>
	 <1076515215.2696.36.camel@pegasus>  <20040213105035.GA10464@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1076669640.2671.27.camel@pegasus>
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
Date: Fri, 13 Feb 2004 11:54:00 +0100

Hi Radu,

> hcidump -w <file> seems to write a binary file. Do you nee that file? 
> Anyway, if I don't give the -w option, it dumps this to stdout:

yes.

> # hcidump
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection(0x01|0x0005) plen 13
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: PIN Code Request(0x16) plen 6
> > HCI Event: Connect Complete(0x03) plen 11

So it is a pairing problem. Check the keyboard manual how the pairing
procedure should work. Maybe it has a default PIN or you have to use the
num pad for input.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
