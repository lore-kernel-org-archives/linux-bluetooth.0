Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7314C64ED6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Mar 2023 13:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCANnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Mar 2023 08:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCANnS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Mar 2023 08:43:18 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2055.outbound.protection.outlook.com [40.107.22.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4AD7EDD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Mar 2023 05:43:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9qGLy+cFFzU59TQXPKUSorkChV9IPq6wC7F8SRTo48hcEzesTBb1V5l5DBIVUlPuBldlyBor+1aHGOsSkAPbrmCfJoW/P0S9vYgsQVl1aYMncW0FXd0JVqFhobmRU1iVRw+4i3dVmr6ac36d59NaQJY7zsfAlLWgYx0Kqlljuuf8LyCIpxmkya8pv5PTVAcx6RNDTHXcc5E4pKkm601tM30qYbqx9FoqyPk36RTNVrz/mAxTDl08jT1JFDgtETi9lS1GMggY1UrkSPzu6i8kITwZxHqgEJSousWGrCxhnP5MCtThkjCKSwu/p71vMF6cCWfbWe7d/qykh9xgCqemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrEq+0u95zBmhNpK2i4OZUfDPueXDAXCjaSN+13RTZ8=;
 b=Z3kT0NmW+5JPIVDWWSEkkve74OKvuHz7D95rVBWqlw9R5qUdasQosniOopYyk3cp+hD4Wvt5+Aexj0knMwEypQSBMwFE5E8LOOl16ps6nGcRd5HhMET0GsksAdaWVOjqE4zYj7G+2DribkjyuD2dJTlM8u+y2NAem1OVSWLUrHF33z3tHExivFpI1YlNZPsAWTPjZrlIUGjrHFydz1GTfEPhPaOQruQOG60n5H9XmSUrliq6Ldg/PJHFVUHicn6ixBHU45RqGhNjMElm7/LKArr3gzN/Y714pqPHW69/JBLZchRIuECdvgrWWuhRaTHjpEej3xbiBGwQCwjQ+/abcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrEq+0u95zBmhNpK2i4OZUfDPueXDAXCjaSN+13RTZ8=;
 b=aj9BrOvzlXDvwi66Ow5ARth3Tsbp92NOGTLo4WbqJZ/C4zWrq6HaGMuybmaQGiOjOhM9oOLvxDHemu4Eg6z2yVh2W0wuIwYG6pxVnRRvQQfjFBQaRz56bgN4Yv/yrcApBXOwtCDl7Jpk0x+u/YbqHKno08E637VC14m9Nwk0q8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB8702.eurprd04.prod.outlook.com (2603:10a6:102:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 13:43:13 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%9]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 13:43:13 +0000
From:   iulia-tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia-tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] lib: Add BASS UUIDs and auxiliary defines
Date:   Wed,  1 Mar 2023 15:42:06 +0200
Message-Id: <20230301134207.10924-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301134207.10924-1-iulia.tanasescu@nxp.com>
References: <20230301134207.10924-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d8deaf5-870d-4018-d1d6-08db1a5ae729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHyyxulhRevMX6qruxSKj0kJafM+0gi3ziuHinKN7BLXtCl8aUAwtOe/QXzOgNp+wzCwcAc/t2CbF9Oiilh2UpN/cPaT/FzL60OyNFfBrie89eS8JYYu6F7o4WAIKK6dsaKT5qRvdMwxsJjSvQYt3E5jCZ367P+2E00sH/5BsHwyBqgvsBYGBPMgjZSvsAeDGAGM9CApeAdXsG2RH2spxFnOmedFOamZn4lB0xlldkMizy7ST3iId//s9H3kQJ9XN+Mx/cKgAoAgAtpSA2vAKlnsK+sCoIpGfOG+AxqfLdiW0oO8EvulzGIuhYm7OA1klpBnkGfW49bZHIjwiOQ9aR0jTie3LSMVCno7RybnfDso15rOgJHRni2pICxNGSAqaOS4ZITnk0AfIjFcxeJEMLKCBytanLkSLBP3rQRPktpfQygooG8coZD84Pn3V7dc8stadBq3FShk8WZ/ushbCoZ6G+X+1a/UMOLwyziQE9hGSGPwWAPrO0HPBcpbq/m1ji64r+rD+/tRp/IyVJ21g97xGhujEZpJ6KD8VXj8TF8oYLijLXT8fYsumaO49Yd2ThDHsuf1ZcwujMkGO0rVhes59RtaxNmipmtbpqTR+mCN79FzyBW29kEPCvo0X9bCxmsmr85Zul8XlTE1gdpbmKAR0U0/9oIxNpsGE+tc4es64Lz5sqKWDglAW4yFt5pbIElXhJtSCmEaXD1O2IqQqWMuvU9xPwfrIaYrTQl+G+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199018)(86362001)(36756003)(66476007)(66946007)(8676002)(66556008)(41300700001)(5660300002)(8936002)(2906002)(38350700002)(6916009)(38100700002)(4326008)(52116002)(6486002)(478600001)(316002)(6666004)(2616005)(26005)(186003)(6506007)(55236004)(1076003)(6512007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tf8BIRCN2iMVZfqywVnQgdOvNkNgqOvnGIh6BPjgHOM8VkPGnrJyGhfPv1lA?=
 =?us-ascii?Q?L+K5yUSQ5YkDBIHPR4AHWa+wXCPj3Cusdjf8J9x6Pt8o2J2z1dWUl/bFmktW?=
 =?us-ascii?Q?7sN2MmGGezf2STw0WgXDUqKnw1tRmMsGXNYwwAZmKm4nFGHpX7mxOQFi3Yjs?=
 =?us-ascii?Q?eBQKxBXpo1fWpRssG7OfgTFOKHNpev6hQrlRBLqn38xA9ZbvZgJV76D3/yYs?=
 =?us-ascii?Q?tzRnQRJPRyo0IJMDuMV6OcsLdD4EZ4mSv9sQhBf0IghP55tVji7QGsM2XlMC?=
 =?us-ascii?Q?cujISfW2WsgCYFqXwYrurFSmff0NM2w+tWDE85TbZSU7cCSPRjAeZP8DEZCa?=
 =?us-ascii?Q?YG30G4P4b7UNHGG9tZmboo4mEazyCT8xckrQ5TLULu33wgdORXgIebScWkY0?=
 =?us-ascii?Q?2JMrTtBjgyEMdd2uHfZHbIAjbWva4fzrTW3eu1mBtH6q+y3ddVL1bVdKdX0H?=
 =?us-ascii?Q?RbrtBuF0Q0QcVWxcCs2g6jRw9gydBBOpMrAc7EKFQqIQmH7IYLCzXdOgamuP?=
 =?us-ascii?Q?Qi/i8dVaZ3qmRgcmi1XT8uvrNNn9yNx3aLGajhNKtPq3J3Ql4LybKSWOK7Z1?=
 =?us-ascii?Q?RKB5sIbxAAHJ5RBgyIIurSVeXt69VxUV4VE9gcB7n2AyJL0p+Jk9SMmhS6Yw?=
 =?us-ascii?Q?bMxFI3p0Cby0jwNye/PX0vjCa3T46wajKWGyv4ZMAQ+exuEhYkGQylPUvTgA?=
 =?us-ascii?Q?/oYl8uIikH2W/S/yZqiOIcLx7NwpOmm9+lkws6vbdcQ2nrH3VjJVABPhN7W5?=
 =?us-ascii?Q?IyTuGejd37dqkUDdxYgpYhbpKFA4SlCe2ttAp18simJBdogQMjoLJDBgIC1i?=
 =?us-ascii?Q?yGBa7pCmH/dHlIgwBQx6d7jhbdB9texL4kvr6Wqr053HojdYfGKpNB4RaNwG?=
 =?us-ascii?Q?lHkVLnhaAcA0htjkKM5zz0CzUj12TEUTl6yPkfv0M7KYJR0xCBLelZdjw00m?=
 =?us-ascii?Q?DgxetmJwebnKQ5bZZvXukLgZcw3xeLHTp1quNGYjWRRgZaR0x1HRwb7YHh1z?=
 =?us-ascii?Q?2u2hPZ7mJ9FNcbJujX1JxcYYDRc3a6s+K2M+1tak6vBMCw/C1IMuWgFGJyZs?=
 =?us-ascii?Q?K+WXPzRqmOIWr6jIejklesG45XPnUCbYzavkWAr2fbl3m/qWwh9Nacz3b/74?=
 =?us-ascii?Q?AEYNXYJixCey1rmarkWycvjQhbQhbZC+Dg77cg6VJAqBRvuBUPToeY4lKYtr?=
 =?us-ascii?Q?jydNH1Vxiehc5kpbYMJM/noS3Um7HfBqFGhA0wVMRiJD3yMJyj53pp2LJt6S?=
 =?us-ascii?Q?ovQ8VSK4HBd9i6lBdewVgPbNmTfbX3e5MqBMXbRsRyUxvUAzoiBPDO1KIDH7?=
 =?us-ascii?Q?CM2mfIEgn1BdDbGrt9DXjKzW26neoW/uZBjhko3hpCY2+yiSYiGGP2mbQ/a4?=
 =?us-ascii?Q?HEA9pGxzCkFFVjYQpTuoE5XR4aneP/LHt2tLo9kQkCszWjD+Kbl3vAzxgtaI?=
 =?us-ascii?Q?av7lyvrMJOkd5MPFu5pMmpmYuXztqF18YsAuiU26lL9+jREQf5yidpJw/wEP?=
 =?us-ascii?Q?tgzZk2YOjTAJ/8h4cbLEgg6R7JWsEhc7qEWgjfhEYNDLwkbXLZdV2La7MEq1?=
 =?us-ascii?Q?TJp4g4tNNbVc82n4GFvbJ58dHOQgUhgqqBV+/Pig3orIkoKt0fYOTbXb9FiR?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8deaf5-870d-4018-d1d6-08db1a5ae729
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:43:13.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +FOiI3+8oQe1jiasyVoFl2Y/X7qhAY/V+vRxnJXVdoj3HVnM5xzfeZCxvJLJMTRvsEJce4Qru0YPfLyREKCltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8702
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Added BASS and Audio Announcement UUIDs, added OCF for
BIG Create Sync.

---
 lib/hci.h  | 2 ++
 lib/uuid.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/lib/hci.h b/lib/hci.h
index 50f385c1e..d01e6f8ee 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -1731,6 +1731,8 @@ typedef struct {
 } __attribute__ ((packed)) le_set_address_resolution_enable_cp;
 #define LE_SET_ADDRESS_RESOLUTION_ENABLE_CP_SIZE 1
 
+#define OCF_LE_BIG_CREATE_SYNC			0x006B
+
 /* Vendor specific commands */
 #define OGF_VENDOR_CMD		0x3f
 
diff --git a/lib/uuid.h b/lib/uuid.h
index 84ff46cd8..a6bbc3770 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -164,6 +164,13 @@ extern "C" {
 #define ASE_SOURCE_UUID					0x2bc5
 #define ASE_CP_UUID					0x2bc6
 
+#define BASS_UUID					0x184f
+#define BCST_AUDIO_SCAN_CP_UUID				0x2bc7
+#define BCST_RECV_STATE_UUID				0x2bc8
+
+#define BCST_AUDIO_ANNOUNCEMENT_SERVICE_UUID		0x1852
+#define BASIC_AUDIO_ANNOUNCEMENT_SERVICE_UUID		0x1851
+
 #define VCS_UUID					0x1844
 #define VOL_OFFSET_CS_UUID				0x1845
 #define AUDIO_INPUT_CS_UUID				0x1843
-- 
2.34.1

