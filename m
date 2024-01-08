Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAAE54659
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PywP8fpl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PicQyK4UkF5+jkuT2B4LIsHjAEabUgxdcm0LbsRQkwifB4QFoA2fSt32uY0TeFsZhReOgADW7nb3/Eahz0gbGMUwV4wHsrS7a8z3VzIQVFESp0bHpvwzFqRbdRFotHZa27qSUfRXoFPlmpkmpmJsssGgSXhFJiFdctirZmkFLLyMDn2/xmlSRpeUF3w0JmbjWMqmydwKyMVYT47ywxThfT1tRdK1qdRAgemHqSdb3kZRM3PNyynMkSY32LtnIWmUJ82WZRe7HSjUBo96b67PjZXxd0u5kEBbcsvODAMSM62SMMwOmLT/cvUmEZ2UGuY2OO0iYkn4qWQU7OhhZ7rK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ojD5MWEWd3cXEBH0z7ruVZLMdsvZe6JAEmedTWi9BQ=;
 b=Yyrg1A9kcWXLmAc2wTpajcJCFJT7RlwAiTwArTK07CkKk2XGm8H5Bfq7jTdJ3EoN20eDHpRvPUNEqKt/MetXLRS81GIbYr6F/s4zvBAUrfrLjvz/sN9nHKvK3C6VY8cy3hw1FR1BK9eCzd48l2/ehhRe8JI0D0HKPOuSgURHHnZJ+kTGsDMBCKe2J6zNvC/CUZjP5kkR96ua2TmF+uN1HSnLlJcH+NR3lC4mAz+acUW+GABx6S8pT48kNps/A5Q80YeRc/qqx1N0vQvo/leM5F3Gp8Ma2LezQqh9LW4X3qSpqyWB7V5C97rSnDruJfKczj4cx9ontIjzcqyF22CcuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ojD5MWEWd3cXEBH0z7ruVZLMdsvZe6JAEmedTWi9BQ=;
 b=PywP8fplIV4DYwOXTIgMzIEC9MUEW0YStrkeZbM8YKbV5YfQS0fCMkKO9I30E8WfBMFErMUW9CELdOoi7DNq3LyZIHqmCD9np/nuzsp7AgRT6p1hBtMfj9A17xhM3Yy7pEoy884QntJw1HTWFoZ2BKzZ8WU8seoWFEr1T+x0yh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 16:43:08 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 16:43:08 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v3 0/3] Add support for multiple BISes
Date: Mon,  8 Jan 2024 18:42:55 +0200
Message-Id: <20240108164258.77332-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::8) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c5e602-600d-48b0-48c7-08dc1068e4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f1IqXXMkke/dGh+QvafxcMV2nCQM4S+1kh80ma5CJjmYzxxj4O1QjlH/4+YVo+9noaOehsCjiY00SRnYazzt2pz8rnbJFAx1ou6Ge+mCX6CxhUFYkr8oN4GZN85giuS+ncGgWsPIgKpnsy2O9ycQifpB0owyd8LXYqPk3pPJJS2HShnP60ZJ5SSbdNNKsx9UgMuInoRTbjTODW1sEsGp+O0u1HqONFjh8K8FxP393mmvnys+WELSQPRc8SkTi52Q9RRpM4VPZmyHNLmlFoGBHTmwzP3bGKE+9+zdpMuTGj5NzVt+2T43mYIJ7YRf4FfDjLW7Ejwsb1KMGP2k8ZwT4002N71n9IBdJc/M4fJmKe8rtYj514qM3Ymhzkm3V+yDfKUpVzLLMUVMytnc9pszTiCu0eFrBOyO8pIllX5USs0Cr/GERnzowYPIE8B8scM7k/+Klm6IWb3AVJoXIae3FeV2xY+UMRy13cPotsuN2kP2NHgfRVlsH1Cjc0UL9/XrGobCzA5JKLkhKcM2hfEjfbsR+bDw67y3TFaxQA49Jd9yrh0C0sKMMtFEcbysHnbt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66476007)(66556008)(316002)(8936002)(8676002)(1076003)(26005)(478600001)(2616005)(83380400001)(6916009)(2906002)(5660300002)(41300700001)(38100700002)(4326008)(86362001)(6666004)(6512007)(6506007)(6486002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EuFlHCFoZ5ePmnvlhrkFnShehkeQWH8Aizf1yAKa0+MrZIWyqZCzeGZ0AOVz?=
 =?us-ascii?Q?/G1mMbfz3a6xEXaxVmH5WjBz3ReNhBxbuYLrbGboaX7S13w+sgCjoe2OlEqu?=
 =?us-ascii?Q?wblDHR1Pjfz7cEW/rpR2VxhQLwg3t6rBk41fJX2IAEtSnpT/uLOXstcCi9E9?=
 =?us-ascii?Q?hDTK9t5mNSPYWUlsZtSxQ6ytg3DYcxWf/8juEphvGognLAu4v7/5ccWra/XB?=
 =?us-ascii?Q?aKqoxPejY58cqu8WhQvZ6YZBcMMriEoUYL8ffCPl80vPp5+qQCRNzCjKQ+KW?=
 =?us-ascii?Q?saqS/+Q0tdOJdmmidXjhicnJz7qniexnI8wibcd/+GrkUI1/xnhIXXgeihre?=
 =?us-ascii?Q?zJ+gftXPYaW+NRLZ/Cec8YHQNnC/JIO97AUqDfdR8wGPaSJHT7MC9dOwzu14?=
 =?us-ascii?Q?FIBOMlAzXIxhVjpSQ1i6cHz/lsA0CRju4mxI48yol1u1K8cLcewAgO6BT4Cy?=
 =?us-ascii?Q?Ih98xB9yntx6hx5PsWJY2xjxEpIYsFC2dA5czYsySpXU4YxQxJdR/JiFgabN?=
 =?us-ascii?Q?gukMjZNSWOoz9kBS6vtK2xQPL/9zf2X8INLSIyG9Apbvkx+2rw8tsCzzqbxh?=
 =?us-ascii?Q?xPTHwYr9WpeLvLE2wy6+JdS9/0uxcBshFV9mAHovL7QHhV9d+umPZXerf/8+?=
 =?us-ascii?Q?gpUES8X0xpzaHO0nPvSXcriodRnTtYyBZ6ogAtJiO4B3sINax7DuQpQwkDAN?=
 =?us-ascii?Q?nmG4vUTqARDpKXMqxvcHFJFUNFGLoMJVU/2TdIaJXtPLJdQY+zAebjEM/LLV?=
 =?us-ascii?Q?EDzyHmWYo0fg6VEMjK329AjNIhIfYoHtMXNmz3x8qLoaTJpKjhMpQ3eP3Fve?=
 =?us-ascii?Q?ovWgy4ibO+WUVOgIXnaN2z6c9lcZcYFCXZa1/pVkNjkHPq9asjzSgvXNEtcu?=
 =?us-ascii?Q?KnfstUM0vUzEWZksS4+uEzR1dwjesEeF/YRzZl5F/LuFkQ35cc/DYZHETVf8?=
 =?us-ascii?Q?oeQfrTjVPXw8fRGYFh/Pdo2oJ1lQb2J8gFgcRkg+ZRjJHb5TN0MTnA4bZZ2B?=
 =?us-ascii?Q?vh+WCg5TXBSQAvhnpuHQKFhJ88b8omvAluvUF4r2Lm0wRaipoJRC6RsbXTnf?=
 =?us-ascii?Q?NQeUxDTV2S1XKGb4KdPyt1rqun7Iim8ksZM8D3q7+z3aEKR9LHViUJ+n1Qoa?=
 =?us-ascii?Q?WJMpunBD2mXPjJRc5EntelQAd4JqD946qMZAfKpfmZLONq4jeTRSzCW4PsMB?=
 =?us-ascii?Q?QusXEqlM34mxziWRC97SPlqrKKY2+rKUlT+FVeY40EBuoqdmyftBVbO9I0yD?=
 =?us-ascii?Q?GRXKeDpAhg9dLAUGflwhpxpbLeRPHq2BKfqPUuus3okfBQQHI8neE7k5fco3?=
 =?us-ascii?Q?DVJ4RdI7SB1mxZFVdk37TL0ReLHok7rkTiRbtlvWJiGxuzH7YcgdEnFGewAB?=
 =?us-ascii?Q?2Qw3eQrOGKiM4FhczKLLfVaNiY1hp/KydLbOrVDtGNr9PDwBfpHyocBkyPpz?=
 =?us-ascii?Q?q4aEKMB8LIgOmkfFaUtnCns4M7EpTdhsEYqUOjddbJxhNnqO0wJk+bVXBNA3?=
 =?us-ascii?Q?kERcYPkmLJpsCpsvRqhYeP/XREycelG+YCzm5U+7ZeLEMVoTHgCvqzjrp+W6?=
 =?us-ascii?Q?mi740zzYUQTUVrBF1sEYqN5+d+hhZE7qx+MqT6LkS3jcv8Q9mSzMyeQ1lLuo?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c5e602-600d-48b0-48c7-08dc1068e4ca
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 16:43:08.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etDvG7lxJINkiiccxy6VGLuKlxI4uIAR4YzInYB7xDQojQTrWoLTDOzDI5AO4RBNZ7ztccytZR44SwvA6cJZ9QSnY8NT+xpFUZ9wf2h4wfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797

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

 client/player.c            |  309 ++++++---
 profiles/audio/bap.c       | 1273 ++++++++++++++++++++++++++++++------
 profiles/audio/transport.c |   25 +-
 src/shared/bap.c           |  441 ++++++++++++-
 src/shared/bap.h           |   36 +-
 5 files changed, 1752 insertions(+), 332 deletions(-)


base-commit: c85546cba715afee020e61bd0a44499e618d0371
-- 
2.39.2

