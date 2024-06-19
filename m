Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5980C16
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790706; cv=fail; b=pj6brOxp6H2S/SJddG90UwRttHVPcXzClNvMZ1l5Bl6Qso6oSZlzTL//2JfD0bvw08PDcurthXG730p9Yn35rWNlSXQu1XPEwpTY4RDY0R9nMF19eOKAFFgum3Jpx5SslI66joEgbzP7nq8TQJ6E72SndjW7K0UPF6wTLSpZm8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790706; c=relaxed/simple;
	bh=AZhPpj013308BbrA94yrMZ4YHMhE4WUiClzwj1H3YWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fLvNOZbyglv/ZuYBn1MvDZlbeO5+js1InD5xPQanIinzTwlWemOZMXXJU0Nc6Ca6RURUcfDFRapQvDlGmMWEriWFWY8DhUL2NMCLG2bV7R2w2/tPyVS41fZU/Y9UlaVmcQIr1sDK7mi0vc3+n6pSup1HeqH7cfCjLV1+fxCW5/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P96m2lWb; arc=fail smtp.client-ip=40.107.8.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P96m2lWb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMiNsh+yRaNvYh51MArkLIKgVNLYL1TiRV4LQxETCV/cdEPxaKrgOpw20Bqfth26SJ/L9NePFFn7y9XLle+vGl0fYYiBgC90CQ3GhMN6fwdRXWYjxMENJo8tTUm2wo/6Ks8A53Pck5DcuQAZErJ7GvyV7f2EBpnjGM/kjofRm4Jq0X4IthG3l0B0q4q0l4rAUZa/8Fa5sZW0xGkyoBTkad4c63p6w5IGmVmMe9H03w5rcXlyrG4TNVU4vhUlAGW0jLnPVFblZPwbGY8nZ1wWsX1d2FRbgyfG6VOsz9/v8V4lktBEFqtXEigWqajwOi6aL5YE8YfIZf4XwQRgvOcx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpnQn6TQh8LOqKZk5O4flL3CszyzWlPrdQ/CnmAHRHk=;
 b=IlmEq6ov/lI3F0U9NcASLIwyHZib05UdmBGviQ2O4EiX3aKJ6Z5Tu2etuLACDqxPW/+wYKjKlE/CrU5lqs1LQLAkZ2Dnfg54FHRhlQBBGsqI3CP47APX1+Jn6tekOmdIg6bvZttHfWopaUaZbUhsyz6VqwB5KRkTNMwa0DcrHl/Y5MtADGv1RUFB9YrAKYrrpi0A/gVZBTp6czvSnXHOq8T+zl+jw9t9nbEg0Ovd96l+JrtOzJ/MOVMFARqHferA0dVQtH5S+KYUMToEHNkE+MqNMmIetMqUcVQqE9isoV2d2GcU5QYjgwENdqy7ENKxqOev/gLYk4KEqdbAk2u/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpnQn6TQh8LOqKZk5O4flL3CszyzWlPrdQ/CnmAHRHk=;
 b=P96m2lWbYiNR8YNWXOpEemRumE0CcVscsXo2WBRDArtMg659T0Cn5FYjKe+BtGcgDEZXzENHbe2xXnUe4chg/CmiYPBM/0IjSdzr+zXbLzMHtcq68E449h539LKbZtb7Nfi3ZHELYDlGjecbMQaNqDLgFBwtZxVS/2su3689Y98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AM7PR04MB7093.eurprd04.prod.outlook.com (2603:10a6:20b:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 09:51:41 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 09:51:41 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 1/2] shared/util: Add util_iov_new function
Date: Wed, 19 Jun 2024 12:51:18 +0300
Message-Id: <20240619095119.167652-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240619095119.167652-1-vlad.pruteanu@nxp.com>
References: <20240619095119.167652-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AM7PR04MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d068702-a27a-4f06-5357-08dc90456bb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|366013|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J0IRk+nqmrWaZsGZ7LeVsv4KkJjSCoJmGwvdb94uCegh5jwNKDwjEfiFulUo?=
 =?us-ascii?Q?YiTDYJagCkS22G0YHozOqSDem80rsyPQ2l/uqM5Ab46XEDCpd/MNKw9oz3n7?=
 =?us-ascii?Q?godlzTuXVjMwCWZ7Z8kKVZ1z8mFYTfMO7vViXWR8PpMkUdLIUvaH/sJuY1mp?=
 =?us-ascii?Q?5QUOENwWgHJ6XKO1CWYXpdN2QkcoHVA4XzOxOgz7n1MC4y/JYlzF5SoSQDYS?=
 =?us-ascii?Q?uvP1goq23MV9nI+C35MroViBw0MbgIrfq9yyeCgFfe0og7vucQqcvbPYwL48?=
 =?us-ascii?Q?WrQozVmvrzomEeAbFSLJRLJxuEd3++6+JAUqdU8OdJFR4k87BJQXoJ/E5CEG?=
 =?us-ascii?Q?HCDve5PXtLlj5pXtKoFS/wCHH4Fb/Te0GHMAfpnTAEsfQ1n3TtHavxY0yuNH?=
 =?us-ascii?Q?SgM/ng6MAC7oUuftNcw3m/NpBXbMpzTM9AcX0SdwZoHbX1gnPBxpw0Rz7RxN?=
 =?us-ascii?Q?u8H2S7ausDKC41I9fVS3uOsqWdBRu8oRtSRGfTFqVKMmo6BYzeLxndd1eixz?=
 =?us-ascii?Q?bBdulIcvay4mZpOxxlVZXAQNWpEBsv0WZh4lqIKyREwgpkMKW0bUvQm3f9+C?=
 =?us-ascii?Q?xzVTdC7IOxUTEkEfzD0wwqVGxHCUkF8b2VlnHw/KBuSaqnJVCDBJ32r831RC?=
 =?us-ascii?Q?Gcopy0mtRluQ9l4VGan+Fxp5vh7jo1nwNlLMa2ZV5RUVdhpwA+b2IWkIlOVE?=
 =?us-ascii?Q?VZh5K5tkbQghTBa3VB0nHHnhKg2prkksxi4FAdiiymjJRm0oYuuxhwmHTZvR?=
 =?us-ascii?Q?UIHvD/RL2nFEbaEZkI7H7CesdEg3aw7wjXRh9k+kj8IgzPhrgv3d+w1i4T8E?=
 =?us-ascii?Q?TWXs1opr9yG4rIozVGvHcmiSyYzsR5KnITAT4Ojsg/T2Il007aedNwZcdYVJ?=
 =?us-ascii?Q?lUy0xlk0sJid4sqBoChHr7Ed6Yig7jBhq8E2k/p8+bs3bJQlxrKn/bcGxHPq?=
 =?us-ascii?Q?34033Tuqh5Tyi4CTsn5IQGtEKyALRZCwRHadeznrJNMwaWOfm1NApsSxOb+u?=
 =?us-ascii?Q?TjFnf4Ffi+jGbvMnM93B2Lf8A1j8NIOxqD5mavGNODp+TaiYVa38UEbyNMuJ?=
 =?us-ascii?Q?3PlaKRNUWaJ9nNefgRNUCQvouXS/SlmEkafffrjwSroc9IMGt1xv0gsFCIU2?=
 =?us-ascii?Q?v6dYMi6A28uYxjdV4iEHjljlvP438ZPhkAmjO37NyG/OBSugKoVMlewC/9mX?=
 =?us-ascii?Q?1s47sk50vrBjlQtfqcJs0UnDnvRGBM4Ir+LnivBHaMx2sA1rrtsQTReKiCIs?=
 =?us-ascii?Q?FPDWlAob3NFrGLm3lCJ36JuFwpbgY1yMsshUNGv/kNZJ6fpOqAg34tBuTRB3?=
 =?us-ascii?Q?6L8J++H9yPGYsguy9qO7dhvp3K/+YWP2Iot/3gfSCuz/8tHmdjhPE1tE8Wnb?=
 =?us-ascii?Q?P/Xjl20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(366013)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LfpxvbM7Db7/3BC2DTbvno1IO9zUR9CfqMtRGcLKBE7osoBx3GYkqo5RULNQ?=
 =?us-ascii?Q?e7PX4VDnv+DnmA9zWgq5Z+LBMmI6/ac+v2G/LfNzJ1ou637PrMoM5ncuhfSp?=
 =?us-ascii?Q?oQDrKCsLXirdhZXriPqQ+cBV0RHcrQwbeTIsj3V0HGdM0Vsd2NvsFDHunQDh?=
 =?us-ascii?Q?s7YbfUIHf3auY6bLSQfp/j3VvpcvRibQeGwudJQCPLgVfWzxnjXTLhHz2/pG?=
 =?us-ascii?Q?nsc7QisLpPWCXMdEOWxvoTpytD3CWtURNLfqWs6qfke9PKkkoddrK7fvBkpC?=
 =?us-ascii?Q?uieW2gmAMW4eiIh1id7P/bpOKFVtwiT5Ar1bzN0kOs5as1bR+d0WGd3JTaF2?=
 =?us-ascii?Q?8RipoKlr7TwuKNePZCyM8qi4tRwAi/47OG58aHfuuHzSZyLGHqHG0QxSkZKP?=
 =?us-ascii?Q?my3NPyleFihytecx2oZ3go5fnfcH6yRd7NJ7Hxu7/S3XosCFg/tjMvBA0Lqu?=
 =?us-ascii?Q?agTYR5NcjU5fuP6b5diy0183KVa/HuLhz2yuiey0/RaLbWKz5JN7/AOhHxKL?=
 =?us-ascii?Q?AumOeY/CBkZxL0Oknzl5AD0ePoqPXUtNxy+0i5qr0qo458TehdIqIEK/Ep1M?=
 =?us-ascii?Q?6vaJtKW4waCcHRsm2iRP/cmb1CSNKt+n5T929dJnMHFLHrfscJUnHvScpwmh?=
 =?us-ascii?Q?BWQT3SYpXjUQgdCic2NnXBCk0aLZ+dHLBWHcAx62sgDtVfdkGBtChXERW2k4?=
 =?us-ascii?Q?czfhylNuQ6obLZ5pEh7ikvXjLDPYj0fqgis/6jtWPyOYn6JmhsWx/G0Qzvb9?=
 =?us-ascii?Q?PGwkxjuGPsyZDOF/smixgxPhTOlRzc/kFy7XelkzbBlu9ZjNTw71NJopZMYk?=
 =?us-ascii?Q?CMjXjEuQwaGCjtgmBywzQhQ75s566yVWxYBy4DIw5ICjDB7TCf7Db2eKdNpj?=
 =?us-ascii?Q?K4XOO9kvCFjAKxEsKvec5s5I2jvl9VrAyxkq8GM1xjwADLNzQz+Wzw+dQ2yl?=
 =?us-ascii?Q?TgA+eevplv2EFktauyNBG3CnSrWJp3+G2P2ry4EGy7Tl8jiFLVqIAsL1cHnO?=
 =?us-ascii?Q?IGyYGk0xMdzn+qjC6b5gJLSjsV5tltmHNXOh71QeZn9hplIL6qIArfwJrsLb?=
 =?us-ascii?Q?jrrxiUWdmxNqwqnYY/WDq0WDH4aZ91Kua7zhD7LAVkEWOPTDCW9L3Dm+/MI7?=
 =?us-ascii?Q?dxydy9T0sv+GA+KTK649zkATLZti71cJ96oEeb43rLQ5i3LulSGa3jUidhiu?=
 =?us-ascii?Q?KSgjoGkEnbNgFb9Zr+pZ2vvezuqfgMexCiUEfZmjfj+iGPwQOzAc+PVcErEX?=
 =?us-ascii?Q?LkijZjk9o8z8bABNBiVrhpC4ejqmuejHZd1RfdH++oEeyq4KZ8A9yHNai6Fl?=
 =?us-ascii?Q?nLx23jnZiFUlfnpsUNJtUBReBhQfSd3f6F+y/1Pvwmd6nw8xeZKitiCFSXhK?=
 =?us-ascii?Q?MrSD+r6+1oGuMHjTy+fmaNuWzfiE2Xev9tZwxyFqc3E6P3I4xduDHlTceZWZ?=
 =?us-ascii?Q?r1Yry6yV70I8dBhx7o62PZN2Ga6Bu8XCXnWns7TRdor2v+nWX0dKBnDrdUCr?=
 =?us-ascii?Q?VJVbWSXnBPwo4DhTtS7m3qerBsM6LYMUYRSvBm2tsgr3o1U2cpnDAXvHaxJK?=
 =?us-ascii?Q?qDVMk4WYZiYOq0kyRHohlf8TjGlbKa8ssFfBreqZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d068702-a27a-4f06-5357-08dc90456bb2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:51:41.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZ8+VKi5/3WfpLTFHZ/y3WjefRrUSjCZH2GnfhCAOwPZeSc3EIZJfS255huklWn+Nkdahb06LwoDrQADQSXhsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7093

This adds the util_iov_new function that allows the user both allocated
and set an iovec to the desired value, using only one function call.
---
 src/shared/util.c | 10 ++++++++++
 src/shared/util.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 6a29b5068..30f054a5e 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -542,6 +542,16 @@ void *util_iov_append(struct iovec *iov, const void *data, size_t len)
 	return util_iov_push_mem(iov, len, data);
 }
 
+struct iovec *util_iov_new(void *data, size_t len)
+{
+	struct iovec *iov;
+
+	iov = new0(struct iovec, 1);
+	util_iov_append(iov, data, len);
+
+	return iov;
+}
+
 void *util_iov_pull(struct iovec *iov, size_t len)
 {
 	if (!iov)
diff --git a/src/shared/util.h b/src/shared/util.h
index bd71577d6..f2ca4f29f 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -176,6 +176,7 @@ void *util_iov_push_le16(struct iovec *iov, uint16_t val);
 void *util_iov_push_be16(struct iovec *iov, uint16_t val);
 void *util_iov_push_u8(struct iovec *iov, uint8_t val);
 void *util_iov_append(struct iovec *iov, const void *data, size_t len);
+struct iovec *util_iov_new(void *data, size_t len);
 void *util_iov_pull(struct iovec *iov, size_t len);
 void *util_iov_pull_mem(struct iovec *iov, size_t len);
 void *util_iov_pull_le64(struct iovec *iov, uint64_t *val);
-- 
2.40.1

