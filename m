Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B09CE7B05
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 08:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjI1ICm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 04:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjI1ICf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 04:02:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E420999
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 01:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaJist8NqUoY4HE0wGpzh8jxsuNA9oOA545/r9/4DNVog4aNEWn14jldUUg6CMkJonWo+LHU8hL8G2NX/mv5hG2eZ2sD2gS2zajYFSTQr0cmht8Oq+NrWrkcLuiYdZGvbkx69oCKnjDfua6NCtj1IV/Husyz1vyvhLcpu1TUBMTkCID/XlFA5x2JutolFHJuS+NAHGnSgjMu7uu/uWYC3RRc+q7VUa8/tQxPgr/H4Rer/sQwTInQITMyacQL8Re//hqPbyZ3EMPb3+qdpp6ugALlqgxxxeNjVz6m57xYcFqFUL32NbPM3Kl9+Z5+ilRLg2yBbSunGn15PI20a58W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8djDpoUxIjOxxBi1Dj9fuAJs2NTsAun6WLshdszKhqQ=;
 b=Ifcwt8GEzU+hP0EGBWBtVdgJblNo9WNz6prQBaKK/ci0uHHyXMGo+LYo7kWcjYyaQqMVKh9T+ezjS6kfxyjZBqJD7mtq9NHen3ek2FTlxFOmRNs5jSxEPJuRQDI1itt0Yf+ME9inqcUMM3IZvT43RD4JDUdE1HtbAz8owHhhQHWybZbNMoo2qeyzR5f5gQ0d/7FxAB+vM7qmXIHlYT3pK7gWXawj2LfkTE4MREXnTMvPACLpwDsCoEsnQHYnOX91Am4vnghMqpIT81SilGoHnln6hP4LptgQt4dFZjXZBPKkkWrimXibgNroU9+05ZcR6+qkxYLg6JhSHujCS3H49A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8djDpoUxIjOxxBi1Dj9fuAJs2NTsAun6WLshdszKhqQ=;
 b=QQDW00eVv22BqJE+2nvcqdyI5uMdZoS+2ALFR27db6pMnQe2rVnQzSP5VYaJEDLcQCXPnF9vi+4IjIPnGDHMZ7kD3frTafUcKwCZBLALdSRfYRK/kwWFa/kRFnArHKh93aPVnnlGWWNt1VsZonMidHRoi/oQeYleVrOGVk/DtZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8290.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 28 Sep
 2023 08:02:30 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::a53f:4bda:e012:a73d%6]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 08:02:30 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date:   Thu, 28 Sep 2023 11:02:08 +0300
Message-Id: <20230928080208.5517-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928080208.5517-1-claudia.rosu@nxp.com>
References: <20230928080208.5517-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::18) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: bedc554b-4f06-4cac-568a-08dbbff943aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LdBvavf34/nh1N9A7nOiZEOITopU3IhiRIyMmYz3e2EldNTpcq1WL4Fdt3gHjUmB/o8QwsOJTS4W78bTmxQM7xtRcE+evN641ZOzgJ4OY2Sn6L5dpcphd7G/BhvUZ7R0g/9WkOVPlVAQWwLeJJcPseED03d7DN1eL/ypv+qHMMFUovj0QgI1EY5xM7WQFdJvpYDm3Y67iB28MTrqjHMfZ4wdxZnCzNz3Evp8KcNypHTfiUW53VYh6/GVsAVlw8KOEjbJhM4nzPc9nGa/q0TmKX6wwCycFRDOAidA2+DNsO8uQnaTfONprBb+RnShycos+6hyQIgOCB1j9tBdXkVsN1QOAj5UiD71HeJXgzQEEuu+3UUrHdnPrYHUxWLF02xV7JKikkx9iBfVCTQdyLr2dfCIUpuvDd2qlaTbPgzMjRiYsAOTDLpAmBctCMntPLv27qqpd6jWGGQuZqmFvWQfHDcH4PF7zBUuG6UpQzoHwaHd3u7TPZEGpAlngad/nhfRVyvgDwm8zn6saKymabM7KX0mWpR1f/s9wHTV70znXtKpL5SKanht6KQnSso5Mmx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(41300700001)(8936002)(8676002)(26005)(2906002)(5660300002)(316002)(66946007)(66476007)(66556008)(4326008)(6916009)(478600001)(6486002)(6666004)(6506007)(6512007)(36756003)(1076003)(2616005)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0eTTXQAA3ZauTCDUmMYLz6Jh5MHIrhnsZQZ3D1Ikt5VZH1+D/mmZivDCoS0L?=
 =?us-ascii?Q?IRr2uA447xGZj9uJeNxjAfyTA9xne1bJuofMZgl3aTXvnI6996/997aurWxN?=
 =?us-ascii?Q?mGbrgU8mDGieZ5UsqqXpwfYzkXJluIbJu69okgne5wAPozhyUnzZ+NuxKdVB?=
 =?us-ascii?Q?noywjLOSSzJGkqboS3atxUU0to38zpTu/SDnLRf4emQQAaOxPnxwTE8n+4td?=
 =?us-ascii?Q?EGJY36hR+Azm2eV2JxRzZ7MuRDRmltS0PxbE1rlIC1/3rYOnXEHIe1hOETNB?=
 =?us-ascii?Q?ZyCkFs5sn+F1N5aRkyGKJHI27LIRZT6sD9JMxukcLcL1tfSTPczvA4+X89Ej?=
 =?us-ascii?Q?tYd0Tfq/A4ZzWdmjFJm0RSOHimo5nPm216Reb7D0MzrliK5yjouVWP08WWGj?=
 =?us-ascii?Q?BlQh+uKqhWOrK4crAKB4gNdEzMxQjEYM1R66nm2t7BpKKQTPU8z7T1G8lnTR?=
 =?us-ascii?Q?USqGFwpSEyWfnlEADTRbkRBqszPvxx2G2FJaMZjG2vc+5iifgB0HJjJY0f3j?=
 =?us-ascii?Q?z62Eee07xekNe8bW7jVTUPqmQtCRXZpc26RrJwwIEVmq7/IbXbC8UymWD7KF?=
 =?us-ascii?Q?jKSBtqRC3CHr5CJLvVpOJpN4+Vp8bxdEK0RoBEuYPX0yMckRnMQP0BZE1cVh?=
 =?us-ascii?Q?qv2/Wqj9aIHjQA+mbVIKcOqhvgfxGwjzQG3ZaUZ+bVcRQr/5x3r17Ie5d2O6?=
 =?us-ascii?Q?NNZJTf0jjIR6m5BfRxFCvdBbob0j74A9fQXR3iLMhM+IIEGjdYBEGCuJDiwy?=
 =?us-ascii?Q?oKpdy061E7qRsbdv7/0INe/mguu1WVKjxjcq2uQNqP96MCCLeL6hQFMXs2aW?=
 =?us-ascii?Q?eZiaF8t5BzJs4aEjB4TOF9A87WTuWE+VCZyN4QVkhNZNScLx0hN9xlZ11Zwe?=
 =?us-ascii?Q?So0/fYre8WjL3ymHC/luAekyCeu+XcDhBmJhurXlQDqWXq8MvHRergilEP+/?=
 =?us-ascii?Q?0Ch+lownS0W3P9+Ma+RTi+ZRpz4f1ldJUdT6jHdU2ahyWjYh5AyTWU/c1lVt?=
 =?us-ascii?Q?e8/HwqwZKswgq0OZwaDkzkNf9guphRrJfLfofi8KQRWth1TJyAR4tsK846PG?=
 =?us-ascii?Q?fJju0VmzlFQcoEI7+Kd6Xul7RnXEIabddxg5owVa+BtoKDlbm5GelsyHFFHx?=
 =?us-ascii?Q?9KE1EWmE18WRY5OrjakLKu3peUHWunQIReVHHB8xY43SZT4gHhadtvPJUCi+?=
 =?us-ascii?Q?kieoJys2dQteXkeQv275WN1tjtF/D5HIY+uEQiLbO07FU+l0lFi2R69IQzxI?=
 =?us-ascii?Q?6SNYOFRDI+PuZPMQxCS9IviZVgl86HkJUB0FBv87dVwwjwgTGAoL8XdInVGv?=
 =?us-ascii?Q?OU6uTvi4F/ahBwIHq3SGA/uajTc7aWaO3K648tmZkA3T3JKrWqiZzR7KSK1j?=
 =?us-ascii?Q?m+Oj1J3dWxBlxOxAbcnzuHh0MwF7MCusoof1nWsdTxtLRc+rZQ7+aGtGrO/F?=
 =?us-ascii?Q?Hh96eHIGf2lTCbIvagUwB9ple3sUlYRk/ZtCvL4nrVoXgMSefVEw8Qru5bjr?=
 =?us-ascii?Q?8RUsHHa32hkNl0qNZg4nHHECuR86Ra4BXR61RERuAmu2bv9hpSJaTs7Se4Yf?=
 =?us-ascii?Q?dy9uWblY6pYZQSQkK17yVjaN0E5WTpWvvrqqL3LP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc554b-4f06-4cac-568a-08dbbff943aa
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:02:30.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9YIW888v83784G/nrDOnP/gHezsgy7/63IAQrNQE0IFBKVTjnSeS9z8sIF7A/ml0NqQLLJOxrUdYOUthTYLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8290
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.

Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
---
 net/bluetooth/iso.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2132a16be93c..4f23b3a35faf 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -14,6 +14,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
+#include "eir.h"

 static const struct proto_ops iso_sock_ops;

@@ -47,6 +48,7 @@ static void iso_sock_kill(struct sock *sk);

 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851

 /* iso_pinfo flags values */
 enum {
@@ -1461,6 +1463,8 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		len = min_t(unsigned int, len, base_len);
 		if (copy_to_user(optval, base, len))
 			err = -EFAULT;
+		if (put_user(len, optlen))
+			err = -EFAULT;

 		break;

@@ -1783,12 +1787,18 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)

 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
+		size_t base_len = ev3->length;
+		u8 *base;
+
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-
-		if (sk) {
-			memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
-			iso_pi(sk)->base_len = ev3->length;
+		base = eir_get_service_data(ev3->data, ev3->length,
+					    EIR_BAA_SERVICE_UUID, &base_len);
+		if (base) {
+			if (sk) {
+				memcpy(iso_pi(sk)->base, base, base_len);
+				iso_pi(sk)->base_len = base_len;
+			}
 		}
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
--
2.34.1

