Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CA12AAD5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351298; cv=fail; b=lC7ON16GJxxAoFPiCWN+/cgX7a1UYcHB/PjfBF+fEoz0mTDI/lr3YLQCPX4tVt7A8CjHSTgpUaMba85AM86JU70hhb0b3gvuJeNDC6xkqj5eiN04B/75bzuzt262q1J8muR3KosTFFHLWHh0wh7hJBdPaWw+kij3ruKaxzflJUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351298; c=relaxed/simple;
	bh=KAGHhR2vv8coLp1Hyr9+VM11xX9sJM78cdstfPw7UY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKLtiiJnq1iKlY+BHws+TKb4YHPzcxhfdRH/0uAP+haDKvPjLkDkmk5cYizZkW1iLEhvKYVKLBDLcn0N8MWRvEUuDn2+5dLaseiLCj/XxjOlwCMx3mELurMuab7NEKvqWFZMQofNgZwhNlwFohuoz3Os27L2Fe5tiMQJPYepMMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hsVbvkPi; arc=fail smtp.client-ip=40.107.13.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hsVbvkPi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4hbadD3rEda/c1BiGqdrqW0HRoP9Mj0gdgSGoY1WoyeAq/WsE9xwxN4Up03lR2US51o0UZGdmRk0enjEcTjtfZhL0cNBOzigKy2TN01Wl9C8bX58S5gmxZGqwfAayUDzpeiI8Oxmc88xK8YgGrIJcReynwNgu3egz6SMpK+QBseB5oq08umXadNp+tYNWR9esUnWJ8B0GtAIEBLl0dLq963xQiu4UhoJrWKnvzKAWXY7Czd41cTnfNUpIvtq+xa6ZR3RA46cvRqSspOnE1JWLLfqFuIkDVOWMr3YalXcIvO3v1vFHo+BkufYasQeS1KLgvjI4CjzLaxfTlX9qYidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INa86BgwBvboxH60PXydDGjgQWkd4aUPJGfxd7vo65E=;
 b=A/KD/MEnx6RbEQH+DImEJ0y0V1wcF4rV2SYMQLwpKtnJ7mQzMxXRmUCMD/s9mxjQ19mEl07C4/SZQ9f11t+HBxQdKDdG1645WFFUoJZwWAbOY+gEPLZ2duHh3sX2wtPXxvXPPEy/16UWd0RbWVDfuTHTQMD3nxYpMPbdGaFSHq4p2hn0lkmRLrgX/GgyU/yc+rlGUtlsykem0zmxbHldHWdN3i8aLZi4Eu5XztTdYej1bi8hQw74VCeigBCh8KhIqC7eGcNghi8x3rBBXjFe4csZLAlgSlmNzh5aSIWDiQ8W46p/PVPu1ATsmfFLDHI+Tkj8gAM3uOkYq1kOcAfZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INa86BgwBvboxH60PXydDGjgQWkd4aUPJGfxd7vo65E=;
 b=hsVbvkPiBMDykMOdiGv+O66Ja1CwzsBxEXJPr4uANIb6cPIcRn8J8CUMBxQD2AS1Y+Cc/SP4CKDVqD2xctwUTZBmpLcvLEu/5uEVlehr25nwRnkn++h39fnrtwuHF1R4uwsRKmhJNRIpdebZytUxp7z8Cprz2u9+OWZl0kXQdYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9592.eurprd04.prod.outlook.com (2603:10a6:102:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:28:11 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:28:11 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/4] test-bap: Pass test_setup as test define argument
Date: Fri, 10 May 2024 17:27:53 +0300
Message-Id: <20240510142754.3901-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
References: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0238.eurprd08.prod.outlook.com
 (2603:10a6:802:15::47) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac44968-117d-47d7-fc69-08dc70fd6b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OoXk2lmTROP6dDv3Hji/MAQxrEWZt5l0XV2dzixoXdYQCQVv8tVVFZKtmXDO?=
 =?us-ascii?Q?nkjKa4OqAwmBvvZjnA+u0+jSzPZ6v9xcUDnieAcEsFIGfJ4WNsnYHARYBvZe?=
 =?us-ascii?Q?Ruosw55KoB6PBrLFNwcyJIL53DfOYzxkDTNFUMB2gJ50m/TpUeMf2fw7wpJ5?=
 =?us-ascii?Q?nA75LiHL1EC66N7/kSO0Zldsv+4RJVgUqHVxwW6hdzl843xtMMB3Cmb42zLX?=
 =?us-ascii?Q?sStpzIW85i7avFU3HDujFLIyuRLv74nNOG6XliNa71dJ7KHcOqqZdh+p24Rx?=
 =?us-ascii?Q?qyAnn41JFXYcB0d3xkxzZYNbGRz7kPGr3nIR3atoCe1mWyNTDsEY6yzq+1z1?=
 =?us-ascii?Q?5gGHdV22mfjtzWcjsCNzK77Z2Cq67POQo4MhxpIJ6NiAztBQr1m5BsWAoGMU?=
 =?us-ascii?Q?r8vb8/M/Ig3/hIrYl2oUVYaBw6wtSKExyXdpTXWPaZeBzI7xR/b2M7GwHWyS?=
 =?us-ascii?Q?TLTEB4ycXGYoe2uVil58IPU0hmf3CiQcJkzt3mehame0H2jsI+9nWnj2QETo?=
 =?us-ascii?Q?HZlL+pTrOdu8nMG0WIvUinWUfnn6QhOmBUNvr9Axi788Od6/Vs5A5GDhdQRq?=
 =?us-ascii?Q?4kosNYny26fMx4MgN6mNObiZvCTfxUjFmHepboDKORosOkF/KtMEX9ki/5fm?=
 =?us-ascii?Q?X+uZat00fzFyF4zeZm7gEI+jek71X+9plaMC5lmPGde/jxbLWAX3Af7uVu+4?=
 =?us-ascii?Q?RCa1dbE1O4femEeHpmG6yCfCbvI0dfvaKupgxvHlD8R3vulvy0uTThgxr6Kv?=
 =?us-ascii?Q?UouQPE+B5AuQrfIxomCWQdV6GpELh/qd1wTpIU21r/uSA9QDiIEEPcVYYrVH?=
 =?us-ascii?Q?HWCFDxC3VNyx94cuzGk69UmVI0YAgSZnMOLNvV6EOPoJR4e4kUhJM4AUpoGo?=
 =?us-ascii?Q?b2fglsrC++GyIcqWfqt5luYIBtl6AAMihgFZnPg2IW8KYwl7bbvjGL1n2OV9?=
 =?us-ascii?Q?uXWpRpi7clGFIpP9oKNsuwTC5OGcDwRM/GxV99Izo60vE5Q2TFNa8q2Ocr0e?=
 =?us-ascii?Q?9YgmoWomzuetWy31yMWsZyI+6f5MliXSExRJsCIaHALynReZlpEscwvEsejt?=
 =?us-ascii?Q?0Hyael8fOv1366B2eF24Hur/Jl1qNzqKdIbel+llxGvigG9+t1WYGXpRmQlF?=
 =?us-ascii?Q?tVXSU4CAuxvg9T7+7NYZ+JbQuTpWjXq4qZE6LyIMQBm8tt0/azbVelKhtBLS?=
 =?us-ascii?Q?Vzmfq/psIu9ENuGUTlIR1PPVYeXeOniajDy0bqZCyKQ0hmpNIy6WrPHHwhP7?=
 =?us-ascii?Q?Qov+GqeDaxTLsfUq5DMqpFOGu3ONYZ4J5fP3/XeYTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IfiklHQWWYcTALs0u5+MKFv2XpBReHSlwwt4eXwnrE6QZZaa+t6+yf+Ng705?=
 =?us-ascii?Q?98qMb0SOW/ppsRvG4VaFFyUnUY5kejwOrflQw0dPLDGpm905wOsfzFAOQHSm?=
 =?us-ascii?Q?awxcxpgNKOx8XIOH1sf+7j709tIR7pt6UIqGI4+u/w9RhUheo/bWdEaPwNn4?=
 =?us-ascii?Q?x4oQM9g9bDsiJzhcBsRMpAOrqWup32lVShi9MXnI+ajaSjck4phyGZ8boxYc?=
 =?us-ascii?Q?WN3xnptSJXuN3sxstRF0kLwj73Ba+im6X4Is9G+mPUqWZ5InWb1qXIaP11Gj?=
 =?us-ascii?Q?Sy7Ha2Sr7wXOmsltSimGONYDPI8rYwteBDyfOcHjLCQrqFDJKAlAb1w9ZsXO?=
 =?us-ascii?Q?Fi/KBWktFWEjhdtvLyl3x6x2aYZKuV+yhOBUUPn5+wDOyuvU04XcZxQT+huQ?=
 =?us-ascii?Q?IZxH29EJtVCy0ZH2GjOw76YQICuCC89JCY5Owi6VX0kSjhYGy7eRu/ODyFLH?=
 =?us-ascii?Q?1JqG/7gRUivwXR9BLG9tgsRDXaE4Q4aCpJQw79qEQEZFgcjW0NjS6dybRu5P?=
 =?us-ascii?Q?uuk8lZKlGl4o4HabCmDR/ntMy4s/l3QDvkKG9M3JcuvMYapgWsXjQep5Hr56?=
 =?us-ascii?Q?MDoy1DGRu469wCXGFTMJ+yFYutt+JV8p5TEpXjhkrTYNIBcNKcv6XuB/k670?=
 =?us-ascii?Q?HOc55olU6o1ZCc4U2A8PkexL9Q7hUYfFYZtdHWYY5b/3T8iI/vKA55qO3JQe?=
 =?us-ascii?Q?GCSrinM4Rf3zidGw6h4fLDYA65KXXvmwqVPQrq83+g+l8SvPOtTwwAgWA3P8?=
 =?us-ascii?Q?aY0JekQxVq/xu+LmfdQmso+gtvOOdlH+tqByMxHhiTDaCDqzECiBKLB2aHUH?=
 =?us-ascii?Q?6tNf09kXJcUaCf0bU6agNJ5LTdGE2cPFkjnAcpro44KxhTptwIR5fL6ZwtR5?=
 =?us-ascii?Q?kh1S2yKOWOYCPBygszZYatxdZlsdXKf1KdzKPETdq7vNApABk94rrbwEySND?=
 =?us-ascii?Q?GY/nH0hk1FwN4Sxy8J3Qhw44t1Q4wpJ6I2Gue9njSm9DofsUjlw9z4t0mSHD?=
 =?us-ascii?Q?IQCOSuithUKl3Ld9iYM+DmWbfrffTruSNOADgg0KXfj3kC2qimZWhGtEl+0D?=
 =?us-ascii?Q?36ckKj6bJulYe765KKkeX2jvIxA3O63lCZNB0qYiidlpjTjwQ7b5qFpW259A?=
 =?us-ascii?Q?ZZhh+jBbBM4ZvJ3x3umD7WGkNkD07e2tDJRQb0mXKAvSG1uuvnlMxUwZIJEj?=
 =?us-ascii?Q?SwRxC0pFOZ08NeTMj9QYzMQNpZ79OJ9X0jk7fjKQHm0Hgk+bW7wvCmui2SCg?=
 =?us-ascii?Q?IqmZ17UqsNKGXHYlfHVLBdZG1qyyXQ1x7MM9tLTJ6gnu1R3Zww5tLP/E4QJd?=
 =?us-ascii?Q?MLro2ZVaR0WhDfFNWUG+Z8RKw/BbrTUryD0h260EaO/N5lS1VPWswLcN9aV6?=
 =?us-ascii?Q?kFFXdEZvMf/5w76iLY2dRfVLkfKHsn6aUa1Aor0tBTxxCxCX5EfuBuPB9K4K?=
 =?us-ascii?Q?N6G8nVtmfO48aUaYp2t1OB4GkAyafHbCBorLIqhi8PjcP3yz+xNI88jB+hVF?=
 =?us-ascii?Q?hza07Y0eWv5h8tNNOMFzAtPdRjhE3q3BBNi6BEAEm0MTMpl20y6dBVMxqRyx?=
 =?us-ascii?Q?XqlphSzeMXIDzGiNJB2TQKGFwpxEgRTM07GXpRl4qQHWpBxK9dS7SmSuxvsx?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac44968-117d-47d7-fc69-08dc70fd6b34
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:28:10.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tk1iB66fvfoRnr7XNpWF7OiPwLVqQgYECr94eJhtKLp6Ge/zBNfF8/RoxDM7LsgCZnbDEvtQ/W0bbFPUlLeOdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9592

The current test_setup function is only targeted for client test cases
that require service discovery. This commit makes the test define more
generic, by adding the test_setup to the list of parameters, so that
custom setup functions can be provided depending on the test case.
---
 unit/test-bap.c | 584 +++++++++++++++++++++++++++---------------------
 1 file changed, 332 insertions(+), 252 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index a465597a0..c6b3a2b47 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation.
+ *  Copyright 2024 NXP
  *
  *
  */
@@ -67,7 +68,7 @@ static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
 
 #define iov_data(args...) ((const struct iovec[]) { args })
 
-#define define_test(name, function, _cfg, args...)		\
+#define define_test(name, setup, function, _cfg, args...)		\
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
@@ -75,7 +76,7 @@ static struct iovec lc3_caps = LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY,
 		data.cfg = _cfg;				\
 		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
 		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
-		tester_add(name, &data, test_setup, function,	\
+		tester_add(name, &data, setup, function,	\
 				test_teardown);			\
 	} while (0)
 
@@ -740,22 +741,25 @@ static void test_disc(void)
 	 * The IUT reads the values of the characteristics specified in the PAC
 	 * Characteristic and Location Characteristic columns.
 	 */
-	define_test("BAP/UCL/DISC/BV-01-C", test_client, NULL, DISC_SNK_LC3);
-	define_test("BAP/UCL/DISC/BV-02-C", test_client, NULL, DISC_SRC_LC3);
+	define_test("BAP/UCL/DISC/BV-01-C", test_setup, test_client, NULL,
+						DISC_SNK_LC3);
+	define_test("BAP/UCL/DISC/BV-02-C", test_setup, test_client, NULL,
+						DISC_SRC_LC3);
 
 	/* BAP/UCL/DISC/BV-06-C [Discover Available Audio Contexts]
 	 *
 	 * The IUT successfully reads the value of the Available Audio Contexts
 	 * characteristic on the LowerTester.
 	 */
-	define_test("BAP/UCL/DISC/BV-06-C", test_client, NULL, DISC_CTX_LC3);
+	define_test("BAP/UCL/DISC/BV-06-C", test_setup, test_client, NULL,
+						DISC_CTX_LC3);
 
 	/* BAP/UCL/DISC/BV-05-C [Discover Supported Audio Contexts]
 	 *
 	 * The IUT successfully reads the value of the Supported Audio Contexts
 	 * characteristic on the Lower Tester.
 	 */
-	define_test("BAP/UCL/DISC/BV-05-C", test_client, NULL,
+	define_test("BAP/UCL/DISC/BV-05-C", test_setup, test_client, NULL,
 						DISC_SUP_CTX_LC3);
 
 	/* BAP/UCL/DISC/BV-03-C [Discover Sink ASE_ID]
@@ -764,9 +768,9 @@ static void test_disc(void)
 	 * The IUT successfully reads the ASE_ID values of each discovered ASE
 	 * characteristic on the LowerTester.
 	 */
-	define_test("BAP/UCL/DISC/BV-03-C", test_client, NULL,
+	define_test("BAP/UCL/DISC/BV-03-C", test_setup, test_client, NULL,
 						DISC_SNK_ASE_LC3);
-	define_test("BAP/UCL/DISC/BV-04-C", test_client, NULL,
+	define_test("BAP/UCL/DISC/BV-04-C", test_setup, test_client, NULL,
 						DISC_SRC_ASE_LC3);
 }
 
@@ -1160,69 +1164,69 @@ static struct test_config cfg_src_48_6 = {
 static void test_scc_cc_lc3(void)
 {
 	define_test("BAP/UCL/SCC/BV-001-C [UCL SRC Config Codec, LC3 8_1]",
-			test_client, &cfg_snk_8_1, SCC_SNK_8_1);
+			test_setup, test_client, &cfg_snk_8_1, SCC_SNK_8_1);
 	define_test("BAP/UCL/SCC/BV-002-C [UCL SRC Config Codec, LC3 8_2]",
-			test_client, &cfg_snk_8_2, SCC_SNK_8_2);
+			test_setup, test_client, &cfg_snk_8_2, SCC_SNK_8_2);
 	define_test("BAP/UCL/SCC/BV-003-C [UCL SRC Config Codec, LC3 16_1]",
-			test_client, &cfg_snk_16_1, SCC_SNK_16_1);
+			test_setup, test_client, &cfg_snk_16_1, SCC_SNK_16_1);
 	define_test("BAP/UCL/SCC/BV-004-C [UCL SRC Config Codec, LC3 16_2]",
-			test_client, &cfg_snk_16_2, SCC_SNK_16_2);
+			test_setup, test_client, &cfg_snk_16_2, SCC_SNK_16_2);
 	define_test("BAP/UCL/SCC/BV-005-C [UCL SRC Config Codec, LC3 24_1]",
-			test_client, &cfg_snk_24_1, SCC_SNK_24_1);
+			test_setup, test_client, &cfg_snk_24_1, SCC_SNK_24_1);
 	define_test("BAP/UCL/SCC/BV-006-C [UCL SRC Config Codec, LC3 24_2]",
-			test_client, &cfg_snk_24_2, SCC_SNK_24_2);
+			test_setup, test_client, &cfg_snk_24_2, SCC_SNK_24_2);
 	define_test("BAP/UCL/SCC/BV-007-C [UCL SRC Config Codec, LC3 32_1]",
-			test_client, &cfg_snk_32_1, SCC_SNK_32_1);
+			test_setup, test_client, &cfg_snk_32_1, SCC_SNK_32_1);
 	define_test("BAP/UCL/SCC/BV-008-C [UCL SRC Config Codec, LC3 32_2]",
-			test_client, &cfg_snk_32_2, SCC_SNK_32_2);
+			test_setup, test_client, &cfg_snk_32_2, SCC_SNK_32_2);
 	define_test("BAP/UCL/SCC/BV-009-C [UCL SRC Config Codec, LC3 44.1_1]",
-			test_client, &cfg_snk_44_1, SCC_SNK_44_1);
+			test_setup, test_client, &cfg_snk_44_1, SCC_SNK_44_1);
 	define_test("BAP/UCL/SCC/BV-010-C [UCL SRC Config Codec, LC3 44.1_2]",
-			test_client, &cfg_snk_44_2, SCC_SNK_44_2);
+			test_setup, test_client, &cfg_snk_44_2, SCC_SNK_44_2);
 	define_test("BAP/UCL/SCC/BV-011-C [UCL SRC Config Codec, LC3 48_1]",
-			test_client, &cfg_snk_48_1, SCC_SNK_48_1);
+			test_setup, test_client, &cfg_snk_48_1, SCC_SNK_48_1);
 	define_test("BAP/UCL/SCC/BV-012-C [UCL SRC Config Codec, LC3 48_2]",
-			test_client, &cfg_snk_48_2, SCC_SNK_48_2);
+			test_setup, test_client, &cfg_snk_48_2, SCC_SNK_48_2);
 	define_test("BAP/UCL/SCC/BV-013-C [UCL SRC Config Codec, LC3 48_3]",
-			test_client, &cfg_snk_48_3, SCC_SNK_48_3);
+			test_setup, test_client, &cfg_snk_48_3, SCC_SNK_48_3);
 	define_test("BAP/UCL/SCC/BV-014-C [UCL SRC Config Codec, LC3 48_4]",
-			test_client, &cfg_snk_48_4, SCC_SNK_48_4);
+			test_setup, test_client, &cfg_snk_48_4, SCC_SNK_48_4);
 	define_test("BAP/UCL/SCC/BV-015-C [UCL SRC Config Codec, LC3 48_5]",
-			test_client, &cfg_snk_48_5, SCC_SNK_48_5);
+			test_setup, test_client, &cfg_snk_48_5, SCC_SNK_48_5);
 	define_test("BAP/UCL/SCC/BV-016-C [UCL SRC Config Codec, LC3 48_6]",
-			test_client, &cfg_snk_48_6, SCC_SNK_48_6);
+			test_setup, test_client, &cfg_snk_48_6, SCC_SNK_48_6);
 	define_test("BAP/UCL/SCC/BV-017-C [UCL SNK Config Codec, LC3 8_1]",
-			test_client, &cfg_src_8_1, SCC_SRC_8_1);
+			test_setup, test_client, &cfg_src_8_1, SCC_SRC_8_1);
 	define_test("BAP/UCL/SCC/BV-018-C [UCL SNK Config Codec, LC3 8_2]",
-			test_client, &cfg_src_8_2, SCC_SRC_8_2);
+			test_setup, test_client, &cfg_src_8_2, SCC_SRC_8_2);
 	define_test("BAP/UCL/SCC/BV-019-C [UCL SNK Config Codec, LC3 16_1]",
-			test_client, &cfg_src_16_1, SCC_SRC_16_1);
+			test_setup, test_client, &cfg_src_16_1, SCC_SRC_16_1);
 	define_test("BAP/UCL/SCC/BV-020-C [UCL SNK Config Codec, LC3 16_2]",
-			test_client, &cfg_src_16_2, SCC_SRC_16_2);
+			test_setup, test_client, &cfg_src_16_2, SCC_SRC_16_2);
 	define_test("BAP/UCL/SCC/BV-021-C [UCL SNK Config Codec, LC3 24_1]",
-			test_client, &cfg_src_24_1, SCC_SRC_24_1);
+			test_setup, test_client, &cfg_src_24_1, SCC_SRC_24_1);
 	define_test("BAP/UCL/SCC/BV-022-C [UCL SNK Config Codec, LC3 24_2]",
-			test_client, &cfg_src_24_2, SCC_SRC_24_2);
+			test_setup, test_client, &cfg_src_24_2, SCC_SRC_24_2);
 	define_test("BAP/UCL/SCC/BV-023-C [UCL SNK Config Codec, LC3 32_1]",
-			test_client, &cfg_src_32_1, SCC_SRC_32_1);
+			test_setup, test_client, &cfg_src_32_1, SCC_SRC_32_1);
 	define_test("BAP/UCL/SCC/BV-024-C [UCL SNK Config Codec, LC3 32_2]",
-			test_client, &cfg_src_32_2, SCC_SRC_32_2);
+			test_setup, test_client, &cfg_src_32_2, SCC_SRC_32_2);
 	define_test("BAP/UCL/SCC/BV-025-C [UCL SNK Config Codec, LC3 44.1_1]",
-			test_client, &cfg_src_44_1, SCC_SRC_44_1);
+			test_setup, test_client, &cfg_src_44_1, SCC_SRC_44_1);
 	define_test("BAP/UCL/SCC/BV-026-C [UCL SNK Config Codec, LC3 44.1_2]",
-			test_client, &cfg_src_44_2, SCC_SRC_44_2);
+			test_setup, test_client, &cfg_src_44_2, SCC_SRC_44_2);
 	define_test("BAP/UCL/SCC/BV-027-C [UCL SNK Config Codec, LC3 48_1]",
-			test_client, &cfg_src_48_1, SCC_SRC_48_1);
+			test_setup, test_client, &cfg_src_48_1, SCC_SRC_48_1);
 	define_test("BAP/UCL/SCC/BV-028-C [UCL SNK Config Codec, LC3 48_2]",
-			test_client, &cfg_src_48_2, SCC_SRC_48_2);
+			test_setup, test_client, &cfg_src_48_2, SCC_SRC_48_2);
 	define_test("BAP/UCL/SCC/BV-029-C [UCL SNK Config Codec, LC3 48_3]",
-			test_client, &cfg_src_48_3, SCC_SRC_48_3);
+			test_setup, test_client, &cfg_src_48_3, SCC_SRC_48_3);
 	define_test("BAP/UCL/SCC/BV-030-C [UCL SNK Config Codec, LC3 48_4]",
-			test_client, &cfg_src_48_4, SCC_SRC_48_4);
+			test_setup, test_client, &cfg_src_48_4, SCC_SRC_48_4);
 	define_test("BAP/UCL/SCC/BV-031-C [UCL SNK Config Codec, LC3 48_5]",
-			test_client, &cfg_src_48_5, SCC_SRC_48_5);
+			test_setup, test_client, &cfg_src_48_5, SCC_SRC_48_5);
 	define_test("BAP/UCL/SCC/BV-032-C [UCL SNK Config Codec, LC3 48_6]",
-			test_client, &cfg_src_48_6, SCC_SRC_48_6);
+			test_setup, test_client, &cfg_src_48_6, SCC_SRC_48_6);
 }
 
 static struct test_config cfg_snk_vs = {
@@ -1263,9 +1267,9 @@ static struct test_config cfg_src_vs = {
 static void test_scc_cc_vs(void)
 {
 	define_test("BAP/UCL/SCC/BV-033-C [UCL SRC Config Codec, VS]",
-			test_client, &cfg_snk_vs, SCC_SNK_VS);
+			test_setup, test_client, &cfg_snk_vs, SCC_SNK_VS);
 	define_test("BAP/UCL/SCC/BV-034-C [UCL SNK Config Codec, VS]",
-			test_client, &cfg_src_vs, SCC_SRC_VS);
+			test_setup, test_client, &cfg_src_vs, SCC_SRC_VS);
 }
 
 static struct test_config cfg_snk_8_1_1 = {
@@ -2079,133 +2083,197 @@ static struct test_config cfg_src_48_6_2 = {
 static void test_scc_qos_lc3(void)
 {
 	define_test("BAP/UCL/SCC/BV-035-C [UCL SRC Config QoS, LC3 8_1_1]",
-			test_client, &cfg_snk_8_1_1, SCC_SNK_8_1_1);
+			test_setup, test_client, &cfg_snk_8_1_1,
+			SCC_SNK_8_1_1);
 	define_test("BAP/UCL/SCC/BV-036-C [UCL SRC Config QoS, LC3 8_2_1]",
-			test_client, &cfg_snk_8_2_1, SCC_SNK_8_2_1);
+			test_setup, test_client, &cfg_snk_8_2_1,
+			SCC_SNK_8_2_1);
 	define_test("BAP/UCL/SCC/BV-037-C [UCL SRC Config QoS, LC3 16_1_1]",
-			test_client, &cfg_snk_16_1_1, SCC_SNK_16_1_1);
+			test_setup, test_client, &cfg_snk_16_1_1,
+			SCC_SNK_16_1_1);
 	define_test("BAP/UCL/SCC/BV-038-C [UCL SRC Config QoS, LC3 16_2_1]",
-			test_client, &cfg_snk_16_2_1, SCC_SNK_16_2_1);
+			test_setup, test_client, &cfg_snk_16_2_1,
+			SCC_SNK_16_2_1);
 	define_test("BAP/UCL/SCC/BV-039-C [UCL SRC Config QoS, LC3 24_1_1]",
-			test_client, &cfg_snk_24_1_1, SCC_SNK_24_1_1);
+			test_setup, test_client, &cfg_snk_24_1_1,
+			SCC_SNK_24_1_1);
 	define_test("BAP/UCL/SCC/BV-040-C [UCL SRC Config QoS, LC3 24_2_1]",
-			test_client, &cfg_snk_24_2_1, SCC_SNK_24_2_1);
+			test_setup, test_client, &cfg_snk_24_2_1,
+			SCC_SNK_24_2_1);
 	define_test("BAP/UCL/SCC/BV-041-C [UCL SRC Config QoS, LC3 32_1_1]",
-			test_client, &cfg_snk_32_1_1, SCC_SNK_32_1_1);
+			test_setup, test_client, &cfg_snk_32_1_1,
+			SCC_SNK_32_1_1);
 	define_test("BAP/UCL/SCC/BV-042-C [UCL SRC Config QoS, LC3 32_2_1]",
-			test_client, &cfg_snk_32_2_1, SCC_SNK_32_2_1);
+			test_setup, test_client, &cfg_snk_32_2_1,
+			SCC_SNK_32_2_1);
 	define_test("BAP/UCL/SCC/BV-043-C [UCL SRC Config QoS, LC3 44.1_1_1]",
-			test_client, &cfg_snk_44_1_1, SCC_SNK_44_1_1);
+			test_setup, test_client, &cfg_snk_44_1_1,
+			SCC_SNK_44_1_1);
 	define_test("BAP/UCL/SCC/BV-044-C [UCL SRC Config QoS, LC3 44.1_2_1]",
-			test_client, &cfg_snk_44_2_1, SCC_SNK_44_2_1);
+			test_setup, test_client, &cfg_snk_44_2_1,
+			SCC_SNK_44_2_1);
 	define_test("BAP/UCL/SCC/BV-045-C [UCL SRC Config QoS, LC3 48_1_1]",
-			test_client, &cfg_snk_48_1_1, SCC_SNK_48_1_1);
+			test_setup, test_client, &cfg_snk_48_1_1,
+			SCC_SNK_48_1_1);
 	define_test("BAP/UCL/SCC/BV-046-C [UCL SRC Config QoS, LC3 48_2_1]",
-			test_client, &cfg_snk_48_2_1, SCC_SNK_48_2_1);
+			test_setup, test_client, &cfg_snk_48_2_1,
+			SCC_SNK_48_2_1);
 	define_test("BAP/UCL/SCC/BV-047-C [UCL SRC Config QoS, LC3 48_3_1]",
-			test_client, &cfg_snk_48_3_1, SCC_SNK_48_3_1);
+			test_setup, test_client, &cfg_snk_48_3_1,
+			SCC_SNK_48_3_1);
 	define_test("BAP/UCL/SCC/BV-048-C [UCL SRC Config QoS, LC3 48_4_1]",
-			test_client, &cfg_snk_48_4_1, SCC_SNK_48_4_1);
+			test_setup, test_client, &cfg_snk_48_4_1,
+			SCC_SNK_48_4_1);
 	define_test("BAP/UCL/SCC/BV-049-C [UCL SRC Config QoS, LC3 48_5_1]",
-			test_client, &cfg_snk_48_5_1, SCC_SNK_48_5_1);
+			test_setup, test_client, &cfg_snk_48_5_1,
+			SCC_SNK_48_5_1);
 	define_test("BAP/UCL/SCC/BV-050-C [UCL SRC Config QoS, LC3 48_6_1]",
-			test_client, &cfg_snk_48_6_1, SCC_SNK_48_6_1);
+			test_setup, test_client, &cfg_snk_48_6_1,
+			SCC_SNK_48_6_1);
 	define_test("BAP/UCL/SCC/BV-051-C [UCL SNK Config QoS, LC3 8_1_1]",
-			test_client, &cfg_src_8_1_1, SCC_SRC_8_1_1);
+			test_setup, test_client, &cfg_src_8_1_1,
+			SCC_SRC_8_1_1);
 	define_test("BAP/UCL/SCC/BV-052-C [UCL SNK Config QoS, LC3 8_2_1]",
-			test_client, &cfg_src_8_2_1, SCC_SRC_8_2_1);
+			test_setup, test_client, &cfg_src_8_2_1,
+			SCC_SRC_8_2_1);
 	define_test("BAP/UCL/SCC/BV-053-C [UCL SNK Config QoS, LC3 16_1_1]",
-			test_client, &cfg_src_16_1_1, SCC_SRC_16_1_1);
+			test_setup, test_client, &cfg_src_16_1_1,
+			SCC_SRC_16_1_1);
 	define_test("BAP/UCL/SCC/BV-054-C [UCL SNK Config QoS, LC3 16_2_1]",
-			test_client, &cfg_src_16_2_1, SCC_SRC_16_2_1);
+			test_setup, test_client, &cfg_src_16_2_1,
+			SCC_SRC_16_2_1);
 	define_test("BAP/UCL/SCC/BV-055-C [UCL SNK Config QoS, LC3 24_1_1]",
-			test_client, &cfg_src_24_1_1, SCC_SRC_24_1_1);
+			test_setup, test_client, &cfg_src_24_1_1,
+			SCC_SRC_24_1_1);
 	define_test("BAP/UCL/SCC/BV-056-C [UCL SNK Config QoS, LC3 24_2_1]",
-			test_client, &cfg_src_24_2_1, SCC_SRC_24_2_1);
+			test_setup, test_client, &cfg_src_24_2_1,
+			SCC_SRC_24_2_1);
 	define_test("BAP/UCL/SCC/BV-057-C [UCL SNK Config QoS, LC3 32_1_1]",
-			test_client, &cfg_src_32_1_1, SCC_SRC_32_1_1);
+			test_setup, test_client, &cfg_src_32_1_1,
+			SCC_SRC_32_1_1);
 	define_test("BAP/UCL/SCC/BV-058-C [UCL SNK Config QoS, LC3 32_2_1]",
-			test_client, &cfg_src_32_2_1, SCC_SRC_32_2_1);
+			test_setup, test_client, &cfg_src_32_2_1,
+			SCC_SRC_32_2_1);
 	define_test("BAP/UCL/SCC/BV-059-C [UCL SNK Config QoS, LC3 44.1_1_1]",
-			test_client, &cfg_src_44_1_1, SCC_SRC_44_1_1);
+			test_setup, test_client, &cfg_src_44_1_1,
+			SCC_SRC_44_1_1);
 	define_test("BAP/UCL/SCC/BV-060-C [UCL SNK Config QoS, LC3 44.1_2_1]",
-			test_client, &cfg_src_44_2_1, SCC_SRC_44_2_1);
+			test_setup, test_client, &cfg_src_44_2_1,
+			SCC_SRC_44_2_1);
 	define_test("BAP/UCL/SCC/BV-061-C [UCL SNK Config QoS, LC3 48_1_1]",
-			test_client, &cfg_src_48_1_1, SCC_SRC_48_1_1);
+			test_setup, test_client, &cfg_src_48_1_1,
+			SCC_SRC_48_1_1);
 	define_test("BAP/UCL/SCC/BV-062-C [UCL SNK Config QoS, LC3 48_2_1]",
-			test_client, &cfg_src_48_2_1, SCC_SRC_48_2_1);
+			test_setup, test_client, &cfg_src_48_2_1,
+			SCC_SRC_48_2_1);
 	define_test("BAP/UCL/SCC/BV-063-C [UCL SNK Config QoS, LC3 48_3_1]",
-			test_client, &cfg_src_48_3_1, SCC_SRC_48_3_1);
+			test_setup, test_client, &cfg_src_48_3_1,
+			SCC_SRC_48_3_1);
 	define_test("BAP/UCL/SCC/BV-064-C [UCL SNK Config QoS, LC3 48_4_1]",
-			test_client, &cfg_src_48_4_1, SCC_SRC_48_4_1);
+			test_setup, test_client, &cfg_src_48_4_1,
+			SCC_SRC_48_4_1);
 	define_test("BAP/UCL/SCC/BV-065-C [UCL SNK Config QoS, LC3 48_5_1]",
-			test_client, &cfg_src_48_5_1, SCC_SRC_48_5_1);
+			test_setup, test_client, &cfg_src_48_5_1,
+			SCC_SRC_48_5_1);
 	define_test("BAP/UCL/SCC/BV-066-C [UCL SNK Config QoS, LC3 48_6_1]",
-			test_client, &cfg_src_48_6_1, SCC_SRC_48_6_1);
+			test_setup, test_client, &cfg_src_48_6_1,
+			SCC_SRC_48_6_1);
 	define_test("BAP/UCL/SCC/BV-067-C [UCL SRC Config QoS, LC3 8_1_2]",
-			test_client, &cfg_snk_8_1_2, SCC_SNK_8_1_2);
+			test_setup, test_client, &cfg_snk_8_1_2,
+			SCC_SNK_8_1_2);
 	define_test("BAP/UCL/SCC/BV-068-C [UCL SRC Config QoS, LC3 8_2_2]",
-			test_client, &cfg_snk_8_2_2, SCC_SNK_8_2_2);
+			test_setup, test_client, &cfg_snk_8_2_2,
+			SCC_SNK_8_2_2);
 	define_test("BAP/UCL/SCC/BV-069-C [UCL SRC Config QoS, LC3 16_1_2]",
-			test_client, &cfg_snk_16_1_2, SCC_SNK_16_1_2);
+			test_setup, test_client, &cfg_snk_16_1_2,
+			SCC_SNK_16_1_2);
 	define_test("BAP/UCL/SCC/BV-070-C [UCL SRC Config QoS, LC3 16_2_2]",
-			test_client, &cfg_snk_16_2_2, SCC_SNK_16_2_2);
+			test_setup, test_client, &cfg_snk_16_2_2,
+			SCC_SNK_16_2_2);
 	define_test("BAP/UCL/SCC/BV-071-C [UCL SRC Config QoS, LC3 24_1_2]",
-			test_client, &cfg_snk_24_1_2, SCC_SNK_24_1_2);
+			test_setup, test_client, &cfg_snk_24_1_2,
+			SCC_SNK_24_1_2);
 	define_test("BAP/UCL/SCC/BV-072-C [UCL SRC Config QoS, LC3 24_2_2]",
-			test_client, &cfg_snk_24_2_2, SCC_SNK_24_2_2);
+			test_setup, test_client, &cfg_snk_24_2_2,
+			SCC_SNK_24_2_2);
 	define_test("BAP/UCL/SCC/BV-073-C [UCL SRC Config QoS, LC3 32_1_2]",
-			test_client, &cfg_snk_32_1_2, SCC_SNK_32_1_2);
+			test_setup, test_client, &cfg_snk_32_1_2,
+			SCC_SNK_32_1_2);
 	define_test("BAP/UCL/SCC/BV-074-C [UCL SRC Config QoS, LC3 32_2_2]",
-			test_client, &cfg_snk_32_2_2, SCC_SNK_32_2_2);
+			test_setup, test_client, &cfg_snk_32_2_2,
+			SCC_SNK_32_2_2);
 	define_test("BAP/UCL/SCC/BV-075-C [UCL SRC Config QoS, LC3 44.1_1_2]",
-			test_client, &cfg_snk_44_1_2, SCC_SNK_44_1_2);
+			test_setup, test_client, &cfg_snk_44_1_2,
+			SCC_SNK_44_1_2);
 	define_test("BAP/UCL/SCC/BV-076-C [UCL SRC Config QoS, LC3 44.1_2_2]",
-			test_client, &cfg_snk_44_2_2, SCC_SNK_44_2_2);
+			test_setup, test_client, &cfg_snk_44_2_2,
+			SCC_SNK_44_2_2);
 	define_test("BAP/UCL/SCC/BV-077-C [UCL SRC Config QoS, LC3 48_1_2]",
-			test_client, &cfg_snk_48_1_2, SCC_SNK_48_1_2);
+			test_setup, test_client, &cfg_snk_48_1_2,
+			SCC_SNK_48_1_2);
 	define_test("BAP/UCL/SCC/BV-078-C [UCL SRC Config QoS, LC3 48_2_2]",
-			test_client, &cfg_snk_48_2_2, SCC_SNK_48_2_2);
+			test_setup, test_client, &cfg_snk_48_2_2,
+			SCC_SNK_48_2_2);
 	define_test("BAP/UCL/SCC/BV-079-C [UCL SRC Config QoS, LC3 48_3_2]",
-			test_client, &cfg_snk_48_3_2, SCC_SNK_48_3_2);
+			test_setup, test_client, &cfg_snk_48_3_2,
+			SCC_SNK_48_3_2);
 	define_test("BAP/UCL/SCC/BV-080-C [UCL SRC Config QoS, LC3 48_4_2]",
-			test_client, &cfg_snk_48_4_2, SCC_SNK_48_4_2);
+			test_setup, test_client, &cfg_snk_48_4_2,
+			SCC_SNK_48_4_2);
 	define_test("BAP/UCL/SCC/BV-081-C [UCL SRC Config QoS, LC3 48_5_2]",
-			test_client, &cfg_snk_48_5_2, SCC_SNK_48_5_2);
+			test_setup, test_client, &cfg_snk_48_5_2,
+			SCC_SNK_48_5_2);
 	define_test("BAP/UCL/SCC/BV-082-C [UCL SRC Config QoS, LC3 48_6_2]",
-			test_client, &cfg_snk_48_6_2, SCC_SNK_48_6_2);
+			test_setup, test_client, &cfg_snk_48_6_2,
+			SCC_SNK_48_6_2);
 	define_test("BAP/UCL/SCC/BV-083-C [UCL SNK Config QoS, LC3 8_1_2]",
-			test_client, &cfg_src_8_1_2, SCC_SRC_8_1_2);
+			test_setup, test_client, &cfg_src_8_1_2,
+			SCC_SRC_8_1_2);
 	define_test("BAP/UCL/SCC/BV-084-C [UCL SNK Config QoS, LC3 8_2_2]",
-			test_client, &cfg_src_8_2_2, SCC_SRC_8_2_2);
+			test_setup, test_client, &cfg_src_8_2_2,
+			SCC_SRC_8_2_2);
 	define_test("BAP/UCL/SCC/BV-085-C [UCL SNK Config QoS, LC3 16_1_2]",
-			test_client, &cfg_src_16_1_2, SCC_SRC_16_1_2);
+			test_setup, test_client, &cfg_src_16_1_2,
+			SCC_SRC_16_1_2);
 	define_test("BAP/UCL/SCC/BV-086-C [UCL SNK Config QoS, LC3 16_2_2]",
-			test_client, &cfg_src_16_2_2, SCC_SRC_16_2_2);
+			test_setup, test_client, &cfg_src_16_2_2,
+			SCC_SRC_16_2_2);
 	define_test("BAP/UCL/SCC/BV-087-C [UCL SNK Config QoS, LC3 24_1_2]",
-			test_client, &cfg_src_24_1_2, SCC_SRC_24_1_2);
+			test_setup, test_client, &cfg_src_24_1_2,
+			SCC_SRC_24_1_2);
 	define_test("BAP/UCL/SCC/BV-088-C [UCL SNK Config QoS, LC3 24_2_2]",
-			test_client, &cfg_src_24_2_2, SCC_SRC_24_2_2);
+			test_setup, test_client, &cfg_src_24_2_2,
+			SCC_SRC_24_2_2);
 	define_test("BAP/UCL/SCC/BV-089-C [UCL SNK Config QoS, LC3 32_1_2]",
-			test_client, &cfg_src_32_1_2, SCC_SRC_32_1_2);
+			test_setup, test_client, &cfg_src_32_1_2,
+			SCC_SRC_32_1_2);
 	define_test("BAP/UCL/SCC/BV-090-C [UCL SNK Config QoS, LC3 32_2_2]",
-			test_client, &cfg_src_32_2_2, SCC_SRC_32_2_2);
+			test_setup, test_client, &cfg_src_32_2_2,
+			SCC_SRC_32_2_2);
 	define_test("BAP/UCL/SCC/BV-091-C [UCL SNK Config QoS, LC3 44.1_1_2]",
-			test_client, &cfg_src_44_1_2, SCC_SRC_44_1_2);
+			test_setup, test_client, &cfg_src_44_1_2,
+			SCC_SRC_44_1_2);
 	define_test("BAP/UCL/SCC/BV-092-C [UCL SNK Config QoS, LC3 44.1_2_2]",
-			test_client, &cfg_src_44_2_2, SCC_SRC_44_2_2);
+			test_setup, test_client, &cfg_src_44_2_2,
+			SCC_SRC_44_2_2);
 	define_test("BAP/UCL/SCC/BV-093-C [UCL SNK Config QoS, LC3 48_1_2]",
-			test_client, &cfg_src_48_1_2, SCC_SRC_48_1_2);
+			test_setup, test_client, &cfg_src_48_1_2,
+			SCC_SRC_48_1_2);
 	define_test("BAP/UCL/SCC/BV-094-C [UCL SNK Config QoS, LC3 48_2_2]",
-			test_client, &cfg_src_48_2_2, SCC_SRC_48_2_2);
+			test_setup, test_client, &cfg_src_48_2_2,
+			SCC_SRC_48_2_2);
 	define_test("BAP/UCL/SCC/BV-095-C [UCL SNK Config QoS, LC3 48_3_2]",
-			test_client, &cfg_src_48_3_2, SCC_SRC_48_3_2);
+			test_setup, test_client, &cfg_src_48_3_2,
+			SCC_SRC_48_3_2);
 	define_test("BAP/UCL/SCC/BV-096-C [UCL SNK Config QoS, LC3 48_4_2]",
-			test_client, &cfg_src_48_4_2, SCC_SRC_48_4_2);
+			test_setup, test_client, &cfg_src_48_4_2,
+			SCC_SRC_48_4_2);
 	define_test("BAP/UCL/SCC/BV-097-C [UCL SNK Config QoS, LC3 48_5_2]",
-			test_client, &cfg_src_48_5_2, SCC_SRC_48_5_2);
+			test_setup, test_client, &cfg_src_48_5_2,
+			SCC_SRC_48_5_2);
 	define_test("BAP/UCL/SCC/BV-098-C [UCL SNK Config QoS, LC3 48_6_2]",
-			test_client, &cfg_src_48_6_2, SCC_SRC_48_6_2);
+			test_setup, test_client, &cfg_src_48_6_2,
+			SCC_SRC_48_6_2);
 }
 
 static struct test_config cfg_snk_qos_vs = {
@@ -2245,9 +2313,11 @@ static struct test_config cfg_src_qos_vs = {
 static void test_scc_qos_vs(void)
 {
 	define_test("BAP/UCL/SCC/BV-099-C [UCL SNK Config QoS, VS]",
-			test_client, &cfg_src_qos_vs, SCC_SRC_QOS_VS);
+			test_setup, test_client, &cfg_src_qos_vs,
+			SCC_SRC_QOS_VS);
 	define_test("BAP/UCL/SCC/BV-100-C [UCL SRC QoS Codec, VS]",
-			test_client, &cfg_snk_qos_vs, SCC_SNK_QOS_VS);
+			test_setup, test_client, &cfg_snk_qos_vs,
+			SCC_SNK_QOS_VS);
 }
 
 static struct test_config cfg_snk_enable = {
@@ -2317,9 +2387,11 @@ static struct test_config cfg_src_enable = {
 static void test_scc_enable(void)
 {
 	define_test("BAP/UCL/SCC/BV-101-C [UCL SRC Enable]",
-			test_client, &cfg_snk_enable, SCC_SNK_ENABLE);
+			test_setup, test_client, &cfg_snk_enable,
+			SCC_SNK_ENABLE);
 	define_test("BAP/UCL/SCC/BV-102-C [UCL SNK Enable]",
-			test_client, &cfg_src_enable, SCC_SRC_ENABLE);
+			test_setup, test_client, &cfg_src_enable,
+			SCC_SRC_ENABLE);
 }
 
 static struct test_config cfg_snk_disable = {
@@ -2436,12 +2508,14 @@ static struct test_config cfg_src_disable_streaming = {
 static void test_scc_disable(void)
 {
 	define_test("BAP/UCL/SCC/BV-103-C [UCL SNK Disable in Enabling State]",
-			test_client, &cfg_src_disable, SCC_SRC_DISABLE);
+			test_setup, test_client, &cfg_src_disable,
+			SCC_SRC_DISABLE);
 	define_test("BAP/UCL/SCC/BV-104-C [UCL SRC Disable in Enabling or "
 			"Streaming state]",
-			test_client, &cfg_snk_disable, SCC_SNK_DISABLE);
+			test_setup, test_client, &cfg_snk_disable,
+			SCC_SNK_DISABLE);
 	define_test("BAP/UCL/SCC/BV-105-C [UCL SNK Disable in Streaming State]",
-			test_client, &cfg_src_disable_streaming,
+			test_setup, test_client, &cfg_src_disable_streaming,
 			SCC_SRC_DISABLE_STREAMING);
 }
 
@@ -2667,28 +2741,32 @@ static void test_scc_release(void)
 {
 	define_test("BAP/UCL/SCC/BV-106-C [UCL SNK Release in Codec Configured"
 			" state]",
-			test_client, &cfg_src_cc_release, SCC_SRC_CC_RELEASE);
+			test_setup, test_client, &cfg_src_cc_release,
+			SCC_SRC_CC_RELEASE);
 	define_test("BAP/UCL/SCC/BV-107-C [UCL SRC Release in Codec Configured"
 			" state]",
-			test_client, &cfg_snk_cc_release, SCC_SNK_CC_RELEASE);
+			test_setup, test_client, &cfg_snk_cc_release,
+			SCC_SNK_CC_RELEASE);
 	define_test("BAP/UCL/SCC/BV-108-C [UCL SNK Release in QoS Configured"
 			" state]",
-			test_client, &cfg_src_qos_release, SCC_SRC_QOS_RELEASE);
+			test_setup, test_client, &cfg_src_qos_release,
+			SCC_SRC_QOS_RELEASE);
 	define_test("BAP/UCL/SCC/BV-109-C [UCL SRC Release in QoS Configured"
 			" state]",
-			test_client, &cfg_snk_qos_release, SCC_SNK_QOS_RELEASE);
+			test_setup, test_client, &cfg_snk_qos_release,
+			SCC_SNK_QOS_RELEASE);
 	define_test("BAP/UCL/SCC/BV-110-C [UCL SNK Release in Enabling state]",
-			test_client, &cfg_src_enable_release,
+			test_setup, test_client, &cfg_src_enable_release,
 			SCC_SRC_ENABLE_RELEASE);
 	define_test("BAP/UCL/SCC/BV-111-C [UCL SRC Release in Enabling or"
 			" Streaming state]",
-			test_client, &cfg_snk_enable_release,
+			test_setup, test_client, &cfg_snk_enable_release,
 			SCC_SNK_ENABLE_RELEASE);
 	define_test("BAP/UCL/SCC/BV-112-C [UCL SNK Release in Streaming state]",
-			test_client, &cfg_src_start_release,
+			test_setup, test_client, &cfg_src_start_release,
 			SCC_SRC_START_RELEASE);
 	define_test("BAP/UCL/SCC/BV-113-C [UCL SNK Release in Disabling state]",
-			test_client, &cfg_src_disable_release,
+			test_setup, test_client, &cfg_src_disable_release,
 			SCC_SRC_DISABLE_RELEASE);
 }
 
@@ -2820,13 +2898,15 @@ static void test_scc_metadata(void)
 {
 	define_test("BAP/UCL/SCC/BV-115-C [UCL SNK Update Metadata in Enabling "
 			"State]",
-			test_client, &cfg_src_metadata, SCC_SRC_METADATA);
+			test_setup, test_client, &cfg_src_metadata,
+			SCC_SRC_METADATA);
 	define_test("BAP/UCL/SCC/BV-116-C [UCL SRC Update Metadata in Enabling "
 			"or Streaming state]",
-			test_client, &cfg_snk_metadata, SCC_SNK_METADATA);
+			test_setup, test_client, &cfg_snk_metadata,
+			SCC_SNK_METADATA);
 	define_test("BAP/UCL/SCC/BV-117-C [UCL SNK Update Metadata in Streaming"
 			" State]",
-			test_client, &cfg_src_metadata_streaming,
+			test_setup, test_client, &cfg_src_metadata_streaming,
 			SCC_SRC_METADATA_STREAMING);
 }
 
@@ -4903,388 +4983,388 @@ static struct test_config str_src_ac4_48_6_2 = {
 static void test_str_1_1_1_lc3(void)
 {
 	define_test("BAP/UCL/STR/BV-001-C [UCL, AC 2, LC3 8_1_1]",
-			test_client, &str_snk_ac2_8_1_1,
+			test_setup, test_client, &str_snk_ac2_8_1_1,
 			STR_SNK_AC2_8_1_1);
 	define_test("BAP/UCL/STR/BV-002-C [UCL, AC 10, LC3 8_1_1]",
-			test_client, &str_snk_ac10_8_1_1,
+			test_setup, test_client, &str_snk_ac10_8_1_1,
 			STR_SNK_AC10_8_1_1);
 	define_test("BAP/UCL/STR/BV-003-C [UCL, AC 2, LC3 8_2_1]",
-			test_client, &str_snk_ac2_8_2_1,
+			test_setup, test_client, &str_snk_ac2_8_2_1,
 			STR_SNK_AC2_8_2_1);
 	define_test("BAP/UCL/STR/BV-004-C [UCL, AC 10, LC3 8_2_1]",
-			test_client, &str_snk_ac10_8_2_1,
+			test_setup, test_client, &str_snk_ac10_8_2_1,
 			STR_SNK_AC10_8_2_1);
 	define_test("BAP/UCL/STR/BV-005-C [UCL, AC 2, LC3 16_1_1]",
-			test_client, &str_snk_ac2_16_1_1,
+			test_setup, test_client, &str_snk_ac2_16_1_1,
 			STR_SNK_AC2_16_1_1);
 	define_test("BAP/UCL/STR/BV-006-C [UCL, AC 10, LC3 16_1_1]",
-			test_client, &str_snk_ac10_16_1_1,
+			test_setup, test_client, &str_snk_ac10_16_1_1,
 			STR_SNK_AC10_16_1_1);
 	define_test("BAP/UCL/STR/BV-007-C [UCL, AC 2, LC3 16_2_1]",
-			test_client, &str_snk_ac2_16_2_1,
+			test_setup, test_client, &str_snk_ac2_16_2_1,
 			STR_SNK_AC2_16_2_1);
 	define_test("BAP/UCL/STR/BV-008-C [UCL, AC 10, LC3 16_2_1]",
-			test_client, &str_snk_ac10_16_2_1,
+			test_setup, test_client, &str_snk_ac10_16_2_1,
 			STR_SNK_AC10_16_2_1);
 	define_test("BAP/UCL/STR/BV-009-C [UCL, AC 2, LC3 24_1_1]",
-			test_client, &str_snk_ac2_24_1_1,
+			test_setup, test_client, &str_snk_ac2_24_1_1,
 			STR_SNK_AC2_24_1_1);
 	define_test("BAP/UCL/STR/BV-010-C [UCL, AC 10, LC3 24_1_1]",
-			test_client, &str_snk_ac10_24_1_1,
+			test_setup, test_client, &str_snk_ac10_24_1_1,
 			STR_SNK_AC10_24_1_1);
 	define_test("BAP/UCL/STR/BV-011-C [UCL, AC 2, LC3 24_2_1]",
-			test_client, &str_snk_ac2_24_2_1,
+			test_setup, test_client, &str_snk_ac2_24_2_1,
 			STR_SNK_AC2_24_2_1);
 	define_test("BAP/UCL/STR/BV-012-C [UCL, AC 10, LC3 24_2_1]",
-			test_client, &str_snk_ac10_24_2_1,
+			test_setup, test_client, &str_snk_ac10_24_2_1,
 			STR_SNK_AC10_24_2_1);
 	define_test("BAP/UCL/STR/BV-013-C [UCL, AC 2, LC3 32_1_1]",
-			test_client, &str_snk_ac2_32_1_1,
+			test_setup, test_client, &str_snk_ac2_32_1_1,
 			STR_SNK_AC2_32_1_1);
 	define_test("BAP/UCL/STR/BV-014-C [UCL, AC 10, LC3 32_1_1]",
-			test_client, &str_snk_ac10_32_1_1,
+			test_setup, test_client, &str_snk_ac10_32_1_1,
 			STR_SNK_AC10_32_1_1);
 	define_test("BAP/UCL/STR/BV-015-C [UCL, AC 2, LC3 32_2_1]",
-			test_client, &str_snk_ac2_32_2_1,
+			test_setup, test_client, &str_snk_ac2_32_2_1,
 			STR_SNK_AC2_32_2_1);
 	define_test("BAP/UCL/STR/BV-016-C [UCL, AC 10, LC3 32_2_1]",
-			test_client, &str_snk_ac10_32_2_1,
+			test_setup, test_client, &str_snk_ac10_32_2_1,
 			STR_SNK_AC10_32_2_1);
 	define_test("BAP/UCL/STR/BV-017-C [UCL, AC 2, LC3 441_1_1]",
-			test_client, &str_snk_ac2_44_1_1,
+			test_setup, test_client, &str_snk_ac2_44_1_1,
 			STR_SNK_AC2_44_1_1);
 	define_test("BAP/UCL/STR/BV-018-C [UCL, AC 10, LC3 441_1_1]",
-			test_client, &str_snk_ac10_44_1_1,
+			test_setup, test_client, &str_snk_ac10_44_1_1,
 			STR_SNK_AC10_44_1_1);
 	define_test("BAP/UCL/STR/BV-019-C [UCL, AC 2, LC3 44_2_1]",
-			test_client, &str_snk_ac2_44_2_1,
+			test_setup, test_client, &str_snk_ac2_44_2_1,
 			STR_SNK_AC2_44_2_1);
 	define_test("BAP/UCL/STR/BV-020-C [UCL, AC 10, LC3 44_2_1]",
-			test_client, &str_snk_ac10_44_2_1,
+			test_setup, test_client, &str_snk_ac10_44_2_1,
 			STR_SNK_AC10_44_2_1);
 	define_test("BAP/UCL/STR/BV-021-C [UCL, AC 2, LC3 48_1_1]",
-			test_client, &str_snk_ac2_48_1_1,
+			test_setup, test_client, &str_snk_ac2_48_1_1,
 			STR_SNK_AC2_48_1_1);
 	define_test("BAP/UCL/STR/BV-022-C [UCL, AC 10, LC3 48_1_1]",
-			test_client, &str_snk_ac10_48_1_1,
+			test_setup, test_client, &str_snk_ac10_48_1_1,
 			STR_SNK_AC10_48_1_1);
 	define_test("BAP/UCL/STR/BV-023-C [UCL, AC 2, LC3 48_2_1]",
-			test_client, &str_snk_ac2_48_2_1,
+			test_setup, test_client, &str_snk_ac2_48_2_1,
 			STR_SNK_AC2_48_2_1);
 	define_test("BAP/UCL/STR/BV-024-C [UCL, AC 10, LC3 48_2_1]",
-			test_client, &str_snk_ac10_48_2_1,
+			test_setup, test_client, &str_snk_ac10_48_2_1,
 			STR_SNK_AC10_48_2_1);
 	define_test("BAP/UCL/STR/BV-025-C [UCL, AC 2, LC3 48_3_1]",
-			test_client, &str_snk_ac2_48_3_1,
+			test_setup, test_client, &str_snk_ac2_48_3_1,
 			STR_SNK_AC2_48_3_1);
 	define_test("BAP/UCL/STR/BV-026-C [UCL, AC 10, LC3 48_3_1]",
-			test_client, &str_snk_ac10_48_3_1,
+			test_setup, test_client, &str_snk_ac10_48_3_1,
 			STR_SNK_AC10_48_3_1);
 	define_test("BAP/UCL/STR/BV-027-C [UCL, AC 2, LC3 48_4_1]",
-			test_client, &str_snk_ac2_48_4_1,
+			test_setup, test_client, &str_snk_ac2_48_4_1,
 			STR_SNK_AC2_48_4_1);
 	define_test("BAP/UCL/STR/BV-028-C [UCL, AC 10, LC3 48_4_1]",
-			test_client, &str_snk_ac10_48_4_1,
+			test_setup, test_client, &str_snk_ac10_48_4_1,
 			STR_SNK_AC10_48_4_1);
 	define_test("BAP/UCL/STR/BV-029-C [UCL, AC 2, LC3 48_5_1]",
-			test_client, &str_snk_ac2_48_5_1,
+			test_setup, test_client, &str_snk_ac2_48_5_1,
 			STR_SNK_AC2_48_5_1);
 	define_test("BAP/UCL/STR/BV-030-C [UCL, AC 10, LC3 48_5_1]",
-			test_client, &str_snk_ac10_48_5_1,
+			test_setup, test_client, &str_snk_ac10_48_5_1,
 			STR_SNK_AC10_48_5_1);
 	define_test("BAP/UCL/STR/BV-031-C [UCL, AC 2, LC3 48_6_1]",
-			test_client, &str_snk_ac2_48_6_1,
+			test_setup, test_client, &str_snk_ac2_48_6_1,
 			STR_SNK_AC2_48_6_1);
 	define_test("BAP/UCL/STR/BV-032-C [UCL, AC 10, LC3 48_6_1]",
-			test_client, &str_snk_ac10_48_6_1,
+			test_setup, test_client, &str_snk_ac10_48_6_1,
 			STR_SNK_AC10_48_6_1);
 	define_test("BAP/UCL/STR/BV-033-C [UCL, SRC, AC 1, LC3 8_1_1]",
-			test_client, &str_src_ac1_8_1_1,
+			test_setup, test_client, &str_src_ac1_8_1_1,
 			STR_SRC_AC1_8_1_1);
 	define_test("BAP/UCL/STR/BV-034-C [UCL, SRC, AC 4, LC3 8_1_1]",
-			test_client, &str_src_ac4_8_1_1,
+			test_setup, test_client, &str_src_ac4_8_1_1,
 			STR_SRC_AC4_8_1_1);
 	define_test("BAP/UCL/STR/BV-035-C [UCL, SRC, AC 1, LC3 8_2_1]",
-			test_client, &str_src_ac1_8_2_1,
+			test_setup, test_client, &str_src_ac1_8_2_1,
 			STR_SRC_AC1_8_2_1);
 	define_test("BAP/UCL/STR/BV-036-C [UCL, SRC, AC 4, LC3 8_2_1]",
-			test_client, &str_src_ac4_8_2_1,
+			test_setup, test_client, &str_src_ac4_8_2_1,
 			STR_SRC_AC4_8_2_1);
 	define_test("BAP/UCL/STR/BV-037-C [UCL, SRC, AC 1, LC3 16_1_1]",
-			test_client, &str_src_ac1_16_1_1,
+			test_setup, test_client, &str_src_ac1_16_1_1,
 			STR_SRC_AC1_16_1_1);
 	define_test("BAP/UCL/STR/BV-038-C [UCL, SRC, AC 4, LC3 16_1_1]",
-			test_client, &str_src_ac4_16_1_1,
+			test_setup, test_client, &str_src_ac4_16_1_1,
 			STR_SRC_AC4_16_1_1);
 	define_test("BAP/UCL/STR/BV-039-C [UCL, SRC, AC 1, LC3 16_2_1]",
-			test_client, &str_src_ac1_16_2_1,
+			test_setup, test_client, &str_src_ac1_16_2_1,
 			STR_SRC_AC1_16_2_1);
 	define_test("BAP/UCL/STR/BV-040-C [UCL, SRC, AC 4, LC3 16_2_1]",
-			test_client, &str_src_ac4_16_2_1,
+			test_setup, test_client, &str_src_ac4_16_2_1,
 			STR_SRC_AC4_16_2_1);
 	define_test("BAP/UCL/STR/BV-041-C [UCL, SRC, AC 1, LC3 24_1_1]",
-			test_client, &str_src_ac1_24_1_1,
+			test_setup, test_client, &str_src_ac1_24_1_1,
 			STR_SRC_AC1_24_1_1);
 	define_test("BAP/UCL/STR/BV-042-C [UCL, SRC, AC 4, LC3 24_1_1]",
-			test_client, &str_src_ac4_24_1_1,
+			test_setup, test_client, &str_src_ac4_24_1_1,
 			STR_SRC_AC4_24_1_1);
 	define_test("BAP/UCL/STR/BV-043-C [UCL, SRC, AC 1, LC3 24_2_1]",
-			test_client, &str_src_ac1_24_2_1,
+			test_setup, test_client, &str_src_ac1_24_2_1,
 			STR_SRC_AC1_24_2_1);
 	define_test("BAP/UCL/STR/BV-044-C [UCL, SRC, AC 4, LC3 24_2_1]",
-			test_client, &str_src_ac4_24_2_1,
+			test_setup, test_client, &str_src_ac4_24_2_1,
 			STR_SRC_AC4_24_2_1);
 	define_test("BAP/UCL/STR/BV-045-C [UCL, SRC, AC 1, LC3 32_1_1]",
-			test_client, &str_src_ac1_32_1_1,
+			test_setup, test_client, &str_src_ac1_32_1_1,
 			STR_SRC_AC1_32_1_1);
 	define_test("BAP/UCL/STR/BV-046-C [UCL, SRC, AC 4, LC3 32_1_1]",
-			test_client, &str_src_ac4_32_1_1,
+			test_setup, test_client, &str_src_ac4_32_1_1,
 			STR_SRC_AC4_32_1_1);
 	define_test("BAP/UCL/STR/BV-047-C [UCL, SRC, AC 1, LC3 32_2_1]",
-			test_client, &str_src_ac1_32_2_1,
+			test_setup, test_client, &str_src_ac1_32_2_1,
 			STR_SRC_AC1_32_2_1);
 	define_test("BAP/UCL/STR/BV-048-C [UCL, SRC, AC 4, LC3 32_2_1]",
-			test_client, &str_src_ac4_32_2_1,
+			test_setup, test_client, &str_src_ac4_32_2_1,
 			STR_SRC_AC4_32_2_1);
 	define_test("BAP/UCL/STR/BV-049-C [UCL, SRC, AC 1, LC3 44_1_1]",
-			test_client, &str_src_ac1_44_1_1,
+			test_setup, test_client, &str_src_ac1_44_1_1,
 			STR_SRC_AC1_44_1_1);
 	define_test("BAP/UCL/STR/BV-050-C [UCL, SRC, AC 4, LC3 44_1_1]",
-			test_client, &str_src_ac4_44_1_1,
+			test_setup, test_client, &str_src_ac4_44_1_1,
 			STR_SRC_AC4_44_1_1);
 	define_test("BAP/UCL/STR/BV-051-C [UCL, SRC, AC 1, LC3 44_2_1]",
-			test_client, &str_src_ac1_44_2_1,
+			test_setup, test_client, &str_src_ac1_44_2_1,
 			STR_SRC_AC1_44_2_1);
 	define_test("BAP/UCL/STR/BV-052-C [UCL, SRC, AC 4, LC3 44_2_1]",
-			test_client, &str_src_ac4_44_2_1,
+			test_setup, test_client, &str_src_ac4_44_2_1,
 			STR_SRC_AC4_44_2_1);
 	define_test("BAP/UCL/STR/BV-053-C [UCL, SRC, AC 1, LC3 48_1_1]",
-			test_client, &str_src_ac1_48_1_1,
+			test_setup, test_client, &str_src_ac1_48_1_1,
 			STR_SRC_AC1_48_1_1);
 	define_test("BAP/UCL/STR/BV-054-C [UCL, SRC, AC 4, LC3 48_1_1]",
-			test_client, &str_src_ac4_48_1_1,
+			test_setup, test_client, &str_src_ac4_48_1_1,
 			STR_SRC_AC4_48_1_1);
 	define_test("BAP/UCL/STR/BV-055-C [UCL, SRC, AC 1, LC3 48_2_1]",
-			test_client, &str_src_ac1_48_2_1,
+			test_setup, test_client, &str_src_ac1_48_2_1,
 			STR_SRC_AC1_48_2_1);
 	define_test("BAP/UCL/STR/BV-056-C [UCL, SRC, AC 4, LC3 48_2_1]",
-			test_client, &str_src_ac4_48_2_1,
+			test_setup, test_client, &str_src_ac4_48_2_1,
 			STR_SRC_AC4_48_2_1);
 	define_test("BAP/UCL/STR/BV-057-C [UCL, SRC, AC 1, LC3 48_3_1]",
-			test_client, &str_src_ac1_48_3_1,
+			test_setup, test_client, &str_src_ac1_48_3_1,
 			STR_SRC_AC1_48_3_1);
 	define_test("BAP/UCL/STR/BV-058-C [UCL, SRC, AC 4, LC3 48_3_1]",
-			test_client, &str_src_ac4_48_3_1,
+			test_setup, test_client, &str_src_ac4_48_3_1,
 			STR_SRC_AC4_48_3_1);
 	define_test("BAP/UCL/STR/BV-059-C [UCL, SRC, AC 1, LC3 48_4_1]",
-			test_client, &str_src_ac1_48_4_1,
+			test_setup, test_client, &str_src_ac1_48_4_1,
 			STR_SRC_AC1_48_4_1);
 	define_test("BAP/UCL/STR/BV-060-C [UCL, SRC, AC 4, LC3 48_4_1]",
-			test_client, &str_src_ac4_48_4_1,
+			test_setup, test_client, &str_src_ac4_48_4_1,
 			STR_SRC_AC4_48_4_1);
 	define_test("BAP/UCL/STR/BV-061-C [UCL, SRC, AC 1, LC3 48_5_1]",
-			test_client, &str_src_ac1_48_5_1,
+			test_setup, test_client, &str_src_ac1_48_5_1,
 			STR_SRC_AC1_48_5_1);
 	define_test("BAP/UCL/STR/BV-062-C [UCL, SRC, AC 4, LC3 48_5_1]",
-			test_client, &str_src_ac4_48_5_1,
+			test_setup, test_client, &str_src_ac4_48_5_1,
 			STR_SRC_AC4_48_5_1);
 	define_test("BAP/UCL/STR/BV-063-C [UCL, SRC, AC 1, LC3 48_6_1]",
-			test_client, &str_src_ac1_48_6_1,
+			test_setup, test_client, &str_src_ac1_48_6_1,
 			STR_SRC_AC1_48_6_1);
 	define_test("BAP/UCL/STR/BV-064-C [UCL, SRC, AC 4, LC3 48_6_1]",
-			test_client, &str_src_ac4_48_6_1,
+			test_setup, test_client, &str_src_ac4_48_6_1,
 			STR_SRC_AC4_48_6_1);
 	define_test("BAP/UCL/STR/BV-065-C [UCL, AC 2, LC3 8_1_2]",
-			test_client, &str_snk_ac2_8_1_2,
+			test_setup, test_client, &str_snk_ac2_8_1_2,
 			STR_SNK_AC2_8_1_2);
 	define_test("BAP/UCL/STR/BV-066-C [UCL, AC 10, LC3 8_1_2]",
-			test_client, &str_snk_ac10_8_1_2,
+			test_setup, test_client, &str_snk_ac10_8_1_2,
 			STR_SNK_AC10_8_1_2);
 	define_test("BAP/UCL/STR/BV-067-C [UCL, AC 2, LC3 8_2_2]",
-			test_client, &str_snk_ac2_8_2_2,
+			test_setup, test_client, &str_snk_ac2_8_2_2,
 			STR_SNK_AC2_8_2_2);
 	define_test("BAP/UCL/STR/BV-068-C [UCL, AC 10, LC3 8_2_2]",
-			test_client, &str_snk_ac10_8_2_2,
+			test_setup, test_client, &str_snk_ac10_8_2_2,
 			STR_SNK_AC10_8_2_2);
 	define_test("BAP/UCL/STR/BV-069-C [UCL, AC 2, LC3 16_1_2]",
-			test_client, &str_snk_ac2_16_1_2,
+			test_setup, test_client, &str_snk_ac2_16_1_2,
 			STR_SNK_AC2_16_1_2);
 	define_test("BAP/UCL/STR/BV-070-C [UCL, AC 10, LC3 16_1_2]",
-			test_client, &str_snk_ac10_16_1_2,
+			test_setup, test_client, &str_snk_ac10_16_1_2,
 			STR_SNK_AC10_16_1_2);
 	define_test("BAP/UCL/STR/BV-071-C [UCL, AC 2, LC3 16_2_2]",
-			test_client, &str_snk_ac2_16_2_2,
+			test_setup, test_client, &str_snk_ac2_16_2_2,
 			STR_SNK_AC2_16_2_2);
 	define_test("BAP/UCL/STR/BV-072-C [UCL, AC 10, LC3 16_2_2]",
-			test_client, &str_snk_ac10_16_2_2,
+			test_setup, test_client, &str_snk_ac10_16_2_2,
 			STR_SNK_AC10_16_2_2);
 	define_test("BAP/UCL/STR/BV-073-C [UCL, AC 2, LC3 24_1_2]",
-			test_client, &str_snk_ac2_24_1_2,
+			test_setup, test_client, &str_snk_ac2_24_1_2,
 			STR_SNK_AC2_24_1_2);
 	define_test("BAP/UCL/STR/BV-074-C [UCL, AC 10, LC3 24_1_2]",
-			test_client, &str_snk_ac10_24_1_2,
+			test_setup, test_client, &str_snk_ac10_24_1_2,
 			STR_SNK_AC10_24_1_2);
 	define_test("BAP/UCL/STR/BV-075-C [UCL, AC 2, LC3 24_2_2]",
-			test_client, &str_snk_ac2_24_2_2,
+			test_setup, test_client, &str_snk_ac2_24_2_2,
 			STR_SNK_AC2_24_2_2);
 	define_test("BAP/UCL/STR/BV-076-C [UCL, AC 10, LC3 24_2_2]",
-			test_client, &str_snk_ac10_24_2_2,
+			test_setup, test_client, &str_snk_ac10_24_2_2,
 			STR_SNK_AC10_24_2_2);
 	define_test("BAP/UCL/STR/BV-077-C [UCL, AC 2, LC3 32_1_2]",
-			test_client, &str_snk_ac2_32_1_2,
+			test_setup, test_client, &str_snk_ac2_32_1_2,
 			STR_SNK_AC2_32_1_2);
 	define_test("BAP/UCL/STR/BV-078-C [UCL, AC 10, LC3 32_1_2]",
-			test_client, &str_snk_ac10_32_1_2,
+			test_setup, test_client, &str_snk_ac10_32_1_2,
 			STR_SNK_AC10_32_1_2);
 	define_test("BAP/UCL/STR/BV-079-C [UCL, AC 2, LC3 32_2_2]",
-			test_client, &str_snk_ac2_32_2_2,
+			test_setup, test_client, &str_snk_ac2_32_2_2,
 			STR_SNK_AC2_32_2_2);
 	define_test("BAP/UCL/STR/BV-080-C [UCL, AC 10, LC3 32_2_2]",
-			test_client, &str_snk_ac10_32_2_2,
+			test_setup, test_client, &str_snk_ac10_32_2_2,
 			STR_SNK_AC10_32_2_2);
 	define_test("BAP/UCL/STR/BV-081-C [UCL, AC 2, LC3 44_1_2]",
-			test_client, &str_snk_ac2_44_1_2,
+			test_setup, test_client, &str_snk_ac2_44_1_2,
 			STR_SNK_AC2_44_1_2);
 	define_test("BAP/UCL/STR/BV-082-C [UCL, AC 10, LC3 44_1_2]",
-			test_client, &str_snk_ac10_44_1_2,
+			test_setup, test_client, &str_snk_ac10_44_1_2,
 			STR_SNK_AC10_44_1_2);
 	define_test("BAP/UCL/STR/BV-083-C [UCL, AC 2, LC3 44_2_2]",
-			test_client, &str_snk_ac2_44_2_2,
+			test_setup, test_client, &str_snk_ac2_44_2_2,
 			STR_SNK_AC2_44_2_2);
 	define_test("BAP/UCL/STR/BV-084-C [UCL, AC 10, LC3 44_2_2]",
-			test_client, &str_snk_ac10_44_2_2,
+			test_setup, test_client, &str_snk_ac10_44_2_2,
 			STR_SNK_AC10_44_2_2);
 	define_test("BAP/UCL/STR/BV-085-C [UCL, AC 2, LC3 48_1_2]",
-			test_client, &str_snk_ac2_48_1_2,
+			test_setup, test_client, &str_snk_ac2_48_1_2,
 			STR_SNK_AC2_48_1_2);
 	define_test("BAP/UCL/STR/BV-086-C [UCL, AC 10, LC3 48_1_2]",
-			test_client, &str_snk_ac10_48_1_2,
+			test_setup, test_client, &str_snk_ac10_48_1_2,
 			STR_SNK_AC10_48_1_2);
 	define_test("BAP/UCL/STR/BV-087-C [UCL, AC 2, LC3 48_2_2]",
-			test_client, &str_snk_ac2_48_2_2,
+			test_setup, test_client, &str_snk_ac2_48_2_2,
 			STR_SNK_AC2_48_2_2);
 	define_test("BAP/UCL/STR/BV-088-C [UCL, AC 10, LC3 48_2_2]",
-			test_client, &str_snk_ac10_48_2_2,
+			test_setup, test_client, &str_snk_ac10_48_2_2,
 			STR_SNK_AC10_48_2_2);
 	define_test("BAP/UCL/STR/BV-089-C [UCL, AC 2, LC3 48_3_2]",
-			test_client, &str_snk_ac2_48_3_2,
+			test_setup, test_client, &str_snk_ac2_48_3_2,
 			STR_SNK_AC2_48_3_2);
 	define_test("BAP/UCL/STR/BV-090-C [UCL, AC 10, LC3 48_3_2]",
-			test_client, &str_snk_ac10_48_3_2,
+			test_setup, test_client, &str_snk_ac10_48_3_2,
 			STR_SNK_AC10_48_3_2);
 	define_test("BAP/UCL/STR/BV-091-C [UCL, AC 2, LC3 48_4_2]",
-			test_client, &str_snk_ac2_48_4_2,
+			test_setup, test_client, &str_snk_ac2_48_4_2,
 			STR_SNK_AC2_48_4_2);
 	define_test("BAP/UCL/STR/BV-092-C [UCL, AC 10, LC3 48_4_2]",
-			test_client, &str_snk_ac10_48_4_2,
+			test_setup, test_client, &str_snk_ac10_48_4_2,
 			STR_SNK_AC10_48_4_2);
 	define_test("BAP/UCL/STR/BV-093-C [UCL, AC 2, LC3 48_5_2]",
-			test_client, &str_snk_ac2_48_5_2,
+			test_setup, test_client, &str_snk_ac2_48_5_2,
 			STR_SNK_AC2_48_5_2);
 	define_test("BAP/UCL/STR/BV-094-C [UCL, AC 10, LC3 48_5_2]",
-			test_client, &str_snk_ac10_48_5_2,
+			test_setup, test_client, &str_snk_ac10_48_5_2,
 			STR_SNK_AC10_48_5_2);
 	define_test("BAP/UCL/STR/BV-095-C [UCL, AC 2, LC3 48_6_2]",
-			test_client, &str_snk_ac2_48_6_2,
+			test_setup, test_client, &str_snk_ac2_48_6_2,
 			STR_SNK_AC2_48_6_2);
 	define_test("BAP/UCL/STR/BV-096-C [UCL, AC 10, LC3 48_6_2]",
-			test_client, &str_snk_ac10_48_6_2,
+			test_setup, test_client, &str_snk_ac10_48_6_2,
 			STR_SNK_AC10_48_6_2);
 	define_test("BAP/UCL/STR/BV-097-C [UCL, SRC, AC 1, LC3 8_1_2]",
-			test_client, &str_src_ac1_8_1_2,
+			test_setup, test_client, &str_src_ac1_8_1_2,
 			STR_SRC_AC1_8_1_2);
 	define_test("BAP/UCL/STR/BV-098-C [UCL, SRC, AC 4, LC3 8_1_2]",
-			test_client, &str_src_ac4_8_1_2,
+			test_setup, test_client, &str_src_ac4_8_1_2,
 			STR_SRC_AC4_8_1_2);
 	define_test("BAP/UCL/STR/BV-099-C [UCL, SRC, AC 1, LC3 8_2_2]",
-			test_client, &str_src_ac1_8_2_2,
+			test_setup, test_client, &str_src_ac1_8_2_2,
 			STR_SRC_AC1_8_2_2);
 	define_test("BAP/UCL/STR/BV-100-C [UCL, SRC, AC 4, LC3 8_2_2]",
-			test_client, &str_src_ac4_8_2_2,
+			test_setup, test_client, &str_src_ac4_8_2_2,
 			STR_SRC_AC4_8_2_2);
 	define_test("BAP/UCL/STR/BV-101-C [UCL, SRC, AC 1, LC3 16_1_2]",
-			test_client, &str_src_ac1_16_1_2,
+			test_setup, test_client, &str_src_ac1_16_1_2,
 			STR_SRC_AC1_16_1_2);
 	define_test("BAP/UCL/STR/BV-102-C [UCL, SRC, AC 4, LC3 16_1_2]",
-			test_client, &str_src_ac4_16_1_2,
+			test_setup, test_client, &str_src_ac4_16_1_2,
 			STR_SRC_AC4_16_1_2);
 	define_test("BAP/UCL/STR/BV-103-C [UCL, SRC, AC 1, LC3 16_2_2]",
-			test_client, &str_src_ac1_16_2_2,
+			test_setup, test_client, &str_src_ac1_16_2_2,
 			STR_SRC_AC1_16_2_2);
 	define_test("BAP/UCL/STR/BV-104-C [UCL, SRC, AC 4, LC3 16_2_2]",
-			test_client, &str_src_ac4_16_2_2,
+			test_setup, test_client, &str_src_ac4_16_2_2,
 			STR_SRC_AC4_16_2_2);
 	define_test("BAP/UCL/STR/BV-105-C [UCL, SRC, AC 1, LC3 24_1_2]",
-			test_client, &str_src_ac1_24_1_2,
+			test_setup, test_client, &str_src_ac1_24_1_2,
 			STR_SRC_AC1_24_1_2);
 	define_test("BAP/UCL/STR/BV-106-C [UCL, SRC, AC 4, LC3 24_1_2]",
-			test_client, &str_src_ac4_24_1_2,
+			test_setup, test_client, &str_src_ac4_24_1_2,
 			STR_SRC_AC4_24_1_2);
 	define_test("BAP/UCL/STR/BV-107-C [UCL, SRC, AC 1, LC3 24_2_2]",
-			test_client, &str_src_ac1_24_2_2,
+			test_setup, test_client, &str_src_ac1_24_2_2,
 			STR_SRC_AC1_24_2_2);
 	define_test("BAP/UCL/STR/BV-108-C [UCL, SRC, AC 4, LC3 24_2_2]",
-			test_client, &str_src_ac4_24_2_2,
+			test_setup, test_client, &str_src_ac4_24_2_2,
 			STR_SRC_AC4_24_2_2);
 	define_test("BAP/UCL/STR/BV-109-C [UCL, SRC, AC 1, LC3 32_1_2]",
-			test_client, &str_src_ac1_32_1_2,
+			test_setup, test_client, &str_src_ac1_32_1_2,
 			STR_SRC_AC1_32_1_2);
 	define_test("BAP/UCL/STR/BV-110-C [UCL, SRC, AC 4, LC3 32_1_2]",
-			test_client, &str_src_ac4_32_1_2,
+			test_setup, test_client, &str_src_ac4_32_1_2,
 			STR_SRC_AC4_32_1_2);
 	define_test("BAP/UCL/STR/BV-111-C [UCL, SRC, AC 1, LC3 32_2_2]",
-			test_client, &str_src_ac1_32_2_2,
+			test_setup, test_client, &str_src_ac1_32_2_2,
 			STR_SRC_AC1_32_2_2);
 	define_test("BAP/UCL/STR/BV-112-C [UCL, SRC, AC 4, LC3 32_2_2]",
-			test_client, &str_src_ac4_32_2_2,
+			test_setup, test_client, &str_src_ac4_32_2_2,
 			STR_SRC_AC4_32_2_2);
 	define_test("BAP/UCL/STR/BV-113-C [UCL, SRC, AC 1, LC3 44_1_2]",
-			test_client, &str_src_ac1_44_1_2,
+			test_setup, test_client, &str_src_ac1_44_1_2,
 			STR_SRC_AC1_44_1_2);
 	define_test("BAP/UCL/STR/BV-114-C [UCL, SRC, AC 4, LC3 44_1_2]",
-			test_client, &str_src_ac4_44_1_2,
+			test_setup, test_client, &str_src_ac4_44_1_2,
 			STR_SRC_AC4_44_1_2);
 	define_test("BAP/UCL/STR/BV-115-C [UCL, SRC, AC 1, LC3 44_2_2]",
-			test_client, &str_src_ac1_44_2_2,
+			test_setup, test_client, &str_src_ac1_44_2_2,
 			STR_SRC_AC1_44_2_2);
 	define_test("BAP/UCL/STR/BV-116-C [UCL, SRC, AC 4, LC3 44_2_2]",
-			test_client, &str_src_ac4_44_2_2,
+			test_setup, test_client, &str_src_ac4_44_2_2,
 			STR_SRC_AC4_44_2_2);
 	define_test("BAP/UCL/STR/BV-117-C [UCL, SRC, AC 1, LC3 48_1_2]",
-			test_client, &str_src_ac1_48_1_2,
+			test_setup, test_client, &str_src_ac1_48_1_2,
 			STR_SRC_AC1_48_1_2);
 	define_test("BAP/UCL/STR/BV-118-C [UCL, SRC, AC 4, LC3 48_1_2]",
-			test_client, &str_src_ac4_48_1_2,
+			test_setup, test_client, &str_src_ac4_48_1_2,
 			STR_SRC_AC4_48_1_2);
 	define_test("BAP/UCL/STR/BV-119-C [UCL, SRC, AC 1, LC3 48_2_2]",
-			test_client, &str_src_ac1_48_2_2,
+			test_setup, test_client, &str_src_ac1_48_2_2,
 			STR_SRC_AC1_48_2_2);
 	define_test("BAP/UCL/STR/BV-120-C [UCL, SRC, AC 4, LC3 48_2_2]",
-			test_client, &str_src_ac4_48_2_2,
+			test_setup, test_client, &str_src_ac4_48_2_2,
 			STR_SRC_AC4_48_2_2);
 	define_test("BAP/UCL/STR/BV-121-C [UCL, SRC, AC 1, LC3 48_3_2]",
-			test_client, &str_src_ac1_48_3_2,
+			test_setup, test_client, &str_src_ac1_48_3_2,
 			STR_SRC_AC1_48_3_2);
 	define_test("BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_3_2]",
-			test_client, &str_src_ac4_48_3_2,
+			test_setup, test_client, &str_src_ac4_48_3_2,
 			STR_SRC_AC4_48_3_2);
 	define_test("BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_4_2]",
-			test_client, &str_src_ac1_48_4_2,
+			test_setup, test_client, &str_src_ac1_48_4_2,
 			STR_SRC_AC1_48_4_2);
 	define_test("BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_4_2]",
-			test_client, &str_src_ac4_48_4_2,
+			test_setup, test_client, &str_src_ac4_48_4_2,
 			STR_SRC_AC4_48_4_2);
 	define_test("BAP/UCL/STR/BV-121-C [UCL, SRC, AC 1, LC3 48_5_2]",
-			test_client, &str_src_ac1_48_5_2,
+			test_setup, test_client, &str_src_ac1_48_5_2,
 			STR_SRC_AC1_48_5_2);
 	define_test("BAP/UCL/STR/BV-122-C [UCL, SRC, AC 4, LC3 48_5_2]",
-			test_client, &str_src_ac4_48_5_2,
+			test_setup, test_client, &str_src_ac4_48_5_2,
 			STR_SRC_AC4_48_5_2);
 	define_test("BAP/UCL/STR/BV-123-C [UCL, SRC, AC 1, LC3 48_6_2]",
-			test_client, &str_src_ac1_48_6_2,
+			test_setup, test_client, &str_src_ac1_48_6_2,
 			STR_SRC_AC1_48_6_2);
 	define_test("BAP/UCL/STR/BV-124-C [UCL, SRC, AC 4, LC3 48_6_2]",
-			test_client, &str_src_ac4_48_6_2,
+			test_setup, test_client, &str_src_ac4_48_6_2,
 			STR_SRC_AC4_48_6_2);
 }
 
-- 
2.39.2

