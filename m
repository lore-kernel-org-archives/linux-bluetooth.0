Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Jan 2008 11:56:46 -0800 (PST)
From: "Russell A. Bell" <rbell@alumnus.caltech.edu>
Message-Id: <200801241956.m0OJujFi003379@alumnus.caltech.edu>
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Could I have a bum dongle?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

	  It never gets detected at start; I have to remove it
physically and plug it back in.
	It's an Integrated System Solution Corp. ; HCI Ver: 1.2 (0x2)
HCI Rev: 0x1fe LMP Ver: 1.2 (0x2) LMP Subver: 0x1fe
	Sometimes it causes my wireless keyboard (not Bluetooth - it
must be some proprietary Logitech protocol) to work erratically:
ignore some keys and repeat others.

	'hciconfig hci0 sspmode' returns:

	Can't read Simple Pairing mode on hci0: Input/output error (5)

hcidump  records:
	< HCI Command: Read Simple Pairing Mode (0x03|0x0055) plen 0
	> HCI Event: Command Complete (0x0e) plen 4
	    Read Simple Pairing Mode (0x03|0x0055) ncmd 1
	    status 0x01 mode 0x00
	    Error: Unknown HCI Command


	'hciconfig hci0 oobdata' returns:
	Can't read local OOB data on hci0: Input/output error (5)

hcidump records:
	< HCI Command: Read Local OOB Data (0x03|0x0057) plen 0
	> HCI Event: Command Complete (0x0e) plen 4
	    Read Local OOB Data (0x03|0x0057) ncmd 1
	    status 0x01
	    Error: Unknown HCI Command

	'hciconfig hci0 revision' returns:
	hci0:   Type: USB
		BD Address: 00:11:67:6B:77:2D ACL MTU: 678:8 SCO MTU: 48:10
	        Unsupported manufacturer

hcidump records:
	< HCI Command: Read Local Version Information (0x04|0x0001) plen 0
	> HCI Event: Command Complete (0x0e) plen 12
	    Read Local Version Information (0x04|0x0001) ncmd 1
	    status 0x00
	    HCI Version: 1.2 (0x2) HCI Revision: 0x1fe
	    LMP Version: 1.2 (0x2) LMP Subversion: 0x1fe
	    Manufacturer: Integrated System Solution Corp. (57)


	'hcitool cc $headset ; hcitool con' returns

 	Can't create connection: Connection timed out
	Connections:
	< ACL 00:13:17:DD:D0:86 handle 0 state 2 lm MASTER

It both times out *and* reports the existence of the connection.
The hcidump reads:

	< HCI Command: Create Connection (0x01|0x0005) plen 13
	    bdaddr 00:13:17:DD:D0:86 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
	    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
	> HCI Event: Command Status (0x0f) plen 4
	    Create Connection (0x01|0x0005) status 0x00 ncmd 1
	> HCI Event: Link Key Request (0x17) plen 6
	    bdaddr 00:13:17:DD:D0:86
	> HCI Event: Connect Complete (0x03) plen 11
	    status 0x22 handle 0 bdaddr 00:13:17:DD:D0:86 type ACL encrypt 0x00
	    Error: LMP Response Timeout

the 'Connect Complete'

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
