Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042B541C2EB
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207103; cv=fail; b=auet56TVKIiXDFqyXuUFbgqss3rPypft+tyufNUcLpILgGFdKXX9zHrUcaG8/PdOu4XfjGlZdTHnqXlJ2qdhl4xSyukJ82V4oSDbnk4ee3FeHSXwm/EF8+4rE89IBco79ZUQimukBHg8Cz8sfW69ktPaEaawCDv7oyh69av4yAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207103; c=relaxed/simple;
	bh=XVnz996WlZM8oEVyUiC9J7A6snalNZ+l06dYYhLqkdc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7u4CLI6dIeCHBoQTJaILG999CfT9IX4YCeEhjapcE7pmxIVlY3k14h2dJHb5Z9VMJTQItJJFUkkl2u2jlxZSAJiSeY3Hz88E+YpipCg9D0L6xlEbCyDiRaEOlPFWzbJaJGselYHXejY2uEGlAYmKr8VqFcdpWtoO0H2gjmcwfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=PRuD+2He; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="PRuD+2He"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeZQvrqGZOlJ1flrERVVeMb95tKqMhkXbfLHM0TdV4tBsYWGo8oGNcvf8Hb/sg3M+2RUTzKJTsALKajcFhvB7rLdKjBYqxp1O3zfMYN2WB9gySHlrS4cZRwzjnjE0QdKM/3sRNCQeJgEmce8RLSB5g27ivH5t63CoywFWrJFBcNhsKcHDI7wK2HGHBpTJdLfopA6rRWDCcezr1wKwSpWykLAFIE7m+9I8qX8tOpY1ogeSPDauBpPvkoV6k2OIfl7Gke/zBLI43mUQLdgpRQzjs0Pq1bb6F2uzo0Ngs6M6pQNQlrcM2mRk6P05kMp/LuvdzuzoL8UPiYadAg0cRC9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/wbuu3XTZRaxv0cdIH3ImQPWWCUuYcxCeoDiPi8a78=;
 b=OSLF6UP7Po+Vx4nfP3nihB1VQ60xH7ZjA3ydN6ASUIq8uYS9QuQQAjKn9Iry3oBcQnYjvmluT9rt9JIhRXy+DY1l9uVj9qMcDm9xF+bioJMGsbj7XyjFI5u5/AOKxGNgOXO7HwoRqGrW5+q9jhRYXS5eyPJOsor47Reb4kcnHSkGsygPiVaxUBlGk60L83QQSriCwJVgBtr3UJTproi/X9UKCfDSDATHfYPHCt99UZJ+999ZN2jLrXjp+nmuk5DFj9zxtfXp4essRaWqJhjE2Vq/+IkN0GBa4h5JMd5+BHrCGhyQmH+Pjus3YUEJ7kb/NAZzgTA7w6gCuXTY70dSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/wbuu3XTZRaxv0cdIH3ImQPWWCUuYcxCeoDiPi8a78=;
 b=PRuD+2HePDUAFVZ5NmYq7M+KgZ2f3BtZMbbJZ6zgozIj4S3TZwDW7uFO/dxVCSiCruFW+iPaaiO5zqMC1eAt9fdQmXrLWyEAQNLzDhu1pjSOq3pg0xOk4AWtaewfEaFAN/GBtPotSPwGjOK1DjnIvkPbPdxPRaZTnalMZf4l7n0=
Received: from AS8PR04CA0113.eurprd04.prod.outlook.com (2603:10a6:20b:31e::28)
 by FRWPR03MB11048.eurprd03.prod.outlook.com (2603:10a6:d10:1a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 15:44:57 +0000
Received: from AM4PEPF00027A6B.eurprd04.prod.outlook.com
 (2603:10a6:20b:31e:cafe::a7) by AS8PR04CA0113.outlook.office365.com
 (2603:10a6:20b:31e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 15:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00027A6B.mail.protection.outlook.com (10.167.16.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 15:44:57 +0000
Received: from n9w6sw14.localnet (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 16:44:56 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: CoC: Disconnect if received packet size
 exceeds MPS
Date: Fri, 27 Feb 2026 16:44:56 +0100
Message-ID: <2334032.vFx2qVVIhK@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZJPBRVE3t0Q-fYdZtCTt3QTxKp8t8Sd-BLrHr5Vv7GSWw@mail.gmail.com>
References: <20260226204357.361000-1-luiz.dentz@gmail.com>
 <CABBYNZJPBRVE3t0Q-fYdZtCTt3QTxKp8t8Sd-BLrHr5Vv7GSWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6B:EE_|FRWPR03MB11048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e89d699-5f98-469c-ecc8-08de761728d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	xpRWyY9XyyL0ixNXIrPXIB7XvN7lZmEn9sEa6/EiYmU2q+1IPuUI/XSUBMMrosu2P44pKo1uHR8yW370tH7icctcgUbk8keRwUKzciSXYQs8ADr851eSEgK6GR43wpfKMq2RhWTue+2siQEm1nGhAqdE9iBqSfWQz42QrUy1uMg/U0aoVgQ4Ob/FpxsReWzG2ojHFeAZ64YNOvFFKIoKIquYZME+LrXLBATgvXqmpRZIYFVzBK1iXBcvLu4EMyBW11y7X9qhm20jX4NPSiYDny2D1TkrTIu8wyWqruRanochbMitus/6ZYoOKTpEipR6qGMPUqSLTAx3sj/WmfGERt+iXZvkc27YMjaZyfLypM2ny0tp3oyHU3iEuu0RWxmdyrXkZLOvXCiU5o9Xv70mzUYg4XS+7N1MfmIueMHvw2Wu12TpK0loaw7iL1pUU+PWXUKqFcKS6XkuyWRp6H694X4Zzio3Dvke73Jc/55VXV2aSNy2Jp8Y6x1hOuWUQScjDJtdwdOctcwM9MOH+Ys7+jz6lEFfedKFNxZzxzotpDrS0q/WoduABbJq77vw1rWqwD7Gb1f6cTVWouoqv/lHOw+OGBjZ5ZYj8Q3GRENywrIw3E64RB65go7d+0PFLaOKXO2pPaniNulV3VLlau9hltHeNkvoIJR3WAE+mei/9M8tTZjUmhCnS6bWrrh0VSZlHrjyaMmH4s7Z5kFc7DcSG4ZQojnGwmNudJVUj087cplYXNPxuWSwlqqu3Dym3WKkWFgAx+8Jj9JgVyBCHxLR/V/g+3BK4rBAF84PcIvZHJthVqQ9g7gwvMnxXCYaets46bWyGw4JuQawMCGl8sQ3eg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nD58/UiUegSKxd7JoUeB7fCqkJwTxCrgYFF0V1+AD2ZzkjctrarFBeynTFpJTJSABK11Xo1rhHNIVDnLIoWwHl4DaJurV5qku2G2hk5Bu+krZq8n0F/yntks3/sYOOlG/oa6/7bnoK1QwiLCscQMsJ2DrzTMVdTkBqt/2zo+POVCDt2ycr/qLV63w+pWmfF5Vig4THlV/zRpa8jdxBbbK+MDoG50VRt8FUjlIZIn3cSJBgEhgZWktTQnhr3qN89PEt4GC6yPG7Hp3udyAZa5mDeKCNWe/WRU9JwaJYkY9LFxJ1Ifr616NUN5fCWDX0gjT+qzQR3g3QPP5Pa7BRZoiSZvH408ACp9yncs7wNzGCW3Qq2hmMLUWTEN7KbyyQWezrz2TGTPjeDUbdal5qVtq2uSGDd3hhBbweXt64iF9QWi14Czu1uzQ2BdS6S57Yu7
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 15:44:57.4323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e89d699-5f98-469c-ecc8-08de761728d7
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR03MB11048

Hi Luiz,

On Thursday, 26 February 2026, 21:48:48 CET, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Thu, Feb 26, 2026 at 3:44=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Christian Eggers <ceggers@arri.de>
> >
> > Core 6.0, Vol 3, Part A, 3.4.3:
> > "... If the payload size of any K-frame exceeds the receiver's MPS, the
> > receiver shall disconnect the channel..."
> >
> > This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
> > 0x0027 -V le_public -I 100').
> >
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > Note: due to lack of L2CAP CoC segmentation support in bthost the follo=
wing
> > test as expected to fail:
> >
> > L2CAP LE Client - Read 32k Success
> > L2CAP LE Client - RX Timestamping 32k
>=20
> I didn't have to introduce any new fields btw since the above tests
> confirm the MPS is working. I reverted to just using chan->mps, remote
> mps is tracked by remote_mps field and I check that the remote cannot
> actually set our own MPS. I wonder if something else was at play or if
> there is some specific requirement for L2CAP/LE/CFC/BV-27-C (e.g.
> reconfigure?)

Unfortunately I cannot tell anymore why simply checking chan->mps was not
sufficient for me. I have tested your simplified version and=20
L2CAP/LE/CFC/BV-27-C runs fine. So you can add this to bluetooth-next.

BTW: In the description of the other patch=20
"LE L2CAP: Disconnect if sum of payload sizes exceed SDU", the PTS test
seem to be wrong:

L2CAP/LE/CFC/BV-27-C --> L2CAP/LE/CFC/BV-28-C

Maybe you would like to fix this in bluetooth-next

regards,
Christian

>=20
> >
> >  net/bluetooth/l2cap_core.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index f550ceceb618..14131e427efd 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -6669,6 +6669,13 @@ static int l2cap_ecred_data_rcv(struct l2cap_cha=
n *chan, struct sk_buff *skb)
> >                 return -ENOBUFS;
> >         }
> >
> > +       if (skb->len > chan->mps) {
> > +               BT_ERR("Too big LE L2CAP MPS: len %u > %u", skb->len,
> > +                      chan->mps);
> > +               l2cap_send_disconn_req(chan, ECONNRESET);
> > +               return -ENOBUFS;
> > +       }
> > +
> >         chan->rx_credits--;
> >         BT_DBG("chan %p: rx_credits %u -> %u",
> >                chan, chan->rx_credits + 1, chan->rx_credits);
> > --
> > 2.52.0
> >
>=20
>=20
>=20




