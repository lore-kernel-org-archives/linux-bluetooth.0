Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2062.outbound.protection.outlook.com [40.107.7.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631B0824BB
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796934; cv=fail; b=j89rAPxLTnP09XHskCBT9E5Fs0e2YhzwsL3xYiu/MhEY8Rl4ltPVZ0bSu/6mW9a/s+nrhV+yQlx7jURb8hIHfJltMzS9Oocc/6kLpqDN9IkN45RszPBNGuw2aasJu0hPAF111TOUOAov/qMTvx7oWKlx5vRInwj3czYgi0+QnZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796934; c=relaxed/simple;
	bh=QoI+Tu4d/NR1R1kNRNNpg+FYRpBn0iP9/MkU784LtAg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kBdTSH7WX0l6G8kIkd4pKK6Z+Zxts+7IT15HyRvaOmgIlzb8xUW/4y6c12xbk8Y7haDgUbtOoF/0h4qXYFiyU6tFDYZC40ci2V2EtQkMNUHKQDpQU/IfufA1tkZNFcxfCUsCAxDeojCiMk28juCzbTTtrs/58pF8Pt5H3VbHJuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=r5Fm80bB; arc=fail smtp.client-ip=40.107.7.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r5Fm80bB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5Yowqpzicrjvi9i35Qk+dxXQQlOfYspYVkg1PsNhNd1vEQg5bH86B8/KuGAflcQDbYXlEtaO2RYK7mHF6S3rixfxQKstpGDvb7N8TnIoVeAgy20aDUoIaZ06VjdE6JpCa03LK6LwkcZNKPXrciLaFzSIJvTChyrIh87h/okGNzsbmGxy0BamTvKdKbC6IbAf/myEL0U89fptb3uJikX6eWVG1MYn2duf6/5c/4ZS0+5dsY7/xAlT8wwOXdRistrB10lX7+tw5ivFHbT8iH0DcGZ/aD9o3Bjhf8i/dccaVpVfhu6SgG8j2n89JY3uX57Q/4yTOj7HbUAO6MRmVu9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPDJw7iRlvnjlGKWX0jDaCGKN5qIfKMa9FJLURUfC7E=;
 b=Ocu+x/tFG1cVH4fpH4dGTWAgAAM5jv6B78oj4X72Z0O+X9Loz3fXD7pl628c0gT8mfHUxetmbVaX/zLvPhLBRJrVRwm6j+PxbUCgPsmD0fYZvvAPC/ULVu5aE4MDGIt4yTPNwuu+kpkC8uTQ5vLHJ8UwGua+v9MfOXBYtDzbDJhFngnRpZpTgCoORLVqGGJQw4MP9e+y6R1O3IuZR7l3F72RG/QEUCd1Wqu/a7d9UaE/CypXFk4TiSMjKJs9qLqo51Sr03bbF3ttLI2DIgqBk6cQqLaOs4dcP8coDLFq3yx5gfyMHnZNFhKK1k71YQ0TtACSZXRkNSdnLLG5iO07cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPDJw7iRlvnjlGKWX0jDaCGKN5qIfKMa9FJLURUfC7E=;
 b=r5Fm80bBq4DoL7ejZEnisOfjdkuwiE69zK8vW3NpAtpf2IDgLSjZYuZFsHTVVqzGl+GT723fy3cnndYIPmXLuiib1CbelJOAshinSuOLS61/egkMNhsqkVEdhX7FgFJ68xG3pmyla5OwUkkm2guPA9jpVi5Iug9b7BmfY9cml5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8055.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 11:35:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 11:35:29 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH RFC,BlueZ] doc: Add initial MediaSetup rst
Date: Wed, 19 Jun 2024 14:35:20 +0300
Message-Id: <20240619113520.7617-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0058.eurprd04.prod.outlook.com
 (2603:10a6:208:1::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa9a08e-ec3f-4b11-01fe-08dc9053ebb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X4AEKNLRJaGzuYV+Gfi6uoHnNs44za+lh/Nub4FGMjYSxHcwggQKMqwzoE8Z?=
 =?us-ascii?Q?3rUFh/6a+pNYpnJuTqBaFYbkZwYjvGn0ZJLGl7pXR2hf16Ylcaw9+oxH75LN?=
 =?us-ascii?Q?cLF8/PEh4xxfKc76NSJAsT8ulV/NHhPGhx4lKHS8hQ6SzliJMQ22YuS7yd9t?=
 =?us-ascii?Q?k+hDhZaE0eX1IkKh8noXySj6dXfcbLqK7CCHgy0KVUKIYjLwvThhLyuyDkFC?=
 =?us-ascii?Q?QGMnusXJCWAE5BDEbJcA4CsgpGoRp3snazD6U8KyyfbWJfajwDFsqsDK5M18?=
 =?us-ascii?Q?1Ym/ReGOt0kz9Iz8yivXRdYtmRgsr32P4PahQv7in6KZwVYFqNWqfWzjLgqf?=
 =?us-ascii?Q?cQ3GG05EyYx6D5nSQBqTutEPf9HYWqnZxAU346TMkz6TzhDDQgUibKWB0pHe?=
 =?us-ascii?Q?gE8YIVUSJPtGDp/ryrzNdFpOs/ohZ/3MgPEituZybzCd6WAZHsPP9MsANW/X?=
 =?us-ascii?Q?fSPQdm2xxLHpaPeNilpm3qTEvzyVmD08B/FhdWqns05FD664OGps+XgeReaY?=
 =?us-ascii?Q?HuokrKYbHmE335nT2q52eZGNtctGx9Y6s770lnzVjNfIUlwrjD7q7oLcd0U3?=
 =?us-ascii?Q?jn7jQanIfbrlfnycUO6UIU5eyFR6H7YsJ2NiAXG7zQ3FVy0i6VFrJHhLjf1h?=
 =?us-ascii?Q?/YL+qaoDsKFgJzoqFS5KFmTWkRmVS+8FNlHJEd3uzZhwzFLa9fUxQgAPCVfN?=
 =?us-ascii?Q?K3nQU56W1NP1gUePSEEIJX36saDcva2KPSkGzsHm2z6JD5Tr3rj2pGsZeQEk?=
 =?us-ascii?Q?zJNB9HFSWAKHJX3Cnt+tuXy7jqi5e+TiaUucUerlYGIFE1CUd7mfaS+nY8jj?=
 =?us-ascii?Q?IbRMzMPWM75uA/na0HIu4QSfS9zpiYP7eAG1efZmsj9sQdzWglsqza9G3A6H?=
 =?us-ascii?Q?qpe0vHXSGhUg4YCuRyuOeRsGiUi0HkKEMI+Pa8c8vJCQZHs1D6ne9UliRsHm?=
 =?us-ascii?Q?lKYN8EwmgsPEr8k0c1HrDZsMErd1bk0j6L4mFjUvLSTdWXI5vsssMJddjBE/?=
 =?us-ascii?Q?uMiNrDKGvt0IKC8cynLKHTaW4MsRLNS0mbK2DhhEbEpRDCG+MBxHqP59xzYk?=
 =?us-ascii?Q?7lc6qwwLoiQ96wiU5JZGSzGzGiNZ2RAw+5rVgpCtEH7WhkLw5FpqCFdR/4eC?=
 =?us-ascii?Q?4dmK10IzSYSIB4uybMwgTZcvYcu0XB49RBBvr80bLEI6m8OQ6VfTKHT7aAK7?=
 =?us-ascii?Q?Q304DGHWfy+mLC9TmNxMQfwIW9fVEc0E37qL1xQKfU/EnIYaNsyV3HpVERaj?=
 =?us-ascii?Q?CGy2U5ohP83FhXefm1lq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EI6NVYk2z1F/07SLN8qMxM+NsR20NTBdGpNfKE1yPpl+eg6SO+D1x+nhpQ31?=
 =?us-ascii?Q?YFgF4j7k4RGeiaIy/8ipDHmLdzZki2Fy7im2+rdf6U664fWnMTEKbYhiig9F?=
 =?us-ascii?Q?u0iS7sswxGOPb+GPXw9M8wiIUwhCuDPvmOq1iGyfEKyyJu8JeXvVzmfBzRVf?=
 =?us-ascii?Q?rjAEEIti4tAXIAhaDPDqPhFqnNdFi43yEZi8DoowhQErYv4eDVfXxO18tDkV?=
 =?us-ascii?Q?klbu/LEIBKW6tALjZbIoqYDvEz+mxKxJTB0sf2Vc4sfuUwV3frAUefK9CUDN?=
 =?us-ascii?Q?e2uksSGbLIZ0EWRNiHIlwnWSR12bF+C8Fptf1T0gvGk5pXcBKMD0LOhLB8yd?=
 =?us-ascii?Q?skEilZUXcm6vCT6L3Id3Ky52Wx5l2RzLrB7jYB5nTkAScMCbP0ttD2Q/M/Lb?=
 =?us-ascii?Q?1UJmL9mHZTOdBP13aYnRP5d43qnnuC5QWeSlFBW4tZhLEDojs3o+DHYE1Hum?=
 =?us-ascii?Q?2JNFX/MAg9nxWb/IN231AW4yvStaVNOH1wMA53JS9lD1UOjTT7UhzkzkjdeM?=
 =?us-ascii?Q?jRYrMe0eI5QR4zf/umWGSFdVIPboiEM4+EI4sJ/QoZUiz24oOrblOj4RVBzD?=
 =?us-ascii?Q?vauNWRpGAprdeLacOe7AHwULlttJTrx0DCeWSGjZZ6801i5K56WTTV+2wvIs?=
 =?us-ascii?Q?AQ7jnpg1PxJ96X3+fBQTeb6rG31oalsCyCL/IZIxbFa/uB30vGygiOqdbp98?=
 =?us-ascii?Q?8Xk6JvHahPY1jhNP9+P8aCGMnxprsLDOL03qgeGa9EM6uxj8bZvZP8S+H8D2?=
 =?us-ascii?Q?STsabsiXgqVPFQ8ycnvKy7TUko5fk06f2LXgJ/vfRj0cOgLy4endS3ZeilB4?=
 =?us-ascii?Q?RNa2MG0igIs9UrSnkmIvveZq4ptLudBwd4Uy/uZTLlM8FK+Dk2KhkVATooQQ?=
 =?us-ascii?Q?M5OJMh+mPOdZ9RV+9ziuMzbW8wXaBXuWBLzAEUn5n0DLzNdD4i3B62MXPssk?=
 =?us-ascii?Q?wBE3t+icQUICGWha0ESftKFoTgQOFnfsE9Jsve+14LzKVQS08GbtvqbMidza?=
 =?us-ascii?Q?MF2d3yOuvh9bJZRR6foVFWPrH3ic9zpFldhrEma2z1bms+hpMNIdwhbZV/6l?=
 =?us-ascii?Q?ReIC5gqYYnUjGAC7jx0wKDDbQONscZayCny+TtD87JKUgs2oFifhoTuzKR7r?=
 =?us-ascii?Q?ZnchqhQZ74L3pxxRacWi+taXKOIvnZ2VvRwcfAO7LRTmsmhRBg2Xz0RvxK8N?=
 =?us-ascii?Q?yhPSxo7h7JP39bO02lgl8hiBU+K+fnGO43ILfpCrWPVRbCPYLyxzmHElUvRx?=
 =?us-ascii?Q?7aOulAit1p/0zX1WB2FL/LJnFbPwg9wS2B/R6ar9vwLZ56s/zSwNoejoNc5l?=
 =?us-ascii?Q?TKz10PkVgC95z7uWSbqaXj/Pxz1HA3Du9lBuQMy5MYgsn1IkKhy9rH/bHqzx?=
 =?us-ascii?Q?hK+tf8oDll4PDJ8ESrwZIK7PIYb+clOvw0JuMgOVvYwokvbGL9rFJzzcnBmZ?=
 =?us-ascii?Q?sjpNqyhnOKNotng4f58pyD1v7gWN29RgaTC/tMGsKcMSdME+yilErFNqsftw?=
 =?us-ascii?Q?dBQH93Nl0ZxL0Lu6Yu6vzPHxCbQDKhCWvnBwSL5nWMiR/nb9TZs1h94WB6eT?=
 =?us-ascii?Q?qgTvY/8ZyaX412XodjcJZ+buzoHxQp+4zHB8n4dUGEQwAy+lQpHj4a89XFoi?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa9a08e-ec3f-4b11-01fe-08dc9053ebb4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:35:29.1866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq0OwddfX25/Zc8p54ZXzJEC7KtBdaEMnApnBJQUWw26g8AB+hGh7ypAwB8t58OAbUO6IIS0lYQ1gZ0RDjtYCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8055

This proposes a new D-Bus API to be used by the BAP Broadcast Assistant
role.

The BAP Broadcast Assistant is a Master device that can have multiple
connections with BAP Scan Delegators. The Broadcast Assistant has the UI
to start scanning, enumerate Broadacast Sources, allow the user to select
a desired Source and send the stream information to one of the peers. If
the selected stream is encrypted and the peer requires a Broadcast Code
to decrypt the stream, the user should issue a command to send the code.

A new D-Bus API is necessary to allow the BAP Broadcast Assistant
implementation in BlueZ to communicate with a top level UI process.

The Broadcast Assistant in BlueZ should register a D-Bus object for each
scanned BIS that matches the Audio capabilities of a peer. Each object
should be linked with the stream and the peer device that matches the
stream capabilities.

The top level process should detect these objects and display the
information to the user. The user can issue commands to select an object
or to provide the Broadcast Code for an object.

More information on the proposed design can be found here:
https://github.com/orgs/bluez/discussions/822
---
 Makefile.am                  |  6 ++---
 doc/org.bluez.MediaSetup.rst | 45 ++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.MediaSetup.rst

diff --git a/Makefile.am b/Makefile.am
index 0ae721111..217e7d2e4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -362,7 +362,7 @@ man_MANS += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 man_MANS += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
-		doc/org.bluez.MediaTransport.5
+		doc/org.bluez.MediaTransport.5 doc/org.bluez.MediaSetup.5
 man_MANS += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
 		doc/org.bluez.GattService.5 \
 		doc/org.bluez.GattCharacteristic.5 \
@@ -395,7 +395,7 @@ manual_pages += doc/org.bluez.Adapter.5 doc/org.bluez.Device.5 \
 manual_pages += doc/org.bluez.Media.5 doc/org.bluez.MediaControl.5 \
 		doc/org.bluez.MediaPlayer.5 doc/org.bluez.MediaFolder.5 \
 		doc/org.bluez.MediaItem.5 doc/org.bluez.MediaEndpoint.5 \
-		doc/org.bluez.MediaTransport.5
+		doc/org.bluez.MediaTransport.5 doc/org.bluez.MediaSetup.5
 manual_pages += doc/org.bluez.GattManager.5 doc/org.bluez.GattProfile.5 \
 		doc/org.bluez.GattService.5 \
 		doc/org.bluez.GattCharacteristic.5 \
@@ -475,7 +475,7 @@ EXTRA_DIST += doc/org.bluez.Adapter.rst doc/org.bluez.Device.rst \
 EXTRA_DIST += doc/org.bluez.Media.rst doc/org.bluez.MediaControl.rst \
 		doc/org.bluez.MediaPlayer.rst doc/org.bluez.MediaFolder.rst \
 		doc/org.bluez.MediaItem.rst doc/org.bluez.MediaEndpoint.rst \
-		doc/org.bluez.MediaTransport.rst
+		doc/org.bluez.MediaTransport.rst doc/org.bluez.MediaSetup.rst
 
 EXTRA_DIST += doc/org.bluez.GattManager.rst doc/org.bluez.GattProfile.rst\
 		doc/org.bluez.GattService.rst \
diff --git a/doc/org.bluez.MediaSetup.rst b/doc/org.bluez.MediaSetup.rst
new file mode 100644
index 000000000..7463d7cfb
--- /dev/null
+++ b/doc/org.bluez.MediaSetup.rst
@@ -0,0 +1,45 @@
+=======================
+org.bluez.MediaSetup
+=======================
+
+-------------------------------------------
+BlueZ D-Bus MediaSetup API documentation
+-------------------------------------------
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
+:Interface:	org.bluez.MediaSetup1
+:Object path:	/org/bluez/{hci0,hci1,...}/src_XX_XX_XX_XX_XX_XX/dev_YY_YY_YY_YY_YY_YY/bisZ
+
+Methods
+-------
+
+void Select()
+````````````````````````````````````````````````````````
+
+	Send stream information to the remote device.
+
+void SetBcode(array{byte} broadcast_code)
+`````````````````````````````````````````````````````````
+
+	Send Broadcast_Code to the remote device.
+
+Properties
+----------
+
+string State [readonly]
+```````````````````````
+
+	Indicates the state of the setup. Possible values are:
+
+	:"idle": setup created
+	:"pending": setup selected
+	:"requesting": remote device requires Broadcast_Code
+	:"active": remote device started receiving stream
\ No newline at end of file
-- 
2.39.2

