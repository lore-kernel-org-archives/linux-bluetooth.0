Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093A9225AF
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 May 2024 10:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716200431; cv=fail; b=bXkSUa3eFvJQeiV7NnyIraev7FtxXTMBzeFmAH7itXDMJh2W0cQo9Uzycge+WoO0OmFbYAsY4DXAN029nKygfx7vv2CEAdAMdGTw1o58pHe+kUDmR+DGQa2vNsBf1ojrqJ2//ies15jpog3y8IImHKZLjQyhjDp7JzIQ9E3UvZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716200431; c=relaxed/simple;
	bh=2VJIkn0FUA7nDabtV2p9qE15OlvbqarTHrr+tnvlndw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxjv5amWKfdhTcQtz+VFajhXN8R+aqflbdmTVrhVhaZhoC4OWNPaLMIuMt8c8EX2EzZCnNGpiY6+b6JhdiW+P9HsFdLZJ73yeqYY+S+eH/uBc4oaJcSDPGQVoR8Lp9EFQy6YRzn1G7Fn+nrjUBoAB3w6001psHDai+t0mRAw3Lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R5FfTurA; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R5FfTurA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gn9imr7y9tr+v0wxosbfzVF+kn2ldvN/mIcW9N7199ARNQwIpO5tUfZvBW+igJ4p7CYZZ6cc3bnhL2/clW3988bJNEJVuFHqqAd/7YDkyeTwQHj6mBGNgeMj6m4NaddUPEINFpbQVWRSolECnIq+rdNFe2XBt6GJqvuZ5TpwFA7iDv+Ec12L0XuBj50+gx0mr6sspof8+iUeeoeF5Lu9voIm2a7GEeMKT04ry560Qy4vUqri6twJDYr9vYfSZcqTyW9fTss8cfljnK6aIbiKS/NanLy+aVUORZcOlIJL8TeArNFAtmWZ/8e2OW2BISzRxnPQA2LBswsCV07BQMEr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHlMo0dZfkFZFzIqGRIV9m0oOwEC6KRjjIUYuXmQ7ss=;
 b=ZSDYAHJZSVNqweOmPTx11cotqjpuverYhFok1viB7F5XF/RAeZpBLQrFvQvdimP93C924v8U7n+c1CMIh1VDC0TJRYjMehIakWmh5OVtTd0hs2ZYBJ2l8lNGmbVY8p8QtHUWE00Z91sBnYATDZr+TY4g9K2fibZS4PeXD7KIe+LTO2JDr74sDi4Abdu1Hcgp6wP/8FLhE3A+CUx3BkH/zZ2tjbCBNEzo0sBz2sVAJNS//FfJvbnFadL/vilPG2QtKbY2ROsaZrjOahFN/9WRCmA4iM5u0htq3uXvABf/bFiZt14QADWJzK/cXZFgiVYBhoTGSXVRMNWEottI5sbLsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHlMo0dZfkFZFzIqGRIV9m0oOwEC6KRjjIUYuXmQ7ss=;
 b=R5FfTurAxpgwY5qc8FSZQSm14S1nSyIF+pVrXE/mk7x8PEBl5/VfGtQ/CUHWrFOQNoKP9H2IRwRTEF3ilcdUaO8lcWn4qJpNOVL2rJTjgzJLmzFQuR/ASL9KpqAhMl84AQJImHQAT9u2O44fHuo1fPAIhtewZ6ABuV2ax+XU1/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10911.eurprd04.prod.outlook.com (2603:10a6:10:58c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 10:20:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 10:20:24 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] test-bap: Add Broadcast Sink STR one BIS tests
Date: Mon, 20 May 2024 13:20:14 +0300
Message-Id: <20240520102014.24236-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240520102014.24236-1-iulia.tanasescu@nxp.com>
References: <20240520102014.24236-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0043.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10911:EE_
X-MS-Office365-Filtering-Correlation-Id: ee704741-8515-4ece-0909-08dc78b6764d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2XxjGKyj36gcQon6yAvZAeELPMbvZojqD57xGUhnyZ8oBMhdk5q671G9ZqO1?=
 =?us-ascii?Q?X76d+PMM8rv0Lgs3TsRpbjRXdPWdCwTDN3o07d8ycjbFYuKnnHUB7OQVmp5N?=
 =?us-ascii?Q?OQxXIVmVbD+51k5sOWtfxOWjfowDkGAzK7tgPMnvBptzCgh7E3g1vgHbLYmh?=
 =?us-ascii?Q?9+5gH6A260dfbW65fTy/azRSIsXA/xb4/UpqiGthmo8lBL5w9dNs+9MRZBZo?=
 =?us-ascii?Q?4QrPlyCtFJBuuAHQNNAm1E+DuZv01GOphNqY8YnUhfZyng3yRkdHBv4OTEzB?=
 =?us-ascii?Q?SlCICKAB1uyMBoTk1gM6pZMcUvq1owuNN2U+VUMGRZGsQ7fDYJOxHHNsCF47?=
 =?us-ascii?Q?Rll+vPnUZ37GOKE4WDfZIh0x1k4PsDbVkWp27TsMM/NFhaKDfihHPQ9LkCQF?=
 =?us-ascii?Q?M5yajULPMUOVmSMc39mDgz6qrsp9TavAngBieDbe+jBLRnFsJykUxEQpM7Gm?=
 =?us-ascii?Q?05KQPj9dNAAh+d4jsFn0fJDZrRXgI7AAeboAncKGw12vOlHhxfWs4wpmWcdB?=
 =?us-ascii?Q?ln6gdLm3DDdB1y4Gg+an4mpUG8ww1wwByOYUtBOYpqOt5P7YmffYzlJITakv?=
 =?us-ascii?Q?bCp/mJLJbMUziUSMtIf+rVKmIq+A6WdiN3bUvXNwjle2WXfZWjKh2Bm1WiyU?=
 =?us-ascii?Q?1A+o3t3hAtYeYgdhj2JN6S2+DSVqtGKJvxWMcN04f2wZzjoMxqzTxPLE1Hy5?=
 =?us-ascii?Q?NKkKGuoKk9GecLbwMbN/RSLznjFsVgv1eL5KcgDrixMRftur2/OuhCKaNHiu?=
 =?us-ascii?Q?tv0qRtfoDQDZm2qUngn20N6QVA3eAw4X1X9dRpEJd2tN3cUIB9MKaCLocP3F?=
 =?us-ascii?Q?zGOPe6aVcSl8A17GmJpT5VNC7leEWr063UQkuio4ueUUzhr5ae/JyaRAwIak?=
 =?us-ascii?Q?PYJ5uOmc6F0HCWLggfY2OWmXi3W9SRB9HverTDQnU6hV1VxNNvuFYCQ5dirU?=
 =?us-ascii?Q?wWy0/KnyvC7ybjn3DwUklU/9jeWHKmiqPUqwvSuKpnPqG1d6M88V4TDzcqyR?=
 =?us-ascii?Q?MGqFVk5L8H0RQhCwYQ6L0VadASgrekrYGqLY5hNa2IOBBgR2a/TKAPQ+PjZS?=
 =?us-ascii?Q?iFHBwf49KocmgDUzjg+0xCbyr0M8fcKS1ijV8kzMhMHKjZAJ/djFepBjlx6b?=
 =?us-ascii?Q?aF+h0OM+VPMw7eguV4TMV75HgihQwbiZRgSXpgy0MyEv86AtLMJHr47l6G7B?=
 =?us-ascii?Q?GI5A7OY2cLY/Wq2HDQHNAyUnG5cVTxjUMogl7MaYIDUYBW7OFaQ42kBWIYQg?=
 =?us-ascii?Q?6wkiMBCKPrTTz1B3bzDwbSefBStF1F/GkpiuPnYAjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jjVVywE+a/8qnWkfEXBZ5YCExd/KG+U+FuJVGHMUZKbvmdM8e2exnnbCALYR?=
 =?us-ascii?Q?eljMw0kpkasfzK4G700hL7Pl8XKHcOftqxPVpv3XCawh6Pxn2sfOYqfdGZ9e?=
 =?us-ascii?Q?HF+HwOdgHN9jcCFz73CZtZx5CkLx4FrLBC2Qby4k589ODlp4Louk449pAOKK?=
 =?us-ascii?Q?cStOCNyCberiWIkssqHAC0AlVNQib06MVyLL8Bs5PcD0BUG7bpVPF04HaEOe?=
 =?us-ascii?Q?TG3IIkmm7QNgpEFHh52FJRmtN/5UKKvkEijZwn7RR50LTLC9wsmsrfIWGlfv?=
 =?us-ascii?Q?OzZybVb+NhNK5/F5rQCtw3JJvPbs4dx/z30gZ2xDoUq61HfK8xM7ruFf0JXr?=
 =?us-ascii?Q?b1KF+EyIMWcnvKb43f7iBWmtiOZ1S5m87a99eYXb/Uwv/VCVaCvnWsyCrjiK?=
 =?us-ascii?Q?dLo1aDdx0pvZUnEnchWH1fmdheNZRsUiAPWzTm4CLrdBzyu87Vxiv9NFwc5K?=
 =?us-ascii?Q?HwkBEF04iyCXzZyzof291u2utxhOyNzpxZZXalSmGotoS3syaXZLIUUu7tyB?=
 =?us-ascii?Q?PJg4KHxHrR3JO+EDqwOi/JWKFwxMdMjYpMz6eg7EusQUYqLPl4Wx5Lq1rEd3?=
 =?us-ascii?Q?/KCzJ4M8l/G4N6Ns8rHfSR69D7hDZ6vaCRXXg0HyFm+9eNtzo8kzZ/RXtg2P?=
 =?us-ascii?Q?lOiBTXX1FTWFB6cVmHfZ1wqvmamh8jLEMojr8jWBmRfNygo+ZRaLnIo4jx76?=
 =?us-ascii?Q?TZCEOcyvQPuPkpmweCxJVvrFuNCZ/DMBujlXalgOoXXjjIsaXDuC2PlPW3hE?=
 =?us-ascii?Q?ViA5t0jLPAEY2ji5hoApuAESqDJCzLiHBZHd2UeFzNZoBPMDR4pNG9q02Dmx?=
 =?us-ascii?Q?ETGF6PEUBxzUs0OnIULVkUMp2Uq5SQs3dyQs5M6oAYaMz5yFX1Zbkt6JNLSa?=
 =?us-ascii?Q?00rBGVnxGwXQxTMqTP0pY67MlMAIzQb7oSpZu4I70BeYni731wlMIinLRk8c?=
 =?us-ascii?Q?k4mb7WmB+p1GYfkcuinjrbm28sv3fRPcT70RIOyQzz7QxVBbeZ5mKI2DUPm2?=
 =?us-ascii?Q?yMD+Nr+wy6Kgu1V+Y8gI0kxxpuPIKoeay9m5aLge4zV939ScHjx3YKBIA1vE?=
 =?us-ascii?Q?NZGc44CIvJ4tRa5v/dxAaPUnDw9TRIX9p1NbL4Ik/I8LiiWwsHPXhv5ubomf?=
 =?us-ascii?Q?MluFgCAimAPSXesv+oYrTZSeg2++AjabJWQWsDyyDCN2tCl9vjctOfHV7er3?=
 =?us-ascii?Q?5nt+y4belOFnZhuh2dXLG7nRCQ/aavjP6roweMQysz3iH5rog0FiH6kFYcFT?=
 =?us-ascii?Q?TpcTe707DIOpPx4BzWqqvDE4jVYuXcEPAJAS2fzp9keLvqfyqwBwaEs6Ldkh?=
 =?us-ascii?Q?aW8fOBm3WfGlx2sgyaTFjI1cJr4Kz8dPjOI1pmU2Q29MZCg9KP4JZTgjzZsi?=
 =?us-ascii?Q?udW3ewpqqCvYWCvyj2jaapGTtW7I6bckQmEA/uP/JHV4i1oLI1z0eIM/1z60?=
 =?us-ascii?Q?pAj0Piz+cx49OIsusd1kV1tDWGP5rHFMracf/XE45QLRAKcFfhUvF+XlvERK?=
 =?us-ascii?Q?A7qQm/N3J/dPjRL2HH+4+nS/rz7Y3HRRZLXiis32Lik2P/lo73CUTBg+OXGh?=
 =?us-ascii?Q?AEiiw409G1ZZhYVB39/bP45hHmoqPi6qI56pucubVwM33/zNdvEcAu46auST?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee704741-8515-4ece-0909-08dc78b6764d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 10:20:24.5711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRw7O5z/GUppSBTsbOVCOcYmuXnvQ9YBhsw62jT9jRSPllhg5enPqkMFik8yrJuJUAU7jm4lXLDz8bPC8iTHhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10911

4.14.2 Broadcast Audio Stream with One BIS - Sink (page 189):

    Test Purpose:
    Verify that a Broadcast Sink IUT can stream one BIS from a
    Broadcast Source. Verification is performed for each set of
    codec specific capabilities in turn.

    Test Case Configuration:
    BAP/BSNK/STR/BV-01-C [BSNK, LC3 8_1]
    BAP/BSNK/STR/BV-02-C [BSNK, LC3 8_2]
    BAP/BSNK/STR/BV-03-C [BSNK, LC3 16_1]
    BAP/BSNK/STR/BV-04-C [BSNK, LC3 16_2]
    BAP/BSNK/STR/BV-05-C [BSNK, LC3 24_1]
    BAP/BSNK/STR/BV-06-C [BSNK, LC3 24_2]
    BAP/BSNK/STR/BV-07-C [BSNK, LC3 32_1]
    BAP/BSNK/STR/BV-08-C [BSNK, LC3 32_2]
    BAP/BSNK/STR/BV-09-C [BSNK, LC3 44.1_1]
    BAP/BSNK/STR/BV-10-C [BSNK, LC3 44.1_2]
    BAP/BSNK/STR/BV-11-C [BSNK, LC3 48_1]
    BAP/BSNK/STR/BV-12-C [BSNK, LC3 48_2]
    BAP/BSNK/STR/BV-13-C [BSNK, LC3 48_3]
    BAP/BSNK/STR/BV-14-C [BSNK, LC3 48_4]
    BAP/BSNK/STR/BV-15-C [BSNK, LC3 48_5]
    BAP/BSNK/STR/BV-16-C [BSNK, LC3 48_6]
    BAP/BSNK/STR/BV-17-C [BSNK, VS]

    Pass verdict:
    The IUT synchronizes to the Lower Tester (the Link Layer
    receives a BIS Data PDU). The host on the IUT receives an
    LE BIG Sync Established event.

    If the Codec ID is LC3, the IUT receives BIS Data PDUs on
    the broadcast Audio Stream containing encoded LC3 audio data
    formatted using the LC3 Media Packet format.

    If the Codec ID is a vendor-specific Codec ID, the IUT
    receives BIS Data PDUs on the broadcast Audio Stream.
    The parameters included in the Codec_Specific_Configuration
    data are as defined in TSPX_VS_Codec_Specific_Configuration.

    If the Codec ID is LC3, each parameter included in
    Codec_Specific_Configuration data is formatted in an LTV
    structure with the length, type, and value specified in
    Table 4.81.

Test Summary
------------
BAP/BSNK/STR/BV-01-C [BSNK, LC3 8_1]                 Passed
BAP/BSNK/STR/BV-02-C [BSNK, LC3 8_2]                 Passed
BAP/BSNK/STR/BV-03-C [BSNK, LC3 16_1]                Passed
BAP/BSNK/STR/BV-04-C [BSNK, LC3 16_2]                Passed
BAP/BSNK/STR/BV-05-C [BSNK, LC3 24_1]                Passed
BAP/BSNK/STR/BV-06-C [BSNK, LC3 24_2]                Passed
BAP/BSNK/STR/BV-07-C [BSNK, LC3 32_1]                Passed
BAP/BSNK/STR/BV-08-C [BSNK, LC3 32_2]                Passed
BAP/BSNK/STR/BV-09-C [BSNK, LC3 44.1_1]              Passed
BAP/BSNK/STR/BV-10-C [BSNK, LC3 44.1_2]              Passed
BAP/BSNK/STR/BV-11-C [BSNK, LC3 48_1]                Passed
BAP/BSNK/STR/BV-12-C [BSNK, LC3 48_2]                Passed
BAP/BSNK/STR/BV-13-C [BSNK, LC3 48_3]                Passed
BAP/BSNK/STR/BV-14-C [BSNK, LC3 48_4]                Passed
BAP/BSNK/STR/BV-15-C [BSNK, LC3 48_5]                Passed
BAP/BSNK/STR/BV-16-C [BSNK, LC3 48_6]                Passed
BAP/BSNK/STR/BV-17-C [BSNK, VS]                      Passed
---
 unit/test-bap.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 46ee0e4e5..20609694e 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6343,6 +6343,214 @@ static void test_bsnk_scc(void)
 		NULL, test_bcast, &cfg_bsnk_vs, IOV_NULL);
 }
 
+static void bsnk_state_str(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct iovec *cc;
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (old_state == BT_BAP_STREAM_STATE_IDLE) {
+			/* Check that stream has been configured as expected */
+			cc = bt_bap_stream_get_config(stream);
+
+			g_assert(cc);
+			g_assert(cc->iov_len == data->cfg->cc.iov_len);
+			g_assert(memcmp(cc->iov_base, data->cfg->cc.iov_base,
+					cc->iov_len) == 0);
+
+			/* Enable stream */
+			bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+		} else if (old_state == BT_BAP_STREAM_STATE_CONFIG) {
+			/* Start stream */
+			bt_bap_stream_start(stream, NULL, NULL);
+		} else {
+			/* Other state transitions are invalid */
+			tester_test_failed();
+		}
+
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		tester_test_passed();
+		break;
+	}
+}
+
+static struct test_config cfg_bsnk_str_8_1 = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_8_2 = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_16_1 = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_16_2 = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_24_1 = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_24_2 = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_32_1 = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_32_2 = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_44_1 = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_44_2 = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_48_1 = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_48_2 = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_48_3 = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_48_4 = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_48_5 = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_48_6 = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = QOS_BCAST,
+	.snk = true,
+	.state_func = bsnk_state_str,
+};
+
+static struct test_config cfg_bsnk_str_vs = {
+	.cc = UTIL_IOV_INIT(VS_CC),
+	.qos = QOS_BCAST,
+	.snk = true,
+	.vs = true,
+	.state_func = bsnk_state_str,
+};
+
+static void test_bsnk_str(void)
+{
+	define_test("BAP/BSNK/STR/BV-01-C [BSNK, LC3 8_1]",
+		NULL, test_bcast, &cfg_bsnk_str_8_1, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-02-C [BSNK, LC3 8_2]",
+		NULL, test_bcast, &cfg_bsnk_str_8_2, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-03-C [BSNK, LC3 16_1]",
+		NULL, test_bcast, &cfg_bsnk_str_16_1, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-04-C [BSNK, LC3 16_2]",
+		NULL, test_bcast, &cfg_bsnk_str_16_2, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-05-C [BSNK, LC3 24_1]",
+		NULL, test_bcast, &cfg_bsnk_str_24_1, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-06-C [BSNK, LC3 24_2]",
+		NULL, test_bcast, &cfg_bsnk_str_24_2, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-07-C [BSNK, LC3 32_1]",
+		NULL, test_bcast, &cfg_bsnk_str_32_1, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-08-C [BSNK, LC3 32_2]",
+		NULL, test_bcast, &cfg_bsnk_str_32_2, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-09-C [BSNK, LC3 44.1_1]",
+		NULL, test_bcast, &cfg_bsnk_str_44_1, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-10-C [BSNK, LC3 44.1_2]",
+		NULL, test_bcast, &cfg_bsnk_str_44_2, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-11-C [BSNK, LC3 48_1]",
+		NULL, test_bcast, &cfg_bsnk_str_48_1, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-12-C [BSNK, LC3 48_2]",
+		NULL, test_bcast, &cfg_bsnk_str_48_2, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-13-C [BSNK, LC3 48_3]",
+		NULL, test_bcast, &cfg_bsnk_str_48_3, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-14-C [BSNK, LC3 48_4]",
+		NULL, test_bcast, &cfg_bsnk_str_48_4, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-15-C [BSNK, LC3 48_5]",
+		NULL, test_bcast, &cfg_bsnk_str_48_5, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-16-C [BSNK, LC3 48_6]",
+		NULL, test_bcast, &cfg_bsnk_str_48_6, IOV_NULL);
+
+	define_test("BAP/BSNK/STR/BV-17-C [BSNK, VS]",
+		NULL, test_bcast, &cfg_bsnk_str_vs, IOV_NULL);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -6351,6 +6559,7 @@ int main(int argc, char *argv[])
 	test_scc();
 	test_bsrc_scc();
 	test_bsnk_scc();
+	test_bsnk_str();
 
 	return tester_run();
 }
-- 
2.39.2

