Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7863172796
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 16:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912211; cv=fail; b=M1VYmgzfM7ypOH/r1N6ILbtxdiNpzNKHjJCFfTaPOrkX7rP8gSF6T+DrOYB4znS5iocdrUOMtD7e5IhYWlYBXf59aD7dLHWRcqTsakuJQnuweKATdW0R/ehbZYMKN94UNvph+nBHJ5WyJs9l77N+Db1Y/tEImCz0ruDnGy8uu9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912211; c=relaxed/simple;
	bh=ucxsr/TXudNQs7YTjcNFa/O3VjIVcIazFyaZ6z+0kUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FgbfjkNwH4kmFZplU5cYGcBtidCBXzXLDCM8yebbsZz73eMHl4KLCBfEuTHueajlfrqN4wWwiavIINOpFpQSZ7mDpPmTNu+ZVnlQ4Z8Fv0eE7TF2Zgom2rpTNUFXQOIQMbGcgLqbHb2fU0Q4c1y9a4xwXxf3XGOL8zBLS1J+TqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=X5DNnlWI; arc=fail smtp.client-ip=40.107.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X5DNnlWI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPIzslp3aVe6AhCrvNydWXBhttQgraRfSpIJOFwg073G6DKTp3YXpF4R4ioO8uH1F82vL5zAVQYjOX5oQ8x7d+QbhVTmRQib83ngejsNxIyA2WUp9qCtVqwsfISf23OwDNsH/4ZvClApS+fD1/jcN+lxirlHQ9uF4PBBhZdU5e1PwvV7ZLBPJRANjAHp4eY9mGsat97/mqaJjx1gr2Y6Kdxm5eAfStWK0eq0UjrIBQa+Uy3JWDGPpjmkWUXEEjWBYVT1V8kh56I7J+OrDoU2YfNy7rTXuqdugu23Bb3RYZtUCa5doHieBZMNpa5XjqizLBR1V++W9kw8XsyWOTRWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynwmNvMY7Eb/kckuCH5fPM/kRUrX4d4pHQO3Yvxl4hU=;
 b=cdeIwQBMu31GYiGbKYfxWOh1kXGZNO1n34aE3x+4zQDvSoemfWonez+kKvebF/fNNQjXiwP97fxKxoioA+FMlRARjTooWcL4MUW5jNAdsnbLHDAjGgXcR33hw904+x7cR9OP8WIheqFZc4HXISeUNQLMIlp8Gq7K5Mmx1rLaOHaGMbhVncmaZZMohNbNrBbKMjMq5rwSBrAwfN8rkemYiFr+qLe961m+zxidvYTuJXnPOu6Ymej9mqAeLOXkAleIOACE2TQCcygxtcZah6N8vSZf7VpGtJdv/7crvd+kAoNcSYhafsZvyTZRjrPU8PbFSjq1F89IBcCrtGtStVzHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynwmNvMY7Eb/kckuCH5fPM/kRUrX4d4pHQO3Yvxl4hU=;
 b=X5DNnlWIjFYGD345+9lhL9NylDtLMXoRpNPVyB+se8jja/abNJNL4XpXxILKRi7ZEZrh9acT2fD6sK1y0bCaoxYQva86ZgjJYRMltBocJSTopoRBm79sd+sOeLSv9qgJd/tfSWNq+IHG4Tdu9URfN4gSKvSn4naJJjspiLmRwPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA2PR04MB10374.eurprd04.prod.outlook.com (2603:10a6:102:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 16:03:28 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 16:03:28 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] Transport: Update bcast sink transport state to pending
Date: Tue, 28 May 2024 19:03:20 +0300
Message-Id: <20240528160320.103845-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240528160320.103845-1-silviu.barbulescu@nxp.com>
References: <20240528160320.103845-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0093.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::34) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA2PR04MB10374:EE_
X-MS-Office365-Filtering-Correlation-Id: c5363e4e-4b6c-486d-6a13-08dc7f2fb697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZJ19l9dmafoTraI5L9EX6Oy4r3K3uEaWU/C4i4eAXzIPIFd875IvfBX5PkL?=
 =?us-ascii?Q?fqWv1rrRAz/RueHdLn99kQxUOQNc+krtgmqZ99ZfBdBFHt3o7vhSXCGtij3h?=
 =?us-ascii?Q?GXrP7ONlmS6F8onz0ONiN13CvLwiVmccR9NEVnNvWil2LvDO7sCdbVyKR5Sb?=
 =?us-ascii?Q?ZThuDDqu2vZXluEhwp95f5yP4B5ThS90RgSTzq0QDlEQL9AJBqLom06JyxtL?=
 =?us-ascii?Q?ekU1ZdhvLrVKGy/nERQb1LZS610UUEj5YVYbR/pVeqkvpPGs4ngTzjSFUIKC?=
 =?us-ascii?Q?388uKM9eU2WlF2Ak0zwGjYj8YaKDYahGZ46VWJI8o2R7Q6+lu0uGxKXxkFFF?=
 =?us-ascii?Q?dOqGlCkWMiW2EanoDZwbyrNUfRQrkPLu9kdGhJtZV9Vdqf5lMC35Du/+dsJN?=
 =?us-ascii?Q?bI0OL5B5eb/kuouQyXx/Ky6g1IH7jxAZtlRtu07Q1smWLcY1hHubBcMmY0bC?=
 =?us-ascii?Q?8ApCC/C7xYCpLrb09tF5uXTgnYlJhXJzxnsgk+v7rd2J72hmNe2VipsXiumP?=
 =?us-ascii?Q?L9JnJ5/QFsF1LllPeo2qMmfamKvgOJs05DEE6kCgXcPjtEPgJ39mZ395P0dj?=
 =?us-ascii?Q?Qc5GM1J7JKSRSEhpCNrqxfvz5TMNKdbDqsKMed6YAEz1NdYh679+MlCyYb26?=
 =?us-ascii?Q?2kSb4ZUm+o/mWmMfB36YBTdXnlT3pXYNcqw19rqlr97lBXJHIyI3hISfvico?=
 =?us-ascii?Q?BB0OxsM6lcKU3wW5zPGDrJbn/OHilch5rp3DDDSjGyFA36l02KEcq+I5cgzI?=
 =?us-ascii?Q?GiMD8D5yPBVkQrbgQFAXfeGTKf+fJ67UYN0iGgMJPo07HFO6DOhQy7p9UB3W?=
 =?us-ascii?Q?jYgra3LVHC9qABFQkfivu8Y/LlDoLr3LtO3B8bXT9fZHHQPSLiZVZ7yiou5a?=
 =?us-ascii?Q?VHHxftPSMSuhp8pwCg6lHC+Rvx9pGn2YeOw/LZV+ECz2WmjxJ93VUoax+oKL?=
 =?us-ascii?Q?8iY44KSRvxcb8x13D7H9TY8/IJT8y5VTyReeyKomBSwqwGV69X+5+RRhzX9f?=
 =?us-ascii?Q?+f8ad7BmoHD4MN5Xj6lOr+Zn44ds4jDtj4LKixKDR8HBxW5yyt6bZy5Z3tof?=
 =?us-ascii?Q?m9zAVxInZnJFqvOQFMSVeSAxTrmUxiPUGwlolWJ4g/sUZootWd2ObNMUBOp9?=
 =?us-ascii?Q?FtZaNIKwSRzClpULUmjkPB9qIq3ThmybIOGewD6UVSPn1hJFX4KcFRrluAz7?=
 =?us-ascii?Q?sOu/TD+C0AXUQGhSFV+1xViC77qbZMAsQkf2E58+P3PcRsf8W0M2lJkGG70c?=
 =?us-ascii?Q?8sH7NYv37ufztI0ngtqWs9XeNUdI07jigBFdc9ldfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b5IZrEsnvrMBeFRDqLdq9oLqO5hXf/4ASzjjZBcfRcpmd2R7HigMiwWetZNa?=
 =?us-ascii?Q?6A1Z716/RDts9Syskfi68pZxgxhlI9tY5MJd66JyyOqTlHjkPnycxmLNdFxk?=
 =?us-ascii?Q?OW/hHQwekI1FbG2kZLa6pLx/Qn/1Adxi0pEluhN6UkT7IZo0W5/cGXDrHFxw?=
 =?us-ascii?Q?IFQJhhSs5TLgfVkhRgplTNowp4L46jqK77BB800j0ljkVWZ1NYCMv773nmn+?=
 =?us-ascii?Q?FlGkBDovcAoAQh2CKMUN6hOSAbHYIIUW0/tpyZhIUWX+5DkLBT3cGUzFq5QR?=
 =?us-ascii?Q?AtCglS6I+RzXAJ3mbi1qs55PdvUrYO93QTSTD8SZnvulXcPGH5Lyy4vGMX6S?=
 =?us-ascii?Q?Z2LExexiNCCOUL3X3YnwBEy7e0z8LoKSbM65ooYjy0p8Cv3HFGcbI09ewblN?=
 =?us-ascii?Q?AWEKoquX/IfoZxPldkwYhAMnaK6YLDs+Y3gq8h+o1Bp6HyNet2YdQ1p3Bn7V?=
 =?us-ascii?Q?vKthyqY2ZdfRcOFtf+xaAQRSvC0Ud9XMtg8nIskSad5OmFHbdbbNWc4JEY6R?=
 =?us-ascii?Q?5rTI1m8na+mcjUO82HlBDL1Fy7fcdIOQVGGen4RwMnDqa17XelsLpHfK+HDz?=
 =?us-ascii?Q?1T/tjEzatxCuQbEiX10tz7mL1c9oq2vk2g+ION4TefLczEuYgVbWjIl9t3+2?=
 =?us-ascii?Q?1NMVHRmM2MPmTn0RXPjeLLSzFB5XtDeZeB4z7BvMBfVlVIVGHDXVPCTorFlG?=
 =?us-ascii?Q?jHWcEzzB6TWOv/RdKBZW28uG+FajGJwFclZ4J9gt7imCO1tDKvHCCN8ZmcYJ?=
 =?us-ascii?Q?8GLMkIP2VpMwpQaxGNMkUW+9KYfCDy2CIJ+81KRQmzY3wZ5gcoCRkXpn+MWx?=
 =?us-ascii?Q?DU91hYnnFgbA2ohV/YAX9iFLlnG5kC5RX1ZqC76JxUysEOWjY9IlUs3xUbeU?=
 =?us-ascii?Q?l244aOyrlXM7NP3ig02DJTAawjJrYW3fYE6v4XFBpnMNFnvZQNCVxC6XTIv8?=
 =?us-ascii?Q?J6RWLRfbryC4XlGaYc8v6gz6gFVh7y2IToSyH97ZU/LMp90d13OC3uUlDUJI?=
 =?us-ascii?Q?LgvJkoEE0ML9QnXuEDhbB2epISt5QJrSXggK3juhePwyz1sTZYlEyBzpDCIL?=
 =?us-ascii?Q?Hzc+i3qggK6YCDMUXR50Il5166MqedYJkctIosgoarHeLvWfZ6GNzgjs1qTL?=
 =?us-ascii?Q?aDXU0077JTy6eoIIT67VCHJbrjdp4P/hdHdfc/veBQjB+6qYI3Ij7aDl0l1K?=
 =?us-ascii?Q?bj67Ckp9DrPPs+eUzyyHZO8FjD35NByx0fEMjoDZlDDGcG0F99ldCEvbIn4m?=
 =?us-ascii?Q?iZIFMxuD3RrkkHIFqnlhpL3LUamRi8bvaP3xqtdOn3CCCHufP+oG4CTUDyep?=
 =?us-ascii?Q?Jjh85fozEUOT4iFNu5gXpW/kvGp1Rpgv+SWhaA9beKenST59Zg3SNGTwpTPS?=
 =?us-ascii?Q?+Zyas/4UtWugyeT/C06oNrRfsrkplTyoVCd1OFGIGrG+ZTzLv3V7Zo8DiCQ0?=
 =?us-ascii?Q?2caEgz3mnMEHj+AU2MbnmpBlgy9jBjnbDdYk2PlYHJ+lwzhn/qIITafjeQme?=
 =?us-ascii?Q?JmtmYjxCGmRVFyvXe7qaVTVcXOHT12MO/0pW66YxTmWjIQg5SCiGROLwbTG/?=
 =?us-ascii?Q?8FS+98n2TicYwxkscDv/XSNeMhRrEbQfcG4QzURX82JLW9gpHT9V/V2adAkq?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5363e4e-4b6c-486d-6a13-08dc7f2fb697
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 16:03:28.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 345PwHR8NqjN0umMsj2RnoPoS+Aok7E+MQqOsA1B70POiSQ3sYeTT/KNyN0VOtAYcrFrpVuLc6P8Sd6lnMe1yQUQ1mW0B3GdxoGiuK3szbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10374

Once the broadcast source is detected and a transport is created
for a BIS that has the configuration supported by the broadcast
sink, this transport must be set in the pending state so the
sound server know this transport has data available.

---
 profiles/audio/transport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 159fbd575..5b11bfeb6 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1624,7 +1624,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		transport_update_playing(transport, FALSE);
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+			transport_update_playing(transport, TRUE);
+		else
+			transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
-- 
2.40.1

