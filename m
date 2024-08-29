Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26E91B1439
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935813; cv=fail; b=atBKqfsFS2P2RQ9/hP81JAc2qOB2PAdrvilBoITadIuBPMkEWufTIZd33BE4nG2F6IH8pUSaztXmu8OBEK3nttp1S7f0ecjCBpwbf4Hq9m3xfLnkChmsP0IqacLckwAQ63ggZdxnEkarTdASKQWnqR5U1Z9yv8j9kFD9uh0PJmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935813; c=relaxed/simple;
	bh=5MV5UrwmXSeydobPGwNOawb6B80ZeItyNfWTSaPGP44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cMtvXh3qFpt7hRQZ3xVKKmtlc1fh/dbi3fpNWLyjaSceKrfHXRBLeTIv5489KkUY0Lg/T5siKWi5owVInxM28sZgsPdIOk6QfxYTI6auSsPF0DAOHN1GB6dCrz/1xP+PJ5/Aqj+fyKwDcInNq+AR+eWz5Ge5yISL/3Qc1wleYF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dtx/yNaT; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dtx/yNaT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB1707krYN5jNWKZr//QBiT6+jtX8hzHMEtEzesB2gc4WwNbHPyQDHDAUZHPWai471vNZNqCnF7YTDN4NaNDjUQic2Zq3d+DalUfLlQ15zACdMPfUWEL3KgLfNRihG5fmD2Fx5/gPFjhCA6FnHvL2F9D7cYUlXgQ2xvAJ7wdfV7739BFpfv5hSxUuWn2nSYjc4iG3Os1EcukOTgju9sxNDMyxzgCodKBYyJeAsiJYUGsu+pBU4hieTk7xfnv2EHs1R3Q6ZbobbmU/tlltZkBfQaUcn2MW6SGywEMlzsqxZ42650RwmcIbC+sDWWa2dHsBgGXwTsI+dY1d3yYP2McXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUEXboWe2HygsTkmvJpK0kOAwb7810UMAQYj80HQckw=;
 b=miZkzO5jCUMk2ZMTCXODiNyA6f+T4MKUdWpGQ0s4mGn7Z3zqaFHbVh9XOy8a+ZyzMKuG5J4pZcBFrRrglPA/yS4M3M18IpHsuZGh5rJJx0r7ICNJZymcIoI8f5TNRywF9J47vO0ZWG9ub5aXo5e8aBNFPbSwkks/71gLqILJYShVDeiRnHXZCz9DViQWgcAOQytT9LfozWVkqXTVHVQcKjqx2Ws6pzELaluV6zFnVaq8fiBgztzmGhQNc8AWEKKgXaMIV9HLzagJ1sbxzHQLZQ4eE2JA1+/QO1TT0OxRXUNARFETZMc+lXxySTsSIghNur+u/A0S5fHM1+yQ6tkrdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUEXboWe2HygsTkmvJpK0kOAwb7810UMAQYj80HQckw=;
 b=Dtx/yNaTyCHOD+JBPx6AM6/zf3ieR4j4JksG+Vy1HvrEKjiLIzkSXN65jbdAaiPOoe/NbP1exltuN2INd6DPh+da0sPLRngn7zESv2ODNaLBEH45NqBjdrMUjGRv9O1jaXOfrXZZ4ZN4kqe6P1hupaWNFxKJVACw+KzM3B8fYFNHCcou6vo+/R9lkJfYU7CKDRSk670hACAWk2m+NyaYl9fVPTNMCzgT+yp9Mto4ge4XM9Qx5ab937wr+SVUX4xCrNcszb3A/l2y0mD69KM14JauCs28xM0zmBP8KvlFq29EcY6PBnuPfw5uWEtnEwyOQUw5wcLCNIpqufnQhgLDZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:50:09 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:50:09 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 15/16] bass: Add API to check BIS required for sync
Date: Thu, 29 Aug 2024 15:49:17 +0300
Message-Id: <20240829124918.84809-16-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c46d15-0185-456b-2eec-08dcc8291d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MQqop5XtdORU6oEbOVXwuHwd9rcHfuMAEwB8jVJowBUHBst9wZDGpzzP5+bH?=
 =?us-ascii?Q?bAy8/gR/XH0sYR4b3/FRcIEb2Q1XgX2Ep04NpztpwZq6dAl3iiSpI1+vTHbi?=
 =?us-ascii?Q?2sEwexzRq6Jfi1jun5oMEtdfBnbogjQau4FiA6s12ari5A//aH8Qn170ito0?=
 =?us-ascii?Q?vu5/poGd8E2ED0T4kQbWudUWfgC88epWg5ivo/EaN4uzBjyzzcCxnR7r1oyx?=
 =?us-ascii?Q?Pub2Q6CIz17dYZheB7wooMf/VnVBh23QOfUQQ3iy2QsEh8rIwWbZ1D05kzN4?=
 =?us-ascii?Q?tL3juRhPlj7THxVCnHEVJXUUSQrfDcMVnzZrDsXH7CmJr6kEfDdZhYIymzXL?=
 =?us-ascii?Q?ElrXfi1GCKTsc6X0LzpfJUwyKtItjHzUd+daOYsokXt3VF9QaDPCKgSn2d6Z?=
 =?us-ascii?Q?0sRTqFuEaz2LkyJEo2AGOXc0fm1xGmIQElhXYxha6svDeLGAqEusoNwukN8F?=
 =?us-ascii?Q?oZ/nrkvY+Fjd8LzOY3AwNw4JOCNvMfiIGfkY+gk38oYO1xSlB633voti9nNr?=
 =?us-ascii?Q?4N/6BTLoIz9XDbEsrv4/pzBt0gMXMiugVu9qmiSV9p1bkNA9HA86f/dZBmuP?=
 =?us-ascii?Q?JLQbj08BC/St9gxnUh3/xWnIM1pMTI6UJYIff0uKox2695x9CQxX7++Fg18D?=
 =?us-ascii?Q?PYKsxrDIIUtiRR9ep7PA2JQn5B4ESxt7gmzpl/8mRYXXrRmZygkX9wSGBjGI?=
 =?us-ascii?Q?cUX2vsIAdhLE12AQLXdF95F+IRugh0kdu9Z3/JoNBuJqxr/J/40mYLZkGi/I?=
 =?us-ascii?Q?YeMrgvFFyemK9WqPk+iNSKAtn/7Dr+wu/e/8Dk29SYVa9QSJxylzY1AVMJMc?=
 =?us-ascii?Q?+Y1QQfZl3D1z2z6Z+UiJvXd4hmMFEJ4azsCzL/PETohcGwSn7PQr2Ip/8dsh?=
 =?us-ascii?Q?Q0e7GW6cKMTw/l3IoOZJQzn7fUYTDr01BqlFkv3sreAEuDALMWB/tPGCKSfR?=
 =?us-ascii?Q?JUUlwR1rLOoPW1+MeJ9mPAHJfVFTPTSV9pFlDS6cC499OdBvhnqE+JFE8iWZ?=
 =?us-ascii?Q?Q8z5rOqih204muuEBJOLwKTIx3RUrNhh+1AIPP/x2RnWFCvYXwioQdwyZt82?=
 =?us-ascii?Q?ih0t/wKS16p1l/ws3QeCF2CNybXsojI0SSzdedp2RTJGqj2PysLgMvbJwu9Z?=
 =?us-ascii?Q?HRlBqTUCFB1H9Z3EtogXykh5E1oFC7OQ7fV7tAIWHZlFgA3l2KUqzngNQRys?=
 =?us-ascii?Q?J24uHDAsnT9fWQM218nGKqn1dZ6sJdlSu6QNXaitYC94yZSFXdF8hSFmAkdl?=
 =?us-ascii?Q?gld0xUlHsqcrz8Ll4dRIsIXSZBmo1+PP9tJIulA+LNa5hz0QQwRYR+0zg2Rj?=
 =?us-ascii?Q?lr64eCC8tb0cOH+r8jYqYS55QJEzWjH176dzvOZw+wq31g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RAWuKWmwf/vX4I70pzhJdDjZOlThGfLR8vkakzXwfCLoG6MgMR2m26lfnSN3?=
 =?us-ascii?Q?8BCis44WQHk3CyzEaoi5q/uMDUA+lWgshRvJVavLXo3GpYGgtLjC8NJm3aSM?=
 =?us-ascii?Q?kvXjKbElI5+cUvFSYZ3nVl26NEqz0iFV77Hcamu0OCSSJRMGpZUL1+4HDLFT?=
 =?us-ascii?Q?qQYDdGzhyMcyDkXT0hZCeaDMLoN2QFwN/UY6Pm2ZGZv815LqJbbJkZfVcApv?=
 =?us-ascii?Q?p6KmW2FuKI0coar/bpqXWItQYYq+hpV3pm6l+uWlLd5etVQharvcy+n5WDeY?=
 =?us-ascii?Q?vamJsmxJs/tSgltbEnuN3ALFa4AbEcoByDqx5GsN4jbBXlB4v3HwQcWLARmC?=
 =?us-ascii?Q?x3JgYASynGN2n6+qCUh+aGOAYz73Zu3sdiwq4ev5f0YgDn6tRG1bm1+qBm23?=
 =?us-ascii?Q?sRdtqO/VgmNIy54epg4lrQx5Mg7TCbJoySbBQ2ubi4v685Ytdb37K0YnjhiX?=
 =?us-ascii?Q?Rz0dPHPMPS0yhgVPlFx/2OpiQ2tnVy6uxmKUUaV/gliLbPdpEa46gxFtC3Dz?=
 =?us-ascii?Q?MrFKHYFa34DyatQuV8wDvysJc9zGiAMfcWNVUd+fwIxMdCvVH+iLZgAGhVL4?=
 =?us-ascii?Q?3h2a1ry395hA09IX/mYKsjJEvZ2eoHwSWWl2HIqoz/A9TM5K+Yu1Z1dk/Gzs?=
 =?us-ascii?Q?TV77bz0q78hN1OwFhu1KuOUa8iT0raiYkPW1aAbJFoJYytkvjRIaxEyz0GZe?=
 =?us-ascii?Q?oZzBaudisspozFydBd0XOxoTjmS/2GP+5zr0GL3cDQMsjjhUtOF4QG/XDbqp?=
 =?us-ascii?Q?Tx0Q4t547hU/WiRTRpa4wUYIap6nTB6Q56Lq3pGX4N4zqsSlkIqcaQ1ZYBYQ?=
 =?us-ascii?Q?HuhBt4Ox2FwMzshTnk+cEROkrdLyWLyBhTZgBVUUdg2pJ3aLmbhrjJlKyMiY?=
 =?us-ascii?Q?jkiU53JbAR4FDSCLpFmNQY5jKRX+iUrs8P9cw/n0BIhHS09JF6Qulio0UiiL?=
 =?us-ascii?Q?XWeGZuiRBBBQgLFKZtq5LVWZwv8XgWHnWHhJAerYEKPdY7Uo9li/vWN8DBk1?=
 =?us-ascii?Q?9ZXzdBPEc8hRladt2p1RQbEeFRwW0BvyxFsyYR6V6BIQjB5D+zZR9gcXRhQ9?=
 =?us-ascii?Q?wjeasy3oJ5flankIPFSldya4Q7hqzPmreuV71KDr0TtKIVun1JTooIrMpVOy?=
 =?us-ascii?Q?BzfYC/Ge7clw25owCJfph4r/szwWpzqmw08Gzy5b4H9mP3O+/nnFpwUrmetQ?=
 =?us-ascii?Q?kTceFmEokCAwurqLF+26o4SiVuFj6ATBNKZRvdUxoOT8fUcuG2xi4zP124X0?=
 =?us-ascii?Q?TcT+NbwArOtO8ek/f078ymCJDuNW2pi6gVqBTrHrIUay47r+M9QoIr5P3RpW?=
 =?us-ascii?Q?BJI0wk5+W4u/7PkSW8394l2njWLNMeeHz9LGLk0Gve2pbGy7siGWRf7enlPf?=
 =?us-ascii?Q?ezywtVDq8tZwCvzLyne/68u2uZE54x/Qqg6U19dbILC0nditNBr59gKPCOcG?=
 =?us-ascii?Q?vr0aHaWUOGlyofNLDyhHHz2ZnOulQxWu6tTCB02AqduKEacirE7yItbzqV0H?=
 =?us-ascii?Q?sh3m66bCmrBqvnFAj2GWYu8sSpG1GX3/x7PDHToprG/rz48+HtbctrdKZQwd?=
 =?us-ascii?Q?DWN7DB1KI33C0el2sE/5RYUIDdQCuecYYUywIYCLfNcje53QanzGgW8tAu9u?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c46d15-0185-456b-2eec-08dcc8291d2b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:50:08.9857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1zN0E1lfggZF4mqg1cad0a5fA6NANpEeb8mTxOBU28kxL8MMkZaDpAm18v6tcBcQT8ooUbbznYhlNNcuWRAGjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939

This adds a wrapper over bt_bass_check_bis, which receives a Broadcaster
device and a BIS index and checks is the Delegator has been instructed
to sync with the specific BIS transmitted by the Source.
---
 profiles/audio/bass.c | 14 ++++++++++++++
 profiles/audio/bass.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index ca20d6e30..7553d1bec 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -125,6 +125,20 @@ static bool delegator_match_device(const void *data, const void *match_data)
 	return dg->device == device;
 }
 
+bool bass_check_bis(struct btd_device *device, uint8_t bis)
+{
+	struct bass_delegator *dg;
+
+	dg = queue_find(delegators, delegator_match_device, device);
+	if (!dg)
+		return true;
+
+	if (!bt_bass_check_bis(dg->src, bis))
+		return false;
+
+	return true;
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 7e20385e5..5e34db90a 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -14,3 +14,5 @@ void bass_remove_stream(struct btd_device *device);
 
 bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap);
 bool bass_bcast_remove(struct btd_device *device);
+
+bool bass_check_bis(struct btd_device *device, uint8_t bis);
-- 
2.39.2

