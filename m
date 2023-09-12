Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BEBCA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjILGnz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjILGnz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:43:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199E7AF
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdQrkA0d8KLVEiU2GttNYIMOlIDUJahAGvekd0d0Sc7Pt9jJ/IpRNBRI1+4m6v8uvikzmscRHLOYV4WXq+LEWwN3G3U0Xr3U6/tz/3jy6eFZSMKPt35x9+SbFZjCk1yojTN1VnEghnlsTDyLkxE5joXZyrdRItyOfliGOhsv2JSTlw+Uh2SPv04SdK+qxQWagIjK7sxwfRpg4cCWdzwFq0hYdA0HBKP4sxIxy5p7YNXK0EnjPDRg3AA0P4NLSClxJoibHBSorvvCNSjoCenHbj3CeYaI2oeo2GVZDuKGjld12uPjnQYBJhXBbCEYLZoBcICTCdsuV9EIs0qTyqk1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0LjiyYlqOZYgaAqYt5kdfmgRLEYAb+bTtAc87yt01c=;
 b=L4CLScgdG0Be+TJRaGnfKMIJNqnGgtT6f+RTofBjCw4wLNS2W+FsMNzR1ebWwjlJebOzpoPXkcm7GLcRkulLkSHUbnMicSCA5g4PAynHW1Q08sbXZUmVy9afePdWW5kSH3GiTAtkzIMW2IxB5rGBFW/VuGLPu9meBixwzXwDDdllHUI2anvuQNJ6jezULLGFfZNIuFXeYvlUEcQFyC+zXOYARlVbE9Vp3NMmlMjjEmVXwUFo75TXZe8JWQh/q/H7WTCUG/UPgfslRIVT0mNkmpW1uOamo1AaMYLIcOGEXjCzFZTXjFWC+HJPhzzHpMAARFgpGkuJjWFj+DFQZWHVjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0LjiyYlqOZYgaAqYt5kdfmgRLEYAb+bTtAc87yt01c=;
 b=Hg+VEkG3ZXgH5JAsbP8T3rWjwSt+urncFjyoQdDvjfntOZp+yogZkwp4uiiFLABsKAxqFZ+lw7J4EStgKXthwIYQwKFUVcVdXkoyPwaQik8+b8W1D6Gn0hoMWbeh4iNzfWT6LQV8cMS7MCdhCo3SX9Eb8d4iWNHwGmrPQoRev/Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS5PR04MB10044.eurprd04.prod.outlook.com (2603:10a6:20b:682::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 06:43:48 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:43:48 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Add command for control of BIS encryption
Date:   Tue, 12 Sep 2023 09:40:26 +0300
Message-Id: <20230912064026.1203509-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912064026.1203509-1-vlad.pruteanu@nxp.com>
References: <20230912064026.1203509-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0054.eurprd03.prod.outlook.com (2603:10a6:208::31)
 To PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS5PR04MB10044:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1203a0-0523-4c94-5fd5-08dbb35b9e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b3i5+QSLuUb7JjluUFlM2Yqh17nLVsld9bl7dqQcs3kmiHH2bmh7/p1cCKbjI/2odRSCMBxLVApZZjTVuiZ2dm4LymrnNokZCZYco0E82U7rHiqCcihU+ULbUVeH1f2q3E69QvGsS1deLcVshrQCXr0cnRgwxXFov7jlfD6+gcIHM6a5ToaFya+WcNZFiErinLT4miMqRTTV8r8bjRAiWaVKPD5YOaNq1ZbXXJEUSN0rysmlKX4b7jJlkwGjCRWVksr7jJQt98vKdilubLNY4zWKCzzqr+Gq1ACepwYyjjdgqUtFxqhyOKK/aDHyZCOv35pvInTqKO9xv6N2dZrSnpOOG+JdoEKQxG7ixFFkRK9T+6Qw8NdOmxzuPXK4cMjoUcQycR1sPSg2rf0dLEtiY3lBwsVmT45lb0spFfAHWzzWE3d5FHzaGzgW9mV+yUWjbSedq51GdDN5yHwnP2I6NCLyf+yzmN4qBdOztjDTe2Nk+GoaIHo4QGdVSXjH4eyKdGecL82W5AOCt+lFTa1Iwbda+y/bLVQlnj0zb0mHGsmHYULIhPGkhOpCHhCN5SXSklUqZn8wDavEMZxa85fME8oCAaKaEg4sk2o8DuxpxqrINsjawgwO76hbcYmRPjSX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(6506007)(52116002)(6486002)(6666004)(41300700001)(36756003)(86362001)(38100700002)(38350700002)(2616005)(1076003)(2906002)(6512007)(83380400001)(8676002)(5660300002)(26005)(8936002)(4326008)(478600001)(66556008)(6916009)(66946007)(44832011)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tbTsOlMPnAXCG29+eZotWwY1pbOkAomTI1jGIGdZsLBy3tQybGlrEaiEHBSs?=
 =?us-ascii?Q?7n3FwuQ50vO8DZDkrLEOf2ad8zOqkhh60PfMI/2Y4AO40lJEsudwp6Lj0yyS?=
 =?us-ascii?Q?2qslns/2Pufv7WW4ldtZgYA4OOfXHUJsOrRUyd3B7O3bloqFk5dRKKri/dCQ?=
 =?us-ascii?Q?aXSvkwHYbXp09q3gdm9rMMD+1Iv9VLUbRkJ4LKeI7CHPZg+s0r7A/hpjSK7o?=
 =?us-ascii?Q?zFnGDMHSNUSpJG6A/0I/Ot0GOhVY+nX1qO8HNvcVL8wlU5FcEB7uWDVz1HZG?=
 =?us-ascii?Q?KppyV5NUZjdPYZFH/nwlRQ4qn8HqOQlkws1qCH7BjACAvAptLnrx01OdY9p4?=
 =?us-ascii?Q?fOB9iAxSJs0JxauJIENa6gICRbln5RbNEfVvIAAxrSX1fJ2Qum4CD9vva4j+?=
 =?us-ascii?Q?4rJvP/lM9a6RWlaJrdxeutNihZun+LavfbsOm79XvXcY5UmVDbG5RFgNqJ4A?=
 =?us-ascii?Q?30ZhiXfMykX2M4b7nFXWIH1oFB1XEzl/Ygk1AgV+TCpKbHCd6h75iUrjyjfh?=
 =?us-ascii?Q?YksD3wWJVqwxYNLIrC7iPDBVeasPmBLGH48Hjjp5xg8sNdXN5B2r5AUT+1if?=
 =?us-ascii?Q?I2taAZvp7d7oPYiRX078U6edOV7ahXr7D+GLUn2SqHiO3nA61WGZj5s1z7oD?=
 =?us-ascii?Q?Al+COWTBHwvbJ2hkHoGscKn7RqMxWbzd07Zap7UXnNoHIwber4omexxovjrH?=
 =?us-ascii?Q?4P3WyL9l/QK78S6gYaE48k0IXTVVqS8Y3J72xR0cYaLdYYyheLP/Z7eSh0gb?=
 =?us-ascii?Q?G00vZTEoAjagSoCsCg7DjaG+/Ga8y3a1n4YarJQpFsh5FTs6Uo/X7kWcT2iW?=
 =?us-ascii?Q?YfrgXz23T9PliF6eKckMzLG5Mz/WkC65kj5O6rzVDwo9YfYXCI5hnwrRvOZk?=
 =?us-ascii?Q?Ufa4JOB9iYUlUKYbtECM47m/Hmy8ofwG23tAquwXuBsMAckHVSCZazd5ApGN?=
 =?us-ascii?Q?Y+KUDmnRH8u7QliGw4NO13MCWqP202JqgUhaF3/rgTg5Wcoxx0hmd4rUyvLZ?=
 =?us-ascii?Q?28Am4zZ5bdB+xKzAhr0jQdkN7OSEdcDl+LsQ8vZ5SPjmpZNZDEQ+8umvgSAB?=
 =?us-ascii?Q?dka4DDMHZcYKA7Gwd/YtaYqXsIOAxwlfBNtfR+IoFsT3NB1UBqMNJPHjms/C?=
 =?us-ascii?Q?XrWVKPJrMKvvQNCchTBS9UW6tJ3rIrv/kEjVJx9yOp64PD7LbE4Hmm4cmlMG?=
 =?us-ascii?Q?2gRsc8QytLqBGuVROkLG5tVs7e9RbijsPKNM6sArkx8ycgvBxuXAJb6NULRa?=
 =?us-ascii?Q?JCloKEdRXCRUodDz172IL8epAGVSVb2EgsifeewtCqeJvLjR8zi7AB45d6he?=
 =?us-ascii?Q?mijhzmFT25ZifVE1RpLr13c5RHJa8iP+nu80pLsrwidr0b/O8GVMhs7xzBIT?=
 =?us-ascii?Q?vSDiG5rQH+mxHFPmAv+tVXztW7GJFcM9GZt+hZB/dsG/nwj2WPTMOHBrLIFb?=
 =?us-ascii?Q?e6A+EYFQX/NYQbQCmoTR+wAUpEtpcR8JR7rrlGeaMIZ27nWmOzSf4fMAvc/F?=
 =?us-ascii?Q?u5sRdTLQ8XZIUUNwQPpoEPU8hDe0SApO0SDNcROn2YO+ZZK4QRWpzYZwyFdP?=
 =?us-ascii?Q?54O8CreaiySlO8z1/X/QybrYmXiP0WkO5V9cTRMut3dbbz6EDd+errxzRl51?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1203a0-0523-4c94-5fd5-08dbb35b9e86
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:43:48.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOsv9sZWv2/fN/hlIq5H3J4fcpiJEcfN43AfetXzfG9F7/8Ll+0TmG0SPrVZ5YA8ZfovbEuDDmWX3nS0ZbJy/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10044
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently there is no way to set the BIS encryption from
the bluetoothctl application. This commit adds support
for one.

Usage:
	encryption [on/off]
---
 client/player.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/client/player.c b/client/player.c
index 42721c210..b1da5e839 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3196,6 +3196,28 @@ done:
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_encryption_endpoint(int argc, char *argv[])
+{
+
+	uint8_t value;
+
+	if (argc < 2) {
+		bt_shell_printf("Encryption: %s\n",
+				bcast_qos.bcast.encryption ? "on" : "off");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (!strcmp(argv[1], "on") || !strcmp(argv[1], "yes"))
+		value = 1;
+	else if (!strcmp(argv[1], "off") || !strcmp(argv[1], "no"))
+		value = 0;
+	else
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	bcast_qos.bcast.encryption = value;
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
 static const struct bt_shell_menu endpoint_menu = {
 	.name = "endpoint",
 	.desc = "Media Endpoint Submenu",
@@ -3221,6 +3243,10 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_presets_endpoint,
 						"List available presets",
 						uuid_generator },
+	{ "encryption",    "[on/off]",
+						cmd_encryption_endpoint,
+						"Enable/disable BIS encryption (mode 3 security)",
+						NULL },
 	{} },
 };
 
-- 
2.34.1

