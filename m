Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885577A11
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801324; cv=fail; b=k6iT28ltuM7XcpTjU8mzHcukK/Ff5mvNYYX57h0V70+zZybrgGJDzxLyhv69CkEe4jCeX4ApMklQjVBrH1sy4cfbAVNSpsViu5rRdK4loOk886w8MiH471W8pXdCRqYQnFGQEY0QkTgwbtach75aJSRWjUvAYVkrdmUD++BsBLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801324; c=relaxed/simple;
	bh=9SroyR2ZUj4AG0uG/ZgVm3k6mGobC9DJqt8wkv8Mpms=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AtEUu3BpjC92VXhvyWZ9PRoXLlt/gIxSB+6VBRLcGc2qgwmTBUAgbrXn35e5L5ThdX23R9HeRY0fdLpcdX+uQPvr3xuU3R4w/zxp7zSFEwiZ8Ivj62DV0Mi6DJNNgJj5/22Vm+Hm6wDBwARhnbFLACYgB5Y7PKp4Bnr21HzPtKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UhDSQrrO; arc=fail smtp.client-ip=40.107.13.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UhDSQrrO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OensAinxixkcBpN+dK+Jw49GSlkc9lTjONvbeWv0lt6WREuTxBAH/W+W4DZxtYk8B+gD3Bs1YX10DAz3vQlcfptqqiqT8CIyW8ImDXnqv/m9bIw/ZwiKNEW4Zv8Im2tDamcBSMjjjEClqBULtLnAeP7ERGX0H3HPicDYKD1LYuHpNTGVMRDpuB8bp+V2b6Lf3qAu6ofI3TCkPLQWWsboxkkKIhd4NGGOA0TukNmsg9vQQWMK3JQqILb4V4Pe/3tgLgASomEs/pzska5WgnBEmj6usIzkmg7T/r16hvBt2UjtEXk4dMuSp9xv7emYGxqW41VTIlS6eavcD61S3OEaFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rQPAug01XUIZ5emdgS0p8/HMdpZgECfunVYHGuZeOE=;
 b=WLK+yhhsuX6Gqgh+ZGSazmEg6Miu7UuJRvuytPkZ1MPBlot1jMZvytr31ieOwL9K50gnD3mJGSy2pzGcgXpxpv/bkacd+r2hTXzxU2F3DMNQIeRp+0C676gk4skrypNVX+DOwZF8dBPZSNLTsbxqhFjWCYZd1P+yS7yutCbuVa2vAyilpt9cGxHcMEfFuCTWF/gQ31ECQ3ICDehe5EE8CUyV9Q9p2sLEmx78Ws0a+8G2IcDXyy5jzOVPEXSIFjbpAqTpHTS8G7irzexNMobOF1XGACp15bwH8t361I0k/B1Lfou/Fsr/iaE/3LckH6sr9ffIL/U8IrfozrkduoJjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rQPAug01XUIZ5emdgS0p8/HMdpZgECfunVYHGuZeOE=;
 b=UhDSQrrOmBOueFwm/fAGmH+dilTXlLQPFF6p62/7HcmL2A8Pehz31avsjylpbPVfzzVIm41gvonS2/1O339in5OzSqx+anGaYcOhPC010XZGDqb4yZd0JDtLQvOxIZd/fcgO6Y06IIwq785SuLlfAcKDkK+290eVeDp8xsCCGsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU2PR04MB8997.eurprd04.prod.outlook.com (2603:10a6:10:2e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 15:28:38 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 15:28:38 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/7] Add support for multiple BISes on the bcast source
Date: Thu,  1 Feb 2024 17:28:28 +0200
Message-Id: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0114.eurprd04.prod.outlook.com
 (2603:10a6:208:55::19) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU2PR04MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: fb41387c-3df4-4992-b74d-08dc233a765e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t68tEcJEOoC3h6Tyz4/xozvJW/b2FzLdJ9NoVrIK6HjtJpta3kLSdwu/zpLFQkGEwtd6qBqskKfwdE1n2Sw6/xyOsd0DeMGJjsUCuoYGSnwyb7BS9d30FomBx7uWrzSJ0k9eHEQglnLoGlF2dInG+p7mtxIeWo4EZy1l4gpJSQjhnSzo0Stdhem73ossyxjLx4Gs/FK6oU0r/pc8B5twO8di+ah48TEJnLEwwrlqAAnq8kG1T53PsSHXYNs2LAWXuK1M5UxIyDEHimph5eH+gU75w84EzrCj435STcj61nF01Y8UhLxCK/cXKwdEgwWeh7VKupe0g4LmgO11LaFK3njVLKFtu6ZQCYSx1l9Yz89PTNiQ56jdy6zLormvYnk1G8GLDNTSeceJqF11A8X7uz/JgPh8kIRItAMkTWj4I/LBIG/MgNSMHt2057vdYH7AkO+gmJcAWqlvfhqgreGqBdL3pUg+rB2roX3IRrPmbpE9gyQb+AtRJnJdDW3RZpCtiNgKhdLWBG6LD9kJKt0lxNNeWHlMF2sVbOglpcuaDYcojBEHwqhNL7FQKn4dSMiM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(6512007)(1076003)(38100700002)(26005)(2616005)(8936002)(4326008)(8676002)(55236004)(478600001)(6486002)(6506007)(2906002)(6666004)(5660300002)(66946007)(6916009)(66556008)(316002)(66476007)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WK8KQEPuFdaTv37c2gCdjyRlST/9UBfunmewsuiAdPcS2DclMNY2FU0MF746?=
 =?us-ascii?Q?/TRlmJYAovokTay8gXRhYA0o7mceB+YErihMswjdV2dlMSpc7ycGDu8TaaiD?=
 =?us-ascii?Q?YOU0DHG6GJgtSnQXHAoNwzDC8iH4HFmpVhz75Kp2zsSUz+iRgYV+wABKyl/N?=
 =?us-ascii?Q?mSldnW+GXazAvLuox9vW2FtN+Jp9zVuJnSZUhnTdMsqpgEDU/9Bxo0nPSon7?=
 =?us-ascii?Q?7XdAa3cM3tGyoKrFFx/EkiKN+NbH0s0sa+ExHaSb6fuy84SxaeylPQpXttsF?=
 =?us-ascii?Q?WHFv3UkB0iGggbSW22bURHSDODOhfc3k3VoC/Pg1cg9Qf9YgqsSNcpLLlNLJ?=
 =?us-ascii?Q?lyID4q+kmtOUVR5tjNrGCI6iBlwl5uCXXbSkROMr09HyIigK3Cblzcsk4RUQ?=
 =?us-ascii?Q?O6/3cf1cxQA802Szz3BPXMG4775+URKbb26D3/xlIbFBHK0vSQFq+MsqJlB1?=
 =?us-ascii?Q?W9jvvunyyp1u7JXq4LPrEIX6cnRniGa+byZwyJTPeaOXmJCBqEIUsNBs4/L6?=
 =?us-ascii?Q?Fksnk8bEfhboZ0GZ/B2g2oNYcmlVxDPNAh/me045IEDXXf/K6Qbqmf/MObHg?=
 =?us-ascii?Q?Htw4GtbA7Kx4uk6TzV1qShKTbKTm7wyAboYuVoFcc3o7gfu6hkdvBFrF/UTH?=
 =?us-ascii?Q?N5+Q4fotAXHiXyFhKfZaylmlbE4HsuP7b7KtyxTlt2ZD1TanIsvcTA3dhvQk?=
 =?us-ascii?Q?sJM/W0B9rbE7NU9SBR3ctoo5Et3IgQcJ9+yEhJsI8qRQpfIk1ML4e66vWI5c?=
 =?us-ascii?Q?SkfERELRZ55OU00o+Q5nQ9UeOcLfMh+UD8l6XLG6ft2GmnO+wOB0vOlCTID5?=
 =?us-ascii?Q?0lgEXiJpXh8bFmdTutAxK8uzXONyKAaGnjy0toJUoqPnoFNCTGX2bCBRMLDK?=
 =?us-ascii?Q?kc3QHLKlCi+VjiJAAVFslps0vQ7B13Vf4VZPXTbwnWWC5oHftn0EflzEQLdb?=
 =?us-ascii?Q?F2O04wBnnTkNORVZrBix4Ai2OAsv7DoEwvEjPahkDyUidS/+yMPHBErGEcZ5?=
 =?us-ascii?Q?a83KLWUN/S6FEots3NLvmF4NNI0IwuSfPcHQmDXnYl6PH9yveuQlXQojcnjj?=
 =?us-ascii?Q?NwzoZEF6MIgT1uCvbswAcUAvT+ToupMQb3TMKrTIsRK4sIhyq+hTAyPPxf1y?=
 =?us-ascii?Q?srvS5up+eTH3XSoFyHN1W47zpA+H2yfE3HMozY1gZR9If0W0uo4nmHqpDK8I?=
 =?us-ascii?Q?6Lvxq6T807qd1HzMVVEvYNwBFX398JvdMxzbhwRc7fODgfJ7Aiz2Qv1FSKoR?=
 =?us-ascii?Q?iM4RLgZmEATLaXgOeXS/R0PTBnZiHbsFOq9P8LDSsG62XH4ieN2jhWxTspXE?=
 =?us-ascii?Q?xXu+qJApYigtGopD982ah0+5hSxc0DBXTwK2yt1wgXGBio0uPrJJBglViY+c?=
 =?us-ascii?Q?jvPPqR3JdWb14GYfvR35MUpnoOBMAcz2vNPr0pM5Ai+0dhiQhwL/kWxup9ne?=
 =?us-ascii?Q?zfO9zVsuOu3OUOtjt6xVw5craAKGQWemHe80ZocDC+BJ7gZxll5usRW2mp/t?=
 =?us-ascii?Q?EK2gGEWmvyTu8x4CEXxArhLIEhl+V5faykqeCGrn7y7SRW4v0EaEqAPt0WHX?=
 =?us-ascii?Q?gur4YLTfON6JpWHIr4fkSyC85xu3ETF1s32MdpVgg+MK5pA3g1i75fGQoZO+?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb41387c-3df4-4992-b74d-08dc233a765e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:28:38.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FxqqubYrVHcz/wKc7n1UyXL6zhC54MokLXSIgciFFgV5b7jSohcHE2v+NJ2bNFFV5sZg8qSPV87Z5+aRt6iWJgj2a6nT131zq/Ch294OSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8997

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
  bap: Create a new endpoint to be available for the next BIS
    configuration
  bap: Split bap_state and bap_connecting in two functions
  shared/bap: Check the state of all the streams with the same BIG ID
  bap: Set the generated BASE on all setups from the same BIG
  shared/bap: Generate single BIS BASE for a configuration with BIG ID
    0xFF

 profiles/audio/bap.c | 239 ++++++++++++++++++++++++++++++++-----------
 src/shared/bap.c     |  67 ++++++++++--
 src/shared/bap.h     |   2 +
 3 files changed, 238 insertions(+), 70 deletions(-)


base-commit: a692cc44dc8735b9303f8893f784306b4d2654fe
-- 
2.39.2

