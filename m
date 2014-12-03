Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] obexd: Fix memory leak not freeing desc
Date: Wed,  3 Dec 2014 16:08:52 +0200
Message-Id: <1417615733-7350-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1417615733-7350-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

descs->data might be NULL while is descs not. Follow scheme in
src/profile.c (in get_profile_version() function).
---
 obexd/client/bluetooth.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index 589d7a5..8e09d03 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -486,6 +486,7 @@ static const void *bluetooth_getattribute(guint id, int attribute_id)
 		/* Read version since UUID is already known */
 		if (attribute_id == SDP_ATTR_PFILE_DESC_LIST) {
 			sdp_list_t *descs;
+			void *ret = NULL;
 
 			if (sdp_get_profile_descs(session->sdp_record,
 								&descs) < 0)
@@ -493,14 +494,12 @@ static const void *bluetooth_getattribute(guint id, int attribute_id)
 
 			if (descs && descs->data) {
 				sdp_profile_desc_t *desc = descs->data;
-				uint16_t version = desc->version;
-
-				sdp_list_free(descs, free);
-
-				return GINT_TO_POINTER(version);
+				ret = GINT_TO_POINTER(desc->version);
 			}
 
-			return NULL;
+			sdp_list_free(descs, free);
+
+			return ret;
 		}
 
 		data = sdp_data_get(session->sdp_record, attribute_id);
-- 
1.9.1

