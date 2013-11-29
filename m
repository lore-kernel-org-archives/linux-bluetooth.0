Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v3 3/7] profiles/network: Rename common.c|h to bnep.c|h
Date: Fri, 29 Nov 2013 11:54:02 +0200
Message-Id: <1385718846-19070-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385718846-19070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385718846-19070-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Files common.c|h contains only bnep related code, it makes
more sence with bnep.c|h.
---
 Makefile.plugins                      | 2 +-
 profiles/network/{common.c => bnep.c} | 2 +-
 profiles/network/{common.h => bnep.h} | 0
 profiles/network/connection.c         | 2 +-
 profiles/network/manager.c            | 2 +-
 profiles/network/server.c             | 2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename profiles/network/{common.c => bnep.c} (99%)
 rename profiles/network/{common.h => bnep.h} (100%)

diff --git a/Makefile.plugins b/Makefile.plugins
index f5025e9..6a1ddbf 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -47,7 +47,7 @@ builtin_sources += profiles/audio/control.h profiles/audio/control.c \
 
 builtin_modules += network
 builtin_sources += profiles/network/manager.c \
-			profiles/network/common.h profiles/network/common.c \
+			profiles/network/bnep.h profiles/network/bnep.c \
 			profiles/network/server.h profiles/network/server.c \
 			profiles/network/connection.h \
 			profiles/network/connection.c
diff --git a/profiles/network/common.c b/profiles/network/bnep.c
similarity index 99%
rename from profiles/network/common.c
rename to profiles/network/bnep.c
index fd25d96..03f9f57 100644
--- a/profiles/network/common.c
+++ b/profiles/network/bnep.c
@@ -43,7 +43,7 @@
 #include <glib.h>
 
 #include "log.h"
-#include "common.h"
+#include "bnep.h"
 #include "lib/uuid.h"
 
 #define CON_SETUP_RETRIES      3
diff --git a/profiles/network/common.h b/profiles/network/bnep.h
similarity index 100%
rename from profiles/network/common.h
rename to profiles/network/bnep.h
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 5723afd..6ad0277 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -47,7 +47,7 @@
 #include "service.h"
 
 #include "error.h"
-#include "common.h"
+#include "bnep.h"
 #include "connection.h"
 
 #define NETWORK_PEER_INTERFACE "org.bluez.Network1"
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index ab4224d..8ac2dec 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -43,7 +43,7 @@
 #include "device.h"
 #include "profile.h"
 #include "service.h"
-#include "common.h"
+#include "bnep.h"
 #include "connection.h"
 #include "server.h"
 
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 3a7e52a..b3aab11 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -48,7 +48,7 @@
 #include "error.h"
 #include "sdpd.h"
 
-#include "common.h"
+#include "bnep.h"
 #include "server.h"
 
 #define NETWORK_SERVER_INTERFACE "org.bluez.NetworkServer1"
-- 
1.8.3.2

