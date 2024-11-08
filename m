Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85537EF09
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082058; cv=fail; b=C6uuziLT0B0SiFKwDEMvrIdAcG/sT26XW8vmmQFBdHGKWEy9GZKTObN8zo/ui6N/zxl1Y1gVn/U29uWJgVOyfYU860wdeFqnbKwslVMJpjYCXGNfGZQSCkyzHj+5kCNe9LbHlK0AlTVKlhbiVtlF0y/0gJ0GK7G9v5Yb0l/zHzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082058; c=relaxed/simple;
	bh=zQRZHl+RtcEZ/mWoXWOVPcsX3xFfzNZf3BnqQ9P0gY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JvOod4AHCA5vak4+BRmYvFwuU8NKFs9tL5rbjQC3WXpZH36HMci0CM/TSAaDOYeAiDB72h9g1zIxLl99kBNaNpicOmCKhFdY9+m2yambPTz3UBM9iqj3th9klCYmMobBmX2PxRmU4RaiI6/6iiWI0rZHz9bb/U+W6XhhYCp114Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gu1r7GeR; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gu1r7GeR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXyT2JDJGPWJEWy0Vuv6X9BhOjqkLMLR6ie3S8Vk7qW9NTu3akRyv+PweJk39/wtWWYvnlbO/Vcs8mmk+ZXNq2hC65wQvdsvQFJN5FO44XJvaTkT0WTWIWwsxlLkFIzVVgnvGMKsoOiuCY7QfaBQDBu4/qapoXAPBi78xyKsJBhA83lj63lMfG+bwvDOiQYpFOjGzemQGkDRiDjDGyJ8y6QczegcOGWwmqfxubRs2/h2vZVsuQ3ROTbKGcfRSsfsC8IGxme9KsecuEYqPTNnjR9TBANOSbQG90xllLBVvuukoW7NrElWZOjiaUV939dy70hvbV/YON8s3Dsvcs7URw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkuVf6uELHaIs/Edv8jGRVvRioIzLj2z+exUYC01o2g=;
 b=yNJ26lybZUnl6jGADQqmEIYwyZUB8xyyZ9pTPpOGu5Do4LIqjwc/eyQAcm288QlCnHKQthX+ziIGyEUS5cW3iK49iRfRQi4cCZh7rMvFaSlDItSotNVwMIsjSxDUvG2+CzZ+kBgU7e0i/Sit9sVuH5Mh7Xmiyv0FL/TLWRaipdSjj9VhPeJPa/gBCfAMS/ehKSSCHA7vBs5NwYLVrqFr0U+tQ0jTnXiz0zERlAJnZPmTcpiXXJbK8FfmN//p6BdBUJAMW7btaC40RHNDxGXeOaE9e/Zi3pE28UDh75xmZIWC66kVMc6gD0NiikktmLYpNnVlfm2L22+Axj6G+YmZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkuVf6uELHaIs/Edv8jGRVvRioIzLj2z+exUYC01o2g=;
 b=gu1r7GeR8gvvOg6GLT1AQ+6fEYmI6rXqdyJYD8wgyNRyOX0H16E8IfNxNyD5Eb1sh91f4wTm2/aU0D/2TqlwyJ8eh/05nXSKRs4oOGjdXL0LJV4jSZsh4nszHB4hEZ7W9dmzZKttYCmsrUrky8mrB55hQxPwHm6z1z0hr0ea8qA8xnVlJtGizEOY5/gh+eE2PRo6Ih5DNInRUnPHFu31h2QARgyAOddZLjLBIWW8dSN2PDplDIsPeySM6+NTXKi+sSMyhmCUbpD1o6DEH5xYYbE91SdClknr8GJhWTvf4tOQyzdTweqIWeK9qe18XiQtwvUAcUMvAZaMg52KE1cj5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB6829.eurprd04.prod.outlook.com (2603:10a6:803:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 16:07:33 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 16:07:33 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/2] Bluetooth: hci_conn: Remove alloc from critical section
Date: Fri,  8 Nov 2024 18:07:21 +0200
Message-ID: <20241108160723.3399-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108160723.3399-1-iulia.tanasescu@nxp.com>
References: <20241108160723.3399-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0074.eurprd04.prod.outlook.com
 (2603:10a6:802:2::45) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f61e465-2651-4344-0434-08dd000f7497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B0Y+LCRP0LQE1OfI03G2f8H8EklC43PtICfgKv1s896KVyv4494/k8cPGFiN?=
 =?us-ascii?Q?yrdFcQ5kFZ7NUyA3sGPB34A5nTkcJfK/04XzWhRWdXkkG0NKVo6eAdwj+SNX?=
 =?us-ascii?Q?Oag+fdYbZ3qcNezetM0+h+2lbhLqfXDI1f/JCDC9wqWgNnc5DO5pYT1KLiDY?=
 =?us-ascii?Q?BqOINP04BucOGwyFuKGxz9BFDfB63wIrVC2+dbyusSmH0cBoUDFybUqyVdZs?=
 =?us-ascii?Q?5e6f9GcLaejIYTdq3L/vWsd1Mg5iv5PsVRPB+GAJJ6cLGJ4o99slejpznG4V?=
 =?us-ascii?Q?HhPudeVacrBdbDT+Kvbs+ag2Sx+ZXZ6JSkIPMm5uDhAk+4VCffN07JGvs/LP?=
 =?us-ascii?Q?Lh5rT1uoJp+Xf58WMCfO44J6OQFF7SwSX3ufVe+y3mQme7zEau1vW9Zr91ao?=
 =?us-ascii?Q?mw4DbGHGI4hguc446+AyQOpDpuIIjziKovgFNBpg3BfW7Z4YE1M5jhV7pU1A?=
 =?us-ascii?Q?5f2DQV0OPPJfNpFcEXQVw3CtPL8uP3ST9J0vvPUfisoJmT4EAya+IaYFQxt9?=
 =?us-ascii?Q?DexL3v1yBPTpIDBfgp0xXRMp8kVpsJ837hJ5JlglOkQH3lD76VDd59l6YUBO?=
 =?us-ascii?Q?9vmzfS9rRjkEkgNYwfCk1/5ATpdOTiqkViVzPojfIuTQapVt5e7r41dpovDK?=
 =?us-ascii?Q?eyne16XJCSf4divqk5xq31LUbGt75GH5rLS5MEy+qu/Cu4VPPLYaTQB9tuXs?=
 =?us-ascii?Q?hR15okZR9fJtyscvBGJ8bF+VNpZXIQFF6LbntPLe1XC4WL839fxP7/QsHHXI?=
 =?us-ascii?Q?JI/QmBLTHn+ar2QqYWzThuOqW7bbE/yxhLMU8MjuK8/iq9GTDabOc2de3r98?=
 =?us-ascii?Q?0dZxtCTy9Vk76/x3fA/rIvEfMonJxk0Xl1qS+q0NaYL07ts25Oej5gmXFDYL?=
 =?us-ascii?Q?3vg9LX5g531gPgyqcA7WWqB6rOzDZSt/o+C3yPhVJGP6NnP8/2TDqddFrZdy?=
 =?us-ascii?Q?+ylDHu2CUyue5i5b9G16JwEpUX2b0Mh/4iIHKtiPAoS50LZhoLRCFuuAvKti?=
 =?us-ascii?Q?TUsub1JWOxPOAZsJIU3Glyo6p4Qu/vC2vNEIN1PoaPaXV28jiR3rEtxL+y0q?=
 =?us-ascii?Q?jmzzaXcHjurWwU6uYSRmXmG0+Lehy2aUPYIs3erC0nbk+eN8W7jvbHIcf6mS?=
 =?us-ascii?Q?HYLKQz6oUUU71RI5oT4HASmduk9OalipYQ0azSfDZQjHPaza6YbSKxN8ANVb?=
 =?us-ascii?Q?aL1ahtsskdYbDOZ1TplWRJt+3J/l7C21eOGdE/JDJNtsRIxIvlXlk/9XselI?=
 =?us-ascii?Q?Zl9qRqF+iW3xfWgA5uPqM86Vv/tKztxFzz6QRUNWexZuYBqFdYKS6mAeXJy/?=
 =?us-ascii?Q?l8eVoy7oaZpU4LobwQxlVQhk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o/e8M+EnYCRhp+H4kCQZ6x6II2nEUIvWMq456szi5lkJIziFufpXHkDqBa/e?=
 =?us-ascii?Q?oPhs29uNJTuQCESSYSFuo/UQjbBhIpJ7aHMm+AKMqErAJWaJZ42xkisoG1ym?=
 =?us-ascii?Q?indTM99GOQ1aqp4v5QBmuyCZ+hDtnAewL2oYYYNLAui0ypXnya4zyZDp8yxK?=
 =?us-ascii?Q?QC+rf9p6JDfffaXV55Q4Z2J3eHuh0thprwJhPLP2UBiRCGrVii/vo261zJGC?=
 =?us-ascii?Q?KiS5sjzWMTC0Db5uNFksaN9PU1C+qwnS2E3mmSy//IGbqNuf3weztrtHrj/E?=
 =?us-ascii?Q?rQDUUduuR+nHfJLQKo0Dy4rph7u7t2iBRTehs+ZpfVzbs4w0KCDfDXTveW5N?=
 =?us-ascii?Q?vu4AG1/OaEy+0Y7sPpfHb85yknhJQI0AcRtHZcSaW/zWK3jcAkP38cvrCSX3?=
 =?us-ascii?Q?oxIgnM/X4iT6ZUf0ta9rYR9OM0PJGH+qLQhNfbzUhuxynMSsxqgDkh66X0dm?=
 =?us-ascii?Q?QnnpFetPe1bflnuFeDO3A31jor+EYAxOzsGVW9q5FVEoyKMg0EXVVVu86d+b?=
 =?us-ascii?Q?ziCGaOyXJmqDSmiUJZtA+3RVmfVbUhxMTAtrexTuIYVBiFEZeaPouRUW2ff1?=
 =?us-ascii?Q?DqsIN5i30brpnjHQjennlJZn/KAdID1/fdVYiy24QH7a77SeMfq7SZIedcaR?=
 =?us-ascii?Q?PkzOlqNVZYkAHUX/X0fQWFT0nbv5h2gNGgpJ/J2oHaF5wdLJMrIofy3om3AN?=
 =?us-ascii?Q?ulp2DzIiqL8iAR7OzzUDK8bLaiPlZg1gaQ6XSy8mJR88BxPg2vu7yul6opVz?=
 =?us-ascii?Q?aSLsiGpkJo47d7QWzFlSEMVQgVJSaJEF5YBV9iDCGTxGYJYkwKjA4s12M0dS?=
 =?us-ascii?Q?8xnWC0Gf0p6YNE/Sn+z9svQf+iEdlgME2W3LiQlH32B7iqnbc9EAGzAhgBXs?=
 =?us-ascii?Q?GyPJxC5M8PzlfI1PCC6nhONiZ00jbP6Pa3SyMqiAnM0TTC5A6P5ZVQ+S+sra?=
 =?us-ascii?Q?nfJYDoCScTTW4NKqjbt42SAQf1AMO6he9+mCVmZusWXqn/r4MIbQsTOfYF61?=
 =?us-ascii?Q?ilRsaFxcrNe+cr8DchOx/t+48SWKSIYDHtAEgnANm5CaDac5Wfd/xv+glKZj?=
 =?us-ascii?Q?RB9Nxdy+3EOdFYuqg/eVKpQ0JthfKsiUqczKw4/0J9u80EqPHq6tTADee1Qi?=
 =?us-ascii?Q?p0w8Vy5FRNuUTPAxsgiL4RgSmQiDy/frQ9Q3jc6EWwU+gK9BU0dfwikie29n?=
 =?us-ascii?Q?1d4hmjw7xPOPEV5nPn52X+hCWR/V2IhkNbVVbI6lZS1oqj8Ds54W8Gc5CBCc?=
 =?us-ascii?Q?ptODV3UMTDCVVm7wS7nQy7OQrVe/J9u5VnlnhEYBvEnaOo7c2uEzAPv+867n?=
 =?us-ascii?Q?ZbfgXv33yBIu7OY0jrI55bt/JY5g5TiRXY7gPGbiN9g0gWKJYUTFHccxrh1P?=
 =?us-ascii?Q?vJ3OWd8JMydxAxfW8yPEKOods7u0Y8whdsHvHzNBQYWZaYvJosUIVdC11Y5b?=
 =?us-ascii?Q?KGAu6Qmh3Zf1mnLF1cm3lnjcP8jGo6tniKmiIZKxmI0ONYIoH+Z39AjiBRd8?=
 =?us-ascii?Q?kv16m3l6YzMUQ2lRn7vxuIzdmaD8SzdTg/8/rwqbnlwjj6fNMCe6LHkFWjkp?=
 =?us-ascii?Q?xiO0B6Lb/27aOkcS6NdGqmgZzIVGbskOdCUvCKMhewoVdjJbTsEuw8K6lcmx?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f61e465-2651-4344-0434-08dd000f7497
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 16:07:33.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzzMHh53x9GQu+6/YCkfau+2DFGQOvGSL/w04mm03+TxKB+l3MSu3EE2fxH+A96w6ITJgApBHKqbFMFX3kNBmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6829

This removes the kzalloc memory allocation inside critical section in
create_pa_sync, fixing the following message that appears when the kernel
is compiled with CONFIG_DEBUG_ATOMIC_SLEEP enabled:

BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:321

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_conn.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e996e9763666..b5b78d469d54 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2079,7 +2079,7 @@ static bool hci_conn_check_create_pa_sync(struct hci_conn *conn)
 
 static int create_pa_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_cp_le_pa_create_sync *cp = NULL;
+	struct hci_cp_le_pa_create_sync cp = {0};
 	struct hci_conn *conn;
 	int err = 0;
 
@@ -2108,19 +2108,13 @@ static int create_pa_sync(struct hci_dev *hdev, void *data)
 		if (hci_conn_check_create_pa_sync(conn)) {
 			struct bt_iso_qos *qos = &conn->iso_qos;
 
-			cp = kzalloc(sizeof(*cp), GFP_KERNEL);
-			if (!cp) {
-				err = -ENOMEM;
-				goto unlock;
-			}
-
-			cp->options = qos->bcast.options;
-			cp->sid = conn->sid;
-			cp->addr_type = conn->dst_type;
-			bacpy(&cp->addr, &conn->dst);
-			cp->skip = cpu_to_le16(qos->bcast.skip);
-			cp->sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
-			cp->sync_cte_type = qos->bcast.sync_cte_type;
+			cp.options = qos->bcast.options;
+			cp.sid = conn->sid;
+			cp.addr_type = conn->dst_type;
+			bacpy(&cp.addr, &conn->dst);
+			cp.skip = cpu_to_le16(qos->bcast.skip);
+			cp.sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
+			cp.sync_cte_type = qos->bcast.sync_cte_type;
 
 			break;
 		}
@@ -2131,17 +2125,15 @@ static int create_pa_sync(struct hci_dev *hdev, void *data)
 
 	hci_dev_unlock(hdev);
 
-	if (cp) {
+	if (bacmp(&cp.addr, BDADDR_ANY)) {
 		hci_dev_set_flag(hdev, HCI_PA_SYNC);
 		set_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
 		err = __hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC,
-					    sizeof(*cp), cp, HCI_CMD_TIMEOUT);
+					    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 		if (!err)
 			err = hci_update_passive_scan_sync(hdev);
 
-		kfree(cp);
-
 		if (err) {
 			hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 			clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
-- 
2.43.0

