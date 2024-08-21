Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE051B251D
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252188; cv=fail; b=KOctXSQHzckB0Nvel9ryL3n9GpY7P5hG6+UyUAgnTpESPtmr0LwD75crNehSTIfKQONo9g/4oSw9on01MLi54cCeyfypMMmn+yFCiuRXEDtcgDjCM2UfkxvnESe975/q1kqYoSLOqBJotqnv+h3C5csExfRGCK/YJs+zyAdBrcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252188; c=relaxed/simple;
	bh=RkF68J+PDKIrq8XHFV7kRzCLCehNUl4bwfSWLw+aVRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hvtNMNQ2G71eBZrODfVa6KOdZJ22A1/m4/TMSisI7Y0uTv+ubspzVA2XpnGNZCfptkKUZkl0jhcVy2Ef8VADvg2GvA9+TwPp7kGSfbJtFvwTfclcyjNqoxCo9Ftrz3nJoeaJ3xwJ4qDCANqRG8RmxvSnL7filGRN3Un7axWxedw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cFKMJoCg; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cFKMJoCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqXK/XPEuENqkIZUMO9plXwUF46O+takCepryk4BdvTor08s6h9w18gB1w8WxaW2LP+XAFPxk+EKQkChRg6YhgaMEvfx+i1jKywVHMzrOvQuuXUwmyg4uXOvB7gyo9jrQBdA5Gt/D4voxNKjC2+bT7btmqlJ+5I8veaUBVvcw6381uNBzCussVQOh9pCvcG5i4Yr945dpDhBP54y7RwMEkvk4fidS0yXAN/bRVBk3dvjfBvkGyl8noyrz5Qb0ayWQUydnGGqsDNWfU82FgkO7d0B4wes9xFeqflmFXjdOeQMu0++B0TqYmq2bjSVHzbrAZE/2Zf1PDGjUIr0ELfzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eg2NnHXfts7yKtiAvynfursASm+1a92E+spJvY24umQ=;
 b=cn9VXtUN7vaCj7/BGBN7S3VJFoC1JN2Bp2w6mknqTT1LsMigTvXvAMSOLPVT8xAD+05xk71OZltb03ElWogjMi253n0x6pHeBiKE2uJvkF7l7UkX2SsU+BMAKozHPythm2Ti8yDqBAgEg+qiuKOVbjGKPlgN7253xSmYkz0oLLmlJ/T9nM6DDCjQsJPfMvz3Yn6Aghps5FF62CdWBULpnVAeqbvBoA8fXngf8ad0sgGj95a/e13oD1c0ANW4nwnsgR705rTgN+aHFJPhk15jMd0L5C4G7opK8vHk3BK56m1Xa/CNwQeUXXbD6o1SX54pm+mgC8wxHC/tNw7nBKMTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eg2NnHXfts7yKtiAvynfursASm+1a92E+spJvY24umQ=;
 b=cFKMJoCgXwCJ8OJZTgj+lkJgd+q8bprVOdxdkGT+8I7VKxQOTpI/euENpwPFE/pH/CA44q9lMG69Hh37QY5OXVzREfE9Jbnzw8CjC9mWof+AqXACHw92eQtanzk4iSO2Jc/tEcHImDKex49IdRc75V1nx0QO+vlUB27HDHBoPJfCga15wAh4f5Kz+jFH5xU3Zv290IWXsFuC80aLZQ0N7+RxKE522yIE9aPz8mQfGh+rLweGp7DOGkntZ0mLhOnfPflQf9iQM8a0BOfhmD6E0pjc/8U0B6EEJDI6JWZrmKf/6E/eokDVAQtVStwTgZSXgaSGlb+7mh4/pZ9ctvtjqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:22 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 04/14] shared/bass: Add support to register cp handlers
Date: Wed, 21 Aug 2024 17:55:52 +0300
Message-Id: <20240821145602.92083-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af1c114-5ce7-41cb-2959-08dcc1f16c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YMveEXP3TpWpjUDC0SclOYmZepOEMTmPzOC8UUh8qMMB0tOknCGd0JQN8LuA?=
 =?us-ascii?Q?e6X7cK+lT7v2Jpc1bTmnHQYh40kWSDIGYY0xPWFcLn6lz35RVUaw7S8tlafa?=
 =?us-ascii?Q?PZOLlsAe5D9vLtHDsnMizIUdPLg1MeVUqQsmaI6/MiDfLYtV1bP7r+bsEk82?=
 =?us-ascii?Q?CA3BukZRQjn/b+3k8BPPbLCMhxb4Q7kulNzaAj7pXJh5dZ2AzyOOxPuEkhlK?=
 =?us-ascii?Q?NF3y10wg/jNfQDNli+KYNlQIcDiriM0xaRxOfvXOcHrJPxwIEurTwunLNXOL?=
 =?us-ascii?Q?Dfh7d2meXAzwCRwmrTxQwLwEfFHuxGXg/1e4RBALsf86Jy+kg/V12x3N1OQm?=
 =?us-ascii?Q?9aaEUSuElt6dlOfXpywba2lIvDunju0AH0nW9XA/jod8ylr9pcHyY69qZ6Ef?=
 =?us-ascii?Q?GGFBakKG3JLj1y8ICmq9xTYi0I/mS+32/6+aEKSJhI2Jk3ABCfZRCD50ydZz?=
 =?us-ascii?Q?WG3bIQ/hsMIL1iMoZcRV8G4cgdOcxaUmzvN2YlQXz8D6kokOcvVhTvneW6Ec?=
 =?us-ascii?Q?5hsulSmAyVUQ6Vuv8Niwuyx7nDZF0Pcrhoii9F+sefDuKtlSqfgzozmvmnkU?=
 =?us-ascii?Q?cH10OejsajkPzxdLbL2hEQ3bI746Vj2YxR6CrBaxOSlivPVg9dWOKVno5+17?=
 =?us-ascii?Q?Q3swJn8F67zlQxnCmyII8L+NKy8PGEHfu2UMfUxjj9uCpo3twfCzV4Mh0M43?=
 =?us-ascii?Q?sjE097eHnrp6mclRXnXC7S2r5EpDEKhupai+32RW/5W/abDXwosbG4h8Bdw/?=
 =?us-ascii?Q?ahkDsmhdHyO5KVAKC+rms1pUlqJjXHjK80djEzu6s9t6FBLz6cS/Cem20Cjl?=
 =?us-ascii?Q?OYfMWiCYkR289PomLIWEaJSfm5IESLQIJpVuAAMD7+lPVsl1hX3Mx/+DkEvE?=
 =?us-ascii?Q?nT2vip7FmSRRIJBX20EkBw4j7B9VL6rf+aIhYqEBmP7LxSoqC5EGKCx0q3dA?=
 =?us-ascii?Q?qJuRnDGBCdz3RXsHWe6LdKutmBJLutNomr1lPsizlXtgkkZl4Znye2/MZzDR?=
 =?us-ascii?Q?CPKyGs3UD46ogk1JTO7Maxn6WVCBX3VKTIJHyW2MpCU3V3fLqIaJBSTYBma2?=
 =?us-ascii?Q?SHcYSdE0KmqNSItuZ5qxnEkOSVvOffceZ5Fzix3M+kp8Fq2cjSeE5r5eaS8/?=
 =?us-ascii?Q?eP3GOMGula4BqYdxjdpEbUiTnrMwKsrXolTuS9r9E/fGQDd6Ykl+KF3YGzEx?=
 =?us-ascii?Q?HVHjSLi5lIWvsN0JwrxKqTomP7qnB9FCPT+cYmFoy5Twbo6gDMrw+xViMrmf?=
 =?us-ascii?Q?sRxIM/Spd9oHk8FyKgcexF7xeJOkRZNJ1am69Nf1OIhU3IRKFK6KWvRrjxHL?=
 =?us-ascii?Q?mYyRvXIz7pKFpcWJfxI90wmYjUCvSdPClGtJ2jo5s05rjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNpBnF5sUDVYhRslXxUpEOsMehIC99ngQIy6ED/rOVb7vtgE2RLKp0fF2tQ5?=
 =?us-ascii?Q?juZ5yJd5k0jouFT1X/9oerHahU6bQ0B4m13mUPqNXGD0Urq40A8X2pLelinM?=
 =?us-ascii?Q?I8MxO3uW69jqrw0fU9L8I1CkYBeLEcLtA4TaKt7vE9td4kvxwNhzIe+ViP0y?=
 =?us-ascii?Q?dgf4Y3Yvx6nFnfh0aK9iSAaXUiwOkvCCv0C+qPJVMtleGlXwz7innvt9424n?=
 =?us-ascii?Q?51kKiLS7Nm58aKkfNJEe7ohzx4sYkiTcdRwDEuLrbixSf48P2ThfQDx9CJVh?=
 =?us-ascii?Q?9kRsYVOf8MQWMpgyuQrtOMSS9RyTdLqr3Bp7QrnboLojxSIBzJex0H06iViM?=
 =?us-ascii?Q?3lns+SgtWXjMLJ7rCLMvpekc7Iq40pKOzIdTrN2eyGlJin9UMXKDpEnJuHJG?=
 =?us-ascii?Q?fMZl3czAx0ZaYE43MKZ7aaEhQGwnfqqXwITA6GjnuNAA+s1VPzg7hM1GM5F/?=
 =?us-ascii?Q?HwWj4VSEx2NzRNEOroyC4IuaHW4kV8zaRVvMwWryY9KRYiQQAC1zAhTINBk/?=
 =?us-ascii?Q?yyVBm7zr6qqNQG1QrgS+8e4f8Bv6l89N0Au1+/ktDZG5LEnpBgVKIueIbwAN?=
 =?us-ascii?Q?ZORvdmW1Pm2i8p4LMxCu9oaBweTWZ54kEcvcg+Cmxx34N4krvgJIkbKQol45?=
 =?us-ascii?Q?NvDkFHt8dm9n5pceV/bvSl83+3LbFuttZWhr3dP+3rVLS2SJCxmf4s93hSu5?=
 =?us-ascii?Q?FY9W85w1RS+aHFQvz344quy33O0vK3Zc72VMzCEhOM5zN6i2Ulhpvc5Ahl6H?=
 =?us-ascii?Q?5dVStVeeXiDMg/z9v5rp1Z/nlynjznUFFCr4GTDYxmP+jmLGkBw9OWuVMZ4c?=
 =?us-ascii?Q?zsk1d95w7pT3sZtKFm1LpIeBsT7wDIktAAr6LvfGvu003/3Ikn40uirnBujO?=
 =?us-ascii?Q?IvgoV9OIkknc/MU4zgCwbtOLKRoAt/yxJLsIqQ1070erjY1pD3fUHtrN09E2?=
 =?us-ascii?Q?a/SKf3f8yzeZAZoNKp7ZSgzUsWpeh+Jn1dB2QDuSZFRL+zob/tnfkUoDB7Vg?=
 =?us-ascii?Q?6KXB+HFiwmmKKc9/8xQX9mv3zjvMyBpPGQw9RYaYL+h2kUjqBSUS7dqHH4Kg?=
 =?us-ascii?Q?OAJ5trkJVRMprtLxFHRHu3ndsfJBhchBigl2duOfhN4yWOQowLmPeGHkxMAM?=
 =?us-ascii?Q?p+yHfKprFBZE8r3uqZi/GVJEl4BdfQXslA431a2K/uOaiVh/ApouOXkZ/O9a?=
 =?us-ascii?Q?FmmsCAwsFRpcamJAEwOpdDAoN/afRWYlMJsSlPeUzWhIsqCToLCpM+rZlSdt?=
 =?us-ascii?Q?xt8X9Wy4oCtDdp4ChGewP13G59+Wpfc0k53ZZa7zyk4UubHcDsIMmY22eqvS?=
 =?us-ascii?Q?bexarz7vLgah4dGydg330umnLcT32mChLaniZASbus/v2DcuYqCgI/iH9xxd?=
 =?us-ascii?Q?nEIiQZccEhS7BtVqGI0FRvQeDSFxu5GYzyOV84a98lCI/E5+jR4s7DEWCCYb?=
 =?us-ascii?Q?0sxvM65SasLwG5A1QKd3zHqsWGvDSAPuEYIwPV5H6FamqXhapoGuNtu26+vy?=
 =?us-ascii?Q?Flsc+S8zjX6fm/mdB8ZINVutS1QLu0XRrNZFxchcy5BPpDftyfEdcvBEpwv6?=
 =?us-ascii?Q?ScncrK3Xee/YBato7NgpNrXLxk6hXTngp3Fbe+2Hj2q+3fMMXGUqAXBYAgLF?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af1c114-5ce7-41cb-2959-08dcc1f16c22
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:22.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KBzVMXhnZAOesT5p29H9VngznBE+ORmOhf+vn1XQz/yCBKnlSYM6QfUe96GxHZhHuWf2nITN45rccGAyiBQDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

The BASS Broadcast Audio Scan Control Point characteristic defines a
number of commands that require socket operations, which should be
handled inside the BASS plugin.

This commit adds shared/bass APIs to register control point handlers
with bt_bass. The BASS plugin will use these APIs to register a control
point callback to handle each operation based on opcode and parameters.
---
 src/shared/bass.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h |  9 +++++++
 2 files changed, 77 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 636eb24fd..635fe1054 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -66,12 +66,20 @@ struct bt_bass {
 	void *debug_data;
 
 	struct queue *src_cbs;
+	struct queue *cp_handlers;
 
 	unsigned int disconn_id;
 
 	void *user_data;
 };
 
+struct bt_bass_cp_handler {
+	unsigned int id;
+	bt_bass_cp_handler_func_t handler;
+	bt_bass_destroy_func_t destroy;
+	void *data;
+};
+
 /* BASS subgroup field of the Broadcast
  * Receive State characteristic
  */
@@ -134,6 +142,64 @@ static void bass_debug(struct bt_bass *bass, const char *format, ...)
 	va_end(ap);
 }
 
+unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
+				bt_bass_cp_handler_func_t handler,
+				bt_bass_destroy_func_t destroy,
+				void *user_data)
+{
+	struct bt_bass_cp_handler *cb;
+	static unsigned int id;
+
+	if (!bass)
+		return 0;
+
+	cb = new0(struct bt_bass_cp_handler, 1);
+	cb->id = ++id ? id : ++id;
+	cb->handler = handler;
+	cb->destroy = destroy;
+	cb->data = user_data;
+
+	queue_push_tail(bass->cp_handlers, cb);
+
+	return cb->id;
+}
+
+static void bass_cp_handler_free(void *data)
+{
+	struct bt_bass_cp_handler *cb = data;
+
+	if (cb->destroy)
+		cb->destroy(cb->data);
+
+	free(cb);
+}
+
+static bool match_cb_id(const void *data, const void *match_data)
+{
+	const struct bt_bass_cp_handler *cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (cb->id == id);
+}
+
+bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
+				unsigned int id)
+{
+	struct bt_bass_cp_handler *cb;
+
+	if (!bass)
+		return false;
+
+	cb = queue_remove_if(bass->cp_handlers, match_cb_id,
+						UINT_TO_PTR(id));
+	if (!cb)
+		return false;
+
+	bass_cp_handler_free(cb);
+
+	return true;
+}
+
 unsigned int bt_bass_src_register(struct bt_bass *bass, bt_bass_src_func_t cb,
 				void *user_data, bt_bass_destroy_func_t destroy)
 {
@@ -1418,6 +1484,7 @@ static void bass_free(void *data)
 	bass_db_free(bass->rdb);
 	queue_destroy(bass->notify, NULL);
 	queue_destroy(bass->src_cbs, bass_src_changed_free);
+	queue_destroy(bass->cp_handlers, bass_cp_handler_free);
 
 	free(bass);
 }
@@ -1513,6 +1580,7 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
 	bass->ldb = db;
 	bass->notify = queue_new();
 	bass->src_cbs = queue_new();
+	bass->cp_handlers = queue_new();
 
 	if (!rdb)
 		goto done;
diff --git a/src/shared/bass.h b/src/shared/bass.h
index 086fe335e..2ca659cca 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -99,6 +99,9 @@ typedef void (*bt_bass_debug_func_t)(const char *str, void *user_data);
 typedef void (*bt_bass_src_func_t)(uint8_t id, uint32_t bid, uint8_t enc,
 					uint32_t bis_sync, void *user_data);
 
+typedef int (*bt_bass_cp_handler_func_t)(struct bt_bcast_src *bcast_src,
+		uint8_t op, void *params, void *user_data);
+
 struct bt_att *bt_bass_get_att(struct bt_bass *bass);
 struct bt_gatt_client *bt_bass_get_client(struct bt_bass *bass);
 unsigned int bt_bass_register(bt_bass_func_t attached, bt_bass_func_t detached,
@@ -120,3 +123,9 @@ int bt_bass_send(struct bt_bass *bass,
 unsigned int bt_bass_src_register(struct bt_bass *bass, bt_bass_src_func_t cb,
 			void *user_data, bt_bass_destroy_func_t destroy);
 bool bt_bass_src_unregister(struct bt_bass *bass, unsigned int id);
+unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
+				bt_bass_cp_handler_func_t handler,
+				bt_bass_destroy_func_t destroy,
+				void *user_data);
+bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
+				unsigned int id);
-- 
2.39.2

