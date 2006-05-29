Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4469387E.5000203@bartol.udel.edu>
References: <4469387E.5000203@bartol.udel.edu>
Date: Mon, 29 May 2006 15:36:28 +0200
Message-Id: <1148909788.31689.66.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] SCO MTU problem on CSR-based Belkin F8T020/F8T007
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Rich,

> I've recently acquired a Belkin F8T020/F8T007 PCMCIA bluetooth interface 
> (basically, a compact flash card in an adapter sleeve), and I'm trying to get 
> this linked up to a Digiwave BH-2000 headset.
> 
> Mostly, everything is functioning correctly; the interface provides a UART on 
> /dev/ttyS3, which Bluez has no problem working with using the hci_uart driver. 
> The problem, however, comes in getting the ALSA module, snd_bt_sco, to behave 
> properly. I can get the headset to connect to my computer, and do things such as 
> change the volume; but I've had no luck in getting any sound to play on the headset.
> 
> After a little digging around, it turns out that no SCO packets are being 
> transmitted by the interface. Closer investigation shows that the problem is 
> with the outgoing MTU; the len value passed to sco_send_frame is invariably 
> longer than the default SCO MTU of the interface (64), with the result that 
> sco_send_frame aborts early with an EINVAL return value (which in turn is 
> silently ignored).
> 
> As a test fix, I upped the SCO MTU on the interface to 255, and now stuff 
> actually gets transmitted -- and I can hear sound on the headset, albeit very 
> distorted.
> 
> So, it seems snd_bt_sco is disregarding the MTU settings of the interface. Why, 
> I'm not sure; a quick look through the snd_bt_sco source code doesn't reveal 
> anything obvious (in fact, it's not clear how the module picks up the MTU). I'd 
> appreciate hearing suggestions about how I might go about fixing this.
> 
> For the record:
> 
> Kernel 2.6.16 (x86)
> 
> hciconfig -a (after upping MTU so TX works):
> 
> hci0:   Type: UART
>          BD Address: 00:02:72:81:23:27 ACL MTU: 192:8 SCO MTU: 255:8
>          UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>          RX bytes:5063515 acl:52 sco:30471 events:94 errors:0
>          TX bytes:4612824 acl:42 sco:0 commands:27604 errors:0
>          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: SLAVE ACCEPT
>          Name: 'BlueZ (0)'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
>          Manufacturer: Cambridge Silicon Radio (10)
> 
> hcitool info 00:13:8A:06:31:0E (the headset):
> 
> Requesting information ...
>          BD Address:  00:13:8A:06:31:0E
>          Device Name: BH2000
>          LMP Version: 1.2 (0x2) LMP Subversion: 0x611
>          Manufacturer: Cambridge Silicon Radio (10)
>          Features: 0xfc 0xfe 0x0f 0x00 0x08 0x08 0x00 0x00
>                  <encryption> <slot offset> <timing accuracy> <role switch>
>                  <hold mode> <sniff mode> <RSSI> <channel quality> <SCO link>
>                  <HV2 packets> <HV3 packets> <u-law log> <A-law log> <CVSD>
>                  <paging scheme> <power control> <transparent SCO>
>                  <AFH cap. slave> <AFH cap. master>
> 
> Big note: both devices are CSR, so this *ISN'T* the well-known MTU problem 
> experienced by Broadcom chipsets. Smaller note: although the hciconfig output is 
> after I upped the MTU and got (distorted) sound on the headset, the SCO TX count 
> is still at zero. Hmmmm....
> 
> Let me know if you need more info...

run "hciconfig hci0 revision" as root and see if the SCO mapping is done
over PCM or HCI.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
