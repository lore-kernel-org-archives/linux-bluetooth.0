Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CA156968
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449917; cv=fail; b=GPKTFxt5G7fA34s485YQuIa+gZBBCsVrNKhcFz0AFYlLY6w86jat6HJfOI8asXaGavcjXXMxl8tsUc27hovKNPhHTAXJ6Q8Np56Uh0D+8Appp+jOBrzfVh2GpljvT4g1ORrHV8QgrjboKa/WB0d9mh/CuX8KCb1iWfjs8SF+ue0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449917; c=relaxed/simple;
	bh=fmVg7XgrkQ0RmGn5WMTBWeDUIbvmWAl0cnmR5SkTtnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tPggebPIF/K++TVXTUn9xwppEi175iuFQuYuyLdxsM7GS/EYlVp9jlAIxCymtUR3ceMFdfr6yY5iSXLAIpCLRxNTo0YRLKD0RzW2gCF7rLi/tgKhl2aktujbNSxRoAzPbR+TikzA+yVHiyeuVz1HGw3q83we2obtjO3Mhs45bRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cax4tal6; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cax4tal6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbD6yEsde4IRpShNxRdTgFpRREJn+DmPuF8S3rb1LtqPoq7UfYSDCJhwL1rnhEL42DhSgY9n86ztF0FGINZUAP+bRsAXlVnoXDf7PjmlzRswPrb0f4DB0spRrCzKMuh/Xedb+raWQRQXSpoG2355bjE0u6v0y+GNbNqQBeqX8kASz33y58CSQ6UFdmAkK6bq2tlDSndCf5HkN+11YlsTEONog2Tkii51Sq/BiqH85X8eptsgIU+yEvAp20XcQKFSzkjh1XyyUj4CUmxI74mlBQ6HWF0YocofflQtOAOk8UOhuaFyfMhk6DQEFTQ/Dkh7SxYcu/RQtn57hkWaIBqhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IscxfkjRIQH4lZLX4mtCT8uvJCa/qmHE+7gNHnkd61Y=;
 b=uVjQeF09Hj2XAr71C4Bw8MDfgyM2RRZF+JUI2m+MFF5XjSDvFSeKmPN0LhitkqF6tqOMUsaNoBb1GQXK1/WeFaUdgsRpJJ7z1nysrQv0qu1AqjgXpECMf+Icbwd/N/t2tOb2yfkPM+VC0P/ZhIy8JRe3UsGuuVvA+EpPy4alRJLMBGUaOZkFX9C7PzZiDPNYkLVfOWRzdL30pU43StrX/IYrce+yLkBpEZpxZAT+hvXAPy7Y02TSZ8JdBbwKhz39NWV3wgw7DTe+JJCn9p1QYi9i0L/0YkHui5Yx+cAYLAWbItCEqbQPTYXdu8NWGoYMV7+1qqIPactdaWIFm0MS5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IscxfkjRIQH4lZLX4mtCT8uvJCa/qmHE+7gNHnkd61Y=;
 b=cax4tal63tY3gPWEBCUb0bGAy+TnzMM6ChFQGf1gQVBtvC0alWTmi4eaiQb8J5uKkLxZHhNDgDIhey8Hxv9bxkY/0Wkv0EkpXd9M+kYEXt7R6tRYgzNwQAmw8zdH7i1ii0l8DqzOJPeD/rA8F8A1eLzd7Qm/hpO3KH24fBl0sWbnOJVsE3aF+f36s+d8d6Hm4g51GB8JP+gW7SYXE1OGTiRI9hMnIXn/GYhUETjLueNupsWvuilbUXXoZ1aYk6EK5EkFPtCvPi+WHLWB7oaLxZwSk3jNmTeyb4N+TsBWi7qNYr/3EXI47lA8fnRx9eZuZqWyV5Ep2S1ui3gdAHbtmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA2PR04MB10215.eurprd04.prod.outlook.com (2603:10a6:102:409::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 08:31:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:31:48 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/5] iso-tester: Fix memory leaks in iso_accept_cb
Date: Fri,  1 Nov 2024 10:31:17 +0200
Message-ID: <20241101083119.4510-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101083119.4510-1-iulia.tanasescu@nxp.com>
References: <20241101083119.4510-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:205:1::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA2PR04MB10215:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7962a0-0362-4ad0-f306-08dcfa4fa087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URaXnWMkryaKwlIgNHrS/hM8hjM0xOUeyPYFiP4uJm+vGMknub+2QCSAS+1n?=
 =?us-ascii?Q?tLT4dYcEucuUcW93f0PDHetueptKs6TCBnHDvR3/XFOnDrwrKvsW3xMbtNME?=
 =?us-ascii?Q?NTA4awgPw/w/uP4CTbMVPd/wqMvMjt4egplfq/u+KTbmY2jPlr6DRRDiFUGR?=
 =?us-ascii?Q?XBI/Q+agleuTOxz7WZLgx5yB6nG2HFfABDJ0RTcwUeLp4nAxFDJiLoOWEdmk?=
 =?us-ascii?Q?cojuY5deqUNcb2NUJX35huQnBiOeIxoHMfi5cZC8qjoKqLsJiI7NHRfSkWDf?=
 =?us-ascii?Q?PCqJoQrJfdnn9LMLMvaBHVNqxh/uUB/T/ez43B6xNEmTcXEpzExhC+n0nJrb?=
 =?us-ascii?Q?/Zc38wwipxeoslkQ7keIlHhcWFzswBbMStNL9zml/CIixNxnDTPeZTb3blVS?=
 =?us-ascii?Q?HlJpLG8ELVMQx+M5+4cw8IyZLhtNE16VjOiM8vsmgIcyWgU9MhEANaLqNn9Y?=
 =?us-ascii?Q?Gj2xK6O2BWTfzKXOgoQXa7y7vCPOK+iRtL72QlYBO2Ob8dSJyfebfTqHgKqx?=
 =?us-ascii?Q?FBF6sS2zcP2MVHYKVhto49MHNMimECX2zR/FaE6bkNTtsDKc0VWpR3ZCQCoN?=
 =?us-ascii?Q?vRRuWOa2+WvnAa2QK2HYd2F4/Qc9mEmsu/m/VJLzoz5J8j9Y0m//H3qDTh6V?=
 =?us-ascii?Q?LHtWSkVMhqQ19cMavWn7xrgoMD3LQBzVUnhrJxIwBZQgaYbgF2E99atHwb2s?=
 =?us-ascii?Q?ccYm4c/lLcXIFfUd9mUme+RDbuKrEb9CfQaLRw+t9y42HpA05SO4ZEJvpXRx?=
 =?us-ascii?Q?k+5zj7FrcwrojHGoAEcwNXYjRh1Dpbb2ao2gqZayK/ytadbtdIlwboeQ0ezy?=
 =?us-ascii?Q?+drwDCaKxPpscF/HV8EDbOTrJYzAo9hQn5eaX01DVflC9q/4P0YKL4WOOIPE?=
 =?us-ascii?Q?3fF3QqFtw9s5rp+zc+Ar5nVWYMFoI0Ncv9MUZFes1hsoNBSycdlb/iYU2XgK?=
 =?us-ascii?Q?vBDpZ4weqAUxvNsI9MF9A0NoUFsxqDFfcBcwaro37B9852tRd8Bc2Xxj5TFY?=
 =?us-ascii?Q?cX2T/lAAUHHEbS9Mk0ikxbhOdFj359ZsUu2nRIDeGnSNn5VZV1xU4LQVFOcG?=
 =?us-ascii?Q?+ecOcg9yJ/Dh9plHZyAgke3opYT/ZOqIfJAb/9sbrL7uVzwHVkjuw2kXmklU?=
 =?us-ascii?Q?nXeECw2msbeKC1vM7NJ5zdekdXQ4GMj31/8/dLkeu6N2Ag+PVWsIKHIK3gQt?=
 =?us-ascii?Q?XsE0ejGVkKBqOpXHDQoyO4GJ/xKV81QHsQ+s9FzXfk+IutwmewHeF87b2UKe?=
 =?us-ascii?Q?b8yeX4Q4T51cjEbFsAPZi+eSg6+yan4ikImF5NkNunD6YWLoViq6AajegO4D?=
 =?us-ascii?Q?TJ3FuX2bLzymAbjVCFAbK6Qbt8DS0Poq2xXePJyAJmtm2FjwrTSgEjWa1Hd4?=
 =?us-ascii?Q?t9b0juA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yMqhCJ8UHt6PAReeXkduKhda9xwbsy0qmu8NkfUwmdwixBCcouzsNb0UbUsC?=
 =?us-ascii?Q?hGrw5nKc1+7aZt3U1xjmEfLWXPTjaDFNEhnZnvX1N607yX4H0+MEUlvEsnxs?=
 =?us-ascii?Q?8VkUxxNBeFkbQCHQVVkbYVGBmp6PwtiR/57WX6FGLuhoSoTUsi59XDw1PVgd?=
 =?us-ascii?Q?TmNyUX7gioT1Qnv8vozDBgpOsw4cwc8ZP113HkCBnMOpyshGCbV7/xsAdeH5?=
 =?us-ascii?Q?akD1OCwz6rSLfAtRgZoHx5RCtEVBkCxSgfMuy8ga5foYicvSfzY5gJR6gxuI?=
 =?us-ascii?Q?E5M7GIFkBrsa554bnb9jygHSfoDn0oO2XrxzvtfwiEcx8VoHG0N3srEqwizM?=
 =?us-ascii?Q?ihtIKg/4RLm8fsjIr241eHbs9ReiqpPmjGPvq3lEOd6RoqfXGog/SL1KQpYc?=
 =?us-ascii?Q?qjtYiQJPeIbU/KjHJKn/saiVRpUJwNbNqyPgx15ljU3Zt4KxSPyeVdn38yex?=
 =?us-ascii?Q?tXgt5x5/UniDcdlvolfM4U1I2HZrom9XTqWFFxeP0JM2516Ex6wpFcFKZQ9p?=
 =?us-ascii?Q?h9BBlDNwMKzTP92OoSZ2nPR/eIZQ6YKsYV7pCuQH5LJCTOD42BtkwJjd+ZXm?=
 =?us-ascii?Q?hTlGo/2IHgQGehqEYMypDR+iVnRN643cdc0kQ8lIKLeXXyYB6D5og/+/ykuz?=
 =?us-ascii?Q?/mfIZP1NyZac7jFu27SuEHYEUyYEU4wys5hkCkNC4t2sIFFEFTW92DQAwDMB?=
 =?us-ascii?Q?OZb010+QRPLLvm1uEHqsXCMoS9qwd4QMcHHPL33taVsWiu5iEmW43sSSj+14?=
 =?us-ascii?Q?mWV6dOXLT4MsXILXuAtppueMgi5q8O5n4pa3mfpsVQNTvvwXGOVui7pm/KIf?=
 =?us-ascii?Q?d6sVDjs6cplHtZmXaw0yyvFvU8apVcYNZGjUPKPtBJRg3MAW5n0AbBk8lhJv?=
 =?us-ascii?Q?z+aXZ9S2UC7VfODKelUZtjxiBaxH7PZ14g+MWR1DX/4d4hnZVpYpalG5IdNT?=
 =?us-ascii?Q?JLR/TeZMaN0S4t6D/NU5UjoDf9zf4yXk8cuCVigc1nhA52t15jCrSYl3vfFH?=
 =?us-ascii?Q?C+iPUtOlchUMXoEBFxcZAnNEtkGe+s6lN6z9Xz6W9L3XRlxDnncP+F0PdLx+?=
 =?us-ascii?Q?imPkuCR9G9tgXWkACLhEZGp1Gs71+lEol2WHkGJcwTwJ+rjEeL/r1TPSHmlp?=
 =?us-ascii?Q?KeepXPcVegDOhViCaCLkGjvP9Fmh28rWMGP+Cs6Pv590nzO4ELF770SKp13l?=
 =?us-ascii?Q?2/8Uk9BjLXAQI9Vm/Y7pGzmn+cHVemqvZ3ExiJYzIL25SbjQABLuz5IFIAj0?=
 =?us-ascii?Q?BVY1LMpLOMv9/s2oZ+Too/Kg6rSqqmjHNA9hLb46gOead3E2E3H/cuVghA0a?=
 =?us-ascii?Q?FSu3SRSuw+d9SHT25ri4oXaVJia0p0a4OsknqWIzTcNdOc3r479brbkBuZRh?=
 =?us-ascii?Q?2PbGuJ02Y0EIGrwE0g3g19iuZ/bN2tN+zVdYw0BdoRCz+LordkMqCNWoo7VR?=
 =?us-ascii?Q?arvX+wkG1bQD/+M13DWAlJfUdxfwldEZ10TU19eso+xKXxhdXgLY4ApU+bDh?=
 =?us-ascii?Q?Lj2RP0SxL3sCt/O6R97OnNVuBvwg6/QtNqEhf7W4nu2YXOuzZHWXij3mZUA6?=
 =?us-ascii?Q?FkT3MNjnm4O7a0w5TWR/5rbineMJnqb4ZyERlMyuQtVc/6OwgQVoJFn8RY3k?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7962a0-0362-4ad0-f306-08dcfa4fa087
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:31:48.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg6rRuZFzkqp7Xm7vIpA5jOxqcXM2HsVsqwbGY95eCw6wnpmbGAFPxST0wXj+5ol/DI71/02ssIfhHU+PPnj+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10215

This fixes memory leaks that appear in iso_accept_cb because a new io
channel is allocated but never unreferenced at the end of the test.

=================================================================
==20460==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 120 byte(s) in 1 object(s) allocated from:
    #0 0x7dcddc8fbb37 in malloc ../../../../src/libsanitizer/asan/
                                asan_malloc_linux.cpp:69
    #1 0x7dcddc719af9 in g_malloc (/lib/x86_64-linux-gnu/
                                   libglib-2.0.so.0+0x62af9)
    #2 0x7dcddc7722bd in g_io_channel_unix_new
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbb2bd
    #3 0x5d3fdfe28262 in iso_accept_cb tools/iso-tester.c:3004

Indirect leak of 6 byte(s) in 1 object(s) allocated from:
    #0 0x7dcddc8fbb37 in malloc ../../../../src/libsanitizer/asan/
                                asan_malloc_linux.cpp:69
    #1 0x7dcddc719af9 in g_malloc (/lib/x86_64-linux-gnu/
                                   libglib-2.0.so.0+0x62af9)
    #2 0x7dcddc70016f in g_io_channel_init
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4916f)
    #3 0x7dcddc7722c8 in g_io_channel_unix_new
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbb2c8)
    #4 0x5d3fdfe28262 in iso_accept_cb tools/iso-tester.c:3004

SUMMARY: AddressSanitizer: 126 byte(s) leaked in 2 allocation(s).
---
 tools/iso-tester.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index e80c2159c..41d46f554 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2987,6 +2987,7 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = data->test_data;
 	int sk, new_sk;
+	gboolean ret;
 	iso_defer_accept_t iso_accept = isodata->bcast ?
 						iso_defer_accept_bcast :
 						iso_defer_accept_ucast;
@@ -3014,8 +3015,10 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		if (isodata->bcast) {
 			iso_connect(io, cond, user_data);
 
-			if (!data->step)
+			if (!data->step) {
+				g_io_channel_unref(io);
 				return false;
+			}
 		}
 
 		if (!iso_accept(data, io)) {
@@ -3037,7 +3040,10 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
-	return iso_connect(io, cond, user_data);
+	ret = iso_connect(io, cond, user_data);
+
+	g_io_channel_unref(io);
+	return ret;
 }
 
 static void test_listen(const void *test_data)
-- 
2.43.0

