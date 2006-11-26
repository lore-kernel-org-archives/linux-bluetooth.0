Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45698AFA.4010704@avasthi.com>
Date: Sun, 26 Nov 2006 18:09:22 +0530
From: Vinay Avasthi <vinay@avasthi.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <1908cc540611240901l1524af9epeee7753ed00b332d@mail.gmail.com>
	<1164536111.25914.9.camel@aeonflux.holtmann.net>
In-Reply-To: <1164536111.25914.9.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] Bluetooth device is not being
	discovered	from	Mobile
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Marcel Holtmann wrote:
> Hi Vinay,
> 
>> I have a linux desktop with a bluetooth dongle. The hciconfig dump is
>> as follows. This desktop does not show up if I run discovery from a
>> mobile phone.  The desktop is visible from a windows XP laptop. Can
>> somebody point me to a direction of error. 
>>
>> The hciconfig looks like this.
>>
>> hci0:   Type: USB
>>         BD Address: 00:0D:18:01:11:8D ACL MTU: 192:8 SCO MTU: 64:8
>>         UP RUNNING PSCAN ISCAN
>>         RX bytes:3783 acl:0 sco:0 events:153 errors:0 
>>         TX bytes:2778 acl:0 sco:0 commands:131 errors:0
>>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>         Link policy: RSWITCH HOLD SNIFF PARK 
>>         Link mode: SLAVE ACCEPT
>>         Name: 'avasthidesktop'
>>         Class: 0x120104
>>         Service Classes: Networking, Object Transfer
>>         Device Class: Computer, Desktop workstation
>>         HCI Ver: 1.1 (0x1) HCI Rev: 0x14c LMP Ver: 1.1 (0x1) LMP
>> Subver: 0x14c
>>         Manufacturer: Cambridge Silicon Radio (10)
> 
> depends on for what devices you phone is looking. Maybe it is only
> looking for headset and your devices says it is a computer. What kind of
> phone are you using?
> 

I have tried it with a a Motorola EzX phone that can do obex. I have 
also tried it with an unlocked Razr.

BR..

VA

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
