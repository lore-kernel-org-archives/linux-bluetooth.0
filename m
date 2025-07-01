Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A3274FFC
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 15:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382575; cv=fail; b=Q3MPY/lf1uzgKl5Y0/eR7+YN3fm0rjwaTYKh2aFARSA8ONTEU+4It2H4RWGNulRMWzQ9OzhWrtLINiZlmVCZCIuy9LQTHWIkndf+KMBu0U++Ou2EzecBM22yRaO+Q20tnMrH0Z4FovHm5fQmdHUxNY8CPzofDlALFtJ9BqTxo/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382575; c=relaxed/simple;
	bh=p6fi20U3cZa68wViiB9Xr79ybX8CBu2B0roYlkUNmsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7k9qGMadjtsm+ap40fAvhv9Aibh0jcinzNHbcCMJ5XCOAAgXd7x5vn8FizaVuYfDWV7OTtqCZhOY+mlpmrY96bJY9stAA1+8+EmK7finUR2Nfrk2zd94C3EwQICTg2CC2Ytv1nOBU64tNhN1FPEaRH//E09D6q323KVp4+Hw+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=KHjCsZo7; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="KHjCsZo7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUqw+bcQEFbeaMzOIqEWl02bg0wOSjirnCMj8fXFWresGQYozzEbKVrMmzw1ibpvv9GRUst/EsmflvdFHuZrsqb+kzkxWvFraQ1isC0FTWNYs0Ar8awX/HzfTrKkZNewkAcUKOfkm/3D/50h8jN65orlHaAO0YO5kPDRwUX2WLHocsjOBQ8PcJFtfIec7zCg7uUlRqTgTF8Q0S2q6VYjwO2bgM8Kr3kCz6kMp9ySnAlHi5U88u+x78wb02jCgDJV3yicQR7gSr2DtC8he6aTKZVz1Ee3PCuZLFdm+Ga13cIQNdoOdAz0KSPoJdhib29MQTbBo9T4qY+uODldqJRZ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk613s+iR9zYjSoYnbQ1TlEkreubvFXpxxMfU9Or62s=;
 b=DLashks+VPnLLMPf3EFxD7YO2TYIJUp06jSYQnvyQVkHHZtpkDZa0vHgZLIRh7yfB3fUimo2kruKZ8JWsMqAd+7tBPqa1KoJ8xUbX9YgYJ13imjHQX9pYZx/pr9wVypczFzKEud/V3B7zENNLvY/bxp7G9l8rzpi9k4jiaC62GSUKbBd7OnCqRkxbf+aZe98s0QA5CUY2qkYAPWRpkNVGG4T2GvVKvO2/mL0QoodiYPNX1VghVMfSCde9ll/bCFuS5sH8zejQlERF/52n+944Vz2wYj9712c9IMrX0aQYjBIdK7JL/qj4X9rOMlU/3o6U0ZxLLC2y1gROy0Rnbqkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk613s+iR9zYjSoYnbQ1TlEkreubvFXpxxMfU9Or62s=;
 b=KHjCsZo74P+YXz6n/9wfCenJbw0MXfelcOFcqKdomeocAqVmAxLeQ4bZFCloTXGAk0AssRaqXDNOwQQW/RuvL/XJ2aECnLrh8jKApIqL1zdhUGyeItB5Z1fcUMRUhuUdq8H6HYVJkoIPNy7vzr8rIxqkpX3RknKXACWN/3CLhMc=
Received: from DUZPR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::9) by DB3PR0302MB9208.eurprd03.prod.outlook.com
 (2603:10a6:10:430::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 15:09:26 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::e2) by DUZPR01CA0042.outlook.office365.com
 (2603:10a6:10:468::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 15:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 15:09:26 +0000
Received: from n9w6sw14.localnet (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 17:09:25 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>
Subject: Re: [RFC PATCH BlueZ 0/4] Initial support for GATT Proxy Service
Date: Tue, 1 Jul 2025 17:09:25 +0200
Message-ID: <2200059.9o76ZdvQCi@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20250701144647.19572-2-ceggers@arri.de>
References: <20250701144647.19572-2-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|DB3PR0302MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e405d1-bc0f-4f6e-df20-08ddb8b14513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agCornXUug08H4Ptd1A6qJa31Bv1y9GO2Mr5JXbO8CfpH/BJUiMI3cxczJ1z?=
 =?us-ascii?Q?sfbA9/YP8Uwr8V1tkAGFaV+GoFcxQsbINchquXLRaYcqSrHD/00NXM36KgYY?=
 =?us-ascii?Q?YYWwcgNhlpAp0Uq+nyXjld2C7haWG7QYspzU4Aq5jUUjsOTXQVT1XQWX2lUP?=
 =?us-ascii?Q?M9PqVskU/jGsGQdDTX4rOH6z0lJLHevkycKu0KJCuuTJUms9ig1/AlnYQyvX?=
 =?us-ascii?Q?BOMEbjoj607Oc4LFYq5ffIORyNkGbNHv2Za9+KbVuOrOx8yD0BmxfO+Rf1iE?=
 =?us-ascii?Q?NUpEn3cMxcoD11EeeOt0lR79hgtLUuPSY+k7Lum/JccS1juuiJa69zZF4M1n?=
 =?us-ascii?Q?jKRwn+D9YMJyOEsuTsXY2d9M9aRv1h0VIlDvbdmUYausXjzLnxadH4m/29c1?=
 =?us-ascii?Q?JaBmU5nZhmh+wGcDKibYUFRzPHort19WkgosviDEfm77/fSDggfz+uEybfeu?=
 =?us-ascii?Q?cBFON0mp0Gy7Tmrm6zTUZ8HgmPOydSkaIkgDPcK6IWAUClQAlFoUbdtH6XlA?=
 =?us-ascii?Q?Jfxns6bXneM91w2dVPXRLXHMj+EvqTRGx4MBID48Fuebl6EQp4KU+ckR3zlK?=
 =?us-ascii?Q?P3jMNQ/0zqhO97VN/cK8/HM4boej0TXKBOfvXnvcscRUZxhypFjgVaJcts3o?=
 =?us-ascii?Q?NeosdfHNHT3e57TPui8ENQ6kVZ71x9E67rMpg6m/seDXuyuzFizFdN5xkidh?=
 =?us-ascii?Q?bToaFKvtyj1Mc1whFNxB3/maavjrLYbMk54jhK4zNrXaWRq4p0znVctGCqTG?=
 =?us-ascii?Q?YNkfvDNXd5xZbsEObLdHn6kjd3exFpju9Bxwha+rgta/WC6GUDFCnGxRkMVx?=
 =?us-ascii?Q?FI6XDXmMiCIO2xGfcDfbShj/lRr5DXQeYqEdUZdFJV4SxAifJJCZ/7SdH2sb?=
 =?us-ascii?Q?X4eOs4prw9wFsOM39JK1iUzispwx17M+0jSaH9UURufKDWThNzywI43yNHKc?=
 =?us-ascii?Q?V16kTIYjQg5BDh8GZgW0QuHAbavTbF8pnpIkrhO3zrTiP0lOhTKBi/b4ko3y?=
 =?us-ascii?Q?iHIvF77TAv6K4zxV3vj1vyfUs2XRNTQ7Rfk1UErB5mj/M3HV1OA0sXGHRzlT?=
 =?us-ascii?Q?ydUrCCyBCMy25QHDUAbCnfHWflshxnSCpTNAaOdDWewizTGvx0jlMQe0Qsm/?=
 =?us-ascii?Q?wV4pD+BLoqfJbAlg1SoXLR8VdtrLLqSDzGHm43cNhbI+KaHBgPEVLJlpgaYW?=
 =?us-ascii?Q?Z0iU0MOxm2MkINsvCmIWvTAdpU8YhKvtYJ7WwkL5eWvw1QRP/vACJE6lR0vh?=
 =?us-ascii?Q?Nof03rKHLtMKyLyZBgBU8YjekE7fkUnEG3LV0o2WznDsfoZBZ2o8rrrr4uOA?=
 =?us-ascii?Q?hSgyzI8q1L+YLJ6shv2WzGyPV6XPCfHWkDkKSapaIrokaezTISeZVNUCQn5V?=
 =?us-ascii?Q?om1D8huodkOjh7L1CcNe7mrQXlJ2zx/xRcZ0weK7UG9Cm9swO6I1SX+tLPl3?=
 =?us-ascii?Q?/F6PECYqy/X7oluyYguD2B/LtF/VJXZZpNSUO4WF/Fz5FmPFYk4L3RcMXYik?=
 =?us-ascii?Q?IY06JYyTVQUBpUXB5n3CMDU2rY/V2dYn4jNq?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:09:26.1739
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e405d1-bc0f-4f6e-df20-08ddb8b14513
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9208

I forgot to mention, that the bluetooth-meshd must be built with the latest 
master of the ELL library (with my D-Bus patches). Otherwise, switching from
the GATT provisioning service to the GATT proxy service will not work.

On Tuesday, 1 July 2025, 16:22:19 CEST, Christian Eggers wrote:
> This series adds initial support for the GATT Proxy Service feature.
> This allows provision and management of MESH devices from mobile phones.
> 
> Before continuing, I would be happy to get some feedback about this initial
> part (and about what has to be done in order to mainline it). Any help for 
> doing the missing features (e.g. relaying between GATT and ADV) would be 
> highly appreciated.
> 
> What seems to work:
> - Provisioning from another Linux computer via meshctl (sometimes I need
>   to repeatedly enter 'discover-unprovisioned on' and 'provision <uuid>'
>   if it doesn't work on the first try).
> - Reading the composition (composition-get in meshctl). It looks like
>   meshctl tries to connect to the GATT Proxy Service automatically after
>   provisioning, but I have to enter 'connect' several times in order to
>   get a connection. You also need to manually set the target unicast
>   address ('target' command in 'config' menu).
> - Adding extra network keys (Advertising for GATT Proxy Service cycles
>   between different network ids every 3 seconds).
> - Transferring and binding of application keys.
> - Using the OnOff client in meshctl (you again have to set the unicast
>   address in the 'onoff' menu).
> - Provisioning and configuration of an OnOff device from iOS (using
>   the SMART+ app from Ledvance). This app requires at least basic
>   support for proxy configuration messages (patch 4/4).
> 
> What maybe added later:
> - Proper selection of the output interface (GATT vs. ADV) when sending
>   messages.
> - Relaying of network messages / beacons between GATT and ADV
>   interfaces (in order to access further devices via the proxy).
> 
> Note: I don't use the test-join script, because python3-pygobject is
> (currently) not available on my (embedded) system. Instead, I use a
> custom C++ program for the 'Join' and 'Attach' D-Bus calls.
> 




