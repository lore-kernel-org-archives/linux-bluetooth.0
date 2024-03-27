Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255D1598EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547400; cv=fail; b=Ih5mfKc+xrFheaYaD0yUJmfLpMUS4gpoVEtzbKWGIr2xjQ5YAAiuMezUrt15SzHUvxnC0NerfXNK5hzIfBZCk3modMJfoX9+U7L2IXGQI3rR0CA2uUuGh5QvkH9aBvheFpKJ3xpBwWGjXGQQZdJ3yEcWZcrRZyHqtI+LR9A5Amk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547400; c=relaxed/simple;
	bh=UhTRTV1dzeSGWiAkSK6SjR3MmtIU2UN3W2Q4v6QFbSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElK6tiBT9dVlqBq/gZSqj4BUCYAcWqxF5e2SrvBUHp+UT9EstxuTZ6gTojnITICkmDBPOvC6iYxt5X0+OyC1uVxi8gL5sSUT/l6Uq+UMC5lZ8+jzEHBB2t2OR55Q/533RNaE58bfekM9yisuPjdd5EetpeOq+HLSpFGLtrDc8Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XJZy4Ihn; arc=fail smtp.client-ip=40.107.247.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XJZy4Ihn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBGiTQ7gKS4eVc2t76K97omaAelypJju5+YxB7x0VFComhLYF9ZTo+GVRJ1CuWjqN3FVv+4POoEVve0wzBEP3a6CjM+mv+WLThf9qg9kCUYJqYa3wXKVymDwoMA/RMkPXvujCDhYqCECGke34KXi7nybm4PATR643Qqn6FdgCKznBIRK2zxBvNngxNqkWZjJajAHvA9pWIEgEd8Bpu2T2SdSs8acViLBfOC42dwQHznTOexqPva5EQROv0ojLKN4/tIowWx0MRPUjLdfpnbLLWgQqtJdK62vD2nedEOzIzaBRAK/FPABuOGuwUZRIVNAKGb2MBGeE2SrPHzrhrbPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1zf/CpVVlm1k2Ybsivr3YgYeEuPi9d7g3Ks34nnlts=;
 b=fJnf/s7nsnkbVcIVNC4gfwLDRyW26mh1aaT+vHm6WmB/poOPYtVJq3fZiP5pyN2U1wyAv2zLgHCsbgX23Ttc4S3o47Vgie4lG9e9qsfcmc4Ws0dE07uloDAO/R8YAhbLrIjLQnqViBoYG20AnZ2kKow4Fi0FvWL80bQWemcFZ/8H/5if9lqMCthsBHepFb3KUi2t5O7PVnWNMVTbVTolvHmKwmX07lXSn34LYa4D2P+9dtt29AGwM2kNPfSjd/5Yfa8g66VghrTyASimpV/5Co4j2NcB9TVzKA26iFFPwlbwRScIY09brH5Kstd5ryV3BBk6a/Ztl8Hu0sXSK2FIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1zf/CpVVlm1k2Ybsivr3YgYeEuPi9d7g3Ks34nnlts=;
 b=XJZy4Ihnbj3BstsfzJHYbXhazD8dmSbEuNdIWHcuLY/S83EAxwJDqWqT8hw/tSaUgXPgs6txozEa/HxzR56fKuD0nZhIvgmUpBF00N0v/o/bVVD93r3lh4LAfZgNebwy1oTSFt1z0+YvnprTbaIw/hmp9b0wGqi8QCDp50X3t8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 13:49:55 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 13:49:55 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] bap: Fix MediaEndpoint prop codec for bcast src endpoint
Date: Wed, 27 Mar 2024 15:49:47 +0200
Message-Id: <20240327134947.40229-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327134947.40229-1-silviu.barbulescu@nxp.com>
References: <20240327134947.40229-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0053.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3e::13) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAWPR04MB9959:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6d1047-ad33-4d11-98f1-08dc4e64c8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KFw4voEJ45aaD/Ob5H7Ivhx4JGWX0FBK1VmR1/CMm1BmSOzeYBQsDQ92BKqLV2FgFS01fXVwzTYRfUqjQvBnqs8VycCmKjzM7ZbD7ibkjRkDFuCuilu/S6FQ/nruRXo0bMZL0wPTqRB5LzZ1+7v6DAcAF4Cu+OM3zZVbKcGvVgEYj+1bIDlmgYcHihtrp3tNROZo6Pet7M+Lomlrkw3S57u7QdsHaxoYeKshnNdViCxsNQti+nYcHe+gTfSQlWR+J27mFrHQzbT+U13md5liBHGH7bkHOuBTHSGj0NakbXoG2oQmBhbwJmTjcCMVEZ8Kbp+cs+PhlEauGn8loy2BmpZwfT0LQiV1Ne5qDUXRifCHUx0o+ArBHFKjZ7irwACPa+4+l53G0T2UyJ53oI1h73vQ4HuqUJ522u6hFx+xSzmWN654yIIB+0xRXkG5XdwWWGCSEPUrok5UbcADjgjfa/J+TpmVx9m7wa+72hLdnpa0U+lI34WEWUZnzD0o/bpF5iU/IPn49LpaaxeiRTP2Fxs1k3oNhzOv6b+i4NcmVW1bCyPnKmCKsbAzyDP8MwAUigmioFs2ITQw8/A0anXGWjScCm8ZfTm9V11b7xrLW9YVgzihvtgu/1OW8xC/JiPHyeUJNSkzzr6eq5LlYP3fgSUMm9U5FiKvUz1F1SnozXA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vTEz/o6e9VUlK3A03pKI+GItbXHiAHC/JuiCgRkpnp0g04McrOQ3JU/qYrTM?=
 =?us-ascii?Q?bVhqnfgKCLodkXF5nxZdQiV26g2IkPG17YTn4CFc6hK21Qxp4gjX+U0N0KJh?=
 =?us-ascii?Q?QbULTXlYqrxbPcY7ANkdHhjlmLYa4gb4uxJcI9IzGaOwE+xObTzThYjqttuS?=
 =?us-ascii?Q?tbXUV1GkdqBQPLj5nzX4LAktkfcH9ppTStBteHKcpi/wJC222y8Hs/a/Bx3d?=
 =?us-ascii?Q?pVRaulIK3sLbeGf8svWRHOTsY4kNbEIekNhLZ+dtCM8gxPKwt3JKg6O6olLV?=
 =?us-ascii?Q?kMciCynVp5KmBVFBWt4jQHSx0CG514Qgqf3Xpuv9HJzY1YAARuY6etV6oL0W?=
 =?us-ascii?Q?aFltNN8VI5A7JElzZ/aqxrK+C30cL97n3py8kvcq1LEIvdsO++b5krDuENCH?=
 =?us-ascii?Q?Q8JsBW4r9KNNW430wV45zOGvYD54Yyhgp7kaOgJ5KuoJMJmmaMRlz0la5fH0?=
 =?us-ascii?Q?FSDWJBfLgdoNWfYlUq61TX9wyhzCQ3n0elg8hW3M6xI1jfE8GZPOX2hJqxmB?=
 =?us-ascii?Q?OmG+vEBU7AzNw4cRyX4Fh6A8TVwUqQSmwuOezGlpzWovm8o70NR4sNQuozNq?=
 =?us-ascii?Q?cX7ybG9Vt07m5h/ErssM2kkj17BF0TYrUd3gAWTK5XIA78u743u8Nur5PgsC?=
 =?us-ascii?Q?Q+zXGoyMZ5COHTGAhTSzVzuFUdw3me3jpJqE+ccKUs1mY4G9Jn061d3M9/3B?=
 =?us-ascii?Q?HpLzH/HADurqt6OKnb5CPtMtXDYKpcbey6OT6mMc+9B4+QT8LPBox10HyGhj?=
 =?us-ascii?Q?PB52Bse2ddxD58b6k6NhKKpe0srK0Rjfvp2VebTItxePWqNGe+ZUg0H1JNHJ?=
 =?us-ascii?Q?rEFbEG7rAVLStxeJnVFQQzxompNBwc198IbxUmcFWRgZc6P2TPVXHILT0WOt?=
 =?us-ascii?Q?Zga8uq4Oi3BtQD0aacWTugm146LsdtdvFpswulQEpu4WmAjAPqTDV9Ye5gXU?=
 =?us-ascii?Q?zGJJWeM3j39+UHk73CTlhPPXv5qKvBSNKEa2eLCeUURDat1j7P1iNmVKCnT/?=
 =?us-ascii?Q?MAvx4mx9swnRLZxYs104HwsGTX2QEIZkc9dwO4zf4cKeLknOVAsOgFoVBFrS?=
 =?us-ascii?Q?Lpi7F5wIj8AcgKdh+I1cMFvB7v4cxHUml/iBZd7WYuND+EwscLYWb/LVtTR0?=
 =?us-ascii?Q?RZlZGaOu5LbmcUsfFW+7jrjXJOs58V21DdQ27M0+iLNfeYaFJQMVDaX7++2b?=
 =?us-ascii?Q?sLRn2C9zW6sAtydzQfQyukZed8OlewUSV/YKFVEO0X4wah1T45uynKFeoYco?=
 =?us-ascii?Q?Ga+6Gxsm5zWIQki3BTOmQRL6054YQjhSxLRtjeCNC3b4hKVQAQG1pPD9ozmn?=
 =?us-ascii?Q?kx6iXmkmTbLVxVM6ubEhuhTYU+6sYFeeFEKEX8/Ue+9m9WDhrTl3kC7i0q3W?=
 =?us-ascii?Q?K7IwglfWOR7OOXIJKQLjBWC3FHvdobcTINTBels8tEKBDNIZ3jEwFxT8ynfa?=
 =?us-ascii?Q?2QY8zGDlXGz6SjpwVFcWD/rQd6tHm1eBOxM+IqrnDae02vq5X2vyH/DcVetY?=
 =?us-ascii?Q?l8buBnKyvouUPytmuvnmwg5L1mC2eV3jxRPRSEwpMRcyAhk+aYGfE9bSxv13?=
 =?us-ascii?Q?n7RQdRNr/5ipprGtV8WLtMze7UjjkQtn2Cbn+fUnWD1cC5gECbdal6X4m/lA?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6d1047-ad33-4d11-98f1-08dc4e64c8c8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:49:55.3890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUOvta/dnO8X/i7n4UZMN2BYgdYCO7KLSynXpgLbCTZkAU8lUJ/t3kwPCk4B821QES9QEpOTQSxHN5XZEMVeXAMMj9yqp1j62tQ4YbTCrI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959

Fix MediaEndpoint prop codec returns 0 for bcast src endpoint

---
 profiles/audio/bap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 23cadde49..52a9f5e00 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -277,7 +277,13 @@ static gboolean get_codec(const GDBusPropertyTable *property,
 	struct bap_ep *ep = data;
 	uint8_t codec;
 
-	bt_bap_pac_get_codec(ep->rpac, &codec, NULL, NULL);
+	/* For broadcast source, rpac is null so the codec
+	 * is retrieved from the lpac
+	 */
+	if (ep->rpac == NULL)
+		bt_bap_pac_get_codec(ep->lpac, &codec, NULL, NULL);
+	else
+		bt_bap_pac_get_codec(ep->rpac, &codec, NULL, NULL);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &codec);
 
-- 
2.39.2

