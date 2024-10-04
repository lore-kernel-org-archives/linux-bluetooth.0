Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999961D4157
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045354; cv=fail; b=Ik52tonOsSARuain+HipiOuGVpLTxsVkrvXfGkk/i3+x1dW6tHf8DOfHQ0QJENuZ924T9tNvdBVBfSc8SlFLytqsPgSNe5x6xOrS3RN4fXEjsCMq0pamiHTWZn4iX/HxevQqm9ov+rxFwXCFRNGqu2HQ0eqk37MZsnRcbSepHnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045354; c=relaxed/simple;
	bh=4VgrWy7pvuIvbK77BHveKT7+yzRn3N8/AVv2mZUlAo0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MYJIuSzRFhIEjhZye9+39gO/Ro4PgToMItGdpGKBHYluFhFJv1ayCfJey6EncGgcm4edFOMBDuNBsxCZAGwthfXv1zDSa5mcrLqqg1b/Bfm4g0tk5PAf9Q4C3O615oLByVPM/nHV3p+767euaPO6d2L45aLrziOzkG08w34ulwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WAbmGMQE; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WAbmGMQE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgPtefHSd0MwCO8aFVnZec1qYDoWy7A2pgw8CFwOGsmeadZPiHOcQofdoC2e6D1RGGGOMKEQjgYorOMMIQ3IRMg8yf5+q134bp1BBz2eJocim7mrMceANmqjXiRSGjj9/UeD+2gyvcdRQbiKUaWsPUDRcGXEeUsxIM3eUmxFN3N39Q3oS0x0D4zoVNZHnTXOJIl8BHqlWIguIM2o/7w+YyXkm1Aqi4FqdgUoFRE6Zluor9iVne/xvDkcYvIbHVizf1Fi+oGiV0D6DQXfmj6Jvoh1vFk4btd0IJSDtfsJjGJ/qS7z9AgSDFwl1Jzd4oqgtFD/QXH7xm/MbrUSF0J5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QARf4C5FSnhN6Yu9ufV9K64i+dKocMYCWjVeAvq86xs=;
 b=P8wJCTnKmA2cJa9lGycYaOTpJAG3+VJOe32uZ0YD2VNUm0ZaPIn9OEqlswzh8g+nGxmHysu/bxWHCVcht614ZKWEN7bg+HkaPcdPO0SSEgLxpBsjF4EWHqnOBGXG3Ets5/r4zaqeTcd0AcsLYFSUsLtd2qfQzujTJ04Qrtbqpaj/ykzF1nrebgwpm4k4CWv1GZRM8sKfxGbBP66ZAliKQm9Ojl6tX3G5otMPJO4uxzXuYVwgHWIUxXaNFTOs7uXQi+QKVJEIRWuqduVlHbaXoNgTjEwtIQAv8deA7SumJsjKVKNxIij2Knvezp33VH0HZSjNT1cYm4xcX9RnoNOrZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QARf4C5FSnhN6Yu9ufV9K64i+dKocMYCWjVeAvq86xs=;
 b=WAbmGMQEuLc6Fzl+f4KgjM7CQR+SQLA6g/ql0fm1W5Uin0pUdyQLEnq81LK5tmsGmoWMo4FpLQg714LmTEQ63TrCXz05N9DolLhy7Mt065FopsIuAFHNs20E99GEW5E+EOO1vuZNJSlJlNCgoRkXhjXYhiWOsAa3BHj64lTFwdGFd2KkRUZcxXoxbupO7hKSS9jWFcpWlFX/TFFm/+ifCdet9EoAoXknCoqHk4ES2rYcbhXWKDoFjjvlGxVsDc4M5ZwIhBI+7/9flp5modSXzP8d3kpC/ZfV6VFVrBtMEjd5cS/15AYA+VGuzHvuXKHkfQw90DV9nMtncv000J7WqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB9PR04MB9963.eurprd04.prod.outlook.com (2603:10a6:10:4ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:48 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:47 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 5/9] shared/bap: Add guard for broadcast sink
Date: Fri,  4 Oct 2024 15:35:19 +0300
Message-Id: <20241004123523.1012743-6-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
References: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB9PR04MB9963:EE_
X-MS-Office365-Filtering-Correlation-Id: 25035b5d-0700-4d19-acf4-08dce47112c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QHOU78hBfuo9ftXSNaekyqP7LlxP26Vn1EUSb8ynv6KZTXf9uQNwRkkAAOYc?=
 =?us-ascii?Q?MDe2qkig7WwIMpq8RDL2kGR3kM41ifuRCDNCZFUn47UH/+6V4ZpngcqzYSCb?=
 =?us-ascii?Q?L3TjlL0VJkZzB0Iu/1un98jzA5i4NEkzWOhK6hu058Ql9WTzVKImCNhIyUjq?=
 =?us-ascii?Q?JNCwWheFlyQcCJfrGsPn11DiK4uz7oewi3+FcTa2fvPVAO8SmrTO0MT4dnnT?=
 =?us-ascii?Q?lwBL4lF5z4FCoxN23mtMayA1An4XPDH6Gnysz9H8SEjqf9v4aEm7IkKRlcfr?=
 =?us-ascii?Q?wW9MMQnCuqKtO+EVHrckPFPuJVcagNREkQ7DwvgF+yvXPdvLDNAeovi/JxSh?=
 =?us-ascii?Q?lW2v5Cem20+ifSDkesOku025Lh3b4jHRUFFUOuHOy20UkNkC0992Mo6HrvMy?=
 =?us-ascii?Q?vcB4J9jGN5eUgutYAXS2XAkJeMPXOYDFTENGkLigTINcie7zbz0F4kPWLrQn?=
 =?us-ascii?Q?n0ThwwIgvwUs+wv0oCajYjwNjD/51xFxhhwgsUtTC0X0PVMqpa+4omY3+nFP?=
 =?us-ascii?Q?W1IHBf6AtmXYsHj7sBqS5QZx7EobhPvStZCIxL4F/K+X73a22jz4bwdDVSn2?=
 =?us-ascii?Q?wwzZQg6wl5DLef2cVvpflcjf7WzSuTRMKyxCNIKM/qbTBEnPW2L/J4pY8dS2?=
 =?us-ascii?Q?DJqYFMw6SaYge2na09f0Sun98kz+KC1u9ZBIxlbHT7dsGPmqucAT/4hirlEs?=
 =?us-ascii?Q?JpilbUoaW1LKt2C00rVqgjY4a7jdDGr5OrGq4SFjRJrUAbQPjWkG84N4Xc3T?=
 =?us-ascii?Q?B+fYOQR6qGzwU3mGERNPbOjABIBkeCBnuuc9u3Dp/21JXI5DTb0zfKH3cfH4?=
 =?us-ascii?Q?phYWe/JDALFWSmMPDmvTrdXvAa/8D8vVnwMIspjzAE4f0fYaVILUi2dZa2bJ?=
 =?us-ascii?Q?QDMgaC2kmz35yze2HNinI0lFaKLMLmxWNfOpwVUj8RK3JeFA8fkAh1sYV+e0?=
 =?us-ascii?Q?WW2HHihEaAlSONR1KFeIVaYYP3QAp69E8TZcdF7MU73briuAAqcaTRZquXlk?=
 =?us-ascii?Q?qYR8lnn67S4P/n+A0oBI+XXK2dtHeYg2KQObmceHYJp28CKuicHFva+D02Va?=
 =?us-ascii?Q?jT1qH9quSk8qsmwbj11f6tArRpTukOy2Wpq+aNOdYBY7dzb/GKSV26KK0fPK?=
 =?us-ascii?Q?d+cqd4aAUOBlk4G73Rrs2JIVzBNU3lCvNytjBnepuRwtocGttHkyPT1B+zFp?=
 =?us-ascii?Q?tE3p3rdzvHsbFQTXwMVvDxnSpyx4JwsGgteCCZqt6sj+MstrwaVOR4qkWa27?=
 =?us-ascii?Q?ShpP80midJ5HiqNnYeBtBlj4Z/iMCTJ8UDuolEJDsSEOJI4dvW74VnnWDNvO?=
 =?us-ascii?Q?qWXVyk+6pzr3RnoZL5OYoH+gKpzuii1kpZUmvjCas4ah5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qFOinskGlbbzUOl2R1cCBYt63hZKhvAVEHZN8kWBR4Iu+ZhuZ7CjP4OgLcI2?=
 =?us-ascii?Q?Q83pVIZzB/oAxwExGQlgVgTD36ids9Kbj+0TXsTKHxPpA6k7oNIkXggME2uE?=
 =?us-ascii?Q?/WruzyJMDDxIp4Ow77nvQClpqbXfBeDjwICgEqiv1XSX7alefsoGtFDdNecP?=
 =?us-ascii?Q?zPVQoxFefXlhDjTB7M6PqbWGoHK+cKs5QaLQMKU7V9rc4v9SXnYGlGZya6de?=
 =?us-ascii?Q?6/c4EHT1Nl1rOuPzNGCahjcEtdOtG0S/TmiI718vioUqY+jQlyx1KZ9b+wLJ?=
 =?us-ascii?Q?UokhldDIf7mzhOfxT59HEh7e2lnsDtl4i9aznVZ0xalz0GXpi4/RuVHeFCem?=
 =?us-ascii?Q?Qdjyvz2z/YFrCzl3vEr3l2LfOHTc+BobYcpBICfU05c4sfVhpUvOLEXBbkSx?=
 =?us-ascii?Q?Y+ho5p6SVOqC+4Fnzto5hJt1Qz4lFMqSN/3B+duKTIn7I96AKxLPHUQ+6zj+?=
 =?us-ascii?Q?0Ly66Tx4QfKzKf9kP3nshZxT1MkkcMnvomwYjAj8qkofxjMYRZBKjfqHB4Wp?=
 =?us-ascii?Q?yK6YjdkD+SkG2mOx1cOM55Skv10HhKS8nwJCGiULgI+llUbbOvWXjjH3q6Oj?=
 =?us-ascii?Q?A5lQJqedOA/aas+lJy7f1aZs9uMFvG/6KgOm+2zhogiLvCVNJdNjm3aJMbNz?=
 =?us-ascii?Q?prKTVJHEn63owfiZyzdqAuL3snRPopOPYkXv/jh2a8NPMo9lNOnxoaM5LhUq?=
 =?us-ascii?Q?QHSAaN4ThiJU9ZpBln5GrLBFCURN/3YQF6Tb7w2VrccBevxNW/04gqPCqGZk?=
 =?us-ascii?Q?3hEgIPDSKGVjn18CuTzWMlQMne13slhuZivY8CBsqIs96dkVDPpAcaXqGm8X?=
 =?us-ascii?Q?1yd+dUyMkOn5rD7/d8Yu/+B2XOnshwAu1QLs+JN9ugcu98PRb5WaiNWyOJPz?=
 =?us-ascii?Q?nJwFb3LErl1/BvpiSQMp43zJBFrW/hnOPxVVIgLbH2WzX6pMokGmjxrFWi5L?=
 =?us-ascii?Q?+Evu0qy4UcIQCigWzv/IrgIwmB7VPJrQ9IgXbPSep8bd9aNeFIpS4Weas4zL?=
 =?us-ascii?Q?H3plk8qgzxogn1W1OYBjNa76AWdHWx7SML7rg5/GKXeEG/rgnlIDw7vp+tIE?=
 =?us-ascii?Q?WctcIsUPu69l6zBWYw4RcDnygiP27GsCiWn00yaxFnnIFCS7bw3U2rLVhbiH?=
 =?us-ascii?Q?KXvyyw1d171uR4SiGfBv6KoliTyKwRCxZVAF5AdZtUHqAuv3XTEHelFanKZp?=
 =?us-ascii?Q?Ld8EWSusLuFRtW8KCxxvmuD0SgF1vihJNHf6JjyRxssZfqIVlt7LEghHtqpx?=
 =?us-ascii?Q?0bZGCNNBPoMT7WbJn2TG4mCN1jFX6Qc9TFlPtBRMZ4aylLX3SFg/nL6WTkua?=
 =?us-ascii?Q?+QhR3biIpD4tMuk7OnMQU2TrzVEdYLadK2ChJ6Jr+GuKSF6qgfLYYVj2UlXZ?=
 =?us-ascii?Q?NFO0KBSed246s6nzJsRWkoKzMozCm1HS5VCGrMjSEayClDYzzluJhmhfB0y2?=
 =?us-ascii?Q?AfJIS0IqhJ+0h/PYukZMlnC2fjfymgIAJn8KCSt0p+C4JHga2Ur2VYss8F+o?=
 =?us-ascii?Q?aPvZZnM2weAzvvpcpM6KaKbmei8UW7l7dCGF4WdDR+fJdNNelp3EF2dAFRss?=
 =?us-ascii?Q?vcIM4kZCo53fms+G3IwyDcytW9FEGSdFQf0mDBwc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25035b5d-0700-4d19-acf4-08dce47112c9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:47.9137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw4mRHOptnA1GDnkcnhpuhixgSf1J3ott4HGDWX+7FCV+bm1zMNU+arf+K1T+4RBAs8vaIbo36BgOf4WgKaXWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9963

BT_ASCS_ASE_STATE_RELEASING has the same value as
BT_BAP_STREAM_STATE_RELEASING, so a guard must be placed here.
Until now the RELEASING state was not used for broadcast sinks,
so this was not an issue.
---
 src/shared/bap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 72f0f8a03..c69c9bf6c 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2098,8 +2098,10 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 			stream->ops->detach(stream);
 		break;
 	case BT_ASCS_ASE_STATE_RELEASING:
-		bap_stream_io_detach(stream);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK) {
+			bap_stream_io_detach(stream);
+			stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+		}
 		break;
 	}
 }
-- 
2.40.1

