Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2058.outbound.protection.outlook.com [40.107.6.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B36171E65
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 May 2024 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912209; cv=fail; b=sMGL8uPd2jsfqxIYmTgXa6L8FYA7UWnEFGARBcV1Qu4ngev3cy5vIHuxCeMtuQXd3qNELJfNambpHtp34psVUIE2OvRMVTTRcPI+R9XBfyYTigB7tKbqT/MYfXzEp17GiPQFABF0oNs8I7P/+JBsb0qrcalaD9Tz5+zdLcx6YRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912209; c=relaxed/simple;
	bh=nlBKL3wbzNkT5vRqZVZMmrU/Ujibv5C17kqxsgJ4kmI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=KbaDGz0MPtWZbC22crJvKpdqkr2jkhfAU8geC5k5vEtsDZevNxhzwXseQ54M1KROD0tJA2IaAcT4o6VFZrgBxCyxnlnHC463dtnECSEcNrQ1DRYMAM/YY4QlPusicerMg1MqHZDpcbexaiMNb4l1MsTJGnvCQpk8NMK8VK8Eqp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N9CR57cz; arc=fail smtp.client-ip=40.107.6.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N9CR57cz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmPr/67aHajlx5cP7k7/dObqnPepBrB9jQ4mp6H45OMM0m2zrP6MOC/puk9O0Eigc1gN3PcRb3fUezHOjXfn7ZoCsIPXYKLtdGKv23HIwxhStPxhYkFC4iqJXhC/mnpdQW9es8E0SwgPtNJ02R1m1IQi+LuRIoU2vINrBCYHXWitcSMBwA6r8Qt2WF9O5LvSdIxl7zqDVdVvYHeD8Xa5vMeGjm9zddKTMSxussgoydoPhe+9mMP8YRLzqPlDltAwiAi2zh7XLfCXSyqdvlUI9KSA7QuyfLY4sROygol+lWmq4qVgcSlKnGKqkMV37185QboM1+xaaMashsU5mTFG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoLmKeM6ZMCqFui7/iBPCk5UW3rp4IhYwbExEWo3MMw=;
 b=XGREu1Jc7z2MljpolKEfaZHWlkwAY77/d54tqlmwnjXdN7u9xP1N0bAnYYxMqY/SjmfgpX3Rt1DTz/DDRXbkFIDzsKofTiMJ5re+d4mhKuJxztCzpPPcsQhQW/ZOlW2KnZAnVPl/jdRJdG7uovqNqcyJL48/Hpa3rIUKzQLXeI+2Z7bmTTqnUEF8z/HSE2C5/0uDIMp8j0kkfxiQtWHMcLKzlNGTiu92wv+B3ByqYDxrnZGfBQ0+dRW23VisE4/sHs5hMgmuvWy+3bAsAJ3bclVeuoir0RAp8R6g9qftiy2U8+vyY8Fa9dz3elD3WqaLtTsaHohmE/tvsRUUQ0lTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoLmKeM6ZMCqFui7/iBPCk5UW3rp4IhYwbExEWo3MMw=;
 b=N9CR57cznUtuQCuX9rimOuyeUiRYlPjHF7Sq2MJKMSt8GkwmtOc0TnMRxHsy9TAS1w7lZkh9X42dJEUHcrl0aRNimTncs/KvUTBlTmi/NkLDdvYiEYIAlwc5XCmxchaL0zhrtMuk+CBTMSK3iPdH8WNsIzEVimnWWQjtYIjZBsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA2PR04MB10374.eurprd04.prod.outlook.com (2603:10a6:102:41e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 16:03:24 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38%5]) with mapi id 15.20.7611.025; Tue, 28 May 2024
 16:03:24 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Transport: Update bcast sink transport state to pending
Date: Tue, 28 May 2024 19:03:19 +0300
Message-Id: <20240528160320.103845-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0059.eurprd04.prod.outlook.com
 (2603:10a6:208:1::36) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA2PR04MB10374:EE_
X-MS-Office365-Filtering-Correlation-Id: c82f0c87-71c4-4141-2fb9-08dc7f2fb3f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qdhgd+bQbggJCgI9piHbse6ZvTBPvkoYByr7+OhPYfAdvSYqcPjuI4Vgwwtv?=
 =?us-ascii?Q?saRZV+oqJ6Z8amd5tNrN8N6EbwmBwoOFYhMtnvFMFi2+EbviWm+sAIr7mSX8?=
 =?us-ascii?Q?1Df/rKcXC+SoD72Wk1p9REdGlg/s5jJxkzaIwFmo3iX04c1pw+3uApViJlL2?=
 =?us-ascii?Q?8KyYVSiVbtn9mIo1hDaTmENFdSp4OwXcDlK+3StGwF/9n9GvufgS6ipZfScQ?=
 =?us-ascii?Q?lL9GRoQq/sUkFymEe9gZfsqwlPbrcOpDoEG9MdUowkYou5KjyC96sRdfeQum?=
 =?us-ascii?Q?2j+4KYLIK+GNfO9KSReblXFYvhQed0uc2cNxuze5Dg4lZXI5lfx87xOyHmfY?=
 =?us-ascii?Q?5EsIY1GFeJoNPuv1g3qcbSY5CZlDTKTf86UTr2HBiUDMOuVNeIvZSXpHF4d+?=
 =?us-ascii?Q?OMeV2b1XBSzyuNYK9WGwhNLH8trxxRrVHMQoJ8R2ttQGwF1v2qqmOS3ICSAO?=
 =?us-ascii?Q?6drKutORHiK8NJf0NS1tiCK+m8GD2hLNHtsm08sAbVeIYGZt8JDwcHNyHywl?=
 =?us-ascii?Q?YVzQ4B4Oo8d0ACmWGx2K5qeCu8YUeKvMKY3XAZn0P8xiU7iIWR9vV+lElk2u?=
 =?us-ascii?Q?tuz0/+IYU3w76eZpTs/v1Ad66kodxo40bflA+B2SUHc3oBw5fWUnFqKhjsXB?=
 =?us-ascii?Q?4WWElk79okJmyoOPoyDdrdhpbOWXIiS7AJLUxASVFywngJBJxopTBxTf4/QT?=
 =?us-ascii?Q?fSAuYjEzb2GY1sTYQsuiHTjoGreOzXQ5gtdNJr9pTdlb2pTUsR2XqMeFNLG3?=
 =?us-ascii?Q?UmaKCR0imJPTHb+acH4YcnFYVlNXGSRDYiOR340zsKFIMqCl7gEJXeDjsd8x?=
 =?us-ascii?Q?BjNDrYbj1n49eO2gKlTTb/hJfWcdBi5Dcf7nWttPmCAZzEOqy4+qxf+wHTcz?=
 =?us-ascii?Q?W8+kHKkUU2/yLi8DDub+z8ydUTa6aHNVXej+Guwp9KBcTUc1NKpKa14hQR0N?=
 =?us-ascii?Q?3X+0dzVL9LQGNvOpAk0nwWS4n3y0RtBrHR5WUzMnkf4fhEiUowmmpugRx40h?=
 =?us-ascii?Q?YavA5lNNzUi1nRwHZvzBBDPkawrlxMz9DCGeYQY7EVfqy2xw84r8q/8xu/43?=
 =?us-ascii?Q?1dNh0l6/EKRbfp2ksoIv+D2u7UyzDKaZVoyzMg9ZcunG/xcTHCn2nMghN5O7?=
 =?us-ascii?Q?G1Beaj87lsocoe7yOpnzqbn7wcSf/2Z6t+LBlzUE02vXaYEsj1YNVRurt8qb?=
 =?us-ascii?Q?DqE+OD8WOCpBYM9YvmrwuyixHfaQ6S8DZoLUzGVwdBybek/65qitrXfaMLvO?=
 =?us-ascii?Q?cQ/45CEHDlxBuJmnOuITj6EE/ta+6tWOtgzAji/kiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5PNC+yWoJ2ZTC+xzgL5Edxson2EGaireOfVj+KRu9fO+tjjBVWXaDwUGU/ZD?=
 =?us-ascii?Q?17lRSVr/bc7rHV+Uz4pZCy+t7A5hTfG4JLPYc2hRhe+U4VxB8oj08uHDKek6?=
 =?us-ascii?Q?YzqFHg/pbc2+G09zGxV/iFORPuHPsyoHPCokCvX/iXLw3foNbk87Rt+gp5Yg?=
 =?us-ascii?Q?hiigaOiUHwoDJvl5YnGEj+VRDRwLSSNJ1b9IImeq00LjNVgTzqbuTIxaKgx6?=
 =?us-ascii?Q?Zjqj4bl2lO3mYF3eAuwh5v9mP1ZFRIfTgXrm46qp16FevQSOvYyIGjF5V9HA?=
 =?us-ascii?Q?3yrX6YRu7Z4NiD1hLCVzRA+S0AlxFwj5d6DC6iUvwtDdzqJkVmO+UwbSsg6r?=
 =?us-ascii?Q?7cVjtmEte+15RFM1hIpRB2zqiI2N9kYqM0iKmAkWo409CNLP3RUDFFD/Ho0l?=
 =?us-ascii?Q?ixpcmObB8zzLpjWpb1Rz7eOqZonWNZ67GrUxvPgMt5EyXcpJz4orsvsD1lAe?=
 =?us-ascii?Q?wBpksr79Xx1plcJM0Eb64lNHB6lPyGoQs/kdy9Af6/7EJ4AaT9EtWNA7/YSd?=
 =?us-ascii?Q?7jFqnewPS2+DDI8wPf8lbQuhTYShgKgu46W0UJDwl7VEYnUYdSIr6KMCYWtC?=
 =?us-ascii?Q?vcZyJ8TPuq/i0Jty2w5Put+b5wlodrR7cYyyx8WmoGYdEVfMhZtuZ1zQWWNq?=
 =?us-ascii?Q?E3nM0okTrXKS+lwyyvGjC1M4t0Luzi60yGEIqmB8mjbW22BlwJ1J9bgR22kW?=
 =?us-ascii?Q?zO0ihe6rhqRLDI9nxm6g80yhcQe3hYh3jp/ooeKv1LKu3NRYNmidXEZVT1N3?=
 =?us-ascii?Q?i09sVHEJjon9GKa3Vj2ZvX4y1wK9BFgtaTko84KAwt/w77o93Aeu8B2cFdk+?=
 =?us-ascii?Q?EdH6/yjfm2Qv4sbzewMKIQiISnrhyaFIwygE7nwS0XvFyVVoCFebS0mJAch8?=
 =?us-ascii?Q?CJwcExBjWcOSqOHDi68a9cojoqRfyggPWnAZVAlhM5iEiWBXVaieR50f3TOR?=
 =?us-ascii?Q?tExS69Nf/roG32cqpP3C6EToihP25ezNnfoepokcfhW/AjsG4+pnWB/a33dD?=
 =?us-ascii?Q?2VnsdZaq8T4CTQyp02eEQKxGoA67BVFscJ3qQHjfdihrOVvNfSdKW0aGrwTV?=
 =?us-ascii?Q?XNR0W1tzWXyu9/T4WGlehVBjoLtPoI2A0u6VMo9M5RbcyFdodC2iwxizKlFP?=
 =?us-ascii?Q?6Jm6LHGGHwnSBSLkJcLxV3HPEiVN7oRzgCvs1BuOzbWxQe6ksnNkmZXYqUeW?=
 =?us-ascii?Q?XpTz2CknJk57U8v6p2qFChMYfnhH6ibgkCAHj/EYurAdassPEDJYwpVoj6hy?=
 =?us-ascii?Q?S5RDidBPKxCaX8w9fwZOzZ9tKhA0yQ9fNR4AZ9UzXawQA1QmL7HMlLQkBPDL?=
 =?us-ascii?Q?OFtLJewiaXQTU17OYfLaSHmsYayaU/r1pjn/8bzlJI7p3lixxbuSi9tnxpg4?=
 =?us-ascii?Q?TNR5sPuZWuzpSxVBB3/YySZ+TnoRwa1BO/T/RebwhdhZ75gnpxsF9cUFt+3s?=
 =?us-ascii?Q?ofAlAXQT6n2X++VnYQ38w9jeZYMl+5n9kCNS3iIM2RMR4+GX7hG917Kn5WFQ?=
 =?us-ascii?Q?GojXQ7Az4uYLMwymHGVrhCSbQ3hmkIXwdICZH2oOMp3fJPQRD4/CbQrs4+Wn?=
 =?us-ascii?Q?J2Otcu7emc+zsGUnpU1zt/Y4kKw986b84mhxikePtIO7dxCQDIhFIbdMwbph?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82f0c87-71c4-4141-2fb9-08dc7f2fb3f5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 16:03:24.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMl5f8kr8s595IeMcl05iDUHgL6HLYh4NWn0MryUmPFedI1bIhIgGilhGkDFWLGWZDS54Tm47hqgeqNSOJhw7MURP1498X+Pedxqad0wsEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10374

Once the broadcast source is detected and a transport is created
for a BIS that has the configuration supported by the broadcast
sink, this transport must be set in the pending state so the
sound server know this transport has data available.

Silviu Florian Barbulescu (1):
  Transport: Update broadcast sink transport state to pending

 profiles/audio/transport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: 75893035705da57efd6f8a84bba77d596c463d34
-- 
2.40.1

