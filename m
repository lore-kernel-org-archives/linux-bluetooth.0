Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2A1E909C
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374539; cv=fail; b=kl9w8JiRSGjjloxS+RWDWqkhTd3N4lGS1aXtoNDFgPz1+urROwgruqNkw8FGm4tchBAujVorF6N7eDLtnxz5hn6TtX7k92NUh4GWuCkaIOIRYGH4A+NES8v5a7bLYHWyBZvwFc6yasANneazO4VNXbJpTu8wRi6sAMo2d0TDhFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374539; c=relaxed/simple;
	bh=zpFDv7QqBEJDw5Tn88XPbwfbUGZSFMTC41Ulvgncgj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQ+9p9OT/Ujy7OmN5FgOxRDLbNsRegVX+9YxuAGs6b6b9jyKQhuDXu6Of2/baOt5nSgYkaHWMpDP7kHjhfvujyo/qlPt+OQV9FKpUnbmAhaHup8XLL+CGwa+5iqTY7iraCglq36pLhYzTAGVK7DN+09QYlwPp45GTbKEI/0Jkt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZ2FY097; arc=fail smtp.client-ip=40.107.105.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZ2FY097"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJcgEalZsYGIPLfdamzltiQGQ7XWdBvUDgGbpOhs7MmgZmpiYzgWj21abqiKvm/P7wBfjjCJtpkHNoyy8Y5h0BtVqvoQ5wQkQM8MyT2mi4A0CRfTtyxPusvMjZnmlPzRnzrYkp8q8BrqJJVklBI+YdreSRUwWwAU4mYaaGGGJYuiRCFQIV3Z8n2SBbBN5BFS9nclvr1sMbbHsBTiDEkV+Pj4m65i/ECXTWyrYlpzPWLjenJuafzC6FZX9rCDJ+6vNKh1K4RG8EeTBwgp5sSsoWSz78hAoIWJhn4MpdjUgSGDN9qqQ3wP+IoBeHIBBfmZNJMel3w+n83IqiriyFXn9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHkrfc3RAByY8yg+OifplWQe6K9H7Q1OdEMveEsVVWw=;
 b=dCMTgkLDauOZT4hQy+kt4LmuSTY57C1FX4LZ+/dTP0XQG70Vn2ngzbtWtMfcGJZbPad+uFj7PDIrEQ8Bpqe8VjkvlHHRQMNUqZ2frVbl+4fVNhTjEC14EFYwciLRAOP0/APYQlZifMyXdWvvLWXrhtfndTI/QRXJSCleegNR0s4UEf5uHDtW4TlpRrTT1DDnUBWHhS6dDt/nYi1YrQPvPb/cc8MGf23vTSUVHd6ss/pBAB2LT32lAF+MMpOS1olkISjnUTtPco5cHVlsq1kEes+f+SSZETTPPbCs8yag4089f7zBtu9oCCEsH2bqSQPe9fEXMY69B4YUGHdsKafS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHkrfc3RAByY8yg+OifplWQe6K9H7Q1OdEMveEsVVWw=;
 b=AZ2FY097Pn02HtffWfJUzRZuwoV7MLj+Kz1zL25ju4/A5G+jTS3vOCpLYH0cOIMZMKFHZaYb7Ma37K9GoEo69lLzyEFVc9JoYl47Dueh2oX1UOj8fFVZ0FIIbCKxTy7BaVUjHj/PUiYKyRKJ4L5jR/T6KPtIjzWHBU8kYwoiISnDuRE6njv/QefJ6pGbj1SzGPSagd9Y3HKw2gkbv1ivfrR2IGE54OAQRDsrt8nZx/YiOl0FpEC/0bhoAy/TkC7VoaWChta0RQ/NqncYYY/xonvSnOkj5O4DhdKxawOPMhkZZLnrNgLsA4HazoFArfKimmtSBrdULSMyT1yqObLiRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9343.eurprd04.prod.outlook.com (2603:10a6:102:2a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 08:02:04 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:02:04 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 7/7] client: Update scripts to include encrypted stream scenario
Date: Tue,  8 Oct 2024 11:01:26 +0300
Message-ID: <20241008080126.48703-8-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
References: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a964bd-ed41-4a00-38b2-08dce76f7f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cE4tuLoI7tsEO1kyIPkkYabrY4/Jz/+EUD2FyM6KoUMBXyZ2Yc5TuPyE+0SH?=
 =?us-ascii?Q?ao2yB4G6mCdEbakTcX90/LDu+Tkj3Wq0K9/BpcmIpz8G6xlewyRFpfZx2gDh?=
 =?us-ascii?Q?bPg4bqJtXY4b05GjQKxpNdC/MttkiwxGLoJTIuc7gUQJrIlM1f1PbuHU3x1z?=
 =?us-ascii?Q?puEqQ3IzBhVqk6wQX+/ogrnC1OLTvmrvqh4OxQ1RqRLYXdlF5xyBFL4mkmlk?=
 =?us-ascii?Q?Xf0T8hKzBDkS1csjNwhYAD5XyVZsKsZHPTPOXJEL6Yk/2c1JWvzM8twJ808l?=
 =?us-ascii?Q?6eriJu4B3eKkbtS7UqKJkNjJ3Jkzhr2HHn3RTRQgU5FtbYsqa2ngCgUKXto4?=
 =?us-ascii?Q?qUZw70dVIbnIsYwCFWsr7LEWOWzKVYQ2gnOjZD5lIAmrJi7ZinMfbX9VJZBI?=
 =?us-ascii?Q?59aF4EqTzjenc1BFw7YzcmMq5OAF5hQLdDv8X7vZfsQNsLDKDbRt4FewHrdl?=
 =?us-ascii?Q?4SGTjLI3JZg45U2aWPiUSWVgTw3BBLiTvF7Dp4Dq4ZEh1qwE4BLAkX5HXhtv?=
 =?us-ascii?Q?7KH3JRIgtRSsUcuAGvsvu/xRc41qTbLuv1Ai2CyUiehs015PWIecJv9KM4pl?=
 =?us-ascii?Q?v6vqxLInBthBhusktJ45BDDogyjWsRHYEOEMOq9hctxEj4y3XjbqF2hvYbGs?=
 =?us-ascii?Q?Ior6hfvuwnzvAKx9DnL5gzIS2t8REjPuQbLj3PVAGKWX3Ppt2nYetly6uLcO?=
 =?us-ascii?Q?ATWK7YJPUhr3EnT4gHl+jPNTUYf7uL6judlDbYEpC7NSL4a6owX/Z6mzbVPb?=
 =?us-ascii?Q?+k9BSn1816hBD4pCG+LxqRl3vga8vx9BLRTjL3qCZZm+yhVLrdgCy4CBNpm/?=
 =?us-ascii?Q?5Tpv4/CuqziEIu1fNeuS0tR4ak/jq5qHYULPmGh1ohkO56hEQIBqbpcXuvLc?=
 =?us-ascii?Q?K+vEhWnuMCyr5NlZwCzXoahG3AFo13mh3DX+9snu/Ytl3/il9KdDFqynC3n5?=
 =?us-ascii?Q?ebW576q8tacSeNNgHLSoHtjBVLiPvCYYyFXv8qjTONEcMJC2RZ31SeFJWQ4p?=
 =?us-ascii?Q?3YYML3o6EZa5qcihgnzyoXB9cB5DBNdueARZn9w+xSVlPR15uMPe27iOY0SC?=
 =?us-ascii?Q?pcsG847boM/hJ95dfeO9Q2WnPVv3oiWDFbNCliIy/JEgOwetnd3DGDwyNj/j?=
 =?us-ascii?Q?szzkrleX6q2ghrfAn2X6znz9Js/DC6gATXcrtQHtSkCECYBPJs+GISsgzuJF?=
 =?us-ascii?Q?vycOS225FPACYp2YquNazAqZS/9XvazU4PsKuPOukpBqqWbipKdhKQo/LnXU?=
 =?us-ascii?Q?zTgVk2HnnZJa5E8+EyI7o50VLhtBe5reKba/GUUJiaIWPyPGuj8uruW/drx8?=
 =?us-ascii?Q?sX8HoWsA06R2q1+8YCy0c1bl0G3LHQNVXIcOz9Ik7tUjAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CsT0eVJ8G1C+INWNQob2lSIQ/C/EyVXL8kiApO56HK4y416gDuo4HOQ6vOS+?=
 =?us-ascii?Q?qz6/jk3NzGGTbM2g+9GGU71g0MvvWLxNm1bc/yA3YvFHkzSoGY+noCc+6/Fa?=
 =?us-ascii?Q?SIAWum6OCgu1iBgXdv2gmRqPKGHXBkm6d/TNP0iyypiPz5Iw0/hDb8YRUZH7?=
 =?us-ascii?Q?wUSUDj5R+svqp4wACOB2Q2RO4EAzS2Z7E0fy9HCD3df9v4jFOUkU981q3hhE?=
 =?us-ascii?Q?VNaC6zdO7+/K3OMmDigyFIwjIwqzOBR6Y/tbN9xFkeQ4XUpY7vdkHCBVnsd9?=
 =?us-ascii?Q?D8yAYgBBlUT+yDsyt5IrFrCccO8ule5Z4IEqATGLmSD6eNNuYE9edQekRlcp?=
 =?us-ascii?Q?xibVZsaG7AAzFbuotE3VEFMGFsZ8ZJGDQkZxQCDHsF7Eg3W0zPekaDqn3Q33?=
 =?us-ascii?Q?iY9j0lAdz+xQu4KHYNKTX2pwBR2jIYIgB+8TRjNPSSkBrbBsoRS7gFY/EA/A?=
 =?us-ascii?Q?Pt+zZ141QG/rVDez3ZYfYTOAQKXDVVk5PBompdASdt1w724217r6Agtf18wx?=
 =?us-ascii?Q?syonh+mkVBPlPqHOyCgryLbunfQxe6j1s2VUviX1kUOLXeoVk9PO5l1182ib?=
 =?us-ascii?Q?KNrBubQv2XWf8B6dalyds+I7YXs5DYMftOUCVjR1zvQE9xJSXPKpEnJTo5M/?=
 =?us-ascii?Q?NtAdMK6zURqXm0lO2i8RlRfpb8okQGJwaIr6YEaf7VTKHZFOSAhf9ud9mV11?=
 =?us-ascii?Q?kV4qz1fx6x0zeHTqOks4x7KXtCk7DC9Q4O6kPsU7uLdzSDQRr6ILPltBXErq?=
 =?us-ascii?Q?mQA17pIlnG0jBgML1BTtcDE5OfF7jbvnReEIokyVdm1REieuxXTx2s5uqidf?=
 =?us-ascii?Q?084I4o8VgRD3yEgLpCPXH+qN1FeWS35VrXUSoI1SuaezpaXKzHmnFz9tfL3G?=
 =?us-ascii?Q?3n0KteCn2Z3kO3rcnh+LtImQZRyhb5DQLjlBLdVZJbewSkU+ljJKys09EO6R?=
 =?us-ascii?Q?gIeYHIGlsskUcBzxRUnqszz+2fMhRWtRhYnQN6Ashh7Ag9uQ6vwn3ayze8ov?=
 =?us-ascii?Q?ae4Mqnx2Fi4vbE8tIPeADtmVHuYdFt1w+e5Z3yjlmzowSwUwQiJJYethFj7g?=
 =?us-ascii?Q?Eb/gMyyP7WF5piCQBp8mZr182I0Nitzr5MvHzhmsqNyyaOn9j5/wSysbHzHN?=
 =?us-ascii?Q?I+utx+h0aDpw2DV5gxrgiWYtmm1Y3VhA8B1swNHkH+HNwsabbKhV45aJTzEo?=
 =?us-ascii?Q?H0cuONPTeT8DpAz0qYqdLg8BbHu9Ma/aDF76+6zletQPmdDeJHAsAKPRgU4A?=
 =?us-ascii?Q?wSl6oFQ8fWyEH5Pwg3dBjnnL5nsPbj//nrolaUObBmPw29aqsqlVU0/zA1Qn?=
 =?us-ascii?Q?WfL5EAgXeXO9mxRsNn619BukUuNIVpNhDuLtpA+x+fX6BxoOVEg8ccbVbKtg?=
 =?us-ascii?Q?hjBZE35VjWpVTCadggVMU9c4weYmSkq9FdNLSZGc/nJHbWhAFwr6w1Mz9WWL?=
 =?us-ascii?Q?WvJ3Y9ouvW4LTqqs6lFhtTzU3kT/3AnVgT5XI+Evz2UouclZK93y3EhJ1lzl?=
 =?us-ascii?Q?hRkOfMa/YkxQy2t61DDMbuehXPV8OKHpgxlHw8L5RaVmYhlCMbRpsLUf4d/X?=
 =?us-ascii?Q?u6GeItJOmaz0fBvpvfTz7OkCPU/+dqMS90MDJYYsd6QprhNCBfP1IngfnJtz?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a964bd-ed41-4a00-38b2-08dce76f7f40
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:02:04.4740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Px6+SnMaNRw2Jw6gWBYs7L1EyYbokdAZtgPJpC0ySO/P58BeHjyHVlojXoLsd03iZzmXeqlhu8T/Rn0vzSswkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9343

This updates the broadcast-assistant/scan-delegator scripts to include
the encrypted stream scenario.
---
 client/scripts/broadcast-assistant.bt |  5 ++++-
 client/scripts/scan-delegator.bt      | 17 ++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/client/scripts/broadcast-assistant.bt b/client/scripts/broadcast-assistant.bt
index 15e9d0980..81bb147a0 100644
--- a/client/scripts/broadcast-assistant.bt
+++ b/client/scripts/broadcast-assistant.bt
@@ -25,10 +25,13 @@ scan on
 # using the "push" command from the assistant submenu. When asked
 # to enter stream metadata, the "auto" option will keep the LTV
 # values advertised by the Broadcast Source. By entering new LTV
-# values, the default metadata will be overwritten.
+# values, the default metadata will be overwritten. If the stream
+# is encrypted, a prompt will be displayed to enter the Broadcast
+# Code for decrypting.
 #
 # assistant.push /org/bluez/hci0/src_yy_yy_yy_yy_yy_yy/dev_xx_xx_xx_xx_xx_xx/bis_n
 # [Assistant] Enter Metadata (auto/value): a
+# [Assistant] Enter Broadcast Code (auto/value): Borne House
 #
 #
 # Wait for the MediaAssistant object to transition to "active"
diff --git a/client/scripts/scan-delegator.bt b/client/scripts/scan-delegator.bt
index 68c7fb498..5ff7bcb89 100644
--- a/client/scripts/scan-delegator.bt
+++ b/client/scripts/scan-delegator.bt
@@ -18,7 +18,22 @@ advertise on
 # After the connection has been established, transports will
 # be created for streams added by the Bradcast Assistant that
 # match the audio capabilities chosen at endpoint register.
-# Acquire the desired transport to start receiving audio.
+# Select the desired transport. If the stream is encrypted,
+# a prompt will be displayed to enter the Broadacast Code for
+# decrypting. If the code is unknown, the "no" option will
+# request the code from the Broadcast Assistant.
+#
+# transport.select /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/bis_n/fd_m
+# [] Enter brocast code[value/no]: no
+#
+#
+# If the Broadcast Assistant provided the Broadcast Code, the
+# transport will transition to "broadcasting" state.
+#
+# [CHG] Transport /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/bis_n/fd_m State: broadcasting
+#
+#
+# Acquire the transport to start receiving audio.
 #
 # transport.acquire /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/bis_n/fd_m
 #
-- 
2.43.0

