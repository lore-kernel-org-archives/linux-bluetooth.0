Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing on x86_64
From: Marcel Holtmann <marcel@holtmann.org>
To: Volker Fritzsch <kokor.hekkus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402211252.15735.kokor.hekkus@gmx.de>
References: <200402211252.15735.kokor.hekkus@gmx.de>
Content-Type: text/plain
Message-Id: <1077365351.2716.2.camel@pegasus>
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
Date: Sat, 21 Feb 2004 13:09:11 +0100

Hi Volker,

> I've got an athlon64, a pda and a bluetooth usb dongle.
> Pairing under debian unstable (32bit) works fine,
> but under suse 9.0 (amd64) or the debian pure64 port it doesn't work.
> 
> I've tried selfcompiled kernels (2.4's up to 2.6.3), suse's kernels;
> i've tried selfcompiled bluez libraries (and utils) as well as those shipped 
> with the above mentioned distributions.
> 
> When working in 64bit mode, pairing always seems to 'time out'.
> 
> hcidump:
> 
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
> > HCI Event: Connect Request(0x04) plen 10
> < HCI Command: Accept Connection Request(0x01|0x0009) plen 7
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connect Complete(0x03) plen 11
> < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
> > HCI Event: Page Scan Repetition Mode Change(0x20) plen 7
> > HCI Event: Max Slots Change(0x1b) plen 3
> > HCI Event: Command Complete(0x0e) plen 6
> < HCI Command: Change Connection Packet Type(0x01|0x000f) plen 4
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connection Packet Type Changed(0x1d) plen 5
> > HCI Event: PIN Code Request(0x16) plen 6
> 
> and that's where it stops - and some time after that my pda aborts the 
> connection.

what does your syslog say? Put some syslog() debugging messages in
utils/hcid/security.c to see where it stops.

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
