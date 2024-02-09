Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48686126
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Feb 2024 16:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497208; cv=fail; b=MR+rp/mSA48mpLUwRyD0J1h+AR1lsyxcrHc2h+sAtFRfhZh6adS2AcNAwAqOk7kKCtV5t+Xsm2ifiQHm1xu50ftl5kKeG8lxx0o/1E0Wg3kBVBtOti1duH9fSC/7u9pV4UnVZGDNbq/GaT2s+x87a8ATjGTGOXl9cG8uNGEYHec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497208; c=relaxed/simple;
	bh=7U1gw2BLefawatfsTkKOgZQtechyQoHuVTtaztbwxNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgZRFP5i+sJqfG+rjAlH9IPsC3bU4Lf5gMihh2oU0nbkNLp33xzHhLsk1h/zbIDGDUjevB0nixO0oKXctbapV283oHCvwCDIKQtzncbp7OgDIk4g0+IVzX3mEQvX1ZtVtyB968sluW+lkwcdZx58XbwsGUoc1mo4pKsyeUpwEto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KHQ5z/ay; arc=fail smtp.client-ip=40.107.104.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KHQ5z/ay"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5Z9d9S9Rox2Tli15IlwbD/v2AoX6tRXHOkQwTwz7VDVmrYEmRPJpv6zPGsR0jeXJ4U14uTEMjq0kk2zXGqUKnx7myWL8EyvqWYEurElf1xkC9N6Td6Zoq28qE0k6QlGDDDwt533IrDCE2owRZHVL7ZCBtzZEMzPGc1xfrkVU1qHPlenfguTASlTqcO9OtVu3853Ecgx+owsIKT5aIiMvw1odnB9up2FWXDAm034G2Ma7bb73YJwkXabSUI99YrleS1FEJrgArROekaRbb1TpMv8GyvnHwilQ0R4XRPOK6WpsNzbHgcrxm+3U5xHAvlYIGo4+SqAURS27XyJU142Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azEjJVe9b8AO3pz6DYGjsSEcVGAObChAAaFX36TDUs0=;
 b=HdY+JHmvBE/L/xn01UDQWqBposz4eP12ZYNyeTIHQyGd7XAkBYSWKVoGp+ebA4qFmsJYX/O3Rd2k4zN10v8KjqnQX6ZWwTPJ55mRHssA9db0oB4fHwRumEUu+FwvYRcdt9hx0CFh7ZE/pLtR4y/VizqZwh0yrmJdmZ54uYKw31xZxs1U0Mp7WoEQHgGm8GBM5nPzAhoFSaXwnoeVNxsRH3LkSbKp90eBRUpdKRvb1g7s9QI7mpSjckJ9q05uKMSsX/sNgk3Cei5F6U/glAsLu+YUom6TpOvdsrYYjMn9Xyg30x5ngWetuqpJNDrwyd9wH/ERBLkUHD81Ool9wRantg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azEjJVe9b8AO3pz6DYGjsSEcVGAObChAAaFX36TDUs0=;
 b=KHQ5z/ayMV5QSORrBjqiJLdMVbbIxKt1GCiY47I791KGD7TDtSr+OEuTgHetOE9e+yKiVLV6P0XQSUHiMilNcZNXBrYKsS74RNuW8YPU9G5ZuXTQVkjMM6VLc8AZq23U+RwjCy3xSlJhZKhqtLJgvNtgwL/KGRtm3xU4I5Aw0so=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB8PR04MB7097.eurprd04.prod.outlook.com (2603:10a6:10:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 16:46:38 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::bbd0:4409:3f0e:afdd%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 16:46:38 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v2 3/6] btio: Check for non-zero qos before setting
Date: Fri,  9 Feb 2024 18:46:27 +0200
Message-Id: <20240209164630.92208-4-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
References: <20240209164630.92208-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0011.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::13) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB8PR04MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: c07690a8-a7da-474e-db3d-08dc298eaf47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u70FOn+nazYdOJwr4pd9xoVRgdmDzba8QMUZItVgQSdP+j/dGJKUjWJ+qZKtDNPy27rRoDgIBUlsjhfjsY4C4j2TELafepCZLprU8qts4pE/wJvTsQxJfa3Wjj6Qzonp4pmxhVLn3IiEXxZ06MvRBsmVglNRwMF/X5hgTQZPrj1JXAKUruyV0l1VTzQM9/FyeaLDuL+bq6yTk4aLjW2roGYtpl5Ta76sWCro5GY7KeqZKFYUJXDBoAJ+0l4aOtogFooJj5JXswqnw68O7W+AnzwaCmVkA01JwKlVOMy9acPQvpDV6Q4bv10+HWdd8e5a/oZ7llM43DkzlYfXBB/U8WgFjYEeQ1ZAxshFhtu+PUHXJcMNGSzchhQF13MxrpRdyi5pxgh/iZBZpXrWmAaUfLcjjB8rM/vUDuj/TgV9oMQoxn/RZEs3m3rS09l0KTLtn8DD9rcJvjsZFkqX/UH74lT/hbMdLP5anUtXn0r+Nk3x7r0WJ4SsKeXG75xU7XlkSzJFZ901vRQcwa2mTBB7aVtVdyVswCgzraEPxUetORPjvfGqVKQLbmpjNgcC8wNd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(4326008)(5660300002)(6916009)(66556008)(66946007)(8676002)(66476007)(8936002)(44832011)(2906002)(83380400001)(26005)(36756003)(86362001)(38100700002)(1076003)(6666004)(316002)(478600001)(41300700001)(6486002)(6506007)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ty4n7OdyRLfwVNPDq9SHKxviEIge0d2wEMXZrRHstQ0SeFAQslM5NleiDzjn?=
 =?us-ascii?Q?mWpogx+9L9Xb7pPi1xudXZJsSQMSTseNwLlvbVPQjSXs2vdagvJKUR/RSr8V?=
 =?us-ascii?Q?HJDBSuk0FXpjcEl7FYdEVMEMhoGgGn4iHEWheRppvkWgsz/8SRM0yyiX0b/0?=
 =?us-ascii?Q?+/iLdIuzm98/ez3wjBx9KjSVxSVYOypO2Nyv+gsjNgTNqMqYAvKm5LK8sRda?=
 =?us-ascii?Q?qacBC6hNrJNmpK3b3+od44cavYRVGBCErF0QYYccVxvhDhxq08SxeSO3tSBc?=
 =?us-ascii?Q?AAGf6ftH+wD221u6PCbr12G4zMd02qSaHo5D7MFJ5eO0boJtjydkdzjKY5Ld?=
 =?us-ascii?Q?aRKWmy4AMAp52ZKyhQqntLwlMsLqs2uP9pJg2Z6onVa88kajUnA1pURTZUKd?=
 =?us-ascii?Q?JclOdm20Lt3dWx4FFBc/sXbtn1PRk8tUkZyy6jt74v7EwI9y6AdU/sPhnB/Y?=
 =?us-ascii?Q?xyn4MllnxOFC1ZGaJac3NALaMxggvziUpNrhHNGAtCiD2R+inNjTmFJo8NlE?=
 =?us-ascii?Q?x3FNbDaw0GEY54+94FCPAdXMT7h7/k0DOR9/JNruOvZB2BupE6VIcGYGPIqw?=
 =?us-ascii?Q?5JGAD2oRhguQo0yDl8/5GoNZjczbWooVeoQ3MgCv/iKZ6roTm23rNXiVi+ZC?=
 =?us-ascii?Q?Ld7LG+nDlSLaN7E3tcYqP781JGeRtMsYkNsN6gaVOB/ErMUwLIoOZO0eY+34?=
 =?us-ascii?Q?vLZe+LkxbzsTwgI+PXPyM23UmCKvtQ/coW+LDXEdwO+5Be09/fstqCPXoMrh?=
 =?us-ascii?Q?bifm+JfSoz2uB9GIts1SikoVAKEdiq0nK45R97xpwhlu2zhg1ukDSDRoB0Mn?=
 =?us-ascii?Q?Ol2w9iKUfu068Y3qCXrmPKf3etti4kCJJCgmcg1TjHj752dC0At6asTfcu0d?=
 =?us-ascii?Q?8tw61/I2vVPCYEU1JWH/J0geR/z1D1V3/JgAOkCcq5xV6CW8B6xWhZ0nONC6?=
 =?us-ascii?Q?wOAbp8vCp6s2d3+M4cz0uxue/IW3pqs6XwtXNLioNYKO8gbZuvGhImCzndT1?=
 =?us-ascii?Q?qvVRVCSW2tWMNbZ4JPJTBqlVAYSA6eCO6EtA2unJWScJR9f8ERIepBwigZis?=
 =?us-ascii?Q?svHufc49IfYCUqq3kVPWd7JsYLqTuaMYzw2HRPimoed0ixB4IBZwVdqHEcWa?=
 =?us-ascii?Q?h2SA65iPHERv8pmqoILd6OEONPIIzczVBPklPjuMhvrRh1LAIdw7ACdW/fA0?=
 =?us-ascii?Q?Kk3CvHgkw2Sa6zfBnMuFHnf+sFJi98myc5b6JkEt/t3vFGYCrrmZbmTLjbk1?=
 =?us-ascii?Q?64Zo5CsxYy0thUBew0j9PmvgJbKBj83KufzZ3GlXiHUhQTDYs7ZDAQ1D4Ce2?=
 =?us-ascii?Q?bRxBUdfGBoUzKfNnQRENGTaBm5q+9uV9sjrUzn7PFcfPepDBnc4clKdGJrLd?=
 =?us-ascii?Q?KL0JfIRtidOYtW5hAdQZeY59GJxeUf41knHpBoxEkp7yYzVMKXdnNI8ITD9o?=
 =?us-ascii?Q?rW9nLW0Z/IPQ+VwXZw0qBb8JqSiiwTZUsvNqxm19OGjdb+6b66WUsw3OL9QQ?=
 =?us-ascii?Q?hnQjZGVo9xEZe38X1WyWrlKg5l5A8+GbYCO/QlRSoXgVMtq1TxpVYY1CoNsM?=
 =?us-ascii?Q?SuVXgx2KGKDKcGmq/CXBLF7cUZNMnJsP8su9txrwqS95XFJuSxoct3Nu/S6V?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07690a8-a7da-474e-db3d-08dc298eaf47
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 16:46:38.3511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kiZH3H7vP3aeKvrar/IK6J7V0WCC+9koVBvQWpxZHfoFg0Alarw8tOduvmcOjhaRuVOvRKK/iVlP/H8kmjiYbSVsKOA8xEi3KSzMjJW/cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7097

---
 btio/btio.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index d30cfcac73ee..5a07f91c7d61 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -1981,7 +1981,9 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		if (!sco_set(sock, opts->mtu, opts->voice, err))
 			goto failed;
 		break;
-	case BT_IO_ISO:
+	case BT_IO_ISO: {
+		uint8_t zeroes[sizeof(opts->qos)] = {0};
+
 		sock = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
 		if (sock < 0) {
 			ERROR_FAILED(err, "socket(SEQPACKET, ISO)", errno);
@@ -1992,12 +1994,14 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 				 &opts->dst, opts->dst_type, opts->bc_sid,
 				 opts->bc_num_bis, opts->bc_bis, err) < 0)
 			goto failed;
-		if (!iso_set_qos(sock, &opts->qos, err))
-			goto failed;
+		if (memcmp(&opts->qos, zeroes, sizeof(opts->qos)))
+			if (!iso_set_qos(sock, &opts->qos, err))
+				goto failed;
 		if (opts->base.base_len)
 			if (!iso_set_base(sock, &opts->base, err))
 				goto failed;
 		break;
+	}
 	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
-- 
2.40.1

