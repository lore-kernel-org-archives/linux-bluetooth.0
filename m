Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BF017E907
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 14:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018735; cv=fail; b=aBOjIUP9OV7iHQXm2FvGYKuGdgGrVCw+CNZXcZMWbJa6fZIf9jpPXKcMIdhj3I0TkQmKxx6NYoGDvKPs5yBnhz+Ro9bIS1qDbttkb+dsWqHxgwsursT1oH2F+5orq/p9zV+ux75sc6ZxdwYhka+NRtvC5IzseFfqSbR4VNJCzpM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018735; c=relaxed/simple;
	bh=eoDmSMLwoW0MuG505uvtv5Lq+d2ku5o/dkenzPqn7p8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fkor1Tg/2wXw00jTE4FTIYOem+kuJ9uRwOjlS2bKDm10ndsmS0/6hrtsCZivpc9+UPKG/DcaBM1I/Htbh47T9aS0+37YMIxJDDm5A9K+6Wg9oJrV0gc9kmRzM8qvEh37JwUesd4ybi+KS8lXZfl3LoEvxZ3Vbn8ifytxBcYhLaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CDD/Gmok; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CDD/Gmok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4A+6pap6Rga2vNXI+vCJ3v8kW76ouVEkH59XK6nrph/U/pzUxj5czTLzQkLmw4Jemvwqt47SkcWsBV8T4Db4sLYfD/HRdJ438+vP2qmDAF1odb6P1iBoViX4MvcW72QFT42ZuLz9vwu3SCOkL9ExDDOVDzOYiH77DGlh372OQ0Ln7tPpUYJrwkZdf+Iiivpt1s5MXzD6WzEp2EUbgwpE5r/2TgYJ16imMQfXE4OSUYMaHOJOYI1t4OYLeN38U4tIdUGI7Mcz/J9Fql8iuTN/UW2gbvhrDz9hPcEKjVpEfv5j6sWJYP1hGVg6EXN3K56xRvbajnxMQ2e92vVtk0Ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1i2G6qqhTzX9r7ZkFufqbC5G5mw3Hnj8aE3JrpSBEnw=;
 b=ccBAcJdckLeRTMkUqQbRq+wCsXxYgLlOHGunkQxzhVNSoo6EuAk9tIbtwTaREjkZIlAcfeYH4ym7OacclLMDgBEKTG/OZlkdG/wsmzumiCh2nOWTFJLYuwAGuMVYWHstV88btVtyFb9Ns2ReU1pmQ+33TxKHud/mlyv5cbOcU+2HCxYHsOllR6J0IJEe9mqwJgtE8ia3c+B6IRXc1LFRC/zAL+60tkNMU5c32sKiI0gJ/+1dpW2rLz6VF7jVRAPQTFurPh6AOVD9GFoWneNioLJ4pllBTLfxITxZJ2RPpXD+PKMKOZB02xzllG6Npw7x1bMa5TkC8XDYE0Y664/cPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1i2G6qqhTzX9r7ZkFufqbC5G5mw3Hnj8aE3JrpSBEnw=;
 b=CDD/GmokOZGmQ4auFD/QUHQ9XZg3urhB3sfYgcN8u0cUAq4N6Vu1A4op2adE1p9RMTAVAqSyGQm0Y/TZoKZcX7RMb1uU34rHRvjP6SbnW4xjqRAHKNHmvXmZdC8jVH6fkf9eEdGK6+uo1hMUIZ2MoDX4+CutE4rQHC2BSyPoqXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by AM8PR04MB7316.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 14:58:47 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30%4]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 14:58:47 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] doc: Add initial MediaAssistant rst
Date: Wed,  3 Jul 2024 17:58:39 +0300
Message-Id: <20240703145839.34828-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703145839.34828-1-iulia.tanasescu@nxp.com>
References: <20240703145839.34828-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0019.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::9) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|AM8PR04MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d0d1dd-7594-499d-05e3-08dc9b70a443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ICBZgHLVE6y7YLK/9cBniBLCpYvYw45ugZu0FQQk1vdcjfaJ8juH2MRgXAIM?=
 =?us-ascii?Q?dREKd39B+dAEJ/sI45NWn6c6dlsi9qapYA/jxiI+H767eELESdYTppMfDCZ7?=
 =?us-ascii?Q?z0KuukxJtvm8eBK1+74i7H+fZQOMydHx9KyVifrnX4baMOqqxC3trw0V8ERk?=
 =?us-ascii?Q?gzUp9dEFneKroPbX+wsYv2NmzvB7yiq5554Q+G9hFa5HKEYmTw56pUCOSE1S?=
 =?us-ascii?Q?6gsq715nBODFQJAg4ugoZLolE84iho64oPJzX9OnEfPi2sjRdvAn1VSOw6lA?=
 =?us-ascii?Q?ZH3QM8vPqyUDmUvQzDNlkcABo9UqzTdgpcHygVJFCyjYcKbNS+0CHGqj6z71?=
 =?us-ascii?Q?zpF+8SQtc75JFD1rfrjVL+4aDe7NF8qwFWBQxkOxcNJ5rBMYzdLhWNqDNb7b?=
 =?us-ascii?Q?skEXo3fr+8uj/akkAd5OHCGRX/rErKumZx0V+5k7CGT51ki1HD13fkSxxdzW?=
 =?us-ascii?Q?keSDaUIH+F/CIRgPFLFo1QzJX2kEMtSasaNonza1NtOnmLGtKJ9HUKAGNJNg?=
 =?us-ascii?Q?X/yp45qGnOFghQpPsOwTNYKFtE2uIUKAgwEPsAwAX2Xl55tJEK+xuEqD2v1B?=
 =?us-ascii?Q?LOpgYJgeyKirDyTvt+J0RnKvflFW6sfu3M10EdhpH2V2m9Wx4k7lnnswfFfD?=
 =?us-ascii?Q?muFjYMO8naGh2/ro+TPzc3MEF9yyR/Zjb8Xh3BwTyZa2Iqs7uVm3mZYSj5T7?=
 =?us-ascii?Q?fWMNxyTuW6hOS4e3JCMP+U4LZjremkvUmNp5pIRjjlZ3hyQjPcFWiSyIuR7Z?=
 =?us-ascii?Q?egLIgSBjkwfzJ7y+y8dqrp6rBzI9rxhY2wuMk/e+gTxi3xHXtU2lSyBlQW6g?=
 =?us-ascii?Q?dICHfLjI8YkZCQMPdybx18mtLqA0MmRd6au2NpIgXzaP2lUPoGHeggiCv7XZ?=
 =?us-ascii?Q?GmDRS+1dD4K8ii6APt5JBtrirX+M0RuJIQAlFuoheIM/L3Neagj0Inip/Pg3?=
 =?us-ascii?Q?PWU8irQsAmpuoOCHsstG8pWtUcFWcxyymi0vxk5Bm1tWvz9nEN+C1Fn0KFvs?=
 =?us-ascii?Q?vF83zK1VxZmZw1QJDlqegIp6jfombZXE2nwy9jsGyfT2WFp7VvY+VABwNug1?=
 =?us-ascii?Q?3KWJGy8Abm/AKaboFhg2tMzg88dbszKFFKmLQfBlcHCwx5NyH7hvF4LL+wWh?=
 =?us-ascii?Q?RoifXGe0rfBb8W6JASo/qjJzxuuJj+iUNMorb2OMuYd9GOqHJYqKNMV+PhIA?=
 =?us-ascii?Q?0g6gKuwQEvHm5Nzwpiuk9eXJCVwSfSA/AIqo6NibdX6Oy+VPkt6v6w0YH97z?=
 =?us-ascii?Q?I0kDt3ii1ARE9nG/ioH/yT+Q/wv+0zhAa4JVTcsYs4jofTnZ1dFGfo9IyqbK?=
 =?us-ascii?Q?6/RW+G7TZ4i3xtXR1KcboAOlb4kDI+M40urC5Cu7V4nb2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?81rCDDJWcc8OYR4YoTNZFsl0FH4Ktx+MGb2kYcGw77P7s589ft67VNdBAGgK?=
 =?us-ascii?Q?Lgq3CauGKUv1t7shu0R1UozNz7hIn7UeEV6dLkCQrFaL4nHigTeadKFlKwLj?=
 =?us-ascii?Q?z7SWBEMNYx4Zw28+64eGGoA9ngt1RVY/Rwhym0HQzkgQ+w/aK8IiAx8Fwng/?=
 =?us-ascii?Q?/51cPBWijs48MdSoBb0z+AalFLapg5A9h7fFqtPTlkB6u4rKZ9aGtzRXxjdq?=
 =?us-ascii?Q?eVVDX0Lwg+Ib0A06KiVFr3IFLgGfTiyLTp5j2VrI3PfvHbLfwFHqnuCAwMxD?=
 =?us-ascii?Q?IrhX4Uwoi69hX5ebnRgcJR/quUN5pmcYBgoV2nzRUAv8iGVvMzbywp+xRpNy?=
 =?us-ascii?Q?yXIWMBK1c1VZb7jKDb3JowQ60YKdbuP/RRhEVlkcJaTCDrf7veTN1tsb0nbd?=
 =?us-ascii?Q?MYR04f9yL3yQVfykR4J1Ksfeoie7S8mKYi03r89e4ONUriYrRg0uBjAWyJtK?=
 =?us-ascii?Q?e6uYvtL0O6MBrHHZYqQzJFHfCh0JPP8qy8j2Yy0HE8UOFEmw+hNZBtCtdiJ3?=
 =?us-ascii?Q?0t60+YTkRy3hkk4UbJrgmbFdcjHwwUeorUf9HXxea9kOx6RlO54gQGXFWt3/?=
 =?us-ascii?Q?mf1Efq68Aj513F9VgHHsf6EEI65hs/AfHDkuiuC5VFVrt3CowRT7XaODvs69?=
 =?us-ascii?Q?/24z6ki2TgIV8X+xs0Zq7HdiUXVN/AslmQcMGuuNUEnhAtTWgOEQOkMK4aK2?=
 =?us-ascii?Q?4s0qNqmkNutciFbWAZCUilk4a+ZWEC/W5pcJ2WjpM9wcwD0/F7x9iQAK10n+?=
 =?us-ascii?Q?E/weLjUk6VolRrRL3srtdmznXdpUjtr0G30o5akFPrhdxf9KJ48ebJ+ZwgBg?=
 =?us-ascii?Q?zqj/C5Ta8/AC0B7zutAbaemJQIhLQ2CqRPApWoRZoeOQyD3WpnyWlOwvTg4d?=
 =?us-ascii?Q?HYu4BfrndIDhtV8CvEIRJwOQV9bFGPbN0knjb2ZwHli4Qz+eqtwJYYvpxAqL?=
 =?us-ascii?Q?bUR4xcaZ6dC0wFycMeq3AnWDBKC4gMcKqipa7MqB9BQOZieSNNwSdM0oKyzc?=
 =?us-ascii?Q?otb2q+dl+S+oafA9EcNrk6Z+98A2oVjoILvdvW9kanj+9rAzNCJEAKGjdzUL?=
 =?us-ascii?Q?UoWYfi6oyu6suZDYubFt7UHk5hGEkbtF1uIOIYbNGGPiMwGE21If6/duiItG?=
 =?us-ascii?Q?nEvxeSM36+qxECtg7m0SPaTp+3+QY8engKBHt6lBLZwTgtWkYpHaRTjsEpLI?=
 =?us-ascii?Q?IfZeR+qGO2NIHf5njDZsAy5uB+VNjWq41juljtMU8c29Pn5SPqPb3sBWPbam?=
 =?us-ascii?Q?JvJ+RrSyypKSbDZchCfwxt8kyplbLBE/89Q4oiKBwEqTTZjmylY7WgSS+NTa?=
 =?us-ascii?Q?lEv7hOnDEan925sfF8E9A2I8OgI/7IeCkchxZTPTQ7ejqTvotmRf49Sr9MpK?=
 =?us-ascii?Q?2op302SG1kGQ+piDzFM/K+s1C1Ntcsw+eFmMLdh337sNveIFIyPjQa7cT0wk?=
 =?us-ascii?Q?zJDGhapv5LgW82VovtQXs/daodOmB7jfI6eWutwPaxKun3dgBxbDuyYB8d2S?=
 =?us-ascii?Q?WlRKgVFFaJFeFl76vRwQXlp0+hdhyW61p4KdtZa5WKukAM3CV7Ox39qiRZlD?=
 =?us-ascii?Q?YuON/q1HTW6shOUFjXrv2V7jxGqCFi2R5NuX5m9eGXkSlWP+y1Mvkd/Kj0TS?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d0d1dd-7594-499d-05e3-08dc9b70a443
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:58:47.7047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnPxxz+PLpq4ZIgsPMWzhz7Xb2wCgo3mCf3N79A6HvXwmkp4YoU4qs73As7HqOZOSDkrwbABgCrBJF1zPcq/HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7316

This adds initial documentation for the MediaAssistant D-Bus API, to
be used by a Broadcast Assistant application to interract with the
BlueZ implementation (BASS Client).
---
 Makefile.am                      |  6 +--
 doc/org.bluez.MediaAssistant.rst | 74 ++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.MediaAssistant.rst

diff --git a/Makefile.am b/Makefile.am
index 0ae721111..46a8cfb49 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -362,7 +362,7 @@ man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
-		doc/org.bluez.MediaTransport.5
+		doc/org.bluez.MediaTransport.5 doc/org.bluez.MediaAssistant.5
 man_MANS += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
 		doc/org.bluez.GattService.5 \
 		doc/org.bluez.GattCharacteristic.5 \
@@ -395,7 +395,7 @@ manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
-		doc/org.bluez.MediaTransport.5
+		doc/org.bluez.MediaTransport.5 doc/org.bluez.MediaAssistant.5
 manual_pages += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
 		doc/org.bluez.GattService.5 \
 		doc/org.bluez.GattCharacteristic.5 \
@@ -475,7 +475,7 @@ EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
 		doc/org.bluez.MediaItem.rst doc/org.bluez.MediaEndpoint.rst \
-		doc/org.bluez.MediaTransport.rst
+		doc/org.bluez.MediaTransport.rst doc/org.bluez.MediaAssistant.rst
 
 EXTRA_DIST += doc/org.bluez.GattManager.rst doc/org.bluez.GattProfile.rst\
 		doc/org.bluez.GattService.rst \
diff --git a/doc/org.bluez.MediaAssistant.rst b/doc/org.bluez.MediaAssistant.rst
new file mode 100644
index 000000000..4aac89536
--- /dev/null
+++ b/doc/org.bluez.MediaAssistant.rst
@@ -0,0 +1,74 @@
+========================
+org.bluez.MediaAssistant
+========================
+
+--------------------------------------------
+BlueZ D-Bus MediaAssistant API documentation
+--------------------------------------------
+
+:Version: BlueZ
+:Date: June 2024
+:Manual section: 5
+:Manual group: Linux System Administration
+
+Interface
+=========
+
+:Service:	org.bluez
+:Interface:	org.bluez.MediaAssistant1
+:Object path:	/org/bluez/{hci0,hci1,...}/src_XX_XX_XX_XX_XX_XX/dev_YY_YY_YY_YY_YY_YY/bisZ
+
+Methods
+-------
+
+void Push(dict properties)
+````````````````````````````````````````````````````````
+
+	Send stream information to the remote device.
+
+	:dict properties:
+
+	Indicate stream properties that will be sent to the peer.
+
+	Values:
+
+		:array{byte} Metadata [ISO only]:
+
+			See Metadata property.
+
+		:dict QoS [ISO only]:
+
+			See QoS property.
+
+Properties
+----------
+
+string State [readonly]
+```````````````````````
+
+	Indicates the state of the assistant object. Possible values are:
+
+	:"idle": assistant object was created for the stream
+	:"pending": assistant object was pushed (stream information was sent to the peer)
+	:"requesting": remote device requires Broadcast_Code
+	:"active": remote device started receiving stream
+
+array{byte} Metadata [readwrite, ISO Only, experimental]
+````````````````````````````````````````````````````````
+
+	Indicates stream Metadata.
+
+dict QoS [readwrite, ISO only, experimental]
+`````````````````````````````````````````````````````
+
+	Indicates stream QoS capabilities.
+
+	Values:
+
+	:byte Encryption:
+
+		Indicates whether the stream is encrypted.
+
+	:array{byte} BCode
+
+		Indicates Broadcast_Code to decrypt stream.
-- 
2.39.2

