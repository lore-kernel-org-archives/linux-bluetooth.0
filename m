Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2659C47082
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 12:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B55761287
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 12:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhEaMRz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 May 2021 08:17:55 -0400
Received: from deltahqout.deltaww.com ([113.196.174.111]:53782 "EHLO
        deltahqout.deltaww.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhEaMRy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 May 2021 08:17:54 -0400
X-Greylist: delayed 930 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 May 2021 08:17:53 EDT
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02E5BDC34D;
        Mon, 31 May 2021 20:00:38 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loytec.com;
        s=Delta2019; t=1622462439;
        bh=RdXrkVl4ENJen584Mfui+EnA0GpPDYUNVW0DWlay+pw=; h=From:To:Date;
        b=T7yOD1BPLPzan/wq8IC1Yvl1bmLlUy8noidAwbdkvmYzTXbr1UN5Lq6lpm7ypQR9A
         Vh70fJIyTXz7tp/TfWw1hlaEx7AVsy8hXerJ8FfTzsauSQ7QtCv0qXgCuscRXKzxME
         jkTBlX3QB/vlTUZyU2bYnIGazPNCtC30KqmGlXus=
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA9C8DC33F;
        Mon, 31 May 2021 20:00:37 +0800 (CST)
Received: from TWTPEDLPDP01 (unknown [10.136.156.144])
        by deltahqout.deltaww.com (Postfix) with ESMTP;
        Mon, 31 May 2021 20:00:37 +0800 (CST)
Received: from TWTPEDLPDP01.delta.corp (TWTPEDLPDP01.delta.corp [127.0.0.1])
        by TWTPEDLPDP01.delta.corp (Service) with ESMTP id 43932C11AA4F;
        Mon, 31 May 2021 20:00:29 +0800 (CST)
Received: from TWTPEEXHYBRID03.delta.corp (unknown [10.136.157.227])
        by TWTPEDLPDP01.delta.corp (Service) with ESMTP id 26A38C11AA43;
        Mon, 31 May 2021 20:00:29 +0800 (CST)
Received: from TWPJ1EXHYBRID04.delta.corp (10.145.157.228) by
 TWTPEEXHYBRID03.delta.corp (10.136.157.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 20:00:37 +0800
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105)
 by TWPJ1EXHYBRID04.delta.corp (10.145.157.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Mon, 31 May 2021 20:00:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSECT7XR8pxtBkV1A0oGY4SLxiOc6qwmy3ix9LZTybPPUtFuwk5aUhsjlryGx1qFAAY9TnO1tTTW7KQt2vXd4qjyP6cVDAMavLbrz8kcnqaywC+XVFCSKLdK3jQPO1sF6KMrn9KunFW9NxTiYDbkQxFgupm9ile+CPueelCohzIbzZxlxcrH0g1/iq9XMX0JDJhlCEkOLthE+nThIwrwK/Cd9xN11nHjFNBdLEOsHRgkt9dEx65CEmJnf1I3oaKG5d4kb4s6SQTyoTqgDl4tcwYL6pB4rLiMJ+00SW+Vu89uWbjRV67iMEfrPptYhYvXtJqGagD9G/ji0u/fMyryxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdXrkVl4ENJen584Mfui+EnA0GpPDYUNVW0DWlay+pw=;
 b=c345lag3ZpfsGzyk0cOMxGVeEyGSZUW57Y1KDkis4rIoeUgmesHeKycmDZp5sDX4XkijT2EjE6F1wmUsxdO8L2UfT7PsaCN5ERnMt7vCtXlYVnkvSGcWlV4Qr4S/SgqahLYQj/H0SLjENNCGfKHb12NIpctEej1Aw/smDf9eHBh6gZsqBwc2PctMnIvNTIb2i0A1ewKgs39IwPL6LHEwfCkYSpt0wDkX+YlG29mdw/IX24sQRgacQPH96A5V+htVUfXxGXbEkOY3xcvQY/5/Q1xpLggaTX7QRp3lpLXz2t9fWO4hyVNOZhX7prji1xdh6PP/eDHmKWHsKlfeOnORjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=loytec.com; dmarc=pass action=none header.from=loytec.com;
 dkim=pass header.d=loytec.com; arc=none
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::7) by
 GV0P278MB0259.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.21; Mon, 31 May 2021 12:00:31 +0000
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::600b:b12d:9b25:db79]) by GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::600b:b12d:9b25:db79%6]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 12:00:31 +0000
From:   Isak Westin <karl.westin@loytec.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Mesh: Possibility to combine functionality of bluetooth daemon
 and bluetooth-mesh daemon
Thread-Topic: Mesh: Possibility to combine functionality of bluetooth daemon
 and bluetooth-mesh daemon
Thread-Index: AddSRA+l/nJ10uo2QpybqLxzHaKHBQAZm4wAANNCmZA=
Date:   Mon, 31 May 2021 12:00:31 +0000
Message-ID: <GV0P278MB012976FB79FA896F6A2A4A87953F9@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
References: <GV0P278MB012962632005A4784A9F243995249@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
 <19a594fe9e76de00331e16346e316a50c06d0f0b.camel@intel.com>
In-Reply-To: <19a594fe9e76de00331e16346e316a50c06d0f0b.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=loytec.com;
x-originating-ip: [212.17.98.152]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78377088-f512-4476-8978-08d9242bb0c3
x-ms-traffictypediagnostic: GV0P278MB0259:
x-microsoft-antispam-prvs: <GV0P278MB025959BE8110C35D96F817D4953F9@GV0P278MB0259.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spKvciHM9g2NDxYYst6d+HWI9EBx8uJwg5FM/Sq4IohtgK6xxuOw/vTz7CHw3xgYS3qOJ7pzOt6t+XiA1Yu7GLsaSkqZOdLHwImkg9mv8uFRVZFAQ3hd9UfhyDmYSEgpMGIRYnNhjwVyusPLLcNlBK3/QJJyqwb5hduaJ/6VnQNxKVpsIviDjdiKMS9g9EDZTXlSUmsPi10dzRDvK5V7fY+a4c+TQ7SMSsZL3pK2JZJUbqvedHgRv9st5XAsQXC7syz9dRE+LTJBuS2oiJWtSAtpdfehBf4vAmas6wKpjU1RWn30z542IYtycyOhaYg5dEBSebnG1Kt+Fk691UX4OwgR68YErSgTLqIOtTD0Y28EYX0hfp/BSGaoMmHkOkpLqoEsdg3XEvunbzrQss7x9L+sSnV+cLhTHFPyzkbp5DV9d+G7XKCNpKfFaQNDwpn4cYK/xe/Amf7LJp4epwZ2BmthE9kg/xhoVVyf73tmkLGWl6xuonOAa5tFINWxE+08F1dPVjq7gpLS74z3jfpbB04CwP2Biu8anbCqR9z16UzzRCjJqRy5NGAOQvKAnxNrX3HYBtzjUUiiuuUSOB0bffiQJGQoLNXALEETB3xJqnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39840400004)(396003)(52536014)(83380400001)(86362001)(26005)(8676002)(6506007)(8936002)(2906002)(55016002)(38100700002)(478600001)(186003)(33656002)(71200400001)(316002)(5660300002)(9686003)(66946007)(66446008)(76116006)(66476007)(122000001)(66556008)(110136005)(64756008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dEZ6ang4U2xrSmg2eVIwMW16Q011cDM3SnZLdEJGVWFxdGVuRjRrQy8xTDNp?=
 =?utf-8?B?MGM5dlBhZVZ5ZFBzYkNsOTRoREhwZ25xeTlwcExsTFdxenRsL3U4ZkVJekQ1?=
 =?utf-8?B?TEZJbFUxZDZCNVp6bVNubWE2NDVGaE0ra2Q5cVZPUDRlWjhrS0VrT3VvN2Fn?=
 =?utf-8?B?UDVwSHl3SXZvWGVsbUlVbWlnOVplcUJVV2pTejR1MU4yNEMyTThxVitkTGNJ?=
 =?utf-8?B?cEFqaDE1N0JNNDd4MnA4VjB0MEZEeDFsZjhTNHR5bHE1aHZ0TkVmbU5uQVNm?=
 =?utf-8?B?c08zRlRVQkhaN1BNelo4NkdkNHBLVTdUNFpNOEdmT1NEcWkySFhoL1FSU2xn?=
 =?utf-8?B?WkZGTHMra2Z3Ynd3dUxhUFZYWS96UHBUM1dOL2NvZ3M1YU5OS0greEJQT3FU?=
 =?utf-8?B?SVk0TU43b0xvcXNYM3lRT0hUSGFaV1N1QjVjYTQxbkdVdEJ4K0xtQzFkTmtT?=
 =?utf-8?B?aTdrRTIycUxJL3Y0R1pxaTdkS3BFdW1FK2VVbHN5VGVWcmlsT1BkbWZ5MDdR?=
 =?utf-8?B?OTRVUTYrRHQ3TzdRTFFpR1RsbWx6TXptT0RPQVRpYUdaQVNSdzNkS21uVkM0?=
 =?utf-8?B?OU9CengyaVBTS2kvOFpCYTJaUThuS2hNcGpScy9yUHl5MERrRXRSR1h6WG1w?=
 =?utf-8?B?VEZ5NC8xZVZ5dEU5YWxqeklSbHZ0WCtJMmYzT0hacGxYL2NnbG5yQU1IQkk0?=
 =?utf-8?B?clBmd1krOFY3Nkp2REY0bHdHSTFzRVF0QUQ0ZjdyVlpteGVEMnBkODJmNWdT?=
 =?utf-8?B?TG0vRlQzTGd1Zm4rNEVKM2FDdiswMUpDcUh4Z0hZUnNFMG00eHEwWU9qUm5H?=
 =?utf-8?B?NU5SaGovQTZYY3ZaTnhnQW15Q2JHYlhQK1Y4VW1aWVF3cHFiMjVVdjBHTTQx?=
 =?utf-8?B?V28va3U4OEpDN3hXa21DZmtnUWFOYXIzd1FEdW82ZXh6WUp0NjVFSDZqVTdp?=
 =?utf-8?B?dUFxK095MkFHM3VsNFV3WXM3YlprdmdYNXZDUCt4c1VTNHhCQU9Qek1oRitx?=
 =?utf-8?B?TVluUDFlaUkwZTRzdnZWMW5Gc292anVodzVzbkFpeW5rUVM2Z3h6Qm9VaStw?=
 =?utf-8?B?QnQxdUR6SnJJbm1ySWVGQ3dlU3ZNV3NKN20zcHU2ckZpODVLSWpYeDBFS3or?=
 =?utf-8?B?TEtzb2d4RlJlQmdJRTBtdmoyeVVXTlJOaDl4RHoxZGJxZFlqTUFPZVpwYksx?=
 =?utf-8?B?WGtuYmdtOFdBdDZxSUdXUHVTSTVvNEZRNVNEcnpaZzVFOVo5Sys0NDRhUUww?=
 =?utf-8?B?Q2VDVis2Yi8reEVqQnU2R0NrOU9OZjYrMG42ckIydVliYWJtY1cyOUtvYmVn?=
 =?utf-8?B?RW8zVi9qMG9IdUowdlRCMnBYUmxFdzFpSUhOL254czFmM2VlQ2oyL0xWcDhL?=
 =?utf-8?B?c0taZ0dzM2NmazRycFQ1bHNOaXdNbUpPT3hBZmM3UW45M3VmaWxIQ0h2K2N1?=
 =?utf-8?B?SGZtb1ZHMFpOYVpGRjJTb3lZcG1MSFJ1YnFoVkNFTVNXZXUyTlRaMUltUTNX?=
 =?utf-8?B?Nmo2dVhlVjRvVUtXNjVJOTN1UkhYWnNVZDRSK2xYdUpCWU1YQlBaRVpGdk5u?=
 =?utf-8?B?NXM0R25kcjgrOTNXSFRTZ3orNHBpb205em4yZFFZUVd2amcwbERLQkpmQWpY?=
 =?utf-8?B?SWZoU0hpTHhNUlJudUxIR0RJeXpTTlRVQk1GT0xXQ3VIdnc3QnQ2OUlyY3Rz?=
 =?utf-8?B?V3RSQUl5b2x0MFFHQ1phdG5oSGlKS1Y5WFAzZFhPOWVibDJnODZPOEg4T3My?=
 =?utf-8?Q?IrOycpP7bC2iu+HxMU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78377088-f512-4476-8978-08d9242bb0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2021 12:00:31.6637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 19f25823-17ff-421f-ad4e-8fed035aedda
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQlccEiNnqQtbi18w/w16NjYGUlee0VEagCH0s2shvU2mWXRM+0MfQqCS7j9S1yf2eu7nuQmQYm5AViMluKqzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0259
X-OriginatorOrg: loytec.com
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-8.6.0.1013-26190.007
X-TM-AS-Result: No--15.644-7.0-31-10
X-imss-scan-details: No--15.644-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1960-8.6.1013-26190.007
X-TMASE-Result: 10--15.644300-10.000000
X-TMASE-MatchedRID: DuKherWvI/tiHm449d3iljMvozJIQnRWC/ExpXrHizzJVWdgKXnqZOhN
        0jwIx2vHjM99hegWeMFXRMeffPZxCHYIQoHEix+q9u1rQ4BgXPIkMBkEieOjZqY3y6dPFN/1eCl
        yCIx6C47j8YdUABjPeuulrrvUsCg/8aVkBZkOPzJbKQUJutmaR86gBdMBUo41K8VLPDcP9n5O2k
        0QVChgeohNfnfp+MashAWki4cbZIHyE3TYj7NIEdeNTGdHWNS/RfAYyemXJ9+n7m/OxjmYo7iNB
        QfYxT0wFep4vGPIIO5kkeOUMf4iJdPVVUpuFvgvl5lQMzKmF9LnurB9e/dw254Q+L3BXIWu4yal
        npfBLSJgoIWdTBydXSclnA0li0gOk0i76rQKzpIRyVsAxhhjrLn4fV+jW8tHbDD7i2QfyEeCbtY
        LKQ+b1JkrM6omwdrAOhmSjrWq/QXtuJnxKbRCP6OknopQLzTu8vvksslXuLc/gf7afIrQU8JvHx
        NadDBf4FAc8pQ0DKW9/GoS6fS5VnItE0HyXabFHch4gZ8olb/XrgRxPDHiQ7gMZBX0PrAKZvo+m
        FW19mCNM6XjguNyIrfpypMYAsVw5VtV90uxxtflWZZHzIU5Uk+crEA4+nhZD+XGOhgZ/4cJ6Brl
        nsmwMeud5cGdYRo2VWS7GR4Fp27ZgcLitgfmzwEaayJtYZNtpNh/2/1+WiWbKItl61J/yfmS+aP
        r0Ve8oTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/s768nf/KClaI53Tjxe4WJalmJAoda/R+NbMi9Mm
        oFLs0Pag2nlackGA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQnJpYW4sDQoNClRoYW5rcyBmb3IgdGhlIHJlc3BvbnNlIQ0KDQo+IEhpIElzYWssDQo+IA0K
PiBZb3VyIHF1ZXN0aW9uIGlzIGZpbmUgZm9yIHRoZSBsaXN0LiBJIGFtIHBhcnQgb2YgbXkgY29t
cGFuaWVzICBCbHVlWiBzdXBwb3J0IHRlYW0sIHNwb2VjaWZpY2FsbHkgc3VwcG9ydGluZyBNZXNo
Lg0KPiANCj4gT24gV2VkLCAyMDIxLTA1LTI2IGF0IDE1OjMwICswMDAwLCBJc2FrIFdlc3RpbiB3
cm90ZToNCj4gPiBIaSBsaW51eC1ibHVldG9vdGggZGV2ZWxvcGVycywNCj4gPiANCj4gPiBJIGhv
cGUgbXkgcXVlc3Rpb24gaXMgbm90IHVuc3VpdGFibGUgZm9yIHRoaXMgbWFpbGluZyBsaXN0Lg0K
PiA+IA0KPiA+IEkgaGF2ZSByZWFkIGluIHRoZSBhcmNoaXZlcyBvZiB0aGlzIG1haWxpbmcgbGlz
dCB0aGF0IHRoZSBCbHVldG9vdGggDQo+ID4gbWVzaCBkYWVtb24gbmVlZHMgZXhjbHVzaXZlIGFj
Y2VzcyB0byBhIEJsdWV0b290aCBjb250cm9sbGVyLg0KPiA+IElmIEkgdW5kZXJzdGFuZCB0aGF0
IGNvcnJlY3RseSAoanVzdCB0byBiZSBjbGVhciksIGl0IG1lYW5zIHRoYXQgd2hlbiANCj4gPiBJ
IG9ubHkgaGF2ZSBvbmUgY29udHJvbGxlciwgSSBoYXZlIHRvIGNob29zZSBiZXR3ZWVuIGVpdGhl
ciB1c2luZyBtZXNoIA0KPiA+IG9wZXJhdGlvbnMgb3IgIm5vcm1hbCIgQmx1ZXRvb3RoIG9wZXJh
dGlvbnMgKG5vcm1hbCBoZXJlIG1lYW5pbmcgYWxsIG9wZXJhdGlvbnMgdGhhdCB0aGUgcmVndWxh
ciBCbHVldG9vdGggZGFlbW9uIGFscmVhZHkgcGVyZm9ybXMpLg0KPiANCj4gVGhhdCBpcyBjb3Jy
ZWN0Lg0KPiANCj4gPiBJbiBteSBjb21wYW55IHdlIGFyZSBub3cgZGV2ZWxvcGluZyBhIEJsdWV0
b290aCBtZXNoIGxpZ2h0aW5nIHNvbHV0aW9uIA0KPiA+IGJ5IHVzaW5nIHRoZSBCbHVldG9vdGgt
bWVzaCBkYWVtb24gaW4gYW4gZW1iZWRkZWQgTGludXggZW52aXJvbm1lbnQgDQo+ID4gKHdpdGgg
b25seSBvbmUgQmx1ZXRvb3RoIGNvbnRyb2xsZXIgYXR0YWNoZWQgdmlhIEhDSSkuIFdlIGhhdmUg
YSANCj4gPiBjdXN0b20gbWVzaCBhcHBsaWNhdGlvbiB0aGF0IGlzIHVzaW5nIHRoZSBtZXNoIERC
VVMgYXBpIHRvIHBlcmZvcm0gDQo+ID4gbWVzaCBvcGVyYXRpb25zLiBJIGFtIGN1cnJlbnRseSBs
b29raW5nIGluIHRvIGhvdyB3ZSBjYW4gYWRkaXRpb25hbGx5IGFsbG93IHRoaXMgYXBwbGljYXRp
b24gdG8gcGVyZm9ybSBvdGhlciBCbHVldG9vdGggb3BlcmF0aW9ucyAoaS5lLiBhY3RpbmcgYXMg
YW4gb2JzZXJ2ZXIsIGFuZCBpbiB0aGUgZnV0dXJlIGFsc28gYXMgYSBjZW50cmFsIGRldmljZSku
DQo+ID4gDQo+ID4gV2hlbiB5b3UgaGF2ZSB0aW1lLCBJIHdvdWxkIGJlIGludGVyZXN0ZWQgdG8g
aGVhciB5b3VyIGdlbmVyYWwgDQo+ID4gdGhvdWdodHMgYWJvdXQgdGhpcyB0b3BpYy4gV2hldGhl
ciBvciBub3QgeW91IGJlbGlldmUgaXQgaXMgZG9hYmxlIG9yIGlmIGl0IHBlcmhhcHMgYWxyZWFk
eSBpcyBhIHBhcnQgb2YgYSBsb25nLXRlcm0gcGxhbi4NCj4gPiBJIGFtIGFsc28gaW4gZ2VuZXJh
bCBvcGVuIHRvIGhlbHAgY29udHJpYnV0aW5nIHRvIHRoZSBwcm9qZWN0Lg0KPiANCj4gT3VyIHJv
YWRtYXAgZm9yIG1lc2ggc3VwcG9ydCBpbmNsdWRlcyBjaGFuZ2VzIHRvIHRoZSBsaW51eCBibHVl
dG9vdGgga2VybmVsIG1vZHVsZSwgdGhhdCB3aWxsIGFsbG93IFNlbmRpbmcgYW5kIFJlY2Vpdmlu
ZyBtZXNoIGFkdmVydGlzaW5nIHBhY2tldHMgb3ZlciB0aGUgTUdNVCBpbnRlcmZhY2UuIA0KPiBX
aGVuIGNvbXBsZXRlLCBpdCB3aWxsIGJlIHBvc3NpYmxlIGZvciBib3RoIHRoZSBjbGFzc2ljIEJs
dWV0b290aCBkYWVtb24gKGJsdWV0b290aGQpIGFuZCB0aGUgTWVzaCBkYWVtb24gKGJsdWV0b290
aC1tZXNoZCkgdG8gc2hhcmUgYSBzaW5nbGUgY29udHJvbGxlci4NCj4NCg0KRGlmZmljdWx0IHF1
ZXN0aW9uLCBJIGtub3csIGJ1dCBpZiB5b3Ugd2VyZSB0byBndWVzcyBhIHRpbWUgZnJhbWUgdW50
aWwgdGhpcyB3b3VsZCBiZSBmdWxseSBpbXBsZW1lbnRlZCwgd2hhdCB3b3VsZCB5b3VyIGd1ZXNz
IGJlPw0KDQpBbmQgbGV0J3Mgc2F5IHRoYXQgbXkgY29tcGFueSBkZWNpZGUgdGhhdCBzaGFyaW5n
IGNvbnRyb2xsZXIgaXMgdGhlIG9ubHkgb3B0aW9uIGZvciBvdXIgcHJvZHVjdCwgdGhlbiB3ZSB3
b3VsZCBhbHNvIGJlIG9wZW4gdG8gaGVscCBjb250cmlidXRpbmcgdG8gdGhlIGxpbnV4IEJsdWV0
b290aCBwcm9qZWN0IGluIG9yZGVyIHRvIHJlYWNoIGFuIGltcGxlbWVudGF0aW9uIGVhcmxpZXIu
DQpXb3VsZCB0aGF0IGJlIGFuIG9wdGlvbiBhbmQgaXMgaXQgZW5jb3VyYWdlZD8gQW5kIGlmIHll
cywgaG93IGRvZXMgdGhhdCB1c3VhbGx5IHdvcmsgaW4gcHJhY3RpY2U/DQoNCj4NCj4gV2UgZXhw
ZWN0IHRoaXMgdG8gd29yayBPSyBtdWNoIG9mIHRoZSB0aW1lLi4uICBiYXNpY2FsbHkgd2hlbiBu
b3QgbXVjaCBpcyBoYXBwZW5pbmcgd2l0aCBBQ0wgb3IgU0NPIGxpbmtzLg0KPiBBbmQgZXZlbiAq
d2l0aCogQUNMIGFuZCBTQ08gbGlua3MsIHdlIGV4cGVjdCB2ZXJ5IGxpZ2h0IG91dGJvdW5kIHRy
YWZmaWMgdG8gd29yayBPSy4NCj4gV2hlbiB0aGVyZSBhcmUgbm8gQUNML1NDTyBjb25uZWN0aW9u
cyBhY3RpdmUsIHRoaW5ncyB3aWxsIHdvcmsgcHJldHR5IG11Y2ggYXMgbm9ybWFsLiANCj4gSG93
ZXZlciwgYW55IGhpZ2gtdHJhZmZpYyBkYXRhIGxpbmsgb3JpZW50ZWQgdXNhZ2Ugd2lsbCBoYXZl
IGEgdmVyeSBuZWdhdGl2ZSBhZmZlY3Qgb24gYSBzaW5nbGUgY29udHJvbGxlcnMgYWJpbGl0eSB0
byBiZSBhbiBhY3RpdmUgbWVzaCBtZW1iZXIsIA0KPiB3aGljaCBtZWFucyB0aGF0IGV2ZW4gKmFm
dGVyKiB0aGUgc2hhcmVkLWNvbnRyb2xsZXIgc3lzdGVtIGlzIHJlYWR5IGZvciBpbmNsdXNpb24g
aW4gdGhlIGtlcm5lbCBhbmQNCj4gYmx1ZXRvb3RoLW1lc2hkIGRhZW1vbiwgaXQgd2lsbCBzdGls
bCBiZSByZWNvbW1lbmRlZCB0aGF0IGEgc2VwZXJhdGUgY29udHJvbGxlciBiZSB1c2VkIGluIG1v
c3QgY2FzZXMuIA0KPiANCj4gDQo+ID4gVGhhbmsgeW91IGZvciB5b3VyIHRpbWUsDQo+ID4gSXNh
aw0KPiA+IA0KPiANCj4gQmVzdCBSZWdhcmRzLA0KPiBCcmlhbg0KPiANCg0KQmVzdCByZWdhcmRz
LA0KSXNhaw0K
