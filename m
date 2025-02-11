Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012026.outbound.protection.outlook.com [52.101.71.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF411E9B07
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Feb 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739283588; cv=fail; b=bOeRrpKhQzV3QrD9YFvdogbytGYm1Kf0pzv72Eppj5vE2UMLWXaIWnUtzBS1O/Hg0jRjTacXNf5See7U3WCzSqynr4SMtnMpSl+JThpXE70aoTH1xPJ3zHJ5RmBlYALuYxtqOjWcgZdEpsgOp3hQUBijDUxz4/O0zR2ofhamvyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739283588; c=relaxed/simple;
	bh=/cqx+mVe2fDRPwc1WMjXycR4LYggRLftgUaImddv6L0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PtqblPwjVumEHxYzOjfoiwfAzeRmpDjCDGTFukEAYfOXY7nSAMED/9xDTTXuZiSACLjD+8PaG0zYtM0cLdAmhsa4OIVhnDkW3gf6URJRft14erEsa++SW+W8LUdpjbd1mTLHWSWLTJP6VLStrFZ4nucnEaYofZ1QHqZZGOll7N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=laPdwRwt; arc=fail smtp.client-ip=52.101.71.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="laPdwRwt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DtxPsJ+Ykl1kCgyVaMO6a2wW+Y0ixaeq/U+wqArXKLdH6La3x1+B1b5Ww/Z0ZCFi39jSoEJ+u2oxW6BtCV6vEg1sawcxEukDBBW6wHRnhj9y2USgDkDMI3HQo8ybYyzh5/+LYX5pidn9sPVfspcDzkXLYNMqVbNf9LjK1zMfIBhO2n6ypLkHQ478uVI/NQ3wMjbwfHrK08j/0xlmpr9m47avusB9layR1l1BsNzEI3kbZR/WzLwPMtMSpFSulVUiASDYdeSuAV4MQNCYejoKbTTNfDVhRLuQpZ24D9U8y1Xuia53/JqeCDN6wlhnBFDMSoc+HbTR6MWZkcYYhpmsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3MfkXolLFchipp/SX/wFAr88THtYVECuuJEoEm3uqI=;
 b=SSkHFMFq0C9/eF4Oc3Icrf0+NdQDqEF1oAnIbSZxjRykplFOBUqmffhQzQ437TF3Np50md6fn8+7b0PD9pc7V8M5ou0rRwVoWZmWN+y7zhXSQKksokyK+Z7zRtcpGu9svsMAcq8Z31HeZ8BoJL5DEapXe91Ril0Bcn1o3HVVkvQfUBvjbK/g3gsyCZJWI+a/0S3GgMTBxp4X9iOnezWmg+tqS2cmxCARBxtRBYgRkYTF4StMBtU5S5mde7Lg76NeLnO/sJ1/X8iSZuSUzrmTkNIjz5ePKT42e7X85OMIf+fCPiVDug4fyGIPtdzoJE3nbWZwVQkPzeCRYVCcFMWVvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3MfkXolLFchipp/SX/wFAr88THtYVECuuJEoEm3uqI=;
 b=laPdwRwt58soXWcDHS14X+Quk+ap1a23c1lPh5STnVPFwPpXJBUFMT+TjT/caz8Qz+JMQulVzmMc7F5xPCWDygSt1F3f4aR9TJPCcxpIb8WqI3uU9ULFCU/p+fphUThKRIPrh0fx86eBLKd06FsqtAZIT1YlqHGSRA4JxcqncgsCzC/sa162tAkOUNL3U16q/w4ed5dpstinXFN10k3Tj65/Y78bw3cleQzZV7WXXEJx2z1VnZt+7Gca+ZKMimzlvYBNNUUHsIZ+gHYJ3WseMxDtFX7Hnvq8L4xoya/pwjWvwiyZTOCDSqWY7vhmLvhNG9EVJThhMCJJF9jPUJJsbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 14:19:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%2]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 14:19:43 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] bass: Register bap attached/detached callbacks
Date: Tue, 11 Feb 2025 16:19:35 +0200
Message-ID: <20250211141936.23372-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211141936.23372-1-iulia.tanasescu@nxp.com>
References: <20250211141936.23372-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0033.eurprd03.prod.outlook.com
 (2603:10a6:205:2::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed0bdf4-d23a-41af-fb25-08dd4aa72110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcGS8+N2lvwCcvY2MXIoP9lLRfXklys1fMOypiRHbyumXyn5zIxkqVWNCExY?=
 =?us-ascii?Q?qRdYq7ej/0YN+QkENBp8Mv2tYVk23RdPxpCBweGshMFzoVNTY46mi302ny6q?=
 =?us-ascii?Q?ucm4SabR6rTHgLzdVxcHmP+7H5UDP7V+r2DvM/JJvuHUQFkKQZ1fA6CEfrYP?=
 =?us-ascii?Q?AcP7IF3Wm/Iit60n3U2tIeT0hQI8RWa7cjyinhxLDmHsT1qHYmxGvZ32kz1+?=
 =?us-ascii?Q?a5eqIyTpxxH3Z6W3dADGnVOUf/Nuydeeo7WyWSnQGFUxxlfe3vQqwr14d/i2?=
 =?us-ascii?Q?QnLVsBDgz8dgTT85GXYYEqDTXXWPd5pG5Z3arJPm++OdbVzW7YebDD+akb4U?=
 =?us-ascii?Q?cxSUreE9m3kHIE0QaEnAqGU6Oi9fqHK9nHKVNSeisX4Uif/ExnWrsmYqPmiA?=
 =?us-ascii?Q?Mb7m8MrvC+3foljIWu3KiFxyy8tL37yOWXyPhVJVvK82Gsq7hXLwo4ipgMVl?=
 =?us-ascii?Q?VUwHj6irn9S81zJJKKli61zRUsSDZXZEoT8/kfOvjhnxWVrL8LCaGDtesZe8?=
 =?us-ascii?Q?zAigw6Bh8PHdi3e4D+zJKlm2vqcWWbZM96Zuz2M+4Q/kd37Uei1P4l7aEC1m?=
 =?us-ascii?Q?RaaccRZhj2L2gJeExptqlforcozXAg9A/aRzyJ3S79Hqz78bRX330E5n9tgJ?=
 =?us-ascii?Q?WQ+erdpGm45BfwN6dst+oWn0hhKVmdsf/Z2AhOk+axcVoIcHCNqudemf1gMN?=
 =?us-ascii?Q?iJsMX2u1rNAWgctY0mef7D43LXXZEpjW9m2qlB7HWoRxf/q6qcUlRA7miHEq?=
 =?us-ascii?Q?OD06h1UfziO2fFKUn5n+wXs+k0r4w/5LE/zKBoDH3QbxBls1Xt/pPVqqCH9p?=
 =?us-ascii?Q?ZbLvcnfpzj/6Azp+ACqQgsz1i+uEY6UMZV82RwKQrGZhk3iMzsF9Ci2g1q3m?=
 =?us-ascii?Q?vn/215xpdyqKPuN/iom5sM4QCeNHh5sNW+uarwlZj3YbdIB3OepsAmo1Ab4d?=
 =?us-ascii?Q?pZ0kV+9Hdh6LGkaeTdrtyL4FGpIeJ81ztwMCQSJBxf11BsJ7wzFiad+l9gqe?=
 =?us-ascii?Q?NF3ZMUhtWjiWlAQX+bgmBmA86PjzllkFr7SXyL/8h/1niOktX6l/ERABeRH1?=
 =?us-ascii?Q?9+wfdCEo+WCwYs6BrQStI7k41AaW/z751NOLxeLJLSfQcXFV0KY3ibTBPsd6?=
 =?us-ascii?Q?UX6hIQI5ztrWDDi3uIhQL1r5HJDSRuahm82TLjWghT+vOIA8hvHNdngZPZfF?=
 =?us-ascii?Q?0f2jFVjJ0KSU9rkECMx+HJysVZ0VuFe9mexNU3wQZVHTCSrYuLhvCggME1ts?=
 =?us-ascii?Q?PM7Hzi7Ubp/ObOYYK5jMtWTOtgWZp2TbDipHhldvWAJ8bpmOwUOuI8ilPmuj?=
 =?us-ascii?Q?U8VvInq4GO332z0hFjIMmyzk+7kkgDTL4X7FT2WfFmd0pFYeiZMl2AOU/f75?=
 =?us-ascii?Q?p+q6aKAykrDQ2biOiAmR3TiASSes?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cu2HGgeQZpojtdOhiOVXl24d84KxflvgSkYHBha9O26PubD4WqKIRMnp5IpP?=
 =?us-ascii?Q?RYdFRw966VBaoD43ovSEIGHf3aY0FPyvZpdfnp+0N01adL0rlh2n6nN5TTTO?=
 =?us-ascii?Q?2+sBLNHULO0FlxfAZveWEUjGqVaQ1elL2fTwacTf2IZNT4U3p2+WduZcxUoY?=
 =?us-ascii?Q?lGtFGWYLxmrRcgb4IDbvu9C3YRQ2/xI90qwfgiARghDkCX1mBHa76YTK2bUi?=
 =?us-ascii?Q?OUCrsU06MI1O9g5Ib+6AfHP5j2AfHWi3azQgkRIcVB+BnQyueBJlut90zccy?=
 =?us-ascii?Q?FnHWJ9om/rENS9+q9MzwgQL2WWXGz/KGqBibRYlM5LnPrK4mrxwAB4PNnxBz?=
 =?us-ascii?Q?ppHBfsyJIAgA9t+C/4zWsOkm4GMX7kzXFAtOOqmT0ItIkwCGqXCvRqIGjCsX?=
 =?us-ascii?Q?ovoRu875Gc0JrkR5M1JzkIE5N7bvdkKK9q7GPTB7zrN/Tp7ulXFmDRN+aUtI?=
 =?us-ascii?Q?OGF5ZGD4Wd6c/CYBHQYNQpJU7yJDXOIXe4FJuJS2zRCkLHKle3cR4KZ1PKj1?=
 =?us-ascii?Q?HU/yrFHVB2FJiMv9c7oMXrZ1y8pjrlQBwRYN1hbzqHcdxS+Un1PRaUuwzUGi?=
 =?us-ascii?Q?rqAyhJavvRi+dhbjlIIV0XMxK3KV1BbID6ARhBL0ZSw0eLILXwYkhe/ARoDN?=
 =?us-ascii?Q?9wosNfGVe5oktrO2es+1XqQeAORUi5zZeuRJq2EAeYBdoYVK3ex8LkZWs+7c?=
 =?us-ascii?Q?SRsMhppTg9uV/v2oDC5H2ElkDiYaQ1MOJN6tc5s26qGxpJcjpt9C3od8fr/5?=
 =?us-ascii?Q?Wyi9Nyxh9NP4OTbR1sSciGt9hDORZ8LhwxWTGZrmzCsxo9suvJSCo125P3x/?=
 =?us-ascii?Q?vNloVsENPHHuGtId9b1qX0S/RmglMWEjIXDKYTWd49ua9vHovIq5CkiTDbFa?=
 =?us-ascii?Q?HqtNBlKghll0OAVcB9vg1vCnd5TAbeJGwg5tO/gGpdHp/Xn2noy87FAI/nV/?=
 =?us-ascii?Q?vd+BvBA4Q4mB5INLR26jS5M3PRfGCuB7yrdgOtu4bR4ES5J9LCrBIdd01NuU?=
 =?us-ascii?Q?tEwmfoaGFAOAIzWiR40hqJKtYwYhQxq0GTJR3CsJg2LBa9LNxHpeahATs4Lq?=
 =?us-ascii?Q?pnb6/eoeYtiurBzOhqsWovA0E3Xs76RfHvFl60C3Rz4UMnqfTKvPD6b153KG?=
 =?us-ascii?Q?ZsU5guapCOMUR2/fHshi6ro0W4ve3T/FVfEWtLRCb4S1G1SH5NTsZ7sVJHPi?=
 =?us-ascii?Q?SN3V1s+1vKepwz+EIDEQPHxnsRDmPzml8wJr9kjVcCbden6C83qEUbG1Aokd?=
 =?us-ascii?Q?JYokk4iq6LC045XwFPdf34hrrGROBEEFi20Y8enyex2Y7p2iwvx0x9P+9rTp?=
 =?us-ascii?Q?1RlEVC5XcvB6tYXNKt8BJH+HRTafTy/VrMRvLCaSf++PRoQMvzH0kpN+LJXc?=
 =?us-ascii?Q?Pw8ejtghg2ehS9DTTp0mA/kMISNWyEs3CoHkML2cMqH4JgVNbG+3SobUpFEs?=
 =?us-ascii?Q?8GYPIa/IOoRcYhbLOgOdwg6IcSpJVGTIkS0QstDqgrj8s0cDDaM7pegF3IH4?=
 =?us-ascii?Q?cWbi1HrjmccC6VK+3dx7DFH3yLWLeYZo8XMjUg/6f79hzAAkuK+vQXlwWi1F?=
 =?us-ascii?Q?qc+Oy9JTEXPJZvdsdV9bW11DsfvxNzVMzuSQjXVDXLtX9I2jhX3dQpFIgmR9?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed0bdf4-d23a-41af-fb25-08dd4aa72110
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 14:19:43.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhXwHkQ3LYflD2o+hfjCpgdnmrwI1dMT6AH85HDbuRmLRuwURy21DkoWdG0LKVR08TCEwK7mCzWv290rbUdEkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229

This removes the bass_bcast_probe and bass_bcast_remove APIs, in order to
decouple the BASS and BAP plugins.

Instead, since the BASS Server (BAP Scan Delegator) implementation needs
to reference the bap session, BASS registers bap attached/detached
callbacks with shared/bap.

- After receiving a request from a Broadcast Assistant, the BASS Server
creates a device for the Broadcaster and adds the UUID to probe.

- The service is probed inside the BAP plugin, where a new bt_bap session
is attached. The service is set as user data beforehand.

- The bt_bap session is notified in the BASS bap_attached callback. The
reference to the service is accessible from the user data.

- The BASS Server takes ownership for the service by setting its user
data. This way, short-lived PA sync will be skipped inside BAP, and the
BASS Server will handle long-lived PA sync and stream configuration.

- When the bt_bap session is removed, it will be notified in the
bap_detached callback.
---
 profiles/audio/bap.c  | 53 ++++++++++++++++++++++++++++++-------------
 profiles/audio/bass.c | 46 +++++++++++++++++++++----------------
 profiles/audio/bass.h |  5 +---
 3 files changed, 64 insertions(+), 40 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 77df9455a..c503f250c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  *
  */
@@ -192,7 +192,7 @@ static void bap_data_free(struct bap_data *data)
 	if (data->io_id)
 		g_source_remove(data->io_id);
 
-	if (data->service) {
+	if (data->service && btd_service_get_user_data(data->service) == data) {
 		btd_service_set_user_data(data->service, NULL);
 		bt_bap_set_user_data(data->bap, NULL);
 	}
@@ -2751,7 +2751,7 @@ static void bap_data_add(struct bap_data *data)
 
 	queue_push_tail(sessions, data);
 
-	if (data->service)
+	if (data->service && !btd_service_get_user_data(data->service))
 		btd_service_set_user_data(data->service, data);
 }
 
@@ -3064,7 +3064,6 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data;
-	int ret = 0;
 
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
 		error("BAP requires ISO Socket which is not enabled");
@@ -3084,6 +3083,8 @@ static int bap_bcast_probe(struct btd_service *service)
 	}
 	data->bcast_snks = queue_new();
 
+	bt_bap_set_user_data(data->bap, service);
+
 	if (!bt_bap_attach(data->bap, NULL)) {
 		error("BAP unable to attach");
 		return -EINVAL;
@@ -3098,13 +3099,18 @@ static int bap_bcast_probe(struct btd_service *service)
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 				pac_removed_broadcast, data, NULL);
 
-	bt_bap_set_user_data(data->bap, service);
-
-	if (bass_bcast_probe(service, &ret))
-		/* Return if probed device was handled inside BASS. */
-		return ret;
-
-	pa_sync(data);
+	if (btd_service_get_user_data(service) == data)
+		/* If the reference to the bap session has been set as service
+		 * user data, it means the broadcaster was autonomously probed.
+		 * Thus, the Broadcast Sink needs to create short lived PA sync
+		 * to discover streams.
+		 *
+		 * If the service user data does not match the bap session, it
+		 * means that the broadcaster was probed via a Broadcast
+		 * Assistant from the BASS plugin, where stream discovery and
+		 * configuration will also be handled.
+		 */
+		pa_sync(data);
 
 	return 0;
 }
@@ -3118,15 +3124,12 @@ static void bap_bcast_remove(struct btd_service *service)
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
 
-	data = btd_service_get_user_data(service);
+	data = queue_find(sessions, match_device, device);
 	if (!data) {
 		error("BAP service not handled by profile");
 		return;
 	}
 
-	/* Notify the BASS plugin about the removed session. */
-	bass_bcast_remove(device);
-
 	bap_data_remove(data);
 
 	bass_remove_stream(device);
@@ -3225,6 +3228,24 @@ static int bap_disconnect(struct btd_service *service)
 	return 0;
 }
 
+static int bap_bcast_disconnect(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	struct bap_data *data;
+
+	data = queue_find(sessions, match_device, device);
+	if (!data) {
+		error("BAP service not handled by profile");
+		return -EINVAL;
+	}
+
+	bt_bap_detach(data->bap);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
 static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
@@ -3307,7 +3328,7 @@ static struct btd_profile bap_bcast_profile = {
 	.remote_uuid	= BCAAS_UUID_STR,
 	.device_probe	= bap_bcast_probe,
 	.device_remove	= bap_bcast_remove,
-	.disconnect	= bap_disconnect,
+	.disconnect	= bap_bcast_disconnect,
 	.auto_connect	= false,
 	.experimental	= true,
 };
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 3a37d6711..6c84fa1c3 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -3,7 +3,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  */
 
@@ -557,26 +557,27 @@ static void confirm_cb(GIOChannel *io, void *user_data)
 	dg->io_id = g_io_add_watch(io, G_IO_OUT, big_info_cb, dg);
 }
 
-bool bass_bcast_probe(struct btd_service *service, int *ret)
+static void bap_attached(struct bt_bap *bap, void *user_data)
 {
+	struct btd_service *service = bt_bap_get_user_data(bap);
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct bass_delegator *dg;
 	GError *err = NULL;
 
+	DBG("%p", bap);
+
 	dg = queue_find(delegators, delegator_match_device, device);
 	if (!dg)
 		/* Only probe devices added via Broadcast Assistants */
-		return false;
+		return;
 
-	if (dg->service) {
+	if (dg->service)
 		/* Service has already been probed */
-		*ret = -EINVAL;
-		return true;
-	}
+		return;
 
 	dg->service = service;
-	dg->bap = bap_get_session(device);
+	dg->bap = bap;
 
 	dg->io = bt_io_listen(NULL, confirm_cb, dg,
 		NULL, &err,
@@ -593,11 +594,12 @@ bool bass_bcast_probe(struct btd_service *service, int *ret)
 		BT_IO_OPT_INVALID);
 	if (!dg->io) {
 		error("%s", err->message);
-		*ret = -err->code;
 		g_error_free(err);
+		return;
 	}
 
-	return true;
+	/* Take ownership for the service by setting the user data. */
+	btd_service_set_user_data(service, dg);
 }
 
 static void setup_free(void *data)
@@ -610,22 +612,23 @@ static void setup_free(void *data)
 	util_iov_free(setup->meta, 1);
 	util_iov_free(setup->config, 1);
 
-	if (setup->stream) {
-		uint8_t state = bt_bap_stream_get_state(setup->stream);
-
-		if (state == BT_BAP_STREAM_STATE_STREAMING)
-			bt_bass_clear_bis_sync(setup->dg->src,
-					stream_get_bis(setup->stream));
-	}
+	/* Clear bis index from the bis sync bitmask, if it
+	 * has been previously set.
+	 */
+	bt_bass_clear_bis_sync(setup->dg->src, setup->bis);
 }
 
-bool bass_bcast_remove(struct btd_device *device)
+static void bap_detached(struct bt_bap *bap, void *user_data)
 {
+	struct btd_service *service = bt_bap_get_user_data(bap);
+	struct btd_device *device = btd_service_get_device(service);
 	struct bass_delegator *dg;
 
+	DBG("%p", bap);
+
 	dg = queue_remove_if(delegators, delegator_match_device, device);
 	if (!dg)
-		return false;
+		return;
 
 	DBG("%p", dg);
 
@@ -657,7 +660,7 @@ bool bass_bcast_remove(struct btd_device *device)
 
 	free(dg);
 
-	return true;
+	btd_service_set_user_data(service, NULL);
 }
 
 static void assistant_set_state(struct bass_assistant *assistant,
@@ -1649,6 +1652,7 @@ static struct btd_profile bass_service = {
 };
 
 static unsigned int bass_id;
+static unsigned int bap_id;
 
 static int bass_init(void)
 {
@@ -1659,6 +1663,7 @@ static int bass_init(void)
 		return err;
 
 	bass_id = bt_bass_register(bass_attached, bass_detached, NULL);
+	bap_id = bt_bap_register(bap_attached, bap_detached, NULL);
 
 	return 0;
 }
@@ -1667,6 +1672,7 @@ static void bass_exit(void)
 {
 	btd_profile_unregister(&bass_service);
 	bt_bass_unregister(bass_id);
+	bt_bap_unregister(bap_id);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(bass, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 678532168..99b755259 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -3,7 +3,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright 2024 NXP
+ *  Copyright 2024-2025 NXP
  *
  */
 
@@ -12,9 +12,6 @@ void bass_add_stream(struct btd_device *device, struct iovec *meta,
 			uint8_t sgrp, uint8_t bis);
 void bass_remove_stream(struct btd_device *device);
 
-bool bass_bcast_probe(struct btd_service *service, int *ret);
-bool bass_bcast_remove(struct btd_device *device);
-
 typedef void (*bt_bass_bcode_func_t)(void *user_data, int err);
 
 void bass_req_bcode(struct bt_bap_stream *stream,
-- 
2.43.0

