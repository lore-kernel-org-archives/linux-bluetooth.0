Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE5DEE49A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236489AbjHUPwD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHUPwC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:52:02 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE672F1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rz+oGoSecN/KFcn6vy/yC76nmAWeCKGjorV+KYwEEHF1+BMUG5Xie4cLDZhL0Et7gwfoDLG0gzKEFcDpiMvxTXdv+SYHE2Iuf7W8ToLRVIHZXyEzc9B1FKYaeR/R3dTS08rX0Yx8Zv36lPoQYt18mstPrY+35x3nVvl1+Yq0qc51LrisSfjEc3H2x1lRjQGA49CKGmmwOsztYYJgwRFEGxvFoiz4Vm/u1yAoof5N9QK3YNSHjkgtdIbqRUJcRHyA5zW8sLb69gqLn2+kpYNpe7QZJr/xjP7UBNpN6XV3SsGnsHhmUiNtub+QB2w3+BeYGoU5jlLYolggoXsf2hqjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqjJ2ajp34cp4Rrzia79nTVqyNroqrDQQkYBHZpCfcI=;
 b=Lx8T+UdEfCs7J2EhiAFsFNlS3WFj1DMiUhw86Ogu4M7c3Rpepf3xs2OyHmabPR6rdGTkmDaHr6+t3VlkptXsEoyyei9O4mIl21dM6umDRalhyJbUhUwuJlg1NDdvQ/ezzyPkVsuq3gDnXuCloUdLdODVZ3FvyM68CXSCdVGNDL0Q/fUjudqQW4zFyuNGD2ikWGjS34rOh3EniskXW+8ecN56346ypxC1QomUaV3A5zTTAW/oZzjORrgNyElgDEB2e3ep2V/Pr+z8pXzs7+OwkFEMHbtY6zNJr/0HIQbtOWjq+DcfVfikg9qlyzIJvbxSdR+MXJZ5+cVRf6bLysW2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqjJ2ajp34cp4Rrzia79nTVqyNroqrDQQkYBHZpCfcI=;
 b=j0v3rLvL6udbo8qvaNELF7yXiU124ALH07GDI7C8SOzFp5Jxu9VSL8dVGWI8DifUq2NmEJxaGKqR04olyjXju6LiZnOq02mNyk5WejRq4OJ/DtY1S+ON8LsxED3h+eOG3rQscJl6vdsBnHHp2FJ18E5OEHlCNisYWCY8xbvQ17M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB9116.eurprd04.prod.outlook.com (2603:10a6:10:2f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 15:51:46 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:51:46 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v7 6/6] adapter: Fix UUID name advertised for bcast source
Date:   Mon, 21 Aug 2023 18:51:04 +0300
Message-Id: <20230821155104.86954-7-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821155104.86954-1-claudia.rosu@nxp.com>
References: <20230821155104.86954-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbef80a-4d95-4745-7a26-08dba25e85b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0WB21GJeZT2PSqA9v0190+cf+fznQ5ZMCXN7sexikqiiOwDKdECVUhZvGoUu96Eik38ttJWK0TSn2lQHvEpV4i/cF4GnH6pYKnUqF5kmw9epDp5r8GJFj8fxlHrOp8hVIDhU3frstT8uPPcruGmbKC4cuZjtuuVIj/dKS2aBKcEDAkM9yz6D8q62MKp6LJgnnbDbLNFfcOAYumueqSEe6CIuVJbEcdptfHAcNZW7/CTQ3rHIuEt1MWaW9aTub5OJ5ODC/gabVcA09YjXGg+JG7rxQXDp9vdhvLqi+ICvsh8zyo44wRKYk4MUt6GCo+ngvj6lQqcIVaCZT6WN1CmRWxZSKj4CEVS8IX1rFBvhQFuUW9p7kMD23lfPsb21imWNoazLtYdVVNl9HuT+DgO7i7n6795JD9au/YZJNmC8EOGktvPREZPeQcHoS57vxKLpgKAsXvWyJ3fVlg7abypKU1zdChy6tXmfd+zhvkKqB8D+HZd0aVqE5rgrEQFDZUXML3/pFW4hqBdgXLjX2O6//07/Lv0/w0MM9y94kGGp+DblJXYUDJTgFtXbRMvGYcPRyhQXEY8IwXtXoDcbcZc9f17LZHF1kR7aGSkqPqutnoJwaGYQzUewUjt6Ou9dxOc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(4744005)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?01e9U7Hq999lFnWvIlRQjgJS2Nbn6aPic+/vc3RgjJp5+7CZiJljv9ZPbgEF?=
 =?us-ascii?Q?wP50Sg/fCRzPhKFlJ5iwIxWUTl1Wsyq4FW7fEyyS4ZJrVD2O/WiXSewPF4eR?=
 =?us-ascii?Q?xR8TOSNl+tm03V5HWiRhQjAAhAytBh7nTzcI/aRdfgsnhM/Qe5AZxXTdqqFz?=
 =?us-ascii?Q?0BRjYBzBx9h2dO5gBWCCx3TN8mL5zwp7e5IJL915V4loj7Jvu9fggE1W5fnn?=
 =?us-ascii?Q?yRpknS8AjOG7BHtC1CGz/x+eXjgAtDITMscdoptSKxnb9J2g6AbPc+CqrEv7?=
 =?us-ascii?Q?ntXIQf0Web2+0qCXX4hJYKkXioIYESGvaUlaFXDcBW4G+G31mEbA7EvaIaiQ?=
 =?us-ascii?Q?rGRXPg913AnF0RhLPY0txI25lKcbJJ0PYBT8NyARg85n9BsEUULIxt3xsrsU?=
 =?us-ascii?Q?Ferv9WjOaWXqlRlK4bxslrNYeNy/0iJW3I2QYWRsM0wMeWXCAic6ElLynysf?=
 =?us-ascii?Q?wYLVJ5f9k85D7Lo/szsZiwqnwGWnRrwwHDjx3pRSZxa3IVnFe+IR5fMAhhpT?=
 =?us-ascii?Q?+dkHRcGC8EZLGEXx5sWRx5aBD3AhoX2g5FJHoVJCSqTn6XY/Yr9Zt1Ya1l/p?=
 =?us-ascii?Q?lETd4rq20sn1RDPLmCy7P/dTsqT93EpxyvLMMLpHbNOfPGLRfqT5wRyhoynT?=
 =?us-ascii?Q?AVAjzXzHQoQydA+3MmCy/tD+BjT4+HZnj8mp6qi42q5aZcavXDPOTEtA6vqm?=
 =?us-ascii?Q?o5t7X3rGGLIJIpn+2SN6C/na4p7vCsCspIFcz4wX3C+CsZI6vZQFO5SSakKM?=
 =?us-ascii?Q?B68IyoweysOpRoK+ZpX6xjDAcDLJ4GANvYaAN8tcFFgCaXPgHTXlLgJEyNUF?=
 =?us-ascii?Q?M/YtLLnbE2+8TwmPF2wix23bQePJEEoVrMUvdm1LXlzZp0d0jHMVh6Y9lzmv?=
 =?us-ascii?Q?LfWr+bOKyx4ZkaDywxLE21JKqt7ueZddNG4WFAJlOqTzNBR3pCNYOuaAAHAI?=
 =?us-ascii?Q?q2knvZ31VsjyFFCl3gLPtDleFOd6m+f2+843OkTH+F+ZpZom+qujUi4XrCQ0?=
 =?us-ascii?Q?eb39EpPcgAHLJTXH27i/U5Ry54lYiiHR+p3VqId8lPhBKgonB17QCSDlI0on?=
 =?us-ascii?Q?LHpn6sv2ShWzKXE7uwmnR7afJie7uhkcdHIna7dG4ro0NCRhKMWy7gfqreRs?=
 =?us-ascii?Q?dFOWVP4fSPJT42knSXFaPFlKhd++hYGzTWff/HOI+a11tuS587CXx0kEEfAM?=
 =?us-ascii?Q?2IEERkkFspUB1w+DXc0J5s3tcdc9ko+SH/yxuJJiMDvnym4mi3Y9t+WzCgEz?=
 =?us-ascii?Q?5+/3JEoXcoS6/qkvgCzOO6A9pKhBbDuOs5EvaSzXQz05a5CzJF8OU9Y9rfrZ?=
 =?us-ascii?Q?kp9IK2634l+c7SPvDfHmR7iH8kmqBmsQESCmjqV0QcGqzms8m3d4PzQeyNBW?=
 =?us-ascii?Q?ZUOT0fUAfkTR2k4Hjlx+k5uO6rm2BiAvUOt5oIiUe9Il/1yGGb79fjk5a+Rf?=
 =?us-ascii?Q?vA8rrkBlZb+RH5T4Ky+jpRldLH6Kl27MxnJZWoj1Q0lT1WamsjrSHzb3I0Kz?=
 =?us-ascii?Q?/cDc0sjM5NuW/VXCM3ctAItVn+kdJAzSshoTqJZi8tlqUHEYICt9YL3ZJZwG?=
 =?us-ascii?Q?R9SfH6fgdU9NEJrrrrAQn+/C7v3IjozqMfdawg6pWdfhbX2upxUAQpXxysjv?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbef80a-4d95-4745-7a26-08dba25e85b0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:51:45.8595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZQOFQYLrW6FO5OiKq56NbHJDTbfEi3qQTs/bICaCUYdgwuSv8JlcmwTbAXoxYZZUisVmb9RXxceT/fGAlZ7IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9116
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

