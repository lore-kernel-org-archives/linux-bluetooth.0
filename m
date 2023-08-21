Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE40EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjHUMBC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjHUMBB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:01:01 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCD4B4
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XtcwHaol9QVzk+CpQ1jmFLy8wZodoYIxFWB3UKp3cpZK7vkCn/br/YWYLGzPzvwkPzZKB7AB0xCV24KpWbAnpgqDw58NFHKLisXPQ1CjbqZ4Hd7C1CIUq4Mlg06B5WEihRTy2EHC6aOFzahm/QvsHb+pOnNwGHNQ1g5WqCrKkPrKLYKX4tA9Eo3GXB4A/eXW68rgXrDnh9JwS4/SbNzGKFSf0FW0vqDikMH+DN/ooBIayQlD77qw69bLh6i/gWjMSLejgL1OmuUBvWkqK3gAnoELrGdOU4ujRlg/ZTdb7dmRuB08VPDn8qN4oc9S7Vt8SiVWr5rSayo5dQaXX2rbJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mARPfhbTjQaJQPTyE3PvznjGtUtB36AEM9FnZ8Gsu4=;
 b=i6766+aqqPTkgYDMNv7nsWRWupfYmg2xtn3W3szRpwzL7jDVIOT74hzSXtnKpo5q8Z1YJV7EfD9UlA1L9NnHzRgH/a7YfkUPVzXdHwmYzMSxFWI2d0+mmBfHd8lyJKJcCbLdQ1Pt+LDcHVvWHpkGKhSfKVgBA6DYo85IwRcA1rM8V8DL/0XYFMh8aoJ/PpPo8uAi2OxuHovSSuFl11f5HVbQniloMI4gseM+W/KdT9Gf33irLGd9i6SfL/vZdQF1csb3Z8IjJLhzD3MaxYYc1vs0EE7e2qwOzvgnZA9HJs7+wN/DGLB73vGqDzjY9oRo3JKqj3cglBzz/U3++QafpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mARPfhbTjQaJQPTyE3PvznjGtUtB36AEM9FnZ8Gsu4=;
 b=WWKWNddHmu1DSs0Hn3qOuhbbmPDyN0/0vuqXVcTwiQCi2/aA36XLVL840c+eMwQTG84xYAz1siQmdOFDXMO+7fqDHxQFHLuZEtmEuu4uZ2rd/flCUXzKD9w5YOMJGJ5NhaNGExChhJnt3OE9iUrSxQ6WONuxa+3E6GdILSBdMw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:00:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 12:00:56 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/2] Add support for handling encrypted BIGs based on BIGInfo reports
Date:   Mon, 21 Aug 2023 15:00:12 +0300
Message-Id: <20230821120014.28654-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0124.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::29) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cee1890-a2f5-431a-32e3-08dba23e4703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v9+YRIgUmjSJ4atpgt9jO4Dl8Tcs18FifkBymFXXudPIVPQkF5SZhbza/w4DvlsQ5gKvk0h7b8NGIDG/KeHmpWX2l8zXOpy3pXuglIHwx8YMJIt6xx2wwwb/w3v1XJtI9qjxz6+LRg6VnsekVH8aSiEYfNsFb4M6s+xerGAeiXg/uw3kVHMCFvrdaXQ388lZHDMM6b7ngRz8ddODikfY1WzGdBD6Q8CrgLUCwnD4EZAETHAqwAt4f8joV7sIfuuYNDFDMdwa8HvO/TnuFDAcUFepm3f14Q3YyzXTZk9QrlzuiDKVmHigKMBYx2eJbpPetVA0xo409tV413DU9vA1GPpOpI3dVynXtSjzidQsp4mYH0ahASUFSAB2O/Y+tCHcN8249NgLqRP/zEryOZgNM/+EJpRiJenWl8jH0+Vm5U0AJjZnAaP2lyqLpvUqN9SCBCTcTE63IcRwwlTorZlIx3T1nClRxy/4zVhGAcXauFcgHIw0Sn33FmEUVy9UKmj06yev3g+Na51T3+lIPG/eT7oJ3MoZyJ0un0BGjCI7UlQ6YXNYjdnlJEh18tTG6l4sQ0GoH0NzfO4FjtDyqXq+NXF7BDo+Fbcrd0JpQEzmu8/spbDGP207MGdfpGzo6hYO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(52116002)(38350700002)(55236004)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dAHZMagGcsRcDLf43T4urOJ1AFyj62y6qMCovEgXnTRTowfLHKCHkaygvcu?=
 =?us-ascii?Q?BzFdqHuWEnfWsCJflXxXQ6YuS3r2lw8jSP7lRn0yA/otbRpEOP0kTfv5OPuy?=
 =?us-ascii?Q?Jubqae0nwP7iSihJ3+PqHDG9zoWXzJeCbvDLMo89Y7fVUCvlFZTznUeUIcZI?=
 =?us-ascii?Q?0o/lswVDYr0MS9R7ANqqGuL2Pevt+yhDoaO/m9uw/frXEvozpvbIM2FXiFcN?=
 =?us-ascii?Q?JfSYWe4DQU+qdhbUtgki7sh9AwssowcnCVGy60Lx05DkjvZZcxS9bBNAsK/a?=
 =?us-ascii?Q?dvIhJY8tw9LCkjWQexI0tGAbxjKDuHYifvU9u6l5rCoD9OZ086rABPhINoCt?=
 =?us-ascii?Q?M/5tCJa98zNHgl+teJKvM2vHfhdxt3BLOHXMdBvzwmrFNs6f4AGwU9qmEgBK?=
 =?us-ascii?Q?wgpel7XFNBuioUZLzRU/ovRrstKX1D9usNJfWLzmxt/D93+pE8Ig4q+RvBEP?=
 =?us-ascii?Q?oZUQN1WIDLu+qNNDOk0UMQYp5tQI6uAWnPWUiF8qeobu8nyU+yUG19YGs1lc?=
 =?us-ascii?Q?bwt07PauSPxNW3/zCeKI10VjC+f84WnWP2zkuicpbdMkf1mNhoPA4T3O0dGy?=
 =?us-ascii?Q?0UdYg09I6v5sI2ENIJI+q/pPOLa5EzSEURZ6upc/G/jQ9zYbaVJbEM45Oi8L?=
 =?us-ascii?Q?xTOfKBGeLQ7Rk5UsC6VTwyRMgiFapYc1xy1XgPdpxVfWTkAGA6kjD8qd7A2L?=
 =?us-ascii?Q?pS1/EHh1Z0qwyQiyPwnPawoU1HlYqqR3XLjpSaMpFva4wKJ2lsPVB5sztb7W?=
 =?us-ascii?Q?C9lcBNz4X90cS0LPMgwSfiHz7yNzJjNJFQln/f+Z8c0uXsdIh4cykjEdGbAE?=
 =?us-ascii?Q?A2BmIJoWCdw0Zc/qeBofLPSfWHJTslKIZ/Hr6KcKZLdp221+9Y5azTfQK/8o?=
 =?us-ascii?Q?b2+ayrFA/jzCvOP7DsfT78lmkLadtjDWAo2gY9ASxpSTt2SdgwElKKg4t79U?=
 =?us-ascii?Q?FxGK/+oI6RCWTAZhXU5wueQyuQ0Sxja03Sqv9rmDT8fc+RNAVSM5ohviG6Tq?=
 =?us-ascii?Q?4gEG6dYeHRLFEM2t3q+n8JOU2Yp0FAgvlhBowBTkbqKPxxXiDl/WIU7lEBLK?=
 =?us-ascii?Q?nhkaDzjqdg1Q1nS3asD7/dlPgN5WaSgU0F4WJnFLK3rOlVBLge9ClUDWL1I5?=
 =?us-ascii?Q?AX+VpChnGInKS2RH3gTH+JmByWrWd5kv1IXyoyLKqSjSBWJMSS2DZb3yxwdY?=
 =?us-ascii?Q?Ianp6MEn2fy99WqxvF12TXmxUVgrvX2MSM7EstZteM4e+YaLTzgHmxMZc/Iy?=
 =?us-ascii?Q?4PKbej+hAM8Cv95iLUwP2XmtDQD+MNI8BHXV02myuWz7Z2kB2mLpTAVvbQRT?=
 =?us-ascii?Q?TuuUP3fXuc8F6I5wkkQRZxSpzE2Y8er4VxePtkU0RdCbeiYYR86YHWfTLRur?=
 =?us-ascii?Q?bPlGgypTbbmRvqktsk9DKtTanJ5PJEbma4qLarlLm37IvwW4ju7EM/cCokc+?=
 =?us-ascii?Q?++uZFiiNUlhfvbufB7gMOljdxJOKoxbp76c+ycZ+7EQD7oBJOQqURZ47v5Iw?=
 =?us-ascii?Q?Xg/w3+x4AXQByZ7azUUYCWU4uGm3eNkYdVTmhXhxHllZHtzCJPRzxgZkv8vf?=
 =?us-ascii?Q?rYHg6ZF93LntwkreqK73EU3IA2P91pP8SyrdhL6M/UDZHv7MZ5RB+EQj088h?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cee1890-a2f5-431a-32e3-08dba23e4703
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:00:56.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pQDabawJ0Mg5ps92wxyEfT5KBU+MpXlze1ncCzBhkrTkI1mX0zF2zUHdIdH4kNYXlQOa15lmECo27rFs1gvHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduces MGMT events for BIGInfo advertising reports, so
that the event can be passed from kernel to userspace.

This patch also adds the sync_handle field to the bt_iso_bcast_qos
structure.

These changes are needed in order to implement the BASS Set Broadcast
Code operation - a BASS Server is required to inspect BIGInfo
advertising reports received from a Broadcast Source, to determine if
the BIG is encrypted or not. The Server is only able to associate a
Broadcast Source with a received BIGInfo report by looking at the
sync_handle field. This is why the sync_handle needs to be available
in the QoS structure, so that it can e retrieved via getsockopt, once
PA sync is established.

Iulia Tanasescu (2):
  Bluetooth: ISO: Add MGMT event for BIGInfo adv report
  Bluetooth: ISO: Pass sync_handle through iso qos

 include/net/bluetooth/bluetooth.h |  1 +
 include/net/bluetooth/hci_core.h  |  4 +++-
 include/net/bluetooth/mgmt.h      | 18 ++++++++++++++++++
 net/bluetooth/hci_conn.c          |  5 ++---
 net/bluetooth/hci_event.c         |  7 ++++++-
 net/bluetooth/iso.c               | 14 +++++---------
 net/bluetooth/mgmt.c              |  8 ++++++++
 7 files changed, 43 insertions(+), 14 deletions(-)


base-commit: f0835e7404b7f6fd825fc1ad7a174253a54234cf
-- 
2.34.1

