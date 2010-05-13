Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Avoid multiple inclusions of adapter.h
Date: Thu, 13 May 2010 12:38:56 +0200
Message-Id: <1273747136-8816-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/adapter.h b/src/adapter.h
index 9b4ce10..8812ed8 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -22,6 +22,9 @@
  *
  */
 
+#ifndef __ADAPTER_H__
+#define __ADAPTER_H__
+
 #include <bluetooth/bluetooth.h>
 #include <dbus/dbus.h>
 #include <glib.h>
@@ -183,3 +186,5 @@ struct btd_adapter_ops {
 int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops);
 void btd_adapter_cleanup_ops(struct btd_adapter_ops *btd_adapter_ops);
 int adapter_ops_setup(void);
+
+#endif /* __ADAPTER_H__ */
-- 
1.6.3.3

