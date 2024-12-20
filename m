Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D90C8632B
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705084; cv=fail; b=OtN+t/mirW5yQNx+wmxbU9+PKgj7l9EFq6bGYgQBfdqxDsIPz0VAqrqwYvz2vUFEhzvudgvf/p6zj3UnEl7AkD5y5BT0nvQyO9NmE/bq2f8R9gvIzhhuWqU/JhQDu71JHhQ7e1gIBbQnNszEwojz58m9SQrMwbwERx0sdrb5pUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705084; c=relaxed/simple;
	bh=6XGpMBbYvcQNkBkl/XyqrkN7vokGLCyzNdlnB0lPEbw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TsZ+3RwGP5gcTwRlBHAKu8bhxfKkN4ITeMUvqYzHqjjaqTDtcCahItYUqODu6P+XIT8SqVrZReZ6qR/YDZumSh1A2UTohy1t/x8lmUCdHkVgqyTY3/gwCasvtjfxLhPyCJi+j1yUmFP95NyGVgDQu15Ab8bofP/HtdU9T3KpJmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kvqr6q8m; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kvqr6q8m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGc5ZG4v1wKUhYMIlmm8l3qbJzNZak4fe/DBOvcZk4Ij5qry2gRJjvGH6s889gsKckWElUwERInh0JdGGIcWj3Atj9IwuGRH1RCPrNLExvbrfLz7wAlrn6PXskDWIj1nEItuxTDL1iUYQpOlesicnxCrvzvuu0fh4JJn/W9UuombzqfkXrt8GDSrTw54Nr+eBTm124T2RZRB9vdNFi8q/4qNRAbNx46XR9SSI81pKEKTH3XPi5hNqb1lVsFRiXcKtYSAEgEJZcNFByJjmJqgG6SD7lPl7zO+zmk0iJcjHK4KQYy4D52/FeCeNLB7fMpeC7WLdttCRAENaVV+4Tpgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RnCCMDNXuBKiQUxMi1/KTLlCVQI66uNIvNb77S/zVk=;
 b=Pg6pD0r4fKRQSD4c0T0phqOWlbJ3GFfnbRM6BYTyziW5EiSBzvkiVXBbNNTHygjR2YOcaDxtDEzdevkuSfe62X5+g9Jd3AiwmNLziwpL+T6mWqA9XU8jMXVi+Q80aS66xBFgWpnmLY8azo241XuhRxIc1O35OW14bcGTz4mXiPIkv3ypxESMzJAYKmgEUzn3mw8XFRWMmvDKz8zXtDpmebEDlbz4RNT87LX9zJ/3fDPAM5NVhKH8rNvR2QwnLefSvh6tT6Htj65JejkH+ymc+JGuOaQKiLusZpijKUDbjmHKenvgAIcaHcbIhdtDgUy1hIMuSLaF1u0tXJ0wrRGTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RnCCMDNXuBKiQUxMi1/KTLlCVQI66uNIvNb77S/zVk=;
 b=kvqr6q8ms/Uqpoi5AcL+78/4e0ysegnupNUVpnYDaW2Ym86wmgySDgHSM6tgeXjIMguHTWD2PXugGekWOLA+DUSgWqu4q4oHfDZHUIJTOiBefX/VK5UO9Gbv1OEMj8uc+ZxsPTC6zFsUiDFGtZCdyvQcm92fBsQwfqFkbJdDwwBG3WonafylgMhCbboTblLcGzhPyATFu8pvxD5GS+bfscZVEKrP0W7/q+qpubZgyRoy1OGbxhHHRZoias8QlGvGkxFQlTHW6DwjGDHdw845SqBPjZ0i+G1nFX7A+qVvjYHVg7fMx8IMqfAIcE480P0gsu/p6UQZRvZ7oNgZ3Td4BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB8251.eurprd04.prod.outlook.com (2603:10a6:10:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 14:31:16 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:31:16 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/6] bass: Handle Modify Source opcode
Date: Fri, 20 Dec 2024 16:31:00 +0200
Message-ID: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0009.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB8251:EE_
X-MS-Office365-Filtering-Correlation-Id: 11634958-db92-4149-6384-08dd2102f666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VMhEHqZAob5y23oj1VMqm3fEinNzxRtPBJBd2peQ7MijNkw8RPgWJzc1FsWF?=
 =?us-ascii?Q?a3W422rwjDCdqc4S/JQRbQjzWyvbIvP3O01nMBWYJ3wpSKTufj46o1W/J9jK?=
 =?us-ascii?Q?ozpfEL6mkd2705+cVd1Oj3N+f4jhy2xZVoECmV+D1I2Lh9VQjuTXIo7AfZ+q?=
 =?us-ascii?Q?RZKmJSzazmpwcW/6BBvWXtOEWHATwnKst8YX78hlP/B7jt8SqzvAICVaEyQU?=
 =?us-ascii?Q?bQKTePw0WPj/CA3YNE6BPcE6gbzF2hlXQaP+Js3XzHl/sUMkXFJg07AR29TY?=
 =?us-ascii?Q?BcA7UHSGNa1J5WlbcNR1UodrO7mQv+J7/9YrOgSd789/E6C0e4lkE5cCUHTu?=
 =?us-ascii?Q?+BBJnKpY3v2UyNObzCUBlO+OuDQTL7CDPtIZXcU2bTuM89aWPKOmhzl9TMEJ?=
 =?us-ascii?Q?WFSJr7wr4t+upcoSDG+Coeu9nAQax4kSo4atN/rPNDIeg95+C5ZcLXWroKe2?=
 =?us-ascii?Q?JPg6ewQoq7OcILcH/Wlnkf6uV3qg4+pTpygMSbgCTpCUZ+dtoGYPEgGNTNCI?=
 =?us-ascii?Q?niKprgaY61IRZy+tX7RQHf8uIBLIeFceCbVUo6uKvCNj+Kj7Sp9YiRozcvcE?=
 =?us-ascii?Q?JW6dftgQ3HkUVd7v8WLJ/6b3mjihoc61t2Gpf0JRVJv33NlcEX/6Ack6gwOP?=
 =?us-ascii?Q?XC7gTJzKNLhC993PbBzdIEuU5RHr80+bN8UYSsIL4A9pkJxdIO9cSo6N57++?=
 =?us-ascii?Q?9Vwa/U2J4XvIW/Zppc7DfAlfOyfpHMn1F0fONyVijdKj9r6+KgKmDrhSM7H9?=
 =?us-ascii?Q?FV1gEn6vMVI8YEML1xQZXsumcnGzbToHSRkJBF87iXqftHsjKf4oIY+0QoSF?=
 =?us-ascii?Q?6BGKLAcbwB1/mWryDPv4S0r7IIUpRu9JNsZR4E1AptNGqZ3Esg67Iq/Eztwh?=
 =?us-ascii?Q?W8y2rdYw6X3sTKg+UgTZEuGWzWoIk75X0j1bHLdKMLJLIfkk31w0bc4NcUtx?=
 =?us-ascii?Q?wzpGJ1HcgPrEAzlrkXe7PzNCvvKy+SqbrLU7JzSzakgErTd4xXZqahOH3Rpt?=
 =?us-ascii?Q?4P/ulzMa4qfPzh0/Enu7zY980u6+oGHKBdOIq+qqd553eWvaY3goSCUbTCsa?=
 =?us-ascii?Q?s1W79wYqG1ybuJy3cjSMpGSL5CaX2gCBcV+2xknubItJG2YqheA5EJ6K+mA+?=
 =?us-ascii?Q?1BAY4dDQ4B7DeRyf4Ve08DHegDP1hJwomsFfqR/i5W+ZQS2UwaTqNEzaTihC?=
 =?us-ascii?Q?5vL/7cBnHh6IiCs6IDBpXr47IzTkkEDtcIoNmHsWcXnIj06yHe70NFOIYWtp?=
 =?us-ascii?Q?XP3rw29fa5UgupQBDcowqjDGWaUWRk350tH9i4L0lZK+/dTohxjKzwWnK8pZ?=
 =?us-ascii?Q?FSrcLFElXiBE1SDKuK7qQBbV7Ju1v4TubRmOy+TEIZbKAXNIdsehga+lt/cJ?=
 =?us-ascii?Q?aTTK9Lfpek54lPXYWlSuCUF2iBw5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Ky8VmAGI1qPglWHBjc/CE7Vbf5ySJFLtBomsjJf39HnMMtYoB8yZ4enlFAV?=
 =?us-ascii?Q?QEFxtbiGM1xipRje8ggJjTEv+AV4SW/mWo/arZs6edHIiZgSkGicOVIkgi68?=
 =?us-ascii?Q?tMJ1rRMj0W8pF6sO6+ke63Dchx24rotvpHgq1T9kBT78D9EWtfN1aV8HBAfA?=
 =?us-ascii?Q?J/cYE8zrTHU0iUPwALxjX3l3m3JcX3dcmfAx9isLfla0ASZqndvXKc++RQp+?=
 =?us-ascii?Q?OngJ8JSZNEDiP3Lqyi9xA3NmVztJF+zzyw3ooIJYWgzFJhhl9OZ97s/B0Yrt?=
 =?us-ascii?Q?HqwjI+MOGLEL+UOCRa/KOhYL7MRM0IORuihcO96TdkU3rN97qKkAvQuV0w2k?=
 =?us-ascii?Q?fZ538JsqkR7PA/Oo8LhHpYUcWNtretRQEONlSa+yXR10RoD03oV9qcteyMZ/?=
 =?us-ascii?Q?y1qdfOLeCrtKiZZce1P4EvlaowqPPw89d6MIzYiPBzV0491Pn3KQiOiLIKMp?=
 =?us-ascii?Q?LhhF/2XWmHNOylrgLy/W4YM3TniWRtOuieEs8T7yFm8CcYJYY2Ow1Hnf1kSx?=
 =?us-ascii?Q?m+R/ej8BPZG8txkjw91j7accWGmqL6syC+2PwuLTZHCqL5LrVlQwu+pOebGp?=
 =?us-ascii?Q?DJ06GD7ZoyP90ywAauVbChOoWMlfm4E5pwVhmYzFjJsywcdBuQP1uNSUk/6o?=
 =?us-ascii?Q?YtugEilQwnFwQ45RITf3WCS4CarO+m5Mtak5j3hP8McobfLuHLFcnggEeMDc?=
 =?us-ascii?Q?OJoY+dldjmVdYeLV75kIS76zpg8lD9V0wSTWkUm9OeD9ALm/ksoPFvNKZtYx?=
 =?us-ascii?Q?OgTBJXX+9aYPCeS3u/FTVpt80Ca8wh+Y2P9VhE4XalXf0/1DV2CWx+D7gZHc?=
 =?us-ascii?Q?aqPtA6/ONjVRw1v4V0rFXwds8brhGYXE2BehFcsaVS65/rldhTAhOKR2HUBU?=
 =?us-ascii?Q?kV0f71FupLUAf4eaPJ18pJ/RPya7STmfFR6PJqiIqMvoG6SRZW25L0bX9n6S?=
 =?us-ascii?Q?uJBaZfhIvkd3TfWORuIgm5NZQGLiUno5rQMWQ4YKLcOIyOWRh8Atj+D1n/bV?=
 =?us-ascii?Q?umL3fZTiuJhFstqtg4uhdx1AEUB2V4F5gSge64XUBUneRkIOf/X3eiZ1E+v7?=
 =?us-ascii?Q?bJSJGNQD1xlHiNpEl460OHrvNBOtLDtKxWMjnocB3KgurA5PwGto7el7uMSI?=
 =?us-ascii?Q?PYxWYloAxrMZvbrIdc7vQdpGJf8DTz28qCN/S45C4/gESHjIqvFbW1mi0wMl?=
 =?us-ascii?Q?PY2r44LET6kwbODpwQWRxaVPGogqS9kJliUz24pMO6l7NxcRLgypnbjVWxQE?=
 =?us-ascii?Q?OiJLTiiZ0X1kJIKUtUmdlhzJnNfKKUIAfpFUZMGVSWuwUqkPHb9WJvE0cWDi?=
 =?us-ascii?Q?RcyWbYR/EK1+VQ2EaiV8El3j1s+Oi18RHcDpiErleNNtyAhBfmQSOEAqVA/y?=
 =?us-ascii?Q?mCQqjXV9Y0HX20QQc2n58XkQIvGYslpEYl8G93/vIy4yh0Pqxa+60YzcItJx?=
 =?us-ascii?Q?PeMTUA0x4RCMwB/AqtdB4K4nI/AX3BXzVG76xVX0TLnteLVYLJqa80vOHsRg?=
 =?us-ascii?Q?Gbcpt90tCCWdraZ/7muvXPWiXqfdib9+Y88kZ8Ng2Q4DudNnG+B+lIFroxTA?=
 =?us-ascii?Q?rthza5fs6+kHPFa+VWAmarfZOB+vn7AnLuVTQzbyy/q9pxbyVYWrv99GP2WX?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11634958-db92-4149-6384-08dd2102f666
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:31:16.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfLaVWKjqxVrp6huHoLohksZchQXxgNphDFKcnxvD58eZnl7D2IYQu36J0FfntFzTcRJqbTWyIBeBpDEBLe86g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8251

A BAP Broadcast Assistant (BASS Client) can write the Modify Source opcode
to the Broacast Audio Scan Control Point characteristic on a BAP Scan
Delegator (BASS Server), to update information about a Broadcaster, such
as metadata or PA/BIG sync requirements.

This patch adds support for handling the Modify Source opcode on the Scan
Delegator.

Iulia Tanasescu (6):
  shared/bass: Fix clearing BIS sync index
  shared/bass: Add API to set sync state
  shared/bass: Add handler for Modify Source opcode
  bass: Create setups for all BISes in BASE
  bass: Pass delegator reference to connect_cb
  bass: Handle Modify Source opcode

 profiles/audio/bass.c | 218 +++++++++++++++++++++++++++++++++++++-----
 src/shared/bass.c     | 110 ++++++++++++++++++++-
 src/shared/bass.h     |   1 +
 3 files changed, 306 insertions(+), 23 deletions(-)

-- 
2.43.0

