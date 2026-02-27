Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586934A765
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210582; cv=fail; b=d98zRR/VnVUnr2qEqBGsVnWNKpVNFQ433CyKCZjCe+ZJoYsTvFtTDdWXJbus2Ol1BsyIcFuiAT6qxYv65jVvBGpF2qp1IjuMqcDZJ++epR58GxpU++IRjXKyfabmqBnURFTaQWOItpLrwNoy7WWBEBflJWGkMJciRk/hwS2/c+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210582; c=relaxed/simple;
	bh=gLz2u2LECgBAFIiRac7/cz/LEkDyeeoXxqRhqnwPFSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9BKkMGCZJVqej+26KCj2wUKL29uSghmG1FaLNLZP3qrw0FHcrJd/w2U0ZxDPtxsbZhHA1ydb7zu5MHeojGIArqM+ruLbOR+p5MZrHOgfKpDf0fqA70mef/RLjnv5bl6NUoyYMOCU2QPQycC/pzCCU69ixh2flsj9bhbfLrf83o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=iFiX311Y; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="iFiX311Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+razBDjgAqtP46knygrHnnfXarKALlNdVOa5r/0xpGCI/QGMvYnA7LwgeikujsIJqvJmGNJ3tKkPQ3K6Z34rJV3ttijfHjTeyl0jth0hK4NNtvzI8UsrUJmhicLoTp673IPCXGV3UNaqMDe38UEark7rOxMYDQ4vZMUDON/GB7DiJ8corz39nhmEqnfLiNvPc/P0mkZpQRXQiiMKEXqLcl1EbfS8GGRMaKAeZuAeXzuMaIAlVePxxdImH4AMPmmIr5N1tRoligMbe9NViNWJV5Db8YakeX/+H/06RTxWi0J7pIfytpvU/ha2U0NqKJlwUp6DXPT91J6AK6hyEAjcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92TsBn7ZxKxqEo08dTCcCMjKBVTj+aR7FXhmnSBFJi0=;
 b=ZWCykjUk/eyPWKk5DSzfQZ4kgc6SefKeK/i4DGdVZpk5TiXj+ha+38CE8P7IEFpaex/2DL1oTnih5Pu+f+Jzl6DU8mygMAnqjrm8nCl7Ddr3SqMmg2im0yb+x1/mijptWSau7khmV38LFu/muSZx1n9haD18cIGlOTgMt/a3BV2FlyWe0yywED2sVDh5ABixMyNd2V6OEDR3XPFU4SdP3x9pd8+vxz089AwqWFvxPky2L9nxKagdo/yQj0kZU6m/I2VbincowzrgkAdLBfEwlwq3utwhk2WlC2ZdlJE5cGzeTZbiVqQ7XTvcDG1XlHPF+IzVOoINL+nEvQcLnNZz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92TsBn7ZxKxqEo08dTCcCMjKBVTj+aR7FXhmnSBFJi0=;
 b=iFiX311YGSonuSnK5fLWMQaUbPEbfpo0U8OBwnnF4KiTY84xnEyOmtYw5uQgLHtL4aeiFtRg1jk/S3UCnIkx5dNnyqSqleLwQ8t4ByLOphAerL+aHHuzcktvu/GMTFZ5AAakeUCRcvrJs52DFkcEMI0NIyVkM4j8EedntA644/0=
Received: from AM9P195CA0004.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::9)
 by AS2PR03MB9098.eurprd03.prod.outlook.com (2603:10a6:20b:5f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:42:50 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:21f:cafe::72) by AM9P195CA0004.outlook.office365.com
 (2603:10a6:20b:21f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:42:41 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:42:49 +0000
Received: from n9w6sw14.localnet (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:42:49 +0100
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <frederic.danis@collabora.com>
Subject: Re: [PATCH BlueZ 01/15] doc/qualification: gap-pics: add footnote for
 TSPC_GAP_21_9 feature
Date: Fri, 27 Feb 2026 17:42:49 +0100
Message-ID: <5022130.OV4Wx5bFTl@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZJJZRav3wRfmkQNg-kyARXwf6A+yDRu94jt8Fb6C0OULQ@mail.gmail.com>
References: <20260227160022.21462-1-ceggers@arri.de>
 <20260227160022.21462-2-ceggers@arri.de>
 <CABBYNZJJZRav3wRfmkQNg-kyARXwf6A+yDRu94jt8Fb6C0OULQ@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|AS2PR03MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: ab04cbcc-b1ea-4e30-cde5-08de761f3e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	pGlXOGUFwLwJA1vBxi896GZINF4B1CpWvZJtSV90U29oZli2u8NY99PWZpBj10HwM0wBlvR/Fqs0O0Ko5ekKOWVs7rLfLPreCsLG0ne4daeNDzwPtgvL/ZQjiDsNWztcUgBMpdUcmHnc/Unwf8Uw3cAGkuuqrU5v7g+ppZQnhTzQ/QIAglzzAWsAIft0DcEs9Ka7V6JQ5qclyP7S6UQWb0TThf+OOhiDAq6zhRwsJOuUhPtq+aXBA1qFhTxxkUzSNYqe7ZguijlEXWxMqnB6RJSZz6j3/nD+WscX+Vn7AhjaSvqUnrdp1NeDLsIIT+F40UuqLAP5QewV/a31RbHiVz8qRK8pdma8R8mW2C6VR5wGBynBEHSNK4dK61HbWMf7dO62tXyGvNZiW1wqs4ZjkSQyAVPNuo1OU0Ev7hdLpsef51ETLpkf//G9MXdcs2pYBVt9h+lXHP4rqu9qbAghj3/6ZQ08HkD5cdaaTjpqxS1dQSckh0XBsCF5K1QHxCWIldUEyOiwQfWIHBwbcTqn8PGxcWLMb3R9zc1hqBGswReeosgGUtjWi4DnPYueQWUyyCly4M1kQ7ZxIRO3QrJeKe6lVJam6MRX909A8JfQgB/NrZBQL4x27oZvYucEYt/Hwfz/79A91648JQT0dlFQootg1KK1pKqDgNLbO8VKWUPg3Lw7iM7duZ+nlmniz9hbirvNo79ARy0FSo5zhB2Z6J10fkeTDcCE34Jd8GbNbq02yfUmClDO9VEAsz51TPP9PSnYxCU9EmjhdkjaV9sCjDPk/GvtMvrN4VJ5ZU8gO3s=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	okc1YloJAB6ZL94kxHYMb+R5x381GpYnCAY7IuFsTK5En0Sg00/6vtutwwKc1hqlcHpwO/ARDIUiXFuXnY4Y49hj0rsUjWzKR40N6DG/mwSIYXx77VvuD707YWSwPUjuWKuBg8u26SIyGz5jO9LG9eDsomsewRlyJgPFUECEVErwXY+hTahCeB6yN1P05vTvRhOxy7OQDF8KNr8p3tyRDIGea+XYCTDZ3pPK/wn+UZJRH8XYyW7x30dY2P7MyKKN1FqxpLTCUCKRzBefgkJZt/yVXDh/jQl82lqy7mTSz/frrdw0l9riqOERdAbFkhVkpsXvKzhOG50uatDI5qqh7Iy+M/heH6+lbtFtZaVNUKusn4G2nSIweGLBMj1fFciM5SJjvSVOVMOIX2TTMhqF/PyJLhwa8Ux7kp37RzzSfJUEyCIg8OdcvZ11Oajy1g8M
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:42:49.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab04cbcc-b1ea-4e30-cde5-08de761f3e9d
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9098

Hi Luiz,

On Friday, 27 February 2026, 17:32:55 CET, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Fri, Feb 27, 2026 at 11:08=E2=80=AFAM Christian Eggers <ceggers@arri.d=
e> wrote:
> >
> > This feature is not supported by some host controllers (e.g. RTL8761BU)
> > and must be disabled with such hardware.
> > ---
> >  doc/qualification/gap-pics.rst | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/doc/qualification/gap-pics.rst b/doc/qualification/gap-pic=
s.rst
> > index f5b63a00ac98..d7673e5da088 100644
> > --- a/doc/qualification/gap-pics.rst
> > +++ b/doc/qualification/gap-pics.rst
> > @@ -832,7 +832,7 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3=
 "Peripheral (BR/EDR/LE)"
> >  | TSPC_GAP_21_8    | x        | Peripheral-initiated Feature Exchange =
       |
> >  |                  |          | procedure (C.1)                       =
       |
> >  +------------------+----------+---------------------------------------=
=2D------+
> > -| TSPC_GAP_21_9    | x        | Connection Parameter Request procedure=
 (O)   |
> > +| TSPC_GAP_21_9    | x(1)     | Connection Parameter Request procedure=
 (O)   |
> >  +------------------+----------+---------------------------------------=
=2D------+
> >  | TSPC_GAP_21_10   |          | Data Length Update procedure (O)      =
       |
> >  +------------------+----------+---------------------------------------=
=2D------+
> > @@ -848,6 +848,15 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/=
3 "Peripheral (BR/EDR/LE)"
> >    otherwise Optional.
> >  - C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4=
=2E2+HS",
> >    otherwise Optional.
> > +- (1) Only set of Bluetooth controller supports the HCI_LE_CONN_PARAM_=
REQ_PROC
Ok, I could also write "Connection Parameters Request procedure" here

> > +  LE feature, otherwise, GAP/CONN/CPUP/BV-08-C will fail.
> > +  # cat /sys/kernel/debug/bluetooth/hci0/features
> > +   0: ff ff ff fe db fd 7b 87
> > +   1: 02 00 00 00 00 00 00 00
> > +   2: 5f 02 00 00 00 00 00 00
> > +  LE: bd 5f 66 00 00 00 00 00
> > +      ^^
> > +      ++- This byte must have the 2nd bit (0x02) set.
>=20
> I think we might want to say exactly what feature it is rather than
> just the hexdump and point to the expected value, perhaps this
> requires Connection Parameters Request procedure?
> https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Cor=
e-62/out/en/low-energy-controller/link-layer-specification.html#UUID-56ada5=
ed-4ae3-acee-198f-27ead57d86f1
Yes, this is the feature which is required.

Requiring debugfs for this is also not optimal. Is there any (not already
obsoleted) command line tool where querying of the LE features could be add=
ed?

regards,
Christian

>=20
> >
> >  LE Capability Statement
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --
> > 2.51.0
> >
> >
>=20
>=20
>=20




