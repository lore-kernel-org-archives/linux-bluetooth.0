Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3718A925
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325645; cv=fail; b=R3OQd4w1VPVmi+hA+s+QJwr1TkqW4Ht2q+r2jI5Z+PvKZ8B+rPs0ZgeB7oXA+TwkiC+OlwKtud4YWHy074NcaLyZsF/BHyqLpxeSmU+M+uCYhgtmnfxRjDZ4JQ6ryNWLEe6l83rKRlN2WoR4A7JlNpM5m0PP+z7krRFOuLKVmZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325645; c=relaxed/simple;
	bh=zQRZHl+RtcEZ/mWoXWOVPcsX3xFfzNZf3BnqQ9P0gY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7pDdR7frNx+NSRoCMl3g0P/QfY+AeDYGnQbpMHc+/WnAJwCy0FQi4ukBxsmMqYHPcnrQRnO3uL7pNB9GOF0wAcwz0wjw5Ac1goLWom0qaRF/X8Mc5dSQdmLyuxoweaMjGjbzcWVBHfqM3TvGukHQuqmvMiKCXr5NodhXXEwTHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GWlkgObt; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GWlkgObt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SYVhKpfu8dKAfBJJIB8kpXxTAsFKuiTornYaFqGFfYYzDX2mTT/kJGg7FZe+nQ6TMUuBpSZiX2JxzXUCcHdkv1TXbKAYdsi9EC2L7ot8xXN1Wtues/wn0mafcWOzpylkA41fdpWQaUtd8SnbRdscg4gtDLGp77o9o4TBdlvqJbQgzlTnLgeJgfmn5gGIXrWTkTtMY12jdXI4cqxYyZYcDHy24zIrC3l4wm6V7nolb3hZUO0hCVuAlIbc64Z1FtUM8T9jhVATosKIjinJlGjpWuORTzsw2l+2ScZnxQpipgn1Ek4+QTSggVImkVxi4l59qYDz9cCXqOBE9r+kcEmP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkuVf6uELHaIs/Edv8jGRVvRioIzLj2z+exUYC01o2g=;
 b=XzQqTXg2rz107aV+FEE5001M+ZycAOGuNQoOqlIwxOqzB+kC61v8hce/btKzEI6aKIyHgslLUYB8DEe0Ccuq2GcZsXbZszHNtqilwom7696W5h2sClUSk1y0LKTf5zpa37kMDqOJIampD0c7mu8QsJWlcRAgVW4z4cF5xbDPGa7h1w6ZjC64eG80C1iVb9mzrHtkmuJJlsdhfbTtmEGiw6ZhOyS4aSblvmigXN4a51Ygi/riqWBpTJInnb+uyEg6Ng9RAK2mZPAicWdRYnugdcwr1mafpNT97oCQckqo+wH72FqtK5OlH16vD8Z79hBPP0bGCtTg9m+bxjm0srb4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkuVf6uELHaIs/Edv8jGRVvRioIzLj2z+exUYC01o2g=;
 b=GWlkgObtdU8S/sK5+HiJKVp5EdrsTAXfVqrQSD7LQbpo+8l7KQXOfW3CY/1poRIlhX7fOigZkqpKRMySeCHepn3WmEkzy1wq6CCGm0O6vzeGH8lG7heK2QK9BrKeiBziyO6hJMwgAZz3XKH1wxx86SnyaGDbfwzPSr7HsgGMVBcsqQ+FtTOzWzum3S8uFvY+LmLbOSN+YMPmSZ2nBVEGvs4+bs3aJSWa+2Gl5qB+LkXYm5plgYVRWl7fbxJ/RKeFGBDlaNYcGaUKJAqtI40JpyXGt0WJdOItLUifmzx1UJSClY7RoF+cFSzRs16lAjAf3BuRbAYlekA/vokk6xc/7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS5PR04MB9998.eurprd04.prod.outlook.com (2603:10a6:20b:67e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 11:47:16 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:47:16 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/2] Bluetooth: hci_conn: Remove alloc from critical section
Date: Mon, 11 Nov 2024 13:47:07 +0200
Message-ID: <20241111114708.10722-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111114708.10722-1-iulia.tanasescu@nxp.com>
References: <20241111114708.10722-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS5PR04MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c17e49-0347-4ffb-e6b3-08dd02469748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBPGU4NaCYRDejwjc8TkxLPaJvmHC9gjEsRCDZW5awWcC62lhWAEsGsgoXBQ?=
 =?us-ascii?Q?zjVSVENs4ML6QxPb3/tGW9id1736Al5X04JJx1GL0RvRoCUkMX5etO+VGbHc?=
 =?us-ascii?Q?+HmQ8+7ycT0ZLdBuAx8pyk0RJz3Ex9XWvMy1itPhTvFgqAhCTfKlhhV69lEA?=
 =?us-ascii?Q?pHBoNCdBfQRiVduKwetU8FuU/7S7+2ixGVHeyvIN0bu4cTSCk8gVqNuJhSGd?=
 =?us-ascii?Q?mC8sWEelOadWPhXQAlqf751VejPtlMLH1jq/eEkW2NqcaLTRIs7iJ+CYLHcP?=
 =?us-ascii?Q?UXbRr07xSH5qLDRs78DifcY12zKVdNJKfTFY7G2iHu3GmgY0YSZFOS5s2DR6?=
 =?us-ascii?Q?w1H9/Yz+F9tNhpIsvzsOxkUrDtLUkEPGjipjFbgR+lkBXrpNBI/O2ySr3SPa?=
 =?us-ascii?Q?KrXp5tinTEQU0Z8xAz7Q4w04/TciYsif0dACZ5TEAaZHt600ytDKiQGaG6fR?=
 =?us-ascii?Q?gwGHNoKKcUCB4rfaPoaUY2/L98htuxwyywctYeWcdRivcxS0O2iCWj/GG4sF?=
 =?us-ascii?Q?2PMLCE1f5ct12qMhQoeXj6pIwxPQ63rz202gNo2S1tdgOOstU7JI0BZeMFoP?=
 =?us-ascii?Q?7+ccQ4YC8LEorDGD8Tvt5uJrCsOt/68qoY2SWPCrLAwvElsspYN/2KfRr+ug?=
 =?us-ascii?Q?0mjAtZqetjSnDXIGSeGGCDSN3Lxiq+jB1PU96gYHz6/CpaZZBsPn06tk+J5r?=
 =?us-ascii?Q?e36xdAJzuIw/CFMx3Qj7dnjvG+KKQ5vANEwlcYSmK1bvpTqBhkc1b1iAoWZs?=
 =?us-ascii?Q?PJ0QbmDzPd1PrkkC9dtNf0HP8i6awR6Ge8bB2Qdvm5zhYoWdhhsrgEe8qdeA?=
 =?us-ascii?Q?hKpX++yORJFYVjahmjP7NRymegPJNqYaCAYbBfh22QArENEUhY1aMRyLkgfi?=
 =?us-ascii?Q?1iz0OHWbexylIE2ISNwpxw5EQcjVWHJvmlhiqUp2wb5jnhPRAz5lh/4sIAAu?=
 =?us-ascii?Q?i4N9eBAy2ZFxZsxvGCDkefYpWj0JbDRXMOaAJXUFy3sd1LYFIU+sPbbnfNj9?=
 =?us-ascii?Q?G0oNKWMJKS6icIx09tc5XREYVCDDszJbfJbrDo3Fwhlzbm4dhiESk7QtwiQf?=
 =?us-ascii?Q?SdQrzD8cV8W4Zj/dZ1usbXTkVnxuE7EVHk6KDoI4h9sg6TB01KeYxQ61RrbQ?=
 =?us-ascii?Q?MJGb8j54QU80ct96Dbz1hieHYGxRkrp3x9mF40f3CtTD3P9k+vlqMhD5ddl8?=
 =?us-ascii?Q?8NKa8gnHW38y8u+kupKfMzBfrYoK0ZHvC0PQ5iWXd9KV7DtPrm6CQOjRrlwD?=
 =?us-ascii?Q?7vsiVKIB0GSlicDmlbk0bCkUesUZD6GmJ0zmGeuuDkghYJwaVh+8uMh1AHoR?=
 =?us-ascii?Q?r3ICkCKZQ4ay+4GxKYxb4bsI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hh7XUcY4SbalET19Cxi/tY1jJcmBC0OQZ6yQcf3iP+jbCvwNvzLEAf8Asl2w?=
 =?us-ascii?Q?tWRBcLMnGFNz6+YGyTlV6xn/y0kwwrfHxs5EO+9rZeo1NgUkCE3gbpX1mECI?=
 =?us-ascii?Q?cgaDgN4YWhDmbjhXAfz4UjU5cYClusK0zE4GIffO/3nH0+suSlkz4AsNJosb?=
 =?us-ascii?Q?0ujTINaCe/KsDzltuIDqSAGiIqqfqIgGS+Ri7l3ellrf+YUz8OtDyAwZYA0Y?=
 =?us-ascii?Q?bznbIp6YgE1ByH7lHRtEzUL9nmrDm6x9Xs6Qg4Mp3fccom+A2irftEeQbd1e?=
 =?us-ascii?Q?8fGh6lBPeRlM1P8dqjOX7q3ba7jMIE7uHeugS8NUwy5h+AmsZaF/69jlyc+d?=
 =?us-ascii?Q?9q5O9tYvAamOR1fcgqmsBZ0XWTPAyVBK6+uihjx5VveqrYqVRLE1i0iCGDZ3?=
 =?us-ascii?Q?YWa8WNG12zgrpFE1UFhWyEfvdnOK/Ai9JYTF6toEtn2+j1lVRnPdjBoAKf48?=
 =?us-ascii?Q?fhdFrpuNLQE1ct+70Vq+YToQdBYf+1gaB9NNhBpowTxzZsm70cPZguBqLgcS?=
 =?us-ascii?Q?qB66WnCwi63noe+YpgtqIwC0dBIhgODmRlLG0u38ECdHy/W+ENoR5GvSrdyn?=
 =?us-ascii?Q?QVFsCoBDbY2YkWvRE5vlfJ7nbsoAKO3rYDQ86MKtIDGf1OhIjv7OOsJJbOOc?=
 =?us-ascii?Q?WTuQjMse4FQl8gr8Oh+r79MHH1JNnBa+kcofCeEcVrlwaeSYqoJcOZ1aIIC7?=
 =?us-ascii?Q?YtIMOKgGTs2rgUbSKYGfP4ROlc9PalsXwDLjugl1roE7NMfOa1tcXR8ZGVy7?=
 =?us-ascii?Q?gA4WGbNBuxrBOsBXqAAJRVfCuAYMrK6aBrhK5KAXo1on6POKGQAWlPUxHuoP?=
 =?us-ascii?Q?EyTXX4uVht+9h5jse18WyqPsiV6B5ijTN/W2LP856sJOGvatOClMntd9FgFb?=
 =?us-ascii?Q?pcSZ+X5tg+puOAM3cklgCTlqrzLq8pCclNWnJyDWlBINGe05VFpyR9oXWsoJ?=
 =?us-ascii?Q?sycSrXcfXKkuEgS+42cDnDnukCJEvPAmtrWCPenx+3rYqi/6m8Dash1JXJAa?=
 =?us-ascii?Q?sCL+j7X43sVjsuLkUDBN+mrob03079u239u8PTpg2gnlM7GDW5wsrZDtOztf?=
 =?us-ascii?Q?T/5uOLbZg48GIoMyb9CU2no9+BJTahTJYRhBTmUWtKD8rJrDz581YJMk0eaQ?=
 =?us-ascii?Q?sHIKfaZ/1CIGCiEQOH/9WCxiW8N9a06Sg4VMNhRfKZXJpVc0H5xnvTbcIkl6?=
 =?us-ascii?Q?q4NmzkE49F071YnnLKoiY6ZnqEGvdcmqOJmYs90oT4wR5XpFhnzyikJUcQVV?=
 =?us-ascii?Q?AXHIHoYPb6X6KhhFWK458wjhIsUZhxmacWlm9sslfYlOKpq7IC0NMbX8IT6g?=
 =?us-ascii?Q?LtyA3x8Qdx+blCZdlvyIXFtIaM824Hje5jTWwMllMufZE5vQlcBqo6velDyZ?=
 =?us-ascii?Q?pfxUDBguNOtKlJgdmJOa19UUlc8nAqcubMcnPkMrqKjpCpSX6cic4/54IaV9?=
 =?us-ascii?Q?doVuY223e5gS/UouduRlEAE1Et5fTxuB2umzbK6ACpoLeAxpEDnzvSBIUOwq?=
 =?us-ascii?Q?QTcZppg5bfP5+lJ0KhKo2UQk4U+2IbGk1np7AIKJoG9k/4c32wM/FKuSj915?=
 =?us-ascii?Q?dB0MWSBGJwRCoq7rmKSOglq96XZxedN428W6PUqLz1qkGhm+jr1NOxwYpMqU?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c17e49-0347-4ffb-e6b3-08dd02469748
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:47:16.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOfl5SnHjnYg82CT9PYZDydc0KWTYLrRwLPXDDfWY6zlweUqm7TIVlb3QAUDCfskmGi6R5p9nu63fsfhxWRQjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9998

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

