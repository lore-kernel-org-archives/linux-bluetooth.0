Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DD1C41513
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Aug 2023 10:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjHNKAl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Aug 2023 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjHNKAN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Aug 2023 06:00:13 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2070.outbound.protection.outlook.com [40.92.58.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBCDE63
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Aug 2023 03:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmGkFqxjdUTnynRRa+Qb3yp26oFqcWliosPO0afXBuvi7SwtmcvT8UIR1plobpcwG0nZuzMaEzBDAyqVpM9uglSuMSBU7tqKyxSnLzY3u4qXKlu667H1/VQkrQyZaZl2ZtcYpriu+EY8cmeOI3AOgiZQi4sMc3mrFMZ8lCf30MkUZGLfy7DhOAAIEi7h3gEiDNAejMdd/lAqsjMU1voJJbVj3P4q0P8D0aqBAZ/1Q1SXPcxP2m7OIvHHaik69qgY5eYeWUd6uRVFLp3GFLk1Q1obuFz4Vwyyazaug5u9+NQ9MUwC6kQxOz7PJT/Zq8lGm18Jx/wEY8n9Wj+bxcBu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPR6hZzAoV6BlexeKRStMThAbVQ7/TTnI3dQzlNs88U=;
 b=lvbX1P/oxUZ6Gv6ajs2KxRPc8WtbgRX3xh5Ve/KZwVGDN0slP2YU1wJUsevFttVwauh7B/WWkF/dKQucGu3iFy05+Cj8/oBbU5FQ60jdHSTGrGfp1pKc5lftd/QGRsJo6zbH/KGPqAZ1oKYyXoW4Vs5sImQ9MC2ToVUd2nYixvEiMsSSlbsatjl033vRq0GyPZpbNKxx/edZggwjJLqxAt/0k9nEUsxpKF2cdNmuU7XMrNbw/gpcFkQcoW7CSavjVPFPACK3t1yoYIZ5ubIHbj9eRObfEeHetaPU5ReEdyniZ6whiU5XcJL0/f9/Kdx5bsC+LjdJTatM2Lt4znhd4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPR6hZzAoV6BlexeKRStMThAbVQ7/TTnI3dQzlNs88U=;
 b=E6pwq6cS69q3VLkxQv+EKdjJlLCYGWG35xYgUWpYCEA4uOUyO9KvGIfPhhOJmh+SCxh73kPeyCGAPMwe8+ddfPAeBpPI0AxyGoTt9XPZpbLYJeHN4M8gEY+KYMcdPh2vanwWff9eAR1MyaYX/V6DBkuu0dJkjidxfbMp7aPNV6ONo6fjJgGQTPGUDprwPWPhMRV9PZs9mKl1IfLaEj0GTpeY1709rDloQy8aVE8ZA13lTh2Yg0StZrUrhyZKlYtP/toCwRPI0JsrDzIfTQkYi5c2VsMGp9E3/RvnlV1HqPZgz5RdRK3bhreRO5kokM8kyC7DQ1ynAQM3u+UNxG+GDA==
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:30::18)
 by AM9P191MB1400.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Mon, 14 Aug
 2023 10:00:09 +0000
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33]) by AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33%4]) with mapi id 15.20.6678.020; Mon, 14 Aug 2023
 10:00:09 +0000
From:   Bruno Pitrus <brunopitrus@hotmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: regression: kernel 6.4.x breaks scanning/pairing (but not use) of
 LE devices
Thread-Topic: regression: kernel 6.4.x breaks scanning/pairing (but not use)
 of LE devices
Thread-Index: AQHZxwU/0l6XSi77i0WWX4xR1VKYUK/bT48AgAmttwCAAGKEAIAEPmCA
Date:   Mon, 14 Aug 2023 10:00:09 +0000
Message-ID: <13020832.2lBWEU9m2C@bruno-beit>
References: <2300626.ElGaqSPkdT@bruno-beit> <5706628.DvuYhMxLoT@bruno-beit>
 <CABBYNZ+Nt3Rho2=VtVrspRLond2agnKhT1LmeLCGdY4fdxmusg@mail.gmail.com>
In-Reply-To: <CABBYNZ+Nt3Rho2=VtVrspRLond2agnKhT1LmeLCGdY4fdxmusg@mail.gmail.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [xbt27biGVyFIGwZkT0V6uKCpau+Vg5pQ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6P191MB0501:EE_|AM9P191MB1400:EE_
x-ms-office365-filtering-correlation-id: d28342bb-2074-41e2-445c-08db9cad3e84
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fJcJKeofkFf6Avy5mOYZxSSuPMrzMV/vLKoYYnIFEzODvszFlbVIXeYJu8sYsw/J888EJSDPrSRYcmLWfEC0iF2831HZ8XBfzIx76yYZQYiJ8Wq/0/cjyHqy7nUSFv8QDJXkWtBHNcpYATz4BOgiSTcCd4gmqNtHHGThxEdPd0E/PIZR1Oe9VPxFyTcCIgfr2M0BaQMHcFQr3csC9YKdsxBfRskbIWu+ZMm/9cnBuq8e5Tw6wdYRHVLW26V8zZ2YxJ1z02KmXIrPUZ5tMjGwzz3GXN4I0pdayZy8N5ox8tcQG+Kq5kExszos04+4HSCY7X1x4eAjZoB1X5WWmqycMG2wC7u/E4cmEYq4SIh47lCDGyoVXdSrHbaiCstrcg2YJWF4xzSiCf+F65GiTveOQOZi6InuxwbZtpFHLZ9Z/Vow6bJ6hW9tEWdzIZBTllbOo0I8zSElVZV3IQoJO62d4hUUryWEXqq4mSiDvlKtLzlNl6B1xMKVCjMSVieyrkDUuaUZwJQwUsoO94ZHCmkBkQp+jxNC56qZLmDp6mJKfWM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXFka2xYb0I1N0ptbzJxaS9Nbm1zb3pLNUw5ejEwbWJqcWFkRmpQSHJPTXVF?=
 =?utf-8?B?NmhZdFh3aXE1Y21abnY0TWJWd1NqekwyRm9TRHFpaU5qMEoxem4xTWY1Zis1?=
 =?utf-8?B?UHp3c0w4NFR1QTlZdDVWY0xDeUVQMzJEWW9qM1hST3NUTlBKdWViSTd0ZGNT?=
 =?utf-8?B?UHJGZG9tU2VHclV2QXgzMVlkZnZsMVpmdTREcFQ5dHlNWElaQW9INnh3MTVv?=
 =?utf-8?B?NzE0WjByUUZWbkkvWEhPengzSVF6dkFUNGVmMTEyN3c2MENWY0xoMHNjamQ1?=
 =?utf-8?B?SUFkdFhkTlVQc093cGR0MDNseXBlNUR3U29uVGRIdTl6b3lxRWpiR2ZpT3JF?=
 =?utf-8?B?Q3daTVArdnZ1VElvMVdTbG9aY0hJanh0RlhaQURUK0lEZDhmVDZ5RXUxenhZ?=
 =?utf-8?B?RVBQejMvU3VpUXVFZGo0WXR1WjUzVTduVjFGWUtMTlprdHdiS2UrL0FKM2tK?=
 =?utf-8?B?cG9aRFRJOEpmWTEwTi9JZWJOa0NBV1YwN29xTkdNTk1RTlNDZTVybUwxMEg3?=
 =?utf-8?B?eFFURHJBVHNyaUxrRldhT3k0VitjOWR6eG9WYXArN0lCOVRxNFFlbkdTNFdX?=
 =?utf-8?B?KzZKZEw5VGQ5NHVoOTIwbmE5SWhQc3BhdEkwR3pJYVdTRFl3dnFZSHVQS3lR?=
 =?utf-8?B?cW5NenR0NEIreFlpQlJLY3dmWC91YVVPY0s5aDhKaGxGTE9uVFA3elpHQWxO?=
 =?utf-8?B?cFZTKzE3VlhkRmIrUElGUTdETit2N2x1cXFJWGhYN0FkS2cvVDNQemxqZFBC?=
 =?utf-8?B?SmJydndoVy9ya2tGbUNiQkZLOE5iK2RCYnByZ01Kb2EvYmgxbEdmMHdHeXBm?=
 =?utf-8?B?dHRDRzdoNUdDUlBHdFVHK0dyYWxHbEFRejV0RWQwQ3lsV0xrckhmcVRXSjFQ?=
 =?utf-8?B?cklkdGdSemZseHN5b2ZFK3grcEpjc0VkVkdTc3dsaU5PWkp3dlB6RVhwdkpU?=
 =?utf-8?B?R3NqTFZpTlgzOGtuS3RNdHJxTndRc013VXpFSHFDS3dMeUxqZ1I2SDBPWXhw?=
 =?utf-8?B?SEZsVkI3Q3VWOHUrbStTV3VPbEljSE9nK3ViL3BYc3ViMXhRSkN3aDlrMVMz?=
 =?utf-8?B?U1dqaHEwLzlzY2grdzVibmJyYVdkVTEzT3FYWU5aUWRlN2Q2eTlNWUNWd05Q?=
 =?utf-8?B?U0RHQmdiRXNmNHVxRTc1VlJZb0FKeWxmbnBnY1FiZG9jemNhS0Vzdmd4Q1Aw?=
 =?utf-8?B?YUtWRHpMMjM3WWRuVDJ1NHRSU3YveWlRSVlXekxIQU9WUFhMa1B6UzJEUzc2?=
 =?utf-8?B?N2hSa2xTL3phOFFwSHI1a2tsWk8zenVVNkV4TTl4K2pzNVNZZHZjbXVkSFQ4?=
 =?utf-8?B?b3hUWVd5Ui9tSEJsQy9hMU5SWS9uUER1RTJrRkJUQTdxeGR1K3dsL0plaEtY?=
 =?utf-8?B?K05PcU56MFo3cnBncHBKOHBlYUIxdThKRnFhN0N0di94aHBSYllYTHBOKzQ1?=
 =?utf-8?B?czBENklLMDBwZFlUUytSam8rMm5GOG85WXBOdGROL0FTY2FPY1BOOVF6L0F4?=
 =?utf-8?B?UkZ3cmpwZUovS2xpUHV4RUVkTFJQaEZadUZscTFDeU9PV2dKS3hHWmZhWDVj?=
 =?utf-8?B?QXNSRkMvdEQwNmtwR2pEQm9QU2hQOHlia1VJMmZSUVhWZW5rSXp1THBSTlRT?=
 =?utf-8?Q?FXD9JfTHOdM6Bpdg5Jkmz5ez0Ay9YuDys/hi3Mk5XK+Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75E70980C85BE644ADDD4E669A070081@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d28342bb-2074-41e2-445c-08db9cad3e84
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 10:00:09.4608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P191MB1400
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

RG5pYSBwacSFdGVrLCAxMSBzaWVycG5pYSAyMDIzIDE5OjExOjUwIENFU1QgTHVpeiBBdWd1c3Rv
IHZvbiBEZW50eiBwaXN6ZToKPiBIaSBCcnVubywKPiAKPiBPbiBGcmksIEF1ZyAxMSwgMjAyMyBh
dCA0OjI14oCvQU0gQnJ1bm8gUGl0cnVzIDxicnVub3BpdHJ1c0Bob3RtYWlsLmNvbT4gd3JvdGU6
Cj4gPgo+ID4gRG5pYSBzb2JvdGEsIDUgc2llcnBuaWEgMjAyMyAwOTozMTowOCBDRVNUIFBhdWwg
TWVuemVsIHBpc3plOgo+ID4gPiBbQ2M6ICtyZWdyZXNzaW9uc0BdCj4gPiA+Cj4gPiA+ICNyZWd6
Ym90IGludHJvZHVjZWQgdjYuMy45Li52Ni40LjIKPiA+ID4KPiA+ID4gRGVhciBCcnVubywKPiA+
ID4KPiA+ID4KPiA+ID4gVGhhbmsgeW91IGZvciB5b3VyIHJlcG9ydC4KPiA+ID4KPiA+ID4gQW0g
MDQuMDguMjMgdW0gMjA6NTUgc2NocmllYiBCcnVubyBQaXRydXM6Cj4gPiA+ID4gSSBhbSB1c2lu
ZyBvcGVuU1VTRSBUdW1ibGV3ZWVkIG9uIGEgRGVsbCBQcmVjaXNpb24gMzU1MSB3aGljaCBoYXMg
YQo+ID4gPiA+IGJsdWV0b290aCBhZGFwdGVyIG9mIElEIDgwODc6MDAyNiAoSW50ZWwgQVgyMDEp
LiBJIGFtIHVzaW5nIGEKPiA+ID4gPiBMb2dpdGVjaCBNNTc1IHRyYWNrYmFsbCBtb3VzZSB3aGlj
aCBvbmx5IHN1cHBvcnRzIEJsdWV0b290aCBMRS4KPiA+ID4gPgo+ID4gPiA+IFdpdGgga2VybmVs
IDYuNC4yIG9yIG5ld2VyLCBzY2FubmluZyBmb3IgZGV2aWNlcyDigJQgdXNpbmcgZWl0aGVyIHRo
ZQo+ID4gPiA+IEtERSBndWkgb3IgYmx1ZXRvb3RoY3RsIOKAlCBtb3N0IG9mIHRoZSB0aW1lIHJl
dHVybnMgb25seSDigJxjbGFzc2ljCj4gPiA+ID4gYmx1ZXRvb3Ro4oCdIGRldmljZXMgbGlrZSBj
b21wdXRlcnMgYW5kIHBob25lcywgYW5kIG5vdCB0aGUgbW91c2UuIElmCj4gPiA+ID4gdGhlIG1v
dXNlIHdhcyBwYWlyZWQgYmVmb3JlLCBpdCB3b3JrcyBjb3JyZWN0bHkgaG93ZXZlci4KPiA+ID4g
Pgo+ID4gPiA+IFdpdGggcHJldmlvdXMga2VybmVsIHZlcnNpb25zICg2LjMuOSBhbmQgYmVmb3Jl
KSwgcGFpcmluZyB0aGUgbW91c2UKPiA+ID4gPiB3b3JrZWQgY29ycmVjdGx5Lgo+ID4gPgo+ID4g
PiBBcmUgeW91IGFibGUgdG8gYmlzZWN0IHRoZSByZWdyZXNzaW9uPyBQbGVhc2UgYWxzbyBhdHRh
Y2ggdGhlIExpbnV4Cj4gPiA+IG1lc3NhZ2VzLiAoWW91IGNhbiBhbHNvIGNyZWF0ZSBhIHRpY2tl
dCBpbiB0aGUgTGludXgga2VybmVsIEJ1Z3ppbGxhIFsxXQo+ID4gPiBhbmQgYXR0YWNoIGV2ZXJ5
dGhpbmcgdGhlcmUuKQo+ID4gPgo+ID4gPgo+ID4gPiBLaW5kIHJlZ2FyZHMsCj4gPiA+Cj4gPiA+
IFBhdWwKPiA+ID4KPiA+ID4KPiA+ID4gWzFdOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcv
Cj4gPiA+Cj4gPgo+ID4gVGhlIG9mZmVuZGluZyBjb21taXQgaXMgaHR0cHM6Ly9naXRodWIuY29t
L1NVU0Uva2VybmVsL2NvbW1pdC8yODhjOTAyMjRlZWM1NWQxM2U3ODY4NDRiNzk1NGVmMDYwNzUy
MDg5IDoKPiA+Cj4gPiA+IEJsdWV0b290aDogRW5hYmxlIGFsbCBzdXBwb3J0ZWQgTEUgUEhZIGJ5
IGRlZmF1bHQKPiA+ID4gVGhpcyBlbmFibGVzIDJNIGFuZCBDb2RlZCBQSFkgYnkgZGVmYXVsdCBp
ZiB0aGV5IGFyZSBtYXJrZWQgYXMgc3VwcG9ydGVkCj4gPiA+IGluIHRoZSBMRSBmZWF0dXJlcyBi
aXRzLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxs
dWl6LnZvbi5kZW50ekBpbnRlbC5jb20+Cj4gCj4gRG8geW91IGhhdmUgdGhlIGJ0bW9uL0hDSSB0
cmFjZXMgc2hvd2luZyB0aGlzLCB3ZSBhbHNvIG5lZWQgdGhlCj4gZmlybXdhcmUgdmVyc2lvbiBh
cyB3ZWxsIHNpbmNlIEkgc3VzcGVjdCB0aGlzIGlzIGR1ZSB0byB0aGUgY29udHJvbGxlcgo+IHNl
dHRpbmcgdGhlIFBIWXMgYXMgc3VwcG9ydGVkIGJ1dCBiZWluZyB1bmFibGUgdG8gdG8gdXNlIHRo
ZW0KPiBwcm9wZXJseS4KPiAKPiAKaGNpY29uZmlnIHNheXMgdGhlIGJlbG93OiAoSSBhc3N1bWUg
4oCcUmV2aXNpb27igJ0gaXMgdGhlIGZpcm13YXJlIHZlcnNpb24pCgpoY2kwOiAgIFR5cGU6IFBy
aW1hcnkgIEJ1czogVVNCCiAgICAgICAgQkQgQWRkcmVzczogRjA6OUU6NEE6RTY6NjI6MTUgIEFD
TCBNVFU6IDEwMjE6NCAgU0NPIE1UVTogOTY6NgogICAgICAgIFVQIFJVTk5JTkcgCiAgICAgICAg
UlggYnl0ZXM6MTUwMDUwIGFjbDo4MTE0IHNjbzowIGV2ZW50czoyNzAgZXJyb3JzOjAKICAgICAg
ICBUWCBieXRlczo1OTcwIGFjbDo2OSBzY286MCBjb21tYW5kczoxNzMgZXJyb3JzOjAKICAgICAg
ICBGZWF0dXJlczogMHhiZiAweGZlIDB4MGYgMHhmZSAweGRiIDB4ZmYgMHg3YiAweDg3CiAgICAg
ICAgUGFja2V0IHR5cGU6IERNMSBETTMgRE01IERIMSBESDMgREg1IEhWMSBIVjIgSFYzIAogICAg
ICAgIExpbmsgcG9saWN5OiBSU1dJVENIIFNOSUZGIAogICAgICAgIExpbmsgbW9kZTogUEVSSVBI
RVJBTCBBQ0NFUFQgCiAgICAgICAgTmFtZTogJ1tSRURBQ1RFRF0nCiAgICAgICAgQ2xhc3M6IDB4
NmMwMTBjCiAgICAgICAgU2VydmljZSBDbGFzc2VzOiBSZW5kZXJpbmcsIENhcHR1cmluZywgQXVk
aW8sIFRlbGVwaG9ueQogICAgICAgIERldmljZSBDbGFzczogQ29tcHV0ZXIsIExhcHRvcAogICAg
ICAgIEhDSSBWZXJzaW9uOiA1LjIgKDB4YikgIFJldmlzaW9uOiAweDIwY2UKICAgICAgICBMTVAg
VmVyc2lvbjogNS4yICgweGIpICBTdWJ2ZXJzaW9uOiAweDIwY2UKICAgICAgICBNYW51ZmFjdHVy
ZXI6IEludGVsIENvcnAuICgyKQoKSSdtIHVuc3VyZSBob3cgdG8gYXR0YWNoIHRoZSBidG1vbiBv
dXRwdXQgYXMgaXQgaXMgYSBiaW5hcnkgZmlsZSB0aGF0IGNvbnRhaW5zIHBvdGVudGlhbGx5IHBy
aXZhdGUgaW5mb3JtYXRpb24gKG5hbWVzIG9mIG5lYXJieSBkZXZpY2VzKQoKCg==
