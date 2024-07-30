Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD61A0B02
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348623; cv=fail; b=Xu1ASrWXxozW+IDi7KUVMt9QssuGspHwbg6hNQvM0c8K11bVMVVXhGUpcnuxqfzAin9e2FrIllkBDB8TSSKL9SqdKofoGXa443ERP7jJ2VYpP2BgkTaBf/z+21CoAOplLsqHU7+Qht8EU8P7iVeRgGafazUyV3gwQtJHlfAR4Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348623; c=relaxed/simple;
	bh=a7v17usoPq9VVb+5xJWANTG0ehA9FJq9FbXOMbWh10Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CoetpOmpa09+SfgmDI26B7asvsP+Vb8mrmh1d0CrZV01REP3E6fZTDFr6vkM1pv7vjAE7txl6IidAr3HyhJcBhLDMOBazcdIBIJg7bYRqCs87ln6AmglUPgNyjuf7pC+yMRQ5E6kxGEvCwJxevl/9Ux4ASDHKbgFR+rWndYSXJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ilvlw/eX; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ilvlw/eX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHIyxPKgpDHB91Z5Cc/fSjene7O+UCyuqBPoAvRGJWPTBX9d/43mg12GYSBMKq+IaEPl/oO+Uv47gd1Ng6oCC8ZZ0zMUDG8ULPPHJyh3RZqEG9je/Tv6+yJCDl3OXdBalvXYDllUA8crPnz/KBUiAFxAlBnc+3PqeUppHHax4QX6tbA7OrT9MX25Wz62JMTCRVMWw600vR4vmjXOSisyKbjJL29ItC1yaYlpxMemBZ1Y2e1a8X8TLJ8s//uioqLbjnPtNRHp/2kYD8RWhQ1jPLVJFvb61HnBkG7kvwIMboYjTgFdVuI56fnpStocUpy6HjcucjuLbtxB/JcVn6qxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOi6tdBSdibvtosJmhZAaAG9oKHYY0XX6KrK3uJcebY=;
 b=dOIAND5BzWdhpHtl8VuGrz72f2ufwt8L1wX5P+8Nbpy9vVXUdvb8Y/5W23Wo6tTKcOFaUVOmWJgr/a2tLDRWjphMqOb3S23VLzoGaTX17SKeDhinS3s345KPta2eYatW5La0jzC9yXAE8yWj5j4DPZOyaEI04XYUGdu8X2BKgjx5j1kQKKCy/1reaw18r8KD26dNmL2cpo8zFYlxmScQrfA1EsN3fyhtc/6eg1od+TsMpX41JjafYgDInSUamYSd2LSsBTZ2ytwrg3KttyQ8VyXyBZ8KElfJzM+N5URkA9gzexNtg/C6o2b5NUG/4m/XMLdQq+hZr4P8H82XxQKZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOi6tdBSdibvtosJmhZAaAG9oKHYY0XX6KrK3uJcebY=;
 b=Ilvlw/eXZDsK+Kq0NEcjWP5h3kglpynMhz0algY2Mb++vRhrC4SbxeZJy+0ZgmSnEerYUOsjcAavsjUcfUA3U0PLQ0oQkPqY+mZ9VBDtbV42CKMlUL4uE4ITLjPIkJtWgJjdXAOeiz18RieUrcHpJ6jsbqkvL7FpwfJUdTOat+YqRRyscSFEXpnup39qbokzC9LwZXw2Rc0S4qy01NNPoG+NoxbHo0ftrpq/fMzwpq/liudHxd7pqFNtcmfpwUx+FSejgGshMIvwMRYhyG/Knivc8vSJyN0GnA6+cMtFlOSmWZ47cC4W6Rkl6wkAgTiPJ7iUnRoyfqZupEM4+enKcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:10:14 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:14 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 6/8] doc/media: Add 'unselect' method
Date: Tue, 30 Jul 2024 17:09:45 +0300
Message-Id: <20240730140947.411655-7-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e38c76dd-4846-4025-43e2-08dcb0a1551f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?89CDgfKs+5vx+vli5Vh4qtDhkmIwlfLuhiSpTlzAQ5zh1um44/fbe8rAty0+?=
 =?us-ascii?Q?pXyS5IyDnVL9ytkv+wu8E0fpPER2Wd5BikKxBySdMFcPbCDH3W6ABLHLz1E9?=
 =?us-ascii?Q?WZjLR/wzQ6uEVE4lL6d7A9iq0deirNNt8DagqkwhEwJfeoslpl0LR2/ya6a8?=
 =?us-ascii?Q?1rnZQe7Fc5G26I31MQKnd+OUv/RwubAgEbcOKzyEZsTvbd+ObvTI7S+a0k70?=
 =?us-ascii?Q?RbziCQmxmMLNz/yZy4fxWCM3IFdkb05A8iHsj3oFl/3mUS7LMi7yqM2IngvT?=
 =?us-ascii?Q?UvUeNHzJjRs6Ah7Z5xMj6TOgoe7MogYb0Fam5RzuffeNL46nlXikTdP1CzJe?=
 =?us-ascii?Q?qP8Fx3Kh7ciwALF5ChCqmIVdn2oOzo8ct4r0jKUkcObKpG5rw311sJGnsuVS?=
 =?us-ascii?Q?w+Yb6JIjCyF2pgY6qLqoJX4weWrvcumybMOd1xHSUrTHgpIchXeh+IESqgSo?=
 =?us-ascii?Q?zSdTKFyxseR7pfM9KTiI1H7r2W8QsjS0q6SNs+K1aSMBBL2nT0TVp0dmpKlG?=
 =?us-ascii?Q?KqfiDI2mhNVqGmRubRkDVbOt/MXkxQXYRAQ7uc0s6sxwCJEhs5AtiH9fubEE?=
 =?us-ascii?Q?ijSMpJsVPxGHj9Q19WkNjA4PkOhIfK8RStyQbFY4OBoqlY7f0D0LS57Dj/D3?=
 =?us-ascii?Q?5rWAlZs0bdzqYL29j/P9EhmiX0D14UE7Hb/2q6+w8cZs5bb6GSCrzBB+E0lW?=
 =?us-ascii?Q?yE+m/tjEePY55xTJMMgD5UXCHZXrzRLTv/rv6xAXFe4Z575Y1hsBNhtOFzw+?=
 =?us-ascii?Q?GAMoEslIiix19fY1XVLFYW/Hg6Cd2CgjJHCyGCwEKP2P9c6W3GYIH/zyVWvM?=
 =?us-ascii?Q?30f0qq7umfjqVG3I10ov0cMNNpZVIUJIEBaPzPlta90pD6hOO6OJ8otYaKbu?=
 =?us-ascii?Q?2GRD/4uDlmbiCKeKsxyXQNNOAhVA77lsl7LXWVDbD6P/BsDUtpodyxuPUP3T?=
 =?us-ascii?Q?yRQM4GijVHWGGPOkOplH4VjkcsFZmZYYdOamhLAIK5tw4xXSOsJMNGLJqTZs?=
 =?us-ascii?Q?WQ+Zp7ScHAt+9LfaVH5SYfjj1U8f2FP5B+xGXoiaBjGrysw2NP+BPcrxpW8h?=
 =?us-ascii?Q?S5TcRLIAJhBBt/LNcNXEm+y6HWjegux/A5ASJ8ra56HbA0GAa3/zDNRX1R1h?=
 =?us-ascii?Q?sx66Px8WfYQG8GI6fpic9kStpflnChYCL7I5WagcTtDQdLSU/RHDM5bARckA?=
 =?us-ascii?Q?opRvjuNkFjyB3ENkYiwMwJc7zV8ucWKNIygz6ortZuR/Cr5Kaznio7GRYQuo?=
 =?us-ascii?Q?qIJ9hA6D+Ycfu1or/9Gb+NsnYJ00kbVtWQTNGKYYxf1O477kj8oqf+5Fa7Sd?=
 =?us-ascii?Q?8y7gtdfnnqGRbg4DSe9e1vpMWtaaWvRS/Z0WMAosQInvkLULRkRG4Bi4EiR1?=
 =?us-ascii?Q?Z8CM5QJPgtjcDr7eTvUlx0a1h24mWH+OXXWwxuGGU6klhzUPBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqVEiwZTFSrGQ38BunfeKMktKi2yZfa3tEl2s3cei/fzEOmYUWnX+KE5SQMN?=
 =?us-ascii?Q?FJvc2/hu/8aYAZcU5T+IlGpmqzf9zLmUdIXzUjhhS+78FeA2jCGDdbn0RMeZ?=
 =?us-ascii?Q?ZzDzXMe6z7MvoJ4yN2c8w54rUFWx/z+BRUPCIiKlQbv3tIld27iiQjOPOLDq?=
 =?us-ascii?Q?X/6aAv5FQRmGDytJDTvV57xm8ytHDWcKdq54BUReODdV/t9hUd5gTCXDVve9?=
 =?us-ascii?Q?mHcbkbT5bVt5BBzWiLr9T5uCfjlVDMbxcmOBNdUE8/8j4KVM1A95OuABx/5B?=
 =?us-ascii?Q?5OBwWBLkEi6aVV7CSnx3iomPtZ0/wiiQob7Yl8Dw9gji4PhJ474ZQszUA/nN?=
 =?us-ascii?Q?37xaAqjqS3tEpTPOwR2Nm2o1x1jUwgcWSSXudwy9jhlJ8oe4MWhw8SJUyuBs?=
 =?us-ascii?Q?VcArg5XBojpGkmrth3QP7OxHigkPVq0o293+ZgxSDhgh6FL5m6s6+5f8N9wV?=
 =?us-ascii?Q?RPIxTP26hdSo8aq4OUJILEuIkOWMKacepPNUnDSAkgwUxd4wNYakikPNTWBS?=
 =?us-ascii?Q?W7WT9Qf0fgOZqXOZKU22yh2zIk5Va3jtBCyYjoQC+Esq8bQ7IWGqwQz4OI7M?=
 =?us-ascii?Q?4YvxbdppPXVvWtcJvPe48+V2uo5nE0mxej82lTMrSkc5/XJkHC/tt8noEP3e?=
 =?us-ascii?Q?4Fwb6uxv4fzTTCedkSs2WdOnmYPGkFCJqHm6I+gzNvZTvCf08bCMUP1a3Qpa?=
 =?us-ascii?Q?wO6si1ZDXHkydgbE49Qm71atz3B1tkFJj1KDKR3NuqKDv3iQZq144PD5wyI2?=
 =?us-ascii?Q?SLkAVfm+t7tdO/dUiquJgGaEipu2IYNw5+lOXzKXLl1tQJHCWuPGDqW6CGx8?=
 =?us-ascii?Q?QqRjoP9ctc92QwrIczFsQhOgqu/yOGXhfudbreyBdWZqi919fBw35pNzJ7nE?=
 =?us-ascii?Q?ywaZsOyF5zQn2hdyy8QJylci46ui02NUb9zK2xf3R18Vg+QFMLNCQGWdk+ly?=
 =?us-ascii?Q?Xvf1iFGZ5kZOq0ASqK8RuDgY/nBJcKTlI5aaWirD6VVY4UrHxD+qRf41AOD9?=
 =?us-ascii?Q?Nw6BV2X+Z5i5KpD7E0abCYHo0oy/iA+vTB5R0frW/VS3Wm3CeHQ86cIVOjrG?=
 =?us-ascii?Q?VVTvyrvsTIcI5A5ADxRxQzlrXBdRPKXU0JyRn77qkA8WoCqmvRTrPlaBgaJ1?=
 =?us-ascii?Q?a6Z3rt4LziSSSUqEQh1gQ4ajwZjTnu93lTt1K2oRkKW50SpkEpWoqoAB4uM3?=
 =?us-ascii?Q?P3sSun+Y86157RSbOuURLpKxa4qTqiFKqWbaQXBqzWbqijeqtUzdyveJHaYm?=
 =?us-ascii?Q?xTp9MFziU+zp41C++S8iwDnZ9rvBKzkEDHjJsdouO6PSUg47YNVbDZvgO+4o?=
 =?us-ascii?Q?WziNOUnbII3joFcCp07KUsZLlHi42VYeH+yPbmbHlFw7J9hL9+4KZ5HlspxC?=
 =?us-ascii?Q?hsqCJUrDgxjjJOXjski6199v1i9F1KbU2HdmFW7IJ8t6Kz4Dzy2XDos2UOwj?=
 =?us-ascii?Q?vKW1pDNiUV5jAw4XBxlNVqWD/nD92FvxSFM0w7dELfl5hU5Yyn0jcXNkn9Uu?=
 =?us-ascii?Q?0INCS59LX5B5DXZAuk9rKVlAXBXDiIYWUMz3yQha1oui3sOgAf1QMXAz3JYP?=
 =?us-ascii?Q?7VVHlQdwZGEnC1AZS3oLG5uBL6o0dBEE4Lhwmo1X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38c76dd-4846-4025-43e2-08dcb0a1551f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:14.6204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8egB5bGpmqkGrBZbnu7Ifucc4xhMs5SuFHksS1hivwu96XUvlUWUX4oZJQiqIebkyGld+J546r18FRUPR/kCrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

This adds the documentation for a new method, exclusive to transports
created by the Broadcast Sink. It would allow the user to terminate the
sync to a BIS, via a 2 step process. The first step is the call to this
method, which changes the transport's state to idle, with the second step
being done by the audio server which detects this change and releases
the transport.
---
 doc/org.bluez.MediaTransport.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index c23d1f59f..b33c3bcf4 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -57,7 +57,7 @@ void Select_transport()
 	Applicable only for transports created by a broadcast sink. This moves
 	the transport from 'idle' to 'broadcasting'. This allows the user to
 	select which BISes he wishes to sync to via a 2 step process:
-	1) the user calls this method, changing the transport's state to idle
+	1) the user calls the method, changing the transport's state to broadcasting
 	2) the audio server detects that the transport is in the 'broadcasting'
 	state and automatically acquires it
 
@@ -65,6 +65,19 @@ void Select_transport()
 
 	:org.bluez.Error.NotAuthorized:
 
+void Unselect_transport()
+`````````````````````````
+
+	Applicable only for transports created by a broadcast sink. This moves
+	the transport from 'broadcasting' or 'active' to 'idle'. This allows the
+	user to terminate the sync to a BIS to via a 2 step process:
+	1) the user calls this method, changing the transport's state to idle
+	2) the audio server detects this event and releases the transport
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+
 Properties
 ----------
 
-- 
2.40.1

