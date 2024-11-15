Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2069.outbound.protection.outlook.com [40.107.103.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AC1B4F0A
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731667136; cv=fail; b=X3+la+ZT0M5+kYHCREZ0pzqDg5rA7Wp/K4ncpE1maQYTkkkVuBA72y6MrHwcOlb1A2mVAObHSPVcvqYrjc7/GZWVRnvqybS6pt86/ukLzgYXl78hlqwZMe62n1YSkTLK97pRRnrxWuahwlIbtgp1XNVQKtMyFp54xXtVLwxh8+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731667136; c=relaxed/simple;
	bh=8VRRDDqWJbHZdqKdE8wHxfNNEAtsVAla0U9wt1vAy/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fxM5Jzof1PMjO3F+b3ZeKOjuR/deN59mrlBtxKz8r3GnmTRSWbXPzsa2iSEBdrZeZS2srKJLt6/MwL15Cbg/5Vn8duGVflPX//NBJ+ubLblMy9KzgRmLhLqbQt+I+zh4wEufL59kadZYvl2yMgdxgVrCvM59AAkF8oaGI6s04NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DjiEqWnz; arc=fail smtp.client-ip=40.107.103.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DjiEqWnz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKekTL8f1vK66e2HAoO4v7e79YFkq5BU7DB2WRYiB3k4TpEDrbLX3VZV5SlObLY5v23OPXvNhYKtIeiXls269U9nnqmA1/0R71iGljMeLZHLA0xUDD4XI3vyYkyEXbP01J6gbxa5LbjbcGr/GVYBhT18AqQ9574w7DHbfgHXZpVTcWGeqSqEhrbL24DkMY9L9uYY9b9TOEIvUdtPOjQojSG9G+f6kvVoqCEJWwYNPpS7qUd5jHG5Z2XKzg1QN9VIn1ROgW2E7jHBWzJ1fRfqgkl0QNr97tFziLtzeycbXXA/l2kHEPwVSsUcUPN5s10HCDE0lcVb4+AzoLNeddSfjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufiPlQTYggn4c0tX4VUTv5Gs/X5GrATCzSRQjzKg3RA=;
 b=hKHh/xXCUzNe0GDGMPw2sM8pZFXjJU081mR2UaBZ3VMomeKG8YiDTKh9FwXYcZ1OwKFDWWFY0BzZA8B9gXGE5wu1rUbnYUtrsBY3kZXypZx2tT0NRNHUnMByUd4YXKoEFBsN+VP8bCtq1IKrf3duFfmYdVzkuXhaDhvKWh52PpCrPwnAkZcmzfTomYVUWr4BKyv1DCl0FbwiUr8KvzvMBz6mKdef6kUFQLsXDj7B5vOGo0c0VbOl+yH08bJo+5OJnvo8U8hQvlCxYy3/fW6zyr9J3FzQOxxkqaSJqLuPJkpOPJoAiDtqK0yPjAojBFRbXi7u4oktc6X9PbLhDOMdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufiPlQTYggn4c0tX4VUTv5Gs/X5GrATCzSRQjzKg3RA=;
 b=DjiEqWnzNM0ugV2U21K8BVX4pS3DzYkxjvWph3xPXg75c06JsZ1ewyIl+CRbl9PK8LxaDi10VrA50CPVIx90RW9javg9bejtoturk698t5dzEOVsWUGhpCB8NOcRYpcXu0BG+kxnGMKynXnPk0BF1QnBVJhav0oh7+6qDVgrUdOnulTnyeXNVWfa1UGvFsOD6JPG0faUEQnM8cCEaEmVKzGthhXh6odo8euL/+G2i0tuZ1e6oqL9IHgJW3EY5IVzvPJXxuiYFPKDBLegfUSu1FhX9j1Y80tQ723CNk6xsZKLw5jAhRNHEZcIcz+mha7zS0kV9vj797T2DNZIKFSB3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7714.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Fri, 15 Nov
 2024 10:38:51 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 10:38:47 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/6] bap: Remove API to probe device from BASS
Date: Fri, 15 Nov 2024 12:38:23 +0200
Message-ID: <20241115103825.19761-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
References: <20241115103825.19761-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0025.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 817bd181-6d31-40e2-4bd4-08dd0561aef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ofwe1jNVBX0UChbGdfCtqjMwCM17qMf0+lCkHK9KzSkHfgdxoBsu9nZO0qdi?=
 =?us-ascii?Q?uKL4jwOglTv9F5lU0alG2rQ+0M/V06T5D1pi4po+dVumowjVWMPJtxpjxiKn?=
 =?us-ascii?Q?Fmsh6+rAvo7jbiHDo24T4cdKIXxm6godcigDJ64mev7NQ5FoaRvcE5FBl/ZV?=
 =?us-ascii?Q?8k3IrjTeexgW13izbtRA+bXTEHgFS7j6FwjmXRPmJTtcHHwdBejraIFyjVLI?=
 =?us-ascii?Q?Ih/aqLkSaUZtZhI01rUOMz+iivvgPcDshDa1sTDyr9tkOsEJnbf2Ap+B6XZC?=
 =?us-ascii?Q?JMESjgRNwhWBbUYMws/an1LxPmOVrh2nWaK4N8yvef4OUC/lJRoZOobaF/h/?=
 =?us-ascii?Q?/MuyOwyTAvtSTsbdppU2RTaBFz3trIHPPKBpTNfTwYk+q7p9hfFwaSonhPkn?=
 =?us-ascii?Q?h13IgFfQCw2Ga7fA4eIjPVDgh+WePHmLq27luPTb3Arzml+4GY8LHotxQdVS?=
 =?us-ascii?Q?fWfyN+8pmXaU5W7jh68Pxua842lEtMwRcluc7xplXX/0OFp+pgDs6dcBfys3?=
 =?us-ascii?Q?iW5s9IATNRgPIhfzMUjaon/3uyJcgRfjTW7yMLsWlfnPy86GwK2wrPLDd6+V?=
 =?us-ascii?Q?zYrDxViqp1jSJS09hLNO+O8zIVvUPaEDXJNWTwCDNfSVdbuexWyJyDNbQ29c?=
 =?us-ascii?Q?8xzy1d93liKNLnf8zcg1FKxqmyhAJ+T3iXPJfeYHUULiOrKScJYRtXjLcVee?=
 =?us-ascii?Q?ulTysSrHvU6CDREL5/BJxQ70Ey/Io8LlbmjJGrL2NrerlcwzPzyaHOyWSjI9?=
 =?us-ascii?Q?/zWjDn30Y2kxinR+HHbLStRAHnzWy6FV5TTWHNLo7t2ruwXWoRSI+NA37aga?=
 =?us-ascii?Q?6BF1PXm3bvtWjEEPLuSo2mF2rFZMtnBhR1iEV8pkcn3Rj4eoOfis7xjQ85RZ?=
 =?us-ascii?Q?G2e20EeUL4jwORay4dVxd4z2oT8a3515oB3MRLSGYC4mvVc2tAmYxROM4HVq?=
 =?us-ascii?Q?IPYWW+PBqOVYrjkdpHqReosVMvedhS9vuD/4YpPk62dEneZakpErbuSmvPP6?=
 =?us-ascii?Q?3mKjgH36X3E8pgTDKR6koqZDtAIukP2ADivuwbV+Fwf7Ge0ojQnHRdj5f7Cv?=
 =?us-ascii?Q?ODy3LfYRhbF8mF4Qiar4SWYR9QjyXu3qVQ9IknrjCVwg3b+WkLzjD4lW2ULV?=
 =?us-ascii?Q?XvuQFsjvFY/QZQnAj3hEEbqdUoHTWpGGTLodVldW3V5KI6ldC3GFaGZvuTS/?=
 =?us-ascii?Q?2/D6QHl5CVFVK/F+T8Vh9p2ayEOhBq3MfkhPI+tEEb2vs2iOW66i/cnXpD8G?=
 =?us-ascii?Q?vsqRf3d1ggX4yga5a65UlTukYrrAbiy9FH+SUWCG0ZXHI5pOxJTX5L9WCcpb?=
 =?us-ascii?Q?kA7EF1jBxOlxc6l0hq23HYIC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j83qDo3sJ2JKl6D9jaC3+q1GYmzMiGQnXrQb4up2FIAHZq9ajFI+9Ir/IfZ1?=
 =?us-ascii?Q?PQK3kGwajUo+IxPaswicCgjaP8tv/+ISYpFYi1SfLbMU/i+SXu789Nnom3dy?=
 =?us-ascii?Q?gMwFctOQx0M9NspW9DWieal+9thj+bnwAURzZHu3xtvvGobEjm/6iRFacHwX?=
 =?us-ascii?Q?cyndFrjq7QZGaSCuNfGOmG6qqrS9jxsWZ2nrqrV0IfL+H96ZhLn8eUFkGYRc?=
 =?us-ascii?Q?+UVBrmifa2XtiZ8/rLxUnZ8NeaUQEt+j8cD80kFNisw/Yg34R/exvSJb8QED?=
 =?us-ascii?Q?+Wko+41fEaGw31n7OV0TaiUBUU2/avX3pzOIjVZGzPoyXVZvPAun6kWmH5w2?=
 =?us-ascii?Q?2bP1YX5IpymtnJgo2DRvDa0t4CPshYnhLo0MtYBMC6dD4TGnsyFF1l1d6xPa?=
 =?us-ascii?Q?mS8MitD1t/jumrX8r/ONnu0NYBgtF8jgqF3mXZuH/E0n/WLj/9ttMNIHNDcC?=
 =?us-ascii?Q?uqM3avaqGtt0qk7hu5+mlJeN6WYihfxX9hjZEvqoQIaRfLlM4IyEAop8uS6r?=
 =?us-ascii?Q?T50atcf72zqxDVv6IfrDYl0J8iLavWbEbuD9g60gdA3wNYd/ws9fE94UWbiG?=
 =?us-ascii?Q?1SfxbC2fq4cHPjZGDHQ+P2MMWoUyYx04jmGuX91XkN+Vn0oshU4d4N5B97GU?=
 =?us-ascii?Q?o5cDuHt91iyYCc2y2C9osHOJjF0Per8ojNVb/HZyyf+1Pb+YElXCG25V9IAo?=
 =?us-ascii?Q?IexkjX+69ylIEEX87pd3qRf2LvikXPjFembqe+FC7fAykrBpGPoSNYzllu4t?=
 =?us-ascii?Q?Qto+B0AX9TkapBFeQo/ueNlFd2ti8zX5AtUkZE81Addc8rRlJrxlC7vykLus?=
 =?us-ascii?Q?syLy1nXVvbMUJ6GjPWx3UoHrY6MIy2F/O5V1HOGqU32d+9FUXPZjOLj719D2?=
 =?us-ascii?Q?HwO5iTdkWPDfhQzsvOPxVTEMqeptSEJhQ3j1Uy6g+lrYrEQ+tq9ce5c9udxo?=
 =?us-ascii?Q?ISnfaHQsVdWac7UhPj7DPK7VBdZGMaIfuW+6FDT+Ch64g4rFqDA7bsRI7RU/?=
 =?us-ascii?Q?XVDMoGRzWzn1JzqBOEkIs8FtLiaF/CbLnBmaDRg03BeF3DAVAQnHJ4NWN6yI?=
 =?us-ascii?Q?xEXEkwzjoLM9n6tegJUED1oPbLp/zUyFkkfYC6gahiCailL7GXPGIZqTtW4z?=
 =?us-ascii?Q?w9fBDbMXss8GCO0P7BM1jJCgkeLae07OYcIZcdmR3MB2BYEk4IxF7T1IipUs?=
 =?us-ascii?Q?JAHbuCuvTHxhX86fS2Ptqa3eRJFPYBbJm4Kk2xWpYhYRUyuyYGjG5vIX5e1L?=
 =?us-ascii?Q?m+V1+pVJf0GYnXgx5XFQsoqXuyCSYsQkXflKg3v5Zqyu38JczKwoyrEFM5AE?=
 =?us-ascii?Q?lItVvph3XCtoSZyW/+73BPpd0lfmYRdWw+O6ejeTAjpgeTwS2tqLOCGk77Tq?=
 =?us-ascii?Q?YNINPE0ltFU/LbRhfDtLJDWMZYl0dEPFp7zvAwri8kzWUWTlP8VLqLu9lpSo?=
 =?us-ascii?Q?J6io1BM/zrfeJAUHWnRprMKy/JUq7Iz6IWTis68gLCkTgZSnBeonKb38j8OD?=
 =?us-ascii?Q?XWL2s/XkDYC7UyRgXcu25BCOmMQDgM/5gjMd+zL+dvPzpAySqV6xG0ldv/0n?=
 =?us-ascii?Q?Cp9U2NcRhw6nqr072ODKwmAQg2m+vPfSpGEwAo1gmz1D0psDRvlIlvIAM18G?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 817bd181-6d31-40e2-4bd4-08dd0561aef0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 10:38:46.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qO6IK3oiUpxVjD1fiPRZuO0l5h3DZfl5L1dfzZF66i8/GTrAmR4b+Wx0Ip/q3IqgosjumYDpG7aR6C7HVHdX6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7714

This removes the BAP API to probe broadcasters from BASS, since BASS is
now directly adding the Broadcast Audio Announcement Service UUID to the
broadcaster device, and it will internally handle the probe.
---
 profiles/audio/bap.c | 16 ----------------
 profiles/audio/bap.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 6e6d68b57..beab85cff 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3243,22 +3243,6 @@ static bool match_bap_adapter(const void *data, const void *match_data)
 	return adapter->adapter == match_data;
 }
 
-void bap_scan_delegator_probe(struct btd_device *device)
-{
-	struct bap_data *data;
-
-	/* Create BAP session for the Broadcaster device */
-	data = bap_data_new(device);
-	data->device = device;
-
-	bap_data_add(data);
-
-	/* Add Broadcast Audio Announcement Service UUID
-	 * to device and probe service.
-	 */
-	btd_device_add_uuid(device, BCAAS_UUID_STR);
-}
-
 static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index ab35a3775..d91cada45 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -14,7 +14,6 @@ typedef void (*bap_stream_cb_t)(uint8_t bis, uint8_t sgrp,
 extern struct bt_iso_qos bap_sink_pa_qos;
 
 struct bt_bap *bap_get_session(struct btd_device *device);
-void bap_scan_delegator_probe(struct btd_device *device);
 
 bool parse_base(struct bt_iso_base *base, struct bt_iso_qos *qos,
 		util_debug_func_t func, bap_stream_cb_t handler,
-- 
2.43.0

