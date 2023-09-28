Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0CCCE7B0C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 07:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjI1HxP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 03:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjI1HxO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 03:53:14 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600D9B3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 00:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS+oMU4BA1/jrTz6a+k2XAkm2eljsborYcimatXOH4yJxm8KLH7ffjnEcxsCtQSOqtul8SwLz7fC1nLU6GXGXdyKnJscNly+rhD8/aM4kU4f7/mpvyAWv4G6+DlvEXOVLknrk/StP/n8WCabfn1QLkzKda16UwqmvA4n5p45d0zuuO0TPsZ+qQp4fx4196JJKV5fbGTDB0KhkVT02Fx3eYXKsHdUmndOIMkVk3oXGfL1icLc3MxlEmHK4MIBRP/rwqtmXxTRqEkTExYAHiy0cwM3WgpeFOxfaZeTQjxJmWQu4DmikAjgptNOq6mxyApLxrNlZYJgKdYu5NKewGC78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGCq0uZNVAL6cvHEpISFPscV5DqgcKMJIFsRshWOVcw=;
 b=XYlkcLRnGPUdnPHmRNTjAv+jwl/0wXulebWeQhN9e4kWLfGYKZFypYoF1HabwrzBFQ38x/21nHjbUQW2P7IJyN9NzmAjSrMsXxHEUkfyJ8dIZptWu0Rv6ESl2GoLbxFS4B1FY+e1Khwun0GxPzfpwGZSLzV2HUT2sYyPo/H4J2Kd38pMm/qYbCVnv7UNs7qEudAbIP3obx0wTkl50tYPLgs4Vw5gHWacoSQvLqPlTbJ84GbPGxH/qjqVzXBmHaSCAOrILnWv3GlkPI1xoZ29dDYhb0Hd0qpRABtMWMZZCAZgvV46pkx/n0zvOEuxH5sV3p6hvG56HvSvSTNBdUOoqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGCq0uZNVAL6cvHEpISFPscV5DqgcKMJIFsRshWOVcw=;
 b=O0vteaX47W5wY4uIy98a51XV6T5yCBc7/1rWFIuwZXJpcns5SjPv+wIv3CQgPnPOWzemg3Obeh/iOILwGgCI+tbRsiyMopif21DTw5FdfNjhxi91b5K7OYsMKFyDBWzz+8lkcZr6j1VZ/NXuuhxvBUUwrFVIG89GEQqJw4oQW+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 07:53:10 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 07:53:10 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Fix invalid context error
Date:   Thu, 28 Sep 2023 10:52:57 +0300
Message-Id: <20230928075257.3123-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928075257.3123-1-iulia.tanasescu@nxp.com>
References: <20230928075257.3123-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a58bf43-bde6-4522-be7f-08dbbff7f587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YFJI2W/Njsh8vwYWMLzKYMRq+dvW5FWxGG+uvNwIcfZeOxCrb/RfquXV34JFMH/iiDGNzmvHyxAUd9xh2lyU/VNppOhVPbmc9Lv+kUn9b77BRiViAp4Gs+5Du6iLTphe9/eQXWLARYKkG4gbBr2uIe0WrB3H543W7g9QKQLZo6tuK5KGJY4wq+qajUnRoHoXuzvKyTIl6Sjuhq8DJxhir6cJt52DqN7zuyryRD6NOjO/4GPIQJf9QBvcXc0xhrD3R4iLabA9wOeNsByKUyhqrVL8YFJ2qcy+InoMq2LaDZkQG6JjJXVwYDvlp4zio2Gwb71PZT5AIDSmLocWq4imf4CTL8GLOQagt9bS2XWKnHaMakV3tm2nv71TfSUYytSCxxdXgFzqWPYaHf6tdTyeARrotmdUKXDJatkgvs+M8VEeXIEvs/StOxHx7eT6cz9NvEOqngJkKlgtTBY/ac05JXH2cAltjUEH3Kj2EXLHDSI5CTppyi07968VHe/Krucfg5Y5eem/vHcWLnRX3u8x+ETFOxtVvo9YqTeNRZXjCkr0ejdeehgVShAZk7t+X/3B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(6512007)(6486002)(6506007)(6666004)(478600001)(83380400001)(2616005)(2906002)(316002)(6916009)(1076003)(66556008)(66476007)(66946007)(8936002)(41300700001)(8676002)(5660300002)(44832011)(4326008)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVH+GCHIhJSkyVbBXA/jqEOXpB5OsiVST9IjdM5x8uQmo9hqkotR2SL2Fw0S?=
 =?us-ascii?Q?DXxxE/SUAcmZVhtoMMenWfVQUQqkQv5UYJNiqoMKxyPck8cYBnT6REksZt0w?=
 =?us-ascii?Q?vZJwKUOuVhTdvxLVYGwOL4pO72p/Tujdl1a/1NbgNA8uTNLcKWm2I6z4vYqr?=
 =?us-ascii?Q?XnXXnYzUrE8AEHspaaIvHhF8PEFhwPLJCTExJPV/c6pWj3YywLZA+rdPIZtA?=
 =?us-ascii?Q?7R1IhPO8YvjRpcV5/BJYLDO+Ajd/zJH/rY3jVHZfCb9sYEeX62B7RmCxrqgA?=
 =?us-ascii?Q?yPoHyiHqdXyIg3XElBcT8gLDA1vb86xk7k7RVOg1z5XS6++c2utlWiTxt14E?=
 =?us-ascii?Q?NfQQSlspWi4H1EtRSJ5nGo1u8GkmZC1H1O3iiHKVGu/D2JMaeFkqoeNVIvOt?=
 =?us-ascii?Q?dN727X0GvQU1dWMXrJ4nClEez2/g+vhjR5fM3KNe+V3Uy6DrVVjwwxRmVbG/?=
 =?us-ascii?Q?qywim+qNxR5BBA1ds9ecqiIoECX0QUkC22CuvpljlOwwr6QgEm+YS/4WA+uh?=
 =?us-ascii?Q?7h4C7dILM20iDv7h0QpCti0pjmbkZWb9PPgKhAWZ6d7jWO2Mv3TaFVlVMfRb?=
 =?us-ascii?Q?YLy3rSy4ZpzJXIYR2SR38Fe8zI2fa/lxzHFkP+QgETzFtm6g6FnP7YRdsp4l?=
 =?us-ascii?Q?79VIgvzI0z33FCfSok3WqnegMUpFoJRHKsjdr7YZsLUB4yWMjVvYXQvekrZB?=
 =?us-ascii?Q?xcvoo4Ly0YbSGxyO8+5cqXyPLPW28O8518UneStSDS5xG9prHewbGrfbwOUu?=
 =?us-ascii?Q?OqBa8874bh3PwZ50XDhnIAvdBXxiLXoVDrvCSIrJagGt8vyS9fAJleEG2NEE?=
 =?us-ascii?Q?jsP8JLWhMlXoS8nMkAIVOB9N4SoVfaaXWZtQyXp1Z7iBuzWnaptcdQxaAcQn?=
 =?us-ascii?Q?8Iw3BGa9SpFO/2IJ2BZl2wcRrQ9i/2K6E+By6ftv2x5w6ltnE6evC+wYork6?=
 =?us-ascii?Q?UrsdDOLH7VxbRNm1d94Zyiwt1m6YRCrF5Kgx2jDNicSHaIkdcgFTyxSR09Of?=
 =?us-ascii?Q?PLtTjoUDiSajwukY57xazYQSZbeyCKNaFqTjeh3v8wcv0Vz0/0aDkYGcMGR0?=
 =?us-ascii?Q?E9OYOnEI4c0wze7elqSOPQCyCYRiUdRj9kQ5OGYQRVpe1c+RYTa1bmlYjtIl?=
 =?us-ascii?Q?WWmViGjxdubhsMyc0EBvwq7yce+2AIi/0MbJxNkWV/cvr+2faY5BS7GBmvTU?=
 =?us-ascii?Q?Zyda9n8vpwKwZRpJTGIpa/fgETOMzhob4qfs0EPKjUS89efp324b/PtGSVQP?=
 =?us-ascii?Q?R/28uLD6EO51YrZybUR3RyKJJVsC5ZkyqQbv2m5ciuum/CzPa//9Rp9jDaqj?=
 =?us-ascii?Q?z/YqwawoYw7y7aJU48VpJ/G/aOdWOSG+cZVC/Ml+I+KhxH5Y2ea6bvP3NOwx?=
 =?us-ascii?Q?RKN91mgjgrc5LTPWi3031R1RgXcUkequJ1lDG0Z2iE9iqaSXxad2JE8MDrPr?=
 =?us-ascii?Q?zI6LMjqEn0lO/7qlquoRxMNUccZOqaLU5HD/9DYD8Cps3YIibYN20yr2hNBJ?=
 =?us-ascii?Q?C5WmPw1wURRoZyAUHQmB7nwZqrP+nm8hgTP6x67yTNZZQfSE3HsJqA/ZEt8Z?=
 =?us-ascii?Q?6Emi6ZiPZDTE8xbaeMTYiAjUcz83EV2ypsDbxaSJadPHj64TjjAhOmG2kNMa?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a58bf43-bde6-4522-be7f-08dbbff7f587
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 07:53:10.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhl6Sr3DXRh7xgVm1rBk+HAP1MHrgxBjvl0fpYnWTK/bePtDyu04pV+0vw74B4+bGjhTXqKSmrjNmpG6onjnqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This moves the hci_le_terminate_big_sync call from rx_work
to cmd_sync_work, to avoid calling sleeping function from
an invalid context.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_event.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d242f956dea8..89ba3e5a9c0e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7020,6 +7020,14 @@ static void hci_le_cis_req_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
+static int hci_iso_term_big_sync(struct hci_dev *hdev, void *data)
+{
+	u8 handle = PTR_UINT(data);
+
+	return hci_le_terminate_big_sync(hdev, handle,
+					 HCI_ERROR_LOCAL_HOST_TERM);
+}
+
 static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 					   struct sk_buff *skb)
 {
@@ -7064,16 +7072,17 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 		rcu_read_lock();
 	}
 
+	rcu_read_unlock();
+
 	if (!ev->status && !i)
 		/* If no BISes have been connected for the BIG,
 		 * terminate. This is in case all bound connections
 		 * have been closed before the BIG creation
 		 * has completed.
 		 */
-		hci_le_terminate_big_sync(hdev, ev->handle,
-					  HCI_ERROR_LOCAL_HOST_TERM);
+		hci_cmd_sync_queue(hdev, hci_iso_term_big_sync,
+				   UINT_PTR(ev->handle), NULL);
 
-	rcu_read_unlock();
 	hci_dev_unlock(hdev);
 }
 
-- 
2.39.2

