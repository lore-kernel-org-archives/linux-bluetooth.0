Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D592C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9575603E7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 16:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbhHaQ0x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:26:53 -0400
Received: from mail-bn1nam07on2103.outbound.protection.outlook.com ([40.107.212.103]:54745
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239964AbhHaQ0w (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 12:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9Q8OYslvRGPVeqmTBhBAq30BZLKC0A4VRebirkNo82paOnyu/6cgITMjRhBmXIFOyO43PSZ7FiKQyGajIujKGsu8cbPOV3CGXje7p3NlTlraPJf1zW/sxbO8u1BOLsm63/EOVG14ejOmTGGscvP1+dq3KY1+5S+O/wMhWe+bCMExNgI2k+mlBn67xHDDyKZBbCIrsSCQ68/ynVD3GWh+/qiW9Vd+1Ju6i2K9b928PrGpXnAcbtZ65aJ3J8jRlo2lovfDn764EsMHaFvrAX3976vM7cuB4atfa5tGxgxvkX+v1oinGdElc8Tj3WwRnwAOVsALW6rpe4tVsZsGpsltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5Q77Q65pxR+wx5n6fffNUuAQjQkFsY71qUJjQaHULGk=;
 b=iwFbNuz3sYXYgSTA4PHG3JXJnMtEbvG6xMf34jX3dHDVPNybhMhX5Iqyv0KcYN762n03pRfcnfeYQu5UDCC9SZnQa6Qn3H4PUsjHT1vZQDH1JWfOrqXqz3rkuqq6C/XQt5MSEo3+86huaj5zHn1nLJS+9GpCb3YhwJgB1nBpU96Gw4tw/vzzVkG4pV9e2+1eFa4LkT/uPZbVosO7ttGqJVccz8eo3nKXs33fHgTd55Tb4iq0czgQfqZfcqh3wRePUoE5I8sme2kwNTiVAYS+HhDMIPNCCu4KJLi0CANMlhu/17lEDS5J2zpJ947fbtLfIbiMMsz93AGDi1y/kl9WGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pabigot.com; dmarc=pass action=none header.from=pabigot.com;
 dkim=pass header.d=pabigot.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=pabigot.com;
Received: from CY4PR22MB0581.namprd22.prod.outlook.com (2603:10b6:903:e2::10)
 by CY4PR22MB0039.namprd22.prod.outlook.com (2603:10b6:903:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 16:25:56 +0000
Received: from CY4PR22MB0581.namprd22.prod.outlook.com
 ([fe80::d9f0:a6ad:c10c:18ad]) by CY4PR22MB0581.namprd22.prod.outlook.com
 ([fe80::d9f0:a6ad:c10c:18ad%3]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 16:25:56 +0000
From:   "Peter A. Bigot" <pab@pabigot.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Peter A. Bigot" <pab@pabigot.com>
Subject: [PATCH] lib: fix variable-length array declarations in hci structures
Date:   Tue, 31 Aug 2021 09:25:46 -0700
Message-Id: <20210831162546.3643599-1-pab@pabigot.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To CY4PR22MB0581.namprd22.prod.outlook.com
 (2603:10b6:903:e2::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tirzah.pab (67.1.116.23) by SJ0PR03CA0166.namprd03.prod.outlook.com (2603:10b6:a03:338::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Tue, 31 Aug 2021 16:25:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9766481f-251e-4f99-a99b-08d96c9c0297
X-MS-TrafficTypeDiagnostic: CY4PR22MB0039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR22MB0039188F2D7A169A554F528CA0CC9@CY4PR22MB0039.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFzTEEzIi3Y18snnjDaCbh0HCgkdiHCKSGRYE+MflhaQ8KLye9lFpjUowA3F2ko6G3536abt7wWRmfyREQ8/cIBcT3waBg0hHI1sTD/32uyBRVDr8+jZad4K7Q9sANepZ/cyz1lqEmxr8+/T31RIF6VdFfsHySv1T9bK8p3GXULsFI30JWeVR1WHha1h1SsRMLKouke/b49yO+5k73FUKOEmu0ReLL8qgt38h3QkwGDdTT/djoVTUjNONkLMVIKSBh0rVWEkDWXfCmr+lcYxCHgi6frq8ZQLemiLYFPsTFEI89OwRMS30s+PFwHDm7dBmxU0/n1S7xj5m1T8ILIs3G3Xm9nWxm6aS8wcEnWQvGelFEpEh8MsWmkciLaQItl8I2B3UAxoSBBXBVGNb4Hd4EqmaQWdstRw5T382iaEusiVkBlmPou+rSgddJWOfjW6mRj5Yb0zfGy+NoExuAIpyjKTHlbEgkci6JwHfK6jdAni7wKVyXc4YYJXQG63BicqGHu3dUqpdDt5EdzoVpkE509cuFpnIJsiWgik1DJj0ZIQvJskziqd3gutISR5CXEnTqGHRTSdVPEpzpIXrmWFosDjbtpnKmcxw77gUeYWmkqkVAP/QDbxog7Ef7oYpzmk7wUx9XwRwaTzZL5wt5gh/h5sqImR1/ubRZY/gVvywvcct3jFdcABPsH2kkZe/Rx0EvsJaOclrcRI4eGXQjR16g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR22MB0581.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(39830400003)(136003)(26005)(66556008)(186003)(1076003)(66476007)(66946007)(52116002)(38350700002)(38100700002)(6506007)(83380400001)(2906002)(8936002)(956004)(6916009)(2616005)(8676002)(36756003)(6486002)(6666004)(316002)(8886007)(508600001)(5660300002)(107886003)(6512007)(4326008)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8XmfW6zkNhxCvIbpTzt/j1Z2oR9+KYnMrw1l96nB13KkcXO6P9xuofM3O0Xh?=
 =?us-ascii?Q?uJJqAVKtqje9aBp8srGY67E2eTrKT/PU0en66VINmrQ8dP1zKmK33oJ3jSUF?=
 =?us-ascii?Q?9G4DdgFaui0sqBZcCW8NkPLgqmoCY/GHf1Ijwx/Q4suO6dDWn9Bi9Ho4Kf/2?=
 =?us-ascii?Q?queuATmURioWHTsMLc0w+KNT1IqdHMX3VWtrOsSE3EUBrs6pSNVVBdrECoiE?=
 =?us-ascii?Q?ghl6vN/GGRG8tJn+Ni0EIM0gJYT0JfAzmpiyIoGCuqqO8TiuQqmcTjZ9b+5M?=
 =?us-ascii?Q?O+MXYu8dOqJelYGVjWHoBgI8RZvad3zlrZ1xxzIsJ5AAXAHAJk+xZ74uhX88?=
 =?us-ascii?Q?QnYaXGb6PtstaImPp48gBB3ew1mBS5YJ7YdPs56wkbt3KS0lXXlqyKFPkgK1?=
 =?us-ascii?Q?7Bc659rceauX+qtsawFBrWz6lRc5Ez+7ue572KEU2yyVCDhU/EmO/zqRq7Dw?=
 =?us-ascii?Q?PFehWQXntLC2LwisNgRYDfbFkcyzoVOPkSxWHyh7S2icQz5xz94MAnY7/Onr?=
 =?us-ascii?Q?Dham5k5E2yoxFBJRCuoPB9TV8jQNw/tanisJa3sYZ8ufM0EVLdT+E2NdDTf9?=
 =?us-ascii?Q?KcutW3qCOGm2ieQnfCRsF8MRDdQGbkHZ+e3uuOoqtMMD/jIyabTDdoNFof8S?=
 =?us-ascii?Q?2wpIGD8+1YkS4zAqPrMRURFO/BtEAV5Lwj03car+z/LvXse3vGkArC13zISC?=
 =?us-ascii?Q?vj8cFcnkcgjzDhMH+oD14nkj5kxShNdSgVnIoQHhBn1HFq9XxnzMNXVyJ0ef?=
 =?us-ascii?Q?YUmXnar3ribKhudRHnaw2pXSa5tY0mRZfyGIeex4btdxaDDp/1IITj0MSszW?=
 =?us-ascii?Q?0vv9Jhqhs3pSpQJWyqf3UCo7Yx17dOv6I3Mcsvhnjnk0KWn50o59OCZyNg+a?=
 =?us-ascii?Q?3rjpjSDKoIdVtSvl3QPFQAzyq+4JDAeFyoLlmRL3YWWBVbA/7pgtMj3saaBV?=
 =?us-ascii?Q?b0g8kALvmQSvHnudE8DlwTKUqqumhzCv3SsNefbFs+Uf0yQAatbRP69KOB4W?=
 =?us-ascii?Q?/Q3pQDPR+tG6SOSgrpPXCq34BakrLfvpe1duSw3B8yDuYQvGPpVgfIPgU/1X?=
 =?us-ascii?Q?kxEelQHnZre2El7u/06G7tEDFDlER7Wb+B5iGwu3o1ftQFqRpsce3b1Nzf+n?=
 =?us-ascii?Q?mJBvLUQLWSX+pgcAoa3A4cmcEjyVzOXhIfmTjg7+WZRdJRa/nc7XiSfawo/D?=
 =?us-ascii?Q?w7+cxSWKBJzLoq6FTe9H75LL9MbY2sMCZ68xFwWcE1L5fMsPEaHRrI73z08r?=
 =?us-ascii?Q?uRrZj9wEYSePfNedGw9fLpCv5iB2o2cIxCkmjnafaKzKBw25Vd9vERE2Vw3K?=
 =?us-ascii?Q?ujEna/qu7L4fSGBHesunHFnZ?=
X-OriginatorOrg: pabigot.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9766481f-251e-4f99-a99b-08d96c9c0297
X-MS-Exchange-CrossTenant-AuthSource: CY4PR22MB0581.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 16:25:56.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 93ff3220-27ea-4632-aa49-46b51ff93a85
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Grul8+HL3yVHH15ZYw2u8WLZuhRI+2bNgTKNymbtAtmZxRKn/A/3X/MZj1msznnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR22MB0039
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use of zero as the size for arrays as the last element of a structure
is a GNU C extension, which as of GCC 10 produces diagnostics when
values in the extended array are referenced.  Switch to the C99
standard idiom for flexible array members, already in use in a few
other headers.

Signed-off-by: Peter A. Bigot <pab@pabigot.com>
---
 lib/hci.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 3382b87bf..a61568bce 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -729,7 +729,7 @@ typedef struct {
 typedef struct {
 	uint8_t		flt_type;
 	uint8_t		cond_type;
-	uint8_t		condition[0];
+	uint8_t		condition[];
 } __attribute__ ((packed)) set_event_flt_cp;
 #define SET_EVENT_FLT_CP_SIZE 2
 
@@ -2135,7 +2135,7 @@ typedef struct {
 #define EVT_LE_META_EVENT	0x3E
 typedef struct {
 	uint8_t		subevent;
-	uint8_t		data[0];
+	uint8_t		data[];
 } __attribute__ ((packed)) evt_le_meta_event;
 #define EVT_LE_META_EVENT_SIZE 1
 
@@ -2159,7 +2159,7 @@ typedef struct {
 	uint8_t		bdaddr_type;
 	bdaddr_t	bdaddr;
 	uint8_t		length;
-	uint8_t		data[0];
+	uint8_t		data[];
 } __attribute__ ((packed)) le_advertising_info;
 #define LE_ADVERTISING_INFO_SIZE 9
 
@@ -2246,7 +2246,7 @@ typedef struct {
 typedef struct {
 	uint16_t		total_num_blocks;
 	uint8_t			num_handles;
-	cmplt_handle		handles[0];
+	cmplt_handle		handles[];
 }  __attribute__ ((packed)) evt_num_completed_blocks;
 
 #define EVT_AMP_STATUS_CHANGE			0x4D
@@ -2264,7 +2264,7 @@ typedef struct {
 #define EVT_STACK_INTERNAL		0xFD
 typedef struct {
 	uint16_t	type;
-	uint8_t		data[0];
+	uint8_t		data[];
 } __attribute__ ((packed)) evt_stack_internal;
 #define EVT_STACK_INTERNAL_SIZE 2
 
@@ -2407,19 +2407,19 @@ struct hci_dev_req {
 
 struct hci_dev_list_req {
 	uint16_t dev_num;
-	struct hci_dev_req dev_req[0];	/* hci_dev_req structures */
+	struct hci_dev_req dev_req[];	/* hci_dev_req structures */
 };
 
 struct hci_conn_list_req {
 	uint16_t dev_id;
 	uint16_t conn_num;
-	struct hci_conn_info conn_info[0];
+	struct hci_conn_info conn_info[];
 };
 
 struct hci_conn_info_req {
 	bdaddr_t bdaddr;
 	uint8_t  type;
-	struct hci_conn_info conn_info[0];
+	struct hci_conn_info conn_info[];
 };
 
 struct hci_auth_info_req {
-- 
2.25.1

