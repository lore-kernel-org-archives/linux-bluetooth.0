Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1282957885
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839894; cv=fail; b=V/8o8n8C+vTsFxzh6Spj6LhkwDgZ60AfNDm/IRyoky6qjqktIPFKnDoc3y1QRpgBwGNhzpb14LWo6HSaXfUi5XOuMrSFx/gjPJpMJb+rcGXa9LqTfSgX/QYDe6hmYYQvnUUhO2GsEClU9L5AKO4uulInQN5tZ1xs/vyH3DO+9uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839894; c=relaxed/simple;
	bh=1QqaQbVpsgeQJxjuKtuxQ3EE8nMZQ02sKlTz+ErpVgE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gBVQ91LR3bVKSQCnljPvR5lV074X08AOntpjj58jC8ih+EFyFFN4iu5roq2NbTiQH3RrhABHyUTjwzYRE1DBlTmKss/8wkX3ygJETCJyA6RD00agA64rlVRQQsVvzQkl2e/FEHgJVF7mnM9hlcujxTmDBg0Bhy0ivOWh5Ce0dY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FhD/+yZa; arc=fail smtp.client-ip=40.107.6.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FhD/+yZa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5AS7D+wSrisCDV+mnrFi7uLymPJd28tuiGgkSmBa5qrdmvlXnTELXXaEo3zMJc4eJ3ZxIiUbdHtt25FxE+a3bslTe8gWB8ccSJwIvFyjU4KuCpjbVMIQmbZFspms5HbxOqaUC5KQxTuuznfGoqq0mi42SGwg1C99Z16T+9i8KH56JCaZdWPTKlez+8P7+Y69t2vQSuoIocKp1EDkWkplpNmZvNOtzN/2frS7hhGahVvDp6yk7Aj3uPKgUv9vgHjbTQvjsCGQgzTEH1owtGcuDGMYSplpIDacqCYFTuuRpJ2bInVEKtAkRAFO56qEoBYp294yTMJvNcmKt+srPxiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFfWV7AOzeMI1eEeVysPWEpv9Dpgve+MzB6/+ttQ+CE=;
 b=ZsPPDNyCEUJSz6HcZwmE940pKLgLaPbs0GJI+icj7PUPc1y4aBGw0FYjq/lCrf0pS3E8E4RLtCpWPXH4Alf5jVNrCQwVonIGxH7OJR0p68bn9NaMsWXIB67D/oMtTpAAid1X1hnfOTZlCKt0LY/xP0K9yalGkZSRjvb3c21GPORWMdk17952aY/GBCSS9Y3KR9C0s8JCn5Q7+bWluFwlksd3PKOYu1GagBeAm6G5jyexrFQkFMcT/n+uWgnfExA1vz5smUi2xt/bOFQMqG3nNm2Z1W4kPTIgmTvIpp/mn8Y2vfyRYLBfDXqBmp1cufRzkyq3kGnRMjTBSRUQGEYOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFfWV7AOzeMI1eEeVysPWEpv9Dpgve+MzB6/+ttQ+CE=;
 b=FhD/+yZa/+Q48v7SZlflS9O2fdeNyXecrdgP2YMsGxotmhr5ukCBbnFDIGmgKVxJ9Kaxcow+mWp5m2PljPecFTtkeiyWqWQArxZxoYWQ7QW8hErPYN9d3MVMVor7XInnTg7fbS8jjgVlU/SDza4YH1N9vPSWrDa1RgkdhDY9Pik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8149.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 15:58:09 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7249.041; Tue, 13 Feb 2024
 15:58:09 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] btdev: Fix set PA data array overflow
Date: Tue, 13 Feb 2024 17:58:02 +0200
Message-Id: <20240213155803.3159-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0254.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a249ba4-7377-40a9-f571-08dc2cac932e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n3qvebBDeX/HF8f7L1YOSbBs+Ne7cVDgXqZMOYSP7g2ntauvUNMv1XyDPPVgVWWSdhWgisLLWdLXzSEQcLNVvML3oxKhAX+iI9eigauix5lVyofOb4Hn9/HjY7TBomdwSFiVWn/GYnVocNKElMkNzsMpWBHX7hHjujabsZfAO+jpgoOhAHwP7a5oPWfXKyCgcyxF5eFN8Dl3p9V/r6djFwAX+IvcUOqMnCWvd6bXIwET4J0eFKdLnzAb/OnXy+/qzZucfg755DRssCe5yekt+sLk8+fn1W6G9B2IXBbIJb+gcxjdcUjiX2P9sWkrxdS6awqWmgDwyPg6zeifQLlmI4AnPNlMcCJ6bdWjzNE8OFbjmyPUm0unCN+6kQiR/TOpXHXk4Ll2DqugVJ9FKh3qNEffoyQ8CE8hNcVRc3Vl7lBNuprSEf0wwk1mQ3H56sRRJxK+YjXS/4PfLf6FHr7XEZZ43mqQocRL2hWR2deU4hgiqGLx/SjVLPOARr/dnYMBFbkd6Abu3mIM6ug6IF1tQpxnafNtuLMErLCtiAM5VRPvA6Em5YKrPludXTtQ538G
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(4326008)(8936002)(66476007)(8676002)(6486002)(6506007)(6512007)(66556008)(66946007)(6916009)(2616005)(38100700002)(26005)(1076003)(86362001)(41300700001)(83380400001)(478600001)(36756003)(6666004)(2906002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XRRTxdLqxi6ZVCaNvtMwYBAImpPU4mTb3w0Jhuik/osbhm6+T7/ETGHy5KZ+?=
 =?us-ascii?Q?aMF+xIKKDdjnz2sKrTFm61A1Rrmf5fmC2dMGoiVQpyTF4mKVhIvNcZF43XQr?=
 =?us-ascii?Q?tk6F1CEIJn3MHbWAjiUd1EtDHB3cqvxGPa24f1cH2Ab/5fD6FSsr8IIUUd5R?=
 =?us-ascii?Q?Ok16aoutLGAjfGya7qW+Zcv/N8YdazAAsS8iDFcXYi7HEpoaRzGBj0Q9YLym?=
 =?us-ascii?Q?0vHPlwvGh53t47E6PYundLaWJIhSjKThTK9EHTiuDJHAgBsvgXG4KhC9GQTV?=
 =?us-ascii?Q?mLRwGLQHxSaRWcSKvr3cQqWqWPZaPJGlU/Ab6fPEav2QdpuGYId+NHzcyfmA?=
 =?us-ascii?Q?e3VR4kKj5NSLkxaqK/+6KYyCndIlz5zRn4jvNSg9/77dVAGd9VDJN4TbG12B?=
 =?us-ascii?Q?rXkbnU9nskA0yaKbGLN+c0ynj+CAgojDezq+XCduHVXgtDLP0NNWjwQ88c24?=
 =?us-ascii?Q?m2RQhFsRGv4+bjyNqzFGjzXOXv72tGcBRVtq77Rd8IlGuRCLt+jYupo2kRq9?=
 =?us-ascii?Q?E4WLzwSnYGOOzNUpYU+NDZdtgiY5R3rlENrM09sAuBQnNp8I5CqbIa8WMZhx?=
 =?us-ascii?Q?rslpmNHobtuh09TjjXdxNHPNMLYO2i65s/7WEsmTObPAGqyqxvcL5mavNkp3?=
 =?us-ascii?Q?16Wq+wNQsvmZGj2pDlIQBTBzyZRTTK1e2sWI/0lgkwyhNWDqbGIK/e9FLg8d?=
 =?us-ascii?Q?d0Ocf8aP41oW3oKo6VHibE2knAzo7E9XHskIiFPXrWclZgpOPofQG6cAUM2x?=
 =?us-ascii?Q?Y2Slp4QH9GzQtt4fF4lzy1/RvjPDrMO9Wkedv9F1I4aXScTUNz30rj75jcji?=
 =?us-ascii?Q?BQDWwY4sRsD7BjMyAudzXiJ9HVfmfwS3ygKNRkfJNTp6+ge+N9FkaOzyROiU?=
 =?us-ascii?Q?FNlTTPFKcyW5EW2M88Tegk49EnXYPemLLN60Qlyfxq42/KmdA5nGyMq3F7Zi?=
 =?us-ascii?Q?u12fKLp0hBAnVmDOKDBHrgZKygUV7OnT1lAjAHqq+hs0ghcpbQhZMv2oxKyy?=
 =?us-ascii?Q?OESEW1cMSpzWv4ZnnxKiLTYqzvddbtfPyCasgN4Z469RDhY4Uh1ErBulRB4V?=
 =?us-ascii?Q?yEPafMlYr0jO9PE6pUQAcsmueGArswXgUz5krXncqLklb3/RCJjtVPtVo9p2?=
 =?us-ascii?Q?rxrPj5xYteLbaP6vZZ8ZCtZRXiwnQMTm0R0MRH7yvNLAWG17GHInMv+tJqyk?=
 =?us-ascii?Q?bI9U8KrVjw+WF7it4kBGevF9DFoXGeCtFl5cuh5aqJOR14UKcL81Iw34wfno?=
 =?us-ascii?Q?tcpKw82j361Ilpwm4MGwoPiC3zWTV4CzkxUgetOX6xsnGL9ZUWj+BZ6OAdrC?=
 =?us-ascii?Q?oJJn1T1aGXAlmYv3fJcLpT8eFCR9HfRJUqUmT9l1H0dprO2d4medZiMwwjX6?=
 =?us-ascii?Q?hBEzk94wrVnqgCCUR5Bb0KZ0Vp3SW1CV3XTnc/4mlYO9qhfbWMQGJe1ZVhxM?=
 =?us-ascii?Q?hTq3F389QtIUOsVbK12bkPacQX3b0ZMI/l4rBn1CX65Vg8i+PBqPt+/perrE?=
 =?us-ascii?Q?JIrnWZNGJET3LypbVYEzHIKtC2vdIQpGNXJ8KEdWPLZ/1RXQNfLRWhRACiUr?=
 =?us-ascii?Q?JjILKXimXgoMdLXCAI+mCt3eATmp80CSzQ9MwGnieRR10zM4WfXursCwKAM0?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a249ba4-7377-40a9-f571-08dc2cac932e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:58:09.5842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmG3yHv/HC5InvmjJlPMHOLW7YkeaJrRb92+8vSR8vnkB5UlTnW2FCVvxLbn9shtaa9jo7C5QpBAf+PGjFth/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8149

This fixes an array overflow that can happen if the user issues the
LE Set Periodic Advertising Data command with data length exceeding
31 bytes.

This can be noticed when running the Broadcast Source/Sink scenarios
in bluetoothctl, using emulated controllers: If the source BASE
exceeds 31 bytes, the PA reports received by the Sink looks something
like the following:

> HCI Event: LE Meta Event (0x3e) plen 39
      LE Periodic Advertising Report (0x0f)
        Sync handle: 1
        TX power: 127 dbm (0x7f)
        RSSI: not available (0x7f)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Incomplete, more data to come
        Data length: 0x1f
        25 16 51 18 e0 99 89 01 01 06 00 00 00 00 10 02
        01 03 02 02 01 03 04 28 00 05 03 03 00 00 00

> HCI Event: LE Meta Event (0x3e) plen 15
      LE Periodic Advertising Report (0x0f)
        Sync handle: 1
        TX power: 127 dbm (0x7f)
        RSSI: not available (0x7f)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x07
        00 00 00 00 00 00 00

The second PA report contains invalid bytes that were read outside
the PA data array.

Iulia Tanasescu (1):
  btdev: Fix set PA data array overflow

 emulator/btdev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)


base-commit: 41c7f3af0352d3e45f4f10b7584e955a7f5cc696
-- 
2.39.2

