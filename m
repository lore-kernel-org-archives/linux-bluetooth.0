Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/7] profiles/AVRCP: Add AV Remote Controller service class id to CT
Date: Wed,  9 Oct 2013 14:11:43 +0300
Message-Id: <1381317105-10729-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
References: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both AV Remote and AV Remote Controller service classes are mandatory
by AVRCP CT role from 1.3 onwards. Also the assigned numbers page mention
that AV Remote must appear before AV Remote Controller:

  "The AVRCP specification v1.3 and later require that 0x110E also be
  included in the ServiceClassIDList before 0x110F for backwards
  compatibility."
---
 profiles/audio/avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b1b2ae6..296067c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -263,7 +263,7 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event);
 static sdp_record_t *avrcp_ct_record(void)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *apseq1, *root;
-	uuid_t root_uuid, l2cap, avctp, avrct;
+	uuid_t root_uuid, l2cap, avctp, avrct, avrctr;
 	sdp_profile_desc_t profile[1];
 	sdp_list_t *aproto, *aproto1, *proto[2], *proto1[2];
 	sdp_record_t *record;
@@ -287,6 +287,8 @@ static sdp_record_t *avrcp_ct_record(void)
 	/* Service Class ID List */
 	sdp_uuid16_create(&avrct, AV_REMOTE_SVCLASS_ID);
 	svclass_id = sdp_list_append(0, &avrct);
+	sdp_uuid16_create(&avrctr, AV_REMOTE_CONTROLLER_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &avrctr);
 	sdp_set_service_classes(record, svclass_id);
 
 	/* Protocol Descriptor List */
-- 
1.8.3.1

