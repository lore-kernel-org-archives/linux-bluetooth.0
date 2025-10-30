Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A51A9FB5
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832035; cv=fail; b=O8w63c1wf4rR+DWeTk0XX3aUpLrZSKEGznDLuIqTZn4KkojKLrSFV7PCI90Wceijv2OCIKxr6puJZNhqXUtWzGiSS+b2W/3mdLc9K/mn/AYr25wMh/tuOvjz32nxdF+DHER6Gf9ySuXdZNpnGHAriVHU9KWq/b6yJ4592kNjz/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832035; c=relaxed/simple;
	bh=t1CqgrDiPxRXT10XRK/rFiSvFY+yaKjKsGyMIhZIkB0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EpoabCJbLrfGv7kteFYhA70mK+dALpGyH4ulGaHZ5SZq/cUymkR+f/RCCBFO6joJU44AKyAA41DwEBKIELlZZJ2CsbPUCuXNtfvavAE1VUKYMKoVIx/z+LVmJ+yjuwnU85cjF2eiTzkvTDmfrMwfYe8U43VntltZAxGo3uq+3Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jzkpQQ3a; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jzkpQQ3a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6oPUzIVJgYfOhaFmf4AihBuDWC64oFKmqOpPZASSMJ+z401l4hUud7Zq4GMvYSskaW8y8rj4868Y1WUjZzze88Sg3TJK96/J6YML9RMOSoienysSvFPItUbPhUJQsQQMDbBm8PS7eFbSRYnBQ4enNR6Pj0YVK6TBOTdBEEme6kxAm45bPuXtEkjM0RwSvzYobUUN207VmcJz/b9BBYGPMmKc3B8ydbb6EOGUdtV9Mu7K3Nz35VnKScIuNMWi+DTsER6aWWHtyd1kmSWt+znIrWYWTIlYTrGHLrXOVRR9XrG+EpgVMxQqHql6m7CjmbN49TI39Pn67IqKHWo5jo8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mw+ITXZAHunWGYEgpvZOQvqzI6VuTZePzudSyyyCR8s=;
 b=d5M/X0cwoorolWJ6xmfgkP+zez8g/x2ZvPv3kWvhnWpTcSRcwbNKZnHm46f64+F7GK7Rx+BmeSGX4CGnhQiH85Z3AFQiwAB0oOhzekp9eRuBuOSA5Evi8WyRqRKY06pl4NetxYyRst1iAFV2l+EDV1e61yYnMCKbv4+m9rXHviY9cwtdRqpkjxhcjeNYur4J2LkswjJ2lQSh+3eNz3RUa3kzfk/iA2tePoerv12/SPgG3R96xc9uYrrvJTREbAMVIMJUOBXghD90p5MewY9A7aOWKjdOzcv8q9vEczI3Qug1XY9fyLJjIDfCcRecNgCWdN8ge4AS4Y6p1fkiCWW8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw+ITXZAHunWGYEgpvZOQvqzI6VuTZePzudSyyyCR8s=;
 b=jzkpQQ3akKvIRBtgcL/tLtqBrYakbQhQvVMUexIG50pV99q+U/V9O++34GRKlawwYFfOherlK6ZYB3RO5P0R9Mg/lREJlzh/RBgRxX2G0UNa4y43uZqb5f2Pn7APaHu2AwThGOqLErd+vJ96iwa5gZv5fUqyjf7wGQ+ENdfAJHvB8+BuzibOEcS1bw/1sdgc2SDpITG1/fYQFHA9olD1ExKECvvleHptXaH19eayVxY9e2cDbTiD2q8gYkG9/eAo9cRMnFXEGNfL29de0JcjoxQcC0Ha3IyrFivzAmK0y35t3l3vFhz5d2gmcdcFtX2hTHZydbwjEMhOSfn5EICzEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 13:47:10 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2%7]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 13:47:10 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 0/1] Enhanced or Legacy Accept Synchronous Connection Request command'
Date: Thu, 30 Oct 2025 19:18:55 +0530
Message-Id: <20251030134856.2726882-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|AS8PR04MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb64a93-65c4-48d8-7f2c-08de17bad2a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jHG+SC+SphptcphZ4jNLiOqln1ENhqHt6zbMWtiJmfdgbbnynrPF/+7vJgL8?=
 =?us-ascii?Q?wYuvbw4h/tn28JZQW1FQGE02OwFuRLO4/tye8o+F5s9dLMlQDu1+mMwreuXy?=
 =?us-ascii?Q?AjyudPXtc3/QAoox89AYZpGYxOCgTLDUWPmr70P8tj1J/v7kjujqB1QcxfR5?=
 =?us-ascii?Q?n0wJaMfly14h2m0JglxQOIs9SGwpLGpm40cwe6YVbIK3pOGH5ZTlQNEcVKe9?=
 =?us-ascii?Q?p5iZ6qYVBmYITc/rVJ96uzzZvUh6j4XisleGXMY45Ya+ab/9AxiBiNAcT+EJ?=
 =?us-ascii?Q?mPIMy5RxBwhRS1J3I+d4mGjVKeQAOtoPgemIXhSrs8Eq6cL7Re3dGHuaNnJv?=
 =?us-ascii?Q?u27Ara4t7Doq6TLP2vivZhJvhdgWujNhW72sZppEfe9w9oAKr02tpPWeCkCZ?=
 =?us-ascii?Q?5/P7JGRdD0kIG48vTzapW6sUJRHBJa2xlNjBCCs0gsXjthSzCFO/KkT7Tz9v?=
 =?us-ascii?Q?vIElvPmC4WFGXWpp/E2UMw4e9P0OVzTKI0o9sfISbf8ZJ4GXBmGwAoLO8kzu?=
 =?us-ascii?Q?ve+ahq3GoJdZBYPOpNXXIvVOFqp/L9sleAykRE/tF3f8ziv8cl8/+as35/PP?=
 =?us-ascii?Q?WwqDNJZSy7xQSdoJJ/U3+oem2hSZM46TCMn0lGZc2YFbyA4eXfQT21CrExhJ?=
 =?us-ascii?Q?8NQGU6uLW8T1lziVsyeufE8hOTgbzUlgFV1pFVtepaWcQQ/9bLaUhjpUCbD7?=
 =?us-ascii?Q?qaDuNekOQaoYnSr/0oE2G3DSbzU9XD9WaUJdxP6NPL7f7KiXRZB9LsfN5wnL?=
 =?us-ascii?Q?gL6ovz0a4Wq+/as3wF4otHf3YIdQWzFeQnwzFIpQI+Sb9955mRjTEbAPuMbO?=
 =?us-ascii?Q?CXWPsvdMUAoW1fs7dEccVasxgtl3Z8nAtoJuX61E7Q+nKW7cn2P1tlMsyPhu?=
 =?us-ascii?Q?9J4jR5ftLwwH8yAwjlAcetYhUi2REKaeTypOEZ9QXcg25M18Z6FHA4I/70di?=
 =?us-ascii?Q?8b7yCNDqLwawHZwoquQZCAJwa2CcjiOavRRLesoHn9kWonqAWuEG/HmAb6Cn?=
 =?us-ascii?Q?ZaS2oMF6E6g5giTaBVIP+tkjRRw3XdzuLCoiYFrgVXE8RAQJZrQkvW3CPjTT?=
 =?us-ascii?Q?4oJPlgN0DjibY+nWBn1rx7Hz+ajdBa6+qvQQeqHLu7EYbSw3h3bb2TZ+hE9U?=
 =?us-ascii?Q?z3aGv1IOevonQLlANmhnobP4kVLv0t4vuJLS6Vo/yLRgsvpZPIFFXg6FcFKa?=
 =?us-ascii?Q?q5ppC/0HFcPaBSOcxRe6yAbvj1WBkCc/FFfIY90tlqquzKYl15Vvl1Az3mT9?=
 =?us-ascii?Q?Pk6MKqFB9bSzK5gKifE4CIpIbA3f8ItLGtOWpV/4w6Vev5HbsjMF5vmnUe6g?=
 =?us-ascii?Q?70l4IGOuiWOhjRd+py7myyo2RdbHcT9So+rAp4FE/VSj7MQV59eSN+zFv5t5?=
 =?us-ascii?Q?0DGM3D5VwJfsuftKSe3tbaE/deGo4BKzscwEYMeILvDzniNABbcNIjVjLvSK?=
 =?us-ascii?Q?WlvXQjoQGOMt1GzHNv5fhe2QreWXsStD9kLLwqrHfMeOvGYXQC5iz4HKsHp4?=
 =?us-ascii?Q?1ExKie/37CKxYF2zn1lExddEUybVgGycK2Cl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CMmoGxhNnHTBUVuohzi38R1WqD58QnY+USeG3H6YzeZX49mzRhkVnrneKSO0?=
 =?us-ascii?Q?hC5LBxKZx1fnZ4m4W45rhwTn8pCWyRWoVjJZdsOqfrYfWAntO/Dj87aemQHm?=
 =?us-ascii?Q?YXCq5n6E9TJo44OWV1KGAwOhQ6SAKhTqKPQjdWzFBnDjpdlaRdrQGAV2i3bi?=
 =?us-ascii?Q?9PR4wmTWSsvc4dhemMExmf675APf9579uxLeqKS2bYzFBSE/vwqsf1KV/rsB?=
 =?us-ascii?Q?BXo3Qcc6lhkrlxqJQi1bl3TLBe4EaOdynpSoP+oTofD8/BNP8hjYmv64lxww?=
 =?us-ascii?Q?HhA2X4LGQx4uT51cUo9ZS05BYGensrT4IZocevyZffmBI2Jz2CS06rCQ/3Yl?=
 =?us-ascii?Q?oNl+CbQ9c5RUoIB+eY7oRnthH6bWBMyw1BWmSgqdw/vyRyiOCdZVy6yu+3Rq?=
 =?us-ascii?Q?VisjNNPsmEuZIf9HaTHhvA6VrWyE5RZvFPdRQeVnQkEQKnp7x6I3LonXvZY1?=
 =?us-ascii?Q?GPJfvMH9vXvFY2s1oUPzHdoMLDU5bCM9ADgIFUVEkdpYksxBlbRAS3XfyDPr?=
 =?us-ascii?Q?seuPoVzX2gAwAmC+wCP9RpaKQLNKrVygl/7mLEvPj3e6h+Jg6SGkLfEb7y5h?=
 =?us-ascii?Q?hIELNzFWGepUcNAjdMnFv9VG0Reoc7f0yE5Cme7CPQNs2dljdx2+RtJCBQ/j?=
 =?us-ascii?Q?XQQzZIwFmQKToKPYqPapRY/SND5UNWkUCIQ7I5EZS2k22z1gBp0dQpg6u1pM?=
 =?us-ascii?Q?Y0ZGX7ufYsQa8qKwwFKZ8c35w+hSIltvZn7Dtrr0DobxevzPwdCy3K6mGOJ8?=
 =?us-ascii?Q?BxoqnAhHxZnQjx+v/PXJ1XreukNXGUA8F5GHXI/rE29jo0+DtMyprD75LcEt?=
 =?us-ascii?Q?AkVDQO4Q5onW7HQwtGE9vR2tuRU/DW58uUNSiNG8zphI4QjWnU2QsQLKgVsy?=
 =?us-ascii?Q?fVwmbUrRpqXtPTC5y8TupIEUM/xhr0qcFOH6VLVhq1TXaVZZNoicvovf5Wt+?=
 =?us-ascii?Q?UX7olvn9YX7qlemKMWHPrA9MCrgu/C+PPmzGyuurkKGjT3AbB6Pt5mRBKSUB?=
 =?us-ascii?Q?u/cG6Zxj9IGs1nbrRIpCLw1N+pACYbKz51+sYUO322bTzvRx6RbbLurP9k+A?=
 =?us-ascii?Q?9GSYM0ake1PD3CLdSuvXKUHNors/6mZ5w+Afus4/JCsyPkfsJezjQeiHj2+t?=
 =?us-ascii?Q?cHT4zXJXadmM8Cd9PaUJMfIc9Ou2GBd1Fz3cDEyexvuvCIx/IyqgI26O7q5D?=
 =?us-ascii?Q?447qnoXY3xHfGPoiWyZqmeSRL8uUMMHFnOWRgE+TJS88UNy4J4B+bikG569I?=
 =?us-ascii?Q?nmSIQxOK/z9UvbhcuuPZjOT+0KGGNaKt2+lJ6Thscmhw2HNjBa4pB7qP6gd4?=
 =?us-ascii?Q?HlPdwY1GIujIPXhgTcg+JZ1uAepubz8DUDDr7awfywXqi5Y/vnzWV2g2/PNy?=
 =?us-ascii?Q?wtRVqxvcdIhvu0vqUC7wmv81I1iiRHkT7v87mP6mlhCkdGL0fTKCKulmwZhv?=
 =?us-ascii?Q?VqG/cVm15ud6y75Tw4MJ+b3ZIZP3S82qKgHu2vWc8A04U1PvHSR0L6x/bIkm?=
 =?us-ascii?Q?CpvLmhQrSGi71JkUNmIpf3Ikz7hq3vawz7UAinKOJzjgELJS1ddQZI4/vfbx?=
 =?us-ascii?Q?02iOIFWrnkFRow3HEvh3nWD5bZV2JoNbiYVv7i95wm2tcDFetElqHl+RlG7P?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb64a93-65c4-48d8-7f2c-08de17bad2a1
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:47:10.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lbe3OqfI7DG7tkKkZKNdv5HlhXRURYPnKF0S6vr5c5d2r/3y/kGq4/u8wb6p5NDI6Biy4/rLHBE8dDvdqxHliA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024

Hello Maintainers,

	In the current implementation, when Connect request for eSco is received,
	Bluez Kernel is sending 'Accept Synchronous Connection Request comand'
	[legacy command], irrespective of whether controller supports 
	enhanced synchronous connection command or not.
	
	In this PR, When Connect request for eSco is received, if controller
	supports enhanced synchronous connection command then it will go for
	'Enhanced Accept Synchronous Connection Request command' or else it will
	go for legacy command['Accept Synchronous 	Connection Request command'].
	
Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  When Connect request for eSco is received, if enhanced synchronous
    connection command is supported it will go for     'Enhanced Accept
    Synchronous Connection Request command' else it will go for    
    legacy command['Accept Synchronous Connection Request comand']

 include/net/bluetooth/hci.h |  34 ++++++++++++
 net/bluetooth/sco.c         | 103 ++++++++++++++++++++++++++----------
 2 files changed, 109 insertions(+), 28 deletions(-)

-- 
2.34.1

