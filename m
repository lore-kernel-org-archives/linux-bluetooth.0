Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DD81EB9F3
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374592; cv=fail; b=TtkRsg9nnWCpg4zTTEXS9gC+kqQ61xprLrH/5W95eaT6F95ZBXR1M6VsASexTUgYIC3x7FbIVozvQHRwCf67tSfYOIZEJCVDQtkS0H7BrI6MRs0AIABCFgDgGYomnlu85m72XGxBoOm9bOh4DUW8lRovby1fm0GIfcVwZsIn/qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374592; c=relaxed/simple;
	bh=4GgI4Isa/L15DGlKgFh5WRgEF83HkOwJnnmcYwp7bSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YFL+RPwIiHfDlJDkHSbDmjsUxjn7iUvui9RbHeucn5Ht7xr09WHnvvdgJAIp0JqzQje7xD7auhd9hImtsKMuG4ob5YHEglURUw5em4DStJi+t02izmChAnP9/0pbB7xMq/bEi5H8/ShVahi8jt67M8suuE75Ky9MBK0Sv53U5C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VmNvqiUr; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VmNvqiUr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yB3nXsep+8Y9eAJpi1FtJrxhb2hc9VgkslEmXiapBXFeFWDprreegtaJ29jkTAjdTZw5wcuGVRyBcnNtp2fb1whrFukeLUFkfowGbK6Qvhqf7wcWCc7zlUGKaRj0o7i2qTI2ce9Mj+emCYtWXfCjFHGtNiebrfqmV09vG3U5wx3svKZxBoJWebbheDsOyLkwCJc9Q1qeL8tcxFXhxPwrgj5LnD7TfZAp8WXtAwSfffI1CIHIptOi5Jj2Y7a4wJP5CGkGTWq+qjlGE+e7qB6vL8NuSvtyGGPjQ7k+/+YC+QLejS2W2ovh9+b5B6qebzrUrMzSFFJUZT2X1PsouRdLuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1Zu6wrZiwVe7s2wdrXx38OHBZBOSfSa4H0ZhWFgxUs=;
 b=XonWe8coc2tlCy7yPYEcvEGHfIq6EEeDnXiZcXU+xzhKlR96bHEh68lVyJgh+0Yn6vSaWAE3j2BTUzKgSgMuLsH4k1l68J38RokN54ekL00RuN4gjm8pd+e3rwOAg2Zhjm4cKHvK2b2gDbcr8ob0IzBhdcvYok+DLGYqgzJXqyDg/fs0HBxmtSkFKkJ4f7RWZFXiFwTxqB6RvHqioYRMu+buClpuH9ulHQts3Q+XSqhgCyvt+4uMAKRrFryLcZzI5KS7RzlZTcMkZnMQt3sSUiXehz0TSpt38cSAMEBoHnhD4fp/f4Ky0IaekIUqWDbcfKQOUiqBhBe+38XURblamg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1Zu6wrZiwVe7s2wdrXx38OHBZBOSfSa4H0ZhWFgxUs=;
 b=VmNvqiUrUqz53w//M4qJYy2WS6QfMGK/pbRPjV45ypR9LrZ6aQZ7yuvFHO28qtToHaHePjP2ye1aroD1nt9RcSWc28OLXSy5Uu6lQJvKGniNgEm2ctfYmkGSU9vOr2PMgoIYjwoTu+y6kfjzonEDad1JVh/MCEvhv/d7zHkCfRiBFKEf7nKri5MhuyuVN2VY7pnGDMGHbkWof64xMZerGuThyz6Ql/Gl85VRVvCWtVxGgxnDO5Q22tWv5HxFWbO+pZgGNNeP0fijkPrXJEzBkMxBtnbN5Fc0B75ohLH4pNlQjsWQpl3o9IW2Lz0SgrwTlxMcDU27z+R1a/vRkB0x+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 08:01:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:01:49 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/7] client/player: Add support to set empty bcode
Date: Tue,  8 Oct 2024 11:01:20 +0300
Message-ID: <20241008080126.48703-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
References: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: e387ef49-be07-4156-fe55-08dce76f762b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y8ludefOq4zdoxI4qptClx1ZyMswxU7Xm283/Yq1fvVKmJO+VEJ3yIUMgeVH?=
 =?us-ascii?Q?WosFfBgB5tVVywQbaFv1pajabxFH/4t+rLdJKh2JTmFIj9DlAUGANhXmddeg?=
 =?us-ascii?Q?oZq1Q16rudReoFq938Q+TzTqNQGdmXLhe0fJWBBlOFXGgqcyS6Ic8gVA7MFC?=
 =?us-ascii?Q?r57qPQ6zmjDT4XlcDSYxd5wo6mUmsW/CAiKpfF3Qtjt9ho+sYEAznz5bPhu4?=
 =?us-ascii?Q?hs35C8cItM9iQApy+2HCJxpCtHxIEcHcnXqWpWbaHLakvhb7hJaSEfyzxBzd?=
 =?us-ascii?Q?ai/4wKsM8NmP2WyjMZxxFXz5vsUjje96c4qjQIJDxnmpi6nRgFwSUtb1XsO2?=
 =?us-ascii?Q?iVqTcNek4/5iQNVnLPutJ9zNv2glFt7hSGQaW47HckOPN9TikyRxw/SXBZD7?=
 =?us-ascii?Q?gASu8air6RKerMAdqTiR1tkiEzbZsLE25/LhUzOVt23lE/1L5dDMcFiqD/Rf?=
 =?us-ascii?Q?ofNzlQJfRpULUzlBaRZjy3kqJwi5J0kxQu0j4rKVcBogGtPkGarUirRnC8Je?=
 =?us-ascii?Q?tJ+9cb85kqfDOG7bH7lcOW2VgbsCPdhWttOGFgXeDeaC2m9BZ9yDCYOWFX6V?=
 =?us-ascii?Q?r5DMB7bUUNTDiM4YWZ1dG8VXW7adqHM0TXZxImlhTJFOi6XFwAuJZkmODy3/?=
 =?us-ascii?Q?CGe06k6aeYbq0hQvCPAFHcJwTVst1Bm8PQBCrEeoSgBLcGUtvRMFCDchiNHd?=
 =?us-ascii?Q?XtLvSyVN7Pmeix7iyd+yrNcNoMYsfhwXwuXZuUcc1Nf5ZKGHQwrHl29tMqRA?=
 =?us-ascii?Q?4FXBle6FRFCGTtv02GdbIis5ifLJyDN9kWtAWC7Ndn0UQQWHBty8mcwA1bYh?=
 =?us-ascii?Q?MN96KzAmadrFSuhqXnwXnlaERyG0UMpa8qayNQScHQ9A39NpRVd3lB4jRqtr?=
 =?us-ascii?Q?xj+GcBoU/DDMS8eFOon6/m5AmXcduiEtiu4VVlfPgj7DlxBZ573lSoP4jWpi?=
 =?us-ascii?Q?tS56eOaukqYdlqYIbkA/wMpPNTWMsFg3dPg/rhoQhfQDAdZRWt5yr4VtD+EV?=
 =?us-ascii?Q?3LCfiICm0klo297RAvByyXXkSa3t5yr1qwTmObymhG/Kxi+r5gLKgbpa0cjf?=
 =?us-ascii?Q?Ilo0dySX9xENIcTez7b6rAhuaObQCN2Ia82Tuo19InwKCV38tFPX/j1c8nz+?=
 =?us-ascii?Q?IMG/xH4Xqi/+wqFDSagUhCNBkTeqWn1ShQtPDjVkNA3U1kcKZc0UxK58tlcV?=
 =?us-ascii?Q?ImMIWAgMGsiK2E4Rgqcw7Ihz2rENIa8lgymUcr0CDeSkxGztPdBRPtLtl1SH?=
 =?us-ascii?Q?YVD8hDv76u3DRaKF3Xf51bWpZy6C/lgrozxvpooMFMT/2hg+ZJvjateEH/9N?=
 =?us-ascii?Q?Id8alVPRIyVWxwqOdhlgLD44ftveL4HENBdrDhl00sV81g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v/z8XaBBy8LDD1SXoLA4GS+GM4omg8Ek8Y+uuJSosWqSAZ1Spb5CENHxTPNF?=
 =?us-ascii?Q?GsJ4Kcb+gHVmRYdruxnwNIb62G4r+X/weC0pV7z3hquhtY3HuNY7U2+MNw9b?=
 =?us-ascii?Q?5MnAz360Jpd4vOhtXBwcZ9MUOJiia2n6tQYAwpg3FNoRdAm8z8EQ46+NNU1n?=
 =?us-ascii?Q?eYQScdCQzVC0Y/IJ+mEYfTUgmijQGnP+gwcCHVc6RcqpvZBFHMY05+CfXPyK?=
 =?us-ascii?Q?vI9wG7EOGQYaaYV+E9r9LPo1I7V5hjQ+SYAKI6mij9spBsqpZ67xh95MTNRb?=
 =?us-ascii?Q?6BcfTn637k4TzlVygvSqxhoqjMnboeUCTwO1QnDHNvBnO9MIBq2wlgdrnZA4?=
 =?us-ascii?Q?TGx0oIyDLijER5ss1gnyN/IpvRm8t+24dV2YMeLrQq+6jxUUkDnwJpxaYuhJ?=
 =?us-ascii?Q?Tdz2DNTQ+t3AhfrCSQ4QFlp6KyA8XG6hWPqeJ0oJ2J5UkkYDyd3Ms/8GaqRG?=
 =?us-ascii?Q?rJlEdJQSx/1qkSySMhKaxgsXhA9+3U4UMd/ebZQp5hajhUqhFiTxNaM32Z4F?=
 =?us-ascii?Q?IhJ6/t/lYyqbQSaPeRC44L+mgtGBH3DKtZKUw/gVqUl3pYh+XmtzjPHsbK4S?=
 =?us-ascii?Q?VO3tfWIIz8jcywnK0oOylHWgfIAibIDXqi0HULnThYQbtmTgJ0w/4MGb97X5?=
 =?us-ascii?Q?jn1ul9NSyBTNGx+Ja76irubWNg6svEShNDXqRiDKJnltYKT/OZWI9YuWeZr7?=
 =?us-ascii?Q?EL7sdQLywz0/jdOB8JdwPJxKbubHCNgvhJsxUZAB6PWmQKpzUcHOwcz1uakU?=
 =?us-ascii?Q?qzKsKXDc5/X2TRg4cgCJCKh/gE9ovuE8gI0vyRUM0195cm68Haopw2oDkaBN?=
 =?us-ascii?Q?TcosPIjB6KYgkf48eKljW+qm805KIWVsncqo6rc1U+8+56ZNdsm0YVdW9JGJ?=
 =?us-ascii?Q?7UwDJeiYQql0++xEsQc3b91J6FP/+crR8225onxFXlz+qPDVxtvr4PXR7i0H?=
 =?us-ascii?Q?WoChWe0V6rv+8Hov/aDKSJ6+8lPZbEhi6h/9t5/PQnUmEg5p0RZyn1CSdkvz?=
 =?us-ascii?Q?GOEza4yhf2om5HG1NtWSlM5MDjTOCNQbt5Ps/qbrThdLG7aT0ca4tGSLGjS6?=
 =?us-ascii?Q?u4Vz5GPbg9i1EDEkdkY3caIFpzrdC0+wvi/ZcqneR7N+1RluvRXX5mD8EYRr?=
 =?us-ascii?Q?FtLKvEt4ZklzG7G26nL6BORvbr4xeVZpbiFbOh9FQKrNA2BJnxIh6IutnyWn?=
 =?us-ascii?Q?5hJxN+fIXjSaSy0kbXP4SaxuGhWxtiomepnDe2lISO4hTOm2MG0Q8IoZSZf8?=
 =?us-ascii?Q?Py+jQoVlEc+Geyk2jL6L6l0Iyu0lCVdxDTvtD0FhQjf/Lqh8el8BdAklUoQy?=
 =?us-ascii?Q?2U1pm1KmGDUv85tyt2R5EvNUq0WM411yG8nt6eN8mpQGi7BEeNqc1JPiWnOl?=
 =?us-ascii?Q?jz/gJuApPfgepO/MUjiqROf5jWcpq8079W5jgsRtbWxe4bGHcoEpT26rYFAq?=
 =?us-ascii?Q?zScD+3/XI7MtXdjhbyd1yf5b1aHJnip6nBTqxXdToxJQB7aTRwmU2XqmHO7j?=
 =?us-ascii?Q?/TYaf+arIidU1PwNA5nwO74h2hNsXEC6gzUPrd7se8Bfb9mJnG/dW22I+W32?=
 =?us-ascii?Q?UnRslEvfgpuZcfulxc/zyviXJkFojbzsxo5EuJwCAX+zXcPPE+Dj5LW0R8P4?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e387ef49-be07-4156-fe55-08dce76f762b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:01:49.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /sDCRoNRgks9K+dqwM05HoeyIp7TMO9x4ko3aqPHZwVrI52O+qS4+toaHJnO+BHVX9ePUYWg00vf6jZ6e4R1jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

A Broadcast Sink might scan encrypted streams, and the user might not
know the Broadcast Code to decrypt them.

This commit adds the option to set an empty Broadcast Code when prompted
for it after transport.select, if the Code is unknown. In this case, if
the Broadcast Sink is acting as a Scan Delegator, it can ask its peer
Broadcast Assistants to provide the Code through BASS.
---
 client/player.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index df2246516..188378175 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5150,15 +5150,23 @@ static void set_bcode_cb(const DBusError *error, void *user_data)
 static void set_bcode(const char *input, void *user_data)
 {
 	GDBusProxy *proxy = user_data;
-	char *bcode = g_strdup(input);
+	char *bcode;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no"))
+		bcode = g_new0(char, 16);
+	else
+		bcode = g_strdup(input);
 
 	if (g_dbus_proxy_set_property_dict(proxy, "QoS",
 				set_bcode_cb, user_data,
 				NULL, "BCode", DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
 				strlen(bcode), bcode, NULL) == FALSE) {
 		bt_shell_printf("Setting broadcast code failed\n");
+		g_free(bcode);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
+
+	g_free(bcode);
 }
 
 static void transport_select(GDBusProxy *proxy, bool prompt)
@@ -5183,7 +5191,8 @@ static void transport_select(GDBusProxy *proxy, bool prompt)
 			dbus_message_iter_get_basic(&value, &encryption);
 			if (encryption == 1) {
 				bt_shell_prompt_input("",
-				"Enter broadcast code:", set_bcode, proxy);
+					"Enter brocast code[value/no]:",
+					set_bcode, proxy);
 				return;
 			}
 			break;
-- 
2.43.0

