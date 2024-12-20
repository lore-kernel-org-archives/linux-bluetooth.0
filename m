Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341B8632B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705091; cv=fail; b=Xi3Fng4znCNcu/Zwm091lgfnNZg7tI1WlS8OXjgSB91pp/+kvQGi1wblzH84PD34IBpApCx9sMshM6s4g4wnP/DkO5TcWROL542fdv7RQXGTrJEvXXrG5SYbiZ+qAggcQm1Rbq1kUGtnHikshGLV79zVQDdkuJi13f0fCSpiH8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705091; c=relaxed/simple;
	bh=wf0gFNfaWgqi0NSQcvvS92vtpJ7/dHUS+Z6IhQ74i20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L3VRXgoUHthTwxvzphosAbKP4xt7sHZkiWSUjWtDMzoLShA+GcoeWPbsETgRVY2asbOqZn83aNTw9elU+8hjGro2K+JgX762O20JiSMQY5V/Q7kWnl84JhU8dJ3XuS2ol9+TNvMHPWPzDsroDINWA7actnTUXwEAM0AOQRsft+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iXpIpjWO; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iXpIpjWO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFGnR9/8mls3d83OGN/WkcnhV4g8RZOSkFctQcV9UYasT7A1bFYz89oHFc1veJzap8+mncaZBUhpIPsm8rVMuhH+5DSA2imPar6XOQDTaxaQQrjJQT431EttKuUsUP3+oO76Qeh4PtW3vTcaJ5ANNNirJwooVbWLNRYVAzBnEf6AzhHA+wxdjnPFdSgbDD/latQVSOHd4ZJyqB12MySn+zm87frdGvps8ktmJxsj5fkbCwPL10dYnVuUvSaJr4T2zn1lrRQw/RSs4oHWtasa4NzfrrRlyT9AhSY1LXDJebMkmQ6sJBHlhWbPC27ivIWGPGyJ1s7kJMkvbntUd6ZL0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bifXqKJcHALp5CWdLfKBtX5yjoO3EdIC5ttDxVuvUy8=;
 b=ZSFk2uuk0m2gnwy/1dCc0vwCfHDtT0Wco1RvF5vz2YTZBFarDFLvFNgOM/0VTFuZxKJk8N7/iEa+3dyDHBzKdAX40MdoBDivY1AWwbrsPkQZ/5+sqDy8S2Pc5FuHr29ri3ANFI+IS8D71VgmGwJwZq+rVGPyZ1AOsBaSOySG2IFnouQaHaAZgth2fFrDwW1gFw/DXz8244vxS3Md3c6WLzkomVuHXBnCsr1ymwCXDa9wXIuIYD9kHeqXKr9BeOe2sV7sR0tdloOe5ZOJkrQGeOBW9p43o/P4AkePEXkqJzFi2mIzigQt0lElqefHWCqkrZLc55Zsa4mCe15Jqk4j9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bifXqKJcHALp5CWdLfKBtX5yjoO3EdIC5ttDxVuvUy8=;
 b=iXpIpjWOA9r5YCKgdHwuTn5WQAK5/UN6hHRPrvbxDlF+aGAGlb4/NoL/OlG/8UWx4mzD9xiqcC5p1+itNt8O5+DgXCyTT4PKNqxDu8s7iclnILeXKANJz78tqi8iTdLhORhOgccS4ig8Su2+RPP3j1O+u2uQc5S5jqoFPa5u3/PkNxVuN7pA1Pidn1rlMrzb9o6vcQjCY8X3Gx8YSt7hi2k5yTIoW+DPGLrleBJh2UqdbI3yr1Brmo1MCVuTMLiiX7kvVVULF8KB6/18QMCa36tOrhGi1ptRIYHNhxcwpuWj54MzTDz2ilUI6OWDN1oTlBm4vVMvCwM3zuPD/CYGDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 14:31:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:31:22 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/6] shared/bass: Fix clearing BIS sync index
Date: Fri, 20 Dec 2024 16:31:01 +0200
Message-ID: <20241220143106.27443-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
References: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 0986410c-b5dc-4347-7c69-08dd2102f9f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fQU4z5KfcHQSwGjHo2BxDgPFHb8d3a7KE+pPj94rZzTbeRAgvX2LiXlkBm5x?=
 =?us-ascii?Q?CiJ0pavzD98zXR+cfcHiGwc4kpANXnH2Sc44+k2LZEUvXviilJBC/qm0fP/+?=
 =?us-ascii?Q?hHA1BiIgIyoSHFBXr9zmzYpa8O821LjmphiwfeG8eo4A0Lj3fnH/KHAJyFJa?=
 =?us-ascii?Q?VNCJmGPOBk6zN7tYcgty9TvABb3iaU0Qr9N8piWa0Tz+JnMdETmvlwS69nPf?=
 =?us-ascii?Q?wS5a872m4OyE8/Sbq1qgGBUtbWTQ9DrPiCSLes/KJBcdEUPIHHdHmTMaXp9V?=
 =?us-ascii?Q?igWpXbXzkMLRttDN4oaZvjQkfDQY8a0FR/R6arPQhvkn/0UJJaWV4JwMz146?=
 =?us-ascii?Q?oDWuslcs+tMUjOhillghBVGYI+mNAKGqo7vcMTroyCCxf92Dp1K5CGSenekU?=
 =?us-ascii?Q?ETkaYPra4KgIFzBty3M4aL53w0rQ/Fj+EkZlQ3U7yai+eoIAZT7MqdULZA9O?=
 =?us-ascii?Q?jy956mX/O7b1kDAS8aaEoYbB+TlxFD67HHd5hIBrXH2Y+W074JjsuooeGzj8?=
 =?us-ascii?Q?Cnwk0kd3GC9/issZS2tQevdfg8AC8IlYQcMR65DxMOAZKgyJhXqceq9yx3Bv?=
 =?us-ascii?Q?uCKyHSb/PKidOtgTNSGKAQMKVZ3q+m+pQQzzUwCBf+iH6+MQCrJ8Hc74IOZM?=
 =?us-ascii?Q?3ArUvd4OJGk7HeNQE1QjJSeCXtLK9ORReMrtyqZEcllQCq5sOd/eewJyxoWk?=
 =?us-ascii?Q?vyAGvgZkpb43aTZHur9+fY4mLkPLbWtvZhYLLRc2hwOiopAiIzR7XFt3Kc6x?=
 =?us-ascii?Q?oTlAzUFXFRuVqj7kga97/W6cFEwuEiegIWMbljUllpRCqXs8Dve88NPsm0jZ?=
 =?us-ascii?Q?7PGCUEMyH9gyARiZbAaHakmXo6cM7FcE6F5EV0QA+NVnLxW6im35+9h/PthZ?=
 =?us-ascii?Q?Y+DCW8VXOAIC9niDADXoS41KOpe/+IwyJV6sQdjxl1lGjEvXbpNAiZzA5/L8?=
 =?us-ascii?Q?sdh8gKzQK72EdcsxKqsK1XSJOl3OaCdh1h0bRJZJzpTr8k7rJuck8SV9CH33?=
 =?us-ascii?Q?D3RSMmHh0byknybjU4PnKwXEt8p5xQzhNG1AkgxMIaRCa8G83gqQFLl/vsPH?=
 =?us-ascii?Q?oeNCrK3vLykg95U4n3rNxQ+hanT/pmDzBQSAqXdC6hm11UaKhl2zTgh97/d1?=
 =?us-ascii?Q?YVhmnakkMwXYTGSXWNL38tZZWSC7zvONWemCg+/3ImuaBtytqE/DIAaNc/+s?=
 =?us-ascii?Q?nBz7hh+C96RNoRvFubpXSRw6XSa5dd0Qt5J1RB5COrf26Mf5l3WMAlZqmdBu?=
 =?us-ascii?Q?SeG/6K/89CeGMKcbUK45uJkgojrfUkeK2IkbycRdGKIpEYipcpsHCdgHCmKM?=
 =?us-ascii?Q?2SHsRARxHyZ79ChDUg5Se/xVMAlUipqnQxHg5rN6l135WoNdLAWndfr9pgn/?=
 =?us-ascii?Q?tBO9EUvDpBUdGSPz4RhycLmqBUwz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aSUtEWSyAhGEJUbBEAkE1Nl7i96kEFucWOvIV/+FwWhLBiP1o9Ym7v/9H/K/?=
 =?us-ascii?Q?JT5MQNxak5hwGs9v0lc4/EHTgTuR1kBb8uVjt27vnHcOsR8wCzeVG7giXy9s?=
 =?us-ascii?Q?Xy6h5ktuvvY8/1hP1sndP474BBzr4OL9B6wMGl4p3l+GlBnuczFRuYqE86ve?=
 =?us-ascii?Q?JN/8CH+shivbz8k727qLdj+CHKAn3s6dUENW0eJ427nR9WhHOv9nK89Jw/D3?=
 =?us-ascii?Q?PRRS8BzSvSS4NF+O3q2qD5Z8pEy1+KLGn4wP+cdPUQShbNtclMvCvkn+LoEk?=
 =?us-ascii?Q?v/t8+0OQq8rpo2YB7ojQQfO34AA5fT+W1VIu+ei0WM7ADSq0NKwXkjJL+8zM?=
 =?us-ascii?Q?0FNHOndzY5DhsPv8Linkrw7P+acvtKt+rer8kd3uJ/qGCNDGyCq/ATa/d6Yy?=
 =?us-ascii?Q?PzeYfu8vAtMdZO/2szCLk1d39zHOPtcxurTh34jypiaP34eNV88W/uCw7qoI?=
 =?us-ascii?Q?ZDKiHvcrGEFf+ekQKsoVdrAytKxIdCyip76HN4bKWyRg0qlrAMZEud1Kj0Tu?=
 =?us-ascii?Q?iVIS8AtHGjdbi/DTU+A3GDqDRdX9xLO0fKuK39caqU7UID5lAxWx0zglxygy?=
 =?us-ascii?Q?R2C6nHSNjuyTiRG65PXxNlawXfQGe9vpzZziWUK8492P/Jy7IHPhT2DeFxFC?=
 =?us-ascii?Q?Da/mzUfFDcvTcxbBzGJTbCI4WyNLTRvmGDAfFSDDvY5IsG+gP49BbGmBB7iF?=
 =?us-ascii?Q?uJdfF3ixFW8crYY0RLGAFesnezSE9Wqg2i8ODcxy+XXsGcR5rE3ip0s0nim0?=
 =?us-ascii?Q?5cdU5pOhWPfRn8fQyOCvD1ICS5YV9WUsXcrzryKhr66PRsdsrQXgC4GZIHG7?=
 =?us-ascii?Q?3fuZN3/WjlXddCHY2+/uVH+RGjw+0HtPBmsNDrPX5qxTL5IwjVNJ5P2qjs16?=
 =?us-ascii?Q?jbWcg8vSxwh43xvlTqeYWbnupcTaPG9LbZv7YnRF0L3ENoGQwSmgWRZ7949e?=
 =?us-ascii?Q?seOx9numzwhMf6fYsNWfT9WU69GeNtcr/s0zDUpbEkRnz6+idTXkJMN14DlC?=
 =?us-ascii?Q?LTSY11A51RF5D078fWKrfmsIam/oCgIL09syYU/fkm7uJMj4kl7N2gD7089G?=
 =?us-ascii?Q?5s6fB5t3XXHQbyZmEm4lQHBRNmEZMkpyCOn2GHSkv66ssIaOkYDQx7PSqCdT?=
 =?us-ascii?Q?kcRvvA4SZt/WblQAQw/5pPCPDNp33c6B2DT315xLBwFJbBy3CtpDzRK84pWH?=
 =?us-ascii?Q?yqczLjQfg17zlhG7gZb6ew+GK1ZF5gqMavU9Le1Zp+m+t/oKMhqVs91E/m0M?=
 =?us-ascii?Q?ggdR77mcI7HAscitAqbmuaSIhXY6hqQRlLNevpo80QhbuK/egIVhY6h+munF?=
 =?us-ascii?Q?WihBaVOt0Gz6b9j8PL5YaJZdE1THusQElscyd6yk6b3BFiu+6rtq0lY+8Nul?=
 =?us-ascii?Q?vmRGbZxPW56Ukord1HZGggu6JWRVP7HxEvleeG1FHiC/GjstVveCZ9bM3TW3?=
 =?us-ascii?Q?TWQcYNfS64N5lYNttX0GRxTQrQkBToptv3ZfT52OtKHmjqvDfnSjO4rbLM6A?=
 =?us-ascii?Q?foMKfdWQpRYvbOmmZDDftB3hBOc5eRuieMYFinnQYBaQ3oA0zUgdCNXmBs4k?=
 =?us-ascii?Q?XLdojSWbbUOK0tfvra+xeF9Brv14yL8pIINKMjdPOEsr+MgzCA+XCQ4wrgJE?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0986410c-b5dc-4347-7c69-08dd2102f9f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:31:22.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VQ43fSuF8DkPsbyP2M0pot3D30Wqw6EplGdWuZLB1rwI1l2nsFjOY+OhCJws80E2IQbylG9wNOX6rxHks7wJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105

This fixes bt_bass_clear_bis_sync by checking the bitmask which contains
synced BIS indeces, instead of the mask holding pending BISes.
---
 src/shared/bass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index d99a140a1..1ab1a0a44 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1819,7 +1819,7 @@ int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
 				&bcast_src->subgroup_data[i];
 		uint32_t bitmask = 1 << (bis - 1);
 
-		if (sgrp->pending_bis_sync & bitmask) {
+		if (sgrp->bis_sync & bitmask) {
 			sgrp->bis_sync &= ~bitmask;
 
 			iov = bass_parse_bcast_src(bcast_src);
-- 
2.43.0

