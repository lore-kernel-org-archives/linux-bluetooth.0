Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41ECD643.6060101@cc.hut.fi>
From: Heikki Vuolteenaho <hvuoltee@cc.hut.fi>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Receiving multiple (>2) incoming rfcomm connections?
References: <41EB8C5C.2090708@cc.hut.fi> <1105960994.8080.32.camel@pegasus>
In-Reply-To: <1105960994.8080.32.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 18 Jan 2005 11:26:27 +0200

Marcel Holtmann wrote:
> 
> your device must become master of the piconet and the phones should
> support the role switch.
> 

You mean the USB BT device should take master role? Any pointers on how 
this is done? Or some good documents, I guess I'll have to study a bit 
more on this...


> 
>>-Conceptronic USB BT (CSR)
> 
> 
> What does "hciconfig -a" say?
> 

hci0:
Type: USB
BD Address: 00:80:5A:30:0C:C6 ACL MTU: 192:8  SCO MTU: 64:8
UP RUNNING PSCAN ISCAN
RX bytes:59492 acl:1641 sco:0 events:2235 errors:0
TX bytes:21545 acl:1193 sco:0 commands:432 errors:0
Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: SLAVE ACCEPT
Name: 'lp007-0'
Class: 0x000100
Service Classes: Unspecified
Device Class: Computer, Uncategorized
HCI Ver: 1.1 (0x1) HCI Rev: 0x460 LMP Ver: 1.1 (0x1) LMP Subver: 0x460
Manufacturer: Cambridge Silicon Radio (10)



> 
>>-Various Nokia phones (6630, 6600, Ngage, 3650)
> 
> 
> Check "hcitool info ..." for these phones.
> 

BD Address:  00:60:57:3B:E0:52
Device Name: Nokia 3650
LMP Version: 1.1 (0x1) LMP Subversion: 0x23c
Manufacturer: Nokia Mobile Phones (1)
Features: 0xbf 0x28 0x21 0x00 0x00 0x00 0x00 0x00
           <3-slot packets> <5-slot packets> <encryption> <slot offset>
           <timing accuracy> <role switch> <sniff mode> <SCO link>
           <HV3 packets> <CVSD>


BD Address:  00:11:9F:BD:9B:2E
Device Name: Nokia 6630
LMP Version: 1.2 (0x2) LMP Subversion: 0x4db
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xbf 0xfe 0x0f 0x00 0x18 0x18 0x00 0x00
           <3-slot packets> <5-slot packets> <encryption> <slot offset>
           <timing accuracy> <role switch> <sniff mode> <RSSI>
           <channel quality> <SCO link> <HV2 packets> <HV3 packets>
           <u-law log> <A-law log> <CVSD> <paging scheme> <power control>
           <transparent SCO> <AFH cap. slave> <AFH class. slave>
           <AFH cap. master> <AFH class. master>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
