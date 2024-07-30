Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013017.outbound.protection.outlook.com [52.101.67.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9E40BF2
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336677; cv=fail; b=hll5YBD5QxGY7Nm35p5Hb+DB/6wl/gi0IEWKpGKip46beqDL/2LBBa0KWODBmiacX1Uf5uSSkBOhCnZKdOcfyZPEosqbIg/Tap7zoB+4gf6gJ6bNbMwFbuzyFP35gGEPyXTBXmXFLiP/xwF8irOFAzDsRNA5Lyd6r95yH2zBH+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336677; c=relaxed/simple;
	bh=0K9Trs3QzA4WAdFNHZFtVMvhvTDk4Tvvo7GBtL5J/aY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c9daUz4mVsbeodFKaC5UUxUvku9TzE8JPu1PytfU/ky3mYmdjtbsOIh4ieLrRzC/T8yP5iwvSMfiRyqM9ZwHuawYTxx+T0DW2xIHqXJd0TG+L+IZTPNUJBPpBXttfRjqmGnoBg0AkAdHbtK4nlzepFrBSR52nCZdg7yI1LQzzFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BGJxFfHJ; arc=fail smtp.client-ip=52.101.67.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BGJxFfHJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICUg0d+y8by4pqgDrRDIzQui3Sis6XtcyM6neGQW8usw+up3GgQU5HGGWD8LuRZ6L7q0o4K23Hp7tFHXaVZdF3U38wz4HxjTFuMhrnZifQur8eOdVttX+E77rpIjNLH2+hrFAhpx9WQAQuh+KE3xWFJLOz8tYklptglqtOsyUcrmKqjxBTL8Sw5USMCtekIXcC51I3x3Vx1+DH5ak/c3frnGmtetpxoFtdlEKoYfjUXAZd/NV1WxZhM5dOU9dkhZoxRkPRysPVb7SlCHtiACqmrsY2JCEard3OCbJ86P8NNQ+4A1ZL3IagintnhLIH2I7hhGYHwOMZ5TAYSplf4diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0K9Trs3QzA4WAdFNHZFtVMvhvTDk4Tvvo7GBtL5J/aY=;
 b=Cc6BV7z44O0rvjX+qv78A8JCuyCwZiFalG1ZlDN4SpecliIZ0BTlKrwYPzfmklY/Enyt8rFrlXPgIgvABOU1hlLgvNbmb267LUntjvCEKgB/++nh6UFajafusBY7fSHuZrJGlaVLRGRvJagUUdi2ed1bDc7z/homXyoAfySr12K2+3i5C6p5JTpe5XyCEwn/5fpMM7HcgxpzXoGND1g2BzFzxHmupR9iluFb5nxmaG55/4Jd6I4yi+USzZwpSS1LcKuT5R6ROOEGK2l48Mg3S/7jUKldKwNFTtf5Vp/HA/tT7nD/W9hmNfcChLZDp0Mc+P57LSDuen76mIQwaX8Q8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0K9Trs3QzA4WAdFNHZFtVMvhvTDk4Tvvo7GBtL5J/aY=;
 b=BGJxFfHJ20Kkqqh0Mas/43gkfVyYVbHmDVOP/uiIpZsvHBWeEtrIoQ7dT+Fj1jERr+yjMpzssSFmvt27lT14ZmiQJ3cVTKFEgKfObbFpUz1w3hHnRHOw9WL0qwNNp9M7zklcviHJDfjVtpehlWui0dSaT2piuWHENG06/fL4pDlCmHbX9TXk2J27VBjECKRgNTEl9nYJ3+whU8nc4FMtdjXpS/imSPa0JRmsPCCFy4+Y0AbSUFu9DjypmwGk9E3Ny4rYuw+MQfBb2zyfwzrL1PTJpOryWU5LqSCpcjJK+jsmwqPbkhCbTLfAKuNnUXZlEHRhyXM5p+NQlkEncpAUmw==
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS1PR04MB9656.eurprd04.prod.outlook.com (2603:10a6:20b:478::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 10:51:11 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:51:10 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: Pauli Virtanen <pav@iki.fi>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>, Iulia Tanasescu
	<iulia.tanasescu@nxp.com>, Andrei Istodorescu <andrei.istodorescu@nxp.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v2 1/5] doc/media: Add 'broadcasting'
 state and 'Select' method
Thread-Topic: [EXT] Re: [PATCH BlueZ v2 1/5] doc/media: Add 'broadcasting'
 state and 'Select' method
Thread-Index: AQHa3ooaweFFPYGcYEqRMpKD8eUyMLIHp0mAgAd4O0A=
Date: Tue, 30 Jul 2024 10:51:10 +0000
Message-ID:
 <GV1PR04MB9088D98F513661F734277EF4FEB02@GV1PR04MB9088.eurprd04.prod.outlook.com>
References: <20240725115854.234781-1-vlad.pruteanu@nxp.com>
	 <20240725115854.234781-2-vlad.pruteanu@nxp.com>
 <de813bd5a9a3b966a109b26cac9003bad7d5e198.camel@iki.fi>
In-Reply-To: <de813bd5a9a3b966a109b26cac9003bad7d5e198.camel@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB9088:EE_|AS1PR04MB9656:EE_
x-ms-office365-filtering-correlation-id: 17d52eb1-a42b-49ec-f225-08dcb0858623
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2JydkswelpMYi9MVmgxaFl5c3EvMUZRSERwR1BTeXp2Z1pUUXdiY25mQnJ6?=
 =?utf-8?B?NE5LOGVtRnZUOFlBTis5V2xDaTZiQVNtcHhqVE14VHBxSURoc0NlQmtxNkxJ?=
 =?utf-8?B?d1EzMVZrMU9BSVJFb3RoZ3NpbDVsdnJyV2xKUGFQd3BBUkhnSk9GTm1USXhK?=
 =?utf-8?B?SGtCcTFaSWppcUJrODJLV1plcTU5S3MwMi9MVjJ1T3NYRmVRcGp4VWZiWFNj?=
 =?utf-8?B?d1dUMjdVWFZxZnQ3ODk2UitkVGRYOXNqWHFjVDk4Ylg5WGFaMFNycGk5Tngv?=
 =?utf-8?B?eW1TcEc5WVZIbzNDRloxNGNhZGoxR3FGK05Mc01HUzVxVmFSeWUxbXAzQ29L?=
 =?utf-8?B?SGNsU1g0OU9QZHE5TXM1MU5DdU8vcWU3dTBtUXg4TUFXZDdXVUNscWIwQmpN?=
 =?utf-8?B?N3lodHErT2k4WHJnT2wvaGIzemlkS0NWaWlPU3ptYkRGbFo5Z0I5Z0dUYlVX?=
 =?utf-8?B?TlJENHlLRGJZU09qR3o2d2JVc2J3Z28zNmxrWnQySnd3RmtvMzRkYzBHbHpK?=
 =?utf-8?B?VDFWVzFTVXNlbTVHQmo0dm5rZ2grQzRwUDZNNFNOUFRWd1RxK1ovZEhzWEMv?=
 =?utf-8?B?SXNlbzYvUFhpMnZzMFhtWEVjTjRtTmVKdTBCWG9lN3plemxxdmJVYnJrSkE3?=
 =?utf-8?B?YkdqdThmY24rdDQ2MGliZVFBY3RaQkJLUGt2SUVPR2srNGNlcUJUTWQ4VFJr?=
 =?utf-8?B?cFVHZVptM0FKaTBhRUhiMlJMMVR3MWkwdnlHajVONU41R00vOWlKN3hzL1NB?=
 =?utf-8?B?d3JIZ0orVk9oZTBYQUxFS3FtcGtZa3hiTHNUQWhyNDkxMitiZzNSVEo4OU5I?=
 =?utf-8?B?cklDWHJWMlpSSk1IdUpQMTZrbGRQMmJJOFZUWm5tRVRBNE9PbmtaeS9XZjA0?=
 =?utf-8?B?TDkrbTdNamUxdTh0Z1hmR3V6RXpJTnYzRm1uUURwQ1p3K1piUkw0aWFnczZI?=
 =?utf-8?B?c2NIZWhGR2VMYk1YcHNndW41VnZ3WllSaFA4RUNDZmE3enQ3dmFBVllmMWdQ?=
 =?utf-8?B?bHJSZDcxSFBtbDM1WERTNGxYMUNuWlFLczEwdGRiTEtFY0ZIdDBWZXBlZ0FB?=
 =?utf-8?B?bmpFcDFhQnRlU3dyc2l5QkVJV1NhNTV6MGsvVi9OZSt2M2FKQTRObnQvUDA0?=
 =?utf-8?B?M1N1Snd1RURBczI2QWxJQTcreS9nWmU3YlVSMDIwZVZ1RVRwUkhNR1FWdDZz?=
 =?utf-8?B?bEg2Tnd4VnNjcWJTZThHaU8zZElLbVJKbzlEK3RCSDJxMUFXNVJsZVlXUWwr?=
 =?utf-8?B?YnNBZ0FYU09qTUtxQU8wNjV1ZCs1UmZpelhUMGpodGZvQVBqNHBWdkl0dFpx?=
 =?utf-8?B?TUdqdExPelpCWFBPT0RocW1vbXZuZ3ZndTU4U21NYmE0MkFXSWRFMENKMzNH?=
 =?utf-8?B?SnY5SDg2VzN6WCtMbGxMSEtyaXorYXhCTUJMckcwTEFxMTdVWTJtUnF0UDQy?=
 =?utf-8?B?TmV6d0JmR3pHOTM2bjhjOGRrZU9qZDZ4TDJlVjJLVHpzS2gvNHV4RE5NUFc1?=
 =?utf-8?B?TWZNdmlybWVNU2Jva1JTWSs5enQ0YTR3ZjlJdHAvKzVzZnBkYlNvbHdhQ05X?=
 =?utf-8?B?c0xUNFBTMzhicVh6eU9NN3g5SHVZVkJNMFl0ejhVMytTbEd6MGRQS1VsRWpN?=
 =?utf-8?B?aUd4ZWsrSXhYdURKd05mTS94YU1XeVBZbUFiVGZ6ZjVtWStlcWVWMG0wejRT?=
 =?utf-8?B?am9XcFA3Q0dLb3dZVW1kVkxZWS8vclpoYTJvQ0MzT1FRV0tGVnJJQzByc1pr?=
 =?utf-8?B?d0laMEtIREJDbC85Rm9lRzc3alNWdGE4Nzh1OG1mZ0U5T2NxdTZDL3BRSC85?=
 =?utf-8?B?MHZQVDFzQVVKaDNXeERZTy8wdnljQ1BZdEh2UVZlUjlzcHdRcGpxV2UwNnJ1?=
 =?utf-8?B?cWFZZEpkOEFId3BlQVRoMVMxaFVpUGM1RHVCdTZKRThrQnc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGFDbWRPOUpCMW02OFhPbmZsb0l1ZnJBSW9QMVFMNlY1YWV6d0tFaXBzeXVD?=
 =?utf-8?B?dWxibHRTTUxoaXI2ck4zd2J1Zy9xYVhURlZLaUFHcG1VU2xqWjFyYUNuTU1S?=
 =?utf-8?B?OWNZcmpUUUcxOWIwVU96dnlhWEh1WGk3NmVzTWxwNm5wbUI1TGlWV1VBQytX?=
 =?utf-8?B?WWxMNGdBMDRDbWV3UkNrOGo0dWFncTBlVzBRM3Vha0NpZ3ZRUCs1TTkwcHB5?=
 =?utf-8?B?RDVmVlE4c2ZOdm5PQUhmdHgxTEloSTluMjl3R2Q1STVnRHpjbWQ4NlgrR3B6?=
 =?utf-8?B?dlpxU2J1SGRnOENOaXlJVFBjT2dSY2FuME1uZUUrZysxQlFYUkkrS1g3VlZN?=
 =?utf-8?B?SGgwdFZwTEpnRi92cWdIUFJJZEtoemVTR1J6eHRudjZVdE5ISHVEbnJhYk9O?=
 =?utf-8?B?RTV6SE8vYlZ0ekdlaWhqc0RJOUVRKzdSeU8yQ0VkRDhYdVZZakVaUUhiWmdB?=
 =?utf-8?B?akxTZ0FHTnNGVUI2TW1mc2NCcEpMNlRaQmtYSWF5QW0wVjY4WDhQK3NMRlY5?=
 =?utf-8?B?WWxiN2l4R01EV1ZMVWNneFFKV0tJWFJQTmN3YnJjV0Z5OXhFUDdKdDRiUkla?=
 =?utf-8?B?R24rNThWWHZ6SU1sRWlEVzV1YnpaSmkwMTBJUG04dzFwaXI3c1dYVm5YV1g5?=
 =?utf-8?B?UjhSYktwMTdVMkRBdXdNcmJOc21rWkdwT2NId2FtRzJmWUFJUDNVeEQwdkZ0?=
 =?utf-8?B?TVJVSERwOU5TcXY5VGJaaEhta1EvaFJFTkNrYm5BVllmRVNKcDA5ekVBd3RH?=
 =?utf-8?B?dGxuTzJnMERJVGVvYmQ4V3I2WXMxWm41MXR6SnJTbGZ5dUh3dEFkNW1ITEJz?=
 =?utf-8?B?enhuRmkvdnZsTlFFTXl4UEowcTd4cCt4SU1iZzI1blRoZkM0cG5NK1VaU2pH?=
 =?utf-8?B?SWpJOG5rbWxsR2dwY3VPeS91bVFkVzBTRmJkeFNycUs1NGVCNjNTKzFzN01W?=
 =?utf-8?B?cnlsQnhIZ3NjQVdubUNicUtYUGZRT0o3UEc4SDk4ZUpCazFIb2YzdWFCNWJT?=
 =?utf-8?B?RU5acjZuUkJjT2xzVi84eUhhMlpYOERQWk5YTWp4Qkx3WjhTazAyRnk3eEFP?=
 =?utf-8?B?NTVGOGxlRnpiUWhzZGkvUlBpalFXWnpHNFpMOVhFdVlGNElmZnFhOUJyZzYz?=
 =?utf-8?B?MXhKRHBPSkhJRzVDYVQ4WnBLbEVOZGpTQUQ3bUpxQ0tSRlNYV0FYOVZRUHI4?=
 =?utf-8?B?aEZFbmVyN2VXNmhHc1E2dVFrMzMwcm15SjF2aHpBbWx4NWJObEdvb2VmS2Vx?=
 =?utf-8?B?ZjF5TTU0emovenFmdUdKK1Job3BmNVBYZ0ZOTE5EZU54eVJHQUV0VW5PTnFN?=
 =?utf-8?B?VUFaVFg3MGlXaklxYzZhRG1BWlVXTCtrWFBhSGFmU3prQWFqRStMS1dJTjg4?=
 =?utf-8?B?Zk1ZcjJzemIxQVMzLytidWpzbHBhNWR1d0JJUTFWRmR5QTlHT3JuSG9lSEx4?=
 =?utf-8?B?SGJSTUhJeFBMd2piSUFnYWRLZG5QTlNwM2U4YXdmUU14dTljWGpyVnIrOGZD?=
 =?utf-8?B?bVZGdm9kTW9qb2Q0QzJPSk85ZVRQcVFvQk11U2tOd09KaDdxTElEU2oxUVN1?=
 =?utf-8?B?bmttRDRpRjJrb25raE1vejNPUWkwdGZ5VDZkQWdEV0dHaHg1Q2xnMSs2cE5l?=
 =?utf-8?B?VElLUWxrUjFuM3hvZnNITTlGRHl6YU9IRnMrTGU3TE1hL04ycXJFYTk3bUI3?=
 =?utf-8?B?ek1Mc0N5dWZMUjNwek5oVzF3L2oycmFCTndySWJ4Z3VmTWRrZ0hIZi96clc1?=
 =?utf-8?B?T04wRnlWZFpDRzVHWGlJN1dOS045KzEyc1cxekZvYXVyVk5JOXhFcE5IcGcy?=
 =?utf-8?B?YVlNSWY1cndqSG0zb1U1ZFo1T2oxSHZlem15bzZZUkZjMWlsbjlQSGNzcWlC?=
 =?utf-8?B?emN6UEdmOHFTanptM2wrTnNkMEorZDNHTjBNS3dJdlh3dFVCMDdONFVDV3BI?=
 =?utf-8?B?cGVQeUJEY1NJQmttK2FuRGw4RXhOWVp6cGhTeTY5cklTaWMzYXZjamtmTmJn?=
 =?utf-8?B?ZTlYSnZmUUVoTXV0eUF6dnRIQk1BbXE3RnNkdDZidjI4VjBIbWhTUjM0YmpQ?=
 =?utf-8?B?aWJGQW1rM3NMQVFRMTlxZE9neDliY0pXTy9zTkNSWlNTZnZheThVdXl6Z0Ur?=
 =?utf-8?Q?0fdDVJlA6xJuriG573V4RtRUO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d52eb1-a42b-49ec-f225-08dcb0858623
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 10:51:10.6763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CmQelWfxrsIzBG+bmb8buqwicCxRjJIoNKtIKfVV4o/SqLt5KqKpagRDSVSwRsMZLek8HvuzyE4ty0TXdwRSNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9656

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bGkgVmly
dGFuZW4gPHBhdkBpa2kuZmk+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI1LCAyMDI0IDc6NDYg
UE0NCj4gVG86IFZsYWQgUHJ1dGVhbnUgPHZsYWQucHJ1dGVhbnVAbnhwLmNvbT47IGxpbnV4LQ0K
PiBibHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNaWhhaS1PY3RhdmlhbiBVcnppY2Eg
PG1paGFpLW9jdGF2aWFuLnVyemljYUBueHAuY29tPjsgSXVsaWEgVGFuYXNlc2N1DQo+IDxpdWxp
YS50YW5hc2VzY3VAbnhwLmNvbT47IEFuZHJlaSBJc3RvZG9yZXNjdQ0KPiA8YW5kcmVpLmlzdG9k
b3Jlc2N1QG54cC5jb20+OyBsdWl6LmRlbnR6QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBbRVhUXSBS
ZTogW1BBVENIIEJsdWVaIHYyIDEvNV0gZG9jL21lZGlhOiBBZGQgJ2Jyb2FkY2FzdGluZycgc3Rh
dGUNCj4gYW5kICdTZWxlY3QnIG1ldGhvZA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRl
cm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9w
ZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2lu
ZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBIaSwNCj4gDQo+
IHRvLCAyMDI0LTA3LTI1IGtlbGxvIDE0OjU4ICswMzAwLCBWbGFkIFBydXRlYW51IGtpcmpvaXR0
aToNCj4gPiBUaGlzIGFkZHMgYSBuZXcgc3RhdGUgZm9yIHRyYW5zcG9ydHMgY3JlYXRlZCBieSB0
aGUgQnJvYWRjYXN0DQo+ID4gU2luay4gU3VjaCB0cmFuc3BvcnRzIHdpbGwgcmVtYWluICBpbiB0
aGUgJ2lkbGUnIHN0YXRlIHVudGlsIHRoZQ0KPiA+IHVzZXIgY2FsbHMgJ1NlbGVjdCcgb24gdGhl
bSwgYXQgd2hpY2ggcG9pbnQgdGhleSB3aWxsIGJlIG1vdmVkIHRvDQo+ID4gJ2Jyb2FkY2FzdGlu
ZycuIFRoaXMgYWxsb3dzIHRoZSB1c2VyIHRvIHNlbGVjdCB0aGUgZGVzaXJlZCBCSVMgYXMNCj4g
PiB0aGUgYXVkaW8gc2VydmVyIGF1dG9tYXRpY2FsbHkgYWNxdWlyZXMgdHJhbnNwb3J0cyB0aGF0
IGFyZSBpbiB0aGlzDQo+ID4gc3RhdGUuDQo+ID4gLS0tDQo+ID4gIGRvYy9vcmcuYmx1ZXouTWVk
aWFUcmFuc3BvcnQucnN0IHwgMTYgKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RvYy9vcmcuYmx1ZXouTWVkaWFUcmFuc3BvcnQucnN0DQo+IGIvZG9jL29yZy5ibHVlei5NZWRp
YVRyYW5zcG9ydC5yc3QNCj4gPiBpbmRleCA2ZTk1ZGY4ZjIuLjQ3MzQ2ZDM2YiAxMDA2NDQNCj4g
PiAtLS0gYS9kb2Mvb3JnLmJsdWV6Lk1lZGlhVHJhbnNwb3J0LnJzdA0KPiA+ICsrKyBiL2RvYy9v
cmcuYmx1ZXouTWVkaWFUcmFuc3BvcnQucnN0DQo+ID4gQEAgLTcsNyArNyw3IEBAIEJsdWVaIEQt
QnVzIE1lZGlhVHJhbnNwb3J0IEFQSSBkb2N1bWVudGF0aW9uDQo+ID4gIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4NCj4gPiAgOlZlcnNpb246IEJsdWVa
DQo+ID4gLTpEYXRlOiBTZXB0ZW1iZXIgMjAyMw0KPiA+ICs6RGF0ZTogSnVseSAyMDI0DQo+ID4g
IDpNYW51YWwgc2VjdGlvbjogNQ0KPiA+ICA6TWFudWFsIGdyb3VwOiBMaW51eCBTeXN0ZW0gQWRt
aW5pc3RyYXRpb24NCj4gPg0KPiA+IEBAIC01MSw2ICs1MSwxOCBAQCB2b2lkIFJlbGVhc2UoKQ0K
PiA+DQo+ID4gICAgICAgUmVsZWFzZXMgZmlsZSBkZXNjcmlwdG9yLg0KPiA+DQo+ID4gK3ZvaWQg
U2VsZWN0KCkNCj4gPiArYGBgYGBgYGBgYGBgYGANCj4gPiArDQo+ID4gKyAgICAgQXBwbGljYWJs
ZSBvbmx5IGZvciB0cmFuc3BvcnRzIGNyZWF0ZWQgYnkgYSBicm9hZGNhc3Qgc2luay4gVGhpcyBt
b3Zlcw0KPiA+ICsgICAgIHRoZSB0cmFuc3BvcnQgZnJvbSAnaWRsZScgdG8gJ2Jyb2FkY2FzdGlu
ZycuIFNpbmNlIHRoZSBhdWRpbyBzZXJ2ZXINCj4gPiArICAgICBhdXRvbWF0aWNhbGx5IGFjcXVp
cmVzIHRyYW5zcG9ydHMgdGhhdCBhcmUgaW4gdGhpcyBzdGF0ZSwgdGhlIHVzZXIgY2FuDQo+ID4g
KyAgICAgdGh1cyBzZWxlY3Qgd2hpY2ggQklTZXMgaGUgd2lzaGVzIHRvIHN5bmMgdG8uDQo+ID4g
Kw0KPiA+ICsgICAgIFBvc3NpYmxlIEVycm9yczoNCj4gPiArDQo+ID4gKyAgICAgOm9yZy5ibHVl
ei5FcnJvci5Ob3RBdXRob3JpemVkOg0KPiANCj4gU2hvdWxkIHRoZXJlIGFsc28gYmUgVW5zZWxl
Y3QoKSB0aGF0IGZvcmNlcyB0aGUgdHJhbnNwb3J0IGJhY2sgdG8NCj4gImlkbGUiPw0KPiANClll
cyB3ZSBhbHNvIG5lZWQgdGhpcyBjb21tYW5kLiBJIHdpbGwgc2VuZCBhbiB1cGRhdGVkIHBhdGNo
IHRvIGFsc28NCmluY2x1ZGUgdGhpcyBtZXRob2QuDQoNCj4gSUlSQywgQmx1ZVogYXMgQTJEUCBT
aW5rL0FDUCBiZWhhdmVzIGxpa2UgdGhhdCAtLS0gd2hlbiByZW1vdGUgSU5UDQo+IHN0b3BzIGF1
ZGlvIHN0cmVhbSB0aGUgdHJhbnNwb3J0IGdvZXMgYmFjayB0byAiaWRsZSIuIFNvIGl0IHdvdWxk
IGJlDQo+IHNpbWlsYXIsIHdpdGggdGhlIGRpZmZlcmVuY2UgdGhhdCBhIGxvY2FsIGFwcGxpY2F0
aW9uIC0tLSBpbnN0ZWFkIG9mDQo+IHRoZSByZW1vdGUgc2lkZSAtLS0gaXMgY29udHJvbGxpbmcg
d2hldGhlciB0aGUgc3RyZWFtIGlzICJwbGF5aW5nIi4NCj4gDQo+IEkgZ3Vlc3MgdGhlIGRlc2ln
biBxdWVzdGlvbiBoZXJlIGlzIHdoZXRoZXIgbG9jYWwgYXBwcyBzaGFsbCB0byB0YWxrIHRvDQo+
IEJsdWVaIG9yIHRoZSBzb3VuZCBzZXJ2ZXIgdG8gZW5hYmxlIHNwZWNpZmljIGF1ZGlvIHN0cmVh
bXMuDQo+IA0KSSB0aGluayB0aGF0IGF0IGxlYXN0IGZvciBkaXNjb3ZlcmluZyBCcm9hZGNhc3Qg
U291cmNlcyBsb2NhbCBhcHBzDQpzaG91bGQgdGFsayB0byBCbHVlWiwgc2luY2UsIGFmdGVyIGFs
bCwgaXQncyBhIG1hdHRlciBvZiBzY2FubmluZyBmb3INCmEgQmx1ZXRvb3RoIGRldmljZSB0aGF0
IGlzIGFkdmVydGlzaW5nIGFuZCBhY3RpbmcgYWNjb3JkaW5nIHRvIHRoZQ0KcHJvZmlsZSBzcGVj
aWZpY2F0aW9uLiBUbyBtZSwgdGhlIHByb2Nlc3MgaXMgc2ltaWxhciB0byBBMkRQLCB3aXRob3V0
DQp0aGUgYWN0dWFsIGNvbm5lY3Rpb24gcHJvY2VzcywgYW5kIHNpbmNlIGZvciBBMkRQIHRoZSBs
b2NhbCBhcHBzIGZpcnN0DQp0YWxrIHRvIEJsdWVaLCBJIGJlbGlldmUgdGhhdCB0aGlzIHNob3Vs
ZCBiZSB0aGUgY2FzZSBoZXJlIGFzIHdlbGwuICANCg0KPiBIYXZpbmcgdGhlICJlbmFibGUiIGZs
YWcgZWl0aGVyIGluIEJsdWVaIG9yIG9uIGF1ZGlvIHNlcnZlciBzaWRlIGlzDQo+IHBvc3NpYmxl
LCBlc3AuIGlmIGl0IGlzIHF1ZXN0aW9uIG9mIHRyYW5zcG9ydCBhY3F1aXJlLg0KPiANCj4gQXMg
YXVkaW8gc2VydmVyLCB3ZSBjb3VsZCBlLmcuIGV4cG9zZSBpdCBhcyB0aGUgZGV2aWNlICJvbi9v
ZmYiIHByb2ZpbGUNCj4gc3RhdGUsIHdoaWNoIHVzZXIgY2FuIHR1cm4gb24vb2ZmIGUuZy4gaW4g
cGF2dWNvbnRyb2wuDQo+IA0KPiAqKioNCj4gDQo+IE5vdGUgdGhhdCB0aGUgY3VycmVudCBQaXBl
d2lyZSBCQVAgQnJvYWRjYXN0IGJlaGF2aW9yIEkgdGhpbmsgaXMgd29yaw0KPiBpbiBwcm9ncmVz
cy4gQWNxdWlyaW5nIHRoZSB0cmFuc3BvcnQgb24gUEVORElORyBJIHRoaW5rIGlzIG1heWJlDQo+
IGFjY2lkZW50YWwgLS0tIGl0IGlzIHVzaW5nIHRoZSBCQVAgVW5pY2FzdCBTZXJ2ZXIgY29kZSBw
YXRoLCBhbmQgaW4gb25lDQo+IG9mIHRoZSBiY2FzdCBzaW5rIHBhdGNoZXMgZnJvbSBOWFAgSSBz
ZWUgdGhlcmUgc2VlbXMgdG8gYmUgaW50ZW50IHRvDQo+IHVzZSBCQVAgVW5pY2FzdCBDbGllbnQg
bGlrZSBiZWhhdmlvciwgYnV0IHByb2JhYmx5IGl0J3Mgbm90IHF1aXRlIHJpZ2h0DQo+IGlmIHlv
dSBzZWUgdGhlIGFjcXVpcmUtb24tcGVuZGluZyBiZWhhdmlvci4NCj4gDQo+IChBcyAic2VydmVy
IiBQaXBld2lyZSB3aWxsIGV4cG9zZSBhdWRpbyBzdHJlYW1zIHNpbWlsYXJseSBhcw0KPiBhcHBs
aWNhdGlvbiBhdWRpbyBzdHJlYW1zLCBhbmQgYnkgZGVmYXVsdCBkaXJlY3QgdGhlbSB0byBhdmFp
bGFibGUNCj4gYXVkaW8gc3BlYWtlcnMuIEFzICJjbGllbnQiIFBpcGV3aXJlIGV4cG9zZXMgdGhl
IGF1ZGlvIHN0cmVhbXMgYXMNCj4gdmlydHVhbCBtaWNyb3Bob25lIGRldmljZXMsIHdoaWNoIHRo
ZSB1c2VyIGNhbiBtYW51YWxseSByZWNvcmQgZnJvbSBvcg0KPiBsaW5rIHRvIHNwZWFrZXJzLikN
Cj4gDQo+ID4gKw0KPiA+ICBQcm9wZXJ0aWVzDQo+ID4gIC0tLS0tLS0tLS0NCj4gPg0KPiA+IEBA
IC04NCw2ICs5Niw4IEBAIHN0cmluZyBTdGF0ZSBbcmVhZG9ubHldDQo+ID4NCj4gPiAgICAgICA6
ImlkbGUiOiBub3Qgc3RyZWFtaW5nDQo+ID4gICAgICAgOiJwZW5kaW5nIjogc3RyZWFtaW5nIGJ1
dCBub3QgYWNxdWlyZWQNCj4gPiArICAgICA6ImJyb2FkY2FzdGluZyI6IHN0cmVhbWluZyBidXQg
bm90IGFjcXVpcmVkLCBhcHBsaWNhYmxlIG9ubHkgZm9yDQo+IHRyYW5zcG9ydHMNCj4gPiArICAg
ICAgICAgICAgIGNyZWF0ZWQgYnkgYSBicm9hZGNhc3Qgc2luaw0KPiA+ICAgICAgIDoiYWN0aXZl
Ijogc3RyZWFtaW5nIGFuZCBhY3F1aXJlZA0KPiA+DQo+ID4gIHVpbnQxNiBEZWxheSBbcmVhZHdy
aXRlLCBvcHRpb25hbF0NCj4gDQo+IC0tDQo+IFBhdWxpIFZpcnRhbmVuDQoNCg0KUmVnYXJkcywN
ClZsYWQNCg==
