Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2050.outbound.protection.outlook.com [40.107.247.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AF26AA83
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669487; cv=fail; b=LcQINJMHNp5OMfizsnhDx/Lzs+JZQns5WZumDJ4qPj/eQrmJbb5q3YoNde04ROxrCg70mAjnIJ+/w/MQdsG5lzhEeJ4DogHwiOHYeFaaqzfXfAF8MAMrJop0hLunXpgtmYLTN8mktQPwb1I+d57RTA8VyX6F1UxBa8kc3DYyyFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669487; c=relaxed/simple;
	bh=wfZ5j8D1XfA6yb+X9VDsm3ojTju+3AnHGq7z6oeBU44=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Fr3KElgF9H4rHXEGJEqej9/qsHyqvt6UDpD1aR66/8BLMKc1gR4WOJkdYE1GeMwlcVe6Xn0ymG0fd/E/jQCEp2TecKXj+fpWPq3SIAZSyFIz+nh+9Oszq1IB1pUJh1uNlMZn0xM/ch44tL69ptJVP1JWJDglE1SUFPLN3YP6Wyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ENO5Hf5Y; arc=fail smtp.client-ip=40.107.247.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ENO5Hf5Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQyhWmEeXW8o9h2VleZSxnW79zOdYNbo5r3cpZbUUR4/ySlTqmUn5gLyEEA0zy8wL8Ky7ud55IwkeKx1YROoMHVr50Pw3Oq13XAI3oDz9kNbrNQMB+qKMh7bjWVgcXdTNLZUkngBkrx7gJK0qCZZv57Vx1G5t4QYBR4BglaBED2dvp1CHRHWucGjyvgyoe9zGaMQYT1rvTwzDy3rEYeqGSb41q3bRCrvfp/fxrcNCTh2qOVlumckfVMlISlrHU+ZQs8UFDlmfU3Ag2ZJyOKImQYqL9UFUm0T0XM3Srpq7Ja6drmyoO8UpSSzkkW8/La+BQqXV+C7910MPxHeIH8iXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENxWTOCb7G/aw42Mqayf14oEnzTZjpvdEzK85qTc+Cc=;
 b=LObAVv4lfPt4pgvQEZ9DNNnXoiz/ZSk1YL3h88zxLlzTLc867wa6yPhcQI9M2DnqRxn/03zpTdAUYAgRbBWy5Rq8GKD5euoLT4yxMS0aaOmiOKkyIQfJG/WPrFx0iJF3Mb5Ti4+vZmNmYdXuwlYbHbnjhqW9gsaZDCvfAnqPH6i5qPBqNjAKzqvgpKgMFc706zFJl1OSaFgoTOKB8Zzsn+TP0OWH5fooesq5YvZVsoqOpCZSEe1vDhvV0hxEHnKoPl3FTMUA2cCf9L3GcybyLdCEUJ8cDiF4uMdKN1XHcJEKzpmvqOZTw+uMEfftV/hm3/Ddyr2xPE/O0FAExfiXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENxWTOCb7G/aw42Mqayf14oEnzTZjpvdEzK85qTc+Cc=;
 b=ENO5Hf5Yw/PNY/XlWwF7nI4Xgb7gEZpJZbPOT7hj1eOMwLi6M0Il8VfaxFwskWBWZs+VdT0lYIq4WuYWIalKOW3/YMw2t0mHV3RqONKROF+fK6Huf0OtVAbk16szO5/sGnP55bM5hRmTSZOdDWA7PTI7qxC1fZ36+TorpQf1KJZyL6UT4XowlXovbpX294k8ofwfqifBchqyhqX+jlZbn7v398nmkjvNoLUDXdHDvpH98pm66xRBP4HKk5Nh/Jic97WWZZXOashcNihiFwqSUUiJweEt4/rZUAaBCogvRV9fpTOEa0xjD5u7dDV7AXWF9nJEO25aoRWXRsNhV0sObw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10918.eurprd04.prod.outlook.com (2603:10a6:150:207::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 15:18:01 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 15:18:01 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 0/3] bass: Register bis probe/remove callbacks
Date: Thu, 27 Feb 2025 17:17:53 +0200
Message-ID: <20250227151756.33772-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0015.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10918:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f2d496-553b-4065-fe66-08dd5741ecec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5tFcduh9+UQsr+tVxCHgR7Ddn39QZVsFKMcd6rlCHPGt7GdrR8cDx2DdY8/+?=
 =?us-ascii?Q?w+Pd1F6CAzNMXnINOPgO/TqEtG6UajvGdiwBR43kn8pR4VNZauStzwLWP8y9?=
 =?us-ascii?Q?17JYGUN0Qd1jzTxxEFV2S8pOF2plNFUT3nk6rtxZ5kHJK9PXRfMvpw6HDNIV?=
 =?us-ascii?Q?qmTb9Rxp8MJfN3jvFwLByT1C4Q/SrFRtzVJKyKj0FDz+yEG6cCscE7eA1e/e?=
 =?us-ascii?Q?5Cz7YXmHcEU633F9K0CF1bmnfqFs1CRY8O02vuP6OD/Tc72XtlvufD1tqLXJ?=
 =?us-ascii?Q?GwJkLgTt5549J5nOZZ6g292Plin/5RBVbNMuKha9AVKNFjRit/TjZo6911Wn?=
 =?us-ascii?Q?JTkIMYikCEMHU5OYJHN0YYG46TdHzETuyK11rgMt/D1Pwa4o+bTJkvaqAxRv?=
 =?us-ascii?Q?Db1ue9M077QWTf+Kvwuf/GmKJ+Vangb1NZEag8us/X+DCxGLd/89nUqf7ED9?=
 =?us-ascii?Q?2HHNC64K1+2iIKpDD1poa8Be3xKSAZexRJ930Vihoo8tYfg2PGrCnoHdVyFv?=
 =?us-ascii?Q?+9IftJ9L5Y5zITFDIGP502TF3xsiekqO785yTcbkgVvkuc1BQrQoYyY7am2P?=
 =?us-ascii?Q?f8PO7EMVq5TQQm7N+Y3VypW+tm83ZKnCHNkgOXoZKuEfXY1YV8dri+yH2d+5?=
 =?us-ascii?Q?HgX0DsPeCJvUfIdH9XN5LDwGDaDGPPbVIIPkWtSEK82UI7I5wM727/Ea+5Wt?=
 =?us-ascii?Q?8A+1h+v6kvLf9E/aEYILKzblfmKHfD9detZiYgib8XQSIGNhgs0PKQE45s7N?=
 =?us-ascii?Q?uPoyU95qqcY8Lc95+wZGnvZ3eBBxtMxfAFmEmTnI8pzDOHdmgNWob1fPFBVO?=
 =?us-ascii?Q?EheKxEu51rOzFim0wQex7hjplNPn+CZTj4Gq7Bc/uMaUJ8B7yO3k6XlFyQDT?=
 =?us-ascii?Q?PD95Tt5oSnavJyUulbTG4L58tviW4pnRvTSWbCVm0ANgh8QFTbe1A3R8DUsg?=
 =?us-ascii?Q?byiiF5moqyiX+04lHHm0ODZJ5czmE4ESj87+mI0oo3iR9uUh0QdUcL3u8TzH?=
 =?us-ascii?Q?YxUWMz8+KSzAzXmOijf6+sdAbBh4zUZsnqprfyktAy0DtPDDpElnla23ny9V?=
 =?us-ascii?Q?zef1p3CV5GyE8/1ScG4e5lT9wVCscQW7HGNsuL/QsbBPR+Q6tuB/6pUDVkoc?=
 =?us-ascii?Q?SfBhObxcost1YFpGdBdFO5ejqw8Aq+cZ3e8VabSYeEPHUPu4XL6hDsW8/Kvk?=
 =?us-ascii?Q?4LTmsiWwbfp4XzXCdDSoCphjEZaIQuc1VmfFOZOfTumRiLBTrSpNK1ibYYC+?=
 =?us-ascii?Q?GQWLs/M7qtqpxPirOOaQxYgHiem15qQJdTW705U1vxT3jzoS0dzSHrWqUpn8?=
 =?us-ascii?Q?16SPQ7efKq1TxOt5gLoiLYUxJmGT0opYOshLctNYoHIcC7cKKWsmXewWH7pt?=
 =?us-ascii?Q?6ANAQCSfgbW1H/S4PgmkRrIyPJmI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IRGxNM5d7o4+erAYifkCTAL9FNZ/jHkBFu57gLgarkHcVmT2IJCF8zfY66wM?=
 =?us-ascii?Q?oFbZr7G+NC0nb0wN4hFVdUblhC38TmX5ddkiiD2YrshGiwx/wFea6Q5jP1mP?=
 =?us-ascii?Q?XrXACMpoJ8+1lUOgN/uqkTkL7JPfGmkQXUo0OSKtGOEGoGcGZDxrbxoxfPRE?=
 =?us-ascii?Q?Rq4eYeJcdfP5Z1BG5temHpozSgD0AfpBbszXZNAdYqMaqi463EJC3RQEIDHP?=
 =?us-ascii?Q?lu9BO9k3qjjTqsSGPGv6ZfkNOzbvNwEgxCcHlba9yCAlj0+7eHITi2/giAIW?=
 =?us-ascii?Q?OQpObI0eQwBSPFTNAzBChQOwgj0MxMV9mN5XnFZpqpZM8NGgSJHAGeQIsE7D?=
 =?us-ascii?Q?w5ttev9aoT3l7PUPus01zZA7cOe7TBGPkwpr9BVRtitPRKU5cgT+QmAXLN7u?=
 =?us-ascii?Q?TTDxYvr9OI4O+pQcLggIN5q8olMHjbG/C0jWYmVW4OeAAkMixAbCugq8exKa?=
 =?us-ascii?Q?waRYByt29UGOVfosE+o4n5/6QGZEqRYfe3gGGFnrciDNPT/nC2CJR8gLuyle?=
 =?us-ascii?Q?I5HNEaShISdHCb4ve5lJxUgiCCZfWLdX5k2Z4iPYh9ICl8zNirG0Qo7GcdwQ?=
 =?us-ascii?Q?lQj1si5tS8fd24UzrhuwA5e+4jRXJnH4hvSeVb2RnEpNO02K7uJrQG1jLoXn?=
 =?us-ascii?Q?VW4aCfHamnkykbZN6XcuZdypy+c1A/1NFMT55Y8JHNknjfIhx1tuhUfshB6j?=
 =?us-ascii?Q?AJzNEBXB4WHfbc3RmgjqPYqTZNZ49AOn8uxIS/0XaivvQIL9Lj97oPLL4flH?=
 =?us-ascii?Q?TG8CPttuudwq+nfzurXtCI8BAux099JY8CHoKOQxK3OKGWblgKiQ/64V7ANG?=
 =?us-ascii?Q?B35sWz7qfspu/LGLlG1q8iS70YyBZRgVSRt7PDHXFTfcWaNJpysS0YB9uEhY?=
 =?us-ascii?Q?r7qxBk5kOl2eLtmGsW5Uyof5bypplu/6M/ztLUrjyHMpziU2VffWVVeLoxz6?=
 =?us-ascii?Q?3kjNHlExNU+zN6jN2M5RYtyHe13zrGsVOGCN+VjRD8+bnTJ8yIn6HM2HRQbq?=
 =?us-ascii?Q?qLgjDHcBgRkzAoKt1pUthN6NBCMfMKmVkyI7wH1quBnP52qQwbWaii+WBMES?=
 =?us-ascii?Q?d7Uk8iUC7hMpJEo6PlRHefxibQmh2VHoGn2VcePSwjnSDBbf75MTZa1DZ9PC?=
 =?us-ascii?Q?VHSzDfJvFU0zKC/Btqh6X6cIQ3q0ZlO8lP1wwFGWUtCgQMiBq3sLKFlJqov7?=
 =?us-ascii?Q?pw95tWBcZqtoGNQV2cGEUPRudS9Nh4DxR/Gx3w6XoXbqR9UPw0cF9ylBtzXz?=
 =?us-ascii?Q?/ZlCkXNlfXCXvVA+hiHP/FVAg5T/nRSjmLlCx+8kUeL5oZGl4R9yyCENKd1W?=
 =?us-ascii?Q?Co1N0FAN2q8mg0qQXoT7ESES9d7YHuIEQ1PVIyfxwd8lky4xZoa7DdYkhOip?=
 =?us-ascii?Q?0AfbjFFXJp8mWmUUtLBOhT0ORFmA2BgxT6Gi/2bjwRe3WJuA2Ke8OieDnJOp?=
 =?us-ascii?Q?9kIaG4fyqZhSdUmQS9uPwoW+G2llEg8349Vl53IzNz+MY0eYAA49LHZJCicn?=
 =?us-ascii?Q?saXni96mhQmdf/J/JiEJJEBUnw9kSZRNTClNoAmUELrdYL71xbRINo9G2jRe?=
 =?us-ascii?Q?8SR7OBJw7DVntTNzSo0ZFhpc5tc0Dm/m1I7z0oGfU0Y84PbI3sQbwl3MTzrX?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f2d496-553b-4065-fe66-08dd5741ecec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:18:01.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0ItqHFCF4OOmQhnqFlR5V7vpzlaVY1oYpMSoDeSbiABBYtCRbS1dmzwYu8Unen7OJXSUpuUTGbuqsZS0qqMFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10918

This removes the bass_add_stream and bass_remove_stream APIs and
implements a method to register bis probe/remove callbacks with
shared/bap, to avoid making direct plugin calls between BAP and
BASS.

Iulia Tanasescu (3):
  shared/bap: Add support to register bis callbacks
  bass: Create BASS session with Broadcasters
  bass: Register bis probe/remove callbacks

 profiles/audio/bap.c  |   6 +--
 profiles/audio/bass.c |  62 +++++++++++++++++++++--
 profiles/audio/bass.h |   5 --
 src/shared/bap.c      | 113 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h      |  12 ++++-
 5 files changed, 185 insertions(+), 13 deletions(-)

-- 
2.43.0

