Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7A5EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 12:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244417AbjFNMbc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjFNMba (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 08:31:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313CB26AC
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 05:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxr5Q85Z/+gmyWQKw4SzctGt5ENeJrAD/AGstxQOnQBWid7/EY2z0hrqTDLCVDvI9RO/2zkfmre89dOQmChT27abheKrbDOhMIQlf5DzntxLoCH9g8ZSZIEGWFQJ/hsnj85kc+PWsiwwiDYnxriigKv7U9Sy4CWMW9uOEtxn67z4b+dc5aqMVRTr4YqwxabgZINxArzmr3WGN89oXWvyGKrbCFxGz71SQNSuWFG9weF/aoc24jVUZyQmI/jfftRVhXe+SyPUClVlds3Bo+ySKwkT0s2t4YWrXihyOxJc3HK53wopWb5dMrzbTwn/sOpS3FNZ0Mb3EtT2K3XmqCUc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbojeEM/28BeTeMcdx32bjkeLg/PCL2BII8ZV7iFbS8=;
 b=nxbelPVDXS4Mumhi91IHrgTU7RjECJIEkUYgRq+zIIoVkdftEnvcH4+LdbeVfSUAXUPioTMsEdLuxaRdX+DhC3qpufpzxw6uAkKESMAFKEpBFEeuAXAau2rc414skae1QOJdvg53FdkiUrlsfnlMzfelAJAYyrevrNI4FUsdkyQ/rS3Xa4I+zud+zPQRxpJS1XVtXyN8F+NvpIUtFpqUQpGe6InvBbn5PtfbM3FxjZFZccjXSHX37WRVGOpoZ2cismNEvhxYaiyAkUoRIBrVJMwRidHxJMcT32C1OQylsS5/Zkr/cEMtKo1A2vtczBmQtmsl9mFJrXTldV/JJwfnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbojeEM/28BeTeMcdx32bjkeLg/PCL2BII8ZV7iFbS8=;
 b=X4nz1DoKM68uXv6wvHqQj5DWyCkyH1JM2o0fFZ8RiqIS+KSyGfmOWD63Y4gCjY0DK8Pn5BhCrube/iSyXTF05Z0h16/ZG30KkHyiL8A1N6qFA2Vt9R6m1vfxpT3cFl1T2QXBsl98xBsJZKnftsyUkVZSp2OgC3SRUD8FAlUPPywEXbX3xsdFbZdNXE/QFatkZ3s2tFDn1g3XB/QzXH1gypq8brx8ULWilWkUj2bi9WuAvcgVNa0lG91+oPCO0E3XB3HeEflKUnpNFChFmy8IQR8XxBPG7kE7hzdx59uTPPITlvAzVn09biP2pfOU4S68rYWDw9jsYPpZW+yWpQLc+w==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by DS7PR10MB5215.namprd10.prod.outlook.com (2603:10b6:5:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 12:29:44 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 12:29:43 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: bluez SEGV in current master
Thread-Topic: bluez SEGV in current master
Thread-Index: AQHZnrvlRF4IgSCGUkSDIZGoqFv8fQ==
Date:   Wed, 14 Jun 2023 12:29:43 +0000
Message-ID: <6704ebbea9d1bb64e54b45b1b3d6cd321b28971b.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|DS7PR10MB5215:EE_
x-ms-office365-filtering-correlation-id: 3d7e3a20-dbf7-414a-855f-08db6cd30814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D5xWzdAk4WTv1kk7MBD+eW7+izVBIH58oDnEAqUm0A9I+FctXHfHGfOw9RenmJp/fxEIs8ocfN895aG7QT+Dp8jJR67YQCzUsmkIsaDhm9cT/7yXBFRNBvyZ7yKtpG6JuwVfLh47LX2XBSPP+3StBpuHDh7rVImaH4SembTefvisCkdn7Crxw7gMa+lA5EI3hfQ/712G1UGjyWIxaOMRD2AuxtDodxZdvgW4A27Ou9mzCgFgpQjXGmlmto+mHcAiHsBgf95h2JYFPEUP520OipcwaO5h1siHHQ0KSd2UU19QaJOgZdjHjZcSwhj+46xncnsWg4q3u7YJhTXLzxn43R936gdu88cbafGRFXg0t4jB0kv8MvUwl1Dgz5Rk3Ph7wbX3h/3V7yhNSyO9UxyEDwoo+WYppxzbZcrG8AoxUgnSm/Y4OkuJNGleLDitHiGM1uArx7iwfAVN+cj+imU7GF00xoTFoDGJqmqEKiJByCXC2cfCHCbL9jr7zHEbmKNjCSDzadDAmxAER3hZ25gi5ns9w+ZE5NTCEFhrkDza/cTRmCv2pe1gaAlmVyueGESpO7S7GL6T9W3CW2HqzzWxiHxXHeF6C1u+gAMMjymuhud4J/upfZTGXmFFcMyrIXnW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(451199021)(83380400001)(5660300002)(186003)(6506007)(2906002)(2616005)(41300700001)(6512007)(8936002)(8676002)(6486002)(316002)(38070700005)(122000001)(36756003)(478600001)(38100700002)(86362001)(76116006)(66476007)(66556008)(64756008)(66946007)(6916009)(66446008)(91956017)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VDdHcGdKS2hycnc0bHQrUXd2YkxrSTdlTTI3QmpybE5ob1o1eXEzRVBPS1c0?=
 =?utf-8?B?QzI1c1RtOVZEMG5vbm1NMjZ3VE9HdTE0S2Q5ZkRZdmprOTNNTTZSL0hXOUNZ?=
 =?utf-8?B?akxpaDJUZUZQZzlwdXdHNUlzUDFLR0VxQUxwMVVsY3M5d2pHNk9tcDh6TlFk?=
 =?utf-8?B?d281Z2E0NkJZaTdpOVVtT2NBbXdHQnNoK1VyRkdYNlRLRERaWEdEYkJxaXNa?=
 =?utf-8?B?cjhab3BNS1pQd3NZTXVRYmEvVEdwYnVjVVJuOWpTNlZDdGNYZ3Z0a0lVendP?=
 =?utf-8?B?cnFFNW1oVWZhTHlEV1BsemVKWVdYTmtwOE5UaXZwQkVtTm1KUVJzSFlTczNW?=
 =?utf-8?B?cjVBQmE0Z3MxeDBtUHFTNHRaL3lQVktnQW8vdjc2bldKMmNHcnZnYXBwbUVB?=
 =?utf-8?B?VmpycXI3VVR1Ukd0cWQvTEZaak1UNGVuOCtnYWIyVTI0dHJZNmNneWxCcTZP?=
 =?utf-8?B?d1JKZUhtcnI5WDd2TXAvYWpLd0dPQUlFT0VpaytRbnp4bjNBQVlIam1uRThE?=
 =?utf-8?B?TC9QQllRVUt4Ty9NZnFnSHpFUFRSMTJxaTVlTjgwcXRDRDJvR2tOYm12cDVo?=
 =?utf-8?B?bk4vNmU5ZmVvNURzQm9XU3hLb1ozNytNS1k3aE9qNzE1K2lXNWFBdWtSYWIz?=
 =?utf-8?B?dm5CbTdpSXlJUlE0akNrSldqdW9vVkluWWVDMFZPWkxSZHZrMk9yYVF6dzdE?=
 =?utf-8?B?b292YWdKeE8yQUpXaVp5OW1VNVE4RStKb211clVNc0VOU2I0SVRBdXQzQ1N1?=
 =?utf-8?B?bXNJNDBZSkNKQ0U2b0NweXdSRlJPNWVudUNDczBqeG93bENzR2lQL1ExUlhj?=
 =?utf-8?B?SGkvSkQ1SGl2NlpSeXlkT0JWakN0VVVBTk5SVnNLZGRVZDc3T0tXTkRWa01T?=
 =?utf-8?B?ZFN3dVR6TTIrU0RwdDFUR0tRNXJESUoxZEZaekIzN1h1czJkdjJqbUExNi9w?=
 =?utf-8?B?a0toRmM0eUFoR1RPZW5RRzA5YTZUSTl1K002aWdsYWRDZkZGRTFpeGpNQU1v?=
 =?utf-8?B?OU04Zmg2cFRMZ1NjcjhqMHFycm9xNnRNdHlPV1RId21DY3FLQ0llOEswV2lE?=
 =?utf-8?B?a3ZnZ0luRUc2eU1SR2xjVzN4ZGt0VHFOamdXT3FrazJkVjN1Q2h4eHA0ZUtE?=
 =?utf-8?B?L2xzR1VyNXNsV3EvN3VocUdhRmxDUk9ZK0dxZnRlR1JTd3FCTFN6NGVuTW05?=
 =?utf-8?B?dHdpczF6ZENyTFlEZTZqUXk0N3RMd1RGdWdPVHppSXBwYzVJWGhxY3FyS01x?=
 =?utf-8?B?dC9LeDg2VzZVU1l6MzNBem80Unc0OE5YTEx5NkpReXYrSVpyakhqZ2pEZHRL?=
 =?utf-8?B?WUJoNEZuSTFjL1hPYXU0bzJqV3YyRXQ3ZTVHRTdEZ2xFZ0lkOHQrc2hYanhO?=
 =?utf-8?B?VjFMK3NXenhYOE5wWTY3c2ZBUEdraS9CSXE1TEt0TlhsZXFSS2lhMEVCTG02?=
 =?utf-8?B?ZS9zdGNDSFlDejlvNms4SmdoVWxVWmtwSjJ5TkgxbWF3bzZSaXFWazRuTGc2?=
 =?utf-8?B?Y0pjM3gzVTB2U2hNUG5Mb2ROVlZ0M3J3VGttWHFBTGJSL25NTElUUytuWERC?=
 =?utf-8?B?QkQ0Z2FTbUJpRUxCVzJpVjNWQUIzcm5vN2ZSRnJjdTdBV3NnTDJMMWZJUVdm?=
 =?utf-8?B?Yi9PKzVBc3grQm5WWXVWWTBRZmxHRG9maWx0VnBRSnFvdnJlekhBNVZIN0Zz?=
 =?utf-8?B?TXhtM29WVmQ4MFpadkZvYmtaaFR2VnQ5ZHE0eVpqSmlrTUoxdkF2NWJpRmdi?=
 =?utf-8?B?YWZiQmRPUVJXQVc0YzFHMGFmZGR2M3NvWDB5VUtSZWVqN3JSaTB2ZmZTRTJD?=
 =?utf-8?B?ck1rYllaQUowTkFMbUpFODg1WGFuaUVHS3pXVmVVSlgxWVhMZEE2bTdncHRU?=
 =?utf-8?B?MmdpK3M1RnRBSWE1UVNMQnIwR2d0djFKdXhDRFFEUHZVOGFrd09FY0dETjAz?=
 =?utf-8?B?bE9RRW0vSUFOc1NKS3haMFF6K2hUTmhSbEE5YUw0RHJFdVEzZnhwSEdzK1NI?=
 =?utf-8?B?SHlwUXZVNHAzT1BHaDhTRlpxRnVUb3Q2WFFIWmNlOGJhaTZQcDFtbFZYN2Ru?=
 =?utf-8?B?NytkcGlaVUpPMjBRa0t1ZGZtb1hBSkdCV01RUzdzZHFKZTRSd0lubW91OTVP?=
 =?utf-8?B?R2FLQldzNjVOTFZ6M0VIZDR4MU5WQkZobU5jZWZtVENLbnQzSHg0elovelBO?=
 =?utf-8?Q?6cFxt96zgyyiw7MT/LrRuQVNRWDvHwvQT1bDJNa+XXuQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6395BFF37A1CB94EAE3C64D9824E1B48@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7e3a20-dbf7-414a-855f-08db6cd30814
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 12:29:43.1912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FLFH4TYBxyZE+50mvcxgC/ANpN8VtmAxkcqnekU7GBuPH+c1qVt+VwQ17CS2KqGEb3jOP+SQlnp04YU+MXqjbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5215
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Y29tbWl0IGJhcDogQWRkIGJyb2FkY2FzdCBzb3VyY2Ugc3VwcG9ydCwgMzAzMDg4MywgaW4gYmx1
ZXouZ2l0DQoNCkEgY28td29ya2VyIHNlZSB0aGlzIFNFR1Ygd2hlbiBjb25uZWN0aW5nIGEgaGVh
ZHNldDoNCg0KSnVuIDEzIDEzOjM4OjE1IHN5c3RlbWQtY29yZWR1bXBbMzk0MV06IFByb2Nlc3Mg
MTg5NyAoYmx1ZXRvb3RoZCkgb2YgdXNlciAwIGR1bXBlZCBjb3JlLg0KICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE1vZHVsZSBibHVldG9vdGhkIHdpdGhvdXQgYnVpbGQt
aWQuDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzAgIDB4MDAwMDU1
NmJlYTkzMjc3YSBhMmRwX3Jlc3VtZV9jb21wbGV0ZSAoYmx1ZXRvb3RoZCArIDB4M2U3N2EpDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIzEgIDB4MDAwMDU1NmJlYTky
MTBhMiBmaW5hbGl6ZV9yZXN1bWUgKGJsdWV0b290aGQgKyAweDJkMGEyKQ0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyICAweDAwMDA1NTZiZWE5MmFmYWYgYXZkdHBf
c3RhcnRfcmVzcCAoYmx1ZXRvb3RoZCArIDB4MzZmYWYpDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIzYgIDB4MDAwMDU1NmJlYTlkY2M4NSBtYWlubG9vcF9ydW4gKGJs
dWV0b290aGQgKyAweGU4Yzg1KQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICM3ICAweDAwMDA1NTZiZWE5ZGQwZGMgbWFpbmxvb3BfcnVuX3dpdGhfc2lnbmFsIChibHVl
dG9vdGhkICsgMHhlOTBkYykNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAjOCAgMHgwMDAwNTU2YmVhOTFhNGVmIG1haW4gKGJsdWV0b290aGQgKyAweDI2NGVmKQ0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMxMSAweDAwMDA1NTZiZWE5MWFj
ZTEgX3N0YXJ0IChibHVldG9vdGhkICsgMHgyNmNlMSkNCkp1biAxMyAxMzozODoxNSBzeXN0ZW1k
WzFdOiBibHVldG9vdGguc2VydmljZTogTWFpbiBwcm9jZXNzIGV4aXRlZCwgY29kZT1kdW1wZWQs
IHN0YXR1cz0xMS9TRUdWDQoNCg0KQ3Jhc2ggc2VlbXMgdG8gYmUgYXQ6DQoNCjM0MglzdGF0aWMg
dm9pZCBhMmRwX3Jlc3VtZV9jb21wbGV0ZShzdHJ1Y3QgYXZkdHAgKnNlc3Npb24sIGludCBlcnIs
DQozNDMJCQkJCQkJCXZvaWQgKnVzZXJfZGF0YSkNCjM0NAl7DQozNDUJCXN0cnVjdCBtZWRpYV9v
d25lciAqb3duZXIgPSB1c2VyX2RhdGE7DQozNDYJCXN0cnVjdCBtZWRpYV9yZXF1ZXN0ICpyZXEg
PSBvd25lci0+cGVuZGluZzsNCjM0NwkJc3RydWN0IG1lZGlhX3RyYW5zcG9ydCAqdHJhbnNwb3J0
ID0gb3duZXItPnRyYW5zcG9ydDsNCjM0OAkJc3RydWN0IGEyZHBfc2VwICpzZXAgPSBtZWRpYV9l
bmRwb2ludF9nZXRfc2VwKHRyYW5zcG9ydC0+ZW5kcG9pbnQpOw0KDQpBIGdvb2Qgc3RhcnQoYnV0
IGRvZXMgTk9UIGZpeCB0aGUgcHJvYmxlbSkgbWlnaHQgYmU6DQoNCi0tLSBibHVlei05OTk5L3By
b2ZpbGVzL2F1ZGlvL3RyYW5zcG9ydC5jLm9yZwkyMDIzLTA2LTEzIDE4OjM4OjE0LjU0MjEzNzUz
MSArMDIwMA0KKysrIGJsdWV6LTk5OTkvcHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmMJMjAyMy0w
Ni0xMyAxODo0ODozMi41NDI1Mjc4ODIgKzAyMDANCkBAIC0zNDUsNyArMzQ1LDcgQEANCiAJc3Ry
dWN0IG1lZGlhX293bmVyICpvd25lciA9IHVzZXJfZGF0YTsNCiAJc3RydWN0IG1lZGlhX3JlcXVl
c3QgKnJlcSA9IG93bmVyLT5wZW5kaW5nOw0KIAlzdHJ1Y3QgbWVkaWFfdHJhbnNwb3J0ICp0cmFu
c3BvcnQgPSBvd25lci0+dHJhbnNwb3J0Ow0KLQlzdHJ1Y3QgYTJkcF9zZXAgKnNlcCA9IG1lZGlh
X2VuZHBvaW50X2dldF9zZXAodHJhbnNwb3J0LT5lbmRwb2ludCk7DQorCXN0cnVjdCBhMmRwX3Nl
cCAqc2VwOw0KIAlzdHJ1Y3QgYXZkdHBfc3RyZWFtICpzdHJlYW07DQogCWludCBmZDsNCiAJdWlu
dDE2X3QgaW10dSwgb210dTsNCkBAIC0zNTUsNyArMzU1LDEwIEBADQogDQogCWlmIChlcnIpDQog
CQlnb3RvIGZhaWw7DQorCWlmICghdHJhbnNwb3J0KQ0KKwkJZ290byBmYWlsOw0KIA0KKwlzZXAg
PSBtZWRpYV9lbmRwb2ludF9nZXRfc2VwKHRyYW5zcG9ydC0+ZW5kcG9pbnQpOw0KIAlzdHJlYW0g
PSBhMmRwX3NlcF9nZXRfc3RyZWFtKHNlcCk7DQogCWlmIChzdHJlYW0gPT0gTlVMTCkNCiAJCWdv
dG8gZmFpbDsNCg0KYmx1ZXotNS42NiBXb3JrcyBmaW5lIHRob3VnaC4NCg0KSGVhZHNldDogV0gt
MTAwMFhNMw0KDQogIEpvY2tlDQoNCg==
