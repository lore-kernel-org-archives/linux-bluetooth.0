Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012061.outbound.protection.outlook.com [52.101.66.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB930FF1E
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806172; cv=fail; b=DGT0x+5FJ4CwRhxGUyl1QtDTpBGv9m1IlNLbZ1PdyCCVgv/oASOxXjo0ZC4C63MqmFakzpAJVDGmJ7e1s9KYe8/+S5NeeClhXhkEBqmJvbMN/H8ymbsFjbwDIVN8Oxop7UdRFe7aHmZXqdjfEWwJv9XO/wMQs88vUav7pvO13wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806172; c=relaxed/simple;
	bh=mGN2f1t5LGLOqM8ZGa0Oo7liny/UBO+dskFY/AXQgKI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JTyZvxCJawULnY5UQQ8C0Xmx10pmmWtokwn9zWMArkeGHNcu/38KX3OHJYulesfyo0x7PF0jJ1uGNw7YYlWuNn8lndrINh3IifonF+JbeYCP2HRf1uPY58YI7i0YJo8KsSzKXncEw05/D+Q4oE/0WcnqBv5Lutc7dOLvRfxCb5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=esD68m/e; arc=fail smtp.client-ip=52.101.66.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="esD68m/e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUZmbklW3b5eUAdd3t0AQkw9WoOV9aAeb1M13TXnjASaB2zWmguNK55oj+RexEidSvJ0NpMwzH8rJEZoApkN3Q+zybGFpy4GL5aUb/Xm/DD0oPyONL5ll88ZMpi2NyebVKRU6MouQRrm5ub5wcyryl5HJlxpr8ve+uXvnk7uIdsybAue/VU2Hjx6TpbqDqFP5nddd7dwh+Clmmg5tjqgGJ8nO+P0VSrpzJASrpNDwhgeSa6ClYZ86/QZUr3/gkCzb1t8OBVJCJfi7mWz/FwMPUMHarGMFIlgXmW28t41nJQnav4vA/NZ2/ApK10zRPWGkrlKYFbVEpz/Cr1WacEwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk1m6Fa+iHnNDPBuZGK5QAa5emPQ5SyHxm/DN/SeaLc=;
 b=wC4EOnhbhLEyT0p2oKZ3oOP3Gqhby17N1IUvwDzPwz4q4NNPUpHLDYrQ5mCgz9P1n1dnIxVymqhO3kDdN//0EMIPH0KVjww4p4+jK00P6J97BYKBwRndMtB/WKftwr+vfstBhkripTEE+4fOVaZmBQtANCNA7cIzIo79du11NpAFHEPOgPTbOqbCO9IjXvkyD8gz94oAUYv9QVQdUHvmmw9CUIc3QsUo62lvsoU4q5BItXeDAuuGq6jCMnbFIpfIwicY832WffcWcl0DTauVJZH/7ivZ78eD00kxMLm6qIamMYhvSQ2nqMVoZdqWdvprwQ3sUKMKEjrxAb34ySuSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk1m6Fa+iHnNDPBuZGK5QAa5emPQ5SyHxm/DN/SeaLc=;
 b=esD68m/efbV4mX1JaLtiLOovLEp8w36vkNiYmO8DGd/hgbWp2fdgjkmvWLHDufS76gmMXxoSrBfbdRRjGvpTFRE/Tp5pFNHOf5sJ60Lc3wzTX4fGczelSfCP0/bPhprdXklxZdWRv1U6CFtzReL7FTGXuI1c1IKosEBQUfisd0w=
Received: from PA7P264CA0309.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:395::10)
 by DB9PR03MB9876.eurprd03.prod.outlook.com (2603:10a6:10:3d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 7 Jan
 2026 17:15:51 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:395:cafe::c1) by PA7P264CA0309.outlook.office365.com
 (2603:10a6:102:395::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 17:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Wed, 7 Jan 2026 17:15:50 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 7 Jan
 2026 18:15:50 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: How to perform Bluetooth SIG qualification of a Linux / BlueZ based product?
Date: Wed, 7 Jan 2026 18:15:50 +0100
Message-ID: <3679882.dWV9SEqChM@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|DB9PR03MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8cefcd-ce9c-4f33-32e1-08de4e10681b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9YPOPiKYjpSBTbuRBeXeLw29RNmWgkLCpdww3gx3MhhQym5AhKcNi67gUknf?=
 =?us-ascii?Q?3NM9nNtYX4o5LfE8RTRVeUft8Qiku5Muk8dWiz2na7Zs+PM8mmSqb4LXvAcA?=
 =?us-ascii?Q?Cqyuyz99I0OP0NPMt2Xq6zHevt1ikbahkBaHJoNWWL/ZHE6hpuYy4OBwYfre?=
 =?us-ascii?Q?IDXa72YguVjgsB0MjLgERPR3xHlV3/PnLOY3xEKG4izz7rIZz+x+XaDewfSD?=
 =?us-ascii?Q?hBsKMJhgBljl4/UCCfQUVRRpkOw2BMNMi+ukHgkdZHNyGmEVcFjq1OlRwtTS?=
 =?us-ascii?Q?S5fz031aJM6DZNDGhRegngRGaae8g7CGbPskgtCWxyd8lxS85uItBkEjFTGK?=
 =?us-ascii?Q?0O1zVRJCHfgXKf55FtvgUREHh824pKMlt5lvYYx2RMlPMwUC6Pdxc0vzNSyw?=
 =?us-ascii?Q?0MhN1EYjnh/XBLoatEPUuynU2+HJ/nJHRZSVCgXPKaKYb43uqTPkQwVnvEwr?=
 =?us-ascii?Q?4+6au+xveiyKqrTdW00TfauDLqYSZ1+GvdJr5xKlQ5xiIGbvtOZLf55ykCme?=
 =?us-ascii?Q?iYNEowYvWLL7a3IDnH77Ie6r9UGdYIyEtE5nx4BKBQUj2lIarmgWxNvCd8+D?=
 =?us-ascii?Q?F84lyOC6Pqg8gnvr5cU7ni2dGs5ZP9o2rAHGwx2kEOp2M0/ADGFVpwSM5Ecl?=
 =?us-ascii?Q?7Lerq8ZrioV730KbUtqvf2MLUu9itLJihPHpFJO+zJXcOrkxA6v/jHVcyuQA?=
 =?us-ascii?Q?dSiWqr29rpM5U3cjH21Z4BRm1bwkY1hN5372Qh7y67Bfa8Yo8youPfDmsmV9?=
 =?us-ascii?Q?Yob/NSqEH/S5QUfIr6gOpiSoDLB+Lpojbhu5edyXScKHB98X9aBAFU+wY5+s?=
 =?us-ascii?Q?Ylfjw8QVDLkCb3XONhFrnxoVXJ4IGkv+j734C/VqMFufjpUxS/W8mDTfSmJw?=
 =?us-ascii?Q?Zc1LN15PPATKgILmutsRD5RGCmOKIRN/Olw69vQQm9HWiJVaTJSlUCHkxEMD?=
 =?us-ascii?Q?M+JbtHeLNim5oa8Fjcf2gF6CODG9B0dW3x4pvnvn8Bmoxdv1MYtOPfyhGgz0?=
 =?us-ascii?Q?7fXCa6++LoZShavJZIQAcUdMsgpf4yEFqHrmLrnXQgGgw9a3Y4iiRmFrAIBU?=
 =?us-ascii?Q?30KFgJNw0Pgu+kncV7cvI6WSf//mT4soSzHGtS8ehko/MsI4yAgqvwSOqbBQ?=
 =?us-ascii?Q?kcHPJs0tcz3XYrCZFuJcutC5xSbfmNiMPkyknKKbbjjD7qBeRE6cKJln2BxJ?=
 =?us-ascii?Q?0OO0P+z+IBFbnBl0CaGkRkdq0+atb+HDJmwrD3PDXMrqwlLoUmKoPLFMJG54?=
 =?us-ascii?Q?IXmf76WARugsL1SBr3LDiEnY4xKT+Fa2DBKfZ5pWtFoDU1w7rlJIE9sIWpfg?=
 =?us-ascii?Q?99vbF1DH6Hukxb/eiOAbp/VEH3luam+dp6zi3HU4DqOQ4mVRj1r14glZQYvS?=
 =?us-ascii?Q?4tn0a8QWQzzDyxDPcaW7Pi0vn0ec9Eh527IkNLOEjLZzSurrLnE2EcEJ8CmI?=
 =?us-ascii?Q?NSR24OIODrK5NrKnaSjaTU/5NaoZAKQBYQEIEgD/rCGX0BUuaGiBBSMxC4jN?=
 =?us-ascii?Q?QKFRhjbPbfEnWhy3XEOfhxwkjNQntJDZeFTe59eR+IHgQ2ynELkfv+cw6es0?=
 =?us-ascii?Q?ioTAex4lP0El+of9F8k=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 17:15:50.5807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8cefcd-ce9c-4f33-32e1-08de4e10681b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9876

I feel that I can't see the forest for the trees...

I am in the process of performing Bluetooth SIG qualification of our
first Bluetooth product. According to what I understand, an end user product 
(Core-Complete configuration) consists of a hardware (controller) part and a
software (host) part. I already have a QDID from the controller vendor,
but I feel unable to provide the QDID for Linux/BlueZ.

Of course I understand that Linux/BlueZ is open source, so there is no
company behind for performing qualification (But I found one qualification
for Zephyr OS made by Linux corporation).

So do I need to qualify the concrete version of Linux/BlueZ myself? How
much effort would this cause? Google KI mentions a tool named
"Bluetooth Launch Studio" for this, but visiting launchstudio.bluetooth.com
redirects to the qualification workspace.

So how to obtain a proper QDID/DN for the host part of my product?

regards,
Christian



