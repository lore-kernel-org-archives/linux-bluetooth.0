Return-Path: <cyrus@holtmann.org>
Message-ID: <7ceeaed30801151230o682e4f64u7559d273860f8c8c@mail.gmail.com>
Date: Tue, 15 Jan 2008 20:30:34 +0000
From: Arkaitz <arkaitzj@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] Problems connecting to devices
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

Hi list,
I'm using bluetooth over a Debian testing and i use bluetooth packages from apt.
I have a Palm TX and a Sony Ericsson K800i.

I try the next sequence against the palm:
Zack:/home/saladino# hcitool scan
Scanning ...
	00:70:E0:AA:4D:11	 Jagger
	00:1E:45:8C:5A:98	Serj Tankian

Zack:/home/saladino# hcitool cc 00:1E:45:8C:5A:98
Zack:/home/saladino# hcitool con
Connections:

This is the dumo if the cc:
Zack:/home/saladino# hcidump -t
HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
1200428828.025465 < HCI Command: Create Connection (0x01|0x0005) plen 13
1200428828.028926 > HCI Event: Command Status (0x0f) plen 4
1200428829.444042 > HCI Event: Connect Complete (0x03) plen 11
1200428829.444065 < HCI Command: Read Remote Supported Features
(0x01|0x001b) plen 2
1200428829.447039 > HCI Event: Read Remote Supported Features (0x0b) plen 11
1200428829.448038 > HCI Event: Command Status (0x0f) plen 4
1200428829.448047 < HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
1200428829.450039 > HCI Event: Command Complete (0x0e) plen 6
1200428829.450049 < HCI Command: Remote Name Request (0x01|0x0019) plen 10
1200428829.453041 > HCI Event: Command Status (0x0f) plen 4
1200428829.502070 > HCI Event: Max Slots Change (0x1b) plen 3
1200428829.562071 > HCI Event: Remote Name Req Complete (0x07) plen 255
1200428831.442895 < HCI Command: Disconnect (0x01|0x0006) plen 3
1200428831.446245 > HCI Event: Command Status (0x0f) plen 4
1200428831.612260 > HCI Event: Disconn Complete (0x05) plen 4

Obex transfers work correctly as well as sdptool browse.

Any hints? I don't know if I'm doing things correctly.

-- 
Arkaitz

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
