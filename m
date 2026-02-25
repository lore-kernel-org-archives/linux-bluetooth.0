Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C03D7D81
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036321; cv=fail; b=oSLQ5I1i1CHa+tc5gwDEWYpN5sYQtlD1fk/InH/r7QrjQ9CTH4xsGA1LfwoO0W5TLuT00zergRxgYk2/N6+Bn2ZJUnWd8y3p8ZUJ1Plo/KOSIckntLJaUN8jIk+9088mMJ3YAFqqh/OJQLbYEjnTiSbokwYoYw4Qrs08td5KqfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036321; c=relaxed/simple;
	bh=N8Jz0AIsxpAcXEhK9VSjYsJ3R/FNYmuxVIgyyqkEDv8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp1J8hFsPYGVlIwl51fiAqjC10oFcXbDkj9CSNWAABXGhYpj9t2A17e4undwNXglZ70Mgyl91ehDXukZ+drulbKh6vdJTGBWFcxZJJaK/nv8aAWXFA/uGZbpgK+f5K3yUiKYECwkR7HqSYbxV/keOnIKqYHEVVV/sIpP7NVs8HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=I4EwEvwD; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="I4EwEvwD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRIrqYM2QFOW+3jUxz4c3hFMP9J4fiaNef6R3oJ0a9M4601ImKHAzCy6bswtcz63vJp0bUzoRB/ApnW7DUjLanjLCZaV3adDmVXMl8CPEiy1y6YErX0Ghcdm6CebsLCtC6SPEF4etCwuImjN+6qWLOTCqSxFvPkck8e//X0roe2JTOpzOx/yofpa9kgWll5zSvDfDllqAUPtOTcWEH6gae5SK0Ana9rKpqDzUuXqSCxFX0PsukFqN8aF855j4YG44l4B7J/9ogAqpR6pka9b93L/fcYd+dyAyTJlWsFZuDq3EXytnBCA8c+edzqPM42BdAlrT4k4gZbubF7hkfy30A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRemba+/2vFXqR34/TnkgP6E1z1VDF+MvILj2qWkKL8=;
 b=XPqxN6sOfSuYgxQ3rjnsLBHf+nCn5NlDvf24XYTJUq1dnvqgKfC3AJB+CxKXxyvwmz5KRb9OQioNsYNjDsHQ2zkED/6AnkXFKB/RfLBVRLtisO/DiloBmry2tSWVhR3TWUhIdUcQJA14qVgf1eC9d58825FJQoxO/G3hlUoO1di/0jmfEzEE9YoQcct90Horpj17P5EHb13ddizhzFS9vaQZLLFWegHI4Oj5Iyczz9q+9YkfjaGCPU/YRA7ljBP/MOM7W2glTWAVY+NOtYxEpdMp6DZi1/hFb1BGeieQnIGUVqqEJUdfdnACOCjJUbUVG0W7uBJ34GhSfp+mA8oMuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRemba+/2vFXqR34/TnkgP6E1z1VDF+MvILj2qWkKL8=;
 b=I4EwEvwDbMsrZ8alGgqdymAq85+RHRXdLpuJ2xqxcZ9K0+1IMifHJwCOAVU0TT4Vo+ZIbrw8XWCxD5ij58sJc097/3jOB3zRIONQxC7onP/hh0175YA16yUvwRzTPh1dYxhqODrG+lRF6z8KZs4YPXP4I8ld6CIfKO8ROdj1ixE=
Received: from DU7P191CA0024.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::16)
 by AM9PR03MB7187.eurprd03.prod.outlook.com (2603:10a6:20b:26f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 16:18:27 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::2c) by DU7P191CA0024.outlook.office365.com
 (2603:10a6:10:54e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 16:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:18:27 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:18:27 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 05/12] attrib: replace ATT_CID with 'shared' BT_ATT_CID
Date: Wed, 25 Feb 2026 17:17:08 +0100
Message-ID: <20260225161715.20394-5-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|AM9PR03MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e96f1b-df03-4312-3e35-08de74898217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	Jf3fp5mSM/Q/UwW5JoWdPAp/nRID97SlWAMgdhhPiZlXXyBPIvMMfKAc0mbpp3juusod7Yhu0Sj6nZveSym+XbiwttgjaVc9SdH/7tn+UlFi7vvoeURJm+slhIZihKg30jWVkBrZLM6ocuUIZL+tNKKEn23SkvS1T7wTF6pvJZggdr8ggu5Lfa4hVVxCqVReTGrDOu7spx6lQug8DHgHSUJpn/sF/8KE9FL9YszuHCpyyjMXa2mO0hnMISnAj8eEmN7Rsb8EJQfkykBpiClyUXjkcFE1mD0IbRxoHgHRVfWo1IJmkmJxeb41q3QnHKDx6k1yfD1XFeaf2nE/594mMGKMPz/VSd2vN6+nSixvqZqnYMNYHo5N0sEH6OMjeWwS+nO7pb4uMkiRNslsXDaPhUxv8kT/JfDCk23N/u0bO2LTautZUOB4Pt5cwwgUYFc+L+Y5m16blqtSkRDQnJPLCdk4usOiTDhqe4dsxwLkW43yx0ABpz5B4iF8lQ32ZN7PH6p092bVy8YtRJPfsT3Pcy69CZ7rYYvBY0uDkA3Q1sU3spT71KDPmHmoXKxlZmq8DGnivbpkvlurI24foC1YKXZ2CLYn1ldZSWLDPC1gKRpE0RJjplHQktg6bHo/r+6LvrvuWToPuxqrJK/PwcEYhBe1aoqGXgt7WfAGef3SzhzfbIrgTVJNACBgVuFTOZPXia4Hi8QEUPBja86uP/KYDA+u+yK3N5F0A8Zs+WUdMlIbeokEGd4JtmRZGnf3AYW9H+/NPf7PTPQhsgZ4HK/9JExVuYP3qwdtqt5RAWRmWDG4snIN30ctfTg0UCEVKZMR9OKX10qJ+vKHWBaYUYHZ2w==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wfd78EuiHavk+wxl+4It6iwUynWnxUoAqJzXw0FybKddjHojDfGAtuiFU26hxr374sofFz9XL/jrvk1+fsiQQzMG+8CjEVlwep+4cq51sqOtiFOfqGA16loXh+VC4lGW6TQF6rBgl2h29t2LGKvDs516/tMXFQk2HOhFI/VqYd8NVu6JbrEv89jRnj9lV50wnAJ6LS6y8znGilaktKttNaivcmvKLIFdfVIDbFtPfa4hjGzRzzSlSqihn7FhcOKP77yBND6ZMuJNGe8AWpgM5pPlYOG2mpiMP8Gp4uVQCcxRkN/9EeNwHWN0QYYSOkD+3NUbW2GakjnszvVuyUWgmuYy+eDjqhUO+wNL3fYWIhMy6EpUJOoIzDwh4cnOJJ/pYhgwEqN78JYS2tw+UlbZ6YJWWn+Xp/P7pCl7YaC+Cb37gsyGIOAs6NL9nh3abghN
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:18:27.4335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e96f1b-df03-4312-3e35-08de74898217
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7187

Avoid multiple definitions of the same value.
---
 attrib/att.h         | 1 -
 attrib/gatttool.c    | 3 ++-
 attrib/interactive.c | 3 ++-
 attrib/utils.c       | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/attrib/att.h b/attrib/att.h
index 13a0c3a31f1f..613a018ba2c6 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -71,7 +71,6 @@
 #define ATT_DEFAULT_L2CAP_MTU			48
 #define ATT_DEFAULT_LE_MTU			23
 
-#define ATT_CID					4
 #define ATT_PSM					31
 
 /* Flags for Execute Write Request Operation */
diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 4fae9d41f44f..c984bef9dd39 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -25,6 +25,7 @@
 #include "bluetooth/sdp.h"
 #include "bluetooth/uuid.h"
 
+#include "src/shared/att-types.h"
 #include "src/shared/util.h"
 #include "att.h"
 #include "btio/btio.h"
@@ -132,7 +133,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 		mtu = ATT_DEFAULT_LE_MTU;
 	}
 
-	if (cid == ATT_CID)
+	if (cid == BT_ATT_CID)
 		mtu = ATT_DEFAULT_LE_MTU;
 
 	attrib = g_attrib_new(io, mtu, false);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 4329685c4f7a..07d6cafc57ba 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -30,6 +30,7 @@
 #include "bluetooth/sdp.h"
 #include "bluetooth/uuid.h"
 
+#include "src/shared/att-types.h"
 #include "src/shared/util.h"
 #include "btio/btio.h"
 #include "att.h"
@@ -159,7 +160,7 @@ static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
 		mtu = ATT_DEFAULT_LE_MTU;
 	}
 
-	if (cid == ATT_CID)
+	if (cid == BT_ATT_CID)
 		mtu = ATT_DEFAULT_LE_MTU;
 
 	attrib = g_attrib_new(iochannel, mtu, false);
diff --git a/attrib/utils.c b/attrib/utils.c
index e48bf4ea5cd3..ca05baaa1e8a 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -22,6 +22,7 @@
 #include "bluetooth/sdp.h"
 #include "bluetooth/uuid.h"
 
+#include "src/shared/att-types.h"
 #include "btio/btio.h"
 #include "att.h"
 #include "gattrib.h"
@@ -69,7 +70,7 @@ GIOChannel *gatt_connect(const char *src, const char *dst,
 				BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
 				BT_IO_OPT_DEST_BDADDR, &dba,
 				BT_IO_OPT_DEST_TYPE, dest_type,
-				BT_IO_OPT_CID, ATT_CID,
+				BT_IO_OPT_CID, BT_ATT_CID,
 				BT_IO_OPT_SEC_LEVEL, sec,
 				BT_IO_OPT_INVALID);
 	else
-- 
2.51.0

