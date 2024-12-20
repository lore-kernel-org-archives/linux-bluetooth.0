Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6F2165F9
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705095; cv=fail; b=Ekkst65p1TEDroN3Xp859k+zdgweY32Ve+doyA0TDRMVTfkbowM1ypC3gev84ypwgYZS9J+Ra8J9uUlHMhWBh027o2b7dLFmUFw4302/Y3W9OJ4KerqQVV8mbaC0RwLIQPfbte6DCzwN+5mubL3lG/hFJLSqrvigs7owPnjyUMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705095; c=relaxed/simple;
	bh=HHR1PuUD18QknxX5ly0QHnaehVaJNjgHiD/RwA4xadw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZa6XZEYhpHhYpXof+6DQypilOSb/ZlHf9up54cj+UxhX2lgTqatkBVl9HUvXM+eTN0K/WWrdVldr4fpELv/IwcrbgPeiKCn4cxdLuHWwtZv7oi63YK5ChzUmO23q605TrlwKLlozSLh76I2PSjP2Ns7PDQiMWcKQpLPJGchApU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mEElg40C; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mEElg40C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eU4CcTadSBCU4xJB+Mkg7pJnMP/xe0BGh1fYKxDBiqM/5EwNtcmwwmTDJZbHuC40moL9KAdV6pAeK5Zx+sBEQUw2BZQA7FzaOU8tLKuU+ht5vroRDwI0Ynj+Uraf+lde7zkl329yNCXfhhAALmoWVxUi8qSH09q60XmUlMr5ZyrZoxFDJ3+26wodSgYmnhfRExd9paTgi3vwfRntnWpVGHud1ghmu18rHdauq4AyN0+9zz3nBN+Fq0m7Gmxicx1sZ2EKNveGRlWSF+jodP+t0yFS7xwYLkZH9rM8pmpgpFHAkgBO6fDNsoDmotRSNkFmMec+Cbjjpdc++6Ef9J3zPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQbvYAloRwqhJU+QSEb/T+VpkAZ4czbU1z6Q5rvthcs=;
 b=XbNT+qsCqKDY21kwk4M2qvcIOoBsplJllWMTa16GFg6KzhNPeWgtW8nU8eWGy/+Cf7RuqhMmYDFi7pcSXDw/a4rOhUmF+qDeghf5LbomOEDiPri6lf9L+GNAfPeMV8qI00g+AaoRvNw1UablFQMK0bkJvEKXwIJHng8vPnR4/NFfRE2R9JCZdRX73dDJ/gmf6unrquuAqABrBn/I/OcFMhr2e1y+HITjEe1I3kaAWtCIbHjgA7sAfjIogMLVsKI9ompeHkKaYK3rKpdtWC2yswKVWTAZ1G6aLFCpiD06hfsk3OV3Lr3PQnYlxsl/+LYzMx8ygIUatMbV8I46EHSuVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQbvYAloRwqhJU+QSEb/T+VpkAZ4czbU1z6Q5rvthcs=;
 b=mEElg40CaRI4MZ8l5z4Bpwckj1kw9mBNqb63kCEVkAtkW+Nmlnd3DJXvkZI0nFJZZpKCLHpWhhCUyp3dYh4wDe8Wys1iwSEkHLy6k1I92P4ukmRt4Oc63Qz7j4VgmFGJ1x9txtqLC1zn6rQw0J7boB9rNOrFdlbS5glMcfFUr9N1tBQl6Z6lM76PSCOkCc2uFWY25oAqIZB7v8637wgEh+hH5WkKhPCLFlyuz05m8SWoSFhW5kkXO0gPDHhBDUxRwfVfBLgmaCz6AWslzoAXt1blBP75Bpa+Ic1aSkXy+nLUbxZ2hep75Uu23T09T0HZWS16+ydDpl+9DPs38n0LHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 14:31:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:31:30 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/6] shared/bass: Add handler for Modify Source opcode
Date: Fri, 20 Dec 2024 16:31:03 +0200
Message-ID: <20241220143106.27443-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
References: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0048.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: ddac64b9-8087-46fc-75d0-08dd2102feaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ln99EyAfmMtDGG7BXgi/I+04GJrAqA5tw3M8pZzIMQNZ78F8Fc/hYlmmqWbA?=
 =?us-ascii?Q?XX+sKI7FBvVdoDvV4rRJmYGmQJ8pyjVp9eYodo0XB8IgefLU3YlwruI6/KAA?=
 =?us-ascii?Q?mmBnmsuHHdFcBMIWKQecTzNCt6Aa0AgayXtq9XQOIQ4KZp/gn9g88H0YLZdp?=
 =?us-ascii?Q?xIKmDz1hUnNHdUEciv/k26gxmQOVp7S0xY5D3vNSuSa1xHy1iRZ2BEo6dzc7?=
 =?us-ascii?Q?66zRyeabM6SIuSQDACzVaysYVD+C2yPzvtudiuL2gpCe4jWLgdPjL2yR753K?=
 =?us-ascii?Q?T6jCBI/+Y1B6mil6fK/kq8BqweacAsVt7rrr3coDVYH7p9Bpq8cotbWoV+om?=
 =?us-ascii?Q?9Deq/A9ua9/gu/Bi6AVbskN0a5M4XwTeXezRNEQoRZLTngcRKVnpLaLUDOdl?=
 =?us-ascii?Q?sVyEjx6Hmq5WNo7ZZL1CCdOSrDP2MN6YAEgTXtp8oITWUJZUnAbPbWp+FQno?=
 =?us-ascii?Q?cDktQINSIbmn5E+cM9kbTN5gZiBDFfflpvOz7pdHOARV2Ngksa12szOQdA9f?=
 =?us-ascii?Q?yH83d9TVhv18Hp90Hwdhyi9EIYx9gxIfbySzi89HD9kNLdQIAd1c738ncou5?=
 =?us-ascii?Q?QHRwNhzuZkWbxK4DOTQHRW/ZJPxcPBw7HYcojNXeDUtNslixnSmjXZddMNOF?=
 =?us-ascii?Q?d7EAzU5FbNLCBAthwaVsaohh4N0kYdFQZXPOBKSRntlZAWf2KQdVAn3oIwOo?=
 =?us-ascii?Q?Yi5BKbNDhr7aFN0N47dq+dgkWmVGfXR2Lf6HX7hoDkGA9kq5dkYaFrFsHUGZ?=
 =?us-ascii?Q?NS4m+WC02h77dilwVpms+iM36OMVhLh9pamlWiVkRitf+6EIP0XgVTUCPEN8?=
 =?us-ascii?Q?AI53U0VtkzlHrOeIRr9GQObfeUISnYJm+60VZ/iTCCqhTE42Phl83XFC8/XL?=
 =?us-ascii?Q?mdNxb3H7ZyhMCncVnj6HaWO7gqgSeeOp5Q4F+JcAFMON5ErZnf1hpROwlOp8?=
 =?us-ascii?Q?sKBZOfG2nsj27mnr6uhfLQkXXQUsfVig7Ypr190XytLI8pPj2bUOxEhB133a?=
 =?us-ascii?Q?Rk0bGqqNwwi+SnMiCMsz/qfl1w4Tb5LxfdRhq21Vv5IsKy+GMc7mIuy9m5xK?=
 =?us-ascii?Q?MHGh2JrtvgV+3pOygQbrbdRFxMoleXiExoNWivmlQCHY9Ikm85D8nwjOPn+2?=
 =?us-ascii?Q?2AQS/sVMj8wsA3f9OxOHV3fJeRhtSc0Q4qY2tqlrVraaUcQofllALZ4BcfsI?=
 =?us-ascii?Q?5m4O+GOJM9C+vnjAACcDMhIFwk8Qh0GuLoJryzj3m5Gj3L+lSHbqEvcksatV?=
 =?us-ascii?Q?zE9W+/S0u0DzVDKFbeHbCfagfoRhXBIVtuFEZednjwr+JI8F71q5qw2pFrWH?=
 =?us-ascii?Q?u8TDJjDM985BKIHoEXz9geh4B161qt2fai1r8BJe5X8xIVuei0bMovsDUm8l?=
 =?us-ascii?Q?Pvb3dXjA80uhsf2KCPHVGpDYqFNq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T8rZICN77ahNVRcR7efZDlcUOBm9E5degilv9/6GsZlUsqo13H4sWKWAn+a2?=
 =?us-ascii?Q?iK/YX1B36OvLTV9dpbIGEjeYJ+X6b7JjpNMHNWpk1dxnKbGnf4BOqmbhOx5H?=
 =?us-ascii?Q?ejdFuk8OTDmAQVMo1PYtl/Zd+7PpUxkF6iDgViZQQZ5i1rjAHl5QrSvxX6ta?=
 =?us-ascii?Q?CWlZErlnO+OCsv+WtVOwwbDdmlfevSb+DbSEmMne4Z4JF3MszQc2QPzXWfzK?=
 =?us-ascii?Q?9AwrAbou625D8MLnydStWVmwkp0SKqWhlpJcomkCoMgp4uYglXXDv/rqj8EH?=
 =?us-ascii?Q?4cV6MThihrYf/aXFueKkRuCzAnuVbEFUqZjJJ8Mzulnaq76w3dM5KdD+SBhb?=
 =?us-ascii?Q?VHI96o+D94HIztlSptvV2IQf9mXMpHoxLAMgOIRZXmgFfty25upWw5L8G16d?=
 =?us-ascii?Q?lA/SdcqXvgc/8YBAzO9GA0jmKnoeYltKnIjezEutRuFGN5sAa4sOrb/QMNQF?=
 =?us-ascii?Q?5vj8tK1lIX+vP7Lo9+E0a3HxKigqjCAPueVSHydYFauJ2HxD1leKtrlk9lx1?=
 =?us-ascii?Q?o6+wLs0m2L8cFOKu2haIqYiIqqGBGFlrlpJrHq2i99Wqb1K5TrEz3u34zUhT?=
 =?us-ascii?Q?CzaASWzAAKgNPMax13zhyLkhIImqrKeccv/grJRxqhoLOwQsluVvJUxpZckI?=
 =?us-ascii?Q?GY/yXvbD6KeQCuMyS0DKZteqnwbAu4Wl808SA136QTC84FW0fxC70lPe9Fci?=
 =?us-ascii?Q?F2Nn3C4X0XAW13XNfNxLIcAz7kBZDabXHII/VUhqRBUi+yeZf+i7zi4AXgdJ?=
 =?us-ascii?Q?K/RpSFPwK875ecpIsEE740Ft8ihEn2gZbG7stu2ES1SI+kue/z0pD/Nbzaqa?=
 =?us-ascii?Q?FGSixH8Vc8P1Iypf/h3sHjuPbWvWNB3dgeYtScCUId4Mkp/L3bB9BLQQn2ac?=
 =?us-ascii?Q?hzzwy5OIKcYCMJ50s+aC31GKffxHQulj1s7kdKewKC/KWeh8gUp3WCAuu+e0?=
 =?us-ascii?Q?UuOBd4IaQXNIhRmJB75I+M3g+AI5WlibDOPqpeiyKriGfk+wn5uJj+5Kkqnf?=
 =?us-ascii?Q?jSQyZGlu81G9e37LpQNUjaRiCDKZmGAGiBS/34j43R98iWGkT9513j24wj/l?=
 =?us-ascii?Q?IDoe+5LXOYSyiGFEhqERvVioan+iyfDgxNN9LpTjsOZ74R7qQ7PIqfUQuIih?=
 =?us-ascii?Q?qjGaFib2OTjtyJ4Zx0yHFCYOf+IbNnZEARxb66r0bjUoGI/M25/RcxJt7lmO?=
 =?us-ascii?Q?45gdfN0r5CaXO1qiY6KXEDLmlmNvyy4oHLeJ+IwkbSfxEo9dwi4+lBRq4P/i?=
 =?us-ascii?Q?mFUVdJWMRCgsJvRyGGNjU4/jSCmUqXTueg/j0R6Fqfx+K8AUQagDN2andsO/?=
 =?us-ascii?Q?pd5KPF5B/TRjoP5Y9DPy7cTe8pHrqUiYu52fggmMKfcR5wPo8g3xtrSht2kA?=
 =?us-ascii?Q?GFfvsvjlJ5MJg0f8oxrcJ7R2JaVBxGTQmNPODkDM5fqU3AkXNZuNkb6fHjvP?=
 =?us-ascii?Q?bD+/DS56zq7ItqnA7ZCn9c69GPkcBFT1qT2wDzkohsAELFftQ6vjX7sc2rTc?=
 =?us-ascii?Q?U5fGvqzdexey2TKrRR4eB+bLNHYfjL1BvOSWJyUY2zEb/CiY6/oSz92Se4Hq?=
 =?us-ascii?Q?cQpBAYMiZCwL+gRCn58HbnGqVDZz4P+VTTrF5rNsXsajwLnzeQ3y4lKaIonl?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddac64b9-8087-46fc-75d0-08dd2102feaa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:31:30.5043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra8VFxmnuytk/gmsQpAovJ5F2B4bUYsPWBuZ4BtLtDG+Hsy0mhQX/vj/X163PhtLAJ6mYWX+mUtPisOn9Hqm9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105

This adds a control point handler for the Modify Source opcode.
---
 src/shared/bass.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 0651f9a40..7b9e0da63 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -995,6 +995,102 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	}
 }
 
+static void bass_handle_mod_src_op(struct bt_bass *bass,
+					struct gatt_db_attribute *attrib,
+					uint8_t opcode,
+					unsigned int id,
+					struct iovec *iov,
+					struct bt_att *att)
+{
+	struct bt_bcast_src *bcast_src;
+	struct bt_bass_mod_src_params *params;
+	const struct queue_entry *entry;
+	struct iovec *notif;
+	bool updated = false;
+	int err = 0;
+
+	/* Get Modify Source command parameters */
+	params = util_iov_pull_mem(iov, sizeof(*params));
+
+	bcast_src = queue_find(bass->ldb->bcast_srcs,
+						bass_src_id_match,
+						&params->id);
+
+	if (!bcast_src) {
+		/* No source matches the written source id */
+		gatt_db_attribute_write_result(attrib, id,
+					BT_BASS_ERROR_INVALID_SOURCE_ID);
+
+		return;
+	}
+
+	gatt_db_attribute_write_result(attrib, id, 0x00);
+
+	for (int i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *data =
+				&bcast_src->subgroup_data[i];
+		uint8_t meta_len;
+		uint8_t *meta;
+
+		if (!util_iov_pull_le32(iov, &data->pending_bis_sync))
+			return;
+
+		if (!util_iov_pull_u8(iov, &meta_len))
+			return;
+
+		/* Check for metadata updates and notify peers */
+		if (meta_len != data->meta_len) {
+			updated = true;
+			data->meta_len = meta_len;
+
+			free(data->meta);
+			data->meta = malloc0(data->meta_len);
+			if (!data->meta)
+				return;
+		}
+
+		if (!data->meta_len)
+			continue;
+
+		meta = (uint8_t *)util_iov_pull_mem(iov, meta_len);
+		if (!meta)
+			return;
+
+		if (memcmp(meta, data->meta, data->meta_len)) {
+			updated = true;
+			memcpy(data->meta, meta, data->meta_len);
+		}
+	}
+
+	for (entry = queue_get_entries(bass->cp_handlers); entry;
+						entry = entry->next) {
+		struct bt_bass_cp_handler *cb = entry->data;
+
+		if (cb->handler) {
+			err = cb->handler(bcast_src,
+					BT_BASS_MOD_SRC,
+					params, cb->data);
+			if (err)
+				DBG(bass, "Unable to handle Modify Source "
+						"operation");
+		}
+	}
+
+	if (!updated)
+		return;
+
+	notif = bass_parse_bcast_src(bcast_src);
+	if (!notif)
+		return;
+
+	gatt_db_attribute_notify(bcast_src->attr,
+			notif->iov_base, notif->iov_len,
+			bt_bass_get_att(bcast_src->bass));
+
+	free(notif->iov_base);
+	free(notif);
+}
+
 #define BASS_OP(_str, _op, _size, _func) \
 	{ \
 		.str = _str, \
@@ -1024,6 +1120,8 @@ struct bass_op_handler {
 		0, bass_handle_add_src_op),
 	BASS_OP("Set Broadcast Code", BT_BASS_SET_BCAST_CODE,
 		0, bass_handle_set_bcast_code_op),
+	BASS_OP("Modify Source", BT_BASS_MOD_SRC,
+		0, bass_handle_mod_src_op),
 	{}
 };
 
-- 
2.43.0

