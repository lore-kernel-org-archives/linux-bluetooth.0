Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: sbrown@cortland.com
To: linux-bluetooth@vger.kernel.org
Cc: Steve Brown <sbrown@cortland.com>
Subject: [PATCH 2/2] mesh: Add heartbeat message display
Date: Tue, 17 Oct 2017 09:58:31 -0400
Message-Id: <20171017135831.31179-3-sbrown@cortland.com>
In-Reply-To: <20171017135831.31179-1-sbrown@cortland.com>
References: <20171017135831.31179-1-sbrown@cortland.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Steve Brown <sbrown@cortland.com>

---

Not too sure where to put this until subscribe is fully implemented.
---
 mesh/net.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mesh/net.c b/mesh/net.c
index 96e82fe1c..9b349b954 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -1399,6 +1399,24 @@ static bool ctl_rxed(uint16_t net_idx, uint32_t iv_index,
 		uint8_t *trans, uint16_t len)
 {
 	/* TODO: Handle control messages */
+
+	/* Per Mesh Profile 3.6.5.10 */
+	if (trans[0] == NET_OP_HEARTBEAT) {
+		uint16_t feat = get_be16(trans + 2);
+
+		rl_printf("HEARTBEAT src: %4.4x dst: %4.4x "
+				"TTL: %2.2x feat: %s%s%s%s\n",
+				src, dst, trans[1],
+				(feat & MESH_FEATURE_RELAY) ? "relay " : "",
+				(feat & MESH_FEATURE_PROXY) ? "proxy " : "",
+				(feat & MESH_FEATURE_FRIEND) ? "friend " : "",
+				(feat & MESH_FEATURE_LPN) ? "lpn" : "");
+		return true;
+	}
+
+	rl_printf("unrecognized control message src:%4.4x dst:%4.4x len:%d\n",
+			src, dst, len);
+	print_byte_array("msg: ", trans, len);
 	return false;
 }
 
-- 
2.11.0

