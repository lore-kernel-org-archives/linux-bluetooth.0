Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0DCC07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 13:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0974461376
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 13:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhGINtd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 09:49:33 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:6034 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231756AbhGINtc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 09:49:32 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 169Dhj8q008136;
        Fri, 9 Jul 2021 06:46:42 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-0064b401.pphosted.com with ESMTP id 39pjap86nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jul 2021 06:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY+kvYQEwyCe+ZVZ8fnw1CewetKskjvpK1d03jIEy/mMLKPcEfrYZ0z+qo75JkW1dP2ZUegMvu8HosAwILyB8l0VpmnVm3WkAVf3hzit0JY+Djwyd7Xg0uaZ8NOzlj1xI/j0s6RPrtz6yuFgLF2jbx6smjPbbDd82eQWcP5Rk1QY4O/HGUZ2lRJuSYJt6dWNN6DsweEwad+LdiuQqQQ84TCmzJqbI+Oa5KUh8z3VOs6HxfnGQXrB4JAWxu60pD9llf8f7thkwuAOxEZ1R2XI2UPOVZxIw21uCffkdJBtLLp9iXJDyebBLLre2cQctK59LshAh/m7FuP+XsHnxXFlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INXqbuVqq3BnNaRF1G9xc8iKhr30LxLpFA9KyR84m9k=;
 b=T70zznxEho0x1jRaAVHALsUTdoN9Ap7UR7yWPuA1C/PpAOH8XndIGCvZlb4Wy+E9rKC3jvor3gmi5JSNKgSDTjFq5+Djwf5X6unMGnVAM1yc1FggvGZidBEb2tunlGqOVvc1RYSoOdDSxd0YI5F7zSf6R94DALPSJdC5FKm2u6ouKMqQv+7YYDbUyhcugwX3vQ4+trV+iDySxzI00JujNHMzdXuV0bXQuFf87dWRdaePQQWg2/j6EdeuRiP5y96wzg0A7jr8/ezlU50mTA6NtjPVw+C3tsG8cgjl+880qbezkYtyzK9rceZ47NZAnH2hipWaSOMpz654wZYFfT8qsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INXqbuVqq3BnNaRF1G9xc8iKhr30LxLpFA9KyR84m9k=;
 b=jrkKidKgT9EQMhhMDrZ1PHK0irUlhtXCBLFLmFrkM29T4oBEZG4+ax6c/GjFDxRe4CNpIAIDKY/+JcEaLksaQ2fvJ5dKgP/LID1U4zL0je/ErpJCDaiOxmhNOThJSRLWgc4wXEWY/d9qcdYnYt39gc+5uZmiRrQ+IUJRrufplXc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM6PR11MB4057.namprd11.prod.outlook.com (2603:10b6:5:19d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.19; Fri, 9 Jul 2021 13:46:38 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::7071:ef90:3130:cc76]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::7071:ef90:3130:cc76%6]) with mapi id 15.20.4287.030; Fri, 9 Jul 2021
 13:46:38 +0000
From:   Jun Miao <jun.miao@windriver.com>
To:     matthias.bgg@gmail.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] Bluetooth: btusb: Fix a unspported condition to set available debug features
Date:   Fri,  9 Jul 2021 21:46:25 +0800
Message-Id: <20210709134625.1235015-1-jun.miao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK2PR0401CA0018.apcprd04.prod.outlook.com (2603:1096:202:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Fri, 9 Jul 2021 13:46:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 123803e8-c0b8-46df-ebad-08d942dff9d7
X-MS-TrafficTypeDiagnostic: DM6PR11MB4057:
X-Microsoft-Antispam-PRVS: <DM6PR11MB4057CCADF7DF3B2936C016D78E189@DM6PR11MB4057.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bzIpkF/6XDHMxJy4ja/jBh2lcA0TD6m7HnAeHIzT1ZnAftg/F2AqD01qn1YpLEqfkBHJdxeUsijHMNo/r1g6tvK+r7Mm8rsBWg/zOvfbFlQ/xt4k4J9RLtdEP8mmmfvdhpwD1K+5vmFX0zvhuJDBG6Sk712pwK9XThuhgFQzfedRUys5CvT2VXFZXML/AQaV/Vd6tFLfkQg0IeqT8a+VIE91ZxXuGOwHs4jZjgAcYUTxe6UBNsUU2f4GZ2TNQTUJKBp4J8VsjukowObnBoSs8g9TUcr0bqyTLX3+2B6JyjDpNGpdnAGd+l9IocGlWcegf3wajRV49oYogFrOgVUea3Rf9lTnE5kgNA9PcMwKmTYjq3pCdNiye7ReCl+2io/WKxqFDDckr2DwrPB4bxCJAtcTMgh2g98xNeli9g1fLT2MiGpEjRCRWhLYSVMqtxjy3ISSe0tRPb+8YDRpRJTy3AXbkUY4vZe3rixxvue0OgNWDEOYbQEEwF/8Lli2JuoTpBGXOnqOShSjHYJx9GiGMWMlvTD7qng4wMCn39TnsKuYJwoiR9w4mqqWZrkZ8EJOyz+mqe89PaXqE4R6RERDTveJPOkI96EVmcxV0dxGaSk6yVHJmQl6feqM5S3skkxNYiZxHiXzoTELJYiXvordSl0dO/Niv654x/kOcLcR/Ek5I6H4ygg58XXi8lt1i3JnZLx8smnI2B/KVllvUUhYwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(366004)(136003)(6916009)(1076003)(4326008)(52116002)(5660300002)(36756003)(186003)(956004)(83380400001)(2616005)(66946007)(2906002)(6512007)(26005)(86362001)(8936002)(6486002)(38100700002)(38350700002)(478600001)(8676002)(66476007)(66556008)(44832011)(6666004)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zCDXltOKTGMTgp1ctFUnGigI+YZbHFRQ6EWMRVOTbOJby51kUPxlObaGpMsG?=
 =?us-ascii?Q?ssFqHVtbziUeIvbslO21prEwwDWAYpPVArOMX28CrNWi+FrqBNHAnutJ1GZd?=
 =?us-ascii?Q?Goqh5t5P44oun1TiKKgdkRUkeorVSixZ+pkwQz5jqrFxwAiuqJgAmuMt312H?=
 =?us-ascii?Q?cWgKaIhFUYC+bCSAAtRkq4FPV//6lFc6p88mMihbcEl9Grk42DxvNELuzNnU?=
 =?us-ascii?Q?FysukqsAcTkwqvXwy6z4MmJnPT5xad4Toms2BnOS0OMhoyjBUMW6ccP46PqU?=
 =?us-ascii?Q?2QkGR0EvJHK2fQWLsioDnK/Ja/mung0nzSzzr5Q2pGxdwXrE+iwe/lCAxtyz?=
 =?us-ascii?Q?xoU6+dm8gRI2OV5iCfXS8Kjc06KkPpVc97LmxWJdELS97WsoXAtpOcc+dlyJ?=
 =?us-ascii?Q?2WYRLUO6X8qhFodZFZ4h4X9sV3x3huVYRQiCN5wRcFdiU+PcWOwRpi2nUAwY?=
 =?us-ascii?Q?6vCSkkSwl1jQjfr2lxt/+lFTYogAO7ulAjEiPaOXJtSVjBYhOYdt8aqI2q6q?=
 =?us-ascii?Q?qfTtx4FXX50wnwOlzhwvPq43MJEJBAGOA9CvvgqYi2MTLLusv1hFUYz+NGIj?=
 =?us-ascii?Q?+VvYor1EZsUtNirBpg927cGQo6ae3TpHo968ienZyqajuXet3n2ysRlB0jbs?=
 =?us-ascii?Q?50dleC9bbJboYPfwC9LObgwBneGXwqxtf0zHlnWPgbljeW+s0tYdOn/9XJpL?=
 =?us-ascii?Q?kAbcbtZara/Q8dF4TSMD2GMO9ubXRIKFxLkShx4JYlvt+6HAQzyydyNt3IEI?=
 =?us-ascii?Q?iJ6p/Kz+2LDWa3tUxg1vjQ5Af2cPEBNc892gWcChNjQ2Fhu3drsf6we0XILN?=
 =?us-ascii?Q?WtNZ/vBmgO8/j4uxRUfrudlX3Z11VbDDpBKi+w+5mtLm8I7F1jW33lHT9pdg?=
 =?us-ascii?Q?pdOZiLifVLuwVU5EWGHSDKR03CSaFby50chDAcmvqJDPoteRPrVMOrJ7oA+D?=
 =?us-ascii?Q?h4IMzSD5ZmUmFeUN5S2Y4B6zrdE08FPoiFwp0W947fMIsCGtQiVtakm8PNKQ?=
 =?us-ascii?Q?Zf/igdkJkIpYOuIyxJzjDBhX6iLBN5LX66+A02FUzoVoHGV8UAqzEyWkvL2F?=
 =?us-ascii?Q?FgrSlQc1jVflUl8x0owmO1iueJJ7K4o9hKNV3RwKDBpJ50iS8GAzoPL3re+O?=
 =?us-ascii?Q?XBGhJhgCe9LKNr9YD3VEz9EXEpjqAQ+S08fIBVgaA/gnPAfTBzvbc4e2XDhq?=
 =?us-ascii?Q?KndXHaY/dRmslpKHEGw+WqgBcqpAGlDtTCthkDzwpVlxznvBgduDrJcXIpPE?=
 =?us-ascii?Q?47exDZHB0YtvoylvJzLEiavgI95P3gMWTv+AbpaCY8+wtTKPu6lu9DiTmx9B?=
 =?us-ascii?Q?5HQC9OMlAFdnIHYg0GbqhfQZ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123803e8-c0b8-46df-ebad-08d942dff9d7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 13:46:38.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0z+BuCuDCQpc1I92awfwnU5Bs5wJzQNMwFuv53mIT2kBfXCg7Ls1blChUGTwwiQn+vKsuUlgq15czEilLK4TQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4057
X-Proofpoint-GUID: s5jBkAWvZ93slwDRw1gzNXaenGRuY_4B
X-Proofpoint-ORIG-GUID: s5jBkAWvZ93slwDRw1gzNXaenGRuY_4B
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-09_06:2021-07-09,2021-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107090068
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When reading the support debug features failed, there are not available
features init. Continue to set the debug features is illogical, we should
skip btintel_set_debug_features(), even if check it by "if (!features)".

Fixes: c453b10c2b28 ("Bluetooth: btusb: Configure Intel debug feature based on
available support")
Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 drivers/bluetooth/btusb.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7f6ba2c975ed..a3c027d17745 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2889,10 +2889,11 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 	/* Read the Intel supported features and if new exception formats
 	 * supported, need to load the additional DDC config to enable.
 	 */
-	btintel_read_debug_features(hdev, &features);
-
-	/* Set DDC mask for available debug features */
-	btintel_set_debug_features(hdev, &features);
+	err = btintel_read_debug_features(hdev, &features);
+	if (!err) {
+		/* Set DDC mask for available debug features */
+		btintel_set_debug_features(hdev, &features);
+	}
 
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version(hdev, &ver);
@@ -2985,10 +2986,11 @@ static int btusb_setup_intel_newgen(struct hci_dev *hdev)
 	/* Read the Intel supported features and if new exception formats
 	 * supported, need to load the additional DDC config to enable.
 	 */
-	btintel_read_debug_features(hdev, &features);
-
-	/* Set DDC mask for available debug features */
-	btintel_set_debug_features(hdev, &features);
+	err = btintel_read_debug_features(hdev, &features);
+	if (!err) {
+		/* Set DDC mask for available debug features */
+		btintel_set_debug_features(hdev, &features);
+	}
 
 	/* Read the Intel version information after loading the FW  */
 	err = btintel_read_version_tlv(hdev, &version);
-- 
2.25.1

