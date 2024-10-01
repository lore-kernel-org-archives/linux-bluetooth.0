Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC486191F81;
	Tue,  1 Oct 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804385; cv=fail; b=TLFtqZvStlG4ZrpglNhmylo6LbdtEiqTiVc9jZzEAF3tMcLGhJdGBBimsGNcfZVuQ/qhXvhy+BVl6CR0XhkmBraJlugBi1jo1BWAOL3/sQuxqJoacVz2TcBPRUMPfSNB8MuqmTlK2PDAeK8qhSGmStDAyePpU4OmWsRhfpsqDT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804385; c=relaxed/simple;
	bh=F1Qe8iqNPoNVEM5E0DQBJQAW/H6qmRxECjHJQP48HCE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Htcy1A3Dbo1bmAlKKNy1yQN/AYpim4UPxD8atZHVG4GZ+ovICGCyE+ftg37sJXYlHUrFSvtA/B0/CGTAc10hcPuZJ5CPme00JcJwDpPK20jHG1AWKgzDC4gYWVI80tbdLIdiJd778+Wf6dXzJFqppM7CcwQAwWu9Sn1BZ9AA5Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bj+mW3oI; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bj+mW3oI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8ZZ2K699SQnaymcIaK/DKXhzkfMB8mKvqU6rQEyDJkYSXEfzYdWjsi4oG0C44MJ2vWwIKqIxA/Gt4i5LsCUhLExeqJeWkZEXQ2yUz2OK7xf/MK/7qe59ABV5TmGkl1nawN0oCxf8kQisIjBwKdRez0JOTKxGvFshu767uoKKtM51Vf+YVazN2Qigh+Qw9DbWh3KPxkFTZKPA/7CDvRuVPvgE6wATdPImg9neZRXBnse5AlNA1qVGmqpmdYAJHoLnxaAgg6FQQSdSF2RmuonL6ULJsTE4Z28WJ24QMXt7Kve9gNWfbHfbLjTZlGfMnzO+eBXyywkzv5AtRJhERdtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+aC63IEkoflcwTkVlSJtkivHv9P4FokqJLLQEIsONs=;
 b=x0ogeV/H0+Ieo+Otd3hFrRbVeINr/dQBLl9o7/1tKOqhOeJ63FAPKDQ+tSedRegDcNFYrWKfU/3WNYyG1NOkGijYlvv4/UBxuyUirARfYhCtHKdRF5NAmZJffb8o1Mw02QuEjuk9cyzx2JLBiw/gSlT/zL8tt6KP9f9dT1uw1OllkPzvSfPc7kCrdZn41u3763vnUoDjHt0Ns0+iQ5I8hUhtg/Vs6TNI+KmdUIhQ6ndOFLOlKSHgx/gIUG5FQEht43rmPAz/aKlKfh0R5fZqVNjD1Q7bXwZdAewz03WNKKRh/XwWT+tBky+ZK3UtismmFqVb2luJ5P269q5056AbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+aC63IEkoflcwTkVlSJtkivHv9P4FokqJLLQEIsONs=;
 b=Bj+mW3oI5q0r5biyqTLczaXyphV3WDOnUyjXWk1Whg6UxeTRQTXYDVSQN2l49xuJm7WHB6WMvXNhGWk055MffmjbdsvfdMgcetYSfbm79WWNCakAuHYtPdUpmXtwlMgSQFEGmw+EGHvRyjQPLBtm3MjDi/dLp4nSTmbEVWT8vU69nt02rOMjqjuUMtGYsuoRC2TqwgqPBmPgpqJfHgIMoBvn+Jo6hYHN1OtrUMSPRnKBkd1bcXt1/xZCzJpnKn+KfTO5uiI1hsJ6CkFTUIzaMbfguRV6GXbs4aKdfTrn7Os+5guVdU6vVxm34mtOOvc1nX1xIUjnRU0yzskaiiVzYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9789.eurprd04.prod.outlook.com (2603:10a6:10:4ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 17:39:40 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:39:39 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v1 0/2] Bluetooth: btnxpuart: Add GPIO mechanism to
Date: Tue,  1 Oct 2024 23:10:19 +0530
Message-Id: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0130.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::27) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9789:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d4e224-df7b-429f-537f-08dce2400670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ozJkWNJhvj+av2LEaTtVAEDfuxO10cCPCKAu+KX/N/iJeR3zV9dyzEQXpLvv?=
 =?us-ascii?Q?E+2ODf+Q5gTO0/BXXF0EoGjhrj4SnojE3s5tKwzQ8N1WGW6mMqB0r2cEu6n3?=
 =?us-ascii?Q?dR0FOFbZ86mbZGxs+b6EGh2f6+ntP0SCMh6A7zQ7UljS0WzJLNYCEkwAy54G?=
 =?us-ascii?Q?DOLcOO+NLnPhH9V67eMx513ocMQc6HyLnNAxL4RhurXzKKsYt8UFlkZu8GSQ?=
 =?us-ascii?Q?eoJdkMTtoJhAlW/i/nzT5R0wXcCpPgI42b6tLav53Hl+AqiEjwoA14WaWyoi?=
 =?us-ascii?Q?Bo61u1eKDlbxLavKgEtRRWuanrDxr4gYXlpCY+FDqsPky646ucCLG1/KT5NL?=
 =?us-ascii?Q?v+d5uOvyn1LoNfeYPLofe2H6poD52qttPwlbz+y82hGArAaW8JrX6EaboR6Z?=
 =?us-ascii?Q?Q73yJBRY51EY5D4o6JmduSyvSELv/dS/y/pqsF9uSCAqayyZLIvrmF5XWV23?=
 =?us-ascii?Q?TMCqyjWPnjSAMr1fxy1MXUAObd0iDiQNuOx5NWLKGN3ZicH1CI5sbFEPelW0?=
 =?us-ascii?Q?llKMYjkkLq/HkvgM6gcw7uIPVmes6zpvcwwk75tY2flvJ62coKxRx8CrxQd7?=
 =?us-ascii?Q?E5+pRQ6fWjEUxkG2729+TARMHy2WrNexkiM+GQI6tjMiB71zJzYUKDot0Ui/?=
 =?us-ascii?Q?O89zgcUnyZTFHOk6Pd0f5blb5eTPV4+UpSCS4gBFt9XsDLkSuNPxTIIQ13pq?=
 =?us-ascii?Q?80xhsVsVFUel+cIrrbuYW8G+d7dfwvw0hMcgNdj5APaAqjrSXfq4lR9z+qb9?=
 =?us-ascii?Q?BXREEURRPdzZBzDu1QwYDKQJDW6Iuzj+GSFHN0vgrWcUTItpm/5ruARMZ7ZU?=
 =?us-ascii?Q?1xYMSiW1OTvQBXKTMA4L9cnOj+cV/GHFMa3gbCw7uTZg9aDuFliXsZ/U8fLP?=
 =?us-ascii?Q?LjcNPfNvFcfx6tncUM3H4qwMM6sOdy5vUuAnte7SJaS1Ifv5mAUTUUNw2vSc?=
 =?us-ascii?Q?issirpnZ+WHtUoUWtepihIXg3j5NCUhDwlup8HyMidkK/wqBvD6FIKHql31z?=
 =?us-ascii?Q?jj07e7XOK4jKSwJgaqBmnRxGypVAhANPV/sIz7y7UJ4menREmkmMSCuxE42S?=
 =?us-ascii?Q?WBMyskfUBlzVqv91ht6xoGZcbm+ztEqrZVVpSTUe3HQ/doAt+oiFKdvKzNTg?=
 =?us-ascii?Q?BeT8xRyxnK9qgjprvhKzibdJt3zUXiUtvo4wD/l/GSJnhZ2vMjcDJzlLRrHG?=
 =?us-ascii?Q?NVAgpvLAKvYCbBybeij9QfhIUoCdSDXi+ExUbZxXQc0a2GZ2ttWA1vE0ZmWJ?=
 =?us-ascii?Q?zUWECB1ZBG6rmbsVyMLOC94TdM9upBY6b8nCCXZPALIutvmYtNJqCyGkdURo?=
 =?us-ascii?Q?SWj2xNsAgwJHBbD7WCnwnJRnYcAGUbgPcCcQgZeIaKduXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0heHXP/k2SnOfizETl2thn3k7XZfdQGCGnGyKrJumzh1a7UStJqdop348y3?=
 =?us-ascii?Q?Pv/rsjlRusfkarwFsGSZCPIaAHy6ncZ8bSAWVTxcV57IjoTh+HEq9cUsBXpQ?=
 =?us-ascii?Q?9oMj71F9W7FB9dOGuhHt1hjV81J8m/M9wLjp0rJRRm4wbmPK0+4nD55c2huy?=
 =?us-ascii?Q?5hoj8XqVSoIuN0473DSaG5B0PW63omeuX3BIWsOBIIa0Fm47+TdcCp+/76Nu?=
 =?us-ascii?Q?Unxcg6TIB9Q3zseGdUQZ17mLIRW81Q7wXGCT+lSHeXoy05pUa42iKYI91m7z?=
 =?us-ascii?Q?TsMPpGys0QkDxGUqe/NKKNWhKpVgyp4XR3r/+7Fdnlp2pk66nB72io2Dblgw?=
 =?us-ascii?Q?6FnvraOlN8Y1FOEiwXIMF94tbZngnGfspEFfDOq7laGhFw7vyvYAZGuBU7GO?=
 =?us-ascii?Q?c4JryOOyTO2gqz0E2Jg4Hqj3uiWx0FwoIAETZ6oUcvJx6/I9ZoaNX6rFWyeP?=
 =?us-ascii?Q?YpcK9BWeTbcjaP9W9+XAQkwjuX9I6PK8i0QCwT2nNE5BQXrSIRWke5wGCd77?=
 =?us-ascii?Q?vrsl26LGUz2CKzYZXKIkMU4q41+4fHpfTjFqwJ76mdOBrepAipOTpiCpcJko?=
 =?us-ascii?Q?YrP+pSqqnokZZHM2zIq74TF7GK+jaNoTNjEdf6RI2IyRS5VfLHKE3/TbazmD?=
 =?us-ascii?Q?P+QiJfNTGp06nVO+NgkwCdduqs67MJLO4KApkWSc0q28LIe6Vx3u/JWLdwVc?=
 =?us-ascii?Q?j68fvzFX/zEPDN1XiH0Ks90yEQhbPlEaq3RxTBc8qL++6Sa+vQOjxdTDHD3u?=
 =?us-ascii?Q?dw1/9BFCTxIpbqMozWlZhyhEbUgpF7aqZbxEFKN6EXjX2OInhfVqVnAKgvdw?=
 =?us-ascii?Q?l92U0TixsuvdJLBsSqSUevnNCqsc/8A91WbmRfw0SIPLq4BCvt7IUy7G+S6D?=
 =?us-ascii?Q?uPiVJk3sXW4kFmggEutPB8ijQz7fuYdQSHinzNPVUXNssD1HJL6f925Izn8u?=
 =?us-ascii?Q?0FSDkTlOtRL5hhiRJYKZkCF4L6eqKb8A1pEEBvoc8VCb5HQM1zMnOcZZwZgp?=
 =?us-ascii?Q?sS2aKTRl5U6OM+lL5j9Gc6zKs0aaK7qCIxAQmzntQpN/kORo8nA5q5OeH9yo?=
 =?us-ascii?Q?otR+PsH+H1qYVHwtoEoW1jTdPZnW1GVh2R7AsMmTFhfW0s6GIVj90kPzTuBP?=
 =?us-ascii?Q?e1dg9mLc68n590CaaLfP9rLgCAa5HPr4KYJTdLFvBP5DEm41mtr2DzJGXtsY?=
 =?us-ascii?Q?RbJ7NjYJIy//RWoHcQaHMvqV4lRsoKgvLLkLVi4zZA4P2c3X3iRLZ9LnFON+?=
 =?us-ascii?Q?ZNWtS9T8rCkf2p67L8WcHtn+g84ymT34oQ3HjiFVwePgY/a6qvXv+SY+L7qw?=
 =?us-ascii?Q?CRzG6nxCfWApnZqHP5qS2MFT12n/SrJj97hc3j7rml2z+mQECdZTg9T0atFF?=
 =?us-ascii?Q?n79awdY4H559veZ8A7Ydk9j11B+HOE1IJgpJjdcS73g/LkgxTSMyjrm6s3ES?=
 =?us-ascii?Q?e3TgvgXregCzBJElRDlTl7LLr/tqBIjNia11tWyPMjQLYiupTU0KKXblMSZw?=
 =?us-ascii?Q?48IOdX/ogGrr43PLThO3bz/H6dBPTPUQK90tu3RRzkn4z3lc9nUk1g+dCrZr?=
 =?us-ascii?Q?EAGwLsM2/KRHVp1hyD51AMT7K3/pnKYAiPTqQKc2ZJiH0DM5+almx575waV/?=
 =?us-ascii?Q?BQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d4e224-df7b-429f-537f-08dce2400670
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:39:39.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htBr3hfTVLSJSPWqh2/+ixu3HNBrnAmVYJTmeo1Ie3e+bXpmIlzN5f0PmEHOns+zfHfp459UBqIPQ2XQdAFZVGBIMS2x/xZLljbl21UvWu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9789

This patch series introduces a new optional device tree property
h2c-ps-gpio.

If this property is defined, the BTNXPUART driver uses this GPIO to put
the BT controller into sleep or wake it up.

The vendor command parameters HCI_NXP_WAKEUP_METHOD are configured to
use GPIO method instead of UART-break signal, to inform the chip about
this new mechanism.

Once power save feature is enabled, the driver puts the chip into power
save state by driving the GPIO high, and wakes it up by driving the GPIO
low.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Neeraj Sanjay Kale (2):
  dt-bindings: net: bluetooth: nxp: Add support for power save feature
    using GPIO
  Bluetooth: btnxpuart: Add GPIO support to power save feature

 .../net/bluetooth/nxp,88w8987-bt.yaml         |  7 ++++
 drivers/bluetooth/btnxpuart.c                 | 36 +++++++++++++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.25.1

