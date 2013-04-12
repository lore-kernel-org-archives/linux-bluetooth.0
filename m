Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/6] lib: Add attributes MASInstanceID and SupportedMessageTypes
Date: Fri, 12 Apr 2013 11:29:05 +0200
Message-Id: <1365758946-8682-6-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

---
 lib/sdp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/sdp.h b/lib/sdp.h
index baae15f..4ef2176 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -294,6 +294,8 @@ extern "C" {
 #define SDP_ATTR_SUPPORTED_FUNCTIONS		0x0312
 #define SDP_ATTR_TOTAL_IMAGING_DATA_CAPACITY	0x0313
 #define SDP_ATTR_SUPPORTED_REPOSITORIES		0x0314
+#define SDP_ATTR_MAS_INSTANCE_ID		0x0315
+#define SDP_ATTR_SUPPORTED_MESSAGE_TYPES	0x0316
 
 #define SDP_ATTR_SPECIFICATION_ID		0x0200
 #define SDP_ATTR_VENDOR_ID			0x0201
-- 
1.8.2.1

