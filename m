Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: bluez-users@lists.sourceforge.net
Date: Sat, 29 Jul 2006 14:26:26 +0200
References: <200607271240.49400.fexpop@onlinehome.de>
	<200607271258.45178.fexpop@onlinehome.de>
	<1153998247.9543.8.camel@localhost>
In-Reply-To: <1153998247.9543.8.camel@localhost>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yP1yEM+fLhkO31L"
Message-Id: <200607291426.26109.fexpop@onlinehome.de>
Subject: Re: [Bluez-users] Several problems with bluez-utils 3.1,
	kbluetoothd and a Belkin dongle in Debian
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--Boundary-00=_yP1yEM+fLhkO31L
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

On Thursday 27 July 2006 13:04, Marcel Holtmann wrote:
> with bluez-utils-3.x we try to activate Inquiry with RSSI by default and
> in your case it doesn't seem to work.

Thanks, for clarifying.

> What does "hciconfig hci0 features version" tell you about your dongle.

Please, take a look into the attached features-version.log.

> Please also include the output of "hcidump -X -V" while starting an
> inquiry. With inqmode 0 and inqmode 1.

I've attached some files containing the ouptut of 'hcidump -X -V'. Those with 
hcitool in their name have been produced while doing a 'hcitool scan', those 
with kdebluetooth while scanning for devices with kdebluetoothd. The 
corresponding inqmode should be obvious from the file names.

Kind regards,

Felix

--Boundary-00=_yP1yEM+fLhkO31L
Content-Type: text/x-log; charset="iso-8859-1"; name="scan_hcitool_inq_0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scan_hcitool_inq_0.log"

HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1
    enable 2
> HCI Event: Command Complete (0x0e) plen 4
    Write Scan Enable (0x03|0x001a) ncmd 1
    status 0x00
< HCI Command: Read Scan Enable (0x03|0x0019) plen 0
> HCI Event: Command Complete (0x0e) plen 5
    Read Scan Enable (0x03|0x0019) ncmd 1
    status 0x00 enable 2
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349f class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349f class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349e class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x349d class 0x50020c

--Boundary-00=_yP1yEM+fLhkO31L
Content-Type: text/x-log; charset="iso-8859-1"; name="scan_hcitool_inq_1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scan_hcitool_inq_1.log"

HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8d class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8d class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8d class 0x50020c rssi -65
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -75
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8d class 0x50020c rssi -65
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -74
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8d class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8d class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -75
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8d class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -68
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -68
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -69
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -71
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -67
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -67
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -72
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -65
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -72
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -68
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -73
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -75
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -76
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -73
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -73
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8c class 0x50020c rssi -66
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x2a8b class 0x50020c rssi -66
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00

--Boundary-00=_yP1yEM+fLhkO31L
Content-Type: text/x-log; charset="iso-8859-1";
	name="scan_kdebluetooth_inq_1.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scan_kdebluetooth_inq_1.log"

HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3631 class 0x50020c rssi -72
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3631 class 0x50020c rssi -67
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3631 class 0x50020c rssi -70
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3630 class 0x50020c rssi -70
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3631 class 0x50020c rssi -68
> HCI Event: Inquiry Result with RSSI (0x22) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3631 class 0x50020c rssi -68
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00

--Boundary-00=_yP1yEM+fLhkO31L
Content-Type: text/x-log; charset="iso-8859-1";
	name="scan_kdebluetooth_inq_0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="scan_kdebluetooth_inq_0.log"

HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x12 ncmd 1
    Error: Invalid HCI Command Parameters
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5c class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5c class 0x50020c
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5c class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5d class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5c class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5c class 0x50020c
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:17:4B:1D:85:0A mode 1 clkoffset 0x3c5d class 0x50020c
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 6 num 0
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x12 ncmd 1
    Error: Invalid HCI Command Parameters
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:17:4B:1D:85:0A mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Flush Occurred (0x11) plen 2
    handle 12
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:17:4B:1D:85:0A name 'Fex N70'

--Boundary-00=_yP1yEM+fLhkO31L
Content-Type: text/x-log; charset="iso-8859-1"; name="features-version.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="features-version.log"

hci0:	Type: USB
	BD Address: 00:00:3A:6A:1B:A0 ACL MTU: 1017:8 SCO MTU: 64:0
	Features: 0xff 0xfb 0x8d 0xfe 0x9f 0xf9 0x00 0x80
		<3-slot packets> <5-slot packets> <encryption> <slot offset> 
		<timing accuracy> <role switch> <hold mode> <sniff mode> 
		<park state> <RSSI> <SCO link> <HV2 packets> <HV3 packets> 
		<u-law log> <A-law log> <CVSD> <power control> 
		<transparent SCO> <broadcast encrypt> <EDR ACL 2 Mbps> 
		<EDR ACL 3 Mbps> <enhanced iscan> <interlaced iscan> 
		<interlaced pscan> <inquiry with RSSI> <extended SCO> 
		<EV4 packets> <EV5 packets> <no. 34> <AFH cap. slave> 
		<AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL> 
		<AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps> 
		<EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features> 
	HCI Ver: 2.0 (0x3) HCI Rev: 0x2073 LMP Ver: 2.0 (0x3) LMP Subver: 0x410e
	Manufacturer: Broadcom Corporation (15)

--Boundary-00=_yP1yEM+fLhkO31L
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_yP1yEM+fLhkO31L
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--Boundary-00=_yP1yEM+fLhkO31L--
