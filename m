Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB94C71145
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 10:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbjHXKRV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbjHXKRG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 06:17:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E495F198D
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 03:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8upZiZpX7NDvxvPhFg4WbNvhnKwLjGXICl8kaIOj02CPe4Cw538NUUQGYFhvP61nSLwKqYOEgvjgy7HiJdArMr21q/5N8KjWmloMoGnCwx9E8iqKZBWZIU/gg1TS+I8CjTtDZCIAU333uths+GLwh5lAtcEAaY+bHJme+oHcok9xh/OCkbBYLZb17arQluJsMbBFRS35IkEdGHpr0Dx5Ui3AVv7mbJunaDWQ5Te0O8ZTLQrcZOolSgSsV4mN2YfPbI7eUHiGLcKv85PD1mR9R9N9SLrR3kB584Ns/q0SvySYA5+AVtbhb9QHfqnOjbUt8km/oW20Ck6IPp0XzgJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMV9PpYmktlqwjJdmN/dRQnPIlDr0YKTCZ+vufcaWv4=;
 b=I31J8LvzjgKZuNpI6jra9kygH1orxvntshic8qEUAz0ok9hdZ9NUSQReTfhiZQBNr8UyDUB7mK5iqVx7reRbv4H91FCd4o0s31ovo1j+jRkp15w1+v/92jZiw0B2L6CqGfYswQeqa5VTwDBOP2qG/dI1hcz6Sr9+ijmYbkAR1yIzeU97rgrc5JTpw8LhAU/+zDR5KCcrlWIqULVsV1wi+DeXPLgohjmH+sP+ejLpysKbW3GGGq8pvWvdnQxjZaHRxUTPIk23tKeFLf1AuXn2a5Q+0TrHaFhrRyWth0JKCDZ32NUSR4r/DqXrbgUNQxsm9aT1f4/FCnJ1J4ETZ+eqVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMV9PpYmktlqwjJdmN/dRQnPIlDr0YKTCZ+vufcaWv4=;
 b=QRi9jTEf9yyUkdKnXTQ2QNKYegl9r7i8aHeUekeFYgybZHXHniSaijse+SPKUoDULdhnwuFagVeU0WYl8AU/2WHpEyRmHipL/MbbzFKEw8GSJepM8lAd4gjUDZEnnNQPF9YXvfjK1+jJ7XYedwxWdbHpL5qM8wZv4HEwXZA2tvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB7034.eurprd04.prod.outlook.com (2603:10a6:10:128::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:17:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:17:02 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/2] Bluetooth: ISO: Add MGMT event for BIGInfo adv report
Date:   Thu, 24 Aug 2023 13:16:34 +0300
Message-Id: <20230824101635.25662-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824101635.25662-1-iulia.tanasescu@nxp.com>
References: <20230824101635.25662-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ee79979-68ae-4d8c-0a69-08dba48b423b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJMK7s2Dmga41jHx0v+mPIGj+9JKR7NmLntuHv/T8sW3gyRRZjkl0D+d4c8uyBJeFVjg6iootl2kSvcZ1aG7hdioy8OzwzodmiMEz43srWyZvOUG9OP20TibcapS7ecSwbPRWFLFeg9PcuTvI97dSuR0BX5p4dkDquhIk8I/S0KET1iuEUULZgjguZk6J7dmjluZrMZkNvNArnxz4GdE76wF+pAHJGE2D25/UCquO/UJ6qBxforEQVBWUZoS4x/vmoV+bwCMt+HiifqoG7KrKV8A7h3uiGGYikhJwFcLDsswFlcCGkfYHGBj8y56dOvzxaFgWKBmkDNaAG/yYKL0me/oM20GowJCAPDihnipt++PkfCxawevdekW9DoqVBXu5dtLNic/wdsPV9LYfBQtpRlmUprbmAqvjjXpZxQUtG5baq30p6laNmrVI0k3dRF4kHQRZ/VvqbORbHfHZMCZwE9peCJLOVABft1x7KAk4H9r6uBup1F6+AmWDfHJQalVdo2gJGAX7F/TbxyJi18yoZ4DdkwHyZ29LeVEzxSYFKPVI3E9sr+nUJCAZZ6tKpNAwgzB/Unlj+MjJQFe/vBbU4GTSORNrFvDw8SXYA8FtMzK+HBEX1oqgpnjSL8nd2ZOFSXCSL3Jtf24v4S16VzjtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(66946007)(66476007)(66556008)(6916009)(316002)(478600001)(38350700002)(26005)(44832011)(6666004)(38100700002)(41300700001)(52116002)(55236004)(86362001)(6486002)(6512007)(2906002)(6506007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(83380400001)(36756003)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cyg2DyRzXhzlzNLd75jOTeOx5UZaqwRo8b/9IEkaT0f+qdJqTDZdOFFzttEs?=
 =?us-ascii?Q?nQYT/QV7dV+fwdlNzyjJVcLOmxTw1HBAr6TncE5DoErRdt68RKt0SeKbdqVU?=
 =?us-ascii?Q?Ohcg+Tw/CqOLGj4ZdJwMe1bDVbN020M1+yzywO00uQsHf/zJ1Jd0v0H2ahWv?=
 =?us-ascii?Q?zOgp1yXftDzMwCa29Is8I35CDR1PS9bncdf5MqaoPON2OUXV/UigpDPDZ5r/?=
 =?us-ascii?Q?EVHBbztHGYtTERfMduC0VXF2/GTPMIFeLd37oZ4H/OTJluvRYVTH8ytRh7C6?=
 =?us-ascii?Q?70y6oCILyAdOdIYmsQrdLkb3urI8jEsBKSS0H/r9gsODf70kQaAT1uU1BuhD?=
 =?us-ascii?Q?OiW1/YcFQH8YWp8KNwQUGy74gPjye7hSucqgozfqnoBoGGHw6B81G9CZcNPE?=
 =?us-ascii?Q?x7wmT0F+T3KX04RadRgybWvHMdGq2Ch1KyMjHbCJau8w4R0xJ4/EgjSrlFEt?=
 =?us-ascii?Q?Rt4s+m40iK1ovBWFd55Z4OtMwRbvr5PTak4TTtSnf9nBqbGVwX9J5Spsp/X7?=
 =?us-ascii?Q?CsySJiG1qOo+RlM5xrKfs/ZwalpKSC+2xftmZVSvpNp5OPXwnUbVWPUpMG2X?=
 =?us-ascii?Q?f0He4Y7aI5t6yGQdV5ivDgkwFmlr53muIcch9qPG4fmZr8+JemTDOW2LY6dd?=
 =?us-ascii?Q?uj/Vwe7eEtGy6+2Y4fG6FtDzsd59/2rZrkh22pLO7Cx2Qn29ILeNZSwkIWRj?=
 =?us-ascii?Q?uF6fiRMe9ZlwIHNVuR/dG+oc/+NJPReiO5YWAY4EJ/PQhCZlmfQOaqc5fSbf?=
 =?us-ascii?Q?gSCejgMMX5odDZhLKcriA8G2uMmBM5s5mYULN8sUonMUhsBhuSjuarS0Z/Lq?=
 =?us-ascii?Q?CB7/1lRUu6xOIgfr/fZcrct/5mHAhkxTL1RddB4QCsx7K7ifupdOispzP1fN?=
 =?us-ascii?Q?WWjNaP01WfZU2bn2INL3vYCqXNoxAaF5fQe+nvI5U2UOxcLNcweIIoAD9JNf?=
 =?us-ascii?Q?pgvOEttWAbKJ6HwAtdy9vbNEoKO8gHCcg3b2JhB2O3LZPanLKwYg0Q9JjQ5Q?=
 =?us-ascii?Q?zv1jdz4FGIDutKvYIN3sAw1fLy9KADgkvz0xZwvUnvbRIsI+To9KWRPNQZkT?=
 =?us-ascii?Q?vpbNnJpvyvEX9C3zebyQfdiNN7JcrW3Q5XmXX9bWX4co0q6Jl71p3+obnbAS?=
 =?us-ascii?Q?+21lgiQeRupRwQwoZ1px2dA+P0ytN+Suv61dLjmJvDVgGvepNRkZ3As39ISx?=
 =?us-ascii?Q?D7+6mPRajo6VKqEAtjJFONEU+bfkimc+iuGf143MAr6DwgJM4+ltRkTu/Q8F?=
 =?us-ascii?Q?ze6n/8UBMCuQbGxWpbX3ezvisBod3vMlZFkNUZwhDkEvMjUZFQzgeM6RtkAY?=
 =?us-ascii?Q?MlvZ+4FfG6moc8biPdrMGucsPYOLqU7eFcg8Sa9JvGeyR98D5CUNCb9A8vcB?=
 =?us-ascii?Q?1aUqD4pkeRqocK4aHxPmkG/C0ghV2bPapwVxuTm70w7rIREAOZ9GC/8C7N2M?=
 =?us-ascii?Q?mmfGx/eXfd1I+/osgrMZDRMAgTmvBJfiC7rI/urzfIiEnhGcf34yjPnZHQAz?=
 =?us-ascii?Q?2S03vFuXfLZ3jpcVq7XEZVN4OT2MCe9cWc3Fa9idr3VG1vY2/0oAENGP0O4N?=
 =?us-ascii?Q?Dv4IwXdt9ePNcu8epq65YCvbT6smoYFlfCn7DOKp6OCDyw8YsfsqDCXe+7Hm?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee79979-68ae-4d8c-0a69-08dba48b423b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:17:02.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+1PBshhLY4SCyBbIqVSQCGtl6XdpNU6bFEi+uc7aQ8IBjqAuPRXX3sT6x9UorC7al5UNHtigCJBcLGd1pbc9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7034
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
index e6359f7346f1..ad6d24f17b73 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2230,6 +2230,8 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering);
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
index 35f251041eeb..3af1a532c9a0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7161,9 +7161,14 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flags);
-	if (!(mask & HCI_LM_ACCEPT))
+	if (!(mask & HCI_LM_ACCEPT)) {
 		hci_le_pa_term_sync(hdev, ev->sync_handle);
+		goto unlock;
+	}
+
+	mgmt_le_big_info_adv_report(hdev, ev);
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ba2e00646e8e..25334833f7d5 100644
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

