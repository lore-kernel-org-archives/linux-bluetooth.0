Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11080C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD77961992
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Mar 2021 12:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhCZMj2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Mar 2021 08:39:28 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:14595
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230141AbhCZMjW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Mar 2021 08:39:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFUV3bXR71oDvkORbcoKxR87wY2LGZoUBB9+pldKvEdp1jytEdIJ5rRic8p7g1d3B4EABiiLr7rAjCdp96rH1JEW73DIvnUoIm0JpYtpdGPueroQGWm9l5zajjYmnHVwos36fgIHd0fNH7+5BRSc8nZ2kXCkN2d437tb565pelQIgTb3clHvCcjI9g8DN72C3jyyB1//XmAqAZUA0NudGZnybgaHUkPkpRqK2ePlF8ZC5vBgkc2D2JUd7B5v+Z4FMwakG2CCJMUvlUOnVGiXebUmGpLLRnYCMHpHdDQ+xLhM60UcGWuNp93NzO9OHU6tW+iNUQoYIg3HpNwfT1xO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt/qfW3p17xhOhtBULtzXuCujSN3XmuHrt4qNjRQ9DM=;
 b=Iob+Q+ffvkFeRn12iPef6xJk44NlV1B5OeRFIZmwPMhfdS1Lfpen21+HT75em5wpV1nEN0MDcX5xiyqDMftDL21M1fO3EM0o0C62bvRFxot6rnRboqAWumuj/Wm0+wMh8gyg+qHVJKWncI6T5SWZCu4YGHkhBmFX2ImLhgye3nBXGPuqduioklWJXoDdkBiAvwXtQ0KO/H/H9rIS/4FQLIJIWx5Co+S5Cw5VFW5d+eiZRjwBr9u52fFm0tV9D3DA903QbsTZfoxV282HdiqD+KDCJo/sfkxG1i4YLmTglcYUOYEb6Q+Aw2fWAG5O0Q3dwSCggKSIiWIRdpl7EQfUCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=expleogroup.com; dmarc=pass action=none
 header.from=expleogroup.com; dkim=pass header.d=expleogroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=expleogroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt/qfW3p17xhOhtBULtzXuCujSN3XmuHrt4qNjRQ9DM=;
 b=lV32Ejsc+8osYuFg3E5bmQRr6BgMlWHv7GSK4VjdMAyy+nIP5M5vJ0lWIXAJfgSvosqP6QbZCWxbvdft6hl8qQwEfmzRCT8KKzZbeX58BqKARe1Vwa23LQMGVK4+pz6yA4fgJS1xvNEMUcNCf614Y931uZ2njEDHxVNtG7p4++yGR+gJaz2L1U3Zg+mIahTrYZIy9K28ReUjrizLcZkW+DogQCNDgGMHC1YaQtBrIdqaxaXfP5JItzbuznC7kx6l28XXtm26E0WejFe9PJa3x2vIo/EALbqQjUGkt6WjJyeMr6lRFXcDqJ2tfSyohml2ZU9y34ekMJ+WPDW1FqIybQ==
Received: from AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::20)
 by AM9PR10MB4104.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 12:39:18 +0000
Received: from AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ccd0:37d7:6174:642e]) by AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ccd0:37d7:6174:642e%9]) with mapi id 15.20.3977.025; Fri, 26 Mar 2021
 12:39:18 +0000
From:   Alexander Haas <alexander.haas@expleogroup.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ] gatt: allow 'notify' and 'indicate' flags
Thread-Topic: [PATCH BlueZ] gatt: allow 'notify' and 'indicate' flags
Thread-Index: AdciNuAAb0iKY3IsSDGgpvHlk9uNHA==
Date:   Fri, 26 Mar 2021 12:39:18 +0000
Message-ID: <AM0PR10MB3265CE91F2AB6FF1F8C8013298619@AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=expleogroup.com;
x-originating-ip: [92.218.234.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15475506-71a1-4de3-7716-08d8f0542c36
x-ms-traffictypediagnostic: AM9PR10MB4104:
x-microsoft-antispam-prvs: <AM9PR10MB410455187DCD682FCB6F504E98619@AM9PR10MB4104.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pj4Fl6mHh4lD8M2gAfAcKFVeFSQBftRU1OBo5mgeFnwwmGWVyNTmtJh8p1mryBqJbLx6Hgqs8aELgGF+PAgD5PcGWREFkcX1t41JR+h4+gq+HcG3QU8LGc1bhqVQZMIdw1pQuSDfn6rDP4FI5RNuIk7K8ky5zIMYbkRDp9Bh3+hgSGzlMlRXpql/+Fd+4qVKZKh2oaj4NPg2gWsWXcDIq/AZSuxlYymZnoxX8COHBO63PEt9bm1sE2EPrPSV/Hw49o7Gxiv+WTi5ddo5NvxZomfRRy2VFCJ6mQ4WSamq3IZEXh+7oP5E13N9z9PS5oHIR8MSpPLcVIl8bxrsASkmTLqYKrOz6V4d6lNWXm4uGBxPNg+70/8+NR/VvvYXh03+kzxUzxanLOyQaW8IC6lm7Nm+sMiexbhV5zyKIqXNDb0OPfrFQUzErqBPruxSOY5B8zal3mtQhIl90U/W6/t01WZ8o2c6ipdo8DiJqXKbkkOUHohgTpWyzuly9E2GxCXmdGXFYvFZIoeztCV+elUYNPCnK35nEvsC07BWqsi4vdvi6qtvin9IMQCpOj944m4ZY/9n509N22WBB0qXUJp4cPD1tPj0IZwDbFFFvrxapNUAz6z2PwliyKIrdSMlU2VsZ/DEESnDDBLnv+i93EZsTTX8Rsr0Q+SGVtRnhyTqNg8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(33656002)(76116006)(64756008)(6916009)(86362001)(66476007)(66556008)(66446008)(5660300002)(52536014)(71200400001)(8676002)(316002)(7696005)(44832011)(66574015)(478600001)(8936002)(6506007)(9686003)(83380400001)(38100700001)(66946007)(26005)(186003)(55016002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z0VXZkh1YUZ0c0VOOStPL2RYNnJ3enBRbXhvMXdSRXRwNTMxaTQwajBhQ1VV?=
 =?utf-8?B?ZDdtc0l5TnVUMlRmZXJYbEhFVkRSbS9BVDhNaTh0UUV1Yk5ZS0dWYWphOXdL?=
 =?utf-8?B?K0dFNlRoc2taTERhNmxyWWlKZkhmdDhmVVFaQytNQkZoUGRlck1oZEFmSnND?=
 =?utf-8?B?V2psYXFsa3NYZ294b29wcVh5RmdtNXgvRFhyb3Q5MWlUMkZqZTAvZ2l3UTdN?=
 =?utf-8?B?WXUwSVBKaXVHUEYyN25CRkNMb1I1M1BCdVhNTWZMM09YSFMyL21NaWo2d3Nv?=
 =?utf-8?B?ckk0TWxQQmk0REZiejhSTk44bkJVYXEwYlBaTVJyejZjZW9Ha0F4dEpibElu?=
 =?utf-8?B?L3ZVN2RMR3BPWE15U0IxbmVYZkhBSWdLVHk3eEw3VW43b2ZSOHJlSGNIWWN2?=
 =?utf-8?B?K05PNnNmSjZqa2d3cmJoZWJkcXNRQnVQNG9ONU1mUFJOYlFWS1g2SU5QMDBp?=
 =?utf-8?B?MmxuSFV3UWxIdmhLMGpqOGMyRFJJS25ldWRFVVF0R2c0SHBJbDdIb21zWWFD?=
 =?utf-8?B?elZZRXg0WEUvV0dJelFIaCs0SVZTL2tpYS95MVhaMGhKSm5kNTYvYS9iVHFR?=
 =?utf-8?B?YllUREpuaXA5TXRYb0p6VzRnT05ZWkl2akRGYXY5T3pNcUg1ZmNBY0Qza2k1?=
 =?utf-8?B?QjM2LzVOTXVBdWxZUktDckZwc3NMSzAwK1RrbzBUUmVFaVgzb3FTSlZNcGRj?=
 =?utf-8?B?Y1FOaTkrUE5KaVVRZGhpbW1NeStWUlU3U1BvM3ZrNlUwZ1RhTWEwU3I5MHY2?=
 =?utf-8?B?enpsaUJRSGZEcTR1STR5T3VSY0M2S0lRY0tzWS9IdlRFSE95U2ozTGp1REkw?=
 =?utf-8?B?ZVd0RTJ2NGdOaVRRODBQZ3NsV09LTXE1cDdXb25FS1VUOXpGTWszK2J5R0Rr?=
 =?utf-8?B?OGlkdnpnRncvL2I4S0NocWwxRVJRdXZ1QjkzUWlMWXNsODJ4SXNEVlRlc21S?=
 =?utf-8?B?MDYrZ09ISjh5SjdqVWNDVy8xRFhlU3dqc0cwZmxQN2MvcUsrL0htcC92d1dZ?=
 =?utf-8?B?R2diNGxNS1hWSFlLUWc5Ulp0WDZDMHF2RWNTR1g2NHlFcTA0cXV4VFhTak1Q?=
 =?utf-8?B?aEg2VTBtUU11ZWp6L211aFdvczc4cXExZUVqUTVnak5rOFJ2b3ZaVkxJV3Bm?=
 =?utf-8?B?MWoxVUk5Wm1teDJjZUc0VXVrOElXR3NCOVNSVEczRFoyMWMrME5EcDBwZW9K?=
 =?utf-8?B?UjZsMDZRQTNuT3BGSGxJNDVSbFJwRmMzSXBOVGxLODRLOExwYU1BUzlmdEp2?=
 =?utf-8?B?UmFIRk5XcWV0Y28rbG0yZjNBWlovM1EwRmdRL3AzQTRUdUc1N3dYU1ZvZGdz?=
 =?utf-8?B?RnZZZGcwSTFObUtMZEVjeTFVWXpKS1VrQ1JTcWIvVTh5bnZzQzdoMFNwcXFS?=
 =?utf-8?B?YnJVUC85eU5YTm00bjRrTmJSYjdCQ0lkUmNKVVlhV0FJN3V6d3pFdWVOdllM?=
 =?utf-8?B?cHYxaGMzMUlsOVJCZjRkazg4L2FYRHVsTllXVE53cHRGbktiRjl6dzZzY1l4?=
 =?utf-8?B?WGdiSTZjWXEvT3BQWGtuV0haWHJFbUdMSE44ZXJJVnloUU5POW42bWZIU1kv?=
 =?utf-8?B?ajMvS3JHcldiV3YwdzhtQ0Y1TlZxYlYzYm9WcnBUQU81VHl6STQzK3BBeWxI?=
 =?utf-8?B?ZmxFOEM2OGpMUEswOUM4UThkRDZ5UTk0Y0dSei8yalBVQ3o3RExXdzFLRHMx?=
 =?utf-8?B?eEtsK0JxWFJlY0tabXFsZ2dQSDA1NjlwdTlqdExGdWhWV083RUgyUXJRSWZF?=
 =?utf-8?Q?OQmTOKnQZx9e/2ZmYk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: expleogroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 15475506-71a1-4de3-7716-08d8f0542c36
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 12:39:18.1605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3b0e7247-e0d5-44bf-8ed1-d01b18d16ca2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYNU9h3494kgTzBFM1N9f86kNpzByLH1bqZA/2CmVanWayWHr9oaftuhAA51Yu6w2QRMg9xcj0AMjSkzHrGQxGUavSeKTEjfEDT57/GABNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4104
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SXQgaXMgcG9zc2libGUgdGhhdCBzb21lIGNoYXJhY3RlcmlzdGljcyB1c2UgdGhlIE5vdGlmeSBh
cyB3ZWxsIGFzIEluZGljYXRlIHByb3BlcnR5Lg0KSW4gdGhpcyBjYXNlIHRoZSBDQ0MgdmFsdWUg
aXMgMyBhbmQgQmx1ZVogcmV0dXJucyBCVF9FUlJPUl9DQ0NfSU1QUk9QRVJMWV9DT05GSUdVUkVE
Lg0KVGhpcyBzaG91bGQgYmUgdGhlIGJlaGF2aW9yIGZvciB2YWx1ZXMgPiAzLg0KLS0tDQogc3Jj
L2dhdHQtZGF0YWJhc2UuYyB8IDYgKysrLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL3NyYy9nYXR0LWRhdGFiYXNlLmMg
Yi9zcmMvZ2F0dC1kYXRhYmFzZS5jDQppbmRleCBiZTZkZmIyNjUuLjhlMTZjMWQ3OSAxMDA2NDQN
Ci0tLSBhL3NyYy9nYXR0LWRhdGFiYXNlLmMNCisrKyBiL3NyYy9nYXR0LWRhdGFiYXNlLmMNCkBA
IC0yNjQ4LDkgKzI2NDgsOSBAQCBzdGF0aWMgdWludDhfdCBjY2Nfd3JpdGVfY2Ioc3RydWN0IHBl
bmRpbmdfb3AgKm9wLCB2b2lkICp1c2VyX2RhdGEpDQogICAgcmV0dXJuIEJUX0FUVF9FUlJPUl9J
TlNVRkZJQ0lFTlRfUkVTT1VSQ0VTOw0KDQogIC8qIERvbid0IHN1cHBvcnQgdW5kZWZpbmVkIEND
QyB2YWx1ZXMgeWV0ICovDQotIGlmICh2YWx1ZSA+IDIgfHwNCi0gICAodmFsdWUgPT0gMSAmJiAh
KGNocmMtPnByb3BzICYgQlRfR0FUVF9DSFJDX1BST1BfTk9USUZZKSkgfHwNCi0gICAodmFsdWUg
PT0gMiAmJiAhKGNocmMtPnByb3BzICYgQlRfR0FUVF9DSFJDX1BST1BfSU5ESUNBVEUpKSkNCisg
aWYgKHZhbHVlID4gMyB8fA0KKyAgICh2YWx1ZSAmIDB4MSAmJiAhKGNocmMtPnByb3BzICYgQlRf
R0FUVF9DSFJDX1BST1BfTk9USUZZKSkgfHwNCisgICAodmFsdWUgJiAweDIgJiYgIShjaHJjLT5w
cm9wcyAmIEJUX0dBVFRfQ0hSQ19QUk9QX0lORElDQVRFKSkpDQogICAgcmV0dXJuIEJUX0VSUk9S
X0NDQ19JTVBST1BFUkxZX0NPTkZJR1VSRUQ7DQoNCiAgaWYgKGNocmMtPm5vdGlmeV9pbykgew0K
LS0NCjIuMzEuMA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQpFeHBsZW8gR2VybWFu
eSBHbWJIDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQgfCBDb3Jwb3JhdGUgSGVhZHF1YXJ0ZXJzOiBN
w7xuY2hlbg0KSGFuZGVsc3JlZ2lzdGVyIHwgQ29tbWVyY2lhbCBSZWdpc3RlcjogQW10c2dlcmlj
aHQgTcO8bmNoZW4gSFJCIDgzMjUyDQpHZXNjaMOkZnRzZsO8aHJ1bmcgfCBNYW5hZ2VtZW50OiBS
YWxwaCBHaWxsZXNzZW4sIE1hcmN1cyBHYW5ndWluDQoNClRoaXMgbWVzc2FnZSBjb250YWlucyBp
bmZvcm1hdGlvbiB0aGF0IG1heSBiZSBwcml2aWxlZ2VkIG9yIGNvbmZpZGVudGlhbC4gSXQgaXMg
aW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC4NCklm
IHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHlvdSBhcmUgbm90IGF1dGhvcml6
ZWQgdG8gcmVhZCwgcHJpbnQsIHJldGFpbiwgY29weSwgZGlzc2VtaW5hdGUsIGRpc3RyaWJ1dGUs
IG9yIHVzZSB0aGlzIG1lc3NhZ2Ugb3IgYW55IHBhcnQgdGhlcmVvZi4NCklmIHlvdSByZWNlaXZl
IHRoaXMgbWVzc2FnZSBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0
ZWx5IGFuZCBkZWxldGUgYWxsIGNvcGllcyBvZiB0aGlzIG1lc3NhZ2UuDQpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRU1BSUwgTEVH
QUwgTUVOVElPTiAvIERJU0NMQUlNRVINCg0KVGhpcyBtZXNzYWdlIGNvbnRhaW5zIGluZm9ybWF0
aW9uIHRoYXQgbWF5IGJlIHByaXZpbGVnZWQgb3IgY29uZmlkZW50aWFsIGFuZCBpcyB0aGUgcHJv
cGVydHkgb2YgdGhlIEV4cGxlbyBTZXJ2aWNlcyBTQVMsIFJDUyBWZXJzYWlsbGVzIDgzMSAxNzgg
MzQ4LCBsb2NhdGVkLCAzIGF2ZW51ZSBkZXMgUHLDqXMsIDc4MTgwIE1vbnRpZ255IExlIEJyZXRv
bm5ldXggLSBGcmFuY2UuIEl0IGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gdG8gd2hv
bSBpdCBpcyBhZGRyZXNzZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQs
IHlvdSBhcmUgbm90IGF1dGhvcml6ZWQgdG8gcmVhZCwgcHJpbnQsIHJldGFpbiwgY29weSwgZGlz
c2VtaW5hdGUsIGRpc3RyaWJ1dGUsIG9yIHVzZSB0aGlzIG1lc3NhZ2Ugb3IgYW55IHBhcnQgdGhl
cmVvZi4gSWYgeW91IHJlY2VpdmUgdGhpcyBtZXNzYWdlIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5
IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBhbGwgY29waWVzIG9mIHRoaXMgbWVz
c2FnZS4NCg0KQ2UgbWVzc2FnZSBjb250aWVudCBkZXMgaW5mb3JtYXRpb25zIHF1aSBwZXV2ZW50
IMOqdHJlIHByaXZpbMOpZ2nDqWVzIG91IGNvbmZpZGVudGllbGxlcyBldCBlbGxlcyBzb250IGRl
IGxhIHByb3ByacOpdMOpIGQnRXhwbGVvIFNlcnZpY2VzIFNBUywgUkNTIFZlcnNhaWxsZXMgODMx
IDE3OCAzNDgsIHNpdHXDqSwgMyBhdmVudWUgZGVzIFByw6lzLCA3ODE4MCBNb250aWdueSBsZSBC
cmV0b25uZXV4LUZyYW5jZS4gSWwgZXN0IGRlc3RpbsOpIHVuaXF1ZW1lbnQgw6AgbGEgcGVyc29u
bmUgw6AgcXVpIGVzdCBhZHJlc3PDqS4gU2kgdm91cyBuJ8OqdGVzIHBhcyBsZSBkZXN0aW5hdGFp
cmUgdmlzw6ksIHZvdXMgbifDqnRlcyBwYXMgYXV0b3Jpc8OpIMOgIGxpcmUsIGltcHJpbWVyLCBj
b25zZXJ2ZXIsIGNvcGllciwgZGlmZnVzZXIsIGRpc3RyaWJ1ZXIgb3UgdXRpbGlzZXIgY2UgbWVz
c2FnZSBvdSB0b3V0ZSBwYXJ0aWUgZGUgY2VsdWktY2kuIFNpIHZvdXMgcmVjZXZleiBjZSBtZXNz
YWdlIHBhciBlcnJldXIsIHZldWlsbGV6IGVuIGF2ZXJ0aXIgaW1tw6lkaWF0ZW1lbnQgbCdleHDD
qWRpdGV1ciBldCBzdXBwcmltZXIgdG91dGVzIGxlcyBjb3BpZXMgZGUgY2UgbWVzc2FnZS4NCg==
