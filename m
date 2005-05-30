Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Daniela Taubert <daniela.taubert@physik.uni-muenchen.de>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200505301752.38707.daniela.taubert@physik.uni-muenchen.de>
Subject: [Bluez-users] trying to connect to a M2500 Plantronics headset
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
Date: Mon, 30 May 2005 17:52:38 +0200

Hi all,

I'm trying to get my bluetooth headset working with btsco but can't establish 
a connection. Switched to kernel 2.6.11.11 today...

I have KBluetoothD running which seems to give me some useful information; I 
also tried without but didn't get different results so I guess it doesn't 
disturb anything...

That's what I did:

1) start sdpd, hcid, rfcomm via init script
2) plug in dongle
	=> KBluetoothD recognizes dongle
3) headset in pairing mode
	=> no reaction
4) hcitool scan
	=> headset found, KBluetoothD doesn't show connection
5) modprobe snd_bt_sco
6) btsco <heaset_addr>
	=> KBluetoothD finds the headset but shows zero connection strength
	=> command times out with 

	Error: Failed to connect to SDP server: Connection timed out
	Assuming channel 2
	
	Can't connect RFCOMM channel: Resource temporarily unavailable

	(passing the channel number (I tried 1,2,3) doesn't change the situation)

7) hcidump (headset in pairing mode) while trying the btsco command:

	< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
	> HCI Event: Command Complete (0x0e) plen 6
	Read Voice Setting (0x03|0x0025) ncmd 1
	status 0x00 voice setting 0x0060
	< HCI Command: Create Connection (0x01|0x0005) plen 13
	bdaddr 00:03:89:91:37:87 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5
	> HCI Event: Command Status (0x0f) plen 4
	Create Connection (0x01|0x0005) status 0x00 ncmd 1
	> HCI Event: Link Key Request (0x17) plen 6
	bdaddr 00:03:89:91:37:87
	< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
	bdaddr 00:03:89:91:37:87
	> HCI Event: Command Complete (0x0e) plen 10
	Link Key Request Negative Reply (0x01|0x000c) ncmd 1
	status 0x00 bdaddr 00:03:89:91:37:87
	> HCI Event: PIN Code Request (0x16) plen 6
	bdaddr 00:03:89:91:37:87
	< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
	bdaddr 00:03:89:91:37:87
	> HCI Event: Command Complete (0x0e) plen 10
	PIN Code Request Negative Reply (0x01|0x000e) ncmd 1
	status 0x00 bdaddr 00:03:89:91:37:87


At some point during my tests KBluetoothD told me "Host rejected because 
remote device is only a personal device" but I couldn't reproduce that 
message.

I guess there's a problem with the PIN... from what I read there should be a 
window asking me for PIN but I don't get anything like that.

Could anybody point me in the right direction please? I must be doing 
something wrong...

thanks in advance,
Daniela


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
