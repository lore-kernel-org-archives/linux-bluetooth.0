Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA0EE57EB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 09:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241948AbjIHJRS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbjIHJRQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 05:17:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379D51BFA
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 02:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmwfqsZyPZF33RqRI+zMUFOfd1y0C+V+Cf02mMEh5q1js4qUXcZmffPi2/L+2iNxCicy2cTFjVmvS9hyE5hqHX4s12pwE4SKPE+qA74WySlw1ze5Imhc3sdJiBLs7DYFmSuP0qf/dYIt3ywHK/mHe4qUglrDWKFNKvv1IVbgwZyPWHxcIseUcV47NxrnKDAoNLjNsZ+9XUX/Ej0ZUUAfT54DpXvEFn1uYFXilkmErP/x5ozi89xM+UT7U8ueDgLpWCcTNf6Lptaz+Vvksp9Mf/KerwApFVX39vdD90BSYw1xJW6JW8yPlRXau1APvG2zAFvxeonddQZCojO2UyMxcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bygBYp04AEMoMwx3cGrAkgGhk741sForvgCb2CfcWJY=;
 b=CPzEI6+A5KYvAROTWihuMJwFgXjbMRw+rvXId9AdYKXqua2TkjewLWmebKxWuaHoon6iDYftfzv1K5LHJ3bDf65gt+TxKGG8J9h/JZae+XIS1MfFpbfBy2r/pbvareHwxX3BeNp82EIT8CYnaiRhdsrAa/aoTu/p4Ga1VhofZNHB2i2iNJERXgoeB9Ce0AqsviVVEA+QBZ+XfVGqPvvJH6Z2F4nYtqyMJR42FNeoa3MxQEM28chZ5wmrlIMF2oZgomPrfzb4YDU97zi+DwRuesfBOgXYAlDOUoCz78nnQAQgR2SYMIJsxZsCFphBaABIGBzoLSxTZNd3zcyRDbDJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bygBYp04AEMoMwx3cGrAkgGhk741sForvgCb2CfcWJY=;
 b=O4awJy67R39hZXM5QizNoq/Rqzjfovdj/VeYnA9KCcl2uBojoSZSIktZsQM9acXQsQ6C2UN3qAXIA3SKLO6EXqj2WQoS462dcSyeH7wOwuoRxN4l4g/SSQbcrkujhMYmy4ubWoEk663pwwK9Z2Z7JiiVN4obWt3n1p903Nwezac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by VI1PR04MB6878.eurprd04.prod.outlook.com (2603:10a6:803:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Fri, 8 Sep
 2023 09:17:07 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 09:17:06 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Fri,  8 Sep 2023 12:16:24 +0300
Message-Id: <20230908091624.20040-4-vlad.pruteanu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|VI1PR04MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: d6c83a98-c25d-4fc1-69b2-08dbb04c5ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kFTwJp1ZeOl1mWDAARvpSA81ukDVOrr87vH/N0nSQFUh/3Dl66q4dkVsX16j88ztjBOfBqmepBPErObZa4qsct6BE15Mp/ds2ydZtp+1/NsH+On+Q9L/E/AQgZxoauFqtl6V0lDUcXQ1gpGPC0jmqqFicD9cAuhhvubHxG04ai/XxLgBWKlv3GVBy9dwT5thCbVsFsGHryJoyZZnyOYzqN0/y0EF2KwGcQQyTO/Gz2q6NswO2S+ABB2rsS3UGoIqB3WnM1jKGgqGsQ044YC96joQGF9nhzI071SWccup9DVbWhHg5IbeFcXExA4O4P7BICwt14Q3jdjGjBi4q5xNesh4KRqMvuP4M2d3XxTZ1m1+RRPdONIeBbZxnyQcYUyM49qGgXNtgu0HW1uqCgFLLWRC9vK0qGVdGVTDc/EpMs3Vud9JM20SiyY9l5aB1vuUqkIxfu6+aliJmeLVG7ki2G3EbmPW1tspL/2/4BaokDi4JswCB4rV0p6LL/J7wdmclLgO/aOeXIHbJN4NqTGTC0mnOEJXI7fFIXrp7u7vye5n5vlkYbmjcGQBOidKBYaTYuIR2EKqZ66kEkeZCBqBwsuQi5cOIgYAY/3ivq+cFB5CkwNnH5DKQe7f+FU/bkMU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(186009)(1800799009)(451199024)(66556008)(6506007)(2616005)(6486002)(478600001)(38100700002)(6666004)(1076003)(66946007)(66476007)(38350700002)(316002)(52116002)(4744005)(2906002)(6916009)(8676002)(8936002)(4326008)(6512007)(36756003)(86362001)(44832011)(83380400001)(5660300002)(41300700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVbbefN/wb9qVwI2Kh6kdjFPjL4Ndg+1NYUpSS++xRfqQpXPX/bkzBIRJY6d?=
 =?us-ascii?Q?wFqyZMnmxJOWBiqcA0kJ0Q13+ehLzeKVWVKq9vnUsY96eAJKMwPXYh+YAYTv?=
 =?us-ascii?Q?/MucNl4zJ981FZ8iHOt9UW8naPkgKoFZ50VEjPTXBVZXHfCmtHmzNdrjt71w?=
 =?us-ascii?Q?RaqLbcQhcPalc0n38re9cXCypDOBOAxb2FoHiKED8MxE/UrjKhLcSfUlxR31?=
 =?us-ascii?Q?jqYKOvYozDrw+anKBl5nOni1S4vr2cqP9p42Y4JXUsxs9YHZQquyfw6Vn/ed?=
 =?us-ascii?Q?lXAzco/XuUt0Mse5BI0+TxUOInsPDsSwY787306vncwSave5OPkrU6croTUU?=
 =?us-ascii?Q?Joo+TIgEnQQszVVT9nREt+Js9OdgtVRNoRa+w6G4EIonOxKVO+bmCdggY3wX?=
 =?us-ascii?Q?EgwDCqzlIPPj8ieszIY3TQvDIgP66X0J4nrGiDAbiQgW0HVVeXrK5YHx7VdQ?=
 =?us-ascii?Q?6AaiYI+WZOp6uX73SeNpqMMqj7Y5eO3d5NvEmgI7c2qu8bQ5gqYY44X5S2XN?=
 =?us-ascii?Q?GRqAI8LhWyeNJa1yGGbOzfzohK2GXY/znjL+WTKlQ+spp2Q+NMwsTYrfTODU?=
 =?us-ascii?Q?RENwFxpB7BaDFcd+9XCHENzXhcP6MxBXwWjzYFh7nPP18q+/jKSdcEedcL/z?=
 =?us-ascii?Q?jlC5w6PV8VZZW9W0Fy5+jpheth5R2Sr3jqGJ3ehr9UKelYoRoswsuNMMkcbu?=
 =?us-ascii?Q?apvYUbp4aYkpbFU+5QC766v9L93IX9qpX4xYJE+vWaJyvfdLPKrkaQeZ+eMs?=
 =?us-ascii?Q?ixJGgGQVeRz4/JefdrFx/QkP2tl18cgTt4WJv9a7jTams6RefhcWxQSuJfvy?=
 =?us-ascii?Q?8c46o4qWeIe6unfDNWKpQnB/s9IfhdXPEGW2SSTDa3lWSfBYQvUiKfXtBDQo?=
 =?us-ascii?Q?+p9oZPv8fEbtTJm4vZFs8HJfsGizGMUmRdsXrSrwQZlL643MO7vaPWAwIG/w?=
 =?us-ascii?Q?i6J52MN8jV6NMFt122WVoLBZGwP319HCtg+sOqNQAZbiVb58Q0rkPUtxBuru?=
 =?us-ascii?Q?S3Ddzlh00Df0jHG2v2k6UAMHecWxf52H9QbWgTww8D7JYCvMni/Ax3CsK8MA?=
 =?us-ascii?Q?PCWq6rL+PL3aqxWsD4/0I407yxOzPRYza/+UE9yW9PLuvrL04VdsfNxSdO6l?=
 =?us-ascii?Q?fpTp9WyyqfcHF9iTvALhxZwhhkzPnFVvOawVyUU6t/stsfSLI1c3Rmg7JCvA?=
 =?us-ascii?Q?CLPCK0P6GKmS7Ow8h443mys54L8RDLuOf4ucDO1Me+dek5ZaIdbuasQoboMI?=
 =?us-ascii?Q?DydB2ou55dWBXkdxPT4QIioSSyebN/r+/0nvUnbQjN55kRX4xaAF4N8/4W76?=
 =?us-ascii?Q?xloaB8aJUKAphGtxScsIyYISqUXTrKO+Rz+VaxLE0RP90qXYVoFB2K0LbyMW?=
 =?us-ascii?Q?2mHw2GsNHsqbizUtG04GT6ReY8wjn4vnpz2OhNgRDk7x41j0lUEeFEoCXxxf?=
 =?us-ascii?Q?k9eYdOIGtVVQykZ5IH/hrSmEwbSFFt9TMP/D4p2tTZ8imHDRHNDp11bhzf65?=
 =?us-ascii?Q?ihM+QrsnGTjxTHxTBzlGWVADtvUUh0H1gWX0RoGo1Hg5pzY5zg8zooz0gAON?=
 =?us-ascii?Q?RqgVB1BIJ294usA58aq6O/gtw8LIO3hGsZKAwLukap/4YA2i8upPuGx/tXoH?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c83a98-c25d-4fc1-69b2-08dbb04c5ed8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 09:17:06.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmH3oNq9mALgWL7Caz1M+msPPhwaR8psT2eIg5iPGAFk56t1UiluQSAADgfi85ZN3emhSNr0EBEnChLaS7DbKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6878
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.
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

