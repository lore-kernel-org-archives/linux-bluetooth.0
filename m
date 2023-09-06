Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7955EB8FAF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 09:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbjIFJeF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 05:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbjIFJdy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 05:33:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9251199B
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 02:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e15C1jiyjBdiCOA61Xir9mlPKWHRK4Ai5/ZS4xSUOKG513kGqzCitTeFdBwkyNy1igui6zpJkPuZoF/2o7P8/UdQ2DVE1axpjG84iFp6l3NWQvgh6EmYF6zsJ6rv/T6O11aaV6Q8FOwd6aINqQ4zj5TPeLfiUHW0OXzhRnIT4lHPsp2Vd3NykZM8DthMsEil13KLabePNYIrNAB0eX1o38KI4ugPjMPa9XSq4OKHse54a0pEawbwsoK46zA+CyVFvF6PmTwsr3NVnqzOdM74wWRBBjFJLvFlPCb7cMzRyds/YYQA1Qg+mI5FSb8XpDW/fKcR4ehy6/Zc8RBYUKwfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvNN+O80hO6Fs5x2PvCSam+t2/Dts/HoBeP8i8Wc/VA=;
 b=Dytw1yiEEgKzqPtpCgX0LhOq9++oQ0cArQ4/gBHz9nivwbO5svKOdHxTkSsaNEmE+ohBz2e2k5w2n8Ujx+1Gnpo3FNbmRVU6RkRy7iXJfKgHLiTdecyTi0JX5FBGHKwgfSYHJ6i/wXO4gQL/kGo2xl1U2ePS0xrQsmBnnZLJJMzFM2Rh400fJQ8eANQb14/MmkR+Tp6bewshUqYPKglbW9zzHclIqtUxmEm1kDh78IDbJoy+km22tQJNjMUqt710cPeVAj2Kwskw7vL5ZCKWJKLJ5Nxy5zVpke+yHgtxSgbKtNClSyGnNvr2aK0/1SlCI9NydaUC58nt/A9PhDZ62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvNN+O80hO6Fs5x2PvCSam+t2/Dts/HoBeP8i8Wc/VA=;
 b=rHl99o2yR7NGWVJEanrIBX4VU7KV7maZbcY1NJgIQwnLRPse3bt/peMC+tAdZVUw9fxpZio5FqIcPRm4I7xaakhQMWnbvdDO43a2oReS4KTen8uQOZtT7+JDP5KEvt/bMQs5DMX+AxnQIH7hDaNoJ21pmqNcMTpaeh6A8LbYt0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 09:33:32 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:33:32 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date:   Wed,  6 Sep 2023 12:33:04 +0300
Message-Id: <20230906093305.11237-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::14) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfe8517-04d7-4904-0cd2-08dbaebc55b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onuZkL35OVxE3C3GAd8SvHJ9qc0bCsXsCvJcrdiOhyPDgmXrq402eGePw3hk6HUt/FWZb2NpTqOrlxujiV9BjO4e7j3ZfSvHEfjnHGnKgsIPZ7+9/YKQbMckgFttT+CJpF48L0s7lz0AEXHN8rVfQCo6FE+IZMDQq0CcKdeFh7RjmVhlvtqKioXk9QG3rwKTHV7f/RvKhmbALhrF1gq7MDAvpQ6WezybLihi5wd+toaj5MaR1REF4eaZiumlZVcoeKHNDE79q3lY+/TZW3Kmyj0CFnBPHgZaE9ykdgQoFxzQmRsLVMW9OsNf71rZ1Y/dR38IypUWmYCWhWZQMQCQN7UWfKUbST+tlinFQvyW7uDvTKi7vRXmfNL/AON+RiDfYDx4c9gY+SMw3WXC74n5+d0+YQYEvLQiMTiP73o6kr11u2oMEtzOK1+T6gDg7uNrbDAUuxvuhHBC6Tv1n3gK9UqxUrNvPWT0kW6hEKwSvu8J/CpCtV+DncSLikYtfflMBmF4PMgiSq9nJNUxyraS+AwscfOQ16vJ5TjFmXKHMRSb6LYQzMc1tM9PFptxW36g63erWZKyNaqDcDbhH25xJY8jJCOTEAGnuRTWdvQZTlsLEkaxZhOEIC2OZ62ViyKV9AGs7+qBLyjoDay8cdt14d71Gnnmj4rcrC5xabOBY/o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(186009)(1800799009)(451199024)(83380400001)(4744005)(2906002)(38350700002)(38100700002)(36756003)(86362001)(6512007)(41300700001)(6506007)(52116002)(316002)(6486002)(66556008)(66476007)(66946007)(6916009)(2616005)(4326008)(1076003)(8676002)(8936002)(478600001)(6666004)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v9zukg9syWdPnD5gCwEZOKqnCiHZDCwPirRQtxp6SwkYvZE8HEQbPxf/hcRN?=
 =?us-ascii?Q?HecSlBlZ+iYQGZGLCXt02+Y17i8a+dzY9PWfH31HswvNqtqDMpguYSrfOJRg?=
 =?us-ascii?Q?9ynTNfAZEJRtOfeKpuITrqYDBRC6Fs3gHBQhDkyLC0szKXSUUMjk4/2MxO0X?=
 =?us-ascii?Q?U0qOUnVfxVNluom1swXWX79Ywo9qTZNm96vKwLM2oaRTvcQPOFc5IeiL2Ajf?=
 =?us-ascii?Q?y2zvJrWPYtvLEqNb5XDpnlEufVVUGTSkjdcD/lqaLoE4Ygnn3KaSnUb+sZwz?=
 =?us-ascii?Q?hLXpLTgYna7nO3BdVhlGGVEIoJCqmDzWZoTAyA2e6+96mhghYhE/LZsZwz92?=
 =?us-ascii?Q?xKPmRgmsRF6cv+AROwcZQhs5QX82jNtN+TFB57Ik7TAat8DUoPtULdydS0hW?=
 =?us-ascii?Q?lVIa45uAv/Nmkm7u8DQTF2X3QtHkM8fVjpRuk/wYGMZFEw/kGalr/dfQcEcr?=
 =?us-ascii?Q?zN1NM811PBZw5INYiPJvFuuwSnq77cn1B8sgHDuwb1z3xKz0ErhIpDEeDIhD?=
 =?us-ascii?Q?Qr2eJyJmSw6KOuBsYd6qMOcu7DhbivuagSi1Fq56U+WRgMFda8tnt3iwXVQn?=
 =?us-ascii?Q?r7ewofT8dok+pgn6YQu2HHN0AQYs9vQxP43l+LGhFyLigkWJ63knrm/5/2dZ?=
 =?us-ascii?Q?F76Jw/RmiQ6QUL+G4aSk4QP5G6ZjPg4IMyR1JGwHwtPX3q0zAklM5VW2oz7M?=
 =?us-ascii?Q?zugel1yRorjDCfOtmLpJkJ55qS8JRidlo84vreVVngfbG0bMPZD+m1StJBRs?=
 =?us-ascii?Q?stldv9yC4+iIzodU+b+TsNkZtk9MzieDaP5Tcdau8veEaNZ4PSTfQuZN8xif?=
 =?us-ascii?Q?COom6MQdrakxNUo4oAXHPzoFgMSlBajXi5OBXkI0LMjIh2HtEZ48TWL0xqrC?=
 =?us-ascii?Q?iDA/Yzn1jAV0YaxNuSs3oKzEWRvwACI8pSeg0sNvi3LOC03D2EbX9iN/Mp3w?=
 =?us-ascii?Q?gmW2QMIqHfp2v351yxWukjrQrGIELH3dOrgjrrUJUQtxkGdNhG4Dy/nUq3a7?=
 =?us-ascii?Q?ksPn5INyHuUxgZoFNXUY+mFowhNvmYUiaI8fluYJZD6hSPbAMRGI7w449SgZ?=
 =?us-ascii?Q?qgS+tpUkz9XWfFs7S0TuqWISUXhb5Wo9yDKi5+Vwy4PvuOkIl1VRe5zTemLt?=
 =?us-ascii?Q?FjFWSScN0OI8IVJ7qBw86ZZVez1SypusmbPsloj7bhkcQ8ylrjaNOEMb6VpP?=
 =?us-ascii?Q?HRud+zG0vIolv+01Eut8MHvTb2VzNv3Atk0besAR7jfg+/4ksAxN/P5ozB/+?=
 =?us-ascii?Q?NmPG5tdmWwopd1OylmI42kiJXTmxtwXkGtTa6I/w5yMG/JM+SOlTIs82/E+4?=
 =?us-ascii?Q?bq1mGn0an2LBCvyFGgV7CYICqOD1MF4a1Bj2DhNFdeOsAjGPGWTArLww/GDm?=
 =?us-ascii?Q?ga5wvDY8n/4tuxzf52KuMjXub4rGtfAyQOTnkefbGcYwZeeTid7B5Cv7d3XC?=
 =?us-ascii?Q?LZsfLSvHtMfd/KaxFjrZhic4qL7HKDvZ2WgJTzIR3mmboaUhVhQgELSFCZsM?=
 =?us-ascii?Q?rtSG3rF6YU2zpH0w0ZRKPX4GFDbGxR5TQBFCPd8sC3Ry589HP3Uqpfyztz/X?=
 =?us-ascii?Q?d5ad41koTps7UYH0r6nNy3fOqyGJgLWOME1ELQXZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfe8517-04d7-4904-0cd2-08dbaebc55b9
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:33:32.1048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2go3g6l02Cy4Mta9ROrU7RUkZhXdMi0KN4D1RY2ROtDn5sy7FjsPo4Mnyqj2bbVQlr11fjEJWt8QsNW0JC4pCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

Claudia Draghicescu (1):
  Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID

 net/bluetooth/iso.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)


base-commit: 52bf4fd43f759ac4698f041fff2cb27691698265
-- 
2.34.1

