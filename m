Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBF1A2569
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348612; cv=fail; b=KB+M5XLB7AgRQJgIXkWBT1itmlMG3Wn9cS5CsA+YuQAsXjQV+ww7wEJW6q2prwECk/+7CZynoEonGn9QVsmiM4z4g+RcXfeBqUaomJ2fwUuwmiolx8wYzmGUPQyrIWT9lQvmwHyKS7HILYOapDsZ1cHck4jadKlekDxBOyJRcig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348612; c=relaxed/simple;
	bh=tq2W0vbZmYoCtaWgRPoBXEPV2G/qM+rxWoRoLePHE44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PVMYSV+psk2ElyUo52uNL1hEen1lrg0S4M3SVha23jhNXbIEjn/19sAqWyg8+ifWyHykT4TrRfHSGUCAZ/R7n7Fk+GcREUawriyXwGkDCjHP4rbQMma1EN8cMk7OHirpOZWVIXp+N2KiAZpCTm78AF8/MoReuVk7v9Cb5xPEnw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UKjDX152; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UKjDX152"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBW5Moc960R24bUjDToSquQFCNVChN8wUxRZ75EjO+naLUywQNS/UItEO/6PmlV4XxTxSE0HEeLCZI4zICTLrBXRPSb4u8Xcj9aJtKP2Rg8oovkhUfRpPLt3h6J38wBdI0zSY02qi/TYUrAN7sWcdunNO+KKOGzXAq8GkaO+t5wiG1/ECpjkVz4b+Q4kLm+j6QWT1CGuGtGqGiLpAA56u8h5mL4dZMKz4snrF7luA25nEWXdteCT4icQVHqHFP96lsUvHJPFqlbjbvOfjn4lqqjZMWw1I1qNAUiQo9hmszzFabj8GqKifRSnnReDcNSE0hph3x5fBFyEt0LQAiEDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg12HxRnf8JDjChYVEgDKd0Z7feZ0QdrdOpbXDE9QFs=;
 b=fuTLYzvrycaipkXw67c6PjHNw+lkJM9KmL+QQxUvWjTMtBzkt4ZyIcEdj5fkovNTtH2naa9fU9KtNA5qAhlj7rCPpjXSjK4lqSLqurysU3NUUgBm8BUFK3HKQ2N0lQwEfSFJhkzmuqbx9YGsKEo8iHpd/QNToXB4iA2H7Ku5E7ljeFgk0ne9bI+lEMgpl52lpowQL2L3g7+eGaJ6MygjmscTBRFSFQvoFQ51jlEjZug/J1cGu6oSHlA4ko2CXQPtA+c8MzySXuDDcEEGqUwGhroqllaq8f0s/MqsfUbMW6M7cz8dW/YQUcqFRZWi8rLLVKB/IhG4aextWYzyR/6YDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg12HxRnf8JDjChYVEgDKd0Z7feZ0QdrdOpbXDE9QFs=;
 b=UKjDX152VDCJrlj22Up5qNViPKVZSdGkXhH74AuWUQJgU2hstys2gFrLsvybVMAV/WclcSugdACqfKJ18UCHpxawUP076EJnnDod25/Huz1vUKwy5v/O8dzWyw3jjgQW9jzEhwkhusYkkXvFbMSUjMi9vX54/kILst9RtMdrOquAJsNuQbyP5Duxdw9v/fb3jqY5a5GyKaf1AO3/uAbuGyJVVxBD0zmF1R97ufKjCUIUymELylEqyc6RHJrOx90C0+X/5NOQhMtxpQCrN2qzw6Uq99B2HUfJmzWKON/T/iyeLJIeTfmP72cIYY1nr27n4E8BaVpkaTiQCDcMuIi2BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:10:06 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:05 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 1/8] doc/media: Add 'broadcasting' state and 'select' method
Date: Tue, 30 Jul 2024 17:09:40 +0300
Message-Id: <20240730140947.411655-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
References: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DBBPR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: bc14fe01-9273-4b17-f45e-08dcb0a14ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UxVJOfszP9ALRA0rPWx1LCKNqd9PCwtrk6vq89rtoaZ43EcGGhA/KN9Eg9L/?=
 =?us-ascii?Q?jVk6hJVNXnVfB5ZBV2rcUjTg5XdHQS5lnXPlJtter34xe5Lhi1fC9DWr/NCF?=
 =?us-ascii?Q?IHFLsZ2F7v9/qhcKA2pO1obWT8/kxiPO8QJZ++bkJZ1Jq9I3NiNjoU3ODod2?=
 =?us-ascii?Q?ubYhuiIWFCWthtKk0iNfKqhfZzwdjvjwc5E2DeC6zbV7dUik8vRQ9mGHZmRE?=
 =?us-ascii?Q?6ykfsS6TGJBddWxpTrvsZssFNR9R/gwWpj7wBqOprjBlX9LjE0zRZRIusJeo?=
 =?us-ascii?Q?k499LuSqpx23t07ODlWnXW6TNHXLpD4zDi/+Byzvmyn5mGQz0qB1jJDxQuQx?=
 =?us-ascii?Q?u9PxonSsBAViAnXjz6ubSRQDiwqOYHZKvsU6uJ6GQQyGnl0LDXbePiuwSurW?=
 =?us-ascii?Q?xnmCORDbek1AGCqAGP5XrxUi6Q/Oyf3+5utZp/bQLkJA6oEEeFCaqPHxBqrl?=
 =?us-ascii?Q?+BzlL/fOEoCDsu6CqNjzok+4PeQFhWD3q81ovKZJEd0neubBD9mDpM3x2HFx?=
 =?us-ascii?Q?+oGXUVAYm6ZbjCJAmXEORgW/AkmGHXIX0j7BLC23Lqc2Lg5WV3TWkTwKrZXP?=
 =?us-ascii?Q?04AcnLlGT6jBB/Mr8N8GjADGZVCiKavxa49h1RJnbEzndKRdGaPH9hD5ZDb7?=
 =?us-ascii?Q?Fbdk1M2RtCWKee6ytDp84UvtIRQiwrNH36NN77Yy62kP+Yhn+rp6hiYla7tE?=
 =?us-ascii?Q?b+QT9jP5hSCaxLiuLtJGc1xK9+OU/ee1ziFMvLME1RtFqia8ZOmAUod6/S+8?=
 =?us-ascii?Q?OdE1lE7MnCOLnrRMh7cIql2fcAZlJbzaGjQi5BAX4X/xBcS6rEiWUv2I2+ul?=
 =?us-ascii?Q?vmBSUdWUCjFwyPC73hT4GvnQwEP+WcaiocIfCwLNDUyMh9rojIzAaP3fFFmu?=
 =?us-ascii?Q?AO+l8PUrV+5sSfue+sjSzqsPHBpJqpELgmS1FtsQXIDBDSTL/e5pt1aDcqID?=
 =?us-ascii?Q?6EW+ogGYt2xm1KgM8sTZp7QFFHv1Urya6DmRrKp/i8VPL3/yl7WuwUK6EG8h?=
 =?us-ascii?Q?DdroH8XMykd+YVhhY6d/cmE4UUs0wYbS18MDwXne4bzhvRhhUTWNkhOCnvkM?=
 =?us-ascii?Q?rEAN31TMAcWXC/JLxgjzIVW5wb+XsA3YXi4LCaTF6P4K0FyOVyX8420JG6Og?=
 =?us-ascii?Q?eaUn/18d0Xt7bXemKCIL+mFghgNrPPsnvDChNo1U7/JMBQVuFrZKzur//+p2?=
 =?us-ascii?Q?R1k/g0J6Mm3Ai0WLH3T2KgLRMp2nhIHtIhMHyASweAiiCfYbUCEsksPJe/qY?=
 =?us-ascii?Q?JEV4S9VMyxrQXtH9fNNgDlX7VNyc8PVRgZi5nf50dYEKHrhgtjAJr8LH09CV?=
 =?us-ascii?Q?B2e7qfDs0H+UcHCCrIwXowZxvtxFNmtrFhOslcoUY++bb960LSH1W9I+Xij9?=
 =?us-ascii?Q?yPLEFbgpBY0hOUi3eZY8zLmd88kwQB0A/KUPBgveBRWQ0es7Sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MJrR90doHlTEHdDEPRZ2JCfvaEELpJ6fTEab5yfUUe1hJ/cetcElxyttb8e9?=
 =?us-ascii?Q?/z0yfxkVnhx0Dlec9RY9VM8IFqzZaCQISfFTjbK3Qz3ZGKdPRWpXEad+Y7JM?=
 =?us-ascii?Q?ERwswoWUm/jQcKq+5EPHY+ouHcHxBGAE8H3PzPS6ckm5MNe7RAIoAhuTKSve?=
 =?us-ascii?Q?lbdHqo4voP3YSrwBfU86GBUkMbZk0nBl+D1YPa4K/Fms6R0yRSiOWDllSvBq?=
 =?us-ascii?Q?75micrcvNYMXCU86M5VxOOs9YspJ+arBIuG9z/wes3yAeqF/LLE7XO8nt2R7?=
 =?us-ascii?Q?cTeAhwwfzyK0JhWOZItq3IlRsYB3eyDTZ4Y3DaCmnzFAAFrQ3uzwq8t+iEzf?=
 =?us-ascii?Q?LTenE6BYsOq4d4I4xVhNRr/81Y5K7doCNnHzFbgy/vvstXMjZ7csyBN3c4yb?=
 =?us-ascii?Q?pXEZJH/dc+pOmdh251AlxmboBt1SwqT7ygO20ZfnkfCFKv0nI5Q+5xcVYbvt?=
 =?us-ascii?Q?Wry8TDOY0R8otuckUROcO9AlBn9laR6aCSLvNIqgDDGntLn10pO6dGKRI/Og?=
 =?us-ascii?Q?JW9X1vJiSOo/OXibT4q3eNuUBMHtquDmvQf0/eA+vf3ruRzweehsGAALzIDT?=
 =?us-ascii?Q?T31U38PRGqJtZlqDLsB4OXyFN9EnJs2EqnD3Kyvn8q08LbXOoxRHf37cNKLC?=
 =?us-ascii?Q?e67r6xVp5K2W6QkSWDOBDbEQm0SWigCfalsNlDmBsEINe/ZMBZbRsNfkc/8A?=
 =?us-ascii?Q?o9zah54iQmIjF0uYS/9Zg9F4dWRGgMeJJyYxsgSbQWwkHz49PH75DMSD8BPn?=
 =?us-ascii?Q?IkP1RO2+3s/C1YZXHf13X1uydtE/E+7eAOAwrw4mnc8YDtztgOP3lTVWTVyn?=
 =?us-ascii?Q?BLGw+jTVaMbKhrEDOCbMOMs+SR8oA7Uu7EG4ju4KH+UrOgLF5tPsLgrOwdi7?=
 =?us-ascii?Q?Bl0N2BtSFeGZWd1L/FWqCtLDJkcG3flxUG6VA9LEk6WBR2TwN13iqF+oiacZ?=
 =?us-ascii?Q?TjtKgUYk76G0cZKtTfctfpYvTwWEyVZK6lDmH48zc7PBPUTYcEHWCHhZhRw7?=
 =?us-ascii?Q?hmezmKtxB+QIOwqFbvdvY/gF3OoBk2roUjveK0JZSRxg0C6/wQZVA0FxknyP?=
 =?us-ascii?Q?z460lYffmd3TKaZyc2WMJQZJryW/648oTTFDcMUT39Pa5gQhE4HPRXbcmsai?=
 =?us-ascii?Q?5J9Do5nLiNF4DdAqCjEWKYYM5iQasVjJcq0I7mOaWqC/FZ9t7aVOVYFJ5Ot1?=
 =?us-ascii?Q?whYB7WDC8DXbl0QfVNBt/KjcIpCUxB5hUYO1ccop6KHYTGaWSDQ2WcchndRW?=
 =?us-ascii?Q?MJCZIk7wHPfi88PExPs6JABHz+8e1HbXxpr9RAVGutAy0J7SHHy04BeGjNQm?=
 =?us-ascii?Q?tadlOG7MbZWTFMS7e5hzIbCqArx28/Y2UFffTETcNk2Fpq1XhSR6LW76yqpz?=
 =?us-ascii?Q?UZI63kn9d6glHeJHcXoytVJtpEuDYs84s2qzmj5eE4/Qocz5x/Cs2gluH8HO?=
 =?us-ascii?Q?iA9eAOZWgASnEJCy3h5xGuTiaRe5gDzhU6B6e5fuWfvttJ+8zPMk0phe1nkm?=
 =?us-ascii?Q?ggsKG9CPJ6bcauC3r51sHQdPBjKXLp0dkRSQCzZ/awWPt58+xpM+dM18AMJj?=
 =?us-ascii?Q?SATm3Q0XvCLka1H9+SCNtDZWw4y+tTEMCbTSwNAn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc14fe01-9273-4b17-f45e-08dcb0a14ff5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:05.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPwJKalM6Q23J5aYltvwHu54oF43bmSN0tRXf9rTa7FTkPtVHuWshgH/04HiUy77NOA+6ak8/Wxa1vB84/THvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

This adds a new state for transports created by the Broadcast
Sink. Such transports will remain  in the 'idle' state until the
user calls 'select' on them, at which point they will be moved to
'broadcasting'. This allows the user to select the desired BIS as
the audio server automatically acquires transports that are in this
state.
---
 doc/org.bluez.MediaTransport.rst | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 6e95df8f2..c23d1f59f 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -7,7 +7,7 @@ BlueZ D-Bus MediaTransport API documentation
 --------------------------------------------
 
 :Version: BlueZ
-:Date: September 2023
+:Date: July 2024
 :Manual section: 5
 :Manual group: Linux System Administration
 
@@ -51,6 +51,20 @@ void Release()
 
 	Releases file descriptor.
 
+void Select_transport()
+```````````````````````
+
+	Applicable only for transports created by a broadcast sink. This moves
+	the transport from 'idle' to 'broadcasting'. This allows the user to
+	select which BISes he wishes to sync to via a 2 step process:
+	1) the user calls this method, changing the transport's state to idle
+	2) the audio server detects that the transport is in the 'broadcasting'
+	state and automatically acquires it
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+
 Properties
 ----------
 
@@ -84,6 +98,8 @@ string State [readonly]
 
 	:"idle": not streaming
 	:"pending": streaming but not acquired
+	:"broadcasting": streaming but not acquired, applicable only for transports
+		created by a broadcast sink
 	:"active": streaming and acquired
 
 uint16 Delay [readwrite, optional]
-- 
2.40.1

