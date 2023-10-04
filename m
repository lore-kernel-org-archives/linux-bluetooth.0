Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE4EE7C4D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 15:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjJDPcP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjJDPcO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 11:32:14 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D3C4
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 08:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fAt0ehYI8QBw2rOcqV70FOuG+ng2KOjC0FjhuQGH1RfzPj324HgtVQQBbMMJjtwtpoppcTFavRcI67TJMcHSqnJAi9ZO8HZ+NKuy2Fqw2nCYF0X+LbyBbho5N0AEtZm8/5TN+86XyCatzOMmshCvtwPe4HRAFuRJOskwiiWMFgLgEnxPmCXbVafu9I9BqN6HzMxZpX8LbANHhe7wxonsGJXdhuKpclhr1jewggJxmoPWxtnh0Q9GCgFsJM9T8b2DoQPttU5EbYQmmI2pcFMQB6Mf7vDy6HkO5xUCzmpuuXksHI5/58pCXh4LM3DX7f609fCxmsLmNRJs++3FAu1vIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDVmGNFMaPG9C7QtsB0jzOLSXgDA5uxPcW8KfqSpvVc=;
 b=KMtSltrg+/QIKaYkSjGqjx+JdgzAZ2RI1MfHIpVcGhl3kFye9JR+JHCP9zNokhBWDlYAuHTREt22BSA1+fDgVh/1a2KJpF5t0YVwvgGvSS32cee1MjgEfQEqMZjUXC7m/ZqO7rG8cXpWQivQaXTV8riIBySkgBE7FMPUvWac+1m98IPYTz4ulhlb5sB7y/JusbCBrRD9wolk/ZbJuwU87QPvYDsa7hKbXGnTTtjjWztH+YPJeSrHYMKYums0rKC4OP9PloKVN8D04iYyzotWFQtTcnY1k0ZBZnheMq6L64joeO27lTq96U6Jm1xd9R4RBPRxhM/DDuriL9hYqYzf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDVmGNFMaPG9C7QtsB0jzOLSXgDA5uxPcW8KfqSpvVc=;
 b=mhCF80T1cJhIq+N51QHJBYkOKnls1LEF11jofb5Uq8iVvsC0BiDuOFFhgrq1/jLMPJ9dUA2u00moslg5WHT9ht0SQ9ZyA5kgCeh6LBEwNLxUmzrnBo3+J0qKUlZOtQPikk9u+L8UfQl+lP9MbXE4dK9lDQmb/We8+2z73QrzPd0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 15:32:10 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 15:32:10 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/4] hciemu: Add support for setting emulator bdaddr
Date:   Wed,  4 Oct 2023 18:31:48 +0300
Message-Id: <20231004153150.3051-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
References: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:803:14::37) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c2579a-4ba3-4317-de1e-08dbc4ef133c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2JDcb8oM/6VpRxJ0ALlwGyvNiSs6VBukYmNGt7CbmY8HG93NTP7cf6oFm4hdMiyCNQyWAY+P5MBWgBHeTbdu7bZOtAoHFqhfw56tTuxFt9RrH82FzS70DTcs2CeuSAFMB83J7QdlrGZxnZlbROjvdjxYym/tSKgOUMHHgtrWe4YpP0NDD0j/Wq7gArkQYdv+ZgffXG1WEnrN1nAmRGyi9JvReZqHi1MekIyScxql3YSIJUDN+LlxuoF8XrMI8z/LLhmmnVz/D0XrYM92UFGWdBNWcnUPynbjEa57ZLywAMd0nLWVwcYPVAbpvCootKzWzGJak+2QTERsburUMDLdVfniZWkqr3AOruamAVDd5TiRpC2OAjCJQtKbnXxEpSn5af3yfJaoBe53DGNTwA8h5Xswr8P/W4QBH6tiH64NzLq1k5Hu8UmkcjDy8Jnyd0z2gmIINwPBysTX32MwAktbIej3YDj/s47CTBxYV4g0dA6Hpat0MtCT2+EW09Er2oSjwILnFTr2WR2Wr4B1T2mKnVvapuORPq4C1NxJV4PFR/hNraTZ71n9hIgwmjVO7Nb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6486002)(6512007)(6506007)(478600001)(6666004)(38100700002)(86362001)(66476007)(2906002)(6916009)(4326008)(2616005)(26005)(1076003)(41300700001)(36756003)(66556008)(66946007)(8936002)(44832011)(5660300002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o20Jvv7pwM5HFpFnJvQkmFaNeCl8QmLEUKV5dOwNiyME0m/f8Vm9Q7jssSa3?=
 =?us-ascii?Q?9pjK3n43iEg+SAFycnLgYxINAHWc9xDr49prrSCc0gpTM7AbcIEfMoU7IRWZ?=
 =?us-ascii?Q?SVL/N+iMeKeJaZJFbwYXt9/Wlu4mRYmH5KQXqcKiU77ha9k9TcH9j9YxjqHr?=
 =?us-ascii?Q?/lnJZN4t9zOY5qO0VVElZ9yfio6Pqm+HO6rObdYFqf5YCrd+SwOj3FLfiIvd?=
 =?us-ascii?Q?QggVqKoqEIDDm06D32+avJapM8DXg8feYpKJ5Bqy8sC3JZZ3o0UdtTNHbtWx?=
 =?us-ascii?Q?sBmBjDkuENQq8IQv7P/mXyBrbX+p+ZMZxEgpVbZiPdvaLj+R5Q4bKg9cjk61?=
 =?us-ascii?Q?Uzy1Gk5jdvVit9xAtPFhlYiIybaVXrdAmUMnbYyKyXBoMBkM0/eaiqUk8/4l?=
 =?us-ascii?Q?HS45gdoE8SGnFllCwGXEwSsnqHTZbAtbqGtX7GZ8Bzqt1VDoaPupsMhziKln?=
 =?us-ascii?Q?pKt0ahdPoS4v8nlrnNgl70rD0EzxdazlsQL4l1EGtK8IIK857Hg/UQ+heSFY?=
 =?us-ascii?Q?ivbsKLw/v7fU4PHQXf0PDtuEfxXsmsvPDKLlktpF/pghGFypQn96Vc+fkJTt?=
 =?us-ascii?Q?rdgpYADFfpkHGrwixXv2DUhUpIPdJWSlz3FVqHg+Exv0+G81wW630ShmwURm?=
 =?us-ascii?Q?72HfQuyk4s3n3TdaZmbMwobMiNxPUqtuRErQBrsXwsZeP2TTBLmkGlxsoa0U?=
 =?us-ascii?Q?nGq2C0KpH88yJt4RKpmujJq/bckVTVbLsT+JKSMSBm5pYVclWeul40MAY68/?=
 =?us-ascii?Q?vzGbH68j++ZRyffTGNDgcXcuvcIkywNaOWjcgLwZ79TD5Yqs9lMRDULodT+S?=
 =?us-ascii?Q?RA0DAeJ2b51dm/ESrrrzi11Rie8jLwLlGRxgznKGiSPdwejVXSaevC6HTz1j?=
 =?us-ascii?Q?YOMserIKj4VNzE4ohvH1y47PPER3sUGdw7uE57TMXG1O5cde8T2ISBFIRFKD?=
 =?us-ascii?Q?Zom4NzMQN3OHSfy7qjOwPLAmuT8GMW+aAIWjmEHzpRR6E5P8UnXLRYi5wFLQ?=
 =?us-ascii?Q?2LO43/Gtkbkc8S75ednwUBrjFqpsGnExfpJ6ddyi5r5mm+1mdEPf/t7ou1JB?=
 =?us-ascii?Q?tAqYxcN4V6jGcaFPRreHs+IWc3VbrBEzpGqHFrZVYfWtTCs9BjmaCNffJADe?=
 =?us-ascii?Q?HeF93R83C7XHBMiZNwE11Vp/28mNF+dlw35sx5okKvVuXg0EtndJzzB3APvy?=
 =?us-ascii?Q?+UhXSvpe8Db+juuhW+laR5thP1ZkHLyG2QkfSN1SVbWy4KmvTGHimbb9SgJ5?=
 =?us-ascii?Q?z041gchE0Ev6cYcF3y3CvbSXuYVmVTKllV6+24qv+c5TX2jOQKjmlRbfrZSp?=
 =?us-ascii?Q?Aeg6Gg3PKaKr6Mlez3ns+aPoj/vqKZqgkDizV/hwcoFfs63zXK/tRhnIz4YP?=
 =?us-ascii?Q?zmIxdWrSMCnzoxCCBxHG9MCV3QPBLBSxOgZiIXkbyeUuBUVQD2AdYcUo16Wa?=
 =?us-ascii?Q?5nMKMcPg/u5sZfHCRaEZDjikvrcHHYlbb++VSDMHe8IVpbMnk3WTP33mQW/S?=
 =?us-ascii?Q?NRuqC/Z/difbD6vvnEmysGoASepY36lv2S10hhIhz9aINSrU9H3ayWu4hlrn?=
 =?us-ascii?Q?4ZfDi2WwAiVD95j1rwYoOhIcFFSp1v+0wdhw7wj5n8olyj49K7F/7fYX5W4E?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c2579a-4ba3-4317-de1e-08dbc4ef133c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:32:10.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DC3HUYRUCxHutIsa/RQbhqkq8waR53AoCKq3nLV0B0tGm/Py44N04qcj96VKcCFl0gxSAr7oPLDQvSd74OqjFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7790
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for the user to explicitly set a desired bdaddr to
a client emulator.

---
 emulator/hciemu.c | 9 +++++++++
 emulator/hciemu.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index 25874ded5..f13b4bda1 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -550,6 +550,15 @@ const uint8_t *hciemu_client_bdaddr(struct hciemu_client *client)
 	return btdev_get_bdaddr(client->dev);
 }
 
+bool hciemu_set_client_bdaddr(struct hciemu_client *client,
+				const uint8_t *bdaddr)
+{
+	if (!client)
+		return NULL;
+
+	return btdev_set_bdaddr(client->dev, bdaddr);
+}
+
 const uint8_t *hciemu_get_client_bdaddr(struct hciemu *hciemu)
 {
 	struct hciemu_client *client;
diff --git a/emulator/hciemu.h b/emulator/hciemu.h
index 3449eae41..dba920fdd 100644
--- a/emulator/hciemu.h
+++ b/emulator/hciemu.h
@@ -39,6 +39,8 @@ void hciemu_unref(struct hciemu *hciemu);
 struct hciemu_client *hciemu_get_client(struct hciemu *hciemu, int num);
 struct bthost *hciemu_client_host(struct hciemu_client *client);
 const uint8_t *hciemu_client_bdaddr(struct hciemu_client *client);
+bool hciemu_set_client_bdaddr(struct hciemu_client *client,
+				const uint8_t *bdaddr);
 
 typedef void (*hciemu_debug_func_t)(const char *str, void *user_data);
 typedef void (*hciemu_destroy_func_t)(void *user_data);
-- 
2.39.2

