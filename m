Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E32C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 21:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbiFVVnT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 17:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiFVVnS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 17:43:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB66340CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 14:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ORVv0GMTGJVDg7Lo84q1s68zb8iNOdXNjXuwxfsXBWztJGuER01Ofrdq7Vn6KuCDWwaR4X4PMctDmEZH4/ZlFQbjMk4a4ZRA/WDUq0cusNiaMfQBjwEj/+cRj2USbrJs8H9E712dqaN8D+tSfxQNs18slAjWy28DEZWj7IZUUDvOKnT5g+Nj160iVcgjQt9WF9C0yOppJEA8N0zRW78CzSC+2gALYsQk1HBoSqAxy3t0pMksbVVG9UGkDXjZYuU353ss6CM31brFyg19hxtsqwGLVlcXrd71yVKR3rDBMZbVMlCxCYO7vXbKOjJvU7yuiLK9ZAd2IMHvm5Q/WpPiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VPIBCPDWASS/C3c5fcLGEXeiOWOBely1uR1897a/j6M=;
 b=oGKzugWYwJUwgGoHmVSbEQ/WYrF8kG42Wyws6WWmbjx91IwXE8cF43adw478fBd9flpBBZJRTxcTGrhTo5guTQ22fm7zDhJXy1Cj3Vy96qR2vYP7S2PfXd5WmrQJhPETu6wpOzZ21Xa6aoso/AOKRt5nZh2FTPcUbIxc5140zz/ultRdphID8YMMAjfQ+PUD5BQaIIHyOV0B/64gKHkhT7DmKXLaxEpZyVqNbzH4em8E2qAVasgVEIvhkTp3GWf804ekWuGGdqoj5Me8RbjfMUEvJ3xWJ/9wKGztG0gm0pPsiVZaAmFTpFyR4yLVMVRvTrFuPVgLLC2hFNcEKRHRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPIBCPDWASS/C3c5fcLGEXeiOWOBely1uR1897a/j6M=;
 b=XKUGKcQPPCYxhQRMsu7QWtmgDyCCvHy4sfh8BmVuFXxwJrcMm0wmnKBj1mrR9G9DzwICMAH9gICr+6YftcBbRmyYN3KRA5QHMUv7KT/ZLHhIR+Sf7vXMqjlx4lBKNaRmADtv3YPZ1pWja4JEA9vd1Je1uq77+m5XLm9dTugDYrZNJgCV4USmJIVILupPVBZ0QFs34ZlRB2fFKsydIkbgj7iAB9d8UahGjkRjVDe57pYRYKh0f+mOCBBeT9vwwfWCekYm2gMk8n1lPdMx/+i+JxCK3Qh+Lqm3WFNtaFaIl/lDJMhdpE0Idyz5xQtZUkWQOIKyOSjZGyCVb4wWdhBMyw==
From:   Thomas Green <TGreen2@Sorenson.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: third time
Thread-Topic: third time
Thread-Index: AdiFqz19yiGChj+TQGudncH0+5ea3QAA9vwAADMZpzAAAQA7gAAAUn4g
Date:   Wed, 22 Jun 2022 21:43:11 +0000
Message-ID: <BN7PR04MB5267899C0B47D40E28784BC09FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
References: <BN7PR04MB52674E1CAADA5B0550C3F6959FB39@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CABBYNZLaPxBMvVXWx+yqQz-SyxptdMfEZ5TPQVP7q4otpcbErg@mail.gmail.com>
 <BN7PR04MB526737063784913B34568C009FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CABBYNZ+Ak=U1UUmYvWwfGOMMQNBAFKpbNm_ZoUTcGvCw7EYxpQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+Ak=U1UUmYvWwfGOMMQNBAFKpbNm_ZoUTcGvCw7EYxpQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5924e89-455c-40d4-e39f-08da54983405
x-ms-traffictypediagnostic: PH0PR04MB7653:EE_
x-microsoft-antispam-prvs: <PH0PR04MB7653E90B59F0D861FB46465B9FB29@PH0PR04MB7653.namprd04.prod.outlook.com>
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR04MB5267.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(39850400004)(396003)(136003)(9686003)(316002)(66446008)(966005)(6916009)(42186006)(186003)(2906002)(478600001)(26005)(53546011)(5660300002)(66476007)(7116003)(66946007)(71200400001)(8676002)(8936002)(41300700001)(66556008)(64756008)(76116006)(3480700007)(86362001)(83380400001)(52536014)(33656002)(122000001)(38100700002)(38070700005)(19627235002);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XnhdyNsAi3B0L/qJ+sVEh1bJRZDbeusdlETGPypn3HHVd1wNtRSbtXTp0dgTxEmy8fvDpZ+UCBxAzCGeqHetPu4kXUpYAnJFJlvvED3tFR+i/MdYN/NUOABivdtgBDhmz3/F5LvVgtg6Hed1FxFzSbD/j2X8hYd8l+VkAdTyGm3RoXha3mkI77w5mOJAdM8exvTLnfQO4OZeyyVt7lpQrSaZH69mqQ6dF9tzV/yRSOpRislVimGZFMtZB9Q00g8C1Rw1+LpFBhCFeAP9Vcj1gLruffyOfsUUOqAKnMHvkgm6Zf+nppofYmgVFduMgZ5mDGQyH9M+Uc5+VkraQraI/bRg4Z99zemEmz3kyCF02u5HqdsRPlGXMEQa3IP23neDI6HGcwZ+l1m7yNzRRzlBP6TfDXC3z+PjcK/TOeA0oydKKrPUr2Xyk/NL24B02bxS7bd0Zd8COQTTxon0PUKXOLOcPJp4k57PC8TTFrcMv0nBdmkJaPqnSo+bH3nTaK43kCUj3S/hjg+Gt9XRz+i9ROewPn5h009MLzTVCwl9vDdvQUYZTQlEqRmNf0PdlSF4Xi9EYfQKeACEf0vPoFYOKS+PleePDWNaUt34NKl6DLF7qf7P+tJ/+twQYRpXksRu/Wc7f98P0CEDRdwLp9PdQITiQUlDafaX/JZjzB3SncVrvDlk+k95mrAO+0ikYakV00oWt06r+WhlvrWl7mEtyO4vEIla/itXR2Ja9TAtiDTmBGi+JXfzy3jt9oNIIL4n3pBO6t+9ulNpUPa6p39Lfdc0v1g6BDw8A030lgf/h8E=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VllzVXRKNTVmNHdqR09kS3dUalpOT2tBY0szMlcxNmx5TVE0by9vWVY3VnJW?=
 =?utf-8?B?L09td1RPTzBacHdYcXhITVUyNGlQOGpmNkhYSVFmOWxUbnF6aStuOXcvcy9G?=
 =?utf-8?B?aWI1cEg0MTEwc3RPdjZQaXlKQ2Yyd3g5dkE1MnNHQWd1bysyNjE0VCttMlRl?=
 =?utf-8?B?R0gzVjJXVUEwL0prVDZNWWF3MEN3NDN1S1hJc3o3NDQweTZrbHdWaWh6aUFx?=
 =?utf-8?B?VTI1MzNFdUt5cUxacFl6bDJMOTVyUC96QmpINzZ1NmpoNFNYTERxY3h6VGdp?=
 =?utf-8?B?WlNlOVRweXcva0ZJNjNTTkx2anRyeDRPR3VJdDgrK2oyay9taGpKL3pBZUNh?=
 =?utf-8?B?QXY2VzhDSmFnWVI3aWJkaFZVS0xTUWlGOGltby92dTMxTVhJa1V3OVhBem1K?=
 =?utf-8?B?NTF4V3laZEQybktKU0RDYzNLZ2RwWVFORWtKWDE2cmJNSUdKaHdVditnUWxU?=
 =?utf-8?B?WnhxbTIvWFFGbEpxbGIzWVZvVXhVOVhhZW5wN3NNYlNpTDJ0MXZCUW9vZ0lq?=
 =?utf-8?B?K29INjJYdGlhOFdlYjBGaDY5M0plVEdjYko3S01vYjBydHVLbFNpZUFXRHlG?=
 =?utf-8?B?enVzTzFZRHoxSyszSmtxalJRL1BjWi8yWTNpeDhFNzlBdE9oemlKYjZTQmlp?=
 =?utf-8?B?eVh0WkNVOUhvYWNxU25DYmdxTVhmZGJKajNUbDdhU0k4bWtnejV6YS8zdVNE?=
 =?utf-8?B?T3IrL1hSSGN4eGtMZk1leVNVQWpSTHpraFUwSThiaEorek9rRS9yam5LbU44?=
 =?utf-8?B?STNXblZMZkNkSHgwTzdvRjhxSVNhSEdmV3BHdU44ZDN2dXFEMmNWNjIxcXZn?=
 =?utf-8?B?YlMreGNXUnBRQlBncmlVcmc2VXdRdDZZWFRZRGN5NHM4MFBBRVRiNDFYaFJY?=
 =?utf-8?B?N1JXYTBiRVpHNnBZRGY3NkU4UkphZFd6eDYwbWZuNm04SW1WL1I4d09BTHNq?=
 =?utf-8?B?c0IzS2ZQSkU3UnF1ekgrNU1rT2F3bmNrTGNIY25YTGlKVFFNdTVWeC9BV1Aw?=
 =?utf-8?B?YW5sL09BdTBYNEZWY08zVHJlYWNhUk9DdHFFK3J0VmxkTVZ5cm9SSnViK3J5?=
 =?utf-8?B?Qyt0enRoUGxTK1l4eW9QZ2NwNFIwNHpRU3lQTXE4UUk1NWF0Ris0UkptNHpS?=
 =?utf-8?B?dG1hNDBCTHlqZ1pLUHh2ZkFUQ3RqbzFwSDQvd0lvbDJlK1VIY0xrM0tmZXc2?=
 =?utf-8?B?NEFqV3RIQXppQlF2Q1lpOUhmRytnWXVUeVVoY25YMWlmZ3VkZ1JuOGdCbmMy?=
 =?utf-8?B?ZEJLVXQ2eVQvRGVxWXhQNTFwNVpRRGhkRUtxejZ2QkgxYXFINVZ2UEpOYWpH?=
 =?utf-8?B?VDErdTY3U25PYlpTYXk2U0xBeEdBL3loWVd1eTFYZ1dOTU53dnYyb2x0a0tj?=
 =?utf-8?B?cDV6V0Fna0d5U2NQczF6MklpbkZhT2VZK05vWk9INEpXc29YK2RIQ3N3V1Bv?=
 =?utf-8?B?dVhZWnFXOFJVQWc4MTRadE53dlJCUWxGVFdJWFdSYnRKM1JqZTlTT1kwL0FW?=
 =?utf-8?B?RldxVmNSdURvWmFzK2c4Nnp6bGUwdnIrN1g1dFhGOVZWNys0cVdIVlVCV2cz?=
 =?utf-8?B?VUpjTHlYc2FPbzE2ODU4bHp4WERFcnhYbERISGkvWkduekFxY1V5UXlNYlRR?=
 =?utf-8?B?b0J0dnpQZ2NDc3RpMDZickx5YlBGTEM0MmNsSTA4WFludzB4aDBtNFl0OE04?=
 =?utf-8?B?QnFCb3owZVdGYUlibDh3TTBuYloxKzYxZmtoT3h2aitYR044dEpjOUFlTDE5?=
 =?utf-8?B?TVBhaGt4ekt2TzdJa1VYdTZONytqOUN5N0tScmI3N2d5ZnkrWW5iN2lSOTNK?=
 =?utf-8?B?NlpjUm02emIwTE1WVTgwMjVxVGJzblpKQkFBTDVnNGJRVjh2QVIxSjFUQlNN?=
 =?utf-8?B?REdUK2lkdDMxSno0WFNJWFRNb0k5NFRQTnllK2ZEV21VRGVFN0FXazdFK2Fr?=
 =?utf-8?B?cm5wb0RWZ0kyM3Nreml4Wm9jZGVUQy84b3Z2QVp1ZHdnS0dmb2VJUUJHZW5W?=
 =?utf-8?B?SStUNFI2USs3ek9MS0ZRY1l4dlg0eDBsckxDSFhjK2VLWUpHMGFibldqdzlo?=
 =?utf-8?B?T29qNmxBaWl6Q29mSEVYMU5KT1VKQ2huS3UwQk9ZOWdma2k4NjRmR0l2aElk?=
 =?utf-8?Q?p9tUCm6AyiVzoW/BZOSEQqFFh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB5267.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5924e89-455c-40d4-e39f-08da54983405
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 21:43:11.0753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3nxhtriUgospuCFXkMwY4GNAdWZJTbOMyEmrZppWeK+u9AntjcOpqeABozayhRRep4q55L5fVP76EFr04jC+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SSB3aWxsIGF0dGVtcHQgdG8gdXBkYXRlIG91ciBidWlsZCBzeXN0ZW0gdG8gdXNlIGEgbmV3ZXIg
dmVyc2lvbg0KDQpUb20NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEx1aXog
QXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPiANClNlbnQ6IFdlZG5lc2Rh
eSwgSnVuZSAyMiwgMjAyMiAzOjMyIFBNDQpUbzogVGhvbWFzIEdyZWVuIDxUR3JlZW4yQFNvcmVu
c29uLmNvbT4NCkNjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBS
ZTogdGhpcmQgdGltZQ0KDQpbRVhURVJOQUxdIA0KDQpIaSBUaG9tYXMsDQoNCk9uIFdlZCwgSnVu
IDIyLCAyMDIyIGF0IDI6MjIgUE0gVGhvbWFzIEdyZWVuIDxUR3JlZW4yQHNvcmVuc29uLmNvbT4g
d3JvdGU6DQo+DQo+IEx1aXosDQo+DQo+IFRoYW5rIHlvdSBmb3IgeW91ciByZXBseS4gIEluIG15
IGZpcnN0IHR3byBhdHRlbXB0cyBJIHBhc3RlZCBpbnRvIGl0IHRoZSBsb2cgZmlsZSBjcmVhdGVk
IGJ5IHJ1bm5pbmc6DQo+DQo+IGJsdWV0b290aGQgLS1leHBlcmltZW50YWwgLWRlYnVnIC1uDQo+
DQo+IFRoZSB2ZXJzaW9uIG9mIGJsdWV6IGlzIDUuNTAuICBJIGxvb2tlZCBhdCB0aGUgcGF0Y2gg
eW91IHN1Z2dlc3RlZCBhbmQgDQo+IGl0J3MgYWxyZWFkeSBpbmNsdWRlZCBpbiB0aGlzIHZlcnNp
b24gb2Ygc3JjL2RldmljZS5jDQo+DQo+IEFyZSB0aGVyZSBhbnkgZnVydGhlciBwYXRjaGVzIEkg
c2hvdWxkIGxvb2sgYXQ/ICBXb3VsZCB5b3UgbGlrZSBhIGNvcHkgb2YgbXkgbG9nIGFnYWluPw0K
DQpPdWNoLCB0aGF0IGlzIHF1aXRlIGFuIG9sZCB2ZXJzaW9uLCBoYXZlIHlvdSBjb25zaWRlcmVk
IHVzaW5nIHNvbWV0aGluZyBuZXdlcj8NCg0KPiBUb20NCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFp
bC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjEsIDIwMjIgMjo0MCBQTQ0KPiBUbzogVGhv
bWFzIEdyZWVuIDxUR3JlZW4yQFNvcmVuc29uLmNvbT4NCj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2
Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IHRoaXJkIHRpbWUNCj4NCj4gW0VYVEVSTkFM
XQ0KPg0KPiBIaSBUaG9tYXMsDQo+DQo+IE9uIFR1ZSwgSnVuIDIxLCAyMDIyIGF0IDE6MjkgUE0g
VGhvbWFzIEdyZWVuIDxUR3JlZW4yQHNvcmVuc29uLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBJJ3Zl
IHR3aWNlIGJlZm9yZSB3cml0dGVuIGFib3V0IHRoaXMgaXNzdWUgSSdtIGhhdmluZywgYnV0IG5l
dmVyIGhlYXJkIGFueXRoaW5nIGJhY2suICBJdCByZWdhcmRzIGEgR0FUVCBkZXZpY2UgdGhhdCBj
b25uZWN0cyBhbmQgb3BlcmF0ZXMgY29ycmVjdGx5LiAgVGhlIGlzc3VlIGlzIHdoZW4gd2UgY2Fs
bCB0aGUgQWRhcHRlcjEuUmVtb3ZlRGV2aWNlIG1ldGhvZCBmb3IgdGhpcyBkZXZpY2UuICBTb21l
IHRpbWVzIHRoZSBkZXZpY2UgaXMgcmVtb3ZlZCBjb21wbGV0ZWx5LCBhbmQgZXZlcnl0aGluZyB3
b3JrcyBmaW5lLiAgU29tZSB0aW1lcyBpdCBmYWlscyBhbmQgYmx1ZXRvb3RoZCBiZWNvbWVzIHVu
dXNhYmxlLiAgRXZlbiB3aGVuIEkgc2h1dGRvd24gYW5kIHJlc3RhcnQgYmx1ZXRvb3RoZCBpdCBk
b2Vzbid0IG9wZXJhdGUgY29ycmVjdGx5IHdoZW4gcmVzdGFydGluZy4gIFRoZSBkaWZmZXJlbmNl
IGlzIHRoYXQgd2hlbiBpdCB3b3JrcywgYXQgdGhlIGVuZCBvZiB0aGUgcmVtb3ZhbCBwcm9jZXNz
LCBpdCByZWNvbm5lY3RzIHRoZSBkZXZpY2UsIHRyaWVzIHRvIHJlY3JlYXRlIHRoZSBkZXZpY2Us
IHRoZW4gcmVtb3ZlcyBpdC4gIEFsbCBpbnRlcm5hbGx5LiAgV2hlbiB0aGluZ3MgZmFpbCwgdGhv
c2Ugc3RlcHMgZG9uJ3QgaGFwcGVuLiAgSSd2ZSBwb3N0ZWQgYmVmb3JlIHRoZSBzYWxpZW50IHBh
cnQgb2YgdGhlIEJsdWV0b290aCBsb2cuICBUaGUgb25seSB0aGluZyB0aGF0IHdpbGwgbWFrZSBi
bHVldG9vdGhkIGZ1bmN0aW9uIGNvcnJlY3RseSBpcyB0byBzaHV0IGl0IGRvd24sIHJlbW92ZSBh
bGwgb2YgdGhlIHNpbWlsYXIgR0FUVCBkZXZpY2VzLCB0aGVuIHJlc3RhcnQgYmx1ZXRvb3RoZC4N
Cj4gPg0KPiA+IEkgaGF2ZSB5ZXQgdG8gaGVhciBpZiBhbnlvbmUgaGFzIC1hbnktIGlkZWEgcmVn
YXJkaW5nIHRoaXMsIG5vdCBldmVuIHRvIHRlbGwgbWUgaXQncyBub3Qgc29tZXRoaW5nIHRoYXQg
bmVlZHMgdG8gYmUgbG9va2VkIGF0LiAgSXQgaXMgc29tZXRoaW5nIHRoYXQgcmVuZGVycyBibHVl
dG9vdGhkIHVudXNhYmxlLCBzbyBJIHdvdWxkIHRoaW5rIHRoYXQgaXQgaXMgc29tZXRoaW5nIHRo
YXQgbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8gbG9vayBpbnRvLg0KPiA+DQo+ID4gSWYgYW55b25l
IGhhcyBhbnkgaWRlYXMgd2hlcmUgdG8gbG9vaywgb3Igd2hhdCBtaWdodCBiZSBnb2luZyBvbiwg
DQo+ID4gSSdkIGxvdmUgdG8gaGVhciBmcm9tIHlvdQ0KPg0KPiBEbyB5b3UgaGF2ZSBhbnkgbG9n
cz8gQWxzbyB3aGF0IHZlcnNpb24gaXMgdGhpcyBoYXBwZW5pbmcsIHBlcmhhcHMgeW91IGFyZSBt
aXNzaW5nIHNvbWUgZml4ZXMgbGlrZToNCj4NCj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2JsdWV0b290aC9ibHVlei5naXQvY29tbWl0Lz9pZD01ZWJjMmI1YQ0KPiAzZTQ4ZGJlNjdh
MmQzMTU5NzliMDk2YTFiNGQxZWI5OQ0KPg0KPiA+DQo+ID4gVG9tIEdyZWVuDQo+DQo+DQo+DQo+
IC0tDQo+IEx1aXogQXVndXN0byB2b24gRGVudHoNCg0KDQoNCi0tDQpMdWl6IEF1Z3VzdG8gdm9u
IERlbnR6DQo=
