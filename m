Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011024.outbound.protection.outlook.com [52.101.70.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A313D53C
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557829; cv=fail; b=gXdc6mUJN47CAg5W1BVEEjGtACLzYGpASjCZLdTNyWf/rn7H7YbjpahHDd5lX4vRiY2j46dlr+uNHMxOEe4NIiO9hd0a6a4XhIX6+1qrYzMFfJeOiIs0yFeljJZUmLUjsejzN/ZyijRK2Pk5HDftIJXWw7WElgG6U8kYifGexzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557829; c=relaxed/simple;
	bh=TYxhAwach0hUzUUs9/r4aVY6phufXLrKnGqM59Dt8ew=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=STKtxwb4eqzII48q4sTMRv+huA01Xi322okOYWug2Vm9Zq2n+AU0V2vKqmhVM0A2zJlMzwlOoKneyxSJHDzK0A5U1tJN2PeMroKfc/+cKE+92G8M+p03sdzpDwqdsajp55zdDjYLwFHLJTioc0WS+b6uNbJfyuntdaIrFEGL7QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ia6PYOU8; arc=fail smtp.client-ip=52.101.70.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ia6PYOU8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5zG0v8g1rbbIM6XTZEn3gx4Vde9juvF6Tt/j+ahxsqFN8tRquqhtg7KlvH5MkaKeMgbmGMaS4TED32LDA02a4hfmCdnQQdxEro2MKA24A4K8Uf1o/jUNzKgAMtHzLspq0EH961A/WLqfNfD74gFgsVDaupVZc17uLKvFw8TRaz9n1nb5id6EHiWKCCJGB8clzj8pSGSwi/LSolAW093ynXisbwP5HW16G+ual6dgBjea1gEi4usntQ6peqG2j3n+eWf4lgIZryQAB2nkV2+kpMd8av2TKzxXzmTRGtf7KAMbv6BDBBdWnWwqBToMbS+dwdkNqahVOcDA+aHXjvwMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiRvxrlkfdF4OYkAQi45nwfo6DcPVkFh0xZMpFK/nbk=;
 b=cnQU0T4DznnR28YjFX6/qbEad0qtt6b9219DsNtNuf7Y5Mnp0ZGK+S/7hXp1bY4buoZ50bSh4CRVd9dHW/iFV9Ao+pYV8mpF3EIFU0LSLS7scI9zaFgytjXUnIbCPRYoWvhDT/HsdsRJmPbthFYYgctVJI+yL6WzCIBNieCDQX8qtVjIlAkH7iV11uQBI5p+7S6H49rLfErVfZW7QHh7jrJVQg2Xk8soR/F/FRXvFdvUkqX2LTH/g15ok0bkk0julgRGrebWasldi/DDrzlMez5ENWyTvo/13iXKyRJKIZLXXIrujzHRDsYJEnkWhnldfGT3w7zqKIfpH2fk/GspiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiRvxrlkfdF4OYkAQi45nwfo6DcPVkFh0xZMpFK/nbk=;
 b=Ia6PYOU8UD0QHFGHjvdoN3KbAa0Ra4bLF7gh2SmrUseohEYnMc0tyS6E8HosDFyCoGTxlI8HvoUcCArAb0euDg8I03QYQzt8pokGKNj8Aly7eZBIjngf0QsqZHPov2PunqxLizF6cFWmHYCzT+rS/VGYzlmtlzIkdKEdbZZpb4mSCrLUv8polb//+3WTg9JIeXbTowm5/yij2PjFpdr9afRj2GNNcXShyFXsFM9zrelHIxiE2qBhD2MGF4LU8s5NupBo9Z/NCe/xaGVSoIG+ClzPk68vnLBIhktsd0R6ICeirK4gwUz8l+EJ3uhO+4HKqQWkZfbXqf2H+5ssqqYfaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9)
 by AMDPR04MB11651.eurprd04.prod.outlook.com (2603:10a6:20b:71c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 06:30:25 +0000
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e]) by AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e%6]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 06:30:25 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com,
	vinit.mehta@nxp.com
Subject: [PATCH BlueZ v1 0/1] Support for Enhanced Accept Sync Connection Request command in BlueZ emulator
Date: Wed, 24 Dec 2025 12:04:38 +0530
Message-Id: <20251224063439.2477969-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To AS1PR04MB9454.eurprd04.prod.outlook.com
 (2603:10a6:20b:4d9::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9454:EE_|AMDPR04MB11651:EE_
X-MS-Office365-Filtering-Correlation-Id: 426c7322-c047-4fc1-5428-08de42b5ebeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aXE40OSgKqwkbkIyfZ01QFoD2mc0wHQuTi42FJoqq0qhDUDnw/l1D8q0L0RU?=
 =?us-ascii?Q?CwHKNjqxj3xWnt7QXExxTbDngBGyY+2LwCBJ/slm471GBhpHHCGp87jj6DZv?=
 =?us-ascii?Q?bT6CwAwzrtwHNK7fjckAgQO48HwK2YHXzeRvyG6jup1/ODAVmQkL9YyKf+HO?=
 =?us-ascii?Q?6d0miPmqlEgFM9RTE7FzJpE8H7+gYfB3OGL7oQ2n4YMXDEeFXtt/0kiTJu4K?=
 =?us-ascii?Q?D9Z44QDvOw65eVo0t+mvjHBGenOSWvzGl+EwLl07NPP9plC0jpYlNmQoiMwp?=
 =?us-ascii?Q?aRJ2gQd/ryyvtn48sS2nicVSnc/zh5/3uMZy0w/RUltW7UdJDYKusFcRGmHs?=
 =?us-ascii?Q?SshOEDdJp9GX5ERkHCbMMo/SGSdX9wbx7SEmxfywgARfeQj6VaXTa/4mDI/J?=
 =?us-ascii?Q?gAhJHeGPOzKj7al8HehnLvLkK07AxUTahiULrj0ndtjRj6gnunV2CDIr3gRb?=
 =?us-ascii?Q?6YPtM5kt+dfI5A4j1k37CJDSm5FXFknNeBHtgRhPauXOgipL1UwM58hADy9H?=
 =?us-ascii?Q?tIIeejeajEerfn6iUem6DXWj31feKlpKQhnUkCssRv4h+WA5QCgp9PeK+tqY?=
 =?us-ascii?Q?47nlUVP5NYVuwIhGC9Rs9Py4fnznCqNtiPbosBq0n5PTTxVrKUJfypnhy8Mx?=
 =?us-ascii?Q?g+KX+mVI9EK2VgT37InhiowgAQQ8zqFBGXnwqvHiUshJjtKxXoYedkPlK0EJ?=
 =?us-ascii?Q?qojWlZkc5gWEQNyTAqqIyDgnccnVcqZkWFpyym6ldLz/oQvt1FJ3Zyf34u36?=
 =?us-ascii?Q?Q5I/eqJlcoFKq6onDH86kJ7dnOjEeY4wFK3gGW6eSUH76XeQqRIV5gproR7y?=
 =?us-ascii?Q?U58bmZSIMIyhYUaW5mzxkftT0HLhcrE0BcSxZ1+WTpCpoZrwYYutk/4KZXAw?=
 =?us-ascii?Q?3KY932eqEUaO//KWYMOtfcC3BZLdglT+1eJAHjA1um95ZtTh/wwFJhQAi4kq?=
 =?us-ascii?Q?uucgnpRitC3UffBrqOBAxoCKpyPAdVXVmHLnoCoe7P2FpanldhPEau12ihju?=
 =?us-ascii?Q?SqDqa/mvWcy5ssId6IWihyvHxjcrU4W2zy2DN1T582OYOZkNghe9TmKJU6Oy?=
 =?us-ascii?Q?1rJvp7kimP2X5tfrRnd824IDk75zta8GDzVkbnPS1Huime/c/+PQkf/pft8K?=
 =?us-ascii?Q?R7nJtMD91pWzOlDWPj46QLk8yH3az/PXdAM1rMCcJla3j7C8RIuW5Sa7tTgk?=
 =?us-ascii?Q?ILHqkP3gyJCsDlcqvT59w2SvV98bD1Tb1WdJCu/u/+jpqeZgLcFPRkcjvgGl?=
 =?us-ascii?Q?dWntKvcS3vgAJj3j6MpAlHsc5dIw4tdiWv2t3ZN3IAS+CZlpCPFg8+YVMmxc?=
 =?us-ascii?Q?LYT72ihbcYbBMMMN4+iSVWi/o5SsYKPzNsDK6Q+mwk2E6Edcz6p2nVLHKH0/?=
 =?us-ascii?Q?kALfyqTaC7Z99EQtHwedDFpvMAcMCcQHcN/U7C/QWHJ+RuupdH+DmwtIs2/5?=
 =?us-ascii?Q?tWhHNQ+9InTpLTnq21c/QZ4Mo+0fZmldtnQmIqOw9fCQ7nYNiF52cB7J9hi2?=
 =?us-ascii?Q?QsjMmbDEMSaSix2kIoc0mBGVO2m6VyaM0Oem?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9454.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8qUHdLdizvjXWsMK/BFk0iewuw6Jiwxq01Z5hMJAkn+zUyJ/PXihmkWYu+So?=
 =?us-ascii?Q?vUtFK6Xs/Wju/dpdZZQWlWeeshcgGIRS04MUnUyzuw7mqVp602iIn/9qj+QE?=
 =?us-ascii?Q?1NBAKygm7IwnMgqIwjbPdZb0eGSeaz9urMOglTIopB9QOovpehFSAX1Fd5rn?=
 =?us-ascii?Q?JV4H66igXmb/8jZOSK+KEq69TH3JaE2HESYm4L6ja/fEciBpPQ8vUssTsB+b?=
 =?us-ascii?Q?P7qaBri9LbNvQTdGtxiVeJwekp0W3n2hm9QmcmNuIbeTc/LD9hHkJ0V+SSzs?=
 =?us-ascii?Q?7WkcSyFxWph6RLG+YuU9q+Po2ogeJ2fgY061UdjwdwVIIT+zVXIgNBnIMKvw?=
 =?us-ascii?Q?GkjOt6ph8IjnRaP2TGZjJ2lSBe4qQJ5Xv5T/0KBD+TnwFIgjJtFftK+281xU?=
 =?us-ascii?Q?UxVAYODlSDefzHc/r4+NQ/zokFQ8vWBkouT0COXg+CALFOSme+t4KB+Zj9Qw?=
 =?us-ascii?Q?Yp8yEz559VLwhUaoQhFext64rnRQMEYHxV8M8Jv/FxsCtf27gaP8VZ7z3pi+?=
 =?us-ascii?Q?/v9kd9qZilOcfwYWgkt/A6557ek9bjN2kbZ5jGkRezjEX/6nrP3RJ/Y/jgDK?=
 =?us-ascii?Q?7/kKBLTiOSaRU2zOE5gUNgy1kELc5Vlvj06sajTpbp92SGLYa5HagsC9U9nh?=
 =?us-ascii?Q?sde2GmJ/21jeuIbNLVmWWlqJAnDTXr6B76BCk6WbjSk5E33QXIcDtK3vgBJz?=
 =?us-ascii?Q?vLHUXHk5d8mMupXefr86pEDIR/ef1ahbLRjIbbTgL3lc1X17mW7ouyvwB7xF?=
 =?us-ascii?Q?aTq45W9LTV/Y6gxixnpIWQRYIFX2+dfCRmBh7/61U18y/WTuQlOSlpKLbpwh?=
 =?us-ascii?Q?u2fVnXu6B3xsw9VVr3Gk08F4yfG+JQiiwJsGDVkRQNP6YHHSEmgbBbu8NByv?=
 =?us-ascii?Q?C/mLya9ZZ1ssJpcx2LJ/mL4UjZ1rue1S49xXDCxV38R1cmPuBog+3YpKRpGg?=
 =?us-ascii?Q?LwSyPctw13HovNiPMDAqsc377Q1ARGbwmWv8qG3WXJZAkCpFbkJO0rSf48ed?=
 =?us-ascii?Q?ycMLcvxsaIHVQjAV/vg6dEGyJV7jozQEnBK6yideCtx3QGF2bZ6kLZ/d22jt?=
 =?us-ascii?Q?tvSDsQEVIiBiBuADVRoOM+5PPemXXljMLjhOXzAspT8lCD4LtoUkHG9RFsPn?=
 =?us-ascii?Q?HS9ceN0v9iYwaTmk2ud643xpsM5UC9c5Z/bivIsKefgNEdn5o7/dXabGbFsC?=
 =?us-ascii?Q?ob5CRVXiY7Gn317jjkACHI/xWzSRhK1fjG1SH09dhdZU/SVQcalgAAoMuD6H?=
 =?us-ascii?Q?KlvDdeQaZ1er02on8vUmS+/X21G0fOQLO5bciKgtJBozTQYbbyKUw/SOVY2W?=
 =?us-ascii?Q?RaEt3ihT9lhrpT6tIvcc7AjosIZl8inQTGcySq3XcCAiuvZBvuAl5si7Hjqv?=
 =?us-ascii?Q?S4j3pYcpojcD+P8cFQb0It3a6NqXR6aETQ3PAS1Xk49L0KS2/4EAItYBKQLF?=
 =?us-ascii?Q?Acr9UyIjul66A9k+k5wE086BT1uiIc9ON0PER5TUJ90jBUJyGnizwPPlmscN?=
 =?us-ascii?Q?7LuUETOsVDvA7/e6JQ02ws72aJReDcB7TH7tOf0FaZnlOc5GXDeAzKggNoxk?=
 =?us-ascii?Q?xChjiKn+haIg3Pzt5cyBJgC8XhBtNmdV8//qBuBFAS1qxajTTeIMrz7lJxv4?=
 =?us-ascii?Q?KhC6KymDojnI681PuUbohClCokQATBusZchVIoRoQMndCIAXUHM6GG9RtCx1?=
 =?us-ascii?Q?zCfUHxmmwckilMmWjqOdxfACTU1CPWs0tRKL6asAAMmEQKBEecLPn8VONh73?=
 =?us-ascii?Q?48aT8ioZig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426c7322-c047-4fc1-5428-08de42b5ebeb
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9454.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 06:30:25.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGYA9t7uz/1xvtr9vgvvag5/t8MKUp+kQxZrXn6yz7jiZAWq3dylcC6KAL8ulWpJOmvtvwVGcIlCiXqjjWTVzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11651

Hello Maintainers,

In this PR, we have introduced support for Enhanced Accept Synchronous
Connection Request command into BlueZ emulator.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  Enhanced Accept Synchronous Connection Request command is handled in
    emulator.

 emulator/btdev.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

-- 
2.34.1

