Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=210.61.82.184
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792632313;
	b=iptvC+vUWCHpaatz8pBWkpnpkQZcjYev/94KPsaXdItRWoOhshR1EU0j1O5Bl4/mQM9K
	 zBvBdGNC1Qwl6KEW09dmddM69hyMoAtPgeW+x+wX7hlwmE28ySOEpTflNiAoLtvAKrfri
	 d2YI+PGORNrgqa3PkFzWiZxIofJwveRKcQ410wBNnXGPhjMefmlPf58MIh9ICBIsafZ5p
	 GfRXwVJg+07Z+88e0oz+rA8ye32BtkqySoqjRJBgN+Fv+CNTC4WMzwL4y0JpNy0uAqjPo
	 kpYe0LhedH+gJpOspVVha4/bpFPJgThAycmvLG7DSXzdYiqgGEo6ypFH0k0POf3WayQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632313;
	h=DMARC-Filter:X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:
	 X-CID-META:X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:Received:
	 Received:Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=pqpxcFvBnMDX+/yGP1+tHwKcSk46qenQ0tmb3h9Os5s=;
	b=uNvQKKmO6/eem40LWof04gODNIUaryXY7GAjeLxE/lqjFGouYDIftTDcw1rzPcUbZrJQ
	 jrjctbfRMdkHsN00sNqSCTQNEpWNJnNgTsCz9z3XSxs/X3ske8d4UDntrdDlVrUJvRcU9
	 O/sfZMlelcKLX+9regd0nRY/AcvnXAUTym0TWwvZ/Rldbz1WYTpwS164tVK5T0GZZuyEF
	 VvBuJq8YxsWeA/hRKtUOo9b2BPJb4xLlyMNgej2cMx+ygMCLTlr75cvse05QcTDrgR6ak
	 qDIGIaD+8ZKItYYjVhe+OGa+gkYuzLVvkAq010XUZjD7hUnCEePjM6arvD5X5Bfz97A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mediatek.com;
	spf=pass smtp.mailfrom=mediatek.com;
	dkim=pass header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=BTYnDepr;
	dkim=pass header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=VvmLZ8u2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=210.61.82.184
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797F7606A319;
	Thu, 22 Oct 2026 01:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 797F7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=BTYnDepr;
	dkim=pass (1024-bit key, unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=VvmLZ8u2
X-UUID: 6ac45922cdb711f18dc8c9802ae25ab1-20261022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pqpxcFvBnMDX+/yGP1+tHwKcSk46qenQ0tmb3h9Os5s=;
	b=BTYnDeprqXBcQ+lw+HuY7Qj5JowEd60pdisIv6WUs5DcqNLWK4vM3GBWbpA56bOxZnE6uB4nQC0d8ZNVXqtiPigr+7tnlr2+zsRbPuQaHbk6ZH3q1F9QQwMRX+k7vUQcMEvDx46+RVNpQO2tkUg7IEh10eyTOoa2MJQ4FHl2E8E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.20,REQID:62341839-766f-4d50-8202-77538af14012,IP:0,U
	RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:291e20b,CLOUDID:c1bbee06-3b2f-4b41-bf53-7ff4ced90a1a,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:99|11|95|82|106|80|1,File:130,RT:0,Bu
	lk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0
	,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6ac45922cdb711f18dc8c9802ae25ab1-20261022
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1152866791; Thu, 22 Oct 2026 09:25:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 22 Oct 2026 09:25:06 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 22 Oct 2026 09:25:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvlsekSF92Dy8CocJd7HZz4nS6FbdbyE6nYg0ggHX/AU2CaGFJ7miZyh76YJfk0TCh6ecuvSPJSlKNQ6uNFC/U6Zuql7ppDFDN6B2XT3pMwalOwj0aX2u/klmFYfgAwJaKquv0r66kt/dpocTPr8JsO+0cHhFMRj2X+cpIxxqh38mRVLMYI7UeDugkXgIj702wvVXRIU4rA7g+ttSH+OoUjqaWIRZw/6IQaNnA9o+YC+L+ZFeoRfjJ0KDdT8xIhXlgNfIFWYh0f7U/f6qxfJVcvANkJ371DejjNULLE87LbMiIQQMzuFf0QEUk00D2E0NiMXAfQSHF4UIxpCf/Z8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqpxcFvBnMDX+/yGP1+tHwKcSk46qenQ0tmb3h9Os5s=;
 b=aQABwGBS3wpUKHIYn7F6wDp2xXKY5DAs2uyxl1QLhjwX1rAqARm+XIt4IbsogKaYotTlQ8QEATCED3Sfng0JehLAtXziRNKKFlAPuSunPSUQpuFeKixcz8i/VQOI10pmQA18dOCv0bjr6t6qdAk/Ppi+kw+HTqfOLQRJhee0Ju5RHax7C0tJgdiH0/II7ua5+lmJsdGDX5PzKhQU1jg0kTUWQ9TUmTzBJG+4c4usQhlufQededOg0rV95kQMCgySM9SSTXhxnuCuNsi7xH9w2luTJFD8Uj+r1RWP6HFaxVhowpH4EYCUzSFyFvy4ypG8QPlfQ8m4ABX+6XHyu2+Weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqpxcFvBnMDX+/yGP1+tHwKcSk46qenQ0tmb3h9Os5s=;
 b=VvmLZ8u2tBttyPDmzsYMQZ54A+JO5Z2a1+neVW+co4ZHBIJcdjln8N0tW4zlMTH2z+UtLJS9aYkVGrKuMi6wiTL4TN0jh9JdjS7tL5L6LXfmEZ9RT8HtxBYx4AzlioYqgSiCwgaHFs9Oyt0ZNxhKJTY48+U1Apnar0mwudxUSls=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEYPR03MB8105.apcprd03.prod.outlook.com (2603:1096:101:16b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 01:25:03 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 01:25:03 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: =?utf-8?B?SGFvIFFpbiAo56em5rWpKQ==?= <Hao.Qin@mediatek.com>,
	=?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	=?utf-8?B?V2VubG9uZyBUaWFuICjnlLDmlofpvpkp?= <ot_wenlong.tian@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, Sean Wang
	<Sean.Wang@mediatek.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 RESEND 0/3] Bluetooth: btmtk: fix ISO data reception
Thread-Topic: [PATCH v3 RESEND 0/3] Bluetooth: btmtk: fix ISO data reception
Thread-Index: AQHdYThIelTq7WK3Tk6xmIjTVF5xUrcIDSWAgAC4vAA=
Date: Thu, 22 Oct 2026 01:25:03 +0000
Message-ID: <da3104c527964d3f29f4bfee9e332364994d623b.camel@mediatek.com>
References: <20261021084337.1515468-1-chris.lu@mediatek.com>
	 <CABBYNZKqAa+3V1k3U-NBodfAhYRV3ZqX4V7bp5NFrXY0ndgL7Q@mail.gmail.com>
In-Reply-To: <CABBYNZKqAa+3V1k3U-NBodfAhYRV3ZqX4V7bp5NFrXY0ndgL7Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEYPR03MB8105:EE_
x-ms-office365-filtering-correlation-id: a1edb62b-3ead-479c-aa49-08df2fdb4c5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|261021123027099003|56012099006|4143699003|11063799006|38070700021|261021133027099003|261009223027099003|10067099003|261021130227099003|22082099003|18002099003|6133799003|261021135927099003|261021121427099003;
x-microsoft-antispam-message-info: Z/8rkmnlTNEK/0E5YlYvLBiUBq2E2IOcA5NX+LGYBiGUFm9KmkPvb5/ZYwgbgUUCG5GgtB0hcMgQP19UMCyxLC+NoCXny/RwimDZFw+c3kjJv6WzQCnxHWLaBRXVXdYjvZMqqL6rawPftmjmwKkBsgePx6yF/IPCW9NesmjRHUhhXudIA6vpy+znaprmfYz1cAsQyaoludYrsae0dG3LaZbnDKjcvBvS0U+VhfzW4iRF7Q6KYMpR+fW5K0ZqGPE1W+GxJUrUMru4PeWKdQ1vV8DTTIB2aX55c/PvHVlki/LU47iUlSC/NLCZ8K+cGGNBKbew/R+Zu43wPXhkMhlPmXAzQrxk6Yp0+rY+5XHUVt9cE3sFvmajfMKn0DIQA5W7LXs/FS6aGhLSxTWAKphzgN3knZzdyDQ1uccCdPYXYv4jhOLesc/ChHj6dbfb5xnjPRqhLyqWRwzbHPUYxzg/mesTib9+ybEGvNC0ibGYQP2Vjbe5ti1agNeVK7y1+dHU1110W31CUzUd5F+WhnJfNaqkkeT+tnHrfSyXp3znYF1mqzgu3UArb0bjq4R9FrUcPSPjxek7KrWNmLaGEBWmhkm/rjkJUSWTDvDobFKI8H85W82iH5ltq6qS4oDjorZ6hHtWMEP4SyiqjgasTzo1FGcvRVb44AjSxWJtQMhnb10=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(261021123027099003)(56012099006)(4143699003)(11063799006)(38070700021)(261021133027099003)(261009223027099003)(10067099003)(261021130227099003)(22082099003)(18002099003)(6133799003)(261021135927099003)(261021121427099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3psZWxzRzcrdVhydDRQVE12VFduU0ZhejF5WDRmZU9SUHdFcVRWbTFLUWtG?=
 =?utf-8?B?R0FHNnlMbVlQUTlqbDRSdXluYzMwSVpkN3RqR0dwOURQR3Bod0VzdEExV0Ev?=
 =?utf-8?B?YkM4bzlMZ1FIRnZZck5VYXIvcjQ4YmtaVjVmZlZ5Z1IwdDE0Wlc4Ym1YaVY1?=
 =?utf-8?B?QVFDUHZ3Q0MwVkczNmVnSWovbnVROW4wY0ROVHdtZUpvQkplclk4QzhwT2dY?=
 =?utf-8?B?dTZQaTNZak9aUUtzQVpsSjVjbjNKTEFsdEpnTThZam1QTzVOajkyN25ja1lz?=
 =?utf-8?B?cVZ2RVc5UXBjbFVCZUdzeXlCUjZuOGo4RGgyMWw5STVGQ3YrRjV5cjRDZGlI?=
 =?utf-8?B?Uis1dlAySWJVNGdvTGF4QzI4VlBIS1F0VlREWDVHb2NiY1N6TDN3UkplM0xz?=
 =?utf-8?B?eEY4WWtLaitrNCtKdUpTT1BEM2RyUjZHcEFWVDdNVFdYQXBSRnl2K1UxMWFC?=
 =?utf-8?B?MjBjQUw1WmkrbWJkRlRveUtFR0dmaElPU1V6b1ZFN2Jmb1U2cXhwTmtWTmhl?=
 =?utf-8?B?bTBYS0x6VzkrL1c1ejhRNGxUSzB4ZWxuc0xaMXR5eTFCajJTeTFjNUlIN0lm?=
 =?utf-8?B?U1dRcERnTmcwNmsyUWkvRzh4emhSeHJWbTJpM3FJeENQbzdzUm8zSWMwVDZ0?=
 =?utf-8?B?NFVHNk1zUmF5MkVsQ3Zvelh0OTFlS3FQa0hRQWYyYldMaVRFMnhjNnV6UUtr?=
 =?utf-8?B?SVAzU2hxMjQrTDVrTUlyTWhnZVRzTzNROUltRUJyMlUwelFFY3NQNXU2ZE5X?=
 =?utf-8?B?b2lZUW9LYm5zNVBWY2R5MHdhZGcvSjREVm5jNklVVG42Si9UdXNDRDZVWm8r?=
 =?utf-8?B?VkFEYU5MK0lEU0d3R3oxK1JJM0lJYUVaWEZGK0hPczNzZy9jZmdRWmFGV3Fx?=
 =?utf-8?B?S3h5MHRjM29hb1EyR3ZPYTgyeWhhK3JscXhFQjdxdmRkU1hITjFjWitUNkJ3?=
 =?utf-8?B?cENaQ1g5VU1RT241dWUzaEpXRk1LVGc2VldsUWp3OXlReVM4emVWRHlEa3di?=
 =?utf-8?B?aWNTQUtwdFp4U1VJS1ZYbUY2S3hlcU1JVG51S1hXQWR5ZGM5RWNMTzFpem92?=
 =?utf-8?B?WEVEZUsyNnRqWnU2dm5lM2hxOU5oK3p6LzFRUnE4NkpLd1pMd1RCMVRMZzdR?=
 =?utf-8?B?Z3dEb0gzZUJ6L1l2YkgyQTVxWllPSGM3OXFWTUFVcGhwOGJVV2xhUXQyMnps?=
 =?utf-8?B?bXlpaDRhVGhZbHdCN3dpNmwvblA0MFlMWGUxQmUzcS9qOFdha05ZVUlTNXFx?=
 =?utf-8?B?bHdJZDRIQVdnMlNHbEIzY3cwdTArNSt6a2p6SmYvc1FmVkF1WEVFa0QxdmV4?=
 =?utf-8?B?WjVQU2s5MUZFSHczY1R4SUNMalA0R1pWT21TVzh4Mm1BazFPRnVHZkdRK29K?=
 =?utf-8?B?MUtjOElRSjM1ZXo2Zk00OTF5c0l0bEdSemU5ZzY1T0hRcHEzLzJhYzhBL2Va?=
 =?utf-8?B?LytLZ2h2eGlSa3lRd2xKTXdpOXZXQndhM0krbm1nZjZiSkozTnliTjgvL3Rv?=
 =?utf-8?B?b0pmdlZZV3NrbDNOQWJNSSszOFMwTGFhQTI1TE01eHRzNy84d3k3bEpUdmdX?=
 =?utf-8?B?aXR4UTI3VUp0Nk1JSm9WN0ZmNFNwYmNkMitKY3d3SVBqS0lldlhLanpObFAz?=
 =?utf-8?B?WDJIZVA0OEFIUzFiQXBZZGU1aWJXaEM0bE1MRDdnaEV1czBrT0ZPbkovTDdk?=
 =?utf-8?B?TXpoNGx1WkJ0cSswR2I1QWpkcUhESHlXellFNkd4NGtsRzNCblBoV3JPK1px?=
 =?utf-8?B?THNvRkVtN0g5NllUbk1TN2tydXpiUXM4TUVDdTFSaVdFWVhKaStEbHNmNkpy?=
 =?utf-8?B?RDRXZFBHbWt4Qkw0bkxUKzRMYkJNN25MRlAwZVdsdXpOTU5aY1VjbjlQdVdI?=
 =?utf-8?B?R2F4aXdTY2VobERVVTBCNWI2cWVzcW9wRG9reHN1dzF1TUZYOFRlMmRVQjRG?=
 =?utf-8?B?RUwzMWdiSGJFUUNxc0IxcU9JOVhVVkVMTGE4K2ZlTms1OTM5NVZBMEUrWjNW?=
 =?utf-8?B?NTY3MytpNXNMc2tEUFdvUHlkZVYyYkpUUEsxSEJYNFY4endkYTJ5UE9lMDZu?=
 =?utf-8?B?NTR5dkhGMDQvbGI4MG5pTngvOUhuRHVva2VmU3c1NzY3eWRZRTZiSThhQisy?=
 =?utf-8?B?YWE0V3BmOHg4dXFiakUxUFpUUGhCdW4yc1dsRFY1ajY4VHFoQTBTMkxqZTBk?=
 =?utf-8?B?cXM2YklXK1VKd0pUQUVOb0xJS1ZPcmdES25jeEt1L0pzaWJUaVVhVWZydFZH?=
 =?utf-8?B?cnZ6MzBIM0F4NzhrVVUyQ1hOWFgrNFQ0SXV2Q0RXYm5BYStlY0dqVnJ0NWs1?=
 =?utf-8?B?d2lWaGpid1lvK1Blb2xuR2V1enNaMVJUVndReGczNzVVSWFNdXk3WVMvUGNP?=
 =?utf-8?Q?RFZ29t7GyTu+iCNI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7309BD3AEEB70458117E5D3D323928E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KhDJap9LB9dbWDlUOm1kD5xsAytn6SnCa/qhefdbR5jS/gQFiQR68IywnghBbyqk/JJmF9icXgqxUoUtxDaAjbwREXtMkllY8HbmRxwmGlLJZtiCq6lZBDbcISS6ATgG0LLcozQqddC3TszKPFKc5wPRVVfT2oSR9gflYaVcKlqdbNkL8ZXoG6ZcmsJV6RsO+BbOGDL4RudKI36j23sjhTh8oWlDW8Q9MXg8CRoEgO5rJ9t4i4WFyVG9g8Ygr5iuZHb7oL0G4e2woc0qgC5UZJjHhpW+zuqEPhBT8IKi/xNOcV09rknUZjdG9DhN/zv6ecJBOrPmUOoB1uGXvyqvxg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1edb62b-3ead-479c-aa49-08df2fdb4c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 01:25:03.4997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04y/TBObXl93KOyC/lXpRbCOCSWmizQNojWZMLs2jWlShSg6xaPm+BxoQ9KSEgvKfnEvqRBKqMclFXGUDL/P/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8105

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciB0aGUgcmVtaW5kZXIsIEkndmUgbm90aWNlZCB0aGUgcmVz
dWx0cyBvZiBTYXNoaWtvJ3MgcmV2aWV3Lg0KDQpPbiBXZWQsIDIwMjYtMTAtMjEgYXQgMTA6MjMg
LTA0MDAsIEx1aXogQXVndXN0byB2b24gRGVudHogd3JvdGU6DQo+IEhpIENocmlzLA0KPiANCj4g
T24gV2VkLCBPY3QgMjEsIDIwMjYgYXQgNDo0M+KAr0FNIENocmlzIEx1IDxjaHJpcy5sdUBtZWRp
YXRlay5jb20+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IFJlc2VuZCBkdWUgdG8gcmViYXNlOiB0aGUg
YmFzZSB0aGlzIHNlcmllcyB3YXMgcHJldmlvdXNseSBwb3N0ZWQNCj4gPiBhZ2FpbnN0DQo+ID4g
bm8gbG9uZ2VyIGV4aXN0cyBpbiBibHVldG9vdGgtbmV4dCdzIGhpc3RvcnksIHdoaWNoIGlzIHdo
eSBpdA0KPiA+IGZhaWxlZCB0bw0KPiA+IGFwcGx5LiBSZWJhc2VkIG9udG8gY3VycmVudCBibHVl
dG9vdGgtbmV4dDsgbm8gY29udGVudCBjaGFuZ2VzIGZyb20NCj4gPiB2My4NCj4gPiANCj4gPiBU
d28gZml4ZXMgZm9yIGJ0bXRrX3JlY3ZfaXNvcGt0KCksIGZvdW5kIHdoaWxlIGRlYnVnZ2luZyBM
RSBBdWRpbw0KPiA+IG9uDQo+ID4gTVQ3OTI1LCBwbHVzIGFuIHVwZGF0ZSB0byB0aGUgSVNPIGRh
dGEgdHJhbnNtaXNzaW9uIHNldHRpbmcuIFRoZQ0KPiA+IGZ1bmN0aW9uDQo+ID4gaXMgc2hhcmVk
IGJ5IGV2ZXJ5IE1lZGlhVGVrIFVTQiBjb250cm9sbGVyIHRoYXQgc3VwcG9ydHMgSVNPIGRhdGEs
DQo+ID4gc28gbm9uZQ0KPiA+IG9mIHRoaXMgaXMgc3BlY2lmaWMgdG8gdGhhdCBwYXJ0Lg0KPiA+
IA0KPiA+IFBhdGNoIDEgZHJvcHMgdGhlIHplcm8gcGFkZGluZyB0aGF0IHRoZSBJU08gaW50ZXJy
dXB0IElOIGVuZHBvaW50DQo+ID4gYXBwZW5kcw0KPiA+IHRvIGVhY2ggdHJhbnNmZXIgaW5zdGVh
ZCBvZiBwYXJzaW5nIGl0IGFzIElTTyBwYWNrZXRzLg0KPiA+IA0KPiA+IFBhdGNoIDIgYm91bmRz
IERhdGFfVG90YWxfTGVuZ3RoIGJ5IGhkZXYtPmlzb19tdHUuDQo+ID4gDQo+ID4gUGF0Y2ggMyB1
cGRhdGVzIHRoZSBtdDc5eHggSVNPIGRhdGEgdHJhbnNtaXNzaW9uIHNldHRpbmcuDQo+ID4gDQo+
ID4gVGhlIHRocmVlIGh1bmtzIGRvIG5vdCBvdmVybGFwLCBzbyBhbnkgcHJlZml4IG9mIHRoZSBz
ZXJpZXMgYXBwbGllcw0KPiA+IG9uIGl0cw0KPiA+IG93bi4NCj4gPiANCj4gPiBDaGFuZ2VzIGlu
IHYzIFJFU0VORDoNCj4gPiAtIFJlc2VuZCBkdWUgdG8gcmViYXNlLiBObyBjb250ZW50IGNoYW5n
ZXMuDQo+ID4gDQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIFBhdGNoIDE6IGluc3RlYWQgb2Yg
ZHJvcHBpbmcgYSBwYWNrZXQgc29sZWx5IGJlY2F1c2UNCj4gPiBEYXRhX1RvdGFsX0xlbmd0aA0K
PiA+IMKgIGlzIHplcm8sIGFsc28gY29uZmlybSB0aGF0IHRoZSByZXN0IG9mIHRoZSB0cmFuc2Zl
ciBpcyB6ZXJvLQ0KPiA+IGZpbGxlZA0KPiA+IMKgIGJlZm9yZSB0cmVhdGluZyBpdCBhcyBwYWRk
aW5nLg0KPiA+IC0gUGF0Y2ggMiwgMzogdW5jaGFuZ2VkLg0KPiA+IA0KPiA+IENoYW5nZXMgaW4g
djI6DQo+ID4gLSBQYXRjaCAyIHJld29ya2VkIGFuZCByZXRpdGxlZC4NCj4gPiAtIFBhdGNoIDMg
YWRkZWQuDQo+ID4gDQo+ID4gQmFzZWQgb24gYmx1ZXRvb3RoLW5leHQuDQo+ID4gDQo+ID4gQ2hy
aXMgTHUgKDMpOg0KPiA+IMKgIEJsdWV0b290aDogYnRtdGs6IGRyb3AgemVyby1sZW5ndGggSVNP
IHBhY2tldHMgZnJvbSBlbmRwb2ludA0KPiA+IHBhZGRpbmcNCj4gPiDCoCBCbHVldG9vdGg6IGJ0
bXRrOiBib3VuZCB0aGUgSVNPIHBheWxvYWQgbGVuZ3RoIGJ5IHRoZQ0KPiA+IGNvbnRyb2xsZXIn
cyBNVFUNCj4gPiDCoCBCbHVldG9vdGg6IGJ0bXRrOiBkZXJpdmUgdGhlIGZpcm13YXJlIElTTyBz
ZXR0aW5nIGZyb20NCj4gPiDCoMKgwqAgTVRLX0lTT19USFJFU0hPTEQNCj4gPiANCj4gPiDCoGRy
aXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLQ0KPiA+IC0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCsp
LCA1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IC0tDQo+ID4gMi40NS4yDQo+ID4gDQo+IA0KPiBT
YXNoaWtvIGlzIHN0aWxsIGZsYWdnaW5nIGEgcHJvYmxlbToNCj4gDQo+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL3Nhc2hpa28uZGV2LyovcGF0Y2hzZXQvMjAyNjEwMjEwODQz
MzcuMTUxNTQ2OC0xLWNocmlzLmx1KjQwbWVkaWF0ZWsuY29tX187SXlVISFDVFJOS0E5d01nMEFS
YnchaGVKNFE3Sk5VR1A3a1UwSTFiLVZZYWNXWFF0WXpYTlVOaHN1V1ZlcUJTek95TXc4ckllcUpf
V0pWMTg3aDBub0hVaTN4ekdMd0hHbGN2V21DSUEkDQo+IMKgDQo+IA0KDQpJJ2xsIHNlbmQgdGhl
IG5leHQgdmVyc2lvbiBhZnRlciBjb25maXJtaW5nIG15IGZpeCBpcyBlZmZlY3RpdmUgYW5kIGFs
bA0KYmFzaWMgZnVuY3Rpb25zIHdvcmsgbm9ybWFsbHkuDQoNClRoYW5rcywNCkNocmlzIEx1DQoN
Cg==
