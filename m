Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1591B5C90B
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571074; cv=fail; b=B90tyANdipGGh0MUzdxVbiQ/5r4TfJPg6cIStHXVAKrnNTea0KVewkVdi7gdqaT6ql1KrEVtnbzXSpHwmIS75jeVRyeO7z2vB023U7x6eRkEX6S6y/SSkKPpBruoE2bpZQLi61tMlujWkc3r7CKmnVZJWIgVNmStOSFWnQRJQgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571074; c=relaxed/simple;
	bh=qypvq3WZS+sAS2I2ygXWWnnSF86rWyxEV4/9r4Ma+q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SNEaXDckHD6WKtxOjrjdEd8kfFlCLNQ8CtbUGgmV0pEdBtUtbIr5BpOS7fqXgkENr6L4obRXgY7g3D0qzRC7rkh/rLuzu+wZLvp9XXb7Lb1c4sbEX5alZHD1HR5bG6QBgJGdTbVvKBWDsPoM713LqcMZ5BxVn/1z7GiUgky1tAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NfCqRudH; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NfCqRudH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn1hPEfAAaCJDr4BCaAHjjuTFnKYh4rsl6RIjAD2soPRjU6xR4AXEr++lvgr5kPxnJ/8Dz/u0hZKPmSnUIddjdMhbJWxc/DKePhp+HPcJOoS6W6yD83oHMleTPcHtrds70nL7NXo9dwubPYjDFhobBohlf13aY351J3H5PyKjzoIlTho8VZhZHU9yGfhI3C+REvFYn9lQrVszsS+wnepSdWl62vE6TFAfjMVk+8qRgH2uG3u8S0N4wMVDWBCgr2tLPMS4GqLDl1H9YMGnF4MMIh2JFmzZCIDa/QUsToH/HJS77diJw7ogoII3e1UMSAGTGWrhBIwVYuk6aHhcSnJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6OGAPnN0bHDtTjpttYJtlZ1Gbh1Pczq5AXUxMuEZNQ=;
 b=cyFFgOAj6V36TGX1f5F6rOt40MuKvrAmwuZIwLrJSSliCyWl4gZted+Bcuzk8uKg1+KAxc1D3HbY8fcY1SS2OXGpTePc9eIH2+zebVAl5vav4M2OunfvKgcQf3A5uyx287C1Okqr901C0IIHwY49aa6UWa+ZwsF6WkWBE8lxzIhONmaJVHy555EdFvvlYhmoO3O/GGqnaBZUDi3HENI4nCB/7zrgviWi0yyGOQCPbjw/R4BuXzxNoFI01404UkYKe9jglp8SWQ5pt8iNwXP4Crxlxu+p2hJcmeswAxLBoVw8vzTL3fjb60FYoVuYet8tkQNwhQ3ez6UVfVuQPtvZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6OGAPnN0bHDtTjpttYJtlZ1Gbh1Pczq5AXUxMuEZNQ=;
 b=NfCqRudHceh/ma8JA8s9IF6I06uPDBrUBNckvoOrsW1pSqBFFFoeq2Cs9v07lWeB6UjP8Ubj7GDSGYxqf31o/HoqpTJJrkC9FZ55tu8j3Ba2GLb+MRo7GK5gJW0lZF0n9XZtsX1NWUqKo7M1Ws2zoQEqAVK715wNVdnd/HXNSz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 16:51:09 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 16:51:09 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [2/2] Bluetooth: ISO: Always release hdev at the end of iso_listen_bis
Date: Mon,  4 Mar 2024 18:50:50 +0200
Message-Id: <20240304165050.3430-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304165050.3430-1-iulia.tanasescu@nxp.com>
References: <20240304165050.3430-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0211.eurprd07.prod.outlook.com
 (2603:10a6:802:58::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f217564-9c3b-4cc1-d9ea-08dc3c6b4ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4hG6s+jy9xpMCNsakoREcWS2zDOLtJESS2fNDcBBOAXhpQw4738BYeRmZhb2tKTyTt9oBHCmH3QD0P3xX7iLfj9OBi0GHF0cAgGwjV72jhU3WeQxXHV53vJFlB/4vBjrb0r7GA1LVphCKm2cYQHmfiyFby/bCW0sK8r7eQ5U3TQkWWWZ1FKTDp6RU0gvlstoPEzO/xOH7stxjfR2HTSnZ+miVnN70RoU0ufe77eavrtlP1gP0tj4Sf/oV0MBf7SZv8xo+7uvT4m1VM84QjzgSfnGE7zsgYWicG1tOUNn6VNUHDwDTrYUwLv+lnenJ2cAhn8tkIHt06TMKeNB2qVMiATdYau74zyQAsVE5gmXdFJm7Ssp8r+bQXVkJ9rUuomsmnK29WAuLJ3XD5H2jq/skCAOxkpFGIFBwtZpDsZ/Cpjrcgpvolpd6BfBFSx2SxVLpf6xj0vQjzMymV/LT9nPHsPDhDyXFnKcdz1tbQ+7HDahwiYQ5+UEQEWTTS/FCko7YQ01kuJBjP/GHr82NxF5z50JNvB9xV6NaFw9Abf4xvBE8luVaIGaPZNj7KXTxcTXOrOTng0ACTehTKl2apt3lyyYwTszFc03+gryfZZ+gzCVbVHN+Hw/FRQ5dVe5xyq0IhGI6zgCac/xKoTVWvoAOx7LEF1o6DeawbyMeEi7TUU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6bzyqRPWny3h0EPRZtXryD2/n/yQkxbgsYsn/ocyewUcAGCqPv/DocBTmBDH?=
 =?us-ascii?Q?DWWSCf8kTyZwIFBpMDe+c4HyP5xvUYUWiHGCIjMvu4ju8gZn3/mF3vEwkEgO?=
 =?us-ascii?Q?T4augwLJdiJsO+hsLJnXr219H0pBd2yCiTPI+6N6BqH7gYhjl1ORE5RZ6kKb?=
 =?us-ascii?Q?0tghSOS/+wIJBk6HXvgIpDi1sxtNXVnSnpbGCVkpRW7hHzarJJHODJ67IYAe?=
 =?us-ascii?Q?/cGWHz/GgM7o/Dr0cEr0TroWV/vdh9VzMdQM9VxbBXF29PAcOa5PMoiNuZ3S?=
 =?us-ascii?Q?2QTifLDIG3xQbCKZ7rTjV23dRZRryIntEwTpbsTZvWyMjGniHT/OZ+7w1Qx3?=
 =?us-ascii?Q?gJnvvwtw6rDEu8rYeFhIUS3rVpBkc1YE0jMlyP5I1902as7jdnZ7G4DOSX6s?=
 =?us-ascii?Q?iqjauV/PIAJtJbjf6qpTxvXZpFD2Gf6iLYx7VVCwLKyRpUFRIUPSyo0+oDfj?=
 =?us-ascii?Q?bPnlsLzZQGQLaV3UA+qKs/HILsC1MPHhIn2+cZMbMwPhJjoh+46gErZSnnrs?=
 =?us-ascii?Q?FtI/6IPhhiCj+xaQHmOM/jpbwrl4rVwaPo7SNGoLTKds16VtuYtnMOGRXAaf?=
 =?us-ascii?Q?f1nw+dDEQmjBo8f0RaWl4E5KQJLd2mpQCovRhdngE/QaYCGrc6biclLFNf69?=
 =?us-ascii?Q?+WkgsRBiYQB2M2zKccaoJWil0d27VqfCwN47yemlgzJmdfwu/z56Czq6BnwK?=
 =?us-ascii?Q?tOnSdJL/x4r4Z1Vg6G8WBoecGC3sfRz31uw3EMatOZ5brnyftnoviq/9GHut?=
 =?us-ascii?Q?HRPuL6Y2NAOhlMUbLFod741JwsKP7+44p+NKSe+SBRPzhRtl/t/x2C1y5ono?=
 =?us-ascii?Q?Gdx9+XtPX0bOVSd3Gok5y5e9zu+RVrY3eUFIXrOwmsoIHCQ4GQf74GNOFQv4?=
 =?us-ascii?Q?N0L/PUVY0pSSu8YWhB3abX8KoI5a7ZikeOQdsUVqKAKCMRSOa/j7xxgaWD8/?=
 =?us-ascii?Q?S2uipcpiVExisi3hg+qJ3ooEBFbL6MojAOCIjPb1hPcXaUwstCESMF+RShbY?=
 =?us-ascii?Q?gIfAqr6uTFp9QKSLU0GQDLG1reNXl6Pt7DNDVJ6wczwke3y6T9fEJbmKuklv?=
 =?us-ascii?Q?ic/t/UBFs9+vEu49YY58Yf3XzymCq5ZstNpu57qEgsmVr6p6yeZfYsMydVAG?=
 =?us-ascii?Q?aPurIv3sLS9hTJuP0wOd6s5WhdNx7wBtCWRIFTUaXocu0dWHDOIW2Y1wDgB4?=
 =?us-ascii?Q?Ok+DBSij5kJ6JSwD24nG6XkgZap9XfptLkf4MMvclQN+VyE9OR/BYGPHjzCl?=
 =?us-ascii?Q?/gx8cdKemTR2MXLySSjHeOXI1zH4ZMuYzjNc+36WodofCT7LqVMF5pByi7cj?=
 =?us-ascii?Q?/ZyzG8nvJ6vHhCb8bSoylRDjV1iiP3iPXZtHw18vnQU2nvtiDYPUW9RCsWie?=
 =?us-ascii?Q?dR10QWj4HJdhAL2hz9oCXw4XhB7f27kTFVyIlDN5pnYn7FT2p9Qt7ab8na81?=
 =?us-ascii?Q?fRdyaKky8Jt80dvhQ9UKK5lKJ1MHepn5U3J7pjVGZBH1JwlZkxfWQGLFHEb6?=
 =?us-ascii?Q?TT2iUM7aCsTBVTGiHSOXAWadoZlIsCseuUVkqXspcURLrJeTGLPDFRgSCLMf?=
 =?us-ascii?Q?77dyv+MnhHEP5KIQjA2cXOVCTVgZ8kFF1xZ2v262+Y01+wD7B5sW5ryxavt+?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f217564-9c3b-4cc1-d9ea-08dc3c6b4ae9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 16:51:09.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9E9eA3iZL6gJVHMUejYcp7mRQ5qZsDvjfYavXFYEIeF9yUncIHEz3q9hR0+9/A6ah42KntedrkGKV0BTBrtAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064

Since hci_get_route holds the device before returning, the hdev
should be released with hci_dev_put at the end of iso_listen_bis
even if the function returns with an error.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 163b07db575d..b1a211b75625 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1131,13 +1131,13 @@ static int iso_listen_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_put(hdev);
-
 unlock:
 	/* Unlock order should be in reverse from lock order. */
 	release_sock(sk);
 	hci_dev_unlock(hdev);
 	lock_sock(sk);
+
+	hci_dev_put(hdev);
 	return err;
 }
 
-- 
2.39.2

