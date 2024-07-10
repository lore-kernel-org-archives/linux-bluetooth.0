Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F025757
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599240; cv=fail; b=H/bWR87GM9QgteWg9do9E4KWAP16g6gBUQSsUQO4CFV8eW4lUSAchGJtCRuiNw6YQZvPJAehgNGHj9kY8TQPr0Edq2GkTbq96fU9IfKz4zuSvXK6mxjCbq4YK0NY+KRGmCSi2W4gPLHF0ejay7ubQ8ZmwQcctdDuotmBpPEYg2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599240; c=relaxed/simple;
	bh=DSHs+NcBt3wXZi19ZDNBV2eIwHafT5jB+XGXNXQWbMc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Pk2DHJd/S18ipmieInmI3zeCWcVjNEkmgL1aUpWSlVxs4cnHiQD7uHbPHLTAfF6Ez/dYf9vC1C7ip2XO6xqU4JTYR9NOeTHXeQV2lrvO0xK3u4GgSk0nBfHzaoEdGVdO8ymlnosUkybysXw/mAqxrUEZy7aUCPPbCLiOBbJYl1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gEqcJerH; arc=fail smtp.client-ip=52.101.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gEqcJerH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZiOsN2Dj9xq+cqMQz82heRwru5W5zv+TU9wdPlfKzi8Flt2z5DihCKO36m++1wvJ0WmMbFrlNQJmGxo8FV6w0shHL61IJMwcZzxFJAeTaQFicSeM9CLG6tUSdKwkWD+vIB3Ks+SWJGQaIymAauteB2rXuzUbbISTjZ77z+SOdkWZz3+en1whGBwu+TUBlmslE36MvdJ3LZAEtDHA6focwZw8JlENsU6+++xysBLQTZI4u6/j8CXPrqkGmPDdKcNDQSaKYU1qG6TRjvR0WFbePGxjd5uSOQeaeTYNXqSv9mIBeQ1m4/28TCwPWosdZBdyycD6OJxpqJ3vQBUe22vcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/w1C9TSM7ScPdKwSQZNej3wrKzruBSvU1/6cK/45+s=;
 b=X+eYmGVeu7rCUQ7dlpu3xojtMrjyH0E822EXFYosnEfZhWgbr4WUPT72U1itWp8Ei4eSsoLnWbT3qkpaiXqcKboC4w3jF1uH84bf0EBpmKkqytLNCGDnx80Ca6//0sQb3yhLHcEQtAW9rmkI0INzIIIRILqzW++yAhmM7RIAgig0bHJ5uWA9ICwtQMypO+Lo/44zE6C9S/FNIr446O4Vq53/k9xQ6l5zgNGirdRkWooRUp01/oYOd5grYUcaWGzfF1Kh/0/mAsEe5332D08vLL9Q/g5wEjC/LPD+3a492P3J+mHHI90FF8ScTMCw9qIbdD6eSwJf88HVrJoNStJezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/w1C9TSM7ScPdKwSQZNej3wrKzruBSvU1/6cK/45+s=;
 b=gEqcJerHFXs0ouho7noZD9o+xNladRdPQw4tpmDIq5EhynvNHNjisi/y3o1fDa2jG3f1lb+/AcBAS1XsKKW2BD18lgX6Y1RTIL2OwWphq3GW1qLBH9p4pypp8QAPXD3OUca9zB0PgNOSJS7lJbFeXEhc8jYU3brni0vT1yT6B/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB8864.eurprd04.prod.outlook.com (2603:10a6:102:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 08:13:55 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:13:55 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/3] Add transport.select method
Date: Wed, 10 Jul 2024 11:13:35 +0300
Message-Id: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0212.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::27) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: e10bd63e-e95a-4a2f-eb96-08dca0b83da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ahcAEkdS0vah2xLgaFIBWjKxE+N6iTFqPFow9nfCOlAPeeU9RYK/HPEukQdl?=
 =?us-ascii?Q?sormHl98U5UU0/dBW3H7p1qmRNNK8TChywjAAPg16EF90To2FaVXobdj4Sva?=
 =?us-ascii?Q?ZKlxZmSCCKGQ3VCglKaE74DVCLsKE0mYnI6j0kwUu2DQF04yGwa6NHMvq3uP?=
 =?us-ascii?Q?2B+88/gP/q5EznuoGeE+SMGG9AL+WlFDeFZlIXOt6MPxNhYz/4D+uZEwkkDT?=
 =?us-ascii?Q?AhtwkW+TLHKYAzWCGXtBghqeRWveIfBhTYmtbO6nefSPnMITvT/dgmiEh3yh?=
 =?us-ascii?Q?/MVpinzs68x0+fzPYj3HYp8MNttVL+EIcK3XCFdJeML92Z6r6jHtMGwMyQOD?=
 =?us-ascii?Q?kgNMU+RorL4SWSMu+aehJWz9C4W1CjEI1H9qh+q41glgTU33qhnF6NC13djY?=
 =?us-ascii?Q?Vv3YbD4PJQ8egi2Mhe63Lf92TILAg+BQi2gsmkRGuCQzMmqLmHr0TWOQiCv1?=
 =?us-ascii?Q?n9mY/OFHUg/9iAUpb9IKfeHqT38+9yw9A+S0QKwxEM+SLQiQ1j93VMViy1wb?=
 =?us-ascii?Q?zipF+FGDGNXjvtHoXn03TYUpdKCaxU92TsZJKUfsGOckNIB9+QtdudjzSAnE?=
 =?us-ascii?Q?53uokgc8CwADe5KKv9hn9OV+jR+m6rf2Ib8FKS7gTkQXdGRdnAovqOHBAIOE?=
 =?us-ascii?Q?nr7dYzUBbW8iMY0TfB1jsJoi2QgKNSJFsbYPBzX0NZKjxB+B3smE8nVrXMq+?=
 =?us-ascii?Q?Q97cBtrWa5nY/pWZJHc5LQFNlqwoiftzIXQMzHLVd+kjXkHrEIxkLLvSr9JZ?=
 =?us-ascii?Q?wBwtYfMdxas929eH6Gr5mygDWHLoCCeai3bp9XiiVoqFbMuxLtlQ850hev3c?=
 =?us-ascii?Q?to8/4IDKpaRy8fzxtTX141Tu+PWvAwSjVx2Q45ybeEilGjwajoL8mZ8uNflQ?=
 =?us-ascii?Q?Zh/UlWxCyGpVjCEG+JjSjACmI+0+B8PiZyMlyTnY6wLf3LA7gyf2saIhIFd7?=
 =?us-ascii?Q?SyNoQ4IISFG3ZFixhJo7TMiuuYbTcD0C7UdeTiWKIGZu9Z85AMgZIGlgD3y0?=
 =?us-ascii?Q?QPcAzcYz5ACrTWphgTdaywztEz7cu9W7jzwvIbgro77PTOe5Gu+cpx2XS22a?=
 =?us-ascii?Q?kpNCeQU0ESXDlYk5oRiSr/7XnRPbZNoZCZgEDphu1S29RGiccEN+CSBzwqGV?=
 =?us-ascii?Q?StHJ2rmrVRL71+DPiFnjzAjRWc/iOrs5yLkYlaxDxki1oF1pkW6kH3hk/4dF?=
 =?us-ascii?Q?bRgoA8xj5XdRYvCScEu2BsFEwJ+axTFkQ4+7oH2U19JG6LoESEAJvKfuVjXe?=
 =?us-ascii?Q?IW8XYsdkGf2uMiByWTCuGvP3HDgOyf211yO/N/4mvUVuRXKgS2TJ6j1bPajM?=
 =?us-ascii?Q?JJ5AnzQ6ywx8aya2d7uLYcogt0g9gEMiRFtdqAXKVAZqv77KpNN5E356G1N5?=
 =?us-ascii?Q?rzdSx039fGJFDxvnJNLY00nBUoF9ClcVqPRqU/PeRQ73expF+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uBqv5+HAUUwWLG3b5An+McWm8HDYzVmJCDsJI6ywXsFJJX5D44Qlpa6CpmJ?=
 =?us-ascii?Q?LxF9vwq6KTXYEXkX9um6AT2yIG+dmx/ntpQnkj3ghQoYQlhdfMQyDofeFvGd?=
 =?us-ascii?Q?yG8tPSdqX+A5ErP2JlWE4p9qgZTH5KqilBL3mRYRJV2I9R+z8aSCSbJIpeQk?=
 =?us-ascii?Q?VDg7jzlx1QyhmQMtU/zhvbJd55dnBgNQdiO0d2ZBtS7YvaZ+rU6dPjHhFMrS?=
 =?us-ascii?Q?b2gmmZIarrfM2CaEi3WIMW7fL4i0xJdqHQlFXPqp5ordYe00CdZhwRZqeX8M?=
 =?us-ascii?Q?nkakNqYwgbCHOYnez9/98QacyUFSj/TBVJEcOmcou3AfJnRcx48nbWqTeccO?=
 =?us-ascii?Q?CHs0De499FeQA7z5YNQs+4wVAPMOcn+vdGSJ0ZMjn6I7avwMo3jTiRe/6cKY?=
 =?us-ascii?Q?NMQwAZeO7QPfxdc0YGBTKv0ItUfPcaXw/ClwJ+EuJi6gEe9LKbpR6F2R4VAU?=
 =?us-ascii?Q?GV04XJnT9Ib8zzp0tfigD1x018hmdhtFBPKKrqNE0mKHSYRr1WGOT2TX0+ec?=
 =?us-ascii?Q?C0i9n3BvGDhhgLyTkD9WwaViAvx9599mNAroaD4pu9uZw0Cn0x9PjYKevLTe?=
 =?us-ascii?Q?js8Y6XuhNM3PLrZFQwOEl7EqbgPRocd489NI1o05udlSp/Ol/ikjU00tAFOQ?=
 =?us-ascii?Q?DrUHkzV4zRQA7FKWpOp0IwRU26YB/6nP4RZZzjAniVqeUOZCQ2BLJd46aReD?=
 =?us-ascii?Q?xvKbC4EyOvhBUYP6On0toDGksnsk6OmJ+0vaa80m2QJqrE32kbldsvoYqJoM?=
 =?us-ascii?Q?tHT1TZGvPjn1QETjNBZh51s4zHg6V6vOm9yQQulZQDSbVIf/pvpZXtdW2aSh?=
 =?us-ascii?Q?NAFPoHguKGalz2APVLtUbAb1pxWd7iqJvn3lV/QXRKogkYtTJ1KpEWcMVnCe?=
 =?us-ascii?Q?hijCEiIEADJjm3eenEmSyFlD9dWzpKDy4AKVOXMLe2b2avRNW3w70hsYtgK6?=
 =?us-ascii?Q?UviddUMlH3WX+cy9FAmXIOCBhplaUlRNiNEQhnNgLaSZfDMarCL3uFg3BYI5?=
 =?us-ascii?Q?9W9FfppNDGAncJw1qoxMZCKtTN+2ezSINaF2j6df/KM98KLzzkxcZQyD85sI?=
 =?us-ascii?Q?fvgC3pJcMvbfAHIagdsTNWjPtoB87ZcjuXsfo7rJ9Q11OMYzS+EaKJlZZsGo?=
 =?us-ascii?Q?UYsYxa1nCshW2bAy67dwoW9PssfaTsxKwvyoSpYbFNcmvc97NRFnbGYJsPOc?=
 =?us-ascii?Q?vj6UAz2s0beNroZz/DYPC7cRQjhGsPQY8Gf3tHP8G6+Wo1vmi9tycWV679Ss?=
 =?us-ascii?Q?hyI0gTHkqSPco3guOShf/TnX74VO/b2y2U7IPdSyWV6R7Lxt7ZvsFWHiygUf?=
 =?us-ascii?Q?4gqTQsINoj70eM2PTFJKUPTCtZDQzbdKK4Mj6KvNR5H4LBCDsCEtOwi+vJeg?=
 =?us-ascii?Q?lRKHNQjYD3fZPGAKtcuVxQZRdANCd7IdqWHngFKNx8dw2elfTOOOQmX3ZpRl?=
 =?us-ascii?Q?TL9hQZNr70jYMOPflyV3EYyaMLLIPyoz7SXIIHAM+GLxhGKWl/F0hbj0poty?=
 =?us-ascii?Q?Xtt2Qs2kNc7LkdN1hBkQT1rFYSceoyIEhUbxvuiMUpt3nRCzcr0PIxcDMDbC?=
 =?us-ascii?Q?sLmo2j638amtf/yu0oCj+o8rI9COG5LDel92wg4K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e10bd63e-e95a-4a2f-eb96-08dca0b83da4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:13:55.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LavMUMUip6j+OJuiIg9MBZH/9DH41AGOhD8m+xdkZmd0zY69SBKy9Fw1VA27BOF0PJFTX7LYRn1XRr2EkF7qKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8864

This series adds a new "select" method that can be called by
the user on the broadcast sink side, to select the stream for
which synchronization is desired. This is achieved by changing
the states flow so that transport are not set to pending automatically
anymore. Instead, the transport must first be selected by the user,
which will update it's state from idle to pending. Any pending
transport will be acquired by PipeWire.

Furthermore, this method will be used for setting the broadcast code
of a stream on the sink side. If the encryption flag is set, the
transport.select call in bluetoothctl will prompt the user to enter
the code

Vlad Pruteanu (3):
  transport: Add "select" method
  client/player: Expose transport "select" method to the user
  transport: Broadcast sink: wait for user to select transport

 client/player.c            | 52 ++++++++++++++++++++++++++++++++++++++
 profiles/audio/transport.c | 29 ++++++++++++++++++---
 2 files changed, 77 insertions(+), 4 deletions(-)

-- 
2.40.1

