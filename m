Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061C12AAD5
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351303; cv=fail; b=FiCMo1aXqpLbAL6ufoTsQZiAt4itdSbJx26moK+w6dQYQgj7bgBL9QEYbw8b99/9JitRqScTKfIcntaebesoWHlu3/LgLXy1Mxs2K7SMoJowJRno7pz0CgApY83Ka+COrmKG7gkrtJbOe/he+oF5NzIEdZNHWFGwhQQeMy3Qli4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351303; c=relaxed/simple;
	bh=+apNrr6wfb+NB/Qpr8uQ2/JLWK4/xHgzVK0nmEsyMcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qh8qv2prkKVo6fNMzrq+1+VFkqDMG9vkEwNyNQ8Rn+ivjUZYQ6B1N50MVgRkte2HxyuaW5vCLIgQj9gwVwFYw8CJ58qO26+t1lwq5DSdqRgVa7hQuxW9fU9Y8doQLS+a6F5JidN4HxGGFE4BlyZWWv6Nyjgx/hcTAGitJsb+954=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F/Q4liAA; arc=fail smtp.client-ip=40.107.13.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F/Q4liAA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPLpQ/eVImQ6cQDz7YRk5ySGJnjyvybGHZAncXxNrt1neY6yZqZc5lntPQn/F3wcGN+z1IKPPQjwV238/6O3WzAwZadhKWqFJ0hgm7eWDJNzOCSpQk10x9Q5E5bF3dPHkkc46EP7InXeJqZqTeforijx209WJtcftvcq1NsvSY8JDlCRz5P9XxoNVEBUSxXKtBnlW6SYw37+UY1RInlr2FneBh/d4fDGpDeiaVEgCDns4qsyuULDpmGYtkDnlOiY8CiMM1mH6qqsmdVj7YqSug9eQmgAh+2tcB949bDg3UH+B3B7TSnzE5V8U0ViLB960APmulDYqcIIn7ss5rPCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49/bl5Vwdi4Dn/vQQpavibXsAPGxecfxtkp/U/2CTqs=;
 b=SXHDAx9wOxjnktrxI5PnJDqEm3uGlC0lot8GUuFD3T4Vuf8pVSnhchjaq7sM82cYB+wgvSo+/NREqCZbHlGGCB7JK3KxWvINDPXpLyvDMzcUe6lfBZblMpXGlDuLLUa4rn4n4Lnngzv5jugSU2sOlXoAhuwrgVcrZ2z4P6jwXA11EExL5HnU99BSe6ep4DmyFf0UJehe3XxLf6WPL9prcDwJ1GVt3gcjz4o958zmUiA7+xATSDYrsds5gpHXL/NZkLsUY/pw5j2vT22Bq6Ecn1kLRgeQ2PYSbMpwQTktWAjM7DmnWU8X3oh3xnK2U+SlEsEk14zh4TTTQ52pDrWsGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49/bl5Vwdi4Dn/vQQpavibXsAPGxecfxtkp/U/2CTqs=;
 b=F/Q4liAA8eK7prhqbD7CXFfbQjecHOuAVhp1LClQ9R/LY7SSYDtFTXaa0Vex3Q26pbizG3e79R7LcD59SCuoAZXKd2B3aZIytS6zhqvFYlCVbdypcTVvkFbbO/ctRUdk4bpyLhKMIdd2ioVQ/3LBEX0pZADvlmezpuhkhprOStU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9592.eurprd04.prod.outlook.com (2603:10a6:102:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 14:28:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 14:28:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/4] test-bap: Add Broadcast Source SCC tests
Date: Fri, 10 May 2024 17:27:54 +0300
Message-Id: <20240510142754.3901-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
References: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::41) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 905953c1-c06e-4f7c-5e15-08dc70fd6dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYlicFLwUmyNFl/xrCpKOpWls805dkJtD0dAmmkMX8uXIaGdsUpJINLg6j+T?=
 =?us-ascii?Q?rvu9Bp5+k3NrMxA5uymCJk1d1F5dIbZ3h/FMJPqjtXsEjm8mSEM54eaQoFfa?=
 =?us-ascii?Q?7E8ESIZuYyWqkzC80ZoBCq/KM1q4P/639e/QQpB00hF1UZ7VOuBto5tsLUQn?=
 =?us-ascii?Q?ZyzF9elrGqvULMAjOcMrWfZ53fhqJTQ3sUZA/hb/7mofIiB6KIxVmUOX/L05?=
 =?us-ascii?Q?O0In3i3RQAlrZPixMepIAtNHlEFKqjjpSdbDW0qYt2Iveh10nlIAZxdMfxoN?=
 =?us-ascii?Q?Yra2GO0w1ZfoMB6ws+jqgPyMSBNhjOV+EMflb6YNkkX5yJ11VcEzwjOfgkYU?=
 =?us-ascii?Q?5GbWe/FvghtqHGKkSS/bGIWM/MP+xCGLUQCWKUFanX/o+yEFyE1+kdRdwdSn?=
 =?us-ascii?Q?dcVdqfpIsqZiH8ZCnIk6RHGE9SmzjvudEvedrGMrBagNxgR0wDSnbCpqWMD3?=
 =?us-ascii?Q?+H9h4quY+Wlq+AqOzDUb8Wh95gvbGDgJK4SoHWfM7DjoqcrgY1bMrt7RncLZ?=
 =?us-ascii?Q?tEc3d3SGPTDQZeO5xfEeV2vKs+S5fTujhzCeaj4LP4YyQBkOB0Bkr5SSzVOG?=
 =?us-ascii?Q?KJcX+N31+a8ks/rU1eX3jlt3QbqgEQAl7zdm/yvSXK41/wtnAUZnXlr04oX/?=
 =?us-ascii?Q?bYpnYvAHlgVhSDVRcy9zO+aqcqXHOgMgNZK5RwugrqCpMpGr7lR1tSfJnYDP?=
 =?us-ascii?Q?jhX6aJ/xzxMtVKwKsiyRCGbtTHuBItKQyav4zurx/W8GbTwyZ1dBQZR11glS?=
 =?us-ascii?Q?pgAKfBvW/tywEhGEdLrojEmnV6vkKbRyq+TxsDFrOnTdKgTEQY3We/gzXAPS?=
 =?us-ascii?Q?mazpJkksuBlS2/gFnh7qANFadz5MEm08IAgkhjdN0Ovmg5qKotC4n+zN3a/I?=
 =?us-ascii?Q?/Zca4y6sF0W+L899xqiF2Dnrj7T6Q2sgSe5nR610w6oitcfrrArUhEXP4kkN?=
 =?us-ascii?Q?z5RlvSTQJAFja32ljxJvrIgVSy5Ab8meiRl5bXLX1H9WqMM6hQKPu0yLS5hg?=
 =?us-ascii?Q?ZQiXYM8lRluEaiO2H1uzmUVRSCLanP8aCFLUwSRzhJ0d9i897E2BOKQUn/FV?=
 =?us-ascii?Q?N7Ysfjy7bNtK3iU+kV5n5C/cMnG5oozss0GxnV0hoYT5ztfEimKAj3A2QoBo?=
 =?us-ascii?Q?66jFxxst6+sSFJUuuWxkXHIzbdiGdi083nsjxTW0Fu5NsKI6Kki+1UAtsg4I?=
 =?us-ascii?Q?a7r93nkaRgsJ6Lhf5rz2EqbvYZiw7Kpne82afBahfH1OxWV5/VG0Mnj4CAWQ?=
 =?us-ascii?Q?Fbq6U1tZDtDY63JK1buoC8Fza0ufgBCrk8qecD90iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MRrqAubfWBt1vE02+JhUrQyIDTgttyAdfZmE9Suf44yFDxrMN9BKfh2vm/Ve?=
 =?us-ascii?Q?XcwxbFD39XlR1+jEnYW9CvKnebO7iDVYIA+kpzenpwWAXWPkgbjAlDp66SvV?=
 =?us-ascii?Q?HoBuQduiOlu5TGk/Y7Bu6aTLBcHzZszJ1NyFIu6WHmDT3u+Hi1SVN+Y+VwRM?=
 =?us-ascii?Q?cq714r/kr5S43IdwNKM8TPaWeE3HeabVtMCEwWKCSWnt019xTkC5fkgrdkse?=
 =?us-ascii?Q?LdT5qzG9u34uTRsRxakdhgZKHb+bks0cFCtSqkL9giv8j6coa73b/JGYUyrO?=
 =?us-ascii?Q?+2jvlBzWBA0sse4dDLErUN2amVOvBeoj/KwfqCOwUSYnmNlUIAXsFIO8c/gt?=
 =?us-ascii?Q?cbrdvGkg1QR0XzVezgf6an4MKFwatxoMS9Fo6RCWd6eadWuh7GeH5E/wW2yg?=
 =?us-ascii?Q?TBGakJg0buXpS4GIkukqz70EGm76iJCxOpErlAL4axrPlnYxx5WUcE+27Jq3?=
 =?us-ascii?Q?7jQ5xMPCJXeKyeSjuk9aCv5RyFopcxQXXlmJBGEx3wr/uZGJEMeVrSZP7h/D?=
 =?us-ascii?Q?+HYawMafj/IUZTwLGvjfUgbbNMTYb/b1U7NSSAdOmEc0ZD4qzbFIrMkpVXqZ?=
 =?us-ascii?Q?lOGKcz0Jo/3mXUa0EkuD2BoicU8oKq5VstH/xF6ruRXxFo8W8tqMW792eVlO?=
 =?us-ascii?Q?Y71PZ7NwAPE2QL2etgybL5O3CjWhmS2qaZ76U6e0pP/828Izyt6RkepKEOF7?=
 =?us-ascii?Q?eCNeIKySGpDYM3mlCfD0qARXiwEQxumZf0YIGG7VsajOmj73HSMPzOl22kXd?=
 =?us-ascii?Q?wH6vTbA4itPE1uoBhxkoNzh2Az+8A6T4SfDWDdoZHL0spqyiBKxCun16o5Qa?=
 =?us-ascii?Q?TFOOCk9ltl0esguOY066sNKo2guXFTEfHFXPwMbnHiCWYIGUSmuD2oHB8+wp?=
 =?us-ascii?Q?o6oO4okRMt+/wTe4XB0X/zCTfoMWz3xX4AYO5dcRUUpxgLeywJQllzcvApvs?=
 =?us-ascii?Q?HRD3XSzMkDGeTFZ4gvXd63m4ur4a+rLWwp/qs7v3FekvsU54aRXQCptUlMlx?=
 =?us-ascii?Q?p4fMOC3IT71+uUyh/UdeAIx7B64v7+5P0TciOkOVya5lDIjNthui/9rruUR+?=
 =?us-ascii?Q?lLsR9noJMD8wlHrGhSIieLwltRn9fk4EuHkhp91JXaXHHB6hFR18vM779/f3?=
 =?us-ascii?Q?QagMfSSsMU7eFulNFMuVZbJJI5D2E/yjL+jS2c0sNXdLW9D9/dZnkiR8Gc5a?=
 =?us-ascii?Q?yp8ZKhXngK2f2aYc+7gi+xkfUQDNDSfxDTxor+p6DVlPtOe0KitvOGeZumlx?=
 =?us-ascii?Q?UnIPIeSKyV7z3/3s3FG8qipV3LUVI8GZS2jLvedQH/jW0YIrNLSLSowyPQBq?=
 =?us-ascii?Q?/dBnxbkyLpCCVV2fdNi7CAzdYsJySXfPC2czulRcfTCOAViorf6jqFZ0T7HX?=
 =?us-ascii?Q?FnfJOaUDFu7t/5hDtPFOmRmj8JOShRQ3c9puYWZdU1b6RFjCPsLtAAVe0NLn?=
 =?us-ascii?Q?CrYSi9OaWdl7huPI3Z6VkfM7UZlyM4XXNTU7nzq2pnon/rsJP1C5wDRNRlBw?=
 =?us-ascii?Q?JCFTzFAV1wkEioLd4JvffFqJHo67J2PCxyQVlyn5d7tKQkyF///YdWW/EO/Z?=
 =?us-ascii?Q?Dg9RB0HtvYVbvWSyDkx3Nw0mcJ74cRGBuffBL6bSgy5UIKpJP+oDh7S1cS3R?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905953c1-c06e-4f7c-5e15-08dc70fd6dc9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:28:15.2123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fR47cs+ypbaA7zjBzpN2xZM/aYUIgrzT8Yuz7+SxGzzxmyqVD+7uKj6d45y3Z8CPk847hORrZH23NYhzOpPgWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9592

4.13.1 Broadcast Source Configures Broadcast Audio Stream (page 172):

    Test Purpose:
    Verify that a Broadcast Source IUT can configure a broadcast Audio
    Stream with information defined by the values in its BASE structure.

    Test Case Configuration:
    BAP/BSRC/SCC/BV-01-C [Config Broadcast, LC3 8_1_1]
    BAP/BSRC/SCC/BV-02-C [Config Broadcast, LC3 8_2_1]
    BAP/BSRC/SCC/BV-03-C [Config Broadcast, LC3 16_1_1]
    BAP/BSRC/SCC/BV-04-C [Config Broadcast, LC3 16_2_1]
    BAP/BSRC/SCC/BV-05-C [Config Broadcast, LC3 24_1_1]
    BAP/BSRC/SCC/BV-06-C [Config Broadcast, LC3 24_2_1]
    BAP/BSRC/SCC/BV-07-C [Config Broadcast, LC3 32_1_1]
    BAP/BSRC/SCC/BV-08-C [Config Broadcast, LC3 32_2_1]
    BAP/BSRC/SCC/BV-09-C [Config Broadcast, LC3 44.1_1_1]
    BAP/BSRC/SCC/BV-10-C [Config Broadcast, LC3 44.1_2_1]
    BAP/BSRC/SCC/BV-11-C [Config Broadcast, LC3 48_1_1]
    BAP/BSRC/SCC/BV-12-C [Config Broadcast, LC3 48_2_1]
    BAP/BSRC/SCC/BV-13-C [Config Broadcast, LC3 48_3_1]
    BAP/BSRC/SCC/BV-14-C [Config Broadcast, LC3 48_4_1]
    BAP/BSRC/SCC/BV-15-C [Config Broadcast, LC3 48_5_1]
    BAP/BSRC/SCC/BV-16-C [Config Broadcast, LC3 48_6_1]
    BAP/BSRC/SCC/BV-17-C [Config Broadcast, LC3 8_1_2]
    BAP/BSRC/SCC/BV-18-C [Config Broadcast, LC3 8_2_2]
    BAP/BSRC/SCC/BV-19-C [Config Broadcast, LC3 16_1_2]
    BAP/BSRC/SCC/BV-20-C [Config Broadcast, LC3 16_2_2]
    BAP/BSRC/SCC/BV-21-C [Config Broadcast, LC3 24_1_2]
    BAP/BSRC/SCC/BV-22-C [Config Broadcast, LC3 24_2_2]
    BAP/BSRC/SCC/BV-23-C [Config Broadcast, LC3 32_1_2]
    BAP/BSRC/SCC/BV-24-C [Config Broadcast, LC3 32_2_2]
    BAP/BSRC/SCC/BV-25-C [Config Broadcast, LC3 44.1_1_2]
    BAP/BSRC/SCC/BV-26-C [Config Broadcast, LC3 44.1_2_2]
    BAP/BSRC/SCC/BV-27-C [Config Broadcast, LC3 48_1_2]
    BAP/BSRC/SCC/BV-28-C [Config Broadcast, LC3 48_2_2]
    BAP/BSRC/SCC/BV-29-C [Config Broadcast, LC3 48_3_2]
    BAP/BSRC/SCC/BV-30-C [Config Broadcast, LC3 48_4_2]
    BAP/BSRC/SCC/BV-31-C [Config Broadcast, LC3 48_5_2]
    BAP/BSRC/SCC/BV-32-C [Config Broadcast, LC3 48_6_2]
    BAP/BSRC/SCC/BV-33-C [Config Broadcast, VS]

    Pass verdict:
    The AdvData field of AUX_SYNC_IND and optionally
    AUX_CHAIN_IND PDUs contains the configured BASE information.

Test Summary
------------
BAP/BSRC/SCC/BV-01-C [Config Broadcast, LC3 8_1_1]   Passed
BAP/BSRC/SCC/BV-02-C [Config Broadcast, LC3 8_2_1]   Passed
BAP/BSRC/SCC/BV-03-C [Config Broadcast, LC3 16_1_1]  Passed
BAP/BSRC/SCC/BV-04-C [Config Broadcast, LC3 16_2_1]  Passed
BAP/BSRC/SCC/BV-05-C [Config Broadcast, LC3 24_1_1]  Passed
BAP/BSRC/SCC/BV-06-C [Config Broadcast, LC3 24_2_1]  Passed
BAP/BSRC/SCC/BV-07-C [Config Broadcast, LC3 32_1_1]  Passed
BAP/BSRC/SCC/BV-08-C [Config Broadcast, LC3 32_2_1]  Passed
BAP/BSRC/SCC/BV-09-C [Config Broadcast, LC3 44.1_1_1] Passed
BAP/BSRC/SCC/BV-09-C [Config Broadcast, LC3 44.1_2_1] Passed
BAP/BSRC/SCC/BV-11-C [Config Broadcast, LC3 48_1_1]  Passed
BAP/BSRC/SCC/BV-12-C [Config Broadcast, LC3 48_2_1]  Passed
BAP/BSRC/SCC/BV-13-C [Config Broadcast, LC3 48_3_1]  Passed
BAP/BSRC/SCC/BV-14-C [Config Broadcast, LC3 48_4_1]  Passed
BAP/BSRC/SCC/BV-15-C [Config Broadcast, LC3 48_5_1]  Passed
BAP/BSRC/SCC/BV-16-C [Config Broadcast, LC3 48_6_1]  Passed
BAP/BSRC/SCC/BV-17-C [Config Broadcast, LC3 8_1_2]   Passed
BAP/BSRC/SCC/BV-18-C [Config Broadcast, LC3 8_2_2]   Passed
BAP/BSRC/SCC/BV-19-C [Config Broadcast, LC3 16_1_2]  Passed
BAP/BSRC/SCC/BV-20-C [Config Broadcast, LC3 16_2_2]  Passed
BAP/BSRC/SCC/BV-21-C [Config Broadcast, LC3 24_1_2]  Passed
BAP/BSRC/SCC/BV-22-C [Config Broadcast, LC3 24_2_2]  Passed
BAP/BSRC/SCC/BV-23-C [Config Broadcast, LC3 32_1_2]  Passed
BAP/BSRC/SCC/BV-24-C [Config Broadcast, LC3 32_2_2]  Passed
BAP/BSRC/SCC/BV-25-C [Config Broadcast, LC3 44.1_1_2] Passed
BAP/BSRC/SCC/BV-26-C [Config Broadcast, LC3 44.1_2_2] Passed
BAP/BSRC/SCC/BV-27-C [Config Broadcast, LC3 48_1_2]  Passed
BAP/BSRC/SCC/BV-28-C [Config Broadcast, LC3 48_2_2]  Passed
BAP/BSRC/SCC/BV-29-C [Config Broadcast, LC3 48_3_2]  Passed
BAP/BSRC/SCC/BV-30-C [Config Broadcast, LC3 48_4_2]  Passed
BAP/BSRC/SCC/BV-31-C [Config Broadcast, LC3 48_5_2]  Passed
BAP/BSRC/SCC/BV-32-C [Config Broadcast, LC3 48_6_2]  Passed
BAP/BSRC/SCC/BV-33-C [Config Broadcast, VS]          Passed
---
 unit/test-bap.c | 585 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 585 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index c6b3a2b47..ac9d7ff38 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -36,6 +36,7 @@
 struct test_config {
 	struct bt_bap_pac_qos pqos;
 	struct iovec cc;
+	struct iovec base;
 	struct bt_bap_qos qos;
 	bool snk;
 	bool src;
@@ -50,6 +51,8 @@ struct test_data {
 	struct bt_bap *bap;
 	struct bt_bap_pac *snk;
 	struct bt_bap_pac *src;
+	struct bt_bap_pac *bsrc;
+	struct iovec *base;
 	struct iovec *caps;
 	struct test_config *cfg;
 	struct bt_bap_stream *stream;
@@ -509,6 +512,93 @@ static void test_client(const void *user_data)
 	bt_bap_attach(data->bap, data->client);
 }
 
+static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
+			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
+			void *user_data)
+{
+	cb(stream, 0);
+
+	return 0;
+}
+
+static struct bt_bap_pac_ops bcast_pac_ops = {
+	.config = pac_config,
+};
+
+static void bsrc_pac_added(struct bt_bap_pac *pac, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	bt_bap_pac_set_ops(pac, &bcast_pac_ops, NULL);
+
+	data->stream = bt_bap_stream_new(data->bap, pac, NULL,
+						&data->cfg->qos,
+						&data->cfg->cc);
+	g_assert(data->stream);
+
+	bt_bap_stream_config(data->stream, &data->cfg->qos,
+					&data->cfg->cc, NULL, data);
+}
+
+static void bsrc_state(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_QOS:
+		bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_CONFIG:
+		data->base = bt_bap_stream_get_base(stream);
+
+		g_assert(data->base);
+		g_assert(data->base->iov_len == data->cfg->base.iov_len);
+		g_assert(memcmp(data->base->iov_base, data->cfg->base.iov_base,
+				data->base->iov_len) == 0);
+
+		bt_bap_stream_start(stream, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		tester_test_passed();
+		break;
+	}
+}
+
+static void test_bsrc(const void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	data->db = gatt_db_new();
+	g_assert(data->db);
+
+	data->bap = bt_bap_new(data->db, data->db);
+	g_assert(data->bap);
+
+	bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
+
+	bt_bap_attach_broadcast(data->bap);
+
+	bt_bap_state_register(data->bap, bsrc_state,
+					NULL, data, NULL);
+
+	bt_bap_pac_register(data->bap, bsrc_pac_added,
+					NULL, data, NULL);
+
+	if (data->cfg->vs)
+		data->bsrc = bt_bap_add_vendor_pac(data->db,
+						"test-bap-bsrc",
+						BT_BAP_BCAST_SOURCE, 0x0ff,
+						0x0000, 0x0000,
+						NULL, data->caps, NULL);
+	else
+		data->bsrc = bt_bap_add_pac(data->db, "test-bap-bsrc",
+						BT_BAP_BCAST_SOURCE, LC3_ID,
+						NULL, data->caps, NULL);
+
+	g_assert(data->bsrc);
+}
+
 static void test_teardown(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
@@ -517,8 +607,11 @@ static void test_teardown(const void *user_data)
 	bt_gatt_client_unref(data->client);
 	util_iov_free(data->iov, data->iovcnt);
 
+	util_iov_free(data->base, 1);
+
 	bt_bap_remove_pac(data->snk);
 	bt_bap_remove_pac(data->src);
+	bt_bap_remove_pac(data->bsrc);
 	gatt_db_unref(data->db);
 
 	tester_teardown_complete();
@@ -5381,12 +5474,504 @@ static void test_scc(void)
 	test_str_1_1_1_lc3();
 }
 
+#define LC3_CFG(_freq, _dur, _len) \
+	0x0a, \
+	0x02, 0x01, _freq, \
+	0x02, 0x02, _dur, \
+	0x03, 0x04, _len, _len >> 8
+
+#define BASE(_pd, _sgrp, _nbis, _cfg...) \
+	_pd & 0xff, _pd >> 8, _pd >> 16, \
+	_sgrp, \
+	_nbis, \
+	_cfg
+
+#define BASE_LC3(_pd, _sgrp, _nbis, _cc...) \
+	BASE(_pd, _sgrp, _nbis, 0x06, 0x00, 0x00, 0x00, 0x00, _cc)
+
+#define LC3_CFG_8_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_8KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_8_1)
+
+#define BASE_LC3_8_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_8_1, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_8_1_1 = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = LC3_QOS_8_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
+};
+
+static struct test_config cfg_bsrc_8_1_2 = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = LC3_QOS_8_1_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_1),
+};
+
+#define LC3_CFG_8_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_8KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_8_2)
+
+#define BASE_LC3_8_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_8_2, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_8_2_1 = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = LC3_QOS_8_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
+};
+
+static struct test_config cfg_bsrc_8_2_2 = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = LC3_QOS_8_2_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_2),
+};
+
+#define LC3_CFG_16_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_16KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_16_1)
+
+#define BASE_LC3_16_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_16_1, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_16_1_1 = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = LC3_QOS_16_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
+};
+
+static struct test_config cfg_bsrc_16_1_2 = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = LC3_QOS_16_1_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_1),
+};
+
+#define LC3_CFG_16_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_16KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_16_2)
+
+#define BASE_LC3_16_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_16_2, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_16_2_1 = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
+};
+
+static struct test_config cfg_bsrc_16_2_2 = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_2),
+};
+
+#define LC3_CFG_24_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_24KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_24_1)
+
+#define BASE_LC3_24_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_24_1, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_24_1_1 = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = LC3_QOS_24_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
+};
+
+static struct test_config cfg_bsrc_24_1_2 = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = LC3_QOS_24_1_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_1),
+};
+
+#define LC3_CFG_24_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_24KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_24_2)
+
+#define BASE_LC3_24_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_24_2, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_24_2_1 = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = LC3_QOS_24_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
+};
+
+static struct test_config cfg_bsrc_24_2_2 = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = LC3_QOS_24_2_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_2),
+};
+
+#define LC3_CFG_32_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_32KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_32_1)
+
+#define BASE_LC3_32_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_32_1, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_32_1_1 = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = LC3_QOS_32_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
+};
+
+static struct test_config cfg_bsrc_32_1_2 = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = LC3_QOS_32_1_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_1),
+};
+
+#define LC3_CFG_32_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_32KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_32_2)
+
+#define BASE_LC3_32_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_32_2, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_32_2_1 = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = LC3_QOS_32_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
+};
+
+static struct test_config cfg_bsrc_32_2_2 = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = LC3_QOS_32_2_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_2),
+};
+
+#define LC3_CFG_44_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_44KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_44_1)
+
+#define BASE_LC3_44_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_44_1, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_44_1_1 = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = LC3_QOS_44_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
+};
+
+static struct test_config cfg_bsrc_44_1_2 = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = LC3_QOS_44_1_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_1),
+};
+
+#define LC3_CFG_44_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_44KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_44_2)
+
+#define BASE_LC3_44_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_44_2, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_44_2_1 = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = LC3_QOS_44_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
+};
+
+static struct test_config cfg_bsrc_44_2_2 = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = LC3_QOS_44_2_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_2),
+};
+
+#define LC3_CFG_48_1 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_48_1)
+
+#define BASE_LC3_48_1 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_1, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_48_1_1 = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = LC3_QOS_48_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
+};
+
+static struct test_config cfg_bsrc_48_1_2 = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = LC3_QOS_48_1_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_1),
+};
+
+#define LC3_CFG_48_2 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_48_2)
+
+#define BASE_LC3_48_2 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_2, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_48_2_1 = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = LC3_QOS_48_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
+};
+
+static struct test_config cfg_bsrc_48_2_2 = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = LC3_QOS_48_2_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_2),
+};
+
+#define LC3_CFG_48_3 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_48_3)
+
+#define BASE_LC3_48_3 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_3, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_48_3_1 = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = LC3_QOS_48_3_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
+};
+
+static struct test_config cfg_bsrc_48_3_2 = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = LC3_QOS_48_3_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_3),
+};
+
+#define LC3_CFG_48_4 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_48_4)
+
+#define BASE_LC3_48_4 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_4, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_48_4_1 = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = LC3_QOS_48_4_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
+};
+
+static struct test_config cfg_bsrc_48_4_2 = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = LC3_QOS_48_4_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_4),
+};
+
+#define LC3_CFG_48_5 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_7_5, \
+		LC3_CONFIG_FRAME_LEN_48_5)
+
+#define BASE_LC3_48_5 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_5, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_48_5_1 = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = LC3_QOS_48_5_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
+};
+
+static struct test_config cfg_bsrc_48_5_2 = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = LC3_QOS_48_5_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_5),
+};
+
+#define LC3_CFG_48_6 \
+	LC3_CFG(LC3_CONFIG_FREQ_48KHZ, \
+		LC3_CONFIG_DURATION_10, \
+		LC3_CONFIG_FRAME_LEN_48_6)
+
+#define BASE_LC3_48_6 \
+	BASE_LC3(40000, 1, 1, LC3_CFG_48_6, 0x00, 0x01, 0x00)
+
+static struct test_config cfg_bsrc_48_6_1 = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = LC3_QOS_48_6_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
+};
+
+static struct test_config cfg_bsrc_48_6_2 = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = LC3_QOS_48_6_2_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_6),
+};
+
+#define VS_CC \
+	0x02, 0x01, 0x08, \
+	0x02, 0x02, 0x00, \
+	0x05, 0x03, 0x01, 0x00, 0x00, 0x00, \
+	0x03, 0x04, 0x75, 0x00
+
+#define VS_CFG \
+	0x10, \
+	VS_CC
+
+#define BASE_VS \
+	BASE(40000, 1, 1, 0xFF, 0x00, 0x00, 0x00, 0x00, \
+	VS_CFG, 0x00, 0x01, 0x00)
+
+#define QOS_BCAST \
+{ \
+	.bcast.big = 0x00, \
+	.bcast.bis = 0x00, \
+	.bcast.framing = LC3_QOS_UNFRAMED, \
+	.bcast.delay = 40000, \
+	.bcast.io_qos.interval = 7500, \
+	.bcast.io_qos.latency = 10, \
+	.bcast.io_qos.sdu = 40, \
+	.bcast.io_qos.phy = BT_BAP_CONFIG_PHY_2M, \
+	.bcast.io_qos.rtn = 2, \
+}
+
+static struct test_config cfg_bsrc_vs = {
+	.cc = UTIL_IOV_INIT(VS_CC),
+	.qos = QOS_BCAST,
+	.base = UTIL_IOV_INIT(BASE_VS),
+	.vs = true,
+};
+
+/* Test Purpose:
+ * Verify that a Broadcast Source IUT can configure a broadcast
+ * Audio Stream with information defined by the values in its BASE
+ * structure. The verification is performed one Codec Setting and
+ * set of parameters at a time, as enumerated in the test cases in
+ * Table 4.73.
+ *
+ * Pass verdict:
+ * In step 2, the AdvData field of AUX_SYNC_IND and optionally
+ * AUX_CHAIN_IND PDUs contains the configured BASE information.
+ *
+ * In step 3, the IUT transmits the PA synchronization information in
+ * the SyncInfo field of the Extended Header field of AUX_ADV_IND PDUs.
+ * The AUX_ADV_IND PDUs include the Service Data AD Type in the AdvData
+ * field with the Service UUID equal to the Broadcast Audio Announcement
+ * Service UUID. The additional service data includes Broadcast_ID.
+ *
+ * Each value included in the Codec_Specific_Configuration is formatted in
+ * an LTV structure with the length, type, and value specified in Table 4.74.
+ */
+static void test_bsrc_scc(void)
+{
+	define_test("BAP/BSRC/SCC/BV-01-C [Config Broadcast, LC3 8_1_1]",
+		NULL, test_bsrc, &cfg_bsrc_8_1_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-02-C [Config Broadcast, LC3 8_2_1]",
+		NULL, test_bsrc, &cfg_bsrc_8_2_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-03-C [Config Broadcast, LC3 16_1_1]",
+		NULL, test_bsrc, &cfg_bsrc_16_1_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-04-C [Config Broadcast, LC3 16_2_1]",
+		NULL, test_bsrc, &cfg_bsrc_16_2_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-05-C [Config Broadcast, LC3 24_1_1]",
+		NULL, test_bsrc, &cfg_bsrc_24_1_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-06-C [Config Broadcast, LC3 24_2_1]",
+		NULL, test_bsrc, &cfg_bsrc_24_2_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-07-C [Config Broadcast, LC3 32_1_1]",
+		NULL, test_bsrc, &cfg_bsrc_32_1_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-08-C [Config Broadcast, LC3 32_2_1]",
+		NULL, test_bsrc, &cfg_bsrc_32_2_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-09-C [Config Broadcast, LC3 44.1_1_1]",
+		NULL, test_bsrc, &cfg_bsrc_44_1_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-10-C [Config Broadcast, LC3 44.1_2_1]",
+		NULL, test_bsrc, &cfg_bsrc_44_2_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-11-C [Config Broadcast, LC3 48_1_1]",
+		NULL, test_bsrc, &cfg_bsrc_48_1_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-12-C [Config Broadcast, LC3 48_2_1]",
+		NULL, test_bsrc, &cfg_bsrc_48_2_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-13-C [Config Broadcast, LC3 48_3_1]",
+		NULL, test_bsrc, &cfg_bsrc_48_3_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-14-C [Config Broadcast, LC3 48_4_1]",
+		NULL, test_bsrc, &cfg_bsrc_48_4_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-15-C [Config Broadcast, LC3 48_5_1]",
+		NULL, test_bsrc, &cfg_bsrc_48_5_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-16-C [Config Broadcast, LC3 48_6_1]",
+		NULL, test_bsrc, &cfg_bsrc_48_6_1, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-17-C [Config Broadcast, LC3 8_1_2]",
+		NULL, test_bsrc, &cfg_bsrc_8_1_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-18-C [Config Broadcast, LC3 8_2_2]",
+		NULL, test_bsrc, &cfg_bsrc_8_2_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-19-C [Config Broadcast, LC3 16_1_2]",
+		NULL, test_bsrc, &cfg_bsrc_16_1_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-20-C [Config Broadcast, LC3 16_2_2]",
+		NULL, test_bsrc, &cfg_bsrc_16_2_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-21-C [Config Broadcast, LC3 24_1_2]",
+		NULL, test_bsrc, &cfg_bsrc_24_1_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-22-C [Config Broadcast, LC3 24_2_2]",
+		NULL, test_bsrc, &cfg_bsrc_24_2_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-23-C [Config Broadcast, LC3 32_1_2]",
+		NULL, test_bsrc, &cfg_bsrc_32_1_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-24-C [Config Broadcast, LC3 32_2_2]",
+		NULL, test_bsrc, &cfg_bsrc_32_2_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-25-C [Config Broadcast, LC3 44.1_1_2]",
+		NULL, test_bsrc, &cfg_bsrc_44_1_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-26-C [Config Broadcast, LC3 44.1_2_2]",
+		NULL, test_bsrc, &cfg_bsrc_44_2_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-27-C [Config Broadcast, LC3 48_1_2]",
+		NULL, test_bsrc, &cfg_bsrc_48_1_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-28-C [Config Broadcast, LC3 48_2_2]",
+		NULL, test_bsrc, &cfg_bsrc_48_2_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-29-C [Config Broadcast, LC3 48_3_2]",
+		NULL, test_bsrc, &cfg_bsrc_48_3_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-30-C [Config Broadcast, LC3 48_4_2]",
+		NULL, test_bsrc, &cfg_bsrc_48_4_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-31-C [Config Broadcast, LC3 48_5_2]",
+		NULL, test_bsrc, &cfg_bsrc_48_5_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-32-C [Config Broadcast, LC3 48_6_2]",
+		NULL, test_bsrc, &cfg_bsrc_48_6_2, IOV_NULL);
+
+	define_test("BAP/BSRC/SCC/BV-33-C [Config Broadcast, VS]",
+		NULL, test_bsrc, &cfg_bsrc_vs, IOV_NULL);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
 
 	test_disc();
 	test_scc();
+	test_bsrc_scc();
 
 	return tester_run();
 }
-- 
2.39.2

