Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2091.outbound.protection.outlook.com [40.107.100.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D813A3F7
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573484; cv=fail; b=BtW+z2Fuwccr4piKBgfsW2eIk3yH75jnDFUw2rMam22hswBAiVBlBGVMolzT5qXugHCAUUlxyl5wDa5A778SDtIsfueurjiHuqf42nHLpaFVWpRiMzPgqPsEuS11sEdEQNYcF5VW8Sru07ynEeFg5MkH4zYGijE06bVUyC6x68A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573484; c=relaxed/simple;
	bh=TCGqQuR8OCL2+8psU8yr5lFpJ80H/YvgeEkzYpdibD8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NRhEd7Dx44GzFo/erLjiK9ri5yWTo85qRYCFxHQIDV4vU8MJZ1d5bDFPJVDzAh5BfUbD/wRS0qh3tDU5+RnKFjeZxzkagubSeatoQtOJr+gVPCiVVHejz9+5al5Yi6Ydt+aRKmBUZeZWLZpYRsqwdI6xhEpnNqCUvgNiufwWiDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ezurio.com; spf=pass smtp.mailfrom=ezurio.com; dkim=pass (2048-bit key) header.d=ezurio.com header.i=@ezurio.com header.b=KoFVP1Ll; arc=fail smtp.client-ip=40.107.100.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ezurio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ezurio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ezurio.com header.i=@ezurio.com header.b="KoFVP1Ll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9zuUJ/TUAe6ZRcuXo4ISDPfEYrsvGbxYj1hPKNUY07um5ZkA3LgMUEs9s8Dq+FWgQV069006iK1fN6DckCwJsjSMYIteSJfKlX9dL3fII/WTLY5r6rY0fe9jMZBJRpLqLsgVj+mmMJD8pwSedORWDzXA/TllGPkvX9y4uv53zK4/nz83NNbtB7RMuUAycjWUpVr4fJ3WmPfBYkpCOfTOpyEPSVL+yremgTUKJjWvspXFZdbyducSkqt0wP6ieZ5dnHCeW1CS7VYoyIMxnt2qw5AccKZqrHR1NcTMqBK6XF5XsddaWY0IquJR/hGqckvMXlNTsyl7YOV+TcB4lvMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCGqQuR8OCL2+8psU8yr5lFpJ80H/YvgeEkzYpdibD8=;
 b=dnurkLwGX06+lfBgdUuXfZ6IIGzPGUTRhLjrbAiHrr1YqTX4CHwtPDAJ279/oGtUbNKftw+k+9NOw5NZyMMWLvVSVN9ou2DFrJK+mYU6sz7Oq4P+vb/KEy+9Vsu2H9hMIHMpRWEkHxHdDiguf6n6pKz1QL57szntvPWcJn8GwjXnMZTZXmcemDa/S2MwNfpLZAF9wrHcJyf6FEOG+9xXUkLeHgyhCxXgAhMM5NuRWcUA5SSljvanl1xDb8nScVQFPTF7WfZ0Xstq0JhGpyIUp+s1igBTlrMXsdNH8+BkVuw4UxcoNGZlREoCNnqfljnxC/cJVd1PHZDqOcZYZHMH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ezurio.com; dmarc=pass action=none header.from=ezurio.com;
 dkim=pass header.d=ezurio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ezurio.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCGqQuR8OCL2+8psU8yr5lFpJ80H/YvgeEkzYpdibD8=;
 b=KoFVP1Ll2Uv6lPDIO3Mo35lbU5YkByb1CuNcC4ax1nUjpnGu35RFdCzb9P44a+bn5fJOCoe21TbVWOE+hNR5lF04eThhKAQWKLi8SkyKcpxwgy+rVpYLq2fjcoFIIDJSB8cT0yaD0zfSKNAa/LLZmudfwR4QEBYz6d7JTXzdp9C4jkcDEX9JlU14DobkCxXk39n6fuee3fv7FbQcsVvrlpAPFfeBlvBVSgesRJRzklSMEf/F3+wGGX5O+0wxuso1JvBgAPljRLL2ymTVSboXqkckeTBnpiJW4ZbzdAax1zz9bLfe7R5NFpcgrP1wz04uAjxfK04D7xkwMTf1VPngxg==
Received: from PH7PR14MB5300.namprd14.prod.outlook.com (2603:10b6:510:13c::8)
 by BY5PR14MB3832.namprd14.prod.outlook.com (2603:10b6:a03:1dd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 21:04:37 +0000
Received: from PH7PR14MB5300.namprd14.prod.outlook.com
 ([fe80::e26b:8dfa:5b06:594a]) by PH7PR14MB5300.namprd14.prod.outlook.com
 ([fe80::e26b:8dfa:5b06:594a%4]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 21:04:37 +0000
From: Chris Laplante <Chris.Laplante@ezurio.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Maximum Bonded Devices
Thread-Topic: Maximum Bonded Devices
Thread-Index: AdqAcgMJHCNRz56XQrWX+InNCWrc+AAF+VwAAAANf6A=
Date: Wed, 27 Mar 2024 21:04:37 +0000
Message-ID:
 <PH7PR14MB5300B754841B71CAC197BA84E9342@PH7PR14MB5300.namprd14.prod.outlook.com>
References:
 <PH7PR14MB53009C64A876F92F7F472CB5E9342@PH7PR14MB5300.namprd14.prod.outlook.com>
 <CABBYNZLj8z1xbB-2Qnwiqvqw1PdLjhVy3GgZLHFirEjLE4QtAw@mail.gmail.com>
In-Reply-To:
 <CABBYNZLj8z1xbB-2Qnwiqvqw1PdLjhVy3GgZLHFirEjLE4QtAw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ezurio.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR14MB5300:EE_|BY5PR14MB3832:EE_
x-ms-office365-filtering-correlation-id: 373b719d-c4e8-478b-0966-08dc4ea182ce
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7XgxuZZ/tY/rUoZ1h3sZDYs4woVpXsMzoS1s0RF/GHnHYFAqT6MiI7trB1omCRQRIne4xb6IhqjAo+nLBl3m3ilv273e+rC214gi1IiA7Za3V7amOpPWOwapWCf+HULQaPHGX1h0cIImEzKRGRYLytyr9ewc4XFAE0K7y5pRB61ySaoSk7JAuvI2imokyiBizK4ruAq0WaYiNt9HHaRSBv0c+7oj8G6gs4OxoxgH8TPqMqxLjpTGMPMjXc6IEfAGodbI+pway8PVmD5gf8uuhDONDNOUXFUR9mxgkuaE5qaW30SQAx/y20k+s2XDiayn1TMK7WE+y1tZCZedFUFHtICCz9+XaomNkK3hGTCNOTEBUaJA2JzwY4DRS2d7ASrV0/frNSUTbwF0dkMFvKDZGt5/1DaelmhXALmo5qukJp6kQlFiSszMglkaRLTanY9B1cJkYmIsYtum5t6R3Wp/NKv+U5q4lDJPQHiaRcXwb7B/8hzRlPY56H409Ooh8JXm2TvKaLrp5SfkU9GKde9k/Ri9U6XChEkEtnIGEdPazVvdKL0TjIuIOehYJCaQ8jI3DOwAiVflXeXEM3pPg4LDdGeHxoXW7D4qfaaGiVpLBNv9XCUODMN9V85jsFRIMgme5iK01Jb29j0nqqZ77DyzYxQzqZNPtQSWWc74b3Ht31BGE2XStbxaJpiZccmUdPxjchiIXoSuaVaj2ROPPZhFM8bqi3e8PAvTrptI2Vonu5s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR14MB5300.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2J4MUZQdEE4WWRIQ29KbW5WcWRmSUFLRzRaQjk2WnJOZ0VKU1l6YUdndFFZ?=
 =?utf-8?B?K04yVk1aTi9mSWc1VjBWazlvelArbVFnQSt4TXVrbFMvWis3SDlxYmQ0anZx?=
 =?utf-8?B?NnQxZFhxSU1OT2pMdURwRFZYRHNGZW5DSGk4bElFNWdMZFQyWmtzc0g0REdh?=
 =?utf-8?B?R2ZNN2pPMmRERGxYYmdFbWIrN1lFeWs2b0tKMkQ0YzBWVEcxU2o0amN3ck8x?=
 =?utf-8?B?WitkbGorRDhOOWdLVWVKaEY3NGE1WGI4OHJtemJtU1hld0crMDUxTllzajVC?=
 =?utf-8?B?YkxXZW1vQnlvR3JwRTZTSHNZUlFCY0xudWJiNFg3NUFUOW5XSFdRUDZhbmxG?=
 =?utf-8?B?MzkxTW5WNENrOXZVb1lLODBvT2JiVXBnSWN6YWlGa25UazlyVDRyUlZNbndB?=
 =?utf-8?B?dEoyYkVDMEZCV1V5TitXdytiMTVodjNsak5udnhHbmgzMFVrNk05Y3BGak9n?=
 =?utf-8?B?N1FnSnloa1BhNktWNUhpM2ozeUthUkhqcWQ0UjRjMERHTmQ2cHJmVG5lU3RT?=
 =?utf-8?B?QnZqOGtZQmpPNXBCZFgwc0FJdGZOazFrTEUzQ21RSUV6V2xrWS9tRWdObWlt?=
 =?utf-8?B?VUNzSE42YTBjR3RwaDhQUVhzYzhwNm42NWE1ZFBQVUlRWWhOSjhNazlSU0hZ?=
 =?utf-8?B?M05XcHJiN3Q1akhsaWFRcm50eVppZHMyNVJaTm42MlpyZFpGZzVGdzhLZEE2?=
 =?utf-8?B?L2lGMG1SeFUrVm1ueXlqY0FsWW9RQk5zS04wbFJFdXE2WkMyU3B0UkhBV2k4?=
 =?utf-8?B?N1FVazBNZlZZWTE3aUwrbjZrOC9VS0VjdnVmTElxcFAwOVZmSkNCUmFTRUVF?=
 =?utf-8?B?eTNxOEErWmUrd2VvWEVmSDRlK1EybmZsN3FCTC9INzdKcE92MVBFVWpiNDNT?=
 =?utf-8?B?Tlo2N1I1L0FhZU10dE40Y2xpaWR1cEl3cjViQlMyK1VXREwwbFBJQ20vMzhL?=
 =?utf-8?B?dDRuWldwV3hRV1hFYmpNUzd4RzluVEV0eEdSKzJGR20xbDczRXJYRXpXcmNT?=
 =?utf-8?B?VEdBZlNwZkRCRTZxVlJqNkVpM0pWcDJEMnluVWFyNVltV2UzeEF2VmEyamFx?=
 =?utf-8?B?T2Q0M2lEVlliOXRkejdkSERRRzdSK1A4cU9VK1ZYWEk4c2JuNXlXdFBDZzRW?=
 =?utf-8?B?TlhOKzBFNDAzLzhHWmE1cHJhQkg2MjJHMDN4dkplTTc5Q0tWYjFtQy8zWkpI?=
 =?utf-8?B?WXVHYVp3SGdDSzBTOElPNklJVElOQjJPN0k3K296VnV2cm1wZlFxdU0wQWpN?=
 =?utf-8?B?U0JBVldUTVI0Z0RyL2FFbTJ6MkVHQXA4b0gvazRMRTRHSjFDdjNNQStOdW4x?=
 =?utf-8?B?RXZpd0JvQmpVcm5QN2hmT3FJazZmdW9pTTQ5UnlCa2xPUkl1a2dGVWRxaFBw?=
 =?utf-8?B?cjAyem5tSUprbmdsRE11S1FsT1ByRytQZXpHcDZkS2Zad2EyZzBSUzFxM2lL?=
 =?utf-8?B?NXR4UkRsNmRMWGppY1F2UkJaSWx1emduSjVGRUs5UnUvcXBwWG9vZTZuTDJU?=
 =?utf-8?B?OW85eWNvTW9TZ1JHVlE4RUdhYWNhQnlkS1oxYjY1Q21mczJWMWthQ0dGMlBJ?=
 =?utf-8?B?NGtBTVNpc0lhWXBrUGlZTGxKVEh1Mk14QmhRZVVUOU1TL3FUY09aVHhHUEVo?=
 =?utf-8?B?clRJY0E4bnFBcXRPcFNQd0xEVnNFeWU0ZUE5UXVXcVR6RTNoSlI4a3NyRTNB?=
 =?utf-8?B?NEhjdkRGVmlMOWVtMzg1YWsxZ2JVN1JpMUtFY0pxT2wwUzlGdERvNVJrVERm?=
 =?utf-8?B?a1JSWWh6VFNjYVQ3TUVHQkRyMWoyeFhxSlVDaWV5bmgzSGVKYUNZbmVqZURs?=
 =?utf-8?B?YnF3QVBtajFJV3lDZ2R0VklpbFA1SUliVUhLYjJZU1hsZjdGWWx3dEZvMXNL?=
 =?utf-8?B?THhqUEdNQ3FpTEJiVGZDNWpzbUEwN1BYdUVkc21US282aVljNS9YM05EZFZ5?=
 =?utf-8?B?d0pkQnBYNVIyRlMxZCtBQVB2b28wZVJVYzdTRWpWRVVhbS83SUhxQnZvSnph?=
 =?utf-8?B?VFNqN1Q1U3l0eVpnT0ZQOVZqenBieFpTamV2ZE5TblloVmVmSkdRc05od2Fs?=
 =?utf-8?B?S21RbGJuWDZFWk5wNSt3eUpLZWwrb0NrdWhnU1doVEM4eEZtclhNdFpENG1z?=
 =?utf-8?B?cHJtYkEvTmZkM0xBM2RIZDM1RVJSeERMRVdrTGtMVmZ5MzFUTFljemxyczBJ?=
 =?utf-8?B?b1J6Wno4SEd5SW9uSkJZSkp3NGhXeXdMTVlOZ05SUUw0V2ZZQjlrUUpjSkZT?=
 =?utf-8?B?NXVpYU1QcXVoRXNJaUUvd1RiSldBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ezurio.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR14MB5300.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373b719d-c4e8-478b-0966-08dc4ea182ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 21:04:37.0712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FXC+c4yDy9zGPZI74mJSbqJV+7EnRvvueL83A6zSr0s3HPs6OhmM45CSGdJx2Bad+pLcEJTZ6DxE4JxU2yRwdc5T82ll/KugGSOUAozPU7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB3832

VGhhbmtzIEx1aXoNCg0KVGhleSBhcmUgbm90IHRyeWluZyB0byBtYWludGFpbiAzMCBzaW11bHRh
bmVvdXMgY29ubmVjdGlvbnMgaWYgdGhhdCBpcyB3aGF0IHlvdSBxdWVzdGlvbiB3YXMuIFRoZXkg
d2lsbCBvbmx5IGNvbm5lY3Qgd2l0aCBzYXkgb25lIGF0IGEgdGltZSBidXQgdGhleSB3YW50IHRv
IG1haW50YWluIHVwIHRvIDMwIGJvbmRlZCBkZXZpY2VzIGluIHRoZWlyIGRhdGFiYXNlLg0KDQpU
aGFua3MNCkNocmlzDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NClNlbnQ6IFdlZG5lc2RheSwg
TWFyY2ggMjcsIDIwMjQgNTowMSBQTQ0KVG86IENocmlzIExhcGxhbnRlIDxDaHJpcy5MYXBsYW50
ZUBlenVyaW8uY29tPg0KQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNClN1Ympl
Y3Q6IFJlOiBNYXhpbXVtIEJvbmRlZCBEZXZpY2VzDQoNCkVYVEVSTkFMIEVNQUlMOiBCZSBjYXJl
ZnVsIHdpdGggYXR0YWNobWVudHMgYW5kIGxpbmtzLg0KDQpIaSBDaHJpcywNCg0KT24gV2VkLCBN
YXIgMjcsIDIwMjQgYXQgMjoxNeKAr1BNIENocmlzIExhcGxhbnRlIDxDaHJpcy5MYXBsYW50ZUBl
enVyaW8uY29tPiB3cm90ZToNCj4NCj4gSGksDQo+DQo+IEkgaGF2ZSBhIGN1c3RvbWVyIHdpdGgg
YW4gaXNzdWUgd2hlcmUgdGhleSBhcmUgdW5hYmxlIHRvIGdldCAzMCBkZXZpY2VzIHBhaXJlZCBh
bmQgYm9uZGVkIHdoZW4gdGhlIEJMNTM0MFBBIChuUkY1MzQwKSBTb0MgYXMgdGhlaXIgY2VudHJh
bCBkZXZpY2UuDQo+DQo+IEZvbGxvd2luZyBkZXRhaWxzIG1pZ2h0IGhlbHAgeW91IG91dC0NCj4g
MS4gICAgICBUaGV5IGFyZSB1c2luZyB0aGUgaGNpX3VzYiBzYW1wbGUgY29kZSBhcyB0aGUgZmly
bXdhcmUgb24gdGhlIFNvQy4NCj4gMi4gICAgICBUaGUgc3RhY2sgb24gdGhlIGhvc3QgTGludXgg
c3lzdGVtIGJlaW5nIHVzZWQgaXMgQmx1ZVogKHZlcnNpb24gNS42NikNCj4NCj4gVGhleSBhcmUg
YWJsZSB0byBwYWlyIGFuZCBib25kIHdpdGggdXB0byA4IGRldmljZXMgcHJldHR5IHF1aWNrbHkg
YW5kIHRoZW4gdGhpcyBwcm9jZXNzIHNsb3dzIGRvd24gYW5kIHRoZXkgYXJlbid0IGFibGUgdG8g
cGFpciB3aXRoIG1vcmUgdGhhbiAxMi0xNSBzZW5zb3JzIGluIGEgc2luZ2xlIGdvLg0KPiBBZnRl
ciB0aGUgcGFpcmluZyBhbmQgYm9uZGluZyBwcm9jZXNzIHN0YWduYXRlcyBhdCBhcm91bmQgMTIt
MTUgc2Vuc29ycyBpZiB0aGV5IHJlc3RhcnQgdGhlIGhvc3Qgc3lzdGVtIChhbmQgaW4gdHVybiB0
aGUgU29DIGFzIHdlbGwpIHRoZXkgYXJlIGFibGUgdG8gcGFpciB3aXRoIGEgZmV3IG1vcmUgc2Vu
c29ycyBidXQgbm90IDMwIHNlbnNvcnMuDQo+IFNvIGZhciBvdXQgb2YgdGhlIHRoaW5ncyB0aGF0
IHRoZXkgaGF2ZSB0cmllZCBvdXQgdG8gaWRlbnRpZnkgdGhlIHNvdXJjZSBvZiB0aGUgcHJvYmxl
bSBpdCBoYXMgc29tZXRoaW5nIHRvIGRvIHdpdGggdGhlIEJsdWVaIHN0YWNrIGNvbmZpZ3VyYXRp
b24gKCB0aGV5IGFyZSBjdXJyZW50bHkgdXNpbmcgdGhlIGRlZmF1bHQgc3RhY2sgY29uZmlndXJh
dGlvbikgYW5kLyBvciB0aGUgZmlybXdhcmUgY29uZmlndXJhdGlvbiBwYXJhbWV0ZXJzLg0KPg0K
PiBEbyB5b3UgaGF2ZSBhbnkgaWRlYSBvbiB3aGF0IGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVycyBj
b3VsZCBiZSBjYXVzaW5nIHRoaXMgYmVoYXZpb3VyIGFuZC8gb3Igd2hhdCBjb25maWd1cmF0aW9u
IGNoYW5nZXMgbmVlZCB0byBiZSBtYWRlIHNvIHRoYXQgdGhleSBjYW4gYWNoaWV2ZSB0aGUgdGFy
Z2V0IG9mIHBhaXJpbmcgYW5kIGJvbmRpbmcgd2l0aCAzMCBzZW5zb3JzLiBJZiB5b3UgaGF2ZSBh
bnkgbW9yZSBxdWVzdGlvbnMgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQpEb24ndCB0aGluayB0aGVy
ZSBpcyBzdWNoIHRoaW5nIGFib3V0IG51bWJlciBvZiBwYWlyZWQgZGV2aWNlcyBsaW1pdCwgd2Ug
anVzdCB1c2UgbGlzdHMgc28gdGhleSBiZSBleHRlbmRlZCBkeW5hbWljYWxseSBhcyB5b3UgcGFp
ciB3aXRoIG1vcmUgZGV2aWNlcywgdGhlcmUgbWlnaHQgYmUgYSBsaW1pdCBvbiBob3cgbWFueSB0
aGUgY29udHJvbGxlciBjYW4gbWFpbnRhaW4gY29ubmVjdGVkIHNpbXVsdGFuZW91c2x5IHRob3Vn
aCwgc28gcGVyaGFwcyB5b3Ugd2FudCB0byBleHBsYWluIGEgbGl0dGxlIGJldHRlciBob3cgdGhl
IHByb2Nlc3Mgb2YgcGFpcmluZyBnb2VzLCBpcyB0aGF0IHNlcmlhbGl6ZWQgb3IgeW91IGF0dGVt
cHQgdG8gY29ubmVjdC9wYWlyIGV2ZXJ5dGhpbmcgaW4gcGFyYWxsZWw/DQoNCj4gSSBiZWxpZXZl
IHRoZSBkZWZhdWx0IGlzIHNldCB0byBzb21ldGhpbmcgbGlrZSA2NUsgZGV2aWNlcyBwZXINCj4g
TWF4Q29udHJvbGxlcnMgaW4gbWFpbi5jIGFzIHdlbGwgYXMgbWFpbi5jb25mDQo+DQo+IHBhcnNl
X2NvbmZpZ191MTYoY29uZmlnLCAiR2VuZXJhbCIsICJNYXhDb250cm9sbGVycyIsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZidGRfb3B0cy5tYXhf
YWRhcHRlcnMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDAsIFVJTlQxNl9NQVgpOw0KPg0KPiAjIE1heGltdW0gbnVtYmVyIG9mIGNvbnRyb2xsZXJz
IGFsbG93ZWQgdG8gYmUgZXhwb3NlZCB0byB0aGUgc3lzdGVtLg0KPiAjIERlZmF1bHQ9MCAodW5s
aW1pdGVkKQ0KPiAjTWF4Q29udHJvbGxlcnM9MA0KDQpUaGVzZSBhcmUgdGhlIG51bWJlciBvZiBj
b250cm9sbGVycywgbm90IHRvIGNvbmZ1c2Ugd2l0aCBwYWlyZWQgZGV2aWNlcyB0aG91Z2guDQoN
Cj4gSSBhbSBhc3N1bWluZyB0aGUgaXNzdWUgaXNuJ3QgQmx1ZVogc3BlY2lmaWMgYnV0IGlmIHRo
ZXJlIGlzIGFueSB0aG91Z2h0cyBvciBndWlkYW5jZSB5b3UgbWF5IGhhdmUgaXQgd291bGQgYmUg
YXBwcmVjaWF0ZWQuDQo+DQo+IFRoYW5rcw0KPiBDaHJpcw0KPg0KPiBUSEUgSU5GT1JNQVRJT04g
Q09OVEFJTkVEIElOIFRISVMgRE9DVU1FTlQgSVMgT0YgQSBQUk9QUklFVEFSWSBOQVRVUkUNCj4g
QU5EIElTIElOVEVOREVEIFRPIEJFIEtFUFQgQ09ORklERU5USUFMIEJFVFdFRU4gVEhFIFNFTkRF
UiBBTkQgVEhFDQo+IElOVEVOREVEIFJFQ0lQSUVOVC4gSVQgTUFZIE5PVCBCRSBSRVBST0RVQ0VE
IE9SIFVTRUQgV0lUSE9VVCBFWFBSRVNTDQo+IFdSSVRURU4gUEVSTUlTU0lPTiBPRiBFWlVSSU8N
Cg0KDQoNCi0tDQpMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQpUSEUgSU5GT1JNQVRJT04gQ09OVEFJ
TkVEIElOIFRISVMgRE9DVU1FTlQgSVMgT0YgQSBQUk9QUklFVEFSWSBOQVRVUkUgQU5EIElTIElO
VEVOREVEIFRPIEJFIEtFUFQgQ09ORklERU5USUFMIEJFVFdFRU4gVEhFIFNFTkRFUiBBTkQgVEhF
IElOVEVOREVEIFJFQ0lQSUVOVC4gSVQgTUFZIE5PVCBCRSBSRVBST0RVQ0VEIE9SIFVTRUQgV0lU
SE9VVCBFWFBSRVNTIFdSSVRURU4gUEVSTUlTU0lPTiBPRiBFWlVSSU8NCg==
