Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4117B376.3030507@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] "comlicated" setup - known issues for hid and	SCO?
References: <4117A907.7010006@dark-reality.de> <1092071597.4564.17.camel@pegasus>
In-Reply-To: <1092071597.4564.17.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 09 Aug 2004 19:25:10 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
| Hi Lars,
|
|
|>right now I'm using two BT devices with my Epox dongle, an MX900 mice
|>and a Sony Ericcson HBH-35 Headset with snd-bt-sco (voice mode 0x0060,
|>before you ask ;)
|
|
| what does "hcitool info ..." say about your headset? What is the
| firmware version of your EPoX dongle?
|
|
Headset:
~        BD Address:  00:0E:07:33:DE:2B
~        Device Name: HBH-35
~        LMP Version: 1.1 (0x1) LMP Subversion: 0x8d40
~        Manufacturer: Ericsson Technology Licensing (0)
~        Features: 0xbc 0x28 0x01 0x00 0x00 0x00 0x00 0x00
~                <encryption> <slot offset> <timing accuracy> <role switch>
~                <sniff mode> <SCO link> <HV3 packets> <CVSD>


Mouse:
~        BD Address:  00:07:61:04:D6:7D
~        Device Name: Logitech MX900 Mouse
~        LMP Version: 1.1 (0x1) LMP Subversion: 0x350
~        Manufacturer: Cambridge Silicon Radio (10)
~        Features: 0xfc 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
~                <encryption> <slot offset> <timing accuracy> <role switch>
~                <hold mode> <sniff mode> <park state> <RSSI> <channel
quality>
~                <SCO link> <HV2 packets> <HV3 packets> <u-law log>
<A-law log>
~                <CVSD> <paging scheme> <power control> <transparent SCO>


How can I find out what firmware my dongle has? It's a BT-DG03...

cu,
~  Lars

PS: great mouse, by the way. Works perfectly with Bluetooth and connects
easily to different systems.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBF7N2QWC6DTWkDAoRArpEAJ4mMDV59gdZUyPBzsZ3a+iqrZsBtwCfZPPZ
TJWAeT+qMUXQ3nGs7DxbrYA=
=gvqb
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
