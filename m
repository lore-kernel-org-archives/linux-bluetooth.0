Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1379.193.136.143.20.1077809745.squirrel@webmail.rnl.ist.utl.pt>
Subject: RE: [Bluez-devel] Widcomm BlueConnect and Bluez
From: <dsas@rnl.ist.utl.pt>
To: <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1077804727.2754.44.camel@pegasus>
References: <000f01c3fc6f$303ed760$318388c1@zedidas>
        <1077804727.2754.44.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Thu, 26 Feb 2004 15:35:45 -0000 (WET)

> Hi Didier,
>
>> > what kind of PDA is this? What kernel are you using? Make a binary
>> hcidump and send it to us.
>>
>> It's a Handspring Visor Pro with PalmOS 3.5.2H3.0. I read somewhere
>> that there is a problem with buffer overrun in that version of PalmOS.
>
> please run "hcitool info <bdaddr-visor>" (as root).
>
>> The Bluez kernel version is 2.3.
>
> Don't use this. A kernel with my -mh patch is enough.
>
> Regards
>
> Marcel

# hcitool info 00:80:37:16:32:D2
Requesting information ...
BD Address:  00:80:37:16:32:D2
Device Name: My BlueConnect
LMP Version: 1.1 (0x1) LMP Subversion: 0x8b40
Manufacturer: Ericsson Mobile Comunications (0)
Features: 0xff 0xfb 0x01 0x00
	<3-slot packets> <5-slot packets> <encryption> <slot offset>
	<timing accuracy> <role switch> <hold mode> <sniff mode>
	<park mode> <RSSI> <SCO link> <HV2 packets>
	<HV3 packets> <u-law log> <A-law log> <CVSD>

I use this version of bluez kernel because I need to make some changes in
bluez modules (qos parameters...). Can I make these changes with mh?

Thanks.

Didier




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
