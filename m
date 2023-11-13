Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1070B219E4
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XAf9vZQx"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1B61706
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 07:39:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLrnkqmzOS4AAGpYkKPSPaT5xVvN6r+5+OZFag1awGtnHpb6CgkYwgVc9M9ZXTNx3bDzXz+5WWve5kk2YwMJKCs+57QoZMmdquP2ULsGG7vR2SBdpbUlQ1G32CvDcL6afw57vBaF7FomGZ6JDizXOxAa1x22gqJwe5UBcI7KzJtCu0ejg1GchDR4w9boEzFC9t5rhjI44/KnihwAkRal9LfENak5bZfI33Uhui4/EoY/AIGO0jUIPoW+t4YtvOtJ0AMI+t9b+CvxcyQMB7oa3NKZREy7qLMkbuzTY/GRa4AjTlIfrRi6PhbCP0WnM0j/Cgv3CD5Op0CHX3YtuYfJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oH8gkqGfOau8AwK80plgHqs+LcivT/pIzjJ9MHdkeyA=;
 b=h9wNi2x/eNh/GmUiG9aXqDhedjJUNwYLNDEtHDn6Drke9oksCb/cnl5O5RhXGnZmfOUm/8vsnvaq0pt5+4P7XMxdljUt1B8PlbliXYmeu8ufh6IMeIETBdycIMkP6ddWdvcdPsc1kGcS4s1FfGRpa/e2O6Dx6sMg/LkC/RkP0KYd9+NCv3gb2hL16I/ejaajRUk4T8YOw1SUKPlZDgi1HdQZQsn2ACX08XQdvwjUQdmOEIttZ5CEek/xgwRZLEm0JrA61fbtqmo/RYMhEiipQbab5bVwNOrZKbp8yPH0TYnjPGQiWb2cOX22/NCxs4VkWeuHK3a8eysYZTxlqgCWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oH8gkqGfOau8AwK80plgHqs+LcivT/pIzjJ9MHdkeyA=;
 b=XAf9vZQx01H+BKDo7KvwXQourITZzcY/n7fGcu84TPxgILxCEzigB26SKrbgTd4CZv6qeoFfSUCZaZyf3X20YfzF5d2qC+fRRwU8GNilc/8ycaTm1oZoSPECybx6wIkF+JzhtrydbOm5CfBW0g+srLDxUeftVFprTCjzK2Z/SXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8498.eurprd04.prod.outlook.com (2603:10a6:20b:341::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 15:39:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 15:39:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast AC 13 reconnect
Date: Mon, 13 Nov 2023 17:39:41 +0200
Message-Id: <20231113153942.3875-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0153.eurprd07.prod.outlook.com
 (2603:10a6:802:16::40) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: abf95290-1b7c-448b-f711-08dbe45ec38d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CgCD6DLSE/fBhG8O8FUt+i+vMPcGepaHJBu77MDFYv+fN+x/GQxiOJwo9aVnPrx4mjhETHmCtdFVOhx3ZpreAcrKTcJK8LXYwwQunpEG8PpTFF11aWcW86m+s/dcG0RRQOnJ1ykNSNU524hQUlZ3MJ7HTftcbRg+3U6U9AibYFLBmieBDKvk5AsPKYmbsb6ibbvOkVvTHIGHizeA6eGFNkLlO2gXeAqqLMtcEuWr2I6ffLNtVd05ehFIAreKyO3hRij7Xiq+br3hKW0OoATP9/FXpEhZhSk4WzMiLPiGllCl5SEtFK6dcWDocVJ69NV+1zTuLD4GepRmVXf/LpEznEpdc5ecdn27e8nA8vUnX77t9tSSW7b0w5oAJ6KMqQo23En25uBplRhQLUnKDwbOeJHc3rJcUA8pqgDENo4oC7nmdcs7VaFdlPTljXsczxumUchpzqrgMMq0JQGuilWsCcwtfFydU62NOsLuvJWAqjhUrxdtU6tt4rppngkP0I/Kn7e8fhajY9/cdc89DZDB2tALIx4pejvemHNoULFotN9eRuqWtH10pdXxZBsp4+t3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6506007)(44832011)(41300700001)(6486002)(478600001)(8676002)(4326008)(8936002)(6666004)(2616005)(5660300002)(6512007)(26005)(1076003)(6916009)(316002)(66476007)(66946007)(66556008)(4744005)(2906002)(83380400001)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RLMCCjy+Gz20dtSP4rt4/NceysHRlEDPnmeJUtbCTu2ZAJWLLzZ61oroyhpw?=
 =?us-ascii?Q?7/2VXRkObtofKFJcVk8L45bYpgHQAk+5I/4KUcgEC8LFLqOHfBz/TFzxCls3?=
 =?us-ascii?Q?Ww3oro246iqw8YEN2UnrInY0n6Q13ZlSghmdD66lBYF5ys2VL4zznJ7f6dbE?=
 =?us-ascii?Q?9gGDGpy636wjUL8/yE/MBIW19lpZ3UYT8iYNvLudE1+kChMTjHTbY3mqwjA8?=
 =?us-ascii?Q?uG3PosOQqRlur9trDvSnJi+szeJ5Lcl45+axW3//FbhSsw9dtNcRb2LJdryU?=
 =?us-ascii?Q?Wr3omj/SICr+4AmqKVA928EsCIVsHNU1UAsEWEdloLOYcoymdN046RNzetxU?=
 =?us-ascii?Q?PebxUVs1MZkq8soKfDxues4docEXGYhBKBRpKL8u4D94KgPQwLKEJSCPz9iz?=
 =?us-ascii?Q?kdn/qJgegvH0ZORo5QUQPMx+6dVRcKGW8wNCt2+gxNUT/THGtfsN+qznUEcx?=
 =?us-ascii?Q?1cKVLEzjO0N6aTf5HUawHikGJCNq2rnD3fV5ZNbuq9My/izeZtUH60cFP6sF?=
 =?us-ascii?Q?Xq1EM4cKtiaynkdhZABjk/DiHwys5POyTXPfpg5oumkkXW8z8/o6/7ZcO5JX?=
 =?us-ascii?Q?FcJVPhpVwq33X6PhYZbaFXd8+/VOI/yYaKkrcm77zsXxKAHddkDqxY2JMliD?=
 =?us-ascii?Q?qrPsAu7AOp/JaZlMOk7qmglOMdjk/YiG/K/uI4eQIPLBPqbALMMr7dP95xbX?=
 =?us-ascii?Q?wg6sSrkZIHJVLgVKb3RvUHoymvIJPUNze4IdkAb49d+m/DWU4gYfbKk2Lrzt?=
 =?us-ascii?Q?/wIqhet/Xbo36KjB4RZY5jMQv5M5rrin3L43IfrHVXejHU7nEDixzxHy6JbL?=
 =?us-ascii?Q?oZJNOme01MQyG0wDozaCe1xlBWtu68HT7FuAqYlw/iRrz2eq1/JR0DslP/a0?=
 =?us-ascii?Q?ErJhRH/5mjAx79hcaJmaeqHnmH9Mx8EjofTO7sPfXB0jSIicfRvyHyIuNbsK?=
 =?us-ascii?Q?mGRraEldslRLBKjPaSiQPAyY4T74TDkgplIhP/4pLPzb6ZHlTmhrJgGJBokd?=
 =?us-ascii?Q?W/myKfpGKPwVsfBiRSmgMs+EbG/3VK5o4WYzpjG7hYDT6pL5orXd2B9ud2hC?=
 =?us-ascii?Q?rs9FZdfkCfZ0NdsQF1YsPz1yaCCx4JLQ/c0El5Xq6sXJsFYYFKTcqEW+KxMs?=
 =?us-ascii?Q?URHpK6RIEtn3i8Gcjt5KPTKumHrjMlaPiN3S+PdmgqFqC9C8ITHaH/CcC7xX?=
 =?us-ascii?Q?Kx3iBBEBql6HMe7FIxwylCYd0O3ObuvS2/kqce10dqDG7ZS5oCpb54QVdrH6?=
 =?us-ascii?Q?7bZqfJJg/pFLpze6rThf8jIlmMrFOpYQaLKEuegDCroP98Zv6VFPM3YMv7Q4?=
 =?us-ascii?Q?gdpAv589vfsL4UYgQowILsgqoJ//LV5mkIPLBNj69d+W0LXHdGjCdlkzbYAY?=
 =?us-ascii?Q?0H5PrWGG8jHQn9hotCFwu8ONNI7xN46ZS7Ns/lj8U8ez9p1B7irAIiYi8dT8?=
 =?us-ascii?Q?RkBzz7Ffn9+YzKzsm3ZtvGnwe33jjnH28ooq36icomD5we9f+Sp93KjLVEsx?=
 =?us-ascii?Q?Trtj49+trYbRXVYu7SpL0LtHaG41X0SkeKTTAL1DFANzJd6WrucMuVd/x3CI?=
 =?us-ascii?Q?w5sZvfRJHbAkxwfsf+QVCOnuu7aPIrmGpLUR/MlcOhvRAxkj2rYcm86qAUoN?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf95290-1b7c-448b-f711-08dbe45ec38d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:39:46.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wo7gqREYiro3gxYICq7DRq3jaMqRxxk05iluVEGtH7zfointv1udIGhfDoKBfb+MkwgVzrdXkeQFtoBvuRFvmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8498

This adds a test for the Broadcast AC 13 reconnect scenario: 2 BIS
sockets are connected, one of them is closed and then reopened, and
it is reassociated with the free BIS hcon inside the kernel space.

This depends on the kernel support added by patch
Bluetooth: ISO: Reassociate a socket with an active BIS.

Iulia Tanasescu (1):
  iso-tester: Add test for bcast AC 13 reconnect

 tools/iso-tester.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

