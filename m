Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Vlad <vkorolev@nist.gov>
Message-ID: <loom.20040820T185934-862@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] Disconnections are not being detected.
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 20 Aug 2004 18:47:30 +0000 (UTC)

Greetings,

    I have been struggling with this problem for about a month. However being 
busy with the other projects I did have much time to look closer at this issue
until now.  

    So here is a brief description of the problem: When the client tries to 
make an L2CAP connection to some PSM on the device that doesn't have the server
listen at that PSM, the connection just hangs for a long time (41 sec) and then
eventually times out. Here is a typical log made by 'hcidump', in this case the
server device is a mobile phone  (SonyEriccson T600)  and the client device
is a laptop with D-Link bluetooth dongle (DBT-120). 



1093025240.204350 < HCI Command: Create Connection(0x01|0x0005) plen 13
  4F 7A 7D D9 0A 00 18 CC 01 00 00 00 01 
1093025240.210396 > HCI Event: Command Status(0x0f) plen 4
  00 01 05 04 
1093025241.282201 > HCI Event: Connect Complete(0x03) plen 11
  00 06 00 4F 7A 7D D9 0A 00 01 00 
1093025241.283640 < ACL data: handle 0x0006 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 12 scid 0x0040
1093025241.283651 < HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
  06 00 0E 00 
1093025241.287198 > HCI Event: Command Complete(0x0e) plen 6
  01 0D 08 00 06 00 
1093025241.297197 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 06 00 01 00 
1093025241.319200 > ACL data: handle 0x0006 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0000 result 2 status 0
1093025241.320195 < ACL data: handle 0x0006 flags 0x02 dlen 10
    L2CAP(s): Command rej: reason 0
1093025241.332192 > HCI Event: Number of Completed Packets(0x13) plen 5
  01 06 00 01 00 
1093025282.204263 < HCI Command: Disconnect(0x01|0x0006) plen 3
  06 00 13 
1093025282.207737 > HCI Event: Command Status(0x0f) plen 4
  00 01 06 04 
1093025282.285722 > HCI Event: Disconn Complete(0x05) plen 4
  00 06 00 16 



as you see from the log the server device does send back a 'reject' response
but the client device that is running BlueZ stack ignores that response. I
have seen same behavior with the other devices as well ( iPAQs running
familiar linux and PocketPC,  other cell-phones). In all cases the
client device was always a some version of linux with BlueZ.  

Anybody has any clue how to fix this problem or seen similar behavior?

                                                  Vlad


Here is what kernel says about the BlueZ version:

BlueZ Core ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ L2CAP ver 2.3 Copyright (C) 2000,2001 Qualcomm Inc
Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
BlueZ RFCOMM ver 1.1
Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>


And the client device configuration:


hci0:   Type: USB
        BD Address: 00:80:C8:62:F4:C2 ACL MTU: 377:10  SCO MTU: 16:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:775 acl:0 sco:0 events:41 errors:0
        TX bytes:333 acl:0 sco:0 commands:15 errors:0








     




    
 
     



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
