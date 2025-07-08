Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D27283FE5
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979815; cv=fail; b=IG2Q12O9kvy2eswJOprYYWhdhP54p2jqASy9ooScKZv8p1YfpI2OlwkCZTT5DL8kz2XhYbME3BvgkCUikmZ5dQWPu2t5s9jIBLIpGJrTAfzhg8AFQry/6uWLx7cL7b1qRq0tDhtiH8KJoU+IDmjomWnI2zPs/QKgyhosjIIt5uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979815; c=relaxed/simple;
	bh=pQqRwZ+t2XG68o4TLef8/aHfAebF91hIiDpsXAZ8TtM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sus4koNpEd8vvEZMn1OtpC5EDdkgFsEE9meGah1nh9Iidr9GhfVC0ywFTNVUuyMGxVVo3a8Nup56KQEIe5+OoBD9FcsHMKBAjq5qRUHJ5bFCmxa0Yl/Tfeb+tN5LmfP8GwtUE+sUY8ye1cHFsCNzBSL6m4tFPqxSimsn/P0plAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=cCNh05lB; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="cCNh05lB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZlyCXiEXlqYn+QoIUDXIInWPYuoTZEjtyZoPit8nqGI9OVOSr/qPLPQlOvctgCsqE0DzgptMBxmzynRyHEhPFU75urrjHD+wxbmAyDbbBcL/U175pFXgYjYz8dcq0e2STvwfVZdtEJekvpF1T1J4PCmjBCg5utxUzlfB61zrJfdIQaEi7juhngmPNrgrhCvFjtoGa0Du4BdWBdMwX4VLotit2mCu9Sl/i8kxQdJ8NJlXSae6jh9/DJNQ5Perhm1J4agpoYKuhw6lLyRHLc1LTI1bW9+HjGhSpgbWQXoNT1eMago6cg9VJM8qdh1BMOIr6RAzZD9WBddCCmlnef/YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3XdTM7Ud4RLh00l6NSWGigVHIgL6atiCVGfqadt6Cc=;
 b=NaUmLp+oZcIaL0dVr4PXpjzou1jRvSB2nwD6hHBW599Qslni3Y/32IQoIk9d4s/745mcR7XmHArOAtg4xr7VQ5IVXoIuPwozJFBQoQCrfX59Voe9EZWnEWO3IGRcmyThQxN3U5aX8hj1NQjUHpsn+BMTzm3bOWzbvZQOs1tzueqEDSAAlaZi5E28n8iJ/MUldE1t7eQhxW3I+EA+9/xqSpkcOD/lB6t6x4/YXa9zBDKYXkZqtnH/3yBrN2ku0BJ2oMPl8NrFsBp6pI9rur71I5vRjs/SJ5SJaIC98665o3/yBpTsXDwh1tNrPLy86saxYWpUrKX/gK14nZ8UAPhq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3XdTM7Ud4RLh00l6NSWGigVHIgL6atiCVGfqadt6Cc=;
 b=cCNh05lBkMrgU+HrIiS98Ybc6ikwCH9mWMIwOxiuBX8UH5m6K6az0yGsXmCxaruwBFC6VZQcVl54fXa/6kRYNuj2vW8CUZhdO5ci8HT6NMBgV2iwjyaJFzx607w7od8osOrSc1QrsTobdrJmlzFOI6RnKHpuQ9G/E/oSszwzEdE=
Received: from AS4P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::12)
 by PAXPR03MB7918.eurprd03.prod.outlook.com (2603:10a6:102:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 13:03:30 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::c9) by AS4P195CA0015.outlook.office365.com
 (2603:10a6:20b:5e2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:03:30 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:03:29 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 11/15] mesh: net-keys: remove dead function prototype
Date: Tue, 8 Jul 2025 14:59:43 +0200
Message-ID: <20250708125947.11988-11-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
References: <20250708125947.11988-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|PAXPR03MB7918:EE_
X-MS-Office365-Filtering-Correlation-Id: 359fe757-01ca-48af-171c-08ddbe1fd618
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kKsqyA7xvdMdv4gx2cKJxkkMa0daj9EV5N3HeDbxy4u5M3qo4fMYlQ8MmenS?=
 =?us-ascii?Q?u5j/4VxpDDKM1JBsSgE+5VdxBdt9mjuSVB6U8ugpa138PX86yNbbOP31kRt6?=
 =?us-ascii?Q?QYgifGcCbLdWvy5k1sOh7feie15/wUWUmei8uI88RSQtH+ZINe72xrApyMgo?=
 =?us-ascii?Q?8JiLu6tdnfcFjInv2Enp8LwxoVJNtJv1BZEDsRA5edynRrtX7mKlR1YOUOCe?=
 =?us-ascii?Q?nnVvG37pRYkWaK1Vyyj6EVijQbExxFfuaD2a6dpsB/rfHiQR+DH4OaBLu3AX?=
 =?us-ascii?Q?nF2D4U20TPE0bnx/qhZrgoW1EV0ul4Wfi/LtbsoT0pUQxTzh9Cbdeh/Qbsqp?=
 =?us-ascii?Q?tHO7HPv+bXoNxvYYm1ceXus+JI3ytai+GlT8iUgQ7K1U9W7luzNLdxLS4z+p?=
 =?us-ascii?Q?GedXQje5HHC59y9huH1wP7gLyKAokg2apRvUPpyRM/Tn5PacsHAUUpAW9/sQ?=
 =?us-ascii?Q?i9AHqrjDJpRXptVTdXMlUwUznot7ImVhaAzmrgyJv/k+CVG6LtlschJuZqGv?=
 =?us-ascii?Q?BOBQcDRoCxTqOflwWmDiJVpZtjvEpjiEaI5Vnj/9sZjFOakvhItG8fWHDRjE?=
 =?us-ascii?Q?zMfE9lb82XSdUDmflr/88ffIgoc52xuZzP80aYEX79EivM9LEJoMcQUaVJJG?=
 =?us-ascii?Q?aroPfaCPR0WIB5rbjWXLWkeMGT9eicB0A3IfRNpmiNkF2mbKi8u+++HoZptP?=
 =?us-ascii?Q?BYxjLOrBTOrxRx9vSBQSi19+agVv22U3bHpCjLJgfnzio93w0n9I5phxt10A?=
 =?us-ascii?Q?FytlrngDBRWiXRxH6o+o+f/9ijgYULewH6IRqcdGV/07ohdsuoCb6l+VaZ7C?=
 =?us-ascii?Q?Yx0tvtKtz+ScbghVkamM0EDLEGW2dVx1BD4DAnvs3KiEHgHcQdZVNBjSnDoW?=
 =?us-ascii?Q?WGoOyDcwAis+VPxuQQKfb1wY6PtSiLNzkhzWNcFbI2DnVckhuzMclF/8ZAkE?=
 =?us-ascii?Q?h1AlvQIQY/PvKa3lHH1x8wAucLYXSU4l48qRtlZ98mGkxfud39qeL6peEbFZ?=
 =?us-ascii?Q?bqlhFiS3gU8tvBFqr0hwMC9Bgk8zZZi1RxriWPEIzTfTF0PRHPZSlOj9r+cq?=
 =?us-ascii?Q?9DptXGM2BhX1/XW31L9acuS0pgFfVsMLys/09t2Xth4s9R/9kXDLlgFXYKva?=
 =?us-ascii?Q?LUYGpEjka4qG3trGoqkMv3ALPkj04XpHAC+A/RtsZAbczoivxWu8Gl7wn2HN?=
 =?us-ascii?Q?eo+ScQWgR1eHIrHKF/GUJBMwKnTl91p2Rdynkgw3I2T1f8ndH44B3kHWvxdI?=
 =?us-ascii?Q?1dmI3O+j/dyPNKMJ/LBY+UgK4p9sLUSg7wXxfl2dxjywMkoi/Il2/rpfA3aG?=
 =?us-ascii?Q?UsuySdlAu+V+4svOYdD7mp0NO+7STJ5wbieZ2QlDIKi/nu2mvP43sGEkqPUJ?=
 =?us-ascii?Q?N9DdS+KUZuOgMRvHsGEG17Wc8ez0vjcEZljESUVh8C1dX3RjQJQK8M5UJUiM?=
 =?us-ascii?Q?uoBeAIEfAstKfeF2sZS4H+bogQe39lh83XyBTwi8/JAqjv9Bxaey5f4eRNgu?=
 =?us-ascii?Q?a+4JzrFa+dzgnJmcfvKMNcnUVN5Jv7XHWyjU?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:03:30.1269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 359fe757-01ca-48af-171c-08ddbe1fd618
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7918

net_key_snb_compose() has been made static (and renamed) in commit
5ba57cf85140 ("mesh: Add Tx/Rx support of Mesh Private Beacons").
---
 mesh/net-keys.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/net-keys.h b/mesh/net-keys.h
index 61340dbfd804..49e01132cbf2 100644
--- a/mesh/net-keys.h
+++ b/mesh/net-keys.h
@@ -32,8 +32,6 @@ uint32_t net_key_beacon(const uint8_t *data, uint16_t len, uint32_t *ivi,
 							bool *ivu, bool *kr);
 bool net_key_snb_check(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 								uint64_t cmac);
-bool net_key_snb_compose(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
-								uint8_t *snb);
 void net_key_beacon_seen(uint32_t id);
 bool net_key_beacon_refresh(uint32_t id, uint32_t iv_index, bool kr, bool ivu,
 								bool force);
-- 
2.43.0

