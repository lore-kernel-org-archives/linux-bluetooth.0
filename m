Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F46A330
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P1xS8yX/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oqPAz0sP"
X-UUID: 286736e4b14511ee9e680517dc993faa-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qJo3UlOJ3ID/KMlv3/YZD3cbV229qN2lcz3umaK5dRk=;
	b=P1xS8yX/PhePDiPy++jSydzWHAnqFKhbP5/PTx9CGuBUfgGZEjJshbfkfokoETI5QG+LrLklZTTuab2lkmCjXeColsLH6FjDVjhhBPUL3rsj6p82yRSRaZaBc1+AKn5sO7dJHKpEcsue3SKfzCrYBEaGjXc2td4dRmRjQaAm9XY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:65050c65-d199-46a0-adba-972a896e68b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:cab8487f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 286736e4b14511ee9e680517dc993faa-20240112
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 588738879; Fri, 12 Jan 2024 20:21:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 20:21:47 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 20:21:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtUbFdlkSaMrNrNa+zNr0zZFdBqVkq+JVM9jgH3RpuNlx5lgT+UXu3eAeXlYeZ4WjEqaQo6aCVIWGrACWSikWj8ruy4dxEv2T9c2uDCIVIa8XXBFm/CoXtds6akL39waeFlAw/WAjuvfWAlYlCJU6rIx1v57TAUHuAydF9ndQTMU88yu+nXQRctF7HnaKPRC1ziU9WLz/cOVhx/1wD3IY0sI771hUfo6zcIYznn0Kz1Ad4J+1rWMPD7yPsVzv9wpf7QK9BhgZKc38Ukede/k0XcH7XD6gxCrwDz4AWJi5bcIfPy0N2ewEpreWBUIY2QkVlhD3rvr9sAzRCDhZ4ha2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJo3UlOJ3ID/KMlv3/YZD3cbV229qN2lcz3umaK5dRk=;
 b=VfYQC4YjMug2my9fYlr/iaJmzFe4UtP4qEg4EjPQn2q/0YXIWB5fWzoLUfc7UIOPglLJLn9lEsfC8/nGAxxza0Ljh0v8f2eh+kgf3G2cKr+2LnpNA51SaUF/dfnEizZSXXgJV6OxjBGIeLWrX9UPUWXogoznTPex8XjX9TT+fLw3cR77vzogGlfDMiG4KQSiNgVBEbUtoq8PsYRtC6nhTEkAnmMBD0ecnMxIPFcgJrmAYEkk8dIfTaPvg/aFyUEeKOK7R3YGhtg5haQbgQXpxUCFMpnuKODiNdEWsuZVC1K6UmkwUUkjTnbKIPQYPT7ZYNFkATUR0rwn1+fbYiXhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJo3UlOJ3ID/KMlv3/YZD3cbV229qN2lcz3umaK5dRk=;
 b=oqPAz0sPRC6vjF7UpEy+0Iv4bD+w8YXndHptknxH+m9R8vd9zG6NW+AVfFT9NnY4AbWgV/znzV0qJoASvh5We6vOHScuZ11xF3z6P8ROZ2mRjjRjfshAsQievOmKf9V8+DvKGiNQaVs4R9fWMfRIM5S6k2G/PRoRSE0SnVc4sik=
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com (2603:1096:4:14e::9) by
 TYZPR03MB5470.apcprd03.prod.outlook.com (2603:1096:400:31::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Fri, 12 Jan 2024 12:21:44 +0000
Received: from SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::fb6f:5270:c66b:79b7]) by SI2PR03MB6194.apcprd03.prod.outlook.com
 ([fe80::fb6f:5270:c66b:79b7%6]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 12:21:44 +0000
From: =?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
To: "ulrik@strid.tech" <ulrik@strid.tech>
CC: =?utf-8?B?SGFvIFFpbiAo56em5rWpKQ==?= <Hao.Qin@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	=?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Subject: Re: Bluetooth: btusb: mediatek: MT7925 issues on AMD platform
Thread-Topic: Bluetooth: btusb: mediatek: MT7925 issues on AMD platform
Thread-Index: AQHaQssLbccZvW3rkUiQVpmGTP0RJLDWHjYA
Date: Fri, 12 Jan 2024 12:21:43 +0000
Message-ID: <dbb87db4cef3620c44fe678a81a062bef11c557f.camel@mediatek.com>
References: <PA4PR09MB653770BFFE6C835BC31B4C61DF6A2@PA4PR09MB6537.eurprd09.prod.outlook.com>
In-Reply-To: <PA4PR09MB653770BFFE6C835BC31B4C61DF6A2@PA4PR09MB6537.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6194:EE_|TYZPR03MB5470:EE_
x-ms-office365-filtering-correlation-id: 1dc9117b-2b5a-4509-1a4f-08dc13690a0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GrFEqTDlA4gQTSdeRSO3j5LYcC/yNYWqTMwLrgs6iwLBBVUUUchLYZx1Tw4EtyWkCGiUVJSkRW763/3NOMugscpUh5Qz0Q8UbuGTt9l0fEpTfDPu8+VizFtj4TIFYjxtxC93v/uf5I3IhJGr/v0Y0daHwGhngp61UJAmOD7oxtupy014B9yL3G2mX+f/Q32uw9jxB614uMz2QloiqL+QCrOCm5FnsmcsSfklksGeNAdDa3MisdNj3SfSLSVP0TZZ07J7hLcjb/R96aSximiank8TMX/0yfNvOz9Gv47aIohpbkSjEHHanYag4ikTUykGShlS5waLniGBt6W5aFRo0ipOBTYCQgvcbn0RTWUCfA8L7cdmL4zxQUAh/ElSzbfx67JTJ/jj+srPzh6KKDixAnKnRg/6X2kMzFjeOKy9n+0AFSvFsfrCUffP/jZa5H57fjh6J4ZvhGU1dNAhi6Cc/lk4TZjINCX0U9iG6pz+f/k+3/aEViltnISPkeGhABs+hj2C9nvD5epLcLtjTrqd35bAfqpxGxrBBbwMszZiJ/LQL3jl7p9JkavUqa6mUkRipMIa7cqsqR0Qa9g4txhVxxni9MZRzq6YsJsps2jngM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6194.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(2616005)(107886003)(26005)(83380400001)(316002)(4326008)(8676002)(54906003)(6916009)(8936002)(64756008)(66446008)(966005)(478600001)(6506007)(66476007)(66556008)(71200400001)(76116006)(86362001)(6486002)(91956017)(66946007)(122000001)(38100700002)(38070700009)(5660300002)(36756003)(85182001)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3R6QWNLcjdDTWJHVXpzUHBVbkQvWU9FL0NzajdJdmZlRFdBVnV4RGp1U3R1?=
 =?utf-8?B?MTUrUUgzNkl2K2s4SVBucmdsRUxQZkJsTDBsbVdFTC9qWk9ZdSt1WUtkalZS?=
 =?utf-8?B?dUdNWE12b2VrWHZubUZ6ekc2UWdFdENlSW9BOUpUN013d1VWbjBHZ29JNko1?=
 =?utf-8?B?UmpuVVM4VzBNU1BlVFdYT0ZaRHBkM3BOT1hkQ0l5MEREVXZkRmdKL3FKRmdv?=
 =?utf-8?B?NWJldlpmY3BGay90MGUrNVlFeFhzVHhsZkp0TjBtdHVFam5IVGFuUVpKc0VR?=
 =?utf-8?B?LzQwWjErT1dWcVIwWGd4R243Z2FQT0dQVTN3WmpWdWZvTFcwNU5lRFBhamxF?=
 =?utf-8?B?VC93QmYxRmIveFVjdUNKYU9HSkdUYjU4SEpEd012Qm9sYlhHV1VGb1hoSTZX?=
 =?utf-8?B?bDFtTG85YTk5WG5nU2pUNU4yZWlnaG9SQkNyLzlKdy8rYUhVN0RvZURLb3lz?=
 =?utf-8?B?Z2tBWVhPNFlxRG83TmpzT3lZRVFMMDR3M0NSSGVRY0FhVDU3SmhoRG55a29t?=
 =?utf-8?B?WlBLc0VoamVPMmJjSXFJT3IvM2JPbmdUbFkvZk9pMmJTWHlyMzJwMFF5UjV0?=
 =?utf-8?B?cVVQeXg2elJBVnVNVlord1QyKzBFa0tucDgrR0xGSkJjRmxiMjBNU3BPbUs0?=
 =?utf-8?B?cldmTEc5SENjZnZESDFwdVJZNmZNdTlrOHZxczlaZWVOL3ZSWlZWaG8wUzZR?=
 =?utf-8?B?OU9wRGxxWXJxTzlYdFY3MUI4OU9CSngxSHJON0licUltSHRmVjVpTHVCbkxD?=
 =?utf-8?B?bVkweU56VUJQNHVLRWttVDdrbjFVYzJBZlM2d1ZlMDZLbkcrS3FVdjN1anJH?=
 =?utf-8?B?TGM3NzRnVlVqNHU3bldGOEpIS3J5YVhVWU5JQmgzTGVxdVQ0dGVuRDFPMnNz?=
 =?utf-8?B?cmc0K2F1YTBUY1FkSW5HTDB2Z2RKTGUwUTNOanhpZjdSaUNEdk5TMFo0V0hD?=
 =?utf-8?B?cWdKbWdnWU5SRDhQeTd1WWJseWlQbEg4V2RqWmhMZmc2N1R1WFlGaFIyZXZM?=
 =?utf-8?B?ZXBGZDhDS2dNeER5R2RhdTNqRUcvVkxsTU9PNlZHS3JSYXozZWtjUTJXaktV?=
 =?utf-8?B?RVRBdWZyYkszbmZsZklReGszTHB0Z2dZbnYyR3lnWmpyMUhxQkorTUsycnVq?=
 =?utf-8?B?Uk9ySkhSSUFjb284YlJRbmNzcnpZWWtDNVpNRWt2NWVMVHJOcGJGYnBsN3VY?=
 =?utf-8?B?SFh1OHZ3eEhzdUZuTUxoczJTY1h2dUU0Mzcxdi9wWkY5bkRHREZMUStndkVR?=
 =?utf-8?B?b1I1bDdhNW5NWU9OWk96VEsrL3Z6NGdDMUkxQTg5SjUzYTJod3g5c0xDSGdY?=
 =?utf-8?B?OCtDQ0RtUURaNFBSQWFmSHhDZkc1ZkQvSTY5T2ZESmVkNVNLaHhJRk5lNkV3?=
 =?utf-8?B?aXp2Tkl5QjBVSmI3eXBwVEliWlpxQUpRVklGSCszVG1jcS9zQWhJNkdPRjJq?=
 =?utf-8?B?Tmw1YlhhOXF6RlhVN0lLeGlsTWZiV043TE5uUzczeDh0UmdsTHJMeStHSmpo?=
 =?utf-8?B?dnR1OW5VS1NSMWZML2VWYjRzalZIZGhQbUdWbzZ3OUZpQitGWGFEbTA3cXd4?=
 =?utf-8?B?alphczlVQ0tBTllFTDdYbUZaekx0L2puM2tRWjNyQlkycWxzbmtDRXV5Q1lj?=
 =?utf-8?B?TjQ5SW9Vb3dsSnBKNkFFRFI1Y0NHTWNqT1ROeDdLUDM3WHNvSHVNNTJCRTd4?=
 =?utf-8?B?bWlWb0pJZmFJTlJaQWs5c0FoSlI2eTVSSDlINmdGMkMxVFdzVXJSQXdsQ3lx?=
 =?utf-8?B?WnpZdVlLZ0Jkbi8wWnFjUE1yQjFGZHJvTzUzZGU5WnR5dGphakZZYUN6NGho?=
 =?utf-8?B?ZWo2OUxySTVtZWNVOUNTQ05BTjZoUFRDNVlKVkJyNlVUZWc2d3J3MWFZY2Ev?=
 =?utf-8?B?ZnkxY3NzRzRaV3NwcmhSY1AxbEFVNURrZGRyN3BaaGZrSzloM1p4T3k4QzdE?=
 =?utf-8?B?eUNUNjhWdGdlRi9TMzVBZURROWVTTnNaWGRVekRJRWZPdlQ0dm5nQ3ZWYmRp?=
 =?utf-8?B?YzZLMGNEbFRKS0s4Ykl0cVpaOTZrQnZZOTRSaUNzaWgzQlVsRWlDWVBmVnNt?=
 =?utf-8?B?LzZpUmRvR2lIWWZLenlHRUVlNW9DUk5LOXVMQXNMdjBPMUJ2QlBuY2hpL1VM?=
 =?utf-8?B?NzVLdkREU010SEVZVE5JbFRLNVBhTlA0YXEydjRMaE52NGRZWS8zeVBmMVl3?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78A93BBDA017004C9FA89B49BADAEEE5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6194.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc9117b-2b5a-4509-1a4f-08dc13690a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 12:21:44.0208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZX402G7y+sq/aIfNIOM+8lN4SDqsXcSJs2ph16KGVoIbDljHizz5U5/BtsJIb3mnN7IJUeYLgq2YADXVvgiBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5470

T24gVHVlLCAyMDI0LTAxLTA5IGF0IDA3OjI3ICswMDAwLCBVbHJpayBTdHJpZCB3cm90ZToNCj4g
DQo+IEhlbGxvLCBJIHJlY2VudGx5IGdvdCBhIHdvcmtzdGF0aW9uIHdpdGggdGhlIEFTVVMgUHJv
IFdTIFRSWDUwLVNBR0UNCj4gV0lGSSAgbW90aGVyYm9hcmQuIFRoaXMgaW5jbHVkZXMgYSBNZWRp
YXRlayAgTVQ3OTI1IGNoaXAgdGhhdCBoYW5kbGVzDQo+IFdpRmkgYW5kIEJsdWV0b290aC4gQWZ0
ZXIgdXBkYXRpbmcgbXkga2VybmVsIHRvIDYuNy4wIGFuZCBydW5uaW5nDQo+IHJlY2VudGx5IHVw
ZGF0ZWQgbGludXgtZmlybXdhcmUgdGhhdCBpbmNsdWRlcyBtdDc5MjUgZmlybXdhcmUgSSBnb3QN
Cj4gV2lGaSB3b3JraW5nIGJ1dCBJIHN0aWxsIGhhdmUgaXNzdWVzIHdpdGggYmx1ZXRvb3RoLiBJ
J3ZlIGFkZGVkIHRoZQ0KPiBmb2xsb3dpbmcga2VybmVsIG1vZHVsZXMgdG8gc2VlIGlmIEkgY2Fu
IGZpeCBteSBzZXR1cDogYnR1c2IsIGJ0bXRrLA0KPiBtdDc5MjVlLCBtdDc5MjV1IGJ1dCBuZWl0
aGVyIG9mIHRoZXNlIGZpeGVzIHRoZSBpc3N1ZS4NCj4gDQo+IEkgc2VlIHRoaXMgaW4gbXkgZG1l
c2cgbG9nOg0KPiBrZXJuZWw6IEJsdWV0b290aDogaGNpMDogT3Bjb2RlIDB4MGMwMyBmYWlsZWQ6
IC0xNg0KPiBBbmQgdGhpcyByZXBlYXRlcyBpZiBJIHJ1biBgaGNpY29uZmlnIGhjaTAgIHVwYA0K
PiANCg0KSGkgVWxyaWssDQoNCkd1ZXNzIG1pc3NpbmcgdGhlIEJUIFBJRC9WSUQgb2YgdGhlIE1U
NzkyNSBkZXZpY2UgaW4geW91ciB0ZXN0LiBDb3VsZA0KeW91IHBsZWFzZSB0cnkgdG8gZ2V0IHRo
ZSBpbmZvcm1hdGlvbiBieSAnbHN1c2InIG9yICdjYXQNCi9zeXMva2VybmVsL2RlYnVnL3VzYi9k
ZXZpY2VzJz8gSGVyZSBpcyB0aGUgc2FtcGxlIHBhdGNoIHRvIGFkZCBuZXcgSUQNCmZvciBCVCBk
ZXZpY2UuDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9ibHVldG9vdGgv
cGF0Y2gvMjAyMzA3MDcwNjI5NTkuMzAzNzEtMi1jaHJpcy5sdUBtZWRpYXRlay5jb20vDQoNClJl
Z2FyZHMsDQpEZXJlbg0KDQo+IElmIEkgY2FuIGdpdmUgeW91IGFueSBtb3JlIGluZm9ybWF0aW9u
IGxldCBtZSBrbm93LCBJIGhvcGUgdGhhdA0KPiBNZWRpYXRlayBhcmUgYXMgZWFnZXIgdG8gZml4
IHRoaW5ncyBhcyBJIGFtLiBJIGNhbiBhbHNvIHRlc3QgYW55DQo+IGtlcm5lbCBwYXRjaGVzIHRo
YXQgeW91IGhhdmUuDQo+IA0KPiBJIGhhdmUgdmFsaWRhdGVkIHRoYXQgdGhpbmdzIHdvcmsgdW5k
ZXIgV2luZG93cyB0byBtYWtlIHN1cmUgdGhlcmUgaXMNCj4gbm8gaXNzdWUgd2l0aCB0aGUgY2Fy
ZCBpdHNlbGYuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IFVscmlrIFN0cmlkDQo=
