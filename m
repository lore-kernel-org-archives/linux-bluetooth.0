Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BC3E7C4D0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 15:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjJDPcO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjJDPcN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 11:32:13 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C46BF
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 08:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5fg71bgnGXpD5l9y8XrHCcpdwuiZFNFMjszyrDnFRs62LN8gLRwmUTq/3fFn/3DGhyyLSqfH7rd4Ngcikepz29EiLgghoTd9aY9zFiMu/4Zqz82Xl3zH0sroYMR/igX8lgwJ3PO2DdCu8Ejy0qu0WPS5iKU1WUahPTFsXZcsIMD09/mi9QZVeM+d/0a04gCYCTV/LUaPr9OuhXAx0SftX913694sNc/GBbdrwlaD9+k7nVLLF6sJLb411rlgDCgF4myJjyS1kUZuoMQoOw5o8EBlOLmt2fVMArfU7bG9srIq3JerF7IRP2/egI7yubu6h+c64rF8Cj3155y6nOtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MduW7ptBFfkMrM8Xi2votwl069/7yHTmERVsEOqtTJU=;
 b=WRY05t7Lov9eLBVZmHq5kverE+wY7h0NEhSDujZ+a2kjs/1X5YLLBHyUocprFcQ7FhtLlmYhZ9gBLdE3KUmdLAYKhSd1H6RBJMduVUUMN+7zx/xpptUNDOgTnxaKF5RMSWYWLu+UkAeeIDRN/F84rAVCuEkywcSfAzLtt1y/+/kBPbJ5mTCPNbP8ev9S4F3NNSSyjCN4h1zC+UNoypJe/Lpe4I7sMncgsqmTS/uSWaqC8SIbiaKZ/YL3+93AqcOaTHiRB7o9qPd7BqnehkfJcSWlcjkUAF6GAi0TiWZ6+hnTMBsfqwF7vWCfz+kKiTKrwaxwZwvW544fxpzhepmBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MduW7ptBFfkMrM8Xi2votwl069/7yHTmERVsEOqtTJU=;
 b=FImgO1X3q6pA6iyws4HNYI+Kk/rg6XU/NR7vGE7EfCl3UWwDq36F327GcO/IH5TC94HjoDw7SlO2q6ZUl8u+Dbzl+kgwDmh2Ca/PysFc008cyCKBJu0RyG+PQBWkP/2V6lCVvR4yp+ZmbfarPpaGmupuWGzlsBVQAbP2jRIg7d0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 15:32:07 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 15:32:07 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/4] btio: Bind listener to bcaster addr based on dst opt
Date:   Wed,  4 Oct 2023 18:31:47 +0300
Message-Id: <20231004153150.3051-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
References: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0902CA0050.eurprd09.prod.outlook.com
 (2603:10a6:802:1::39) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 5008703f-31dd-40ed-0621-08dbc4ef116c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QECC0UyzF2lYvcV9AMQfk86A38s3V87GNcH+OChlGdCNKzQJT9rVWx0Zq6hLrJTFrT1s/diyv42zopSBXuCcfaZlpPK/V0fBpO0LMqzeRtIYGkSQBYKAEvI+pW5tP0c1O5mns6GkTHYs9BrKSl2xavrqSq22A2D0kUfzbSWdwAqKbp61xiFb27pOhzo5ix8rDprV7tFJmlql/54ndu/LTdLgVZcWhnvBwW46tTiICus18CqyEcaBMLDTOi98wj3aMnkZ/iW3SNHsjuIomitZjLvqnxqFJLO1rguvHUJEccnpdn8LwMFcMKOPqexLa3NWK1ZQp6NC8hnV4xBuVQQBu/vWySTxkmSVZ59HmIRT3a84lVp0RipE18+qGq/r7VqEOnXkjHQJrq3CE1IShwGvKMhCxcPpdOIeYsYZh3Zfeqr+tIWfdnEwJB7vMPBBusI79gzr2EmnmXLYn/YgXlaQJYSeoOeAS85DVkYR46lfwGg5WP8lVeHRKeKOAv7EI3g0uHGjZWfAfImiZxPg3Cpxm2VSCt1pyjq/kgW1tp6SXLv06zTrjv4DXJ1/nGzYdxX8TVofv2Zkni5FYEGfLd6r99RWppW95Up5rxfBsn6TgthFYAUDgfVEOUwyUGkOqUF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2013699003)(6486002)(6512007)(6506007)(478600001)(6666004)(38100700002)(86362001)(66476007)(2906002)(6916009)(4326008)(83380400001)(2616005)(26005)(1076003)(41300700001)(36756003)(66556008)(66946007)(8936002)(44832011)(5660300002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MS/9ffbZvBlEkQIPyEjGg/FhLu7uWxsPfMTzXXLgJvfZdLTkUVhBRC3Og2sf?=
 =?us-ascii?Q?WelrSgKKKD5VI2lOxfLgYDrYvJhovoxVuW/BRZi/hw19l+QmIYBY5gbn0Utp?=
 =?us-ascii?Q?MSRnoYLwf4AVMbD2t8FauD11WTcRk5/OZi06Nksb3u6CMpLm+xG1vC7Koi6x?=
 =?us-ascii?Q?ZCwrh5ht+MN6jqir+gTeHnEa8nMUye4D8VHJ5rn1oD1SMP7JXK/WZQjpHtVT?=
 =?us-ascii?Q?8itSH7vx5zb+ZQKpe7Q+lwo+VnEzcslq1ED/gwNbBz8oKxKcV7HeMkq8xwVv?=
 =?us-ascii?Q?msqDzXk94aqI+z+ahsZCquJsOSX3uqQvnVHRvO2iOp6ILBuT4qHeAjQuRVnA?=
 =?us-ascii?Q?pkTyVFFl7JA0AI2q+Z0or16kyADWOj/+BqwIaWvdiavd0YAKPCDr9tbeVGgH?=
 =?us-ascii?Q?s4jKdxe+lGKNm0+DG6hcAD2YPH8O89yRCdATrR8E02nAaLh9c7SLVfogEPHz?=
 =?us-ascii?Q?Vv2VE50SqgJhkiS07Cvz1Bp8AG9WUIv/PfFpgTI5p8f8pvyDyvrnsih9bfG4?=
 =?us-ascii?Q?x9/jPY0D+XEYWVQ3jT8CZ0XpxdIE18PDVPNsmZhmvERJ5xyra2JjbI/B5WoW?=
 =?us-ascii?Q?mlPnFSwNCHiDeV3ja0M2n43TetSA5Jxz6BqtfCueDE28/tW4x1EfuQZW9nEZ?=
 =?us-ascii?Q?gh/QLdlLSu8FEfxAQ2fij7j3lqqRbLpiUT0x+FFfA873kCZZt9gratxh+f22?=
 =?us-ascii?Q?DSTdjWSms9l/RFRjLbo66dujaa1tp/hKdpnq0V9ZaFr7WrEpG3qj71xW3X3j?=
 =?us-ascii?Q?U3boYOxLJZ0qMWEKOOSKcJyc2GzV78/hKdSnWNt3hY76D127YfHRSmJE+4f8?=
 =?us-ascii?Q?0DkB0WuE0t23PfkHsb9o4Ys7ejFIv5Zx/1OmxFLQO+wRvOjpXA+xNbhUidol?=
 =?us-ascii?Q?EdLiEUcpb3oQSRAdmzdnjxwpV1N29+yslZwNrc9nhHLFZ1mgiyopYnuriSCl?=
 =?us-ascii?Q?yPmg7LF8LrAqMCrOPIRW1gPPXErsfc7bOWRIM5HDPtVq2hF1ojgoR33NFi2w?=
 =?us-ascii?Q?46mMW1e06DedHG22QE/B46hRRFDpi7ZM5av5/gM2xZmXEXnfRJtgbOEBK/8n?=
 =?us-ascii?Q?i5L6TXjEB5Rwvz4/c/QLuJ4e1Z0ASswfARPZSYVvcvSUx7yHYvYEnCewZ4tO?=
 =?us-ascii?Q?CNkVx4l4RpROmBEHaIg+vlugik19AfJDCaKMhZW8sGPypZXZizdK6LZuoEkE?=
 =?us-ascii?Q?W3XDvw1HUtrveu/7BhuB56Ych5UAwXEWCnpTc9ElSZ8atPWaD71LsKGKx9za?=
 =?us-ascii?Q?hyb4LbpijVAA0pZpOqrVNZHw3OklnOMQmPIi+sWPWNAkzNIZKwoPA585Hwxo?=
 =?us-ascii?Q?Ut+NWPIC0zqQtwlIlse9sZAnPk8QN5btqGUWCwXHUWQaUKYq3VKx4K5gc4CD?=
 =?us-ascii?Q?X1YmC8FXd0AcFyxNtKx5DyliqmrF6SsYvVfK+ZElwHf86hpyM9hgx921M+Jm?=
 =?us-ascii?Q?xnu0NvoKHueesRkXtib9cWgq/WFI+2tJjblpmJRRjl9mQaPRIRlsMlvf14It?=
 =?us-ascii?Q?vKbVFbG7jCTYIcQROykvSD7gO6rOgDhnhpkaaueo8acYVQah6uEBcmV7Am0t?=
 =?us-ascii?Q?uAtpHc4aHgbZGl8uILbCKP3dCY6m3pHrTLQWYMi3yQhA2dGK+fGvZ9TKxLQL?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5008703f-31dd-40ed-0621-08dbc4ef116c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:32:07.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PD+MXNEgDBoKlkK9YgybczacMTZfGkSKm8wCBYND7GHXejMEgbjCIOAxmnaepxE+sUNTJI4JcMxcb+QCAZ9oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7790
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This updates the btio module to decide whether to bind a listening socket
to a broadcaster address or not, by looking at the dst address.

---
 btio/btio.c          | 24 ++++++++++++++----------
 profiles/audio/bap.c |  4 ++--
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index c6d056b89..d45b8240d 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -774,16 +774,21 @@ static int sco_bind(int sock, const bdaddr_t *src, GError **err)
 	return 0;
 }
 
-static int iso_bind(int sock, const bdaddr_t *src, uint8_t src_type,
-					const bdaddr_t *dst, uint8_t dst_type,
-					uint8_t bc_sid, uint8_t num_bis,
-					uint8_t *bis, GError **err)
+static int iso_bind(int sock, bool server, const bdaddr_t *src,
+					uint8_t src_type, const bdaddr_t *dst,
+					uint8_t dst_type, uint8_t bc_sid,
+					uint8_t num_bis, uint8_t *bis,
+					GError **err)
 {
 	struct sockaddr_iso *addr = NULL;
 	size_t addr_len;
 	int ret = 0;
 
-	if (num_bis)
+	/* If this is an ISO listener and the destination address
+	 * is not BDADDR_ANY, the listener should be bound to the
+	 * broadcaster address
+	 */
+	if (server && bacmp(dst, BDADDR_ANY))
 		addr_len = sizeof(*addr) + sizeof(*addr->iso_bc);
 	else
 		addr_len = sizeof(*addr);
@@ -798,7 +803,7 @@ static int iso_bind(int sock, const bdaddr_t *src, uint8_t src_type,
 	bacpy(&addr->iso_bdaddr, src);
 	addr->iso_bdaddr_type = src_type;
 
-	if (num_bis) {
+	if (addr_len > sizeof(*addr)) {
 		bacpy(&addr->iso_bc->bc_bdaddr, dst);
 		addr->iso_bc->bc_bdaddr_type = dst_type;
 		addr->iso_bc->bc_sid = bc_sid;
@@ -1930,10 +1935,9 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 			return NULL;
 		}
 
-		if (iso_bind(sock, &opts->src, opts->src_type,
-				 &opts->dst, opts->dst_type,
-				 opts->bc_sid, opts->bc_num_bis,
-				 opts->bc_bis, err) < 0)
+		if (iso_bind(sock, server, &opts->src, opts->src_type,
+				 &opts->dst, opts->dst_type, opts->bc_sid,
+				 opts->bc_num_bis, opts->bc_bis, err) < 0)
 			goto failed;
 		if (!iso_set_qos(sock, &opts->qos, err))
 			goto failed;
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index d70ad872e..cab68f779 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1566,9 +1566,9 @@ static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(adapter),
 				BT_IO_OPT_DEST_BDADDR,
-				device_get_address(data->device),
+				BDADDR_ANY,
 				BT_IO_OPT_DEST_TYPE,
-				device_get_le_address_type(data->device),
+				BDADDR_LE_PUBLIC,
 				BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 				BT_IO_OPT_QOS, qos,
 				BT_IO_OPT_INVALID);
-- 
2.39.2

