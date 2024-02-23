Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE387D417
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694120; cv=fail; b=tcA4i/Q+ZAcI2yYD6G94PqOHeH4OHhSW9S435vJt9pIl79pE//BY+eJUZ2R/GLo3T6eyXHd+vfPG4RUpZq3/O/b9V7GTaAUikelKMR8JaOK2Tu7r9ZU87uwaL/laqbIgVqO3jvdpKZopoV2DkagdOhMViSNQi85CJUwIQzcCSdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694120; c=relaxed/simple;
	bh=061k5n33Ys6Ud9PZiAzCy78j5PB+ATFke3G4N8LWt8o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LfA5GFxgUGzXVE7tpTRLNbf4Ctkqxn/Q4+hRw4ru5yYpCISe5XTYh0rl64hN2xifjl5r3/pL1E6NCRp2pQDZ0O+zjMF491X/eTIlnfDlWon0kseLLVoDqIhdfhw4SFpSu2lYMq5Qk0jNzrRco69GXMVgVTttvwTLYImh+3HMnlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XJJOqp9+; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XJJOqp9+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ed5jMZW/apM5jxdg9kh5SZFSCVM+rMYUnROJ/FFDNuT1/EuR9mEDWktnr+Griwq8esZsC5uyxdyRIV+kvQBhg2M7hgkna05c5rVwkwEwA7TEUMm80wMpyHgckXMCzLM122Oq39e0rsQ+9gLls0Lh+A7DmwshvLct5C8BkOow5l4lTR7YN6Lg0EBL+hJuDg7AaWSNG0V05B46C9xlIfi4VZaMamiB0VHa8jdEb65FT/cXdIjNKqUn4LzFUdR1iotBrr4zuaGfAXqr687MCuT58I24DX9eK8wBQJFabLmAt1Hl6vTqbeTI8T5u8sL3NHbj6/wfyog5ceHlj3GW5CmL/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RR7ZH8lukd4C4SXvsT1Yh2PiB52WJkZudc8/KFcJAw=;
 b=EW4YgU+pGmXHAHPnJ7hclHr/2PuCbpR9EokWJOI97NYeeyqgnu58+JUvb/HmsYc+kYXb1g7jkzl9URl9JcaK7a5hhnn3SoTRljoDvBue/WufgQynJonxzR1nirgcbPrxRiXapH4uHDYo8fP33LV1eTtdW8HV3Ce7EE/2N5yBe3aqCOJ+v1UiZLEtmLKta5xgJxT8Q2fdnYP+mH/ftb5NaQrU5GYBPjBW+ceKftw78tRQwLx0vOa139pfIdmgHoCQojIL1Pj9MFgv6HydTi0l/F8meF4c5c8vSVSIY/lYpS9EtuVU3Rj/qeWkabylAlPrye8NBh0NHLx064MQLPUoVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RR7ZH8lukd4C4SXvsT1Yh2PiB52WJkZudc8/KFcJAw=;
 b=XJJOqp9+iFOjPlxP021h9zXBze8qA4sWS5zzjZ36Us1Do5ou71iQSMizuHMGybFfy9JQ7GcG8dPbyouHZAPMWMNDL046OfvXQshpy2Ag629u6bSvKfbYsczbKt5RDKWDQ2mIaiRwhV+Af+P33BjVgybFfoTGZeeL9sek2dpAXWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 13:15:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 13:15:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [0/2] Bluetooth: ISO: Reassemble PA data for bcast sink
Date: Fri, 23 Feb 2024 15:14:40 +0200
Message-Id: <20240223131442.3077-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0133.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::31) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d47fb0f-eca1-4cda-b128-08dc34717992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SyMCGVZzkZ7xbTy+JCfRR25CElfUE3RqEPYKx5P1w+Gitoji7eDkHEvc7yIr5Q3sfepV7yj0o+WRw0RpnVp03QzgbS4o+8kW3vSRdUmIgZkkJ2Fi+QpUf3/yyTIRXzbJ6aVdwOMrnKujWHIAMB2hd7ug4oNqHsGptJUR1yWPT4G6LSJAqth6HXlaKD4xvK642KIinWJkD2AwAXThlYa9Yr+Bs6md+S4SOsU7RUAKPm1YhIz9NU2IImO1g1xUHyPKEnuZ/tUUoh83hGIwe6osfZCJmyVjrc1chkQldAPDYu1X1RWTykhfZexX/X/iiPAskuyhGj2RDQYHaTRixx1TBobt0bSFu8h0c+7poXuuqdE+rgAK7EMI161Bjx/LzwAHIlLw6BKTpaOd85Z5irJLWUD9alz3JRzJxnnLI+iaTvwYqD17BdhThr/CPUcFRkeUQEQtkAVP/C7P0hmQyQHaPXiLtyfJHFff7k3chouduQoyChvrl2zq0DcTLwiiLekt/Vc+f2jHgBnesmWJkbEZrRZSDjgNG6NFJtEIzWtt+tM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lIhj53MoDpOhsMSJgtRsFRZlA7LgJuMV6Yb5eqR+X4VDAjGX3upQAOy0S4Os?=
 =?us-ascii?Q?OS/EVAC+4NQBvWuYHnJocIY3xh/FiVlAkqpNeINRj2uJbN0+FjyjpiXzIo1F?=
 =?us-ascii?Q?YAawC1l3FGzOIusnf1yqFu7rqVPpxrMWOwhHHVLrHnvmwwjm2XQsxlSgg4kO?=
 =?us-ascii?Q?8pyIPACGjMjujJqYS6OvsQkOgYxze8jmnbOpa3NxpPkDpdjSTkv5v/QZT2Ns?=
 =?us-ascii?Q?mQuSaOKFPu9qFvyyQDXmFAWTBjGa9K+wt0qsr5SeB5rC7kGoxiY5CEcoXSRU?=
 =?us-ascii?Q?VZIhWbEe1kz1TTkoz+8OB4wZRMdCmwDK1dzgYUPjoB8kecJgl3iPXhnO2Bep?=
 =?us-ascii?Q?50JXx1fVLcXJqKNWtG9Xi4ReBnrne9UgeeLJgRP+NMsiN0/ihjIhED3Dllyc?=
 =?us-ascii?Q?NgIQY38vhbOlKXlKBSqB9rk/rmyMbrjTsikqPCF+WILP8tyRlQwZgsEBkflO?=
 =?us-ascii?Q?XPA45e8orGMIx/Y4prxpmmB97oHoiQKpFyAg7Ejb2XJFRWWUZ99tXzhrFp0c?=
 =?us-ascii?Q?YtshEAu2+NijyQrM7qnX5iVNG/XmhS0fE38xsxkpjERDAnM+xcLQKcjJZeTX?=
 =?us-ascii?Q?0/ctRnBe/Z0QLUnla8HGVpEUTNJFeJ+Bp5Did9aYAeju7brA440G4ljXfdf7?=
 =?us-ascii?Q?WGXj33rvNO6Ypo+oOvPjA/+I98CItvQaHhpK98S4x1bWnyXLf5m8kiDus7wH?=
 =?us-ascii?Q?Sns+KJW8Fxwz8ju7vzFmT+p2mtCiBJn0fNDjZQj6i+8bftdOLsnAr4SCdgrt?=
 =?us-ascii?Q?fYtEC9xZTBwks7vcBpTehzYiiA7Ron83a8lbQFQnC4o11lty0BFHvdvv9RCl?=
 =?us-ascii?Q?XucpE9jLoNLdiNtam1acm2ZCYJquMn/84LZBcreAoqbEnMxapbAao1hlWO/t?=
 =?us-ascii?Q?PZ5JKLwMQWqKXTuECX1gsT6zDqodYS3pvJcXnUq11pt+FI5C2D0WgvOhIzR2?=
 =?us-ascii?Q?b95lBk+SlAaNQox01B+BWsUzl1xU5hzw2m+eeuK44tfhCJSNYYqqk9Vf1tvM?=
 =?us-ascii?Q?cx/BFTmnCuBlLjM39dOJ/14L+wUIvt1MJgFJT8MGctchdFgDnLDUYRodhO7V?=
 =?us-ascii?Q?ty+mITGiJkKYhd59bcwkGtK2RCZ8bmEoa8eO1a5PnBuym86rSB9eNF7ZO3n7?=
 =?us-ascii?Q?1eCx7vq6tXU/MmNjlzzR51yyD6vPBwErDnHGnA+9g5d8tnHzLRleHnlaAPVF?=
 =?us-ascii?Q?f61XGsJN2uVw10biWhLzlbzG/xMxfkvPFBETmsWNQsWcTti65UW00aj6WvrM?=
 =?us-ascii?Q?xhsS1+hYSkG9wa78EwSG7Y7SK688CTMyRmjcBAlgfCM8wXoraDimXsvpe7q2?=
 =?us-ascii?Q?ge2wcBkh3oysbCLRRF93yFGyDK4zDpmnqJpvY9gSoxS2Enzyp45y8641yuIm?=
 =?us-ascii?Q?5XeMtDFHldZ1cXrO5Hn5UZ4nWUPQzEfuaxULoib9N3RyHprL08lIUa9Q2/mh?=
 =?us-ascii?Q?bJAKyDlRI/oHQqJIsxsFxCCjdmgNDNf1DcGtrU318F70LX+8G6quYI8Lwh8p?=
 =?us-ascii?Q?pB8JqeacHjFbhOnTEJAZOT2z34InMot4XblI76QzImEZjp2qCGueSJTMmCMI?=
 =?us-ascii?Q?DPqLPJM7Soo+nobP8r0WIp9JqO3ADvF78ii7QQnRm6Pl7iXq27jtxo6GpTP6?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d47fb0f-eca1-4cda-b128-08dc34717992
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 13:15:15.6178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g5PLSehIXXa2UWB/DihNnOgAN588AX5V0nAhxVEb8lCLJ29dG+C9q30YSCGFjG7IOcneZ+Zl6km9GBu+yJRJZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447

This patch adds a hcon for a Broadcast Sink listening socket and
adds support for PA data reassembly inside the hcon le_per_adv_data
array, before the BASE can be extracted inside the socket. This is
necessary in case the BASE comes fragmented in multiple PA reports.

Iulia Tanasescu (2):
  Bluetooth: ISO: Add hcon for listening bis sk
  Bluetooth: ISO: Reassemble PA data for bcast sink

 include/net/bluetooth/hci.h      |  5 ++
 include/net/bluetooth/hci_core.h | 11 ++--
 net/bluetooth/hci_conn.c         | 32 ++++++++---
 net/bluetooth/iso.c              | 91 +++++++++++++++++++++++++++-----
 4 files changed, 114 insertions(+), 25 deletions(-)


base-commit: 75518da8cf76df4510d452f3214130d17efce283
-- 
2.39.2

