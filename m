Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AE2EE49AA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHUMBD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjHUMBC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:01:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D29C7
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTsDsM4UFK/ahIRlDgOieCqJ/LBh5BcHk+jsJGhaijuWn2zRFI94H2sv00dkkPCSoUND3fo9K0T+2ly8ayPdjwyXXSeiRX6M58SS4PgWY2UHHerD1NsRmL/z4v6nBFn05C/yM0URG0LYrvglzviQ2voLyjW+/kHgJANJv99ig0TuKZSsb0YNeas85YsVqDbdBAfcZWmc2Z8Q93sCw9dbFzkJ+1FWbuGzy1CVlnnfLg4KQhioZpj2p66u/nxWSQNT9mLJrBDotFfiRly4ROqHVuyJp4pnMRs5c679trCxbJh7ZdawaC2vb+YFwlVH4UicVKlJ+7Jhhzin4ul5+DpNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3rMSqVvJS+dU5rAXtWWY/+V9j1dhE1y7FlyUlh0okA=;
 b=OE8LNQws9sGkyKzXTYn2lsbTewzscezkXvdnEQeDvzBS/Vezlf5G4Kv15LcQN4EnB3x1+okaD+ISaBkfpHxbKEfEOHfr2ByU8TshFI7VjlRZ3rXUghkZZQnXE5Q29C8t9wAdbngGmWmdqbOUhsxQ0IVai/66nKZM95EW8NGQTUP8o+MZDbYDAo87RgUK89MSrus9lvftMIeGybniRHrkZHsdHZUPCtNIHePxy6oYNRnH8X8LFvaBknvCVkTbcSpAGGEaUUSUMU2L7eY6k88kO5eO8olTk9YGjdEaUDiVR08dset5II+lERCEXm4lodeK1Px/67hgIcDxCR+z7mmcDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3rMSqVvJS+dU5rAXtWWY/+V9j1dhE1y7FlyUlh0okA=;
 b=RojizRpzRjl7jXWSM9n5TMeT070JeqtBM6VnrLdThe6YmZhahS9ZzpctWFJUs6oSGGLAqzGNzwz60WdxYHsPNLmUQmzgUbvrAbWLT6QHFjc2Tygs7pU6ApX541rOgurEvliT7bkDz+4lCYVCkXh4ojcwPI84K7n5WIRufYpsmzo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 12:00:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 12:00:59 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/2] Bluetooth: ISO: Add MGMT event for BIGInfo adv report
Date:   Mon, 21 Aug 2023 15:00:13 +0300
Message-Id: <20230821120014.28654-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821120014.28654-1-iulia.tanasescu@nxp.com>
References: <20230821120014.28654-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0124.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::29) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 908537ad-b320-45e5-8458-08dba23e488c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRiouIMgOmWqdLpJWT8CzGHS9UKHFWshZ3TERYKpBW/0YkOS3IVWmBeOixDgHmVaIs7nvee4vt6w1GXu71QIRgUpThOzi+myaUvinTO/ymJ+wQMhEVb6+4lWFVLzvi53tw4hlsRdD9uUm1f67bevU8H0AAiQy8ZXOGDq9n0WIHIR0YXFF3mHwd5dx94UMtg5ARmvJ6kXBrRtFdmXCWwOxmV8zgbhtlPdZHbHSP1iRp/W+Iqd5bYN2UJ0raUES5MPRFOToQ2n0nxVCBa1jFmb9K9m/XlLnEsfjl77+KPBOHSpmwzVv5XtojrJjqKhcyOcY2emRuqTbsXXwt3tdxdvb+3PVLiN8Mti+PgDa4M27awnGMw4kg1hYz/F3zIZrZ3uQhIp1GIAAlF+TQIHUvcq+HxKXYLS0L4Wo2lICB43F3ZWCd3o3nQ0kh1060Asl9LZwZRMS2H10lWc4Xk7X0OzajLK36cxZh2E1kPJlLrXMMKpnoqp7yeFvYDUJ1wfysRfao9UNF5JmWo9876bUPSUD6YnZzDnCZfuj/1ueJPny/fXjcitnGXF7qAQAIhKkIPgnmygVdnJK2cJhH1i/V+PhABuIg/O6ZlnWv3WHme0JA8zeWmL6LDbIsoMOfGpOGvz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(52116002)(38350700002)(55236004)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pr7Mtz6NTugQbLusbHT/DLRK9YHOnWFmzK4PnoRzv49/uUrkAxlbvSJUK45u?=
 =?us-ascii?Q?1Yz8vVbk82RKCynksYlVhQ9mI/z+Bvuv/UC/FGSGpFLpmgO8LUuyJgu9W4fg?=
 =?us-ascii?Q?+HXO9cjOZZ82m2Ww7/OwyjCl+otsaw7zRwjDna9Kklv0yAsieMQ7fJN+Je0o?=
 =?us-ascii?Q?cW865qZ0GQFASKhySXOWS4bbNxTDJ0rsxA2rATtf/8m21XMJ04QdIY0i4Ok5?=
 =?us-ascii?Q?15ZOu61sHJMgd2oFzuZDdGPAr6u9+K8MdaoZtgQMDwJ13ylHEQvEvUz7u8al?=
 =?us-ascii?Q?yfvXJdKo1+vmXpcxrUiWoKQeeqtgdgKcnYmVCqaLvqNWcus4rMiFEoVk4KnB?=
 =?us-ascii?Q?CuxH91Cbbai3VcC/HlFbCs2Z2vfL4va94EX3NnuPJTh+1xXYoYiRlyacWnQT?=
 =?us-ascii?Q?ywLmW8jIi6rJvRYYq42evbtbKXMKwSWvtF9Z1f+tmWNgdsDq7OFA+rpr14IY?=
 =?us-ascii?Q?+IFNOHSwFalSXLuTIDim18MTZXsCRT25+P8DfuNuD698pgvrtqPHmln8uvGE?=
 =?us-ascii?Q?g+U92LIVBGss8m5vsQYKijuNBN8nHu+2Yjf+08vjl3m7887RBd/O5NIoqd14?=
 =?us-ascii?Q?PnsMJkojG4Zpl7/0/Sqe4rjMEdajG1186Lsqys7vkR5Bhnt1E9plUPI5FzxS?=
 =?us-ascii?Q?QJSuIdg83QtaRao4Qt5nY1aIliu8NaDW2ZWpFX7vVhyfjizpm1mFQlnanE1r?=
 =?us-ascii?Q?X8UCyGXhMSIjyjwAM/1womNlrggc2PVEn4v+Ht+8V8XNL2p7vKgCwk3vfUUU?=
 =?us-ascii?Q?fTlnx6/5uotZSNNUvkeh4DdGh+wkZwEjprGBZntuJ9PxT2s35qZit7U1nxWG?=
 =?us-ascii?Q?QzNnA1hELq8PWR2wCDFC8HX/lapA7rO3rZv5/2MyEF2cm1QUxknwX4kWRQ0D?=
 =?us-ascii?Q?ppjX+8ydfa4N6o2pb8ux+eDSqtrgcq5wDo6aLkWuaIIxwDcEHjghjvwQqgeT?=
 =?us-ascii?Q?XDVGXG219jXS8HbhBDW2Wp56lvSXaRFHpOLrdZeRd67/lk/2XPbRDF64/i8/?=
 =?us-ascii?Q?AtQmHriiifi8Tp7iTaYjCW8JyIHztH+3k/FtM2FEF8rOgFucn6LwzP2Apu/Z?=
 =?us-ascii?Q?wxEA4OWMv/OF5uw0j5PDmBbbecBvu2o6+t7aMW7XYTE8o16+3tkpbtrETu0Y?=
 =?us-ascii?Q?MJsm01pEcwAYtOmX0ZEmAQgEggJ57DffALAulXIEGwPCd0nZ5Oo3SQxsk7Eh?=
 =?us-ascii?Q?VhUlDT3bx3nIWT5mauv3d2jYofrTk/Gsr0s/XSyaqzOrIauhiOY37YbqzYFw?=
 =?us-ascii?Q?mufEHRe/9hjQYDWKLY34rFjF+kSiO/vi64oAWfiBLpjHSGEIlXxOVd8QlmmS?=
 =?us-ascii?Q?JjbMj02Wj9lXfzxV8BLD7NHGC1WeWN64mHx3djZfxuAuS4unaU4MlrtZBNwx?=
 =?us-ascii?Q?PH4OMwp+oFAJiDgpCaUbP3+aN8Eu75TcxCGCGRKUpP0s77/FHvn1qhfrOPrC?=
 =?us-ascii?Q?/ZhfRrjD5e2U34eYrXbHP7uVGV05eRljTJcuFL6VJ5mGydTCcuUBDlVIEOV6?=
 =?us-ascii?Q?Yux7LTA6yNx9RIFLx4/HwV8sYFhRI7wFiYIeveP6Ygg72pqBGi4a6IIQxujf?=
 =?us-ascii?Q?CHccZVag7yvHYpW+p0MNiyT65kVCL44MSSl46Qa+g092xL4QQ+qfqzMXiEzT?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 908537ad-b320-45e5-8458-08dba23e488c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:00:59.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2uLAA+9ljiDg8fqvIvaXV89vfUN3DsID8DVZOQJmResoTWVOwtSpFyrd2ObaUZ6TxgkFRRUckB0oKKokjasMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This introduces the MGMT_EV_LE_BIG_INFO_ADV_REPORT event.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 include/net/bluetooth/mgmt.h     | 18 ++++++++++++++++++
 net/bluetooth/hci_event.c        |  7 ++++++-
 net/bluetooth/mgmt.c             |  8 ++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6fb055e3c595..ba2e1082b86f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2228,6 +2228,8 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
 void mgmt_suspending(struct hci_dev *hdev, u8 state);
 void mgmt_resuming(struct hci_dev *hdev, u8 reason, bdaddr_t *bdaddr,
 		   u8 addr_type);
+int mgmt_le_big_info_adv_report(struct hci_dev *hdev,
+				struct hci_evt_le_big_info_adv_report *ev);
 bool mgmt_powering_down(struct hci_dev *hdev);
 void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, bool persistent);
 void mgmt_new_irk(struct hci_dev *hdev, struct smp_irk *irk, bool persistent);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index d382679efd2b..5f7ad5bc5f73 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -3,6 +3,7 @@
 
    Copyright (C) 2010  Nokia Corporation
    Copyright (C) 2011-2012  Intel Corporation
+   Copyright 2023  NXP
 
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License version 2 as
@@ -1177,3 +1178,20 @@ struct mgmt_ev_mesh_device_found {
 struct mgmt_ev_mesh_pkt_cmplt {
 	__u8	handle;
 } __packed;
+
+#define MGMT_EV_LE_BIG_INFO_ADV_REPORT	0x0033
+struct mgmt_ev_le_big_info_adv_report {
+	__le16  sync_handle;
+	__u8    num_bis;
+	__u8    nse;
+	__le16  iso_interval;
+	__u8    bn;
+	__u8    pto;
+	__u8    irc;
+	__le16  max_pdu;
+	__u8    sdu_interval[3];
+	__le16  max_sdu;
+	__u8    phy;
+	__u8    framing;
+	__u8    encryption;
+} __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b4b72070f5f6..b794c8fb2238 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7143,9 +7143,14 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flags);
-	if (!(mask & HCI_LM_ACCEPT))
+	if (!(mask & HCI_LM_ACCEPT)) {
 		hci_le_pa_term_sync(hdev, ev->sync_handle);
+		goto unlock;
+	}
 
+	mgmt_le_big_info_adv_report(hdev, ev);
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d6c9b7bc8592..db6d74c40ac3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3,6 +3,7 @@
 
    Copyright (C) 2010  Nokia Corporation
    Copyright (C) 2011-2012 Intel Corporation
+   Copyright 2023 NXP
 
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License version 2 as
@@ -10523,6 +10524,13 @@ void mgmt_resuming(struct hci_dev *hdev, u8 reason, bdaddr_t *bdaddr,
 	mgmt_event(MGMT_EV_CONTROLLER_RESUME, hdev, &ev, sizeof(ev), NULL);
 }
 
+int mgmt_le_big_info_adv_report(struct hci_dev *hdev,
+				struct hci_evt_le_big_info_adv_report *ev)
+{
+	return mgmt_event(MGMT_EV_LE_BIG_INFO_ADV_REPORT, hdev,
+			(struct mgmt_ev_le_big_info_adv_report *)ev, sizeof(*ev), NULL);
+}
+
 static struct hci_mgmt_chan chan = {
 	.channel	= HCI_CHANNEL_CONTROL,
 	.handler_count	= ARRAY_SIZE(mgmt_handlers),
-- 
2.34.1

