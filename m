Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2082.outbound.protection.outlook.com [40.107.247.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB14A18EB7
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jan 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nCJSFm1+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doJ76WJYBkChqaVBUKtp4fGtqSi9qGxHqFr80ag+wThsmYZP0ILwfoIQKgmY2OxdZcXL+6zvo+6/JlLvTVTBexjvTmAlfkqms+8Kotf5z+VFw3zoXLok0cCTuE0rEDLNEiWrya2bHjcszJVAftHVJj1F18mIGndO/BqWhNnW7TFtCZ40QjoP0mfiv2UyZMi4pLDgyQmD9N2N1gqkSrS89cnFMFXA6G9pusstzLdBgn3/6I8AIPRZWUVJpyJ450tcjV/Rkd6UYXUVluUs3Tvr4yRXUU0k+wBWaol0FP8+AisRLDAqHdBDNldbr+heyPy8xPgs2DD6IBa5S0JvNqlkPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+YI35k9RwFjDCiFxcnJo6H/8mKg80ycNX8DPUfQ1Yh4=;
 b=JZulC4bOnxRPG82jVFA9MFDZVuVF9B7f18yL8QwDDwc80cp1B1Xisw4IDlfPUWc3KVBm4rmWvj4Bq4OIFy0EwhMovkgIK2pYbpaZPCxnu5xWEZ/XdR41hYEY2oGM848CkUp3xkF4uMWNwBS0/BlqLnEiIRA8DidUhjk6oguFg0lEh8A0KMQz/esACc2Wkqv4f2EJd5/b/kWbDGN4246nsZK0r9HswnIHset/8/SyPfWX1eRUaO4zdGll8sKt9cs1xvP0n7+WVThJdD3dHayS7txQ8g27sfW929m6wO91p1VEC/ywZVEfFl3RVB39P8QBb10TDvAgN2kd/AgjynvrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YI35k9RwFjDCiFxcnJo6H/8mKg80ycNX8DPUfQ1Yh4=;
 b=nCJSFm1+8OviQv7rNyTxR/ivBIqrqD9iBg2qCYGLEIPM5EpYO3ZPg2nGYgWrZw88qUyX3LgTLMOJLfxwdzWFUAPsrTT3+Qm0MnCbIGL0DDk5A5+m8gKrhDUtHQoldx3ctbZRYp6AOhZPWHeIlRjbIF6pzMvwzo6lNs/uXBoi1nM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU0PR04MB9370.eurprd04.prod.outlook.com (2603:10a6:10:359::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 14:33:38 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%6]) with mapi id 15.20.7135.023; Fri, 5 Jan 2024
 14:33:37 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v2 0/2] Add support for multiple BISes
Date: Fri,  5 Jan 2024 16:33:32 +0200
Message-Id: <20240105143334.7248-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::35) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU0PR04MB9370:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2ab074-aca1-463b-55b6-08dc0dfb4e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NLvkQKIRjDja0DBIVCQkQ0C7+8Ln2LhDUDfRTb2Id1iHbX7aEk9iHxteDqFFQs9Op5Rm7q9jt1zaBlztIMopvwQcgaZ/NPR7FE4NICSdNDV9oFU1+mHLZKObfv8Y9VStl+GttKudN6zmH2nhmlLTyUn9OX7MBADOyRYVLjj7sSTZaKg/z0rCyuxpIutk274BKO7ZruOHrl0JuIHy7BifPzkKC2y0RQn4J3N62o0SslQ4Em+I1uuGTNn6YVcgvNyHKmeK4wILMwjy8A8mJIQsJ26Jgkq2MhvklqpAHjwyCxnA6slwz0U2+3uwflZZYp4sMcgDDeJNocIJSJCoK9+RQfReFi3Wg/qcx9RFcENPimnaFZBQugKfF8egBPijs6bDV71yejmDBfHjTM0JcvIU7JGKrtGFXiTGdzGF5Jiz2rIVdVrVU8hCzN/hz7KMT99J+2Vc9soM42IhJt1pxnYHfddN/KISlCujJ5omV2Q4ZmvnzqsqxXTa3UqWrLe4cYRZSlg6uK+09gwHgwCWCLa0KJ6j6U0WLXYRE0vbEbHvxgx9Ws1MbclJivbrpCPY6h9Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(36756003)(41300700001)(86362001)(6506007)(316002)(6916009)(2616005)(66556008)(66946007)(66476007)(6512007)(6666004)(6486002)(5660300002)(478600001)(83380400001)(8936002)(8676002)(2906002)(1076003)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iEjAzh3m1icU3r6ePFvIkmf/2bUR20w8OJzZ7iL+uxWFc6osdi+WsKdLxFyM?=
 =?us-ascii?Q?agN5o22yDYK0HuPP/LSBpOL69HtfycfKsQ1DxQOG2BrkyKWy+uCqARKi+W+F?=
 =?us-ascii?Q?otvLBJAbTpmaf/xAoM/InK8mUjrFYl4ZFLf2FOADTex2m4v0JWWo56cbkqIe?=
 =?us-ascii?Q?+Z/GYdGaUQxQQusHiNU4Z4XQqIplpjHZRyMqgmj9PbbdvisonqLi4NybqUG8?=
 =?us-ascii?Q?NB1y+IfpNWINh11KmOdHctF91F38Me96xCC3Q7ElXsBptiKa7xryK9Q4uxc5?=
 =?us-ascii?Q?d50tnsgPadKyaCShDLf/jeFn5ju+guCp0cOhZv/mxiF1QvYxKEO5Dz8rNitK?=
 =?us-ascii?Q?Mc0G9vrBgTOg7LTjlLXs9DdzpDrznKfqXWODOg/KdSx20PF0QCRXM9Kuxe86?=
 =?us-ascii?Q?krzGd/ooqgqUBQ36/9yKdw1ake7HN3o0jRw0yD4pns+OeShBZQ2ZS7Xp3jWj?=
 =?us-ascii?Q?2Tk7/VbsbtrsyWTRRv7OGbCSAxVtJDljHyt7v9HfUipVUzwyEfdzIvGWrmzq?=
 =?us-ascii?Q?imE3Zk76Fjyq2c9PoEWD82vWF59tnAt8yBEBtiji5GV7607hzO1zmzRz6nAu?=
 =?us-ascii?Q?ZZtDniGjlr9TOrd8PKo+j2b/sRWRazywLbuAYif2pYQosYC+tTq6zDrm+ruf?=
 =?us-ascii?Q?rSF/5QUMX6NUrNlKFCjSDnUmvCs7AOK+5Fyw5HEf+P8wwQi8KIpo6Xf5Smhw?=
 =?us-ascii?Q?u7cioVeeo39IC8yyis9KVmjYLbynQE6ziEqTUzrtLX497X0NXOZPy2QqOp8j?=
 =?us-ascii?Q?Uli+2Q3MauCFk7Ih4+rAjz0g++kYwr1tGzM2pOTEL3cpbcpwesHYiNmJMqVx?=
 =?us-ascii?Q?/1RXHwVYfkkfRGenfvS5l633HqapifAGkPF5Y+s3HsfDSAxqbC33gPNX1k2o?=
 =?us-ascii?Q?JlhnGsK6P2MgcG9a/5+/sBADPrN55l72EmFQeVskMPHUtrcZaKULgdrk2oij?=
 =?us-ascii?Q?gY08uqBlJAfRrdqxRG7+1KUfbY2Ge5klIBs69YlmaFxPVTS1sOTs5zkCZBJc?=
 =?us-ascii?Q?+iDqLnk5ZiLuUbig0LqnEfgEumPT6qH9domOaZu6VHGX/9+rDM0Jx5jHCALU?=
 =?us-ascii?Q?yWY8Gpe7CsuZpQjcg57oJ/6LdLBlAnZP53wLiJaeLpnSclpb/js1qvh0z7GO?=
 =?us-ascii?Q?68l/r61g2kEb0MBZLAGNnmCYW4MvSUOcLXe1Ar5DI2oDl5di2r9CqQF/MDov?=
 =?us-ascii?Q?GiSmc4yci4OQWg4w/BYhHHMs1hKe6UC7NZcg704mzCLIMdzG/EzZhueP91ph?=
 =?us-ascii?Q?0l4tXCnEpxX0tXkqCMh5aNHx3UfWYMqpvtuSvv+UN3+ESQCjIh8BHJUHk2km?=
 =?us-ascii?Q?+x2CF+u5VMY4/tffWqa3kre1I32Wmp0BRaudxKhKmgCtagCLoHUUv37f/tOc?=
 =?us-ascii?Q?r+n77mRbjXs7k/8K7u9cTA2bF/RFf2A0CJfntoYlvTmfXZFgKgpWVGKjabPU?=
 =?us-ascii?Q?dqx3HP5tLtpVkDXQRVcJiWtUiUcw9A6dBpmQ+yKDDJhW4oQ4pk71kZWI2cyw?=
 =?us-ascii?Q?J69gwVzm2OZboE9ryThc4NZ8GrOGp05DviNDJeevt8w9b5OPJxsHj3Itf/S2?=
 =?us-ascii?Q?DdeUj8TTmogBQSUa6e8AWUwwmjx4TCfvm3PCH1wdI+ktMB0Wk+Pa0CWrfAhL?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2ab074-aca1-463b-55b6-08dc0dfb4e12
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 14:33:37.8783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16LhCF7Jb7xJoB2lEyNWFJDQEG7t/hZzkxoi5o9gafAGqoIhSXo44DvloIZNOeuDRR8S8v9amXsArGiwvBMDpsGv1OVvJbx70obeO/ngcaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9370

This patch adds support for broadcasting multiple BIes and broadcast
source BASE generation in Bluez.
To start a broadcast source:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
configure multiple BISes with endpoint.config command on each
newly created endpoint
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 24_2_1
endpoint.config /org/bluez/hci0/pac_bcast1 /local/endpoint/ep0 16_2_1
each endpoint.config command will create a new transport for that BIS

Use transport.acquired command on each created transport to start the source
transport.acquire /org/bluez/hci0/pac_bcast0/fd0 
transport.acquire /org/bluez/hci0/pac_bcast1/fd1

Use transport.send command to send data on each BIS

To sink to a source on a broadcast sink:
endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
Use the scan command to scan for broadcast sources
When a broadcast source is found will automatically read
the BASE of the source.
For each BIS that meats the sink requirements will create an endpoint
Endpoint /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast0 
Endpoint /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast1

To sink with one BIS use the
 endpoint.config /org/bluez/hci0/dev_37_8A_1F_26_A1_0F/pac_bcast0
/local/endpoint/ep0 preset

Silviu Florian Barbulescu (2):
  client/player.c: Remove hardcoded base and QoS for broadcast and use
    presets instead Remove BIG, BIS, and context from the register
    endpoint command for Broadcast Add Location and Metadata support for
    endpoint config for broadcast source
  bap.c: Add support for multiple BISes. Update broadcast to support the
    new setup structure. Change broadcast code from iovec struct to byte
    array. Add adapter property for broadcast endpoint. Make broadcast
    sink to select broadcast source BISes based on pac broadcast sink
    properties.

 client/player.c            |  301 ++++++---
 profiles/audio/bap.c       | 1273 ++++++++++++++++++++++++++++++------
 profiles/audio/transport.c |   25 +-
 src/shared/bap.c           |  441 ++++++++++++-
 src/shared/bap.h           |   36 +-
 5 files changed, 1744 insertions(+), 332 deletions(-)


base-commit: 1c321baca7815cd7727eff89b2307d27d328fdbe
-- 
2.39.2

