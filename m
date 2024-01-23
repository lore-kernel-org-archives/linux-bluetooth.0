Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FED5C909
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014314; cv=fail; b=F0HsGhGIRXUH7WgC3t51g5tnGnB6ub5BelaJ0MaiIrwd9GbZvjIF99tj8hFK9teCFQzAn0nmjDRpCPW60DinfxxNrtt1+PqLmVBxAatDHBRzIeYXg5Cu2R/yMWtf0dDOoLEimqJQWk02kjlJt1mYFuZ6RSkOiv0y+4+0tFRAifw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014314; c=relaxed/simple;
	bh=xkyvXRaAG+BiNzbC3Zx378WeyhqcEY3EeSa3gh3cqjU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K31jCqDHfyjnyu4PHlBrE179Ug1z5ERZfrf1i5B2dLq068XNHyzLq7xL5ki41oOOOmlj7S/wSzB4QQ4rXhWFHbb5CPYdI/7WOzvztUxs3YI+UROA5AIYv7B2hUeMunSHdebWQ7heS5SdIh55Qy3hsy8j9rOz/F/ThFKhLFEM4jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xg3xhPHJ; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xg3xhPHJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPUDwH/0fuxxa7eB1Sy+ZnTYcWO7sKYN+nyqcAeYHTeV7tqcZPcOgVCwRi6u+M70L6qEuTBJvg81XKgbuzPrj3uska3eg0LqjkZrpOU8QZakQCDdcTdlrjmQM7TQM8k/Ow5uw+quddkRz9p7/nIc6vbE4g6+9m8ZvVXE3V5i1EJFv5rG+Bpq1XP53jP72u6BHxJhZpTVa/xhbi0YBxDF9mfbcc0aMlsN4LizWBia8SNvd5Itjq3pbuIyUEZwa1Wn7cKrJ5deBu7ZDjvIBm7M2BivHcZneS8E89CR48lAKc3nnwlMG3UXjfO0Q16yxgw9u7xdW4ZTQToayb/AuYlh4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frKwbfy6NsXx6ASIuIW4ob7SRGHD1fJ5gCHlNPns7lU=;
 b=jCvs7kd4okpOvhoy39Q3YrP1Cw8ZLX2nPWaHiEb7NmeNDHMYlR7szvQ3GQ2O5bHO2QeLIyKozX6xTk3hxPwYwv/Bpbut5r/EfBDDYGdstW/A6Qy4UIiH6xUnVky30Edlpi7pOcU9nhEnQf9cWkyhC25CLp8kfl/vysn4OSxT5tTGvNBr98MQvPcDrQecDe+BzUJpQNnloujxlt4pWZBpHHB3WBRe1TQpf9KcnfUpVPX4N2VYFGt2FqIpF0GqMUSycwtt6Mg5zWmRGe6yGfTyfbhZt7dfI2IZ0aZt92a881iUZH/7WoVecxckZuuMIGYMQ5pNAsohB3YdtkeVtLdjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frKwbfy6NsXx6ASIuIW4ob7SRGHD1fJ5gCHlNPns7lU=;
 b=Xg3xhPHJNYCXIr6qSAO93pOvsyzbGixYDFbfOybWFSPJpu5h/m6KtfzK4TD7AGF9O5nXSU2B/t/z+9eGwBd1fFwkKnuCliBtTP/jnThlJ/dRm8TRkB4RBFHmga0hGHOomLqpM2WwDNU9ZjdEImUcqqLEMLaD08p3olmgBha7FRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 12:51:49 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 12:51:49 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 0/3] Add code to support dynamically generated BASE
Date: Tue, 23 Jan 2024 14:51:42 +0200
Message-Id: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0051.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::31) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: affdfc55-d3ef-4239-e848-08dc1c12107b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	I106CjizIHEXHySGPVcZy3Qq3AEyV6doQ+MOGgpBOUTAlwMwwmPzr5n04k3Y3h2ss+jLSi8CHSihOVRdI2uKP7EfBhUay4NlFFc8Zh7qngCfstGPztEZt7yAwIyjT7mSkn9TFfoeCQKlu7rt7VhWzViD0i4VDzqC31qjfT4T7bkOd6A1BfJEF/TIw8NPEBeTdZfkRtrTYSD0FCUxsWy2c4Mj9tnnCmvubp7Cph4znbWZkekStz/rOoUMffK9A+wm2d68bYAT0bVUFjmN+v3BgcMryo7jiDDxBy0AFCWbkD1qoWUuMNGRupSj5R7mSuyKtRV3mbtEsUIjjnJKvk3kUp3X29IHVsxMJv9VSpdUR821A8dnUy/jEESVtGE0BYvzNv4T0LyGWRfYLMRiF2AvbEyf8kiaIbXW7fRCTUah4k3TZVEzvvSTtSoRnqe3qDnn6XNvGKKOQ2Eqaaasc/Mc14hmgMH1721zhy3wMmMnFKUGS92QwfL1BEV9Ub4sqzEsDhTbB7u4jMGOVyiWv8KaxTGg8iV4JNzmRpW2oOvQl0M9Ip0qRgm7ZhGdISpe8o4m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(8676002)(8936002)(4326008)(4744005)(2906002)(41300700001)(1076003)(83380400001)(6512007)(6506007)(6486002)(478600001)(6666004)(26005)(2616005)(86362001)(38100700002)(36756003)(316002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ct1xCJMb6wIWuTgHLeOEADySrfYKFZy8Tqq0M4ulvk+uWiFmD5aDSUon5fB4?=
 =?us-ascii?Q?Qzn6O1XtLI1kl0BBDvS+1jx0AUen6AAyxGck4zWmVETzUn2pjlqAHoTTi/NS?=
 =?us-ascii?Q?8pqINi+1hWSvYEUB+k4xe672nq0CQfp1DaSwvhMgZVqezVt+zJg6+XVI3IdH?=
 =?us-ascii?Q?wLgtgj+FgNtVwJY+hw4HnoURzj/eHJIXOqO1OMUX6g6VBcnsqwg7oNwA799y?=
 =?us-ascii?Q?g1fGHdN4Euq495SgoxDIJDgtYlOIPoh6SdE30zTPX7JYjikr9dswgsYWxkjF?=
 =?us-ascii?Q?yft9Ir8QMVKdmkPk5m0bd8YCZSpYj15t8EQbhwS9zvOJ6l96U/GK0i5olWEJ?=
 =?us-ascii?Q?ULO+FMONHJIHZb8L8tstCVDweHKm5OE1EXaUWUXQTMwkbVdbq7O0F56TMbPS?=
 =?us-ascii?Q?6julgC5gzSFyRay50k50F2/sbk1u4oaa9COEEaKtAonWPaPFEFMrlMEvwDXf?=
 =?us-ascii?Q?rulnzC6UhOpNLNk6G89JVH4NLST8nxHpYOEz5Ju42p8UnMvCDP8RaOp5t65c?=
 =?us-ascii?Q?62zfi4RcsZBlFvAXSs6Y6vpgxvZCz//u4tnjUdAHlpTsdzbrvpFFwXVov7dF?=
 =?us-ascii?Q?BWo4mRChHVKjxE7h4ZaWRKDciouZRRLehxOhGFd3oq70lzEoRDf9wQu6pTLb?=
 =?us-ascii?Q?OU9ZISV0glVUh7BW9DN3JWdXYMqPK5Sixx4UDYxhIusgFlnRBvzP4J8ogXhv?=
 =?us-ascii?Q?7yZHNR4tNyAV+L0NBt5d7LVw0uFpJb4sxzu3S4Y50fK9DRY7qmX4jlxjVLdU?=
 =?us-ascii?Q?jVRKJ/oEibsHFvVyuJ2lOBD4BZ9wpKZX9lhb+Y/g6mWmkU6U3xWu8bXiiKa2?=
 =?us-ascii?Q?+ZYPcOKkeW1Umto+ryvJjndYtTs7IAazHFfeJzDqOp2OoBdKVpp64GSk7rBJ?=
 =?us-ascii?Q?wa7yzU0PzkuI0iggGYZKq2dhaTTECDDXd4P9Z1bxeQGSJLW25EayBMWOF//c?=
 =?us-ascii?Q?fdseudYTupa4+MJIpLQbOebwwzSn25ZQqgFDabI8NzOc7Kin08t8LxbB3oan?=
 =?us-ascii?Q?pwNTO/Kj+z6xEq4jfSpKENdgZvNgdZ00lBlDqvW6Qgf5hEZiBbbomoyygTkw?=
 =?us-ascii?Q?TBykNby2GfFWTBcK4224pqt4mv9q6o+1VR0pyExKsuk74Pn/PR5zbx9dzlaF?=
 =?us-ascii?Q?VDCXi0hLVoVaIf6cFYo8jx+sMzSlcvjPShMExPhjMvDozO7D5UwfSPVKU+iz?=
 =?us-ascii?Q?UNf7fwOCZloOQfDmCbwFDwkvcXTV9rdN5yK+ZQFUwpPKtKwalYVWvGL28NYO?=
 =?us-ascii?Q?wbx4TRwfTZLzZ627hmE1Fq2k7GelL/BA6lzceux3Ag72hpLwD6g/WFC8csDO?=
 =?us-ascii?Q?J2Ye4tmZ1GgvKZzEERcsluriB2HKRamQYILNwU8RwQZcC2dDBKzPDqGMhTa6?=
 =?us-ascii?Q?sIXoHnuncz40ABKPrSl2t5VWSbDzsrjNbraJkbaOVfGwfgZPFNffgepcLMhK?=
 =?us-ascii?Q?R9lzwV4SBgD84KA1TUEkAd1nGNZGOIuEqRe7Q7Wze3YrKhoqcXkoW2/QBzJ9?=
 =?us-ascii?Q?6ea4P0e9iEgu/1uUwQwu1hr/oZ0G3q6btwW55TPZqeyvh2goHOWJVt6U0A9R?=
 =?us-ascii?Q?OGi4dbqEtAhOnvuPyd5W/vYXFpuJkEv6i1Jc8n+plErMyG3ok9gannU7XYYP?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affdfc55-d3ef-4239-e848-08dc1c12107b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 12:51:49.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: at4Qw4ny8Vaw7luIuc5NYTQClBpCC0JTKOgUg9meeTV1i5mJJ+82xzYgxPsFHOjZJgCDqkCem+3FD232kDWSZ3awNQMfcsTD7nQzbibrXrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864

This removes hardcoded BASE from client/player and adds support to
dynamically generate BASE from preset provided when configuring
a broadcast source endpoint.

Silviu Florian Barbulescu (3):
  shared/bap: Add code to support dynamically generated BASE from
    presets
  client/player:Remove hardcoded BASE for broadcast to use presets
  bap: Use the information in SetConfiguration to generate BASE

 client/player.c      | 153 +++++++++---------
 profiles/audio/bap.c |  21 +--
 src/shared/bap.c     | 364 +++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h     |   2 +
 4 files changed, 449 insertions(+), 91 deletions(-)


base-commit: a9d1f6f6a625607de6c3f5b7a40a3aac5f36c02b
-- 
2.39.2

