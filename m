Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232A91531D5;
	Fri,  1 Nov 2024 07:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445112; cv=fail; b=Uae1YMq+0J/aTyC3JdZY9ClhR9RMpXhpmJpXEMxDGl7tSBT/ArmazGtgmWwaiykm5zkoYO0B5qCHs06CPr39cVJ7vk3sYwD6Ry0uabP5AB/SwN5Qx0onDJ/EokSJOLNgtPI3cxlhE2+GPjepseBbrfqRT17VWEpgs1VwEHw62Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445112; c=relaxed/simple;
	bh=WIhHVhFBNlydVnUdv4yifGqaDt7rMjavWHGQPVMP85M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jiQcUF+Ycm2m7FypYEtNOwbIiNnXGB+K81FwTU3NPUJ3plCbz4EObbRnbcq+beabyo/ZQx0TsuwH6TMI88pZ0nZtgluFDtEFGjcy4LKJbYjwdUVgjYx1fLnDJEzaJV67XsNo/D1Yp+n6vlV7mkWVQ7Xl+A6sXt7WOHCgaUWUn68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iXeX+Qqp; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=IIHiFpz4; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iXeX+Qqp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="IIHiFpz4"
X-UUID: 88dcaf8c982011efbd192953cf12861f-20241101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WIhHVhFBNlydVnUdv4yifGqaDt7rMjavWHGQPVMP85M=;
	b=iXeX+QqpS90dNb9nbDuETi0nRIvNct/0lDIg+L1Y9YpUuEygZHEoXzjSA2iZRD54XbJa0a3pMh9MncIIbs/9P1C5rh+mqC9iVm6n2zbi8Jp/ZO8Relera+ZBwnGtoLKCuvq1gDLEgH08bXGb+ysG967RQ4xvhi5asQvQCY2qTQc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:87d93893-eec8-4062-8aa9-bd7b1f5d7105,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:a1846007-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 88dcaf8c982011efbd192953cf12861f-20241101
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 983905292; Fri, 01 Nov 2024 15:11:37 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Nov 2024 15:11:36 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Nov 2024 15:11:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRJfq0JzG+MHmdg+SgnsSnCNk83wliEwUSoTtAT/Zv/QYr0ikZGM9ygRexFYkjUrSEuJiK67xBbFgaHwo/9vv+w2g6NQSEMY+ndLXEAIKuGa7ySGGX88joAP97TrDykrMtZiEx9uC8XDGVdwF7X2tXZMVPRNnPT0DP4uWdRmGfdtxCkqw9howUmd0xgamoBGQd5cBV/F3G4EnMcXPSOR+Jb33FPOrnHQags51xT8TDK2yF+yzeTMKjpq9fTjXTsmxDmxZ0UYjFKtgdBg2P51DcuOFYZrf1UZDlj60sPxpkKmvxh6FR0JQTW/qiPHaqXW2ISatZJNOJKkfum48clbMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIhHVhFBNlydVnUdv4yifGqaDt7rMjavWHGQPVMP85M=;
 b=Ut4/tgsR6359gKVTdCPWiLg0tO0ziZPOFireA8Q/YrNiyjcrYuRR4PL28x8sokIySDe2s2cE2RkO7BpbXAurRg5GdTVaBz0kZX2dHrmDCwzq2aaQq4PpTWQLbKj+Zv0yoVezMKJXwoitjOyyhBD8gReaoNCYUpxUGaCSNHYVqw7EOoABDnVTp9ei3AwwlhjP2vi7XkYPDTE1zZGm5nFMat05e/v05yWm1Dq4umWb0paTw/2w75fqPXi2rQ0wWsRlogJVBa8DKRm44I0hEk4d++KUWBisMtQ3Qq1zNAhL7a3vZfZ+HVljF2+lkyrLoC7Fv33pp2mpqcy8MShwBL3j6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIhHVhFBNlydVnUdv4yifGqaDt7rMjavWHGQPVMP85M=;
 b=IIHiFpz4O41fSyVrkONZKtPusesxdyueZ1+qWW223Mf8VsX7MVFq+jtnuvGRE3ic1G78gv9tnjurSGifUPW3zYCY2HZ1qxEG2kv0biBxEsNl6Muv2flUizGALmzEjyoOO8q9wNbUr7EyphAl04Z6ioB2dROjvfHYT+n6KN7ZW0A=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by OSQPR03MB8433.apcprd03.prod.outlook.com (2603:1096:604:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 1 Nov
 2024 07:11:33 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 07:11:32 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "regressions@leemhuis.info" <regressions@leemhuis.info>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	=?utf-8?B?SGFvIFFpbiAo56em5rWpKQ==?= <Hao.Qin@mediatek.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"marc.payne@mdpsys.co.uk" <marc.payne@mdpsys.co.uk>, "tiwai@suse.de"
	<tiwai@suse.de>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
Thread-Topic: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
Thread-Index: AQHa9FNmoMNrfHOpSUGvzt/DtokMqLJRX6GAgAsunzeAASkiBIACJd5SgCZxi0+ADKqeAIAMeB+AgAAj6TOAAtx0AA==
Date: Fri, 1 Nov 2024 07:11:32 +0000
Message-ID: <f3c6f6f857d19c867941c86c644042fa195621ac.camel@mediatek.com>
References: <20240822052310.25220-1-hao.qin@mediatek.com>
	 <ZuB3omUkdUHLggYu@mdpsys.co.uk>
	 <790e542aa9d08c7efeee6ef298fce2a87d8035e4.camel@mediatek.com>
	 <ZuneSM4SvyUFX86j@mdpsys.co.uk>
	 <9bfbbf24ac2480d94d3455f7e33e4b5502b38ced.camel@mediatek.com>
	 <CABBYNZKYsL9jcF2n9TsA1BjU-CjXOdXu7MDLP9Sz_Ly8hBAf1w@mail.gmail.com>
	 <c01e6dfa730dd10a7d4dba60fe31e82b9c296b37.camel@mediatek.com>
	 <Zuyk1c6Gkxx3G0PB@mdpsys.co.uk>
	 <f9e8688ebe559e10c019d0cbab4e8b1f5a7d2339.camel@mediatek.com>
	 <ff502f63-2d87-4dee-a893-cce53353df8b@leemhuis.info>
	 <87iktk4d9l.wl-tiwai@suse.de>
	 <75f671b6-ce2a-4404-b662-2c9c7d28a598@leemhuis.info>
	 <d0f70e662f5e9329cff43f92a5c191601cc599f1.camel@mediatek.com>
	 <0a988691-8c18-4dca-ac78-94e36a9b8b37@leemhuis.info>
In-Reply-To: <0a988691-8c18-4dca-ac78-94e36a9b8b37@leemhuis.info>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|OSQPR03MB8433:EE_
x-ms-office365-filtering-correlation-id: 31cae35e-e8c1-469e-6031-08dcfa446a3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cHFtdGRhNjNaOHJjMHZJS3ZJYndxYU1KYXZJL0tYSVFYWi9KSCs0K01MaENP?=
 =?utf-8?B?eGZ2T2ZRQ3VYNGEyZ2Z0Zjl4OUJGWkExeGpSRWNlMjZ2Y00xTzJIdnFyREkw?=
 =?utf-8?B?NTd0V0FTTHhXcUFBSzV1R0t0Y29RcU5rT3F6aG8yaG9sRHNlVzZaY2h6VXZn?=
 =?utf-8?B?N1JrS083cmdiQXQ2Z1N6bkdtUEFZdWZOdU1QNE1jVU5XeVdPMFFpVlpvcHFn?=
 =?utf-8?B?WFBwRkc1aldUY0IrL09LSzdTS2VtTHlId0g1Tkw2WVEvMExlQWwxRlczRk5h?=
 =?utf-8?B?WDZicnovTzNabVZjYktqL2s0L3ExMnAzb0tRNkZOUVB6RVV2MFF0YmJpYk5I?=
 =?utf-8?B?UTNDKzZJVU9WSUdKc2phM0dsTU1YellFclZVSWJVT2JweVU0U1BlK05NYldz?=
 =?utf-8?B?Z3hLUENWNnRIRlBpSEN2ODVvS0FsV0dFT3phSnBjcVJnT2w5R1MvaElJZkhH?=
 =?utf-8?B?TzlNa0hkRHA5eHphVEZoTlR1T2JkK2NZYnVxdHI4N25MekozMXBrT1k2YUQr?=
 =?utf-8?B?K0pnNlZLeTBkaEJzYnErZktpZGJJVDJkdTFYVUxnaXFEZjVsZXJ0eDRHOHZL?=
 =?utf-8?B?aW81emcyc3pBbDdEdzNqeUU5YXp2WE4vZXR0d09hMm04dzlTTjE5eFM2eU5Q?=
 =?utf-8?B?UUhsVmtxYk5vN0hPeTRpdThqdmd6VEYraUZyekpzaWlaemo1T3BXMStCSWo3?=
 =?utf-8?B?aHE0WWFVSkJwNTgwOEFLbSs0NVNGbUJraXAzQ01jRmRXRGhYVnZLVU5zemY4?=
 =?utf-8?B?REgzTmhjQkpCdkdlK1d5enVsTFl2N1NNNmtlVytLNUowcURJT3FXd2hNS0JH?=
 =?utf-8?B?bDYzVmg5Y1RWdmx2Zzllck1vMTZESGtZZmdTYlNORm5vZWVVZmRubEJYaU5H?=
 =?utf-8?B?eVpUOXRFeFJYa0hzNWxubVMrUVE1T1VWZU1HU3dSVkErWWJkeWNFK2x0U0k5?=
 =?utf-8?B?WGp1blhvRCtaSXFHVlF6S2JIUkRWTGR0U1orZUFTV2kxMHVLNnpPaGpuNXlj?=
 =?utf-8?B?dG94c0l3Ym93SVA2Y2VYMnFoU3V0b3VoZjdUSldtRVZFaU9IK2Y0Vm1qWDZJ?=
 =?utf-8?B?QklWK3FLT0c3R2swS1RlNnk5NHM4dGUrd1ErWkJ2RndSWnIvSFVaWnBJclVF?=
 =?utf-8?B?SEZmQUM3U0FZWXBuQ3VlQ3cyUURXTmczWFJkbUs2VUtuRlRweTJqTGNYS3cv?=
 =?utf-8?B?MUd2eW94cXZDbUVCYW8zd2p2ODJkSTEzWmMwNll0NnBEbUs0eUlPWEZ3Z3Ix?=
 =?utf-8?B?WGJ1TWxzOFdMWXpBeis3bURZbHcrVE1pN2padlF5cGpVQnVRVk1qQmJlR3Jo?=
 =?utf-8?B?djQzTk1tQzlpbU1KY1JjRFowVGlOd2MrOUc4V0J6cDgwaU4xL2RsQ25tZ2tl?=
 =?utf-8?B?VlV3WEFGZ3MxWVpGM1hZV1A1bTBEdEdLbTl4TElaT3FlTlNLS3plVEIya3R2?=
 =?utf-8?B?Z1R1dnlENGRlWWdpQVB4ZjN5dXFXQ1dWRkFiNmlLWUR3VXdaMmRuZWtXR003?=
 =?utf-8?B?UHdmTzNPYXFQbTQ1ZlJ3V3FhemtTNEJOc2pSaVBhNlF1cmFVQktrRUFQY0F3?=
 =?utf-8?B?WHh1K1QyVjJBeVdUdUlnbWFpSmVQaS9xMEJWZTJ0dUp4QzB2NGxQang2enE0?=
 =?utf-8?B?U0Q2NDd3RDJ2NUx0YjdpZlFpNWRSS0YyTXpUSDBhbC8xOE10TDREN2xzd2dw?=
 =?utf-8?B?aXQ1QjFnRHVwbEtydFpYcFZhWXRHMnExcmx6eVVjUDd6UHFOWlBseTJrUDVp?=
 =?utf-8?B?TmMwQStpMm1VWU1WVHlpU3VPbjRoMFU3R3gwZkRMYkp6Uy9Vc3B0Zzg4UVUx?=
 =?utf-8?B?akdZRFBtS2w4MTNaK3pzT091Q2dFOWJLNDlzeVhZUE1kb3R1WkpadCtPbTRp?=
 =?utf-8?Q?Br3Bh5RHRyptz?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGxFUTB1VGxYK1FYYXo0SVpMU0I0b2RnbUZSZDlmcDc1SWJQRWdRaitqejhw?=
 =?utf-8?B?RjhaVGZNNXZ1SnEvbTgyNnNmem9rTmtjb0paV0FZNmdzZVBkY0MwVlBqbFM5?=
 =?utf-8?B?U1JOdjFpYmhQWDlzNUx5ZEdKbXVFenRFaCsxNGlqclhJemlrMG80QVVHdVhq?=
 =?utf-8?B?MWhjMEN5U1FvVmtaZ1g3alpxWkJTalZlNGYyOXp1OFpsUi9CYTFsSzVuVndW?=
 =?utf-8?B?ckpaNWh0S3JyYTQ5SVZjRjZHWUt0TVFDT1d4OEwwM1R3MVVFODh5M0tsdUlX?=
 =?utf-8?B?dTQxTUdzYmJDMUxnaEhOT0t1UnpCRWZQZjBKRFl6S2UyRGorbEE4eWVPd0JP?=
 =?utf-8?B?Q21QYlBZcTExdGRla0l3YUVTVXZyQm5BZ1NKK0pKVERuRWZHNmM5UytXeFhN?=
 =?utf-8?B?eFJoUDdrN09RRlF6cEIwVVdkQUNsWGxiMFFnS2Z0dWFDMTlTKzg0ejdPRzA0?=
 =?utf-8?B?WDdlZWxFdi8va0ZucmZaRXdaajRrK2FpNWp5TWR5LzZmTEk4TFFNdDZicmY3?=
 =?utf-8?B?dHNGRFZTblZxMW5uQmg5endqZXdXTTA4djBWYnZkQUliNEgyS2FtWlB3WmFu?=
 =?utf-8?B?eS90dElQQXBFV0orOHlzTCt2Q0pwM0pMWXdlRERhQ3V6MEg3cXZaS2srM3Ry?=
 =?utf-8?B?Nkw3dCs1ZDk3OGFCVHEyeWpFL08vZkVFZWd2Ly9ZM2lPMGEwM1VWK0h1T1V1?=
 =?utf-8?B?eno2K2NQWmpCZHMrR0hnN2FVczRiQ0YwRThRYzBQbVBvZUsrRkNHRTNNTWs4?=
 =?utf-8?B?YWx0QmxTSmgycWVjR2FRR3FEenlSM0hsOS8wbHZ5dFlKNS9INndIU1RDNXpJ?=
 =?utf-8?B?d0MwVXlNenBpd2wyNWplalRrN3FnQU5Xd3lmYmxxMG5lcDZiMHNacmwwaWFH?=
 =?utf-8?B?WkladFZvVzRsL2VPQlZqZ3dBSTBDc0p1ME52SXoxempHUFhFelpOL1RlK1Zo?=
 =?utf-8?B?TnJBTDFrYnk3b1lPZU1NK0UzT0tHQmV2SzdjRjBmOEY0QnRNVXp5ckFzUFlC?=
 =?utf-8?B?ZFJkQlVVRVFtS0ovNlJ1T1VYcWVSSjd6eWNoSTNFdk5qZzI2c2N4UjFSTWZt?=
 =?utf-8?B?OE1YL0ZpSVMxSkhtSFFneVpCUnlLSkVrR0hud2EyMG5SbjdrZUtlN2xReXJh?=
 =?utf-8?B?RWJvKzJYYW9WWmFVWXJnN3ViRGFmZ3M5SW5YTzlXL29RWTVoR0Vrd0RHcnVU?=
 =?utf-8?B?VEFMbWJuZ3FlUGQ1aHpWdGpRemxtNTlaRlhOdm5WZHhrTFVmU1FtTWdhcHpD?=
 =?utf-8?B?SXlGdDBza1k5eXpudXZDREVvTGR2RTZaL21KZ1FLZU9vQW5lK2piRnF1dHB1?=
 =?utf-8?B?RW1LVVhKK0dEdjRMNlNGSU9JODVDVFNkN1Z2cVIwMno4RS9JcU9jdG9lTnJG?=
 =?utf-8?B?aGQvUkQxc3A0Tk4vcHRlbEt5d0JJcTBjbzkxeU56ZE9JMFV4aTMxUXpNbFpp?=
 =?utf-8?B?ZG1DUVVtQWpJS3ZCbGwvUEp3cms4MkdIeEczNDBxYWZyeFhCT1pXMDNKYjVG?=
 =?utf-8?B?bHh1SkwwTHczVGNaRHFCOHJ4MDdZVnNYcHNUVGIrWjc3em5xb0g1b0wvMzZw?=
 =?utf-8?B?M05ZcHorNStzS3ZqaUZkUWM3OU9RY0h2M1hveG1mTmZrZm8wdUVPUXByR3BW?=
 =?utf-8?B?RGVaQXYvTkZLMXVycWhCa0o4d2Y3dDFYUnkrb0dNU3dwd0xoL0h5TkpwcjVO?=
 =?utf-8?B?MGNkS3RBZ09LY2E0Nzdhc2ltU21xY2FhdGJybFdvdE5HcFFMVUcwRFJkZjZz?=
 =?utf-8?B?Z2kyQllkWm9VVkppczFDR0hOOThndGM1UVV6ZGoxS0cyQUk2VEhtZDZ6ZkNJ?=
 =?utf-8?B?QzZJNEdmaSs4ZnJFR2IxS3JRVGpYVnBTS0VGU1FJUG9HRWQ1WERlZEQ5NERV?=
 =?utf-8?B?TklzSWVrNVREYWVZQVRnTktXOGV3YnNQd1dMRGFWZjlQbUU0UkU3UlErdVVw?=
 =?utf-8?B?WGVrMFNFaGJacHhCOFhyT1ZBSFgraGdMV0RJMXBYMngrRnUzN2hxMFNMaFQ3?=
 =?utf-8?B?TXZBMkxoVS92QmYxdC9EMFQ5NmJ6M0hIcDR6UWFVV09PckZzakdSR1c5eFQ3?=
 =?utf-8?B?aWQxNDViMGNEUVNSTTBFN0JieCtwZkhER2RxTzh6eXlqU2VxSHV5RlYzeWR4?=
 =?utf-8?B?cHpBeFhLeXBLOFZoaVhFaGxTTHpKNStyU3RTZjBkci9TNmYvSUYvMjFKbnAw?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A6F80C58B542E43A56B578F5AF14F6A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cae35e-e8c1-469e-6031-08dcfa446a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 07:11:32.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpPbOMUlylKqQPpiA3Phmhb+8z5UTPuHDrv6dE0yh02vWdhfTRITZCbQPiFnF6Y9mIihE+FHtt1TYv6JC5abkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8433

SGkgVGhvcnN0ZW4sDQoNCk9uIFdlZCwgMjAyNC0xMC0zMCBhdCAxMjoyOSArMDEwMCwgVGhvcnN0
ZW4gTGVlbWh1aXMgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gT24gMzAuMTAuMjQgMTI6MDMsIENo
cmlzIEx1ICjpmbjnqJrms5MpIHdyb3RlOg0KPiA+IA0KPiA+IExldCBtZSByZWNhcCBhbmQgdXBk
YXRlIHRoZSBzdGF0dXMgb2YgdGhpcyBwcm9ibGVtLg0KPiANCj4gTWFueSB0aHghDQo+IA0KPiA+
IE1hcmMgZmVlZGJhY2sgdGhhdCBoZSBoYXMgc29tZSBwcm9ibGVtIHdpdGggTVQ3OTIxQVVOIHVz
YiBtb2R1bGUuDQo+ID4gT3JpZ2luYWxseSwgd2UgdGhvdWdodCBpdCB3YXMgY2F1c2VkIGJ5IHRo
ZSBjaGFuZ2UgIkZpeGVzOg0KPiA+IGNjZmM4OTQ4ZDdlNGQ5ICgiQmx1ZXRvb3RoOiBidHVzYjog
bWVkaWF0ZWs6IHJlc2V0IHRoZSBjb250cm9sbGVyDQo+ID4gYmVmb3JlIGRvd25sb2FkaW5nIHRo
ZSBmdyIpIi4gVGhlIGNoYW5nZSBpcyBtYWlubHkgZm9yIE1UNzkyMiwgd2UNCj4gPiBmb3VuZCBz
b21lIHByb2JsZW0gd2l0aCBNVDc5MjEgb24gc3BlY2lmaWMgcGxhdGZvcm0gaW50ZXJuYWxseS4g
QXMNCj4gPiBhIHJlc3VsdCwgSGFvIHNlbnQgYW5vdGhlciBwYXRjaCB0byByZW1vdmUgTVQ3OTIx
IGZyb20gdGhhdA0KPiA+IHJ1bGUoQmx1ZXRvb3RoOiBidG10azogUmVtb3ZlIHJlc2V0dGluZyBt
dDc5MjEgYmVmb3JlIGRvd25sb2FkaW5nDQo+ID4gdGhlIGZ3KS4NCj4gPiANCj4gPiBIb3dldmVy
LCBNYXJjIGFsc28gbWVudGlvbmVkIHRoYXQgQlQgaXMgYWJsZSB0byB3b3JrIGlmIGNoYW5naW5n
DQo+ID4gYmFjaw0KPiA+IHRvIGFuIG9sZCBmaXJtd2FyZSBiaW4uIEJhc2VkIG9uIHRoZSBjbHVl
LCB3ZSBmb3VuZCBpdCB3YXMgY2F1c2VkDQo+ID4gYnkgYQ0KPiA+IGZpcm13YXJlIGNoYW5nZSB0
aGF0IHNwZWNpZmljIE1UNzkyMSBtb2RlbCB3aWxsIG5vdCBhYmxlIHRvIHNldHVwDQo+ID4gc3Vj
Y2Vzc2Z1bGx5LiAoSW4gZmFjdCwgd2UgZGlkbid0IGV4cGVjdCB0aGF0IE1UNzkyMUFVTiBjYW4g
YmUgZ2V0DQo+ID4gYnkNCj4gPiBub3JtYWwgdXNlci4pDQo+ID4gDQo+ID4gU2luY2Ugd2UgY2Fu
J3QgcHJlZGljdCB3aGljaCBtb2RlbCB1c2VyIHVzZSBhbmQgTHVpeiBhbHNvIHN1Z2dlc3RzDQo+
ID4gTWVkaWFUZWsgdG8gZml4IGl0IGlmIHRoYXQgbW9kZWwgY2FuIHdvcmsgYmVmb3JlLCB3ZSBo
YXZlIHByZXBhcmVkDQo+ID4gYQ0KPiA+IHNvbHV0aW9uLiBJJ3ZlIHZlcmlmaWVkIHRoZSBzb2x1
dGlvbiBsb2NhbGx5IHRoYXQgTVQ3OTIxQVVOIG1vZGVsDQo+ID4gY2FuDQo+ID4gd29yayBub3Jt
YWxseSBvbiBVYnVudHUgUEMuIEl0IHdpbGwgYmUgYSBmaXJtd2FyZSBtb2RpZmljYXRpb24uIFdl
DQo+ID4gcGxhbg0KPiA+IHRvIHN1Ym1pdCBuZXcgZmlybXdhcmUgd2l0aCB0aGlzIG1vZGlmaWNh
dGlvbiBpbiAyMDI0IE5vdi4NCj4gDQo+IEdyZWF0LCBidXQgZHVlIHRvIHRoZSBrZXJuZWwncyAi
bm8gcmVncmVzc2lvbnMiIHJ1bGUgdGhpcyBpcyBtb3N0bHkNCj4gaXJyZWxldmFudCwgYXMgdGhl
IHJlZ3Jlc3Npb24gbXVzdCBiZSBmaXhlZCBpbiBhIHdheSB0aGF0IGRvZXMgbm90DQo+IHJlcXVp
cmUgdXNlcnMgdG8gY2hhbmdlIHRoZWlyIGZpcm13YXJlLg0KPiANCg0KTWFyYydzIG1vZHVsZShN
VDc5MjFBVU4pIGlzIG5vdCB3b3JraW5nIGlzIGR1ZSB0byBhIGNoYW5nZSBpbiBzcGVjaWZpYw0K
ZmlybXdhcmUgdXBsb2FkZWQgbGFzdCB5ZWFyIGFuZCB3ZSBwbGFuIHRvIHJldmVydCB0aGF0IGlu
IHRoZSBuZXh0DQpmaXJtd2FyZSByZWxlYXNlLiBTaW5jZSBpdCdzIHJlbGF0ZWQgdG8gY29udHJv
bGxlcidzIGJlaGF2aW9yLCBpdCdzDQpxdWl0ZSBoYXJkIHRvIGNvdmVyIGluIHNvZnR3YXJlIHNp
ZGUuDQpBZGRpdGlvbmFsbHksIE1UNzkyMUFVTiBpcyBhbiBleHRlcm5hbCB1c2IgZG9uZ2xlLiBN
ZWRpYVRlayBvZmZpY2lhbCBQQw0KcHJvamVjdCBkb2Vzbid0IHVzZSB0aGlzIHR5cGUgb2YgTVQ3
OTIxIG1vZGVsLiBXZSB1c2VzIGFub3RoZXIgdHlwZSBmb3INClBDIHByb2plY3RzIHRoYXQgaXQg
Y2FuIGJlIGd1YXJhbnRlZWQgYmx1ZXRvb3RoIHdvcmtzIG5vcm1hbGx5IHdpdGggYW55DQpmaXJt
d2FyZSB3ZSB1cGxvYWQgdG8gS2VybmVsLiBBcyBhIHJlc3VsdCwgd2UgYmVsaWV2ZSB0aGUgaW1w
YWN0IGlzDQptaW5pbWFsIHRvIGdlbmVyYWwgdXNlci4NCg0KPiBTbyBpcyBhbnkgc3VjaCBzb2x1
dGlvbiBpbiBzaWdodD8gT3Igc2hvdWxkIHdlIGp1c3QgcmV2ZXJ0DQo+IGNjZmM4OTQ4ZDdlNGQ5
IGFuZCBhbnkgcmVsYXRlZCBmb2xsb3cgdXAgcGF0Y2hlcyBmb3Igbm93PyBPciB3b3VsZA0KPiB0
aGF0DQo+IGp1c3QgY2F1c2UgcmVncmVzc2lvbnMgZm9yIG90aGVyIHVzZXJzPw0KPiANCg0KQWN0
dWFsbHksIGl0J3Mgbm90IHJlbGF0ZWQgdG8gY2NmYzg5NDhkN2U0ZDkgd2hpY2ggbWFrZSBibHVl
dG9vdGggY2FuJ3QNCnNldHVwIG5vcm1hbGx5IGlmIHVzaW5nIE1UNzkyMUFVTiBtb2RlbCArIG1p
c21hdGNoZWQgZmlybXdhcmUuIFdlDQp0aG91Z2h0IGl0IHdhcyB0aGUgc2FtZSBpc3N1ZSBpbiB0
aGUgYmVnaW5uaW5nLCBidXQgaXQncyBub3QgZXZlbnR1YWxseQ0KYWZ0ZXIgZ2V0dGluZyBtb3Jl
IGFuZCBtb3JlIGNsdWUvbG9ncy4NCkkgdGhpbmsgd2UgY2FuIGtlZXAgdGhlIGNoYW5nZSBiZWNh
dXNlIGl0J3MgbmVjZXNzYXJ5IHRvIHRoZSBjaGFuZ2UNCnN1Ym1pdHRlci1IYW8ncyBwcm9qZWN0
Lg0KDQpDaHJpcyBMdQ0KDQo+IENpYW8sIFRob3JzdGVuDQo+IA0KPiA+IE9uIFdlZCwgMjAyNC0x
MC0zMCBhdCAxMDoyMSArMDEwMCwgVGhvcnN0ZW4gTGVlbWh1aXMgd3JvdGU6DQo+ID4gPiBFeHRl
cm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gSGksIFRob3JzdGVuIGhlcmUsIHRoZSBM
aW51eCBrZXJuZWwncyByZWdyZXNzaW9uIHRyYWNrZXIuIFRvcC0NCj4gPiA+IHBvc3RpbmcNCj4g
PiA+IGZvciBvbmNlLCB0byBtYWtlIHRoaXMgZWFzaWx5IGFjY2Vzc2libGUgdG8gZXZlcnlvbmUu
DQo+ID4gPiANCj4gPiA+IEknbSBhIGJpdCBsb3N0IGhlcmUsIGJ1dCBtYXliZSBJJ20gbWlzc2lu
ZyBzb21ldGhpbmcuDQo+ID4gPiANCj4gPiA+IEx1aXosIGNhbiB5b3UgaGVscCBvdXQgaGVyZT8g
SXMgdGhlcmUgYSByZWFzb24gd2h5IHRoaXMgcGF0Y2ggaXMNCj4gPiA+IG5vdA0KPiA+ID4gbWFr
aW5nIGFueSBwcm9jZXNzPw0KPiA+ID4gDQo+ID4gPiBDaHJpcyBMdSBhbmQvb3IgSGFvIFFpbjog
Q2FuIHlvdSBtYXliZSBoZWxwIG91dCBhcyB3ZWxsIGFzIHdlbGwNCj4gPiA+IGFuZA0KPiA+ID4g
aGVscA0KPiA+ID4gd2l0aCByZXNvbHZpbmcgc29tZSBvcGVuIHF1ZXN0aW9ucyB0aGF0IG1pZ2h0
IG9yIG1pZ2h0IG5vdCBiZQ0KPiA+ID4gcmVsZXZhbnQNCj4gPiA+IChzZWUgYmVsb3cpLg0KPiA+
ID4gDQo+ID4gPiBGcm9tIFRha2FzaGkgcmVwbHksIHRoZSBidWd6aWxsYSB0aWNrZXQgaGUgbGlu
a2VkIHRvLCBhbmQgdGhlDQo+ID4gPiBtYWlsDQo+ID4gPiBmcm9tDQo+ID4gPiB0aGUgTWVkaWFU
ZWsgZm9sa3MNCj4gPiA+ICgNCj4gPiA+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8x
MmEzNDRlMjViMzFlYzAwZmU4YjU3ODE0ZDQzZmNiMTY2ZTcxYmU1LmNhbWVsQG1lZGlhdGVrLmNv
bS8NCj4gPiA+ICkgaXQgZnJvbSB0aGUgb3V0c2lkZSBsb29rcyBsaWtlIHRoaXMgcGF0Y2ggc2hv
dWxkIHJlYWxseSBiZQ0KPiA+ID4gbWVyZ2VkDQo+ID4gPiByYXRoZXIgc29vbmVyIHRoYXQgbGF0
ZXIgYXMgaXQgZml4ZXMgcmVncmVzc2lvbnMgZm9yIHNvbWUgcGVvcGxlLg0KPiA+ID4gQWZhaWNz
IGl0IHNob3VsZCBnZXQgYSAiRml4ZXM6IGNjZmM4OTQ4ZDdlNGQ5ICgiQmx1ZXRvb3RoOiBidHVz
YjoNCj4gPiA+IG1lZGlhdGVrOiByZXNldCB0aGUgY29udHJvbGxlciBiZWZvcmUgZG93bmxvYWRp
bmcgdGhlIGZ3IikiIHRhZywNCj4gPiA+IGFzDQo+ID4gPiBpdCdzDQo+ID4gPiBhZmFpY3MgdGhh
dCBjb21taXQgdGhhdCBjYXVzZXMgdGhlIHJlZ3Jlc3Npb24gdGhhdCBpcyBrbm93biBzaW5jZQ0K
PiA+ID4gbW9yZQ0KPiA+ID4gdGhhbiB0aHJlZSBtb250aHMgbm93DQo+ID4gPiAoaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvYWxsL1pzVGg3Snl1ZzdNYlpzTEVAbWRwc3lzLmNvLnVrLyApLg0KPiA+
ID4gDQo+ID4gPiBCdXQgbm90ZSwgaXQgc2VlbXMgaXQgZG9lcyBub3QgZml4IHRoZSByZWdyZXNz
aW9uIGNvbXBsZXRlbHkNCj4gPiA+IGFjY29yZGluZw0KPiA+ID4gdG8gTWFyYydzIHRlc3Rpbmcu
DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWnVDQjk4RFNkdEtDZ3hhTEBtZHBz
eXMuY28udWsvDQo+ID4gPiANCj4gPiA+IE1hcmM6IElzIHRoYXQgc3RpbGwgaG93IHRoaW5ncyBh
cmUgd2l0aCBjdXJyZW50IG1haW5saW5lPw0KPiA+ID4gDQo+ID4gPiBDaWFvLCBUaG9yc3Rlbg0K
PiA+ID4gDQo+ID4gPiANCj4gPiA+IE9uIDIyLjEwLjI0IDEyOjU2LCBUYWthc2hpIEl3YWkgd3Jv
dGU6DQo+ID4gPiA+IE9uIE1vbiwgMTQgT2N0IDIwMjQgMTE6Mjk6NDAgKzAyMDAsDQo+ID4gPiA+
IExpbnV4IHJlZ3Jlc3Npb24gdHJhY2tpbmcgKFRob3JzdGVuIExlZW1odWlzKSB3cm90ZToNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBPbiAyMC4wOS4yNCAwODoyNywgQ2hyaXMgTHUgKOmZuOeomuaz
kykgd3JvdGU6DQo+ID4gPiA+ID4gPiBPbiBUaHUsIDIwMjQtMDktMTkgYXQgMjM6MjUgKzAxMDAs
IG1hcmMucGF5bmVAbWRwc3lzLmNvLnVrDQo+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuDQo+ID4gPiA+ID4gPiA+IGF0dGFjaG1lbnRzIHVudGlsDQo+ID4gPiA+ID4g
PiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiA+
ID4gPiA+ICBIaSBDaHJpcyBhbmQgTHVpeiwNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+
IFdoYXQgd2VyZSB5b3VyIHRob3VnaHRzIG9uIHRoZSBmaW5kaW5ncyBpbiBteSBlbWFpbCBkYXRl
ZA0KPiA+ID4gPiA+ID4gPiAxOHRoDQo+ID4gPiA+ID4gPiA+IFNlcHRlbWJlcj8NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IEkndmUgcHJlcGFyZWQgdGhlIHNhbWUgZW52aXJvbm1lbnQgKEtlcm5l
bCB2Ni4xMSArDQo+ID4gPiA+ID4gPiBNVDc5MjFBVU4NCj4gPiA+ID4gPiA+IGRvbmdsZSkgdG8N
Cj4gPiA+ID4gPiA+IHJlcHJvZHVjZSB0aGUgaXNzdWUsIGNvbGxlY3RlZCBuZWNlc3NhcnkgbG9n
cyBsb2NhbGx5IGFuZA0KPiA+ID4gPiA+ID4gYWxzbw0KPiA+ID4gPiA+ID4gaW5pdGlhdGVkIGFu
IGludGVybmFsIGRpc2N1c3Npb24gdG8gY2xhcmlmeSB0aGUgcm9vdCBjYXVzZQ0KPiA+ID4gPiA+
ID4gb2YNCj4gPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiA+IHN5bXB0b20uIFdlJ2xsIHJldmll
dyB0aGUgY2hhbmdlcyBiZXR3ZWVuIHR3byBmaXJtd2FyZQ0KPiA+ID4gPiA+ID4gKDIwMjMwNTI2
LzIwMjMxMTA5KSBpZiBpdCdzIGEgYnVnIG9yIG5vdC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gSXQgbWF5IHRha2Ugc29tZSB0aW1lIHRvIGludmVzdGlnYXRlLiBJJ2xsIGxldCB5b3Uga25v
dyBpZg0KPiA+ID4gPiA+ID4gdGhlcmUgaXMgYW55DQo+ID4gPiA+ID4gPiBwcm9ncmVzcy4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBKdXN0IHdvbmRlcmluZzogQ2hyaXMgTHUsIGFuZCBNYXJjLCB3
aGF0J3MgdGhlIHN0YXR1cyBoZXJlPw0KPiA+ID4gPiA+IEZyb20NCj4gPiA+ID4gPiBoZXJlIGl0
DQo+ID4gPiA+ID4gbG9va3MgbGlrZSB0aGVyZSB3YXMgbm8gcHJvZ3Jlc3MgdG8gZml4IHRoaXMg
cmVncmVzc2lvbiBmb3IgYQ0KPiA+ID4gPiA+IHdoaWxlLCBidXQNCj4gPiA+ID4gPiBpdCdzIGVh
c3kgdG8gbWlzcyBzb21ldGhpbmcsIHRoYXQncyB3aHkgSSBhc2suDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gQ2lhbywgVGhvcnN0ZW4NCj4gPiA+ID4gDQo+ID4gPiA+IEZXSVcsIHRoZSBzaW1pbGFy
IGJ1ZyB3YXMgcmVwb3J0ZWQgZm9yIHRoZSByZWNlbnQgNi4xMS54IGtlcm5lbA0KPiA+ID4gPiBv
bg0KPiA+ID4gPiBvcGVuU1VTRSBUdW1ibGV3ZWVkLCBhbmQgdGhpcyBwYXRjaCB3YXMgY29uZmly
bWVkIHRvIHdvcmsNCj4gPiA+ID4gYXJvdW5kDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBjcmFzaCBh
dCBib290Og0KPiA+ID4gPiANCj4gPiA+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTIzMTU5OV9fOyEhQ1RS
TktBOXdNZzBBUmJ3IWpZeUgyb3ViQkV0SUtYbUtsOWNJMnJybUstN2tTZGFpSUpROHhINE5aYTVp
NVlDVFFESGFvT3hDQmhNZ2RBQVk2Uk9JUEFvUHdiT1YtTE5lTVJKQmxSNnUtQXMkDQo+ID4gPiA+
IA0KPiA+ID4gPiBJdCdkIGJlIGdyZWF0IGlmIHlvdSBjYW4gZ28gYWhlYWQgYW5kIG1lcmdlIHRo
ZSBwcm9wZXIgZml4IHRvDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiB1cHN0cmVhbS4NCj4gPiA+ID4g
DQo+ID4gPiA+IExldCBtZSBrbm93IGlmIHlvdSBoYXZlIGFub3RoZXIgcGF0Y2ggdG8gdGVzdC4g
IFRoZW4gSSBjYW4NCj4gPiA+ID4gY3JlYXRlIGENCj4gPiA+ID4gdGVzdCBrZXJuZWwgcGFja2Fn
ZSBhbmQgYXNrIHRoZSBidWcgcmVwb3J0ZXIgZm9yIHRlc3RpbmcuDQo+ID4gPiA+IA0KPiA+ID4g
PiANCj4gPiA+ID4gdGhhbmtzLA0KPiA+ID4gPiANCj4gPiA+ID4gVGFrYXNoaQ0KPiA+ID4gPiAN
Cj4gPiA+IA0KPiA+ID4gDQo+ID4gDQo+ID4gKioqKioqKioqKioqKiBNRURJQVRFSyBDb25maWRl
bnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQo+ID4gVGhlIGluZm9ybWF0aW9u
IGNvbnRhaW5lZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55DQo+ID4gYXR0
YWNobWVudHMpIG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxlZ2VkLCBv
cg0KPiA+IG90aGVyd2lzZQ0KPiA+IGV4ZW1wdCBmcm9tIGRpc2Nsb3N1cmUgdW5kZXIgYXBwbGlj
YWJsZSBsYXdzLiBJdCBpcyBpbnRlbmRlZCB0byBiZQ0KPiA+IGNvbnZleWVkIG9ubHkgdG8gdGhl
IGRlc2lnbmF0ZWQgcmVjaXBpZW50KHMpLiBBbnkgdXNlLA0KPiA+IGRpc3NlbWluYXRpb24sDQo+
ID4gZGlzdHJpYnV0aW9uLCBwcmludGluZywgcmV0YWluaW5nIG9yIGNvcHlpbmcgb2YgdGhpcyBl
LW1haWwNCj4gPiAoaW5jbHVkaW5nIGl0cw0KPiA+IGF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVk
IHJlY2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZA0KPiA+IG1heQ0KPiA+IGJl
IHVubGF3ZnVsLiBJZiB5b3UgYXJlIG5vdCBhbiBpbnRlbmRlZCByZWNpcGllbnQgb2YgdGhpcyBl
LW1haWwsDQo+ID4gb3IgYmVsaWV2ZQ0KPiA+IHRoYXQgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBl
LW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlDQo+ID4gc2VuZGVyDQo+ID4gaW1tZWRp
YXRlbHkgKGJ5IHJlcGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNv
cGllcw0KPiA+IG9mDQo+ID4gdGhpcyBlLW1haWwgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMp
IGZyb20geW91ciBzeXN0ZW0sIGFuZCBkbw0KPiA+IG5vdA0KPiA+IGRpc2Nsb3NlIHRoZSBjb250
ZW50IG9mIHRoaXMgZS1tYWlsIHRvIGFueSBvdGhlciBwZXJzb24uIFRoYW5rIHlvdSENCj4gPiAN
Cj4gDQo+IA0K
