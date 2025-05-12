Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A078F43
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065900; cv=fail; b=BcMKGnlrRc2Frt3UOHDkZZKjq+yKJWYRevZuf/qZp7u2VkSAY0SVhhwNJ1gS7V2MROBiLvhIdYPN5jkD9pyXCdeNScN0gPK8OMfCZB1H/FbiWhQ7hQMWRqt+qszSFvUZLUtUnTS1MTmet5hPlW9fHZ209kideVACIgvjLvDX3TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065900; c=relaxed/simple;
	bh=T3Kz+MijVB98/6B9CdI4OJmaHLS1Trtig5joT4RpZ9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4DDlSMJzd8ZZUSLm35x/gmndZHCu8uaNCSz0ZKPKYizux7IZ7t74n+9xCNidIMtSQrAqFkcj1Zq7pvdCRaELzfaB4U/9+1DIkFIIzYoWzbPsxtGNp94fP5SdD2euAf1n3lvaQ+QAjYKgtSVOYQblcvWr1YHF7dzuutVYpB8QxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=acc4b9sc; arc=fail smtp.client-ip=40.107.162.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="acc4b9sc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSYZAGGQJC2k8tnv1VoENTSOpGD5CuP1TjILA3fzzFCgwjSR9BiOBoP+l2oijf2Rw26QyANOStqoNVnjgHgnjAgupElNk3dvEN5nuKlJGOTpp06v/q19mpMOq4xD45g8YIwG7pkdvBKD3y62IPMp69TWO8sxt4927z70XO+hoar5GPPzDqV0Oh2jDcdM5cCeg3huZ3w1ycWwdrbLLGO2SX40TXnh/7c1TqNrxKL6JcZ/eR+CyRjBy4/eA/KWY4JXAeYRK/xBVXAtmFYTeWI5IBrzI6yTWU122VC1/5AJjcFgFm/CZj62DFW7JXdz3yNDzZLpGEeuYabzVPZrPCprIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCuMby6j2c6p5C+hxApPLMGk0GteRrzseu6MRo9pZIM=;
 b=mHXrNz+Qv23CGA85VDwC7kG8jwJS1+yg4fimVZMyQaJ6a1zSBifmlGrH8zmzazE4PxWrmtVE0sgiQBTB1mL6MtbnPgzdYWnSvTZJbXYRh2EqptsyNEK70vaoi89DUzUJGzBfmpm+/Jm4zZTgOK3HSJVknXGfP6FZMs++/vyuEb+FPd5ROWaHBG5H3F4zaWRcQNwNiilRvYPBvRn9EiW839cL1Zq3PoOaO/QyJb/Yf5pD/6SmFj/wkWrXKO5Nl8HRbLtovs6B8zmNAFEAq8KU0d6X4fs7UKkeIE0pWyFyB9dSSPIMgyVVfj1DlEHZV2rZvR3Utd/nxYAQMzFZ2gFXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCuMby6j2c6p5C+hxApPLMGk0GteRrzseu6MRo9pZIM=;
 b=acc4b9scK9ftHDViJqyN4oZs++v0tv4Da59WqyQGx3xLRY5WPn+umBlI0qV4Mt04Wn1/Y7oLxCyyZoxmmLqAeDTmGQIqH1Q6RqfA+VRuA2xHXrx4J9QnFb3p6bEGZ3f7quuQ8LEDe6YVGTPH5jENzqvbVl365PlcUsYs4aT+Dgo=
Received: from PR1PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::18) by PA4PR03MB7007.eurprd03.prod.outlook.com
 (2603:10a6:102:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 12 May
 2025 16:04:52 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:102:0:cafe::d6) by PR1PR01CA0005.outlook.office365.com
 (2603:10a6:102::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.28 via Frontend Transport; Mon,
 12 May 2025 16:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:04:52 +0000
Received: from n9w6sw14.localnet (10.30.5.21) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Mon, 12 May
 2025 18:04:51 +0200
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: main.conf: GATT.ExchangeMTU
Date: Mon, 12 May 2025 18:04:51 +0200
Message-ID: <22123914.4csPzL39Zc@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZLruNnKJKCzYdF6803JsCxidQCu4OH9T-1wezP8NhS0Kg@mail.gmail.com>
References: <5681377.rdbgypaU67@n9w6sw14>
 <CABBYNZLruNnKJKCzYdF6803JsCxidQCu4OH9T-1wezP8NhS0Kg@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|PA4PR03MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: da27f236-dc92-49c9-3d90-08dd916ebaf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UlxQY4Vzr3IGxKFx9ztll5qJGglOqxmu52TZ6DGD9xqkTGNofjB0HHDp8Isl?=
 =?us-ascii?Q?4F+xKGa9jxH+ruRXAe5sGt1Aw33y4UWA+DclPuiVo5pOqz/45epog5Y5ulrs?=
 =?us-ascii?Q?KQvTHGRTRAXGjTcsHg+Jt2iTCr4mVdiFC1P3udp/q8diBlDRG7AGSMYQBCXZ?=
 =?us-ascii?Q?U/ImHawuZLXDkAXa3nav29SDyMkskKgeK1gc5waWxEtUfAnpkh05iN+HDa22?=
 =?us-ascii?Q?luWSTQsQutxwk89/fQlyG7kqfoep89bA5ix2DjsoR7ChOuTreP6rKlgJOB/a?=
 =?us-ascii?Q?Dn6AziI4txES1/FryaUyi1U3eC12t0M89ojFpnC/V8Snl0nVF7xYMmVnsCGx?=
 =?us-ascii?Q?eeJItYqMKGmUK3wJ3acZKkcHhxfbqMNgP4cWMYy7fJnA9EfgVZxDTYoZuPvg?=
 =?us-ascii?Q?llkru9LGsufZacVKGpIFnEnK3dddC2gZgAMAqbyX50gVYon8H77s8hNwDHRB?=
 =?us-ascii?Q?0LdWCyhE6GuJWmWED9DP86UpIllN8O0GZdJQywFrJ3RxOdKJvvMLqr2ig9EY?=
 =?us-ascii?Q?77yZhy/53D3X3u5SGkowocfSXR64bpH8J+iJJ0R3/U8b1ybMkJ9OLgvoVdKA?=
 =?us-ascii?Q?bmiWrJyowde1KY7WXhjHRn0GNKZTstkrR7qj3BjsEGw2cG9gUg6KFHyfN91X?=
 =?us-ascii?Q?Zoi9Y4c+0EnBagrLDI53OTZaTz3Vl1kW7LZxlICO9YSWGps8+K88i1ZQZi02?=
 =?us-ascii?Q?CXAghcbA88ijl/AHSEhthrOEjaUpayMOlTnOkfo5NA2NUOuGwXnSTCcOQiOr?=
 =?us-ascii?Q?5XpukS6eXozCmS1+WL+TxHH14F/xRd3VsDVdDQbIskV96kWH4L0DsSyl51X0?=
 =?us-ascii?Q?4pxkPoFlE/NwTXw2Jg2z+kzzjdforwtlx+W5PqfFbHY7P9RuKgs/3o5ldd5b?=
 =?us-ascii?Q?fqMGG5DZN1viz/+NDhaCH/EwXUIJQ8PT/35AmJRnoVmsxq5uslUqPCLtsugP?=
 =?us-ascii?Q?PMkObvlhsDEPf8hiuwsoVROBBfyp93wkn7MLa+P4aT1w8DxuXu1codAqJ4g8?=
 =?us-ascii?Q?g1/M5gqyNOPctSwtg3KDS+skuIYJQb7ABUwvwJCV8RFvSgZNeTUwvpUiXQOx?=
 =?us-ascii?Q?vM1wuGAaDs3t+0vqJStva1bXqYAMLvqSXKzAOfFdltc44Cn+oqpmLV3sBfqE?=
 =?us-ascii?Q?VFH+US4NubE3rLEhyRVU9lxHh6WdhAUn2gjzkThDDCHvqgqB8HkgqD80T2jP?=
 =?us-ascii?Q?XyZjsSMCZOMcQr/ic3LXk11HzWnk3alpLcjKQQN/N0yZvANy5qX2vGT/Hkmi?=
 =?us-ascii?Q?1NsJLidU2KUnRYA9Sp/KXzhYuZKO91ErR/UZqAJJoHJaqtcPOQEtqLyUBzR3?=
 =?us-ascii?Q?xWUGOyEcXZTHi4+tbEvjKXiq6MfYL4m0rGEjDgO2qqBfEs/uy2/MckmENaw3?=
 =?us-ascii?Q?WFfGspQN2MHw1I1ZQ6pKX7Y5BSV0IBSgxIWT5CLsCA+fJau/JEO+x1TVdzZF?=
 =?us-ascii?Q?vW/R+RPwZKJZhQNYZm9Xket3fWCE6+BKDHaKqASrNjDcBajfBe4y4SA7/MWE?=
 =?us-ascii?Q?F8p9ZVUJ0WzpiVVb2TslI9zyKHsSvL0/yXDY?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:04:52.5299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da27f236-dc92-49c9-3d90-08dd916ebaf8
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7007

Hi Luiz,

On Monday, 12 May 2025, 16:04:54 CEST, Luiz Augusto von Dentz wrote:
> 
> ... but if you
> want just LE perhaps you should disable classic then? 

Do you mean setting "ControllerMode" to "le"? I already have this in
my config. It seems that this has no effect when creating the GATT sockets...

> Otherwise we
> will need a different setting for ATT over Classic.

I only needed this because I wanted to test with MTU < 64 for Mesh
provisioning via GATT. Setting ExchangeMTU = 48 is sufficient for this.

But I think that at least the documentation in main.conf should be
updated.




