Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A62E810A0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 07:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjI0H7C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 03:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjI0H65 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 03:58:57 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46C6192
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 00:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCstmgQ/X2tyunT7Mqvtg5+SIwz+CuI2Y+ME/cxJv7naywh9GjMfwjoacs2nWMSi4g5BRdNJozU1Om3gkjFubVeITge9hNeVOxD8LwtX9RjLnAeoLmMLCz2yELhYlgF90X2pqoAe0C1vFOk81pmtz1I6SxFhew+SMIMwAd1/KkMCHo2V3QpVgXHmEIK3GIaNKaFStClDlJvFERPXPuNSzWgbsZv8odhPIF0NJ++YYJqzyld0VkEWQ+P2XVSCpvsJ3pnNpV2lJLx79gIn2l168u1ldgnFJ9xVrA3Yo3OSJ//VcFh0coUQzXSj7n/OkrIm5GDJn3r+bILwowgXfL/Lfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifQcjIDZTtfM19T6lWEmPswcuHz4tkdjYLLadUQDpLc=;
 b=lkLAsQxkIfg/j8Ck8syyUVXVlKSC9dnCmioLD9qrWF4N2zLp7M0Vqs68nbQlR6bs8La39COU+7rLvxOLyIuERlSTBZ9VFDCF6e86vkkK1ipf88pfbl9HooXmI/3zVPvlCWTox0mkHp7WZu2j4gbxhNyxcSELGjxx/GuTCjZL6FXLxBH/zAXdrBJOF5giX0n7ZI6r1UuR8AkmTTtDUsVwZM/hGhHtNdUEZEn8FWoLxo5vHATGPteyeFgTx1BpYg3YnmSqKIdlXo+qqbZld0eNTqq9FGAfZcr/oqczebXcDNxcA6hKLvdmdOAuTMjkIWyzyE9BSacbK9FOutxRdc+eBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifQcjIDZTtfM19T6lWEmPswcuHz4tkdjYLLadUQDpLc=;
 b=JhbMpwFpxQwqYPb6XfRympmCO3xSIaULQk8vMqpZmqoB6ykK8y5I7CKVRaJNHurjTkWCASQr0izCvpLGQ+poj6WdCssmU4ZLkaSt0flTlFyG59MEgUi+WzZL+K4dAoHmP4Zd8M+jDYqWneBatk07Zz5q/AVJaq8TbxnJf8KoU/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAWPR04MB9912.eurprd04.prod.outlook.com (2603:10a6:102:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 07:58:53 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 07:58:53 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Allow binding a bcast listener to 0 bises
Date:   Wed, 27 Sep 2023 10:58:34 +0300
Message-Id: <20230927075835.20125-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0129.eurprd07.prod.outlook.com
 (2603:10a6:802:16::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAWPR04MB9912:EE_
X-MS-Office365-Filtering-Correlation-Id: f2609d10-4fa3-4f73-b507-08dbbf2f97c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VE+7PwX65e+Incl2toy9eDK/XJ43qg81qhmk72q3bYq9OSVEmqQ9M6R7jsT5h98QX9CBTYc9vVykmYZeJ6IlwhW4zLbb+C2xCQtGSHmen9spMY1zDgddcbD4Ix+KRGlDVK4TXnmCaTWpQBD+rAuMha9I24wd0HP8xdgfDmfFWfrx/kEKWYtRuUgl/uGTr9jkpZKfbAhIPrNlqM5OfxVMAFDYumz0gaIYcs+zdLk447Q/PZeJXo7LT4mfL/101xqwu0dXnuswQl3jBSPE9WA0CfmccTnAXKw1BavURbqu0XEUdlcR58RjNyBB3YMr4HGAGLaE5vxWFjyN28rChY8ZthM8sixgdeE/QUUgHODjqZE5JZH2i7UP7kImZvZhyv723U2GwwU79ovq9vvYGOfUtHmB/3PeeqRkIs+rkrtJtBPtZgWi6wfvk8jWZsVgXPsY1aDQUoNpCJLIpvFvxn2I70cYdxF3ajb7t8j0pFDITgSdk17ndmq+42sxFSxV0x+8nLcCfTcBqqP9fxS8DX3Hrp1XRbKmLHpZxriphRvSjY3CECYpma6zDtisuWnRxcvgZ5GEdnEcUagB+udi08m35LdWM97WyfBR3TE1m33YPkUIPEQ9no4LXxhVVzaA+Cv3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(1800799009)(83380400001)(2013699003)(8676002)(8936002)(4326008)(44832011)(6486002)(6506007)(6512007)(478600001)(4744005)(6916009)(66556008)(2616005)(66476007)(86362001)(26005)(38100700002)(2906002)(41300700001)(1076003)(5660300002)(6666004)(66946007)(316002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AdJcr9blQ6Sl+skhNIRb+5+OPeRvacNZ8nGQZLbx6mJKsr+UG2tOnzHoUEUL?=
 =?us-ascii?Q?+ItVdTAQHXFa3Zlbq7LMIxRGO2bMLqSQrdkJ5KcBuOhbs956KNdM9Ww0A7JH?=
 =?us-ascii?Q?IoYvJ6XpNWjnJohyW2f+ZnrvOs2mCFkWAuH0D72AXWRNRvOk9G2MrurQ9mAO?=
 =?us-ascii?Q?rozLXPxFJqP6W5T038i196QlCtZ1S7TTFeHMPS4T6JLk2VlOWop7HPz8ICtT?=
 =?us-ascii?Q?0Qymy141dAwGOWQJwFriHmSwX4GYyF1NneIuDEQ0uO3LfcZmaF40arbTYsXK?=
 =?us-ascii?Q?vaZP23L9usBLVFvEH2uQ/x06CMt1lWKJDXNsE9Rwt6UB70ahx772POen91Lm?=
 =?us-ascii?Q?uUk5oU3oZOn1CG6eDg2HtqsA1QdaQ73KI3IRQNTh9d3byD256TqQ5cO+e53H?=
 =?us-ascii?Q?dXQ8Cql7bgWqzXxdEuhe7u5UoqkA+RGyCGvqRBhCzUZTeIqYicVTobLRvpIu?=
 =?us-ascii?Q?SbIB/igLULtwfO4wxVLl0wUj0ppc93SdM76HhmUkBhOTc9eDFfFdvwLGQj+/?=
 =?us-ascii?Q?NhPbeM1OUd0ufcFrQO/jzElQwiOMzQWwmomYzCcl3LG7cGN8YGmxSg6RVlTg?=
 =?us-ascii?Q?KKKhON6u1B41CyuHh7u9zvY/W65WOgq6emk8t0ZBRyqGlV+Ol5MG9aap4FQZ?=
 =?us-ascii?Q?lT3n+BcHBlocmMaVblhahO1Hbcu47uH3ywhr98o+KP23gnb7yz7s2rLYLfNe?=
 =?us-ascii?Q?OFZwvXm8p5wsBBKVyNJFnQPsDD3ZPt+pvsBGQ+RFkuRNMzG5f+pYg2y8agzp?=
 =?us-ascii?Q?Hi2K2V0ehV/MzEYP99/dFBHMQDbUPP7zLCLkoN8XKWCCeVI0hjdCXFZXoicD?=
 =?us-ascii?Q?EoRy+1r2ybPrsvbja62jw4MxI+ltkLYAQ9uvuV+ln3zndaoxgdHRcH99DrZf?=
 =?us-ascii?Q?SRxYqmRaj/yGO17yJa3Wp2QVNGDx6SZ311Y2v9PmUmt74GUpqcXscMAxl3O2?=
 =?us-ascii?Q?xcKRhe4wIWGYpXNKkx1S8UtE0Hko/bZMP+3m4qyjnr654KfBiNn/s+xCYMSE?=
 =?us-ascii?Q?bKrQfW+Yugfi4nE39mtqofHmSSHOw8r2jfm3AkgYQaQUaHBIf1OPPdgrcRYk?=
 =?us-ascii?Q?SSCdZEwbHdhdZVlzEYtkrV57FrRqnCS0KTrouH/jcuUshOGS7UEGg5YMJkm2?=
 =?us-ascii?Q?yMdRgzQqO/kJrLxJJkRcOmoAxscvcBNYhHYYCcR6/WIUibyzi6PgtHqCH8RQ?=
 =?us-ascii?Q?2yu80CEThTi2/fWElMsPYMGm3J9AT+g8ColKRa1BRFdqB35p0Qp/cvvMdvzK?=
 =?us-ascii?Q?WdXwhECJeiwtuq3z2pVGb/1t3puvn505Xes+rTCP/yP1jK4w/2ELTnD/MyHP?=
 =?us-ascii?Q?a/veubolxZY7vpsR8XimshHGEvTdCd/wBEZF6NWh1QzEG/sBStc13zjjFtGF?=
 =?us-ascii?Q?1aqhEz2ItFzHR9NdIsbiaOE1iZs3GCWEywEBP8C2jSf2zDd3V3KC7Y6LtuXV?=
 =?us-ascii?Q?33swR/UefjZXOqKdk1Sbi5WI3wyz28bPEtmMhqZqgJX59T+9ZRAPf4KwB5uH?=
 =?us-ascii?Q?FJy4EnBwhVr/W1l+/Xk4RXikPCgRLAOU21sfWhFJ0MO+4uXKkaVy/Xsng4WB?=
 =?us-ascii?Q?inDFiVV4SaRzJ3QdXL657nq+9Qt8eSkInSLYeUvjXSIwp/gVoXbtPWU17vsi?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2609d10-4fa3-4f73-b507-08dbbf2f97c7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 07:58:53.5116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rojoG6NMtMUXsnL32BeBXZZyHgX4JbexcLxQLoeW5io2KhOvsYrf1r7nZ8G9JVatlVWijPaosSUDtGr2wXuHZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some Broadcast scenarios require for a broadcast listener to listen for
a broadcaster only for PA sync.

This patch adds support for binding to a broadcaster address without
asking for any BIS to sync with.

Iulia Tanasescu (1):
  Bluetooth: ISO: Allow binding a bcast listener to 0 bises

 net/bluetooth/hci_conn.c | 2 +-
 net/bluetooth/iso.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)


base-commit: 091e25d6b54992d1d702ae91cbac139d4c243251
-- 
2.39.2

