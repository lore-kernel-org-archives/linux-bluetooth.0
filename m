Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378CF3BB5E
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751951; cv=fail; b=XZUsp09UvUO0/+lZhxb7rsF5UvA+aeAhk+aigqWL1Wv2axIDN/J5vOgJELSpghODE34oxthy+mq3baVAUPXmxDfDM5AUqkUwdMHcPs1tn04vTtXo6u7LsgcWN+X7ryX2HO3b5TZ6gcpU23NIUEN9jqSF6gYloJfA9itBVL9Fk+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751951; c=relaxed/simple;
	bh=7OLgN60OSx0ZYELGTiiK+wqm9cRW4HV0WMUvBX/n9fs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s8Z6YskWpYNn0K/9h/FLm9/AQwr+vYWIalvLlAY/CBZb9nanVbkc68sY6elywPJVrA7oIsZEQ2tfdWpPJ2hrmPMSQSQFqC2BufcBLOk1sVhR9d4IdD5TE1Eb0I6z4a57g010F/za0+UOi2mGtlLWvsV67tpWvfg5Kb4XqGMuBt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qcxfumJN; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qcxfumJN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMOZfMdWsv2ra3dpDZI45CPVtyRQO1I2GuHkDe4lfCcYwxEoePx79tXUNJW6qy9xeL/b1IfHBVmVyo04ezAYh6Hleyi6NTNG8GIgQHaYM+iGJwfOLJHQE9q5depedTfEWMsKGMx5kkZBk5U7X00Q/W2u6h47Gs0En60tgUKBrfz+vFedIqelU9bWRDQlHZdXyw4rRzGninMyULJh1JkN7bjRIabsm9UZSVuDxrNq3FyxhRL4UIAYT6EIB9+il+72vAXoezN4v/qMDwv8qU8+HG46+X+rPKJqyLRLFhnUXSTTw5lk8uzeIcazjxmv8CJovb0IYh5DotBBLIKk6Ekzeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XGN5nJleiJD6kacCB/sZlrkvmWsCf4TTtqF+WVbvXA=;
 b=FDuzs9wN3nNHZ0Ip2dhuoyvpv7qfknbD55+0L3hGVe2Wff8uLJexXFpLZzkOmIW5smeoVIsi7jE9m7Mn/cWy5Ww42R/h578Eh4hANUCJoJ9YVrD9jiyGkJZE3Tzsfp1BOnXuLrrAki1V2BEZyYG83FmJX5aYTnBGNNpgaVTDniOO9R09Y3v6vnbFxKdRJJgpswysoraLwud11srvSGsuH6AWOK8p1vCIwcVsM1UtEUjRybpFbIW1WyxsCSS7mT1bxuDOLuRpCg2GssZryrjcmsOdXIc/f+trIq2wQWXgAP6nbSdAonwiW5D3K1dGmVSf9hBtOnMZJxCF/XZS2Jtb9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XGN5nJleiJD6kacCB/sZlrkvmWsCf4TTtqF+WVbvXA=;
 b=qcxfumJNHMvZMr3Ca5436Yc6Uli3P5UqJet6o/LZg+le1u6zcopnnO1HbvtHMWDsdES8cKFtqDI160Fye2jbsSLjGQJgkDOjIlqtvjZsmdQXHKDeXXgOEoS+i/bob/nfpvLJujr/77Iq6lb+v+YcwNKFXn0SLEWEnkGiMEOBpKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VE1PR04MB7439.eurprd04.prod.outlook.com (2603:10a6:800:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Mon, 12 Feb
 2024 15:32:26 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:32:26 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 0/7] [PATCH BlueZ v2 0/7] Add support for multiple BISes on the bcast source
Date: Mon, 12 Feb 2024 17:32:15 +0200
Message-Id: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0032.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::21) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VE1PR04MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 643c4ffb-f351-45bc-d2e3-08dc2bdfd0ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j7yBejC6XDVQG/It+VUnn9u4LFTY3DVFHYdWcKh5dzgBYFg1rC/7TrWwAUo4pNNnrCTg8W3qWiS4WZn6yDYEFXP7v2jc0kyKd7ty7/w6Pn0T+07rM14bjsv73O6zvdJH6DxGuGS/Z8gr41A1a0MQS8p1nOXhZNI5cfibrCEtrvxsSnzZN4w3ObRT0Iqa14MurbSXi9GFzqPa978q+nDaLjN7RrUpzcH2oa5VQ7RipXkFRAjxB52g/4KiEsHmezrtxHDLtbPD4o8ByPEsb/1D9ajYIx1zcqIRd18kzZ/4kzaKW4SLLPQ5dQb7LR9depnnUBlaTNib4MFHF7Kkb5VFjOf3QxDbDKyXZ8dXPr7UG8VxN2QgKO9lGaO9LbjIx/K1FvW+WmSv2XPykFJ0x4W9ULZUX14cFV67Xbocebt1xWepQ96yGmi/OG/RD9W0M/DZXFZ/3AOzPkTmj6lLsCUaXpmwtoCTfCtyimUTfIsZV/TRyMqL5vK1dHLVgm4HDIyob+SEd3YWRLeLzAziNnUZHAdQL50fKhPdfRN16Ky7Y9EtPCuq8Ql4m0IGv3A/+zWY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(478600001)(83380400001)(6666004)(2616005)(316002)(1076003)(2906002)(6512007)(6916009)(26005)(66476007)(66556008)(4326008)(66946007)(8676002)(38100700002)(8936002)(36756003)(5660300002)(86362001)(6506007)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FcJsF9AO4y/P0CAPLus/ZiF5pbFxAVna53if58BaMfFTIXf3faA8rDixya6E?=
 =?us-ascii?Q?GeAOfeqpXrb8004eiIYRLwz7j2TDFAVSORNa/kodOzMwX+krKWcfyBQhEfZk?=
 =?us-ascii?Q?4iJ+wJ1o6hklgLHJguzYeZgZLMjYna0V3321VmbvyPVIOaEboTN0yzIvQvqw?=
 =?us-ascii?Q?6QsVPgZL3Dc+1CToj7Z25osYJCQlJj0hzNUFpHxKp8lrMZqNr/AXj+RUawYq?=
 =?us-ascii?Q?rx08jkwcnmxSjEfoyf6dPAaMD+0YFmKJJ7C0PJJt9S3CX0LDgY1YgOsvQmNf?=
 =?us-ascii?Q?paDlx0HxWoeLL6Dqljzfkp1CVtj9gGcNiqvGYDIuYzFT/0/zu73QslwPVcLJ?=
 =?us-ascii?Q?WdnB1DslzVRdDuQvxBdQiU08t7guJ5/QOeCxUfZrITEWt6RZaQnhM80XLLq+?=
 =?us-ascii?Q?HJMYpXlvAQebEFIHP3Va4Q/ejnGnrNjLwa3kUD0ZmHCMZvIapFgi8i91rE8A?=
 =?us-ascii?Q?i9oMss2r15H0tLZGCtEooV2y9axkJrEUMsKBgc5fDadgOyevdq5F8+sxfqYx?=
 =?us-ascii?Q?60dFlRhCIcFvdWR2bk3OdfzLDeksQMGRLD3LB/8huvD6Ff+vMQEQtio67uGe?=
 =?us-ascii?Q?VvnHFR1Gin9L/gajK+auO5Lhdn3UzZ0ux3XlNnvSG7/F7BenB9G3XgBwtDOx?=
 =?us-ascii?Q?XMGxwNYptGhKpYldVtUgUyCHJKunIp1sOFkBBwfN3QxrX6iydxRmfVh0q1fe?=
 =?us-ascii?Q?PwGjPmZMMkL2oJIFGilRxZMHLTbE+hR+hUSVK9jxXLo9o7X/Mypde3yifGEG?=
 =?us-ascii?Q?XfJaD8/Pqg8aSk+8zKGy9zGveTVskgqWg5DL8tEvnjAfJiZ7BQSlR1UAzVW+?=
 =?us-ascii?Q?3K7xvicykEEJSvB+OPeISRDHPSFLyFTflx0FYuRXgiW9jF6fzbp/OSWLWsdo?=
 =?us-ascii?Q?c+kT7Eq4e3xXx0Cihf9EVWxbVy1d9UK5KoS3U4zTJ4MaTFviJ/Y6VRDNwy0+?=
 =?us-ascii?Q?pII9njAZXsebruucCpPbdHkFvPKX0wzFAkexCxct2nymarlfstrDwdAxDCiP?=
 =?us-ascii?Q?uWdz+4ECzjKHwfo7t6nlaFRyMw37dQtg0stTzg5Y6UN7cuUv1nenM+mtVdzE?=
 =?us-ascii?Q?bi0H2dauj3IKapxSQY5PjA6lzn5ay9JyKXZzMEIIesjuP2LdZeE60ZzP2jYl?=
 =?us-ascii?Q?X+3H0NEobg3C8Hhdp+x+WE+krHSK9VxfA96wtPGyyylR9Bmb0UkmIzyvi8VH?=
 =?us-ascii?Q?hdtSpvJf3w2V4TB9gbeMGvmKj+PQub0zNKfw1ybYuE54zBVQHCPAlRKMvynE?=
 =?us-ascii?Q?bUz3+VM2y6BQX0SCrMtxewapLqMVHpM91SbbPGbgkw5FjUhX8F4Q6UYGOBQh?=
 =?us-ascii?Q?DCUpA9F/Lm9wvPVgvWOAFBwI4gUmZtswYqP3b8wza+5/bHVeUPS46MB4x62M?=
 =?us-ascii?Q?aeScsqvU2kt2pferpJe7C/V3lIMGFQnddf1FvOiphyrbRAkgQBaj8nUARLtN?=
 =?us-ascii?Q?THDkB0e8kva5LnrDus3s6azc5B458rbBFceCDaCb9VcRo4vA7s+75FXBNj2m?=
 =?us-ascii?Q?RW18iAcFKM/1DquwfQ9cNXNLBO8/Wv7ILddftwnspv5ZT10AsEtdHmQu8Y8C?=
 =?us-ascii?Q?ZhmbSR3coynCgz98d9yfO6IiSvFuf/ZZ30UPAMEBDLhxo4NzR/V9y1NT6n58?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643c4ffb-f351-45bc-d2e3-08dc2bdfd0ed
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:32:26.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaZnefkh6U+8E/kHDTBbjXu/zVukfFbcdTmIL/fQUKy8x4GNtKjkmrNK8BC7YXn8qum6GXUwlh7pPAw1q2atEGfEXvEaa6q8Un/oFxIu7WQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7439

This patch adds support for multiple BISes in broadcast sources.

Example commands:
Create a local endpoint and an endpoint for BIS1:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 0x03
[/local/endpoint/ep0] Supported Context (value): 0

Configure BIS1, create BIS1 transport and endpoint for BIS2:
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0x01
[/local/endpoint/ep0] Enter channel location (value/no): 0x01
[/local/endpoint/ep0] Enter Metadata (value/no): n

Configure BIS2, create BIS2 transport and endpoint for BIS3:
endpoint.config /org/bluez/hci0/pac_bcast1 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0x01
[/local/endpoint/ep0] Enter channel location (value/no): 0x02
[/local/endpoint/ep0] Enter Metadata (value/no): n

For multiple BISes acquire must be called on all transports
before the BIG is created:
transport.acquire /org/bluez/hci0/pac_bcast0/fd0 
transport.acquire /org/bluez/hci0/pac_bcast1/fd1
.....
transport.release /org/bluez/hci0/pac_bcast0/fd0
transport.release /org/bluez/hci0/pac_bcast1/fd1

Silviu Florian Barbulescu (7):
  bap: Remove set lpac user data at bcast ep register
  shared/bap: Add support to create multiple streams for the same pac
  bap: Create a new endpoint available for the next BIS configuration
  bap: Split bap_state and bap_connecting in two functions
  shared/bap: Check the state of all the streams with the same BIG ID
  bap: Set the generated BASE on all setups from the same BIG
  shared/bap: Generate single BIS BASE for a config with BIG ID 0xFF

 profiles/audio/bap.c | 318 +++++++++++++++++++++++++++++++++++--------
 src/shared/bap.c     |  78 +++++++++--
 src/shared/bap.h     |   2 +
 3 files changed, 330 insertions(+), 68 deletions(-)


base-commit: c1851987ca2c6e41d1e0e166e959b754e369c254
-- 
2.39.2

