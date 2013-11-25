Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] sdptool: Make code consistent for SPP record add
Date: Mon, 25 Nov 2013 15:14:45 +0200
Message-Id: <1385385285-30592-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385385285-30592-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385385285-30592-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move freeing to the end of the function like it is done for other
records.
---
 tools/sdptool.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index 6682612..b4b65ec 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1174,18 +1174,15 @@ static int add_sp(sdp_session_t *session, svc_info_t *si)
 	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
 	root = sdp_list_append(0, &root_uuid);
 	sdp_set_browse_groups(&record, root);
-	sdp_list_free(root, 0);
 
 	sdp_uuid16_create(&sp_uuid, SERIAL_PORT_SVCLASS_ID);
 	svclass_id = sdp_list_append(0, &sp_uuid);
 	sdp_set_service_classes(&record, svclass_id);
-	sdp_list_free(svclass_id, 0);
 
 	sdp_uuid16_create(&profile.uuid, SERIAL_PORT_PROFILE_ID);
 	profile.version = 0x0100;
 	profiles = sdp_list_append(0, &profile);
 	sdp_set_profile_descs(&record, profiles);
-	sdp_list_free(profiles, 0);
 
 	sdp_uuid16_create(&l2cap, L2CAP_UUID);
 	proto[0] = sdp_list_append(0, &l2cap);
@@ -1226,6 +1223,9 @@ end:
 	sdp_list_free(proto[1], 0);
 	sdp_list_free(apseq, 0);
 	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+	sdp_list_free(profiles, 0);
 
 	return ret;
 }
-- 
1.8.3.2

