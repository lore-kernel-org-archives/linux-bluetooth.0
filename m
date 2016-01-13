Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Lukasz Duda <lukasz.duda@nordicsemi.no>
To: <alex.aring@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
	<glenn.ruben.bakke@nordicsemi.no>
Subject: [PATCH] Bluetooth: 6lowpan: Fix handling of uncompressed IPv6 packets
Date: Wed, 13 Jan 2016 16:57:48 +0100
Message-ID: <1452700668-4241-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes incorrect handling of the 6lowpan packets that contain
uncompressed IPv6 header.

RFC4944 specifies a special dispatch for 6lowpan to carry uncompressed
IPv6 header. This dispatch (1 byte long) has to be removed during
reception and skb data pointer has to be moved. To correctly point in
the beginning of the IPv6 header the dispatch byte has to be pulled off
before packet can be processed by netif_rx_in().

Test scenario: IPv6 packets are not correctly interpreted by the network
layer when IPv6 header is not compressed (e.g. ICMPv6 Echo Reply is not
propagated correctly to the ICMPv6 layer because the extra byte will make
the header look corrupted).

Similar approach is done for IEEE 802.15.4.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/bluetooth/6lowpan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d040365..350f379 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -307,6 +307,9 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
 
 	/* check that it's our buffer */
 	if (lowpan_is_ipv6(*skb_network_header(skb))) {
+		/* Pull off the 1-byte of 6lowpan header. */
+		skb_pull(skb, 1);
+
 		/* Copy the packet so that the IPv6 header is
 		 * properly aligned.
 		 */
-- 
2.5.0

