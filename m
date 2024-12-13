Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A39A1DEFE5
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089495; cv=fail; b=HXDQwo2W3b7xY+I7bJSpr57uHnBFymjeBn9vrPEZOOLaeS9sXYlCqkou13TXsKsVusBq0IEE8j+crhCASlRAQyo1ajopg4463sB1quV3WfBIJ2Ze84I7wnOLqiusKWJF+ZglmqcPLuqLYU7I65WX4UIIf5pCjraZ1OumxzauO5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089495; c=relaxed/simple;
	bh=vyZ1k4n+tawpybI43sjI5Vp2+eizGmiKOtNr7ZT5ikA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M06hiwJpVoYNFiI82uClZCEIBDqFjmLe2+e96cvvybMKDKSyjzpYdWpsTgnIRy3q8D5/V09v55iDvsIqIJ08Uyi0fZZ37oSfoLiV+Cyk14jWGwCpIQpy0PXvKv+f4xuoeyy//9xl/q7T0MBEv8+45BCG9H28g4NS2JZQnvCJPU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dbtcFxEU; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dbtcFxEU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vadm9pCl9OBPvCuu0pF1Y2CnLT4GMrKila/pZ90VgOFDVKIpD2ZaBs+uM7S9Kt+ZnCvzuwChPX3ZhthcpWvjfShE+ZxzhLFT22EA4ZTlGEeFfYlZyUc7ELAjUnKDVOxlenKsjWoxowcoV4W5Eny6kdKq03ZpiZ+ncTNEBydno0wQmthr5j2i5dGtq4dtyN0mbDdmbXkE99vgrWLba8BR9Dzo0rS/cxVBFgvvApSkBTZ4g9I9C3dFSzF+SWm19uLPD1j2xnD4ImI0kVFOmqafKvyeRi97rxlF5XL4VhYS+GTwtr02EyrHcYmk2Qow19naaKyTykbOiiEUsecpYhdvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCPxnhjEwq1ubtQgQJKFrnwUoqGJ1M+mgrGHPvVGImY=;
 b=M8qwq96r3Z0dKtnHvdYBWSdNUzE802fdIPMSYsDKBRvGxK+eL1HDl1QauqcVP47bxJ0/uGEh3nBtch0ERYaCVnhO2TQFfEIM7M/VcNOPlQFWKKyatOCiM1FHHqIw8WZ3Cw43wzRuf1kyoIDNuS4UdtgXsVBY3/NZ4KLeooeOKABVY3O0Xuf9rXXsy5teldRVJgmU2EIvk9FXm/mOunXoxTGQ8bzgqujc+bzh6QSN5VvyuhV1WNf0z9ynP1MXgJTdjHfq3kLZJzRDa4ScFY6UQ/QxwShFxLcmQcSt1PSoenspHlyYQiGNY7eilzOE58SO+OM/qm7Trdc3tMfY0+561A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCPxnhjEwq1ubtQgQJKFrnwUoqGJ1M+mgrGHPvVGImY=;
 b=dbtcFxEU6K+lUPpdKBAuXewXA/QGBVKpaYmhIEu0gqTVDDsGpocBxmhTpNqWlkOs7W92SJb3KtpBi7wLlGmn7MQtWWeCuDNELiZfjpaonBKGaiDSTG3DGI/q/jMbu3z3NnkdnsvNyBWHAX0u3qCstZN3f478rZcOcAcLKjcI3aeA+02BKBZmU7635seCUGn7B+ayOPxTbDwZUxlECc2xvYrGEgGAk1N5nu15pYHmBCLMIc7ZJq8xW1hcH9sMHV4ofLkatSQbWF3C0zZdv66/LtTTDAFRAidsPP9/8P/MmcjoAfXh+Qfw+W+xdXI4T3+e4wiVJQZPusNORXvsAHHkPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10438.eurprd04.prod.outlook.com (2603:10a6:800:21b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 11:31:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 11:31:31 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] client/player: Make QoS sync_factor configurable
Date: Fri, 13 Dec 2024 13:31:12 +0200
Message-ID: <20241213113113.64818-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
References: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10438:EE_
X-MS-Office365-Filtering-Correlation-Id: a85d23e4-7f2d-4f45-fcc9-08dd1b69b12c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2A4biMb+SBMdVVdRqK9sVAwHqURG6oS+5Dl1PgqPZ6PfNxqA1tRk8s0EqOCs?=
 =?us-ascii?Q?TfyFIzq4n+k1vYsMnOuYhwLkevzhIxT9mVwyiwCNF8OekA1VDlxaUuqP5l1r?=
 =?us-ascii?Q?czbMrqIJAh41WkgWfqRuXQ/18Yk2duRiIeFAVvePF2qacFSjcI4L9CCHmM59?=
 =?us-ascii?Q?beKV3eT47aIpLELEQAu8DtVk2C2O0HK/c4liz0t19lN6PPsT34EN8pYOgXUc?=
 =?us-ascii?Q?co5Bm7iN9/Mzx/hVJfpqPKYlysVyRKkK3KYA0WVuRi/+NMyC7MouB4x/fVvF?=
 =?us-ascii?Q?pVdZgfQZ7OSX09BCPmdE0P8LTmXwo1CT5NKrK1YKv5/2/bkVUCB8adGtaeMx?=
 =?us-ascii?Q?h7G2LA393L1vdRbHzzWqRRPu3mi+R1QQsnqAGMitqR4vQ9g5l31+G8kvYOs6?=
 =?us-ascii?Q?DUAd5o6m4e+AzJ0kgoiNVyAgDo9Tqv8UzCDEa5fz6brjo2Dsum9Bck02hZeI?=
 =?us-ascii?Q?yYywG3mkbnTuZy8xL3uY/pP2uAXnlOjLglHObN+QTpfjyVhr+dFThh73Ft7e?=
 =?us-ascii?Q?P/c77KXE3s5VUqglh+uxL80n7kI4Xegmefw5vIPhvxPxN3C4GQMpuSRDaM+x?=
 =?us-ascii?Q?/wlfVGgSjid0fhwH5SFexpUa1s/DPXZof/8CG9x7XEWqS79SJ9/i75sh6OVR?=
 =?us-ascii?Q?jDFwIGcfSHldyX4J8H70A9jJNVYPEiOSCWG/GgcjunDtTn7bYjmFRFv/pRY+?=
 =?us-ascii?Q?4Qq1B3rnNsg0TKmMPqCcGfrI8DnbJ+3g9cA6dxBAqYNFHq48eDcWSxU9o7IC?=
 =?us-ascii?Q?4TOFPBtnGSE6Y20DCsHYfhzIYA9bYKlS3JaE2OZ/anZT8aVwp7GiFFpDeKyv?=
 =?us-ascii?Q?k+SmS3OykJXVIQtbfW813w5sPZWTXYUgZpiT3qpCx1fzY/2eW8Os5kc49Si+?=
 =?us-ascii?Q?tAhVcYRhxEFmaNMgzgfviaVgSBO1MqMRMjeVhB+nDtqDY273dWz3d/JSNcx4?=
 =?us-ascii?Q?aP8w1GiWcP1jKra8YNXejkvQpocPmk2Cu/LekAw2hE0YYZn3Rm2AXsHjNLRM?=
 =?us-ascii?Q?f4rFwcNdaN/rLc1jH0aApnHChW3yFU4gCFe9d8qXC27s4yJbE3MUhlUeCki8?=
 =?us-ascii?Q?acNvDeRxZRDJfxNNbYDmACV/9d1ofPWdjSRWXuLsqLQAtNF0TQ6Cs41bs3js?=
 =?us-ascii?Q?Vmm/x54eGEhuMyJOyfqj7Qe2U5SXz1eLGi3ftJjWQvXdgr7yDXlGRtJmRnM1?=
 =?us-ascii?Q?V+uPTww3EZ+PtMq6NXpO0xPO/Bx1roPArvV2X/YPG9U7Yw8UmmuS6+dKUcRT?=
 =?us-ascii?Q?pUePFaH00gj1uyaHC2dfb+Tljv6cvCdTfaZe3oCDnK/f2nZRDOzXXGBJHhZY?=
 =?us-ascii?Q?xHFFzZ5ufc52UGMC5/fzQejm4Az0xnZuUwOV8Spz7stAbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjRi6VKmL1Ds0zX4FNfpBFiKhH+zV7m2Iv8n62B9x7FYUcKNybiE66Yvqg6s?=
 =?us-ascii?Q?yuU5lGomvH3/iLEooJTYQytzwp3X/KRgAb1Qgm5yC8Y1tG++XGo8VhV/4dfn?=
 =?us-ascii?Q?4fTZC3aMuNRywG3HLEglCSBA+qhTb2hC8D68iXc0DlJx05lH89BjFAG9CUuP?=
 =?us-ascii?Q?RkI8Jj7nymYWtYok7JXsKqqgcK4i1iVeBfcpaRrcRonP6p4a7q/mMQzzY/1s?=
 =?us-ascii?Q?1fFpNkhZXDT+36tRbHeZt8iXLJx1sll/4zGVsQscEN3M02F/QFufDvab5TFU?=
 =?us-ascii?Q?3PJ1+w7ZiAK3Pe28w9ETHzXoet37yIv2cN6RA7DgLR4aEBO05vxeUuNFHiMZ?=
 =?us-ascii?Q?4lfFVcicaKRQyEtCDIFHbfGDfG2X7g4gpS1RN/rx50W8gxFhFl0S2/yOEei7?=
 =?us-ascii?Q?g5sVedxEwoaqm7Syb8dTVYO86SJ8vbUqcp81n2ZQokiN13SulrNev1R8vHTW?=
 =?us-ascii?Q?uR0zPlxggpcTBuBQQxOZ2VPB2O4CKZAiWT6bXga1DwAX441luRPkKqsCvjEB?=
 =?us-ascii?Q?dT7aIgkIGQhHQkNLjYhvn/1ARlWCF+xaLGNWtRP7RZyehdJSJPqZ4reonSZ9?=
 =?us-ascii?Q?2U5Dt6TdEsqp4HakwEOmPobh1TCQJ7VOJyhodTIUmrCFmWTgosZCH/0VlXSc?=
 =?us-ascii?Q?BzxlvJvCAvc8V8UxJaBAaqk1wAO4xNgvp3bsQmb7nxlBlMT/mk9DvwugN3qg?=
 =?us-ascii?Q?3SQAm9G/y73TghwoRC//G9uGx6WS92o3QAM0LSV+RBqi2HPam/70NZrTSfPI?=
 =?us-ascii?Q?DidsSVMPi4gAUcv++iayvkols6SXM/iq1dR8yNhHxBJaZKPcjeBQg6JzZNP4?=
 =?us-ascii?Q?WZP2l5kAy11XhFMxvFsiSMHmDn3sbqXfMP+Sy4V1p9pi6LgDohXGmbJ1mPGs?=
 =?us-ascii?Q?96h6ItDENAHin2mYqqaYUr7nJrCsGFqqfs1yqlKpIpIbEG0sY+7idpNE/moM?=
 =?us-ascii?Q?wXyzHm9baLeweWbj6pZsrXn4GYnvMmIVdD/ORToAaeD9p7djTLTV0QABT+6J?=
 =?us-ascii?Q?qJQOfCLHDc6ySVXQrCfpVl848D5EIYxcBCXw8OIMbTl1JotdHUtI24Fo05Xr?=
 =?us-ascii?Q?xTVwp/JGiVYB8uh2SqB/7pTGISm5dK/usVKG8QK6YjrbBNbRUpSuM5o6cpfH?=
 =?us-ascii?Q?M+HaalMaz+1kYvadJgzScWJ32yHoJUCK2VgIrJAlOyKTT4CdOOPNavfTauOa?=
 =?us-ascii?Q?P+wYb1lRruHdKUYcBh0sgXRwOjoqibwCUVR9a1WiXoDel5pHPyi5gtDokQsg?=
 =?us-ascii?Q?Srg7jrMgpZSV1ngIIiXwr1YNcnDWoZCMmtKmRXltPD8OrfwgoGApqX3/Ti02?=
 =?us-ascii?Q?FrDPnAy8qdIpFB1tW0tja9LmAUXmswABaM0fRJN4Bq0hWG/obSk79no2p7/B?=
 =?us-ascii?Q?UDnWXQ7PoJJpKiNuf1rdZalL9IK79aJ0j038qiVz/o9tex6stjkbrOonSs4B?=
 =?us-ascii?Q?/B8FApms87o1RzFg8O4q6F/Y/+3TgekWx2QvQaIhdB68GjPnzqjnLkZgTtOg?=
 =?us-ascii?Q?baXYgT6BrKAa0xUdnsw7cadlEniHM+a8O50V+kMIemRm6ftslU8WSiPDstqx?=
 =?us-ascii?Q?JTrvtqlK7YxT+ElLXBoahr8zmB+FFFVPtxb7PDPW8w1idIP2/UNA0RFZoBIK?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a85d23e4-7f2d-4f45-fcc9-08dd1b69b12c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:31:31.5989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9Xy0bD79PLvWnoAtpdARLPE8DEtJVbt58rNEvf091I8zI/YIDZxjQHukJtnsEG98HrMXVlK+e8WEW+5BjTuGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10438

This adds a new user input prompt when configuring a Broadcast Source
endpoint, to configure a QoS sync_factor value. This is useful for the
user to adjust how frequent PA announcements should be sent by the
Source, depending on scenario, instead of always using a hardcoded
value.

[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
                             /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (auto/value): 1
[/local/endpoint/ep0] Enter sync factor (value/auto): 2
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): no

The PA interval is chosen as the BIG SDU interval multiplied by
sync_factor:

< HCI Command: LE Set Periodic Advertising Parameters (0x08|0x003e)
        Handle: 1
        Min interval: 20.00 msec (0x0010)
        Max interval: 20.00 msec (0x0010)
        Properties: 0x0000
> HCI Event: Command Complete (0x0e)
      LE Set Periodic Advertising Parameters (0x08|0x003e)
        Status: Success (0x00)

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
        Handle: 0x01
        Advertising Handle: 0x01
        Number of BIS: 1
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code[16]: 0102680553f1415aa265bbafc6ea03b8
> HCI Event: Command Status (0x0f)
      LE Create Broadcast Isochronous Group (0x08|0x0068)
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e)
      LE Broadcast Isochronous Group Complete (0x1b)
        Status: Success (0x00)
        Handle: 0x01
        BIG Synchronization Delay: 912 us (0x000390)
        Transport Latency: 912 us (0x000390)
        PHY: LE 2M (0x02)
        NSE: 3
        BN: 1
        PTO: 0
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 6

This also updates the broadcast-source.bt script, to include a new
input value for sync_factor.
---
 client/player.c                    | 30 +++++++++++++++++++++++++++---
 client/scripts/broadcast-source.bt |  1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/client/player.c b/client/player.c
index eed8d2306..f93c9d908 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3724,7 +3724,7 @@ add_meta:
 			endpoint_set_metadata_cfg, cfg);
 }
 
-static void config_endpoint_iso_group(const char *input, void *user_data)
+static void config_endpoint_sync_factor(const char *input, void *user_data)
 {
 	struct endpoint_config *cfg = user_data;
 	char *endptr = NULL;
@@ -3733,7 +3733,7 @@ static void config_endpoint_iso_group(const char *input, void *user_data)
 	bool found = false;
 
 	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
-		cfg->ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
+		cfg->qos.bcast.sync_factor = BT_ISO_SYNC_FACTOR;
 	} else {
 		value = strtol(input, &endptr, 0);
 
@@ -3742,7 +3742,7 @@ static void config_endpoint_iso_group(const char *input, void *user_data)
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		cfg->ep->iso_group = value;
+		cfg->qos.bcast.sync_factor = value;
 	}
 
 	/* Check if Channel Allocation is present in caps */
@@ -3763,6 +3763,30 @@ static void config_endpoint_iso_group(const char *input, void *user_data)
 	}
 }
 
+static void config_endpoint_iso_group(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	char *endptr = NULL;
+	int value;
+
+	if (!strcasecmp(input, "a") || !strcasecmp(input, "auto")) {
+		cfg->ep->iso_group = BT_ISO_QOS_GROUP_UNSET;
+	} else {
+		value = strtol(input, &endptr, 0);
+
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		cfg->ep->iso_group = value;
+	}
+
+	bt_shell_prompt_input(cfg->ep->path,
+			"Enter sync factor (value/auto):",
+			config_endpoint_sync_factor, cfg);
+}
+
 static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 {
 	cfg->ep->bcode = g_new0(struct iovec, 1);
diff --git a/client/scripts/broadcast-source.bt b/client/scripts/broadcast-source.bt
index 6da9e23e2..1b918efb0 100644
--- a/client/scripts/broadcast-source.bt
+++ b/client/scripts/broadcast-source.bt
@@ -6,6 +6,7 @@ a
 4
 endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
 1
+a
 3
 0x03 0x02 0x04 0x00
 transport.acquire /org/bluez/hci0/pac_bcast0/fd0
\ No newline at end of file
-- 
2.43.0

