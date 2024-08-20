Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9400618DF70
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150610; cv=fail; b=SSvXDRGbIcSxHSAUdXKaBpJT4iyNd/R6KKaEyldpwPQL7TrEpQfmojPXHcjpt/XJ4FbYyj4+oMNSsbxpsFk20jdpbqv1RJ1+giySNFdgZJkHAlrv/l2ABIdZzwXqEcdQkOMSkoFcJfnyw8WauPyjnRQbdVLPEL1LZZC2OafmNcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150610; c=relaxed/simple;
	bh=29egCaevO7qWaIvC6EcznmHXpMtzmupOd5Xo37bJJvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YZSxSEgzHF5GEdmU6eVc9MBZ5QYiSQUi8CPj+SSVd4ekXQdrIOzrEO2h7x3C1VDOXNeXtWfFigLx6MXkMyE1jZWL2G7+h4Rdns7ZED9ekqObU74LH197XPMPGWiS7tTNBq1IiNfHafttNJHrOIvBRyDn1Ka3/2fbRfXbjqtNVu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HhOc7y3C; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HhOc7y3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azfyk2hCB81SlazsS4DGtUXIZ5Ws+ZeSFed/VHcmluCZrRhPlGmzKAiLaHmneiwuCAofzk9zUIxESv3Yza3efQSKuNRiAItwUt0HZhn9ZhHRSYpha1h+tx50WkpgAXy7fa86Kbj6sXKo/CyqwTJXlkyzDc/3otekpv5OOL6ZtQJ3DIHWZLNujvP8uRBW3ls2HwjdMDUyihqsXaJ1k6STFLYxAEmM6uJg434HmS3dBwadNMpWVIZrJVXMNt1YHxjCHzA+vdk8Oz2TTZYdmg0Za3aiia/VLXjGZn+EH1JUWUfHCPIxAgjIfMQKgkQ26yr9jzwQdMb2s0dpd+rrlegKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XDDNGuqLnTHy2OR6rdADRf6hHqG9lGdMI7rHo/h4hc=;
 b=Aq3ki4Ju2kreWT0WzcqpnEsL/tCW+BVXPPuCngMpzcCE0eeFk5HfwIu1x5whXaizxJK55bGIy7IQh7klk++fGONQirrM74m7203okb0+2ZJwIBo+oJQmTb/3XjAQfj/q7mGaZIhjm8nXVnK+paAcHM63EMUelfXiVjPXGTnyi+xxeLWrVcsMfpYH/2em5gZVSxR9zTkGDPWvuLR4hb7R8OKMpflKEI08DIsbnhoBq44VCMyGWZW5K0waSspJKJMpHO2j/Fa0OQfN+kFHhl1WkFk6BWoHWFAH/q3RbWpVjcXOPuYw2LfBD2pfYBlIR4d0KEFxf4RCk77JjWTVmP/C/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XDDNGuqLnTHy2OR6rdADRf6hHqG9lGdMI7rHo/h4hc=;
 b=HhOc7y3CiDPd9zKjps0TeBT9ey0dM+HszOnP0EiuTFBxYQj9NgYMncY5gPQFmWhXV5KJH871N1wNLKsZPkxjSHz5YlJBhhh7MMSrz36lZ9hXSCbHJplolXf3jTKrO0jRcUMGp7cWvIqzkckkRPgUzte9ertrjTb7GGUibn7N5055+alPZNsUnmUg8UbmpTCC9LpdyBN2sc4AyPX9T3O2QT5nxwo4O2biADop5RwYpCHIGvABPkWOsrsvqujfJiT2bHzQsQu14+xhQvXVs2+vW13vpeXDW4YXv8MEaHOLSiCECXM2IN2x+ByVsVmD3KYYESOZf1Ht4N2cSMzdkEJSfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 10:43:23 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:23 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 7/8] client/player: Prompt the user to enter the bcode
Date: Tue, 20 Aug 2024 13:39:17 +0300
Message-Id: <20240820103918.24246-8-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
References: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: b189953b-b3e1-4e0d-d328-08dcc104ea37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRqrMBVoLkGlhxYFtd/aTMQGTY30CZXqxHHcoOcXf30NxnswdKAzzWKe1sYg?=
 =?us-ascii?Q?TPI9PzBH+W0ewSyaoLSTdJGQqqk/T4dEAUjHGBfC3Ts+dRSygDuEhQiOje86?=
 =?us-ascii?Q?zdM8Yo873dLcr1GNxXeKlcI08I897n+/QvmmSTEtWune4127Zd3vsyeafFnI?=
 =?us-ascii?Q?0w9e+GEF04bfZXk74gqu059A5pIPXsGKrwGxLtgYqqgALH1gV94x7tliH0mS?=
 =?us-ascii?Q?1uCdCRNuLVchMR+wos4+QVqOrj98I4M3qzsQPAk7vDRQ+zcoc8D8SMgiPIvs?=
 =?us-ascii?Q?HXK5DY4d5CfJSlXlZNBR8k/4C179hDAz/yIaVBnNYNOgQYwSEL3oTsNTUXRv?=
 =?us-ascii?Q?oSvQ1ScHEXrVq1QAeTYQAEHzTW3CR1XtIpqm5oylvNv4x4aLuNhEPbbQy1hJ?=
 =?us-ascii?Q?3cTDNIYkqudNDiYU3E07Ll+tkHlqqAdBFOVcn0bserGzu7GDIzzzGPr/Agmt?=
 =?us-ascii?Q?FGtBHYEHy8EvttOyVT2XxnaubQrPqSowx3Vh0NI0CFNeeyMxxKRKRuKT8wHX?=
 =?us-ascii?Q?EAey4ApR528BrbI26p2NStH6NBR0Wxt4HEkpaI4MzI3Po1zHbCZkSwMQB4TF?=
 =?us-ascii?Q?+QC66u50GfSAkaiNAK4i+Y6lwyh5mXM/dq40hdAXLcJWwDYWJKgIGz7nM8VR?=
 =?us-ascii?Q?aIYmKsKK+JAXU0ryHDMpuVEcDQ+ZqmFxNKPkpm6BF6t8GQHPIjDp62tQ26Md?=
 =?us-ascii?Q?C6BYlWFE7XJV0TlfpurE6DZLrAWnP+w3rnhuOoACvJf1Jj7W5eNbPDD0dkk8?=
 =?us-ascii?Q?QZj+WAlxAkDzKMXdSOv9L0g6qr+FOlf6ABhndQQWepScQaUrQyzsDJX2A8K1?=
 =?us-ascii?Q?U2WgYEPuVFM6mVTx8WYn6KBvhYk1ELGxgql4n9L4toquO5MEwO4oHBTLJU5d?=
 =?us-ascii?Q?AHd97ZMMjnc/nHAUdULdZTWAGrQmZenXIhtfFEg+MTa2uZ138HqdW7JW9wuR?=
 =?us-ascii?Q?kRo40l/N8zUzs5vAeNGXyRf9S3issYBvixvn+Pj9pCHkw01r7pP8FXjbMMD2?=
 =?us-ascii?Q?PQfWh+Q/80P0erDtiysglewVR9/vbp87A7N1sk37GJ+1G0bAOtR4FkzhFJw7?=
 =?us-ascii?Q?R9eHceRR9vgI4rSrKnSM7b+XXH/ev8SVW8UG5ZoV8+/RN5AlKxkDSu5eI7W7?=
 =?us-ascii?Q?mtetd9zalmy46fWxP9bYRaUXydldIN3Ex6OQzpgLbBwsMKd1E+axGFDVNqPp?=
 =?us-ascii?Q?sAxrBxUmu6ev0CbxVKtxkYA70xrZey4f+FFoyRdUxqm4mcNRPLh+wNm/XvOM?=
 =?us-ascii?Q?CWto3Ox6truYQCYE3LYUVqw1xH0bwojMzQ3EVGmBOoQbVUmUFcSaO5+eksaw?=
 =?us-ascii?Q?wfkd2rC4EWd81jtDeWGJzJrRJ2fX7gdEMDgtqN/y8HyskeOQ/7MtcfQAToDm?=
 =?us-ascii?Q?sq7XlzzK0mwmZo+/8/KNxzofqtkDIVxzRvx1J65eW+uvsJ4Iqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hW4wxVz5lex4zEgninLvBESBjDKlPttdKlJE+oSz5l1dnq9hUkpnB7AhFhQ4?=
 =?us-ascii?Q?L8Js1nSY5lrbwgF4q9P0bhLmPTF9QL3frIjystfATZKax4RAvjJ274vha0Y7?=
 =?us-ascii?Q?R2kajv5Tf8FOiQVUVVRPkL060nmO5fK6LNvPvAbOrT+7vyKkFqxxGGAjzD+e?=
 =?us-ascii?Q?cFmWuX8OAmVal8XoJNqEDqFha32gepf7UfkWjrhrMKTybn9L5oYdNeM4yAK/?=
 =?us-ascii?Q?9FWmne84GSHZJ+Uld1TQmJSvkduHP0BA1BGXPFdbOZfk9KM5Csc9TU975APE?=
 =?us-ascii?Q?CabjVPUx8qLVwywng1uLO5rKCHeOZarHAekgiFjXG4nPUxd8GPhG+4ETChLw?=
 =?us-ascii?Q?8fphbhGcOF+N5RkELMYuycybJd1wKSyiuO47O68t38LPRLERX8RyLvShtABc?=
 =?us-ascii?Q?48wMRfqs8P8LattvbOqKAYrf4sDpBThLeHltJh1uaTNubwdPNDXS9ctFz2AG?=
 =?us-ascii?Q?YWUAV9nHTOZmGKg7v7U7iLX94OC/2uT/1NQEfUHowj7Z5BkeWf4sm/CdEKby?=
 =?us-ascii?Q?Ee/Pcdg2GJuFkBBrzz2bAl4wl9Rr/tgJSJrbkdZjeK91Pkcea8N0DXB6GHNC?=
 =?us-ascii?Q?3g9haEuy98v/fqLJ9aaYFsKTBYj7vCVFPnuaqTF1OBAv1YRD7eK9gAi2tLQc?=
 =?us-ascii?Q?FvH5alm7uZoGU7BFe2njIn9DOVQdDd+x8+/8ksPTpbZdo3j2oezTVMwUabTF?=
 =?us-ascii?Q?UNW9lx9xC95E2i4iMyuDgrHLXAE00i6RyhjiOV1bcYjswZgmBKHCFGsBcFpA?=
 =?us-ascii?Q?zS+qvFAPu6PrMKHXhINerCN2OmwTAoFoBgH5F0uaUE0A8L+RnRaTT/IpCdDs?=
 =?us-ascii?Q?YmCoz8EB4yeU26omVE2A8NDwgfZPWRFv0fv3Sq5wrbnkow2pitj9rPnG/Nyq?=
 =?us-ascii?Q?FaW+UFtCKAZQnMhyHgC9m+3nYe++XZScdlIiB43CNVR4wA8aPV/F2FloWjbL?=
 =?us-ascii?Q?pnlQzB1zVeH9+ivPDCT2Mk8zewz35goc7wfnDuu4lvoi/tZJujZZpo60iIG4?=
 =?us-ascii?Q?NCQY3XcoWtgzz1N1OiszEHp583xJn8QM+xMhwPPxk4E7CeHdB7JjTb47jkrl?=
 =?us-ascii?Q?cDpH8gan45d/o/+Y4ac/RpaSJiSHjj943DRnwlCirDRgDNyuxFYrVsStF3bZ?=
 =?us-ascii?Q?Az8AFU7/QXYQAi2HcZcvcg4URYMGLa9usExEiLpO4GFGzdpbbbvxlEtQpidw?=
 =?us-ascii?Q?jdHr7NHxAWySKRpecD/NeChUyY0QR3rLVxyXRtEKz1433chQd2tjXZA72W8f?=
 =?us-ascii?Q?yWvWAAonamVwKsj4wJXIuqxKmCTzEzQ58PWwiLdbjEz5JDBBfNIo6vkkKP5S?=
 =?us-ascii?Q?0jHea5U5A75yT4zuGNqttsOrhUe9/4eYHJMT6JAxml3a5MxB+dWRiqJzI8Se?=
 =?us-ascii?Q?zuyKqxg8+K0etUOWmRgPtknWNFxb19kTT54IAK4ZaQnE33HNc7eXEgEI/Meb?=
 =?us-ascii?Q?rcJBvIr7+rgC8VjKtoXlieDjUUUpREr4fu+t0k+b79HTPuKiGLJzxlzFjrs9?=
 =?us-ascii?Q?96eGNPuTV6rjtdfKxRlDfuLJN+HR3q1J7rpx4iR1kTbJ9kveWQed7sjbW7X/?=
 =?us-ascii?Q?FFBnLLc3Fz9MYRwNGwRbn6Rb9pDSWNUW6YHG0mhj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b189953b-b3e1-4e0d-d328-08dcc104ea37
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:23.5107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovGdDdVnNH4nUV3/BrOWyqqUPPGHwMv67A41dbsJy8D6o5UK12MZ59nBrI+mymfkeOfnrRvWMlXojo1SklUFrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

This adds support for entering the broadcast code on sink side. When
the user selects a transport, if the transport is encrypted, the user
will be prompted to enter the broadcast code before the process of
transport selection can continue.
---
 client/player.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/client/player.c b/client/player.c
index f1cd90966..6c79cb27c 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5022,8 +5022,65 @@ static void cmd_acquire_transport(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void set_bcode_cb(const DBusError *error, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to set broadcast code: %s\n",
+								error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Setting broadcast code succeeded\n");
+
+	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
+				select_reply, proxy, NULL))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
+static void set_bcode(const char *input, void *user_data)
+{
+	GDBusProxy *proxy = user_data;
+	char *bcode = g_strdup(input);
+
+	if (g_dbus_proxy_set_property_dict(proxy, "QoS", "BCode",
+				DBUS_TYPE_STRING, bcode,
+				set_bcode_cb, user_data, NULL) == FALSE){
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void transport_select(GDBusProxy *proxy, bool prompt)
 {
+	DBusMessageIter iter, array, entry, value;
+	unsigned char encryption;
+	const char *key;
+
+	if (g_dbus_proxy_get_property(proxy, "QoS", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_recurse(&iter, &array);
+
+	while (dbus_message_iter_get_arg_type(&array) !=
+						DBUS_TYPE_INVALID) {
+		dbus_message_iter_recurse(&array, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		if (!strcasecmp(key, "Encryption")) {
+			dbus_message_iter_next(&entry);
+			dbus_message_iter_recurse(&entry, &value);
+			dbus_message_iter_get_basic(&value, &encryption);
+			if (encryption == 1) {
+				bt_shell_prompt_input("",
+				"Enter broadcast code:", set_bcode, proxy);
+				return;
+			}
+			break;
+		}
+		dbus_message_iter_next(&array);
+	}
+
 	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
 					select_reply, proxy, NULL)) {
 		bt_shell_printf("Failed select transport\n");
-- 
2.40.1

