Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ECFC4361B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Dec 2020 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF81B2395C
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Dec 2020 17:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgLTRKC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Dec 2020 12:10:02 -0500
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:14850
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727674AbgLTRKB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Dec 2020 12:10:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY7Z1YqvIk0xi4n3KWvi695GwmUrZYs5jpXjiI/EvAZSUcIXx0ivuAsPV0oz1cWKw0+c9kXqp9v69pumMlowm1OeF9Fmfz4alxejHqaJgEIvDV2EJABBTlo0tFIIR0xzT7waGHWwf8SHCt7vX2RFgq/tcSINl+i5SEwmlDm8xuNk4t7qhaQUA0pTvJpR7eSzFXf3EBuh55h+iQiMp98ky6qz3HCsJHFFo3Vf6DCndvy0lUR8V95vhZZ+hbtbSQlbCwsy2lecveFlKL2iolqucKbRwd409EphDFPJ3zdPBv2RgwyVJehTM2drbrTWRlqv3UZf2ztJkhl4eSNtp4On8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mvaVi73pLBrvAebQQcpZM2WHe3Jyv9Bu7ekjjccgh4=;
 b=B8CTBapOgM56URvUP4yewHdKVaIKcXi3cafzNzk9hwOwy3f1PSqNQ+ObssNqkgmB1/sHkjenaGDi2LvL4dWEweAALtLdRbmw3f+cbYMZTsFOMJ/tWmnR4gND0yGc3QE+BjnnRv1nK3+v+CtA3z9/7yZ8kL3UKe4tz85rhYKP1PIIwdASsyDXq+y9HNJBv0n6YRFWpGuiq0OZ4eHJ+sQILVvvfx8lYtFEKUqlyI4i6fBXytQNl5api89WzbAaJIJsIIG4NKrEBkVkK6DVth2FW69lABTsHWDPnAgZMV+MBOVcL9vr+51X3di8CwR2UbOvcb8Hh85hj+BgU8JaeghHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mvaVi73pLBrvAebQQcpZM2WHe3Jyv9Bu7ekjjccgh4=;
 b=XUOTTsL/zjTk4VLymfi7//dy3XdTZ59/ZepfSZFxZtF+Jlhq1kXAFLkrTPiWl5pEW7gY+0PMW14ide+dZ4X/B8MmeQPclr4ShIV60gDWQYdeYyRzsPQGBjFomWNk8fdhgbUGulBhwWzfC02WcqzeFqerQ5R9RhINu7n0ZQJQo+o=
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) by CY4PR10MB1318.namprd10.prod.outlook.com
 (2603:10b6:903:29::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Sun, 20 Dec
 2020 17:09:08 +0000
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7]) by CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7%7]) with mapi id 15.20.3654.032; Sun, 20 Dec 2020
 17:09:07 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Thread-Topic: Default to HW mSBC on capable controllers ?
Thread-Index: AQHW1UH1ZbjENPecx0GN2Ly2GQ87Man9QZ0AgAL5hAA=
Date:   Sun, 20 Dec 2020 17:09:07 +0000
Message-ID: <f8fff0d253471107ef39806b15f32d5746538a90.camel@infinera.com>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
         <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
In-Reply-To: <CABBYNZKy4KXWqLdZu7C49jJ_nMbmBOdMjtM2_5OQg2ruUHUh_w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17585273-576b-44b2-a8b5-08d8a509f664
x-ms-traffictypediagnostic: CY4PR10MB1318:
x-microsoft-antispam-prvs: <CY4PR10MB131854440D18392E96F14F1CF4C10@CY4PR10MB1318.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kVLEtqGor3WkMKbXhtexJFU/bG/nQN56CBz/wW0n5bTU+8IF9mKMt8YKtLHr5BEgIwPvcNOWladtccfZz70h5XbAOAW2eRpvLV1zXNTgUO3kYlj8ChgGaEqBzzp+ctVUhis0RZErII167OZvYkU/mXlUeHf0d6Z722tYHKGZ4nLY0xyMXD5fdWCXp1OGDgQXZoMyOHZvBePrWYbrTE0dW8n9khE/lYsFb9Xzz39Nftt5XbLcuriA6l2/KcIusPJGL5M1fuEzQieJ+nfaMBV5BSba01rutLtdcAcjieDIA8vztKIot8nbfXa/BxGBNHVX8OQ8fPZchFz+7E4eSE+nk/aXpO2cIoQrdTOkdlcZW1Z8eqfTCKlhEcydehGaLaVW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(366004)(346002)(376002)(76116006)(66556008)(66446008)(2906002)(6486002)(64756008)(66476007)(66946007)(2616005)(91956017)(478600001)(4001150100001)(8936002)(36756003)(6512007)(6916009)(53546011)(6506007)(316002)(86362001)(26005)(186003)(8676002)(4744005)(71200400001)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?L1ovSjl3Sm9aWWU4QmwxcjB3MWp2ZmNvQmpYd1krd2ZVM0F2alpkTmpvajNu?=
 =?utf-8?B?cHdhTk9YaW1WeEh3SHJFYkRDc1FXNDZ0RFlQSUFpMnpxSG1YNU9KcWhmY29n?=
 =?utf-8?B?YmFCVXZDekd0SWNvWGtRMEVpSUJPMHJwRnQ5amxZS2pmMUVTWUQ5S29tTElo?=
 =?utf-8?B?S1ZRUTNWRVBSd2lhRU9QVkp6aEFiT0t2dFhFQWtwcUErSHc5WXcwbkx0Yjgz?=
 =?utf-8?B?QXZaeGNOVUZISnJ1TFIvWkNJSFlQSURCUWppdlZtUm1jM0dkcTdvV2tlMk5o?=
 =?utf-8?B?Uys2S0VOSDB6cGJhQzRONG01aGJoVVNScWhmdFBqbkVZVXpqcUN0dmVOMzJ3?=
 =?utf-8?B?TVM1WjU3Q2ZzMlMzTjE4ZFJXTmx0UUVzcGJnd0tJckZKQ01kZmo0NXBIYWZa?=
 =?utf-8?B?U2ZzVXhGeVBidHpEMklVb1dsS3U1WVZsblBORWVzUmFSbEpQWks4dUsxRjhM?=
 =?utf-8?B?TEtCOURrWDc0bzE3b0ZTMGdheS9WdDdoYkhjSzZSeW56OUdySWZsbGc1N3Bk?=
 =?utf-8?B?YjN6dzNtVHhQZmZGZG1CSWIvZ0F2YlM1ZjRNajNhWGdFRS9RbWtyTmNjb0t0?=
 =?utf-8?B?eE5VclI3a1dKYVRJSlEzMWVyUXhrVkthOVVJUEdxakROUVZQWXpzdE9CUVg1?=
 =?utf-8?B?eDZQVTZuRUl1TFpPa2R4RUVDVEh5MUhzWWNydnlFK01VTDh1bnN3WDZRdFZ0?=
 =?utf-8?B?ZHlzS1oxNlYzT3p5YldCUUhqdnFaOE1RTk94WnRybXJSR1lhSUVqeGE5MVcr?=
 =?utf-8?B?eWw3YWNudGlLamJpRFpKcVRuZUZ6MGxOaURmc3lQblljWEdCdXhESkJyMzRL?=
 =?utf-8?B?bjhSb05yR3U1S09TcldHbU5QNDk2MFlrTW1qNkQrWjNzbElPamxTRkVuSk9C?=
 =?utf-8?B?eno1dlRrdzJCTWl2ZS9FR25RaGx1ejBJRFBNY1RYaSsvdnBQQk9NbGdJamFP?=
 =?utf-8?B?T3JQc3RGRklYRDd3aTFpN3hZVU14L3JFdUNXV1QxdE95VFBvZE4wY2ROVGlr?=
 =?utf-8?B?TlNTN0NibzBrN0RZNVpyQ3NaQ055QXkybzRGTHlVWStFZU5va0xyWUtDZ1Y3?=
 =?utf-8?B?YkYyYnBzaGtMdlg5Z2FHMStObFFVZ1E3WVZpVlU1SktPWHg1WWRsUE1ORHV0?=
 =?utf-8?B?NUVJcXgvQmkwTWVUaXlaVElraHp6TWc3aVZLU0hJSlVhNktDWUJFMXQ0ZmpF?=
 =?utf-8?B?UkVuYXZMUzJ1LzBXZ2doS0QxQUNncEdicVpKeWZYejMxM2FLeHRIZWZjTnA2?=
 =?utf-8?B?bGt4QnlNQS9HVXNRVndxSCt1ZysyTXVsOUxUY2pyemlIbC8xM0xzdThVQkxv?=
 =?utf-8?Q?/jUeeKgLBGKC+vZOrhqQI6/ZS+KPpSKpPg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A6EA252E65E734ABE3D752D827FB9B9@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17585273-576b-44b2-a8b5-08d8a509f664
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2020 17:09:07.8766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9OZylTz+yo6OQ6Yp18QYnTKMdusuF6g5Iad/Eiy3QCv99tB6I+76lPY/ze/8w5KXFbkN//b7nWVNEJWJ7FDT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1318
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTE4IGF0IDExOjQzIC0wODAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOg0KPiBIaSBKb2FraW0sDQo+IA0KPiBPbiBGcmksIERlYyAxOCwgMjAyMCBhdCAxMDo0
OCBBTSBKb2FraW0gVGplcm5sdW5kDQo+IDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4g
d3JvdGU6DQo+ID4gDQo+ID4gVGhlcmUgc2VlbXMgdG8gYmUgcXVpdGUgYSBmZXcgVVNCIGNvbnRy
b2xsZXJzIGdhaW5pbmcgdGhlIEJUVVNCX1dJREVCQU5EX1NQRUVDSCB3aGljaCBJIGd1ZXNzIG1l
YW5zIEhXIG1TQkMgYnV0IGN1cnJlbnRseSB0aGVyZSBpcyBubyB3YXkgdG8gc2VsZWN0IHRoaXMg
bW9kZS4NCj4gPiBBbnkgaWRlYSBpZiBvbmUgY291bGQgcGF0Y2ggdGhlIGtlcm5lbCB0byBkZWZh
dWx0IHRvIEhXIG1TQkMgYW5kIHVzZXIgYXBwcyBsaWtlIGJsdWVhbHNhL3B1bHNlYXVkaW8gd291
bGQganVzdCB1c2UgaXQgYXV0b21hdGljYWxseT8NCj4gDQo+IEl0IGlzIGluIG91ciBwbGFuIHRv
IHN1cHBvcnQgSFcgb2ZmbG9hZGluZywgYnV0IHRoYXQgZG9lc24ndCBtZWFuIGFsbA0KPiBwbGF0
Zm9ybXMgd2lsbCBiZSBzdXBwb3J0ZWQgc2luY2UgdGhhdCBkZXBlbmRzIG9uIHRoZSBQQ00gbGlu
ZXMgYmVpbmcNCj4gY29ubmVjdGVkIHRvIEJUIGNvbnRyb2xsZXIgaW4gdGhlIGZpcnN0IHBsYWNl
Lg0KDQpZZXMsIGJ1dCBpdCB3b3VsZCBiZSBuaWNlIGlmIG9uZSBjb3VsZCB0ZXN0IHRoYXQgZWFz
aWx5IG5vdywgYSBwYXRjaCBmb3INCmVuYWJsaW5nIEhXIG1TQkMuIFlvdSBkb24ndCBuZWVkIHRv
IGFwcGx5IGl0IHVwc3RyZWFtIHlldCB0aG91Z2guDQoNCiBKb2NrZQ0KDQoNCg==
