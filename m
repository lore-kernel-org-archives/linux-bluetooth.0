Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16619938A
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908776; cv=fail; b=DwdaqI3mLHwPpwhzWFTQmVFeW72JhdHRKPi7pykXjvGDIovENYcYeOXCKx1Ap5bp1dVREn47y66hAbEBntpPmYSF3+Gn4cIrUcrF99fVKc/htlLidV9kotfsjhgYIPNHZ6X1pebA7nfNl0oPHVpxvi3Ih7RnbXkrsyKA+jlNjq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908776; c=relaxed/simple;
	bh=czaSDfnJVKCrrkGXMQAvEltIA7s3kIsEDsFBSbxx2B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iwWPdyVEeFDoy6IoJLrpAnWenpTRDbau25RGoH38TdH5pDvf+bxIjqJ5StA9ba1Pwqw6LbUExa+ZYt/pP+3HaFkCuqB6HfVoiDH6O2THFJYvMBuP6Ej4ebeDRbxv1dwdCOXjza97vUYyoQ55jQNiVKhJNqbWzd9dQELW3tWOHoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NdP2rPV5; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NdP2rPV5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DGGBBoH05dEtJZ+r9VdKjQo9JPJ4Z493Xk6cEC7egTzqTGknrmB2nxPCAQCjx6630YHjCWl6XiGYDcoGFCCueLsuXt7TziqTaAzdNult/4xPhuDrVIQikTgSOlNZwoaT7FPbQbou/LteRnGRbbwORQksHLiCOeStYqIwL/Z90AmkCMcrn+FtLTseNVFVL7GlL2vuuAfyfHjJovrCDn59+vyrIUzOVxR4vKL64GCcEmp51Bi8OJENbsPEjjAkCR+bl9XEnN1wgVqJLeJKfImRQqTTC/345kczsd+P57X6MhP5WSG2IGKl5Aox9IXi5w8Vq19HWRlk+vY68jdcGsSRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzzAhPYXwU0UJNjZ/EMvu71JfpR/pRsC1GViYxA2wdI=;
 b=DtgUVqr0yE+Hzv+Ai5/FU0msy5O5kZTXgQyhX4axbiN8uCX0Bm0Fr4igY7OOAbrYgZavTCOjAKiCbqCn8zszRu2/aMOmXQOifzqthCc9EAH3lS3ueASqlUisDdQgnvIEjLPDQIw3zoF5e5aY2MX/bjJIB0CulNbZw3p/jwJ7a1Y0HtxUxYxNgeR9XLPkDNnAkCWYohCNQrtcBtCWCHKKYmborIXtlOElSJONRpBWob751AZZXrAkifnptdw9sFFwn08Cm60de3RTlugY/rBV7gphPNMS+pqZxgQvMQas+3aWVNdAyd+5bksUY2Fo/jLiT7tkJlOpqB8uAbbpQQwj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzzAhPYXwU0UJNjZ/EMvu71JfpR/pRsC1GViYxA2wdI=;
 b=NdP2rPV54zNKmood/Tb8Jft9f4gi1Y2HasX4DLR2sMbaVobmnC28MVOfgLx3LYqqBN++08uFeguClZ49rKcq9rYIhs3CDg7BNboA9MFY40CI6dnqibvWi3TtLk6Z9C7eSuuTTCCDaGMtNAgoLvn6wmG06Keob5EWBgIaDFRbPs8WI6YbWThoYqsn6EDA0o4caKRpXT+HzNOff/loKBER+7++hMaYQSyDAhDJvFYiCT/tPZ7sFfBNjmRH056yDNyB96zRzfxKXTC3zz1jdFvHp8TfoF903Ta1qAsFSIZ7R+H5/RR8bZHETngOLshXM+/0DNmI3QrqH9OgfTa6fRTeVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PA1PR04MB10795.eurprd04.prod.outlook.com (2603:10a6:102:491::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 11:59:30 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 11:59:30 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 2/5] transport: Add 'broadcasting' state
Date: Thu, 25 Jul 2024 14:58:51 +0300
Message-Id: <20240725115854.234781-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
References: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PA1PR04MB10795:EE_
X-MS-Office365-Filtering-Correlation-Id: f179e0f5-af48-4636-7b86-08dcaca13d90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iIphvhTe7+7HV/RBXPgcDeMv+J2rkJcMyMf7+FGY7AYs16JpT9VttFevYIOO?=
 =?us-ascii?Q?D8WyOQOu4F3x2lEqXySMv0I42Kajro8mL22opZ86ZjDu1GqjQ9JfUKEi+cly?=
 =?us-ascii?Q?avabbdzW9VMfQ0xgUhcRfRqJbKFMsTld8U1SDOsXzX+MyCouVHQLWUTPPESb?=
 =?us-ascii?Q?pzCy2K3CfJfz3t0eT3Po/DIq1YMuoST4fxNQBUBEFt9BiIO5jF5bWWw3k57p?=
 =?us-ascii?Q?7XMGQUDLCf52rtG2E8j9/caPT/e41/wL1YO6lGLeVYPQsrkTvJRbtVA3zgat?=
 =?us-ascii?Q?PpjeEB5u7qtHUm4RGjIHxAvM54J8+IbkFgY9NIFNEYkPFBvhPfJicqQ3sSMt?=
 =?us-ascii?Q?URWnSlNL85KvykIv8s6UmWPYubnNLs7azsoG7/SbxpdMaULO925eeNFkq5nU?=
 =?us-ascii?Q?qfQeSBFUX6h/jfaOmtCq0bhB1Gw3kf/o/0jDlwu9U1sohI6PPc3ScjivvOn7?=
 =?us-ascii?Q?+oqaWtcc0WAsTz5oxpQgfl9g1/+9ipzaFy6BVp/390qUrLJXHTtQgZ5b1t9t?=
 =?us-ascii?Q?CGoC/LCL0odtkfV2wxCixesoCJR9cUUIsBa3J/y0Ywh5aoaRfTa9FDK1B4Eb?=
 =?us-ascii?Q?SwRwAO5jZqJ0MVjyro5ZpqOJ3CQMQCigFxFWJu/3+NXrvLbhJWMKNfQGOUj7?=
 =?us-ascii?Q?uVb41GK9oqmPe1hde8BA0t3K/9cI6SP+CCBO/aL4HK8eEkav1MoXCNiKU2Cn?=
 =?us-ascii?Q?sGHqM/oZVHEYl/HGlAV0wfRQi8azsFhtvdeS09tHWaprA7+1XaoSOJio5Vl3?=
 =?us-ascii?Q?Y5XLn7VJyLLFqn2UoRi+GM+ZL2xHnB1O5FgO5m3vbqIyuL2HKwPrOIjSiotU?=
 =?us-ascii?Q?eDgtS3MB9DHOJWbi2KQjGP9SFF1b6hOY41FAbCNjgR2FI9g6VNefZzSbOhl7?=
 =?us-ascii?Q?O3jPaZL2zEIJzyM6cnQOLykH9tiN15Xlzob+RhrCddkrFEIblKAkUpHckBAB?=
 =?us-ascii?Q?dHiCsdcF29EUAV5KsEDddol2fPwxIfaaKsuZi3R8UJYDH9oD/4oEX5Zuhgrq?=
 =?us-ascii?Q?kCk/DcKAc+ImF5DzHo5iYYgP/6pFvpzpTQpok/2h9BH/R8sX0k+XEkH00oMD?=
 =?us-ascii?Q?vU2/6wW8/b0TedjyLHPkz71VBSNWjM7ZLw3UqM6CIUgmmkLqTIv2jdQYKnDw?=
 =?us-ascii?Q?Xmx8NE1hVV41I3RloukDEIAPEBFPuBYu5eGaBgcXaHxU2HK+euF0ZtbXfXKQ?=
 =?us-ascii?Q?3JXQ2iT3he3SVbd89BdlyMXMXB/0NG6bDqsSgH/PTqjUArXxGKK62qb/SiDY?=
 =?us-ascii?Q?vfmWPHbeNW3NJYXniDLM0CBP5p8eoyBtmSEwVmoo7NFnYo2udXdD72Hxif5t?=
 =?us-ascii?Q?u67+NDlSoCyRY26B1WZ/fZvi6c83Yi1JVLKOueIEI6WHBgliDa4kkV7b3CZ7?=
 =?us-ascii?Q?c++BjQyk9s9l5B6Pyd+40dOH0eqfYyHKywRhwbXGH61SH/dtkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?grlWvvf2rRXwEAg61WWwhrpWcugLWdwm9gspzyoLxO8pM+S/Yk7rscdbXe3H?=
 =?us-ascii?Q?mRIbaE8VtouFM5KY4TVVYen2mBHX+YvltTnc6uzrGYngCjvmbjbBKwxIIigk?=
 =?us-ascii?Q?hVR33FEIslY07hYbrsLvy/jUh+s2lkyhpsRjWX4dKpgRRzCdLv74rQoTquO6?=
 =?us-ascii?Q?IehT7HNYClNJ+mBXw1oBsGC4DA7x2cJJ0jkRsdvtMJ7pbjaaHe/5Jor7qc/H?=
 =?us-ascii?Q?M+zAXQHpn+z395KixzrBuXG+oupj7gm3tvm49pG17PNtsAgz6e53jHCRlhFZ?=
 =?us-ascii?Q?LQGEEGihNdb4kMl8xUKjPwDus5eiebR33INRjlxtUpbJYzXhirhVSZW73scj?=
 =?us-ascii?Q?+DRKK+ztHkPaC2D1qiIB73buZs8BjooQak8BTtsQBwlLS/Y50KgsVQULbHqM?=
 =?us-ascii?Q?UZBhqyEqjmaZXLMI3KjAZxUN8rx27yRZNQm6U0ZPpcGxWhWUc12d+QVeYhmn?=
 =?us-ascii?Q?ggGON19mWObU/+BdJR2XoTUIU2GMrTr0kMYh03GaWC/6OvcaByIHbqlLD2a9?=
 =?us-ascii?Q?1tQxOlDPIOIE61Uhgb3qM6Azq9BR7F8CuAOlme/oJap8Su26JMnFFP17IhgW?=
 =?us-ascii?Q?NdEvYxjwIUeFtZAe7pXzSUpx1giH7gn24LkUfmwVjo/kiZj87ktA/j0pXmia?=
 =?us-ascii?Q?puEExbQSmS+2TSLdLF97iSoP9q1Z6OGSjwPUxaAca4LCowGIsQRD6Wo4i+Ak?=
 =?us-ascii?Q?t4ymogLAta6hVKUA1ZyCZzHp/NcggjRH/eP346J0uQVM9m0m5UJwrvjtTheQ?=
 =?us-ascii?Q?JyKiNQ5tuUFIv8AsbA3wl63QJg8q0prmCHxhFTNYBdMg4M3np3frytNtrbZr?=
 =?us-ascii?Q?ujAHbYPszxSMw3yRBBkNFomt1kL/0gP1B/i74QtXZGZwtpR1xP63JOSDO1c8?=
 =?us-ascii?Q?lUTRe8KFKfK6s4jaD++WhFyctAezsslSqgGVkvoSs9KZpNAN+0rpuLYNlXae?=
 =?us-ascii?Q?xzaD04ubvUq4FI3rkMnL7D0W53XcX8UVxGJhDDBwvFWaJ/zsanMIA3PLhkKD?=
 =?us-ascii?Q?DZx1v3aQlf3X0c2Q9mTL1UePZXW/ensEC/G3CshACMsLI7tbgpcYObJp74wR?=
 =?us-ascii?Q?8/CaWriq+rjfDqjU2n+titg/4plg3HGFXnR8Qd8BD9Jv9Ymi09B6NFyMSw6Y?=
 =?us-ascii?Q?qbpZ9wXEvj2KtJ5gKfkM6ddB3uDx02qiva0IrAa/U0Ky4Zd1ak9Valxva0Hz?=
 =?us-ascii?Q?q4hV61Sd+jtJSuoYT9Yq2392bO6xX9bnScQ4E0y3Zi+1gaolMVdLgbcjFX32?=
 =?us-ascii?Q?LWVPYGbc7lW+T8Ax5wmjvI2ZfThI5BO2tN4pt/qLFtk98UF9bL8LDHuR33Mn?=
 =?us-ascii?Q?xcfae0t4dWvwq3gsxvWUYP/1u89kRFzQx1E3yzDeAN/JTI2ZSqzbqWMUuQqX?=
 =?us-ascii?Q?KqsHLuDbW/8ea6ofzC9pi3iASuXGPFUBR9/PFfz0lgrW62sBjIL0/oKOlBaw?=
 =?us-ascii?Q?DsJu/KMtCBfjpjmyOJyhQE3gsRcptC6LL1vWRk7oeP7Ah1tKqQ/av+EvHLLE?=
 =?us-ascii?Q?jfZ1GZtHfmpzkGljF6igmvBSedtKebHHMDvXkiplVNgPfXnaloXUOis5ZvlT?=
 =?us-ascii?Q?CbCX4zddbx+eFXKpI1RtcnRrpgqottnOgJyEwQD7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f179e0f5-af48-4636-7b86-08dcaca13d90
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:59:30.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zo9S59AFkxo4ZkKha6kgVNyRdHLweFnaDeu3GNXVu+qZFas3B0ptskA/Hgib0/++BdKHcHXsEHcigmqGtnbNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10795

This adds a new state for transports created by the Broadcast
Sink device as a result of scanning a Broadcast Source. Such
transports will remain  in the 'idle' state until the user
selects them using 'transport.select', at which point they will
be moved to 'broadcasting'.
---
 profiles/audio/transport.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 922911cf3..0a890c0ac 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -51,6 +51,10 @@
 typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
+	/* Playing but not acquired, applicable only for transports
+	 * created by a broadcast sink
+	 */
+	TRANSPORT_STATE_BROADCASTING,
 	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
 	TRANSPORT_STATE_ACTIVE,		/* Acquired and playing */
 	TRANSPORT_STATE_SUSPENDING,     /* Release in progress */
@@ -59,6 +63,7 @@ typedef enum {
 static const char *str_state[] = {
 	"TRANSPORT_STATE_IDLE",
 	"TRANSPORT_STATE_PENDING",
+	"TRANSPORT_STATE_BROADCASTING",
 	"TRANSPORT_STATE_REQUESTING",
 	"TRANSPORT_STATE_ACTIVE",
 	"TRANSPORT_STATE_SUSPENDING",
@@ -139,6 +144,8 @@ static const char *state2str(transport_state_t state)
 		return "idle";
 	case TRANSPORT_STATE_PENDING:
 		return "pending";
+	case TRANSPORT_STATE_BROADCASTING:
+		return "broadcasting";
 	case TRANSPORT_STATE_ACTIVE:
 	case TRANSPORT_STATE_SUSPENDING:
 		return "active";
@@ -152,6 +159,7 @@ static gboolean state_in_use(transport_state_t state)
 	switch (state) {
 	case TRANSPORT_STATE_IDLE:
 	case TRANSPORT_STATE_PENDING:
+	case TRANSPORT_STATE_BROADCASTING:
 		return FALSE;
 	case TRANSPORT_STATE_REQUESTING:
 	case TRANSPORT_STATE_ACTIVE:
@@ -679,7 +687,8 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 	if (transport->state >= TRANSPORT_STATE_REQUESTING)
 		return btd_error_not_authorized(msg);
 
-	if (transport->state != TRANSPORT_STATE_PENDING)
+	if ((transport->state != TRANSPORT_STATE_PENDING) &&
+		(transport->state != TRANSPORT_STATE_BROADCASTING))
 		return btd_error_not_available(msg);
 
 	owner = media_owner_create(msg);
@@ -1281,7 +1290,8 @@ static void transport_update_playing(struct media_transport *transport,
 					str_state[transport->state], playing);
 
 	if (playing == FALSE) {
-		if (transport->state == TRANSPORT_STATE_PENDING)
+		if ((transport->state == TRANSPORT_STATE_PENDING) ||
+			(transport->state == TRANSPORT_STATE_BROADCASTING))
 			transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
 			/* Remove owner */
-- 
2.40.1

