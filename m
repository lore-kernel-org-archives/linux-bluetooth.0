Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F643EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Jun 2023 16:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjFNQc5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Jun 2023 12:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbjFNQct (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Jun 2023 12:32:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61132718
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Jun 2023 09:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcatCU1tR03p5WWwa/FECiOWUAD+Cgt115ImRkZM+QLgDKasBXgWSYhdj1wQVgn9ekSIPjqxtirupfcDihj54SagygbZnmmkJ1wpQnxqVPO6GPExxP1P/tHG8jaM+fc0yrkkKeRIZgoFnfL2VmI7nRA2Zox2JVvKVH2WqcvHlsoKTKTWaXHwPgioT8UrPX5zRitr8O/+LD+DuPPT7p7LAceY3xhhdaaKygZezk9WOHDMMFyLD5AZtw6fWjzQpnvzTBv8T4jTEDwWFGou6A5eE8/HPRjjxooKVKtdl/THX3nkHg0PLCY8rbTybeA2z1IC2BbyTKr20SlyzPdbSnTvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPwnlAb3VjZIwyxl1C4p4KqCZXqFX5hH2Y0q6n+BJQY=;
 b=Y4arTjPmmj18Sb4ADPndJpndbCs92GMzS2AAEJr2yoFClGSpm0Pp7IIQGO4XdUhVZZpabeZKPbe96bhfafK77v3kghDHsCEZwcJwnZSIRTTNvEGZD3S+2flc4yvMdTdJ9F5nIat6IvkoiO/37kLeobJqay6rOcWi83il+pmOrguI1KG60tDgfze07nAGZ51EJQ0v30BBq/Gb0qEo3/aPCruv750r2Beo7rLvDdtQsgRZb6kiujUBDjFZYH38DT9QDZd00Qno9iga+PZASPe6XWYzoT0ADAT6WkdlkPJQMDWtiy/1t03LmgbzWRkqqgs5E2Gqo1A3vGYImW/nfIq0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPwnlAb3VjZIwyxl1C4p4KqCZXqFX5hH2Y0q6n+BJQY=;
 b=qCSnLlK9Q9/RX2QSQcZ9hPyM8VPO9s1NJ6v1wj0Hhlif9eUVrnn/tUwVZIY9+YM4QmpS9DreRv6tSWEDvQ3G74fYfDd2Z+lWPgZoGcvPl9+fXeGrmqeu/9pTLcSGaxAl7EYB8z2kfexU6oysS3SvCKjtRRdkYGstTs9G8v1Ni09TJbewCVdVUCUIZyNppB8ZE+ToTS7Z9rfMUaXdpN69wkHb5XxXbYkkUqbWqtt710On/hIPxiPPEWfnsXdwDQ+1wKTumuGFQ+U445LeohnD0prBIGtEncNQIvDm+jLUjbhObLXvjWg7FZA7JTI79noF8Jg1hfhbR2SnUTGHLZRSsw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by CH3PR10MB7646.namprd10.prod.outlook.com (2603:10b6:610:179::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Wed, 14 Jun
 2023 16:32:32 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 16:32:32 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez SEGV in current master
Thread-Topic: bluez SEGV in current master
Thread-Index: AQHZnrvlRF4IgSCGUkSDIZGoqFv8fa+KfFUAgAAB1IA=
Date:   Wed, 14 Jun 2023 16:32:31 +0000
Message-ID: <da4df669a540a395eec5a596a9594bea73be404d.camel@infinera.com>
References: <6704ebbea9d1bb64e54b45b1b3d6cd321b28971b.camel@infinera.com>
         <CABBYNZ+5ToeenijZkpRSrQ+wyLPjFSD5S7LWwCWXVoT=m-9Y3g@mail.gmail.com>
In-Reply-To: <CABBYNZ+5ToeenijZkpRSrQ+wyLPjFSD5S7LWwCWXVoT=m-9Y3g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|CH3PR10MB7646:EE_
x-ms-office365-filtering-correlation-id: 2ca2e061-750c-413a-141d-08db6cf4f3c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YyD/dFBBk+Z+IuE9eABKgk+lul5wq4LpH3RGwSP54hfbTawPs5GROS6BF4F6r8IvYl6lO0lwiJriQXmBDVHj0pXCnnLsyIpMDZJTShV108YoDc0dnyaMDaXtB1pZct2XIFy7HpAGmJQWdgqD0WKoDe7DvAZ7AhvP85HS/65N+tYlmIwOgNFD3f6TVLkxviUyf3MzIngwK/oMBrCo32xg40kECpn9Xd7SR6GjCmQE6/JAGu2jjvf8Juh78jLOZW+2oTHKybIkrnINDcRf+iX/rnbYX9Z9DcMeeIOLa3kH6TSiXHS9ins6RRL6f3u+a6e0hj9tvD56K1jP/eztmamIQURvAnAeDjkTxFxMC88VKu2bXy9G08rCFc4mWQYPSJSjJqF1Qt3GS3YQnYT/tYQeNwPPQiKcDpQV5877Xk5wgHVxKNpWQ9V7KZqBqI+8NeKRw5Z4EHGvAPHBD9ZQUOtxsEBsN9Z8x8Y+IdVL3/3D++eGYcg4Wh0egjcinx1UDwR7+8VkqFJDHFMolDMovA9eBttUkR3HjXzUYA+CXlqO24ToIwkBvezmCBR5T27Bivt4pnJ6ecNgtJ6DOLmU8tvUTxkQ/MNnQ7Kxag2o48b+Ce8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199021)(36756003)(86362001)(38070700005)(66476007)(64756008)(66556008)(66446008)(6916009)(4326008)(478600001)(966005)(66946007)(316002)(91956017)(76116006)(71200400001)(6486002)(8936002)(41300700001)(2906002)(8676002)(5660300002)(38100700002)(122000001)(2616005)(53546011)(6506007)(6512007)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHIzaHNidmh3OU5oa0EwZ2Z3ZHEzY3ltTVc0d3N3TW5PSUtMMTdpWkY0TEFi?=
 =?utf-8?B?NVdHYmlDZGl2bGdacUtQbEprZjhNT2gvMmJWSTUzMnVyQWJmNzJrdHpNcDJL?=
 =?utf-8?B?cEQ4V2dWamFsNWl5aGxMZGxRSnFaN2xHUnl3dTJ4emZac1RsdmJvczFBOEVx?=
 =?utf-8?B?TXpqNjNxL3ZvSERRR0FyTWpZYnpMdDJVWjZIR0N0Q0pmQTRaaFExSzlsVFFP?=
 =?utf-8?B?TjVDc1ZlUWlWa2ZEZVZvWjNJOUdwVUpKUHhnWEl3cytyZnQyYXhOT1pXOHNy?=
 =?utf-8?B?WEVYVUp0NUdBUUp0SFY3Qkx4Z0R5WFpzTm5xKzRVWnpYb1FWZW1tUFNjak5y?=
 =?utf-8?B?L05ZTzFjWTJlSGZuTEo4bktGR055OElyQklleFRrOVY0bngxTklZQzZLa1Bq?=
 =?utf-8?B?Rm5ieWVGc0ErbUNWWEVaeDBTczd4bTlVR2EyYktITExYd1hIWS8zYUpwWXNK?=
 =?utf-8?B?V0NhZEZvTnIxdWxBeXZhcXFFR0JLT1Z4YU9LelZsbHFvcUxpajhHTVNHOUF5?=
 =?utf-8?B?dU5zM0VYbk1NVEdBaVRxZ0RTQTVDN0FzdHQrWTdMVytUcVB4cExnN1RPYm1x?=
 =?utf-8?B?M21qWVVlbGI3eDczbUI1eVdoKzJVOEIwbS9odjhiK3pLenJxbndqVVN2ak9D?=
 =?utf-8?B?TGVJd3ZzOWtraWdRbXc5RkN4MzRKZXBMVkJ3blJSbFpWWGVyV3Y1M3VlamZS?=
 =?utf-8?B?TW5yRER3NTVWK1ZSV1N1U0J2QnY1aGd3M1VidldTa2hYUUpuLyt3Z3VaQlRC?=
 =?utf-8?B?NVRsL244ZkozbmxPbXB1RHhpVnlmUXhKRFN0bWRMUlBndWJSMjE0OWQ1U0tH?=
 =?utf-8?B?TmltNTB4NFBjUWpyVHhlTUtMOEZFNmZ2TmJmQ2paY3RFYnNkYjFxNDRHUU5D?=
 =?utf-8?B?NUo1NVRxcUllUmhCcFhwS1JTVGpMdTU1SWVVZHMvejFJelVwdm5CTTM4S1lK?=
 =?utf-8?B?bnA0WXZHaE5qclpUSXpZRWFlUWM5Z2p1TzBXN05QdFh5bnZBcjdld3F3d0ta?=
 =?utf-8?B?NkdxcXY0M0pTbzhzWTJtOHdlb2t3dnpJWlN2Snh4Qko5TTlNdVRHK1V6RTJE?=
 =?utf-8?B?TjIwRnNveUVRUi8xY1ZIZFlDSU9iNnpFdmQwY2M4MTRDcXByTU5jdkYxcURE?=
 =?utf-8?B?TGsvODU1NkE0d0kvWXp4SWJld2N1U2Z0N0IzN2ZISjFPTTc1OFlBNHR5MExw?=
 =?utf-8?B?QjN6WExxSWhCbFV5U3lMZ1p4MkYvREUvNDVLRkdzZDRBR00vSVoxWTVEblRr?=
 =?utf-8?B?eWZlTTA3Qjk4U013NmRpZ0FHTUdXNnZIRFdoaUd4WDY3RVR3YnBmWXlMeWdN?=
 =?utf-8?B?N3JoZDBKRE9McExpZzFFNVZqQUhOemp0eG9UcHpzZmxPL29aUlk3SXJnbnRl?=
 =?utf-8?B?QS9GZ0ZVNU4wMEozQmp0QWtyU2tvL3BUSHRDRkI4RHl5VTE2UThLTytJaGJP?=
 =?utf-8?B?akt5V0JXc09mZ1J0RVNqaVFQblNqaG4ySmNWR1dpUGE3YTRpTHlUNHFnS1Ju?=
 =?utf-8?B?aVN0V1h1Sm9saEc4SzJXUmFqV2VUQnhrNHhKODZsN2xsWkU0bS9WWGhUMjdV?=
 =?utf-8?B?aHp2eG9Cc2grenFVUjdhV1FiaVJ3a0ZIQnBiMS9waHR1WXRnR0FUa0d6UDRm?=
 =?utf-8?B?c0o4d0VGNUFwTVN6Q2RtVXVHb2trR0dDTHNxMzNWWWkwWThCenRXRWo3cFlx?=
 =?utf-8?B?YnJaenpCVFJZbDlrUVpNaFZwdk5ORmpFWE8wenVxdUNnT29ka3VhZHVCWFh5?=
 =?utf-8?B?REROM01XNGJQVExkNCtGckRnTjZjZGtZdklFSFo1ekRmK1VCTC8vemVpTkov?=
 =?utf-8?B?QkNHdmZSQzEyTFFkR3BJTlRiU0tBK1hNOHc3TzJTNE9xREFIRTkxR0dBdWJO?=
 =?utf-8?B?VStmaDd5VHRMdmdaOEhYenNTRitVMFRjVmpmR2FpRGI5N1F6bHl5QllOUnUz?=
 =?utf-8?B?dXBZcUlKMVRRMm1kTWE5OVVWenVZT2o0RGp0ZFU1a2Y0TEYzbStpRWJ1eHFi?=
 =?utf-8?B?bmpTWXZjTmVUcGEyT2VHbHFPWnVCUk1sdkF1bDRBNGdoWFpLeEdUVjJoTFQ5?=
 =?utf-8?B?M0kwKzhsOHdCOERUR3dSWkpGM0pUNjNibVV5TjI3NVFHVW82cE8zWEt5K1pL?=
 =?utf-8?B?MTBqdjg0Z2k3Y3padEF4d0VNVTZTWlZVRjR4MzFjWUxJZ2Jwa1hlUkZCYnRI?=
 =?utf-8?Q?D382gM7WswQ2OKpLz0jywW5ERdKxXSSILID6t9WcLkRS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AECE4E7ECC3F94FAD201F235D8597BE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca2e061-750c-413a-141d-08db6cf4f3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 16:32:32.0000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mzv0sGgBbBbmGV4yhXXLUkcjUbiMeHqjz24I/1Y4D1WQWb6KkUFhbVlcuRcZ/FJ0mc4oncOzRFQ2/EGD9Tp5Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7646
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDA5OjI1IC0wNzAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOg0KPiBIaSBKb2FraW0sDQo+IA0KPiBPbiBXZWQsIEp1biAxNCwgMjAyMyBhdCA1OjM2
4oCvQU0gSm9ha2ltIFRqZXJubHVuZA0KPiA8Sm9ha2ltLlRqZXJubHVuZEBpbmZpbmVyYS5jb20+
IHdyb3RlOg0KPiA+IA0KPiA+IGNvbW1pdCBiYXA6IEFkZCBicm9hZGNhc3Qgc291cmNlIHN1cHBv
cnQsIDMwMzA4ODMsIGluIGJsdWV6LmdpdA0KPiA+IA0KPiA+IEEgY28td29ya2VyIHNlZSB0aGlz
IFNFR1Ygd2hlbiBjb25uZWN0aW5nIGEgaGVhZHNldDoNCj4gPiANCj4gPiBKdW4gMTMgMTM6Mzg6
MTUgc3lzdGVtZC1jb3JlZHVtcFszOTQxXTogUHJvY2VzcyAxODk3IChibHVldG9vdGhkKSBvZiB1
c2VyIDAgZHVtcGVkIGNvcmUuDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE1vZHVsZSBibHVldG9vdGhkIHdpdGhvdXQgYnVpbGQtaWQuDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMwICAweDAwMDA1NTZiZWE5MzI3N2EgYTJk
cF9yZXN1bWVfY29tcGxldGUgKGJsdWV0b290aGQgKyAweDNlNzdhKQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMSAgMHgwMDAwNTU2YmVhOTIxMGEyIGZpbmFs
aXplX3Jlc3VtZSAoYmx1ZXRvb3RoZCArIDB4MmQwYTIpDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICMyICAweDAwMDA1NTZiZWE5MmFmYWYgYXZkdHBfc3RhcnRf
cmVzcCAoYmx1ZXRvb3RoZCArIDB4MzZmYWYpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICM2ICAweDAwMDA1NTZiZWE5ZGNjODUgbWFpbmxvb3BfcnVuIChibHVl
dG9vdGhkICsgMHhlOGM4NSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIzcgIDB4MDAwMDU1NmJlYTlkZDBkYyBtYWlubG9vcF9ydW5fd2l0aF9zaWduYWwgKGJs
dWV0b290aGQgKyAweGU5MGRjKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjOCAgMHgwMDAwNTU2YmVhOTFhNGVmIG1haW4gKGJsdWV0b290aGQgKyAweDI2NGVm
KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjMTEgMHgwMDAw
NTU2YmVhOTFhY2UxIF9zdGFydCAoYmx1ZXRvb3RoZCArIDB4MjZjZTEpDQo+ID4gSnVuIDEzIDEz
OjM4OjE1IHN5c3RlbWRbMV06IGJsdWV0b290aC5zZXJ2aWNlOiBNYWluIHByb2Nlc3MgZXhpdGVk
LCBjb2RlPWR1bXBlZCwgc3RhdHVzPTExL1NFR1YNCj4gPiANCj4gPiANCj4gPiBDcmFzaCBzZWVt
cyB0byBiZSBhdDoNCj4gPiANCj4gPiAzNDIgICAgIHN0YXRpYyB2b2lkIGEyZHBfcmVzdW1lX2Nv
bXBsZXRlKHN0cnVjdCBhdmR0cCAqc2Vzc2lvbiwgaW50IGVyciwNCj4gPiAzNDMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAq
dXNlcl9kYXRhKQ0KPiA+IDM0NCAgICAgew0KPiA+IDM0NSAgICAgICAgICAgICBzdHJ1Y3QgbWVk
aWFfb3duZXIgKm93bmVyID0gdXNlcl9kYXRhOw0KPiA+IDM0NiAgICAgICAgICAgICBzdHJ1Y3Qg
bWVkaWFfcmVxdWVzdCAqcmVxID0gb3duZXItPnBlbmRpbmc7DQo+ID4gMzQ3ICAgICAgICAgICAg
IHN0cnVjdCBtZWRpYV90cmFuc3BvcnQgKnRyYW5zcG9ydCA9IG93bmVyLT50cmFuc3BvcnQ7DQo+
ID4gMzQ4ICAgICAgICAgICAgIHN0cnVjdCBhMmRwX3NlcCAqc2VwID0gbWVkaWFfZW5kcG9pbnRf
Z2V0X3NlcCh0cmFuc3BvcnQtPmVuZHBvaW50KTsNCj4gPiANCj4gPiBBIGdvb2Qgc3RhcnQoYnV0
IGRvZXMgTk9UIGZpeCB0aGUgcHJvYmxlbSkgbWlnaHQgYmU6DQo+ID4gDQo+ID4gLS0tIGJsdWV6
LTk5OTkvcHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmMub3JnICAgMjAyMy0wNi0xMyAxODozODox
NC41NDIxMzc1MzEgKzAyMDANCj4gPiArKysgYmx1ZXotOTk5OS9wcm9maWxlcy9hdWRpby90cmFu
c3BvcnQuYyAgICAgICAyMDIzLTA2LTEzIDE4OjQ4OjMyLjU0MjUyNzg4MiArMDIwMA0KPiA+IEBA
IC0zNDUsNyArMzQ1LDcgQEANCj4gPiAgICAgICAgIHN0cnVjdCBtZWRpYV9vd25lciAqb3duZXIg
PSB1c2VyX2RhdGE7DQo+ID4gICAgICAgICBzdHJ1Y3QgbWVkaWFfcmVxdWVzdCAqcmVxID0gb3du
ZXItPnBlbmRpbmc7DQo+ID4gICAgICAgICBzdHJ1Y3QgbWVkaWFfdHJhbnNwb3J0ICp0cmFuc3Bv
cnQgPSBvd25lci0+dHJhbnNwb3J0Ow0KPiA+IC0gICAgICAgc3RydWN0IGEyZHBfc2VwICpzZXAg
PSBtZWRpYV9lbmRwb2ludF9nZXRfc2VwKHRyYW5zcG9ydC0+ZW5kcG9pbnQpOw0KPiA+ICsgICAg
ICAgc3RydWN0IGEyZHBfc2VwICpzZXA7DQo+ID4gICAgICAgICBzdHJ1Y3QgYXZkdHBfc3RyZWFt
ICpzdHJlYW07DQo+ID4gICAgICAgICBpbnQgZmQ7DQo+ID4gICAgICAgICB1aW50MTZfdCBpbXR1
LCBvbXR1Ow0KPiA+IEBAIC0zNTUsNyArMzU1LDEwIEBADQo+ID4gDQo+ID4gICAgICAgICBpZiAo
ZXJyKQ0KPiA+ICAgICAgICAgICAgICAgICBnb3RvIGZhaWw7DQo+ID4gKyAgICAgICBpZiAoIXRy
YW5zcG9ydCkNCj4gPiArICAgICAgICAgICAgICAgZ290byBmYWlsOw0KPiA+IA0KPiA+ICsgICAg
ICAgc2VwID0gbWVkaWFfZW5kcG9pbnRfZ2V0X3NlcCh0cmFuc3BvcnQtPmVuZHBvaW50KTsNCj4g
PiAgICAgICAgIHN0cmVhbSA9IGEyZHBfc2VwX2dldF9zdHJlYW0oc2VwKTsNCj4gPiAgICAgICAg
IGlmIChzdHJlYW0gPT0gTlVMTCkNCj4gPiAgICAgICAgICAgICAgICAgZ290byBmYWlsOw0KPiA+
IA0KPiA+IGJsdWV6LTUuNjYgV29ya3MgZmluZSB0aG91Z2guDQo+ID4gDQo+ID4gSGVhZHNldDog
V0gtMTAwMFhNMw0KPiA+IA0KPiA+ICAgSm9ja2UNCj4gDQo+IFdlaXJkLCBJIGRvbid0IHRoaW5r
IG11Y2ggaGFzIGNoYW5nZWQgZm9yIEEyRFAsIGJ1dCBwZXJoYXBzIHRoZXJlIGlzDQo+IHNvbWUg
QkFQIHJlbGF0ZWQgY2hhbmdlcyBhZmZlY3RpbmcgQTJEUCBmb3Igc29tZSByZWFzb24sIGFueSBj
aGFuY2UgdG8NCj4gYmlzZWN0IHRoZSBwYXRjaCB0aGF0IGludHJvZHVjZXMgdGhpcyBwcm9ibGVt
PyBPciBpdCBpcyBub3QgYWx3YXlzDQo+IHJlcHJvZHVjaWJsZT8NCg0KSXQgaXMgcmVwcm9kdWNp
YmxlIGJ1dCBvbiBhbiByZW1vdGUgbGFwdG9wIHVzZWQgZm9yIGRhaWx5IHdvcmsgc28gd291bGQg
ZGlzdHVyYiBxdWl0ZSBhIGxvdC4NCkNhbiBJIHR1cm4gb2ZmIEJBUCBzb21laG93IHRvIHNlZSBp
ZiBpdCBpcyBpbnRlcmZlcmluZyA/DQoNCkFueSBjaGFuY2UgaXQgaXMgcmVsYXRlZCB0byBodHRw
czovL2dpdGh1Yi5jb20vYmx1ZXovYmx1ZXovaXNzdWVzLzUzMyA/DQoNCiBKb2NrZQ0K
