Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72456C4167D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 15:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377009AbjKBP6k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376703AbjKBP6j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 11:58:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6F4186
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 08:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTy26pirHJ172/ULpg3DgpepGRgIpoUTXphBz2AQww5aYrGG83VN3ZFOOiOs9g3uTJoy/7nQn0mGmrGY4uhYzy9wWCRl68L7TWrNhdfUfmSr4tbPTck/LQQ/RsMCxFpBsQv6i2MkuzlVZtxkEFT9uP4XmyNtVYp1LUyKntX1cluQt6d1qQ/qkmgNdwYZj27JRFH0/34gSdTvMDeMvR5y3NrgNaiXAxuXYzfDZ3APj37b6WqqtmQ7VAb6ryFrqwjnMIhGMtTaQZUAmggfVKSuJ1Fztc4Ra4AMd9PrW8qxM3nxWPoVGHg1YNb3beJBKgAWRA4NMF+yNzYHFEPjpZsxxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pal62jxlWOJrDRuNiZdPWfuXLncglhTIHSmwksPx428=;
 b=NhH5vghabr6B2znq8QOwzUgmtjorgTdXXg70mpGLV2tDWrthCO0FAVtt7RbLD9lRXJR719oLmQDrKrbVfaUsNzXRmxjK74B4RsWqZDH4I3rMvtxDfvWkJHuYXIPGcH8S6EQQOdDeIXE2px9e4uW9/Az2/Ohb+3ao4/N0SZHMNdZE4kCUaC3cO/VBRa7zUsVsxd7ZXnpK1a6sophqd/Xw14nXSQBAKVe/XRlgoYIE8BhjiFyxsbNBK47RPFuhUpXLjhHuIJ3+kAjxPqzH7g+586U1aEiLpDZmn70eECg+jLj08Ok5sNz1UXNo0WlwpcNAgERYUxR1q0UNNLddXWrEzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pal62jxlWOJrDRuNiZdPWfuXLncglhTIHSmwksPx428=;
 b=Od6Qdxl3WkA2/sgkqNJaboeAXTuE6do//SMqlVsgWhS1ChIFgOMKBqfx61/VUIQzSu5dyhoADEHmEAdo5fKc0AmAfBpxwWlhyzhyLDjONTgRD/GoTz6UeDl+gEREBcBKzHdnMn9K7yWZkrKHBs6Eqyx9LRLfBvYX2hMPpOGUb6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by PAXPR04MB9005.eurprd04.prod.outlook.com (2603:10a6:102:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.18; Thu, 2 Nov
 2023 15:58:30 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:58:30 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 0/5] Add support for bcast multiple BISes
Date:   Thu,  2 Nov 2023 17:58:22 +0200
Message-Id: <20231102155827.4219-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::20) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 934a711a-9b27-4a2b-2681-08dbdbbc8f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pqCQThSAQ7BkRBi/4oIdcJ29g3lVwT7Diqa9MWwllRPrPr1BkWfpgTOIBzZ+UcAkQgKYFCZyxGs08MoeNoivsiXG5XGJazjXb7Lof/tPpnP8qRPuKgKJIMkH6yo8Y3zemGRYkHOGyt00ND+M0ZStFNKwbK9zQVq1KDnWVPUQ0RRL4YwFF1flpVwRJOhDhj29tcwPGx55emhXKTl5A790PNOVNfygDCjIKUr6a/UejcamofgjVejUMufa7Dnq6Pm1eZ7JvbLGGLY5v+eLoq9EkyObqtp+mbffnZfThBFARLqWvSvwzZyk3o9/bmWEJMn7MyJVouig3fDwQGZvDlA6SYr7F3Bq+i2sz8AEsKRpnj0GWFAa6Zb1bHI7FbYeIpvwXGcOTkj/35M17apwwu4rEylpZeo420CrDA72d4XH3nhwiZVp7Z/9Us+vSEX3mLEIIslGo5tZa9aOnqp8vbR8RWdiWgb5NukQOmX+ryTWJqMpO7/f+qBdIPyPQ55qOW/O03apkVBfQ6P+y671KhyDLl6v3rXspLi+YP0u3HJo0R9wQTMyAcSvCNHBhSKuQqW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(376002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(26005)(6512007)(1076003)(478600001)(6506007)(83380400001)(6666004)(8936002)(8676002)(66946007)(41300700001)(5660300002)(66556008)(6486002)(2616005)(66476007)(6916009)(316002)(4326008)(38100700002)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAbaIlbmP7e9quZgBviWVDHjQ4Kl02L8mShm2AUyDWVDdq5rnQuY1WZuJusG?=
 =?us-ascii?Q?t3b9Ito1zt5DNIbfX/Nrth/kvwrZTHN12cF8EAKzeoOB9kfTD20fM1IjyWdE?=
 =?us-ascii?Q?CWen6Z/xsxeGvzb41HCi1okKSMVKGnADk1QtWqcL23rLu33WFC1WfoQ0mEQm?=
 =?us-ascii?Q?8bT3tNUjXRbGMYTMWqpZBYqY042k/b4F8gdjYpVElZIZAZiuOBnkGIKFMGlU?=
 =?us-ascii?Q?WzP8leJ0oGVhjUPTbI8Whg9LqskFvONzCgESWNrjOI1Vi4o+pCi0nl0H8FF6?=
 =?us-ascii?Q?rFlne35Bv1ikKlSKflqA3P0wImFeJW43rSQ4zfY2ga8qykyviYY7ScV6UcLl?=
 =?us-ascii?Q?dYuKV/4ZQMyI5nY/ITqgeStBElQ4BrYj9tJa1seqptSY+K2LAcqS4hWEf6Ad?=
 =?us-ascii?Q?7z4pSAn7lA7Vhw3bjCwedbVRSVMEaBly4ONFspjAD+4koBLRs94fFW4r3UuU?=
 =?us-ascii?Q?qjco26UwwzxhNQsKLq/xXuNq6cASuoY4ZWYQY7wELYfcWOVfUny2XGBzFyjq?=
 =?us-ascii?Q?xKvWxdWddIYJYWprGv7d6KuUVb8kcXFoh8D9MMiJQhsA5LJYsz+Qz2+LHT2V?=
 =?us-ascii?Q?Uo+LJHguGMYsZ93eT9/BmuE7SiDH8eA2sWD04Gh+M8uE9rY10jtdFWwa6QOx?=
 =?us-ascii?Q?SmIt+hjhjY8onDkimR1Ovl46P6kxWKKUf4bZ0vZJ0uxJuu+abDWlyoRqph41?=
 =?us-ascii?Q?RRYKFy7hkkImv1oINHbs7tatv/1pe5PFhhfa2vN7KbVujpGTIB7EsC1Mp/nb?=
 =?us-ascii?Q?W8bTYa01Y+EUbyHraSMHUFxcPeScEDCIVas2lvRIQJYazZfh591Bqi8J5Ssr?=
 =?us-ascii?Q?kAVN02bDcsbcTy12t39fjGKwN53OCawWO5EmXokeE+soBPjZzyOM3sMb4gFQ?=
 =?us-ascii?Q?IoInz365An9iqP65ZNbEbUadHvzA2NoV9q2foxmQPklOoKdtAruXD7sa2QKF?=
 =?us-ascii?Q?s2Zb2Oc/tuF4gDXCwYPTMZJyF8kqLZ9w0T5VxYmNLMFUG9Kbf96ESdpdo+7p?=
 =?us-ascii?Q?5B3GXwKdSrmLurIM3OAWxd7mFA5E+vqDtpJyk//YT6HbTntokxAUN5JCJyNI?=
 =?us-ascii?Q?/m+v+k/+3OObXfrI0GS/55lVynJppTYZ+upkI441+7DNh/yQc9e1wmN7pWp5?=
 =?us-ascii?Q?uNhPYX6GqPEG9FoJgfEpt1aSQrO3BSu1wpPfl8fiwpvdsAEbFbLP5388ELzm?=
 =?us-ascii?Q?PDy7vslKCBuWyAK0rMvFT8NCzNViqmSkkkrbtDenm93qyPrNw35XJoI4KJln?=
 =?us-ascii?Q?zwLxeKo/tOKdy48T0xFnbeFP4NDcyWpk1ahagFQpaYuSoyU+mjwKbuxm2RYc?=
 =?us-ascii?Q?xtvDX1OTND5Zus3scoDzXfDsezMCuSYYjpdEXrVGPZAB6i5oFQQ7ntzXT33S?=
 =?us-ascii?Q?Ss4PlKbP0AiK3SZLYL6WM6US3ZxLX4iu1IQHzBtic5Cnrgb+kb8sBPnzr2I5?=
 =?us-ascii?Q?Zxr+4H1TQhi4PiRo8h/OexLewM4jfVCQLAqHfI+53VV0BNtIG9gOzeRVXGpR?=
 =?us-ascii?Q?sR94EEKT69qsVjWzD2a1o9x2w+8zhaqFZrdnx6g4jjAJF6jRwawk+T7OWUGz?=
 =?us-ascii?Q?LOCMBu8qwoKw/qZYZnQZIK4XL+M8y0Be4u80jcXSJRfFoLZO/XcuLSZftQdc?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 934a711a-9b27-4a2b-2681-08dbdbbc8f45
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:58:30.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zMVe7+bDS17rc/m9+DAnsMfqpe01fPHpt8RpZ1+15yIbFLFZfLfY6zRmP5fwFEHxgjMySqveq2HKLg1N2Dy60vO93oBEQ/Cx0ZxWb/UOuIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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
  bap: Fix source+sink endpoint registration
  bap: Fix source+sink endpoint registration

Silviu Florian Barbulescu (3):
  Add support for multiple BISes
  profiles/audio/transport.c: Add support for multiple BISes
  client/player.c: Add support for multiple BISes

 client/player.c            |  46 ++-
 profiles/audio/bap.c       | 582 ++++++++++++++++++++++++++-----------
 profiles/audio/transport.c |  59 ++--
 src/shared/bap.c           | 291 ++++++++++++++-----
 src/shared/bap.h           |  35 ++-
 unit/test-bap.c            |  12 +-
 6 files changed, 753 insertions(+), 272 deletions(-)


base-commit: 00fdb61d56161f523e975b4c044030f4b40abb6d
-- 
2.39.2

