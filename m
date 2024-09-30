Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2443B1922F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 14:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708333; cv=fail; b=NViL3f5FpJ4FfucKzlGSl0lxk8pUqrFu4hC0hQydgh/BAjJrD9fjIOCe3djFblULI1DDzaGbUuKI7lQYmMBDjwLWwuWu/g9Stfw96+BpjUxGfGPAu8lVUJ/GB6uuuQqX7GtBzmH9YZV/DFMrKez8WI3wU68gAYlGAKfj7RKYMgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708333; c=relaxed/simple;
	bh=xfqEv2Y5oebWIGJB9jm4QNCDr6+2FlxhOWHM2kztPXU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l9Uhut8452Pt/InQySo4M/OobFqT0sSzbofGJVOYgcVjOSOcZezGsypQD3l8PZS1R3eGrADfrJhTS/Up6NQNk6QBp2Dj2v4KWqqiBAjwdAZWFcgTUPRfPYP3tNq3FFNRY3MaY9bz5p93jVCbCO1ypNBLm/tLTKimN5iEbB79tiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gimai+5c; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gimai+5c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZtNTUnhGkvh+yCPHdEjejfhahw+jCVCsTa/WP3jjk6r0BR1ABeso+MgpAXDogxAS4AOe/Z6CLwmx67gFA6omaR1RPEGuaCl0sRHRDGe8CZcJuOE/UtI1sCIrrZlKJBy8uM9+f6JJy43beZsUzxyPt5hskaVARyN04Ltt2EKbJ8O4xmxroy5wKez8MXKRZ8JwYfjIrLx943yTMj21F14cY57oyyw9NcFO6FPiAR7TW4IE0saOAvrsQPHQ5eZbAEnILw1VG0Agd5NPwFs6ucMgF/d7at2M/3N3h8TtGbcBw7qxzyp4ApMDhAXcN8ceOgWnEdLsMcQ/9Bhxen0dimY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIfe7bJA9RY2EVOaURgbjpJX9Qc8t6nPMoeV/F0SI7M=;
 b=wea3t+HKWybDXIpCw7E0kPtjvxXU3CdLamsDaQ0zunp42ct8pwwhnHAeWmX9zpmxiZFqNvgs8TzobGhQDQe/Ewr7equAEljZ3em1q5+X7kFb7RkrvOgCRo56wRsgEOSVWwpLzBU2fwGGeBulBU/Uas2pqned/ac3miiMSuxCB+BnqVv/n+cf0YT9OTnf7nI2fW2Ia/7tTAgOnUiizzZZcULQifktZmiu2UTJKnjjpXjBIIRUK+sPJ7Jjr98KjXvSBSh0/d1Hd67uYD36eW1Yf71rq/7/+M1CAN8bwMIaOh073UERmlazY2vHMKDy9T0+cpTH6L/4yXzbgIgKqTOY/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIfe7bJA9RY2EVOaURgbjpJX9Qc8t6nPMoeV/F0SI7M=;
 b=gimai+5ckAnGAaCa6Vrt2F9hHSXjefrQc7zhX2mCxhZAqWUCDYAnpmiWpcAax+7ub35mpmVs7Hq9Ao68sWW2eiMls4VWDtPds87poHgAGPDjhR4vTOkWA477rvkzmD5QoIS316t/wmL9WmujQcBn9rgvh6kVr2wEb8KlsdHOp1yqufCQCQT/6TPbi9QMesbPdNLNTaKYgeBMBTt81+DoX6geP9hsgtdfO/QBdBv9k3gdzT0BQ1CIWpW7RjBAo1FCTnTI6AozquyvT6o7SuuQdkPmqDdoU5YEf54cMP7Y3TSD22DfM4KIOaiJhFhVDFSt5WJLb5myptaeo+0y1JZNCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AM8PR04MB7364.eurprd04.prod.outlook.com (2603:10a6:20b:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Mon, 30 Sep
 2024 14:58:47 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 14:58:47 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	nxf92481 <vlad.pruteanu@nxp.com>
Subject: [PATCH 1/1] client: Update endpoint and trasport doc
Date: Mon, 30 Sep 2024 17:58:30 +0300
Message-Id: <20240930145830.864663-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::7) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AM8PR04MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 868339f8-d777-4545-a76e-08dce16062b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8dLYTX4vnhU8qC9oYk8aDspxoCghcPLDU4sIsgFkTTl0OpcIjvvywkoQJVzS?=
 =?us-ascii?Q?ykRJdtKkn5J8SB9x0jPvqG8IP1QxCF7yLjMZDkoibBUvnt4/p/YUKXxsveTD?=
 =?us-ascii?Q?XBxIvDkH1yQaMJZBlw0gf2+dZX4Lulk89fGW1bwQhJmCOvCiye1X9nreFnEo?=
 =?us-ascii?Q?RqtlniaYguuFZdceTCcaH0ZKR8+9S3Y5hI6Gwx3xFEzOg7fZRknCRNs7d+4B?=
 =?us-ascii?Q?QwnHi3hGb2STLHettiOPUnjMHYJiCnzNhnd7NyDR85rfjEKOHS7jB2JpWnGg?=
 =?us-ascii?Q?e05/TYwuuHWt307w5tI9nM+WV+ETBQPJwXE5sjfORiksipibs7rbNo/LMxtA?=
 =?us-ascii?Q?8CtAJVR3Lz706vf0ExhEstg/Dk5nByFS56wKsGzcoNnni6lm/rZ5VLywCc8I?=
 =?us-ascii?Q?YsMs+NgZe9uL5CG2zP4GYaZ8tWfuBwcJxbHtUkRTBiD/k6+xvBMdPBydaSVv?=
 =?us-ascii?Q?xi/EhZVqhtC8/VZ+Es35mWsDuWGGpZGcEedYbK0mBGlWeuTmJ2/WM4GFRgnr?=
 =?us-ascii?Q?XuIgH0r+Cfu+IwFRWmfstXVpW7qe5aR9P9TvUcWfqtFhnUAWgKwus+ZNNRTx?=
 =?us-ascii?Q?Mwyk6swskaPAg9REZ9vhE24tMrGrxszhof5ABUwitXHg6zJ+eMU1AUfixhf7?=
 =?us-ascii?Q?69BQUY/SQOW5YZWoOzYEF3T9AtEElYzKJzbYEbzC7WvXvwemVlOZ3IcFvAzN?=
 =?us-ascii?Q?dgBMrLVzT7rMvAK9VR+DETTot5c/xVMaq5uF5ROIFNdUrfTDXO1P6qggbXzZ?=
 =?us-ascii?Q?1+ZYcmsrR3yjt/3KAaddeuM8kfpQkxsx2JBb0v+dhClqXftbl7z6ghGx1mTp?=
 =?us-ascii?Q?XHhejc3GqJrtfH86p+E9b+yPP//ne4OA1gsJKlPqjFkWH/aXpZVxKh1uW5m9?=
 =?us-ascii?Q?qMq5jYtKf2CGYwvtwE+/oyzWSkjM1SwdlmgUX2iVg9aH0k9dul5IQmXes1Tv?=
 =?us-ascii?Q?CRF9aw+x3D9bVeKVuGS9kaph6ZkjpHpurFGwIUgQILW7JddDWUajhhoGwBWV?=
 =?us-ascii?Q?nhTszTVpat9brSTKP73wuEhUDW2+lRgEY014efcwI3yamilhcT38R6yb9+rI?=
 =?us-ascii?Q?cEha7Frk6hQAPPEP9LlhMauIrJdfLp1Bd4XAww/FRvYuUOKIn1BeRcI1UrFY?=
 =?us-ascii?Q?b4vvs5Yj4NrDXgGt1AW+Wd4omjtaghRf05V0w4ATpj7kw9t3AsN6ZROF2c/d?=
 =?us-ascii?Q?I5dumpaQqv0NeGOyTdVQA0LKEjMy95OPTCI9+7McUqmPcIYNV6W/vyBWQOnK?=
 =?us-ascii?Q?PZIV7S7jomvlALCyXBeWI5lSEniPk12TXvkO7uyLe7RPFcvoM8zlyhTe8xEw?=
 =?us-ascii?Q?0YWldrngeZUU8OPrf7bVrFHvGaqdgkXAnIsK1Mp08s58EeB9Y8PdpvfHyqTW?=
 =?us-ascii?Q?xD2PdPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GQraBuTeXLjtD2/5iTpUEdC3c+u3RAgcfw3Z+tHjojTMK2EDrNMxOMb81Lcs?=
 =?us-ascii?Q?YtkFoZEeGbGIZbR4BDsIHGqJn0gri9OTgwDxGYrcbyswEfhVbDhSD3RdC6VI?=
 =?us-ascii?Q?eYYcenmJ7BjumJgjtIsRhG/eYQQG5cmR2sF6BZ1YotXGxPBdNxPWd12Ph0W/?=
 =?us-ascii?Q?kwtx8AwRNI43RtiCWBI1pYU05FqQW2550vK5gHV0q7S6AmvkLLzFyOorF2kK?=
 =?us-ascii?Q?fRO2cipiBgiL6lsYtvqfahhDHRTak+dkjxff8Of6sDp6IT4p0tAd6O6ekhpi?=
 =?us-ascii?Q?A+dNAeZJBEQCxnjltNXx4ZEzApNOyXApYBV1e7CkVbXo7RIk1uy79WRR2kMy?=
 =?us-ascii?Q?mgW5cSvUtgnt0boaEgzEIUqhgxd9iJQIBsj29TJfm7vJzr14rQVB5TjDEpL0?=
 =?us-ascii?Q?cBhw138i7xvjxxTMeTPPYroWklvdaj4yTb0XglkKxA9smj0665Ek4r3lkA5s?=
 =?us-ascii?Q?c/ioZNL16wDT2DoOU2rfpchhidvEwEX6DoLfgusNliWnXwk1NPBb1oc5Fy2N?=
 =?us-ascii?Q?wvsrUSmE+pAKN/TbEeQ75PjrI8NeS3wvpkb4rg7phwW/Beh7hT/h3MoS6xRT?=
 =?us-ascii?Q?KlVv1FKTo2F4b7aqTwZVyGUBv8XkoCOjLrhrKkC6aac+1HM5lAXMmxkajALk?=
 =?us-ascii?Q?Lg0XXjzv4ZRVFqvUshZ+ZYICvhdwnTeB7uemmc923MeVeJryoJz8fMAqErER?=
 =?us-ascii?Q?1BC75Zs1CeS47gv2jfD/aaDoXid9d11j5VBZxjIk2k+pFVcn/lI831A/pNIk?=
 =?us-ascii?Q?kKt778v72LtI9F1jKWLLhQxsr+yJ5rAOr3w7PeWu7W5rKzCDS1eVYZpJXu+q?=
 =?us-ascii?Q?/Yb0DDApPrgz8zRx+VPgvt2v3eOV5i/1fPiKMeLihqm0JwsVakBdpcQxEFLr?=
 =?us-ascii?Q?+R/cEdn4zXAwpgmFyROayv633Lq+9zhxG1iz6IRfDlB3VlqS9GeaL0iLVFxZ?=
 =?us-ascii?Q?20XqZDUfNdqbx6y984JMlX0O3YFjRM3EVM3yTb4THin3Io7PhzW0RsBLIwwA?=
 =?us-ascii?Q?I50HIHFGUShtUzz4cZsaJXcGNKIgzWv+vDD/KLJ8PFNeIsBlYdUfBdzrNIEB?=
 =?us-ascii?Q?17RwFy4nxAgIk5yxLURJ1rU2vLvAh3GxSuXf4R/g7AipSXKH+WA/Yhohz5Wp?=
 =?us-ascii?Q?HFllWue+RmfcJSQi1KLPaR9tHEapIeTQ6pPhMe233F8/aq6n0lpzc373PMw9?=
 =?us-ascii?Q?Y0ltnRQs/Dorryd78p83w+8NAPYO0tUcMtXNCk21CIM5C9EeZJzn4IjLHPyW?=
 =?us-ascii?Q?IakIjqDJfwxzCOenN6LXW8EgXMr6fiDk6lh1ljxkcrwKRfNCo+XfSOdPKcTJ?=
 =?us-ascii?Q?r57Ts+46N5UqTiiSoZPhso/cay93yaEWnHl1LS/M2IbLyGs9lLUeUYwvJ6Eu?=
 =?us-ascii?Q?Hx7AHLA8py2X9M0Wcn2/N+SfFvLG0VfvLLTfN1YcHjwQ7tsdUdEV1M6w1jly?=
 =?us-ascii?Q?EWS24hrk5OxHh/EgA4MPR6BDHNU2Pt3U8pn8qVZcdg9K/KYItmG3JUMQm6bz?=
 =?us-ascii?Q?GcJpHPQMcZ4G4DL8bQ3drHPCazhIqPJff9HqsVLgPTzY1CqUinjrE9QejaLn?=
 =?us-ascii?Q?aHNYqT5n1X0whTMe25SqZz8UFOuRoJJ+w3ZYWMDg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 868339f8-d777-4545-a76e-08dce16062b6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 14:58:47.1350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUCvtLMHZaVl+e8Fhn9np36EY6vPEXQiC+l71jgarGrYDqOBuL1frmdH3tUjQeXAZmda7OzVHWtbiDkf+AK5zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7364

From: nxf92481 <vlad.pruteanu@nxp.com>

This updates the documentation for the use of endpoints and
transports according to the latest changes in their design.
---
 client/bluetoothctl-endpoint.rst  | 33 +++++++++++++++++++++++++++--
 client/bluetoothctl-transport.rst | 35 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/client/bluetoothctl-endpoint.rst b/client/bluetoothctl-endpoint.rst
index d7865486e..907dbde34 100644
--- a/client/bluetoothctl-endpoint.rst
+++ b/client/bluetoothctl-endpoint.rst
@@ -41,7 +41,7 @@ register
 Register Endpoint.
 
 :Usage: **# register <UUID> <codec[:company]> [capabilities...]**
-:Example LC3 source:
+:Example LC3 BAP source:
 	 | **#endpoint.register 00002bcb-0000-1000-8000-00805f9b34fb 0x06**
 	 | **#Auto Accept (yes/no):** y
 	 | **#Max Transports (auto/value):** a
@@ -50,7 +50,7 @@ Register Endpoint.
 	 | **#Context (value):** 3
 	 | **#CIG (auto/value):** a
 	 | **#CIS (auto/value):** a
-:Example LC3 since with extra capabilities:
+:Example LC3 BAP sink with extra capabilities:
 	 | **#endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06 "0x03 0xe5 0x03 0x00 0x02 0xe6 0x07"**
 	 | **#Enter Metadata (value/no):** n
 	 | **#Auto Accept (yes/no):** y
@@ -60,6 +60,25 @@ Register Endpoint.
 	 | **#Context (value):** 3
 	 | **#CIG (auto/value):** a
 	 | **#CIS (auto/value):** a
+:Example LC3 BAP Broadcast source:
+	 | **#endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06**
+	 | **#Auto Accept (yes/no):** y
+	 | **#Max Transports (auto/value):** a
+	 | **#Locations:** 3
+	 | **#Supported Context (value):** 1
+:Example LC3 BAP Broadcast sink:
+	 | **#endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06**
+	 | **#Auto Accept (yes/no):** y
+	 | **#Max Transports (auto/value):** a
+	 | **#Locations:** 3
+	 | **#Supported Context (value):** 1
+
+Note:
+
+If running the setup with an audio server that has LE Audio support (such as PipeWire) it will
+automatically register endpoints according to the configured roles. For more details
+about configuring a Broadcast Source with PipeWire check:
+https://gitlab.freedesktop.org/pipewire/pipewire/-/blob/master/doc/dox/config/pipewire-props.7.md
 
 unregister
 ----------
@@ -68,6 +87,11 @@ Unregister Endpoint.
 
 :Usage: **# unregister <UUID/object>**
 
+Note:
+
+If the endpoint was registered by an audio server, it can't be unregistered from bluetoothctl.
+This must be done by the audio server as well.
+
 config
 ------
 
@@ -75,6 +99,11 @@ Configure Endpoint.
 
 :Usage: **# config <endpoint> <local endpoint> [preset]**
 
+Note:
+
+If the endpoint was registered by an audio server, it can't be configured from bluetoothctl.
+This must be done by the audio server as well.
+
 presets
 -------
 
diff --git a/client/bluetoothctl-transport.rst b/client/bluetoothctl-transport.rst
index 21ba2f701..4151dd436 100644
--- a/client/bluetoothctl-transport.rst
+++ b/client/bluetoothctl-transport.rst
@@ -42,6 +42,37 @@ Acquire transport.
 
 :Usage: **# acquire <transport> [transport1...]**
 
+Note:
+
+If running the setup with an audio server that has LE Audio support (such as PipeWire) it will
+automatically acquire transports according to the configured roles.
+
+select
+-------
+
+Select transport. For transports created on a Broadcast Sink device only. This moves
+the transport to the "broadcasting" state, pending acquire.
+
+:Usage: **# select <transport> [transport1...]**
+
+Note:
+If running the setup with an audio server that has LE Audio support (such as PipeWire), it will
+prompt it to automatically acquire the transport.
+
+unselect
+--------
+
+Unelect transport. For transports created on a Broadcast Sink device only. This moves
+the transport to the "idle" state, pending release by the audio server. If the transport
+was acquired by bluetoothctl it can be released straight away, without having to be
+unselected.
+
+:Usage: **# unselect <transport> [transport1...]**
+
+Note:
+If running the setup with an audio server that has LE Audio support (such as PipeWire), it will
+prompt it to automatically release the transport.
+
 release
 -------
 
@@ -49,6 +80,10 @@ Release transport.
 
 :Usage: **# release <transport> [transport1...]**
 
+Note:
+
+Transports acquired by an audio server, can only be released by said audio server.
+
 send
 ----
 
-- 
2.37.1.windows.1

