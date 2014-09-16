Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 7/8] android/tester: Make avrcp use sdp pdu sending helper
Date: Tue, 16 Sep 2014 10:49:36 +0200
Message-Id: <1410857377-3162-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes any potential issues with the sdp response transaction id not
matching the request.
---
 android/tester-avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 46c92e3..6beab7d 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -173,8 +173,8 @@ static void sdp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
 	struct emu_cid_data *cid_data = user_data;
 
-	bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
-					sdp_rsp_pdu.data, sdp_rsp_pdu.size);
+	tester_send_sdp_pdu(bthost, cid_data->handle, cid_data->cid,
+					get_be16(data + 1), &sdp_rsp_pdu);
 }
 static void sdp_connect_request_cb(uint16_t handle, uint16_t cid,
 							void *user_data)
-- 
1.9.3

