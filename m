Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4A19D063
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098389; cv=fail; b=ahuD0uuLEf585jX9kL3P+QSjmS3HsTjqjlVqYKJOvLpo6wRoyJb7KThaT+5T+hUNLS393khKPyU3OsMEJ77YRI+YpkHQ2H84bCWBsb2eJ58nLFaLAbbzzM/bBU2uiDERq9awvvHIXnzyH/3ux6vbtMVVcC5+8yVKs1xm98uh2BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098389; c=relaxed/simple;
	bh=VSQqDI/KvjPp/Xhad5XuqiArJNRl2ZVszpE9wQx55BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kBEufxJ+A76a07xk6d0HVpzYSUFGT9xKbWfsuGmECDwak1eyICc399XTJZYWtzVJVKFqhrgJN99+3GSsFf55b8n+0n9SmkDhvLW9fIDVp2L4dJ+u9Li0J6vBpfPTcgdYcTgAed8TWVNpQAZjCcgCoqFLYeWXvaMsAxkivV/WUas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UYgqBmiR; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYgqBmiR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XW7PsVlU59VBxpz31u1fd+h/VCRjYco9IyEQG1sAVQuYKNwRCOXCWea02RzSzGP3zDfKh3XwMntOvj/4Tf1dQOOSn8Yjma2AR2Fl2O8m2dJGFoCKXeDygr4GZI8ujZPH9qHt4V7FnZtKM/X2CchTW4gc134On4VUmI80COETiWcZ5Jxqn8sixYYgc8LV/3se1ppkTFvmxsErYGsqY/74X7KPSFf/ylTbIZczBUJuLvgIComU92WIxqtVu7x1KBwboO44VCnnrQbGbr2nstkv5RE7WL57+boYW3S8exxne/fwbOa1dmztMvBrtOsdyctaXQyjt4Ut4v64e+kS+2zLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RuJIhM5uJW9TwzU2NZ+Xc/U8fXHUVVsb61igd+FcbI=;
 b=nZ/GD7IGBxQiDCdUb1qJocjBGwyesO8tyjvAdnSDEwkvjlks3FtVGNh2LOnlflX3OE1szFK52w9Fpgyx1LAdXrv4ywrWia0LCajLhNCjl9kGkkOs0uSv+gjuIpt6XxQLa+WSC2YL/pOcmUOuyrCOxWGEUD+5PYCrCFhfpdUsC9mLcZzFDs9nQzuwYq4RfAA+XMm9VU/+5kz031GjRmu4jJ1fmveFqlT+JpPsvOHN9dRz8XAfMrRSaorZAJVyTmMSXoken2Aija91w5rSlAkAp9qtWyUq7a9kVrXTj8IMaQj4KYIWeWbRQNcty4nyzBboS120IoDGw3OL/Qm0Fn4UbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RuJIhM5uJW9TwzU2NZ+Xc/U8fXHUVVsb61igd+FcbI=;
 b=UYgqBmiRKoMrpqxCKqdTkhNv3yxr7PthHYA18fombUzxXU/OpdniIYcasrgu9FKwooVgBnGW5dCkveHYSU0MLQwRQYR1D+rnhBHpdGPu2ZiASi4j0Q3ZoVqPIc77i/S0VZy5UQV44n4FXnBWYmrU/gM+GcSJbBLi6J9BTKTS63K53EdbNBeg5kMvxKlqyxs5vGX1NKblcauEIBT213CT+UQatimrZuCH53R3uNa2MY137Z5BbWI7XTYZCAme41H8apP2ZBEkYN5nJqKchlHGpDXKTZ/UyWSgTz5b3v7yrmkTiUoADThMc5fq37J0HKT2lyiqzHZ/uBCRbvKJH84ghg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8904.eurprd04.prod.outlook.com (2603:10a6:10:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 10:26:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:26:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 4/7] bap: Make default PA sync QoS public
Date: Wed, 20 Nov 2024 12:25:58 +0200
Message-ID: <20241120102601.38415-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
References: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dacdfe1-c1aa-46f6-60a3-08dd094dc964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2njTrE3YprCcsjF5HtgP+xmW0iAm7mM1Y54QRy33alzDmotBfKwNM88LrO1A?=
 =?us-ascii?Q?gwWfvafjorh1fbURagm/toaupTgkBNaNcoGa5gifKsOrix5+H6YSq1C79LHh?=
 =?us-ascii?Q?AE6ZXs0eg/KSRqnPALPIyODPpxVSCS1i3CqXIsrZQ7HmytahTIJUToBJu57f?=
 =?us-ascii?Q?LwTgW4KyO4meE+tAULqKiVJ5SghBZSn88WKVEZoPUuvM6EHriBGa8HSO4NZB?=
 =?us-ascii?Q?NJWK/HZx7+0Kmwj1EKo251Fz0/dOIBNH7rD+A/+f0JW2HiE04L5Qr1A7mCS/?=
 =?us-ascii?Q?mFn9L4TRGCBrwpBGT2HZiwF84QUTZsXq4N6m8jC49gpDndc9/0IBCJHNGJtG?=
 =?us-ascii?Q?mw3t9L/DMWfeDdHZbgaKlO7E981pXZzb4BLk7/Lce2V4fu1lE6w9miZr5US6?=
 =?us-ascii?Q?2IdJO9z6intKybsJSgGyg84PxzVuzuFMPojHswdUqi0eh6IDO/ytMFfZOTWS?=
 =?us-ascii?Q?khxjuam5F70e//4yh6R6LNzw4JcWKADrOwEcoD0lEaMoXUu2NLedXDWBTWlF?=
 =?us-ascii?Q?Kvus1A0Fvznn5XA599hRSdQ70OWQrLuZiv3/pmyqqiunXrxGqp4174lxeLso?=
 =?us-ascii?Q?lvhr6awaetDbFllys4+nft8AdivYFf/m3acuD4E1E2LOLwWeGofwMZgjReiO?=
 =?us-ascii?Q?DI/y6DNnGaV9q1o4AYI6gXPLvUS4E5nPOynXHzOcmJdK+Vg1SlQ/0EDfqVYi?=
 =?us-ascii?Q?5tnYDX7d0iCkdQJe6nZ/vslt/cIj5tQnja0ca0QCy29G63HhZ46GZEubuI1+?=
 =?us-ascii?Q?e317+onA2t63wmJMzlmTyjElU/vQpvwB8siUnsPFUJlaxWDztXlgPSYhiwJv?=
 =?us-ascii?Q?wFzndFVViBkUzx2kiBXS7VGXLO5yrYgMOZvnIlLqNPs3ZBtr5G1GY0BoJb5q?=
 =?us-ascii?Q?cW3WJO1H+2oLLwY/Y/ArsFxEjJs2gwulATOwOamZhf4syd0IowwKSsHE3XJs?=
 =?us-ascii?Q?dGTKfa1fL1EaZ8Pm/uUsbdPhTwQO2rrmUDxGQAgx/22QH/qevG44uhQCD7vb?=
 =?us-ascii?Q?ekcO2OrfT2f6CyGCyXruG2t2s/qvUOy0xnrrd/mvJXhEDemZLASC7F7sl8Dz?=
 =?us-ascii?Q?YAZ5z8zPfxn/lvUv8PS+wu3qjW7T7va+WLCwKIE0ODxXXs7muXrYEbyj3CYF?=
 =?us-ascii?Q?j4TDAnnEmdMWyYko1NtjZAk8OYTT4E29+E589Y5zA5uVXDYJxg1P633xN2vv?=
 =?us-ascii?Q?P2mcqZe+TiAY7ubl1+7fdIVIaAKB5Uuxs4KmLUx0J0myYzFIQp+XZDz8BYeb?=
 =?us-ascii?Q?jQCBaJ1/S17nzdfMNWdRq39G0tHUeRBQf3p569MsJ0RgJ9gPk1ynAsYxyulP?=
 =?us-ascii?Q?1PXsRDVl8Gy70WL4pQao3+Ms?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/R9gXslywph3JrBGIv9zAsXZuYEzSOU9WBOjhnYnOKcDl5HBViJTkR20TI5R?=
 =?us-ascii?Q?cWt2qOnyCFSDqBerZm/fzmHi7KJx7+RNAqii9AuIXXmzuw3IWU3YeKyWVnWB?=
 =?us-ascii?Q?tKuBKb3LpxEO+OxRvZQVhvWHqX9JxIJY7cyz+ymevTESymWrqRz4TyhcXXxq?=
 =?us-ascii?Q?/oLJ3zZnC/ARbtEu/EGM+tzA/Jsin7x6oHlnEBmSfTk/SL+r/2JYKE4fvAb/?=
 =?us-ascii?Q?biotPExhYVSPPfSUzw/KbbDbS9beXBxGWC/eimJ+iZBdhd5zXmoZMJEbYuZ6?=
 =?us-ascii?Q?+cPXlRJA+mgBNpB/PcxTnAIp891lOZZtGlmPpgc13gAMgnX4UoDewn68islp?=
 =?us-ascii?Q?sownlds44aq1iNX9BcsDx1JOSrpj9OdNO0ZThTKLOq4ljCsmLDRcQCsIIs2G?=
 =?us-ascii?Q?tqTK+N1lSVxpPs9C5y00+S5r99kJ8X+OV3wjtI6p9Ga0Bwo/bnrAGE2V09hV?=
 =?us-ascii?Q?m4Ozxu97AHN4qyMJShPSuotAA8mhmABqbugxieektAtVvEEILlVqA4m3pO3Y?=
 =?us-ascii?Q?HUP/KPzieTFL0RF9Xq2poOMOhLytXD1+ndKzTgLmTEXq59kfptnmrmnvYdCl?=
 =?us-ascii?Q?l1RmBKzUdLbvgRxLptF7JKF84d+K6/w+nQ0zwZF6EjeCbosSib1mcOOCOFxP?=
 =?us-ascii?Q?Sl3i/cxpxk+sjTHKtBQmsDKzjJbQOYkbz9sJL4x5S1leZbbiaPgE2P3SgomZ?=
 =?us-ascii?Q?Yc5z6r/vjKYbJrT4ZcUB/Eopr2+Ztr3OVwJw99zzMjkzhl2iC79TYsaTG8Jv?=
 =?us-ascii?Q?ipPCNTZpY7UUOucGAaNxw3IowJeohDxhzxnUyPqqQUA3zXW0tFGNTWNGuwd3?=
 =?us-ascii?Q?Olf2oX07qol4JSPpbE8CBgGJqFP732VwK92t5hVMFGqw30mCSU0CszaLdRqN?=
 =?us-ascii?Q?DK6wT+EEcbhkJeHIrK7gct/D54S/hgd+ciBE7UErwma31A6mJ2OW5eBYZ3s5?=
 =?us-ascii?Q?sxmnYnmquqscr0AS4Theb5GvcypBVxPnlys5UMDTW2mAYuk3DBvg6DV6AgAt?=
 =?us-ascii?Q?5WlGFz+EnBWmBVII8RD6EkacmrF1khNnmACrmSOTO8+yx26mkhkcsPAabYml?=
 =?us-ascii?Q?B4YhUBiT6LXLKdA/p2jNcDbYWFgm887yuBJjNOLIadmfhJHe6WcojXweBHKl?=
 =?us-ascii?Q?dG5s771MjKXdU1WNPL9alHaAei8mButvn7eEJMbBxnt2G3r4vvVz/Tl2Lghu?=
 =?us-ascii?Q?Nt2yY+JRvVgtrkZ3S5rK7Dzr6ffz0TZ8ACwAxWhB3PwXjLDWXnJvlzfeNQR5?=
 =?us-ascii?Q?gQOo4abAk5yy1hR5N/T0/cB5JqQk9Bz4sYmrgZxHsDkc8PAzrskWEu8QuPJK?=
 =?us-ascii?Q?4zUxZWASKcLPMe2rmrHpoEJcD3Xglap8dGe5vRx/UldNz4kDGmX1aSb+ItRz?=
 =?us-ascii?Q?57NXY1YLORGZvVC2OnHgPLH/ybSXzWGUD3SrJIdMd4UUHRdZkiBmvM0FIpP/?=
 =?us-ascii?Q?Ve3vavRhVKyF3/oTs3YDwEdT5HeQTAd9CozdDdDpM6UNqw+hfk5I6eHjXxj3?=
 =?us-ascii?Q?J0TR3rHAR+zD+i+fFpDuCg8A4k2WI369Yfl6NDCxZXTg2n3oAEbsIhbqhrof?=
 =?us-ascii?Q?ZZ5i/OUGfqx+Tox23OXOiYf7EeFY+z0qoaPxKKdGj3tIG3gzlr7RYbC7DBBX?=
 =?us-ascii?Q?mA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dacdfe1-c1aa-46f6-60a3-08dd094dc964
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:26:25.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kfDp/T8WdsFbsNesAdU/R74wb+Hgl8/GRBMeQ7NKMRRIN5ic42duryJ0Zwg7/54Hc0xvEu51sW2QRNEnhAGyaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8904

This make the default BAP QoS parameters for PA Create Sync public,
to be available to other plugins that might need to listen for
Broadcasters (like BASS).
---
 profiles/audio/bap.c | 2 +-
 profiles/audio/bap.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 2a194d709..675c33c6d 100644
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
index 2968f6216..fcc443dbb 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -7,6 +7,8 @@
  *
  */
 
+extern struct bt_iso_qos bap_sink_pa_qos;
+
 struct bt_bap *bap_get_session(struct btd_device *device);
 void bap_scan_delegator_probe(struct btd_device *device);
 
-- 
2.43.0

