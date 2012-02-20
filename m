Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/2] Fix crash in profile descriptor list parsing
Date: Mon, 20 Feb 2012 21:57:56 +0100
Message-Id: <1329771478-3935-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've tried to connect the HFP audio gateway on a Mac running Lion.
bluetoothd crashed. So did sdptool browse.

I guess the whole device has passed qualification, and is widely available, so:
* First patch fixes the crash.
* Second one makes sure profile version can be read.

Hope this helps!

Regards,
Frédéric

Output after running in GDB:

Service Name: Hands Free Audio Gateway
Service RecHandle: 0x10003
Service Class ID List:
  "Handsfree Audio Gateway" (0x111f)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 2
Language Base Attr List:
  code_ISO639: 0x656e
  encoding:    0x6a
  base_offset: 0x100

Program received signal SIGSEGV, Segmentation fault.
sdp_get_profile_descs (rec=0x80039520, profDescSeq=0xbfffef38) at lib/sdp.c:2070
2070				sdp_data_t *pVnum = seq->val.dataseq->next;
(gdb) bt
#0  sdp_get_profile_descs (rec=0x80039520, profDescSeq=0xbfffef38) at lib/sdp.c:2070
#1  0x80003f2e in print_service_attr (rec=0x80039520) at tools/sdptool.c:1129
#2  0x80005210 in do_search (bdaddr=0xbffff186, context=0xbffff164) at tools/sdptool.c:3803
#3  0x80005627 in cmd_browse (argc=1, argv=<optimized out>) at tools/sdptool.c:3898
#4  0x800028f4 in main (argc=2, argv=<optimized out>) at tools/sdptool.c:4277
(gdb) l
2065	
2066			if (SDP_IS_UUID(seq->dtd)) {
2067				uuid = &seq->val.uuid;
2068			} else {
2069				sdp_data_t *puuid = seq->val.dataseq;
2070				sdp_data_t *pVnum = seq->val.dataseq->next;
2071				if (puuid && pVnum) {
2072					uuid = &puuid->val.uuid;
2073					version = pVnum->val.uint16;
2074				}
(gdb) p *puuid
Cannot access memory at address 0x105

The following is an extract of hcidump of record wich caused crash:
              aid 0x0009 (BTProfileDescList)
                 < uuid-16 0x111e (Handsfree) uint 0x105 >

by contrast, other profile version looks like this and are fine with BlueZ:
              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x110e (AVRemote) uint 0x103 > >

              aid 0x0009 (BTProfileDescList)
                 < < uuid-16 0x1108 (Headset) uint 0x102 > >

Frédéric Dalleau (2):
  sdp: Check type of sdp data before dereferencing
  sdp: Fix sdp_get_profile_descs for Mac Os X Lion

 lib/sdp.c |    7 ++++++-
 lib/sdp.h |    1 +
 2 files changed, 7 insertions(+), 1 deletions(-)

-- 
1.7.5.4

