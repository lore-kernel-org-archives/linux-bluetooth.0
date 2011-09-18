Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH] Fix crash when update service record with an invalid XML
Date: Sun, 18 Sep 2011 14:59:15 +0530
Message-Id: <1316338155-3862-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we pass an invalid xml to sdp_xml_parse_record(), then it returns
NULL. Further we are passing the this NULL pointer to the
sdp_record_free(), which leads to invalid memory access.
---
 plugins/service.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index d73cdea..14a5cb6 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -436,7 +436,6 @@ static DBusMessage *update_xml_record(DBusConnection *conn,
 	sdp_record = sdp_xml_parse_record(record, len);
 	if (!sdp_record) {
 		error("Parsing of XML service record failed");
-		sdp_record_free(sdp_record);
 		return btd_error_failed(msg,
 					"Parsing of XML service record failed");
 	}
-- 
1.7.4.1

