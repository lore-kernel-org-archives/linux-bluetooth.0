Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011006.outbound.protection.outlook.com [52.101.70.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABC82D030
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831710; cv=fail; b=SeO6d8r2foI2bwrvchjg8PWOQ9yffvhfEfmchpIMYgnZKRW6H0MQSqBR6oOaDeUVFJbWXal45QzvN+L8DiGcZgpapXc76csH3aJFvCW2QV7tiBwfYt4ota9nE4x6Y4MD4ZUDlyXUDZkL7wMKYVnvAtmlIZny+L2s71x7zS0O7TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831710; c=relaxed/simple;
	bh=RnH0nlDkZY9UP2HK8wC5uNzNex3QI+8Teb3La2AO+sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q8kClRqhLGwTj7MNz1T3A2nIXfNArIeBz/ykp0Q1ZWPoLytnsd06yGxNja+GnKI9c7Pj8TCrofGgu2ZAv1IUQdg4XOW17TP21mMh9oqQrytRYS0jfsRI3A/SeGGhL4OaLAR0dfJbNs1sQNrKjK7m5Yl4DqlWqsqnnCM5dS5+uzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jvrk2J0g; arc=fail smtp.client-ip=52.101.70.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jvrk2J0g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7Z4D0eShroW+QdqkXmSIaCyWb8+/+tfbJFhUVDVezlRcBd1XSYNixP3lkb2NqRhAT6mYrplbpE31CewJoMBVxH+abc7nV3TnVWY0xUX5j5XnTWU8bYnA0pUMQYbx4TwNmUGRnUQRcX/G+FOkiI14Pn7xvi9JZB5R89g6ewZnKsdn17jqOpeh7OD1l15VCq9LEFh7x6fhhNKwV7kBL0dBKqapgA5mKpwOFQz2a05G3BQzTsFjkkMI1o4mb43x+r1wVCyBHCrhuMib0T3jrtpIDF2/ZmiYt3ZozhkZhTaH94rP1Q0pVaDPTIyHTcmy+WX3q3JfGXIcLW+0uK4NM/qUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sE+BPPKVuKtmt5Flr0relgvD7x3ymACZKAvHNR5/hYU=;
 b=JeAiqfG+J7jXCJ9FjyU+cEZYyj5/Qp/9Q/HlIlyDCMiN075owyvlV7QNkKCCwd+1DzotFFTzCTG3THwOY6b+PiZ30Aseb8GD4HncZob+JuFhkdUCIkzFQ9If36eiGVPZNZIZ6eUA8dAUupnGH61QJXt278+OwlMO5gEo8IfLJvocXKV0yBY3YHHhVKRihfBQ060bjOz3nw8DABP3RaZqzUi1LMCkE7tKzLZJe+rMm5TjSLM96VzeA7WXm1svb8+f+B7TW8h9D6H+uJGEZh584uAUDt4QUv1005Q1uerbi3Yj1utEcLxkgVH/XLpzqhXFovC9UYuNetj4YZm2FWkZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE+BPPKVuKtmt5Flr0relgvD7x3ymACZKAvHNR5/hYU=;
 b=Jvrk2J0g8TlVS06zeQ+HqSK5jWfPTGkxNUr4oGHPxhfVGusJxpyPgCRf2aMZr7F0GsbFRyjzID3Y/8axwP2g9CZiaWjCVKxNwNuE8CYITLX40tAv7v7qGLfIehzOqvDCtTWK6EtEL8N2UmTb5xWtj6thJetTe8FyWj/1/JHHFmq77s3e42zR0uFsUPZfUcWXYhQM5CF5vr2bBBiUF1O8mvF8ngbmy7nY/sI/e2W7b6PMIdRS0mkKgVKh3b29n2VVBh3M5qASfNQf5396DsRsvdA0S56ucmaW5Mn39NM6DzBnI+Kv/ovsaYZXhDTRzgaRWGgp8zrMG1BMItmBDC4nPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 14:35:05 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 14:35:04 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/4] Add 'broadcasting' state
Date: Wed, 24 Jul 2024 17:34:21 +0300
Message-Id: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 373689af-9965-4a17-4855-08dcabedcebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ctUP5ONqrj3G50GETFU1skULdaEFwDD7uSkididolqrCI+6/PKhYWXb+F1eQ?=
 =?us-ascii?Q?5egORdmNRwxyxzS4nSEs/mWp+GOpYTcFBTY5NYwORIKBpx0Sr51JucU0QcWu?=
 =?us-ascii?Q?CxvE18oSY1SCh7dLtDo2bOkE9dD0F+O+mUCo0fYfYlTHIdUnjvfF+lbFHvi0?=
 =?us-ascii?Q?msVnjzopsm7hTeBFh6Y4z7YzAh+ODkHNOoJAVGdWTIPgbhlUOej10/5Y5n1o?=
 =?us-ascii?Q?po5l5LFoMZagy/Bk8bn14oM2kJWbY6cQ3JJguYSDDOb5VGsr79vxAhUNGi8Y?=
 =?us-ascii?Q?4UqIemKFEn7EL2L2RqRz7878g+zatDjoxz9unlLJZgLNNxeCzUo8U9Z7TuZq?=
 =?us-ascii?Q?yX/ZqD4nozuP77H/Q9cSPjrbyD8hEXwkjaM6kI1TDVLjJnH/REI27WQbqcAj?=
 =?us-ascii?Q?k6wzg1D+S13bIhdfXkZoLSYwIzt42ipYB76ijKEj5bbaRKfBRmL8hpi/mGC2?=
 =?us-ascii?Q?r0Mb/PcijhJ983qbAoho6m3n4M3eNzV8nMAhsokZFRtE1HZXKveRuMAXyyGJ?=
 =?us-ascii?Q?xW80ziOimn8OUJSEUELff1OeI3PW3yAtdthK8scnNcdAStCX/WPfIKoN0BUr?=
 =?us-ascii?Q?T5nY/m+4ivszsqq64bRCNrFom8o11rv1e+q80JIyz4zHqj9PIoN1vKhDWqcL?=
 =?us-ascii?Q?iKaHRL6gKIzHYjm8Bw+ZTw9QSkXOhL5GsfbHm+X4hgBeNsRQmjg19uEYR1lp?=
 =?us-ascii?Q?EUDwicUaaO/PyPD8NB35ZnbTQLsaWoascWtGHk3T78pruePmEpxBefidLoPk?=
 =?us-ascii?Q?nNf6deExtlG8K3EAIse86krsfz7KX58b7/9kZKlEehKRlWrwuo2DYinB5+Ks?=
 =?us-ascii?Q?aHAZOfbLORUuw9Pn/9HBKuyifIuuG0r/jC1sNZn9VEDITIqCaIxK6mlvhePu?=
 =?us-ascii?Q?fdw5CY7HhIRJxkloU6NVCU2UCK6v/aAUEHSzgw855bmLbh0gaOXq3zFmrmEt?=
 =?us-ascii?Q?S7Qe3HgV5kGqneXCMG8TP/Rtgctlln6a6OG13wi3coGHdGz/1FFFnKXfv0BS?=
 =?us-ascii?Q?P1ZgFc3uYFVre2SADEVcJAYoKkduqf3CAsmbrxViv9F8tmUMv+GW0yQI3b4J?=
 =?us-ascii?Q?wy1u7U5hJGo1HrE4ty8cGf4n12OmkHYqUQKxaGvwj2D5RgbuRrG1gEUYc1hG?=
 =?us-ascii?Q?lYUCKRrnAFP69tEfJDT8vbWJUzKgMWbV8sYuN3HjFjvSWFPFZx5z5Wd899+O?=
 =?us-ascii?Q?95vIr5UCVTJoKd7+sVD5AZJK5sFK6v6jcMBvDpH87QHVw4DZOgUmDIcMqFn3?=
 =?us-ascii?Q?GsScp5b6gpvBvN15FBF+miTjL525+BsvcOATis7UaeK1xgnJPkjzv25E2gLF?=
 =?us-ascii?Q?CED2TybBj2jIq4xjfkX5U3lk+HPjkQP2ckTYgLF5qcM98Ndm0f9ZrgOb6H7A?=
 =?us-ascii?Q?SFy/jwRgojMh2jjgCOK53vlMw1yRNF1gKFeFUvFcFwbG7eMVog=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1nJdRJk0jFZ5I02oIxtCERSLtMCggpreC07pMDk9gSIkcl3UqZt4bhu9H8wA?=
 =?us-ascii?Q?Z2fZ1CogepDN1bGwYMIFBNgvglA/xoK1Z2XZn875xI/wAi0htOGty3Bk04q4?=
 =?us-ascii?Q?x1cc4CMe5s88Z8sbKJaofUXCs4krbuewwvJnwFWpRrLlOgzORgdO1vOect3l?=
 =?us-ascii?Q?DFqwQ5T6qFpZD8pjskNi/EnD9tZ7lP+P9QbAHhzCAYGDO3mWabIJYnHAYK+P?=
 =?us-ascii?Q?N2oWTYI4xvd9UXGEaFourXBoTUeonsFVXyHFRn2U7hM5vicTbPUVM0bSAXFG?=
 =?us-ascii?Q?BGiYESWt1L4YiJM7Gr5m18s1GKy++EcD96Fu9sEXMT2+srlXTpjNt61Tk7rJ?=
 =?us-ascii?Q?PfNeVVzi14xYOYeEZ7ZCgiCUI5yUX00BEIS6c3810AhHH2OHM+33g26SikyA?=
 =?us-ascii?Q?gawih9DYNZUtxiagaGcrsf/iKatYnQjYqAgqNzBdKVbU8HBMDf/eACQnW+I6?=
 =?us-ascii?Q?mrqMYOnomjNbDnoIlDAPQYJFadLw3Fxjxj7AZZfQkLhaTkKwgPuqS1gh1AtE?=
 =?us-ascii?Q?tSo7i6jmpCXfSHhLHAvmEUL8oQfsVKiC7axEsma81wKDfTKQiGr+GbgFVKP3?=
 =?us-ascii?Q?C9TDi0Y9ZCKgRMBfyyzl0JNcboaaXUGy5WGmNjxtsQoBJ1MbaZ2GcCKFcqgN?=
 =?us-ascii?Q?aHgtmnpj00NsHdgNGCvmVdvOZ258tn30aSoNEGSL7YVdW6I4NK5bgnAMYF77?=
 =?us-ascii?Q?FSw+hwfiZtNN4Gm0WJonGYs4q4euIguJAb5hyigdVEZmyiwcZPQqVBNnfs4F?=
 =?us-ascii?Q?a69b1ZWO+0If+6jsSm4SeZAZUOXNdPHOliO4ZlKUKTStyuGOpl/KxVfBYNsI?=
 =?us-ascii?Q?fjGd5jR4JJuSS9xSUvOL4K58qhqLOGwfTEcR5+gdi2KpmrlrnmjZT0Ht30Bi?=
 =?us-ascii?Q?owi6CU0WkTnlD0QvqTF0PsaSPk4lpxZRNxBlP52wYVDV+PhmQgjTghr49zSG?=
 =?us-ascii?Q?GkkmK6fc0krjjE2jhqjg//fbA2cS4ZSaeO5mmuE3BE0UNg060Y15S1vRyh/n?=
 =?us-ascii?Q?s+/QkmbcvhY+3FXku1C84bi1XZEyf9mWjVzW2A75fzxjCWHJsY4Oft+5oLNd?=
 =?us-ascii?Q?A639zMNmyNYyf56xicmfrWc//XvtRm67gNFwDbfqun92eiq62+vBJVN7hr30?=
 =?us-ascii?Q?MSJIYoMVcDd6VFyDtWzovMF/b+sEbTk6xV7ltKEo+QkcLFzKf10nsssXxnse?=
 =?us-ascii?Q?7oadiIX4DyYIyn4IVpQ7PIWPaXwn2mhZoQigGE1yUpE/gsb/E5NlDRPQdy2x?=
 =?us-ascii?Q?ejt5LdT+SZB1q8nTqOVT3oTKW6cthLadbItFlmU5DAJKPo7Cq+1VUC1v1j69?=
 =?us-ascii?Q?WLysudYzB/NZPN6wdbHx/BHCVfINoi1/AajPzGjdEo8dDgawoX3XCOq1B7qQ?=
 =?us-ascii?Q?jiy2o4IYF5yHglTYrlX/RtSIMdDUGQFjwf7YpBXAmOzfewp8ja2Ap9gVtXg+?=
 =?us-ascii?Q?HKTOv4D1jH7+JOsfacsAMBjkajfO0Ksgnv8KUug5FOR8LWyUB+YHd7NCwIH0?=
 =?us-ascii?Q?13VEzDG1shbplT4mFGgblkAPBwmoOu8Nd8poJXA/JO+KsTqgG5EBauJaU5XG?=
 =?us-ascii?Q?+tuJtKFyl/O/p/cDZLm6L1v9f9n4H/s3Eblc8W81?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373689af-9965-4a17-4855-08dcabedcebf
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:35:04.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkZJplEYeHgdIzwU1ZFVnFsY/mLPsQAOsWK5BdeBwMcavHtRt+7CNu0FxqQXD2Wv0GyDwlySYkftj5y1xR13fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024

This series adds a new 'broadcasting' state for transports created by
the Broadcast Sink device as a result of scanning a Broadcast Source.
Such transports will remain  in the 'idle' state until the user
selects them, at which point they will be moved to 'broadcasting'.
PipeWire detects these transports and automatically acquires them.

The transport selection is done using the 'transport.select' method,
that this series implements. The user can thus select the BIS that
he wishes to sync to.

A PR has also been opened for PipeWire, I added Pauli to CC so that
he is also aware of this change.


Vlad Pruteanu (4):
  transport: Add 'broadcasting' state
  transport: Add "select" method
  client/player: Expose transport "select" method to the user
  transport: Broadcast sink: wait for user to select transport

 client/player.c            | 52 ++++++++++++++++++++++++++++++++++++++
 profiles/audio/transport.c | 50 ++++++++++++++++++++++++++++++------
 2 files changed, 94 insertions(+), 8 deletions(-)

-- 
2.40.1

