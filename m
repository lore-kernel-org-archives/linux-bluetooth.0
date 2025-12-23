Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C51419A9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497936; cv=fail; b=W63gWy5EG0U35GfeinCTyU5poA1BWSHC8KBe15aJMhY9VXnuhpBiDkgYzHx3lpB1rFExVWcqRUWw38+yhvtbtQTqNbRrlJoGuJdVoeOnsQweIiv2D4f//kSCHhGYVTBf1EsT4tH1UEl++8fEFcU1aVIknEP+otpfNk2uzvUKQOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497936; c=relaxed/simple;
	bh=ZIstN7rUYYxj7QHBMey0YkI25j1YhKYlhaRFQNH3ArY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HMLbiEXLM2DiOUBE6GmG0E/2pnmUSk6lTu0UDyi60SVoZNiIj+n7dZKoopX9Ax1yXRQTS9OUMRSnVsJIh5DPCw+AVHlRYLUEuzPL5Z7XOrzbnBjPIIGi1wkUps8JIPWcxa3DQ7sfmKgaWuUNsPmdWKOKDIHmvTfnUrXXKTqWbzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wb2UvLwN; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wb2UvLwN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CFEVWYGCcut8Q51kKHoMtwkjdgsCJYiHBbNOcVm+MdT1bRRskKDpR6nacwgOUg+5jo1iLK1FRELSx7VS7mbomPf1b0vfmMv40WJ73wFC9JkdsvKTZo674jBwizqGJropH9EwR571J3dRTGPs7oZ74IuqOGUaKhB1/I/com/hXcf1CvejqZh5l1y4/2eLD1DSZgr8zZjPbdXZr16eX0oiSCvKBnCTEq6WSY5gCnOjcoVri0/KobQvqaC+hzJjS86ArdkcZqHERJ+e6XqS6hG+K1IF2U9IgFvvhn8LPuDpxzB3X+lUjdtuNDifQTJ1lPe4QKKmlV1+QnhXMdrtsRAqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkFcjUEisokop5eBqlaNvmBFBqkquAGj6+BPqOESG/k=;
 b=nbajnik6m2TH+byalFUvmfon4ZP1aFYr6TpjZRRGLbkMaJ+PCBqOn6PQAFx1WBg5DxbuXkkc/wlqrx2OU2Y0s+mRfVKgZutQulk1BYsl9AlUgXsco1VLa2oYDsi+SX7UoTMtFb3cWnmlEXNI8iysuAzUre9WF/RDw/W3icGnVT78bkHjWHFcPQcWMGdnTUF/fT1M6Zml+QHUvdlh12zeizZW7hYJkHAetB7Ba4djSP6ST4mX+cd/oQaN7zucIRbFKqWZ7bMnw50mtuXN3V6MREexT4t9vTzbr9KwWLMqIKITQYLd3tdg5E8+LPXZTLISJGU/JWNrKVgH7DXSgCRheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkFcjUEisokop5eBqlaNvmBFBqkquAGj6+BPqOESG/k=;
 b=Wb2UvLwNQZnQTgVy3QB8OZdb7i+RhfwUOu1Jkps15eX0ThxwqDrzddKpAgOUG8ZsLwSR486jjj95Q2Ixs5CjFCz9MO7AMwYNAdpZRlsw1eNbtNkYPjbIM9EC3f6qqHV8NdWEOQruwk1MundSLmKb7GoDRmJeSjk3YZ5xRw8OPctbbyemOEDZf4u8TisGwrUoOytNkNlX5yhijUjgp5FwtlQjhTeUn+hXzT0Gr5I6nX4ilkLn6/h2NMxKmGen6s2NTN590BkbEmPBY6r6HmHtg7Bejx2H4016GeI+TZKwsLaYh1IOBoMe9QPBc0WqDUrgGmpQC0gGA1E6KioDjpsxDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by VI0PR04MB10544.eurprd04.prod.outlook.com (2603:10a6:800:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 13:52:08 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::8e4e:9bae:9fbd:cb52]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::8e4e:9bae:9fbd:cb52%4]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 13:52:08 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 1/1] profiles/audio/bap.c: Fix heap-use-after-free in setup_free()
Date: Tue, 23 Dec 2025 19:21:33 +0530
Message-ID: <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20251223135134.706-1-sarveshwar.bajaj@nxp.com>
References: <20251223135134.706-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::12) To AS1PR04MB9630.eurprd04.prod.outlook.com
 (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|VI0PR04MB10544:EE_
X-MS-Office365-Filtering-Correlation-Id: 268c0e7e-fa88-44c3-f782-08de422a76c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?84hG8/y0o0OKu8KWEBtHvlxRoWHCm/8jpTWEMMZXJor9eeOj+07UWPqoB4EL?=
 =?us-ascii?Q?C+eKtJYnj3rbP+NioFj7ITdOh4iVoffNsRmmBuNHnH4iizZTMKiMAC0XBipe?=
 =?us-ascii?Q?fTbsCOXKQFxDUj7K0AeBb0Lpi4LBjDblHj7N00nY0SE5zx2nNXVQLFBnqY3S?=
 =?us-ascii?Q?s6/n5il9aHAL+UXKfAy+wJzS5DmGNULrwQSNnvLkeBsnnL6LcVdhK6JO3uRm?=
 =?us-ascii?Q?Gnya+HvaUmPJIHU9eb6m9KYUJUeeimnNhCivb2Sk+Voh3AgTRxvCGbf0p99d?=
 =?us-ascii?Q?BU7iuCtODxmY4eVfx7QIGBPbIutyxN4GqIIsDS8dJbrvYIGnKdKLY0mYWyV9?=
 =?us-ascii?Q?IdMrBnWJSux9kKFa5sjw8jgoUzPNOCoaXRHeP1q/jtTpb731aQbJ5Av8dPr1?=
 =?us-ascii?Q?BQzP0OvTPCLD2w6tQyM6t8nphupxazY2bnsmBjAeMhS4rOdPcKZdl2mX6DpG?=
 =?us-ascii?Q?CwtuXoRDkjnsyIfKoA6duoZEjbkYbp95ikxXJIGYpax1f4eRIVjH7G/bopCH?=
 =?us-ascii?Q?99DJmD5xbMJyxbPhlAPfpDjG1h/ZM+8SPSG/pBqdWovBycqMdU9Nm6HDdz53?=
 =?us-ascii?Q?HFBtVPbamSxPeNEn4SxgcAVhZac+L3ZjASjk6nOb1pQ6iptjpQW8cLQTzaQH?=
 =?us-ascii?Q?6eqeTmNAiTcdf4R78RCoKrK3h+1J8+x5QXIKGFC1S16YsOvS1V6kUAdAr5rd?=
 =?us-ascii?Q?NNdedDfl54T1+AKBVaVEWHCia+QgfHgPPKOu5Yo71r58zCaRY0fi7pCo2Xna?=
 =?us-ascii?Q?ImME7YXggEHJ7Ie6kxmyEwPs5Vs9VZhdXf5XTsitZNpBe5pJXMlWb0Ikaxun?=
 =?us-ascii?Q?EqWCthMpAs6UP6oNYVGB0R+8D3KEZ1Z/UQN0TnOB9FKzSHorQE+I/9w6ypHn?=
 =?us-ascii?Q?Wmdff86fi4LuPxmetoy1KPGBjHr1sCn9/wsvSbURf2jb3B/4+Af3kwLXnb8B?=
 =?us-ascii?Q?3vc+NvVnSisJ/IX6+zBFCasbnBRIEmHdiSakXzKociT+gTUNPWUREPFo0aHD?=
 =?us-ascii?Q?zGygP36ul+FOMfHcO7ONdU3HGbVXgSshwWc1ij4zwVP2bEk3S0CUcCYKyjCy?=
 =?us-ascii?Q?SqP2frcdmcoSlZFgW1C5QBpCQMbX5DWVy1EiHxjpn1QlBvaqO/7dOU0ZOI2s?=
 =?us-ascii?Q?fFdYI7sOabK1NkKrsrQxaeY6VpUK7IGT7Iru/i6tGjxyIOXWdgNX0mAgCj7i?=
 =?us-ascii?Q?uAg9OPpPk0dbkJF0hNJNcTuI+e1Lv/GkrAFGxHpBznGfqxtEYBUgjplLEutB?=
 =?us-ascii?Q?9NsPPjITGWuapDt1toJJBWEnRR09og84QEBSsG9BZJQvhvF6oJ2zX9ko43oi?=
 =?us-ascii?Q?JXAzjzZKqCCVLoUQt78qXZnrWuynrPV8lCjUkrS7LWKRIum80KIlA8b2M+Ja?=
 =?us-ascii?Q?nfYbO5Pf96MxmOSGKl+dxZt2yzjBhSD6XMgQvWLJms0gr0DLPbu3aUhkfjkg?=
 =?us-ascii?Q?7OX94FceAsmL7Sg1oAzWdqBuQEWQN+PARa/Hd9IjHUeJ4AOBaaqd+f1y1t5Q?=
 =?us-ascii?Q?yV18g0EwB/19747O7NxZNpra56jPBVZlerm5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lph/ykI8KU6yBax3qXVOaJOWKfUDCUW7qgiCtrv745qxmyPR0uxN1o66xzQ+?=
 =?us-ascii?Q?OgYw3/pod5S+W+NBfg3qlysaqdhQZZEVwL1s9hiC15xR83erRr+26IWgxteU?=
 =?us-ascii?Q?qDSCuMDw2cXHNTHVbIeMH+CZYi3YjrupKNbYlnrx63mJnvR0g5hOiuPzH+EO?=
 =?us-ascii?Q?4vGJIyAkHJBVXSKvN8NS1eMyOgeicqTWpinfMC7rinIGfVYsfKzGdm3sNn0o?=
 =?us-ascii?Q?teEG1zyUxjTgEhS73et4k5tgDkI0da+NFN1BsNB+DOpzdhzfHmiizEEQKtmF?=
 =?us-ascii?Q?jehxZOYHVPKK4kYRzC0w5ifNo+ShH+6l9tvRSpTeH3Pjl03V9sBDxS9vQ8P9?=
 =?us-ascii?Q?uG/0M2SniWEa3X/d99kz4FUi50kJ9HFBCtfO92L5quphdohTGc1SfjjM9c5p?=
 =?us-ascii?Q?Wt/KO4k344WKOnHoDYWCxSAsK3O7TyXQJo3rWGTbqToqlBi19mxSI0OAHpfy?=
 =?us-ascii?Q?dOwB0wwbgK9vZUc+Wzv7A0xySoEqlHOCCdy9uGnatldoiJ/1T+t1MiJtLum6?=
 =?us-ascii?Q?BO9AGsaU+ge4CftmVU7RPDK9/At/hh81iXxHBKt+57V+HU0HUCymmoKY+Dd0?=
 =?us-ascii?Q?+iyjB3FR3DxRr9h0EfWJFPBJ8KD7VPIROekCUmbxoE+i3LB5+CFC4AguTmIh?=
 =?us-ascii?Q?CiqfuTJGrD5iLVGs8H3no2U8T/d5vAGpPENFMoICEzxQ/yPBOxaW9ew0/A7D?=
 =?us-ascii?Q?E6YY6j40n4lDSQQswXaRuFR4xvobCvyZdQ1otybIMN6g+EuYl0AtR1J4tNG4?=
 =?us-ascii?Q?YmzIe2dqF6u358LF/tEUe+fY15Qn+DEV625nN9UprGU1DzaKi/1q9AEnSDO7?=
 =?us-ascii?Q?GUDi8e23ieoUJmynCHcI+rwLBYja3ntIRO9Ci0kmcRb9VMyVHtZc1UUZi8l7?=
 =?us-ascii?Q?ywBpj+Sm1yCGScQ23aFZ0e3Gn3c0ZDwdAW8usH7Kqt3/07a9wCmfBoyTXjGD?=
 =?us-ascii?Q?brr+n3B53RQR7QPurI6v/QmITnew/wvDydJdKwSasWZq6HyfvI834KEJiJA/?=
 =?us-ascii?Q?RZis6AASMbNuWQxYoHoEBgpA1PAG/wys56nzLVcvygRoiMiPLfv5msMuNC3f?=
 =?us-ascii?Q?y7K6FTJY8iHy0O9kNuETNX4iiBoBS8wuW/+urdLgtboFKB1AkAEzxj7v6DcL?=
 =?us-ascii?Q?9et50LtA9Pr41AjIGZoTlhrl9sdxExT3sv3dWtAXKHf4odHaxCermfZw859r?=
 =?us-ascii?Q?EMcR5TfZDppqvzkEjbdMw4H8EOpupyy8CC+9ejlwi7hENpnWmFj/PGMZWN4n?=
 =?us-ascii?Q?Tp+DycJ1xmmhBSbj2fq/RLEDOp/C5UQ8dmrKgJtsZEIZfdpaeTC5hnjTGsIf?=
 =?us-ascii?Q?4POsBeYULBw4laPPPeb/8U9A5j9DFB9BGarjEZEBqhWwwf5hFTojmwxyjONR?=
 =?us-ascii?Q?S8OaZMnc55LvS9XLdyOkbC8cGEPmT32G/m5HBJK7zOYxGZXbAYg369Fj4S0E?=
 =?us-ascii?Q?7nTixzBNNiCCqX+a1cB6BbK6pdQU2L5vZrm42sYRHx//uQle8NOxW9bee/gY?=
 =?us-ascii?Q?sO+RQGcMDXA0osq6wneIFCF08mQkW+F1q8h5jIYMVB3CRKPndadTecYTFja/?=
 =?us-ascii?Q?6EPWDMKPAh5KAUjBSILXcKf5DnBsIOiK+SRXToolKYDZ87Xn4d0J8YoWjDEb?=
 =?us-ascii?Q?NLYcZOHRUs5/OjeTtSjvgAY+wVWUhiWplHcoeyKoabio1t7BdBeWxEbQLBTs?=
 =?us-ascii?Q?Ci/V3MPwXVss+BfMqJJc5dltyTSXTOOtb8EZiCxg1aeTDThd53B4qTR6Tb/8?=
 =?us-ascii?Q?OTjj8oj1jmZbGTVa8fA1Zku0AQiWjHk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268c0e7e-fa88-44c3-f782-08de422a76c9
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 13:52:08.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy4Wi3uoY5bySdcrscVtXntHwL0+MaPOKNH9eZ691dQEV5dOPoL7/8932UagYWZjn0i+hZPbw15uAX08/B6+tA7u743N8U05pcbtRmkl5q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10544

Fix crash when removing or disconnecting a device with active broadcast
streams. AddressSanitizer reports a heap-use-after-free in
bt_bap_stream_get_state() called from release_stream() during
setup_free().

Detach frees BIS streams during teardown, but setup_free() still
unlocks and releases setup->stream afterwards, leaving a stale pointer
and triggering UAF. This can happen with multiple BIS streams since
each setup holds its own invalid reference.

Fix by skipping unlock/release in setup_free() and clearing
setup->stream to prevent further access.

Log:
ERROR: AddressSanitizer: heap-use-after-free on address
0x7c43a43e3458 at pc 0x572415a8603d bp 0x7ffcdef9b870 sp 0x7ffcdef9b860
READ of size 8 at 0x7c43a43e3458 thread T0
    #0 0x572415a8603c in bt_bap_stream_get_state src/shared/bap.c:6386
    #1 0x5724158f9d0a in release_stream profiles/audio/bap.c:951
    #2 0x5724158fa10e in setup_free profiles/audio/bap.c:1121
    #3 0x572415a293c1 in queue_remove_all src/shared/queue.c:341
    #4 0x572415a29440 in queue_destroy src/shared/queue.c:60
    #5 0x5724158f9464 in bap_data_free profiles/audio/bap.c:192
    #6 0x5724158f9464 in bap_data_remove profiles/audio/bap.c:211
    #7 0x5724159040e4 in bap_bcast_remove profiles/audio/bap.c:3821
    #8 0x5724159a7eb9 in service_remove src/service.c:239
    #9 0x5724159cfa49 in device_remove src/device.c:5489
    #10 0x572415999889 in btd_adapter_remove_device src/adapter.c:1458
    #11 0x5724159b99c7 in device_disappeared src/device.c:3854
    #12 0x572415abcea5 in timeout_callback src/shared/timeout-glib.c:25
    #13 0x7f63a58f9329 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x68329)
    #14 0x7f63a58f7de1 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x66de1)
    #15 0x7f63a59691f7 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xd81f7)
    #16 0x7f63a58f9156 in g_main_loop_run
        (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x68156)
    #17 0x572415abd18d in mainloop_run src/shared/mainloop-glib.c:65
    #18 0x572415abd9c4 in mainloop_run_with_signal
        src/shared/mainloop-notify.c:196
    #19 0x5724159ea378 in main src/main.c:1550
    #20 0x7f63a562a577 in __libc_start_call_main
        ../sysdeps/nptl/libc_start_call_main.h:58
    #21 0x7f63a562a63a in __libc_start_main_impl ../csu/libc-start.c:360
    #22 0x57241587d464 in _start
        (/home/workspace/bluez/src/bluetoothd+0x106464)
0x7c43a43e3458 is located 120 bytes inside of 160-byte region
[0x7c43a43e33e0,0x7c43a43e3480)
freed by thread T0 here:
    #0 0x7f63a5b212ab in free
        ../../../../src/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x572415a710f4 in bap_stream_free src/shared/bap.c:1254
    #2 0x572415a710f4 in bt_bap_stream_unref src/shared/bap.c:1337
---
 profiles/audio/bap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index cda10a643..f30262987 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1113,12 +1113,7 @@ static void setup_free(void *data)
 	if (setup->destroy)
 		setup->destroy(setup);
 
-	bt_bap_stream_unlock(setup->stream);
-
-	if (!closing) {
-		/* Release if not already done */
-		release_stream(setup->stream);
-	}
+	setup->stream = NULL;
 
 	if (setup->ep)
 		bap_update_cigs(setup->ep->data);
-- 
2.48.1

