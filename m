Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2090.outbound.protection.outlook.com [40.107.101.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6D41238
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710340050; cv=fail; b=kojR0Xx/RNbWA9MUbtwS+NxCTBGhEbIHImvCFOsrOgQ7XBaL3GBvmREPyVnKzx+++kC14mGKRypZ3tWEFbLDWXn/4pjsKWKzpAWXsfBVRTpxSbQrPE02qaYmxSh4JO+F2FULf5uPNKG36iGZzKof9aW1ACeoky9w0gd8t4oFlOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710340050; c=relaxed/simple;
	bh=6ubWFW44QF9gqV0D7Uo1DJTCl+aa4GgkRzUVoadfXiI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ntGuYdiBs0sqcOsaacp+JH5rdZgcxXGj3Ofrvj1kpRwhXa0UFgLIp3qHZNzcSof6HBXSTySMIl8Y+pmsuzikcIl84nZkXAPekr75H1BLG+O2grdfZt3jCZSemXRMnRqcBpc3d7FR+ZTn9RRsgIr8mH9LuItAPdHuJMjIQLqoofQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lairdconnect.com; spf=pass smtp.mailfrom=lairdconnect.com; dkim=pass (2048-bit key) header.d=lairdconnect.com header.i=@lairdconnect.com header.b=wxWP/8gN; arc=fail smtp.client-ip=40.107.101.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lairdconnect.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lairdconnect.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lairdconnect.com header.i=@lairdconnect.com header.b="wxWP/8gN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVrr47VVL6TxX7dYQQNxmfqq3I94LjFz2hKzHIk3R460uYHKs8+9NbgYAW5tK0P5Isl1VwqfeZZ62MwRX4ajZEWRRPhlQeleOg2/IRhxMfSLR3DDn6WpdfedN32quVwQ3MHCQ2QJHXYeYr4s9tAbetVeXU6rstgbiigw7UR+dGi6Jq/+gvyA0h5GThl9Lo5nNXBuB7gszDjkm3V0fsAvY/WKWVDa6+PtrF8MUQdlDrtm+8yY43Hlbm6i2vZXUF7BZv+93QVlIrzU2FxMBu7fxGzLWC/eZQHyXGH0r90yo8SY1UtseZWtwozQZ/j/r2010iIiAcBv6s9OIbAASMVZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ubWFW44QF9gqV0D7Uo1DJTCl+aa4GgkRzUVoadfXiI=;
 b=F75WNd5qAS60BarbgJKNo+eRHz8wQo53Qhb/1h+ZvPi9owf+0X+j4Ln3zrk7gTdNiz5ivuaoMrUfo1RXg1KJQu5xFutKSJVvgRnRXQUdoDUU6KnyEERnbGT5pfvzZuib4+t/iEeTCOlo95eSpqAw8WOwdb4vOnhb8Rls4QJIcrqM66ds0RWZeF/5HNI3zoQFdfHc96/6X/OrZbg3XKrtM/q2BfpLajVUYohpoPhdKFW/3eKtbZd3xnn3iKW8UQ+8kwhNTNF26CqdrdFciWSnHReDMhCY4PlWN3EypJRA2WthCSrrhHdLn7oUVG1h9q2rqViDCe5p7CznJGTotrlqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lairdconnect.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ubWFW44QF9gqV0D7Uo1DJTCl+aa4GgkRzUVoadfXiI=;
 b=wxWP/8gN84LBq6A2zAritfLavdloI9nsRBpYv1C4FMvGpwhVZltZUAfEZunbwOLXGgnV9TcdZzRQml78qbX6RnFktKDabLdGzXhyDE/kVH+prHIyYaDNpBpV/Fpduk6yW94CME/Fyv3LE6bf/F+Zmya8bI2PhvqJ3xVGmKaFF9owmvvHGLmTlnXPKh1+vmcaP7otElPve2U+vWa98H+sQ4wLOZLEeYgiwO+AUk/yolAlYnyoyz1eAJQrO+WQVE+02Htw4Exj85qRMPvZFQBnTDnl8Kj0FIIq0ZhThPhtzSA0OPkEiImP2cZ20SBLFuQKku7okuUIySLv6mZ8fvzxlg==
Received: from PH7PR14MB5300.namprd14.prod.outlook.com (2603:10b6:510:13c::8)
 by PH7PR14MB5781.namprd14.prod.outlook.com (2603:10b6:510:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 14:27:24 +0000
Received: from PH7PR14MB5300.namprd14.prod.outlook.com
 ([fe80::e26b:8dfa:5b06:594a]) by PH7PR14MB5300.namprd14.prod.outlook.com
 ([fe80::e26b:8dfa:5b06:594a%4]) with mapi id 15.20.7362.031; Wed, 13 Mar 2024
 14:27:22 +0000
From: Chris Laplante <Chris.Laplante@lairdconnect.com>
To: "'linux-bluetooth@vger.kernel.org'" <linux-bluetooth@vger.kernel.org>
CC: Chris Laplante <Chris.Laplante@lairdconnect.com>
Subject: Concurrent Peripheral and Central Roles
Thread-Topic: Concurrent Peripheral and Central Roles
Thread-Index: AQHadVKP/Sk6SiRdkkOOc4pRWv18Ww==
Date: Wed, 13 Mar 2024 14:27:22 +0000
Message-ID:
 <PH7PR14MB5300AF1826295555381F300DFB2A2@PH7PR14MB5300.namprd14.prod.outlook.com>
References:
 <DM6PR14MB387122AE48F0A1870EDED496FB9C9@DM6PR14MB3871.namprd14.prod.outlook.com>
In-Reply-To:
 <DM6PR14MB387122AE48F0A1870EDED496FB9C9@DM6PR14MB3871.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lairdconnect.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR14MB5300:EE_|PH7PR14MB5781:EE_
x-ms-office365-filtering-correlation-id: 4765f1d2-2817-43b4-110f-08dc4369b251
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Fdws77orlj0fdzNVXxyyAtTknsW5q4ZCePZkCtXMVPHYvVLU3BZoX+vTAQaHHAj6XqYUst2nrAcE7HWnSWHWuyrkOL2PGCJSzf2uGMdU60DZxpnVBt355vAippz3lhH1Z7DFeQFZ5qBzKuvv750qWkv2SWSoRIrQZ8NdVc2hDEX9JKPp2Yq3ZOTo9RLBSHIv7zMpYStyKMAkXdYo9jGeDX+9lfWT3HLq/PwzaDuEtapwUAjPOhd2VC909RGkNBuDPr4tceOkgVD3Tbfv95Z9xcay49mciZiDmaJnXZ0qysiYzecQC+u0hKpN+zoZCVnlwF6ZHVFRPQpF1lE+D5/+Mqbp5e2Nwn9MNr1vftTAvPyzU1eE4tp7yRQ/73YotDYBOcrcglvgz43qGGt45a5wiqbwcn8hEAAhcsqFX3a//kIhPlokY9W3wPnXC+B//ScSjHWE20ta+XOD/IKYbSn2/uQCvHYs+lOeGh2KGoD5aZh0D12xErsHCf43uwU+Gjh4oVWLW9bMv6D2uhpS3DYwqlu6m8yZvq6qdqkuzL/gKDv7PDzAbZ39E1awIkP0SbKdK59/No4F8ImwK/8RROcU0QzEupRfL6RY/OPkJ0JDXwAXbIEv1SIXpqaj4tk5tlLVtXJmthwaQ2AoN+Ngf79ESr4PtdmQSjfgl00SD7x6PXgUSSDR8gKbmy+zTGafSXuKx5PkwM4cC8vhFvEpL/EF/0SXAaGvYt+GxkJztYP/fU8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5300.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YfLUdZiZzg1QocdPtXFxeo/tu+2X7qN/aSrCLrNtyu/+z1bq9FnqMbFue2U/?=
 =?us-ascii?Q?pdYDZ3xZGRUB3kHCAkq4vY+PTBVosTJYTXb1LKkTuQmr8hpfNk16US2e0MQq?=
 =?us-ascii?Q?ZIRXlRKU2gppGV22OGv4DKX18hlG2G3N01kre2eNLd1EfTCpIzF5H5AmSQI3?=
 =?us-ascii?Q?cuthvtL2uU3R42mvC5HakZCwd7/z6s2xUfifz95Wa9yQ5XJ7oCcaI9s6hgH+?=
 =?us-ascii?Q?CWpviBFHA5RdeToN66O7BU7awsOftrqIAFjYEwMS05blo9TkkLckEbkdN1Ow?=
 =?us-ascii?Q?EZwPGhd9HAUiG25yunrQa5xPNxQwJflHPdeCUdSMLAIoHAyUealSyDIf1mvY?=
 =?us-ascii?Q?4lXlAQ5EXE49cfk9g1XWPRAX19wvYDys+DIVxJKC3N4qiwLWFMHH1F8rPPjg?=
 =?us-ascii?Q?ZMbPB6h2ltVGKndf6hUfmf15VkIgUR/1b9DdNMKbbDBEaJTl8U+pa7CtvWhh?=
 =?us-ascii?Q?zuHwNfWEgnoFpUgLJRfTFS1rGMdFBwWclkYRHXLnDyvdd6CkXlFjS5TcAnOf?=
 =?us-ascii?Q?lNBxn7g4uWTTxdkgUuffMYlaFAnz/7ZJ20+l1946ZGECpdOnoScarhyW4TPj?=
 =?us-ascii?Q?V+hddUdTfFvbKe+s19e1rCP15rYMdm0yqnNpD855lknrC69N5a5X1mR1NWOq?=
 =?us-ascii?Q?fZv5+4llrn4HNNp/jFqK0GAsdEJDQaO+4zishyTWJUyPoy2jxXjDqyvS69Bi?=
 =?us-ascii?Q?9FaDQbwDEfXzh4q/PyuP2xUW0iZCva/iEWg6Z5Er6M6N5Ti5LfnSD4DgPCjy?=
 =?us-ascii?Q?5CQcFQ9SiSFaPEcci30u10EIOS8SaK0Ou/PyBc/hzbZuHBmy4omuNCvpgIhI?=
 =?us-ascii?Q?6he9bYQVlvwLecKAx4naHxgyIlI97VoS9CRnbsj8D8VWIeZiWm26hReNQxTW?=
 =?us-ascii?Q?fx+HYbZpYwodld52oJRiiwPIOxwU6m1AKX11NW/JvAT4uYC3oayQZKpC6g5e?=
 =?us-ascii?Q?WuEHFFWnhJOUrqE1kbq14xy4+EV1QUIQl2EY2vtPAGfvmw1Ysv0763TH6THC?=
 =?us-ascii?Q?mWWPthqTjnxi3URHeBU6aJx+UBtdfqQjQrF4eIgK71BIXOkilc6b3+M5IUFK?=
 =?us-ascii?Q?R+3j++XmP4D6L3cVfeyQVEDPYbsgSeqf5Wf/ZuxNHZOtJVXr1OzloNVQ0SCS?=
 =?us-ascii?Q?JeuMpOVUMn3N3FiCHSN3XpKib++pekWfvDQwpumxFGvx8tGsvDsKORJv/NM2?=
 =?us-ascii?Q?6JPJkg7WBw1fo/NHsRfEKUGzo2gFZiobKxZC5Z+485e/u68zObE+4ijUm/1p?=
 =?us-ascii?Q?+xnnoLnmn+Pg8kiNLyDw8lv5VWwOBbLknxpJc+zjv+H/VQG47Do9BKCs5nee?=
 =?us-ascii?Q?WB7GE6FA27yS4N/eblg4jUDKJ9lZ4BzDlLrkKlrC0Buljg19b4yQ9NnSIM3V?=
 =?us-ascii?Q?QJvrjunixqUnSa+mrFHJJk6mNF9kzpkVkJHIFekcyxtJu/HfQ1RN2LS5u7IR?=
 =?us-ascii?Q?jxqYkWu4cUz74lrCasV/muz3rgjQkXfPtT5XpYrC/cQB9UUfNuLuhbbe14W3?=
 =?us-ascii?Q?EhucN0asA/bMOuwoL4glFchhgMlpVFT93SKZX9CFQrcAv9FRin/vx6rkXwgc?=
 =?us-ascii?Q?0v4bv8+2RjSoLqGW5C0e0N1dhvAQ4km3GH92k8hStfjWJ30BNmTS2NtupFad?=
 =?us-ascii?Q?o+JMl+5QIzbzeyvOgoqyIIhHaQxV4T05MC2AgS5CB0Wwiole6+7ByRwqFuHt?=
 =?us-ascii?Q?csAUeQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5300.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4765f1d2-2817-43b4-110f-08dc4369b251
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 14:27:22.1749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EzNzwUXnBjtnr0ZyWg4kHDCkw0pt8QibYFF3J8K8JHM/yqmrCnD3RXET/wexQ89z0Fkp5ewyUnFvB7Q5BmaStp37t8KnvsuWOFDrF4eqpYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR14MB5781

Hi,

Does the BlueZ stack support concurrent peripheral and Central roles. I don=
't think it is supported but was hoping for more details.

Thanks in advance.
Chris
THE INFORMATION CONTAINED IN THIS DOCUMENT IS OF A PROPRIETARY NATURE AND I=
S INTENDED TO BE KEPT CONFIDENTIAL BETWEEN THE SENDER AND THE INTENDED RECI=
PIENT. IT MAY NOT BE REPRODUCED OR USED WITHOUT EXPRESS WRITTEN PERMISSION =
OF EZURIO
