Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3255AC6FA9D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 15:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCAPdo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCAPdn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 10:33:43 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E01A658
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 07:33:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMPY6coqYLrW8Z5/IYbEQ4t43iCpvtVFPgYArT9bJeV7rdY5JDnDcYTR8NJd6xXRpbv2zdNeyXKqy5AoU9fHNX0R4KeCnOI9n6h4IGSh/l7sVtTSWLBR4AUub6jTK2Fi4qjZ0/oWvCxO9+KlfWC1gRj0DZN3YcpqFbJF27NQxtIFtlZrsCZxjef+qhw0rsVGq2UyOcQx9JXXBJipDxgxHif5Pfy5aQdXsik9XCBg7EhH3pB0CJ6+/a38gkVjUI4Pu1dYjVoV1uSc8zTSthz/z0Uu8RtblKKUln4TCPVXVoXrHjgc/OEFv8SSOk2Egm/Ye4kbIyJoH6vIKPYp0OE3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EotbkbKQ5WknFr0iF1RDglyOYBehuc3CbiWL/zvrtw=;
 b=cVbYQPtzHMFSbALvk+2n/ahqtMeGtzbVD8U3aHprSTapKGFsncnkyCCGm61ltBqkwbvNDvo0aPSQHaxX2dGEw3IZAv0QYI7gs5nblclsIfpD26fdMAuqLUTKqwbRV2jlJiV+gPX7THtw0/RrgR5crD6C6w9+WlJTQy8UBMgymB0ymTfvBowhpf0UltiMxCiGGzhOpT58IgiFISJd53E1EGsLfUPDyEIOBo/NCNbbRsFOUn5CH8YAUXfM93rn0xiL+TAJ18UiRSxHth2LrOgpz+QlKtVb0YjDo+hxs1C4MKXXI2n4uts8n4qDNsCe8y4dL3/cj55hvHEfJnnvapnW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 15:33:35 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%9]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 15:33:35 +0000
From:   iulia-tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia-tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] Add initial BASS support
Date:   Wed,  1 Mar 2023 17:33:20 +0200
Message-Id: <20230301153322.12555-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: AM4PR05CA0028.eurprd05.prod.outlook.com (2603:10a6:205::41)
 To AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d2d3b4-73db-43bd-fb49-08db1a6a523d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19M08n4DM98y5wns2ehYtwPGOQm4QPfXRfYvwjXPvjtjCqAJymTPp0dib/jCSI8WbdpJlf2gMJ8JHp2cGkT3Cj6OvBUuZrvd9vrad8oeRMHhPlb3WBR9uW6LWHtKuCnvuy/dPCHP+I0o985i/rgz2mRbnE1fyMd7Q3+BvFi8qaR2PIQTb2S1CKd6YMLasNo6ufMX4Q1L4epK7jMnk+2eClGnDPKgijwUb+1+tI0Z7rFPsv24GptBRkteguOvnAW4mC9wwKWwzvSQCAvzGnyOGpfzJiEjfK+r54e5Jl8WiH49rhI7oBn5tdHz3VTsvb0ab6mwWo78e6DU1Fr9xEZxpFrgSMi2Joq6pGzka/f0v7PQic5OnEG9ltVuSz8YbN3LPMKknEDKRkCZdI+f7L4DB6QHHvl01PJ+iBEHR8wCSiiFMDofwvx22ziCTg3lPlu0FuKytxWMhvuJd96Vpc1N+cDojLI/g0Kex2GkNkNCa4dFoeCacqhlPVZ/ku+jdGxGnPqz/OaPa//klj1PoalrV0azeiR55sZTn7WFLtkcBLqkQZevMWFnEGjChzxBBaxKwED/jgtL1x1MEJOygE351FCIoqbgulC+owBK+uvJ/eJj1YHmKCbQspzSn4erUUh4a7QjvE17l0vMqTw6zGWT65K/2DPWAdjyanCcUDvtcIW1WSLJyYveMwIZW2PJWm2PGSiCcDd5RgII6jF+l5ZXCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(451199018)(5660300002)(4744005)(8936002)(36756003)(86362001)(478600001)(2616005)(52116002)(6486002)(6666004)(186003)(55236004)(6506007)(26005)(6512007)(66476007)(66556008)(66946007)(4326008)(38100700002)(41300700001)(1076003)(6916009)(8676002)(38350700002)(316002)(2906002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fVRMc814JeovhE6pUQEXkU79UD8TZkbpUFR04Su6Gz39rR74MMsHSNJowMCG?=
 =?us-ascii?Q?2G/4BahHHT5+lUxsU3tm1GPtI+H5S0/gFXxIVQWcroV2/UG1tn/vZu8I7Xbl?=
 =?us-ascii?Q?+qLSrCwkZA9fxikUCxGPFrdvsJdZkEttEPjkNBqn4nZr1WsAyOQpBHz24Pcw?=
 =?us-ascii?Q?q/hf7xDSsbALuZZabx74JO3akpYArAIhLzzVS57rLcabK5cIlBozRRVUW/2Q?=
 =?us-ascii?Q?HjbDJhM0h+A0cUB/J78VhPreGQOgMvl0vgPaknjGK5rlzTDoTnTsq8p5bli0?=
 =?us-ascii?Q?aHRRCcRBgBUYFnPhEViQkZ84AhiqBtciHoQTRr0TpqM+TCH/e0rdmpZMXWxH?=
 =?us-ascii?Q?SxYFwWOgtB1vFFA+kHBNx9q8fYwnHpJTp/EWJtif5V/redS6a9gBkCKFjPMb?=
 =?us-ascii?Q?EIpTw1OLL9e0dUZGlPtKkZoA484HqloTp3Z2yjI10spa8vy2TSRQU2cSIrXW?=
 =?us-ascii?Q?pprIyOt6g5kmRVIXx61cZq2x1ivSlWRRfNv3oDk4vk/44qV7bCUNIOo0LjOg?=
 =?us-ascii?Q?WgWcuMPi8bLxHwnle4cN0Cmvqq4BEGBCIb2tZF3IyfJB54ibN2PzwO7f8TQ8?=
 =?us-ascii?Q?JU2efyrkZdSehvLnJTM9mIwxmo6UVgOHqW8N1ExPZk7PV07uyqacZMaBkLjS?=
 =?us-ascii?Q?lLZkA87nOoE1+t5atY1dRUQ3CQiN7m7AMb9iVw3GVYM6Y+fIPC0DgCTKDMmF?=
 =?us-ascii?Q?VWgj6d4Tm9IS0G7+zcgyYFmX0bFC5GjkCeWjsVcdSoCWGs2yIyLGqL3kiOhK?=
 =?us-ascii?Q?Ql6KBr2RLH+u+rHLTf08G+jXapn0p6OZdGRTJK8dryjP8P/5ammOj0YkF4t+?=
 =?us-ascii?Q?3o0l/Zr8iesAvFiZfAcnIlf2F91Dot+pHjWBch+uqlPkYh8uze2U1wBiF4H/?=
 =?us-ascii?Q?cp/atGAqx6IremDX//ice2Xjo/OF0ADIUkfC6+FbmRH33qVGDC8On/c2VYLX?=
 =?us-ascii?Q?T1+rzoXUNWnTBARVfqGHawarE2vTTIgCyD3IEsAXE+Yr6V3nF1+aTuWE5Qbi?=
 =?us-ascii?Q?hXIJ1lR3y97iWPGQXRHL9n15StB9YzgGRdPfnVSLUTMn2dA9ZSq+pYC6F6jL?=
 =?us-ascii?Q?viB4PzUkcVvqWHrTRNz7xa0WjOcXqGu4Ek8LRnL1+DF0LC8TfsV9D5OVU/kq?=
 =?us-ascii?Q?xKxNYhjTNOwTJgOgAxbbcaoSWOlJoP9Lli9p8lAwMqBF8W08T2fl+R3Xzq/l?=
 =?us-ascii?Q?2nQrX7evtzEq2YznwJFRW4Mq/i5RR5uxgC/AQzFg62RmlL6+8lCx7xd2bXPH?=
 =?us-ascii?Q?cwjM58Vuz9FODPNoZjHgoNPPtucSLJjD8ls+5auyfmmHaDTKWQSRPwTWOSda?=
 =?us-ascii?Q?Q95HbCDTRCu6qIOvNb0Ls6/vvL69EBmnkMDmq177I8MkqDHcAFXTik9RG+4W?=
 =?us-ascii?Q?PlKLwnYenqqIQdnBbEepKo0A5RWqCIixkm6KgvyY4NVOL8/ywe7oxGWTo3uV?=
 =?us-ascii?Q?MfPKTaSLi7NTj558mVUoch7fwzT78vmqci4FsHzQakO7cgwqFxz35AbQbJxx?=
 =?us-ascii?Q?u62BgtC1GFa/V5vFVjnsSPv/mkXw816iPuoY5Pl5g1HAA/oSHLOt2g+3CmPA?=
 =?us-ascii?Q?KaXtDJNWWIWg/PA39n7jNyGd3WuNRz/P8WEadUU+aPm9z+V9/P1RuNeHo8Ol?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d2d3b4-73db-43bd-fb49-08db1a6a523d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:33:35.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoXuDfZwou2a+mji7p9OaaTKxrfWrI53maVlwRMm+0/2STRQZod9RLCRvy+aDbnQqAAvSg4P7UvxoYnbohCK3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds an initial support for the
Broadcast Audio Scan Service.

*** BLURB HERE ***

iulia-tanasescu (2):
  lib: Add BASS UUIDs and auxiliary defines
  shared: Add initial BASS code

 lib/hci.h              |    2 +
 lib/uuid.h             |    7 +
 src/shared/att-types.h |    1 +
 src/shared/bap.c       | 1065 ++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h       |   25 +
 src/shared/bass.h      |   43 ++
 6 files changed, 1143 insertions(+)
 create mode 100644 src/shared/bass.h

-- 
2.34.1

