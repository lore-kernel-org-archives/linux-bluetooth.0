Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sunnan <sunnan@handgranat.org>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1137635164.7455.63.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Apple mouse gives me various "Can't get device information"
 troubles
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
Date: Thu, 19 Jan 2006 02:46:03 +0100

Hi, Marcel;
The only modification to hcid.conf I can remember doing was to set the
pin_helper to a shell script that just echoes PIN:1234 (I don't remember
what the pin is supposed to be; I got the number from /etc/bluetooth/pin
but isn't this resettable somehow?) regardless of it's arguments,
because regular bluepin crashes with the familiar(? at least that's what
I gather from various mailing lists) xserver permission problem.

My output from hciconfig -a says:
hci0:   Type: USB
        BD Address: 00:0D:93:04:19:15 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:318 acl:0 sco:0 events:36 errors:0
        TX bytes:502 acl:0 sco:0 commands:26 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'slowstorm-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x385 LMP Ver: 1.1 (0x1) LMP Subver:
0x385
        Manufacturer: Cambridge Silicon Radio (10)

Sunnan



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
