Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Peter K. Martin" <Peter.K.Martin@t-online.de>
To: <bluez-users@lists.sourceforge.net>
Subject: AW: [Bluez-users] Re: Toshiba and BT (SuSE 9.2)
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAosiAEZOtxUiHqgChZUVmh8KAAAAQAAAAOihBpRJ97k2gwO2yUG25+wEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1103109183.2143.215.camel@pegasus>
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
Date: Wed, 15 Dec 2004 13:37:07 +0100

Hi Marcel,
now no pand or dund is running.

##>what the f* is this. Use "sdptool browse ..." and "sdptool=20
##>search ..." to find out what services/profiles this device=20
##>really supports, because it seems that their support don't=20
##>even know it.

the results make not really happy, isn't it so?

Linux-Notebook:~ # sdptool browse 00:0B:CE:00:01:8F
Browsing 00:0B:CE:00:01:8F ...

Linux-Notebook:~ # sdptool search 00:0B:CE:00:01:8F LAP
Unknown service 00:0B:CE:00:01:8F
Linux-Notebook:~ # sdptool search 00:0B:CE:00:01:8F DUN
Unknown service 00:0B:CE:00:01:8F

Linux-Notebook:~ # sdptool search LAP
Unknown service LAP
Linux-Notebook:~ # sdptool search DUN
Inquiring ...
Searching for DUN on 00:0B:CE:00:01:8F ...
Linux-Notebook:~ #      =20

##>Also do a "hcitool info ..." for me.

Perhaps this gives a way to you:

Linux-Notebook:~ # hcitool info 00:0B:CE:00:01:8F
Requesting information ...
        BD Address:  00:0B:CE:00:01:8F
        Device Name: Bluetooth-Modul
        LMP Version: 1.1 (0x1) LMP Subversion: 0x175
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot =
offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging =
scheme>
                <power control> <transparent SCO>

Regards
Peter




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
