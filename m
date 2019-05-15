Return-Path: <SRS0=OL4k=TP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFCAC04E53
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 19:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 912C020873
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 19:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfEOTAd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 May 2019 15:00:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:27572 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfEOTAd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 May 2019 15:00:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 12:00:32 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.254.97.211])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2019 12:00:31 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/2] mesh: Remove unnecessary includes from .c files
Date:   Wed, 15 May 2019 12:00:19 -0700
Message-Id: <20190515190019.19710-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515190019.19710-1-inga.stotland@intel.com>
References: <20190515190019.19710-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/agent.c           |  1 -
 mesh/appkey.c          |  2 --
 mesh/cfgmod-server.c   |  5 -----
 mesh/crypto.c          |  2 --
 mesh/dbus.c            | 10 ----------
 mesh/friend.c          |  6 ------
 mesh/keyring.c         |  7 +------
 mesh/main.c            |  7 -------
 mesh/mesh-db.c         |  1 -
 mesh/mesh-io-generic.c |  4 ----
 mesh/mesh-io.c         |  2 --
 mesh/mesh.c            |  3 +--
 mesh/net-keys.c        |  1 -
 mesh/net.c             |  9 +--------
 mesh/node.c            |  6 ++----
 mesh/pb-adv.c          | 16 ----------------
 mesh/prov-acceptor.c   | 16 +---------------
 mesh/prov-initiator.c  | 16 +---------------
 mesh/storage.c         | 11 ++---------
 mesh/util.c            |  6 +-----
 20 files changed, 10 insertions(+), 121 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index b94ae77b0..4f99bad7b 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -24,7 +24,6 @@
 #include <ell/ell.h>
 
 #include "mesh/mesh.h"
-#include "mesh/provision.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
 #include "mesh/agent.h"
diff --git a/mesh/appkey.c b/mesh/appkey.c
index edf815c5a..412a2c48c 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -23,11 +23,9 @@
 
 #define _GNU_SOURCE
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 
-#include "mesh/mesh.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
 #include "mesh/crypto.h"
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index a693881e5..060d7f4e4 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -21,17 +21,12 @@
 #include <config.h>
 #endif
 
-#include <unistd.h>
-#include <stdio.h>
-#include <stdint.h>
 #include <sys/time.h>
 #include <ell/ell.h>
-#include <ell/ell.h>
 
 #include "json-c/json.h"
 
 #include "mesh/mesh-defs.h"
-#include "mesh/mesh.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
 #include "mesh/appkey.h"
diff --git a/mesh/crypto.c b/mesh/crypto.c
index f36518f68..085e72798 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -22,9 +22,7 @@
 #endif
 
 #define _GNU_SOURCE
-#include <fcntl.h>
 #include <unistd.h>
-#include <string.h>
 #include <sys/socket.h>
 #include <ell/ell.h>
 
diff --git a/mesh/dbus.c b/mesh/dbus.c
index 083a7f77e..2b700a1ad 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -21,21 +21,11 @@
 #include <config.h>
 #endif
 
-#include <time.h>
 #include <ell/ell.h>
-#include <json-c/json.h>
-
-#include "lib/bluetooth.h"
-#include "lib/mgmt.h"
-
-#include "src/shared/mgmt.h"
 
 #include "mesh/mesh-defs.h"
-#include "mesh/mesh-io.h"
 #include "mesh/node.h"
 #include "mesh/manager.h"
-#include "mesh/net.h"
-#include "mesh/cfgmod.h"
 #include "mesh/mesh.h"
 #include "mesh/error.h"
 #include "mesh/dbus.h"
diff --git a/mesh/friend.c b/mesh/friend.c
index 84a75a13b..da2772870 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -21,18 +21,12 @@
 #include <config.h>
 #endif
 
-#include <unistd.h>
-#include <stdio.h>
-#include <sys/time.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
 
-#include "mesh/mesh.h"
 #include "mesh/net-keys.h"
-#include "mesh/node.h"
 #include "mesh/net.h"
-#include "mesh/crypto.h"
 #include "mesh/model.h"
 #include "mesh/util.h"
 
diff --git a/mesh/keyring.c b/mesh/keyring.c
index 4b1460aa8..4c6d2986d 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -22,24 +22,19 @@
 #endif
 
 #define _GNU_SOURCE
-#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <dirent.h>
-#include <libgen.h>
 
-#include <sys/types.h>
 #include <sys/stat.h>
 
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
 
-#include "mesh/net.h"
-#include "mesh/keyring.h"
-#include "mesh/mesh.h"
 #include "mesh/node.h"
+#include "mesh/keyring.h"
 
 const char *dev_key_dir = "/dev_keys";
 const char *app_key_dir = "/app_keys";
diff --git a/mesh/main.c b/mesh/main.c
index 93a646895..a621300e6 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -23,25 +23,18 @@
 
 #define _GNU_SOURCE
 #include <getopt.h>
-#include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <ctype.h>
-#include <signal.h>
 
 #include <sys/stat.h>
 #include <ell/ell.h>
 
-#include <dbus/dbus.h>
-#include <json-c/json.h>
-
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
 
 #include "mesh/mesh.h"
-#include "mesh/net.h"
 #include "mesh/dbus.h"
-#include "mesh/storage.h"
 
 static const struct option main_options[] = {
 	{ "index",	required_argument,	NULL, 'i' },
diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 255a2e23e..5b2868fdb 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -23,7 +23,6 @@
 
 #define _GNU_SOURCE
 #include <errno.h>
-#include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
 
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 1a42c593f..756dceabc 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -24,15 +24,11 @@
 #include <sys/time.h>
 #include <ell/ell.h>
 
-#include "lib/bluetooth.h"
-#include "lib/hci.h"
-
 #include "monitor/bt.h"
 #include "src/shared/hci.h"
 
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
-
 #include "mesh/mesh-io-generic.h"
 
 struct mesh_io_private {
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 8cf6c486a..37153ea9d 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -24,10 +24,8 @@
 #include <ell/ell.h>
 
 #include "lib/bluetooth.h"
-#include "lib/hci.h"
 
 #include "mesh/mesh-defs.h"
-
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
 
diff --git a/mesh/mesh.c b/mesh/mesh.c
index d5b6197b6..231a6bca4 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -23,7 +23,6 @@
 
 #define _GNU_SOURCE
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "lib/bluetooth.h"
 #include "lib/mgmt.h"
@@ -38,8 +37,8 @@
 #include "mesh/model.h"
 #include "mesh/dbus.h"
 #include "mesh/error.h"
-#include "mesh/mesh.h"
 #include "mesh/agent.h"
+#include "mesh/mesh.h"
 
 /*
  * The default values for mesh configuration. Can be
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 0a0e58fb4..25f4caeb7 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -21,7 +21,6 @@
 #include <config.h>
 #endif
 
-#include <stdlib.h>
 #include <ell/ell.h>
 
 #include "mesh/crypto.h"
diff --git a/mesh/net.c b/mesh/net.c
index d808e9bd4..c7aff9ab4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -22,18 +22,13 @@
 #endif
 
 #define _GNU_SOURCE
-#include <stdlib.h>
-#include <stdio.h>
-#include <sys/time.h>
+
 #include <ell/ell.h>
-#include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
 #include "mesh/util.h"
-
 #include "mesh/crypto.h"
 #include "mesh/net-keys.h"
-#include "mesh/mesh.h"
 #include "mesh/node.h"
 #include "mesh/net.h"
 #include "mesh/mesh-io.h"
@@ -41,8 +36,6 @@
 #include "mesh/storage.h"
 #include "mesh/model.h"
 #include "mesh/appkey.h"
-#include "mesh/prov.h"
-#include "mesh/provision.h"
 
 #define abs_diff(a, b) ((a) > (b) ? (a) - (b) : (b) - (a))
 
diff --git a/mesh/node.c b/mesh/node.c
index 8b8205301..394f5bfa9 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -22,21 +22,19 @@
 #endif
 
 #define _GNU_SOURCE
-#include <stdio.h>
+
 #include <sys/time.h>
+
 #include <ell/ell.h>
 #include <json-c/json.h>
 
 #include "mesh/mesh-defs.h"
-
 #include "mesh/mesh.h"
-#include "mesh/mesh-io.h"
 #include "mesh/net.h"
 #include "mesh/mesh-db.h"
 #include "mesh/provision.h"
 #include "mesh/storage.h"
 #include "mesh/keyring.h"
-#include "mesh/appkey.h"
 #include "mesh/model.h"
 #include "mesh/cfgmod.h"
 #include "mesh/util.h"
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 915bb1973..8762afd7c 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -21,25 +21,9 @@
 #include <config.h>
 #endif
 
-#include <sys/select.h>
-#include <sys/time.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <termios.h>
-
-#include <ctype.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <getopt.h>
-#include <time.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
-#include "src/shared/ecc.h"
-
-#include "mesh/util.h"
-#include "mesh/net-keys.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
 #include "mesh/mesh-io.h"
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index 2ec043679..7b79fa916 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -21,28 +21,14 @@
 #include <config.h>
 #endif
 
-#include <sys/select.h>
-#include <sys/time.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <termios.h>
-
-#include <ctype.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <getopt.h>
-#include <time.h>
 #include <ell/ell.h>
 
-#include "mesh/mesh-defs.h"
 #include "src/shared/ecc.h"
 
+#include "mesh/mesh-defs.h"
 #include "mesh/util.h"
-#include "mesh/net-keys.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
-#include "mesh/error.h"
 #include "mesh/prov.h"
 #include "mesh/provision.h"
 #include "mesh/pb-adv.h"
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index a1f29ca83..f147c7ad8 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -21,28 +21,14 @@
 #include <config.h>
 #endif
 
-#include <sys/select.h>
-#include <sys/time.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <termios.h>
-
-#include <ctype.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <getopt.h>
-#include <time.h>
 #include <ell/ell.h>
 
-#include "mesh/mesh-defs.h"
 #include "src/shared/ecc.h"
 
+#include "mesh/mesh-defs.h"
 #include "mesh/util.h"
-#include "mesh/net-keys.h"
 #include "mesh/crypto.h"
 #include "mesh/net.h"
-#include "mesh/error.h"
 #include "mesh/prov.h"
 #include "mesh/provision.h"
 #include "mesh/pb-adv.h"
diff --git a/mesh/storage.c b/mesh/storage.c
index 2e10a4a00..1a9945aa8 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -22,7 +22,7 @@
 #endif
 
 #define _GNU_SOURCE
-#include <errno.h>
+//#include <errno.h>
 #include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
@@ -30,23 +30,16 @@
 #include <libgen.h>
 #include <ftw.h>
 
-#include <sys/types.h>
-#include <sys/stat.h>
-
 #include <json-c/json.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
-
-#include "mesh/mesh.h"
 #include "mesh/node.h"
-
 #include "mesh/net.h"
 #include "mesh/appkey.h"
-#include "mesh/model.h"
 #include "mesh/mesh-db.h"
-#include "mesh/storage.h"
 #include "mesh/util.h"
+#include "mesh/storage.h"
 
 struct write_info {
 	json_object *jnode;
diff --git a/mesh/util.c b/mesh/util.c
index b3ce1ce5f..861232266 100644
--- a/mesh/util.c
+++ b/mesh/util.c
@@ -22,13 +22,9 @@
 #endif
 
 #define _GNU_SOURCE
-#include <stdbool.h>
-#include <stdint.h>
+
 #include <stdio.h>
-#include <unistd.h>
-#include <termios.h>
 #include <time.h>
-#include <sys/ioctl.h>
 #include <sys/time.h>
 
 #include <ell/ell.h>
-- 
2.21.0

