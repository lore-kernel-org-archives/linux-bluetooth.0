Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3521B87EE
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315348; cv=fail; b=SaAYXcK+5z5mKnuhiIMDFJ9tcQOMKtAN7eVldnVhcuekEYsdUFsie3LW6GLZ+t97RmSkgNommO/Yc2GOBLJVGJm8fBpLoP4ypQOeK/Cvd48Mv7mLrv1Q/7X4QuDGe4wA0MnDip/frQI8HB9Jf7p+TCFrdHlVjZGjnS89lzeFOuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315348; c=relaxed/simple;
	bh=xulDf6KkoDyIuhMIJb32+CdTtEy2VX5BODZhivQXppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rn326um2jhbGCtE8ykD4VCCrVECzS6OMUlIJoGKO8qBjYpFsCddmxZBAIKJKcWi82y7L5pcsedDrrxLlK8S1jZy8I6W0r16cttN83IoLfOnl7ERArEqEYaU6sonTgYNTc50mj4FSOFN+2mnRABspoYtxIRS8rQs39T6drWzKa0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kCmlz1YB; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kCmlz1YB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVZEXfSofSlv07nVmUAGHMmT2d8Vm87azZ4V9mVH9DI8kPgyJqkWk9QXfO1mOc44YZbSPkCYkrCbyJx67wWBUyGUNwR3JnJDZlP20ueUeIKwnIiqDSwJUReH/COwpcmksEQn/98BV/jb0MJW9HQMG+SpoSRjU9o34gF8BUbNkmfwoK0iIhMYiyy+PYGNcrb1VSlOWcF0XAJSzbIQpi4Qn0AuIwOXBopKkX07lg6cMLD1CNnzEI4qzzpJgN046gU2f5Ojea2A5Dopm12X9d+6x1qzO+y1T8p4u/Da05+CRokZrKlPsx7MlJZyaJxM+vl+6PMAiirkgT8RUe+HLL5vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WgwJD9I4tM20m0QPM+aPwj+T+FWGadm9j2m4AN3uJM=;
 b=kxFJRnneQKe6qkFHoqc8Kw/0AIhLxbSbfc/t7f+xU6o5TIMx+EWuJ5KahDQSUhQ41eOQ8OAkSAgys1XHuhoh8q5MRj9qLvoct1Ub+/6HlAAB/n8KuXReLaWwqTQaYc0hwO/ZdnwL+atMRUAy5oWycecbrL33ubI8ifEPQKZO5fodiM6+ww/TV9vF2oMSo5IMf8+QqKuGHb8NTe0om34ZiAlQTt8FWUU96pq5IAFf8ANjh1ZxYX1iHeDPYmxpmOstXJAD52uJBBV1tmAchMDy0ZtdV6JOqaEkZRTjbWF3TV2ifC/3A7SFxmOBD/PSx7D6fODrlB0nMK+bPISac4fw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WgwJD9I4tM20m0QPM+aPwj+T+FWGadm9j2m4AN3uJM=;
 b=kCmlz1YBhFmcdCOk1/VPIKYx4XogSZc/R7HrpcNjh2CjQIKVmh69Fk5qLWw8awqOSLYwOK1vPM9etR/mX63by6q16KNhhjU0CSSmUjLnfvveYLrrwQgfhb24LrXY7BqWMR8C4TmCe6QOFJjxxCCTIecyIVTi7PvpA+uOAHHF8ni87akIanbBn/0/UELCELc/7SZhNsjo4JZFBFyqiNJpJE/FZoIR0apFnN7kARoyZxfdJ1rUmbrWSX1HaemBV4ttHNvXxqgVNEQ1X6nPeBUTmpSYsZDFBdCdJd2lcKkvmrplCjf3/OJV4ep/qlAxWgAMo6NqFDHYPf90TJ8r5CZfRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Wed, 4 Dec
 2024 12:29:05 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 12:29:04 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 2/3] Bluetooth: iso: Always release hdev at the end of iso_listen_bis
Date: Wed,  4 Dec 2024 14:28:48 +0200
Message-ID: <20241204122849.9000-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
References: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9be283-1e0d-46cc-107f-08dd145f3dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Gl/xA4Lzrdi2S/czjyeV6bimt7zzO37gmdyPFIiGI1fmr8+1enj5//cxcSB?=
 =?us-ascii?Q?LtVWLst11SLsbUh1dG1QXzrpPcKxyhF0hQjUdinOLAnKj00GtyG6Imjt6HmU?=
 =?us-ascii?Q?6KOhORuH16qHkM3m3AZsawPTinSEW50LZl5Jhqz48hQygZPij+pathPdTrgz?=
 =?us-ascii?Q?VQl/bjCuP2m7H6G9xUeolADHIwWlawKcDipH3XPY600jwmZ3xSsYcJYOi84+?=
 =?us-ascii?Q?9gicffkr721TIn1qX4q7rY/fpfaIIw/wJLV6nxsDW5De+PuvIgREdpF8tHe3?=
 =?us-ascii?Q?pJdX2dKpFvLkfgDZC+fV3/52E7jlLdxUa4700CmnxNoL2QmciD3RhC1ctFdy?=
 =?us-ascii?Q?y4jHlkAKbAwCrq+Ezmi7IyQVUkaG0mXquxK/aZEHE0i8hzAagQE1KcHkrmgW?=
 =?us-ascii?Q?EOLTb4UIYVhb0gmdnkiedFikPnHaKiQr4RQNyzB99VpNS2fFQ48KqFQoelMC?=
 =?us-ascii?Q?ktsyyWD183Z9WP7Ljd0K2c2lzysnysZzG02mCGMGd0yDwfm/A2mBRFz0O1Cn?=
 =?us-ascii?Q?u+YtvaY9I36UUMMUvweYv5q2KsdJY8GqVkuI7uL2YdV/PCoWi4jEhvDpcVh4?=
 =?us-ascii?Q?e+ZCMk4q6RXEUnc5oqgcWH8VEy+kIa+/rbJzk0UGhl+l3ZPur8PEFdF/plSS?=
 =?us-ascii?Q?FW9TQtvVVNb3pX6aLSpN7+ELYDWZYo9kzK5Ug5oAWuNvAfovEHfMMKsOPGIY?=
 =?us-ascii?Q?JV5mZ2Jvi7yZoZSr0jIxLduPptNxOIvUtBZNim/yCeXecMM5qcMY7quM/YEw?=
 =?us-ascii?Q?In4FCbn9LXP1CH7xr+ubjI+iRMGJAdftbJSza5KuQzoiv1NiQaYczBX2b8AA?=
 =?us-ascii?Q?FkjYpLGj1SRV8SzQz+DnhIz13tiLX3QSLWfZbqoDHxc6Z6sO6eKt2Pq0/dkz?=
 =?us-ascii?Q?JZT9w/gWR8tS1ubKXFmCccPQN8UShajYKjOdEEC6WQlP5Q743ioPbnpE2mR/?=
 =?us-ascii?Q?DsMMK4zVANMV7SOOcxahyepkkoY+pSA4BVjbkxCiltcmribAWDFZaeA3JvtY?=
 =?us-ascii?Q?zND8K1ptcWcGm9Kn+I4YLZpI3/q832HX0FRtLbIwC7LwI8DeC7SGUoF3sWb1?=
 =?us-ascii?Q?YiLoJHwcYg20gIizzRLu5YyooLaqKI3WO17x0kFrF0DBN8AH1h0DFQZ2CocR?=
 =?us-ascii?Q?uiFN+d6Z1GbFPs58lXKB8Voa8GsF1oEn0ikboyc4DPcZzUMk2n83o2C2X9Ub?=
 =?us-ascii?Q?QIcKjqlxcKVaqFWbsZgHPuyhMOEc4VzI+rBxcK4zwxXWStcjJ/z0JnSVttYi?=
 =?us-ascii?Q?UnILYYHLpDKr4VAmGk7tdby1bXYJFXk45IhD5OJ4uNCiWtpJF2UWVGW+yhPl?=
 =?us-ascii?Q?HpnOBOCBm8LrwLuo1i7jMrJEAM0wENAVFW6mK06BJ8Vs7w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmXswiOJfNbDqa5KpZ3dfVuRVKB2QaR+nrreqc6rBcXlIrUK/ahOUpOCSEAw?=
 =?us-ascii?Q?WGxrxRhaozjw3wCZ7YpU2eGSH/+asZSRlrFsar/LE5lOio/rrICFMT43j+Ct?=
 =?us-ascii?Q?+2sg7Ux6KTFylMRxJSC+M5k2FJ05qNePiwC+2DrjbNlsl5PxS96lBls3CgtN?=
 =?us-ascii?Q?qM9wz2FqSmYFlrmjVNW1PQUX1E342xaVYVsCkObqYA1JDKTeAPOPDfbmIB1/?=
 =?us-ascii?Q?zfNt/niwkiPt0uXFS/sNETqEEvt+y7Ojo/6ni+eKRRSsBozurglJQ5tQnQ0W?=
 =?us-ascii?Q?QXUM3XCTy00+nWLIvc+IQ7ZSzmH76nc04AYwHHZ4uqYXSV24q14N0XL/zjxb?=
 =?us-ascii?Q?PS2Z37CcUCeG+IzilDQT8t3qsoAzwNmAuPgUQCXjgqRga1f3jW8bWd6H9kh3?=
 =?us-ascii?Q?jujPn2CUNyn56ybad7/oziSUaR4a66YuqV6BH6MDwlBsdm7aqblzC1weR7WH?=
 =?us-ascii?Q?2/iYQeKUL6qEMiPR0uDClf05tjIOMslMY9M4aNfZDNulx9s28rvbUPH3lhsW?=
 =?us-ascii?Q?zfpQOJuQ+4CHygVzWrGCfzoHpWXqvX+jPqyoLlxgC5RJj0YzTFTbffs5qARu?=
 =?us-ascii?Q?P92MdeqUfAc4I4ZOR4K7er31OIVGFGzoORIy3Mqn94g5pRpEhg+BZS172MeJ?=
 =?us-ascii?Q?vzanTSwO7svVJ3WsbkiGyr/02tDkajDPPI0tofBEmo4e+rhPRz1Yi1AL5EzP?=
 =?us-ascii?Q?pUcptcG8Pn70klvGUV++at+cIlP18PypmBgCOyVP/Nks56+ZnkorkwuIosax?=
 =?us-ascii?Q?OhcndI3cm1/IaMNqWcJEg47HRUWQrRIS5c2hYOhYsxZK/qdWhNrEy0h/xNJu?=
 =?us-ascii?Q?gsR92kYuPHJlXWwE5ISeWiYZUhjH/d86ysF9p5/nDlb1bG0ikOMO3Hj9cgcP?=
 =?us-ascii?Q?S0VZSo31wseG4Yw38jcpDO0UmrCKedhf+AqbvuMkcw6J8w5i+DYhiIXf8ahC?=
 =?us-ascii?Q?kMyzrf2co+DsXt/NB3ue5tQTVmD4pUoXxCIQysEFSkGMu68N4cYz3rBpzLiS?=
 =?us-ascii?Q?7HnXfAPwuAmAN8xLHLaiaiSmbrzIu7saWpq4Fjxot5l6MlSUo8302CEHIQ5A?=
 =?us-ascii?Q?/CfI9cQr0RvQVGDlR/l/0Svp3zHePVGJgML7Ds0Thk7CH4AVb/MqLSf+7Y6A?=
 =?us-ascii?Q?IbZjjN5j6+505OiBO3mnkzPXDGfllN5kZdvizkFMRu7X5lNpOEHDpbnVp/q8?=
 =?us-ascii?Q?eCr9DdhwHi3+05oDNSO0cepktiSsuiqXYc1WvHg77NQXzdJ31hrPM47/vbx4?=
 =?us-ascii?Q?SgC9NqfYgagk8GPxtuf7PAlpSTaBSxCUsicA1NRaC+M+1z7YsCt5jWehgwFn?=
 =?us-ascii?Q?WU4mcHj2Ko/ogSAP0in2VH2XZnuSfKjCV+6T2UZh65r6KcLihf3/8ZDPPy8s?=
 =?us-ascii?Q?jRlX45hM0QS+5X94sBoaU46Cy8wb1WmIs/wYi9w5Q49Zjl1eXDzW80fUthvn?=
 =?us-ascii?Q?Adp1bHmiII1FGnWJANhLuvy/8P7My/o3rR19Mwoz7A2izVZzpLxLI5X7PC50?=
 =?us-ascii?Q?29WU2O10KcNFFoPyLzcT/Hhk7QMpwTZrnfVlnctpNHHvemshU89ZNG2+upkm?=
 =?us-ascii?Q?2M6VCMS5ldJlBiDstorWn6TPag2yX4JdzEwY8eBDATVsnwWi0M6aASut0GST?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9be283-1e0d-46cc-107f-08dd145f3dca
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:29:04.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHc88r3nC8sowufGfVOmVp7jq550cSrKTbKLLNj8C+eSDNJL8LV/e8ptS1AuStb4J0BwE9vo17f3Ee1J7nXIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431

Since hci_get_route holds the device before returning, the hdev
should be released with hci_dev_put at the end of iso_listen_bis
even if the function returns with an error.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index cb004b678d65..df523a09ca9a 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1167,14 +1167,14 @@ static int iso_listen_bis(struct sock *sk)
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
2.40.1

