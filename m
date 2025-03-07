Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83CDF71
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362345; cv=fail; b=mN0baKSVvbYkFGqDfGJ05A5gH0jlDXDC++mJr7t8HbXbzBu1Ic4tOLrOwasaB+J3sEvNfwCQwyNA2yBrVTmj+F0wFFsSlMfXZHive5wcg7pUy32nOTLOr5nmYbppBpk4uDSSlPKcdjdryePSDB14Bt7JYUtRlVrGb2l2bRo+li8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362345; c=relaxed/simple;
	bh=YGJWSjtVHWtv4esQ0I4xf4GUbiumxBIl1zsRMbSFEt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dHaLeZAsAaKDvjBbxTs3jc//R0ZC+6uPYwqcaGI5FESboKS96hMRxF2KK1MeByW4Bkmhm9AyARuzQ6Q65RsJW177onY1z6z+DeFsCHVyk9AZwDOLantPJo+5KzRnpqQOACc3QkwTD6AVf1LhmBv962O10eY8LGEkq3kuda5nJJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dT4QLAaQ; arc=fail smtp.client-ip=40.107.104.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dT4QLAaQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVerPidNDwg/fiXdreOOafCFK9+3tOgbf2LW3TQtIxhS0lm0mFM8Jte7gO3/vOry8ZwZanRDqIypTZKhX/C8hRyI6Kjx+fEXoy/ekVRSprd2EjtOsdWVxgJZd1VNAc+ywS/BmMALIcAN09AK3TmjSSwXXWKNEoCvyKPKB/bnp+kptT8HdyEyNQUxdWuMNvW4TTkFHflP4S5Ugbl60jDdD1yWKRhJUiM3GVaJ/I5G11yLdMRIwGFkuX+xpneLv0o+LeK/ZG0FpRkjbC/axofHZc7zsz55/e3Ceyi05n7G+dKC7J4515Nel/NzNmtnpgRGZKFMSC1j+a5Gk00xcf4TVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blQfwpCL43xe6W4TqD46dHMHQrBULxWpAF/xp+f3I/0=;
 b=hUwVQD79lyhjQeQbvjDZwFRDsBhsSoMVXJ//AvK2Y5Yv/esodrF+UN5TwBPlpW4Ke+zQJpWeTjoHMvvfowXQwG341+b7HEWzGZdSvVdKfMfyFrrhe+E5NXZ+ZyQC3naaTsV+uWNhD4fwnsAxKp3LL+imhurCafEvinTFrI1OwrdK6QYrH2IMpbAKdrp/gXxX0ltc7aBLc62oBz2z84vuqAkBqsBULSBqu6IedDkNhbv6s9/ECUy8JQDyDYzRP7SiE7Ua5cRjDQ2pDzRaDI55wxzZmH4gvGCbczgtL2x4K+js6d4/2MIO08F1Jm4YSunmTNxuSsfWL19Dz5Glt0mOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blQfwpCL43xe6W4TqD46dHMHQrBULxWpAF/xp+f3I/0=;
 b=dT4QLAaQNd2N7bi0NyfUHRG0cwt3GrOQOqmccvpbra175A+haGW4gQ/ugEynEqKM/D4E95W+0sZbsNE6eL/s/GIHRD2clvCBUyHrc7kOagMoSArF+XXwrWmbzyoHPVyq4gvq7t1TsROWM0yM47Gp3oc6VfeySZV65vnJcLgbTyF5BQisTwggRk2P+mzW2lcEbGYZHy5ZoaVtE9e1Z265omgKcEhhpU7gm12E2yhx3x78oL2p8jdyIUzgUt006ar8C4U+kGNhRf3TrlOiLhcoF4/qIg2B9y9Xx0ptVQKrr7EYLAzdlQd9ZSjYX9B5P3T6znEpznlN/jQzqzJMuto+Ug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:45:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 15:45:40 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 6/6] bass: Free stream path
Date: Fri,  7 Mar 2025 17:44:57 +0200
Message-ID: <20250307154457.85751-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
References: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1812f7-d61b-43b9-744d-08dd5d8f1cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T5BdWVEsHLimF7sqof69S8K39L16ykZo4s1oWg3rCtpfZlwO9F2A7BXZgguT?=
 =?us-ascii?Q?qtVFIBoQXERfZh+vCaqps4jscQX3eliG1Io8cHFS5HQsdOz2Rem7pzcKlR2x?=
 =?us-ascii?Q?1DxEarwFFV8MTpJtL3dxsSGUXPzJ+3SLWocehhxCSfP024nmI2sHC45vXNeT?=
 =?us-ascii?Q?YC62r1kdVR46HABMh/il+It2mB4dgg6l5C3ysN9baNWu0c5InV7Ky9qXsHdT?=
 =?us-ascii?Q?hUbFiLH4DG40nqUeFv1RrKf7HO5kr1s4HANe+iVKwILf6EeVDHMiLTUIQC4C?=
 =?us-ascii?Q?Kwl4ZAWK8L3OkfWWybnJ8YzSvJJ3iNEEnVo90XFXq4HW34wTNjOnwdi6kCqw?=
 =?us-ascii?Q?Y6tVlhlKPfrDG3Pfc/Mw7FrIwolWWBh0DvJ/O5KcmBH7UtT+TgWmZ7+d2XgO?=
 =?us-ascii?Q?sEgQOKU50iWqrWdVE0VIDR+iVLULk1CWH1H9kGdyuAWMxliw6MtoZqKtVif2?=
 =?us-ascii?Q?n1RBT1TfrDt+vYrrqE03ACntZbabw5K/WTQuDpEYUEi2pPaUKvVHR9sEIB1Y?=
 =?us-ascii?Q?hTIAhstOep+v94JnPnavrSqWG2YLXO2ZPG8WRqiVcsBIf2k5vCa39zksMHap?=
 =?us-ascii?Q?g8hi7aykvZeqb4vkUdD1PCRWUrmhk9CIRAWD7XaGCsRjYLynG70sH7PZVfxV?=
 =?us-ascii?Q?KQe95/ZCZDmEf5Ptx0qAIvmYugLuSIEw3fy30afc2W0gPbMH38/uG6VgS3oe?=
 =?us-ascii?Q?LRpQbIMeUShz/8E39mi8CMv0FQAj6VcnLXvQ+m4WEceU8EPllQg3b9eF+nfs?=
 =?us-ascii?Q?0+mgGndoeC/i1Nzy3zD/YclJFMPj0yn9FL0DAVMOWAo0ZO5FFAvBqrq4LdPL?=
 =?us-ascii?Q?Iip4IqblgXvYDm1CYcik7N6EWp8/8WzcwNFoPdp/BgqNH4h142z4l5aUwjiB?=
 =?us-ascii?Q?sYk4vytBsqlPWJZIKljnMBTT9bAHO40xsALDpYaRaGEvFEACMKRK1I02IQcv?=
 =?us-ascii?Q?Xzr0oZbUVqoL4yiV2uAOACMzW5ujwqvHc3dMJ/IoGUIZecD5Lvw4Sa9irZF6?=
 =?us-ascii?Q?ytjCYezuYGZNzZraAO8c77xDwzR6D6RkJk4PCerbonyfZ830j5o7HamRtERS?=
 =?us-ascii?Q?XdXEbAi4Vh9kLFIPaE/SSnhrhjdS02uGWBugCkU5ZQyPQYxEHkF5SC/5cAZT?=
 =?us-ascii?Q?Qs2Zn6MiFXQ9RNEePNLY1lpD9ex5JDeBcwAxZk2Il5X7vOGQxIPukk/3u3rI?=
 =?us-ascii?Q?zxM6SkwztHGjnJOigM+KkqTE8Qi18HxM7La1W7i4kvUYYdAqI4g9R12rZlm/?=
 =?us-ascii?Q?vkPOjHUPrNVpE/ct8lKAE60LfxrYO+BS9CJROYcsyeErm7m4bv8XbXDnPfSQ?=
 =?us-ascii?Q?aoGjE+V0zuGagZ/tslzGEVEHK/iDbgBRMQtBnZwyV/VlmhPub5O0c4AJLYwy?=
 =?us-ascii?Q?jjwss7+0ZXAhqpnfgbAS9MqcLAxO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zRDfR2MnKIIC5hAmGa4suKusDudZfFQ7VDha+PqVAQw7kzDI7HzDp0Ag9Mui?=
 =?us-ascii?Q?FSadpQuvMcxng3ae24EwdvrMBvAx+JMJbVjpKp+wGAZk1YzurzmIL2Abs8RV?=
 =?us-ascii?Q?5pOQCbK8drIdJ9jankWJLhLOYYaluy07NAWDOVENNnDGAWUxyfurWUgq358W?=
 =?us-ascii?Q?Ym+NSwN4wTiN6iJNsqUAoZHE1bkNmp/UMgtV8ou21ZKSeyI7ygK6FNomPXtk?=
 =?us-ascii?Q?4oY56TPaa3Vo+su+9Pt/0ZHPp0fUiz6yL4GKt7ladr2SvB2mcR7k7qeTGZgM?=
 =?us-ascii?Q?24YJPSYhMmB4VXfwPVXXZDWCHE20pn4DA5ZVlpH2W/FOsHYc+hRmxJwvzEvF?=
 =?us-ascii?Q?zP8hPOv0hea/CR/ruxQ6sJbfOPQffcpZrIsRnfEia/8weujY/4GKCu/XeO0Q?=
 =?us-ascii?Q?2vbPg3/wHo7dmGgT9xxhiN454ogAPz03ywzZmoIpZ+nvRCxIiSHSSKCohWeB?=
 =?us-ascii?Q?sUSPjhupaFREBoON79R9aKpHeL+6eS1CfuCq/8taLhHazE2odTiA8r61jB++?=
 =?us-ascii?Q?p0oX0PTskjjgOrAU+uMMuQZuf4eJGizr6HM9/aEllZR+9EAgVkLyixh6ERYQ?=
 =?us-ascii?Q?PPBSc7zoB/k/8+WRPF6oIuThppNBo7EAcP8MET6clN/z1PR6qVSjM57ascKf?=
 =?us-ascii?Q?xoSVaNCJpsul7bTAYcMri9FqcfNr4Xv3jM6L87WxBjORSkf9uHP8CD0V1IxP?=
 =?us-ascii?Q?3lpYgKFIVeztQDTSGFCFZnrlSZkL21+GuLbh04kHr16SV0QwlnVXZbmemyHB?=
 =?us-ascii?Q?n1SgnjNyPCPgX0cmM8SVG0qiZ9XnwPojwzKMtVwLK3upQx5Pr3uJkThFkRXh?=
 =?us-ascii?Q?D4r557QaPTYiEwjH1gyBWMy62rxJ/mdHTpmua9E+ol4tB4qa94L/8+W4CFSc?=
 =?us-ascii?Q?zZ6GCIJuqKJYDoWJxWBjvLvysQP5pg4zllWwcdz2QrXMMcktPnMdWyXDUWyb?=
 =?us-ascii?Q?j1JUgZcdU0XqZtBDj5HB3jK4dSySOcmjpLHzJ/JUYJXuph8RPpsnyI/48rAe?=
 =?us-ascii?Q?OwLh225oAYaHY92oB0t2Fi7BG5z7g85T86M69JQwrqb+eTTWyNW9lcBuBkpu?=
 =?us-ascii?Q?pGK0JOe1T3egQ8RIVAqalZMcpD9b5UYXvP461bSlh2fibXA3xoKVH+mH3LJ2?=
 =?us-ascii?Q?FMKOaRotzZ3lvNxcAjBlhyGyDSJboKsnFrm9c4cEbjatAJUcF+VHVfnhv3av?=
 =?us-ascii?Q?Al5xUmhKfaRBkT5ZYyPotBVn1kd4ofwTCk3qGE32ZvUCO2Prs7Xtf5XxHpuU?=
 =?us-ascii?Q?mfNE+PrXQ29nPFVyvSSGDIlnKnzwzSz0sKwgvwCLaq9SaQmW4ngwaHg+QYL8?=
 =?us-ascii?Q?gW4LwFIDT4zBbSfBtwYh5vGaWkkYJBrYhinxxFIYM/IHlPXMxRc0Wvx6jrW+?=
 =?us-ascii?Q?jH1TDP+kbs1vZcP7dEbrHzbWRZXjt9tXv4LPs7JdTyji6yOppK5USE2av5vi?=
 =?us-ascii?Q?gp/G2gqSZPiRviRsAgmlRr/pVJe7SN0CXLEJfDHko8uRUXw2bW5qv1UgeT9S?=
 =?us-ascii?Q?3GH6ylyvivbyC5ZFMpYlwia0TKN5+nPGOUTBPvzwAc/Hr/jrf82g7vnaPYkH?=
 =?us-ascii?Q?qYpvEkib27Dpi/FvLs1cxVoWHwhOcb8QXHxHoV7n4Ab8qmOUtBeSOLHRRBmE?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1812f7-d61b-43b9-744d-08dd5d8f1cdb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:45:40.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+gVFOdrPoIO+cqs/naMa3EtngAbpodEwDBMzEVioUhFAWhNTHbYtat8a4sipbc/q4PWAzwLrgjGT037RJmYbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

This frees BASS setup paths, to avoid memory leaks like below:

==5877==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 43 byte(s) in 1 object(s) allocated from:
    0x7ab1adefd9c7 in malloc ../../../../src/libsanitizer/asan/
                                        asan_malloc_linux.cpp:69
    0x7ab1ad08f937 in __vasprintf_internal libio/vasprintf.c:116
    0x7ab1ad135d62 in ___asprintf_chk debug/asprintf_chk.c:34
    0x5c2197401338 in asprintf /usr/include/x86_64-linux-gnu/bits/
                                                      stdio2.h:137
    0x5c2197401338 in setup_configure_stream profiles/audio/bass.c:420
---
 profiles/audio/bass.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index d987987ff..d299791c8 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -116,6 +116,7 @@ struct bass_delegator {
 
 struct bass_setup {
 	struct bass_delegator *dg;
+	char *path;
 	struct bt_bap_stream *stream;
 	uint8_t bis;
 	struct bt_bap_qos qos;
@@ -411,19 +412,17 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 
 static void setup_configure_stream(struct bass_setup *setup)
 {
-	char *path;
-
 	setup->stream = bt_bap_stream_new(setup->dg->bap, setup->lpac, NULL,
 					&setup->qos, setup->config);
 	if (!setup->stream)
 		return;
 
-	if (asprintf(&path, "%s/bis%d",
+	if (asprintf(&setup->path, "%s/bis%d",
 			device_get_path(setup->dg->device),
 			setup->bis) < 0)
 		return;
 
-	bt_bap_stream_set_user_data(setup->stream, path);
+	bt_bap_stream_set_user_data(setup->stream, setup->path);
 
 	bt_bap_stream_config(setup->stream, &setup->qos,
 			setup->config, NULL, NULL);
@@ -649,6 +648,7 @@ static void setup_free(void *data)
 	util_iov_free(setup->qos.bcast.bcode, 1);
 	util_iov_free(setup->meta, 1);
 	util_iov_free(setup->config, 1);
+	free(setup->path);
 
 	/* Clear bis index from the bis sync bitmask, if it
 	 * has been previously set.
-- 
2.43.0

