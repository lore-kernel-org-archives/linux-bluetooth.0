Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146B482DC
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L1CEfA84"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efMjBxHbF6Rf4UAtGX+3pU2Qj7LwS9HlOizozFA+LTJieIDmYoq8d0cC9ygxFeGoK66cWKcC3bRERnUpWWSTi397GQGFR1Bi+8CNJiH9dOCocvqdC3CLtw/wldS1YbVjVTh8ghb6NilVPYP4YcNVCTGQMrlAUzXoVVxSDsyn21nNTzLvcomcCUA39RvFBkYpz0wt5EFkdiQFOzIBI+Ep4trgAnIvMAq8hG8Re5RBmFvd1gaZkejBXS62148CXkGQq8SK0Pkv+PrIufeklUAEsYEBM7MTTgp2AgINu2A0Retod1lKScpnc/cuh7V2Ran/JRQ2DQ+oFKj8wAa8zTOW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoOEDv+ug4JNIFA+grF7dkph0PWujyp8X9piLnWdXoA=;
 b=Pgwplyzkat2H2n1ybN3zZw//qVkuCRfokL/6KXKzfQUO4URuTEF3attxgL4Dq++7NSgvCWj/odTLXuAeD3IouxyGH7ymzUqby3nLIlrUJi6HB7jtUPZXuNPm+TrLOcbkSqqdMAvjEt7w8Vm7vVP3t3ht9XWz8HZuMkCfOd+H8mg5aJmT9F5QD/GAa9fs2wiMjJgegyek5TG6X8qu9DQEmWzgfRWt2v6kNam/UGjIKosdDNW83jYW9nRplQfMlJDS7XhKYYwf1CE7XbZOyLWzkXMve2cjIrLAwSsuDp0WKWe9G2TwwYejzbXSSudtjULfQn2q10C+Cj6Yo2XhuuhQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoOEDv+ug4JNIFA+grF7dkph0PWujyp8X9piLnWdXoA=;
 b=L1CEfA84/XCSJIIQckKbxKVUpgv59PFqZBu2eJZJcFFZHhKLHKXxZFZ1Yfl7rpwf4Ln65GRZCZPArPi6EvCbIJIG+1XKvaHrZHKoniC+C9soorECEZKp9TCvgVpHo2eYIKRIQvETmMftV3cSarFnH46SRSLpIq1SP0aFUUHdrAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 16:58:30 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:58:30 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v5 0/3] Add support for multiple BISes
Date: Wed, 10 Jan 2024 18:58:21 +0200
Message-Id: <20240110165824.114022-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: dabde497-81da-45d0-9b05-08dc11fd5f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/hFG6Xr2FZx41o13skQs/s6IWKx7LqekdIH+MwjW1JhBaJidDX+DELLR3LJoMmeOxmM224cV5AqbeaaAbwX1QUeR2gA+UAtvRJduvqcltw5C7RfrvVHvO4j/+P7syMj6hoG4sNTa8h6rOvVpDF86TQDZ+ZnqlcOQrRV+5naY/cslfzMYsj+RXhg8x0GDmILSdfjzpONTh4StXy1JZeoO/c2+O+1FMRHo1Dbg1xklRIyjTwHw5wOx2rScvNFOHCNszS0WaXA/nPFBVWcJwm9bG1419PpbWF2NV39+zYfOKN7oF+pH2V/z2JXUb8jU2Sr6heIFyExb6BfyYYGeDwh512B/ZO06INAeGobUnTOZlVMtB/Rw7zdkL8hdZoRiEhde4V3L6DtBqmmv4IS+K8q8MtHpXpktPh4TFen/T1Ys4KlwOpxwEqwBC2yObdjRFQ+GawW4SLsFNC5DWy5qtYvHniPQPy73vkNh7IZl4rYaHs80T70tDLfzOpQ5lMWgk1caTgBMAql+FlyDy8w6AUQuasPEDB+YgMWZpDzfyVUdqvaD1YD3+tCOMDKe0uwIZS8y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(36756003)(86362001)(38100700002)(66946007)(2616005)(1076003)(26005)(6512007)(6486002)(2906002)(6916009)(66556008)(66476007)(478600001)(316002)(8936002)(6506007)(6666004)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rcJ0WQSXr4XNRlxGiVA0S0ZxSZ+r1THwWARh2DzZXsFTFXxOLjIZ1bCQRtOi?=
 =?us-ascii?Q?Z5agA+zBG3Tfi3PTsmiGq/eKLF5hi9NkL5KP0rLtl978YplEyAIwHHA6+vAA?=
 =?us-ascii?Q?tnrWvYUmxUlWI1gVrRBZwZ8cGzIqe2slMUyo5nQ7th/cYiB6ud18aMJkDNjf?=
 =?us-ascii?Q?cr2dOq+NJJtHrQUgQAVmBUnKcmTpHkg5NYqWnJS8ceh4JlpNA5ETXv9XJk0f?=
 =?us-ascii?Q?cdS1K2gCTK0YoYQz8nWUFb7ra7U+qck8AHlY2xXiYyNNV75XwML8OON4p6xQ?=
 =?us-ascii?Q?xChT97AMsfBHh/tIkHsUYyWBmhPxpKDPDNAkWjdBqUuLyUn6laDthXckl/gL?=
 =?us-ascii?Q?immyCNNAhhMsu21QLcEjBc8eLO/pW2LRqf69sq+ZKlTlROC++n1z7P78LDV+?=
 =?us-ascii?Q?TjWBQJlezuHk4L9n1F7nXts/HYzA5dYf6+SiDiCd3MEbmT8+t7cGH96H27xj?=
 =?us-ascii?Q?LDwiXIsUW6bJAJ1skvdQceaWZDbjoqsVyXCndmYbtwKZ4norHq4Q3vwlby80?=
 =?us-ascii?Q?fidyfoeaxHNmIa95fGQW+1DojHNS+mXxnwls7xCR8Y3/Da8UiF9tZkCoRKhI?=
 =?us-ascii?Q?8LYrqPhUwVLZ3orK4nsnf3RpyAXFPTVdQTaMlAr+65MHrho24SQU8lYcc04H?=
 =?us-ascii?Q?VyoscuZJqXM1XWz8Yk5lw3Yxyo2YqrMcZHgcNyq5kxDhuWb0D61exRZDEgSJ?=
 =?us-ascii?Q?5c2xSpBBgylSSXHMj1EgzLrzdzXtbkimqMOCO3KvA1itf1J0Tn3VmYd9Qjp3?=
 =?us-ascii?Q?rPLNIN16PMjmhISYb5tN+jYfiqTeFq05hL2z7TU4iw9PqIgLHF4dfGTGDZns?=
 =?us-ascii?Q?poHPU3/aZxcfUHoDqhWh9RPunUMkKFhNFp98zmum4SqFMYdpDGq9bC/KDb0d?=
 =?us-ascii?Q?PDQV1H6UKP3/nTU45hNMxj7xhDTFg9Ua3tCrch1ftNP1ghqjBXj05atQ96q5?=
 =?us-ascii?Q?OEk254YNbis+zoJ5ScpMLSq1RilaRnJj24OdgpiSSmZyuLqGGxsREV01LPx3?=
 =?us-ascii?Q?QvAtEO/q3RKV1s4Hzgk9jp2Cnu6M+2/t7OApRimCUtf1HYiXxSxh0J+ebJBb?=
 =?us-ascii?Q?vUpPsHzTAoz2CMzqXVxD79DCv0uezbhzzSF2DKDhkO4vW314BQcXd8YGZ4PS?=
 =?us-ascii?Q?6klrAyCl4gpsaOyn1gZjuosuUXHYBQZBuyD820Gq0jSB8b1P93pO2C/5khqa?=
 =?us-ascii?Q?ug5deQ+iAZKTb/3jCmMWesKD8RQ/9wdjQxnyrIETMI3IgNKflwdGX5J0tcmW?=
 =?us-ascii?Q?ke547zOEhmAnjXFvWNPxQU2cvtT137o2EGpXC8YMwz9G6px0aMwiBHd/lf0s?=
 =?us-ascii?Q?FSc8mWMb3GIuqRYidA5lIxLNChT9Xnx1p+LNwV012Re99HgH4A5EQ5paWux8?=
 =?us-ascii?Q?2lBWc8WblBq1IJ2ZvjKgrRwZFOpsSEhV5qV06dg7f/BuoaB6MThh4TDj9PVu?=
 =?us-ascii?Q?lHWsRHzwmUGk2VcfuD9Z+fVdPllX7vmA9g9aiLpl/qu3Qzqphx0PmpwXmRN0?=
 =?us-ascii?Q?FgTH2gf2nmOMpUdwGchHqCh8p0uRxcvy3Z53KEPsElirncesz/cYINxm/gX/?=
 =?us-ascii?Q?lyaaNAp+MFh5BWC8EZrGdFCdkSpN0EErtW8BwmYOzA1iBuZNRClb9hJs0xRt?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabde497-81da-45d0-9b05-08dc11fd5f55
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:58:30.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGDf1/3JiTNdnqHo4xhfZt0SZEehchzxpCR/jx2clE2KJAezChtgbgiLlPATkdGbMx0a9xSjoa2HxnBvi6FKxjnIblOLcXD3GqX/nn8jt7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539

This patch adds support for broadcasting multiple BIes and broadcast
source BASE generation in Bluez.
To start a broadcast source:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
configure multiple BISes with endpoint.config command on each
newly created endpoint
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 24_2_1
endpoint.config /org/bluez/hci0/pac_bcast1 /local/endpoint/ep0 16_2_1
each endpoint.config command will create a new transport for that BIS

Use transport.acquired command on each created transport
to start the source
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

Silviu Florian Barbulescu (3):
  client/player.c: Remove hardcoded base and QoS for broadcast and use
    presets instead. Remove BIG, BIS, and context from the register
    endpoint command for Broadcast. Add Location and Metadata support
    for endpoint config for broadcast source.
  bap.c: Add support for multiple BISes. Update broadcast to support the
    new setup structure. Change broadcast code from iovec struct to byte
    array. Add adapter property for broadcast endpoint. Make broadcast
    sink to select broadcast source BISes based on pac broadcast sink
    properties.
  client/player.c:Adjust the SDU size based on the number of locations
    for broadcast BISes

 client/player.c            | 309 ++++++++----
 profiles/audio/bap.c       | 850 ++++++++++++++++++++++++--------
 profiles/audio/transport.c |  25 +-
 src/shared/bap.c           | 958 +++++++++++++++++++++++++++++++++++--
 src/shared/bap.h           |  42 +-
 5 files changed, 1847 insertions(+), 337 deletions(-)


base-commit: c85546cba715afee020e61bd0a44499e618d0371
-- 
2.39.2

