Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAx68NEbhABUCCBVz+cCM6sAEAAAAA@t-online.de>
References: 
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAx68NEbhABUCCBVz+cCM6sAEAAAAA@t-online.de>
Content-Type: text/plain
Message-Id: <1103107570.2143.189.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 15 Dec 2004 11:46:10 +0100

Hi Peter,

> ##>
> ##>this time the connection is refused, because of a security 
> ##>issue. I assume that the link key you send is wrong. Remove 
> ##>the link_key file from /etc/bluetooth/ and disable pand and 
> ##>dund settings in YaST and then restart your system. Then try 
> ##>"dund -n -c ...".
> ##>
> 
> When, at first, dund --search --persist was still active, I got immediately
> - after removing link_key file - a connection to the AP. Then I disabled the
> dund and pand settings in YaST.

and you may make sure that no pand or dund is running.

> Before I started, I removed again link_key file. Here are the results
> 
> Linux-Notebook:~ # dmabt
> Linux-Notebook:~ # hcitool scan
> Scanning ...
>         00:0B:CE:00:01:8F       Bluetooth-Modul
> Linux-Notebook:~ # dund -n -c 00:0B:CE:00:01:8F
> dund[6943]: Bluetooth DUN daemon
> dund[6943]: Searching for LAP on 00:0B:CE:00:01:8F
> dund[6943]: Failed to connect to the SDP server. Connection refused(111)
> Linux-Notebook:~ #
> 
> Linux-Notebook:~ # hcidump -x
> HCIDump - HCI packet analyzer ver 1.11
> device: hci0 snap_len: 1028 filter: 0xffffffff
> < HCI Command: Create Connection (0x01|0x0005) plen 13
>   8F 01 00 CE 0B 00 18 CC 01 00 AD FC 01
> > HCI Event: Command Status (0x0f) plen 4
>   00 01 05 04
> > HCI Event: Role Change (0x12) plen 8
>   00 8F 01 00 CE 0B 00 01
> > HCI Event: Connect Complete (0x03) plen 11
>   00 29 00 8F 01 00 CE 0B 00 01 00
> < ACL data: handle 0x0029 flags 0x02 dlen 12
>     L2CAP(s): Connect req: psm 1 scid 0x0040
> < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
>   29 00 0F 00
> > HCI Event: Command Complete (0x0e) plen 6
>   01 0D 08 00 29 00
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   01 29 00 01 00
> > HCI Event: Max Slots Change (0x1b) plen 3
>   29 00 05
> > HCI Event: Link Key Request (0x17) plen 6
>   8F 01 00 CE 0B 00
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
>   8F 01 00 CE 0B 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0C 04 00 8F 01 00 CE 0B 00
> > HCI Event: PIN Code Request (0x16) plen 6
>   8F 01 00 CE 0B 00
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
>   8F 01 00 CE 0B 00 07 36 31 33 31 32 39 31 00 00 00 00 00 00
>   00 00 00
> > HCI Event: Command Complete (0x0e) plen 10
>   01 0D 04 00 8F 01 00 CE 0B 00
> > HCI Event: Link Key Notification (0x18) plen 23
>   8F 01 00 CE 0B 00 5D 3C F6 8F 76 A6 EF 83 C6 68 B2 C4 0F FE
>   E2 C2 00
> > ACL data: handle 0x0029 flags 0x02 dlen 16
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 4 status 0

now the access to the SDP server of your AP is failing with no
ressources. This is weird. Try to run a "sdptool browse...".

> In the meantime I got a email from ELMEG the producer of the AP. They told
> me that the AP uses the LAP via DUN. So it must be possible to establish a
> connection to the AP and the router. If the connection is active, what have
> I to do to use it? In windows I have to initialize COM as kableconnection
> between two computers and to enable the usage of this COM by the
> BT-connection.

LAP and DUN are two different profiles. I don't get what you mean.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
