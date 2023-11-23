Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1iojLji"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F81AE
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 13:59:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOCgVzjxF2Z8Rm4y5DB/MRsPlSkFN8acB89DiyxhoZFu8eMc2YGghMhIBKcox836ItwG4y9h9//Psi1rNJBx0Mp010Zuu72bBuxQhSv0OJP0M8C0N6EUPQZ5UMnZK75hN35dqprUs7RU+1st0S0Ic7/YJVlne+kTNLXeggf8tHuM1B585YoP6g7///1GrmqaoLTqTfBQGIlyvX5G83QVJxcVJHaPPkxneVFvtukjBZEsZ4OqzWwG9IXB7ASXpVWmSxFi16+8+buVYYANioEC8xZ29B/RTAQTRW/+xaJZ+kGv7nPDR1d535z34+b7PRHSMk4wMK6jFaZlkKnkxWlyQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIYB5H/KqpMxox/Bf+FlaP1MRqcxoJ70HrgxhHNeKIQ=;
 b=UbczWU8qTTQZobXAx3nULOZu3fUaBlLvdWjfonTLsPJTuEyPfpC1p0M+MPkFuHxwg6MvRwjaRNJjSnvnWmjXhoOiZg+0hozU0sFt776miH44y+p7tU78+AD58dah2cBAIappzPJKWej9y+v/YnZCVNj440Q8QkCz+zODZS1xD/wIx8Ru5xc30rONozwpoSN75LsU/lSDJSyA1M0VawzebQZGLFL5/CLxi1QndTqEJ+4qIXH+AbDiUACguah43XuMtX3t580THl1iovvQJikB4tmDL1yXLiqCoAeMXmjEIGDYb4SkzmknRYaFohPPsFmC8vDpds6iUmqgeXWnQ/BO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIYB5H/KqpMxox/Bf+FlaP1MRqcxoJ70HrgxhHNeKIQ=;
 b=B1iojLjikq9HWqKKH5QHEYex2iPI8yFNFk7d60Pw+42miXgrFq8qQ+pSBdJqumJZdUs+ccj4rcZuFajtwXJVBMTwRBoPlvYtkvvpKUA3ekdE65zDcYCvCyCFBHQG6kKsl5UYAFBMkV0gPzfkKN1o6gmgyW+PxAvchgZFBYgD2Mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.14; Thu, 23 Nov
 2023 21:59:39 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 21:59:39 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v6 0/5] Add support for bcast multiple BISes
Date: Thu, 23 Nov 2023 23:59:30 +0200
Message-Id: <20231123215935.73501-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8c::14) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2ec69f-24fa-4e75-ff56-08dbec6f7d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EhvKYZpt4OwVJU2nB1FWdixT8ElUrTDzpBz1QhiUCtnqGofhy3Z7fnmWsBWSjT1SSVKTUPefAIYYGEf0wxqDx5D2IoUcEXcE4JRru132wN0N9apeOrJkqmtD3NFSq5guztVNZpEJn2uujfLIJpFL31IU1gukpmbD/D8Zyz4fcXsCaoQEDyNKofqglUMwAcdlbl7TOexjE3sf1IWmBnOd8Q41ZwNaDKT37aBxVpJ7SU+Nd0ZIwDjMuByzr+YCukQC35b3K9h2Mh31vKaiFV5v8VmkBFiqSMMBVCOhy605a6J0uk4xWW7U89KLj2znjwDUUcSBxPnZlrmpYc0XVvVQkvfLIkcfy1B7g/WJKVluUKY+8YU1DiErlixwfTDWbtrkIVucrkqGxX6sX6soJKYBzzSs3s1654a+YMr8hUBX3Oj65MPC/FwLvPCq4/jEzHH+Xw8XKWOvoSsXPhlBSzVLbGStPOiqgp6oWR7ieZrZ3qBVhkq+nLdoaYt2FuuD4SPWhL1+XLZ7tYmSLtrdf640EXE8RkTf/PCnuaKIg2r1NqeTkOspUjAv0+Z7oXCwk1Q9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(316002)(66476007)(6916009)(66556008)(6512007)(1076003)(26005)(66946007)(8676002)(8936002)(83380400001)(478600001)(6486002)(6666004)(4326008)(6506007)(5660300002)(2906002)(38100700002)(41300700001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wdAxVBF2950Xq+pwZcoqWE/3sezHMo6u6vrdYLuuzh0owDJOvxuy7WGbFDx6?=
 =?us-ascii?Q?S3ZVqX7ORiCG2gMUfxBJ8pas9+VXVitRE9mhrVki4aA0kKarjKWuzobZTaBO?=
 =?us-ascii?Q?/DVWxvnmsAygQAMY2YHL5/QZhkuPV6ozY3PM2IF4nk1llGx7Ba7C2MScf/FU?=
 =?us-ascii?Q?QFqk89LXCLAuZVg3GVXxvhClihCVaO7+lRR5tk1R61l+ABevT7Jeq11tEvEo?=
 =?us-ascii?Q?ZVJEPnYUw3Ocm9J1TCkcgvdUQT6EvbhtV8sYbXde+9GFdJ6gO57NQ2AcpG/y?=
 =?us-ascii?Q?G1ukwPF9moc6JGsOtywAS+R9iRdEHxrMT/1XVcEQTdxL0IU4j38egfpWqoSj?=
 =?us-ascii?Q?VggUNtI/+YeDiFK5WyN45EeTGZFFPqwWi4iO0MP1EvuBTfBcb5Ayz3KwLB8B?=
 =?us-ascii?Q?GUoDmR4lDrVJpGrp2Za/nbxMcm4K3NgVQUFzedZbi7eQPM48IibsYC0k3ORJ?=
 =?us-ascii?Q?OnBMEyX6KBwQXC6gb2UGyBIA+ZA0hHcVr1NNDvWuODmyUG4HvGPc2HvyA+Ot?=
 =?us-ascii?Q?hWJMT7dmiFd4R+PyqNEEpNzPhslRolN8CLaNqaCUBAym/AzVb7QyWEP2w9qg?=
 =?us-ascii?Q?QGGJFf8r/todSWVyoYK5sEH0dFzZYOZMPW4SFhpJjUGKlt2FKW1we+6pZ0Z5?=
 =?us-ascii?Q?SYNcsyImit6wm1oG2JonzzWrJBgHGjkHbKKJUjVH/xMKujOgjh63pGxc92EJ?=
 =?us-ascii?Q?4Q604whAZHgAz92I5q0UEHmcMhJQjcAuqMIFCyxc13F0rOWKEMJN2izC53iq?=
 =?us-ascii?Q?gLgXSYl8XjgZruClrVLniq8tFcVEKwMVC/Z9g7sDbeB3ZHHEJhzLGfIe2N2h?=
 =?us-ascii?Q?1XMJSReZ97r2zJjvWhRu9C7txwMFVJsxl7gAEeAOPJAlB5hXBJPqANtgdtrl?=
 =?us-ascii?Q?fPKWkDNuCNyPw76EBDnXuOnuZoAxgF1Sk8kDJIjVFkemhd4RDCw9Ctg9UFGi?=
 =?us-ascii?Q?2xeZ6TkSBHR8jInu63/T/EVOhK/hzbUDOhCzabZQbbP0SWlcNqSXPWEXL8Tk?=
 =?us-ascii?Q?zInMg7izpRMI9MbEE5GC328yLyiIjF3L8UGsOfH5bP0XZMWBoVKIJSfwfMzk?=
 =?us-ascii?Q?epwwpAhvCUIm3xXaxCOvIl//Ka3jQEKlTe0KJTMK5QaNW8YSy/5UWZwpfFJ9?=
 =?us-ascii?Q?3RK4a/cea1N8WvL0T3llVQdQPd4i+zk5QRNSrvlu74wydcBRKA6z0IP0rk8U?=
 =?us-ascii?Q?ZWGEzTre0vXkQodfkVllCeGEs0M1SkcTEqhIjMtNQ7TnlNi7jIG8qUimuNv9?=
 =?us-ascii?Q?dvPn5j2obOfCX6E6hiD7keHhlwlCI1sUlLpdorN0i6LsNhgHJoVfHTrZL6U6?=
 =?us-ascii?Q?6IItbPCwy/9uXey9AgGmfT4pNxnf2cVbe2cNq8FUapq/v/1RGYXU5iA6njn0?=
 =?us-ascii?Q?OYZ76ILiK7xH66uY3z6l6cPPFcF1i9YM+Uxb3goBD9UQXonxWPNdXcMe2CKF?=
 =?us-ascii?Q?LB/0oJgz7SZQ046QLwoMG8BQGerfwNvPjV3QdzI77EeNex+Ypp3hxWIWbsab?=
 =?us-ascii?Q?LWFmcXCj8JqfRy8dKJEOBljhP7rWRaVxRN22RF7dA2sCTA+3DPYyhLwi4ISm?=
 =?us-ascii?Q?fN2jUBiw+Wll6OqHUwgQ2pYa3hAR9A2u2R9IvN5d9GoC8Op+nuii7lXq7Ob9?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2ec69f-24fa-4e75-ff56-08dbec6f7d33
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 21:59:39.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S18IkAV/a6lhWgL6wIJZpgrBfZN5d9F8azOiibzdaWEYRgwI7mSX96jhJdBUwa3Z0LUdcMllQnwTVHHu/Ma5gtdswucVumZT95qcdPaafo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335

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
 profiles/audio/bap.c       | 617 +++++++++++++++++++++++++++----------
 profiles/audio/transport.c |  36 ++-
 src/shared/bap.c           | 290 ++++++++++++-----
 src/shared/bap.h           |  38 ++-
 unit/test-bap.c            |  12 +-
 6 files changed, 776 insertions(+), 263 deletions(-)


base-commit: 8b035b70f379e45a32c94579ec8d00e48070c21e
-- 
2.39.2

