Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5593B9DAB
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020027; cv=fail; b=MHSU6D5KK1nNJdLb1J5h7EL48qNaaWoVpvc9Mv5hW9Ba7Y6QfYzV/IodAq5Xb+lWl7Y/RwsruthZbXEnXbzvV0xLPt9b9KuukZDBB+cKh7mWyinvqOPxaEtNl4iVrs/BWHLjP+NVNC/7DOMoQog4UhjzpGz0iZvvoZ2gNpQhZ1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020027; c=relaxed/simple;
	bh=6a8kySiVsih19ilNUDXkR2H96XCcSeH+hAaEPB6zy38=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TNlzcRPrvvwrkthqSvx21+8VSOs97H1ebFZ5PGytHftPZBarYgugNj1DU8Lse7Z+JaSaoFIR4XgDx52NR1DSKSBBlMbDsEsq8HqlfA8y0EbkHTo55/C6BopxYDI1v7KYAJk6oaQuLJj0Q9q5647uw1aQwfbcb0rjN3FJNlst87M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EU1445K6; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EU1445K6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2NuHfWP/R1X0R3rv0H+d4gzB39UzZOj5147pIUh+WaoY6dBz/r70pcvVfHKBqiLWjXEnh9jb4kJ4gwkUahVMVPnm2n+1ovG8zK8Sib8DNJSOezZQDw+9/jekvzuN2uMUcdGxY3FYEAZsyD4JR4IsncvfOpu492LyfMs0uIwp794Gi86Kbu8/XYYaFx5hjUX7eoeeml/HY5dhquPcUB4lIVZ4AUCd+aU/6hWsWRSAke3WiT5AbXUA/4YhEOHXYyswtXMV3E1XLZfSFyjtb2NL8pZha79PSGqX+pw/CRc2+n8wNDuazyOTv57w1EFGpXMziCNTff9/FJ9v3g9FFKByQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8Yn86VPOi66EJ6XrnXBb0od+zUKNm/4gQ4KtfFKufY=;
 b=n1Y+w4i3J5x6KnTcNpywWsyi7VfX9A9NuQWHs67nbdcwbeGkEPC+tmoqQuPZ/2nXcBGkMgmj33H+Rp1X3peFUJKy3zEslrGvbZx1IDspchNWsKIVWtFd6zP+ra083gC8S9ls+1exDSD4+CjnP7kHRBYfGQORSP+IXSFDOuKl8jOQEzjbnnkLz4lRvbdfyv/JZgXd8yMjBzpTa1zHVx8HbxFUadx6Q4UJhT8OJ50buXgjyOqS2/Irug3ZPYLgsU9w3gI0PQ+syoRaOX4SgsVEzpP5XYYbZwN0s/lkhS6LwTkO4FI6m7ouJa+6jSYbNBJLnC+Cwnbk9GMjhuNVwnEtww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8Yn86VPOi66EJ6XrnXBb0od+zUKNm/4gQ4KtfFKufY=;
 b=EU1445K6X8WS4pwv9mKxMagsR00BtlmbRUINOdbgqreyl3DTv2Id6V0TPAQk2mjSyHPiiyEkMAF6k6cXB+dqflzv7C5UyW8HJUGpuHLpiix2r0P8N06g1nnRw3eyecmwuYEfmlF4rkx6waD0jH/pQyXE86z6P+94hdHUFVrG6qkAt75Xdez+2M/xMQ027NsaLPw/IdqOWEGFW+SNglp1gDPRH8FqfM3oyzjy84PKY7cR1HYh+yOba8OX3hRbBjGy3hDQELS6AKwwqmNoQ+6wgAiGdXdunwt8SIvB5v7JiAk77TL55cHfpmcmDdAXzKccrB0JNYnRcBun17LiL78s1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15) by DU0PR04MB9324.eurprd04.prod.outlook.com
 (2603:10a6:10:357::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 15:20:21 +0000
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8]) by GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8%5]) with mapi id 15.20.9723.022; Fri, 20 Mar 2026
 15:20:10 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org
Cc: vinit.mehta@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 0/1] test: Fix pbap-client to work with system bus obexd
Date: Fri, 20 Mar 2026 20:49:57 +0530
Message-ID: <20260320151958.851-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::16) To GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12191:EE_|DU0PR04MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 791d41d7-04f6-46d5-9084-08de86942d21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|10070799003|366016|1800799024|376014|52116014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	HHtW7orJmb+fKpcEAcbjhKe3IjYojLG1YKkF0tJTV9znH75ChLEoK10bZHKygTrz8LHHat9c3X3n68eg6/3NlQect2bKKMb472qdwS1BggMIPow4RI/hZJ0wTG3e9Iuq79MYKDT/ghhxe+9WGsjskTGrYlAz2c7qIrt13npbAr1op3vwvm2CjKdsZasSWIghfYSvMQB6DjhseqLwdYJq+Tseo8WpKvhXUoT1YlOlEygIuySUy11IJLvpe2Une3eYcOx7UCHm6ugA4RmKFLF/AaQeNxJyX1JtOj5+KERUfLMUgvzER6Xv8XSsf/4ZQr/MMgIESnqi5KkQJyVfYD95Drz7m6paYc4WwUI3XPhKmFT7UrJFeokGKmNAdfJ3AVkzR+9btr4b/N48GW82MkVor/Qs6mPKYXCY3wMkkVCgsNLdTdLnrq84XJiOZuICeVGY/hkToRmjg17qGLpwuSgIlF31BhOm/WPmkKKd/T3ymVhphLMTU620WBdg/7uMRX7DuI2wRStUY4dNA3yNMKHYv6vIxQ0ZOjdmIF06BsMCQqM2z2QsIZBvw39qdF73XHCD7GGngI1/JRGzooUyW2jKEJv4BBZ5G2i85O+K2fzSsUQ6wUKKH4KJyH07Ny04d0pf27DzG0c3DeCijAUk642xVbKAvNDZUykI1O54C3Xm7UYDoyi0lLF57srxXQqJwg7xRPH/+y8u18UOfUWbh1iY6NrLRJT9KOt49GCHajE2U54=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12191.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(1800799024)(376014)(52116014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gvW0jLWpTqdiNgCGaxQX03vuaqIzfhQUct3KzT/Kgl8UUIct13EN6a9yBbED?=
 =?us-ascii?Q?/dQecMTVPHmzWd645uOSh8Z234lBOhSQyrtjEUdOfToy4zuxylycHUgN3J+R?=
 =?us-ascii?Q?fEW53XGRSd1UeYizs5P7GI3ZRwIu25V7lNrMbnDLr9HFupXyr3lKSTY5+q92?=
 =?us-ascii?Q?eJwAS98mP6gyOCGVC1nVQVDbEYlcX4ygVDb3o4ND7OMnjBU7GqHRsMgv8Yvl?=
 =?us-ascii?Q?TZO9KZShf82xEUUDkIXBlj6YruIenWjo34iTjgQmFd8oV1pAbNWuJy3j/Pfd?=
 =?us-ascii?Q?JTfhF4gmQHone8HqGcRDvECDfudQwtexJS/KP9K6ejak5wNkuPyekEu7gpkU?=
 =?us-ascii?Q?CchBp0yjBMJIJWKjcarQ9FZMxyEbIpQ/50OT7BgA0VwNSj/TrIcudJEvWu8n?=
 =?us-ascii?Q?Aa1TinxFEgQYVZUO62G3stAC+w1MsGRcNr5Qd+/+qIOo/qGMqMQFJD2o+2X1?=
 =?us-ascii?Q?O4v3ILUeIRAnJJCNL+IeoZilALGTD9HGjOB0U1WGEq+uT1coQRyJiE8WQkiv?=
 =?us-ascii?Q?GBuZS/+PV2NiJXPdHq9NIf+HvH/KjrY3FYDga66dnZqgCYVBTbO9U5lgfwJv?=
 =?us-ascii?Q?ztp8hHRbEmQS2uxoqswxjrwaWolL8llk8stdANBqwijCXNirnewJ1iMGy1l2?=
 =?us-ascii?Q?5npP9kJ9Al20H1A82WblgRWdX+dInXWrfAhrFedayAPWcbSAFnjzxp4X7q8h?=
 =?us-ascii?Q?TUEP3GyTvl6M/KuzhoP1WK9udDSR1+/ECinbhmVcwGeQgUpCLUzJEYaJckhp?=
 =?us-ascii?Q?PHMQlGnkDs6CMyNYKBFXGauKXkITQR6BtWYl3Pfc87AeBx6zHNN//jUK/fbI?=
 =?us-ascii?Q?uXxT40FD2iXv0LLFDFTfeSXSo83yVYHIB7YFhPLII/qRxjlDFRMM6blJmIrc?=
 =?us-ascii?Q?FUuI2ut2GD39zzLSn4WeBchd5m2WnNW/HR2S9+nhEinJDYhJK8h8Fp4dBKwz?=
 =?us-ascii?Q?uBA0COpUA1y4tBiLc7MFtyBRPKHM90bkUWKacV0faQDh8EBKT8QiUbNjohbY?=
 =?us-ascii?Q?er7l9kOLaf1O1X4eIwYTkx1G6PL1p0iOUbisZWImPVfDEsilCvw5vdEepzG5?=
 =?us-ascii?Q?EIxJLAov2jHgcJLskZE7W4JBo/sZd0zabIiZdhIzhmWf7YnvvqBebKlqsWMG?=
 =?us-ascii?Q?kr7zKCTlJmGgFDN1Zau156uvfHPpQACuGqE4o/HWYun7XFm23Xlugj8WaJug?=
 =?us-ascii?Q?aPSBYRkltPJann2SX8gNHOaIwp+5Pm5cvXT2jwiUtM91CHh063bFlYm+hrmB?=
 =?us-ascii?Q?xRZglzUk8McusYTqg71qSxNJE9vhpOpCm4cs/ZYIGEguOC0W+DIU0V9LbUCX?=
 =?us-ascii?Q?EYdFq1U+DLIC3duiyMb2vZgrMXGD+qm0z+cj7+3R6ogHDoZNadmTfoWSHBc6?=
 =?us-ascii?Q?0Vnfl/+6ZZ9lXd1KbJS2SJtyl1e6GNndydQ0BvJGXYtd+n2w2fS6luDkMUgb?=
 =?us-ascii?Q?em8XJ6QczAybZTY4b+7qFyWOVWqign2h1Y3ngzFEiKzxPNmFNsP93375w6EU?=
 =?us-ascii?Q?yw8YGWowHy9eWkRsD8KnMh56ZwaJ7MpVEHj8yX5YKUwZgux2vlfj8xyB86sO?=
 =?us-ascii?Q?pAVbzbIBz1TUwlBcH2E6HdFZLpOqbQOlkgCE71iZbYCCwzlcl4CgNVZD3k2s?=
 =?us-ascii?Q?xPihYeB0GJ5YmTuUGeNFphpTUaBCRkYD61rIg/Xdq3mvVjSZTLertC6WRgDL?=
 =?us-ascii?Q?4G7O+YsEKfT3ThuKqUK422/ZN8i6EV7Aq5DD9YhC4ATaHYKaVE0ZSbmpyksk?=
 =?us-ascii?Q?QyAZ0dDvq+3PGqzK25fxJSXDQFvCJ3VeVvtJ19v8zFEr092mbw/141G7rOmt?=
X-MS-Exchange-AntiSpam-MessageData-1: UGpOdadVFKvgzXskwlN8gXPPxhIFgu6sZaI=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791d41d7-04f6-46d5-9084-08de86942d21
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12191.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 15:20:10.6532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0zIcOi1EaK7Gn9v42vpUuY7lm6DO3a8jYzjIK7qnpHomv/Pp3uqYYMXdYY1PAcnlTEK5LoVy8yx3c/EJek9pj4aed4HaKT+oq0wcMNPjeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9324

This series updates bluez test utilities to support systems where
obexd runs on the system bus via the --system-bus option. The existing
pbap-client script used the session bus, causing D-Bus NoReply failures
when creating PBAP sessions. 
This patch switches to dbus.SystemBus(), updates the main loop to 
GLib.MainLoop, and removes deprecated GObject fallback code. These 
changes restore PBAP functionality when using system-bus obexd. 

Validated on i.MX8MP with a Samsung S25 Ultra.

Sarveshwar Bajaj (1):
  test: Fix pbap-client to work with system bus obexd

 test/pbap-client | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

-- 
2.34.1

