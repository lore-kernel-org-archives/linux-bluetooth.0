Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1511801117.14298.4.camel@ewol.com>
Subject: [PATCH BlueZ] mesh: Correct typo in config op defines
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 27 Nov 2017 09:45:17 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/mesh/config-model.h b/mesh/config-model.h
index be7acabb9..d7ee5e61f 100644
--- a/mesh/config-model.h
+++ b/mesh/config-model.h
@@ -93,7 +93,7 @@
 #define OP_NODE_RESET_STATUS			0x804A
 #define OP_MODEL_APP_GET			0x804B
 #define OP_MODEL_APP_LIST			0x804C
-#define OP_VEND_MODEL_APP_GET			0x804C
+#define OP_VEND_MODEL_APP_GET			0x804D
 #define OP_VEND_MODEL_APP_LIST			0x804E
 
 bool config_server_init(void);
