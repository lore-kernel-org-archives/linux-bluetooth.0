Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54117E7C4CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 15:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbjJDPdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbjJDPdL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 11:33:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B16D8
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 08:33:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMiGpL462hRMRTOae0VXWkKN30adJH4w7Nws0qXhF6Inh0OdWnQxjWJnWKZ/FR1E/CKcR6H3dYjzkngdYr0TU+guQoUZkUnxU22Iz3xXnvJwGd0cNCo8hv+MELve0By6FH5NW0UoDMe+sHTCk/WWQW3NRFtQBmLb2Ka+tEn6RfttQPaITh9GO20r9hZ2JZt8X/cc+Url85di7uoKxfIb6xKoMiQIV0GqQ2VlXnwYQdcAjk4KSxjxFE/WSzVnkITav4VG93ylFzfqGSzg+pIKakGneFZlXPkaKoZMKcLBynLjV9FUudY1SIRQnLeZX1wZuEKatFRCSqxwQQaWlHU7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szgg6x4NnH9C0jM8CrN0qEDWzkE/03mAcGod6jFWfn4=;
 b=C8bLSdkIRYSBQTz5zptdVPzC0dRHJNWUMDHs2+6Ne9D6CKLROi9/cDj0erd7enWx9avQzZmljemYzg3KfRfFDgjsucFsVao8cp2scGlFhqk2fzDBXH+7i83Ptl7wg/TAGrCaAeP7c6BDyLMH8JXH+TajsaEgEpsW93QuZIAo0fo/nqoHPBIrQZnc+c3CohAuNRVgBWqg8WqmhuMSiHFCjRIMmIoWKmasLVw9Jlpf4Lnbbq86YONxf8gBdaS6KNYH32ljUiJ0W5a5CA5WU6Q5wR6b0VvUSjaMqUH/cwrfwmlQanIHlc1BbaHpWprkCLbW1cG5MnAcgXrxmiuMYWocTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szgg6x4NnH9C0jM8CrN0qEDWzkE/03mAcGod6jFWfn4=;
 b=Od0Ckuj8vGUaKIh7ECyMApsjkICFslz5dJLOeoB7fHXJQ5OOPNmogUs98E1owmVuLQskludJEg1jilm+H2+6lQrFXFIsLug/fCthWdr3uZsqkFBhRW7/M8aN4Jqe8LRI1QC2rZnTlpJ0QKdfUwxGuIBP+HpMANNJfAZvOKQ+fYs=
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by AM9PR04MB7652.eurprd04.prod.outlook.com (2603:10a6:20b:285::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 15:33:05 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::c031:474b:cd00:5f95%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 15:33:05 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Claudia Cristina Draghicescu <claudia.rosu@nxp.com>,
        Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 3/3] bap:Update transport acquire/release
 flow for bcast src
Thread-Topic: [EXT] Re: [PATCH v2 3/3] bap:Update transport acquire/release
 flow for bcast src
Thread-Index: AQHZ9UXi5OoflzYp+kymbHhz5oA+arA3BNUAgAKF9/A=
Date:   Wed, 4 Oct 2023 15:33:04 +0000
Message-ID: <DBBPR04MB633163C3443290DF34C15421EBCBA@DBBPR04MB6331.eurprd04.prod.outlook.com>
References: <20231002153352.3163-1-iulia.tanasescu@nxp.com>
 <20231002153352.3163-4-iulia.tanasescu@nxp.com>
 <CABBYNZKiTS9herQBkMZge3CienN46_1TDcjdFUPf+yw05ESwtQ@mail.gmail.com>
In-Reply-To: <CABBYNZKiTS9herQBkMZge3CienN46_1TDcjdFUPf+yw05ESwtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB6331:EE_|AM9PR04MB7652:EE_
x-ms-office365-filtering-correlation-id: cbe697b7-1a5f-4039-83bb-08dbc4ef33f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MvJQUSyrHb7xf4cluFtzMRGSeWFtcwKNzDJlvezerk3+9UAhCT6uv0kRWS34LgxF5K22cJZ6Hv7/sAmriGZZQzHjh26ZakWBk2lXFZ6R8Yb+oUzNv59Pf9scDY++YyYtKfaCPx3UkR1ajdSKdyLQ77wTnbRQwtbYwSPvZMYLbXjXdOrn8QUbEAkCvuTasZN9du2BhuX47bMDBHZ2s1IeXbvNDRFNRxTF2hbuZ7msS+QNSI7WeDs5i9GekYZzl1AEzNnyaRlOEXemYPTnEK54EuD2evRqBT96v5KDmGil3T7ZxLIVPiupqj8BpsbLaN3PYWvS5YA1iOfvjz0bsHi7pFQbI569ZuraGLQAgd16UTCDmRCtcDhAkqZmk7J51IHG3YZz6aVAg95qwOtHVO/h9y+f5D0czAItELbWprOiEMuOIuxtvrkxM0+oolbnXPVLqES/ZuiOuYuA/gFwWWrjjUB6zJBn0uFvH5/xHiBzsfB9PtHPKnkdvF/h9N5zCP6qnRzjIRbuu7SQDjEFEAj4Cz2h/LidY3m3sgWv/hRnv10938Ub9L/PeDnLA8FHWSCVAW6h4JXCmVTbPtvIiI1E9qwXmIiY3NTWFDIl/To1W7ftai9d9OLGcraup0aDuttb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(52536014)(33656002)(5660300002)(4326008)(8676002)(8936002)(26005)(71200400001)(9686003)(7696005)(6506007)(122000001)(86362001)(55016003)(66556008)(38100700002)(2906002)(478600001)(38070700005)(66446008)(66946007)(64756008)(76116006)(316002)(6916009)(54906003)(41300700001)(15650500001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1FWcitpZnRJNEM4aG5ic3VjenVQeEh5Rml0QlpRUC9GeHJWejNad25VRkcx?=
 =?utf-8?B?Uk52TFpaNkMrb0hsOHRLYm9NRXlKbDM2cHF6ZzNEZTdpLzlqU1QvbGtwbTdJ?=
 =?utf-8?B?VnBXTWNiSWlkZkZMVmNsYmVhcVFtbEtGV1p0aVZaRkVmN0hjamFNREtZaVVM?=
 =?utf-8?B?N21hZXNnVnFxZmd5bEJFK1ZvRFkxUmdEcDduNEk1YlVnY1RmZXhhZzdSekJV?=
 =?utf-8?B?eEtTdmJuUVBCeENQOUt4Rk16cHBDT0kzRWVFSVpWbm9OWUdXTTduVHBtdnNR?=
 =?utf-8?B?VWVCamM3OUhTMGZBbUtuOCtrVlNlelhML0hrN1lhcEwycWU1MDhqQ3l6Ykhl?=
 =?utf-8?B?QnE5d21yUkJUejVydkltbGFvSmhLRVl2VmJHeE9KSThmZzBFaHltdk9PRTNS?=
 =?utf-8?B?bkdxREhnRm1TcEp6YzV3K3VYM0xEODdLT1JhcERrVjNPUkIvbWNENDU0MEEx?=
 =?utf-8?B?T1JhNzN3VkdtVmdOR0NPa25Gcm0rRVRPTWJjN2tjTWtXRW9FQjV0dG9BZTJx?=
 =?utf-8?B?V3hkSzZLZXFDSlByUkZ2NGU4dXZHZjlqc25TdGh0T28vQVJnZEwrSjZpQmV1?=
 =?utf-8?B?VVBWU0NvbnpybFBZeWtPOWtsVWZuZDRXTkUrMHMxRy9qYXd2YjhQL2UwL2M4?=
 =?utf-8?B?TXB5bktlbjRXa2NCWG05Q2ZvRHpJZG9qRVRzVGd4N0VlZWF1K0UrTUdaRjZY?=
 =?utf-8?B?dG1FVE1hZzlGS3p1WDFnbU92NTVhZzNjZHNIUHJ2QkpBSnd0U05JWTVWbUV0?=
 =?utf-8?B?aDNBWGltWThCNG1id2VYLzBwa1I4bkFrRmxuUUJydUk3UDJrSjhOUFVyVjdu?=
 =?utf-8?B?ZEx6dlVVZ1huUGh6dytKcjJ2TW80Q0UwVldnbGhTR3dFdFZLdVg4N0MrSlVa?=
 =?utf-8?B?NlVjQXRkKytjcGNLYzZua1FNUzRhNWs3MnJCOWs3eUVnVzZRbWdEUmpxTVB2?=
 =?utf-8?B?UkwxZitxNXNCeUpGdUVxUUpoSDJZM2hSa1JHVmo2UjJFMU9ZWlpQVUJBTmFE?=
 =?utf-8?B?VjE1UktqcW1LQzdrY05kanB4UlhDMDdqR05ybHhyMW9LWFlHQ0NyKzF1NXox?=
 =?utf-8?B?SHQvcW1aNDlpeE5nWUFmUnBIUno1ZzVtWnF4N3NIc3ZXR3NLYVNjNVZ6OUVp?=
 =?utf-8?B?NVVTZ2JaNkV1NjQrQWMyYkFNYWpIdnJGLzdpaDRhTElUcVFsdFJ2RVJuQ1dP?=
 =?utf-8?B?OGUyN1B3ampwei90Uy93QmZJZjgyNmt5UnF2a3I1QUM4bGZBZDJubTlKNXIx?=
 =?utf-8?B?UVNNZi8wNlRQY0pyYWVZZlBlSHRkK3RNSmJHSXFoeVlWblpkWE5ya2ZJV3lG?=
 =?utf-8?B?Q2poK2dFSzZLMHBvMWcxay9USytBVmZMZWxYYTVOcDZ4NzM1RXFkUTN4d3Rh?=
 =?utf-8?B?azFIb3FPdGtyZE0vM1BlZ0FuaWZ6Y3FWZmROdWZ3TzR6bW9DTlRkeUJjTjY2?=
 =?utf-8?B?RUNxYXhoa0p6TFpjM0lLVUNRM2RFcmh5V3FOV1JlRlNhN2FpbWxyV29iZm16?=
 =?utf-8?B?aWV1a0t5Z00vUjJaNXhmRFk2aGZUSmlFdy9vS0hxNm5ibGNUL0xyWnVDaVdN?=
 =?utf-8?B?T3hYdTZTK3VwZnU0WUh4OFFkaGVSYjhGVXR1SzVuK1dmV0hWWmw1STFMOGtK?=
 =?utf-8?B?a25YMTJITjRpMVF4bWNYWjdkZSt4YXdlRjhFdmZ2d3I4UEovTW9WMVpIRnRW?=
 =?utf-8?B?Y3ArUTJNdGJ2RFRnL3JLQTV6Rk5kTjFkOGovUVlqOE0yWkxpRkFVRjZiaDB2?=
 =?utf-8?B?b25OUmczQnJwdHhUUFNLdm5vYkJoZ2pOcHozSkQzQ1BPcURNbHNvOFd6SnZD?=
 =?utf-8?B?RzA4K2xKWlQ0dDJDWnE3bHFvUzMzVkNnZmVBSUhmeDZ3dXk0c1Z5OHk5dzhw?=
 =?utf-8?B?UWt0KzBsMU9nU2ZwZGlmdFoyL0drcGhwVWc4NERjZVFsUnhtWStlRFExYXVm?=
 =?utf-8?B?bUhVd3c2UC9TNjFEazBzUktvZEczYldYUTFGQ2VqaXFGdHlhVzZlTzhQcDZC?=
 =?utf-8?B?T0JxVVlWTnFWWnBFTTg2eHFIaGY2cEl2UFBpaEtjZ2hPUFpJU2k2bmppS1dE?=
 =?utf-8?B?UDl3OTV1dTJLYTBVVVFRb2REZUtkcmNtWDV2QnNiYnJ5MklKTHBJdkRoRDUx?=
 =?utf-8?Q?XVmjvXvXfbWg1XmKO1ShSB5ND?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe697b7-1a5f-4039-83bb-08dbc4ef33f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 15:33:05.0156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Sp98/AMv0P7K0P0dBsQrUBbe7dQv/juTOBOniI6FGErfeqV4SiJGLKItRAn1kJth7glofwH0ENgQJExfAvcf+n69I7FnngQXSTKqix3uOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7652
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPkhpIEl1bGlhLA0KPg0KPk9uIE1vbiwgT2N0IDIsIDIwMjMgYXQgODozNOKA
r0FNIEl1bGlhIFRhbmFzZXNjdSA8aXVsaWEudGFuYXNlc2N1QG54cC5jb20+IHdyb3RlOg0KPj4N
Cj4+IEZyb206IFNpbHZpdSBGbG9yaWFuIEJhcmJ1bGVzY3UgPHNpbHZpdS5iYXJidWxlc2N1QG54
cC5jb20+DQo+Pg0KPj4gVXBkYXRlIHRyYW5zcG9ydCBhY3F1aXJlL3JlbGVhc2UgZmxvdyBmb3Ig
QkFQIGJjYXN0IHNvdXJjZQ0KPj4NCj4+IC0tLQ0KPj4gIHByb2ZpbGVzL2F1ZGlvL2JhcC5jIHwg
MTYgKysrKysrKysrKy0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9wcm9maWxlcy9hdWRpby9iYXAu
YyBiL3Byb2ZpbGVzL2F1ZGlvL2JhcC5jIGluZGV4IA0KPj4gNDhhMWE0Zjg2Li45YTQ2YjE2YWIg
MTAwNjQ0DQo+PiAtLS0gYS9wcm9maWxlcy9hdWRpby9iYXAuYw0KPj4gKysrIGIvcHJvZmlsZXMv
YXVkaW8vYmFwLmMNCj4+IEBAIC0xMzI4LDYgKzEzMjgsMTAgQEAgc3RhdGljIHZvaWQgaXNvX2Nv
bm5lY3RfY2IoR0lPQ2hhbm5lbCAqY2hhbiwgR0Vycm9yICplcnIsIGdwb2ludGVyIHVzZXJfZGF0
YSkNCj4+ICAgICAgICAgZmQgPSBnX2lvX2NoYW5uZWxfdW5peF9nZXRfZmQoY2hhbik7DQo+Pg0K
Pj4gICAgICAgICBpZiAoYnRfYmFwX3N0cmVhbV9zZXRfaW8oc3RyZWFtLCBmZCkpIHsNCj4+ICsg
ICAgICAgICAgICAgICBpZiAoYnRfYmFwX3N0cmVhbV9nZXRfdHlwZShzdHJlYW0pID09DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCVF9CQVBfU1RS
RUFNX1RZUEVfQkNBU1QpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ0X2JhcF9zdHJl
YW1fc3RhcnQoc3RyZWFtLCBOVUxMLCBOVUxMKTsNCj4+ICsgICAgICAgICAgICAgICB9DQo+DQo+
UGVyaGFwcyBpdCB3b3VsZCBiZSBhIGJldHRlciBpZGVhIHRvIGhhdmUgYSBkZWRpY2F0ZWQgY2Fs
bGJhY2sgZm9yIGJyb2FkY2FzdCBpbiB0aGlzIGNhc2UsIHNvIHdlIGRvbid0IG1peCB0aGUgZmxv
d3Mgd2l0aCB1bmljYXN0LCBzaW5jZSB0aGUgaGFuZGxpbmcgaXMgcXVpdGUgZGlmZmVyZW50LiBJ
biBmYWN0IEkgd2FzIGdvaW5nIHRvIHN1Z2dlc3Qgd2UgY2hhbmdlIHRoZSBicm9hZGNhc3QgY29k
ZSB0byBsaXZlIG9uIGJjYWEgZHJpdmVyIHJhdGhlciB0aGFuIGJhcCwgc28gd2UgY2FuIG1vdmUg
dGhlIGhhbmRpbmcgb24gYWRhcHRlcl9wcm9iZS9hZGFwdGVyX3JlbW92ZSB0aGVyZSBpbnN0ZWFk
IG9mIG1lc3NpbmcgdXAgd2l0aCBiYXAuDQpZb3Ugc3VnZ2VzdCBtb3ZpbmcgdGhlIGJhcF9hZGFw
dGVyX3Byb2JlIGFuZCBiYXBfYWRhcHRlcl9yZW1vdmUgZnJvbSBiYXAgdG8gYmNhYSBhbmQgY3Jl
YXRpbmcgbmV3IGJhcF9zdGF0ZSBhbmQgYmFwX2Nvbm5lY3RpbmcgZnVuY3Rpb25zIGZvciBicm9h
ZGNhc3QgY29ycmVjdD8gTm90IG1vdmluZyBhbGwgdGhlIGJyb2FkY2FzdCBjb2RlIG91dCBvZiBC
QVAoc2hhcmVkXGJhcC5jLHNoYXJlZFxiYXAuaCkgYW5kIGNyZWF0aW5nIG90aGVyIGZpbGVzIGZv
ciBpdC4NCldlIHdpbGwgY3JlYXRlIGFub3RoZXIgcGF0Y2ggZm9yIHRoaXMgc3VnZ2VzdGlvbi4N
Cj4NCj4+ICAgICAgICAgICAgICAgICBnX2lvX2NoYW5uZWxfc2V0X2Nsb3NlX29uX3VucmVmKGNo
YW4sIEZBTFNFKTsNCj4+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+PiAgICAgICAgIH0NCj4+
IEBAIC0xODg3LDE4ICsxODkxLDE2IEBAIHN0YXRpYyB2b2lkIGJhcF9zdGF0ZShzdHJ1Y3QgYnRf
YmFwX3N0cmVhbSAqc3RyZWFtLCB1aW50OF90IG9sZF9zdGF0ZSwNCj4+ICAgICAgICAgICAgICAg
ICB9DQo+PiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+PiAgICAgICAgIGNhc2UgQlRfQkFQX1NU
UkVBTV9TVEFURV9RT1M6DQo+PiAtICAgICAgICAgICAgICAgYmFwX2NyZWF0ZV9pbyhkYXRhLCBl
cCwgc3RyZWFtLCB0cnVlKTsNCj4+ICsgICAgICAgICAgICAgICBpZiAoYnRfYmFwX3N0cmVhbV9n
ZXRfdHlwZShzdHJlYW0pID09DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQlRfQkFQX1NUUkVBTV9UWVBFX1VDQVNUKSB7DQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICBiYXBfY3JlYXRlX2lvKGRhdGEsIGVwLCBzdHJlYW0sIHRydWUpOw0KPj4gKyAgICAgICAg
ICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAgY2FzZSBCVF9C
QVBfU1RSRUFNX1NUQVRFX0VOQUJMSU5HOg0KPj4gICAgICAgICAgICAgICAgIGlmIChlcCkNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgIGJhcF9jcmVhdGVfaW8oZGF0YSwgZXAsIHN0cmVhbSwg
ZmFsc2UpOw0KPj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPj4gICAgICAgICBjYXNlIEJUX0JB
UF9TVFJFQU1fU1RBVEVfU1RSRUFNSU5HOg0KPj4gLSAgICAgICAgICAgICAgIGlmIChidF9iYXBf
c3RyZWFtX2dldF90eXBlKHN0cmVhbSkgPT0NCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQlRfQkFQX1NUUkVBTV9UWVBFX0JDQVNUKSB7DQo+PiAtICAgICAgICAgICAgICAgICAg
ICAgICBpZiAoZXApDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJhcF9jcmVh
dGVfaW8oZGF0YSwgZXAsIHN0cmVhbSwgZmFsc2UpOw0KPj4gLSAgICAgICAgICAgICAgIH0NCj4+
ICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAgICAgfQ0KPj4gIH0NCj4+IEBAIC0yMTE2
LDYgKzIxMTgsOCBAQCBzdGF0aWMgdm9pZCBiYXBfY29ubmVjdGluZyhzdHJ1Y3QgYnRfYmFwX3N0
cmVhbSANCj4+ICpzdHJlYW0sIGJvb2wgc3RhdGUsIGludCBmZCwNCj4+DQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICBlcC0+cW9zLmJjYXN0LmJpZyA9IHFvcy5iY2FzdC5iaWc7DQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICBlcC0+cW9zLmJjYXN0LmJpcyA9IHFvcy5iY2FzdC5iaXM7DQo+
PiArICAgICAgICAgICAgICAgICAgICAgICBidF9iYXBfc3RyZWFtX2NvbmZpZyhlcC0+c3RyZWFt
LCAmZXAtPnFvcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
cC0+Y2FwcywgTlVMTCwgTlVMTCk7DQo+PiAgICAgICAgICAgICAgICAgfQ0KPj4NCj4+ICAgICAg
ICAgICAgICAgICBEQkcoInN0cmVhbSAlcCBmZCAlZDogQklHIDB4JTAyeCBCSVMgMHglMDJ4Iiwg
c3RyZWFtLCANCj4+IGZkLA0KPj4gLS0NCj4+IDIuMzkuMg0KPj4NCj4NCj4NCj4tLQ0KPkx1aXog
QXVndXN0byB2b24gRGVudHoNCg0KSGF2ZSBhIG5pY2UgZGF5LCBTaWx2aXUNCg==
