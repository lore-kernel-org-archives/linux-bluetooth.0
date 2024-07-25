Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FBD3C3C
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908774; cv=fail; b=ZzsYWHSOx9El/pInXAggErm87bnjIaEFGigbubOh1Y5EctQRC4riaxAuxTr7qO1vc4rYCHV+lB+5wRcdn186sq8z/RPSIFsfb5RvEAi0JsWKZr1KWFBd8UqRXqCSuqsV8sqkqxWSzBj7nRaxct+2FEru15s3pHfBjWyQOYm7W6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908774; c=relaxed/simple;
	bh=b1sZdaoedYLsmMfIzF14uaUK/tZfaVq+31D2enW01Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/Wn1iTIcqb8pglqadAi5vvcgjTPLh0Bh5Iyq2tEHY9CyG01lqc8uTOFg5RnOR50GTDJc/an5IICadc16/ImPQ3RJcv8BKqo455hLwNihG8d6tKZC1VcSRO/N6/QRMR5XgoVGN3X/6NC3JIWX2DElQfod9cU0OyhssfLGjhI/6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mPmJMFmd; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mPmJMFmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xlvt0uBVMcJxOhhoubGldlM/7lBj4Imm/6+Y6Xb5PHEF1/rkWHeTyT7NVuG4V4wVpcuuRuy/dj5bLmElZXw4Gp+O7boJS8cBW1fMGzWQUhM7c2ze012/b6ikWqkbDoccrKoFSvq9VDhwbWbIT3ff9NgeHxKqCe2hk6hDaY7dkSGMlQEAwm7A2aTvjRhsrgOUFWA3mPLJPvLukVd7bkohnbriSGJShEwjzIgyHrcuVOdf3IRSgN9yrlpIijSZe0oG6eKaesmazj28NE+CxoWVzj+J4ozcS1PePQZiWizIEFBqTK1R+yYF9gS6IGROIDKaG1tyu8NwEdF19CFpdrCBBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRFEQtpW0VRs9rCpYINHiN20l23/jQ7nzxrZnlTzKeM=;
 b=QhPRAP4VnT6MrW8WXUVXCgrRinyqLQdbKYMSxDseW4VN38y+ttT77udpjJnVTlrcpi2PIQIP9UkJ+aZReoY6gtSL2FMt+NOmXgOkvLCq2vl7bWos7jAk8X0YOk/nafsGsBb/wqVzR7ulJ5t0XzmNsA1ftAsNNwP9DV2IovjNMcVbTXmM6ivxr3ACMPHdr3zMNL59tvqJS2Z3ONomYtxwarjvHCd7ynr/hIwZQUHhH9PxcJPYoRvcbO+qGUh3tel47pr8VWM6EcReYBsX4l6I0QRhjvwPYDLI0G01meF6792xXMRb98ZYD4mMXcIS5j1OyYe+/zg8+ioIXqytJTp4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRFEQtpW0VRs9rCpYINHiN20l23/jQ7nzxrZnlTzKeM=;
 b=mPmJMFmd8RmFOWzK8+FqHCj/Jj7AnaiNeOWYt+Zj8cF0PgOX3z5sZJLnTqTeD3H9wur3Gnp/GV5U2ZZvKbMEjZQLbni0S3AiTOD8+KAcxSdb75gMWX555aZjUD1QFKZo6JSgrWWrV5ngnNUdBKmBGo2kcmWqEQiAIYAYwNFmtP4KPe9sQocdtUNKrHrDkvJJaMZOV/IzsPrSSjd7fC/fm7g0Uf4DAOJL62mipObxu39gNHGCNoW8iv7jmvVlAkCr1tUrn1I8EKtPhaX9Cm5kENJDmN3N9uQw+rSulPzm2x/AwhiUeRgsov0TCmYSP+rnoOAecDcd7krZ/I6i+UIdnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PA1PR04MB10795.eurprd04.prod.outlook.com (2603:10a6:102:491::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 11:59:28 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 11:59:28 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 1/5] doc/media: Add 'broadcasting' state and 'Select' method
Date: Thu, 25 Jul 2024 14:58:50 +0300
Message-Id: <20240725115854.234781-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
References: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0026.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::10) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PA1PR04MB10795:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd7dd91-8d7b-414b-62e1-08dcaca13c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCmxJ3wUlYtLx+YzZmHWqV6ShGGqbemrCFd8FejChhBQnih9KPo6FrWV9cP8?=
 =?us-ascii?Q?iYbz+SpC8wJv0G+vO9nUXDDUxNxGsX4HIpOoAif93IpJT4axDvz3LgMwRmlg?=
 =?us-ascii?Q?+twt10CAB2ZJ5ottu+1h8gE3YRfgErfJ7J/rbgUvMU+V5nJ6sERT6/amwdVq?=
 =?us-ascii?Q?Te0/nHsRy5ehGErdUowQh4p5MQdddGLBt5Rt3DUcpSyilivHcGPcyl67okqO?=
 =?us-ascii?Q?R+u20CJzNGPD2o5KJjWb4hZVS72zCF3h1dKni1PR0KulGixoTijvnTH7+yVr?=
 =?us-ascii?Q?hhYFf3FmB/9k7F73af/ho/7H4YF66a222hePGvhEYo5BCDwMGubWWCL3XqrG?=
 =?us-ascii?Q?S4zEtlyeQMP2EoXvzC0UB/68u6JCcLmoRotb1RCY7XsRByKvp8jn0thwjrPo?=
 =?us-ascii?Q?VJpDRg/7Q/spDlr4b9VoPxEIkzqk+3a2n8C7bNMblJd4kbOrX1wNLJNX4XgM?=
 =?us-ascii?Q?iSPoC3r16nkGv9vQ2qUDRwCq/dAMxi0nO6ZOaGm8E+bF8BiAvilrKEhBhh4O?=
 =?us-ascii?Q?iGc+eWdsYI2k/g2Pg35fOM9r3jDVg9sUnZoiqd6Z/hT1hwyAZpEAjyv4O6f3?=
 =?us-ascii?Q?hPnpG4x/H95HyfJAakXS1VawHSdfm+dq24+qtp/8/hCsXb1phy0pfiJGnhtn?=
 =?us-ascii?Q?T+39sH6Se0GJCoYjW2ThUSxku5/euB9Cftw4CGPk6GN7nzEOjvDuRj3yHuwJ?=
 =?us-ascii?Q?82W8MyqeabmORFMHkwh0F0BF94utSxTo4FVG+taPKmawmGeT0D2MCV6ir3aw?=
 =?us-ascii?Q?LScVxZCrOUWkTr8LQTWyb4y4Rx+cglOLq/Ug59qxwAf+ru2jo/arpAZrgpSU?=
 =?us-ascii?Q?BVAObjyVdizKFt493appZMJ6YXo1TsUsQcDMyCNLYldgUz9mU8VzQzYg3S/z?=
 =?us-ascii?Q?tw/weNEP8jYHzfu7bp9INf0Z12MVfkc3eC0G3tbPsRveU1hyfAG5VWH2Xn0A?=
 =?us-ascii?Q?NIdUvHORj1glqHBaedD8gBcW1FjyUo8Fq7DjfVxWRMzNyDyfWDy5Tmp/iR//?=
 =?us-ascii?Q?D8gCqdFP9hWg3iDA3Tqd8QchgHTEnLY1OKfFaMqgr8SBIjHFhwFpU9Cd13zk?=
 =?us-ascii?Q?vMn/TOjhPuiUCz8ssDYge0VqMEYPU/yfM4ode5tycbcMlA29ih1hcfiiyNCh?=
 =?us-ascii?Q?/1eHDRiOzPTUuZaCqpqcfx+BGZRxDR/ZSrnfn3JElBrA7ghHKFo+vLHi3Vc3?=
 =?us-ascii?Q?sY44bOf3j4O10rFITV6qBLK6B9PO/S2nwTZ6mKFWmnnpq+0G5xcSw088kM+G?=
 =?us-ascii?Q?h8BoUIP+cQMWHL6SXBlyz1HeWY9wdYG9v5pdlRDAl5vE4hcU6skZlo6+82iJ?=
 =?us-ascii?Q?EjehHESOCmM6/rQUE2y1y9Y2ab/Z4Rhdeani7r7LNHOpbD2w0r+d2oC3APhA?=
 =?us-ascii?Q?kVL/EMTCU3S4VU4HA37s0c1IOm3PSWlOfPcg1EyZXlu5czNM/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uGHFL4oivMQNBtrmjYsniaHUBbzJlRez2CDnQUgfVm6FOl4rq0mMLdXyTvIQ?=
 =?us-ascii?Q?7MIBedTIF+oz3aROK+WZpNwU0stc5SyR/z5qBUMAwd4Z2wG6juKeWgxaibas?=
 =?us-ascii?Q?eDutYcV6J3IgfVAGgGgqflUoCkXsHLgUrQrvmCJkuSi61xBJzANOdjBOEVyx?=
 =?us-ascii?Q?V2wyzYczlktoXdt65blev9tvx2YincPacalyk9LKdIqDshwpxAxd6VH//Glf?=
 =?us-ascii?Q?K0xbclzqanXENrM/vOY/sZwq1FnEGmLFDUAc7qK1AfjE10oYkS/+Ai1j5qG1?=
 =?us-ascii?Q?zr2rTBf4PFmcX8JBj4M/6NTljeZbaZ3dVSmyogky0KLMFPhxLeml+EsmeGFm?=
 =?us-ascii?Q?qG539kpfJlAwvAS/efgJ/6BWki1Ls4d/Jlvztt0NNN9ZEvBWHueTsFk/wrmt?=
 =?us-ascii?Q?aDvZbE3C4ABBoOnEKggkJgatXOWCWraWOl61B95xXOu8z3AlqzMBBL3gG8r8?=
 =?us-ascii?Q?nbnktq+GYkCxI5al0uTWsIklhpYIbCkSMkUpxYa0tTx+O2O9AvCr4yKXHRlj?=
 =?us-ascii?Q?kEUaqwDY8No9XaWsCPfAQDpUa61E6VeivpFcLVtEDuqwPmKz9zKiwk+vjgLE?=
 =?us-ascii?Q?0hUDNDop8s9ySYTmzDYB2J4ESsPjybinqPUQJezixSlQdN/+CgQavHKF2dAn?=
 =?us-ascii?Q?5ST749DYctsy1bDmHdwx6ZXqj+mnvQ/zGTajB6w1OaHLaxu9J3N8sZYMPhbb?=
 =?us-ascii?Q?wUjW4sKXYbxpROHwfxQKDstWsVNuroYo7Eq3n3Z/AAQtwITQKXK4GUNmKXaa?=
 =?us-ascii?Q?Z3aCWLwwDNUXoaiF/RsQfnWBGSgm2GqKkinhcFxsL14JEN6ItEbMlrfIvEza?=
 =?us-ascii?Q?eQRJeXTJltBV/8gxifPbRfC3WWw3TtAr0O7C1jpgN61YzxF5DS0OSKzvL4vb?=
 =?us-ascii?Q?CAJk2aIFTswNe2tMA4gtl0Ko2bOw8naff1EcIrlARRb1/Zw2D8Xqh0oT4SIn?=
 =?us-ascii?Q?0+IGqUhcWoi5sEHfK6AAie8aOJ6HqodTRgosXGWvPU+XFW5JH4ZuEzV79doB?=
 =?us-ascii?Q?5N/WnMoeb3GO5Q2b4THfqvoRpBNYRNZp8pxZCLVx6VuPXmyW7TSi1o056UD0?=
 =?us-ascii?Q?fAb1KtWr2IPOOFZHs3k+LnCh5MElzP8Q6k6mDYoEHiV3RyZSEYbKY+V/igCv?=
 =?us-ascii?Q?hfeZkp+61rDLc2c1jfyXK5aMBRHwoL9pv6O0LCEatFzHBwYpoS6qzXrq/7sV?=
 =?us-ascii?Q?bkqlCah5Gy2zRgcQHv6jduy+sHx2XTOufA2SvgZoDYd0WaZ9P4njeyguMN+B?=
 =?us-ascii?Q?+3dHUA8rxMzLnA7QkT0fJjYt14fsCS0gPVVvoScuSt7VAfhwfs60+Skokfe6?=
 =?us-ascii?Q?m0lq8LCHQHeoT56H7lJP26zpOY56V5jhFXrRvydxeT+8jMk+Kbihb21zOtsQ?=
 =?us-ascii?Q?ZB3CULoIccvVoSyz5NCW93/mZK1a9AcfuVu7lbOlmINejeXY8bE+zjrvfzeg?=
 =?us-ascii?Q?sOFLA6RY33GBYV/EFSMfxZ+D/9UexPP2KmPTOJoxMQqFNt7nO7CvhA56rRnD?=
 =?us-ascii?Q?z7PZYwfs49Vb/+hsvZK9ZxwGsPXY9HjTyBznj5PyY+BDp7HnqRg3xC0ycXXC?=
 =?us-ascii?Q?hfPvLjcBOjVClVMaWcNqQK9oLOh62BIO/2Ajfs7q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd7dd91-8d7b-414b-62e1-08dcaca13c60
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 11:59:28.4226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMt341sRGaFWXit2hsvIO5WfIKUM+ER6rrj9v6fd9C/BpKtMKGUvKK/oipEAM/0u2IwQZY4zvNZINHfVRQji4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10795

This adds a new state for transports created by the Broadcast
Sink. Such transports will remain  in the 'idle' state until the
user calls 'Select' on them, at which point they will be moved to
'broadcasting'. This allows the user to select the desired BIS as
the audio server automatically acquires transports that are in this
state.
---
 doc/org.bluez.MediaTransport.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 6e95df8f2..47346d36b 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -7,7 +7,7 @@ BlueZ D-Bus MediaTransport API documentation
 --------------------------------------------
 
 :Version: BlueZ
-:Date: September 2023
+:Date: July 2024
 :Manual section: 5
 :Manual group: Linux System Administration
 
@@ -51,6 +51,18 @@ void Release()
 
 	Releases file descriptor.
 
+void Select()
+``````````````
+
+	Applicable only for transports created by a broadcast sink. This moves
+	the transport from 'idle' to 'broadcasting'. Since the audio server
+	automatically acquires transports that are in this state, the user can
+	thus select which BISes he wishes to sync to.
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+
 Properties
 ----------
 
@@ -84,6 +96,8 @@ string State [readonly]
 
 	:"idle": not streaming
 	:"pending": streaming but not acquired
+	:"broadcasting": streaming but not acquired, applicable only for transports
+		created by a broadcast sink
 	:"active": streaming and acquired
 
 uint16 Delay [readwrite, optional]
-- 
2.40.1

