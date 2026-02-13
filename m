Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CB5224AF9
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000914; cv=fail; b=SGZWRxHV0snljbFcluoH5zZckfJCY3nHpyZWNNJ0T0QMiYm0F66ajzcmWdRda/kJcVB17GreJexhu+tkJJztqzISwEnToho2ZPFw7NtP52LtCaRFpnsXQQ2OMbtCho492w2kHUgzRLcA3v379D6T69QGgjGTTgrjlxRv1yBjVjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000914; c=relaxed/simple;
	bh=cb5m4kg7YJ226d1JfhXctNILl5GLp33pEgr5yF22MVA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ILQQIxb/MfSq1+6jwnz+k7xkZs14skCBOH81K7S2ezFCFPuuim4F1BhmbTQ5eaPOpp5QE7PWo1G1JYF0trMZbNbhfa4+7duLQjI5qKHrc8FF/OfyYoJv2SH45vL4aZd65EwXWPrEf009K4Vig886OcIKxO21j+0+NXuTaDjRyyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y4imjjNN; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y4imjjNN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLmeeoX4QRdGUJUV2l2E1MbfxleD4TolWeGg9v1nRQVLGlZpYdFPc6yukkhpNt7OZs2B6vcjf0eXVFg2lsgRrD9ecaJF0Pqjb+JjLGUky8re0gCQ2NLLjHlKW5R1dJxkUaPabRPyomT9NZu0CrfQz0M7kcsTWmlvc2/+bMbb+iNZmOOmLA67fVC8MT4Tlmgj2oGk/Ps8WvyQCq11lRbwC+dtU2imT+Q2gFnZpMt61irDDHrLWbarFFkrIzOijqcHNRJ/QgPDPPuUw1lv8WL/9CQYy0wWJJGTW4FlZcnspAPnlxiFlfs2E/x73r9w/V9NGRBpE4Tq5Eez5GjGT815VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekpeT1F16pLUYI1nXOuedBGfjkImAng3ZzoiY25ySyw=;
 b=G5Cssvsq9ir1NdshJw7ADJPztGBUBrqG3ooMVCpeF3yXieeC01j039cEnBB+2L82AENM9OofJeJWk9y8ltmrpvggI2Y61+TCyCPscuK0ITDf7hEmVN65GYubqT1hBhQ2s29qdsV/HKfE1dYKv8E2jxyQjuKfvNXD2wW0gFTgi9P8itvbhUNyrw5Vn0rTeKbos06cUw/FIcS3TMTL/1tI+dI6Ab82HjfUZ66/wla10hCTdlnDRaFJyRbrlMHfb98XXW6YcGPl/j7z67lyCnupzSpnhV2QSGkgII4Ei+0oCalTyQQ7hAmNbY2SU93lpF4564yXsbZuxeMeIkStfRvvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekpeT1F16pLUYI1nXOuedBGfjkImAng3ZzoiY25ySyw=;
 b=Y4imjjNNFHPjvhC+qdN7NSHkDx8c1pvLejf9olJgf+yCYqTLmpoqW6s7vZO2z0vl6lapSr+nRd7p7xTudjxqoAsT40t+E5gUA2FcgQgZ+h2FmcFuerca3/fPSI2B7FrYpMfbkew0NCzRp3fJvnQjpx+FC8vYfx/049pvbTdLQ/oDbN9hlbxooLy4vBOX9VOECcqLW9ZmCCUG+2WVlqxAXAN+j1fErOnG2NEvnFtKTW7dnaFDQP+TVCZ0y/4Pm5EJjaADBUKaNTKaF+1ysBzp7H6tQegGQGRV+XVFe5YuetvGhXkNjy7Kt98xbRLEOMyjkNwecmrt/9I5XrCobhQEnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB5PR04MB12203.eurprd04.prod.outlook.com (2603:10a6:10:64b::16)
 by GVXPR04MB10708.eurprd04.prod.outlook.com (2603:10a6:150:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:41:47 +0000
Received: from DB5PR04MB12203.eurprd04.prod.outlook.com
 ([fe80::ec86:5dfc:992d:8d47]) by DB5PR04MB12203.eurprd04.prod.outlook.com
 ([fe80::ec86:5dfc:992d:8d47%5]) with mapi id 15.20.9611.008; Fri, 13 Feb 2026
 16:41:47 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 0/1] Fix use-after-free in BAP broadcast cleanup
Date: Fri, 13 Feb 2026 22:11:19 +0530
Message-ID: <20260213164120.502-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To DB5PR04MB12203.eurprd04.prod.outlook.com
 (2603:10a6:10:64b::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR04MB12203:EE_|GVXPR04MB10708:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5bc07a-e767-49ef-8c3b-08de6b1ec771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gfamuHFJWvMfC7o7D3YO3aqKVtlZdxTYUUE4OwkpFzW8gCxzdkg3UFLEby0G?=
 =?us-ascii?Q?GbWivuKublIS2aJbIeub0Pf98hbRLKSjJmJnN2lVsjSvhwg8DAdgf9W0XMYL?=
 =?us-ascii?Q?erHWrxpImBd5HvIO97NFVBJZNXHN1s9kAJRLciMHXd0D1aVUzpejZvz/5wOt?=
 =?us-ascii?Q?ojBqFIhXNgJHMpMywBVPG/+jOIaDkL+x1Ab9RTFAWQz8Z1klJxoVPHdw81OC?=
 =?us-ascii?Q?8b/9pZAI3yTfinv3MStin8zu40934vO//0yTM+eOVJBnaK1NMdyZCxxi42jZ?=
 =?us-ascii?Q?GRfAxSGVctB3GXcvfITsXqs9qLjKpaq6WFIihADpcngSejmKce68Z/shqG9e?=
 =?us-ascii?Q?l4kcRPcgpHFqtqwQhx0z5p58oilc0WSdDa24fmFJLcwcsI/Xec2CUv5vLBIw?=
 =?us-ascii?Q?tDSeGs8UUBuMYxPqSnqKHxHq17zf+Dm/cIsJ8+JQiPX767TZQsNIfZ3BVzAD?=
 =?us-ascii?Q?WlWxXDjpL1idE+l2CWqYja5Uf778CPKqp+1LYjBK6kblVs+EqVbYNIYF1FDk?=
 =?us-ascii?Q?A/jwpcRSRlX8rNgBXAfSpo3a6HCWIvb8WUGkwIlplURKLvqeArOpmVvVkKA1?=
 =?us-ascii?Q?xMc60ssoSOSfV1zejRlbZzl+x25rLb5qMSfvIc8g+O0S3poHPoQXbGJ/LoiH?=
 =?us-ascii?Q?50IS7e51+swWp4yFfY4RE8Q1vb6QvJ/YoQK1Tc/IPj6kI7nFJp37tf/eeNVY?=
 =?us-ascii?Q?STIN1O3E0IomAbsE63jLL5ia8EET0OMygIlOXXGY0IrhxiR4Eo/qyetd2yct?=
 =?us-ascii?Q?VVIu57gePTh7aEtpAgcG+0mOlrlfALsEFLK1mtAhxfql/3gKnblGyHfa0kxR?=
 =?us-ascii?Q?RQMIL37ZuEeArYpQEvSvpmx4sU0idFGS4CKRYMZQBDhygOB2haTGd9CfgfEA?=
 =?us-ascii?Q?/guR95MQ0VjhPJCJdDO5MrZlvdz/FKgYGaAGAsEKeKV7LK2surw4aLmHXevr?=
 =?us-ascii?Q?c4WBPD0OEY/iwtui2JiRuBa7mMEIloDQk9gjnGj1wf/BcufSBC3q1OLpSAgZ?=
 =?us-ascii?Q?rkT80OT7vTVPP9AFRRSFhazO01ZvvK7i/1KSySpnC8kXtTJZ3DHTiqgO4Ah5?=
 =?us-ascii?Q?sik7Hpd3nF6Rg2sPptZrTAhVOANjz1cr/3tN9FVFWDWS+8Ft4WiMRbjgAYDz?=
 =?us-ascii?Q?2rstxRjkMVXeZHY8mDdXW3jvWC8Lie5ICsnc+494zd9hCW4QIMLTCArQ4hNF?=
 =?us-ascii?Q?nLCJXyfiegbDsHENNbJxDnTc4xma6C3mWYLIlwMPR6YHDxS03UoPPCvCLOW4?=
 =?us-ascii?Q?CgjpITIiL4nOgHr6RFuy2gWfatQKwQb0K3YvQ9v8ZryraaggD5/Gwi3L6Avy?=
 =?us-ascii?Q?MYPSIcjGgRypvhgRtsjYz4gJOLIFtayb86BNUIbynuJUoqL96kuw3AyvzUhO?=
 =?us-ascii?Q?Y2Ftnz78OmSl6EODrPehZxZgZdCWscsM7EjYeYXPv26rGzYPuQLhxZL0vB6T?=
 =?us-ascii?Q?HGdJLjaezZSb97Gn2MmEqgdTIu7wJhSUU61ROT719QkSbFBCfRzHmEbA7C0R?=
 =?us-ascii?Q?L9giK1mXxGFimQlF6xoov14VOQD2k/AJzmknfWwnb7F4NpEiQNqiUbrYWaZS?=
 =?us-ascii?Q?5JeH3v0uq3zOYBVn/tgooBBpzr4DvVQyNhYMkzipcobHhwmMSUBELUQG3c4F?=
 =?us-ascii?Q?dfp3NCP1hFEf++QUOirhkow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR04MB12203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mIc+J5phNdXJsX8OvjNm32HhGKSztKYaAAjjbDsfPsB5BShg1NJG8RYDGBJ?=
 =?us-ascii?Q?MYazO5vk9/WDBoeOxwDcvbB73rPlNUg1dOg+lQLqNb58wSpZsWLc5NOezUJc?=
 =?us-ascii?Q?guMU5d+/05qZh93pW9pxHNhyMkP39jHRly748NH4gzRkL+apnrUn8l366zMM?=
 =?us-ascii?Q?mHzTYhvVVf7+PV8Fx2UboFpSaq8o1dbQwojDDgobpsolaxCpA2vfd1wgAkw9?=
 =?us-ascii?Q?IaICAfP3vuUU3cTI5XuPx71LOhIwr2WX4d59FW0FllZravO1Iq2/ynpwwQtb?=
 =?us-ascii?Q?7gSgSHXNl15qaLa9dgrEx1nt+z3OjA2Tp5WoxV76oMIFYf+vG3rgs7XRZO/z?=
 =?us-ascii?Q?01KG6xUvkN33y8QhptGHxR9g7wT7wAJXJFOrLOPsqhoz8gh8kUXZrCb4U26i?=
 =?us-ascii?Q?YKLai6YfJh9HPjssJ0FnhLkoXSAkjRYOQA4l6381x5T3buLdKzVFTkAtouFA?=
 =?us-ascii?Q?hN1CY3SVAbaM31Z8vo/9QaXhV4HVBsi/RdK4A4NR3YSxbruvwZenPwciTQe/?=
 =?us-ascii?Q?B+slC18dZoAIw3V1EbUH1Lnp1IgLhLtMyx/aPCBJULel/0t2r1fyuk907WJr?=
 =?us-ascii?Q?ORLszQ9vn5JlY/ilht61C6H0tJm3zzewcX8W1pYuoq9+lxow+H7BnYxBuFOF?=
 =?us-ascii?Q?gsyC5wTMyoZ6GlFhc0GYBd3jTfbIgkDhfOZqpzJLvFIpSJbTkHgBff07A3oX?=
 =?us-ascii?Q?BXxVnkztwqfdxuMwQ4EfrMlOXcRaZLdNMc5YRqLsSsV/8nMLy4BdQgyobxnL?=
 =?us-ascii?Q?1zMNOMtW4uSv5v3hdByAC5CR5x5Jb23kpDJS9lfNQUz3c8shGNgBTur+8UXi?=
 =?us-ascii?Q?smvyRmkXfQTw+o3FHmrbc/kqG+aKps6Io1PYEv59BkT9qwFfeTOfSJG+fvk4?=
 =?us-ascii?Q?fwtbB8IkKmqsWoD+CH49/1pXQgTLriwm58U/KlSmxKKjvLsM1e2SnWZOgOYN?=
 =?us-ascii?Q?GidqIH4sl10Tw7OWW4VqB7gZCBX7XDXDxrOQYNRfhaeJI/4mZfSNw+f2HboX?=
 =?us-ascii?Q?HHvujw8nBaoDTylBQSY59Ck9msBcoIFCuJAPN9YbAxLbTNZIrQhs2+mnquIv?=
 =?us-ascii?Q?KUWRFDFsKXFh+mN/rErHDworvUJwNTX12/wwU3HAb997Jmo6XwJ6Lr71wl4W?=
 =?us-ascii?Q?Vw03vOHJ7/LZAQN9C1TXqby1aorLKJ+CK4rDBGL4DXHl5rM63+nb8m8bhcRt?=
 =?us-ascii?Q?c9q8sQjUP+fTVErt7wynzdizoE9GukURcQushr3qKlRxHTHbIDX01sYa22ph?=
 =?us-ascii?Q?6q4jsc/qrlaRE1EudH92Lv3ZfSi5707BuNo8G0U2DDzf5exaIUtjWGGfLqJz?=
 =?us-ascii?Q?Mg+8kN9cDMcV875VdeqIIeI5XJBBlmjT39Uvr++NppBpvXzurIftLL91pORf?=
 =?us-ascii?Q?rzJFqezeS8HdXqKorO398hppfbYJSikcmYmyDMUkOvPi2qX/xIxVe833JdT2?=
 =?us-ascii?Q?nXpM5neO2WBIsFX4yHmDHhFdwBn9s+Pj3q+552Cz6kfT0roJrC9vkKy9r8c0?=
 =?us-ascii?Q?f2tewedNngq4KbQkZWsfkt6ExH/RYtphBAl7hqNQglNbhbq0KfsGOfxjN0FN?=
 =?us-ascii?Q?WNcbiE09+pU4ifGA/AnJsZR2MqnVIEchl970eoNJ22qdERHFGi5g8LPPaQPJ?=
 =?us-ascii?Q?la5RliKJNlBJbXkj4VutpzD91xmOoLYUjUTTFEz545xe8+pKXsRlJGSH6xtH?=
 =?us-ascii?Q?BTEl2PmcqlHwbwqlDQdGxzlK91nFESouNEN/JVS3GOshV9xYbzXjReES2uGI?=
 =?us-ascii?Q?xPu0E09UiHJVQFtB5pB24btm3r4wmtE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5bc07a-e767-49ef-8c3b-08de6b1ec771
X-MS-Exchange-CrossTenant-AuthSource: DB5PR04MB12203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:41:47.5611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sttTG2Kh9kv0502GY5utUqIjhUmFHDcdhYUD5SPCAp6RzyT5Fzl8bO5FzM5/dK1WuQYXZ2i4QRpftPtrW8Ypm5u64EE+04mnCp126LLb0ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10708

This fixes a use-after-free crash when broadcast audio sources 
disconnect or undergo RPA rotation as reported in issue #1866.

The crash occurs because bap_data_free() was freeing streams before 
destroying the broadcast sink setups that still held references to them.

Tested with AddressSanitizer on latest 6.19 kernel with NXPs 
controller as broadcast sink and Samsung S23 broadcast source. 
No crashes observed with disconnect or RPA rotation after fix.


Sarveshwar Bajaj (1):
  bap: Fix use-after-free in broadcast sink cleanup

 profiles/audio/bap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- 
2.51.0

