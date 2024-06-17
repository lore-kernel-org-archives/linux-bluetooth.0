Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2046.outbound.protection.outlook.com [40.107.8.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE22CA48
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611249; cv=fail; b=jde0N1hnz2w47c2yT0mWz5JZ18ll86PZKea7nFMlfpLwVavspM/kIUG+Y0BPoABWzWtarCXqTFW5L053SGyhVBz+TxTFTeAZjfyIRvA30ZVX7tOyKCpT40CwLB1AWewbpJMkOeKfSCxrZHzTmQrFcxpS6JbEUKmqnTCvi87Li4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611249; c=relaxed/simple;
	bh=4aU5BF7gSocuweEIrbJxHUUr+FG1UjnFBx6aJtFPXn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l6UwW03pZMQ8lreyfCYvZxUb+AX4Eq54nywHB4IQH0c7YnOJw3qG7cFK86pN+Gu0X68K1eO63DhBr6/6RX+aIGKC+W/fACJO48nMlkA1Hcn0V3s5dPQwDMV4d/03AqDqWwl+8embxZU7t4nOiFjzTHvuk/Dj9Li5Sarw9lXIKkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e97EhRnF; arc=fail smtp.client-ip=40.107.8.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e97EhRnF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+B5XJSp2eixVXqieJKFOREeUYJo9/sGAE2yddB7kyYvBqrJC3AskshCOXAU+l8GT3elTghl40nWdg58QN7xrh2ijC0QfKYasioUSx3kY5H0UPnZiRclgJjvpcRVDmLB7kYdnI+D2Kec1QJqakrv7u6SMLplMBVFsFpqTYr9Ks3hpAJf9jLpWLOZfdozwekEHWM1+aw7t3oZ3bfiNQwl8HKtSQg3PG3BiMTznyvc3jnvtfped+MB685qx59tYv32oQHn7cDI0arOYh1Aix5ZtYe1X30FtGgey4Hxg9JXVpHDgQLz31pbp+llYpmDapZUg1U1yNNZexj6Po4aEXSVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ytm46ptZ+O4sWiNCuf58Ki272MrYMoFC4Vj2ebG/8w=;
 b=Rj/4IEZ8Hy27rwwp9BJapiX0dsoNOR2oRBX/wQLwE7VPMdI40i83c6wnvkPXWD6ws+c+a5zxPiXR5ICjMUkSkPRQNMAG+stYUTmWggZHl7a4qPgljoan6S4y/OR4X6NyMlT39lZI6wBMLwASW/44ppc01hb0+EhMrZh5XEW3yKrDckn3xHcgjdmWzVFd8LAYRnpZsHXJGpWHehaJj9OYvFCIatBcrOn4CJHkrC6YrqV7FVz+R9qQWKGmd4jMx9GpgmHI4jfNRa4/fh+B8SmG1QTOndC1R9sLQFvcmXoVCg/WZv43BLNczYIShj47cIGTxw1ndqleE8KZ/kWjC+dsAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ytm46ptZ+O4sWiNCuf58Ki272MrYMoFC4Vj2ebG/8w=;
 b=e97EhRnFQqb4cXQqUChLvfV3IfohjlfVIP7XCFS7PvzSqnLF5LqZhxyQhMbWs9A01PhaU11yl+okJsL1A7GnD9jpi+coKu4p01PwJm3hMmui5nB+yucbP62S6k2/7Chch49gV/4taNL9ZNprt4b8hem1S4NZ++3IfBH+Ht2e8RU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GVXPR04MB9759.eurprd04.prod.outlook.com (2603:10a6:150:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 08:00:45 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 08:00:44 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] src/adapter: Check if device is connected before clean up
Date: Mon, 17 Jun 2024 10:59:34 +0300
Message-Id: <20240617075934.154540-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240617075934.154540-1-vlad.pruteanu@nxp.com>
References: <20240617075934.154540-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|GVXPR04MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d3be3c4-09e7-4949-efed-08dc8ea39730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|366013|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NzTtVvIYXASSWfEXKd1LXFj/VtFpnG4Z4EL6zhSxzR0ArlqbA5Pf9dDrZ36g?=
 =?us-ascii?Q?rEU9gxvO7A7HHYxpHINXFs5okq2NGDEUa59unZG0+eGrECRe34uU2n4RqHv0?=
 =?us-ascii?Q?TbpDMw/OmAcBg1xXNCp/slqoqNE20CtpWgFykeTblWMUH/w1V/gVup9ZpmCq?=
 =?us-ascii?Q?OQ1Me6g68244OhV+8YXs98W/FRlSZmFd+H53GCBYgajaIgvgpfaPSxyeFS52?=
 =?us-ascii?Q?VfulCsXGiRWFRxxQ7OD+nmOya6wSp5ApxKclehj5TwOWO6AdSIcFkX4AtNgS?=
 =?us-ascii?Q?mLwlA6b7pYU0hw2CrcIHdHy5xuJRUEw2FC7Xstg9kjXLb/bWWG7NkNY2NiHg?=
 =?us-ascii?Q?6d3JzpPgmO23YeFtjXb/eMrFUPpIdRCaijUHDG12v619kBgUHWU+G2p4ppri?=
 =?us-ascii?Q?NI1zCzCLIqfTfY4qYHGwV/ov5AHdYzckP8gt93zEXH9+4hnkYp4S2Iskt1ch?=
 =?us-ascii?Q?LaqP+GUvq7HibVbluKwS88+ooFIBEmD0fkZexodKpNb0VSNbugA9QBWJeV9k?=
 =?us-ascii?Q?sF16QSUwEu3zqtlKjRhobeWcY3YChQF7+bYfYGL+iuYfpbDngv0nYZtDI2fC?=
 =?us-ascii?Q?dGKJlKX4e90EFbiibXg6hNn74f+pIN4pXvtSi1gCptgufWvJVTuKnC60Acw/?=
 =?us-ascii?Q?vLQD/XzmwyE9ZCZqsTLqZmEN/Wv03JbG8QjLr5sqc8HVIoW30E0FJLAeiBRf?=
 =?us-ascii?Q?LTcmZM19xesdt2XGNMljS/dQmWpH7TgbudlUZcJA3Nwp2twIDyxJFKUwl8a5?=
 =?us-ascii?Q?xIgBT8fLELe6Bfpk0llZi/OSSn8cEEL2YtXzlk5zfv50otJwtzDt0GpdTAkx?=
 =?us-ascii?Q?B+CTUr5NbfLvP5aQVDuV5+PldNOonN47vP2Zc59bA5hawLucF5PNIgjGwIUR?=
 =?us-ascii?Q?PZFfs4qEWNXwZzbqHXte/mIEqKPvfpC44B7WEwgn1Fv8ekU6CAp6nW12cmk2?=
 =?us-ascii?Q?dbtOLUx95v2SiqeK6QBNxUJzmKLwS6UC9tLJmsaVA2UJD7g1eexQWIzsYNDK?=
 =?us-ascii?Q?7t3f6AQxQYu+6gLHW54/h2opPD3c4pAsje2SxHKO4dP5L29ONmC85pz5lj/u?=
 =?us-ascii?Q?2QNL02gIyMZPId1exaztaX/4rCGqhhY2tZhKi1cO1RmhAMnMmQdAVA6YBPZA?=
 =?us-ascii?Q?ooeZNO8ytpDTXS+qIDArfunP7GIEDU5l12Xzd2hgdxnKeRAMRbVBRlkuce/E?=
 =?us-ascii?Q?EnQwc8DX5lYcyYALvDCkmB3ylgvRymbGOKZ6/T0i9ZDHl5mqe9fuZ+xQob88?=
 =?us-ascii?Q?YqoEiS4fYVJMhe0JOBn3NmEPejl5c0P2atI3kVgBmRIlCtxB50hsRVRflOS2?=
 =?us-ascii?Q?+XUZJNxi+GGYCVR+Ibh2bm1JUTK2tmVs+voDYEjSF+OdXHB3lJUnAh+2vvSt?=
 =?us-ascii?Q?Eaw2NWg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WWnVo3+D0dBfvrO9Hbh8aRPu+d8aR6TDrQeBqFDlK0qNPzhf4PJvUmkZNBI0?=
 =?us-ascii?Q?XvswI9o4gs3QBgqvbGlRQzewk/lj0CtjIOsRq3zg2hyRDXx0PtBBwVYOh2/W?=
 =?us-ascii?Q?u1L3/49nQZ78o8kf5dfTs14w8hGfaHqLkmB6me99bZC8rKGvl+/qrgUUmBS9?=
 =?us-ascii?Q?nXEjwyah75M5JDSWNEBQje9ucuIVIGLNK23I5Sm8U5gLIEVvfsnn/KIdQzVP?=
 =?us-ascii?Q?dEb4oEnhNyWF1OaLWrGYIHrJNIXrMFyGr7z6Gt4JBhCXceTY6/pFeZ3uf7fB?=
 =?us-ascii?Q?V3iOahXlIbt14rQ1KOjjg4jRumtRCxrotRYeOTKpelmwWR978JMoBe2U8lfE?=
 =?us-ascii?Q?MFRSN85nmJ3ze0MPuLX72sXMV1x86HJ6icgX7347+g27D+r6tnvwEJfo/mbW?=
 =?us-ascii?Q?PlbE8+qSGb/t5RGNEf606AiFU/gTedvFqUQOkM7XczLjFYMFdadOrLcxEWKs?=
 =?us-ascii?Q?jeCFQpBlXA36gjKbMAS6rmvc8V/U2pDXQw1dEsRD42/pkIDLBSAD17rgycFW?=
 =?us-ascii?Q?ZC1cEZ74kSul6OYP5iih0ckunuY3R1+kgLoIG5q0uONqHqokXDhFx9DTdgq3?=
 =?us-ascii?Q?kPrZ+7fMc3OYO7oHH5PQwoqE2RVdxJmxc+9KzCuBFJT1IgIGULooyvDNg+9c?=
 =?us-ascii?Q?tlTmF5FSSCD2RhSFmSabsUA67CmWxA4yjqh+h5Fc8Se11O14lIVSxCgYZxEr?=
 =?us-ascii?Q?xZfXHfWHYgxV9Xc4GzD389V3IWPx7ruCkdkR2QcykSxWC7gCkeudHiMyNELB?=
 =?us-ascii?Q?JthDhv/zRv4tNgnNKExBBaiOo3G1GjNoAr7M8cviTZoW6J6Auheoa+f0M4AW?=
 =?us-ascii?Q?+rlT6ZyV31kENRFrpw7KgGY7ZZu3bLR0qSlIGdKz0IfZGk+JBOYdnJfPTigS?=
 =?us-ascii?Q?eV2PPFXng32sw9oR0M4nxLSyD2rFMJnUsKRMFsIlJylVMn5RfGsvLq0tBtct?=
 =?us-ascii?Q?GYs0G4McV7F+6jNdt6WvElyv1bdPfQ9Rz/ikg5We8ZIxDE/DvwbDyt0eaKdY?=
 =?us-ascii?Q?AXQIe+XeOz0/rp+EWjm1fUuZQx216SoYpaHCMNhlxg9bpu8rGe+H3jmylbdH?=
 =?us-ascii?Q?cz4qyZHK4fiEeeJzeUjfmmuuyKKpJ6xFNkQEFZV6q2dy6X2DHcQa6ay/cHOI?=
 =?us-ascii?Q?3o4t9ZCBuwv84zBpg/+wi+Ce/GnqwLuqgT7hBTFhlgO0CKStEo/Yt3i1Pj7J?=
 =?us-ascii?Q?2Fzc1zSeRRcOT4b1w0DupWTJRpnpPHEaEtxI8ISdiONzCK/MTuMi24LEu2fy?=
 =?us-ascii?Q?Yo2NxPODcYU+SXd68E8Qf4twsxsCX1bxxb6/5/pC+yehiG/zWzRxQKN2kEle?=
 =?us-ascii?Q?m6T0uBqN9rKg6MZJ5BUSfUz2rI44GgDNGscweNabC0nVxEV+tkDiTjMT5pmw?=
 =?us-ascii?Q?gGQqFW4kbkEOc5u/FRtPu1lHtnk04dz3wVz8TSTNHQHe8s6oQWbc4c4BqeBZ?=
 =?us-ascii?Q?KSrYgMcIYu9srma8Q43SDduG6iFBowradBxjSJN+9NhL1u4EKdTBCcsOFfeS?=
 =?us-ascii?Q?aLbSE/iLvDK6lYpXwBIKPrfyW/k2oltZ5UdT7gC+UpM+J3HxVPsKMrXdYXvA?=
 =?us-ascii?Q?6SiNa+YdhtBcIXPkxNgmZUIX5uuMjSx0duIUoQLo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3be3c4-09e7-4949-efed-08dc8ea39730
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 08:00:44.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUScKiLD7wmh6zy5EN9OBsxYpjAAS7l7aXKlwLQz3h7+17QG4rlToPK4NyWkuqoqjB8eAAke3/OsYx7DYyplPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9759

Broadcast sources are currently deleted on the clean up triggered
by turning scan off. Thix fix prevents the removal of sources to
which we are synced by also checking if the device that will be
removed is connected (sources to which we are synced are already
marked as connected).
---
 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 821d94592..bdc5bf920 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1730,7 +1730,8 @@ static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
 
 		next = g_slist_next(l);
 
-		if (device_is_temporary(dev) && !device_is_connectable(dev))
+		if (device_is_temporary(dev) && !device_is_connectable(dev)
+			&& !btd_device_is_connected(dev))
 			btd_adapter_remove_device(adapter, dev);
 	}
 }
-- 
2.40.1

