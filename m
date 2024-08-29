Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B8D1B011A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935790; cv=fail; b=eh5gcI0W8hYP+tweeIDd5S6kKeLDZJZoe56jIxCYi9z/gPquNlnOg9kgSR2ysnO77Md/izu/lFZcapL0aZPVEfIzeBjwsTD+b3c72BbzE1IXd4rKUbq9mmXzkvn9Kev1+6PeTIYzviLNzLJCunb4p2oj3ZvvC5MbXIVZFYFnSWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935790; c=relaxed/simple;
	bh=fMVPu/sucQBHpQFWxlUgu1Wpg/AjxVrNDKqTRcnBl0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SPq4+BP/hgqfIQoaYFH5FNm4Fo+XDgKVSAimBkzhLOIJ0xfbyZD5py3Nkghx/aI77u9QsvDr3cGLXYfqpnrDbAqoGJalPWRPCsgY023vgLxa6GAibqzvG6AiyGaCK3dmrfL70RuJWWta1ZrvnzUIuOZVYPLsqmeNvCqNqEPmNkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QFI+cXev; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QFI+cXev"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bc3PgG5FQ2x/KBFNqorHWtlUuniJLXDJHiRhyIo8HBxso9tsFcfZ7gfPkS0H1VnEeKTwEL2pUiNF0q8dX9wIQgaKzEPKUZSIX0CPps5QGQsZUrJorfbgMA4ERQWzc0emTQ+C5dFn2DOiBILbzsPauHEs/6h17SSd7XW2hGvU3+x8m9Msn1VfoSY/DoWCEcwXTywFpzCZoQQo8gnHAdRBU0lVVwaiixxGbmbGq2HicYTyALgCcxdXxKPwcvaDrN595etRfFX09SybfhHhQBdZXSV1cj1MzKa8LnqM1yK+SzwW84tKKQTXFtF2qaQf/Z/2IQNlTTHpf5F6wfKUk4R1BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wE4x9B4TumoXik6Bg9LVUVNa//Bpv2gfcrGExAjhKTk=;
 b=fkN7RHEI2ASZsv3BU3zWkoS85redCIcjqRBmeYBqs5o4QQ3WklYroy4wOBE8sF+n1YF/N5uvaph5s238iqTKDkFBCh6a43z0QgMpz39n7RJ5GaytdHZf3TVvgdAz8O5F/Ff0remm/ehix7qU+rlel+oC5z700IGe0Bt4AFWJd62UWMQ5TGtxLBqxowe6RMrRvAeoOAhfC9qWo48w2Y/mvDnOmvzrTv8E2lPnaSkanuycM+CPEM3fp9Q/SbUi/xkwaJTXwbOsJFnd8EOt2WBpcfdG78nSJWAMQ6rAEyzyn678xmSuZAzQuDQ3Fg3SIP4IlFtfB84SQBTDv/KfEyoyqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wE4x9B4TumoXik6Bg9LVUVNa//Bpv2gfcrGExAjhKTk=;
 b=QFI+cXevogPORrFLPUAFQ9elRedWbp8cRmTjTRiv0bvDfxMIdmyvyf/RgjjlZH99xz/kCk4BfPoUagT7TwTdfk8JjfBnhuOFndfWezQlaqW3rGEtm+OpgTmqGpV+S28LUO6pFy675qi7MJ2olT/WYJp3drxUtAhjk2ftJMZHVBTq6WNyKDVyEjArVqa+Yc5zUw6gn/QyQ3+mVsZEPa0/eSLXynf0mk/6pnZiB32LVzmAqFCRnXYOCocHP1NsYdwPecc93C+OqX2OKZR2CzeADlk7HqR9vLZvYV0ihOUraT5YB/pJ8c9R0EtYsMgkFDTIOTomHOT0sYn5VCdro8GHQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:45 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:45 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 07/16] bap: Add API for Scan Delegator probe
Date: Thu, 29 Aug 2024 15:49:09 +0300
Message-Id: <20240829124918.84809-8-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0051.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: c342946a-1998-4fc5-68a5-08dcc8290f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EUYCy0gSaj2qbE7ZvSLR0BHjGjdTpwL+73DWURGUaifN2DNxXrJNp5xe6vbF?=
 =?us-ascii?Q?iP5Jmz0+WMwAOl2oRtPrub0sPO+VX676xgrxCZ2wJTiua2b6HhJk2ZEeAHzf?=
 =?us-ascii?Q?eit2VTJzavbPxsmumpB3JiEJoF0PvcNIIca25Zq5YyjVqwDGPND11HH5Gtby?=
 =?us-ascii?Q?safuulUMkUnOAsEc8sEF8WeEWjF80OgtDq3LHmfZMoc50g22DsDHHWTrh6+L?=
 =?us-ascii?Q?D9c0tsJDZR6CKPt/rcP6pRAh+VF8zLjmj7uA89K+Ea6aHCylITmaK4Jpmhnz?=
 =?us-ascii?Q?T8ydzj8qWDIHICixar0BIXZp+Kq4AwEoYZ3hZlrI/tZHnLdDXrcSOQetch5U?=
 =?us-ascii?Q?COwR3XXYsAe9vVmGVfPovhSiQ02zgGXsy3xPZ5HN5BA1qk3/A8pYCFkrBuky?=
 =?us-ascii?Q?7XG3/sQX7eSxzEKp28kKQmSjgtXkOXbiYvikWcZp01gc515c0CdWHjWaskZ3?=
 =?us-ascii?Q?BI2m1scU5MwAvMuzSRcpB/foQBFGhs6EgcNnQpG+Ehhw7y3SvRA+AA3t36ud?=
 =?us-ascii?Q?OUYAH/pFZj9V9Rh4IYqnzDkISrn9J7SLWvlfeKNcV9syD7h3bU8DdVJEUCAr?=
 =?us-ascii?Q?NUrDr9ZwjjvvTsTmFLOdUAxUEP0QKwuoUGcrQ9E7YVgLdeu7lKcztBcygTyO?=
 =?us-ascii?Q?2yiGMzTb/32nRqfY2tV33MKzsJMEMb9MJUETAvGovLcrXqFrjTh7oNRrjud2?=
 =?us-ascii?Q?g4/t/MfBBWNVd2zj6n2ynFPqoWTC5bhJvWXiobKpZRXlJfVeY6JACxm0diyc?=
 =?us-ascii?Q?vedrrs68T6Qau9vgdncRPM9kqBtlRf1ZjhtATHptmD/oyb5dI0JL2H+SK8jC?=
 =?us-ascii?Q?l5hbVOClIVD2fTYWPVRg9o7w5SpBjY1xP08pOnaZ8/grTd/UNT8dbGfUfhxF?=
 =?us-ascii?Q?Bnjrr2iHZxfUAD3cxAEOJYbT91NhmFVzz9y+yhroZ1T1gaxnH1GfNuv3VH4D?=
 =?us-ascii?Q?7KUWLnA9TY3ouPsDMhDIPNvIdZj8vbV1n/XL+7SuR+dmL9qIujNB+Qklrp6H?=
 =?us-ascii?Q?7yFCXuOC6As7xVdnCIeJZpJ8WsbKgk+szpX8xNOHDh/uIRsjR33jJxgNDq2U?=
 =?us-ascii?Q?KV/PvEuW8uiLjdcWE9sc7tpgX1r09Z0sXdUF281i+evBWJytgD/TiN1iU88Q?=
 =?us-ascii?Q?9o4Y1xNVXFYsFcDdT/BvrOJ2r1j10/1WhmpEcJSk45iu10Y1QKtJ4fwaKwRv?=
 =?us-ascii?Q?BTevWUydgYNUQ2WZOwM1OExl/B5EpN6WXI/bRPepmAEtcgpU9cLu3dPJ3CxM?=
 =?us-ascii?Q?V2AgcvZAGtthCa+XlrWaAOklQEZkuCbAhpM6/iYV0XY+e+VRYJt+FqPHOfGT?=
 =?us-ascii?Q?IO630Jk1UKdClarAU0yvYnwCkJX0lwLR8tzlHsvUI1j4hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wmbmmW8zug1hvQDZ9kOUucxm0/ZEv3rlf4gmV+oxUKosZMvH0O7HWb7QoBtO?=
 =?us-ascii?Q?Z5pETheo3hGcr1Y+qCHKgnxeNnnF0qpTFoAreXq0f6EwTn1YVRPBUqmvttEX?=
 =?us-ascii?Q?PZiKAymcmUsd+8TB229sqM/wIpqFMcLRolW55C61IpI1hDe7fDIW7feONmr7?=
 =?us-ascii?Q?mkykul9jTrz7huOxTggA3A/1Kv1p85v6fuK7t/Vijyc3dbQCqc3fjDT8v+9Q?=
 =?us-ascii?Q?E09ykONVlZtBQLTFx4c9DM9AMdLLREc0Vs5J4MS29PAXvEZFTuTTDKi7V+LD?=
 =?us-ascii?Q?D2eaadnlBmAlbbdRyTJYLKazbHwpOvEMJ9jAvH695hxdsxcV+hW0VhR4nb/y?=
 =?us-ascii?Q?GdETFjF5hOY1AiWauIFw32LTCdKuxgpzJQ6CFdeYewiMUYUn5nIa1+nh91Kl?=
 =?us-ascii?Q?eBGDbnKndPZDsp0p/yU/wILg3x/tJjDW2Xg5JOG2B9zawW4OKhyjGgqLRytI?=
 =?us-ascii?Q?WeRzJH0BCv7uhYHYfDdt1b3C4LLfCY3lQw53cek+ozDJOrQ3NClIKt2l8iIv?=
 =?us-ascii?Q?ac3wxbhGIBM0pIgdeo+iYvPQDTDKiA8OTKPsBErwUVFzo/izQ5F/6o4l7et1?=
 =?us-ascii?Q?zAoFGkRsnpRtqrIMWB3FdUb4Wh9dI2x+u1rsvgoT1UpBhKqiDed4KTHRN20A?=
 =?us-ascii?Q?TE4qmqBmjChDo/6WbZEBc5/MlFwgQYdLgu0SLAoM6dUlFHEjlBua0m6Azf3Z?=
 =?us-ascii?Q?2mmSGeU2oWjqqrxyYva3SxodCSlPnIdv2HDFeVmbE7BH4z7HKfcaPd0NfFDe?=
 =?us-ascii?Q?taLC65nlKzkI6J/GGitUTv/KOHK+DVR2F/aMBivycVHUTCib+I4jz+U5toU4?=
 =?us-ascii?Q?ZLuqnZpBiZo2nZ/UYfuqcPvimKlIOJuyvrr6sju7LXBoKbG9l7mbRmvZxA5e?=
 =?us-ascii?Q?+na0SRcwGOVYaHVm7+QPRbdMjBs6NgVH9IwYo8ahXiddZJ3rhilfImPwqeDV?=
 =?us-ascii?Q?RAiL+Dr0atv48BINFnc1yUXRSzjb3nZGOYY2nA9qnIG3KWj92INctjm5oYs8?=
 =?us-ascii?Q?clhA20HAqK24mrg9u57zZyeJy6Bdux6pytOIf1UhkF5iWInFTYZryHeSkhs4?=
 =?us-ascii?Q?ZxrpzCQksigjO+zccebDr/UzMk8sD+JTblhKp+AgUn0jyCC4j3fuVnkEcNRT?=
 =?us-ascii?Q?VvvW3PyRL/Kd+cHIwKs/5qaJil2/e7eUkl/X/cmaLgG2ifRkT1Z94MBrRpG4?=
 =?us-ascii?Q?+Y9hHpJsJjX0+HpLcxXVMoAreA43UIKlEJlqChP5ulGcoyTk1XKrQyaShS8O?=
 =?us-ascii?Q?LkOCgY93hv4m3tT06zrqWoY7MdLMmbTwuBUNgWN2p9wB4nIW9Gsd5luXXjM0?=
 =?us-ascii?Q?Am1no1QTYdydAOdzreMurX800GvfCup9zYSeZSL8FdOsogZleUYdE1NAOqYW?=
 =?us-ascii?Q?AGn0kTHJZzLpVTIMZ8/ZXLeX/Nqr6eHZnLJZ7Ghxyk4OETRcJ+02rw04sS+b?=
 =?us-ascii?Q?kEFwTwPEU4E3mREi2rQuVOTRKTQevryU64WElEgcGEqX5vTtv2ES820fMsSN?=
 =?us-ascii?Q?6ybjMAsCSJvFgmfne62vnuwY5t8yyKNdueOI9blhDi0bc746b7qsgZmNUb/m?=
 =?us-ascii?Q?fRUm2Jtp3S3th+K3xuhrKxpK7H7EtnRWDjXsHXdN7iSOwfttkQcZvOUZditB?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c342946a-1998-4fc5-68a5-08dcc8290f05
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:45.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IO3zxkzHF+fWo7ERtumH25jvk++KcXAmtOY67SIVoq+f3aJgoYTjU5+VFIrd5K9S/SJON89+GCriHBK93beNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

Since a BAP Broadcast Sink might probe Broadcasters autonomously or with
the help of a Broadcast Assistant, BAP needs to support 2 types of
Broadcaster probing: short-lived and long-lived.

This adds a BAP API for Scan Delegators probe Broadcaster devices
long-lived.
---
 profiles/audio/bap.c | 45 +++++++++++++++++++++++++++++++++++++-------
 profiles/audio/bap.h |  1 +
 2 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 76171eae7..3b2a742c4 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3171,12 +3171,29 @@ static bool match_bap_adapter(const void *data, const void *match_data)
 	return adapter->adapter == match_data;
 }
 
+void bap_scan_delegator_probe(struct btd_device *device)
+{
+	struct bap_data *data;
+
+	/* Create BAP session for the Broadcaster device */
+	data = bap_data_new(device);
+	data->device = device;
+
+	bap_data_add(data);
+
+	/* Add Broadcast Audio Announcement Service UUID
+	 * to device and probe service.
+	 */
+	btd_device_add_uuid(device, BCAAS_UUID_STR);
+}
+
 static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_bcast_pa_req *req;
+	uint8_t type = BAP_PA_LONG_REQ;
 	struct bap_data *data;
 
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
@@ -3184,10 +3201,27 @@ static int bap_bcast_probe(struct btd_service *service)
 		return -ENOTSUP;
 	}
 
-	data = bap_data_new(device);
+	data = queue_find(sessions, match_device, device);
+	if (data && data->service) {
+		error("Profile probed twice for the same device!");
+		return -EINVAL;
+	}
+
+	if (!data) {
+		data = bap_data_new(device);
+		data->device = device;
+		bap_data_add(data);
+
+		/* The Broadcaster was scanned autonomously,
+		 * so it should be probed short-lived.
+		 */
+		type = BAP_PA_SHORT_REQ;
+	}
+
 	data->service = service;
+	btd_service_set_user_data(service, data);
+
 	data->adapter = queue_find(adapters, match_bap_adapter, adapter);
-	data->device = device;
 	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
 			btd_gatt_database_get_db(database));
 	if (!data->bap) {
@@ -3202,8 +3236,6 @@ static int bap_bcast_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	bap_data_add(data);
-
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
 								NULL);
 	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_sink,
@@ -3220,11 +3252,10 @@ static int bap_bcast_probe(struct btd_service *service)
 							pa_idle_timer,
 							data->adapter);
 
-	/* Enqueue this device advertisement so that we can do short-lived
-	 */
+	/* Enqueue this device advertisement so that we can create PA sync. */
 	DBG("enqueue service: %p", service);
 	req = new0(struct bap_bcast_pa_req, 1);
-	req->type = BAP_PA_SHORT_REQ;
+	req->type = type;
 	req->in_progress = FALSE;
 	req->data.service = service;
 	queue_push_tail(data->adapter->bcast_pa_requests, req);
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index 66f8db887..cfe633311 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -8,3 +8,4 @@
  */
 
 struct bt_bap *bap_get_session(struct btd_device *device);
+void bap_scan_delegator_probe(struct btd_device *device);
-- 
2.39.2

