Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D303C943B;
	Thu, 26 Mar 2026 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519171; cv=fail; b=XDDyIYGFbtS4k3shLoDQ9A3U5f6cBXR2Wjznj6sZiYzHPUEcJ4JlrIbAQYMHj3wnb/fDu2RQJagPvZX/IRRqJbhkCBf557RFOZOoI17x73XBeamUieYy1l4brREn+XjhmGzvsOI/c0B/A6aHYywiWkq2FhY06hM+chBRmrNhWfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519171; c=relaxed/simple;
	bh=Aq6Q9YQslYahhM7IfEgXsDMdg04FiB1n+dPA1V30/ss=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QPuVnzyRadYskZ3QAQn6b0yMjhRwzed18/afqE2v/8Z/9S3uD2TC7PjhCFwfTKtst0X4r4ZY9wrGigdqbZzagW29No7EnXyrOxyD9mcglapwCoJFm6JoTp3M5SlRcZR5p1ToNdMIxeZxvcIvIm0nXFWIKHG6NT7p6SRc7gdHt5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=LSiZJweK; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="LSiZJweK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFZE+PDKH98BRAgZ5oQd2CU5BgD2zBI6BGayHx6Awzd06fDvGaB+jWpfGbwyuQ/y2aDJXbW78uclxSJWAr/mcwjz/EHQugWBmuGTUAi42oBL/+T5Lkg7ng9ijmD2KQla51tbij64KicSe4ErnTyCn2iDTz68uWwVwsmyMyotamYWh2hF09ojnZECKg4TET6AJzs3YBKvu8GAzYPxvaGddGcy+FT0MD9SHJQKn49J1PJcvM8NlvxdVwdnHAx1guMYpZtZoLJ6/mLjLgQ1RKJw3T2k6eujvpC7chh1JNzo3ww9y6CmAOi9bBzLIUXJLrsDyC6nAmJ+5uH525NCQR0iLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCLrMDFkc21eKW3l5sJm97FfiDIZt189ThG8F88rp58=;
 b=wYxObWgLpw+RotWs0TXACOF93OLy31wsNfteE57MOPjQPcmhWh/A5k35uJQW4+sOcwFeoYfpwjbAsmVbMI5SLHu4Vqhyvq7EJgMoz58HDbb1PD/igOjFWgorQ7sXi916vwgLRDVB8ZbevTmwB7lv9SpNpWRCPgKyaAh+hxpT7LDzNL63EM6z88Nuj+RfEJVfXsf7MwrFvEu9ZuZ0vXdyerCjc+TAB9Jq59EePl5/VEb1IT0SHRVuQTGHS8rVxNgN/BDcfnffLH2sV9l9fawqRlthkA5Q9d22SvqKT6jY2DyEXDBuBaAmrxTcP9lnWp692PS+VWekh7bMCylV72Expw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=gmail.com smtp.mailfrom=axis.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=axis.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCLrMDFkc21eKW3l5sJm97FfiDIZt189ThG8F88rp58=;
 b=LSiZJweKFSyYArl34JlbGsmGp4RzfnoyBOS68PLTySFVnEAoJ1nuHfeOSFyh3wGdlURrRXy8oaMNmz1F0xyFTzQ0yUmgFpao7s0JchPUeAuoNHz6iqAX5/zHUlzFBjEqG0tvPdAIqZSFgdvb1dm7jtF+XqbBgE0KR2wF4tH3+04=
Received: from DU7PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::14) by AS8PR02MB8615.eurprd02.prod.outlook.com
 (2603:10a6:20b:54d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 09:59:23 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::5a) by DU7PR01CA0027.outlook.office365.com
 (2603:10a6:10:50e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 09:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 09:59:23 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.39; Thu, 26 Mar
 2026 10:59:21 +0100
Received: from se-mail11w.axis.com (10.20.40.11) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 26 Mar
 2026 10:59:21 +0100
Received: from se-intmail02x.se.axis.com (10.4.0.28) by se-mail11w.axis.com
 (10.20.40.11) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Thu, 26 Mar 2026 10:59:21 +0100
Received: from pc56869-2347.se.axis.com (pc56869-2347.se.axis.com [10.94.2.37])
	by se-intmail02x.se.axis.com (Postfix) with ESMTP id 8DE6E2CB2;
	Thu, 26 Mar 2026 10:59:21 +0100 (CET)
Received: by pc56869-2347.se.axis.com (Postfix, from userid 18630)
	id 8A36B602F25C; Thu, 26 Mar 2026 10:59:21 +0100 (CET)
From: Jonathan Rissanen <jonathan.rissanen@axis.com>
Subject: [PATCH v2 0/2] Bluetooth: fix race during h4 bluetooth
 initialization
Date: Thu, 26 Mar 2026 10:59:07 +0100
Message-ID: <20260326-hci-init-fix-v2-0-a974211d0224@axis.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGsDxWkC/1XMQQ7CIBCF4as0s3bMDK1oXXkP0wUilVlIDTSkp
 uHuYuPG5f+S962QXBSX4NysEF2WJFOooXYNWG/Cw6Hca4MipamlFr0VlCAzjrJgrw9HVidDTB3
 Uyyu6Om/cdajtJc1TfG965u/6gxT9Q5mR0XGvyXR8M6O6mEXS3k5PGEopH2kI+emnAAAA
X-Change-ID: 20260303-hci-init-fix-9657128a0104
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jonathan Rissanen <jonathan.rissanen@axis.com>, <kernel@axis.com>
X-Mailer: b4 0.14.3
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|AS8PR02MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ecbb20-e2f1-4f41-bc87-08de8b1e5b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	hCafs4WmQN8zW5q7gfBiM1KUpO6R/+OZ8+qXJ0Ud9kKotIp6ke0INzfPu8SORA35jcBp/Ubu1+LgaMWNFADHtfK/XgcnZONcpL6cFI/i+Jq67gejE14m6/rL6sPVgI1JabID8M6eF2SHLloKcPh+F3JH8rniTezPNAGfpWU6e8wEr2QN/oc0EMRQN4YBREzjaNtEL7QV03vWlyziQO5EIM0pnLn+8HPXPgE1nz62PtC52ID0YA4nYtDW8gJOEHz1OVjdLjH4e8N3oJtmub31tWTndmAxh1wVM6kbVLPlfJoS9qcNw19MfVo/XPQWMo+t9WduQPlrK5iJc7ovJir2CKd1HrtPn9tuNVSmTN0kp/sNBrGaqtbnNCnISmRGcvW1TqtJxIcjkRDtlmn7Q1cH/TjfhmtvRSXaAlA33iRKx+B9ZD/23LvQgMRgcPxyY6hLb16tD16WlWiZV++mS9CO0yhsUL1DiHS2ve1rEo7J1AwDv33/9vJ54D/X6EjONCtUmL7JEkBX27j7a7FwnfjWnSgGNnRJljsm+699IiLqU7pbVRDoZrDKEm8/Ps/FWFrOie/o/TSSHLiIHUYjIvl6SeHiLGiGF9xF+WDG56V4i3h3xzjjRuOWlgu9kGx1yFLUOUivqNOnUyNLGK2Ilz/pE7CkFTQohqL/i3sEvDiLXK1cJefGZSMFBGtl3DjfwEjj6LcYMJS7moKo2W4PusvbVZbTLA/o5/KAX06IZC5mpGQfN7MRnc93uTMHZKQzC2iHIRwlUj0aNhEP4lfaB70bfA==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TbUt4TfMbNDZ2+dIs5oga1nPx5cUMY0TznzXDvpWtYUVO/LvryQSF+5hOCMYhJ0kX+MHaVwEjRfzUgIYdYGQa+y9aLvN/gPsOtF1ilMCg1HNaunuvj93k9wtcDnmZ/R7VBR5ylrqyd54SmxLCRnfu1ZemmLtmQtSWifw6qThgLERJ90Unmytzh6KNBh2II+DO6Igd6zefmNIoxw4ETTwhyUaPjC5oeM4yH9e+FLEst0ItKP1d3MoDCct05W8jxdKRnGTV85uhl3XKy3NhfgvPxvdDAX4dk60LPfYpa5qk5HCNeTgnY0yXif/dRDzDRIajJ4iq0gzBC3m1nmVS4jRW1bhxDa5EfNNnPULugNoE/z/qL/uqzYKlG2venxgdgiIBMhOfExjBmAcaNd80ni0I7URFYJtItFpWv1/S5QjC/NQE70wz4qnPqPr2z1Qd/Jn
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 09:59:23.1426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ecbb20-e2f1-4f41-bc87-08de8b1e5b66
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8615

Hi,

This series fixes a race condition that causes hci events to sometimes
be ignored during h4 initialization.

The first patch clears the HCI_UART_PROTO_INIT bit if device
registration fails. This is needed to prevent the second patch from
introducing a possible null pointer dereference.

The second patch contains the fix for the race condition.

Signed-off-by: Jonathan Rissanen <jonathan.rissanen@axis.com>
---
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

