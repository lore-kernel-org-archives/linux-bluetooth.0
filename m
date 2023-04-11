Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E6C7619A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Apr 2023 07:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjDKHmI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Apr 2023 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjDKHmF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Apr 2023 03:42:05 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7894213D
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Apr 2023 00:42:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvnyXO/oQf+FdNV3GJsjN3MhAl8QXPNE0VDssKJbXdHsmycnVRinWuJpJoY//RnlZdoeRbwxJWB2LTkaGQPG/TwmuKDqWNBkWXKk1j+9GoEQYSrf8j+5wcqRb8rjdPitozZdAR+FcieBlcWKCig9pRp/UOd4+ecmZpOLXpTBPkInGvcwrniO3Mb8PU62u1inOt1deWIc9KAEoC9RNak2DodfffZgbV8xmHz47xlW0cuPOzg8lwx2QyJVPIAFp8muYBpL9+cdtixksjPWo6x4ppGiR4v9OxBlmTZqKWiZmVFBvn0gVaIOupEr0S3e9L6aZ2qtJxotAZ2E+5NFFpVMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5o2k/ZOTSQ/8w/EtOGvK/oqB7GyOm3XA9Vm0HhgnMow=;
 b=Ry/jlJCRSaJ3qrv8ggZRjTv2yAH/UOU6THZ71HIt9A4RrX1beFu+6sM7KUTp/XfJelqmDER5FTMQpRfCjeZC/rk++/SF/nkoufsZLd5JFKBZ9WRXuoKo4ClfSAzCx6TEHCMqxNuo28V5ikKBeM6tgbdS65RgQwZSi6nMOLyBqXqIdLSttkvT9xdwaXhf58MZGhZ+z2sD0HYDa7XGv84f+QwLQAR7k1sOpfeOJblPOUvCIRqMOor1N04D9n8hJsUo832iztbmxWn2Ed/uPKLgWK909SspAamVjWC8VituTB0hOMGDnNrkBht8ETIey3tC0ZV+WKiI5w/rlcQkH95fsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5o2k/ZOTSQ/8w/EtOGvK/oqB7GyOm3XA9Vm0HhgnMow=;
 b=DlDkKibAND7SbJ9/n1Qx9l6YKxGKVeCHjrjIe7x+dm3e2H7GWWrKeegcxYAMcx27hlR4qm9eXq+vpBlPnxSKCwqiNUgt8DEyLdDnpVplDJzV+PLmZ4eegf7aRVtovIgSu03+AaUaepv0D3rn3unFHKWUPrsZAczFI2vsA2XOmH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB8137.eurprd04.prod.outlook.com (2603:10a6:10:244::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 07:42:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 07:42:00 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: hci_conn: remove extra line in hci_le_big_create_sync
Date:   Tue, 11 Apr 2023 10:41:34 +0300
Message-Id: <20230411074135.69768-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa408aa-6393-4538-bced-08db3a603beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exBD8I3AIJKER/okvivkFq+FIL3vOThp94pcjKvEgwahGtHTW1yGp4vMWGaV2/XNOie4H8D6RN5D27amdzpPOpiyUCVUpq8yCFuBQv1AHbVU6wixEqTD3haIhOhcJXxGpk6UQh9AmRXQg52XlCoqn6mT4Ee6xTdAJvzIfzCmMPXDuW61J1BAINhXtl5bVA6kz7edMihfwlopp06yDV2BTxULVIvZfKL+LgNYYGshlis4R5oSMyCAkg9ztDyIbHJJvRkJFtxZAzSc13vGRzB+YBmJhN2wpBtv5SXCxvNGtE0OOFTZsHx+yHXrK5zWK08ZuOZR0hVhDmpmYId0vkwwIwEDPt/5sKHaIhEnky0FtIU6LAR2BSvOWaPiBSUwKWhfcEOjVmx+zZKqVeVnGtXqMcF8YWaQfG5UA3O2vezNU/J+wCKn+N0qeDJoggsc1a0wLDMFBVjVzeSQ41UxJe4JgqAuspN7huPg5vKdP2rbqeK1p6SzS+a13f4OyCzfub2Si28Ca+6gzJb1cKDYkWrraVynDDB8Am/gvM0/XHfhSmJ3CeinnBEcuXjFEYgUmRz9i90b8Bt7GAknxo+2XvenRzEttRrR+nQLbdMN15zyz0dvPaj+8XWO3mEOW7cNTreP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(41300700001)(478600001)(86362001)(316002)(8676002)(52116002)(6916009)(66946007)(66556008)(4326008)(66476007)(8936002)(6486002)(5660300002)(4744005)(44832011)(2616005)(186003)(36756003)(38100700002)(38350700002)(26005)(6512007)(6506007)(1076003)(83380400001)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xXtQxv68gQa1SeAVwtzGo0s6VVqXFw2bWZLXHziHEsXUJ0Ho4rVBFmA/rK5L?=
 =?us-ascii?Q?8XE1PckqpZu19b6oMfIKK6uK0FA+fkjHflJAb9PjturfOzgYoenyrRjup0Pt?=
 =?us-ascii?Q?pQq12CeHNFhpXMB3c2r7bBTQkYVSpffzI1SWi0n5Cd+QAxfR4UYYs/4AhD47?=
 =?us-ascii?Q?ieRzYlNKTorw3hywiOikZBPsiaW9Or95ZBpnqjJml4/CKkFNQ5fHmAbSZUq4?=
 =?us-ascii?Q?05SjsAQcf2rErw46jrsSpjuli1Obkm35UuEVm6hD+caNNo14xO+XBkWjErGJ?=
 =?us-ascii?Q?A2e1otRVtX3MkqARwbs6VUA2LKr0ARb7nl4HMmlULVnchVkALKFxeFz23vjF?=
 =?us-ascii?Q?mOH7dtGY9aIUv1M2YS2xP0XFbmKdARTDwx0c4WpMF7Uu9OJXHPNDbr4O+Ru6?=
 =?us-ascii?Q?HMjNEArwKefffYt5rcpoYGoGz+XdRlZCUlopoNidEbxSuZS3e2msLVphcwZ1?=
 =?us-ascii?Q?FbjJ/8u6o13iU6xk7YdroXhCk4EKSrQ44ff9gj2RErDXaia35hVmnREilbKQ?=
 =?us-ascii?Q?3dGBIxnTuyaKNPzsR1Jj95+G6/Y4ywlbNs0VV3XwhcDmSFCl5Nrl2j0cyleA?=
 =?us-ascii?Q?EUbNxRW2XEM1mBsulHKorgAm4we9a3SpISEEo37o9t2F1Ia0+4kdBVPgIzT7?=
 =?us-ascii?Q?0HvseErfuXpEYa0UABgy7Gs93tmGoRTlYWRA3cKfY6MjrlOYonBJo5CJhIA2?=
 =?us-ascii?Q?eY0HBgFCUPcl5H8LStltCnZPs2Ia4dciBwUd4mGGB+I8gM4LU+r678c1dko1?=
 =?us-ascii?Q?o9cRtWGHnfKqI7X5b1eGoO2peqg3vSb4JDsD+rPan5ty2cMO0wL2IuM+NmKE?=
 =?us-ascii?Q?jwbs9cnGsQWnkkQEG+D/NStbHvwN04hhm+8F3GVBhrpqqUCDCNXaq/Lgg4px?=
 =?us-ascii?Q?FGJFkqW2w6c84r/D1tMr5bG1uHvL1WINPWrjqZRuAFtMP1R8zKYnqYkTlUkv?=
 =?us-ascii?Q?fBkoH1KGjCKYCk6+jS7qduhCwlIyd0UOP/AlrDsFuuUbEqKXsW6SAgPynA6P?=
 =?us-ascii?Q?w1Ku9m2IPEyho+npeVN/zG0+vTTnwhFVlo/caso8ZEyxF+Q8YakZZzWV30bg?=
 =?us-ascii?Q?l/wDptc+dHZfdeWrz7EcBul90kd8u5kxkrgKF0/k0Q9WnFdlqoR6oSHkP9Bp?=
 =?us-ascii?Q?va/q+VhAB7vxZYO/1UgoOMyOyZ21bi7zoRZUGxVKhiX0Y+bngNZwNA7dr4ER?=
 =?us-ascii?Q?pm9qFRHTygDgBAZIrlZYxBJIuztJp5xZx8vgiNM+nvoFklfxMNbPihVo5+LM?=
 =?us-ascii?Q?oc4rr8IEoOWVf9ZQFBQsqmSUFSXoG2gZoloZz+/Pak8RWSekh1YEBsaiWmha?=
 =?us-ascii?Q?yNOdqzfId07Sm1qua7ohMWHR2rYagt0Mjv5qq3SLr52ooqnVag0yu7BNURYq?=
 =?us-ascii?Q?Bg64/tdkxH0rgdiAdUl8LLr0xjyzC8zufZSxqzMOXSgzwU5CFw5OJTijbdmW?=
 =?us-ascii?Q?nXuTXo9GH0ZvPT/SsUh+tCCPvVU9S8h2Kvd8IrXltSWt+CxABNZ6QjK8neBq?=
 =?us-ascii?Q?fOQMsRzpq7cI4/qYnEn0Vq1RWGwDy93Tjb/xSaR8gUHdTfPB91narDryuxXR?=
 =?us-ascii?Q?GnNi6xgZNsEuMPD2UgOQMF7Gr47Shxtr6rd7dz2YHuv7Hc1cx3sGTVAd+fO6?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa408aa-6393-4538-bced-08db3a603beb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 07:42:00.1550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0XyEF8R4Iv8W+lWcKb1xEgxVQ0UO2gQWUFRSaJLEBDCRHmRxVOdPoTKjr96CGjkYCowqtY7+5Gh1Ey53oruwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8137
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch removes the extra line setting the broadcast code parameter
of the hci_cp_le_create_big struct to 0. The line above copies the
broadcast code set in the QoS struct into the HCI command struct.

Iulia Tanasescu (1):
  Bluetooth: hci_conn: remove extra line in hci_le_big_create_sync

 net/bluetooth/hci_conn.c | 1 -
 1 file changed, 1 deletion(-)


base-commit: cbcb70b9beeeb5978f34844e7fa3a377d9fa350f
-- 
2.34.1

