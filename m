Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FBEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 700B460295
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 16:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhHaQgz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 12:36:55 -0400
Received: from mail-co1nam11on2127.outbound.protection.outlook.com ([40.107.220.127]:47863
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230047AbhHaQgy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 12:36:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGBnXDGN0bFnfyCelRpfRwDbCX/hN5MMKNvmiVJRobjOr/qwc+6JXrIQNeYMOFSVvRUCIKf1yiQcYl3sElFiS6EDAHT8B05ARaD/WmjEqk1Riyp+4jjl/OiL5yvCO4O7C5lZmJIAqrVeS/ayT/x0BTonA49k74Xt2opbHWx1756CiZnJtG7+R3oNF+8OfDFIlKaNg8Iedon6YyIqVP0il4Io02wFbfR6lFoRhej7870dXBZC6PNZfDnw0h5cw8dTKD1zDQE9IR9RcTgPk47j5vgBnBdg3GwUNP3LzrWFCbvlR9LVkzCB4zdpm3Al/MMdXysRgEIFmKf8GJBgnXn1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4CzSmjHUm3k5yQPwnLMi8zX5XwI7WosjSmjmg1+1I8=;
 b=IYvkqeA0lYALNMqudMKS8xdIBzsbRdUvm52spuxsp5IY86FHRhP6bE+Z/MoDPIjpWKz1HlrOw0c7+L3lSYCnJRzxsWZT3Ky6ojAG1GCXUSMwqD14Os3JeoC8Pum9cEL5W4pmYxERlHi5iWC5IG1hRqJs8cZv6rNvTuz1Asb9vPMu6QcZid8agAevB9eBkPF+Nt2x0Cdq5lkit5DJMUZokkA3blA19u2pgrdgl1J/L6QQKlwwuFDCw8yAM3Yrto6xZ4cPdQxC4dnAlbxJllZ6Ja9nFPfHoPK3n2K2QIgx9zkooTFy0gdi27vmRKucnN/b3XDaMQ0pRgGFy98QmLvtUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pabigot.com; dmarc=pass action=none header.from=pabigot.com;
 dkim=pass header.d=pabigot.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=pabigot.com;
Received: from CY4PR22MB0581.namprd22.prod.outlook.com (2603:10b6:903:e2::10)
 by CY4PR2201MB1224.namprd22.prod.outlook.com (2603:10b6:910:61::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 31 Aug
 2021 16:35:57 +0000
Received: from CY4PR22MB0581.namprd22.prod.outlook.com
 ([fe80::d9f0:a6ad:c10c:18ad]) by CY4PR22MB0581.namprd22.prod.outlook.com
 ([fe80::d9f0:a6ad:c10c:18ad%3]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 16:35:57 +0000
From:   "Peter A. Bigot" <pab@pabigot.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Peter A. Bigot" <pab@pabigot.com>
Subject: [BlueZ PATCH] lib: fix variable-length array declarations in hci structures
Date:   Tue, 31 Aug 2021 09:35:45 -0700
Message-Id: <20210831163545.3646157-1-pab@pabigot.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: BY5PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::40) To CY4PR22MB0581.namprd22.prod.outlook.com
 (2603:10b6:903:e2::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tirzah.pab (67.1.116.23) by BY5PR16CA0027.namprd16.prod.outlook.com (2603:10b6:a03:1a0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Tue, 31 Aug 2021 16:35:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec6b481e-dc1c-42bc-3098-08d96c9d6890
X-MS-TrafficTypeDiagnostic: CY4PR2201MB1224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR2201MB122407CB826450A721869727A0CC9@CY4PR2201MB1224.namprd22.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcJY60xfhXMldzsoXuX7k4Co9LzTdklHbTowPUE/lmBQEFrmzpdI/3JuDX4AeasMMKDDDdZGsApRy9C6iLY0TvUuKvCTVQUVcpsHjue9K9anQ9WZNzWsMnx+qd417+jT0s2Gxt45/DpUHNtipCltuhEg634osF3Ka9Zd8gdkkWHaeJaKqvYTeIB/2ouOE+en3SsQMNgjujuweLURFd/xFxqXJPUZckAZyxqXZeg1PI6Oi9e81gJ73IeCmule+fk4EBsPLiBnUKunime7Qs38YLCVfWgiVqH45VI+O9BBOqQIfGh8sz1tk1H9H+ccvIfpD9Y65uBrP+1XFTfN49x4pqQXVAGmq9phJbrv8/SMZKK4KVj6GS38Of8kwJzX0rw3XERSGge/seY8dyVaYzSFFGSUndW34pDn69HUTnDv/J/UqrtcEmCfkEMA81JnkiqI9aysxQixmGhtbIOieJZJyhXbKifsJmqzCHyMu2ll9WZr2iI54xsU3rQeJAGELqTizQwdko2Z/AmEzF3jzbvANAh6G3qzVv9UQwFoqDItLTrvp4UBzjX7GV+qoO1/EBDWAcmsaa3qSdV6rpIzS2dasoFxCqroHznYLGP4SJVn0aq0kFBB+1/L6rI77SIgzfHzcLSsqgfAJfrNpT//dLJ5JOsoucrRdpqEvMT6mBXMWH/dIaMw7Mo4BO8oqGrMUjUqvB6k58/OrBcw+9lN/KXe4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR22MB0581.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39830400003)(346002)(136003)(36756003)(2906002)(6506007)(38100700002)(2616005)(26005)(86362001)(4326008)(956004)(6512007)(478600001)(8886007)(38350700002)(8676002)(6916009)(6486002)(1076003)(83380400001)(5660300002)(66946007)(8936002)(52116002)(107886003)(66556008)(6666004)(316002)(66476007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vdD27/qtFQlHglYxd7Cz9wU5Mds8q+kPQLQN2fQmmYNKR9oMplWkX/uw31fu?=
 =?us-ascii?Q?CWh/nW5/c6Tt1sZKDTIcw1qKgCnGd1Ki63gBQEYwCjicfVrL2uFlbdeuV73V?=
 =?us-ascii?Q?rQuk3rVbBo8dgxoBhenL3dAX3NHc+Y0dMmMQbAxw1C0m3pSO9OJlb3SaV6kN?=
 =?us-ascii?Q?x2r5TvA3aJNMJv2g7dgGtz72YupQti1vfgflWIsfRpU4oByqoLqEDl+WUHaj?=
 =?us-ascii?Q?YWZuBEaXCnEpt1w/ckjTDny7lDR3LPoKCJtvundK6ZzlXpoEZ1XKj49bz8wc?=
 =?us-ascii?Q?ozaMNZ69cA9Eo+CTmdZ6sytzgrot1vboYsFDSRiOMORqFUF3kv/MqdzVTYTh?=
 =?us-ascii?Q?k0dWlOUUMckPjzrIyeZL7DZtg8E/vXW4kjNOfTiy9m3ErdlL2hFp3a5SMby0?=
 =?us-ascii?Q?QOu3vkV0/KglM9/BL7fWoHhVsB4DRQLByZYSaj+dSyjo8rlMTtXCIgt+lDos?=
 =?us-ascii?Q?EjqK1EjAs5KpnYznyNnF3fWDLMzuNc9ZAeq0j/9+49Yo4ctzqekVlAw0Nx1L?=
 =?us-ascii?Q?/7hRRWFCaHQ3XPORn2yXS52jVGma9CsJLcWvIrZRhhtSVeKv4Y0klfifF59S?=
 =?us-ascii?Q?HJ/hRYJ0lz/BGFr3bX+RAOIQRN01NnYvhoF/Q9q1Axzf53R8ZJo1zSJlK6gT?=
 =?us-ascii?Q?nQz6squNOln6k0XvDfe2/OkgcVb5zLyaFklYkjjFktPMW+egqK+g4oRsFjzj?=
 =?us-ascii?Q?9Gs1lsJthCWqDMFHda51v7xP/DOkBFQE2JcTanVThkWaJuMnSFhINDGkSfDG?=
 =?us-ascii?Q?Cng+M/ia1r2HmdkJFMIdGaYfpgk48Yif25NALj+TMhnp/kLMMNl4E6LaErVH?=
 =?us-ascii?Q?Ab/SdUXjW6HvwnBCqLrbNUI5mziqko7Y83C5OhDwM48nVs9PubYGa44q1DQI?=
 =?us-ascii?Q?sK9tnqvGVmziDOL0eT1VkkThSj1GJruRyIbmyq66nX2YfSEynU1AyfElNivS?=
 =?us-ascii?Q?HnOC5F2wlr8DUQEmluHdyhOXTMQfkjY4+lPI189hBu6aqtGx8/Jn1pyA1EKN?=
 =?us-ascii?Q?jKTUbiC5tZhpjsHXAErsng3X0izNOUWlhNhJ7IzVrw0n1ricHfg+xROAZT+t?=
 =?us-ascii?Q?IeU9POS/rMHaM2PvLyy06r3n+O5p3EdEL5sGKAezenlxzstycViJuXzFe6xf?=
 =?us-ascii?Q?UUWQqFy594SH8mos5HDZ4PRrXExf/TvIFuJWqtLbfMI+9RXspels94IR4185?=
 =?us-ascii?Q?cDR+J/3XJx0j0YsSpS0w4lEc4cddzdCS5at5PCi5M+ulC8GXN1Xp9tBBiHv6?=
 =?us-ascii?Q?Puqkr8BKFAzdTY34A2aK2ZiRgcsJXXZ3ok0/VzhyZ4L1Xz/YPld9clzVD+Rf?=
 =?us-ascii?Q?DydjeN1WsiV3H2Siy1yMfDgF?=
X-OriginatorOrg: pabigot.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6b481e-dc1c-42bc-3098-08d96c9d6890
X-MS-Exchange-CrossTenant-AuthSource: CY4PR22MB0581.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 16:35:57.1630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 93ff3220-27ea-4632-aa49-46b51ff93a85
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdWLyRwNt/i4hBFD8+mOrFWkuEg7DeM4GajlzJrhCIn3zJjb1bqVilYTUU9hQjFu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1224
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

No changes from previous submission except the BlueZ subject prefix
that I hope will get this into bluez.

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

