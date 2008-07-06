Return-Path: <cyrus@holtmann.org>
Message-ID: <a7f7fb4f0807060733m432a56f6ndf113d4eb30aa8b2@mail.gmail.com>
Date: Sun, 6 Jul 2008 16:33:18 +0200
From: "Unai Uribarri" <unaiur@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <f9d4bd30804240557v1d6d3187o59fcba455f57b82d@mail.gmail.com>
MIME-Version: 1.0
References: <a7f7fb4f0804181445q349985a8kd8cde5185ad3c5a9@mail.gmail.com>
	<a7f7fb4f0804181511y2fe86120n3c169670f4cb7ff5@mail.gmail.com>
	<f9d4bd30804240557v1d6d3187o59fcba455f57b82d@mail.gmail.com>
Subject: Re: [Bluez-users] Link encryption failed: Input/output error
	(Belkin F8T013)
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0227526734=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0227526734==
Content-Type: multipart/alternative;
	boundary="----=_Part_10077_30873011.1215354798326"

------=_Part_10077_30873011.1215354798326
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I have bought a Logitech keyboard and the bt dongle doesn't want to encrypt
any communication still.

sdptool browse --raw --l2cap xx:xx:xx:xx:xx:xx (Logitech keyboard)

Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010000
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1124 - HumanInterfaceDeviceService (HID)
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                                UINT16 0x0011
                        Sequence
                                UUID16 0x0011 - HIDP
        Attribute 0x0005 - BrowseGroupList
                Sequence
                        UUID16 0x1002 - PublicBrowseGroup
        Attribute 0x0006 - LanguageBaseAttributeIDList
                Sequence
                        UINT16 0x656e
                        UINT16 0x006a
                        UINT16 0x0100
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x1124 - HumanInterfaceDeviceService
(HID)
                                UINT16 0x0100
        Attribute 0x000d - AdditionalProtocolDescriptorLists
                Sequence
                        Sequence
                                Sequence
                                        UUID16 0x0100 - L2CAP
                                        UINT16 0x0013
                                Sequence
                                        UUID16 0x0011 - HIDP
        Attribute 0x0100
                String Logitech Bluetooth Wireless
Keyboard
        Attribute 0x0101
                String Keyboard
        Attribute 0x0102
                String Logitech
        Attribute 0x0200
                UINT16 0x0100
        Attribute 0x0201
                UINT16 0x0111
        Attribute 0x0202
                UINT8 0x40
        Attribute 0x0203
                UINT8 0x33
        Attribute 0x0204
                Bool True
        Attribute 0x0205
                Bool True
        Attribute 0x0206
                Sequence
                        Sequence
                                UINT8 0x22
                                Data 05 01 09 02 a1 01 85 02 09 01 a1 00 05
09 19 01 29 08 15 00 25 01 75 01 95 08 81 02 05 01 09 30 09 31 16 01 f8 26
ff 07 75 0c 95 02 81 06 09 38 15 81 25 7f 75 08 95 01 81 06 05 0c 0a 38 02
81 06 05 09 19 09 29 0f 15 00 25 01 95 08 75 01 81 02 c0 c0 05 01 09 06 a1
01 85 01 75 01 95 08 05 07 19 e0 29 e7 15 00 25 01 81 02 95 01 75 08 81 03
95 05 75 01 05 08 19 01 29 05 91 02 95 01 75 03 91 03 95 06 75 08 15 00 26
ff 00 05 07 19 00 29 ff 81 00 c0 05 0c 09 01 a1 01 85 03 75 10 95 02 15 01
26 ff 02 19 01 2a ff 02 81 60 c0 05 0c 09 01 a1 01 85 ac 05 01 09 06 a1 02
05 06 09 20 15 00 25 ff 75 08 95 01 81 02 c0 c0 05 01 09 80 a1 01 85 04 15
00 25 01 75 01 95 01 09 82 81 02 95 01 75 07 81 03 c0 05 0c 09 01 a1 01 85
ad 05 01 09 06 a1 02 06 00 ff 25 01 75 01 95 02 0a 03 fe 0a 04 fe 81 02 95
06 81 03 c0 c0 05 0c 09 01 a1 01 85 ff 05 06 95 01 75 02 19 24 29 26 81 02
75 06 81 01 c0 06 00 ff 09 01 a1 01 85 10 75 08 95 06 15 00 26 ff 00 09 01
81 00 09 01 91 00 c0 00
        Attribute 0x0207
                Sequence
                        Sequence
                                UINT16 0x0409
                                UINT16 0x0100
        Attribute 0x020b
                UINT16 0x0100
        Attribute 0x020c
                UINT16 0x0c80
        Attribute 0x020d
                Bool True
        Attribute 0x020e
                Bool True
Sequence
        Attribute 0x0000 - ServiceRecordHandle
                UINT32 0x00010001
        Attribute 0x0001 - ServiceClassIDList
                Sequence
                        UUID16 0x1200 - PnPInformation
        Attribute 0x0004 - ProtocolDescriptorList
                Sequence
                        Sequence
                                UUID16 0x0100 - L2CAP
                                UINT16 0x0001
                        Sequence
                                UUID16 0x0001 - SDP
        Attribute 0x0009 - BluetoothProfileDescriptorList
                Sequence
                        Sequence
                                UUID16 0x1200 - PnPInformation
                                UINT16 0x0100
        Attribute 0x0200
                UINT16 0x0100
        Attribute 0x0201
                UINT16 0x046d
        Attribute 0x0202
                UINT16 0xb309
        Attribute 0x0203
                UINT16 0x011b
        Attribute 0x0204
                Bool True
        Attribute 0x0205
                UINT16 0x0002


HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
  0000: 67 20 76 61 07 00 40 25  00 01                    g va..@%..
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
  0000: 67 20 76 61 07 00 01                              g va...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 09 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 0b 00 67 20 76 61 07  00 01 00                 ...g va....
< ACL data: handle 11 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  0000: 0b 00                                             ..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1b 04                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 0b 00 0f 00                                       ....
> HCI Event: Read Remote Supported Features (0x0b) plen 11
  0000: 00 0b 00 bc 02 04 38 08  00 00 00                 ......8....
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 0b 00                                 ......
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
  0000: 0b 00 18 cc                                       ....
> HCI Event: Command Status (0x0f) plen 4
  0000: 12 01 0f 04                                       ....
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 67 20 76 61 07 00 02 00  00 00                    g va......
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0004
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 01 00                                    .....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 67 20 76 61 07 00 00                           .g va...
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 17 scid 0x0064
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0064 result 0 status 0
      Connection successful
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 185
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0064 flags 0x00 result 0 clen 4
      Success
      MTU 185
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0064 flags 0x00 clen 0
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 67 20 76 61 07 00 4c  6f 67 69 74 65 63 68 20  .g va..Logitech
  0010: 64 69 4e 6f 76 6f 20 45  64 67 65 00 00 00 00 00  diNovo Edge.....
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  ................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00     ...............
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 185
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x0065
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0065 result 0 status 0
      Connection successful
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 04 00                                    .....
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 185
< ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0065 flags 0x00 result 0 clen 4
      Success
      MTU 185
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0065 flags 0x00 clen 0
> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 185
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
  0000: 0b 00 01                                          ...
> HCI Event: QoS Setup Complete (0x0d) plen 21
  0000: 00 0b 00 00 01 52 03 00  00 00 00 00 00 20 4e 00  .....R....... N.
  0010: 00 ff ff ff ff                                    .....
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 19]
      HIDP: Data: Input report
      0000: 10 00 4b 01 00 00 00                              ..K....
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Input report
      0000: 01 00 00 2c 00 00 00 00  00                       ...,.....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 13 04                                       ....
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 19]
      HIDP: Data: Input report
      0000: 01 00 00 00 00 00 00 00  00                       .........
> HCI Event: Encrypt Change (0x08) plen 4
  0000: 05 0b 00 00                                       ....
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 0b 00 02 12 00                                 ......
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
  0000: 0b 00 01                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 13 04                                       ....
> HCI Event: Encrypt Change (0x08) plen 4
  0000: 05 0b 00 00                                       ....
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
< HCI Command: Set Connection Encryption (0x01|0x0013) plen 3
  0000: 0b 00 01                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 13 04                                       ....
> HCI Event: Encrypt Change (0x08) plen 4
  0000: 05 0b 00 00                                       ....
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0064 scid 0x0040
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0065 scid 0x0041
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0064 scid 0x0040
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0065 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 0b 00 02 00                                    .....
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 0b 00 00 00 00                                 ......
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 0b 00 02 6c 00                                 ....l.
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 0b 00 13                                          ...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Mode Change (0x14) plen 6
  0000: 00 0b 00 00 00 00                                 ......
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 0b 00 16                                       ....


On Thu, Apr 24, 2008 at 2:57 PM, Claudio Takahasi <
claudio.takahasi@openbossa.org> wrote:

> On Fri, Apr 18, 2008 at 7:11 PM, Unai Uribarri <unaiur@gmail.com> wrote:
> > Ohh, this dongle works in Windows because the driver disables the
> encription
> > for HID devices.
> >
> > So spying Windows drivers is no solution.
> >
> >
> >
> >
> > On Fri, Apr 18, 2008 at 11:45 PM, Unai Uribarri <unaiur@gmail.com>
> wrote:
> >
> > > Hello folks,
> > >
> > > I have a Sony Ericsson K800i phone, which I use as a remote control for
> my
> > Linux media center, using a bluetooth 1.1 CSR dongle.
> > >
> > > But using a Belkin F8T013, a Bluetooth 2.0 USB dongle, the phone can't
> > connect to any computer running Linux, neither in an Pentium 4 running
> > Ubuntu 07.10 nor a PowerPC G4 running Ubuntu 08.04. I get the following
> > output on the console:
> > >
> > > hcid[7355]: link_key_request (sba=00:0A:3A:6E:0A:C7,
> > dba=00:1D:28:2D:39:33)
> > > input[7358]: Incoming connection on PSM 17
> > > input[7358]: Incoming connection on PSM 19
> > > hcid[7355]: /org/bluez: org.bluez.Database.RequestAuthorization()
> > > input[7358]: Link encryption failed: Input/output error (5)
> > >
> > > If I strace the input daemon, I get the following output:
> > >
> > > poll([{fd=5, events=POLLIN, revents=POLLIN}, {fd=6, events=POLLIN},
> {fd=4,
> > events=POLLIN}], 3, -1) = 1
> > > accept(5, {sa_family=AF_BLUETOOTH,
> > sa_data="\21\00039-(\35\0\1#\371\244\0\0"}, [10]) = 7
> > > getsockname(7, {sa_family=AF_BLUETOOTH,
> > sa_data="\21\0\307\nn:\n\00039-(\35\0"}, [10]) = 0
> > > time(NULL)                              = 1208554156
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > writev(2, [{"input[7358]: Incoming connection on PSM 17", 42}, {"\n",
> 1}],
> > 2) = 43
> > > send(3, "<31>Apr 18 23:29:16 input[7358]: Incoming connection on PSM
> 17",
> > 62, MSG_NOSIGNAL) = 62
> > > poll([{fd=6, events=POLLIN, revents=POLLIN}, {fd=4, events=POLLIN},
> {fd=5,
> > events=POLLIN}], 3, -1) = 1
> > > accept(6, {sa_family=AF_BLUETOOTH,
> > sa_data="\23\00039-(\35\0\30v\5\10\10\0"}, [10]) = 8
> > > getsockname(8, {sa_family=AF_BLUETOOTH,
> > sa_data="\23\0\307\nn:\n\00039-(\35\0"}, [10]) = 0
> > > time(NULL)                              = 1208554156
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > writev(2, [{"input[7358]: Incoming connection on PSM 19", 42}, {"\n",
> 1}],
> > 2) = 43
> > > send(3, "<31>Apr 18 23:29:16 input[7358]: Incoming connection on PSM
> 19",
> > 62, MSG_NOSIGNAL) = 62
> > > gettimeofday({1208554156, 773967}, NULL) = 0
> > > writev(4,
> >
> [{"l\1\0\1\35\0\0\0\17\0\0\0x\0\0\0\1\1o\0\n\0\0\0/org/bluez\0\0\0\0\0\0\6\1s\0\t\0\0\0org.bluez\0\0\0\0\0\0\0\2\1s\0\22\0\0\0org.bluez.Database\0\0\0\0\0\0\3\1s\0"...,
> > 136}, {"\21\0\0\00000:1D:28:2D:39:33\0\0\0\0\0\0\0\0", 29}], 2) = 165
> > > gettimeofday({1208554156, 774555}, NULL) = 0
> > > poll([{fd=4, events=POLLIN, revents=POLLIN}, {fd=5, events=POLLIN},
> {fd=6,
> > events=POLLIN}], 3, 25000) = 1
> > > gettimeofday({1208554156, 776093}, NULL) = 0
> > > read(4,
> >
> "l\2\1\1\0\0\0\0\365\0\0\0\'\0\0\0\6\1s\0\6\0\0\0:1.569\0\0\5\1u\0\17\0\0\0\7\1s\0\6\0\0\0:1.568\0\0",
> > 2048) = 56
> > > read(4, 0x8059f78, 2048)                = -1 EAGAIN (Resource
> temporarily
> > unavailable)
> > > gettimeofday({1208554156, 776764}, NULL) = 0
> > > gettimeofday({1208554156, 776957}, NULL) = 0
> > > gettimeofday({1208554156, 777150}, NULL) = 0
> > > poll([{fd=5, events=POLLIN}, {fd=6, events=POLLIN}, {fd=4,
> > events=POLLIN}], 3, 0) = 0
> > > socket(PF_BLUETOOTH, SOCK_RAW, 6)       = 9
> > > open("/var/lib/bluetooth/00:0A:3A:6E:0A:C7/input", O_RDONLY) = 10
> > > flock(10, LOCK_SH)                      = 0
> > > fstat64(10, {st_mode=S_IFREG|0644, st_size=290, ...}) = 0
> > > mmap2(NULL, 290, PROT_READ, MAP_SHARED, 10, 0) = 0xb7f6f000
> > > munmap(0xb7f6f000, 290)                 = 0
> > > flock(10, LOCK_UN)                      = 0
> > > close(10)                               = 0
> > > open("/var/lib/bluetooth/00:0A:3A:6E:0A:C7/linkkeys", O_RDONLY) = 10
> > > flock(10, LOCK_SH)                      = 0
> > > fstat64(10, {st_mode=S_IFREG|0600, st_size=55, ...}) = 0
> > > mmap2(NULL, 55, PROT_READ, MAP_SHARED, 10, 0) = 0xb7f6f000
> > > munmap(0xb7f6f000, 55)                  = 0
> > > flock(10, LOCK_UN)                      = 0
> > > close(10)                               = 0
> > > socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
> > > ioctl(10, 0x800448d2, 0x805cbc0)        = 0
> > > ioctl(10, 0x800448d3, 0xbf9c561c)       = 0
> > > close(10)                               = 0
> > > socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
> > > bind(10, {sa_family=AF_BLUETOOTH,
> > sa_data="\0\0CW\234\277Vg\234\277h\206\5\10"}, 4) = 0
> > > ioctl(10, 0x800448d5, 0x8058668)        = 0
> > > getsockopt(10, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333",
> > [16]) = 0
> > > setsockopt(10, SOL_IP, IP_TTL, "\20\0\0\0@\300\0\0\0\0\0\0\21\4\0\0",
> 16)
> > = 0
> > > writev(10, [{"\1", 1}, {"\21\4\2", 3}, {"\v\0", 2}], 3) = 6
> > > poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 1000) = 1
> > > read(10, "\4\17\4\0\1\21\4", 260)       = 7
> > > poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 990) = 1
> > > read(10, "\4\6\3\0\v\0", 260)           = 6
> > > setsockopt(10, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333",
> 16)
> > = 0
> > > getsockopt(10, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333",
> > [16]) = 0
> > > setsockopt(10, SOL_IP, IP_TTL, "\20\0\0\0\0\301\0\0\0\0\0\0\23\4\0\0",
> 16)
> > = 0
> > > writev(10, [{"\1", 1}, {"\23\4\3", 3}, {"\v\0\1", 3}], 3) = 7
> > > poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 1000) = 1
> > > read(10, "\4\17\4\0\1\23\4", 260)       = 7
> > > poll([{fd=10, events=POLLIN, revents=POLLIN}], 1, 990) = 1
> > > read(10, "\4\10\4$\v\0\0", 260)         = 7
> > > setsockopt(10, SOL_IP, IP_TTL, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\362\333",
> 16)
> > = 0
> > > time(NULL)                              = 1208554156
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=946, ...}) = 0
> > > writev(2, [{"input[7358]: Link encryption failed: Input/output error
> (5)",
> > 59}, {"\n", 1}], 2) = 60
> > > send(3, "<27>Apr 18 23:29:16 input[7358]: Link encryption failed:
> > Input/output error (5)", 79, MSG_NOSIGNAL) = 79
> > > close(10)                               = 0
> > > close(9)                                = 0
> > > close(7)                                = 0
> > > close(8)                                = 0
> > >
> > > The interesting part is this line:
> > >
> > > read(10, "\4\10\4$\v\0\0", 260)         = 7
> > >
> > > $ (0x24) is the error code; LMP PDU Not Allowed.
> > >
> > > I can use this dongle in Windows without problem. Does anyone know how
> to
> > spy Windows? Any other idea?
> > >
> > > Thanks.
> > >
> > >
> >
> >
> > -------------------------------------------------------------------------
> >  This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
> >  Don't miss this year's exciting event. There's still time to save $100.
> >  Use priority code J8TL2D2.
> >
> >
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> > _______________________________________________
> >  Bluez-users mailing list
> >  Bluez-users@lists.sourceforge.net
> >  https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
>
> Hi Unai,
>
> Please send the hcidump log(run hcidump -X) and the sdp record of your
> phone(run sdptool browse --raw --l2cap xx:xx:xx:xx:xx:xx)
>
> Weird, according to the code encryption is applied for keyboard subclass
> only.
>
>
> Regards,
> --
> --
> Claudio Takahasi
> Instituto Nokia de Tecnologia
> Recife - Pernambuco - Brasil
> +55 81 30879999
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
> Don't miss this year's exciting event. There's still time to save $100.
> Use priority code J8TL2D2.
>
> http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_10077_30873011.1215354798326
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,<br><br>I have bought a Logitech keyboard and the bt dongle doesn&#39=
;t want to encrypt any communication still.<br><br>sdptool browse --raw --l=
2cap xx:xx:xx:xx:xx:xx (Logitech keyboard)<br><br>Sequence<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0000 - ServiceRecordHandle<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; UINT32 0x00010000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Attribute 0x0001 - ServiceClassIDList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x112=
4 - HumanInterfaceDeviceService (HID)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Attribute 0x0004 - ProtocolDescriptorList<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x=
0100 - L2CAP<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0011<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x0011 - HIDP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0005 - BrowseGroupLi=
st<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; UUID16 0x1002 - PublicBrowseGroup<br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0006 - LanguageBaseAttributeIDList<=
br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x65=
6e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT1=
6 0x006a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 UINT16 0x0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x00=
09 - BluetoothProfileDescriptorList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x1124 - HumanInterfaceDeviceSe=
rvice (HID)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0100<br>&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x000d - AdditionalProtocolD=
escriptorLists<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x0100 -=
 L2CAP<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; UINT16 0x0013<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; S=
equence<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; UUID16 0x0011 - HIDP<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; Attribute 0x0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String Logitech Bluetooth Wireless Ke=
yboard&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0101<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; String Keyboard=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0102<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; String Logitech<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute=
 0x0200<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; Attribute 0x0201<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0111<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0202<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT8 =
0x40<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0203<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; UINT8 0x33<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x02=
04<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Bool True<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; Attribute 0x0205<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bool True<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Attribute 0x0206<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT8 0x22<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; Data 05 01 09 02 a1 01 85 02 09 01 a1 00 05 09 19 01 29 08 15=
 00 25 01 75 01 95 08 81 02 05 01 09 30 09 31 16 01 f8 26 ff 07 75 0c 95 02=
 81 06 09 38 15 81 25 7f 75 08 95 01 81 06 05 0c 0a 38 02 81 06 05 09 19 09=
 29 0f 15 00 25 01 95 08 75 01 81 02 c0 c0 05 01 09 06 a1 01 85 01 75 01 95=
 08 05 07 19 e0 29 e7 15 00 25 01 81 02 95 01 75 08 81 03 95 05 75 01 05 08=
 19 01 29 05 91 02 95 01 75 03 91 03 95 06 75 08 15 00 26 ff 00 05 07 19 00=
 29 ff 81 00 c0 05 0c 09 01 a1 01 85 03 75 10 95 02 15 01 26 ff 02 19 01 2a=
 ff 02 81 60 c0 05 0c 09 01 a1 01 85 ac 05 01 09 06 a1 02 05 06 09 20 15 00=
 25 ff 75 08 95 01 81 02 c0 c0 05 01 09 80 a1 01 85 04 15 00 25 01 75 01 95=
 01 09 82 81 02 95 01 75 07 81 03 c0 05 0c 09 01 a1 01 85 ad 05 01 09 06 a1=
 02 06 00 ff 25 01 75 01 95 02 0a 03 fe 0a 04 fe 81 02 95 06 81 03 c0 c0 05=
 0c 09 01 a1 01 85 ff 05 06 95 01 75 02 19 24 29 26 81 02 75 06 81 01 c0 06=
 00 ff 09 01 a1 01 85 10 75 08 95 06 15 00 26 ff 00 09 01 81 00 09 01 91 00=
 c0 00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0207<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0409<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; Attribute 0x020b<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x020c<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; UINT16 0x0c80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0=
x020d<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; Bool True<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; Attribute 0x020e<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bool True<br>Sequence<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0000 - ServiceRecordHandle<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; UINT32 0x00010001<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; Attribute 0x0001 - ServiceClassIDList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x120=
0 - PnPInformation<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute =
0x0004 - ProtocolDescriptorList<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x=
0100 - L2CAP<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x0001<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UUID16 0x0001 - SDP<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0009 - BluetoothProf=
ileDescriptorList<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sequence<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; UUID16 0x1200 - PnPInformation<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; UINT16 0x0100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0200<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; UINT16 0x0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0=
x0201<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0x046d<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; Attribute 0x0202<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0xb309<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0203<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UINT16 0=
x011b<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x0204<br>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; Bool True<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Attribute 0x020=
5<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; UINT16 0x0002<br><br><br>HCI sniffer - Bluetooth packe=
t analyzer ver 1.40<br>device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>&nbsp; 0000: 67 20 76 61 =
07 00 40 25&nbsp; 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g va..@%..<b=
r>&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>&nbsp=
; 0000: 67 20 76 61 07 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g va...<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 0000: 00 01 09 04&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ....<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp; 0000: 00=
 0b 00 67 20 76 61 07&nbsp; 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...g va....<br>
&lt; ACL data: handle 11 flags 0x02 dlen 10<br>&nbsp;&nbsp;&nbsp; L2CAP(s):=
 Info req: type 2<br>&lt; HCI Command: Read Remote Supported Features (0x01=
|0x001b) plen 2<br>&nbsp; 0000: 0b 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; ..<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 1b 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&lt; HCI Command: Write Link Policy Set=
tings (0x02|0x000d) plen 4<br>&nbsp; 0000: 0b 00 0f 00&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&gt; HCI =
Event: Read Remote Supported Features (0x0b) plen 11<br>
&nbsp; 0000: 00 0b 00 bc 02 04 38 08&nbsp; 00 00 00&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ..=
....8....<br>&gt; HCI Event: Command Complete (0x0e) plen 6<br>&nbsp; 0000:=
 01 0d 08 00 0b 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>&lt;=
 HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&nbsp; 0000: 0b 00 18 cc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&gt; HCI Event: Command Status (0x0f) p=
len 4<br>&nbsp; 0000: 12 01 0f 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&lt; HCI Command: Remote Name =
Request (0x01|0x0019) plen 10<br>
&nbsp; 0000: 67 20 76 61 07 00 02 00&nbsp; 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; g va......<br>&gt; ACL data: handle 11 flags 0x02 dlen 16<br>&=
nbsp;&nbsp;&nbsp; L2CAP(s): Info rsp: type 2 result 0<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; Extended feature mask 0x0004<br>&gt; HCI Event: Command Status=
 (0x0f) plen 4<br>
&nbsp; 0000: 00 01 19 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&gt; HCI Event: Number of Completed Pac=
kets (0x13) plen 5<br>&nbsp; 0000: 01 0b 00 01 00&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>&gt; HCI Event: Role Change (0x=
12) plen 8<br>
&nbsp; 0000: 00 67 20 76 61 07 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .g va...<br>&gt; ACL data: handl=
e 11 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 17=
 scid 0x0064<br>&lt; ACL data: handle 11 flags 0x02 dlen 16<br>&nbsp;&nbsp;=
&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0064 result 0 status 0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection successful<br>&gt; ACL data: hand=
le 11 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0=
x0040 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 185<br>&lt; A=
CL data: handle 11 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Confi=
g rsp: scid 0x0064 flags 0x00 result 0 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MT=
U 185<br>&lt; ACL data: handle 11 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; =
L2CAP(s): Config req: dcid 0x0064 flags 0x00 clen 0<br>&gt; HCI Event: Remo=
te Name Req Complete (0x07) plen 255<br>&nbsp; 0000: 00 67 20 76 61 07 00 4=
c&nbsp; 6f 67 69 74 65 63 68 20&nbsp; .g va..Logitech<br>
&nbsp; 0010: 64 69 4e 6f 76 6f 20 45&nbsp; 64 67 65 00 00 00 00 00&nbsp; di=
Novo Edge.....<br>&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00=
 00 00 00&nbsp; ................<br>&nbsp; 0030: 00 00 00 00 00 00 00 00&nb=
sp; 00 00 00 00 00 00 00 00&nbsp; ................<br>
&nbsp; 0040: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ..=
..............<br>&nbsp; 0050: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00=
 00 00 00&nbsp; ................<br>&nbsp; 0060: 00 00 00 00 00 00 00 00&nb=
sp; 00 00 00 00 00 00 00 00&nbsp; ................<br>
&nbsp; 0070: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ..=
..............<br>&nbsp; 0080: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00=
 00 00 00&nbsp; ................<br>&nbsp; 0090: 00 00 00 00 00 00 00 00&nb=
sp; 00 00 00 00 00 00 00 00&nbsp; ................<br>
&nbsp; 00a0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ..=
..............<br>&nbsp; 00b0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00=
 00 00 00&nbsp; ................<br>&nbsp; 00c0: 00 00 00 00 00 00 00 00&nb=
sp; 00 00 00 00 00 00 00 00&nbsp; ................<br>
&nbsp; 00d0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp; ..=
..............<br>&nbsp; 00e0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00=
 00 00 00&nbsp; ................<br>&nbsp; 00f0: 00 00 00 00 00 00 00 00&nb=
sp; 00 00 00 00 00 00 00&nbsp;&nbsp;&nbsp;&nbsp; ...............<br>
&gt; ACL data: handle 11 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(s):=
 Config rsp: scid 0x0040 flags 0x00 result 0 clen 4<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU 185<br>&gt; ACL da=
ta: handle 11 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Connect re=
q: psm 19 scid 0x0065<br>
&lt; ACL data: handle 11 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s):=
 Connect rsp: dcid 0x0041 scid 0x0065 result 0 status 0<br>&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; Connection successful<br>&gt; HCI Event: Number of Completed=
 Packets (0x13) plen 5<br>&nbsp; 0000: 01 0b 00 04 00&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .....<br>
&gt; ACL data: handle 11 flags 0x02 dlen 16<br>&nbsp;&nbsp;&nbsp; L2CAP(s):=
 Config req: dcid 0x0041 flags 0x00 clen 4<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; MTU 185<br>&lt; ACL data: handle 11 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nb=
sp; L2CAP(s): Config rsp: scid 0x0065 flags 0x00 result 0 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MT=
U 185<br>&lt; ACL data: handle 11 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; =
L2CAP(s): Config req: dcid 0x0065 flags 0x00 clen 0<br>&gt; ACL data: handl=
e 11 flags 0x02 dlen 18<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x=
0041 flags 0x00 result 0 clen 4<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MT=
U 185<br>&lt; HCI Command: Set Connection Encryption (0x01|0x0013) plen 3<b=
r>&nbsp; 0000: 0b 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>&gt; HCI Event: QoS Set=
up Complete (0x0d) plen 21<br>&nbsp; 0000: 00 0b 00 00 01 52 03 00&nbsp; 00=
 00 00 00 00 20 4e 00&nbsp; .....R....... N.<br>
&nbsp; 0010: 00 ff ff ff ff&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; .....<br>&gt; ACL data: handle 11 flags 0x02 dlen 12<br>&nbsp;=
&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 8 [psm 19]<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; HIDP: Data: Input report<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 10=
 00 4b 01 00 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ..K....<br>
&gt; ACL data: handle 11 flags 0x02 dlen 14<br>&nbsp;&nbsp;&nbsp; L2CAP(d):=
 cid 0x0041 len 10 [psm 19]<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HIDP: Data: I=
nput report<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0000: 01 00 00 2c 00 00 00 00=
&nbsp; 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...,....=
.<br>&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 13 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>&gt; ACL data: handle 11 flags 0x02 dle=
n 14<br>&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0041 len 10 [psm 19]<br>&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; HIDP: Data: Input report<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 0000: 01 00 00 00 00 00 00 00&nbsp; 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .........<br>
&gt; HCI Event: Encrypt Change (0x08) plen 4<br>&nbsp; 0000: 05 0b 00 00&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ....<br>&gt; HCI Event: Mode Change (0x14) plen 6<br>&nbsp; 0000: 00 0b 00=
 02 12 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&lt; HCI Command: Set Connection Encryption (0x01|0x0013) plen 3<br>&nbsp; =
0000: 0b 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>&gt; HCI Event: Command Status (=
0x0f) plen 4<br>&nbsp; 0000: 00 01 13 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Encrypt Change (0x08) plen 4<br>&nbsp; 0000: 05 0b 00 00&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ....<br>&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp=
; 0000: 01 0b 00 02 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; .....<br>
&lt; HCI Command: Set Connection Encryption (0x01|0x0013) plen 3<br>&nbsp; =
0000: 0b 00 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>&gt; HCI Event: Command Status (=
0x0f) plen 4<br>&nbsp; 0000: 00 01 13 04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....<br>
&gt; HCI Event: Encrypt Change (0x08) plen 4<br>&nbsp; 0000: 05 0b 00 00&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ....<br>&lt; ACL data: handle 11 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; =
L2CAP(s): Disconn req: dcid 0x0064 scid 0x0040<br>&lt; ACL data: handle 11 =
flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid 0x0065 scid 0x0041<br>&gt; A=
CL data: handle 11 flags 0x02 dlen 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disco=
nn rsp: dcid 0x0064 scid 0x0040<br>&gt; ACL data: handle 11 flags 0x02 dlen=
 12<br>&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid 0x0065 scid 0x0041<br=
>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>&nbsp; 0000: 0=
1 0b 00 02 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .=
....<br>&gt; HCI Event: Mode Change (0x14) plen 6<br>&nbsp; 0000: 00 0b 00 =
00 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&gt; HCI Event: Mode Change (0x14) plen 6<br>&nbsp; 0000: 00 0b 00 02 6c 00=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ....l.<br>&lt; HCI Command: Disc=
onnect (0x01|0x0006) plen 3<br>&nbsp; 0000: 0b 00 13&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .=
..<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>&nbsp; 0000: 00 01 06 04&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 ....<br>&gt; HCI Event: Mode Change (0x14) plen 6<br>&nbsp; 0000: 00 0b 00=
 00 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ......<br>
&gt; HCI Event: Disconn Complete (0x05) plen 4<br>&nbsp; 0000: 00 0b 00 16&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; ....<br><br><br><div class=3D"gmail_quote">On Thu, Apr 24, 2008 at 2:57 =
PM, Claudio Takahasi &lt;<a href=3D"mailto:claudio.takahasi@openbossa.org">=
claudio.takahasi@openbossa.org</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div class=3D"Wj3C7c">On Fri, Apr 18, 2008 at 7:11 PM, Unai Uribarri &lt;<a =
href=3D"mailto:unaiur@gmail.com">unaiur@gmail.com</a>&gt; wrote:<br>

&gt; Ohh, this dongle works in Windows because the driver disables the encr=
iption<br>
&gt; for HID devices.<br>
&gt;<br>
&gt; So spying Windows drivers is no solution.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Fri, Apr 18, 2008 at 11:45 PM, Unai Uribarri &lt;<a href=3D"mailto:=
unaiur@gmail.com">unaiur@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Hello folks,<br>
&gt; &gt;<br>
&gt; &gt; I have a Sony Ericsson K800i phone, which I use as a remote contr=
ol for my<br>
&gt; Linux media center, using a bluetooth 1.1 CSR dongle.<br>
&gt; &gt;<br>
&gt; &gt; But using a Belkin F8T013, a Bluetooth 2.0 USB dongle, the phone =
can&#39;t<br>
&gt; connect to any computer running Linux, neither in an Pentium 4 running=
<br>
&gt; Ubuntu 07.10 nor a PowerPC G4 running Ubuntu 08.04. I get the followin=
g<br>
&gt; output on the console:<br>
&gt; &gt;<br>
&gt; &gt; hcid[7355]: link_key_request (sba=3D00:0A:3A:6E:0A:C7,<br>
&gt; dba=3D00:1D:28:2D:39:33)<br>
&gt; &gt; input[7358]: Incoming connection on PSM 17<br>
&gt; &gt; input[7358]: Incoming connection on PSM 19<br>
&gt; &gt; hcid[7355]: /org/bluez: org.bluez.Database.RequestAuthorization()=
<br>
&gt; &gt; input[7358]: Link encryption failed: Input/output error (5)<br>
&gt; &gt;<br>
&gt; &gt; If I strace the input daemon, I get the following output:<br>
&gt; &gt;<br>
&gt; &gt; poll([{fd=3D5, events=3DPOLLIN, revents=3DPOLLIN}, {fd=3D6, event=
s=3DPOLLIN}, {fd=3D4,<br>
&gt; events=3DPOLLIN}], 3, -1) =3D 1<br>
&gt; &gt; accept(5, {sa_family=3DAF_BLUETOOTH,<br>
&gt; sa_data=3D&quot;\21\00039-(\35\0\1#\371\244\0\0&quot;}, [10]) =3D 7<br=
>
&gt; &gt; getsockname(7, {sa_family=3DAF_BLUETOOTH,<br>
&gt; sa_data=3D&quot;\21\0\307\nn:\n\00039-(\35\0&quot;}, [10]) =3D 0<br>
&gt; &gt; time(NULL) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D 1208554156<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; writev(2, [{&quot;input[7358]: Incoming connection on PSM 17&quot=
;, 42}, {&quot;\n&quot;, 1}],<br>
&gt; 2) =3D 43<br>
&gt; &gt; send(3, &quot;&lt;31&gt;Apr 18 23:29:16 input[7358]: Incoming con=
nection on PSM 17&quot;,<br>
&gt; 62, MSG_NOSIGNAL) =3D 62<br>
&gt; &gt; poll([{fd=3D6, events=3DPOLLIN, revents=3DPOLLIN}, {fd=3D4, event=
s=3DPOLLIN}, {fd=3D5,<br>
&gt; events=3DPOLLIN}], 3, -1) =3D 1<br>
&gt; &gt; accept(6, {sa_family=3DAF_BLUETOOTH,<br>
&gt; sa_data=3D&quot;\23\00039-(\35\0\30v\5\10\10\0&quot;}, [10]) =3D 8<br>
&gt; &gt; getsockname(8, {sa_family=3DAF_BLUETOOTH,<br>
&gt; sa_data=3D&quot;\23\0\307\nn:\n\00039-(\35\0&quot;}, [10]) =3D 0<br>
&gt; &gt; time(NULL) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D 1208554156<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; writev(2, [{&quot;input[7358]: Incoming connection on PSM 19&quot=
;, 42}, {&quot;\n&quot;, 1}],<br>
&gt; 2) =3D 43<br>
&gt; &gt; send(3, &quot;&lt;31&gt;Apr 18 23:29:16 input[7358]: Incoming con=
nection on PSM 19&quot;,<br>
&gt; 62, MSG_NOSIGNAL) =3D 62<br>
&gt; &gt; gettimeofday({1208554156, 773967}, NULL) =3D 0<br>
&gt; &gt; writev(4,<br>
&gt; [{&quot;l\1\0\1\35\0\0\0\17\0\0\0x\0\0\0\1\1o\0\n\0\0\0/org/bluez\0\0\=
0\0\0\0\6\1s\0\t\0\0\0org.bluez\0\0\0\0\0\0\0\2\1s\0\22\0\0\0org.bluez.Data=
base\0\0\0\0\0\0\3\1s\0&quot;...,<br>
&gt; 136}, {&quot;\21\0\0\00000:1D:28:2D:39:33\0\0\0\0\0\0\0\0&quot;, 29}],=
 2) =3D 165<br>
&gt; &gt; gettimeofday({1208554156, 774555}, NULL) =3D 0<br>
&gt; &gt; poll([{fd=3D4, events=3DPOLLIN, revents=3DPOLLIN}, {fd=3D5, event=
s=3DPOLLIN}, {fd=3D6,<br>
&gt; events=3DPOLLIN}], 3, 25000) =3D 1<br>
&gt; &gt; gettimeofday({1208554156, 776093}, NULL) =3D 0<br>
&gt; &gt; read(4,<br>
&gt; &quot;l\2\1\1\0\0\0\0\365\0\0\0\&#39;\0\0\0\6\1s\0\6\0\0\0:1.569\0\0\5=
\1u\0\17\0\0\0\7\1s\0\6\0\0\0:1.568\0\0&quot;,<br>
&gt; 2048) =3D 56<br>
&gt; &gt; read(4, 0x8059f78, 2048) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;=3D -1 EAGAIN (Resource temporarily<br>
&gt; unavailable)<br>
&gt; &gt; gettimeofday({1208554156, 776764}, NULL) =3D 0<br>
&gt; &gt; gettimeofday({1208554156, 776957}, NULL) =3D 0<br>
&gt; &gt; gettimeofday({1208554156, 777150}, NULL) =3D 0<br>
&gt; &gt; poll([{fd=3D5, events=3DPOLLIN}, {fd=3D6, events=3DPOLLIN}, {fd=
=3D4,<br>
&gt; events=3DPOLLIN}], 3, 0) =3D 0<br>
&gt; &gt; socket(PF_BLUETOOTH, SOCK_RAW, 6) &nbsp; &nbsp; &nbsp; =3D 9<br>
&gt; &gt; open(&quot;/var/lib/bluetooth/00:0A:3A:6E:0A:C7/input&quot;, O_RD=
ONLY) =3D 10<br>
&gt; &gt; flock(10, LOCK_SH) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;=3D 0<br>
&gt; &gt; fstat64(10, {st_mode=3DS_IFREG|0644, st_size=3D290, ...}) =3D 0<b=
r>
&gt; &gt; mmap2(NULL, 290, PROT_READ, MAP_SHARED, 10, 0) =3D 0xb7f6f000<br>
&gt; &gt; munmap(0xb7f6f000, 290) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; =3D 0<br>
&gt; &gt; flock(10, LOCK_UN) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;=3D 0<br>
&gt; &gt; close(10) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D 0<br>
&gt; &gt; open(&quot;/var/lib/bluetooth/00:0A:3A:6E:0A:C7/linkkeys&quot;, O=
_RDONLY) =3D 10<br>
&gt; &gt; flock(10, LOCK_SH) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;=3D 0<br>
&gt; &gt; fstat64(10, {st_mode=3DS_IFREG|0600, st_size=3D55, ...}) =3D 0<br=
>
&gt; &gt; mmap2(NULL, 55, PROT_READ, MAP_SHARED, 10, 0) =3D 0xb7f6f000<br>
&gt; &gt; munmap(0xb7f6f000, 55) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp;=3D 0<br>
&gt; &gt; flock(10, LOCK_UN) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;=3D 0<br>
&gt; &gt; close(10) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D 0<br>
&gt; &gt; socket(PF_BLUETOOTH, SOCK_RAW, 1) &nbsp; &nbsp; &nbsp; =3D 10<br>
&gt; &gt; ioctl(10, 0x800448d2, 0x805cbc0) &nbsp; &nbsp; &nbsp; &nbsp;=3D 0=
<br>
&gt; &gt; ioctl(10, 0x800448d3, 0xbf9c561c) &nbsp; &nbsp; &nbsp; =3D 0<br>
&gt; &gt; close(10) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D 0<br>
&gt; &gt; socket(PF_BLUETOOTH, SOCK_RAW, 1) &nbsp; &nbsp; &nbsp; =3D 10<br>
&gt; &gt; bind(10, {sa_family=3DAF_BLUETOOTH,<br>
&gt; sa_data=3D&quot;\0\0CW\234\277Vg\234\277h\206\5\10&quot;}, 4) =3D 0<br=
>
&gt; &gt; ioctl(10, 0x800448d5, 0x8058668) &nbsp; &nbsp; &nbsp; &nbsp;=3D 0=
<br>
&gt; &gt; getsockopt(10, SOL_IP, IP_TTL, &quot;\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\362\333&quot;,<br>
&gt; [16]) =3D 0<br>
&gt; &gt; setsockopt(10, SOL_IP, IP_TTL, &quot;\20\0\0\0@\300\0\0\0\0\0\0\2=
1\4\0\0&quot;, 16)<br>
&gt; =3D 0<br>
&gt; &gt; writev(10, [{&quot;\1&quot;, 1}, {&quot;\21\4\2&quot;, 3}, {&quot=
;\v\0&quot;, 2}], 3) =3D 6<br>
&gt; &gt; poll([{fd=3D10, events=3DPOLLIN, revents=3DPOLLIN}], 1, 1000) =3D=
 1<br>
&gt; &gt; read(10, &quot;\4\17\4\0\1\21\4&quot;, 260) &nbsp; &nbsp; &nbsp; =
=3D 7<br>
&gt; &gt; poll([{fd=3D10, events=3DPOLLIN, revents=3DPOLLIN}], 1, 990) =3D =
1<br>
&gt; &gt; read(10, &quot;\4\6\3\0\v\0&quot;, 260) &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; =3D 6<br>
&gt; &gt; setsockopt(10, SOL_IP, IP_TTL, &quot;\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\362\333&quot;, 16)<br>
&gt; =3D 0<br>
&gt; &gt; getsockopt(10, SOL_IP, IP_TTL, &quot;\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\362\333&quot;,<br>
&gt; [16]) =3D 0<br>
&gt; &gt; setsockopt(10, SOL_IP, IP_TTL, &quot;\20\0\0\0\0\301\0\0\0\0\0\0\=
23\4\0\0&quot;, 16)<br>
&gt; =3D 0<br>
&gt; &gt; writev(10, [{&quot;\1&quot;, 1}, {&quot;\23\4\3&quot;, 3}, {&quot=
;\v\0\1&quot;, 3}], 3) =3D 7<br>
&gt; &gt; poll([{fd=3D10, events=3DPOLLIN, revents=3DPOLLIN}], 1, 1000) =3D=
 1<br>
&gt; &gt; read(10, &quot;\4\17\4\0\1\23\4&quot;, 260) &nbsp; &nbsp; &nbsp; =
=3D 7<br>
&gt; &gt; poll([{fd=3D10, events=3DPOLLIN, revents=3DPOLLIN}], 1, 990) =3D =
1<br>
&gt; &gt; read(10, &quot;\4\10\4$\v\0\0&quot;, 260) &nbsp; &nbsp; &nbsp; &n=
bsp; =3D 7<br>
&gt; &gt; setsockopt(10, SOL_IP, IP_TTL, &quot;\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
\362\333&quot;, 16)<br>
&gt; =3D 0<br>
&gt; &gt; time(NULL) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D 1208554156<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; stat64(&quot;/etc/localtime&quot;, {st_mode=3DS_IFREG|0644, st_si=
ze=3D946, ...}) =3D 0<br>
&gt; &gt; writev(2, [{&quot;input[7358]: Link encryption failed: Input/outp=
ut error (5)&quot;,<br>
&gt; 59}, {&quot;\n&quot;, 1}], 2) =3D 60<br>
&gt; &gt; send(3, &quot;&lt;27&gt;Apr 18 23:29:16 input[7358]: Link encrypt=
ion failed:<br>
&gt; Input/output error (5)&quot;, 79, MSG_NOSIGNAL) =3D 79<br>
&gt; &gt; close(10) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =3D 0<br>
&gt; &gt; close(9) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D 0<br>
&gt; &gt; close(7) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D 0<br>
&gt; &gt; close(8) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=3D 0<br>
&gt; &gt;<br>
&gt; &gt; The interesting part is this line:<br>
&gt; &gt;<br>
&gt; &gt; read(10, &quot;\4\10\4$\v\0\0&quot;, 260) &nbsp; &nbsp; &nbsp; &n=
bsp; =3D 7<br>
&gt; &gt;<br>
&gt; &gt; $ (0x24) is the error code; LMP PDU Not Allowed.<br>
&gt; &gt;<br>
&gt; &gt; I can use this dongle in Windows without problem. Does anyone kno=
w how to<br>
&gt; spy Windows? Any other idea?<br>
&gt; &gt;<br>
&gt; &gt; Thanks.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
</div></div>&gt; ----------------------------------------------------------=
---------------<br>
&gt; &nbsp;This SF.net email is sponsored by the 2008 JavaOne(SM) Conferenc=
e<br>
&gt; &nbsp;Don&#39;t miss this year&#39;s exciting event. There&#39;s still=
 time to save $100.<br>
&gt; &nbsp;Use priority code J8TL2D2.<br>
&gt;<br>
&gt; <a href=3D"http://ad.doubleclick.net/clk;198757673;13503038;p?http://j=
ava.sun.com/javaone" target=3D"_blank">http://ad.doubleclick.net/clk;198757=
673;13503038;p?http://java.sun.com/javaone</a><br>
&gt; _______________________________________________<br>
&gt; &nbsp;Bluez-users mailing list<br>
&gt; &nbsp;<a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users=
@lists.sourceforge.net</a><br>
&gt; &nbsp;<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-us=
ers" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-u=
sers</a><br>
&gt;<br>
&gt;<br>
<br>
Hi Unai,<br>
<br>
Please send the hcidump log(run hcidump -X) and the sdp record of your<br>
phone(run sdptool browse --raw --l2cap xx:xx:xx:xx:xx:xx)<br>
<br>
Weird, according to the code encryption is applied for keyboard subclass on=
ly.<br>
<br>
<br>
Regards,<br>
--<br>
--<br>
Claudio Takahasi<br>
Instituto Nokia de Tecnologia<br>
Recife - Pernambuco - Brasil<br>
+55 81 30879999<br>
<br>
-------------------------------------------------------------------------<b=
r>
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference<br>
Don&#39;t miss this year&#39;s exciting event. There&#39;s still time to sa=
ve $100.<br>
Use priority code J8TL2D2.<br>
<a href=3D"http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.s=
un.com/javaone" target=3D"_blank">http://ad.doubleclick.net/clk;198757673;1=
3503038;p?http://java.sun.com/javaone</a><br>
_______________________________________________<br>
Bluez-users mailing list<br>
<a href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sour=
ceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br=
>
</blockquote></div><br>

------=_Part_10077_30873011.1215354798326--


--===============0227526734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--===============0227526734==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0227526734==--
