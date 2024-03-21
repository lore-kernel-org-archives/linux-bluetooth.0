Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023112C7E9
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2024 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037586; cv=fail; b=V1brvj2/f9ImUpJ1svQxUTH4/uy5kzu6ui/iQyHXjmiG9/vnICToVmBVjtvUxEGSuvL3FLAwdwVPUja9FzOCgVf1Gy12op2OI/QBbHVSuHrR0bnXXZD4q8CgBcTPpsag0ny7hMXQ3R8RtQNHtuek+0qmF4sDipy0HVe6oMvM338=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037586; c=relaxed/simple;
	bh=yoWokl9tB5ddOWzutmtAyMh6i4FEpYL39B0Xcw8ejEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ja97bOMJV+sBsHDd3XtMcYidtxscHmVYZ5i7VyUxHjs/qWYi1Gxb+iImY+brUSGgOHW15Jv6j7L6hYcjopuZaENiTW7V4+3SVVnXiWp9WrWIJibr7MnuokmnytlTAWMaFjdzr6QD8/XszJL0635RCg9xDww5ejD3ULi3PSxW9sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LzYz6d/B; arc=fail smtp.client-ip=40.107.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LzYz6d/B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2qCpkJrUYa46Zu73LdkJcGJhdMTUl/c1sfJ1It3PVYnppQSGPk5Y+qqnAubDMXYMHk6NWtsB0tY4qbbmvcu00iFgbFBRkGuhX3Bxqg2Au+LC76BQyLH99guXHRWfmcPe2YgFvwUFhlfh8PfWMVxNKFBh3s76AipZA3C7UYVjTY3ZFw8fNTZVZjLa3Na9SKYjiGBoXB9otJi4zaZ1rKxI1tI0BU3tYeZnsstuPCQKVmVSJosUrEuC6rDvHc+No4dpvZk6Z4iUxQczzefSlGynmF/0J7XzwCf5JUKPcRz3WmLp06VJalPZXmbGCgAyCXmi+j7gsNuKP1t9VT13HcZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBchBunfmEJnye/klmyVooNeQYcLNBHui65wNp33sZ8=;
 b=Ga+/668ZseHC4dQvasD5wats8Z68dyzHuKgjjehQfAVqD9OtVA/q4D7SBrDf7qRx4cTOajWoTypHIYmh8kk+BQUUtlcAVijIR75c2nGmHMMSu43k3MQkgML5an+JGDd7TjLthrFxcR204ckV+xO9HRGjSUXZo0kNgYHgBp5u017Zz8ZdsLMItpGdwr/Uy5xJXa7U4g2LVfd6V7kJg4H02Qp0npz1379JXbsDoi7qAKq3qrPZodOuUpAQJbYTsNiaLgoWR8pxcgwTxrHJbpszShMlrsz+Tg1Qf8gFBfUz4zBL3Iq9MXwjiqlwoCEvuwTCIIhOTzq5/KA7rLq1L85i9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBchBunfmEJnye/klmyVooNeQYcLNBHui65wNp33sZ8=;
 b=LzYz6d/BCqtpEUipI8pHb9+3pi8OOdfR2pNnilytlj0jamhnNB/8l9upYawbRamDCSv3eg1MIjbp0HtKUvAY+2xCiZUtdC/G1P4V/7L5arrFKWl9LyReCWYTv9IwoJiK+Qwm/fMVdri9H9xwlipXaxXd5hMz/hMgIH8bczHjYuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Thu, 21 Mar
 2024 16:13:01 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 16:13:01 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] player: Adjust SDU size based on the number of locations
Date: Thu, 21 Mar 2024 18:12:55 +0200
Message-Id: <20240321161255.24892-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240321161255.24892-1-silviu.barbulescu@nxp.com>
References: <20240321161255.24892-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0009.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::22) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: 3992bb57-64d3-4e1a-b26a-08dc49c1c82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qc++rvlz1A5tSUhxNZCK8uLsCU1kdeBNdhtP1tTsayfD7F6EAOmUvfRdnE1yZ5js4IkQfpYEL9IeqL62u/4Mx005xheRN46hnSJeORAvIzngQEWaopblhFjl1xcwhB0CnyJh7VceqoZF6fBakDZYWGiPSDMMWimr30dy/uJ4JuMbgGFn35UodpCyITzAHmcKV5cC5tx+Ns5eF0cagEBQNkwB/+730FaFY5MmvE6iGT2BJoZIwJEUWuEpIWSFh1k4lPwzhV/likZcaKwGc8pD5p/7IpcMNu1lPQDig7R42xvVgSgSqUK6ext/xvVsQmV2pnxNVE9zuCERZlAac/Pj/X0tvP3iv0/hZ5Xfkxq0XCaZllotdBKZCCeoQlGNE8melmH4w/DDA6kBMahhSzpdu92pdeM4PeOTSbqo4u3yv8uoJXnNayQcCbGkmcP+3niqw5ah9kxkcPBuWhoT4QGHXFqm9A38nOD89RZhWl/1y3Ul0kLEc7Q+2tV9Le/Y/MRc+GDTO8uxf8c7xk9OrSx6jMWIk+1ObYjsC7n657GJTgU10/99td7fs6IngtsHCLpZ/r5hpA4k9JTOdFicDokMLeyl3pVwa4hDNxiH9/pftOCS2j+kjYyWG3uE36oc2r9V6wXtOrS6C1/7nGOTJ8iftw8CSGpXRmbFcwpnqBxkwcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxREh6WJOwmjlJYYHdJovfL8zHh/NI8V0W9tFIlbQ/j8MpvYqT+tJadTyZBp?=
 =?us-ascii?Q?aYmwmVj7DFwLlRHNC3gVx+TXmQzPsiLAApnW+ifRzWmhFpLCSs0B8PNaA9Jk?=
 =?us-ascii?Q?TVUJ31+YGW5WEbQ0y4ZONc81Uo9CsW8CuDfm34muDCy8SNH82TwQV3J49hOr?=
 =?us-ascii?Q?W3k2/onvTOMLQZLdWK9g0Pmr0SG5gD0mRLJVWtJN5lvMQwxIXuALlpyL4KS8?=
 =?us-ascii?Q?x8eeHpvBDddcI5UPJLb+y3br78Apu7wxqbEf+OYUmDJGWwDnW6sSUtK4l6pa?=
 =?us-ascii?Q?P8BkkU+a1i94ClcASoD46lkPMQaJCF1blYAyb2eAZkpaCsILNHOTfxQ6yo9X?=
 =?us-ascii?Q?f6mIzYQGRIlpPhk+TMeUWng2HoOZSSDlrBGpBJQiyT8gwoKLm3T6DZdXJrnB?=
 =?us-ascii?Q?ySNxw3sSSlCmhotdvv37h2PkaT5wVMmH4nXFlYARuEv+Taqr09aXSVtB6vND?=
 =?us-ascii?Q?dZaWl9UMZS+citP7Ai1aq2j0FlJlDW0Am8j9kTJbNkSbcepL64ZVsvs+vzRi?=
 =?us-ascii?Q?avUlwJVmtgjnL3YwalLUGK5SbDfDhw7RtyRzo6OLWPwV59nLnMBpQJowbWzR?=
 =?us-ascii?Q?YLMYURrw39UJCMtTtiQMcKGCCT0J+ofVUGzrlKK4u2Xz/y096p0HJR2A4VDE?=
 =?us-ascii?Q?0vW4WJRTOIIFD3xGWQnshYldJ6/2Zbh6mgAsVUd2x5QrbJubSKVkkQngYe64?=
 =?us-ascii?Q?XwK/+EIb4PBapcWwU5bW0tYABPc9CV5ylZ4kViS+bhmWNivj8n91Iaw5M+6u?=
 =?us-ascii?Q?15vqvIZ0dGQ2mf3J25KauHDM+N79AbVFb27v1A1uwzN85LHSMoHH0uo073zN?=
 =?us-ascii?Q?YrnHp8SJQ2dMr3zYqDGzI/cTFx54k9RZLOJXtVcX7ZqqVyiXO9hpYbsfHG4R?=
 =?us-ascii?Q?lmvfew4f89Un6RR/OpUay+xA6R9kbV0fvygHCR1VMQkrFNlAGS/yIhT1dBE5?=
 =?us-ascii?Q?sMr/hMA+mRb8T6FIGh2+UwgNnyzeS7l/k99PcZLpW27aAZdDsticRxdEXfQr?=
 =?us-ascii?Q?wQE/psE16FnvafrGpdRZmxlCpFr5bOWeTCUutlawmb6P7U/i36awCz4H33ju?=
 =?us-ascii?Q?UHq++Bn1Sx9LcxMRdOssKgnlRS3eP9pDuI06w3PefB00O6HDHJZdT8qOAHur?=
 =?us-ascii?Q?6wQZi4pjP90tac4eAQjwRbCf5PkaJHtaeFphxt+a8xAb4MyX2k+TTQOzeTPq?=
 =?us-ascii?Q?Al5z21xgMMeQY+t+0bE88PWLDGR1T6SlKJ3bbtFYDewRYMea1CSIVOArnetJ?=
 =?us-ascii?Q?gwfWQF8RVygzzVU8Yb3vSZyDAUDJC/07OAjY/ZX/lOfOyAwsVbyZGdJudcP/?=
 =?us-ascii?Q?FbZ1Fq2sKBSEnSQl7JmZrPwmxsLLWUmYu/bF5j5YrHW1qFYjMjUrtyHN/SSV?=
 =?us-ascii?Q?/8qskmN0J88vxbQJgu3iQnOENArf7WUCgdjdkNJDJNp7HjIYJIBkAyc8dHyC?=
 =?us-ascii?Q?O722LnnoEJ+AEM3YRUtGxBPFxaBimMThp4gXCyS9Rtewsr0QtVQJ5TC7nTP5?=
 =?us-ascii?Q?x/N5v0SmSqynfdDG6VzD5QKACiP9YBOqPgi98YtEyH9EpbaX2nUc9oP4GIDJ?=
 =?us-ascii?Q?BBSsU0tw9HrpVJkyrz6xI4P7ie3XB0GxLMgMI65sFQSPRVG06zrBl+bgj7ji?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3992bb57-64d3-4e1a-b26a-08dc49c1c82f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 16:13:01.7052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Iycvi7+D49Q96UjqweCmww0xZjZORR3j2zOGtfofLWuY3cFlPkd73hrmHcXmiFrfPZ0ATnkAEFVnueOEdMUmLZngbn5b59qz6AFKfK8imc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

Adjust the SDU size based on the number of locations/channels
 that is being requested.

---
 client/player.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/client/player.c b/client/player.c
index ab33bfc46..7856be3b5 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3574,6 +3574,7 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 	struct endpoint_config *cfg = user_data;
 	char *endptr = NULL;
 	uint32_t location;
+	uint8_t channels = 1;
 
 	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
 		goto add_meta;
@@ -3590,6 +3591,13 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 	iov_append_ltv(&cfg->caps, LC3_CONFIG_CHAN_ALLOC_LEN,
 			LC3_CONFIG_CHAN_ALLOC, &location);
 
+	/* Adjust the SDU size based on the number of
+	 * locations/channels that is being requested.
+	 */
+	channels = __builtin_popcount(location);
+	if (channels > 1)
+		cfg->qos.bcast.io_qos.sdu *= channels;
+
 add_meta:
 	/* Add metadata */
 	bt_shell_prompt_input(cfg->ep->path, "Enter Metadata (value/no):",
-- 
2.39.2

