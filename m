Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A5E810A0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 07:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjI0H7F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjI0H7D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 03:59:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41112A
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Sep 2023 00:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSv2ZZC/epRQ+e5ZAazE3XpUq+r8WMtquOLfm0vS3p+nZsttL7KKeiRX1gC2/3VaO2M9aySNB8rsfV+TIWGSpEIc1rphycNZU4QcycQqzUn1w3OPbCHuqELQAE0PdFhfQ6unhNj3A69glJBkdjdYbO9Cz108F2qYtEOTp2hmL8cCfU63f0EM2u2f8g5UI8+g556CuqIsjzBMcuxeU5ikjGJVGgxwFiB6ZIzR11e/+MQNnbS6iVXPYHpwDPDXrejd912CK5vrJIT4OmLt5JkF8rpzSPlNpcvFhWvTJwyY/JbtBO4uLizZW4oiNsK+wu5+VWcxpovGIlxNA5ivKuPQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECixQjPHC4ynBDHtIMoaTAv8GT8FLGlxCR2n/lPgoec=;
 b=Jh/RaQBxBqqu/M0H6+HM0/5tKV0Mdbh192JEjwAUg+V5C8xy0WTJNITQZWEC08cwz5mwXhWnWckjMo0k6Byb33UBNvlYtFFCdEXs4RzOPpV69jD/hEtkHPgFMpfn/UmbEJm4AhZ/u55UHM5IIUn6JKypGRbHXCrwSOL8I/PjqUQRONbFs3/z95OUsTTcyHRM8eNpL6xP7ycu7ivtlef0TPyxTFqDdI33nDvfAqWsQ5VXWc3U+9+PqHsrd7MErF6J3sjw3s/KqwHG+LxXFI69T9G21/QHCvmNcU7UNg/gMDAszqvVNYQWsmZejTuRSsQOao36I2xBWUuhaed4hiI5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECixQjPHC4ynBDHtIMoaTAv8GT8FLGlxCR2n/lPgoec=;
 b=T9J15qJqefks3LEGlxWw8MtFXLNLOnCv9GrcBlLHjhuL7hkHTLL8m6aCgMYstvAMxZZLmsMpFl9CoQe1bpXWjzPOiPbKC9lJm5/vXOupBQTPcer56AxYZDQtDBcCnzE55NESCV3xjt6qtMs2umLrssD9WneTa1llQ56BVhF3RaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7802.eurprd04.prod.outlook.com (2603:10a6:10:1f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 07:59:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 07:58:59 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Allow binding a bcast listener to 0 bises
Date:   Wed, 27 Sep 2023 10:58:35 +0300
Message-Id: <20230927075835.20125-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927075835.20125-1-iulia.tanasescu@nxp.com>
References: <20230927075835.20125-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0268.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 67130bd2-6c5c-4c1d-107d-08dbbf2f9b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: povQaI8Glo7TRGM7x/hnnqgpl8I7liwVFWHmxKEUaEk1XxB5jUFcuHaJng9ExEZX+o1DIt5jq5VWE+1dZ8RO/ziv5Jw6mtdFF4kc+iMvZvnCeZZ9AuX7CrYXwiJVDlhQmRyqCOlQfDH3iDJBxxzO0/ims42sXEnVrnePjNKh/7nVw4e/6suuOq9T5UsgIytER+WPOxyExx8vEbtCw3YokU9DrxlpM2SQG5++T+oxJV1Xirwr4uhqVY0F8/4MiY55lSTKw32RVM+aU/VJAM6YpTuHG8asdPcbO3Cix+2VpTLyhfRiEMMpxNyhoXApYZrIbfl7pA023aCTcSKCDGuraR0pHEJ3kQ0t2f3wDacc9h0lARRXBXskZ1edjf9HGGXbOsZvtykLaUFiF+plPno28uHRqU5Q271mUSqUe2av8iMVhzIo5AwMqcyFIXv6gmSr/KYuwcff1V79xikXewsWTN1kc2w5GBbDo6kEvN5xetsQPxsdpBnkQtlZc1Csbtj/04CbS5W/cf4hTFIZEe9pWd2Qk9s0+19AXN1eInoaNKKi2MQgupZQNPdpflzZ8OzN7BRMdlMWAWy9IauslAnmTySA+T5T/lnC06rlc8wRypzdTIaq1DMnxipB3ynwWKfa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(230922051799003)(186009)(1800799009)(451199024)(1076003)(2616005)(6506007)(6512007)(8936002)(8676002)(36756003)(4326008)(5660300002)(6666004)(44832011)(26005)(478600001)(66476007)(316002)(66946007)(41300700001)(2906002)(66556008)(38100700002)(6916009)(86362001)(6486002)(2013699003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?71zoEs76goKr5UJkIrB7zrJeoyL+UVnDx1a5UrFpSDpJWLooYKTXltYv5Una?=
 =?us-ascii?Q?23pJJRHAkc1uathTO4Ov5eo1dCP2XdVkUSv9f22oAynDIAhRTvo+/44tczSe?=
 =?us-ascii?Q?vY5ZaqckdxkOhJzS02pudxCRvn11ugmU1XsizSJmM1wRSceeF3Ibx7+vG6mA?=
 =?us-ascii?Q?Nt3woce0b2EW+tJlu8cNBoJJ+5PSJrcY/bPax7RGGSvabDX5mR/pZgCLXlNj?=
 =?us-ascii?Q?pJQhKDC8P+rCLUMaqb5ODva5a5DjpAD3k5lF6cXR+8+Knmwub79GSUsBnevw?=
 =?us-ascii?Q?+71v9jYHguk+QeYoPXWcjGafnpytXclncYDyiZasI8OEQ2Wz8Av8Dur39faK?=
 =?us-ascii?Q?sQa9yTtENs2xqC9RxcazOtuvu5UjrRkV0pDM4z3+82tkri6LA0gm4Q+iSm6D?=
 =?us-ascii?Q?kPoqKS/6gxjTjfEXervllAy2UFIH+k9JR89V16ZY3UScV6H6Tfck4wOEalhD?=
 =?us-ascii?Q?dskK+ntbS4HG2fbQI+TvM6xwS6boLF6p38kzFvyFmV+uwa749OR3fcGNI19E?=
 =?us-ascii?Q?jxvrr01J89D+x3ZFzgbg0JyX5WmcuPcaOjgpWOwQW8BqJnnfTuwD85Duu/Xw?=
 =?us-ascii?Q?pVUVCCexP+uyavoeC7YyrU/n3HZVC0QugK0NXEgxAJrPpEdJ/fnvwAh8rzNE?=
 =?us-ascii?Q?BbWW203/ab9OFXsXvW3HVy0qrEzEWaB4cANyT+nynCPmTn8JbyyTqATkB3Up?=
 =?us-ascii?Q?RffVVIGGpQWmQISIWoWlRtdhJ83RyVk0Wj+1PHmoRWU+kQG/SBJefBWtb2k4?=
 =?us-ascii?Q?jQhebPrcuaSAH1ImnO0Y5mH4Nz/xgQ2X6HHNPasENxVDMXUpREvt4bMNsScd?=
 =?us-ascii?Q?Ac6z0FU9/3CWmxkK4sqlXja6UK0uYLoF2iUeboD1ztKpDtyppI7LXv7wEosA?=
 =?us-ascii?Q?avwfZlqV+SCxudvzrNZWHrB552tXsB8U/qc1YpDPmXrY9h+yRak17vvfdcWs?=
 =?us-ascii?Q?krIxVwrq6PZLyDN7Exj5i29vdG0fGjHtZgmDi/Uhi2pCKJCoquQO/wDMFD+y?=
 =?us-ascii?Q?21s6PJJJB7zv8wjIyB34UkH+rDNf7LBcHpHmcEqDhQ45i/WhBwt0aBkS1i03?=
 =?us-ascii?Q?ByylOhcQphgIu7COgktzebXY+nkJvLqN6cXNwdLxuYPZNi9fmWP4NHRFT2qx?=
 =?us-ascii?Q?9xukc2iC0apBYd1qkX5B8Elc8dG3uVoMM0SOk1NXsKOCjNnErAZfx/9btrRk?=
 =?us-ascii?Q?Z+qecQcky13B/kAt+Xguth2kzxKJFsn60laAcXXBvhDsDv5eH9PvhBaToCw+?=
 =?us-ascii?Q?MnlkFeNyUmwZe9ldtA4TO04MJAldfxTMuuj/LN55aCpevKbWUzOEpZT00S+6?=
 =?us-ascii?Q?r0xfGXgSqP2x9XY0+CMWr0iCBYdCqbvEd6aHMtAgm6PqeaEXE6UVoXqIhWAC?=
 =?us-ascii?Q?xoWz5Jfjbiau+wvAVaMQB8N0WT5XROYYCtHGWsGT62psB5hMGNstvp+taVR+?=
 =?us-ascii?Q?xsm88BXZ8AqIKLrRNLstwO9YXJaATAAmCyGcPE9GuAi+wPUraeHiQH4cifwo?=
 =?us-ascii?Q?5v59i9k66sJ5lVCYs8iI8FmPzt0pq2p+ZwX5KzIVZKaAUDCMInl/xNVR//nP?=
 =?us-ascii?Q?0g0GCrABbWpL+A6eArF76xLQD655x5L9uzbrSgnZ475Es9lBQX/OxIZY4SI5?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67130bd2-6c5c-4c1d-107d-08dbbf2f9b5b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 07:58:59.7180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pq+gvSdUxI34q6z7qe8FoDOSK3Rq4x6/FQ07EFCmTVOSXT+owRwFC4Xu4QAE1JCOTdutkcKxjq5JVM/z4mWoBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7802
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This makes it possible to bind a broadcast listener to a broadcaster
address without asking for any BIS indexes to sync with.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 net/bluetooth/iso.c      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e62a5f368a51..c4395d34da70 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2138,7 +2138,7 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 	} pdu;
 	int err;
 
-	if (num_bis > sizeof(pdu.bis))
+	if (num_bis < 0x01 || num_bis > sizeof(pdu.bis))
 		return -EINVAL;
 
 	err = qos_set_big(hdev, qos);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 2132a16be93c..8ab7ea5ebedf 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -790,8 +790,7 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 	BT_DBG("sk %p bc_sid %u bc_num_bis %u", sk, sa->iso_bc->bc_sid,
 	       sa->iso_bc->bc_num_bis);
 
-	if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc) ||
-	    sa->iso_bc->bc_num_bis < 0x01 || sa->iso_bc->bc_num_bis > 0x1f)
+	if (addr_len > sizeof(*sa) + sizeof(*sa->iso_bc))
 		return -EINVAL;
 
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bc->bc_bdaddr);
-- 
2.39.2

