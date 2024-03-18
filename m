Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5254BF1
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779950; cv=fail; b=TAPumhRnCsqPu/Jk0gJ+0xI8jck+Rs0fZJucSwPbSY8gQL3DFkMVXIFDYSnmlgnQPJx6S55ohH5G4zStlS1FZkZ5qVkmhLWvPg5GcwrY7pQKrYbXIFLEOm8U15o64NwVl1V1QanMeyT75PVR7ZzJOzCUZ3NaIoVfJAfklfu/1b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779950; c=relaxed/simple;
	bh=5C4d1ggYCok8vN2Ws2PfiDnTCwVpycgguvYtvyIDAVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AkFymWync2Ly6HgW1Y0sZFDOmEXaqK/3/n7QFTli9do8XoHJqPP3nd4ecGVzjWb7r2NaktwHawLGAKniisTls0Ao/7BvElAxWmQBYV0RQzrn5qZZao9oHcOkMlwFeIQ7K2CyjR1bKSGKUUU7TVq9WyUpftnu4fFccISJo0asXbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e0/N0dgA; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e0/N0dgA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ2wDucW3Ceg/7Wcnd012CPlWHXkBY12u7bZZi6IY3m/M1tyW/wLrHESHmG4+jxNpBpRw2rzgQxsZbdK4iem2vp+x/4IstDfQbwvzQT+Anb8y2AtIVEMXl3MYDeK5NvLupurWSZy4+jc+ir1MY7ADkti9rRcdCiGwpU9A9HfgFsvY3NzMwftEK82kMZsM6pQ49ayT9DOgUUmntQXNNFDeYAf4pdwxFpRN2JzsvIpE8jXfXTFpS/OXN+7M2KSteiEXGchuP06AN/slrQHYI2+xYD5y3f4idd+8DaoVQlOn6qacYrWC3OS6Nuaj+a+UPk5J/Avy6S18DDPwiAFBwx5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruGmvlIaqGHUZAYhnd2/YjYXrSPgrSSGMwmc/J6DbDQ=;
 b=AI5SbmZ6/WMvn8FX1tZTqa4awy95u18ZPzx51nxzZGLgQrdsN3UEQ2PIY8g/jGG/yu2DKfh/v3Bqjf3D1+nOqXRIKHgdeIoyEo7+wu9pKqbU1seebBbMhNl1DW/DkWiwGGf3yUwVaG62k6LqiyIpLCSnu+O393dox26zq/voiCuThq0Wn6KC9KUOBuck2FLlLQS7bEYEidavN7ttDDFgB1+Jp3V3x+nFj6HzSwkU6WpNZNuha9IIgsDpyB7/i3Gxjmmms8l/jtHMnySUS1QTYQ6CrM3TdJfdQNGe9Nv0jsi4rwlftyKb6RAa/oX1kn+dmwZaMFtXfORSmzKQkfoXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruGmvlIaqGHUZAYhnd2/YjYXrSPgrSSGMwmc/J6DbDQ=;
 b=e0/N0dgAXP1evtJxOjQui2tjs9RtFMP2lZ+DBCpcDP1AXV9N1/kYuFPyIYPfBZrYp62XXI9VO2pzK9MlP6J8MKxLoEZ/D/ixIul+/PznSPE/FeQ5AFwedS+W9VL6xWeIRoAc5abdT9slzhHNYjcVY7gJVeXEH9jettqkM+J7qZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:39:06 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:39:06 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 4/5] player.c: Remove bt_shell_noninteractive_quit on commands
Date: Mon, 18 Mar 2024 18:38:52 +0200
Message-Id: <20240318163853.68598-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
References: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 87af3c6c-85c6-4fd9-75fd-08dc4769ed99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gAi9Vd42bJLz/CYi9Vl4QOYASQLrWMvlWI0fpdeAETjfS87OiVt2VSLq8H6UH6srwGGyt7r473BEfKjispEfethB7kL5jhSqmeYFHPCrv8+tmKzaJfPD7hnpyA0Gnl18b5BdLNWD2/XYJb5IJYf2a1FnVecx6J46azzIE3VHm/eHtOq0+JsxEtkeWSnd5RbH4ezuszaX4XKS9lo1TZXna8qv9lyOHNx0f91XigWlu+glwGTgX5/qi62Ivx1Gn7qrSZe/7llXb+iVDjaImHWRrDeW/JhJMVF7moJ0wvVVKDqkHRdOk/55tIY4xOHJZoQHqjVHYLjbN9HSAyoIeyJ5bUi8j39fVGFCj1AJD17hzeFJXsI3Z9xaMoJ2mYX9U4OtMn3xpQo0Yq1nL6OvPqrxgmIf4dy84fY0BHT9B9i+8DvFgdsscoqGP/QDeNyFibGYojERJQhfbh7EaQkMkXHaRoTCkXVaY6pr186hz1ULtzv+4Q/KXvoTzq3eXaGWEvpUOrgC/IQz5IiL0hGTwMHwvZWv1km0kwFeBQVRb3+y5pMBr1CFe0LT1J5NkJydS9wljRFodZdJpmzzVFWu7NdNLnItU/0u19v4dskU/aAEA0iH7o7KuyofEE/voAJULftuAal97Q+YsKl7Hfr4sqxw5PL/4IrfeeWHEbuyDVPeM4M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vXMqIVTBJHZwkobLtUxeY4IslA1IBYn85iu9sNL0KZDlaWkl8Cw8cAEeshFC?=
 =?us-ascii?Q?mKhFRKOGxBZ+lZJic11OeTwx3SLUHoYf7Y/tJz2QfPIw0O0PAAEncvDXrteS?=
 =?us-ascii?Q?gFxUnt92schk1C9jQpvmyzYReYxPe11ylA8sk7GiMTsFDSELzuSApdiGjzN6?=
 =?us-ascii?Q?ecEK52Xlu1b1g8HET9lduNs48lpJsKanGDFHlDwTemvsNvU7mK4k+kT6DH8H?=
 =?us-ascii?Q?agDbIWpWjVMJIfO/f4M8FnJZk7e3f0GbE4cFrrP64BuO2NvVNwCqmX17Hx32?=
 =?us-ascii?Q?vuMuQJmGoJGLxDtH2v6gXwXVygGggRl6bgS+yNAM7+FZ2I6S2f1YZb/DScWL?=
 =?us-ascii?Q?JjweZeLGvATZJuOpM1jCDT2Mo8wkFkSFL8SeA+68p6LJ9IHEhnlbEg+lmBnc?=
 =?us-ascii?Q?nd8AZ174J+92TaVKPjlN+yRckYXskCJEPF6rqHsMQFePW4PiCeljW+3cElVs?=
 =?us-ascii?Q?ogRMXX5ziCyoIQzy7vmfgdZANCRJqjVgM/S/ipoqeTdr2IPJFggzHxRKnoC/?=
 =?us-ascii?Q?fOJLu843njxgmuwFVvHHSbYxMdAj9wNbnlHVNAbkAPBELKk+30eUIXngmdMc?=
 =?us-ascii?Q?CleO0Jb71U0PLebQKG1dXVm2+ImUnCCHSOM7AJZzgKkbSQdZXWHpGEUIadis?=
 =?us-ascii?Q?Xb5juukglcVN38oBRqQw39Lp8NtBr3WqhvoxmlSsm4vcOikWOvv+VV9Uziyf?=
 =?us-ascii?Q?FnXdZKwxUoohILe58JMIsX0+U3lBHKpD0qi5A3gtH9mI6Du0bp5oWR+bWxTc?=
 =?us-ascii?Q?SvUpTCd1yhKlKAyNXkhGNEaHzRew+dFPVlX7FybdnF6D5ILiunSB92p6FROb?=
 =?us-ascii?Q?V3V71h43sMpvPtjV4pK6uGL8r27vj2g6XXepAti4lB6H663gCUdIXw+5PpLO?=
 =?us-ascii?Q?BiUtl0uQ32tJw/hfDXxyN8YDHBAzskXUm+mVshvjv4GHRFHfOuEkSLTbcmDv?=
 =?us-ascii?Q?Fm0zmOFPeJ0w4eE++fKHIOOGtq/7SMI2Dd7vZ5n6O7IDjV3qzdSaWqzRQOnB?=
 =?us-ascii?Q?YlzoXCHxN0bcBktmVWCucCs2ColDDXFmlcL87w4FhqXx6OmGtQEdShH3IEIc?=
 =?us-ascii?Q?6/C601+zWq309mDEWjV9j6LpTbpn6Tv2DhQLUNXQTXP7e4xEwxq/MqFCUdZn?=
 =?us-ascii?Q?NAvt7G543tQz6Gcrv7kpXsbKeDIfW86LURS9yVQUeJng6SixiYaXMNUlPhLA?=
 =?us-ascii?Q?rCSJRDTCQbaWTLWsngfiUqGYHhNlzgmeuNfK0h29/iFWe26Ks6ae5q6so5+L?=
 =?us-ascii?Q?xbaGYXu5UC+mAydRwooTTZOxmKyIWZOQ6bTSMyAIEqSKJ6egFXZDTr5YSGs/?=
 =?us-ascii?Q?PSypZ/9S3gj/+TxeIKHQ+Zy9R1pJl2SI3PXD9TEHhwIaV7uWk8ZalPOfDdqL?=
 =?us-ascii?Q?Xn4CXs4oXzvDLOPVLF448VjJKkCWypghc6V6ykqct7emx9Iwhtsy65z1XLnV?=
 =?us-ascii?Q?iHS4BDkneLoaTqNbIeLUtVzITdNBp8Qb1/s3XVmPZemHTNg4uXpGDrBVA6p4?=
 =?us-ascii?Q?044v5w26U8UXxWmsirOik2+xiXWWHbQnvsKzbKGBJ0ZPODQ7+RjVMoo7dU/y?=
 =?us-ascii?Q?nlRj7OcAGrPX0T8S45laqt297nZXbZhaeazksZwD6fNaP22ECjce4W/esfn8?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87af3c6c-85c6-4fd9-75fd-08dc4769ed99
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:39:06.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FIM7+Eqp/8qbn1r5oBAnWX6dlCp2TDssdnd/RSrrlaEqF/JqiXFOlO/IPqPQ40WHtBCNSll4UPWoNz0xo5KZEEX9a1YY0uzgQSJaYqEQR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132

cmd_acquire_transport and cmd_release_transport should not call
bt_shell_noninteractive_quit, this will be called on acquire_reply
respectively release_reply.
Only on replay the acquire\release process is finished

---
 client/player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index c9c6779f3..49bb52f98 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4893,7 +4893,7 @@ static void cmd_acquire_transport(int argc, char *argv[])
 		transport_acquire(proxy, false);
 	}
 
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	return;
 }
 
 static void release_reply(DBusMessage *message, void *user_data)
@@ -4945,7 +4945,7 @@ static void cmd_release_transport(int argc, char *argv[])
 		}
 	}
 
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	return;
 }
 
 static int open_file(const char *filename, int flags)
-- 
2.39.2

