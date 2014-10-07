Return-Path: <cyrus@holtmann.org>
From: Martin Townsend <mtownsend1973@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: marcel@holtmann.org,
	alex.aring@gmail.com,
	jukka.rissanen@linux.intel.com,
	Martin Townsend <martin.townsend@xsilon.com>
Subject: [PATCH bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC decompression.
Date: Tue,  7 Oct 2014 16:33:56 +0100
Message-Id: <1412696037-25111-1-git-send-email-martin.townsend@xsilon.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch aims to reduce the amount of copying in the receive path when
decompressing by checking for headroom and calling pskb_expand_head if required.
Another benefit of this is that the skb pointer passed to the decompression
routine will be the same skb after decompression.  This will be a step towards
freeing the skb within the receive function and not within all the error paths
of the decompression routine.

Bluetooth and 802.15.4 have been changed to ensure that only one reference
to the skb exists before calling the decompression routine as this is a
requirement of pskb_expand_head.

Martin Townsend (1):
  6lowpan: Use pskb_expand_head in IPHC decompression.

 net/6lowpan/iphc.c            | 53 ++++++++++++++++++++++---------------------
 net/bluetooth/6lowpan.c       | 19 ++++++++++++----
 net/ieee802154/6lowpan_rtnl.c | 13 +++++++++++
 3 files changed, 55 insertions(+), 30 deletions(-)

-- 
1.9.1
