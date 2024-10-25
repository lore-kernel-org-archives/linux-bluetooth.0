Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46F1FB8BB
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866552; cv=fail; b=Yy3Kb7n6+5sKyPD/fVafvZHKXcOwY8lsI1GeSStx0LlDO0ZSby8/VGoXHkMEm1fX+APkRXdyDCY8Bvcr/1WIExdp2tKa+QZKxHFGA7RwgZfkcbGhMezUzOszs28pBnLeQXXnPgJxIpp94pEPljXlNAeGAWvoeMrNiK796qCHLTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866552; c=relaxed/simple;
	bh=+Cg52JgZpTyFa3xpu0DCKrd7cBkj1fKCUXxW9U2BCzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bi0wFL+yH9KHrzKUUC43Rv643VtjUmrrlBlAtypKaf+yMQ2iEioEpZ1zHCdXpM1fzV2xYXZqtIdKkjYjtQP0VUc4VlLH7ouR8KD4ofQ4Od5jDFPJOYvHBwkKlyBh+x3aZmV65dmpqC7BvS894QkGGB1mxO7pUCgzUGz9bh3nrs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lJCGz1Ll; arc=fail smtp.client-ip=52.101.65.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lJCGz1Ll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ao8i9JUJIqhJll5OQVWvuk4cksw8uQLnGAqnmsfspMX5hSszsjfJq5I5L8Lv89weruplCwK8GEU91J0LGtimU4ToWw2eTfAf5vXxyi6IiIqxt+9bpZSS+Jkcn4kYjgExFvdX0UdVrSlkwY8GFffytTZRk3ojBTI+W4JiXlei6Zr82WdlNw8pbxrRdZuaazhcuQuJ+8K7huSTeDKJXZYAc47Nw32S1uQTe9NDI9YwIZ1osSgPLwxVuklTeBB2nvRQ6MLd0QsRkaTz3o51QIFtUa6fmv37ZZMexGGSf4CpiUGX03GmWSaqphkvWM73cR3wtV7Gb9rxftJ2TtkJ2QoJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1h52PkuAXPF4cHSIQ1j50LIxazIYFvfJP/DygbF1vQ=;
 b=ribSD305WWWZcOUls0TBtKntkCnAi5oQHuoB0evzGKYxkq8ykzEeX80Yvl0D5Fzd2K5FmCXDFaAYGYLqpwQRzT8KUS5gCilcs6XB5qs+yCKOQWTbMzMiUhArta2q9ciRksDKiU24Rc+7ZOGDCYxx9FydUS4JdaV21z63U8jpJwP2hKStaTFxHJ8AmSDLkx2MHkWK3ks8g9uPrjot07FTQCkWj8rTkWXBGNICx2/p/tnZ5nKAXOpF/DvGXZ0nHrvqWA9hMqh/rVTr2iVcRwwthhKplbvcVIHfky674z5UMI78AwB8MUPKFTfGdcO3a/tM0+v2nzAIfhY1YDG0ST9jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1h52PkuAXPF4cHSIQ1j50LIxazIYFvfJP/DygbF1vQ=;
 b=lJCGz1LldN6KiGQkvtTwNZDUEfNCCCml2X0EyrQAbyjkK7GhhERc3ykWZcb8rYo3GLlfRcgxVpaxeahwHenyGxwIOLnu0ncEAIgv2J9QFCTOKA8GGFeX8UFLJZK0wB02RrJhi9jMy4ZxFoG8JpYb6cK1M3DgTrAWP/KZConSfpANGuEdfj/x0YzTbqKLBmMu0aI9u3F5T70gW+849I+DGiR8ziJILL//rOUNkX+PJ9XdYoKLqFQROIQLITp9hvqVCSXXtaqnJiJ5pQqjBAGT7GHT99vXxgxHEaJBI+5Tk1vz0cmEYKT3A94ObWe3Jr0Hb0Ala8MkKA1HEG2+JfaEvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7254.eurprd04.prod.outlook.com (2603:10a6:10:1a4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 14:29:06 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 14:29:06 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] client/player: Fix select/unselect reply prints
Date: Fri, 25 Oct 2024 17:28:42 +0300
Message-ID: <20241025142842.46566-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025142842.46566-1-iulia.tanasescu@nxp.com>
References: <20241025142842.46566-1-iulia.tanasescu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7254:EE_
X-MS-Office365-Filtering-Correlation-Id: b4cfab1b-b8e2-4738-6215-08dcf50161ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mhzFgEDkYzjryOiC973qekZU3yNBOyagKTQhJ5g7RrGrxGA09HIfl3fQprqo?=
 =?us-ascii?Q?3wGZ/aFqDzhratbxE4lXAaAY+dL4AoA1r0oTWDQHOERhYvDtNg0DZr+gdZQg?=
 =?us-ascii?Q?JXEJ8P206LDR5MqMGijot4ye3Z1pPwG/AKi842uDLLRnl70kFlG3Zzao+2a2?=
 =?us-ascii?Q?sF9zacRfVfMAAeoi6ovQ8OV/yZVOrIEf11JvBovKXNK+xBKa8n0ffqF/yTu0?=
 =?us-ascii?Q?Ke1M0WGKZDc9Y67fRa9EPJs9bUr75oAkEg+vext4b8K4icz1C7JTVTdf0LYK?=
 =?us-ascii?Q?NdBbk8G65oH48OMmBnC8q+Eprwzx2nImCf/6VLOUmTJVz1xKS3Quu0//TAh/?=
 =?us-ascii?Q?fTg6P9M6zy0uObxCbvjExMUXBg2Q8mXEy88h3OBZ4hsikIafZZ7msQO9/Mmg?=
 =?us-ascii?Q?4IX80eOpTtgiC+QVzgdaNoU2O1gVd9o1H3rPIgj6k91UPoC3dUwPQB3y47GW?=
 =?us-ascii?Q?HVTHDDW1XOgkFUHkQbBjckdC110QkeSR1g67O+u+7RoTUJejPJrSocLSndBU?=
 =?us-ascii?Q?swgVenAiZ0ONbnWfi6kZU7if9C4NF/3KeIWLAIQl3ojbmGYek3w4j3jAYKCs?=
 =?us-ascii?Q?wT5QxFUMatm1fvkkvyC7gNy9VJcCys108QsthbOmKeu2qC3BvWC4znz/shyo?=
 =?us-ascii?Q?rLGGalb47d1/QdOi60TeTyJHdo/YJ8WSQGNYJICV/sYHzjC0af9DcUTeeqjq?=
 =?us-ascii?Q?T7l9bBZ80hAy5hcmcG0fZCShBDs41lD2bPbDPx/Dwljtj2tLIooXs5BL7NPW?=
 =?us-ascii?Q?IJVIEMuxefg9Y6ppIlKzRgSBzPHU2gODDGaWRvQ75yzaOVoPVJsw/qmHa93l?=
 =?us-ascii?Q?soPm9Vp75XVCY8r2GrkqxlJMc/Zq2J9hmj3Q4+9pM9WZpJ96mJiRLNrtAxkQ?=
 =?us-ascii?Q?xZeMZVcwcyPRfC6h1WoU+g+G3iksc7D77q5YKbGOymWQGzJusHjIyiA6Gsr9?=
 =?us-ascii?Q?exhY15sfHzRPNfQvEVE7vU+GCBzHnOiboMtcvHfNDHZKTTTtFy/WVyaDR2Pf?=
 =?us-ascii?Q?KSc82yxxrtS0IGgemf80lvZLLwUQa6yMlwVVTugKTHrQfkFR6euDBq9a/7OG?=
 =?us-ascii?Q?RYTN49j2SSZpDaHzh8uxbyfP9pgArbMh1bHREHR+VLIj2X3Cw45i0AgWO0I9?=
 =?us-ascii?Q?Xq0j8aofoTpruYG6Es21VEGu3jsieCWezVUmOF+OEUig+XczkumLWr2GXkh0?=
 =?us-ascii?Q?7Th8ELNTUeCJsql/geXkuY07Zy/LSouNW6tfj/iqqaIm9OwbzwPZQyp1g9lC?=
 =?us-ascii?Q?ATc7pPu3yYE6/Q1AEFunne1zZSJ+f8XyXgaZ0eVpzkoQm32D321UQ7RB3T9v?=
 =?us-ascii?Q?KAIDAUTOOicOgeMgvyALoBpIMLqJehX4jQdVBommwOyPcppO8EU/oNCXZVDn?=
 =?us-ascii?Q?PbT0FG4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cgEUUNDkHBP3kZnt+K0Jj5/9DtiyiO+IQvX6OanMD+QWKi8hra2LEgsh3UdU?=
 =?us-ascii?Q?tFpFbX4kznY9HJ/7e2OjZEiC8yqB+kw6iZQQRyaIBfRvsGzP17HYthpguODM?=
 =?us-ascii?Q?Pp8n5daZydQUWJd09ynhdrya1US3m6HuYCTK+0pdc99Vp7jEN3fxoEVOLh3I?=
 =?us-ascii?Q?9jzMiFWNXKkhQChSetI43Qjcxz8U4l10yFrGtvILZSX7bwm61Pl9f412wZzW?=
 =?us-ascii?Q?Vc6diB5Blw3nT1IoMzPYR0O2fDY7lYQky7bmlJlb8i3G3LBs3/xoQrWDTg5T?=
 =?us-ascii?Q?GJO7iv9ib1+zfM6YFAbJ1JrY/VxIP7lieWsrm3fyJBMPE35kO1q+qFcZlakS?=
 =?us-ascii?Q?PHS4rk1zCUDVkM/UvT7hXWm1tjWAxQ12PVegFiI/0jfJqFB1EsOHDFHjIAn3?=
 =?us-ascii?Q?f8Xos7fcc1oRWOADtZhs80eMj6a9OT2ozU8lS0N7Wmd8LbauGcu8PjcsEQ4P?=
 =?us-ascii?Q?HFjbYwixik9i9gQU2m4TUMdxyaMpIu5Hc7fhM0bYS9wV+3ufao8YjKPS9NwV?=
 =?us-ascii?Q?dxTofivuzVSVCiCXuIzrVM94jN9i/lhQvP3lH/SZir2DviSRkx4MSeW0SHLZ?=
 =?us-ascii?Q?W+3vZG/lFa/KrQSLYgMziFQeJM4elmpJmSgAXJW0MZszOcFdd0BzdSk+o22q?=
 =?us-ascii?Q?5L9AKnFHiFCG0vnAKb0vHKXIbg4cMb3rvWSZc253AHR3nLbSEQtSjlkh+QMT?=
 =?us-ascii?Q?5cc7Nlb1EKHmENnR4xGebCPW9yaTU3haTwW7S9OXJHS8ZAtwDBvoig+tohJA?=
 =?us-ascii?Q?Tn5HFdy7SnoDybArlUSXpKyBdQVcI5okFGDjpiWlPfAZWqGndyCeJ8ynnfIa?=
 =?us-ascii?Q?w+FTw/H6kiugMM8ajiM70GnfQ3CTvEnGVfl6tReAtxQKeDjGs0p3amBD2GQd?=
 =?us-ascii?Q?Yiq/xdDow4Uq/CjutGOxJOl/VGvQDQ6eF/LI4RGSgF7qSAzzVUFw3lQEGF/H?=
 =?us-ascii?Q?Ub9OVHsZLNUbyDqHr286lrUr57eGe8Xd1rHpNa3ZsJTNaa96yBr5y6hMPN+F?=
 =?us-ascii?Q?d39rufu60/x7glCPgPKAvZ4lvOwvY93KQCe2+ahIrpTWBVToQR5uFZFRTQrL?=
 =?us-ascii?Q?24xOUqlswpYa8fkped8hrDcw6+146eDGB4pz2gTFBw4fDYAE5ic2QznBZyGf?=
 =?us-ascii?Q?B+YzHuUJDEHREu0S9tLiuv8+XYb/8s7082NLtGL+AM6bhXQmzJJNPIlMsBia?=
 =?us-ascii?Q?cL3Mc2q2FBUnZaNEr+nXYnRQrdYn5utkYWw6EQSPB0snSQpmp/VP8sRzbXOM?=
 =?us-ascii?Q?Uz+rOf8AGyejJZrjjnTmWW3Xo09Q/SuHcel/y4KsHBo+uObKXhK7fcRR+Xcs?=
 =?us-ascii?Q?MkyJGW29pDwOTHG90WfifR9NTt95+Cbc0yRZldlS4nLZHHaf9Rv9SBOCzFyw?=
 =?us-ascii?Q?LtTIk7n6+/YOXtEJ8ko5/M04jceg37nzphPQ5s0lmpcxisShkqlnB+dQitU8?=
 =?us-ascii?Q?sWMUdUxSFAQ1dAHCUPOHB5UW66UysoqVdgsJCy94aR+pJw/7uxeNoyZN7YeF?=
 =?us-ascii?Q?t/hBwmBNmUoe1VlyKT1aGUcysaNWT5Inj30/5XrAE2A6EyeGsnQQesQOehfJ?=
 =?us-ascii?Q?Wi/Nd3sjzZv8y0MUyX7Kz+pFgBDjHefGrCVB5HXn+sHgdvX1CWvfzV7FwBL3?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cfab1b-b8e2-4738-6215-08dcf50161ef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:29:06.8074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38dX9IOdkzmc7Mwy6yIOm/09MuqBjFopW+vkDV7CHVn5RmurKbi17eySMZO7RpbBBViGrsG1tZg+WAhIFxhh+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7254

This updates the shell print messages for the transport select/unselect
method replies. The bluetoothctl log below shows the fixed result:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
Capabilities:
  03 01 ff 00 02 02 03 05 04 1a 00 f0 00 02 03 01
Metadata:
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 17:7A:80:64:A7:93 17-7A-80-64-A7-93
[17-7A-80-64-A7-93]# [NEW] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# transport.select
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: broadcasting
[17-7A-80-64-A7-93]# Select successful
[17-7A-80-64-A7-93]# transport.unselect
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: idle
[17-7A-80-64-A7-93]# Unselect successful
---
 client/player.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 188378175..7a0631d2e 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4870,7 +4870,7 @@ static void select_reply(DBusMessage *message, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Select successful");
+	bt_shell_printf("Select successful\n");
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -4887,7 +4887,7 @@ static void unselect_reply(DBusMessage *message, void *user_data)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	bt_shell_printf("Select successful");
+	bt_shell_printf("Unselect successful\n");
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
-- 
2.43.0

