Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2073.outbound.protection.outlook.com [40.107.103.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B60C1C3318
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 12:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316600; cv=fail; b=HmZHgpdhP7Igo33sC/zNGKhYlIDIZNrUyQAHpvbcttJzlu8RF5OBgGL1c1ProLX6YAhKr+4IrkqrB1a6mXuLzwgxuexLQByW84L75ngGn8mKVN35sRVPkMfaVjm9guemH7w4SMxeN62nC1/ynW5KrN6xfPY2iuhVWLtn54TnJB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316600; c=relaxed/simple;
	bh=Fau0Otde8sJ1OKfdj3GGj6vLjhSGfnFXXmnVYfXMsHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e3uhlfqK7cfD0eQJffJQtaRGH/sNoQ43ovlg6L7UiypLnDbi23PcvwHNg8PUzWlRPlhCcfZt12KXByjRvbWlqrxhNDkSc7HOh48xBK6zgstGOS7XSjP/JGv8TitGsGGSyrt7YxulwmcSjmY7YKtgc0hdsZhRtjAMyrZ8KoMyn6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H64wyQzL; arc=fail smtp.client-ip=40.107.103.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H64wyQzL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJ+ENY2qmGyopL2IKWERwSf/h2l+M8FPF375U1Cp+x64FgeXw+YGsWCNvq4oEr0FxIOAi7Zztium6bIIYSETfmuPfCv4XX1kueDWauU6bNrT1kgj9ifONBWctyf6jQzrU9XRjKVOrn8b4HjZsJPnvqGvGm8uwf8/xqN/q04HGSXYNj+ucvtVdjkLvh2M9xjCI6vzlMsWhjq/biES4KrL005qq1vc535OU9DAerPa9mCZtvCNtHOihH7nNvyMFygzGkVyWYxaAAx39ol5uLR9XG+hkN5/r40eBe5SKW0x6VQIIomNPcJCs/H8gqaNmY4LVZJk9q6TUJKzyZBZtZeiMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h31dz31G/Q3vM5zEKNt+8ECGsdN5IRRA/q/pIMMrraw=;
 b=tBJOEUoPdYgEngvkNNcFe3hiEfwntl52rFAbp/tAby4awd5E46iUJ63+0iTZTLW3GvZGTOysW1R3Ci172DZ8DUl91Iu+tdI3kwx2ZCAF624iS93CLYu44UdD5FfHg46el/3z2ONvy20w/v/+dUoi5mbBvUwn9MjE7TH3hTlrA7+HU8WRf6i6IG3+fMJCFVdz+eEF7KbDqJNIOKEZ26XUPhVr15+Yekns6fmN3MjhrdsByH3ciLAqfrsVa6PTfmggTusXENxwaK+AQLvG2f+OvTohL7FELX2Xsw8OCwETyHoJDP2WXymiTjfH3IYNeCRRW+LUqk6sPCGlfa1ud5rZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h31dz31G/Q3vM5zEKNt+8ECGsdN5IRRA/q/pIMMrraw=;
 b=H64wyQzLvvZajk+V/baMU2OG5zB9ZvIxyX0x4JOs8kA+JnmOpj0FpQKEFEpoHIAGw/rd7S3whf24wt6g0QwLVYJ4SlmBwygNSnoGJe9oP3npguYc0t1Duka8XWIhT8iqJN/EvT7zfeQdaQklOk/O1tYVP0+joU5wBbEcEN4/VtZlAlvqw9CAtAxE4pz2lWSGHID6rYW/AWEtgwAolvJaOA+/zPsmhd2qhqN1KVbMYiMOtxxmHtwkxv9MRQKAYAlK5ZdSMT0DkByMsqKgjXEHSgwGpP/PRePJUraHhJFXlUtqEIPdIcLI5tUQlew5cyBm6QHYslVhvSPTYcVd/Ryc+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB8391.eurprd04.prod.outlook.com (2603:10a6:102:1c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 12:49:53 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 12:49:53 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com
Subject: Re: [PATCH 1/1] Bluetooth: iso: Allow BIG re-sync
Date: Wed,  4 Dec 2024 14:49:50 +0200
Message-ID: <20241204124950.9680-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CABBYNZKiZZQ4vpc-w1b67hyRe+k0GE5OoA_wBERC=_zoo9hxTw@mail.gmail.com>
References: <CABBYNZKiZZQ4vpc-w1b67hyRe+k0GE5OoA_wBERC=_zoo9hxTw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 402df3db-1092-447e-96d3-08dd146225e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YolBAvMTm7CNCIazNHhKE9qsJa3QH5EQdYEDt30ZvZ8nbV7hezu7WLYWfb2k?=
 =?us-ascii?Q?pJS6VXCFl2k+TqAOH0WHL/uSs0NGh17dTGIrZITFOwg0SmeulGvZIId0C3V/?=
 =?us-ascii?Q?W395cPUDDEd/8V0KCGjBNM+Ci7Hg9ZFvBuahDP+CgCS3K1bQ09W/b28u7zLU?=
 =?us-ascii?Q?ODG+ogSO/trqwJEP2o1RpM59IrgJO3BP7DJWc2Ncg5M/QdGQvmzSkHCOIUVn?=
 =?us-ascii?Q?Z15YRnKjPk4rJE/V7dda5YeJdn8PNQcW7coWRe/7689PdV1krjIMG5+O77/n?=
 =?us-ascii?Q?V/dgFGEW1kYxld8W7/ywEgsejoU3ixLL61xEWYqwsS4zO6xrQDSg1g5Cmmi4?=
 =?us-ascii?Q?ltlTjCtjqgONT64pFa1kq3tOQENQfSYYiu54SkkBrM+uww5gul2aFej+zrV7?=
 =?us-ascii?Q?4U1rPfn3ajLUJ8w8+uVj+5JO6GWREsQ0uYXhqu7ha66+XghaCRqw4OXnDWXv?=
 =?us-ascii?Q?0iLHSKkN8az6rcPpKjNyFa/MU1QdKNtafrScRP8tY2tNSQmxUJvgCVzutS5l?=
 =?us-ascii?Q?YHqAoEcs581vHOE2CJxd0lpNGCPf8X1rEVUEGnYw+Iu3N4yPFfF6UP3+KXbS?=
 =?us-ascii?Q?Ers2yPSgq6jJqZeqcwPDhFNhfm1FYSsgZaAaFvx3VF/W2GKhbnl9hHg1G6/O?=
 =?us-ascii?Q?tNvwhbI1My9pfj9jVm0i6SKFAOFE0iPvbwjT4tJoZW0c5gvqM8JUJs0LvggX?=
 =?us-ascii?Q?xbhBCAVkshz+WHw7o2f2cJpwUvy4t6VV+b5Gu88SHZcut+D5wTMPQOSTHuAp?=
 =?us-ascii?Q?Vu20FCrO/2T/EMVlOkO5no+D1IcBDct0U8yqURccU8UxkrYyMvh+ODVLF/qY?=
 =?us-ascii?Q?H53lewbz+J/eF+syYmhWLAa52VHbg3pCxp2WEnIPpbIRjko8T30ujFwh0SJy?=
 =?us-ascii?Q?zsG4CUKcNpgcw/KLetIk/mNm1igdsKHCskiTiZ+BjabcML8IYfda44t7WIgo?=
 =?us-ascii?Q?ktJ1rrd8w1etgDRREsPbNtrTXsbHMVGSxsXyOYNQBVNLVhT9ng9maU2kTh7Z?=
 =?us-ascii?Q?GYIiRPKuhbZS2jY3u9Gk30PzU3k73mFetLFEIsNq0xXbfP1f3mNlwEtz5Zi2?=
 =?us-ascii?Q?72YdhOi0hOTgcTtp1ycex9W8JpMqANPua8leNC6O9YxThxtd+gD+sTJPKZ24?=
 =?us-ascii?Q?8Mqxunznyk/1rgdGKwihzMhj5dD4DPAAlKzhY58JTIw5akaU7sKapbEbbI4U?=
 =?us-ascii?Q?4q+670LFJLWJntqwDw1t+3dzmy9xgIWdCr/tt7t8gdvMIqauGia7Q7j3FbD3?=
 =?us-ascii?Q?qooarsYRYJ92xcKYtoFnyIWklPc+iJftXHE9i74QC2CCZUOKDWjSUx1oFH/C?=
 =?us-ascii?Q?3m4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yjuz9tEA1Rfev4ajamtDsJNp9KRtLwU5dWrliyWPchAGsGwF5KIIJw2zjAPE?=
 =?us-ascii?Q?9ZNgf+aBfhRa9wGjZj2Hlt3SWMTCoUZ/RoSA8LTAC6j4MA5TPZqaww0GhZqL?=
 =?us-ascii?Q?IYUX5JmNU/GmFDaMrnidrrSmW3C1f0Iqm+Yj5QMttZqSn7wYqYTsGpjYZXJf?=
 =?us-ascii?Q?TzzJC/EHSGbH7i3VvMNFm1WLj6r8DetFzXsIMOuJDKUfND2uTmyDbmQA2MSj?=
 =?us-ascii?Q?zryIFCFSFa/u1mqMu3BHUdB1rv2WqTxN5gEPrutV4rMW1G6GJiFhtJEHgdfU?=
 =?us-ascii?Q?+iasfJZ3wteyHWjGV1HHsVERkFkUkRGd1wvECFVoHz1w4M7JbRhFNt9E15Tn?=
 =?us-ascii?Q?zhORpmAm9kMRq5VBA7Obmhy814HYj4FpDg3T5JyiGoBr1BH0A+LqfGyljQy9?=
 =?us-ascii?Q?Qwdis1WLbsn6XaKvK6uq0B98luYUg5Oi+M/u/2igwsoqr2r7OuD4aICpytKv?=
 =?us-ascii?Q?HkQh+52tlqLE6ePEsSymQiNgkjjTeBMluZHvsevTwwD7vfKPumZ0UID0TyEM?=
 =?us-ascii?Q?RuwbrXREcsrg8U2zsqfGcpTznWXS2gnTNoOoUQQp5JybOdFps+vcPqsN3TNE?=
 =?us-ascii?Q?cQSIsLxiFf4qPmUA13IR2NdFYe41iHPHuvDQO9mHfRH6vRmIJ37mRupAlzfK?=
 =?us-ascii?Q?qPf9eeUrL+/8EeQx2i1yN4nT+6eNYlfKUjpRQ+UQPzlTtMR9n/vXKIMufUjG?=
 =?us-ascii?Q?vQmkR+lTzLx46Ijq/ONc/oqtNxpyUK3lvhBjA+OZ4NhnozX5+zZNf02pR2us?=
 =?us-ascii?Q?OdOxBitjkZUg2Pfo3keBlYQ+Xup0fUtNzbcJa5zzaOhmiEvQvAgRKVgqYdM1?=
 =?us-ascii?Q?PbQJG+7mSM//Al/EbxZk2DPgA0JuWYnC0SrQZeJq/GcPG6vuqZiKGgOO2mRT?=
 =?us-ascii?Q?iybTi5p5Tawyiz+XvrQ8XB5sQeHiz5LyRYSYe3rVtmf1V5DK3zo3IOCJ5/tr?=
 =?us-ascii?Q?Rfrg0ZJJGrPf+5Fq4ZLje3ehttkEvX6LG4BIpvflstXVwLZP7WqxLjF7cbUU?=
 =?us-ascii?Q?0rK7udsmzmtSaK8Ze/GDDjnYdc9+eiddojnlyVTG6xorCFY7B+vRBpEIUh7K?=
 =?us-ascii?Q?6hPw4D9IlAEhdJyIx/p/UUm+ttATSsB30bnRBq/xhzlQByN8Gk+AR/8gTuBI?=
 =?us-ascii?Q?QV1hBgJXJokqddqTVZK99iX25BWkToLx0uVdWmB6t/hexYL02Ki4AEdqV4jp?=
 =?us-ascii?Q?sWwRnuoKaUMTc9R84ViDXlMdMn/PeqvOzCvPxFZE7qviouxU2gmJMHZml74q?=
 =?us-ascii?Q?7Xn25hyp+vgTrQj1lGXsO9YJtVrqxESqvgf8dhZdovucdigR6mfvPoj2LUuy?=
 =?us-ascii?Q?KiD3h8hiI+lMhCchf+FsIFoSxvo4rI8/M5JVshLgQNv4SjNmQWEsVq6fOC7f?=
 =?us-ascii?Q?t3b/NV3kYo0MEUOFzHIVVY9ujzgX58RPPA/yKQRlcvOBKVq2JmfseJGDEw2M?=
 =?us-ascii?Q?/gzc5+bQlzeUHC9iMJhFaLhzXCT19hM2TeLP4xrmTgM4bGqCREaw4ME6x/C6?=
 =?us-ascii?Q?eJWLBXB8ilcibO4rXdkPavgIOvs6rMEZX8sCpA73vkbJ5Wxs3pDBMk/si55J?=
 =?us-ascii?Q?ac6YoiL5yTfkbncPBxybeIh9BgFidnY2GdYO5KhZqzOgU87gGLPJVHZKzrkd?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402df3db-1092-447e-96d3-08dd146225e1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:49:53.3670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/7tzKKgGc431Up3b0ae1+ZtVYJHR+eZW1Ah2zmbXBnUvkXKB2p1+I+KSN05WM4corCsor5Uk/LDu93j32kcxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8391

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, December 3, 2024 12:29 AM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Andrei Istodorescu
> <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH 1/1] Bluetooth: iso: Allow BIG re-sync
> 
> Caution: This is an external email. Please take care when clicking links or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
> 
> 
> Hi Iulia,
> 
> On Mon, Dec 2, 2024 at 5:00 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Iulia,
> >
> > On Thu, Nov 28, 2024 at 10:54 AM Iulia Tanasescu
> > <iulia.tanasescu@nxp.com> wrote:
> > >
> > > A Broadcast Sink might require BIG sync to be terminated and
> > > re-established multiple times, while keeping the same PA sync handle
> > > active. This can be possible if the configuration of the listening
> > > (PA sync) socket is reset once all bound BISes are established and
> > > accepted by the user space:
> > >
> > > 1. The DEFER setup flag needs to be reset on the parent socket, to
> > > allow another BIG create sync procedure to be started on socket
> > > read.
> > >
> > > 2. The BT_SK_BIG_SYNC flag needs to be cleared on the parent socket,
> > > to allow another BIG create sync command to be sent.
> > >
> > > 3. The socket state needs to transition from BT_LISTEN to
> > > BT_CONNECTED, to mark that the listening process has completed and
> > > another one can be started if needed.
> > >
> > > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > > ---
> > >  net/bluetooth/iso.c | 36 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c index
> > > 1b40fd2b2f02..013edb19c4a1 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -1268,6 +1268,42 @@ static int iso_sock_accept(struct socket
> > > *sock, struct socket *newsock,
> > >
> > >         BT_DBG("new socket %p", ch);
> > >
> > > +       /* A Broadcast Sink might require BIG sync to be terminated
> > > +        * and re-established multiple times, while keeping the same
> > > +        * PA sync handle active. To allow this, once all BIS
> > > +        * connections have been accepted on a PA sync parent socket,
> > > +        * "reset" socket state, to allow future BIG re-sync procedures.
> > > +        */
> > > +       if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
> > > +               /* Iterate through the list of bound BIS indices
> > > +                * and clear each BIS as they are accepted by the
> > > +                * user space, one by one.
> > > +                */
> > > +               for (int i = 0; i < iso_pi(sk)->bc_num_bis; i++) {
> > > +                       if (iso_pi(sk)->bc_bis[i] > 0) {
> > > +                               iso_pi(sk)->bc_bis[i] = 0;
> > > +                               iso_pi(sk)->bc_num_bis--;
> > > +                               break;
> > > +                       }
> > > +               }
> > > +
> > > +               if (iso_pi(sk)->bc_num_bis == 0) {
> > > +                       /* Once the last BIS was accepted, reset parent
> > > +                        * socket parameters to mark that the listening
> > > +                        * process for BIS connections has been completed:
> > > +                        *
> > > +                        * 1. Reset the DEFER setup flag on the parent sk.
> > > +                        * 2. Clear the flag marking that the BIG create
> > > +                        *    sync command is pending.
> > > +                        * 3. Transition socket state from BT_LISTEN to
> > > +                        *    BT_CONNECTED.
> > > +                        */
> > > +                       set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> > > +                       clear_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags);
> > > +                       sk->sk_state = BT_CONNECTED;
> > > +               }
> > > +       }
> > > +
> > >  done:
> > >         release_sock(sk);
> > >         return err;
> > > --
> > > 2.43.0
> >
> > While testing this Ive run into the following problem:
> >
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.12.0-rc6-g47ebf099106e #7428 Not tainted
> > ------------------------------------------------------
> > kworker/u5:2/38 is trying to acquire lock:
> > ffff88800224a248 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}, at:
> > iso_connect_cfm+0x563/0x13e0
> >
> > but task is already holding lock:
> > ffffffffb0438668 (hci_cb_list_lock){+.+.}-{4:4}, at:
> > hci_le_per_adv_report_evt+0x494/0x6d0
> >
> > which lock already depends on the new lock.
> >
> >
> > the existing dependency chain (in reverse order) is:
> >
> > -> #2 (hci_cb_list_lock){+.+.}-{4:4}:
> >        lock_acquire+0x1b6/0x510
> >        __mutex_lock+0x180/0x1a60
> >        hci_le_per_adv_report_evt+0x494/0x6d0
> >        hci_event_packet+0x54a/0xec0
> >        hci_rx_work+0x76c/0x11c0
> >        process_one_work+0x7d9/0x13d0
> >        worker_thread+0x5b7/0xf90
> >        kthread+0x293/0x360
> >        ret_from_fork+0x2f/0x70
> >        ret_from_fork_asm+0x1a/0x30
> >
> > -> #1 (&hdev->lock){+.+.}-{4:4}:
> >        lock_acquire+0x1b6/0x510
> >        __mutex_lock+0x180/0x1a60
> >        iso_sock_listen+0x2d4/0xe00
> >        __sys_listen+0x163/0x240
> >        __x64_sys_listen+0x4e/0x70
> >        do_syscall_64+0x71/0x140
> >        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
> >        check_prev_add+0x1b5/0x23f0
> >        __lock_acquire+0x2bdf/0x4580
> >        lock_acquire+0x1b6/0x510
> >        lock_sock_nested+0x36/0xd0
> >        iso_connect_cfm+0x563/0x13e0
> >        hci_le_per_adv_report_evt+0x4f8/0x6d0
> >        hci_event_packet+0x54a/0xec0
> >        hci_rx_work+0x76c/0x11c0
> >        process_one_work+0x7d9/0x13d0
> >        worker_thread+0x5b7/0xf90
> >        kthread+0x293/0x360
> >        ret_from_fork+0x2f/0x70
> >        ret_from_fork_asm+0x1a/0x30
> >
> > other info that might help us debug this:
> >
> > Chain exists of:
> >   sk_lock-AF_BLUETOOTH-BTPROTO_ISO --> &hdev->lock -->
> > hci_cb_list_lock
> >
> >  Possible unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(hci_cb_list_lock);
> >                                lock(&hdev->lock);
> >                                lock(hci_cb_list_lock);
> >   lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
> >
> >  *** DEADLOCK ***
> >
> > 4 locks held by kworker/u5:2/38:
> >  #0: ffff888002213948 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
> > process_one_work+0xce8/0x13d0
> >  #1: ffff8880024a7da0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
> > at: process_one_work+0x758/0x13d0
> >  #2: ffff888002300078 (&hdev->lock){+.+.}-{4:4}, at:
> > hci_le_per_adv_report_evt+0x152/0x6d0
> >  #3: ffffffffb0438668 (hci_cb_list_lock){+.+.}-{4:4}, at:
> > hci_le_per_adv_report_evt+0x494/0x6d0
> >
> > While this doesn't seem to be new I think it is a good idea to try and
> > solve it so we don't run into deadlocks.
> 
> Looks like this is due our usage of a mutex as locking for hci_cb_list_lock, we
> could perhaps use a rwlock_t like its done for hci_dev_list_lock but I think we
> may still run into possible unsafe locking if there are multiple writers, so
> perhaps we could attempt to convert use RCU which does allows us to do
> certain operations
> lockless:
> 
> https://docs.ke/
> rnel.org%2Fnext%2FRCU%2FlistRCU.html&data=05%7C02%7Ciulia.tanasescu
> %40nxp.com%7C493e0b198a26497d5e2f08dd1320bfb8%7C686ea1d3bc2b4c
> 6fa92cd99c5c301635%7C0%7C0%7C638687753582549789%7CUnknown%7CT
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Eyu7
> %2BLOcRhCHYA7wEpkikFHsUgJQKFHRAZlPFXcPn8s%3D&reserved=0
>

Even if I use RCU instead of mutex, I still get the following warning:

[   75.307983] ======================================================
[   75.307984] WARNING: possible circular locking dependency detected
[   75.307985] 6.12.0-rc6+ #22 Not tainted
[   75.307987] ------------------------------------------------------
[   75.307987] kworker/u81:2/2623 is trying to acquire lock:
[   75.307988] ffff8fde1769da58 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO)
               at: iso_connect_cfm+0x253/0x840 [bluetooth]
[   75.308021] 
               but task is already holding lock:
[   75.308022] ffff8fdd61a10078 (&hdev->lock)
               hci_le_per_adv_report_evt+0x47/0x2f0 [bluetooth]
[   75.308053] 
               which lock already depends on the new lock.
 
[   75.308054] 
               the existing dependency chain (in reverse order) is:
[   75.308055] 
               -> #1 (&hdev->lock){+.+.}-{3:3}:
[   75.308057]        __mutex_lock+0xad/0xc50
[   75.308061]        mutex_lock_nested+0x1b/0x30
[   75.308063]        iso_sock_listen+0x143/0x5c0 [bluetooth]
[   75.308085]        __sys_listen_socket+0x49/0x60
[   75.308088]        __x64_sys_listen+0x4c/0x90
[   75.308090]        x64_sys_call+0x2517/0x25f0
[   75.308092]        do_syscall_64+0x87/0x150
[   75.308095]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   75.308098] 
               -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
[   75.308100]        __lock_acquire+0x155e/0x25f0
[   75.308103]        lock_acquire+0xc9/0x300
[   75.308105]        lock_sock_nested+0x32/0x90
[   75.308107]        iso_connect_cfm+0x253/0x840 [bluetooth]
[   75.308128]        hci_connect_cfm+0x6c/0x190 [bluetooth]
[   75.308155]        hci_le_per_adv_report_evt+0x27b/0x2f0 [bluetooth]
[   75.308180]        hci_le_meta_evt+0xe7/0x200 [bluetooth]
[   75.308206]        hci_event_packet+0x21f/0x5c0 [bluetooth]
[   75.308230]        hci_rx_work+0x3ae/0xb10 [bluetooth]
[   75.308254]        process_one_work+0x212/0x740
[   75.308256]        worker_thread+0x1bd/0x3a0
[   75.308258]        kthread+0xe4/0x120
[   75.308259]        ret_from_fork+0x44/0x70
[   75.308261]        ret_from_fork_asm+0x1a/0x30
[   75.308263] 
               other info that might help us debug this:
 
[   75.308264]  Possible unsafe locking scenario:
 
[   75.308264]        CPU0             CPU1
[   75.308265]        ----             ----
[   75.308265]   lock(&hdev->lock);
[   75.308267]                         lock(sk_lock-
                                            AF_BLUETOOTH-BTPROTO_ISO);
[   75.308268]                         lock(&hdev->lock);
[   75.308269]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
[   75.308270] 
                *** DEADLOCK ***
 
[   75.308271] 4 locks held by kworker/u81:2/2623:
[   75.308272]  #0: ffff8fdd66e52148 ((wq_completion)hci0#2)
                at: process_one_work+0x443/0x740
[   75.308276]  #1: ffffafb488b7fe48 ((work_completion)(&hdev->rx_work))
                at: process_one_work+0x1ce/0x740
[   75.308280]  #2: ffff8fdd61a10078 (&hdev->lock){+.+.}-{3:3},
                at: hci_le_per_adv_report_evt+0x47/0x2f0 [bluetooth]
[   75.308304]  #3: ffffffffb6ba4900 (rcu_read_lock){....}-{1:2},
                at: hci_connect_cfm+0x29/0x190 [bluetooth]

I think the root issue comes from an A->B/B->A type lock order with hdev
and sk. I submitted a patch series with a fix for this, and also
2 other issues that I found:
https://patchwork.kernel.org/project/bluetooth/cover/20241204122849.9000-1-iulia.tanasescu@nxp.com/

> >
> > --
> > Luiz Augusto von Dentz
> 
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia
