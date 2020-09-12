Return-Path: <SRS0=izlr=CV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F5C43461
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D824F214F1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Sep 2020 06:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgILGjW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 02:39:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:3839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgILGjT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 02:39:19 -0400
IronPort-SDR: dnMr2K9ooN6tk/NvuDIqJtLdPshi54ap/QeQtscWuxvD4rGKBlzxF9gvoz3y8YaUxBcIlSYWA7
 bFLG+C/cG7Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="138912337"
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="138912337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 23:24:20 -0700
IronPort-SDR: mxyIdSQIgYYzdmcTj+vKz8XNlp2w898qEB8bE2Pc8dq9o4kURN1C/s0gqtvUvs5VczVNHRjpvs
 9uk6h76SU+FA==
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="342519275"
Received: from han1-mobl3.jf.intel.com ([10.255.228.79])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 23:24:20 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ 11/17] obexd: Add SPDX License Identifer
Date:   Fri, 11 Sep 2020 23:23:51 -0700
Message-Id: <20200912062357.23926-12-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200912062357.23926-1-tedd.an@linux.intel.com>
References: <20200912062357.23926-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds SPDX License Identifier.

-------------------------------------
       License            COUNT
-------------------------------------
 GPL-2.0-or-later     :     65

License: GPL-2.0-or-later
   obexd/src/mimetype.c
   obexd/src/transport.h
   obexd/src/server.c
   obexd/src/obex.c
   obexd/src/log.h
   obexd/src/service.h
   obexd/src/plugin.h
   obexd/src/plugin.c
   obexd/src/main.c
   obexd/src/mimetype.h
   obexd/src/transport.c
   obexd/src/obexd.h
   obexd/src/obex.h
   obexd/src/obex-priv.h
   obexd/src/log.c
   obexd/src/map_ap.h
   obexd/src/manager.c
   obexd/src/service.c
   obexd/src/server.h
   obexd/src/manager.h
   obexd/plugins/opp.c
   obexd/plugins/vcard.h
   obexd/plugins/pbap.c
   obexd/plugins/vcard.c
   obexd/plugins/messages.h
   obexd/plugins/phonebook.h
   obexd/plugins/pcsuite.c
   obexd/plugins/messages-tracker.c
   obexd/plugins/phonebook-tracker.c
   obexd/plugins/irmc.c
   obexd/plugins/ftp.c
   obexd/plugins/ftp.h
   obexd/plugins/filesystem.c
   obexd/plugins/messages-dummy.c
   obexd/plugins/phonebook-ebook.c
   obexd/plugins/syncevolution.c
   obexd/plugins/bluetooth.c
   obexd/plugins/phonebook-dummy.c
   obexd/plugins/filesystem.h
   obexd/plugins/mas.c
   obexd/client/transport.h
   obexd/client/opp.c
   obexd/client/pbap.c
   obexd/client/transfer.h
   obexd/client/opp.h
   obexd/client/driver.c
   obexd/client/map-event.h
   obexd/client/bluetooth.h
   obexd/client/sync.h
   obexd/client/transport.c
   obexd/client/pbap.h
   obexd/client/driver.h
   obexd/client/transfer.c
   obexd/client/ftp.c
   obexd/client/map.h
   obexd/client/ftp.h
   obexd/client/bluetooth.c
   obexd/client/manager.c
   obexd/client/session.h
   obexd/client/session.c
   obexd/client/map.c
   obexd/client/sync.c
   obexd/client/map-event.c
   obexd/client/mns.c
   obexd/client/manager.h
---
 obexd/client/bluetooth.c          | 1 +
 obexd/client/bluetooth.h          | 1 +
 obexd/client/driver.c             | 1 +
 obexd/client/driver.h             | 1 +
 obexd/client/ftp.c                | 1 +
 obexd/client/ftp.h                | 1 +
 obexd/client/manager.c            | 1 +
 obexd/client/manager.h            | 1 +
 obexd/client/map-event.c          | 1 +
 obexd/client/map-event.h          | 1 +
 obexd/client/map.c                | 1 +
 obexd/client/map.h                | 1 +
 obexd/client/mns.c                | 1 +
 obexd/client/opp.c                | 1 +
 obexd/client/opp.h                | 1 +
 obexd/client/pbap.c               | 1 +
 obexd/client/pbap.h               | 1 +
 obexd/client/session.c            | 1 +
 obexd/client/session.h            | 1 +
 obexd/client/sync.c               | 1 +
 obexd/client/sync.h               | 1 +
 obexd/client/transfer.c           | 1 +
 obexd/client/transfer.h           | 1 +
 obexd/client/transport.c          | 1 +
 obexd/client/transport.h          | 1 +
 obexd/plugins/bluetooth.c         | 1 +
 obexd/plugins/filesystem.c        | 1 +
 obexd/plugins/filesystem.h        | 1 +
 obexd/plugins/ftp.c               | 1 +
 obexd/plugins/ftp.h               | 1 +
 obexd/plugins/irmc.c              | 1 +
 obexd/plugins/mas.c               | 1 +
 obexd/plugins/messages-dummy.c    | 1 +
 obexd/plugins/messages-tracker.c  | 1 +
 obexd/plugins/messages.h          | 1 +
 obexd/plugins/opp.c               | 1 +
 obexd/plugins/pbap.c              | 1 +
 obexd/plugins/pcsuite.c           | 1 +
 obexd/plugins/phonebook-dummy.c   | 1 +
 obexd/plugins/phonebook-ebook.c   | 1 +
 obexd/plugins/phonebook-tracker.c | 1 +
 obexd/plugins/phonebook.h         | 1 +
 obexd/plugins/syncevolution.c     | 1 +
 obexd/plugins/vcard.c             | 1 +
 obexd/plugins/vcard.h             | 1 +
 obexd/src/log.c                   | 1 +
 obexd/src/log.h                   | 1 +
 obexd/src/main.c                  | 1 +
 obexd/src/manager.c               | 1 +
 obexd/src/manager.h               | 1 +
 obexd/src/map_ap.h                | 1 +
 obexd/src/mimetype.c              | 1 +
 obexd/src/mimetype.h              | 1 +
 obexd/src/obex-priv.h             | 1 +
 obexd/src/obex.c                  | 1 +
 obexd/src/obex.h                  | 1 +
 obexd/src/obexd.h                 | 1 +
 obexd/src/plugin.c                | 1 +
 obexd/src/plugin.h                | 1 +
 obexd/src/server.c                | 1 +
 obexd/src/server.h                | 1 +
 obexd/src/service.c               | 1 +
 obexd/src/service.h               | 1 +
 obexd/src/transport.c             | 1 +
 obexd/src/transport.h             | 1 +
 65 files changed, 65 insertions(+)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index 0c043e0ac..d7100a36c 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/bluetooth.h b/obexd/client/bluetooth.h
index 968e131e0..1d1e85c68 100644
--- a/obexd/client/bluetooth.h
+++ b/obexd/client/bluetooth.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/driver.c b/obexd/client/driver.c
index 0dae35601..773a6efe4 100644
--- a/obexd/client/driver.c
+++ b/obexd/client/driver.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/client/driver.h b/obexd/client/driver.h
index 0112219d5..a503a1751 100644
--- a/obexd/client/driver.h
+++ b/obexd/client/driver.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/client/ftp.c b/obexd/client/ftp.c
index 5e30654af..b260dc298 100644
--- a/obexd/client/ftp.c
+++ b/obexd/client/ftp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/ftp.h b/obexd/client/ftp.h
index 3d9096863..280872bd0 100644
--- a/obexd/client/ftp.h
+++ b/obexd/client/ftp.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/manager.c b/obexd/client/manager.c
index fbcad6da4..4782203e0 100644
--- a/obexd/client/manager.c
+++ b/obexd/client/manager.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/manager.h b/obexd/client/manager.h
index e4068de44..d8fed0c83 100644
--- a/obexd/client/manager.h
+++ b/obexd/client/manager.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/client/map-event.c b/obexd/client/map-event.c
index e164e863c..7b7e227e5 100644
--- a/obexd/client/map-event.c
+++ b/obexd/client/map-event.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX
diff --git a/obexd/client/map-event.h b/obexd/client/map-event.h
index 5414b2621..db7cc0a20 100644
--- a/obexd/client/map-event.h
+++ b/obexd/client/map-event.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX
diff --git a/obexd/client/map.c b/obexd/client/map.c
index 23be2d6b2..e352499a3 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/map.h b/obexd/client/map.h
index 86f6b9512..eadd8371a 100644
--- a/obexd/client/map.h
+++ b/obexd/client/map.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/mns.c b/obexd/client/mns.c
index 4912cb90f..47c75c8e1 100644
--- a/obexd/client/mns.c
+++ b/obexd/client/mns.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/client/opp.c b/obexd/client/opp.c
index 92785f66e..4a08540f7 100644
--- a/obexd/client/opp.c
+++ b/obexd/client/opp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/opp.h b/obexd/client/opp.h
index a23e94e00..3c727ddd8 100644
--- a/obexd/client/opp.h
+++ b/obexd/client/opp.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 3f5665fcd..1b1edb1ea 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/pbap.h b/obexd/client/pbap.h
index ce56258b5..b28a6bf09 100644
--- a/obexd/client/pbap.h
+++ b/obexd/client/pbap.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/session.c b/obexd/client/session.c
index 5bd2d2670..43e86551e 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/session.h b/obexd/client/session.h
index b561b7e58..aebc17d21 100644
--- a/obexd/client/session.h
+++ b/obexd/client/session.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/sync.c b/obexd/client/sync.c
index 548c318c3..90a2bcb0e 100644
--- a/obexd/client/sync.c
+++ b/obexd/client/sync.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/sync.h b/obexd/client/sync.h
index 8adc5f8d6..2e6e628c7 100644
--- a/obexd/client/sync.h
+++ b/obexd/client/sync.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/transfer.c b/obexd/client/transfer.c
index b53dffa21..489c03743 100644
--- a/obexd/client/transfer.c
+++ b/obexd/client/transfer.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/transfer.h b/obexd/client/transfer.h
index b6b835d18..dea9e97ca 100644
--- a/obexd/client/transfer.h
+++ b/obexd/client/transfer.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Client
diff --git a/obexd/client/transport.c b/obexd/client/transport.c
index 4cd770672..3467f7001 100644
--- a/obexd/client/transport.c
+++ b/obexd/client/transport.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/client/transport.h b/obexd/client/transport.h
index b035cfc45..e9f7d1193 100644
--- a/obexd/client/transport.h
+++ b/obexd/client/transport.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index ba1e0a99a..955616010 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
index 48239a8bc..e50338fb3 100644
--- a/obexd/plugins/filesystem.c
+++ b/obexd/plugins/filesystem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/filesystem.h b/obexd/plugins/filesystem.h
index f95773beb..397d74673 100644
--- a/obexd/plugins/filesystem.h
+++ b/obexd/plugins/filesystem.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/ftp.c b/obexd/plugins/ftp.c
index 3ee18a619..cf58cd3a8 100644
--- a/obexd/plugins/ftp.c
+++ b/obexd/plugins/ftp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/ftp.h b/obexd/plugins/ftp.h
index f06de8490..8de21ac2c 100644
--- a/obexd/plugins/ftp.h
+++ b/obexd/plugins/ftp.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/irmc.c b/obexd/plugins/irmc.c
index fcf5340e7..782afb485 100644
--- a/obexd/plugins/irmc.c
+++ b/obexd/plugins/irmc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX IrMC Sync Server
diff --git a/obexd/plugins/mas.c b/obexd/plugins/mas.c
index f73c3e9d8..ac379d622 100644
--- a/obexd/plugins/mas.c
+++ b/obexd/plugins/mas.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/messages-dummy.c b/obexd/plugins/messages-dummy.c
index 3eca9ef4c..63632c9c3 100644
--- a/obexd/plugins/messages-dummy.c
+++ b/obexd/plugins/messages-dummy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/messages-tracker.c b/obexd/plugins/messages-tracker.c
index 60f3a807e..3d0a20069 100644
--- a/obexd/plugins/messages-tracker.c
+++ b/obexd/plugins/messages-tracker.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/messages.h b/obexd/plugins/messages.h
index 00a16b1ae..83a45cb43 100644
--- a/obexd/plugins/messages.h
+++ b/obexd/plugins/messages.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
index 5bb766770..c0747856f 100644
--- a/obexd/plugins/opp.c
+++ b/obexd/plugins/opp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/pbap.c b/obexd/plugins/pbap.c
index d5a3046ae..0dc5e4cfc 100644
--- a/obexd/plugins/pbap.c
+++ b/obexd/plugins/pbap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/pcsuite.c b/obexd/plugins/pcsuite.c
index 43ab409e9..1b37f3e81 100644
--- a/obexd/plugins/pcsuite.c
+++ b/obexd/plugins/pcsuite.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
index 9279ef29a..edcacf420 100644
--- a/obexd/plugins/phonebook-dummy.c
+++ b/obexd/plugins/phonebook-dummy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/phonebook-ebook.c b/obexd/plugins/phonebook-ebook.c
index c422585df..2230148d6 100644
--- a/obexd/plugins/phonebook-ebook.c
+++ b/obexd/plugins/phonebook-ebook.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/phonebook-tracker.c b/obexd/plugins/phonebook-tracker.c
index c1d14078b..ea1811786 100644
--- a/obexd/plugins/phonebook-tracker.c
+++ b/obexd/plugins/phonebook-tracker.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Phonebook access through D-Bus vCard and call history service
  *
diff --git a/obexd/plugins/phonebook.h b/obexd/plugins/phonebook.h
index 70a9cb797..28110a971 100644
--- a/obexd/plugins/phonebook.h
+++ b/obexd/plugins/phonebook.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/syncevolution.c b/obexd/plugins/syncevolution.c
index 854505a58..32e772a1e 100644
--- a/obexd/plugins/syncevolution.c
+++ b/obexd/plugins/syncevolution.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/plugins/vcard.c b/obexd/plugins/vcard.c
index dc7c3b3e6..40269f4e2 100644
--- a/obexd/plugins/vcard.c
+++ b/obexd/plugins/vcard.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * OBEX Server
  *
diff --git a/obexd/plugins/vcard.h b/obexd/plugins/vcard.h
index 22c3f6899..933636fa7 100644
--- a/obexd/plugins/vcard.h
+++ b/obexd/plugins/vcard.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * OBEX Server
  *
diff --git a/obexd/src/log.c b/obexd/src/log.c
index 8e2ebaab2..769c7183c 100644
--- a/obexd/src/log.c
+++ b/obexd/src/log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/log.h b/obexd/src/log.h
index d9fb8678f..e0b69bd50 100644
--- a/obexd/src/log.h
+++ b/obexd/src/log.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/main.c b/obexd/src/main.c
index 139f1412c..462fd796c 100644
--- a/obexd/src/main.c
+++ b/obexd/src/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index a4af627cb..a3cbd3fa9 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/manager.h b/obexd/src/manager.h
index d709af5a8..ffabd7608 100644
--- a/obexd/src/manager.h
+++ b/obexd/src/manager.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/map_ap.h b/obexd/src/map_ap.h
index da108fe6e..40664c89d 100644
--- a/obexd/src/map_ap.h
+++ b/obexd/src/map_ap.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/mimetype.c b/obexd/src/mimetype.c
index c8b040a43..7dac1ee98 100644
--- a/obexd/src/mimetype.c
+++ b/obexd/src/mimetype.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/mimetype.h b/obexd/src/mimetype.h
index 79529b890..6cba7507b 100644
--- a/obexd/src/mimetype.h
+++ b/obexd/src/mimetype.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/obex-priv.h b/obexd/src/obex-priv.h
index 355a7f87b..8fe936e0d 100644
--- a/obexd/src/obex-priv.h
+++ b/obexd/src/obex-priv.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/obex.c b/obexd/src/obex.c
index 2850d3a37..d9b6b93d4 100644
--- a/obexd/src/obex.c
+++ b/obexd/src/obex.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/obex.h b/obexd/src/obex.h
index 67593f11b..5acb333fd 100644
--- a/obexd/src/obex.h
+++ b/obexd/src/obex.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/obexd.h b/obexd/src/obexd.h
index 42c3c4d97..0f2805c4e 100644
--- a/obexd/src/obexd.h
+++ b/obexd/src/obexd.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/plugin.c b/obexd/src/plugin.c
index a1962b91d..fcfd0b182 100644
--- a/obexd/src/plugin.c
+++ b/obexd/src/plugin.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/plugin.h b/obexd/src/plugin.h
index 13d77695f..4d824a4f5 100644
--- a/obexd/src/plugin.h
+++ b/obexd/src/plugin.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/server.c b/obexd/src/server.c
index db854233b..5e3ed7283 100644
--- a/obexd/src/server.c
+++ b/obexd/src/server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/server.h b/obexd/src/server.h
index 278c35fce..222b2ef80 100644
--- a/obexd/src/server.h
+++ b/obexd/src/server.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/service.c b/obexd/src/service.c
index c088535e9..faa39329f 100644
--- a/obexd/src/service.c
+++ b/obexd/src/service.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/service.h b/obexd/src/service.h
index 5d9d325fb..57fc95897 100644
--- a/obexd/src/service.h
+++ b/obexd/src/service.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/transport.c b/obexd/src/transport.c
index 4984643e2..b6b7f7a61 100644
--- a/obexd/src/transport.c
+++ b/obexd/src/transport.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
diff --git a/obexd/src/transport.h b/obexd/src/transport.h
index 97e10d05f..948b97cf2 100644
--- a/obexd/src/transport.h
+++ b/obexd/src/transport.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  OBEX Server
-- 
2.25.4

