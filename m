Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] sdp-xml: Remove newline before EOF
Date: Tue, 08 Jan 2013 17:07:49 +0530
Message-id: <1357645069-30841-5-git-send-email-s.syam@samsung.com>
In-reply-to: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
References: <1357645069-30841-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/sdp-xml.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/src/sdp-xml.c b/src/sdp-xml.c
index 8cb1e2d..6492781 100644
--- a/src/sdp-xml.c
+++ b/src/sdp-xml.c
@@ -994,4 +994,3 @@ void convert_sdp_record_to_xml(sdp_record_t *rec,
 		appender(data, "</record>\n");
 	}
 }
-
-- 
1.7.9.5

