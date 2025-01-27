Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2053.outbound.protection.outlook.com [40.107.103.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1491FC7CE
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 09:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970222; cv=fail; b=RlltTY67joy5nv0qUm7QA/FGBfFl7LtaHUUT1A13TP1wbmnNOcqmyHWs/Wie+R0NPH2jbZ/V5OCX1K0eVr3vtl6RuUeSVTA5RFGarBq1r4iLMRwCF5A8HCwGsEblfwdTjX4IBqYHAwfN+kDkJkIlMiszO4jsNgHtSSOgZfPUzUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970222; c=relaxed/simple;
	bh=QT05hO4No033S0ldOZIHAbHxzbj6kF3ChH1kXGUeXF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CdmGxySHUWQalwxCOzxwmGp4Sv2p/5OCK3ZFTK1r0V/QTQ1oNC+IlymGjQSGcnAt2zyZ9pIsorQKBCcXlBVEdbG2gol9UD4eqv7gIEI9C+ZMzMGZ4C5Wqkfnj7sVjTlIQX5+i8mxCWz6NuodZ8eMy/KeHQVkCqxqFI3tlXspqCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dul22wqh; arc=fail smtp.client-ip=40.107.103.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dul22wqh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eg7Xs51ixVV9sv4k7W7vJjgMQxJFpxSJGrYXgQgYCMjIZc5qkqsZITMzhkexTAq9IeijVhKMiH0D0zKlBvfwHtE6uHjyrGXjmDVL116kk0mYkxsQaxkkjltsv9E42sS5+qJXvqVuPYo6tMyp0a4NQ4qICAVKyWLHarL9wUMzVcWFoHNJoICGWVaqOUAo3o50wo0qzoXy/Kc5LPTGiz9VXeYrRkPVv3UW5LCltDSPJEcWslKhqPGgMCNaSKm1rWphV6xy7p4Y6f7K7yRSHwI1iUt9QemGaoBIQX+YkdyADL9NShgSRf+DNN2U/yARQZbT/IUH7CicKFQcxk3GZWaXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZInTLv13rODDSanj/YxyIWuJa7yoFrG+l6zHvRseGZs=;
 b=qtbo7ZUEqLx7O6rUj0TlVnP4r6cjJc3nZQDS/zc+i9a7lHfcUPBMTvKOe9agItDzNe4mTxm6PrXYUUTzFgviuylJAfwPb1eWgnmo/GXbHf1jSvlxTVu0OtkbqtM2xWLjDgdYDUMPVUZkS/EW+oWiQZ9Y9jVkc5VUW9za8Drmj4ZnTIGCRavz+bZzlz6QrhkhkuNfFQ961eTjYz6GivqOJ9tcMYRe8GYIdnlDDbfdmSoccvdj6T3u71f4uJckbHWLXrluowwxpHhPWcJlhdRQNrqA/ahHl4LjuSe9Uh5vF3JzzHgMxKWr0VDGTavBYT8qTT2kCmQyEWJEGv5wgPfoIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZInTLv13rODDSanj/YxyIWuJa7yoFrG+l6zHvRseGZs=;
 b=Dul22wqhLyxrImYnwUEGSYIsTMWlCPc114FWww0TqdivKPiNXKTMuX4gpy2WGn4BRuk918d037kBFjqtCPbdBbWm2b2wJiLOBoYasLGIuoEBkTH8MEl4XQAgP1cGgObgWuE0j62SveBtQVYe3xqzvPAYR+igZgBggngYiaL7CEJzSKeJsavBYPP0ASBezYIfOd4CDhxkDXNuh8GKzOsDsXyz9MBamnhwAo6DzKHLfU9usi89xV5/0SAFZp4K2pa+KNtjz15n7BJ/0/9zIRzn+jNJCL9umvDftWXqYpAQNrGyj9l3EV5XdDHq7xskD45Fx56OwCdIDjRbPqiyOp7mkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 09:30:19 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 09:30:19 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 2/2] client: Update transport.select documentation
Date: Mon, 27 Jan 2025 11:30:04 +0200
Message-ID: <20250127093004.19268-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250127093004.19268-1-iulia.tanasescu@nxp.com>
References: <20250127093004.19268-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0076.eurprd04.prod.outlook.com
 (2603:10a6:208:be::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8de2e6-be40-44d3-fb7e-08dd3eb536ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ev9t5DYcdO72K12v77wRlwjmxyCpv5vuzeSo5wWypI9zvgRZN3UIleTDQ2Vr?=
 =?us-ascii?Q?+7jWvznWR8x5g4Hs4weEjKpJZdSazmWZHkqLHAIzJ5qsvefYEcwDXfk8XJgV?=
 =?us-ascii?Q?+sFL9d0Oc5VBiInrL+FY/5/V1w8NI9WnL2vW4P9+gbtSYLv0NtizoWxirot3?=
 =?us-ascii?Q?dxiJjJDbSYK0YK3m6vL6gGq3LRqcCXKdJmTAP0HAk7Mq/DgaUh2Qyo2sCC6m?=
 =?us-ascii?Q?YFIRnZdDAUoYqZY6huV1/CFU3JJ7CA7KwrM0u6PK/shTpISRgW9rHRPSvFLV?=
 =?us-ascii?Q?FukiQAl+Sm7HtynQdJw0SlmT92gxhWbfwI+bQOiWfbaiBMdbApaBOVTrdqlG?=
 =?us-ascii?Q?mjh1xSwqnvXfobNHcmDLuf5ohf7DY7i+2vobV2gi1Ja0qGfU6MXI0uv99fjl?=
 =?us-ascii?Q?Oz305jxKqtMyvdqkZp2W9elFHNQIKSAED+Uu8Efcsbf/cmo8n883o987S4hr?=
 =?us-ascii?Q?1uzgspd1pmaYXG0xVCZGvK2A/IQ/xQ1CqZHb5M7BYd/P5vTJ54XeS+E6kyO3?=
 =?us-ascii?Q?17rk3aJHSfsdkIQz0PN+hYFiZShRTVy00RMwojXsyLqtD9IbaxK8F9BdFAHF?=
 =?us-ascii?Q?uzX0qEpVGvvMp3KymyOFcgWOH9xO+xR3M0om/W+A5exVlCHS61g4icnzov5a?=
 =?us-ascii?Q?BsDbdQOaOH9l/fYKUOUrjPxH8ZdWmWFAeO31BNpoVeIQZjAj+VssKCMgCdll?=
 =?us-ascii?Q?vV8j/nFp/UnUrot8w0KOLD+fTi+rDsWFLNISBkemZ68YX9m0ATPcpp4sRasQ?=
 =?us-ascii?Q?/nVwpKIVFXZ2vjVWVM7ps8AC7yHuDfofUEIx8UTMfsIuVSM1TmAeg4hTo+io?=
 =?us-ascii?Q?5ByIrORr/2Ad+uyw78Kg4LUeHilPl7WQSPPxYoOz4+avs64KSHyAk6aWgvge?=
 =?us-ascii?Q?MDrfAU1RKuAbwmjXjEXVgxlM1DVlmHFTz8mGLqdq5zyQl6WqBNjBMOrS2dQF?=
 =?us-ascii?Q?nLjRCvw36BzuBd+HRzOTEUTgnT7iaIVAJzVHahwM/Db1ufkZgI8jpL6fWlRx?=
 =?us-ascii?Q?kpxH9n+BgygOVGl4RIAieiY/2Vo2jrA4UAD+f9ebndsvi0L/DX7ksynVsFFY?=
 =?us-ascii?Q?6oh9v2ybDLvbrm4VFh5IlUiCPyuVG+/wMSxBkHElcEZTqUqkzfobIcyBMQhG?=
 =?us-ascii?Q?39O3WlMbflK+BRz/2g6n+CnjyP49/522dYRb9kmilcFbqtvNdL1Kg467BdjY?=
 =?us-ascii?Q?ehEWzI47Mw+NBMQSCURMEvh5NB5VEwGbBphMMUK/vXSifJOYUPq4M0jMbZMp?=
 =?us-ascii?Q?I1hL8EgtlpH8XceY5S77dbmva8/+AY1e2efGkkBmJ2p/e2i7RoiC7J4yQVhc?=
 =?us-ascii?Q?REoIKK7el8UKLboiJcx7jz/N4BI35obmNNz/hWqx5CiwsAXs5qf+OcJ/4BSU?=
 =?us-ascii?Q?kB04cOhCciHAaIYULK7RybYBZs0i?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7YInzju9TZWoTRELc9sK2N0QVmckcPjQ71AxBpHN634csoFzD0O1SQkNzo/?=
 =?us-ascii?Q?kKxuC0GV9pn9vnIj0310hHZ2ZadoUxHWDCTnv2z45eYAnKVbTVEp1NG0GsqQ?=
 =?us-ascii?Q?4sII9S0eVHx324CCzoHbbeJP6MqIJyQz7QjziyNKLvOzk3h95hhZmiYRQ9+9?=
 =?us-ascii?Q?hXBuQJJNT7Pd12Ca0eukLbmhYfym7FGOrCKVZ+HAdWZ0kUPgHMsXwBqrzIBZ?=
 =?us-ascii?Q?lBz4Z1EaBl2ezwI+iCZgAKK5PJl19hCB8h5reCO3MsNic46iiEOkkcDSnmyC?=
 =?us-ascii?Q?uP25kJERq0N0cOcDIglRE6CVew84QTPxtFYAE8sIhl4NBkjY1eHo0harpzdy?=
 =?us-ascii?Q?vAm8h2qlO01j/0o2DLafAIP1913W1ZXJNtw8/6vXF/o3t/oFMSZIxTH7pFLY?=
 =?us-ascii?Q?/ppW2jxz8WZl/HLLaZ7JYraABITdETO90voBb9bWBVjELGoJSbWpMKE5suto?=
 =?us-ascii?Q?FtFTKJ0X1ZebnGOam1RXBxcWUOXASiQQPucWFTEbpGNY7LwdYKETq5FVSqEy?=
 =?us-ascii?Q?bPVUx/jAVNShhmjvCXbyxwdSZU22ynLmFUEVI/2gUTcvcTRZEUDBFEorVQ0j?=
 =?us-ascii?Q?zu/sSVaJG2WO/uZ6U0p36qCLGCVmj+UPvF0yCPcnpXmLRKmZ6FySfGXmH1fn?=
 =?us-ascii?Q?IPC0+CiNNayznlqKLelW3h3TdXWLz1CtT3n7OhwWsTWCIw5T2kDe27l15oPH?=
 =?us-ascii?Q?w2T/B7u/FFfp2k/WZDaODTa9gcn31YRr/heAN/5FkV71ljcGWd6DoDQmejTI?=
 =?us-ascii?Q?XMM+I/JN3NEvJSHsKoe2qUiN6CIeEsQ2IBPjA+BouztLDBv4IoyDt2xYcWVD?=
 =?us-ascii?Q?kAN1CzKXEQIibngS8dzRTJEhyV4U6vo9v6doQ6GUaOTblIwR/44D6eWlW2Eo?=
 =?us-ascii?Q?WtMeMsLJw1CZcJ/YWntg3FN3m3hxubNakYIU49h01kfHZusVvdhUncURe41h?=
 =?us-ascii?Q?scyXC8f7aHwjx4rClGGXsgbKK/XNCg8lFkLXtmj0C1hxA2BfZEnnosaYNa/N?=
 =?us-ascii?Q?rYuzXZCynUGX3VYACWvDLJjiPuR55zBhI8GnVBdrLGGa5JNk5TYLGwuOMFqD?=
 =?us-ascii?Q?V4vg9eJRf4cvTGriMCgS7K6bjknRiKzVB6AzaT6dl2EWoKt3P7ZYulo9B0pS?=
 =?us-ascii?Q?NsOo7qNJvIAxnA23dBQpVS3GJLDoS7Qlp+u4hRkVbUoTgg4Buvo/A0tQVZa0?=
 =?us-ascii?Q?RR8Wq5RCii4TScFz9W8TgP6FMupUB05rqewOgGehU+FeUJw9/RcPiQi5kAEi?=
 =?us-ascii?Q?563b9P3f2fXmLrU9b2qCo0HngKysKcWCjY2fsaklbHc6FRpn/pnFS00Q4dzM?=
 =?us-ascii?Q?nd9zVYgEW+329acptZ2Cu84RP6ni97cwO0SBplhz1wVBBaRoz39LA+UdT7SH?=
 =?us-ascii?Q?CaFWOXjP9QepiVSrW0qzISBMUxEklulzCMqJ2KeO4z9KFAvdVqzyitxVUs92?=
 =?us-ascii?Q?OF18139CssGE1gihVxD6x9rI450o1wDF5Bii/p5INbCrRGw3+6v/ZC8NHiCj?=
 =?us-ascii?Q?P5tDuvlKB6f+9OrOO9uyqZt/B4qySH/aqn6pXQrMKiZ/qV2pGAPUKxeNO+UB?=
 =?us-ascii?Q?EsfKjR7G4mxlD25jtBNoSE6ibcvi+TPxpe4HYQVd37ce53WBdAUovF/WHUuj?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8de2e6-be40-44d3-fb7e-08dd3eb536ed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 09:30:19.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQVcjQcfTTIOEnCXfVt1RhcVu+Cm+cILp73+ULzgd33+H0tm+O70ZovrkyQCbBpkCQNAC8U671ueFv8ZO/d0hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766

This updates the transport.select documentation to explain the expected
behavior when selecting multiple transports and when an audio server is
involved.
---
 client/bluetoothctl-transport.rst | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/client/bluetoothctl-transport.rst b/client/bluetoothctl-transport.rst
index c7a57716f..39b7fad2b 100644
--- a/client/bluetoothctl-transport.rst
+++ b/client/bluetoothctl-transport.rst
@@ -56,8 +56,17 @@ the transport to the "broadcasting" state, pending acquire.
 :Usage: **> select <transport> [transport1...]**
 
 Note:
-If running the setup with an audio server that has LE Audio support (such as PipeWire), it will
-prompt it to automatically acquire the transport.
+
+If the select command receives a list of transports, they will first be linked using the
+"Links" MediaTransport property. They will then be selected one by one, by calling
+the "Select" MediaTransport method. After the first transport is acquired, the Broadcast
+Sink will create fds for the associated stream and all its links. Each link can then be
+acquired one by one, setting the fd for the transport and starting to receive audio.
+
+The select command does not require a local endpoint to be registered beforehand. This is
+because if the setup runs with an audio server that has LE Audio support (such as PipeWire),
+the audio server is the one to register endpoints and the transports are created as a result.
+Once a transport is selected, the audio server will automatically acquire.
 
 unselect
 --------
-- 
2.43.0

