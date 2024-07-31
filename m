Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50F91BC40
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406655; cv=fail; b=taKMnJMzVwH/7VuKisvBQvYsncSawytmWpTbOwLqc8PGQGUdarCIwq/M210Ha1c7VesxvvbXOZwIF7og/hqvM3lZcoQIieI38NrkeG7F8+yC8PDn/L0kwhFHYN35J3tisY9eaNGZtu3SfsYcj2m+vL9LzlJtjE1lPnGCUQ106tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406655; c=relaxed/simple;
	bh=LQWbOIvr2N7pGCzi9K2j6iutlR+YQaTiQe7ehsk7xjw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OaTsBtxwQeZybbk8K77k/5BNLPgnrwnB11IDFhqH/Awcauv9mIAKXaNZFsr5fiCt0n3uLDNuvqmkV5pAdl6fv1/A7lxhOS3H/6CX0i+tjvDhMFG4D/GhVcOvWcT9b0WuXVD8Txqpm/2BZicaRHcNCOrPfy6Ul9/8BOU/MMBHL14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Drj6dvDV; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Drj6dvDV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndbiEJiflHTJ0gK/a0nv/aIX4ZH1CEBDQF5wCidxNw0iNX9XZQhPAvWnKDglrZngYOxWrS8b9lVGsNtV4XNPRYthiGclt21v2i99YRSvyCDVphW2qs/Wost43PA2OfoBSqYvjiOg0A6wpGDy/u3eaTx+Mm1uHZE5g/ivqk610d7YmSzaj3PzgWpQ7wz8UhsRlqHGc2ALMq4UkZpv4b4nzU9sv6khpJCCz4c8F39ATtG6b4mD2YJYChU414HR8pesIK9dopeu9RYAvoRzc12aVxK9dn8Wgy66/F/vKItK5JCfyyhPFxK529rrcxkGGM8h0aSf6XZ3yiw31jrPXUy/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJ1E+hMO9xBp+ij2gTCzS7PEcoIMDrepu5h25wxdvdU=;
 b=UsRXH1Pdj/IQHey7cBW5HHvl6W+SPBsCYNDSk4gXdefvI1X/CqxHldneBzhaVdYxYRz/lZRFWJx20rqsn+afcgpWtvKpT4xnLDcIqs82XJ/91WlLE3bqAn6nrsrjzEyLQBhFytIqx2c36N4ydk2fAe5+GHM8fUbejI1P6I90vGdzRTD63GVrSF0FJptDEXLxbewQpMABAZft6wMDkNhSYvzeutMc70XikYnhN5FxG6hcPXX1UyxroISTDfS70uaLUxx6H0/4MXhL1zHRrbYof/qwrq6Zx5Zw1lgklK66fb2ANUq/b7a3jOtesAZzEhyTgaRnV2towWjLiCkOsPlTVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ1E+hMO9xBp+ij2gTCzS7PEcoIMDrepu5h25wxdvdU=;
 b=Drj6dvDVvwBJtzsOqgJ5sazIiybFKTl8EgkcMvnH/BsATrzB1nWfEgnn7xLe5Hi8Tqt/Q7NEDQaCHvo23Oo5uyMSKU6tnMtyNpLAJxUSlR7DOuvCStvumVUrQANQYlv6zVG3NYEF7xgDP30AwB1JcHhSYsa0BLW9LfhkYMESD92FRmLwF13SB3SDHRNZC9PDVCOtx5T6PHaxOi4mTBYiKi5FpOVCcavMR9AUjM+977woDNAB/eS9PokYiOQ0YwnfB/MHYyuUyci0OkyFRiXyUbH3CMDogQqCQd2EAu0kVPk3FGgQta6ercR7HNfqW7b+BZc/waRTzQuzuLyt2gAlnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:29 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:29 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 0/8] Add 'broadcasting' state
Date: Wed, 31 Jul 2024 09:17:05 +0300
Message-Id: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 811d0dc9-7956-40c9-238e-08dcb128748f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NfvKhMIEa4BPTbtkUHKNsWBTzYjryuQfzhdL0hbjPPiHAIuqISwzO9H+kPe0?=
 =?us-ascii?Q?MRT/bS1EWmfx6qzx1RScYej4MvvVZLdcCwqRdhlYq5wWC5uBIl9EI4O5rEEj?=
 =?us-ascii?Q?5UwX0AWx2XOkqQUlkQWo7cPsFNhghGRnwbKNaXBA3Vi8PaDPLKzXY90sfLS4?=
 =?us-ascii?Q?EzRrqGzLpc2e0OmBFxC6YMs/smgNHUQ/NErBG38mzmR3fOwvMtcIhUaUy+MS?=
 =?us-ascii?Q?eClIUu1cGb5tI2kDRFq/5RJIaIm9Gysf2YwQQCcNfLAbFay/yGf/p8Q4LBN6?=
 =?us-ascii?Q?m18kN64wg85HetR9eSe5tl/wzhPfM4RdEGWBhskgSjFvpaWZhtr8jE0nvvLM?=
 =?us-ascii?Q?3mpGDtrTgZfDbKIFiDcjnet0ObveCDQmLTydOlARHEbs5E3SdMM9X3R5wYun?=
 =?us-ascii?Q?ZVTFGoxwA/JlV6I15k/+TW4ZO/hoPrU29APQjyZVAntzc9XUfkDjap87HE0T?=
 =?us-ascii?Q?tcLrgC/JgKBz7c5x0rBK2CcSSxV7ojqZiyhevFnOyI4s1V8zADxGi0afsjvF?=
 =?us-ascii?Q?VF26WnnO2lNK93wcPEnATSHrVtYv4QAD5VYNccxXVsTs9wXOquXonGpUgae2?=
 =?us-ascii?Q?H8H/vq1nKLkkAKsKPQpKk/qnlJj+KUDOLUCCHhPzfESmNT6m51QcmRPDhZEi?=
 =?us-ascii?Q?Y2rnoKd+xa01335lMwuJca/wxeSeHtxucfUrXp2SMLpEu3RyihUY3Z5f6e+4?=
 =?us-ascii?Q?zC2Fp12bDSiZUd7EegVIkEYcDl8QXfdOJIxu8GKdOZwRZjb9/pOFQv1ORMeJ?=
 =?us-ascii?Q?3B60yV9km7iwJgKdYn1LHE+I6YtnQK0Cxsa4cum7/h7vHGJktP/GeEWCrWTf?=
 =?us-ascii?Q?nlqR0SXc7v0JngacPSEPFupWEe67A0H4RU6uVhmRR89MzjP+7QOdaX0UOZFM?=
 =?us-ascii?Q?ni2tUwHgknCad6X3AWHv8SHJTxIQ8S8x5pL6o1+6i4M3Od7AIBmMy8dtC1nL?=
 =?us-ascii?Q?C8sgya0KzeIBRdz2D4El7OG5YwY2oK17hjTPMW270l7Axm/qy7uB95SIQwY5?=
 =?us-ascii?Q?rKNhbdwRRUkQuqRw22DEYne4Q5+Woe0O+NOKBOEmZNrSRgsTLrs+M9/tCkrt?=
 =?us-ascii?Q?UtDKMoZukIW3nHqMLF8KFiArVphbNOzv4gwB9y7JfqvY+QIVBl/yg3WGu4gr?=
 =?us-ascii?Q?UqgKHgxD/PZNkc1XJRaSw6gLDbS7HB7Fx0gj04jnEe9nmflU1QeoJOl5oU0/?=
 =?us-ascii?Q?JoQ8IDsLgAZG6uteB5quwHzqnWEwGbJsR2+fGj27zQIz1/D8iOlLq+OX0c7l?=
 =?us-ascii?Q?w1BL8/WH9hZjW7dHCQnUWYAsargqMVJevvWTQnhLw35enyBoUgGhYobJYoNG?=
 =?us-ascii?Q?YVy8e9M47u+nLlo4aKDqyD0TiTtjRZbp3nfHPmiHlYSjLZliuQ9jYJu4UDaD?=
 =?us-ascii?Q?YyxuXHx8xAN5PAZecgSwkEVwJtqAD6OQAHL//MZkYT77ispW+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pe8DQy7KkLZGp58G1kJM3Gn1OxpM81RthZZX6QhjRoCEjNn/xXzkF+ajdGvO?=
 =?us-ascii?Q?HAbH/IOy0M/zcPoLaAihc+0ogBXVQwnh2CQ6KRTrz7PZTNQZbAkEUtrL3xV7?=
 =?us-ascii?Q?hkGeo+LKNAejA4OQWNKoBFW2fMAb9B3dhNSWsDDQWaJLq6odOQpWY0ySQSsK?=
 =?us-ascii?Q?OSDGw+901I2mcrQaAscLj4eC8ysBE6v9dpPrJSHtITftaoErbYs4O4bd+oiF?=
 =?us-ascii?Q?XGAThGo4Py42ZrqQbtm0tR8YVguhJ4yVliII+gDr+32VN97Gl5YwZNlQ+L/V?=
 =?us-ascii?Q?F/Jo8kVMTJYEc2YYD4H1XmqthEqI6u0QaXXcyo9MgqiP54I4ZNxWed5Hj2NW?=
 =?us-ascii?Q?bGe3EhZogjtzQRNU0C7egRe6XqMe09zttdZK/v8CVa5PgII0xL/U3S1wznJA?=
 =?us-ascii?Q?LAjd6jsHqCSbRUKgK2rJwOcH6HF6Tu0HaGwq4sbvFMOv/R9ptly9g5fT+c7j?=
 =?us-ascii?Q?/mToKykPq0HdOoiqUepZHcR9H+jlGlhY/1gorVGgBaYnlLztaMw2MN5+/K7Z?=
 =?us-ascii?Q?AOl0N/bAQNgj3mi3Gz+Z2o0Taxf7PNsEgF/q/M50D8Sl9d4MR4tBGSMLOasS?=
 =?us-ascii?Q?jCNYvOnitvzXtK6oiPr7/Ya8QXR5tDx3u1p7FuUwOGRPLUqOJTB6qREDyAn9?=
 =?us-ascii?Q?eWUbESkFWtazY15Htc+sdypP4Y5TsFFbtn/tf0WFAqQ5RtfPe4+0oFwZizfs?=
 =?us-ascii?Q?Rl4Tijs3VSsr1QXrGuGX5UryLvfOpNFvz4P1aGcoTBuCaibb8oTFo9hWK1WV?=
 =?us-ascii?Q?husqDhUoFRuYCXGByzNNUewBnQ3/HljH5kt7XdE9tXXczd6APzn5wOTVhqN+?=
 =?us-ascii?Q?qQbA/e4HzWgwErxBiNL0iOPI+dTuibU6Qsyqp5ubecx/1uiVRbiR/YO2HdK0?=
 =?us-ascii?Q?pROsfF6iT1pIIkPy2ga0ZaLw5ZufuAXuDOHwTBaV3Qg7vCqBVC5ruuUwHBmY?=
 =?us-ascii?Q?lDSmpmzLplXt1UphIcQcR54dfWFVnNz18ZX+Vk3XRX9cffsFwfKA9/QXAiqY?=
 =?us-ascii?Q?z3l97qUti+Phaa73gYfO+k7g9DE2WRN2A+unjSByDkYMMVVJFqLUVsoCtzoV?=
 =?us-ascii?Q?Nm8UARPb6/IyImlaRDI8t+7XVnEODfGEWmCSHKFaGzSxZeJys3j6D1yHk+J0?=
 =?us-ascii?Q?JfJ9S5y1Z5go47rRefonJi5IpXQSoDyQ/kA0eNR8dKRhFwMF0zF9pp/CKEtt?=
 =?us-ascii?Q?PRS5ZVW9naeky3impNrxOSF6FLpWNxEiy8J5ZSOspxFyI4NvrKeG1XIbmxDr?=
 =?us-ascii?Q?q4iw5WrGcc5WDKJn5MNcCNF2X3ZTUtpnhUgEQ5xP3791XEquuApWjWHK6A6k?=
 =?us-ascii?Q?quJ/4Dl9GRdQG0ci63GQuvGaeVKWjN3EU+lR+y5XRmUKuuv/Oue6SY6DPKP1?=
 =?us-ascii?Q?f7T+zJrC0hupnwhRRUlloNpKf3rmNWKj+2EEbZILjJNrjKFoQ61NCu7HJPZk?=
 =?us-ascii?Q?+EL9BbTPcjQIXJlNA5xm0yxhrStiNDkx231bY9EZ+8CHHiufPdIiE+FUx0k3?=
 =?us-ascii?Q?3EhZGL52CisbRpwKCGEFxbdVsy3fhLxzzJgI+e6sLLiQ79/90UKhtRsAJusy?=
 =?us-ascii?Q?KYn7a33VecjN9HKu38Jl7a8X0tLjLi5nhJdhxHzD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811d0dc9-7956-40c9-238e-08dcb128748f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:29.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OX2PT2e6P10STRpuHOeOPucRZlBBeYz3Yr3CpCWZqmWzBvQadI11OP3UjZzpmwJnI5QDF7iVRcwvsl3VSDgY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

This series adds a new 'broadcasting' state for transports created by
the Broadcast Sink device as a result of scanning a Broadcast Source.
Such transports will remain  in the 'idle' state until the user
selects them, at which point they will be moved to 'broadcasting'.
PipeWire detects these transports and automatically acquires them.

The transport selection is done using the 'transport.select' method,
that this series implements. This allows the user to select the desired
stream when running the setup with PipeWire since it acquires any
transport that is broadcasting.

Termination of the sync to a BIS is done using the 'transport.unselect'
method, that also involves a 2 step process. The first step is the call
to this method, which changes the transport's state to idle, with the
second step being done by the audio server which detects this change
and releases the transport.

Vlad Pruteanu (8):
  doc/media: Add 'broadcasting' state and 'Select' method
  transport: Add 'broadcasting' state
  transport: Add 'Select' method
  client/player: Expose transport 'Select' method to the user
  transport: Broadcast sink: wait for user to select transport
  doc/media: Add 'Unselect' method
  transport: Add 'Unselect' method
  client/player: Expose transport 'Unselect' method to the user

 client/player.c                  | 100 +++++++++++++++++++++++++++++++
 doc/org.bluez.MediaTransport.rst |  31 +++++++++-
 profiles/audio/transport.c       |  90 ++++++++++++++++++++++++----
 3 files changed, 207 insertions(+), 14 deletions(-)

-- 
2.40.1

