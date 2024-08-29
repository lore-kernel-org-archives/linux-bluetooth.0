Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEDC1ABEAD
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937928; cv=fail; b=hc20YGAFYVDM+F+8PURBuOLMPu2dnz4AUidY1Nkb1T4QzWdPBs4Y6214x2arVjgTx6bO5iK6pYGd6DqYQgJxv90Dia3xuumkJr4OyOmD+RAd7caS6Af1+QNL66UgKEF6nshYfq/v+FoI6wxzZ/jv8GVPEfoEyJIKb22hdCUgzv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937928; c=relaxed/simple;
	bh=JDi0E2AoY6qOabO4Kf694/K3CkpWi4m2c3WOG1emJOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFJjS5JDDzUfD64cec+FWJC9m5o70wj2oJ+siFn8Zr3iSkg3NH3Rq9QRhua03ShhqqVhrEERgd/ApcBDuk8ufEu8ZPgiuKF9b/d0GvW0tqThiCE1y+LUjX5HLqzr1rRArFoRhxbOwPMg200BAndW0b94OWA1M3q7ynLAwDYSRbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ALX9136Q; arc=fail smtp.client-ip=40.107.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ALX9136Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrzePfFE/URChSZCBRP4o3xIPgTnlQI+YYAGFky7aUsC+WOI/E0dF1GE1jzI3GJmcp4EGuWAHbp0T2W4dBJghj8VvlaSNiE8buBvEXcej5EFfxZnHudFVGid+ZdepZniskwUopO3MDbEbHM5Vb2fDXYGhVQsQjTPjklhNcaWplO8LOYkmNcsyLTOWmiwyrmmgrp4ALI1lkWbkScc+ykfoLtQ8s3/mQJVoKpjAZQ+DRsz86Tbof0lk59pnBQ2osCT639/uyBdm8KFunfL9IAmUPibc2VzxV68B11GdMKvoqH+t1QmLwNr5sXUS5LJq8LLgi6gGhEGMyGs46QLzw5+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2uMz9ubI4zLD2/THMWsuoEGoJNSSH4xaMBwXPVUaVg=;
 b=XDaJriUiNmUJL5I9Ko/Ee04YXyq+ybVzTA3o9YCmRLwtwox9IHHEQDH9xsE2VhEDI42HDcIRE5vMUFdxGiyrOdyPDiYxcX1loeNKntGZl7YXZ15cUzHzbTPRh3d4Sa989c5GdYXJScseWJRdqegqpCTHlkE+aPhX2o+eSV0F9MN/t/H0B39dgwrXqR3M5LsIP5fvaZGw9azvw5cBYmfNYZxsG1qY/9M3zQQV/+e85AV1Qn1i/xt66v0u/82ELiVt2072ruQMALdTNkI82vpEA6qP8hv4py+RN23RWicqEBJFQ5ZuV9J/0WX1hMWnL8VSbcIg1eLvHZkQvtmZLcYAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2uMz9ubI4zLD2/THMWsuoEGoJNSSH4xaMBwXPVUaVg=;
 b=ALX9136Q963e2VQwieAjg8m08LDqOjb6IqVYD2G1PgrD9KCjfkwDbAijBj19kZ5zdKsblbSOttjX6paepBIoq1igiTvgXOFkeL+v7ouV63mFr24iYJaabEPOPjJTcYoFSlP5qDRjkLQG0s2WBIKRj+fu34RROBpjYn3imQurwxdbQ8fQ3OzGgYR4hPjLRLhSyTZ6wUm+bG9nI6hMNCIDjP1OhiTkq8xRSy8+OmGQ2rWv4wkNZVJByYtWSoE6+jEXQO1K4TVhKUqTzQL7CsY7aif7dgArYEJvhwr5vcAwcL1Ngbf2r+a5qLOozWwvdud3Mujjf4Q/Tz8XQ2ArM2/0Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9385.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 29 Aug
 2024 13:25:21 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 13:25:21 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] bluetoothctl-assistant.1: Update push command example
Date: Thu, 29 Aug 2024 16:25:07 +0300
Message-Id: <20240829132507.4545-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829132507.4545-1-iulia.tanasescu@nxp.com>
References: <20240829132507.4545-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa69e6f-483b-44da-d987-08dcc82e085f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQeyOBft/+ob10QpQSuwOlX7eXtPWBqGDGOonyE1pcECotvBP3Z/XDbgh08r?=
 =?us-ascii?Q?CQnFNLNIfI5YxqJRxzKL2vc9rPmQYniNxi6wzi7YXh69q+MFScOwHFVHpj/S?=
 =?us-ascii?Q?lB8XV/ZvAX8MxkxNOP4OzFqz2ekO/F0NWgm408xGM4UHMk5OYSajazNv/sQB?=
 =?us-ascii?Q?hpCu7WwI+E6J/Uczuefq0qNQHKGNJ9olBk55T43jcOCxcJGvgl1BcR+spnaR?=
 =?us-ascii?Q?dh8043zQphXHz++QnLvDpCpCTYFUNmTxu8cmiejBBNjIz4PEVUISSLJ4a5U5?=
 =?us-ascii?Q?+XWlKiyF+gIIlxBaLuvzF4/MZRQXdXQxdb/RnxJDws4zF+blUY+9Pywuhtbo?=
 =?us-ascii?Q?NmVp9NPL1w5pVRAbZhQioWvU8twSedEQacHTV5ERt98NWtO0CG/aLY5Bbj7U?=
 =?us-ascii?Q?fOaCMb/QvpkPDj09MCD0JxweGBNvGtALwZ2kENOTpTtojWOkokOjPUT2HnDV?=
 =?us-ascii?Q?90xFssXjyuQpta8AxqbBhWHANWtanuBzXfoGVRyVBY3ABv2cc34frgdZ1mrh?=
 =?us-ascii?Q?h5izzFL4ad2wNTGGodgIj/XekRsTqPLj2xeY1obo5T4DQMuJzq9thLXV2D0o?=
 =?us-ascii?Q?3PA+TEyfyI2wzreTqaM+VrhNC5IkLjHF7oQNt0LrPvVgN9jxtJXxPBQPj0Zy?=
 =?us-ascii?Q?ZW80FRaIeWSTcP3KCkB0ntgtnZnlCogVtm3KkZFjzZxASlXy93jqxIFCtNC/?=
 =?us-ascii?Q?JISixhG80JA/Wr1ArSPdu1LgXPhvb/dZAupO6Yi7JaFF7gfaGpnm2eJz5Pvy?=
 =?us-ascii?Q?XXfu+CPsT+q93EbjvwG67/avuu96cN3Wsz3VxreiheRaEZZVkJbYi5nK334m?=
 =?us-ascii?Q?+mdd4vCxhkpvKE4s8sZJBLbGp7bj6rw9ITgIZdLyPSpnuSMmsj/9XawNKKq3?=
 =?us-ascii?Q?71PRbBf81db+eBzF9tW6jzxtNTe5Gt8jWPbClNxpkR9HWWUY+93E5JJPcJJV?=
 =?us-ascii?Q?OCx0SGlVI1U4rah+5lYAU3kcFJIVyWRVYVq3lk+47dwbB0JrGz/j+Bg/3HDq?=
 =?us-ascii?Q?kDUTh1/Dn/MGZ48mMeNh1Hzhdwkkz+vdpyFRIO301r4qYt6vtgdUA9Zyl4Ad?=
 =?us-ascii?Q?oEmbxTjTtv75zuoJ5qtiVKOdSjmMiozSgazbEYxJbczT7SfK2EcpjEoHH/1Z?=
 =?us-ascii?Q?uU1hTsS5R+sbiRGjQTP5hrB3x/Qm6SlIPuISpupnWJh2w4uI5VjQHSf8vL/i?=
 =?us-ascii?Q?UAR3+mrC56ws2w5YqQc4sGRGy+2pyj2TLakT4OLLfP6zdJtylYqCeSZTJZXr?=
 =?us-ascii?Q?NTKj0fn0Sqj8iptLgG5FacjNfgUzapk6LM/jnNecKaB0Q26mEXC8RdntgGzV?=
 =?us-ascii?Q?vZ0Zi33iFVU42JbAA0TATWaqnCAbl2h/pSjIzep+adJMcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ropHdg/fyVBt6KW9mjJ/bQE2Ub8GFJakdCqn/fIGLSG6EeJiOLT1kNLYRGDG?=
 =?us-ascii?Q?vVSDl0Ejtp2FDo5yN1CaU2G/dqgr7/LpsT3wOfgYAfYvFN6xzuqUPLoUe+xK?=
 =?us-ascii?Q?B3NcgNK7+IKGV9wikwCVESvCx7eWK0jESuo0QVzyW+To2/lcJzp0uDo2QOmQ?=
 =?us-ascii?Q?jf0I/BNgcqAfa6cQZzUyaI1NEtUdzP0pIjmaj1dj8pKaPB8AvXR3v8QGuHS/?=
 =?us-ascii?Q?GP2cnyh1wmL8kSrjg8ApDYkFBZiTRqVF5ocG7UjkAtvm0Ji6gK37gNTEXo5C?=
 =?us-ascii?Q?37DHMpotxqaggu7CctPaWBssiMB7EBOmUrqqreZaQn31rmfSOgzeqoImK6zO?=
 =?us-ascii?Q?8pjS2qQDoAjC+w4nmJsZwQRzxM7bLo5aP9uDxL9a+Cjr61NRHHHZIHBt2XQd?=
 =?us-ascii?Q?ZDTZ88VEZhD6jC4XwaPYXVu8KWUETbgRwZRbVBzXxlyg7IljdD9GjSRXR7us?=
 =?us-ascii?Q?OsHdN6Ostwr8qhKu0lp6j9/M6GkAbbJAlOyJR2tSfMilhfoBFvZs3ETSyKBq?=
 =?us-ascii?Q?tR9jPxUOOUc9cReWZCb0OYw9CdoxD/4hzwQ/oPoCQPQNrhHfGKvpso4XdoB+?=
 =?us-ascii?Q?c9pobHKMyPtlmy+yXwqNuLsqe05kwaYCI8T2DFvq2wMQ8SZkoGoiBv+nQJ6u?=
 =?us-ascii?Q?tU6P2QQRf9y4b8/RSY3YOTO7Q7hFEHwEJxZ1jfo4oGLaKrXhdIfwgkzFerEa?=
 =?us-ascii?Q?4I6tdF3OnuZ/z5Bv6N326fWDqxqeujV8Ah7a958VbP8AWMD63/elhmvEAjY6?=
 =?us-ascii?Q?WB8qg6nY7SMjSDSj1i4pIh6KskKJOJeYazqukerg3Vf8PS5C2yKzO/FdU2kF?=
 =?us-ascii?Q?DBY6sdxMk+Zx+7N5r2wTvVJHIxTEjI/5fIPwzoIQcgFlKmcXbZcPcmTqzQc1?=
 =?us-ascii?Q?lVAya70CYHSGKpu9UMq48xnO4Rar9kpwDjjn601W5IfrMJ8DObtimUKzXLZ3?=
 =?us-ascii?Q?hzIrBX4dO6ozrshUaXSnxQ3K+FYCf7hGMylNNig04ihLh9OkPi9WWcqXXbg9?=
 =?us-ascii?Q?t1Zi74vHcfvTtvRQFgTbSgVw+hbF5+ZW2jS8qYtT04htrQwAiWEnx7xJaZ8a?=
 =?us-ascii?Q?yhwxII2QMvg1gGixwZqQycAc/d0JMyC8LaKAGlVb+5SsB76CQigHwAHCMhZs?=
 =?us-ascii?Q?JKVO/PZtb8kv+yEf/PAkgd6PLP5SmJz9/E0cAoNrFxUty6a4Z4UCa80sBWF+?=
 =?us-ascii?Q?vhnQWzARsa71WYP84U+lN0EKtTQUC1o3LSaEXX0/9ZpVLnPfNr6aj0FVMYhf?=
 =?us-ascii?Q?jB/TDA9Q4kWLtfdKYdCB7pMnjQavOlAS2boW1gmvEPQDt3qSpTxkEkBXY6TP?=
 =?us-ascii?Q?6UIygbtUTab2wTpPPGLml3FH9cSHv0ARylKEU9n/aHP3LmAyvlsNVXpuFgCz?=
 =?us-ascii?Q?Jr67kCFTmpZxHQ4ipjGMivwCvAsbTzST+jYwcrpfcF4h/zoP9RWaXI9LjqL9?=
 =?us-ascii?Q?w/k0Agu1HvB1+TY+cxHEFJLhOQvSBr2CtRwUF1wSHR4OXwx9oLuIM0eYnQye?=
 =?us-ascii?Q?izG0maKitthH9EkgF5Xb2ZhAvO5Rivs+CMs6GvFDp+0K7LuE6Aj9b0wVPOrj?=
 =?us-ascii?Q?SoVKzBP+LZM+bFrybXjrCpLsr7odyVVwBWy9914vwDkSqQ2BGwN6pWkn6RVw?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa69e6f-483b-44da-d987-08dcc82e085f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 13:25:21.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1DBV4alNamwwcVZ1jjwwB/qOelr4C6VgVDqHwmeFe6/esxzYSEYyMQ4umI8rZjIM7G00a7hL+cxJ3LMoSBpUvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9385

This updates the push command example to enter the Broadcast Code,
since it should be entered as a string instead of a byte array.
---
 client/bluetoothctl-assistant.rst | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/client/bluetoothctl-assistant.rst b/client/bluetoothctl-assistant.rst
index b4f7d039b..fb8c3a0d8 100644
--- a/client/bluetoothctl-assistant.rst
+++ b/client/bluetoothctl-assistant.rst
@@ -41,16 +41,20 @@ the default metadata will be overwritten by the LTVs
 entered by the user.
 
 If the stream is encrypted, the user will also be prompted
-to enter the Broadcast Code. This is a 16 bytes array which
-will be used by the peer to decrypt the stream. If the auto
-value is chosen, a zero filled array will be sent to the peer.
-Otherwise, the bytes entered by the user will be sent.
+to enter the Broadcast Code. This is the key to decrypt the
+stream. On the UI level, the Broadcast Code shall be represented
+as a string of at least 4 octets, and no more than 16 octets
+when represented in UTF-8. The string will be sent to the peer
+via GATT as an array of 16 octets.
+
+If the auto value is chosen when prompted for the Broadcast
+Code, a zero filled array will be sent to the peer. Otherwise,
+the string entered by the user will be sent as an array of bytes.
 
 :Usage: **# push <assistant>**
 :Example: | **# push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
           | **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
-          | **[Assistant] Enter Broadcast Code (auto/value): 0x01 0x02 0x68 0x05 0x53
-                          0xf1 0x41 0x5a 0xa2 0x65 0xbb 0xaf 0xc6 0xea 0x03 0xb8**
+          | **[Assistant] Enter Broadcast Code (auto/value): Borne House**
 
 RESOURCES
 =========
-- 
2.39.2

