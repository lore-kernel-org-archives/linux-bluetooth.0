Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845663233ED
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557675; cv=fail; b=kwuVWW4/nR3wtU7DIJx99nOQDDkypeZIz/t/1XXdI8rTfR5j07NTsEHdc00ZkwDeGsmm87YhsBIRgfUY4gmHH7TCW3CSIO62FmviaFmEMJ5t80lFXfXv1xPuiAD1zpErB7F76J30OqSGmd0GHcN/RNYCofPk2UPkpOs0D3zzEMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557675; c=relaxed/simple;
	bh=YxNLBvY1FjvnISPFKydiakV04a2Ew5AGjvvmoHm6t9c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8NMXoWBNCRF+sun0ta8JwNczx4LOkEQXQhCtOLJDLhgxTfCb3UOftXJA+8+Q4xuhz6p85TomrD5dUieQBiZUQqrOfgO1M+ClmFPUhxuWCqlgMQnCcaVjzbBlBnH3F/FMLnnE+u8UZ4iyTolcu4XQjA8kTRVZ6EC1qJtTgMR4Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SvTADqs8; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SvTADqs8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/oykpw8RBEd1YUSPK/5lnb5nipHDfpHT4TQEQnitrH5vlyketTWtXWT4EyKEKjBzyXsyQpC7lu0v8QcJ1lkaNx1AZIOZ28ck861gopc/NmEqbCHG3DXf+fCfPZ4NVOo5GGzxjbkVdmI7jfp0PZaUyr0FhP1oZEtwbN267DZIVwrp/BHbN6XuModz/Kn17WcGZ57wtH4KeaFeQLV2fqDQiJTit7AiKcepRE41UUtKkQVKH8tu9/vMqylm2wQNTVTtYxhgQQb/7wJfPPVQOrtrJhIKAD4/b3Vxp8pkEG2/gupKrlIslGl48t144BqiaByyfOWTSFUAFS9OvNaMU+Ljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5SXH5bx9msEt4zEcqPzvR5v/h+nf0LuJPoVFt+w6iQ=;
 b=kz4IZM9hhee5a6oPJhrn8J/9wc6HS24YJaS9SvTxpmLkm/BYuLY0VANfDU66nKtX3nzkHPq3U4wCX6ZabrORN+/B5JqX/AbloreXGTxwQQELtKmSQNl5lZQtwvK27Awqz6hpKT/aOxdMtsdRY96Rn3zkkuTbz/4pEyjaX7G8jtuPtEygyLbnfEMYBmq9aoz5YCMrf9kg0+OquLWBYo1lhaaBDRAD+a4lBsAWylR2CjXXNQIqfWtZyaYES6LH1cZepZkP4Ud8eNymoPYu2SlCSnyAEC0lNsIlmxZB/9GpehFFF4S3exJjf2p8QnvV7woyGamo/M1MBIwg3zMSxDH0JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5SXH5bx9msEt4zEcqPzvR5v/h+nf0LuJPoVFt+w6iQ=;
 b=SvTADqs89ZBaCeAgLsD3JmIeEoadAt8cQezNN3uH++RDjD/QdYa2pDYcMBv36ZkdJkzyy93CpmDOCT73fgdt+2bmADGAgV8+WIXrWn/+zsU75MhnoBT9sTr0bVoxWaU7DRwyaz8Co+t4V7SF13A87sqLL34jT/J2L5dNjd+kef9B5+mFM7S1PuCerlHSrBeB3NNKEocjpbYgBlc7UGHvb4Xnlk8pwJpDMJOcHPSTf/NWivd/h5v9u7XBlEF/M35nUxGePCYYN6UHNdTYhkCEdEbbtTUt8oDi3xeQx36SJWrB4+FIUDVBuhN7lqdm3qF5rUj4JfWTzb/BpOLJdwXOQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9)
 by PA1PR04MB10940.eurprd04.prod.outlook.com (2603:10a6:102:480::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 06:27:49 +0000
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e]) by AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e%6]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 06:27:48 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com,
	vinit.mehta@nxp.com
Subject: [PATCH BlueZ v2 1/1] Enhanced or Legacy Accept Synchronous Connection Request command
Date: Wed, 24 Dec 2025 12:01:50 +0530
Message-Id: <20251224063150.2476968-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251224063150.2476968-1-mahesh.talewad@nxp.com>
References: <20251224063150.2476968-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::20) To AS1PR04MB9454.eurprd04.prod.outlook.com
 (2603:10a6:20b:4d9::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9454:EE_|PA1PR04MB10940:EE_
X-MS-Office365-Filtering-Correlation-Id: 668da708-e0ff-434e-3f56-08de42b58eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FYfYck6mw6y8xyi25B1ECqTQyIOJBZlqheRPWEtQfoYotM3OWkAp64puY/q+?=
 =?us-ascii?Q?ksFkgWbYgSwEhE7TVpZrN6en2bDdm/UGT2BgMuy4S2sOktaBFfhwETnp1Ex7?=
 =?us-ascii?Q?wjEO9r/bo9GxwrXM3k82PGm3B/sZ9H5SkR947f0VNZ7H0TFR4LYgiQ0gzSX2?=
 =?us-ascii?Q?pQJdIPiSffcWeKszZRm7SGS5Eakz81IBirLrKgbNgboyX4x94XdCqCmlJpoH?=
 =?us-ascii?Q?k/qYciId7Vt1nVVdh1kSr2iNzSGKKksdUcAkZXgslYURvtG6dh7e0latFvSR?=
 =?us-ascii?Q?XjV6aHhR0o6fOxV1XqoCsvbHrEG8GVd/7ProHI+LP96Xt4QNHBuNbNCch3bP?=
 =?us-ascii?Q?oN3M0OIA+p99lAkQfvSTmReEt3e9T1xgFq1D0F13oAfuRtZd4dmWUe4ufFO4?=
 =?us-ascii?Q?IrZKeP6SCMkFIYGR5U07Y6fnGOYav9tPcLj3/YL/qTTjSbX85HHg/FkEPNLn?=
 =?us-ascii?Q?JPHwkflyqd57/CGYU3DbKTIZiZf88drP1K58eq3L1gfFL/SZJcIbR2/xotbo?=
 =?us-ascii?Q?5bO7CmNZ6OdOuYIX4as/5RuuNUdjR5oDBdf5z5KOCRARanX+L29z4kBGLMVT?=
 =?us-ascii?Q?ColHHkr8naRK0ij4o24FiuJzx7o9Nyrzbjea0jn4+5GkvsqZ7EdA2P2C8t3f?=
 =?us-ascii?Q?Rbj8wh2j4Rg/3VoeI7PuN/zrey1eoSJ52Nv7V4BBumOhrrftOAyXuUDcUQX0?=
 =?us-ascii?Q?qQs14ffeQ0DYaqxn0xmzxb1EEqbgbjZJ3oggm5F2842L48tbo2dIxirTnFrz?=
 =?us-ascii?Q?WeKEHgl8PzvECs5NpOMXvy+PJdljyB3vdI9Wrp6Hal72doEispodvulHCkLh?=
 =?us-ascii?Q?b1mZXw74yBiB6LHoU0S+2Tie5U1O1Z53LqucrKqnB9x66jNi+7uBPIstUisD?=
 =?us-ascii?Q?Ll6REJIrOycY0aYRSh21WmJd6KvtVvQLB7ypCXghjLYthfxTJjpn8R1A45Xk?=
 =?us-ascii?Q?bxkgKHgt5RnSic2l7tOG+Wq8vyzq+gciz+gwjYTQnac7hosyuO0STqt5/DZ/?=
 =?us-ascii?Q?hR4OPRD9D13S+VPlX2RLAZSJuqfIWFl3C7xAqAyBox99ObEKC/P7PvQX/YAV?=
 =?us-ascii?Q?ZBQ51n9SFjuRl7JDC+8g/38tbk9DZO1KXe2MwpgCM2qEhjYJBL1FindIxxYq?=
 =?us-ascii?Q?usLOh2LcIUYDyxQNFzea26Hp+uliEb16M/z8h5IaVtiYYzT3lryPFQpKHRNQ?=
 =?us-ascii?Q?XHgypz4OSo9SScLy5nKRFw0KERRdhphuZyx7H+BrmUFRGdWqvE6yaKWeWxDn?=
 =?us-ascii?Q?jY/F5OC0AoL4BDI+ZiE7CKLJrJ+tPta+LSUtdA0aFdwFABE38zchM0JBXTtA?=
 =?us-ascii?Q?VJ2pW1tjX8BNfCr4X5Y6c3gfdC7ghyXGSTKBAN4342V8rJM1l7YKkcSBD4mK?=
 =?us-ascii?Q?0ZSH7wy7HRrREU2L3T1RA/1RStJ5UosRX/kdqu+vsnUvXSbFbci1Z+eTZL2O?=
 =?us-ascii?Q?JcyB3sGGr2I4neP8jVpQ9JDW9ytzO6xHGUhcNBUUrfTjpaplA83T5NDpqymy?=
 =?us-ascii?Q?ixKGjY3k9VYX9ZhnhEDrjTN+0gC9A5SFvVrD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9454.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eN0lH7viTYkWZDwsTnP0nT71gPKDXiT6Mw4T/5phq18nNFndDn1u1gyZXI5y?=
 =?us-ascii?Q?R8NGaxkXrAvYi3ZTosPDHI5n+GPWmkzXfqx7k1ypl4kWU4dZgjQwtcJ2Uyyg?=
 =?us-ascii?Q?6bgECoy7HS3tZnBwcLWpL0caG5EXEPYyn8qwGWoYE32g9k3MMD7XReK0EeEk?=
 =?us-ascii?Q?et3B2MOa/Dlxiv+omBVZ6OrgB7QFtjNZxUFies7mgbRK+4u0W6L0KL3IRzx1?=
 =?us-ascii?Q?MUbEARwhxMLk8waLDqC2VgB8NYZAiim22UTXoZ2NMKURoVgUR2RuuDkSXWb2?=
 =?us-ascii?Q?nhaNbcByEILz34niEHsyV0nn5oYZD2H2Lc4wXm4+0vbirI8BnM6/AUmt1lfY?=
 =?us-ascii?Q?06KCD4VoGrOdQuvZMP0D/RWwr/hmp4PWl3Lf5dYO8KsmZjX1ydYj56Ek0UH0?=
 =?us-ascii?Q?2lWqcE2U8H6lsy+JCe3vW36NHm1+b/PDNBRI2a86/OMkU5O+xDbzIBjaJVoC?=
 =?us-ascii?Q?/OqskED5yIZmmcJ56mp6U5GavKL4RcZH6EX3tPkSjrZT2DlbTkcWn0NXtnDx?=
 =?us-ascii?Q?F6V9bY9GKX1/35L+6A95eR1XKG2okBJL+L5f5Lt9jvKsKQc7Uc0rV4RMs29n?=
 =?us-ascii?Q?t0AiFdP+poouFRcXyebI5/W9AmaxeB4oQXZIjwE9qbt9VorrgFUglwfUUTo4?=
 =?us-ascii?Q?sDY/sTB8DNWVvzhrmSPbg/UB4VKPd7JksmCJEU1ANfmUN4Jkv9FywjZFMGXv?=
 =?us-ascii?Q?i0kcpJN4rTHK9mBUOHLmrQBZ1kNZy0bwU5ezDG6rm9j/Oss/qLTE4SU3Zz70?=
 =?us-ascii?Q?PgrSWWGe7WawPh8rBKCa1NpISmycgGSWgAL8JvkfXkSTt84P6Mj860ArQunL?=
 =?us-ascii?Q?wgvhC52Pq4bxO0uBzFOEKy2vHKvFKGAqQMqnzbgVzGn3GJDXYWx8TGjP/4BO?=
 =?us-ascii?Q?v86x37qlWg+mtl7E+Wze4bXpqrV/uTssOSMTBF6Y9K1mlHg33B7C2IkHcRqf?=
 =?us-ascii?Q?lKO9XtxZWCL4ggRc5tvoLZtWO4dgAGT65sMOk222wo4R/rTRE+4lXGcaYp9G?=
 =?us-ascii?Q?0ZwbJGj9vpWdPjoLOGgkJE4lEQpCuBVRE1zFZox2PTigTinWGskT1GY9asGe?=
 =?us-ascii?Q?DORYwgmWKIGNAcbF4bha0XBmK1u1IJc2stDSuPVXdVXOvSzG1cSN355ULaJ3?=
 =?us-ascii?Q?kmAITlk/nVzkUDGbPLAll0XTg2UjM9ev5JkF1jZ38Io2yQEIE+IHWwJWZM85?=
 =?us-ascii?Q?VNDvncCH4VUq1ZAQ7FRFK6T/bUEdwV7pX57P3Y/DekT9AFpbZ4bG0e+XxOb5?=
 =?us-ascii?Q?sMCDKkawGOOQyYqcsrTluTC0ijS9P2pZQ2iBAAVy0hM0Tl8Zguu/g5bjY/sR?=
 =?us-ascii?Q?ap6nvbTCTfhtgx5zhICi7oFYMHT+SzSH1LIQaohKtBlD70thunz4ryvp2VxU?=
 =?us-ascii?Q?lrRi13Wx/4yM01DrxaSYpTxuS9lQXmbbPhv+0qiAjjJKyAQAe1MruvB1NJYq?=
 =?us-ascii?Q?pw1yeGWFb7FCSSdSEW0GhTQQ27lqeXNZWsv8WJOBL0i+/su3bXeySIq4CVQB?=
 =?us-ascii?Q?ugtyoRjkYnia8W0z5mymkRBWiUmz+ZXcwlrMgl22wCyR9LIdZGUG3MrZL6c1?=
 =?us-ascii?Q?TvBJcJL/lQ0maRlK/RfBz8FSGphqE4ORWBbUNYf3k4i2yUunJrSj2tDac9JS?=
 =?us-ascii?Q?Sk7hhphXuEsiAV74ENzQlbz+uH01dzdxB8ehcGIn0sVxSiE+6Jh3cvbRaQ5J?=
 =?us-ascii?Q?y/19N+wrvYsnRV/FATHZK3t4F9GobVYOQ3uh/wPOFYdml5bXMwkbSm1yir0z?=
 =?us-ascii?Q?1gkQMC2I0g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668da708-e0ff-434e-3f56-08de42b58eda
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9454.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 06:27:48.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1L5mVHye7MPvKhyq8LYtcWTlYVWfNqUWYiQnAHHyPHa7kN2OXhBB3wO4hZkIE6KURwsCamL4eMsjuOSLTymNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10940

In current implementaion kernel is sending legacy sco command
['Accept Synchronous Connection Request command'] always even
though controller supports enhanced synchronous connection
command.

In this commit, we have implemented the code in such a way that
when Connect request for eSco is received, if controller supports
enhanced synchronous connection command then it will go for
'Enhanced Accept Synchronous Connection Request command' or else
it will go for legacy command['Accept Synchronous Connection
Request command'].

btmon trace:
> HCI Event: Connect Request (0x04) plen 10
		Address: 10:EC:81:61:71:67
		Class: 0x000000
		  Major class: Miscellaneous
		  Minor class: 0x00
		Link type: eSCO (0x02)
< HCI Command: Enhanced Accept Synchronous Connection
Request (0x01|0x003e) plen 63
		Address: 10:EC:81:61:71:67
		Transmit bandwidth: 8000
		Receive bandwidth: 8000
		Transmit Coding Format:
		  Codec: mSBC (0x05)
		Receive Coding Format:
		  Codec: mSBC (0x05)
		Transmit Codec Frame Size: 60
		Receive Codec Frame Size: 60
		Input Coding Format:
		  Codec: Linear PCM (0x04)
		Output Coding Format:
		  Codec: Linear PCM (0x04)
		Input Coded Data Size: 16
		Output Coded Data Size: 16
		Input PCM Data Format: 2's complement
		Output PCM Data Format: 2's complement
		Input PCM Sample Payload MSB Position: 0
		Output PCM Sample Payload MSB Position: 0
		Input Data Path: HCI
		Output Data Path: HCI
		Input Transport Unit Size: 1
		Output Transport Unit Size: 1
		Max latency: 13
		Packet type: 0x0380
		  3-EV3 may not be used
		  2-EV5 may not be used
		  3-EV5 may not be used
		Retransmission effort: Optimize for link quality (0x02)
> HCI Event: Command Status (0x0f) plen 4
	  Enhanced Accept Synchronous Connection
Request (0x01|0x003e) ncmd 1
		Status: Success (0x00)
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
		Status: Success (0x00)
		Handle: 8
		Address: 10:EC:81:61:71:67
		Link type: eSCO (0x02)
		Transmission interval: 0x0c
		Retransmission window: 0x04
		RX packet length: 60
		TX packet length: 60
		Air mode: Transparent (0x03)

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 include/net/bluetooth/hci.h      | 34 +++++++++++++++
 include/net/bluetooth/hci_sync.h | 13 ++++++
 net/bluetooth/hci_event.c        | 27 +++++++-----
 net/bluetooth/hci_sync.c         | 73 ++++++++++++++++++++++++++++++++
 net/bluetooth/sco.c              | 34 ++-------------
 5 files changed, 140 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 40fce4193cc1..4f1a38e8f276 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -914,6 +914,40 @@ struct hci_cp_accept_sync_conn_req {
 	__le16   pkt_type;
 } __packed;
 
+#define	HCI_OP_ENHANCED_ACCEPT_SYNC_CONN_REQ	0x043E
+struct hci_coding_format_en_accpt_sync {
+	__u8    id;
+	__le16  cid;
+	__le16  vid;
+} __packed;
+
+struct hci_cp_enhanced_accept_sync_conn_req {
+	bdaddr_t bdaddr;
+	__le32	tx_bandwidth;
+	__le32	rx_bandwidth;
+	struct	hci_coding_format_en_accpt_sync tx_coding_format;
+	struct	hci_coding_format_en_accpt_sync rx_coding_format;
+	__le16	tx_codec_frame_size;
+	__le16	rx_codec_frame_size;
+	__le32	in_bandwidth;
+	__le32	out_bandwidth;
+	struct	hci_coding_format_en_accpt_sync in_coding_format;
+	struct	hci_coding_format_en_accpt_sync out_coding_format;
+	__le16	in_coded_data_size;
+	__le16	out_coded_data_size;
+	__u8	in_pcm_data_format;
+	__u8	out_pcm_data_format;
+	__u8	in_pcm_sample_payload_msb_pos;
+	__u8	out_pcm_sample_payload_msb_pos;
+	__u8	in_data_path;
+	__u8	out_data_path;
+	__u8	in_transport_unit_size;
+	__u8	out_transport_unit_size;
+	__le16	max_latency;
+	__le16	pkt_type;
+	__u8	retrans_effort;
+} __packed;
+
 #define HCI_OP_REJECT_SYNC_CONN_REQ	0x042a
 struct hci_cp_reject_sync_conn_req {
 	bdaddr_t bdaddr;
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index dbabc17b30cd..c4286d90af6c 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -189,3 +189,16 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
+
+struct esco_params {
+	u16 pkt_type;
+	u16 max_latency;
+	u8  retrans_effort;
+};
+
+static const struct esco_params esco_params_msbc[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,   0x02 }, /* T2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,   0x02 }, /* T1 */
+};
+void hci_cmd_accept_sync_conn_req(struct hci_conn *conn, u16 setting);
+void hci_cmd_enhanced_accept_sync_conn_req(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5c4c3d04d8b9..1324d3b107ff 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3314,20 +3314,25 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
 	} else if (!(flags & HCI_PROTO_DEFER)) {
-		struct hci_cp_accept_sync_conn_req cp;
-		conn->state = BT_CONNECT;
+		if (!enhanced_sync_conn_capable(hdev)) {
+			struct hci_cp_accept_sync_conn_req cp;
 
-		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.pkt_type = cpu_to_le16(conn->pkt_type);
+			conn->state = BT_CONNECT;
+
+			bacpy(&cp.bdaddr, &ev->bdaddr);
+			cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
-		cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.max_latency    = cpu_to_le16(0xffff);
-		cp.content_format = cpu_to_le16(hdev->voice_setting);
-		cp.retrans_effort = 0xff;
+			cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+			cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+			cp.max_latency    = cpu_to_le16(0xffff);
+			cp.content_format = cpu_to_le16(hdev->voice_setting);
+			cp.retrans_effort = 0xff;
 
-		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp),
-			     &cp);
+			hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
+		} else {
+			conn->state = BT_CONNECT;
+			hci_cmd_enhanced_accept_sync_conn_req(conn);
+		}
 	} else {
 		conn->state = BT_CONNECT2;
 		hci_connect_cfm(conn, 0);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a00316d79dbf..91e321d13db6 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7077,3 +7077,76 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
 				       create_big_complete);
 }
+
+void hci_cmd_accept_sync_conn_req(struct hci_conn *conn, u16 setting)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_accept_sync_conn_req cp;
+
+	bacpy(&cp.bdaddr, &conn->dst);
+	cp.pkt_type = cpu_to_le16(conn->pkt_type);
+
+	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.content_format = cpu_to_le16(setting);
+
+	switch (setting & SCO_AIRMODE_MASK) {
+	case SCO_AIRMODE_TRANSP:
+		if (conn->pkt_type & ESCO_2EV3)
+			cp.max_latency = cpu_to_le16(0x0008);
+		else
+			cp.max_latency = cpu_to_le16(0x000D);
+		cp.retrans_effort = 0x02;
+		break;
+	case SCO_AIRMODE_CVSD:
+		cp.max_latency = cpu_to_le16(0xffff);
+		cp.retrans_effort = 0xff;
+		break;
+	default:
+		/* use CVSD settings as fallback */
+		cp.max_latency = cpu_to_le16(0xffff);
+		cp.retrans_effort = 0xff;
+		break;
+	}
+
+	hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
+}
+
+void hci_cmd_enhanced_accept_sync_conn_req(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_enhanced_accept_sync_conn_req cp;
+	const struct esco_params *param;
+
+	memset(&cp, 0x00, sizeof(cp));
+
+	bacpy(&cp.bdaddr, &conn->dst);
+	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.tx_coding_format.id = 0x05;
+	cp.rx_coding_format.id = 0x05;
+	cp.tx_codec_frame_size = __cpu_to_le16(60);
+	cp.rx_codec_frame_size = __cpu_to_le16(60);
+	cp.in_bandwidth = __cpu_to_le32(32000);
+	cp.out_bandwidth = __cpu_to_le32(32000);
+	cp.in_coding_format.id = 0x04;
+	cp.out_coding_format.id = 0x04;
+	cp.in_coded_data_size = __cpu_to_le16(16);
+	cp.out_coded_data_size = __cpu_to_le16(16);
+	cp.in_pcm_data_format = 2;
+	cp.out_pcm_data_format = 2;
+	cp.in_pcm_sample_payload_msb_pos = 0;
+	cp.out_pcm_sample_payload_msb_pos = 0;
+	cp.in_data_path = conn->codec.data_path;
+	cp.out_data_path = conn->codec.data_path;
+	cp.in_transport_unit_size = 1;
+	cp.out_transport_unit_size = 1;
+
+	param = &esco_params_msbc[conn->attempt];
+
+	cp.max_latency = __cpu_to_le16(param->max_latency);
+	cp.pkt_type = __cpu_to_le16(param->pkt_type);
+	cp.retrans_effort = param->retrans_effort;
+
+	hci_send_cmd(hdev, HCI_OP_ENHANCED_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
+}
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b872a2ca3ff3..2ed88b96fa2d 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -778,36 +778,10 @@ static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
 	} else {
-		struct hci_cp_accept_sync_conn_req cp;
-
-		bacpy(&cp.bdaddr, &conn->dst);
-		cp.pkt_type = cpu_to_le16(conn->pkt_type);
-
-		cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.content_format = cpu_to_le16(setting);
-
-		switch (setting & SCO_AIRMODE_MASK) {
-		case SCO_AIRMODE_TRANSP:
-			if (conn->pkt_type & ESCO_2EV3)
-				cp.max_latency = cpu_to_le16(0x0008);
-			else
-				cp.max_latency = cpu_to_le16(0x000D);
-			cp.retrans_effort = 0x02;
-			break;
-		case SCO_AIRMODE_CVSD:
-			cp.max_latency = cpu_to_le16(0xffff);
-			cp.retrans_effort = 0xff;
-			break;
-		default:
-			/* use CVSD settings as fallback */
-			cp.max_latency = cpu_to_le16(0xffff);
-			cp.retrans_effort = 0xff;
-			break;
-		}
-
-		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
-			     sizeof(cp), &cp);
+		if (!enhanced_sync_conn_capable(hdev))
+			hci_cmd_accept_sync_conn_req(conn, setting);
+		else
+			hci_cmd_enhanced_accept_sync_conn_req(conn);
 	}
 }
 
-- 
2.34.1

