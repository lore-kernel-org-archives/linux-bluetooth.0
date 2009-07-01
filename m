Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jul 2009 21:13:04 +0300
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: hcidump: RFCOMM and OBEX parsing errors followed by a segfault
Message-ID: <20090701181304.GA13827@D-PC.vodafone>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

While debugging an application that concurrently pushes files to
close remote devices, hcidump (git HEAD - v1.42) erroneously
parses obex packets sent to and received from certain mobiles.
Details and a verbose backtrace using "-ggdb" follows.

At first, hcidump rightfully parses the OBEX "connect" packet and
its response:

2009-07-01 13:46:10.016580 < ACL data: handle 42 flags 0x02 dlen 15
    L2CAP(d): cid 0x0040 len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 7 fcs 0x4f 
        OBEX: Connect cmd(f): len 7 version 1.0 flags 0 mtu 32767
...

2009-07-01 13:46:10.075331 > ACL data: handle 42 flags 0x02 dlen 16
    L2CAP(d): cid 0x0041 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 7 fcs 0x89 credits 1
        OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu 4096
        Status 200 = Success

It also parses the first PUT packet (final bit not set) and its
headers nicely:

2009-07-01 13:46:10.204197 < ACL data: handle 42 flags 0x02 dlen 76
    L2CAP(d): cid 0x0040 len 72 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 12 pf 0 ilen 68 fcs 0x4f 
        OBEX: Put cmd(c): len 4096
        Name (0x01) = Unicode length 12
        0000: 00 31 00 2e 00 6a 00 70  00 67 00 00              .1...j.p.g..
        Length (0xc3) = 863062
        Body (0x48) = Sequence length 4070
        0000: ff d8 ff e0 00 10 4a 46  49 46 00 01 02 01 00 48  ......JFIF.....H
	....

After this packet, it seems hcidump didn't recognize that subsequent
packets are normal OBEX packets passing through RFCOMM:

2009-07-01 13:46:27.759807 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 0]
      0000: 31 ff 07 05 90 00 03 89                           1.......

As you see "90 00 03" is the OBEX response packet of "Continue"/0x90
with a size of 0x0003 bytes. the rest is possibly related to rfcomm
which I'm not familiar with yet.

In subsequent PUT packets, similar erroneous behaviour occurs:

2009-07-01 13:46:27.808222 < ACL data: handle 42 flags 0x01 dlen 86
    L2CAP(d): cid 0x0040 len 1012 [psm 0]
      0000: 33 ef de 07 02 10 00 48  0f fd 0d c4 a6 c7 6e 05  3......H......n.
      0010: e6 41 2e 6e d2 c2 df 4a  bf 76 cf d2 26 95 e3 62  .A.n...J.v..&..b
      ....

Above data "02 10 00 48  0f fd .." was an OBEX "Put"/0x02 with a size
of 0x1000 and a "Body"/0x48 header followed by body contents of size 
0x0fffd. "0x0d c4 .." is a part of the pushed file content.

I've noticed that in all cases of unrecognized OBEX PUT packets _sent_
to the remote device, the packet get encapsulated by the four bytes
"33 ef (de|89) (07|71)" at the start and "4f" at the end. Sometimes
the _single_ OBEX packet get sent in several smaller chunks encapsulated
inside those bytes. I'm quite positive those are related to rfcomm.

In the other cases of OBEX responses _received_ from the remote device,
the packet always get encapsulated between the sequence
"31 ff 07 05" and the byte "89". So I constantly see the sequence

      0000: 31 ff 07 05 90 00 03 89                           1.......

due to the several OBEX "Continue" responses to the non-final PUT
requests packets.

At first I thought this behaviour might be related to the bug I'm
tracing, but the sent file was nicely received by the remote device
and the transfer continued till the last OBEX packet.

Ironically, hcidump recognized the last OBEX packet received from
the device which was a response to a "Disconnect" request sent
following the successful PUT operation:

/* Not recognized OBEX Disconnect (0x81) of size 3 bytes (0x0003) */
2009-07-01 13:47:12.250213 < ACL data: handle 42 flags 0x02 dlen 11
    L2CAP(d): cid 0x0040 len 7 [psm 0]
      0000: 33 ef 07 81 00 03 4f                              3.....O

/* The response is perceived as a response to the first _recognized_
 * OBEX "Put". It's actually for the above "Disconnect" request. */
2009-07-01 13:47:12.296699 > ACL data: handle 42 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 12 pf 1 ilen 3 fcs 0x89 credits 1
        OBEX: Put rsp(f): status 200 len 3

Given above details, we can say that hcidump only recognized the
first and the last OBEX packet. It's also clear that hcidump didn't
recognize the rfcomm overhead itself where the obex packets are
encapsulated.

Any ideas about the possible cause? I'm not comfortable yet with l2cap
and rfcomm binary dumps to be able to judge. Thanks

----

On a possibly related behaviour, while reading ("-r") the same binary
dump, hcidump crashed by below segfault. The binary dump can be sent
privately if requested. It's 15 MB in size and the fault is reproducable:

$ gdb /usr/local/sbin/hcidump -c core
...
Core was generated by `/usr/local/sbin/hcidump -XV --timestamp -r binary-dump'.
Program terminated with signal 11, Segmentation fault.
[New process 11962]
#0  0xb8088b23 in ext_dump (level=3, frm=0xb80ae0a8, num=30716) at parser.c:309
309				printf("%02x%s", buf[i], (i + 1) % 8 ? " " : "  ");
(gdb) bt
#0  0xb8088b23 in ext_dump (level=3, frm=0xb80ae0a8, num=30716) at parser.c:309
#1  0xb8088cbc in raw_ndump (level=3, frm=0xb80ae0a8, num=63740) at parser.c:338
#2  0xb8099c70 in parse_headers (level=3, frm=0xb80ae0a8) at obex.c:213
#3  0xb809a2c8 in obex_dump (level=3, frm=0xb80ae0a8) at obex.c:307
#4  0xb809523d in uih_frame (level=2, frm=0xb80ae4f4, head=0xbfe94898) at rfcomm.c:278
#5  0xb8094f8d in rfcomm_dump (level=2, frm=0xb80ae4f4) at rfcomm.c:325
#6  0xb8092596 in l2cap_parse (level=2, frm=0xb80ae4f4) at l2cap.c:828
#7  0xb8093282 in l2cap_dump (level=1, frm=0xbfe949e4) at l2cap.c:960
#8  0xb8090888 in acl_dump (level=1, frm=0xbfe949e4) at hci.c:3226
#9  0xb808924b in hci_dump (level=0, frm=0xbfe949e4) at hci.c:3302
#10 0xb8085c09 in parse (frm=0xbfe949e4) at ../parser/parser.h:248
#11 0xb808619c in read_dump (fd=3) at hcidump.c:465
#12 0xb8087b1a in main (argc=0, argv=0xbfe94b78) at hcidump.c:1152
(gdb) 

Regards

--
Ahmed S. Darwish
Homepage: http://darwish.07.googlepages.com
