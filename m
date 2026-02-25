Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D7F3D3312;
	Wed, 25 Feb 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772040888; cv=fail; b=jq3ahpY867FE3n3dlLvHhEV5uv1q/CSvoTtYWC52LPZnptBxwqHlvm38ej5730GCVbXTlu/NmoCjxM+LyEzYOV6826T6r8OPGv3Y+RsVPsymzrn4LM5VxJXiiMgepIi4mEqMsFvsju5MxdebYuqjeG0U72DUihpdd6xDn78DpBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772040888; c=relaxed/simple;
	bh=m1fFhDMJv9S4ZM/1D4FzPbVdy6vkZrgE7V9sIiSO+gU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUyCRr0AlTzOVhq4skrVZ+x0wS8FRrWkiXSvWxP1TmTB9NVZA4VRFW4Gc53JoIZbm9eufqzWXsjrKmKyzZm5/Tt3ALka6xT/C8Yk6h50qk8oZT+DZXcyGa0Cb9M0rtUsetxPOaNkIaHCvoXwLwCmuhkkUFHdMlF4lvNouUfnWRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Cz1RCCWQ; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Cz1RCCWQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk+IZJyutSBT1o9sg/mxz3ZwhpChlIWRorv1IPkRg0FdIRvX59yoG8BczHcURQ2tpYJ3ZuLqvh4MnRZ/vPCCptCeHI7fC7qP7KzeGX09OAgmcClxm07SAM+XBx9F7xKg+G7IyyGQlzWmKKU+wahfjsw67yqMhpViJHMXBfOe/p51eCKQ+sdqI+chp51MwOTR7Fm/rlC4T/B4d6qXDBp4DxOhPYDLCbxqyFTy39tZ3jyrVxX4g65r0hRU5B/U0iWIiTGxQn/OklCXhLbsbLFEMGlQ0k/WEZ9W4mMqMP7DBHyFdDurINWbgbxplvGVaYmiQ2gf/qJ27CpMtKOSSHW0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InvB6fpmp1wt9FKrkh1a9AM05oytVTzc1erksJSmY8E=;
 b=VortNAuluh+xilhjgs611L2XBZy1tqipBWxXkX9nycwBKbNByYx9w9+id+RL3SVexsTNxWLGd5bqSC1MXXb3X1GoUDOxBWmLVxX2T2XAzl4e8fgdLdgXhfjYZgTTZFajEm+tUyZiSLo4Hys3joNchW6vAZFlCJiBG5vCXqRqExfbI+mlfnUJEhimMdu9hZs/DExbtFRI+j9yKptjqPI/8vYYecWNpfmuwojzsgf8++Dyoiwc8wJikDrUkEWi9dwTUVfKmTpmciC1lFWZNTgNnpTDPsGsiYUVVOd6EDyrzvp38Yqhayn+ZoR93DGJdSZUZRzDUgfjBqvyJgXe9fpQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InvB6fpmp1wt9FKrkh1a9AM05oytVTzc1erksJSmY8E=;
 b=Cz1RCCWQoe3tfBH+cObDShAz+cW3wxPJNlS5rQox5Mv0TeG6zqcG+jShAkHE5c0TQc1FQ+HCYo8RP4CmOH9glmZrJUBI6mzzSYXhye5qq9JxcODPJOdkbETD7TzI44I3XlC86ucHxqzvpgoDTe5vNWJIhjbsbMLuMhdVqFQYPfw=
Received: from DUZPR01CA0014.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::7) by DB9PR03MB9855.eurprd03.prod.outlook.com
 (2603:10a6:10:45e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 17:34:42 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::f9) by DUZPR01CA0014.outlook.office365.com
 (2603:10a6:10:3c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 17:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 17:34:40 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 18:34:40 +0100
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] Bluetooth: L2CAP: CoC: Disconnect if received packet size
 exceeds MPS
Date: Wed, 25 Feb 2026 18:34:40 +0100
Message-ID: <27266297.1r3eYUQgxm@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZ+VjSe9J-UzkVGt1opK+7PbnrbuxHmqZo9WPHxxa3kzgQ@mail.gmail.com>
References: <20260225170728.30327-1-ceggers@arri.de>
 <20260225170728.30327-2-ceggers@arri.de>
 <CABBYNZ+VjSe9J-UzkVGt1opK+7PbnrbuxHmqZo9WPHxxa3kzgQ@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|DB9PR03MB9855:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dadea85-0934-4ec0-4efd-08de749427fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	+cmNOa7NF1iN+Xoi9X4VgQdp3udrDp3oci5vpLDNQu+jZ/dTU/8QScBxBrdI+G2DnRCsjHsve7Hgyn9oW07MzGa3oauZLKtc2ex+d5trUiCSEJp0954Pw4CQ8suCNZuthi982m+p6XtzId1PG92cw1tJ+ppIc/uobqtvPmnF9gnG6XrIy/qqV46hssSi2qesROC3czx6itaBYjmWyDTLSVCc+9alJHV8b+Vx9IJx2W062OYbKT9mGPEyhjpbAdqtnDcFEWmp3K91Nb26J3CPfxptOgB4aSzIudNVoXKgZ4fcmakjRivPIMuQ7dfe4KYwBgP6Olt7Ju4f9BTjbtgKch7OzX87qs+CGuiLuZT5hjq87KxRjzCYBlZGdQwCD7vtWNLPO0wUMeg5/YLPs8L0GWIKrM92NycaVRltZX67S6tYzzUGcmRwqGxt3B5A0f4ka0fEpYT8lc9PZNssA8u1yaFtxE4B5Vy5Q/UQfbL/SqL55AeOJMljB/c+D3jQ/McqKbtOgfuwJhyZuQgR1ET8RbNCmLbs6lSeCBjJI/FyZbh4Sb82VR09XZCPrXZYQNWXM6i9Dqfela1wnDuONuqw7GJ9C7OMi3Jcz1igU4+ufhYuOhQlQiV8f8YqfdWstArhT3p033B54gmk+p/DjQqj/4dwHulOzWqphgSo4r0Y8/EDQPjwulSkEd6MM+vEurpRIO2oqD8LWhdS8Lh0GaONbW3+SQFNQmgGHwNvwo4yk4DKfexLxwRnp0Fp/6WVEddP4bAT6E7o0yBvWWwwfONOmRZdZ2Y/E4/i39xZIsb4S+9g2kjY6IyGjm5/6RmgKEcp2NIZe8kDFmxtm3NAHUxmPg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uu2tCb1SIESErx01fBphF21MTksgvGsHXy9eIKX+ouCInozSlc2B53LXFeyUKpSSDk6MqjO59FN9bV+iZGhfki39KH0SGG1Rn1aLnBGfhIRKWFM4hVxi/0z+n2X/Di9AtL65fU8EHkFm4k1tDtaUtNyC56PhHKagxbC3k7EiZVGEwWM2gWbFheDo9MZGqd/i8TPoA1v6WgAnTA/eEie7HMPr+AvLpiLg6x9smGk1DkTUIusYHzVGQOokEaGlCSeNOQIC0kRqJ5FshS2CJ2q3zAuYi3iprnz29gWBBGNV85UkfJmeXyZ3UQWaA2nmWWX99EE797I3piUjBDzhl2cKsCHoO3KSgLN38Yr1bEZagPBRdNWZVRZxHf7d9C1D1mfF0XqkJbp6Jx2kDQGbnBJ5ehI4wf7YAOvkWPwXIhOBRD4KlrlEI3y7XTDBoegEBYb+
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:34:40.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dadea85-0934-4ec0-4efd-08de749427fa
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9855

Hi Luiz,

On Wednesday, 25 February 2026, 18:24:16 CET, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Wed, Feb 25, 2026 at 12:07=E2=80=AFPM Christian Eggers <ceggers@arri.d=
e> wrote:
> >
> > Core 6.0, Vol 3, Part A, 3.4.3:
> > "... If the payload size of any K-frame exceeds the receiver's MPS, the
> > receiver shall disconnect the channel..."
> >
> > This fixes L2CAP/LE/CFC/BV-27-C (running together with 'l2test -r -P
> > 0x0027 -V le_public -I 100').
> >
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > ---
> > Maybe the naming of 'mps_orig_le' could be improved...
> >
> >  include/net/bluetooth/l2cap.h | 1 +
> >  net/bluetooth/l2cap_core.c    | 4 +++-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index 010f1a8fd15f..c6744cce75b1 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -552,6 +552,7 @@ struct l2cap_chan {
> >         __u16           retrans_timeout;
> >         __u16           monitor_timeout;
> >         __u16           mps;
> > +       __u16           mps_orig_le;
>=20
> Hmm, I wonder if it wouldn't make more sense to have imps/mps_rx and
> omps/mps_tx? I guess that is why you need a separate field; otherwise,
> the MPS is updated with the remote MPS, causing us to accept the
> packets as valid.=20

I can confirm that I needed to introduce the new member because of this.

> That said it would need to change quite a few more
> places it seems

I feel that I don't have enough oversight for fixing this everywhere (but of
course I could try). I just did the minimum amount of changes to fix this
particular test.

Could you eventually take this over and propose a patch?

Thanks,
Christian
>=20
> >
> >         __u16           tx_credits;
> >         __u16           rx_credits;
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index ddac5b9270bf..c9555b0a3461 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -568,6 +568,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan=
 *chan, u16 tx_credits)
> >         chan->tx_credits =3D tx_credits;
> >         /* Derive MPS from connection MTU to stop HCI fragmentation */
> >         chan->mps =3D min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HD=
R_SIZE);
> > +       chan->mps_orig_le =3D chan->mps;
> >         chan->rx_credits =3D l2cap_le_rx_credits(chan);
> >
> >         skb_queue_head_init(&chan->tx_q);
> > @@ -580,6 +581,7 @@ static void l2cap_ecred_init(struct l2cap_chan *cha=
n, u16 tx_credits)
> >         /* L2CAP implementations shall support a minimum MPS of 64 octe=
ts */
> >         if (chan->mps < L2CAP_ECRED_MIN_MPS) {
> >                 chan->mps =3D L2CAP_ECRED_MIN_MPS;
> > +               chan->mps_orig_le =3D L2CAP_ECRED_MIN_MPS;
> >                 chan->rx_credits =3D l2cap_le_rx_credits(chan);
> >         }
> >  }
> > @@ -6662,7 +6664,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan=
 *chan, struct sk_buff *skb)
> >                 return -ENOBUFS;
> >         }
> >
> > -       if (chan->imtu < skb->len) {
> > +       if (chan->mps_orig_le < skb->len || chan->imtu < skb->len) {
> >                 BT_ERR("Too big LE L2CAP PDU");
> >                 l2cap_send_disconn_req(chan, ECONNRESET);
> >                 return -ENOBUFS;
> > --
> > 2.44.4
> >
>=20
>=20
>=20




