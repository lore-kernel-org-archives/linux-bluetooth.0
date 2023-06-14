Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD749EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 17:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjFNRAj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 13:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFNRAh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 13:00:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11731FF7
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 10:00:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXuNeBYwOZJ3Nlw1O61YEKT2HdDTEMkZKXCfh7eUxtGmulFoTNm28fLigNqaA6uOznEOX/dxkyHpx3zPA0IdW0qqH+0wPDWZ5fybq/N/pzXwWsGXd8Z9s4AW5lyLtTXPUwV0Dxx5QGsNdYAFM51ooa6hmx04gZj5Fw9RNwAebp1vfXOj/qBVzfvm4kiPSCyUGC+heU29sxtm908agkV1ham5UtbWP0dUyBoE82Vu2WhDLTylVBTZQICQMhwJ/Lu4/bezd6UwnHYRYpG2icyOWIpmomTQfP16v4DjHJPiaKcLvJPqB7bnWWaSyO/Qw0v7BNlfEpsCQndOZSrhkZpSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CX7uPNxC27DrE++9bOxfe4fK66KpOWq6A3y2+wHNZP0=;
 b=fuj4+fRpEnZX0pLj5mVykRJTwGkCCGngbb+xIH/grCt4Lh27SCZntmiaQxrkJWKLkleghdx0IMvjanhiT90hafVynw4tj7IgUMW2S/n3ZhP5c2Uu4+la3MqlUc4LbDZ116j5jU9LWW1eR4ID3vUYNvYsUQpqiu2YsD9PS2ud4nEICSo3p2WWv9mNkVYW77JOZvvmjb5LaVlZU8f/098G/ovBoW/zZk8ONPp06nm/cZ7o7hJQg2WjtsPvcnQiIh0um+5bmDDYXG5f1OsIMLMbvRUDG5V2DHGCjfcQ3m2V77uS073IEJ1nfrL9681PO9f6z5ej7M7dA/2MUtBtft2apg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CX7uPNxC27DrE++9bOxfe4fK66KpOWq6A3y2+wHNZP0=;
 b=GmllSEgVrFAnev4pBg/XA7mK5ExBzMrqrd9Bk/wZXrv0BEARhBx4Pzs4l7/qo4lPzLJ7y5Hl++h4oYw3fOaAtj1+3FPQ80R3t9dEsc/S4s8aFLcjnlrz2mnPv4c67GSg0ZIibXARkGZwqxLgrKcDwanH5smujGpDpUDOVdTPDsNXSyBfbub46kaIG/8Nikn9PPn3Sk+e/Zah2xX5x2oEgrwJ5+TwNxsn786uRg36BSafa1e6bX0Ng/XWb01l/vpfusXJbfP4Fb0fvps6RqovCznkcagnnC8IWWugfr2vwgM7aEo26yDHvF9u8H59L6abkjv6nPqsaDiLzVw5vBPM1w==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by DS7PR10MB5053.namprd10.prod.outlook.com (2603:10b6:5:3a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 17:00:34 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 17:00:34 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez SEGV in current master
Thread-Topic: bluez SEGV in current master
Thread-Index: AQHZnrvlRF4IgSCGUkSDIZGoqFv8fa+KfFUAgAAB1ICAAAX6AIAAAdoA
Date:   Wed, 14 Jun 2023 17:00:34 +0000
Message-ID: <b1588e0579d4dfd9947d0d6938f10eb0e05e8558.camel@infinera.com>
References: <6704ebbea9d1bb64e54b45b1b3d6cd321b28971b.camel@infinera.com>
         <CABBYNZ+5ToeenijZkpRSrQ+wyLPjFSD5S7LWwCWXVoT=m-9Y3g@mail.gmail.com>
         <da4df669a540a395eec5a596a9594bea73be404d.camel@infinera.com>
         <CABBYNZKhf0Ve5P+N9zhAuUwU5O-e5JcifcxE-0=o+X_hRdPtyA@mail.gmail.com>
In-Reply-To: <CABBYNZKhf0Ve5P+N9zhAuUwU5O-e5JcifcxE-0=o+X_hRdPtyA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|DS7PR10MB5053:EE_
x-ms-office365-filtering-correlation-id: f1d6e706-139d-4145-47c9-08db6cf8dea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HDH5aEGqAlEfjllmYbzxdZOsjVm4rAVbc/sCTVUIJJfzeGeQsP1augN4DT3MdEYJ37JgfnRvYiPUcafePx/PlSpOg+5wA/S6wsUBAbsLpwQiQdcxraX23mOky9rRaQqXG/O9WPKmI2yIISGlZJS3xv1EvrXD2CdRAVhIw4ZYMYGft761dtx1i8U3Y/SJ7fS9BXLgkml/vtBvrp3sWqO5kESAGfNyEwIf9Upk1drksccX/88FVYc0o3hZM2tuR5pGQi3yCwDtCrqVvjSp5sI/j/RxGJvOuzP/eYbFxNnCkAdeoeVWX6JqQcVb4/cJHW5gIA1tnNwJsfYuscgxb+eDgWZMNJCl83xjCzS2UvCUTFJwh4I6uxUkqkyJhRo03+VErus8nOCfLgxvLktSoHyZdmwHzD7RqZhnNuP6DUKZQ0LPDLgwmAAGoztI/cghCJQirvFncejqGiI2yWjr+xHHmDNyeLJYsZewXzRJ20SAgw0cW2Fr2YddrKBeY3bNh0x96LNU+weZTn9o60JJHJLcTS65dQObzbhnR+uFBQlm5vtLI1d9LDE7lzqvqW5/5oMUyBD9O4Pvgu9Tcx3qPrHxTLaMHoSnf4/z9GU58Op5rQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(451199021)(8936002)(6486002)(8676002)(6512007)(41300700001)(38100700002)(478600001)(36756003)(45080400002)(71200400001)(66946007)(6916009)(66446008)(64756008)(4326008)(76116006)(66556008)(66476007)(86362001)(91956017)(316002)(122000001)(38070700005)(53546011)(6506007)(5660300002)(83380400001)(186003)(2616005)(966005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emtOdkFrSFZWcUZPVzVmT0F1T3cwQ0xjSVBOQjZXaGg2bUxLZjE2TDZyUHF5?=
 =?utf-8?B?Vm1XK1JKMnh4UDMrZForZnpqMW11dDVvT29iZnZlcW5SanN1azhZNFREVjlk?=
 =?utf-8?B?NUtneG51a29WWEdWYmVwT09BWWhlend5UUhzM3ZJKzhlQkUrejJJcldlcEw3?=
 =?utf-8?B?aHQ1SmNVVFZBdnEwUVkyQ2tGZmlkTDg3VVhxc1Vjb2hYaVNydkhHektpTHN0?=
 =?utf-8?B?Ykp5NDB2bFBBTTcybUZ6MkFvOHltZlc5RGl3UVNuUE8xOFJINUExeWY4bUJt?=
 =?utf-8?B?c3RELzYvck1vVmZUdi9TQlNWTkxHMTZmb2U2NXZpclZqT1owZVlnaDg3Mk9C?=
 =?utf-8?B?Y0I1d3UydnBpWVY5SGlRQ2Q5bGx0RXoxMkhSb1pZVTRySlIvZ0R2ZFdHM3J2?=
 =?utf-8?B?UUMxZ3FOS1hpaDhCaWlQK1k3UWhySi9qcnNHWk5jUDFiOCtrbnpvN1FZRG5l?=
 =?utf-8?B?QWE5YzNLRTBvRzI4dFB2Nm0yN3FCOEoyZStjTmtBWkx0dk5TS3ozSUVqY1JI?=
 =?utf-8?B?cTJMNmNUc29vQ1NTcTJNbnFHbWsxd0NOby9TSE5yOS9vbkJlQ1VlWVBQYnpm?=
 =?utf-8?B?WUZOc0dwQUgrT1gvRUJGbDQ1eGM4eVVSem80ZHVzbDVMbTNTSTlJRHdzSXo4?=
 =?utf-8?B?RU1NZytibW14WmE1eDdqYThDdFlyOXQ1ZWdUMElNOXlwSFNzK01ScEx6VnJo?=
 =?utf-8?B?bDI3V0JTenFkZ3hraS9uZUh6M2l1WVJrbEtBeHdHd0pMdnpacCthckYzb1ds?=
 =?utf-8?B?TkdGK1BITUVlR0NmekovakVCcUFkQlMrbk92cFkvYVoxemozY2F3OFRjSXJm?=
 =?utf-8?B?TXRIOWxLb3VSL3lBd0R3bSt1aVhWUkRUbmxwMEptZzNRYmRET3hPcHAzQjZG?=
 =?utf-8?B?dHlTdE9PKzltZ2NJRWRIQjRjcDhoL0lLR1drVnZFSDBqUDlzRVViK3o5MmVi?=
 =?utf-8?B?cmRHa2Y1MXFMSW9HM0hlUWZvUUhMUEU0ajFMbVZpYTRrbXMvZ25lU2NGdUU1?=
 =?utf-8?B?QjVsVDBuRmE3S2laZmtYYmVSbDlWNkxpV1B3UGtNOVdqclkvR2d5VGEzMEV6?=
 =?utf-8?B?ZFEreHMwc2g1NXZLa29lNDRHN1haUmp4cEc3b2VVM3ZDZHRxV3FGeExDU3RO?=
 =?utf-8?B?ZmF1WkNJajgydlhwdU1zdUl1b2FFUzFpMWxnZlFZT2NDaHFDR0hOR2FvQmpx?=
 =?utf-8?B?OFU1eGo2UjlmaU9oVHZlamRkcU1BQmYxcXBIWFpRQjNlVDZjWW1QQ1Y0cUJl?=
 =?utf-8?B?UzJlcDY4SVpHbDdaNUpqZ2t4dWFobHNJSnNxdWY1QTFqcFBqb3RUMjZMMzNs?=
 =?utf-8?B?MU12T0NCMFkyUERMWWd5QlE5S2JVZHlsZzBiM3RRdW9YMVlHYlF4NldCekdU?=
 =?utf-8?B?clVCVTlKQjNCMjFhT2UxN0pkZXNpbThIRllidFBuQlNob1BGOERBb291aCtE?=
 =?utf-8?B?ektEVnluZGN1RnpEL252dy83Y1VPOEFuMGkrdTQzdjZvOWNCczBnU1llUnZl?=
 =?utf-8?B?SUUxRHFDNVJDTGNPcUkzK1lYa2pxZXpKQkk1OXhYZHZjOFQ0anBzT2gxYWtO?=
 =?utf-8?B?cjZvRFd1dXdoVVY4S0hJd2hvT3lVQUZaYmVnck9jZXlqYzc3N0hEdlNTcWgr?=
 =?utf-8?B?SDRuRFFQR2FUaFVzdDFPa1RnTUFkZG5VT215cFJFVWJYeWx4MU1OVTBMeGc3?=
 =?utf-8?B?T3RrV3pGRlBpcTVKWUxqWUpuclVnOUgyZkh6N2thVmJwY2ZoWm4rNnRKMzdT?=
 =?utf-8?B?Mll4cEVPTXpMditidVlxSUlRMUVWSTUyY0N1Q2dNVXBRRkQrLzZVZUx1QjZH?=
 =?utf-8?B?Skdocm1jd2lReWlhZGROaDBscWRuY1NhWW8rQktnV0FVd2gzcmM4MS9pbWow?=
 =?utf-8?B?S2lFZVRURDk5SGhUVWJySzJKSDZmVFlLSk51aU1uYWQzRTBqV1dJZmVQa250?=
 =?utf-8?B?N0g0VzlrNElXTjFobk90Zi9LajkyVDJGZ04yUm93KzltZ3NrT2p1L1lwcnVh?=
 =?utf-8?B?S0I2RkVDRXI4a0hGdWpBY3lQVE1ybkh5ZUZyN0JEV2tra1liUUsxbWJBOVZO?=
 =?utf-8?B?bGVLQkE0Qy8yeUFRRG4reEptamd0ZFR2VkVPcEdoQjhxL05FbUNWSnFhczJK?=
 =?utf-8?B?Q3NyOXdiZEJocVUyOENQV2hyb3NWeDRXOVAxeVZvK3huVWh0Q0g1MGNUUmxh?=
 =?utf-8?Q?dGTdQpskFf1K9IxVI6gDTtAof6H4MCQn7VlDq2SO6xrA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <057FBABED1108D408910019A6BDD9431@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d6e706-139d-4145-47c9-08db6cf8dea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 17:00:34.5740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: depKKMMiLgPDgq1WcJ4KdwsCP5XsQk5zBXwVd+eVglYsY266I38XxMX4lLSQobtyqR4Kq0N43oFemtDfQTSN3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5053
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDA5OjUzIC0wNzAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOg0KPiBIaSBKb2FraW0sDQo+DQo+IE9uIFdlZCwgSnVuIDE0LCAyMDIzIGF0IDk6MzLi
gK9BTSBKb2FraW0gVGplcm5sdW5kDQo+IDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4g
d3JvdGU6DQo+ID4NCj4gPiBPbiBXZWQsIDIwMjMtMDYtMTQgYXQgMDk6MjUgLTA3MDAsIEx1aXog
QXVndXN0byB2b24gRGVudHogd3JvdGU6DQo+ID4gPiBIaSBKb2FraW0sDQo+ID4gPg0KPiA+ID4g
T24gV2VkLCBKdW4gMTQsIDIwMjMgYXQgNTozNuKAr0FNIEpvYWtpbSBUamVybmx1bmQNCj4gPiA+
IDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+
IGNvbW1pdCBiYXA6IEFkZCBicm9hZGNhc3Qgc291cmNlIHN1cHBvcnQsIDMwMzA4ODMsIGluIGJs
dWV6LmdpdA0KPiA+ID4gPg0KPiA+ID4gPiBBIGNvLXdvcmtlciBzZWUgdGhpcyBTRUdWIHdoZW4g
Y29ubmVjdGluZyBhIGhlYWRzZXQ6DQo+ID4gPiA+DQo+ID4gPiA+IEp1biAxMyAxMzozODoxNSBz
eXN0ZW1kLWNvcmVkdW1wWzM5NDFdOiBQcm9jZXNzIDE4OTcgKGJsdWV0b290aGQpIG9mIHVzZXIg
MCBkdW1wZWQgY29yZS4NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1vZHVsZSBibHVldG9vdGhkIHdpdGhvdXQgYnVpbGQtaWQuDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMCAgMHgwMDAwNTU2YmVhOTMyNzdh
IGEyZHBfcmVzdW1lX2NvbXBsZXRlIChibHVldG9vdGhkICsgMHgzZTc3YSkNCj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMxICAweDAwMDA1NTZiZWE5MjEw
YTIgZmluYWxpemVfcmVzdW1lIChibHVldG9vdGhkICsgMHgyZDBhMikNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMyICAweDAwMDA1NTZiZWE5MmFmYWYg
YXZkdHBfc3RhcnRfcmVzcCAoYmx1ZXRvb3RoZCArIDB4MzZmYWYpDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjNiAgMHgwMDAwNTU2YmVhOWRjYzg1IG1h
aW5sb29wX3J1biAoYmx1ZXRvb3RoZCArIDB4ZThjODUpDQo+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAjNyAgMHgwMDAwNTU2YmVhOWRkMGRjIG1haW5sb29w
X3J1bl93aXRoX3NpZ25hbCAoYmx1ZXRvb3RoZCArIDB4ZTkwZGMpDQo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjOCAgMHgwMDAwNTU2YmVhOTFhNGVmIG1h
aW4gKGJsdWV0b290aGQgKyAweDI2NGVmKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIzExIDB4MDAwMDU1NmJlYTkxYWNlMSBfc3RhcnQgKGJsdWV0b290
aGQgKyAweDI2Y2UxKQ0KPiA+ID4gPiBKdW4gMTMgMTM6Mzg6MTUgc3lzdGVtZFsxXTogYmx1ZXRv
b3RoLnNlcnZpY2U6IE1haW4gcHJvY2VzcyBleGl0ZWQsIGNvZGU9ZHVtcGVkLCBzdGF0dXM9MTEv
U0VHVg0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiBDcmFzaCBzZWVtcyB0byBiZSBhdDoNCj4g
PiA+ID4NCj4gPiA+ID4gMzQyICAgICBzdGF0aWMgdm9pZCBhMmRwX3Jlc3VtZV9jb21wbGV0ZShz
dHJ1Y3QgYXZkdHAgKnNlc3Npb24sIGludCBlcnIsDQo+ID4gPiA+IDM0MyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICp1c2Vy
X2RhdGEpDQo+ID4gPiA+IDM0NCAgICAgew0KPiA+ID4gPiAzNDUgICAgICAgICAgICAgc3RydWN0
IG1lZGlhX293bmVyICpvd25lciA9IHVzZXJfZGF0YTsNCj4gPiA+ID4gMzQ2ICAgICAgICAgICAg
IHN0cnVjdCBtZWRpYV9yZXF1ZXN0ICpyZXEgPSBvd25lci0+cGVuZGluZzsNCj4gPiA+ID4gMzQ3
ICAgICAgICAgICAgIHN0cnVjdCBtZWRpYV90cmFuc3BvcnQgKnRyYW5zcG9ydCA9IG93bmVyLT50
cmFuc3BvcnQ7DQo+ID4gPiA+IDM0OCAgICAgICAgICAgICBzdHJ1Y3QgYTJkcF9zZXAgKnNlcCA9
IG1lZGlhX2VuZHBvaW50X2dldF9zZXAodHJhbnNwb3J0LT5lbmRwb2ludCk7DQo+ID4gPiA+DQo+
ID4gPiA+IEEgZ29vZCBzdGFydChidXQgZG9lcyBOT1QgZml4IHRoZSBwcm9ibGVtKSBtaWdodCBi
ZToNCj4gPiA+ID4NCj4gPiA+ID4gLS0tIGJsdWV6LTk5OTkvcHJvZmlsZXMvYXVkaW8vdHJhbnNw
b3J0LmMub3JnICAgMjAyMy0wNi0xMyAxODozODoxNC41NDIxMzc1MzEgKzAyMDANCj4gPiA+ID4g
KysrIGJsdWV6LTk5OTkvcHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmMgICAgICAgMjAyMy0wNi0x
MyAxODo0ODozMi41NDI1Mjc4ODIgKzAyMDANCj4gPiA+ID4gQEAgLTM0NSw3ICszNDUsNyBAQA0K
PiA+ID4gPiAgICAgICAgIHN0cnVjdCBtZWRpYV9vd25lciAqb3duZXIgPSB1c2VyX2RhdGE7DQo+
ID4gPiA+ICAgICAgICAgc3RydWN0IG1lZGlhX3JlcXVlc3QgKnJlcSA9IG93bmVyLT5wZW5kaW5n
Ow0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCBtZWRpYV90cmFuc3BvcnQgKnRyYW5zcG9ydCA9IG93
bmVyLT50cmFuc3BvcnQ7DQo+ID4gPiA+IC0gICAgICAgc3RydWN0IGEyZHBfc2VwICpzZXAgPSBt
ZWRpYV9lbmRwb2ludF9nZXRfc2VwKHRyYW5zcG9ydC0+ZW5kcG9pbnQpOw0KPiA+ID4gPiArICAg
ICAgIHN0cnVjdCBhMmRwX3NlcCAqc2VwOw0KPiA+ID4gPiAgICAgICAgIHN0cnVjdCBhdmR0cF9z
dHJlYW0gKnN0cmVhbTsNCj4gPiA+ID4gICAgICAgICBpbnQgZmQ7DQo+ID4gPiA+ICAgICAgICAg
dWludDE2X3QgaW10dSwgb210dTsNCj4gPiA+ID4gQEAgLTM1NSw3ICszNTUsMTAgQEANCj4gPiA+
ID4NCj4gPiA+ID4gICAgICAgICBpZiAoZXJyKQ0KPiA+ID4gPiAgICAgICAgICAgICAgICAgZ290
byBmYWlsOw0KPiA+ID4gPiArICAgICAgIGlmICghdHJhbnNwb3J0KQ0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgZ290byBmYWlsOw0KPiA+ID4gPg0KPiA+ID4gPiArICAgICAgIHNlcCA9IG1lZGlh
X2VuZHBvaW50X2dldF9zZXAodHJhbnNwb3J0LT5lbmRwb2ludCk7DQo+ID4gPiA+ICAgICAgICAg
c3RyZWFtID0gYTJkcF9zZXBfZ2V0X3N0cmVhbShzZXApOw0KPiA+ID4gPiAgICAgICAgIGlmIChz
dHJlYW0gPT0gTlVMTCkNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGdvdG8gZmFpbDsNCj4gPiA+
ID4NCj4gPiA+ID4gYmx1ZXotNS42NiBXb3JrcyBmaW5lIHRob3VnaC4NCj4gPiA+ID4NCj4gPiA+
ID4gSGVhZHNldDogV0gtMTAwMFhNMw0KPiA+ID4gPg0KPiA+ID4gPiAgIEpvY2tlDQo+ID4gPg0K
PiA+ID4gV2VpcmQsIEkgZG9uJ3QgdGhpbmsgbXVjaCBoYXMgY2hhbmdlZCBmb3IgQTJEUCwgYnV0
IHBlcmhhcHMgdGhlcmUgaXMNCj4gPiA+IHNvbWUgQkFQIHJlbGF0ZWQgY2hhbmdlcyBhZmZlY3Rp
bmcgQTJEUCBmb3Igc29tZSByZWFzb24sIGFueSBjaGFuY2UgdG8NCj4gPiA+IGJpc2VjdCB0aGUg
cGF0Y2ggdGhhdCBpbnRyb2R1Y2VzIHRoaXMgcHJvYmxlbT8gT3IgaXQgaXMgbm90IGFsd2F5cw0K
PiA+ID4gcmVwcm9kdWNpYmxlPw0KPiA+DQo+ID4gSXQgaXMgcmVwcm9kdWNpYmxlIGJ1dCBvbiBh
biByZW1vdGUgbGFwdG9wIHVzZWQgZm9yIGRhaWx5IHdvcmsgc28gd291bGQgZGlzdHVyYiBxdWl0
ZSBhIGxvdC4NCj4gPiBDYW4gSSB0dXJuIG9mZiBCQVAgc29tZWhvdyB0byBzZWUgaWYgaXQgaXMg
aW50ZXJmZXJpbmcgPw0KPiA+DQo+ID4gQW55IGNoYW5jZSBpdCBpcyByZWxhdGVkIHRvIGh0dHBz
Oi8vZ2l0aHViLmNvbS9ibHVlei9ibHVlei9pc3N1ZXMvNTMzID8NCj4NCj4gUmlnaHQsIHllYWgg
dGhhdCBpcyBwb3NzaWJsZSBzaW5jZSBpdCBhcHBlYXJzIHRvIGJlIHNvbWUgdW5iYWxhbmNlZA0K
PiByZWZlcmVuY2UgY291bnQgaXNzdWUsIHRoYXQgc2FpZCB0aGF0IHdhcyBhIHZlcnkgb2xkIHZl
cnNpb24sIG5vdCBzdXJlDQo+IGlmIHdlIGhhdmVuJ3QgZml4ZWQgdGhhdC4NCg0KSXQgaXMgbm90
IGZpeGVkIGluIHVucmVmIGNvZGUgZGlzY3Vzc2VkIGluIHRoYXQgaXNzdWUgb24gbWFzdGVyDQoN
CiAgICBKb2NrZQ0K
