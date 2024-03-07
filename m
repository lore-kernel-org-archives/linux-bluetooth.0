Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004812D753
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819934; cv=fail; b=MBA6IkMvSWG3Dy2IbE89bk2hUFhNx0djFNKBuKAvvvW+rU4fVRhKios3Lf7ZDJ4hXphe+yYOtQ1K0Cu/AkjEPBtiCDLqqDYjHUB535Ntp4gezFqDhJaGaC60VPYhHmBYu6sGSspTEltni/U7Aqstx2WGFwq3VVQ1xjzvTUtPTX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819934; c=relaxed/simple;
	bh=6MR6+EgBvKVOIu6+SXwdbd09yF1yIjnGCSb+RgesRHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AXegA/PHzk+MZAJZKL6K3EezsbZOihLBNrGHxMyU9bR4Qrl/KbsKYSRDybN9u98z4f4R7+JRORVanzOzsgOWT/qzZKLuxW4jRlhMSY7dOAdFsoikA1izkHnLHBqIkz0yQIT+0qAxq1+IlapHZubHfesYyF+8e5y76FLgA6d6yLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NvINnYxt; arc=fail smtp.client-ip=40.107.15.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NvINnYxt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cp6NVYCdYE/6cCeGb9xQ/v2rhVsZYCFWsAnJPCALhyyaz/2htCxvrdgvZ/QqyvoVBChL7TO44B1PsFZXcui2mRItLmqeiw1YERDGgt0sZFHB3qnfehparTKNhLOo7bBIvRXaWGkPsK2X219MEFipL0wojq++1FsaBSQj3FIhIiA6wzJc58f22tnRdn76jf1Y3Fd5Xz0rfz7APOBzi14gaNtPq1oc9OPRrKR7KAmjuXWIDIOhwAIaKlHlDv+nqpM3RVywHroTQpFA6+Au2EkyHG91EfRImCy8sU/iY+HUYAfbZDWHAUJ8uxuAecyVHJdELU0keKpK81c2ZwfPyNSC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciLkxyUn7Fu2cMas7kn72dWiO4fEzMz3n5UpZnccKeA=;
 b=odxl4Y7fW4XQtr04sr9WAcGT21q4ihBAFFja6DsWSyCzLY4U97i4rEMPx/DM918I3jmtygaVRLty9CSNW0I/rnptazul4NgG5eEXv9eHT50Tn+1Y//jGRmSpvyW2wd9PD0gUN36IpxwvsPfLNMTO4pMVw8mXYakjhYCR1d87BLsJ1mOzhBXPtdNWP3yUlMnOkfxUnzKDArJljb2ijTb1FJnhJVttAIif/GAK1g9kBSoB/ehNcmnQwG9RNDPXmC+FKzdp360jKvVmiGatxWOqCvkmnsBM212HLCdVIT4ETeSHuq/PZOa8mkPM5Lswwga+f+YydgO0DOXR1Jp0Ozkw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciLkxyUn7Fu2cMas7kn72dWiO4fEzMz3n5UpZnccKeA=;
 b=NvINnYxtYZaRzR5CS5DxawXMmOptnd8TJRdrOrU10XJN2SgLHbxolY7i6g8FDCitI4cnLpVl5n64nfuJGWqt6K9nuxxPJqe0FI46+5/UdoADQIUCXiM622/ypNV8XW13edVomrUaoiFdNjrCdFpKlme55RJU5oah4LxW++w9QCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by AM9PR04MB8424.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 13:58:50 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 13:58:50 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v3 2/2] Bluetooth: ISO: Always release hdev at the end of iso_listen_bis
Date: Thu,  7 Mar 2024 15:58:34 +0200
Message-Id: <20240307135834.3941-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307135834.3941-1-iulia.tanasescu@nxp.com>
References: <20240307135834.3941-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0036.eurprd03.prod.outlook.com
 (2603:10a6:803:118::25) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|AM9PR04MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 86899e51-98f7-4c46-90f1-08dc3eaeb74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jYjS0RKeJ7ly87dJleSpqnLqyQDTWYbm5sqGKJJq46QK+Lyc4Ygk1UZIXaZs1v08uhCRbmzaP69ttF123/8hBCWA8qOGXOWt6kCodsJRyHU0oopWh2v70SZ4DZcri0UYEPHh9cF99pETPrGxEWIvoBUYNmg8izt2HvqRrfvjtYJE1UMO2gTPAUsAOswOFWEH7P++H8QeLZay2Xl7uV04m6TBCuBDIhpWTdkb9sB6xZjxwVqnChAetUSMBFIPYOfW846+tlb0OYfEd/fV3W3wgonHVmjr7ouT+HNVKIK3icEGtnLMgIK7vRqYZ7SfwBmyQA1tEKq4iLE/tfrBL2oNeUCBDkOVwGNW/mnIVUj4Q/ZyNfMIn4HQWLqFlGAY6UfQGO/AESJCceyICq2fhNkF2kudC8HGBi0yGcH+t8VuF4i2jp/fgGZoiQH8WibUgJpi+AFCBjOwkwP9kYR9DmjmHt6Mf9KEKxBEM2YD84VWctMR5eAzEB6YBct631hYUPTU63yTWQYCHMBDRR59CwW4R2V012NbGc9hlRktM14n3DyWhAlH+/2fXSs5KMaW4rzOe8axZYKy4q+iuFgwx/nbyHSfO6mZ6H9+9JE3nCrOt3i8FFW4HDj/DJ9KQGBvX5RBNFMF92fW9IBmiTIEpNiNKQc3XsKklB6lUXFgjMeqq5s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mUCmvlSudjVklL8qPnI6qgCYluqSvBBVi9y+XeOv709nqm5gx1FGRyJWSmfh?=
 =?us-ascii?Q?mn5snOZRAz2WHCjFFpoPiRR4q76W5lxGs/tpZHhsuvb+5gMh8Nymyl5IfNI+?=
 =?us-ascii?Q?b1sGNFx4VDoKX0lY5NKYAKKqprwsQNOkGlZbm40bHnngd5oZ+xXGBXkzeHGI?=
 =?us-ascii?Q?lqAF8eCkW6fzzNhbtHF0iZ1Ec71DnaN6Q/jHSYhwEHJhWb6UWKd6oSWB2BIJ?=
 =?us-ascii?Q?VFUDL7y5tk11rtLpkB8MF2IWp4yMGe4d5y1bXmFoha/mcQq7Vyckbod8wbAF?=
 =?us-ascii?Q?MpgF3d5G4YQ7BGkeb3Z+RhS2jpC8WrvBaZlP1GJ3hh6diJZce8jYHLi3sGVI?=
 =?us-ascii?Q?mSg3mdKH23vO63CqAOqTrTb2aWMHrvVRhRInsmn0xLjRDOHNVMYQ87pzjgKS?=
 =?us-ascii?Q?StJTkq03l7ZLxa5uz5GxZHNra4kqf+gSbk/D8q4+4O7xJGJaLEAyd4PC4EhE?=
 =?us-ascii?Q?srTrr6vyxYjqEvYLUhYvZKa/uPo1h+jas+GpeBapjCb5wD/dXNqJgSLuYww/?=
 =?us-ascii?Q?XF5uV2RDID9s9cB6b4+EkvJ+riBnr1/E1bRDx9MQRMotLz+pSc2Oo0fmglG6?=
 =?us-ascii?Q?aWq6YV6uYXFZxex0/ZqsLs3eKsTkoP48ZhpXLNEzvWlZwYQpIN+GrtsnMZrN?=
 =?us-ascii?Q?mXFo+FbkyZ36gGwgnx9meg6TEQcP38n8yGAmlWe+kcODmR8ic7/s2Vr63T08?=
 =?us-ascii?Q?9yj3ABgd4rn/Igx+piktB64S6zmj6VPtLbVJen9OlKORTnBUw+InT51tQamR?=
 =?us-ascii?Q?PTKxDGUoyCjnUVBuRu6WXJl06lTWwpN/QAD7bu0XWb971nGcT5M1wEVR58+Q?=
 =?us-ascii?Q?055xtJk/WJ2RwZac/KG8Ua9YtgofRHG+KtdzPc46JOlwrrrIY+hlgZQEOWJi?=
 =?us-ascii?Q?CvLboXwW+siVFua0Qm1izb+7TqKa9k3eeQK9lWXVgaCOr9LY84I0U2CjppD3?=
 =?us-ascii?Q?mh8GOJuEINEoM2wgsLtyhgbR95KzLaBuCOHDeLWAKfqXSTr1QzArZJWpweaC?=
 =?us-ascii?Q?KT4PQ0m/lMAervA77hhgrZl/jj2btkNb9YIkd4ke5bsOhhpdIQZQsTO/5rUV?=
 =?us-ascii?Q?2nI+kC+sHg8okxBAGdcxH3sxiPy2bxEP7jKFq5h/+SXx0o+wM0gBZUFW1LA2?=
 =?us-ascii?Q?vVb0oeqC8p/eXAK9uZvE4rqHp5V24vfSs2CvkzDxV9Eb7kcYecfd3OezZH/S?=
 =?us-ascii?Q?1MLgO4ZXA4xTqiZ24GpFWgqmFJn7jLyhdShhC0G/vDeqoz0PbXNXIHWQVmAf?=
 =?us-ascii?Q?LRIeCqKbi93ej6xeqB2lntqNMCFDbv6ORsrxwr9JrZEyjBbpvHiDWwtJ7o9W?=
 =?us-ascii?Q?2q3WAGvLGcPSoge1YjeatLf+nBp3jqpjBhdfejJfndFc8sVoy9Jx5SP/eiPr?=
 =?us-ascii?Q?6Z9AQBrt6LtpphKIlAkvo7+0VHhyeQlOMFiDzvjzhg/zu/JKQmXei2WRHbl5?=
 =?us-ascii?Q?+ZiyKPCxFR9CWD0xfFnmjpS48Pkq+3b4lbk6h5CGleAeeldaB6vdKih40vZw?=
 =?us-ascii?Q?lEhrkQhrI/OgqaWy0GNat4M9ZJRRPpwLmyxuTO5AISqPxJyb8fx71Dg3kNOi?=
 =?us-ascii?Q?Tq6EHSXc00MkD2YpUgGp8cmIKa4B0aSvnQg7LwQEymtOzwX0LPiyt5WTkhdJ?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86899e51-98f7-4c46-90f1-08dc3eaeb74e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 13:58:50.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a2j2Qp0Nnl7TiBJzSVh+yWipbcKQVOfTOVRrazMdrC17R8sT+6YYGGbnMcB/tDsHP1Dko6R4yer9iS0syfv13g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8424

Since hci_get_route holds the device before returning, the hdev
should be released with hci_dev_put at the end of iso_listen_bis
even if the function returns with an error.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d1608387fd85..bd2271cba359 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1134,14 +1134,14 @@ static int iso_listen_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_put(hdev);
-
 unlock:
 	/* Unlock order should be in reverse from lock order. */
 	release_sock(sk);
 	hci_dev_unlock(hdev);
 	lock_sock(sk);
 
+	hci_dev_put(hdev);
+
 	sock_put(sk);
 
 	return err;
-- 
2.39.2

