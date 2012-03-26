Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <lukasz.rymanowski@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH hcidump 0/3] SAP PDU parsing
Date: Mon, 26 Mar 2012 12:02:08 +0200
Message-ID: <1332756131-16439-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following patches add support for parsing SAP PDU. Below is sample output from
'hcidump -X -S 8' for reference.

> ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 16 pf 0 ilen 12 fcs 0x24 
        SAP: Connect Req: params 1
        MaxMsgSize (0x00) len 2 = 2048
< ACL data: handle 1 flags 0x00 dlen 28
    L2CAP(d): cid 0x0040 len 24 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 16 pf 0 ilen 20 fcs 0xfe 
        SAP: Connect Resp: params 2
        ConnectionStatus (0x01) len 1 = 0x02 (Error, Server does not support maximum message size)
        MaxMsgSize (0x00) len 2 = 512
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 21
    L2CAP(d): cid 0x0040 len 17 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 16 pf 1 ilen 12 fcs 0x38 credits 1
        SAP: Connect Req: params 1
        MaxMsgSize (0x00) len 2 = 512
< ACL data: handle 1 flags 0x00 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 16 pf 0 ilen 12 fcs 0xfe 
        SAP: Connect Resp: params 1
        ConnectionStatus (0x01) len 1 = 0x00 (OK, Server can fulfill requirements)
< ACL data: handle 1 flags 0x00 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 16 pf 0 ilen 12 fcs 0xfe 
        SAP: Status Ind: params 1
        StatusChange (0x08) len 1 = 0x01 (Card reset)
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 13
    L2CAP(d): cid 0x0040 len 9 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 16 pf 1 ilen 4 fcs 0x38 credits 2
        SAP: Transfer ATR Req: params 0
< ACL data: handle 1 flags 0x00 dlen 36
    L2CAP(d): cid 0x0040 len 32 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 16 pf 0 ilen 28 fcs 0xfe 
        SAP: Transfer ATR Resp: params 2
        ResultCode (0x02) len 1 = 0x00 (OK, request processed correctly)
        ATR (0x06) len 12 = 
          0000: 3b 98 95 00 93 94 03 05  0e 02 02 02              ;...........
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 1 packets 1
> ACL data: handle 1 flags 0x02 dlen 25
    L2CAP(d): cid 0x0040 len 21 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 16 pf 1 ilen 16 fcs 0x38 credits 1
        SAP: Transfer APDU Req: params 1
        CommandAPDU (0x04) len 7 = 
          0000: 00 a4 08 0c 02 2f e2                              ...../.
< ACL data: handle 1 flags 0x00 dlen 28
    L2CAP(d): cid 0x0040 len 24 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 16 pf 0 ilen 20 fcs 0xfe 
        SAP: Transfer APDU Resp: params 2
        ResultCode (0x02) len 1 = 0x00 (OK, request processed correctly)
        ResponseAPDU (0x05) len 2 = 
          0000: 6e 00                                             n.

Andrzej Kaczmarek (3):
  Add basic SAP parsing
  Add parameters parsing support for SAP PDU
  core: Add support for passing RFCOMM channel for SAP

 Makefile.am     |    1 +
 parser/parser.h |    2 +
 parser/rfcomm.c |    7 ++
 parser/sap.c    |  335 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/hcidump.c   |   11 +-
 5 files changed, 355 insertions(+), 1 deletion(-)
 create mode 100644 parser/sap.c

-- 
1.7.9.4

