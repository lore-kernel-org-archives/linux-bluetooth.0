Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB08C0015E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 13:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGYNsV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjGYNsP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 09:48:15 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2052.outbound.protection.outlook.com [40.107.15.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C8DA1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 06:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtHt7o+peW5kW9PCJ+ylq8jEIwQcZopKYdFeJZJf4bC4C0VGjDlELgkhkI+GWJ7h7hQN4O/232EEghugFYObg9ueIBMskV+JVXcZOQgycOrF3i5ujLO7yjLlPXzgK1RGQNzzrMjO9fc/ZWsyzQWBigG9wqS6PwOg7LuPT1locyLXmF6+IZxatuBpGTzsX9vaNkYva2J8t3MFb6v5KpLvIGUrxx95XF+lEMeXu9N25u0BFzDJtCuV8qX+tSmMn4sB9V1HVNWAZ4Cq4gkCr/xc8xQ3AlzkZVfMAPAjv7U2EqnaW3IUE4TSFSOEnT6jQ+CprM7ag9VcPOt0LmLtJbTqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2o9oMMTBRzrlvzvqRH03A06HPrm1knS7PpN3p1pbOs=;
 b=kyPPz9DcZOXGZQNOLepLxJl/nEEhnlHChnR++nXDgZKmB2xnw8v+m4P9FFd9aD5QL6u1ZJ+zUYVUOvXc2wzezCU9mI6+wlnC3y7MQ/zX5B6ShSjrthKdHSWSGWGzYHMADJS1b6io//fJmFMsmBK1baDhuOTLhqcj07w9O4+aLx1FMMoIayteei35NBkT+1se7qfBGE7QiudRKUekvnObEKz8LNC/n3vPlaCFvItJ7ZfORy911axhVODC/Yd3+im5GE6tKbLABNci5UXVWbryTz3qTorRsEvackN3elXSCCoEQVMxniENhrCc8pd9rH+n4VRZLuNeTExZpZ34WnMQAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2o9oMMTBRzrlvzvqRH03A06HPrm1knS7PpN3p1pbOs=;
 b=Ad/W2ujch3L6HFyB1iKTvfwswoPFmvwkTqSatDJCbu/rJyuc0Qs/jAaxFWDPwZ7YZYQFf9E28qerWklEfvnpMkgjzDbJHOseNjnNLVNu2GEbypWPXl/2zIbLD9ESSNdboB5CASBuTAqMtiZsRfcw4MA1Z8Vm1MD1g4/EH4iQ6KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:48:12 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:48:11 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v4 3/3] shared/vcp: Reserve one more handle in VCS for VOCS
Date:   Tue, 25 Jul 2023 16:47:42 +0300
Message-Id: <20230725134742.51651-4-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725134742.51651-1-nitin.jadhav@nxp.com>
References: <20230725134742.51651-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::8) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: 834ec679-f3c7-4de4-38ab-08db8d15c989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyghHJM+x7in9nwntfK/t0Y1acEDqqZ7MH6VKJl/eMxAHJMnDPiCpznJvVDLTdTjTFv1I17HjvaoklysNzJP51E3frP53cw1Q5oKB3bkFc3nhAlmVATBgeodejC0Vdfh+I3eUU/fARj2xib8PUlGPimrujK2OvpFUmH4gcXzX2SCibonSk8cOwzOXzSnL+i3jvcnNYeJLl69hM/Gtw0yZoHRL/8ICDvlc9zkVR1rvDdNNfFGUnmibVhCqCslHmJYovi6nZdpp6uYS0WJgPsIrQQzEgsqRpzEh9ZQqJba4XQtNYhm9J3UpByXa0D2d5DKWc5LrnUQEbcPBjeYYUuYquQdMbqzP066de1I1is3h5BdvGc9p8QPOx9Aqfc5q13IO70XIfGIOlvt91tmXd6BWlJdNh7b5nl4+jjtT4fUFUEmJt1DwrV00VbF7b8fOrsElZZbOJDX3gaOT+jHt7sdhBYVkzjAKgyoTDHlrbR7O/WsmBopWzOLaALCkH/JAF+4Trq1WUgIoap7B6XI7C7s9Jn3d2UtllkU0YACDtHOJQXSl2RM84wD4235J8NBpZufm+TtgZtEeIut3cGVz2WqCHtTWgPunB3UkWdhb2LA3HNi1etexSuVpVRRfW1AUUZM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(86362001)(2906002)(52116002)(4744005)(478600001)(38100700002)(38350700002)(186003)(1076003)(26005)(2616005)(6506007)(55236004)(5660300002)(8676002)(41300700001)(6666004)(6512007)(44832011)(66946007)(6486002)(66476007)(4326008)(83380400001)(316002)(66556008)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lRvVmE+qFUkDjHZckEwRfGsoVBy0WEZNaC5LKoaDStDLXj4bJvqQmww2Wraj?=
 =?us-ascii?Q?Cnp6Ng0LP2apoggGO1lI1uBffdlTCNbbWSemPEzkmLTJe4I6YMo46/BumAGV?=
 =?us-ascii?Q?PRZKRL0JFIoPSPeq1b3JeRmg6WtxKwrmlwhOZORFkAMQNv+VdqC0QLfXhZNR?=
 =?us-ascii?Q?mSyjvX1mAaDu1KzCxZrgCkxkTkpeNXq49ivmVtZbvtDpJTTDcMW61+RGcJJW?=
 =?us-ascii?Q?sRl3tSjGKTsypr/oc+GFNcdiYqQEJBq28Um25o7i4bg2Y2dz2yYQrgC908kV?=
 =?us-ascii?Q?+E58ynzGjDPjBMK4V+rpCOvSuY040GRbbOD/Ul1jxIAxt/wYIwctn+sDBCXR?=
 =?us-ascii?Q?7V5TVjUgFgFfvIC13TctstswEeql8BOiUwGa7l538ZNu1oXvGUt65tcBjavB?=
 =?us-ascii?Q?JXbpP7yylZmYZbML2dwQFcjn9aEEE91CY/mZ4soX+CGpuru/aPI0EBDAlW1O?=
 =?us-ascii?Q?pzZWrIWlT3r2aFDxeKhS0bCf5v0HuCIveRu7Stw/AaDhVC0WbH9T5IJxxlYZ?=
 =?us-ascii?Q?TZyvtA0lwg8yfO9N4nqa/uDGGcPDebkAm58D6J16Dz9Azmnh55OpleQLQb/n?=
 =?us-ascii?Q?Dgi752IionqQJnarGU2oUecLHhlyGWW+VdAAtoXjM0MRMgY1rm24jfArzmaS?=
 =?us-ascii?Q?19QfQnSgBJjAworBk8fOjRfz74eopvx13KIN2dGuHIW0eExIJubs7g1O+Gjw?=
 =?us-ascii?Q?lXQnYUkcz5NGScn/P54DV70BsNChEcs+FEH52e+m+apDneFHKNrqlbm/XvgB?=
 =?us-ascii?Q?ldvJFsSeAETAXKUFSZtxomZAf89fWcrmRp3d91Lr+3CKkEqeP5f4upF+fSVf?=
 =?us-ascii?Q?J9fQKiR/BnjaZKnqD3ynsFVW2ZnEk59TnmuK67XxNjncgnC/14Rn7ZaaFB5N?=
 =?us-ascii?Q?o3P12avRnwZqCrDQZiZskAjevwP4W0799YaA0C5bf8EBg0cdpjzlohyZcGfM?=
 =?us-ascii?Q?EIZFHZwZ9JVqdcoQdOO15k/Mqx3wM4Q/KjojJmIwVXkFljNVyyPHXSmA02xJ?=
 =?us-ascii?Q?3TiCsgrH/lFStOdF6xkce6HlGYbTU6/6HG/JT/TyAKhQqTLIxTcLxdeje5ui?=
 =?us-ascii?Q?NGvknpOh7gRM/n2QOIfZAzFgSQUfw1N4J1qJhRMz3UnJMlo2U0kSMz5l9c5c?=
 =?us-ascii?Q?Dpt7DEz6Ny5QkIb0dD/aXN0YRkeJwDvB8V78qO5EtqZ3IAMyKE48DAjJYIor?=
 =?us-ascii?Q?sOfxgeuyH7OY7kTmFT/Yn2hddNS1AKdc50Wwsgo78CE0+jPiCkndN2LFwLU8?=
 =?us-ascii?Q?iCW+m3Zq3BZP3aqJSI31TET+nBdfSob6xemXPZqiyfDLki4w4J0HwbiXrA/+?=
 =?us-ascii?Q?lFdY3VS3UGru7nbD965PUrVIUgKyc5oUHwXBxKST5FbXmpou/RSpug2vy1RN?=
 =?us-ascii?Q?dk3LKrFol5zW2yvRB9ieURKUWKAr3Uvkgo1EHrY2oZHKQOTfghjQbMg8dTZu?=
 =?us-ascii?Q?GUVGtWTdb8+WeyadqyBkoLm2AX+zy2ZJVcFBiy0VEGKx6ACUpP9F2uVaWfEo?=
 =?us-ascii?Q?+UT0oJ+ryOyeJfj9UaESwtnjZHkynNoIqDxFBuMVWReTDO0aUAkLDomfHdK+?=
 =?us-ascii?Q?TDh4haGKik77KvoAGecVCQTpF7KQRgwKJ6uaLNt4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834ec679-f3c7-4de4-38ab-08db8d15c989
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:48:11.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSD7gJh2eITAQUWwrREYIlwiHjKzLS2UKu/OpMIcb7a12jk1KoeYBBI0N+YnmkpqEv25o+lmYkxV47rwbzSIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix: As per specs, VOCS is a secondary service;
hence it should be included under a primary service VCS.
The current number of handles is increased to accommodate the
included service
---
 src/shared/vcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 0408531b2..263da4c30 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -998,7 +998,7 @@ static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 
 	/* Populate DB with VCS attributes */
 	bt_uuid16_create(&uuid, VCS_UUID);
-	vcs->service = gatt_db_add_service(db, &uuid, true, 9);
+	vcs->service = gatt_db_add_service(db, &uuid, true, 10);
 	gatt_db_service_add_included(vcs->service, vdb->vocs->service);
 	gatt_db_service_set_active(vdb->vocs->service, true);
 
-- 
2.34.1

