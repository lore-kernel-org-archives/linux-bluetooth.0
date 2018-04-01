Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh/meshctl: Fix reclaiming address range
Date: Sun,  1 Apr 2018 16:35:33 -0700
Message-Id: <20180401233533.20526-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The computations for reclaiming released unicast addresses back
into address pool were off by 1. Also, the adjacent pools need
to be merged, if the released range fills the gap between two
address pools.
---
 mesh/net.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 20dfcb8a8..85c4b715b 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -730,7 +730,7 @@ static int match_address_range(const void *a, const void *b)
 	uint16_t max = range >> 16;
 	uint16_t min = range & 0xffff;
 
-	return ((max - min) >= (num_elements - 1)) ? 0 : -1;
+	return ((max - min + 1) >= num_elements) ? 0 : -1;
 
 }
 
@@ -749,13 +749,14 @@ uint16_t net_obtain_address(uint8_t num_eles)
 		addr = min;
 		min += num_eles;
 
-		if (min > max)
+		if (min > max) {
 			net.address_pool = g_list_delete_link(net.address_pool,
 								l);
-		else {
+		} else {
 			range = min + (max << 16);
 			l->data = GUINT_TO_POINTER(range);
 		}
+
 		return addr;
 	}
 
@@ -775,23 +776,42 @@ void net_release_address(uint16_t addr, uint8_t num_elements)
 	GList *l;
 	uint32_t range;
 
+	if (addr == UNASSIGNED_ADDRESS)
+		return;
+
 	for (l = net.address_pool; l != NULL; l = l->next)
 	{
 		uint16_t max;
 		uint16_t min;
+		GList *l1 = l->next;
 
 		range = GPOINTER_TO_UINT(l->data);
 
 		max = range >> 16;
 		min = range & 0xffff;
 
-		if (min == (addr + num_elements + 1))
+		if (min == (addr + num_elements))
 			min  = addr;
-		else if (addr && max == (addr - 1))
-			max = addr + num_elements + 1;
+		else if (max == (addr - 1))
+			max = addr + num_elements;
 		else
 			continue;
 
+		/* Check if range pools need to be merged */
+		if (l1) {
+			uint16_t min1;
+
+			range = GPOINTER_TO_UINT(l1->data);
+			min1 = range & 0xffff;
+
+			if (min1 == (max + 1)) {
+				max = range >> 16;
+				l->next = l1->next;
+				net.address_pool = g_list_delete_link(
+							net.address_pool, l1);
+			}
+		}
+
 		range = min + (max << 16);
 		l->data = GUINT_TO_POINTER(range);
 		return;
-- 
2.14.3

