Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/1] Remove unneeded Service ID from service SDP record
Date: Thu, 24 Feb 2011 10:50:02 -0800
Message-Id: <1298573402-21739-2-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1298573402-21739-1-git-send-email-bgix@codeaurora.org>
References: <1298573402-21739-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 7ec0f56..08a9b23 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -89,7 +89,7 @@ static uuid_t snd_uuid = {
 static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t end)
 {
 	sdp_list_t *svclass_id, *apseq, *proto[2], *root, *aproto;
-	uuid_t root_uuid, proto_uuid, gatt_uuid, l2cap;
+	uuid_t root_uuid, proto_uuid, l2cap;
 	sdp_record_t *record;
 	sdp_data_t *psm, *sh, *eh;
 	uint16_t lp = GATT_PSM;
@@ -130,8 +130,6 @@ static sdp_record_t *server_record_new(uuid_t *uuid, uint16_t start, uint16_t en
 	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
-	sdp_set_service_id(record, gatt_uuid);
-
 	sdp_data_free(psm);
 	sdp_data_free(sh);
 	sdp_data_free(eh);
-- 
1.7.1

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
