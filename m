Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2051.outbound.protection.outlook.com [40.107.247.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1621B41F
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331723; cv=fail; b=s4eMxzeXGsoUGe8ERVkH/xUrdZRIm2LEpobhvkaEx3K/JpIooudtxKa+9h9Lv6FlxNRsi0OXS6Btx3DAVXlUacNLbdOuk0nvuRmbsH2+4Jmf0Jb7W43tAvhGave6Sgb2u3qclQyS7I84WAzlt8kb2HKxnCn0fcbISKbt8h9SY3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331723; c=relaxed/simple;
	bh=tB38UpPEK1Jxc1xxOK56rDoHExWVwf+sCYSrP1/ZF7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qx3sYn5hZqCkC4ch23QkhjlirM5UiY0B9Yn7to+TYZy9HP/WHG0PTDBxJl0L1k/4W32+HIJmMo57wV6PPmHWZWjNAwelJd2gQ1oddYgJph1au7gkbyb1XwR32qe97cmtrnDfb1VPnZDCK/czBsdLH9E6OB04GcsPR6rgUn9nt3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jbdyVa6y; arc=fail smtp.client-ip=40.107.247.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jbdyVa6y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJsvqbJZTYwZcMkM5Tg+1PudVC+4ZI4X+EzxuDMJiyGSvhiuLBWNr/2t8ghYYdTPKruMowcM45Ki1m1PDX6lKgHY5Ag4lNsQHZlYLmyiVqB1FuQ6Hzmn91UbndWFTKRk4k5rCwJ3cFL7rvchET10l2w5Tq7LK8odPmT/05qKEFFfrIausP7qgn46Xv5WChKiDlV9KX4T+yUNsZ25W6sreuDEWuMNygL3Km1HGm4O5kWOOsZKsfgKiz9iu8Zk5GglgU43m1emMVST1/gVS5EBSfZGgmrYqcoPt6KxaNHVDhH5JtPF4dsaLccrdUOWCNM7DC3uhDdlJUD57gs3wv8Y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPw2xsFzSdFxXdOV79k3wOdYsZMUJ7ir86RxVvhueDU=;
 b=Vptuh+bKLn+Jbs+YCBRkBo2MFEbFkK8ZyRjK04F+mqAR9HJNaMZCA7SuOI+WHNp4PgQY5O+ErpsaCOUuqWOstROh0uDHa1dt9IMnimqir1TRXoOnv2n5uGyH2CUl07auumULd8FH/z0uHp6OoXKJW0WsQjRI6neyVIulSvZAuQzH5KU8RQtXKwEiI9HTCyWv+cmViz9uV+HDl0i+B8Nq60uOv9c1y1R33YQmS5uFLGuFvh0G9HY55byvz791u/YA+r/g96XejnYa2ffagR1GTLj5zhQSKiCUTqm9bAqunenMD0ebazokBjmhMjOy2YvlGY/UvrtQLyihrcUoiv3hmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPw2xsFzSdFxXdOV79k3wOdYsZMUJ7ir86RxVvhueDU=;
 b=jbdyVa6yDajPqF5pMIyh/s+DrZySGqcxbW3RbgaXgrMlTBtwq9+s7nitebd72stTnOgBeWcb0USVr14TMVnGxuKwS80+Osgsi+GXy+8NDtQHb94MctighAJj6TI9bxr8JjK32fBwPQk6dKcByJbFiyZn6+lVvU65O2OabJkPB6Ex6w/YmewObj63o2eiPqstMknxXbH2tf+4OnUYDs/Cxq31FKRf/xUUN9EXdboSkZsiDH0I7yLWRm4lpx0E19FzoJdBop35dEbxO8caGn9DFYyZTf8d+byAL4bAvDRh06O1Y2nvVYJtmbHN2ihZhNwt0XMsS8WIrjhDafLXMmt27Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PR3PR04MB7211.eurprd04.prod.outlook.com (2603:10a6:102:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 17:01:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 17:01:58 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	pav@iki.fi
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix sleeping function called from invalid context
Date: Wed,  4 Dec 2024 19:01:55 +0200
Message-ID: <20241204170155.14181-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZ+KcZ13SF2yksP3su2kY4sSCJgiF_o0OfrXTomFigmKbQ@mail.gmail.com>
References: <CABBYNZ+KcZ13SF2yksP3su2kY4sSCJgiF_o0OfrXTomFigmKbQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0012.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PR3PR04MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 653c6df8-450a-46b3-9f04-08dd14855ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f9AlZymH4m4pIvHTRLI58Ue7VG8Yj9IzobtRsi/xp6tFPF9KwtMazbZSGuiG?=
 =?us-ascii?Q?KYSWW0a3luzIpKjExquEU7wrVCmrMgTsCYyGicMRbNQ7PM1QQ0RmjqTG7HXf?=
 =?us-ascii?Q?maZfZ1XE1hLgr4hFHy9M3RQEDBL3/UVSFZnTmNQYhxTXTa099Ihf5wLbJs4F?=
 =?us-ascii?Q?KH2K2u/xURiSSls+KE+4R4PNj9Tt8g90GN+uPufILtOlcCikZylOY9G3EEfg?=
 =?us-ascii?Q?CA8IF+2ky3I2zkAY91SFr30D3fZlGYnlSEzzTd93fr2/0c46kVO+dYxjvmHO?=
 =?us-ascii?Q?+nfmS7xR3O7+y0ixOEfXO4LIoOLB2xVlbXPqZfxmPtp+bPcLHAKHfVt/oCyP?=
 =?us-ascii?Q?KyCtn6gQ4YRdPKgxm+9UndcTABxtQ5xo5KBm5EWhYShQ1cNaO8fDzXWYkKiR?=
 =?us-ascii?Q?Xd1QP1w5Fy5kAdIlQ9K0tBmyCx0HcMuOnJEvR0DSTgOd27p1yBzBwD5QE4zL?=
 =?us-ascii?Q?VxvsGgN62eAERuVG9zPkXCo3gjw5E2TMH6et4gBHCEdtmIvYRrHmpLYL0pN4?=
 =?us-ascii?Q?mJGYpS3YJ33BAYjbleqTvTpSBi6Mvci5Z0h3Jg5iQV86lHCh3ky2LUpbeY+T?=
 =?us-ascii?Q?vWiIIieZEpDJaStT5Fvsb8IRZjMFg64NX+w1za+bms+z+kYanzKZZubHUdtw?=
 =?us-ascii?Q?LrjxwQ9iHikrp3+hugesKFDDiuBCbVTaukbsGUDvZ3waxyaASvWGiX2W+6UK?=
 =?us-ascii?Q?14ADY0GrnT2QVlZxjI4sqBs8ZoplyxJCi5duweyDeGPCVYSj/GXFxgXpKnVm?=
 =?us-ascii?Q?Iv6w9tqeb/vl4V7ZcpuLNCIYqVNxKoWJq1gA/uJwlikFrvB9ztuLlpOHfpJW?=
 =?us-ascii?Q?HBGuzMd0ONpxnIiTKkVUaOta18dL2dREH4DX194ouV7Jwlj9NPGmct0yIXnk?=
 =?us-ascii?Q?TwZVSMzMT5D/8UR7j1CyNCEKQcj8rfESiYRMwFNYiLwNWYP+3lzleAoRvRcK?=
 =?us-ascii?Q?0mvF+ZxMlJHLzBlqPIQpIVhm9UbUH7FEkJQ9+dRSadqCpWfPTEB9ktahYZlq?=
 =?us-ascii?Q?9HHD2cxLQtuUSpDuIjV390qFDZmZ+GRPnc1TLbGYBsAuntOzA36ssjOHAHKS?=
 =?us-ascii?Q?RXEm5YtXVSPeGpywJDk0dHqRjjjq94M2vdLe6OqSccuC3Ju6dnXlBEB4U0Ml?=
 =?us-ascii?Q?By2DNmJubu77WRoZuyqqkk19D7yOSVwEupJbbNvTfR//YsNRakNKVkZQlriQ?=
 =?us-ascii?Q?e64G/6IWpkP76GbP9FerLbSD2bU/Wx9okdzusowNdvBrlLemYVFxgn41CXzv?=
 =?us-ascii?Q?wFYNcSMq/YnKwjlcj8MIXpG5ISpvHx7qHLHB0hmCwUgB2VJGe5LcwrYowbr6?=
 =?us-ascii?Q?TFU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QAwdytgDLiaqWkfElGA1NLR0p6w+9MkXXt2n9tL3dNaIS6NDIte1d/1F2CNO?=
 =?us-ascii?Q?tK3AD/t4uolxUEu0GdBQcXPav6Ayn5zRkLNXdd2aatzJHjOZ2uGKLkecQzRj?=
 =?us-ascii?Q?530SheTAobGCMv1cxxxGhdnSNWaaXHht6xfoxQ7yhZdb+ygJd/poBaPMZN7N?=
 =?us-ascii?Q?qjjG9Xt1Nzt6wY6wndDaEO1xd/ZStnHNvcvp0cXscWLNBXVMPrwWJDX0LQr0?=
 =?us-ascii?Q?kry6NyOGLmlpAXLSf6RRwa9RgWZsmii1K3p68Ixw/8zDIIn0lo1NpLxL9hCY?=
 =?us-ascii?Q?vpMn1S6fMpehr4me1HX+C5vGG6v6CHuSYffzWaAXSRwqh1DkvtbNeSWVUHCE?=
 =?us-ascii?Q?8YAckdXxu8a+Oe286KDU2ytQ9irn/nSri2ydjHicjzVx6Hz3z/pGlO8UJNfD?=
 =?us-ascii?Q?QazJFPL44NPC+ikTevuYxzdi1r2oC5XaLvb+C/mgKcXz/0em4eSFrLK53XJv?=
 =?us-ascii?Q?29+2F6Dp0ZS4+q/b/OjXG0VVFqFp1B52rilUdEUzUwVH1XVM5Y482KQfGuv/?=
 =?us-ascii?Q?DkrWnKp28v06CVY8cdIkOUWqvtFMAR55Xj4aIjto3VUmdBdD7EUpAhCegytF?=
 =?us-ascii?Q?lFCDKB1AsGCa1guXhi9LzsNZ7rN4tCnNksiNnIEp3o+3diZu3KnXSIxQ+9NE?=
 =?us-ascii?Q?kJnku3XbUHJoelpIFOjhUuK7NPIaJj98WyKhn3VvpgpVtujL5H9s2iFbb86v?=
 =?us-ascii?Q?tf8glerRQLOElR38/wXa8R/wX1KCC0yVVMtrsYcDh5v6NaJyLWh484ATEro/?=
 =?us-ascii?Q?TTbDVTfIUcT7d5qxWGPoquzaENEWu75PiF/hgFFEZiJomatrPgJMXOLLPJGb?=
 =?us-ascii?Q?1vlHNcrVivDkrX59F+RxAySaPu3EQXEuCzuOCeK3dKm5K8ZfuRy1ASQ5QXEs?=
 =?us-ascii?Q?jKj7+effM+FkgtBnS/TFOV08g3V0Ab3Bpd/K6nWY2mbsZDjAp1ctQIVDH2mX?=
 =?us-ascii?Q?3OYrOqraLXS3erZJD+3tNiqEOoOos12jacTOcKLkocUgBLi2ZqTMU66OGifE?=
 =?us-ascii?Q?Pf7rs/Q7OOVPnvhpGbZ22WEpwlFxhetE526+R1+9UvJ0jIPwlHjkM1cEsKXT?=
 =?us-ascii?Q?wQ7q8friuXi8Awd3q6f5yX81IJoKm0oLhyPL2FMhwBkRdDiDLrMS8MfF5NlY?=
 =?us-ascii?Q?k66Zrl4pO1ACzqzD6Tbxv8qtm1ArDEZ6Y67itBNbwFttjh6H7mL9nQCoy3Xn?=
 =?us-ascii?Q?ScWPZVejaAdSDw+tvwj7JOBCHBaB3N3TIvWRV9TsyZ4cChM6Xwhx3OfuQK9r?=
 =?us-ascii?Q?jG07Ih97iz6QSJ7IkVHvkl/7XI8qvUK0uby1UWqp9+Cs5rlUtagxNruCKnvU?=
 =?us-ascii?Q?VMFk0PEK4UXM+OQk4H8n+B6DE8jsuhxaBeiu8cTa60/1m/z9ENhv4IDiSYY6?=
 =?us-ascii?Q?4naffibdC/sx9ArMwCrqdpaqDnaUym1b18Ax3LxD4ZADR6sldwW48WOERKbe?=
 =?us-ascii?Q?wxbe859ECYD2K0cik0O/uoCWgGPL3TCCzVRMNvMDJwWKgxM7d4lhz7fhvMa8?=
 =?us-ascii?Q?H12oHc2I8alVGj3S/RFTy0ukEWbs+yDol8sP1OQswyayrB11Rqq/hB0aDmRv?=
 =?us-ascii?Q?5xo4JWpHhUeMa+mEROTQNoLoZCUcXA7plgDcr5RcJLg8nQETpo17jLHXHEtY?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653c6df8-450a-46b3-9f04-08dd14855ce2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 17:01:58.1308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i6+xsV+avS6hAbOXR7819+EZ382JT4JRrUY/BwDDP1a1dX8TEiTHSYb2NHRwlH/svukterVBYU1F0zGJV/Lfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7211

Hi,

>From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>To: Pauli Virtanen <pav@iki.fi>
>Cc: linux-bluetooth@vger.kernel.org
>Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix sleeping function called from invalid context
>Date: Tue, 3 Dec 2024 23:31:37 -0500	[thread overview]
>Message-ID: <CABBYNZ+KcZ13SF2yksP3su2kY4sSCJgiF_o0OfrXTomFigmKbQ@mail.gmail.com> (raw)
>In-Reply-To: <0b897a445022f99bb812c811135fdbc8bf73bbba.camel@iki.fi>
>
>Hi Pauli,
>
>On Tue, Dec 3, 2024 at 5:48 PM Pauli Virtanen <pav@iki.fi> wrote:
>>
>> Hi,
>>
>> ti, 2024-12-03 kello 16:14 -0500, Luiz Augusto von Dentz kirjoitti:
>> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> >
>> > This reworks hci_cb_list to not use mutex hci_cb_list_lock to avoid bugs
>> > like the bellow:
>> >
>> > BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
>> > in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5070, name: kworker/u9:2
>> > preempt_count: 0, expected: 0
>> > RCU nest depth: 1, expected: 0
>> > 4 locks held by kworker/u9:2/5070:
>> >  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
>> >  #0: ffff888015be3948 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
>> >  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
>> >  #1: ffffc90003b6fd00 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
>> >  #2: ffff8880665d0078 (&hdev->lock){+.+.}-{3:3}, at: hci_le_create_big_complete_evt+0xcf/0xae0 net/bluetooth/hci_event.c:6914
>> >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
>> >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
>> >  #3: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: hci_le_create_big_complete_evt+0xdb/0xae0 net/bluetooth/hci_event.c:6915
>> > CPU: 0 PID: 5070 Comm: kworker/u9:2 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
>> > Workqueue: hci0 hci_rx_work
>> > Call Trace:
>> >  <TASK>
>> >  __dump_stack lib/dump_stack.c:88 [inline]
>> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>> >  __might_resched+0x5d4/0x780 kernel/sched/core.c:10187
>> >  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>> >  __mutex_lock+0xc1/0xd70 kernel/locking/mutex.c:752
>> >  hci_connect_cfm include/net/bluetooth/hci_core.h:2004 [inline]
>> >  hci_le_create_big_complete_evt+0x3d9/0xae0 net/bluetooth/hci_event.c:6939
>> >  hci_event_func net/bluetooth/hci_event.c:7514 [inline]
>> >  hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
>> >  hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
>> >  process_one_work kernel/workqueue.c:3254 [inline]
>> >  process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
>> >  worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
>> >  kthread+0x2f0/0x390 kernel/kthread.c:388
>> >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>> >  </TASK>
>> >
>> > Reported-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com
>> > Closes: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
>> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> > ---
>> >  include/net/bluetooth/hci_core.h | 89 ++++++++++++++++++++++----------
>> >  net/bluetooth/hci_core.c         |  9 ++--
>> >  2 files changed, 65 insertions(+), 33 deletions(-)
>> >
>> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> > index ea798f07c5a2..95f11f04e24a 100644
>> > --- a/include/net/bluetooth/hci_core.h
>> > +++ b/include/net/bluetooth/hci_core.h
>> > @@ -804,7 +804,6 @@ struct hci_conn_params {
>> >  extern struct list_head hci_dev_list;
>> >  extern struct list_head hci_cb_list;
>> >  extern rwlock_t hci_dev_list_lock;
>> > -extern struct mutex hci_cb_list_lock;
>> >
>> >  #define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev_flags)
>> >  #define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->dev_flags)
>> > @@ -2029,12 +2028,18 @@ static inline void hci_connect_cfm(struct hci_conn *conn, __u8 status)
>> >  {
>> >       struct hci_cb *cb;
>> >
>> > -     mutex_lock(&hci_cb_list_lock);
>> > -     list_for_each_entry(cb, &hci_cb_list, list) {
>> > -             if (cb->connect_cfm)
>> > -                     cb->connect_cfm(conn, status);
>> > +     rcu_read_lock();
>> > +     list_for_each_entry_rcu(cb, &hci_cb_list, list) {
>> > +             if (cb->connect_cfm) {
>> > +                     struct hci_cb cpy = *cb;
>> > +
>> > +                     /* Callback may block so release RCU read lock */
>> > +                     rcu_read_unlock();
>> > +                     cpy.connect_cfm(conn, status);
>> > +                     rcu_read_lock();
>>
>> This looks like incorrect RCU usage
>>
>> [CPU 1] rcu_read_unlock()
>> [CPU 2] hci_unregister_cb(cb)
>> [CPU 2] hci_unregister_cb(next cb)
>> [CPU 1] rcu_read_lock()
>> [CPU 1] list_for_each_entry_rcu -> iterates to "next cb" not in list
>>
>> If all hci_cb weren't static, it'd also UAF (maybe it is for rfcomm?).
>>
>>
>> hci_le_create_big_complete_evt() also does this (and maybe crashes if
>> ev->status != 0 ?), so maybe it is simples to fix it.
>
>I guess you are right, it seems incorrect to have
>rcu_read_unlock/relock inside list_for_each_entry_rcu, that said I
>wonder why the entry is not accessed via rcu_dereference, anyway the
>only alternative I can think of is to copy to a local stack list which
>we can then run with list_for_each_entry_safe, or we create some
>mechanism to differ actions that otherwise could block/sleep while
>holding rcu_read_lock.
>

I submitted a patch to fix this for hci_le_create_big_complete_evt:
https://patchwork.kernel.org/project/bluetooth/cover/20241204164840.14037-1-iulia.tanasescu@nxp.com/

>>
>>
>> > +             }
>> >       }
>> > -     mutex_unlock(&hci_cb_list_lock);
>> > +     rcu_read_unlock();
>> >
>> >       if (conn->connect_cfm_cb)
>> >               conn->connect_cfm_cb(conn, status);
>> > @@ -2044,12 +2049,18 @@ static inline void hci_disconn_cfm(struct hci_conn *conn, __u8 reason)
>> >  {
>> >       struct hci_cb *cb;
>> >
>> > -     mutex_lock(&hci_cb_list_lock);
>> > +     rcu_read_lock();
>> >       list_for_each_entry(cb, &hci_cb_list, list) {
>> > -             if (cb->disconn_cfm)
>> > -                     cb->disconn_cfm(conn, reason);
>> > +             if (cb->disconn_cfm) {
>> > +                     struct hci_cb cpy = *cb;
>> > +
>> > +                     /* Callback may block so release RCU read lock */
>> > +                     rcu_read_unlock();
>> > +                     cpy.disconn_cfm(conn, reason);
>> > +                     rcu_read_lock();
>> > +             }
>> >       }
>> > -     mutex_unlock(&hci_cb_list_lock);
>> > +     rcu_read_unlock();
>> >
>> >       if (conn->disconn_cfm_cb)
>> >               conn->disconn_cfm_cb(conn, reason);
>> > @@ -2065,12 +2076,18 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
>> >
>> >       encrypt = test_bit(HCI_CONN_ENCRYPT, &conn->flags) ? 0x01 : 0x00;
>> >
>> > -     mutex_lock(&hci_cb_list_lock);
>> > +     rcu_read_lock();
>> >       list_for_each_entry(cb, &hci_cb_list, list) {
>> > -             if (cb->security_cfm)
>> > -                     cb->security_cfm(conn, status, encrypt);
>> > +             if (cb->security_cfm) {
>> > +                     struct hci_cb cpy = *cb;
>> > +
>> > +                     /* Callback may block so release RCU read lock */
>> > +                     rcu_read_unlock();
>> > +                     cpy.security_cfm(conn, status, encrypt);
>> > +                     rcu_read_lock();
>> > +             }
>> >       }
>> > -     mutex_unlock(&hci_cb_list_lock);
>> > +     rcu_read_unlock();
>> >
>> >       if (conn->security_cfm_cb)
>> >               conn->security_cfm_cb(conn, status);
>> > @@ -2105,12 +2122,18 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
>> >                       conn->sec_level = conn->pending_sec_level;
>> >       }
>> >
>> > -     mutex_lock(&hci_cb_list_lock);
>> > +     rcu_read_lock();
>> >       list_for_each_entry(cb, &hci_cb_list, list) {
>> > -             if (cb->security_cfm)
>> > -                     cb->security_cfm(conn, status, encrypt);
>> > +             if (cb->security_cfm) {
>> > +                     struct hci_cb cpy = *cb;
>> > +
>> > +                     /* Callback may block so release RCU read lock */
>> > +                     rcu_read_unlock();
>> > +                     cpy.security_cfm(conn, status, encrypt);
>> > +                     rcu_read_lock();
>> > +             }
>> >       }
>> > -     mutex_unlock(&hci_cb_list_lock);
>> > +     rcu_read_unlock();
>> >
>> >       if (conn->security_cfm_cb)
>> >               conn->security_cfm_cb(conn, status);
>> > @@ -2120,12 +2143,18 @@ static inline void hci_key_change_cfm(struct hci_conn *conn, __u8 status)
>> >  {
>> >       struct hci_cb *cb;
>> >
>> > -     mutex_lock(&hci_cb_list_lock);
>> > +     rcu_read_lock();
>> >       list_for_each_entry(cb, &hci_cb_list, list) {
>> > -             if (cb->key_change_cfm)
>> > -                     cb->key_change_cfm(conn, status);
>> > +             if (cb->key_change_cfm) {
>> > +                     struct hci_cb cpy = *cb;
>> > +
>> > +                     /* Callback may block so release RCU read lock */
>> > +                     rcu_read_unlock();
>> > +                     cpy.key_change_cfm(conn, status);
>> > +                     rcu_read_lock();
>> > +             }
>> >       }
>> > -     mutex_unlock(&hci_cb_list_lock);
>> > +     rcu_read_unlock();
>> >  }
>> >
>> >  static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
>> > @@ -2133,12 +2162,18 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
>> >  {
>> >       struct hci_cb *cb;
>> >
>> > -     mutex_lock(&hci_cb_list_lock);
>> > -     list_for_each_entry(cb, &hci_cb_list, list) {
>> > -             if (cb->role_switch_cfm)
>> > -                     cb->role_switch_cfm(conn, status, role);
>> > +     rcu_read_lock();
>> > +     list_for_each_entry_rcu(cb, &hci_cb_list, list) {
>> > +             if (cb->role_switch_cfm) {
>> > +                     struct hci_cb cpy = *cb;
>> > +
>> > +                     /* Callback may block so release RCU read lock */
>> > +                     rcu_read_unlock();
>> > +                     cpy.role_switch_cfm(conn, status, role);
>> > +                     rcu_read_lock();
>> > +             }
>> >       }
>> > -     mutex_unlock(&hci_cb_list_lock);
>> > +     rcu_read_unlock();
>> >  }
>> >
>> >  static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
>> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > index f9e19f9cb5a3..25d180d225c1 100644
>> > --- a/net/bluetooth/hci_core.c
>> > +++ b/net/bluetooth/hci_core.c
>> > @@ -2993,9 +2993,7 @@ int hci_register_cb(struct hci_cb *cb)
>> >  {
>> >       BT_DBG("%p name %s", cb, cb->name);
>> >
>> > -     mutex_lock(&hci_cb_list_lock);
>> > -     list_add_tail(&cb->list, &hci_cb_list);
>> > -     mutex_unlock(&hci_cb_list_lock);
>> > +     list_add_tail_rcu(&cb->list, &hci_cb_list);
>> >
>> >       return 0;
>> >  }
>> > @@ -3005,9 +3003,8 @@ int hci_unregister_cb(struct hci_cb *cb)
>> >  {
>> >       BT_DBG("%p name %s", cb, cb->name);
>> >
>> > -     mutex_lock(&hci_cb_list_lock);
>> > -     list_del(&cb->list);
>> > -     mutex_unlock(&hci_cb_list_lock);
>> > +     list_del_rcu(&cb->list);
>> > +     synchronize_rcu();
>> >
>> >       return 0;
>> >  }
>>
>
>
>-- 
>Luiz Augusto von Dentz

Regards,
Iulia
