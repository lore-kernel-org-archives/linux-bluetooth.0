Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997501FB8AE
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866548; cv=fail; b=PEMzkkca6QPcI7TKrpQZgWnl7se5twcl67keZnOAKPV0eJqvZdQLR77VTyqixdM6eRUK4WqLKeqA0nA1Rr7QlyuO9t0oHE0NmxCkP1fQi6StvqatpQ/f5Dxpvols9Buver0qReoQ25jzWP1FvmOaZUdDO4H235QVlusVwwzNj1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866548; c=relaxed/simple;
	bh=xbolBX1FSBLMw9eukgaYF1szLiJ2VlYZ5/SLfb+mveY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m5yDo5Tz4Z3HAj0H6mH/sfnFy8uIsJKCCPFTtWT8bzUtoD2+HAp7alHNOLLaWGywtLmu3eNzg3wpmZkd5kYK036qAvPZ7tXCxKY0OG70SuChLaGPIAUTZUdeGolLm0QF+zx/pjfXRk9WNyAZ9ghSN2da0QP1m0pfOzR61S6Jtwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KZniHOBT; arc=fail smtp.client-ip=40.107.241.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KZniHOBT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2YfIagO6h1LSQTYfTyGhq0qAdAyIBNugpX5nusQb03X3gU0CmOVhlGK/AToIAiUpX1A8fwGADhtSGD/KJBlA4yuHjJtTTgoh5ON44WBlYUbGoU/bkuce7zYsnpXRBwQQSsxvHji3MCGh/0habL9czP4LQlOI5ySXXcYHmnn6X941GhzfWYEncgCBlnYPQZttmKdqO9gCDVCZY96089eByaZEXeQzA5RGKwPL7W/iOKSz8yU4PXXOd/HuQPZ6l7miV4qQdDga0A8PZH3YQlADuQHYhQf1kk/8X+IJufyKZ+Zu1sbTsiVC3oXB81jw93Nu1uG7m8RjzKQkGlPr5qvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlJJhqtxFfD2Swbn14ThlGFPchtbjB28uLieAboDENk=;
 b=MP1+Zgh6k+UsA3VVzLHPJ5k0729et9eVW5eFvcCFLVZSqUzmrbxXFK5G2uuwh3pK3FA87Nss3PYbA+HegD/bZ+6NZdh6bHgvisdSzRWmp0ZQz94MCBqj/p5eoxxTRGyeGrZm7GbFlKiOvA/WERKaLomPWiUJQyTsXocAQtZBVaQWMGYFkbuQNEGzL2MdPHTX6YenUsYyBCMgPALq9G8ybSlvaBjuO7ENIhoTeQmb9jJWawb3MXhUkxFyD9ZHzUwehT8ZijlImxxazrKW/imSzyHKz7KvMLOqRp7nLz82YnDh21IHifSkY6hOSqX9ObXp0C4dL4FiYneBC3eKbHTWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlJJhqtxFfD2Swbn14ThlGFPchtbjB28uLieAboDENk=;
 b=KZniHOBTMpK7Pf/Uv7tnn+Gmp3uQhu2xVbsDZXYsxqjvQlmtXHp1ZjLANaLdGnK8LHTm5tBkv/y6fp1mK2i+LupRpJWf1YBaNM5Mu7wBvUDuuZREtwJOec8p0QX/FVseSPz3Y17xUfvVUwUm6fXbWpjzS3K1TUFKOna0cfmK8VtaHrwX5O+aaaZ6gaYDOQi540duuEFyuY4jIu2ql8xOTQ99EAW0yuoCQOqInbUDXDBhO7EpaRl9mddSNark0WfTSI6BOyRzpHBUtTr0MK0WXQYwf72Q0pI6j5So0So3Sa4Xy//1S+t822x+JWiL0TE29yJK16FwbH3CKBnCOZ4zTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9830.eurprd04.prod.outlook.com (2603:10a6:150:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 14:29:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 14:29:02 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] transport: Fix select/unselect reply missing
Date: Fri, 25 Oct 2024 17:28:40 +0300
Message-ID: <20241025142842.46566-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9830:EE_
X-MS-Office365-Filtering-Correlation-Id: ca8af5aa-88e3-4869-fd46-08dcf5015f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1CBtBuBgg+b5R+1w+aWJUWSuPzHH2go6lyt2OQEqIH5/TnOEPgTdf8hN1jcG?=
 =?us-ascii?Q?H5vS02RQkui78BgKP3TayulVy94IQyFx8r5xJFm3bXEvIKSwgUr7PQgglnX9?=
 =?us-ascii?Q?K9alo31dH8q1BY/j2LbWFHllW/p1OxYEyV/vRGHVAXKlFYT9Csiwj90IlE1+?=
 =?us-ascii?Q?bU2DplG93xLFtRWmnQ6qPfWV6pPS8l8oiSU9DMY34vxTZgKtXHDu52duegvM?=
 =?us-ascii?Q?CHPqnUJpfvpm99zn4DDX/wFl2Bgxvwdbf5CkszjP2HImJ3DxsmgRjbpiRlZX?=
 =?us-ascii?Q?9ozyESx21FxrgUV3OS/7d4Xvm/YuY323X2DeipV8MKhKP1eG/VjaJnpRtAfa?=
 =?us-ascii?Q?wWNFdPaPn0P4ktJF+yzEAn+uCXOcYqNwFxuJvMevg/o2VlXPweEA0HqMCg/R?=
 =?us-ascii?Q?DaJgwQdVhcosKnHwgK01ERzEQCQI1FjFXZeHAwRFkQVhWMtdmRmD0t+QuN5Q?=
 =?us-ascii?Q?AILJ4Cgzx3Mi71sEblJoQPoGwnbIXV0/5C6pzTYQwImjbqYEg9+rt7IUCIuT?=
 =?us-ascii?Q?AlnabcUVf4EoejOAnKxk27IoYN/LaPPOJvogyoF+uVWb4jOHnzptG1HcFsXp?=
 =?us-ascii?Q?Jj4ahh1Zl0THlXEl1IPkt0NLwi76Dk+87JrgnOq1KcuTAXxy0CM91koqW8X1?=
 =?us-ascii?Q?LalSV64mvXq4wveoNa+5cLWeSvquiBmUhbba19ZeQs3aix8S17OJqpsCBqZV?=
 =?us-ascii?Q?Yf0mRyv6xkGSjCTFamxgbYz/tjC0Aolkw/93sNaljb4H25JmQpjlXEuuHhDx?=
 =?us-ascii?Q?ypdSqpIbUOJVCR5kwEEmDm2OJ662ijYGBb6aX5lT99XMqejPfYyDsxv4xZhA?=
 =?us-ascii?Q?iQl6mpKgRSXTfgwcTJltT9S4ldVZ3+NK6deGvx7lYlwuNwfAPH27mhrwO7+C?=
 =?us-ascii?Q?0kNb6OB3W7QNoXOxHxQJcklaEIwiNJvIuNX5F2r6GMeWH7M5DEX8+qcVV0k1?=
 =?us-ascii?Q?0O+nEsoKuR1EXr0pruUcp8PXBeMxCJTva6ut3WKzyTqd80Uc3sxBTfyTb4aS?=
 =?us-ascii?Q?zGLNZ4OqAgmIs76RbVeZ/BO3A1c5d4VIrBpdjJpOh6SXmNusbKXC9LM7h+Su?=
 =?us-ascii?Q?OuOPm37Y5yDbKC8WG0xxlEteafrSgC1VWpUMuCdQKTkWy2Fb04dOP4cYfa/B?=
 =?us-ascii?Q?FlFp99pEuDDJeI5Tcgfd6vzWNeZleXJHsiN0A5kYVtl0k8eN1GhC2Z3U5RnM?=
 =?us-ascii?Q?K/TDT3XEEPP7X0iiyhBKczsDiufIzf7LwuLOvQFSBjE9gDqzfhR/oYQyFDAD?=
 =?us-ascii?Q?sWJEONXIV5w6iQDw2jxnAFY9zM/jqvyveBzD8lLDNkUDu/wPFIyeDcXnJabX?=
 =?us-ascii?Q?LHnTGQmGJJdxDLAXMqgcqwysXboEnPSai5TJhePrGpsG6inMSOs4vYgzeyEU?=
 =?us-ascii?Q?6yDWQ5E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wB1UjSCdOPT0irg0/28Ao6T8Z+jMwNLG2EbVVqagb21aHGOyZcdW6V9OA/Sg?=
 =?us-ascii?Q?7xBcUqXnaoMFEbg9az+SRXvjCnwV0OWYt07vXXN324yg3FT/pNSW/kSpHulg?=
 =?us-ascii?Q?1Qb07Sp1IjUY96Cry+4Kvv8d1sTDNGQQTr38zgxnSHWf7t+c+fVRX32SqUK7?=
 =?us-ascii?Q?ond6f8xJ20PUqtOM+3psIu1PluSTiD+nMKzFd2P7zw4gIt2gkm07yr97jxnG?=
 =?us-ascii?Q?Wp4/WYQYtsH9gzVS2htrtj1UoyMI58NdrBF4gxEzy/J2oXB3bPcyA4XtVlEI?=
 =?us-ascii?Q?EhKxLYV3v59Evdeeq8f0/d+6x9z6CDN94OrzxVPlkmhG/MdvybuJ93vbQjEZ?=
 =?us-ascii?Q?2ra3mu5wr2mJhDDe5Ln4hogCQaU2MQE0FrVirKE9pmPLPV1gvuoAJRwidG8g?=
 =?us-ascii?Q?ntDNObVqBPfMtNu7uIocpGT3dDZaiQfYER4PxIBx6OuNTaXtTGVrw83TN1tj?=
 =?us-ascii?Q?Dw7OgXyMph1pvnJEs9P21wRotqhiYXoIoAD8GrIlqYhE59J948bsphQ3RV9+?=
 =?us-ascii?Q?AbI6E7p4VVKiEJvFbSjId8JXLLxHWA5/mAYmJ9JHUCJF5lj/brRT9TpKyGUI?=
 =?us-ascii?Q?WbyIoWYGqMCGog/yPIX2cKvYbaHwA9pHaF9LJPn8uQf+awLQ5VwGJkiXCeVQ?=
 =?us-ascii?Q?uintZY1lPu2RNJHXo+X6t0bH2UufLs3pB7W5n49g9h6NqCZYTHFhqygJdSTk?=
 =?us-ascii?Q?WIgD2gof23MlMqiEXrTu0mjEJF/22kGGDIBs+WWvcFZo0PrhYSMdA9QQRW0d?=
 =?us-ascii?Q?F3AEpyFXkd04bh7vm6PcNfoIh8GgV+J5z3stCQCmFgB4XmITL+Piwv/1vBaR?=
 =?us-ascii?Q?l1ab7Pe/1MNjTKu/7fh9ahniIuLX0AKr5tekdVcrxu7jSM8NS/oIITd9uXuf?=
 =?us-ascii?Q?ymz/6kd0qEe9ELUZszpZF2fpO4dPeiB/KuaGg+u5T9EwWiZF7duQ0lP7t0GM?=
 =?us-ascii?Q?RZ+cDeh4zazLdZMNhmgXuv8IXhPlCFrvn7D6ZdAFX4yHtlWNmID7/SmuyRyX?=
 =?us-ascii?Q?9QCsF1lh85CsspK0dCtd9iFiYAZb1y2Qd6WVeyRFR0S6MbszwerjLzJnr1Xc?=
 =?us-ascii?Q?w6ZS+U4pgfXpAUYOU8sz0TEYMwlKZTKFBimLkOVUScPCEpg53j/EVvRWIDXu?=
 =?us-ascii?Q?+BoOSdvyafBPRe5WnaYw3KzYOMS48PmhKVfBGgtoCLFhaSGI2tjJPWCQ3FP2?=
 =?us-ascii?Q?iBE+L+KWgylIHHU3ChiYdJewRRFhQHnatBjyvBKQn7ptz4C9nMie8Cmeh5Ab?=
 =?us-ascii?Q?EKXU5Lb1DWv2HncN1lRQptfkXSGKzqq8yNRhoi/bvePjDn4Elh499c71OlL7?=
 =?us-ascii?Q?RjmUld3+PW8eeMwoEeCT8YrMyv1mnptzeLfcCwNTOO4WAu50xpQTe3raphrj?=
 =?us-ascii?Q?m8vgFne+HR2PCZFVcZHYovG4f/4n+1NLWVsdLt63+Dixx72rRqm/ro6+ZiJV?=
 =?us-ascii?Q?3UtkdaUJQ4w0c6zIKgs/yMx/rt7lTl5eum9frlzrdjr4Xat4ovBsLbtnJ+b3?=
 =?us-ascii?Q?dIXmlg4t+JnuAmPcjlkT6HSfzjoV5dBTK8G0am8gaVEhVW07t5wywc0iCXbn?=
 =?us-ascii?Q?Kw6JSEMpsX9Xj5nOqeRg2rfAOlvADQGvocVtWzvtZt0uC+0LJ+f1QCxgcBNX?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca8af5aa-88e3-4869-fd46-08dcf5015f59
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:29:02.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R2RZod3Yxq2CJa+jy7m2LhI6thfafbyc9uN/z9v79xDHThJPO2mptBZlXOyts3VpMrYOo57qRzRotZwIPd/OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9830

When a transport is selected from bluetoothctl, a reply is expected.
Currently, if the method call is successful, no reply is sent, causing
the following error message in bluetoothctl:

transport.Failed to select: org.freedesktop.DBus.Error.NoReply

The same error can be reproduced for the unselect method.

This patch updates the select and unselect methods to send reply
messages. It also fixes the shell prints in client/player.c,
when the replies for select/unselect are received.

Iulia Tanasescu (2):
  transport: Send reply to select/unselect
  client/player: Fix select/unselect reply prints

 client/player.c            | 4 ++--
 profiles/audio/transport.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 806a552d53c787c0ddea9328a09b0ef124bca26e
-- 
2.43.0

