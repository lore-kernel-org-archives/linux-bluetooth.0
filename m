Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D718FDBC
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 07:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718611197; cv=fail; b=A4X+YsgQ8zzk2DzNqzKqLoJogkfrFPLKkJvW1NkvozBmibcUi3OIqI+/g52qt6jI5wcYdUarQ0A7wpiMuTx+YbPp/7Chyvvif0QapRUdXvoBfiFJxLUt5GvgBk4OskBBwID+XVtmJjX+ULuZ55FAORGt4pqw/cQx1kHoP6HtFIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718611197; c=relaxed/simple;
	bh=y0oT1wG59hhGlmJ628Z9i6UA/ttjnff6TVWKqg75Qh0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=M5Tarv7in40HzUTB/jZR5WLpIgtV9Esa0ixjpNn01D7fbqiTvBCYp8b22/NSWJHfa9oHh8y9OYWLZwbx8D6B8OpRcS437CrTLzFUT0Tth3VA/gGVISpJicyhy4QWRXLnb7CM0n1jEO8HISvs54mCXFRZxLzTgg/goMqnzXZxwmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C7olyZ4F; arc=fail smtp.client-ip=40.107.8.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C7olyZ4F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXtrLw7JvWCPKSAi01253DQhRfBYMYa95XDHlTStrZZtVw+2JalKjZfYQnurxZcCf97DA34daA4HNkePOSEPp6aeZZSgrRJ24x9WAlfwuFSKgtMb9DjOqsqvrsriaqiPOYml3CwGGyrWTR2HfzHIs8MOh0j3kbseuYYw9+BYYbandf3bQtJkeGQvckKUATPHZa3/pHra46bvrpd9GnsEPu/EBWzwsvFT4u8/WCKTuQJxprZkJ/woeqTh3IlQu1pfNHbSAon1rU2aFiYOlEb5fR/3PYXgGzvEcZrtm2VDTPN41+TmpDmB/TD9A7gAsr5hY9ik75lMwWH2y57d1PJVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL7lex6y3mluQPoq8S6rm4qwAE4CJFfmNVwimFEsdCk=;
 b=BTY3xgDqxTESNzP1b0jBnvrUnyzUWiC8drBe9Vl5S+1SdssHf9Kz0NhK95TYT8jItnGLya+r301CU/nBpejwMbrGndqNJw88Y7emVDtoJYTjFG9lrpMos+YIrCohoB+seVooDKi/GWbTrLjq9DTvmeofOJEp5m1b85EXAVNSxp6t1W2OeTgbY5f5QUY2DHeeDh/7bFAFtquX1k9yco4nW3+7pVZ7u6oc9lbZXwN9gPq9QGJ8B6BKZF6+8wNkaALnIGD2Q0oqnaQuJIyB6MLhaXh66o/nAN+Pafbp7hDIId6d0oq7saziwQKPB7k7+MAcYHv86LJt0zWB+Z4amngy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KL7lex6y3mluQPoq8S6rm4qwAE4CJFfmNVwimFEsdCk=;
 b=C7olyZ4Fo5/6nEOEfKPiANC0ZVXREvPRtR3AU4PoDCAZBi0+DvWjLyyZ2tdecPDWsGe2XXQurRdV/KWMOQsgTD6zHTi/viXMiso+Kr1t1hADeKRtQWOH0jhQNhKS8yxnCearpEN1a/CjnrCB2DixyCkyltsLE2BeFCI0gAKlT68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GVXPR04MB9759.eurprd04.prod.outlook.com (2603:10a6:150:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:59:51 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:59:47 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] src/adapter: Check if device is connected before clean up
Date: Mon, 17 Jun 2024 10:59:33 +0300
Message-Id: <20240617075934.154540-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|GVXPR04MB9759:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c9f422-c1a4-41b4-c0c0-08dc8ea374da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|366013|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Ikx9uw6weplYBlJB6eet+YV5GzL69FZA7NIUJbXQShOOLVFYl20wOLngOjX?=
 =?us-ascii?Q?iTzZipFD/78ESkCl9kfbVJPDzYDPR04Q1EYXBpSwKrt4zAaFKrHdxpWAlpsa?=
 =?us-ascii?Q?hk/pLu4IbzssJX/ywxX6RKjbwtBqMq6v4NYWDSybGWcNizQtogPJAWh6R98d?=
 =?us-ascii?Q?JVvUAIvb9IfQG5c6yaFt5nIJe5AedA/4kaWFZicTgvdt2+1bXI8hIJQEbuaM?=
 =?us-ascii?Q?XUNTj9Upv93lEOByKD83Tx2A2wvWItjBIUiuXjyUvpTJ8UTBZda9rRQJvR7b?=
 =?us-ascii?Q?xEyB936JlmfLHooEbREdzuo6aNh19DlQnmt8ChixjHz//a0g1ZUXBY2e167T?=
 =?us-ascii?Q?zV6TLyytltiSCtatSRVcgiso8uyzFmJbZDrWhHGTHH05S4JtHB7bsv0qOk0b?=
 =?us-ascii?Q?FXzgS58vJgTUxLqPpSYNOx+fIsq93Xpkn+LlxIKoOa/H6t8T1xwqN9IxAoT5?=
 =?us-ascii?Q?HUrWOj+YgGVgkAgzKlnTbRSAZVcKq0AD6ApGDKn4sXCKm21reJFr48llFBAq?=
 =?us-ascii?Q?t8Xzwz5QaVpCvNV/GYfYzL8h67Fg18OY0plVlRJW8XDuXKjgDcpX2Y8AoWsV?=
 =?us-ascii?Q?JlZWTuBQHPT6jE65lGhO6XM5y/WmAuIw07cOVkNzSAk3oR+ztTUsY7hHh1+8?=
 =?us-ascii?Q?cU97NiqbABvvlgDUeCr6WS3LIfqEo+9PB2U48MTSDmcFeD9tYsrwhSHE+EPU?=
 =?us-ascii?Q?Uc4G6uztKbTP5XgH5OSo7VZI9OM2gWrJynse+iZRP+V7OKp7lYV0HHKPYWNK?=
 =?us-ascii?Q?pR8ykIKNBiOFhXFYJUM1vL3ZDD0YaJi4DdfOcn/uktueWaRYaxOuSSxjYava?=
 =?us-ascii?Q?RBuYDVoS4MWr2xdopJsk2Pj9YurtpTb+aVulPLyJX8Pe3hZprUMo5kHyy7Bu?=
 =?us-ascii?Q?1uky9oRneJSqyUi4HL2y/2pK1wDWO67PQi/mmjZtEo/EfdB5bWil6qm7EL50?=
 =?us-ascii?Q?rN9FwA9PG9vcurgXARcxyDmmlE+Ml5xz0Bj8gb3Yvydu3peI/utSti3BsXDa?=
 =?us-ascii?Q?RnZXh4tOrpJ1qu0sylUyYmfOeY7RwV5DMJrA7uW8APOB/71SAIryb1MXw8jK?=
 =?us-ascii?Q?uKMHPMzu/kZ8BQajaUn7vUH5dl2EXvOsyW8eaIIyIp6AX8F3By8nDGchQgUD?=
 =?us-ascii?Q?CNA4RU7uMQJVpwjIbys/mmJgcmM1rk+b/+6HYnrTaY4w/n3CGu+JzUkpeHI0?=
 =?us-ascii?Q?YudCBmdaDCuqYDQq7gOWzvaWyCrxQoR3lakUQKpwcwxFn7N70tI2MTueQQyS?=
 =?us-ascii?Q?YJnko/PrtRQXsS0Um1AWl1xLX42ROKHQbXC/Qaaax6wEcA5O3HFVcOB8Fw8i?=
 =?us-ascii?Q?cgHFzt5Euk3ItMY9EPWlwoYIy/SDQmu693DskqJz4+tTQ6piYvp1Y8wIy/jK?=
 =?us-ascii?Q?XoR/AGg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2o9ZHzCEq5Mtffv/2cPTT0DNni2SWTsfJkMB8ZssnVFGwcXhe4g9bJRuR4Mo?=
 =?us-ascii?Q?5RlvnYJZ3ZMmHB8JwAxKqeCM93if5uI6J+wHKJ3Oa9xidW/0jB/FOaHuU+N1?=
 =?us-ascii?Q?N0UVNIRnBRIvQrkqf5kqMk17ZdqRx3WTveeJhdmwNiaeh+8GbnhmW1CXXtTl?=
 =?us-ascii?Q?RnFskTXSo3m5ra15lCqrP4bHet7I49WUI1x7/3fWPf5np3bfXBFCnkH6HG2o?=
 =?us-ascii?Q?wf+lOAnBpcjBN3caPIZ5ydUag0NxtKJoJkw27V4MSN+Qln3jJEhwa9KFTqsx?=
 =?us-ascii?Q?wdQ7+FTZANIDpM7d7nTZ6B1vnbSb8A9ZFUOs3ud9daTY/P087L9SM0H0g2BJ?=
 =?us-ascii?Q?ixQa+1M6cM8vodB0LZnsbyLNn4CcNfVLcARhBVThgCSOqEQh6EkuDGj0YQWG?=
 =?us-ascii?Q?fmtthKpOm85q8OUKESuIbhur3LtxdPy8Y9UPtot5cgr16gpubdbZ+4nRVCni?=
 =?us-ascii?Q?ir9QCYmupTtWmYgLDDghZT034pTdvhjQbfTOr/sxCHJjvZVnjz8r32uQbj6N?=
 =?us-ascii?Q?9pONXuEMmWjwtCqFKu7b9A9vYF1sGlxR6KetfMxBwvjrTJf5GPcfz0jvCxlG?=
 =?us-ascii?Q?Ot2xkFJ8GHg4C/vzSxXHNoIdPhMt4/Mvvap1j3UR6PfeJYPpopjnc37QGzAd?=
 =?us-ascii?Q?CsvzhJB4IfYsnMPwwzYzV+pxhjd0zm+na/Mvp0cSjl/6V8pbVleuArYy2yDX?=
 =?us-ascii?Q?R0KditwWhOMnwgnmip93MqX4l9BqspxOr/nNmqUejaCHANnLIUy8ca5NZYwV?=
 =?us-ascii?Q?F8mrWUnmKIlHXV5y9A/fvUdFiEXtktapoFpfEY/nTshaHAagjfZZVVv0AVPU?=
 =?us-ascii?Q?NjAIcVBjIuji5PyNKo7EV055jCWzcwfGAc+qiDzf5YH/CzKcJOQI0sPNRY3w?=
 =?us-ascii?Q?6IjbgBn3Ly3BzqqQtMf20VZOb3XjLKVEXd6M7LcAvVLUaMILJC/XpTHpEyP8?=
 =?us-ascii?Q?e1ED7XNLgJ/s6HiYvWvGdzK84xcIDn6nvDBMSNs31qcTS0q9v0R3/m0j/nN9?=
 =?us-ascii?Q?wRDSLbKgdnQB8HpDye9nVLHRH9CPa8exGAEKve6qrgXW3DHLuhm3EED3+xfr?=
 =?us-ascii?Q?LSMtqeAxDsCAhabbzai9Jp++FZ0AFx/SESbfJ8hq+bjpmfmjwjpeGh5n98wv?=
 =?us-ascii?Q?wdVXlp+t72SR9wk18Bis4V/paiB2jq/Io1wv9hdYVoPDM0Gpc1zISJKZlTtm?=
 =?us-ascii?Q?6sNDQQD5iL8j9I2lX7XapN95eajI2GpR6eu7SIbEZz77t9+T19z9YaqPR9yb?=
 =?us-ascii?Q?WjeMxxsHdVzpi/DwNGmiKCGtoc7FO0GWQ6o0TDo7bcLkjy2m7lGFCT2TkXfI?=
 =?us-ascii?Q?y8kqh6mG5zZvcfvUXH9ebu35rBXOSFQUqhxJ8P8v2JMNmirQdgNCOZ2xDprj?=
 =?us-ascii?Q?Ti9nd/TbDqm//BdU6AwOh1mIgO3TSNAFGiJEIr0NlyVc7q/GfMlcwINGPFak?=
 =?us-ascii?Q?FeX54GsIXysMLivbqv/oQXW5uHeHX8PS8fsYeQmSJxuDVx1eKCtww20bGBe8?=
 =?us-ascii?Q?r4IrKEW2i4mRM3uo35C0U9A7JkTrTgyHkCa6kQljh6uEiO0dkb9lR7trYmkp?=
 =?us-ascii?Q?bd5KOk6kJDpuATYFSDjBELmoLaq6OZBgXwU7S0+k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c9f422-c1a4-41b4-c0c0-08dc8ea374da
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:59:47.3897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgmd48SzcPoerMhE2hwUcM2TRkQriRRgUScU/M9WLMNLLIHno6F2eCQPDoWoVNKYjP5UDGWIJy2mFI8hxjmODQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9759

Broadcast sources are currently deleted on the clean up triggered
by turning scan off. Thix fix prevents the removal of sources to
which we are synced by also checking if the device that will be
removed is connected (sources to which we are synced are already
marked as connected).

Vlad Pruteanu (1):
  src/adapter: Check if device is connected before clean up

 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.40.1

