Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62B13B298;
	Tue,  7 Jan 2025 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218040; cv=fail; b=GKbJHor/61XMq001qrl9AdiS+Gfy8ozi/Es0FYXCxBBlsFTl4c6YhNJucIWeZgK6EcfpNjQ9D2k/3kTU+K+XwAs3rTSB43dWbv/M53AwUqLQ1uAy0Xl1xBze0ALvlDDzfLtsqHHcZJqOgH4zJs702ptw1Ehvker1Em19iEt5eB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218040; c=relaxed/simple;
	bh=Vs027XHkiugV+ce7ErZP4Bw6yI4feZSyPLDf2o4/X/o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OpnlLQ0OKqT+f1JCfMo4T0BieVSN9tq3i3Ekx27cyCyY1DqrRAt1neTDAJF1Ms28cAxvhaV9KqgNDwIzcb0Hi/MrC1IbCq40ayE6beIrvH848VhqP1lyDY9VhlngxzHofIVxCLIEp8vsUktKI9R/sv0sfY38YjtXSriDU1DwK/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dAkAbtzq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=RpJnupXs; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dAkAbtzq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RpJnupXs"
X-UUID: b2776b42cca111efbd192953cf12861f-20250107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Vs027XHkiugV+ce7ErZP4Bw6yI4feZSyPLDf2o4/X/o=;
	b=dAkAbtzqKCx8MMs4F8VHu0lUoWNod0vjBOHy75oAELFY/LRKZ5H7pS8fBU+im4XptC4+oP7//yaYBBdaJxt3pvDeOLukyK+sVsm8UzubR0f0aiRs8Y8Nrp2kdCWY99JESebqBVVQ3tidI6XVfvFVHsnWsX/59pVF9sVxX2a0+/s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:fac18370-cd01-47ea-ae3c-82e7d05e1f4d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:4a707a0e-078a-483b-8929-714244d25c49,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: b2776b42cca111efbd192953cf12861f-20250107
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1719285600; Tue, 07 Jan 2025 10:47:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Jan 2025 10:47:11 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Jan 2025 10:47:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTOidBDkDIlhxDd13Q2gl//tOmY+8ykx4wbfDcaoeVTS8rs+JYqtDnTGgt5V5VFS8fkBBecqVyQwAVAu5A6p3yQubvgF4Vd4lI0fvRORkDqtt6gBkVCDqifCSnGBadz3PwZZaTnCcphlobR2GiFDY7gdQAa0OruLv8Z0hpFN+CdntyVgF6/bD2/q+WNy5AONyH0bg5g/tBdi93gDVgyR9/5sbsTz1DdaShSGY+XwbX+4WIvIYbrwzPeuXYT2591C7kHS9wrz47isSoCF3jkKJnCNmAVmPK6N89qpfGBvRtA4jEDmwwk5Cm25/IzJbWfuDD+7/egAXopiPbXkjwB5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs027XHkiugV+ce7ErZP4Bw6yI4feZSyPLDf2o4/X/o=;
 b=DP10ourfwCXCppnNOsnveopae2tUiE8plYHc2HraHr6r5v5WFFrJWflTWOiYeFW7L89tI1hZwPnBhH69W6X37LwYfcCZOOlkUaMievWfmMP95RCvMPv3uIgi3PH4yKVK5lrGjINYQHovqPuXGD+3WLqV61VIeXUYDPndlvx/MTNJw2TsvUSQfk9HokhqHXcIod+SOhrWlVZOomhA1RfbdYMBGm2n8oaCznPtfAPTjn03Xq2yKZJs39CW83ezy++9FUrL1pxORJfMJD8z+rcA07a+upgPAmj3CVmDN6cc8aVf9a2m8R0HRiLOtiOyz//D7YlFKAwpOQ+MtSoqWg4d7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs027XHkiugV+ce7ErZP4Bw6yI4feZSyPLDf2o4/X/o=;
 b=RpJnupXs709Vyh44E+kKjr0atyllFzrP2Mv6aScsKUyBh1gEYXcQdDe9esJw3om5UYA3RDfYk3O4OUu0MQ3TXpW39zDx+BVIau7aoUn39g507PDJE+OjQwVBnllFi1qIh+hKcmlpYWj/kyy37nNA3JV+6poaizebueO37ZCzI9Y=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEYPR03MB7166.apcprd03.prod.outlook.com (2603:1096:101:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 02:47:07 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 02:47:07 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: =?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, Sean Wang
	<Sean.Wang@mediatek.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1] Bluetooth: btmtk: Fix failed to send func ctrl for
 MediaTek devices.
Thread-Topic: [PATCH v1] Bluetooth: btmtk: Fix failed to send func ctrl for
 MediaTek devices.
Thread-Index: AQHbVRjT+WZ45Win1UuQUnbsiM7aXbMKTT4AgABlcAA=
Date: Tue, 7 Jan 2025 02:47:07 +0000
Message-ID: <d286e31689c8a38b5ee864ee84e4c18eeb36238b.camel@mediatek.com>
References: <20241223085818.722707-1-chris.lu@mediatek.com>
	 <CABBYNZJOEi_=vLiivGFt7tKiq8TMn9YG=FkC20y-6M75Bi8vYg@mail.gmail.com>
In-Reply-To: <CABBYNZJOEi_=vLiivGFt7tKiq8TMn9YG=FkC20y-6M75Bi8vYg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEYPR03MB7166:EE_
x-ms-office365-filtering-correlation-id: 81e19229-a396-4cd1-6da7-08dd2ec5938e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K3VJVGVKUHpnUjU5T0xQc1kvLyt5T0c4aDdGZjhBZEZCTHBETWJ6MFM5YjdZ?=
 =?utf-8?B?RmpBN1JLdW9VMkJ2UVFnZmFNbnBZbjhWdDYxL0tzWjVVOXVnY0JuL3h6elll?=
 =?utf-8?B?UGxXOWl5akRWVVMxOWl1SlljeXlSNm10YkhnczdnYjUxdDkrcGFiL3MwNHR2?=
 =?utf-8?B?eEsyQWc1QURTS2ZkS2YzaEE3UTBLS3NqZDFWMWFYeGxtSGVtaFNGRTFkUnJX?=
 =?utf-8?B?MDE4dmM3QitjdnRMemoxRnBlY1ZoaHJEMU5Va0MxQzYySGZQSTFQZXdhTmdV?=
 =?utf-8?B?a0U0dkxVLy9JY1J1V3l5dHgrdUVuMW1meVJwR3c1S1VGNm1JYjZQSUUwRk5L?=
 =?utf-8?B?QkIvRFBNKy8vRjRPWTBZYXphNmF5MVA3OWwyTmVodmZwNnNoNFRLa3BNWDM1?=
 =?utf-8?B?YmNWVHZiSkp6ZTRvRmZ5WmJxeG1UaEorbFNKNURndFRuYWc5d09NbGMxMzJ2?=
 =?utf-8?B?SU9MdXIvalBmRkdYUkw3MVpuaENmVDg3YXhoaEEyczBLZzBUVWhqMWx6dkJs?=
 =?utf-8?B?R3hjVXJLbFo3SWR4dG9MNkFHMzJXR0IrejhYUG5BaDRvUE5UYTFjeUNpL3Rr?=
 =?utf-8?B?a0NEZ0pyUC9NeTlTVEI3U2pob2NiRmZoRDJYbVBobnZQc01JVEp6SU5kaGpK?=
 =?utf-8?B?N3d1WVpvZ1BZUER4Z3Bwbk5JV2RjeG5URTEwQkVGTDExcTk0MllicktpVXBr?=
 =?utf-8?B?dW1Vemxic3E2ZzBvZ1JRY3BnNHJ4L1FUNlF6YUE1YWxSUytlNmpINVRtZHZs?=
 =?utf-8?B?WVBsQllod3RwYzA5RlVWOHlpT3lBUXZGeXVvQ2dvYk15UUJiOGJiRHpFU0U1?=
 =?utf-8?B?aVF0YmpYNE1zd3FHdzlsc1RiTFdmVzg1ejBZbXJqUzZpZVBBUS9ZNTV2SCty?=
 =?utf-8?B?ZWZOajlEMmhCOEErS3BlMXhhWEtaaFZ5VjR6TnVqTWNPN0NITDNrSGdGTzJT?=
 =?utf-8?B?bDlaaVFqQnIrT3Y1L3pxQ0dlbjRXcm9IREc4cXQ2RWhiS3RsaXkwUWY1OWZJ?=
 =?utf-8?B?SThsaVBaSkJwVk9NYUU4cWdjazZzdktPbUlSRFNHbTZ3bW5RRHFaK1UxdGMr?=
 =?utf-8?B?NVF6M3JQSlFGUklFdFg2L2wxd3hIQytQbWRpeFNBT3N1VUNDbnRHbEtaUDVn?=
 =?utf-8?B?eElIZXBkQkNjMjVNNnFuSllXbHhDMTRCcFZ1WE5xWkN2SWJMMkpKSFV4Zm11?=
 =?utf-8?B?MXJ0dEtkTm10S0QwOXRtdVNwQ291YlZyRmIxVkNCaU5jY2dWY1FWMmgxTVRk?=
 =?utf-8?B?TE5PWXNxUGFOVDRQRlVwMWhTd2FoKzg4ZE1NMk55cjVXMXU0UjVZSDJ0djI5?=
 =?utf-8?B?RGhDT3lCWFpEVTJPY0JsbWJzZDgvekVNNjk5Tm95eXVUQlZsUjNtaUMzZFly?=
 =?utf-8?B?bXdEd1hTTS9sb082SVhuNStiWk5jZFo4SWNKMCtpVDFTMVlpR0xNR0RyQUVQ?=
 =?utf-8?B?RVpwY0tBVGFZeFk0QjE1NXorMnBnMHl1dHZ3WDZ2RTNyWStMSld3RUhBa1ZM?=
 =?utf-8?B?eS9JcWgyOEFJblhLb0NUUTQ2VnowQjM0cnhFUDBnZjVnUVdETGJpUkprRC9j?=
 =?utf-8?B?bWxVZHpOakpjbDRvUTVGbkw4eHZ1THcrUUptMjdMYWljQU1Fd0h0M1FBT0lT?=
 =?utf-8?B?M21pcENPMWRrcGw1ang5VmtXVVAvV2JUdklpRmFZYU9ISTdBWC9aSmZGNUdn?=
 =?utf-8?B?bmM0QlEyMklRbGc3NFNTc1RpYkVtZEkvRFBydlY0aSsydkp0aDc4bDVoYm96?=
 =?utf-8?B?Y2N5RmdtclF0aXA0QnpLdTJsZVNrLzVOMEhMSER6TjQzNW9Hd24zbDJIMVpy?=
 =?utf-8?B?NGJPZDFZRktmZlpBWHhKaE5YWUoyVEVzMmZyK1dYT3ZNN1NINXloenZEaVVW?=
 =?utf-8?B?cDhyMjJWa1k3emRPcUdobmdqUG9pb1d6OTBHV3AwemIxNGxaUW1pMkVabmky?=
 =?utf-8?Q?6+KA5kxg97fMkd10xNd9KxmWtcv8Y3pO?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3lnbE8wTEFXeWQ2Ukk0OXNNVndzSUdoRmRNRnVRTk1hSmVoeGo3UWkvTExG?=
 =?utf-8?B?N2hsKzJXZzBHUFNYQk9Oc3ZlQnIyUUZ3djQ5MGVqMGpKcXpSQk5tWE1MUzlB?=
 =?utf-8?B?YndyTUlRK1dQOUZGcm1RTjVzeGNnc2ZCOXdwMG9vZ2JJb21vMExNaTZUdlk3?=
 =?utf-8?B?U2lDZk41NFYraTZrUWFhUXVpRWgxNU5UUEpGRWFXR0NVdG1ZanlpRGxucTdQ?=
 =?utf-8?B?bTJ5d3J6SHdWZG5OVk9scVR2TGxSdXlZb1R4SFZ6ejY2ZWluSXVoc0o1RXFa?=
 =?utf-8?B?bFhmWjRyQjBudDMxdlNVeWowNERSdnZ2azQvNlkxUEIxeXAxNXc2VStYcmc4?=
 =?utf-8?B?VUdTWTZNNFh5Zll1NTNGWnUyNTVWRDNHWmVadlM1N1hRcHN2eWlDRnFNR0h2?=
 =?utf-8?B?ckR4TVFMMEJiR2FrbFNXR1VXYWc1czNZUXpGVUUyUFRxZkR2aC9iSHpQZFhy?=
 =?utf-8?B?UXVZUEl5RTVtanYySzFLQlE1WElXUnlTcmtPa1E5d1BiT2p5dTBmRjNmWitC?=
 =?utf-8?B?MUowQmxTYXJaUXUrQ21qYnFuL1ltWEg4UnBpTHdERUc1Z2hua0YzeFdHdkN3?=
 =?utf-8?B?S1NFeGg1NFZJcGRuWHJ0SzNWdktrZnZ0TmFUVXhUYkROTWN6NXc4VXE4K2dR?=
 =?utf-8?B?NE0reTE0cFhnNEtjeWtCSjM2ekwvOUJZY2hIeElON2FCVWIwNXhTOFJJZi9n?=
 =?utf-8?B?UWFGQXg3dmFMNmNvSFVHOGFBWjlYaHExanc2MEZZWTN5cWtKam9meDFTaXhG?=
 =?utf-8?B?anhzR3Vra2wrUVZNVE5hS0ZkQk9SbWRwejhYTW5iMVJ0WEhHQ1NnUE4yYUVV?=
 =?utf-8?B?UWkwODFZU3oxNFVlSEpiMjI3dElrc0dJVVhTVjZjZzhoSlZMcC9OdjBXb2RJ?=
 =?utf-8?B?cW4zUTA2OGk1YmRCdnR4OU5FRXRxWTJYbjBJSEJCWmlJWTV2TUNYc0MvZllU?=
 =?utf-8?B?UEg3WC96Y1l6YjNYSTJBWXY4dVdtYUpnNDRxQnFxalRqQmhIUGZlTWN6eGhY?=
 =?utf-8?B?T0EwS2Yvam9jVjlQRnBiZEZrRmdjS21WNWQ5dFZjakJyalZ5R25oazluQlJy?=
 =?utf-8?B?Rko2VzJOYjFxcHplSCtWeDBGZ2R2dkg1U1B1WkhzbGVYbzJtSHJQTVU4UnB5?=
 =?utf-8?B?TThYY0FZV2NjZjNpS1dJQUw3YUtxejNFU3JmdWZSUmZ6b0JDNTdCUFlhTzVT?=
 =?utf-8?B?NFY2OTdad2g5SUxEbzB0TkF3RlZvd0tTeVA1b2ZmaTZuZHFaOWFRcHI2YmRC?=
 =?utf-8?B?d1dISnI5bFh1a1lNMHBXS3dPRXlYSW5TSFZXMkJRZmZrSjJJZzNxcnhHOGZL?=
 =?utf-8?B?SG5TVnFQUnJ0Q1gzTlZqN0s3M0xCNFJtWHdMSEwxY1BHT2NtTUE1UTJhcEJ1?=
 =?utf-8?B?MHhnMjZvMXIxVjQzVXJaaHQ0eWY5SEFFeWNhUlJsNmZtQkR5VlcyeUVIbWJs?=
 =?utf-8?B?dWpVZXkrYzNXNG4xWWYyczlhN0J1c0lmbTdhNjZBWWQ1NVN6bEYrem1uOTZJ?=
 =?utf-8?B?WGJhMCtDTjJjMyszaFozeDFhUUQwS0EyQjRwWkZXRWxzUHdpSUNDb0NIREUx?=
 =?utf-8?B?U0FxQUV1U01sSWJHZVRRbElJM2xKT3pwbXVScDd4VmtRYkZGSDQ3L1VnWm9Q?=
 =?utf-8?B?bUNNN285YUVsOU94ZWlHbnBYSm0vbVI3YTdlVVBuWEZBSDlla0VKUXFiOVli?=
 =?utf-8?B?OUYrVHgyWGxkQVBlWUMydFcrUHZZUlRiZHNqbHVVZXRrMjlwSHJQV1Q0NHBK?=
 =?utf-8?B?QnB0M3M2MHdKRnVSV3dyZlU0ZUZtSmNkNHluSTBpKy9BY0lKdU9IdktvSy9t?=
 =?utf-8?B?dTRqSS9NOHBpb0NwNEQ4YUU2eVlVcE51eDNXMXNsSG0yeXltZzJqK0ZlZitm?=
 =?utf-8?B?akMrc0ZTVVhKMENkVStQRlhDcVRsY3dabVUxcDVnTjd6SUNVQUhRcUE0RUp5?=
 =?utf-8?B?SnlnRm02SUNLaVhnN3RaNitlVzNKN2pQMjZya3JubG5ibmpuS2wvOW5vTmxp?=
 =?utf-8?B?TXpMeG0xTUwwWTFheHQwd0UrMmFSaDc0bGNsTHBWSWJyTmpTWDNRdlZtbzJi?=
 =?utf-8?B?NmZ0b0RRd0l4UkwvQ0pSUXpzQUF2Yi9aRWZxblE2UUdUQ3NTV29jRy8wMTNn?=
 =?utf-8?B?QzIrU3hnTzg4T0dqYTZnVDdWZDE1dmZvM05ibFpnTEl5aTlDcm9LMks5cG1T?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3F0BC24C2C8CD40A4792197C5A9CC0A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e19229-a396-4cd1-6da7-08dd2ec5938e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 02:47:07.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7Ou1HMTZBD0glGGJgR7Y/+o3RkSAC8SJOESIwbAjAzxtpDYC8YApxfUN/el6HJekKt9g9RcdfTjMeLzn1ak8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7166

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KDQpPbiBNb24sIDIwMjUtMDEtMDYg
YXQgMTU6NDQgLTA1MDAsIEx1aXogQXVndXN0byB2b24gRGVudHogd3JvdGU6DQo+IA0KPiBFeHRl
cm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0K
PiANCj4gDQo+IEhpIENocmlzLA0KPiANCj4gT24gTW9uLCBEZWMgMjMsIDIwMjQgYXQgMzo1OOKA
r0FNIENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+
IFVzZSB1c2JfYXV0b3BtX2dldF9pbnRlcmZhY2UoKSBhbmQgdXNiX2F1dG9wbV9wdXRfaW50ZXJm
YWNlKCkNCj4gPiBpbiBidG10a191c2Jfc2h1dGRvd24oKSwgaXQgY291bGQgc2VuZCBmdW5jIGN0
cmwgYWZ0ZXIgZW5hYmxpbmcNCj4gPiBhdXRvc3VzcGVuZC4NCj4gPiANCj4gPiBCbHVldG9vdGg6
IGJ0dXNiX210a19oY2lfd210X3N5bmMoKSBoY2kwOiBFeGVjdXRpb24gb2Ygd210IGNvbW1hbmQN
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aW1lZCBvdXQNCj4gPiBCbHVldG9vdGg6IGJ0dXNi
X210a19zaHV0ZG93bigpIGhjaTA6IEZhaWxlZCB0byBzZW5kIHdtdCBmdW5jIGN0cmwNCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAoLTExMCkNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHJp
cyBMdSA8Y2hyaXMubHVAbWVkaWF0ZWsuY29tPg0KPiANCj4gTWlzc2luZyBGaXhlcyB0YWcsIEl2
ZSBiZWVuIGFkZGluZyBpdCBteXNlbGYgZm9yIHNvbWUgdGltZSBub3cgYnV0DQo+IHlvdQ0KPiBi
ZXR0ZXIgY3JlYXRlIHRoZSBwcmFjdGljZSB0byBpbmNsdWRlIGl0IHNvIEkgZG9uJ3QgaGF2ZSB0
byBnbyBmaW5kDQo+IHdoYXQgY29tbWl0IGludHJvZHVjZWQgYnRtdGtfdXNiX3NodXRkb3duIHRv
IHRoZW4gZG8gZ2l0IGxvZyAtMQ0KPiAtLXByZXR0eT1maXhlcyBhbmQgZ2l0IGNvbW1pdCAtLWFt
ZW5kLg0KPiANClRoaXMgY2hhbmdlIHdhcyBzdWJtaXR0ZWQgYnkgYW5vdGhlciBNZWRpYVRlayBt
ZW1iZXIgYXJvdW5kIHR3byB5ZWFycw0KYWdvIChidXQgaXQgd2FzIGlnbm9yZWQgYW5kIHdhc24n
dCBtZXJnZWQgYXQgdGhhdCB0aW1lKS4gV2UgcmVjZW50bHkNCmZvdW5kIGl0IHdhcyBtaXNzZWQg
d2hlbiByZXZpZXdpbmcgb3VyIGJ0dXNiIGNoYW5nZXMgYW5kIHRyeWluZyB0bw0Kc3VibWl0IGl0
IGFnYWluLg0KDQpBbnl3YXksIEknbGwgZG8gYW5vdGhlciBzdWJtaXQgdG8gYWRkIGZpeGVzIHRh
Zy4gVGhhbmsgeW91IGZvciB0aGUNCnJlbWluZGVyLg0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9i
bHVldG9vdGgvYnRtdGsuYyB8IDcgKysrKysrKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10
ay5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuYw0KPiA+IGluZGV4IDdmZDlkNWRkY2UwMi4u
MjI0ZWFmYzI3ZGJlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMN
Cj4gPiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jDQo+ID4gQEAgLTE0NzIsMTAgKzE0
NzIsMTUgQEAgRVhQT1JUX1NZTUJPTF9HUEwoYnRtdGtfdXNiX3NldHVwKTsNCj4gPiANCj4gPiDC
oGludCBidG10a191c2Jfc2h1dGRvd24oc3RydWN0IGhjaV9kZXYgKmhkZXYpDQo+ID4gwqB7DQo+
ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgYnRtdGtfZGF0YSAqZGF0YSA9IGhjaV9nZXRfcHJpdiho
ZGV2KTsNCj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnRtdGtfaGNpX3dtdF9wYXJhbXMgd210
X3BhcmFtczsNCj4gPiDCoMKgwqDCoMKgwqDCoCB1OCBwYXJhbSA9IDA7DQo+ID4gwqDCoMKgwqDC
oMKgwqAgaW50IGVycjsNCj4gPiANCj4gPiArwqDCoMKgwqDCoMKgIGVyciA9IHVzYl9hdXRvcG1f
Z2V0X2ludGVyZmFjZShkYXRhLT5pbnRmKTsNCj4gPiArwqDCoMKgwqDCoMKgIGlmIChlcnIgPCAw
KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7DQo+ID4gKw0K
PiA+IMKgwqDCoMKgwqDCoMKgIC8qIERpc2FibGUgdGhlIGRldmljZSAqLw0KPiA+IMKgwqDCoMKg
wqDCoMKgIHdtdF9wYXJhbXMub3AgPSBCVE1US19XTVRfRlVOQ19DVFJMOw0KPiA+IMKgwqDCoMKg
wqDCoMKgIHdtdF9wYXJhbXMuZmxhZyA9IDA7DQo+ID4gQEAgLTE0ODYsOSArMTQ5MSwxMSBAQCBp
bnQgYnRtdGtfdXNiX3NodXRkb3duKHN0cnVjdCBoY2lfZGV2ICpoZGV2KQ0KPiA+IMKgwqDCoMKg
wqDCoMKgIGVyciA9IGJ0bXRrX3VzYl9oY2lfd210X3N5bmMoaGRldiwgJndtdF9wYXJhbXMpOw0K
PiA+IMKgwqDCoMKgwqDCoMKgIGlmIChlcnIgPCAwKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJ0X2Rldl9lcnIoaGRldiwgIkZhaWxlZCB0byBzZW5kIHdtdCBmdW5jIGN0
cmwNCj4gPiAoJWQpIiwgZXJyKTsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
c2JfYXV0b3BtX3B1dF9pbnRlcmZhY2UoZGF0YS0+aW50Zik7DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7DQo+ID4gwqDCoMKgwqDCoMKgwqAgfQ0KPiA+IA0K
PiA+ICvCoMKgwqDCoMKgwqAgdXNiX2F1dG9wbV9wdXRfaW50ZXJmYWNlKGRhdGEtPmludGYpOw0K
PiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+IMKgfQ0KPiA+IMKgRVhQT1JUX1NZTUJP
TF9HUEwoYnRtdGtfdXNiX3NodXRkb3duKTsNCj4gPiAtLQ0KPiA+IDIuNDUuMg0KPiA+IA0KPiAN
Cj4gDQo+IC0tDQo+IEx1aXogQXVndXN0byB2b24gRGVudHoNCg0KVGhhbmtzLA0KQ2hyaXMgTHUN
Cg==
