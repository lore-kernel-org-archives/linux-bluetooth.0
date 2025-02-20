Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDD71EB1A3
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041905; cv=fail; b=Iz3QCGiJtuPC8MfOSnOvFX6TdsxF9g9/M2P+/SAqd4kjR2SGu1AT1I3HuNiv1s9RUu1zN9otB/EM8k1R11SJia6B+ObNOjo8kZaI6EJwVH3RU6UlxLdUaugTn9YPxyznLKajSRV1idATIv7c4e98vchEDKqhow4Y9Dimm0PwaFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041905; c=relaxed/simple;
	bh=2VGNhuBd8k4JvY4x9/tDMqIRRkTv8r+7XoFSjhYbu/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XSLjZ8m2bJsAPIlUiJ+lHEoeDGlJwaR3T/eTQ+9mHAa1fZaWndlc0RuHMee3RHZTgLFulVHi+VUYV09x7nngFfuCRW4n1zcBEzDYTk2mKJqSFP8Q7q2HGuYaXKmxLpBhkPwvDd11svfbjWPKicGHW+CrE0KtND8j8kLvqEhYNgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DRtwTzyZ; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DRtwTzyZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ok4Yw9xHJko1oNgikIUDCKNf7X5Wxdge9zNYK9hsiuTJ8HSBvPNTO4NtimP4oVoDttJO6i9FjQJW9rtcVTgDvPXFsY5UvQnr1khrG92dgbqPMSxM12bqp/4DyHLJjRrlIYsDltkE/7d5hh/NHaWgGmnMHUjW1G2m509CTjMDmqrXtkc3vHlV4vJOxxkBKWeF17rcPl108Da/y8AuWpcgPE9es8B6Hact2RyO3Zgg7OIRmKKt9/KvzO8xR7WDMgZSaDsN1beDHUzESUQrwrYhFgST/TaXrM+TNZh+q5NrZK6VDbHZ8hGRZeRIXn1WCX5H5l7kpSaPMuOkYyfheidEPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuvMT+m6Wq72DZ/sCSuXwbyGE77amQLjNZaohWh4Ctg=;
 b=H07284PCA53lGCrsRhMvmoRzr8+4mNao8mHxSWAyUg6OhDjx4n+ixXjWvQk47Zpxq7b50IuWjQLH2Heo1tIMLN3Zw2MmPdwYuKXF7xps9j7WCUn9oDA4oXnFhORtRzEKim784WiE4wyaew6Cgh8QbSoyo9lCMCYPQ1ijgr0Qwd+LA/rSnP48r/6GtBXG+sphMv7fixQD+ro6g6tIyafLQmIsiPOrFo4aJ3Ynn9khmvsTrIMd38OrZCudPOZXmTKgFXXr75n/s5Rz9ud4H67f2WYqMT5JiSC3su1io7EkJRM4WP3z7ItgtMr0392dfJL/WXhavVFSYEs2BUYTLgIRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuvMT+m6Wq72DZ/sCSuXwbyGE77amQLjNZaohWh4Ctg=;
 b=DRtwTzyZrXzejAdSUiVgShuNQGIgqASoIKKDmiGg3/R3xvLzWWOXTYTQNXVA7i9i/jPPx29Q1jlk81St9uJuIX0eITXyCcepkIMWC4IHk1Nwo2vNIrzAtWEW52Aw2cdjVjZl2BGi0Fir2Yvz/EEJWoBX4i5D4zlNnPPL0Ez4qoxLKgPd0J2j68+mgZl87f4SPAIjNgaMAcphFzqVMEwzqQ2JVUPeGlrizlebC5wGADzNljnvsSFOo8C0hZXNM42CBf9WtbTHKis3QBqmvhItYrn34I6zKEZ2qGEkCvJhP2NzAdC41tpJm81zYC5pnbuKgZHdOO/JiNcYA98j2+de5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9121.eurprd04.prod.outlook.com (2603:10a6:102:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:58:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 08:58:22 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] bap: Do not clear user_data before detaching bt_bap
Date: Thu, 20 Feb 2025 10:58:09 +0200
Message-ID: <20250220085811.5033-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
References: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d806fc-d31b-4b16-a916-08dd518cba9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GZsQA4Y+uI3QYzw5LqUyWBCRkBlsaawz7MSXOfc0RYm7iI3QH3WgTZVfhXCQ?=
 =?us-ascii?Q?73q0/h1vWw3LyH6URrgGBLJNdwUb3eylF22sssd2OjhBhpsAiWId6VtqCviV?=
 =?us-ascii?Q?ICXmk2EI+ZgE7KSrp2/MCIH5WoMrPGH84EEiSwuJAcU9ahuapddjN9qmp+0L?=
 =?us-ascii?Q?A+KiyB3Am6Qv5Yiak/7zh6U9aLtJB+OSm44Z8blpLCd+JrlKGARZtxa5OWI8?=
 =?us-ascii?Q?i8yktbi83ohAfDpLr0EP5uw6FDC/kMliKfnC+Is5o0zU4ApQkhBW+2cOtE1Y?=
 =?us-ascii?Q?NWkXnawPOQjVdhF0f4MdT9gpxzDCk8msk5Cokvgw3i2pNB5lXO7E22N4HvBm?=
 =?us-ascii?Q?LDGIu+vxt0LGk5hGggCxdvseV82jOvlbrWR34kjMs4SwfYkEb66YGj33Y/AW?=
 =?us-ascii?Q?DmN1DtGbLufnOBHkaKhzcWZXunXv3o3Cy7r01VPHCkMpH6FxTMlkW2E9teXH?=
 =?us-ascii?Q?KCtsCN3weow0ovt9g1nNATM8A+jc65KZiyxRDe+PUVEwbRrX+uPZNHln5Hnl?=
 =?us-ascii?Q?dOKZGHMo6Rc7rodui58MQ/PwSYRdxXIGOdUW784C7q4fNVCptVGMseoKdLzT?=
 =?us-ascii?Q?C10OYPpzobKHCbkLigKWiKVYULhxGlyct5tjPACAIxlbQXneBX9q0KzR/ovO?=
 =?us-ascii?Q?6AK/p0pdK5Kr9m05gTWYB72u7HT1vY7B5TkXKU7aFxhHU4EUZzfe2LGpUt5r?=
 =?us-ascii?Q?H0gC2Dj2Ox4ftNM/KaCCCYvvuP7+BbY4MgBOjtgsZIVjl+KVFUlJPAc7xXqj?=
 =?us-ascii?Q?3VXyWIIK8L/3U+wHsmx0QBzTzIpZrVLtLERiVtp8kjTMojuEzj5Wds1Kbw3z?=
 =?us-ascii?Q?MVpAnqpKjAdFNstkJhMHFVki2LtreZo0nKb+9W9z37HjcNnLBZCxQFdoK1HH?=
 =?us-ascii?Q?atpqs3ir0M8faUDZMjZvay2zKdsbZnQx0H/Ux8Ui+8iWA7bvQ5CXaX6l5WnJ?=
 =?us-ascii?Q?xLkd+J+hhGqQXUKrcCUayTV1ECS6pYe6R6ed/O2CQeKPp//j0UQSkICjw3pf?=
 =?us-ascii?Q?q76MmO1FomeIQd4GkfC21i6MA1U4dQf3hVj2GZYkYYMpfjYAInxHkofrDsPp?=
 =?us-ascii?Q?iY0e2VYZhDvjIvuRwueyyvWjUkNFSaZ2H7Jcj97iRCowA4Tpp+EHIS+AjAnz?=
 =?us-ascii?Q?jIuigzvkrhcZBKTLZYTDFzvy9m28t2FYjyvQm1SdhW2EuCMjAsuNt3WrUPNa?=
 =?us-ascii?Q?jre8c+459tsftoA08h8HLzefrq556hiZMM+kPPp3hR4ZemF7RU5c1Zqi6x7l?=
 =?us-ascii?Q?gP/EKGvn+5adC+qJLoAk1iUwO7h1NmEuF1dUT81tULb6+Cxip9lp2ulBzecd?=
 =?us-ascii?Q?+m+W2Ha/6gR30dakvS8yzOYCsE9iekVqlbUjWxdexCizZrfBaYqE/x9wCQTO?=
 =?us-ascii?Q?SJJNlwXae+lR242D5bUHtWxV7o4v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+C3aU9/kT9ej+E+A46rKwowSePRQwWFU2vGURMDIYU4MMjg+lCxiI0t14uGU?=
 =?us-ascii?Q?DlWOUeiKddVmc9hdFYN0MubZCbaTfCRlB/pg3BS73jLASXbGf+7Kh7YAqvnB?=
 =?us-ascii?Q?AFyA+kvuYOujaEWOPp74QU0wiWePuB6GNtzx1lXGi/zSNivvkRufeZigPCkj?=
 =?us-ascii?Q?fcnf6dYRjymPeTx8q74ZwrtJq0VWOuXtvQFL99F1fwRbEKaECidjoIJlwcO0?=
 =?us-ascii?Q?hgO74G3EcFoXlIw0C9XhqqM1Mmt/DTMHpylkQQjqEYD08p5/gC+/1JyvLVrt?=
 =?us-ascii?Q?Js4zVkW7IUsrWXNkMwyVv5FdHPcPJDCi77Z9FevnpV5L9GcRyHRFoXPdfwgU?=
 =?us-ascii?Q?s9zc1rnjxMeQD8QNr0DkicESIyZMmpiUslPRP5Pme3VOJJF207g0JGVzIxdv?=
 =?us-ascii?Q?jT4G9f9Zocp+CXBSc/MI8bKKpaz5EnPqVGB9l3m+TJSu9+juKhJlK5EUd11v?=
 =?us-ascii?Q?QM6RxnMmMgOIIKZ7jsUSa+4jQtlmmFgsOAFVhArqmD2SB2nF7Dphtw2kQ5Ev?=
 =?us-ascii?Q?BPPcFVaU2WoPi4LzgViUk6GNySfIDW4nBZJ/q+p2cWAlsSE5emrPzmcuzQ+D?=
 =?us-ascii?Q?25hGctF5JsIGnBaWJK0kZZ37Cfu/KoeocA+ICfZRrGqOGzdsVx2TwxS0Byau?=
 =?us-ascii?Q?tHALSIhffEXEEylqRPeKWNl1eTzcX+nC7CZkwx6xjNdPWCrlzkzTB/a9Jjgm?=
 =?us-ascii?Q?Im2vgRXg3p4hygk0bw1S0QptBGFqmYRXeJNZo8acMQ5CAcFPVbw0L2beLigz?=
 =?us-ascii?Q?DSz6qRFel3twApILrp2lWbCktunk7z/hKMHZVGcTz2N9tFXkL9Fw/5P37Rdo?=
 =?us-ascii?Q?TCdI597On3NlYa8uW2sNfM4+imB2QgC7sUPVev6PM+BOXQSrgRf3aZf/BP3Y?=
 =?us-ascii?Q?64h4GPu2AJajlpKFLYQNl9QsWjPYEhdmLitXy7cjQRbodO8PsBCx2qZVup61?=
 =?us-ascii?Q?N5fPBmAR66ISohC8BlnaZ3B3HrEssKuPsMNISyofYMwE3tzmiMs9dtIQchkg?=
 =?us-ascii?Q?dd3yDKl/fMua5M+kJ14TW8jQtZvmb1PQM/L95oHOMXnrSNSyt7GKr2A5snXI?=
 =?us-ascii?Q?gMCej28Hz10E5tG9sN7UO0vNy+dnVksasABZHQgZZAMmFJMpElOVlNLFmAFU?=
 =?us-ascii?Q?XbYXk06BPMwrp0szZDZmLjxS9IQ/mcu1GsbtMA9WaX7fvGSo8/mfl9gP/Cqi?=
 =?us-ascii?Q?aWndTrSHICPbT1D5YcWSr7Isl0fQQgGHKMIc1ePIskVnYCY0RBdXsc2X5OMn?=
 =?us-ascii?Q?RVPeaY90U+lB3sR1NdWhfHKesxwGh8v+aAtlnbuBHmQN7zNeIjh9Mmo6GiyX?=
 =?us-ascii?Q?1WBkveC94ZsshQDZopGtrwbiuKy4G38eyM605IsFUEsfKSW+qlwX3cU7wZZz?=
 =?us-ascii?Q?DlmTRRcjRKkkfB7JCqIA75/Q8pXALgX+qoaW5vCInYmVxCm2GUwQtxJ4b4YG?=
 =?us-ascii?Q?yFKL7Uzkojn7Yblgz1VumElCq8VM1z0iGmL+/XGcjgGb2qFH3oi8MGUjcsMI?=
 =?us-ascii?Q?FyBfL9WJ1LrY720uBG17REWBNGQOvvWcHnJno7nHcDRa6ZZ8KRriq/3BgP+g?=
 =?us-ascii?Q?AoXy5SBNmN22XZW6UjrzjAgWcA7Rv+3faEeb2x3XkNQgbh2dygdk1DYDQ2AC?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d806fc-d31b-4b16-a916-08dd518cba9d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:58:22.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM+nC7xcDbp5OC6fHqP+t6SywUQHe+vI4W2vH+aKDvNEZcAbkIOcj5fhqvUfH5ec8wZCaicK05H1uwSd3Q2iyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9121

After detaching a bt_bap session, each plugin that registered a bap
detached callback will be notified. The bt_bap user data should be
set when calling these callbacks, so the bt_bap session can be
matched to the associated service and the cleanup is handled
accordingly.
---
 profiles/audio/bap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c503f250c..6d2afa2c0 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -192,10 +192,8 @@ static void bap_data_free(struct bap_data *data)
 	if (data->io_id)
 		g_source_remove(data->io_id);
 
-	if (data->service && btd_service_get_user_data(data->service) == data) {
+	if (data->service && btd_service_get_user_data(data->service) == data)
 		btd_service_set_user_data(data->service, NULL);
-		bt_bap_set_user_data(data->bap, NULL);
-	}
 
 	queue_destroy(data->snks, ep_unregister);
 	queue_destroy(data->srcs, ep_unregister);
-- 
2.43.0

