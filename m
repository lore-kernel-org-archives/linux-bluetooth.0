Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Robert Siemer <Robert.Siemer@backsla.sh>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Jumpy cursor with Wacom Graphire Bluetooth
Message-ID: <20051127212410.GE15156@polar.elf12.net>
References: <20051008132533.GA954@polar.elf12.net> <20051127174209.GB15156@polar.elf12.net> <1133115990.13629.1.camel@blade>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <1133115990.13629.1.camel@blade>
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
Date: Sun, 27 Nov 2005 22:24:10 +0100


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 27, 2005 at 07:26:30PM +0100, Marcel Holtmann wrote:

> to create a new hcidump which includes all HCI traffic. The latest
> versions even decode HIDP for you. Send in the output of "hciconfig -a".

Latest versions or the latest twenty version? (-:  HIDP is in since 1.6,
so I hope 1.23 is okay...

panorama:/tmp# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0C:55:FF:71:AA ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:1121232 acl:71106 sco:0 events:2355 errors:0
        TX bytes:1366 acl:64 sco:0 commands:26 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE 
        Name: 'panorama-0'
        Class: 0xff0100
        Service Classes: Positioning, Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver: 0x33c
        Manufacturer: Cambridge Silicon Radio (10)



Switching on the tablet, hcid and hidd in place. In the end some mouse
movements...

HCI sniffer - Bluetooth packet analyzer ver 1.23
> HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:13:C2:00:11:2C class 0x002580 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:13:C2:00:11:2C role 0x01
    Role: Slave
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:13:C2:00:11:2C type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK 
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:13:C2:00:11:2C mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
    handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0040
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Command Status (0x0f) plen 4
    Change Connection Packet Type (0x01|0x000f) status 0x00 ncmd 1
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
    status 0x00 handle 41 ptype 0xcc18
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: QoS Setup Complete (0x0d) plen 21
    status 0x00 handle 41 flags 0
    Service type: 1
    Token rate: 0
    Peak bandwith: 0
    Latency: 11250
    Delay variation: -1
> ACL data: handle 41 flags 0x02 dlen 40
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Role Change (0x12) plen 8
    status 0x00 bdaddr 00:13:C2:00:11:2C role 0x00
    Role: Master
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0041
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 40
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 28
      MTU 48 QoS 0x01 (Best effort) 
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 48 
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> HCI Event: Mode Change (0x14) plen 6
    status 0x00 handle 41 mode 0x02 interval 16
    Mode: Sniff
< ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Output report
      0000: 02 b8 00 00 00                                    .....
< ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Output report
      0000: 03 00 00 00 00 00 00 00                           ........
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 03 00                                             ..
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 04 00                                             ..
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 05 00                                             ..
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 06 00                                             ..
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 07 00                                             ..
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 08 00                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
< ACL data: handle 41 flags 0x02 dlen 7
    L2CAP(d): cid 0x0041 len 3 [psm 19]
      HIDP: Data: Output report
      0000: 09 00                                             ..
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 41 packets 1
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 00 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 00 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 fd 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 06 00 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 06 00 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 06 fe 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 06 01 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 07 01 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 06 01 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 06 05 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 06 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 06 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 fe 06 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 fd 07 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 fa 03 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 fa fc 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 fd fa 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 00 f9 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 01 fa 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 fb fa 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 
> ACL data: handle 41 flags 0x02 dlen 10
    L2CAP(d): cid 0x0041 len 6 [psm 19]
      HIDP: Data: Input report
      0000: 02 00 fa ff 00                                    .....
> ACL data: handle 41 flags 0x02 dlen 13
    L2CAP(d): cid 0x0041 len 9 [psm 19]
      HIDP: Data: Input report
      0000: 03 00 00 00 00 00 00 20                           ....... 

--BOKacYhQ+x31HxR3
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="hcidump.out"
Content-Transfer-Encoding: base64

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
AikgDQAJAEEAoQMAAAAAAAAgDwABAK8JikNDOgYAAikgCgAGAEEAoQIAAAYAEgABAK8JikMM
QgYAAikgDQAJAEEAoQMAAAAAAAAgDwABAK8JikMnqwgAAikgCgAGAEEAoQIAAAYAEgABAK8J
ikPwsggAAikgDQAJAEEAoQMAAAAAAAAgDwABAK8JikNFuAsAAikgCgAGAEEAoQIA/gYAEgAB
AK8JikMawAsAAikgDQAJAEEAoQMAAAAAAAAgDwABAK8JikMT2w0AAikgCgAGAEEAoQIA/QcA
EgABAK8JikPb4g0AAikgDQAJAEEAoQMAAAAAAAAgDwABALAJikN5LAMAAikgCgAGAEEAoQIA
+gMAEgABALAJikNANAMAAikgDQAJAEEAoQMAAAAAAAAgDwABALAJikNfnQUAAikgCgAGAEEA
oQIA+vwAEgABALAJikMjpQUAAikgDQAJAEEAoQMAAAAAAAAgDwABALAJikPoIwcAAikgCgAG
AEEAoQIA/foAEgABALAJikOxKwcAAikgDQAJAEEAoQMAAAAAAAAgDwABALAJikNZGwsAAikg
CgAGAEEAoQIAAPkAEgABALAJikM0IwsAAikgDQAJAEEAoQMAAAAAAAAgDwABALAJikOYdg4A
AikgCgAGAEEAoQIAAfoAEgABALAJikNcfg4AAikgDQAJAEEAoQMAAAAAAAAgDwABALEJikPs
ywMAAikgCgAGAEEAoQIA+/oAEgABALEJikPUzwMAAikgDQAJAEEAoQMAAAAAAAAgDwABALEJ
ikPhigYAAikgCgAGAEEAoQIA+v8AEgABALEJikPIjgYAAikgDQAJAEEAoQMAAAAAAAAg

--BOKacYhQ+x31HxR3--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
