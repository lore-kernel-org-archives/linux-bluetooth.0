Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2137.outbound.protection.outlook.com [40.107.7.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA55664AB
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058220; cv=fail; b=IRht1NO8yQiSDwZH27oXQYS3A5HkGSUxGZAvi17nBdJIwCWGOVgr1OgPho3CSF9BN8c3u5mRYpk82xmgiawhLdf82p+R+9OGYt8XMexG2uxWqAVJjXhgXuOql68gCbv24TitReciVPbtuX0AWEQC0tKFrBQFjooh5wB++Hb2od8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058220; c=relaxed/simple;
	bh=PI1xJ2t6ehzXgmf8DxtgMo54lsM0yjZZse2GrEcJLH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QXnokbYUr0lzik9MvLN7fesE/Bm+oE4XpYnjmsuNvm6tuMMogR43V3Mw+cjS7FvqRDBzEwGh7P1TuJ+3MkbnQ9nt4xKIT2wA9RucfEL18+j2AF+87vGpq1hPhIGUPjpoewnuI8T3tvL+7k80DeqrZi1L6zoSJR6/Axc75x+st5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BRVPjYxf; arc=fail smtp.client-ip=40.107.7.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BRVPjYxf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7OndRqueRsSpmeTDMrOT0I72cG+Vvr07mcJWcZejjTuEBUh9o0A1z+ya+ciFEf7lcysbk8985GKktdsxAq17YX3vAHDwCaBlf2+BGjq4SNtuoFVg5i55yUyYrY3Rbmy8s4zoONqHliGYR4Cedgg++gqVlEbcDM+aKd/wei2DWCa6HTnP7C8gJ64GbKZOSuSwUTRfZBkLrZTGNG3t939Vahb5/0wdqEjndAYDnmshq17RVHiHM+6QBCYn25v4/KoGLSMZTBzxy/iKpg4b9EGrVgqYTlZP0bf+ZI82huLtzbGVf9wZ7v0FXR8NEVeYY7ud/PCeQfgJ+HOlteFBZhgpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8Hy/5IWYZaP/7qnIGFtGP0egtcPXlcdmYboWt6Yro4=;
 b=Dk0fkASV0JaSFE+M5v6yNgFfmHvrkIEeoZER1qOIPPHictTlR/+0UI8mtEPaytkdwJo6wdIKiCyC8SnupPgVq+3BB8iD5StVLWOIg6Jt4Rx3389sAEbTG8Ai6sI+JxkB0lSgKhoNjgNgo260EW9Me5IRQIjL9N3QQq2ZE78OJeoJ1YrB+41uceTmkrVlHODunHUdnEALONbMo7WX3ArnJlpmXCcjRbq1Fe7OArFz2Csplc3Q7j+PWoI1GX3hCIOdSoAnj5/M1O9G2dPEpAY9zE2wSi4Mx+LQBijS+UwdM9pLlLrr4f7X41/YSuscGIe4q+0IfPjO2LU/ykXVD964Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8Hy/5IWYZaP/7qnIGFtGP0egtcPXlcdmYboWt6Yro4=;
 b=BRVPjYxfsjS6D/6Dtdz7GJij6U7swikUob4odVNIOxEgHNE/vqO9yE4dD/Z6UIebePNmk7hNCn/6v5Au6ZV9D7ELXFN5Qztf33duc5FObFN4+bFegpDv96Ahv2e+9Qr4gwY1dSgtEvrijgsVtWcBikbAhJ1GMY/EL8didHoqRFI=
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:43:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:43:35 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] lib: Add macros for HCI_MAX_PER_AD_LENGTH and EIR_SERVICE_DATA_LENGTH
Date: Tue,  2 Apr 2024 14:43:24 +0300
Message-Id: <20240402114326.3330-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402114326.3330-1-iulia.tanasescu@nxp.com>
References: <20240402114326.3330-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0012.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::24) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9498:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pmZtFx3WOID4/sA6Rt81DHWMsJMQtLjYoGgv63dqt6UiEaTUNHTpgT9RYPwmyeHt5Hgc5/VsmwHOPwIlucGjbskmkZhrEgVqdJMWVX7Y8PaOE00Qyo+JO8gLr0PPTwYAovp9C0s1Y5T7m+HDaAp7HLT1sdL6aTxSpGT6wG0H+AiE//DADDsOw2Jy+yAh1tF6c61mQug0V6VIYGOMBlMa3WE0sF0cVL5MeyDVHVvzmcGXAF4L99tOWLRfHNcAeoCl2i9HPzrSpJM8AUAfSc42Mr4PO2HLe78gN4aXD/3fowGEuksTtOBKRU5gDgJS4ArRPycuqR/NSCU4DjbLuT7pQ+tIJkx+SlhhGJVuMW63px7/FcppKNTS7gnVErECQhEJqGvrCHqKAFskJZEkjnt1XDPhENjs8HSMzYsrrnzCoc21kdexSdvyQAmT3LrI3kQHxkwcCBDsDRcJ84mPNrnWrLxDzH45yyto+xnzKZUeP66UbJ2gxGo/S4fsxzAwUXEXYJWIfmJDUnYY/RJN7SW6QhrRjqsMeVokR6vonANKTF44qRCsnQfT/STW6w/ik9xMuXCoI6VAsGqkDio6WMxMspjk00lP9DpWjr3mQa5SpHOL8TYdP17tC3Il08EiXl7smOmwP8QW4kcai3RaAZ8dmnHnchfBQA9o+6QFAnesBJg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MsT1TX0lAFxgeT773Mu59VavzNl0o5lNNXQH4tR8divMPJynIa90kP8CkzKG?=
 =?us-ascii?Q?6dcGubKWtylrsVxeWJ1f/ewbC0bJmiTh3emtX5Xp+7LucyGbg/oSVuCsEm9y?=
 =?us-ascii?Q?Bzdnj/xpgiwj+tyN29MOjCM0BafGgqlLuH9vgnqA20OtJWI6j/APCyxb8FdW?=
 =?us-ascii?Q?AKNoQDfDu9P+JmgmK+2T8/8vmACWIvJveXNuZyWUHbK8rFOkLc8BxsMKfHeP?=
 =?us-ascii?Q?dvgLJjN5vJ91K7tx5jqzZ2q3JISuIrU4X+yGnW6DcYeEds2eBuBmgy2nRd1L?=
 =?us-ascii?Q?F1sXyizVnqBQZAOz9/1Kn7mTjRESW9VSb+0GlOYtP4JqAnDU8HsTr1cnU5SZ?=
 =?us-ascii?Q?cUWOF8Y2mpgs2ZOKFrXznaBmQVLvIjJQgErdDt3/WqW6DNZUSt3v1z6H7Rv4?=
 =?us-ascii?Q?pSAgjYpfVKVuB3lbeYT6sY+W2jBmod8W5i3CRolGYozefgxAtIOf1PY/fCRn?=
 =?us-ascii?Q?Gbm780OfbBqqdexJU7SfwcUIFws/xYkaCoATFXtgE0Wdh5PgvYDHxA8RWJej?=
 =?us-ascii?Q?GBtqJp5/7aDy+7BIGiDqQmyWq9K+jt5Ysggy1wZG0n1Ie8yPXzAh1ezoKVme?=
 =?us-ascii?Q?+Fm/sQZtQnE+4ceRtM6qXhkUTnYOKJ4S2q5FtFB2aaBigevnYVCdnX0vh2pK?=
 =?us-ascii?Q?vGhHsjNptlAdCLgvu6v5s7f7Lt2nZZimwNNQbWnUi9nx4xk337/8vA8pEHLz?=
 =?us-ascii?Q?tUh1vyd+mJUkmhpMwJyHwKWC6X1DvEhbPaOGKZO+p++xCJwYMco3QnOxmFeW?=
 =?us-ascii?Q?LB01mEPdgBA+prCOzTrNVoIGhMZLid622ND9sh0iWilUFSsmMT7eUgbLWAIR?=
 =?us-ascii?Q?+lSJ08/PPPoM0wWHO1ZJHcOveZhmiYAKq3rLpvF3JV7kd8AD8WVVTCPJ5M3T?=
 =?us-ascii?Q?L/XnXzqhLsw0x1hMlrhKjM9txW1hOQ7jZo1toACRHuvc5sgYhwWugSWvftzg?=
 =?us-ascii?Q?Q0kHN/dXBczDeMh2mMJX7Us68vlXtbOxUZkmZHBbGQ1KvWC+vAyEQI53Flvm?=
 =?us-ascii?Q?za6wMggp6aWrQ+KhjG0TJ+af3XrYSIlsN5CKsXnyBwoRFdVwKQTbPPaONsDE?=
 =?us-ascii?Q?WbQEfi+HBKELVAvOLsyDcI8T9USlqxlT3hTos8MUCnnA5iajar8HM914nOIB?=
 =?us-ascii?Q?cCCBKCRaNqJfsyrl9VPNwxfGXvsvH3zZwjj8c0onzYK2VOc1wYoR374/ZKwL?=
 =?us-ascii?Q?uFIA0MrqpLS+ewH/Wx4mC2ugkrFgDXNsIl0568g50skavBCxWZF2CQp/AP9U?=
 =?us-ascii?Q?XvelWu5o2GkDjCgIYNzqimT34fWFO9f2ojf/FgYJqPbwVK4RWgW1B1RbkZGw?=
 =?us-ascii?Q?fhgwAYKYjyg17yNLxTK9o/Ba65uafvXTcO6dgx/lohlB79AGkW8eHgzF60AD?=
 =?us-ascii?Q?qZ3AeOnU2z17ffrCShD4gzff6v1obA1WBZVpWPQp07x/z+wX4IBY5t9Q+liR?=
 =?us-ascii?Q?TXOJhdUeO/50AXRyoCGICoOegDirL8jpmY8jdxGTxQgtB7kCYkqaGR0P4Hdx?=
 =?us-ascii?Q?Ni35DuhGMnX7TrEmNNWrAEt1m/L4r9ZP16ioZraw2M/dOG/OiaufQSJvFC4z?=
 =?us-ascii?Q?+qUIEqQTOwBjolzKpoGyijB5RbuZoTAWymro98HbsIvnKW5a2XpLmyHRZOHT?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c407f8cb-d77d-4623-52d5-08dc530a2197
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:43:35.9176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnU2Egyt6ugTLQpg+VLV0E8tfGzYlxRLTILUYJayxBU4pxsPT/iSg7p630cInFeMEmfJvRIeGpLJaHI/CuWHBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9498

This adds the HCI_MAX_PER_AD_LENGTH and EIR_SERVICE_DATA_LENGTH macros.
---
 lib/bluetooth.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 75dc960c8..f67d79f66 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -6,7 +6,7 @@
  *  Copyright (C) 2000-2001  Qualcomm Incorporated
  *  Copyright (C) 2002-2003  Maxim Krasnyansky <maxk@qualcomm.com>
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -191,6 +191,9 @@ struct bt_iso_bcast_qos {
 	uint16_t timeout;
 };
 
+#define HCI_MAX_PER_AD_LENGTH	252
+#define EIR_SERVICE_DATA_LENGTH	4
+
 /* (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH) */
 #define BASE_MAX_LENGTH 248
 struct bt_iso_base {
-- 
2.39.2

