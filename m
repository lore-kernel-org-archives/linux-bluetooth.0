Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C90919B5AE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139758; cv=fail; b=IhFF1oE5NjKd6JL20zU9JCvkb75Dl5isZrKmUJ8Y5JVoM8/wc5Qag5plNeRnUbDEzpktcQO5k0OfHByNhrNNfQumPjkWA2ROEfsZlFwneBkMlRvPtPKJzLGAWYPVTtgGGDQ0s5jS8+hrG4VI4BdyoRTmzc6ibNd9R3TPxqWFp0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139758; c=relaxed/simple;
	bh=GUUF7av6dbKZyu8XBrUZDf7DkAqTDfnJrL5HRvVoB/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLAJx2OFE/EC2vwaB9NOkcY7mgLftxzoSEsdsNhAm0ZPao5CSB2FasBeB3iILf30T4p85dKn+kcW5pTmIJHdUp/RBb9B0w9vj8MD+nvIGtf5RbPTR6iceWhRHI+nPr5eHUhIHjufYpBipcK4MqoTqCKaLVyS6/8jk8vB/QqNKEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ewJ0inIJ; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ewJ0inIJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Efyq9Ra1p5JuS7QeunJuiOVmtKqA6eYdfEiiVbGfwfFFzBB6xjSwyLmTuPkXwegeatHkoRutxoPlSRh7BqT8ktsqv1vj+PL7tDICk2udExK32hNNkVZaMF2jyn5aOxsHjens44VQM/DcIZOO8rEN6lBEzfgHFLJMxJpEAsZ+dbmhb07V0j39dCSBP3bn09LDz7YwAunp7OkC05sFWh41kck5I9HCBsuuSqsG+1EddaOiUF1FwC4Qc/Py+MSGFSTZYupnxXX4Zu7SOfNYIjo2zveFjXasfmQ0icmt1gNHDzOqdltJnCtQOnOfVSdCAMc3MFvWYuaZoEmyB1ae3yZhrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV2JczZSktyO6A2ZB0wvMJSXmHDOXH38xn/Gt4tuV4I=;
 b=QgVaijbH0/2GOwORwS/X+UmtJcr2T3p5IJ2dYXSPvLY3XkvznRdE5fyrEjdJVtsy+4bRiqMzAgSFs1v7JnXedYJcW+G1WfGU7bUUWX5+i6hbT3g3edASHUEJWd08KGTD3rBJ10NKRXQpNmJ3XT5bUVL3IDkOlQZtPUp7cH/rVDypEr2yduuxtv9TEYfld3XwT1F/GCiNEOl6KgYaBOjxSLbosXcPFia3xrLsLGlZzlWnLlYc2wZ1GXmlUCbmCTMIrorW6abdgPAVBTOOHgcVIQSAwB6ZZbNft172g3o0TfssgtXZpaDu8sz5n1/sXuw7MBiNRWhvDg3VjhAh5/j2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV2JczZSktyO6A2ZB0wvMJSXmHDOXH38xn/Gt4tuV4I=;
 b=ewJ0inIJMC1zkk3tHGCYFtGQGK6GqHXeT6Dxn//ke83kAe8pUGySk57XTM52ZnMUdBDTIpwx0gg+RCoJpU8epUr8ljaGW3Z8XK1O9XRKM5a9h4kVbSkCZvih9WYVQ6+uDTX63ETuO5+7MMf6v7KpgZtRlDPGmer4oCLzWHSrIZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:34 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:34 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 06/10] bap: Add API to get bt_bap matching device
Date: Tue, 16 Jul 2024 17:22:03 +0300
Message-Id: <20240716142207.4298-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0057.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bfc509-e5f1-4602-44d8-08dca5a2bc62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jLotAzywPfION83lhYETXgvmE7GMync4t3jjFkvAMR+KVtjkW36Mx85x0g7a?=
 =?us-ascii?Q?kaw5guNsEPLNLVJ6Mjo6LK6iQT85zxKwv8LRFsLzcQf0knMFqPST3ywCcZe+?=
 =?us-ascii?Q?Tmk8MgWjLdmKKOCb3sUyJ5lyv9MFBrw18Iwfz1Im94uuaqZOcO18zx5Ljsqk?=
 =?us-ascii?Q?cP0/Ca7DZQNbAQn9BuxJjlc41r/XSdLF61gT7TrzXcnPN6360PaGj7QyiX+H?=
 =?us-ascii?Q?SojuGyM7opAKs7v7JVNjEA8O/h/RGtphiy5LFthIDO7VDC76G8g6zHiJPfrz?=
 =?us-ascii?Q?XBUIrX18bh5hIt8tZ/N+rVKwzgw12UzQmwacqTx+LYSCcNX39RIDCDKz8ehm?=
 =?us-ascii?Q?nMcEFrlzqzgvEQ2PfhLUhlJJxsSgb7F/7OHitoH59tfD0murG3uKoGDEO6Ln?=
 =?us-ascii?Q?Z3t/5/UoR357TdOMjwMDzc1J4FDRtBnBILMyW58cLlzoSKZkfV/k2u5qlxL6?=
 =?us-ascii?Q?zqbq2VX+rYgYwZQ7sM/e77br6yer6CEcdDGNRHtS3XMQ+xFoUVG+s94CfO6s?=
 =?us-ascii?Q?YeTwCiEHdetk1RiycyyOQrVfzA+yBJByNEcd7273QP9e8M2fk8gd4M3d0Vx1?=
 =?us-ascii?Q?CriVzSZYL7Ej10EywFIj1fnhE2qB7it8emP6Q95h+yz9EBPusxo9CGU0y8fH?=
 =?us-ascii?Q?XKp3h732V9mIQw2rX/9+uwGe/TGlrWLyQtxm8YAyhoGZ6W0Vy9CpFE7oWMIH?=
 =?us-ascii?Q?SZ7lYzqY6RUwdFAQy7Fz4EkZr2pGHqHYjpq0QxOlYRNEg2r8f9DEdZbG5m8x?=
 =?us-ascii?Q?mEXdWohW8PwiKW2LWUYy1N14eQe4S/6cuvYeIfGW/F43d5I/4fiWRkk/g0bP?=
 =?us-ascii?Q?qUXiTVYRTtv1oYVfAEQ7EjJA4AFRir8sy8wSoBNEJq+o4HCh0/NhdgZWBNuB?=
 =?us-ascii?Q?g47SuXat3iP85OLqZugxTaR4awx6gUDNH1vLUnl+5JXOUEgiclQCtTu/6Gnx?=
 =?us-ascii?Q?+ykSiCNDDqEUCMSVrokETCC6mNbWl6NDZFVVU5P7pm7bl/tFvwvUCrTM+Ltg?=
 =?us-ascii?Q?eQWwgR+Flm5L1Wu42ybDfZpa0Q20toeJg/7yL4T33TWA4dDUTBy+fBlE/kvY?=
 =?us-ascii?Q?bh/kJ887sc+kYOkJRtsSBvOqvBp5B7tY2/YGbSAgvNHWfaOm5BSZH4kH7srK?=
 =?us-ascii?Q?fybLblx8y+84PU3mWmE8RGQOXXTAY/b/p7KN4hg8eB2N/lal+eRNcvLBZQlR?=
 =?us-ascii?Q?lZ56hZwm9xei9/avYokIuyM+SL0EQ4Eq+cmn2vVSO3REGiy6n8+DhZVMaORZ?=
 =?us-ascii?Q?O77PIzzLOFv4ABJDPpcZoxQmrXTJjyxeeunrGva2PVUMieVd5c4+wgfOEqXT?=
 =?us-ascii?Q?7h+va2LT/aiRP2gvS0Rk9FTAeqr4hDJWqyh+b6kBSkeGlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTWheWnz0fsV3QQpXVuuLGz6fb5qFzlbCuDFkQZ5xFG6CgTam0csjiQDeXfF?=
 =?us-ascii?Q?fdbFlu1m+e9bsWlSwFu/onPJdZYkEufkKBYfVPd3GUtAdjLKaCK5xeqE/cl2?=
 =?us-ascii?Q?KvdrXqsBc5v/ZLNJ944BV/YLb4UV+e+j0PcpXywrr1g8ZhY15ptvfaKXPJ0/?=
 =?us-ascii?Q?FZYHIVwUvvFX5/Pk7rNerZBgeEoKRxpMF3/k21i18y28BVEAj2z1f+hSCEeV?=
 =?us-ascii?Q?01eK9oWmsEyUWbi78Y3Fme0fVLOMrcz7jXXFrsw8E2mDCmOLeR+pCYAyNAkI?=
 =?us-ascii?Q?/WJXmneXVXFTScmOKIlb6C6wj6gmV69k+Z4ji7oNDSHWg7FJy9wp3/392XLb?=
 =?us-ascii?Q?sEq56RiLNRK9J1j5v2Y6bX9vrUy0VychZlOYWr/TLVn4qvOl+ErZaVYxyoBX?=
 =?us-ascii?Q?dg4e4R3pP0oTHuwYxxOiI59KbOmzW3sokeAAC/C5BiXP8C2ncvCqOoZ9ksVC?=
 =?us-ascii?Q?rN7HtiOIGhHCr7NO/oLy5ONVdzeuNrLkXpxqfPaEPwAd1MsGUwa6nBMyk3uS?=
 =?us-ascii?Q?kwAyk/fkhBBgaxPbWRGrpGUxYbULfq+R0o9mj2undKfa26+l7n2RUjLbLKi/?=
 =?us-ascii?Q?KIMtZgEGWibqn1twfms5Gu4Z/nhc7gLYhOI4lhqxyHyU0MLeACQMjQjBLhe8?=
 =?us-ascii?Q?Riz+88BPQ30dxj5LLrgiVrls3t6t234uxXeOSygNq357UJU/7/E2kxpoxM/R?=
 =?us-ascii?Q?ebZScruE1ADkn813uffvq1njMdZfjt9BMN9NTkqNFTBQO+fwLVGEwulZeWKY?=
 =?us-ascii?Q?5DMIW2E6YRN6I5d5SPcjiYIaaUxtbFINiXHpFxkyT53rYg0/FRG0f4jV2TKk?=
 =?us-ascii?Q?iUjga8nyAmrL+W+qlHiyhYViJM2WplrND62XBGJOa3hOlzPhQFZFCJjrECUZ?=
 =?us-ascii?Q?+ZdY3Xlaxkl6qAgJP+EwLhlToLbE3a11A7Ag1MWpxW+LTbZXEgioeU/qTUI3?=
 =?us-ascii?Q?KqfRiAOx+SRByW3eP1vDEOuS6ujQnxnN6t/XGqWGtcTfss2/B4ezBDgkP6Za?=
 =?us-ascii?Q?NFqWOJI7uYT8tIwETc+eVduhEgmXIuOAFzF2ctJs849L1aM6XA5h2fAbXwAS?=
 =?us-ascii?Q?OPeZTCQCywMtEuXzBiLXNGa7FzEZlgvJwGHK+orVgYbBsy8zS5E5E/VbQUx9?=
 =?us-ascii?Q?Mh6Hv0VJr33Pkv6WW/cjG1zHe8Xjb6seaO0O0ix6s9S6N0DMx4FdBAOpWW/z?=
 =?us-ascii?Q?HpT389Gd6H3ddJfpZanLxOFLtITg1aQyo9uh7qtRxl0pTDp8ARgTF9ssQ1MR?=
 =?us-ascii?Q?acpfi8dumYpPnjzkmtS55tg5P/UZdjdgGuXOy9wJa0s5st1p4i2joKCYdVWL?=
 =?us-ascii?Q?eASs5P16BYlT/4dfHWKm7jbchdELZA0CjZ0jP3GMMFJ5PoMAISqvQm+5thnz?=
 =?us-ascii?Q?6u0jB+0dgPgd5PZXgwe+9Bpq3ubaKiTAB4jnZCLlerKiw5UrGKU5onwIOUsv?=
 =?us-ascii?Q?hUrcu97sGtOY8BPog9JkmkVe38vSa1AgQ8ZWyMrXQeGwwlxzP9wQE99R7dQW?=
 =?us-ascii?Q?gUGTzRs+xnG40rvTJhsXfigwBu0pKe6+d0IX6YZrloKxdNS4dRbkDfuD0eFh?=
 =?us-ascii?Q?BSVVThIixagMseNVEcschd67ojp/lsFkrzFoV5wMnqhpUZakyOCr7ElIxUl/?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bfc509-e5f1-4602-44d8-08dca5a2bc62
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:34.4806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bkm3Cpj0C3QPLpZHEtj+l0nUwf2va7mHRA122kTXuGzBIqg3LEIYRZ+2RuYnH4D28s8ewyZjl1yeWmmyny7yJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

This adds a public BAP API to obtain a reference to the bt_bap session
with a peer device.
---
 Makefile.plugins     |  2 +-
 profiles/audio/bap.c | 21 +++++++++++++++++++++
 profiles/audio/bap.h | 10 ++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 profiles/audio/bap.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 44fda4536..9dd8134b4 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -115,7 +115,7 @@ endif
 
 if BAP
 builtin_modules += bap
-builtin_sources += profiles/audio/bap.c
+builtin_sources += profiles/audio/bap.h profiles/audio/bap.c
 endif
 
 if BASS
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 6d8289418..fe5390e6a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -56,6 +56,8 @@
 #include "src/log.h"
 #include "src/error.h"
 
+#include "bap.h"
+
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
 #define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
@@ -2751,6 +2753,25 @@ static void pac_removed_broadcast(struct bt_bap_pac *pac, void *user_data)
 	ep_unregister(ep);
 }
 
+static bool match_device(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+	const struct btd_device *device = match_data;
+
+	return bdata->device == device;
+}
+
+struct bt_bap *bap_get_session(struct btd_device *device)
+{
+	struct bap_data *data;
+
+	data = queue_find(sessions, match_device, device);
+	if (!data)
+		return NULL;
+
+	return data->bap;
+}
+
 static struct bap_data *bap_data_new(struct btd_device *device)
 {
 	struct bap_data *data;
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
new file mode 100644
index 000000000..66f8db887
--- /dev/null
+++ b/profiles/audio/bap.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright 2024 NXP
+ *
+ */
+
+struct bt_bap *bap_get_session(struct btd_device *device);
-- 
2.39.2

