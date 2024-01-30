Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75082D7B
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629462; cv=fail; b=sGpdSpORmyOStbQdM3J91HQQzbRzjwNfXnJBPt/gMATd6DNNgcHReKSI2XPl5NU4JmMyKAcw+35+Y/W8sgeHZ1+749i8t5G/h8DFgcsq9/7uXBhJ/MPL6+YYIchD+9d0HoG/Vj4HfS87RD9hlOVbHExRyZpvGGKkZF5FQvGm8aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629462; c=relaxed/simple;
	bh=rW7Of4Yb51t4UONKOc/O2yd22+FEmUZE8iLMFi5nooM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Wxyorg5+BPj4+8ERm9tKoVstGAVWEDIGdP77B9f5RQkgeO+HgDZXZ9cnbpvYjcjFUJ0ZwLjEs3bhRoYKaZGr4wK+k+YkFNlUVrXGXb9JVF1h6W/GXq6j7qTGuPgngEVxshcGD897wIqwgvJnTvJgdnHZUWk/Od/AUAFrzz6n+W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WkGE0I5b; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WkGE0I5b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1TjGJzfRLYQPqvd6V5iIQng7+iBvQzZorbM1UG4Zm5gmNMnS5GTw98+JWu+KEhRg1n3m523nBBc5qhi4pNP9uVeccR+8iXoxM9qapUbFt0uJKmOjJNY5oITNUTd2OYrAu1eFpOiaX/5k+9s4vAJ3YhfpsNEtGgFMhikmabFm6a7V2IAhArlW8lgdIqlPLUpYN6aFlldZnmtXFHi5KRas/ScAAqKn++MxinZ11CsPJjTwlgHB6uket8iQA5jB8AQTWWPkf5oO0Hhqq+udmJTdgD2Nobj1e5J0Qt0VBWY/gOr7LEVcLWexbePmZnFJlBmRRaop6OOC6Sye6YWUT+VzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJnB2COuOlMjm+W9RrEryIw1RQlkiD3GaPcHfIfXh9M=;
 b=X/OtONghuxqp+dLZ91Bm2px3COfPUtfQpt1fCpcNNpCq2wI5b6b+DpbZk40A3iQvfjIJWyMnggw4RzZZY8NBL0KgS4GMs6yYEAqiMZSwOsQ68iSnLhzK4lPQCX/wQrg3LsdmOuRsxhBC5oqKWSc6aVLc/BeHuIb0X/875g9+47WX0onPK1UjlqLRMQOyQG5itEQBOk273pMxtY/tSFFX9hUqmBTpEbfG4creD3a2MLJPqkAEiOIp2Nfk6648s+XVmOtLiDWD6TIid2yYV6MMV6doVe0hOO4kKNzcGAiJlydod+08a0Z7WDnVMkGTJnZs+Uh8pK0k/2VWpgHW9aU2Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJnB2COuOlMjm+W9RrEryIw1RQlkiD3GaPcHfIfXh9M=;
 b=WkGE0I5bRRZrj79GAgpJFdTbAWB+bNY+vOoD/yuArrXFb1cx0QQcy2ET+BJOGGau3vD7NqmN2qtXjfS4kJdwjkvNeJhvDzZrMZPk8v383pwHBd6uP+UYn7ZPp44q/zQH5FWrA22EVKarzdLz0+ndlZuDWKULZOcZjGzThB3LmlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8773.eurprd04.prod.outlook.com (2603:10a6:10:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 15:44:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:44:17 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/4] Update bcast ep register and config props
Date: Tue, 30 Jan 2024 17:44:08 +0200
Message-Id: <20240130154412.3157-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:803:64::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8773:EE_
X-MS-Office365-Filtering-Correlation-Id: ded09e66-d36e-41df-390b-08dc21aa515b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BNTbbmKPGoSJM3RvIW69IMDkgFZKDT5tUpVwdapxvlGxt1LniaI/5fTEIEth6blxovfMbL5cCAkFa9Xo+FWfMmsd4WbZili3RdU5uSF99wsjp7xE3YREl9J4KeNylyzT7tDyr6LDaYDqxhv7qCTNi6x9d0ThbH02TPVgiba1/SBiNt59D3Hn1TWNcZehG355d59jtp8A07a+xXQhbIV9APRuQwor7OzD9pF8Udj0fXvvxo77L7ZxiUzvVRcXBcdEDEZtpN+SqFb+5o9QabGHV0tRlqgL1X5sXMBoc7B5FWMyVRMrBQhNRUdXp4TgEUS5YfoFnccad0PBS2CNiPSsMHhgeXh4Dl7TnjmWTNa6RSb9EQbUMbRyb4Hgf7NMWHVxxJg908QWKIIRkyDIrZHL0nncgvV8pXHsWdWo9jQVRy0QU9YwmOMAcDtBiy2krRlJBJFPb0x4GSXVgCu9VGh3PxLoK7i1YvO/LQ08ut7KnVtMOAj6RVg5r2SnUAMyzpT1HeDdSKMSRR6yqwDmds2m+UDBlRu47yeg12bH3VxE6+BetP1B7u2K11gK3mSi0Pgu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(1076003)(2616005)(41300700001)(83380400001)(26005)(6666004)(478600001)(6512007)(6506007)(6486002)(2906002)(66556008)(66476007)(38100700002)(6916009)(66946007)(316002)(4326008)(8676002)(8936002)(15650500001)(36756003)(44832011)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k8W89FgHxjH6SIWgwF5xhvjzPmTsKhB3eZBCFmltFFcePKx4XmrBJCk1Z0Oi?=
 =?us-ascii?Q?k/rI7oepVgk65vccIjXdgMkFaSYaqK2KX8qTF4+fMPirJ7X6ru0R6UqQImer?=
 =?us-ascii?Q?R4ADs1Q3MQP64/OwtLbU+UNeF9WFBjZ4B0ZYuPe9xdSfLu+ep4yGacWAEOOS?=
 =?us-ascii?Q?F3yQfbTjYHvH8rj/MCgqODxehRlW5g01T9TzxZvBCpWcowTzsiUPXk6Hsbj0?=
 =?us-ascii?Q?XUkAKbb8MTN01PneTzXKF2FTqyayb+M7apfrwNTlQTbpPmgwT+Cqqc1Is8tE?=
 =?us-ascii?Q?wbLgXNmGnXLTYL8WiBQOppqhCtayzeb30bA1eL5fsq9wXQylq1JwujnNRvfX?=
 =?us-ascii?Q?DAThiNNVjqlAP1Z4WGci2EzPbWa7ozYTJrgTbgzVFm2MSzajkFhQTagzG7Zu?=
 =?us-ascii?Q?UpAeseeuHVdcxGlyLHFCvBfR7eOJIG9+zXASr7VunXrgg3z7VKaglvKTYMdc?=
 =?us-ascii?Q?QpdauEfhQafayjZf3HqyLCLvywF/JGknpi1tL3/DfUaVXgryZx2JKTX+Qlr7?=
 =?us-ascii?Q?++LLS4H2vuNaJkJAwxjZJtYOy58YI0ZDO7PKi4bJ76frgmmzx7nCcSxeL6pR?=
 =?us-ascii?Q?bEAXM5EK3UNJ8FfQfyrmB8FkORod0bV51HZ85m3pWYMKe2yMRs6ve0Nl+62w?=
 =?us-ascii?Q?6btcBRucFtlyM5QMWuDhIQTlDdq7yFQ+sE5TRoklMXkCIhELmu6gYuynWMs1?=
 =?us-ascii?Q?MnqPHB3VLa52jh5Y/BGoybuwVkmFwjdpvdlIgrsDz8CIlvlWq5q4L+FOmt+P?=
 =?us-ascii?Q?fxM2V9XCKIuB9IZA2gBD3K0NENM5kVh8oiNyfhAGMvu4NV1V/AVc7JfBSdI1?=
 =?us-ascii?Q?adGeoOVc2XzTP14PkDdgLRx5hcgdFeY9IRlwPJhicBHJKSe+0Iyb91KhCOYN?=
 =?us-ascii?Q?+tkZhW0Upvk6iZ1PjHiUmOEjgi8BwRSphfnauogNZF1mG2KXUqPQrJpI03Gf?=
 =?us-ascii?Q?ycmcI/OPSQf95p4aEC7GrwVbF41arLY44jeA63O5IcjwbnaFq+ck257RrxhD?=
 =?us-ascii?Q?J16AtiU69joigUgM5HUNEYxrlfb3ATCvk4qDFhjJeHCuZvGSBxGPJQ3qO5SE?=
 =?us-ascii?Q?pxG+MK7DIyeP8clPyxqSXw/f03sJ7x+vSFuejCuZEY0LHAIGdMm1jynKEDMK?=
 =?us-ascii?Q?I0R54Uu9mtq2Y6ll6D5bQR20YoLa69ANV0lvVX8v5cK/O0CC+Vc8LvPzIicQ?=
 =?us-ascii?Q?SaeSEhmgmkydpJgT93GG0iDKeGXaAdDOm2hwFJb5ofe6EFDk847O0cVhGAPt?=
 =?us-ascii?Q?zhtWOgg2QXVSFUW89cnTC71I5KdqVa5WqLgP5H0P+2eJ/rALgRiQK9xw93XV?=
 =?us-ascii?Q?fToKZunOjiqSszNGZkBARJd0jGkNYNvFeYckh9OXc/9eco7TG4N8LHcsHNVl?=
 =?us-ascii?Q?4pu1YLkojXDNxTWjfRcYtKp85KV8RWo90SeX4xCcPa6sTJ/E6K8Xb8tBpZAr?=
 =?us-ascii?Q?ZQYmq/QXDyRSytdxYAh8EsqugYqXnN2kcUzpcLNCEc49N9Y0Kqbr/js8t0aY?=
 =?us-ascii?Q?qZUzzBwwj0ix3dP3Ya0ydhvyL/oaXgqUE35By8oTdv31ZKzKdcbk1057GUZS?=
 =?us-ascii?Q?5fJgiCBoFmXBEU2d7Ax8iPFk+nnqugeNn/rGmX55r8J6hZm0p/s4iF9w5lrQ?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded09e66-d36e-41df-390b-08dc21aa515b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 15:44:17.3767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNojsIuIKo3oeTZx0nQN3OKlK68GXiOSfI/YEyxC5I8y+OtzHrD9rwx9wT6sdbX9N7s4/WAsEtzErLsDzD+rxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8773

This patch removes unnecessary input prompts from broadcast ep register.
It also adds support to provide stream config options at broadcast
source endpoint config.

This is useful for a broadcast source supporting multiple streams,
since each stream could require a different config.

In client/player, the input prompts have been updated for broadcast
endpoint register and config: At broadcast ep register, the user will
enter the locally supported stream locations and context types.

At broacast source ep config, the user will provide the BIG that the
new stream will be part of, the stream Channel Allocation, and the
metadata of the subgroup to include the stream. These options will be
used to configure the BASE and the BIG.

Iulia Tanasescu (4):
  bap: Parse BIG handle at endpoint config
  shared/bap: Set bcast stream metadata
  shared/lc3: Add macro for Channel Allocation LTV len
  client/player: Update bcast endpoint input prompts

 client/player.c      | 238 ++++++++++++++++++++++++++++++++++---------
 profiles/audio/bap.c |   7 +-
 src/shared/bap.c     |  20 ++--
 src/shared/lc3.h     |   4 +-
 4 files changed, 213 insertions(+), 56 deletions(-)


base-commit: f59f4902bc4ea0bf5f1fed2b1e5e2f4ed52f0cb5
-- 
2.39.2

