Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45962C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE84217BA
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgIMDeL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 23:34:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:59032 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbgIMDeD (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 23:34:03 -0400
IronPort-SDR: IFW/dd8aLjWOf3lbqD2pAkJ09yfaq6a8sMndaIbW/gC4Uoty05Av+3ERX4Gd1cPhhoTv+4B1xd
 oCiDndYtgWNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9742"; a="243784903"
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="243784903"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:00 -0700
IronPort-SDR: T1rAZR+DSkJCaAHl7VOnsfVGafrdviywweIXyZPbxNh00bk7INr8GX+uUCOfwUYbFersHQg/Fp
 Yf5lR+FNdejA==
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="301347233"
Received: from han1-mobl3.jf.intel.com ([10.251.29.101])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:00 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v2 14/17] profiles: Add SPDX License Identifier
Date:   Sat, 12 Sep 2020 20:33:38 -0700
Message-Id: <20200913033341.4639-15-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200913033341.4639-1-tedd.an@linux.intel.com>
References: <20200913033341.4639-1-tedd.an@linux.intel.com>
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
 GPL-2.0-or-later     :     72
 LGPL-2.1-or-later    :      6

License: GPL-2.0-or-later
   profiles/deviceinfo/dis.c
   profiles/deviceinfo/deviceinfo.c
   profiles/health/hdp_types.h
   profiles/health/mcap.c
   profiles/health/hdp_manager.c
   profiles/health/hdp_main.c
   profiles/health/mcap.h
   profiles/health/hdp_util.h
   profiles/health/hdp_manager.h
   profiles/health/hdp_util.c
   profiles/health/hdp.c
   profiles/health/hdp.h
   profiles/network/server.c
   profiles/network/connection.h
   profiles/network/connection.c
   profiles/network/manager.c
   profiles/network/bnep.c
   profiles/network/server.h
   profiles/network/bnep.h
   profiles/battery/battery.c
   profiles/cups/cups.h
   profiles/cups/sdp.c
   profiles/cups/main.c
   profiles/cups/spp.c
   profiles/cups/hcrp.c
   profiles/scanparam/scpp.c
   profiles/scanparam/scan.c
   profiles/audio/transport.h
   profiles/audio/avdtp.h
   profiles/audio/source.c
   profiles/audio/player.c
   profiles/audio/avctp.c
   profiles/audio/control.h
   profiles/audio/a2dp.c
   profiles/audio/source.h
   profiles/audio/transport.c
   profiles/audio/sink.c
   profiles/audio/avrcp.h
   profiles/audio/avdtp.c
   profiles/audio/a2dp.h
   profiles/audio/avrcp.c
   profiles/audio/media.h
   profiles/audio/avctp.h
   profiles/audio/control.c
   profiles/audio/sink.h
   profiles/audio/player.h
   profiles/audio/media.c
   profiles/sap/server.c
   profiles/sap/sap-dummy.c
   profiles/sap/main.c
   profiles/sap/sap.h
   profiles/sap/manager.c
   profiles/sap/server.h
   profiles/sap/manager.h
   profiles/iap/main.c
   profiles/gap/gas.c
   profiles/midi/midi.c
   profiles/midi/libmidi.c
   profiles/midi/libmidi.h
   profiles/input/server.c
   profiles/input/suspend.h
   profiles/input/uhid_copy.h
   profiles/input/device.c
   profiles/input/hog.c
   profiles/input/device.h
   profiles/input/hidp_defs.h
   profiles/input/manager.c
   profiles/input/suspend-none.c
   profiles/input/sixaxis.h
   profiles/input/hog-lib.c
   profiles/input/suspend-dummy.c
   profiles/input/server.h

License: LGPL-2.1-or-later
   profiles/deviceinfo/dis.h
   profiles/battery/bas.h
   profiles/battery/bas.c
   profiles/scanparam/scpp.h
   profiles/audio/a2dp-codecs.h
   profiles/input/hog-lib.h
---
 profiles/audio/a2dp-codecs.h     | 1 +
 profiles/audio/a2dp.c            | 1 +
 profiles/audio/a2dp.h            | 1 +
 profiles/audio/avctp.c           | 1 +
 profiles/audio/avctp.h           | 1 +
 profiles/audio/avdtp.c           | 1 +
 profiles/audio/avdtp.h           | 1 +
 profiles/audio/avrcp.c           | 1 +
 profiles/audio/avrcp.h           | 1 +
 profiles/audio/control.c         | 1 +
 profiles/audio/control.h         | 1 +
 profiles/audio/media.c           | 1 +
 profiles/audio/media.h           | 1 +
 profiles/audio/player.c          | 1 +
 profiles/audio/player.h          | 1 +
 profiles/audio/sink.c            | 1 +
 profiles/audio/sink.h            | 1 +
 profiles/audio/source.c          | 1 +
 profiles/audio/source.h          | 1 +
 profiles/audio/transport.c       | 1 +
 profiles/audio/transport.h       | 1 +
 profiles/battery/bas.c           | 1 +
 profiles/battery/bas.h           | 1 +
 profiles/battery/battery.c       | 1 +
 profiles/cups/cups.h             | 1 +
 profiles/cups/hcrp.c             | 1 +
 profiles/cups/main.c             | 1 +
 profiles/cups/sdp.c              | 1 +
 profiles/cups/spp.c              | 1 +
 profiles/deviceinfo/deviceinfo.c | 1 +
 profiles/deviceinfo/dis.c        | 1 +
 profiles/deviceinfo/dis.h        | 1 +
 profiles/gap/gas.c               | 1 +
 profiles/health/hdp.c            | 1 +
 profiles/health/hdp.h            | 1 +
 profiles/health/hdp_main.c       | 1 +
 profiles/health/hdp_manager.c    | 1 +
 profiles/health/hdp_manager.h    | 1 +
 profiles/health/hdp_types.h      | 1 +
 profiles/health/hdp_util.c       | 1 +
 profiles/health/hdp_util.h       | 1 +
 profiles/health/mcap.c           | 1 +
 profiles/health/mcap.h           | 1 +
 profiles/iap/main.c              | 1 +
 profiles/input/device.c          | 1 +
 profiles/input/device.h          | 1 +
 profiles/input/hidp_defs.h       | 1 +
 profiles/input/hog-lib.c         | 1 +
 profiles/input/hog-lib.h         | 1 +
 profiles/input/hog.c             | 1 +
 profiles/input/manager.c         | 1 +
 profiles/input/server.c          | 1 +
 profiles/input/server.h          | 1 +
 profiles/input/sixaxis.h         | 1 +
 profiles/input/suspend-dummy.c   | 1 +
 profiles/input/suspend-none.c    | 1 +
 profiles/input/suspend.h         | 1 +
 profiles/input/uhid_copy.h       | 1 +
 profiles/midi/libmidi.c          | 1 +
 profiles/midi/libmidi.h          | 1 +
 profiles/midi/midi.c             | 1 +
 profiles/network/bnep.c          | 1 +
 profiles/network/bnep.h          | 1 +
 profiles/network/connection.c    | 1 +
 profiles/network/connection.h    | 1 +
 profiles/network/manager.c       | 1 +
 profiles/network/server.c        | 1 +
 profiles/network/server.h        | 1 +
 profiles/sap/main.c              | 1 +
 profiles/sap/manager.c           | 1 +
 profiles/sap/manager.h           | 1 +
 profiles/sap/sap-dummy.c         | 1 +
 profiles/sap/sap.h               | 1 +
 profiles/sap/server.c            | 1 +
 profiles/sap/server.h            | 1 +
 profiles/scanparam/scan.c        | 1 +
 profiles/scanparam/scpp.c        | 1 +
 profiles/scanparam/scpp.h        | 1 +
 78 files changed, 78 insertions(+)

diff --git a/profiles/audio/a2dp-codecs.h b/profiles/audio/a2dp-codecs.h
index 93e9d3523..f94a25112 100644
--- a/profiles/audio/a2dp-codecs.h
+++ b/profiles/audio/a2dp-codecs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 2feea66c0..e8c60a3b2 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 19466a428..a1bceafaf 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index f096d22b0..a7621b412 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 95d95bbbe..69a07736b 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 782268c08..08fc0c62f 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 011fea89e..171c1a2d1 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5ef98acd1..0bce23c0e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/avrcp.h b/profiles/audio/avrcp.h
index 159ccf846..f3938c192 100644
--- a/profiles/audio/avrcp.h
+++ b/profiles/audio/avrcp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 14744ea94..57a673995 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index aab2631b6..d7d192bdd 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 02bf82a49..d07b3a165 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 53694f4c6..540b2826b 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 27a7efb7e..530c06364 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index e98550064..536dc2293 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 7c5e77577..d190e9753 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index 93c62a206..fb1301b11 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 0ac20fe40..2d840a7c4 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/source.h b/profiles/audio/source.h
index a014c68d6..7c332528e 100644
--- a/profiles/audio/source.h
+++ b/profiles/audio/source.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index dd1c553a2..fe20c988c 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 78024372f..c226f74f3 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/battery/bas.c b/profiles/battery/bas.c
index de369fd3c..51c28fa3b 100644
--- a/profiles/battery/bas.c
+++ b/profiles/battery/bas.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/battery/bas.h b/profiles/battery/bas.h
index 3e175b5b5..4d85e1e6c 100644
--- a/profiles/battery/bas.h
+++ b/profiles/battery/bas.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index c9a1af4b9..da46858f6 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/cups/cups.h b/profiles/cups/cups.h
index f4e0c01cd..98bf7a596 100644
--- a/profiles/cups/cups.h
+++ b/profiles/cups/cups.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/cups/hcrp.c b/profiles/cups/hcrp.c
index edaa2cdfd..a3be5dbe9 100644
--- a/profiles/cups/hcrp.c
+++ b/profiles/cups/hcrp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/cups/main.c b/profiles/cups/main.c
index 1fac7267f..c91e4a4b4 100644
--- a/profiles/cups/main.c
+++ b/profiles/cups/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/cups/sdp.c b/profiles/cups/sdp.c
index de9cd4eeb..d79bd9540 100644
--- a/profiles/cups/sdp.c
+++ b/profiles/cups/sdp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/cups/spp.c b/profiles/cups/spp.c
index 2f1e270f4..b19a322ee 100644
--- a/profiles/cups/spp.c
+++ b/profiles/cups/spp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index fa94efe7f..cd68b469a 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/deviceinfo/dis.c b/profiles/deviceinfo/dis.c
index 6126a776c..ca4a96206 100644
--- a/profiles/deviceinfo/dis.c
+++ b/profiles/deviceinfo/dis.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/deviceinfo/dis.h b/profiles/deviceinfo/dis.h
index 305ba1ad0..914f9497d 100644
--- a/profiles/deviceinfo/dis.h
+++ b/profiles/deviceinfo/dis.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index dffa31314..a0a3d9da6 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index a8354936b..8a8698769 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/hdp.h b/profiles/health/hdp.h
index 6e78b0947..9f1c25908 100644
--- a/profiles/health/hdp.h
+++ b/profiles/health/hdp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/hdp_main.c b/profiles/health/hdp_main.c
index 2c4bbe298..23f6eac0d 100644
--- a/profiles/health/hdp_main.c
+++ b/profiles/health/hdp_main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 401adf6e9..01a1e1c22 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/hdp_manager.h b/profiles/health/hdp_manager.h
index 1cab4d008..99f151a56 100644
--- a/profiles/health/hdp_manager.h
+++ b/profiles/health/hdp_manager.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/hdp_types.h b/profiles/health/hdp_types.h
index b34b5e031..44f3b286f 100644
--- a/profiles/health/hdp_types.h
+++ b/profiles/health/hdp_types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/hdp_util.c b/profiles/health/hdp_util.c
index 64debfc6b..736ec6efa 100644
--- a/profiles/health/hdp_util.c
+++ b/profiles/health/hdp_util.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/hdp_util.h b/profiles/health/hdp_util.h
index 35e1196b2..5048e708a 100644
--- a/profiles/health/hdp_util.h
+++ b/profiles/health/hdp_util.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index ba43e6e96..ecd1491a2 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/health/mcap.h b/profiles/health/mcap.h
index 69873ca82..c52c07cd9 100644
--- a/profiles/health/mcap.h
+++ b/profiles/health/mcap.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/iap/main.c b/profiles/iap/main.c
index 2fd34c067..3ce6a4eac 100644
--- a/profiles/iap/main.c
+++ b/profiles/iap/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/device.c b/profiles/input/device.c
index 375314e7d..d3f49c4a0 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/device.h b/profiles/input/device.h
index f61e8a558..a1394f92b 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/hidp_defs.h b/profiles/input/hidp_defs.h
index bb9231dbb..533750efb 100644
--- a/profiles/input/hidp_defs.h
+++ b/profiles/input/hidp_defs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index e96c969b7..9b0770cf1 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/hog-lib.h b/profiles/input/hog-lib.h
index 415dc63d2..f90017069 100644
--- a/profiles/input/hog-lib.h
+++ b/profiles/input/hog-lib.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 130f696a9..7a3ecd0f5 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index bf4acb4ed..7ef9a90db 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 2bd5e92e4..f5cac6860 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/server.h b/profiles/input/server.h
index 74159bbd7..f4b15a462 100644
--- a/profiles/input/server.h
+++ b/profiles/input/server.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
index 8e6f3cc18..871cb1c8f 100644
--- a/profiles/input/sixaxis.h
+++ b/profiles/input/sixaxis.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
index 542ae2592..84c5b6762 100644
--- a/profiles/input/suspend-dummy.c
+++ b/profiles/input/suspend-dummy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/suspend-none.c b/profiles/input/suspend-none.c
index c619bb11e..51cf20912 100644
--- a/profiles/input/suspend-none.c
+++ b/profiles/input/suspend-none.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/suspend.h b/profiles/input/suspend.h
index bfee3cfef..0e8131d5a 100644
--- a/profiles/input/suspend.h
+++ b/profiles/input/suspend.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/input/uhid_copy.h b/profiles/input/uhid_copy.h
index 0ef73d4cc..f8d817e49 100644
--- a/profiles/input/uhid_copy.h
+++ b/profiles/input/uhid_copy.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef __UHID_H_
 #define __UHID_H_
 
diff --git a/profiles/midi/libmidi.c b/profiles/midi/libmidi.c
index cb2787db1..40d4b017a 100644
--- a/profiles/midi/libmidi.c
+++ b/profiles/midi/libmidi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/midi/libmidi.h b/profiles/midi/libmidi.h
index 9d94065b6..e112f2aad 100644
--- a/profiles/midi/libmidi.h
+++ b/profiles/midi/libmidi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index 1ee5cb16f..fc902996a 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index d0ad9e483..4e017435f 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index e9f4c1cf2..ad1d50543 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 170841de6..050bfd5a7 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/network/connection.h b/profiles/network/connection.h
index 4a8b43bc8..2e9a3459b 100644
--- a/profiles/network/connection.h
+++ b/profiles/network/connection.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 41377fb83..aa0c06111 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/network/server.c b/profiles/network/server.c
index c462677ed..d8f202818 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/network/server.h b/profiles/network/server.h
index a76e6f7b2..a431e7e50 100644
--- a/profiles/network/server.h
+++ b/profiles/network/server.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/sap/main.c b/profiles/sap/main.c
index cd707ff3e..967ec85d4 100644
--- a/profiles/sap/main.c
+++ b/profiles/sap/main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/profiles/sap/manager.c b/profiles/sap/manager.c
index b62239780..4e59fc6c2 100644
--- a/profiles/sap/manager.c
+++ b/profiles/sap/manager.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/profiles/sap/manager.h b/profiles/sap/manager.h
index 6601a034e..3373aa3a3 100644
--- a/profiles/sap/manager.h
+++ b/profiles/sap/manager.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/profiles/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
index 53463ca7c..eca630961 100644
--- a/profiles/sap/sap-dummy.c
+++ b/profiles/sap/sap-dummy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/profiles/sap/sap.h b/profiles/sap/sap.h
index 6e78d6c2d..8e5738821 100644
--- a/profiles/sap/sap.h
+++ b/profiles/sap/sap.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 5de682a33..8f4ba4725 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/profiles/sap/server.h b/profiles/sap/server.h
index 4bf9296ad..97ba34741 100644
--- a/profiles/sap/server.h
+++ b/profiles/sap/server.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index d72be3dff..4471ef119 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/scanparam/scpp.c b/profiles/scanparam/scpp.c
index df65d2c1e..b92ff1aae 100644
--- a/profiles/scanparam/scpp.c
+++ b/profiles/scanparam/scpp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/profiles/scanparam/scpp.h b/profiles/scanparam/scpp.h
index 048fb9f23..260fc8a96 100644
--- a/profiles/scanparam/scpp.h
+++ b/profiles/scanparam/scpp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
-- 
2.17.1

