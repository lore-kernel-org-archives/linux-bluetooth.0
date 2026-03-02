Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011058.outbound.protection.outlook.com [52.101.65.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B413E5581
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459252; cv=fail; b=dyLrLgIOZDHBfkHEe7ffSDHOnEjDpzAMAh9G1rekM9FRGbweZdiEslNA4iOHxD28nkOsw9iBWhX/L4CMOqdONQXLfITUi2ZEKHdH7I4y0+MIieMIlqEZAxQcwQ+RRHzYXxy8089o8FJURnE4PH3y6umTsyLGlo8feRDSPnxRWTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459252; c=relaxed/simple;
	bh=kgtjbrsv6KA2AEdCfKSp7LJkdUvNPgXDpPyNAySd3q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpgGMYt+u0IJPjTtKkpKrMT2YmGZu/UHicHRBgGNAsEQPrsHDS3s8gAwga/qW2hJj/O5QFCkDRRAYqdsicJgYDyv6Lj7IOje3QHumRlAmKVyPHPOxs3/LaIl6BfjJgTlEeYUQNSqjtX8KajftEcTnP8D5+tbBTqsNRZCuwMy4Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=OiFrIbIg; arc=fail smtp.client-ip=52.101.65.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="OiFrIbIg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIaOyawod7ZpnBykUVrt3DcNvw6XvVsgJQbu1KRc7kJprmPncYOvHy3zeVFQ3QOwwbnTXJjRE/riqbieUoNoPWCDUS+T+egP1NS6WCcLj21jREqZDixXCk+L/O9SbCReKtsOOXy/Cq6aSfpfQzCCaBGvO7hXvPNE0++lUezysTqNV7kYz7ie1kg7RcPZP38LkBmYq0biTyuqTThuiTp8P99h4f0HRJgI+E7kFmOaAyO/h50DNQHRgH/RNUJ/Rgp85njuqFDPzIUtbKjfmCzWVHcgpAWeRCQG8Zs6SjorNoTFPu6XnnVeVDtcj6t8YxcgULP6d+uEQ/XVYlN1qgnPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eufmgWnX+YKE/julH5qK4u5iCZf/vajrYpn5Nn5lEDE=;
 b=Ge7ZQlIp+7S+iLpKlaIY8JOU1HWM2HnEadIxQfySKW/27hHbVjT2k8eue1E7mmuII6+vz4l2RMdBjrnGCtWXyOH87/UpB6RQAvIzgOa1AzQBTToRV57tkTdeM8+ZaEGqCePzPLlm8PgMWH3/0tyfEHlfT8191mbwH4bDHfr6JX87qUD0dPYwxaXyZA8ckrCSeACSpetTLrE+9Rmkms12ZbzNhP5ykGegAhx2zAbNIm6n1wfkaT/32ZTd7hFRH7EYWDlCfxbzJUAG+dz+03PHPh2rDyxX4uPdN20qRrXWS3T+pUWhkd4XqG0vP7YjKrmclBkzJhfAGtOXeq8ZErTIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eufmgWnX+YKE/julH5qK4u5iCZf/vajrYpn5Nn5lEDE=;
 b=OiFrIbIgLStUeMZUonGoRDXdj2bKR/BiHxcYg3DsMpqsTeXaJzH37vxKWMub1v/4Iiu1xG2dQcQy5l1wYgI3AUz/si0atYtb6vKuHg9wOWWBHvettSQhDtQJaI3iwu26/jZDvdAP+780IabIJkjYLTa6RTWBca3vwWTNyzcz8Ic=
Received: from DU2PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:10:3b::29)
 by GV2PR03MB11422.eurprd03.prod.outlook.com (2603:10a6:150:356::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 13:47:25 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::d4) by DU2PR04CA0024.outlook.office365.com
 (2603:10a6:10:3b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 13:47:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:47:25 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:47:25 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 04/15] doc/qualification: sm-pics: update capabilities in table 7b
Date: Mon, 2 Mar 2026 14:30:32 +0100
Message-ID: <20260302134540.25540-5-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302134540.25540-1-ceggers@arri.de>
References: <20260302134540.25540-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF0003922F:EE_|GV2PR03MB11422:EE_
X-MS-Office365-Filtering-Correlation-Id: bdebdef2-7493-40e8-e27f-08de78623cda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	9SeFoZDG3t2pZIbXC4xaJKhylYOAkBC6dFr2sgAhQrk95QeBKKEOOWqJFDy1uwD4/eBGeSLF5UM4+nlZ1msLxQZ3zeyG8IU+KV2/EBH7jxity6DoD8CoTSy9lb/JbtlXwCqRo+m/qKe8h4n/bh9ribpYr6fbrNHRa1L2pzvCeqWJps7SK0H+jsc9mBuJrkl4v9Z21ewSP2Xrg7xNjzq5g3yuZwdPL/KiO7QIKyj3UoUXFfqg4LFNGtbPYWFl4zMh3ln6vIY0gmZEHdozjeq0b6hHgzyrb/Mk5s26j4Q5GMER6EPmhmnqDlHxtfBO0pNGGRjFX1fdnT36O4SlxcO8SbjwRR7kqotB8LaIubDWtTi+sXQpeM9Z39Qc/f11NDMSm+4GN6qenCECahWTvt0TsQYMic7wk8o0EZkUc2C2V9PJj1nv0FYv4jElNbqlPa9jyxSRWxBAaQ2LGnJf+Qy7ajk0miPNafFoJOeynxSie2OtgoCyp4XLrlnqdfKewrGkpdP+lPmSLcYc75WPe7fRMPHEW7HEcU5UaZ6w5lfLjVHqGtqY2hkyD3QFStLTni8qN9ZJfnPu8qrcRuoh03XfVNV/K+smIvVBu83R+XPj5araErZyR7Aa59zbdI/rTfxKPAB+DD6uFHBJnY0V0QSzfyXqJXUB0fRbP8pUQQSCCz7GNIDATglKx86JYm4kf1h/Q1Tpp0Q3Fdcw8vs1fp7IPQyO5tUQPrkmq+fU+tF2iJodryDlMBR30Kzxn0rEJWzP0w9aPz1rs/KntkXcH78fM4OhEJq8cZ6jJAM87fG3t01V8aqdln6odbfIwcz3aQluFcVRiFgziXPWeiFQJep3ug==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+v04m3VEqda0/rpJZXAl4bH99bdIl/46Zhe2/gKwimpBNwo05bAO/w9I+GYmef30VmrqxnKSFVHadtVAsDTaifgdlhaNKIpxJzldooBLNZ2q8Q/MhzKz9qD9FP/VbpkfsAa6W9HeCt6xno3EaALYPPJ2tphccIiaRlRQ4GNRbFtZnEJ0tKbIoB9wWk4K7ZPFGLw6pQot6EQjL2B/StZO8Exl/RkiemZxrYuozgvTn65W86wwn7i1rQODZ7rhDEvQT23NjNF/003T87WaG6rep/9sDQaFyQlzBnWAM/oY3zQYTa6mw0f2r+L4sNqcx8Y4CjQ5qySZ3ZgUJOsHVX23ADSG8tGWR4LMHL/SYV1KV6Hm+rw+ZCGDcuPHPGept3Q6yQ1O21AvPf6p6yc+/Lo6XOdElOVvRQRmoTFPIy/hY8vCqJZjZNpwgeZwuogih1lk
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:47:25.5573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdebdef2-7493-40e8-e27f-08de78623cda
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB11422

Match naming with current Qualification Workspace
---
 doc/qualification/sm-pics.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/qualification/sm-pics.rst b/doc/qualification/sm-pics.rst
index cbf375a0307f..91c4f0ff449c 100644
--- a/doc/qualification/sm-pics.rst
+++ b/doc/qualification/sm-pics.rst
@@ -149,14 +149,15 @@ Prerequisite: SM 1/2 "Peripheral Role (Responder)"
 +------------------+----------+----------------------------------------------+
 | Parameter Name   | Selected | Description                                  |
 +==================+==========+==============================================+
-| TSPC_SM_7b_1     | x        | Encryption Key (O)                           |
+| TSPC_SM_7b_1     | x        | Long Term Key (LTK) (C.1)                    |
 +------------------+----------+----------------------------------------------+
-| TSPC_SM_7b_2     | x        | Identity Key (O)                             |
+| TSPC_SM_7b_2     | x        | Identity Resolving Key (IRK) (O)             |
 +------------------+----------+----------------------------------------------+
-| TSPC_SM_7b_3     | x        | Signing Key (O)                              |
+| TSPC_SM_7b_3     | x        | Connection Signature Resolving Key (CRSK) (O)|
 +------------------+----------+----------------------------------------------+
 
 - O: Optional
+- C.1: Optional IF SM 2a/1 "Legacy pairing", otherwise Excluded.
 
 Key distribution and usage
 ==========================
-- 
2.51.0

