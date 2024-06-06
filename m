Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2075.outbound.protection.outlook.com [40.107.241.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79A194AF4
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669561; cv=fail; b=pDWPxq8HGVGoa1b2qnKDaB7IbV4xeEK/T/iIcrdKF9PLsCSsFtHrnGjwV3eXt1FVYnbQAv/xzNgEyuNK1AM+UJ62d+MT5WrK1KJnYvmjAQZ19GyXiRtdoDb4W4jU7hDS8P0B3QIvu5OCiXalXyaXaIYIjHrNWx3cc6Fqwfs/u7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669561; c=relaxed/simple;
	bh=o3E0CmzPtP2Y50WcmO6nXom6T/AGhwNn1LtRBNI5HWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mN7s9I2gZhGwu5D0WetPGz5ZFeQrWRW0JZ+GQlAGIShLeLsIYXHACYCD7QbpfQPQFDi9vIdjoHrPQIjmOQL6EdbExULmjVvqfdDCYOypeUjpbKU3FYPd0mS2ZNIrnv9Tf+khukf43VQjdhilTHRXFk8gdMtbz2ctZpyDnBtPwm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OQrQIE2c; arc=fail smtp.client-ip=40.107.241.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OQrQIE2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3vJ+DohapuqVNYjKbgnDpOBUF8tnFtdH8ufZ5NmnYaQ28PHYDIqOgWhVFfiYDk77LNWk/JzRuV6XOlG8UArTEcHRGja28VGTVeC+2YqnGRXiycPoKW2tx/OyNJwshnz5eiwJ7v5gtndgf0nHcLxaA+F4uX8i1m9P8ItenP1j4F0DxC4DrwacyVq5QY4Sg3Mef3lwKBkn6Rf1wjoWAmobsqn5b8gw7LtwmDsZimLoB/lYu4ISoU6hDMSWwK5JruBgdkfzruKTytRYQejBQM8S5JZWD8K96/gkLIq1KOO0SgFOqmUEWGHuzsJ2Actno63sq5fO+R7hCkMmmgtHsUUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxo4uK6v4oDkAFv6/JRLWPbZHpdPSTbc0H6ALWFtEsI=;
 b=gX44jbwKJSiwbMRgIhXbZP8V/j3xCaOnkvB8U4+/Lt/5E0x2T+3WvPQ0XubHmwN2HCDTR2/bOUHWQhuZFmZSrWZ5GMoCBeRSgP7GmtjO/l+hljZv1nY8Zs4dnoapsDGBhAe3I3qGmeaWcUAbMN71Z9MV193hG+8/HSOb7C0/B0TUhhkbdzRNVZ2RGnL7lz+6uWw8oERXGcq6i++DHCrhz/fhE54fI2wQJD7a2R0ILgYHzS0ndekeYRzStqkpgk+CNta7AY4+qv6GnIpGXduoTkO29ArZQwhmiNjNnGCjYVk/cYPkaczmE0bFSv2legQYP6lLQGMAKfG/pXKqNQY3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxo4uK6v4oDkAFv6/JRLWPbZHpdPSTbc0H6ALWFtEsI=;
 b=OQrQIE2c0K+TPeV1ZrLD8bucCkCE1wRd82vt26RKFoyZfbryohutX4om+Ho/V4LkiIjpEwqtshsmKJmCS31G8ODVHhM3cXHRLMfGwr/SkGGiYcxZg92TTkZMjDUEESssjlGRDEd172kQpDmPKle5R/+dh1JBgSp9v10T97fMWME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 10:25:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 10:25:56 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] test-bap: Add support to config multiple bsrc streams
Date: Thu,  6 Jun 2024 13:25:40 +0300
Message-Id: <20240606102541.5395-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606102541.5395-1-iulia.tanasescu@nxp.com>
References: <20240606102541.5395-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0125.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e6af8c-9cc4-4689-49a5-08dc86130d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?26Ox8J09MKKP8eI02G9yXVIpyEjH9K5PTi6olz3aLqXS+NLYAezd0KuuShki?=
 =?us-ascii?Q?0+n1PQYQ0yeM+sHxen9zl0ASVg0lS08S3aiJZ+9URmmL70Q407cJFh2Wo+BV?=
 =?us-ascii?Q?KM9W8jIUmgj13mpzZbv24Pp4ITHZmZrzAT5bg5L1m4SXY3WYQoNaK2fbIZzH?=
 =?us-ascii?Q?QcKi6ZFrL5nserEIoxAsDF7cpKkcBvhYNqPAoiUjFCohG/NC7P201oSkfxUO?=
 =?us-ascii?Q?AGNr2pNWgCU95qr49OLX1DwqBKoWhtdyq1EkXLRrNbgdNeEXP1UAJ8EmutS2?=
 =?us-ascii?Q?9FbXfvEK3gA4kZhrSSZy/3P/T9YT3DRjV63gD+TgjY/up7INc76Lcs+CdJeo?=
 =?us-ascii?Q?mI7h+xvTYbaBsKPgFDKLYINeG3G6RLSVu7sIe2J8aJ89vausAc/+M1qBkl2M?=
 =?us-ascii?Q?/nbLg8UA9yFwHJSsagvsdpi9JLyGCXHB0Hx34qBcU1fuMD7SrsdxAyd0oDcg?=
 =?us-ascii?Q?0sXmkhPFepUAaPLpRyWs0EifXoeIXVEOvBr4zfXp1CsuzjVYegoM5om+H4gn?=
 =?us-ascii?Q?M5cz3iyQJVmJCRA3kQwoJYZ8vfYpgrnPAJ4rsh94H4GUDZQpco6qO7QTtWl/?=
 =?us-ascii?Q?APpqy42bfPaLH45XKeAt0H2njuh8b4clRlavfaUMIsg6pg0WqNSBMCodyaiv?=
 =?us-ascii?Q?vy0WR33U0sgyVzAOPoF46YEgQo6o5MXGQDwcxbxyANSF5ART9ggbzCGj4gBC?=
 =?us-ascii?Q?32UhFSxoRcTtBCZ8xrYlMZV4Dl0u2swCE6Kd6WFRqEzXJTAhOpdlF3SucONk?=
 =?us-ascii?Q?gOlTNIJgl/bmcsAckHbydDMbOYfa3tGXnVnm7Q4kmbKSvNgDsJBgj59MrEiT?=
 =?us-ascii?Q?Y4r2UFqenuR/BsvbDwFy7p7IrnmyjSG2xqF/D7BkR1vu9X0PKgnCweGkWhmN?=
 =?us-ascii?Q?axbl2FtZyXj81Yy5ZG3Zl4wBn6w7cEZ+DjSJP2GTFQ4vyxxT6ZPTRICIsS7Z?=
 =?us-ascii?Q?diJ9kGbbj6evmkj3S5OMJu/Z24QT4B43bDZ+K5fIU1lvqg2oGKj0ELnPj+Wp?=
 =?us-ascii?Q?Sfl2nESYfrdJnz42eIBQJLhMZ1XUiUKI3f7ca3VhIfqo82MhjPpTyNYu/JpW?=
 =?us-ascii?Q?SynwZiPE1XnuEgqSI2PPSTfF/ubVQWwhCQrvlhWFXn24xFE1RDTQgHz8Qva9?=
 =?us-ascii?Q?IN+ydvPtQW28wJW48Xkd7f6YpLQ5IFm4gMLcauU+snol5LoGDsa6I5OSWrHz?=
 =?us-ascii?Q?zgNYvOZCyJ6rG/4/jpXtoZKkyHRsWUikcgMyqc/iahDsArwScZjd0jwcboAs?=
 =?us-ascii?Q?Ajd8xFKHGGcbUCju6MPDm+Fu5hSTnkIAeOXVqAeGr4EMyZ+Ykl6EQo9/YGLN?=
 =?us-ascii?Q?Wd09aGTJVY99c9KU2UIsuTiP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DWs3FzFNzAQW8hoDjkE4MX+wohRDGhB0Ll77jqITdt83E63otReHOOobLC5M?=
 =?us-ascii?Q?35RQc5Nd7TwXsrKPfwE5Y7A+viMojzxymsRiWhqBothN0O2420b/IuaM4Fa/?=
 =?us-ascii?Q?8jI7ffOjpy2jQfv2EPapFy6nu3yFbbUn8iYptfCJ2Yyi0G3bLvBaer6ZzUsb?=
 =?us-ascii?Q?wChL8lGyFv0kmhLL1vD7oJ4Tllk7bgJpZ22R3A+GthfhQLwkqHZeTs2cuswV?=
 =?us-ascii?Q?S68DgWs6rAaho1NK51HsM/97DmnCstNHvybBFRdlV9SaqK/8ee1Bat0iNWC0?=
 =?us-ascii?Q?nrW0XNorEzY4d/6hFsRAPd7xDUO+87ikSXicYsciICoxkoS5tsmv/7RdwtKo?=
 =?us-ascii?Q?TAbulvrJhc/bQUSAbH6wqOwY7OkvU5M/A4pEztsXMQrnAmplI+s8A0zoGkbH?=
 =?us-ascii?Q?0o7XYH5RBIiEENYVEXQXWrCmKEjRJCszjvyUJgtZW2ezVPwxpSdsg2TkkARf?=
 =?us-ascii?Q?hVrB6T9Jn2HFtmRoZG6YM8XEfnfn4EOmJCivNPFE869FUuPkhkVmQ2Srd9Zk?=
 =?us-ascii?Q?y2OaOwaBWlPCs0qrWhAqYL5mIZW4cANchkk2hd9NFOkPKUooR+bDVQjIZo+Z?=
 =?us-ascii?Q?RgTMARZmWoUEescErFn/XdAYN9o+4kKZN5E7APWxxKr5rAQe9epsEGHA/p//?=
 =?us-ascii?Q?o1JVUdFJby1LzRvHYiN14wwVc2LBKDsW7/UnxiHqgbl4/c1xiWP+/Ljjp5cO?=
 =?us-ascii?Q?e3Adatk4bRWv0Et2G9Pjp56NW1AnQxDa5aQ9RSICuE/0vk9gvvCd38G0SYfc?=
 =?us-ascii?Q?RMm9p70nrjzgQ6bxPjYgo1UsAAEdBfD/iTEEByAXmJgkgu0xct8RxTYwog1F?=
 =?us-ascii?Q?oGLtAIYf95z0trHRIN+GKoahQ4YKWiIersyMexLrJv92Ym+XouDCFbVmijS9?=
 =?us-ascii?Q?pQj/b1bjKGfPfSdJ8Y+Ve32xBJMiyqwbh8U+BrgrHQLrtlL5JbmxYQO5UR7U?=
 =?us-ascii?Q?Ph6Vs2rGNGs8ktSTTRSKB41ayPZi4KLrhpIOwEXaImrH7SFdoBijEJjWWeWg?=
 =?us-ascii?Q?mkt5TFr6iXM8pJ6OTvy9hsGk9Q5VuLPoZg66HSsUR5CZRWEE7MPlNuNkUcBj?=
 =?us-ascii?Q?0gWTPbqN69qTLhuz2hN9Xy5kdJfSW56W4L3rjy8aUKmN6rAKZYnwOYFMAU5j?=
 =?us-ascii?Q?d8bZFr6NBrS+SJ0SdYpG30y0dmk1jMGOdilfK5XqVToNOCS7l44lJMqpwkHz?=
 =?us-ascii?Q?9rOcHJEumDjkH/ovsZw8chLmfqVXFS4EuD4Iv8Ax3A5pHfe+vCVRNFr4lp/y?=
 =?us-ascii?Q?Vndc3KVllFiegMHvOoinWS2ZyfB0Ko7wokXw1QJ3pMXfj6CY5ufz+hRNmtaR?=
 =?us-ascii?Q?acOUhYywMYOqmFu1yo5C4QP46VBu0p6PjXnvE+1m0tIUcTIj+o9NaHOgV6+P?=
 =?us-ascii?Q?nsHHFxXS+1pqk8Ue2cssvEe5nx0EV+mc5dQDFFMxxBb6Qt9jRcTL88MrKVNa?=
 =?us-ascii?Q?80tZxwLhZX5cALQ3kQE5qfUl0LvYDaM2h1lwu5u7azwQF+lb5wcsFOZw7FRw?=
 =?us-ascii?Q?FI/Lk20J4ZP6g0gg1fi0WmfQH1Rr4fXNtbScz38eFTiC4vBht/m3bnPRAeQb?=
 =?us-ascii?Q?rPyZN9sdProjlRgohTKziPUIOvVBR2iVTieAhsRXBHlA1g1uZ4njvJmcKoaj?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e6af8c-9cc4-4689-49a5-08dc86130d1d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 10:25:56.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6lDpgk8c9S/n2CKZwpLJ6NzA4b8aXlDSsGNkho8QBAfxaSiHqdgUrlbzB9kk1r/VBzHFqOhUZggBt1V1yrxSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027

This adds support to configure multiple bsrc streams.
---
 unit/test-bap.c | 52 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 638717afc..c37f7676f 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -538,15 +538,17 @@ static void bsrc_pac_added(struct bt_bap_pac *pac, void *user_data)
 
 	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
 
-	stream = bt_bap_stream_new(data->bap, pac, NULL,
-						&data->cfg->qos,
-						&data->cfg->cc);
-	g_assert(stream);
+	for (uint8_t i = 0; i < data->cfg->streams; i++) {
+		stream = bt_bap_stream_new(data->bap, pac, NULL,
+							&data->cfg->qos,
+							&data->cfg->cc);
+		g_assert(stream);
 
-	queue_push_tail(data->streams, stream);
+		queue_push_tail(data->streams, stream);
 
-	bt_bap_stream_config(stream, &data->cfg->qos,
-					&data->cfg->cc, NULL, data);
+		bt_bap_stream_config(stream, &data->cfg->qos,
+						&data->cfg->cc, NULL, data);
+	}
 }
 
 static void bsrc_state_cfg(struct bt_bap_stream *stream, uint8_t old_state,
@@ -5603,6 +5605,7 @@ static struct test_config cfg_bsrc_8_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_8_1_2 = {
@@ -5611,6 +5614,7 @@ static struct test_config cfg_bsrc_8_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_8_2 \
@@ -5627,6 +5631,7 @@ static struct test_config cfg_bsrc_8_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_8_2_2 = {
@@ -5635,6 +5640,7 @@ static struct test_config cfg_bsrc_8_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_16_1 \
@@ -5651,6 +5657,7 @@ static struct test_config cfg_bsrc_16_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_16_1_2 = {
@@ -5659,6 +5666,7 @@ static struct test_config cfg_bsrc_16_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_16_2 \
@@ -5675,6 +5683,7 @@ static struct test_config cfg_bsrc_16_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_16_2_2 = {
@@ -5683,6 +5692,7 @@ static struct test_config cfg_bsrc_16_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_24_1 \
@@ -5699,6 +5709,7 @@ static struct test_config cfg_bsrc_24_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_24_1_2 = {
@@ -5707,6 +5718,7 @@ static struct test_config cfg_bsrc_24_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_24_2 \
@@ -5723,6 +5735,7 @@ static struct test_config cfg_bsrc_24_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_24_2_2 = {
@@ -5731,6 +5744,7 @@ static struct test_config cfg_bsrc_24_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_32_1 \
@@ -5747,6 +5761,7 @@ static struct test_config cfg_bsrc_32_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_32_1_2 = {
@@ -5755,6 +5770,7 @@ static struct test_config cfg_bsrc_32_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_32_2 \
@@ -5771,6 +5787,7 @@ static struct test_config cfg_bsrc_32_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_32_2_2 = {
@@ -5779,6 +5796,7 @@ static struct test_config cfg_bsrc_32_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_44_1 \
@@ -5795,6 +5813,7 @@ static struct test_config cfg_bsrc_44_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_44_1_2 = {
@@ -5803,6 +5822,7 @@ static struct test_config cfg_bsrc_44_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_44_2 \
@@ -5819,6 +5839,7 @@ static struct test_config cfg_bsrc_44_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_44_2_2 = {
@@ -5827,6 +5848,7 @@ static struct test_config cfg_bsrc_44_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_48_1 \
@@ -5843,6 +5865,7 @@ static struct test_config cfg_bsrc_48_1_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_1_2 = {
@@ -5851,6 +5874,7 @@ static struct test_config cfg_bsrc_48_1_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_48_2 \
@@ -5867,6 +5891,7 @@ static struct test_config cfg_bsrc_48_2_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_2_2 = {
@@ -5875,6 +5900,7 @@ static struct test_config cfg_bsrc_48_2_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_48_3 \
@@ -5891,6 +5917,7 @@ static struct test_config cfg_bsrc_48_3_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_3_2 = {
@@ -5899,6 +5926,7 @@ static struct test_config cfg_bsrc_48_3_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_48_4 \
@@ -5915,6 +5943,7 @@ static struct test_config cfg_bsrc_48_4_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_4_2 = {
@@ -5923,6 +5952,7 @@ static struct test_config cfg_bsrc_48_4_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_48_5 \
@@ -5939,6 +5969,7 @@ static struct test_config cfg_bsrc_48_5_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_5_2 = {
@@ -5947,6 +5978,7 @@ static struct test_config cfg_bsrc_48_5_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define LC3_CFG_48_6 \
@@ -5963,6 +5995,7 @@ static struct test_config cfg_bsrc_48_6_1 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 static struct test_config cfg_bsrc_48_6_2 = {
@@ -5971,6 +6004,7 @@ static struct test_config cfg_bsrc_48_6_2 = {
 	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 #define VS_CC \
@@ -6007,6 +6041,7 @@ static struct test_config cfg_bsrc_vs = {
 	.vs = true,
 	.src = true,
 	.state_func = bsrc_state_cfg,
+	.streams = 1,
 };
 
 /* Test Purpose:
@@ -6152,6 +6187,7 @@ static struct test_config cfg_bsrc_8_1_1_estab = {
 	.qos = LC3_QOS_8_1_1_B,
 	.src = true,
 	.state_func = bsrc_state_estab,
+	.streams = 1,
 };
 
 /* Test Purpose:
@@ -6196,6 +6232,7 @@ static struct test_config cfg_bsrc_8_1_1_disable = {
 	.qos = LC3_QOS_8_1_1_B,
 	.src = true,
 	.state_func = bsrc_state_disable,
+	.streams = 1,
 };
 
 /* Test Purpose:
@@ -6241,6 +6278,7 @@ static struct test_config cfg_bsrc_8_1_1_release = {
 	.qos = LC3_QOS_8_1_1_B,
 	.src = true,
 	.state_func = bsrc_state_release,
+	.streams = 1,
 };
 
 /* Test Purpose:
-- 
2.39.2

