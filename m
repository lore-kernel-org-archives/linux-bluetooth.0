Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6B179B1
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916762; cv=fail; b=ljHUXClBvbf4t6cWrr8h1goPPCH4NWko6FAB5vCnps6kwyMOdHXzoomSIEKdcICL5eNRHd+vfJ9ad8fgLP2ExDkygB9A+aaDee5ouPBB6j9jLesFyG4uX5sRoc19p4Qa67TynBI4ByfAatIyZDiSevMvaoAL/sBp3pPqMclAB20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916762; c=relaxed/simple;
	bh=LNJ6IKQIILL4QpQTAFV7m7uPFR+Y6rINoH0O64d8wUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EazJ80HVa7AqkRwDJ1dDpmEAbJqBmuipkRNBlroXSEcce9praBLJSJsvBpzdSJ8Tjxcu7jDNeXsp7Wy8w2QUZK1M65JyqLHSvWRwaTpxvDAvxaK2zpx98mILHJAJXssG1R7Lcq6aFey/r6rLpzaxKmKJZANRsq1MSCtPyLBc5qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bbLvYNuZ; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bbLvYNuZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUWB+yGwv3SmB/SDp756qFt4q5P6AU2Vmn4N2cpKBpnwJ+ZtZkwvagyBLNnAv55frJEwNKyIt7NQ4nBGZw/3KYMQEbsaF5KRP66ACTBhhmvQFZK262yHcnU5qmEiDFnHhsNX8uW7BlZzpw8zrAbsUO5szAjJGMfX4AMqrhgOi1oHWh8Yr1gclDCy380ZMHEfFyYbjWhVbXON6TCLrLrkCMaXRQKcfeHOruNzxBIhmOnfB8MNJ4SsbdZCmectWAwlPA9tbJrP83HZ1kr2uvqdEBQm7rAD0fmAknwLlU0xr63c8A1aXNUp4Xh/DrLpw7NfJoZzkX3DwxT0McMzKX2JwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJYPo4BDEQehzyDUUeCbu4wXD1MJpd0C1mIihRuBq8c=;
 b=DzYsSReLW0hZ8uyUjUgZ6wCiCvnX+Yi76+g9MdJApb2PHIU0flZqcNHeBfKO+W4ymGDTiskzyJg2Svt/bCOfjWm3B5jJaoAtQ7xbZB1Z0UWaH0XcooQ/D4I/gV25JUbPxeArggvL8urelEIgYJiBUbfPY41TvdnULuL5VMYIrubk4xQhA/kSgo6R7j4RtQE91/UKmdAikxVnWZrRwi7Vx+0uuKUMqDOMFNQP5XD8bwAesaaCUOQfMruohCsdzErk+FhNxIvyZNg/jfC5zEq7YFdliLAFfRD4x0kxBes7McNL94Vl/QYS7VPcOIDQRNyPANXzB+uyHTBkSOktQers3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJYPo4BDEQehzyDUUeCbu4wXD1MJpd0C1mIihRuBq8c=;
 b=bbLvYNuZsT6RKPfKl+IJmsJzb4l7Gia+zPeuY5F7i4aCj/JEbOMyR+9+To51uBbvAzIXHzbiRNMwCax/We4d3SQcUOZ38DDEYych6jtkygBFB5x/Vd4owiekHPfr5e7Uit31SxH8zJMyuPc9aP8SuCKKiI2w428AGjeBtqj4M3s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB7572.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 16:52:37 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 16:52:37 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/3] player: Add reconfiguration prompt for broadcast source
Date: Fri,  8 Mar 2024 18:52:30 +0200
Message-Id: <20240308165232.53906-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308165232.53906-1-silviu.barbulescu@nxp.com>
References: <20240308165232.53906-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0001.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::7) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: c07e5b71-f9d3-4624-efec-08dc3f9028fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nL4n+npWvLld37Lm0elP2Lb4maPHM2+RQ8qFxR5OT6FoZzsbAt5P+qzhzMwKPmSkWmk00StZd+jaz6n6qOdO/Ke26WZ/742/oRKRAMMAQKWTbnaa7LSEN0DuVRP0wUuUoz4Yr9B0qYiYry79EEkD8VPZZRcHGEmCypA9QjkN9DWCNsN+3DACdEELuMjljN9KaUV1P2IkYgMhW/Gvmr+ulBGlibzyNoBPIwaDvd2KwWHpJoyKzs9SOBbWQF+uZr6Yk80M4UxZVSq8F7aLw2TWi5dR4JfeyAn3mlBa6rg6+4PDnvh20t/f5clD4bRu+sLBvrmVhNYVMSmsD397M1yVRQe5MZgnZja/8Hs86XmGh06K0DsSHP2NWFQU2RFYUFt06nh49NLWuD9JNO1zus8vTyJGf4QNWpu41zt+r/vI8c9AblRvbuGyw5mcYcMX4yoCCBCgYeL4UGPv8J4E8A+B9Nptk4ARxzGn5jZVzf1b+RemX/XYVAmdDv3v8ECVuC1Qyx2nC4yfFPlCcSCjRWm6ZFUqjqS3tIFrfdaaTO+qk7QXPW8hDIqdThUeQqp+o/0mJk2QFNseaSh+L1oF4i56G6TByYUA1PcfqovTKNJijODlXcoH20cjXQHAWt3e72NaT8ph1k6ZXg0yU0qm2xAXnR+xhV69TrACDSvDPg8EhWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D8AhBZuqMjaGPS0PixkVkBWPuGKQjrLo0RXGGWfMU2ytW3F1rJkoH7I1KCTP?=
 =?us-ascii?Q?8OFDkTLaTWp9780LnoWEBZNCuptVQcwNdmT6nucpHnNtE10vYNXXuBRW9h+s?=
 =?us-ascii?Q?Q14rHriXf5HtBBrra8jYm6TkQvuCtqk94nbkrPH04xF7lA+aqdAc59vVehsL?=
 =?us-ascii?Q?HRUESADPY/P6TNS3n4iuuOtIizk5X6mSUtIMyPsPXN8v1E2EYjqn5tVj9cy5?=
 =?us-ascii?Q?UwAGMDr8qScWtIFB6bpZruxbJ2OFNsotgv1VGM4d2eOg/34ZTDB8NzAbX232?=
 =?us-ascii?Q?jB+tKaCi7f00M+PgvVDEDiAQiSmjMbG3yMU5IFvWU4gjKtYsLGtiOdiaa7Ut?=
 =?us-ascii?Q?COiUsHwz9h8C9hzob6wl3sdOckRyW0l7xWeOao6DdPjIkp8Z3gfQ4NTIhhMD?=
 =?us-ascii?Q?RJLRR0/vJGWLBwsE1HyY3KvjcuTIaa/KqlqBcYorghqXnu+TfGQ69NVNs3Oc?=
 =?us-ascii?Q?dpfrHOQb7SSE4CXHotMfRZKV7/mNYG3lohBaNAme4UaaHVzQFNIkf74DG1gZ?=
 =?us-ascii?Q?meerSTHnd5HHA/mLlqzqDj830034tTmPzNDqbW/VTuJWKhEZ4Y7u0tyJPwaE?=
 =?us-ascii?Q?bSG3PUFLs+uqXQ/MkVivWIWLMz0p45BEFRwxjJ2Qs8SzcIvtmaxs5SjIXk/O?=
 =?us-ascii?Q?mK/Rdzf+Jj+bNFgy+I4iqYXVSoASsLLtqgRrQGLEQcBV5t1alWMngQM0qRLX?=
 =?us-ascii?Q?9xYIByUNCDF9IkIoo2rtt0VEiWQwEo70ChrN+yxwP2RhGX4/Mr9GciFPpWsq?=
 =?us-ascii?Q?DOfvcWP6ww54pKlX82ittKTfDvTkpAdMGnv4KOh4qKZUT2pXIImq+n97ZJWr?=
 =?us-ascii?Q?RRDzNnDu86O1qtPtCMk27oQrFmoRo5nPKICeSThZyp29/I45M6rCvCu3lvUU?=
 =?us-ascii?Q?BvCI424EEtWo3Hqsa7Qwi5bzFu/MonWZA1v8segVa7KbChev9CUPYOMMGuXz?=
 =?us-ascii?Q?JUe0SM2zBEtcL5IR9Clz2uUgfmumnzNBKM5PFzcJ1oYvcLlPXgqaDePQPFtB?=
 =?us-ascii?Q?5vkxztDAj9Uk4DIHIm/F3CY5hK0M+Z53GUsnTd0dEjOwjeAon6JttcoL0wBF?=
 =?us-ascii?Q?D0thMGvZw/5Ml0U5vmTill3r2lXiLWB7zDhUPtFZNZE8X72mLoEkLlb7DpyG?=
 =?us-ascii?Q?L74O/7CSzJlvdgXKqM1jGbkM544Q7e/4b5+TyFzB/i6KHGl0Mi1RWWShYFLq?=
 =?us-ascii?Q?XEDdolny0LAurBDacadyM/coyShDg8u86s/+7iTcxwVp/qpJU9amiDSRQ1z9?=
 =?us-ascii?Q?KfRWpZ1mzxPwmxHTS7qGQ5xH1l68CU9Vhm2918XL7b5SQ9mpCBMj4cPJ4FXR?=
 =?us-ascii?Q?H5k3bo0nWhtWGVMjR0DjVNWQpo20ltIfWAOVNf2s+iMcVwYhKqyMsVE8nZkv?=
 =?us-ascii?Q?CG5tqb4CMgW/yegR0ff11cLPoSyMeAa8ojpQ1SKtuvhoEXKmyAsI2ACyT0VO?=
 =?us-ascii?Q?2EW/S4kXqsZSOrdft//4Sy0uDx8hGrAhD1KCiisLa3Z8tKHrtP2D09l7SROV?=
 =?us-ascii?Q?xhJ+QfLuhP+8CXG02kjpRzTRKSqet86wZ4aDGOjWVoeoJWaFeczdRuXYV4G/?=
 =?us-ascii?Q?+8H0NcUncO64yPTZiQqe/BmrnUvpD60rg/8weNfUgKR4vZ6+0rSl/8qJ4En9?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07e5b71-f9d3-4624-efec-08dc3f9028fe
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:52:37.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLb+6dtlO9REmIrOyXYD7fCApSPcaIjmVGDKIz8GzVKDv1eXm6X79lfTwX7AIYEJqW9Zg74SPny2uzH7kO3W59j+ShxboyzygIrH0XtzAqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7572

endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] This is a BIS Reconfiguration? (yes/no): y
The BIS index is assigned in the order of the configuration
starting with 1
[/local/endpoint/ep0] BIS Index (value): 1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 2
[/local/endpoint/ep0] Enter Metadata (value/no): n

---
 client/player.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index a40bf66e3..35143115a 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3809,6 +3809,48 @@ static void config_endpoint_iso_group(const char *input, void *user_data)
 	}
 }
 
+static void endpoint_set_reconfigure_cfg(const char *input, void *user_data)
+{
+	char *endptr = NULL;
+	int value;
+	struct endpoint_config *cfg = user_data;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	cfg->ep->iso_stream = value;
+
+	bt_shell_prompt_input(cfg->ep->path,
+		"BIG (auto/value):",
+		config_endpoint_iso_group, cfg);
+}
+
+static void endpoint_is_reconfigure_cfg(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
+		cfg->ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
+		goto done;
+	} else {
+		bt_shell_printf("The BIS index is assigned  in the order of "
+				"the configuration starting with 1\n");
+		bt_shell_prompt_input(cfg->ep->path,
+		"BIS Index (value):",
+		endpoint_set_reconfigure_cfg, cfg);
+		return;
+	}
+
+done:
+	bt_shell_prompt_input(cfg->ep->path,
+		"BIG (auto/value):",
+		config_endpoint_iso_group, cfg);
+}
+
 static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 {
 	cfg->ep->bcode = g_new0(struct iovec, 1);
@@ -3835,8 +3877,8 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 	}
 
 	bt_shell_prompt_input(cfg->ep->path,
-		"BIG (auto/value):",
-		config_endpoint_iso_group, cfg);
+		"This is a BIS reconfiguration? (yes/no):",
+		endpoint_is_reconfigure_cfg, cfg);
 }
 
 static void cmd_config_endpoint(int argc, char *argv[])
-- 
2.39.2

