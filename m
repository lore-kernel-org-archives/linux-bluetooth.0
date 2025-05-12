Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E389255F5A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044258; cv=fail; b=dM1RogqxNgB7gBPIzs1INaqCSWZrI75PLkD7lJuLQP6kmBS99tM8UQw4BUi5DxyfbppF0Od525ouFn6u1+gT5CJQH+CMZeufYlpP2PskJQL7RbYCCNWl8C8ykVzfFWtJX6T+I+QejYYfS1PwZLdLszEhAZG1eLQLH3G46QTFFGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044258; c=relaxed/simple;
	bh=D4yRCtSKnhifmilFq7SEohVDRrTpHHNd8qLNppxFCe8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pT1paHeTyCOun9O7nwknb9EQPY8/HInpUd/EwJigKv26FQe223rPce5MerhL1/7uNhWHnn0VsDDOHO/3hu7yMmjuhnVstZb/tadUSFMDQ9cZqO4HtLoxyEqAHK3U9ZCh5L/mchYijvh7vuh+MXF8Kf9HC02z9UVgKejDvEKOFNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=pRSJgWVe; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="pRSJgWVe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hi92FKw4ShVqlZDsTwGWfbt1ojDJ137pvVc/tpS+dBMXX586scWy7tFQ2OO7G5SJcdx+bECudAc9oZyFx9Hu3KTomi/vNwBHvEU8jmD9xMrF1PyjlYaxvxBG7FLfx68E8NA3iGBkddxEEvm0kProZQPCX2LUSFiGZUm1dI2pt3UawSr+NjXVIUTbubpDT7fzazoKhHGsOoeljYFsRh23DSoEqanPmZul2h7QYPHYNF9glEBRa3vXI1mHXCxv1Lo+x0I6xp1tBX5sKHtbrSEEVNYPOROI40wg1aOoCOHzwbK9ilRRFQdyeWnK8CtAXQg92VQvHklsDeXoyOvpIMiAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjinRVfwtVvo7heuu3JpfDtF3NXu17y/VnnXiOHNdmM=;
 b=YZuD+JT3Sol/NSYXXr9J8TCtltqBfi1V8BMAO/jlsxGet8WdEBAnm7zReEZ8Uw+JQMaMIkiR/n1iVICKvUz3lmwQJTo+w062p+7HRlHyrcyyjYONjCuQPDkMJSbhoWooNX/uvhVUUhHeNDt2BPKeWgruA3dtZr0VPIpTyQY3FNMGB+FnnmtUMcJwZ11+7jvTIarIWcZXmfUKZytJzpXjZod8k8lnwgbdDiWwTPHcc36/Su+i2AAcAmjmoek0wZDlE0t0nh4h3xYPMnXYOw+D/tm8zppIdt/uLRuXvBn7tVhXtaBA5pCb7FkwAYZwHAPIcYbsdBrj/mHPg3n6GuLYkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjinRVfwtVvo7heuu3JpfDtF3NXu17y/VnnXiOHNdmM=;
 b=pRSJgWVe2NWNtpdVADHHJDEs0fP1TnTjCgluk4XoD5+HQXQR1tUFqixrYF12KtNmVirpIhoUjWyIa5RlNKCWEVy3Brq6AaJPT9NIZ235JADn2omOMkNeM0C4rZ6TXX//URfAmtAIAxt14IXw3U1qbuC95Y3fhUiMwwq9+pKq1BY=
Received: from DU2PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:10:3b::19)
 by PAXPR03MB8000.eurprd03.prod.outlook.com (2603:10a6:102:21f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 10:04:09 +0000
Received: from DB3PEPF00008859.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::21) by DU2PR04CA0014.outlook.office365.com
 (2603:10a6:10:3b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Mon,
 12 May 2025 10:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB3PEPF00008859.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 10:04:09 +0000
Received: from n9w6sw14.localnet (10.30.5.21) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 12 May
 2025 12:04:08 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: main.conf: GATT.ExchangeMTU
Date: Mon, 12 May 2025 12:04:08 +0200
Message-ID: <5681377.rdbgypaU67@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008859:EE_|PAXPR03MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f2f67f-3087-4fe6-11b9-08dd913c568a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?65KGTRCv1z5/bnBF0dPDabuJkUNFEtL3vv2n03mo0jc1Vw25gK33WmG17nW+?=
 =?us-ascii?Q?QxEjx0UO4Y/14vOzO+/YePNzOSRHlmD5UtIEMmqSUfwrq9+N17jKggyEUFyw?=
 =?us-ascii?Q?kc/SF8UKuQeLhG9+DfUIFVZcAWX8zuUuqHXIijKNf88T3DXojBZFOFQs6E0k?=
 =?us-ascii?Q?yH+1Ma/GE6cbgXKVpCHvb29PsXr6j862qH6HpB7TrpRSNSPDVRtLhdSvGyIH?=
 =?us-ascii?Q?dCPbpLJCDOqnZyiUFVfzf2glisARUOyktCf85oChnbDHZcxNUHSKDW58OosH?=
 =?us-ascii?Q?F9Up1OsTQyyq+dRvXISC4wK06JtnWiiK6AT+7xRKOAUmcD+EnyhAhMSfLapD?=
 =?us-ascii?Q?HoFyx7dz1kyogNdsTXMY7XutCgGAuQya+bAhlDYAUySUcfxP2KCn9ETar7Qw?=
 =?us-ascii?Q?2McCckmDGylUabzxPgYMuun6CZKfg8JFIjSadzXNiPmlvluBxEs/SXddJhyM?=
 =?us-ascii?Q?ybBVHC/uJF7EI7GtzqU/3oEvszBMbOtGmSv9H+jMaD5ZrJSlMZNGYVCZg0oy?=
 =?us-ascii?Q?WHkrln1tTrLzgW+CWY4fipWGGQAtjwqDT7ns8iiLsCUgUYMWwj7B4YaFCwnX?=
 =?us-ascii?Q?CdJ3vn7j5G5OEcNtz6cAF5pd+RIvTjqjFRpLQm54J+6jyQ1NSeYrtGcsGtmq?=
 =?us-ascii?Q?PGsHETqdXwSNYhe/4RTR3k5tZrB45hthXOIk61XC8/TXfodSlaBSjgpe6Ni1?=
 =?us-ascii?Q?QV0JHn9qi95EVkVzDw6XbXa4FLh79whIl3TSwMTr2CrBCy7uxhfgvj3WWwT/?=
 =?us-ascii?Q?TfXQ65niGyYCAUHT43GLaN53nSpvWb94m9P19yUWvDWwF6yPaGWjfkqkPisG?=
 =?us-ascii?Q?kqB3/9lVYFhrfRy78/39otGx9RqASVpd4sE9TFaBtgFh6dPOSXTumlmBULhc?=
 =?us-ascii?Q?yaMFOXTNfGNnR/nhABDT8SKKU5IzCxSER22dmKiDJzidwi1rYqHZiZQHeiSw?=
 =?us-ascii?Q?qthHhAe9Rn4bm/1JrCwoZwJJn2rCtLFuBqKbFYdze0f+x2oKWT31IN6YIUX6?=
 =?us-ascii?Q?/SaQlRcLHFxY5STUGsgW6MZEcCSpILGk9eZy2TCnA4M6VA2ZPXoet3jRRrfL?=
 =?us-ascii?Q?D9WaBGUqSFgLFcqlxJrA8MEdSWnCHIkZYSQvxX0jq0GuJ6nWeGzUHLB4m8CM?=
 =?us-ascii?Q?xJrb2O9coXwDxVYzXK4De6BeWLSzzg6Ycz66cyP47bThOyM5RXfbgUFuP231?=
 =?us-ascii?Q?fv70QIl3zCmEK2u7fIMVVU3mOyf7dUAQfIZGxOyLtCI3ZPohxDVNQAaRctFT?=
 =?us-ascii?Q?zdlDNumm2BuDs/lD1G0odbpG5pViv3L4O9gjWLLL3s21Y+9nqp27jcMBViPI?=
 =?us-ascii?Q?tNa47MY3sPNJqKty35FCtaF4uwZT/p8SQSrNX22ZUQmuhTMq8rsVpTPAZGZc?=
 =?us-ascii?Q?pyZkWYwBtDxdDwzY5oP/hU3bPrCXnTSj2btIeDTkfWft77D6ii1IuiBkG9iu?=
 =?us-ascii?Q?peTDKbEsTfiwR5B1Cm1hHH93ptoY1rmr9ZK5TgRx95PQRhJmUCkWYBkGEiAb?=
 =?us-ascii?Q?HqhMMq4//Wcd6BlgFXIW2XcnGmHXb5dh1HKsjQU5UqyP6cBtDd/8421+yw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:04:09.1707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f2f67f-3087-4fe6-11b9-08dd913c568a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008859.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8000

Hi,

for testing purposes, I tried to lower GATT's ExchangeMTU in main.conf:

> # Exchange MTU size.
> # Possible values: 23-517
> # Defaults to 517
> ExchangeMTU = 23

Unfortunately, bluetoothd doesn't show my adapter anymore after this change:

> daemon.err bluetoothd[450]: /usr/src/debug/bluez5/5.82/src/gatt-database.c:btd_gatt_database_new() Failed to start listening: setsockopt(L2CAP_OPTIONS): Invalid argument (22)
> daemon.err bluetoothd[450]: Failed to create GATT database for adapter
> daemon.err bluetoothd[450]: Unable to register new adapter

The first error message seems to come from btd_gatt_database_new() [1].

...
bredr:
	/* BR/EDR socket */
	database->bredr_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
					BT_IO_OPT_SOURCE_BDADDR, addr,
					BT_IO_OPT_PSM, BT_ATT_PSM,
					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
					BT_IO_OPT_MTU, btd_opts.gatt_mtu,
					BT_IO_OPT_INVALID);
	if (database->bredr_io == NULL) {
		error("Failed to start listening: %s", gerr->message);
		g_error_free(gerr);
		goto fail;
	}
...

Interestingly, the ExchangeMTU value from main.conf seems not to be used when
creating the 'le_io' socket (isn't this the most important one?), so I guess
that the error message is raised when creating the 'bredr_io' socket. The
kernel has different allowed ranges for the MTU, depending on the L2CAP CID
value:

static bool l2cap_valid_mtu(struct l2cap_chan *chan, u16 mtu)
{
	switch (chan->scid) {
	case L2CAP_CID_ATT:
		if (mtu && mtu < L2CAP_LE_MIN_MTU)
			return false;
		break;

	default:
		if (mtu && mtu < L2CAP_DEFAULT_MIN_MTU)
			return false;
	}

	return true;
}

As the 'bredr_io' (and the 'eatt_io') sockets are not created with the
L2CAP_CID_ATT cid, the default branch is taken here which imposes a minimum
MTU value of 48.

Questions:
1. Is it correct that the value of ExchangeMTU isn't used for the LE socket?
2. Should the kernel allow MTU values such as 23 for all (GATT) sockets?
3. Where/how should this be fixed (kernel / bluetoothd / main.conf)?

regards,
Christian

[1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/gatt-database.c#n4103
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/bluetooth/l2cap_sock.c#n709



