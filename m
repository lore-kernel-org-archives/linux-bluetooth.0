Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BT-1.2 spec device
References: <2de46576050103071248159461@mail.gmail.com> <1104776590.8894.57.camel@pegasus>
In-Reply-To: <1104776590.8894.57.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200501032137.22606.cijoml@volny.cz>
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
Date: Mon, 3 Jan 2005 21:37:22 +0100

Dne po 3. ledna 2005 19:23 Marcel Holtmann napsal(a):
> Hi Manjunath,
>
> > I am looking at a BT dongle with Adaptive Frequency Hopping and power
> > control. I think I will find both these features in a Class-1 ,1.2
> > spec device.
>
> you can update the D-Link DBT-120 Rev. B3.

is B2 firmware supported too? Apple garantee it, but tried it anybody? My 
friend want me to flash it for him, but I worry about destroying dongle.

>
> > I am looking at another feature, that is the device should be able to
> > read the piconet clock. i found that DBT-120 did not have this
> > feature. But DBT seemed to give a better LQ value. So i am a little
> > unsure about which product to purchase.
>
> As far as I know it has support for it after you flashed a HCI 18.x
> firmware into it.
>
> > can you tell me which BT product with 1.2 spec with the above features
> > i can purchase??Will the BT products with EDR hit the market soon..
>
> The number of Bluetooth 1.2 dongles is quite limited. However you can
> flash the D-Link with the Apple firmware or get a Anycom based on a
> Silicon Wave. These are the only ones I know of. I expect the first EDR
> dongles very soon, but actually this depends on how fast CSR can deliver
> its BlueCore4 in large quantities.

Other one is inluded to Genius Bluetooth Traveler. You still didn't it on your 
list, Marcel...

hci1:   Type: USB
        BD Address: 00:C0:DF:6C:02:E2 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:226 acl:0 sco:0 events:20 errors:0
        TX bytes:413 acl:0 sco:0 commands:19 errors:0
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'Linux (notas)'
        Class: 0x100100
        Service Classes:
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x54a LMP Ver: 1.2 (0x2) LMP Subver: 0x54a
        Manufacturer: Cambridge Silicon Radio (10)

hci1:   Type: USB
        BD Address: 00:C0:DF:6C:02:E2 ACL MTU: 192:8  SCO MTU: 64:8
        Build 1354
        Chip version: BlueCore02
        Max key size: 56 bit
        SCO mapping:  HCI

hci1:   Type: USB
        BD Address: 00:C0:DF:6C:02:E2 ACL MTU: 192:8  SCO MTU: 64:8
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                <AFH cap. master> <AFH class. master> <extended features>


M.

>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by: Beat the post-holiday blues
> Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
