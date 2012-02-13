Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/5] core: Add port to service driver
Date: Mon, 13 Feb 2012 13:37:46 +0200
Message-Id: <1329133070-30003-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add possibility to optional port in addition to channel.
---
 src/service.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/service.h b/src/service.h
index 3dee7d7..5d9d325 100644
--- a/src/service.h
+++ b/src/service.h
@@ -21,10 +21,13 @@
  *
  */
 
+#define OBEX_PORT_RANDOM UINT16_MAX
+
 struct obex_service_driver {
 	const char *name;
 	uint16_t service;
 	uint8_t channel;
+	uint16_t port;
 	gboolean secure;
 	const uint8_t *target;
 	unsigned int target_size;
-- 
1.7.7.6

