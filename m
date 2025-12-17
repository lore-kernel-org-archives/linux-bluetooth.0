Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020078.outbound.protection.outlook.com [52.101.201.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B8270EC3
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000230; cv=fail; b=YTl7aSZQ3lMj5ii5ChAKWncG3o4xATa2Xmg1za9IVPeVcSSokTm5ec84YTEfMMGBFrESM64WjtknHrCaXfiaUSbZQBOdJoUzEJZWdXqUb+ntr7hnGmtsvdrw0EkuUGeWk0ORD63rttrr17cLGIse9+cfa/5fvK3WsJntxxcyPfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000230; c=relaxed/simple;
	bh=pEF6awchURoHX3r/hSohvdG9zwblYNfPGukVrfh5Hqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qhEr3AIY0y2WFMvsrS3xxn9Nwb6NxV8JLKEQzYykmZZpy9UEVZdIqx3fHHSmbMQQ+T/0xfx5+F0hbsEj3o7LIp+I5RnwJTAen3+Rzc2q4ZP4KOcN6yCzZNPqgWSsp/8n5Te7PcEgqwO6cU1TjlTzWrdprpW2ipEWw6SljzpLWtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=BnJ3WMkJ; arc=fail smtp.client-ip=52.101.201.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="BnJ3WMkJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgQDrstlwP6zqlIpBTR6QtUKWfltMc1lL6XJbgtq2+GLuMSJFkghKdxJIzPCDan3u86oCQTgdSvqD9hFSTU6LG+r4iSPvElD6PiKszXelrtr8B8TB9L7m1ksnxBEEuDSmBF1aCSy8sMpxgIXWaBJBWbsOaMKeZSwiHfnhrouyx2qO7ugqPhclcmz/1vt93Lrg8wSuHYb86WCN7YZ3pTyjuxFrJW30WwRuQicmyHGqhZttox8WdkoLg09CCLAZbpKfJdHr+qqFH6XOGlLj4b3f32uHNffylwclPV8iRZiajbXoXOHwPDiw0B82GKFQWV+xYKoJSD2UkuZyEHC/O0qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZZabgFUEmzbRQHywyW222h+LPLsEtVpvUr6OYPnXHs=;
 b=Enx2ymehr1Y8Qeb034unZsUbYa5aQAGkDYKG/MDjBfK0siqANsI54cl1lIgBgX5qBBvNZxUWocZLxlTpFDvrMtjgLPRH6v/9Oq8Dg9h6av3WGMnboNerpKTHfSmwpkNklJE3iIQ2Q1Ms2IZ1aQyLldlHflWw44nl6S53aoc1VLZ8YpHVo/OFwzCMXsPTUQD4AeSW8zNVTznMJ7KSFfw15LyFfcnwsZwLANg9YzmmFgEQGHMRMZJgtDXML6ssHdtz/SeF2/l1mVk1FQVHRBQdLTTN4swCnX6rf9ZQ4dbxpHIjWs/h2Dal177ErBsfb1ZrzVmwM1FWNni9Jc/Gv8+eiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZZabgFUEmzbRQHywyW222h+LPLsEtVpvUr6OYPnXHs=;
 b=BnJ3WMkJN2X69wPI3dI3KVnfPOLimBEgibzU3OeYYZu9n0L/n+CuMmvOYZXV9BE2aR2FTjIjv5BIk4yGfWvp94vt6MILXInZgoQ0/dNkTh1WZUV4kjTza+9hKuTIw7wpdfEaIOq599+mXq7KXTf/+VOXBw38fYKDQstcuYCrj+YQsTkfoKRaeGz3BdZMzY0OEvbmqN5dlC07G4Nonvs0H8E7Bzefk9nOoni3rnhRFtpHy+e1HNC3+Yyk5yc8YKJJ6gZB5uf1xcQn+0raaknWVtlM73rbC9ouNYkZYtt5AKCb4gqOWlsCjTEBxLlwZbbOjvKzWzz95o+JthuLIpTGYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 PH7PR01MB8665.prod.exchangelabs.com (2603:10b6:510:30d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:03:39 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:03:38 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH BlueZ 2/4] adapter: Do not send empty default system parameter list
Date: Wed, 17 Dec 2025 17:02:54 +0100
Message-ID: <20251217160256.441737-3-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217160256.441737-1-ssorensen@roku.com>
References: <20251217160256.441737-1-ssorensen@roku.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:408:e9::6) To SJ2PR01MB8282.prod.exchangelabs.com
 (2603:10b6:a03:540::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8282:EE_|PH7PR01MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: a693d645-455d-487c-d7a3-08de3d85d742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2lKk+Dsk/7K9VB2M9JMq2UgiZErn7+anhPX+VXsDQs1mXZdUZZvFwqFQGP9e?=
 =?us-ascii?Q?xtcLk3RVrDUksDUiys3XW5CEcs6BaHcaDTaKSHCc+GAn7qP4/U5oVsCRZGp9?=
 =?us-ascii?Q?K4LE1ID/tczJgw7BWGplTzXzN3Oact3sT1HHGulZgovg+Rniwr7VPFlf6lKb?=
 =?us-ascii?Q?izep3cIGQGar4mRrzVnd963YKbmfl6a1kCeTQRDn481n1uAgP926J568Fu3h?=
 =?us-ascii?Q?lgKUkMoqaH95xuTi3zOBhhncE2t3SFtNapqVJ8EJsPN+wCQ7FbWj0Q4KraJ6?=
 =?us-ascii?Q?7vdMGghI5357V3e5ACNJHsZfQnjfekyynrNigiuHDf9RBiZGbtUfzSgZpYZ9?=
 =?us-ascii?Q?/3kOt/Rb/7qEFBhaMJOXKRnkKZOERqsOdCx7qiviKVNtM5GrHhMchJD1gFkD?=
 =?us-ascii?Q?UdFs8gkOs0vHEZ3HXvTvwdbqBnaGDQ2jPfPsUo4sfOF68tIeouS6bZkInYhn?=
 =?us-ascii?Q?dqGZAGhzQ7NXmAWnbUisRm6LSpYUZKlpawW11j6URIxiSd/oUkkbqWNr+zzq?=
 =?us-ascii?Q?TMWY35nGH/htnq5xmmS0IiFdWSblP1ljyqUxU9DfkKjjIPqrulIPuUClixFY?=
 =?us-ascii?Q?eC/VKnKIO5cyyggYwsHvCRm+8xarYtX9yAtrBuQUIKhDLwWtEx76/tys6oij?=
 =?us-ascii?Q?QwuJo3ider9f0GvVtRo8T21p3sew+vE2kw9pmoOQG3cY2e9TfYs3ZttJyixb?=
 =?us-ascii?Q?Nw3KcRnmiJLoCKZZOk6ZdvaKqXPhaPUjEg+0/cMLVH8oP9Agg5ubFA7lhOgV?=
 =?us-ascii?Q?JcJWrGze1BHXDMElcrFid6qrEyO3bCmCctZ68bRUhTapDAwMu4nJxHzzngDY?=
 =?us-ascii?Q?VHYWGJtfYcsi5cvq4/lz6jktyXTr+2kM6fFLgaVDRNyYEtu2OwBqrZ4D1plN?=
 =?us-ascii?Q?VNfekA8+G4M/q+/VsZkZvKUqKkvQdWW6WSjc+uID5A1p4uXY31rxTz6R0Xmn?=
 =?us-ascii?Q?MZ5l41oE02FKtwt4PoTvOrAwdMj2K/4IVP7y7F0YfGo/03PsKr8On/Q5QenN?=
 =?us-ascii?Q?8d18XI32MdMgTAzrGYRoPTY94+KX6pPi0PczcK7f16w5FIbToX+qy5CrGMXa?=
 =?us-ascii?Q?ttJFub26K6j+PpgdTb0JMnJvyVW8wwSFbeaf8AyO3SyzwyEBfT9GfwwukWyD?=
 =?us-ascii?Q?iHAsYIpkQ5SaqYSbuHCpIULO++8CgS5eVxC3xR1QoONOHoYgF92sT+Ss1ir2?=
 =?us-ascii?Q?2qEVZJC+ZeRqGqAIrdMswNxsOpmSQEW0LoVMytz1UNd/3TTN1cmBOZ+jY9pd?=
 =?us-ascii?Q?/6HOZrezSxG7+Rfnr9neOn+Hpxi5/OoH8a1spZ8eMU2ekF4bgubGLtsi45/R?=
 =?us-ascii?Q?w2W2VVFgwp1xxspxDRDgGR35PyNeBLg2/3A0ktGBeKuFd/VSh8oMa4StqOwN?=
 =?us-ascii?Q?SV4oztAcDQiRnt+o/El0cdkWE5NDn2IvVfv/HWBjLuWC/zEBOFjP6NkyKZR6?=
 =?us-ascii?Q?RCp6uYlJY6GYyEEqZK95DF0IA8RFbriN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XHH0vMsRvSTQMXjQGSqDRo3yl7yUtBokNIUTXgfLgjuuHmNWl+M9IeKFjLK?=
 =?us-ascii?Q?pPWf94a2PdBMvGfMAz5hc+EDX+Df83CQLXOb5rzcGuFxcb7w0ZOzOFzi4f/Y?=
 =?us-ascii?Q?aXZ/zloimhDtRsG1DsIfz6Ij5OWJgkobqN/qWEtiV9nt8fOdEWUiyRNGsrp5?=
 =?us-ascii?Q?IPHwhNZzynaUmTVJYMJcjyqz+GDXm0mrtv0BPIubVhEV9sC+vBct/Ismrp6m?=
 =?us-ascii?Q?29ZGp3imj4Jj/FzZMPL+k6embxEUDb0PYKmGHqk8IY8Zbz8LSSMT6P8z+cbP?=
 =?us-ascii?Q?UnHzIlxsHcF5ss04L+3rnjUkVXJvYVrAHOomVf8gRbaDMKlleqcp00Q4h8iL?=
 =?us-ascii?Q?I8qE5qZ9/tj2IRqNXfz9uNSEeUkltl2d4AqvR10ieKbDqjNJQvzjNqLkkDuu?=
 =?us-ascii?Q?xbvCYn1rWTqJzcCOLPYCHA22jencIBKeRrlPvyyFfK+/4DZK+yKf0hHYfam+?=
 =?us-ascii?Q?be8GLnp8o4nPatHNWrEoAS1hsumd+UERXkVvYNRkWU5rJZF0EkArp+pxB0cf?=
 =?us-ascii?Q?PTc7eDnW3qnTwooJwDSS53SjNO2PvR05ALYWvL4ASzGmVvMzPKnZ2+B/bYnN?=
 =?us-ascii?Q?pcyHxd0gKDMV2a6B8EKEUI+01hdpUDx8hhpPee1fLAcQ6YTb+emWJtPdcBQJ?=
 =?us-ascii?Q?lnIeizcVvQTFd8/mvHdzxQEk8vZNrxukaWIidy8khylXtOhvig4fLDUH9J4Z?=
 =?us-ascii?Q?SZGJzH0nPyIagPpWcOzlYf8eoeYaDJ4kZr2LYA+fgecRSIqUBcTiwXZbDiWE?=
 =?us-ascii?Q?MkRrbwwVPqWec0GHxOAQl/fRaFStsPNSQP2PzuKjrLJPU3AF5vHyRnFE9Uv2?=
 =?us-ascii?Q?O4VO8VCqpC7wYJDDpVhbf+PjbmdJ5X+b08VKJ9bUwXEi0UnuZ8FbDIeqVqc1?=
 =?us-ascii?Q?aqTxneuvbqNvmTcKenxmEdcUXkUz5beHY1OT8kphGcV+JIhMKXBgxr7mguNG?=
 =?us-ascii?Q?VuqTPeDdB/DX078jpnh9lg72HS5zk2vZZGp9sdliTrtoYenvzwS4NO+IhX0p?=
 =?us-ascii?Q?tJijiXEa7UgDEjdopfXpDEcnxlL4PJxeRRJ4xReN02ueoc5jxNZB6HfWPCP7?=
 =?us-ascii?Q?FaWB1xGoRZcUHxoS9iPkSSMcRJmnR3oL3I9aedvQBP/+SvxlhNLuwJ/iDku9?=
 =?us-ascii?Q?/N2/8qqvA/xqY4h0lYaN/o68ZMavVtEbcOt7QAnmUqv20OZqeR4bpX6J1rS8?=
 =?us-ascii?Q?0+6JNkCFd5qr9TO4tHSP7jVoirVFVVTkOCGL7UDRL0hU3DCG3yvY1MakAyo1?=
 =?us-ascii?Q?lFcyPrwBu9DRj4Dc+vlB9twYTKvXdMJEluvllqxd/e1LuC2FVvx/Ha0nILiJ?=
 =?us-ascii?Q?wXr7FaWNAoxzXKfSqVexoCzU/iUG5BOphj6tIiwHHXKamDz39VEhdjiz7xtV?=
 =?us-ascii?Q?PF96Br/2N79u9jBAKwT6HGxVKcMEgET+YCAC2prwbAIbZ1o4+216ItFBtdSc?=
 =?us-ascii?Q?rMLRz9FnOLJK3U5Hr9OYpMcrDG13SxGBoV0n+Vkbf7jaMyw/AbeoMxULkUWN?=
 =?us-ascii?Q?kJgZT+Lim7I+z9HeG1UwjaFoGliT2o6KXXfFYDsVB4qYXbGZj05iBxtluoBV?=
 =?us-ascii?Q?LGnIgB8Ac3Fwtc8P/rbEmRKHgyuVYqGEp/TwZa7f?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a693d645-455d-487c-d7a3-08de3d85d742
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:03:38.8655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6dI88t6IYf8Dw3VIcmS9vi2AfRdrhmZlveiMW78iLiR7s8dtDBtJX6U2Bv4fClM9fHL1MXZBVJBoOSJ2fJOdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8665

If we have no default system parameters to set, bail out without
sending the empty list to the kernel just to get an error back.
---
 src/adapter.c     | 3 +++
 src/shared/mgmt.c | 5 +++++
 src/shared/mgmt.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 445203463..924cddf3b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4957,6 +4957,9 @@ static void load_defaults(struct btd_adapter *adapter)
 	if (!load_le_defaults(adapter, list, &btd_opts.defaults.le))
 		goto done;
 
+	if (mgmt_tlv_list_size(list) == 0)
+		goto done;
+
 	err = mgmt_send_tlv(adapter->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
 			adapter->dev_id, list, NULL, NULL, NULL);
 
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index a5335b978..6a7eb5798 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -686,6 +686,11 @@ void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list)
 	free(tlv_list);
 }
 
+uint16_t mgmt_tlv_list_size(struct mgmt_tlv_list *tlv_list)
+{
+	return tlv_list->size;
+}
+
 bool mgmt_tlv_add(struct mgmt_tlv_list *tlv_list, uint16_t type, uint8_t length,
 								void *value)
 {
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index b413cea78..2629fbd59 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -36,6 +36,7 @@ typedef void (*mgmt_request_func_t)(uint8_t status, uint16_t length,
 
 struct mgmt_tlv_list *mgmt_tlv_list_new(void);
 void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list);
+uint16_t mgmt_tlv_list_size(struct mgmt_tlv_list *tlv_list);
 bool mgmt_tlv_add(struct mgmt_tlv_list *tlv_list, uint16_t type, uint8_t length,
 								void *value);
 #define mgmt_tlv_add_fixed(_list, _type, _value) \
-- 
2.52.0

