Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C014C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 21:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358288AbiFVVIm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358214AbiFVVIc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 17:08:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA62F01D
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 14:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjOR/hSiP7BmLWXMldbKXerrJjNMuK/0b+dkmBdTyI7ql4QHKW/cQ5UUBFN2lySZ2dVTF9IvwnEKtKIF8m8RhAPugUo5+fzPqQUZuvgnU64YhRUuQW/uMwuHsObWm2O4DZdu6pfVWNxQz7tNieumlUWIr44uNvnIdYo42PSxjIqpZDLrXW0Q2HHdeYHfVY1+lArZd52/pcgbFtVemCbwRA7++biiyvzbkxNoYkjytP7LdH/U7v8kUJcKvEPy+jhtkcSqphFgnniiBy2k7elD3vjV+h/twnKFgxKqB4kHET6CGJHqJPv3rRMmnpHhetJHUZXdZpcJX4fPTGK4y+RCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJFtnhavOc8ktMrJYv627EUeruMyjxpOLm7H9J82tNQ=;
 b=H1x1DkuqFONzivDi61DbrR3u8m1T1tqYxZCCPb8hPEKRLVubZ6txY491l1CVjTkmkPBBBNV0vFsdxnRHR8UcUGkWBSbJWSagjgjFMPCK/JdUrf5Su2T8fIWV+HjARIhqY9MZ3geUFgpU9BGSkgh71kOeKLFuJg32JmuioGFIkPmW1m4sLVSfCIHeSdIUOkQGk6zGXYNmRNML2dsixC2O/RXhpv5Onk7juMRc5jl4Omg4lCZejcuABR+fLEb0l5KC/WgrRp23kAwPpmUd54rMGkH4dgc+6ktTlVDVpQCdb4ojyHBBXZHfX/fBtKvAXXbUisrbBLJTJkSvWmke+g27SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJFtnhavOc8ktMrJYv627EUeruMyjxpOLm7H9J82tNQ=;
 b=Ykjc/zjpxbAryrGEL4BfZaxr0dJhDZrtE4Hmq7qvx6XbpXgZTDlOEVkr6et9xi3KNZzmqUCHaoJdWyQUvoa4NITFHtVhXdkUBEshIhjmPOqRn/3kC6Da3DpG3Tz7F4uzqkeJQYO0rFNOmbQkkIOZgAM9SAp6yFh5w3wR/AqsDp+5jPRNuup7ShMO1bGZ7ICy70NxZFh1MjX9jUFkS5RvBnRvNX7fKU7nkLg38nocJAZdymfelGjds7SZxns9l/n2wSfdRsGH336btbuEYBM0QIie3kLmfVLa/7qNPEkPwbCRUb10Cc+SJOlyqbzB/WKiFE9cupsePxqUQ/1ogFfUMA==
From:   Thomas Green <TGreen2@Sorenson.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: third time
Thread-Topic: third time
Thread-Index: AdiFqz19yiGChj+TQGudncH0+5ea3QAA9vwAADMZpzA=
Date:   Wed, 22 Jun 2022 21:08:23 +0000
Message-ID: <BN7PR04MB526737063784913B34568C009FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
References: <BN7PR04MB52674E1CAADA5B0550C3F6959FB39@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CABBYNZLaPxBMvVXWx+yqQz-SyxptdMfEZ5TPQVP7q4otpcbErg@mail.gmail.com>
In-Reply-To: <CABBYNZLaPxBMvVXWx+yqQz-SyxptdMfEZ5TPQVP7q4otpcbErg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4b54b97-a536-49aa-0b08-08da5493579e
x-ms-traffictypediagnostic: CO6PR04MB7521:EE_
x-microsoft-antispam-prvs: <CO6PR04MB752107633191C54A0D0DEA379FB29@CO6PR04MB7521.namprd04.prod.outlook.com>
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR04MB5267.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(396003)(39850400004)(136003)(42186006)(66476007)(66556008)(64756008)(8936002)(53546011)(6916009)(66446008)(966005)(478600001)(38070700005)(33656002)(71200400001)(7116003)(2906002)(86362001)(41300700001)(52536014)(26005)(76116006)(8676002)(66946007)(83380400001)(9686003)(5660300002)(316002)(38100700002)(19627235002)(3480700007)(122000001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +OQakPHM3JDWzUG929IGmbjjRsrnRgbACm/szrDtKczcf58jnXCZT7hpv5ATyaOKZ6SE1eYg+nJl1TAEmWqRSBo8uEsIGAzeb+6bMDC7VPevpcyW3+Shm1cBhs7GF1v7acv+vKxdG+Gkd/KpLtPXUNSTUmTTHonXmnWb4Vq/lalt1M8x2nqVQN9sQomteCDXh5vHugX+ssan+4lP5p9xkVDp3/eoaKfJmmCccVQjATr/JcY7MAO0rBOs+14pLR+vu/bn4TxJKrHJKNCeIrwjXLaGciOC0mKmAj0wO8JgvQEjPLbTvYfqlHIYXLksfWO5ntooqqrumZpQP197dL/eVAhCu6bjVwoZZfSM78bxUmFahr2AiiTaiuaZHH/f5ecwnp8bqXYfbPlIaAQuFQ5T+iP89Ew7vEuNbqMgf0YezP8uWG7v0Z8rUksw2iAKn3wU5dH08VrTf/sUjXf5S7/jvgs7maNEZLM8Qs6MLSfJlfaMaoDDbIfeUkScytuazFrymeBrMgLBk0lsehVxGhGA6pXYgloPnnyJ7xuQE5LstQ5cs8TL18IFQHlvkhyDxgk0Tm18sCc0jVWBnt/8TFck5Lgi/1nbVLEUbImoQTH+SFYzk4bZccINz1rdp5ZZZY4c1tyPN+HyKBt0fhJ7pkvSAfafnfvL7+4L/t/ddFm+JbdDRkf6nvDwB15JkDqTAwy/e4rnoEj0V9U5HDpW+BVYbp5ahDEzPCtluzkHiBSEmbwpJCZxvupblry36+JLFAqLY+c688IaFB2QGXAn6SndlxUgXUvRgOAy06JEBHdXzuM=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTQ0eWJjVlB2VXZzVkVQN2xOaG4vc2ROcHd6d2VPKzBTRUR6Z2poSlFYNkoy?=
 =?utf-8?B?NXIzNnRYck1ZU2prRmR5RFVYdDBXenB4cG9jbDlFOVhaQkFxL1FGay9IWE5U?=
 =?utf-8?B?NmsyWGdqSG4yM0JRQjhuSkhEUFFCUjVkdlQ3SVRRWnVOSlBXOUFBMEk3aUxP?=
 =?utf-8?B?Rk9kV1lJSUVRTkVLd1B6RHp0aDFmNmdKZ0F3aEF4b3ZyREYxbmE0ZFpsdngr?=
 =?utf-8?B?SUQ3RGxsMU0rZVlyaG05QURieXp3Ym1ieVlZYXVvVXBlMlhRN0xTR2pBTnN6?=
 =?utf-8?B?bkl3aE53MTdxemhhS1RieFk1dDB2ZjcrOEsvbjc1R0JVSVpsRElrMWprS2pZ?=
 =?utf-8?B?cURkd25FSXo1THdRSDk4amxBWEJObS9jSUorR3MxNEFIc1E4ZDhwV2VyZDB1?=
 =?utf-8?B?ajNFbUpsajVraUJGNFlxU0VKa3A4eXlWdkFTVGpMZys3NXB6MjZoVTZOemIr?=
 =?utf-8?B?TndwWlRsOUdIZzJxTnlKK0xRK29xWnAvVWVyNGZXQzNhbGlXMUJ1bEtqbkJ5?=
 =?utf-8?B?aUJBaHNIUktOdHVla0dmYms1dU1tY3UwZm5xaGdGUHRKRFV3TEdON01sUDZU?=
 =?utf-8?B?MUoyeHVpcUtmSEF3b3NGN0lsaWRQRFhxSkkxZlQzNmJrMXBNUDZ1WlUzc1p3?=
 =?utf-8?B?TE5yckx4cHh2akplQjhRcG5iOXF1THM2TlF4aTY1VmJuSEJaR0RibnFMQ253?=
 =?utf-8?B?SG1rRWpIVUtKaXg1aDEzYXo5VXlUMHdUNk9jL24ra0xqVjI0SlFzRjd4empP?=
 =?utf-8?B?R3YrY1BFcVBlSFVuR3g4TmFrN2tJb0w1aUZHbktrZjl3cUdkNWpqZTBVNmV4?=
 =?utf-8?B?MUFrZ0x4VXoxTW5BZlY5bWduSXZkZk8wUUVCVHlYYTZxWHpGa1dGWXB3clli?=
 =?utf-8?B?VVZGTWhyMG51NnpFUGJINUUvWEVXK0VySnNHZndIeWR2eFBaa1dzYmw4K0t5?=
 =?utf-8?B?RVNta2YzWS9hV0xLZDRWc3NmdGRwRWVpQ3h4QlVRelFtV1VycXRCc2ZKcFV0?=
 =?utf-8?B?c1RFSmU4TU1uZmZSY0M3SDl0S3Y5YkJrbmNOZzRYNDZZZWJpU1dSVWowR0U0?=
 =?utf-8?B?VEY2b3QvRkJuNEhNaHRZSHc3MXA4WDRCcmNoSzFCR3Byb29MNjVDWUVxSGZn?=
 =?utf-8?B?ZmVJcHlhMjRDcFlERVNYZDJFYjZVYkl3dngwYVBmUytRUVZsdGZDNEtXRTlZ?=
 =?utf-8?B?aHRneEt4cTRRRUlIUGV1Qm0rZTFrR2dMeHM3d3BKemFKTVFibkJFN0FxYitN?=
 =?utf-8?B?cGZuUmt5eTlmSXpHVWNxVUxFSU1DeE5hZ1NCZ3IwNExHSVh1MHFqMXVEMVhu?=
 =?utf-8?B?akFhNHdOTUVLb2lpQUIwM2xmRGRPc1NpZXd6L1d0MWdVdHE2TWczS3d1SWZH?=
 =?utf-8?B?aVp5TGg3RzRXWVNsV0JlRkF1TGpVcWJWaDIrYmV6b3NoS281dE0xRHMrL29J?=
 =?utf-8?B?OTRrd3o4bnRDZ0F5MENQWUZOTVZZMlRsSHZjeGdlUDBxQWh4L0NhSXR4Y1Fo?=
 =?utf-8?B?cFduOEFQRHYrZ0hLWElRNWh0SnZrdW9VbnEyQytpNjE2NEg2OStDQzQvekd0?=
 =?utf-8?B?clRXdTAwS0FjSG0wNGtoYVIyMi9NSlhXWFhuanVob2JLM3E4OW1jaEpjWHYx?=
 =?utf-8?B?bnZVaTdZWFJNRnJmR2l4TzF0bHdncCtlTGdScm81K3JmU3gxYUw3Mkl3ZEZC?=
 =?utf-8?B?YTEweUVXWkRnTXVxNnphYnFyMFZlN2pwemNJN0hjNG5XczdaSmdVTWlxWHBM?=
 =?utf-8?B?NUF2dmVPMUNzNjlMaHlrektQZlhoWGtPVk0vZFkyTTNQU2tUT2QwaGdLeTVp?=
 =?utf-8?B?RERMeWMwM2ZpUUJQZ1k3VXJMTzlaL2NZdVQ5dHVtMTFXTHFpUnd6TW5sd0Z5?=
 =?utf-8?B?aTZnd2JxTkRoZjBjcHYzUEpqblF6UDRyT2hUMm1nQi9jb1ZUOVNPSE1pRlJ4?=
 =?utf-8?B?TmtCZHN2NDlmcUNOc3BZa0xjRWFiT0FOTWU0c2graURUbk9kRjZzQzNtNytZ?=
 =?utf-8?B?UDZXWEY0bm45NTM0eGVCTGN1a2xGNWdMUVJBUFFZbkltVXNJcUF0Y3dIWmdF?=
 =?utf-8?B?U3pUMWV2WUZCMWc5VHF1WGdtbis3ZjRaU0wwckpNbm1sNEh3TFkrN2JNbUMv?=
 =?utf-8?B?SXBpRGFpaWpLU0s1SUx4MThlL0EySEZpQTJOQTNrcnlRbzQ3SjJrMFJrR1pE?=
 =?utf-8?B?ZU1XKzBaNlFLUWJIU3U2UUNsWkJsZ2dLZnJJaGxrRDRITnJEQm5kUFZqKzVD?=
 =?utf-8?B?SlJzaDQyUWxEclA3cmpZM2F2SXJZTEhmUWptVzhLdlowa1psUnpZdXFpOFVC?=
 =?utf-8?B?bkE2eGFucmQwK01lREhrOTJpUlh1ZVJjZGhxaUlvTXpMWXowdUV0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB5267.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b54b97-a536-49aa-0b08-08da5493579e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 21:08:23.2778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OLRSsu5LW9+jxwFMFiPn0/Vhc0h3GMAspZuzjOokydcSxC3bmhJ1CYCS1KMmWg+dodwzyEufo6OM8PYyH/RVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7521
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

THVpeiwNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5LiAgSW4gbXkgZmlyc3QgdHdvIGF0dGVt
cHRzIEkgcGFzdGVkIGludG8gaXQgdGhlIGxvZyBmaWxlIGNyZWF0ZWQgYnkgcnVubmluZzoNCg0K
Ymx1ZXRvb3RoZCAtLWV4cGVyaW1lbnRhbCAtZGVidWcgLW4NCg0KVGhlIHZlcnNpb24gb2YgYmx1
ZXogaXMgNS41MC4gIEkgbG9va2VkIGF0IHRoZSBwYXRjaCB5b3Ugc3VnZ2VzdGVkIGFuZCBpdCdz
IGFscmVhZHkgaW5jbHVkZWQgaW4gdGhpcyB2ZXJzaW9uIG9mIHNyYy9kZXZpY2UuYw0KDQpBcmUg
dGhlcmUgYW55IGZ1cnRoZXIgcGF0Y2hlcyBJIHNob3VsZCBsb29rIGF0PyAgV291bGQgeW91IGxp
a2UgYSBjb3B5IG9mIG15IGxvZyBhZ2Fpbj8NCg0KVG9tDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNv
bT4gDQpTZW50OiBUdWVzZGF5LCBKdW5lIDIxLCAyMDIyIDI6NDAgUE0NClRvOiBUaG9tYXMgR3Jl
ZW4gPFRHcmVlbjJAU29yZW5zb24uY29tPg0KQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5l
bC5vcmcNClN1YmplY3Q6IFJlOiB0aGlyZCB0aW1lDQoNCltFWFRFUk5BTF0gDQoNCkhpIFRob21h
cywNCg0KT24gVHVlLCBKdW4gMjEsIDIwMjIgYXQgMToyOSBQTSBUaG9tYXMgR3JlZW4gPFRHcmVl
bjJAc29yZW5zb24uY29tPiB3cm90ZToNCj4NCj4gSSd2ZSB0d2ljZSBiZWZvcmUgd3JpdHRlbiBh
Ym91dCB0aGlzIGlzc3VlIEknbSBoYXZpbmcsIGJ1dCBuZXZlciBoZWFyZCBhbnl0aGluZyBiYWNr
LiAgSXQgcmVnYXJkcyBhIEdBVFQgZGV2aWNlIHRoYXQgY29ubmVjdHMgYW5kIG9wZXJhdGVzIGNv
cnJlY3RseS4gIFRoZSBpc3N1ZSBpcyB3aGVuIHdlIGNhbGwgdGhlIEFkYXB0ZXIxLlJlbW92ZURl
dmljZSBtZXRob2QgZm9yIHRoaXMgZGV2aWNlLiAgU29tZSB0aW1lcyB0aGUgZGV2aWNlIGlzIHJl
bW92ZWQgY29tcGxldGVseSwgYW5kIGV2ZXJ5dGhpbmcgd29ya3MgZmluZS4gIFNvbWUgdGltZXMg
aXQgZmFpbHMgYW5kIGJsdWV0b290aGQgYmVjb21lcyB1bnVzYWJsZS4gIEV2ZW4gd2hlbiBJIHNo
dXRkb3duIGFuZCByZXN0YXJ0IGJsdWV0b290aGQgaXQgZG9lc24ndCBvcGVyYXRlIGNvcnJlY3Rs
eSB3aGVuIHJlc3RhcnRpbmcuICBUaGUgZGlmZmVyZW5jZSBpcyB0aGF0IHdoZW4gaXQgd29ya3Ms
IGF0IHRoZSBlbmQgb2YgdGhlIHJlbW92YWwgcHJvY2VzcywgaXQgcmVjb25uZWN0cyB0aGUgZGV2
aWNlLCB0cmllcyB0byByZWNyZWF0ZSB0aGUgZGV2aWNlLCB0aGVuIHJlbW92ZXMgaXQuICBBbGwg
aW50ZXJuYWxseS4gIFdoZW4gdGhpbmdzIGZhaWwsIHRob3NlIHN0ZXBzIGRvbid0IGhhcHBlbi4g
IEkndmUgcG9zdGVkIGJlZm9yZSB0aGUgc2FsaWVudCBwYXJ0IG9mIHRoZSBCbHVldG9vdGggbG9n
LiAgVGhlIG9ubHkgdGhpbmcgdGhhdCB3aWxsIG1ha2UgYmx1ZXRvb3RoZCBmdW5jdGlvbiBjb3Jy
ZWN0bHkgaXMgdG8gc2h1dCBpdCBkb3duLCByZW1vdmUgYWxsIG9mIHRoZSBzaW1pbGFyIEdBVFQg
ZGV2aWNlcywgdGhlbiByZXN0YXJ0IGJsdWV0b290aGQuDQo+DQo+IEkgaGF2ZSB5ZXQgdG8gaGVh
ciBpZiBhbnlvbmUgaGFzIC1hbnktIGlkZWEgcmVnYXJkaW5nIHRoaXMsIG5vdCBldmVuIHRvIHRl
bGwgbWUgaXQncyBub3Qgc29tZXRoaW5nIHRoYXQgbmVlZHMgdG8gYmUgbG9va2VkIGF0LiAgSXQg
aXMgc29tZXRoaW5nIHRoYXQgcmVuZGVycyBibHVldG9vdGhkIHVudXNhYmxlLCBzbyBJIHdvdWxk
IHRoaW5rIHRoYXQgaXQgaXMgc29tZXRoaW5nIHRoYXQgbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8g
bG9vayBpbnRvLg0KPg0KPiBJZiBhbnlvbmUgaGFzIGFueSBpZGVhcyB3aGVyZSB0byBsb29rLCBv
ciB3aGF0IG1pZ2h0IGJlIGdvaW5nIG9uLCBJJ2QgDQo+IGxvdmUgdG8gaGVhciBmcm9tIHlvdQ0K
DQpEbyB5b3UgaGF2ZSBhbnkgbG9ncz8gQWxzbyB3aGF0IHZlcnNpb24gaXMgdGhpcyBoYXBwZW5p
bmcsIHBlcmhhcHMgeW91IGFyZSBtaXNzaW5nIHNvbWUgZml4ZXMgbGlrZToNCg0KaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2JsdWV0b290aC9ibHVlei5naXQvY29tbWl0Lz9pZD01ZWJj
MmI1YTNlNDhkYmU2N2EyZDMxNTk3OWIwOTZhMWI0ZDFlYjk5DQoNCj4NCj4gVG9tIEdyZWVuDQoN
Cg0KDQotLQ0KTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
