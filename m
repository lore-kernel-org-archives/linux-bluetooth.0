Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1425EFAB
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473078; cv=fail; b=TAaUAgKlIrZhD++FXbTUoLxJod04XwYJ/Q6KeQuZnIT2Xenxk1MaJgfMHdCyKAHBKbh4xQSIH/J0n0ZwP6VK8lgwdpGf2a8iILzqKpPcylH9+gyQyKVjJR8t5avoXWUS6yvNIK33gmsuk7x+WTfHjrEXuozzI9s80up+eimxfLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473078; c=relaxed/simple;
	bh=dCIMbZLdukPeMSe269Awu/LhXzWTxdst7FA5Jxh72TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gITepz5qWyIGK3VB6FLC0bns7doOmD0+DK19lmGvYvthcc2FsQbiiL15xoGjJljS2Hg2bSRHMIYjs9Gxrr6lweEO3YPFO8LwCihokvobCFQOpURSpSPJJdXL5QTCFkn45nFCniNVr3qmcK+0Q+QQmTKTe1hVikOw8TxhadpdRbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z3KPdH5I; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z3KPdH5I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3895fwR0A9nQbqdbBVmttcOa6geVizrL3KTV4y0P/rINC0Z20fhqwgZjCn+yXoPzyRU/TOgEAoa9/CaPyIdKc+nVDRPBQz03VFywPt/WAtRh7hTWOQDreRZqw68TsYwk0kh6qJWGIm2X5sW0Vl11X7QYMOqmzXK1Uq25SF1DKj6vxCES55BYWKVtMxWcjVQ0RHlTaMjpEw8MZx0NevMfeIRYm2oA7RDnFQiMONQswxP+dnF5OBfcgYDZUyqWYKCO0z6Ygfv1MHzfuDCW+0sMe+WXatjmLIqnaa6rR42j8DwpWYdDc6AhSU2jH1CRDOgOXYR5zl1nPyjoaEf8755Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DfEsqD6Ug8OISbsA8zl8Wn3I+frqS0mfimgO6/Ol9U=;
 b=BB8rQXr/eCMB66mlsXbJgfUi1ZYJAr5vO/t5CRr71R1SL0pzAl1XcGXo9gVRLvks1Jz0oVGVhpCYQkv3mFppD+G5Xn09vFfPsjG+2XirGhPmV1XeaAr9Mfsj7p7RhXdCpR3YEcuqLz6+tFdCKkO4V5m5NWEKoKYmKJ0GwmDNyK/Brr3yzSpzrt5eeLhWmD9ytUvlpQzmNtAMNckyGDsZfGoJglu7+U1rpDJL66DGc7oJwMcxJTus35HwnH2RZJaOnMN8/jUnhrDwrRO97hYr2EHbK2TGOUdr8IsVkYe2gg+Qk0j3aPYU8cK7tRwHgnSNC1AILOoWDQVoHZZDKtmNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DfEsqD6Ug8OISbsA8zl8Wn3I+frqS0mfimgO6/Ol9U=;
 b=Z3KPdH5I69KnC63EC+h68ky7KICyjI2ERFYTfu+XyhYbiYxjpNa+WYUNV66JHv+VvaM3iqxy/4miMWnolO3bFyASpauKG/qfWgrc6k9h1bQNgvs+/2Fgp/bsprwhqCST+xCB7H94Ve+CiJRXEJdOn+9EfoDGNeugduommaxtIRui47g2XZNCdUxoVE4Lmzi6kMz1J7UeahZDPHMEy78eqVxKsuYXU0GKE6fIIOn3liXSMZprS3s1/Mx/QQ3taLTRGFD5r435n74n3o0oob/fTT4C3JIg18444/sI3HHeVAInzRDbUGe9+Tzal1mSuERrBdufSNJAukkMjCl/2NvbDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9570.eurprd04.prod.outlook.com (2603:10a6:102:24d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 08:44:34 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 08:44:34 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] bass: Register bis probe/remove callbacks
Date: Tue, 25 Feb 2025 10:44:14 +0200
Message-ID: <20250225084414.28677-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225084414.28677-1-iulia.tanasescu@nxp.com>
References: <20250225084414.28677-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0057.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ec81f3-3ebb-420f-a10c-08dd5578a112
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1SsnuripSmASbJSsO5A/6ow6Njijnm8RMDh/AgV/oTTdPEbFL36qRBzM7DYN?=
 =?us-ascii?Q?+Syj3gETZrEjBiaimGdZdBFzMXQ7RGqRO1kcw+4xUYtW6ETb9JNvmCrQG79k?=
 =?us-ascii?Q?DC2ifu6nBf6MOIwLBsSbO1Qfb6viMilxnOfNMB4URnGcVyeMBHrKEIPfLPTD?=
 =?us-ascii?Q?1mV8ozdkRHBFrXs09YHaKSzs2zsqj6Wz2qMvHaOV1UDc1IPGcrWauYlRPlA/?=
 =?us-ascii?Q?soy3ZuHRrytUq+DXOHgHN90x3uPmuvwVu0xrzM4vFdWugM9slk2iAs83p92d?=
 =?us-ascii?Q?EGVZqkeY+l/199dh5Up//Tqhlja+WwjqcJQP7abnZcMTe0ez1xLegD9fL4uw?=
 =?us-ascii?Q?gD3THVPeYW4ND8klGgsA+kJA+yNxrf4q/4ndKjUx/pJl05EMAMNSfMI7n14A?=
 =?us-ascii?Q?/TBoGmei0KL7Pq4ciSihcY2Wio2JxWHF6u8sH9zOjhQo4DI8N9xb7f/lmKOB?=
 =?us-ascii?Q?R9iclmfW8+g5+KtTr8HVLOYO6r8bwypJEBVIO9Bo1AjLZtOFwpQzT4c9RQys?=
 =?us-ascii?Q?hkN6TOH52y1ed1jBAIjfsaC3ozi19ObuEkHoCn1HQwN0lA4Rkg94VkHWCC9y?=
 =?us-ascii?Q?84Tp+6CbQLOYgwN3n65Zzrz3cPjrJ/yY5dzhqNkZyeRi4L/cm8i31c5yHVVH?=
 =?us-ascii?Q?5F+iGzUEKTVrvEBm2umlcDC6pk6zfpBmg6vj5+mtPGO2DSmkGvAS61/n6ern?=
 =?us-ascii?Q?01s1WxK427ohP6aqxeOZL3cdm8b1qLjzkYvPSbQpBbdex+xfGA7L1zrY3Igi?=
 =?us-ascii?Q?CUPe2HVwCPi6Sh7jXdEzNiidoup8GpsER7B3EixeYG6XmB4OCFzkPbCUcEFu?=
 =?us-ascii?Q?Fbv/E3oounpZW0lkxvTmDf87GpDkRdgxYw3T3pROpuLDwfoL9wCzZvZenNFJ?=
 =?us-ascii?Q?N5jz+cU+Uz/UEFNTFAvkHZxiEhnFeSbt6/ITuaB0U+IHX67Z+MIJT5OVlk9v?=
 =?us-ascii?Q?u7V+eFY9G8p5mzLfSEOfCB0KhcNGwvaJ4X38eUKNLVaXYoxLUWIWHykv5Ih/?=
 =?us-ascii?Q?FgtONtiqdVurL8yNG9DyD3l9oft+zm/kPoMO1YeHWKZwZ2l2zd7NMRQM9Z1u?=
 =?us-ascii?Q?I4nC+28sPrGXzR8VE/OgOOTZ3WlVZc02O/q7XKzFA5e+bcEgvO2x7nCDmBF8?=
 =?us-ascii?Q?oY/mdL7a7cJ+dLBdl/AofR3BqYiUbCnWWUO0X4CmRtnDNIIDBJciNuTl6SKD?=
 =?us-ascii?Q?5HegEa2kGScnUqk87HuuY1pPZXdq6czNlGMmrzb6u9UXxEhZfXQ04XLGjeOM?=
 =?us-ascii?Q?t1dOkk4KX0zEN52s07XuNH13O1zTQg/ZEiv2/XMENxqOUvG7q4998siI4ZIp?=
 =?us-ascii?Q?2NZaRd5sJHxzBVcnrDXS4vxbMOyb8F7/3a0I4Zc5q1gDBetJep5ES8fwTTUW?=
 =?us-ascii?Q?Ll6Ip9fnGSdNKaBjuCCaA7OdmFJ7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hTOLI6jxuUHsjhrOc9IWP9I4O7nLIGhq26SqLf0d76npvkKOiPPyYF25nJEf?=
 =?us-ascii?Q?HJh8VE+Ry6t1cmDo+69c81Wd9h7ByEYFxEYzdCZKr2Ma+6QdprfwXwHpvNN5?=
 =?us-ascii?Q?F3DqxvSPyIEV9yRsegvqOnihDHG16hwwD23u6MSCNcdyFs/L5YGioY607wsB?=
 =?us-ascii?Q?NMIXZpXsHH60qgZQRfi4ZB7t/WDaGLJIkpl6dqAK+IZ8W4xk73gvREDXFnYB?=
 =?us-ascii?Q?Yu/siY5cVVi3LQ4gOEalM8KYpE9F98E27k7OwnUNXNhHg1I9uNmSZ1T7q+UH?=
 =?us-ascii?Q?M0U6Qc+W/he3hZBOLaKMQnG/fYkzwoaaR4XDnG1MVMJShF/XqmrjfYvp6L7m?=
 =?us-ascii?Q?MLR8cqMruLpNthIz7kc/VE53WclTDnm45tiLp6RdsjF/WNUWZKV+1x7IpyyH?=
 =?us-ascii?Q?5XXK4Cp3VUK5prt6Up3f1bCk94Rgyb8x/h0XXv6b7OAdY9NmjE4igzZHxwDg?=
 =?us-ascii?Q?hhMlMg3iAMIeJ0uQN7FDt/y2S6hSjscGdx/xr6+5WIRqfSCC6WR0j3HAb4fZ?=
 =?us-ascii?Q?nM7FPu3zPZ0/OGcqDLfbDsOknfosdM5t0glweXsJJ/RjxE+83UyNU+Rrje3n?=
 =?us-ascii?Q?ZWose9Cm9RJIeTXJOB21INXWGH6HVjxmv5wAAKgLwQkwWKf4man+YTqDR3jS?=
 =?us-ascii?Q?RafnCDX9pgojSZz6IfsKgkhgpVhJdbLBufYAlqWsrfsiifg3KVgdDiaCJQon?=
 =?us-ascii?Q?3LEtsFjlwrDo3mlyhv+kTNH2bcIhmcpcX5oMgMjtS7IqiCqVPtCvzu6e8AWg?=
 =?us-ascii?Q?JQeYmjBc7kW9VYgsA+iSQ26Cugk2RHVv69gaw25ifhZfttACFbsxuLcuYuSA?=
 =?us-ascii?Q?a+Tlt/TqlTh6AAT1DWV69yVVb7HQiRVQTGEfQMdC05+VMZ5ZW/oPda5ONcgg?=
 =?us-ascii?Q?OTq14YlxfZUmdtyv9Fi/xPbmpHeyWbNNtokWyoDe3ewGDs0jC8zmoHAE9RJG?=
 =?us-ascii?Q?OTLshKDejPI3o1OKltXXTLtKBFSg4BWiuiVmpRm/R9dojN0q/4WAz1YxnNvh?=
 =?us-ascii?Q?2kZdbhoP093W15W+gkAUKUTrqEhOj64cY1RQGjo/Y/N/cs5fIV0+zLc6Vppw?=
 =?us-ascii?Q?e2b7YvJYSOJVTGZJM3c4DC7o0w93u3EZcBrz7Jzm7YqqX4P6KtnJIrHXrVrB?=
 =?us-ascii?Q?b8egT+iYS/wUUVkP0MoLwsImCGK7nUZSwXuLLp7JgHbS6WT5wz36Vy9D5ESb?=
 =?us-ascii?Q?CupOyEzD6y8Iqqn22nRLn1DAF8iaJiTllCb19/Q1Qjvuh0AH/tqKShj+CsXz?=
 =?us-ascii?Q?ec57ZmEZUYuI6UtcLGYO/ktukLqyzeWc3ZDdI8Hj1f/uiQjhiC4Ru9BrmnY8?=
 =?us-ascii?Q?eF7zf+gMFb4CSXgnKE2h8Q0JkWzSwyC8H57jvUilfYYAAAqqVuDE0QLqFDty?=
 =?us-ascii?Q?9kKtq/rIfEGE7feAU6qjushjVSF9tAgysKUytd+Oc/ETvdPfCW1LxfifXT77?=
 =?us-ascii?Q?0hDt4JDNT50Qr2qvr2LvSi64ipPSxrcA5fKW8qwsghxN4wuJS8DcSymHBvF0?=
 =?us-ascii?Q?UGV+tLRTgUISpbiSpqApozqBgA3/oofEvd7XM22Hy3yHthea68CQmQcNH0tJ?=
 =?us-ascii?Q?It5EGF8pUuxU7B3kPAgeW1cfzYweurj9PwYKDJbncyglRudKrXExeASzvtm3?=
 =?us-ascii?Q?Mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ec81f3-3ebb-420f-a10c-08dd5578a112
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:44:34.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6g2UCmiTF0lTdQ9gti+GYU+fgTpRCQVIshek+m85WLd9mqwuiwYhOPHnQHbjg0CaXu1QecynraprHH5/OWIUqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9570

This removes the BASS add/remove stream APIs and uses shared/bap to
register BIS probe/remove callbacks instead, to avoid making direct
calls between plugins.
---
 profiles/audio/bap.c  |  6 +++---
 profiles/audio/bass.c | 22 +++++++++++++++++-----
 profiles/audio/bass.h |  5 -----
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b36e45ea4..37168e58c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1178,7 +1178,7 @@ static void bis_handler(uint8_t bis, uint8_t sgrp, struct iovec *caps,
 	struct bt_bap_pac *lpac;
 	char *path;
 
-	bass_add_stream(data->device, meta, caps, qos, sgrp, bis);
+	bt_bap_bis_probe(data->bap, bis, sgrp, caps, meta, qos);
 
 	/* Check if this BIS matches any local PAC */
 	bt_bap_verify_bis(data->bap, bis,
@@ -3128,9 +3128,9 @@ static void bap_bcast_remove(struct btd_service *service)
 		return;
 	}
 
-	bap_data_remove(data);
+	bt_bap_bis_remove(data->bap);
 
-	bass_remove_stream(device);
+	bap_data_remove(data);
 }
 
 static int bap_probe(struct btd_service *service)
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 96e767744..f5fe60652 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -86,6 +86,7 @@ struct bass_data {
 	struct bt_bass *bass;
 	unsigned int src_id;
 	unsigned int cp_id;
+	unsigned int bis_id;
 };
 
 struct bass_assistant {
@@ -141,6 +142,11 @@ static struct bass_data *bass_data_new(struct btd_device *device);
 static void bass_data_add(struct bass_data *data);
 static void bass_data_remove(struct bass_data *data);
 
+static void bis_probe(uint8_t bis, uint8_t sgrp, struct iovec *caps,
+	struct iovec *meta, struct bt_bap_qos *qos, void *user_data);
+static void bis_remove(struct bt_bap *bap, void *user_data);
+
+
 static void bass_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -590,6 +596,8 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 
 	/* Create BASS session with the Broadcast Source */
 	data = bass_data_new(device);
+	data->bis_id = bt_bap_bis_cb_register(bap, bis_probe,
+					bis_remove, device, NULL);
 
 	bass_data_add(data);
 
@@ -678,8 +686,10 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 
 	/* Remove BASS session with the Broadcast Source device */
 	data = queue_find(sessions, match_device, device);
-	if (data)
+	if (data) {
+		bt_bap_bis_cb_unregister(bap, data->bis_id);
 		bass_data_remove(data);
+	}
 
 	dg = queue_remove_if(delegators, delegator_match_device, device);
 	if (!dg)
@@ -1077,10 +1087,10 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	return assistant;
 }
 
-void bass_add_stream(struct btd_device *device, struct iovec *meta,
-			struct iovec *caps, struct bt_bap_qos *qos,
-			uint8_t sgrp, uint8_t bis)
+static void bis_probe(uint8_t bis, uint8_t sgrp, struct iovec *caps,
+	struct iovec *meta, struct bt_bap_qos *qos, void *user_data)
 {
+	struct btd_device *device = user_data;
 	const struct queue_entry *entry;
 	struct bt_bap *bap;
 	struct bt_bap_pac *pac;
@@ -1142,8 +1152,10 @@ static void unregister_assistant(void *data)
 				assistant->path, MEDIA_ASSISTANT_INTERFACE);
 }
 
-void bass_remove_stream(struct btd_device *device)
+static void bis_remove(struct bt_bap *bap, void *user_data)
 {
+	struct btd_device *device = user_data;
+
 	queue_remove_all(assistants, assistant_match_device,
 		device, unregister_assistant);
 }
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 99b755259..42a2c047f 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -7,11 +7,6 @@
  *
  */
 
-void bass_add_stream(struct btd_device *device, struct iovec *meta,
-			struct iovec *caps, struct bt_bap_qos *qos,
-			uint8_t sgrp, uint8_t bis);
-void bass_remove_stream(struct btd_device *device);
-
 typedef void (*bt_bass_bcode_func_t)(void *user_data, int err);
 
 void bass_req_bcode(struct bt_bap_stream *stream,
-- 
2.43.0

