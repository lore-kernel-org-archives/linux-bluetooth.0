Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C0CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 13:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJGNdW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiJGNdV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 09:33:21 -0400
Received: from deltahqout.deltaww.com (deltahqout.deltaww.com [220.128.70.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2AF76444
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 06:33:17 -0700 (PDT)
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FA6213C169;
        Fri,  7 Oct 2022 21:33:15 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loytec.com;
        s=Delta2019; t=1665149596;
        bh=Yv24WbQLTloEK8nI1nhfOTSd6phXlfAD3bQkyjFLeGc=; h=From:To:Date;
        b=lyh2JTW5AzQRc1DoNE6F1siO41zXTNzOK0tN0YpSdOKWXAOgfeuOh7+J/GlU8WQ6U
         4M4Osr7qWblpz8d7SWng+GrnH4n3esNl+KoaQk7M5pQUAXqaGevio8UYtkLbIfEc9I
         db8//21XZxyk8wFa2j41RtHrcbB2abyf1Fhk0HQ8=
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7960D13C0FD;
        Fri,  7 Oct 2022 21:33:15 +0800 (CST)
Received: from TWPJ1EXHYBRID02.delta.corp (unknown [10.145.157.226])
        by deltahqout.deltaww.com (Postfix) with ESMTPS;
        Fri,  7 Oct 2022 21:33:15 +0800 (CST)
Received: from TWTPEEXHYBRID04.delta.corp (10.136.157.228) by
 TWPJ1EXHYBRID02.delta.corp (10.145.157.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 7 Oct 2022 21:33:15 +0800
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.108)
 by TWTPEEXHYBRID04.delta.corp (10.136.157.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.9
 via Frontend Transport; Fri, 7 Oct 2022 21:33:14 +0800
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::7) by
 ZRAP278MB0826.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:49::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.32; Fri, 7 Oct 2022 13:33:09 +0000
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7692:ca19:8bd0:928a]) by GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7692:ca19:8bd0:928a%3]) with mapi id 15.20.5676.034; Fri, 7 Oct 2022
 13:33:09 +0000
From:   Isak Westin <karl.westin@loytec.com>
To:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH BlueZ 5/6] mesh: Keep canceled SAR data for at least 10
 sec
Thread-Topic: [PATCH BlueZ 5/6] mesh: Keep canceled SAR data for at least 10
 sec
Thread-Index: AQHY2ZRMw7ATnDH3NUGG8lNdyNY6464B2K8AgAC6nACAAAAcAA==
Date:   Fri, 7 Oct 2022 13:33:09 +0000
Message-ID: <GV0P278MB01298DB6AC0C593245E3FCFB955F9@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
References: <20221006145927.32731-1-isak.westin@loytec.com>
         <20221006145927.32731-6-isak.westin@loytec.com>
 <4c8e20487a5ee71088bf6374bae8fd55a95055b3.camel@intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=loytec.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV0P278MB0129:EE_|ZRAP278MB0826:EE_
x-ms-office365-filtering-correlation-id: 797fcf1a-a0ef-46ea-b039-08daa86879a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CEHhZ98StY6erjYGq8FmqjtjENV1KSO7EEnx3O8oOH4rqM4d5IMHwrEJXjZDTVmVjdqdUk21YHyz8zGyCxcXjXwB8S4ITvya3U6ckGIuQDyH41cWL46xLkrZ/kUD75J1WWJvpkVpP9rGYoCBFF+GQoPAqaYzdACJsQ7P8K1lOX6u0gxZDcsp1/DgdtRDOIkyE4VJM9Bj39wLsL+QatvfnjYasjBUzp/w/FaK+tQkJFTf/daXLPb8KJ6hOpAjtDVOfNBd9UFznK8jAp2s7hVLl1DM2c7M+2zS2c+BYV7H9xvy/Qnig2XCxb01L7BIlTirF25eW1fcQ9abstE2AM9TtL/k/dcKoQgFytkG6vHcUIzuQgIHsFHISq+lgmu3T/D94iPQd1WijMP+yybIGtDiYMvfRs9i0TWe0Pwl8PkTkSYE/MzIEW6TsMuORc7KEcjrIw+xsnzOb3RFmpykTiUSC+38TH6J205/WuTRcZDy/mK016kYNvZXozfFl6PEjHgpATyxLUv9msJTXtKMvUIsmA0vqzGh1mjsiSaCjLmfBS5JwHASwj9eceHC00NePd0c3hthJX2p0NP1AQLC8JUmnO9nREJFlipKjwYxkNvV40MONTB/eg7uu9Lw7nmAucp91pbWnYLZ3eXUhAgGATxPl2sfR5xjTc7cdfZ97F3yKYA/RJJpAd9at72uFU2TqZL1CLtJ9GCt7h5LueOQL2loLsFbRU+g3Tk9uSOfALq+x7iPcHKNRgd5rWcuXrYldZW0uz0xmu1sdKMxD9sHyXU/kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39850400004)(136003)(376002)(451199015)(44832011)(55016003)(33656002)(8936002)(7696005)(52536014)(26005)(71200400001)(9686003)(6506007)(5660300002)(64756008)(86362001)(38070700005)(66946007)(83380400001)(76116006)(66446008)(41300700001)(478600001)(66476007)(316002)(110136005)(186003)(2906002)(8676002)(66556008)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzJqZGhJendrVS8vY1JYY0FMcWVlcnNOcGNVU1lNS1hYbmZ0NFZ1NEUrOEtT?=
 =?utf-8?B?L2ZzR2FLZVJXR0tvK3JHdWxWN0g5VmZaUHp2bkR3dGZzMC9hOXkwYWZZV3R3?=
 =?utf-8?B?VGhiSkRPQ2NrMEV3S0NQU3oycnZNZy9wQ3IwbzhMdDhBTDBHNG1ndEw4ZC9E?=
 =?utf-8?B?YjlRRWJ6bVQ5dG1iRWtCbW5YM3ZXbERYeWg2VkJJdkRIN0NLeHFpdGhMdEhv?=
 =?utf-8?B?U1NxWUowaXkrdkNtZG5QNjVWK0hPTXZ0RFd0VTVPS1lSSnRCWW1TTjlrbGZJ?=
 =?utf-8?B?NmFqOHJtMlpST3N2WjRyTWpMbXBGVVBFWWF2Q3VieUZPYU1FNWpKaXRKNWxG?=
 =?utf-8?B?aWVOWkFTY1FqYVB1QWYrdzNsa3oxVDFTM1FjNmZ2cjNPQlVyMm5VbkdqaUJj?=
 =?utf-8?B?WnVxbmJWL3dXejdrZjlzRVdsZkQrTHYvN25BU2lHZFNIZmNMY3NheE1VMzgw?=
 =?utf-8?B?UkMzaERFUENsOUpTL015RStSRFZWTm9MQjhpdjdpMjhieGRTM0hUSi9HWEZH?=
 =?utf-8?B?V3ZVdXUyeWI5ZGJsZmVoZForTU5MVWI5NlBSM0JweE16MnV4TlROWnRBeFBy?=
 =?utf-8?B?anBmU2w3SklYYUJPZ3BRVFVxZnovdnNDWlNQak5hODN4Y2laZFpHaGgxKzBw?=
 =?utf-8?B?ZGdYNnFBZWhlREEwUmF6ditySi82djcvM0lDTEhJbk91TmhKdUxlWFk5NGhJ?=
 =?utf-8?B?cjkxOE4zS2dvMlVLbFBjdmxKNHE4T1l4dEdpazlZOHlHMU9CSU1JYU05cE4y?=
 =?utf-8?B?OEE0eUZDNnlqM3QyRXhzQ01DekVPVFlXQWF1dnBCMExxVkpCQmF4T05SU1J2?=
 =?utf-8?B?dDB4ZlpDQ0RNR2xwU2ZWTVFkekhDTm9Ua1JGMGlUa1VEaWYvNGRSSDJ5YXow?=
 =?utf-8?B?UUpSSFhoZjcxRWpJK3RZVUZLWHNHaVIzc01hbURneUpjSU9ERy9McmtNSmFQ?=
 =?utf-8?B?U0s4cU1vUkdmOXNLM2UzZ1pkMlRyVFRmTitBN0VkT3cyZVJnS0VJenZyMFNM?=
 =?utf-8?B?cnp2UUhqTzhBUGNFcFlWMVY1NWtzZDlUOTRTa3FzbmV0UkhFUC9CNmg4dHNK?=
 =?utf-8?B?MjVydElZclp5S05pRkYvSUZiOGl1QjJ1Zm50eEJ2SzVHNVFTS0VTcVZvSWdQ?=
 =?utf-8?B?VmJMd2p6QTBXeWtvMW10WTJJZzZ0cXdYN0NFK0taSWt3RmZCQ1pucnR0NjVU?=
 =?utf-8?B?bmMwaWRrQUJ0NFlRK0RlbEpyU1dlOHRKS1YxbGRaaUxraUkvRm1pblBVbHR1?=
 =?utf-8?B?LzRucUhsRWRmcW5tenFFOUVvRnRJZC90T2M5Um1kZkVQN0hDaEpHejhHUDB6?=
 =?utf-8?B?WXpuNm8wMS9FcTdBZTdpWXF3aHowakx5UHVvamFYb2RLL0dTMHhJSVR4L3hP?=
 =?utf-8?B?dXNqVWd3MXZjemg3NTM4ZGFvN2IybHdoeGtIbHNzemRkbGo0RzB6ek9KVUN3?=
 =?utf-8?B?dG5NYnhSTU8xZThwL3VQTkE5ZW1Gb09XVjRuMmMrSUx5L1FhVnZvODNJZGdV?=
 =?utf-8?B?ZVhoZ28wbGxFSit6SW9zNDd0U2JpSnlkNzNUWmQreCtCaFV4bTZJWDJ6aDB5?=
 =?utf-8?B?U2xNcitVTlRSWHZTemdCZDV0OW5ZczNPdmxRUmdkY0RjYzQ0Y1ZhbzJFOHVa?=
 =?utf-8?B?SDR3cEZhM2NKZWwrSm1JZlpqaUtFdmxKUFlIVFQ2RFV6bWFOSGFBOXlpcEtr?=
 =?utf-8?B?b3BvUDJIRHJ4KzJzQXZkSkJ2MnNuUm4xMGpvdENrMmIxcEM5dllwYmExS25s?=
 =?utf-8?B?cW9IVDFUN01DajhaUFZNWTdhbHYyMlJFTk1YWUVWZDk1VnQvU1I0cFBaRkdy?=
 =?utf-8?B?T0xmWmNwYjNGaDl5aFlaVjc2NzFFbXJiZ0trWUxwT0xOOUFGWG5HMG0zQkVr?=
 =?utf-8?B?YnFVMnA4eDczQVpVSjk4U0hnMVZCWmNLaDdIRmg2STE4NXpvKzd3L0FFWUtk?=
 =?utf-8?B?TWpvZ3FyOXF0c1lSNFp5UkUzUTVrcURsMTZ0cG01d1Evd1VoeXZjTlNzaGZa?=
 =?utf-8?B?TTVJS0dGKyt6bjBTY2g3Tys0WnYwZlVuazFZZDFoU2hpNU9nelhVaTNCMlgw?=
 =?utf-8?B?czlzdDFkT3djdGVUYkNuQ3NJV2Rqb29pM0JyUndaSnNyNStsZGdMKy9PZ0dm?=
 =?utf-8?Q?gCe8ucH7UkWtIRy2nYXCOpp3o?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmDnltL0t/RNetyJumn8I1kk3WKN6KHnBqcxZYmHTc3Lng/XRaC4VsBtLrE4SzBXqt3FFCc6X/2Af7rWGK3h4tHu0TZF57x/Xxo4Dde8hro65N7Dy8d6FrcFomCi0KROCUlkg46jEx9570II5D/gKXLoraHBzXFKqa39BQHIJOe8FLtC3CQqj3M1Lo1/v9/pJVnj4V5MzwHYOq/cVh267HJeXd1ATkcyncWGPt5MfmfL6pICclVGUdzaq9lAwSRkqxRxiDQ5WdAIO1gBj813CXVG81GEYDbvfwuJhwy8AFL3rZuj3iBjvsJmuO8DkXW8KS8KQ9vReygw7h4dZqpOtg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtZrw8vyc7mjZpel2FQML+YY/HfGFl6qFyf6WY0/sZs=;
 b=DAHGUY/r3cXItXOBZ1w3mLXtwHm4MtWgUE9M4WsbNjMLxZK0KSsKS7YlxuJt4BiXxfGB0SNSaYd6e0tg1qrtaXkRrXcrpPDUG3FEj7L2xu+mYjtu8Vnq+OlOx1K4AjdncHFrer3Ts4zMJejAoGn5yWeoWyXPSr1c9uRD2NfAbPB/Qv/0HDvwZqkntuoocyKfZULO2r9yht9LlQ4B2taNkruTCQAEoGZJ1qekL21EUox8oG779b0gYWdxIPjyfTf/IWszic+ksFw5U4UrbCdUwH7zCh6k+7u0/u2a2yixgQ9+4/5XjuO0vZsQOTRWa9KXnHy75NPqcxwUouTMTTdlxw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=loytec.com; dmarc=pass action=none header.from=loytec.com;
 dkim=pass header.d=loytec.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
x-ms-exchange-crosstenant-network-message-id: 797fcf1a-a0ef-46ea-b039-08daa86879a3
x-ms-exchange-crosstenant-originalarrivaltime: 07 Oct 2022 13:33:09.6713 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 19f25823-17ff-421f-ad4e-8fed035aedda
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: AvRrwIYpUdj34rJT8TM3vnVPM8EAOW1MNB4xn6a/F9x+gijzLU6X6va4n2EfuNyOminfnPWYm/WmyetlJ6O2Yg==
x-ms-exchange-transport-crosstenantheadersstamped: ZRAP278MB0826
x-originatororg: loytec.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.2116-9.0.0.1002-27186.007
X-TM-AS-Result: No--14.835-7.0-31-10
X-imss-scan-details: No--14.835-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.2116-9.0.1002-27186.007
X-TMASE-Result: 10--14.835000-10.000000
X-TMASE-MatchedRID: eVEkOcJu0F44HKI/yaqRmxMxKDqgAFSzkdS3kPlaZyXkMnUVL5d0EyrB
        Ldpas6PSWhZ7HebQga06GgA7KKe0oKZY4PxfRMWE3nHtGkYl/VqW0X7Fb7OFSPmt2wtrXQjM7sv
        HEURJyCiYD3JmsdUWgD8b21I0GekZVlWj4EEFi/CtvDfLuwpDh+NS+fPZe8iFe0uomYEfecFuBK
        Vb9FhXCUg5PCKc2OXlZCn+RolpoONxV5gKrHXBXE7nLUqYrlslFIuBIWrdOePfUZT83lbkEAFpI
        DHLwQ/CJt8KlS7APfjpA9zAtoTtQQA9cDrFZsqXKiJEqUFWRgi6hgVvSdGKo1/8lGqVstJXjXo1
        v7B3XhCBwOiAXd70LJcZ0icLp7DqQv21zJNl0CyDGx/OQ1GV8t0H8LFZNFG7bkV4e2xSge4CSf3
        KNDuUbr2Bpd9q5NGxWf0xU/RWlDqJKKvjw+1jv+ulxyHOcPoH
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQnJpYW4sDQoNCj4gSGkgSXNhaywNCj4NCj4gSGF2ZSB5b3UgcnVuIHRoaXMgcGF0Y2ggdGhy
b3VnaCBhbnkgcnVudGltZSBhbmFseXNpcyAobGlrZSB2YWxncmluZA0KPiBldGMpIHRvIGVuc3Vy
ZSBpdCBoYXMgaW50cm9kdWNlZCBubyBtZW1vcnkgbGVha3M/DQo+DQo+IEkgYW0gcGFydGljdWxh
cmlseSBjb25jZXJuZWQgd2l0aCBhbnkgbF90aW1lb3V0X3JlbW92ZSgpIGNhbGxzIHRoYXQgZG9u
J3QgaW1tZWRpYXRlbHkgc2V0IHRoZSBmcmVlZCB0aW1lciBwb2ludGVyIHRvIE5VTEwsIGFuZCBh
bnkgbmV3DQo+IGxfdGltZW91dF9jcmVhdGUoKSBjYWxscyB0aGF0IGFyZSBub3QgcHJlY2VkZWQg
d2l0aCBhIGNoZWNrIHRoYXQgdGhlcmUgaXMgbm90IGFscmVhZHkgYSB2YWxpZCBwb2ludGVyIG9j
Y3VweWluZyB0aGUgc2VnX3RpbWVvdXQgb3IgbXNnX3RpbWVvdXQgbWVtYmVycy4NCj4NCg0KSSB0
ZXN0ZWQgaXQgd2l0aCB2YWxncmluZCBhbmQgZm91bmQgbm8gbWVtb3J5IGxlYWtzLiBIb3dldmVy
LCBpdCBpcyBwZXJoYXBzIGFueXdheSBhIGJldHRlciBwcmFjdGljZSB0byB1c2UgbF90aW1lb3V0
X21vZGlmeSgpID8NCklmIHNvLCBJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaC4NCg0KPiBPbiBUaHUs
IDIwMjItMTAtMDYgYXQgMTY6NTkgKzAyMDAsIElzYWsgV2VzdGluIHdyb3RlOg0KPiA+IFdoZW4g
YSBTQVIgdHJhbnNtaXNzaW9uIGhhcyBiZWVuIGNvbXBsZXRlZCBvciBjYW5jZWxlZCwgdGhlIHJl
Y2lwZW50DQo+ID4gc2hvdWxkIHN0b3JlIHRoZSBibG9jayBhdXRoZW50aWNhdGlvbiB2YWx1ZXMg
Zm9yIGF0IGxlYXN0IDEwIHNlY29uZHMNCj4gPiBhbmQgaWdub3JlIG5ldyBzZWdtZW50cyB3aXRo
IHRoZSBzYW1lIHZhbHVlcyBkdXJpbmcgdGhpcyBwZXJpb2QuIFNlZQ0KPiA+IE1zaFBSRnYxLjAu
MSBzZWN0aW9uIDMuNS4zLjQuDQo+ID4gLS0tDQo+ID4gIG1lc2gvbmV0LmMgfCAzMCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBi
L21lc2gvbmV0LmMNCj4gPiBpbmRleCAzNzlhNmUyNTAuLmU5NWFlNTExNCAxMDA2NDQNCj4gPiAt
LS0gYS9tZXNoL25ldC5jDQo+ID4gKysrIGIvbWVzaC9uZXQuYw0KPiA+IEBAIC00Niw2ICs0Niw3
IEBADQo+ID4NCj4gPiAgI2RlZmluZSBTRUdfVE8gMg0KPiA+ICAjZGVmaW5lIE1TR19UTyA2MA0K
PiA+ICsjZGVmaW5lIFNBUl9ERUwgICAgICAgIDEwDQo+ID4NCj4gPiAgI2RlZmluZSBERUZBVUxU
X1RSQU5TTUlUX0NPVU5UICAgICAgICAgMQ0KPiA+ICAjZGVmaW5lIERFRkFVTFRfVFJBTlNNSVRf
SU5URVJWQUwgICAgICAxMDANCj4gPiBAQCAtMTY2LDYgKzE2Nyw3IEBAIHN0cnVjdCBtZXNoX3Nh
ciB7DQo+ID4gICAgICAgICBib29sIHNlZ21lbnRlZDsNCj4gPiAgICAgICAgIGJvb2wgZnJuZDsN
Cj4gPiAgICAgICAgIGJvb2wgZnJuZF9jcmVkOw0KPiA+ICsgICAgICAgYm9vbCBkZWxldGU7DQo+
ID4gICAgICAgICB1aW50OF90IHR0bDsNCj4gPiAgICAgICAgIHVpbnQ4X3QgbGFzdF9zZWc7DQo+
ID4gICAgICAgICB1aW50OF90IGtleV9haWQ7DQo+ID4gQEAgLTE0OTMsMTMgKzE0OTUsMjcgQEAg
c3RhdGljIHZvaWQgaW5zZWdfdG8oc3RydWN0IGxfdGltZW91dA0KPiA+ICpzZWdfdGltZW91dCwg
dm9pZCAqdXNlcl9kYXRhKSAgc3RhdGljIHZvaWQgaW5tc2dfdG8oc3RydWN0IGxfdGltZW91dA0K
PiA+ICptc2dfdGltZW91dCwgdm9pZCAqdXNlcl9kYXRhKSAgew0KPiA+ICAgICAgICAgc3RydWN0
IG1lc2hfbmV0ICpuZXQgPSB1c2VyX2RhdGE7DQo+ID4gLSAgICAgICBzdHJ1Y3QgbWVzaF9zYXIg
KnNhciA9IGxfcXVldWVfcmVtb3ZlX2lmKG5ldC0+c2FyX2luLA0KPiA+ICsgICAgICAgc3RydWN0
IG1lc2hfc2FyICpzYXIgPSBsX3F1ZXVlX2ZpbmQobmV0LT5zYXJfaW4sDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgbWF0Y2hfbXNnX3RpbWVvdXQsIG1zZ190aW1lb3V0KTsNCj4gPg0KPiA+
ICAgICAgICAgbF90aW1lb3V0X3JlbW92ZShtc2dfdGltZW91dCk7DQo+ID4gICAgICAgICBpZiAo
IXNhcikNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+DQo+ID4gKyAgICAgICBpZiAo
IXNhci0+ZGVsZXRlKSB7DQo+ID4gKyAgICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAg
ICAgICAqIEluY29tcGxldGUgdGltZXIgZXhwaXJlZCwgY2FuY2VsIFNBUiBhbmQgc3RhcnQNCj4g
PiArICAgICAgICAgICAgICAgICogZGVsZXRlIHRpbWVyDQo+ID4gKyAgICAgICAgICAgICAgICAq
Lw0KPiA+ICsgICAgICAgICAgICAgICBzYXItPmRlbGV0ZSA9IHRydWU7DQo+ID4gKyAgICAgICAg
ICAgICAgIGxfdGltZW91dF9yZW1vdmUoc2FyLT5zZWdfdGltZW91dCk7DQo+ID4gKyAgICAgICAg
ICAgICAgIHNhci0+c2VnX3RpbWVvdXQgPSBOVUxMOw0KPiA+ICsgICAgICAgICAgICAgICBzYXIt
Pm1zZ190aW1lb3V0ID0gbF90aW1lb3V0X2NyZWF0ZShTQVJfREVMLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbm1zZ190bywgbmV0LCBOVUxMKTsNCj4gPiAr
ICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAg
IGxfcXVldWVfcmVtb3ZlKG5ldC0+c2FyX2luLCBzYXIpOw0KPiA+ICAgICAgICAgc2FyLT5tc2df
dGltZW91dCA9IE5VTEw7DQo+ID4gICAgICAgICBtZXNoX3Nhcl9mcmVlKHNhcik7DQo+ID4gIH0N
Cj4gPiBAQCAtMTk1Niw3ICsxOTcyLDkgQEAgc3RhdGljIGJvb2wgc2VnX3J4ZWQoc3RydWN0IG1l
c2hfbmV0ICpuZXQsIGJvb2wNCj4gPiBmcm5kLCB1aW50MzJfdCBpdl9pbmRleCwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAvKiBSZS1TZW5kIEFDSyBmb3IgZnVsbCBtc2cgKi8NCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBzZW5kX25ldF9hY2sobmV0LCBzYXJfaW4sIGV4cGVjdGVk
KTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPiAtICAgICAg
ICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHNhcl9pbi0+ZGVsZXRl
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIC8qIElnbm9yZSBjYW5jZWxlZCAqLw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiAgICAgICAgIH0gZWxz
ZSB7DQo+ID4gICAgICAgICAgICAgICAgIHVpbnQxNl90IGxlbiA9IE1BWF9TRUdfVE9fTEVOKHNl
Z04pOw0KPiA+DQo+ID4gQEAgLTE5OTYsNiArMjAxNCw5IEBAIHN0YXRpYyBib29sIHNlZ19yeGVk
KHN0cnVjdCBtZXNoX25ldCAqbmV0LCBib29sDQo+ID4gZnJuZCwgdWludDMyX3QgaXZfaW5kZXgs
DQo+ID4gICAgICAgICAgICAgICAgIHNhcl9pbi0+bGVuID0gc2VnTiAqIE1BWF9TRUdfTEVOICsg
c2l6ZTsNCj4gPg0KPiA+ICAgICAgICAgaWYgKHNhcl9pbi0+ZmxhZ3MgPT0gZXhwZWN0ZWQpIHsN
Cj4gPiArICAgICAgICAgICAgICAgLyogUmVtb3ZlIG1lc3NhZ2UgaW5jb21wbGV0ZSB0aW1lciAq
Lw0KPiA+ICsgICAgICAgICAgICAgICBsX3RpbWVvdXRfcmVtb3ZlKHNhcl9pbi0+bXNnX3RpbWVv
dXQpOw0KPiA+ICsNCj4gPiAgICAgICAgICAgICAgICAgLyogR290IGl0IGFsbCAqLw0KPiA+ICAg
ICAgICAgICAgICAgICBzZW5kX25ldF9hY2sobmV0LCBzYXJfaW4sIGV4cGVjdGVkKTsNCj4gPg0K
PiA+IEBAIC0yMDA2LDYgKzIwMjcsMTEgQEAgc3RhdGljIGJvb2wgc2VnX3J4ZWQoc3RydWN0IG1l
c2hfbmV0ICpuZXQsIGJvb2wNCj4gPiBmcm5kLCB1aW50MzJfdCBpdl9pbmRleCwNCj4gPiAgICAg
ICAgICAgICAgICAgLyogS2lsbCBJbnRlci1TZWcgdGltZW91dCAqLw0KPiA+ICAgICAgICAgICAg
ICAgICBsX3RpbWVvdXRfcmVtb3ZlKHNhcl9pbi0+c2VnX3RpbWVvdXQpOw0KPiA+ICAgICAgICAg
ICAgICAgICBzYXJfaW4tPnNlZ190aW1lb3V0ID0gTlVMTDsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICAgIC8qIFN0YXJ0IGRlbGV0ZSB0aW1lciAqLw0KPiA+ICsgICAgICAgICAgICAgICBzYXJf
aW4tPmRlbGV0ZSA9IHRydWU7DQo+ID4gKyAgICAgICAgICAgICAgIHNhcl9pbi0+bXNnX3RpbWVv
dXQgPSBsX3RpbWVvdXRfY3JlYXRlKFNBUl9ERUwsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbm1zZ190bywgbmV0LCBOVUxMKTsNCj4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIHRydWU7DQo+ID4gICAgICAgICB9DQo+ID4NCj4NCj4NCg==
