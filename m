Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fQG0L9yJ"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E22F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Nov 2023 04:08:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BX5Zyzidm6x91hX0F7VaQ+TXkTX3A6PHP+7l3xUS7v1binrlVRzoGVMqDQKUZZLrP/6YpHlgWJgMFZ/5Pg8NxKqGU2vcmzKkLsLWO2Y9Tv/r3hJwLySmIipDqB9r4H3evIOMLVY2TDPdbczlYmA2dAr0wW9zlrKpfpCtctQAMqB219o+3WnVg2rGTIBunXDcQJ6q/gXbuvbnY8kLPQPp9jz5af/mehMgZ8vWIh9upUqMLZzRxFkpf0bsqR7CkgXIpuSp5i7iWwA/qD90A7A2hFgNM8LfX04AgS6pvYe5cp9uawwN6FoyEPts3e5QTAdKtLt/b+zKUwUp7PfL/yVSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXVeFzU10vgdYxjij9HnL1RA5lk5CYTOlzQ6NZtc7/8=;
 b=gJeZRc1qmrTu7/3IdNJegzOFOw7Se7rO9hQRMrQXF0kd1zvt5Q+xKwAvAlbu/V6NhRrk/rcDGa4cULuXBNRbhU7279gKZA2cRDYWOw9evVruYrLYq/b/Ocvt/dWSaq8eBl22ne3oWSGzBA7ZcSCHKiHcVMDufIRQGVqwC76kWgrdRCKKtOGIcGgAN6HzNQn0O+ZEVVx/hWCiU54SKYUmeEawwXBB+4rIiI5bU/ZvNW+zNtTgMckkJGknq72tXPh4TfnFgxCYUg4qHW+qhx++nKhMxnqtHN79cDSkaUkTdvIhzOD4s71mjt66m3PYtd2AY2GHM+D+10hTqVkug0OR1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXVeFzU10vgdYxjij9HnL1RA5lk5CYTOlzQ6NZtc7/8=;
 b=fQG0L9yJHEFtZBu+vDGJFNUVmo4BLDWB87VTq0rKLP+LbIqPHinOZT+QQtz7ihqwARrStVvvmkv+KxgvMsY6AI2HQLzBdqIaol7wE7O6TMHltJyCtGNYA/4fU4GvqmCzf38ZCX3tahzJJR8IY8ZncWq/iK/S3TfuBDXVBMhzvys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 12:08:34 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7025.014; Mon, 20 Nov 2023
 12:08:34 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 0/5] Add support for bcast multiple BISes
Date: Mon, 20 Nov 2023 14:08:26 +0200
Message-Id: <20231120120831.5353-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0180.eurprd09.prod.outlook.com
 (2603:10a6:800:120::34) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: a5332526-a7ea-4a3b-0024-08dbe9c16b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kM0Sfk3vo4nTLdLhy/QENla3U0jHj9AJ8Qyz2r1dtG5UhOpUaJKXQNn+Ix160N3PQj9Z2pCpQUK6NRe5LRv73IA0EMOZANf91BVDSCuHwKleN89kFtx1EPmfWOJpcmOv0h4TIMr6KjGI+WPM2gAm+iGchJH3zyB4AQ1gc4IOH3uVXERt8j0Fwr1B8XN/7HIA4f3vpdVNvg5Hx+zeHqD35eHIzvDrvPbblxgfnm60EZPy1YnFEetc0Lhye63RvERbuQCmRbkEB+AnEsLnqnDr6eAeKzbD25HLILJh3+wNU22gfBtrm4hECzwpxR5ocJFoo/mlzFSSD0MwXUuZdkt1tnTh5yZ9EF6pDG8gCyGc07Wge8rOLo7EOqI3TmDaYId21juU5IBmLIoRG2twhWSrVnVVok2f8JsHzAS82BF1T7b8RL1BjHugPgnkFW+bVn4KP/PEkAV9KWfw6N5qNG6c5xSf8Uh9cXXqpQRdDjbh6HkqZ8JyzNDCRyAF6wC6OYBjuN8HEIcddfK87NnmmbrD3rjqZ1vaXb13T8VSY5upDDkNZ5AmM5R74ywoI3FeYons
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(66476007)(66556008)(66946007)(316002)(6916009)(38100700002)(6512007)(36756003)(6506007)(6666004)(86362001)(6486002)(478600001)(83380400001)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?egsBwrAYPVkLCNIqHeG/lwD+lHMku53Lxkh6xX1/1C957I/q0PXXFfoFQjLa?=
 =?us-ascii?Q?VQH8K+33l/ki1PEq28FnRIXi5GZQPwR2guFOhNQGMA7iswKdN5fQ1v09DhvO?=
 =?us-ascii?Q?c6zEusyTXecZ9EFaebdRdcfZKt4Cd+M0fOfjAsTH3RmkSFQ5419R2TNSdpz2?=
 =?us-ascii?Q?aDzdy4IFdCNdZlG9KZlqXCExOKgE29VAS4chM2YfsVcxs+0W1cgiT+xHtIlT?=
 =?us-ascii?Q?Ghi1Z9Hm5NyIlt5q4JBTPIC+YMaLlDrC4RjSfOy6a3BubHlVVfr/flcZl+0X?=
 =?us-ascii?Q?M/QnwcOI0Ws/ld+xu3kiRAu6C9b9pfW6Ww4Ooe3+Po8kdZxDZpDnA2KXDVxl?=
 =?us-ascii?Q?pNZTiwA8yee5VrkE+eyP/ld+m00ojOoCOMlm37LNYrrkLeqNyqIwjAmt0LAr?=
 =?us-ascii?Q?VJeC0O9aqUrbyR5vCWq4yXEEdl23duvsABD8lyJ8XVhoZLVbwRJbylGC/+qt?=
 =?us-ascii?Q?6R6jOQplbu/QhyShCZAOBKWqq0I4n7p7Xxvsfx6QC//n9fok/AECUy2mpRu5?=
 =?us-ascii?Q?rZ21mzgs7ISFf9MSSN5br1LamMXb0/tXfCxfZCWjId1M9Nwi0wKpPlAQE5ik?=
 =?us-ascii?Q?TlGU7GpABrMJuQ0JE951W6S2Alt/cISJuH6aKIK0tfHzBZyKSPEs6PZrjH5e?=
 =?us-ascii?Q?c5tKFAdS0oh03lBC710UZr1rZk9WJ+6BCTePgrNMPcir2X8tm1Z+zyQBuHqH?=
 =?us-ascii?Q?Vl/dk0JcpCYKrLFexizhjzJ09H50B8ML4b+ZJMZNM+MjeZkBK5C1wraGcjUU?=
 =?us-ascii?Q?7Se/MqgVpZT6RXeazF9pUv1g6uHTevpQZv4UlHb8kTAqFn0/t6Tz9bq3Z66o?=
 =?us-ascii?Q?xjpSifCdYz5aDTyqRZNKAwV6pIOdwZokANtGTLrFm9PJUNmNsPMigvXApAKO?=
 =?us-ascii?Q?qaeWhrnKtw5Y3G1Tiocz/xeXiGdgP1AWlQ97AzkqBVgd05pNdi2649ChyqtL?=
 =?us-ascii?Q?1rPOxJrE7UpDecZLWIsHZm16q7ezUX+J4y9rKt+wCkAqPgVcEqs+KdL8Lkci?=
 =?us-ascii?Q?l73sbq8JFykJoJQhGFVUIwr9YAqjBRMZ9Z9LFPNQjTzMsQXvNwnHuom1806k?=
 =?us-ascii?Q?jaHaWK6hFT0GRXD46SRkEnWM/h1ztxhstqYD6j4aYlqHGUpQ0l7egBB/Uso8?=
 =?us-ascii?Q?prtYhJwrV+K90I8EU7rhLp8l/9ymSJQcKtVXBMZw8hyDRI+/4B1KSiAM6Z1a?=
 =?us-ascii?Q?JhChiWmhkXBNLVQPheswe6ZYoEmRLYavtkUkntmSVzaVOyX6XV+NoT/aY1L/?=
 =?us-ascii?Q?s/yIe2DAeEu27o/k6Xk4QpE4mDXg8BLpwN3cqxG+aEJl39CLtR7D3vCs1W8I?=
 =?us-ascii?Q?ekmx+1Q7w3bdyRX40oKihOb4gZR3Bv1a1lQu5hGLfLjd4CMwn0pMmWouT3da?=
 =?us-ascii?Q?KSR9UUVr5FrwCyoAk1MOigxdPVaiGGTbi4EfsoV+yNntME/km6Jcl7UTbsn5?=
 =?us-ascii?Q?33x1DqAe+Qtcr8OxRje1qWhB5m/6rQlSg+DmqpltUGUSUyvN9RDHihBD7Ppy?=
 =?us-ascii?Q?t2ONBFRbZGYG5wOhcz1gpvDVHy2hQGzN8TvhUIp6SvaoTmUAJmoZuc3FkQv7?=
 =?us-ascii?Q?WS3HtuW8QWHDDwCFz0cn2UbQsLkHBwqC6adJ1h4nzee5mUn8rh4ACmaKmE/v?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5332526-a7ea-4a3b-0024-08dbe9c16b39
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:08:34.1999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxanKc9K1+GT0qktq9IMgbfL0/2paikMBYYOElWXIfGC6iT+E7eUKxq7MtitJnhFG6FFvKZcRXFSeVoYMZKvzLhJPxXAbJACf9bg9X7EuxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966

Add support for multiple BISes
Register the broadcast source endpoint
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
After registration a new remote endpoint is created
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 1
Based on the number of BISes seted in the base_lc3_16_2_1 more
remote endoints wil be created (If more then one bis is setted)
Use the endpoint.config command to set the BIS codec configuration by
specifying the BIS when prompted by the command
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (value): 0
[/local/endpoint/ep0] BIS (value): 2
Use the endpoint config command to configure all the BISes
After all BISes are configured, use the transports to send data

Claudia Draghicescu (2):
  shared/bap: Fix source+sink endpoint registration
  audio/bap: Fix source+sink endpoint registration

Silviu Florian Barbulescu (3):
  Add support for multiple BISes
  profiles/audio/transport.c: Add support for multiple BISes
  client/player.c: Add support for multiple BISes

 client/player.c            |  46 ++-
 profiles/audio/bap.c       | 595 ++++++++++++++++++++++++++-----------
 profiles/audio/transport.c |  36 ++-
 src/shared/bap.c           | 290 +++++++++++++-----
 src/shared/bap.h           |  38 ++-
 unit/test-bap.c            |  12 +-
 6 files changed, 754 insertions(+), 263 deletions(-)


base-commit: 8b035b70f379e45a32c94579ec8d00e48070c21e
-- 
2.39.2

