Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070E0C77B78
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 15:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjDXPZ3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjDXPZ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 11:25:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DA01BD
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 08:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXv8Dz0/twOLjhofMfReLBLqJusZmV0THdiGA8Kr0fUEnTTZos8gixXZL++LBsBDvgsmXcTZeGMNSr3MYbNF6QHidTeFnXrVb5X9XTkPYXZ0xr69636+0zxwbN7KZExxl7UUmkSWm5aHEBheZAGsr4BDgMmVfLK2suAwjAHXVsEUbQ880GVe48zlly/Gmieoe0I6vmYlgx+i5HbpPml00Jrgc7lzSb+h5KApvLzy3ZmBCrv/Cj+xiP2zNbsm4ApNX0FummsSHmtbvEQj9itqHk8NEKeGWAn155IlJqef6MDAr1htStucoXXClxk/W+8YpSiaUyglAPHYaFv9+gnhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3c6M4NGcB0HRHi2DXB/m5rSiCFRP3Ggu00Wn6INDAro=;
 b=VrPAh4i4tCYu2pa/cOxPRB0F04G7Mx3ZFGCaYA1iiVsn/7s5C9nM2XAXqXeyInPv/GESMPhKmUGpsaiIc5eG396mFUIYAnIHwU7NR4oF+JxnQBjel293JywQcQ3DH0ND9P7EJClekV8Whjn2gxPmDPV9+b5ukLTfMzWBqhMPcBBOhNPRbrCIbBKAeHO3fmFfcXaO4uQjyJQWcZMACyKilKKTGMVqNdfqs/IuaJ1qEqI0izZ9eJH9c6CMPSyeZxW+zXPd9rZ4LshVuU7x4cpLonLqGR2iiTxgNs1ZNLXbTeWd5Mh861zuDpk8OHvliLIMRdKxEkjgVnwwddgZsw9LPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3c6M4NGcB0HRHi2DXB/m5rSiCFRP3Ggu00Wn6INDAro=;
 b=Xg9QOe/671b5bYOnU5ZPKczAiJ2uL7ZiZH3QvfIqrv0BvPm30l3dVhxTosW4vWkVlbvlKboplzRHHn+GV7LtEdVBj3/ryxr3dht7zS8JX0NePFSKfZlYtY8tw41tapNUWRVp7T4kB17QzFiN/6FEKscEExeaiM3fwynC5KqzpT8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9572.eurprd04.prod.outlook.com (2603:10a6:102:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Mon, 24 Apr
 2023 15:25:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 15:25:20 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] lib/uuid: Add BASS UUIDs
Date:   Mon, 24 Apr 2023 18:24:56 +0300
Message-Id: <20230424152457.28000-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230424152457.28000-1-iulia.tanasescu@nxp.com>
References: <20230424152457.28000-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d651f2a-62e1-4a43-f007-08db44d81dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xUPpsK1DaSuxQjvTZDTy1WhS6hBQrNh+r5FrAAjGXigqiB+IrXm+jL9G4wHiffhdWKLTbDRFUK/4jeBCi8ymbKmpfeG8oV1NQUf7itsQGY8Ct5FGjBmm23uGpRnWPlARNAQo3Sdsv2i9gTBa8tTcXr7CslHSp6eju5V0N6xSyjD0zMoh/rsJPyyFtfHnU643XyK3vYByeoxU9By9JGrJcaPmLhm5mhFXq/tBGGvxQmudStS5VMYcH5Jm1aH/67bPM00SurerWIokaOoyMAJf8xBMAFxEN0c25DSDrB5o4sx1XlezuGbi3JlkGAzmEBTA6PRTxg2X85VUm8JhT4ZzHqQwpa8M4HHfH+SFj8SwcqRmqVSzqk6XXhQKSQ8hWit31jjw7O8a55AzVa09LoK1k77o/5GxtjgVObaOGsjYcvZt+G+UmACAbfnt3wp55Dx4gINV/wzCl7K8KpEBXLv4TuncisXIOBMmXKojx9TFGe5Fyeh2Z5O8jkMAtT3HTiPNRFmrvNOxLv3b4nZ9aieMa0bZjPqqG/g1POtSHhn3lWE/mshm2fYERxgzPIMQRURur+H9B+ImxXN6tT+S4tYHXvG60h8cmjYNzIHZgkcNp4+zvO7uhkEkNqUyfX16mhZqxolI+kZo4eqtY4J+pcVDFD8qrfoHTP6Dhdk4B0uyI4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(52116002)(186003)(6506007)(26005)(6512007)(55236004)(1076003)(6486002)(6666004)(4744005)(38100700002)(66946007)(5660300002)(2616005)(66556008)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(38350700002)(478600001)(2906002)(44832011)(316002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZOhYvh+Sm9WpFIpZAJgIZzaEFDaUDyH+XAhbQe1rmnKMnLZHyNjDLoC4idW?=
 =?us-ascii?Q?NNA6kUacWeeXwQJF/XF+K1edHd+xmnMkx6yd37vNo1uSq9sobIZEMEtsSUc4?=
 =?us-ascii?Q?UQb13yC6XIsAAsgpEKivHQQnzus+bV446T36Rk2YNvnHOcsvcP7e5lTcoGlu?=
 =?us-ascii?Q?DQBjI6V/2s8O2zYIv+y8MDUlLoupMO0tpo+TNQsiwfpUNbbdug5H0xRkaG4o?=
 =?us-ascii?Q?UgL+4V6zZzq1eUT9obrovDPVK4yI5t/kW7Q+4c28fkv7hNsdQSBYiely8Q4g?=
 =?us-ascii?Q?1eSIAhl2w8XiCTUcEXOHWl8V3B3Xi+lGcswGSzllhybeJenINVg+QKSQM5ow?=
 =?us-ascii?Q?O5av18OuGeEVR9Nzb4T8Y6waZh4JfGl0ln8R8vco8XsWpbJckgIE6fxn6FMn?=
 =?us-ascii?Q?T4/7pQBskoGiofXCbB4hABfi2BFCMkeOngm2/BeLrcOznALQBwBS++ApthFI?=
 =?us-ascii?Q?kcnok4S7UZh/bx3QH+4Ve3Dcr8fR9qIruviq339JLoMzUcKip0keJpeZgPun?=
 =?us-ascii?Q?8GfbuYautKGY124cEseYJsfDFvVBMofMN6yP2fPF7cC46ZUaR1I5AUfGwoJV?=
 =?us-ascii?Q?Z5kPKrYkyGfPr3fgGF/BfnL1ergwZ3YAMvobGVRT9GiEzNZ2k9rcwOHzTHV2?=
 =?us-ascii?Q?U6AzYnT7v67qwufRurDfpEY8l8jrJK084YkOBIpFr8gi3C++SvZgGjrt4Car?=
 =?us-ascii?Q?QwqgrabQ++XzmU26to/Q74Ugd0GYzwDJceXFbGj84ksQAP9XcLPpK9GLZ1mt?=
 =?us-ascii?Q?VC9S1G6wTWQ4ed+kkuZRhImZjltS1CNAK1uF1tVEcNHBlSK6mWwcUW69YD5E?=
 =?us-ascii?Q?wrtNbO7lTxRCRMjw+pA32f9G7dwuAIzX5G7vxWp66SNTZd3suReOewfuzLUJ?=
 =?us-ascii?Q?MqZuJ8bLWB4kesf6KUoWfHGSQsmJ7jIIgOVORTGAMWkmM+R8PHJHlnOWJFTh?=
 =?us-ascii?Q?+N97JEhSusoVWy8TyJhMc5Lo0CDhA+/jsNRI6+fNFr1tZZG9aV7j19O+O8uv?=
 =?us-ascii?Q?x8n0EaZsTlwmlpiNkuJAbY+iHAvwZXAJ+KOTuddt/UjAEPOeXGQaXvHN4qxR?=
 =?us-ascii?Q?5NZSCAS0Bbc2bNHijwR5CvEo/6dBjvlXMEtCBUuxvdD8uEw3Ex0jm+NoUcdK?=
 =?us-ascii?Q?98BG8sVjYN3nXs5ih0XFRowfME3CjldhftDufnLeJdRIn4tJqx2COvAn8m+i?=
 =?us-ascii?Q?mG4X+sbdZi0gnFQl2ZQTbia0NFUQEAbYkupHskrC2tbDP9/Bhqs51in/Gjw8?=
 =?us-ascii?Q?KYJoDPtrykhJaWxYFSixSbzuJiVmiGgXYrXU9giGw53S9ljOAZejWPY0qvwT?=
 =?us-ascii?Q?d94p3RtLdCHHBrV194iXfxBgcgZKE5irkoQShJ8ivxCmw4eAjiCW7fAJPwOs?=
 =?us-ascii?Q?WBgNI5MO9EdST2L5rUDFoc+qpxZ9kiIOE/c9HO0GXT4dYo/v6ctoUFgIQtAs?=
 =?us-ascii?Q?lXw/RG2Vllez3GzT1nyorksSsGTTBvFxmY+HfmTtLrvk6reMRs/ulbA6zLe7?=
 =?us-ascii?Q?OV7YNuCu//D6rDja6yw/5Ixk5GuUjkHIsonWTmtw+2bsMZZ5vGDBO0FDLGZ3?=
 =?us-ascii?Q?iIpFGS2XgukS9qNA3/nqSKXQari4eJ61vYUjN76wVNIXoR94whK1kuTZ3Vs3?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d651f2a-62e1-4a43-f007-08db44d81dd5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 15:25:20.8404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q0xcxOJzFS8yFepz93sB3JR0FmGaKDVJr7Q9dwf/fUVTPWjWA1R8wM8x7M68LWXn10STdWqeZWs8dZ3HQtASfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9572
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds BASS UUIDs which will be used by Basic Audio Profile.

---
 lib/uuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 84ff46cd8..ddde4bfa3 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011  Nokia Corporation
  *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -164,6 +165,10 @@ extern "C" {
 #define ASE_SOURCE_UUID					0x2bc5
 #define ASE_CP_UUID					0x2bc6
 
+#define BASS_UUID					0x184f
+#define BCAST_AUDIO_SCAN_CP_UUID			0x2bc7
+#define BCAST_RECV_STATE_UUID				0x2bc8
+
 #define VCS_UUID					0x1844
 #define VOL_OFFSET_CS_UUID				0x1845
 #define AUDIO_INPUT_CS_UUID				0x1843
-- 
2.34.1

