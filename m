Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E3E157E88
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098382; cv=fail; b=SrJRgS7uGlrY0ZZoTsX+nEDRg7Bs6/H99Zx05fqiUjbZEBwl/RuwYLNBF+aeA2yJHRqMHZ36q/ArBjtoJA9sZAr0pHM5wUW9A6xCzeEZc8kZi9bhydu9Qrj2UrcBI/oYoWTgVwWi7jl12EhgUxuu7mfcAsgwFl3l26ZpY6HR89g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098382; c=relaxed/simple;
	bh=KidKvvt6/wVblEHSD+dcLeJienp4+/2xBXj+i3osNkM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rIUHDfTIGFe2DC9k04tTppMVZbc0RouRbGAjU6AiRKbvDfihOEwm6T2tp7tCBHgRX88IhEPrxy6jzJEjScvhZhetk2aQQ5G15CjjJFfkUyeCwjq8xm6VM0SvvrS70T6rf8x9/BebbO3P0d+/D/ctDhPOHZJv6Iv4/YkfWq7c8n0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ISoS0A/Y; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ISoS0A/Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnLHo+gZfr+RIOmc0MMe2ZHN7fer1CF+2x9D2k1t3/vpCEh3ksNZQHhX0wl7D/Dk2Sl1aYm2Kf9PEcAVdiETqeNFQgPfPlupsZFDwRXz5iDHP+6/mQknmsEqVXq+beVPZy3cG/zrtl+52IUj70LPlf5YgNktqGeYAEowwJkdv/PTQJFyfoVhJbHekvnLAI/MbKIq9Bmzh0xenpnIcT1t2O8KIsYzW79h2TkhYUdT+viD5g1miLBX6raip/Su60/P3VnYlfeMBAONNmZrre3Gs0ouLRfwolflY0b/GGOaE4s9g7GiMf4W7VyG//bhG6IVX08/uAorCVwQMxSRSXnehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfSULfrGF+C4ghiagShBghYhVIJVq6Ml5mX3GyRXNWg=;
 b=CtvfmskwwcJNnxoHSKtLqXpm8zd/aExCEw0I/lQMOh6hXMPkglQi9auJIDj1ozTT6CXuFuHZOhjPJ+966xI3M42iuxuGzLpF7TXMMiz4tfVJ/tL+G98h8eZ5jqOLHIgmYozthAvsLlAlDUCnbVCXKQp4fjEQdjQK+10shEYC/kpdMTvvX/VKVf2khXkRjMrFledfw2AKvEM1zZAK9MYgq1sokaNqM2S7/Rlj24AdrE0cQqks3AzzpvA0BB28ObO70yjy/gvq6zobKmOlrAO38qg0pt2nmMNykbxgcfzm6iveWEWuVIoogO3jgMSA8OObUVQLV5ZtvcixQQQVNnIebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfSULfrGF+C4ghiagShBghYhVIJVq6Ml5mX3GyRXNWg=;
 b=ISoS0A/YgAPQX1frk1aIYEN1eoavy0UNxRCp+faF5BQ30lUkc5gIvusHtkxoULrSlgQPHhnKEfUM8rQYpyM/9itW/TTi7BlS5SkXxtV4APRbY1ri27JFFC8c+a4TivTEIdXEmmSa9CE6yPahOSPLKhraJL3nMXr4zchzjQ/RmrPRiLLbbWegXBCJSZ2bdYIzEgIs/4J6qaXW+Kc2k3aqbSD/5TDYHwm3m+6+S/cEr45sczUQO3K6ehi0shLU0mkO4ltpph4crhlInJ/kMoANKaVxbfw8X1Gb6TJWaW7DsAjIxnCSgPW9MfBGTR3LUalrLoevWL01U/Rrtu/ofoezKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8904.eurprd04.prod.outlook.com (2603:10a6:10:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 10:26:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:26:12 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/7] bass: Rework Scan Delegator
Date: Wed, 20 Nov 2024 12:25:54 +0200
Message-ID: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0197.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 672a5c0e-b796-41d4-8572-08dd094dc1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zSsYpVUqeW4miGVPaW4absnsT4L2aDbLXUrghvbCO2o036X0qCVeJG9C2G54?=
 =?us-ascii?Q?dAtGYefGGb5JzOGuUe1vjvl5blVOOtEAjYmG9LmFDBlfx6EZYfs6W5IWYfOA?=
 =?us-ascii?Q?Flcl7YmdbZ3noFSP8RqTV/0SUq/3TB6Vxo7GX/wurOoKCRIJXBw6kL1n1AY0?=
 =?us-ascii?Q?mNeTadC8B+jL/Ia2XBfcsLZdIyKd1uHayCnoSkCLCvyakoidgXhlRBCzaKX0?=
 =?us-ascii?Q?vNgGAMFQ1fDGj3f4863RBYQWfDXYddL9GUNtBLhGHMutbj9Q4F2vy8YxT1RA?=
 =?us-ascii?Q?aJDqtpM0jGlL6GHRrnVCPRgR9xQRKZJay7+snH0f+7rsngcBFcpr6QkH4SRJ?=
 =?us-ascii?Q?haIClJ7sqjCrfJzO9dfLXExpiiQ8cIXyijtU4WyjXVdZNJT0T0+Y/7SPKTwH?=
 =?us-ascii?Q?UqsIyBAdEEeRI3DxnKLdyouUN3ZKfAjtvdMeU5unrwu9OntmUruFR2F4wY5g?=
 =?us-ascii?Q?AvEHUmVra9TDiK644m7+0mXRXSaU7mjB3BzrO+WkSJdIslqwi+60NzNijt2T?=
 =?us-ascii?Q?RkNstFPL5s+rsCLRRH1EsQEZa59HZrqGRZyvkEOyuYY90yM6x5xw4rMgbzTN?=
 =?us-ascii?Q?JjCUqaqz3IPjD2hxxBd1JzmIlaLjHfpv54pV/QO/xeoxBE5NdXCqyFQStAmm?=
 =?us-ascii?Q?L7kMDP4OknR9Rcjbhwe0YQ5zhnbmvLcfD/P+WzZ0YjCbIOriRPPB6N/itUPO?=
 =?us-ascii?Q?zEldxE/hlZXEvnzR71/kSfARNFm8zz+kcqi5JY6/j78b8zk21NxRA5QiktmB?=
 =?us-ascii?Q?WzgpV6Ql1+/F5Xu+RrYubV84hIZJOEOa+tNC55vpKRDkk1l88QDBgkppNyYL?=
 =?us-ascii?Q?J9l65oaFfYStuNwShB3Wu7nXTREMW5iWbpQUcXiE+/9U1iUD9uDCdMPf1ac+?=
 =?us-ascii?Q?1TVbdrV1ToX/l9Uktcii6uWbYZAy0kZq3umbEXr/1XXvkbi+WjzStRQyQDWg?=
 =?us-ascii?Q?PB7J7dM3aRT/GkJoEry6lp9jNtXrwlb3X/Vl4/g3y8hM2kGlQl9I6TTIsKAK?=
 =?us-ascii?Q?ZdsAsi4tgYjzCKgpsNMnaRO+KDhfW6u683Kihi+wyGPu3/Yk9VYwe4g2Mpd0?=
 =?us-ascii?Q?/IqjpiZfZv5WRcNTESAOqnGyIdfhYyvS1zr9tCVbfHRtNIZdOP+NWdoSdIWR?=
 =?us-ascii?Q?0vqOdL3XZTRK3ZPbdm/cqwLU1jaO/SyM1x1SdBgApBmSDXn+E/ikfUkbjptM?=
 =?us-ascii?Q?0NpagMLZGcBct6qlnKswFG0gNW6mswXodszxhuPa+TkFIg2Hg6+83/g6CxUg?=
 =?us-ascii?Q?c737a1nI7eThnhsVjRlskuBDvstG4t0N0IqlZe+ePdrXy9X+MZO0+6ULjtCu?=
 =?us-ascii?Q?Ozm1Qk1KBPftrQ3kC3Bo+GgE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tpm/LpIEAowTfkVZt6+X7xbp9sfQdFy9VJJS5L7mwM6siDql5wpyo1AWz0fX?=
 =?us-ascii?Q?Msc/qywo4+3nXvr5Mi6NtzUXsquAwanckg38SjPI5OvpC07K1fuRj7nnERLG?=
 =?us-ascii?Q?grQEPQySG6DEtpPSXgFxvn57tHiIVYrMBhOgYhGi6H07aD6iOQyJ9maNOZaC?=
 =?us-ascii?Q?rloWqpXKAiF97yA/pcsj/dmPLYFELNCbZs1oYOaTtSSV12ptxWvuHsfZkN9t?=
 =?us-ascii?Q?5U7sKpAG7aCXcK1a4BwuPTdK5KokkwhnYaEkahJ1KH1N/PmxPLgEHqNmbSoX?=
 =?us-ascii?Q?ea8Oc2KuDMCi/aERcWUtdSuD5Yxer+09xFObciyoXwsFeskG6pA+tsnw5TI6?=
 =?us-ascii?Q?Ep8uVdeaQ31jbQMCBWPwenxlurBzYPRClGCSiM1366SUp5v06tbS9VF/Zp+p?=
 =?us-ascii?Q?pLpqSHhl0NPGm/R1IKt89Tq2/1MjA93u6m6aWYEg7BBfv6wtD9EE94yZ5DHW?=
 =?us-ascii?Q?CWa9HIGJBBUvfTisMMUu+4E2NsjqgLX9DtHiTT66unc0HSLkAKRd3KPPZwwV?=
 =?us-ascii?Q?uZUC8R1eW29uWq6RT4tNFrbLbXsN2RI2hedg+DX41ipSezXsj5/cV9hfaBWi?=
 =?us-ascii?Q?DRBNFcaEUR51U3PRmZXnTvCnnnXzlG+CH7qS2Q4Y1WZXRb7aCVTVRkNC6C0B?=
 =?us-ascii?Q?0P7/XXeNshUCRx1U5mcjCh5YPolGoj3ZZfpqp3Z07UOGQ27cF19n82J/YTG2?=
 =?us-ascii?Q?rAiY3xaHvXx8XWYpExSO7g+RleffEzIz65xSfOceDaVIQRhPPRX6vVqjvedk?=
 =?us-ascii?Q?/Fk82WakHM+bgN7/oQaNNlldeQXtFzhN9iTY6s2qnNLqKGHztNhc8FYipJ24?=
 =?us-ascii?Q?wQiRm4bwNAPmPS+DoXQ0dGsxmmL4HM7U3oKZ4AdegRtb4z5Ni3wHUKaaOGyg?=
 =?us-ascii?Q?iVG54k1njgMi5akrq0oLmuPRFHjaRXVP27Emk//YnYO/YRhDRApiY+UwfXKF?=
 =?us-ascii?Q?OSgFULG1PfnYspyqXQXERmjYqGAPxpvh4wZVfJWS3VJqEkPCFVGGwuvvhLAI?=
 =?us-ascii?Q?pueE9SUeHGmsqAnlPO0Lu+5Lq2booRd6hoFFLPetbk2AVmRhGXYFUo2G5BBy?=
 =?us-ascii?Q?4dBgmVQqFzIYI6gZZvfyZN1i8fX8tQkQMzwkA3dKltQlJGhQnj5RXOeYtukQ?=
 =?us-ascii?Q?YoE7cLDsXx1aXt8oADpB95wNmeyoAigNwc5HIoWyEsUiTDFYveGrPS5J5uDz?=
 =?us-ascii?Q?p5oJTlXdrzEpc9mmliqQ3xO5F0xem5y3/QVWKNUtnOWdfxQwvK0RWh8JheKR?=
 =?us-ascii?Q?ZLttv/WkNvo6YaPkj5DM1TeG1UukSmYlQ/33Ux90mbiwRoccXx3krEZt/knt?=
 =?us-ascii?Q?oCrRyvyxsLUW1VWufr76NBSSwrDcJUoFND9cb8umM8bku+u8dM+iuMudPSFm?=
 =?us-ascii?Q?lmzV7fgjhMBnuR5ANTiw4tic+jz2crDXQv+ArJp+OzXIruz4/tZyR1AT69Rn?=
 =?us-ascii?Q?PMxg/jrRBSgPZ04BXCCAMefCb+UrnwqhNbQiOHarM7MCFKLUXDMewnJKQkiN?=
 =?us-ascii?Q?DZ1QTRqxBxq4ozCwSK20wvYSVNaACQfdaBbBNyoPr52V6ceJK5KFF8CRKC5N?=
 =?us-ascii?Q?Hx3lqaQAA4xryPnrn8y+KcX5V/sV2FXN0JpkoY6tXWK6W5Q6OBqNRUSXPQ5w?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672a5c0e-b796-41d4-8572-08dd094dc1b9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:26:12.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7UdSBbTnfhTSDejy6E03VaIzttY6QDUO96iSKSU4+Y1yYaSLW1rTTo++izRzCKjmA5S/JQ/p/arX6XTgIFOQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8904

This patch reworks the Scan Delegator implementation in BASS, to
manage BAP streams internally and leave BAP to just handle streams
created by autonomous Broadcast Sink.

Thus, this also removes long-lived PA sync support from BAP and
also the pa idle timer, since kernel support has been added to
order PA/BIG sync requests.

Iulia Tanasescu (7):
  shared/bap: Add helper to parse BASE
  bap: Add helpers to convert iso_qos to/from bap_qos
  bap: Rework BASE parsing
  bap: Make default PA sync QoS public
  bass: Rework Scan Delegator to handle BAP streams
  bap: Remove API to probe device from BASS
  bap: Remove PA idle timer logic

 profiles/audio/bap.c  | 687 +++++++++++-------------------------------
 profiles/audio/bap.h  |   8 +-
 profiles/audio/bass.c | 362 ++++++++++++++++++----
 profiles/audio/bass.h |   6 +-
 src/shared/bap.c      | 125 ++++++++
 src/shared/bap.h      |  10 +
 6 files changed, 626 insertions(+), 572 deletions(-)


base-commit: 5c65356cae64ddbc95210deb36ee66430645edf8
-- 
2.43.0

