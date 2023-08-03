Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5B6C001E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Aug 2023 07:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbjHCHVE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Aug 2023 03:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjHCHVA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Aug 2023 03:21:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A992D69
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Aug 2023 00:20:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mw8nSbtQJ1j9/0de/ficGnBOyyVbRqugh65eKpSBa1/q/L95acwxnc8pNroeEEIzfvmexB4ooYV+gODtU7TsznpO9ozsmqmjMr0RoGSjLgOoHgSpQRrAyACb6I9TkF5eX8eBrkLM2qV4obCxhq2cXm79wSxeuv9E0PsW17HrKOVAF42nGKJvxzmAuZMWS6ln+qrlUoBZckCr73Ff0ikkyrjsEg0kDUzK+KYQHUTvY0mU5zX5LekLc32wPshXkaO6EIoW3O3eFD6cCt7aLLwi1aS4kla4QoHXjoZZqjpv4GE5bCivkIdBjD7asoi0DQIR0WOaQQrerI3pB+qB5IQoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIX4M8oYNUY2aGL5/KwkyU0WRb/cYKNuwctDzxFRIck=;
 b=b/bQOcPJ51/9x8bCwv9VXnH6mnJhJNPBsiTaQnynFhkzphijFYOV2SfPANR0EDl2DdT8a/xN6AqrUnFscl/emfIUc0rqXnSt+McLmzsLyMOmjgPYzgwXfIxKmqSCTS7rV/2kzKON8poP0TbQUsbfNQMhtRxSqhoE89H3c69mc+zFvti3nh+3yU5cwry5bCnyArDq09iAAYIfTHAhDwlCShh8679RbcV/lXRmIbPNwhC+HMvlQTjIRRc3yOV7oHttxNpc1k37XmPZv0In58QVZrRf0n6HGx1yLDQS3dpANbP86qPh0moxJNtbE9NIckHhd+pk3RhIfu+JefsE0RpuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIX4M8oYNUY2aGL5/KwkyU0WRb/cYKNuwctDzxFRIck=;
 b=BALd7WQmu01MakblyENxxhyyC30OXLYaENmgER3Ve3+uCXnI5uV1olsHEZ6hbVGiNY+PSnjbvxk9iYVOvJ+xH8GYjF9v9imEDksgw0CuU34K0fOhsMgzZ18z18nWkB7DtvyrBXeUzfyW57+ozMhcipIV4+0AWJkEn2UVF9c8bV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com (2603:10a6:803:12d::13)
 by DU0PR04MB9418.eurprd04.prod.outlook.com (2603:10a6:10:359::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 07:20:55 +0000
Received: from VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::4299:5db1:461:bc17]) by VI1PR04MB6991.eurprd04.prod.outlook.com
 ([fe80::4299:5db1:461:bc17%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 07:20:55 +0000
From:   Mahesh Talewad <mahesh.talewad@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, devyani.godbole@nxp.com,
        nitin.jadhav@nxp.com, mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 2/3] client/player: Add interface menu to configure MICP-MICS during PTS testing.
Date:   Thu,  3 Aug 2023 10:20:10 +0300
Message-Id: <20230803072011.191449-3-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803072011.191449-1-mahesh.talewad@nxp.com>
References: <20230803072011.191449-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To VI1PR04MB6991.eurprd04.prod.outlook.com
 (2603:10a6:803:12d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB6991:EE_|DU0PR04MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: dc57af45-d4fb-4299-8575-08db93f22d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGmgiJglJvdoOVHaHYYmNtYtQJX/bzg1BdQ7ZHEDlaTVU/ZeiNm8CD0fG6ihR2m5X/NwxTYC/mxTeZNLjKYNIAxSav2vJydBwxp9/WlUj/pL68ucraB7HJ62pyggGa6RSuaN5H0OHO2quhTPJjf3Ws17QSAZFYK9bZxr5Zjs2oloMFiosY7irvZ80cG/2iC/M0bexK22U+7bncdu7CZBzAsbC0ljgWp1y6CPPKbKYla9ch2DnzI9qewZv05FvC6meSj9Y4Cy5wFPFIfAqtgtTU60Lz3tgjH2rxvSIardgBJzRCXYqlPsJ+vv6jlOaua0TWCPEwJa5QHaHcKUgewz6lJ5UHJdHDhVG8RRguvkZGShbMbu7sQOG8WmbHtW+QBDBuVSxYbuEeVluoGVPQpto/pGWZeyT4pllchCjOAE9bc8dgQD+Jc5xKLnPIwlI5diDEMoX9SlA8GFDe9K+GzXN9RcIdWapgwh4J2E9+Yisn0ezFKl/NHhiNg4BrdXMcD32InBkP5d6pSh13Fpd4JvOjX7oQfVBwTbmZy0rhHaaE43sp/7Lm/74lbanYYfAlA0O7txnJ5knv3QNZwAomOBbzBxw7equ0zFzSC3Y6OCQZiMtF2ELZmNSonJRSiNYwbP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6991.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199021)(36756003)(86362001)(52116002)(478600001)(38100700002)(38350700002)(2616005)(1076003)(186003)(26005)(83380400001)(6506007)(55236004)(41300700001)(8676002)(8936002)(44832011)(6512007)(6666004)(6486002)(30864003)(316002)(66476007)(66556008)(5660300002)(6916009)(4326008)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Eqf04dOAd41I1bkjq5pKqKBCW+aGq24AwWBTKr5fNVWpX4in/tNSEwECHuFm?=
 =?us-ascii?Q?LfaBKIII0Y4HBaJ3Y0IaOV5XD4mBa7+PsvUD9wybFlG35Vsy8tncl4NU99h4?=
 =?us-ascii?Q?moWy9n8yGV1YoJTBj8HH1pYit6BwjHy2dgI16dbVYmxftLz+vJZgf2f8/d2G?=
 =?us-ascii?Q?xdTTLywQrs6Xq3sJr5LlvanBPxwB0CqnWjjPull1jGu9zyU6D0RuQ+6e0LIu?=
 =?us-ascii?Q?USDDudhRYd93gsPtt5VgoSr6HpD+aNrMaKKmiO7xADWikcf/YsOUQzNOGcAD?=
 =?us-ascii?Q?rG5XjD3Yarvwv1LJyv9baOEMSLwIz8LB++H+NuQp1ObCJj/0ruMaes+uWKMv?=
 =?us-ascii?Q?u+ZdHKqYQ1gnUZciQXa95P4S71hdQ9nzQy/eA8B9yZIxJjpLjKAbj9ydTy4+?=
 =?us-ascii?Q?UWpQkWylzPJ7ijxxBbKnJRNsd0ytZGV5Wme+Gr8UNpPW070rl1v5c2b1zjQ5?=
 =?us-ascii?Q?3kXVPEkGkyrM7FCXlOz+useLkHDpjCLCFDUFtHqcYMHnp2brX44tLvMd4Pac?=
 =?us-ascii?Q?cqDCs5eiPDkRFpF9jk85xjk+zXb3bhTwsefB63n9F5VlVV5CpqoIas+Y6EcX?=
 =?us-ascii?Q?EKrzksTgYDKGFkeuqEoeAGnoA+zismD2BsXVkj4hTWOp5NTiuqlngtd2DnpL?=
 =?us-ascii?Q?wiOsEE6VOssVKieDUnlBndh2wOOHmCvchnu+sawDUXUbVltFXs6MUsETy4QY?=
 =?us-ascii?Q?cIWYZhZaOFDou38fgtwSbUL1H32yY4M8fwOBSM5DvlGqYxk+R5P7rY4yvDWN?=
 =?us-ascii?Q?kYsX6z9JfFdPy6BH7Kasx7is4AZXBXzV9lobSsKaKxu0iu9M8szT58/R1B23?=
 =?us-ascii?Q?Eoz1h/XA+N8DNV6n7yA8Dnt9zsc022e1MuyAnWC4oEx7CYWsbNr0C9Xj+F1R?=
 =?us-ascii?Q?+NutpepVG+0XjG3LQwitCTtDDPt5PwHguOoiUpZ0Mz2+8FNvdpHPy3msuU2s?=
 =?us-ascii?Q?ZIQ9++QFD9HLoWiHWrTJ/T0D7fLVO9uv2DPxXJqi+28JGuHKAexR71idCame?=
 =?us-ascii?Q?A3OExy0C1Kre2R6Fa5/fKKApuDEXE/AkeOyf8MJYYMT7ErhBg48fz9LA1yD+?=
 =?us-ascii?Q?0kWrjDDOn3QVW+P1ssIgexk+1gJoDWl2d9XgP7YIynvZt43xFwoTU71x4DGO?=
 =?us-ascii?Q?VEj8/Muu5qs1On5ZDJverhx2wU3M1+KpHLZAEF775eZAkWUQG38bBU4g4TJ1?=
 =?us-ascii?Q?B8eOvhTTir80Y4gpNGC9jjcn2EJRlGIc4ntpcLKMxo/G2o/DoU84p8tGLL2N?=
 =?us-ascii?Q?TYElNroXXZEiqJmsiYPkOYz6CZb66ygkZC6+MAM0ZxBmGfL9ivDoXLJmyQHs?=
 =?us-ascii?Q?G3SGeI1MT1cGMx4uNxC2UXtwK0nnyn7mHol+FWKbs0WOzqBjKDOgpvjOaaRQ?=
 =?us-ascii?Q?DKWuZiKTvxB9NAPoAfprnlBhFQ8FYgVX0mj3ipdqvSVOlul8x0tLHrDJsuEN?=
 =?us-ascii?Q?P6r/kG4hvfufIbxCRJFI34l+cYW5R7xBwwsD2iy+LefoYMNNaoAQwNuaPViJ?=
 =?us-ascii?Q?DZHJCR+GPtjqapjvYKCNEEGB1ot9arpsoakqGULzaUHWAcX8yJ/u/8lEAHky?=
 =?us-ascii?Q?vqSdNInMaB5qic31MtRKuR95a3R+H40NTgMNCmHo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc57af45-d4fb-4299-8575-08db93f22d59
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6991.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 07:20:55.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1texrbndt7axO0FbSuzajGjvVOzoUfHQ0n17A9uX+JozLIdxtlhrs4bLM+0mLXl5aRfkHd8IlLTuvZqlQTrEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9418
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

- Includes implementations required for PTS testing for MICS and MICP.
- Interface given in bluetoothctl/player menu for sending MICS and MICP
commands while excecuting PTS test cases. Tested all MICP and MICS PTS
test cases[LE] and all are passed.
- Added flag - MICP_MICS_PTS_FLAG in configure.ac which enable/disable
PTS testing related code during compilation. uncomment this flag in
configure.ac inorder to enable PTS testing related code and comment
it for disable. By default this flag is disabled.
- Spec implementation/PTS testing:
MICS - MICS_v1.0.pdf
MICP - MICP_v1.0.pdf
PTS Testing MICS: MICS.TS.p0ed2.pdf
PTS Testing MICP: MICP.TS.p3.pdf
---
 client/main.c     |  12 ++++
 client/player.c   | 164 ++++++++++++++++++++++++++++++++++++++++++++++
 client/player.h   |   4 ++
 configure.ac      |   3 +
 src/adapter.c     |  87 ++++++++++++++++++++++++
 src/shared/micp.c | 122 ++++++++++++++++++++++++++++++++++
 src/shared/micp.h |   8 +++
 7 files changed, 400 insertions(+)

diff --git a/client/main.c b/client/main.c
index 0eac5bdf5..d7c735d19 100644
--- a/client/main.c
+++ b/client/main.c
@@ -413,6 +413,10 @@ static struct adapter *adapter_new(GDBusProxy *proxy)
 	if (!default_ctrl)
 		default_ctrl = adapter;
 
+#ifdef MICP_MICS_PTS_FLAG
+	mics_set_proxy((void *)adapter);
+#endif /* MICP_MICS_PTS_FLAG */
+
 	return adapter;
 }
 
@@ -892,6 +896,10 @@ static void cmd_show(int argc, char *argv[])
 		}
 	}
 
+#ifdef MICP_MICS_PTS_FLAG
+	mics_set_proxy((void *)adapter);
+#endif /*MICP_MICS_PTS_FLAG*/
+
 	if (!g_dbus_proxy_get_property(adapter->proxy, "Address", &iter))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
@@ -951,6 +959,10 @@ static void cmd_select(int argc, char *argv[])
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
+#ifdef MICP_MICS_PTS_FLAG
+	mics_set_proxy((void *)adapter);
+#endif /*MICP_MICS_PTS_FLAG*/
+
 	if (default_ctrl && default_ctrl->proxy == adapter->proxy)
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
diff --git a/client/player.c b/client/player.c
index e5084967a..2e48025e8 100644
--- a/client/player.c
+++ b/client/player.c
@@ -596,6 +596,153 @@ static void cmd_show_item(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+#ifdef MICP_MICS_PTS_FLAG
+struct mics_adapter {
+	GDBusProxy *proxy;
+};
+static struct mics_adapter *mics_default_ctrl;
+void mics_set_proxy(void *proxy)
+{
+	mics_default_ctrl = (struct mics_adapter *)proxy;
+	if (mics_default_ctrl == NULL) {
+		bt_shell_printf("mics_default_ctrl is NULL\n");
+		return;
+	}
+}
+static gboolean parse_argument(int argc, char *argv[], const char **arg_table,
+					const char *msg, dbus_bool_t *value,
+					const char **option)
+{
+	const char **opt;
+
+	if (!strcmp(argv[1], "help")) {
+		for (opt = arg_table; opt && *opt; opt++)
+			bt_shell_printf("%s\n", *opt);
+		bt_shell_noninteractive_quit(EXIT_SUCCESS);
+		return FALSE;
+	}
+
+	if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes")) {
+		*value = TRUE;
+		if (option)
+			*option = "";
+		return TRUE;
+	}
+
+	if (!strcmp(argv[1], "off") || !strcmp(argv[1], "no")) {
+		*value = FALSE;
+		return TRUE;
+	}
+
+	for (opt = arg_table; opt && *opt; opt++) {
+		if (strcmp(argv[1], *opt) == 0) {
+			*value = TRUE;
+			*option = *opt;
+			return TRUE;
+		}
+	}
+
+	bt_shell_printf("Invalid argument %s\n", argv[1]);
+	return FALSE;
+}
+
+static void cmd_set_mute_state(int argc, char *argv[])
+{
+	dbus_bool_t mute_state;
+	char *str;
+
+	if (!parse_argument(argc, argv, NULL, NULL, &mute_state, NULL))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	str = g_strdup_printf("mics %s", mute_state == TRUE ? "on" : "off");
+
+	if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy, "mics",
+					DBUS_TYPE_BOOLEAN, &mute_state,
+					generic_callback, str, g_free) == TRUE)
+		return;
+	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_enable_disable_mute_state(int argc, char *argv[])
+{
+	dbus_bool_t mute_state;
+	char *str;
+
+	if (!parse_argument(argc, argv, NULL, NULL, &mute_state, NULL))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	str = g_strdup_printf("mics %s", mute_state == TRUE ? "on" : "off");
+
+	if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy,
+				"mics_state", DBUS_TYPE_BOOLEAN, &mute_state,
+				generic_callback, str, g_free) == TRUE)
+		return;
+	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_micp_discover_mute(int argc, char *argv[])
+{
+	dbus_bool_t mute_state = 0;
+	char *str;
+
+
+	if (!parse_argument(argc, argv, NULL, NULL, &mute_state, NULL))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	str = g_strdup_printf("mics %s", mute_state == TRUE ? "on" : "off");
+
+	if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy,
+				"micp_disc", DBUS_TYPE_BOOLEAN, &mute_state,
+				generic_callback, str, g_free) == TRUE)
+		return;
+	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_enable_read_mute_state(int argc, char *argv[])
+{
+	char *endptr = NULL;
+	int handle;
+
+	handle = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || handle > UINT16_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	bt_shell_printf("%s: %x\n", __func__, handle);
+	if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy,
+				"micp_read_char", DBUS_TYPE_UINT16, &handle,
+				generic_callback, NULL, NULL) == TRUE)
+		return;
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void cmd_enable_write_mute_state(int argc, char *argv[])
+{
+	char *endptr = NULL;
+	int handle;
+
+	handle = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || handle > UINT16_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+	bt_shell_printf("%s : %x\n", __func__, handle);
+	if (g_dbus_proxy_set_property_basic(mics_default_ctrl->proxy,
+				"micp_write_char", DBUS_TYPE_UINT16, &handle,
+				generic_callback, NULL, NULL) == TRUE)
+		return;
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+#endif /* MICP_MICS_PTS_FLAG */
+
 static void cmd_show(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -969,6 +1116,23 @@ static const struct bt_shell_menu player_menu = {
 							item_generator},
 	{ "show-item",   "<item>",    cmd_show_item, "Show item information",
 							item_generator},
+#ifdef MICP_MICS_PTS_FLAG
+	{ "mics_mute",     "<on/off>", cmd_set_mute_state,
+					"Set Mics Mute state to on / off",
+							NULL },
+	{ "mics_state",     "<on/off>", cmd_enable_disable_mute_state,
+					"Set Mics Mute state to on[enable] / off[disable]",
+							NULL },
+	{ "micp_discover",     "<on/off>", cmd_micp_discover_mute,
+					"discover Mute Characteristic",
+							NULL },
+	{ "micp_read",     "<handle>", cmd_enable_read_mute_state,
+					"Read Mute Characteristic",
+							NULL },
+	{ "micp_write",     "<handle>", cmd_enable_write_mute_state,
+					"Write Mute Characteristic",
+							NULL },
+#endif /* MICP_MICS_PTS_FLAG */
 	{} },
 };
 
diff --git a/client/player.h b/client/player.h
index e7778cb1e..316090721 100644
--- a/client/player.h
+++ b/client/player.h
@@ -10,3 +10,7 @@
 
 void player_add_submenu(void);
 void player_remove_submenu(void);
+
+#ifdef MICP_MICS_PTS_FLAG
+void mics_set_proxy(void *proxy);
+#endif /*MICP_MICS_PTS_FLAG*/
diff --git a/configure.ac b/configure.ac
index 9a8856380..a190d9168 100644
--- a/configure.ac
+++ b/configure.ac
@@ -215,6 +215,9 @@ AC_ARG_ENABLE(micp, AS_HELP_STRING([--disable-micp],
 		[disable MICP profile]), [enable_micp=${enableval}])
 AM_CONDITIONAL(MICP, test "${enable_micp}" != "no")
 
+#AC_DEFINE(MICP_MICS_PTS_FLAG, 1,
+#	[Enable/Disable PTS related code changes in MICP and MICS])
+
 AC_ARG_ENABLE(csip, AS_HELP_STRING([--disable-csip],
 		[disable CSIP profile]), [enable_csip=${enableval}])
 AM_CONDITIONAL(CSIP, test "${enable_csip}" != "no")
diff --git a/src/adapter.c b/src/adapter.c
index 2679d4302..89f6d76f4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -68,6 +68,10 @@
 #include "eir.h"
 #include "battery.h"
 
+#ifdef MICP_MICS_PTS_FLAG
+#include "src/shared/micp.h"
+#endif /*MICP_MICS_PTS_FLAG*/
+
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
 #define MODE_DISCOVERABLE	0x02
@@ -3333,6 +3337,82 @@ static void property_set_pairable(const GDBusPropertyTable *property,
 	property_set_mode(adapter, MGMT_SETTING_BONDABLE, iter, id);
 }
 
+#ifdef MICP_MICS_PTS_FLAG
+static void property_set_mute_state(const GDBusPropertyTable *property,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	dbus_bool_t enable;
+
+	dbus_message_iter_get_basic(iter, &enable);
+	DBG("SET %s: %d\n", __func__, enable);
+	mics_change_mute_state(enable);
+	g_dbus_pending_property_success(id);
+}
+
+static void property_mute_enable_disable(const GDBusPropertyTable *propert,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	dbus_bool_t enable;
+
+	dbus_message_iter_get_basic(iter, &enable);
+	DBG("%s: %d\n", __func__, enable);
+	mics_enable_disable_mute(enable);
+	g_dbus_pending_property_success(id);
+}
+
+static void property_micp_discover_mute(const GDBusPropertyTable *propert,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	dbus_bool_t enable;
+
+	dbus_message_iter_get_basic(iter, &enable);
+	DBG("%s : %d\n", __func__, enable);
+	micp_discover_mute_char();
+	g_dbus_pending_property_success(id);
+}
+
+static void property_micp_read_mute(const GDBusPropertyTable *propert,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	uint16_t handle;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Expected UINT16");
+		return;
+	}
+	dbus_message_iter_get_basic(iter, &handle);
+	DBG("%s : %x\n", __func__, handle);
+
+	mics_mute_char_read(handle);
+	g_dbus_pending_property_success(id);
+}
+
+static void property_micp_write_mute(const GDBusPropertyTable *propert,
+				DBusMessageIter *iter,
+				GDBusPendingPropertySet id, void *user_data)
+{
+	uint16_t handle;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Expected UINT16");
+		return;
+	}
+	dbus_message_iter_get_basic(iter, &handle);
+	DBG("%s : %x\n", __func__, handle);
+
+	micp_char_write_value(handle);
+	g_dbus_pending_property_success(id);
+}
+#endif /*MICP_MICS_PTS_FLAG*/
+
 static gboolean property_get_pairable_timeout(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
@@ -3886,6 +3966,13 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "DiscoverableTimeout", "u", property_get_discoverable_timeout,
 					property_set_discoverable_timeout },
 	{ "Pairable", "b", property_get_pairable, property_set_pairable },
+#ifdef MICP_MICS_PTS_FLAG
+	{ "mics", "b", NULL, property_set_mute_state },
+	{ "mics_state", "b", NULL, property_mute_enable_disable },
+	{ "micp_disc", "b", NULL, property_micp_discover_mute },
+	{ "micp_read_char", "q", NULL, property_micp_read_mute },
+	{ "micp_write_char", "q", NULL, property_micp_write_mute },
+#endif /*MICP_MICS_PTS_FLAG*/
 	{ "PairableTimeout", "u", property_get_pairable_timeout,
 					property_set_pairable_timeout },
 	{ "Discovering", "b", property_get_discovering },
diff --git a/src/shared/micp.c b/src/shared/micp.c
index 25ffa6940..c5b814d98 100644
--- a/src/shared/micp.c
+++ b/src/shared/micp.c
@@ -6,6 +6,10 @@
  *  Copyright (C) 2023  NXP Semiconductors. All rights reserved.
  *
  */
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #define _GNU_SOURCE
 #include <inttypes.h>
 #include <string.h>
@@ -74,6 +78,11 @@ struct bt_micp {
 	void *user_data;
 };
 
+#ifdef MICP_MICS_PTS_FLAG
+struct bt_mics *pts_mics;
+struct bt_micp *pts_micp;
+#endif /*MICP_MICS_PTS_FLAG*/
+
 static struct queue *micp_db;
 static struct queue *micp_cbs;
 static struct queue *sessions;
@@ -532,6 +541,9 @@ static struct bt_micp_db *micp_db_new(struct gatt_db *db)
 	mdb->mics = mics_new(db);
 	mdb->mics->mdb = mdb;
 
+#ifdef MICP_MICS_PTS_FLAG
+	pts_mics = mdb->mics;
+#endif /*MICP_MICS_PTS_FLAG*/
 	queue_push_tail(micp_db, mdb);
 
 	return mdb;
@@ -783,6 +795,10 @@ static void foreach_mics_char(struct gatt_db_attribute *attr, void *user_data)
 	bt_uuid_t uuid, uuid_mute;
 	struct bt_mics *mics;
 
+#ifdef MICP_MICS_PTS_FLAG
+	pts_micp = micp;
+#endif /*MICP_MICS_PTS_FLAG*/
+
 	if (!gatt_db_attribute_get_char_data(attr, NULL, &value_handle,
 			NULL, NULL, &uuid))
 		return;
@@ -920,3 +936,109 @@ bool bt_micp_attach(struct bt_micp *micp, struct bt_gatt_client *client)
 						micp);
 	return true;
 }
+
+#ifdef MICP_MICS_PTS_FLAG
+void mics_change_mute_state(bool state)
+{
+	if (pts_micp == NULL)
+		return;
+
+	DBG(pts_micp, "%s: %d", __func__, state);
+	state == true ? mics_muted(pts_mics, pts_micp, 0) :
+					mics_not_muted(pts_mics, pts_micp, 0);
+}
+
+static uint8_t mics_mute_enable_disable(struct bt_mics *mics, uint8_t state)
+{
+	uint8_t *mute_state;
+
+	mute_state = mdb_get_mute_state(mics->mdb);
+
+	*mute_state = state;
+
+	return 0;
+}
+
+void mics_enable_disable_mute(bool state)
+{
+	state == true ? mics_mute_enable_disable(pts_mics, MICS_MUTED) :
+			mics_mute_enable_disable(pts_mics, MICS_DISABLED);
+}
+
+static void micp_char_search_cb(bool success, uint8_t att_ecode,
+						struct bt_gatt_result *result,
+						void *user_data)
+{
+	DBG(pts_micp, "micp_char_search_cb");
+
+}
+
+static void micp_foreach_mics_service(struct gatt_db_attribute *attr,
+							void *user_data)
+{
+	uint16_t start, end;
+	bool primary;
+	bt_uuid_t uuid;
+	struct bt_gatt_request *gatt_ret;
+	struct bt_att *micp_att;
+	struct bt_micp *micp = user_data;
+	struct bt_mics *mics = micp_get_mics(micp);
+
+	if (!gatt_db_attribute_get_service_data(attr, &start, &end, &primary,
+		&uuid)) {
+		DBG(micp, "%s: ERR! gatt_db_attribute_get_service_data\n",
+			__func__);
+		return;
+
+	}
+	micp_att = bt_micp_get_att(micp);
+	gatt_ret = bt_gatt_discover_characteristics(micp_att, start, end,
+					micp_char_search_cb, NULL, NULL);
+
+	if (gatt_ret)
+		DBG(micp, "MICP GATT DISCOVER START\n");
+	else
+		DBG(micp, "MICP GATT DISCOVER FAILED\n");
+
+	mics->service = attr;
+
+	gatt_db_service_set_claimed(attr, true);
+	gatt_db_service_foreach_char(attr, foreach_mics_char, micp);
+}
+
+void micp_discover_mute_char(void)
+{
+	bt_uuid_t uuid;
+
+	bt_uuid16_create(&uuid, MICS_UUID);
+	gatt_db_foreach_service(pts_micp->ldb->db, &uuid,
+					micp_foreach_mics_service, pts_micp);
+}
+
+void mics_mute_char_read(uint16_t handle)
+{
+	DBG(pts_micp, "%s. handle: %x\n", __func__, handle);
+	micp_read_value(pts_micp, handle, read_mute_state, pts_micp);
+}
+
+static void micp_write_cb(bool success, uint8_t att_ecode, void *user_data)
+{
+	if (success)
+		DBG(pts_micp, "MICP Write successful\n");
+	else
+		DBG(pts_micp, "\nWrite failed: 0x%02x\n", att_ecode);
+}
+
+void micp_char_write_value(uint16_t handle)
+{
+	const uint8_t value = 0x01;
+
+	if (!pts_micp->client) {
+		DBG(pts_micp, "%s: pts_micp->client is NULL", __func__);
+		return;
+	}
+	bt_gatt_client_write_value(pts_micp->client, handle, &value, 0x01,
+			micp_write_cb, NULL, NULL);
+
+}
+#endif /*MICP_MICS_PTS_FLAG*/
diff --git a/src/shared/micp.h b/src/shared/micp.h
index b307ac9f4..4a9807ed4 100644
--- a/src/shared/micp.h
+++ b/src/shared/micp.h
@@ -44,3 +44,11 @@ bool bt_micp_ready_unregister(struct bt_micp *micp, unsigned int id);
 
 bool bt_micp_unregister(unsigned int id);
 struct bt_micp *bt_micp_new(struct gatt_db *ldb, struct gatt_db *rdb);
+
+#ifdef MICP_MICS_PTS_FLAG
+void mics_change_mute_state(bool state);
+void mics_enable_disable_mute(bool state);
+void micp_discover_mute_char(void);
+void mics_mute_char_read(uint16_t handle);
+void micp_char_write_value(uint16_t handle);
+#endif /*MICP_MICS_PTS_FLAG*/
-- 
2.34.1

