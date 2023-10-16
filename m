Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6483C41513
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbjJPPqB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjJPPp7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:45:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBE7FA
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow8TqRzlSucs7F91Dpcuv+5R8lMfc6MRwTQL0Bv0imfIpCB0f9CWgUY0Yv2mcuXtH13iMpzQqtC1Qc9DkOXZnSJyaPS1IXj9Dh1xRSWHEDf/8/6jAEbs+nlpmNz8VbOsaJfSC6Wc7BJ01x0lh/+9QyuaWsOjCReURm86p4a35uM+orVgrCx5rK9kcAN7sLigfF5ZDX0iSquCU3CKHNWrygc4h2jUYz6AmkFRWl0M8ZNfci2ZA+GKX3fFuCVmB6pP4wJAhCrygyn/lqnmZ+a7XNG8mpNwO68IcV09GbKH429IQbJBDsgfmG+pmj5AYLEnmvBG3EzWfmtuWFZC1CwCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d8IYRDwqCY7iYHrXgeCZAszqMHEskuFHfh+q8Cg7LQ=;
 b=PsHMBgloW8EwAScGwNHo2qMb8DMDP8IleLEkfEa8oPhiKSOPebr0xfM/P+NttLu9Gtso+pauOilm6QfkX5oNvvqSL3t/gLzkrL4SwLGBZiw4uIM0BJCMC/dpobnKXoaTGVu+qOfazPh1LFJox3LT6of7xviyKmNfYJ7unmWUZfbsyCsubeOSQny96THKQdQvTA/GhQWGz1u3DpHtY39PsCtQRd1NcgGMTZKEGBdphh6RBtaFz1ZdZBkq6veoSYthATtRpCcHWtvc+T8wgRVgLQZXdSHaU8Bz88sccPoAJK1Qq4QBTG2S09Gg5mxQd02YL93mI+KV6oLpo4sSRNLUcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d8IYRDwqCY7iYHrXgeCZAszqMHEskuFHfh+q8Cg7LQ=;
 b=ELzEPZ1L2q5/qsMB7XWIO+CXxrlSTWR+yUWL3Rkod8wPf4vs9n5cRB50GQvQBN61KeiqlM4vveSMS/5aVcFaaAI/lX0F/cl/FBwjK6f4ySW/CjQAqKjCvCRq8qIBBAHffB0cZ7GCE0QIPLJOQzj0p2OQHCx9jnK36+L7w4hBrsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:45:54 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:45:54 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Allow binding a PA sync socket
Date:   Mon, 16 Oct 2023 18:45:44 +0300
Message-Id: <20231016154545.2883-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d437b5-181f-4437-03b1-08dbce5efb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n53C/53z+v/EQfsdldYX6cQdQzgkmWROEcm+WE6nWvVt6FtPY33G6tonaprKFBirOca17LxXdoJWQZtPb2xAkdqHV+bDw6rojt6TJXIogTSbxnrF69FkkcZu3xLuRduJyoQKTK5V2gf0zpG2BSYWgYbNggW++aITOM/dc3MXkS+mGgX6xQMwTPf+mOQdgwPD39SR01T1eWxRLrKTI58Snt34OVZndeEEnmPe1XkJSHJzrKkaB372P6iDMxUYJR16RPvAvBDynq2Qp+aggjisN4/nhzuaV0LiajHENEkTFmHEnfpWThbdlCnIbU7jcgQ26QZjoh4joEgvOCkPfRzxGYuZoUdxFQ+u3dvCX952yRfZeM8d868y14FDEO0W1yjgHw5TaaSm4Ij2Qn1uyp0Mcoab6L0Ry/icyfXE+PS942occ7qt+ozeIp6/2P9kAXdI3dIgxbTRrK3ecTVQFpZTFRXyxXFp7sA4VTER6ZRKYk5qsx2gWk5L73vn7X1fmZaeJb3V07tV6uFAjsL7x2s8ifl6M9q5Oi3IaMTFIMMYb4No7Ef4tsXz4+HS0BoeL5jl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(66946007)(66556008)(6916009)(316002)(66476007)(86362001)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(4744005)(41300700001)(6512007)(6666004)(6506007)(4326008)(2616005)(26005)(1076003)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pV+R5so5uepanwa2m32LX7aOUAtgU3v7dGXAbbfzzN4XdGe3QNcdGc04QXDw?=
 =?us-ascii?Q?iz65P6nAoD/l4ylFld/8kKbmAucLGTYGfqKdMjbMWHgCjvdAWfmjMonDqN9J?=
 =?us-ascii?Q?78Fpafuprf6F947g6UwCCWL9eVDgUlRG2sjztYtax885nzB5ZgPdF79xuutt?=
 =?us-ascii?Q?j4upoH+LnqEco24Pb/M4E9qipTxTD/gDXaMAe09RjDVaN2TYj4O0U9HbSP2l?=
 =?us-ascii?Q?A1QiZePK6IHSaHKPKj0bQVUDLy8nRHbWX3NpMqKToyqDVUgIeaoIPvHp36VH?=
 =?us-ascii?Q?hMU+IyG4XGVo4sN6xnN7aIO+HfozA4F2HAZa235dHBjyFOdjYcTjIdLcLP8q?=
 =?us-ascii?Q?jQoRQU6Xqbo44PQnCm7bi8HRULwHOx3v/2GDGSrFSTgRMcx74qZeGbChuAtY?=
 =?us-ascii?Q?/wViMA9wLxsEXMHcSrbD5BoCxeLyebWII6xTFhN0yMUE6HqhiSfI63qeUWI/?=
 =?us-ascii?Q?SIHW7Dgk/ELO4elLcpLD64EA2g/MhIVCCEz6qS8KMWfxyKf6Kmk0kXD9DeSi?=
 =?us-ascii?Q?QeKxWx/v6VxKtc4/FIvKbs0QubzuGLzb/PNzja7EnjUYVj1DJAWTiiZ/81Sg?=
 =?us-ascii?Q?hikmAhmfk0XW5/UolD5lnML/md4bOj6tSsugXUfJQeOMXfmNjDhfS37Uvcz7?=
 =?us-ascii?Q?KPGrQ2FFr+8XCTk8k7gH6fRECJVloIMaGsJzu9hWb+NTAkFBsVmQQGOh/irL?=
 =?us-ascii?Q?CfgrKkCyvweVLYTc5HaNjAcQuZZhWff+ldBMfDfLFL6fj4lsHoBSK8yNz2T6?=
 =?us-ascii?Q?NoNWUbMjs2BA6uVIYWg7EZ3yPvwLA4IWpW8eVbhwhQ3wd0UjwR9+CNrY8z78?=
 =?us-ascii?Q?irOs6kTucL7NINqZM1j2+Fs8N8I45YKxc056WEvHuHcYaRuokIDzBSoJt9uz?=
 =?us-ascii?Q?c5OYxJl5acMT5LvUgv49rbGXRo9jJRQ9AjatcouqlAnVgR5OE79jMJcXmLI9?=
 =?us-ascii?Q?fzEGsdvvbcnPl05Omuk7Xmp3HjzQ6R7vATwRaMf1EQFJ+bzz9QQ0zh4B88ug?=
 =?us-ascii?Q?mHfbeHWKX7hjCoR+4qX2w3t8Ga/NEj/i/r7t6kR8U+S3kXv+FNsfKEPiLJNp?=
 =?us-ascii?Q?vnHOInn57SNJ1EFcJ1C+3InVASxhilA+L3vGjpHFpjPQ4ZzU+5jRuLKI1X0E?=
 =?us-ascii?Q?GshvNqyWrAAJrhCKdCQDyHb0LUBLnUiDZNGlK4ysaf5hCZF75hgzTWELYWZR?=
 =?us-ascii?Q?REzHNRAOpSfXv/Q83hJVKQvVI8ZJwESKfL11Eu88rr4pnN6lvvpZzZK6lWbI?=
 =?us-ascii?Q?CL6Nl38Z4wZJvBAq/prV/JEzzJEFwZFUV0JlDlv5/olI3Lu2ePHKu22FRtgd?=
 =?us-ascii?Q?VLnoVlJnVP6SrphqXnmGO/MneJGUSsVk98yXuezO5n0tNGEWOMYH5L/D8lSN?=
 =?us-ascii?Q?Mpgs8EM9hrsb1WA07C7FfNg2OYau8kEeX41Qa8tvd7nfRAKoSm5BZsz3wszz?=
 =?us-ascii?Q?a/XoNGtMlgsPlfEQeE8yfQSMEBEmRyjtW7xR9itiKehodRiCv4P6T4BD2Dtj?=
 =?us-ascii?Q?d7juD98cPiQMUO3I+L47TJdofNykr7LKpqvNLTI10G0GOfH64q4zTWcux7gV?=
 =?us-ascii?Q?qjpFxyfsquktUStbiSzV5o9JqLw+HjqxLYUeWSgqw6YLzYW7jvRfjevUgX28?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d437b5-181f-4437-03b1-08dbce5efb50
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:45:54.3214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3wzKQuUKcsHFT2XJ5/koCWDDA4I/97oh6q5gLXyi8z0QPogvGz/7KmJLIMBoUe8ue987sLtSd/JnqZO6ekmHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

A Broadcast Sink has no way to know how many BISes are available for
sync or their indexes, before establishing PA sync and reading the base
struct.

PA sync is established by calling listen with DEFER_SETUP and accepting
a PA sync socket.

This patch makes it possible to bind a PA sync socket to a number of
BISes before issuing the BIG Create Sync command.

Iulia Tanasescu (1):
  Bluetooth: ISO: Allow binding a PA sync socket

 net/bluetooth/iso.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)


base-commit: 8fa4c368ba691e6d92bc7a71279ed4ce5f1a6a1d
-- 
2.39.2

