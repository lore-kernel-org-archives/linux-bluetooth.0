Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBD651BD
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861597; cv=fail; b=WFfD4m1Oey4zT+AK0W5y/e/zS4crT+JfE0bnf6mcsiWv8l3INZhiz/HAYh1S3/H3rjQroJD/Y6B/e5gLQeBsbcCxQU+reE379fCB+XBOMiZvMKfiywqjieWoyAQGRGL92XmgMXI8jp9C7PXIPfeZNwiDkrSE7LXqO5R41wE077w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861597; c=relaxed/simple;
	bh=zMuoZE2zqqv9UOgf4XZ8MCJoBxdWNBc4DspwcZO7RZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AOCYmA7+/qAfL1JgYiA8mPbih5WT5f68k2RrWJAPXyGZgyu+PGiukDdYyPjXmKN+kVDqtvC7M/1TZgcclhppG/B3op8tjdrUt/Ph4EV7fuS5XIWb+Np8uZMjO+U19yFK3/IWgA10p03xmrMNsvTvL3+JRdtZvDSlwoyHf/5abD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VCOoWUq+; arc=fail smtp.client-ip=40.107.20.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VCOoWUq+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZeb1y5v45ACaoRTNxBKWs17uenJm6wvW+QrbUxvr7zhg3+G0y3Qx4ld793+7cyHNN0Fmvh2zUEESfo7iYZ57UNO8fwYUiEk9gIWodUksmGZGJ40XzRPdzVCVw2HVv3T35RtVofw0sP0Da+50zxqoX1/SIqjl+2lXsXtt1RavM+a6joY35iZF0qKGUiu3o4lh7F4Vt8HIJ+DLFFbX8aEEx88Ts05E8KMHLFKbFj0oTn6JP4LfgVsCuA5Ctqhs0mmDArFPysWHfsfpXpwBXAxUtspMGqm3wHAjqlvSl+2yFPQBN40S7081uiy/p27Uu2cVQwj0r+O3ozr+rpW/HY1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Q1liWkj8ChkWrx/0c2AaibPDzXrvRrXQs3Dgaica4=;
 b=UA4g/lS7nLo+0JXufgpKLQStOxvrta/kVH5e9mlD1RYdi69j1udrB5QZGf2st1RpOlWQ2Nw7TRO1+5O89zoxA2CVkwc3+DuZUyyMMpxXHQnuruSP7plnbMpysfX4ljBqVXD2esu7U9cMtP0D3W3r+TJ0hA8OCBy/83VoGVXuVQVKszzNMPcUF3jsASND+37jP1zbBQLXtAjzAlwYfcRZCe/MJ8Yf/879aNN/WMtUXDbMiVcAFzCfG/kOaEJQnccP38aubIiUHOcOqbM3/+QEhcqXjSIg3OUjSXNpKpfjjG+eSjCKdSeICIZoBpbXADBV29sRxFVIWdwspDzdlScomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Q1liWkj8ChkWrx/0c2AaibPDzXrvRrXQs3Dgaica4=;
 b=VCOoWUq+cn957K5ofmDmLdvPHht4rLILxsIu3vvpMhs1iEiVuPtS1U+tjxHOJ3MRZfCB+BWKJG6ygLuTPEmvFgDCKaO6WsaLXYLYDCZvUPaWo8kmMokyTCmhYxwRj8kPvgUobfSuINB9UpjynrGmEts6BbuBObAvhAWKHBadipM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by AS5PR04MB9924.eurprd04.prod.outlook.com (2603:10a6:20b:67e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 15:19:54 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::58a8:b333:c024:1077]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::58a8:b333:c024:1077%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 15:19:53 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 3/3] client/player: Use util_iov_append instead of iov_append
Date: Tue, 19 Mar 2024 17:19:17 +0200
Message-Id: <20240319151917.834974-4-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240319151917.834974-1-vlad.pruteanu@nxp.com>
References: <20240319151917.834974-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5384:EE_|AS5PR04MB9924:EE_
X-MS-Office365-Filtering-Correlation-Id: 6916d720-479a-4875-b93d-08dc48280728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZJcSUpqsemK0Dg+BxgdH4mj1+zOn8bOARqv/anCzM3RuS7vMPCAInpW1i5Hy34Fmr86bRSF+gODzFPYYku3uNo/TUWxXK+81m9DEaim6612P2TZ7shmAlBwhOcM+GBnMnxBaBDcJhjXQK+gqkri+Gr62uvVHI+/DPrrhCjKy2I0YMdw9gvOxf65yvKhFQ0mmnlU3MKQ311bZErwn/iZvYk/4N37ZTjqTfXLCHMF41dOmNPh9ZdLk4L9qkmtgY0y9I0mrPG6rCcR1AzkUeZKH1M93x1gNz9YJu3+VfcqzkfJYosbwG90Ba7VDiKhwhEwKAj5zFSTrCMleiNSyivt0wRr5VvFy0QNAG7/yTI2JE/8HvOkMeb9ADueswzno6h8wGFSUOtHXbn+HUa/7rTmfpmjrltFGvAqgYGSweJ/yGDl+H+b8xEEEoeyonIzLMVupFFSpHauu6TGRVANGXs7dkmfbAgpngpCHlIiWXUZPmg+V2Ui3KuTXk0+SZdhttzvRWUemP8cIWRicFvjV3leIxt4v/HxQbaXwdr1FfsNueVIAMY/Nli9yvUOge7s3bu57APZR/mJdQkgG/lRhL+RDki5qt+ES7h3J3F43qFSGYCorv02/h0KyKrYjl9Cl3/1osomgv2WiN+ErhwwWEeatASwrh0GOKvCrRLOLs/gA6zL30byx9RJQ7b3O76sJc32uYlngQSCi+Ew5Kf9z2r35kl9A9QJuHbTaCCYPaq+CJX4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yTd3zuyReIOxxJWOxlNJrniKRMqIQiv7elVV4G9sDSih5fWU2H4r8Y3e90Yo?=
 =?us-ascii?Q?x9UdmncwddxgxzuAvDp1oT6cOmyv9asmCGGadc+oP9yTW2i5F7y3RZI236WM?=
 =?us-ascii?Q?zjjOAs3BiHmfdc1acF/UMdp5CgzFuNXQYfjrvOYrFhaXz+/goBHV2u/0sf8L?=
 =?us-ascii?Q?sMws+MUjFkSVTGucWEwugyhiHVsvQA1aUiD8reVjgvWlO2tuip3uLpUWZhi3?=
 =?us-ascii?Q?C5b8CfOuXN/zBEURr88katXu00LYrdwJuVaKd/E4L3ZRi2Z22kRl2GdSBMS7?=
 =?us-ascii?Q?szH7PcyvwqTNM0GxJbNM65VOWOID49rKYk2C3GHN/3BgGXgLUzD81879gHlR?=
 =?us-ascii?Q?jzL2r7u90zkZ+2HA4sZWvICvZnsqNEt8VVzhe3vg8+6ku/usrHYrWH4XcK8D?=
 =?us-ascii?Q?bvofEUk1kXroHAkNxU+o8Y0mU2KzBIXLMabkTf9EX/vOJMRpZWMUU68FoLSp?=
 =?us-ascii?Q?d7ZdWeEDQiKJ6Xwi9jWQDJzGSKmFkptbiotWJiS+GF0ifLBcVEVaPvXQPR6r?=
 =?us-ascii?Q?M8zl0V4zShP3A2zkk0dJ6E4qYE5aLcInc1vyMRBSiIhM6cCg25SHlQQrns/F?=
 =?us-ascii?Q?LWmFCi9h/R/6VaI2xgofCUdTdJAwsffFHJj/mzlltboBZMiADqEo+MPRPrrl?=
 =?us-ascii?Q?w1teHihGUscJXFy6kZry4i+KbCW9qADo6xpvLaOEDuaHEx+RhL817So0cgES?=
 =?us-ascii?Q?xgjQK6tGtabtlRsc8cZfP8NXRHLPD65ufn+QpgdDqRC36f6ngu4lTFt/mefo?=
 =?us-ascii?Q?gRzlbmh89v9/6MvBkAVSp2Cg8LRDo73kphMh5EKteH7T8cbqcfyKirv5zcXh?=
 =?us-ascii?Q?kM79aeIudctmhHMG/76EM2tl3m5sYAhO4Q4Q3p1CGlXQJU4J2XQhujw8LWeY?=
 =?us-ascii?Q?YhRBABInhkow+2At9avgZMt3IAgMqzcm8L6OTLYSLeT9/6Gskz0q5+U43mQQ?=
 =?us-ascii?Q?EVEAVEADnQIbaEm9z2bSdJJgY9kz0QG01rcy5TRaC5TvXizGhFbUhna7Iybe?=
 =?us-ascii?Q?Cs7xzLzTxm377JhYpZvSc1FLlbj8z961QruFsbzGc8xcZqXfzS2bi7WEUHMq?=
 =?us-ascii?Q?jlXLzFvpjIGesMxbEliq39kxMDcjMUswgb+V87GWhidEbRdpX0H8lqAlYKwY?=
 =?us-ascii?Q?ytE2kubwHLYsp4Y0ztwC2NGWOu2sDdD1aHNbScexcWloTtx2ogBr3Zi8onn5?=
 =?us-ascii?Q?iMPHFhkPYT11I8OlDWXa9LWM0jt9MxkeKkWViiDLmHvrv+LJCet3a1ir/yxz?=
 =?us-ascii?Q?pLT09kLyGBVb0LbBK2P4rPyth3X6ZUX6sqQov6++S3kvWwj+eQiGtzSI5uFy?=
 =?us-ascii?Q?fyeu+KD7KwNvtqSyV3Igt7Wxc3xPydetasFUfiBNbSxdrt5xGFhc1F6VkvUt?=
 =?us-ascii?Q?rhTETgzx08Z6kWKlqqaZMPJbxkSiW3mTDbEtZ1WxezJh1zP9HpFP+yXLF6+B?=
 =?us-ascii?Q?u8GOARHHX4n5x7Gwo9FYiuFW28BWI1oNwf+jdPKYeKVSbGMS15UbBGDXy6tW?=
 =?us-ascii?Q?vvSTZOTG274DAMoXF94aHzsQ9b/j0iebYRBgSZXOpSyEtdQxh0zh2kJJhZb4?=
 =?us-ascii?Q?DF8jD/N6DD1HoccCIcDjnCtsz5qq03RcwuwSYSU5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6916d720-479a-4875-b93d-08dc48280728
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 15:19:53.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 842uRRZnit5eMCk76az4kQos5S5RKEGIpRZLw5tsECIfzCgPWVFT40OrVb8o53Yl69C0f9Ehx8AfN8eM1XweCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9924

util_iov_append has been recently created. This implementation
allocates new memory for the appended data, while the old
version of iov_append from client/player.c did not. This could
lead to crashes in some scenarios, such as Unicast.
---
 client/player.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/client/player.c b/client/player.c
index 8081ddc13..ab33bfc46 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1951,23 +1951,6 @@ static void append_properties(DBusMessageIter *iter,
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static struct iovec *iov_append(struct iovec **iov, const void *data,
-							size_t len)
-{
-	if (!*iov)
-		*iov = new0(struct iovec, 1);
-
-	if (!((*iov)->iov_base))
-		(*iov)->iov_base = new0(uint8_t, UINT8_MAX);
-
-	if (data && len) {
-		memcpy((*iov)->iov_base + (*iov)->iov_len, data, len);
-		(*iov)->iov_len += len;
-	}
-
-	return *iov;
-}
-
 static int parse_chan_alloc(DBusMessageIter *iter, uint32_t *location,
 						uint8_t *channels)
 {
@@ -2033,7 +2016,8 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 			location >> 8, location >> 16, location >> 24
 		};
 
-		iov_append(&cfg->caps, &chan_alloc_ltv, sizeof(chan_alloc_ltv));
+		util_iov_append(cfg->caps, &chan_alloc_ltv,
+						sizeof(chan_alloc_ltv));
 	}
 
 	/* Copy metadata */
@@ -3540,7 +3524,7 @@ static void endpoint_config(const char *input, void *user_data)
 
 	data = str2bytearray((char *) input, &len);
 
-	iov_append(&cfg->caps, data, len);
+	util_iov_append(cfg->caps, data, len);
 	free(data);
 
 	endpoint_set_config(cfg);
@@ -3662,7 +3646,7 @@ static void config_endpoint_iso_group(const char *input, void *user_data)
 static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 {
 	cfg->ep->bcode = g_new0(struct iovec, 1);
-	iov_append(&cfg->ep->bcode, bcast_code,
+	util_iov_append(cfg->ep->bcode, bcast_code,
 			sizeof(bcast_code));
 
 	if ((strcmp(cfg->ep->uuid, BAA_SERVICE_UUID) == 0)) {
@@ -3707,8 +3691,9 @@ static void cmd_config_endpoint(int argc, char *argv[])
 			goto fail;
 		}
 
+		cfg->caps = g_new0(struct iovec, 1);
 		/* Copy capabilities */
-		iov_append(&cfg->caps, preset->data.iov_base,
+		util_iov_append(cfg->caps, preset->data.iov_base,
 				preset->data.iov_len);
 
 		/* Set QoS parameters */
@@ -3937,7 +3922,7 @@ static void custom_length(const char *input, void *user_data)
 	ltv[2] = len;
 	ltv[3] = len >> 8;
 
-	iov_append(&iov, ltv, sizeof(ltv));
+	util_iov_append(iov, ltv, sizeof(ltv));
 
 	bt_shell_prompt_input("QoS", "Enter Target Latency "
 				"(Low, Balance, High):",
@@ -3963,7 +3948,7 @@ static void custom_location(const char *input, void *user_data)
 
 		location = cpu_to_le32(location);
 		memcpy(&ltv[2], &location, sizeof(location));
-		iov_append(&iov, ltv, sizeof(ltv));
+		util_iov_append(iov, ltv, sizeof(ltv));
 	}
 
 	bt_shell_prompt_input("Codec", "Enter frame length:",
@@ -4006,7 +3991,7 @@ static void custom_duration(const char *input, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	iov_append(&iov, ltv, sizeof(ltv));
+	util_iov_append(iov, ltv, sizeof(ltv));
 
 	bt_shell_prompt_input("Codec", "Enter channel allocation:",
 					custom_location, user_data);
@@ -4074,7 +4059,7 @@ static void custom_frequency(const char *input, void *user_data)
 	free(iov->iov_base);
 	iov->iov_base = NULL;
 	iov->iov_len = 0;
-	iov_append(&iov, ltv, sizeof(ltv));
+	util_iov_append(iov, ltv, sizeof(ltv));
 
 	bt_shell_prompt_input("Codec", "Enter frame duration (ms):",
 				custom_duration, user_data);
-- 
2.39.2

