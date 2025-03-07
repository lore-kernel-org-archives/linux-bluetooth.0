Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C714121D008
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362326; cv=fail; b=ts4dF38NCvWI8CFvx7WdcFISbf6LKgVoLqjEriJnxf6ug6Xy8EHvD0uWy3d2UemQawMy500sJzO8yTNH4kwrmnPaxsGRgUIyYJ3BiGOVXMiG1fX+bwU0MA32N7lQOm3cv9AJsXfBv78yY9W5pOYPXeqf5vFd3ICy1UDoLwAhIgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362326; c=relaxed/simple;
	bh=j9YJDX7hfGxfzwydgZjC7TKkh23hFPa82LeJ3BB9ybc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDVt3tXpYhTnzRTSpEwKziLxr9JO0pKGdSm/pKLbRfYG2SuHG/Sqdqr5xCbMvwxQBhNbJzvk/lTV6cMd60J7JcFxRJfVbxybnlFR0VvJYjKGLKHFlGdN7D0WDp6Sy+5nBstoo4mBs4fLPWymPvqgLGThiMgxVtRCu0GR+h4EaII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vn/PWBIp; arc=fail smtp.client-ip=40.107.103.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vn/PWBIp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3aXXH3kfRu7y9TeQ2Ho4eMZOR/M8nNXwfT4QM6o3PdPs1/n4AyC3KyxE6z+/Fysg8hNtlquspjFLQAZiao/DD69Trr68LjOCBRh81TlP5Q/8bjS/qUcqL8t2P9F7DzRsV1MUzswnVt+DMiNKm/Qf0YWiRfCuAL2miek5TWmWig/B8NuVUMOySO/kpRzRbA93FvuDnz0tfQ4/SDgDljXc6IUspwU73UT4EhppSsgnZuCVzzRXK5bIrkkv9HLptmTpT9oJyL38+DTRfNGyg2qMyH2lIEB+hUhY+OLUri7qc3u2dEuUFLFgddrPzKAdZU3AhpOoY7NkDqhJH7bUF/oIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n38O1BSfYK40c5UF3/4WtPYdpFlyEpnMHAGtIhHQ3ws=;
 b=dk74otCI2/NkQr4Ke5F4OEcLFs3fOxHCuIHuMqcsSbvl5dt5WkuRdxXLx9AxUAso2nhuyjb6K9EVuSHyGEu6Bh3jwdJF61/ZsBjMmmov6Kui+HFxPlXtMl7IqMeDrxTZgzDJq80KiS2V8ScynOvBK6Y7AoZfs55oXWbI1XW82zmmwp6B24kb39JcTu7dMu03fK967hBo1UWxFHTvELC7I0ENzD+UXBs20Qoil5lbzB1NJzrUrWCYnhfgoiF+OF4HDtFBncO8C/tpK3deq/gV2cL2W6vGDTWaal4EqbrQR3+U9CqsYnDxGdZpksndxj0XxeNSdsHwPheYjBCuRl57rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n38O1BSfYK40c5UF3/4WtPYdpFlyEpnMHAGtIhHQ3ws=;
 b=Vn/PWBIphv8r58FToGJr0aSVR5xUOs9NMdk+vQF5LspgtONCYKaNjSxtMH44p/oP6AH31TSRGAWhjub2XozOIFNfMo6vogyhpX/YfT5tCbZO7B5TdtePhq5ALX39HgFfHnq7eVZowx2HTVVYHe6rezTX8Z0YlhfQONIeOA582R4SfdPsxi9O/h6z12yYmGcCkddX1LAmTX7AnpvWWfaHFmOZCz7QQBfWh0mROPFXE2tcuikw7A4UvFjfeq9A8HxGME3GmIjxDK+Q3jOf+aBxYNWMhf7rJGMIK/kOusRm5Qv2WFbu0XIrhE6UzUuMPB0wYkAmicZi6bZlD2SRkdKYhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:45:19 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 15:45:19 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/6] shared/bap: Make bap_get_session public
Date: Fri,  7 Mar 2025 17:44:52 +0200
Message-ID: <20250307154457.85751-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
References: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ca616b-4244-43ba-944f-08dd5d8f102f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KeopAjU5Y8TswzcD5Ve1klMhAyiLYkT3V8bqGK6hxU0eZecEeP6iekoTb0+b?=
 =?us-ascii?Q?I90LgkebtIT4wNAGO84oGo5Oe/StF/pqKJ3fblLalgMJQaFCb9w5XshQSyxw?=
 =?us-ascii?Q?GJhlmSftuR0DbiUdCsVmL5oyvMVOvzX2SmR9qUWB+4TjET5xAXUZ5mh9gwec?=
 =?us-ascii?Q?j3t9mdzf4Xaa0S98r3M3I2grP4l4M/M+4dUpQDxpUN8hnBdFTInUHFqHyHG8?=
 =?us-ascii?Q?d/91WpdhtXvZP1wT6lEglKcfGbLTfNRosImPohdVV0asymH8r+Ig1ZfswO18?=
 =?us-ascii?Q?4hDM1Kb29YvcF6MJ6EQm3+wxVYTJ/R9kmefhosdgByHYVlnTae1Iy8+WqsCq?=
 =?us-ascii?Q?4j8T819JZJ67YCWqBsxkd0Ooxwx5HwRjkMCP8jtrPp6QbpRrf5146NfBhHFd?=
 =?us-ascii?Q?xEpBUrzvWgnYJeAF7CUI3cIJxGOhlTCJX2ULmp9hrgNkfbwRxan2Gh7TRI1d?=
 =?us-ascii?Q?+ha55KYVGleA68u0Y8Dm+SuKODuExU4d/lwENk/BmzVz8HiL0y9NMLtBXUXm?=
 =?us-ascii?Q?vsdd/UKjNfsvMjP1lluD5NRHyk+apapjN4ALto5hbT0AyWALFRoPiyBEU5Zi?=
 =?us-ascii?Q?rS2qfG0ifxwm66UKGSwfa7Ub3s2dy9LPyG/IAqCOn4E9gLjAg5eRW0/Sl1tD?=
 =?us-ascii?Q?/HCcGZ24zlFfmY2L5oCl31ms6tfwE0d5PMV1zewcM2upleM0hw90r9R2FhrI?=
 =?us-ascii?Q?XiHesfd5QvWI7KhKkF4YqdXjgNzCzjzS08f0xEtF8QUgJ2MmzuVzulkcyJtb?=
 =?us-ascii?Q?V+BtXCB4irAh41z+K03qcUl3BFOMugY9WQ2GIo82LvBQ5p3/pgRAGZghx4vM?=
 =?us-ascii?Q?KkC4nM2ZHa+/5HJJp/czHao5Z6QvIRLUp5ZfjgNFdtjjdGo5MVmMBjk5vo8u?=
 =?us-ascii?Q?VvkXv9vNk77R2gQ2Wylu6/peLWvUPIec2qVWL8y1CkACdpF28eDXD8yQ60mq?=
 =?us-ascii?Q?dOcmc5t20vKEbLst1SWuydmyT4QY1nJf3K33xGxA+tL8LueAO8yXcqFzr3es?=
 =?us-ascii?Q?slbf627CG0/+Te9KQYelIWWnqyZzGoaKGofAx01Dh3D9Tz9GVZiuOZ2OatHN?=
 =?us-ascii?Q?DlQauOJQ9Bp6pkbxcj6JukoUo/sO4Nix6eANOIwldeFokgPYdaxi6LlbobgS?=
 =?us-ascii?Q?fu/W9Ngn8s1+iXKRO2eOt1f9Wz3YbTTV6Fd12masRAW/kMj1cERXpWvPZYHY?=
 =?us-ascii?Q?yW8+rjw7I6nYmCjuBpKMacEP7Z4r0rbLuBc2vAAWBameJxoRmnNJritMYEVa?=
 =?us-ascii?Q?QV+pFiBpbRHA8L3z10fJVUbuxhc9z5O6LpOUBhNF1P2zsqSX9WwNPeCg9Sf9?=
 =?us-ascii?Q?fv5d7E5z4cjjOAJw73ErHQpHYxBBh1o7oF1V34ch+N6VcrqFnkJgFVXNxWv+?=
 =?us-ascii?Q?l+jxEWfYMHX+MWfTAFL8fu4dwQjs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qhCX+XYxWJyoOxPAsOVGy5rDA2ie+MI6M/F8Q9Bf+fgzFmxhpgvi3M3munS?=
 =?us-ascii?Q?UZ4pRyGM822yzV990qQjkrTA8CFYzSfv+h/kftwyAtq7PqX7KYuuedeD6/9t?=
 =?us-ascii?Q?oP4tUuyt6OEGGRN1ovneECjf4I7HPP3dfyn9uorKSWPt6hjeX7JfcdjBz4Qi?=
 =?us-ascii?Q?BvbYgT1mtKzIBIPRHtB96LZ2+4qFSEuGFV0XMgCpGTFv4C1bITZVYaBF1hqL?=
 =?us-ascii?Q?qYdkIgNsZjPcqFMtMPPugKlSPPBIdvq+rwTu1PrxnTRQchBRuCUfgAVNDk8J?=
 =?us-ascii?Q?9xYPpovACgWWZ9MgLTTKpbxzpG/9zxSFPIOQ0kQI3YTmVpdJLuB2iqUu/VuF?=
 =?us-ascii?Q?pmcQSreWPF1wNaRcyIAeaUwV1m9kCkIwueVJB0J9YwIKypFyoSp+ChduIhS2?=
 =?us-ascii?Q?yHvdXQJFzCEsn89lr2QfWTgwpksun7hX+R/xV4PkPDkXBzgN9936s05EoLT2?=
 =?us-ascii?Q?iJae+OafTWHrODwkHtzc7lfkyRtbe0pHB3TeAtG/dYuruigRVq3Aa4+4dRDL?=
 =?us-ascii?Q?HK1VEbGmVQoWVhku7ekl8UVKMs9724zAN70BgbO9wwlW8f+U8eHyDyD7/vki?=
 =?us-ascii?Q?CYwpKhppLFrBsNQN5Y1huGPnDTXoCPa1dCec3U5PQPgguQs5HP9DKHWgyE85?=
 =?us-ascii?Q?4HRI69Cs4DzlZ+IVamPiGDthwek3wEhVufS69pl6QST2Q4AK3LIHiLT7hlZ3?=
 =?us-ascii?Q?Kq9Rnh6l0h6B/um2KCQuUk7NKtFOz/EYpjh5tnFPr7GqAQVh5f4tHJZ618+W?=
 =?us-ascii?Q?MAc0Rl3xFu+DsxV1HfTHrMxY1W4rNLWRK0qaopjGIDmjgpGTSSlMCN5QKXuy?=
 =?us-ascii?Q?t1Q7jxvKXwDazTggWpTpOdSKsH/KQ+bEjuboZRMUiweLnHuUstHVbR/kjWnj?=
 =?us-ascii?Q?vfkvKkI5YpH9PqqbjYwZjW2M+5tUDTtBM/ylFMh7J+a4P37m6IrHjihVfuQp?=
 =?us-ascii?Q?YHBO+2qudme+hRwFBUwWt+80bHrpvfcMuJYYNO3ob5L9HSZK3KdqtyqmZyKM?=
 =?us-ascii?Q?ifOCatOvi8pAbsICfBY2tV+q20FKAxlBCkcBGSUBb7ElVm1J1uIj3HikXYfN?=
 =?us-ascii?Q?VYcpA+M5H1eFkwhDfXQ1DRnsFvVd8fqlvnk9NlqJejq9Cs1wBzez0VGQY8Ow?=
 =?us-ascii?Q?TFThTDJ4gAxJ+bA5hemwf2T4PorxTl+SPWAjIVPGe/WDUQatWOKv84Qll9GF?=
 =?us-ascii?Q?OdQsfyzAvREZ69jaWAP5DSOymIeB0TSqAzzj24P3yDkBf7A8JR63JjlcZBiJ?=
 =?us-ascii?Q?CKwYxMpr1tQb+HA0wn4H61TiBGC/ZSxl6qE3oqD+pgBPomd3c8lL1g+gY3hM?=
 =?us-ascii?Q?dKlOrxEcZGVtKmTpU7/vn6iU/qNRjcJWdDlUAGuo+s0C3bf+rwqraNksND7C?=
 =?us-ascii?Q?iYDiPrAo6PpPsXqOzuVWY8cii+KEVSMEj749jfdh9ic107ugP4vNWU07j6I/?=
 =?us-ascii?Q?ma0fci3BeBTt2pLmex7rMFlRkrvHb3h79waOVtaoRSu2nmwk3ie+mq5IHKPL?=
 =?us-ascii?Q?pudBiV1ooJ4OPjlFdpX7h798xyPC1hYKv1GunXtkIW7z/BTOFOzGdR3pCgn2?=
 =?us-ascii?Q?+5RIMfc7OQLHW+H/Up0kZBHwRcwlzAndZCk9+0iDWaM69qs/EvPcDTFkYdK6?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ca616b-4244-43ba-944f-08dd5d8f102f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:45:19.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMXffuW6boPeAf+u9elKqzkmmEW1bSyqUy+Rs25jjKYj1VHnvSKxe77TJAE9ZmbXgSHo/pCP+qFoZa+lCqnJnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

This makes bap_get_session public, so that a reference to the bap session
can be obtained and processed from the BASS plugin, for the Broadcast
Assistant implementation.

In case a session is not found, this commit also adds a NULL check for
the new bap that is created, in case the provided db reference is NULL
and therefore a session fails to be added, to avoid any invalid memory
access.
---
 src/shared/bap.c | 9 ++++++---
 src/shared/bap.h | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 4dce32efc..63c4c05c7 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -662,7 +662,7 @@ static void bap_disconnected(int err, void *user_data)
 	bt_bap_detach(bap);
 }
 
-static struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db)
+struct bt_bap *bt_bap_get_session(struct bt_att *att, struct gatt_db *db)
 {
 	const struct queue_entry *entry;
 	struct bt_bap *bap;
@@ -675,6 +675,9 @@ static struct bt_bap *bap_get_session(struct bt_att *att, struct gatt_db *db)
 	}
 
 	bap = bt_bap_new(db, NULL);
+	if (!bap)
+		return NULL;
+
 	bap->att = att;
 
 	bt_bap_attach(bap, NULL);
@@ -845,7 +848,7 @@ static void ascs_ase_read(struct gatt_db_attribute *attrib,
 	struct bt_ascs_ase_status rsp;
 
 	if (ase)
-		bap = bap_get_session(att, ase->ascs->bdb->db);
+		bap = bt_bap_get_session(att, ase->ascs->bdb->db);
 
 	if (bap)
 		ep = bap_get_endpoint(bap->local_eps, bap->ldb, attrib);
@@ -3437,7 +3440,7 @@ static void ascs_ase_cp_write(struct gatt_db_attribute *attrib,
 				void *user_data)
 {
 	struct bt_ascs *ascs = user_data;
-	struct bt_bap *bap = bap_get_session(att, ascs->bdb->db);
+	struct bt_bap *bap = bt_bap_get_session(att, ascs->bdb->db);
 	struct iovec iov = {
 		.iov_base = (void *) value,
 		.iov_len = len,
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 359147b69..198ae50c5 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -296,3 +296,5 @@ unsigned int bt_bap_bcode_cb_register(struct bt_bap *bap,
 				bt_bap_destroy_func_t destroy);
 
 bool bt_bap_bcode_cb_unregister(struct bt_bap *bap, unsigned int id);
+
+struct bt_bap *bt_bap_get_session(struct bt_att *att, struct gatt_db *db);
-- 
2.43.0

