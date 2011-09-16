Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/7] EFS: extended flow specification option support
Date: Fri, 16 Sep 2011 16:26:29 +0300
Message-Id: <1316179596-30906-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Implementation of EFS based upon series of patches sent upstream in Aug 2010
by Haijun Liu.

http://marc.info/?a=128277503500005&r=1&w=2

Changes:
	* RFC: initial release
	* RFCv2: rebase & take care about comments:
		- use flag in l2cap_chan instead of variable
		- move channel init out from parse_conf_req
		- other style fixes
	* PATCHv1: support only Best Effort channels for now.
	* PATCHv2: disable_flowspec -> enable_hs, style fixes

L2CAP sequence looks like the one below:
(my patches for decoding EFS have been applied to hcidump)

...
< ACL data: handle 1 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00f8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Extended Flow Specification
        Fixed Channels
< ACL data: handle 1 flags 0x00 dlen 10
    L2CAP(s): Info req: type 3
> ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list
< ACL data: handle 1 flags 0x00 dlen 12
    L2CAP(s): Connect req: psm 4113 scid 0x0040
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
      Connection pending - No futher information available
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 2
< ACL data: handle 1 flags 0x00 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x00f8
        Enhanced Retransmission mode
        Streaming mode
        FCS Option
        Extended Flow Specification
        Fixed Channels
> ACL data: handle 1 flags 0x02 dlen 10
    L2CAP(s): Info req: type 3
< ACL data: handle 1 flags 0x00 dlen 20
    L2CAP(s): Info rsp: type 3 result 0
      Fixed channel list
> ACL data: handle 1 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
< ACL data: handle 1 flags 0x00 dlen 41
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 29
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0,
          MTo 0, MPS 500) 
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime
          0xffffffff, AccLat 0xffffffff, FlushTO 0x0000ffff) 
> ACL data: handle 1 flags 0x02 dlen 41
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 29
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 0, MTo 0,
          MPS 1009) 
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
          AccLat 0xffffffff, FlushTO 0x0000ffff) 
< ACL data: handle 1 flags 0x00 dlen 47
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 4 clen 33
      Pending
      MTU 672 
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 12000,
          MPS 500) 
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
          AccLat 0xffffffff, FlushTO 0x0000ffff) 
> ACL data: handle 1 flags 0x02 dlen 47
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 4 clen 33
      Pending
      MTU 672 
      RFC 0x03 (Enhanced Retransmission, TxWin 63, MaxTx 3, RTo 2000, MTo 12000,
          MPS 500) 
      EFS (Id 0x01, SerType Best Effort, MaxSDU 0xffff, SDUitime 0xffffffff,
          AccLat 0xffffffff, FlushTO 0x0000ffff) 
< ACL data: handle 1 flags 0x00 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> ACL data: handle 1 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
...
< ACL data: handle 1 flags 0x00 dlen 510
    L2CAP(d): cid 0x0040 len 506 ctrl 0x4000 fcs 0x5337 [psm 4113]
      I-frame: Start (len 672) TxSeq 0 ReqSeq 0
...

Andrei Emeltchenko (7):
  Bluetooth: EFS: l2cap extended feature mask update
  Bluetooth: EFS: definitions and headers
  Bluetooth: EFS: add enable_hs kernel param
  Bluetooth: EFS: parse l2cap config request
  Bluetooth: EFS: parse l2cap config response
  Bluetooth: EFS: add efs option in l2cap conf req
  Bluetooth: EFS: parse l2cap config rsp pending

 include/net/bluetooth/l2cap.h |   47 +++++++++++-
 net/bluetooth/l2cap_core.c    |  176 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 218 insertions(+), 5 deletions(-)

-- 
1.7.4.1

