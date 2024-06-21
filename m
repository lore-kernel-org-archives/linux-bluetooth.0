Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953FC169AD5
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956547; cv=fail; b=ix3MnYRiAdnXix0m++hQvrLlDD6To3K3r7qpQo8xiodMbOZyCD4XxY2KJLHnU2TXiY89vuU9VWgePySLMI6jULrgqTLN7UJS9uEHxuV8c5vveLEqMQAtc3/3JGnpC/YB71RjDOunSuIJffQ0tz+7hPEmBLkPanoKwGqBghK3Hc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956547; c=relaxed/simple;
	bh=bMy2RwURWnML6Qku5TDVAYJUa7EVMvnOTnkN6+2ZldU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZkok2ZJqrqlXjZONk5R/TI8+AcNJNQ07DjMWYb5kCyjWnKEA7WfSydwaTqiAoDS8fcYd9GgNCt+fIh1y4SWXFncpAOrspL37r+Y9sentHm+mkw1/NpyUg+h19GWlpKDOAdI3tme83I1ef0C3KDMUZQJIZNSyjXGP3uHf1cknis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bC9BICxs; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bC9BICxs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEMTrGMPc+GR7Du6E8w6OLGEE3RSqRSIinPVJwY6euIoI57T3wXHdZMMqcjNlez6W8KupYLpjcJwvjJYXx1wWn7mmGcAOWT5zD2tzWExjyeFy9A/rMzyn32Z0mr2ZnnvWTmnTq4fzmT+AA1L0JPSIukSGv2whMRhUr63sokrx8fRf5Gs0ykHrr4x0JCTiCtjaj5ooYO6nGtfWgJyMRYZIamyge4A3WaLxbPNyBgmIlsyMX+uFretxkwDoTiMi3bPmWftN1I728c7VbgAMVFRgZNaDu24Wh0YnxjyNixmvBkLHC+l+jZXI6PbnUkBr8FvMD1N8kMTlNzIrbBc7I/jyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vbQdG8NI3oajzLb7VkFwBg2kIzAzO1xiIo6i584i54=;
 b=klRQn+HyrO1Os1tArfh9pyWM7/riBtyEb2Plz9Ipjp+lTaVa5q41K7l2Igol1TdpuXu7fceUUWm0dn51dsXNIYGOdNIXb4mHSXkeVTYJXh0JlkR680WVBgRGgu6PxJ3FYfXVQ8d9OJGmjv5tv4jRXOs1eK5NoJDlC1o2qI5FasdCt/Bs/8kapRaABwKARDvJBUQ5ixnfodKASqCxOdepgKZpXvLxVO83bbJ4VZRuO+1RX75+TtUEqv7ULgV206TR0wC13xGSshIsZuxzNnkcW01/bSOG0blKB1ImoP+olQOOmrm2q2taCuhYMEzxeTa9dmNvOPtFznvQ4/3hlTEitA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vbQdG8NI3oajzLb7VkFwBg2kIzAzO1xiIo6i584i54=;
 b=bC9BICxsp7GEt2osPjs4SeuIFFzwkKW1d1LBOvR/uJkpdYNhH2WJeWEc6rZB718J+zY+4Vm3KmWmnvTDs/W4Uq72fWda3tNaO0pUDk4NNd2xSrs3o2LmqqZDuIBk2KaWOHVbVE5WSQWjQKVF00jhVOC/sXeZ+fDcb5w+GiFkM80=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by GV1PR04MB10200.eurprd04.prod.outlook.com (2603:10a6:150:1ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:55:43 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 07:55:43 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v2 1/1] shared/util: Fix null pointer dereference in util_ltv_foreach()
Date: Fri, 21 Jun 2024 13:25:17 +0530
Message-Id: <20240621075517.22576-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240621075517.22576-1-sarveshwar.bajaj@nxp.com>
References: <20240621075517.22576-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|GV1PR04MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fff025c-8236-48e7-40f8-08dc91c78ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fm1Ctzox6otvEcvgEz/M/dxaCyFoqssQ6qdiQ1cVhaqmIRX3cxu8lo1lqRw3?=
 =?us-ascii?Q?layP/k38dqh98RGwmNA/Vx0pqBVz37EuV3UFXLiZDDsIibqO7osGFxmXEhuj?=
 =?us-ascii?Q?RqFwOS/fk1wJjtLZinsQb2yEFdubnJVnjmXc7S+vdb+GbgasiErJQXVR9sDo?=
 =?us-ascii?Q?rcXER35swQ25wHQ9+KT3JHznaHH0GRKQbV23LxAO747HPg7CzOeqc3k2583C?=
 =?us-ascii?Q?4Makc3l5IhY6IyGmQdoshGYZLUCAj6SJLDR/YRl9VpxzsXluJNvFkpmqvCqq?=
 =?us-ascii?Q?g59biEAMSevPwDYT1uW91aoVJ27NdOsme5nDtdJZxsNtf6Hn9BNbjxBhxxJ2?=
 =?us-ascii?Q?vrDGIZ+4/o35OIMmWWuKwxl3vW8hAcjltA1cTx2GQm6SJOmh3PYVxKSlwT8c?=
 =?us-ascii?Q?DEtiH8yuEBaT1EqPxrRs3G3f7QSRW/w5n87gBBiKeUzd+kguXR06Qvzy9KXv?=
 =?us-ascii?Q?4l3tLOX3os+vZo2qCaPXtuzZs2ouifRHOlcT0Cm6l7ms8SE+fxuucmob/Xzg?=
 =?us-ascii?Q?2NSZUfHwVwOdfAw6jWp1encOH9a1phMQJ9IYXmNrnVNarsk/jPCnah/jLD2U?=
 =?us-ascii?Q?I504xabG/9Tmsvt0+BCGYpnn58NtVAZFm5ppOfNp+fxFvmIBoFFDrbfUk/CE?=
 =?us-ascii?Q?UIDhCHvXt2wc42XRMFKYPuvCZh9OL2WvEwkziB1JWEwpO55nuqezWicRY/9d?=
 =?us-ascii?Q?vl2B4DQXP16Wt3hWg/ib6BSLFNDsJ2aeCPLIZRTmiVornYor8SK1d8AFpadJ?=
 =?us-ascii?Q?QPOQBVxNP39efmvlaY4HqLTsPTS5vGNWf3mHvF24mX/7OzDfFIDTgv8986MQ?=
 =?us-ascii?Q?4IhqvnrWTL1pc+Az3Q+brUIJmdjZy+6eJUvWnJDTPuH+JDPmuDvh/5Bj/f5w?=
 =?us-ascii?Q?slxjtWfcl5KXKpIZ0dl8had1MZJkT7hx029w4/F1q8DEDsBMqJSY1+/3QL1i?=
 =?us-ascii?Q?fOSPSRYY0jk/R06sLNzDjhRRnGa9AL1pNfzzBOOXeFDKmUhdFaFS6LaRoaNu?=
 =?us-ascii?Q?9oW8KI1RKFtL68LROQ/qP0+omB+y1Z5NYtjy6YQHbNr1cvFYnE/mu4DS6qHA?=
 =?us-ascii?Q?mBBDeKHY2tobX3F8/VDNt9jJmeaS7Vd1VVkJXu61OiTNmghiSog8UyJWKCwd?=
 =?us-ascii?Q?EhpiofzS7poShAnP5RHTNIkb5HtlALYOuuU/cDXVIZqR2FEA7icaq3vF8qGU?=
 =?us-ascii?Q?QG6I8a6Br+6tVXdncsoeqCnajtFQFxDTHk07Fc1Z9kjGvWMhmwSPdNfzauOX?=
 =?us-ascii?Q?9Ns78fnw+YpkeI9CGZ10Xq9deXMolFSZt/xEP3FrVkdBK2TeQ45++stWs6kI?=
 =?us-ascii?Q?7ckubUoKmdkTeQz2gRYrQheQz6OJJiO37zNVOb7YafofXOpJlZw+KLewywtg?=
 =?us-ascii?Q?hQLGd4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TOVDUsFaRBceCYyTnD6UT/WOiSGQ+BCvd55DtCkQv66+cdAnob9KdCKfww6L?=
 =?us-ascii?Q?+bo8jBgjnhEvfI1nVxX/H+ywzsdIMUZn1PCM2M9fxATBWgSfJhYKGVgD8SQR?=
 =?us-ascii?Q?9oGNEu9pIVuTEZnYdvznZNePfVVD2NHtnzTgbziVZxK8fCfMSg188McbAnbv?=
 =?us-ascii?Q?KG8JPt/YlF1/1mCIfK8CIyp81E+A8X9nubUFJJ4kQiZYqWAB95RxsNlTfWkX?=
 =?us-ascii?Q?vi66bbZOnUJVyJUzmGqtN/ZQd5fitDj40Yr0+1dBQyabYo5La5hQdnWcOXCy?=
 =?us-ascii?Q?2FhSvIcxKb37gd4alSTTtEKi/LsvLaMrdwEuNSEiTzgmv7FcL5nPXNlV2tNP?=
 =?us-ascii?Q?ofqIzE8+xXscof/W0HMEtKqSIacl1vd/67ZBoYCQ+gAf1FOd8zrjOuAETeNl?=
 =?us-ascii?Q?8LPqCeii/BoDVB0ckOeLhzktASmZoLgT3331MxP0DROtIhpMEBKPWPMDoIyk?=
 =?us-ascii?Q?kYoYd/ahIQQRIH54JwuFqRuCw8B+wgx1PebLfpGQ/NEqOkSk9gx6bf0mEw3A?=
 =?us-ascii?Q?NbpQQYmjlJpw1pw4+H/OF/zOu7BR4t0H0cXR5e9WFd4onITCjm/4ycEiFALP?=
 =?us-ascii?Q?hWGg4RsVMCIQLtC/psLl5gwp8iSY4w1paTFmNgoWmYuspFUteqk5FSqlNTX/?=
 =?us-ascii?Q?ytvPgdEf6Js4Ck31LWm49mzsPNDINIPuuCgvTwEJVXxsUWuPGRFPvFizbFAe?=
 =?us-ascii?Q?9X6Pv9grhAVEfXGk85K6KBjWDe6xF6SWp7w4Uz219mpndjJ1oya7YlbAxPcg?=
 =?us-ascii?Q?UDJVcmKkXsgdIMqwGQYh9V373s5FuscceaDEkfJaU7kyVKs4/KXNUeqYA67K?=
 =?us-ascii?Q?T5xlIp5CVvdWLR/qtgRdLf6AUOt2I4cXJZcs/4d1blH/vW9asENH6DpnXFM9?=
 =?us-ascii?Q?3kwHdIyzXz8v/ncYnP9pKUDi9TNPBclfNLUzNu2PMdul0Ciwhqr3J9PCk59+?=
 =?us-ascii?Q?s3j/bw0Po4o+3s72F65+ieyLAwXsdUTqug6ZMRkFXdLVYKdxD/OKStj//yU8?=
 =?us-ascii?Q?SJn4rXhHVLbZZ4TV3pJtFuVxR5cWCsENLuJhTfabf/ghVr90qNT4roc0miar?=
 =?us-ascii?Q?qYKXVAOgKsxfBDAj79MWKGLGImvmcWx92X6uUamSW3JpBB2Bp240+DeDZ3hL?=
 =?us-ascii?Q?QxbiD62AUKzew/M1dYofM7SP87Dq/mmUrjNmhgl8aj9dUcFEhMYm5DDqd1/D?=
 =?us-ascii?Q?4SBLE0Z0OOq3548VDAKPxCNZ93M8Hc4d0RjBfL4RdDCs2kKXRKPdW4octJuX?=
 =?us-ascii?Q?PZh/C7N4LH4YY+EMkOcVnJRnIMEzk8bTB//DxuDBKL0uK+XfLg17FGBrQjge?=
 =?us-ascii?Q?Db4LwCFVNz1/wemgUJtODTUpbhoKKF/a9Cy4ISt9uJ1ZAW3t7P+otxuli9yr?=
 =?us-ascii?Q?hGI6xLeY8aciXWkFiJVZVVXtIrgCVBS9OyrroorZBVvrzjqmzI6vCgSguS0y?=
 =?us-ascii?Q?i8i2FDrMtA3IPrh3hm6MNuuDjuwrXSwkPe8P2R0fAIZPKk1XnOpZoGw8j0np?=
 =?us-ascii?Q?COiWi5V8pVgB5+xAlFbJXAbxKJFduijU1MCeZJ6LQPTq6hN/HoAZ5axpOSD9?=
 =?us-ascii?Q?5rHX/jSecJh6W11LQt8lklu4HRTlbkJoVDClMMVFYtqS4Qskmi//6B4qFbxc?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fff025c-8236-48e7-40f8-08dc91c78ced
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:55:43.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8yOYc0JwauVABrv9ajRmrKHEqNWXhnsQNNPgViLNFt+vfDHfOJpT5OJGFO1oIACSGroKdSBmnwXNTD9eDsXpvM/9PqWkCzaCmn0k5zbrTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10200

In the existing code, iov.iov_base is initialized with (void *) data,
assuming data is always valid. However, if "data" happens to be NULL,
dereferencing iov.iov_base in util_iov_pull_u8(&iov, &l) leading to
segmentation fault.

To address this issue added explicit checks for data at the beginning of
the function to ensure its not NULL before proceeding with any operations

The following log was captured while running Broadcast Sink setup:

==79178==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000
(pc 0x5631fc6550b1 bp 0x7ffedd247450 sp 0x7ffedd2473a0 T0)
==79178==The signal is caused by a READ memory access.
==79178==Hint: address points to the zero page.
    #0 0x5631fc6550b1 in get_u8 src/shared/util.h:206
    #1 0x5631fc6550b1 in util_iov_pull_u8 src/shared/util.c:680
    #2 0x5631fc6552f7 in util_ltv_foreach src/shared/util.c:194
    #3 0x5631fc4b57eb in parse_base profiles/audio/bap.c:1189
    #4 0x5631fc4b57eb in iso_pa_sync_confirm_cb profiles/audio/bap.c:1253
    #5 0x5631fc4d5990 in server_cb btio/btio.c:265
    #6 0x5631fc4d5990 in server_cb btio/btio.c:242
    #7 0x71d33511bc43 in g_main_context_dispatch
    (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
    #8 0x71d3351712b7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xab2b7)
    #9 0x71d33511b2b2 in g_main_loop_run
    (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
    #10 0x5631fc738ea8 in mainloop_run src/shared/mainloop-glib.c:66
    #11 0x5631fc7397b6 in mainloop_run_with_signal
    src/shared/mainloop-notify.c:189
    #12 0x5631fc355c3a in main src/main.c:1467
    #13 0x71d334429d8f in __libc_start_call_main
    ../sysdeps/nptl/libc_start_call_main.h:58
    #14 0x71d334429e3f in __libc_start_main_impl ../csu/libc-start.c:392
---
 src/shared/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 30f054a5e..6e7634ad1 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -182,7 +182,7 @@ bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *type,
 	struct iovec iov;
 	int i;
 
-	if (!func)
+	if (!func || !data)
 		return false;
 
 	iov.iov_base = (void *) data;
-- 
2.21.0.windows.1

