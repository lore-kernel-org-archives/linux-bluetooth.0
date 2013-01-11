Return-Path: <cyrus@holtmann.org>
Message-id: <D43D72D2B7084BA8B750CE7FD0D1C287@sisodomain.com>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <1335342544-17320-1-git-send-email-manojkr.sharma@stericsson.com>
 <1335342544-17320-2-git-send-email-manojkr.sharma@stericsson.com>
 <alpine.DEB.2.02.1204250827200.20357@mathewm-linux>
Subject: Obexd OPP filesend fails with Windows7 stack
Date: Fri, 11 Jan 2013 14:02:28 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

We are using the obexd 0.48 version and testing the obexd.
During testing OPP file send, we found one interoperability
issue with the Windows7 PC stack and some commercialized devices
available in the market.

The issue is: OBEXD file transfer is getting failed
once after the complete file content got transfferd. This is
because of, we do a direct RFCOMM disconection rather than
doing a proper OBEX disconection before.

Does someone can help me a with a fix for this?

hcidump logs:
< ACL data: handle 11 flags 0x00 dlen 15
    L2CAP(d): cid 0x0041 len 11 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 7 fcs 0x9a
        OBEX: Connect cmd(f): len 7 version 1.0 flags 0 mtu 4096
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 9
    L2CAP(d): cid 0x0041 len 5 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 0 fcs 0x5c credits 26
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(d): cid 0x0041 len 12 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 7 fcs 0x5c credits 0
        OBEX: Connect rsp(f): status 200 len 7 version 1.0 flags 0 mtu 4096
        Status 200 = Success
< ACL data: handle 11 flags 0x00 dlen 65
    L2CAP(d): cid 0x0041 len 61 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 57 fcs 0x9a
        OBEX: Put cmd(c): len 57
        Name (0x01) = Unicode length 28
        0000: 00 74 00 65 00 73 00 74  00 2d 00 74 00 65 00 78 
.t.e.s.t.-.t.e.x
        0010: 00 74 00 2e 00 74 00 78  00 74 00 00              .t...t.x.t..
        Length (0xc3) = 15
        Body (0x48) = Sequence length 15
        0000: 54 65 73 74 20 44 6f 63  75 6d 65 6e 74 0d 0a     Test 
Document..
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 3 fcs 0x5c credits 1
        OBEX: Put rsp(f): status 100 len 3
< ACL data: handle 11 flags 0x00 dlen 14
    L2CAP(d): cid 0x0041 len 10 [psm 3]
      RFCOMM(d): UIH: cr 1 dlci 2 pf 0 ilen 6 fcs 0x9a
        OBEX: Put cmd(f): len 6 (continue)
        End of Body (0x49) = Sequence length 0
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0041 len 8 [psm 3]
      RFCOMM(d): UIH: cr 0 dlci 2 pf 1 ilen 3 fcs 0x5c credits 1
        OBEX: Put rsp(f): status 200 len 3
< ACL data: handle 11 flags 0x00 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 2 pf 1 ilen 0 fcs 0xb8
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 2 pf 1 ilen 0 fcs 0x92
< ACL data: handle 11 flags 0x00 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): DISC: cr 1 dlci 0 pf 1 ilen 0 fcs 0xfd
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0041 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 8
    L2CAP(d): cid 0x0041 len 4 [psm 3]
      RFCOMM(s): UA: cr 1 dlci 0 pf 1 ilen 0 fcs 0xd7

Thanks,
Syam. 

