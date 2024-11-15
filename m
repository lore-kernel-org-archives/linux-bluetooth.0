Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC11B3921
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667123; cv=fail; b=HScsTXLm0z5eTk2nmszm9C8kSoBomECEntue5rchMzwP3ksdFXEfS8bRQmjKNdBlKurbvg4WCUF8OD4Y6bxFrZjVM2jOwxl/2+7NI8ChqnzSO7RLL9rA/LVy7LoJ5WttU+ABKUjpdQT7+qA0ILakkxbJ27y7DpK6V/rXQ1c9PDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667123; c=relaxed/simple;
	bh=ORIyVquidOZMpGSPVGSBQyLO4+6IqpxPVwrm+cUTi/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RppZBfjp3OKTo2RQGoDsVJfYStR034V0/gBiHD+uMoZ/BBmTXYuFHBp+asQoBhJrp4kyXp2005niUSY4KPGgjJJy4JEwwNOwO757oSoHI6vDqnovodwGPSUB5EwZcPR1g7mbfI01CBd1jX9Rd1+NsydMs6Qm0/OSO7Js5U7LXLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jkBHoOWd; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jkBHoOWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpiapO5frP5KxXM1UtL+ELCmP95bsYjlWhHfa/i52IWdfJ4R+nIov4+O1OdbvyKC6x+98CqRBqf/5O5WIFjLXnf6cn+I+7Owjf3pIMz4zbXG+rpctTBok9gqvwT+NMuvjvSAA0fCn+vc0akq54b5UC0s6ogKCoAbML33yhYSXNhgZfcI10aA4+205pIThjQnQso1nmyox72/G5RvUH8wQwZUm6wwwk9VCoqqSbeadZ0BBypt1jQfIUYa6bCTHPIVgT5kaIqtpRH2fmon73w1tn09+afZwdwEW+bTKVJ4hxBVVyfzSCEv5IqGdO2jMjkQ0XqXf3rMxAn5M3ryD1CBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptKvC9TgbCdy729sgSCIx6PPwcWTvfoKcwCRf2GInT8=;
 b=nksxLZVDSgemBp894o8uD881kN3bpgexRxFC6Xo2BxjsJbcGY47wGvsty4rpNsiMygkXIgtx0o9/CNfeDA4TEpnGtIXZbvtqH778bfPx23Lja0rh9vOfqp3TQw5/xHK4jx6yC62EFMKUJXvnITRMAYO9MXm/fkGdfBVR4KRC7vLA533VeaPb1QxOTGtycQu4Xi2FU9bEQ6RJXHO7W1gXaNVKBuXCzpTWFt+gXk+kE5LYDHt2tBaQwdf3rEkYd+bZunohroF/c3DHHM11vmjuVoO3yLOltCNx9HnU/3RMgNhw1geE2tRurXFiNTPdyu8doHAiO908IlL9foE/kiVmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptKvC9TgbCdy729sgSCIx6PPwcWTvfoKcwCRf2GInT8=;
 b=jkBHoOWd1CCRiZ3nde5s68oKqA/yLzhgVY8JQarTKGMt8lVNMBHIfeW8/NF1Q+BxrUB31CF/ay5NsiaxTi+U4ungXFvFi3taP5G+cvcg/CgBnymUeJa4wjKMnmRqyopxRz+7j4kO0VKlH8I3xCp79gvHIzLhhZh+DTDnnwlmcuNrg/6LAOTJlWLd8GtdRUlVuqED1dGuRbokAn7yQcT6x5Oyzta5CNz55hJc//Ty5d8qFZwPrzPqUP+JJ/NbvnIV3BAvSnY5w8VaRcJJr9QlszuT1f9ErpolZZRCFALhUf+oZOnpmm38W4uAqrTvzAQizJ4MX5kPGFLzvolP9JDTnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8776.eurprd04.prod.outlook.com (2603:10a6:10:2e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 10:38:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:38:39 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/6] bap: Make default PA sync QoS public
Date: Fri, 15 Nov 2024 12:38:20 +0200
Message-ID: <20241115103825.19761-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
References: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0019.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bd7ee3a-e98e-4fb0-f35d-08dd0561aaa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bT/D1O4JRbc39ke5p5uYFlabFRaR0N/HmoNQY/b00w4f3MmjXDLHBlpfo8VH?=
 =?us-ascii?Q?wJU8liPaZbtq3O9zol+8RIn5xjw4BUlXrBuCudjTGRV2toqa2d6tHZvJPqbw?=
 =?us-ascii?Q?ddoiUshbf5frQC4X00Lxl7OcFBdJnZMMjLwsGVGHXObF0nvriRGuox/uqfpA?=
 =?us-ascii?Q?uu5Xi6sxBFJHGFvl/66kw1rNi5iyeXo+KBZ8wD1zVKp5d2avml9zw7dDQrx6?=
 =?us-ascii?Q?47aIElwhvmRaW5hyLhIOXkn/VzgKJzwZrBZCEgCK95/jUEV9h8eUf9bW19Td?=
 =?us-ascii?Q?YPVOO0S5lONOntpXep3PZ49XvQzTGCUnace+eXs9G6g7HafvGBZRzYtFMTQ/?=
 =?us-ascii?Q?mrAD2gZl36NRB2SlY1x9cD76Q9oxaknw5dr6aPy9A132FvcRIycEhZC0R9vG?=
 =?us-ascii?Q?4nNmyClY5BJD1+EuJAe9Uftd7Wz0W3OBTwfeNYdrLs8fSsj7kRTppdCzhIsj?=
 =?us-ascii?Q?Ig/0VhkSyiSDxMGulm60XZrXDm+SyIbmDYZmh/4nfyd2zZVE0Wjap+38TTvh?=
 =?us-ascii?Q?iDiQ3FxVY9Lyol0RG5WY4ZBrQgxap6eCbCCUjfGg2aj3S5wba2zjzv3ZQY2u?=
 =?us-ascii?Q?WChVx8l6xjlbSQ/tTlS4AMy3tBEXhp9LkFMPI3+6p9QcE5qHSfQ0nQBHrkWR?=
 =?us-ascii?Q?jh6T4RdAnX1qBxTJsV2SpGxPI0byHVdL5nk1mB1T8iJMqSIZhtQsToiRUkXw?=
 =?us-ascii?Q?Zhq96SkS50MP/4Uks2RGP6fj5ruPtY5OX3+SrNZbB/MuVmebKeOpX00QZs2k?=
 =?us-ascii?Q?2QIqnE0SkOkwzAoE7KDGE+3h1rn5Q2Wldbkv4/bbpwKfQG/ss0d552pHpIt1?=
 =?us-ascii?Q?GsiVrGJEZBa8U0k+mnfivuoabZUc7NTjQv1TC7h63vsMRUlgw0bcq8jmB7Wp?=
 =?us-ascii?Q?cW4M/oV56p7pRvAMCHMgnr+x1A74PgdguzSsfR1B2+/gGdScLab6kofotJkr?=
 =?us-ascii?Q?VVCNDACRIZqRsiX5ySebJKMmFg9jKgPNqdt0qgajakJi4tEn4D/LHFDyyPyE?=
 =?us-ascii?Q?gLKCsK6AFAuPabujrFp4U0l3NPj2BGxgdF2bY86mm8an1GSc2dynbaASYNya?=
 =?us-ascii?Q?JU+hxgEhOM2TMB9gK+PZtkGwFABjpMZgCRMw95B3sMUTa/v7gFaoJZmo6GaH?=
 =?us-ascii?Q?ClSerrjymNkx3DSaPZ2G7xIVxxeGwllQCE7UnIMm2uWczjI0pioNGuxKWHGO?=
 =?us-ascii?Q?VGSclD7AVgo5bk2GzEONHfXc++7b79lf6ew5hz0VCxZnQO7U67D/RaeLGAbR?=
 =?us-ascii?Q?EpgLA8IpqxZ2Z5aa292VKT2dv9OhfZ9ca514MnQBhC+Fe7msS69b3jZt3949?=
 =?us-ascii?Q?aF9/pQ3ruIpovGsclWiaDIpD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JtglrmGnMBZ4J8JA8qInjm7ApyG9INJ7RSRsfM4FwwNyeLKUYrpeQ3jcXGgJ?=
 =?us-ascii?Q?Vejz8Us+HKyR3I+CmTP8DD3hfSZltiARIGC/7ISdUSdQni50Oigjf+VebSJm?=
 =?us-ascii?Q?Y/82stRoInu9KJsQhKqmpOHCSoXysx2Kx+RC5tgBkZtKooS4T+IsNt8umo72?=
 =?us-ascii?Q?nTmTDB2NoSi6nugUeJKN3061TWzEqr+8bR1PN+zJtOofVt1BJgnBCVUhqgr/?=
 =?us-ascii?Q?Y+QgT2h7IN4j7EDjeQogSnpU59c4iuJsnIlbBsYil49QZGg4FzW25Y9B5Ll+?=
 =?us-ascii?Q?ykh/gVPH3ZlPwxuOJ/VDZwAeJrKruIVChMwb5xAYNTGjEGkq0vOOuOdYNkam?=
 =?us-ascii?Q?clxq9b/XD/5vNOQXWKzjYrz7jge1vsS0zGgXD4cEgCJpUnNBzQyDsq1gIsPF?=
 =?us-ascii?Q?NExEsGmBEoRJVQzreqf5gy7vbesnAWwWUtMrTBhoxdvdYA2MSsE7c7SYEHbW?=
 =?us-ascii?Q?h7yUjqWXhUP0UeNWLTs1rVIs0dkf1kNvxHLEnt1TTpEHKHxlrv+OENUvMa/A?=
 =?us-ascii?Q?02kVKTh7Y00U4t4Q28/c7/ZtqQY9ZU9OUrUeRbG+jFR/NDfjLpwpFg5oys6Q?=
 =?us-ascii?Q?nvQNHktgHk0j03FP2Bo07o3O8rsf4cMa56W0p7DEjqNGQIhnvRg5fgS2AZvd?=
 =?us-ascii?Q?FrDcWcLUlOuO6DgJuQQY0J6dZ6r8E1kQJkPFSA11pBUuy27tqi8mT06ZHrBk?=
 =?us-ascii?Q?W70k55PNcQ4oDgV/BGk0xVvGufeH4QFKOKQhrEnnqR15yMJNYLcw0hgzAM7u?=
 =?us-ascii?Q?G+rTNfVG9eicT+OU90L2wSZSGgOhRybLiFhuLyvwZ4Eo1umcAEUXlvQVzq8V?=
 =?us-ascii?Q?rklntKAu2OaAMawIXj+ZNgTZcTOYbWsRGRw7fP1jmNpb7PzGm4NlBI62d1wH?=
 =?us-ascii?Q?yw/N4oK5MLfVq31Zvn40VdfOSBW2qdfA/ktglBZAXbEog04A8EQtIO3ArLV4?=
 =?us-ascii?Q?ULYdTGA4cx2FlKITJaLLToJeP3+MnWOQeZSQ9OcRooWxVuekzd7RvUvkpuiO?=
 =?us-ascii?Q?ciAXneiZcXH/Dm7gadxo8YNB3LFZuhZueM3XhYZimxisjqmI09awwfDLrdnL?=
 =?us-ascii?Q?/7aH8vkzdUzmWhqe6sRi9dntfZud7sMVxbrTv0EaEL+18PvBR1I9jbhaWFQf?=
 =?us-ascii?Q?s+yAS+UFrEvZEgbO2ldnRZ/dHv9ztEobdMrKyadfMUuKavVKS9gwJdhNPjmv?=
 =?us-ascii?Q?+s1yV3r/Ewxj+A7yu2bSXAGe/e2FoaobgvKztDZwrKhY5J5ivnDg0akFzsT3?=
 =?us-ascii?Q?aOAJG9GmVK4zi5OI3c9yN4MoaGoV3G8pRpeD+GsX/jIxikeW0IUs/oJzi6s8?=
 =?us-ascii?Q?K0Qg4PFFYRhfeqYDerjg7Vz+vAgJmaC2zgPTJTyPS/vClvOGwVKrcr25Ag+k?=
 =?us-ascii?Q?JHTn3sKUsZ+2KEi9y9ZnswAMKNKTayPL5FU07K52PrVG631/YKwCgeADEOtO?=
 =?us-ascii?Q?+Xj3gyNDXPzWAJFi1ERroIiRPpU/rTwg/VLIkiY8DLMivUCTKYpKStf5FqCk?=
 =?us-ascii?Q?G4qmJya4txToSZ39VfMiWM5yU/HyKeWCMFvQztpfs50KMmjf4Bjhqp77zLcd?=
 =?us-ascii?Q?DB+Fbg6/NLPSMZk8FYwufjKslVwpVRdAKFBpfqqCtIYakFENeBDFoxJ3/B5H?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd7ee3a-e98e-4fb0-f35d-08dd0561aaa8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:38:39.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXKEBzoQGWNRqbGOqGHiqr90Qptyj8yorWjC0nw1lIH9KCLou7JuscyHIvSNtzgoESUfLLDWPv5ut4LPEVgSWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8776

This make the default BAP QoS parameters for PA Create Sync public,
to be available to other plugins that might need to listen for
Broadcasters (like BASS).
---
 profiles/audio/bap.c | 2 +-
 profiles/audio/bap.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 98b28f15a..dbea59776 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -150,7 +150,7 @@ static struct queue *adapters;
  * The full QOS is populated at the time the user selects and endpoint and
  * configures it using SetConfiguration.
  */
-static struct bt_iso_qos bap_sink_pa_qos = {
+struct bt_iso_qos bap_sink_pa_qos = {
 	.bcast = {
 		.options		= 0x00,
 		.skip			= 0x0000,
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index cf2593db8..98bea558c 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -11,6 +11,8 @@ typedef void (*bap_stream_cb_t)(uint8_t bis, uint8_t sgrp,
 		struct iovec *caps, struct iovec *meta,
 		struct bt_iso_qos *qos, void *user_data);
 
+extern struct bt_iso_qos bap_sink_pa_qos;
+
 struct bt_bap *bap_get_session(struct btd_device *device);
 void bap_scan_delegator_probe(struct btd_device *device);
 
-- 
2.43.0

