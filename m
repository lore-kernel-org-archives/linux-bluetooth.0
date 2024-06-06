Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902C913C8E0
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jun 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665269; cv=fail; b=WUuMXcmIGxYTH2sSN2tLqJs76r3AIkDUNVLREcdluQ6AwivUT3YoEfVFQAn+qzT1e5eMBZYDzeAIYEyUX0Mu68NAnWBIKTodqn39qP0Iz5ZLQkWN78/mY68yUDJnOULLhmH6aAGKOwTu/a0wMst6Mnz9uhoffR7lsj5v3RZM7YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665269; c=relaxed/simple;
	bh=RyKqSQu054G4gI2E4EwN4D61/0qH9W7Gb9SEGXlaLoE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jdt2GY92cSa6E5uOrVsWWZrPokOoatikPSB4tbPMejNs4mysORz86W/RTeecZKyRC0qfEx1QOcOHhqr26OlieqmdKUFBokXaA+409AqFFUoq9mby4+blYJdjBSavy7X8/89XqV9310h/bVlv8mlX0dzP5idsW+4oQ35BE6DiO4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BJsptL36; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BJsptL36"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTgtpH4C6Qc0ySJQaa3wLQ6BFi04Hq/ctM+FuhCG37ecXBPTwSfzu5ejofRuL+Pp8A7mpJjbDOBy2dJc3pbbPqPHfWOrZRDI5ppMl0GtOlXfd66TTGhDJHRduW5eNJglOmveMgwbWfprDe/ojlk3AzRkgDVAB4KzdWvQnvOkLVv849N7cN9KB8yU7M0jf/quIMMc5UV6ZIb74LGQq+AaznpuNmde0f4cagiuTlIZW+GVZPrXGtdb4mC9eDrx1nzkJfFulnk2X2NvPksMYMhELoSCVPN8EvVJ/t9s4p0bWANIKXRsdvAZaIJ9f35pXxIDjG6W/bundV+W7zq/t8MlWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyKqSQu054G4gI2E4EwN4D61/0qH9W7Gb9SEGXlaLoE=;
 b=hwlDgx3FsYWIjWW1ydz9pngtm+OnSv0l3adCT2v1enhhY+xs7SmK0+NYB2PEfEP/QJTkiucXdOa3c01CjqvzBp5A97/BTLL5Rc6tHczxPxXnhPQyaKUXAz86zQTGT1nRZzaVSAYUH7FFvzLmdAtmzujp5TOYhK7bNUv0fqQUjmoq259irOJx663dSOB/q36gEQmpOT29MFc4UBr821loa++RzyYgnvXqENGfCZDnrWRWnfRWYb5RZoIoNEwdE6iFAbd5L1TZ64psu9fu7QbLMznT07h8qjb1hwk9rKlbEwqE1fyHNjafxHYLle33eL1l53MBogbQhd9wAgZdWE8YJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyKqSQu054G4gI2E4EwN4D61/0qH9W7Gb9SEGXlaLoE=;
 b=BJsptL36Wf4bdNkEuYnpkh9njlyCQHvIQD9UR0uhu46TJqAssPXTTNiBYXDZ7X2w/+Dm1mH0sGccWln8Sdkjdi8NoJnxNgX9vJ0f/72eYcTOxabmCOv40qBiUmfLs1aUmkOCKhRqAEYnBZgsLgTLYIekRVJs6zAR9O5ATz/sqQM=
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AM0PR04MB6785.eurprd04.prod.outlook.com (2603:10a6:208:189::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 09:14:24 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 09:14:24 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>, Andrei Istodorescu
	<andrei.istodorescu@nxp.com>, Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: Allow users to set the broadcast code on BAP sinks
Thread-Topic: Allow users to set the broadcast code on BAP sinks
Thread-Index: Adq38c0vbRaUNHD/QMugfCaTdOnAVw==
Date: Thu, 6 Jun 2024 09:14:24 +0000
Message-ID:
 <VI1PR04MB5389A2396A9996129375D2EEFEFA2@VI1PR04MB5389.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5389:EE_|AM0PR04MB6785:EE_
x-ms-office365-filtering-correlation-id: 1d03a420-9b9e-493d-d1a6-08dc86090ee9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+6PoTYeLJQndneckroqmbgZbn5QrXxaNHkhCOXgvsiYjSsKniKoTs+J+4/l6?=
 =?us-ascii?Q?oTrqhl9GU0sFpNRtDz6iq5b8tbttl0kmAlshtaA4IC17a04CGGPvRptFo9t+?=
 =?us-ascii?Q?cVbyMrAhPWVhQh7aNpn+8rfqFrmJMlJg46RJs2ax4cuvw8Up3W5eQQBIguxZ?=
 =?us-ascii?Q?1WYs6v0tYZZM9gL7j1VhMmnxQEULUo2qvxj2AfCQCnt25rPM/Orup63wqEWq?=
 =?us-ascii?Q?2108E1j9ZyhXVpCDFgzFVcHMM20pyF1HAOTaB97WBYQK76w1PvXh8l1xY+Dq?=
 =?us-ascii?Q?z/BuNl9X3kJttp0g9UwhMRPaX+ulOJWfnDX9gtHtsq2u7A8rGm3xd46NtI6/?=
 =?us-ascii?Q?6ZlRP5S94yTFw99xijtkIWuFBQwNm3bOGFm+//QkpWjnEyEF6nZgL0OR57oy?=
 =?us-ascii?Q?LzYX+wRkAArGeZgn2ZrjfR4oChZrL377jKLAVXaXBZGFO5I1KBdI+El7vZp7?=
 =?us-ascii?Q?I+tBTX0FdrRiafq7xRpx4fx9BAN6nISEMrXdIUmxWiUhIPf2vcCAuAVEiR8f?=
 =?us-ascii?Q?9NjpC+cFF3KRHs3JrgjyeJDXDvlbuE8J4gXL3AFkr3ZdioQNw4/RZf05iGDO?=
 =?us-ascii?Q?8OkJZrPbg/Puw2sLImYFlf4Q2MKeyBSHeBaaKatn+BRpaFTDs4oOh7ty0N5l?=
 =?us-ascii?Q?pOLuIe4vqlebqajecC7B+GnUFpUKo5zlHMizXdiFi1jTAhv8+KM96pfPILH/?=
 =?us-ascii?Q?TnDtdpqHbGq4z8nBKyruB0pGglGyR/x3IE5qc5UTdngbbYGcEZxA7+D8h17m?=
 =?us-ascii?Q?PrZrKHz7dG/xsULztPNBRvZjlWFunOx/BM/fq18l2Cn/A1obXF1uImgbNboy?=
 =?us-ascii?Q?WDnrl9An4t2C/YAtGwEmi07SS/gmovs3AivzuFCORnhcOzVHzREwiCH0vA/t?=
 =?us-ascii?Q?PqepBShVZ5aLp9AwJY+fzm98Je0gfyEPf146TAIy10/IGTxROLVfKztEDzh2?=
 =?us-ascii?Q?2dRvxYfzAjDOfohgRMufJLbcDppqC6DS8yXeEToO5Q3I9HNadlMN9V1aVOBw?=
 =?us-ascii?Q?c0kXeA0NBFqNEVsHLlMKTXbL8U7BVHig3pgKcJ/TJMSFPJh02IZzD1LIHe7Q?=
 =?us-ascii?Q?dCoknNhivLvZyU77gQifspCwilDSL6QsnGt2VdyXOc5waIKB1UdYV02sbLZJ?=
 =?us-ascii?Q?VPvFpL+YAUDpS4M2vR6vyU88JwePMUMUWk7dk9OIT9OghCeMLMmBmnWoUadP?=
 =?us-ascii?Q?YPSEoZr668EcQDIrG8KJdOv5f9cUhT/xuUuRqKeNZDcuafq/oLgylMsQdps+?=
 =?us-ascii?Q?pCPy/PQkhBim7b4qz2QhAGxWCPoNFENB9uDj8FNd3jEZv0zgCkCOdzDorHZw?=
 =?us-ascii?Q?ZZ4RHfKZRAtNSvKxLH3N1GLTk1vrdzmZXgKHuD49fZB3zeWF5Ffp4+7sJK7p?=
 =?us-ascii?Q?mN2iHh8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7WKRvE+kHd13M1/GP0b0XeUqDNJa9OE7nXd0aijUUEhizRkjaA17q18dgyDn?=
 =?us-ascii?Q?+VuqPghANaRd4tkJ+BYz2RyY1Rbgx042z5W3gwQ2CrerXisXBv/pTVjP5ynt?=
 =?us-ascii?Q?kAAcd+ti0cfsFQjT6Mwe/hR4cTLvkugIQsc35iBiY650OZtUmX9ackSZSul1?=
 =?us-ascii?Q?+h6u990kvGT586oD3ibNj2NlKu43wP8E4JPYbfmT6THPV+CoGTNHkZ+izl57?=
 =?us-ascii?Q?Tx9HekhQiHLxunABg+LZtSmWh72j5cKgM6hODVWX6L+Y1qhhMheFd8LiNmI8?=
 =?us-ascii?Q?xVrvUE+PEZx4sFhjkcm2ASGTBfMzSjGFYu0+DAsVClc5m0cCk6LqM0tt2vto?=
 =?us-ascii?Q?TH9uplQuGK8EyCH+4Sj+OcNc+8vLh1fXZgsi/0c+Pg6CmQVLhxdOQJAJszwa?=
 =?us-ascii?Q?6R1rxMyBtVkYraey53K5gSgeb3grVIEO/Ym2oB2BxHMJUYQlSJ/ItcH44vuw?=
 =?us-ascii?Q?SnR2fVaQyzDCpxksSbUwgMFcj4o9/HNGK1uV4ZOgNTvHv+ESmfxMktbpVHWo?=
 =?us-ascii?Q?JnkvvaU99MthbbWVtS9oQg+ZLq05fwULekwHof7ypIAAb9WNA4gQPw9QOBuW?=
 =?us-ascii?Q?PJ1uCX9Q4l+yGaaTtDXH9BsfIEsbJMIr3OiRfMAYBYiaNF33HCIw9Kt0SHdi?=
 =?us-ascii?Q?xUJcR1KzZ4au36emsaYrxB5aH6oGZ16r1SrNIbPPRElu3GlZs+Tlo/G/U/Kh?=
 =?us-ascii?Q?hBEpJ6UlD8O+Ah9O5WLOBStwZeG8LlaDAqfKD4Vy+9XvcBcc99CP8R0koTnf?=
 =?us-ascii?Q?A+/3oYAr1UxElO5RH2NqJkTcVQuuffTJJmd3sD4XbIh0/3yf3ScrtGk9rSBj?=
 =?us-ascii?Q?5QwrrkOUgMpcCk2Y18I2B1cwV65pKnGOyfh6EelGUm6jrS7CjdaYDLZl2goy?=
 =?us-ascii?Q?WEcDhUveg8VBaq322VKsh6clRdaWMK1fzFFfyQagEZV9KC/SF9RBnK19siKQ?=
 =?us-ascii?Q?Nkv5cBXDzf4nUd8/NXPy2PEm4Ep3kDizcmWcgy0M79tsG3NWzg5sMYRjeIcl?=
 =?us-ascii?Q?im/rP/aB7oRRL4AOWDq4usn5By+wIzJnOcIfLdIcKYDxgkvHc7M0ip7bgpn+?=
 =?us-ascii?Q?npRMYUI9lMExn605LsrgMnukHj1+pRDhpXXb+UkMZ3GIYinZZtJRdfJigohV?=
 =?us-ascii?Q?BENFFHonxAzMDejXrkz8zZFb9rF7egrwZNIWsgwuSt0+AJdalkzz4iIT4VLe?=
 =?us-ascii?Q?IV3Am8Wh2Xukt6KxM6DKthOHzG8E4wgFxTLYnazFYeTxo41pENNoaHviEJcL?=
 =?us-ascii?Q?LrvRM/D1kYGuPeNoJI7u2SWvUcz/X1NxagOssFa90cMOvJqLbK0aQ4Yi/pLo?=
 =?us-ascii?Q?67Yx/MxNW59XyO7sd226xf8bwgQ6A21cDdUIlVhaV6PCFYl5vxXI7BZJAV/v?=
 =?us-ascii?Q?d5vsRgHlHNh31IE6D/IcHJppmyoHXvq+uSIulpx8DvXuj+nz5Muh8z41TMi0?=
 =?us-ascii?Q?/7+bQJeFwDY/i3j9VU2TQ0QM+8q0tNRAWYhPX0J9Owc+IqDc31mKIurF8Nhi?=
 =?us-ascii?Q?SGGtq1VZZOXDqdZBqKtXz3wvezhIDiHuoaAjYvFz3MWAfCwb6gvo7yBI6vG7?=
 =?us-ascii?Q?MFtDfoHHfR94IxFwy9b+aKz2b64x5H8WE+QT1ZlU?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d03a420-9b9e-493d-d1a6-08dc86090ee9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 09:14:24.2181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KgRc5viPVQyhFJk7+cLbCo3a8FMNEDLOEfwTjDvhuGAr2dY7L0XPvYG7L83I5ZbOKOD3FYL/nCnV3maRgvBHog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6785

Hello,

I am working on allowing users to input the Broadcast Code
on BAP sink devices. I opened a GitHub discussion regarding this:

https://github.com/orgs/bluez/discussions/863

Regards,
Vlad
