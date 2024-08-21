Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594761B1D73
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252184; cv=fail; b=ERSKgNX98AhP4fRdDOctCJzRY/kzVBFc7urJSw0RZjn5Czha8va8C4ZmJkXpwFCVMW7U9Z7wqLSpzrG4REjG/i5J3ShMx/64w2fj1AZGC3OdIxfQrAF039gAesZsngrN5YAg4bc0clImPBveIeIUUhvk9WJRkIp2aCHLDdvG7sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252184; c=relaxed/simple;
	bh=GdrKSfE8RskHLwKIz7ufas77zD0wbF4L8HG1NyCYge0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUIMa+TYsNGXn6RUqLqmuvJ3VxOLcT3/mnn3RjZ/XLLlZbJgi1YyBO6rhv0fv708pZFbwJGB41rR/tYTI8++aNgFrbkeAyw1Fb6Yg87m7ojKZjt+lnwJcXmczCtIu4PmgTHs0ET+yLFcsYm0mMk+krHo7srwy4A0F0DZZlx/yZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bwSy0NHM; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bwSy0NHM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igOkxtwJ5dzatJJZk7q9edtO/qINYySf4cHn+DpGQ/GP9fYT5wlf3Bb0tyMFuVMY6BQfOHBRSxwS/URQy0eEiNj9sxDVKjf1oBq/YScn59KAgCrdlF7evwDawic47UOru4NxDCd+EURWWUije2USQfPAl7fLWciAIJCNsv60HPnPrZuM1/tORJjucL4uxSV7wALm40SPGy/tWZiuiOiKoCBLmcabuiNZNUzW8/2lT0OHcrGaPzAdROKqjeCfjlmlEehItCwdtgCvdsR/GoCh14KwjkJ3tr5WNibeuiT0qTkC/Z2YEUCFDhRTEsTPifur53TCqDw0YDS2ab5jeuK8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqh8ShlMLengkjYJyf7tiFYNNbMFabZryoJvRZVfXcM=;
 b=ZVh0lm6weFq+Kbfy4cRra0QoNvQfSDAbA70huHs07bFH5p9ZsiTzQqSqThPYb4ziFE4qCczVOW0As4wlxTMGuNPFzmtVos9rRH3craLx6/ECUg5PqazJteArBXpL7ZzV5LBKqnbDsfPw8/HcGOAhrgS2R1ICqFpGiQu/0ULnYnuJNdcfPgkjTb2nHhw2qyU86NxGQq6mDHP0/lGF46CJMn53BGv1LugssGH7NFBwp5JIFNf1NZ5oHUEbEUOiVZPV+0My12E9l62ksPWObkeA3syyiKIOQGaObB8i3Nm+/MkE3QfUHJb+E/NkHIHYPTj0pnRCXFEIEc5pVxEtOuEuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqh8ShlMLengkjYJyf7tiFYNNbMFabZryoJvRZVfXcM=;
 b=bwSy0NHMEkbLdCRf6Zk6Csq/ZbPZL11apX72rGQUZj0n3VzdD2XITtsgkUY8cDLZRs7umVKiAuWJFHKqdnj4oHi/9Rf42AXw6WMkt+F9dQ/Nwyp3mYce1QftEmfujHHWoXZ2pH9GdoHhQq9uPFlP3npQAcqtNncUq8CUg+fVDGe4eS4GppfTw+9us+Hw45QyO4n9Wb58WlXw7maI5bRhXJqiZ0lv82LwcUWMtA8p4Y+yOCs2kpXWdtoEKxlVP8fcE6YxtCvoEtGTGWD0N4dRHWBdiu4YEOtIWN+b12YAK+optBtqx2vWwelVScN6LPyTQgdW+AsaX+Pd14fGUpt5SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:19 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:19 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 03/14] shared/bass: Remove io handling
Date: Wed, 21 Aug 2024 17:55:51 +0300
Message-Id: <20240821145602.92083-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0021.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb09317-df06-4a8c-7f3c-08dcc1f16a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VLGA/kLIXcOYE+mnCij14Gp/KTcsQxzzFgAn/fyTLnTN28n0T/afenONsGB?=
 =?us-ascii?Q?Rzv+4wfaeUN5PlWCmAf784YklRSk2nOLQ44SIIMD6zizvgIW+INcVt7QBLDq?=
 =?us-ascii?Q?0dV0oe1nF7Kn2e+rpCbCGNrBcCwTkAFzOLt1mn/OjBverekrUTmjrqjsHAB2?=
 =?us-ascii?Q?GGD9/WpAUdOO41S89WEBxujZUHLHCoU3fmaC7jwuqhvSkTD1YP5RirQNcW/b?=
 =?us-ascii?Q?wqWIpey2xIv4Abawi8PkBTmPU8EFhBpUrXbEs77Q7cKSOGvIf76LFB4u+VSl?=
 =?us-ascii?Q?T1/UMwZmceyYcaJ/lgMhJbYeL5tcOkdvtabiQc1oa/l7IFsbGpS3B9UqHb70?=
 =?us-ascii?Q?JIlHGqOUNFns/23edEnCo4TPpz8evqxLVv6DplwgTBfn67CHUIiRsASEZD5w?=
 =?us-ascii?Q?xE5jmzkIkjWxun5V2N9mR1r6inOvT2Q7AYMAESiwIygLLpYuHhI5hZzaHG3Q?=
 =?us-ascii?Q?EoZV5yueWzFuUQkjke1z8/82FmQzijLJBylRtRs+ZagYODeI1LM9BcNdt0U4?=
 =?us-ascii?Q?hX6EXqhQX067KK26z0jlfIdY6cuna4+ECFydhAtTaogSTBb+fEW+0uwlB4E3?=
 =?us-ascii?Q?VffKvOWBi6rUE52ojcj3c/zdJ/WcqgxBRI8xI5wXMFSnt8QWeCP1Dmb7gKCu?=
 =?us-ascii?Q?IaPWL8SAacdaOXSdjybqlt43Kf8AK3fmUsWLVt2NHc62nd+LD/KikiQVQOOn?=
 =?us-ascii?Q?XdL01gG4SJmg04fj1caG1ip79axMlSfG6V/Kz0CnvaCwytzY+LauHHfO6Kf8?=
 =?us-ascii?Q?JM4K1Rid9TZNyys9II/IHvUpqDmf67jhgjJrdkwI4/Dfzf/diQjTUHEXmdWl?=
 =?us-ascii?Q?7kdDfHxc6P64M5ZFs193jU0g27Z5+uvb2wKB5TbkAwYHWX9dtFVkJQZMyaoG?=
 =?us-ascii?Q?yJgznjMSRgwl9Fm/EEfM+WvGfB+voJ1s4K3MSdV+3WNxHaC8KwN8LPFbW+ME?=
 =?us-ascii?Q?1x6neqXaMmCXA+Q+j6/OWs7jGUTTjK80bnMEJlZymOKtZKsZEJbEZC7Jcsay?=
 =?us-ascii?Q?QVV2C5NJec9CJcXi2NOVu17f3s3sA1tWnVXYNssJipk15bL00F5TG32bQlag?=
 =?us-ascii?Q?9HeLUXq7PyNAnIkOfGXZ+rOj2+1C8u1yxnEhnkxLoiGueugSt7IEq4Neo6sM?=
 =?us-ascii?Q?iJEtkU1FnJtkuyAPbmgENp2bEkDrhLnLKWe1YAB3y46Bqb6SYStDH1ejGdMC?=
 =?us-ascii?Q?C+JfYSnR75AfT2sJdubuSvIr2b/J8KaAT9XdGIoG8JqWtFk5AJnIQMBRMzOx?=
 =?us-ascii?Q?bH9ufeK6G17n8m64QstDhaquiNA2qSOsFXzkl8tpk/Yn0/0ffNKJxQLRSDix?=
 =?us-ascii?Q?m6hqnwDspIwyL6ESTL1IK5KzPvubbjayJMcvquWAcyT8tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mOtE4b/W1F6M3Juwqs/X82fehLRBNsMDJg4yh77ncBfIyGHgdmlBMxVCATjP?=
 =?us-ascii?Q?NHFShT7IDIy0UJAtwav1lQE96YfY/G73M0SAzn/llNj11yvWr2nnt7aEMOgZ?=
 =?us-ascii?Q?7Jmw+mxdVhdhFga/KNbT/tcOuSg3L/Q1IdZXQnHFAQuoeMY+jOrlyLvBMqlA?=
 =?us-ascii?Q?NS2iKz7VHcx/oDwC28Gn4+qSKsTUb5zuC9TDIY0qOlzhsy3Dp3T9hLxVVBPQ?=
 =?us-ascii?Q?23cq0jvfzYvWxnx9LYDXADZuOf6AUu36Ud1n/p1H2ad/O/4OKlpMZEIvZgEG?=
 =?us-ascii?Q?bSpHDU9R0oKTIunVul90R/7qmoNBuChyLBXdFBKdJabUplSwdxzts+JusN5Z?=
 =?us-ascii?Q?XStrM75yYdSw4uw6oJzCQdTtkJ9pL1to7ttAlIqe0Bdk+W0p35PDt81pAFox?=
 =?us-ascii?Q?sJxflzAEyhGn09JLRG+uPLV/RY9QIMwQ+U5mGh8/N9fhJ4JKicYq6ClkxsLA?=
 =?us-ascii?Q?WFQUicOWTuCq/YQ1FG2vjuZM40qRSUjCnYDHP9DBv9JhXlR1jFCwjqJuccLo?=
 =?us-ascii?Q?Cp+cZaYFMHLmh1l9tqlwQShRxpZt6gsAglc2SabbjkB0bUZJCSGsQa30f8ve?=
 =?us-ascii?Q?oZcnjh24gSutrvLOvT2di+ZDmWmZY8dm1RvNtuV/fJwqQ+itmqVWROEUcD/i?=
 =?us-ascii?Q?uVUm3DRxCldQu+1H0izqqP8yPRxR+FflmOrbLmqNtIONANAb51J1tYjy/T6H?=
 =?us-ascii?Q?1+eQTksBhn4+iruhqSCVAH3SaXsTxIXBmbK0RsqMsC6HCnWCbjY0EvQxaUln?=
 =?us-ascii?Q?AG6FD7TQfzoIRzrOaL4OMBPm3zuk+CRKYKv/FoEnmOn4bEcxSRg1guePOmp3?=
 =?us-ascii?Q?eq45VksoSoMaiZgqBsQ33h4QHXRKcpwBrnosMFfsgI2s/g4d/r9IlGjuRbpp?=
 =?us-ascii?Q?N5Ql/HubET/P9xLjcB7Y5g0XcyYQGPcHPKgE+MjwQZaTVo4m3ZjOiO92QUea?=
 =?us-ascii?Q?ZyEGR4B6KBlqOhw/wswkEBKgmrCn8HZHxGQ1VTF2o2PG9DojoOgNeE/2IVS9?=
 =?us-ascii?Q?Js8rO+8EdmWdqqmC+cbWkqO3x8YLOCxFzB5Ztl9+dbEi5aXyviAgVCZRR/b0?=
 =?us-ascii?Q?XcM6bSFMLCljSVQhhDpJsldsr34uW7vBZylrwqiXb4pq6DQ0k99c2lb6scPd?=
 =?us-ascii?Q?3hKtr+O7oGp//Rj6x9AoeyhSGlMalvt/Otj6+GQV99YBv0moN2EfDAWUfg5s?=
 =?us-ascii?Q?klQLB31TftFvk3QuLKRKOksVM+XingiqSpoKWzEtRVYISto7KvoZgEPNTHXc?=
 =?us-ascii?Q?zJh3+s/W7uppb2DXKyNCRH/Rt9D3pMzBn+aY/aqu/fk4e6mCzt3hG/+ENv+r?=
 =?us-ascii?Q?LusKpmNXNvbSL7t8ZumzxsdzCAIMFW8j1f+1N2bEUbcYYvUORVrUvl17z7QT?=
 =?us-ascii?Q?R7gZWCsy6vfOLXJmWT5ycdHs/Jt6UkotC8YICZcSqZzN0IfqYyPKnEdJWrvC?=
 =?us-ascii?Q?huyTDhqPXQPZhB1Uf7BWDtCUDWwyiIMplFe+mmfCnVkvOH+2my+OMpr2irFE?=
 =?us-ascii?Q?+vrAC7SQVszJDoZTBzvtWf6a+39J44DtRlxwD4VvJXlik8JqbF1tqiqKTEDU?=
 =?us-ascii?Q?7dclOFKLNqnDk8qqisE+zdZy2cng3hZ4PejLGKjfWNvydfBoguONkBTqJUi8?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb09317-df06-4a8c-7f3c-08dcc1f16a4d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:19.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lk2rpCJscXms5RlN+KfeWLK1VM7Szvfi4rOpVESzJihbcscMJXIP9vaX4EfXO27Iel/LgSDkDeC0EUeBQWJuHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

IO procedures should not be handled inside src/shared. The BASS plugin
should be the one to handle socket operations. This removes IO handling
from shared/bass.
---
 src/shared/bass.c | 312 +---------------------------------------------
 1 file changed, 2 insertions(+), 310 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index ce13f2c24..636eb24fd 100644
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
 
@@ -119,35 +113,6 @@ static struct queue *bass_db;
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
@@ -643,115 +608,6 @@ static bool bass_src_attr_match(const void *data, const void *match_data)
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
@@ -766,73 +622,6 @@ static bool bass_trigger_big_sync(struct bt_bcast_src *bcast_src)
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
@@ -919,13 +708,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
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
 
@@ -942,8 +725,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
 	queue_push_tail(bass->ldb->bcast_srcs, bcast_src);
 
-	memset(bis, 0, ISO_MAX_NUM_BIS);
-
 	bcast_src->bass = bass;
 
 	/* Map the source to a Broadcast Receive State characteristic */
@@ -1025,18 +806,6 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
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
@@ -1051,38 +820,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
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
@@ -1122,10 +860,6 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 {
 	struct bt_bass_set_bcast_code_params *params;
 	struct bt_bcast_src *bcast_src;
-	int sk, err;
-	socklen_t len;
-	struct bt_iso_qos qos;
-	GError *gerr = NULL;
 	struct iovec *notif;
 
 	/* Get Set Broadcast Code command parameters */
@@ -1161,37 +895,7 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
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
@@ -1375,18 +1079,6 @@ static void bass_bcast_src_free(void *data)
 
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

