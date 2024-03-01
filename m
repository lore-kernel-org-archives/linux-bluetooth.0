Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2C941A81
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305247; cv=fail; b=HJ4T2X34dGP6hBeglDstIyfQoyTkKI29R8uvJ0Gqel/FsxRNdPvEmvuQRzCIAXPDZAg5API0WOAYEEdIdCv1fVUttK2SqwOs924X8a//fMUlvC1JGG94mFflvfLTPEWKM27arfODbjR4Z/EjgEtsosgXZBn7RF0oR/nkX8Olu8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305247; c=relaxed/simple;
	bh=roLM+/eEFxg8jca7hhFgE6SYnbS3E5Mg55iaDK3LgBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=grRvHWnYwisAJ22263JNd6C+rUxp/71j/oTyRxU/rciUu2ZkX1omBQ+SgUii3GB6ug+woM+dFGOLcLzaX6K0bQab8uLml1AEvd3nQTqdjtyHm/8w4Vh1Fq03Sbchn/lJEoKLC3u49B/9p4474O/uV3fOXi3S6VWFzGikBfk+Zps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lPzpo+mf; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lPzpo+mf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhM3O+njGY6dKEU2Sh/xosCq4eEXKjTtiJd5UixF7QhlxSG5oPrvjiJ0ynjMK1D4dajzRyP2AOquBTmn0pIdWLcFsOSFQhCTH5czI4RUfnLvzSQe4BixQ3tfnwprvWeYt8B7/BnvKb88m8I13+DWzNdIO8TkS0VNP24ItFJcj2/+XyDHhLi9FR4AalByGmPDNxpzF8kARUObaYTuBqDsNOVEAaxMeNV2j/1EGkhAmkVJYP9Bu/u1tPct5icQ+BoUj9ANzLwEjaKF2l9I08trI9WhfvZq4h4KPC3HuYku/Sa3sIbM4OzZ8MF8t6GWzcDJ3C6B9xbEG3QTHK//Fa0q2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfdQb7yClhH3S70tYz6UQMFjCcTS/F7iwUczdWemp5k=;
 b=ElG9l5m65lt9C+GZfAjvxsIGnaALEvJ0OTrjvhUTdKs19JbGtnjHu02KGCK/Xqyj09h+GZp9vT1zn8Ixrdkuq8/b9s2k3KjLDtJM4HLBOmxihmGVVy+iiLyJIb6qyfZwqgjVi5y5d/yKQAwWM/ihlo8UQlfqmATed/ITbuNmxOidzQvaDgEXzZoeMHsLthTwsCkPmEVaNgerEUIyht8KVodRvuA/++LJKXR2N2Os8PfzmdH1kqyQ8M2gXz9zbM/1JkN2b8nEpghAAJ5iMY7hmzkRX2+kFSzSuvO8jwwVrDcGdjBx92BlL68KnWXvb5mJ+co5+ol+kMP2dqXZQKA50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfdQb7yClhH3S70tYz6UQMFjCcTS/F7iwUczdWemp5k=;
 b=lPzpo+mfSzkeYSww6fBta/vdjpct82GEK0Z4lZweDcXkalJ8yDV6StDTQF/gGboZ/O6f1TlUqJuboHeUj1Nz0WUHoODacb8O4q5peWE/xhv1nmG3zx39S8OVPdnGbK7tFtIwXltxI6dgr1RAE1orMuv46P70/rYNhqq4iSGwM70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 15:00:41 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 15:00:41 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 3/6] shared/bap: Update local PACS for broadcast sink also
Date: Fri,  1 Mar 2024 17:00:26 +0200
Message-Id: <20240301150029.14386-4-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
References: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::44) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f87a278-e873-4a3d-1f65-08dc3a005cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gHxfb8DwM/2gGj2kSC/xFvkGhUWH9XB4bHT6qG6fGfyadABmXP3IB2HC4WE28Yh4BlA0ULa2DsDvjY3LUwOmcVGDQWvJM9Y/luHhFHplNcWUlWQ4DplZhQxXJAFg2iLVIoVrorARD8Q1KpK5xaUHbbvUxTd6JhMaZMuwmxZ/5K5mcXHDAmTtO2Ku+mRd+8hYnLHSCe0imtsYYidUEBAfmBiyTvPXC4wWA8rwP7Tts6Wi3fTzDIfZYUyNB6GZnnz6Jda7OkWg/YbbMp5ppeuuVF5lLMvuTxHeFDvQOWhpbwz3FauFsrXEC+nr3JBnl/b66VLOSO81XjvFvwjkC+VyYY9nwKvglgq3S4rHayTO1/aojFfhnmvtjE4tTPp6gTWcuHw4npqhlL+XrHaDI4/GfKyOKaK0FHV1OdwXAhkzkj6TSYBYYA6DntGT/8IG/MvDUWXtIAar4Xdygo1JxIDqdRNDrc52hQLe08CQQ9uW7nnTk1v3WuYikpMrTOtt19rnv433J+AUxoR+INzt7ZPp/XKbUlqd9swUZMfhalO3i9U4cMkq4Nuck+Su0KYIuFQmIceL7tisNMB48jPwUMfch1/xOsVQw+FkO+DbIZyn66ebGYyX0tAbMadO7kmMgvN4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RgwE6DHJ0nbxuOgOtpGaLkUzJQDti7cSiMKT20I9ElgRRRwy30bPc9DvOCB7?=
 =?us-ascii?Q?NklxWe5LSXf0QAvOqRg1HG3+qO7p8C3M1bzFy1RZ+Y8r9vFmQPYOeYv4iLlM?=
 =?us-ascii?Q?EfNAvYMXpmInBu7EJibvoFvNx8pXt2fCCK53c8YU+eETYCxyeDRCh8W9T3lg?=
 =?us-ascii?Q?unc4Gn5ksHG2RrWh9YBa5IcldZ5qZFvEpdA3r+knIlv0nFqk2/Z+8ETN9UzV?=
 =?us-ascii?Q?LDKzB/TndDIF3Q+6GKx1taIFCrLSzpGvQC9HPlzyY4I9oFGD/PJ2hpUCt1yb?=
 =?us-ascii?Q?LM1Gs4OwBcCaEiLiXNFaTB3QBrCpSXNJf1YvR/prZf2rcLrEBzQ/HCW0yPXS?=
 =?us-ascii?Q?14tkXNyU8EJLU+fBn7e7ITs47v8DrsNg4T9X6cp3okSuqu7C9saBCo07yB3V?=
 =?us-ascii?Q?CFq6IhpjYHtnRWacnNTM9TKdjPGAEqDLh+T9mLbFfQbtDlLPPdqF0IBfZf7I?=
 =?us-ascii?Q?4C6HpzbIR+LxCloxXIfaHdcFOBhptsNY1y8Jen0eOww1VRotoR0zOhflaR3L?=
 =?us-ascii?Q?i1TFTcz1xF/pCAoGqToGe/sSwsGI4vPtPfrS+PZ4aHXq970NNGXyGn/S3RF7?=
 =?us-ascii?Q?0NaREKW6IaaAPGYXSbIrIelPSBTONpu2et11hlSJNi6agDt4ShTcvCA1p3HJ?=
 =?us-ascii?Q?FTDQL1wZPNnVp2hNtTUFjzVeq1cUJPaJBUeOMSffiZOgE/zUAAX7eceBF/HB?=
 =?us-ascii?Q?Hd9f8ftIGoxjP2j0CiYwUsjP2CRQ0LmltYARlobhVs/AdmCeToy8n74L4eKS?=
 =?us-ascii?Q?ajrL6ZrgIh/o0CEXNXMJoiP4F+bIm5JF/vZ6fiIb6b1Izbpz6B5dh2/MZNG/?=
 =?us-ascii?Q?IU5q9dvvV2Z5/+DnP/ANtESeJTet+69wUQiT5Dwf8s1OldvEuVHyeVDdXBcl?=
 =?us-ascii?Q?WBYQvsINwL97PO8YQX2gLtYdIkgub9W92J6YwGfhyCraWVV9UUG4WvZuhgZo?=
 =?us-ascii?Q?GAxaSSaGaXTp3TUm9XRHFzs86gqmKdEr4p4mdfaDe7ZCwcfMk66qopV9tGu6?=
 =?us-ascii?Q?Jsvsfz1EnygrL/l31n9Am4ogMII1BVVrvGbwbetmjn12unc02JSxlV9KAsto?=
 =?us-ascii?Q?qr80JGcDib3gl5UYnTyDwgBbp/O9ki+d4FMdYJHlD5WJ9piNcVClfF51E72E?=
 =?us-ascii?Q?eF/9wjr/E2VHfaade56csT5zAX1Vj/zgOj/4Oc1KFurZ7KDV5oexx2bx66Hd?=
 =?us-ascii?Q?IDuZ6sW4ZkaZaWKMtUtzu1n5XvZySRm3IQ39sCYxskvvyQoTlFRqAn6fGJdk?=
 =?us-ascii?Q?QXhZP8TS7urlcc3oTqDGPf0hyw+bgymwWZCdPCQnFxL2v4+h6LW8Os9ArBrw?=
 =?us-ascii?Q?HIe2BmzjBVGTYgNBSIYIH1sv8TxGSEC6lMYa3rGiqS0h6UejRS4tQJwC6hHO?=
 =?us-ascii?Q?xwi9g80C5QXRmWszPWPGlMn6fjJcR6f76Cg0MGjZkReMzBXBR/ste/YHz/X+?=
 =?us-ascii?Q?4j/OWNUzZmOd/rRqw8VAVVkOsM+USexj2pKRePIyq/8Kge8Vgkrq2gecWT8G?=
 =?us-ascii?Q?a3MpSoONUVE3ZcXwlGuW8h95R/QPO9Z32S68FoqEQG8PCBHg8dRAIn88Osgs?=
 =?us-ascii?Q?MCK+6h8S6UCUlZoNBQn50FQc9y5Fckmlj54El+OCogVRbDjaXk0px/X4KNcs?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f87a278-e873-4a3d-1f65-08dc3a005cbf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:00:41.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efR6wb9e+CfJeqjUhv00qlGED/UrbY1RRUbvaM3warxlV6ZK6PsxGdoxQgftsNxrTu/pWKNHQ5bBb7aWJK35W/+XRbdZACUVkTwAwm1ORXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

---
 src/shared/bap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a44b5534805e..638c6f8a4947 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -3306,6 +3306,13 @@ static void bap_add_broadcast_source(struct bt_bap_pac *pac)
 static void bap_add_broadcast_sink(struct bt_bap_pac *pac)
 {
 	queue_push_tail(pac->bdb->broadcast_sinks, pac);
+
+	/* Update local PACS for broadcast sink also, when registering an
+	 * endpoint
+	 */
+	pacs_add_sink_location(pac->bdb->pacs, pac->qos.location);
+	pacs_add_sink_supported_context(pac->bdb->pacs,
+			pac->qos.supported_context);
 }
 
 static void notify_pac_added(void *data, void *user_data)
-- 
2.40.1

