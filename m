Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885A156F41
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859490; cv=fail; b=WSbBDeTgg7wCNqWS47VNYa++QERTw8jjayDsxOUKhu0PWrVyfCD7wELr77yLgBW07IfGLQqZjPvVEkNtLIfL8wXbeXZk44j4fuyaGhXzlWgzRMalrhh2VPaFjPFl9aX0reTfXHGd/5ibkduPyex10iHmBkJE0dZ5e0g0xdSligE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859490; c=relaxed/simple;
	bh=xfcJrAwt+06PNZqjD3RQnimQ9UwdR7Z5qJLwUEcUGyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=elIg552xCvJp3cBO2/OlppjK/I6gQCiiEhSr1RfjEcRVlY4+LLcNW2U+NNlAi/SypVcc8oyvo8bS6oyXof5Fwi1HQlv8MDN7otP46NP9OowxUk17kvO/D1Vh61PHjHK7UQVOvVm080YbWKacNLkSve0+YsFboU3QI4cndH0M454=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ic7YCTXy; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ic7YCTXy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRxVhlczBa2Wrgl+t7nvzeUCSIOC30JXd3L7rs+6jHLQsQHeB/3P+zGbT3m8vFQf+7kJx45JcuQFGFVjOdY0IPfJa7rulne573j6CKkrS9GHn/Xg+QkV0iF/lqCXomOPzXvHURAtgrwcj1ATBlgUphtYQspaHlKAX2FcIvd+AuS24coRVxW606FPXJaj6yxaGDA0D4/i5WewpE5DuKfkkvLs7S/vBWIpQGGUoHfgdeTWvBqan1N7aPdrrQXwuWwMX29LOE4IJ1zXdIOIjnNxPCPxOL7Jd7NoepBP70KnjsS9O1I/sb/ce1506sHxGBK2a5U6pjMKxCQeM3EfAwcUNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7hvhC227PZ8nEM98BLq7s6OpzOOErPdsk2RTW1HKWs=;
 b=g2E5eppjOmFPEwYcPnq0zxVEX/xtwfSaqFmnlYj3TZY58mvPZlpwd2Fi/N0/YIVfqU5/49Vh1BAg7P6I+PfrHZtr9zIXDDMF2+8d98yIajxqSUABaViDlAwUmmNtJtZDxyV3DCiQkRh7FVJX0i1uRa6cyLRnxzl+/+zXWEleK4zWjvtx9TsKTYCBtc37n2iQGtiYZNTI7ah/qUYNemFUQz8PDWYwBwPVpVnZH9h4IK26yliiKzGJYObGdIZ20NbkUuNrnIWEsjMZgkh0NuYDdztQqay5h7H8kHbzxBhgj77bSSb0SarTBimlBZJFvUjA3EWJrTiccGvOvTtqFMSHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7hvhC227PZ8nEM98BLq7s6OpzOOErPdsk2RTW1HKWs=;
 b=ic7YCTXyPXSJoRFP0WzZsaH6SGOWWurGSHjfMpNhasx8LOCUZxhtnkjQ+aEWF5UuiCFcp5egmR7yyMUcwIV1XK72Q+QKv5N4ADqMIhHsV46Pfb3/p7YC3Jd2R+fF8A+JJIWsQafkE10S+Nmue+/xwsA1v3IqZC6m+ob5Gk6t6rUxA2Up3GkW09TWj9o4gaWms0qcNNr8BBdzex3c3Ih9zqXdwnoWAiZLxmCORdzqkUlFDJJe+AJKXbSF0rveTisjGJvVQ5OBpQ1T0s1nc/3JGN4qOl89qeh/APMHbCdKOn28dF+JuUVxOh5Kr2Ht3+xfxVBlXnkZvOfFIOKzVJNnRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:04:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:04:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/7] shared/bass: Add APIs to register bcast src changed cb
Date: Mon,  5 Aug 2024 15:04:26 +0300
Message-Id: <20240805120429.67606-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
References: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: 41663558-256a-4097-89f1-08dcb546cc3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+y2bsoExxWc65/GGJEJR/ePFifIcLMhvnED6fnzzxZ4qROZCMv6J1FomvbJn?=
 =?us-ascii?Q?otQvzSj/RHZm9HGBivEjPD3Lq32scI+z3eIrVRq2bU9XDU133SdC3uqhOrZx?=
 =?us-ascii?Q?806O/ICJK2enPxbkvPysI32oUQeDyETc1stdMFNxNpNyuxs9fi62YlqvUAfq?=
 =?us-ascii?Q?n4CQ5XIn9baVA3E6OIfz8iTGHKLJ1DS2aqy8cNK6wuxjph9xzGsklQW8bfLd?=
 =?us-ascii?Q?30u+CfgscWw3Eq7gn7xunb8DHpd1tD1SCJVtjWvd4whF+d7WMVi2z3yLTJT5?=
 =?us-ascii?Q?FcH0Iju3UCM10i9i3xo11AstekhF0gW3U/hB1jK0W4Hxkfuhk0SjrpotimAg?=
 =?us-ascii?Q?2NqZmd4OtDzttq4pc75J4VELiacinnuyzw28OsWRadHa0gKU5o5Ned8gQpB4?=
 =?us-ascii?Q?WiYteG7wb3FcmElR89U0JXCGVE8T2hrqfqvi+CYk0Uk9YKK1ekrRx6qykkmp?=
 =?us-ascii?Q?Z7dBKwOTivWF3Jug4fT1FWfNstttmn4fmxd3Nwe3OlgTuP4mfgFXigqm0PJI?=
 =?us-ascii?Q?viWZJzfrhCHKwd9HazaSQ1QHtemTluRBVhT9N6egFpWBLSIuk1aw10J1tlEE?=
 =?us-ascii?Q?HGzDCTli2AfP2sOb1vuXicuuZZBHKAqDcVapgR3SU79Cx6grWKWggA4oETvE?=
 =?us-ascii?Q?N8vOf5Gy4fCh0YcjD3w/w2JbaVaytWUaYUT2RM9vUequb/uf9clWHcFk5SS2?=
 =?us-ascii?Q?bTEXJnhl+KwQaVuY9Tj+A/IsXvL2c51A6M85S1WiI+NqvzqpMxvoUlxgKqDv?=
 =?us-ascii?Q?cNpNbz9XhQ6oSPpn9RfFxrPjUlm25iWD7tpxQqd+bwAuI9kqx3Y9qCEl4G+d?=
 =?us-ascii?Q?0Taavev1myHFP1eAJYTN/YK+tnZcz0WrIB4P7j+qs0qVzH+XFDu5eoBB5N9y?=
 =?us-ascii?Q?zqd3uuA1oNsAHle6t8Q9D6TSpbp0hFw0FE/T2KCYrSG2pBStkNXqZrA7rBvI?=
 =?us-ascii?Q?Ux6AEv7OTXNel4OfpKZEzqrI1ffCZ7HIMnfiU0HJv4EAYyYQVhyE8uvoyZiM?=
 =?us-ascii?Q?myJLJHjS8Ibgc7KazEZk6wDMZyPx65R1CobGwqdHViQrhXOV1UHnsqoCTU/J?=
 =?us-ascii?Q?a1sR26ALY0jutI19jQ77m3XgZNsTO33kYHKtBhiCOIL87MqpWutOFo8nvUK5?=
 =?us-ascii?Q?G9KYk5flpadPCbn5hu8sAYKpEMVmF++57ofd+Sa+E6fHm75Vnkkdpu4ID0T2?=
 =?us-ascii?Q?GIukG1VeBZ8Due4GJSZ7plckhN+bYvHSf4QgK01+MOWzCS1BTRShmuoZVlED?=
 =?us-ascii?Q?5URkG20Lps6ZB4rKuxFBEGO0zBP/qqiQLNEb+Ev0n+xjT1VU69w4aEwR3FyF?=
 =?us-ascii?Q?3seebdpfPdbAoFDEM8RzFc5T4VqFVzkEuql48CfLnbEtXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JTKpy0J/fTJZk6nKqApDbQ207XLivQeVsSL8/UXBJrmbt39h1L9l7S8xbo/y?=
 =?us-ascii?Q?BKmGuSTF9DHzxSCsE00u5ODly1ZCqI3LxuI4m4gwoc/tXfo6I5VT9jhE2EHW?=
 =?us-ascii?Q?Yy2vIaVdl1oud69Wx0bmJ+dYqsDNJGTvp0cjMEDo5iUmfyiQV0tYLPJSC96Y?=
 =?us-ascii?Q?kZ/z91KqFExIInCWpOppQ+gIileMve8mkZgt8ZlTvkKbTyAaCakE+xzRZVrp?=
 =?us-ascii?Q?bPIdfQH1afBs+aJ372efZpwpuzVccChKfqHtMd3VDX1vP9lEW6mj1UrCunXk?=
 =?us-ascii?Q?b376z/ozeWPMNNQADTbDDz1PCkmbOtsHAvzivsQAXMbUQkjqifh+2VeTccp1?=
 =?us-ascii?Q?PBVezhl9kMX1GdnXjG0OhT8ceCliNd46aXVBOI0rJVysaio9DnQPdfHBUzjD?=
 =?us-ascii?Q?YOKJsZqUDgaw6pz/F7828iAs9fG0cBVVO4BXPLrIdp5MsyPuEC1vXZNLVwXb?=
 =?us-ascii?Q?A6bKjWqIq4YAhSUcYm+hYDZlhSXkFM2Fktrsm6qbD8nVrbgtjXETTQH4D/Fm?=
 =?us-ascii?Q?Ml+BCKy1u4CaGhNJRAKDN8OivCXIvemKei2AdkrZDjQCvqywTLFav0XKfIxb?=
 =?us-ascii?Q?zG8wSvXXkp5U5P/4uYwF+99tTRk/yw8qXNPtdBD+iLwjHFjWv6JooJdvHckD?=
 =?us-ascii?Q?iPbzfG4DCWyFnpDRVBaupj3tSLNmu83Zp+gGib+MBa68nqWK1oF0DWaoMA0Z?=
 =?us-ascii?Q?encrPg7rIjcUQpnR3mv3unYVD81iVjukyu3dlXsY3eSCRIjTR6Eb4rLxS0L2?=
 =?us-ascii?Q?FYoL1Cp1hF1a+Cy1FUe/3EtoJx7APEI3VIYkqtSY1ycnZamIuqJHsAcvwkhj?=
 =?us-ascii?Q?JgU+PaIgNnPe8D7vE4wtbShB+qEBl0rVSR1uF0IX8gHjw6NzmgikwJ3AW6XR?=
 =?us-ascii?Q?XgG1khIZi4FYvBQfHLuo6qIMTkQKOD8QGiLkBAEMaBANsokLGmFEp1sPjjvG?=
 =?us-ascii?Q?3VcHrlxLFLMI8koJyFwlG/os7K3mJhCWSZK25GenwGaRDSJbmlJgU85BN18T?=
 =?us-ascii?Q?PvA7h4h6cMqGwSc2Zf4Je8omMNsiRaq4Gt2GdtiYRQObRG5laQCasFPUkq7x?=
 =?us-ascii?Q?9dX4lAN+FekndehxYAQc8TJPKOe3YgnhJdnR9ED4JGP4D24PX7OllXgsLLQX?=
 =?us-ascii?Q?hbla6HeuXhMRs4zABrVt/W0Xbpn2owpTyDtDaImsb+okWBQZlTWntYNSfoES?=
 =?us-ascii?Q?xD/XbQZq+4KQ7VnFU+Qx9nQ2GATV72s2CC9cP/URUW0/AjuVJNv+kFcs3KYb?=
 =?us-ascii?Q?J1IMgiWOhDY61EEMDVexlP//JNy00LNG07rde7v5hFacHgE/pArWBSRtyfED?=
 =?us-ascii?Q?YBYO2xDMsab9FGTNXOe6siyY9NZNvqLBSF/63A4eV4aQI6U0Wz9DfioHz9I3?=
 =?us-ascii?Q?iFipg+elS0GjzlWbRgyA4M5gZadyF6ovn2jNLx+DfS7Bdg6v937RrmiCN1Oy?=
 =?us-ascii?Q?iKgKeQ8MxGuOlzwvdyRN4eoEsLrurqzFkb84IRlke3nkAyaExmObsi6FVV/e?=
 =?us-ascii?Q?6qSxo7y62i8VyWs0JI6OQQdUA08SKbafo8mqNb0Xavr3OKnJ+jhNZeMIpErN?=
 =?us-ascii?Q?n/DE8hS18wG36P/otGdv9F+118ACrzSDt4I6yyZCi7kOrC5ti5ie3GtW419t?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41663558-256a-4097-89f1-08dcb546cc3b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:04:45.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TcWdGHiw0scz+LaxKSqpNMX/inygAmR3gaqR9LrCTR8T4WfbKTxc20dp2YW2/HCt+R1AsdGv9Xb7BkGzCBnrTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

A BAP Broadcast Assistant (BASS Client) needs to listen for GATT
notifications for Broadcast Receive State characteristics from peer
Scan Delegators (BASS Servers), in order to learn about updates in
Broadcasters known by the peer - for example, the Assistant can be
informed if the peer requires a Broadcast Code to decrypt an encrypted
stream.

This adds APIs that the BASS plugin can use to register/unregister
callbacks to be called on each received notification.
---
 src/shared/bass.c | 95 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h |  5 +++
 2 files changed, 100 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index d9ab210b7..b54bf3094 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -71,6 +71,8 @@ struct bt_bass {
 	bt_bass_destroy_func_t debug_destroy;
 	void *debug_data;
 
+	struct queue *src_cbs;
+
 	void *user_data;
 };
 
@@ -118,6 +120,13 @@ static struct bt_iso_qos default_qos = {
 	}
 };
 
+struct bt_bass_src_changed {
+	unsigned int id;
+	bt_bass_src_func_t cb;
+	bt_bass_destroy_func_t destroy;
+	void *data;
+};
+
 static void bass_bcast_src_free(void *data);
 
 static void bass_debug(struct bt_bass *bass, const char *format, ...)
@@ -132,6 +141,64 @@ static void bass_debug(struct bt_bass *bass, const char *format, ...)
 	va_end(ap);
 }
 
+unsigned int bt_bass_src_register(struct bt_bass *bass, bt_bass_src_func_t cb,
+				void *user_data, bt_bass_destroy_func_t destroy)
+{
+	struct bt_bass_src_changed *changed;
+	static unsigned int id;
+
+	if (!bass)
+		return 0;
+
+	changed = new0(struct bt_bass_src_changed, 1);
+	if (!changed)
+		return 0;
+
+	changed->id = ++id ? id : ++id;
+	changed->cb = cb;
+	changed->destroy = destroy;
+	changed->data = user_data;
+
+	queue_push_tail(bass->src_cbs, changed);
+
+	return changed->id;
+}
+
+static void bass_src_changed_free(void *data)
+{
+	struct bt_bass_src_changed *changed = data;
+
+	if (changed->destroy)
+		changed->destroy(changed->data);
+
+	free(changed);
+}
+
+static bool match_src_changed_id(const void *data, const void *match_data)
+{
+	const struct bt_bass_src_changed *changed = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (changed->id == id);
+}
+
+bool bt_bass_src_unregister(struct bt_bass *bass, unsigned int id)
+{
+	struct bt_bass_src_changed *changed;
+
+	if (!bass)
+		return false;
+
+	changed = queue_remove_if(bass->src_cbs, match_src_changed_id,
+						UINT_TO_PTR(id));
+	if (!changed)
+		return false;
+
+	bass_src_changed_free(changed);
+
+	return true;
+}
+
 static int bass_build_bcast_src(struct bt_bcast_src *bcast_src,
 				const uint8_t *value, uint16_t length)
 {
@@ -1321,6 +1388,27 @@ static void read_bcast_recv_state(bool success, uint8_t att_ecode,
 	}
 }
 
+static void notify_src_changed(void *data, void *user_data)
+{
+	struct bt_bass_src_changed *changed = data;
+	struct bt_bcast_src *bcast_src = user_data;
+	uint32_t bis_sync = 0;
+
+	for (uint8_t i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *sgrp =
+				&bcast_src->subgroup_data[i];
+
+		/* Create a bitmask of all BIS indices that the peer has
+		 * synchronized with.
+		 */
+		bis_sync |= sgrp->bis_sync;
+	}
+
+	if (changed->cb)
+		changed->cb(bcast_src->id, bcast_src->bid, bcast_src->enc,
+					bis_sync, changed->data);
+}
+
 static void bcast_recv_state_notify(struct bt_bass *bass, uint16_t value_handle,
 				const uint8_t *value, uint16_t length,
 				void *user_data)
@@ -1353,6 +1441,11 @@ static void bcast_recv_state_notify(struct bt_bass *bass, uint16_t value_handle,
 
 	if (new_src)
 		queue_push_tail(bass->rdb->bcast_srcs, bcast_src);
+
+	/* Notify the update in the Broadcast Receive State characteristic
+	 * to all drivers that registered a callback.
+	 */
+	queue_foreach(bass->src_cbs, notify_src_changed, bcast_src);
 }
 
 static void bass_register(uint16_t att_ecode, void *user_data)
@@ -1562,6 +1655,7 @@ static void bass_free(void *data)
 	bt_bass_detach(bass);
 	bass_db_free(bass->rdb);
 	queue_destroy(bass->notify, NULL);
+	queue_destroy(bass->src_cbs, bass_src_changed_free);
 
 	free(bass);
 }
@@ -1656,6 +1750,7 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
 	bass = new0(struct bt_bass, 1);
 	bass->ldb = db;
 	bass->notify = queue_new();
+	bass->src_cbs = queue_new();
 
 	if (!rdb)
 		goto done;
diff --git a/src/shared/bass.h b/src/shared/bass.h
index 864b01637..01c1279bb 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -119,6 +119,8 @@ struct bt_bass_remove_src_params {
 typedef void (*bt_bass_func_t)(struct bt_bass *bass, void *user_data);
 typedef void (*bt_bass_destroy_func_t)(void *user_data);
 typedef void (*bt_bass_debug_func_t)(const char *str, void *user_data);
+typedef void (*bt_bass_src_func_t)(uint8_t id, uint32_t bid, uint8_t enc,
+					uint32_t bis_sync, void *user_data);
 
 struct bt_att *bt_bass_get_att(struct bt_bass *bass);
 struct bt_gatt_client *bt_bass_get_client(struct bt_bass *bass);
@@ -138,3 +140,6 @@ void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr);
 int bt_bass_send(struct bt_bass *bass,
 		struct bt_bass_bcast_audio_scan_cp_hdr *hdr,
 		struct iovec *params);
+unsigned int bt_bass_src_register(struct bt_bass *bass, bt_bass_src_func_t cb,
+			void *user_data, bt_bass_destroy_func_t destroy);
+bool bt_bass_src_unregister(struct bt_bass *bass, unsigned int id);
-- 
2.39.2

