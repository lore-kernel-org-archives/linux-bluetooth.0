Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Access Point elmeg D@VOS-44.dsl
From: Marcel Holtmann <marcel@holtmann.org>
To: Florian <Kimpenhaus@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <opr3yb4dsoqdj9uv@mail.gmx.de>
References: <opr3xmdugiqdj9uv@mail.gmx.de>
	 <1077725935.2919.116.camel@pegasus>  <opr3xs5louqdj9uv@mail.gmx.de>
	 <1077734547.2919.147.camel@pegasus>  <opr3xydd1hqdj9uv@mail.gmx.de>
	 <1077740936.2884.2.camel@pegasus>  <opr3x23lc1qdj9uv@mail.gmx.de>
	 <1077747171.2884.5.camel@pegasus>  <opr3x77rphqdj9uv@mail.gmx.de>
	 <1077753099.2754.1.camel@pegasus>  <opr3x8uqadqdj9uv@mail.gmx.de>
	 <1077757118.2754.4.camel@pegasus>  <opr3yb4dsoqdj9uv@mail.gmx.de>
Content-Type: text/plain
Message-Id: <1077758327.2754.9.camel@pegasus>
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
Date: Thu, 26 Feb 2004 02:18:47 +0100

Hi Florian,

> I tried the command You gave me some mails ago
> 
> bash-2.05b# dund --nodetach --connect 00:0B:CE:00:01:8E --msdun
> dund[8116]: DUN daemon ver 1.1
> dund[8116]: Searching for LAP on 00:0B:CE:00:01:8E
> dund[8116]: Failed to connect to the SDP server. Function not 
> implemented(38)
> 
> This is all I get :(
> 
> 
> bash-2.05b# hcidump -x
> HCIDump - HCI packet analyzer ver 1.5
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection(0x01|0x0005) plen 13
>    8E 01 00 CE 0B 00 18 CC 02 00 00 00 00
> > HCI Event: Command Status(0x0f) plen 4
>    00 01 05 04
> > HCI Event: Connect Complete(0x03) plen 11
>    21 06 00 8E 01 00 CE 0B 00 01 00

it's again the role switch problem, but what I overlooked is that you
set your link mode to accept and master. Don't do this. Change it back
to accept and slave

        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 

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
