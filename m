Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31999EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 06:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjGDGCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 02:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGDGCN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 02:02:13 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2069.outbound.protection.outlook.com [40.107.241.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB90E52
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 23:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/+HoubBdukrW4qoEp5lap7qvLG0bhoV839VUDj8JFgCWx92ihNMyZcKE709S8yHomevnhUYESyljIRH+7y0GygDJaLT8t9mrF1i2Seqh14t5vc0/PXniBNNuMbA3HCQvgCIQ25h0ee5ne4lLyxethc5k6OIVzOX231do+qqvU2IpCt2WXAY6Tl6YVk+4eKUD5U5WrnTITTSb8PbYFGi1j81yVP44Fh7pho9EZ9dOHfEfw6QeMmHjMrkOaFQld3KjXhwgclxxx6qZ0nypXsuVL9FluUeV+3TrY2KyZB6q1nxZW8NT3RW8IUje84lvd4neW/GbgCsZZXZIBHEEb05KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBF1VroD3jsEVkJ9BAxHjMTFuiLCI+HOOq/CSmA+DxY=;
 b=MZdo84dL886Y/DiV6nVG+kDvhNabQPW9el2tSaxm+5TDfpJz3K9435Oc/yZFvyrIfUWQ6KVfM9nlU0OmOdCnmIGvqFOAAVTBi3FeWde4MScZd/YmPvGu/CWfuBFhtbGA5b4QATgaGkyVURzx25oOFwrgVubETkQ4eL1LsdK/JBFa3JcQbwGZt0MWU8tY9qqtv11rhOyLbfjgLOAwI+F5xlr+e9D7/9pItOkj4rbYKswxmRMTDkyHr6D9xAt80vTLEgTOdwICpMrWFD+YVj+RoEylvxBi6pqNZ9H18PkCyQtu9z8q07R//NB6XLyu/Qgrkj+0gA0DzcYndBUBZnHY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBF1VroD3jsEVkJ9BAxHjMTFuiLCI+HOOq/CSmA+DxY=;
 b=JbEl0sscjANcuEGfdVwFpzQ/HYHGP9OlonTxC9GTjGtmPWTPHQw5ca8AiVKdbKD+RlgmaIOp4Nz7jQY95BPVW/ZCBDM48bN+3eo/M3OyZlbbz4L8UIFJ/DR/tqT5fywaow/THKQxgh+ojUaGPNVBfS/3q2y3b60MTmt8Zo58Iz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2919.eurprd04.prod.outlook.com (2603:10a6:4:9b::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 06:02:09 +0000
Received: from DB6PR0402MB2919.eurprd04.prod.outlook.com
 ([fe80::dc24:7fb0:d2f4:6be6]) by DB6PR0402MB2919.eurprd04.prod.outlook.com
 ([fe80::dc24:7fb0:d2f4:6be6%8]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 06:02:09 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] plugins/admin: Fix heap-use-after-free when using 2 controllers
Date:   Tue,  4 Jul 2023 08:56:43 +0300
Message-Id: <20230704055643.296260-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704055643.296260-1-vlad.pruteanu@nxp.com>
References: <20230704055643.296260-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::12) To DB6PR0402MB2919.eurprd04.prod.outlook.com
 (2603:10a6:4:9b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2919:EE_|PR3PR04MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: a19e02da-4feb-443e-7227-08db7c543408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzBkHJX2HuNbByimJT3iz/DyZWyYTEFQ7Az1asaDyT2JyAgH/QqkvQEFWr6sPIrTKDqnXE8+97Y49hJdthBsKLuEV6LVvcHFwgKXs9F3tFeqW5Zp9AZnSHat3YembjhQUCam2TxSti7cru8/aXFd9EL0f1p+SoYElQ4iXwb4HwAOcduu7W7RovMiMSig5VlvPrDpgfBE6mDy37F+TX0pxgqDqmL86nLeJ0j3q7ypNQ6qmHVCQXvGKMDc7WpWNrZwLlY8yW8bJL5f+wsZ9bpUuawrtSmzkrjX1OUAIxYIflS8SpE3csOhZfSmrnkXVD5i+3kiPrDD8KWRfo84oXJgUTchKuwi1k2HI72Sklrpv5PFwjoOxjMsNWk/LewQS7W3cRlyVaqqzxuuA9lpjHfqZ4UoRIBuXMVK2g1J++l/afLbU5B8Hjfqz0+RpYJ1wdd+D2I2MaBG4yAr3qtcxzi/001rCinoFU/CjzyHgqplUkon0yuSvdvCtN7CgF1kIAE/eK9NbwBy+gynkmekO3bwlHZemovQ+8Px1NsVYWjLLkmvUL9fqAs90FdM6VHPsto1Bk2G4eXMzqyqj5pTAMBWFvGaSdkUOyQKlQNqI0cua8wdOPa3kh4/RQ3s6Gua7KUk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(316002)(41300700001)(6486002)(52116002)(6512007)(26005)(83380400001)(186003)(6506007)(1076003)(2616005)(38350700002)(6666004)(478600001)(38100700002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(5660300002)(86362001)(2906002)(8676002)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kc2VDc5lnFqCAd/TtqmH1YtUeFkzDp5x1FXJnqEMY6SDFcQ3HU2raWvknhrp?=
 =?us-ascii?Q?OF1o6NBllkA1Wt7F279vD2o8CpkBb0jbCulW+kv9aMa9npG8iExowRFLu/3J?=
 =?us-ascii?Q?m4TZxPtmSW3t4A9CznQEDM8I8ddbxmvusvQRYeWSw7USBaJkXGTtHJSZXNGR?=
 =?us-ascii?Q?vk1zNBozs8XFWO6zpC6Vww+rZdKapkcimuiXSU0asrUBi+lQoarXbU7dfeXS?=
 =?us-ascii?Q?cIilkUms6bcR4FV26pxE1rYI0HUqnrt56KWNsaidVOffHRXmRENTFc1MxvRF?=
 =?us-ascii?Q?EO2ml69Je/9Y4LIjXQrQQFobJgRRwuoSxhT4p9Uy2GXa7T3NymZu8Tk7d8h2?=
 =?us-ascii?Q?Yj42BTWRPCME4xD6P/tbOnyPOhUXqTtbCLFe25no1ZF1jjdOG3xjl+BfTauP?=
 =?us-ascii?Q?aaLKc0fDLZ529IAQhbDCNrQL/726yb5OCLIKrugYib4e5UVqW4PaLqrWHNnd?=
 =?us-ascii?Q?CCWMFhFWzwIFCuelqqIP0HU8FtM7NfJY3c+mv8JifPikwnSN3KtfUL+Y04Cg?=
 =?us-ascii?Q?3GKFe3Zks+TGtYyY9KbztPZjYorzslNTcDltgOX4HFkwJx5kdID0bjjurp84?=
 =?us-ascii?Q?O/l+vTQ948Xwq8Mlopo4n87Bqd2pvfssboEmm0s+nSe6Zh/ilPCwG/2S9mVB?=
 =?us-ascii?Q?4FA+uVhSct+gX1QoO+mR1HZyfgg73IX0SecPo0hABoTXcrvGurJbbyQK7zQZ?=
 =?us-ascii?Q?w5J61R0NIC2oeCKtl3kfS6IewwMbts1MgzEo83vhg1pqrxmi/hVzHgBUeVvM?=
 =?us-ascii?Q?0QVarBSs7wFwHDEbeso79RNjWfNtRa3eE65fPjLeAGZ84ElvAq7SYCiuN/cW?=
 =?us-ascii?Q?GwVylJH6hbysXDYufT0IxnofGJ6nYjkPjw0HOuiI8FoYE8sA0GyMiL98iKjZ?=
 =?us-ascii?Q?7cyOllYORJmhQha0QirU6mtcV6f7Ele9nmSzmYWcwXjYU6h3mCvh3DLLqh4f?=
 =?us-ascii?Q?iZo0IkcnWPXl0zurMQZtd6TTL73sHOmXfhgE2XD0bZ8RYEmQF2DPvDcs+U86?=
 =?us-ascii?Q?EDjjxF7k1z/ZJyG+8cMqFv45lPxcgVuKYr6q0FsGYcpfJPXAnxk7rG6hvhd4?=
 =?us-ascii?Q?FH9DRdTWI/LZYx6NnRF/+k8n+/yH/wdGhEtJEOX1wGtPRAAmKFrYZLF0LRfb?=
 =?us-ascii?Q?ljX964AUk7+3xvHrBPRgi7PFeFjfor3d86yeLYQAhObF/latBHaOXgbtIVAJ?=
 =?us-ascii?Q?UYC+0RR1dHETkgpk2tOFKkKU6sL8R6Xo0CbKHSybH6MZIHDLW7On0EZYkOKg?=
 =?us-ascii?Q?lFLQydBJw0gS0lxvmlczXVf44tC+pwXQloKjjlrnZOaPIqG2qxXToHriFQd5?=
 =?us-ascii?Q?1aN21YCm4aFkqYdXi1CPiY/7bJIkrzAJP8PP05w3U0YKH5N3EHsiMyzrkWxS?=
 =?us-ascii?Q?tcO4GNFmaeW12QB0UEGoJ1hDInDQxBXrjvnpXz++9lojes1MGAb6I2LdLeVQ?=
 =?us-ascii?Q?fUW9kcMQt/5qFmtO79XEKZkz6JKwlDlI6h4plMsS9i/Wrraf0yivrLhsbBLx?=
 =?us-ascii?Q?DpWBZ3K3Iwub1fxCmI1jHnLdedZivrqFX9efcPXNtNETC7JqOnrbujfOqceU?=
 =?us-ascii?Q?GiIk/n2IO44IkPDs8iBpgDGqY7QB8Cf0U0HRlEnyCIImSYZtgeaPcJaEUT4m?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19e02da-4feb-443e-7227-08db7c543408
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 06:02:09.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psuLLff/ZL/xcsOGodhsg87TuaYwwYPotFgGh1wMfHiMdHhH/pQtJletLmhYkztPKnDswpsU+6WKmHqQBHI24g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit fixes the heap-use-after-free error when connecting 2
controllers. When a controller is connected
admin_policy_adapter_probe is called. If policy_data was already
allocated it gets freed, if not, it only gets allocated. Eventually
add_interface is called. Here policy_data is put in the "data" variable
(specific for each controller) and the process_changes task is called
with idle priority. This function ultimately accesses policy_data from
the "data" variable.

When Bluez crashes the flow is:
1)first controller is attached
2)admin_policy_adapter_probe is called and policy_data is allocated
4)second controller is attached
5)admin_policy_adapter_probe is called and policy_data is freed, then
allocated again
6)process_changes runs and the policy_data for the first controller is
read, but it was already freed, thus the crash

---
 plugins/admin.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 68e9237d3..16b74cfbf 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -502,7 +502,6 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 	if (policy_data) {
 		btd_warn(policy_data->adapter_id,
 						"Policy data already exists");
-		admin_policy_free(policy_data);
 		policy_data = NULL;
 	}
 
-- 
2.34.1

