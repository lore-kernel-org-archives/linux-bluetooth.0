Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299B811FB
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790708; cv=fail; b=fc63p9usnt7wVAfFc/t322ViZXTclGzjxlGk8AO7qzRMnjbqBy2+l+2z7cVRhaLWXKRklS4jFJEbcD8ZYno6VneaXWywfgUMTJ5i/zkBYvAePA1J8cCEDt+jPVBGiP5UDta0bfTEkpxNXsn7jn7eQRHKtiI6kvJ9iCE92lv+uSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790708; c=relaxed/simple;
	bh=yDlmxS09/l5uDb7pfYgZ1rC3RHoOA95XGziZF0zgAdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BpyQJf4NMSMEpb0g6uvFFW3qWp8IoWJa8k7tbD1XBX3bqR1z5EqGJD+gvnTWfHXwNa1MJul/GgKMEcx2tAnmOXsNkoWPoh4xDDX+ysWuBk/7DNwhPWTRwe3zYaO9cmonLPkumYog+A1sYq6a9KulrWe3CywQq3G6ZO/YJY76R84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hioodjih; arc=fail smtp.client-ip=40.107.8.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hioodjih"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROjSvV1qdf5YF1uCzE6a/Q5DzPGAtpnh3oo2hVGYm4I0oTompXDM7lPYc9+NnXBd5ChY8kpuC9DDTUa8llhmqAeq9oq0olOsSUoU5HehhV7twckSLEriuDLty0ZST4Bn8x6awiKL/e78WvxCB8ZHUET77c9u2OyXCktqhl/Wm0GLB4vLir1o5YxjGVPMmqCLkB38eet095OL8JfHSvIf1ox1QqXPYM6nixKUrc8f5LiLEBIiqmQBHSVKgyJha1c1PU7OnB5Ms1WRYAscRM0ks0qdD/R/kgPXzLQro8g6LJV122pPQnQLBYSlhI/KprQAnJ38V0rESuhvY+49U2totg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orspnGQE3Sxv0lPkv1d/eagWlZEIkXyV3Uodp7BbpVg=;
 b=QT/+5kYDDBHddCVVZvHcOJWtUA4SpHd/oeFnkfb3BBhQO2OMSiFCoLzzIen3yv9LnIfE1w3xmo0cMR4TvjtfeM6/UVVZSkD2LiDz3L1nfU4Yhf/14SZEZl8WrgdKmUm8NL6RGsz9niHBOrQXCncjcxZN3VkfxdJs4nXX/PwwR6TolufQHSwpfBfJG5KBvXkOSbevHAI9/iR7e8eyNH4a1pPzuOuBuntPDDLDxgOxR0/FEHgARGBjuYxqcIITP64AczGZ7tkldlwVQpzoCLl+8+PWb0HO12bfV44vdWom90tQuth12zDgBSD9ZJMRaCiyZ+/H7i2GHxf/QHjS2po/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orspnGQE3Sxv0lPkv1d/eagWlZEIkXyV3Uodp7BbpVg=;
 b=hioodjihX0MRq9WhoUgCI2QhNAa6aWd69t619ljcNVA64NMo9iW9MemUBl96H3Uzu7OmP0p+kLKP9A069NIZoY6DjzKW5lENua0jpndHWt19e3ii1t2SGyblnFt2Nw9xz4yQz4yY6l1NG8GTnKY7376tMivjHWLjLQyPvQWFJsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AM7PR04MB7093.eurprd04.prod.outlook.com (2603:10a6:20b:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 09:51:43 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 09:51:43 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 2/2] bap: Use util_iov_new when setting bcode
Date: Wed, 19 Jun 2024 12:51:19 +0300
Message-Id: <20240619095119.167652-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240619095119.167652-1-vlad.pruteanu@nxp.com>
References: <20240619095119.167652-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AM7PR04MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 25358681-58ce-4370-631a-08dc90456d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|366013|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RbaaHSIZj+yDkxSfc0YVSo41RJCZkrP7joWB+21/h3bleD5J9wAXjMNK8GAC?=
 =?us-ascii?Q?7BcswHa0qf8HMFfSIvbB2MJrKFG2p3CVJsI/NO0PLBeIo2+7SmvE5GukMrLC?=
 =?us-ascii?Q?oy7Lf+e+O2VUCHyY63rvccheGG6eiZy29wQr1ZwOoyCSY8Nzlyme7eqj1pbp?=
 =?us-ascii?Q?uqjXCPRPA4N50xutOlVoTz1T5rTUGTyYK0uVKNwKvE/+vt+fAmDwfof9BxBn?=
 =?us-ascii?Q?9+/9fGvhG4GbVLZcUNiP+oMXYHm5hVscloqhAaRw1Eb40mYPjjaVxMuYRcIF?=
 =?us-ascii?Q?6yM/1oYe2ms+yo/jcCeoX880aHpe4JKMeCysqH9vcFKz7vXisJje/bbWk8Zk?=
 =?us-ascii?Q?Q1+9sGiJBGXPasJQDcp9SnXJs4SJiVIsAxutFNM/jyqQij1jc4dFpAf2XIG6?=
 =?us-ascii?Q?JwF53KLTayvr4b3/TP8y3q2Fd35VE+FQXZYJHfgmwTV5TneV4W7QisVLP0dw?=
 =?us-ascii?Q?fFh1ONOLOm0Gl35x40i6AwV2khp0xEdGxGhIRPEn3Vx+gGdFSPVUvHmHJ8dG?=
 =?us-ascii?Q?pJswEMgDRyVvtF1bXx2oflwDRsMvirZo+Gm4lAvX3X7iJvjUpvVZa+N65IXl?=
 =?us-ascii?Q?9T5ZYaoxeu0EUJUGUkyp23+6V4SzS5YoquZsJ1jAV2ixu1rk/KWx+4D+JnBJ?=
 =?us-ascii?Q?oWrw/u3FtdW1eEkP1rB38d0e+1s/dZePhMQrMAauvH2zVkTWqDBiXAkwR+9a?=
 =?us-ascii?Q?HkIs5pn5EwHGHqNuVsOIs4pRJw7aq4nKyA1gBJ2oZuuPBsVOr6NbxpSGN/AW?=
 =?us-ascii?Q?mBxmkryFPHakikJqjaN7Qdh33OtXlDTBq8pzEq7JpkKFA9Udz/xNPo3KRtHV?=
 =?us-ascii?Q?OUFh+RmVa6lAj2mAfYZLrjdk3FbRG3J92EClGDMTYjlS4QRgqqpWMaFQk9nB?=
 =?us-ascii?Q?BdASWc8VAqJKwI7RxJV0aO7pGFM3LgkO/KQGIHoLWALmnbbi8r2gJzHhar5O?=
 =?us-ascii?Q?yOUUFyIEChfu4ZfVLdytGtMPzKaYeOd6xA23R6BYXCILtUofpyg/9EUOM8Ti?=
 =?us-ascii?Q?XX184oh5W87F7qQ4ddsEeQum6q8CDH3K42vMjlAtQJgyYIBPrxAcmBN8hamK?=
 =?us-ascii?Q?crrghx5tLktD/U16fzyKLLdTEGFMWeqUgWAUiQ9H2F6jRpn4dgwUIfExPtk1?=
 =?us-ascii?Q?VwMnyTqLAIyHKyuMh8tU14cYHBDmtKR1QM9P9ugupDlG1SR8c14m2Bb8sL3q?=
 =?us-ascii?Q?Xg3gL/kB2zc87vk0UFjNuX0IMTi4vWkHMqW8HNBhTRBeXrONdyFXC+aYe1CM?=
 =?us-ascii?Q?DyPgWCORwARLCMHxK/BdbGCBQtc/2MzV6NP9zgjj1kcIyNom9JPpcEUQiYF3?=
 =?us-ascii?Q?kMmLlfECRoPCbEqRC1fYtMxNIeBIAQX9Jh/esZ1xmVfQhwTWlX6rmr2gNcFJ?=
 =?us-ascii?Q?N+hlBZg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(366013)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?91M5pmDx/HZT/BY3lG0iHrx9TDgCjFouguS2jj0pdK7seC4huGCLfMYQJNDY?=
 =?us-ascii?Q?wy3MUzUdtBP5EmIKZw+wu+JxzC5IPNJ3+bchBkwVDtD2JUMJwS+L3X5PkSyz?=
 =?us-ascii?Q?X3o/3AHebJe8ge4ADJRNR+7yFEhEDhqZr6bMmlwSlvg4K+GHizHnr3Cl6Eht?=
 =?us-ascii?Q?QMr91pqpHTBHn47YhbFR55bvhIT7VNYy8E2uRp2BJlPkbsIEfI/7lZiifpHO?=
 =?us-ascii?Q?U20r0PntBP9OZzC2Plw3kDoaemsCLhvr++FwYRCx/l2mEEZw58X1FKZh7iaV?=
 =?us-ascii?Q?3xIYOmKq/VidSJFQ/8G1IgVKLQ93jEmM1n7x3RP8DevQoLClCO9etTMUDdgQ?=
 =?us-ascii?Q?pZ4DGZQFtnBQBfjngMatdsdKp9Wp829MpO8cSOuHh2DpIdv+77Wt3BNoCtRf?=
 =?us-ascii?Q?fZ5gnQCyPR2BM3YJjtitakavxHEpKgmoXnzSRDPFSnpt2fyS4kGfWFB03VaH?=
 =?us-ascii?Q?B65G4+WkF2qdsoCHOJfx8QtFbOpGV0srycpQ4C+vORACBJz5qOXy5LB0UjQZ?=
 =?us-ascii?Q?ZqgrBOvN8R/49g8GlVeRre49AfIxrG+Rih/4XQ+fAi7IibZdxq5a+75r2D+8?=
 =?us-ascii?Q?Tk0TrdB+tHXn1n39sdsS3NMqVz25D5+xPialeWHSuufr7+Vvv24HD8GT6lKl?=
 =?us-ascii?Q?n09zaSe1byf/hhxMsiqwx/FEkVeXYxLsDP2SES5vHBUGvwoQg1SrmzPAcx9T?=
 =?us-ascii?Q?cLimcpsKIvMfnITzvQiVQ0f6FgZaorUriVFIxN+1CEL0ucSre/gFrCznGjMs?=
 =?us-ascii?Q?02Cp9rYGeaqUa9yis9OdwsOAWo/cnyKrEE9bkAY3MLQNLneZYeCjekKENiwL?=
 =?us-ascii?Q?lQ/708w+y5tiJTgTeBZDKSxJvOFdStta+I42j4y80Lih6zr7/+1KoFOYzLKj?=
 =?us-ascii?Q?kbrJzh6mvVc8UCMvV1aml9dNH4RghHahAkV8pwo1tpXji1GyPZ67gJljx8AN?=
 =?us-ascii?Q?5i+YH4yAeCONtXraKnV4Evi6aUyVVO7pq1sW7jPBtk4nUD7Qw1WLlIanblmU?=
 =?us-ascii?Q?TGbnUW1W6iYiww4Rd1kOGAoAAA51Q08QIRp1y+3zWatorctB7iUkxIHoXUg3?=
 =?us-ascii?Q?TAKn4WdMGQK1dXDzLwxfugRFWvlTgqg08i3QLQgxFSXLmKEzbkEqpv8qTymx?=
 =?us-ascii?Q?RmS44+q14/DqYB7ny/t4LN2XWRIZfHpV/zWjr2aijf93T8krRhwLiS2XXK2T?=
 =?us-ascii?Q?FVF0WI7uC6g234CD2a+nHPYCTN3nxu+leK9NRoa3AgV5SDpSXBsC1fjcRXPR?=
 =?us-ascii?Q?7/mwWY9IHvdkxStPZcsK91hJVdFu3TyF1z5NclUqzXAveugRdOL2LVCgFgAf?=
 =?us-ascii?Q?xa7nnEfscm4CQ3y2htCJZrI02BrgOWXATBK4WY6nSdEUt6lPSXq2evrPc4IJ?=
 =?us-ascii?Q?B80yarcw9wLWrG1969hG84n+VyvKR5cs7VPqLyrolE0vNfphgleXTQTtsyHW?=
 =?us-ascii?Q?ddzip8UL3O19dQcN/MfJa36jLfMUibXh8UfzuAQv510RWUhLkNpFOQ6BtHP0?=
 =?us-ascii?Q?5+jf2YhYtps+lcKDVRcgeeFzzeELjxYQnVSNQZg3WWjeDAXgr63+KANHxeXP?=
 =?us-ascii?Q?WXG8dDDLfbapKcN1Mt3tbVR0+MmI9csK8wuMRqRx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25358681-58ce-4370-631a-08dc90456d14
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 09:51:43.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JkcKWtUA0bYQKOTxGjSfmGFSN2GntnCZvZ2+5sGWzZmodmD3DVwZmDHZVCf17zWgVl5cby98bQ0OGQVtHu9SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7093

Currently the broadcast code is set without memory being allocated
for it resulting in segmentation fault. This fixes the issue by using
the newly created util_iov_new that allocates the memory before
setting it.
---
 profiles/audio/bap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 53e7b3e34..e82a25382 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1042,9 +1042,8 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 	setup->qos.bcast.framing = qos->bcast.framing;
 	setup->qos.bcast.encryption = qos->bcast.encryption;
 	if (setup->qos.bcast.encryption)
-		util_iov_append(setup->qos.bcast.bcode,
-				qos->bcast.bcode,
-				sizeof(qos->bcast.bcode));
+		setup->qos.bcast.bcode = util_iov_new(qos->bcast.bcode,
+						sizeof(qos->bcast.bcode));
 	setup->qos.bcast.options = qos->bcast.options;
 	setup->qos.bcast.skip = qos->bcast.skip;
 	setup->qos.bcast.sync_timeout = qos->bcast.sync_timeout;
-- 
2.40.1

