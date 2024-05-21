Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966D1E525
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288946; cv=fail; b=amFqZcPPkdttSmmddBqTke6JFPNwZPtciXbHuCcdH1hUtkWI7MrTSQoLVLY/pgzG4R87dDB9lIJeSjRuWcWLnFB2u3bYaPVeqXEslx0op0fyFr+7AWvbIYydCUsxupqgl+VWrOxJKUJVH+EVnB0l0DKoA/tvpo1JxxP9q19u/yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288946; c=relaxed/simple;
	bh=B6E1kPa5YPrHo+SIswFLj/vU1g7PsGMwV8fQd+xweBA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HHSq/WLc1BygIGNZdZkgihb9qKV6/ht9OxS0l9OfDMPgAsiD84CpCNd3XORcaYv0TKB4GVuq/2BVggUhDfDINihFWRSQRBa7mRT0yRtkbtIzVxGTN3pd2D6xTN1Bvr3JDQurBf2jUYHE3mIhqdjwkxluafuM1juy6sTCzSFCzYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yy1SyqWj; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yy1SyqWj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJac/Uk+ANZn31u0y34uhNGEZier1Wjaazk+CsKobTj+3CPxlupocy9frnGacGih53AZcoxi/UgPD1cGV5uyol4BqCS1KZjpP+lYo4cmt7SB3bkwvTJN6FNB1FAtHNkkCJGDuTGXAJ/M0fYHrwpY7scClnLmLCfl4QeOPezMmR+kgsJcAR4+0LkNXItmJfTG7oewKW3FNO2I76n8adCCPiUTBEEXb6EP/OcOALMbIhoBgvixy7RZQ4TeWl95IDvohhmVeXKmut/brnsH9gugyWwijijsm1xftAca6XqrgyTlXRf0dc9FD++wMZD7im+0PIWlU+VclI5DmgJK8+nPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9+ChHXR38Qev3Fumjr1N1p4ZJaGCqGMV3HddIy0NFw=;
 b=dCVWGChTk0yMmnhwxQWWDTfsS5YbusWMZnFVEdX/9o+B4g/qTr+KluMN6/XKxlRY74FkyXEFIHclsjJBjJLeIqChvRSvDXUs5K0x+DIpDbYSb+kQrEiRvKoVWWktS6JGrIj9G0CyCKaAfbekCi9jAgW46p0cY/CCzcMF83D87I0Q+zayckyxqDuX6MsX4xpet+Qz8KM1lUQEHGCKakeU4sOIPR9o6L/ZjzKmhKNgUhY0+ddHuXolf7fbn6wY5Bw/BlaO83/eNCvo1HPIdvrHOTwNSlK0ngUGlCg4bjSqWDSqpFvFyEXECxOvSZnRxwWn2zb3FhdC3E5h4dH/xdT0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9+ChHXR38Qev3Fumjr1N1p4ZJaGCqGMV3HddIy0NFw=;
 b=Yy1SyqWjHYhLPqYBYaifs+K9NWA+nuDvvds0Tgml6xa0sQwA8+yAe9rKmcb3m0vK6WxVz5Wc/9S1tJ9UGxnmST41M6NwlasWXaUtqU5wGjbh3jdHaTOzmsjds1kLfW6mXEHm2tBcYxJ6WNaTrhuLT+Tjrh6Lksf8bWy5Dc4vSYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10947.eurprd04.prod.outlook.com (2603:10a6:150:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 10:55:41 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:55:41 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] test-bap: Add Broadcast Sink STR MBIS tests
Date: Tue, 21 May 2024 13:55:12 +0300
Message-Id: <20240521105515.103972-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0027.eurprd03.prod.outlook.com
 (2603:10a6:208:14::40) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10947:EE_
X-MS-Office365-Filtering-Correlation-Id: b2500685-971f-4441-565d-08dc79848ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQAweVhquJCqQ1ZzVWrtGxTOqW3a0uaStQcQ8+HTu7T5PiGCrbbKzYOkwCeh?=
 =?us-ascii?Q?uhJSmfRTqbqu6YknrphvFm9EixhFIyDcI8W3JmDffKsaZu/JHBAfth/yZzpS?=
 =?us-ascii?Q?5daO9jAhmaCoFfpqHM1HxTX5h802MOCPSs8QAS1xlVnz1Cuz5gf4PV9syje3?=
 =?us-ascii?Q?jvQ7iioOcOSV0m7qNpWCxgu7+NKYw0YPO1UbItFJWKoQycK4axtT2D2l6iC6?=
 =?us-ascii?Q?jXg7VNKyL8jJ9jUY6l4jkA9oemMTbmP+atImdWn4lICh61+DaRE98FgrILhE?=
 =?us-ascii?Q?8u0XHaHPC5hxQG9X9McHpSM5ROVIjZv6/Wbr/+iLdS7gSOWhzW0NfQgv/vmU?=
 =?us-ascii?Q?WI7lDJ2zNhJGjGwuBS5+7gnQIJ4oZzJbn55rAhD49v3zOPCJeEUZMXdZh3y1?=
 =?us-ascii?Q?2TX4hZ/4M//5w/fisJ2QZDmEd9zwyAYGbakR3uf3gEn22EFRquWidOCEG6Et?=
 =?us-ascii?Q?Ik6OYty5Z24UvjBuPhOhHtjAOXx/gnRsp7kEt2VuvO/qTu2/3g/I6OVhMunC?=
 =?us-ascii?Q?cZ7GXxA1VOTl9Ofhi0w3tNdEcOQxAywG8RtegjbzWpny7L6KZc1TcUsgdssm?=
 =?us-ascii?Q?qEKKC6RS0TcbW8IS1Kf9CCr+I9cNC6lwogOYFykuxzYS50xH/edaoUzfviGz?=
 =?us-ascii?Q?ATb2QhOyTcehAyl9pDOCzWefC8LAHGPUSvpg/97HDUxh5NRFFsvnYyfQfzKh?=
 =?us-ascii?Q?Cw6WgHXugrRVo7ShxGwwiFqAyPwK5bC/EWCOR7FW+dxgUqUXtXbK6c5VJvfA?=
 =?us-ascii?Q?1dBaJDpdX739uZM53fdynka88mWwhxz6vEHr+Ty/KGM2rpVENbAsOUT9zMtg?=
 =?us-ascii?Q?Gl+rx3z8g5RyvMyAg7S6ZIujnE9mgGJCfKUNs+e0j5T2lLOvfhk63WLKFW0t?=
 =?us-ascii?Q?RjHJdoe0Z6yPAgtSHH+YHSrqLlqdIRJ1pyQFZg0epybzsYW9ndxcyEdj+3CO?=
 =?us-ascii?Q?ms+XqHVgEiwY/YKw07gu7D40gRQofvt7YSZtZc/v8cI2J8yjlczc/20Y14XT?=
 =?us-ascii?Q?q1guerpBS+HOKItA1b8OhbhWBikW8IFiOYuFgwajyDIaG2Iy3gJlSBdvAaw9?=
 =?us-ascii?Q?1s6P5s3WZ50qN3fy3C7JgGDJmnuBrtKRtwvsLGSv27PUMhqfMVrc8oajKNlc?=
 =?us-ascii?Q?JBep6KO4csKhMVizT1jKyydKbhnmx9QeDQvjv30T+ZVBlWWbqLUU8xptScyL?=
 =?us-ascii?Q?7tu0GtpbWqjx/T75Rxz38xOYt+21eUEibZTj2mTkta7nH8T03/DHF1hYAOSb?=
 =?us-ascii?Q?7+iexCJ6sLHDOsqUWttFJ67BmBIcbBhkPI1VPO+mHg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mKO8afveWUgerbj4u/cC7fy9y8zLDhBTLueAV6ESMyrkhFUUkruW0hDIoI7I?=
 =?us-ascii?Q?xtM6OifmAFWJS+sy3WQRxECG0Sxokd22AU0kzHTKV/CAja4ZiJKK3hBSnjQ6?=
 =?us-ascii?Q?6M3RO+Z6kncWYVKFqP5nLeuP/Sf590+26w6KX+cEEfeb3l7w99RM5d4FMVtQ?=
 =?us-ascii?Q?fi3/bD4KnNgbz+QgrUlTGxtEUN6CbVO7xiC74i4Fl25pvP+FPE0ssWs3ySft?=
 =?us-ascii?Q?DZ48QIizBHXF3FC4DpdC0O5xOU+I6bdwsN7L7MI4FzK4pap416O6nruAfbNN?=
 =?us-ascii?Q?Bcx5nWNHMcwr+tb/1n780DiTNAfxvkE0hGnFznyStuG+B3Cg8Aek1w3U/KK1?=
 =?us-ascii?Q?5nRJP79lRthLKeL0KDEmrkGWgjKfs5ZWHjxylbgxMno3duZJU+Z8+zps0WWH?=
 =?us-ascii?Q?LZHFRePhJUOHZhHuUw7Ss76WmEtjnjbdYjubP/1ZVJ0xoqAk/7g/+C6fUjKz?=
 =?us-ascii?Q?/TgzNTt4t6MuNYzFHZg9xmULRdf5Jf6pL7lg/36NeLY+0wVLNm9oee4epMPG?=
 =?us-ascii?Q?Utbbefpez8JBtSFvkbyqt+UteTgGend//QC7Ce+5swsLYo6uaIlUF0/WDAvn?=
 =?us-ascii?Q?iCQAkseKcww5lY/BD6YiBm7jQzVo/psYLKKl4Ua8vh8hN/g5C8OU68oxG/7V?=
 =?us-ascii?Q?M1oAOg33gyMw4udzoQLtyv7Q9wzs7XCirclHN7O33snS1M3Ba0fENBtGODIa?=
 =?us-ascii?Q?b8zck8Ye7MyujVSOqp3NBeeq2I/m6E3pHFWtvT9beGPzxZ/uetqMI1odoZQ2?=
 =?us-ascii?Q?W4hYpLxpnU2wS41sMT6JCJJ2sLZSmSFHpuzFalgQqpQh97RDlIzOVku0XC6u?=
 =?us-ascii?Q?WXXjHN/vNg004aM9eOi9JQ9c89nT1LJdFe8yjso/YPw4CaVvImrIjhXk1Enj?=
 =?us-ascii?Q?znDQGh+HLd2eFnv2JYo2tIGhVKcxxwDkJ97vDh6NmrEL7Zi2S6rI8Rsg5sj1?=
 =?us-ascii?Q?RiLGMDCzA2jVJHmdeoPu4aop9pxrC2w5SIF7n71JeCxY50XlRR57IJ0fAXK+?=
 =?us-ascii?Q?VuDQfz7qjYLGqrc6tWyvMUtWgSzQzvPXj2xWm6HwTw3IMloTF5QqeS9wy7Lx?=
 =?us-ascii?Q?BN9VccqTA6gTD98mTN41tGEAgsvwZZ6HbJz0kmwsSgf7cW6X5ng7/pqJbdVm?=
 =?us-ascii?Q?N9JoY8Gwc7p9WcwfC1tA7N/8WsccnFyX7o5LHAeQbBhJx7+iUep2QSKuLb4N?=
 =?us-ascii?Q?B3KqTUSbj8YOWx0ISRDOqhkqNnJopIwJczwiMFDBaAcNaZ9S0rlAIJ83cueG?=
 =?us-ascii?Q?vkQIifP+7GWOcGKk0ZlKkvDaUEQ+rEz1w/eb8uPJhmIYsVAkWsUwitoeUt1w?=
 =?us-ascii?Q?w7mq4OeMrW2sn8uC0nX9Sk4/8qtFqdxYacbywkNC9JSus0DxwAIxuSi4sOaf?=
 =?us-ascii?Q?EFARHrJd8W2bPMf34SgyvqzYfWhaxdYCb8spJi2oM7xS9jeNxFenB1J0aZ97?=
 =?us-ascii?Q?OvL+T5adNifjPZDvMR4yOxyHnsYcvJyg7QC4JqeeSuaWnf0hNcqA1/1U3/xZ?=
 =?us-ascii?Q?KyObGvBlQqPgVzh+3Fz1MmHMBh0WyAQsKS/+1Z1qDh2hA43FgCoqROIuAxWD?=
 =?us-ascii?Q?Rewpp3Id6KfJvVY/PEqWCtkXNr0Y4dQVT+tRySjMTo1Dk6xvNbMvmCZqV272?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2500685-971f-4441-565d-08dc79848ea1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 10:55:41.6138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HVBOLrNxiHjdUFIu48H3BcPS9lvzPCJojvopj/BxuuAphs/c+zn8XHJlo30/GdYK+xNz2rDGi52OrEML+tn8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10947

This patch adds BAP unit tests for Broadcast Sink Streaming with multiple
BISes (4.14.4 Broadcast Sink Receives Audio Data Over Multiple BISes -
page 193).

Iulia Tanasescu (3):
  test-bap: Keep streams queue in test_data
  test-bap: Add support for multiple bcast streams
  test-bap: Add Broadcast Sink STR MBIS tests

 unit/test-bap.c | 319 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 287 insertions(+), 32 deletions(-)


base-commit: a2438e46f8129d8e08cfb00001a4b63f5616cdda
-- 
2.39.2

