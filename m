Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SkmqTOt+"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9D610CE
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 08:28:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WH9Hxcs5n/KUGNo2aj8AOD1sICGKsKgBirFE5nu7/Am3IufYkxLUvaJBLqJI4zHun64/hObukU7MCiZXVZkf1VN8UoN82C89OFJeOKOQOqoJoZKzITlV6HEcKm9vQcPe9IsYrFmNN+AsWgqGmBaq2WKOpe6rfI3aZI/QXTScmDr3YWrCmugMkP7EXAPcM1y1XxOKgpuyj5gGrgmnH9i+8TYR26DaOVMeQADn/OL1+7ZzSuaOqRkykHEjpZsZuW40rnHHsE1P0R/TFQueSkUb3MSoKqpqMD/zowDT7OGTrNDDlQUl9dwZrxJoFZxbl4cTE4rd8Bfp6Ddai+lv46Jc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki/0l0YXHZj1ymn7SHBdxEPBP0HzW8tYpy+QlRkmtfw=;
 b=UTg6Vw7cHPsomv6I769O11ZxGgl2uxIW4PI00Z/w8pYVRuUvzpP7QGJgz8/OH+43dV1Nx1hh+mOAfx1vIQxv8AyZOJJmZZ9jUiuWaZc/SSbW6ox9qERJ3zJXO5umaHZoQEmY99cmZdhgDyIXcsOwVzuYycvZrrrq3prviT4BR5Mgv+8wbtOeCYc4etBXn9MvGGbGUJrbQvw2qvF7VyoYD7BZZqWDI9Q49SLubH6V8qhIGg6uqXeGdjMSiCYuAG27zFBp0/+Bur/931vl5E2VySa0EdpUySQOJ9e0TFkeaoPTZEU9WqCqz6738LTHmekX69SbonkTsZPiWr4qYiGZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki/0l0YXHZj1ymn7SHBdxEPBP0HzW8tYpy+QlRkmtfw=;
 b=SkmqTOt+2oQNwj0xlqfAVPt1blUWjF4LbQFyH7tzlllC3Nu8oZ++jGPl/KUyF1NYTzEq+K+RUf1agNeYm0BiLi60NKBaIirmOWOAHuiIFcxdNRzkmwqXMqyna9PpwJLGtKco6NsPVrVmqlI2qc4dCLdSef5eTNdkkhQMhdJXyU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB8302.eurprd04.prod.outlook.com (2603:10a6:102:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 16:28:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 16:28:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Avoid creating child socket if PA sync is terminating
Date: Wed, 29 Nov 2023 18:28:41 +0200
Message-Id: <20231129162842.3596-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BEXP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::26)
 To AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1f177c-96ec-43a1-3b43-08dbf0f842ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y9oHtDCVLEm7sRafFpvk+EybvkVbNdHRHZSSa3NNhwzqY1PzFjSa9ohUvAGLX0EE4/m0tgdb6+YYrLxSUcn+emdrHIwby1JwRTkvfzNpQuLYYjStoBEyQVes89VBOU7L+ab9Ige13ERTpEMnOzKG0fFUNl6xI7RVxPZHbb4fOuAhav01g5Tb6rFFt/J+kihfp8GH3jhMZqedsPqdW0KunP7wKOlcaU4Q+3jFozONfTtcoJGPDhaJJCozSzXQ/jzAPw0jNInxPGpFqabj9+zdNEJ6RKVaY2A0rcU45UUJwKq9v0LqfzNLBbjejXYMurQ53k/RP95DILo9YVrwXIFNmPNSmM9JzOpksxk6AReHJw1F+S4AC3UfrYkukp+49bZOhS/8fZbSlndeIUemsjBJYrRIKk86LB0Eim/1TG4wG8OkRSGegjnIWWBO6X+cz91IZr+22+jZj/faIJrwtlMV9PGQ7orQjwvSZePCPlSQ549IlBsGL3gJh7Qf4QV3TGo9gyeLBSlDjBYEnehj9pL48sxb/PnyGLlOLyc3T2mg2b2VaHEiY5a37Cfoqn4bSOXO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(44832011)(6666004)(6506007)(86362001)(4744005)(2906002)(6512007)(36756003)(478600001)(6486002)(5660300002)(41300700001)(83380400001)(38100700002)(2616005)(1076003)(26005)(66556008)(66946007)(6916009)(316002)(66476007)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aHpfKA8ZoFtjn+iQMI2eNRe8m0XnjrNkd/vbwrvZdWPZo1Y9p49V5OJat+2p?=
 =?us-ascii?Q?Y6aE66zI6ED0WgRmxu/JPtzC4GwJzwamJ4U1ctwNJiEl3uGHDrWjQAFXyzoc?=
 =?us-ascii?Q?lRMR2RsRKSq/c+MXyN37Ndw/Igrj0v3ToqksqE5tIU9du0YWyMIxfcdUkZ6P?=
 =?us-ascii?Q?uaHNi3cRKY4+V7IHR6YiRP0eZUJHaIj9J9dpJ5t0wzLjqEo0XDVIucBh4QOk?=
 =?us-ascii?Q?7OcmTO6na4PaC/0jiINq9rAplgt7C6YTca2raWhcrxoxHQZDxCF2xTIlB0LR?=
 =?us-ascii?Q?/T14JPa7YktqI2HdgIW7IEJtP+GQjQrLhom+WDft/jwFvICBPw2dLt6kOD7D?=
 =?us-ascii?Q?stmiDRzdHhe9G9VV5XZ+4ui5jP/LzNh67mtInX3ODYx7FD9ThjBX6lbgf+7d?=
 =?us-ascii?Q?4yKVbyuEkot9oa+4LtOI1Njp7xA9c5P4zctXYqaBOyhN3LpNPV8dIk3JTSrT?=
 =?us-ascii?Q?/m1Ie08pjCbGZG+fA2AlaUBcmgiNY1eXDsKI22zdiWscvuDNyFAvqnpSl3Yr?=
 =?us-ascii?Q?NHaE2Zn3dRNagaAb7P6v9LynkzE9BvgUVhdBX9LL0plvmXzL1xvIhOs7AQ/M?=
 =?us-ascii?Q?Ow+RXWFMlsjYOPzeHs3aCVHYearPctqXoaKMbrjnzyBvOuLoONHVjcHBZ8RR?=
 =?us-ascii?Q?glGkojVQ0ZmkJwIk8GGxQfVegrxcZcOZhZ3cNA61MKD0SovR75CZQQwRlxTv?=
 =?us-ascii?Q?GOTNHDvNH0auSFEkK9u69ruE+z7H+M6JgYoGmRhtjc8d8khLQUV8btV97plF?=
 =?us-ascii?Q?MeZhNGqeeoG1/L5GlHIElIOAPPFueXCszjaqQbzj39wbxZG2fhZZn3dygUjd?=
 =?us-ascii?Q?JM783bL250s9Z7/RlYFA7qEPgRb8ntsGBydqrJhYh4kpRwCrCDyCC1E/5XEV?=
 =?us-ascii?Q?MxbmdTPZmMtonkIFB0uYCUAnNjCQL/s3NkNY0BizuAB6p50jU8zI5dIJBdA8?=
 =?us-ascii?Q?GQd08yi21T3PwELhdPcBGHZTlaZJoRG4PowdnhlljRCt9OkC89M4e5AcH88j?=
 =?us-ascii?Q?V/fsn0sAwXSQWMAxWwfCLVVbw6JKSUEDznpJQFCUiag2W8d1fweBJ9n77S42?=
 =?us-ascii?Q?UVQTvjm2DbrSey8gUOaAlrO/fB0v5q8e+RHx3Tw0cQxfVST6lovtxE7gc+X4?=
 =?us-ascii?Q?Rfg8hkqOGx063VL1LSrKGyVG7dJHD3DNL+NOBXMMDU1FroTYBPcvrJOxPfyk?=
 =?us-ascii?Q?2aL/Fboqi73jHThh1waQ1U7Zs970WVIXl2nzQF7vWq5tkjSJq2YT5LMLpVwA?=
 =?us-ascii?Q?0Zunwo3E6qEtbpiDr8asf8Kr8F7ybub5f2As9cgsUEGg0g7y5NXX2NUdXAPa?=
 =?us-ascii?Q?epL/+iJwse7OiDPFsWMab2veW7oK2BVm/+YuwAx9p/DBP/ogDc+xk/+y+YYo?=
 =?us-ascii?Q?dCO05OdI00ntabbzuD/MHGJcsSVCW2mrmlIewCJTcLqexTVPxGjXWheBtflG?=
 =?us-ascii?Q?S/NPyRCqAoJXCH+WEv3MA7qotiR2N0Sx9j8zAeBW1KzBse44Biva+FzY2sjY?=
 =?us-ascii?Q?A0Fr2LiflDqSSn8Iozj3BLlJvyrBbH4mEjWG/j3JFBGH3yTEqxsrrIL6T0ul?=
 =?us-ascii?Q?5d3KT/Ut/hOCY0AdeeVrz/+I6bf6tB1mu5uHmNDoHln2FCHMJUl+RZxaUKg+?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1f177c-96ec-43a1-3b43-08dbf0f842ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 16:28:46.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPyy0e9iw0q/fXneL57NlrDcmx5v7E8zrjWcuyrX08Xki6qJqe+fYxQVEMr7PMeGONmRVE2yOJwp7QkmtwfTew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8302

When a PA sync socket is closed, the associated hcon is also unlinked
and cleaned up. If there are no other hcons marked with the
HCI_CONN_PA_SYNC flag, HCI_OP_LE_PA_TERM_SYNC is sent to controller.

Between the time of the command and the moment PA sync is terminated
in controller, residual BIGInfo reports might continue to come.
This causes a new PA sync hcon to be added, and a new socket to be
notified to user space.

This commit fixs this by adding a flag on a Broadcast listening
socket to mark when the PA sync child has been closed.

This flag is checked when BIGInfo reports are indicated in
iso_connect_ind, to avoid recreating a hcon and socket if
residual reports arrive before PA sync is terminated.

Iulia Tanasescu (1):
  Bluetooth: ISO: Avoid creating child socket if PA sync is terminating

 net/bluetooth/iso.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)


base-commit: ab3d463ded5dfd81227fc998910c40913ce17616
-- 
2.39.2

