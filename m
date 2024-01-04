Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12931286AD
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUKKBhkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDTtWQYt+15l0abfXNveYScS0sWCSl2rRThUuQ/LWqBI/Sgedh/OJ9ngUeYqpgn441iz+jt8CcDDT+UDEU7MMcsEjxiINS1lShCD0Cr9yGj9x77OAe2EE/rqaT4Ure9VUCR4yoIGLyZ4vXtkRjWDCVkM6U/CGqi925OBGJStNeYEJ4TLC2y5ZuzKhaeMhdwKtKAWy1T0BEWpzI2Hl7tpOeOh2lEdoEWsSXHIgdB0Umc1ZskZ0ar9FAvMsPKQkDwQ02faUUiZO2pNgTaZIsPa8GRR4gl7LEqPjwj7iGrY55LILdxfd2tHfc19LoEYGXThVtRRzo9ev1OgnYaKRCdsGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AncXoW5zQKod0Dw6MckeBZ1HOYNV3PrflCwKJIPPCk=;
 b=ihCN8IJREBzczTMdNYcV02SJqx7lDs7c/ms7YIULpXGI7ih9k4HrcVHazk39oUmm2oH1PjGvhoxFXYehu7UnRFeX9hTgPv2ue/hsCcB4cJ65Cx/9Kn1hgvXtQPrNwENW2/Mrs8DJhd7/ABxOXqSGPFaeaOKdzPZqa4Vh5CXuYPF2tKqbB50yE48bapRZPbvP7Vo+/GwcVWeqnkRTSp5t4ty4nPCxkiQe5fWi30ZKYJCZWkS+9VkrfZn/CVdWNuZmjUtYpNwZrFzvi5h+ruiuGT8eGm5rZE67vXx/nVTEJ/M8SOPBxGXRYgKQ29nGed4VH/TOjOugyE+GYtWqAxMcSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AncXoW5zQKod0Dw6MckeBZ1HOYNV3PrflCwKJIPPCk=;
 b=MUKKBhkkIMsq2P2Xjuu/SqCxBNm70+vu4/66udq9xU41lJ+LoXFG1kFLyfyFn3Wdib+mReVEaCukzgMB85Gqv71if3lLqK63qEhEtLG/aLPFUPLdMTu0IbOXEUAVE30LhQkBUjjt8Otpy3SNUPBNbeWmdFxLkJFCarTKTumgMjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM0PR04MB7073.eurprd04.prod.outlook.com (2603:10a6:208:1a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 17:16:59 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%6]) with mapi id 15.20.7135.023; Thu, 4 Jan 2024
 17:16:59 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH 0/2] Add support for multiple BISes
Date: Thu,  4 Jan 2024 19:16:50 +0200
Message-Id: <20240104171652.189629-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0065.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::8) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM0PR04MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 9862b99f-6ecc-4d8c-d3e1-08dc0d48f5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zYFKwOy/Daw7TG8+LDDSMYpKg63wo6hG+Ye759+v061pFYRVS3948F0U08cYBEH9Dlj5Xu3SALx/UjxKtwKaek8OXeisVX2LPnUd0fD7dyQApiKsYvcvsr+7xrxEayLrqgjdHDaAWJE3rJmDCIwm20rDXHEIefkz6ZGdCL7CoAaVu0NHTFozVAYBWzdKr1Wv6jh9te9EQ2apvWXd4jzZVylhGttqze3GFo7sjWrg1DvMDXjZ6zLW12RZ5w1KKSwQ0K0YULk4mgsSTLHoEQel8PS9nGIxQpNeSd29HMdH1uJK6cjTdn/IvvdpZSPxN4s/nqQlOF0J8L2N7I0D3OYhLFJ91W420D/cUS+hag70otwViWN1j0+knZB9Jte+khHiOoY3It97oiK1bPvxVbYB0taIfoAShMPinIAUKekcPZqHBQSRJZntGaBIDsnoY7l5ibe52w5q7nOpHuWOUfDgekS8yG3Bvwlox07/58snf+b/m9HoSNDPczYTUN4zFr1TaFZsNBI/DOFc1LAS5u3dF/Eszg/4MEwUN2XYcLfJ1cPfduqwqTnHkwhqsRxFZUb2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66476007)(6512007)(478600001)(6666004)(6916009)(66946007)(66556008)(316002)(6486002)(6506007)(2616005)(26005)(1076003)(83380400001)(41300700001)(5660300002)(2906002)(4326008)(8676002)(8936002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NVBRF49igIpyxR8uV7OdSBLLXW8H6hSSdIJxRrmy3i4L3NDlJx9CZbbT/ck/?=
 =?us-ascii?Q?PPkhYiGYlHriWVZwEAyK+OEZb7SNU3qNtnB/Oq+W6pewfEt8bxXcetsc8UGj?=
 =?us-ascii?Q?7EC83rpnHWPo0MV64KSGM9raV8DUVU3upmbPlZabO4IQ8OFx1LDu5tBadThc?=
 =?us-ascii?Q?sUKQkEwpuIj9203A2NYOs8J5MDlFSZn9eN4MkgdwWvfmthirX0lYz26qPzSa?=
 =?us-ascii?Q?VKuxgk6tjID7Zd50uXaRPO/M7AGA+VDpxaqXvQOO8AfWRxPfMPcx1sQwt/eD?=
 =?us-ascii?Q?kACcFJ2oY1wrOsm50lSZohxO42NSltPctzkfdJ5yAIp/mRzjoTOGjmpWdHgt?=
 =?us-ascii?Q?8b4usQZWQwLJTqvRXdRiWVjbQhogO7C3CeBlTw8XLu8IaBOrugG15YdF1fVN?=
 =?us-ascii?Q?AYrSGGaV8ATBygQskoKl04WtMZOEZVI9RZhEITlR58/xkh1iESICDGeKs19N?=
 =?us-ascii?Q?fr2VVL5l6Ns/juol4AEDtjS53breI1Occyl5B76mdSXR+xSqiPKIJFt+mOgs?=
 =?us-ascii?Q?/3yoRRF65owUk8pfWrlxlnMLuXFvolPlw9BosC8OJ1PFpXiW51beevX/va9V?=
 =?us-ascii?Q?BU0wphyLjekBmfRKd3RzJ0V/j3jqgljvjofoCNpoDavgKjRhr4Izkow3C16w?=
 =?us-ascii?Q?LN/w4UJy7y5TB2R0xsvIf+eQjYVhZlut5bBh00g7Gwrv68BiFIu1Jm0ToHBA?=
 =?us-ascii?Q?Q5mGGbrs7lcmoo2VjNH/WHcJI3W85thEWJTj9L+Fyz53NTahyg6GwZSNSVQF?=
 =?us-ascii?Q?YdDFdBqwjbukW3tnGOPRxA4Rhnbq7Lg8uqEgOjkfBfa4TXBLIfRRgYeHEkJq?=
 =?us-ascii?Q?x7gjrGbSU0gT+FsSoMsFVnqah1OLjU/n5AET4e2dB9tILh0vQXYoY4cuyglx?=
 =?us-ascii?Q?LhLn7yU8W9OfVOlEGHezRbEcSdwohNU7JZoDYABlbUsI1nwfytusyQYRaTiH?=
 =?us-ascii?Q?/v3jlNoyal5B1x0ZGpwgx9s9xCubkcraFndj1PlSEM7kaKm0pgdB8JUvutaX?=
 =?us-ascii?Q?hwUFG+AOfNQvkO8tlQ624UyFAadZRCSWxonxvZeeZ5xOCAsKapIdM1tS91vW?=
 =?us-ascii?Q?63QALqHqZI6+NSOJ8BiZlgRrZmBh1mdud+rWXiWUZ4rl+yBpuqO1PeNOnIT6?=
 =?us-ascii?Q?uzUS48H60ox4zoy7tRygqisi72D7u+E7DwtlNRjxfz/Eo28jpaAedG3Uwy31?=
 =?us-ascii?Q?enGUlQjIlwGy7MlyyVjt6nl82WtxiWYY1JGrzdN2kZC7J25OnYaqximmQes4?=
 =?us-ascii?Q?wndUfIjCZVuEY/uxPK9mLcFuFWFefgHWmsb1NSfKe80Z2487SKmpaoMhHlaj?=
 =?us-ascii?Q?yvX9icuACVasQm8pUHtPlAeATtsQqHe7zinRbqiCwY/I9yozMFG5rO33T/iH?=
 =?us-ascii?Q?Okqu88JMiwx9nd9ZX/XRQ/v/7xAYO7KARW0/XpLz1Ql7uLDHiNzqYrZrjq1r?=
 =?us-ascii?Q?X6hpy3EzXUlIKRUNbMXkxaTdbNm0GLWSu10JOwOteuU9tPjp7uYt9etyswy5?=
 =?us-ascii?Q?JdrpNs/lpT3VmdYSjxRqDRuQqATH0i9D7OB8oreb1AftvY7uMF6QwxuqZKel?=
 =?us-ascii?Q?Aab5iQRV2eZTwgDAwU+E+ylnHZvivT7f5fJ0dcpfPpJliUWlxuQ6Prmlj+Yt?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9862b99f-6ecc-4d8c-d3e1-08dc0d48f5d2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:16:59.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kAgUCc+T2IetdF3pJgcVGzuHnhue9VLtenE+E6QloTIwU2HClX16KJlyq2IO++cSsvXbMPj0Zp6FymrrsS5ai/4uHjp9BX4TAylVUCMGAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7073

This patch adds support for broadcasting multiple BIes and broadcast
source BASE generation in Bluez.
To start a broadcast source:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
configure multiple BISes with endpoint.config command on each
newly created endpoint
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 24_2_1
endpoint.config /org/bluez/hci0/pac_bcast1 /local/endpoint/ep0 16_2_1
each endpoint.config command will create a new transport for that BIS

Use transport.acquired command on each created transport to start the source
transport.acquire /org/bluez/hci0/pac_bcast0/fd0 
transport.acquire /org/bluez/hci0/pac_bcast1/fd1

Use transport.send command to send data on each BIS

To sink to a source on a broadcast sink:
endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
Use the scan command to scan for broadcast sources
When a broadcast source is found will automatically read
the BASE of the source.
For each BIS that meats the sink requirements will create an endpoint
Endpoint /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast0 
Endpoint /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast1

To sink with one BIS use the
 endpoint.config /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast0 /local/endpoint/ep0 48_4_1

Silviu Florian Barbulescu (2):
  client/player.c: Remove hardcoded base and QoS for broadcast and use
    presets instead Remove BIG, BIS, and context from the register
    endpoint command for Broadcast Add Location and Metadata support for
    endpoint config for broadcast source
  bap.c: Add support for multiple BISes Update broadcast to support the
    new setup structure. Change broadcast code from iovec struct to byte
    array Add adapter property for broadcast endpoint Mak broadcast sink
    to select broadcast source BISes based on pac broadcast sink
    properties

 client/player.c            |  301 ++++++---
 profiles/audio/bap.c       | 1273 ++++++++++++++++++++++++++++++------
 profiles/audio/transport.c |   35 +-
 src/shared/bap.c           |  441 ++++++++++++-
 src/shared/bap.h           |   36 +-
 5 files changed, 1751 insertions(+), 335 deletions(-)


base-commit: 60d60166e4bfae8555fb671e5a99952586cc6b56
-- 
2.39.2

