Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 8 Jan 2009 14:30:32 -0800
Message-ID: <35c90d960901081430s5f5d1067pbff846525842e27e@mail.gmail.com>
Subject: [RFC] Suggest to revert commit 9719f8af (Disconnect when encryption
	gets disabled) due to role switch issues
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This original commit drops an L2CAP or RFCOMM connection if encryption
was requested and the remote side disables encryption.

The problem occurs during Role Switch. Bluetooth 2.0 devices have to
drop encryption temporarily during the role switch, but when this
remote side does this we immediately disconnect due to this patch.
Here is an example:

2009-01-08 11:17:52.972625 > HCI Event: Encrypt Change (0x08) plen 4
   status 0x00 handle 1 encrypt 0x00
2009-01-08 11:17:53.021362 < ACL data: handle 1 flags 0x02 dlen 8
   L2CAP(d): cid 0x009c len 4 [psm 3]
     RFCOMM(s): DISC: cr 1 dlci 4 pf 1 ilen 0 fcs 0x77
2009-01-08 11:17:53.139648 > HCI Event: Role Change (0x12) plen 8
   status 0x00 bdaddr 00:1A:0E:7E:6B:70 role 0x01
   Role: Slave
2009-01-08 11:17:53.142120 > HCI Event: Number of Completed Packets
(0x13) plen 5
   handle 1 packets 1
2009-01-08 11:17:53.165161 < ACL data: handle 1 flags 0x02 dlen 12
   L2CAP(s): Disconn req: dcid 0x009b scid 0x0040
2009-01-08 11:17:53.279174 > HCI Event: Encrypt Change (0x08) plen 4
   status 0x00 handle 1 encrypt 0x01

(With Bluetooth 2.1 this is solved with the Encryption pause and
resume LMP command)

Reverting this patch is unfortunate because it leaves us less secure -
we continue happily even if the remote side drops encryption. In
practice this does not normally happen. However we cannot ship a HFP
product with this commit because many CSR headsets like to role
switch. This will be affecting all bluez users that use LM_ENCRYPT or
LM_SECURE with devices that role switch and maybe the best approach is
to also revert this commit in mainline.

The other alternative is to introduce a timer that starts when the
remote side drops encryption. They then have say 5 seconds to complete
a role switch and re-establish encryption, otherwise the RFCOMM link
is dropped. Any other ideas?

Nick



Here is the commit in question:

commit 9719f8afce34d3d04e884873a8a5e3483e30974c
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Mon Jul 14 20:13:45 2008 +0200

    [Bluetooth] Disconnect when encryption gets disabled

    The Bluetooth specification allows to enable or disable the encryption
    of an ACL link at any time by either the peer or the remote device. If
    a L2CAP or RFCOMM connection requested an encrypted link, they will now
    disconnect that link if the encryption gets disabled. Higher protocols
    that don't care about encryption (like SDP) are not affected.

    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
