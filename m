Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010000.outbound.protection.outlook.com [52.101.84.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9B3164B5
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338055; cv=fail; b=QmW0tssXmbwmQTXD8PZhvyPSkqcbTENSehi/k+/AA+f1KSCxKbI+QjtA0Ql2nWwTgSaCfAi1XnPSie9TfNll0Ar3U0BFw1oYxQmaLhA5XGwqKAfzeXkEa3f+cbS4efPkOT4TFGtkSuQAnCPxHt4PVZQexK0UokA96w70rJrYVkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338055; c=relaxed/simple;
	bh=E0iPF8q6NsqO8CuGPI2c9q3fsIX0ou3k7Nn1c6xN3zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bS9F54MMw4pp/VP5Dhnu/p0KVDGBAXJGU9pmFyBhjFIDa49+R3OH27rTpwr9oA3IkilEQNtZwYAexQmGKacnsJFPUO+s7UnImaIZObsdxUi+dadnYND5BqlsC6LTLKKn30/708d1hmMc7i/NT4LepokIbd0hmshXwop9bfptXNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V0600N4L; arc=fail smtp.client-ip=52.101.84.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V0600N4L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEjV0Kjt1fSd62/IhWhhmnMx0iikIX147rgGEbADVEsbWX8319gR8NGxh2yLQWYT6P7EHpCavM+ms3Edkuz25bZkQTJXYKWglaazx3Szbdx7XQqR6S9Zi4BQmaRptRMTx9vOeez0nYv6qno4IvC3kqMA1LgmjF6XXJwHOliUR30iKDQZPuNHczOmuSWS8UwY6qVKDyqjkW3yI8JlbgTBc5/0j4iW2HBCrG5l/a3WHqjZkTkO93tWs1WvkKIiuDpjovfFNy4i6uXoGkeLYPikH1VUuuivyVFbfDKvsZbSRRRuoWQMh17aDSPo3Vw1FFUpvhkWB/jBY9dZuFfbLcuVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYjvRjVpAMPxnKOM2Y7Z2Gn1eHPFXXS9MywHuvZ7bLs=;
 b=i4Y637e5IGCUygoaF+BzWkPdAUZ34l1DQX9DJlnk1ghssF+DBZKwAuxLk8Iz7/m2JIe8oU8GKEdafG8iET8Kv2jm0dVn/vFIbUcohHHhswD2xCkB/iOvc35gyzdwfptljWG4DHeiXBUJry/MjWyj2mmHkM0dlSY4+8SRacenGqjqC+RFwKzGRs3d+idUjMJIuiaeTh8bRPIK+190X4O8KFdui1/m2CL44Z6W9lHDQHGc1fAw9256onQiTfLaAEp7wGdWTkWTOlzJ8eiQZQa19ePehlCau6u+Lc5ZbAy1wKebTBln5bqXfxIuBmKz0iygRL+zsBK0f5PIFL4sSLXPTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYjvRjVpAMPxnKOM2Y7Z2Gn1eHPFXXS9MywHuvZ7bLs=;
 b=V0600N4L8IUg2IYXzzX2vn29PyzMWJo8fChzNk48YMnRgwnudaPGNC1HuKuipF9oWcrpOTXXek9+rdt47pTrmc34fmHll1OGoTSroHQwUeOCdyHHW/X6gLD1Y3VJKtJFg1M64nmvVVOMU1dre0uZvzdsuvRFzazLsUA3ae1CFeb+NBmtQeRl8Dpvx4Yvcx00c/QQcASqHeU3EgnS7bmhxc39ae0dezyInWuPZodCh8BRChdJkGCLshyxA+QWeVKTC5qvfXf4YMr569E/nZFn/QjVV8y7++3wKAQ49V2tKL3ywu61Td9ajgI4ubAopRPVEL6bicp0CDmBS4oBkGITYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15) by DU2PR04MB8823.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 14:20:52 +0000
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8]) by GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 14:20:52 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	pav@iki.fi
Cc: vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 1/1] bass: Fix use-after-free when rescanning broadcast sources
Date: Tue, 17 Feb 2026 19:50:17 +0530
Message-ID: <20260217142017.1554-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260217142017.1554-1-sarveshwar.bajaj@nxp.com>
References: <20260217142017.1554-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12191:EE_|DU2PR04MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e71aac-6bff-4dfb-869c-08de6e2fc138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U6S3RZeugt+CycRi+csXXceNb+EVXcLrvmcLzStadEhXXi4a8P3dj3mjEEUc?=
 =?us-ascii?Q?uNT+trwU7Yycj6CCdnVjRIcRWCtFpQMYqidzhhSj5eFcUaQ6EgdtmVseccm3?=
 =?us-ascii?Q?e2rNkDdrLtsvFg5J8UJ/vny34MN6xbYQwWLffnFm6n5Uo+MQhr+wbd43zo1h?=
 =?us-ascii?Q?S0f1Qrq/iGKC0a0eWJe9Ywi1Jk0lvtrsoCYtjTurdSf5P8sDhAr7BCnIG992?=
 =?us-ascii?Q?qxIagKuDA9cpRg82FvmYl7rDcVjHBgwetGwYiiv9e73i+mGT/M5+ha8fAaHq?=
 =?us-ascii?Q?/nKXDS+86YKaDjnnxYfttNf1luoWdQ6B3kkdv4oUHvuH9lMAUD3a8Qh1Xh51?=
 =?us-ascii?Q?dDAFL/3LFJYRX+Lr9qUcXBGlnlcpbCfElK3FuhrMbe7hcAQ5R0bpf7EP1Vm6?=
 =?us-ascii?Q?4XcGf53QjFMGORS529B25p+rabEzwlBIfnYS0uaUULhyLFhdb++ElrHMDo6i?=
 =?us-ascii?Q?90kcqjGz7RFpfLXJCZnKNb9TG7UYtVrVdH6BHf/06kqcx3ddO5ZpJZgXT2fI?=
 =?us-ascii?Q?FZarDQ4v8bUeJM7mE1M1oCkfZA2nnCug/GX4FS6Bdve1SH5eVuWpfZptCt11?=
 =?us-ascii?Q?nXappdxMY1bVuNI/TeTkwPgfReLxfSM2iRuZDFS22P/e4D1WUrrsiBpYQWgA?=
 =?us-ascii?Q?mFTKdcp0NjNBKx3o+FtR5qAlgUSLE6usKFN+WKTdrlvEjQ8yDgMj7qItz/ON?=
 =?us-ascii?Q?OFEnBLN3us4U/ZM1f9dhfgrKuDRwd2GythrIy0q56a0e18Q5lQB80ppuHGLe?=
 =?us-ascii?Q?RWLU2DD8UB5vueKMM4prRiR4gBq8ABgYGjUE5lLE06w12mCwY8pFNgpNq43m?=
 =?us-ascii?Q?XRlS7zuG6iOeaRdozF9H3dMOUDjBEq6bdK/7NFlJF8ZByUkxSTHHZl02alY7?=
 =?us-ascii?Q?htpKzKlp6R9aHipns5YogfZVf/gp/z0EUihWprpkcW8uiWb/lNJWS803ZQso?=
 =?us-ascii?Q?rhcgS18dm9D8rfoQMNytD+mmCNQLFSejg0UHqfd/SufxqN3RAC6KnaMixkdJ?=
 =?us-ascii?Q?oox4IQh6vSgrDsI4SwIKMWMAYGzN0ZofvTOIgEzFW5wl+8aMQkqAMOispNcj?=
 =?us-ascii?Q?/5di5q3f+rBMJrd6LcSET7r6lW+B0/8H+q3Rgn1GtYMJBpvEJeaLgbNnC3aW?=
 =?us-ascii?Q?PLbjvmQdLHklJ27vEbfXqZuTgk3SbT5vjX5u+HvfVVt9SY5Lqb4ffpF1RrUI?=
 =?us-ascii?Q?3AU1pPV/SDFGY4hu42ygE2b6CfS19OXViWoDe+8RkCGJpRfzKr+4BaLnMsOX?=
 =?us-ascii?Q?BURPUnpe+y04Ct/UteL1W/6v6sHnIIufPXntaxhurcT047OE5mZ65L4tp3bq?=
 =?us-ascii?Q?RUkqAYvr0GFLe+xbrZxy1szQKz/Q6KdHWqhWAUTdJwS44zBUNjN4Foq+v/Wb?=
 =?us-ascii?Q?bxuFta6gfdgkBJ/3eaCXGj0bcCm5XZx0qA7TCMi/F2Q0UQC/0ny3/11nWYkA?=
 =?us-ascii?Q?nnt3E19HGQaenaish4WoSqOtDt9PKIqSp/FmTUlQ1l3nEHXV4vghrANbBC2E?=
 =?us-ascii?Q?/epiJJho0zcpCdzAM13Y4/6XbP/3MjhM8CfyEvuVl1cXmIU8RCqlmmnt0iya?=
 =?us-ascii?Q?uJUWxtQ/13u2xQSP9qIu0iGN2cH1X41xaI8FN4wfrkGffihtLCNzKo6dhy6J?=
 =?us-ascii?Q?MkGEF+EsgEQGb3+hz/fIYZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12191.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J4S99tNU9/7kmv5JIVSf2gA7RzT896y8cL8sEDk0o4qycbA9wTzOblhdX4At?=
 =?us-ascii?Q?4T15BKzxptTmaahY/FBnpj3vMiICZuVxtKjMwRpsXqVy/CuBiO6z4T6nE2+t?=
 =?us-ascii?Q?b2pcEmMKvY48KpwCKZOgLsNer2zucIqVlPeOYbChJ4cwKSLLL6ngsSjM6yps?=
 =?us-ascii?Q?ifFghLRNFCVLWKZQ0KpS8HWqAAN/PGfD/uMBGs2vSYgAKVbADxDfEbkG1yy4?=
 =?us-ascii?Q?HSfWefzj/V7+g8Zly7DqcXEjdEUl5OJe125F/ZyKiSDXPKMdrdV17TCIZTbp?=
 =?us-ascii?Q?Udw651po+KdXf+YoHeZ+aT645Aly2/LVS9CfIKJHLTChQxGPk2+Gnn4ikvR3?=
 =?us-ascii?Q?3Y5KWW37JFkVnSlC4nC7eCLdDpy3d77ocfEADzfMuKy2x+l5ai2U+wRPIOTS?=
 =?us-ascii?Q?05PWQkl7l860BWUqjPvWdQvA3S6gjqWCzvUpu1F/2MQfL2dA33ZAahZDRXBj?=
 =?us-ascii?Q?vVyS1lourqBkZoKIDEa7SPp0sgoXxiYfEv4/HVIV+6jJZ1VHsH8Z/5E3k8zn?=
 =?us-ascii?Q?vyf+4R3tSALqyPveiOd1l7ATDkafAE2ehNQA3GE6UgikBr9yEECZErzk0xEq?=
 =?us-ascii?Q?8ZKajOhNxO869aoT6rtMxZxjVY/mRqJA79OryMwc0XmjSu+9lyIlAa+1bVZI?=
 =?us-ascii?Q?1pf49T8zfjKDZN15wXr19hdNLSceUVUX6jK7QQI0ofXyTDX/Jj9YfRB1jCZc?=
 =?us-ascii?Q?RlCl72MJFnlNMzUqWtQ16Ww37ygvMaUk9cqv2ZJ+mNut9Q6+0Re2+tDRfX/Q?=
 =?us-ascii?Q?4IR1Gp2Y+V7N6D66h5mhU5kFVkLdzMyG/hF6dcmVbc8WhCxjuPiJtRDlWGsB?=
 =?us-ascii?Q?jC9xhGa4OpqwNRbuyPAnph2/vckKDdPje3aIFyUF2QkYZVv97eUDQ24tpIKp?=
 =?us-ascii?Q?l27hQKc3CFUGH3/8rWjU9OLnZj3GJpyr6Qo0+S8wjRsgtgNzHS51pQf/193z?=
 =?us-ascii?Q?TLUnyEiqMAk6oRr+Tdn6dNVnn9FRs97T67Nr34iE99BMsKVUCL+cNpLM+twI?=
 =?us-ascii?Q?93jzo+Toy81MNop94hYZnlOCBEctPYB0HV0TQvTVI7dkmrcTOrcJ6uZ83wl1?=
 =?us-ascii?Q?yaxn+ZC8cjWKWQgaWC9/OGl555t2rqmSXOcdB6lhH18Af88rpUMIIS8xwK1s?=
 =?us-ascii?Q?GvcJonIf/iK26F0xNv3io7vQpollJAtWOtpgXTwbabeC35pTVLXvRJ6mRGzs?=
 =?us-ascii?Q?tdrF/8WvAMpMC30osS6jRxofP/8RlWwh4HEm3hWaOfflGlVJMmRqhqPtL0i1?=
 =?us-ascii?Q?WJuVRVs7RpgfdhhaynRXvP5jNOxMlmlzrNq8ltuqqsWRejDSPJTIuJbEO8hx?=
 =?us-ascii?Q?afbqGg7d1hL+zrytSce2wg89GvZk++TWdsHqlPJQVKkOWDJpKIJW+bXv3Ult?=
 =?us-ascii?Q?ZFcIXZ6L2P+sWJqX3ZlH2xUCQC7nTMGmHUal5xSp4uD9MsMVDvJhn1eh3yQz?=
 =?us-ascii?Q?bWBVnjssLgsXiTjEBzrS3F/FHlgVPghMPApD0W/KMNfXdexa2KMUvvSKR4pF?=
 =?us-ascii?Q?KJuyBS1D3pTfy8/bNeFFneFMr5YSBjdtDbvaHla9SvkqL2oaLF2IZyXIO7PY?=
 =?us-ascii?Q?yrNPbZ/5kC88MJG9W57KcAS6YfmVmcNb3JPlqqPTTGcUSCa8ri6d9ZIDz4tx?=
 =?us-ascii?Q?sdPR0D155DP1ujSBOXBa60/arX+SxmEAK2AwEdugg20m9QYvYGP0AtUDGUdP?=
 =?us-ascii?Q?Q0yjeX+lVZpBgJGZr7ZK9koWf6ko2Cu780uZqKuASLAAuKHSYjwT1VmgM1tW?=
 =?us-ascii?Q?AS/pfd74/EKGv1m9y5OCE/FYcsSxU+Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e71aac-6bff-4dfb-869c-08de6e2fc138
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12191.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 14:20:52.0472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya7boyEfVdI2Qf5uiZ/L1Kc2t1FlAsfwF+JN+b4cToh7v38m4GYllLeZ3B4vcYUGOybRbpliY6nXsP7fADWjh7ssl9l4rRrF5rGp/VUYcUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823

When a broadcast source is discovered, bap_attached() allocates a new
bass_data session but does not initialize data->bap. As a result,
bap_detached() cannot match the session using match_bap(), leaving a
stale bass_data entry in the sessions queue with a dangling device
pointer after the temporary device is removed.

During a subsequent scan, bis_probe() iterates over the sessions queue
and dereferences this stale device pointer, triggering a use-after-free
crash:
==151814==ERROR: AddressSanitizer: heap-use-after-free on address
0x7bad5fde0908 at pc 0x64b9501c99ee bp 0x7ffd70517800 sp
0x7ffd705177f0
READ of size 8 at 0x7bad5fde0908 thread T0
    #0 0x64b9501c99ed in device_get_adapter src/device.c:6826
    #1 0x64b95010f04c in bis_probe profiles/audio/bass.c:1561
    #2 0x64b950284395 in bt_bap_bis_probe src/shared/bap.c:5903
    #3 0x64b950104c1f in bis_handler profiles/audio/bap.c:1541
    #4 0x64b95028eb7c in bt_bap_parse_base src/shared/bap.c:7767
    #5 0x64b950104a5b in big_info_report_cb profiles/audio/bap.c:1601

Fix this by:
1. Initializing data->bap in bap_attached() so the session can be
   correctly located and removed in bap_detached().
2. Unregistering the BIS callback in bap_bc_detached() before tearing
   down the session to avoid callbacks referencing freed data.

Link: https://github.com/bluez/bluez/issues/1907
---
 profiles/audio/bass.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 9c8046dad..bf0db0555 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1434,6 +1434,12 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 
 	/* Create BASS session with the Broadcast Source */
 	data = bass_data_new(adapter, device);
+
+	/*
+	 * Store BAP reference so match_bap() can find this session
+	 * when bap_detached() is called during device removal.
+	 */
+	data->bap = bap;
 	data->bis_id = bt_bap_bis_cb_register(bap, bis_probe,
 					bis_remove, device, NULL);
 
@@ -1454,6 +1460,15 @@ static void bap_bc_detached(struct bt_bap *bap, struct bass_data *data)
 {
 	DBG("%p", bap);
 
+	/*
+	 * Unregister BIS callback before removing session to ensure
+	 * no stale device pointers remain in the BAP callback queue.
+	 */
+	if (data->bis_id) {
+		bt_bap_bis_cb_unregister(bap, data->bis_id);
+		data->bis_id = 0;
+	}
+
 	bt_bap_state_unregister(bap, data->state_id);
 	bass_data_remove(data);
 }
-- 
2.51.0

