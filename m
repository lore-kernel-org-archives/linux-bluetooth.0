Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011025.outbound.protection.outlook.com [52.101.70.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2793254B3;
	Mon, 17 Aug 2026 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786947826; cv=fail; b=ZYn6FZIGx1Hi+nss6uB2DX3V2+GHv/FxSdt883HmQkN1+BbdYCZi4JdxQW5MpCPeogN4gZhLnSdwnF2a/TdVJ22oTen98lymW7pI/FX7aR8kry+mlxSeCtZ/sIV4LR83NIWG3d2/CCKQ7mH4MS4O/OOuX70bLwJEuMuL0gmnWeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786947826; c=relaxed/simple;
	bh=ddo+smsms5JgeCwu/6TCA+lKJNvowr25rSfmAffAERI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rz3wdIRptLEcL9HXVgftA3NSkNYwpF9N6rlYSDnv+2gXPzWPzmhlIyiHv0nzmE/mnFIhtZJ9qsZBbxAUNlMy63dv/QS3lmlT2UxfCqV3FevMOX4IjjE8FkODiI9YFT/92rTgPXOqR1bMFGQUXfwpGuqA2wlMAdcl3vFahYC6HHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c5WhUOJc; arc=fail smtp.client-ip=52.101.70.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c5WhUOJc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLk/DXb8lyoOTVbs9jCU6VN8H1HqtIOPMentgtDv9uZ26jn0H7jgBv6AAAs5ZNHXa485sKN48qHTbOL5AQLd1Xwh3NAZAOj94tyuErnYWy5S4A3jeEYCOBZ88/AZVvS/gy2LQrsdtK54kha6XRmAmvfbRNNkYZqaut4GtXyFLa8mTZYxgWFvsF8UwNINYl2FdmuwAquMqtfoIleVvQ9QyxI3K8BSkjg4OCbxnSDfsTOEh23m8KUPh4r48IOPxKUGhZ8hi3GAwmurnc5rI5bh44Nq08TiT55YuJEGauFmSOKN9kdSwSHL0DUwa6iNsXdE4utx1x/M32Plzh9pUcuURA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddo+smsms5JgeCwu/6TCA+lKJNvowr25rSfmAffAERI=;
 b=i9yi2AbZqaowo6vAZWyxCzy9SlUtrtqk4VhCZawYo2CWcDamBjXEgMI/ZpqH/0BY9D1IUritwkqVASDhXJWweeQaJ1v7RmrKkHG+lFYmbHOjuCdmtT4y2jPVgIlb4eJj1WJBjJR8stoCUrPG6VMBXvtUcIQz0uJBkdb6wYj72/EiEOtCJZjNAm50fxDLuhwPw5ie3lp7W/dh4AmvID6hSxt8HOFNfAHEyBkKDxs96JlBplBK6aTMyu7+EKfv0Yu/ayGAijGQ6jcq7TUuOo+HcuqYnkVSCUGU659XEdteNhxRTEm59JgDuGRHhjRRRtnTIdXojzp0Fjfpklq9kfaZWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddo+smsms5JgeCwu/6TCA+lKJNvowr25rSfmAffAERI=;
 b=c5WhUOJcw4ZU27WCrfBbN1sTQFJp4hlbb5T3UR4GqC5Gdz2tXFpKnQ1+yXFdIun3W0cmGf3kH7D8+IH95PhmS5T2B1jNslRHDy6Y9YJvxsZrO20pBthZYNH5Lkrwmvs9pmNO411lfkmuo3DU2dp0wv9MfprRgQ5yzP3EVmKP421R+pPg2qGh50Gworut+zpL11HQl9caKuichqAedecN9EBVlZ3VqkO/VdptagMqY6cpbAZNys71eUz0Tz36CXFN6KhTjMbfZc3PtUycZj9y021MWCVQURDGtc0HZk5z/T7scwXqhTnnpb0hgB4B6BhMydqwqxnJfX40QE4MezYEtg==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8670.eurprd04.prod.outlook.com (2603:10a6:102:21d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:23:41 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:23:41 +0000
From: Neeraj Kale <neeraj.sanjaykale@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Ali Ahmet Memis
	<ali@iusegentoo.com>
CC: Amitkumar Karwar <amitkumar.karwar@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, Alex Zhou <alex.zhou@nxp.com>, Song Xue
	<song.xue_1@nxp.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: btnxpuart: Validate the FW dump header
 length
Thread-Topic: [PATCH v2] Bluetooth: btnxpuart: Validate the FW dump header
 length
Thread-Index: AQHdLhDyheaZl7LkckiPYVv6aHvtZA==
Date: Mon, 17 Aug 2026 06:23:40 +0000
Message-ID:
 <AS4PR04MB9692EC13E3176B6D7525D097E7A72@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260814081221.913676-1-ali@iusegentoo.com>
 <20260814084110.920879-1-ali@iusegentoo.com>
 <CABBYNZKVQ0CxsviF92iP1Hj2rBiH_hmmEHirp8D=b-DvuaTNeA@mail.gmail.com>
In-Reply-To:
 <CABBYNZKVQ0CxsviF92iP1Hj2rBiH_hmmEHirp8D=b-DvuaTNeA@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-08-17T06:17:35.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PAXPR04MB8670:EE_
x-ms-office365-filtering-correlation-id: e611aab3-21f6-4df2-7950-08defc2814bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003|3023799007|4133799003;
x-microsoft-antispam-message-info:
 q5XglVJztVtO62deO4RtuydY89nK/3oPmh64muLfaxpPn2oQCgtjTsdZaD1QRPmxhSUGGYmuirEXqcTYoZYQ/rSNfAMpcfsJHDdVrAyz0siRQoyt8sWkQssxKL/WarzfdaUo+3+Q0Xr7pGoiKXxKctX6F3T4EiSDckx492VHydcD7rrNcvWV8ZRoghSwSMX7R9grla1hEuODcHOUOZfqyI8G0LWMt1cKgNk93MCpk/kEKB2haNwLgp8t1/m7NAKDX6etc186AjGWZ0hdEDaq9OxZ9rwNv9AwvY731k/Tgzemmp7Q30eaSMelQKoukziH/XUr/DBH/pzXghppOxr+sqoW/b8X11lgdZzS5wQbE8i3BLcp3hpL42Sx5zKuvi4Y5ePdOf6SRCJnsoM0Hxs0JR3Uns9mkMKQ+fsC3f1AJMF1Dt1a2g2eZu3RFZoEyrpswpADNl/pE+QO+ZL+fd2WFGffKHtnXzr28UK+XYRlD63qJEfTbnOk0Kq90prk/7bgYdf6z6zP+qk+mqREAJjtoyYlFuHgZFeMXiIT1mMG5cXMngukplH1+TXL2n+yAK456Eo8rpbt6TDX/ky3Lv3lxpclpwDJgOKWPgWIRgatNrgQX6fO9jOFWMXX6t1ScpQz4T41rklp+XZEdC+JKHhYmKIZuurhlmthaN1t/4hTW9z+WGemuCASBphKvMGdsmuljQP/VEpMxgfN54Bngvtdt8N/NBeP1WynIU4r5Dj2KlU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHFYazdXekNHZFBhSHdJeklOcFV2UUxUazBKem9NVzdrWmNNbmVWZnZ0UGdr?=
 =?utf-8?B?ZmwwQnE0NWJJZ1lLZ01Zd1R0ZlFxRm84by9pbkFtNjNxaXZURjhJWktJaTlP?=
 =?utf-8?B?L1NXcTNzM0JXTGtrMHpCMEVUTWxlbjFackl2dHduUmFUSnNWcGRjS0VJU1Vs?=
 =?utf-8?B?Y2V2NjA2TmViZG9LSU5zYTVSbWt0NWVBanFYQTArN0UzZTlYSEY3Q0ZUK1B6?=
 =?utf-8?B?N3JRVHV2d1NzQjhJSmwwcDBzL0NSNzBxTG5Ib21jMllrS1BObzFDRDdiT1Ru?=
 =?utf-8?B?LzZjdXpaa0g5U3hEYXljYXI3TndCZmVZZFN3YzBMT2NqaFEvM3E0M3VSVjFQ?=
 =?utf-8?B?SlM4UmdwdHpoR2YydWZLL1Y0N2diRUdDdHA4M1FrYXY2SE81bXJLWGxjUUg0?=
 =?utf-8?B?TXplVm1ZNWJxNi83ckkzcHpBQnBSelV5cVV5UG82TVZXNk91NUVBcERBamR3?=
 =?utf-8?B?cmt2SkZRbWUxbG9TK2w1djBaT0svNmd0aWpzdzlmbTZDL1FpNm5Zd3ZiTjZ4?=
 =?utf-8?B?cjlvSE9lOGhjOGl2T25lemxoNm0wUlJZb2kwaUc1QWJwTVRKcnVRVm9Gempu?=
 =?utf-8?B?Yllaa3hJY2Zmem4xTTdPd25PRlVqQlVUNlA1bGRWNHh6bnZFcUluaGZWelpS?=
 =?utf-8?B?UUt0cEVBMTc3NGQ2dHc5UEpPOFc5MnZ3aW92aW1YZ3BzVldBWHQrYjFpUmwz?=
 =?utf-8?B?ZXVKM0pwQ2lVclZoMVVWWkpzR1FuRmZ3LzJxOVY2ei96VVc1Q1ViVXpSeUVJ?=
 =?utf-8?B?ZHpkVkFuMjQ2NHh4K1pJc0hIb2xBZGJJL293dnZ2c1I5NzZRSFRidURqcWpl?=
 =?utf-8?B?L0tQVDJ4WGRrTmVISEFqSHcrSTdUSVFGNGZZUnVILzVMSVcwcXlYU3dTSnVy?=
 =?utf-8?B?T2pmSkYrTE1Qb29lVnZpbmxzNUxtZlFqaVdpNi9KUW1pK3VlNUUybERiMHph?=
 =?utf-8?B?MVV0LzlsdUxzUFNoeXJEalowN0llRjloWXRMUS9uNU9hUEhDM05EQVZpakFa?=
 =?utf-8?B?c2ttTzZlbSt1ZzJBek92Rm14UXpIT3puVUNRS1E0c1lHYlVmVTNoZUo0VlVY?=
 =?utf-8?B?QWJ2WmRJZUZNS2NLMnhQMU1WOTE3OVkvdERiZy9KYVplRzdrdm5ZTkkrb05x?=
 =?utf-8?B?YldKai92N1BIVjdHRkk4WG4xN1JYakdvWENSWUtmb1FJNm01TTc1K1dTM0xv?=
 =?utf-8?B?b0w4Y1JyT2hGTDUxMlkvQU5ua2EyckJKUnBzZjRPVUxyeFgxMDlJZUpVdVMy?=
 =?utf-8?B?S1I2R3BuaWZOSi9YSEdmMGZyb2d0UUVCS0JndUV5clNWMG1tK1hpdDlXTUxQ?=
 =?utf-8?B?Tncwajl2NHFaQTlMa05UZVJOdXBLWnFyaUgxQm9RZU4yRUt5b2dxSHMwZkxo?=
 =?utf-8?B?bThCWE1mMkVPZ1dkTHpRVkkxS1lRdFBobktIREZTUG8wZHpRMmRveCtxL200?=
 =?utf-8?B?bis5YjAyRWp0Sy9odE1JWDk1Q3gvS04vMTJvYUpGTlJKSk9NUEw2ZW94WmNG?=
 =?utf-8?B?ek5iTGNjeDFubTRpa1pqczRMd241bm9IR3dRaTFGaXdHdGw0OEVUTDVNUkFJ?=
 =?utf-8?B?UFdqa0lsWWgzMFRVY1p2RWtWV2YyUkVWcm1jYUROME9LcldNMExKelgxU1R5?=
 =?utf-8?B?WWtQODBQQ09LOStjVkI2bjR5eHVsRndVZWhqWnE3WHlwaG8vZit1aU0rOUhB?=
 =?utf-8?B?NjJNbk90dllDZHpEWTBGcDVJY1VLcWtpZW9Mb1pBOWRQbnlxT2lUd2lnZzFY?=
 =?utf-8?B?OWlGQS9ydHpjTFlMME5ueWdyRkFzWGdwWTNVWTF1NWpKSjZmd2ZnVWEvTHNV?=
 =?utf-8?B?Q21XSC9iQjVocTRWR2lRb0k2VE5hY2crTmVpVzJFdGhnQnN5V2xKaXc3cnRq?=
 =?utf-8?B?Tkd5b1ZyT2FSc3VmWElMdWZiMExueXd0OXB0TVZoVVJOVXlYWWo0RkxWTWpz?=
 =?utf-8?B?aFR4NU1VWDdNZFRGNnhGMXZoejQrN0NSK3NPT29DV3RMdkM4bTdvdEY4WEFF?=
 =?utf-8?B?YzY4eUpSeHJCU2pTOGhmUFZFTTErZmdlMVhXYnFQSmpzVkxOVExrajZSSVVJ?=
 =?utf-8?B?aE9WbThNWGoxTGhLWXdLVjBKeXFqczU4RG1PelBXQmlySDkwcjBhSHpQa0tP?=
 =?utf-8?B?RGgwUnZVSkp1S1E4RVI5TitSQ2h5dVBKVmJLZFY5L0lHUVlYYXdjUGs4aGU5?=
 =?utf-8?B?VCtYVFZoK3p4dDhxK2dMVHlwR1dTWkk5YUg2ekZiUTNtNG1Ed2ZEYUpUcjhn?=
 =?utf-8?B?YUMwenFySzc4REpMencrYVZ2Y1czRVdreFdXc0pZQ2w0SDZpb3lZU2djVy9Y?=
 =?utf-8?B?TUd0QlJBNE1iQ1RXd2NjL0sxbmw5d3BKQjNBaC8ySUtCOFlySjVodz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e611aab3-21f6-4df2-7950-08defc2814bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 06:23:40.9377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndTt2wOJyxNarfzFxcc2umKq3EDq+/QhZOh/s1JacSWQQWkP0SoahiyM1VZmib92d5d1Kim2cq+eCzs+uU5lpUrevGmvTbFdfuuLJUXY1Jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8670

SGkgTHVpeiwNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGNvbW1lbnQuDQoNClVuZm9ydHVu
YXRlbHksIHNrYl9wdWxsX2RhdGEoKSB3b3VsZCBhZHZhbmNlIHNrYi0+ZGF0YSBwYXN0IHRoZSBk
dW1wIGhlYWRlciBiZWZvcmUgaGNpX2RldmNkX2FwcGVuZCgpIGlzIGNhbGxlZCwgc28gdGhlIGNs
b25lZCBza2IgcGFzc2VkIHRvIGl0IHdvdWxkIGJlIG1pc3NpbmcgdGhlIG54cF9md19kdW1wX2hk
ci4gVGhlIGR1bXAgYW5hbHl6ZXIgcmVsaWVzIG9uIHRob3NlIGhlYWRlcnMgYmVpbmcgcHJlc2Vu
dCBpbiB0aGUgZmluYWwgLmJpbiBmaWxlLCBzbyB0aGlzIHdvdWxkIHNpbGVudGx5IGNvcnJ1cHQg
dGhlIGNvcmVkdW1wIG91dHB1dCwgYnJlYWtpbmcgdGhlIE5YUCBGVyBkdW1wIGFuYWx5emVyLg0K
DQpUaGUgZXhwbGljaXQgc2tiLT5sZW4gY2hlY2sgaW4gdjIgYXZvaWRzIHRoYXQg4oCUIHNrYi0+
ZGF0YSBzdGF5cyBwb2ludGluZyBhdCB0aGUgaGVhZGVyIGZvciB0aGUgc3Vic2VxdWVudCBza2Jf
Y2xvbmUoKS4gSGFwcHkgdG8ga2VlcCBpdCB0aGF0IHdheSB1bmxlc3MgeW91IHNlZSBhIGNsZWFu
ZXIgYWx0ZXJuYXRpdmUgdGhhdCBwcmVzZXJ2ZXMgdGhlIGhlYWRlciBpbiB0aGUgYXBwZW5kZWQg
ZGF0YS4NCg0KUmV2aWV3ZWQtYnk6IE5lZXJhaiBLYWxlIG5lZXJhai5zYW5qYXlrYWxlQG54cC5j
b20NCg0KVGhhbmtzIGFnYWluLA0KTmVlcmFqDQoNCj4gPiBueHBfcHJvY2Vzc19md19kdW1wKCkg
cHVsbHMgdGhlIEFDTCBoZWFkZXIgb2ZmIHRoZSBmcmFtZSBhbmQgdGhlbg0KPiA+IHJlYWRzIHNl
cV9udW0gYW5kIGJ1Zl9sZW4gZnJvbSBhIHN0cnVjdCBueHBfZndfZHVtcF9oZHIgcGxhY2VkIGF0
DQo+ID4gc2tiLT5kYXRhLCB3aXRob3V0IGNoZWNraW5nIHRoYXQgdGhlIEFDTCBwYXlsb2FkIGlz
IGxvbmcgZW5vdWdoIHRvIGNvbnRhaW4NCj4gaXQuDQo+ID4NCj4gPiBoNF9yZWN2X2J1ZigpIGNv
bGxlY3RzIEhDSV9BQ0xfSERSX1NJWkUgYnl0ZXMgb2YgaGVhZGVyIGZvbGxvd2VkIGJ5DQo+ID4g
dGhlIG51bWJlciBvZiBwYXlsb2FkIGJ5dGVzIG5hbWVkIGluIHRoYXQgaGVhZGVyLCBzbyBza2It
PmxlbiBpcyA0ICsNCj4gPiBkbGVuIHdpdGggZGxlbiBzdXBwbGllZCBieSB0aGUgY29udHJvbGxl
ciBhbmQgcG9zc2libHkgc21hbGxlciB0aGFuDQo+ID4gdGhlIDggYnl0ZSBkdW1wIGhlYWRlciwg
b3IgemVyby4gQSBzaG9ydCBmcmFtZSB3aXRoIGNvbm5lY3Rpb24gaGFuZGxlDQo+ID4gMHhmZmYg
dGhlcmVmb3JlIHJlYWRzIGJvdGggZmllbGRzIGZyb20gYmV5b25kIHRoZSByZWNlaXZlZCBkYXRh
Lg0KPiA+DQo+ID4gQmV5b25kIHRoZSByZWFkIGl0c2VsZiwgYnVmX2xlbiBpcyB3aGF0IHRlcm1p
bmF0ZXMgYSBkdW1wOiBhIHZhbHVlIG9mDQo+ID4gemVybyBtYWtlcyB0aGUgZHJpdmVyIGNhbGwg
aGNpX2RldmNkX2NvbXBsZXRlKCkgYW5kIHJlc2V0IHRoZQ0KPiA+IGNvbnRyb2xsZXIsIHNvIGEg
dHJ1bmNhdGVkIGZyYW1lIGNhbiBlbmQgYSBkdW1wIGVhcmx5Lg0KPiA+DQo+ID4gUmVqZWN0IGZy
YW1lcyB3aG9zZSBwYXlsb2FkIGlzIHNob3J0ZXIgdGhhbiB0aGUgZHVtcCBoZWFkZXIuDQo+ID4N
Cj4gPiBGaXhlczogOTk4ZTQ0N2Y0NDNmICgiQmx1ZXRvb3RoOiBidG54cHVhcnQ6IEFkZCBzdXBw
b3J0IGZvciBIQ0kNCj4gPiBjb3JlZHVtcCBmZWF0dXJlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bGkgQWhtZXQgTWVtaXMgPGFsaUBpdXNlZ2VudG9vLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjogV2Fy
biBvbiB0aGUgZWFybHkgZXhpdCBwYXRoIGluc3RlYWQgb2YgZHJvcHBpbmcgdGhlIGZyYW1lIHNp
bGVudGx5LA0KPiA+ICAgICBhcyBzdWdnZXN0ZWQgYnkgTmVlcmFqLiBEcm9wcGVkIHRoZSB0cmFp
bGluZyBuZXdsaW5lIGZyb20gdGhlDQo+ID4gICAgIHN1Z2dlc3RlZCBtZXNzYWdlLCBzaW5jZSBi
dF9kZXZfd2FybigpIGFscmVhZHkgYXBwZW5kcyBvbmUuDQo+ID4NCj4gPiB2MToNCj4gPiBodHRw
czovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0El
MkYlMkZsb3JlDQo+ID4gLmtlcm5lbC5vcmclMkZhbGwlMkYyMDI2MDgxNDA4MTIyMS45MTM2NzYt
MS0NCj4gYWxpJTQwaXVzZWdlbnRvby5jb20lMkYmZGENCj4gPg0KPiB0YT0wNSU3QzAyJTdDbmVl
cmFqLnNhbmpheWthbGUlNDBueHAuY29tJTdDNzE3NWMzNTU1ODgyNDM0MTAzMzQwOA0KPiBkZWZh
MA0KPiA+DQo+IGQ4MGI1JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdD
MCU3QzYzOTIyMzEzMzA2DQo+IDgwMDE0MTklDQo+ID4NCj4gN0NVbmtub3duJTdDVFdGcGJHWnNi
M2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZaU9pSXdMakF1TQ0KPiBEQXdNQ0lzSWwNCj4g
Pg0KPiBBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3
QyU3QyU3QyZzZGF0DQo+IGE9dVkyQQ0KPiA+IDJkNmlYWDRRSXR4ZlVLUGl2YUslMkZzJTJGbjNX
TGw3VFZ5QVcxc1VlaGslM0QmcmVzZXJ2ZWQ9MA0KPiA+DQo+ID4gIGRyaXZlcnMvYmx1ZXRvb3Ro
L2J0bnhwdWFydC5jIHwgMTMgKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0KPiA+IGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1
YXJ0LmMgaW5kZXggNmExY2ZmZTA4ZDVmLi5mNDM5ZDI4NzE0NmUNCj4gPiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0bnhwdWFydC5jDQo+ID4gQEAgLTEzNzAsMTAgKzEzNzAsMTkgQEAgc3RhdGljIGlu
dCBueHBfcHJvY2Vzc19md19kdW1wKHN0cnVjdCBoY2lfZGV2DQo+ICpoZGV2LCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKCphY2xfaGRyKSk7DQo+ID4g
ICAgICAgICBzdHJ1Y3QgbnhwX2Z3X2R1bXBfaGRyICpmd19kdW1wX2hkciA9IChzdHJ1Y3Qgbnhw
X2Z3X2R1bXBfaGRyDQo+ICopc2tiLT5kYXRhOw0KPiA+ICAgICAgICAgc3RydWN0IGJ0bnhwdWFy
dF9kZXYgKm54cGRldiA9IGhjaV9nZXRfZHJ2ZGF0YShoZGV2KTsNCj4gPiAtICAgICAgIF9fdTE2
IHNlcV9udW0gPSBfX2xlMTZfdG9fY3B1KGZ3X2R1bXBfaGRyLT5zZXFfbnVtKTsNCj4gPiAtICAg
ICAgIF9fdTE2IGJ1Zl9sZW4gPSBfX2xlMTZfdG9fY3B1KGZ3X2R1bXBfaGRyLT5idWZfbGVuKTsN
Cj4gPiArICAgICAgIF9fdTE2IHNlcV9udW07DQo+ID4gKyAgICAgICBfX3UxNiBidWZfbGVuOw0K
PiA+ICAgICAgICAgaW50IGVycjsNCj4gPg0KPiA+ICsgICAgICAgLyogVGhlIEFDTCBwYXlsb2Fk
IG11c3QgYmUgbG9uZyBlbm91Z2ggdG8gaG9sZCB0aGUgRlcgZHVtcA0KPiA+ICsgaGVhZGVyICov
DQo+DQo+IFRoZSBmb2xsb3dpbmcgY2FuIHByb2JhYmx5IGJlIHJlcGxhY2VkIHdpdGggc2tiX3B1
bGxfZGF0YSBlLmc6DQo+DQo+IGZ3X2R1bXBfaGRyID0gc2tiX3B1bGxfZGF0YShza2IsIHNpemVv
ZigqZndfZHVtcF9oZHIpKTsgaWYNCj4gKCFmd19kdW1wX2hkcikgLi4uDQo+DQo+ID4gKyAgICAg
ICBpZiAoc2tiLT5sZW4gPCBzaXplb2YoKmZ3X2R1bXBfaGRyKSkgew0KPiA+ICsgICAgICAgICAg
ICAgICBidF9kZXZfd2FybihoZGV2LCAiRlcgZHVtcDogaW52YWxpZCBvciBjb3JydXB0IGZ3IGR1
bXANCj4gY2h1bmsiKTsNCj4gPiArICAgICAgICAgICAgICAgZ290byBmcmVlX3NrYjsNCj4gPiAr
ICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBzZXFfbnVtID0gX19sZTE2X3RvX2NwdShmd19k
dW1wX2hkci0+c2VxX251bSk7DQo+ID4gKyAgICAgICBidWZfbGVuID0gX19sZTE2X3RvX2NwdShm
d19kdW1wX2hkci0+YnVmX2xlbik7DQo+ID4gKw0KPiA+ICAgICAgICAgaWYgKHNlcV9udW0gPT0g
MHgwMDAxKSB7DQo+ID4gICAgICAgICAgICAgICAgIGlmICh0ZXN0X2FuZF9zZXRfYml0KEJUTlhQ
VUFSVF9GV19EVU1QX0lOX1BST0dSRVNTLA0KPiAmbnhwZGV2LT50eF9zdGF0ZSkpIHsNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBidF9kZXZfZXJyKGhkZXYsICJGVyBkdW1wIGFscmVhZHkg
aW4NCj4gPiBwcm9ncmVzcyIpOw0KPiA+IC0tDQoNCk5YUCBDb25maWRlbnRpYWwNCg==
