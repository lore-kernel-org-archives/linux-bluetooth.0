Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BECC19F499
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348617; cv=fail; b=YTEBexeGlmH0bOsZ0mnIbVEzbkP+ebwgZM/aDvkWAsOPgtKOyhiM2HIcLaWy+2q6N0GQ5iiwzFs6v+7uzzym6w8Nf6KpUyl9csNkgET6o2NQajrpHhVqXhDljyAntoTt7MLajE9Bm29Cok3kG/dlBSeMVI16opfZS7MAbPJzaWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348617; c=relaxed/simple;
	bh=ScA4UPNj3WGmvMkJvYFNz9vuwePqO/1d7vp86uw3AAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgrbpLs/mr37LuTWc2Y44yP78cW7b6irORDUfPlNdmpmr06eW8zZWZst/7q903ict0VOvhW0kFn7Y1L8iaT6WyqFVJbX+S7+3nYwI0Z4TXvhq1fXjyq7KnhCBnf6L+ZO0KTpz+uYSGvl9OR+Npbq9z6/MDiAJhs19zt/xNAVPX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oItWwIFS; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oItWwIFS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BW/r5e0ypvqUQa1j/R8E+Y49PTlV65AquOLVzR3/M+vIy8LrMUFEM5U93s8XbyYDGUsupZgT5D/ciTYpgy+Aofo5O/8lTi6iAvVe3Q5EOHPRYSQ7Q7vSQk8cM/wee1gHQsSYm03i3hvmLchatp5WWtHUgs2BNLy33Cb5QX6UVr+9ymtFuUANPP35GpV3MDbT8q+62o6B1w4fSIsAguaHRSo4F0rHkLdO1FExS8GlZFJeuYnPpL9k45qqccm1ugZzZcPkriFQgwxfefb8zt1IRPp1xdA0VwwmiZ4F7Qx5SfBd4F+D6r8KTfZ9KrWfWpCJXBjIyAO5cYdjGmsguktwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UTYtrHGcPISsbUfQTgBM7QWrrsGXrIK7EhT5vVwByM=;
 b=zPzDBn/ty2NjsyqmrjWaymWSApCPMcR1pMCCFzNG9GeMFqfZM+p/Kl8HduVhswVobwHH8O3POTgNxi+jRp/1gkBzycHJRuPZntMEufAgTaNpbh4HJxxIVyC0lz+YC/94E1UKoqS3bmXcuazAFtYQIG8xz7iwhio8OgR2fZCpOgCvtpkawdDJErko4HpYBpkne40Y6u+ddP7fagwDE2+gBChRLI+sH3scojw5/nUWRikkpLZKNK4VZLMrXohY54E/DxEe+denf7Bkpf9KutxnDN9im52Rz1Gk0pmj/WreUjtTr3F60T95KWxn7JwE00BLp922MnY1l9yZk/trQsO8Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UTYtrHGcPISsbUfQTgBM7QWrrsGXrIK7EhT5vVwByM=;
 b=oItWwIFSQ5fa7MBmrnS+Z0uIENJmI+JY7fJIqgZdKr0t97CiHb/pvsKQvb2O8QK33UpFErs9Vojnoz8Rl1cCDKeD9sz96BWOY0eVPDE1i0hxHEItP4orh/dxZns8+KVFO+1tRznw1kDrIIy3l9zf/D2nzG4mrYPV53isX3oSWIC8Kmlu4vU+mv9/+B1dZEloYNCgzgrasRvJqcVmHQf4u5ShUAEy63uQC41LNYJWKY6u4hPetOZWWCaXaAv5sT5pI/pXrRI2V5WbxaqlRa6Gmbf24qk/M0tonEkB/FYVUZBRR7YVQtrlbRxjqBuVX9DIoS+CvxcIy4s5vura3Hs8bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:10:09 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:09 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 3/8] transport: Add "select" method
Date: Tue, 30 Jul 2024 17:09:42 +0300
Message-Id: <20240730140947.411655-4-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1694f6c6-babc-453b-2cf8-08dcb0a1520f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qMSqYzqf8w1sWjOVMmpt8OM/F0vWOwJRQkFYXTkymDuzkWzTERrf0ykAj92d?=
 =?us-ascii?Q?67mBUz43mi0i3sJB3/zzW7lYV/3f4VmTGeuBC3LO3GQ4hjBci6rWhDMYCFGc?=
 =?us-ascii?Q?CShpFE7ZLxmTd5X5MAeiDW3FUqFf8LYLjyol+lCOAFGqPiBQGloBm8tpqVfs?=
 =?us-ascii?Q?Hcb6CqFc64Q8YyQZrhpVxcG0aNZfSMAF3quYQ4KVUdNDmGsiz1jE+qYwl5qb?=
 =?us-ascii?Q?t4KWHsxGxwYtgpr9AvpA3z73QGaXhrvZxmLSdAQ2VCBfJdi1iOdYLGqJ9n0H?=
 =?us-ascii?Q?R86choXakKsJSZPxon5xn7UWxwL5iB6APVk5N6lJZ85RNCcShzAGRMKPoteo?=
 =?us-ascii?Q?imWk3PiTnZytyHXbi5M5Bye/0ILgMoilY5nycx47GrGhOaLlyCFVf4S8PAn4?=
 =?us-ascii?Q?yiYTXEn2sabyVHNg38aAgZFoMg7WN5PWL/3syPtpOVobdMuQcKEcV4A2TPHh?=
 =?us-ascii?Q?HKImPWff5npdX0dgh6c4hFnFj3HR8IO5AHkWtXCO44O28z8CguXpHr/bTyiJ?=
 =?us-ascii?Q?pe+ygVkGa6tyRKkMx3CMcX/uIwdmmE7MyytLFB7ATxaGAjddyZw8z0k+tfPu?=
 =?us-ascii?Q?+u8e7wJirsM2sYvDylhWKnXYhnawpRP3op6k1W+BZlxeOmE8dMQBPQL7pGna?=
 =?us-ascii?Q?8S18rLFnKyxrdSrZy7NgzkmCCuajH97atHsNffxd0i7P6ahSEC5mQQRzaPlV?=
 =?us-ascii?Q?5WSVVaAJfWuhawNW0u2LY4iXhFvar0UKvUE8HGAwdzfWppkeKJxj5MgBNmo8?=
 =?us-ascii?Q?n1Fwa7GvKmihl+ZVt4pefAgVCIxAf7MMt5AwzU449gnbJGb2CM++MUN403fS?=
 =?us-ascii?Q?pMBR382mqXHQZm+HynD+d1lzqMX88UBa/hJ67liqkO/PikjNBvvYAhuZAWoP?=
 =?us-ascii?Q?hj49HVt0Mf9h6YTc5p2UqWSLiGg55trR5cWbclEi/J24mePokdo8ZgGCCF3p?=
 =?us-ascii?Q?AjjIWh8k7tIuPgdaqIOUpkwDGRwOUx4AIauH/83MmUhcomyL9Xeq1WvWJMXq?=
 =?us-ascii?Q?Q+w2Pslbc6kaRxHlNJcWDdvznl9G+IhC7iOjUsEXeTw3ta1s/X2ytlcWd+gq?=
 =?us-ascii?Q?OlE+Y6LNy47bgUkh674G80faJUnsv7DYlRg2N2uZ4B90MhYIvZNI2pFtt+k8?=
 =?us-ascii?Q?qVYws4cP4jY0P9RE8nyjpUw/cLSwM9N7uSuIUV2hLkPcR+Sn2Hj5qGk4CBGi?=
 =?us-ascii?Q?+V8cLhBuoIG9Agan/6r/bV23/yfm++Aqwvgop8qQMuC5DsuIuLY3mVEw3OMW?=
 =?us-ascii?Q?xqp+7Iao+yV4iwdf5HPSX84zm68LeAnp7CkYQp9c6DAPRFBdSjcJjMy6+AUK?=
 =?us-ascii?Q?CaW7mGBcM3g5jFMblsSDniT4fCxI9PUTZHrR/yxRgDuAhGupuPL7lAeo7sJF?=
 =?us-ascii?Q?k38icNK09nJedxxyrLXfuUAUSfFIYZObzFN/zySORpUFTLmzdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?efwHfqYwlwAxc7x+ve3+4P3W2nggQNgjfsWLPF7vfvJVTob1vmlnsPzAGGf1?=
 =?us-ascii?Q?wUK3Gd/vPGRoIegw7D2zQ9PBHg9JwbzCRMsTSz2ZPgYPXXu+AcN5TxAbzKY1?=
 =?us-ascii?Q?sbFWGqg72imx3stG5CDwQ2I1eyX43y2y1V/hl0NGSZNO3hVb2a5Er7CRuGjY?=
 =?us-ascii?Q?uZVRkzZ8ezuNHbkAHD6Wulfs8Ct+2DZ6bk49EnrTqTU4tBdqOIgsCU+abz52?=
 =?us-ascii?Q?U6MoxKpTYEbXdwYbQmo6YuculQUz+PJ34nBFT2At3zYQ0FdheopHM3B73EWD?=
 =?us-ascii?Q?M9gr84bs4UX/U33kz5vpFUFozDsg+qSsTgSczx30HKZ7ohBeIJh7phY1CPlQ?=
 =?us-ascii?Q?VRZVU+vYR+Z8w2bSxo9S6Qb2lSIm1II7YOBbsXES54lLbBcqX/JXK6EjDT9n?=
 =?us-ascii?Q?7Kml+kdKFTWOkyn14uZXsBcxS3zEQhattlZtWRR+b5mqu70+W5ASYcP9wvPL?=
 =?us-ascii?Q?KQvmKuKxYCbuPYHylq/3vRChQq8/cvp+8JIZ69TRVTdn9l78MvrtQx1kVo/t?=
 =?us-ascii?Q?HlPCUHEuxSOfw7oaatQws1Y2WY+ZPhCQ6/y5GRF2BCK15hm9wRjBhc8SVTC1?=
 =?us-ascii?Q?9y1PEPUqrzxuYzYu5TyQjnFYzPhQYp0S02xhxEGGMrQ/FAwCHzURPM88kbph?=
 =?us-ascii?Q?OMOwyFiGPpn3h8qyJKXBV5FG9cnYOiQwYIKu8KzSR7hcYV5dSan4jo/eMZvf?=
 =?us-ascii?Q?WSH5CUPJpkJAe0byFb8aUBm/p1O6r2WE5NH+s9/sLnH+0iSIcCd8XtODNgiL?=
 =?us-ascii?Q?RRYKnnMjU5jvkob7nTwCBzJQKeXd2AhbBFNaDplznMnj+bWRUieZqzj1VrRV?=
 =?us-ascii?Q?zpqTe3Vn2/szd5P/2cQdEayPhNHZsW0KiBYr0SJT+tf9r8h9zus8vtKc+2Zz?=
 =?us-ascii?Q?7Qa4p+r2XcRMwOzFzNZ3AEl24F2sVVKlbxGqOVAUA06VKFrcniqqVmRDVmvO?=
 =?us-ascii?Q?V0BgPjZlsYmPXLtpT3YOsAvnNPP90J7/BtJuAOxdb0OGNpXHizxaCFPzNz+1?=
 =?us-ascii?Q?hR1eIjYG9c/zlnZ12tOJLzLabxGRjBS5TjbWlyHDnM53ic/y5xp/Ygj8ravu?=
 =?us-ascii?Q?ehJ+aVVHCdD4I5eZyiVGjJk8Bxgd4WxZC54kE40IpUp7lYbhA0e7KMTxdKnJ?=
 =?us-ascii?Q?EtNplFIZteansFai7FUz7sqDWb5OE6WHsVhBqGu1WSFB/vuVLaHx8RPOdyfk?=
 =?us-ascii?Q?BnyX8nf/r+PLnRDApR0sjopEF/4ASqvhBPyAOvi4wT0I43sJbkr5FrUATRQ2?=
 =?us-ascii?Q?xgiYhK9hqFWIiyxFpQXcP01fA6LzLp5MDUASygFs78pQNBL3Ik+XCY3D2M6q?=
 =?us-ascii?Q?2mCEMjMtpHZUKCNlzuCuQ6RKNQ2C5G2fDrcsA8BWe7AJ5LNpwek3DVtfYtVA?=
 =?us-ascii?Q?qJFCxwpV7VVfcXNeHcu0M4naQzmbxQgyS2LO1DAkbtKJA7muZj/255lp2vjw?=
 =?us-ascii?Q?zuEj0IC15spYqxL5Sts1liy9URl3tEXigybeu/liPvFDE9UmuJT/69rK+62q?=
 =?us-ascii?Q?h28S1zfKuZ9xNnV99xvt5XeRxWsWRSuSuo+njONytLN4dwPTf3L09uodAbdx?=
 =?us-ascii?Q?cgS/FjvvcNWgtHSQ9RV6ap6OOwY6YIoJVbCWN1zf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1694f6c6-babc-453b-2cf8-08dcb0a1520f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:09.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ4JtfdPcEOFF3qsrsy1+KanKbP1l78tyrP4KXjnXl1wloxE8evkz+5XK6H6lDA54e8HufNeHjSq/KDBKEo/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

This adds the "select" method for Broadcast transports. It's role
is to change the transport's state from idle to broadcasting. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is broadcasting.
---
 profiles/audio/transport.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0a890c0ac..bf2215a0f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -972,6 +972,9 @@ static gboolean get_endpoint(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data);
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -984,6 +987,8 @@ static const GDBusMethodTable transport_methods[] = {
 							{ "mtu_w", "q" }),
 			try_acquire) },
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
+	{ GDBUS_ASYNC_METHOD("Select",
+			NULL, NULL, select_transport) },
 	{ },
 };
 
@@ -1302,6 +1307,25 @@ static void transport_update_playing(struct media_transport *transport,
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+
+	if (transport->owner != NULL)
+		return btd_error_not_authorized(msg);
+
+	if (transport->state >= TRANSPORT_STATE_REQUESTING)
+		return btd_error_not_authorized(msg);
+
+	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)) {
+		transport_update_playing(transport, TRUE);
+	}
+
+	return NULL;
+}
+
 static void sink_state_changed(struct btd_service *service,
 						sink_state_t old_state,
 						sink_state_t new_state,
-- 
2.40.1

