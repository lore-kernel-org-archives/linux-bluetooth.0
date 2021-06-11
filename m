Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D60AC48BE0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139826109E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Jun 2021 12:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhFKMcd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Jun 2021 08:32:33 -0400
Received: from mail-db8eur05on2125.outbound.protection.outlook.com ([40.107.20.125]:39104
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230188AbhFKMcc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Jun 2021 08:32:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOBdarOo+JgKlOehF9BphH9NBgQZcxfKuxgMkGF81kTxzNtNtRZnky01+cOWkCVTZpjvYY07T26YM5NDTLJ1hKpR+dbiLYBg+j89UqLdUtPghvaKwc5FbTPZCcmrEdZHJsF0uwsww4R+XUIaqpf7XbALo7S/4POJSXZV9U5K1H9AgsWXrPcMHsViGTHDghchzDAKgrlVyGox4Ti1DEjwSuTpj0I30OVim7n/2O+KCowCkHA/tndtYFFG8wmMnEDJPSR9CymnMESUQNUKysnhsXLxbW8eIrGrz6LAsHMvtjO8qmIf4dlEyGqLmWWe5oegRigUWe48xhn+CXmR+urQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mukUpJsDNgS53W2e4HylVJmDOIvJQylULoqCR5+uAB4=;
 b=lugLUZIVq/799wRLLJBxY9/GqJ7M6GqpKT9J7+ydzK5fFY9Ezx9NI9r+2egwH4GzwowUCE+r05yC+12lekMFynoY/nvFWXIh2TFm+N/4foql5EwuDxN8VPpRkUokAtxKqVXM57Lbvy2JIwKpYDFI9I5LT0rVKtndooBEyAU6rYL92ZpVl1D0BjxXQRFbGRdzQnHTSLcBgVMEQrMI8LLWOzW1xLYDIJcBEtUJM7NdtKIpVpDwiP6/j8LWxzDY27HKrLqiH78wIwADK3Z7t2ZwG43X5KqRyYIqEKoXQht1jDy0WCLVnRLy1YkzmuYkG7EGGWb8wAdq6gHqjLclR1r76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mukUpJsDNgS53W2e4HylVJmDOIvJQylULoqCR5+uAB4=;
 b=W2GkTmMHIkXqOWobHSWpe5IgsjjZmo7HvVZQMoyyK4FymbqdtIn1zE6fwu2EVrm1IPW+5nOBJ6J8cDc5w4Pxx/JOhbkgCVhmuU/2XvOUcwEMvr8l7uXVeJ0f8U+zI0U1WSTQSaUBYE/VCJrVMje05ghh5pFZG/sDDXJvwMwt41w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=surban.net;
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:30c::17)
 by AM9P189MB1714.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:308::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Fri, 11 Jun
 2021 12:30:33 +0000
Received: from AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf]) by AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 ([fe80::d9c0:8560:388:4ebf%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 12:30:33 +0000
From:   Sebastian Urban <surban@surban.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sebastian Urban <surban@surban.net>
Subject: [PATCH BlueZ] gatt-client: Check length of notify multiple op
Date:   Fri, 11 Jun 2021 14:30:21 +0200
Message-Id: <20210611123021.21211-1-surban@surban.net>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [24.134.128.129]
X-ClientProxiedBy: ZR0P278CA0116.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::13) To AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:30c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dino.localdomain (24.134.128.129) by ZR0P278CA0116.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 12:30:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca12ece0-f167-446c-8be9-08d92cd4b4df
X-MS-TrafficTypeDiagnostic: AM9P189MB1714:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P189MB17144BE8588C99D870AE7DF5AB349@AM9P189MB1714.EURP189.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRHO1hM5TPA7UOJtJgMMjqJjpkq0GVZk5PIQZ0msLUhKdaR/QhXoyU4pwVTCles5jugSQGcG1ttPCVmhPbV8fwSnZq8EjnV3VDxkYiBGm452vc724QmJiPrxhkLyUkVLap4wUHxeJT5Z/JyUh8I8LzUjSsZNPonlUBuNDWvzuMHGl9PLS8Xubnu+1uWZQMLEuPnYb346xoZbsXh1g/vaLO8CfzGzThPpnDpIFk9SQyf9KAuLCz8PLaCRGboqIHiVCdlYihtkITLu14XiNOByXmnUqESENIvL02KZjX/1Fs0IW18t7cq82Y0gbYRVXpGylL+oROqv5b/my+V0ytXY0NQVuVjoqxI+HSgOU4XcSxwXfCUlFQbim4PgcNIXCV+e4Xw/PV8NAnTXhuv81yl/EUVRPEXo9BM16Ad7Lf+Iz8vbwhssE3DyTLU8vPNJb8suioCWI+Qb5BZjWw1+OLJYE2/kh2KMlvZuLV9DGW2cFzXzoNz5ZHRdfMg6/ATLMf4Dzg6DwL+MNSgNiQzGPSNaNo+9QcwJNIMcYQeQmMxLQLlXjC2Wj9hKptqaEwRklqsfMeGpqokmxlplKqSc9fS6wgNn1+sG4eO0pjSUryoogrovAtfRzZVDVn3yJwaOOF3UkYgzzTMOtDkqD4898yLYYcOdO+ZBJmf7UN53xWA+b1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P189MB1730.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39830400003)(346002)(366004)(376002)(6486002)(66476007)(66556008)(83380400001)(66946007)(4744005)(478600001)(186003)(956004)(316002)(38350700002)(16526019)(6506007)(5660300002)(26005)(2616005)(4326008)(38100700002)(52116002)(86362001)(8936002)(6512007)(2906002)(6666004)(6916009)(107886003)(1076003)(8676002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m+VivaJi6UZjBekMdc8Y3txzKUkGvB6RC2jhhLAs3eNRjYTCoSYNEofKvPcP?=
 =?us-ascii?Q?pQ8hGWrvUpJKqM/HwdLd4BXWGcoF5CcgrIgAXwVkzJRCKplrm4Eff+XRhnAJ?=
 =?us-ascii?Q?KWvMEFbthAsJZa0SLZfpLliSZP1GjfzC3NETL280mDNXxnHozu8ryGh8314K?=
 =?us-ascii?Q?D9f4VVMzsUQ6k7Ih4YPrBvuP8KpKBzcDoKUg3wWIKsWA5xeAGIopNJUZQev8?=
 =?us-ascii?Q?QoFZwBZLjUAMK+XPjwnfRZavrgHhTd2+0VSULvhKo84Rv3EE4HQgMJAhEgA/?=
 =?us-ascii?Q?Wpm6XWAocsqtvD3OoQuw6KNo6A/BOxQ8qx4bHw0q/GOF+SaEru4lAaetQloy?=
 =?us-ascii?Q?GzrjSUwvqCpq61+CVucoU5f6IGr0iVNN+MNOwzPKQAoIK4WaKqexdmNZj0lr?=
 =?us-ascii?Q?Thk8ZkuXfZy5q5JBC9tm+v7O9xjPIb9JLDJfbpMBfM8Ezvy4bvEjf1HZpryH?=
 =?us-ascii?Q?ANwyfhWNskcAy+KWgbr/T96cMVHpnSPXeRwvOawvHaHhJI0KwrlpY/7RhlQi?=
 =?us-ascii?Q?wvbZNKifMtD5KzWIJTZlWp2JHu+ZrBPsLZi8xX0DWnJJQXQW96CY0+RSj0wC?=
 =?us-ascii?Q?Q6MkCqygzlCtJaCe77KvfXGPBRGpE/3RgT6WL9fTXGXXevlTdb7Jsqii8xfF?=
 =?us-ascii?Q?2H2yR/wlDzAqznHwX3QysAmM5Hkdip8/iCUXkmZ0R/Ody7ueZVpTgHqCpVhw?=
 =?us-ascii?Q?ungcSCE7BlXEliu+jwoIh6KsZUxA0+bAA2yxbhvWiy/RpaY3yTQfWxDId6sq?=
 =?us-ascii?Q?jqQw9SlRu35CrAjLVS1A0ISvJ6oKdHHP4X/TgSkHXqU8/qybHP+bwnVGRSEm?=
 =?us-ascii?Q?k38dJo/6/a2rDxre4yD20UmI8UvElc6Sd50Vq58Sv7E+Fy8dJ7J7/BLdDNwu?=
 =?us-ascii?Q?/OMkwerqEDE6NqeJ3PKT/wGfpuiOo8ybjTtMTpFG9FtS/t1TW4KxfJFIk/pD?=
 =?us-ascii?Q?IjWy73nd4ffWtYjDU59I5xP3xxe0cPFOWAAigAWPHy4Y8QuxxdfS/+k/Xwwq?=
 =?us-ascii?Q?gfuITVOTYfngHG1Cqm5Pw2jGfP0+mnnLSRQxgbn8IBKttyp7/E74uDOGo4RE?=
 =?us-ascii?Q?4FVD9vjAfsPaRg250UtScP0DzgV6WKNszrokYK3FDZ+qo9AYf9z4VeZC0lr/?=
 =?us-ascii?Q?vAHPWsnaaYGaMyJ/jnfr1yF6BLez809Qy/fUqojEgCRSYUT1ObAmL83TQNAv?=
 =?us-ascii?Q?Wn3u9PcsOnw97u53Yu/KseHLVUo15fxqYDyCuCEQE+GVc6bPeHsGCP8JBlqU?=
 =?us-ascii?Q?aP61qMGajmHzCtD/EyOczzZpIzssWDpi1y+4grPbIlAlBok7ODOsAWJl+tNX?=
 =?us-ascii?Q?bserVxJHf9HCSueGgfa38IRE?=
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ca12ece0-f167-446c-8be9-08d92cd4b4df
X-MS-Exchange-CrossTenant-AuthSource: AM9P189MB1730.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 12:30:33.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgPxi1nTSFQpi6rqAqkGDFr5jB0zWntMZMjgtfREkuZxbenkkzEml+JmSe6YxUC7GAyz5MmK50ABH7O1gYi5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P189MB1714
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Check that specfied length of value in received data does not exceed
length of PDU. Otherwise data may be read from beyond the end of the
buffer.
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 9511ea8ca..094922486 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2173,6 +2173,9 @@ static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
 			length -= 2;
 			pdu += 2;
 
+			if (data.len > length)
+				data.len = length;
+
 			data.data = pdu;
 
 			queue_foreach(client->notify_list, notify_handler,
-- 
2.25.1

