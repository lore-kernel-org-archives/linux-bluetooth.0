Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390C3164B5
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Feb 2026 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338050; cv=fail; b=T7+0TbFvcGK4qfD0rcR/1yl1bM0VGh3lWhSW1W8ZeW5CfCzDHVovnvblsYl1iKhRQYjV84W5IE8YjWQzGnlfYvvR6CIbBKIWPw6EpeQFfJCXvLL4s4zZjqlY5DJIeXRXaky+x61CnJL3tL9GRpru2ybmEg3lkEud2zYEiUUGHK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338050; c=relaxed/simple;
	bh=ECi29e2hsP4RXWUWP9+CADQFf/bAsXqup0AVPv8T++8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rh4VWw+oFys/SdNiqsCJwhUIgBKHgma41/ha55QG1dmYWegT4zhWbjXR4agugDB9DwiYDBzdjmeQcXammi+9VOKs5LMuRHxU8BmlzJeMwh/CUTbPC+fMf3vi+sg5AXgUPLeYpnF/p81V0XVPzu1PTwwmLADlxQ0pFn4kqkwCM2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SWldsNaO; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SWldsNaO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpZ8stZSlTfX5iMnJyd0PAWbyz3MtnnnBYjyLusey4eXjEFUGp4WY/RyzDFzbXByB4emVRWm14YMAVmUboRseiN0k0l8+oIwYHOeAC2+RjybRi1c1jjT3BLBPM97BeP4zSldGnDJ6pGrbIPVTRfqme08S+ixPTD5bWAblaL8TJD0miew9FRRkG20XvM34209XCRHDbuSpq5g9URObu/7H3VTBHUtT1c1QgPxni974mmFv+pBkUsnt/cwp2x7BbT9JcdbfpqaWEnjBd24TN912P6y1slIauGn4WK+kgWEy57cHmIiTha4C15kq6okEchP2685NheVaJvEDyu9LI2REg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujaXUf34TjiGiWQCKHnxMV6EZ344Mw3AJY6ImR9cvx4=;
 b=VFX0DtX80eyylinmdP8ZK0MIHL+fyRhkZu7Ju9gUr0Gp1/fZx7r1/i7eVDOHxGDGTXMg6Vz78zshBCBbBcCmQoA/Knxo14Egt+3VQ655xVNC/pjgNqpiWEreAUIlH9EFeb7gbflOu7SjZNr+EI/qfBHyjf3a4bLooibsXJJtVNVLM5wVcFguQbn1E3O22Kz8e0OYzVDgOlffwWuFM454t8hwNJAKLV0FqRnCYFwqTOBsM1g5QDsx3oSF73cExHI+fcTwNjOKMRtbcMH0hbP4yfpvq8yxBVDFkbmD6IV4kLYlxW0t1qIdbwd3gX0UmRDD5/G6M474wBv4cSiIAIoEJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujaXUf34TjiGiWQCKHnxMV6EZ344Mw3AJY6ImR9cvx4=;
 b=SWldsNaOStAoGb9TDVXEL5ObkuHIkmYnt6287dhs8V0f4zZ2ALYYHa83kVT/rHQ8WyhyZU9gCqahtGOEyzy0AptJRyj/T0W6Uv/XnXRkwMWyiErTCVJJzOng5Rsly2jEDv55kJUHFPJXVgDRIZyIV10N4ev3UPqGp2NWv3hCz4KySK7IrlCNpHGb29JKGSMXBMDxPdPIgD556yMPQhkUV4JIRS+qYLGic6+qyIj3+df3VPMdrgmJK1H1n88BoJ5gR6sV7c7fcqEXyK8VAYGW7vlxRsdTeckRQTyAqnsrmOBLFUVaiPnx5jY4VgmXsCA+cz/YpSfjcRV35uCNjeDcYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15) by DU2PR04MB8823.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 14:20:45 +0000
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8]) by GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 14:20:45 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	pav@iki.fi
Cc: vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 0/1] bass: Fix use-after-free when rescanning broadcast sources
Date: Tue, 17 Feb 2026 19:50:16 +0530
Message-ID: <20260217142017.1554-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12191:EE_|DU2PR04MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 8687b4cb-218b-466e-71c4-08de6e2fbd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c2q1CDvogGLfAK+d4IPNaz/uJzzSQVfya6S2MGHvirOvhAUVgP/sBg6qbkx8?=
 =?us-ascii?Q?VLGt8wlM61nxo0MhCX+XRkzvKEE7vjisUuyUAKcQBN3I8+RfWv6iaFE+Vtfm?=
 =?us-ascii?Q?CkvEc5wwdNWbf8yMU5cULB8ntGapfAXq+5JqnaEIzh3YacGNTrqeUohcqI2I?=
 =?us-ascii?Q?wdqL1Y8mnjtEjP7vP9nC/mnIrR7gHmsahuEnNRHMfnwIaqtVCiL2OAcldoLw?=
 =?us-ascii?Q?irn6zE8N2lIU+mTIVcwuVKnr2vPJsgjpuxx7upAuAYDT36tE+wqy72mvNt5A?=
 =?us-ascii?Q?BbouYI6Qj1eGz8hORj3q2I4N9T0aLNbf20Rdwsz80wwLWip7kgqejbsuNeDo?=
 =?us-ascii?Q?+BFgf3MuxowADhAuChfeMTR2O0ISJu7IjsZ/4K7JvjlsPB9y7bq0OyRcGK7v?=
 =?us-ascii?Q?Sjrv0kFtOVdh1WuGK2RJZnj7/klDkEcHs3q7gv19QQ5mMj6USTcQ1mzla+wH?=
 =?us-ascii?Q?PjREAEN9Kl6Bda4Qb5PfYsWPBoR6lthmf1dhnAIm5c2LP+Ark7qDIoRssPhG?=
 =?us-ascii?Q?1PEclqUTT+gwieBSD5n6/hxzR1zgjjqeDWe14ovKqEYYnJwT9pnXdxT0iOsb?=
 =?us-ascii?Q?dbgQ2ouXxBmFxhI7f7kUH2kK5cY8uNMLT9o2uYsC0n8lpiR7vPAuV3pcvgEt?=
 =?us-ascii?Q?q3LPnmP5KKNNs5k2QQYgqNyaLwXi5KclR+VX/KKh7m3gLzaU1Fh93YfL58vc?=
 =?us-ascii?Q?sWBcokUBE2sgXqtyHXv9BUpICUiM0/4yfTuGvbp/qQ34kLCkjXLp1RDyU8OH?=
 =?us-ascii?Q?8ol4Ml8ZPa1aZe3mS8mV0n2HPnw2whCuUIlf0ABqNiamsx3IG39UJIfe6e+M?=
 =?us-ascii?Q?mGgsRG0A2x9gH3d9shiMs9Db0y5lpqW/5vZDwuaAFd4gTdsrhT8BwRezWnR6?=
 =?us-ascii?Q?pDTFWxQ+g2kIedDD8+/5J9H3pkWp9mbjahxMhNo53ZktFwGb4PDGW3Pzu/it?=
 =?us-ascii?Q?53eatJasdrYtIYHN/Ki3XTqMbZBoEgA3uYsFfIw2s0loLh1oBD12MWbFtpAD?=
 =?us-ascii?Q?DsVTakQCIQThLcmNyozFFS+iJlsOv2Z+8LuHu3AYMQWg7dzmYK0hIc9q3Xou?=
 =?us-ascii?Q?Oetdl+GlkBGxqK2jC66T2Iy7wmk3/7+YUcJnAmuwJZ+WrHOSsxFsSgKb9IKS?=
 =?us-ascii?Q?j7PZj6RP+tkKqemv0PXHk5JtqnlS5wzS/PWWHKw+HnIS1vQMZbpsstrpPhK6?=
 =?us-ascii?Q?hsTamOGEN7cVaXWvw/sPUslLYJZEQ/Tl7IXBL7uCv8gnyX6pKieuVlH/JPjZ?=
 =?us-ascii?Q?nKFg0wqqLK2U87hntYTfEI73VnYukJoS8HSw41ImbIUtUIFA5q9LZEaMkcNm?=
 =?us-ascii?Q?b+LIYN3mvF7r8wWVklRGxV0x8nXIT0mBjQIOdXhcfM8uvZcn+y/zllEa0eWB?=
 =?us-ascii?Q?CmJ6fKImt+q9vAc6AwXhjvaiQX9ihfGDrHpybqWKzQ/Iy/BGCJVFRYA53iCi?=
 =?us-ascii?Q?7rc3qnVmRFVuTqPZCnBPdgMBe5BIM3e6lqYO71qpuj8oynI3cfHFm3aQCV++?=
 =?us-ascii?Q?gTVOfFT4PDJS3sAQHrCEwuLOMg12QoA10aaKgnO0Vb0q0gzLpvcKOI3YnNiD?=
 =?us-ascii?Q?3oB0yHPnwaIN33L9PUbv7Ny2RC0H2OYyecVjLaNkXMn2UYvBlYz4SrSfSYPR?=
 =?us-ascii?Q?xcsaYy+EF6iu9Za4sBGkQa4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12191.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FLPqAmOV5jGrn/JI2somXqN2sicCk9OMrEtJ271L0f2vUmyCQSUkPqtPSxrL?=
 =?us-ascii?Q?HRV9LFofJFGeENJxCvdPRtiSvn5PkMx2uoR4VyyePFax27iQsBpFnoMoK9Zg?=
 =?us-ascii?Q?MzOVTnBXWglGR2YsSzClcAb75bCawI2/B+2T6lXorFstNIABCn+5KDb9CExt?=
 =?us-ascii?Q?wr/ozyFBn5EXuMns5wgdBKtlJK3xP7OV4wMBp0lCL/74VxiCNJisj8z0P0+D?=
 =?us-ascii?Q?Z7if5CUE660VfOlHLumIdojLwBC02x6tThzKX/HJ9NyImI5b6g/G2ucHKez4?=
 =?us-ascii?Q?G9csH//m9j+yYX7bHIlpnNxMoeSyVaUK18KeRNnjTIKoRhVk/fIr2qSHA/3f?=
 =?us-ascii?Q?kEirD2Eg9DqyaLv+3uIQ9SsEi5JqKmJDPumI7NO6OxTIj8Wtv/FcocqDlHgc?=
 =?us-ascii?Q?HlyFWhwoWDMOKpiU5PkiREDcGevZ6fRy3VjhkRz90Ie0KMcvz4vcRSjP5Um9?=
 =?us-ascii?Q?7nqubGSHriDAbxaAFkJR8C8lYWd3SBzd7+P6XqE/ecp584g3AdHOPq7r9xu9?=
 =?us-ascii?Q?1N8TS1UEt5CLZV5KTA6u6G0cZbCJg/d6ycgbWlNvkv0nsDgZD67XSvtV3l2y?=
 =?us-ascii?Q?VWZbTha99wLugjmQz/2nnM3H2cZWUT9K4kimak25CFOtDNXDG7Y3HcyrQzn0?=
 =?us-ascii?Q?jI3wKLi3aeP53vGdaXUu1MQNTJI7M4ItxBoGPh0OsP2mDBb+ILu8IfexP/KJ?=
 =?us-ascii?Q?tUlqrSOofypyVk7QH0XWm9vX1S5H9fn8Vhli2N/BDwdD5mX31JXvraxteQXP?=
 =?us-ascii?Q?WElRQ5PcXCt6SLl95kdY9uSIeLyW1cAfdZ21N/QccfmLFKlE3frA2PetxJXD?=
 =?us-ascii?Q?iBvT5oMPxruQzNK2m9C9lVodYM4CR+Fh3U4kgvrMMS39CKLcp9wd4SVZQXVt?=
 =?us-ascii?Q?N0jnvaYigs1mmmavOWd+6sJzHKm6JnG3E8cD6CDVbv8ku38Xs5TwE6q0Xg/x?=
 =?us-ascii?Q?5Cf8CHEy594TJHTB5tkH4oxyc3h0u6/F8gnX+L+5Z/+YlhcjtH33vMDwBuU8?=
 =?us-ascii?Q?1nDCJqCK2qk60o8HGcgbsrmBUwX4rzSn2FVLjsASNCbTNPCStJiR9nL2yTvc?=
 =?us-ascii?Q?haYlRzexdhwbZypraC33IlFPsgK8b90QArmi0HDtzo1Ywzd/4LjQQu8ZA6Ww?=
 =?us-ascii?Q?cJS05nSmBedD0xWl4O7W1LFjFZkV9CXqeEOSWsiqzp1RCKO5RbBxUwYp6LaG?=
 =?us-ascii?Q?S71mUi5k2IiwlJrgjctJAwTx3nKkKYcFzk3oOHLezCeQxtCIPnqsZ3TPVI8p?=
 =?us-ascii?Q?W4d0RH5+aA4PZc/6DS3h74aFyDisplta1g2txPci7hsRYeAMNLInOdzFOUdQ?=
 =?us-ascii?Q?ajeCCyZRH+bW0uzBR8BnvrIMPS+K3k6jjdOO5wHg5P6Aj3Rot7ib8tv82rts?=
 =?us-ascii?Q?euw3oMDJMKgzntTukYdNzbI6AEDJ+ppsv/Nz0IUnwAfwNgHha/eq+QjwjwA+?=
 =?us-ascii?Q?9OLkLkthp7SYnWf+lE4K14xcYWK1ian4dLAXzpqHIgTRkPLWj6XAXkwKGtti?=
 =?us-ascii?Q?GeIGAL5vE9s6mpNhgACu8bNK3MTmfcABhvUe2we/NwjtAz/XCXrJhiG6cyYK?=
 =?us-ascii?Q?6Q6iJOE/C6TP9C6XeZBrotPp1r21Mf6LuKkxCEijz3O6dVDiCzYK9pTDqQsU?=
 =?us-ascii?Q?8t6rvXzE+OnTFYp3dOhYwayrMSFghqqRbepUonxxIHMgriqm3MRaIMSV7XKr?=
 =?us-ascii?Q?R53tkrXqH/ewNQ23S8gR2G9sbsFvD7jbppwrzOjYrIvCECrF/7aa12JIU0/1?=
 =?us-ascii?Q?EuOXdV6s/EC0+rbUglOiELGRBdw1eeM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8687b4cb-218b-466e-71c4-08de6e2fbd78
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12191.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 14:20:45.8247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xrdt7jZBV1m7o0tQJG5f43hgLx7ftZTVzDN8mVjcrty3Yx4cvtOIqUujvIWHhtsX1N4KJgJCTJxT4ORDQnyAVJX2Zko26xLMJeCUGwaLceU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823

Hi,

This patch fixes a use-after-free crash in the BASS plugin that occurs
when rescanning for LE Audio broadcast sources.

The issue was reported in GitHub issue #1907.

Problem:
--------
When a broadcast source is discovered, bap_attached() creates bass_data
session but does not set data->bap. As a result, bap_detached() cannot
find the session using match_bap() leaving a stale bass_data entry in
the sessions queue after the temporary device is removed.

During a subsequent scan, bis_probe() iterates over the stale session
and dereferences a freed device pointer, triggering a use-after-free
crash.

Fix:
----
1. Initialize data->bap in bap_attached() to allow correct session
   lookup and removal in bap_detached().
2. Unregister the BIS callback in bap_bc_detached() before tearing
   down the session, ensuring no callbacks reference freed memory.

Testing:
--------
- Repeated scan-> stop -> rescan sequences without crashes.
- Repeated scan-> stop -> power off -> power on -> scan


Sarveshwar Bajaj (1):
  bass: Fix use-after-free when rescanning broadcast sources

 profiles/audio/bass.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.51.0

