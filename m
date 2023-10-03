Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB24BE7AD57
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjJCOSD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbjJCOSD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:18:03 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2047.outbound.protection.outlook.com [40.92.73.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17AA9
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvdqLMzl8f+69Q9rjlmc1PJpPzyL0GSNHDBZR6Ui65FXQlu99UL/FF6jWiwTs8gJKMe9HDKOrqnpPRZfPqBnVYyrMq7JIAfhKjpfXHi5yKXVs4hku+tcWuN24b9ZgNVPa60Z3Rg5/7qbQXowNF53p6yScxSzI8vawSF5qapP9J0erpovhax3i1qkaUO3OWcqGxOPtU6boJuOqdSrFmAF9ayH4aTplzhktwSeDlzbQRpNxGejkXFdsUY0T+kq2OncP2MmRDnNiXLvIeb/CRooGhw0HhYdLF6h84G5R0tkK/pVZACjVZ8NdZ+9t/RJ51ic1yb/gYueHsK12nrAcyC5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mR+/CsvKAhMhOiVXC5+YlnRxqhMC7B0mdQ71KcWIKTg=;
 b=HVtClwcFs4wXktLEhIFQkN+/1xi3EpaZExKJI8VQcQ6qOUi4kijRPu3ohPGWUY+nrbwuQY5vLujqDh/PFAZYDKEMHBDWhjroguL0bkMKQEKYfclIqPk4gHuXVmJb6Ag5upiVWHa9qHbqodp0nmbzq+iU98OOjDwz4X51TuH9tBq0pdkwTIdv565yMp6zL67DoXdqGUzM/1D3MliqRUQ16hUowlns+uGlZ+be+g6yqXxGsGBkE+ZBreUY0aDwb9mrTRFYj0jB5g118UR5D3WuNqv6Ucv9wHZ1DXviJwpXSOyu0qpS0JMNlfLie/sH1wASofG59PKAMT75OaPzZQ+7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR+/CsvKAhMhOiVXC5+YlnRxqhMC7B0mdQ71KcWIKTg=;
 b=VDwMYn10jgtxwjggv3S5KjcZcuQ/c7v8M1mn8dbzXXAKXGlY04TMQMYxUNfgmq77YJTMiG0jlr64Ok1V5FXi1ImBRMt2LTMLzmaskj4Mq4e0CkjXvCV3Ia8P/HsKxPEuu+M/ZTwy3kdkfgiAlr9okcBnyC50o+XqwPA79swBlkUs+O5X4SCFWsRdMedd9q+NmOhAK9UzLMI+/JZ1dGJqlE9COCOvmseCm3jbwWSdtBUJyhy90wr9/RHgxgO8Nid9z7qWB8BotT1NoHxroP3SDHaRgutWQSD7NTAJiqfzAyb1qooaL4qS98rzdIk3Ia9W7kpx+XfsuL0wW0MZ0XQN5Q==
Received: from AS8P189MB2602.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5c0::20)
 by PA4P189MB1437.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 14:17:57 +0000
Received: from AS8P189MB2602.EURP189.PROD.OUTLOOK.COM
 ([fe80::94ef:9fb8:bfb5:e10e]) by AS8P189MB2602.EURP189.PROD.OUTLOOK.COM
 ([fe80::94ef:9fb8:bfb5:e10e%6]) with mapi id 15.20.6838.029; Tue, 3 Oct 2023
 14:17:57 +0000
From:   technicaluserx <technicaluserx@outlook.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     technicaluserx <technicaluserx@outlook.com>
Subject: [PATCH BlueZ 1/1] hci: Add LE Extended Advertising Report structure
Date:   Tue,  3 Oct 2023 17:17:16 +0300
Message-ID: <AS8P189MB260298A86DD024F75EB934CCC6C4A@AS8P189MB2602.EURP189.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003141716.23955-1-technicaluserx@outlook.com>
References: <20231003141716.23955-1-technicaluserx@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [aK4vAqxRu1wHL28sE+45GK7v5WmRO43cQ2RQvYswzuT6BfKrs60vHB8GOFxhVhPO]
X-ClientProxiedBy: VI1PR07CA0288.eurprd07.prod.outlook.com
 (2603:10a6:800:130::16) To AS8P189MB2602.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5c0::20)
X-Microsoft-Original-Message-ID: <20231003141716.23955-2-technicaluserx@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P189MB2602:EE_|PA4P189MB1437:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f9838f9-fc71-45c7-00fa-08dbc41b8a49
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPORm8TAwoCWZYq75/E1w7Vd/qipiSxahIFLZrrsUAAKUkjyRc8dsVnLRE0lHgJd3lJTwVtx46HoMyAUp9A8bvYMtPcO8UPwaJwL8g/RLmKb+sRJ6QK8haqXQNL6LrfWWZsKl/lquGrxx2oT+vTkn76XtQVY4tVuc1f7/a3bI+f412bhPOCeJcS7dv7ZIIXEZPKBE4/9mU/pHyS9icWziIW4RVO7fbDMTZUR2RWNh+Mw9yMuOnydjYdTKv3h21vMXcgt2CnDtok+kJnAJOTq/DkSwnCaZIHB6cj1NkQwlTMZWKE/WaCSBDWm42re06q416xpSzKsp1kGYirP5ilIDwy5BTtke+JFIXTLx/poxFDuiPGXPQrYHl4BF7LLLD4pPf8qDyLNOxX4wD7FqZ6O5IHdPrHC1l0hB/tlFq4/VXjsca0XcLoXw4WAKrBqbskwLB8tHkIoa15PEwgTwAYGKHda0NUChjbf0mnyKeukFivwZ4t8H1jxHw415pEKV6nX7r4UZq6aJIIp3kkO+wWBm8CGcURcbG/ouYY/dMyuupRZgVVqNJME1XvVBpnJ5IKsR74VzD3GtZKFaGGxDfnkYbLG90UEQ3VzWH4lqSzwW0FQwfHE1DrmCZ18f7N3KZwy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGAc3DktfRDJFOs08R2JvyJaks19nBUAq0fRA6tZwjeVytdhMIfsEUI8MlBM?=
 =?us-ascii?Q?/cior6WEaDbUXgdQRj2yG6qLDO+muEZakmPAYZoDZDi7xgXNYgeXcxdZApzX?=
 =?us-ascii?Q?X6epADFb2p4QvmMwSIWTm1ssO/eUrNhBhgCblY/5ps/mvBB4x4lkQMpt43RC?=
 =?us-ascii?Q?u91ioKkybWDWSDwYRXfXHupGI6g6sQOokPLm+ZK9j+fc2JpRSBZ0tVI9+wXO?=
 =?us-ascii?Q?akIZyEbI4LDbp405LrvGBFO4uJPq6/k+CrgYi97l1zm577jSgrow36s+Zspd?=
 =?us-ascii?Q?updhrdqYe/MvT1BKVUMiRX+XVpkKABKFgkjQM5sgfeMRltQ/tSspY8ZciREe?=
 =?us-ascii?Q?GWzhRPVJybkDp0YN+OOkd3PPhVRKQHlhfJLmkO3f/KVJ+uDZ26AytTebGV4I?=
 =?us-ascii?Q?PfjgF3Fp3Vq4uhviIn/gLqWu5aby38oi5R5S/91jnF8/ltf0RP9OCmD37Jd1?=
 =?us-ascii?Q?miQgMGMSQWHWyQLbe9thajEga43nUV6MQx9kwQDQPMVNy9bf58JSUn2KWPPK?=
 =?us-ascii?Q?xD/ZjcU6QvaT9nky9ytuj3loQFRHkbUf3Kf7lFihlMsYvfhHVreUWoWbo5M5?=
 =?us-ascii?Q?svX2DmwjOdoSHPvo34CtB7CjFLWGPtc6htwZCJ3U27Zj/BIjXpNYJ+eBiP8m?=
 =?us-ascii?Q?eJUxD3HUBnV0RpBL4JPrIpgdRt42lUY4bbSZHVVOS7Wi9HJVtMqDFJVxpXuy?=
 =?us-ascii?Q?RNEZauj5VEWmd2ZWSJjxxAnbpca8STwWxjbPVmyAUOBrf1fgrISLc6wtPiWW?=
 =?us-ascii?Q?pcd8UqLk/1JPM2wWwsOMeOq2LU1c9VwLCbVtEKg/oIuPqaVvTe5W7DWu8TYc?=
 =?us-ascii?Q?HqlCdbFDwYV28KefdQZveZrkPQJ+TxL2ZJei3Sas9l8hJ4FcifgId3glx3Du?=
 =?us-ascii?Q?z4xyGq4grMAw5aaR4x50fWIdlf+3nwJ67q8uCe32htcsZYPJk+tZFDKtJ/EW?=
 =?us-ascii?Q?lTbDcN5y/bePwdzfCspluQfJpeANl1piq6iKrjlDO5Q+kifsMln3wNvGeme4?=
 =?us-ascii?Q?qkJU8IG49wYo5xlOnRJOfKL+QjRSupc0gENW/fSXtKT+3vowjLMRCG2hmiyJ?=
 =?us-ascii?Q?jN11T2LAP7xQuniTyIyvXn9HwcVLrVz89BqaPmL57t6zud/qJJMI0qO//0uG?=
 =?us-ascii?Q?HcOBv4tAYOHbRDmHeigelm9llnZp1CRITwl2SNVFx8gwuWgEqK1zzxShmV4z?=
 =?us-ascii?Q?n1pxXF+JiiI2pyyhg7yNupAnQxVEQYVpeJ8BzWItzwczVSDV8g8UPngTqEAu?=
 =?us-ascii?Q?Wj9osvHJ7px9TKkXWufnbD3pWE2+vXXeRnEM6aWwPQRisKlPFeWqP9FtMgdd?=
 =?us-ascii?Q?KFI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9838f9-fc71-45c7-00fa-08dbc41b8a49
X-MS-Exchange-CrossTenant-AuthSource: AS8P189MB2602.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:17:57.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P189MB1437
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 lib/hci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/hci.h b/lib/hci.h
index 50f385c1e..24466cb7a 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2164,6 +2164,24 @@ typedef struct {
 } __attribute__ ((packed)) le_advertising_info;
 #define LE_ADVERTISING_INFO_SIZE 9
 
+#define EVT_LE_EXTENDED_ADVERTISING_REPORT 0x0D
+typedef struct{
+	uint16_t evt_type;
+	uint8_t bdaddr_type;
+	bdaddr_t bdaddr;
+	uint8_t primary_phy;
+	uint8_t secondary_phy;
+	uint8_t adv_sid;
+	int8_t tx_power;
+	int8_t rssi;
+	uint16_t periodic_adv_interval;
+	uint8_t direct_addr_type;
+	bdaddr_t direct_addr;
+	uint8_t length;
+	uint8_t data[];
+} __attribute__ ((packed)) le_extended_advertising_info;
+#define LE_EXTENDED_ADVERTISING_INFO_SIZE 24
+
 #define EVT_LE_CONN_UPDATE_COMPLETE	0x03
 typedef struct {
 	uint8_t		status;
-- 
2.34.1

