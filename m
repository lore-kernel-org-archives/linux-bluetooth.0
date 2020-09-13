Return-Path: <SRS0=7mPt=CW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED437C43461
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B04B42177B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Sep 2020 03:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgIMDeZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Sep 2020 23:34:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:59036 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgIMDeJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Sep 2020 23:34:09 -0400
IronPort-SDR: bzTVK7CA/lN0nLMBFIueVDZHcLtcFHzKSjztr3KslkpxM+ybNlSCkFYgD1I7g8e+ZFB2FYC+xU
 nBiYkH6kG2Xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9742"; a="243784906"
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="243784906"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:01 -0700
IronPort-SDR: OFzwL87C2/XOiCqMEMk8V9k7c9kfKSHTbpFSGoylP6Bo8XeutIH88PsUVmFXbRUnxY+Q6ZgrUd
 tj2vtWnHDl/Q==
X-IronPort-AV: E=Sophos;i="5.76,421,1592895600"; 
   d="scan'208";a="301347243"
Received: from han1-mobl3.jf.intel.com ([10.251.29.101])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 20:34:01 -0700
From:   tedd.an@linux.intel.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [BlueZ v2 17/17] tools: Add SPDX License Identifier
Date:   Sat, 12 Sep 2020 20:33:41 -0700
Message-Id: <20200913033341.4639-18-tedd.an@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200913033341.4639-1-tedd.an@linux.intel.com>
References: <20200913033341.4639-1-tedd.an@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds SPDX License Identifier.

-------------------------------------
       License            COUNT
-------------------------------------
 GPL-2.0-or-later     :    102
 MIT                  :      2
 LGPL-2.1-or-later    :     38
 GPL-2.0-only         :      2

License: GPL-2.0-or-later
   tools/csr_usb.c
   tools/l2cap-tester.c
   tools/hcisecfilter.c
   tools/ciptool.c
   tools/csr_bcsp.c
   tools/btsnoop.c
   tools/check-selftest.c
   tools/bccmd.c
   tools/hci-tester.c
   tools/hcitool.c
   tools/btiotest.c
   tools/oobtest.c
   tools/btinfo.c
   tools/hwdb.c
   tools/hciattach_bcm43xx.c
   tools/mgmt-tester.c
   tools/hex2hcd.c
   tools/hciattach_st.c
   tools/smp-tester.c
   tools/bluetooth-player.c
   tools/hciattach_tialt.c
   tools/gap-tester.c
   tools/bluemoon.c
   tools/bneptest.c
   tools/gatt-service.c
   tools/csr_3wire.c
   tools/rctest.c
   tools/rfcomm-tester.c
   tools/hcieventmask.c
   tools/hciattach_ti.c
   tools/seq2bseq.c
   tools/scotest.c
   tools/bcmfw.c
   tools/hciconfig.c
   tools/btattach.c
   tools/l2ping.c
   tools/obexctl.c
   tools/l2test.c
   tools/hciattach_intel.c
   tools/csr.h
   tools/hciattach.h
   tools/create-image.c
   tools/bnep-tester.c
   tools/userchan-tester.c
   tools/rfcomm.c
   tools/btmon-logger.c
   tools/hcidump.c
   tools/csr_hci.c
   tools/rtlfw.c
   tools/hciattach_qualcomm.c
   tools/btproxy.c
   tools/nokfw.c
   tools/hciattach_ath3k.c
   tools/3dsp.c
   tools/bdaddr.c
   tools/sco-tester.c
   tools/hciattach.c
   tools/amptest.c
   tools/btgatt-server.c
   tools/btgatt-client.c
   tools/cltest.c
   tools/ibeacon.c
   tools/mcaptest.c
   tools/hid2hci.c
   tools/btmgmt.c
   tools/advtest.c
   tools/eddystone.c
   tools/csr_h4.c
   tools/avtest.c
   tools/mpris-proxy.c
   tools/csr.c
   tools/avinfo.c
   tools/sdptool.c
   tools/btconfig.c
   tools/parser/parser.h
   tools/parser/obex.c
   tools/parser/amp.c
   tools/parser/sdp.c
   tools/parser/tcpip.c
   tools/parser/sap.c
   tools/parser/cmtp.c
   tools/parser/avctp.c
   tools/parser/lmp.c
   tools/parser/ppp.c
   tools/parser/rfcomm.h
   tools/parser/hci.c
   tools/parser/sdp.h
   tools/parser/parser.c
   tools/parser/rfcomm.c
   tools/parser/avdtp.c
   tools/parser/avrcp.c
   tools/parser/ericsson.c
   tools/parser/hcrp.c
   tools/parser/bpa.c
   tools/parser/hidp.c
   tools/parser/bnep.c
   tools/parser/capi.c
   tools/parser/att.c
   tools/parser/l2cap.c
   tools/parser/smp.c
   tools/parser/csr.c
   tools/parser/l2cap.h

License: MIT
   tools/ubcsp.c
   tools/ubcsp.h

License: LGPL-2.1-or-later
   tools/test-runner.c
   tools/btpclient.c
   tools/meshctl.c
   tools/mesh-cfgclient.c
   tools/mesh/model.h
   tools/mesh/util.h
   tools/mesh/config-model.h
   tools/mesh/cfgcli.h
   tools/mesh/mesh-db.c
   tools/mesh/mesh-db.h
   tools/mesh/keys.c
   tools/mesh/util.c
   tools/mesh/agent.h
   tools/mesh/remote.c
   tools/mesh/keys.h
   tools/mesh/agent.c
   tools/mesh/cfgcli.c
   tools/mesh/remote.h
   tools/mesh-gatt/prov.c
   tools/mesh-gatt/util.h
   tools/mesh-gatt/prov.h
   tools/mesh-gatt/net.c
   tools/mesh-gatt/util.c
   tools/mesh-gatt/prov-db.h
   tools/mesh-gatt/crypto.c
   tools/mesh-gatt/crypto.h
   tools/mesh-gatt/gatt.c
   tools/mesh-gatt/config-server.c
   tools/mesh-gatt/keys.h
   tools/mesh-gatt/onoff-model.c
   tools/mesh-gatt/net.h
   tools/mesh-gatt/gatt.h
   tools/mesh-gatt/node.c
   tools/mesh-gatt/config-client.c
   tools/mesh-gatt/mesh-net.h
   tools/mesh-gatt/node.h
   tools/mesh-gatt/onoff-model.h
   tools/mesh-gatt/prov-db.c

License: GPL-2.0-only
   tools/obex-server-tool.c
   tools/obex-client-tool.c
---
 tools/3dsp.c                    | 1 +
 tools/advtest.c                 | 1 +
 tools/amptest.c                 | 1 +
 tools/avinfo.c                  | 1 +
 tools/avtest.c                  | 1 +
 tools/bccmd.c                   | 1 +
 tools/bcmfw.c                   | 1 +
 tools/bdaddr.c                  | 1 +
 tools/bluemoon.c                | 1 +
 tools/bluetooth-player.c        | 1 +
 tools/bnep-tester.c             | 1 +
 tools/bneptest.c                | 1 +
 tools/btattach.c                | 1 +
 tools/btconfig.c                | 1 +
 tools/btgatt-client.c           | 1 +
 tools/btgatt-server.c           | 1 +
 tools/btinfo.c                  | 1 +
 tools/btiotest.c                | 1 +
 tools/btmgmt.c                  | 1 +
 tools/btmon-logger.c            | 1 +
 tools/btpclient.c               | 1 +
 tools/btproxy.c                 | 1 +
 tools/btsnoop.c                 | 1 +
 tools/check-selftest.c          | 1 +
 tools/ciptool.c                 | 1 +
 tools/cltest.c                  | 1 +
 tools/create-image.c            | 1 +
 tools/csr.c                     | 1 +
 tools/csr.h                     | 1 +
 tools/csr_3wire.c               | 1 +
 tools/csr_bcsp.c                | 1 +
 tools/csr_h4.c                  | 1 +
 tools/csr_hci.c                 | 1 +
 tools/csr_usb.c                 | 1 +
 tools/eddystone.c               | 1 +
 tools/gap-tester.c              | 1 +
 tools/gatt-service.c            | 1 +
 tools/hci-tester.c              | 1 +
 tools/hciattach.c               | 1 +
 tools/hciattach.h               | 1 +
 tools/hciattach_ath3k.c         | 1 +
 tools/hciattach_bcm43xx.c       | 1 +
 tools/hciattach_intel.c         | 1 +
 tools/hciattach_qualcomm.c      | 1 +
 tools/hciattach_st.c            | 1 +
 tools/hciattach_ti.c            | 1 +
 tools/hciattach_tialt.c         | 1 +
 tools/hciconfig.c               | 1 +
 tools/hcidump.c                 | 1 +
 tools/hcieventmask.c            | 1 +
 tools/hcisecfilter.c            | 1 +
 tools/hcitool.c                 | 1 +
 tools/hex2hcd.c                 | 1 +
 tools/hid2hci.c                 | 1 +
 tools/hwdb.c                    | 1 +
 tools/ibeacon.c                 | 1 +
 tools/l2cap-tester.c            | 1 +
 tools/l2ping.c                  | 1 +
 tools/l2test.c                  | 1 +
 tools/mcaptest.c                | 1 +
 tools/mesh-cfgclient.c          | 1 +
 tools/mesh-gatt/config-client.c | 1 +
 tools/mesh-gatt/config-server.c | 1 +
 tools/mesh-gatt/crypto.c        | 1 +
 tools/mesh-gatt/crypto.h        | 1 +
 tools/mesh-gatt/gatt.c          | 1 +
 tools/mesh-gatt/gatt.h          | 1 +
 tools/mesh-gatt/keys.h          | 1 +
 tools/mesh-gatt/mesh-net.h      | 1 +
 tools/mesh-gatt/net.c           | 1 +
 tools/mesh-gatt/net.h           | 1 +
 tools/mesh-gatt/node.c          | 1 +
 tools/mesh-gatt/node.h          | 1 +
 tools/mesh-gatt/onoff-model.c   | 1 +
 tools/mesh-gatt/onoff-model.h   | 1 +
 tools/mesh-gatt/prov-db.c       | 1 +
 tools/mesh-gatt/prov-db.h       | 1 +
 tools/mesh-gatt/prov.c          | 1 +
 tools/mesh-gatt/prov.h          | 1 +
 tools/mesh-gatt/util.c          | 1 +
 tools/mesh-gatt/util.h          | 1 +
 tools/mesh/agent.c              | 1 +
 tools/mesh/agent.h              | 1 +
 tools/mesh/cfgcli.c             | 1 +
 tools/mesh/cfgcli.h             | 1 +
 tools/mesh/config-model.h       | 1 +
 tools/mesh/keys.c               | 1 +
 tools/mesh/keys.h               | 1 +
 tools/mesh/mesh-db.c            | 1 +
 tools/mesh/mesh-db.h            | 1 +
 tools/mesh/model.h              | 1 +
 tools/mesh/remote.c             | 1 +
 tools/mesh/remote.h             | 1 +
 tools/mesh/util.c               | 1 +
 tools/mesh/util.h               | 1 +
 tools/meshctl.c                 | 1 +
 tools/mgmt-tester.c             | 1 +
 tools/mpris-proxy.c             | 1 +
 tools/nokfw.c                   | 1 +
 tools/obex-client-tool.c        | 1 +
 tools/obex-server-tool.c        | 1 +
 tools/obexctl.c                 | 1 +
 tools/oobtest.c                 | 1 +
 tools/parser/amp.c              | 1 +
 tools/parser/att.c              | 1 +
 tools/parser/avctp.c            | 1 +
 tools/parser/avdtp.c            | 1 +
 tools/parser/avrcp.c            | 1 +
 tools/parser/bnep.c             | 1 +
 tools/parser/bpa.c              | 1 +
 tools/parser/capi.c             | 1 +
 tools/parser/cmtp.c             | 1 +
 tools/parser/csr.c              | 1 +
 tools/parser/ericsson.c         | 1 +
 tools/parser/hci.c              | 1 +
 tools/parser/hcrp.c             | 1 +
 tools/parser/hidp.c             | 1 +
 tools/parser/l2cap.c            | 1 +
 tools/parser/l2cap.h            | 1 +
 tools/parser/lmp.c              | 1 +
 tools/parser/obex.c             | 1 +
 tools/parser/parser.c           | 1 +
 tools/parser/parser.h           | 1 +
 tools/parser/ppp.c              | 1 +
 tools/parser/rfcomm.c           | 1 +
 tools/parser/rfcomm.h           | 1 +
 tools/parser/sap.c              | 1 +
 tools/parser/sdp.c              | 1 +
 tools/parser/sdp.h              | 1 +
 tools/parser/smp.c              | 1 +
 tools/parser/tcpip.c            | 1 +
 tools/rctest.c                  | 1 +
 tools/rfcomm-tester.c           | 1 +
 tools/rfcomm.c                  | 1 +
 tools/rtlfw.c                   | 1 +
 tools/sco-tester.c              | 1 +
 tools/scotest.c                 | 1 +
 tools/sdptool.c                 | 1 +
 tools/seq2bseq.c                | 1 +
 tools/smp-tester.c              | 1 +
 tools/test-runner.c             | 1 +
 tools/ubcsp.c                   | 1 +
 tools/ubcsp.h                   | 1 +
 tools/userchan-tester.c         | 1 +
 144 files changed, 144 insertions(+)

diff --git a/tools/3dsp.c b/tools/3dsp.c
index 77a70c037..617bfdfbf 100644
--- a/tools/3dsp.c
+++ b/tools/3dsp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/advtest.c b/tools/advtest.c
index 050b570df..bdc2421ca 100644
--- a/tools/advtest.c
+++ b/tools/advtest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/amptest.c b/tools/amptest.c
index 557470781..f452d2471 100644
--- a/tools/amptest.c
+++ b/tools/amptest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/avinfo.c b/tools/avinfo.c
index e45b50918..26e9d1431 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/avtest.c b/tools/avtest.c
index 59fb1da8a..1a1427b2e 100644
--- a/tools/avtest.c
+++ b/tools/avtest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/bccmd.c b/tools/bccmd.c
index 2c215ace7..a75415963 100644
--- a/tools/bccmd.c
+++ b/tools/bccmd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/bcmfw.c b/tools/bcmfw.c
index 80d8e71a2..9769016ab 100644
--- a/tools/bcmfw.c
+++ b/tools/bcmfw.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/bdaddr.c b/tools/bdaddr.c
index 952e99077..fb0772c2a 100644
--- a/tools/bdaddr.c
+++ b/tools/bdaddr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index 800541110..ff676d32d 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/bluetooth-player.c b/tools/bluetooth-player.c
index c1005c9b7..c8553f75e 100644
--- a/tools/bluetooth-player.c
+++ b/tools/bluetooth-player.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/bnep-tester.c b/tools/bnep-tester.c
index ec4ad2668..95176f0a1 100644
--- a/tools/bnep-tester.c
+++ b/tools/bnep-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/bneptest.c b/tools/bneptest.c
index 8bc7596b6..694eb4420 100644
--- a/tools/bneptest.c
+++ b/tools/bneptest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/btattach.c b/tools/btattach.c
index 56315d050..dc9ea642e 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/btconfig.c b/tools/btconfig.c
index c1ef5834a..c7e97d1dd 100644
--- a/tools/btconfig.c
+++ b/tools/btconfig.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index bc762dba1..c148728bb 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 5b7857b00..5d44a5bf4 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/tools/btinfo.c b/tools/btinfo.c
index 5e609739c..93e4d96ec 100644
--- a/tools/btinfo.c
+++ b/tools/btinfo.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/btiotest.c b/tools/btiotest.c
index 6c778e3c5..bf23a00da 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 48c9e5887..7c658c617 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  BlueZ - Bluetooth protocol stack for Linux
  *
diff --git a/tools/btmon-logger.c b/tools/btmon-logger.c
index 9c23d3c5e..79cab1e2c 100644
--- a/tools/btmon-logger.c
+++ b/tools/btmon-logger.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/btpclient.c b/tools/btpclient.c
index f9c693056..ad89678b8 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/btproxy.c b/tools/btproxy.c
index a98bbb73f..10340da7c 100644
--- a/tools/btproxy.c
+++ b/tools/btproxy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 9f304377c..164bd0fed 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/check-selftest.c b/tools/check-selftest.c
index 0de6362da..ff8c8740a 100644
--- a/tools/check-selftest.c
+++ b/tools/check-selftest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/ciptool.c b/tools/ciptool.c
index b898ae8b7..cc1caffcb 100644
--- a/tools/ciptool.c
+++ b/tools/ciptool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/cltest.c b/tools/cltest.c
index 44a17a892..3629f70e0 100644
--- a/tools/cltest.c
+++ b/tools/cltest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/create-image.c b/tools/create-image.c
index ca9d0112c..0afb95873 100644
--- a/tools/create-image.c
+++ b/tools/create-image.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/csr.c b/tools/csr.c
index 61bdaa0cf..87f87510a 100644
--- a/tools/csr.c
+++ b/tools/csr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/csr.h b/tools/csr.h
index cc245a550..aeba8bfb3 100644
--- a/tools/csr.h
+++ b/tools/csr.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/csr_3wire.c b/tools/csr_3wire.c
index 33fcf389a..befc4dfa9 100644
--- a/tools/csr_3wire.c
+++ b/tools/csr_3wire.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/csr_bcsp.c b/tools/csr_bcsp.c
index e3eea34df..5a8cdd2bd 100644
--- a/tools/csr_bcsp.c
+++ b/tools/csr_bcsp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/csr_h4.c b/tools/csr_h4.c
index 2dcaec1e5..892685812 100644
--- a/tools/csr_h4.c
+++ b/tools/csr_h4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/csr_hci.c b/tools/csr_hci.c
index d2e4ab9c6..b0425aa32 100644
--- a/tools/csr_hci.c
+++ b/tools/csr_hci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/csr_usb.c b/tools/csr_usb.c
index 32fdf1f14..3c7cb922c 100644
--- a/tools/csr_usb.c
+++ b/tools/csr_usb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/eddystone.c b/tools/eddystone.c
index 4764c677c..4303a16ba 100644
--- a/tools/eddystone.c
+++ b/tools/eddystone.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/gap-tester.c b/tools/gap-tester.c
index 2aa404267..6c0a4ec0b 100644
--- a/tools/gap-tester.c
+++ b/tools/gap-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/gatt-service.c b/tools/gatt-service.c
index 374a4c9df..c276e4f1a 100644
--- a/tools/gatt-service.c
+++ b/tools/gatt-service.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 7873e7aea..6a7e0a63e 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciattach.c b/tools/hciattach.c
index 9a02173bf..7e601563b 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 249aab49e..9965661eb 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index eb2a2aeb6..9e09b2440 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  Copyright (c) 2009-2010 Atheros Communications Inc.
  *
diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index be82cd011..4ebae6744 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciattach_intel.c b/tools/hciattach_intel.c
index 0f0b60f2b..e54b4b6ac 100644
--- a/tools/hciattach_intel.c
+++ b/tools/hciattach_intel.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciattach_qualcomm.c b/tools/hciattach_qualcomm.c
index 29d15a5fe..f13768d2a 100644
--- a/tools/hciattach_qualcomm.c
+++ b/tools/hciattach_qualcomm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciattach_st.c b/tools/hciattach_st.c
index b34964cb7..3163d9e11 100644
--- a/tools/hciattach_st.c
+++ b/tools/hciattach_st.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index 183839443..c254b203d 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index 78498edcf..605888716 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index ddc17c4b5..ddb796c75 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hcidump.c b/tools/hcidump.c
index 33d429b6c..6d4577d73 100644
--- a/tools/hcidump.c
+++ b/tools/hcidump.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hcieventmask.c b/tools/hcieventmask.c
index b5f818d30..e75cfe2e2 100644
--- a/tools/hcieventmask.c
+++ b/tools/hcieventmask.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hcisecfilter.c b/tools/hcisecfilter.c
index 18c903334..9c56bf7a3 100644
--- a/tools/hcisecfilter.c
+++ b/tools/hcisecfilter.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 9250c41f2..e2587b80b 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hex2hcd.c b/tools/hex2hcd.c
index 1148bbb46..9a5cbafb5 100644
--- a/tools/hex2hcd.c
+++ b/tools/hex2hcd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/hid2hci.c b/tools/hid2hci.c
index 1e0f7aa2a..2110c0624 100644
--- a/tools/hid2hci.c
+++ b/tools/hid2hci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * hid2hci : switch the radio on devices that support
  *           it from HID to HCI and back
diff --git a/tools/hwdb.c b/tools/hwdb.c
index 8a42dce39..12e885a45 100644
--- a/tools/hwdb.c
+++ b/tools/hwdb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/ibeacon.c b/tools/ibeacon.c
index 40078d5ed..141f3a9a0 100644
--- a/tools/ibeacon.c
+++ b/tools/ibeacon.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 1ef4e9213..00df9fd6d 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/l2ping.c b/tools/l2ping.c
index db120a550..2c980b5c2 100644
--- a/tools/l2ping.c
+++ b/tools/l2ping.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/l2test.c b/tools/l2test.c
index 0d846ed93..d136d094b 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index 82663d8de..eeed9f97e 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 3987e3179..e8dbe6aa1 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/config-client.c b/tools/mesh-gatt/config-clien=
t.c
index bfc788258..bac767083 100644
--- a/tools/mesh-gatt/config-client.c
+++ b/tools/mesh-gatt/config-client.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/config-server.c b/tools/mesh-gatt/config-serve=
r.c
index 9e9b93959..284726482 100644
--- a/tools/mesh-gatt/config-server.c
+++ b/tools/mesh-gatt/config-server.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/crypto.c b/tools/mesh-gatt/crypto.c
index 493b502ca..04d4d1f34 100644
--- a/tools/mesh-gatt/crypto.c
+++ b/tools/mesh-gatt/crypto.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/crypto.h b/tools/mesh-gatt/crypto.h
index e8f16f35d..a28754c17 100644
--- a/tools/mesh-gatt/crypto.h
+++ b/tools/mesh-gatt/crypto.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/gatt.c b/tools/mesh-gatt/gatt.c
index 1bd9868df..3828c6092 100644
--- a/tools/mesh-gatt/gatt.c
+++ b/tools/mesh-gatt/gatt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/gatt.h b/tools/mesh-gatt/gatt.h
index 2878587b1..9a8377638 100644
--- a/tools/mesh-gatt/gatt.h
+++ b/tools/mesh-gatt/gatt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/keys.h b/tools/mesh-gatt/keys.h
index 477ff1309..1f96b92a4 100644
--- a/tools/mesh-gatt/keys.h
+++ b/tools/mesh-gatt/keys.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/mesh-net.h b/tools/mesh-gatt/mesh-net.h
index 76a98224c..405a93436 100644
--- a/tools/mesh-gatt/mesh-net.h
+++ b/tools/mesh-gatt/mesh-net.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/net.c b/tools/mesh-gatt/net.c
index d74e1f5a5..5e8d89463 100644
--- a/tools/mesh-gatt/net.c
+++ b/tools/mesh-gatt/net.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/net.h b/tools/mesh-gatt/net.h
index b388d616c..30943be1a 100644
--- a/tools/mesh-gatt/net.h
+++ b/tools/mesh-gatt/net.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/node.c b/tools/mesh-gatt/node.c
index 6afa6d6ab..7a9340cf7 100644
--- a/tools/mesh-gatt/node.c
+++ b/tools/mesh-gatt/node.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/node.h b/tools/mesh-gatt/node.h
index a5b5c7520..3370809fb 100644
--- a/tools/mesh-gatt/node.h
+++ b/tools/mesh-gatt/node.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/onoff-model.c b/tools/mesh-gatt/onoff-model.c
index be519c969..83a9f6424 100644
--- a/tools/mesh-gatt/onoff-model.c
+++ b/tools/mesh-gatt/onoff-model.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/onoff-model.h b/tools/mesh-gatt/onoff-model.h
index 31599056d..a9fdb300e 100644
--- a/tools/mesh-gatt/onoff-model.h
+++ b/tools/mesh-gatt/onoff-model.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/prov-db.c b/tools/mesh-gatt/prov-db.c
index 44096e1e1..db8cf8875 100644
--- a/tools/mesh-gatt/prov-db.c
+++ b/tools/mesh-gatt/prov-db.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/prov-db.h b/tools/mesh-gatt/prov-db.h
index b8584a8c3..50e88266e 100644
--- a/tools/mesh-gatt/prov-db.h
+++ b/tools/mesh-gatt/prov-db.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/prov.c b/tools/mesh-gatt/prov.c
index 598c94ebf..ccde8114a 100644
--- a/tools/mesh-gatt/prov.c
+++ b/tools/mesh-gatt/prov.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/prov.h b/tools/mesh-gatt/prov.h
index 2587df8fb..71b40e57c 100644
--- a/tools/mesh-gatt/prov.h
+++ b/tools/mesh-gatt/prov.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/util.c b/tools/mesh-gatt/util.c
index 564665e5d..998df6024 100644
--- a/tools/mesh-gatt/util.c
+++ b/tools/mesh-gatt/util.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh-gatt/util.h b/tools/mesh-gatt/util.h
index dba2c480b..09f9313ae 100644
--- a/tools/mesh-gatt/util.h
+++ b/tools/mesh-gatt/util.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/agent.c b/tools/mesh/agent.c
index 0258a3803..83b7d0af4 100644
--- a/tools/mesh/agent.c
+++ b/tools/mesh/agent.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/agent.h b/tools/mesh/agent.h
index 7f95798f1..38609e97a 100644
--- a/tools/mesh/agent.h
+++ b/tools/mesh/agent.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 292bb7e19..f7d30b092 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/cfgcli.h b/tools/mesh/cfgcli.h
index 89a67f5de..9e544c71e 100644
--- a/tools/mesh/cfgcli.h
+++ b/tools/mesh/cfgcli.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/config-model.h b/tools/mesh/config-model.h
index f08d3b890..c5dbb8c5a 100644
--- a/tools/mesh/config-model.h
+++ b/tools/mesh/config-model.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index c4070cb75..743488a9e 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/keys.h b/tools/mesh/keys.h
index fa51044ef..ebd78a184 100644
--- a/tools/mesh/keys.h
+++ b/tools/mesh/keys.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index 7f2d5b358..12219daa5 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/mesh-db.h b/tools/mesh/mesh-db.h
index 49af33e87..5e6073522 100644
--- a/tools/mesh/mesh-db.h
+++ b/tools/mesh/mesh-db.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/model.h b/tools/mesh/model.h
index 35bb80efc..2d78badec 100644
--- a/tools/mesh/model.h
+++ b/tools/mesh/model.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index f68ef4b41..809d55996 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/remote.h b/tools/mesh/remote.h
index 482817c5a..75daeecc8 100644
--- a/tools/mesh/remote.h
+++ b/tools/mesh/remote.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/util.c b/tools/mesh/util.c
index 41a629177..788013cd0 100644
--- a/tools/mesh/util.c
+++ b/tools/mesh/util.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mesh/util.h b/tools/mesh/util.h
index 3b6a2f521..602be83ff 100644
--- a/tools/mesh/util.h
+++ b/tools/mesh/util.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/meshctl.c b/tools/meshctl.c
index 57998fded..1c7cdff18 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 337a05b45..500159324 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index 617f80586..37591a533 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/nokfw.c b/tools/nokfw.c
index 6209642b5..467656e48 100644
--- a/tools/nokfw.c
+++ b/tools/nokfw.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/obex-client-tool.c b/tools/obex-client-tool.c
index 3d61c00d7..3fe70cb95 100644
--- a/tools/obex-client-tool.c
+++ b/tools/obex-client-tool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *
  *  OBEX library with GLib integration
diff --git a/tools/obex-server-tool.c b/tools/obex-server-tool.c
index b20dfaa6b..27a80d19a 100644
--- a/tools/obex-server-tool.c
+++ b/tools/obex-server-tool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *
  *  OBEX library with GLib integration
diff --git a/tools/obexctl.c b/tools/obexctl.c
index 0709f692c..2efd27508 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/oobtest.c b/tools/oobtest.c
index c228b65b1..cb1caf723 100644
--- a/tools/oobtest.c
+++ b/tools/oobtest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/amp.c b/tools/parser/amp.c
index 7c85fb96c..aeaf2732e 100644
--- a/tools/parser/amp.c
+++ b/tools/parser/amp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/att.c b/tools/parser/att.c
index 688ed48a2..3c8b537fb 100644
--- a/tools/parser/att.c
+++ b/tools/parser/att.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/avctp.c b/tools/parser/avctp.c
index 5038443a4..d399e0f3f 100644
--- a/tools/parser/avctp.c
+++ b/tools/parser/avctp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
index 18569c895..5130b42af 100644
--- a/tools/parser/avdtp.c
+++ b/tools/parser/avdtp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/avrcp.c b/tools/parser/avrcp.c
index dfc6d0580..d9c3f0e7a 100644
--- a/tools/parser/avrcp.c
+++ b/tools/parser/avrcp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/bnep.c b/tools/parser/bnep.c
index c3bbae74f..23f3c93a3 100644
--- a/tools/parser/bnep.c
+++ b/tools/parser/bnep.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/bpa.c b/tools/parser/bpa.c
index aac010b39..28584dc92 100644
--- a/tools/parser/bpa.c
+++ b/tools/parser/bpa.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/capi.c b/tools/parser/capi.c
index ef6ac0664..f0bdd17da 100644
--- a/tools/parser/capi.c
+++ b/tools/parser/capi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/cmtp.c b/tools/parser/cmtp.c
index e7ac4b55c..32d7e6ac6 100644
--- a/tools/parser/cmtp.c
+++ b/tools/parser/cmtp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/csr.c b/tools/parser/csr.c
index 718baab32..c751809fd 100644
--- a/tools/parser/csr.c
+++ b/tools/parser/csr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/ericsson.c b/tools/parser/ericsson.c
index d148c93f7..c0ee1d960 100644
--- a/tools/parser/ericsson.c
+++ b/tools/parser/ericsson.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 41f6fe087..72c0e959f 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/hcrp.c b/tools/parser/hcrp.c
index 7c46cb6ea..1f8999d95 100644
--- a/tools/parser/hcrp.c
+++ b/tools/parser/hcrp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/hidp.c b/tools/parser/hidp.c
index 703049a7a..b2624489b 100644
--- a/tools/parser/hidp.c
+++ b/tools/parser/hidp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/l2cap.c b/tools/parser/l2cap.c
index e43761cf7..eb7684bac 100644
--- a/tools/parser/l2cap.c
+++ b/tools/parser/l2cap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/l2cap.h b/tools/parser/l2cap.h
index 788aef006..298ce25a6 100644
--- a/tools/parser/l2cap.h
+++ b/tools/parser/l2cap.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/lmp.c b/tools/parser/lmp.c
index a7879fb37..1f24a39de 100644
--- a/tools/parser/lmp.c
+++ b/tools/parser/lmp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/obex.c b/tools/parser/obex.c
index 51719aa9c..9830ac588 100644
--- a/tools/parser/obex.c
+++ b/tools/parser/obex.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/parser.c b/tools/parser/parser.c
index 61c5b1cda..57ab44b7e 100644
--- a/tools/parser/parser.c
+++ b/tools/parser/parser.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/parser.h b/tools/parser/parser.h
index b7e1d7568..3b939e1a2 100644
--- a/tools/parser/parser.h
+++ b/tools/parser/parser.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/ppp.c b/tools/parser/ppp.c
index 55aaa60fe..90e7304a8 100644
--- a/tools/parser/ppp.c
+++ b/tools/parser/ppp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/rfcomm.c b/tools/parser/rfcomm.c
index d800b7e6d..5704d8dd7 100644
--- a/tools/parser/rfcomm.c
+++ b/tools/parser/rfcomm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/rfcomm.h b/tools/parser/rfcomm.h
index a9faa0bf8..fa7df9597 100644
--- a/tools/parser/rfcomm.h
+++ b/tools/parser/rfcomm.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/sap.c b/tools/parser/sap.c
index 0a875fc7c..250cbff4b 100644
--- a/tools/parser/sap.c
+++ b/tools/parser/sap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/sdp.c b/tools/parser/sdp.c
index 7477037b8..e235dd188 100644
--- a/tools/parser/sdp.c
+++ b/tools/parser/sdp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/sdp.h b/tools/parser/sdp.h
index ed55a23ea..bf329c1ef 100644
--- a/tools/parser/sdp.h
+++ b/tools/parser/sdp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/smp.c b/tools/parser/smp.c
index 817e08e85..fa444c6cc 100644
--- a/tools/parser/smp.c
+++ b/tools/parser/smp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/parser/tcpip.c b/tools/parser/tcpip.c
index 8ccfb007c..a96b345a6 100644
--- a/tools/parser/tcpip.c
+++ b/tools/parser/tcpip.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/rctest.c b/tools/rctest.c
index bc8ed875d..0fac6ebcb 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/rfcomm-tester.c b/tools/rfcomm-tester.c
index 2d3be27d8..4635ac8d3 100644
--- a/tools/rfcomm-tester.c
+++ b/tools/rfcomm-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index 177d8f828..4880b0c2d 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/rtlfw.c b/tools/rtlfw.c
index 375f07592..50bf70480 100644
--- a/tools/rtlfw.c
+++ b/tools/rtlfw.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/sco-tester.c b/tools/sco-tester.c
index 651fbe01d..594c36619 100644
--- a/tools/sco-tester.c
+++ b/tools/sco-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/scotest.c b/tools/scotest.c
index 08bc8a8d2..d48dbe5ca 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 3c5d840d9..5c00c69cc 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/seq2bseq.c b/tools/seq2bseq.c
index 9268ecd06..20e91810a 100644
--- a/tools/seq2bseq.c
+++ b/tools/seq2bseq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index c32519e0c..c6bfde920 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/test-runner.c b/tools/test-runner.c
index bd3c73001..c735a2ba9 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
diff --git a/tools/ubcsp.c b/tools/ubcsp.c
index b3f883a03..ff96c3107 100644
--- a/tools/ubcsp.c
+++ b/tools/ubcsp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT=0D
 /*=0D
  *=0D
  *  BlueZ - Bluetooth protocol stack for Linux=0D
diff --git a/tools/ubcsp.h b/tools/ubcsp.h
index 6a74e9a16..2a54146cd 100644
--- a/tools/ubcsp.h
+++ b/tools/ubcsp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: MIT */=0D
 /*=0D
  *=0D
  *  BlueZ - Bluetooth protocol stack for Linux=0D
diff --git a/tools/userchan-tester.c b/tools/userchan-tester.c
index 8fb088827..50cdfb238 100644
--- a/tools/userchan-tester.c
+++ b/tools/userchan-tester.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *
  *  BlueZ - Bluetooth protocol stack for Linux
--=20
2.17.1

