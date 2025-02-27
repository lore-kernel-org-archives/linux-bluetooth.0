Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84826A1D9
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669495; cv=fail; b=GDO21Hmdmky0ot88JBrqHkfO4t12jJCAijhaJIjzyhf0jVohKlh43QgJ1lb40LOhhIEeBA+LORW9kYMf3SejjrnHF804OB2AqDbHHyQOftT8ezylLalCRkbonLj0MsQBNgPPJT+vdUp6vm9hWU71hbwBJuUDUaUnHQ7viNHtWfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669495; c=relaxed/simple;
	bh=6Q9blRxzuQRFXjbVRxdCmJFh/F2xutGGU40wxV29BH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CcEKEbNHSHRZrOmDDQnkFAr/NZTbI9rLwthKf3sO1KiJzFZcNxdN9XKu0di/eE3o+WHtWCTkTrlkvz6yy2EP6mB0M5+Gox7YoGenxwUneVS4hvfyefproV6bvXOzpPnnjgDYeNGn/jNlFiShiEllRa7Wbuf9uf5Va3CSHjY5Rgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hu+HtNgn; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hu+HtNgn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxUgyhZxNVw42+npp2RadHgK4+4YsHplj+7r2K320ZF8lsZMq339H1eaOMlTczTqTfxW3eNETj9xGmLNjM+jv83uzhGT0vF0S3OIfxwi495tq6NMsniHPhdSetVTXDzvFmoMtRTJttS4oGErJmmQR7QlA0HP57N20du006fV3gGXrM4ep8uXNXRK5qtsotr9oo9sPJcNeIfv8bI8xcxcjc4go3C6zKrKgsfH6kNZkzNu8jFwceyvKwnAVb7hwOJEO3wVMDqEE7+QRWQK/48Zv03PARW5iCjsCBSxyHTVLfqeFAvuR1fR7H/K1Z8m8HxpTFlF3dp/bpRg+Yujsgdb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ0AVM8JKUpqNCYOX5iNTUY+EgTXp85NrrBoIVJ97z4=;
 b=LJV211VpkL1iBmOLPVblS9zimHk02i+YNG2vlUfgERsW+Q90PTNK0eE9EPOW2ml8Q5RTNpmFUSxFgHdTC2ZgUFSk9DkOJOo2p9vwj6TlX08dH1wU1a1KfjU0nwkK8Kb9QYm002heqjXEibTWwDRpf+wLC5FU8JsAaFiM1yUXsrZJAkGD0kC2OYw8D1OGmOjd5ugzf8leHHBk2Nnapu9+bRt50FcLqU3S/LoGU9H9aEVZqypD8IWcLVyJz+Axj+lEXE9lYgIgqU5nd+P+QUqNUUsNSArkeS/rOeSL3ok0xnIMxpACXHLJhU9zBwQuWkYusJ9LIMZb44ycVmgCHnXFLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ0AVM8JKUpqNCYOX5iNTUY+EgTXp85NrrBoIVJ97z4=;
 b=Hu+HtNgnv+gpTvW1Xhc+qCFOVqEHDiA9+dABJajif2xwPNcnS3ypdDQ0vcHJ7S7nk6DLxh1PofV3Ymm1VFfm4R8L26Pip+sJBe66IE6/z8wXaj1GR3i2MAW42K+QyzbvBZ24g2LV4mz1hP79cdAPhlaHLU9kMLAQaQoGFbrjat3nWjIgkwvRR/2EO02tTfRmHu0XKY4XETQeuiMwHzQkWU1Hmov5DJ/qtRS4HdQMeMcfnGcWwrCbZdjRfWUep7GRQ33vfbeqD0kY7tFAYO3OBka7YOtXp7shbNokdJFPidCPFf7dbKcOAYP+ufOAuVYJibeCeUbRWGPYa/7wqlzzIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10918.eurprd04.prod.outlook.com (2603:10a6:150:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 15:18:09 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 15:18:09 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 2/3] bass: Create BASS session with Broadcasters
Date: Thu, 27 Feb 2025 17:17:55 +0200
Message-ID: <20250227151756.33772-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
References: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::48) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10918:EE_
X-MS-Office365-Filtering-Correlation-Id: e980a293-c9a9-423f-43c5-08dd5741f196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SChqJQkdM6hKsX2wp1iJxHkc13vnHZHle5hkx+j0iykrMddY8FPbYQr4/8Y4?=
 =?us-ascii?Q?41cwMnU22OCuykAjdaEgv+wu8aR2MTd86B9h461wOSrJxXK3IKzz4k7fFwYu?=
 =?us-ascii?Q?s5Zghn71kpGwx73Qv5IUfEK6ci8s9kPEcrRbK+SmPGfOJiqspZ2wA8S2Uf6g?=
 =?us-ascii?Q?xhp+uSHxKWkTz+5Wj02n+XL9qCZJHy6YUHsu3qsCbBBvhkFzxh6spGknYMTU?=
 =?us-ascii?Q?A2es6jkU9lK6B43KglSap1FS0Qjm0VKE4m/z199Y26pkiKxTydtB7HzCDWZH?=
 =?us-ascii?Q?mywt1YybdNQflfvYYDW5Ef89IeLMxslh7mU4Nq02Z7s//IBvvPGVf8QDhkPV?=
 =?us-ascii?Q?FSTk9HSJ2yHphh3ZknQDRhlEYv8Bc44ahtyX9RWQg6J10KsZqOLKyEF7OKms?=
 =?us-ascii?Q?c7w5fCzUIXv7qO9j41jbhIqs/jv0oqr6+WPx9qNwHv7tC0tfq1Uwwy9JOjLe?=
 =?us-ascii?Q?fU9NcZZmm3Y2yoZukj1FPJooo+AWeUyMPoDfj7XqTPDqmmx5fdf7phajRg/R?=
 =?us-ascii?Q?JRqsIKUsxKLtnKFespLvQXMm+BdJeuiazo2h+Wn1mad1IPWiRpjC50qvReMx?=
 =?us-ascii?Q?PWtfVjI8+avgD7mH8blW0GApiO/msrqi9YAx9E52CpnL50+3muYjjtDjqcEy?=
 =?us-ascii?Q?284Wu31JSMvfftYIWheG7QZvPILmSc8X7t8dfQFrjGMNjUCuCybNmoC69vRp?=
 =?us-ascii?Q?jB80on1rq77Rql48IY8/BcYNNVLgEIvh1pFxpipZ+FG2PyTY21Bd4wBOQ83F?=
 =?us-ascii?Q?0szETQkHp2s0FLhM4V1Y/EQmN2/14zjtjd5ua8vSS5r66J1HpWONO476Wve/?=
 =?us-ascii?Q?4HHz3V6YE5jm+eREl+b2k/4eCAL0iwhM+wvubdI31AppB/iGq31yMpnrSvhq?=
 =?us-ascii?Q?wBE2wGKPORWmof7jAWfMsQ+EXUqFPhJPWHDsCFuTqLUjTM5W41Td+bnkt9dL?=
 =?us-ascii?Q?TI6nV6pZVhvDE/8qiae3f0kJNvgzLu0xajzC5kB5fwNbuJW3001ZQQKFoRls?=
 =?us-ascii?Q?YRnZCWyq3JasQkdEblx+ap8nJd9piHH6MFyoH4Jougayl+9bofyIIOqN3iwQ?=
 =?us-ascii?Q?W/0r7T9wPeJxT5YaF/KAdly8fCCfnSDDeiCfLa5okf9angisesLWyD9k00ig?=
 =?us-ascii?Q?1LHSlhcVHAfulhcSr0rzW2L8rFHZxoOxDQ8e2DfNiQJMHEGMTnJfgkKyyVUi?=
 =?us-ascii?Q?606pCMBan0TAAH7OboaZ/ew/afVZTLECE8BumUD7kE7GlzH6z09ubsnYobX2?=
 =?us-ascii?Q?znB5yiM6WTOlaEIjlhTAHqnOtXJ09CRkSgBVjg3d3gEY/yZRepu6ViCDQIHa?=
 =?us-ascii?Q?9SeZDsLHRGDuAEp8oE5i3oOhVzyo0ru7UdbseuR82+W0463LWtLj8mXEeOwu?=
 =?us-ascii?Q?ngc+PswsqG6zQrnx+9/J6LxYfGCi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sPKIkuCIb42PFuR0XZPlM69VFPmIPw5raiOuMy3jSDKxUBM7n7jWpQQobfc?=
 =?us-ascii?Q?L35l1B0D0co/YQGrz7VPaMvl/ECdEVgtf+PhpKPr4xxQ8qrLLBDFHIUVoIN/?=
 =?us-ascii?Q?Br8WtyxmtF5VIev85sxclkJYFbYUa4Nrzb4dT6tn2dwNVyWoiEJOiJDCIW9I?=
 =?us-ascii?Q?w9de9CJqtfc+bxLLFccMzQqDbcvrMtym2yOYbaOToqeWkd1UtO49Ao342MOi?=
 =?us-ascii?Q?9w+AmxB/B6uOX/s6b24+90Lpw84VzUI0wv5YRTxXOTv8e01AmyJ6m8VVqeOY?=
 =?us-ascii?Q?ce0dar7PRDEomqjg65iBAyM7nbeP5xsXCJVGZt7yH4LQQTP4vkElUTuCIc2z?=
 =?us-ascii?Q?BJQBTW1Q4fsQvTNVHTudUv+0sTekPVjQXvAHfWAUgVvAUnMrM9akbKb4waYJ?=
 =?us-ascii?Q?z0EUBTD9DvSaHi0n5N0zqoBGiY11ij9ZHQEoJs1cTx12zsSvT8ms5UlxEr8W?=
 =?us-ascii?Q?IgV0W3ecFecX4cmJDXDp4y8gG+EDpWvAoye+ZPcWLb8bcgoK1CXRMgo19RNR?=
 =?us-ascii?Q?uOPIzh5xDsi8H5LAqW0G2uF3X/mzinMyIF85vhwdhEim0//nlLwLUUgq7+y2?=
 =?us-ascii?Q?U12/yVzWzSd5ZhPRd9yeUFFx1J+Lsc2oaxQDb+bDdPUfFjIFAioIA+72vTv8?=
 =?us-ascii?Q?xImfJhMuqt5Dm9vRKNXdopub7YPfyZNdbZmhVpLMB/JrScrOagi2uqP6i3GU?=
 =?us-ascii?Q?2YGN8abFtBQP+amLtmpy9m4UXgXocv+JV3dOetV2D9iEBcbpKOBCoxOcquQu?=
 =?us-ascii?Q?STS4ILlQXUp0PmCf5o+2wasq5udpIq+JgY567uIck2C/rMfn6gNxkjnOwfJV?=
 =?us-ascii?Q?W/CLcEiugysXSEjfpP7Iq45cYBGuUp0tRdBi8E3+N8aImsEIX6BFBqq2yMx8?=
 =?us-ascii?Q?fN6L63kRw9K3rAK/LM8jwd/8AZYS+PTMOJj68tmvDBzi0FgVCwwkOonxRB/G?=
 =?us-ascii?Q?dXXQSJsJlfpj2u4UuDfEeQMLe6bLeExgV7kDNR8pnJK5HI663zx8Tj+He+Hd?=
 =?us-ascii?Q?cwC/diPdU1q+s1seqPuc9IofDBMEfbjU/fsqJYfNdd8PwT/OwSEIbYFDplPf?=
 =?us-ascii?Q?hK1HohBYSmeEmoZNzOfaHW5yW33PpyRUYDAmX+8euyCi+m3cG142IA0FbYAG?=
 =?us-ascii?Q?yEIy1mknvZHZlJoLxq63EVjfBLMIjOlt4fEghjwYlAF179OBvzm1rYryKPat?=
 =?us-ascii?Q?Kb62K04P6HPKEPYizxBdUnUnWeSRUzTqYBArAliWY+0A5f4MSHI5ThCA28A4?=
 =?us-ascii?Q?LwD1JWmBI8lMo4JCjQh67Ksm3jdj7MMa6WyL4b8SayQI/EkaLMd6HvfmKAXv?=
 =?us-ascii?Q?7N+eCwoiJ/1m0CKN2do+StketMfHUCgEr2Nrib2y/ZQEPg1PQjjAqZrc5+YE?=
 =?us-ascii?Q?Hzt5oHr68BK9Ek5UWBSuWr0olJd7WE7EBZMUuhOB7SumbfTBOsU0FhfB0EG6?=
 =?us-ascii?Q?6yRnS5O7pcQmYakQMDHmDetVhrlI5/XupRL4T5xiIgNO8y0bke7YkLz7A82C?=
 =?us-ascii?Q?ka06SNaugTBpg0a8qISh4/uH8mfYsfh5G2aXqvQ1MOVvoPk4yDPxvhtr9+BA?=
 =?us-ascii?Q?dMAy1gM5WO+NbVSQap6cjm2jLqlMoSE5AO4dT3C+7OJ0tLMtm1QngdN7N/8K?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e980a293-c9a9-423f-43c5-08dd5741f196
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:18:09.5280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrHXp1OhH0pFpaQWuUPniXvcre5nxn+jXi/jcOX4uv5XBYvuhFsP4WrYr55tFyefbFnTtZ8Oo27Aj8HICXRVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10918

In the BASS plugin, BAP sessions created with scanned Broadcasters are
notified in the bap attached callback. This creates BASS data for these
devices as well, to internally keep information about the sessions.
---
 profiles/audio/bass.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 67ee847b8..96e767744 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -137,6 +137,10 @@ static struct queue *delegators;
 
 static const char *state2str(enum assistant_state state);
 
+static struct bass_data *bass_data_new(struct btd_device *device);
+static void bass_data_add(struct bass_data *data);
+static void bass_data_remove(struct bass_data *data);
+
 static void bass_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -560,9 +564,11 @@ static void confirm_cb(GIOChannel *io, void *user_data)
 static void bap_attached(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service;
+	struct btd_profile *p;
 	struct btd_device *device;
 	struct btd_adapter *adapter;
 	struct bass_delegator *dg;
+	struct bass_data *data;
 	GError *err = NULL;
 
 	DBG("%p", bap);
@@ -571,9 +577,22 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 	if (!service)
 		return;
 
+	p = btd_service_get_profile(service);
+	if (!p)
+		return;
+
+	/* Only handle sessions with Broadcast Sources */
+	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
+		return;
+
 	device = btd_service_get_device(service);
 	adapter = device_get_adapter(device);
 
+	/* Create BASS session with the Broadcast Source */
+	data = bass_data_new(device);
+
+	bass_data_add(data);
+
 	dg = queue_find(delegators, delegator_match_device, device);
 	if (!dg)
 		/* Only probe devices added via Broadcast Assistants */
@@ -625,11 +644,21 @@ static void setup_free(void *data)
 	bt_bass_clear_bis_sync(setup->dg->src, setup->bis);
 }
 
+static bool match_device(const void *data, const void *match_data)
+{
+	const struct bass_data *bdata = data;
+	const struct btd_device *device = match_data;
+
+	return bdata->device == device;
+}
+
 static void bap_detached(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service;
+	struct btd_profile *p;
 	struct btd_device *device;
 	struct bass_delegator *dg;
+	struct bass_data *data;
 
 	DBG("%p", bap);
 
@@ -637,8 +666,21 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	if (!service)
 		return;
 
+	p = btd_service_get_profile(service);
+	if (!p)
+		return;
+
+	/* Only handle sessions with Broadcast Sources */
+	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
+		return;
+
 	device = btd_service_get_device(service);
 
+	/* Remove BASS session with the Broadcast Source device */
+	data = queue_find(sessions, match_device, device);
+	if (data)
+		bass_data_remove(data);
+
 	dg = queue_remove_if(delegators, delegator_match_device, device);
 	if (!dg)
 		return;
-- 
2.43.0

