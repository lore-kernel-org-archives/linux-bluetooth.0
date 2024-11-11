Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2055.outbound.protection.outlook.com [40.107.103.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1BA158866
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325728; cv=fail; b=IV/rBEX3x3X1bWAnEFWsIs1AuO8PZm5mojjnpSDFyGEjJOhIvFCfIOdSjtFtHD2un5vKUFteShdU7hBMg6jzigQx31Aw4xka7vlb0qcoC03hMwRuCrkA1ur3F6+c9cIuf7KIO7PwgWjZbalFyTJjTcB4a/3K/flhM8Vz7UMLklE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325728; c=relaxed/simple;
	bh=RYvSnfyeGVqK/busqYiEcjKnHFYKy821wAL3gBVQVnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bCKas0GFsw3ZJFqbljctGWRhscXnbnqJAYfWAZPQ3Rr0UP6v2tC4mXovsyPVG2tGsjFuTzFHj2btjJ5z8h403YTbX+YmbPIoF2m1M87y/8vmh4gzqT/KdN2zMY0H2d2B1p8ZA026C20nt1ktWOEsmZylRuzTmTszPhB1xoAPPbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HD5zO+l2; arc=fail smtp.client-ip=40.107.103.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HD5zO+l2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGfuz4jYC5hlyhiUhZVkFnRv/VHJnhLzYt2VUJ0AI0gb2780K6SeiN7pBCHyhaD3V6VwpvULuKe1Srlut15eYCNZMdvNPwD8hOC1VzAl8KMc9mo7yay715iQfXCocrnHGtV+ajgfCYlmB/UUIXNdLz8RVvYuisN8mwYKl/K1RZvQYsawXd3lDtZKVHUqzoWXIft523DADoof3HU7b5GFiogFVYYzVFViSGdfX37b7b58ct2ZkUhvkGnZIj7pw2vvtNiXg+/ItTlTspSkX+uOWZ/6G7O2g3su+KvCeIVO1KPSAuCbAqj53gTo4VncHD+/fCp2L+8ve/sofqTUxNlkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by+7kqyQZx77lpYwXHZ8r9D3Ovc/QAoUqCU6JVb7dlw=;
 b=UF6XHwcGBcNTT/wvkd/0XF2kPDaNRQxfiiO09mwAXEnNlGIZk63KV0lQhsOiXWrEp3GMo0dqG9MpUljTmpJw/YRyjiVR35oIcn1lM7VT3VEJEjOnZL57TcWzxKJCAtfiuMCz9ejYnkd6IIvgSzjwy5UAIFWVB9ea6OrAtiBnyHvm98KURWd5aowRvpltNqneLICHZiFXsQBihiRs4Kk3LPlQmNqzSRCXT0noCnzSQVs9lpAtEX05iONlGUTA4Mg+6ya6cd3qW0S7ROYlCh5MRfse153lCMMGhdjRbuRxmv7STc50iE44g6TPVBawNJn9MS2s7i23wvCwON/I/iZM1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=by+7kqyQZx77lpYwXHZ8r9D3Ovc/QAoUqCU6JVb7dlw=;
 b=HD5zO+l2/Nw4xHyEZvQAMbM8OGomWCA6uK1Mw9pRMtpiNWAfy6jqpcBXFe7P9hkpkJ88WWTOYXR2Y6DsRrqxmwf1IzVqu15h4rPTkNw5t7ZubYNIyIVs60uXDhfJACi381w4mRoMqf39JSSNQjLTTAAB/0KtLCnnNwzo0LR43B8spxiB+CiK8CbeJmvghfaxWbbZ15FNU32aj2q2Lcb/Jn8zi/p3Vxl8IMbWZpFDZ8b7D98BB6Xbp64HDywHIJqrPnPl0nrUp1PBOJ03jvzr/o23nxL/Nrq34mi8yURrpabvxL+k+Ep6/zWdCkHpFygQLb7S0GzBorDzVAlmAnfnHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10301.eurprd04.prod.outlook.com (2603:10a6:150:1dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 11:48:41 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:48:41 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com
Subject: Re: [PATCH 2/2] Bluetooth: ISO: Send BIG Create Sync via hci_sync
Date: Mon, 11 Nov 2024 13:48:39 +0200
Message-ID: <20241111114839.10793-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZKSfcSeDehE0bJj7F6XBP10hknC6GDzqDQ3CrXEofjy7Q@mail.gmail.com>
References: <CABBYNZKSfcSeDehE0bJj7F6XBP10hknC6GDzqDQ3CrXEofjy7Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0013.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10301:EE_
X-MS-Office365-Filtering-Correlation-Id: a38e1921-a029-4cc6-2b11-08dd0246ca0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?796+c+8tOowZV/XShNeLpTSWGM9Llk+Oag0W6a2IsI6p1CKJehBym5WfIvqh?=
 =?us-ascii?Q?gEaFSqyxqL5l80ZAyP0a+VpRzAw9rT4Hrbojhb4YZgWypv3JalTHf+BLYFAl?=
 =?us-ascii?Q?pZfC4i6siOFL0Afv3uSUkaUclcF3f1ODZvgUsCbj4WXVSzOXsnyEUpAG21NV?=
 =?us-ascii?Q?iLQakWydgyC0e17sZN0nEFEc3C4wLJDpJpx7DA3V0LpzPuJOEHUX+oPU7NfS?=
 =?us-ascii?Q?TQGAAC48sDNpJeTNhWzN5TgBRldzczKvfs2NsNE3bHWcWVQ9yINKQWfrzgtF?=
 =?us-ascii?Q?4FmaZiym4NQRt2toUjzuJ1+PVlflk2KJlStw2DOjT7xPWt4iMXT4FH6eTYPl?=
 =?us-ascii?Q?VWtYL6xAvYEjlxM7DSgCwxwB4gg6s082TpCB1uIdeu9r62sIEJ1ss8TuMjqL?=
 =?us-ascii?Q?qyzxYovcDGZJkMMGzLKSHvxJ74KD8eR9QdOKP++H1zzqj2Mh5l0TF9v5KsVV?=
 =?us-ascii?Q?t2z6a+5cPOIep8LSYlMcIKMFAr/0oyhp5nrCkFgrBAmWt4sqCr+7IGVoNg+s?=
 =?us-ascii?Q?D+RL0f6UuYq+AP8cMCq1urTLGT5bkDy+L6Lpk3DTYtsISbUPnQjvj8T5oLvs?=
 =?us-ascii?Q?ZH9xYEiZ6lt6TliFJ5eiKxonadnMgmHknmAbqWjLMP+17JNgxB/3I6D1emaT?=
 =?us-ascii?Q?cDx+Eg0/X0l5NcbwOZZ+JsK48vxo1VuaPzcAgmj2hfDHh+g+QeuKG0/DCWKx?=
 =?us-ascii?Q?2PngU92ZXssYlmNClezulFekUlHPRr3dtgJ/WAppP5bPoium+G1K36SjGoVM?=
 =?us-ascii?Q?6mtv3XYLVsnicynz74nfa3584XD6uifLvwuGfN/oYX1hWHcoI2C1NKLp8Dng?=
 =?us-ascii?Q?0UZkeqvmL4IzvFgcTmf9/0oEHPppoOpakivV2yk7rhV++GCKFXu9j8PvKKf2?=
 =?us-ascii?Q?FTCDF+DmalJ8hWpDB+WuEQAga93CkDxeM/iXb1qUMlZoNUAFJME3yKUOtaz6?=
 =?us-ascii?Q?zUnwU9hlYcWObhfKREU0Oyr1qprxpTM0rsFeFX3YyomGa/UEfX51FAnuc3tH?=
 =?us-ascii?Q?D88kyXPDroY44b3KhPvc7g82AgMMiK5b3+ET8aJXfYI48IKJpC/HVMLHyb8D?=
 =?us-ascii?Q?Vli1IRlgarzghrDNipZmNT/kF70LtQx662lVn7D74+kuhDbhrwKmAShiAPTc?=
 =?us-ascii?Q?itPr28M3cqAhCipEQgLEqz12fw4tonK2X3l9RPHhBdqWH/vj5GFs+2yETyUV?=
 =?us-ascii?Q?9gMpN/NTqP3+o5uKsncjfKEX4CCjMBUosuZryNBed1ROrteStGtDXBNpdjkE?=
 =?us-ascii?Q?bdUmgqmiOOGovGSg3wK4uw6t1gzZSEEHmQwLGeDXpm/+KTt4m9+UBzgj30Ly?=
 =?us-ascii?Q?R6Z+S3N7rU0hTkqvNzQ2NTjy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbY/xLmVTeaHCgO8KNgjJJ87iU25vYG4fby/Z0bKu3RbGSVIrROnqFcOAGor?=
 =?us-ascii?Q?QWGYew4ydcauBVOQLge17yYSY+bWEhm1Dun9ZWVSZ+ZhXNzffbKc/fPmvfEo?=
 =?us-ascii?Q?daVcpWujF3YRPbX32i1wAAjLRoNHFfMrt4yZgX3ZWV4px9VIFL4SQ83tXPM0?=
 =?us-ascii?Q?/v0OkFyw44TMFvufpO9CNsDBjbkYM4WwZoJihTgPgXUt+3d3JkGBteuv6MSQ?=
 =?us-ascii?Q?BaP/teNYMcxrCzqbbvE9t8wJYcrIhM3y6H2y+iIhaZdDKltajKz5w1xN6MOh?=
 =?us-ascii?Q?7e9+QIjPXpccpL8jb2EXkl/1rzfDPFWUshHtOUUwbq58ibblGYLSy2g8t6+H?=
 =?us-ascii?Q?gYvrTJAzIhb9ulEZdciEso2PnyXN6ex1GZop0Zyy3V9zHI9nriptlGxAW+Wi?=
 =?us-ascii?Q?W2rVMtwkjZbX7qLVNSlNSTzv7OGs74aVjaqP6gjK2CSXh8iqiSOmBgjZ90FC?=
 =?us-ascii?Q?jz5kUd60BMdFgJnmitY2DsUsSPAj/zycynA50aG417xewbcMiOZHR4C//sfa?=
 =?us-ascii?Q?H0RIQzAjYuTNWck3BX9VDXcNTtKxEjUl1j8hiptf0TkGpwylmnBAN/wMol3C?=
 =?us-ascii?Q?uWVUzoQHRdfYL9loIJlOrnVZYYp5pPh76ZZf3hSvlRD63ylWMUz9GEVigtit?=
 =?us-ascii?Q?FktbURN2zOf+yvyXjOGIBWM518RruwI8stieF2f76TRG8hCqtecQxUEu79UU?=
 =?us-ascii?Q?152c58SdpDMn+rdl/gpOSG2jCYe63mNcgckTRwo7tCARvybc2lpOT+8CHnx9?=
 =?us-ascii?Q?nwgrLp5I/s94Kw5JNYy+fMXKg99AUI5QRfRt/pkBIJK+IyxFG3367dc1Qo+d?=
 =?us-ascii?Q?sbxU6/Vmk6WdEtlEW7lfQ5xv5daDg+DULxfsYlvhQLwjN9Lx/pTglsJKnDxh?=
 =?us-ascii?Q?fs9dVWE7/FIQcb0nuFHMOORHjiHDa0gkYGezWpQRcsQi8q367j6jpC6QJjmT?=
 =?us-ascii?Q?c+H7y2XIb6/MU40mQTD85xwhg1Xn3q3zut38K4mYBx2l7N0HYSLkFYpVHdBP?=
 =?us-ascii?Q?X0PjWEiFNiS2WD6skzFAZ08pgrjv6P+GIxEAv0GEUvxAkIBRZE/hrxsSwWSG?=
 =?us-ascii?Q?C4WjmpoeJhXQxmSYYnMUkQg24cXORok3+whik5M9CdlOuMNZctSyXwTQskFN?=
 =?us-ascii?Q?G8OFi/gyOIak8IsrA3dxgqHF25jUg4EHFVHgHKb93zOhaa8cZ1h09/9CiVDh?=
 =?us-ascii?Q?EUxMw/d4GGW5pPNJKBJ/1HBYKN+E9rE1/P/Dba9prF6hMOJD8kcEKYKcgKmF?=
 =?us-ascii?Q?/luo24O0STRq8glHfF89PnAKEA/rkzP0R+xtA9tPJnZDZKpd5PZhT7Jay9z5?=
 =?us-ascii?Q?eEY8fl/R/tj2JyN66dVjWw87VWs4jYOaXQvOjglnGhMcYo1+I+6k9BHAtScT?=
 =?us-ascii?Q?aTWAttamlxq0mcqhTigmsv/m//BUNitT9i1DK5MCEBZ/1beanSTGGND2eml3?=
 =?us-ascii?Q?+7BYogKsHdu0uK8kvHQy0wjzlUreCnaGdY6YhsBvvaO3SVAEN0tz7e/+wAIE?=
 =?us-ascii?Q?moGkVRv9xRqr5EiQZup+BJNi8yZX1v4rwUfsgyV/16IzlWJcv2CHrBsuPT0t?=
 =?us-ascii?Q?IoxKeUy8iaJOTHp+SdygAQzoSCcCRykP3zCTw9a5bez8wJZDStkXjSO0BSgd?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38e1921-a029-4cc6-2b11-08dd0246ca0d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:48:41.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VvJzFo388jEggkm/8k68NKCW4VhEqYjuVrcQ9yrX0znydJeoU2q3PE+0TTV682Tzp0zKzvu4BfeR8kD+NvraTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10301

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Friday, November 8, 2024 8:01 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Andrei Istodorescu
> <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH 2/2] Bluetooth: ISO: Send BIG Create Sync via
> hci_sync
> 
> Hi Iulia,
> 
> On Fri, Nov 8, 2024 at 11:07 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > Before issuing the LE BIG Create Sync command, an available BIG handle
> > is chosen by iterating through the conn_hash list and finding the
> > first unused value.
> >
> > If a BIG is terminated, the associated hcons are removed from the list
> > and the LE BIG Terminate Sync command is sent via hci_sync queue.
> > However, a new LE BIG Create sync command might be issued via
> > hci_send_cmd, before the previous BIG sync was terminated. This can
> > cause the same BIG handle to be reused and the LE BIG Create Sync to
> > fail with Command Disallowed.
> 
> We should be using hci_send_cmd anymore, so
> hci_le_big_create_sync_pending shall be used whenever we want to queue LE
> BIG Create Sync command, we shall also make it safe to be called multiple
> times by using hci_cmd_sync_queue_once so it doesn't get queued multiple
> times.
> 
> > < HCI Command: LE Broadcast Isochronous Group Create Sync
> (0x08|0x006b)
> >         BIG Handle: 0x00
> >         BIG Sync Handle: 0x0002
> >         Encryption: Unencrypted (0x00)
> >         Broadcast Code[16]: 00000000000000000000000000000000
> >         Maximum Number Subevents: 0x00
> >         Timeout: 20000 ms (0x07d0)
> >         Number of BIS: 1
> >         BIS ID: 0x01
> > > HCI Event: Command Status (0x0f) plen 4
> >       LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
> >         Status: Command Disallowed (0x0c) < HCI Command: LE Broadcast
> > Isochronous Group Terminate Sync (0x08|0x006c)
> >         BIG Handle: 0x00
> >
> > This commit fixes the ordering of the LE BIG Create Sync/LE BIG
> > Terminate Sync commands, to make sure that either the previous BIG
> > sync is terminated before reusing the handle, or that a new handle is
> > chosen for a new sync.
> 
> If it is a fix of a previous change then we need to add the Fixes tag.
> Regarding the order, hci_cmd_sync_queue also fix that since then the
> command shall be executed in the order and in the situation where it needs to
> be canceled we can do so with hci_cmd_sync_dequeue.
> 
> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  net/bluetooth/hci_conn.c | 19 ++++++++++++++++++-
> >  net/bluetooth/iso.c      |  4 ++++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c index
> > b5b78d469d54..ba74fac823c5 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -2180,11 +2180,20 @@ static bool
> hci_conn_check_create_big_sync(struct hci_conn *conn)
> >         return true;
> >  }
> >
> > -int hci_le_big_create_sync_pending(struct hci_dev *hdev)
> > +static void big_create_sync_complete(struct hci_dev *hdev, void
> > +*data, int err) {
> > +       bt_dev_dbg(hdev, "");
> > +
> > +       if (err)
> > +               bt_dev_err(hdev, "Unable to create BIG sync: %d",
> > +err); }
> > +
> > +static int big_create_sync(struct hci_dev *hdev, void *data)
> >  {
> >         DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis,
> 0x11);
> >         struct hci_conn *conn;
> >
> > +       hci_dev_lock(hdev);
> 
> I'd add a comment why we are acquiring the dev lock here, sync functions
> typically aren't allowed to do that except for minor updates but never when
> you can sleep/yield waiting for something to complete.

I added hci_dev_lock here thinking that it might be necessary to protect
iterating through hdev->conn_hash.list, but I think rcu_read_lock and
list_for_each_entry_rcu already offer the required protection, so I
removed hci_dev_lock.

However, I think hci_dev_lock is necessary in iso.c, to protect
hci_le_big_create_sync_pending, since hci_cmd_sync_queue_once checks
hdev flags which might change. I added a comment to explain this.

> 
> >         rcu_read_lock();
> >
> >         pdu->num_bis = 0;
> > @@ -2229,6 +2238,7 @@ int hci_le_big_create_sync_pending(struct
> > hci_dev *hdev)
> >
> >  unlock:
> >         rcu_read_unlock();
> > +       hci_dev_unlock(hdev);
> >
> >         if (!pdu->num_bis)
> >                 return 0;
> > @@ -2237,6 +2247,13 @@ int hci_le_big_create_sync_pending(struct
> hci_dev *hdev)
> >                             struct_size(pdu, bis, pdu->num_bis), pdu);
> > }
> >
> > +int hci_le_big_create_sync_pending(struct hci_dev *hdev) {
> > +       /* Queue big_create_sync */
> > +       return hci_cmd_sync_queue(hdev, big_create_sync,
> > +                                 NULL, big_create_sync_complete); }
> > +
> >  int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
> >                            struct bt_iso_qos *qos,
> >                            __u16 sync_handle, __u8 num_bis, __u8
> > bis[]) diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c index
> > 9e119da43147..ac1598b1e1b6 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1338,6 +1338,8 @@ static void iso_conn_big_sync(struct sock *sk)
> >         if (!hdev)
> >                 return;
> >
> > +       hci_dev_lock(hdev);
> 
> Same thing here, typically we don't use hci_dev_lock at the socket layer as
> there is the likes of iso_conn to interface with HCI layer, so we need to put
> some comments when there really is no other way and hci_dev_lock must be
> used.
> 
> >         if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
> >                 err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
> >                                              &iso_pi(sk)->qos, @@
> > -1348,6 +1350,8 @@ static void iso_conn_big_sync(struct sock *sk)
> >                         bt_dev_err(hdev, "hci_le_big_create_sync: %d",
> >                                    err);
> >         }
> > +
> > +       hci_dev_unlock(hdev);
> >  }
> >
> >  static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> > --
> > 2.43.0
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia
