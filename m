Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4CC16A93C
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844321; cv=fail; b=Ndpb8bAy6o0Yt83U1dO1eXqHSHlBHpVZbnEBTap7lcYH1scjrFThgNBCS6c1tKpMcac/RMdEArgEyDLioY0dTFpDMMTv7ATIuPqgVLTujjuJXm3xYKKg72cHc6Bft/dBSfgLGqX0Z+34+FcWkmATAbdbgZ2GGiZco/zvwq2O3t4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844321; c=relaxed/simple;
	bh=WEAYipiyBJsOP1w2eFPTYgonQ1zSHhCPUhJn8J+F+8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRRjnwD4I0HECSQUDD2PH/Oywon/FDkzSrzH3uCczvZYwFgfw8iFlGtewJwTXBH1kP69SeJHf/GgEU78HcVwSJVOmCBJVUUK4/J7+TJtc+sQaEXtaav0jO8eFwX+jTKiqOx1UpeIDoxTfLLC2ySdfw5DvQuKGUR3MvyDjzK3Whw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OxpdCh7c; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OxpdCh7c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1b7oSB9Oezord7Q8PfBOaZmMO1N3Z/14cKVVEilfA3xO6LP/CQkVfuvkcLCVwarWdxwkQaLvPFeSJmqDPq7uWtkuMau4yf5/V1sgguvvXAj+6HyBczCzMjK6v4YRX5Y45AqgppfkCosNXYMPwaEkH4evClq4zDT/Mo9I+Syq5dT2IHeGPJwGt3sfHRu8Bip+PYwcI4SGVlfxe90aYd4/xtggJVjeV0uxusoltL6lM/fiMOop+1XPQfCWUQFE9Wk0BNy9+XJj1+UEC8l16ZNNbX627zg8BUu81anrFKctvu/pSz3VQOOqkCTF+OY3UyLy+tTbOMhaB5cfSLf4TxgsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxDzM3wy1g40MoKj0JL44dnCOUEJlWVnaV5g7enIFUU=;
 b=mUkA5adG6Cg9ZGHFAcn/oocElcvIQS9fqIBvpYl/I8YLNFQMVNtt+qNiHDl/wefyA0h6bCwIhgL6b4o3LorosnYKQv7pEJxjiP0SsrABOmLI0WrzS56B4mdaVLZyHqbmt5d3NZODG1rotNw4FDnXfZ0ybzioBggCxv9IqUtGx0JeCZJjvfhYlYwWTv2xAzcf5ToP+wzVhy7keTpGizPOkxNXnsKKXiEES4O2FEwZJYCa6MN93i1PBGIA9g6Bq7CDsVOlkkvhlmOIzxM4Ykf/Bs1n+A0YFEff20OvFavcinny3uMmhzMqYSOQ69z+PkMGxmMHNFCN2DpJAJjSUAtbuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxDzM3wy1g40MoKj0JL44dnCOUEJlWVnaV5g7enIFUU=;
 b=OxpdCh7cxkLdjw3gfMdxxLKNhwG6nVdqPRanFfvb+d/i6wa2H24qubyVI54gLsoOnL5exux7WSy4h2c66KuqK6seCzb3adUKgfpbi+YtPrY0NUBRSl5g6PEorOFXwb4+E+sWnpXzrWDYU3MlWPoI46cCPEsSSue0e8h7PGmVuiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8947.eurprd04.prod.outlook.com (2603:10a6:20b:42e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 14:31:57 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 14:31:57 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] doc: Add initial MediaAssistant rst
Date: Mon,  1 Jul 2024 17:31:35 +0300
Message-Id: <20240701143135.45677-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701143135.45677-1-iulia.tanasescu@nxp.com>
References: <20240701143135.45677-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f0f98e-044c-4ea5-3cfc-08dc99da8fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8LEj9BPEFJgTo09nrPYVtFQ2ClIOpqlfZfa4o/7uPbsImiS3uGuaGiYMjeon?=
 =?us-ascii?Q?k+qL6UG7s3Yi3ofjk3kxEdkLXiEBC+OwNqt3HiPsvNK92grgqzdE5CUktU2k?=
 =?us-ascii?Q?kvQzXe58H8Yeh1dToXDr67gB0aE0p3suKTmQnR0Cl2YyTJoI5uSP1VQMMePI?=
 =?us-ascii?Q?w10ACvhsuTCWG1w1dFns0msdimydwxWt6KyzMkNrIUpQ7aEC+HFndmqh5IQN?=
 =?us-ascii?Q?7b0z3/cJLaEFpQdp23q9XTXhkEmcDxOg/CgHftfgNIiCSOjiD6ahO/I0uROF?=
 =?us-ascii?Q?spCB5D7sK3h9tOo+Evb538R+5igJOQMh/ODVg5ca2GKKYxb4FtiXrQMPy9qX?=
 =?us-ascii?Q?ghNSmb+sZAGjp6WLVAZqSaR/fWyomfft3i8r/7q7ge5m6R+2D6cOSToD1pr/?=
 =?us-ascii?Q?BF+p/VhQBBt2wUR4kCw9fX22uD4sIh8CH8q+2xJAgRA5hqJ7BbOrB5jxkEfP?=
 =?us-ascii?Q?HJEX461rNUjFePxRfomeWXDIkCXv8j+NDQ3cw19wWbPioMqK1dYbSr3+7hk5?=
 =?us-ascii?Q?DfdVmBGxVxHn4DIIjjVYuuhYn4VDpVJL+UO81ZhmFL30U7KSHj5T2iKc4s9j?=
 =?us-ascii?Q?AT+t/Uy/BEzf0YyJ83/jz1m+gwUz/LryV6YZ3+t9OJ+iiift25BOevrfkgVO?=
 =?us-ascii?Q?E4QVQ4Lqcu1zHhGkKI7Ynbuj+kzM3STr5Ij6hgRxuTQoTd+haMTKvT0rqu5d?=
 =?us-ascii?Q?eOpR7jRUo3MDkcTaPxmS90isiR1O2s/npJkLdVdTROakvFIOMqjHcjmoBaPw?=
 =?us-ascii?Q?hdlCnvIA4DNZ34dAnK1MHUjhn9lOIg3LAJfn+NZKrbPc17CXDF6z6rwmr2Wp?=
 =?us-ascii?Q?vxIgqS9LvBD/8OnV78GSE/lMFdoR3R+XpXUWBZOnVkJsuvJtXKt07d+Zgl+T?=
 =?us-ascii?Q?1jdByODLC66XgAzimB7/mNbJvcIlgg1U7u2ZH3vUQ/DE2AeJlnjoxtyevaOH?=
 =?us-ascii?Q?wQgIngIxn8Poy8SOt1Ru1pzFyc5n9BKUQ71k+YKNmaHFlmOvtWZsjr8yUeAf?=
 =?us-ascii?Q?AZjnYwJfPtNo0RJjCdqfGWXY4HG0P9JiaGuuxW5+Z5olN/DNO8FbM1qDLTAN?=
 =?us-ascii?Q?RzvOEdnaCyhzMLlR0XjyvBiNNKEY8Gpu8wnPOrbCPI1BRT/ruquYF1l92wsA?=
 =?us-ascii?Q?l25NtsifiinIY6vUYqNTSTdNdfJ1f7aoXmQPEqge/ZmwoHa+QbmES6AzRetz?=
 =?us-ascii?Q?/dY+9UfXdX5VQZ3lZZVl1Sz+B8ByleP1ufFH26Nlj9sZq3Wb3kEn9q0lp5eg?=
 =?us-ascii?Q?/hnu89BoCmyxEcb/3QT405myBzhORfl1Ms+ryqfxJg19Ammgu6gnAOLgtgfS?=
 =?us-ascii?Q?yjG/gDtfdbCpkocFyNh1j/tyw7Q+N6A16ezUUxg7zsnQFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B0ERzq0aRJy28cLuz49JnduHpe95EUNnhQ+ilPdiIYI/4PmIWePSDXuoD1Vs?=
 =?us-ascii?Q?4pnDQ/qbQzczI48sF0IN2ZkbffuiobtvoL8M7BVT1m2GN81K3QQ/beYAtxEb?=
 =?us-ascii?Q?2BIFxq37Z7ptFNUl1GBIBtV+/8w+N92G0aMbrqjQIvVCkfGro0dhqe8Vl8VH?=
 =?us-ascii?Q?fSaR28bS6ZmZ2eYfItXUCzmz3LaJuhipwHEeAXtLc8ai145o//Y1DtKCbluh?=
 =?us-ascii?Q?R/Np8DWRsCOuGFHuVmaulURD1726lyICBNqA6iREzvKYHy2s1FON/ak4Xh5o?=
 =?us-ascii?Q?pR1U1o1b+NxLwzl/Lke+dOic2FrPbURbOjQlD61XHCJL1+5867+drv4w3V9I?=
 =?us-ascii?Q?pL7blU7BMbNA5UH0I+BTFINlcuQouph55DrUsNwr3pxcV0UTZMi6ZXrn6nzK?=
 =?us-ascii?Q?pqQGWjodAq8SRbTG4Xhex9sP4C0txfshyPnjy6eTtpxgqxsHyBhGvY3Pua9f?=
 =?us-ascii?Q?R9FMfROcj6cH0vmlXG0LJpQjWgfROTMKroAp4XltjhPwLkNj23GiVJasqR+j?=
 =?us-ascii?Q?DnDXbzN8xMV+rkfCyP+lcUjNc4Kik06tyx3/DG05fqaMpaJ/zs3eFAU17Iic?=
 =?us-ascii?Q?d0sbCNGGtSHpbiPtHPe0DBgGX7kiiFD3xg3qjceVrmDoYM3h9ouXIPrELPGp?=
 =?us-ascii?Q?zwHTHnjR/fawoOwKiyBuyIx5e5dC7F1Vu3rWrrGX5NWm1KdbHGY/s7y+ZDkr?=
 =?us-ascii?Q?0z68+54fX6fxSPfFOFog8oQPV5Xhqa+C9Evxlu/4ODx7MKhFfNVi7ed0ytNK?=
 =?us-ascii?Q?l+sRHD3iNAdGDEQak7iJzDYaAmqEH7if3G7aCQ0gTDuj1Kyj4KW3mHs3SHCc?=
 =?us-ascii?Q?bV5lN4O3tyFdAkNreO/EV7YUeii0UfOPoKsnO1zVoCUnz4ofHlCSqTsBX3bC?=
 =?us-ascii?Q?WqYTJLZ8mMpbOyj2GIR38cSdQQWZuh3fWN95Rl6/iX2+ROV2TEzrDBXntFUR?=
 =?us-ascii?Q?56w2ofjhpeLnC1fhY3R8iscbK/sSBbrMSw123adFJ1MJM6XzTFFOwrWd2u5U?=
 =?us-ascii?Q?FkhGlTqst6hRzXNPOgPTae5FmZZKydyznTWUD/SrLoHHGutLuOUxCf1DEA+n?=
 =?us-ascii?Q?pbBoKNUy5sb3wc0kZUkTHan09LhNVklWN6Spn31j8X7+n8XG4FdYdUGjbnCi?=
 =?us-ascii?Q?2Q0CDcv6clHDnjgvXUi3+EiOLXNoi2qIepH7ocwZ/HjZuufJsvBSu1rdOO0+?=
 =?us-ascii?Q?YYjfq4yBuM/nMIdy5lpbqv25qeXWoL1QYV5qAYwbxMDdBMjJzIa4j44G0m3k?=
 =?us-ascii?Q?Io6lwy3fn7ya7gYNxF5FZDGEDubnokxhU00uclPBEaCTXWR7wPl32AGsEgQM?=
 =?us-ascii?Q?nczHXnzYVYOKTiEoEuEl7xSfLGr1NFnXXFKGYz5bLZ3cr04tuevWaqQz28BO?=
 =?us-ascii?Q?exoEmmyADx4tbCEwL/qat5W7oS5szbskJj6H4NaEUQL1rh5PfkrAFjfX7bmB?=
 =?us-ascii?Q?nk41n/8lPYzPGWLeIiNorzff9aPvu4dSHuFBGcEp9K2Pxl+6wA5mUTImWroH?=
 =?us-ascii?Q?2F4uNXxm5EXQt9NsHSOdwFMVzeZZ90rnVJZAgsOC9V7QP6OE8fJo+fhLOXnD?=
 =?us-ascii?Q?/PFuG1ggmPPDCfkJM1J9VCxqax1wPOBdCnxbJqao42oL4GDeiodBTpNrTMlp?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f0f98e-044c-4ea5-3cfc-08dc99da8fa0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 14:31:57.2749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMiyeELe1RhQ9YTDft/tLsbua6i4pruDD2P5WNuc2Y/dsOuSdaoi+W8JrwWXmPsQmYhgCuUN0tgTFNw6oFWu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8947

This adds initial documentation for the MediaAssistant D-Bus API, to
be used by a Broadcast Assistant application to interract with the
BlueZ implementation (BASS Client).
---
 Makefile.am                      |  6 +-
 doc/org.bluez.MediaAssistant.rst | 97 ++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 3 deletions(-)
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
index 000000000..a6fdef393
--- /dev/null
+++ b/doc/org.bluez.MediaAssistant.rst
@@ -0,0 +1,97 @@
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
+void Push(array{byte} Broadcast_Code)
+````````````````````````````````````````````````````````
+
+	Send stream information to the remote device. If the stream
+	is unencrypted, the Broadcast_Code is set to 0. Otherwise,
+	it contains the key to decrypt the stream.
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
+dict QoS [readonly, ISO only, experimental]
+`````````````````````````````````````````````````````
+
+	Indicates QoS capabilities.
+
+	Values:
+
+	:byte BIG:
+
+		Indicates BIG id.
+
+	:byte Encryption:
+
+		Indicates whether the stream is encrypted.
+
+	:array{byte} BCode
+
+		Indicates Broadcast_Code to decrypt stream.
+
+	:byte Options:
+
+		Indicates configured broadcast options.
+
+	:uint16 Skip:
+
+		Indicates configured broadcast skip.
+
+	:byte SyncTimeout:
+
+		Indicates configured broadcast sync timeout.
+
+	:byte SyncType:
+
+		Indicates configured broadcast sync CTE type.
+
+	:byte MSE:
+
+		Indicates configured broadcast MSE.
+
+	:uint16 Timeout:
+
+		Indicates configured broadcast timeout.
+
+	:uint32 Interval:
+
+		Indicates configured ISO interval (us).
+
+	:uint16 Latency:
+
+		Indicates configured transport latency (ms).
+
+	:uint16 SDU:
+
+		Indicates configured maximum SDU.
\ No newline at end of file
-- 
2.39.2

