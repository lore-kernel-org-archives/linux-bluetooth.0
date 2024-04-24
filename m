Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C415B996
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967686; cv=fail; b=TN73089+W5SoslGwZYWkZyDuKerrK0RJpjc389D9ne7YsWrOeA5uJZ7K1NPdSPRWY0L9UY7RZouGv2p5aNs0sZEog9RaYiFUd3sNs1Ve9ftoHy3atsZRRNHo2O3mGTraa99oa4ujTfCCRJ/sggFeIS1srqGFibnlPgZcQ2bU4Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967686; c=relaxed/simple;
	bh=iejaXdpErS8cMi952+n4L1J+dFtl5tzX6Q2QWlG2LGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kIAaJ80vIZU8wIXE7D7IowmFRCb/TCyHwTZu4aFWjb6zMu2BP48jTAk5ycuSR+Jp8GLy9i6L3NyeLInCa6OT+IX+mjkpheKEkG+QIfF0YxtRrUIWoMi3Tf4pjYnydJXKRp5JWBiLx9FgqVFTJGHQPiD1DApSWs0b067BxppQU10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EvlzF2mx; arc=fail smtp.client-ip=40.107.105.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EvlzF2mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5JXD7gtEnm3qMQMDNB/M1zTCq6MG/UzqOZWERwnqCYqFNK8DhqN/Vc1KHlHDTNI5CfxPbNmQyWcRNbVcPGV/tydVghNnQW8NxWAV+iTwNJc2u6rpY8yjMezyn5+qb6d5eNDfi8VC7uxTF2qIe+CVKkBc24nTw7Doygu3bjs+jY58FQ7LxCQMLwYhv3GzL7AciY+TQhnCxIUg97bbHAUYHNJeG+DIMEmmnILkG5uxxjwM54MfWW8JEEB9xlKS3GF2wvL0/wH9F2VxL3esJLVct9gEBEazUIORRWJybtmeJjJmkBNpOGGp++hfJcKHGw21dywl7BmRAYznpFRV9AwOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjKUjS2DjXbb8BnhsSsQvjunkn0xpQJhSNuX0l07wdY=;
 b=cREil+jKMdnEFOG/yVEVNsxX9Dwf375AL4YQo6HzHNa9hrLOxlGT9trDLToq9Sa+khfqwiLTWvfc8DF6qiieh9lMM/6iSdowb8mKlvm6CGzVPtPryn0P6+WFhDxT4hBXe/kC3W3t4ATMXoHXONnkB/aqQl8XWJu3kvajn6I/mPkUP7n6r3spIjEChjXYRPDhJAygWgR6aVccFi67ltyN4B91LlwAx0/dKUmsnyxogrvM780Zb0YKLhhH3Vm3RItP67xdbAeA80OWYUP988gtZQes8aHb+EO/P2aKh39h8HOvTMh3KNZDag9ktCQLcpfihouKsn76dycVmws9wmR9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjKUjS2DjXbb8BnhsSsQvjunkn0xpQJhSNuX0l07wdY=;
 b=EvlzF2mxAEAGhxGwcVbSmwZAdMuBOFG12OXRo1xbeMG0X3ZklKButys52cuGyxWfln6JPakV4CbeoLjj1Mn0GXgmZkmaMbXbOgqvHruPnsvqvVputdJ1y+PLbDDwwUtsw1WIFkex4fkDSdB7+7ccoy2X5INWmSAlnIzAJ+oMvaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:08:02 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:08:02 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 0/4] bap: Replace the global bcast_pa_requests with a per adapter queue
Date: Wed, 24 Apr 2024 17:07:37 +0300
Message-Id: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::9) To AM6PR04MB5384.eurprd04.prod.outlook.com
 (2603:10a6:20b:2b::17)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5384:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 20478885-5ad5-45ab-0c6a-08dc6467f376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9mX/2r63THx5S/4hoHgENP41+OU77qJV5mQg3VTuV6oZ6inRd4rVFFXpPCby?=
 =?us-ascii?Q?0WKr6p0+jXAHMCduDOhhmVd4M9Mk5xjCbF4HMwul5HuapgGfwMXDW17wF0Sq?=
 =?us-ascii?Q?UHcNYGkVtpDhXvnPEYNpHtHMo6YTirWuSurP81OOkvB+lj/tPImmJFj1XFn9?=
 =?us-ascii?Q?z3Hqu2Opbq/aMyrksgVLrW0QQFTpafgHbLTd6mghDOWzVG3GYm/XpozWaeL+?=
 =?us-ascii?Q?0QgANFX1t9IyuHHqEDLyQKThhN3b4toPpFISACdTmXABqu+7JaC7vejx3tZb?=
 =?us-ascii?Q?KTICxkfVNABxVEXoM252eYGC2KnPSsYG9lOtIZQsmAts3DGUUSZHs4tK+glh?=
 =?us-ascii?Q?ljLArloHC5uUXlJ9QkvGJSgA97GTUcF2ab3JW7Ak7rz5jkXxnmzIp2qpZY8w?=
 =?us-ascii?Q?cNuGUnTMDW9IUSJdBIKjFJtBGNMXZkpPg5xwZjgC666HLPTyKEAAEkjm4eAc?=
 =?us-ascii?Q?VxPZ6cYBN63JdOov/5CAJhM0BzlcBUbL7WlKLBqgXObvZFRe2Vv/KIHlx079?=
 =?us-ascii?Q?vjeZhelCP8lQ1GG3i/n5XuHjk8rr1ZLaqpugEbdMUA5g5wMM8E1445Bih81u?=
 =?us-ascii?Q?nm5BIn0CTp2NctsN+3SCy1EPJ9EbEDLQQZUdjwlyA7BxHsHGHaV4dSz3xfXu?=
 =?us-ascii?Q?Acr6AKixNg8jaReqrNSkD5AL3QMfKckId0VIL3nuE6MlyF/0fQUPZJV5rPJ0?=
 =?us-ascii?Q?NUdyLMeoBHdWoQ+XMMUDA/kn1akxGLSNemLi8PIP6EphIdhA1cxAMfbm2zCr?=
 =?us-ascii?Q?bdBxg9pp4b9p2e3UelsMzr8eU5MjEXKme/H6XEdbl6clxGAd6zBfIAjjs6pG?=
 =?us-ascii?Q?BfNej+4rNnllFQLJB0rKMG5PE8lbZLftuK/A7AXgU0fb1JwpngklQR1buRJp?=
 =?us-ascii?Q?cv4KS9prugNFvj4jDWDZM+MyaqUzoqr1GpejRWIOsGHbBs0vzUlMXKHP8DEz?=
 =?us-ascii?Q?cZOKJlepXozTWeN3GeQ/ZK+oBWYZit2Y5NvYppAv50vyHzS3c68jPIaI9WI1?=
 =?us-ascii?Q?+YnUzHc2uhhilqAPx2t10sJzg6KlS8ZBImQvPIT5WTOttg/f2/HTTgbKctra?=
 =?us-ascii?Q?3F5C19qjBB05i19c5ekXoKoVsHS8gPrp87ibf/McsScqHx+hjdCiagUo216R?=
 =?us-ascii?Q?N6/xvg2PMURfD9ZsiYy1NTcHdUVciigRWF/VldZZOgOel7bhkUEQ2xY9clfu?=
 =?us-ascii?Q?GzUWjrk8f36LA300l0HgSsEM1/gfj0cvJmM273wPhWKEr//rkDg/guEMBjAM?=
 =?us-ascii?Q?magS1TotyBlMv3MtByLQBp7GgwTMj15eNgYRca3BoDssk3lHjsulNrEBvfQF?=
 =?us-ascii?Q?Jsdhh63MYbZWN/GNa8btoBajEQhGg9p9z5j5FWb06H6n2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9V2j4c2jU0mRf8Hlql4tuGWCZ50VkSczEVm4wLxbyHMPkosiweZVpM4XJXUF?=
 =?us-ascii?Q?SL1WVEngovL3MPmMP64wTl5n0i/GUhMUJj1iIgC5wi9yy4iZlPkiQ3guE/uH?=
 =?us-ascii?Q?kl4wsCGMbg337G8g23grBXYw4i68Rjoxqht5KPwp/JLcfpnq1mu8ZSyduU7Y?=
 =?us-ascii?Q?v+pgmp9l2TgwqSJGvVwyDVrebY9DY2cq2ECMoAltAOVRcNdOzXV5Szdk9vBV?=
 =?us-ascii?Q?NTyxQJL1cROkgDB3kHbXm5R/Vn/+JCgfFT+04oO5LSuQM1FMazNIAX5E+TpC?=
 =?us-ascii?Q?aHJFbs0mFI3en6H/GJMPGNn8PxvsrBPjcsdaIl82G3sfju7dcg1AFzO8nS4H?=
 =?us-ascii?Q?6ZxXYaxDifMw2FbfQ8kbQpA6uCxa3ImkFJmuxo6SrBSeq0wZIvbQg/jJiGgf?=
 =?us-ascii?Q?tsaQ3NPimtInIVmWmKvZTrqCOQLPRhtp+SrKbmp0kTOXKkKSP3wsO/2b7x60?=
 =?us-ascii?Q?ledFAiqwYYekjQTkKs8RGIvPOJ0TPhOM/+uIUtqXMUCxTKM003pIPjxwBR1J?=
 =?us-ascii?Q?9Pldg2hFHAaUxDXJ6lAA8Pmy0m1FF1lClQ9jtRciEc+0gqDCEBb9AvLzXtS4?=
 =?us-ascii?Q?X9D20/Ug72HgBw/o0L/sN0xQ0/mV4FyKltidsFMvASAJXmYRDBNoX47oh0qn?=
 =?us-ascii?Q?wRATKvUE4mVwK4+BReFr/sqY6WZYprAhWnQDBsfF40MVM1hjxIilH+J8MLPq?=
 =?us-ascii?Q?t2OOZe1X9l/KXH5XxMLynwCS2R6opDvswjDjf7FLnWSWip3IRnvWBUoitp2h?=
 =?us-ascii?Q?jTiIEJ5uJcv1YSMP11KZ3dAFjvSSdE5sKpWUsBqKiiSCFBCBf7eMneSNTCFB?=
 =?us-ascii?Q?H6j66HnBdJO7JRkdilK7C6IDKJmqexM3om2CinxQ83kBoW80+GJHKpFP32Ro?=
 =?us-ascii?Q?PjZ2SFcy6SfIEaVyu9w4dBpcFWog8e0yp13Od1R/5cVCioTVpeCtshVXBv88?=
 =?us-ascii?Q?eshpgWcljOAb77bBee60g+gma10EcdcISyHXmSPCJSJbnOMe4wLdXpMvs9au?=
 =?us-ascii?Q?zdcPXtWomYO3SZF2zM2WOSiC7DN5wYDAPaLXSGmMLu1ppmnJNyzynvm0MrxJ?=
 =?us-ascii?Q?1+1pDflWQEOAZxME+cammE9QOsIn+8j/uaf6aJGxlMg80q7FZhLCkpjV1aiy?=
 =?us-ascii?Q?ebJmJnyJsV+mcGGwciSa0l7aNXAfDpVGFSdZoj9IRpxIn7bR0h4d4PQjf8Ui?=
 =?us-ascii?Q?RFyOYB0yoliQyJ1eiMDj+H0Yav7iCKsT6lSzaVkD798b0ztM29XwwQxEK8IW?=
 =?us-ascii?Q?Iu9gfXfwpP9TN1oeREOnoS/8bLAyRY6jgh1zG+oaEMtKG0Yr0I+xeuDgjVil?=
 =?us-ascii?Q?BWTSXxll5Jlmchf56vchqort8uBq6qhzoncZlY+5eUdM6BnDASXGcpKpRmof?=
 =?us-ascii?Q?TisbH7zyF7Y+x9pTbPnsL3A+Y8Cnh9KW7wcwFcC2nTLtZdr5WwtGcZPROjU1?=
 =?us-ascii?Q?gRHJ3rJeEJmXbjbE8lz6A1OPbo9gCLQZdJp7T/3UWe3xk1CBq/UsEwib00sZ?=
 =?us-ascii?Q?fSx0pSRfrvkBDsjCShm37OvnoPY4YicGsktjPdPKBkvLjzLJdXkqeM1LyT4v?=
 =?us-ascii?Q?/I38lDSoC1vhnXHzGEfzrBaxrISOnDK3f5rwg7YT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20478885-5ad5-45ab-0c6a-08dc6467f376
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:08:01.6240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+L6jxlsQk5VDSB+cB2hI31JwkPX2xIOUYthIQWs9lyQkddJEuFKyEDNB4rRwCBS6IFB0AYdCEDbuP970UHoUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582

This replaces the current implementation that uses a global
bcast_pa_requestsqueue with one that runs on a per adapter basis. In order
to implement this the btd_adapter field of bap_data has been replaced by a
new struct, bap_adapter, which includes btd_adapter, bcast_pa_req queue
and pa_timer_id.

Vlad Pruteanu (4):
  bap: Initialize bap_data for scanned device in bap_bcast_probe
  bap: Replace adapter in bap_data with bap_adapter
  bap: Improve handling of pa_req timer
  bap: Remove deleted devices from pa_req queue

 profiles/audio/bap.c | 196 +++++++++++++++++++++++++++++--------------
 1 file changed, 131 insertions(+), 65 deletions(-)

-- 
2.40.1

