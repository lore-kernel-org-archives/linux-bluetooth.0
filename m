Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 18/35] unit/test-avrcp: Add /TP/MCN/CB/BI-04-C test
Date: Fri, 25 Apr 2014 11:38:55 +0300
Message-Id: <1398415152-22950-19-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
References: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To verify the ChangePath response issued by the TG when an invalid Folder
UID is requested.
---
 unit/test-avrcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-avrcp.c b/unit/test-avrcp.c
index 2d51779..1cde8fb 100644
--- a/unit/test-avrcp.c
+++ b/unit/test-avrcp.c
@@ -573,6 +573,9 @@ static int change_path(struct avrcp *session, uint8_t transaction,
 {
 	DBG("");
 
+	if (!uid)
+		return -ENOTDIR;
+
 	avrcp_change_path_rsp(session, transaction, 0);
 
 	return -EAGAIN;
@@ -841,6 +844,17 @@ int main(int argc, char *argv[])
 			brs_pdu(0x02, 0x11, 0x0e, AVRCP_GET_FOLDER_ITEMS,
 				0x00, 0x01, 0x0b));
 
+	/* ChangePath - TG */
+	define_test("/TP/MCN/CB/BI-04-C", test_server,
+			brs_pdu(0x00, 0x11, 0x0e, AVRCP_CHANGE_PATH,
+				0x00, 0x0b,
+				0xaa, 0xbb,		/* counter */
+				0x01,			/* direction */
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00	/* Folder UID */),
+			brs_pdu(0x02, 0x11, 0x0e, AVRCP_CHANGE_PATH,
+				0x00, 0x01, 0x08));
+
 	/* Media Content Navigation Commands and Notifications for Search */
 
 	/* Search - CT */
-- 
1.9.0

