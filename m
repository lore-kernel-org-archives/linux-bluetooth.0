Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <44E5C7E4.9030605@sd-6.org>
Date: Fri, 18 Aug 2006 09:00:04 -0500
From: Jon Ferguson <jon@sd-6.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Can't create connection: Input/output error
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I have been fighting a Motorola headset for several days and can't get
it to connect.  It appears to me that the pin is getting sent correctly
but it still fails to pair the device.


blackhawk:~# hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:F6:08:99:88 ACL MTU: 120:20 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:480 acl:0 sco:0 events:25 errors:0
        TX bytes:372 acl:0 sco:0 commands:23 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'blackhawk-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)




Syslog output:

Aug 18 08:50:03 localhost hcid[22950]: Bluetooth HCI daemon
Aug 18 08:50:03 localhost hcid[22950]: Register path:/org/bluez fallback:1
Aug 18 08:50:03 localhost hcid[22950]: Device hci0 has been added
Aug 18 08:50:03 localhost sdpd[22953]: Bluetooth SDP daemon
Aug 18 08:50:03 localhost hidd[22955]: Bluetooth HID daemon
Aug 18 08:50:03 localhost hcid[22950]: Device hci0 has been activated
Aug 18 08:50:03 localhost hcid[22950]: Register path:/org/bluez/hci0
fallback:0
Aug 18 08:50:03 localhost hcid[22950]: HCI dev 0 up
Aug 18 08:50:03 localhost hcid[22950]: Starting security manager 0
Aug 18 08:50:03 localhost hcid[22950]: Device hci0 has been activated
Aug 18 08:50:03 localhost hcid[22950]: name_listener_add(:1.53)
Aug 18 08:50:03 localhost hcid[22950]: name_listener_add(:1.54)
Aug 18 08:50:03 localhost hcid[22950]: Default passkey agent (:1.54,
/org/bluez/passkey_agent_22968) registered
Aug 18 08:50:45 localhost hcid[22950]: pin_code_request
(sba=00:11:F6:08:99:88, dba=00:0B:2E:38:0D:C3)
Aug 18 08:50:45 localhost hcid[22950]: Calling PasskeyAgent.Request:
name=:1.53, path=/org/bluez/passkey_agent_2296



hcidump
HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
