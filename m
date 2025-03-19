Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012008.outbound.protection.outlook.com [52.101.71.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCF620E31B
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380676; cv=fail; b=kNDSj2F6SkyMLyDlHUgPu9UhENhzIErLHvo54FdqicFfBq8CHYJM1C52YS7yzPB45BgKnCxXT0Yz7kNuy4TX9+u1XcN63tWIYj1fVqe9n+HF+VtE3WI1xQATniprdY2xsHzCXSvtPooaZcx9jFlBTyJEJNL6+W9n5OLHweLq1HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380676; c=relaxed/simple;
	bh=zVdNB62KLj8tZmiIpDCSnQN+R5dn6zx3GCz1YAdjD/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRPT0NB26/AvuafQa9ICCtGF1AsOgbtUL6dvI0ecArKozRhtuzGhDUX22gHaPB2vgdmCyxciPNIdsXznTJP1EZq/Xq2zfzdNkJY4U14Jy9awBcW7ET0AJk5mUHNfpTvPQEaFTsMAV2ijwV1VVK+Bkp/Rg22op3SBD0P0aikGYOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ukppw7CD; arc=fail smtp.client-ip=52.101.71.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ukppw7CD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4de3b0Z1vUd7jwCeQt5d/eP0HMQqkf+xwtixUQESnAj5dBFgrkO0RJa5eR/CGNqB6GwlF1kONSU9z0aYQ/H/h+B32CKv2W7ghNp9cF2cvnpTeUTcSLf5SpSKyRRcpcwZB8Ter1Z54qakg1blW+QVzsnvzwWua7kBtyHGVHv2B4Im7/2zDAoOK5X93EWvPld1NTQ8907ItcGBstUGhF8GWQtWF8wm1Huj48xOgIQlv9YmHD13ZoARAdjG+PWcpRu89Iqfi3aRfVCEKYqOwflDcSDGIKsqXPPf8wUbxt0Oc7qhgiAWRXyN4YiTNgmZ2VOTuFhKPFspRAYroddPY46Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gej0HRQ04nVo3rYN+KvlFp7ModDVv3dnJNVy7igk8E=;
 b=Injj+SM8y1JD3WWpvog/AGSzTVLnTYhVWQMA8/sI5AyqZS996EhKiW7UovONrQh8KZhelTYGaPiA0jENpoNmDrzZwf/fWyg5sW0RsqPoAtfMGG4spVPi/muiYD8a4+PTyxWCkw9U8cwwmcxKwceVbaHPVJpvmw+rBiVW31+eBz6wv7zV9Wui3LWMVYCdA5H2o9vYAubW50cejuwtEhacltJ0CdtqMtNHk4uu0pzuGCLeGd4xXS7LSi1/IMHxGoOA0z/xLpNbGYzEF0mMgpAn1rDbL/+4UW2vqTmDQJxBfvSqXKQmQGiIk6MKiPFP4LfsSRsuqz6vnneU6sa1BdrIUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gej0HRQ04nVo3rYN+KvlFp7ModDVv3dnJNVy7igk8E=;
 b=ukppw7CDSZrkI6I2v1zZYb2KQh4ZZNJpDddgwXyADkaIuP82rJ3Kj1sRWbJ5v6JANO1GTGpYR9x3vLuieiGIawvSnKL9xSkX8v3z5geteEE3VxvApuLFIT5fqwBhsXuw8MEw/BCkAM8YIpkL88Zx/CaQeVDodvkroc+bgOIOMQs=
Received: from AM0PR10CA0102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::19)
 by DB9PR03MB7227.eurprd03.prod.outlook.com (2603:10a6:10:1fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 10:37:47 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:208:e6:cafe::5c) by AM0PR10CA0102.outlook.office365.com
 (2603:10a6:208:e6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 10:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 10:37:46 +0000
Received: from N9W6SW14.arri.de (10.30.5.20) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 19 Mar
 2025 11:37:46 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 2/5] mesh: include <time.h> before <ell/ell.h>
Date: Wed, 19 Mar 2025 11:37:21 +0100
Message-ID: <20250319103724.10433-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319103724.10433-1-ceggers@arri.de>
References: <20250319103724.10433-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|DB9PR03MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 40383f08-a41f-4d4b-0b04-08dd66d216cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LcoKU1/CGclglRak7nqkNlR2c6kJmKS+P675z00px9GK9qnTZCfdqA/8iZWJ?=
 =?us-ascii?Q?pLIagonGN0xhW1ge35SM7iYGRgredHzIs4wwtcFwh9Lj/ZtBXqMPvgnimkDd?=
 =?us-ascii?Q?1JrSF7BByYOG5Slz84JFHYtZduGb9Y7eEbo7bW7ubkoMVnkefVjsHIwo+B5K?=
 =?us-ascii?Q?EqRlsMkFCFGWKVQAlicp/CFZjvjPS4QRqdPWxRK6xPk5Up05JmwCMElhkOzr?=
 =?us-ascii?Q?8p1QaQYqPyIZcVGxx5ZcrumZIRKfT5Y0KSloDkN3qmv7RxQWR9Fh3ExFzg31?=
 =?us-ascii?Q?Qck7ZfyKw5YOOLAVwBJ/AZtYKhwlEuStmQwouZIR4tlYC7FJnq0qCk+p0CMH?=
 =?us-ascii?Q?iKezKNgD4ZJpwflA6Ojd/Xi38JGXKVkDChNvsLYO3XbZmU5tJ07bLgrqNwIO?=
 =?us-ascii?Q?AYpLAgbi3aUaX6BxP3LVFXlx6kZ9BJ6k6pdxwZD/h/CvaBeq5L021gOvOF+M?=
 =?us-ascii?Q?5IJ/AU9+NnSPs7LBnv44p+ZqPq+PfI9wIhKukgzfwRhHatdONH07nTFcP5r3?=
 =?us-ascii?Q?ovEntq6w3JqHt+S97joD57h+yPK6vJo4rHf3N22pqlQjzEV3hFCOZeqv6ttr?=
 =?us-ascii?Q?u+Rgz1UttKtqyXH26Z0uigqjTejFzqHKWKb3TZSLjKU396HOkA6Rg4qCysOM?=
 =?us-ascii?Q?yMf8Q2UXBnzc/bMW2mOrBRgZV8nnN7dGeHRpe4o3h2Gq31AJyw7j/mmacxQe?=
 =?us-ascii?Q?B0ut5CupAMiy0r0X1lUy4f7tWcZe/RvfOfSvNhHebdlKyyFLDOX+4hwEtVYD?=
 =?us-ascii?Q?cm9i95MGdz4+pL2YlAy99uPuIJNDhT2U4IOIDarrxyVxCyw7zrH5jjv5TtZK?=
 =?us-ascii?Q?W13eIqjnsNr16Ax6dUltwUj4Ve7rm4ecvgkS/D1MH15/xxwNaiYoPoI4fAaD?=
 =?us-ascii?Q?0iDyun1eaOUtRXVISn9hSooTkwLiHGSr1ndXO91SbOQH9Irtx05hUB2Or8vR?=
 =?us-ascii?Q?1LBJ1LCPd8jNh0Ay7uZhzx6u5IiB0m/DtcGiN6HzaTvw1IStJtxnnZ953V5a?=
 =?us-ascii?Q?uMKX3izdPXMJ7H6xmPXPnIVF7gIKwCC0l+CsJT1Pw8219GiBEe8Zi19wuGyi?=
 =?us-ascii?Q?v+SmL99T9+/AT/0NLEUGU3jt57xW0urf4kMK5Kw9zMbPKvnH08M/nKH2YMMT?=
 =?us-ascii?Q?7BUCcO9xsZYqvKbl0z7aVNc8Znm6GvFiyb2mzIYGEELsPez2nPOSRx2Z4SVX?=
 =?us-ascii?Q?VJeOsPpD+bQqK17y6SRdt+bdhaFy5FATwMtW9kYpwzVbJE/apOt5q+lwiZDh?=
 =?us-ascii?Q?YuYrAf5WohEa0WEMtliKOtxsPKgrAh7Qe/kgXhhYcLH+Z4cf/9n8LJVeCjVu?=
 =?us-ascii?Q?k6wHxBrEuzXGNwomBBJG3X5Rbg6zU2zGSfCF8en+8k0iYMEE3jsz2LvRH5No?=
 =?us-ascii?Q?r7wu95k/VddW6NJGOSFEpQb64Xd7ZJzC/s495BpwHZrI9rRWFC75sA8j/9/5?=
 =?us-ascii?Q?AjWLJBjPcZ4=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:37:46.7867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40383f08-a41f-4d4b-0b04-08dd66d216cd
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7227

I get many of such warnings:

In file included from ../bluez-5.79/ell/ell.h:8,
                 from ../bluez-5.79/mesh/prov-initiator.c:15:
../bluez-5.79/ell/time-private.h:15:43: warning: 'struct timespec' declared inside parameter list will not be visible outside of this definition or declaration
   15 | uint64_t _time_from_timespec(const struct timespec *ts);
      |                                           ^~~~~~~~

It seems that there's no guarantee that 'struct timespec' will be
available via <sys/time.h>, so include <time.h> directly [1]

[1] https://libc-alpha.sourceware.narkive.com/yb0aXzSp/defining-timespec-in-time-h-or-sys-time-h#post3
---
 mesh/agent.c              | 2 ++
 mesh/appkey.c             | 2 ++
 mesh/cfgmod-server.c      | 1 +
 mesh/crypto.c             | 1 +
 mesh/dbus.c               | 2 ++
 mesh/friend.c             | 2 ++
 mesh/keyring.c            | 1 +
 mesh/main.c               | 1 +
 mesh/manager.c            | 2 ++
 mesh/mesh-config-json.c   | 1 +
 mesh/mesh-io-generic.c    | 1 +
 mesh/mesh-io-mgmt.c       | 1 +
 mesh/mesh-io-unit.c       | 1 +
 mesh/mesh-io.c            | 2 ++
 mesh/mesh-mgmt.c          | 2 ++
 mesh/mesh.c               | 2 ++
 mesh/model.c              | 1 +
 mesh/net-keys.c           | 2 ++
 mesh/net.c                | 1 +
 mesh/node.c               | 1 +
 mesh/pb-adv.c             | 2 ++
 mesh/prov-acceptor.c      | 2 ++
 mesh/prov-initiator.c     | 2 ++
 mesh/prvbeac-server.c     | 1 +
 mesh/remprv-server.c      | 1 +
 mesh/rpl.c                | 1 +
 src/shared/btp.c          | 1 +
 src/shared/io-ell.c       | 1 +
 src/shared/mainloop-ell.c | 1 +
 src/shared/timeout-ell.c  | 2 ++
 tools/mesh/cfgcli.c       | 1 +
 tools/mesh/keys.c         | 2 ++
 tools/mesh/remote.c       | 2 ++
 tools/mesh/util.c         | 1 +
 34 files changed, 49 insertions(+)

diff --git a/mesh/agent.c b/mesh/agent.c
index 2f9697a3330c..a1413c0008dc 100644
--- a/mesh/agent.c
+++ b/mesh/agent.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "mesh/mesh.h"
diff --git a/mesh/appkey.c b/mesh/appkey.c
index f31d8194298e..b03ddae4714d 100644
--- a/mesh/appkey.c
+++ b/mesh/appkey.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #define _GNU_SOURCE
 #include <ell/ell.h>
 
diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index f64566daf39e..e5d5a86e0d8e 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -13,6 +13,7 @@
 #endif
 
 #include <sys/time.h>
+#include <time.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/crypto.c b/mesh/crypto.c
index b712a26549ad..b7607bb83794 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -15,6 +15,7 @@
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <sys/socket.h>
+#include <time.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/dbus.c b/mesh/dbus.c
index a7abdc428e88..c43d6550d87f 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/friend.c b/mesh/friend.c
index 5b73da68916f..6aacf6338f24 100644
--- a/mesh/friend.c
+++ b/mesh/friend.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/keyring.c b/mesh/keyring.c
index 1e1de3e54bfb..cb091e15b613 100644
--- a/mesh/keyring.c
+++ b/mesh/keyring.c
@@ -18,6 +18,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <stdio.h>
+#include <time.h>
 #include <unistd.h>
 
 #include <sys/stat.h>
diff --git a/mesh/main.c b/mesh/main.c
index 145bcfa98d85..5b8af4bc7345 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -18,6 +18,7 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <signal.h>
+#include <time.h>
 
 #include <sys/prctl.h>
 #include <sys/stat.h>
diff --git a/mesh/manager.c b/mesh/manager.c
index 0c98721bf4b5..63551b4ee4c7 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #define _GNU_SOURCE
 #include <ell/ell.h>
 
diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 5372130d7f8a..86e7d87e482e 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -21,6 +21,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <string.h>
+#include <time.h>
 #include <unistd.h>
 
 #include <sys/time.h>
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 13a863b48158..3da0a8c2d227 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 #include <string.h>
 #include <sys/time.h>
+#include <time.h>
 #include <ell/ell.h>
 
 #include "monitor/bt.h"
diff --git a/mesh/mesh-io-mgmt.c b/mesh/mesh-io-mgmt.c
index 5f0eb206b3b2..d185f5c9760f 100644
--- a/mesh/mesh-io-mgmt.c
+++ b/mesh/mesh-io-mgmt.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <sys/time.h>
+#include <time.h>
 #include <ell/ell.h>
 
 #include "monitor/bt.h"
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index a9fa53308eb1..4fd72bf8480d 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -19,6 +19,7 @@
 #include <sys/un.h>
 #include <unistd.h>
 #include <stdio.h>
+#include <time.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index b953bf4cff81..99c7c2014375 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "lib/bluetooth.h"
diff --git a/mesh/mesh-mgmt.c b/mesh/mesh-mgmt.c
index fd21a168ab27..87036d180fe0 100644
--- a/mesh/mesh-mgmt.c
+++ b/mesh/mesh-mgmt.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "lib/bluetooth.h"
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 91cf25175384..50059adbed57 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #define _GNU_SOURCE
 #include <ell/ell.h>
 
diff --git a/mesh/model.c b/mesh/model.c
index 4ccafa17edd4..01b21675c557 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -13,6 +13,7 @@
 #endif
 
 #include <sys/time.h>
+#include <time.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 57a9df04a2a7..42d498ce0ede 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/net.c b/mesh/net.c
index 05ca48326fc5..cc862dade5ae 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -15,6 +15,7 @@
 #define _GNU_SOURCE
 
 #include <sys/time.h>
+#include <time.h>
 
 #include <ell/ell.h>
 
diff --git a/mesh/node.c b/mesh/node.c
index 93537c5ba4cc..a85814727d40 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -17,6 +17,7 @@
 #include <limits.h>
 #include <stdio.h>
 #include <sys/time.h>
+#include <time.h>
 
 #include <ell/ell.h>
 
diff --git a/mesh/pb-adv.c b/mesh/pb-adv.c
index 7a1dd87dc210..0b1fd7d577ff 100644
--- a/mesh/pb-adv.c
+++ b/mesh/pb-adv.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
index fd9d4cd5d209..241345bdd1ea 100644
--- a/mesh/prov-acceptor.c
+++ b/mesh/prov-acceptor.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "src/shared/ecc.h"
diff --git a/mesh/prov-initiator.c b/mesh/prov-initiator.c
index e353d23865ef..dc19d1e9b7a5 100644
--- a/mesh/prov-initiator.c
+++ b/mesh/prov-initiator.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "src/shared/ecc.h"
diff --git a/mesh/prvbeac-server.c b/mesh/prvbeac-server.c
index dd0e4cbf449e..f318852b8a42 100644
--- a/mesh/prvbeac-server.c
+++ b/mesh/prvbeac-server.c
@@ -22,6 +22,7 @@
 #endif
 
 #include <sys/time.h>
+#include <time.h>
 #include <ell/ell.h>
 
 #include "mesh/mesh-defs.h"
diff --git a/mesh/remprv-server.c b/mesh/remprv-server.c
index 927dbab0e361..53c764f8626a 100644
--- a/mesh/remprv-server.c
+++ b/mesh/remprv-server.c
@@ -22,6 +22,7 @@
 #endif
 
 #include <sys/time.h>
+#include <time.h>
 #include <ell/ell.h>
 
 #include "src/shared/ad.h"
diff --git a/mesh/rpl.c b/mesh/rpl.c
index 69533bf431b4..8de4a8d567b1 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -19,6 +19,7 @@
 #include <unistd.h>
 #include <dirent.h>
 #include <errno.h>
+#include <time.h>
 
 #include <sys/stat.h>
 
diff --git a/src/shared/btp.c b/src/shared/btp.c
index e54eb830f9b4..04ccae9d81f1 100644
--- a/src/shared/btp.c
+++ b/src/shared/btp.c
@@ -11,6 +11,7 @@
 #include <stdbool.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <time.h>
 #include <unistd.h>
 
 #include <ell/ell.h>
diff --git a/src/shared/io-ell.c b/src/shared/io-ell.c
index dee9a95c945c..35dc38e2ee67 100644
--- a/src/shared/io-ell.c
+++ b/src/shared/io-ell.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sys/socket.h>
+#include <time.h>
 
 #include <ell/ell.h>
 
diff --git a/src/shared/mainloop-ell.c b/src/shared/mainloop-ell.c
index 5cc0311c2a42..1aec7fad9e96 100644
--- a/src/shared/mainloop-ell.c
+++ b/src/shared/mainloop-ell.c
@@ -16,6 +16,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <stdlib.h>
+#include <time.h>
 
 #include <ell/ell.h>
 
diff --git a/src/shared/timeout-ell.c b/src/shared/timeout-ell.c
index 02628692642a..7867c7570277 100644
--- a/src/shared/timeout-ell.c
+++ b/src/shared/timeout-ell.c
@@ -8,6 +8,8 @@
  *
  */
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "timeout.h"
diff --git a/tools/mesh/cfgcli.c b/tools/mesh/cfgcli.c
index 1a404af38ebd..fb6fa666d2db 100644
--- a/tools/mesh/cfgcli.c
+++ b/tools/mesh/cfgcli.c
@@ -14,6 +14,7 @@
 
 #include <stdio.h>
 #include <stdbool.h>
+#include <time.h>
 
 #include <ell/ell.h>
 
diff --git a/tools/mesh/keys.c b/tools/mesh/keys.c
index 134c1a10e210..d1d2ffefa1e6 100644
--- a/tools/mesh/keys.c
+++ b/tools/mesh/keys.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "src/shared/shell.h"
diff --git a/tools/mesh/remote.c b/tools/mesh/remote.c
index b917ae9df227..2d400081994e 100644
--- a/tools/mesh/remote.c
+++ b/tools/mesh/remote.c
@@ -12,6 +12,8 @@
 #include <config.h>
 #endif
 
+#include <time.h>
+
 #include <ell/ell.h>
 
 #include "src/shared/shell.h"
diff --git a/tools/mesh/util.c b/tools/mesh/util.c
index 6e81bf5f0285..c11010129f3e 100644
--- a/tools/mesh/util.c
+++ b/tools/mesh/util.c
@@ -13,6 +13,7 @@
 #endif
 
 #include <stdio.h>
+#include <time.h>
 
 #include <ell/ell.h>
 
-- 
2.43.0

