Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Inga Stotland <inga.stotland@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ] mesh: Add config server response for loopback
Date: Mon, 30 Oct 2017 11:56:38 -0700
Message-Id: <20171030185638.20168-1-inga.stotland@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/config-server.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mesh/config-server.c b/mesh/config-server.c
index 8a88645e4..938ec2275 100644
--- a/mesh/config-server.c
+++ b/mesh/config-server.c
@@ -141,10 +141,17 @@ static bool server_msg_recvd(uint16_t src, uint8_t *data,
 		break;
 	}
 
+	if (!n)
+		return true;
+
 	primary = node_get_primary(node);
-	if (n && src != primary)
+	if (src != primary)
 		net_access_layer_send(node_get_default_ttl(node), primary,
 					src, APP_IDX_DEV, msg, n);
+	else
+		node_local_data_handler(primary, src, node_get_iv_index(node),
+					node_get_sequence_number(node),
+					APP_IDX_DEV, msg, n);
 	return true;
 }
 
-- 
2.13.6

