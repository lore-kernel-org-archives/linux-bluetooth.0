Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E7C47082
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061E9613DE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 13:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhFCNSa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 09:18:30 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:21728
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230351AbhFCNS3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 09:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+DciLXDvplLLdwCxxQZhpHLyNe45tSnNzlzX+jm++SFvCQwlXuJiklYXyN5tvsz9bv5Ykx4Fd6n+z275AHhbg2XJ7PG1mVpO7LTsXV/CA0Z2qgsyfxWyhYsRpCbu9Co+SdpKZM2wA5GhrCn5xHlV/Esh75IFuYXy5RqMRazdOusA9yyK86I9jMTZNy3MNO+fr4SV9wkgE6wAixxgeqXnzQemKgvBcGEAB43gdIT0TGLxh2F66Ysv+y4+EkRq3Yhwnr6RoB7ofLVwC1TUgGyWstGs1YKwYjdL6u1aXq7xoPzXsQ7NuhjWNZVqsAYo6QKkAf/2cCMomLhjzj85EZbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9+dJpy+7zbcQ62ZqUGxhcxOJ13tqGHGEGrRz9S7VUE=;
 b=lfIX6IZYNOM5cNOJTNGJ0ivT+xHtQB2fZAzqSYVwIiraN/23RDJ/1U3+xJVVJyV+yFu6xTHLssxOD2IDgmYxrTf+kOHPJ/RHZ2y9m1YjQlhAjOqRx5QEcPw1wK9RD+P1VDfvvqVoDy73n9q26KZ3glxjHhLXRJJhKS6mt/sRuKSZ/o2UBIrwxdkQbSXPIX2X/3U8/tOeFG5SsfBGNKu4otP9zrkItzuS0/l5wI3WJOwpuujxxlYu4DUt8/iW5/YTsAJtrPqoMUyxCdIOs+KSClAbQ6t1KbGVkJIEubmoiMKMtAkwjQCv8/vi/ghoA8iFUTSeao0GtmbjrN6p4JcsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9+dJpy+7zbcQ62ZqUGxhcxOJ13tqGHGEGrRz9S7VUE=;
 b=aCB1/gYdAMup5Do/ZcPfAa+GZWwGLxwCmk9NnZdPecQ2d0cAVAV1VFp67xd2oGuj8DA1dVTuzYpu2/eKYalKIJYsv/F4x0bfQ3EwzFgV1OTpussc8jNX0WuwCYkO7+fwRpqVZ51MiU2C7TO/bkKhF3zUqGeZJ+iT9ex2W9jHl+Y=
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH0PR10MB4565.namprd10.prod.outlook.com (2603:10b6:510:31::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 3 Jun
 2021 13:16:44 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::5021:f762:e76f:d567]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::5021:f762:e76f:d567%7]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 13:16:44 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
Thread-Topic: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
Thread-Index: AQHXUzxp1Hmy/K78mkezsPdlt1nyq6sCTuoA
Date:   Thu, 3 Jun 2021 13:16:43 +0000
Message-ID: <c975e61b3866cc7615e6b995977a9d59f22384e8.camel@infinera.com>
References: <cdab6dbada26fe31d21bb133ef087574c85c1411.camel@infinera.com>
In-Reply-To: <cdab6dbada26fe31d21bb133ef087574c85c1411.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.0 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af9f9f8c-7501-45af-ecdd-08d92691d558
x-ms-traffictypediagnostic: PH0PR10MB4565:
x-microsoft-antispam-prvs: <PH0PR10MB4565C35CB70D0A29AE99DF76F43C9@PH0PR10MB4565.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tVqxrtkKU1uP3d8UHNtiFG9urH91zLgQorqiCf/+cnJxSq2wiLEbDrDwdzQvHqikHeGMc98fzj+bT2UvRav8+DmI+VE/cZlAEY18BfemmpDvHMKAAJgSRyIcf5Evw1/tdgu03enxC0JrJycWGQdu5dEbuxWLMNWBIeP2xBEm+/1h5nQx4NhHk/9k1qay2MAPlMD4iH12CDz1AMPtGLp//i9HppAGZ64EUBfcZpEieoq2o/sU0Tkz34uZWMFWgw6rRrHe+zWtpY71XyHPwGk3MRYvUQlvDqoCdk9XnkMa+Avjn/+zgJrVmDY0tzDVZqN6uGjTBfX66XD8jhGS+j8SdsvGhb3WoEwJ3bSCxHCDRyrlX3vICoPXY25KV8L5np8Azq9OrQWVLRAHssLhOLDLUaBSpth/i0Pti9fvjUGuR2VFTHzPyS2esg1hKrOZRZcmjuQTslBWzzpMuQ3zcNwZZo0tRdBMwjfEBFC00PNBP6gAFiE/HluUEp8O+X0NNS2txonqAe3iU7phxOsaczprStXQJ2PScJkhanNtUnD/vxZnZ+VSFYEgQluDRrgI/b2PvYZoobW7uTC6i9D5d1FXbRlgp0DzagUmzZb4/I0l9q0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(396003)(136003)(366004)(76116006)(66476007)(91956017)(66946007)(6512007)(66446008)(66556008)(6916009)(64756008)(5660300002)(2616005)(186003)(26005)(36756003)(558084003)(122000001)(6486002)(2906002)(478600001)(86362001)(8676002)(71200400001)(38100700002)(316002)(6506007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?em9HSU4yaHRxbnFUeTU0Z0VJeC9FSjFWdkpiWmlVSUFWcVlZTVN3aTVPTzg1?=
 =?utf-8?B?SnQyR0RlOFl0K0FLcG1iOGF6ZFJicEJYN2tGc1Q5RXYvd3E3RklIYm8rUEVJ?=
 =?utf-8?B?ZndaVkQxcEhJZkdLN0VKN3ZxR0FjUlR4WHNTTjl6YlpPUHJsY1RpN2xoNEFD?=
 =?utf-8?B?eW5qcU9ROG9JVkNJYU5hNkZHR1BhbDVvVHMrSHpYUVkvZUlhY3VQd3VXK3JJ?=
 =?utf-8?B?UkY1bFFMZ1pyQTMvcUhpOWFhUHF0eTRESnA2THc4UGJFVjA1cjZKcUE3TXdH?=
 =?utf-8?B?NnU1a3ljZ3NIZ3NKR01FN0tnMk9yK210R1hhWWYwbkp4ZXZ6a2l2emRNKzVN?=
 =?utf-8?B?VitxeTd6UC8ybGlqYmQ5bzlPQ1FSQXZuOHhBeWxWMG5wTEVSb1VpTzVTVFVv?=
 =?utf-8?B?YVorODNnTldLZG9CcUs5bE53MlpyWUswTmlwTjVlZVVpSTA2cjBkVHk3Q3dQ?=
 =?utf-8?B?RVlnQUhEd09yOXVYczdUYm9rWTkvZDRVRnQxaUNmYXFROWJ1bWFwd29YNjBO?=
 =?utf-8?B?Uk1kN2VjNXhRV2V6dUwxMTlhazVZMHhFS29NSUVpTXZ1ZzJtZUUxTVQ5eDN1?=
 =?utf-8?B?T2NrYW51ME5yQkx0UHc0SFpId25BSXR4ZERxNXFZM0pRQjR5ZGJxZnlnVUI1?=
 =?utf-8?B?Qkh3amN3Z09oWVk3ZFhqZVZLUWVaWm9sM1puS2NBS2N2K2l3WUFGZEZ4RUlx?=
 =?utf-8?B?K21aeU1xRktoaWhIbXRHS0tNRk5rYnBSMjJ0NWhDcUpXWDI0SzkxWCs2b21u?=
 =?utf-8?B?K05oR2dRTXVsSmF0dldsRWQ5MzRUdERjNTNXREZCYnNqYW5ETEFYR0RNbk95?=
 =?utf-8?B?T2xMZEpxUUxselpEZmR4ZlpZYXZRU3hYTlMybGVkZGwwYmUyQ2lWbnRHT2JE?=
 =?utf-8?B?M2RpN0RzaHVGMEZacXFEYXYvcmtsSFFwOUxmVG9IUHNSMjgvM2JFYnlNT3li?=
 =?utf-8?B?SWxrdFIxcCtVbnN3c2ZMdWduZWprSWhhMkpndDRTN2dMRGdHSDRmKzQ0Ty8y?=
 =?utf-8?B?bWltbDZjMzZ2Qi95dm5FdWY4R1RXYSs4OFJIQmU0d2trZGxiTkdOZ3dTS1Y0?=
 =?utf-8?B?WE9mM2YvM2ZlMkVoTkFIUUNPODBZK0ppd2dKSFFVVU9nWDJKNlZNQThlTGsv?=
 =?utf-8?B?VGhiOHcxK1R1cG9DaEs0QmVSYXFtdU9YSVQxV1FNWEdvZnd2YUJhd2ZoMkpa?=
 =?utf-8?B?TXJLZmRZL08xNWRLWENoQmF4cWwxbThWeDg4NnRlc1U1azNBMC82dVBZV1JP?=
 =?utf-8?B?NXY4dVFhOVJIM3AxUlNuQzM3YzdHaFpGeUd0b2l0OFRKVzBDR2NQSk44NDh6?=
 =?utf-8?B?MzRMQmpOVFlLSGdaZFIxRnNsa0lnc3g0cEVSUkUwVG9sYndLWk1RVGVRNjNp?=
 =?utf-8?B?VENwbmxmL2pUKzBQQkxEbllRWkNoenZlZ1JhS3AxRjFrVUQrTUcwb0tBVTc0?=
 =?utf-8?B?Uk41cUJPNDJYNjVkY0dUTXFxSVJLV0NIemVNTVRDc1Q0My9SWEZyTHg5NWVt?=
 =?utf-8?B?L1E0SWFMZEx2cTd2ODkrUEg5MUkwOEEweEVnQzMrVWc5RERLYWNKazExdUNR?=
 =?utf-8?B?cS9DWGNKd3gvclNhRUtscVUwWis1cys1YkNtSzdEazlXSk9yOXFLZ3doNlRM?=
 =?utf-8?B?SnJrb2lpaGNCclljVklUMlV5Um1WalFtV0FMM2VFR25oUVVOaWl3cStwaWdL?=
 =?utf-8?B?aU1WVndHNmZsR0g3UTdNOU0rczFkQ1FXeXh0US9kSjc5dkwxWXVnbmZUdXdu?=
 =?utf-8?B?UzdraUZBYkhhMy9CZGFVRGxkdzRhYWtlZHRKa2JqK0ZoVGJFT1owajN0N0pP?=
 =?utf-8?B?bjdJdXRWRjhJMklLeitiQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C56C1B0767FDF847A12550999F4D8BB3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9f9f8c-7501-45af-ecdd-08d92691d558
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 13:16:43.9720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v++rxRJVyi1quRAw5ETu+p1o32ycCPe7i1XWOIrzrrFU+bn9zmrwgQWjsVISJexPdOE7SDvU5MY7G1+pTQxWFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4565
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTI3IGF0IDIzOjA4ICswMjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBUaGUgZGV2aWNlcyBhcmUgcG9wcGluZyB1cCBub3cgaW4gbGFwdG9wcyBsaWtlIExlbm92
byBUMTQgR2VuIDIgYW5kIHRoZXJlIGlzIG5vIHN0YWJsZSBrZXJuZWwgc3VwcG9ydCBmb3IgdGhl
bS4NCj4gDQoNCk5vIHBsYW5zIHRvIG1ha2Ugc3RhYmxlIHdvcmsgb24gbW9kZW4gZGV2aWNlcz8N
Cg==
