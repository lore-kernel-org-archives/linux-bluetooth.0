Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED217B41F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720018732; cv=fail; b=jlqP1/EoW2o5Ci8l+LbtcP74FG0Nz4/3k+WMPUfj1g4QVXne2MfUqgFT6e1XO9WgA+q+PWXDH0HcsO7hJIpMieIW3iqyNU6aR6o/dpfVmpMJxAqHnMAAjMiZq0dVae2g5CE6CHDmo3ZSm1phnRRHqN8oJdKihaJRb4Lp1Wppoto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720018732; c=relaxed/simple;
	bh=GKVP4mkFwOHfsAZJHT1oqgevW1w6Ayh8jZ5a574bTRg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=vC7+S9TAJXyI/F5f2VjoswWYpAHrHzf4lkDnLjNPDff7yQy9ZZyajyD/WxNdzuwOxp29mQWnprcD2mDBJrpyH+vaeFHnEUWCFmowoFCMLxUrUV19d4OzqBuEb1TYpof54S61EFXLuW8t3W4vZpwbxiQheQjWc1sH4g+46fccPBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dn63ENM/; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dn63ENM/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQ2Jpej+crgx4LgaQI4oaEacjZQtpL/RV06ywXAViqvUAAxbWuG567V9k4H1YFa7ybEU/CuKqRfqN53ClQ5MrA4gk6h9vyYrX2iRQq/MMd46p4AVkH+zY/oheAjFI7injprWbQJYlzU6jZW8m45AZTk+AzHwsffc8BWlVbJ1jrRkd64T6Rx206VWPjTyn15310DL9wgfFk+EBWp6iM48QoBek/tP40iNdAqyEBkk6LGH+3xFPn+ds0vi0sR+W8hKLbuQoOxg/Z5N8OTVZE8TQh6iif1sAmLGTOGlTEq38jx4I/JTp9lTeqOafc03gPCpCKDFDXSB0IgkU1COw4lMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vEP7HzRggMjzUlvHZWO2VbqVW/WWIra0QgN4OBu3lo=;
 b=PBahkcaE/VkCns8pAmH8+iRzEbUFLtiJN3bcH3EtQ+x4AQHPRsCtgFwjmguTAHQqqVeFJhgMABYGe3nGiIstV0PsHboVVKuDBmIAh0IlkNHNxAKYyAXg8Z+HkAeY7Z9cMjGrM8t05ya4MhHjZY36OWYg6e0WjY7rj6FEtvbPnVx13kH74PFIHosAUpIXCPaQfRNYG6ym0lXuJHDzYPFOUFP3YXd7s1u/b3ByAbkrItPfIX29Kwgp6hL+xuC+JxFNNvWwReZzq21nNwf24EejLsAI8vNBOjOoY+lgUNJ8AWqdbQJRby3mFWV7SxRwbfuJBA6Vx7rzW0+CIxBsK90QuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vEP7HzRggMjzUlvHZWO2VbqVW/WWIra0QgN4OBu3lo=;
 b=dn63ENM/HtvUehv/4LJq7ESeodheaCZFgNg8vxDqbUYeT0ebGfZbldzlvG2sTmXbT151+8H3Q27Wc/mkDOqeiAvqexayP0nUAaLMwD6hZ+OankcRbv2oNbJU+jmJ22Cwq+m+KHX4P2d4BNsKRtQXY5v/I+iGul8kCYMPg1cQFqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by AM8PR04MB7316.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 14:58:44 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30%4]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 14:58:44 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] doc: Add initial MediaAssistant rst
Date: Wed,  3 Jul 2024 17:58:38 +0300
Message-Id: <20240703145839.34828-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0104.eurprd02.prod.outlook.com
 (2603:10a6:208:154::45) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|AM8PR04MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c65051-4b99-425e-b4c2-08dc9b70a28a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WFeaSsPVEvXrOvPyJ4o8ECERpsEa6VQf1x826MSyYmyrfWait4K8EVQhYTfx?=
 =?us-ascii?Q?2Wl6aTcYdMNQpfNd3oSwt0rMjp1lIhHkGec7zx6M/2PPXtKA4At8ZVdQ+TlX?=
 =?us-ascii?Q?kjVaRs4sG7FzBa7YijLQdrh0smHfhHqe3ZR249yesHv7PP8hNyKwESdQUJq9?=
 =?us-ascii?Q?9RjHjz2llZAoAbA6xy6ccv/tZGXKKhFq/3CalU1+RkyySkO3AISel6bja4d7?=
 =?us-ascii?Q?sF4M2XzLX9IPz/CePNi8zQ7ac54ubS05/Wmc3C69jY2NR3wfFEGhi1R+mkCs?=
 =?us-ascii?Q?ChoIMBqCE0t1vKC4LnbMyrc4sYc8bhTf07uECtwUB+FMK3EjUL03THQzxXPG?=
 =?us-ascii?Q?dRR1RB9opk7pWyaTpbXo6cKf9rZpmraJECI301OTp9oct+zgCq1D7NgIW3I7?=
 =?us-ascii?Q?Kt5VUhmQ0vt7ssg6Qnn9R0isZOuX3S1VcoDSfAT5OcRdxvjHBw7EChCvsjBB?=
 =?us-ascii?Q?PRipuV7sFmlSCjco4T4xwuvsce7qwWTQ1bvT37c27nQHi1w8wv91IB499F1A?=
 =?us-ascii?Q?y5y5mQElbOe5HpUlm8fwGmfOKi3yKZIrQ18iX+97ro+OAl8SEZ/fbluJ/2By?=
 =?us-ascii?Q?2m6XY8zXGtyvolCzqDfH5uJ22KrEjvF0X8p/Ua7UsM91PjgCQMiWFO9dtbNt?=
 =?us-ascii?Q?OdpIadg7GvCwkaqna9VzakxzWZzKt/Q6JGgbIxQu5fUEqpvCFJ7yUqR3LXrB?=
 =?us-ascii?Q?khbsM8Mt7OtddVrFdaqhR15HmAfq+SojnRdayaU8VP37ql0OG8yOXH49P+Rb?=
 =?us-ascii?Q?yMzB+pfa/+IDcIR4+66P9wchc46ot5t6HYr1r2hzdOzJYa6mbe7iSc0UnTA9?=
 =?us-ascii?Q?ySamYubablWlvoYFo4F69377LC+cpZPkecQiuacjQQCV/NQNWWCB+1cPamwj?=
 =?us-ascii?Q?WeidWxRaetrjtA6jk6sqzMbh0oeOrTweHpsWRu8A7XVaWpVr1TH5PgDwADhD?=
 =?us-ascii?Q?+G4RPPV30XVicloIBSADtrCrIH7Tdb1K1oTbr4l3w3O/uEfC6x2iD4yHwd3D?=
 =?us-ascii?Q?B7taXH9IyRg9nB3zBy3RBEgnfKQdydetJQ5VLqwWl5L9OpXo8wVo0tVJlK0h?=
 =?us-ascii?Q?UI9kXbUmWGiQr/6Qe/IJNTL6NP77ZjIEcUBpKyoVIpTbH5v17flj7lTAZJie?=
 =?us-ascii?Q?cVFpzR0BoLs+1SEW8iW79z1K2sikh4NP6SSGCxB7KVZGpDcgT2lGJZEpUIyT?=
 =?us-ascii?Q?Nwgu48v8ljspZ5Gb2eh7I7T1XdFqqplepYEgjYsOlJxgiMWmIgY95VQjwj50?=
 =?us-ascii?Q?7bjA5ougyyhLC46UYZEt2PBROO4yS8Pah9phwzkChWifHRzd6NavkQMSaobQ?=
 =?us-ascii?Q?B8P0UNupp6hufQ7VkRekn9RxKSALb37t8NZB4dp51Eg5Ng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K4TCrHIksIfm3EKjl8HX3LyCELWdiGBqSmsurgdQYHiMljU1PdzZ3Yqcpbow?=
 =?us-ascii?Q?RNJROaVqvxTBov6Hxs2VmajD1GIUUT9k/yWF3l7U1d0q5ayva5xPOqyCz7Pp?=
 =?us-ascii?Q?y0XEeI7TPQiV3N6yJZj67bhwQi8N0LCmhBwKXj2BxmHsHSnvZl3kjAttM96q?=
 =?us-ascii?Q?79HDjeVmLdtmCCBvnGuhxJoPSp0MC9A9EtFuWPADDDimCiA+pXfe7xdVDgzN?=
 =?us-ascii?Q?XHCYPOSHkHb/T5dNSz6kLrQLvCzfOHYsMXlRexnQjd1aY/HnjvrT2D0gso1z?=
 =?us-ascii?Q?UNU9rElhxqChdbEd0iWdnGa/0i5j6udsysBaJuuqLqIF4KgiT+/xB7YvbYrL?=
 =?us-ascii?Q?X20Ti+UkEIq7nzAeyCe6ZMYHJ8+PQzEe+mZx44XzkyQ7a9CPu500lVfNgC22?=
 =?us-ascii?Q?odKr9XVKiKYqF35ObN9fenHvm/8AAU/wEM1uzzcOo2BMsqpX3eJvIta79O93?=
 =?us-ascii?Q?nQcQx/leM3+tYNS5W+UUWGCI3SVlih03SEvTWUcHxLZLi2csGI9tGEcpkLXO?=
 =?us-ascii?Q?lqF15Gi09er9NoOghNkSJ5NhupwWz0oaEbzsNafBn0rbNZYvIGIOYuyas7Bn?=
 =?us-ascii?Q?suVWJc6x6IWR2RGw1PCPRANwwD1N9GUBZThWrqJJKBDaXg9ScLWSS2JlsA7a?=
 =?us-ascii?Q?WXYJ1uiOrxiWug+30KDO6E6Kf+tr/rKHOm/oiY14bjb/xI251Pi1wpXVgJTM?=
 =?us-ascii?Q?hcdBBNJrQKsx0+zNcuIJN6kNZz6B0vzKiZ/M1FKmTqPoRFOyJJ/SydXrMeu+?=
 =?us-ascii?Q?8Awk1i7VQpnHd5NU5iUyV5q9c3fJpZ5FhyLdTDhZvH+ZcEWqixqokt01Nna5?=
 =?us-ascii?Q?t8NdorehLOJTFtiFL/0MxIKS2qPDK5neO7VY3EPpacE32kAnwaDrsszrCXC/?=
 =?us-ascii?Q?uqWVIyfrtqAvqn37zBJ38UI38+AqPzx2aNtUyhwMkht3ZA6BGKmsCXMYtFRs?=
 =?us-ascii?Q?DbZ11BVWIaJaM27/a+g2EH2ItPr0JfE22mQbTQp7UkSZK40Phwu8pNcavR1+?=
 =?us-ascii?Q?rnkrGY4hzgVVA1kV+G5W5L13eCMct8ZfdNUzkNush3FnBig3J5oG6etjn7Ve?=
 =?us-ascii?Q?Sq1zfl9h/CkQFzIc+feRKQ6zdMNtIY6zrt4JrI3cFoWF1fz4ZATx0Ywnv6Jb?=
 =?us-ascii?Q?DdnGSdnR4HcFUREHnNrrYoAbklObQyba/hhKpOoTaURo+A4fGRFzYGZT3PYB?=
 =?us-ascii?Q?QrmnPmVcZVpi2Aj5M+RGaGECii6Gn5XGVPv994onRm+UsPNrWl3ES78/Cd2Z?=
 =?us-ascii?Q?3bWOlPV4p+/vSTMxDPVF+NiT0X16du802v5tztUOdSlge/qGQaNzPU1h3EIL?=
 =?us-ascii?Q?pQ46UF6Q/2iD8Q1iW05PEhcTyaegR3zHhUdNkd2xlEZdSE/08b2gqInU8ZiB?=
 =?us-ascii?Q?D9KCiU1qLJ+C+eWsUbojwiABSIdWqkYv1y1uGf3p6CDEDnrSUUN6rGbLam1E?=
 =?us-ascii?Q?j2SIpb8R1d39UMAsN5n0sbsCGS0yetlQLQMSultxWIhbdxoQjJi3kjvB0Gm/?=
 =?us-ascii?Q?3pOvvVFw60r2DkXWfewPnwefyZHqgV6u1/JUTlbkFhuMua6ccA2n41+a0e/y?=
 =?us-ascii?Q?l1qHyJ/TBVqt5MGFx9t3JhisWBEdjbuRQ+f6fReYeVxvrK6vM2Nis11rBAh8?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c65051-4b99-425e-b4c2-08dc9b70a28a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:58:44.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOWkf7nHkudQmieIu1bfgfF9+pk1L9zxN6sbdAbuoTZbTaQmanpcYPezKsoSRroShW7C3xQJ1RwhUz19C7/4Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7316

This proposes a new D-Bus API to be used by the BAP Broadcast Assistant
role.

The Push method on a MediaAssistant object sends stream information to
the peer device. The stream information refers to stream metadata and
the Broadacast_Code to decrypt the stream, in case it is encrypted.

Compared to the last patch version, this updates the proposed
MediaAssistant props, to include stream metadata and a QoS dict,
with the encryption status and the Broadacast_Code.

These props will be provided by the user to the Push method. If the
user does not wish to enter new values for the props, the values
discovered in the stream BASE will be sent to the peer.

Iulia Tanasescu (1):
  doc: Add initial MediaAssistant rst

 Makefile.am                      |  6 +--
 doc/org.bluez.MediaAssistant.rst | 74 ++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)
 create mode 100644 doc/org.bluez.MediaAssistant.rst


base-commit: be0b08770e9214592e89589b2dc069426c0d9b91
-- 
2.39.2

