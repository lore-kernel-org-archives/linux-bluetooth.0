Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91AA0EE4993
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjHUME3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHUME2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:04:28 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76B390
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9VTLW6aMG+hHD8yXNdx1RPCOcos/PjDRwYdIs/IJlhHBN8woEFUDKnvRzXBedbhultfgXQZ5CnDlPvwOBnnW5BzBBjOGne8VNztyv78Q/1v/jCtsNENyTNJjS7ASm7SzgiumlWiCJTtTpekC2ob8yixw/Wq+CTsnrZPT9HmwG58h5oD2aSHKoSuE5b3IBMO0DTH4ke/mYEca/5AWr70of3zc50OX/+25JUbLS3iBA90DeD2nH5oxr/dtl2SGcAOIAx543mjsi9mnb+dRoNekCtJsaWvGN9YornLexYkyYUwjxhZIatxQLzL75eIcSZLsEJy2/9iVLB42rajdanyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z06okP7WRy+3oKYUVLtgOwLMz22+lL3WEuQxmWOoraU=;
 b=QiAbDsK9V61S/iD6IEk7qqRFTOAowzP4M4QTASn7kcNJH2ollVuq+BaCRsWIb8KTe4lS9s0zarT6KGcy7kA84fg7iKHha/EGUdGt+NvSgctaqeHtl8CKvH8allQ+7Y6VFHv7KkcJAzDSPugqksZgXIMle+hEjLTqVqUWI7SfRoIZI/csOzTGzghZYZoIP+8A35/wyf4+9MsR58XJxu6cFhr/pk6PiJSukJsD3co7Kogk0GMd5ueLoU8Z+gYHNyk4cz2k4ZxS7U4A+9TZu2PFu6p2+k+0XYnSfGNFHwotxacaLz7+nFW9NwAyZ2FmzAG4dHsm+IE9ZDQ7E9tg3rgi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z06okP7WRy+3oKYUVLtgOwLMz22+lL3WEuQxmWOoraU=;
 b=r/Yn0RnLtyBftPr60mFb4OyfcSHOJShyN744rEVIjT0+HXD8qL4lraqvGD8roqDvduw07UxLuyMloXewa0oRvDKMI2DTL5w0lgogFcRY+QeQzlFlIfx4262vP2S/bTuaBTStAi2znJ4tCj9j6AkZCtZueMuLDyJGwq2W02ZZ0W4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9586.eurprd04.prod.outlook.com (2603:10a6:10:31e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 12:04:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 12:04:24 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/4] Add mgmt event for BIGInfo report
Date:   Mon, 21 Aug 2023 15:03:49 +0300
Message-Id: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 153065fe-6e2f-4dbe-bce6-08dba23ec2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kb1SuGdWohi0lvRo29s1EErWm/2viRMlxCjs2X7SFk1MNTc1p+jN6IPvbSJswQBHI1RkiwwR1FN+ookBMylrd9gRGPikmDEr7EMOsFsIXOg2yaZe0qIsKS8x1gPIkqy2mFHvMZQsbpdqRiHj5u6bDhMmtQxLqsHvugRE2nl/XSezJ0hoGQNDmDjEnAxcunV7LDD1d3uHl/jdJmUzQIxLHnCR6/tQVupTvAYMqV4dC95P6YZ8m3lLTC8/gP7tXYq1AQ8jSi2Q/J9YHQTwto/h1ubEI9j5YYRD8kWJ8iTJ/LwR80naQaRCd4VdSVLgWYebE5c5IJK+16pHy7cokXCNrKgqTw+4cykOW0IElecGJyu2cl2CXe3rq0Tn9G8kG7m90SJ/0JzSP1+HBSf3aq/7gTbzRIY3Z/VmbXPNhk+RZ2D5EWYbxHyGkEOljXvqDsCnJNKNDPNn66y+11rT5wnzvAGfdVRAuq218xnhQZlTM/r/foikV3dlG+ahUWRtgWVQZ77qs6MUtfpQR8k1A5W8oQLwiLesuPQeA10GubWnhgJsIfhmMbBHXM86hi0mk79GvBLl4lhvyHdXVnve/7zhKFJ+wPC12R8Gcu+Wg/rQXc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(451199024)(186009)(478600001)(1076003)(6666004)(55236004)(6486002)(6506007)(26005)(52116002)(6512007)(2616005)(4326008)(44832011)(8936002)(83380400001)(5660300002)(8676002)(2906002)(316002)(966005)(41300700001)(66946007)(66556008)(66476007)(6916009)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPeBqmwNtIgAHBLTWHji6RjyRwHIzFRXFkYxo4bU4tUcQF25rgqu5LCmzG4K?=
 =?us-ascii?Q?vkAvKVH/I14tQLSH9dtdi4ME7KhV5TSD2nB03Q82NvFOimLUudJWcTerXYn2?=
 =?us-ascii?Q?5ztcFv4yeK5++nTnSJ4yeLpw/eiLrBzJPO+E1CBZ3T8P46C3ULlKMNlq/qk5?=
 =?us-ascii?Q?HX95C83jYVSoCnI2sbwceoC/mWCnzd1IpzzMtgLIKiY12T+I95P2XzskylAf?=
 =?us-ascii?Q?eAsn+5Osi9M+vhKYNbfk2/b4sVTr+y5r3UqcLmjpERiwd18X6YnfdixlMAOi?=
 =?us-ascii?Q?UNQUBhJIN8zUjLprzbVQdUx8QqV4jxR6PFE8o7/4tLII2ykE65+FNQtjUdwD?=
 =?us-ascii?Q?guf5ai8okpo/vxYlf5LpudJiehmjqgqMgutKI0eqFbhU5UZESBVNYnDNG0N7?=
 =?us-ascii?Q?3gY/e60bhuoCjLVq2RgptySe/QN5dVy8JeKl5t8zUg5FXel2dZ+0b4cBl4RD?=
 =?us-ascii?Q?LeJosBvstg4JL627jo5mbxGT8l+w+5kxmVXfgXuro8Dhk2NsDANE55Ex09jV?=
 =?us-ascii?Q?9OUrP/w2T8IN7QUfW6NI8NfC/KZJ074wsJDxlXqAxrzgkyW0LbYWOgITnrBY?=
 =?us-ascii?Q?7HGdTzTN1JAsMcY2xfYqzSQqiaV1vkyEvUwbBuD+ahsnRsLe9cPBAyO1ydew?=
 =?us-ascii?Q?kLmfJv+EVnsyp1+4/N8wR29+kv9xADHfpF9D9aurJblRA8xWXn/ouFtQz8Oj?=
 =?us-ascii?Q?apm4xd75ojxip4K2QeDNnX0C33bhNKsihinKL3S3gRFMj53oR+NMkcH6zq4W?=
 =?us-ascii?Q?WX3JCNy7tcGTEzjEaxs5cVl0q8O/fNK7YxgrGl/z2DTsbfcGN204DOHbXYJf?=
 =?us-ascii?Q?gDaW6RyaZNBGaa9ReFWdmeBG/sPmZ38GYkN+2XXL+qMLZUzcOK+FdTQnuIbP?=
 =?us-ascii?Q?3mSIaLc/+n+Rv4/Bi8m6HQMQWbiciHiMzIBtrr7Iaf6h2+a0WJp07Aqo4wRd?=
 =?us-ascii?Q?c0qva0X0Jo9QS9UZ/yQrss0cqMVZGp0e3RHZXIZO6mzWa3Q8qsrg8K0y6ERv?=
 =?us-ascii?Q?qRG+sd3XPItU4T0+glNpRAlsHqfZtOkMbIyJJLzU+Vg4/kkkAKAz33r2/6oj?=
 =?us-ascii?Q?4VttRB1YSOpWS8VGW2YlOuo75SNLH+/mFnzIdCl45OWRgdTWLVZs9N1znl97?=
 =?us-ascii?Q?Pq9DCRS+nbQBr4A/OFEm6F9WvEaxkbCZeJDcoJDl+tOTxm79oNQqnHz8iJE3?=
 =?us-ascii?Q?LhqAuF1MiJxEPJX2a0QojfmJaqJCdNw8eJIDikf01fJEULnVAbjnf192CvNK?=
 =?us-ascii?Q?uECVDPlaTGRqaUMOtPYUmgybhZUmwEWCsIcw+efKhR4F+YIclntZ5QYY6eBV?=
 =?us-ascii?Q?J7zza26Mtqwr3K8zKGxMLw54fZKtxZNck7CDhZids/+Uudx4azFgZq6yz/+/?=
 =?us-ascii?Q?HbdjkV6XR5tRCMEytXYvMQBg+gYfALm0YycAeR/MklOF/P9+Ywr0ex089ZR2?=
 =?us-ascii?Q?7lw1lWxLlDKE9yAoPQGbW+M8XpZAnncH3+wDj8flwhyjiDvGkV+1gMh6fyev?=
 =?us-ascii?Q?ze22IS0Du42Mvu5bMNbzg/LvIa77OZs7INOMvCYYKxFHapFfe8UIw9S0AZYv?=
 =?us-ascii?Q?YqXIVJyhTJ1BkUrMj4LxoKy5jIM7Q4T7jcwCO5RIKcTlXKIMiB97WbbAn1qu?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153065fe-6e2f-4dbe-bce6-08dba23ec2cc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:04:24.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGNrwxiUBeWJ7IIGXeAEPeZIxqsFHIiC/HwivllMZRlz/sBeURDDRxGrx05gH/6+90ZkZFW209YzOu+Hm2N34Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9586
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch introduces MGMT events for BIGInfo advertising reports, so
that the event can be passed from kernel to userspace.

This patch also adds the sync_handle field to the bt_iso_bcast_qos
structure.

These changes are needed in order to implement the BASS Set Broadcast
Code operation - a BASS Server is required to inspect BIGInfo advertising
reports received from a Broadcast Source, to determine if the BIG is
encrypted or not. The Server is only able to associate a Broadcast Source
with a received BIGInfo report by looking at the sync_handle field. This
is why the sync_handle needs to be available in the QoS structure, so it
can e retrieved via getsockopt, once PA sync is established.

This patch depends on the kernel updates introduced by
https://patchwork.kernel.org/project/bluetooth/cover/20230821120014.28654-1-iulia.tanasescu@nxp.com/

Iulia Tanasescu (4):
  lib/mgmt: Add mgmt event for BIGInfo report
  monitor: Add decoding support for BIGInfo mgmt event
  monitor: Fix decoding issue for hci BIGInfo report
  lib: Add sync_handle to bcast QoS

 lib/bluetooth.h   |  1 +
 lib/mgmt.h        | 18 ++++++++++++++++++
 monitor/control.c | 25 +++++++++++++++++++++++++
 monitor/packet.c  | 35 ++++++++++++++++++++++++++++++++++-
 4 files changed, 78 insertions(+), 1 deletion(-)


base-commit: 60731cab5891ad2be01f5fcdbf5908aff7df4fd1
-- 
2.34.1

