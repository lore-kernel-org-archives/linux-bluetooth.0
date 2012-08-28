Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] Fix redundant NULL checks in convert_raw_attr_to_xml_func
Date: Tue, 28 Aug 2012 15:33:15 +0200
Message-ID: <1346160796-23277-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Param data can't be NULL and was already dereferenced before check.

---
 src/sdp-xml.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index d7b2aef..52df285 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -377,10 +377,7 @@ static void convert_raw_attr_to_xml_func(void *val, void *data)
 		 value->attrId);
 	cd->appender(cd->data, buf);
 
-	if (data)
-		convert_raw_data_to_xml(value, 2, cd->data, cd->appender);
-	else
-		cd->appender(cd->data, "\t\tNULL\n");
+	convert_raw_data_to_xml(value, 2, cd->data, cd->appender);
 
 	cd->appender(cd->data, "\t</attribute>\n");
 }
-- 
1.7.9.5

