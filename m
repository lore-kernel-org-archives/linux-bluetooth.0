Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 3/4] gatt: Return not found if characteritics is empty
Date: Mon, 20 Aug 2012 14:32:21 -0300
Message-Id: <1345483942-27973-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345483942-27973-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the behaviour of Discover All Characteristics and
Discover Characteristics by UUID returning <<Attribute Not Found>> when
Characteristic list that matches the defined criteria is empty. This
scenario can happen when the GATT client avoids extra iteraction with
the remote attribute server if the last received handle(or handle + 1)
is equal to the end handle of the primary service.
---
 attrib/gatt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 9ab283f..aea59ec 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -302,7 +302,6 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 	}
 
 	att_data_list_free(list);
-	err = 0;
 
 	if (last != 0 && (last + 1 < dc->end)) {
 		buf = g_attrib_get_buffer(dc->attrib, &buflen);
@@ -321,6 +320,8 @@ static void char_discovered_cb(guint8 status, const guint8 *ipdu, guint16 iplen,
 		return;
 	}
 
+	err = (dc->characteristics ? 0 : ATT_ECODE_ATTR_NOT_FOUND);
+
 done:
 	dc->cb(dc->characteristics, err, dc->user_data);
 	discover_char_free(dc);
-- 
1.7.8.6

