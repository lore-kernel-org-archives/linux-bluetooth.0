Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] core: Make adapter_ops->set_discoverable to take discoverable timeout
Date: Tue, 28 Feb 2012 13:23:21 +0200
Message-Id: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables the driver to implements its own handling of the timeout
---
 src/adapter.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/adapter.h b/src/adapter.h
index 22bb0bb..7acd14d 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -181,7 +181,8 @@ struct btd_adapter_ops {
 	int (*setup) (void);
 	void (*cleanup) (void);
 	int (*set_powered) (int index, gboolean powered);
-	int (*set_discoverable) (int index, gboolean discoverable);
+	int (*set_discoverable) (int index, gboolean discoverable,
+							uint16_t timeout);
 	int (*set_pairable) (int index, gboolean pairable);
 	int (*set_limited_discoverable) (int index, gboolean limited);
 	int (*start_discovery) (int index);
-- 
1.7.7.6

