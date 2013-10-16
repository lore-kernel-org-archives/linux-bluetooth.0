Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Fix L2CAP command reject PDUs
Date: Wed, 16 Oct 2013 11:06:38 +0300
Message-Id: <1381910801-3130-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The L2CAP command reject PDU is required to have some extra data for
"invalid MTU" and "invalid CID" cases. These patches fixes the code to
always return the right kind of PDU.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Fix L2CAP "Command Reject: Invalid CID" response
      Bluetooth: Remove unused command reject mapping for EMSGSIZE
      Bluetooth: Remove useless l2cap_err_to_reason function

 net/bluetooth/l2cap_core.c | 54 +++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 29 deletions(-)

