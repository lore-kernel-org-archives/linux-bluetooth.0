Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F45146D6B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864665; cv=fail; b=OZ1gS7tE3ee8yBf6g9YUBZ51XIyywxR8fmAh3jf5ZIHsmlp22+nhGrfuCFNy+4C4f5Vd1eeTOBsKy/a9SAIawwLFc6BYd/0gFo0pkJFsJx5blJ5xn3oI34rYNXgwlwTZoesqeym2wtsqX/tyblkBf6eYB7+RuZbupAebOf8MOCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864665; c=relaxed/simple;
	bh=UiLc1Wd1TWODP3EL8PVlsGmCbucKc4tpmkQYM994M/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vi3Eprkrt1SrPKGH6ih3Fmb5snHivXb1xyXJxVHamenwIfMKVKKwaD9pbf99dbHJUrx5gaX1n04MkKA8upDyyU3pkaRk7Rlqx0p23k/veLvR2S7n2qCaWtNskMRtcYJbydwy10wtROeN2HaDVyCn8qB3rMHNTOFqjZyVrd9MPyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=p/ekyK28; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="p/ekyK28"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2gLdGenaIn1VFQRIlCMXIgcqov2XeXSlo2p8Y9lfPPYe4+JAqykSF/Qhvljt8rTqCPdKjxDTY3Y3xO3cVhjqftIDaNo+p6TNNdQ5hdMH81FQd8OwRfWea+dAes7OaZ79xCypVYDns8EhDbgHCH3V6K0Kwy7KuyxA5ZUPtkaFGhc3wTuvMm1suhKQtxyMJz+sTP4k18a67/P5NljJx+uqlfA9zbgi7tjWGUr6Lwr6MLu9Yh9T+6btjMnhRXHf7PWg+eDNKVkTEiblJG2JULHW4G4ggokJyHWeGd+wnX3p3858ZLOiykp38H1WrglfvUnw/drSt6ccepZsljSy2WWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJTqhgFmE78NyhyzvCDE+29vlVPvl0KdXNA4D2G9DXQ=;
 b=PvNIhl1DaMI9EAy9nuhfzX9qxdtBvVwR61th7OxRA7MLvTNocX6tU4qos6Lneis9XP/SQ6JgDHaGVNAdbzC7VbRNEXLDJjzMtEL1m0id+p4AorxH4zhSSliTklQ2imLPcTjg+4BtajWxx1uBDJS6U34fBtFhi+PLDRN2W+3s4XBNw9X4N65WqWHnVfLu1zUTz7/wP6iCweNchyM14tDKHX3L2RQ94i3Myj6fdrRHYlM5IavuCaVwdRPYz8heaRZmsUx8gFl65XTG/N4Z8/lnewtYkl+TU6B38doysi4DFgUN6l43KYXOAh6pNwnXVRMvz8EN3gs6COeIfNhgneRknw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJTqhgFmE78NyhyzvCDE+29vlVPvl0KdXNA4D2G9DXQ=;
 b=p/ekyK28dhZdhmUOuj6B/s+g4Dq4MIFJA+OYOXNHrsu5WMcOQ2furSlnIkNiwlqefvpRIP9+a142BKoUALR4vxYr5fAFZc9BGrYD4tf5bxbGZlt9oNOIL5Ef2DvssV5BhZCywWB6+at2XvuUtOX64RzW/lls3mLX3YXiAZCQBsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 13:04:11 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:04:11 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 5/6] shared/bap: Return the local PAC when matching a BIS
Date: Thu, 16 May 2024 16:03:59 +0300
Message-Id: <20240516130400.16713-6-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
References: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0079.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::20) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: ef062ecd-6ca1-4a51-6def-08dc75a8adee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9HV05dvfc2QmeKNug6L6htRCZ9Hkb7tr/Hcyo6ONmoYMBEUqUggCiTfIbGm?=
 =?us-ascii?Q?hrU2Jp2iCtoigDzAfwdCu1TKS/p8cBxJF4DZzZZwTtWCoLBw+x4EcOULyEP3?=
 =?us-ascii?Q?ZS4haRbVHLhZZ6w8Aze5LmPVcR9T7mlc71knv+MVBG9fgjZojc5WfaJoD5nY?=
 =?us-ascii?Q?NZkCIIV4ZvF7uYwhXkjDl8WDQbg1deXUwaNMZDgIqa09qgr3RJXEr+NXZFhZ?=
 =?us-ascii?Q?LKrPgrJJr+GG3B6bllGCl2O6o64cvFJQ/dKlKiWql3iMBlpiqq/b2cyzd7bR?=
 =?us-ascii?Q?QWyPEdaJm9PSIBg3lsgq3eFUTDkcGCsiaOJFC5GFbvkE5Y6KRLpIEUpMHKAb?=
 =?us-ascii?Q?4PD2O+C8RBALt/DW0ZWUax6857YiUgRUaOoYAsluWO+ffUm8gsOkVyugqWK9?=
 =?us-ascii?Q?xJkoFb3K7z4hNTC+l2k0eO5QEqm9jmJ3vUr1rAp9EW6/evgO07p8diKKc4lB?=
 =?us-ascii?Q?/naKFP1deckMAmzrTMlHWlH+7i5N121mwjkxjpK6e2of0f9lxIOqGVkVm3Va?=
 =?us-ascii?Q?2L3xnxTh6spOC7h9NKXWcBkj3aMrLh76LuS7zC/CuVt5KMgn4WA0AwFjkbK7?=
 =?us-ascii?Q?xhrt1lpiJZ16STHK0OhLu9i2Rby7SoUuyDoYd6pU/tE6XYTYsRhB1pb+uSjV?=
 =?us-ascii?Q?PipRjJ/ekYOa1m3ifgO0VKt/M+HPCyOmPCuYS0NI5qpRuN4Fk61nIviemqzc?=
 =?us-ascii?Q?CWj+XuD0EJ9HXY6m7QQ3vD9CF0dWKG3OuqTGEL0AQpntCTiUnPbH+HJmWjlG?=
 =?us-ascii?Q?nKCWFrHdoFIxoZxrUvOiB9q1XQn7S55KPf96LIMTu6wk81MBumDdda+RHI5a?=
 =?us-ascii?Q?A6lLQC6EfX7l8dEGJeJYG6bDZJr8loudgjUgpSQJaACzZBfOtQPzzBOnOXqq?=
 =?us-ascii?Q?KhNj7AcuhFj8tOAje74rouwO7uF2eDHxGBIBJRtiUW/FNC6PtpB+KIydLD3g?=
 =?us-ascii?Q?ae/3+1ABL0tEUl5wOFmlbmFF1/wuQzgx/OeebuuIUSde4o+8uenJ9bGmOJqb?=
 =?us-ascii?Q?QWmXClzYMFtUyt5BfxCGKnZmOkd/xjXzPMmyAlNGdLBR4rcZc5/Dkjfr8PTC?=
 =?us-ascii?Q?hcH94BHOIqdsgP901uxprPTRPNidqObY47HoAccNWGRQ1jybfgAAYe5xR6vw?=
 =?us-ascii?Q?If3ltuEalFCvaMhKZ2HILop4zNL/eWp6Q5R1CjZT2WUawMCJYN0nHy+VXI7c?=
 =?us-ascii?Q?aMYFjT17X2GwpVNVxfVVV9hNvLoL/W3J/BiYqPjFG/7juvdd4GS0jZuvecvf?=
 =?us-ascii?Q?FACPwK4UJM/M063WSGhHLituwn2uKM7zACid4QUDEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?baQGtlw7nW9uSL5BaVnyRNuBhMVjNk5jlqGwI7ADC/EpvQVWSXORV4FFI+BS?=
 =?us-ascii?Q?1zUIXbIHYLTTs1bRZ9uyBFSuoj5LGugkMpNtMzI2HfmuTOveGHnf2D4DGhbJ?=
 =?us-ascii?Q?aHHapiMGTkk4KUdj3lBaBxUX/cUbNATkSwviBG3PX/1ri6ngPuskYCQCn9VO?=
 =?us-ascii?Q?ddAUIOHzagSOEx1U1uu91zZMdmuvht4fAuTKRAyWxV90qP8JUk2eXlD1QlKI?=
 =?us-ascii?Q?CzWFeLfD3e5agKggVqkz9iI5tPIheaJsVW/ckrn4PJqoMrcMif2fpAis0Y7c?=
 =?us-ascii?Q?Grm4sTPdMmqzUbhAw5DiayTozVQmzQ/4WQr76jXDh0m6zwvCu6skNK0vX1YE?=
 =?us-ascii?Q?QH4oUa6bwR2Jl0coulPHRc0eis78s/HjZzRUyHIA7QZ0Z+9Yi62nfcYQGGcj?=
 =?us-ascii?Q?tYUO4AbPGec3jMqMpaZvLwmGDMrzUVJGzvNr9ZUdsD2ugqB3RdSQtYNVRdaV?=
 =?us-ascii?Q?j0g9I891GOxKNMpPisoaNUoghAlpH2z14Qf663pS1LCVkTvN3dQam37iofvN?=
 =?us-ascii?Q?flruvGYp1hjO0g1a3HXUCvTt5LIJsIvixIUJ2UE3cJn7zyrUqCe/TtXJrnmI?=
 =?us-ascii?Q?zo15Gh0osZrsmFbquX9E+cwBM+84eSybZ8tUzOxHqcY+A/hYijD8TiW0x9zC?=
 =?us-ascii?Q?J1FgBU5F7TTfiqfqDnkZB3KbmJpzQDCtqXJXIWd8NW4qudhC14hBGbpnACyA?=
 =?us-ascii?Q?AuwkemWJimq1RldPdU6bbt5IffA2kJd7b5Qz7q8211Ik1yZVTj1E/Xx5x9Xt?=
 =?us-ascii?Q?7dh/CFcRgFCHYI95D8oFuCDyzI9Vp0Aj1cXlTf39X73EF5A1g80d2KkrLkqa?=
 =?us-ascii?Q?4FQmEdNU2jN6Q8XamOCRksyHHbWn3jcarPw5W3h78i4mN+l31QocZ2VLPwrR?=
 =?us-ascii?Q?dCoMLJgGzUmSsLYdhpQMDTx1mh+QKGG1GRaUM6H3nKyZRIiifTSN5lfn0z/n?=
 =?us-ascii?Q?5NMMYm25GxBOhk2HjMsqkhZMHD+nFngTlOJ4bUJw8/lTzembdbjRUl7X5N9Y?=
 =?us-ascii?Q?yanjxnAvOgoKqyKCEJSacFHG7n/xIvwMLJ14HsxYurw4fU1vQ+4ONjpsp8/u?=
 =?us-ascii?Q?5UkcKEDx4JcK7lCjgiNnWCIw7a4FBAB1BEDWYHpc6zrhGP97t36aBSHWXgnF?=
 =?us-ascii?Q?XhbCispQXGwJaRxqY1nZdt0n2b5sZL0CWl9B/bn6nDwV8KTiB5y0cCpSpgOb?=
 =?us-ascii?Q?mfCCC2ZP27WBGm/8545zj1wFXvUEUPtWtsETjh6fNGtMj3vkmhKmRfd4Tx3k?=
 =?us-ascii?Q?c3Zd56l2fq1KuP0zMXwTS5Rh+c8fxkttboP4o4LH9FTBdBUei/mIyoHTkbzt?=
 =?us-ascii?Q?DeQjYpYs/eDk5RkN9kbTIkkWmFC/fhwdP9OkS+Upqa7wDsTwh/AGxs629xvL?=
 =?us-ascii?Q?GbTt9QitVRuOHbO3sIq/DMeItVmGGmMOgoW96E4HhNJG0oNfoh4HHSpMOLOZ?=
 =?us-ascii?Q?ePO8PPp+KH90ZZJ3i9pU2N7JGEQHb5sIl7Q5PYNedWyZUJ97zP5irEXgbh1V?=
 =?us-ascii?Q?lsdWvkjCKOOCeTNWd5LbthzVz1uCDRjjCPOLRmY8LySTIXzxtCUoroVdR3N2?=
 =?us-ascii?Q?xZs0JThbglYShSBkbRnMti97eK1H4CviTiMfKx6MtUh4gtfLQKe16zR3f3PC?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef062ecd-6ca1-4a51-6def-08dc75a8adee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:04:11.3706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ikn9zl33sbl0w8PczJiCCPsxQXQsGUyKk8Z66yAbymYvuLZutHF/ut3FFnpAYYoF065oxmB++V6E/9yUURq3cNntvc6nqtbDhvchTORo9wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

---
 src/shared/bap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 1d1a6b25d1a9..802b8a21da73 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6398,9 +6398,11 @@ static void check_local_pac(void *data, void *user_data)
 
 		/* We have a match if all selected LTVs have a match */
 		if ((bis_compare_data.data32 &
-			CODEC_SPECIFIC_CONFIGURATION_MASK) ==
-			CODEC_SPECIFIC_CONFIGURATION_MASK)
+				CODEC_SPECIFIC_CONFIGURATION_MASK) ==
+				CODEC_SPECIFIC_CONFIGURATION_MASK) {
 			compare_data->found = true;
+			compare_data->data = data;
+		}
 	}
 }
 
@@ -6482,6 +6484,7 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 	match_data = bap_check_bis(bap->ldb, merge_data.result);
 	if (match_data.found == true) {
 		*caps = merge_data.result;
+		*lpac = match_data.data;
 		DBG(bap, "Matching BIS %i", bis_index);
 	} else {
 		util_iov_free(merge_data.result, 1);
-- 
2.40.1

