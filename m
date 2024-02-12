Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D63D0D2
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755149; cv=fail; b=TddovgwPZwbMU7poSU+Nq4vEnGDN/9I+OQDP6rvNkWzgmoyuJVvxaoQJCM3fxdna4RPIOAcK+fm+MpSSuVtqwxLE1bOBbgSEBrjoVxBQiBlYgG9f8mHkk0xS4yXlWSUXOmnQ17HQAs2VYXj6h3K6z1ER6ik/WaBpaLbGFPfCbeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755149; c=relaxed/simple;
	bh=1yPyxWycmlRGuGkIMDT/YzO7Pgf0vVEPGll9bQAAdFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWiaaxogIUJkJY2vt6fx1JHjq1Xl3Udvh+3KYcxBc+f/WiFpvhoYyPLuszI1JOoPxuQwv0fSCBiu3mhHpWSxCU87QW7flFg5hEAmmQP7uNnbJ7SCt6ARxv22YtDt+zjV/I1HNcB7dRfhkye60ZZorHlheDKVAri9O8JePpPv6P0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UudCoIhA; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UudCoIhA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceEDh3H7VUPste8UEM0KbvWioY8pT3X5jZEeiiJRRCfXv3tHYqWDtPY5mx148O+RELG2dVpToI+usYdf8l2SSUVorTvf3oB9VhSocs845FrU43eb5CNnE0GkQq4aKcrwy1F8rFnvuU5JGp+LdPWrEWb75W8tvNiP4Ta6hRKlp88FeMi1jFET2UoePogrJdE9J3X4r5iNTomnYaS5DNXuxl7MSfqQA7up2RW0hkZtq25qYNy/Dwm2bY/eNo/mwX69tbplScLxxDBLPU5pb2Z01Lb8dldHIrdsyri8Qn+f/O5J8+YMFULE+J0Tf6nL9YnzRx2rXqXyuf/IZXN/ocHB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCOcpCgLdzYJfZQmr34ySTzqyPa+hLOgkyRMsyQDY+8=;
 b=jKiPOtkZEUtjuqDnqE576RzSHPm7ROUglVN+7ItEOxlgZYTtnX55snSM1jrTTRTrTq0YBMQDEqPPCvXDsZDy9eXbsCEkphqJWMlItMjGjNUCaXGyYGrlWvAQd1nwL9b9Q5lNXuEy1IpzRoo/zRD6oPrK4BynrPGiLAspgYXWJQiXpIhWWkRVCU78lpnDjFcJCa6DFzC+k6uirGslno9O4ukmDjuT/7A0itQHrlJ6lKwArUUApjmxkbvsVvI4upFJVZmX1WzFyR1nr5wCk/oUiXSVPiqUqiXmFIlGDueq/eeNGv3ujrQ5f9wHw8C5/1D+myblw94W5kq6bqfQvamFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCOcpCgLdzYJfZQmr34ySTzqyPa+hLOgkyRMsyQDY+8=;
 b=UudCoIhA/oyxgbeNNxgHSFY374OgufZB5oAYlE8mQzWVvYWurYRrQzoYjLAcYWdiGUZ4eW5qwl6bb6wYcIsOSsRJ/FWinyLZdxyaAbM9MUoUB0HJuIN3v6Nkwc22Bt27s+UBOKvsmrCoiPNKU1qjzQ4nd4RNhJCKRiC+qsbKoU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DBBPR04MB7865.eurprd04.prod.outlook.com (2603:10a6:10:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 16:25:44 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 16:25:44 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] shared/bap: Fix wrong value used when extracting LTVs
Date: Mon, 12 Feb 2024 18:25:38 +0200
Message-Id: <20240212162538.32207-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212162538.32207-1-silviu.barbulescu@nxp.com>
References: <20240212162538.32207-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0116.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::13) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DBBPR04MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: cc3a3d6d-faf6-454e-78aa-08dc2be74315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fUPabMFhGbYVUIzxRN9DQQ6YbAs59BrR0I84Rki+BRF2lqrlmTRV/A3k3BtwCsHXpSktH795VJf6X67VRkNgqDgBPLjKUYoyxYFN2vEQPsZeQ7T7Ozjz5rUHXD7WqCFKqyDTFuh12lKMvlsPXIr0UQVbdIRKrY4xxwtgG5fIRFGTPClzcTJaa9YPVR6OfPWxwyDzO/dqpxqdt2lTKdrozSGSf390oS8tNelOFlnC5ES8ZuwCy4JrYP2Ed/FvCiJwwxzvkwiPVAcJnT8nsxrNClKGFbLFbUDrJcm7f6E25bMHaW2Gd+y6kRKsuPA9KVo4gJewxZHVAFTTgTppepeJvJQqFm7/p8aUMuXgxAfF1tHcLkkl3+nbbQR/SPQ2rozdQFlnGFv/A8VPBdkAv4DZLe1yEbAqJd9YAkTFGQzrJv+59mjA3Zc/MW66q7E0ptutLWzQHGWaCQUIZsT5SVY7x4zhXRiyyaeC8c+hoAT+0YvAEXf/Y30eHmgj2+IXrEATYnnNb+a/g15CPowa2weghIih7pY1gb7WIM64ogklgl80C8YuyCuJSzebQdUA+VfD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(8676002)(26005)(1076003)(2616005)(41300700001)(4326008)(2906002)(66946007)(66556008)(66476007)(6916009)(5660300002)(8936002)(4744005)(478600001)(83380400001)(6512007)(316002)(6486002)(6506007)(6666004)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GkXgiWK5xGxxLkawRe15YaKWLM/piK937/lQKGjNtOwtyn6EP/V3A3wnxMCR?=
 =?us-ascii?Q?WiRvLrw37fozlKm8PuhOx1+tsGlEi1cxG07coz8imY6qD833EvlHfpwpfBQu?=
 =?us-ascii?Q?bQyuVNrdeepudGk7GedRCVf0mAcRUmKHdtNkJUlSSe0x4sMXkmw1yF6ZWLDC?=
 =?us-ascii?Q?iuQO7utVj5po2tHKDYrvEbQum4p9MrMYhgZaJWYPmKZsjZ0iXIyYRdxnvSCi?=
 =?us-ascii?Q?yv8fQ9/p9NHhaxvA0F2rZhk7Qp1DEq5dAutLH3vm9n+NIAuvapt3U60LGxs+?=
 =?us-ascii?Q?rlfasPUBM1UNoZOeZ2IgTMoSHzwcDjZsAvPqdgxAzP1JulDOI3RdfSEzPQDq?=
 =?us-ascii?Q?Z/cFORhlxKnR7shzdH2JNCDtwZ7dqMZuef6muksa5XbiU0GoNfcjcoAazSug?=
 =?us-ascii?Q?Vj5WlGHacjpdiGMKpQhQO3ThfOJ7QDyS7dasCHGMiwA2EhvFc8ke9axaHAaQ?=
 =?us-ascii?Q?J7vtYjZ5CjJ9Ib5YvLoZbmAYWKZM1Y5t5XXPGj+w+NOcbvjg1yOLvGScnKrw?=
 =?us-ascii?Q?p9boNc3pjEcINTct991Pa+wZZfB6gsuktdAk8qAyQoiXq2pkm3bK6uskyHkW?=
 =?us-ascii?Q?yjgWLC0q2CeZqJXnHkd5FaBmj3FwVYAj1gSXP5bYwhC6akXZC1MsH6X3PD4c?=
 =?us-ascii?Q?CJK2tOCtk2ibXVH0eYl+vMzNTkzhwpgcSwGobjyUTZtCX4+YXiAKXBTjVpcm?=
 =?us-ascii?Q?RxR9lCYNaEn8dlQ/En6su0iDHBw2q8pipVG+I3Es5Z8HMKBq6vqZe8qm+agZ?=
 =?us-ascii?Q?EjVOTuxiZuP42bv3wfmTFDjKdem9ek5yshXxT0CMxdEPRb61bBoRhkZN7Yl3?=
 =?us-ascii?Q?naBMgp02VeER47hdw4zjsVs5oz4ZSvL4JRfNSa0pS4EjV8LEm9Iz87LXJzn5?=
 =?us-ascii?Q?CBUxYo/Sy2HDwpisKWi9korUvzRMvEYKpDLMOxsgquFrON/phKcFQ1s80lTV?=
 =?us-ascii?Q?0reG9XZbDj2sczqKmOf08vS8GXm4cwD4Y5E5iSBDpf6K26MuCBbjIZQ4uCFx?=
 =?us-ascii?Q?rU9TCbltC7Zw1Z2F3zErX2Y/hMaEnwrLPaZUI7L3XBRYQjUMtfmmWS2C3SEz?=
 =?us-ascii?Q?oMSYl59w0frcb0kMo8yX5EPiuIo2TmLTrGKnrNFL3JRrs/HYNHZ9x6T2gXqI?=
 =?us-ascii?Q?eZEEIZ6SMQMW1n/WoWCw1gim5yT6B0Cxj3P0PCfKqMkkPgipPRJowqAb235U?=
 =?us-ascii?Q?XUQTMMKuZxDZakGevtYOTIp0LI5obAfPv/Rdkvio4jjVCMtRQu8s7T92JX04?=
 =?us-ascii?Q?FO1Vb0l7agSqcb9TDG4TrGmd93kEL+liqbrvRwbWpSsEXZ4nbSID1Zhu1WaM?=
 =?us-ascii?Q?zjKWhGm/91fAYv4UAqZtk0AL39Kh57xUqBraGGRoOSqwUJ3szNdGgbqRe0XT?=
 =?us-ascii?Q?LEevlKKG0nerFMig03iumRYECqVJn9bvnmKhcDrBi57oGDBWTrHfNhYkqwlr?=
 =?us-ascii?Q?lAvDzPGi3/s9sOmP6baOue2bXsVOZz4lupLorQ4POVflBgSyHA0lHl0rtQgE?=
 =?us-ascii?Q?wPlU4L8JBznSOizT6JRWd/Aa8RHxaW770ggJkzQJuIPrEHWi5XXL6OLOjTnc?=
 =?us-ascii?Q?G2w1Y/xffRaATnXOD1KbcvDWDkxdT+C99HTgZulTzvsSLMggbjdVZDRKB0C/?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3a3d6d-faf6-454e-78aa-08dc2be74315
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 16:25:44.3599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n8K3CHjhtYbWxadgNgYuiqIQVbkfR/wh5jlg28CCKHmLpCugzjq0uL6/PpK08uvsdIQm6GdYXntINVx+PNXxULOMX8o/aVZzBr/hD/HlQLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7865

Fix wrong value used when extracting LTVs when generating BASE

---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index e26dbf944..4cc81844f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5991,7 +5991,7 @@ static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 		ltv_len = l + 1;
 		iov_append(ext_data->result, 1, &ltv_len);
 		iov_append(ext_data->result, 1, &t);
-		iov_append(ext_data->result, l, &v);
+		iov_append(ext_data->result, l, v);
 	}
 }
 
-- 
2.39.2

