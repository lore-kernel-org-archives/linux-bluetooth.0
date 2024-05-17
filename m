Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FB43AA0
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715949325; cv=fail; b=Dq6PyY57ElL3ZEBzMjBzDiA84RkZiCxmN7cVHoYQFXVbBVxbwedlXmIFs2TJ0Xom11nf7sMKSdiOlii6V4YQR/b3WihDLANtp8i9NgJTfr25XlSwOHOzcK6OuNI8Lo1ya777+TwlmWdgzOYgFLWdmKvYATTDtTOhyt4v7qqglkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715949325; c=relaxed/simple;
	bh=qsduHTIPafhfsSPZixQ8D4RTNS7IanUBnbN6wVuOUCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KId7hf8llkLkrV34jPC2TqWOiZQclhaLWndEvGI4U6rjV+5BMyFkgnuWAB9L/x7XhbvxeYmrpntv8c5btGAXSEstmxZHXa2Ltvi8KVc7Hu9o2y2fxRwtjyoMxKK/aUwZVn2uenwcbF6XO4MjEPG5uOwxQLrn/P/OW5lNJH4fP9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=h4nh61m/; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h4nh61m/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHx8vVVLnwBXI5gM2svEyBccpd/Zlc7jJ5n0jNJvjfejgyRdznMR+PXSSWe1vOnevFNJR708I5PPRxfR/pVSWQko8cEjOf6LfrYx/8S4LTs7/nRIEa2mNJUs3AGG7E0bBrsnwBjDv9Qj9cW00UL0CBX48N2h1shTivAtFWjdKWr5QsMROyZToVng+NGCN47CPv2XxmVLP4NxCVonvNxdEDlL6gsrxgPM2uotvLCFn+80UqJq8VV0zQYv/Ed6WwIp/6W4SHgLd/UgdYkBfMXirwS4/vM5hL/d1fSzFb6RXgKhXmaXHX57adt6xhsy3s0TRdmJRC7vnJC6jUt/bBDyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IK3ze+fdUYY+y8nwfj8lJScMtXPNbliKupOdYk/Lbw=;
 b=E9RbE+fzGuozQH8Uv52cL/y2q70qfDPTXSQnJFL+EWuKnY8uHAs+lHDt3tv8mtHNBh+7coSHtcbKBN/gD5ds+Id1UB9X6AKKda/iSBpPXIbncOsLlyL2IFEu8khs/rXlAEEr+G4rIjeqm7Q7ZbXlElEpblQYmdh8F+zO2GtTs/JA++vs9GuMtGc1KGYl0Bn1AZzAXxA3e0hlE0Omj2fDSI0HzPsEsTVQ+nZBCPetIxw/s76ewCKGCSwoH4bwXURA9i2bAefQahDJrhNA9vFukY4pD+nOTMPNqyQJsylseQrQBFwOtv8nEisIWiNldZPjWbHoUP8tFCveXUVTm7KVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IK3ze+fdUYY+y8nwfj8lJScMtXPNbliKupOdYk/Lbw=;
 b=h4nh61m/LALF8omH68O2BjftUerCOAbjDPEKsOfCSxkT5DRP/5R+hXxmsVrULo0zmntVI/F51EdiarHJYZJlT9hNNJDine2W4zftSKLayqYoKt/y4XxuaWavkXBjDTPQNURunJBHQfC3PQhAgPhQwm29QTJNW4RlbWEzsluHwkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB8362.eurprd04.prod.outlook.com (2603:10a6:10:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 12:35:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 12:35:20 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/5] test-bap: Make test_bsrc generic
Date: Fri, 17 May 2024 15:34:35 +0300
Message-Id: <20240517123436.146332-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
References: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 333345af-bad6-4514-86b8-08dc766dd075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MAh+ZTeR7IV6BDHok3c2vLSm7zu8y3dkWPM/MAVolOYLB9vnoXybmn0JVzqP?=
 =?us-ascii?Q?I56E56+d6uMHTWtvCfeQQlT5NIhKk37aFqqpU8LCDNJ24x9pTCsQV/u0jhdb?=
 =?us-ascii?Q?aTfv/lKaTa1NNgg7KcXBk1dQLufPV+UEbMcXdH7FbIFyxVSxwTW0m+plTFT0?=
 =?us-ascii?Q?gR+/Rd1PKQPzd/ewQWllq9glfVWkD8Qw6D29IYswKzDxzDcxnEtx2v8wXVqu?=
 =?us-ascii?Q?zKIanB13UPHvHLgXn249gydOk3OWHJS3BjNMqkALy6gL7bHnpy56zdVJjiwp?=
 =?us-ascii?Q?kwViTK77HigGCUGpNbweSTAq8el9flSdSp79zojVRgG8DywTHr1Whp36nsZq?=
 =?us-ascii?Q?6D/Kh5XXm57qJzNmljxf1DMkQkqZ/sJB1aLTMfv2ISo84NHtMo74zEcpEPRw?=
 =?us-ascii?Q?9/cgB9uE1NI97S3XDrqOzAU7k0CBND2EXjQPzFpZAYGfEXGEsAFg0M0lNGKD?=
 =?us-ascii?Q?LEU8ntvcy1jcPX3a/mbBdcK7qon8pPzuwq3ERJfiAHXufygiM2WtkTveAson?=
 =?us-ascii?Q?BlVmcrWv5TNyyXe6UncdEfUwFABxhN3JPRDPwIl146K7rZzzgiRa4lMx0IKe?=
 =?us-ascii?Q?+WKQj2ZwYcjve12dRAJAQwVB6ihj32SsgqmR67792iNNS4KFOVEc2Owmwjaj?=
 =?us-ascii?Q?MmNHvzgCOWzKWYDG6uVaSG1NuMZOQwHcpGIr38bUaTWoNIHAYMREPH31Ls50?=
 =?us-ascii?Q?zp/BbHddXYWE29Gm9lJHF06pS+wAB4l2TFxxVDaRCseFkxdXTjUmhBCqr5rm?=
 =?us-ascii?Q?/6s/WqsZWb5CUHD0jjGJkEGYuunr+2enNjyf3V92rV/2ODg0xIm1wWYUCNn5?=
 =?us-ascii?Q?E1e0n+xb9teH3vJWophL/FsiCeeDVPEpvQTmGBFU0L+oV1yjjc56uhnqhuzn?=
 =?us-ascii?Q?2/5BjJeGuSUDRiEIeUvs2GDuKuJCuimJyKj+Jk5E41th7E76LrPunaiujev0?=
 =?us-ascii?Q?7bGN6GoPZwwqoodsQ4D9GxwdWPQnmr2Ga5m1kS8UyCgepdXe9lxf7Qq190Ev?=
 =?us-ascii?Q?e+NoEZLmiW3bnwoJFXA44iiRVsiim4s2DDWSBLd2he3IFfUdo8Vn4bBCC1PN?=
 =?us-ascii?Q?LA+snSbY6SZRO2reb8GpV4AKKQl7q75yG/pZCsPDiIJ1LjEm25yB9Zr6UDMC?=
 =?us-ascii?Q?evb2/bGzNs8205T5CgIpa9wl3Rs69G4ERFoEtELmqoPuSmoD4x9r+OLiYljZ?=
 =?us-ascii?Q?wkU7XWe7iPEBpozMB7+v8Nqt/M8fXjSENGs0iQ69XbNtL7/GgkhvxwuO3FGB?=
 =?us-ascii?Q?Qs+8+CD0GSDW5foyksDijn6IQkDaTaVgYSvYAOnL7g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZPWVcs4z12IX1HdAMfNIjolCQn0Ti4oyDURwhPXSpu8P1rZ1WeRBZQfUGLqw?=
 =?us-ascii?Q?/6UjB0lbd/w2EEX42KQpWuTy/hw1bufUYRtwryWpEPCsVdXVup9hThQwvUHD?=
 =?us-ascii?Q?SLYmuHy9lOIasXsukOKpfrTAX0XMeyjZMWVQmtIG4lcjWXvT/tVdeic0Nn8y?=
 =?us-ascii?Q?TNFzzjW1J+OKQsqElVSl077rHwDp9iTbaIzxRQuvbYDSpQJ/dYqTl5SKPNnx?=
 =?us-ascii?Q?idBiWov1aQforLcyoFhfFGlVoopsnMWg2YVzW5SdaQG7zm38jaJXtjiP4u97?=
 =?us-ascii?Q?lghTQknsf3KmI875zHaiLQ3WoUBJnItzX7JL26sEfRSu0h+/yHo/++8jEpQQ?=
 =?us-ascii?Q?2KB4sCszx31vEeIhKJRzJS6kX82Bgfs759wiQIRckhcy8+fxKkv1i4r25cdt?=
 =?us-ascii?Q?Xw57lqPE64+MzOTUqTHLHHFy5Ti4Y7+LFKW9U+bidxpDj8AA+p2k/afmIyMV?=
 =?us-ascii?Q?pGSGiKvmnjzqc3UeQyYd1R4uqgs+lcEhZpaJuxTH+MEXQN0gHIW2wm6e251/?=
 =?us-ascii?Q?cQAeFoecCSv+FExtXHcipSRLdKa5NEHo45EppD8UgHJcax+7RQuBIiXCQa5u?=
 =?us-ascii?Q?h7NVYrceETiAtXV6mfz8nAXnIPzVevi2fwfnyEK72QclUzRDJ//9bbu8YqQv?=
 =?us-ascii?Q?6n7gE1z5skUv79y1PgEj8gA65pj21FLnQ3a9YoZ9kkxWlCeBr13dRXKoTp5N?=
 =?us-ascii?Q?E7ZfLv+bp4XL0rtxiVoUvqeilNvqmm6JOrX3zv+Jz7NqRD2fqymd1t7dthli?=
 =?us-ascii?Q?LMwA60BSnQepXRpwgker9dZrcr3XXxFqLEGdJy56SA1Up/5twKcSOODuK+EU?=
 =?us-ascii?Q?952cOY+zCd6CTDVI7otBaYHnLAnoTytwm9YYJmBDBYEjihd8VUiOzKyexzdB?=
 =?us-ascii?Q?haIMJKdqIoTgRa4ZLfsaH+T9aZS5B37QoNAYiqv58eJc1jVvLXHJROKXaNrV?=
 =?us-ascii?Q?SKkIFuU8EPwtQ03ZVziChL/SBS8n0r8roAzbxv+7bV81TaFzt4bDK0uoGB/p?=
 =?us-ascii?Q?N35WpxFSy3TabRF0AMOMf3w3uN/7TJ+Xchmnl9hX8/xBrRA1R5ZPfw/od2EC?=
 =?us-ascii?Q?dgs6q18x7cs6n0YTZXVIU8L1eESndRjwaA2G574jdUhDSjucHT0o4NYYDNUC?=
 =?us-ascii?Q?cs+8fW//PEEfSgua0L5B80y4yW01cR1UpW1sKl4h027SbXFtmaccSACwcpBC?=
 =?us-ascii?Q?I8uzLGSEDOA0XYiK74Z5FX51VJ21WmzmNXnSVMrzfBPCLVGxh48Qb8IvPCVg?=
 =?us-ascii?Q?pClIEtgOfie9UwED3oyWtfFX5Wuh/2I0Yl4ybl6iJhmfsIyPNiBv+zGUSHgQ?=
 =?us-ascii?Q?rbHGk8ileiZ/y/IpSPC9+NAyYjqmcH/9c0Iao6W60HduxI7Iio7hAZCgNz7A?=
 =?us-ascii?Q?q5sNE8Vdx88S8/zwZwus8A7RTpHO9jf2M3izqkC5bY7p3hTcv7SbAri8iWNA?=
 =?us-ascii?Q?wmIoDW7eRDwzBV0BYCsjH5Nyox15klYzCX+FAeBvVoILbKVMksljrK0u31+B?=
 =?us-ascii?Q?msTSuPYWyzpOOj0xiiCJ9JQmcWgfWPHYaeBhdO7UDfn/JxkDOKTSD4//9wp3?=
 =?us-ascii?Q?IE+w19YMJCvrWt+QZcYOcFEZZaJY8Knad4Q1jVD/Vu0OX1FTF91xvGLKY44t?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 333345af-bad6-4514-86b8-08dc766dd075
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:35:20.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2es0J+k2C0oDEWErc/OYYNdpRo24M1TE9wwgLRh5aXmwH0zTC7mNCdE2iloBOoXrAWYBK7y1dwO1p+wWnmWspg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8362

This makes test_bsrc more generic, to accommodate Broadcast Sink tests
as well, following the unicast design for handling source/sink
configurations.
---
 unit/test-bap.c | 182 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 131 insertions(+), 51 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index e930ca604..a6e24e605 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -565,7 +565,34 @@ static void bsrc_state(struct bt_bap_stream *stream, uint8_t old_state,
 	}
 }
 
-static void test_bsrc(const void *user_data)
+static void test_bcast_config(struct test_data *data)
+{
+	if (!data->cfg)
+		return;
+
+	if (data->cfg->src) {
+		bt_bap_pac_register(data->bap, bsrc_pac_added,
+						NULL, data, NULL);
+
+		if (data->cfg->vs)
+			data->bsrc = bt_bap_add_vendor_pac(data->db,
+							"test-bap-bsrc",
+							BT_BAP_BCAST_SOURCE,
+							0x0ff, 0x0000, 0x0000,
+							NULL, data->caps,
+							NULL);
+		else
+			data->bsrc = bt_bap_add_pac(data->db, "test-bap-bsrc",
+							BT_BAP_BCAST_SOURCE,
+							LC3_ID,
+							NULL, data->caps,
+							NULL);
+
+		g_assert(data->bsrc);
+	}
+}
+
+static void test_bcast(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
 
@@ -579,24 +606,11 @@ static void test_bsrc(const void *user_data)
 
 	bt_bap_attach_broadcast(data->bap);
 
-	bt_bap_state_register(data->bap, bsrc_state,
-					NULL, data, NULL);
-
-	bt_bap_pac_register(data->bap, bsrc_pac_added,
-					NULL, data, NULL);
-
-	if (data->cfg->vs)
-		data->bsrc = bt_bap_add_vendor_pac(data->db,
-						"test-bap-bsrc",
-						BT_BAP_BCAST_SOURCE, 0x0ff,
-						0x0000, 0x0000,
-						NULL, data->caps, NULL);
-	else
-		data->bsrc = bt_bap_add_pac(data->db, "test-bap-bsrc",
-						BT_BAP_BCAST_SOURCE, LC3_ID,
-						NULL, data->caps, NULL);
+	if (data->cfg && data->cfg->state_func)
+		bt_bap_state_register(data->bap, data->cfg->state_func, NULL,
+						data, NULL);
 
-	g_assert(data->bsrc);
+	test_bcast_config(data);
 }
 
 static void test_teardown(const void *user_data)
@@ -5501,12 +5515,16 @@ static struct test_config cfg_bsrc_8_1_1 = {
 	.cc = LC3_CONFIG_8_1,
 	.qos = LC3_QOS_8_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_8_1_2 = {
 	.cc = LC3_CONFIG_8_1,
 	.qos = LC3_QOS_8_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_8_2 \
@@ -5521,12 +5539,16 @@ static struct test_config cfg_bsrc_8_2_1 = {
 	.cc = LC3_CONFIG_8_2,
 	.qos = LC3_QOS_8_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_8_2_2 = {
 	.cc = LC3_CONFIG_8_2,
 	.qos = LC3_QOS_8_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_16_1 \
@@ -5541,12 +5563,16 @@ static struct test_config cfg_bsrc_16_1_1 = {
 	.cc = LC3_CONFIG_16_1,
 	.qos = LC3_QOS_16_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_16_1_2 = {
 	.cc = LC3_CONFIG_16_1,
 	.qos = LC3_QOS_16_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_16_2 \
@@ -5561,12 +5587,16 @@ static struct test_config cfg_bsrc_16_2_1 = {
 	.cc = LC3_CONFIG_16_2,
 	.qos = LC3_QOS_16_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_16_2_2 = {
 	.cc = LC3_CONFIG_16_2,
 	.qos = LC3_QOS_16_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_24_1 \
@@ -5581,12 +5611,16 @@ static struct test_config cfg_bsrc_24_1_1 = {
 	.cc = LC3_CONFIG_24_1,
 	.qos = LC3_QOS_24_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_24_1_2 = {
 	.cc = LC3_CONFIG_24_1,
 	.qos = LC3_QOS_24_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_24_2 \
@@ -5601,12 +5635,16 @@ static struct test_config cfg_bsrc_24_2_1 = {
 	.cc = LC3_CONFIG_24_2,
 	.qos = LC3_QOS_24_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_24_2_2 = {
 	.cc = LC3_CONFIG_24_2,
 	.qos = LC3_QOS_24_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_32_1 \
@@ -5621,12 +5659,16 @@ static struct test_config cfg_bsrc_32_1_1 = {
 	.cc = LC3_CONFIG_32_1,
 	.qos = LC3_QOS_32_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_32_1_2 = {
 	.cc = LC3_CONFIG_32_1,
 	.qos = LC3_QOS_32_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_32_2 \
@@ -5641,12 +5683,16 @@ static struct test_config cfg_bsrc_32_2_1 = {
 	.cc = LC3_CONFIG_32_2,
 	.qos = LC3_QOS_32_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_32_2_2 = {
 	.cc = LC3_CONFIG_32_2,
 	.qos = LC3_QOS_32_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_44_1 \
@@ -5661,12 +5707,16 @@ static struct test_config cfg_bsrc_44_1_1 = {
 	.cc = LC3_CONFIG_44_1,
 	.qos = LC3_QOS_44_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_44_1_2 = {
 	.cc = LC3_CONFIG_44_1,
 	.qos = LC3_QOS_44_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_44_2 \
@@ -5681,12 +5731,16 @@ static struct test_config cfg_bsrc_44_2_1 = {
 	.cc = LC3_CONFIG_44_2,
 	.qos = LC3_QOS_44_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_44_2_2 = {
 	.cc = LC3_CONFIG_44_2,
 	.qos = LC3_QOS_44_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_48_1 \
@@ -5701,12 +5755,16 @@ static struct test_config cfg_bsrc_48_1_1 = {
 	.cc = LC3_CONFIG_48_1,
 	.qos = LC3_QOS_48_1_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_48_1_2 = {
 	.cc = LC3_CONFIG_48_1,
 	.qos = LC3_QOS_48_1_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_48_2 \
@@ -5721,12 +5779,16 @@ static struct test_config cfg_bsrc_48_2_1 = {
 	.cc = LC3_CONFIG_48_2,
 	.qos = LC3_QOS_48_2_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_48_2_2 = {
 	.cc = LC3_CONFIG_48_2,
 	.qos = LC3_QOS_48_2_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_48_3 \
@@ -5741,12 +5803,16 @@ static struct test_config cfg_bsrc_48_3_1 = {
 	.cc = LC3_CONFIG_48_3,
 	.qos = LC3_QOS_48_3_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_48_3_2 = {
 	.cc = LC3_CONFIG_48_3,
 	.qos = LC3_QOS_48_3_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_48_4 \
@@ -5761,12 +5827,16 @@ static struct test_config cfg_bsrc_48_4_1 = {
 	.cc = LC3_CONFIG_48_4,
 	.qos = LC3_QOS_48_4_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_48_4_2 = {
 	.cc = LC3_CONFIG_48_4,
 	.qos = LC3_QOS_48_4_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_48_5 \
@@ -5781,12 +5851,16 @@ static struct test_config cfg_bsrc_48_5_1 = {
 	.cc = LC3_CONFIG_48_5,
 	.qos = LC3_QOS_48_5_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_48_5_2 = {
 	.cc = LC3_CONFIG_48_5,
 	.qos = LC3_QOS_48_5_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define LC3_CFG_48_6 \
@@ -5801,12 +5875,16 @@ static struct test_config cfg_bsrc_48_6_1 = {
 	.cc = LC3_CONFIG_48_6,
 	.qos = LC3_QOS_48_6_1_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 static struct test_config cfg_bsrc_48_6_2 = {
 	.cc = LC3_CONFIG_48_6,
 	.qos = LC3_QOS_48_6_2_B,
 	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 #define VS_CC \
@@ -5841,6 +5919,8 @@ static struct test_config cfg_bsrc_vs = {
 	.qos = QOS_BCAST,
 	.base = UTIL_IOV_INIT(BASE_VS),
 	.vs = true,
+	.src = true,
+	.state_func = bsrc_state,
 };
 
 /* Test Purpose:
@@ -5866,103 +5946,103 @@ static struct test_config cfg_bsrc_vs = {
 static void test_bsrc_scc(void)
 {
 	define_test("BAP/BSRC/SCC/BV-01-C [Config Broadcast, LC3 8_1_1]",
-		NULL, test_bsrc, &cfg_bsrc_8_1_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_8_1_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-02-C [Config Broadcast, LC3 8_2_1]",
-		NULL, test_bsrc, &cfg_bsrc_8_2_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_8_2_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-03-C [Config Broadcast, LC3 16_1_1]",
-		NULL, test_bsrc, &cfg_bsrc_16_1_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_16_1_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-04-C [Config Broadcast, LC3 16_2_1]",
-		NULL, test_bsrc, &cfg_bsrc_16_2_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_16_2_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-05-C [Config Broadcast, LC3 24_1_1]",
-		NULL, test_bsrc, &cfg_bsrc_24_1_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_24_1_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-06-C [Config Broadcast, LC3 24_2_1]",
-		NULL, test_bsrc, &cfg_bsrc_24_2_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_24_2_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-07-C [Config Broadcast, LC3 32_1_1]",
-		NULL, test_bsrc, &cfg_bsrc_32_1_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_32_1_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-08-C [Config Broadcast, LC3 32_2_1]",
-		NULL, test_bsrc, &cfg_bsrc_32_2_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_32_2_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-09-C [Config Broadcast, LC3 44.1_1_1]",
-		NULL, test_bsrc, &cfg_bsrc_44_1_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_44_1_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-10-C [Config Broadcast, LC3 44.1_2_1]",
-		NULL, test_bsrc, &cfg_bsrc_44_2_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_44_2_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-11-C [Config Broadcast, LC3 48_1_1]",
-		NULL, test_bsrc, &cfg_bsrc_48_1_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_1_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-12-C [Config Broadcast, LC3 48_2_1]",
-		NULL, test_bsrc, &cfg_bsrc_48_2_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_2_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-13-C [Config Broadcast, LC3 48_3_1]",
-		NULL, test_bsrc, &cfg_bsrc_48_3_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_3_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-14-C [Config Broadcast, LC3 48_4_1]",
-		NULL, test_bsrc, &cfg_bsrc_48_4_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_4_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-15-C [Config Broadcast, LC3 48_5_1]",
-		NULL, test_bsrc, &cfg_bsrc_48_5_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_5_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-16-C [Config Broadcast, LC3 48_6_1]",
-		NULL, test_bsrc, &cfg_bsrc_48_6_1, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_6_1, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-17-C [Config Broadcast, LC3 8_1_2]",
-		NULL, test_bsrc, &cfg_bsrc_8_1_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_8_1_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-18-C [Config Broadcast, LC3 8_2_2]",
-		NULL, test_bsrc, &cfg_bsrc_8_2_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_8_2_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-19-C [Config Broadcast, LC3 16_1_2]",
-		NULL, test_bsrc, &cfg_bsrc_16_1_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_16_1_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-20-C [Config Broadcast, LC3 16_2_2]",
-		NULL, test_bsrc, &cfg_bsrc_16_2_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_16_2_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-21-C [Config Broadcast, LC3 24_1_2]",
-		NULL, test_bsrc, &cfg_bsrc_24_1_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_24_1_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-22-C [Config Broadcast, LC3 24_2_2]",
-		NULL, test_bsrc, &cfg_bsrc_24_2_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_24_2_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-23-C [Config Broadcast, LC3 32_1_2]",
-		NULL, test_bsrc, &cfg_bsrc_32_1_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_32_1_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-24-C [Config Broadcast, LC3 32_2_2]",
-		NULL, test_bsrc, &cfg_bsrc_32_2_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_32_2_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-25-C [Config Broadcast, LC3 44.1_1_2]",
-		NULL, test_bsrc, &cfg_bsrc_44_1_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_44_1_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-26-C [Config Broadcast, LC3 44.1_2_2]",
-		NULL, test_bsrc, &cfg_bsrc_44_2_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_44_2_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-27-C [Config Broadcast, LC3 48_1_2]",
-		NULL, test_bsrc, &cfg_bsrc_48_1_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_1_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-28-C [Config Broadcast, LC3 48_2_2]",
-		NULL, test_bsrc, &cfg_bsrc_48_2_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_2_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-29-C [Config Broadcast, LC3 48_3_2]",
-		NULL, test_bsrc, &cfg_bsrc_48_3_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_3_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-30-C [Config Broadcast, LC3 48_4_2]",
-		NULL, test_bsrc, &cfg_bsrc_48_4_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_4_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-31-C [Config Broadcast, LC3 48_5_2]",
-		NULL, test_bsrc, &cfg_bsrc_48_5_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_5_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-32-C [Config Broadcast, LC3 48_6_2]",
-		NULL, test_bsrc, &cfg_bsrc_48_6_2, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_48_6_2, IOV_NULL);
 
 	define_test("BAP/BSRC/SCC/BV-33-C [Config Broadcast, VS]",
-		NULL, test_bsrc, &cfg_bsrc_vs, IOV_NULL);
+		NULL, test_bcast, &cfg_bsrc_vs, IOV_NULL);
 }
 
 int main(int argc, char *argv[])
-- 
2.39.2

