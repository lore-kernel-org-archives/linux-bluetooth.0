Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6A5EE57EC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 09:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbjIHJQz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 05:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241404AbjIHJQy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 05:16:54 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF1019B0
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 02:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcF2BV/X+v25S+jaOghqZvNsLT0ZLtu2ywjhEFW9P13FtxQCJ386PEVEarIRFmfHYaCJHK9PZowKokzjhJTmJ8I9vZdghWCXV0pYKKJa3rQs6RlyrE0kTnaK7mNQVZFvPXQsdL5ImDCbt9xOxlPXcu7edyMy1iNTRagxRZ//CPldjrSTUXYHiwuxpgpEu22JrMQsmaGnB9zH+PzcMEtAxCq+/EYgqn1Kpclc1CHjBdx1vlAYS4wv055aDtFpCoVJP5MpKi1/7/xh9YAXYCoiStBvG/Ov8Ci1NzH00w5Ss23gvU1iGF+9LuXnotOL83oyjGMKApDIMGQvPc1bjgI46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEJzTyaQu9XVLnMtJfW1NN7ghoonjf3+4R+PAwq7G6E=;
 b=fPNeQ6EAAqQerfuaj5lJaecaTQN4W3t982H4xa/+VVk9DS4HgsvJ89n7cIk4fKnjPIxcvJnxr0BsPUm5poyBr82XoWf5mpH+XubsW0agD7oGGuRK1pKjH2OkBlekwYWHPhFQ7vApnqBhH4Yl/gCzZLCx6Y+D7j7rtV/Xa538zlk7I5NVdJpvUZf2z320V5FgrTVJaC2jPe1jg9CyiUKWrunb8AeOvU59FHw++TfPuiVZCXn6bAJRz874Lh8nJ+vXEW4QkHyrWvaojGE7YumgddFHQ4NJZ1MNK++x13b712ZzPtQavMWnDCDFut9h8/NKONVZ0LAqfh3EsKuB4jACLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEJzTyaQu9XVLnMtJfW1NN7ghoonjf3+4R+PAwq7G6E=;
 b=NfFiRYPAFdetCYgz52CiS7HpN4fVr73MdyO4CV8c+sfn4lFxhbeFNRfhyH29yG+Z71bE12M7h/Rc5yrQKTxB05N/9jHWp2kI1ij8VgB03KivkoHnpt3DzuWrVidrDUJOvmu5gGwzFJdOfvnmdD7jpSJs93KeSvBfHNFG5i41MPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by VE1PR04MB7327.eurprd04.prod.outlook.com (2603:10a6:800:1ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 09:16:47 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 09:16:47 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Fri,  8 Sep 2023 12:16:22 +0300
Message-Id: <20230908091624.20040-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908091624.20040-1-vlad.pruteanu@nxp.com>
References: <20230908091624.20040-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0040.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::9) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|VE1PR04MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: 320d144a-9bb2-43b3-1077-08dbb04c5375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWK06hInPcwUN5Ma3BUt2SGIoUHnvk+STVNHARjADBBhSLW7p16JLa9Q0SFV6MCoqh/luGxNSPLeNXUEzE0Cd0EIgbQ/kJcKkxVJuePPxh8Pw+UgEJmuv1uvd1dp1IA2lure+DJcb/MQ3GK8pCaHPFFohTgL394SlUq05Z37o37tuVui6e3IvnSAu2OFBW00d7v8IPeEsBi4wFV6e2CZsCcmHh5iYUM44LQ0OHg+ShjGvw5xSYL+0yLZ2GAUTR5cM+NCZoDYzfbGMvHJPiE6MWt+Khambs80PJ4HByRjHmlftXrLc0B5Pnw8wX1c1pdMQRgBSFnQ6uQ99wVrgjjJfrYdwqjc8BfkYXnz5MyXF9eWbK5mstgGvigXjwaynLuJPMtvXbk9HyxYldPqvukJgkD7/TaHU9BT1RdqRsyV1djEP34cKlLCnAYS4W3AwraPBOuV8u7c7clIhPQMUHrvxU6o1j0Hnk3vdg/Qo3XhTHNBaDSCigSWv3LgHL5BYtStrvqZJi+fiISwIuxTE7Z/U4m0m6oH/tyhonFDIPYgIFPQp/yPZkAIQD/OVF0ZY18wX6SUEXAEQKxNoGwJ8OJUiKnIsrsu4ZVrGt3NEyx3Irf9+ThThYfgFgCj273AbMEU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(1076003)(66476007)(66946007)(6916009)(316002)(66556008)(2906002)(4326008)(8936002)(44832011)(5660300002)(6666004)(83380400001)(8676002)(6506007)(52116002)(26005)(6486002)(41300700001)(6512007)(4744005)(478600001)(38350700002)(86362001)(2616005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z/AcNa6CMxQhpTZoePAj9ZKdcRFYBvQSiJuXgK1fNZ5Jgj7c4JD9BR987htI?=
 =?us-ascii?Q?4/AT6iXZTcOwZPKcKUZPKu0mmamTwJJ6Pbiz8P1PNo5B3vmS418ozh33Wy2b?=
 =?us-ascii?Q?hCwX9sd+9fuup3NAAWkzCDjnVc67CYGKkZPONbekGtDaWacm4AAueV4BD2pJ?=
 =?us-ascii?Q?5Ep4Y3Cym3xeIwaHO6Z2WFCwnWSU5s5T9b2is7OEP1zd6bmHOMtUN7zg/1ga?=
 =?us-ascii?Q?7l2TWZ7q2okwJLpLj9zvWrbCMs90wnABm4zWgnSC4XZX7v5h4UV+THr8hNIG?=
 =?us-ascii?Q?LhGQ8ccj5R+oBlo4t2xPky1ObdnZ36d2/3uszInIswgZGb0Of5NBelx6ZX47?=
 =?us-ascii?Q?vim1W8BAspTH7OwbwzV7cT9CK1bWhbyee9+3qRdPiZOogaZrF7hSnbNV1Iga?=
 =?us-ascii?Q?TCH5HRAu2GPzoUha5uIflXgvVFm71S6JeYF9QbcYGfToly4EPL0PTk1cbSOk?=
 =?us-ascii?Q?YTUb/fltP6i9RUTTAIKrv8ih8rUb1UQPe3sO23Ck5dV0kxI5zdiQm+pGL4mp?=
 =?us-ascii?Q?OBiWDfQvLsmNTPGEx93svFoUp8GWm/9CZ8fFAYkbswwD6e6YVjh5lS8oirvE?=
 =?us-ascii?Q?w0GVZIT3p7FsowuU5HByDgH/nk2vKwyTEG7d20EOGxkVFvcCcj0F2nbXQizU?=
 =?us-ascii?Q?LhvZCppnaOkoOOvFrHErg/ovAodAHJRakBFXIYIlcXCng0dLHjik88Tx+sUh?=
 =?us-ascii?Q?txYRiOsbKKrxT39WL3lYbd2pOZbZCaraWYFLSpwzMKKAIopuVeU25HSaTOPo?=
 =?us-ascii?Q?1gyDasiUdowXrYZtq/3JT72Noo+eofMCSBXeyoMheOI+U8Ig7oRSBlANJCWl?=
 =?us-ascii?Q?gnabTLIszJ/Cf+euHOc4hGrrsHqO7kZNxxxQ+gDtZj+prRTbvuiEbT6HtiQl?=
 =?us-ascii?Q?UJ2OzXoJFEL/usJZ8hk1RUHqpwIffRO98wdATEdLRExNGmow0pCjuc2lYFV2?=
 =?us-ascii?Q?3nBwWoAj8QbO+SNW67WXO+NTV9fdt443haSRC6HwibdoaBPTEuaL08XhpsRj?=
 =?us-ascii?Q?CmMlAW/lqJREVrq09klrwcdNPb2SYWiRtU70gc1oYO2tSaESqprSrclyE/Hx?=
 =?us-ascii?Q?N1CIrXx2iTDRNcJVQfrUj5gP6gNrNCj9goIUbqINYK7RLtiep7msHDr4pUyD?=
 =?us-ascii?Q?+fRcNQT/a8R0bgp54WCCinPq8HsD6Qu7OHQ2YvgTwIQDjvrwDybbm8BKg00j?=
 =?us-ascii?Q?69I4B39shWdeHoPtRTR9hd8diFXCB7ecqcobmiy5jRlhdePyD6QAZ8hoGiN+?=
 =?us-ascii?Q?qu+ug3mdt3HRFjjopU5H5NV3upAkzH7FA1lP4Uz3We9y+LVaqVDWsfPwojxk?=
 =?us-ascii?Q?9R05aAHh5FG/74fdOB6qJiSz88vNuIv20ALhf/Rj7gFmwOTQJzJo73fXJPhX?=
 =?us-ascii?Q?TD+ShN3M+v8mOeyAriEtcxykyu5jOp3h5g2chNea3d5y19j6o60JkV5/jWJt?=
 =?us-ascii?Q?5SgdDB09HQIrI8yzQf+AnqXTXQLgpdKy0J6g4umkOKLTjyIyOrqvUhHocQr2?=
 =?us-ascii?Q?aVQPFyHAomyvS5al3imwK6AOJQtix+g6M4hGdez1gRbQpefVxAhwSJTF6fzA?=
 =?us-ascii?Q?EAN1bVT8x5o5/X3gHYDsH1/D0OcQcKoWwEY7zj4oQ1CnmlI50Jg1Ap6uaUnV?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 320d144a-9bb2-43b3-1077-08dbb04c5375
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 09:16:46.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8m6/VEcKlzvGrG+POFTRgsZbFeFaZ8LMI9FFp5d385CZwv4MV1NZ0VrvmRxKEGAVJD80d+vVs5t/u9WN02mBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7327
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.

Signed-off-by: Vlad Pruteanu <vlad.pruteanu@nxp.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ec4dfc4c5749..f09c5812c247 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4264,7 +4264,7 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!iso_capable(hdev))
+	if (!cis_capable(hdev))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
-- 
2.34.1

