Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/client: Print peer and CHLD features only on connected event
Date: Mon,  6 Oct 2014 12:34:14 +0200
Message-Id: <1412591654-10250-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We want to print peer and CHLD features are only when client gets
connected event. Otherwise it might be confusing as those fields are not
set.
---
 android/client/if-hf-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index 07c09cd..0f4f3e9 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -203,6 +203,10 @@ static void hf_client_connection_state_callback(
 	haltest_info("%s: state=%s bd_addr=%s\n", __func__,
 				bthf_client_connection_state_t2str(state),
 				bt_bdaddr_t2str(bd_addr, last_addr));
+
+	if ( state != BTHF_CLIENT_CONNECTION_STATE_CONNECTED)
+		return;
+
 	haltest_info("\tpeer_features%s\n", pear_features_t2str(peer_feat));
 	haltest_info("\tchld_feat=%s\n", chld_features_t2str(chld_feat));
 }
-- 
1.8.4

