Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F802010EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858960; cv=fail; b=auPD7cED93RVgOcZGuGJF6Q+s96tksm2m8roMiy2Y0Su8U4TZkABInzf8RZtSZAs0wbsOaT5az13az0Bk00Eqdfc7edLmpsRx/GQK2KdnOlVqTPMVmhmzeevKlbwYIKO/dKDtdWbXs4TsILJ3Ny1m793mL9EVNcy8baBS6rlHBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858960; c=relaxed/simple;
	bh=JGUqzxPfsYUr9BVao+ZnnBylRBbvw/737OpD0MrOp9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5Zz1ViDwPICDrcBqVR44Ttcei26JMtjKOxwEiHM1byFhJiSQY5XN9cgsrWZumVNEP6Z6KfZIKqD4OG11HLLIwPm46ekw+KWhBPFFnzT0oXsyjJHE93eHYLrEV57xtDZiHMz0LXcCR8YQ7SlL3EWYlNaPZ85gN0YejIRB9QTuAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JvlozHbg; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JvlozHbg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0U+9a492ODGwoZ8swe1oAd5FfhbWY9q51/iUpeQMvyTWCqiLO71DG44+EogIQL3ihj+IFeCr2wmhqTylP/s6NXFhuqxT7xHt4IfQV8Kqv8t29skkm5LV8goEJ7DSvsWe3Iere2+FGbl2e43b0jDah7lKPWpF7k3DA6ImE0kVEY56rC6Fe9sfIDBNOJzvD4WsJOmuDmeNwg8AwOo/a+cqRU0dSpwgLijcdn0lDCKQAttW6spGhuo69An5mtA4cmhPWui6dkfK5slZM/IF8BXzO03+0l2EMjk1aOkaYWv0i28R8nNggmT5+nyMTLLL+8dj9Txq2aigWK/d/2O9SZmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG0JfFcPMjt3WfSlLtm8E/r4ZqzeMtHRX3RPWtzPRnY=;
 b=oVoiIvP44pHgTWmbtWbXDhO4PvtSizQalSiRZ78zEUd7d1KLg+NZOl81Fh8B5L0Xr5qrh4fh5mBHupwQwojOpHhZtgK5tL9Gv8bT4hQCSyQN/ktyeJNGfR2RIP/d1o1u/fxATal44IzWlAsdTuLWMNe+47JIW3ctpP/ijN4BJcetsoa1vV7f86YolxKXwbIkj5ZMlrrQSyJuRzhDjVAPGnOnJ1MjE9CSuHAv6ehSbu2CtWvIJp2p+0jYT9uuiwr8srSK/qAVscDnFa1cKwgGx4NCT43pUym76/K/9YNuhiEyAn874ioU5vFjnAdn0hrmAW8XIUE+xI3ual8OhooFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EG0JfFcPMjt3WfSlLtm8E/r4ZqzeMtHRX3RPWtzPRnY=;
 b=JvlozHbgaJp39zo9Wp/kR14Gm+8Q4zxoaXMONt6MS9BLy/s3lVWv2+umCseDayJVzRL7/vJUHUIfkdfdkW9IRm5ejRRuIjc7sGRSqRhCxZPEAfvmntuEjF/cjmBfviuQovgz0ZEohbbqQV+A1jcf5DpJzhvOpPzViLRJ+xi+cUHQrWQl4LBeKEG4tapWZgEWDxWAJIRKFAlcmENrp0yKFpFO5Na+GGzq8kAMekLRjUwobHYeGSUiZd1FIL1A9gIiBSCMimFCXAuum0VLzUnG2WpMf1P172O68WFOA3tyQLS4Idh+j79ohEgVCXg2VpiadmQyGoEzUoXDe6VMWJymPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:30 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 09/14] doc/media: Document Links property for broadcast
Date: Fri, 25 Oct 2024 15:21:41 +0300
Message-ID: <20241025122146.17925-10-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: ed22403d-cbc4-4ac2-14b0-08dcf4efb239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5aygQdI2IoOffQfDb6SKZgofhUWg37ZTEpNnZfKuksifuw+Iu5Gz7RzOdVl?=
 =?us-ascii?Q?j/5sXrsvYAPkC9xOc3UWhACGYOp7ugn0FquaCBgavn3/fLg0YtAaUz77L2us?=
 =?us-ascii?Q?obpV8fQXmYdCv2wYyCmI0zluTij2LMqVGZn6T3f7PjSPZ2jRQ/ayBNJAPmoK?=
 =?us-ascii?Q?R3iVo6gggDh4dDDMpPLNtLpGSmUcwGh7EXenQ9xLjbH8iVL4yalAR3N9SyJ8?=
 =?us-ascii?Q?NnE3xgzhcSU+k1OEKO7k225pkJRPqa4TZtsXrA9Q7ZdDD7/Bd+iIlHJ4XYUc?=
 =?us-ascii?Q?TfgG7QIH3rJ1Rc9PZm4+3ry/QURlrYxsp1oeHuaJfNFMjei64XZtKDJ76Qni?=
 =?us-ascii?Q?Jj7+1k3XbhQnUkUJQZnGnuzrNt2b0JT3ZWFznqrNdChuJA6gecp77P9MPKim?=
 =?us-ascii?Q?xA3pk1FtfjfzlyRI2gtzfIQ+i1Mz5sD4hdzc2iXtCW6x/akUWiELaPkS4HP6?=
 =?us-ascii?Q?kBNYI5dFAfsK3v6OYqQn22z0fNLDd7PhcJ2YYRWI4DKejrP/Rn45g6Z1A7Yp?=
 =?us-ascii?Q?v9+5qgPlhRmwVq9M5XTGBoEooontk8lcCH3b9ly0bsIyUrxUwhhjplfkcyG+?=
 =?us-ascii?Q?tvqEtLU8PfbE1+QDPjUoGLyrEfgaYuvdcDdzUkCT+pc8YUgC9lvtdLlz//oj?=
 =?us-ascii?Q?8TO3xGt+1zwhKHp6MHmELy8zktKpX4Pch/00khyO6eAgV+pzanDP+IVPLv73?=
 =?us-ascii?Q?jLUey1hH01YgPj7lInjtB+MsePmAR4Iqfr1FJ7Td93iF3JSt+0zeZOLMZLum?=
 =?us-ascii?Q?OJHBlm+HVZnvehcc51bDKia3RzhRvIZUinUeAaON/yof+Ytwdo6y/R9+BL5J?=
 =?us-ascii?Q?AR4yXVUeTmislEUh00BZC59j4VMfNbDBKyHc9yk0lOycDFs5YslnmItZqi+g?=
 =?us-ascii?Q?wCV7UzGyd6qfP5lTJzIBc/67xa4oPhn9qyyS+w2uNcJuJoPlb386tWzgowXk?=
 =?us-ascii?Q?theJhony0NrsjY50o7yp/pBKMlwOlkQKYhdAfxl1tZFOLzy2obWRakRQyOFK?=
 =?us-ascii?Q?2W5TjhHWRYy5CbTaHf9eL9Awu0Mhd/z8rdwlCLnnt3yGew1DRLhK6WPvFrXf?=
 =?us-ascii?Q?OVynGX/HPbU3C/qL/0GS32V5cQmgoPEOVE5saYQUMUDthJXNoFrkXrY7phDx?=
 =?us-ascii?Q?86//GPw9cJSGKgzDm6O9Tek+QHOwDb+9W8D6tVjS/xEFm+5Jn7+CetB3Rd2H?=
 =?us-ascii?Q?vHQubtUES7H5ZestHARbjooLUtcwOsTA7wF3BmkLf4eGwfqY4vt1QGa+3kE1?=
 =?us-ascii?Q?B5oOjI79KsD89HgCCtQOSocjDXPQz6k2t3Dgiwsro+hw3JxwRSx4+2cqgRJ+?=
 =?us-ascii?Q?i1dnv5+I81d4mglebnBGvdmBtkD2hdOnsHbP1tlqqw53kdMtEKac6JU1hAXB?=
 =?us-ascii?Q?uMzp8vo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jux2qclDwYaIk4BXCBpBwdTvxD6bOPELI2wBECuvWL82msTP0hBDdrcnzzP+?=
 =?us-ascii?Q?LFmPOkmRYPURBFGtgEjlGkqrQsPXbhMnObbzPiJOhbji6p+bl6m0aQRDlOF5?=
 =?us-ascii?Q?GCb9gDE3sxjDd/xN/fS5DwgOTBm8Ty1a6Gn+rKlzvLXYBhHtGgEtkOY1RUbp?=
 =?us-ascii?Q?aMdz+U0rXE6GIsP2OWrFni96fx4/nd48KpKh5OKLKoBakB+asLoARRVYo2Gh?=
 =?us-ascii?Q?7D3t2Ck2rHyDkyOw7SylAPQw4J/PNckh5561NZm0iBuHm78LqBXotY76NXlt?=
 =?us-ascii?Q?WvQz0SKTjNNxBSlhHmVwIVliV6DePpQQlHJxtfm3WQviiEDvLqvGLeDsZuBV?=
 =?us-ascii?Q?tVb8yzUfinrNIfFBxqDONhq4VEwWEaBVmD2Y97ZVJGEMJzI3HX23hDTEZiIP?=
 =?us-ascii?Q?N4uoIibLOSa4WJ4eFIEKi1WdEYchHg2UxALpxdoS8wbCRl0JLxDM0EYS3Wp0?=
 =?us-ascii?Q?IdX9LpBqoaCcFhdQTP5EYDCFg9JdZKCDFPzdIvfuHJPqxqzSX09FmQTO9F1s?=
 =?us-ascii?Q?rsoZWH8HcGIaPHSmIVLQ5KfOof+11CbJK13VXZqhSGK1Et9A5UynG95RwCZw?=
 =?us-ascii?Q?iYEvpeUU5yn+sdk5ynixKBi2CaVQk6nNnfyTGL1c7AHWgBTUhgDssqekUq7z?=
 =?us-ascii?Q?gEf9bXnrTWaUMCGHpzSXtqjeSTyg7yADHnZtu52h6DmNAAmLzstoTNFpyVPS?=
 =?us-ascii?Q?BIBpvnBZ5g+ko3q5WLKPhGEzQt6tMLObHkvsnIuwgcwS4MSj4jncq9m86YbG?=
 =?us-ascii?Q?iJOpWFmcU0fAp0kSMwouCjwkHcxwt6TqVL4KL429MIDEW5rFujG2ROOdWgmm?=
 =?us-ascii?Q?ugSGVcF2Sjyck/Mn/IXzGLQFr6eRzd1dEUzalrB+Rw3Zj/grObaU3teNrA1i?=
 =?us-ascii?Q?IlZVkbRkZX7jLq+QrQeyA60iwgnivjP+gtOrgqmXgSwBQ/gsSRqBFZjhdj+9?=
 =?us-ascii?Q?qtlBdJUvfFRzr5N5O0EyTD8tSVGi2cV+ZhHGOTZH/xYdnwHABOAxBvnukWVp?=
 =?us-ascii?Q?WFy+jHq+utvamGZgVhvbUSNmCHLiv9lw66STUROK6R0aFhYP/8f3CTnlcRMk?=
 =?us-ascii?Q?qdmbqsuzFEmSy8liW0gvgoTqB8cstmTBKVRN4iAklpXTCBVToyju27IyVIUF?=
 =?us-ascii?Q?xnxZDX7vIg0bAfIJxTdQjAG8jjWES8knvKeYBS6VaCf2lOz4kcNrqXroW5We?=
 =?us-ascii?Q?df4oi2uagrZxqRf5hIypLb0iGiPijxlZsmfRYWOQ60aJ0VM+qUFy/GssCAd7?=
 =?us-ascii?Q?mid3kOf8qaZ+4s4Grs8m5CSRV9c0npE6re59AHt/qbpbuk9DOyMPOD3Mf/4r?=
 =?us-ascii?Q?J/ilscnaNti2boHDwXCBpwK6S29UrM1Z+50Ayz0I6NLnQvXpc1vqP3Eh8Gsv?=
 =?us-ascii?Q?yiu0iMOKYRzbzsVkXwgRkC1SfbfC/fkkyaH9neISeCnjNrQYQ/3jbm+uFxgZ?=
 =?us-ascii?Q?xa6Zfr0kwtmMM6y3aQHCgdI6wRdOVHASOVcVam68MTOTePZwhI879MIBiFmo?=
 =?us-ascii?Q?vWNqF88/wEIEvEFIXX6N0cfgrd5KwhLgmD8b4ZdbRJFpjDVok22HHvfesdPT?=
 =?us-ascii?Q?G/Mtt6U//t2aEFaOlY2f1uOCoZQg0fKlYx/uCtMvaBERwnU/EhNuFRPqgawq?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed22403d-cbc4-4ac2-14b0-08dcf4efb239
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:30.5026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O2BPisKo5HwNGlPYfj5Oema6OWBB1D3U04GPp7Dp7m6UWo4HXpvn8dIrTBOIBgGWdjaixkhMcFrUKceQppS7RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This adds the "Links" property for broadcast.
---
 doc/org.bluez.MediaTransport.rst | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 4d998b2a8..4838d69d0 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -144,11 +144,26 @@ array{byte} Metadata [readwrite, ISO Only, experimental]
 
 	Indicates transport Metadata.
 
-array{object} Links [readonly, optional, ISO only, experimental]
+array{object} Links [readonly, optional, CIS only, experimental]
 ````````````````````````````````````````````````````````````````
 
 	Linked transport objects which the transport is associated with.
 
+array{object} Links [readwrite, BIS only, experimental]
+```````````````````````````````````````````````````````
+
+	For a Broadcast Sink, the BIG sync procedure requires all
+	desired streams to be enumerated from the start and it cannot
+	be later reconfigured by adding or removing BISes. To avoid
+	terminating and recreating the BIG sync everytime a new
+	transport is selected for acquire, all transports selected via
+	Transport.Select need to be linked together. When the first
+	transport is acquired via Transport.Acquire, all links are
+	included in the BIG sync command. An acquired transport will
+	create and set fds for all its links. Then, each link needs
+	to be acquired separately, to get the fd and start receiving
+	audio.
+
 dict QoS [readwrite, optional, ISO only, experimental]
 ``````````````````````````````````````````````````````
 
-- 
2.43.0

