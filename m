Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <448D6723.4050107@ibmt.fraunhofer.de>
References: <448D6723.4050107@ibmt.fraunhofer.de>
Date: Sat, 17 Jun 2006 12:42:41 +0200
Message-Id: <1150540961.17539.40.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problem connecting Bluetooth device
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

Hi Harald,

> I try to connect (unsuccessful) a Bluetooth Device (blood pressure unit)
> to read the data .
> (The connection with other devices was easy,
> Inquirys by the manufacturer are ineffective)
> 
> I doe the following steps:
> 
> doro:/home/harald # hcitool scan
> Scanning ...
>          00:11:B1:A2:01:C9       TaiDoc-BTM
> 
> then "hcitool info" (after sending the PIN):
> doro:/home/harald # hcitool info 00:11:B1:A2:01:C9
> Requesting information ...
>          BD Address:  00:11:B1:A2:01:C9
>          Device Name: TaiDoc-BTM
>          LMP Version: 1.1 (0x1) LMP Subversion: 0x2c2
>          Manufacturer: Cambridge Silicon Radio (10)
>          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>                  <3-slot packets> <5-slot packets> <encryption> <slot
> offset>
>                  <timing accuracy> <role switch> <hold mode> <sniff mode>
>                  <park state> <RSSI> <channel quality> <SCO link> <HV2
> packets>
>                  <HV3 packets> <u-law log> <A-law log> <CVSD> <paging
> scheme>
>                  <power control> <transparent SCO>
> 
> then:
> doro:/home/harald # rfcomm bind 0 00:11:B1:A2:01:C9 1
> 
> and change the rigths:
> doro:/home/harald # chmod 777 rfcomm0
> 
> If i try to connect the device:
> doro:/home/harald # rfcomm connect 0 00:11:B1:A2:01:C9 1
> Can't connect RFCOMM socket: Permission denied
> 
> and in a message box I get :
> ....Authentication Error!
> 
> hcidump give the following infoarmations (during the steps above), but
> I'm not able to interpret the output becouse I have
> no documentations how to interpret the output:

run it with "hcidump -X -V" as root.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
