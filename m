Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190E51FF7D2
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 14:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122816; cv=fail; b=sbk4+CzzjAOYuzHs3ZwdcmDDaASqacKmoWMbuAVrkypkQEWmz70MPqFRxb+NMHu6ACoJHLlYfsnVj2CZP5iNgUXUcpRvnuohRLJrycexMfJW8lPFOxaSw/L2z2sbjfdHrYUbKrWKk05usTlXqQ03fgiCrv1pOoamPo18v4JSLv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122816; c=relaxed/simple;
	bh=rT85Rj3wxYs03Gul5CAP3tLHGR9r9R3J8gQN5qpvVPA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pTd34iJIr+y9gS0LfbyiOB0lcgSHIDwnELM3kn8rl/MrrGml3Jal1PtZPcNRqwJQhDKOCfzf5ye2gyEES9kACY/as1qPwaxvH0iVm1BWzA3Cxby11DdWP5Fil8cqnl2WhXrjICtr9NVgz/8AHYJDP+93gSfp7qSWMwE6RgDD9tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Aw1iq7yY; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Aw1iq7yY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddMRTzOY7X/S1R3HCMkhw8/AvDwwkgN+VVsCY8PED3pJ2dXMhuiE8eG9QUVPG4auW58OtKpUhOtylYRuIdaRXinkCpF7WmgIOgok/vxBPkouVERgQQP04s7GYvJYnvs1H24jdHtXuJWCdbMdwyZ6Nw17VRKSFS5bsoC+020EKH+l+UsKBLDl/LsHpvfVNajsuj8lpBEdhq+juw8kbIQr9Qc8C9wzU65486k1XQVj/iPC6x/ZmKyxhKwVGazMkUO6w4lQkCZeVW5vgAjq5SRw6YMJJKbIbjFUsV1QulUDE6sxJGYnZZnZ/yKCIOAgFxEjmlPOGr/Wo+3g5fcbbRXxmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWUg+MUiYJlBWhvSAVIhqH921hGQ5DmC0LS5tgrH2PA=;
 b=wWEyEbOnYEgFhI9DAjH+WdM7lHnKPfPS4xfmrVbCzhITWYFy5hOEICIbIdVrye4799VmOpN5y7EIsPYZcaVFyHm4BtNv1WviaiJGe2q7oyilRFWz7e/DaXQwye1YNWrzQl0nxqoo8hENWUd/SzWe46CYGIeDgInJKJmnAh8/lYN8MaXzfzlDKIs3l8FZtX/uT/TbQSfFtC/yeHizrhoOrLEqoIdn32+4RzAAc/xssfusI5ivPqkbAc53EP3THfgr4/KkYsgSXNuWeJRPfBrTMuWw/N7v9S0SaFVOTsjQFR4NhRyuHtjEaZOnNY7OwDieyu3jfxHWT0EMLgEJun+rZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWUg+MUiYJlBWhvSAVIhqH921hGQ5DmC0LS5tgrH2PA=;
 b=Aw1iq7yYX5/ffnsPwfdDkWZOd7C59FeW6sbGQLoffE8+OOX5W781JrGz9VsraYcxetpqz/sd6wUaXIqGWIexW9Q9RIANffbOFSwk+xsU0gO6+paRNrNprTguxZfB2iX0/V5Z9hYDxBBpYxkKZcBBe8uLsrkn0cBbrl8JcvbZKB3qd45y3kzgJE+OLJVhP7uBHMbC/TYSq8+M+BTTUMmfQVvM9u9In29ImN0VNCTQZ7qX8ElaWNf/8+utC6j7X5plOx9gt3fzjpbF1fT+qKFisZlciLv4TLG1brKc3jsTasGfh3utgldIxRMKrXBt67kvpYdxBkRffn0eH11ETRvLdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by PA3PR04MB11156.eurprd04.prod.outlook.com (2603:10a6:102:4b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 14:06:51 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30%6]) with mapi id 15.20.8335.017; Fri, 17 Jan 2025
 14:06:51 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] shared/bap: Fix BASE parsing
Date: Fri, 17 Jan 2025 16:06:30 +0200
Message-ID: <20250117140632.120501-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0034.eurprd03.prod.outlook.com
 (2603:10a6:205:2::47) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|PA3PR04MB11156:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd25bd5-8ea5-4861-e543-08dd370030c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MTr02Hx6yUu7uzgMf6oQp1cgutXi2VmMjyuj5FTOdGn2cM3q0NRWG+q9tP9U?=
 =?us-ascii?Q?zoY0eA5B/vO+pNcXOsMCzrnQSC0WETzocdbyaw1PB4Jzn/5rSJRWK6hoX/RZ?=
 =?us-ascii?Q?xEGZ32KeKk17SkWJWtumrCkgl2dqsHzFQAi4is+xnwwVrOJKC0jzRy4Go1Il?=
 =?us-ascii?Q?gGDxkIajnpMUInGGEZNOPJNqANp1xtoP33vi8t2e82kAogQJdzoGR/IV8Dyc?=
 =?us-ascii?Q?4QoAEb1iyk4TnSLkM013T57Bi/nyejKJuTnG9icrv+SyUpENp4XjZMrIX5io?=
 =?us-ascii?Q?1fJfR8G1+jdXgWMLv21TUODSOE7Yn/K0dZKJ+9IWI5eIKRRE37v9btGBQ/uG?=
 =?us-ascii?Q?lFD6+/AzGew3yJqX/XHfBF0DiBDH+juMK6QNnCStJCFQDlvdxPx6sJw5Bp65?=
 =?us-ascii?Q?+d6KJA8HOK1IoZ8+aHoLlSHJwDZO/QIMKQ6uIeLY70tzvEgdJHyXVgdhitA6?=
 =?us-ascii?Q?0POjeGO1U+O5tvdU8ZTkwzEDMBwIk5mXuOrUI7pVazzFxXbiGbQ3RFW8suRg?=
 =?us-ascii?Q?aOjDU10wFqtjkCk8mRoUOWRhEa7S0DKvTYuewBTO1zWJQgYt70yygRnnh6D4?=
 =?us-ascii?Q?0xWHOX9e4poTDwPSHfenyExDkpQw6kdU8TNFLEBs41XLYzxJ5hCrtEZZEs2W?=
 =?us-ascii?Q?BcJSRGw5CjDz1vVIzpArd6JNZri1xL9jZ+YEvTNof1i4lEuy1Jv1oWIG4/1C?=
 =?us-ascii?Q?HVCgc9dIVwGawl1jke4RseprbP6DdR96lCA4WmrOoQKakfHa0taet/aag7rO?=
 =?us-ascii?Q?E6CbIE9A72yhLmxgRuBke4c6iWvGEb9C9YuwwiEZ3hGxcFlJksGlAvAg6jq+?=
 =?us-ascii?Q?bhtmd+z5xvJjAtmyWZfms8YBvOLM0tJpIMHd7RdZsc+qALRpXu+F81QbnBnD?=
 =?us-ascii?Q?HOZPnS5ORDCHHVM9YL6Uo3yM2tnCqNhuMuoYvL5goxnaKf+F39GakZBlKY5r?=
 =?us-ascii?Q?CIwbkTmmipxKegkElpdlvzLcrPXRM0ew333abkMw+vVafUdkXcu29cpu96oL?=
 =?us-ascii?Q?ANYR7E8HKOEZj+/ngFtTVP7sOrrMQkDkG/uHBu3fpzgzCPiKFyPkvVlD64ij?=
 =?us-ascii?Q?WmyuIZr7SasUyrD35TzLBFVkA0Kz8bgXldvYhf7/ozITVbst5rnDjKFn1TbC?=
 =?us-ascii?Q?rycOkskRjCD6hA5yEZtpOukNlVMOOfo/OFW7kqva8rSXmtePv43Oxm1iZq0A?=
 =?us-ascii?Q?1JIHXttStUEGfSVQjdTeQzNRDq/5II6715OcPNCJw49LwZgOrCuHUjVyarZt?=
 =?us-ascii?Q?J0qPq8qfffypw9Yr5oRTxj6i2Cusz/V3ho/S88sZsQXaizHJOfgMYEh0Mmbk?=
 =?us-ascii?Q?mIjJtwGXgm3QBxrrFpgLs4sZewaFYjscWjDoINlDlTCrGDcgNBcfV+tHn9T0?=
 =?us-ascii?Q?oWLg3dL+x1Yx2Og4ydxifV5LIokA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EYtzu304Bb9Pc5dVh7SoxbcwH3pIEG7gPDANaJZsdOLL8oE/bBE1/CzAA6Ji?=
 =?us-ascii?Q?pZFl4tUbqYlkoJAOUFWgZfpwYpH9ev7CFejCSANzxsHhBS2c2cuL2VSiTtqe?=
 =?us-ascii?Q?yWeqmS6FBoK1RamfMMi2m0q38RWTDwzxZphTBP8fQeUnC+FTHfd0P6DBxCA8?=
 =?us-ascii?Q?URClhSQoJ4g9IzNttsI9y9rYYuSBi0/tBAa8a74U49jyxGuMP1Imr0MDEyw9?=
 =?us-ascii?Q?rQMVMGv6bs1WP0+y/CkTxSlJ02o0O7+jOtTALr/V8jKdEiybUDmxjv26ImGb?=
 =?us-ascii?Q?VC9LlhcOUy563ZbZhhQnzrdDp0NwUZX5psAWRuTfnORXyftWejRaOEzAVtpT?=
 =?us-ascii?Q?bD1ZS8EDLN7aHwYw6tJo1Lt3B9cc2WoZ/XkmtVIoMz37SryjpNYusRoYTwMZ?=
 =?us-ascii?Q?wdpdRwDe/W+8uPAE1J7rWXsr8Yix2dluyvblD15PuX6brs7/4TvRsngjW/0r?=
 =?us-ascii?Q?QwNeQg0NKE7hSZxvmMeFscIbR22vMuk+pWKTIoS6oqA68cSf6cjZi0aC4ttd?=
 =?us-ascii?Q?Z3dIi8otk7ZSENSRhc7n0TnEj7lctOYCKsK88RHnfmpwFNbJ1jBq6kgU2wA2?=
 =?us-ascii?Q?uz1hi33l4LQZsQ+m4ACl0mt3xGwAbF9RabPdHSXP7rVRpaYVnqV88vJKqh15?=
 =?us-ascii?Q?JFV8xZfHbcWDccV/fZJq6Mdiu0x8PpBOreZN4v9VsBhhgjxxzWF7p1+4DqyX?=
 =?us-ascii?Q?rMcZcg0QzJsCzlubn2we+IrBJZTBlMaTfMt6KTNCXUJgthRBMQQn/ZdgnTpF?=
 =?us-ascii?Q?/iLtM2/dbUqNo1buvGxZgmmqv7WPo+y3zIBe+q081+UIKjzHX/BHemwwBPTT?=
 =?us-ascii?Q?uHuH9DXQt4Ysfjrav2kTdwhVjxXKXt7V9/1sVe9BorGH2BsOuYdqbBbv8BjV?=
 =?us-ascii?Q?IUekN2jFCma0O445DNlE2SA4P1GIa6gY7V9lSmWxbEkqZ0gsXAOoZv99NRkE?=
 =?us-ascii?Q?h1ic7ondxPTgapBLG26SMgfIzVqYlBsSRq9r25SlNPFyDHxPM8QafcphUd0J?=
 =?us-ascii?Q?BfBodz7EArL/h1wOZaDjOcQQFFaDiNgwPwhydDUTLduXfJRpCKFxmyqQS6+o?=
 =?us-ascii?Q?y8JuXkSGtK4rz6mFcBNn5tNG53/+MscAxJE0uJLXVcsQLLLDXAgj0GyOE3Q9?=
 =?us-ascii?Q?OTTDghgL+hNgz9Wtfe8q4Xb+xnuosryRIsD7E5b93Y5Pge39r3X87uwvtGt0?=
 =?us-ascii?Q?QPyJk/XuIZ1G0z3wKQDCaBB9UUD/6Ux0kLO7B5EjF2AJgOyXzjB3kLHN3K/E?=
 =?us-ascii?Q?2+Oqox1mEBtLlSjzkrF3Ij5s4eVTljv+0b1iRJfaG9KU0xbNO7hFq0Qf5zp7?=
 =?us-ascii?Q?QlI5g8BTepiag68EDimv9kLtQf++SlWy9vZjt6har5XlA6J/aYbDTZp8TAYQ?=
 =?us-ascii?Q?giZZVFuQbKn4IPtLPH1Cym3DMilQEbb2jJzvvu6xXdZ0zG6LAA1a7PyVRu7g?=
 =?us-ascii?Q?P9+/QSv+PWrgwWWjJpXGr/C07G/aSuD+JuIf4aOz4B/cFyjOOx2zw4BTkRT3?=
 =?us-ascii?Q?mGGl83Q0Ol+7ILv6rQJiHLOJ2+wDoHXecNITbVzRHP81HKccXFtu7bKcFkGK?=
 =?us-ascii?Q?c2lKjHA0/GWC8qnyWZsixO42HSrC0Pv51xaEKsNIxwGc8vjl6NJaYIpCd91s?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd25bd5-8ea5-4861-e543-08dd370030c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:06:51.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6t9yVeUwgWZgJ9kunlI9iFe0ysV3HYvnVX/rqVrSne29hhWYy6tCGBoY92LgtQTm9+4eGJv0aIVQjGSBPcZFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11156

This patch adds some fixes for the BASE parsing logic in BAP:

The first commit fixes the getsockopt call for BT_ISO_BASE, to
make sure that the correct BASE length is read from the kernel.

The second commit adds a missing case in the BASE parsing logic
for Broadcast Sinks: the BASE structure might contain level 3
(BIS specific) configuration LTV types that are not present at
level 2 (subgroup level). These values should also be appended
to the final BIS configuration.

Iulia Tanasescu (2):
  btio: Set correct length for getsockopt
  shared/bap: Append extra L3 LTVs to BIS config

 btio/btio.c      |  3 ++-
 src/shared/bap.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)


base-commit: 2ee08ffd4d469781dc627fa50b4a015d9ad68007
-- 
2.43.0

