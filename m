Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8444B66D
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208044; cv=fail; b=i+Tb4RcJtB9Vut/vOI+41GodA5HLVJN/FyiwZbWx8Jmc9TvKxo2SFaHzMwILyIM6MPnUSDCwQJJnLZuZD68FC+xBVVsplCkBBGn/HFHC64ko9dE9rIKPuK81RqjZK/cnlKwFM6m1l9FHL14g0K4wPy7N1y72RERIzSecpCCya8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208044; c=relaxed/simple;
	bh=4weRcJpKFjoUN5Eimt1ewBts7ckAk0r/A0If2y98KfU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DLU1QfvMOBol6mq27CCkHVIxN1tsDzbl1CMder9wpGTmC6aBw/SFzz7CgPktfa6cPBoHZA0Gceea2Y+KrXW2rnPbQ1uRMdM1e/nAfJyAPcXLYJr45D1Sv3NoYcTdwwfnGBo7ngQdNthtZRiQCPpKrTm1fEMm0nVcHs0g0vqncEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=MBTvaBWI; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="MBTvaBWI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTTuMbOCoQX6ArBZC/bEYeP3Zs7gIPDxbTVLU+joxWtk6O/+akJI+IzEfppTiVISVqWjNFJTwZbdH52F/2tdtE+F1eY5Km1/PQQQCUxrToxIbTotCC7KhEIWL+oirlwtPQ/4YOQg+7H6doCRqdBY/7diO3ulr2Vyap9Y00I+IE3FR9IkTXqy/M7lLwhCeIw2dBXF5Iw67nVfggP5jEZKZ7KA8jd8F1oI1lCn0BDPydSrtW8DsqUDRotf5vpM1hER90GOEAGNTzqMM5fK7x1KOiv+3ENxAa1l84OrUfBQF1ke04d70ii1xrXE2dx2xuZfPfICnnrFM6tDV+/tx4muXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWCsYKZMub3lyyFWr9r9+sISPkA6efuuwhFA31PYHAk=;
 b=n7muYHn0C8CeKW0SNRWLPK7fMdPQC+QPx5opZCHwC4kyOFlGmqxBGDDfdMUB2kEiJB91E7ETd0rBB1Drj9NmlYMkbTexvkzoiXFBmeRN+kF1Qu/eodtoYqiVI9Ku1Okhrr+189rYW09yQFL6AEC3mTC/eI0tvYrd2TLy13WsCSBOVcMLRBklbkaiAae4jbFTVqCjHrQiNSf1DwOd/gBfHr2lMfbmxxGyXipSlpddkKjgs3IwXVh+5agmCMeuNTrOQYCO0yIAkkm6yFsyqDoK5qtsaO6b2nfNv98Mq7XpX/xeASqHRNdSxz0M56Ni9BQeCNsOZb89/+d4y/35b9GpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWCsYKZMub3lyyFWr9r9+sISPkA6efuuwhFA31PYHAk=;
 b=MBTvaBWIslo/nkJzBueI4RY5c5ZSOGKhrY568J/CJN82kUHiEKff3vkq/6GmkfNh+fd+XSY6YS35rm5mcLq6PaFGH3h4M+YgpGqFeg3dN0ryHSbL+uzCkwRghjzNkZPsUzclJ8jfs4zeqeni2ofaKTat4RY9hhJgdSilPHWSxgM=
Received: from DUZP191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::12)
 by AS8PR03MB9983.eurprd03.prod.outlook.com (2603:10a6:20b:634::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 16:00:37 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::68) by DUZP191CA0045.outlook.office365.com
 (2603:10a6:10:4f8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:00:37 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:00:36 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>
Subject: [PATCH BlueZ 0/15] doc/qualification: Updates for TCRL pkg101
Date: Fri, 27 Feb 2026 16:53:46 +0100
Message-ID: <20260227160022.21462-1-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|AS8PR03MB9983:EE_
X-MS-Office365-Filtering-Correlation-Id: 311035d8-4aca-4332-9e75-08de76195919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	hKpW5CT+69eDVfPsM3HhjBnHDaOTAuNYoCIUk8gx7MgiujtAStEffq4+G/RAVbMcHH+irtF2pOe7KyRq68lpd/FJ+6Ffet8zLS+V+F9e+lR47N8Hd8y6By8BFLlUCmu8AS7KWjxbVW9pV+tWtJGFEsrVBkfnTUpJ7zBe3Z0it6aO+Ytx+Fim5wVcBey41ts6vuVUKznMi1E3Ovx+du8VW8YuXnLjAHRfaJJTaKXaRkmOP6nLziY6m+2hd+XKTQZ+1E4+iqD3s5iq4aS8xDzrWUArLJSSCVRgXIa0BqWrqp0OKjSRcCYhadkCb4bg6YX3iRRtsk579G3JSbuEJ/lTKDetA9+1pWAv3oiyLiAnMDkboH7re78KkvLv5P3nsDsejUFqmDRbkrrd3pPuXNHH0PpNRkhKXHqNq2GYNMhJTs41DDLKhL6cxn+V3xdaossB7++pmE880HNApqqj7LAicOt+9qLrZ4yIrZmryc4sUMS6dVWh2rJKAwvYiP1qZZQ7D0KZco+LO0eCFFqW1bnyz3oXtDfPLrif4jnxZmt7FkyV0mbYiCG9xSWqH05SVLEX2w0UYL2DGUxatPLJYm8UYZWeCGzGe9HMx8VvFWo+2Kh9nsdsN6M8iCsspRp/zvIW3E2jh6ZUpPuuxueb4cQ1CejEEbK24ueJFuQPbfNdiRZngYkLEF4JuGJsNb+YAEXrZMTeICFF0hYClOdU+39+q3pX+4gD7WOamXX2pIYTWfpkNBo/itt/Gzx7Jmujvt0eVAwQJ2Dxxz5IWzydEjhMu3P6t3/t/15vHzgcFnZ1zdWqvw6PkG1VAW+8+RJlaAx5mWD709N4rhJlB+6hTm4W0A==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MqY8fOKv9K+d2uI1RN+iI2XxUYqxriC3WjUy2ANSs9mwmLJIZ4abgybuCAOe/VJNDo8OngazL0YPTih/xzGogqSIqSvYWG5AugLmo/9EGdHD3CMKHD+0xVT/kB7Ns6H/eZ+rjysWvMBiVxCX61glnOktyN3nXJbcon123pwWpSXyH3SOEaMQr+00/5y30qr2ivDo0LdFSHgFD1BR2nHQWqzZYfS8NP/qa6eU4DgI6X5GbMrfyLVso3QcJZazOYPD14/+3kHIdBSDfg8Q2504bXLFmguPDPyPmgtvHLLt+ZsiYEyWEElVbMCW5x0Tyx8W1pygOzd1FkDLnLU+3XCbJ6jTkWWyR3lJ3ds138GFjDWb9R1idltBZ3vggdRTwDuWNPcAVYI1IRvHbiapYAQM+nXgyetzZsbTvtCLbNz7a8Zx25XBJnefnxtyKwQTwVxo
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:00:37.2721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311035d8-4aca-4332-9e75-08de76195919
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9983

I am working on a qualification of Linux/BlueZ for "LE / peripheral only".
Due to updates on the SIG's ICS/TCMT/TCRL, some ICS options and tests
have been added.

As I am not able to perform all the tests as Frederic did, these patches
bring the documentation into a slightly inconsistent state (as I tested
with a newer TCRL/ICS/PTS version, but only updated the test docs for
the testcases I actually ran). 

