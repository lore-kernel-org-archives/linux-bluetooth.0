Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022118.outbound.protection.outlook.com [52.101.48.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC612E62C8
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069012; cv=fail; b=ouTSjUT17zIVEULtRa9sEngTJ7fEspBQ6inQaXU4Vuv/5bkj3m14N1dFx5y/thjctE6ew2sm8L5Wptt2iBjNcAxfvw7whbn6i7HBoenZ4QmNiSH/Kv330ZLlCnP7hL8PtU0RbnYlsadv5gopC2fQU319JfNhm9xP8GHAHBIBACQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069012; c=relaxed/simple;
	bh=j8bxOuKo+a4rC6oj7nKwns7vKvbclags3KumC/Uiuno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nNURcsQtJv32JlMdLeF6qdgSYOwr4iqLFFQB8lb6ly46PPQDbjZf9rj1OnuLI9oo2LK9M77OACNupARsGyhgifZi8NdsZw+hHz5rii0n1RWiUyd0V7WAK/TB11GSGB9Ba9hfSYSu1dxhXMDaZp3MVKljfxKOW2KeeiGmXye5mvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=jlhhAZss; arc=fail smtp.client-ip=52.101.48.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="jlhhAZss"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rbWTQDkoR2lDLQJ41mEJpSy+DBfA6R8FxfJ/xtoWwWYWSLC/vCuaieNZJjR02Hyk3UiS0FCiNHC1sQR0muIVfLHDRSHDzHCX4qNzvMtHtHQ3TtKM6K5pF3uWRjVAi3x8PyHZqV2iSbbJm3gtwrCUqbbKsXpzMdiIVtO527LFOakM7+OrKjxXtbl2lsMJ47ZakECM3sTuOckfy5iR4flC2JA31YbaN+yxjvqf9adwduWFhuKGRPBduv6PclIImU+rIZpxyZVxZpZ9Gd1KfkoZNm6VDwKr03EW2NPD6Pa7VPW1wSad1KRaG86gayBWAjhmBG9OiUvpjbIE1eT8UUdQFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8bxOuKo+a4rC6oj7nKwns7vKvbclags3KumC/Uiuno=;
 b=YDf/x9a5Nrm9ZA4vwUIBhulZaNAws3buc/gZQtdlN8sm9fJ9xmry2vrWhIC+U8S5C6U0ZoPv998wToENSlE0oghVGQ57mBgMkhjSli4Mio06Xsq3D+2Wgbal0so45ik1kgT2NCcGV0jYJiBtZ+p6l/lc+eN0EwLSphoXyX0upz3ONYcu2wHeWUNUV0xTbmzL5mw6S4wTRQhFNx3Pvn+QK2VL4O6euHZcDj/Zqw104do4gzGD38HDZ+W6EWRwbxmUrEEgcRGpHlCGGHHWgQUiI+GR+4nhVHugXuylLTJnt5NdQRzu9K83RFkeJfnj8nPSSYPRHFZKR2O61Z5arCwOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8bxOuKo+a4rC6oj7nKwns7vKvbclags3KumC/Uiuno=;
 b=jlhhAZsscrIP34LRGaYXeIX1a0F7ZrGkX14F9Q2bb2iEjiPWf1kWsBQluiP4kuGmMbmbI0q9zm/IbBCeLxnDgKR4SYBs7xkEblM2izRdbUOKxbG0BW+pK4wsdiryohvRbhoCR1RXnkP9GPxPmdwHWCrEdIHAJDBiD74OQYC0nYHm8RQ98WmYm7c9fflQTgxAPj+AtE/uyPjgaOJCmKZ8RqApiaw3mhAOu0iSWi1oJg780kmh0ahIM0o1SsDp9F7gHPowMwPf7fnDSAAVZ3osnRkR7X3ICcLlISBGJjPYR/yreUDBWzFtZabSUZxPRjFHGpsBO4V5Ov2Ah127Hkt1Sg==
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 BY3PR01MB6658.prod.exchangelabs.com (2603:10b6:a03:366::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.17; Thu, 18 Dec 2025 14:43:28 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 14:43:28 +0000
From: =?iso-8859-1?Q?Stefan_S=F8rensen?= <SSorensen@roku.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/4] Decode system parameters and add BR/EDR idle
 timeout
Thread-Topic: [PATCH BlueZ 0/4] Decode system parameters and add BR/EDR idle
 timeout
Thread-Index: AQHccCysTOcGjBPxaEG0xgus2yBwuw==
Date: Thu, 18 Dec 2025 14:43:28 +0000
Message-ID:
 <SJ2PR01MB828274B96E7222D59B851408D8A8A@SJ2PR01MB8282.prod.exchangelabs.com>
References: <20251217160256.441737-1-ssorensen@roku.com>
 <CABBYNZLxp1aWRQp8cVMZjE-GgcTdMQPO6-eThcOiPG62A=geCQ@mail.gmail.com>
In-Reply-To:
 <CABBYNZLxp1aWRQp8cVMZjE-GgcTdMQPO6-eThcOiPG62A=geCQ@mail.gmail.com>
Accept-Language: en-DK, en-US, da-DK
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR01MB8282:EE_|BY3PR01MB6658:EE_
x-ms-office365-filtering-correlation-id: 80d41806-544c-48e9-8c40-08de3e43ced1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Mhn5PF7UCaOTsNaiuqBs9zQP+KK5Ii8VC9ntHTfl1IxPSMCi0ftSQqnxUq?=
 =?iso-8859-1?Q?QlpgjzK682njfiUXD2VcgSZLmoTmkQy6oM8CrpYwtNEq/0QwV7MB3y1taH?=
 =?iso-8859-1?Q?FRYZsw6PaYCYbDHDPW+NYm7xcEKJcwm2Wsct7xozIxKDZPvQ6q9eeUs69q?=
 =?iso-8859-1?Q?9o+E/qbmxG6K6ETqyI6NoQcg78c1nTtrFHnaG5LDnuBDz+N/oAbnKxQ0c8?=
 =?iso-8859-1?Q?KsBPR597KPlj3ydOeel+k+N1cLrKROWoHF+XgAbdkZ/3+HdH9rD1gVYhaa?=
 =?iso-8859-1?Q?HdRwcOi00XW9qKd8lhsSNHY2s5bds4GSZY3gVt2SBOKzlZEVXnqRMPP+5/?=
 =?iso-8859-1?Q?+mq6unMQcPwoCLhI51W0BFBnKWl/nATrcjst7QZUjI80MpBsAjHpnGAQEs?=
 =?iso-8859-1?Q?TS6ft5EzdwSq2//efxBXG1YvK9C9Gi1Fb/35BRCtGz2lQN9NBjYp01Hk99?=
 =?iso-8859-1?Q?7i6VYyxxw24a0qyBNkW3O7ILn/dW+K0kYbIsDeMqoHOaOwzJilZQnY0HIW?=
 =?iso-8859-1?Q?g6PPG2dgqX1Wz6JdiaJHEd+poq3+5bePfIrrAZrJMdJuSUtw/9grvdnZjZ?=
 =?iso-8859-1?Q?MxRUK2fyQ7B47YxlpPbXe45LiMiNBnV8tJTyflUHdyI1AN+jOTf9+HI+NM?=
 =?iso-8859-1?Q?hE12yrc0Xu1uaiXA4i0bc3z/A30Nn3/LVqzI4qp4lIyDo//yhIhAXE4GrS?=
 =?iso-8859-1?Q?BqIHlHw8dasG5wRdx4kAaDuwsBpU1qGVFOQYxev+HGmgBRAFaNdIM6QK+Z?=
 =?iso-8859-1?Q?4FnNkr9OgdNQXyWmBZaaUwcZPldJdLCnV7kYgs+GlWqgMaqBkN6GVUsQlJ?=
 =?iso-8859-1?Q?0JlsdFH1M6Mecg+wfCp644njEEPCn2ZjrkOLRWaWOWCIUbmLZfrctBG/Ay?=
 =?iso-8859-1?Q?wl0i/cNe9vgpx3ORhpnF2WwsXtWV8NykOiXyf0lgcVQ9rjMyEmwH9ApOsj?=
 =?iso-8859-1?Q?54GePHk/ylKpgpG0eFHnn/XY+i+pO9FUZYgo9zy/ZpASFKhlGzL9ceRzA+?=
 =?iso-8859-1?Q?+mwke1aSKF7ZvxR3mGTmBgP4Fh/d/LBaOgwpIjZC6Dc6iwimsX+jRoNa4B?=
 =?iso-8859-1?Q?oZffDzSfG0RmlWUGpKYRYmFCWVHapKR3Bt/KFoUD1ccwpykpbkMZ43d36j?=
 =?iso-8859-1?Q?ylSv/GLSvnoCDTYcvHJPL+bHALbQWW3cE/OsZ4ItavSOYoS6uIQssxbBfJ?=
 =?iso-8859-1?Q?SDw7jYADvg6mKBtoxfBxtwFBkoxvV/beCYKMgmamfhdz+zk0M/rNzUn5o4?=
 =?iso-8859-1?Q?dVffFECgVa6UYn/JEifo9wbKQcL2zKVPZoqMbyxNC581cx8toMctTuArOB?=
 =?iso-8859-1?Q?1McmJlfaJUZUATUGIFXGZoPEfvMORYyY5A6q0z6mPVCMMnR0C3H5af3o3P?=
 =?iso-8859-1?Q?L3CiuUuJndONPMBKeanD6uN+4QBP1yUl9ZdEtCzdI9FUHy3y8BV+1TxjI8?=
 =?iso-8859-1?Q?UvSan7PQVToRXRcO/g2IbB8K4pXKnxdaaR2zTY/RNbMEWd2d0ZEF2D0HpN?=
 =?iso-8859-1?Q?R1ppARmlSL9WudPiaS6rABtjVSPlkj8QraZnSYLIaOEi4cKdajGdNONm1q?=
 =?iso-8859-1?Q?7wdHvCDBG2Y6xuRPP0cf8vZAMjwe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1elAkk5C3DOCRGEJrI8RaMDCh/guLDaUsZrG9vDIWeRiMFOnM9hlev9+4Z?=
 =?iso-8859-1?Q?Of9YOIuVyXN1Yn/SwZLVykVlVdhEvJRw//h+4XpHvUh2tuBaLtw+EhxPzL?=
 =?iso-8859-1?Q?aLsxTxNScgBcSlBAjrmMMrE1zDBqofPLEAiWjvbyTYVUhqphNG2usvWmr+?=
 =?iso-8859-1?Q?eXRpUSS+U7gb4bsbh0vBnvR7J2GXCP1fvwLdpcp2aIheU/FLoAFXYmQ8CP?=
 =?iso-8859-1?Q?zm5rM8ZKciE862YeIRAU5uEQ1PK9KToYxCQLbE8f0J5Al2kPv79tvTnFLh?=
 =?iso-8859-1?Q?Y8Iss5Lpqpiwd+mA/ANFVT16KlteMbUBHSyNmtQulaXp8Q8DNW3GVeJ4EI?=
 =?iso-8859-1?Q?n4aJ1LtCQzE2uOCuLvdcfL7Dyqds9E+e/d9jIUiPmdhKTq0Fs+xizkTeHX?=
 =?iso-8859-1?Q?VsmncGuGHTuh+t6MYB0ipVg8c2OVJCGxrEXgh6JtNf86l8opVM8mTS+w9S?=
 =?iso-8859-1?Q?sE2BmfrFNPef2HW53SR5hvS36rQNRo7dO00wZJQkd9v6G+xuCKwwm0gM9M?=
 =?iso-8859-1?Q?rs73A+Tt8V6Sr2kzYnLUSOrMf/gWg/ZGjxIaeWR4CDzO3nMZ1w1inERq3l?=
 =?iso-8859-1?Q?g4Iaf2TRKPlgvKpQMnvlXT7Xlt+C1MLhBCeZ0tKLesJW2DQrHvIjGyWjPd?=
 =?iso-8859-1?Q?5a8wxugf3l9nN/xuwaIaKMjNy6j5KowROyI6zk2lJ/V8sNHRijZxoQF23B?=
 =?iso-8859-1?Q?+G+li96a5p3W+JKP98N3O/ExwNT8bHvLYUHlH+NkJxg2XFTtwcuD/qzMNV?=
 =?iso-8859-1?Q?PPjOCGsab37svKWO/K2jqlaOzYvrC5x/921BzYb1jRJl1mpK9gSPZDiXPc?=
 =?iso-8859-1?Q?lyP8zHeb/l6nQL8/Z6Z/RR1M35THvqdTfwFCL/RxMB5EitBIgv12zeaT9G?=
 =?iso-8859-1?Q?M1agEHFt+gAbwfPB7QgcQ7jIMdaBb/Z/Xg4ke80pz9DMy2sAW1m+TwQrIT?=
 =?iso-8859-1?Q?Og9ry0Q3m3Slcm15qIv8TDGEUhdFN+YflMZxTA63/RRqwqA2BYvmfHU7GL?=
 =?iso-8859-1?Q?XxMkBlIUQfHjxVUcv+ZvKIDysoiLBPnaHjbI9IXktWDDDlE3XirOlu03Fr?=
 =?iso-8859-1?Q?F+RxjBcBJrSVwXn3LxCRceSwSZ5qcs2M2Ademsibu9UV8EPk6vWn+pdOzz?=
 =?iso-8859-1?Q?Rutp6LqfvOdQCmAGtMSoUlioZhH9qju9uHUY3ynqRsG/rcvWDo+Wy7QbkK?=
 =?iso-8859-1?Q?lMTz7pGc8wHRhGvvHFVKYfRsmYZ4Mob13yZFvcGidTRMTH3VY6I9axXVDW?=
 =?iso-8859-1?Q?ZM/LtHo2HntRQnGA2kHo8g97YQVH7jHTVORir/pStzqmX4bxO98ezKWYW0?=
 =?iso-8859-1?Q?YlHqGLyZs8vwtv4aSENqHbTY6tvHzroC/l0/6K86gwkmBux4MS89075z8Y?=
 =?iso-8859-1?Q?XCp7JGnQGXPWpZPOCL4cHfNh1P0Pmw18qg09ZGQA4TAS/dHmLvGb52CCeR?=
 =?iso-8859-1?Q?vlz3wzcfcUQw0KCTcIP+w0D0fSZEqmuzq6s5pIVdNCoJ3dcYqQpvubQxVu?=
 =?iso-8859-1?Q?7JdMlSVQWtemAEKhPdqhFxxPHgs1t+Qojh/c4MXfOYAyqv4HwTutVguG1z?=
 =?iso-8859-1?Q?qdwdghaS08QcGjJBwZH2UIS1CjoPW4CL/0P4+iNBklZwjRqAjy9be9Ib0G?=
 =?iso-8859-1?Q?GO1mFJH8zwwwI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d41806-544c-48e9-8c40-08de3e43ced1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 14:43:28.6259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnSTpUfQ8zxZLOqOUcqEZxop6ZHK0N56EajBHNDwPuKrrXQui6RvnAP4FBT0u3KUrT1uM1VPbHyBdnavKyyHZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6658

>>=A0=A0 doc: Sync default system parameter list with kernel=0A=
>>=A0=A0 adapter: Do not send empty default system parameter list=0A=
>>=A0=A0 monitor: Decode MGMT read/set default system parameters=0A=
>>=A0=A0 main: Add BR.IdleTimeout option=0A=
>=0A=
>Looks like the last 2 were not sent to list, or they were blocked:=0A=
>=0A=
>https://patchwork.kernel.org/project/bluetooth/list/?series=3D1034329=0A=
=0A=
I looks like there is some delay on the mails that I send to the list - but=
 they are in the Patchwork by now.=0A=
=0A=
Regards,=0A=
Stefan=
