Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Set correct adapter state in cancel_resolve_name
Date: Thu, 17 Mar 2011 15:20:39 +0200
Message-Id: <1300368039-1376-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously resetting STATE_RESOLVNAME for adapter was missing.
This was causing problems with discovering devices when discovery
was quickly turned off/on during resolving name.
---
 src/adapter.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8c368fe..cc4f43e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -260,6 +260,7 @@ static int pending_remote_name_cancel(struct btd_adapter *adapter)
 	if (!dev) /* no pending request */
 		return -ENODATA;
 
+	adapter->state &= ~STATE_RESOLVNAME;
 	err = adapter_ops->cancel_resolve_name(adapter->dev_id, &dev->bdaddr);
 	if (err < 0)
 		error("Remote name cancel failed: %s(%d)",
-- 
1.7.0.4

