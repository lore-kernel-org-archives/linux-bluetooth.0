Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17261.23534.882674.809679@waldo.lisle.iphase.com>
To: bluez-users@lists.sourceforge.net
From: bradbosch@comcast.net
Subject: [Bluez-users] btsco + aplay produces only silence on headset
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
Date: Sat, 5 Nov 2005 19:27:10 -0600

Greetings,

I hope someone here can tell me what I might be doing wrong.  I have
no problems pairing various headsets with my computer and the volume
controls and other buttons produce the expected results.  I hear a
beep when I start aplay, but no other sound is produced.  I've been
thru the mail list archives but none of the hints I've found there
have helped.

I've tried three different USB adapters (two CSR BlueCore02 based and
one BT1.2 Broadcom based Zoom adapter) and three BT headsets (Motorola
HS850, Plantronic Explorer 320, and now a Logitech Mobile Express),
all with identical results.  All the headsets worked with my Cell
phone.  My distribution is Debian 3.1 (Sarge).  I've tried a couple of
kernel versions and am currently running 2.6.14-rc4.  I've also
upgraded to a recent CVS snapshot of bluez utilities and library with
the same results.  I have included a variety of debug output (obtained
with the newer of the CSR adapters) here including hcidump and all the
version info I could think of providing.

I would greatly appreciate any help.

Thanks,

--Brad Bosch

brad@waldo:~$ sudo hciconfig -a
hci0:   Type: USB
        BD Address: 00:20:E0:27:91:15 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING
        RX bytes:117 acl:0 sco:0 events:15 errors:0
        TX bytes:310 acl:0 sco:0 commands:14 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: ACCEPT MASTER
        Name: 'waldo-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x322 LMP Ver: 1.1 (0x1) LMP Subver: 0x322
        Manufacturer: Cambridge Silicon Radio (10)

brad@waldo:~$ sudo hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:20:E0:27:91:15 ACL MTU: 192:8 SCO MTU: 64:8
        Build 802
        Chip version: BlueCore02-External
        Max key size: 128 bit
        SCO mapping:  HCI
brad@waldo:~$ sudo hcitool info 00:0D:FD:06:AD:09
Requesting information ...
        BD Address:  00:0D:FD:06:AD:09
        Device Name: Logitech HS04 V01
        LMP Version: 1.2 (0x2) LMP Subversion: 0x60f
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <AFH cap. slave>
                <AFH cap. master>
brad@waldo:~$ sudo hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.26
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 09 ad 06 fd 0d 00 18 cc  02 00 00 00 00           .............
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Link Key Request (0x17) plen 6
  0000: 09 ad 06 fd 0d 00                                 ......
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
  0000: 09 ad 06 fd 0d 00 36 f4  c2 81 dc 4e ab a5 a0 ba  ......6....N....
  0010: 35 91 6e 5c ec 1d                                 5.n\..
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0b 04 00 09 ad 06 fd  0d 00                    ..........
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 09 ad 06 fd 0d  00 01 01                 .).........
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 29 00 0f 00                                       )...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 29 00                                 ....).
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
  0000: 09 ad 06 fd 0d 00 01                              .......
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 0
      Success
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
< ACL data: handle 41 flags 0x02 dlen 24
    L2CAP(d): cid 0x0043 len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 00
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          count 38
          cont 02 00 3A
< ACL data: handle 41 flags 0x02 dlen 26
    L2CAP(d): cid 0x0043 len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 3A
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          count 38
          cont 02 00 14
< ACL data: handle 41 flags 0x02 dlen 26
    L2CAP(d): cid 0x0043 len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1108 (Headset)
          max 65535
          aid(s) 0x0000 - 0xffff
          cont 02 00 14
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 32
    L2CAP(d): cid 0x0040 len 28 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x17
          count 20
          record #0
              aid 0x0000 (SrvRecHndl)
                 uint 0x10000
              aid 0x0001 (SrvClassIDList)
                 < uuid-16 0x1108 (Headset) uuid-16 0x1203 (Audio) >
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0x1 > >
              aid 0x0006 (LangBaseAttrIDList)
                 < uint 0x656e uint 0x6a uint 0x100 >
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x100 > >
              aid 0x0100 (SrvName)
                 str "Logitech HS04 V01"
              aid 0x0302 (unknown)
                 bool 0x1
          cont 00
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0040
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 25 0c 00 60 00                                 .%..`.
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0040
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0044 scid 0x0041 result 0 status 0
      Connection successful
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0044 flags 0x00 clen 4
      MTU 1024
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1024
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0044 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0044 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0044 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 2 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 1019 max_retrans 0 credits 7
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 2 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 127 max_retrans 0 credits 0
< ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0044 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0044 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC CMD: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0044 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 1 dlci 0 pf 0 ilen 4 fcs 0x70 mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 0 b1 0 b2 0 b3 0 len 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(s): MSC RSP: cr 0 dlci 0 pf 0 ilen 4 fcs 0xaa mcc_len 2
      dlci 2 fc 0 rtc 1 rtr 1 ic 0 dv 1 b1 0 b2 0 b3 0 len 0
< ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0044 len 5 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 1 ilen 0 fcs 0x86 credits 33
> ACL data: handle 41 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 15
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...

< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 29 00 e0 00                                       )...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 07 04                                       ....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 01                                          )..
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 2c 00 09 ad 06 fd 0d  00 00 01                 .,.........
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 03                                          )..
> ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 0 ilen 10 fcs 0x40
      0000: 41 54 2b 56 47 53 3d 31  32 0d                    AT+VGS=12.
< ACL data: handle 41 flags 0x02 dlen 14
    L2CAP(d): cid 0x0044 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
      0000: 0d 0a 4f 4b 0d 0a                                 ..OK..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...

< ACL data: handle 41 flags 0x02 dlen 18
    L2CAP(d): cid 0x0044 len 14 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 10 fcs 0x9a
      0000: 41 54 2b 56 47 53 3d 31  32 0d                    AT+VGS=12.
< ACL data: handle 41 flags 0x02 dlen 17
    L2CAP(d): cid 0x0044 len 13 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 9 fcs 0x9a
      0000: 41 54 2b 56 47 4d 3d 31  0d                       AT+VGM=1.
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 2c 00 13                                          ,..
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 2c 00 16                                       .,..
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..


brad@waldo:~$ uname -a
Linux waldo 2.6.14-rc4 #2 Thu Oct 13 15:02:05 CDT 2005 i686 GNU/Linux
b

------ Here is an example command I've tried testing audio output ------

aplay -B 1000000 -D plughw:Headset /usr/share/sounds/KDE_Startup.wav

------ And the output from btsco associated with the dump above ------
brad@waldo:~/src$ sudo btsco -v 00:0D:FD:06:AD:09
btsco v0.4c
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
speaker volume: 0 mic volume: 0
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=12
Sending up speaker change 12
speaker volume: 12 mic volume: 1
driver is not in use
disconnected SCO channel

------ Some version info:

hcitool - HCI Tool ver 2.21

ll /usr/lib/libbluetooth.*
-rw-r--r--  1 root root 70502 Oct 29 15:27 /usr/lib/libbluetooth.a
-rw-r--r--  1 root root   835 Oct 29 15:27 /usr/lib/libbluetooth.la
lrwxrwxrwx  1 root root    22 Oct 29 15:31 /usr/lib/libbluetooth.so -> libbluetooth.so.1.0.21
lrwxrwxrwx  1 root root    22 Oct 29 15:31 /usr/lib/libbluetooth.so.1 -> libbluetooth.so.1.0.21
-rw-r--r--  1 root root 66104 Oct 29 15:27 /usr/lib/libbluetooth.so.1.0.21

brad@waldo:~$ cat /proc/bus/usb/devices

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.14-rc4 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 23/900 us ( 3%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.14-rc4 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#= 15 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=049f ProdID=0086 Rev= 8.02
S:  Manufacturer=ACTIONTEC
S:  Product=Bluetooth by hp
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr= 90mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.14-rc4 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.14-rc4 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

brad@waldo:~$ lsmod
Module                  Size  Used by
sco                    10820  0
snd_bt_sco             11692  0
snd_hwdep               7072  1 snd_bt_sco
8139cp                 16512  0
prism54                53448  0
wbsd                   16840  0
hci_usb                10320  2
sd_mod                 13264  0
scsi_mod               85736  1 sd_mod
ipt_state               1536  0
ipt_MASQUERADE          2624  0
tun                     8768  1
isofs                  32632  0
zlib_inflate           17280  1 isofs
vfat                   10688  0
fat                    46044  1 vfat
rfcomm                 35228  7
l2cap                  20548  5 rfcomm
bluetooth              42180  8 sco,hci_usb,rfcomm,l2cap
thermal                10888  0
processor              18940  1 thermal
ac                      3396  0
battery                 8260  0
ipv6                  234752  20
ipt_LOG                 6080  0
parport_pc             25092  0
parport                31624  1 parport_pc
iptable_mangle          2240  0
iptable_filter          2304  0
iptable_nat             6724  0
ip_nat                 15860  2 ipt_MASQUERADE,iptable_nat
ip_tables              18368  6 ipt_state,ipt_MASQUERADE,ipt_LOG,iptable_mangle,iptable_filter,iptable_nat
ip_conntrack           42128  4 ipt_state,ipt_MASQUERADE,iptable_nat,ip_nat
mii                     4480  1 8139cp
snd_intel8x0m          15172  2
snd_intel8x0           29728  2
snd_ac97_codec         93692  2 snd_intel8x0m,snd_intel8x0
snd_ac97_bus            1856  1 snd_ac97_codec
snd_pcm_oss            48096  0
snd_mixer_oss          17088  3 snd_pcm_oss
snd_pcm                80328  5 snd_bt_sco,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd_timer              20548  1 snd_pcm
snd                    44772  13 snd_bt_sco,snd_hwdep,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore               7200  3 snd
snd_page_alloc          8584  4 snd_bt_sco,snd_intel8x0m,snd_intel8x0,snd_pcm
ehci_hcd               29256  0
usbhid                 35360  0
uhci_hcd               30608  0
usbcore               109120  5 hci_usb,ehci_hcd,usbhid,uhci_hcd
ohci1394               31860  0
ieee1394               88756  1 ohci1394
mmc_block               6408  0
mmc_core               19344  2 wbsd,mmc_block
speedstep_centrino      5128  0
freq_table              3460  1 speedstep_centrino
ide_cd                 38852  0
cdrom                  38688  1 ide_cd
rtc                     9784  0


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
