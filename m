Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC8B6FBF
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697777; cv=fail; b=HXPqshMWoRF6vLyNq95pltnU/GukKqWvYSobmSCtl7YdwNWnv+y89kVJAx823iWKzpvxAX+cHygMMNDEshvRRCuki4eg5EitBM3kWFbkPzqQ8M5+6818eJ/FzsryCdk2VJAQGxXErCPlsyEEtZFPI05o/iIbz5O5yLa5X/+ZO98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697777; c=relaxed/simple;
	bh=X8hWEw1JmSQBVbujJKHdvso7nnOZB3IVymHyUNNki+A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iNGHG6HZ1R/rmqFFS0SlkhLHOIpb5mPnjgclmsekFoQpgrpwRIsE/BftzWzeTuxOHayWjAEhDmRUrC53nA5rZckBBXmA+97Z3kdIy1kBfx9C+Dt7oRSuF+Ii8yYNXA8x/saF7DQW/hYglbBFctlViuOepd6+1nPWjInPP7M9tTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H5xq7Pbp; arc=fail smtp.client-ip=40.107.8.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H5xq7Pbp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2o19f/XQ1YG2TYx1gyfufnpIEHK5oVw4jl4b150MsVdCziLz8wq3U6vX7ZYrpXi6u0SDSNIb11aQyUgwiMOm8tRzEe1Mx3T0z3iZYXZQKuH9Z6W9hSIGXEnGYDkkeRMAvlUrwuRJFcsje/jSRRy8WoKrUjgtaqm6T/sEK2uArom7fwaNe0toDlzik5TGPCYFgIsBYmUtsXNxSss+sq3xIGkqLccpBxlmn+i7WuatpT+FY8J/A7fuYd+gWNq6SJoaXH8zmkBUjntvBu9i0dbgRkFjvQjZjoenbRDLkwAQzjaYkV6c5hqLfXCs0KOczFG/NUYGza5CaHp3gP/9VT8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWNgHKDsUBF2FAOptXzTqDT2t+iKyKk7xZkGbV5xwo0=;
 b=MCpe0QuIcmDb3tG1CMPTOtJdIqJnZ7Y9jVh08K484/HOIENxFHWs2ofJpJxgm2qoceKWko7C8/uPzi5d0SA6z3CEJS+5mxI8urAeGkorYseFhf+Q4MTPMhnKP0dl+kVPjq1M9QRFLSQ40dtlQRrFxDMu/qORjaqjbPE4O5lUl+Ini3nfjSxvCWHNh8BPHNRise1W5zJRubHlyjxylQY1qXvxXQ8aAUONHdLrBGBtLVv9/V4hZOmvHbI4oOPKvh7FK7GwNJxHMGFj+cZrnb7wvlOGLk44dYYnr6qk9vrafgzkfPN8bIc8FgYfaUknlZt0dKWDwfaTGO0iSo0T7mDwtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWNgHKDsUBF2FAOptXzTqDT2t+iKyKk7xZkGbV5xwo0=;
 b=H5xq7Pbp0ax314ejEFwfqrQpR0EjaIUqmS7tvA/oiAGb9jFgN3Yp92mhBD/6nxIoWakjXfjk6TMk/LIBQ7dEXj7pRy/NFiuhJlYmUS0Oq95CRaRukysl9focnqtJc5YmiDSrK+2GNngHlTR6hAOGDx7Rr9N+q7CmAClNND1RQRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS5PR04MB9731.eurprd04.prod.outlook.com (2603:10a6:20b:654::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 14:16:12 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 14:16:12 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Fix crash when unregistering bcast source endpoint
Date: Fri, 23 Feb 2024 16:16:08 +0200
Message-Id: <20240223141609.27181-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:205::28)
 To VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS5PR04MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cac55b-8a7f-46f9-0a8b-08dc3479fd65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P3wsUE+kAP3dWbB5Bb+FPnu8d+9Hli2Mahze8a4shAG9Oe5bXY2Gg28m82u9wfm5m3Aidrd7GCWBefoQch8OMdkAtKFQ8mHIUYi0kWHnUMwQsluEcd8WrQbcqJHbd5CMgYGloBgvn0R36A/SPOV5OWfWGHoLM56yyn5VRXA+W5t0yRx1vpr/BJPlJHsj4DSB4pZTpgxJPxRL4gJj61Fnfc/j2n+GgN1mNwyWLSaO9Mhflphxeuf5/8tuyeZBK2rMlf6kjlejcaEAhexLeOdbiu4UxGs/8GQ9b/TTW/mFGM8CDKgO6cXdiUTlg+/GCIswuWQSJMZUCTP9Q9zcceDXH0QMsQSSg1kQABKH+WA0uqewkuYQgZlsmEMluYSAEJGBYBPTIOSXxDoFgVfu7I9ug+gveCF+zgkFbNM7XOxnuSRNeRLcHiyhUHV+ifx1Syi1iu7hFgSFJCtFUC0i/vi7ZBLGEDB/U85adIoOQt01Gy0W/2vdE5ZRLhdCp1bbbEYjMRhRR59xhUINTK0ITK7py5YwKPzNj4oJ2mvz4OBX9II=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gl19n74/DkyN7P5evkYURaFQWVN9EULcjUqVXKV2AxS+0jAj7+2r1BQPKtk/?=
 =?us-ascii?Q?JedsGcdha1BlaqlkgQwiXs2/QOgtq1T0rkXOCbwjZEafCdqPw9YNDJeoXsOA?=
 =?us-ascii?Q?VhBny9gHwVVYEBkdWaC+AbnJJiuzIVeq4CpUXkR1mGpVsRqS5P2Sz0AdzLnv?=
 =?us-ascii?Q?8Iu/bn9CQoDHBTn/bJKpkFmxCoDyxpYnCeWi8L6IcUN42A/whvk3m9Alu+Yn?=
 =?us-ascii?Q?/sr1AghdxQIJMx2v/damQOmq/CECT96ZNaEhd2q1xpBWKqV3zp2YOeBSV0xt?=
 =?us-ascii?Q?a49H7B3vxLDqGuTIvY/pK6bSmtdvn+UkLQkYwUvAfC7ha1T8RaFimTfONPDE?=
 =?us-ascii?Q?iRJDBGLyl9NZV/vhzdWYG5G9xnOiIQ4c2CZPlvW2GKrA4bz7ddWagI2raBVi?=
 =?us-ascii?Q?XIZYUFdMy9FiupEm2a8+wITPbHYOJgWStp0lJu99IaVIt0UtVU1TXjqWFGdx?=
 =?us-ascii?Q?klBtLbAR+muVGt1d4tWcDTYsbucVfM7AujLzxJSs7r4zeETzDzXlmXF2rFEk?=
 =?us-ascii?Q?bQzvG5pzvhxBZOlpxbi7mH2uSZpCnWxer6tVJKS+sXhx7caOUrDd9zlKpTLs?=
 =?us-ascii?Q?Rt3fV6jgbzehbFllNPsaRA4kbMGZORxjpOhwVwuIEh6pQsYfoW8/0BCmun6n?=
 =?us-ascii?Q?/V7NViNLc02eKMW3h/QMSV43qm6i3MCBrUR3WqQ6qRpIb/BfdgqMiU2IG8kc?=
 =?us-ascii?Q?asRH0IZUknoKq5xaHhyV2iN0DIMrPy3fxv2KqOXOjf+FPVHpns1tjtkaZLgD?=
 =?us-ascii?Q?qQKfbGHPnONFMPvvRG50j68qHHEGceaRWLCwWMN38EcQWfenB7x/BSZIKSHQ?=
 =?us-ascii?Q?Ig8CEqFVkUZUc8yI6128K04s5g8eILoomn0PzgNthqgWQUR5Syg9a5fObU6i?=
 =?us-ascii?Q?pSh4uLP71BDQkHOA1bMRWTHCRdj/HvGS2Obmog2k1l1CBzCOWYa4o/PNWLOG?=
 =?us-ascii?Q?amzKEvjltEw8zFM3z4tjvRdRne8XT2GhNilA2Vkm0o6Qore5j55zEEgxOOBy?=
 =?us-ascii?Q?envTBqUZQcumnakFPDl+X9cDgQrzzgu+Bxc+hgHEnEPwL4pIe4lk29y6SJyk?=
 =?us-ascii?Q?KK2jpAG6fgoqiSxVEe+5VTtCdl+8LlKtejJyp4cdIujHz2G8Uo7onJxA/GvB?=
 =?us-ascii?Q?aXxNSKyUd6ggOOJuMpoZ4gm/QaQHeor5qvah+iMF5Mzuy8yluyjLRkiYOSIL?=
 =?us-ascii?Q?fuRWDxVBFLr9+qlj/JlN0lXE1w0JKqLUUu9dG5GiwRo3NV6TfC25XpU7SW/U?=
 =?us-ascii?Q?4T9HmAAXIOjTvpu2ebVh8fwexEccRrBQYS14WyiC2SesV5uNUBXWyI0t3Raq?=
 =?us-ascii?Q?e7IBnmXa20tXviVJsiVXbz/7xXgatpdi2VI54Q9XvCMZud++N4TC7p0atv2F?=
 =?us-ascii?Q?ccpk5HwyOdy38E3PUYZO+T62WXzqSXgK996yDEKj5D+PDHFHQd77LOP3c887?=
 =?us-ascii?Q?iU8OefP68bRE0SC9mkqmb7re29KSMV7xHgciiCpIIaJz+DxxbIHGt3pCkknY?=
 =?us-ascii?Q?bLTO9aDu6+N5KHO1BB1RDn3ww9a+ZUsZ8pTTY9muOHxWAwS0E+85mnYbRss1?=
 =?us-ascii?Q?yIw2VsrP37+cJddjY/1d0jpXoa7muBZtsYRZUR8qkcl1OD215psSO7/xqEmu?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cac55b-8a7f-46f9-0a8b-08dc3479fd65
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 14:16:12.7633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnWqGYSOY0X8z9pHAKKTeV4MUbe3OYspU9SqsQD746xE0C9B08+7mbT/ETNMi+TWIEz7ujQb1lfSrbPFX1KYPRbqRT5nNcEeDDhKFyAgTAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9731

In bt_bap_stream_release stream is accessed after free
ERROR: AddressSanitizer: heap-use-after-free on address
READ of size 8 at 0x60d0000001e0 thread T0
    #0 0x556602a14ce0 in bt_bap_stream_release src/shared/bap.c:5423
    #1 0x556602981292 in queue_foreach src/shared/queue.c:207
    #2 0x556602a0712a in bt_bap_remove_pac src/shared/bap.c:3572
    #3 0x5566026ca846 in media_endpoint_destroy profiles/audio/media.c:180
    #4 0x5566026cdef9 in unregister_endpoint profiles/audio/media.c:1708


Silviu Florian Barbulescu (1):
  shared/bap: Fix crash unreg bcast src endpoint

 src/shared/bap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: a16c2ccf9c256285188f4549b7b767cf31b100eb
-- 
2.39.2

