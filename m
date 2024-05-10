Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289822233B;
	Fri, 10 May 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336303; cv=fail; b=Xq1ueF+kRdd0F2ZSzpZuvboibpbUQVMRnj5wyEGnLTGpGghbo+ewMvGz8Y4SnH7JCLKL/ZFh7VgE9zO7DlMLaWF57c64ph/f83E2ntRpZ3xkdlYfkX2Awnzf/VPzlYEieGXHEBlmfSxUBMiDB5LihLWLbMryV+dcvY+Ua3aKaVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336303; c=relaxed/simple;
	bh=A1//F6b4SjOCYIlB0jJ6HIvCYUwSG7o0W2toyCc53iA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ra6jyUPit+8BZ4MeC5UgOE6suOqRKFpaQjrIdHLWI6vZEV6SXkhf7Z/Ds391cuPFUtXXO0HeB7Ef0YRjLak28Zw+D4pxwPXWUXt6jcwzzZy/1E40tOghcJoR2/ZmgYROlp1uz9ci5Pcu+aZlBlxlJQ+Z3vif5KVv46AoDHSVJ+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MmMbZKqi; arc=fail smtp.client-ip=40.107.8.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MmMbZKqi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvzP4fbDX9kb36ebGlEagDPIumr1J+8x3Prc2PF9aQTkbgCMni/l112fcuHC2zUMtxBlVb6KU6fOABEWb/ClfxdJiy2HjKaoEbLtdkxuxidmqOcLVxxceURefZDO2P7XnI4H0xCpsfNnppmX5d7rcklzYvcQCFbhVi3tBGQswDCICOZCBvUQ/+8c9ML/qBxXC5MXUrPA8oifzT6ouklTu/1srAJdiiMSuPweEGKbibw7H3ooy9iTdZVPI36yuNsnRRNFZ5ZP+1mox7VoYo/FK+Zg1hs0qTaanqSVNve3Bnos0A+Gc6IKPp4JW7uT2xa9vH1PjPeoFmcgB1GYs8vgLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1//F6b4SjOCYIlB0jJ6HIvCYUwSG7o0W2toyCc53iA=;
 b=c8m1aY/Jc6LmT8/U+nJOAflrnci7VYE+iK67pG7Ie57LF/dro5FWDrSRidFo00/5cjCYEsVDesVgz8SA6EyysxFryf9DQqjq+mMUAXwc3cnJDfByFC1xoH1h2t5D74JpV8VriJ4a81jpf1wPueYLLCqUiIp3F7Al/GykW4W5LVoNNme/XcxPJI/LdO2u7X5OkpQc9e6DctkdJ6lt3NXC8xngWaG4tOV/YXth5rIgo8XiHUne8HCutnw4ldB6A7VdQeOKaZ/LWJTO8aGKo5HAP82S5+Uck3LDoWSLaa5Dh4z68p+o+9r8ezG3D8hs2g3aw2GXJnnOBkq6D+lrUI3a0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1//F6b4SjOCYIlB0jJ6HIvCYUwSG7o0W2toyCc53iA=;
 b=MmMbZKqiXtOTpLx4mti2LJ6Un5npGaFlSB327pOsdfzyzY0ajoBv14zXb5MAAmD/Ub/iV5BUZ0RLaBSXQ4dtPEg5f698MEAC2OmNxBXV/pXvyt0xjPvuIp2QOhCtiUFKWPR7SwjZXU4iF1cmpTeYelYaEnDM0t281wfNb7755Qk=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS5PR04MB9753.eurprd04.prod.outlook.com (2603:10a6:20b:679::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 10:18:18 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b%5]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 10:18:18 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>, Rohit
 Fule <rohit.fule@nxp.com>, Sherry Sun <sherry.sun@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Geetu
 Naagar <geetu.kumari@nxp.com>, Francesco Dolcini <francesco@dolcini.it>
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on
 startup
Thread-Topic: [PATCH v2] Bluetooth: btnxpuart: Enable Power Save feature on
 startup
Thread-Index: AQHaosNgITon21YFMEyB5DClICojuw==
Date: Fri, 10 May 2024 10:18:17 +0000
Message-ID:
 <AS4PR04MB96925F0F893BB57A32253077E7E72@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240304170753.500074-1-neeraj.sanjaykale@nxp.com>
 <20240304192952.GA17410@francesco-nb>
 <PA4PR04MB96874E4B23D6C225AE1367F4E7282@PA4PR04MB9687.eurprd04.prod.outlook.com>
 <ZfRsYf8qhqmrGbkK@gaggiata.pivistrello.it>
In-Reply-To: <ZfRsYf8qhqmrGbkK@gaggiata.pivistrello.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AS5PR04MB9753:EE_
x-ms-office365-filtering-correlation-id: 3c20084d-ae76-49d8-7b48-08dc70da82d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jzFM2nkn6r/3wwI3efUi18NyNHyWJbYbrlLYb2GDyylQ/qLhI/F2uNYxiLn6?=
 =?us-ascii?Q?o/b2G7qWdbj8kUqvAQ4Ggro0f991Z0acviB6pMAc9feL1xWaowUPW3k0uBDL?=
 =?us-ascii?Q?Pw1nRW63IbDIfhy9OXAPaLQDtb1uKthx/nA295/un4g5GAgRCgLw5DeBFCJG?=
 =?us-ascii?Q?gxMoaObkbcQE8qo/dEzorVnRx0ot2Qilq96yTRgtRHcsv0kUUNG6gsHCw14X?=
 =?us-ascii?Q?6Ksf6yJ8GxeZAiTT05gvGS1iX2cIWR6p9Mm75xyklkzxT384skfPe6KBxuMG?=
 =?us-ascii?Q?g182Py9hC3jexaIf5BEByWTE8em2tIV3jDsQr3yRy039S9oS7Y5YQaYESVZo?=
 =?us-ascii?Q?cjeXwNs3cNw3xfksDv/BfQXJvmxc9UAepOqk/FZ3P1pbR0Yt1qQP9s7NoUbD?=
 =?us-ascii?Q?FgnOhA6lPtA9Ond3zdxOWJdT1UVlkwN3edmcyH0AwOUf1RsJ/0RyGIWvfKyF?=
 =?us-ascii?Q?eQaqK/M/CEmAFrSbKSjF0cwPrNlFL+Y2irpRp/ay/4zN7YPDFLAm5EEFHtZX?=
 =?us-ascii?Q?MbsW2/USRk19KF4dx8W+IvJkYivLe5FYENl4OV/sTkw27/2VOYmmxY9LJdHG?=
 =?us-ascii?Q?d6/Uv7bjT3XQqjtXYqBC7iNXPBP0yGdXQ5d2oCscJ+LaJYn0omReplTEoge9?=
 =?us-ascii?Q?QZMFExcBI6Dm4wj0kC6/eeGeHPX+a18eqs12wKvrdWS9J4d74Ex2t6nbzULr?=
 =?us-ascii?Q?RdKR7rbTewy2w77GhGdAbR48uzwoPUJjMJUPOuhep6SsUQLiScCJTZBhtssb?=
 =?us-ascii?Q?baeexbAJcl0DsC9ddYKuQW56Lw9hfq+scRPU8gRE5Jz2y6mehVJGL7/x9pww?=
 =?us-ascii?Q?AikopJ5J5hzeN4q/zAVyW4yoH8MwklFteKf3kITHzfhFDTUJ/CmrmuniF2d9?=
 =?us-ascii?Q?5BVZh30MFCgv0NE6GnXFPjYmhyMIkavgQLZmCyC9fS63WFt9GFkBPU5OXozd?=
 =?us-ascii?Q?Do01iI6eP9POlz6wL7DR7JRkJJSHbueQG01qqqz17RBPueyf1l8o8MdD8O6x?=
 =?us-ascii?Q?ydvDpWBI4QTtdJFZ7qelkjrELpJ+y2/ZYJbKkDbwN21rXKmRf/0dVQ90ziXJ?=
 =?us-ascii?Q?YLbaD3aVv2Nn/9nR3Vr3nhM9ToxXUzzTKahC9Eq2nu4UoHnj8gpPWBpwp2gT?=
 =?us-ascii?Q?q/fPXJa49nha3GcpIsQyAs6qfNVttX0Tcf/1m+8RDeMQTpGqvu++CPk2R2Rs?=
 =?us-ascii?Q?Ipj5dEW6B7jNNbAmXQHi8cJLsGilE7HQeIBdtMUl4AqahWbT3+xMvPwyGLu0?=
 =?us-ascii?Q?88v/SxxYMBWIoRy4mGx7wLqzqOWB1hiltGSy0YoBMVtTVEU84dUx2SAX2/uP?=
 =?us-ascii?Q?yhqQxC17bF4yREr/Xb+Zd1+5SoVk7yrdVKkhq+dtOtGH5w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2P2imknf5/LasgGyjq7AS/uen3aUxMQDEli3xlkX43/Xgv4Au9NE2VghfTRG?=
 =?us-ascii?Q?HQAzibDTslAOblt29giWW7YJUltqJ6+ohrCS4pRaF+LjWvSAw3mDF59ljmtU?=
 =?us-ascii?Q?1taiUVepUfkDW+PWdiJyBQnxbLbLodnsia5FXolEgxOykZzJ8A+FxkERonJI?=
 =?us-ascii?Q?IwAYmK2y75Ie0Rt/qx/xr1LFQ5ti9NtuwaW56m6fukYhKEJP87g1ZpjQMOYG?=
 =?us-ascii?Q?7gE8dh8p2y5clUT4cpA3WKj/qYgoAjmvO3feVOOaRn0S5fUHhTb/C3Wul0lV?=
 =?us-ascii?Q?eCuot+nyHd3edNbXLeziP5ymM/mtMRk8xfmJeNrxuXk6+LwkqQ8cTvYQ2koX?=
 =?us-ascii?Q?XsNZug6B9MWaBHEwKwvGxAPEXZvK1WNG+sxYYd7qU2SrQhSCM6r+i+jRKJ02?=
 =?us-ascii?Q?GxCR/9wCB0W9Ing189h1SeNDgKssZNz8mJrpO35O/2usFgUV2Gqc/K9Y3xE0?=
 =?us-ascii?Q?xRtTSZmUbb1a/fIeDaXpl/4CdSg0kJ/jjbg2zroxE4QxpqvrJ+H+PVf5xt/J?=
 =?us-ascii?Q?NzHCX2Tzuz3hjkygN6LRaBHZCjNMKqK45WrdHOoCpgZw1DdAkXkjdEAMfYPw?=
 =?us-ascii?Q?FPSlR8xXYg5OKk4OVMFxQM6dmaM1MDv9A4XsFognDrYpwh+/9LEDGy01ZLDQ?=
 =?us-ascii?Q?5SuV9+ZyIOBIntS0iToqk2SE/uoYLqXq+Vzar/ohAQZte94G6FYZBSOMsQvp?=
 =?us-ascii?Q?UD70mSsDNbAvzSHNe/n3ockLiVwjLGt9565TGdJAdyg4TIkXT1azZdjMoIx7?=
 =?us-ascii?Q?UcqxC6wujfVhGVbcdALkJpXakR5iuqb3MqWSqDKs5y4KMMYpgR7LImhPAXnz?=
 =?us-ascii?Q?t16gO3Y9DqvcSWDzUf2WjdOwRG8DDYbQWSdM3DccgdN0ge8HmDkWSYs1UfRV?=
 =?us-ascii?Q?NVKofJw38WZbIrLNISoA440saYq9MvAMBnEYs8JUiSsxEMbfh51OxPLymUDi?=
 =?us-ascii?Q?NGw3qF+T+DM3IPJ2pZeUVUc5zu1TLvFa5tuErItPHZH80GJLEciXbyo0omKL?=
 =?us-ascii?Q?sTCekvOdgyV71/+EbBWXn+gJH0O0wIegXni7nXHoSgVXKapsY/lN/G3LH4Wi?=
 =?us-ascii?Q?1E+ch5zQ+ftKua6pESuEdWrgg6a5PvFzuUGiAUCOPW0sTvrU84TD6hTFRNgM?=
 =?us-ascii?Q?SYL3vDm5ZfHfGxZ+bTQJwoREzKSVA+nGZwkJ3VVrPzd+H8Ry7MMer4TycJ3+?=
 =?us-ascii?Q?FW5t9/glwdURRkSTRc7+asCGStsZkN4ELGf8pFaSZkTiKwTjlNyVFIAgpfly?=
 =?us-ascii?Q?d9BKXdoWemK//Qq4yOqZWPCQM7gZsM7zY0mhVR6LUTx0AN/2YHSiJmUJYj28?=
 =?us-ascii?Q?llgdt0H70ZbrrtTIu2q4Pmujfqn1EBTLRvL8nwJNFDa2I1QDSdGa6yg8IJ8q?=
 =?us-ascii?Q?Vks5AKNPoo/kaUGhdEECaGqc+pOKXs869etrE6FTSLgBXuiZlvAPMpIMj3tY?=
 =?us-ascii?Q?9SppVSXOWJl7Jgn0T7NqRDhHZRKSTGHQsbvEaJfnfvIREqZUFRWfUJ+EJGWC?=
 =?us-ascii?Q?9qGxFgnM1orwCQM/Ar8ZwqpKCMlh4/zMf2+0BEWXFgD135d0uTrMSy84Eva4?=
 =?us-ascii?Q?oG+nH6KAczUOsKg6JKww2mk5Ka5+aulQ4eJbFMCZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c20084d-ae76-49d8-7b48-08dc70da82d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 10:18:17.9627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xa5pAJesuYNVAWCpG9qeWi10T7FNAbRQPQROCvpUP+pPSAzHotad1gOBHIEDAloXO5D49eJhJH3laTEqewlxiBrjhKrGCMVNGqtkwrydEvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9753

Hi Luiz,

There are a couple of patches like this one pending review. Can you please =
have a look at it?
Let me know if you want me to send all the patches pending review once agai=
n.
Thank you for your time.

Regards,
Neeraj

> > > > This sets the default power save mode setting to enabled.
> > > >
> > > > The power save feature is now stable and stress test issues, such
> > > > as the TX timeout error, have been resolved.
> > >
> > > I assume that the stability issue has been fixed in firmware, correct=
?
> > > What's going to happen if running the updated driver with old firmwar=
e?
> > > What about combo Wi-Fi/BT firmware files, were those updated? I'm
> > > currently using this driver with this firmware [1]
> >
> > There were some stability issues in the driver, that are fixed in previ=
ous
> patches.
> >
> > As for FW, I have checked internally and there were no power save
> > related issues reported for any combo FWs.
>=20
> Thanks for the information,
>=20
> Francesco

