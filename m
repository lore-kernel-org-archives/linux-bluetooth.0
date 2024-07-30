Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E01DA32
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336834; cv=fail; b=tzBumjJZUCKZqC+LanMJW9ZggqH6uMBRdK0zRXFxx9b29hLlNvuIaw7GB+LpJFB+CY6tUhI+wrtpsK6vgngVzh9JucTkI7B+tC+uFkZ3Bbi2z6vQfkCNnsw4koX6DDQF8WcdN7mN7bYnKstPP8L5ottuw6EW1OfoVbbj/u0LME8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336834; c=relaxed/simple;
	bh=VjK2KK7oJwzad35wcAnc0WRVrp/dn/lQEt2hKxMxljI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rSJCQFxMJnXMi2uYkjqu+nPF/0QPEjfGIwpOHZeJinAzfmSE6nUgQf2RwSenIWK9y3ZpR9sY6Vye7if8DZ3pDiyOfM6exEO5yaqpuT7/qsHg3yh+9DA1TLRYPZhnkk1AequxosJ0o61nskZVTjrQMEH4ppXoHzxpz1VvyO+ut4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W+sOoShl; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W+sOoShl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHIAbeYxgxA1t6tNgS9hoi2J4iH3pNpV5LbOotWLFrDydAiLGqU1RoQNHKdMEjDYBur269I78y3uTeNFNU1MdMC/rgjhj6HR+wq0/HzRjQsP/RdcaDmwFtljRgThoiwZXvfJ3D9Qw6yPNh3p13vhnNNdHQYMrVI2PUL76pX6Am69XEnxKI58oVIqvwh3rvfdG+DJkehiY5s/hQW9n8BuCdpR+0yeBu+brNEZIuySru46V282HqkZTFVd4vVW8fGEvmCbJgrDUG0DYjYS8/4sHigYbiU9slGCwASxSU8OnbbVCLAryMiUbMSTedpTtVtJyhZrzD1aRB6oVwCLJVxpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr9lMtaeE65NpeZxb8SZrnZi69RokeqBdI9aRzpneWA=;
 b=fwTrd6nSYgHRW64yrDQ1eYW0z+okTxQQoPb69BzBWHoX0R58vOp8QiyNXafPw1WFK13P3JjgbZ4Y5S+qt9ErdCarKKNkKUo7L9LSWNgaNyRT2HGw7HhUGp1ANz0O5YCkuIzsVhQO/XOWcARDmz3nVl2OD/xfYSdHCo92QOarNFZiC74QFaK1kXtC+h3afguqQ54GJoNSPDJdxNTrtlvlhTlF1oRdNsBGo/5JWnVRLmzDsQPkLkVQTXPP5hyg7UL4TIzZsZLuHv76fXR6NtrmYenowzO5LbnmHntHpyUWfxOFFx7qEFPqZhrAK/+nAVa1/ih/jdyhjd/9CkhFRVN89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr9lMtaeE65NpeZxb8SZrnZi69RokeqBdI9aRzpneWA=;
 b=W+sOoShlZJqdvFfNjg50U3N3pWkOzbuGvzky/6SvalP6puUEwn+YNlH9zxxbsIfqg81xdZb9Emca5KyQm/9zFUO+DDGnXQdM7K/Xs0gh1OMQZtAStkLq2dFI0AYRihuVc0/lfC58qOV8NMt8p9wssVr1sTtDFYJlJYYv+lVtoyT5T0F15PjiPb1JD16MftmZHncG+tn6AnAz6hNXHRIvn5ixrIQqNRoZ/m2ZG8jd2R45WjIjnOKY9yZBnwZGHp6hr8loQlQmScNHMpK/AOkCifqgHsA9YLUDgKzib6o0eAaBN4hxGCNkptNtA5Z+mdvvqf2a+Sw+TuRhW21b0q+gqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:53:49 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:53:49 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 0/8] Add 'broadcasting' state
Date: Tue, 30 Jul 2024 13:53:05 +0300
Message-Id: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0212.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::27) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: 14dd125f-525b-4ccc-c938-08dcb085d946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ObObKqoUnYH7d+sKom/X6GvyI49bZVV76AIqVNLBsJLzW/iROh0fFf2ATQap?=
 =?us-ascii?Q?H2NirkCs3Wkm5iAkv/cSyz2ZAEDMCqEte16l7jlyQI2m1cOVrGAT9PLu1Wzu?=
 =?us-ascii?Q?pk5m85COIpgi3uiLN3LSn/5t/2I/8sF6JWHxToDn0YuFNPOLweBqSczVvneF?=
 =?us-ascii?Q?+ZSuWHl534/xh5ZR8Mmn2VX6BwgrVvvavOoWifal6RjC51/xvL2o8HPNLHON?=
 =?us-ascii?Q?yMQUHzp2m36JbdTUCc7N+dfgqSSfOtjK7e5/iKR1q1Uv04itdkwchdf4G/hg?=
 =?us-ascii?Q?c30PmW34CpZx5WMyQhJLz4kHEn8rDyY8E1RAS4e4uBewj4c6S1vSc4ZaQCNi?=
 =?us-ascii?Q?dArSA02sPps/hxqz+XdKzOU05urLj9lmiskL+0qjU4oPHr/XNr++mVZT1GNw?=
 =?us-ascii?Q?RrG08vr30ouVW+YWXuAYapi87THOxGXiC+xgxbSGw/J9BMAM1/1vufjmIXRe?=
 =?us-ascii?Q?RdU6P+C0EPlAB/+wTO0p3R/OP3ChJOpfDMNagu0jbIVC8xJP+sNYdW/qd2p8?=
 =?us-ascii?Q?wCxrLU1w+tVaMw9lLJXHEK7Qtc3nX0lvfQzF7ecWy5TyNA47fP/7V4iiyAW6?=
 =?us-ascii?Q?t2XJ21GGMZnHRINPIBC09ormT5518po+ioFRzZmsWRDDwt/Yyf43PRWgI+HF?=
 =?us-ascii?Q?bM628GqylKTz+vRbTLl7EzhDKxqmBEmZNVpdGkA9H86OWu+m4/ey/XcJqUvw?=
 =?us-ascii?Q?xJthTG3LiX2XuZ8zDinNPBYqZQs434Dt0JdPr92/GRA1zPEWntbRL/teoVgU?=
 =?us-ascii?Q?2BnT+hmr9InIFvcPLYIUntcd3LSFQwzHXISoSwryr9+zrODAMv/23omMWI4O?=
 =?us-ascii?Q?INQZ6ynxFugxsvMvb0VPBTBLjFULLvz6lRbmfxiM9ojWqU50VWktn/F/0OXy?=
 =?us-ascii?Q?Jif6+B9N2bab/45PL8wDehQGo5PNcN2aQ0g5ylR5xIawVyr63CHsQkgXH6V+?=
 =?us-ascii?Q?3Rn5GJhWQyl+WosrPiNI8KxlUnhFq5+MBsO5fF0GZxw57uC65wE0P2064quv?=
 =?us-ascii?Q?VzH4rhx8/YxE53mr6p3kQPw2GDKbAXVWXeT0hCWgONrMtMwg3iBSJVfAIZBX?=
 =?us-ascii?Q?FNgS3qaygDOcpsPVbnmD41yCTUldFYDxTEFje8BuZuZ7YYdnRNCrFjMjFAqq?=
 =?us-ascii?Q?Kf/p9cXDFko0Da21roGIcNwNThqzRt1kz5XauPZsDdc7/05QuUmuXt0L8mF8?=
 =?us-ascii?Q?8WCOqGMNG7ZUmzYldSgUNqkZy6uuwOhvgXlbKNyiSw/+/r4WUX1xhd9Oz+jK?=
 =?us-ascii?Q?uKJ3ZaK4z8T9Y/T+67Vtes3WN3XwNaj7VzKN3ancSJ/AZ5tqSIy6qnbSbFmp?=
 =?us-ascii?Q?+DmN0gN9UnXK/EJFdzsJZm/lCPCOUCa40K7IgPFtMqmb/TAPdU9ddAdn6uym?=
 =?us-ascii?Q?tePmE2V1ZoPYDYau6l8DsJPAKcLHdatI6abRlklBDePN3wMEWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VzOXyn1+wOtJgn09lLR/7HChcFeMqzabQrbz0u6h++AqeEMKF52raw9Irq22?=
 =?us-ascii?Q?GT37BYUvcypYrj2dUqpGqEPpNqSL+cJvq6RxVwqU56oTg1J5GG3cBl/YF/Cl?=
 =?us-ascii?Q?luBvySrx0m7qnbWz+6P7QBs/icFMM0QT4FtpI5bdcirQE2HgmzO3+SMInvql?=
 =?us-ascii?Q?zsJFvxVU3riIBvtPbuPZUcgyrchJicAEV8sMvOM/H++5rJH8EnymkUi5h6h3?=
 =?us-ascii?Q?P8fXsZ/73uqqFrJJIE4ox9D1kxHbF+i6HfGHrYxQsblZwJz5u/iOAZf0Njx9?=
 =?us-ascii?Q?N6QOZPL2vDGqoiFKnrauaIgaqY+YFMRZSGN3vu4q9kimgeH9JRbE2C5bJbW2?=
 =?us-ascii?Q?n4fxzf8faOXFjmduUvOPyiLL/exx0mz7p9h8UUkF9fjikU54ko6z7TDFKaoT?=
 =?us-ascii?Q?KdzLeG7CowvLJE2J5qx39hTv8zv0p5Vfz6t0vYwF9MpQdVFfSrBhLXLVAmsL?=
 =?us-ascii?Q?3qhNxngrN5/S/NmMo23+CnLlLOyNdYSePbgYsvRwknGOBPTXIWhQ+zUsuKis?=
 =?us-ascii?Q?UzY7ser4VAXGzYhqwU6sZv5g6SyH//TT57rVU0lCuBF5831cA4F/mcz7lbMX?=
 =?us-ascii?Q?vtIqN35BudNMWNQHP1bZow/hkPHaFvXqgsreSbQKjTjaZvuwztNssWYIvXJH?=
 =?us-ascii?Q?e+3thVJiFLCFCNXEQOYeLj1AHnuGSTyGLDlAIZicGSnHDWn06ECjLXnAaZsd?=
 =?us-ascii?Q?Ia2OOdnoXvoVZjjcbB/JsDWo+LSa7TkA+rKiNPmJyl0VpOJ3FGHdeWiGCLym?=
 =?us-ascii?Q?ThBlcD1Roq8Ayincq8v7B2tr13UPFxBvab3utnOlhrv853Qi/mXhmMcLhTZa?=
 =?us-ascii?Q?2J7bCbNDT3lU1HtXFSt5Y2+dHI9sAxmnEG2Eu3CkauydbtePnDhSWU0CB6KL?=
 =?us-ascii?Q?fZDQRFpO0s17i7kNxV+Yp1HDbZ8USE1WD7WbIB39HXNI5nXhhMf6+/Iv6Rdk?=
 =?us-ascii?Q?h5h7epfpJJZaklDy+mgZV0L6RlxlJL/Heeb62EfzKgsOHIyL+2Hl0PD3gFUD?=
 =?us-ascii?Q?qCMNNsKXKBch5l3IaL+fpUS5QhniaF2Y10r3nusctlLaNIBWvf89f4GSBi10?=
 =?us-ascii?Q?bTwWoWspCxxUUyeRpZKVvV4fi78KuLW08kTRUKze9OSIBQZ2Uquz54SLk6rV?=
 =?us-ascii?Q?ejCGRTx22+3bJZnc4ufnBMvCaQLhIUnu5sczxvYkyZvAg7iVVkObvRMgs0+8?=
 =?us-ascii?Q?vycggBHQc2ZUtZnZFm7gNETjTD/pww1doa2zxXbyZgWkFO4n3AZ5yxe4W23O?=
 =?us-ascii?Q?Eg0IC2IR8VXwMR599x13nUfNWY3G9o0ghOj/we4nzXykNNk9FB4GWjrlns8V?=
 =?us-ascii?Q?a6Q3jGyxWzKsa+g3gGP+pwsx2xAaiXeYtMkmMfApjLtV1DrjNI8gF0xgerGi?=
 =?us-ascii?Q?ukjHRqYu0FtWqNAQHHwx61O8ModaOLFek8rabI53b20tC761uczaU6xOQIpV?=
 =?us-ascii?Q?lWdkmFt/hnmGWNXKwnhYYmrXPFXNVWzA+k+D/qrYS8VX+PkHwuVNn2iQ0vFT?=
 =?us-ascii?Q?cVPNU+diUcOrIG3+TOUNZZtOq/QbciOFgP9EUiW6Qc274twAII26+uKlH7Ok?=
 =?us-ascii?Q?BL3kxDp16pg2hOSA7nEuSrlopwfl2eu05W912MlU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14dd125f-525b-4ccc-c938-08dcb085d946
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:30.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jbZXGd7/K7K1GAaESkdjh0rqCLyH1Qm0qZgk4DCH2Eig88FSEojYiVTQJagt6ye0LEA1122ee1SgAKb8980spA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

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
  doc/media: Add 'broadcasting' state and 'select' method
  transport: Add 'broadcasting' state
  transport: Add "select" method
  client/player: Expose transport "select" method to the user
  transport: Broadcast sink: wait for user to select transport
  doc/media: Add 'unselect' method
  transport: Add "unselect" method
  client/player: Expose transport "unselect" method to the user

 client/player.c                  | 100 +++++++++++++++++++++++++++++++
 doc/org.bluez.MediaTransport.rst |  31 +++++++++-
 profiles/audio/transport.c       |  90 ++++++++++++++++++++++++----
 3 files changed, 207 insertions(+), 14 deletions(-)

-- 
2.40.1

