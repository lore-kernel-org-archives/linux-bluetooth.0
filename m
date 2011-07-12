Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Move attrib server init/exit declaration to hcid.h
Date: Tue, 12 Jul 2011 16:05:18 -0300
Message-Id: <1310497518-19526-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Avoids GATT/ATT headers dependency in main.c.
---
 src/attrib-server.h |    3 ---
 src/hcid.h          |    3 +++
 src/main.c          |    1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/attrib-server.h b/src/attrib-server.h
index 83484fc..cde6eff 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -22,9 +22,6 @@
  *
  */
 
-int attrib_server_init(void);
-void attrib_server_exit(void);
-
 uint16_t attrib_db_find_avail(uint16_t nitems);
 struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len);
diff --git a/src/hcid.h b/src/hcid.h
index fcfd45b..ea038e9 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -63,3 +63,6 @@ void plugin_cleanup(void);
 
 void rfkill_init(void);
 void rfkill_exit(void);
+
+int attrib_server_init(void);
+void attrib_server_exit(void);
diff --git a/src/main.c b/src/main.c
index e451e72..b161a98 100644
--- a/src/main.c
+++ b/src/main.c
@@ -49,7 +49,6 @@
 
 #include "hcid.h"
 #include "sdpd.h"
-#include "attrib-server.h"
 #include "adapter.h"
 #include "dbus-common.h"
 #include "agent.h"
-- 
1.7.6

