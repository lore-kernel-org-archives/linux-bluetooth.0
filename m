Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A29C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 06:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73DE613A9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Apr 2021 06:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhDMGjl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Apr 2021 02:39:41 -0400
Received: from mail-dm6nam10on2070.outbound.protection.outlook.com ([40.107.93.70]:60993
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229534AbhDMGjk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Apr 2021 02:39:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dKyDWBquzWj3xNnUmgVwRq7sNCVhxkjzXDz+NINcvZpyaKmnPvZf8y1KNiyELzLfG0426yrWkJHubNOpXWv64LBURS9owW8oWBG58XN3q/P54BST7V8kqQ7wW8zK0TpumRt+36L8CnsQlONJzKzjZBIjwORU2XFyyVs5RrpE3aDtviHKugETHH4fvum2Pwml/2/bujaeSKJaEz9NKbQlSbtxN7+3Vi+6v6QrZSsjQgFoRqolQQcAK57UYqFMn6vkSdI9ypSV4gZNY/ygBnu987YNbk6717rSwBIahisdjgHFBmMZSfy0Be67rjlRdqxRGpd1CFzO4VQdKthp90Ox3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBfxlSe50oCTAXH0zVslMpxz94A6UorTLnH8cvlhHA4=;
 b=oWBw5Ut1LFVPKIptS4nfEQlL3HrPY8yIFowKOZtTn8edMD+19xApiVHhFxM/61Vj/VPCskphsW4fjg/aX87nMsOckFM7j01uBoiTsl93rT9tatvcBxASQqm2r0FUrtRy2IUjyLIqnm8EPFbic1gdJW+YF5gV4mGsUrxOBJIiHfpYzrUq236d21nqiPkaB7G97LTb2zWH/N+LpS0UAv7do0s2My3MNZFE0i1q9Fu1x8W3g7iKKL5sb02KUj7QoWyn5jnU2gsJKBlE9Q2T7cfclwRTD+daFvme0uNI1wde0iQSK8zhmoDZX/mbEeU31F+3L5Hz5bNObcvtJPbGHlQ5Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lairdconnect.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBfxlSe50oCTAXH0zVslMpxz94A6UorTLnH8cvlhHA4=;
 b=QfcM72uMJksXdL3Pq4OV3zcvdzm5ZgyxCPbWGe4pA7L6j+7e7x0wjlGG8Wsw+v48B3G7Z9O74XWRH3jUIObsWB45nscdzjwlOpB1xlki7IY6nfcCcnwWNrZ2SjKBz8x6Yr3YLwd66KY5WyMTniBWzJgkt5Wu1sJ8Jk8L8qa7utts7mA+jojAGYWOlNb3K0dWgilssQJKVX4fjRXsUQiItwHWBx6Ha7uXYt1FmmmSSSU57k2c9Y8UgE6Ow/vZOCjB+l3/XXMALjR8pntz3AkAA973/95Rts04ddFBJ9sMS0w2S1ycpRh3NgOnlAR2AzKEF79BcNTzt+nS4nWkWcb1Mg==
Received: from BYAPR14MB2887.namprd14.prod.outlook.com (2603:10b6:a03:15c::18)
 by BY5PR14MB3560.namprd14.prod.outlook.com (2603:10b6:a03:1d4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 06:39:19 +0000
Received: from BYAPR14MB2887.namprd14.prod.outlook.com
 ([fe80::441e:f968:4789:7ce8]) by BYAPR14MB2887.namprd14.prod.outlook.com
 ([fe80::441e:f968:4789:7ce8%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 06:39:19 +0000
From:   Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
To:     Kenny Bian <kennybian@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Disabled bluetooth cache. But the app still getting wrong data?
Thread-Topic: Disabled bluetooth cache. But the app still getting wrong data?
Thread-Index: AQHXMCoqrlXsnVDz1EeWMOm4Dtkdf6qx/rqA
Date:   Tue, 13 Apr 2021 06:39:19 +0000
Message-ID: <BYAPR14MB2887AB8A9D781267F8F4B2EEE64F9@BYAPR14MB2887.namprd14.prod.outlook.com>
References: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
In-Reply-To: <CAC9s0NYWacb=SH8P9zr_66CZnD6HC4yHkY_o2wk08oeSwn+Syw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=lairdconnect.com;
x-originating-ip: [109.158.132.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6413999-dc15-462e-8f5c-08d8fe46dde5
x-ms-traffictypediagnostic: BY5PR14MB3560:
x-microsoft-antispam-prvs: <BY5PR14MB3560518111DC20A479B787DEE64F9@BY5PR14MB3560.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhU2zfqY79bdG1VmVEnoIn062NQ89hm16PbAXw+JKQCeWeeN+l1byqtz6PMrm9t9m840aBKn2ZKqYcU5OcQ1ag78su0iiZUahYYMRSJEalIPp3QXDIc120bKHI7ZDjyZ8AB2isV3xXZDUuFIQlRol57DKIYmDfsGetHJi4jAnhSNNFEZziOdy9pqk2Inehv4jS3tGGwQBg8Cqr+1AwrYI1aFOjw/++0/ifI/WBVwHYQxF+j+3AYQfRf3NyqZXo8M6U7ZMBpv5LsIO8qvfYgB25e3La5n1T0BFRwPTMkESBAKiptHmROUwMz0iHvTcKOiKwVjqVd5p8ZDQyLdiG3/e1F5taRKKp/+Pxwp5mC83x6/bVtseSOIl33/hD255EYNT8MaY6xcVR4A+HKFN4SlTE2TTX60kageLEhM9qth//Hcvz17CcRB0whTvAxRRg5Es5A1ug99vpeVs7lJZ2TiwrGLAx31FsLOxVZVHPNCKjbSply5kNIWkq6uQPWWuQpec0sEMZmEiJ3L7RzHKP9Ro0tusL+6eRMYuaH+Cu5lQ8pWWQo8YPbFTScLeI0QAxt/wdGaAhTJXhqlbc+bj6l8ddAHvIIQjqt8sXb5SGSgWME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR14MB2887.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39850400004)(136003)(83380400001)(55016002)(66556008)(86362001)(7696005)(6506007)(66476007)(71200400001)(2906002)(8936002)(110136005)(66446008)(5660300002)(26005)(66946007)(52536014)(64756008)(186003)(76116006)(38100700002)(33656002)(478600001)(53546011)(9686003)(8676002)(316002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c0FrSzNOaEgyd2pvYkprMVVVVXl6b1pLbUJaZzNYTW03OFNtYXVSVXY3OWhw?=
 =?utf-8?B?NnFCSVlNa0E0OWp1ZVd3QXRtMnBqdnBHYkhsR0xhZUtJb2p3dUdyQ0pYQWVz?=
 =?utf-8?B?M3M3d3FGd0pVczhOaHB0N0hiUjNLQWZaRWF0djdWZjM2bEtZZ2tZeUJlNkF1?=
 =?utf-8?B?Uy85UjBQdUpBc1hhSXV5eC9xSjRsRlVuZ0hrT2tNV25ZSjUxVy8zME10THRU?=
 =?utf-8?B?ZTNmUmNIVCtMUEdsL2VieFRIdkhkbjEvSE13TVp3bUFodVZnZnU3WWpwYzJt?=
 =?utf-8?B?c3FhTmxiMWoxNDVnc0R1Wng2QVBQWmZkbkdTTm1Zcjk4bVA0OHIzajduR2pz?=
 =?utf-8?B?V1pXLzBpN3l1enJqSGprNTFTVUloMVAzM2hNU2d3MjdSV0VBdldJVG91d2dj?=
 =?utf-8?B?Z1lyVDB3K2VEcUpORlVhVERsRDMxM01CQWNXd1k5YU12K2RuWmdDbDFtVXdU?=
 =?utf-8?B?Ym1sRWNOTjBPV0tHcWpIRXEraUFPSEpYS3lEY2ZCSHdYQ1BWQUxvdFBUKzlQ?=
 =?utf-8?B?MDliOStOY0I2Tk52cDM1YXJaNlE1YnRZVFAxRzZqdUpYU3VOWnZUQStmTE5K?=
 =?utf-8?B?cThFNXZnakFSUExQZjdERlNYNWI0K1dXK0lNa3JKdFJuYlk2emJDSGtqNWsx?=
 =?utf-8?B?UmFiZWRybjhVNlRzTnIxbld0Q0VUWVdQM3QyTURuRzhONWxzOGI1bjZwc1lx?=
 =?utf-8?B?VllWY2IvNE1Ea1BEaFRlMGVPcWRrd1lVWVdTWGVWRSt3ZTl2d0RiL1cvRzJu?=
 =?utf-8?B?M0dMM25mTVpsVTNZWDNPYktMSU1wcERTRWpoWjVIQUloaW5pcDV5eGVXT2cr?=
 =?utf-8?B?Znk5eERGREpGYXZzL0RMRlhWVU0zZThXWVFXRFN0TzN0QmNaRHNac2hzekx6?=
 =?utf-8?B?d0dNZjBYZXdDNE5oUGhXRlV6TWNmQUJkTE4zaVJ2Q3BvT1FMLzRheVIvVHhw?=
 =?utf-8?B?NExicnNaMXhJMzNycXdReWpuV05jY3JoRFpwM29CazZQa3pLSnRCZEZJbXo3?=
 =?utf-8?B?QW04TVY1cXJwNnVCUXQ3SnZ0cmpxOXJ2ZWtTT2RFc09TeFkxSHp6aTRndkR2?=
 =?utf-8?B?SzFNR1VKUEMzUkFoWC9tK0YzVkVJUldraDVQZXVvNkVlbDl6WW9qTXVEZmVB?=
 =?utf-8?B?aVMyajBSc3RVdGJiQ1VsdDhHaGtZM29sWlpUVHlWQmNwaGp5MmhZL2FRS21u?=
 =?utf-8?B?NG5aSFk2UzdoNnN2Q0l5VlN3dVdMTWNkb3hJVkZ0ckZBamRyRUFBQ09EZW5Z?=
 =?utf-8?B?cEJwMC9COVdLOGhsSDZteVR3LzdJRXNQaFNhZ3lmeHZaMldGNGhFZlA4Y09E?=
 =?utf-8?B?bmxYTFgrVHowL3Ixd2FHZEl1b3hsejRTK2Uzc2hodFJVdFU0UXU2UGgrWEI0?=
 =?utf-8?B?TWFuN1VCSnowaFRTdUEvRFFDNjJnT0t6aTRKZW9RUVBKaDhEQ0lHUm9GVFM5?=
 =?utf-8?B?UnNpOGswSThRS3JvY1pwNEg0RTVSWUJQR2VYWVd6ZjNCNG4rNlMwZFh3NWFE?=
 =?utf-8?B?RGlVY3VWVXJYR0pFN2RkU1NQTU13Q1dqcmRTU2t2U2dVaHhBTzViZ0VUbHdv?=
 =?utf-8?B?SEtLNjV3MWxuNFlDVm5VYnNCOFNYWXpHVnR4OFJmdWlUVTNqaFRBOTJETkww?=
 =?utf-8?B?SHVvSWxoa1UvWm9iOHNmbG9keDU0UGoxaDFESXdCZU0yN0k3aDN0MkJsbkpn?=
 =?utf-8?B?ZllOSDdEQ1VIS0pXY3VLSTJhSENpRTdJR0VIS241MnRra3Zja0doaXREdUJM?=
 =?utf-8?Q?gTbV50uxJMnCtafqj34s3TYmIcCGKUH1s3fqQBS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR14MB2887.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6413999-dc15-462e-8f5c-08d8fe46dde5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 06:39:19.5081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: puG70aK/zxsJZt2M+pvZjYsKobYiAeZkvYhDfsq9Rv+D0277lZ4GvOSkDZeOHi/ho5HeCij68ONz1WK577btkigOVLMNNfGU9gQUUPBouu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB3560
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgS2VubnksDQpXaHkgbm90IGp1c3QgYWRkIHRoZSBzZXJ2aWNlIGNoYW5nZWQgaW5kaWNhdGlv
biBhcyB5b3UgcmVmZXIgdG8gYmVsb3c/IEl0IHdhcyBwdXJwb3NlbHkgZGVzaWduZWQgZm9yIHRo
aXMgc3BlY2lmaWMgcHVycG9zZSwgeW91J3JlIHRyeWluZyB0byB3b3JrIGFyb3VuZCBhbiBpc3N1
ZSBjcmVhdGVkIGJlY2F1c2UgeW91IGRvbid0IHdhbnQgdG8gdXNlIHRoZSBmZWF0dXJlIHRoYXQg
cHJldmVudHMgdGhpcyBpc3N1ZS4gQW55IHdvcmthcm91bmQgaXMganVzdCB0aGF0LCBhIHdvcmth
cm91bmQsIGFuZCBtaWdodCBub3Qgd29yayBhcyBpbnRlbmRlZC4NClRoYW5rcywNCkphbWllDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLZW5ueSBCaWFuIDxrZW5ueWJpYW5A
Z21haWwuY29tPg0KU2VudDogMTMgQXByaWwgMjAyMSAwNjo1OQ0KVG86IGxpbnV4LWJsdWV0b290
aEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IERpc2FibGVkIGJsdWV0b290aCBjYWNoZS4gQnV0
IHRoZSBhcHAgc3RpbGwgZ2V0dGluZyB3cm9uZyBkYXRhPw0KDQpFWFRFUk5BTCBFTUFJTDogQmUg
Y2FyZWZ1bCB3aXRoIGF0dGFjaG1lbnRzIGFuZCBsaW5rcy4NCg0KUHJldmlvdXNseSB3ZSBoYWQg
YW4gaXNzdWU6IGlmIHRoZXJlIGlzIGEgY2hhbmdlIG9mIGNoYXJhY3RlcmlzdGljcyBpbiB0aGUg
bmV3IGJ1aWxkIG9mIG91ciBmaXJtd2FyZSwgdGhlbiB0aGUgYXBwIHdpbGwgZ2V0IHRoZSB3cm9u
ZyBkYXRhLg0KQnkgc2F5aW5nIGNoYW5nZWQgY2hhcmFjdGVyaXN0aWNzLCBpdCBjYW4gYmUgYW4g
YWRkZWQgb3IgcmVtb3ZlZCBjaGFyYWN0ZXJpc3RpYywgb3IgYWRkaW5nIG5vdGlmaWNhdGlvbiB0
byBhbiBleGlzdGluZyBjaGFyYWN0ZXJpc3RpYy4NCkluIG9yZGVyIHRvIGtlZXAgdGhlIHBhaXJp
bmcgaW5mb3JtYXRpb24sIHRoZSAiL3Zhci9saWIvYmx1ZXRvb3RoIg0KZm9sZGVyIGlzIGNvcGll
ZCBvdmVyIHRvIHRoZSBuZXcgYnVpbGQncyBwYXJ0aXRpb24uIFdlIHJlYWxpemVkIHRoYXQgdGhl
cmUgaXMgbm8gInNlcnZpY2UgY2hhbmdlZCBpbmRpY2F0aW9uIi4gVGhlIGFwcCBjYW4ndCBoYW5k
bGUgdGhlIGNoYW5nZWQgc2VydmljZXMuIFNvIHdlIGRpc2FibGVkIHRoZSBibHVldG9vdGggY2Fj
aGUgYnkgc2V0IHRoaXMgaW4NCiIvZXRjL2JsdWV0b290aC9tYWluLmNvbmYiOg0KW0dBVFRdDQpD
YWNoZSA9IG5vDQoNCkJ1dCByZWNlbnRseSwgd2Ugc2F3IHRoZSBwcm9ibGVtIGFnYWluIGV2ZW4g
aWYgdGhlIGJsdWV0b290aCBjYWNoZSBpcw0KZGlzYWJsZWQ6IGluIHRoZSBidWlsZCBudW1iZXIg
MTAxLCBhIGNoYXJhY3RlcmlzdGljIGlzIHJlbW92ZWQuIEJ1dCB3aGVuIHdlIHVwZ3JhZGUgdGhl
IGJ1aWxkIGZyb20gMTAwIHRvIDEwMSwgdGhlIGFwcCBnZXRzIHRoZSB3cm9uZyBkYXRhLiBXZSBs
b29rZWQgYXQgdGhlIGxvZy4gV2hlbiB0aGUgYXBwIHRyaWVzIHRvIHJlYWQgdGVtcGVyYXR1cmUg
YnkgdXNpbmcgdGhlIHRlbXBlcmF0dXJlIFVVSUQsIHNvbWVob3cgdGhlIGJsdWV0b290aCBzZXJ2
aWNlIHdlIGNyZWF0ZWQgcmVjZWl2ZWQgdGhlIHJlcXVlc3QgdG8gcmVhZCB0aGUgImRldmljZSBu
YW1lIihkZXZpY2UgbmFtZSBVVUlEKS4gU28gdGhlICJkZXZpY2UgbmFtZSIgaXMgcmV0dXJuZWQg
dG8gdGhlIGFwcCBhcyB0aGUgdGVtcGVyYXR1cmUuIFRoaXMgbG9va3MgbGlrZSB0aGUgc2FtZSBi
ZWhhdmlvciBhcyB0aGUgYmx1ZXRvb3RoIGNhY2hlIGlzIG5vdCBkaXNhYmxlZC4gSSBsb29rZWQg
YXQgdGhlICIvdmFyL2xpYi9ibHVldG9vdGgvW0JUX01BQ10vY2FjaGUiIGZvbGRlci4gVGhlcmUg
aXMgbm8gIltBdHRyaWJ1dGVzXSIgc2VjdGlvbiBpbiB0aGUgZmlsZXMgaW4gdGhlIGZvbGRlci4g
VGhhdCBtZWFucyB0aGUgZGlzYWJsZWQgY2FjaGUgc2VlbXMgd29ya2luZy4NCg0KVGhlIG9ubHkg
d2F5IHRvIGZpeCB0aGlzIGlzc3VlIGlzIHRvIGZvcmNlIGV4aXQgdGhlIG1vYmlsZSBhcHAgb24g
dGhlIHBob25lIGFuZCAiRm9yZ2V0IFRoaXMgRGV2aWNlIiBpbiBpT1Mgb3IgIlVucGFpciIgaW4g
QW5kcm9pZC4NCg0KSSBsb29rZWQgYXQgdGhlIGJ0bW9uKHNlZSBhdHRhY2hlZCkuIEZvciB0aGUg
d29ya2luZyBidG1vbiBsb2csIHRoZXJlIGlzICJBdHRyaWJ1dGUgZ3JvdXAgbGlzdDogWFggZW50
cmllcyIgdW5kZXIgIkFDTCBEYXRhIFRYIi4gQnV0IHRoZXJlIGlzIG5vICJBdHRyaWJ1dGUgZ3Jv
dXAgbGlzdDogWFggZW50cmllcyIgdW5kZXIgIkFDTCBEYXRhIFRYIiBpbiB0aGUgYXR0YWNoZWQg
cHJvYmxlbWF0aWMgYnRtb24gbG9nLg0KDQpRdWVzdGlvbnM6DQoxLiBIb3cgaXMgaXQgcG9zc2li
bGUgdGhhdCB0aGlzIHN0aWxsIGhhcHBlbnMgZXZlbiBpZiB0aGUgYmx1ZXRvb3RoIGNhY2hlIGlz
IGRpc2FibGVkPw0KMi4gSXMgdGhpcyB0aGUgcHJvYmxlbSBvbiB0aGUgTGludXggc2lkZSB3aGlj
aCBydW5zIHRoZSBHQVRUIHNlcnZlciBvciBvbiB0aGUgbW9iaWxlIHNpZGU/DQozLiBJcyB0aGVy
ZSBhbnl0aGluZyBlbHNlIHdlIHNob3VsZCBsb29rIGludG8/DQoNCldlJ3JlIGdvaW5nIHRvIHJl
bGVhc2Ugb3VyIHByb2R1Y3Qgc29vbi4gVGhpcyBpcyBhIGNyaXRpY2FsIGlzc3VlIGZvciB1cy4g
UGxlYXNlIGhlbHAgaWYgeW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zLg0KDQpUaGFua3MhDQpUSElT
IE1FU1NBR0UsIEFOWSBBVFRBQ0hNRU5UKFMpLCBBTkQgVEhFIElORk9STUFUSU9OIENPTlRBSU5F
RCBIRVJFSU4gTUFZIEJFIFBST1BSSUVUQVJZIFRPIExBSVJEIENPTk5FQ1RJVklUWSwgSU5DLiBB
TkQvT1IgQU5PVEhFUiBQQVJUWSwgQU5EIE1BWSBGVVJUSEVSIEJFIElOVEVOREVEIFRPIEJFIEtF
UFQgQ09ORklERU5USUFMLiBJRiBZT1UgQVJFIE5PVCBUSEUgSU5URU5ERUQgUkVDSVBJRU5ULCBQ
TEVBU0UgREVMRVRFIFRIRSBFTUFJTCBBTkQgQU5ZIEFUVEFDSE1FTlRTLCBBTkQgSU1NRURJQVRF
TFkgTk9USUZZIFRIRSBTRU5ERVIgQlkgUkVUVVJOIEVNQUlMLiBUSElTIE1FU1NBR0UgQU5EIElU
UyBDT05URU5UUyBBUkUgVEhFIFBST1BFUlRZIE9GIExBSVJEIENPTk5FQ1RJVklUWSwgSU5DLiBB
TkQgTUFZIE5PVCBCRSBSRVBST0RVQ0VEIE9SIFVTRUQgV0lUSE9VVCBUSEUgRVhQUkVTUyBXUklU
VEVOIENPTlNFTlQgT0YgTEFJUkQgQ09OTkVDVElWSVRZLCBJTkMuDQo=
