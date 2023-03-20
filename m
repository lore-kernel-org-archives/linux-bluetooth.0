Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3881DC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjCTOiw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjCTOif (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:38:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3934252A6
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRXom/yh7d6I3SCLBpjTcijloEq2Fr1L1QI2WPdKHeDaS5vatCB9r9SPPuUeAA0UoPrIU5gluEDaN+Q9JEdKOD7xDUmQMZrYh+LGaa3rN6gNaTuxAwj4No6B/EwxiRWqJaVuKBYxAUTfr9XMkzEcj4TaJTEVzlYd7dj96aUH2FsErmZ/Ru0WBSrsyhcdMFvoXG2lbq2wBgwfz3BAivoJjmlTLLdVq5aZDlpHOjruaaeSisKMX9kmGULHzxcqrw3PgMDJHrKNPuGHJ0fDrAWPxn+v3aSPDVty7paQ5SO/KXpst1+YdJisXBSS6eK4p9GNQcQV0CEPecg/fsvU6o0afQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqmMZmWDKsZfMJW7NK5LGUZesJaZTR2T9i8SorsNixE=;
 b=DiT3H2dPzKfz8RYFroNfKMWnhn687FnMW0eZpxvWs41HkfNM5xEalzLXgVS9OvKGvfi1jhFv5waJtHaH3a2Th06joTyNO20wHN9Ag6Jx4f5M42qhZdDnjVkdzB0sGrQXPORt6RVLUSydjoRGqO5rkyFjBnyMsEZAj4IAbyUR7wch6jr+oHTKXgGMwIKA4LEAHlytlNPr0cmjrxrGcbbRcw+A/26o4KMLbEhSWBa4bCEyGFZs+vm7T80Se+mqJZR9xNUCd8LjMCMolp2N5RhsiftSxoryawPUBfT6Cy/KVGsC2dk4/bONTHNdVTYNSMuBY31y6Jcw49ioPF+7YRF4zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqmMZmWDKsZfMJW7NK5LGUZesJaZTR2T9i8SorsNixE=;
 b=LqKyrQgH2oPvoSIl/DL4olWCH3KnZhhXwT9skfb2MjQTzCOA5ZUhWggJG7GC9zkYkoOYOPpGSoUGdgED91OJoqRloQH1scq1ToP+ddUSFaF2wXUu44cSSrKz2oyIuSrSjXu53SSO41KjpWQZioEq2Xj60H466bO3uWFK+3QcpfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:35 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:35 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/8] emulator/bthost: pass unicast QoS structure to bthost_set_cig_params
Date:   Mon, 20 Mar 2023 16:37:08 +0200
Message-Id: <20230320143713.25449-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
References: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 362cdd58-35cc-492f-c5d5-08db2950a5ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7FYITG6NvLOUmPVT8GzzW3aYR7hfe+Dowky+WO5nmEHOLH3vaRlLnOVKHlj2PwTw+Wdt31CbqCPvanVe6aYcB1oQbQcUwvYoXIRe1IfGtSxdM3esJFAGrxaa/lrXz1QD4kM4Gy3ltre7+Nye0UJSlTbQg5mofmVpPMqEDs/8gKAoJwcz6xhJksFfAtmm3M6VHP45umVV8TqT20gghoVotYYJDSnYl8PvR4/q1bZv2sAMI56FPE3/BG/wUu8QV+bMBsqGUctgbG/S4EV6fz/Wtao9LcqWC1skA6IcgVxwR7dp6p/fauPNA+ZS/mrSMNvA3lFM3aQJ0f/BbpCKouruKqK9xxeRW0mHUCQaTCGTPXwR6h83MK/+QL09sCyfhh9kyxuFUxFIFt1PzyNMho1dldGA+oeWHiwk+nMtibU/II1sVxLnoik4+pHXW0Mnq//u1BALXhNDMnKAXMd34cuktesfucgcmq+f2u7VWOXtnE7H2Wiue/cqqJxt3FN2NMvt/3YRZSAQcYgQzfZmSN8wuYS8/NwbiujckZLDRuduznhliIQBXAqV0tQJnmOcH2ywGbu8OZ9TDUTQbZ7C6lbmYi+xRDuM03MDYkXDtLJNwWxO4LvPW/RUHfCtlgFuUx7YyY5ifWnLkBjHnmG2qQT3Gq4jJeSEUMCrheZRogU1VtlyR4EaU+zBlniVyVu6jGaxmgfExzwcrNoAgLm7SHegjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(8936002)(5660300002)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CYqQEBINaqIslmtZKG5bp6qdQLVR27BlX1tyE21UystA4Kh77pgAWsIcbUfJ?=
 =?us-ascii?Q?3IuKv5GSggqTlZbF8p7ywAlpVW2eDXxdHQkyqukfDt4iDaxT/QdeZVhHPPyQ?=
 =?us-ascii?Q?5GvyxVPV1H3XOh/uMeoSu2zcoZeMw/CZqSc+lSe8RaMRH6rgAMHa4RS4K1fd?=
 =?us-ascii?Q?Xjc7IsEBWk/vKq40Tr2bbKiE5EtdCJ/pXyQAvhqEDxF9M02wEeQX4ndOy5jE?=
 =?us-ascii?Q?MoZ/7+IxIoaePP9NrZKk8qKqnULrtjcAHZo7wqdr5IlsBvCscLA+OaFp+qFg?=
 =?us-ascii?Q?oS6px/pMO67TSPrHgQ1KZyhMqzkYwY9DS8dy46gCGSkAiro1PNEdHdi4VYNW?=
 =?us-ascii?Q?y2EymdQiRD4JyQ+znW80tWT9sjjuT4Iym+T54cF3M1VaYaeLSfR8J5IFqL94?=
 =?us-ascii?Q?XSYcmupKJwpmaYXWQ7cFpo0FuyHVCfvYuyXCaOKLmp/qIemtdHxo3pqOjlnH?=
 =?us-ascii?Q?i1gdZcfhtm33uK3cs2fCGSFPxynnzkdbXYFCYRoi/Nef8SYLnDyaIGTfXjcw?=
 =?us-ascii?Q?NzJ2cxnzCaZMH8Hz4Im7CuPq4oekWIuRUOCQZJPg0SUH8OsjRZCOmudG1iFh?=
 =?us-ascii?Q?c4ShEcKWwq497DbkOmA3ZeUUGF2Ad4UzKnEgfw4Y4BZE6vIJEOtMssoRhfr9?=
 =?us-ascii?Q?Gof2FFcqw/E9HNBBP73P8ZVYfxRPyOm+K4GTB5KW3LTcFcaAbn0Ttfc+ThdD?=
 =?us-ascii?Q?OmZVqJHyRHsYx3K1uZeu1QOR2wMwkFEwfH3IteryjOltGS7It4oEihqrddaD?=
 =?us-ascii?Q?vXiBG/1MWJT9nCJPgqKE4HPDOPtAr4fWFN7SyhEdSGCi9o0qG9GAhsMMAp9B?=
 =?us-ascii?Q?TfFOCzBJ94V1WesDmLSiNGgkz6XtmrmDgV0OQltrjjJ/jfJQavuyT/fyIKOo?=
 =?us-ascii?Q?TTj4BL5aTBZxknlb2PSpxA0PzOuPjvXK/UrG8ppcc0bFov3BfBo3oUqLtQ0k?=
 =?us-ascii?Q?+EbPfce681kx8GlEpZ/ujP99MdxE+xQidMrX6t2gWN+/jjhJ2EEIzQWWInQS?=
 =?us-ascii?Q?7N+SCgb3DrEVA/xgB0Q5X1inLxcbMOu+B2MzbJ9WBCQsbPmkk+vccWvceG5W?=
 =?us-ascii?Q?/WDdsyOxlFdX4K6uQnbE1ozeyDI8H0HAi8h0k5y1pHivys96fqRawLFZ/Ttf?=
 =?us-ascii?Q?hIGJ+SZUOPOv1rGp+VUlUS1zYIgyUIIm2VL1ejxGoBdJme3ui9fgxzG1R/RP?=
 =?us-ascii?Q?QkVhVrzCvbj0s+4H9MCGKI9Xp7UhW9UBpjg7vM3+yQvtXnHaYqFZnsFy7N0i?=
 =?us-ascii?Q?EmIRhD59P6s9O/piBaOtL+Kkh7PW0ZZH2jmcEVgb2S2Dsjis7STVAvmDdJfN?=
 =?us-ascii?Q?gnjsDq556RVDaBJwWbzvYmBnEsJxqarQs8t2uC9jci/+8EGvbMHyIpuAwolH?=
 =?us-ascii?Q?+vX1eXkGRkDZU+FPY2dLp4lnw7lMqzWZHENm+vnhhT2vApuAny2Dg63B4NQ4?=
 =?us-ascii?Q?2zPxEzmpYY92Bp/rxe2EEGmx1jeBI2FaV3zC26U1onqBNk+uePJjKAdpOLR3?=
 =?us-ascii?Q?jUGfQKutlyenU8d5P5TeH//L6jEfQTZ73hKBX84itZDKQAWtL4LbGDEhkWB0?=
 =?us-ascii?Q?2ds1tancETGH9pZ/KnZTV+On5GqlOpmdkSqj/9Jg4rRwmyXJyOKK0qtCk6wn?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 362cdd58-35cc-492f-c5d5-08db2950a5ae
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:35.7511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9YsYajn+FvNA6fJ5j0J9k1ybfUKNVIDZQaE2pgWUhrWKGcRLHvyZxgkCTWtxjTZV9SAADRGs/co/MupExiftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Update bthost_set_cig_params prototype to use the dedicated
unicast QoS structure.

---
 emulator/bthost.c | 3 ++-
 emulator/bthost.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 4671fe17d..80e4a4963 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2012  Intel Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -3171,7 +3172,7 @@ bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr)
 }
 
 void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
-				uint8_t cis_id, const struct bt_iso_qos *qos)
+			uint8_t cis_id, const struct bt_iso_unicast_qos *qos)
 {
 	struct bt_hci_cmd_le_set_cig_params *cp;
 
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 92182687f..68aef62be 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2012  Intel Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -106,7 +107,7 @@ void bthost_create_big(struct bthost *bthost, uint8_t num_bis);
 bool bthost_search_ext_adv_addr(struct bthost *bthost, const uint8_t *addr);
 
 void bthost_set_cig_params(struct bthost *bthost, uint8_t cig_id,
-				uint8_t cis_id, const struct bt_iso_qos *qos);
+		uint8_t cis_id, const struct bt_iso_unicast_qos *qos);
 void bthost_create_cis(struct bthost *bthost, uint16_t cis_handle,
 						uint16_t acl_handle);
 
-- 
2.34.1

