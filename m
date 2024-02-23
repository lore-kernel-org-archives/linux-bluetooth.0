Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB184FB0
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706901; cv=fail; b=KPh+9WTVHAlFX5kcB9w1VjSxoT3yCYBfluE/sjW3xR4DRYnRPCg1m34BDvzA5nq4Ng11pUh8wBEg5d896G+NrNnYxPEVycdHG/fFxfrc10Vxrc+RfVRSLdl7UhOXgmQgmEJ4LlNk1fMuax72Ftxf+MuV0qhERCoeVkCNQqq8rAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706901; c=relaxed/simple;
	bh=Nfyj79lV8tmL1AG/kFtfeYfd/MjqmF3KGr/b47OF05U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Fls/Qco/LmLUzF7Y72kWRN+Ur+PlvLAueJYfd+adMjW7wNSbexKbcomJlSICGNv5veTMy2VBFQI5URi1ffi2lh0BX6I8IaR58Z5rwfroKpdoZWaSEUzv2eAmFzlte3Aa4Jhc0yLw+sukBTd5vjCOHwU9WjZm3c1F/+PEL3WeucY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jpW7ef5s; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jpW7ef5s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=getmAHKrK3ehRookzIxNh+u9n9sfciHyg4WECfe5JGzMJJZU8drI+BuQsWbAd/SMirp9DzL8BXp2MpUQYRPporo3gaXoA7t5lLJa1yXZ8gh4sCtrpPBcEnxDYJRTz/V3SHJr4KuHscLXGN76E7hp4JG20mkmHfVmoZi+2WdkdoV+AFbpz9opa4in5g/po2w07rYyTuJq7tI+BRaIr9ylR8o/aA81FgWO4Fu+L9fvMKkG95WN/yRU9Afv97wOc+4rhK/dLmQ+dfJNsafvE+2ZWMuz4EIiL2SeJwLbpwn5/ZxrQBtBklIxn4FIkNDvCGbBiHM+hT3wogBN7rk4Ql3m5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0zPk17NFWc9+1JrHTPwONFFpfiQaAA8YeflND/fV08=;
 b=mpomASda1lqh8F1oA6eZ8Oy2lJHsIZydmBwJXOmdanYQpA4dOGWmiY+PtGawMNrG6AF9xINUC4uCpdcAmzauO/2Lx4FbtY9y+5tprY7Dy65/+aIGfznRKVYOVBpjYfa7UfpLDs+dw3wXljM5rXGLzCHiDDR8m3pNDd37K6W+29y1MSY/TN5hcwcDI7PAguqIvqAMjbOMsgEsL+Nj22dX5GnSA16QiEyvMUL2i6ODzC9RggROsEryyGJUcSVIVo0VLN4Uv1QauAeawdu3vLAVjLEL7APVUt5ql04K+Xu9jLBD9Q0H1z0JiAT1kY1ZQyEGW1cfqM1rWaqFRjHVFNCVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0zPk17NFWc9+1JrHTPwONFFpfiQaAA8YeflND/fV08=;
 b=jpW7ef5s7qYGegjU1rzIFKe1thG2126ZOisrIhmChWhkD9S1CGp6Vy+IZT1bUCd4U3SUFM25gSHiY+TgZaQynuDMoIi1JMpMiGxAapNG6OrtISeHW+f3AMTLOHMsguBMCFELZ1c9QP14EISwLiBHJTeyqcryQR9aNz6RC7bTkS4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 16:48:16 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 16:48:15 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 0/5] Add support for multiple BISes on the bcast source
Date: Fri, 23 Feb 2024 18:48:08 +0200
Message-Id: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0033.eurprd05.prod.outlook.com (2603:10a6:205::46)
 To VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 206e0715-53e9-4776-4dd8-08dc348f3b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aB8mvhEWMRPqrGI1Ty5gB7cqJqJ5Mw1yaykmGO4FSP1d+NzeOX8ZffPDQP3Sfq446xEhRBxgkc6ouiYQZJcVPy1CIYBjn2/uc646lAPuMir1Af8qDUk/la4zU2QbyLQp7gbO/wRGQ8eyckMsv1J09R6MbfN9nqO7HgUaepfpBSlO6rgroJB0Pny8pAL8VktkLJj+CHyw+OpkxDwvW9Ske7Ke9jdug4YSGVjRFU7oprkxgLrlaVy18RhyNP64ZNrGZO0WVB4jqfjl+vNs0oPyp7+c8lmeli9auTrV/qhNISgKvPXdzU276hYh0YhUHrejDUbea3EIILCAwRWu6BN1Y2b5voqtTPzkTJ9sxfJkmh5SpEoO5kxDQRXbssZocGBmyXrPq2+fYcjERCAchLxnoFqkvN1ReNtcDxdrcZnOeMoXrm0zg7qkYMJ0G7Zo4sWDhe7rZkHi5X4739i5xe8P24S0ux132hpGKo1pwuaiLV5YDvYAlDO/ACVBzv6p7js4nW9vs5UFWzLNeIpYY6VnAeZvp8SMfXXVzZyXif67nZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6BTcOA5jqzHmPBe6BOr0jtrvpNpQDQW5jMoIx8WGkB69Dh39VOxGB22EL4Fb?=
 =?us-ascii?Q?wRCgGP6/aTzmfzT04t1Vx66b2ZB6c476w//hv3pCjTnw6O7vV0IZ0uKRyJNA?=
 =?us-ascii?Q?4xvSxHrX1H3MsMC3M1j8/uNcCWRT/+fub0hLqUUCpwQYff2ducTqHA1w/LEU?=
 =?us-ascii?Q?lRTbc3lWqDJFImoa4pkn+wiTdfQ3xzC7BopxIzLaav5Qhbqq+9DA7pLyfzjp?=
 =?us-ascii?Q?MNht34AzsOuKW5DFyfPdnLde0JEFqDcZm5GFZxoaGg91aSYSETC+d6l3+BXz?=
 =?us-ascii?Q?nkr+ThJGORsodrRlhYKTxdnS0X7FYx7Ll9XCWEzdORiuz0qXbUFEp4ubMSvd?=
 =?us-ascii?Q?PYDY8yl2fSpD5ksN6/3XVC7x6JFyLaR7cojnd2lL+CdaN4s3oruqLzK0CDuY?=
 =?us-ascii?Q?vFqAXVHTNzz0VLBX9uBLT5pUhxdtpH/FxvC0HeOkvSnjWVlep20sUGF5vg0/?=
 =?us-ascii?Q?MaOWTnaN8rp0R/RttToHKnKVjaw6gNYKXnuYUQvrcXWtom0eJ4VSWHUgv0J4?=
 =?us-ascii?Q?k0uKExSye8y3uTG/bfBOpHmPGw587SFDqxTJpdvwrjoPDcVGfAuPBGZa0nT5?=
 =?us-ascii?Q?EwqfmTxTycn7JbA57Yk9Uec5IX4PtovpiO7tNwFytOcqs0o5nqkza/zsb6GZ?=
 =?us-ascii?Q?XeVjqU88CpB3KekmEkqsJBdrshLUdY/S80l7MRY9njrrDxi1HtjSVZPbwzzo?=
 =?us-ascii?Q?Wk78ZIDwJ+9bvqpyNqP0Qh4pRk/6YNxSeH+nHjr3NRkGn+nJQWFvyxrCBqsf?=
 =?us-ascii?Q?bU6HJnBZ/2lSSKcew4KwMpAfqBU8LtWLfHbHPn3b7sq5gAsddVsbgRZUfkF/?=
 =?us-ascii?Q?Rex+brFxy1Vycl9rvQdrD9dMVxghMmrEUcBx4gpcLbWeoEw58ezJEu3M4Q1f?=
 =?us-ascii?Q?hkMklztibHJ0UZDVWPOIX7sHZlLtwp0f0giacgNbNFMRrLSzVOWrqP5Obl6y?=
 =?us-ascii?Q?Wm0q/lV6KwD2BAE0aEcFIMglM31UBUf7zed1Ovhvnb3UXIaLWVeUYXxG+PqC?=
 =?us-ascii?Q?A8d5nJwZuMQolxli1qU8G3v8fUH+fN2sH2818zO6SUeMW2oZR6C6DRnBsoeG?=
 =?us-ascii?Q?G9nzhbii6+LEUp0SytxzCzedCvScl8OznanhHRUNDSFv86HfVSmDI/KBM2cH?=
 =?us-ascii?Q?fmT5PCTTSnnLTtJakww/EuoUzeoLxPMrtMmPmPusG2PSsDiuu7PepJPwTsL7?=
 =?us-ascii?Q?3ZElknJFDsnfUNTGXcoeWyWxWfnMDqDq/eZ9oBC7SHe4m0pCqRq0wxehKrNn?=
 =?us-ascii?Q?0KA/9ODYdUZYKfqtXD8pE1WmG8ZsmE6iF79XSVj8dXlDB5WnCLEZtX2r0Z1l?=
 =?us-ascii?Q?8x2Rgyu45Ae+dwR7403RkDMIGJy0/dnGMZFyVG5Z1Qbd251mQ+rTHhwtny+7?=
 =?us-ascii?Q?6/mXOQVBMforQLMz5LQkyd5t8rsfzbwuvfJ3sn3O5HkVStjnvID4AhQNrVEy?=
 =?us-ascii?Q?fbSfoA9/uV2MzE/0Qx4/Q1J3tSKyIkKcOqkSS9/QXCe0OHIN/DSZW0Gg8bD/?=
 =?us-ascii?Q?UspoCaQKEC7G0x24NmghLvGkwcwjUK6HvMVlxUHTB0K78118N/7trM7omh/+?=
 =?us-ascii?Q?CgOt4Gcif1DCYGZma8Q/YgNiDGL3tcgtHFNGKrLdT67XKCfLHM0pQP8AkmLB?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206e0715-53e9-4776-4dd8-08dc348f3b19
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:48:15.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXFm09NQNEkVMI/Vxnus0kKFEfnayC0xjfn4f+xkVQiJtmg+K3x7hPs84/FjtyQn3aQX4dUMNk62YDYLOs5AtJnQGC2030P2p6XltIogpBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479

This patch adds support for multiple BISes in broadcast sources.

Example commands:
Create a local endpoint and an endpoint for BIS1:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 0x03
[/local/endpoint/ep0] Supported Context (value): 0

Configure BIS1, create BIS1 transport and endpoint for BIS2:
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0x01
[/local/endpoint/ep0] Enter channel location (value/no): 0x01
[/local/endpoint/ep0] Enter Metadata (value/no): n

Configure BIS2, create BIS2 transport and endpoint for BIS3:
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0x01
[/local/endpoint/ep0] Enter channel location (value/no): 0x02
[/local/endpoint/ep0] Enter Metadata (value/no): n

For multiple BISes acquire must be called on all transports
before the BIG is created:
transport.acquire /org/bluez/hci0/pac_bcast0/fd0 
transport.acquire /org/bluez/hci0/pac_bcast0/fd1
.....
transport.release /org/bluez/hci0/pac_bcast0/fd0
transport.release /org/bluez/hci0/pac_bcast0/fd1

Silviu Florian Barbulescu (5):
  shared/bap: Fix endpoint direction for the broadcast source
  shared/bap: Add state in the stream struct for broadcast source
  shared/bap: Add support to create a stream for broadcast source
  bap: Add a callback to create a new stream
  bap: Set the generated BASE on all setups from the same BIG

 profiles/audio/bap.c | 223 +++++++++++++++++++++++++++++++++++++++----
 src/shared/bap.c     | 133 ++++++++++++++++++++++----
 src/shared/bap.h     |   6 ++
 3 files changed, 327 insertions(+), 35 deletions(-)


base-commit: 8f262a27bdf233f142a7bb22bf3f8c6db53debee
-- 
2.39.2

