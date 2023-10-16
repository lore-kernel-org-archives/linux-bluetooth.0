Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C03ECDB474
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjJPPqD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbjJPPqB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:46:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCB83
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:46:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MypEWCfL+Uj/wAPKI/UrbGUSyr1ykPjgFHU8cyxBaTvg8P2JgHv8Eir19x+HZgXCbnhZEGRYysN2GMTfbDeN7b3h/UY3VaqEsqRbmyFYNrD5OVvGNyrniE5IB3pg/k3o/+QiOCcPGIOkHAGJmF0TBURm0kSXtNzmUDW9d2FBN1MreDswlkHtHqsrlbNlyIDC6HckZtRDgtFSCbpSZk04vYE3vn8HQE25D/mL7MfdTOoTWgOlbxaamXmu6cRcnSN/mgOYg914ZJoKQO2+Bln0z4Pya3b4VTWH1V2zojVRV7WiEZb8T7agRnTCzd8i6mGEMEm5Xb+yVaEzHQXTgROLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWULvbIhclQk3c2NnZs3mIBs1Bmi1aE4jjNZz0QXtL0=;
 b=W8HnUkTx6ZPKThONvR+l5rrWNV8P7MUTK/kxyZ2e9hK7XbxDmdSyruQ5M2BugvyzqJ/fqNJ4z4G06gNVpdwqXTsbqdnRx2pLOuocIQO5eEd7HCrCn9kyxr/cxdtOckKM9RLjC6xHSHeePt094s+dGJHGMrXP9GvlwDzxAPJnkRQKU5xLKjPk1A5CSC8PEHyIszKlMk19YAd4AxjHiBi7Mc8jSpeuDCU9QITPZorl8Dv7X9xyaLIxEcPKF6NMWU/ituhcTpz8le5NXcd+MKWF4vDFUxnHuGPsrhTzIeq34MeriukgLy9gv3Ny8FLgT7PQnZ0XFZxxFkkAu0/Y7d0S+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWULvbIhclQk3c2NnZs3mIBs1Bmi1aE4jjNZz0QXtL0=;
 b=B3JAvjaFU5vxg+wnQ2NWQ3uAhh3Xx3KReyUDpdp0vs8vC4oiZjT8/GjAfPHoNgBd5zbFcVEupxFRrWh4C+R83l2Z1bu4DgCIYgFmcQr+ws/3aXxtUukpJdV1V0EK0pX3T0Ug+xdQ8QGrrZQl0ktL9VIbc3H54+GKoUUd3saFEoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:45:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:45:58 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Allow binding a PA sync socket
Date:   Mon, 16 Oct 2023 18:45:45 +0300
Message-Id: <20231016154545.2883-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016154545.2883-1-iulia.tanasescu@nxp.com>
References: <20231016154545.2883-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0072.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bea6aca-0328-41e6-07d4-08dbce5efd98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8d7LSQYCCNI2o0NHokxAqMEO89ToOVOPNeKJDdy22LkjBAYtqzvNkKwz1cMN/4yg1aeSHD9gvwZRlrxMGo79og9qitk3iagNLhbBSLZwoohILKUt4l5HOhkZPaIKex5rqH5/rNxRqNcokATSPKKMz1SYl8CKmMnHm1hvm0Gbr5U+RUoRAoAr6UeqRMu9+eXmayDTCIqox5UDv551vxsMZDx+Sfecs6bn4pZWxLlCzBbCHqzHvKi6qw+pZg8gsnTEN6n6YCo5KT8r7T1amcS+5mkU1Mcalr7EBzhm3EdaBZeFp/wdTrhSX1pGkvl4oFtLNc29e6UUulNOrqiPkZaebfse+gLw8xFIsQu+wEdY3PKGZsuYE4u5GPziEZKf+eCV1u8GKSEDVp7PuHH91WA80QCFTf5F0XaSo8uh8YnqMcNy8g1Rprli1i2r+xQll6Du795fOhV0sOzYnlAnEh3njr1h8poYqttdpU+tCno6tXxwlhdct2hAGkA36eb9Og37uQbcmXHeKeBx5+A+huZn4bf93+pGcMF8Ei5EAyAl172cSKs8uwwggiPqiec+6Ugd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(66946007)(66556008)(6916009)(316002)(66476007)(86362001)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(41300700001)(6512007)(6666004)(6506007)(4326008)(2616005)(26005)(1076003)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APVzS94YDOIGFhYwb6BlfIYslJb5c8D2gpM0Y3r2Dou1uUwK/HMYXANUlm4s?=
 =?us-ascii?Q?kU/YuzwAuXGIKBOl6k9Q2dTkNJTMpa+Wy8pV/o9a6YN5VmdkB6/BewgX2Bc1?=
 =?us-ascii?Q?7cC/zBUG+brgq8hbo11kl1tz2L3PSGLcwLuitEg9PUwxCaB1quR+GaWMxE+a?=
 =?us-ascii?Q?9WxY1wbajgzxfEcW4O8EhZIP65jbgwIdIFgT4z8sw2pzONXvLS7rCpsJ9zD5?=
 =?us-ascii?Q?7LbhTI/FX67wMLzqBizfFsPBprMpH4vIbYUixvl5DGfsR6NULvf84NlVdP3w?=
 =?us-ascii?Q?IZdBsVac/lDICUrd/BGcKE7DEn72ROQUlBT2avFcvqQ+QV7Li6cjutxckiXw?=
 =?us-ascii?Q?AJ1UspbRiZ7alF00x+ZHa5LLyZo4+ppZuv8O12yduu4Md6FxarlWxBHHnKmc?=
 =?us-ascii?Q?Ll1oq+kzvOpVL6lVJ8ULPRsPmuN4ahXPuCxPbMnlJ1SUwmomnHxtvzo/x3eJ?=
 =?us-ascii?Q?i/klZJxO1wPsRAcsPt61CrKRwDlnpUz4e6nR8GUhWOuhNa9OJbyseV/pQLow?=
 =?us-ascii?Q?xhluXqqCjaMwbdq1pVFU1hzKLwx5Hp/hdG/1yMkZ5FAU1He6RQeUObL8rKt6?=
 =?us-ascii?Q?TtDJYJhKbLYd2sT2e6AWmAlcquW1Bj/eANQ1XE2uC6sMX1VceOPOo0a49FuG?=
 =?us-ascii?Q?HSO47bpGvWzrRLr3icMZ2QdQi7CahLM4mKmibtTxg+I/7XIksbksdwBm+5VJ?=
 =?us-ascii?Q?q9LFVPqbEJ3lZqU+a87/tYBPpJWjZVyYZz0Stxt7MjS8OIf0jgw8SCvW5E2b?=
 =?us-ascii?Q?PZjWl7Sah3e+cqL9ZaGCNfGwk3y9Cohdn/A+auLx+yi5O46NkCGPGyKqcNyP?=
 =?us-ascii?Q?Msa/0Q7Fbt9uPR3V+dWVbwFBNmUr8cZgL3i6YwlOKtz9W6NjjjBZzuCfODqF?=
 =?us-ascii?Q?ZWEzS0XyF86Y0DyAyICmocJoLsYtzeeMDx7LYz7602hQOmEUJCFU9aNkS9k9?=
 =?us-ascii?Q?CL3RG/KCKONRrGFiebOtO+UxbRkt9N3rWxiAcZt0KgLZJ/U420Oiqf6a+P2I?=
 =?us-ascii?Q?3q7f2acDrmCfcZut0UW59n//hOT3ICVg17ISM41v9bAkU2/Ubl7qrAIb5guV?=
 =?us-ascii?Q?BkYb4o/W3ghxhKvD2FjzDS546wbdlWCdYr+g64eE74FVYhcewW4Xgwfmg/4g?=
 =?us-ascii?Q?6Fv9w1LLjAP5Z5krCNcNTD/Q2C8maPvdLKl4H9RXH3sK0uv4cbE6px5mHB8j?=
 =?us-ascii?Q?8Y1tBwsAI7mJ9exd4JA4thdZEgqU77N5jExglHzwm0pp5RwBgBE596A4z22J?=
 =?us-ascii?Q?5MAe5WmGI4zlLkcsLi9lPCqCrfx5OOA/UkPn8lI3C+D1/ffJRoO7H+5URUbd?=
 =?us-ascii?Q?zBRcQzkvgtVZ0sNHkEylQ1PBYp/oqoEpyRblxsiOu9w+uTKYVSr7RXD1/nit?=
 =?us-ascii?Q?F46wa2d5HGUH7tJFQdOYmPEu1UFodVicIEK1Oin4SF2oKBndCRT/nJYU2fRm?=
 =?us-ascii?Q?jtSsdkb4sp5mg/+DRfpwRskGUGWpBZ2JiGmsypbgQXBYG/PnJioau3y+XsvO?=
 =?us-ascii?Q?6sY7CrVyiU/ObUjSo1+lrSNhPz3lV2fZwKABYjagmD/t4RB3DDvqJJVKGzTY?=
 =?us-ascii?Q?pG4OKBV81RzwgR4Z3AkO+oBHjsdhR+iQhndg9SExAzqTUd8FIKZLOsyL4eRO?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bea6aca-0328-41e6-07d4-08dbce5efd98
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:45:58.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHbwac0wdusjt+vwBuP0mVu5I//nYgE41d32G+3tw2AeH/qiUesVXsYazsHuMXq+uTWMfIuohY5nnOz38nvcfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This makes it possible to bind a PA sync socket to a number of BISes
before issuing the BIG Create Sync command.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 07b80e97aead..6938ff4accb3 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -813,6 +813,40 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 	return 0;
 }
 
+static int iso_sock_bind_pa_sk(struct sock *sk, struct sockaddr_iso *sa,
+			       int addr_len)
+{
+	int err = 0;
+
+	lock_sock(sk);
+
+	if (sk->sk_type != SOCK_SEQPACKET) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (addr_len <= sizeof(*sa)) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	iso_pi(sk)->bc_num_bis = sa->iso_bc->bc_num_bis;
+
+	for (int i = 0; i < iso_pi(sk)->bc_num_bis; i++)
+		if (sa->iso_bc->bc_bis[i] < 0x01 ||
+		    sa->iso_bc->bc_bis[i] > 0x1f) {
+			err = -EINVAL;
+			goto done;
+		}
+
+	memcpy(iso_pi(sk)->bc_bis, sa->iso_bc->bc_bis,
+	       iso_pi(sk)->bc_num_bis);
+
+done:
+	release_sock(sk);
+	return err;
+}
+
 static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
 {
@@ -826,6 +860,13 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 	    addr->sa_family != AF_BLUETOOTH)
 		return -EINVAL;
 
+	/* Allow the user to bind a PA sync socket to a number
+	 * of BISes to sync to.
+	 */
+	if (sk->sk_state == BT_CONNECT2 &&
+	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
+		return iso_sock_bind_pa_sk(sk, sa, addr_len);
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
-- 
2.39.2

