Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D242C47097
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88191613FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 14:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhFCOgo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:36:44 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:59808
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231768AbhFCOgm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Jun 2021 10:36:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy6YT1fdKtsGUEqxTTE5uYtqF9serlnBM+2k94DPEx11u5vR3BY/pxvhciHuZFppadfjKkEk7JP/jbut8dHfqXsf6MCz+cuKc7fP7FKcQgJKEgkKdFZaJ2oJT5uQNo5KsalyvGJwgbofx+lzVMYoPlbI+KuSF1qukVgluDkcCsahVYAN3CS/oIuA0NzlM/Rp1w+k9K+m6rtrbOsuRjF15IW63gBIc0W0m6Z47h56jb4jFWb1XuCYvvS7IrAjwyv3KiS6RluFQsdgE12hmGHJw17Ud/2wBHDcK7T8rI0EuvVSYDB++yRewYHdgmMR9CphP90Lsks9QTh6iTm2KmBfvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PildPMv5eQP/6CzZwQMdP1V1a96vkwbkn2ixua2QDAY=;
 b=IIfsZDGy9RsaYgty+HoLqO0JGSRwedijWVSkQ0xT7sXBu6xMnpqD76lYY5Ur1qE8EL5HnPtDtGDF2gFI8m2ufrJ/BT5pNdVX43tUNbsI9ilOraaxYHA4db9iC9kwg5tTPh2egTMcFX2QP43TVoc0nmNCT/pRmNbqnijYTPIaiMes2ANcVuvcUs3ucnD1pJSGCsxlAG2zZYDmdvwm+a2BT12xHiWMzaGn1rHhYeM7kV9rGJ1lv39kYqIx6WD8cuzS+YoeuZQ8bsMgwgP//KTZV06WDNViShweeW83Klo6nEIqd0OVVL6xZlnP3RQFELrk2UZwJImFIwqv5dZBLYvRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PildPMv5eQP/6CzZwQMdP1V1a96vkwbkn2ixua2QDAY=;
 b=Ih8G5mZ8ktWi5jzbTBCfMxQ897AA8a1Boq72pFMEvSY6mkRlK/0iUvzf096CmZtEPEAOinOihlgVN9f5JDwdvd4d3SAfbkAkbQRF2ELMYZGq02oVZAtgKNd0Blv8ocOIG5iOgVJukjBvL/ExLa1G2Jp4vQqYhb1J5jOj5clyBgo=
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH0PR10MB4517.namprd10.prod.outlook.com (2603:10b6:510:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 3 Jun
 2021 14:34:56 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::5021:f762:e76f:d567]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::5021:f762:e76f:d567%7]) with mapi id 15.20.4173.030; Thu, 3 Jun 2021
 14:34:56 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "kiran.k@intel.com" <kiran.k@intel.com>
CC:     "ravishankar.srivatsa@intel.com" <ravishankar.srivatsa@intel.com>,
        "chethan.tumkur.narayan@intel.com" <chethan.tumkur.narayan@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
Thread-Topic: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
Thread-Index: AQHXUzxp1Hmy/K78mkezsPdlt1nyq6sCTuoAgAAC69CAAA3HgIAABSiA
Date:   Thu, 3 Jun 2021 14:34:56 +0000
Message-ID: <d309749ae01431b9ec6d8ceadfdc2cd9e56d5c7a.camel@infinera.com>
References: <cdab6dbada26fe31d21bb133ef087574c85c1411.camel@infinera.com>
         <c975e61b3866cc7615e6b995977a9d59f22384e8.camel@infinera.com>
         <DM8PR11MB55737E1DC9F97B750713C1EDF53C9@DM8PR11MB5573.namprd11.prod.outlook.com>
         <029F6035-91C8-475C-A7C9-C8DB2698255C@holtmann.org>
In-Reply-To: <029F6035-91C8-475C-A7C9-C8DB2698255C@holtmann.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.0 
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc55e89b-07ee-4c95-9654-08d9269cc26a
x-ms-traffictypediagnostic: PH0PR10MB4517:
x-microsoft-antispam-prvs: <PH0PR10MB4517BDD35A8488A01EDC5167F43C9@PH0PR10MB4517.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g3fR1ByqLGlhg1b7uKpT3+87jgMzjSLjQX+oQsXvCB+uEvs2yKo+r919zAPdjRlQY+SSf+xUL4wzYucxfuvuzXcVGeaxppQHi5+jVmhG/klb+PS/3ej2s+iejvY8TPf74BQOoreq8b14l9wteq4mXHmbbIkjB7d5wHtmKnCa+6E+WugG0IWmMwyPXijLa+Zqe+culXY215oGu0OsXQDJYm0XznoFpzawFMZjwCuJ9Trd5sPaS8oIYCAoIV4v8mKNVWvzkwh5zBsZIQxTQ5ws/4QmF6b++30CZdasYUqxIA+TaVMSJvG/lKp+Mm0kazQLs+G9ALxX8zkdFnLjrn45FLKwvo6NBaP3rg34+tarbLaoyVoHtbk9NQQvcEPhiN3eahg5cWKsvUwYbysq/wKDGK2ix7CofJCzJa4zZn9tXaWE0FZ1AAybl2Stk9OIMu9gsBlj5UTk/7WgxmnPULjhH/ADiQTCqz+aElRlaxjfAhpyd+ccJ2F1scJMkTtXSmTtPgEEnAXY09uiS0o/1mgQne46BCdXzaMtb0RZRJk1AfhqI+YTj0YJp0YMNs6idWLCyQN+lBpBvg9/Ne7xwgf0ApBebApIEq8q88T73VPJ7jo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(76116006)(66476007)(66946007)(66446008)(64756008)(66556008)(91956017)(86362001)(2616005)(5660300002)(4744005)(4326008)(6486002)(6512007)(8676002)(2906002)(36756003)(478600001)(8936002)(71200400001)(54906003)(38100700002)(110136005)(122000001)(316002)(6506007)(186003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S1g5cElEcHJOSEZsaDRvaVYxYklJamNLMmpIN1l6L0RmRVI0Y0JaM3lIMHJa?=
 =?utf-8?B?QUNsVSt0eTRUSC9vWTkwTUM0SkIvZnRZeXFYWWpuL3dZN2ZwQlpFSE1QSCty?=
 =?utf-8?B?M25SdzRoZm16R0QxWTBMOE53Mm01QUV0ayt0c3ltRGFjUyttanpxMTczWEhX?=
 =?utf-8?B?emw0MUJ5ZmdhbkpvVUN1RTJtZ0VBUCtJM21UZDZOTGg1bk5zMmVCTnR6b2VN?=
 =?utf-8?B?ZFBqYnNUVVRZUGovVGl0YVQ3bXFLeXYxR1JYZ1dyb0xqbFhGU1d1YnpZaVZy?=
 =?utf-8?B?NlJXV1B2ZGhQKzI1TlN3TTBzUlpMSm5veHF5SVRGRWZBaWRtRXNySFBUMEls?=
 =?utf-8?B?RnRwSXpUcFN1anJiZTJxMjVsbSt4MExaaEtPczl0cis0V0gwTS9FQnFOekpx?=
 =?utf-8?B?eWY3Z0JkQ0JCWUljNGZyZjBZQXhVaWVWNWR4NlVibjU1VTI5bUdIdU5PRGV1?=
 =?utf-8?B?cVE5TU9kZkdONlhMRHdGam96cGpnZkl1MkdzYXI4SEVhb2dUUGtpWWZ6NVkw?=
 =?utf-8?B?dUxTRzVselc0WVVnZGRYbW9wdWoyN28zdVg5UVhnNHhHK285aHJvMmJwWldJ?=
 =?utf-8?B?MVoyeC9TeVB4T1llZG83QmdnK1VjMitMUE5IeXZxT2dxVUhKbDEvVWFhM0d5?=
 =?utf-8?B?WFdURGhjbENsUTFjVG9tS3VBK3VRTHYzVXFST1M4SzQzb2VHUTNCSkRXN1hX?=
 =?utf-8?B?TFhQeFF3RUZtbzBTMXRkbitvVzFBNDE0NkQvWml0OVlPNjJDd1pPL21BQnBv?=
 =?utf-8?B?aDRwa3BWem9obWRIcVJlWVBzMnNrdjEzemY0aWo0ekhXcGRwYkQ0cktSNjFt?=
 =?utf-8?B?aEdtRGc0TzBLeThFSnhLeFBtRTBFSTNMV05FL2I3eUduUzhLNjZ5eWpNUFpy?=
 =?utf-8?B?c2JSbmV1R1B6NHFYVWMxUnNiL0lRL1duVnI1bGJ5WmJYckEvUGNpR21TTzFL?=
 =?utf-8?B?UHIvQkN5UHpsZVpPYVZ4clM4Z0ZHMW1OcUdUZENtYlFvVitRNUtxcjBzSEZq?=
 =?utf-8?B?eWEzQ2ZtalpWSmYydnk4SHZmQ3FvUnhPanpxb1hTNTBBdnByOUdTdzVwQ1pJ?=
 =?utf-8?B?K3VKODB1SERqaHFJbkVWdHdIUEN0QUtrSUJ5L1dvMERVL01jWER0ZHRhcGJt?=
 =?utf-8?B?aGFSODh4SlBQQUZTY2lLRWt2QWlUVW4zRXRrbXJydkRBaDRpam54dlZHTW1V?=
 =?utf-8?B?Sk8wQ0pCU05mbHpQRDBiTXh3S2ZJUnhIVktqQytEeS9lbGlveXJqN3NPVXpR?=
 =?utf-8?B?c1ZyMEVwVEQyYTJwKzJqVHU4ZTA5dWFDSDhCU0dET1F1cno5aS9iUkJxbGNS?=
 =?utf-8?B?V0ZISk55YjY0SGdLTEozNEJZU004WGlYdVpyODN5K2RoY1JvRzhJVVZsNndw?=
 =?utf-8?B?bGRTaWlDSW5nYVIxaXZUMFhKdUkyVklPNUpMOFIrRCtNcUU3Tk5aY2s2UXBB?=
 =?utf-8?B?YkpoTHV3aWppVEhkUDNwODMrWmI5Zm9hcVIrQUgwSHJxelFXRUxocVc5WkVU?=
 =?utf-8?B?RS9YWk1TMS9OTW1WTEZ5cTFMQlhML1oybkxkeUttUzVxZjcvQW11N0NLeENY?=
 =?utf-8?B?dE1Ca2JiRmVxZGI4VzhRWmY1Mm16WTNZOTBDSk9hM3E2UlJzWnpzQ1lVS3dQ?=
 =?utf-8?B?VCt2QzNqZUFRbnc3S3N0bENtcm5IKy80czVqWjRSMnVHQnJ2ajYyUzd3ZTFI?=
 =?utf-8?B?U09jNExNRmdlUVNTRk1Qa0Z0Q1R3NHhDQ1pwbUdLQ29BZVc5YXp4NTdBdmV1?=
 =?utf-8?B?V2ZhU0tzMHBvcmNXdHQ3ZlBRUFN0dUViNkN4OFYySGFnT3UxRzdZYTI3QkpU?=
 =?utf-8?B?VnJQR2pUZHpPZWVBOFdodz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <469D4952F380024781C2B25C3CFB362F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc55e89b-07ee-4c95-9654-08d9269cc26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 14:34:56.6511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHNz61wz6INSgy04pfmFprckKVItktr+E88Rt3+JwAg4KAyNLf3S8y39kCdNeRs/mdqg9shDoWi47DA+N5GdpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4517
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTAzIGF0IDE2OjE2ICswMjAwLCBNYXJjZWwgSG9sdG1hbm4gd3JvdGU6
DQo+IEhpIEtpcmFuLA0KPiANCj4gPiBJIG5lZWQgdG8gY2hlY2sgdGhlIHByb2Nlc3MgdG8gc3Vi
bWl0IHBhdGNoIHRvIHN0YWJsZSB2ZXJzaW9uIG9mIGtlcm5lbC4NCj4gPiANCj4gPiBMdWl6L01h
cmNlbCwNCj4gPiANCj4gPiBBbnkgaW5wdXQgaGVyZSA/DQo+IA0KPiBpbiBnZW5lcmFsIGlmIGl0
IGlzIG1vcmUgdGhhbiBqdXN0IGFkZGluZyBVU0JfREVWSUNFIGVudHJ5LCB0aGVuIG5vLCB3ZSBk
b27igJl0IGJhY2sgcG9ydC4NCj4gDQoNCnRoaXMgaXMgYSBiaXQgbW9yZSB0aGFuIHRoYXQgYnV0
IG5vdCBiZWVpbmcgYWJsZSB0byB1c2UgbW9kZXJuIGxhcHRvcHMgb24gc3RhYmxlIDUuMTAueCBz
ZWVtcyBldmVuIHdvcnNlLg0KVGhlcmUgaXMgbm8gbmV3IHN0YWJsZSBvbiBjb21pbmcgc29vbiBl
aXRoZXIgSSBndWVzcz8NCg0KIEpvY2tlDQo=
