Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001E371CEC
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930428; cv=fail; b=UDoqIkEoDMoI6qhomVNn6nlxrlwTypULnTD92KEzatggTpZrz0OtMAQt/3MC1mq/pToCD8Gxdr8kpJuSyJupd/UPcWjtorbborY4R6VIBDP3SfXOuPMW8o+YyXMBNs2ppAhAIPSmCnTE7oaVDudH4Ow8JzSMs6qOBvgpCgmO+S0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930428; c=relaxed/simple;
	bh=Vlv9yu+lAziNEiJIB7a4+dpUwkvP3gkl4A7jUlvQJdo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLYfZbMLhcdwyFtIYX3lObwm5DNnMupilj/lkiFIaWCnr0dXRq4HRXoxwKIIeq5SX8lTsGLccK7WkeRAjfIZf4qUWvCsXV3NA2qLWC9QEqiNELnKZMBPLiCGhnGvDFzVTmaTyjXwa5AP56CcAvZWWsorD5V0oQGmfYzrmMIFV7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=uVVWZc6v; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="uVVWZc6v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elWSbmoPSQvBdyAmBwsR9RTOPcEqK/QBnDr8UwVdpdMBUADmxti/lEHTuTAhAFcHDDHMDzM2hecevCJ31ojHQF3SvgHl942sH4kT/q3Lc51vIW1idWs37Fv11WusVLWlzloc+OPhwSd1GLiXzLUNATKHvfiZQsdcjSGRPJJhY5jLuB5Un/iplWKlj8ddJctDmNEtjvlOMe8XXCg3nC88b6ww2M1Jt0kDXzjUqr3ocOZJYCXYnU3Fzgcr6ZQuVrtodZ5dtJNqZmzgp6iMhA+v6CS++3b/dnAL1S+V39JzC3OOedbkjd45NHT42imG5ReGfLoRD5qk6nkqysYSKRYLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT0PDLRG3i2L/JinRDDvpXr05W2BwoaNjFHgHBDdjPI=;
 b=HzVlOSAIArOusC2RFY2DB8AyUKDteeiFDOMl/Sd/5QKRX4VOqniZyMwunZcLGyPDHcDwKx2LVFdC9JcTAyvGC9LTMScyDmHzqlmH/3/V9ezp2LAFvSrDWrM7XxcYBr1zGKz1hj0bBx/MKMZ74wkeTHXI568sUodq/tIuEc/GfrJJzyX2b/Vt+fqUz9u5v5f9kVJ/FWEyJ5M+r7C2XIPl5dZl13Z6B8QYGM59T2fNmkek2K5z+OAiV6gAPM1DAuvnL0y6GLF2niVWp7/E+nxuh8P+HbLqphtG0Ma4ym3Ycns09zenL9NyEqisQRCOdj/yJokMX6Jdr8FAttu4jT9+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT0PDLRG3i2L/JinRDDvpXr05W2BwoaNjFHgHBDdjPI=;
 b=uVVWZc6vZz77xK4cZuTHKxaEpltHm94UPpJDvN8TuqU2t3RHiIabw8Q8YwClahJFy0HhWN5KMPDVqwgOyOORSIkNTG1ruHuDiFlRCzzc3IxUZdQ5a7Ns10rCw3w4A4KyWsL8vvCZJNa3vTQxo2Mzqj9UW2TDBS0qQGTn7V39mQQ=
Received: from DUZPR01CA0345.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::28) by AS8PR03MB7366.eurprd03.prod.outlook.com
 (2603:10a6:20b:2e5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 14:26:58 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::c0) by DUZPR01CA0345.outlook.office365.com
 (2603:10a6:10:4b8::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Thu,
 19 Mar 2026 14:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 14:26:58 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 19 Mar
 2026 15:26:58 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix regressions caused by reusing ident
Date: Thu, 19 Mar 2026 15:26:57 +0100
Message-ID: <2796916.vuYhMxLoTh@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20260318180922.307838-1-luiz.dentz@gmail.com>
References: <20260318180922.307838-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|AS8PR03MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f16c71e-df3d-4681-63e9-08de85c3944f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	C1eTFVSpy72cOLLvWZ+V9oNhnehzSwJyFduxhvAgz9ByWGwNCAKmmcf5KVkwqXuzUFEgrFz3XJ3ZwBNRJ2hiVwtOEKCOm7HZrgZxVP3jTt59V2KSVtffoqsIcEbU0WDKxnoStlhXj5Q0uKeYJhokV222Ciui2zYqBktuBRNzqjzwrQgzNRX44EbGKr3XGnpIIi8V5kFuciTYvCgoJFk2f2AF6wB0DqDGIOh3iXKEuvoQXzyTzzviUJ/GtvPPyZaGovMXZ3XCqc0rnw83QzJvt7/ioDWEj9OPvkblR4hfY+0imf3njS/cQq5cLakDWgqoWl73x0a6bnsD4cUatkXzANZu7hEiUDZrB4gzye7YvY3XZlSRr/qYktfXE5ZtzO7OamKdi6BlYOk3KANOUkxbPU1+lsqKPMiKGgH/+C9VxiLkghXualzIu9nfVLxnv9kjidMpa19GHHdZaU3HyOrcM10pPKXOXqdQCt1xjD933lBcLxShbelDn+Geu+kHOqHCO/S59HAlYB7XaLy7pkdElATkCVkcEZxPFO6ZPhkJg+MhxgOn5Udgm/NtLfZZK4GAOHQXAZ6rwl3SwLKdyeeUqb1YskniQKExVM1/IyP/RdkORvDZDwA+le5Q8tXp38UZrpHYSji9W9DULOOa7INGNzUqU4g3W1WDmQFn35wLHkJ/4RGYWgx8VataUsUW4GAS7phynrzeT6t+PrOMVfRvRvimJv3X+AzGAk6Ogk1CM0Jif8dazdnBfe1DkJTAHYZXOrIVL8RwZoX/0MCbzXyeJw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E/jH7TYDbWxjH8DVmxf+fKfdcWz+8tHJ6vgeobCL5wykrp1w4Exem92wYGSP6mNUTI/Va3GFSXijIG40nk/E5aoSrOZmVJ9t1K0rJHw0m7JF+b+6ctwA//4ODYXoprcKpYAeBfYK1iCykNhdcOWZ7ETrzdL2Oe5gxymwLF/cpziFXPaLi6T+9bsamjCYHualRvEy52QIenu057iRDBnQN985lXzQX7p9erO8DZ0CA9iY7s90ACqSWUafrqgOlEhTA6QQ9qfM6bY4q9q3jUSSBv0PHX6BsDw3gzzFqgFLWW1n8iIrKXy3HW440PLjnsQd/W1PCbw6vIM4lF7zJd+6nqj2+vpWxKUNJS2qVyEjzgyzLTH+LGlBzilah8Pi3Jbc0ZTVyKysMQCDMjXbA36BkZQSOg2oKA9ugr3Jd/wzz6kBjAVV88eSsLs2tfWPbAxt
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:26:58.5808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f16c71e-df3d-4681-63e9-08de85c3944f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7366

On Wednesday, 18 March 2026, 19:09:22 CET, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This attempt to fix regressions caused by reusing ident which apparently
> is not handled well on certain stacks causing the stack to not respond to
> requests, so instead of simple returning the first unallocated id this
> stores the last used tx_ident and then attempt to use the next until all
> available ids are exausted and then cycle starting over to 1.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221120
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221177
> Fixes: 6c3ea155e5ee ("Bluetooth: L2CAP: Fix not tracking outstanding TX ident")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 23 ++++++++++++++++++++---
>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 010f1a8fd15f..5172afee5494 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -658,6 +658,7 @@ struct l2cap_conn {
>  	struct sk_buff		*rx_skb;
>  	__u32			rx_len;
>  	struct ida		tx_ida;
> +	__u8			tx_ident;
>  
>  	struct sk_buff_head	pending_rx;
>  	struct work_struct	pending_rx_work;
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index ead51dc0f3f1..a818a58362d5 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -926,16 +926,33 @@ int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator)
>  
>  static int l2cap_get_ident(struct l2cap_conn *conn)
>  {
> +	u8 max;
> +	int ident;
> +
>  	/* LE link does not support tools like l2ping so use the full range */
>  	if (conn->hcon->type == LE_LINK)
> -		return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMIC);
> -
> +		max = 255;
>  	/* Get next available identificator.
>  	 *    1 - 128 are used by kernel.
>  	 *  129 - 199 are reserved.
>  	 *  200 - 254 are used by utilities like l2ping, etc.
>  	 */
> -	return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
> +	else
> +		max = 128;
> +
> +	/* Allocate ident using min as last used + 1 (cyclic) */
> +	ident = ida_alloc_range(&conn->tx_ida, conn->tx_ident + 1, max,
> +				GFP_ATOMIC);
> +	/* Force min 1 to start over */
> +	if (ident <= 0)
> +		ident = ida_alloc_range(&conn->tx_ida, 1, max, GFP_ATOMIC);
> +
> +	if (ident > 0)
> +		conn->tx_ident = ident;
> +	else
> +		BT_ERR("Uanble to allocate ident: %d", ident);
> +
> +	return conn->tx_ident;
>  }
>  
>  static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *skb,
> 

PTS test L2CAP/COS/CED/BI-29-C is happy with this.

Tested-by: Christian Eggers <ceggers@arri.de>



