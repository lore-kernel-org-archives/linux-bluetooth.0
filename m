Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A9C3431E3;
	Fri, 27 Mar 2026 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608464; cv=fail; b=qXmZLaCs22m2oC4PYEhGZOpSJvGabMXeAYDScZGVFdercmdNSHQsngJWebAi/O+iG8pz7fYUA+2p3sfO5e/Et0lnpxbMlu97lLS3jKOmlRRDWWpr0bc0iwngfpyxnG3FB5VsjptC3t8ND1v+5eNFBHP5XGp3WhZeTJZzmyWak9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608464; c=relaxed/simple;
	bh=XRVLvMTKtReq0bwKQAmv5BMb++2xkGiSzyepcDbOnVM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=lvbvVQ/rV5+LM/DP8redqWD7ZR/nwXLxshvXtgWSt3+VXYpiZr7BSfNRpREy8fRLd6UJk6w92uKTqSh/jBqkGrZpXsgUXOfYq09hgVBHJJIonJqSTZTD63TtYYXexEWgfj9Td8WGtDqxzDS2gdGOQ5jmAiBd/aZ1/twmi1okGec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=mMJ8Zli4; arc=fail smtp.client-ip=40.107.159.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="mMJ8Zli4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4KdyB2qVNvG4/9uOkx6DdPi/dnQ9qBSbk0djprprI/Z67l2PCwdnFBUPjANrA6NBLiQy+VKxjTGFuUwsZn/D8mS0Qbg3uF00L91ZFmDkLEPWW6nEOcrrCSZlQVDsytMcxBrL44FmSOUIrerI19WjCoEAokpWv6Q2MdQWPgARf0dZuBa9QQyXfP1a257TXF0gnf/DYOGU1MBKg9SfIUrBm+enRY3iGD1EfYlnXBuEqZ3g1TwDGHy8aStibR22FY2ardsQHcLVyFGtcqR3Z5vwk6wA8UDuGUMLvSmVZpxd/WvU+pZ878Lm83yRT2kW4w6Nzp+tvQGciuaCY7uZibUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpJrW/DW0A1V4/0EFswTv6mxQz04TstCuagTA07fTGk=;
 b=nNvZJ8815H82KpOWwpAl+lmr6bsMKu2oolO0G26OUnhA7/kS3WqGEu8m7SSMSbZsmNCcHGi/+RLB31Ikhk//FN41PmtCFqPh84oVgm4eb7kVcnZnTnMIe6XFY4l/kvU1AWouxqYLymQs+k6Hbn8p0GEa2VA3Q5Aoa/VpJLtqezVxLVWNYoT9ILTuixlmNYhipFFM/CcNcf8LxuI2okgcvlUnF5MWIpBwpTW20s1KT4bv6tcFCgSGdySLzYonfph2M5YKE5aKJitsV9N4U8CCnWSd9YUywZ2jKwfyVJvVD4UBpwulbIl2RxWuPUlneRjgjTsBy2+3ql+AvNiR4e6C/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpJrW/DW0A1V4/0EFswTv6mxQz04TstCuagTA07fTGk=;
 b=mMJ8Zli4/6yOGD8Qxk1flfxHxhTEcvDmnUOw+nV3if6Qb8BPstXgO3X+CPVP4BbRDFpIsj9Xj9T9HrD2kSfBs9edEbmyWU+FAQBZzLIALD0aCVOc/VjWcNUCJlw+PXZes40zaGJWERFq/VePVwfjY0e2ud0Sf4RaVOAaaRQM2mo=
Received: from DU2PR04CA0022.eurprd04.prod.outlook.com (2603:10a6:10:3b::27)
 by PAVPR02MB10012.eurprd02.prod.outlook.com (2603:10a6:102:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Fri, 27 Mar
 2026 10:47:35 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::db) by DU2PR04CA0022.outlook.office365.com
 (2603:10a6:10:3b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 10:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 10:47:35 +0000
Received: from se-mail10w.axis.com (10.20.40.10) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Fri, 27 Mar
 2026 11:47:34 +0100
Received: from se-intmail01x.se.axis.com (10.4.0.28) by se-mail10w.axis.com
 (10.20.40.10) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Fri, 27 Mar 2026 11:47:34 +0100
Received: from pc56869-2347.se.axis.com (pc56869-2347.se.axis.com [10.94.2.37])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id E1A0447A;
	Fri, 27 Mar 2026 11:47:34 +0100 (CET)
Received: by pc56869-2347.se.axis.com (Postfix, from userid 18630)
	id DC9E2602BC90; Fri, 27 Mar 2026 11:47:34 +0100 (CET)
From: Jonathan Rissanen <jonathan.rissanen@axis.com>
Subject: [PATCH v3 0/2] Bluetooth: fix race during h4 bluetooth
 initialization
Date: Fri, 27 Mar 2026 11:47:19 +0100
Message-ID: <20260327-hci-init-fix-v3-0-1b54bad4ef0f@axis.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADdgxmkC/12MQQ6CMBAAv0J6ds3uUot48h/GQ4UiexBISxoM4
 e8W4gE9ziQzswrOiwvqks3KuyhB+i5BfshU1dru6UDqxIqRDeaYQ1sJSCcjNDJBaU4F8dkioVY
 pGbxLetvd7olbCWPv39s90mq/I8bfUSQgcFQatJoetuGrnSQcq/6l1k/kfWv+WgYEWxaaiWpk1
 rt2WZYPy7kev+MAAAA=
X-Change-ID: 20260303-hci-init-fix-9657128a0104
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Rissanen <jonathan.rissanen@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|PAVPR02MB10012:EE_
X-MS-Office365-Filtering-Correlation-Id: 89228fab-3dc7-49de-a4bf-08de8bee41da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EtDFW81BPUZ5qX/HSuka27lcVYE0lMG+R2ctqdfHiFRSO3CmcZimadDPMjB+w1XxVE8vKEYPdgvUMKoM4Bt07XIfOGLv7Bw8u/hFwhVRudfc0r03bK4XIdxEqK60VPEcguklvWDfAKpcMoK70jPAjbtkfezsm59ezVbaEqltXTEIYGDEJ3PSuwxlnEG72RLVZSdOjTeuKj/1Xrh+BL43ARtUa7seOegGopeHjB3Szw4mkoB+h3Uk5Sk9MVGGPoXTqceI1CRnCD4MmqWUk6KD5pRnrMJ+bxyzyfHASy6YL1f4qsyV9kmrIXPEkXFQXTJX9kQR1H6W3AqQ0r1OkYRZDHwE0XIyI6kFr7Gk3TlbGCK0Bu7vYswIPleup7+nCKs9VLbhoIxqnjF6AP64kb410gPNeh1qTZafd5DUYYUQmEaiZLnsaFvk8BIDHWvZD9YMOA5cqGahiNz+uj0vPfR3gK827YJ8Fk8U5cvIHqvh+cliA5E1umPxTuiQukUZ2I56KzcMn1+S55ONMaKudr3CycrC39foxkWkCV9hgvyb/BZIQBb0Yv+qm7g9ax4SHi23tAbzSLfVHg2yfIj7eaYvXntbQAC8yCQtjHqtOwdhkQgEVPsEshumcgxJUUr+ySF7CapLHst1mHRXXcyoiCnPZqnVio3n6JeLeOjBymKnhwcU/XMjOtDlyk7mcKEziqbKIprO7kbiXgQdnpPeQoPJKZAJyusd34LcqYzLwVMZwxFNy0yec+hQCsPxud6joVyzL7K0aBRCKye59LbMjZcQKg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	J5LsYi7g2eBGsVnVmX4eP3JL/BUEC060phxkbF0lN6Pr74CtAaBiiTzAB8+pCm1v2z3UdapPOebJ4hbCX8xNTmmuACDbUjxIEc3JkOD/aba280TOIs7aDR0fOtNOFU8yQjGcS8JLMJ9Xxaa8r2IE+1H7P5XzYMS7ogTe1ncN6GSVeY0kd/kgLukG8sg8GgLHgP4iu74PRd2siOb1n+yQZ4BGhcwutpbgkPz/bRqOYWb/+Yucd5ChTGK5Kxrg3JSla/BXVtFfZYuJ7fIRrKBpY7regYtsayRIkBIp6zLlPp8HbdS4TwzQ9KUnMT+ov1WEgy4B/RGukQX+baiqazu8W5BsPYKWXhBSCSdIXSnoWFSG4FOTky+PHnkJJFk2oCyCrH9G9as48kWSWgD2ZkyYUHtqylrsWalWSnhK1s5bxpp1MlunfKfwW47jeyFeh5sZ
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 10:47:35.5999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89228fab-3dc7-49de-a4bf-08de8bee41da
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB10012

Hi,

This series fixes a race condition that causes hci events to sometimes
be ignored during h4 initialization.

The first patch clears the HCI_UART_PROTO_INIT bit if device
registration fails. This is needed to prevent the second patch from
introducing a possible null pointer dereference.

The second patch contains the fix for the race condition.

Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
---
Changes in v3:
- Add "Fixes:" tag to the commits.
- Link to v2: https://lore.kernel.org/r/20260326-hci-init-fix-v2-0-a974211d0224@axis.com

Changes in v2:
- Added a patch before the fix that prevents possible null pointer dereference
  from being introduced.
- Link to v1: https://lore.kernel.org/r/20260320-hci-init-fix-v1-1-e1960a41baf2@axis.com

---
Jonathan Rissanen (2):
      Bluetooth: hci_ldisc: Clear HCI_UART_PROTO_INIT on error
      Bluetooth: hci_h4: Fix race during initialization

 drivers/bluetooth/hci_h4.c    | 3 ---
 drivers/bluetooth/hci_ldisc.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
change-id: 20260303-hci-init-fix-9657128a0104

Best regards,
-- 
Jonathan Rissanen <jonathan.rissanen@axis.com>

