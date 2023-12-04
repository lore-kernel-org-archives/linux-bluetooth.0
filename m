Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iLv8SG4K"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A1ECD
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Dec 2023 08:59:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3MxDEizmNqqWDR5B0be64834QAVoMFsUZcVhzIlU6SqL+4IITMdD7Y7N/Au8XdB/fCAlf27TF8pFnEMFBJmGWPqa4qRNdwMv5hldCaOZ/Ny0BdVvzyPQEqNj4Rwo5j/kQUwKxmCeSR8+R/EScH+8NAtz6ODPn4HGtmdqC577JS2OXFdKgtX4t1KUlVVzR/jEMFsUPgv4G6y3WM+W13oy2Hk0784bcExvV3u3/tgHnqgB6lp5QyY4EspEphrFhXqYLyhSW2NpUqaAjZpq4XstqbgnMBDvGJhA6IL60CXMD964f87ppCqkKCf6O25xhudiegdwCfffD1Pz5XbRmdm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7XDCnLXzdKQYOJ0q/K7OSDL7WcAPHlAfz7ChXC9wv8=;
 b=Vu1xTaBzfquxTQ6NAqpJ5yUTRjiEVdDHbaZcezA9UslgHHmuvGPBNi7icfdFkROQd/U81s/rSUsZDAbQ6S1Qk8CDTKTYmPUZCnR5qoWtqPlwm+ENu3BioNhllFeXkOaHpDvnxn4osCpoGriiAZRHeP4pOZwa5IYxydDBZ/lkn1ucOmtEHO0hWaY9vxw2SzHbKXANCFW3Il/vXcbgjdkvI3yCkMtc9H3U1TkzNfcbbBGEjPpafK053eZ2Alo8CXLAzbZ2/4i40C+aHmAPswsjGaZ/JsHNQ4UxA/CTjuPzSs8o5uTWljNe85vQwZfR4FEMumn1J/J4/8VT9Cc9reC8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7XDCnLXzdKQYOJ0q/K7OSDL7WcAPHlAfz7ChXC9wv8=;
 b=iLv8SG4KCdTL9lkfWPFRrdnSYMoLqLKLp1Fks3MXFpDTon1FZag1Ml+c5AzZ0HJLjJJkzUTA7DPFytE9GdxQh60lAqHo/wywz662UEZZwDDjfCgSPsuyHLaEdMTG2Joxd7BkCTrlyJl3qF4rA4I9TXBcrCLtLZ7WGXjqVPtCABQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7538.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.23; Mon, 4 Dec
 2023 16:59:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7068.022; Mon, 4 Dec 2023
 16:59:43 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] shared/bass: Functions cleanup
Date: Mon,  4 Dec 2023 18:59:33 +0200
Message-Id: <20231204165934.2847-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0171.eurprd09.prod.outlook.com
 (2603:10a6:800:120::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 1172d600-66e9-4458-fdb2-08dbf4ea6986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UMzorQYK49roB3A8Ei0QovkyKVelBmJ4Ue0YRauyafS6TREuBT1Cg9aAysC+I8XJgTta9C4HUgQTVmMIqomieZjEeiEHT47n8664NMiyfQyhN6S5m+/h7mtu0ctHwUzFNvVsiQrALuJuDMtEJG7eNyOOxzu3x9DCZvOIbuEKWOHUQ9h0j9NjKY6mFHlKJemiuCI17LM+kZxOk/3eU/pRRErkPT9/SEG0IHFaZRS8MLTo/PBIJ3xnOyx2uZHgve1PMLR14aYUgcstpKIrqskPJjG5oQBL0TRs3XDCpf6BeWuNcKmbzcZ9qajIfB+Y0vStAcRCzCUT2Vo7dt3i9MaZarfp+uuPMVsGXSYI9uuTDXBc7GERFUpJly5R5kEGMUqkKgVkEcdj+MC3oEacGAQr0Cz/fXPy+0TaDApVKd0tDstoHJwYeOxb2QZ5rO7JjH/9jvbSnywzf/aJ02155wVLrrunwon/KGP1g7kgsIUxYzZTa+w8JopYm7mcTyAKr8jQ/BXAVOrmBy6GuF8rtff1P76q1GBKXzL5YKy17IhlnqknxIiluQd5IldL1p5ox2or
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(4744005)(6506007)(6512007)(36756003)(26005)(2616005)(1076003)(41300700001)(38100700002)(86362001)(83380400001)(6666004)(2906002)(478600001)(44832011)(316002)(66946007)(6916009)(66476007)(66556008)(8676002)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yA6d2ZDbIM7iBtvFhQAJC8C+F4duOJa3Lps068g0PqTBZ3q99hIz1GZZXZWf?=
 =?us-ascii?Q?C5jk2Zt3OJHFLDGdn8+8VbMxzghda0YGGAskSRqPEWo0QePNhGjFilXPqE/H?=
 =?us-ascii?Q?RiNwo4aW5sLbuAE+V7SNDMj7jCoCnU1KqvCton3/cfFEo84wJY6LLCDjUq/c?=
 =?us-ascii?Q?zT6QcceHwggnZaOUkYIYMEe/YiD3yyfkJ4py5xQConeFW71XeD0DArnAknL5?=
 =?us-ascii?Q?YhwaV4zPoTK/C5fnZDJrLKBx31aqSMSMsKeq8BVeRnxT1YrwCbCjlbUHv6z6?=
 =?us-ascii?Q?0GuixIGY+XnnnjoZBoWCz+4YuYNTZRMyHSxKCQ+kU6aG7IrZxypCi1v4oEFj?=
 =?us-ascii?Q?Bgy4ArWn7mi3j1oiJFizMuAn2sSUF5uFhtbRbANYJE9YJlzIUHh9niCErFbX?=
 =?us-ascii?Q?Iak8rsqTQuxJQzJkry18qWDwNjMf88vEiB6DYSXnZOGb4fsJpNpdF/m3STDY?=
 =?us-ascii?Q?WyfGDyjSiUkoJlUzaXslpdoVLejjeAIHUWTcdqQwdawTPjzmKM4Wyh2/sl+6?=
 =?us-ascii?Q?s7QcNdAaBmdbytUqMNcFZhU2rDIhGRpnGYC4Qr8Do1r4gixfcJjievW7PqmN?=
 =?us-ascii?Q?FCDOoI+FH9z0E43K2SNIwD4A85JYKtd05MbT8JFtQxw73W0TSZiGiiq3HlXJ?=
 =?us-ascii?Q?V2FBC5JM8J22ADTtyHKcHh03Oh4/Z69UZ3UsOa7Rx2clOzTCX2+1yAcKx+5y?=
 =?us-ascii?Q?2rNwFvgH4Wo9ZD+ofuMZ+NA2B10Nft1Gxk/gxX2rQa6HSMpv78kYjun+fn50?=
 =?us-ascii?Q?SFNTT46w5m/4K3eOUeLnTrA82LlEDNYOUbVWiaIFPqSYr0bt8J/BFP32Mvux?=
 =?us-ascii?Q?8Cr8cDFvd+e2g8XczbDaTHRJ7bMJw4EHGq/+Z5o9YfSO95J7EAtgPzztiey7?=
 =?us-ascii?Q?56xp+VgHnFhwQZuXZpzKkwoO1kqMipGe1cT9WsWE+ddJtNuED7Kx0hgNJmcK?=
 =?us-ascii?Q?x4D7F6Qa/oULMWy1ThW/AwbjII/CJ92lveBorWEhZ4GcjG3qAKRAyUPMGaBE?=
 =?us-ascii?Q?3K34o7yvCtMxN9C7qTNwjfAVh/B8lNirfaGTlNW2AIxYrw6m1hT9hy5c1wIa?=
 =?us-ascii?Q?Q844GVJEa5gna0lRAHu1C5luqUm03XbJJur4JsJB2uo5K9tpRQtTpsqFjlu1?=
 =?us-ascii?Q?urA4NNM4btzmDysdhc692Eb2hbCYyglRcz6I0L7eWCh3fITabrfLZv6DwAiE?=
 =?us-ascii?Q?Tuh8Kl/yo4J5ma0pKoG5ZBkaSfq0JfrLAv8UBKzO3u2YtWupwldse0+RLfvT?=
 =?us-ascii?Q?PmSTLKeC3+y5BPAWYx+G+00YZEdx94ludR2QjsW7GFCy15+WxASu08xppC2a?=
 =?us-ascii?Q?33w0PW2OHM9oxNOxZkKerMF+GGcCSQFI8gdeLEqQav6hvc7dxPwSgicDGETp?=
 =?us-ascii?Q?6JEZRw6WegaWjrhkhqEKEl0YYeVwHCvmN9N9Si8r8ZpuoWS7GjD9GXtr+luG?=
 =?us-ascii?Q?hj67Go2t9W8xfjDAbeHPSeVs0ZibT0iIfb9kyonSfNQX3jtoog4ZPAkQyTzK?=
 =?us-ascii?Q?DxouDlR/u1ZVnlzAp/A2Oya5+sRZcqblAYO7LkkUBKOVwOK+aaLtp8qncZhZ?=
 =?us-ascii?Q?US8MwXbnRSb0lSlKq1wr2iYcNcMqhvhJGeeQOawPy7xGCPTHcg/K0Co3dNHF?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1172d600-66e9-4458-fdb2-08dbf4ea6986
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 16:59:43.4491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tv1cBkgPUwmPTtloNwlpAADf3bfMpFNhq4oN5k8c9rWd5h3C2fNvWrPPdTgFsAZqSBs3rZnt3CFD0xUcjApBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7538

This adds some cleanup in shared/bass code: use util_iov
APIs to extract/push bytes, use new0 to allocate structures,
remove redundant functions.

Iulia Tanasescu (1):
  shared/bass: Cleanup memory allocation/handling

 src/shared/bass.c | 241 +++++++++++++++++++---------------------------
 1 file changed, 101 insertions(+), 140 deletions(-)


base-commit: cb1a3fd96c48a878f1a93ffc81e0c5d867b03cd8
-- 
2.39.2

