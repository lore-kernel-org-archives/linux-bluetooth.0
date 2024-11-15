Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5918FDDB
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667134; cv=fail; b=BSy0/w/pQSBMjEpfACALbd7DyFK6Fzx0beiIYHKmUDmNNbUOwTUbb662nAaR/F64tIEnX2Dwt8rjfL2yeTb4Ue9lO3t3kRA77vsrRcVtfR7V2O4VNu6P5bQJOUvgbeLwRH/RWXSiZLYJ3qTzLlrI54tb5RNtIMsUmiUOnvgvz6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667134; c=relaxed/simple;
	bh=6sfnvi2UZ0xRsZkgqHHQvSmz09FVKeSj1ApvrOnSEBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bq/WmdzlIa+kJMNaMuve7VchMoHl0WBvhdctjy/YksZZ0/+aauApcL+1GJn+yCObQacgbwisdoUxcRpCck5v9U0/kZPhu3FE3piE4Y81n1DbUZx1R9nlHK92Zwjh9+oehhbAu4sLOxYZmx61vhdCzJ/CQvgEHqSHyGHpvAlUv+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jzK1CXnF; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzK1CXnF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bX0AhwgFpfXPAxCf9gVDJft7n7VeKtcZ3Xh5pPCN0Y9qvr4iNl6euQaFQt67I1gzhGQ1jwkIdJS+uwoV22X0/8wFjdPIs0peN600Aw13P7S5BbV2SAN4E3UC+rV1Uswbv7mDtyw/KYPx9hoiwCMU2YeAldiXXn5ofxpNrBcBOV+WZ/CsKGrqDtgn6NKuPw3Bs5sNvcFjfooTHjqKmF3FIyjzxkiEEAvtRkEGh3sP2KHkxR2xJr9oL7Dx/vFORfHtgg6viQFipI/3vLiOkKxzVfx8s3W+0klV88AUeQ5tDQ/o/sxeLSXLXV48+COzz22vNlC7nl4I0B9JI2agEclrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4uugzXthhrM3auc+WFqqLF8g8zQF/FpSguKSElC1JU=;
 b=vxmPTy+Bm7T0pqmpDRVB6JB0K0hTwUu7SO4yvNkOtIMe+k2Z05WO/Kw+B//CViQF07yoyjyJrNgUY0CaUHG2iV+U6QKmEsum+x6RccCqqeON3zvX4WGaV4PSAMDZqNO3bde38ODJuuQlKEj11P9LPMRcniBUNTOlK4Al/rHfIYlBq9AJB9Bt+rtH22vyDOg795xOcWL7Bq3xBTVUq9Tkjx2fJvfak1gRzWZLepN4Db0kkgoBWiA0auGI3hMzq8pYyojklmKgnEkNTX52FGX8+7OEJGzKloTu1i/x+Y5ZBsQrkF9f3N/VTY3HdddewZ+vrsq/SDEthHONgllPvq+LDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4uugzXthhrM3auc+WFqqLF8g8zQF/FpSguKSElC1JU=;
 b=jzK1CXnFQNKpwVOVcWAKraz27Tur+dcZkI47k70Mz0HWIYwRLQyQmvPuyvIC8xoKjNcpVxveTtvw4AN0TLJRHxVjtBVaHtqCVX6e/iz3w8loWT1mj2pEgWpNSyF9pigrA/E/v+jo1+MoHicCvzypg5NhjpADa7+0Dxm14xKhY+fvMQnwq5nE/zvk/ycxVQDqUwPmA7no/cBaNhI4eOy5yDs5ErvEqoFOfhTPpe3DGfD2pXPEM49wbS6aifX+5YOZtha5J2UwISJfmVzhfobyIhUEYH38T7ClD6t5pa9ECDfmsxB0tRAxe2OZREgeqrQmfaf+R0b2SysqNXYwfFVIjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Fri, 15 Nov
 2024 10:38:44 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:38:44 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/6] bass: Rework Scan Delegator to handle BAP streams
Date: Fri, 15 Nov 2024 12:38:22 +0200
Message-ID: <20241115103825.19761-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
References: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: db17b700-eb63-4fb4-c0fc-08dd0561ad93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grDarMHsC1s30I2iewWu/SGFVdCNHy28eTOueTVb3BAlyqLP1v7bnhg1iIBS?=
 =?us-ascii?Q?w1qQGNzxVZpk7wwCaQAcooVTIBbikXYpzNzHa/MVqjGYdiPRxH6/Z6dxB0sz?=
 =?us-ascii?Q?4YGt0E63AcRlmtLhZ4n2lo4KYMFV+lc7QrkHGCmAV75XAnkOKyktaAbjXd3V?=
 =?us-ascii?Q?r1/A7GYiOYISJrElCSjXcKXG+GKOV8tG6lU2M3QIsgg0SaVTOMi8PyDYbvwn?=
 =?us-ascii?Q?wPfjC1fQSKQ3f2VyVztylboP8YG5uS+Qxb1jir5GxPNYtnp7gsz2zthcWXLq?=
 =?us-ascii?Q?KBN5KqHQ+hE/dPdsHF81XydO9pa1KPN08b2ThZW79mRIDGjsRUfhtZ6ostJV?=
 =?us-ascii?Q?LoBKnG6Uj2GmXA594lXIll+832ax/1qzi5GdQb7syN9z8moT41ZXeIKriDDc?=
 =?us-ascii?Q?cRxIcA8Z/DuvqYSb1tY9bi0d+BSRRg7LT4Uoq5HCZ68a4Nr3VLelt6kJmtW/?=
 =?us-ascii?Q?j4Wvv+orrPzwLsRq8Y8gvQFpqU8Hy/t7PEYbpVIGe9OubVUV5GAlEc69+Vck?=
 =?us-ascii?Q?R8zCPo08bUqSvk23elNojhCyP4P5f4GnqToK62VqybbYt48uI3OtRK4hWFKx?=
 =?us-ascii?Q?DUOnthXz6+j6W1/DGhseFNwE/RMvHt9JziKdCvmCHlK1FT0mXPVZSam8lUif?=
 =?us-ascii?Q?PRXbs7zwEtRoSbH7zj2LI4+K5KBuqM9tIpO5N6QoIZ+5IYui5sYLevKJK0ov?=
 =?us-ascii?Q?AOOyv2Qpm9SWJ1t0Xv7kXjsOvZ3uCTuQdhCY6HR1Y2zPcEYFhhERdN8HvOV4?=
 =?us-ascii?Q?l+iBG95LC59QTuQ3cj9Vuda2nDvoXFJbMWGP4aDGEnt8PqvSkOdbMQ78Wk4K?=
 =?us-ascii?Q?2FnMF7NdjIsu+Xaq+tbi9maovvOjzsrPrS3zM6gl6haUCsVA7NFNzOqlhgCE?=
 =?us-ascii?Q?fGGbSgJmpYOjQm5NNFM2TqKTFiTryhiK/bnDmCOV1lhRaM2fA6rs/cpDIzkf?=
 =?us-ascii?Q?cNlC6brwZE8keT+AGprvJExcPwdudYigzFmMRwQ4oVO1u6BcITw0wfZCwusG?=
 =?us-ascii?Q?XFYdxKZ7e/iE2poUPM6hcylxCzxlNUidThCePhCOhSCfx0liXkiB/Y7BcosR?=
 =?us-ascii?Q?WZlhanHXCQRC8QCZkMMNp4hAYplEtw/iGrsVfC2CMCFIOmAF0OsUFY9hIDjj?=
 =?us-ascii?Q?ysaYFiHFlWNPZg8m7dfmrH31Bdw3NeXkjh7CtuJI6REBTgMZ8etLHPEMleYZ?=
 =?us-ascii?Q?27hRZ7jFIbUjzL6Q9+fgFf4MNAx/WTgJYHbSr2ZpXPlZW6bpiVmMCMCa8yTP?=
 =?us-ascii?Q?UJ6WPs9GW9/icIOx/WUhQTV0l97ngqoJtF2/y+rD+DcwJfTLKCr2+/2t9B5H?=
 =?us-ascii?Q?sL/UvokanV8VOd9TrzTTLv0d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y/NoeF2Taa7HCCqSHw3SvrdKHitolJTqgAQu2ogwB0KY+SX12o7UUwbQ4N14?=
 =?us-ascii?Q?Oeg7JqGG/I5xCqAv/9kxmpiESlpq3A0eFX+Q3ylQDX9uGZ9P+wcwGR4m44R3?=
 =?us-ascii?Q?/iw9HBNVAX0vqVWBDWMf3wlg20Ulm3T9O28b/M2v3GMDy1b6zLMO9Tj+v2b/?=
 =?us-ascii?Q?lQlbM+yXryInsqxfqoPdG1YeuA3jp58bEVGPxC51DH+xZ+phfIQrHLlAfh7d?=
 =?us-ascii?Q?0ZgrmxeIHfdXO7Xp8SYZPosQAdJ6pm8Y2013xUw88PgnSWUhoEq1UoTF4Ql6?=
 =?us-ascii?Q?VU2k71E4I4zZNPaztcTQrQeRF/aWvW6uIF7oBPVEnDJl5eiqwTaeTsR/SnaR?=
 =?us-ascii?Q?iNvtPbtnqUiF/XKUVR0pQkpRzIghzdmui3tdsfbgJWOAlnDboqMf8hkDCXfs?=
 =?us-ascii?Q?76eNO9s54AvtXPhlW/EzsYqsKOdo3Xp19ecoC5wogeL+cND0GdRnhVphdIoi?=
 =?us-ascii?Q?qlyx2BDzTZ6w5AjeacCdKEQsR5M/haeE/jpTbdjbQFkruC9Xj4sJLUL7CQw6?=
 =?us-ascii?Q?wLcoyE1wNHkjysP2DEtOsJ5YzsH/Ccc9MkTgNsRLyvrS6z2fE3gTF/hggNFR?=
 =?us-ascii?Q?Bdbf5CpjB+YO9a2zKLfeM/9htAqGJKq0wGUKsWnEG1Olcsw4PX/J3PtK3Hkq?=
 =?us-ascii?Q?LJeQZIaa/kw0JRzlEC00Vwrz29Xzz48rKoqhPpkqGXlWZCwbsdTepZaS+RBQ?=
 =?us-ascii?Q?yW0xnWvhk7vMEkP9hVxGmMd8RX5Xo5j2C6YC0IRHRrYjs8OR3fajA5WxikFK?=
 =?us-ascii?Q?GC76Ublf9SFkMX7pWkSt1Kw7PUIj9tuWTklRrPTS547gtDr1qEAvgQj0k8uQ?=
 =?us-ascii?Q?wZ20+yf/ZtTi2X5COeRa6kwVHJWXcBRV0EkJNEFhK72dkMvNrjObC5AfXL6E?=
 =?us-ascii?Q?MWCw9GJ8u+n9Ab/qPAOyFTStdKVMvdb/UFgoFOwijS6jhZpQOVOJws1ztzI3?=
 =?us-ascii?Q?uyjFi3DhP3cVs92jKCwDO89Gxv64HeOtVB5mHrayvRIxyTwM93iP8IzDDgBo?=
 =?us-ascii?Q?0xV8yEHf+C9QHw3U5OfcNSwKtfgZTVoYlo3z7Md9mSQ4tgEFTDuXOFemPHGs?=
 =?us-ascii?Q?XLF3LWk2uT9XiQn0iNbjT1/Gfkz0Z1VUDnmf8/VHHQdeDSIOUUdF7w9W0U/w?=
 =?us-ascii?Q?HlV9hH22d7nXhCZ0PmrzFxVHrdIOclz+GVd3QdKbJS3soivmXU1c+1/NnONZ?=
 =?us-ascii?Q?CQu5x2Ogl8wrLP+Pop9VCLyRufHuIQeIOuEEeQ6wAjnJj2m8cD6N6zx23w4r?=
 =?us-ascii?Q?dmOjX4qqSkjW9cEkXLfyM2ExuKExH92dXBinRwsn5a1cugZ7EOWUxYOOlwzT?=
 =?us-ascii?Q?g7NZUKbhftfbkobNP0rGV1KGgphAlfhZfRVmAv/uzkHfw5kbdLTHDjpr+eVW?=
 =?us-ascii?Q?gIiSpga61/xGx7cYqfgmzYdetpfl+RKVK27/t6aSorMtjWzq0UYxftJJ9AAW?=
 =?us-ascii?Q?WNOa+MCV4BXnMR0t5wpUpkak/TRa+kzU5psS5fA2ZyKvnEHyqRAubR2Gwm/m?=
 =?us-ascii?Q?BSs+flgxDM8LVXnD8RsYgqy2K0GXpfw7euqI/JPebcUsl7EHWlzaTChJSuxE?=
 =?us-ascii?Q?ZIvESbpR54ZdOHEj42wgciU5OPDjhMW7d/FYamWqLkxyhy68ml/k4BJcQxxY?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db17b700-eb63-4fb4-c0fc-08dd0561ad93
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:38:44.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJw18SHWkWHW+BrO8hj+HoInh1GLcEdh/ebJNT8HaSo79IsuY2FS2BKkWl+ZipXyQvS+1zHd9blmv29o7aYYOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

This updates the Scan Delegator implementation to be handled internally in
BASS: The BASS Server is responsible to handle Write Commands for the Add
Source operation by creating long-lived PA sync, parsing the BASE,
creating and configuring BAP streams, as well as enabling them.
---
 profiles/audio/bap.c  |  18 ++-
 profiles/audio/bass.c | 264 ++++++++++++++++++++++++++++++++++++------
 profiles/audio/bass.h |   4 +-
 3 files changed, 237 insertions(+), 49 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8635c383d..6e6d68b57 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1125,14 +1125,6 @@ static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
 
 	bass_add_stream(data->device, meta, caps, qos, sgrp, bis);
 
-	if (!bass_check_bis(data->device, bis))
-		/* If this Broadcast Sink is acting as a Scan
-		 * Delegator, only attempt to create streams
-		 * for the BISes required by the peer Broadcast
-		 * Assistant.
-		 */
-		return;
-
 	/* Check if this BIS matches any local PAC */
 	bt_bap_verify_bis(data->bap, bis,
 			caps, &lpac);
@@ -1325,9 +1317,6 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 		g_io_channel_shutdown(io, TRUE, NULL);
 	}
 
-	/* Notify the BASS plugin about the session. */
-	bass_bcast_probe(data->device, data->bap);
-
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
@@ -2729,6 +2718,8 @@ static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 		return;
 
 	setup = bap_find_setup_by_stream(data, stream);
+	if (!setup)
+		return;
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_IDLE:
@@ -3276,6 +3267,7 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct bap_bcast_pa_req *req;
 	uint8_t type = BAP_PA_LONG_REQ;
 	struct bap_data *data;
+	int ret = 0;
 
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
 		error("BAP requires ISO Socket which is not enabled");
@@ -3329,6 +3321,10 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
+	if (bass_bcast_probe(service, &ret))
+		/* Return if probed device was handled inside BASS. */
+		return ret;
+
 	/* Start the PA timer if it hasn't been started yet */
 	if (data->adapter->pa_timer_id == 0)
 		data->adapter->pa_timer_id = g_timeout_add_seconds(
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 6237f5acc..e53241a1a 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -29,6 +29,7 @@
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "src/dbus-common.h"
 #include "src/shared/util.h"
@@ -42,6 +43,7 @@
 #include "src/shared/bap.h"
 #include "src/shared/ad.h"
 
+#include "btio/btio.h"
 #include "src/plugin.h"
 #include "src/gatt-database.h"
 #include "src/device.h"
@@ -101,12 +103,16 @@ struct bass_assistant {
 
 struct bass_delegator {
 	struct btd_device *device;	/* Broadcast source device */
+	struct btd_service *service;
 	struct bt_bcast_src *src;
 	struct bt_bap *bap;
 	unsigned int state_id;
 	uint8_t *bcode;
 	unsigned int timeout;
 	struct queue *bcode_reqs;
+	struct queue *streams;
+	unsigned int io_id;
+	GIOChannel *io;
 };
 
 struct bass_bcode_req {
@@ -218,18 +224,58 @@ static bool delegator_match_device(const void *data, const void *match_data)
 	return dg->device == device;
 }
 
-bool bass_check_bis(struct btd_device *device, uint8_t bis)
+static int stream_get_bis(struct bt_bap_stream *stream)
 {
-	struct bass_delegator *dg;
+	char *path = bt_bap_stream_get_user_data(stream);
+	const char *strbis;
+	int bis;
 
-	dg = queue_find(delegators, delegator_match_device, device);
-	if (!dg)
-		return true;
+	strbis = strstr(path, "/bis");
+	if (!strbis)
+		return 0;
 
-	if (!bt_bass_check_bis(dg->src, bis))
-		return false;
+	if (sscanf(strbis, "/bis%d", &bis) < 0)
+		return 0;
 
-	return true;
+	return bis;
+}
+
+static void append_stream(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct sockaddr_iso_bc *addr = user_data;
+	uint8_t bis = stream_get_bis(stream);
+
+	DBG("%d", bis);
+
+	addr->bc_bis[addr->bc_num_bis] = bis;
+	addr->bc_num_bis++;
+}
+
+static bool link_io_unset(const void *data, const void *match_data)
+{
+	struct bt_bap_stream *link = (struct bt_bap_stream *)data;
+
+	return !bt_bap_stream_get_io(link);
+}
+
+static void connect_cb(GIOChannel *io, GError *err, void *user_data)
+{
+	struct bt_bap_stream *stream = user_data;
+	struct queue *links = bt_bap_stream_io_get_links(stream);
+	int fd;
+
+	DBG("");
+
+	/* Set fds for the stream and all its links. */
+	if (bt_bap_stream_get_io(stream))
+		stream = queue_find(links, link_io_unset, NULL);
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	if (bt_bap_stream_set_io(stream, fd)) {
+		g_io_channel_set_close_on_unref(io, FALSE);
+	}
 }
 
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
@@ -237,31 +283,54 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 {
 	struct bass_delegator *dg = user_data;
 	int bis;
-	char *path = bt_bap_stream_get_user_data(stream);
 	struct bt_bap *bap = bt_bap_stream_get_session(stream);
-	const char *strbis;
-	int err;
+	struct sockaddr_iso_bc iso_bc_addr = {0};
+	struct queue *links;
+	GError *gerr = NULL;
+	struct bt_bap_qos *bap_qos = bt_bap_stream_get_qos(stream);
+	struct bt_iso_qos qos;
 
 	if (dg->bap != bap)
 		return;
 
-	strbis = strstr(path, "/bis");
-	if (strbis == NULL) {
-		DBG("bis index cannot be found");
-		return;
-	}
-
-	err = sscanf(strbis, "/bis%d", &bis);
-	if (err < 0) {
-		DBG("sscanf error");
-		return;
-	}
+	bis = stream_get_bis(stream);
 
 	DBG("stream %p: %s(%u) -> %s(%u)", stream,
 			bt_bap_stream_statestr(old_state), old_state,
 			bt_bap_stream_statestr(new_state), new_state);
 
 	switch (new_state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		iso_bc_addr.bc_bdaddr_type =
+				btd_device_get_bdaddr_type(dg->device);
+		memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(dg->device),
+				sizeof(bdaddr_t));
+
+		append_stream(stream, &iso_bc_addr);
+
+		links = bt_bap_stream_io_get_links(stream);
+
+		queue_foreach(links, append_stream, &iso_bc_addr);
+
+		bap_qos_to_iso_qos(bap_qos, &qos);
+
+		if (!bt_io_set(dg->io, &gerr,
+				BT_IO_OPT_QOS, &qos,
+				BT_IO_OPT_INVALID)) {
+			error("bt_io_set: %s", gerr->message);
+			g_error_free(gerr);
+			break;
+		}
+
+		if (!bt_io_bcast_accept(dg->io,
+				connect_cb, stream, NULL, &gerr,
+				BT_IO_OPT_ISO_BC_NUM_BIS,
+				iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+				iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+			error("bt_io_bcast_accept: %s", gerr->message);
+			g_error_free(gerr);
+		}
+		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
 		/* BAP stream was started. Mark BIS index as synced inside the
 		 * Broadcast Receive State characteristic and notify peers about
@@ -280,17 +349,79 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
-bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
+static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
+	struct iovec *meta, struct bt_iso_qos *qos, void *user_data)
 {
-	struct bass_delegator *dg;
+	struct bass_delegator *dg = user_data;
+	struct bt_bap_pac *lpac;
+	char *path;
+	struct bt_bap_stream *stream;
+	struct bt_bap_qos bap_qos = {0};
 
-	dg = queue_find(delegators, delegator_match_device, device);
-	if (!dg)
-		return false;
+	/* Only handle streams required by the Brodcast Assistant. */
+	if (!bt_bass_check_bis(dg->src, bis))
+		return;
 
-	DBG("%p", dg);
+	/* Check if this stream caps match any local PAC */
+	bt_bap_verify_bis(dg->bap, bis, caps, &lpac);
+	if (!lpac)
+		return;
+
+	if (asprintf(&path, "%s/bis%d", device_get_path(dg->device), bis) < 0)
+		return;
+
+	bap_iso_qos_to_bap_qos(qos, &bap_qos);
+
+	stream = bt_bap_stream_new(dg->bap, lpac, NULL, &bap_qos, caps);
+	if (!stream)
+		return;
+
+	queue_push_tail(dg->streams, stream);
+
+	bt_bap_stream_set_user_data(stream, path);
+	bt_bap_stream_config(stream, &bap_qos,
+			caps, NULL, NULL);
+	bt_bap_stream_metadata(stream, meta,
+			NULL, NULL);
+}
+
+static gboolean big_info_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct bass_delegator *dg = user_data;
+	GError *err = NULL;
+	struct bt_iso_base base;
+	struct bt_iso_qos qos;
+
+	dg->io_id = 0;
+
+	bt_io_get(io, &err,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		return FALSE;
+	}
+
+	parse_base(&base, &qos, bass_debug, bis_handler, dg);
+
+	return FALSE;
+}
+
+static void confirm_cb(GIOChannel *io, void *user_data)
+{
+	struct bass_delegator *dg = user_data;
+
+	DBG("");
 
-	dg->bap = bap;
+	/* Close the listen io */
+	g_io_channel_shutdown(dg->io, TRUE, NULL);
+	g_io_channel_unref(dg->io);
+
+	g_io_channel_ref(io);
+	dg->io = io;
 
 	/* Update Broadcast Receive State characteristic value and notify
 	 * peers.
@@ -298,15 +429,64 @@ bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
 	if (bt_bass_set_pa_sync(dg->src, BT_BASS_SYNCHRONIZED_TO_PA))
 		DBG("Failed to update Broadcast Receive State characteristic");
 
-	/* Register BAP stream state changed callback, to keep up to
-	 * date with BIG/PA sync state.
-	 */
-	dg->state_id = bt_bap_state_register(bap, bap_state_changed,
+	/* Register BAP stream state changed callback. */
+	dg->state_id = bt_bap_state_register(dg->bap, bap_state_changed,
 			NULL, dg, NULL);
 
+	dg->io_id = g_io_add_watch(io, G_IO_OUT, big_info_cb, dg);
+}
+
+bool bass_bcast_probe(struct btd_service *service, int *ret)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct bass_delegator *dg;
+	GError *err = NULL;
+
+	dg = queue_find(delegators, delegator_match_device, device);
+	if (!dg)
+		/* Only probe devices added via Broadcast Assistants */
+		return false;
+
+	if (dg->service) {
+		/* Service has already been probed */
+		*ret = -EINVAL;
+		return true;
+	}
+
+	dg->service = service;
+	dg->bap = bap_get_session(device);
+
+	dg->io = bt_io_listen(NULL, confirm_cb, dg,
+		NULL, &err,
+		BT_IO_OPT_SOURCE_BDADDR,
+		btd_adapter_get_address(adapter),
+		BT_IO_OPT_SOURCE_TYPE,
+		btd_adapter_get_address_type(adapter),
+		BT_IO_OPT_DEST_BDADDR,
+		device_get_address(device),
+		BT_IO_OPT_DEST_TYPE,
+		btd_device_get_bdaddr_type(device),
+		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_INVALID);
+	if (!dg->io) {
+		error("%s", err->message);
+		*ret = -err->code;
+		g_error_free(err);
+	}
+
 	return true;
 }
 
+static void stream_clear(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bass_delegator *dg = user_data;
+
+	bt_bass_clear_bis_sync(dg->src, stream_get_bis(stream));
+}
+
 bool bass_bcast_remove(struct btd_device *device)
 {
 	struct bass_delegator *dg;
@@ -317,6 +497,17 @@ bool bass_bcast_remove(struct btd_device *device)
 
 	DBG("%p", dg);
 
+	if (dg->io_id)
+		g_source_remove(dg->io_id);
+
+	if (dg->io) {
+		g_io_channel_shutdown(dg->io, TRUE, NULL);
+		g_io_channel_unref(dg->io);
+	}
+
+	queue_foreach(dg->streams, stream_clear, dg);
+	queue_destroy(dg->streams, NULL);
+
 	/* Update Broadcast Receive State characteristic value and notify
 	 * peers.
 	 */
@@ -895,6 +1086,7 @@ probe:
 	dg->device = device;
 	dg->src = bcast_src;
 	dg->bcode_reqs = queue_new();
+	dg->streams = queue_new();
 
 	if (!delegators)
 		delegators = queue_new();
@@ -903,8 +1095,10 @@ probe:
 
 	DBG("delegator %p", dg);
 
-	/* Probe device with BAP. */
-	bap_scan_delegator_probe(device);
+	/* Add Broadcast Audio Announcement Service UUID
+	 * to device and probe service.
+	 */
+	btd_device_add_uuid(device, BCAAS_UUID_STR);
 
 	return 0;
 }
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 257346374..f299ac029 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -12,11 +12,9 @@ void bass_add_stream(struct btd_device *device, struct iovec *meta,
 			uint8_t sgrp, uint8_t bis);
 void bass_remove_stream(struct btd_device *device);
 
-bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap);
+bool bass_bcast_probe(struct btd_service *service, int *ret);
 bool bass_bcast_remove(struct btd_device *device);
 
-bool bass_check_bis(struct btd_device *device, uint8_t bis);
-
 typedef void (*bt_bass_bcode_func_t)(void *user_data, int err);
 
 void bass_req_bcode(struct bt_bap_stream *stream,
-- 
2.43.0

