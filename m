Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B1947F78
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945763; cv=fail; b=lDmH47XW8eMPrv81K1Jlk1t23COZubXLx/F2U7w6YlwAiynNexV+gysBwIp6icEcHQk2C7mHsUGWAP0aa/QxlbcMnx5N0/aCJQ7r3tiia8t++iKXjS8G/b+dQWoB//nNds0m/B3U0qFtmz+D8ofrI8DK943Xjly16OPgWcm3hCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945763; c=relaxed/simple;
	bh=iyrL9TJEnXdJXQSjbEE6i1yCIe7EPfvrMzuB+cpbFJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ntF9opYApxSWiSkvaNjsYuQ4+TKzNd9NxRy7vidFkqSfWtTqHN2qDoO4DCHzLX+PJj5kLzxBSvDlFrN/Q0LK7KTVB9nopoA6jianSkhcUJJ7SXLfyPdGUQmRxH3gxK7Ep2oxVigZhdFEIdULuAYSQ8r+7OWAoDnwYIeqW4BFUVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XHb5Fx0s; arc=fail smtp.client-ip=40.107.13.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XHb5Fx0s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EElLi3P0H9rDJwYY9irgsniYiiGSqjp+eO1pI3pF6dHyigzOIIMjh+uTZ4qpytO3yFV1UqcbSxt78gN3GS4ZBNHEvvTKeA9aBEl5eD9Qfi7/L7DTMzXH0+75vvX68bWm1WREaC2AZuIAD2N4Pi/ioJT+irGS04x9YHTeuCpKUAm7hzZ+2D+kM3kLTspoi2H5im9tBFny0C+9t3Cb4qxreTrkQf7nj9w4NEpBPY5gpss8ME44s2vSy5tzXd2gA87x755cOuvkguA2yWW/2ASmYVEHUiMJ8zg2yl4l6Cmlh89+0y7vQbhuw/5EBzOc5Xc5MsCCdH8kj5v4U+990zhcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kk2DlPY77Fp7NC7UCmAgs8dDq9nVBBDKl7lHQw4igvA=;
 b=LdB7YvggoXXyLasTHKps3ZRtIxwV5UNv+SKUqAO++MEKEQBaxKGfip8/jfc4FMGWGg77jaw+gjm5lMDMB5GJC0aJlnYGps1DHIAqm+/v/ynaq24M+Ee47htd/sYgwtOB732TyQ8V1bH/pvJsq3uo0ecL9E//q3QF/jaEu4rJ4+hq380OflCROZHWM7XXZoDaWgwGbKQ5bihAyhybHOO02N8d7fHtyTsFP3U6Oxv3wUtojHs8XCVQnEwEMy2B+8kRlW2WgfDp9fenYiiZ7sgaaIt3qrr5rpj4MYjYrP3wPiRX+97oI0QVI7jPyhaVwcrwt3t1c5pW8u+wZCic0tkVPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kk2DlPY77Fp7NC7UCmAgs8dDq9nVBBDKl7lHQw4igvA=;
 b=XHb5Fx0s3xmDT9bvxOFVhxT0J7otzhE1i0Hs7HfY/cr5/MNyA57uSAtACTvn6MpTdH4K6zyN6UURMUC6m4+2t8rliJDenXbc3K/UeIUSmge+yIpoivjaXYgJWRypkoSBT9qqK1uHtbqheq7KD8MU4mopgEb2mLEisHXMfgnZdIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Wed, 20 Mar
 2024 14:42:38 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 14:42:38 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/2] bap: Add bcast source support for MediaEndpoint Codec
Date: Wed, 20 Mar 2024 16:41:52 +0200
Message-Id: <20240320144153.46408-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240320144153.46408-1-silviu.barbulescu@nxp.com>
References: <20240320144153.46408-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 7885ece7-e2bd-4836-c62e-08dc48ebfd22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7V4uABTBZIVBZ1JfHVN9t0WjtxYGdIbwYFMHIYBMbKv5RsFcXXhQuj9ASTC+jTAR2GK/ovmJBs0vbda2OPtTIXLP8bF4FtVD1m3ITyQ2y6tjZZjY2i6c8yx7G3ybcqVuAA5xbBOyqxYfhlM3mZ0IVPBXMww3zTCjKRyiUs4wjfGUcBgY+q3ldv1oP0cTmEt5VO+IGnEQPTjUNl+fBhL2yRl9WxqvohLw0/xk+JFcmH2RUpYRcVpBc3hcfTuyl2attWQ38N/PUXnbPyVZ/pHvffoM+V+RKTT7hQhxv3Y+6yQjHuQYvvJOZLbg9mTlgTOkOH4n6aVihfSXghMNRoAE4UCP9z59Slnddl9CJRkqvI4WIcRYwrmWEMZ/z67/mV1VvXNzV7PcMUYd2lvNh8VwBFOq0HtnoMxcplgwtJHrWPhKVmt80MFfXVUS/MntujZ+d+bQ2a8n6POu5GIgvbUHTo8TLdbS+XL0yLblRSCTDTfnSdUvxkePri0C9/cm6N+EFabA3/45ypGGsgKieP+GfcepVy+gmDJ5tkMl75RPfI6PMxwstv6/wWgIbuXuOVSsnyJWZx4AvV1Bv9iMIK/33jlqOzmkf9kPijtSqeLHHFqeTz/gUjlDK1TMIva7DZ5RGgpTaDS2MQyOP5OmJfEIv7K/TSPjNh62wg4As+L53lU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fCEyY6H0ABk+B/TL37i/mzOfuV9kchfbL7wjEu92cZNW1858J+nuuLoLD4iJ?=
 =?us-ascii?Q?6PLebP+P4MArPR6Fb6N9XLEl6gQXVPLfL8p5Rin1ShnN8v66dApr0BR9kOuU?=
 =?us-ascii?Q?4D+vbHjxqTJJjIkBS048QnNWo1/xyEmesAMOCTr7S/kEVsPuGffhpllIT6AC?=
 =?us-ascii?Q?SUmPXZvo3UfxkqyW+3uP6sMdkTXHAdfZ211iSkD2IrLNUg0/Yg8ggQnu07DI?=
 =?us-ascii?Q?0pQ6p0SHUdSkJToAEVRP5vlZSwJObnejc6cBq//Bh4HIAe97jVJ8InhvVo/U?=
 =?us-ascii?Q?lhjyg2G6RLS1eqQdPnJ9zT/yJeUlL5H6xEptE/pX0BLQE1flEizoWn3mi+iN?=
 =?us-ascii?Q?b2Oq1jvSjV//AJl7BVfHSWMijPcEh5R+SGa+bfqEeZ9gyuFZiFIKRhioUx0Z?=
 =?us-ascii?Q?+8g8+ircNlmZBOqVnKa8neLk4GSYdYmOJ3J3abqhEVsMQ47Px3Jomq2YR8cf?=
 =?us-ascii?Q?ymSiHwp6hrIx9hCAOzUovCM7ujWCwx/yBRrYHEIjaNZaxi+vCQcKDDni44Ax?=
 =?us-ascii?Q?Sl5osgMzunHZoBWpg6O1VrHyfQbpyRt7ORmvvxtThs7c16aOZ0lU4DWLASlz?=
 =?us-ascii?Q?Cdq80o9t6m2l52T5mPQwyrbSutYSUMGMgERefHOQVCqMtzpQIFpetBteSlu7?=
 =?us-ascii?Q?GmuhfnXQbdgvUSjNoxSLBIFD6ZLoQG7VjYwCubQVcwNA/fHSd6Y1eB0pIujQ?=
 =?us-ascii?Q?ST4XXS2bZHKPi3aAxHS+2cxZNYoFmmRU+KhcM44/i8xryv3Il9ymic3BjonZ?=
 =?us-ascii?Q?8zjv4vqKi+Tpk7ApNkE8x2ANeCJtxFxw3goyka5gHRn9VfEd5C7namzFhpDW?=
 =?us-ascii?Q?G35RpHz7fInf5OQncuFU6nLm4bdeJuOXcz3Ii/qN5QuJVTgkvc6Cnh0qzh1M?=
 =?us-ascii?Q?7/KL7wq1+awWW8IwpW2avBTIlWcjuJ60XJt6sK2ac4Ul7IaHmbMH4yUwV0q/?=
 =?us-ascii?Q?4YWbZNjjpl+01+GmBPk7eMZClpDmz4TTEVyiTIXURXaxjMY9V3uL6Jyse2Pl?=
 =?us-ascii?Q?9UzhqYozJ+q6oori+Mb3AYtePAB2enmsVW4thmciJ2hwPDexXlhxeLeeFwC5?=
 =?us-ascii?Q?QFZNav2ETNY/wDBwPk11whQ/IgIYAaDUmH9DhsXiTAjC6kRQh20Bdc1DNEGz?=
 =?us-ascii?Q?WPO2AGD/F0IloATcWcWyPpKP0DZqWmT6n1CuHweWIDpW1Ez5+aD6LDj3eF9P?=
 =?us-ascii?Q?l53NYHoHufSwBY+oz2OJpVic/QMwXhZCZxBOtrlaOaFjjeViaYezMwP0Qk7n?=
 =?us-ascii?Q?/09dfRU070whWp/QI8VoJMWAks5Uza5NwjWm04SgTKYweaZiDkeXRMKZdD93?=
 =?us-ascii?Q?kNNxfy3VjfVJH3htt6HAFywjf8pe6G7bUL0nZpOyezC/4xANi+TOKjVqlfpz?=
 =?us-ascii?Q?YMjL+UP1wdG1tQYixGBhoLo7m0ZnCOlEaLM6iWlkLBUWKUcF1stmVQiwzVHn?=
 =?us-ascii?Q?gvhVzCAiem3DmOhx2tPRkn8zENOnO+Y1r/2qT9ZkfV/5Z8k1tMueWVIedLJj?=
 =?us-ascii?Q?X6pdltXApOsDO7j9xju9xEitD5SH2xzR1a43KL3ewQT+wtEq+/AKySi9H/IO?=
 =?us-ascii?Q?Ga06QDPgW2+R0DgVW4gvNShC7O+EezTVws0Zdp12wV69oNvGdnYDqm3vUPht?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7885ece7-e2bd-4836-c62e-08dc48ebfd22
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 14:42:38.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCpY41bKmzAgHzN0F+EtG4ZhCsA1FKhYCRZM98aEFmHOcj2fjXydWyYGzth/mD4y10J+FGTHBD5PNRSAz/FL3G3C3S2z8zrRCCK5zsRKBrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797

MediaEndpoint property Codec returns 0 for the broadcast source endpoint

---
 profiles/audio/bap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 964ba9c21..3ab13a51e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -277,7 +277,13 @@ static gboolean get_codec(const GDBusPropertyTable *property,
 	struct bap_ep *ep = data;
 	uint8_t codec;
 
-	bt_bap_pac_get_codec(ep->rpac, &codec, NULL, NULL);
+	/* For broadcast source, rpac is null so the codec
+	 * is retrieved from the lpac
+	 */
+	if (ep->rpac == NULL)
+		bt_bap_pac_get_codec(ep->lpac, &codec, NULL, NULL);
+	else
+		bt_bap_pac_get_codec(ep->rpac, &codec, NULL, NULL);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &codec);
 
-- 
2.39.2

