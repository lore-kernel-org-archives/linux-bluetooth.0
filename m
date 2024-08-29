Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9E18E028
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925170; cv=fail; b=kAjtUkIlvs+FhVs/TbqfL0Eqa0wUVAmG9tN5LQ0b+Y6rGMO0YMGR+5acCqAfvfhb1RWxJbIpZ5csY7OitSPBMuW1qcPnZUgjhpa1tja6Vi3MgjT2YJUCgRcSHVbIjuM4K1c0JH0Stj5ipYYwDpy2TN1WqIxWKasBJ8attTehucA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925170; c=relaxed/simple;
	bh=kVnrkynjB0RwXkt9+ekJSFGmiJTCkqkdP8ubjuKdzzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C6P53MoGp1ASrDxndLRb6ngiGmg+wv44xVazNB1asdDzHDujGP8XF5v3xLaRxxmRrgXbBFxWyprRReFUcbgGrMjFqxQjlUKuYgjLcdenA9Oh6h8sjbIBC5TBlKrNF4RwbeeVagBNHqFioqbAR9l2fejtXisoHIrdbS71UtQIJ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CBVe3DP6; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBVe3DP6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EhK+GK4Z0FIzCy7AXFX4i1pzeKzu8lbmiudCRbrPE4P2EP+E+ng8iB+fLDo/nK/L7Q0naLI1YKK8cPG7JuNb7EDemGMWxxQjZmbkbasxGeZxP1VhbxSp0as3WKYU479+upqbCNzV+JCl/M9aN3G0EXinYCQcaxrPi5DfAXOrCiuVUS6vPwErwgUx5GWhadUcdIj8CzVgETFKI7/7MWhQgnkuWuTCqlBVqyhLZeewPGOOzlu/kBBOMSwaOjBFKCowf7NYKkL98R2SvNFTOlmDtlFz5+ZV/NqSHU+XEbE0sCynbfh2k0McdBtzsIK2YGeP4Q6Aounp4yG8gQSgbQ87fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8czvwetVNcxQZXV0c0IdS3aq7DZRQ1v48PiQCmkttvc=;
 b=nIMXJTPIoYcB4eyb9jRzAs6td/qXhcFBBI1+Ue+d5t7TdJEYBmF9pxJ/SE3y+KhutJ5iVDs253yfihlLHBjT9T2kaC8DqEk5NHrJSv356+6v6dQ5ymTe7zVKwPgZenxfwFqI6blagMsjy9hAWQWGAvDTgu6vP5XJp1viLqKBpUqqQeEWob9p2D+CWaVa5esL+20GwLcBRvqhyX7VmC+ttOrxxkr25b4lNKzPbVYt3/Y0Ixn/oyw1DGRhyH7vF7APzk4rtwpmfPfqLsudLBAY2hDhLIK7SJZlNXX2H6ItJZ2e7y4ahT+dvYvG1k37wUenQi6hEAjMbAxNxLKkme8WSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8czvwetVNcxQZXV0c0IdS3aq7DZRQ1v48PiQCmkttvc=;
 b=CBVe3DP6u5YET1At7gPnzk3R/qQ6VPGAD+6ALR23nSCBO3EkBUeSs4R5NUupoJjDt6zjvq4r0A+aNawPXSabCaNdygX6nHToqlk5u+drXSd+6lQ/ULNxDYlNqCddERb9PRW/g1SIw7rsvqNDeZs2TlbjB8iXpc7nMHATzFtU+MbgbUsYqGJGEVyAiKovXh8PjpuyAQ3ZeW8km6cG/mu+ZJMlStf/zW+OXWdsIZ7lpcn2a+QELDEdxiJ7cDU9rqQFdxXgnkAxSDzsw0XIBZ/Qdo6VxlEzyn0HSGEPLNh9CofBsIEfknSa4Ff94OHpwCUlhQdIeGyCPUM4XqdIeprkOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB8733.eurprd04.prod.outlook.com (2603:10a6:102:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 09:52:45 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:44 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 5/8] transport: Add set_bcast_qos method
Date: Thu, 29 Aug 2024 12:52:03 +0300
Message-Id: <20240829095206.91150-6-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
References: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB8733:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f37e0d-ac00-4ecc-d241-08dcc8105494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+OT9XoVNrXSp2URYRk5xyX5uHtNazCX/Vq7sRPyoXNK6Ay+gERhIlQZoudw/?=
 =?us-ascii?Q?a27czYJ4ylNgXm06eMwverJovQDuEzpMm2miSYHlx4e3jAEKRMFrdk33b1MH?=
 =?us-ascii?Q?CdEWkeus7pLqnTW4DV/Q7VLWqtg7HFGxXGiH0gJdjFFONAolgJI7vdPqHe7B?=
 =?us-ascii?Q?shzGlx67nG7f1EyfxuQ6YFDvS0MxAF+2Y0Q9DP8/QtuEYVbzEbFhXHVob6N/?=
 =?us-ascii?Q?2pOGc/wdRerGc7yC3gt4HKTvPGt0xM4AEzGTHx42/xRcibrJZBaKCRHtF21R?=
 =?us-ascii?Q?tnfoOcC88VFdj5d7qnlp+/CKgnaAby8NK+mikfyr5qqRjIF2av9v49odMk3F?=
 =?us-ascii?Q?/fNE5OQZGwKnIXzUGH7wT9RFmGbIUSEdgi4LhdFxvULdV0teRK6RjUJMWs8B?=
 =?us-ascii?Q?aJ4kAncSOva7ASb8r54nI5RK+XaRfIiplnNp67ACpNbhgfLbjH4Y9tGo9k4i?=
 =?us-ascii?Q?l/n5eR9g1UWzwLpcdtNL/wLjEE1lPwzWaYnHus8ZJf7EJRRikbvKsnBp6/tg?=
 =?us-ascii?Q?BfQXKclN/bMhbxG5SZxHw7kH17pkZO/IUrMuGAgXK7DCL8JqSEX+Uk6Q6oza?=
 =?us-ascii?Q?khQy8bzTc94PziDlMbO1IF279BG9xJ5RJEdhahmiujH2JbmjXu07K6Qv6o9w?=
 =?us-ascii?Q?er9HNStWLeOtKAM79pKIKjSQSXTYPhZLIq7hEBlkwTaUr+kTwOS/7J/392P3?=
 =?us-ascii?Q?SYP18ra3mCz2WcRkDEZ6wqP8XjhMGkmCPGbeAo8q30L4tNg5FaG52YdcpJnj?=
 =?us-ascii?Q?tGYGXI+6xwWKS/O4klewaOaatSpmPT0wZdyJTyorzfzFToWjwxysM2fNLsgN?=
 =?us-ascii?Q?Tw2xE8azrbDJUZ+/KUXJ9sAOZ8ADAUPytQzAHSKQ3ZfI4fuPGBa7i3QhEcrd?=
 =?us-ascii?Q?E33WcYsBVOgXEMTcAlomGkLXbXmAoYiNvvIGDB6n+p+stQSB8Ar+hFxxXjAe?=
 =?us-ascii?Q?bnWIgw7qXlYu5JxCpDxrGj+Uocg5nl59nElXSBHEn9dEXs+4pWsOdBL3gERK?=
 =?us-ascii?Q?mpJ2LF0yMA+vIc4QzHmYV4CIS4RtTymf7LV1spc8BT4NdoXqr4oRfbBkSWU6?=
 =?us-ascii?Q?gVLNLWWbYCPexkreAVIIaCVgBEsdtSii5K7Vf8rh3D38H6tB2blqmwr7miAV?=
 =?us-ascii?Q?H9MzbWCX1EwYIXWjVQPKxGqHpJmqmKGKT8owmfMvauOPGKtCJHnIMj9cVOwI?=
 =?us-ascii?Q?k01RLKZd1oncPa5uui/LYjLGCESIx8PeoxsTdqbe/G/T2yjTFuMezlA+yGYb?=
 =?us-ascii?Q?7P/fF7FI9Fv/wuzyphnbDyaM80sO63k+BP0gzexn6U43vS+1YdbBzyU6GkPm?=
 =?us-ascii?Q?7g1+J86TJRvJlEDPgr6QEroYXHUtAVLWPrmbnkJEYOcsbHYT7FCBZXKm0ck2?=
 =?us-ascii?Q?Et/Xv/GtxgPWhjEvnwpSlrDNZ/y4FYx+6y+agZnI2daDa/9rJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spyTg63PWk9nor6hR8wT9+Opz81wn7OpeypHtv4ya5nguT8qtZf/zDe79QTO?=
 =?us-ascii?Q?/Sp7F04otjS0uyClf5smpxq7kJZHvOaHPljHqCslpSkk2FdzBjMXkeH/LEC+?=
 =?us-ascii?Q?oxPiSvCSI3MPiYgfhCETe1kapXtClrfikqN65w1ULoi0zwVeZZ+0dMqBbiDc?=
 =?us-ascii?Q?sDeZl1hpfVtdDSDpZYCE765R7mT9CgKplNhV1zRLEul3TyZB54Y7rTSGik/Q?=
 =?us-ascii?Q?D3eu3p7wxJchS5VdlicPUGNItRnejYB/JzHkudMDFOHus19buhLTRxNY429m?=
 =?us-ascii?Q?pRJqFYQ4ZxNKdmyImQ/Pdu3mpBFPsc1CG/0+FEPH76eocDAYVadxTWuMVpmE?=
 =?us-ascii?Q?I5vA5zxjsefYsz8uzwwJqvlEF6Z6SAs4vGbFr06OP0KFMTqDBrFx5rOQfS4B?=
 =?us-ascii?Q?t1HWgCdHuyMoZWbxlXgIX7QpyWlC+I99zojLEokNgjQoHnqhwWp383toDI1A?=
 =?us-ascii?Q?4h358uCH26AaEPWBwAsX0sa8vu3Mlk0wxNPhpnCoqxmADOT5/KNfAS/+nuC+?=
 =?us-ascii?Q?TreAUG2UTwUq44vDfrnTb+geJBtQKwp9HhsOC8fn9ve2JiJmjC97NvaWN8Q2?=
 =?us-ascii?Q?FpXEhDUDfFtFBbfQumc+LmWOwYFnPwGlzdtasZ74Fwmz5DskOfvX9ZhrW3j1?=
 =?us-ascii?Q?xKSOMYWp3uB0etvubmKEmOL+Wnd/WqN+ji3Qdk8WEHpGLHClbThteyqUQNa8?=
 =?us-ascii?Q?nOTdaIaoqZpVUg5cT7osnQGLcpU9nPOrGk0GPJ70VU6MgytkmRHdhqcPOTKR?=
 =?us-ascii?Q?QHaubYFN8nr3/pyI+CLbsRymrmCTe4PNnDO/OgVDByeJfJZTQRRYg6W2snjE?=
 =?us-ascii?Q?jq1PLWTKzT/LTl6w99rcvIlhjWC9JZbRPGc27dWmTuD4puNLNTUuZnVonuyu?=
 =?us-ascii?Q?Bb7sIgfD6eCPPQLy/sXYKIz5E6akFetuaS8GU7EEA50wAfFSB8jhs9aqXZUT?=
 =?us-ascii?Q?3OL/mRbsId2c0c+QEImmiwJw+WzPwkCTFpk99GbrIjJLjgYBSrPucObJo+29?=
 =?us-ascii?Q?3RJ1W2TmrLxFX9kD6BkpQkTeA29am5GtW9qhZnuI51r3HuJw/LEy7l0ZrUIJ?=
 =?us-ascii?Q?BOdkU60gdybl156D7gH9gOeLSIYrF6Qj+DjXSNrjI712ACCH/42pujvRqh08?=
 =?us-ascii?Q?WE0s0s2H8hSepAMcndnbindlia3bMtgA5Kmhg9hqz0208PWrTjU+4ZY7bZKZ?=
 =?us-ascii?Q?s5j3Qf3qQoz2TgdNmM58Gqz/CVP+mDVtU8y3qp2tQX8PFKCq0+iXjf3A4o8A?=
 =?us-ascii?Q?Qa14U/+NTmuY4Ff03CkRJEZnalh/fz/zDibozs4QVcA/LC4jSG7bTm9FwXDB?=
 =?us-ascii?Q?VkNYZElkWJCTDWlwz1qi3xaPHOC4wNnOybLLxGA2pU3LRG4yXcWN4lIpZb2l?=
 =?us-ascii?Q?McsCQnkcb9s7WwEOAw3lcna44R8M2b+cICDFnuCpaYmndMuWjMDRh085vG2K?=
 =?us-ascii?Q?Iba6yjqCT6PvnKxjGE145iGRDk66Has3A8XWoR8L2XSXqwOcTrMNVuLYXe24?=
 =?us-ascii?Q?Q60oVAQKYZIju11QlAJUQxzZKi2DjeQA7yUs1YQvaSjiUx99N5FWpWdpKRVl?=
 =?us-ascii?Q?tNDtrJ+KmOitz/2qlc/XHeeVRV7Y6xx0GZw2isnL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f37e0d-ac00-4ecc-d241-08dcc8105494
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:44.5801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5y8Nfiz5hyWlUdf8cGFDzAv8o/P25FeE5vmKNWjntG4mWe+9pBIr9Q7RchluKWGshwS1aWylNMgHnm4RE99Xmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8733

This adds a set method for the QoS property of bcast transports.
This is needed so that applications like bluetoothctl are able to
modify the QoS (for example, for setting the broadcast code).
---
 profiles/audio/transport.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e8915490d..c4b6ce7e3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2006-2007  Nokia Corporation
  *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -1208,13 +1208,46 @@ static gboolean qos_bcast_exists(const GDBusPropertyTable *property, void *data)
 	return bap->qos.bcast.io_qos.phy != 0x00;
 }
 
+static void set_bcast_qos(const GDBusPropertyTable *property,
+			DBusMessageIter *dict, GDBusPendingPropertySet id,
+			void *data)
+{
+	DBusMessageIter array, entry, value;
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	struct bt_bap_qos *bap_qos = bt_bap_stream_get_qos(bap->stream);
+	char *key;
+
+	dbus_message_iter_recurse(dict, &array);
+
+	dbus_message_iter_recurse(&array, &entry);
+	dbus_message_iter_get_basic(&entry, &key);
+
+	dbus_message_iter_next(&entry);
+	dbus_message_iter_recurse(&entry, &value);
+
+	if (!strcasecmp(key, "BCode")) {
+		uint8_t *val;
+		int len;
+		DBusMessageIter array;
+
+		dbus_message_iter_recurse(&value, &array);
+		dbus_message_iter_get_fixed_array(&array, &val, &len);
+
+		bap_qos->bcast.bcode = util_iov_new(val, len);
+	}
+
+	bt_bap_stream_qos(bap->stream, bap_qos, NULL, NULL);
+	g_dbus_pending_property_success(id);
+}
+
 static const GDBusPropertyTable transport_bap_bc_properties[] = {
 	{ "Device", "o", get_device },
 	{ "UUID", "s", get_uuid },
 	{ "Codec", "y", get_codec },
 	{ "Configuration", "ay", get_configuration },
 	{ "State", "s", get_state },
-	{ "QoS", "a{sv}", get_bcast_qos, NULL, qos_bcast_exists },
+	{ "QoS", "a{sv}", get_bcast_qos, set_bcast_qos, qos_bcast_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
-- 
2.40.1

