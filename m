Return-Path: <cyrus@holtmann.org>
Message-ID: <482FF471.6070708@powercraft.nl>
Date: Sun, 18 May 2008 11:18:41 +0200
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <482C233C.5060808@powercraft.nl>
	<alpine.LNX.1.00.0805180455510.25212@nge2.ngu.pk>
In-Reply-To: <alpine.LNX.1.00.0805180455510.25212@nge2.ngu.pk>
Subject: Re: [Bluez-users] Nokia BH-801 why??
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

jayjwa wrote:
> 
> On Thu, 15 May 2008, Jelle de Jong wrote:
> 
> -> So got an other new headset with the hope it would work...
> -> 
> -> The nokia website sad it was bluetooth 2.0 instead of the 1.0 headset i first
> -> tried. But I does not work... Can somebody please enlight me why?
> 
> sudo hcitool info 00:53:53:FB:7E:9C
> Requesting information ...
>      BD Address:  00:53:53:FB:7E:9C
>      Device Name: Nokia BH-801
>      LMP Version: 2.0 (0x3) LMP Subversion: 0x212b
>      Manufacturer: Broadcom Corporation (15)
>      Features: 0xbc 0xfe 0x8f 0x7e 0x18 0x18 0x00 0x80
>          <encryption> <slot offset> <timing accuracy> <role switch>
>          <sniff mode> <RSSI> <channel quality> <SCO link> <HV2 packets>
> 
> Still looks like a plain SCO                 ^^^^^^^
> 
>          <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
>          <power control> <transparent SCO> <broadcast encrypt>
>          <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
>          <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
>          <AFH cap. slave> <AFH class. slave> <AFH cap. master>
>          <AFH class. master> <extended features>
> 
> 
> 
> May 15 13:39:57 debian-eeepc hcid[8991]: Badly formated or unrecognized 
> command: AT+CCWA=1
> May 15 13:39:57 debian-eeepc hcid[8991]: Badly formated or unrecognized 
> command: AT+COPS=3,0
> May 15 13:39:57 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet for 
> unknown connection
> handle 1
> May 15 13:39:57 debian-eeepc last message repeated 2 times
> May 15 13:39:57 debian-eeepc hcid[8991]: Badly formated or unrecognized 
> command: AT+CMEE=1
> May 15 13:39:57 debian-eeepc kernel: hci_scodata_packet: hci0 SCO packet for 
> unknown connection
> handle 1
> May 15 13:40:28 debian-eeepc last message repeated 10190 times
> 
> 
> 
> The error messages also look like those when eSCO gets sent to a SCO only 
> device. Maybe it's possible for bluetooth 2.0 devices to still be SCO-only? I 
> don't know the qualifications ...

Yes, it seem so but does this feature <EDR ACL 3 Mbps> not indicate that 
its a 2.0 device?

Thanks in advance,

Jelle

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
