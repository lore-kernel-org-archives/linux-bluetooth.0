Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC41B013F
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935802; cv=fail; b=FJYu/2up/26cFskWo5muRF/5kk69a7ToWRFPg646+K5Uq33PZbeu7leGlTcZuq5EBdd9gsd+kAshfJ7xLGJABChZQLqbvAXwW4wuTMiJ/3Z2p7S/BK9mb3FpKT2v7GawTPDcW/nq+YHaaCpw/9g7OgWt7aGy9Qu67vqWMnndAMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935802; c=relaxed/simple;
	bh=Xj0iuXMp4wmKPn2xSlhixHToEFcoUPboiEoVbnGWTnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cb9JOfPvJY1vaej8bSZtehI+cMLA2urs3T6IEpLIa+2gcYaEBLqkA79oB3ypSN6yrnYZ15xA1QLiJRB4IfiudrP0o5IiNbpYG2HET99kDRF/DLwR+ofjpTHkpjSNyxzAAQS7y9VJmNjefOeo2UkoyvBppfAI2F45t7SMKVF1rxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B/O+kLqK; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B/O+kLqK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GXeeCdeyyikAUrvidrZkjkeQAXlZmgc8xwMjUMImwU5YPeXjqG7KqE223QUSbXfK+yzL8ZukZbwRQc5SANk/GLN2wl8uU3JNZqmKWfekshboRYf27f6wft0AeXEcJWow9lSgkxeG4K2bqE/l1sOTYM1RTXRPtNBipTEAcYk/KzsxygnM+FgC50xG58CJW1KZft+nITv4IH3U0AsqNL7Sy8IFcGcTnqZA6/ckrKXC8ukU3FjTHFImSlRsiP1gcB0RpIgs4vW62hC5uQ74Ox1cHHwDgpDltBf8siT5XphyAmE9RyRkVoFHScQUWKVrb5Et7wDM1z/B3Q5FYN7N7cW+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTUifbOiXRLSvfccmIcxkAcS1tj32YAhduDe53d0QDA=;
 b=IEpZ9922pMN00x9Wubs6Hc3f857eA2LjQuAOmREnAR9wxyDkUDjYVoOL4Kp4QwfGgozDFFZx/76CkmKuOdkdYQUjF0zjtfH/DiB5jXHmn9jfHqdT0NfCbYALwY5hQvc0DULRt5CzxgGn4mkGlywkUVTErypdAOxiNAHrFR1noRZN8oalRpirkpw5yroxDdrGWmH8qsSFCq+EUEnyiAAYQdZ2Vw7krRCN0HCmZKVmVHsYEikHtOhvB3wxuHTRBXZlYLdboAKADDNE57WrVswSAL7WQl3AG4L1azdcv7Vy1gFNdlRbqLmjg9vVV6ARCZFmrZwGjtdXE277NiruP02SLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTUifbOiXRLSvfccmIcxkAcS1tj32YAhduDe53d0QDA=;
 b=B/O+kLqKT+j8qDBZWvrARNi1VoW2pl2KAcF8YYRfAo+oQMBp5+F8dEHnnMjvLA8jyT6We7Dc1Qli4ThcIEFEzv2nMa4b9uL7uV5sgAQiFZlXjl6uukbAVQA6ClkIG6nUDeJItFBRph8g01y3sQZQQeiCxPBMaXTPlBcdj2Bn5kzgiaF+evHii75t+MnKOx3BmX/rFrW6EpDDciBs5UJnmwtZFfvK2aYJPuduInddg46IHgg/zkiiDZiqKznjWdK67itdVa6IOodKGGJVnKYL2wMUW8L4hVAS2l3xlr5qI2Qd5RfAJo0YJZ+RB3JS9IniaP/Ux6atDtJ2GEzLvIyvgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:49:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:59 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 12/16] shared/bass: Add APIs to set/clear BIS sync bits
Date: Thu, 29 Aug 2024 15:49:14 +0300
Message-Id: <20240829124918.84809-13-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ba872f8-6c1b-4df4-ed6d-08dcc8291765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ROOLSPIIL8BIiCnIRaqXICrW/4tTGCR3paXTUvkMgZ/CYorPyD7sGEMXS5U4?=
 =?us-ascii?Q?8n17JTqHllELxkxLdmJV8Gpdc2f6K28UMuIBcDOFWs0SgvJMXOTwNpe7XP6K?=
 =?us-ascii?Q?sNjUGxvQP9yiAOtekWMixG0QAd8QFwqnGOoL4NB6TUIsmP1nQsYbwPB9q6CI?=
 =?us-ascii?Q?UjbNn1QSLUQ+dabTsPudzP2+Mb16FYTfUtV3q+USiga6UVQvx7xAONUbnfsN?=
 =?us-ascii?Q?a2TmAzG1IKCmIh6zAX5gjspnSJ7VJ1uIp4zJXRKVYk2XW8UNHBuvO2aZaoT3?=
 =?us-ascii?Q?z4uSNv8A740/f4sWbYv0lWmoSTkEndNmICAi1rJsZ4Ledgd4dx7NYxhbjWlB?=
 =?us-ascii?Q?MmOKb9F/md3KY06RKwnSEwmdFZG5QbB/cX0ZuumJdePUX+DnwYn7LysGp+BE?=
 =?us-ascii?Q?3Ma2EGSLt60TbmppZ6EpX+RCvIywUFtoTWaP7uABTUBT3krapKWxeQnaVf9Z?=
 =?us-ascii?Q?HOzdIWC65mHNWiEp1MH4jPdrR6cYyvndNWmlWkAMIxkGRAsbRdbi0FWYrEaJ?=
 =?us-ascii?Q?qDhbwqBientOM11fXCe3YWIPOEODneE9hfuGoHMFzwrwjBZDRDnCw4kon0Qq?=
 =?us-ascii?Q?zc0Ws9gXnP0VxJO/5QsNVBZ/ABxCsg6nvVkiGGODAN4nlcQKOXj/IGMwmdvA?=
 =?us-ascii?Q?8uM2flm2AoZsMojs2ai7fD/P24/aJHmayqvuduNiZZl3Jy2BIbi8WUmOMJif?=
 =?us-ascii?Q?pF+37mjrGJlAXleAbojdxzMbidb5p51o5PD/Cu7GrjAtT/Mp/2L1YzZIWAEz?=
 =?us-ascii?Q?TtS5xdp/wGxTE1IbpE7mjp9ILVUhEBoH/w/809ua5hgG06G5ZQB/w5GeQdbM?=
 =?us-ascii?Q?MdHyVsUEdhNNcqlFTP649GyzjFxuH+QIyRvxXyTaivmeeqYcnhC0O4OfErCt?=
 =?us-ascii?Q?is+6boTFsl+PdeSt04HW8fhlRssiKkILEcysxlhz1Hi50gJtp7b5z/ECaDIf?=
 =?us-ascii?Q?uSqOjomgjKnmBUIBE5g9/IWRNefKpnQODxQ64tR3gaSgfxHEaRAIBTgFHSQz?=
 =?us-ascii?Q?B5/XLopXJnEvk3HWIJzAxOqr23SlYl1mSugleh/hYMDNmUoxCHSI4d/38gaT?=
 =?us-ascii?Q?1jPB5XVcz4kr8oeo7lBcMpx0MUt6boM3v96x32GwSJpdeuPujzZFdEuVt7lt?=
 =?us-ascii?Q?Am/evn1sN8ZcVd0xr2wR57xS9ExhInoEzRyd4+cCqfNzaZQiyAnn3NICMJxg?=
 =?us-ascii?Q?zq8DlfhIEG2Nf7O98nzTj3n/qd/3yQAqidHtjOyBQrejjTbTkmn3ey0iF3mv?=
 =?us-ascii?Q?5dNKhCKc8uqbCCD8O8xpegfGwP9IiYfTHXehdDFu8Irp5eOfbcdJIgdAcGnS?=
 =?us-ascii?Q?PL9PSQEYLlXCRgpA7mGwNVL5PErmXfGeF+oPsXELjPCmEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Izc3YQMFu9H9pXc7CPw5uE6u/b4gJfnsJSj5hRsGEuIfSh9PCKS/BaVDzPwh?=
 =?us-ascii?Q?TVCtzrJkPNefBB990NgPVcUKz86bxGWcBj9riQ7/kM+jrcMFozOzCUvwvoud?=
 =?us-ascii?Q?QZJVRKurhBIKAcRWj6ITwHk1T/+8IJ7WEgWF4pFAq5xbw8x1wCqxjd9Z7XNK?=
 =?us-ascii?Q?3IvspvZExoMaFCH8ne0y3SmquvmNgXyEyD5KnP4b9RcNkAOCUr2v+UBvwkmc?=
 =?us-ascii?Q?b5pGtNzk6JwcPTsKDM+JO5Z6PYV8E1lU6NLHny2Cr+x6D59w3lwKvKDxV2SZ?=
 =?us-ascii?Q?ZydxO3X7GvmdDyMlQh6gnbz8u5EzVgu8kV8zJbJJIsXJ/XsYaQpRvIRuugOE?=
 =?us-ascii?Q?uLzX26yqsF4ffspDu6FLc4XCv0DeYpH0e34WbFd++XPCfYbrDk5HTTMQi2cb?=
 =?us-ascii?Q?0VB1XxTzMy34QoaCerzRpo2NaNts+NQV9mzCDQU37yTZsGNqWazMNI5Tqmzt?=
 =?us-ascii?Q?9tVU08QNkirs2wxPpWlw9/NUDSYt/aQzqn9GvJ3sJKkC1TjnHQYDU8n+yOjf?=
 =?us-ascii?Q?vWZSFwVrK4auhI0Iv99Th+fWqMLeLkjoO+7CfIYQhIkkDB33TZCjySirZrmn?=
 =?us-ascii?Q?qoeqJHs5cJsyhCzHa4ofz6aSxNZAIfY/0uISBoXNbPc+XkvPwdDBIRvup7yb?=
 =?us-ascii?Q?k+8qvN2O/vbnA3niSh/9rMttzvcGMpqj8v/jOh6Y/s9Uoe/Nsi5bS+DM+3ZF?=
 =?us-ascii?Q?oeOHU2nHzY/2BBKQeCud+3/0Wv2KpxbWeOOd+FokMuX9qiNnemxdZ+m+XoQg?=
 =?us-ascii?Q?Gcu0u+8TrM8AzdFfzMggQUHfuf4hSDOnQV14c+oWYPdMSAyo6TqmSs9EqH94?=
 =?us-ascii?Q?DR82s10lOCkod2F2iSASvss1r8lJkEjie/GxI19Sd7+tN63LF2Ka1eQMO+Ps?=
 =?us-ascii?Q?g56Yxke9EbZUimS+ssfzEqTlpzgSi7q7/LqfChCLfkG4Pex8m2oKdFr17VTq?=
 =?us-ascii?Q?Tlh7XjqrEPVBiCO+Gd4MVbBSFz6PV9ka/0v2laCUADKe8htAoZK4AOpMc0KD?=
 =?us-ascii?Q?daZA0SjwtNVlroxhwc2JfDByyFqeCFYlgiDCRJ21Ah0iaoyN1rsAs4KmQ8gN?=
 =?us-ascii?Q?XJsLxGxaRVwJSfSbJr9k1ziY5/lacLElSOfdVK2Xq5iVuhA/ayLVJpxCABj/?=
 =?us-ascii?Q?xgtDc/n5K4Xcm+a+/IcrNgRfbdC8PESshhqwaCzVTLiq/CmrdWHJ+kjp6oDq?=
 =?us-ascii?Q?gEVjwPDDJoCkKJdPd57JSboCEVLRnjKOPDNvx9ZZ0A/vXNqEv515GFJIC4MB?=
 =?us-ascii?Q?AywmfEo64XDkJ9UKiSvJm65ookAsJlQ0zXsMH/7RnbMhw1l7EwUffD4bzzXp?=
 =?us-ascii?Q?5ajKn8wOXPy8gv+WwZmfGyq/RXpns6hnz9UNvBTx3l4GUw6Wl3M7A6GeCLvl?=
 =?us-ascii?Q?LmG9k3cj1KRTnKqRW/iMIR4q9v7FyBNdH342IMg1Sxq26VBXtXRWmJClMVb9?=
 =?us-ascii?Q?Y/G9T8+B0Tzzx1H89VC8DWsKBzv0zFyp+0YSj4goAdf8LgjcG2I7XPLiq9ku?=
 =?us-ascii?Q?A5Z0/IlwoZ92aA5gnqVc+U2tGudIAL6E21mXS1XPwhvY6NW6vPLBVf1AXRmG?=
 =?us-ascii?Q?xNtwnbGD8nhsqgCpmoNjJ8cIxxmsgvjueMt8FZgj+VtRGbXfxwJmW9YgCjLO?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba872f8-6c1b-4df4-ed6d-08dcc8291765
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:59.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMndSVyVb7RTu4X+v0Ra7Fck100wOnfLl78CBojSL5nXeRGmpWHGpHhX0IoLpBX6rAyyTUK2kVS697kerLioYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939

This adds shared/bass APIs to set/clear bits inside the BIS sync bitmask
of Broadcast Receive State characteristics. Notifications are sent to the
peers each time the characteristic is updated.
---
 src/shared/bass.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 958b6f788..8f02086a1 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1766,3 +1766,55 @@ int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state)
 
 	return 0;
 }
+
+int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
+{
+	struct iovec *iov;
+
+	for (uint8_t i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *sgrp =
+				&bcast_src->subgroup_data[i];
+		uint32_t bitmask = 1 << (bis - 1);
+
+		if (sgrp->pending_bis_sync & bitmask) {
+			sgrp->bis_sync |= bitmask;
+
+			iov = bass_parse_bcast_src(bcast_src);
+			if (!iov)
+				return -ENOMEM;
+
+			bt_bass_notify_all(bcast_src->attr, iov);
+
+			free(iov->iov_base);
+			free(iov);
+		}
+	}
+
+	return 0;
+}
+
+int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
+{
+	struct iovec *iov;
+
+	for (uint8_t i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *sgrp =
+				&bcast_src->subgroup_data[i];
+		uint32_t bitmask = 1 << (bis - 1);
+
+		if (sgrp->pending_bis_sync & bitmask) {
+			sgrp->bis_sync &= ~bitmask;
+
+			iov = bass_parse_bcast_src(bcast_src);
+			if (!iov)
+				return -ENOMEM;
+
+			bt_bass_notify_all(bcast_src->attr, iov);
+
+			free(iov->iov_base);
+			free(iov);
+		}
+	}
+
+	return 0;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index a82d8f573..f3f708246 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -130,3 +130,5 @@ unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
 bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
 				unsigned int id);
 int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state);
+int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
+int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
-- 
2.39.2

