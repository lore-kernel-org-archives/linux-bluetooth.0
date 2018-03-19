Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] Mesh: Fix reclaiming addresses when deleting a node
Date: Mon, 19 Mar 2018 00:14:12 -0700
Message-Id: <20180319071412.5269-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The calculations for address pool edges were off by 1.
Also, handle a case when newly adjacent address pools need to be merged.
---
 mesh/net.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 20dfcb8a8..b64847fe1 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -785,11 +785,25 @@ void net_release_address(uint16_t addr, uint8_t num_elements)
 		max = range >> 16;
 		min = range & 0xffff;
 
-		if (min == (addr + num_elements + 1))
-			min  = addr;
-		else if (addr && max == (addr - 1))
-			max = addr + num_elements + 1;
-		else
+		if (min == (addr + num_elements))
+			min = addr;
+		else if (addr && max == (addr - 1)) {
+			max = max + num_elements;
+
+			/* Check if needs to merge with the next pool */
+			if (l->next) {
+				GList *l1 = l->next;
+				uint32_t range1 = GPOINTER_TO_UINT(l1->data);
+				uint16_t min1 = range1 & 0xffff;
+
+				if (min1 == (max + 1)) {
+					max = range1 >> 16;
+					net.address_pool = g_list_delete_link(
+							net.address_pool, l);
+					l = l1;
+				}
+			}
+		} else
 			continue;
 
 		range = min + (max << 16);
-- 
2.13.6

