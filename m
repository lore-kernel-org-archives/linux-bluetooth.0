Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B82DCC03
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751979612; cv=fail; b=fR7IrER3fus6KdbDiVLzvHUazknnjg7vlUqZGfTGgNo9XVnFK63hyjGKwv0RsYusuwm38xNXGAtYlFFMBeZZTzqCqMPvcQ3c4+kDri+du2un/5EAuMahNZKf6FgxUrFh849vZW1InD43SX4H8+vXK3sGTQeDUBFJPwdZJVMm+NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751979612; c=relaxed/simple;
	bh=Pkkn/lnTlOsTRZtGmTwMoqUIfnbCuwCWIcsjutkcIGM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CWR9DKPY23z3ByfbRpFkeFZgJVWWGrRljGSJualT+TvIP3Bn8YwVzpWcWy6yW9By3RmJt/oVA2yvf+btqZ/193wcltf6BdTER4EWVjzEQ2zApYVj1avovVm4zQc4ihmELzJJMGvoXjz0MPBXUrLS1zvA37HCSXwwleiPsRHpWJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=kO3uZ/Ch; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="kO3uZ/Ch"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCOnD6UDNZA2jqXnmbIOw0uy3F9+qhm7HbEjqOylpE9nzaxf5qwZbVk13Ke+wSXd+ygCznm1btpjK9obKbPlLpOyNKyFCIhV36OshMvdv/+Yge0mrNc8mHHwgzXy4TfExofNjy8/JNwZPhunCrL2oXMbpInFOLO0aZmDlO/GAjFl2BmZsv/vFuBoKrAV5JdnhhwHq1D443Ix07xeF9t+pdiC/RJ3KyivvpdYIekn4GoiWSC8TRvbv5HMo/Be/yKoN/6sPaXKObSLkHKxD3cSCZFNl7cB5IqnX+Snci/3wY00QKNw9GzjFhdVGtSJ55iExOc1L+aNj4ZRKvncuJpGFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4MgcWKzM2MmPvWfbNY0oU9qvO0ZrtjrruX2LrZcayQ=;
 b=TxB0RF+j9A6IrY5H37JsVoYmQy0n0Q+YSVJGWFHjDZCPYpbvepYSSxFiYiVzb9w46OV4MAZqg06P7zwqMDvI0WbdiPO7A0W1l2ffrpbhbBSsffm0Ax0jZ1GsdxvgB4kFqT6C5KcJOQvnQb6jrrbcSedIGiRXbmSA1cD3e08SxQ+ek6Q3j97cD5upstp/lpMRG3Yic68GJXyQtkNpc8HsfzlMLOPzoUXeb0ucyjndtXFzpC1UhrUEal7GklvBn8Om1KiLAx4cFiZQrYXdSxSPbittYPx9AJJkLjwSIk46ckWECtyc89hHRjfn+nLqZu22W2I/rQcN7IfhQ0EBLKA1Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4MgcWKzM2MmPvWfbNY0oU9qvO0ZrtjrruX2LrZcayQ=;
 b=kO3uZ/Ch5ovf84+EgA4o0z2zJseiF65TzAPXIzttGfr1RvMCIuL8/zf5/6aRDNu3Dx250IrTaYo3K8Q0+tWaaXxnPiSFnSWJdcNZ3en3c+FaecToP1xQ1Vu2/bI6QVtUwOI0wotXwfTjYBSN1Ozl7HpBn3RG7PKz5SE1jDWcRnw=
Received: from AS4P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::14)
 by DB9PR03MB9784.eurprd03.prod.outlook.com (2603:10a6:10:456::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Tue, 8 Jul
 2025 13:00:02 +0000
Received: from AM4PEPF00027A61.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::45) by AS4P190CA0022.outlook.office365.com
 (2603:10a6:20b:5d0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 13:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A61.mail.protection.outlook.com (10.167.16.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 13:00:00 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 8 Jul
 2025 14:59:59 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 01/15] mesh: crypto: remove dead function declaration
Date: Tue, 8 Jul 2025 14:59:33 +0200
Message-ID: <20250708125947.11988-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A61:EE_|DB9PR03MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: b4222965-671f-4834-5972-08ddbe1f5905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IZImEDty+WoUo2ga8HpkGhOB3XERRKpnsSx0pNgGKWMFaoYrcev2qaxRVIB?=
 =?us-ascii?Q?sM03cTaFxnzPJdhIu9MMBjCX7JUM1uvw2XwAFYe7yv7GfRhS76ZDFh5i8n13?=
 =?us-ascii?Q?S/ioPHOPAQpPM29QnxxVaY4n7/2pEBI85D6DV077WYAkUZqkOeQnQZ8r7Xbs?=
 =?us-ascii?Q?N8S5o6BctwrYcL98RoFhzr1aUz+BMCKFSdC7vaI9F5/f3mYaW2eN1Z9Ph7gF?=
 =?us-ascii?Q?wMvDwh5mkc8YajtDesQSBUSU9KCWWwOR/EiybS3LEgTOcV2wfbSaX24XaqXK?=
 =?us-ascii?Q?ytjmCnqrBcy10/6j2sZzkykza9ZU+zPmCRz0e1VF5ZfefioOgR2/D9Q85Btm?=
 =?us-ascii?Q?AOwWhhL7lukHGFGTcPtDWPxI0RaYhSfzZb3p+R0CazCRjZXKBUSCPpcxmwA/?=
 =?us-ascii?Q?wOzZCJZCjXhFQLBPMZTeXev5hcJ1hjM0Y0cdWY1scsVfFtOLp+yvAjZCXnGr?=
 =?us-ascii?Q?WM73gi4jm+noK96JNG0DKPKmx4PutVg5AtpsdXUgsk7Op87iCOB7MVp5zUQY?=
 =?us-ascii?Q?Cs6tbEe4YIeg8/G5Mqe+NgfTO+jvlgM3CUPTFzA24SD2+XOvyIj/R+wHiYuU?=
 =?us-ascii?Q?aN0h1t+077HGtiSCm10nJK9TfgGhgpPlMinNjKb4lDqdOL0rlAqWSxb/7sms?=
 =?us-ascii?Q?6gSdRaE6bUMhdBjD/3tqHj0uLI3Yfx00W5TXDi6kOP5aUf3bWIJEYLeG2Tvh?=
 =?us-ascii?Q?6L5i8CrqoTN/OEfUD+9t9NIpuzlevH9pJUrrO8DYgjoldoAPiZBmMfAwJ2P9?=
 =?us-ascii?Q?kF7v8g6S4p/kgcVOXnaPqt6QEX+oSqAX8VpCJos2ayZHXq7+09wu/y98H+QL?=
 =?us-ascii?Q?UE+PSgC/4cudIOXAFCaEtViOxEQ5R+CoFBvqWmZVnn2yxf2bD5L+7ch4+7HW?=
 =?us-ascii?Q?OXzai1X0etlEfDvBtnktyVdxw0j9oHra8BVL6fgU7+o4MnZlk3IesL0J9huw?=
 =?us-ascii?Q?Us62j2y/qiV7GY6FswV1HS6WiRWEajwoA0rNSK8FEVvDyOqnucYGJJBw5pMh?=
 =?us-ascii?Q?yJvqy+x5PzsKeCtC3DobSR1mIv4DdKRM2ScdYAz6fqD4LPewsy+rjO39L9uL?=
 =?us-ascii?Q?p/kxMMoZcvywgwNJwOwDkQ1MAXhCxvvZWpC/meERgQXuDmccbT8DksFoOUXm?=
 =?us-ascii?Q?lHMEDfeWwiyuSJjeKPWMpvYiPWFkNQrIMob8zXRi+yDF0EhwOK+sYAYy4KP7?=
 =?us-ascii?Q?6e1G5fbI5NwNv0cvp0X+8dA+g5uAqisddhkvpawR/O4Z3aMfOe2q6v3s+dAf?=
 =?us-ascii?Q?8S9n5bJYYGhWxL29paHV+UJMQpbijurfyYSb3NlDQX/9LEMigEGqKDQ/qBfm?=
 =?us-ascii?Q?JSasGdtqQdxnCNTBagar50sM/mPMkCOqh0gAGKF92YCNwLviEGsXLQW4onBP?=
 =?us-ascii?Q?ftXMj9cERVRD9xm4HGo1MOcn+3wwm1WcW2LHX+LT4wmDmGKdCmCEcH6UmauW?=
 =?us-ascii?Q?2PRy8o8xXnRnxiwKZcFGUwnUCnnRj9ZFOQE2Kjzo96mbYScPyr7yloOo0xK1?=
 =?us-ascii?Q?ogq35l6sxBXJJHJOtCw1AT0aje3lPygSwm+a?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:00:00.2825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4222965-671f-4834-5972-08ddbe1f5905
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A61.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9784

The implementation of mesh_aes_ecb_one() has been removed in commit
dfed4839463f ("mesh: Convert crypto to use ELL wrappers").
---
 mesh/crypto.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/crypto.h b/mesh/crypto.h
index 55789886eb0e..3d85785f174c 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -22,8 +22,6 @@ bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13], const uint8_t key[16],
 				const void *enc_msg, uint16_t enc_msg_len,
 				void *out_msg,
 				void *out_mic, size_t mic_size);
-bool mesh_aes_ecb_one(const uint8_t key[16],
-			const uint8_t plaintext[16], uint8_t encrypted[16]);
 bool mesh_crypto_nkik(const uint8_t network_key[16], uint8_t identity_key[16]);
 bool mesh_crypto_nkbk(const uint8_t network_key[16], uint8_t beacon_key[16]);
 bool mesh_crypto_nkpk(const uint8_t network_key[16], uint8_t private_key[16]);
-- 
2.43.0

