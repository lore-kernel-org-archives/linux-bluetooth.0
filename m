Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2BEC04A6A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 16:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbjHPQqb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344959AbjHPQq0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 12:46:26 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2054.outbound.protection.outlook.com [40.107.247.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DCC273B
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 09:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bn3Ic6dFS6YeiKlSosKkLPi6Ar/WjK+N1OgBXWaVyBmP/xISRYh4RjHM7A0HzzjyXhV5OoQ6hJX3Ejc09xXyoryvf/7hLynAgvwh2Vj6gx/YTAi5FZ4aO/7LfLZ+1Z2tjnL4uBHuTCChKCgaQ571ST3TLT4ENEJW24Xi8tBoL7/PvAOe/fxfKnCBQOe1ZWMS7OFYdnPs3RdAgoyQYLsu8Hsc09fldtGvNIkiYIYS0cePSBYuabxumY+J2IVH1gxFazY7tv43SSPFY5WXGzhANM6tQyIPnM4VeA/1Sy3Pdx+zOp0l8ZILpGkh4b0PzSiWbfrx71ehxFKdOLusXrd9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8CflWRguBHrm9ZvGzSA7EQQvh5p3bv3himHSc+dd28=;
 b=Fe/RjVIp0HdqU5R6G2gZpexR3ItdwgjwMS1NLqfVEqeoDXREodi2Pd28svyJI7DsATZ+xnufk3YswuWy2iFCcUtm6eBhiTl8DIHDKc1X7vjgl0AHwcIIer3y0YHsxfi7tuBn4w2c07AG5oypxQOZW3ENCtWEEtG7xqk8EXG6/nSsCTV8X9kENdf/uE8sI28jY0kraQFRiX4t62CfR22kNdmNswz0UMkhx1VtA4VQwEdCgF0jYLfRxpoV6lAa4NrDrVmjs/XNAbMW4kjsaBINaU31QUbPX4miqXywIxppOGG5vE7hqCn14RC60rdGrt0awreoUI4saHs2SlV+OBIZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8CflWRguBHrm9ZvGzSA7EQQvh5p3bv3himHSc+dd28=;
 b=hoSJtf1CtHiw3GLBfypDcP9aQ9zOjNI15/VvhSqsJqR3AWJXuylbwMorNeLiN2bHtNSkJ7zHPv8nncJfR817hiOiIZO7o9ubpFgqOfC+N3irp62JnX85rJYYIk9wf40FBSDxE1E08QVKNlSGrVkcb9v8ukRBob4n25HmHASO0MM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM0PR04MB7107.eurprd04.prod.outlook.com (2603:10a6:208:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 16:45:25 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 16:45:25 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v6 6/7] adapter: Fix UUID name advertised for bcast source
Date:   Wed, 16 Aug 2023 19:44:34 +0300
Message-Id: <20230816164435.5149-7-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816164435.5149-1-claudia.rosu@nxp.com>
References: <20230816164435.5149-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0047.eurprd03.prod.outlook.com
 (2603:10a6:803:118::36) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM0PR04MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c06ab5-dc43-4d44-f42f-08db9e7830c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jG7/mb65UiG5nuz5VjuipxRM/OVQ0MSv6n+i6uD/m75XZgVlQbwDWwZpgWtdx1v0zk5inFMLQg8BcRIMNGgYWzfD3DY1AmF5swBMw0nXClsa0tlEmovcnFgSZzZrYnccdE6ZGPMHKhoE/Of85s2PeCLj3nAQI2+WAwYG29pN8nhW37H6z4/uVCtiyPuDQMKsIOQEjK+vHaT7HunuKap3Ud9+M8Bs80fSorwFK+/f7X9ym5tbCN+vm+KMHrxAMlUuAu/bQfBDYKpn6f7SgFutvhHZXMMmbbqCyLry4//93od8Ve3jCS7oOTr3EEoHYkBInBawiKPzY6AL2Ag9taud+MsD+lKVq5ZCd3mgo8kQnotJ+mOOXzjSCpt32Ysx6XZnVwwfsLnG2SSwxuYUyLswUzHEmP+jAYk/T4u1WFUzqJpxfVH6JuVuIp2XGAvCqQ08ME9VmaKRtpprmXv33bnpeSo8MJW7oQWq8aX4+THhi/8FpB3n2y8ESL/NH+qNpEQcM2UJM4V2WO4fZ9bXw3uXSv2KJvSlU+S2JiBTQq6+kTmzTw1p+5cRmThWkumT07oQnBy9AujYZ45BjzRogGNINrv4nGNavdc5vzkRoiqUVxRN+NpcmvqRfHQvSidymMFG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38350700002)(38100700002)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(478600001)(86362001)(6512007)(52116002)(6506007)(36756003)(6666004)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GPkCknWsAaaM5KGg2NkGtHQs9pOGFg0WgZEtNC9i4LHPwNC91q/LguAgy+ou?=
 =?us-ascii?Q?o7CBvuLO7coRWABmCPpAbWJeysp5KTyFbTSPSBcZl3dBuCIEYZSUaSq7nBxQ?=
 =?us-ascii?Q?zIjhKqHeUR1DH5hubBCNhxnky/LemKpmk+iSeh0Ag7v+3hlUq4WvShetHX2A?=
 =?us-ascii?Q?l0zO5oinhBa7qtIf3frdZPJVh4HisRUlOfUzvAVRt6XluxYYAzlWcw2XOmu/?=
 =?us-ascii?Q?JIf4rNJp7hSIYpqHrHchCtDWGKjcybEpJR/Btg+iLJ1Wk3HnhVR0hET4vOdZ?=
 =?us-ascii?Q?mq+bDn/hqs90JBmCRLSUalWuROsElUm6D2Q9CsRiJmAqoecabc/D0A4R8ekj?=
 =?us-ascii?Q?7M2isWdZO7JQ0gj8X/Y2rqQFfBKRg7atHHWMlc5XHToy3+Qg/a8q6CXtfz5p?=
 =?us-ascii?Q?oIWJggwlpTv+0W00BJ5rOIjYOKu9w8HOZUl/3zMTRiD3hiTHyXxjFmrJ67+p?=
 =?us-ascii?Q?hcRqG78sKtqbDobCQ1eSPBW/04x2knPHpjbgcEPESLnHdEKp0vPtbplHPiSE?=
 =?us-ascii?Q?7Gfvo1Ma8F8MHYOsT3bbAn+fKa+N0n0nXUn8BMUF4zXe6mTClcG9VNGCwLAe?=
 =?us-ascii?Q?w4UepbbyEV11/m+Zwbt9fdfPc+lzYURrKx4auN5qIFF3rRQGKNbEKiZF+wUW?=
 =?us-ascii?Q?lsn8QnNtm6DzChXSF+obJtbd4TiX02ppy6swVXkgSfFhchUUlDpNTFfSDG1P?=
 =?us-ascii?Q?UHANSJwPVpn8gk7BsPxwpG1hFUDb/PWAXFpZ7GgHaATmYlEEifGYt6ywh4dQ?=
 =?us-ascii?Q?FhqLCGh90rxRkbTS8YReYV0Q7TZwOx2Erh+jN0Rx6AwnAajat9qljGY0JuUg?=
 =?us-ascii?Q?28/Yzua35IvrqTM2nlNgYSFCzqrLwxUerGHc4ENsfJHWzchaddsWHEXajrKY?=
 =?us-ascii?Q?xiGcQq/DCa2eTymPBTrdx78fiSsZHy65CmAb1+jUxhGcffb3Ps6fpzNiYOih?=
 =?us-ascii?Q?LwquB2amIzUUhvLuGbfEW6/zftUxRlppMN++pOKid73UltFYdVnmf8XK7Yg8?=
 =?us-ascii?Q?PHxas6c/9v5cJln+GLG5Cv73xNUJ2WNh6X6sHx9lqaxjxaDH1EruzpM5kp8k?=
 =?us-ascii?Q?LX1nYyXPyvD7WJW/0xVqWzMNLa1m/pbkk364xXE2eaxOYmgajt95fcGgXzh3?=
 =?us-ascii?Q?No36logwAygt9ffV4QWrWLcThxjz7BPZw/EITEs1ImDykHgCqWloAmN+z1Qc?=
 =?us-ascii?Q?nkpwjiHmoUI0cYEdz0CDtYTPcV6hhC+KdeFrqxXSt4Azzp+f7JcyzCA3/91s?=
 =?us-ascii?Q?dmN5v+2Y8Tkg5+qK+IP+gB2DT1qVFI8Asons36ARKc2Uh48YQmY5pC1YIpuG?=
 =?us-ascii?Q?EDbA+UuxS0txsCdU/5/oZqnkQzZI6+SrpBIevUGCcm/rW/HeOf82e9/PXW5b?=
 =?us-ascii?Q?aOy1WQ1OLlhumMxKXTaNViW/P3wFrKz9J/XktB9wSADaAo0xuAhrrmt8uOM8?=
 =?us-ascii?Q?p6PkPvWW6bfStGfsCnJvAFJXiKpqxrie5cvT7T6ldcQqSQyHb3GZ2IHfdpfF?=
 =?us-ascii?Q?IjhQnPqXbpuXULdgxASW0YfbMbqiIpZSd3XPqmf3jUtQgcC7GsB3ZDG8nhst?=
 =?us-ascii?Q?Fw2uNPWhBo2zfAx7cJpGVaSkymXTEvPh8VoP6f7Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c06ab5-dc43-4d44-f42f-08db9e7830c5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 16:45:25.6871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP1fgZTPTiNLOwteCf/7yjysVtpPcH5D+t0zjyMOraiE3IEiNyo22ydmVq6jyOKcqs8co5hnaswN1b4llW0aKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7107
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix UUID name typo.
---
 src/adapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 004062e7c..f2f53d339 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7155,7 +7155,7 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 		/* Monitor Devices advertising Broadcast Announcements if the
 		 * adapter is capable of synchronizing to it.
 		 */
-		if (eir_get_service_data(&eir_data, BAA_SERVICE_UUID) &&
+		if (eir_get_service_data(&eir_data, BCAA_SERVICE_UUID) &&
 				btd_adapter_has_settings(adapter,
 				MGMT_SETTING_ISO_SYNC_RECEIVER))
 			monitoring = true;
-- 
2.34.1

