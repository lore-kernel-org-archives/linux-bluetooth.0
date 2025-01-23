Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519591E493
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jan 2025 13:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638634; cv=fail; b=Gbvl4XuZ1B2Adp1RWKX33RMsrdMnCvlkRD6fH1aCwFItPw+wqlyRIz97JD7ClErG90K3g9vyw8qnC6uO7BLnagLONyS6aGvgznEI7/nRXe+na5q5KSKRkFzQ2rsmqU2YB5UGel8Ii1Astt7ivBuFYZ3t+YLb7TTrOJpJmP7sf/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638634; c=relaxed/simple;
	bh=tgDvIs4vduQXbJ7lujh6dJVrP3vILKMUn8pT+pmxJqI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Vti2qsmBXheUhWQq7VfocNcJF0A7RHED3hFgnpepSj4Bm+t1E9xcqgW/dS6zQzLNsiww2rALZRqTjmru2N5f4qLYbIgdlAd/v0y0ANWg6k6kDXnR91qMRNHQMrD4+BH5sLmubNYtXVVOR7eICFoQgJ2vRB0KHMigd4wl5b5rZ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c0Dtvl0o; arc=fail smtp.client-ip=40.107.104.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c0Dtvl0o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmaBpErjRUMRjlSsPjNNZTBo2M6MHZ1pm0BhMUohuT88IATwXc4OJH2X9Vi4uL4XycSMtSHWKhbm0kFS4LE6/EyqdI5eKwm8WGoUoVyzpaqpdMNNpT18+pvyJ5Tu3O3+KdHQdm91JoVrQca+hf5mTQgXVvr7XYKAI0VQyF38XxwhnPJrZZUNMo/gIRy3pH+Vk5Dz58fnJlQHV4UoFGqaBYRrO1oc4Adp/M5ZcToIwXskTBCi/pyFf4Uuh+Cio1B5dsVqgwrsjaZLZ/1Wr1fq7RygF7Vsc+6+dcplkw7BNjSnuYHXGw4YW7fQcISh0Yz9y5wlSoa7UTx1V0TyDoUgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lz5nTSdEFUeW1Xl8dJxag+N4dV1iy5VaOxjQw9xLlU=;
 b=nCZA8wFYfp61wapasCTODDtjy1EeA8mqa6riUU/u12993t40ncdTWhJztwUjUIifLcgoBfDKVesMRSnH+o99mLp9+IUgPA5+Dl6xFJ14SBqHEn8+4QMhT9fzUdR6AAGZ5fJl3azjQcd6/22SYMONHX9um3/z4cS+zicQAoZ82iqTaEtCckixYRBg2t6OgjyB8jUsqNlqNob4gzXe4x9g15n6fGbmruqSxSJhM20G/gdm1UzNVhlBjya9yeva27+4Tcr++iXHdRr+niNSMDco9tRWo9Vn+2RuFu3LPfTeyrpAsf1s1VE9GF5Iro4ofRx92X0xsOMvgxrtaFOXPb62IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lz5nTSdEFUeW1Xl8dJxag+N4dV1iy5VaOxjQw9xLlU=;
 b=c0Dtvl0oF9/M6MLQWY19bUMZNom29j6/2LwDX9k68KkYFQwlcmHYY/F0IQe0LPY21oTVlF8cYJArQSf5m7mPIPO8RLA/TVzmp+33Q6/b5/6rjaIjU2aKO3N5dTcVZNbJMSfg10JvRiUD6MM9pzYyVj0jxWHZF+yVrXCmOGIBl5GlWXgezgtw9q/sPs55xu//0EDx8r75deKjSNfQWSpc6ItBfSz+SKWsV95mUUEpdKXoXzYRDoljRj+XSCaaF0XEy9ABx+yhWuMd56Zan+VUjrXpI65Z7OW6vBjVZWaefWJXDW3ZAgYykNYhy1fgSlw8pCKRGT/e0dkeBTtzHzIueg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DUZPR04MB9783.eurprd04.prod.outlook.com (2603:10a6:10:4b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 13:23:48 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 13:23:48 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Rework transport.select
Date: Thu, 23 Jan 2025 15:23:30 +0200
Message-ID: <20250123132331.27435-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DUZPR04MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 018e44e2-bdc6-4616-bdd0-08dd3bb12bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcL1DMv0WgLGwWz5C319uV7JYJDDBImRoBlHnlC2Ujh9xkRaQtiTWw6g55jV?=
 =?us-ascii?Q?c/H/dszznGYcFBBwkIKqGTINf9wiHhskNIXQyPCC5FNHLTIq9h8QxUfiwIgS?=
 =?us-ascii?Q?e/biqif00wx5FC0ocAg0jNJ25r0gFdAQFtGB2x4Zt+ggXOphrLrnQr0hha+8?=
 =?us-ascii?Q?UyZwlBbiLhDM2SL7GX0DyH7DyaU7YxYSSJjAf7Wb3oCDylT1SKk5vvLVpWFj?=
 =?us-ascii?Q?P8c1v/NfiUz/VoZuMjtxZuIKh9hm93x1AsnpcukilWoT6WUm2LbYoq0ZzmaX?=
 =?us-ascii?Q?fWXuUCwKBdDXjIDRebWYcX/a5rHZg7UZqbBD8RcWenE+EAwEzM5iSWtAAQ6E?=
 =?us-ascii?Q?tQmZtBblUvSfyE1iN7ljJcX+8o/9xfFhYDocAU85z5IZb4nC9hflhkzUQ4WZ?=
 =?us-ascii?Q?BYhAodxLAwF5EQ1Ijtkq19HDKPKeRzAv6yPVevPBoI8/wi23D+2HsJVec7ky?=
 =?us-ascii?Q?8SGypqgpBdf845SkJEelD7x7GeA+MxzvlKD/Dam9OJx10W6alLShXcwJgMjx?=
 =?us-ascii?Q?sUakff37/U9PbPRO6UDf7dnGtHKOyhXZSS3tWFzveOTVuENIdNm5Irgcu2FG?=
 =?us-ascii?Q?vFOBfL5l667yLKOOKxsoH6v8usE0CdVwUUvFkZXNwZzHNuPj+LveT0ssfKZ+?=
 =?us-ascii?Q?puZC+cpem1aOLDYYIkFp0P6YeCjXmN6+HLKesUpQz3Tf0WbqLckZPL4yZFGz?=
 =?us-ascii?Q?Dd3/Gu4KisO9wUy3y2uQJXUIIk7WLW4jlQPFesHN5Pnt/6hHWRPwyXZOAykv?=
 =?us-ascii?Q?rm9Tya1kgFImEmHEFcKKi4MP53NRk3CxzwwqXay8TR1iyFIzQd8HR/9a0zFy?=
 =?us-ascii?Q?4SLksHJAHMT8n7sufTWk1oSXKHk1vZerTg7cX5cYJYRmganW7Pv8P9Mh5DGD?=
 =?us-ascii?Q?RAmns6CZJHHt76shwDdhMxK6LNDIzd4BJvoimnVQWUGbxWpLOsYbjFIQ/zaw?=
 =?us-ascii?Q?GqxKBeG5Sp8iTspJdkrID0Qdv8WT36J030Ecg4ZHbTnTYxI+jtcek6FQ/bNC?=
 =?us-ascii?Q?TkJwiHQkeTdX0J/mKEASfXYqK7XhazSRyp8g0A2CDETx1Vh1ZabMn+nwn+1Y?=
 =?us-ascii?Q?ZjPuOsRbn54vO1C3P7ETTvwMz+AxaBPY3hZgzOE/Ej+eMr5612XQJvMTb8MV?=
 =?us-ascii?Q?CVvYUOcLSWDywdUeXRXLF+NcPx70mGgtZQodIf58ubntLzqx6pTvCWals7BA?=
 =?us-ascii?Q?TL34RgZ6iNtSepl0sEm7fCNamw4/DxUFXlgFMb1iKWeeEbuttv4BwvGRCZgR?=
 =?us-ascii?Q?niqwN5T9MwFegcqKgRNt41U2PM7HUtArdhmH3h+nq03QUqPJlRe2UOXEwwRT?=
 =?us-ascii?Q?gW4Mv/swQpeYYD4NOiaQbNxp4eCidzm4hhRedwdi4AQKXaf2L7w3FW4YWzmU?=
 =?us-ascii?Q?G3QytePg2z+r2GY0wnP/9WAPMOD8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B2KERJU2vPDYs7Uip9B8S9mebAl8YKiF+lapzC7X0U5ROCpb9UYUujvLwvAi?=
 =?us-ascii?Q?9nh1fL7TxH4cPz6/zDvdYcmxG4v3JqAJMJ6cPvYyj8gW6SerLKv1NC+HkNYN?=
 =?us-ascii?Q?Kll6+yZoWLhBCqoQiRHFXRmV+qeaaP289ZOPpp3z0B9VYKs5QDjJzZMGO7qO?=
 =?us-ascii?Q?o08RflAVpo5qLKmAmY3sQXaZ6XXy6de9wyr/SkvbqR3YWgQUJpkEAiJxHccq?=
 =?us-ascii?Q?CLC+pK4jTTt2n38+nl1sf6avRO+nxhT/yaFWw6Q4ceWJ7807dmV5vnEBVqg9?=
 =?us-ascii?Q?AvC9B9ZsLwOkQnKF5gUvxWrKG8qVgQhu8gBgwDYUkcUcNqwkUx3v6xHEwRD9?=
 =?us-ascii?Q?9DEfJ1VKpCxdtzvdSSrjZhqGQlxQE6Pb7OZF3Z2vx6w0obyCsZKLmJrfZ2vq?=
 =?us-ascii?Q?KMT++OcaZnkRp6OoHtBMA70N5Ya69u3V0Apasbiq5pW6W5aDBNhvtEG43w//?=
 =?us-ascii?Q?QnMGPWe+5cuy7Z9psjPybRk+VjYTK5XHdqCuMFPe+Rw66sV52z8BsQgBbsbP?=
 =?us-ascii?Q?0D6jWFDOs94Jl099jpULbDljBPgkEA1ZLF+H3MbRUvKNXGmGqH7Cb9As9Q2I?=
 =?us-ascii?Q?ndpzJ9k5Pj3YH4eEIFpg1zXB2z9bOLnm7dmeyAqm8WpnkMwNXBhAJNiItpF1?=
 =?us-ascii?Q?hQBBxjOGAOw43n1oxGVesPQoDrulgYM01jHGVVgHURL3xfQ1iNQN7NjiP5RT?=
 =?us-ascii?Q?6Nk4hBBIEhgCbRfYz3ev/ex8V8F+wUfHVpurKnT+EgzSvHz8rLLiUenlA+0j?=
 =?us-ascii?Q?GaRfMsKtvKJNmOZ4kiF8LYu0DRojXqPERe+aN2yO3M8Csy3EwF0bwXiIr8Ne?=
 =?us-ascii?Q?kBFiErHHk42Ku6zNoS/NO5M2POWz8DT6od0D3o3Z7BevldmHH6C5kpA6XDBt?=
 =?us-ascii?Q?XW5kgDl7ftFpRw5l5yCSdKLMTfIJhyB9M15H5+nqwsIBOwHlIU66zNbRXylx?=
 =?us-ascii?Q?WUYPzhjibrys0LtJY88deYz9WyxSICK8ogqGjidQTKSeyFOb21Fwae3dU2Tr?=
 =?us-ascii?Q?nrp+Q2CpB8tc6XotXUISukUCkn3dcBI9eE6i7vDsi67ZZ0l7i16A7nw6yrjJ?=
 =?us-ascii?Q?Eo1IViDBo49CCwR+xUIRUVKPwBfOU3/yw+qvndsez2Gpfdx23/6RhrL87kuN?=
 =?us-ascii?Q?6hz2T5Db1sSSzwsqjqVAaYs7DGoeb3mDYwNWy5TIQYPaPzaH7h3J9/xNuwPp?=
 =?us-ascii?Q?HfE3omfrscCZnjx7GGFoseX68f5znl4O1VRksV5oVrpKQidsR3Yb4ls48aB3?=
 =?us-ascii?Q?ngW7s/+BIW9oAKkbzEMpUMmKSG91JqoyCzpYGTJL/velq+YGP9mCye39oWyv?=
 =?us-ascii?Q?i0PzqD2JFfqa7Lz5JRW/IHCjYBG8fCpIMzS+I3/da4ZUucZU2p093gEmv+VO?=
 =?us-ascii?Q?XrY8ckPpJigtYeYpaxr7/6mFGjoeLQjTNK6HA1BtY7rNvZLr4tDq/saXuGyM?=
 =?us-ascii?Q?QhZsfSxt20qnfcEb01FRKBMQqiDYiA1WHpZW7TC6jH8W+phUHZoQ2bxhTbI8?=
 =?us-ascii?Q?4x0Ow1tNbgr7dZJu7hFp/ik4YIrGi5pbYDwT/OhWiw3zm5u87RwOaDyoMscQ?=
 =?us-ascii?Q?9S/qkSJzRAu4l7lpjp0oQF1HeeeWjcGl4BIRDPt7ziujEwJh8G8o2D5vq8OP?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018e44e2-bdc6-4616-bdd0-08dd3bb12bba
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 13:23:48.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x76nnfI2LyyhsFm53JLyfQ7sp3vhVXFxiYNTw1QXLqgiqDQxYryy0IjGPAFXsgNWW3proFMZmuJA/y3ELjlycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9783

This reworks transport.select not to require a local bluetoothctl endpoint
in order to work, since the user should be able to use the command to
select transports created by PipeWire, meaning that the audio server
registers the broadcast sink endpoint, and no local endpoints are
available.

Iulia Tanasescu (1):
  client/player: Rework transport.select

 client/player.c | 160 +++++++++++++++++++++++-------------------------
 1 file changed, 77 insertions(+), 83 deletions(-)


base-commit: 73b251b8e8f0de46ce2fc8d1834dff529820d458
-- 
2.43.0

