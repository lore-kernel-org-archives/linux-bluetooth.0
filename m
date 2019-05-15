Return-Path: <SRS0=OL4k=TP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A9C46460
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF01320818
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 19:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfEOTAd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 May 2019 15:00:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:27572 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfEOTAd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 May 2019 15:00:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 12:00:30 -0700
X-ExtLoop1: 1
Received: from ingas-nuc1.sea.intel.com ([10.254.97.211])
  by FMSMGA003.fm.intel.com with ESMTP; 15 May 2019 12:00:29 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/2] mesh: Update copyright dates
Date:   Wed, 15 May 2019 12:00:18 -0700
Message-Id: <20190515190019.19710-2-inga.stotland@intel.com>
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
 mesh/agent.c           | 2 +-
 mesh/appkey.c          | 2 +-
 mesh/appkey.h          | 2 +-
 mesh/cfgmod-server.c   | 2 +-
 mesh/crypto.c          | 2 +-
 mesh/error.h           | 2 +-
 mesh/friend.c          | 2 +-
 mesh/mesh-db.c         | 2 +-
 mesh/mesh-db.h         | 2 +-
 mesh/mesh-defs.h       | 2 +-
 mesh/mesh-io-generic.c | 2 +-
 mesh/mesh.c            | 2 +-
 mesh/model.c           | 2 +-
 mesh/net-keys.c        | 2 +-
 mesh/net-keys.h        | 2 +-
 mesh/net.c             | 2 +-
 mesh/net.h             | 2 +-
 mesh/node.h            | 2 +-
 mesh/pb-adv.c          | 2 +-
 mesh/prov-acceptor.c   | 2 +-
 mesh/prov-initiator.c  | 2 +-
 mesh/storage.c         | 2 +-
 mesh/storage.h         | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/mesh/agent.c b/mesh/agent.c
index 88ad84d79..b94ae77b0 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/appkey.c b/mesh/appkey.c
index 3cc1e4f0b..edf815c5a 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017-2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/appkey.h b/mesh/appkey.h
index eda82ac3b..1c22e801c 100644
--- a/mesh/appkey.h
+++ b/mesh/appkey.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 737aee376..a693881e5 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/crypto.c b/mesh/crypto.c
index 451e2da71..f36518f68 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/error.h b/mesh/error.h
index 1669c070a..f3e0f5476 100644
--- a/mesh/error.h
+++ b/mesh/error.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/friend.c b/mesh/friend.c
index 1722a2e71..84a75a13b 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/mesh-db.c b/mesh/mesh-db.c
index 01ae63146..255a2e23e 100644
--- a/mesh/mesh-db.c
+++ b/mesh/mesh-db.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/mesh-db.h b/mesh/mesh-db.h
index 19913148e..da5efa12a 100644
--- a/mesh/mesh-db.h
+++ b/mesh/mesh-db.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/mesh-defs.h b/mesh/mesh-defs.h
index 131b3502c..aba0d318f 100644
--- a/mesh/mesh-defs.h
+++ b/mesh/mesh-defs.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 670c7ab97..1a42c593f 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 5e0bbb009..d5b6197b6 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/model.c b/mesh/model.c
index a632d80e1..034d54496 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 4f85d5e52..0a0e58fb4 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index c752d3991..d54c52156 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/net.c b/mesh/net.c
index 9b1fbd81e..d808e9bd4 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/net.h b/mesh/net.h
index e040e19fa..f19024766 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/node.h b/mesh/node.h
index 6b481e46b..142527b30 100644
--- a/mesh/node.h
+++ b/mesh/node.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index a6104ca89..915bb1973 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index a8bc2c9cf..2ec043679 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index df8884a81..a1f29ca83 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2018-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/storage.c b/mesh/storage.c
index 8893b93cb..2e10a4a00 100644
--- a/mesh/storage.c
+++ b/mesh/storage.c
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017-2018  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
diff --git a/mesh/storage.h b/mesh/storage.h
index d71d11b8e..a537ddb25 100644
--- a/mesh/storage.h
+++ b/mesh/storage.h
@@ -2,7 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright (C) 2017-2918  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
  *
  *
  *  This library is free software; you can redistribute it and/or
-- 
2.21.0

