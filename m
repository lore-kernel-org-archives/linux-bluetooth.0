Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <464A2954.2080006@gmail.com>
Date: Wed, 16 May 2007 00:42:44 +0300
From: bhairava <bhairavah@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] asus btd-202 - nokia n 73 on a debian 4.0 with
	2.6.21.1 kernel
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

hi.

problem:

dongle asus BTD-202
nokia n73
debian 4.0
kernel 2.6.21.1

inserting the dongle i get this:

usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice

hciconfig confirms i found it:

hci0:   Type: USB
        BD Address: 00:0B:0D:4C:AB:C3 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN
        RX bytes:44955 acl:671 sco:0 events:1451 errors:0
        TX bytes:20242 acl:717 sco:0 commands:494 errors:0

hcitool scan finds the phone

Scanning ...
        00:18:C5:38:AF:D1       Bhairava

Restarting bluetooth: hcid sdpd rfcomm. - i get no error



bhairava:/etc/bluetooth# cat /etc/bluetooth/hcid.conf
options {
        autoinit yes;
        security auto;
        pairing multi;
        passkey "1234";
}
device {
        name "bhairava";
        class 0x3e0100;
        iscan enable; pscan enable;
        lm accept;
        lp rswitch,hold,sniff,park;
}

so, i try getting some photos from the phone:

bhairava:/etc/bluetooth# obexftp -b '00:18:C5:38:AF:D1' -l C:
Browsing 00:18:C5:38:AF:D1 ...
Channel: 11
Connecting...

THIS is the moment i get a prompt on the phone, asking me to input the 
"passcode for bhairava"
i enter 1234. three times. i get

Connecting...failed: connect
Still trying to connect
Connecting...failed: connect
Still trying to connect
Connecting...failed: connect
Still trying to connect

the conversation is seen by hcidump as:


bhairava:~# hcidump -a
HCI sniffer - Bluetooth packet analyzer ver 1.32
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
  . . 8 . . . . . . . . . .
 > HCI Event: Command Status (0x0f) plen 4
  . . . .
 > HCI Event: Connect Complete (0x03) plen 11
  . . . . . 8 . . . . .
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
  . .
 > HCI Event: Command Status (0x0f) plen 4
  . . . .
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  . . . .
 > HCI Event: Read Remote Supported Features (0x0b) plen 11
  . . . . . . F . . . .
 > HCI Event: Command Complete (0x0e) plen 6
  . . . . . .
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  . . 8 . . . . . . .
 > HCI Event: Command Status (0x0f) plen 4
  . . . .
 > HCI Event: Max Slots Change (0x1b) plen 3
  . . .
 > ACL data: handle 12 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Info rsp: type 2 result 1
      Not supported
 > ACL data: handle 12 flags 0x02 dlen 28
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
 > HCI Event: Remote Name Req Complete (0x07) plen 255
  . . . 8 . . . B h a i r a v a . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . . . . . . .
  . . . . . . . . . . . . . . .
 > ACL data: handle 12 flags 0x02 dlen 17
 > ACL data: handle 12 flags 0x01 dlen 9
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 12 flags 0x02 dlen 22
    L2CAP(d): cid 0x0040 len 18 [psm 1]
        SDP SSA Req: tid 0x0 len 0xd
          pat uuid-16 0x1106 (OBEXObjTrnsf)
          max 65535
          aid(s) 0x0004 (ProtocolDescList)
          cont 00
 > HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . .
 > ACL data: handle 12 flags 0x02 dlen 38
    L2CAP(d): cid 0x0040 len 34 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x1d
          count 26
          record #0
              aid 0x0004 (ProtocolDescList)
                 < < uuid-16 0x0100 (L2CAP) > <
                 uuid-16 0x0003 (RFCOMM) uint 0xb > <
                 uuid-16 0x0008 (OBEX) > >
          cont 00
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
 > ACL data: handle 12 flags 0x02 dlen 36
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x0041 result 0 status 0
      Connection successful
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 4
      MTU 1013
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 672
 > HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . .
 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 22 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 22 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 22 pf 1 ilen 0 fcs 0xb8
 > HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . .
 > HCI Event: PIN Code Request (0x16) plen 6
  . . 8 . . .
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  . . 8 . . .
 > HCI Event: Command Complete (0x0e) plen 10
  . . . . . . 8 . . .
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 22 pf 1 ilen 0 fcs 0x92
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0041 scid 0x0041
 > ACL data: handle 12 flags 0x02 dlen 36
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
    L2CAP(s): Connect rsp: dcid 0x0042 scid 0x0040 result 0 status 0
      Connection successful
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0042 flags 0x00 clen 4
      MTU 1013
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0042 flags 0x00 result 0 clen 4
      Success
      MTU 672
 > HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . .
 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0042 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 22 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0040 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 22 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 22 pf 1 ilen 0 fcs 0xb8
 > HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . .
 > HCI Event: PIN Code Request (0x16) plen 6
  . . 8 . . .
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  . . 8 . . .
 > HCI Event: Command Complete (0x0e) plen 10
  . . . . . . 8 . . .
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 22 pf 1 ilen 0 fcs 0x92
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0042 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0042 scid 0x0040
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0041
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0040 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0042 scid 0x0040
 > ACL data: handle 12 flags 0x02 dlen 36
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 1 status 2
      Connection pending - Authorization pending
    L2CAP(s): Connect rsp: dcid 0x0043 scid 0x0041 result 0 status 0
      Connection successful
    L2CAP(s): Config req: dcid 0x0041 flags 0x00 clen 0
< ACL data: handle 12 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0043 flags 0x00 clen 4
      MTU 1013
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0043 flags 0x00 result 0 clen 4
      Success
      MTU 672
 > HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . .
 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0041 flags 0x00 result 0 clen 4
      Success
      MTU 672
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
< ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0043 len 14 [psm 3]
      RFCOMM(s): PN CMD: cr 1 dlci 0 pf 0 ilen 10 fcs 0x70 mcc_len 8
      dlci 22 frame_type 0 credit_flow 15 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 7
 > ACL data: handle 12 flags 0x02 dlen 18
    L2CAP(d): cid 0x0041 len 14 [psm 3]
      RFCOMM(s): PN RSP: cr 0 dlci 0 pf 0 ilen 10 fcs 0xaa mcc_len 8
      dlci 22 frame_type 0 credit_flow 14 pri 7 ack_timer 0
      frame_size 667 max_retrans 0 credits 3
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 22 pf 1 ilen 0 fcs 0xb8
 > HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . .
 > HCI Event: PIN Code Request (0x16) plen 6
  . . 8 . . .
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
  . . 8 . . .
 > HCI Event: Command Complete (0x0e) plen 10
  . . . . . . 8 . . .
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DM: cr 1 dlci 22 pf 1 ilen 0 fcs 0x92
< ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0043 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0043 scid 0x0041
 > ACL data: handle 12 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7
 > ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0043 scid 0x0041
 > HCI Event: Number of Completed Packets (0x13) plen 5
  . . . . .
 > HCI Event: Disconn Complete (0x05) plen 4
  . . . .


let's try again and see strace's oppinion on hcid:
bhairava:/etc/bluetooth# ps ax |grep hcid
 6067 ?        Ss     0:00 /usr/sbin/hcid
 6106 pts/5    R+     0:00 grep hcid

bhairava:/etc/bluetooth# strace -p 6067
Process 6067 attached - interrupt to quit
gettimeofday({1179265044, 407227}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\17\4\0\1\5\4", 260)         = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265046, 166927}, NULL) = 0
gettimeofday({1179265046, 167035}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\3\v\0\f\0\321\2578\305\30\0\1\0", 260) = 14
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365d0)       = 0
close(10)                               = 0
writev(7, [{"l\4\1\1\26\0\0\0\22\0\0\0_\0\0\0\1\1o\0\17\0\0\0/org/b"..., 
112}, {"\21\0\0\00000:18:C5:38:AF:D1\0", 22}], 2) = 134
time(NULL)                              = 1179265049
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
umask(022)                              = 022
stat64("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/lastused", 
{st_mode=S_IFREG|0644, st_size=42, ...}) = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/lastused", O_RDWR|O_CREAT, 
0644) = 10
close(10)                               = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/lastused", O_RDWR) = 10
flock(10, LOCK_EX)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=42, ...}) = 0
mmap2(NULL, 42, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_LOCKED, 10, 0) = 
0xa7fd1000
munmap(0xa7fd1000, 42)                  = 0
ftruncate(10, 0)                        = 0
lseek(10, 0, SEEK_SET)                  = 0
write(10, "00:18:C5:38:AF:D1 2007-05-15 21:"..., 42) = 42
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
bind(10, {sa_family=AF_BLUETOOTH, 
sa_data="\0\0\272\32\7\10\0\0\0\0008g\303\257"}, 4) = 0
writev(10, [{"\1", 1}, {"\31\4\n", 3}, {"\321\2578\305\30\0\2\0\0\0", 
10}], 3) = 14
close(10)                               = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/manufacturers", O_RDONLY) = 10
flock(10, LOCK_SH)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=28, ...}) = 0
mmap2(NULL, 28, PROT_READ, MAP_SHARED, 10, 0) = 0xa7fd1000
munmap(0xa7fd1000, 28)                  = 0
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
gettimeofday({1179265049, 847889}, NULL) = 0
gettimeofday({1179265049, 847971}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\17\4\0\1\33\4", 260)        = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265049, 848340}, NULL) = 0
gettimeofday({1179265049, 848424}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\v\v\0\f\0\277\356\17F\230\31\0\0", 260) = 14
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073bf8)        = 0
ioctl(10, 0x800448d3, 0xafc36660)       = 0
close(10)                               = 0
ioctl(9, 0x800448d4, 0x8073b50)         = 0
umask(022)                              = 022
stat64("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/features", 
{st_mode=S_IFREG|0644, st_size=35, ...}) = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/features", O_RDWR|O_CREAT, 
0644) = 10
close(10)                               = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/features", O_RDWR) = 10
flock(10, LOCK_EX)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=35, ...}) = 0
mmap2(NULL, 35, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_LOCKED, 10, 0) = 
0xa7fd1000
munmap(0xa7fd1000, 35)                  = 0
ftruncate(10, 0)                        = 0
lseek(10, 0, SEEK_SET)                  = 0
write(10, "00:18:C5:38:AF:D1 BFEE0F46981900"..., 35) = 35
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
gettimeofday({1179265049, 851791}, NULL) = 0
gettimeofday({1179265049, 851873}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\16\6\1\r\10\0\f\0", 260)    = 9
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265049, 852237}, NULL) = 0
gettimeofday({1179265049, 852318}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\17\4\0\1\31\4", 260)        = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265049, 852695}, NULL) = 0
gettimeofday({1179265049, 852776}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\7\377\0\321\2578\305\30\0Bhairava\0\0\0\0\0\0\0\0\0"..., 
260) = 258
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
umask(022)                              = 022
stat64("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/names", 
{st_mode=S_IFREG|0644, st_size=27, ...}) = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/names", O_RDWR|O_CREAT, 0644) 
= 10
close(10)                               = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/names", O_RDWR) = 10
flock(10, LOCK_EX)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=27, ...}) = 0
mmap2(NULL, 27, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_LOCKED, 10, 0) = 
0xa7fd1000
munmap(0xa7fd1000, 27)                  = 0
ftruncate(10, 0)                        = 0
lseek(10, 0, SEEK_SET)                  = 0
write(10, "00:18:C5:38:AF:D1 Bhairava\n", 27) = 27
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365c0)       = 0
close(10)                               = 0
writev(7, [{"l\4\1\1%\0\0\0\23\0\0\0`\0\0\0\1\1o\0\17\0\0\0/org/blu"..., 
112}, {"\21\0\0\00000:18:C5:38:AF:D1\0\0\0\10\0\0\0Bhai"..., 37}], 2) = 149
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
bind(10, {sa_family=AF_BLUETOOTH, 
sa_data="\0\0X\32\7\10\260\314\4\0108g\303\257"}, 4) = 0
close(10)                               = 0
gettimeofday({1179265049, 901229}, NULL) = 0
gettimeofday({1179265049, 901311}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\26\6\321\2578\305\30\0", 260) = 9
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
time([1179265055])                      = 1179265055
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: pin_code_request (sb"..., 75}, {"\n", 1}], 2) = 76
send(3, "<30>May 16 00:37:35 hcid[6067]: "..., 95, MSG_NOSIGNAL) = 95
ioctl(9, 0x800448d5, 0x806bae0)         = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/pincodes", O_RDONLY) = -1 
ENOENT (No such file or directory)
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8071a28)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
time([1179265055])                      = 1179265055
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: call_passkey_agent()"..., 53}, {"\n", 1}], 2) = 54
send(3, "<31>May 16 00:37:35 hcid[6067]: "..., 73, MSG_NOSIGNAL) = 73
writev(9, [{"\1", 1}, {"\16\4\6", 3}, {"\321\2578\305\30\0", 6}], 3) = 10
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8071a28)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
gettimeofday({1179265055, 250513}, NULL) = 0
gettimeofday({1179265055, 250545}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\16\n\1\16\4\0\321\2578\305\30\0", 260) = 13
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8071a28)        = 0
ioctl(10, 0x800448d3, 0xafc365e0)       = 0
close(10)                               = 0
gettimeofday({1179265055, 255123}, NULL) = 0
gettimeofday({1179265055, 255205}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\26\6\321\2578\305\30\0", 260) = 9
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
time([1179265059])                      = 1179265059
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: pin_code_request (sb"..., 75}, {"\n", 1}], 2) = 76
send(3, "<30>May 16 00:37:39 hcid[6067]: "..., 95, MSG_NOSIGNAL) = 95
ioctl(9, 0x800448d5, 0x806bae0)         = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/pincodes", O_RDONLY) = -1 
ENOENT (No such file or directory)
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8071a28)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
time([1179265059])                      = 1179265059
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: call_passkey_agent()"..., 53}, {"\n", 1}], 2) = 54
send(3, "<31>May 16 00:37:39 hcid[6067]: "..., 73, MSG_NOSIGNAL) = 73
writev(9, [{"\1", 1}, {"\16\4\6", 3}, {"\321\2578\305\30\0", 6}], 3) = 10
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8071a28)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
gettimeofday({1179265059, 810513}, NULL) = 0
gettimeofday({1179265059, 810603}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\16\n\1\16\4\0\321\2578\305\30\0", 260) = 13
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365e0)       = 0
close(10)                               = 0
gettimeofday({1179265059, 819021}, NULL) = 0
gettimeofday({1179265059, 819103}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\26\6\321\2578\305\30\0", 260) = 9
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
time([1179265063])                      = 1179265063
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: pin_code_request (sb"..., 75}, {"\n", 1}], 2) = 76
send(3, "<30>May 16 00:37:43 hcid[6067]: "..., 95, MSG_NOSIGNAL) = 95
ioctl(9, 0x800448d5, 0x806bae0)         = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/pincodes", O_RDONLY) = -1 
ENOENT (No such file or directory)
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
time([1179265063])                      = 1179265063
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: call_passkey_agent()"..., 53}, {"\n", 1}], 2) = 54
send(3, "<31>May 16 00:37:43 hcid[6067]: "..., 73, MSG_NOSIGNAL) = 73
writev(9, [{"\1", 1}, {"\16\4\6", 3}, {"\321\2578\305\30\0", 6}], 3) = 10
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
gettimeofday({1179265063, 913831}, NULL) = 0
gettimeofday({1179265063, 913913}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\16\n\1\16\4\0\321\2578\305\30\0", 260) = 13
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365e0)       = 0
close(10)                               = 0
gettimeofday({1179265063, 917575}, NULL) = 0
gettimeofday({1179265063, 917656}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\17\4\0\1\6\4", 260)         = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265066, 13396}, NULL) = 0
gettimeofday({1179265066, 13478}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\5\4\0\f\0\26", 260)         = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365d0)       = 0
close(10)                               = 0
writev(7, [{"l\4\1\1\26\0\0\0\24\0\0\0g\0\0\0\1\1o\0\17\0\0\0/org/b"..., 
120}, {"\21\0\0\00000:18:C5:38:AF:D1\0", 22}], 2) = 142
gettimeofday({1179265066, 170153}, NULL) = 0
gettimeofday({1179265066, 170235}, NULL) = 0
poll( <unfinished ...>
Process 6067 detached

maybe we can help with that 
/var/lib/bluetooth/00:0B:0D:4C:AB:C3/pincodes that he's complaining about ?
the file doesn't exist, so let's create it:
bhairava:/etc/bluetooth# echo 1234 > 
/var/lib/bluetooth/00:0B:0D:4C:AB:C3/pincodes

let's see what it says now:

bhairava:/etc/bluetooth# strace -p 6067
Process 6067 attached - interrupt to quit
gettimeofday({1179265213, 584136}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\17\4\0\1\5\4", 260)         = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265215, 338358}, NULL) = 0
gettimeofday({1179265215, 338494}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\3\v\0\f\0\321\2578\305\30\0\1\0", 260) = 14
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365d0)       = 0
close(10)                               = 0
writev(7, [{"l\4\1\1\26\0\0\0\25\0\0\0_\0\0\0\1\1o\0\17\0\0\0/org/b"..., 
112}, {"\21\0\0\00000:18:C5:38:AF:D1\0", 22}], 2) = 134
time(NULL)                              = 1179265218
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
umask(022)                              = 022
stat64("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/lastused", 
{st_mode=S_IFREG|0644, st_size=42, ...}) = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/lastused", O_RDWR|O_CREAT, 
0644) = 10
close(10)                               = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/lastused", O_RDWR) = 10
flock(10, LOCK_EX)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=42, ...}) = 0
mmap2(NULL, 42, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_LOCKED, 10, 0) = 
0xa7fd1000
munmap(0xa7fd1000, 42)                  = 0
ftruncate(10, 0)                        = 0
lseek(10, 0, SEEK_SET)                  = 0
write(10, "00:18:C5:38:AF:D1 2007-05-15 21:"..., 42) = 42
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
bind(10, {sa_family=AF_BLUETOOTH, 
sa_data="\0\0\272\32\7\10\0\0\0\0008g\303\257"}, 4) = 0
writev(10, [{"\1", 1}, {"\31\4\n", 3}, {"\321\2578\305\30\0\2\0\0\0", 
10}], 3) = 14
close(10)                               = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/manufacturers", O_RDONLY) = 10
flock(10, LOCK_SH)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=28, ...}) = 0
mmap2(NULL, 28, PROT_READ, MAP_SHARED, 10, 0) = 0xa7fd1000
munmap(0xa7fd1000, 28)                  = 0
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
gettimeofday({1179265218, 786740}, NULL) = 0
gettimeofday({1179265218, 786772}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\17\4\0\1\33\4", 260)        = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265218, 786921}, NULL) = 0
gettimeofday({1179265218, 786952}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\v\v\0\f\0\277\356\17F\230\31\0\0", 260) = 14
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073c30)        = 0
ioctl(10, 0x800448d3, 0xafc36660)       = 0
close(10)                               = 0
ioctl(9, 0x800448d4, 0x8073b88)         = 0
umask(022)                              = 022
stat64("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/features", 
{st_mode=S_IFREG|0644, st_size=35, ...}) = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/features", O_RDWR|O_CREAT, 
0644) = 10
close(10)                               = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/features", O_RDWR) = 10
flock(10, LOCK_EX)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=35, ...}) = 0
mmap2(NULL, 35, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_LOCKED, 10, 0) = 
0xa7fd1000
munmap(0xa7fd1000, 35)                  = 0
ftruncate(10, 0)                        = 0
lseek(10, 0, SEEK_SET)                  = 0
write(10, "00:18:C5:38:AF:D1 BFEE0F46981900"..., 35) = 35
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
gettimeofday({1179265218, 789419}, NULL) = 0
gettimeofday({1179265218, 789451}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\16\6\1\r\10\0\f\0", 260)    = 9
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265218, 789597}, NULL) = 0
gettimeofday({1179265218, 789628}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\17\4\0\1\31\4", 260)        = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265218, 791109}, NULL) = 0
gettimeofday({1179265218, 791140}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\7\377\0\321\2578\305\30\0Bhairava\0\0\0\0\0\0\0\0\0"..., 
260) = 258
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
umask(022)                              = 022
stat64("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/names", 
{st_mode=S_IFREG|0644, st_size=27, ...}) = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/names", O_RDWR|O_CREAT, 0644) 
= 10
close(10)                               = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/names", O_RDWR) = 10
flock(10, LOCK_EX)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=27, ...}) = 0
mmap2(NULL, 27, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_LOCKED, 10, 0) = 
0xa7fd1000
munmap(0xa7fd1000, 27)                  = 0
ftruncate(10, 0)                        = 0
lseek(10, 0, SEEK_SET)                  = 0
write(10, "00:18:C5:38:AF:D1 Bhairava\n", 27) = 27
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b78)        = 0
ioctl(10, 0x800448d3, 0xafc365c0)       = 0
close(10)                               = 0
writev(7, [{"l\4\1\1%\0\0\0\26\0\0\0`\0\0\0\1\1o\0\17\0\0\0/org/blu"..., 
112}, {"\21\0\0\00000:18:C5:38:AF:D1\0\0\0\10\0\0\0Bhai"..., 37}], 2) = 149
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
bind(10, {sa_family=AF_BLUETOOTH, 
sa_data="\0\0P;\7\10\260\314\4\0108g\303\257"}, 4) = 0
close(10)                               = 0
gettimeofday({1179265218, 863125}, NULL) = 0
gettimeofday({1179265218, 863157}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\26\6\321\2578\305\30\0", 260) = 9
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
time([1179265225])                      = 1179265225
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: pin_code_request (sb"..., 75}, {"\n", 1}], 2) = 76
send(3, "<30>May 16 00:40:25 hcid[6067]: "..., 95, MSG_NOSIGNAL) = 95
ioctl(9, 0x800448d5, 0x806bae0)         = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/pincodes", O_RDONLY) = 10
flock(10, LOCK_SH)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=5, ...}) = 0
mmap2(NULL, 5, PROT_READ, MAP_SHARED, 10, 0) = 0xa7fd1000
munmap(0xa7fd1000, 5)                   = 0
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
time([1179265225])                      = 1179265225
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: call_passkey_agent()"..., 53}, {"\n", 1}], 2) = 54
send(3, "<31>May 16 00:40:25 hcid[6067]: "..., 73, MSG_NOSIGNAL) = 73
writev(9, [{"\1", 1}, {"\16\4\6", 3}, {"\321\2578\305\30\0", 6}], 3) = 10
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
gettimeofday({1179265225, 150033}, NULL) = 0
gettimeofday({1179265225, 150064}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\16\n\1\16\4\0\321\2578\305\30\0", 260) = 13
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365e0)       = 0
close(10)                               = 0
gettimeofday({1179265225, 152469}, NULL) = 0
gettimeofday({1179265225, 152501}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\26\6\321\2578\305\30\0", 260) = 9
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
time([1179265229])                      = 1179265229
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: pin_code_request (sb"..., 75}, {"\n", 1}], 2) = 76
send(3, "<30>May 16 00:40:29 hcid[6067]: "..., 95, MSG_NOSIGNAL) = 95
ioctl(9, 0x800448d5, 0x806bae0)         = 0
open("/var/lib/bluetooth/00:0B:0D:4C:AB:C3/pincodes", O_RDONLY) = 10
flock(10, LOCK_SH)                      = 0
fstat64(10, {st_mode=S_IFREG|0644, st_size=5, ...}) = 0
mmap2(NULL, 5, PROT_READ, MAP_SHARED, 10, 0) = 0xa7fd1000
munmap(0xa7fd1000, 5)                   = 0
flock(10, LOCK_UN)                      = 0
close(10)                               = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
time([1179265229])                      = 1179265229
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
stat64("/etc/localtime", {st_mode=S_IFREG|0644, st_size=798, ...}) = 0
writev(2, [{"hcid[6067]: call_passkey_agent()"..., 53}, {"\n", 1}], 2) = 54
send(3, "<31>May 16 00:40:29 hcid[6067]: "..., 73, MSG_NOSIGNAL) = 73
writev(9, [{"\1", 1}, {"\16\4\6", 3}, {"\321\2578\305\30\0", 6}], 3) = 10
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc36540)       = 0
close(10)                               = 0
gettimeofday({1179265229, 357245}, NULL) = 0
gettimeofday({1179265229, 357276}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\16\n\1\16\4\0\321\2578\305\30\0", 260) = 13
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365e0)       = 0
close(10)                               = 0
gettimeofday({1179265229, 359759}, NULL) = 0
gettimeofday({1179265229, 359791}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=7, events=POLLIN|POLLERR|POLLHUP}, {fd=5, events=POLLIN}], 3, -1) = 1
read(9, "\4\17\4\0\1\6\4", 260)         = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
gettimeofday({1179265231, 488802}, NULL) = 0
gettimeofday({1179265231, 488834}, NULL) = 0
poll([{fd=9, events=POLLIN|POLLERR|POLLHUP|POLLNVAL, revents=POLLIN}, 
{fd=5, events=POLLIN}, {fd=7, events=POLLIN|POLLERR|POLLHUP}], 3, -1) = 1
read(9, "\4\5\4\0\f\0\26", 260)         = 7
ioctl(9, 0x800448d3, 0x8071ab0)         = 0
socket(PF_BLUETOOTH, SOCK_RAW, 1)       = 10
ioctl(10, 0x800448d2, 0x8073b50)        = 0
ioctl(10, 0x800448d3, 0xafc365d0)       = 0
close(10)                               = 0
writev(7, [{"l\4\1\1\26\0\0\0\27\0\0\0g\0\0\0\1\1o\0\17\0\0\0/org/b"..., 
120}, {"\21\0\0\00000:18:C5:38:AF:D1\0", 22}], 2) = 142
gettimeofday({1179265231, 647177}, NULL) = 0
gettimeofday({1179265231, 647209}, NULL) = 0
poll( <unfinished ...>
Process 6067 detached


any sugestions would be welcomed.

thanks and sorry for the long post.



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
