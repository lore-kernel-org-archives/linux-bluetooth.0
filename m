Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5B414AA9
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979656; cv=fail; b=UYVCUpXnou0gyHfKBNsJC0kkbf8VSSV/tY9O4v7xmq/QGvEa8K76PWUVv6wrOBTvO3zfyOwVElUtlhNazIiJKz2Lh2sOQZWJpOapR63SgkadFKQAqzD08mn8VCXtErtpQS37o85nDDxXS3MMmLJRyT9jKdhBmWccobvBo7x2DeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979656; c=relaxed/simple;
	bh=NPqBI4atNtfrVm8iJnw9D3J2TX3yKZpKl00UKrqiey4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FsTloQ7K57sj46XXdYS6iQhnq2hRxwu34221YshKdU9Qa35r8f2JrKEt58pWhpDLbDebEZsrc9Ndukk31XIEgQhwJN1Gj0gHhGJFavd+7oh1YKEtorVeUZhBiYJLA3D6HFv84IBrOt5XWN8tZqABi/220CD13BcejmnZETDvERI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=us2y7IKF; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="us2y7IKF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYQ8suxNMC8mk76p7AF+8zrEewtlmnQpxZ2PAcZE2oKF5uAAuYybbIJlOtsCYDJ0i4aoujnfYMcncyqMBzz+5cKtSD8UoPi76vS4oLv8nXLT1KZTRa1uDiXf4LxSi9yN/8UFWBiNiWz/5JjmTeIFGz8oJ4v52Ym7bVd9Wohk2030v4k7uSyCqAjdiBIfl4+00WkCQEmX739UFy3ZduRDW7JoYmYEtKonWsMxuZXZWrp/w+UoJXNyNTlqNZKwdYAyAyG/Pmud4D0IY/hzJicqTBfbyMQl20iR3ANTG4MGeK5OIbS3KIMe/gbwpylIYpbKj+wpRvU+aeyitqgJPLXXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGjCoigLByhJmX2tily7pcEQdFyjIyEFih1aJdd+hwk=;
 b=kv7UtBHbI93x58xiQXL94eRuCOK7Q9ihuP0yeGEJA07tLP5HU7ZKIfNpshNF+z4XZldItqBAjlxfd5uJpCMdQywDd8THlDX1du7aAvDIf67IuE+TtmVxQM/lqzdm4gTXstK98e0PW7bdLETH7AATS0KO5QihVoBRu3MwfsE/b3k+c/N4P/bj4j0bDuwZDe5o/5VI1tRTpQCHL6UJI+iTH0En7YY1mTaFD7aJtLbGwyBFj9pbFRK1ucPRFWEqTqejBvFg+OlaxSTGR+OsMmGZh3LGUCY4Oc6AVKBY4QujYVCAc56sj+mo8RApzlEdDPF3DszS8lyrjLbSIx2tiOwDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGjCoigLByhJmX2tily7pcEQdFyjIyEFih1aJdd+hwk=;
 b=us2y7IKFqcG6iItEYQ8iKgf9BIivhZs6a74p8uDY/vYfKqN+yqrLRlm9kEsI2k9pHWUPJnecUNSUm7YNzpjhP8/ciEvj76rgMGOxypwr9aaS/d7keDBWnrO2c8cnyiHjBz29uNnqVvBZmJus4JjZT+ZlL1gjSQJIqFDMe+LOIo4=
Received: from AS4P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::16)
 by DU7PR03MB10945.eurprd03.prod.outlook.com (2603:10a6:10:5b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Tue, 8 Jul
 2025 13:00:50 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::a2) by AS4P190CA0027.outlook.office365.com
 (2603:10a6:20b:5d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 13:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:00:50 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 15:00:50 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 04/15] mesh: mesh-config: remove dead function prototype
Date: Tue, 8 Jul 2025 14:59:36 +0200
Message-ID: <20250708125947.11988-4-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|DU7PR03MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: f4540b48-7ba5-463c-ff28-08ddbe1f76f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lTQdSfpbdt8dD1rBvQdt/SSNuPHDiFeYRTfm2t9TqfJ+sAl5VR+xlLNPWqlE?=
 =?us-ascii?Q?UDEdHoOk82J9s4nROUCU3rboGMbKvV4IDacn6XSKnV+iXag7R8tss3DckGe8?=
 =?us-ascii?Q?sUINtuOh7Grx2br7JLLyVNA01KGWbcYeHhbwk1GdVZFQLJ/2zAq0NM/SRvCT?=
 =?us-ascii?Q?GmaxvJGzRTPgKfB+VgUsatzv+YhCc8xhT+ovjav7rSi07irUnlmG10QslPBc?=
 =?us-ascii?Q?4k0SueQALTkVbcDNJPsXZ+66zcND2t99171TeaaTO6EnefyN8MP/CMk3AEde?=
 =?us-ascii?Q?L1FL7R5YBvb/CfAMNZKTrktZ9mjJSZWIhtxcFtTDXbNUq6XyHs6QwLoBqCP+?=
 =?us-ascii?Q?LGGYiKOwWO8k4gOhDz9TQq/V3gOvW+VEYN1zp8bUiCceoaLDz1PG9kbf7sii?=
 =?us-ascii?Q?xTCJloS59jcB7jU3xiC7NmNrq4fXR8U2QHbGK2W92a/qXrpNmuIZbSjc00dw?=
 =?us-ascii?Q?MgT2XOoZwoV8EYZP5mRwxNoYB5uiqLybW9cpIamrgtSStUyozjBCsDiNj1iq?=
 =?us-ascii?Q?VVZVENE1V4+zfjvbnH0GiQC8yxQJq9DxQnJlM/pk42TxMgcLi6vkTO8skhoN?=
 =?us-ascii?Q?Qa959HBmwa4+8QHG7iVp7esYaORjGrY6vcFSanh9HeeK1WudkJhefyuV98qj?=
 =?us-ascii?Q?j5LZ04tRFD28Hs8mLXySgjO4EH1KF0S0tn0Jh6FvYlFmuEyNsUBy+IanvOPh?=
 =?us-ascii?Q?XtEPU7ZEsn8thb1rMe+lT1az+6ZxvBew8ujMDaGsXQV/JCWtkC9oAMSAfK3w?=
 =?us-ascii?Q?4YXJljQ8VI3NE8WZrX4QlGXCfAxLcbFaSG4/6sB0ZEHUpKzX9ZOxaEJjY9iT?=
 =?us-ascii?Q?+jWcUD7yYj9O9YOnEo5K+LAoLOwaT7fkCg8YchM3d3vrBU+GqYz38SEVCigk?=
 =?us-ascii?Q?PSp7E5/48dRoMlGgYNx2/dCXl9gFmjtHIPoJHpl8wUVYheVPSI5INxIgPEHT?=
 =?us-ascii?Q?US/qaFFg6xFbNuF1xcYQjpAkvCHIYlRd74KJ4Rz1yZO2iWpGLlBIW7ePNzIN?=
 =?us-ascii?Q?Su+XaEBtvfAiQ5Y+SqjCASmPmri9fBiCAyQKr+jlc8rARR7yRUBafegulC02?=
 =?us-ascii?Q?sjTHvCOnrdEnZKQZG3f04g64I/2RoZjksEYIu7EDfO0iXdcKisBOPW36xqXb?=
 =?us-ascii?Q?fR2CWgBGjmXJDsEKwJbhkOvJ9W/+PUkbfSRR5n8E6VdyNTMW94URzVpVV0Bz?=
 =?us-ascii?Q?eOHkKL6Ua14uvIf6uLcDbCIisCdFKTT30u3v6uiuxAg5VwWM2VGW7E6dHqfM?=
 =?us-ascii?Q?A22+Mjf9A6HAzomM6ht5hhx/0kp6kfFg3mvMpApoQztYfIQg1y4eGurAT5OB?=
 =?us-ascii?Q?PnhULpqmE1vbc06yAZAZgHuLv9K3vhp6dwkWH08ajeUE4fnf4uQCKftzfvGY?=
 =?us-ascii?Q?AiLBKzaJZWQnz1urpajmTM+wWiyLPrUMbU54zni6jbiv01NEy5VCz0h1bHqj?=
 =?us-ascii?Q?l1QGUjp2TdQGwy6fFm8xsYtMdLjV5PZ6HEJFdc00k6mPLZHq2MTwnuxQikIo?=
 =?us-ascii?Q?8R6SNRIWFdtRfXFY96fhsVKi1NJnv2dh0Pir?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:00:50.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4540b48-7ba5-463c-ff28-08ddbe1f76f3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR03MB10945

mesh_config_write_address() has been added in commit 78668a02d6c4
("mesh: Change mesh_db prefix to mesh_config"), but an implementation
has never existed.
---
 mesh/mesh-config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index b320116fa8dc..ea5993346111 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -186,7 +186,6 @@ bool mesh_config_net_key_update(struct mesh_config *cfg, uint16_t idx,
 bool mesh_config_net_key_del(struct mesh_config *cfg, uint16_t net_idx);
 bool mesh_config_net_key_set_phase(struct mesh_config *cfg, uint16_t idx,
 								uint8_t phase);
-bool mesh_config_write_address(struct mesh_config *cfg, uint16_t address);
 bool mesh_config_write_iv_index(struct mesh_config *cfg, uint32_t idx,
 								bool update);
 bool mesh_config_update_company_id(struct mesh_config *cfg, uint16_t cid);
-- 
2.43.0

