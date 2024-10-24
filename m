Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620261CACFC
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767788; cv=fail; b=S8b/y76krvqAOmWd98rcU8PsR0n7X9jQbdtOpiZza6fx3d0GBXtCQ4gAHgpWbAeCaiP6vY4N4TvPVjlU7VadfY5Xx+O45VtoUG6/m5uYNJVH0aiZOsUQ46cjGyQY+eSppECyKjlq8eix6iblNRIU1vh3GC76rZ8FKlhzJKFRZJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767788; c=relaxed/simple;
	bh=+MALGdDd7EySkRkU5XLFMHWfRYgSmE2/7sC9p1j1X1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G2uERykNGGvCiPFBSOTIQ3FPuPQLE/uKIAD1IV769aCf3v4rShiosVaKKhf8WrO5ePCvXxJ/3gjDZj2m+J6onphiwt8fQFWfFnCgZqGDbDmR9NYdN0j06VmVmIgBpJrj0+MxkvD16IxoDUy69l6P/6fl8WQiz3x9LF5zlnbb0XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KtmsMg7r; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KtmsMg7r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWgRrXncj3UTkMdCzoL+MChTM/45stcr7KNH0MA9oGRIU/K00eglX1ZrouznLEkAIx09U438dMVHJ4w26iUDMDSlOSOK8XZZ1f0hRxWEXowhyd9QCtUrza9/wtav9xlR/fUgZiRKvO13WWEFEs4IAnIjeatRsETotRleH59wb4aQxl+0Hob5CG8XBnDGdb/YLJigXRZqAXdYo26nBJvnauO6he1BftBd2pNjg0tq7ZiFG+qDptGNabpjndIUWI0Cy2/qYA4kvvZ5webU8ZIydzzHzh7BRnMS0MnDOObx4PmKfr9O1bkqw20ns4wSeUtjSBE5/hdGDChnHGejPlxV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mLuqgmV0vm8IfMVhrCCQYByBGTtkc+fDKzKuAxBh+U=;
 b=rKlLuwpZ44lURFBKvxF2cJ2CnNxXF6fBxJqXzX64q1VT4F52TA5RrqSmBRObvofG/sHqgRGiFVOTTlncM9gKzjxAHqO40FovSuLDfsvVPaYjJLFwY4wAun5har4BRfIqOc8jhupV1C3LlT0APSZAa4W9vji52t7goPIOzHKYnuhqTGERlgNgW5CzEayqtXn0OiYc+p/fW2POskWYAbiWoIOJLNDe8XXZo5VPq3s75K6BBwqLEGi6Y2s5TYSIZlgsNdGrPsyQeIacdn/ddhQelv1N8rRUGwcfcrPAbB7EyNauj3Ple76mU8PZOIPori37y0I6cp60sIx0bqGs3w2mfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mLuqgmV0vm8IfMVhrCCQYByBGTtkc+fDKzKuAxBh+U=;
 b=KtmsMg7rWbjo+wSgZs5bqITefr9pl03RU8EGvoBnOGI8gt/lF+KN65s7jxOOMT1gq2ALK2yMEciF7GDFnZ9dustWHMQtNP7j3v3VQYbvHY0DQaysb7TJkd8DFSAgVF6nx05yWlY54SCwQjqD+y2TgXoWrRwjU3kTsqJqVKaLYmcuOj0wa45G2ufWALHTO+IB23l7dP+uAPESOdh8unH173KtrTTfQtIoVD9tONgZ19nXi3CacoV2Qk89vzsnxWEiLMue7KjpzE88fHE43fbmhUot97/752n+2kuPZ2sK9V5Vk3c/s8mdJvrAscGS8jc1pTJUa7FbBQupapqEnifsWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 11:02:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:02:58 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 04/14] shared/bap: Use enabling state for bcast sink streams
Date: Thu, 24 Oct 2024 14:02:13 +0300
Message-ID: <20241024110223.77254-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: d10c21ff-2a43-4bc1-4d11-08dcf41b6b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djSlNzCP39Xk2pvcxujEig6CDrRyek+zxZ2oRQr7iHFbhBUL4LC5s2IlubIL?=
 =?us-ascii?Q?3/CVEMGLAHVIjkU1wIBlTKJOoLNtihNO9bAg1yjqI1K8tVi0FuXl1GTVKwpu?=
 =?us-ascii?Q?H+8SFuzZUWIqKMBJjSyaa3qblP5UXBBJ16Objj//gNwnHdqpuq2Ew+1vybbK?=
 =?us-ascii?Q?7fDE91Peaqsp7/XstPgTjigd/rmWZyeirf79A1xyOCKVKJioVTH9F3Z1Qxxr?=
 =?us-ascii?Q?XPjS3kwYofmGF8Y5FVipnDvqnceedaUd7NOlG7TPXKbaa6/3gQONLcO602kI?=
 =?us-ascii?Q?UJgd0aGyDp7Gp7dTFZiGegRwj7EL9iLvjlJZdWyuSsGSvBvpoqlh/gRJIEK1?=
 =?us-ascii?Q?N/etsJFadmZfa/C4UhsttirNUob4b8gao61iSnVPLh5MKakwPDK7t1OToeL3?=
 =?us-ascii?Q?VNTSx88kwjBzQByA8qePHcmvrkSkBOVy3rYESkdw7DqbDTWWU+iMWtIgMhXI?=
 =?us-ascii?Q?ONemf77zWfz2MyPKjNpni5OykPazMvl4u6dmVHhgaD8d+NitKu/jJco7U6xj?=
 =?us-ascii?Q?J1GpLVTEiEX5CaLMkHwAYAZ78NjklIjT1J+7nT5WTjcsIqXM21Kyp9vnSwnR?=
 =?us-ascii?Q?vDnPe6glwxH9t1z6GIr+Ose0P9xDyI9T2v8OAqHy/aqAZ+nzQ35CKCg0dZ9n?=
 =?us-ascii?Q?qp4mIcJWMrwWXmwNwiYsP9e3kYZXG+meQwKvAYxfeMsYV4gUv8oNG0tami/f?=
 =?us-ascii?Q?kwlWqvVE+KJmRzWVpvXslnjnS7zxIyxnfDZAwUj5VtnujmcM1vvx6ouE7UEu?=
 =?us-ascii?Q?kservPpYIq3fb1d6I0AXtUvnMWI/6AhHCL7Fhoe469BjwjrNPms3mdplsHic?=
 =?us-ascii?Q?dEzcIeJfc7qgrtpWiL95hEhhLwqvKhOKHirr9za64x6wUk912ZZ6u1AWA5YC?=
 =?us-ascii?Q?1syqarsURBpvR19/QyFZZqXOV/mI/2P2ycZc3UxVyb5hLfbF/3p70E7rD19E?=
 =?us-ascii?Q?e1iW29VKsUiS/A/SglKPl2nejd1r39m5+g0pTFfxpGv3ZczwD9WirvQSBGxv?=
 =?us-ascii?Q?rP2xTgmdD2V52DM6XiVn/AMzBlsudedr7m8RoMVM+hsoTv2cHAODHmZdL0i9?=
 =?us-ascii?Q?Y26pFHHzb5UTDwiJbH7p1lFqFCltHd3NxBUf2gm1WJmWpoDuE6VFgEL84zsp?=
 =?us-ascii?Q?FBef2wML/kioBuwKkQ6SDfjse3N6w+JpHwv12CIgd2Osb2IV0nesdVRVxW8s?=
 =?us-ascii?Q?CHj5/2b3p23pazAUOEuB8CEXk1ugi982uiHJQprvIeGD/RR28v+L3+vEJYnX?=
 =?us-ascii?Q?QHBzDTLTAbX6gnWJtHjRhfx23LrsC2MEEuhrCxnCM2xFxrNwGBrUzCLRCAiO?=
 =?us-ascii?Q?STvSdD9mjsaCw18cYOOu0LcFBFXMdVBkFy/GQbzyq0vJ+aKdFrx+jd9IvpL5?=
 =?us-ascii?Q?nD7mUVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yjY8O3veqqRLJiw0Ai4IxibPvXaq/vJ1o6SXtlJKSjlrENUdAeX4rSlIlm2w?=
 =?us-ascii?Q?/O/x1M1KYgUDhYRE40kmETZ578pobcSJoo6H+AURtQyAvo42Eajmiq3nTb0y?=
 =?us-ascii?Q?kVfxqktFPFugPwAu3QGH/BrN1NJ3x3PnG1xHBpuI8entbda8m/6oMH/6oOPa?=
 =?us-ascii?Q?3qJ8JzMSsNfJPdk8vgaFxB6No0qcYbT+z/731tJ94BSucLiQ1VsPT/zBWMUD?=
 =?us-ascii?Q?V4RuOIyxSLywmf3vQJyNKliTUqKylkIv+VMYBFJRVUbxmHQneiLskNmq7ajZ?=
 =?us-ascii?Q?zoDsOo084+2jWCKtxX2qzUlUHrDwVMi3EFQx9Zb1rrxd/K+SWQfE7IrTdlFf?=
 =?us-ascii?Q?hviKVYTU8SpyNkOH22TeYdjK08fTESTcG72nYCi92vcB5YPYJM2yFW/iro4o?=
 =?us-ascii?Q?YgS70RFMuAU4HQA8SWb5cf0H6OI7Irq0ekILuzSjW6rMmPoRH6/CIy7E7v0v?=
 =?us-ascii?Q?kbaZLJE3dMH/O+BTIqEYYE+7dYki/NatkPMxNHS17NjpADxun6wEeR5diNPg?=
 =?us-ascii?Q?A7hepv5eKKm0I0qUvMV+Rt47vEv1HAFKVc8kdDmoTvPsMHM0O+uY3KkzmecS?=
 =?us-ascii?Q?vcHMO0L4+PSuPN+J+q0orXD5erfjhbBsr7DX30xi+h4UMrldYybFzP86JW2Y?=
 =?us-ascii?Q?8h16lKaw+5E267cfg4czEzK6X9cyixWPU3fng8OXay+OOo6APTtpkjjqjeV0?=
 =?us-ascii?Q?0xDW3PlIhisnR3hOxaR09MV/vyWSqfAD7u1/hRvYWsUKTZOLA3DMRmDtL08y?=
 =?us-ascii?Q?IgsaB574NmMDTGmSTqp3qVMXLN3yRYJxCNI0upSVByU+HNPUUdtFdyHSgjTn?=
 =?us-ascii?Q?k57hk9j+MjstGYdHjUhCasr8SWFbjpNISqehk9s7WJ4zryWH/WLnJzvO1pAP?=
 =?us-ascii?Q?sLDu6nTpWk7kwqfgJKSqcrWySZgQp4acRb9qGdewbrwQQcWT4Yj7qImcDt/4?=
 =?us-ascii?Q?RcLMNOEK+3Db4KPxl4exHfNB3StU8DauGUMrXYMSj5z2D7RkLnS9EJgbBW8D?=
 =?us-ascii?Q?xbUhTyxJAOi/wJUI18zJvWh10A4dMtQJqbowiqE/4v3kN9sGbf8Uz0wfstTX?=
 =?us-ascii?Q?tRGvMm7azZD5ge1jdQH7n3LxtqtV1VaMOKuyJuPzgmg577OoRPSin/nb5SUx?=
 =?us-ascii?Q?K+Zf++HY17xxijHCS60KLFuNk13TKQYqwwIhM8bFgQLjPfKlVXWI+RSt78CC?=
 =?us-ascii?Q?7ACbgYnvq16tgE+Cj/JoUFXze+QuvJfll4V8Qg8BL2oNu1+h0AdHNqA9OF5z?=
 =?us-ascii?Q?Bi0XSJDsFX32vAOvXveUzkrVKRyCKcdtfHYciCwaB40RGhUHsPqlZL+jnPqK?=
 =?us-ascii?Q?FDIY66euLDhKNy2kjhxym6Ff4OOvEhVuYGOu5pxc5fY6iFK1zClI365rz0Ep?=
 =?us-ascii?Q?NRShn9Z9QwvYCmr4IoYplRMbhBFbRvMV0lZmiBanMDRAFIf+vbmqlMhdOgmY?=
 =?us-ascii?Q?cioL/mYuv2FO2EwXWs/+AEn7hogqt1kE4bf65MnF33208lVQicx+DDDLRIqN?=
 =?us-ascii?Q?A/X/5s8JeNV0mI94l8IC21Iy4yj0GHr/UxBw6fV25l3iOjhGEud+Z8mEre01?=
 =?us-ascii?Q?iFaCrWSclciFBIxtzNWYRK3Bawkd2p75n9IoaZvrl9hgPVtXuLwnk+SA8JpX?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d10c21ff-2a43-4bc1-4d11-08dcf41b6b9e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:02:58.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF53mcJsXrxtwsVPtpMG/mbiUc+GUTHuQPblRK/V9i9OwltYMhMz4OIO0lD4Fu/A8EAIzJ2u7Doi3B8zM61LQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622

This updates the stream state transition from CONFIG to ENABLING,
on enable for Broadcast Sink streams. This is done to differentiate
between streams discovered in the BASE after short-lived PA sync
and streams that have been selected and enabled by the user.
---
 profiles/audio/bap.c | 7 +++----
 src/shared/bap.c     | 2 +-
 unit/test-bap.c      | 7 ++++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c45717ef2..4d250db52 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1020,7 +1020,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	free(req);
 
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
-		bt_bap_stream_start(setup->stream, NULL, NULL);
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
@@ -2676,13 +2675,13 @@ static void bap_state_bcast_sink(struct bt_bap_stream *stream,
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (!setup)
 			break;
-		if (old_state ==
-				BT_BAP_STREAM_STATE_CONFIG)
-			setup_create_io(data, setup, stream, defer);
 		if (old_state ==
 				BT_BAP_STREAM_STATE_STREAMING)
 			setup_io_close(setup, NULL);
 		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		setup_create_io(data, setup, stream, defer);
+		break;
 	}
 }
 
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 46ed490d1..6a2e12577 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2186,7 +2186,7 @@ static unsigned int bap_bcast_sink_enable(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
 {
-	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_ENABLING);
 
 	return 1;
 }
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 9cfc8c403..0c190d7fe 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6419,14 +6419,15 @@ static void bsnk_state_str(struct bt_bap_stream *stream, uint8_t old_state,
 
 			/* Enable stream */
 			bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
-		} else if (old_state == BT_BAP_STREAM_STATE_CONFIG) {
-			/* Start stream */
-			bt_bap_stream_start(stream, NULL, NULL);
 		} else {
 			/* Other state transitions are invalid */
 			tester_test_failed();
 		}
 
+		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		/* Start stream */
+		bt_bap_stream_start(stream, NULL, NULL);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
 		queue_foreach(data->streams, stream_count_streaming, &num);
-- 
2.43.0

