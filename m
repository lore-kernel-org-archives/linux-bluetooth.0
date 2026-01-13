Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA354285058;
	Tue, 13 Jan 2026 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290416; cv=fail; b=dPejDgSK3af13xyjb1oubLPsWWcR6bIAcp7/n0JoIAE8gq0OId4+5uaGAfw0BnwDZXeDxhhIRVohG2xpN/RcANVjwdtq1SK1+cw0rUmoN9ka/rB20IQgdzpwZdH4L6fvIJCyO1ZmpA4olp4ptdPoFcKnsXynvLTAQcbIAZSerLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290416; c=relaxed/simple;
	bh=v/+IANBCitrH0JPPZW8ZJyA+ti5aycwt0Po200aux2c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aVKsZQXVIRtYWJnXyu/csx3gVIzYQyCGQMpo3I4+SL5vEEJGIrwxGLQDFTsAduW3Wa53vMPfZWEbNBtN0Cv00CxVusAuMJANZvem1U+5nPaWLlc4z06j5E07E0h2aaFOPAJ6LoEsf0IEVOJsJeET++dJoa3kfXlAwUZeqJQBt9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QgMDJj+G; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QgMDJj+G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rv/U1l5K3wzxf2zsobmLCYrhpX/IRbUv/foxqJvJfQfmMImDubj1yYUgScyN6MXBs+cgvRG21B31ioln0/pPvYQseFFdLZaV2EYYaVFEpqJwV6eoIJYoAaP6vZ0lSyF2p3zyJT7rvNr7h2hab3vCVqkDs4PdbRSBWQSDcGuTHaMTapiuIP74L1YfAI4W6bCqosOuh46b5e0+dWGdyIL6iNgomIL8LvjwM1ooCOyvgx1V/Evp3Z4q0GVhVOMIttIphuY+DeKgUUYClSOjgvxvNh9ERwsRdr9V6ZBcTPX425sZXKBS7/Av9Jk8Ks3XARJgW+LXXpcQRFSnH6NJbO5M3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx+314doJI2eQrzvv4TMxXzH0PBnI/4dj0K+ZciJRWw=;
 b=E5zf8qlNzQKXZ/SCdeSdweqXxX9cNIyq/H8CzXvpKwsZ5V2WHXryV4ZFRr58FWuMSC3NRmxiiiA77pFZXhaK1C6LWu2ljCMVDLjErzclzeYloJLymJgB/IDbKIydY5vi7Rigv4JEQV0lAXdPIpCN+0vrKQnj/WPBGc7UTp/8E0LeOZzR+THSkVZocDFVleJ8R7HMO4QaMWi7KG78HSTzjPL3wSS+5HEaUv+/mos+ehbZcnAVPDElnLWkcsQeppFcDaYAUi90RsiCCusfboULtJsWUcPwSE37WHyA2ZMOW+vgs+iIsX0a0bewfqRYQaX8+0D+MxOBmCmGXKDpN7v2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx+314doJI2eQrzvv4TMxXzH0PBnI/4dj0K+ZciJRWw=;
 b=QgMDJj+GmkjkHfpLelj6MLRHGSDtsGQM0E5thu/+9JG19ruICESO/ltrjwCvRfH6KmfrPkH+j7wP0mLGn/JXGdIGNLMWtIphoPdLJ8nJ5t++kJoo/tGbylO5/wdne7gIz2z9bvxhtYOS9jYW14m8VYaDILmPeHZ/2/nTWGrH/XoiLAUJxYqlDc5F0WgOiU5NONiJcYwy3YJNhd6J8Y8wfJWrSmixMrwwwK2N44b0JZnRcw+sdmTl+n+rxt7wT2RHJXSWH49+E/4K3tzT2Gioeu7jGiz97jnPm0cn8NaMjwypnp/EsM+Z5GCN2MXAapDiOLFtZmtwKFrgcJlmQoBL4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:46:49 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:46:49 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 00/11] Bluetooth: btnxpuart: Add secure interface support for NXP chipsets
Date: Tue, 13 Jan 2026 13:17:07 +0530
Message-ID: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cff4b75-eae6-4db8-01af-08de5277e8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sAIYg+h50a7G2olYN9eec+deQ6iY2sDePee8ShJxRKV6S2y2K/6lyUVleWwi?=
 =?us-ascii?Q?pd6Df3ApREzGzXfkO7nUuoLYkjXW9vnMYXCn+SlhG0ZUpo7cC/WrbtlocoVw?=
 =?us-ascii?Q?cjF70lG0/NEk98x/E07YLUVbIk9aOCvdptv9T2iXKLPxpn6ZfxaIkez94PnQ?=
 =?us-ascii?Q?Vz9t+uuMZ6Pfdoy/RCfVqFlYXH/Kux57PBOPo8S9XwbQnU9hvjfcwVzEed9M?=
 =?us-ascii?Q?YQPaY/BVxkzHbj6rRfFo2rdNgU0iFs4aiOqORHMKRS4c5zcF85ZkAzKxxR0U?=
 =?us-ascii?Q?w/0CYgVO2zfO+myE1aHJWwWmCI+kKezgMbVR7mQF/6tLjP0n1BgYXS3E96fr?=
 =?us-ascii?Q?gJMyu2mIda1F+nMq9+454BsphZmOnmiTlpZU47hOT5oJ/juXpjmK1xh8pZxR?=
 =?us-ascii?Q?og2qdgAk4oQ2A7aqJ2KmBLbjCWjHxZrfIuMrEJc0eEPeCjkkPKyz+N91ejGX?=
 =?us-ascii?Q?ZZrPoDcDIV1+Hw8KBrkD3XgV3attNYV8g2acv9zdoKIPdAdFrS/bWx8iK1s9?=
 =?us-ascii?Q?jq5TCN6dlnBq94ocEBqodCjL5mmg46ejdB7ZW5GNeZPFsaAO5jFYz17uA1pJ?=
 =?us-ascii?Q?jGTF2bK0M0Ce0TkRJYHCk14IAF342q5Po55JLlgzaPGUbiqjD9Bq1i6ZZ4rW?=
 =?us-ascii?Q?PSCNXLWLJX9he5i0MsIsv6P7Ee2I1y+A/8tQt3u5WqSxqeAP+EPLfqyR+yz8?=
 =?us-ascii?Q?y547t44TkesgoK5cydYVOFi2k1feCxsTanfETOS0FwbP9UjvTUMTZ9C3k9LR?=
 =?us-ascii?Q?wcdgf7LcFlQs6JR4RBsaHswSmnqqlAOlw+zBU8S2NXwJaMB8LPwnbzDf20hd?=
 =?us-ascii?Q?Ux0k1h+YnZdthww4B5HS/DRKzGbMLbj8Zs7Apzv2dpJOIrSCtHYw+1wHMJ+/?=
 =?us-ascii?Q?Sq3hrH56D5kdBunnQbt+J4NBlnVmqHSZoeJ98aRNCW2/YtFPtgXn67aoPvME?=
 =?us-ascii?Q?0oQkSbdk7iC5yaFn6b+MVWID02324Np6IA+xaDPObYBjQNWhc+RPjWiHE0ZB?=
 =?us-ascii?Q?RUOxYiiw4nMXWEbIf7ptKNiUkR+xE9lDaGMSX9gP4fTE0IAIBS1vBSH2Z35q?=
 =?us-ascii?Q?L9VdHkEu/7LLypz2kr6tHx3lzHRFPkaW7aDQCSwvj7z+KSx7A2sQW0oKh1rF?=
 =?us-ascii?Q?egKBblGF/gibghYe69oIDIaF/kctdcL7yO+vCzVLZk+/2zJG1V4Bjv5Yzw76?=
 =?us-ascii?Q?DwDL1V/W25JtQWmUFed/WqHBGCApZyBBeQ/fNOvJy2Fv6GWqmNCqXucA88bd?=
 =?us-ascii?Q?Ln7FWxCwqYqYQzOWdJGnP1LvQ+SSYa4UXB0Z8em/7YDNDB/q3pYEF2+Q6Y37?=
 =?us-ascii?Q?T5Zw4yg1YFrybF/CAivSeX1iMYWXP3JBp375RVW1qXLeuCwwrdiF+8Ro1qbq?=
 =?us-ascii?Q?Wt7fuJ2Ero9yBQJwwUR2OMySMAeYJKiJnHvJ++RYFsWWNpvnh4vP7X0OY5r/?=
 =?us-ascii?Q?NbUXY/qLunDcI2niv32EyNtZHScdlhIQUcPCWH/0UbZ2HCLRZ5eFaZZ0Vbld?=
 =?us-ascii?Q?WkqD6HFPy9pS2e/em62PMfHUBtQCRlqYEMBz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i1ACChRvVjVQhSRLZP0QPYNGb6nQcItpGB9jsWbAPpcOXd4SEQYFzG2Sq0jB?=
 =?us-ascii?Q?Z2YOFvDqq4DITklL4sSnNufvxuwEAodfBDrbzCybKsdwmYWesT8Wwa1lu6Aj?=
 =?us-ascii?Q?bJWA/j0/4YoeOxfWpp9p2ifQk2c0EQaPXSLNS6PCL8XECsHgGVYbAcAC5jej?=
 =?us-ascii?Q?SwVvf/47BrlRJVZNJOUUKHntUceK1G5lU8KOujwi2MhuZhJlBtGhfrxenH19?=
 =?us-ascii?Q?+TUd88m++76iL4z+ronvnmbXPolY8K/jLq5E6AWMtckgRnltahCALMUZAsem?=
 =?us-ascii?Q?alIfPH/96NS8XWnosMUWPdiaFxTMBbxrfucbXgyNWS4+OlWUbOjcCqaEChGU?=
 =?us-ascii?Q?WA5vqSCHeUV9ieKG4aTqgDrUmv9UFm1rI/JObSzmMaSemdKZTDowDM34kJgL?=
 =?us-ascii?Q?eorxn4Vl5kbSIgMDD7h4nCOhl4jukiudrCa5j5XvPQh+x8uo2EQy33FMgXj2?=
 =?us-ascii?Q?vpZ+iPV1V5WS7utVe9U41fTT4wzTyLCLBmYFokP6qoPOcWBprRIDICMg2O/2?=
 =?us-ascii?Q?YixMYgG6N+5g/W1R5xBbeM+zv38EDHe25BWfXhz30QqsKHScga0Rk/NmD0E2?=
 =?us-ascii?Q?Rnnx14SGF4Y2sNUIj11ahBfsi4Pk9OIYQ+UMuTopiy8UvgylIpT681s/+4Dc?=
 =?us-ascii?Q?cbF2XdlyM48NJa70hBi1J/5FTp9gU+JKPLNkT4rSbSla3KGb8/a6H0bQ6O7V?=
 =?us-ascii?Q?Lk7NGv9jZfaOFTv1m++DHAx1pOy1pq4T2SgxmqtPe4zFHXKdOikk5MHFNnqI?=
 =?us-ascii?Q?KWNNfVjN8e+IhRJ2amAVJ4bKHUn5Erfdk0I+tNWp7nkvG3/OqyQPuwsXGyuS?=
 =?us-ascii?Q?9+mMrkIgG5RU7X8Ncvl67ZF3Oo2iaSgIk1YdI1zdVCD9TpetLrHYNzp6gNsa?=
 =?us-ascii?Q?WaB6pJjCLT2fI4P7vPfSVzMBuMddWZkRQSo8j9oxVnq8N/hDWM8wjE1hXUIk?=
 =?us-ascii?Q?J8dD7ntc2NpGKNBlcfPLF5K8Sq2/h8P9X0U6v/KxutDx1LS7P7IQY1h54K5o?=
 =?us-ascii?Q?/eaEqa1gTXSRaEqw0E0VW5ZGpqEjUrFSLYNfBhY95I/8kDadMTpULwTgYHvG?=
 =?us-ascii?Q?ZUBMiqFHfjk7TL98wCLT6Pj90S3UGLtI1hbdL9zej4zO7qZgQN+u1LFFCvEg?=
 =?us-ascii?Q?cPXBxJMgobPuJlEpORnEnmgMqD5J/i/f4yYfXAX9xgKK8ZmCccl78Nps9cF+?=
 =?us-ascii?Q?HWkncqhVxEkwR7QDwhVVktRWyxvRJvC/1h2SxSK4yxBQYwQO7eeUdmF12G7r?=
 =?us-ascii?Q?MHWMqmq1O74Egi90bE6TfHSqoS0itxeHEWVcfFFMPYauvZtlCHFYjcztH1iF?=
 =?us-ascii?Q?3L+jFM8Gk7RPHK7X51AmcqRH/q1/mki9f244sElD6RSSF5fepvQsUIKCYTAi?=
 =?us-ascii?Q?FZztx1hOs6sEiLgrD5EYKOK24zBG8CLr/aXgGC6iUsRqnKb6hYQWuN4coXTk?=
 =?us-ascii?Q?9vS1TEiUsjuNb6s9PeKPbZSWPaxUBTSRJ33qSFPdCUPD6SA0YfFUXBmffzRz?=
 =?us-ascii?Q?SU8Y3+tNiNb7OjoMJpPRkXNLjnzUY/ogxO6f9XkXMDFtqfMQSyvvB+033/8u?=
 =?us-ascii?Q?EWvATWju2k4NuDud8xY3lhNbpCIT2uoGjYCbB5/a0XlJYLLojpm6NDpZyjgk?=
 =?us-ascii?Q?UmmPArdChuHzSk+XPiC1re+Fd4OARaBicjW8/Pz5e1yS2CowxJXudQS8oEsX?=
 =?us-ascii?Q?xdUEHJZU8JEvnKrnurmMi9+H15IRNesM1K9zY588DTzkOtOxk4QI7w/0/kZz?=
 =?us-ascii?Q?Y7TNNsrwoC17FYIXiUk+VtZgI2csLvc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cff4b75-eae6-4db8-01af-08de5277e8ae
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:46:49.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMDpYrT9rsJbGTtl72X79TeDJlsVVlCBYes6slpyALBkvoJzacVwuFh6sQ5QoL3qtvOHj0zj6TXdol4Oy4KRvcoOgh88LkNLv9/nBGZQQ5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

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

