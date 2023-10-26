Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF910C25B6B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 14:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345339AbjJZOv3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbjJZOv1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 10:51:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1391AB
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 07:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P31p8JFC/NS9oSSXb0apH2I9lHfPunGrSjce8qkosRpRGlK3z4aJPAtnUFgRr0VMW4FKPigEbp1tnwIJaLDKbDL6++qyognDtAS95whPlzzpuKXkfM/erQuAhPrqPIZMLnL3VqhbS34/Nq+qD2L+NB9lnY3nyIvQbRFVIcWh+LEulDSMQFgStKcHuRDaqAaKEjufRL3kpHSRtdfMzARaMJ4HGr88wJO4vjX2T2Kz5ZD/h6UIcsgH+xNEKw7VxxiXOeuyzB/LUniVyFhfhTSOqYDIwaiQUagWvOTeFo2xeIH3R6Q6w22C79oHtgdZgaZaPYBiWmvnfEv3Yx8/Bp3BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46UoylzRrssOQO0M/LJs8Mju8Ky/Xiiz74VnLZawUig=;
 b=nGJZHM1QIJstKz2kbGadQQ8SikBhQ+yby43IOnaPVYMHvupsCN2r4OvVSDolyC/RG4xYbDpat05MY+r7S7yrJ0fzjpXkG1AgK8jTGbr7RpmSYBNMBuaAZC4z2EY/gsDVqJuCYEQ7aXalrhRfFziqd2t3BuBQduSB27umjS39wQoZiA5Y/gnjBnp0J8H43R9tTXbpUPC9GcJRf3ip11oriNgFqKShrGr+706sM9xNkGDjMPqGvpHLtZTi1hPylaQzgbhSyHAkIWPZk0tCjdZgJ/MKUmSV/B6ImqRMDfjyc6wolrf69abX+wenzRDoqVuKw2TIUFjawCOQ/OsV7tIVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46UoylzRrssOQO0M/LJs8Mju8Ky/Xiiz74VnLZawUig=;
 b=h720WVacku37xPfy769UMX4GmMrCaYylnx2f97fdjofxb+WvOFYevWMSP90A9+9H1wvEMw4tBTheuIxW6glJDiZWNQRoPgzVtOPLPap6eI84raWYL5xdadQsx8V8/gjKaLH3UcKNsONTwhJmlJpHoTN+bxqXIzsFfXpSyf5kxwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 26 Oct
 2023 14:51:16 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Thu, 26 Oct 2023
 14:51:16 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH 6/6] client/player.c: Add support for multiple BISes
Date:   Thu, 26 Oct 2023 17:50:47 +0300
Message-Id: <20231026145047.4637-7-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
References: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0001.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::13) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 519c5b50-cb31-45db-3e98-08dbd63301ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +6nzozVq5jU0QJZBn4GOdKOlEoy+jy4aFDDEcvhjQGn1ez4sUNctmRa0VOJ+Ee41PoZ7l2eXFoUgReJnwVdFCtPzjzyTyIp0AiuYIqM/djts9JTsDpMujr9zPjV896Qynfz9oCjWso/Qk7gBIU+xar/0b6Hui9lW5mDHJQ90fTVLjy00INuny6O8iDFJK7CpZ69ZhXSNjLlqE2ZEa2iUD3ub9WTBE8JsLNdQWDjtCcm29tD/mWsYCrldApwSbQqf2dn2jc1q3fCq3TZik3OkVZZjxTn7kTbx4ZVk4cZZiF8UrlLBb/Cm9ovkWNWsEmV4FbS6nPm47Vt1hivkKkvlb7HyhjPNF2UV2HZsTZ7+06wXSTe9rNOKDxtvekAXLhH7ktN9NRxbg3efkcziIn6jCXGJNdSByLd8qS6QqS/0cCxafgEGPr6m7lT9ymXUdgBYJJMr5dQNHHDtdZ7UJ0TM0E28BZQDjtfUZePGZrz2fsLwNHy13miYBwkI0ZiYpcBHE/ZJB6ZoAo2z3+AdErDQVEXsLeY3X5C2nwG6GKuIBQGLI3+6oBlxJQ+utuoL3Xe8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66556008)(66946007)(316002)(41300700001)(66476007)(478600001)(6916009)(4326008)(6506007)(6512007)(6666004)(8676002)(8936002)(6486002)(1076003)(26005)(5660300002)(2616005)(83380400001)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vrzgiOEeeM+gkmDP0CDccfk6ccl8M2rjuzm9lktOy4VUgNEApHVQ2Vcyx9EP?=
 =?us-ascii?Q?qbhPmgcMXgtrzElT+Qg1uiDZDyJ31Uk6oJqjuc75F6owyEQmAF9KRGlrrf+k?=
 =?us-ascii?Q?I1rp5mL/X5c4J+qU+h05XyXP98KMUwAy/z4smjnRKrXHbtegd6laIqM9G9Vn?=
 =?us-ascii?Q?khpsgEQCgLlMIQnaTcXj8EkDWih599AYBiMbpHxbTrFV/BXpJf4zB7rI7H05?=
 =?us-ascii?Q?hY/bUsb5kM8+GVefeKfc5Hg5Gp/SElvrDMUJBj7QE8ZhvHoq0yOznU0ldKRH?=
 =?us-ascii?Q?3ZQk0GTxANSz1ZNBGT5nhp9JN1g79Etx/blljMSoW5TUs+cvzqIsihcfVeDB?=
 =?us-ascii?Q?2I22KRGxyIYZ4WhBFF9A/lzqqE29I23oQwup7uDsXBKD7PBEBLvYPS1+zcuF?=
 =?us-ascii?Q?UOWCBIMuSmbYO41aSRb7D6sn3R6aZIALsvIQbyln3dZnKG4qWmac8YfQOmeS?=
 =?us-ascii?Q?LKlpHe0VF9iIQEZ3R0dDAId3gqzQx/YSVym8dcdl/9bLHRuRvtdJfhsNBl8g?=
 =?us-ascii?Q?WFC3Cx/UkctT/ORkjKXDkdwaZ9OC25ODKDc4uXFqFmP3HxoSUVbF30zudFlq?=
 =?us-ascii?Q?Uk+Fp/RUv1ta+1/3Zu8zdDT1aflzOZG6p/0XCjMrPbt3SykGOuZVo6Uvu0A3?=
 =?us-ascii?Q?tN2F3FVxNSy5MQbXvRwVXpcI2paeoOS2JfWgLXfgD5RrnPLgrky1Cth1gaww?=
 =?us-ascii?Q?JkLb6o5u9KC+6s3NC6Nousuhm90P6pQEg5sAyhJsqonL2lcUNZ4vcp2DKHfg?=
 =?us-ascii?Q?9uGBi4FNN47un2KbnzVDwOkXboMiBS1+D9iaV2QMaVMxnQ5W4h0yWSQjv9qE?=
 =?us-ascii?Q?v+HYT6MsEoQFN37FO3T/LLpjskhbMlc4PpTD6z2+kZjb5NXhjEFWFjz7Xvsd?=
 =?us-ascii?Q?hnrw5kdzELNcebWv9ielTQekmrwNu+d5qOmrhlaEnpmLZ5TsBtaed84+FkP+?=
 =?us-ascii?Q?G/FJacEBdwr9DLX5TCIEs6+aiMjaP2Stb2ESAdkf5fH9hiu4Yo8hwMu2qY3h?=
 =?us-ascii?Q?qmJWyKKijQRW38KrR3l6bW1ZSCXyN/1FuW8mnhkpuIaPBkVbfJNEXQIdSVS4?=
 =?us-ascii?Q?Er/ppmon0fFBd9Ffa5WiPwFYsFPbftcf+ZOYOQNTKy3PrnjYT9nmP0PAwh42?=
 =?us-ascii?Q?lrDqbrh/9g3Wum1iTA+z9ewO39oyN8L3nM/05CSZVLeaO6soFPupGVKFSE1e?=
 =?us-ascii?Q?o6XDf0dq6z0aklaiv6bRcdOQWuaM9y8N+SEuvaZtTOE1kSyKGQJuZNmPiBH0?=
 =?us-ascii?Q?0Vm4r4MHBrPNq3oUPsnhaoPOXDpWRuVPvKhU7tCmvhky9EGG7VbabBY27lyF?=
 =?us-ascii?Q?edRnKOiSUG9jr4cJNApX9Li3aCKCL/1dFnNOg47H1Rku5O228hw1wK4kjk/A?=
 =?us-ascii?Q?Udnunk/Lx+evXRaLCNle51C/G4+Y6NACBprE5stIykwbEq+SwLGiD6VpvoQK?=
 =?us-ascii?Q?T068P9Apb2KWCkstUANMYUmKAN28wWDxSEd4TUJuIkQpf8f4vFR8AckxTNRu?=
 =?us-ascii?Q?IvceuF4oQNXEG2k6uBy0J8OPo8Pv4L8qYf3c+vPiRksEyQi+9xwVdtlyIOnp?=
 =?us-ascii?Q?wXBKxnDq5+CcHzvtoekmWNsJn8Z7l3dvAnFUBXvnjvULTPBY3hdesrqKfoGP?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 519c5b50-cb31-45db-3e98-08dbd63301ad
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:51:16.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CO2Jmis/ZfKfFN0Y8u2z3Lv4GscZssH0Ggj8/Ysh/ggAMxwirHd80Z702J11VIJGTbUYeBaqbvCKdwa7bvjI7llJIsjGnHpyOF0qzxCCNJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for multiple BISes in broadcast source and sink

---
 client/player.c | 57 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 715598aa9..bf0338dfb 100644
--- a/client/player.c
+++ b/client/player.c
@@ -118,16 +118,16 @@ struct transport {
 	struct io *timer_io;
 };
 
-static const uint8_t base_lc3_16_2_1[] = {
+static const uint8_t base_lc3_48_4_1[] = {
 	0x28, 0x00, 0x00, /* Presentation Delay */
 	0x01, /* Number of Subgroups */
 	0x01, /* Number of BIS */
 	0x06, 0x00, 0x00, 0x00, 0x00, /* Code ID = LC3 (0x06) */
 	0x10, /* Codec Specific Configuration */
-	0x02, 0x01, 0x03, /* 16 KHZ */
+	0x02, 0x01, 0x08, /* 48 KHZ */
 	0x02, 0x02, 0x01, /* 10 ms */
-	0x05, 0x03, 0x01, 0x00, 0x00, 0x00,  /* Front Left */
-	0x03, 0x04, 0x28, 0x00, /* Frame Length 40 bytes */
+	0x05, 0x03, 0x03, 0x00, 0x00, 0x00,  /* Front Left, Front Right */
+	0x03, 0x04, 0x78, 0x00, /* Frame Length 120 bytes */
 	0x04, /* Metadata */
 	0x03, 0x02, 0x02, 0x00, /* Audio Context: Convertional */
 	0x01, /* BIS */
@@ -2999,7 +2999,45 @@ static void endpoint_config(const char *input, void *user_data)
 	endpoint_set_config(cfg);
 }
 
+static void config_endpoint_iso_stream(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bcast_qos.bcast.bis = value;
+
+	endpoint_set_config(cfg);
+}
+
+static void config_endpoint_iso_group(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bcast_qos.bcast.big = value;
+
+	bt_shell_prompt_input(cfg->ep->path, "BIS (value):",
+			config_endpoint_iso_stream, cfg);
+}
+
 static struct endpoint *endpoint_new(const struct capabilities *cap);
+static void endpoint_init_defaults(struct endpoint *ep);
 
 static void cmd_config_endpoint(int argc, char *argv[])
 {
@@ -3033,6 +3071,7 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		if (cap) {
 			broadcast = true;
 			cfg->ep = endpoint_new(cap);
+			endpoint_init_defaults(cfg->ep);
 			cfg->ep->preset = find_presets_name(uuid, argv[3]);
 			if (!cfg->ep->preset)
 				bt_shell_printf("Preset not found\n");
@@ -3057,8 +3096,8 @@ static void cmd_config_endpoint(int argc, char *argv[])
 			iov_append(&cfg->ep->bcode, bcast_qos.bcast.bcode,
 				sizeof(bcast_qos.bcast.bcode));
 			/* Copy capabilities for broadcast*/
-			iov_append(&cfg->caps, base_lc3_16_2_1,
-				sizeof(base_lc3_16_2_1));
+			iov_append(&cfg->caps, base_lc3_48_4_1,
+				sizeof(base_lc3_48_4_1));
 		} else {
 			/* Copy capabilities */
 			iov_append(&cfg->caps, preset->data.iov_base,
@@ -3068,7 +3107,11 @@ static void cmd_config_endpoint(int argc, char *argv[])
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
 
-		endpoint_set_config(cfg);
+		if (cfg->ep->broadcast)
+			bt_shell_prompt_input(cfg->ep->path, "BIG (value):",
+					config_endpoint_iso_group, cfg);
+		else
+			endpoint_set_config(cfg);
 		return;
 	}
 
-- 
2.39.2

