Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Access Point elmeg D@VOS-44.dsl
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian <Kimpenhaus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr3xydd1hqdj9uv@mail.gmx.de>
References: <opr3xmdugiqdj9uv@mail.gmx.de>
	 <1077725935.2919.116.camel@pegasus>  <opr3xs5louqdj9uv@mail.gmx.de>
	 <1077734547.2919.147.camel@pegasus>  <opr3xydd1hqdj9uv@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1077740936.2884.2.camel@pegasus>
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
Date: Wed, 25 Feb 2004 21:28:56 +0100

Hi Florian,

> bash-2.05b# dund --nodetach --connect 00:0B:CE:00:01:8E  --msdun
> dund[3470]: DUN daemon ver 1.1
> dund[3470]: Searching for LAP on 00:0B:CE:00:01:8E
> dund[3470]: Failed to connect to the SDP server. Connection timed out(110)
> 
> bash-2.05b# hcidump
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection(0x01|0x0005) plen 13
> > HCI Event: Command Status(0x0f) plen 4
> > HCI Event: Connect Complete(0x03) plen 11
> 
> how do i start/configure the sdp server?

this is the SDP server on the AP, you don't have to start one. Run
hcidump with the -x option, so I can see the status codes.

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
