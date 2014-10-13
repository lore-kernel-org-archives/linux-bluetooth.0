Return-Path: <cyrus@holtmann.org>
From: Martin Townsend <mtownsend1973@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org,
	alex.aring@gmail.com,
	jukka.rissanen@linux.intel.com,
	Martin Townsend <martin.townsend@xsilon.com>
Subject: [PATCH v6 bluetooth-next]  6lowpan: Use skb_cow in IPHC decompression.
Date: Mon, 13 Oct 2014 11:00:55 +0100
Message-Id: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch aims to reduce the amount of copying in the receive path when
decompressing by checking for headroom and calling pskb_expand_head if required.
Another benefit of this is that the skb pointer passed to the decompression
routine will be the same skb after decompression.  This will be a step towards
freeing the skb within the receive function and not within all the error paths
of the decompression routine.

Bluetooth and 802.15.4 have been changed to ensure that the skb isn't shared
before calling the decompression routine as this is a requirement of
pskb_expand_head.

v1 -> v2
Use const int for new headroom size.
Remove blank line.
Use skb_unshare instead of skb_copy_expand. 
Use consume_skb.

v2 -> v3 
Remove cases where we are trying to free a NULL skb.

v3 -> v4
Now uses skb_share_check to ensure the skb isn't shared before decompressing

v4 -> v5
Remove skb_share_check from 802.15.4 lowpan_rcv as it's already done at the
top of the function.

v5 -> v6
Use skb_cow instead of pskb_expand_head, adjusted commit message to reflect
this.
Moved skb_share_check to start of recv_pkt function for bluetooth.

Martin Townsend (1):
  6lowpan: Use skb_cow in IPHC decompression.

 net/6lowpan/iphc.c      | 47 +++++++++++++++++++++--------------------------
 net/bluetooth/6lowpan.c |  4 ++++
 2 files changed, 25 insertions(+), 26 deletions(-)

-- 
1.9.1
