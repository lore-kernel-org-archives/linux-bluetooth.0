Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Ross Burton <ross@burtonini.com>
Message-ID: <loom.20050411T115017-79@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-devel] bluetooth-alsa not working with Cellink headset
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Apr 2005 09:53:36 +0000 (UTC)

Hi,

I've just purchased a cheap BT headset (a Cellink BTHS-6023F), and tried to use
it with the bluetooth-alsa userspace/kernel stuff.  However, it's not working:

$ ./btsco 00:0A:94:8C:CC:67
[enter PIN for pairing]
Error: The voice setting must be 0x060

For your information this is the output from hcitool:

$ hcitool info 00:0A:94:8C:CC:67
Requesting information ...
        BD Address:  00:0A:94:8C:CC:67
        Device Name: BT Headset-F
        LMP Version: 1.1 (0x1) LMP Subversion: 0x434
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xfc 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                <encryption> <slot offset> <timing accuracy> <role switch>
                <hold mode> <sniff mode> <park state> <RSSI> <channel quality>
                <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
                <CVSD> <paging scheme> <power control> <transparent SCO>

Any ideas?

Thanks,
Ross



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
