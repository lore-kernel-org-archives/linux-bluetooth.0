Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42F0C263.8070606@teleline.es>
From: Pedro Monjo Florit <pmonjo@teleline.es>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------000900080701020009090808"
Subject: [Bluez-devel] DUN lookup on Samsung D500 raises SIGSEGV
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
Date: Wed, 03 Aug 2005 15:10:59 +0200

This is a multi-part message in MIME format.
--------------000900080701020009090808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks:

I am having problems with a Samsung SGH-D500 mobile phone. I do the
following:

pm@PM:~/Development/picdproto> sdptool search DUN
Inquiring ...
Searching for DUN on 00:12:47:63:FB:2A ...
Service Name: Dial-up networking
Service RecHandle: 0x10002
Service Class ID List:
      "Error: This is uuid32" (0x00001103)
Protocol Descriptor List:
      "Error: " (0x00000100)
      "Error: " (0x00000003)
        Channel: 4
Segmentation fault

I have attached the output of "hcidump -X".

Using gdb, I have found that the offending instruction is in
bluez-libs-2.xx/src/sdp.c. It is produced in the library function
sdp_get_profile_descs(), in the line

	...
	sdp_data_t *pVnum = seq->val.dataseq->next;
	...

It seems that the problem is that "seq->val.dataseq" points to an
out-of-memory address (in my case, it was 0x1a), so trying to get the
"next" field raises SIGSEGV.

I do not quite understand all bluez structures (sdp_data_t and similar),
so I do not know exactly what went wrong. My guess is that the SDP
information sent by the mobile phone was corrupt or bogus and that the
bluez SDP code did not handled it correctly.

I hope that this information could help to fix this.

Regards,

Pedro Monjo




--------------000900080701020009090808
Content-Type: text/plain;
 name="hcidump_samsung.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hcidump_samsung.txt"

HCIDump - HCI packet analyzer ver 1.11
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry (0x01|0x0001) plen 5
  0000: 33 8b 9e 0a 14                                    3....
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 01 04                                       ....
> HCI Event: Inquiry Result (0x02) plen 15
  0000: 01 2a fb 63 47 12 00 01 00 00 04 02 52 85 01      .*.cG.......R..
> HCI Event: Inquiry Complete (0x01) plen 1
  0000: 00                                                .
< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 2a fb 63 47 12 00 18 cc 01 00 85 81 01            *.cG.........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 29 00 2a fb 63 47 12 00 01 00                  .).*.cG....
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 29 00 0f 00                                       )...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 01 0d 08 00 29 00                                 ....).
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004d scid 0x0040 result 1 status 2
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x004d scid 0x0040 result 0 status 0
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x004d flags 0x0000 clen 0
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 29 00 05                                          )..
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0029 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 48 
< ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x004d flags 0x0000 result 0 clen 0
< ACL data: handle 0x0029 flags 0x02 dlen 24
    L2CAP(d): cid 0x004d len 20 [psm 1]
        SDP SSA Req: tid 0x0 len 0xf
          pat uuid-16 0x1103 (DUN)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 00 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x0 len 0x2b
          cnt 0x26
          srv rec #0
            aid 0x0000 (SrvRecHndl)
               uint 0x10002
            aid 0x0001 (SrvClassIDList)
               < uuid-32 0x1103 (DUN) >
            aid 0x0004 (ProtocolDescList)
               < < uuid-32 0x0100 (L2CAP) > < null null bool 0x0 > >

          cont 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x004d len 22 [psm 1]
        SDP SSA Req: tid 0x1 len 0x11
          pat uuid-16 0x1103 (DUN)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 28 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 52
    L2CAP(d): cid 0x0040 len 48 [psm 1]
        SDP SSA Rsp: tid 0x1 len 0x2b
          cnt 0x26

ERROR: Unexpected syntax
          0000: 00 00 00 03 08 04 09 01 00 25 12 44 69 61 6c 2d   .........%.Dial-
          0010: 75 70 20 6e 65 74 77 6f 72 6b 69 6e 67 09 00 09   up networking...
          0020: 35 05 1a 00 00 02 00 02                           5.......
          cont 00 00 00 03 08 04 09 01 00 25 12 44 69 61 6C 2D 75 70 20 6E 65 74 77 6F 72 6B 69 6E 67 09 00 09 35 05 1A 00 00 02 00 02 
< ACL data: handle 0x0029 flags 0x02 dlen 26
    L2CAP(d): cid 0x004d len 22 [psm 1]
        SDP SSA Req: tid 0x2 len 0x11
          pat uuid-16 0x1103 (DUN)
          max 0xffff
          aid(s) 0x0000 - 0xffff
          cont 02 00 02 
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x0040 len 10 [psm 1]
        SDP SSA Rsp: tid 0x2 len 0x5
          cnt 0x2

ERROR: Unexpected syntax
          0000: 03 00                                             ..
          cont 03 00 
< ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x004d scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
  0000: 01 29 00 01 00                                    .)...
> ACL data: handle 0x0029 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x004d scid 0x0040
< HCI Command: Disconnect (0x01|0x0006) plen 3
  0000: 29 00 13                                          )..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 06 04                                       ....
> HCI Event: Disconn Complete (0x05) plen 4
  0000: 00 29 00 16                                       .)..




--------------000900080701020009090808--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
