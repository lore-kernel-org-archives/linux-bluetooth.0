Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pairing on x86_64
From: Marcel Holtmann <marcel@holtmann.org>
To: Volker Fritzsch <kokor.hekkus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200402211648.16390.kokor.hekkus@gmx.de>
References: <200402211252.15735.kokor.hekkus@gmx.de>
	 <200402211508.47481.kokor.hekkus@gmx.de> <1077373108.2716.8.camel@pegasus>
	 <200402211648.16390.kokor.hekkus@gmx.de>
Content-Type: text/plain
Message-Id: <1077379873.2716.18.camel@pegasus>
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
Date: Sat, 21 Feb 2004 17:11:13 +0100

Hi Volker,

> so I had a deeper look into it myself.
> It seemed, as if the first four chars of buf get blanked after leaving 
> g_io_channel_read.

what is the sizeof(unsigned char) and sizeof(char) on x86_64?

> Feb 21 16:13:57 dionysos hcid[5088]: ** io_security_event
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[0]: 4
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[1]: 22
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[2]: 6
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[3]: 121
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[4]: -109
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[5]: 50
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[6]: -32
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[7]: 7
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf[8]: 0
> Feb 21 16:13:57 dionysos hcid[5088]: glib-ectomy * buf points to: -1073745232
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[0] = 0
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[1] = 0
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[2] = 0
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[3] = 0
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[4] = -109
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[5] = 50
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[6] = -32
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[7] = 7
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf[8] = 0
> Feb 21 16:13:57 dionysos hcid[5088]: security * buf points to -1073745232
> Feb 21 16:13:57 dionysos hcid[5088]: ** type not HCI_EVENT_PKT

I don't know why this happens.

> the appended patch does work for me - at least at this point,
> because now I get the following from hcidump:

We should use a static buffer and it should be unsigned char.

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
> < HCI Command: PIN Code Request Negative Reply(0x01|0x000e) plen 6
> > HCI Event: Command Complete(0x0e) plen 10

This can be a problem that the call of the PIN helper program fails.

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
