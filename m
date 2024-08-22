Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2063.outbound.protection.outlook.com [40.107.215.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E791581FC;
	Thu, 22 Aug 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313312; cv=fail; b=ee+DxbB/Ldn/CMBwj6wODQ8Xn2hCTvSuka4qrxX3pFaFQ1waQBxWTUawQu5yZDPtAEwKMM88Qddm5+Q/l1JoCeG3ehzQtX/UmBlDZ4hbyIvSBU1G+fuvlyK2xpBahqySEfNfYQ7DlclnB1A5o0KHUCRicNhxOaf92Qy/BMsI+Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313312; c=relaxed/simple;
	bh=sj0z9dxy8BM4wzVsMaOkVU4FWPKgVCoS9QDTbEI79pc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CVSGtszCC7eLBHACeikwvJgx1f0gz4CLvG+bNx08KTwPLCr/0MyQ3+Ues8I0YFa92sAl1lPj5sdTK6widWerkYEt5Nt0zdtYeDNozT04V+2XkZkcdOpry+qq56EIgw/qiSvdUWH79++FQ9fQNudK44Rlr1O4OtEB4KLP6UHnEn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YedB7eqz; arc=fail smtp.client-ip=40.107.215.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YedB7eqz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vas8DzGbWr6MyVv+sxxNOOFqkRm65jJSMcYNGgOGbysQgWg5wdcVUtIhhStZa0rEYi+f2RPDOu0XY7vDWoCO8nRAtLbZMCHNx2dPN3qKiQ8uJE1LYwc0Ic/smCDc7ONvMagXPikfAr38qab/mBR1Rzi48iiWgUR/Dxd1E5l9gVRmTYuSQ2YbKHHnTYToi8yEokfHGHaytpck1vpKLFh7tuW6lEr6uEhUaxAqlcSg+WRvPrBDFWuCZ2k+5XvarWGvOPyfHM+cIuXWCzRtZ+g9M06iqsmR3m7Ya2HXAvT7nIHX/Wgub85Afy7RD7wGMTnCseKUclS10bos9u3YL+BPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2e8ziabvVwKIa3Y3e8gN4xSfj/IavsFOx06gBTAsBNQ=;
 b=x0dGtIZoBHBNILROx2i0pX9F4ZvzkF+tnTxMFdrUww7YAjn4/k3nf9Z01Xw1+VT7I8jZk1L0vcHSFBPP6YcaXzdmcS+Hhx901wa+fdFgOxm7cP/yYXJcOgphupmcO4nU5gGCj1u2WK4xUGmZF9mzt7dxuL7mAyN7D4v9RtvSJiNXy5xkjl6FzDC7I9extAJrmsEkk23qvIzFSpeK7yUi4+65l3bGJ1yWFrrhvchHelOgOLd0U3sbbXgVXmznBE6zOeh9g+fDcaOhkqubLH1VoXVApBlPTgM4PC54e4sCM1B2O/CGGAOdIjFFhntJqM5Ibiwi9uiqEHZdM1yCj78Wyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e8ziabvVwKIa3Y3e8gN4xSfj/IavsFOx06gBTAsBNQ=;
 b=YedB7eqzdkf350a8/xbOKdHB9ahE0PKuq66O6mMYCleJLYntM3Jm0UnQShWayowqHfTgUTtg7Vk+41wspMISDUSJ1GDth2e4/oCpLQVD3Qbr4fDovvkQjGraDDPIBNdzS3xp4F27csUfnnP/JsP3gJ2+TXEB5kJcJMSWqFu6V0HuaX8HlwKTlO/KeuIAR7qtrcNZYuceZwqMsMoO23Dml7kVa4mKJuVR+NjuyLcxISqh6SzS4s6lpeV7Qx8XK06pswzOW8nZb/kWi+fNqHDmZgPQz41O2pFaOVKRTrgLYcZgbo5AEfUCxs9O/Z01oFm2Ru6hUYymZLe+r1fHfm54lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Thu, 22 Aug
 2024 07:55:05 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 07:55:05 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yang Ruibin <11162571@vivo.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] net:hidp:Use min macro
Date: Thu, 22 Aug 2024 15:54:55 +0800
Message-Id: <20240822075456.1370350-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0137.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::15) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|JH0PR06MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc190a7-2464-43bb-1a89-08dcc27fbc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+c2omDTh/COs8I9uuz4/uw0z2XF+g+0yxgiflsOefexRvMqSAfozE5h/fKv?=
 =?us-ascii?Q?Wpg9OY/3RTifNiGc7YDEBFJ2HRBnp7FmRbnl3N4auR1IdykAaTRFEswUtSEf?=
 =?us-ascii?Q?W5swxLMf4jfiFm0nQEolY9C+6e5cTssoxjdQZE+mrklp8ji5DBunPX1dBpnT?=
 =?us-ascii?Q?JTmToK40pSHhZv3Tns3PVCqDPRP7mQCPMFG3IIOMnh+GYPJclJLbjKxAON2m?=
 =?us-ascii?Q?qbM7C+K0a44lvddvDllU4qNytuQd6Zu3EtOfAyzhGblZn6U3zuSM1ZDSAfNB?=
 =?us-ascii?Q?bB59OJ5/RWJxS03PPOG3rzZCKGd00jEqh6zaYV4ENQC1UscXpQBz++ddq7ex?=
 =?us-ascii?Q?5slBagqIHOlVpN9onAWwYOLJJIPVp0L1e8HH14IZEfc8J2Nq/lGGzNhMzvAY?=
 =?us-ascii?Q?VpyvMYgQRh/9KXsFnjxT7N0UfV7L5Sl95rmRCy0yYwPAEMeYou6VOHgJqJA6?=
 =?us-ascii?Q?KY2vd/yKx/yYlbsQlem2JFOLFVk2NF32JvjjBqPi+bdiLlhzVDtKhSJ5SFHD?=
 =?us-ascii?Q?UQZF95MtRMC12aL68Xhi1vErkWppFGk/Iwm/ejLidrfTIWNQWPbr5KTH5dk/?=
 =?us-ascii?Q?JgTOoiloYOcnm5BpTao13QWn+KhPWWkitPSeF10SiuvP+ywup0LS83EyWB8s?=
 =?us-ascii?Q?28hK0W5tHYDrFUjul12506904/fQjHzqqtwPt5RefHvT9JZTL1OPxr8aSBgL?=
 =?us-ascii?Q?aHaiiwdmBryRbUeAi0nU1/zoP0cBas985pqe2E/Udl+DTh/ZndMFgPf0r4Ev?=
 =?us-ascii?Q?71MsaUBOoDVKDn0Hiu0ryeXpYZmlBf/pq8OHTlOUUv7ZQADZtZb/fUt5p3wI?=
 =?us-ascii?Q?6m3JY35qJy9Gl51BcmnFAQi13q+WSjzgp1vBv/xzsw25mF1G8D15gwIso9vX?=
 =?us-ascii?Q?VookzUSVEsDwsVpGctiyiQbRPjRpccbNdH40rHSZoG2Z/mqwVt8GCnxd8ccO?=
 =?us-ascii?Q?Iew00b8U18d4+I6yMR0zPc1izQk6S89EIupJXl6EUAeeZulMbdDOfzc8Amx9?=
 =?us-ascii?Q?w/70+NJanwhxAcfz5q6J1HWKFBtWtzbx7M0orgWiSQcyF7xV8+tKquklPyBf?=
 =?us-ascii?Q?CTi2ooZVsKSyB2+Rq0ZMe1JaK0IM/f3yAUcPj8dXyaaPVCLMqbVwkEUfrbt2?=
 =?us-ascii?Q?KJeUyfdscLQXol6hFMKpF1AB0Eah4hZ2YQcjoRNb/PZehoDIE4LmMWTR00LN?=
 =?us-ascii?Q?ztjmGpopTErj0Z/YuzcQSDhvWeshCJJJAW8mkYd7KImq2v3x9feBSqU6q/+R?=
 =?us-ascii?Q?EU5gYrTyR7vzqCHkMJgeAmrcaLV6fmAZck8pAtlUzUpa/j6s9bQa1tGstGNH?=
 =?us-ascii?Q?YB7C79EGoUlTlfSwlZpyl7u1Tx1QsxH9Bmf9ooTvKCJlThEwI7ewhKnx2OYk?=
 =?us-ascii?Q?IDCapUI5TC01jhW82cdIAm5rQ/yOHxcXSZWzfwqdHhr/sLoVGjqSwRTUSMYr?=
 =?us-ascii?Q?dr0uDDtexuk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dL53uEWMGRLhkBFUwlVoVh/C9KeScKVkXiyU1YMKr0Y4yv3APJCHkXC+V5N8?=
 =?us-ascii?Q?uL9W6d2/hU6h2zWB2BNMP3SnZAPJZBlna0uWbyH09Aj+pJ69a2UGkWNbvtxT?=
 =?us-ascii?Q?cUk45wN6fps4u+UKFK3mg8W7+ViiyfAQKpT5OeE4X+k21bNgOw7Rl6zdEwoL?=
 =?us-ascii?Q?uGZTaiS3hGJWkYpSYmhMEhBhfnJ7sQbfttVKGogPsuJfGYsBPEYBYG60pUzB?=
 =?us-ascii?Q?ABcxJuPv4yuLHJI/2vcavahtkm49wc0xdCFGKtIUi8L92Onma0E/F+5AzQck?=
 =?us-ascii?Q?Mr1GrQXEqzgs03Wgjl89xcBMjhAOYtqULhgRpy60YzuG0+i4VMoJT6T7aD9a?=
 =?us-ascii?Q?Jg29ofC0ehNT2puhk0ySTL7naiuP0JqU5PRoa04BJY8sqvQz9Eu1xbljkRCl?=
 =?us-ascii?Q?XjgLDMSTIqCUDI+jek56QyATr8uQfQSAe3Wm5iOr3kW3H1pnzAk/3PGR29VI?=
 =?us-ascii?Q?dp+JcoRJM+i1u0VhKKc/u+dv8E5E+HN9VfMXqGW3zZx/6WlcHnMg/C1Cw1hV?=
 =?us-ascii?Q?OoyOCw9t9aSeDZwovMMLWy1nxG6oLArX7f+3gxlIgC2jHjt6hvncB541y7Pr?=
 =?us-ascii?Q?XDkf7Q51KVqSmoXfmXvuUBimuLkZd3ZQEO2nDOt6O0DxBexBY0riI+kAHdUz?=
 =?us-ascii?Q?Br1enZ9WaIt91uxCfgG4Q+R/tQkHw/W3VaRoLzengQTOmmZOxuTTMBwTkCiJ?=
 =?us-ascii?Q?zUn1fWKLGOv/JStwXoBARzkFxBB5NCD5gF48OYgbSO0OZI0GbiTFVOix7Lk8?=
 =?us-ascii?Q?+uf9FOjbFv1vkNCyjW8NfzfbZx2gICkZLywisn25cezzmzyNjKIahw6pwV+U?=
 =?us-ascii?Q?aaJqMeyIwplpZTLrnkwGqp0F6G8suNBjty9T2cZ7vurQ1xnT+XsAyhvdf3a0?=
 =?us-ascii?Q?lxdRH2gYozeJjBEkdipijh+9cIhPIYn5x2G/uVCjCC7qHouIV0yjV7bILeiF?=
 =?us-ascii?Q?fcaKYNFEJigEaINRBNCLzPJ9XTSNx/tH6SdwNgYOfFeJ6b8pg3XllhOF9FgK?=
 =?us-ascii?Q?MSpG3ADyp/KKnisCKhZ0K08Ufx90vPJUFYtGH0Ojf4EOE2DKVwfiQOJnEHWR?=
 =?us-ascii?Q?xEoyR5C59OnnIeJiwKjZn4TTyZJ0NawcROpAxSreI6/DjiYWxB5UQBS9rKgQ?=
 =?us-ascii?Q?IFxo97BbFVYYj9t+42ogXVAK/lxXvothSIY7icWJgYcfEGxZUnmXGt/17MtB?=
 =?us-ascii?Q?1FOazQXqRmCtyO3ppyurFwFmAc0QT7YUaIfLqmjfGAReLosgV7E0lZi+k6E9?=
 =?us-ascii?Q?YNfli/M5Hbas+7uCR7uqRuPs1MA+2t6kdYXPfSe95f1QWGCL6fjdxl/884St?=
 =?us-ascii?Q?qU8y+2gL/Jem021EhYQjpnRgLU4RXx8Tqq8OHGRzWT35eGWw4ZPPreuQdh+3?=
 =?us-ascii?Q?bsXbvevndOJrgX+ix86ykKxszSCNW6H/1zRulhDCi2woD7w6Me7G8940TQAK?=
 =?us-ascii?Q?1tHnKLRNeM31To3DU7yAxSLtE1kEGeA1o3i3aPd2gJq/w0wN7KNrr1rVZRfS?=
 =?us-ascii?Q?JrcR9soJIyZfFamN0ilHsW6Eg9BIr8n5YpiM6AVpcPwuQEXD39jdvVEZatHH?=
 =?us-ascii?Q?WEhsEIaku5YnZKtXQuHcbnE9QxLTkghx2NuEBdPb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc190a7-2464-43bb-1a89-08dcc27fbc33
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 07:55:05.6012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79aCAznZSuLYzVr7cB/0Qi6RvAFe7+yy/3Ek1L5GGdH/8+ChRIZqtLYSdX2sySgsvUPYT+YNkzTeTgTs2R783g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917

Instead of using the min() implementation of
the ternary operator, use real macros.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 net/bluetooth/hidp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 707f229f8..7bf24f299 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -294,7 +294,7 @@ static int hidp_get_raw_report(struct hid_device *hid,
 
 	skb = session->report_return;
 	if (skb) {
-		len = skb->len < count ? skb->len : count;
+		len = min(skb->len, count);
 		memcpy(data, skb->data, len);
 
 		kfree_skb(skb);
-- 
2.34.1

