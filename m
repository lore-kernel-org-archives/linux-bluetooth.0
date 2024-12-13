Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF91DEFC1
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089499; cv=fail; b=rdvCw1Hz1VzRWZFEBMKUjY91+R6DSGXwCXJ/TGLiWRpsmvM4aRNNmfEacr0+juTzc7EjiZI5JxgJ2v+irUp3CCrQjxFe3lWmP3O4CySZNf94wsyisaqGZAyjx3AlMzrkVEobvxQ+1TXGEUO+Wu9ASAIHJ5Qo2vaEyIXLJWF0dSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089499; c=relaxed/simple;
	bh=B8xtEJuvXllCuJyhBWdk0duWErjov//tsLAvAlLV+DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBrdr3i2W2mP/br06PYDq9PKdyDdUaoscVewgfvHZETWU++9VQf2qOspOmJMjEzUoTlm3Pd9mfvS5b+Mfmct8R1sBq4JoW/HAIUhXTdDEd1hiSVYUx7vy0rdl3IHZMuZ1b5uqzVTr7VCi154EFSS73QJ8MEcrXRG8jNuN37cf38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IMnkS/q2; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IMnkS/q2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYOJfumCVBwRFFh23BVObYeQxiHCfHMJ1JuFMWV/YwNt5PhAY1kkQPT26+GFxdSENMVkf7nXatWaggxcMAanUJVF42epu2LIfAjDxoHvb2L7yieQkFIrnOJiYbt7KjIZEjY5dqSNcAqVos90dGCRIloh9njyT4eUkmB2QsSBVyNcaA+Ih/HZEL+zjSnzwKE+fKoeISFewDYnvUCN3kT+rvwcER1z4qGm57/wz3HW3Sm22qgQsFFWN/WxGTR863gksqm0wxobTMVjlbAeCPZf/QBMw83Z0UQ1XfNH44WM2fzK3DhuNjRWCBTpGG+Vd0mY38K7pFEfyFFf2X264DOYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od9L0ItbXvfnvgky7X6teuli+/6CYtZ1CVZlvMm0R+A=;
 b=q55kIj03Rmvq/EHVbc8yS2f2+TQrfvPPVVbgh+4Nm2+99QR3SRk8WaNdyeYyEnUYtsBT5znzEtc6MEE1lU9Yz5WeGNDr1GTtcxS+AkLPP8dEANjk1PrcTOEMFWApF3DaQjf68vI6gYOvuJcpJUsBOfygg2NJ2DASGO6yUVUwyX+SGCg9SyyK7X35jJJzuHTJfPEQo228UPo9r1gdcXpeUtxc4BhyV8/F1+M/N6NNUFF59debFvMwCH8Ys45xPYS2v1Rr8W+5i/7iWUDBiaD2H3wc4Tq+OP3KaEDHTIFE7xxA5C2OYeKn+PYkEHtS7k35PEHqYtcS11xYLlprAQebiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od9L0ItbXvfnvgky7X6teuli+/6CYtZ1CVZlvMm0R+A=;
 b=IMnkS/q25EONG3nWq0jdjh6AtmQaNCP5R+l/AhB3uwkLHrkxsAZd5sEcbVM9ANW/dGWlqnqGSOR9Xhyjq+hQ7xPNDQs0WFK76kGjYbbLeYMZC8jidvpouMoctPIchmoNrEm7N0tB9TxAJfawpsp+8ZZieHs3aET5n6FPsEHSMX6oM37ZbtvmSIoo6LBG43Bs46suzJEyI5wHMO786GR7kJiFBrmBRsqxRlMHxdgUeK8cEhRoTBENA1UHJNPGKOd+i62UVtzy/R6nefkKKutMsULt0vUINs9/V65htYxsVj5po34Nf6REiIUySsjLeasgpRUgxSrc5Vbjc7UAyUnoUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10438.eurprd04.prod.outlook.com (2603:10a6:800:21b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 11:31:35 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 11:31:35 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] bap: Do not allow BIS QoS mismatch
Date: Fri, 13 Dec 2024 13:31:13 +0200
Message-ID: <20241213113113.64818-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
References: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0034.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::47) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10438:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cbab8ba-281a-4600-73b5-08dd1b69b356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3IFKh5OnwzAKeQR/mqqkoaHrgt1ibrT/wQH3MoWnfZ1Ny0w+03r9daeGcWf?=
 =?us-ascii?Q?rMwtcWa8fs9NXtDB0ccVp9Q+N5ugKwcr70h1MzL1GQlmpgz+GCobU/2MaRWA?=
 =?us-ascii?Q?heEKRXiRXozQhWttBwUCKeYRfeetKFk9eUzl51mHIZk9m1N+WEal6UAZxR/M?=
 =?us-ascii?Q?s4mNK4bw2JYemVlGw9oBBDyxqQ1l2+0K+S2cPp8t948v4jPBCEB/7pcfyfi9?=
 =?us-ascii?Q?uQz6lrffk4/nxAiDcJVpIOcGVPtmdQVvsW+uQsnHi/WyA1wv0dJH6EaUUe8X?=
 =?us-ascii?Q?kF/lSnbPnjx3Mpd7cmGuKI0OLf048iiyE8UDynIK3Xvj/izBCiYwLDj2OMi9?=
 =?us-ascii?Q?NiK6rhMLNSieNobTLkMKctCBkOz7uxPMxJyDM0vhWXtkeR33IaNQeod1+PD7?=
 =?us-ascii?Q?XDDzTdh+1snjC6ebnSHjhZPPXqv+vzC7QlixpzypT/PKvJHnkTW2ktHaQOUS?=
 =?us-ascii?Q?+bc2qHUyjLezDYZQXYb5Wj3U2hgekSi0k7R6OHFwyENevWb7/eZuG/6cNtIK?=
 =?us-ascii?Q?6/V98kpJgf32dLggr5lb81M/VFud9dYw6CEv5HMGTMFYjtKXGp5o3gY4q+ht?=
 =?us-ascii?Q?/kt5taJxTdfR4EcbHmBPjLEEgUUqU/xY5SRLIOdqyI9z8XrBmTCtCZlntOLy?=
 =?us-ascii?Q?CEnsHeER814/TVAC6BVROYklZdzL0TDJLAelGcLjUHEoN6TF3cF1An56v+X7?=
 =?us-ascii?Q?ycLI5283mfX7+AOQmGNG2wj78lDP4CoRHRS+1M/PF/Pa+u3WcCQVPqFQ6lfD?=
 =?us-ascii?Q?Z6MJlXK6s+IIueQ0ribLbZ59R5HA0zQcDRytBXa9jV7WHd1NFIkLRBMknZ29?=
 =?us-ascii?Q?DwKNwtZFGRfgCT+gIFYIjoyD8nQW5XPSYBeLwDKJOG3uSc7mF/8OeUyUyir5?=
 =?us-ascii?Q?dIRut8K1yyltcP0IBuZH4n8lE80V1M/cNTZU9XHLSw7Hz8PHBretAhCYuDn8?=
 =?us-ascii?Q?Mqi+9440M7mZ76d/opWmSAUG+tw+QIN9MiDGhmcGpUXeWqx2Xn6iev0vjX3Q?=
 =?us-ascii?Q?Ku+4/8JrIzmuYgvTNQVHKsbIMVBkmKxGehfmu4IsSDZuW9/rX1eRrtdcG6LM?=
 =?us-ascii?Q?Wgbfn8VzEiEZN9VLYMClGkmjEO4J0unEm8w4aTeBau+mTtg//o98K5bAgbpM?=
 =?us-ascii?Q?Q0uDV9avoZj7Yaror6XeLBAheLUuRQ+v2cY4w9KPyrQ4FUvmUUVHwxaPnotH?=
 =?us-ascii?Q?EodcLK+keTh/j6ptlzQeT5vjfJjRv32gNqN9D/kXEKuPQq/tYo2k9Gvf0PB1?=
 =?us-ascii?Q?vBZZfnnEPx/DkVPyB4fwx23afqPCaQLHluoCpqnYkmFDF7R+7K+xVGx1I62x?=
 =?us-ascii?Q?aVkVjq81rhzf0NGnHWpp/s7avHtYrtMyug2olqJcAeJkKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mJsQJl7sR1Chm8EMGQFddUHRJpSwEul5qY0+6TSEMBjwfiNLeGoZeXSKiNGm?=
 =?us-ascii?Q?T/6XY9UwwS1zrcMAqW4/qyxwdDaO3eiq/Udlb7tJot5hmgoGO7dRYXDeJ/JT?=
 =?us-ascii?Q?8yoxmw4191kyMXJhBIKE5e8UHsb5kYD0vxu7w4douFDUFPSx7SVQcmoRRy78?=
 =?us-ascii?Q?pFY3e26JAYGZ4EJTuQv+Ubv+nWoTZAOENjKkpQLAgEcEakThNSX5YWU4yolO?=
 =?us-ascii?Q?8dH5wiFw2fs/pZe6CW/tOjAoMUScIs7WGC2EqaZEC6fFsvMUCmAhrwJFJVap?=
 =?us-ascii?Q?5nXIoeD3kvWjR0i7jLYbtO+NllH0MbUjzNtollR8TE7dVf0rKxsXQZT5DR3i?=
 =?us-ascii?Q?M2ujBomPqKX6IHSpCRNZ/0ACo81jy+LDbE5Y4pEnDy3GMmMYrk2uRMW2C/9p?=
 =?us-ascii?Q?I6iBbXxaX1mfC7wK/SDEUJM1HjN5tUF/xOcE8Rzysgn5oYeV2jsl7zDb0E98?=
 =?us-ascii?Q?BjLeHdYEpMT1fdBv8cjCVGVaTW9Lkf5DEtx3LziEAOU/YMiF5GuQR1rPO3Ft?=
 =?us-ascii?Q?Z/rx7AugjLbwXh3OMfb2x8Fsxedf0Ndm+MgTq+3Q3JmRvU4e7dVs4vydnD3b?=
 =?us-ascii?Q?RW6AD0SR0naVLLBXzOBefJVUvkbP9DsVSuBL4PG+ofodhw//jkfFlG50p5LN?=
 =?us-ascii?Q?2XCV9NJgExRsWK0dMCQb2NeQX2SKsvjhhFVEiEhQOQBbtbsSWVcvaZkiXCAU?=
 =?us-ascii?Q?G5+sGl7BzZk15vQ/vacxwnuvxOLGtV2zRePDp5ZVxH42IMREye0tdvdvd9dt?=
 =?us-ascii?Q?9/FLJAPKRuo0gbU6J70V8ILmutTMRBYcl23SxcZnWMsGKtQ0VEUdg53YUVaY?=
 =?us-ascii?Q?ny6rlcubVMP5wBE/TzQLROlJCLnIYHEdKoBsue/3713KQZZe+7aYjUL6BZcg?=
 =?us-ascii?Q?af2FU/mTve2GjhdM7hWotTRbckpClP+X21ISyqnF7XUgax1vd+JKirimKivX?=
 =?us-ascii?Q?WUJhm1QFC1o27uvaJOHYfo/FN4LiWaxxag489aUKedH6ZLRmKVn8sumfulE3?=
 =?us-ascii?Q?swSNY3TWzyJ+KDi/gT7MQ6HgErXwKaHFY616vNQA2QAc0XlK1ngI2h84zzqz?=
 =?us-ascii?Q?C1pjHlYZE0oI3oe/xBuAa6b1tWbCto/92V8RSjDLBBpkoIN0sq/QMlG3geZ4?=
 =?us-ascii?Q?AIBWIsXlrUhYJ6YZpr0O4E+LnoR37bgmWrHOPQYvHE5emx640Q/s+cyYDxJj?=
 =?us-ascii?Q?LsWI1OpGKTgY+Fc0PG2u+RXg08tAz8NvCDvk2kXn+yof/wjt+DopNKcJqQUC?=
 =?us-ascii?Q?tg5iR+gfBQBL8mkyKC1wE/4s8jAd0WFWlp/GKMP/cYeRC5xCSVXQCUbWGUaS?=
 =?us-ascii?Q?ubuc6IIxS58MeBhBymR4Gm72JYTx+wUkkTy575xenhPGzJ1twmTmbvMuwJzw?=
 =?us-ascii?Q?NDplhNNtwOmV4e+s+5jQgurCYAFs2uPO8u4kvdUHvQwjETA060s4ykOms9VZ?=
 =?us-ascii?Q?3bTyRvWwPB1UkLr0lz3+CoR8Dt+wgodNJOn5QJaSEuCR+p39zKBRO8erCgRH?=
 =?us-ascii?Q?Vg9UuXXDtgUzg34rH1nZqgIjl7OIRNeSjypyCobZBW0CEI64JNUX8FL8JNsq?=
 =?us-ascii?Q?qnWXvcCrpf4IdXAmloJbxfX2fnKYN/YCgLtI/LJ1ktivu+cwHDE96/UIAdaf?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cbab8ba-281a-4600-73b5-08dd1b69b356
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:31:35.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54f1FSUGLYZiyBN+dysSTIU+3GZ8o5AtCtlOV4Mpbxkp0hxjfMCl2DSCRXUOBo28ZC8xI05n063ldqCCVH+QCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10438

For Broadcast Source streams, QoS parameters are used for configuring
the PA and BIG. All parameters provided to the LE Create BIG command
are the same for all BISes (Core v5.3, vol.4, part E, page 2573).
Likewise, since the PA train is associated with the BIG, it is unique
for all included BISes. Thus, a stream should not be configured if the
QoS parameters do not match the global BIG configuration.

This commit adds a QoS check before a new stream is configured, to make
sure that all streams share the same settings.
---
 profiles/audio/bap.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index f382b43a5..77df9455a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -905,6 +905,83 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static bool match_io_qos(const struct bt_bap_io_qos *io_qos,
+		const struct bt_bap_io_qos *match)
+{
+	if (io_qos->interval != match->interval)
+		return false;
+
+	if (io_qos->latency != match->latency)
+		return false;
+
+	if (io_qos->sdu != match->sdu)
+		return false;
+
+	if (io_qos->phy != match->phy)
+		return false;
+
+	if (io_qos->rtn != match->rtn)
+		return false;
+
+	return true;
+}
+
+static bool match_bcast_qos(const struct bt_bap_bcast_qos *qos,
+		const struct bt_bap_bcast_qos *match)
+{
+	if (qos->sync_factor != match->sync_factor)
+		return false;
+
+	if (qos->packing != match->packing)
+		return false;
+
+	if (qos->framing != match->framing)
+		return false;
+
+	if (qos->encryption != match->encryption)
+		return false;
+
+	if (qos->encryption && util_iov_memcmp(qos->bcode, match->bcode))
+		return false;
+
+	if (qos->options != match->options)
+		return false;
+
+	if (qos->skip != match->skip)
+		return false;
+
+	if (qos->sync_timeout != match->sync_timeout)
+		return false;
+
+	if (qos->sync_cte_type != match->sync_cte_type)
+		return false;
+
+	if (qos->mse != match->mse)
+		return false;
+
+	if (qos->timeout != match->timeout)
+		return false;
+
+	if (qos->pa_sync != match->pa_sync)
+		return false;
+
+	return match_io_qos(&qos->io_qos, &match->io_qos);
+}
+
+static bool setup_mismatch_qos(const void *data, const void *user_data)
+{
+	const struct bap_setup *setup = data;
+	const struct bap_setup *match = user_data;
+
+	/* Match setups that are part of the same BIG */
+	if (setup == match ||
+		setup->qos.bcast.big == BT_ISO_QOS_BIG_UNSET ||
+		setup->qos.bcast.big != match->qos.bcast.big)
+		return false;
+
+	return !match_bcast_qos(&setup->qos.bcast, &match->qos.bcast);
+}
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -937,6 +1014,15 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
+		/* All streams in a BIG should have the same QoS.
+		 * Check that the new configuration matches previous ones.
+		 */
+		if (queue_find(setup->ep->setups, setup_mismatch_qos, setup)) {
+			setup_free(setup);
+			return btd_error_invalid_args(msg);
+		}
+
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
-- 
2.43.0

