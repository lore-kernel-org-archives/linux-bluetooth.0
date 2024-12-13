Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ACD1AB530
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089490; cv=fail; b=ExobGCvtvqYpOqWyaVvfJmZ7pW1A8VCFgRVh5iBVd7VY2YKWMi5++QC3DHTySGgIXafddtgjOQleL6ucqAekWIiqBsPga2FJpHqa8y0pwiTrcD6Q0oEDWiNMTrXROALZsK5mfF6nSQKhazBX93NwP9DPqPQ1XLq+4xik8DP8Us8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089490; c=relaxed/simple;
	bh=d9fRckpDX2W0dkglxBKBjPfTIbdr/5UgXgUU2vDh/A0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RBk1YpUkcEmrGEutKQ8ZZ2WaZ5ZcNhIdu7WOLhyjnTOn6PrQRlPedodW+0XPaEA5pzvEEVIjNDHBTCdIYhzjYsQoOAi5sGsU/7r8WwEtKpZBKddDrCHpmYxSa+FhllVrqYNAHCdLlLDlAOxPw2KULoyp21+N2EETI0R2NG2Q+U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ntt5Ir7f; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ntt5Ir7f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrWimfAD2Tt047wuQJ6WnafYNLLwIFtffF3vProW0HizoZrPB8NonWb0FpPA6lnPKYlwLNgxmFLJkjs9RgOGkHd3UOihPCgFIob3Lfap3sdrSwlALEd7/pFht2Ific6Yh/s9dT4twa27ucwFSYUiUEaEiDmyohWzawMQ9i/874vGXbT5HnbN1A8oyN+8b24HCyjMvqr873ViXWneicAx5ZxepQ+EhjEx+sZx+HXJ7PIAPr8zuoz6oSZk10P7yefNlneCE1NHdDj1ZgP6FEMw/tB6VCU3ohS1jO0O2/qZYathFzy7gs+EnjHzfCeVcRy1baKu/yPgZz07Liwq7OhCbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u//GYg0aym6qAmROExQK3J7Tr2xXVPLQr6j7AXNGKFg=;
 b=kpM6F54VZQu7OjLtp1SGLEnEh9+tbOWd7neASntMeUp7c/LFVngKqEDs9/5Yww2ouBtuP/S4wQeLKHsTuboAFoRzw5euDbfrWzCAF5Nq7lrS2p0TF65O3/q19bOkYizXhMIQt0ZR4gVms5jxkKL4oblWmVbhuvos2Z1h6xVkEW6AV9NNIT9PU14pncNhVTjP3mzD6ti7ExTGC0vX39wt7ylpeR9aOZen0yFDUIZ5R02chVBylZsN3VON3cdutDolL0pyQ72QGu+HWtB4grsmQ2ZmZuIlofwCokpvN0c467UBGi3FC6+32ynqfU/c5t4NMYvCzIJ2Jojij/eDdDnrHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u//GYg0aym6qAmROExQK3J7Tr2xXVPLQr6j7AXNGKFg=;
 b=Ntt5Ir7fnH1V94paJN8soKkik21SzxVnhEEqDJS4HnRAQZ4UWZb/CXXjnCSCZyoPrw1bPpWbn7AQ4ZsbcxpNCEAF55MXT1ohd5Xq2vN/xLmuPqeKT2KcVqpMQTD0/bIj9f2TsOARclHRgGxl8YDVbjqU3n9qTC0SNPZ0WvzwL0TAxxRxOIej9wAzpC0a1qGfMUFHxlmWEwxLawqpBrVkmIXzVl6ZmqGUPl3vnQahf/A+AsVarhq5DoqartDI+LZQ/tqtXVoVE419n4Jn/HGw0uTFWhqNx8w/AiPBm3/szrJ1xWoqbc42k2GbLnbIy25oYJFmLGD1WqO3Lk5g6eQOwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10438.eurprd04.prod.outlook.com (2603:10a6:800:21b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 11:31:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 11:31:24 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] client/player: Make QoS sync_factor configurable
Date: Fri, 13 Dec 2024 13:31:10 +0200
Message-ID: <20241213113113.64818-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0048.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10438:EE_
X-MS-Office365-Filtering-Correlation-Id: 55d02686-e600-4551-74d2-08dd1b69ad22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Atw9iUmP79R0qMoPFzCvn76XzyaVMnXmoxhshOcNCt8AncK3SRBGtMGNsNMZ?=
 =?us-ascii?Q?BOLKGEzBrKyTdiSvhNkQ+PrWUg7y4C/12kj6/D7DAR9QYGvLwfhsUiKwcMYg?=
 =?us-ascii?Q?A/+zByWBDhy3H4MPCCaHwhKCdCzqSBygRHJ1u3g/gaMZOUlZivufutAPcPX4?=
 =?us-ascii?Q?HnMGs+yvmiqIPhzNr4E++K+wwm4n1AOL6H5jEXLOoPDg6TAoWSGDYNLLiVFg?=
 =?us-ascii?Q?YH9YuH0SghUsgM3cXmWmXUgN7CU3bKMzL5AgXk2k5IIB1fEuhJkZTVCsqNUJ?=
 =?us-ascii?Q?ckj/G0V9L7PF/isMsVqzq+1RK+ZquOGwGJq1z3LQjqItscpxhlXUiHXxdgTG?=
 =?us-ascii?Q?AkeZutxZ9hprZU05L4gAcWWz5ojHz+IH8635NM0k4Z/WlfJh5wqknm13wl+r?=
 =?us-ascii?Q?GwIOpUKUNkPNdXMZMuGojGLyB1vsiDOm/HrqgwPkOgAgiSMe3fTlTmynP+gc?=
 =?us-ascii?Q?Fq7y/zRBq0cSclGr7asrNuL/L8MPdkqBJfU+qntNfKeURr/JCLGNFJ++Fk2x?=
 =?us-ascii?Q?3TaoQTVtXpvtZoBLqv8XXa6FsdkTF/yq0O3hG6ICWeCqrJ0WNiBxU6Jl7R6x?=
 =?us-ascii?Q?r9+KAGohBl3jaDOYxo7GGUja9KpGM5qmYxEps52xWWvpL3o3ibA5bwWnG4jG?=
 =?us-ascii?Q?zj3Gq3aFf+nmG6t032T501thp3RnIMCigefOjveHaPju79KIRBu0TIYcb3nW?=
 =?us-ascii?Q?6rV5Un8//RnuQZbMkuRutBM8ZAhlScDXGptjCikph50pzenZiaHV7utf0AUM?=
 =?us-ascii?Q?zkg0lYsJPjvrbrrDeiZGDRGplrKwKSeJilC8pN0gjpEmlleIRmEm3jQbwbfx?=
 =?us-ascii?Q?1hinXC/mLc4TRX4UofhKcb/s6gSSfpUbB2vlp6BMY7oCIiKTHBaeo64edrVS?=
 =?us-ascii?Q?FO62Q+OUPpr/8Zpv2RTzxf8PTu7rEHjowA0GKLqxYHcuOEobPuSqvdjLpCvD?=
 =?us-ascii?Q?Hj/onzF55i8QFlSvWaBCbmYmOoI913unt3KWoeaigrfxS21oGnQTmKuLItWS?=
 =?us-ascii?Q?8fzAu35E3TUYklDLDS5yA74DVQGOiRgPw8u6WZ7iJKqvmbxoYn78Wm45aXKe?=
 =?us-ascii?Q?1o6LxevWjMi674ePqE8yR6OkLRY0iMHj/mTSR/Yt5Mn4S3gzUvRKqlA6reT7?=
 =?us-ascii?Q?JAx0pjfWXr7U6zln8NkyRgJUJC2bEG9NqEn/zNeM/pA81fmGL0IPyrn74ai8?=
 =?us-ascii?Q?2jU5MVOMizQR6i9nRgo1UCsyMWJ6QNuuP2zYq0UlX5dMNfADP0nDslfxiqlf?=
 =?us-ascii?Q?3nCkDjV+sMB/jJE0JhmjKH3MxXpHNLth0rW6yPo96QQnMfpHh7XMg+ecJvaL?=
 =?us-ascii?Q?DrmYQvF4oG7PAoaFAaztCMYn16U8/fjS77jnuq57hmngOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?edZsdRWhkFDUYMoXX0jZPsTGUIRC3a6/NYaAuEWj/gZKzF5odo3+TfFud1Ls?=
 =?us-ascii?Q?0ifmyr68ZjhPvn0eX2FVgvgxEmFb3bBSlaU3dYXoMQnD/DN3UY9tgLWSqby7?=
 =?us-ascii?Q?eXi5brdfXWDTKuZAgudbgL7rZgTEJSVEdOL1aM9qB2rF8VtJkqXC8qnSXTxS?=
 =?us-ascii?Q?rpB1xmejnmU9VifhqgDikCCfhD5hlbsufwu1xkurfbZpqzkq7act2NPvA46+?=
 =?us-ascii?Q?bFV6EQWUqYjRloYYtNaWoH2RAdFDe81FvlrJB2SpfkFCaZ0RPea+8oI4xw9W?=
 =?us-ascii?Q?moaUyTEcfUUEvXPYvyexwKRtsBQ2Ev5fcCCZzoNNzUcIgBPBAIXIAVDTqBNZ?=
 =?us-ascii?Q?V3li+rROBIfL8ObJfZ0rm1+EzU1SX7ZVqMRvIdVMhKxvDB/Rs1HLscWTR4du?=
 =?us-ascii?Q?/Nthb1cFHT7rz3TixmRT9iKu1DUtG7mbtS1NIBra6bV6MG1rZHRJYlbT7h4x?=
 =?us-ascii?Q?7Fki5nHi9WK3p8ohbMcdUwAFDdCgbMTFHyIeJpIonl64VuVCplkvGG9wHWJ9?=
 =?us-ascii?Q?vPxLGIrGlOb7Sd+MHEa9JEbXUXDmFMrAZarHweYZcUkHmij8ie1oq2q68gjU?=
 =?us-ascii?Q?LSM87/7P3tLfEV0GsNoL56/8Oz3DB3oiC/l3j2hEWpV/RM10u53YDkkqBXSF?=
 =?us-ascii?Q?SvLAZlE5R3HVt1PU41VNDEmK3FjN6Xqc8Udd//VLUR4YgJERMntFOMr/7rfk?=
 =?us-ascii?Q?P97zUYYyTiSin71uCYZzGzdFggW33r6c4AEUidlqqiQz3XlbHdweVzSMuQw/?=
 =?us-ascii?Q?CjOF8aHOSnSl5dP4XFG0uGsdKK0/jViOhur7LLb0hDAPgZi6JBOSyWLUN3hY?=
 =?us-ascii?Q?7SwYDIi3JEV59+MUs/yw4t0YgPP1p0BnCbZPBPNhY58Pw2YqQJb9P0/CKFQq?=
 =?us-ascii?Q?RN34X0785xwUmlg1Ybr9O016BkP+5DGEH8qawTCzT2FaKIxpqCFH1iY+z60l?=
 =?us-ascii?Q?ZIIcQZrjoqpCCgi0bt2yXMSAwEBVLNs43TPqgMPiJ9J36f2WOPpFgVlrgrAJ?=
 =?us-ascii?Q?oKEX3vcHD3l5dDRoYmhPPlLEPdERXVAto51dW/CK9DRzcJMLouMldfHXapPB?=
 =?us-ascii?Q?fTBhJJKxukicHDHP8Jcq2vXoy4z7ScBLuyipkl6D8TgUz1Z2xFULxxZvhk/3?=
 =?us-ascii?Q?s/LfA6jUxhuoIF9WmdhnA2/91kQ/U38ChBfVVPWKUS5PSRTigOz6IrxyMG02?=
 =?us-ascii?Q?rUk5F/rT+mF45Ef4loYONhx6pUMCYVxBMteVSV2Mewjdl0ZOP3QEzbc77C6D?=
 =?us-ascii?Q?1w810zgBESHw/J58UuVWxwrbcdCpmfK1n44KlS1YsptVoEDxiQOer5qm56KT?=
 =?us-ascii?Q?YIbR8OgudYE4OXoNcMGedrKLPOWXE+LNkNs9jGeSwYMYtMB9Xdm2Nk6zSYxU?=
 =?us-ascii?Q?KP2T5moqMKzPgBmLBr6iMk3L7+2bMYGHbbEGuV4mFsGAhlT3ZevCtJUktXea?=
 =?us-ascii?Q?kEZjy0dVfA6WVKqvpSl13tMaBblmJVWebcIVdhvi2sVITKlovkabQUpjDyzr?=
 =?us-ascii?Q?oodFtRupGvF6rXT3Vdw9hVZhbLNOj4/zOyUUBdIaXuQxEdmyLMJ4IxNUU12D?=
 =?us-ascii?Q?Bgpn5rnJXs/QWNfAzszRxt9QJgnCfLpZMul/C9yr3yv3C99zK1h7g/MmkU7w?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55d02686-e600-4551-74d2-08dd1b69ad22
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 11:31:24.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnYPPBqMDcN8FkgrbVRYmBZX1JhMWZv22duGndzx7DiSYlzw3J7fuaIwVLsYLwdKZTz4VWRGqMDVqf9kUEcADQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10438

This adds a new user input prompt when configuring a Broadcast Source
endpoint, to configure a QoS sync_factor value. This is useful for the
user to adjust how frequent PA announcements should be sent by the
Source, depending on scenario, instead of always using a hardcoded
value.

Since all BISes in a BIG must be configured with the same QoS settings,
a check is added in the BAP plugin, to ensure that the QoS matches for
all streams. Otherwise, connecting multiple BIS sockets bound for the
same BIG will fail.

Iulia Tanasescu (3):
  lib: Add BT_ISO_SYNC_FACTOR
  client/player: Make QoS sync_factor configurable
  bap: Do not allow BIS QoS mismatch

 client/player.c                    | 30 +++++++++-
 client/scripts/broadcast-source.bt |  1 +
 lib/bluetooth.h                    | 12 ++++
 profiles/audio/bap.c               | 88 +++++++++++++++++++++++++++++-
 4 files changed, 127 insertions(+), 4 deletions(-)


base-commit: 92f3a3b108c22e3395c9dab0acefdfb894404cfe
-- 
2.43.0

