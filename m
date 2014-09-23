Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/5] android/client: Handle handsfree client connecton state callback
Date: Tue, 23 Sep 2014 08:49:37 +0200
Message-Id: <1411454980-27225-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411454980-27225-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hf-client.c | 69 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index 38ae42a..528609d 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -22,6 +22,69 @@ const bthf_client_interface_t *if_hf_client = NULL;
 
 static char last_addr[MAX_ADDR_STR_LEN];
 
+SINTMAP(bthf_client_connection_state_t, -1, "(unknown)")
+	DELEMENT(BTHF_CLIENT_CONNECTION_STATE_DISCONNECTED),
+	DELEMENT(BTHF_CLIENT_CONNECTION_STATE_CONNECTING),
+	DELEMENT(BTHF_CLIENT_CONNECTION_STATE_CONNECTED),
+	DELEMENT(BTHF_CLIENT_CONNECTION_STATE_SLC_CONNECTED),
+	DELEMENT(BTHF_CLIENT_CONNECTION_STATE_DISCONNECTING),
+ENDMAP
+
+/* Callbacks */
+
+static char features_str[512];
+
+static const char *pear_features_t2str(int feat)
+{
+	memset(features_str, 0, sizeof(features_str));
+
+	sprintf(features_str, "BTHF_CLIENT_PEER_FEAT_3WAY: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_ECNR: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_VREC: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_INBAND: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_VTAG: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_REJECT: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_ECS: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_ECC: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_EXTERR: %s,\n"
+			"BTHF_CLIENT_PEER_FEAT_CODEC: %s,\n",
+			feat & BTHF_CLIENT_PEER_FEAT_3WAY ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_ECNR ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_VREC ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_INBAND ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_VTAG ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_REJECT ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_ECS ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_ECC ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_EXTERR ? "True" : "False",
+			feat & BTHF_CLIENT_PEER_FEAT_CODEC ? "True" : "False");
+
+	return features_str;
+}
+
+static const char *chld_features_t2str(int feat)
+{
+	memset(features_str, 0, sizeof(features_str));
+
+	sprintf(features_str,
+		"BTHF_CLIENT_CHLD_FEAT_REL: %s,\n"
+		"BTHF_CLIENT_CHLD_FEAT_REL_ACC: %s,\n"
+		"BTHF_CLIENT_CHLD_FEAT_REL_X: %s,\n"
+		"BTHF_CLIENT_CHLD_FEAT_HOLD_ACC: %s,\n"
+		"BTHF_CLIENT_CHLD_FEAT_PRIV_X: %s,\n"
+		"BTHF_CLIENT_CHLD_FEAT_MERGE: %s,\n"
+		"BTHF_CLIENT_CHLD_FEAT_MERGE_DETACH: %s,\n",
+		feat & BTHF_CLIENT_CHLD_FEAT_REL ? "True" : "False",
+		feat & BTHF_CLIENT_CHLD_FEAT_REL_ACC ? "True" : "False",
+		feat & BTHF_CLIENT_CHLD_FEAT_REL_X ? "True" : "False",
+		feat & BTHF_CLIENT_CHLD_FEAT_HOLD_ACC ? "True" : "False",
+		feat & BTHF_CLIENT_CHLD_FEAT_PRIV_X ? "True" : "False",
+		feat & BTHF_CLIENT_CHLD_FEAT_MERGE ? "True" : "False",
+		feat & BTHF_CLIENT_CHLD_FEAT_MERGE_DETACH ? "True" : "False");
+
+	return features_str;
+}
+
 /* Callback for connection state change. */
 static void hf_client_connection_state_callback(
 					bthf_client_connection_state_t state,
@@ -29,7 +92,11 @@ static void hf_client_connection_state_callback(
 					unsigned int chld_feat,
 					bt_bdaddr_t *bd_addr)
 {
-	haltest_info("%s\n", __func__);
+	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
+				bthf_client_connection_state_t2str(state),
+				bt_bdaddr_t2str(bd_addr, last_addr));
+	haltest_info("\tpeer_features%s\n", pear_features_t2str(peer_feat));
+	haltest_info("\tchld_feat=%s\n", chld_features_t2str(chld_feat));
 }
 
 /* Callback for audio connection state change. */
-- 
1.9.1

