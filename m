Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <454B9B06.8070802@gmx.net>
Date: Fri, 03 Nov 2006 20:39:50 +0100
From: Arthur <arthur_vd@gmx.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Targus ACB20EU: Scan times out
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

Hello all

Scanning for other devices with the Targus ACB20EU USB dongle (a 
bluetooth 2.0 adapter with EDR support according to the packaging) 
always times out. It doesn't help to run hcid or hciconfig hci0 up 
beforehand. This is how it looks like:

# hcitool scan
Scanning ...
Inquiry failed: Connection timed out

Running hcidump -X -V at the same time only yields this output:

# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
     lap 0x9e8b33 len 8 num 0
 > HCI Event: Command Complete (0x0e) plen 4
     Inquiry (0x01|0x0001) ncmd 1
     0000: 0c

hciconfig -a gives an input/output error:

# hciconfig -a
hci0:   Type: USB
         BD Address: 00:16:38:3A:63:5E ACL MTU: 1017:8 SCO MTU: 64:8
         UP RUNNING
         RX bytes:275 acl:0 sco:0 events:37 errors:0
         TX bytes:667 acl:0 sco:0 commands:37 errors:0
         Features: 0xff 0xff 0x8d 0xfe 0x9b 0xfd 0x00 0x80
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: RSWITCH HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
Can't read local name on hci0: Input/output error (5)

Here the associated dump:

# hcidump -X -V
< HCI Command: Read Local Name (0x03|0x0014) plen 0
 > HCI Event: Command Complete (0x0e) plen 4
     Read Local Name (0x03|0x0014) ncmd 1
     status 0x0c name '.'
     Error: Command Disallowed

This is on a 2.6.17-10-386 kernel on Ubtuntu Edgy (2006.10).

Any ideas or suggestions are heartily welcome.

Regards

Arthur

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
