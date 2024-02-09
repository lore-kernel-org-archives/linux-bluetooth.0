Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEA86ACC
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497210; cv=fail; b=LVzi758m87oKz8DwIy4TEmHVFAPGY8xIxaEcdCl4Qxaev7MabL1SBhk9sCjXR81WrucvAgHDGfUY6IEwqnMBZw571a/0uxEVrVzWwRM1nZ/IvoZC/k1jwEpuhxgK3fgeomGNDrDKtrd2bKUJOWvjrZQYnAiLSUfM7dzkR8pcvh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497210; c=relaxed/simple;
	bh=9AgvRW9E9j/T0/niKnjjtAbJmFEM0i5AaSqgVjbj14k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ce8gRhS5pyS/T4siW6r1PO6ez6rIHCBZ0W+hgx84yHPZH1hT+NegSozxHc6Th3QQtUGjBPelGpK8IQW1rXtKyDXRDeDlPuNxVmwAUHypsXv1ZWKSZLGMMDcxByI7u93q7xlL60YziHkE/zTmxwmrVYZVuOegQreezTh5e5ejMGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XFvMAm/V; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XFvMAm/V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKQ63fZqOdsdV3+buI28CN5aNuHrCQhxqOTSSlV+apqOaOP9wlF7FU+xSQDPqoXP3jwW7qy5UODUBJsgVBJrlDkqp35PO6gnIUQbqkZf9XFXga8EsOsU/djZ/A4KoTXTGhFtVXcfjQM6a41f4qJwJb33ddDA1qguUcalex0N85r0g3To5wkfMFOSoiYBG1V0fsy+0tjvsy2ERlumLkOKM5zS0LlQwn1tLG4eIAafRkWa7kSB5cKPNJAEq4aBx5hjpZEoREv0IVQLzWkgACaU51bEpJL4GoarDB7u4vfFvKpsQ3C8kAyyOnC1QEnhD39LceTbr32u2A1X1DyJ8rnSwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYr688Ib2JVhhXeoAn7QdQJt1/iKVAu1wTwXXGrbKaM=;
 b=QzKDdGBWGd7ZeB/RqS2u0dFVXZqKnP+DzrrlGipy7JqMr+c+E/Z/e2+DvyugEO/1LH87ie3tYfdIFk7NoRytaxLyNVWItX1e3CpJxyTB4TysMr0ttAeHg1MSvuWk7xv12OMoaTUQi2J8MzEqAbkWRHOFKzwF2x9pWE3nS3/uvFP/bsx6J1L1RwIcQQTeHcDTrQqpbRGbhflbCjdVPXb24fWb90TFomDTOmkU6DTZtydA1CX+9374/CoBXiMFN1OyKUuffWjwmwBvjKUrqb1UQPOXY0XT21Yer1wGT610mweEgiA0iAONR4J+KCLMmA16+RzmMbZOJzNJJz1dLRtRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYr688Ib2JVhhXeoAn7QdQJt1/iKVAu1wTwXXGrbKaM=;
 b=XFvMAm/ViJzVTpm0DQlwyjEJKsc/TKxCAg8khRJLd1kpWeylIwL1WlLy3WFafTEIuha2E1hIWLcCWMQN9mfEx2hG39rNF9ecHYjZ2m/pA7KK5FMiiLXXDpHAXh8Oa1mIpnp5o6BTmXQ7+80EGonVDIe9VyfbuPI+wYq/UmJ1w/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 16:46:39 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 16:46:39 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v2 4/6] shared/bap: Add Broadcast QOS copy functions
Date: Fri,  9 Feb 2024 18:46:28 +0200
Message-Id: <20240209164630.92208-5-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0035.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::11) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 504cba22-e16a-4d0b-db41-08dc298eb029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rwtZk78GV2Kw3m1Zl7R5PDf1cWG2rGJRqBGEYHISwLIk596ByKBcFaRRHX7FpQQ3L0bRvEMOUZ5QNWbksDjW7iNZ2W/tlevVWYCICACsJv84M57KYGMfAOmULTe6pUzh+fB0NiZc+m5Lm4QaL9fD+d7olGj1yS0OnVsJScMuJUi6rfukyWeWasx/z59oa4+0m37n/BUDA/pGgfj7mx0PT3ghke/pXGw+MBmJKyUkvp76m8+nUcEC5RpkHCsMCjgKTxD9rbkQpCGmk/xP4k/mkAbgaSjHLYTxsi/UH2UJc3Bsh2Dij7d+VKWVkVoVKvjYQt+HKSDiSwI+EOy/UqyIbi5hsWzW01xMUfIZYhj5M/M5ovWD8s9Reb1ySqjQbx77ZOrp1SPymdZl0GBJBhxRw6VRawfqYGM3wlh04bYEH2wrkRqlKWvqDi7DryGlAk9g33MBlAzSA2Z2myIhsYlg4EuslSzcilR06SCFoLIl+6VpI7bo5L1bjY84+N62k8GN847J1NKIEGKW+6EMcDOLpN+luMSAkJrWrrWGFfeFKMtfu3MW8FBxbxxUo2P8uczk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4326008)(5660300002)(6916009)(66556008)(66946007)(8676002)(66476007)(8936002)(44832011)(2906002)(26005)(36756003)(86362001)(38100700002)(1076003)(6666004)(316002)(478600001)(41300700001)(6486002)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HTZFv1LARMNHBvT7jzhp4Hg7JsymRhYB4iiHB9O58zxTiEXOXJ86tcw5Dvs/?=
 =?us-ascii?Q?3sgfh2bYu7DpJKHirmsTTeRjHl+JCXcEhZsdWaTfp2VFkgjjDAWKSjd4r8nf?=
 =?us-ascii?Q?ol3kWskl2E67luCuKfVM6hzqLxrgUwAoIzz9A207AhYQhIrG5UwnJCLZrPhs?=
 =?us-ascii?Q?UWU58lX5eAUBtbm4G6dl6yG9mNgWzWhSOm02HVDVjdSdGVq0piEnBqsY0uQT?=
 =?us-ascii?Q?eyem43XTxSxT83RzJFnfD89k96oCIdrXHrmvecyWL0D/P2AHa3BLcztKuZsE?=
 =?us-ascii?Q?xoa+akPjuqeCmM6wD2hCXXDGRtte+vCTQJjBQx369T8TcVNVsbY4pyz8a4he?=
 =?us-ascii?Q?ItgxYpi/WUCQ5Yukvq7GWWdlpOgQcu/wVsjCxo6tOrCVeZrKqUL8+jsH0rI9?=
 =?us-ascii?Q?dXrbOYjFqs6hHc2AB9bGPBF46iy1Xpq29qUW3jr5ghdvOx/yuaP10reQj6pH?=
 =?us-ascii?Q?VHK0tsCZ69OxO4DiqQa1Zae6nq5/skPFUGDPEqZUz08czXe0qJnY8K7botSN?=
 =?us-ascii?Q?IOhtScera9TDzlrCIzqo1oOdrR4j4/6/H9jB0O8OCuCECDnjP+4G5+gEXRZS?=
 =?us-ascii?Q?IbXqFs3mc9614KNGgY0LkW1KlKOTj9QkCBtAcgXzM3w9tKUSq0EAQv98tEpT?=
 =?us-ascii?Q?U5S9Zn/kAA6iK3GTARWFnocrQmb0PuYgSDjkAY6lpX7ca4fuiOvC90KbS72m?=
 =?us-ascii?Q?dvgk2MsMI+lnMdDxxEKHqItTDYF89WjeSuo+kDKeodJyZaMPIwQME4v/SDBe?=
 =?us-ascii?Q?gqrCin7i4bEa3K96ZGBRbAMZ+GLK9vE0dXOK3JBA2+/AW8SjpOo6cL2I15lW?=
 =?us-ascii?Q?AyRSeSqW7BFvtcUcOmhgDWxHarTfT1koAO7vYkQNTis4xMqluu2ocWljo3q1?=
 =?us-ascii?Q?BwtyRLK5mEppTPU0tPpfTi7tfZE8Tr72ZZ8AUmKDzftcJUF55Zns8ykFElsW?=
 =?us-ascii?Q?dpsyD1ge1bSrCbwQtQ67VKbD16LToN/YcAX6Z9xGUEgRwCzRcIxEV85ywzLC?=
 =?us-ascii?Q?CwMEFbB5dEyNWVtqVC9GzwljQuTeEY1mjc7djPDPV/HkkItVWQjkKt7em3KN?=
 =?us-ascii?Q?ExMaK2hHAORQ6CJp2y7p4Y8sfCxqdhmW+Uk/7Q329KSyL1W+bFQwJzwxz7dv?=
 =?us-ascii?Q?aiqM9yn3B/i17KMIhcfonNJ4MstrL3lhNau+LBiJz+09oPQr2132T0ks8O+4?=
 =?us-ascii?Q?Z+jTY8aRgg2eN1b8+oGIenJIM2DoSUhTg/07lmmvlbmOMItPqgcFUt850yI6?=
 =?us-ascii?Q?zHr9wsbtlUnsvm8Z3mm/Rt3RCwYIaZ2VPSWtiOlf5brnuvPzXDjs5zLNpI3q?=
 =?us-ascii?Q?TNxeVufKD+DGDOsM7SyYif4f2YNme9/coU1pdJpjadqyakPSx8ax6U92tLj5?=
 =?us-ascii?Q?MDRf42sAg9ihw4TsUsfYNXB6BNg2eMTcrYhv8Ar640Vzw83qFqFuVBB6V8ya?=
 =?us-ascii?Q?6yrVkGQA4oQ5NibPyeqRWVYAaGqI5YqOyiMr3ZfXQJfABKAEBvRxQ8VGkLZw?=
 =?us-ascii?Q?+Ts4ZXV4MUEVgvRJf7PIRviYhWO0AcD9kcCriQ017wo464aKn4FP+NoRFoQJ?=
 =?us-ascii?Q?J1MOErUGUgQhv6oemRWrrkN53AA6hynAnY6/g8KAa3pjRJ7kN5Wd/5kP7EtR?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504cba22-e16a-4d0b-db41-08dc298eb029
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 16:46:39.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwvSnD360B+jO5ZyB2Qp/ZHzMTMacgtwpaEbS839PJitb76IvNSK6t5nccnrahtJxfM68I0Sn2on600QR+wV7YEH5q4wkkWnA7/1VSLL5rs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097

BAP works with bt_bap_qos structures and kernel with bt_iso_qos. These
functions are utilitary functions to allow jumping easily from one
structure to another.
---
 src/shared/bap.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index d205632b3c80..b88fc60842a3 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6527,3 +6527,47 @@ void bt_bap_parse_bis(void *data, void *user_data)
 	queue_foreach(subgroup->bises, bis_to_pac, subgroup);
 	cleanup_subgroup(subgroup);
 }
+
+void bt_bap_bcast_qos_iso_to_bap(struct bt_bap_qos *bap_qos,
+		struct bt_iso_qos *iso_qos)
+{
+	bap_qos->bcast.big = iso_qos->bcast.big;
+	bap_qos->bcast.bis = iso_qos->bcast.bis;
+	bap_qos->bcast.sync_factor = iso_qos->bcast.sync_factor;
+	bap_qos->bcast.packing = iso_qos->bcast.packing;
+	bap_qos->bcast.framing = iso_qos->bcast.framing;
+	bap_qos->bcast.encryption = iso_qos->bcast.encryption;
+	if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
+		memcpy(bap_qos->bcast.bcode->iov_base, iso_qos->bcast.bcode,
+				bap_qos->bcast.bcode->iov_len);
+	bap_qos->bcast.options = iso_qos->bcast.options;
+	bap_qos->bcast.skip = iso_qos->bcast.skip;
+	bap_qos->bcast.sync_timeout = iso_qos->bcast.sync_timeout;
+	bap_qos->bcast.sync_cte_type = iso_qos->bcast.sync_cte_type;
+	bap_qos->bcast.mse = iso_qos->bcast.mse;
+	bap_qos->bcast.timeout = iso_qos->bcast.timeout;
+	memcpy(&bap_qos->bcast.io_qos, &iso_qos->bcast.out,
+			sizeof(struct bt_iso_io_qos));
+}
+
+void bt_bap_bcast_qos_bap_to_iso(struct bt_iso_qos *iso_qos,
+		struct bt_bap_qos *bap_qos)
+{
+	iso_qos->bcast.big = bap_qos->bcast.big;
+	iso_qos->bcast.bis = bap_qos->bcast.bis;
+	iso_qos->bcast.sync_factor = bap_qos->bcast.sync_factor;
+	iso_qos->bcast.packing = bap_qos->bcast.packing;
+	iso_qos->bcast.framing = bap_qos->bcast.framing;
+	iso_qos->bcast.encryption = bap_qos->bcast.encryption;
+	if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
+		memcpy(iso_qos->bcast.bcode, bap_qos->bcast.bcode->iov_base,
+				bap_qos->bcast.bcode->iov_len);
+	iso_qos->bcast.options = bap_qos->bcast.options;
+	iso_qos->bcast.skip = bap_qos->bcast.skip;
+	iso_qos->bcast.sync_timeout = bap_qos->bcast.sync_timeout;
+	iso_qos->bcast.sync_cte_type = bap_qos->bcast.sync_cte_type;
+	iso_qos->bcast.mse = bap_qos->bcast.mse;
+	iso_qos->bcast.timeout = bap_qos->bcast.timeout;
+	memcpy(&iso_qos->bcast.out, &bap_qos->bcast.io_qos,
+			sizeof(struct bt_iso_io_qos));
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index aed3bf52b8d9..968257651766 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -354,4 +354,8 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
 bool bt_bap_parse_base(struct bt_bap *bap, void *data, size_t len,
 		util_debug_func_t func, struct bt_bap_base *base);
 void bt_bap_parse_bis(void *data, void *user_data);
+void bt_bap_bcast_qos_iso_to_bap(struct bt_bap_qos *bap_qos,
+		struct bt_iso_qos *iso_qos);
+void bt_bap_bcast_qos_bap_to_iso(struct bt_iso_qos *iso_qos,
+		struct bt_bap_qos *bap_qos);
 
-- 
2.40.1

