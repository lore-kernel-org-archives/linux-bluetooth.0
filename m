Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 20:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiFWUAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 16:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFWUAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 16:00:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E09337A87
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 13:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJXhMH6HGMEiNQkPwRTfxT1n7ONpA1l1OyPIvHDirhW7XWuurSC+K/faJBZC6cRYQe/HP62rdbRe/7pHvHCtGzeTPxyRBhPmrLohnBpTQ8+CImhjuZp6wEPRW2ydpMwWy73t9N4/JVbZR2xQTc1BEhPOeK4NTkVO+y4E1sZT4fKXqgTd3TMpDlNgeVBPJaeDHyrjEd5l8RHEKsQvcSusWP0YVoXZlTYQFBnIcDGlhsRTvUYItOS7hTsbqs6zI9aZYWzb4TjBL93ylEwTXdalx0saC+Sl1k8Iqu2DzmBthtl+REtNdpfX5r7haLALnJEYmH2vv6NmCUA/PUBHDJ3GYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TRhSBajByQdtu6V+/96E2PBIMN1ISnNokDEeDP0Mng=;
 b=DyeYWx8748Qi72ANtLO0Ftgr6sL4FVXn3RQuu0ng9v7Wbaw1l/eQxa/QcXqCFtF7F71Aw5xpDdAqEA2cE0TAVgyXay93yBSWSjASzjzvO7t5vqQQ1yHjeD722DfIUt34G/nu2FIJVkwQnut5h2VKQGstkpbLK5hQAkMtFpfxBls5BHT/M4PFN3HBI0O64e9+EUeOQrbS6I7I3Qh+bQmy+YsCKkLRGfb58SlEGvLtZOXJhf35q7kg1RMzdWWvc3MgCbYrtQlk45kYlzAbt2fDMo1G+LOMg1HxUo6exoWq9E+GlrHHUg/Q/HaFHyu3DJ+1CFG9MGCnnLKi0buzLY21RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sorenson.com; dmarc=pass action=none header.from=sorenson.com;
 dkim=pass header.d=sorenson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sorenson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TRhSBajByQdtu6V+/96E2PBIMN1ISnNokDEeDP0Mng=;
 b=A4gCd94dDtB+mbmy3Gwss0BM51Jq5tAe4s9NJ39e94Gs2FujSs3FyAkCKU7Xq7VQh7wSrPKWOspkixyxlUvAef3EULjICGn5EY5wIJ00/N5VRjtQ5MnTbEv81svvX4fUXx9BQNUJq/dXajFz5ezBy/7874ePG18rFWWypGBs5OqyYufFGt22fvwVeSEPSlVJdAYGDxHY4XnzXEmbNZGEGg9zOIS4xygiu1U/0DzEteXgdEsBCcU4P3objqFmxfjXXPJBSe5actP1hGS7xb2r8ApuVbfcmOXuInKEhIC6Nxfc5G4RgFb3cg6IyjQxy61ELFYxNI/aaZhx3xSrCvQyUA==
From:   Thomas Green <TGreen2@Sorenson.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: third time
Thread-Topic: third time
Thread-Index: AdiFqz19yiGChj+TQGudncH0+5ea3QAA9vwAADMZpzAAAQA7gAAAUn4gAC56URA=
Date:   Thu, 23 Jun 2022 20:00:17 +0000
Message-ID: <BN7PR04MB526754264668121B190EB50E9FB59@BN7PR04MB5267.namprd04.prod.outlook.com>
References: <BN7PR04MB52674E1CAADA5B0550C3F6959FB39@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CABBYNZLaPxBMvVXWx+yqQz-SyxptdMfEZ5TPQVP7q4otpcbErg@mail.gmail.com>
 <BN7PR04MB526737063784913B34568C009FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CABBYNZ+Ak=U1UUmYvWwfGOMMQNBAFKpbNm_ZoUTcGvCw7EYxpQ@mail.gmail.com>
 <BN7PR04MB5267899C0B47D40E28784BC09FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
In-Reply-To: <BN7PR04MB5267899C0B47D40E28784BC09FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=Sorenson.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1fe198aa-5ab0-4fb3-3f4f-08da5552fe94
x-ms-traffictypediagnostic: MWHPR04MB0961:EE_
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR04MB5267.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39850400004)(396003)(376002)(136003)(346002)(33656002)(38100700002)(41300700001)(83380400001)(316002)(19627235002)(186003)(966005)(42186006)(478600001)(52536014)(9686003)(71200400001)(2906002)(8936002)(6916009)(7116003)(66446008)(66556008)(66946007)(5660300002)(86362001)(122000001)(76116006)(3480700007)(64756008)(8676002)(53546011)(26005)(38070700005)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GbPDgOIdc/3Q12BHQmlROm2LPtmfNujjZGZQa2UUSFu1fBfAAAVedKqrpyawjH05QEJ1AbhVJr8ffGiLhxZ4bNYtsiXXMoqfPZF5MYedQrAaJuySYgYpc/Z09mVTYsrQRFwwC1Y8B/w1Q0oxs5cfqDB02dY/8Q4+ck8HanHw8JbQ0qZ3mTdBB2jKxngeCAx5eqWLDzABW4DY9W8uy8iwSuedj6TfS4QgwROq3Pi2mZTeFyXBFiUL9dQkO5HlPhknvLMN190wSJAaRMw8s1U1ZhXYnaBVb2ESd42Q8lDAwgahaAiqrCAt8i/OhWP268Iqpc5qis1Y7Nk6N0Qll4QzI53M/51hmu+GJ8a3wERnJaKZKkMc/LT9HNmoRGMXYvE7MuLjfFx6rR1qVCcpfZR6Wh+c+/rC9uMScPRvagIlM7KXPKTV5EjqsNEOKE8+S1sai4ogmy3m4bFrc7H2koWaHVNMX8hIZUTa5IlbcCIsBEIoHAaWPUTW88GKCP+JPEbaFSZSvFak3PIJlu4oHBUJhUJwJTY8KInfATZMJ8WzKdQOWrAG1Xk8t0gq1WtVSzOwv/rX+AkZNjF4loVXygen/+P9Nd3acTgCZcseKyHh9OG5LBbde8jcbzX3EQudVazPGEbM7lVc3dbZI6w5SVxWyLJbRjhO5T9v9dYxDaDQEhvumj7moxfTBv2Rt9h9lgzknTFTTZqEI42fSzEhjTE6TCnm+DjiHAS0PAR3u526ePzQCgs86nauflc/8M6iePb4UFx9ur0qglgd3vQqSRQEHqdDgtOBEgVW3Yny8SOLIiOVWjNLNFYcMOA8OdjrVUy+6QOPt0rw/gdI57uNsxegw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1NPVlMzM3NkSUppMTZnREJCZGtDcmFsRVJQdEZ2ZmNLMUovVUpnMTFiM1NZ?=
 =?utf-8?B?endzWlVpN3lnNEpUNFpMcWMxVmhLMXRLZVpCd0NsL2ZxUi81SktoT0Nrazg0?=
 =?utf-8?B?dTY1NWphRUhhK1FwZ20xbzlMaExyelhrUXIrRTRNYVVadklqOVJWN0N4UC9s?=
 =?utf-8?B?aksrMHM4cis3bnVFSUxoUW9Tb1JhUWFNS0Y2Y1Y5VHVIaEhkRU8zbjNKVGpW?=
 =?utf-8?B?YzVrWmd4UUh2aWJZZTdQUDM0L0gvNEdNMDhPeEkzdkF0UFRBRU54UjZSeXJP?=
 =?utf-8?B?S3FpZ0E2VWp1S0MwRUFZTjRIRi9nVkt2aDZzMFA2ZEFiM3ZsUUFMMW1NUDMy?=
 =?utf-8?B?bEJva3E1OFJXVnNacmlSZXhjeHB3QmdONWdEYmpPL25HK1d2L2pPUE81c2tJ?=
 =?utf-8?B?VlZBc25yVlI1ZHBBSXVpTG1PZ0xMdWJzcm90ZkZyZ2hxTmRRR2J5QzljUURI?=
 =?utf-8?B?NHhnbU9IejdqM0prT1kvUmVyN3RKamtqUUNvSnNtdy9QSHZiOXdwajNmYkh5?=
 =?utf-8?B?a1BGZjJRVmFpckV5MnpueHpCSVJiOVBxdTBVM2R1V3lsdEdqZThGN20ra3Vo?=
 =?utf-8?B?VzNJNktHT0pxOE5FU2o0VUg1cG82RFI4S3dNSHNUVDFoUnBWRWU1aS9YNmdZ?=
 =?utf-8?B?YkxLVWs3YTNlRUJoMzVpQlZ3d1krN1FzRmlMU293dHdtcGY0VDZRci9NdEJy?=
 =?utf-8?B?aW5jeUp2VWZuNGdnM0lHZkk0R2M3dkFESTErWVZ1d3hyWTlMR3paYjNOT2ZC?=
 =?utf-8?B?UkJQNDNqVTU4YkcvVzRBcERFZE1ySE5hRlpHTG1nZU94WmZielBLVkVQUkJ3?=
 =?utf-8?B?aThKRS80bE1lc1NiU29tdVVnbktad1BrNHVlTDFWNHRoUk1Uai9ZL0svbUg3?=
 =?utf-8?B?Q2Q3M3ZzMGMwZWRKYm9xdnoxSVhxdGtoQU51T2dtZmdDRzRvRUR0NTBvSGRU?=
 =?utf-8?B?WEhDakhaQ2FaaG5Ob0NwdmFCZWI2M1BCTHBSVUVYWjRyUFZVeDliUWpGZ2hG?=
 =?utf-8?B?a2ZlcnRzdVprU3l1anBpK1VURk0vNXEvc1k5T3BwZFZRZTVnK0JkSnk5eW1W?=
 =?utf-8?B?K1ErbTMxYm9BeFRHdyttYWZPYlVYWWxhWFhQZktWcFhyVDhmM1hQQWtLc1BB?=
 =?utf-8?B?QmczanIwazBzbTJOOUQ2Z01aSzNGTG15TC9kUVFCS1lFeUVFQzh1d0tjNW1t?=
 =?utf-8?B?UDREQ3dsYzJ0akJ3M2EvUTU0K2ZLcGlQVDZxZXRZbkkyZjA2dlEza3lNUkZq?=
 =?utf-8?B?eGJOaHBSb0UxM0pZbDZBT09KVkJZVVJ4UUptMjlVenQzS2Q0N096ODhLL05J?=
 =?utf-8?B?V0ZZWVRBOWdOZVBQYlJBT0hBOWRnQ2YyUSt2Y1BPR3RpWmswT2VlTmoxUklH?=
 =?utf-8?B?TkJ0VzJIRmZVRktVWkpldHZSbnBoQWt4RXZRWlJJRjNQWEF1TWl6dExTK042?=
 =?utf-8?B?MUU1SXY2VE55UXI2ZUVzVHB6S0M4bUhtSDVndmtqd1ZhNUlXNGM1bURiaCt3?=
 =?utf-8?B?bFcxL1NMM2g3cUc4U2dqRUFNZ3BXVmxDRTh2d0pjeldXS3ZNc25kdDdYSzAw?=
 =?utf-8?B?T1VEblVMU2YvZkd6MVNvRjl1YUgyOWU1KzhJelZ5TEJpWlpxdU9OdEV1SzNU?=
 =?utf-8?B?MEErcmowRjYyaWJqOWpocGZzUS9OckVMV2h1T240L0N4MWdRSk5LNThBNVR0?=
 =?utf-8?B?SnNINnNnYld5UG9wV2JmSHJnVmFGWlY1U1NoZFhIbWw2ZlY2U0VVZFVUeWhy?=
 =?utf-8?B?azJpdFhkdFlkVHNWN3ZFSDAzQSsrczg4bVpJc1JRU3FYQmNHYWpjK3FXQUda?=
 =?utf-8?B?cEIwakNUNXZ4WmxLdmptZTExTU1LbWtkQXlYVmJKTnduN3ltQUhGOHJjYklm?=
 =?utf-8?B?OGdxYnQxNDNKQVQ2ckMvejNjaHYrUnZUZzdvbnppa21nMnFRVWdKdm9Vckd3?=
 =?utf-8?B?MG5zMkhRQjF3NzFFdHdBZmtGYjRvTENHRE1wbktUWW10TzBpOTk2SnorbHpW?=
 =?utf-8?B?MDB4SFpOYWE3a2gxcm9MM3l6Ni8yVW94Q1JoeEc0Nkx0VDhvU2djY2MvWTUz?=
 =?utf-8?B?dTdFSERaTkhVYktMSE1RZFlsS2RoYmNIQVlURk9MSHB6djJRVWRvSXlXV1dq?=
 =?utf-8?Q?E1mHsoERmYmZILcnlnQZ9B0t+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sorenson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR04MB5267.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe198aa-5ab0-4fb3-3f4f-08da5552fe94
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 20:00:17.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d0f7f33f-8d1f-4ac0-bccd-2ecda8bf422b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZSFakwobGTa/f27+Q+thmMaCAH7zVLwDhugMOYPAwaCz1n8FSu4XZohwBz5hbW3ORInIrDSLI+KVPRL1No95A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0961
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

THVpeiwNCg0KSSd2ZSB1cGRhdGVkIChhdCBsZWFzdCBteSB0ZXN0aW5nIHN5c3RlbSkgdG8gdmVy
c2lvbiA1LjY0IGFuZCBhcmUgaGF2aW5nIG90aGVyIHByb2JsZW1zIG5vdyB0b28uICBGb3IgZXhh
bXBsZSB0aGUgZmlyc3QgdGltZSBJIGF0dGFjaCBvbmUgb2YgdGhlc2UgZGV2aWNlcyBpdCB3b3Jr
cyB3ZWxsLCBzdWJzZXF1ZW50IGF0dGVtcHRzIHRvIHBhaXIgb3RoZXIgb2YgdGhlIHNhbWUgdHlw
ZSBvZiBkZXZpY2UgZmFpbHMgd2l0aCBhbmQgQXV0aGVudGljYXRpb25GYWlsZWQgZXJyb3IuICBP
biA1LjUwLCBJIGNvdWxkIHBhaXIgYXMgbWFueSBvZiB0aGVzZSBkZXZpY2VzIGFzIEkgd2FudGVk
LiAgU2hvdWxkIHdlIHRha2UgdGhpcyBvZmZsaW5lIGFuZCBwZXJoYXBzIHdlIGNvdWxkIGRpc2N1
c3MgdGhpcyBtb3JlPw0KDQpUb20NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IFRob21hcyBHcmVlbiA8VEdyZWVuMkBTb3JlbnNvbi5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBK
dW5lIDIyLCAyMDIyIDM6NDMgUE0NClRvOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBSRTogdGhpcmQgdGltZQ0KDQpbRVhURVJOQUxdIA0KDQpJIHdpbGwgYXR0ZW1w
dCB0byB1cGRhdGUgb3VyIGJ1aWxkIHN5c3RlbSB0byB1c2UgYSBuZXdlciB2ZXJzaW9uDQoNClRv
bQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBE
ZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQpTZW50OiBXZWRuZXNkYXksIEp1bmUgMjIsIDIw
MjIgMzozMiBQTQ0KVG86IFRob21hcyBHcmVlbiA8VEdyZWVuMkBTb3JlbnNvbi5jb20+DQpDYzog
bGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IHRoaXJkIHRpbWUN
Cg0KW0VYVEVSTkFMXSANCg0KSGkgVGhvbWFzLA0KDQpPbiBXZWQsIEp1biAyMiwgMjAyMiBhdCAy
OjIyIFBNIFRob21hcyBHcmVlbiA8VEdyZWVuMkBzb3JlbnNvbi5jb20+IHdyb3RlOg0KPg0KPiBM
dWl6LA0KPg0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuICBJbiBteSBmaXJzdCB0d28gYXR0
ZW1wdHMgSSBwYXN0ZWQgaW50byBpdCB0aGUgbG9nIGZpbGUgY3JlYXRlZCBieSBydW5uaW5nOg0K
Pg0KPiBibHVldG9vdGhkIC0tZXhwZXJpbWVudGFsIC1kZWJ1ZyAtbg0KPg0KPiBUaGUgdmVyc2lv
biBvZiBibHVleiBpcyA1LjUwLiAgSSBsb29rZWQgYXQgdGhlIHBhdGNoIHlvdSBzdWdnZXN0ZWQg
YW5kIA0KPiBpdCdzIGFscmVhZHkgaW5jbHVkZWQgaW4gdGhpcyB2ZXJzaW9uIG9mIHNyYy9kZXZp
Y2UuYw0KPg0KPiBBcmUgdGhlcmUgYW55IGZ1cnRoZXIgcGF0Y2hlcyBJIHNob3VsZCBsb29rIGF0
PyAgV291bGQgeW91IGxpa2UgYSBjb3B5IG9mIG15IGxvZyBhZ2Fpbj8NCg0KT3VjaCwgdGhhdCBp
cyBxdWl0ZSBhbiBvbGQgdmVyc2lvbiwgaGF2ZSB5b3UgY29uc2lkZXJlZCB1c2luZyBzb21ldGhp
bmcgbmV3ZXI/DQoNCj4gVG9tDQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPg0KPiBTZW50
OiBUdWVzZGF5LCBKdW5lIDIxLCAyMDIyIDI6NDAgUE0NCj4gVG86IFRob21hcyBHcmVlbiA8VEdy
ZWVuMkBTb3JlbnNvbi5jb20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiB0aGlyZCB0aW1lDQo+DQo+IFtFWFRFUk5BTF0NCj4NCj4gSGkgVGhv
bWFzLA0KPg0KPiBPbiBUdWUsIEp1biAyMSwgMjAyMiBhdCAxOjI5IFBNIFRob21hcyBHcmVlbiA8
VEdyZWVuMkBzb3JlbnNvbi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSSd2ZSB0d2ljZSBiZWZvcmUg
d3JpdHRlbiBhYm91dCB0aGlzIGlzc3VlIEknbSBoYXZpbmcsIGJ1dCBuZXZlciBoZWFyZCBhbnl0
aGluZyBiYWNrLiAgSXQgcmVnYXJkcyBhIEdBVFQgZGV2aWNlIHRoYXQgY29ubmVjdHMgYW5kIG9w
ZXJhdGVzIGNvcnJlY3RseS4gIFRoZSBpc3N1ZSBpcyB3aGVuIHdlIGNhbGwgdGhlIEFkYXB0ZXIx
LlJlbW92ZURldmljZSBtZXRob2QgZm9yIHRoaXMgZGV2aWNlLiAgU29tZSB0aW1lcyB0aGUgZGV2
aWNlIGlzIHJlbW92ZWQgY29tcGxldGVseSwgYW5kIGV2ZXJ5dGhpbmcgd29ya3MgZmluZS4gIFNv
bWUgdGltZXMgaXQgZmFpbHMgYW5kIGJsdWV0b290aGQgYmVjb21lcyB1bnVzYWJsZS4gIEV2ZW4g
d2hlbiBJIHNodXRkb3duIGFuZCByZXN0YXJ0IGJsdWV0b290aGQgaXQgZG9lc24ndCBvcGVyYXRl
IGNvcnJlY3RseSB3aGVuIHJlc3RhcnRpbmcuICBUaGUgZGlmZmVyZW5jZSBpcyB0aGF0IHdoZW4g
aXQgd29ya3MsIGF0IHRoZSBlbmQgb2YgdGhlIHJlbW92YWwgcHJvY2VzcywgaXQgcmVjb25uZWN0
cyB0aGUgZGV2aWNlLCB0cmllcyB0byByZWNyZWF0ZSB0aGUgZGV2aWNlLCB0aGVuIHJlbW92ZXMg
aXQuICBBbGwgaW50ZXJuYWxseS4gIFdoZW4gdGhpbmdzIGZhaWwsIHRob3NlIHN0ZXBzIGRvbid0
IGhhcHBlbi4gIEkndmUgcG9zdGVkIGJlZm9yZSB0aGUgc2FsaWVudCBwYXJ0IG9mIHRoZSBCbHVl
dG9vdGggbG9nLiAgVGhlIG9ubHkgdGhpbmcgdGhhdCB3aWxsIG1ha2UgYmx1ZXRvb3RoZCBmdW5j
dGlvbiBjb3JyZWN0bHkgaXMgdG8gc2h1dCBpdCBkb3duLCByZW1vdmUgYWxsIG9mIHRoZSBzaW1p
bGFyIEdBVFQgZGV2aWNlcywgdGhlbiByZXN0YXJ0IGJsdWV0b290aGQuDQo+ID4NCj4gPiBJIGhh
dmUgeWV0IHRvIGhlYXIgaWYgYW55b25lIGhhcyAtYW55LSBpZGVhIHJlZ2FyZGluZyB0aGlzLCBu
b3QgZXZlbiB0byB0ZWxsIG1lIGl0J3Mgbm90IHNvbWV0aGluZyB0aGF0IG5lZWRzIHRvIGJlIGxv
b2tlZCBhdC4gIEl0IGlzIHNvbWV0aGluZyB0aGF0IHJlbmRlcnMgYmx1ZXRvb3RoZCB1bnVzYWJs
ZSwgc28gSSB3b3VsZCB0aGluayB0aGF0IGl0IGlzIHNvbWV0aGluZyB0aGF0IG1pZ2h0IGJlIGlu
dGVyZXN0aW5nIHRvIGxvb2sgaW50by4NCj4gPg0KPiA+IElmIGFueW9uZSBoYXMgYW55IGlkZWFz
IHdoZXJlIHRvIGxvb2ssIG9yIHdoYXQgbWlnaHQgYmUgZ29pbmcgb24sIA0KPiA+IEknZCBsb3Zl
IHRvIGhlYXIgZnJvbSB5b3UNCj4NCj4gRG8geW91IGhhdmUgYW55IGxvZ3M/IEFsc28gd2hhdCB2
ZXJzaW9uIGlzIHRoaXMgaGFwcGVuaW5nLCBwZXJoYXBzIHlvdSBhcmUgbWlzc2luZyBzb21lIGZp
eGVzIGxpa2U6DQo+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9ibHVldG9vdGgv
Ymx1ZXouZ2l0L2NvbW1pdC8/aWQ9NWViYzJiNWENCj4gM2U0OGRiZTY3YTJkMzE1OTc5YjA5NmEx
YjRkMWViOTkNCj4NCj4gPg0KPiA+IFRvbSBHcmVlbg0KPg0KPg0KPg0KPiAtLQ0KPiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6DQoNCg0KDQotLQ0KTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
