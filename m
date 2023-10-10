Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA19CD8C9D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 14:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjJJOw5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjJJOww (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 10:52:52 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2701E6
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 07:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yf9LjpAjF3w296kfZwsLyUkhAjfVpP6fwhe/BXUeLRK1yzkH+yP7m994UjNNQuOaAsGtgWIhDkNEiYqK0hZUSqBPXmg7ptaMWVZBCLi+dkoLfkWVuMFd5/oKEns80K6xViyiDRrECad1rXMCKtFe4iQBsdVdVUKUR0JGlnWl6XSScm7oAPdZy5sm7ZZY+RQRk+5ovlrfYuPL8D0OTxabYqhEfrRz/+MdSp4BhoabbRvqZJEeDdRSrmqr1AFNi0d+nTXbRxg0r5UcuXFwZXmFxegxC+wc37vf+eC5EErEwhDCQTSpMLPs3EhfqZINwCImlQ6eEi+gzx2CRjKmq2Vj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPGOd0iZaH5amcPJM+xODsa3IVBYjRljQyUNZiA+QJw=;
 b=I/GmACn3iEbDAUAJbleod7aJntWbYx08BOQzhvLHkZO7H+3RwTk26/javJ+wFq1E8t9YhhwTuNOYXA1YOXzdetQGXA9KLK5osFQivxCL+4l5yFqg1aEoMpofXJWgLNKbjzeYp/i/ypboNrAou1FTHpYBZyog9ddMAvRb5b6Q1D3m8oXhzTu3BDKmtIonTev+aOZ1aaIc4bYMwWlfLbDeyOVWR/RXQmQmvP5lVoG+ZUxf3GcWGn4LsD/NeajZlDfBKKbJiUSTu/7mA/vlvntjUFWIMXH0/2HTE6uOtuQ0PTdUGzH9wqgtHjDCnPaYPa0L5AS7BmJPVegYvxpSY5efDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPGOd0iZaH5amcPJM+xODsa3IVBYjRljQyUNZiA+QJw=;
 b=kFG8/KPrVqrkZz86R2RxINMK+MEzw6H1KfLABoxSp/OVYKXdn8T0VI9oDUlZNgLku61G1aA8n4alXMtCnLs6GTbnRZnWGjJ33a50iM2BwqeqSBMpzTmtQKNIHqf+PXsy0PZ4PG3e58lVrW96XroUIr5oMPzddTImlMPuZavhNAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9792.eurprd04.prod.outlook.com (2603:10a6:10:4c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Tue, 10 Oct
 2023 14:52:47 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:52:47 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH v3 0/2] Update transport acquire/release flow BAP bcast source
Date:   Tue, 10 Oct 2023 17:52:40 +0300
Message-Id: <20231010145243.4441-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0026.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::15) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9792:EE_
X-MS-Office365-Filtering-Correlation-Id: da130f11-063a-42a7-a410-08dbc9a0912f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9e1DwxUTao2lpl+6QM/7FnqdBN3NtNHInsBmxW7qRRv3Ch3NnmzfEpzMvNysvIJSW41u9LQiAwV2gbAVMzzLemZJRjrTBk6JRqMKGGNbjrcSsnITDv8/ROXpMnowjN5bsDj75W8fONBiUlzck8z896RNo0rNJzZaYoNzjuR/6rd6j/0f9UY2QVIVRIHTwVacXyK9noa5AzIRV+3XY7syYiXLlsuh+7qf6aiaaJMi9Cgbof4FaG/HXsUujLispE60aYJO8sxIqr+pmQ2pWsRqN98pqeYs4uldyvdYeGLCGOhQ2+8ra2BIJWRAviE8aqCiIA+F03bXa2yEflf4W1oXODtFpyqXJIirEITyyK21YV35qpr+Em2HegozfYPWSodqwPiMAyhGbxk9ccXynWNGcW7UUTbKc4gvx3dmrHWPjCWVCjFMtSibNDpYiveDqkENXkGJyvZRzb9nubSghpRwVspD1T74NjPN48aLSshMVuCags6F3u6Ti69o7A1EjIOGJSBEbbdHpTsMXnsp8T1Ps5sjo5ESZVVQYWJ331Rbh1JOU9yLZ5jmTn6hl5dhbEbH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(4326008)(8676002)(8936002)(6512007)(6506007)(6666004)(6486002)(6916009)(1076003)(316002)(2616005)(4744005)(15650500001)(41300700001)(38100700002)(86362001)(26005)(2906002)(5660300002)(36756003)(83380400001)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jnL2Zw1SnqCSX/Q7CvWgEOzz19L8v6q7efPK76oFV78+Efqr9c6j/EEh/fFX?=
 =?us-ascii?Q?DlUROxTMz/62o1fAU+OOOCMH1zXg/aBnnFEYOwNrjOKBPQpYAUfwnrvegs86?=
 =?us-ascii?Q?Cdp6loXgoJLuiBrRYJbNuxedrv4imthRwQJBsNzwvrwL7lLsEtuFYoDrVKlR?=
 =?us-ascii?Q?rpTgPk4SC3kzrxJFvXu4bpC9NLyOHpeHZq3QRfKFzz/+bQqQ39dnL+m2ss94?=
 =?us-ascii?Q?h+M21EYdSkV+tz80fxXWJ2R5OQ+n+jJES0wOdlNqd5uPYXisAevGwHlxYorH?=
 =?us-ascii?Q?X+rdtImWhEcx3GyqnYBvA9P/Zn2XNEgKSr9sFtpObdAoFWOpQ/aSWMrIxjh3?=
 =?us-ascii?Q?ytfaJymamOnUQOYSztGmQK+6II2vx26/Y+PLATpIaWfbUySlwYhJ3M5MNiRR?=
 =?us-ascii?Q?PN8inNeK5XuUf0h4tl4/TfqC+rnifeehazORQZ2QNv0TvCUkXj6hkoXofX9y?=
 =?us-ascii?Q?GaHMeP6KJJHiw5uyKm//89uK7t83aS1YYDBjP56jy5abSeiQgB/2miLEUPYr?=
 =?us-ascii?Q?2qVyv9Oh+AJBiv5BtvFdkytlQkBtPc0WH/TEb6tGz1SnqAeL3uBbog1NQnIB?=
 =?us-ascii?Q?CKxwyrkIA5ezmTUHYe9N4+7pIB/sSjID6uf4yQ1PjNCSCAhKFE1F68bfTNK0?=
 =?us-ascii?Q?V/aRECgqoLxTjpRZasF9jx2XbKUaZyoJuuQ9RcvmHz5bNGqHPntNx/ta544o?=
 =?us-ascii?Q?FCaKYbLV5P1r0Hnb8zQUfgCEhk3GTETT5fuj6ngxYQqj4aKNq60tANAkUkoh?=
 =?us-ascii?Q?Ym/a59eZW5aeYeHsDM0Cr9v/OOkoeKqP4O3Q1jZE6+nNLZXsqJ4fM/LdA0j1?=
 =?us-ascii?Q?WfCdI8QoWQaF3Vy4doLi7XQ7iIE27cfuP3TLBvFiNY1jNQFS62aVz1t+uroK?=
 =?us-ascii?Q?E+pKuUw9s+FdeyBal1mT7/6B4Mcrgcyw2kFxTbmHlpYVFbatoZ0N6x87SLyR?=
 =?us-ascii?Q?0vAr3GNT2v3usfh5lDAEXS1t6q17MCD8Qfc+5/9wrvGWiD8rvP2gwCGkD9nf?=
 =?us-ascii?Q?7H7NCHrNVNduZ0VsrJ/22wL/9bgw8ie478YGz4O40vKTp5yfV0v5/T8ONlLS?=
 =?us-ascii?Q?d/AOuPm4BLjOekvuNTcE/njBPHjFytkzGvOPgBO1T0IfyX07JzAEApI9p5Sv?=
 =?us-ascii?Q?zRBDaTKOeFl00XWqFLd5MhoHqZjMdGGZHLzGEQUaMgeFcvPI9E/hqNlLuG32?=
 =?us-ascii?Q?Fiakt2ZXFUA1nTfKzTPXNg8ZABfEBtqXI7tmACjPchwY30+cNKwZPPpvF0Jv?=
 =?us-ascii?Q?bfELD74mE6ES92wT13Qc86EGBkuDSWR5GSRKYrLbHR+DVTGek7LNzCM/vZqy?=
 =?us-ascii?Q?6WNqoPg2zFv9rg3bBoCJ47VlTc8KGi7UCjAydR+A+gRZZysdyKiO10+R2pUy?=
 =?us-ascii?Q?p8N1w3r5cOC/pf6zsJLSJXsmEcr+d0EyCycgYxZKA/CkwsbbimKZDo3PxNUj?=
 =?us-ascii?Q?tSFcLmSmis1zcXEmuMdESI7JM1z7+iwA0VsWp6z91h/UqUsBurhol9RKsoVb?=
 =?us-ascii?Q?gFBm3NINrYdN6fMsS2PbBBe1GP48S75aac9olZ8llEghOQANlTG+Er2Q4mTE?=
 =?us-ascii?Q?98Mm7ZWgO8olpBqvo+I16TVAWqhrSG2nEzDruAlOyGmNnfknaNLz+Vy+YeaI?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da130f11-063a-42a7-a410-08dbc9a0912f
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:52:47.1974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6zxZoUkf7w2QEnsLPaVQ70MemcjE1ypQjw2ILz7arpGA5Vz1F63tOXCIqDQXsnQDeQ/RyC04OEruUhzdWga7aNw/dzN81mYzcZZqbJ15ZJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9792
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update transport acquire/release flow for BAP broadcast source to 
fix failure on transport release, and second acquire

Silviu Florian Barbulescu (2):
  transport: Update transport release flow for broadcast source
  bap:Update transport acquire/release flow for bcast source

 profiles/audio/bap.c       | 51 ++++++++++++++++++++++++++----
 profiles/audio/transport.c | 65 ++++++++++++++++++++++----------------
 2 files changed, 82 insertions(+), 34 deletions(-)


base-commit: 7a79ff88fd9576cd9935a8c0bab4906b7c38ea03
-- 
2.39.2

