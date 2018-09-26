Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: grpmind+bluez.users@boromir.vpop.net
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
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
Date: Tue Feb 17 06:36:05 2004
Message-Id: <20040217132821.A599132D2F@mail.rvs.uni-bielefeld.de>

Marcel wrote:

> please run "hcitool info <bdaddr>" to show us what kind of Bluetooth
> chip is inside. I think it is a Zeevo one.

$ hcitool info 00:04:3E:81:90:E0
Requesting information ...
        BD Address:  00:04:3E:81:90:E0
        Device Name: Pocket_PC
        LMP Version: 1.1 (0x1) LMP Subversion: 0x8d
        Manufacturer: Telencomm Inc. (18)
        Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link>
                <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <power control>

The folks at handhelds.org think it's a Zeevo:
http://www.handhelds.org/platforms/hp/ipaq-h22xx/tc2k_public.pdf

> It can happen, because some link managers only does this right when they
> are connected to there own dongles.

Do you know which dongles have bad link managers?

Thanks for your help.

Matt


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
