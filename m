Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CE31AE87E
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935778; cv=fail; b=bZNzXj+2S0xw5SXURNnyCiU8Q0yCpKlzDkHzD3CCj7p7G0cETnVOo/HcA5oZ0/D+M4vTLsQKL20j9jDe2CuvxlguqIjtWxGFsk4a8KfiFDZMjkDWQUL6CQrS0YkKpy3posD1EKG+iUmMUGzYG7WQuiqWbviyt31zw+6vm0t4aQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935778; c=relaxed/simple;
	bh=cK5eRj94DvJJ+vkSFcDaaQt8uMBKkn8Yak0ZuEHGT1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k986JbYT2k3D/o+GZiOb4BF9iNeOC5FXL0xAIAAilGM7e19nJixIzCLPwOM7f9n9MIeaqUKhtc4UodZC8Sek7DyEHmHHhtrOEsEyOknV1V53aKftlvz6YIMjwsJM4an+79UqbNvsYcxhIcoIl+eGvdTZ5u2Y6c2nJKsOUPvutZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=maDmJtAE; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="maDmJtAE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRrKro6YPvCEVTQy5GgN51XLoMKtVvHl8RBWfiMp7rad9ae7U8x30G5HWdZD6XLGfGrRUBs5meQFnZXEeNicRaGkPQ+h4zgKqBRM0cgprsjn/pxnd/aIUn6ZCK31z2wfJh6Fcw98aga6d0QTpN0GhmEC0skZwPi6Cs6u4UVToJKqYbHG6HzN9OJ4+vN8kiTRngsVm6LVniDrce1XWpnZZ4TZsYYowqbtrTpM2VdWbIsmu+WvpyrBJrn5iW5ZdkSXie3Cd4m9aB4NTrhxQNImSndTS2w5DxsJw0rzXocdUv9keqooPIIafFLCfystU+eteT2O30heyP2ENWRWguG9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGQvvXv3zJn5kt7g/XqmjGIR5Hs/awBU7QrET2rmmnU=;
 b=pgnaFcSrhGtrWDDQkVk7xZiMSNkyaHd8aT7ggV16i9K59yYTCsM7vOmRZ2TYcL4/djNz6p12L4bCtEFLrMxH799aRqdv9fICvfm/eqOCioPy5mEsKtawlBAhRP/V28fBsxIxHUZReHy8n4a+9JjPIG8cSH7ZeDf/5MXfaNaHcfomuIA38tTO3O480zvbZoG+es3imGrV9osKbNLufDkmb9ziqjRZaFJ4MdjNyzfz9Vbhxugo8wc2j6BeW8kQEnDuRcL0rpN1tNu2IVCxuhYxTt5a4/PWUuN+4p4xf1qkeHKAHZ8nyowSQNZtTVYI1hGzaTxvDlOPrppIjZjmKxxwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGQvvXv3zJn5kt7g/XqmjGIR5Hs/awBU7QrET2rmmnU=;
 b=maDmJtAEDwO25MAbzoNhGJRjT/fTNVlE43pOYGiw6I8Qy7HX6Vp6FeD2fCGOPIviZZt/r+ATst8NHCeBk/FLrViivckjpmnB/9VzGCtqxulbfQELVjFlxVVu7PsZpHnIcScVr3Xqmhs3YO7eAr8zOyMmhyrAJ8m7Y7qISRsMtXPcaMOo40Zy2dHoLvIzQN8HgNTPFGTyKBcCEcaXhViwyJ2plZHeiCHDtz8hd38hp1MikqP/Gr+aSqGo1VuU0YQSFK5DbWXZWqbdBWqb3tZ+gu3jWHDaNk9XOsV9fcbXqQIvnofWpb9TNAIzoeOCSf4aQRzDaRggQdt5O5Z6MQqRgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:34 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:33 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 03/16] shared/bass: Remove io handling
Date: Thu, 29 Aug 2024 15:49:05 +0300
Message-Id: <20240829124918.84809-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: ffbd7cff-a19d-4ecd-2d42-08dcc829084a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8iqGosSsAYZE8DbkVvzKD+eloKmihALrzG0+TauU/bjj4pwp8+NZ3oVIIgjt?=
 =?us-ascii?Q?N8mfAQ21w8byDr3dd88j4d4jXWAkt8D69eY/1kH9DElDKtW6tidKWmRs0plZ?=
 =?us-ascii?Q?U5EKEh0MiBfMCK4DsPfrtkE320vv6bI72ntVldXi5mOEbKiKkAoDhODTqNzy?=
 =?us-ascii?Q?q83pa1IXb41/ZtSY8emxby4UU38ScONcS8271JrkUthyNsmX0PrMJt5sxbaQ?=
 =?us-ascii?Q?GccnI1SCSNffNyzvvVRz++qWy44SK7cmCuH31xZLpQ+Ongqkftox+SCsLQdv?=
 =?us-ascii?Q?ipett7EgQm5rasKeFwCAoobsc8mLJK2LTEeNu1UQBcAY9BszoP+Y+V07jy2B?=
 =?us-ascii?Q?w4g9TNa7enjVa+H5FAnkInpJvArjh2f9gI1veWHmcngtj4sv5KmY8CH+1AJB?=
 =?us-ascii?Q?8zJ8aufsBVTjtHhS+qa9VPPxoQ09/aJzoSSIJlLdDujuCFCcVS2Z+fHSMSeO?=
 =?us-ascii?Q?o5DFV3ltnRXauOzo3wsiuQJqBNBIRGoY+IuD1LYkTAnrzI6i/ZelHdl3bWhB?=
 =?us-ascii?Q?uYLGXT4i67eyuQQO+JCLjzrfHPIA7G5118DvOq5b0YKONYAG2Vga9uw3NTGP?=
 =?us-ascii?Q?Z/6E5iE0JpERvahBRIiheJpGCN9C5CP2EnqNKhxQr90kft1Rj1BYJi7UY1IZ?=
 =?us-ascii?Q?qLR1ClFtAxUjrPfvTKrb9WerB2Y5dDtpobpXl9CkBTxJxy9S1qAZp69C1Hp8?=
 =?us-ascii?Q?MU0lP6zJbvWOBST4Vkb2kQ48PkhWEXEnxbPFIqXjK8HxqNRuLblnVhyPcteP?=
 =?us-ascii?Q?gxrOBUYMP5piZ5YKjr4LSKhDDWFhwmZlmpqZ54nLcxkUOshJY0ykS2FOBrlI?=
 =?us-ascii?Q?2Or/YtrXbCczfEoMOpT+5NMYXXhDuBhjN4OZEIuGwlwi9Nj6awMrUF7/VxIf?=
 =?us-ascii?Q?moNv+DMa5ONXnTQ5x88AV+ke8cW2Su4s+4Eox/tGpeYBR/QVXdhwFSdwEGTn?=
 =?us-ascii?Q?gxFq1pl0dYBNG/ZlEM3vcUn03SOKJz+hnVuDCk7Wup8KIRFOGOGjnVi97QyO?=
 =?us-ascii?Q?TzNJ0kVooEt3hsX04rGqQbx9Hn07dnfYYbFOB/8BsYiuTwY8WTjHHRxOttIw?=
 =?us-ascii?Q?GcNOtzFa56x+euAcQuFaumIwRBxvjTfw5mbGzOZR4KjwdmdHg8OwlZ3f3Bk0?=
 =?us-ascii?Q?/llP1v4B52OS73kC0RT/v8+iBIWM8QfKfBcBffHRRJMVDZo3l4hmEzc20Jao?=
 =?us-ascii?Q?iss+ou8Un+Y752QgR1B5HYu4Kwbm6N5r4L9sESSjGBDsARIfyVInCXpB6pSv?=
 =?us-ascii?Q?CEgaPkJKckg0vgCk8QMcNSfYZ0K+bo/kyPltOPBOpC2djlV0SegM9TwyTFWV?=
 =?us-ascii?Q?VpxhJaZfjNIRBkHcKDGx0/2ywhxCwqa6ByW40la5Z1b9fA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cg9XIerjgv2GGNmZ5P/3GmV9PM0m0m0SQUk8aLpMccOWN4mMzXmA/tmvmmfR?=
 =?us-ascii?Q?d6GYkSS6WsyijEGnY0cdnqZmRJtuH7D0vUlqpRsHUPQtY0mYUhIW8ZJyYR1n?=
 =?us-ascii?Q?zDU7jJWMTh06UpUy3CKnFCloN5rdprcdzTXL3TyP9OVRzF+2ANKV96qoEtsw?=
 =?us-ascii?Q?ewdXUrIG+1KTkwq/U5VgSZsFYNHSqMmg01jbegNJ/1U/guk8mmwwkeKlJLTb?=
 =?us-ascii?Q?znjggn5pOiWGmnUcRQ6A2pxFpeGB0aA+80MFJ0GNlMAd0r6XqGPb/Tr2Fayu?=
 =?us-ascii?Q?FqU9oE7XIme+x7X6bGbUkyu6ag81tcFIxJ+UB6R6qKIkkdbOetXs1YTsEcua?=
 =?us-ascii?Q?WHObmJdJmbZ8rAOhbah6/BF2qKzqeJQGabNzkLJ01v8jWXFdXFCjl3dh6SKI?=
 =?us-ascii?Q?2Yod3qgQ1BFQDQvRZTuKQHrKFGpOPGMHLBpkhzHYZsGr/FeJBjcBrbqcrvSZ?=
 =?us-ascii?Q?oFmG2oh1lFe863+SVkNDA01KrPZjhWo/JG+TfPzGk6BM7MAH7tWF9iR40vQf?=
 =?us-ascii?Q?xst9mWYcII7Yf8XraqqRRCyfSYq4cKXDUT/Gq7C4kJczwBbVIQIUCf8+yB2s?=
 =?us-ascii?Q?ZkTpfhE76egJKJSEExifkNQu4eTSUIfnLjPrNalR0IXR5kCovJjdJuRnt1S8?=
 =?us-ascii?Q?3YLJ/BTOwFZgmCsvteA7W83BgMFM26MuT4BjMHwp+b2CWe297sSmXlOrH03D?=
 =?us-ascii?Q?r/LVWePGK7KG59uyFjjuJNZLwRmEyvwxY/WlRLLyoYtdq6LIfX+0TJVh0+D4?=
 =?us-ascii?Q?lNnMtDRRY6yMjkT4eZnv9cpw71oE3HOL3WD5da60xWC3dF7wJE2fdiZffB6y?=
 =?us-ascii?Q?fl7Qb/wyvlwrBg0oCfE4kbx5yr/Fsot/kooIyiQ+POGIMIr8C/6UVmVIqXjC?=
 =?us-ascii?Q?q1veOTQ+ewQssPttAvfB4aeGzCmhVw8NxVLubVzm584JUj0duoO++fyRTATB?=
 =?us-ascii?Q?7HMp0d/1cA4yWI04thEYXapd+H9n8ukmjRf8m1LSlOE3lvRpzLRAoDxYiOsw?=
 =?us-ascii?Q?Vi0FytVMmo/+d8eUb13twr4OZLQfHsRgSN8jsj7eg3MpuzZ1f6b3PxhiV13X?=
 =?us-ascii?Q?rei/u0GO1GpGej7WVwRD52Sy7DJSgmcOWOwp0G2QOitqwT2ztnlOg0S0Y+iv?=
 =?us-ascii?Q?Gy4SJx5DYl8VG/Bv1ysqH6IcW9bh0KUG3VxonfTpTi8o22AvpbxCq6yJUe5v?=
 =?us-ascii?Q?HogYTVHbPrhCifOCJoW0nnCZXfIwcCv3JXnmED3NeQNPSVM4YxCPSIZ2b7KZ?=
 =?us-ascii?Q?SwEcPY9jsVTF1wxqLGtN+BR7t8FJzm1YPBFwSaJxZY5Mt4DO6wY/0xc3rF+J?=
 =?us-ascii?Q?ARPS7+Uv2gvs4XsBWwxLokW/Fr/Vv8+/ytBPwZqmNl8jRbTcYCgusYD1AlGf?=
 =?us-ascii?Q?FgLMqcevBY4mjbvLgU6tHBnDMVEZMKtsP3qYRTFdEOMx+k63yhae2iwhbU/y?=
 =?us-ascii?Q?/d9gsKBafXBLDYHNt3dnqTHO375hbt6rk6mywIfwEPEpbeubvdojo5yWhI+W?=
 =?us-ascii?Q?Y90n4fDiGHwlSlvpga7hY9LRNO9vR6NEeud8YF4erwlBhWSPswm2FwEJLVID?=
 =?us-ascii?Q?wNgTQeUsFqLiJRm8HkV1S4Ogx0bLkC9vadFwYsroNkJpTmi/1WjCQCgVxUp6?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbd7cff-a19d-4ecd-2d42-08dcc829084a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:33.9632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmkmYp2iExG60/2m0DifcbII7HFUSYMbyIh5fd12XtpDQsQ7rLb8HpqHQSJ3mgci6d9n2Fa+lf7c58q+ZPaHWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

Socket connect/listen procedures should not be handled inside src/shared.
The BASS plugin should be the one to handle these socket operations.
This removes IO handling from shared/bass.
---
 src/shared/bass.c | 315 +---------------------------------------------
 1 file changed, 2 insertions(+), 313 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 131f978b0..636eb24fd 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -14,13 +14,9 @@
 #include <stdbool.h>
 #include <unistd.h>
 #include <errno.h>
-#include <poll.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
-#include "lib/iso.h"
-
-#include "btio/btio.h"
 
 #include "src/shared/queue.h"
 #include "src/shared/util.h"
@@ -29,8 +25,6 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/bass.h"
 
-#define MAX_BIS_BITMASK_IDX		31
-
 #define DBG(_bass, fmt, arg...) \
 	bass_debug(_bass, "%s:%s() " fmt, __FILE__, __func__, ## arg)
 
@@ -102,9 +96,6 @@ struct bt_bcast_src {
 	uint8_t bad_code[BT_BASS_BCAST_CODE_SIZE];
 	uint8_t num_subgroups;
 	struct bt_bass_subgroup_data *subgroup_data;
-	GIOChannel *listen_io;
-	GIOChannel *pa_sync_io;
-	struct queue *bises;
 };
 
 typedef void (*bass_notify_t)(struct bt_bass *bass, uint16_t value_handle,
@@ -122,35 +113,6 @@ static struct queue *bass_db;
 static struct queue *bass_cbs;
 static struct queue *sessions;
 
-#define DEFAULT_IO_QOS \
-{ \
-	.interval	= 10000, \
-	.latency	= 10, \
-	.sdu		= 40, \
-	.phy		= 0x02, \
-	.rtn		= 2, \
-}
-
-static struct bt_iso_qos default_qos = {
-	.bcast = {
-		.big			= BT_ISO_QOS_BIG_UNSET,
-		.bis			= BT_ISO_QOS_BIS_UNSET,
-		.sync_factor		= 0x07,
-		.packing		= 0x00,
-		.framing		= 0x00,
-		.in			= DEFAULT_IO_QOS,
-		.out			= DEFAULT_IO_QOS,
-		.encryption		= 0x00,
-		.bcode			= {0x00},
-		.options		= 0x00,
-		.skip			= 0x0000,
-		.sync_timeout		= BT_ISO_SYNC_TIMEOUT,
-		.sync_cte_type		= 0x00,
-		.mse			= 0x00,
-		.timeout		= BT_ISO_SYNC_TIMEOUT,
-	}
-};
-
 struct bt_bass_src_changed {
 	unsigned int id;
 	bt_bass_src_func_t cb;
@@ -646,115 +608,6 @@ static bool bass_src_attr_match(const void *data, const void *match_data)
 	return (bcast_src->attr == attr);
 }
 
-static gboolean check_io_err(GIOChannel *io)
-{
-	struct pollfd fds;
-
-	memset(&fds, 0, sizeof(fds));
-	fds.fd = g_io_channel_unix_get_fd(io);
-	fds.events = POLLERR;
-
-	if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLERR))
-		return TRUE;
-
-	return FALSE;
-}
-
-static void bass_bis_unref(void *data)
-{
-	GIOChannel *io = data;
-
-	g_io_channel_unref(io);
-}
-
-static void connect_cb(GIOChannel *io, GError *gerr,
-				gpointer user_data)
-{
-	struct bt_bcast_src *bcast_src = user_data;
-	struct iovec *notif;
-	int bis_idx;
-	int i;
-
-	/* Keep io reference */
-	g_io_channel_ref(io);
-	queue_push_tail(bcast_src->bises, io);
-
-	for (i = 0; i < bcast_src->num_subgroups; i++) {
-		struct bt_bass_subgroup_data *data =
-				&bcast_src->subgroup_data[i];
-
-		for (bis_idx = 0; bis_idx < MAX_BIS_BITMASK_IDX; bis_idx++) {
-			if (data->pending_bis_sync & (1 << bis_idx)) {
-				data->bis_sync |= (1 << bis_idx);
-				data->pending_bis_sync &= ~(1 << bis_idx);
-				break;
-			}
-		}
-
-		if (bis_idx < MAX_BIS_BITMASK_IDX)
-			break;
-	}
-
-	for (i = 0; i < bcast_src->num_subgroups; i++) {
-		if (bcast_src->subgroup_data[i].pending_bis_sync)
-			break;
-	}
-
-	/* If there are still pending bises, wait for their
-	 * notifications also before sending notification to
-	 * client
-	 */
-	if (i != bcast_src->num_subgroups)
-		return;
-
-	/* All connections have been notified */
-	if (check_io_err(io)) {
-		DBG(bcast_src->bass, "BIG sync failed");
-
-		/* Close all connected bises */
-		queue_destroy(bcast_src->bises, bass_bis_unref);
-		bcast_src->bises = NULL;
-
-		/* Close listen io */
-		g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
-		g_io_channel_unref(bcast_src->listen_io);
-		bcast_src->listen_io = NULL;
-
-		/* Close pa sync io */
-		if (bcast_src->pa_sync_io) {
-			g_io_channel_shutdown(bcast_src->pa_sync_io,
-					TRUE, NULL);
-			g_io_channel_unref(bcast_src->pa_sync_io);
-			bcast_src->pa_sync_io = NULL;
-		}
-
-		for (i = 0; i < bcast_src->num_subgroups; i++)
-			bcast_src->subgroup_data[i].bis_sync =
-				BT_BASS_BIG_SYNC_FAILED_BITMASK;
-
-		/* If BIG sync failed because of an incorrect broadcast code,
-		 * inform client
-		 */
-		if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
-			bcast_src->enc = BT_BASS_BIG_ENC_STATE_BAD_CODE;
-	} else {
-		if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
-			bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
-	}
-
-	/* Send notification to client */
-	notif = bass_parse_bcast_src(bcast_src);
-	if (!notif)
-		return;
-
-	gatt_db_attribute_notify(bcast_src->attr,
-					notif->iov_base, notif->iov_len,
-					bt_bass_get_att(bcast_src->bass));
-
-	free(notif->iov_base);
-	free(notif);
-}
-
 static bool bass_trigger_big_sync(struct bt_bcast_src *bcast_src)
 {
 	for (int i = 0; i < bcast_src->num_subgroups; i++) {
@@ -769,73 +622,6 @@ static bool bass_trigger_big_sync(struct bt_bcast_src *bcast_src)
 	return false;
 }
 
-
-static void confirm_cb(GIOChannel *io, gpointer user_data)
-{
-	struct bt_bcast_src *bcast_src = user_data;
-	int sk, err;
-	socklen_t len;
-	struct bt_iso_qos qos;
-	struct iovec *notif;
-	GError *gerr = NULL;
-
-	if (check_io_err(io)) {
-		DBG(bcast_src->bass, "PA sync failed");
-
-		/* Mark PA sync as failed and notify client */
-		bcast_src->sync_state = BT_BASS_FAILED_TO_SYNCHRONIZE_TO_PA;
-		goto notify;
-	}
-
-	bcast_src->sync_state = BT_BASS_SYNCHRONIZED_TO_PA;
-	bcast_src->pa_sync_io = io;
-	g_io_channel_ref(bcast_src->pa_sync_io);
-
-	len = sizeof(qos);
-	memset(&qos, 0, len);
-
-	sk = g_io_channel_unix_get_fd(io);
-
-	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
-	if (err < 0) {
-		DBG(bcast_src->bass, "Failed to get iso qos");
-		return;
-	}
-
-	if (!qos.bcast.encryption) {
-		/* BIG is not encrypted. Try to synchronize */
-		bcast_src->enc = BT_BASS_BIG_ENC_STATE_NO_ENC;
-
-		if (bass_trigger_big_sync(bcast_src)) {
-			if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
-				connect_cb, bcast_src, NULL, &gerr,
-				BT_IO_OPT_INVALID)) {
-				DBG(bcast_src->bass, "bt_io_bcast_accept: %s",
-				gerr->message);
-				g_error_free(gerr);
-			}
-			return;
-		}
-
-		goto notify;
-	}
-
-	/* BIG is encrypted. Wait for Client to provide the Broadcast_Code */
-	bcast_src->enc = BT_BASS_BIG_ENC_STATE_BCODE_REQ;
-
-notify:
-	notif = bass_parse_bcast_src(bcast_src);
-	if (!notif)
-		return;
-
-	gatt_db_attribute_notify(bcast_src->attr,
-					notif->iov_base, notif->iov_len,
-					bt_bass_get_att(bcast_src->bass));
-
-	free(notif->iov_base);
-	free(notif);
-}
-
 static struct bt_bass *bass_get_session(struct bt_att *att, struct gatt_db *db,
 		const bdaddr_t *adapter_bdaddr)
 {
@@ -922,13 +708,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	uint8_t src_id = 0;
 	struct gatt_db_attribute *attr;
 	uint8_t pa_sync;
-	GIOChannel *io;
-	GError *err = NULL;
-	struct bt_iso_qos iso_qos = default_qos;
-	uint8_t num_bis = 0;
-	uint8_t bis[ISO_MAX_NUM_BIS];
 	struct iovec *notif;
-	uint8_t addr_type;
 
 	gatt_db_attribute_write_result(attrib, id, 0x00);
 
@@ -945,8 +725,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
 	queue_push_tail(bass->ldb->bcast_srcs, bcast_src);
 
-	memset(bis, 0, ISO_MAX_NUM_BIS);
-
 	bcast_src->bass = bass;
 
 	/* Map the source to a Broadcast Receive State characteristic */
@@ -1028,18 +806,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
 		util_iov_pull_le32(iov, &data->pending_bis_sync);
 
-		if (data->pending_bis_sync != BIS_SYNC_NO_PREF)
-			/* Iterate through the bis sync bitmask written
-			 * by the client and store the bis indexes that
-			 * the BASS server will try to synchronize to
-			 */
-			for (int bis_idx = 0; bis_idx < 31; bis_idx++) {
-				if (data->pending_bis_sync & (1 << bis_idx)) {
-					bis[num_bis] = bis_idx + 1;
-					num_bis++;
-				}
-			}
-
 		data->meta_len = *(uint8_t *)util_iov_pull_mem(iov,
 						sizeof(data->meta_len));
 		if (!data->meta_len)
@@ -1054,38 +820,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	}
 
 	if (pa_sync != PA_SYNC_NO_SYNC) {
-		/* Convert to three-value type */
-		if (bcast_src->addr_type)
-			addr_type = BDADDR_LE_RANDOM;
-		else
-			addr_type = BDADDR_LE_PUBLIC;
-
-		/* If requested by client, try to synchronize to the source */
-		io = bt_io_listen(NULL, confirm_cb, bcast_src, NULL, &err,
-					BT_IO_OPT_SOURCE_BDADDR,
-					&bass->ldb->adapter_bdaddr,
-					BT_IO_OPT_DEST_BDADDR,
-					&bcast_src->addr,
-					BT_IO_OPT_DEST_TYPE,
-					addr_type,
-					BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-					BT_IO_OPT_QOS, &iso_qos,
-					BT_IO_OPT_ISO_BC_SID, bcast_src->sid,
-					BT_IO_OPT_ISO_BC_NUM_BIS, num_bis,
-					BT_IO_OPT_ISO_BC_BIS, bis,
-					BT_IO_OPT_INVALID);
-
-		if (!io) {
-			DBG(bass, "%s", err->message);
-			g_error_free(err);
-			goto err;
-		}
-
-		bcast_src->listen_io = io;
-		g_io_channel_ref(bcast_src->listen_io);
-
-		if (num_bis > 0 && !bcast_src->bises)
-			bcast_src->bises = queue_new();
+		/* TODO: call BASS plugin callback to establish PA/BIG sync */
 	} else {
 		for (int i = 0; i < bcast_src->num_subgroups; i++)
 			bcast_src->subgroup_data[i].bis_sync =
@@ -1125,10 +860,6 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 {
 	struct bt_bass_set_bcast_code_params *params;
 	struct bt_bcast_src *bcast_src;
-	int sk, err;
-	socklen_t len;
-	struct bt_iso_qos qos;
-	GError *gerr = NULL;
 	struct iovec *notif;
 
 	/* Get Set Broadcast Code command parameters */
@@ -1164,37 +895,7 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 		return;
 	}
 
-	/* Try to sync to the source using the
-	 * received broadcast code
-	 */
-	len = sizeof(qos);
-	memset(&qos, 0, len);
-
-	if (!bcast_src->pa_sync_io)
-		return;
-
-	sk = g_io_channel_unix_get_fd(bcast_src->pa_sync_io);
-
-	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
-	if (err < 0) {
-		DBG(bcast_src->bass, "Failed to get iso qos");
-		return;
-	}
-
-	/* Update socket QoS with Broadcast Code */
-	memcpy(qos.bcast.bcode, params->bcast_code, BT_BASS_BCAST_CODE_SIZE);
-
-	if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos,
-				sizeof(qos)) < 0) {
-		DBG(bcast_src->bass, "Failed to set iso qos");
-		return;
-	}
-
-	if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
-		bcast_src, NULL, &gerr,  BT_IO_OPT_INVALID)) {
-		DBG(bcast_src->bass, "bt_io_bcast_accept: %s", gerr->message);
-		g_error_free(gerr);
-	}
+	/* TODO: Call BASS plugin callback to sync with required BIS */
 }
 
 #define BASS_OP(_str, _op, _size, _func) \
@@ -1378,18 +1079,6 @@ static void bass_bcast_src_free(void *data)
 
 	free(bcast_src->subgroup_data);
 
-	if (bcast_src->listen_io) {
-		g_io_channel_shutdown(bcast_src->listen_io, TRUE, NULL);
-		g_io_channel_unref(bcast_src->listen_io);
-	}
-
-	if (bcast_src->pa_sync_io) {
-		g_io_channel_shutdown(bcast_src->pa_sync_io, TRUE, NULL);
-		g_io_channel_unref(bcast_src->pa_sync_io);
-	}
-
-	queue_destroy(bcast_src->bises, bass_bis_unref);
-
 	free(bcast_src);
 }
 
-- 
2.39.2

