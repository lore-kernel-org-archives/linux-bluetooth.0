Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0091BEB8FB6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbjIFJeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbjIFJdy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 05:33:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7B199C
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 02:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAXR5Niz+i+3lRm+AsVyrsU135tytxeNjgUycIziB4imEpQ/WYB+upirTPz+mG3RAWB0KY+AwfMRaTXpI8IM/a9yEC7HZtDqL8Y17HE6YkAUm0ojLKtQnA48B93VK7agARGzaB4eSxtRT7A0ZWxXogpBsA+y7WIqQFANi8CXh0J/cUDELR4/BV5y754hVCPousFeikctSU0pprGm/fiUvVy2tN98BV6pUilZ6W6pjvVWJqzrl2rBbHsY5TcAxfOhUVyuJfywMGwNpVU3nnFOebiZA/Etd6XD4HRkZsQsRU6P5s5olJuWjl2bUQ96bmunTagnErvV2xuEqEO7JkZe9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOsMwqbL1NP64qLKmI0jnf82HtEGaxZJqli8c/gmLcY=;
 b=ApJiplXvY0qbsAcFtmBzZZqLx+R6c19kOMdJ2lDOirCCRlfhlYjS0tjCGklw97+XUEHoiLkRDeofcU94R/ubKyXSOxm1yfc7FiW7Cwl+y7j3gQrQpz9XC6cQ6PBsocBCzjAI+VTpQwqQtdm265VLlN+TSQv3lilYnRlwzc5v+XnDxU0vCESYsDfE6XNSNIiZwyVSO/SFLZUsWOhGp7G37/usHkPusWxrpH5Rr/RC9yDheEzfO2/Hcx+FGY2HaNTn2K4lLirDmFATfxFkMpaSzw0nTk2+p51Nukk10bSQaGPL3ncbi0Ww7oXoVYDk6nP2WPLX7Nbp+fz4iShlgXeObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOsMwqbL1NP64qLKmI0jnf82HtEGaxZJqli8c/gmLcY=;
 b=h1rYs2QlJi/n78sbK3VGhgcCG2WYiizBZabwHqqLQoyF9+DbC1W4mO0ZBisrBXvus/zKE9p5I9dNEAqKCQ8m4uALG3c6dGYRS57CDKC65JS/3boNKtovfDEyM70ecGeFa+XnnCOUqRd1zTQyuTvPW67WkpjtXgKlh9bWpdawYRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 09:33:39 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 09:33:39 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Copy BASE if service data matches EIR_BAA_SERVICE_UUID
Date:   Wed,  6 Sep 2023 12:33:05 +0300
Message-Id: <20230906093305.11237-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906093305.11237-1-claudia.rosu@nxp.com>
References: <20230906093305.11237-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::14) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c078348-f635-4f45-ee2d-08dbaebc5a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1frgFS0p2/b84XvReWZABiNyX8kvW38bQCJNNUi40EGxFV1Kr5zb9XHtlVImxdU8GWm/e3P+Jhk/v6RTdWpitWRip63mN+hF6azmBNIgT7tWCPIkQJc5iIX5XXhv+AnLwAcckXAIUcULHF3ndLBNCX5IXWEvSmRIQco54baZL6et9+hnmGmWjtkq4wAk1hFe85JWldYlvzxgY8GfJeBQexj0sAlK00mSHQqqqtaLpZACOezVjBdnLXstArtvyKGsaLog17AWHCNHmdtZND7kTA+TbGa+MTu93793HoB3yKRNUV4x0gFWfwFDgUNbhIw+FN6fVExr6gG4Rr/WNXlWeOS4olr15rdPskfMR4MdpITHa2hqD6ZFe+3RXv7/AtBUgGvzHEVdp9HzGm0bDO2vhAtxs8Iv1N9jIuNo8m4q5uJWJI/yCojAv/ENZRDf5wGKz0Tp+fYMGHbtG4G+gWmBgM10VupwUkWFEnNGzXWUG3H8h7lGGN9xi6meNeeQKuPBA6c0HBwUbUFMAlqfBzTrEPUVECDFhcnJWb2ParVtyRUsrQ2ys24aByIRuIE1VuIOz0wyd/uc/h8w1bNKx6C9qTkqqyWyUWIY+PnOWoI82exwyTmpjQCjbgqyV2mNAOxU0rqu1scvoApwyaBGNLJSWwbLOVxQG7S8oYlQqCPrJq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(186009)(1800799009)(451199024)(83380400001)(2906002)(38350700002)(38100700002)(36756003)(86362001)(6512007)(41300700001)(6506007)(52116002)(316002)(6486002)(66556008)(66476007)(66946007)(6916009)(2616005)(4326008)(1076003)(8676002)(8936002)(478600001)(6666004)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wsMoR2MFp0bXR7dFISgnbxgM6JD+SwZ/pk7BwPUW2K+oVJXdeDWhx6m8t/WX?=
 =?us-ascii?Q?N7hJGhTnXxRxHR+Vn9Ts3xvaI4SNHS3hGhW20vMKaSluct26ml6EBbqP6jwY?=
 =?us-ascii?Q?aeklhS3BMgN6cJ88Fiffd9QH1JkA7j/I/7aiVZSkQJaJm0Taibgl+6AUfBUg?=
 =?us-ascii?Q?2BG2ioluG712BHLl/IReFWPInU7NOLbN/voBS1XwQ89Vgo7ow6uxGw7kpjPk?=
 =?us-ascii?Q?EWnFobju+4Jg/9NyHTChkKZGu/6V80HyrLHt/l9fksyr7Ym7Lb+GJcT5I7Ie?=
 =?us-ascii?Q?E1GHLHUj3FHLUnAHPo+n/TKt+GPGnZzvXIO/sAVnZ/a9mYOhaRfScAwlUdKA?=
 =?us-ascii?Q?Eh3X7OzYMoeJbFE51uThBUfyHzvzdkVKgnX8NtCEAh4aqWUksMBVduK0O8s9?=
 =?us-ascii?Q?+EVsApq7X46gO3tCFdv8yeWlMYsVtFoVk8znp9dtjnDs1jXoBNJJGrzjKCSG?=
 =?us-ascii?Q?0RG/EQXZj8ww8/lsGhMQJxXMUOKV5Q/SEe5HZ2hAJnykc5hivviP3O7gry02?=
 =?us-ascii?Q?Aksg3rHNb77qFmFKcJjTN/Nfr6E7TJb+Ce1CW+b7jy6RYyTgHOslUNSFpAJT?=
 =?us-ascii?Q?kRYX3YOlIjdLL+uI8D8YZ2rQu9isjgjMmSqOOYptkjhwBK9UyDGwWUcU9tjz?=
 =?us-ascii?Q?bA2mjeyJdmT0iIJGeRihNeO/j9mIyArGXI5HPh3knbA3Bdz+PJtFhJtef0or?=
 =?us-ascii?Q?ORuxg6Opg0SVcBbm/B4a9O9uJ5LLENhsvYxyPHhU7jo3kN5jNRQDKBlGySr+?=
 =?us-ascii?Q?deacnrskTsxSovk1s6avZ231Krdg1F81yOUKcSkkiV+aSv8sFpx0JdCsRx90?=
 =?us-ascii?Q?vZ65Hy79aqyEQxRh6Cfnh8RD83jIhyB3SrHd53wZUC1xplLj8G/wOjAy/S+j?=
 =?us-ascii?Q?4hQc2oRQigYyYGExjSTNuRDpOwekq8tleah1kUUvE5SgWFuT/k+T3CGqtz4T?=
 =?us-ascii?Q?XCkdYPe5A5zaAbuJOcm9v3ggTR9W1Bct028fRd1mAOvWcswLKnqm+zysSYpv?=
 =?us-ascii?Q?Mf2EuvhVhXvsccJWWQNgXog+zA3QRt7H9iXXPmqOrlCeZ/zWxynk6Wwfvj3D?=
 =?us-ascii?Q?bz3SBpTV8bmzxB9VbpomcnMZNn/MAEJ3w7mfEZg0IvuL54ubUyc3j3Lp6C2Y?=
 =?us-ascii?Q?ggFV0Ch5fGcS10DPsA8pkAETxJxmWqn/BkGl7XPM9Uc4TjaDaArFZYq1VBKZ?=
 =?us-ascii?Q?TxGs/Co7y2XVJvlAU6P+bOcxPDuw/pxbN4R3ZwiRgE8tIvOekQ6IXvPFt/6D?=
 =?us-ascii?Q?LgYnZGaK/J3P/w8I/FjwbBGmUELtkW2AhXyY0Zv9oMR6KTkpuxrDbqbMJAiH?=
 =?us-ascii?Q?m4ARm21/Fn6/TILxMEjlvxMbwwc7adDVp7sSHADvGvbz91uST3PmgAtxFo6y?=
 =?us-ascii?Q?FdxOSXPylavt7LGu0nqAXUYMwN90r9uAyjsk+CMNqjEVw0GO0coFzfz/4atn?=
 =?us-ascii?Q?Q3WSYSpI/qC8pYZQ5KIiLtM1MmDUVdyS8uWD5r5X810Mxd/oERL+U8lYvbs7?=
 =?us-ascii?Q?n+EPRVzBHHSjCXlvh7RJMkNySL0Pj3Gr4dJ9MvJB781jtZP8U2Enrs56812L?=
 =?us-ascii?Q?11s6QlCPYmQxBygNrWShvA+mROnmnu4U4eSKr0oa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c078348-f635-4f45-ee2d-08dbaebc5a41
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 09:33:39.6030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVlTKnhoES4dUFumOMFuUTYMFfMChhituDOK+v45FvjTUcp4wDl5Vx7u/plAVvgAy7GP7NXk0W3LeRPyBOVakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Copy the content of a Periodic Advertisement Report to BASE only if
the service UUID is Basic Audio Announcement Service UUID.
 
Signed-off-by: Claudia Draghicescu <claudia.rosu@nxp.com>
---
 net/bluetooth/iso.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 16da946f5881..33ce9df7f65d 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -14,6 +14,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/iso.h>
+#include "eir.h"
 
 static const struct proto_ops iso_sock_ops;
 
@@ -47,6 +48,7 @@ static void iso_sock_kill(struct sock *sk);
 
 #define EIR_SERVICE_DATA_LENGTH 4
 #define BASE_MAX_LENGTH (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
+#define EIR_BAA_SERVICE_UUID	0x1851
 
 /* iso_pinfo flags values */
 enum {
@@ -1458,7 +1460,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		len = min_t(unsigned int, len, base_len);
 		if (copy_to_user(optval, base, len))
 			err = -EFAULT;
-
+		*optlen = len;
 		break;
 
 	default:
@@ -1648,7 +1650,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 		}
 
 		if (ev2 && !ev2->status) {
-			iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
 			iso_pi(sk)->qos = iso_pi(parent)->qos;
 			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
 			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
@@ -1771,13 +1772,20 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
+		size_t base_len = ev3->length;
+		u8 *base;
+
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-
-		if (sk) {
-			memcpy(iso_pi(sk)->base, ev3->data, ev3->length);
-			iso_pi(sk)->base_len = ev3->length;
+		base = eir_get_service_data(ev3->data, ev3->length,
+					    EIR_BAA_SERVICE_UUID, &base_len);
+		if (base) {
+			if (sk) {
+				memcpy(iso_pi(sk)->base, base, base_len);
+				iso_pi(sk)->base_len = base_len;
+			}
 		}
+
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
 	}
-- 
2.34.1

