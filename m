Return-Path: <cyrus@holtmann.org>
From: Martin Townsend <mtownsend1973@gmail.com>
To: linux-zigbee-devel@lists.sourceforge.net,
	linux-bluetooth@vger.kernel.org
Cc: Martin Townsend <martin.townsend@xsilon.com>
Subject: [PATCH 0/2] linux-wpan-next: lowpan_rcv - skb is freed within function and fix return values.
Date: Wed, 30 Jul 2014 15:55:03 +0100
Message-Id: <1406732105-17500-1-git-send-email-martin.townsend@xsilon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently it is up to the functions below lowpan_rcv to free the skb on error
    conditions.  This patch now removes all the UAPI error codes and process data
    now returns -1 if there is a problem.  In this scenario lowpan_rcv will free
    the skb and return NET_RX_DROP.  This also fixes the problem where
    NET_RX_SUCCESS is returned on error

Martin Townsend (2):
  Remove dev parameter from skb_delivery_cb in 6lowpan.
  Change lowpan_rcv so skb is freed within function and fix return
    values.

 include/net/6lowpan.h         |  4 ++--
 net/6lowpan/iphc.c            | 37 ++++++++++++++++++------------------
 net/bluetooth/6lowpan.c       | 21 ++++++++++-----------
 net/ieee802154/6lowpan_rtnl.c | 44 +++++++++++++++++++++----------------------
 4 files changed, 52 insertions(+), 54 deletions(-)

-- 
1.9.1

