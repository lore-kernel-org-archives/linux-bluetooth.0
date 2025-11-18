Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC6350A1A;
	Tue, 18 Nov 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475658; cv=fail; b=nEWjoc3Wzhzq3byVTKwVCBqNKMLMHmKfYJAQbfAw6wn+gmpn2HLKCgvzOhThmucJMAefLpuApjyyxn9K0ZD4J4c17ca0PfPljq89GCnpo5IzBwsoOwDlFRIjKa+l0E64A864XIOyV5ZpMZxNeQ4Dypqei3CA1mAsRRB9AXWQQF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475658; c=relaxed/simple;
	bh=v/+IANBCitrH0JPPZW8ZJyA+ti5aycwt0Po200aux2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lXdR+POEVPd/RvHqWny1vqf8Q+BNw6TQ0YuE/TuZ8zuWra1I+t2yvNj/8EU9lcq3+koTGYreIJsaAMci+bjCTCpm8VCeIgbPs/UJKr4Snmlvol/WBYGDxDushIjTY0QayYQpo1MTpxf/SbImBo/eTLBMRZIdP87ohoM4CtwhU+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UJ0RQ1rV; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UJ0RQ1rV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shzzd53fTIOa6434V90MvQozRUK0jlThyzBnW22FytvkSh+Kuc9WZziQ/Y+awE+8sL3Ti0n9pcF4JD+3SsEiGl25luH9fvISEh53nuv19/ZYhsUvPV3RbgcQZxe6suvufUIXh/rMuuc+EMmg/sN47ef7+9Sev09TgOQRvRF6vK6L4hpD5L6gf+JSvN06WFooLaxdRYwxt5Qak1RN+St4FGvKYi92Cn/yV/xnfa0saBRKZrX86sQOkNg3m+cUxuRHcec1yKPuzeoc2duqp2cPlKrhBxnsfj1YmMIqicqFm9v2Sn8Z3ENLGiUFOFifsWpsGl1ImlEAND8D7NySTgB8AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx+314doJI2eQrzvv4TMxXzH0PBnI/4dj0K+ZciJRWw=;
 b=hSyOlFAKlakKpzrCttZ2Bf1f+cWZtUXHXHwsIayDqTEZjih7IPnqWISgoqk0p99XjuIUE7jAxC22SOBkhpgGmnoftBPVBhbp5h1wVYWZwmbOY5lx9EVWsUSal78g1Pjeh5Bfl/NAwMOXBHFWPv/frLVk2+1KMDnVcXm0v2+8XjEgiLEPtjSEDWf6y7a42dMgzFowGjgojWakfSF1cAyRivbWL/2wzcl0OTwhKoD0BHbAlV6oFGZQdEwkLWwm4rz4WxgGvC1MRR+T+YWyPWHxDxfz47RkyPv+sCX13F9PMmJsB+pKUCZHKn1uIBmgxNKVEBPoXWTpAaMJbXfBI0JdqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx+314doJI2eQrzvv4TMxXzH0PBnI/4dj0K+ZciJRWw=;
 b=UJ0RQ1rVkZ9Hu6o1853ccgkmVTTWmNhS7rIdIfUj/MZ7XNIq7dgOOoG8aJ0oWGZQM2qbCiRCT42lw8dFkeuxi/BI0+0p0yqubSh9rsn/zJcHCPofLPf/u5LPyzKpAMFQhJ7DIQ88bWN0yP7Icw2/wQnP1pH+fEcXX/dUk30EFJ8UD4ktDVyu5Kl1ahFjEsfzkTI1cByyN6nQEtDWkA9l8QuVRezGFUzOvDAfWrHxiwwua5UW5toXvsikZxfygsAlwGSVgKcjWJhpmgCUKSkUxWzsv0jSMhVN7W8fWlZYkVaYqNst4eSnfEQ+GH00KuropCXrMqo2rnDxM6XKq//3pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:20:49 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:20:48 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 00/11] Bluetooth: btnxpuart: Add secure interface support for NXP chipsets
Date: Tue, 18 Nov 2025 19:50:13 +0530
Message-ID: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0036.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::29) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9e6b4b-947d-4e4f-de63-08de26adaba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b4E0KgOeUKqIEAjOtEFIKOTD1jz8zMbUxEXubpPbQBOWD/J5TUwBV0cce6tQ?=
 =?us-ascii?Q?09ChJyn6LpRPmu+3i8gVTLI3kucVasoPwWT2Z+Tacg54sUg6WvaRvvVGUY3i?=
 =?us-ascii?Q?j8tzckCt4pEUmEgrd3WBoZhb05adb/bZgQ7MvJvSM84d1spLj2gjzTAXtc/T?=
 =?us-ascii?Q?qifxo6U0SYjLaCr8iAi5qNOq9k87bqO6YebKq3nXq6LDLbQMU4VkUgbY0vtV?=
 =?us-ascii?Q?SgTHUu/NfzRV+0Wmg4NXQYp5WbPY8RgnARYyS3xx08/2GUry9Sl+aSvEhak4?=
 =?us-ascii?Q?ouUlnVfe5sZZ/ycP5SYewBXlP4D3VaCUTnTEPVkTYQin93K6e9WS6urt/Hkl?=
 =?us-ascii?Q?wBvtY8aqG/eNP+DHuROMJOftRag8Vf4Xuf92lxV4qWLPW9JoerzV6sW1yIlK?=
 =?us-ascii?Q?OImeqsKVu4GnQRK16GOcicyda5AYT4Ff/NZE6fKh0Hmp+MA3eMtqtQseGBBU?=
 =?us-ascii?Q?tMxsLFk8GRCi9A7aADFX670RPaxCb6UgsUfM5UQhHLHOJZXFmCWRsgXyLSuJ?=
 =?us-ascii?Q?pZXnuz8/nercT8dT88R/FKA4aU/11goFXt5OIn/BkIvkjzJGBIxpeOQomfVF?=
 =?us-ascii?Q?XI5NlEtVz512Vm/Hlf5PzaF2qOdj45w6z5h6PMLhjR3v/1aGQjlczfrLoFCM?=
 =?us-ascii?Q?OciS1pmWz1uygZsVvkgNPYrUydgWCIJeQBNRADYDiwK67VfphCvOUrsa+Fqu?=
 =?us-ascii?Q?gopi2/55cYAZeL09rBonjoqjB+CgCEqN8f7XLyZJigoPDlCjxjZQNy+mchE0?=
 =?us-ascii?Q?atnDU+Fdsvai5Pu5MKSbp8u6IE5u895zy5HrrgqCYhf3AHKW1YYlHnuKgLJa?=
 =?us-ascii?Q?JjVpWAo1AoJCVf7wCMgC7AAV6B7c03NbgcpMPP2EXHpl3SV29GxqafD4y2AC?=
 =?us-ascii?Q?n6fM0rpTAYg9r7tz+pAJutnjuoArEYqxGD/KDfjepSC4j/wX+OdQxxsyZ/Ce?=
 =?us-ascii?Q?fjitDwEyjHSSHTD9dBASoMqmd70dSnfQAdy1sjy71uVLDm8piqPRbh8WNh+Q?=
 =?us-ascii?Q?c7jcpof9X0+m7ktybnbpCXjJcuWbQAEjZ8NLY5h4QotPZHwoVuosxSyGADlf?=
 =?us-ascii?Q?42b4uRNV9UCJZOEyHDJmTBUlzSKpmWqsWYjeNuS5FAANUSi1/Y1FMnx9odbh?=
 =?us-ascii?Q?fjcfwF8doT0MOAkm+1splq0Fx7PdYOipuRggZohxrAi6eFnZFxxw90ljQBwh?=
 =?us-ascii?Q?DvJoZMxqh39F7lSpr1WWl06yJ2ZSjfVFh+WN9SNgo9SbqNPJWyYnFogQAyDo?=
 =?us-ascii?Q?KoRN9u6HPOwGk1skx+Xh07pUxg0wX/+MgKp4+X3hltNkn/i9d2cCT7a/YGms?=
 =?us-ascii?Q?U7TxIIamn2fDXAaeBLYX+6mXxFjaFvF0SC2aCaGisiCRQf/QTCvfhpN20dDM?=
 =?us-ascii?Q?DRpFaMWi8QNNVDN+K3QZxRCh64yC1OtAQwhGaYIhrCy4vyc7KAFLSm0Q/NoS?=
 =?us-ascii?Q?+cDK9oSoVOC2Ovh8WF5HQWorqRehWXg6z38w4fAS6EF49d0Xg6BaGQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fBJOo1SIk7cBr3xeElbavPm6iEzBXcGZTBBwRekYyLt+SKq/iNiqzQVOIJHX?=
 =?us-ascii?Q?kVxkcZufvx4hhjlAL4sG1NZbxPGyyKhwFJHNzQLbjRHaCbZBpThBeKZDOjvL?=
 =?us-ascii?Q?OVcSmBgkgHTxSmVEJ2/3IV6GXZgt4c6laZsel6uvD5BCmByPZ1E7BSdlRnV7?=
 =?us-ascii?Q?+XpZtu3xTh7KAEnnwn5QuJydwuKs1Q0R1DqLfLN6Ikdbm+I2Y/831v8OhLCF?=
 =?us-ascii?Q?g8MbYc64u7fb7A8cnWuuM6cTvQSpnGOQMZolo1HhVfdPflEDb9+ae4PcLNdp?=
 =?us-ascii?Q?YeVcKVBZPliU/JhtVh8JRMIHe+DaKiP4WjPrd8kyO5MAPn/hJAm+ce1T/pk4?=
 =?us-ascii?Q?5VN/QTLowmQeowgLpGkgCoKWXEZwEjGj7LofDIzYA/rCKgOsRs2V1tUy9iKm?=
 =?us-ascii?Q?Dy9/YRK9liCyrzd53QgNkLy6I5We5fo7HMAHeoxjtuUqfoDLiu3zzHZwpMmg?=
 =?us-ascii?Q?P0FmJuNF+wEi/kN91qz6K5b5JYCTBqsEn/mrflcMXXe/YlD46PCp7Nh77bg/?=
 =?us-ascii?Q?PT1uJQfo816+/x5KFO0uCEYr1DHfwkSoH+BcdxzEXDZNVsVOBxDvQw46TJs8?=
 =?us-ascii?Q?uOIoR0NiOo9jujZcAZBG0Egpy7+8wpw6CBAfRi3xsKFSUr96AYHtJf3Sx6Gi?=
 =?us-ascii?Q?SCd3vPz2ggZBLJ2Khf3CQacwxv+o0S2o2FJUCi2nk5JSmFk+lTFBVykQlAZi?=
 =?us-ascii?Q?gm+LcanboQfyE295D3rGU2ON9Z63A2G8vdAWa0XNh73QASQbbcNUWqw1/Mkg?=
 =?us-ascii?Q?J6fPcjvVEqa1icDbQAJNY602LQfRSvsCOk05oRgCWpdaVLGAFKnM0X+b0efv?=
 =?us-ascii?Q?KyiT0cWqvk2VuqxM/CCKODrqnJ+EQyjuJvTwRIx495oyj1v06DdN1CWk5chm?=
 =?us-ascii?Q?7j2B55vyqd8uR4vPTJq2gjmWOaqgSTrXLc6j4F7LK5KWCnRV4au6vvs7m6jL?=
 =?us-ascii?Q?iDIllUCUKZzbHBwrxkwSO6FgP+LaExvILW5RHmEtMrD787fIhEJqG+CdAWJD?=
 =?us-ascii?Q?3rPZnaAzMEh1Ll9gdcLt7EXKgIEDVEpfhnowby3XU+8UtvGetlckC6Xwi2zh?=
 =?us-ascii?Q?FIo33lwt0NS9LbwKuBNq1HhV/8CaKiYykAmIWh2SPo212ryTb0ixuM+FTruI?=
 =?us-ascii?Q?tt/KPWWeKOY8lVZCVaKw0P/23EaqsRVnh+mXWIyNW5uDVTA52pIK4pdjTxcX?=
 =?us-ascii?Q?sFv2ZgY0n/1woBblECdswTqm33DkyrCxgYMMgWxJq1PEEB1PpaqaO+8L9CQZ?=
 =?us-ascii?Q?ND2f3flJJgW8lfebpxX41zD1aqHIPPCazpdjnQHL01FwwRu2s+XPiTXV1qk0?=
 =?us-ascii?Q?pxbNIlfCDn5+P6IeBxbuktqEvmhUkfwyJjlVrAoEafDgP9GrnH0/U/IjKXVo?=
 =?us-ascii?Q?cYlBl7O7Uju8qJqmmON3vzSwZlkMiCEtkk9eJtMmJdpu2/8/mr7oxuueRyDQ?=
 =?us-ascii?Q?eKObUlEGYGBS/+wSY/Nw+2+xoxHjhQgBj160XQezqcUL8TLdeAM8k4kw80d6?=
 =?us-ascii?Q?fOvcetIDdco3n8CZSxOHOS+xHlTgNFV625VE2Q8DwZ5UD23c+/qnCox2SpDM?=
 =?us-ascii?Q?/nAFozPXN3aSoISIdP/YK+eGYWTEds0x9C2IP4aebl/C2QcNSkNk308mSeAB?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9e6b4b-947d-4e4f-de63-08de26adaba7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:20:48.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccTWKyEPJMw0gW+l3hEkuMpxDukSYbjkgCXub5dfYalb5OsXQRriCXBr3Hia1qJrCOacJDhQ2+funD1hDoKRiZK2PGYmrozDag+OyP3MjkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

This patch series adds secure interface support for NXP Bluetooth chipsets 
to protect against UART-based attacks on Bluetooth security keys.

Problem Statement:
==================
Bluetooth UART drivers are vulnerable to physical attacks where adversaries
can monitor UART TX/RX lines to extract sensitive cryptographic material.
As demonstrated in research [1], attackers can capture H4 packets 
containing Link Keys, LTKs, and other pairing data transmitted in plaintext
over UART.

Once an attacker obtains these keys from UART traffic, they can:
- Decrypt all Bluetooth communication for paired devices
- Impersonate trusted devices
- Perform man-in-the-middle attacks

This vulnerability affects any Bluetooth implementation using UART
transport, making physical access to UART lines equivalent to compromising
all paired device security.

Solution:
=========
Implement a TLS 1.3-inspired secure interface that:
- Authenticates the chipset using ECDSA signature verification
- Establishes shared encryption keys via ECDH key exchange
- Encrypts sensitive HCI commands (Link Key Reply, LTK Reply, etc.) using
  AES-GCM
- Decrypts encrypted vendor events from the chipset

This ensures that even with full UART access, attackers cannot extract
usable cryptographic keys from the communication channel.

Implementation Overview:
========================
The solution is implemented in 11 incremental patches:

1-2:   Add firmware metadata parsing and version detection
3-4:   Establish secure interface framework and crypto setup
5-7:   Implement TLS handshake (Host Hello, Device Hello, authentication)
8:     Derive application traffic keys for encryption/decryption
9-10:  Add command encryption and event decryption support
11:    Add required crypto algorithm dependencies

The implementation automatically detects secure interface capability via
firmware version strings and enables encryption only when needed. Legacy
chipsets continue to work without modification.

Security Properties:
===================
- Chipset authentication prevents rogue device substitution
- Forward secrecy through ephemeral ECDH key exchange
- Authenticated encryption (AES-GCM) prevents tampering
- Per-session keys limit exposure from key compromise

Testing:
========
Tested on AW693 chipsets with secure firmware. Verified that:
- Authentication handshake completes successfully
- Sensitive commands are encrypted before transmission
- Encrypted events are properly decrypted
- UART monitoring shows only encrypted payloads for sensitive operations
- Legacy chipsets remain unaffected

[1] "BLAP: Bluetooth Low Energy Attacks on Pairing" - DSN 2022
    https://netsec.ethz.ch/publications/papers/dsn22_blap.pdf




Neeraj Sanjay Kale (11):
  Bluetooth: btnxpuart: Add firmware metadata parsing for secure
    interface
  Bluetooth: btnxpuart: Print FW version and enable chip specific
    features
  Bluetooth: btnxpuart: Add secure interface TLS authentication support
  Bluetooth: btnxpuart: Implement TLS authentication crypto framework
  Bluetooth: btnxpuart: Add TLS host hello handshake implementation
  Bluetooth: btnxpuart: Add TLS device hello processing
  Bluetooth: btnxpuart: Add device authentication
  Bluetooth: btnxpuart: Derive traffic keys from TLS 1.3 handshake
  Bluetooth: btnxpuart: Add command encryption for sensitive HCI
    commands
  Bluetooth: btnxpuart: Add encrypted event handling
  Bluetooth: btnxpuart: Select crypto algorithms for secure interface

 drivers/bluetooth/Kconfig     |    7 +
 drivers/bluetooth/btnxpuart.c | 1442 ++++++++++++++++++++++++++++++++-
 2 files changed, 1440 insertions(+), 9 deletions(-)

-- 
2.43.0

