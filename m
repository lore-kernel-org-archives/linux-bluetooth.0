Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E315DC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 08:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCUIJC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 04:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUII7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 04:08:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BBF1E9FB
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 01:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikO5/ruzQcfXHmk8tLDKrG7lI5D7zC/JnRjLj/UHCvNK9NboWRHiKtkcgW7MEO95LAUIkOqW/9hQC+2dMZd3C6+dMOA50HfgkObdkVpKc56cINhO/BQoZ1yTlYJILCNX1prcDse9SsK/hGJO9/81h056F7FIIJFqpxCF42MnAmp4Cnlbmve/KkuqTLpGrAK6xgFHqx/rpAaJlsGbpAeLeTjYtdTHt/nZ36x4AbYPNqgPQRXx1X7EK8n4k+HbQp3+qL3O8lW1JY20cCiXRhOAYj3Yw5ZPj/JFdQJ0uaaqAruKg/ma2xbgaG3EbU6sQdnJPomtsbw+r5/aDzOC+1/FQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvwKGs7sMeNDm1/xzXwTyIOiy+ctwskJv+ZAfnCzURM=;
 b=oJSUTlwY+AGHAU4GI2cmKo4IdnG+t17l/wj4QKe7L6og0DCXJG3IjtzNHSPjKe4YSo8h7jMJvKvCWjixT2Wg29bAyp+RxbuX9Vk/Xu74jctD8qONnHDfwo2YEO4FKvhXk8BfNsKLmanzTftlULZiCe1kZy0s7dLyM/B5KjWOmKOZ2qomjOZyhiZe6WrED+eBWIK9VzcrtpdJtDYJyRLJIj8AZihFNtgGkK7ZBRTV8ugjdY/yBfqa4HmD78nlInWD31lNUb6V3vNWqlWAb7kN7jQ50rL0pLSv58BpSgBiW1FhcVTV2dPyNLVOkb2aOdwtzymlweAQbQZqWObYwznRfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvwKGs7sMeNDm1/xzXwTyIOiy+ctwskJv+ZAfnCzURM=;
 b=XB1iwtt6izLHtU2jXAb5pB8FR6vFJsg/j1k/SYQtvxgUNdu7MTJhieNmGekd+Dvf/EWVkJ7RPjilaJ8XzkZuKEphRQG5YJly3Fqa9WrfW0nHI8UO7NN1GsN9xUB45b/Q201UssYu71+MD3J92eCjv7Ac3PnXX2tDndSTHKkYLMA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAWPR04MB9806.eurprd04.prod.outlook.com (2603:10a6:102:389::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 08:08:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 08:08:48 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
Date:   Tue, 21 Mar 2023 10:08:36 +0200
Message-Id: <20230321080836.2613-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZJTvEFAESfLqebuUrq6mUAw1ZcQbSMqpfgbMLkGbH_k8A@mail.gmail.com>
References: <CABBYNZJTvEFAESfLqebuUrq6mUAw1ZcQbSMqpfgbMLkGbH_k8A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::9) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAWPR04MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d886df-245b-496d-dc54-08db29e37fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQO++/L9nZp77J/bYp+AK8CCO5WLvKf9FYc0aIEIqy4N23jPb+q5I59TD/jdxfCh59oZNYRluoU43IdlFr4M9gslkwO18OTBMS4gIpDf+Khfj6fupGowjRXNVI8DRynitLH3/xCO84UJzk2+wOFwVT3NmmkqCkjBfEyJcjkcirLDCrbIPw9wlJ1C9CkoaAR6kpI+RvXCwHXuTfA5HvDtNmaN8boVT3vZBfaWSDBRWGBv6RyPGdt/L734xYCWqlVLlpTwL/hpbTmGjUvtJvnGJ1DOQg7tx0zkGR5Ffw1Ofi1Jxi32vhG0ULKrJB8n7dwwnVgagkpj/ncogFj5IyJN9Tk5xtZCFA/rJNlCHqxU0RU/GFBPGxkjg8EJbbyznAWVY18Vj298fXL1opjYmeN2kiJLzlhsaZGGBDgcO0kzXXw3D7lAsiTukFye2TbCkQ3KfAkhbn3vWZoQ/XFuKKZua8ghuVSaFSvb0l9hohl2GJ2vtgl6HS70/JLerFMu4Va+gyC415rO6lzCIcJkdzO47zjq0jl+2kXUQgf+8D5zAm5xh4hpDndcl1keaaWV+DBNuCQRuu2BYHHOhojiJFHDH9EmHJOVoboo4kc7KZftRCtFIvWHnd45TnlYUc/6tFIFXnXrtz8fs4q1hYtmRcXiEJlQnm7FMXb28JOM4NSmHqL2ZG1JvXaMR2FJpNhtxCN++0Jqe9WcVI7W/hmUjYMCgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199018)(5660300002)(8936002)(44832011)(41300700001)(6916009)(4326008)(36756003)(558084003)(86362001)(38100700002)(38350700002)(2906002)(6506007)(6666004)(6486002)(83380400001)(6512007)(478600001)(2616005)(52116002)(26005)(186003)(55236004)(1076003)(316002)(66946007)(66556008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nHeg0Nqyw4zg8KlVCtF93JpiQJnay5fYDcLclUj8S7XT3lFCQWmE03oCwHSU?=
 =?us-ascii?Q?j4SKNxVEE1Lr6yNfDmOFC2tReqauUSQh0d0GTBvB7NodjqesTzcDUKws4xjZ?=
 =?us-ascii?Q?iKQiX+gdx+7CRB8v7q6Hir7R6pj5sgl5Uxsl1gGBat2mPF+KmbPIkMUSDtbS?=
 =?us-ascii?Q?zWfukpD0zF9fTuTDIqv+0Bu8ZeMT+5U/ifmjzCQ+tkQIK/W6JKKuhD6t2iE9?=
 =?us-ascii?Q?0PBTe4oEldmAvUGmDB0e9CQfMr3yHZ2/DlMXAYcs457O3qbvbU2mtnZ7GOtE?=
 =?us-ascii?Q?7nzWNpOL54BfLXI/GXyJdeuOqPzXGmJbXGuJGHlRIeMSMfRyMh81Q9YBkrA5?=
 =?us-ascii?Q?JVnnO76xGMt7xEq8zkMx35ClGpXlOoJqXuDyjFbg/lfBxZGWqHaDeTOS+Ay/?=
 =?us-ascii?Q?hRqRg33O2V4pqNcadbF6QqdZM2MLNjEGa8uCr+MZlLJWP/MTUgsN7D76WVTP?=
 =?us-ascii?Q?rneYYGMN+Bb9m5c12UkJ/1cVLZnqnAtY7FaziLB/nCAHFLa0e+eUXJShWkVM?=
 =?us-ascii?Q?CHZvGgP4oFCJt3bVtS7NJr3HYDA5+i4Yd51UH1CP1BIgoOOgJvpVZQO368Is?=
 =?us-ascii?Q?YRlhZFVh+IGCKTD4t6SFpgaTo3wUodjMYeK02qgLlnxPBAsSuC7gNavk1HZO?=
 =?us-ascii?Q?BA64ZczuzN5+DaFj+XbI6BjuedK2HosY98FzEGO2HnN3D+DtKsVMWgYiwe7k?=
 =?us-ascii?Q?ymFRhaSZqLjL1Jgu0Fsqity/7QLXWcUhDU4vPgGgxTd3VX8hfA++LWlg9oXN?=
 =?us-ascii?Q?ungIJymS1QKZvKx00j5XaGhEOqZ5XimUj7aSHf17NrI1aAXux5PdhjyUP4wi?=
 =?us-ascii?Q?kn6W2BIa/90ZzhtXKVexVbILE2a7j7w99XqZvN1jao5c16Pwdm+AiWPhzqBQ?=
 =?us-ascii?Q?TlF3sdFwOr0E8m95r3LeTFjjjhhlfbIDuONvHhTPm1MLVpCvb+YICLNWXMyU?=
 =?us-ascii?Q?i8qArTmzp8/79cvEoV09YqbWJk9wG52RlZnszd153x+PJA7/yvGPa8773C0O?=
 =?us-ascii?Q?XgGtYByU+x8v2XTiN5OjvTRa9UD7VoH5ljNg/LOZ+YSCZQIHj+KC15xhozbm?=
 =?us-ascii?Q?DeZ6DvrRI+tOV2kZSXA1/XkW80+fScbD5WDuyJv/BvF8/sZtpR72gqGS2z54?=
 =?us-ascii?Q?gu2sSNjk0vIALPm4SZhVV68rnImoo2TQHYpu2plFXMivTW4inf0ivq1j0Udb?=
 =?us-ascii?Q?AnH48rnlQRdZBJhhXbyC+FLzjByx4YZLYj8Upmz10Pt8ooAXCICTdK7RXV86?=
 =?us-ascii?Q?5KRupxFXCu5LpW83e/DPMSJH/1wuumESBDcROiM5ggOd7LMJTm5MJ55J89hZ?=
 =?us-ascii?Q?XU/tidG0MA00MSxfYlOH5yQoDRU8VxAhIGQw1xPtCbFeoKoLdDM9PCKC+lkB?=
 =?us-ascii?Q?MLaTBhiswhGIcq/qJ8ZWYuemtFI0kU8irtN33TkxS3ZV++pFoAgk7cGX1czN?=
 =?us-ascii?Q?jFQ2kkdYRLsWf1BJo7LNlx/m26s0XIrGmp/nORCnKFimxchB5jLO9LIo+Pl3?=
 =?us-ascii?Q?l+Jqzhg2YS3l+N5jvBTIB2yOsnm9jxFvlnwmqrGEDQgHsry9QnV8LuRbhWTQ?=
 =?us-ascii?Q?DFrou37Qdie6XaONPB5Ey1lAOVGhDkGDsfyUr6N3ZQbPnP9xyGKyU9Mc2Xkl?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d886df-245b-496d-dc54-08db29e37fc7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 08:08:48.2270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WgzRhwqbsBD8Rz5U9p4VuPy0bh9+9eDbgX15pZJsA1GcMApmo3EbKZsN+ql6U/tYfyzYNKrDTG4VSc/SihAJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9806
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thank you for your comments, I will update the patch
and I will resubmit as soon as possible.

Regards,
Iulia

