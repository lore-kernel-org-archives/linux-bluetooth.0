Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FD0C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 19:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685D9619B1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Mar 2021 19:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbhCXTHC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Mar 2021 15:07:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:25612 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237780AbhCXTGy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Mar 2021 15:06:54 -0400
IronPort-SDR: IOpucKtWh2pH0VzeWpxqKlXLB4vI7sEs85o1dF9VVOLmSiAAcWxvBE6f33hlUdk2Mzt8ucYVf7
 rojvo5Ophreg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="252127673"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="252127673"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 12:06:53 -0700
IronPort-SDR: IvwNO1wQ32j+tBx4j0QgNp5GUAfO4phum8Fj4E0S1C3lLamkdPz9zsf3t1m0qFezYSzwyz180i
 07YE2Z0XND3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608211301"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga005.fm.intel.com with ESMTP; 24 Mar 2021 12:06:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 12:06:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 24 Mar 2021 12:06:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 24 Mar 2021 12:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIaPcHioLQOBF3k6efymrUeluaY3a7MysczMzmzMvNLCNLVkDwQaSv33sYQ+zZ5vLdDQN3ytAoRjkpM6FK6rbyqVmwPo0Nc/li5dHGNHxXjiflqaXbhurcVuCZorgA8JLziIjxdPRgOVPChsawrzdSlINMZiIRHO/gWIqswQzZAdTyckPCXNObFyhmIl8COvmPc+Z0ae03oeicJTO2gcT1Q3Vs+sCmmLpZFHkyX3A6worfHgH5lqt+XFS5oaqb5at833onOIINANqaql8MFo1v7NMtmcYLnJzjaFTA4Nfe+q/NnNquufXa2K59rmY5WXH6gZFJ6OdBGNwgjbt48V3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwAjczFUM+t+9eigsG0XFhOGX9v6Zayyg/E0x3s6u2I=;
 b=iXz4SKAqzuxVnvMXj+iolzSBsCTussVe7F+rNvI0EbtvK1M2fBDUkwCjxmy3QiNlYhvKcHaLTIHPp+dTSmwu9A00MA4yZItXughDCyVnLDS9yeg+iGroq1OvPLQE1QJpk7vN3B1zlb/BVzDhoBKhq6/Z/8nu7MR0m4qL7HQbW75a6VbcDKla/aF1z0qrz1klf8cMud7gnktVV5bmyjVN8oOY7lnCKNe5+CGAXi3DUPq1V3bM1wKyKSSJaYhmjNnVJzA0KLq+yWLf9uFM+0AqsGbfuSJM9t93HIaFLTT11LhhTYDOn3NQ8zX+TOPw4EewjSm3l8Rg09QjHbXZb/mkDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwAjczFUM+t+9eigsG0XFhOGX9v6Zayyg/E0x3s6u2I=;
 b=kzIgj8Jhh3hh1NA/SSFvfzmLVJ1PwM5n7jCjLHbaiSkAPYl32w2RQWwy0FuUxy3LT3RHlaykzrx4/duGHJUkA/On065OAmuLMVby3Sje4SFUp04WDG3V3dxoyjcmmD0SA4aYk+j1Hnb246vs3V6UBgHkiAdR3YbErPdPpgmuVvI=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB0015.namprd11.prod.outlook.com (2603:10b6:301:66::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Wed, 24 Mar
 2021 19:06:51 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::a995:ea7a:29cf:d212]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::a995:ea7a:29cf:d212%5]) with mapi id 15.20.3977.024; Wed, 24 Mar 2021
 19:06:51 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v10 1/9] Bluetooth: btintel: Check firmware version before
 download
Thread-Topic: [PATCH v10 1/9] Bluetooth: btintel: Check firmware version
 before download
Thread-Index: AQHXIBa6NZ6Tvo4t+0iqq6OPeq6DCaqRlyeAgAEgoICAAFRkgA==
Date:   Wed, 24 Mar 2021 19:06:51 +0000
Message-ID: <96233C8A-CB19-4EF3-B870-CBF1CB7389A7@intel.com>
References: <20210323185904.3372987-1-luiz.dentz@gmail.com>
 <0702034E-2AC9-4AB3-89F1-0E282650F7D8@intel.com>
 <E1C1EF65-F692-41A1-86FD-7CA3485ECAB9@holtmann.org>
In-Reply-To: <E1C1EF65-F692-41A1-86FD-7CA3485ECAB9@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.45.21011103
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.115.118.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7335b5e5-65bf-4f00-e7d0-08d8eef7fb87
x-ms-traffictypediagnostic: MWHPR11MB0015:
x-microsoft-antispam-prvs: <MWHPR11MB0015D7E38373F846279473A2FF639@MWHPR11MB0015.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f65U+UM/5vTC7kmYj9E0mOCofb/Mvm+upp462V+gNeM0EJ5Ipd7wzj+9JbqYe3v+sJiTeqeLANt+V7AWL4p6VY7UQ3rUOOwgaJkvqYuB34d8Ogo0vMkdKsXX5mub+jOEMLoSZylrZV/MWxZ0TuDit3/F1B7ZEHE2ApdzOpmtvnSg24v2+d3OLj5hQghthSR6F5u5CfmQuH2OSXdMZugmHemSxMkKABSWUgGfO58yBF1Ql2gVAUpECwGTIu+QefGHZJjRAyUU6uR+bPs39zEUjG5cUt9Xzpw9m093XsfDtIQlp3tfDD2D9RH4MlvUUVcCP9scSHARk/fO5jXlXP5BgPgHS9Tvw6cWjgUgpz+LWRaji7tDeIRtEZCHWnOtZQDH0bNGDF778x1UsDsdX6I+u89Qjj84BrTUMoR3paXTZLQJKhSM8Eo8NQA4eNokKdn8/jlh5TTX+tEvinkkW8xfqArBxRAOOPXU71R+MfBBIC4+UaPHd107tlT7fPRb2uilqO2h/ZrORTYkLTleKTUm+S7rMoytIIiXDEqsT836s5ukK6JIQncpx2/wGIA4QNF7JtQ4BtPKoKDtvrV6Tt3kPpTxyaqdLilo7WrvyTdRg19DN1M8sRbWxcjEmWwIHVQnqf83B+w+JJ+/4/Y0ewF2i2uwujutN8KJXMh01GtLYnKfpjev/Qi6GhXvLLUrIJXr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(396003)(376002)(6486002)(66946007)(6512007)(66476007)(66446008)(83380400001)(6506007)(64756008)(76116006)(2906002)(4326008)(66556008)(53546011)(2616005)(186003)(71200400001)(33656002)(54906003)(38100700001)(316002)(86362001)(5660300002)(8936002)(36756003)(26005)(478600001)(8676002)(6916009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?U1dqamMrWC9jV2NOVnN1YmRDLy9EM01LWmMyZUZUVkJMZDFJODFBK3RlMHJD?=
 =?utf-8?B?WmliSVVvYWNzMUtVcG5QaXFWNS9HVElETnNzdGt3U0JVaG4yVUQrbzJVOEkv?=
 =?utf-8?B?eWFaaUtqcThxaEc5SU03b09hRWhsTThaTTB3K0kwTzhlQTYraUhyZGFnamhN?=
 =?utf-8?B?Z2w0MUxFS3UxVVRUSlUrL1lhbFQ3T0hWNVFVRHphK2FqYk1PT0RMMWQ0SEo0?=
 =?utf-8?B?RGVlRWJiR1hId0szdWlXYU15M0o4UG0wSk5icEVJUTBIeHBNNzZYWGNUZVRl?=
 =?utf-8?B?M1NmY2g4S1dtZFhKckV1VCtQSzl1MGdOcHFKT3JjTndjREJ0dFhmdkNwYi8x?=
 =?utf-8?B?Z2xuVGcydnZaVUk2dXRITHV2NHV4enVOUHRma2MwUnhoRFNiMzRHUFpCTWNY?=
 =?utf-8?B?dExWMEkrN3dSdmgxSWREajJJaUFKaDZqTnVUVWkvNXVreXVuSThOcTlGL1lU?=
 =?utf-8?B?bDEzalZSU08yY0txV215UjNWZHVNU3NMbi8xVkV5TllTb0VZQU9IcytwQ1gv?=
 =?utf-8?B?WTU0MjBBUHRzRytzdXNnS01PT055L2xKUE55ejV5d1lZYkxVS085S1hoUDRC?=
 =?utf-8?B?TVdBejR5VUhIbm5CdjhZV1EwUzM5WG8wejRzVGNZbVpZYnl1Q0dRRkozcm1N?=
 =?utf-8?B?RGdaU2JWRitUTlpLbkZXN3A0VURGeTZqVlRCNzF6NXkva1I3WTBmUHlHSDFN?=
 =?utf-8?B?Z0JxZmhwMmJOa1RhZWhkWFhjK05ibmpxOTdMSGYyNElscUNvSERnL05aWVlk?=
 =?utf-8?B?V05OVkxROWc5NFlETi9PN2FHVllCY01NWXRkTFFxYUVRM0IwbGNFY1hCamZ6?=
 =?utf-8?B?Lzl1aVE5bEpEaExsbXFDR2w0aGNISWNDYXdHTW1zbVJlS0c5N1VxTTBpR2JY?=
 =?utf-8?B?MG1ZUmRqRjkva3dYUU91VlB4b08yOGM3UVRRSVQxM3IvT2g3U255QWp0RVRx?=
 =?utf-8?B?OVRkRHlVd1pINm9ONnFyeGI4c3NOQ09aTitZWDVoV0NPYThvOFd6d0pmc3hM?=
 =?utf-8?B?NXU5M2VHajZTQjVWQzA0L3dCb2hWVUVIb2lnMEZyR2xzZU1lTnJlanFlbjl5?=
 =?utf-8?B?RUw4SWtDY214NUh0SnJMVjJESTdVVFg2QmZWVzhIRkh5dW1aSWZIRzEvT2dZ?=
 =?utf-8?B?bkQ1a281TnN4MkRvM0JHVitkQmNlNGRpZEpUekt5S3I4OVFvbzN0RDd4NGI2?=
 =?utf-8?B?QnlRZzJXaXdzMXB1TlNBeThqVk5WUHlOZ0g3NWlsOTAya2lVeUY3RUY4UmpK?=
 =?utf-8?B?TkZCV1dpcW9rS0pQT1QweWZXNlUvTis3RUlCOTdDdHhwbzEvUU4zNWtaSjFQ?=
 =?utf-8?B?dDRMYitPZDNzRkp2cXpiM2d6ZitYSkd1RXovOHRlZzVxMnplVWhZb1RVOHAz?=
 =?utf-8?B?VXh0UDUyM3liSTZsQ0lKZE9IVy9WdWRpOFREMFh2WTZXSVNDSVBxU2lwZWJu?=
 =?utf-8?B?ZmZGWEo4ZTF5c1NvRzlKMTFWaHFCcE9jbm01RkthVGk4VEpNWFUyS1FtYnhP?=
 =?utf-8?B?Vjd1Nms0T29wNy9QcnQ3cTFUVUZxYTA4UkQ3bkNpSVZhN1VCTTA5Qmo4Z21E?=
 =?utf-8?B?QmdMZGhOMXlPN0VGLzdUbUZTTVJmaW5za3JnKzUxZE5wMjJUSlQ1a01YRy9h?=
 =?utf-8?B?MG1tWERKRG52bFlmNlREYlNvQUFXTDB6cFdzWWtVaVI4OCtmVGNReWJUbzMv?=
 =?utf-8?B?NnRVZVhVb1Z4U2d5WlVHd1p3aHFTazVnQUE1NHY4cmE2aXExWXpvL0xnaFIx?=
 =?utf-8?Q?/bX7//k6waSOetebN9DIViSCKcd5Cd8+2hQq75W?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <004F140681304347A47154CEFDA8F68A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7335b5e5-65bf-4f00-e7d0-08d8eef7fb87
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 19:06:51.6548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +TVFtQ44/fnaq6eaYlVugoMOY7xRTAERjbAwo+UmKSB8R3kSQrVR1XAOF4qbsp51QXYhSAQAPaF06UkIzxttrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0015
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQrvu79PbiAzLzI0LzIxLCAxMjowNSBBTSwgIk1hcmNlbCBIb2x0bWFubiIg
PG1hcmNlbEBob2x0bWFubi5vcmc+IHdyb3RlOg0KDQogICAgSGkgVGVkZCwNCg0KICAgID4gT24g
My8yMy8yMSwgMTI6MDAgUE0sICJMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IiA8bHVpei5kZW50ekBn
bWFpbC5jb20+IHdyb3RlOg0KICAgID4gDQogICAgPiAgICBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9u
IERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+DQogICAgPiANCiAgICA+ICAgIFRoaXMg
Y2hlY2tzIHRoZSBmaXJtd2FyZSBidWlsZCBudW1iZXIsIHdlZWsgYW5kIHllYXIgYWdhaW5zdCB0
aGUNCiAgICA+ICAgIHJlcGVjdGl2ZSBsb2FkZWQgdmVyc2lvbi4gSWYgZGV0YWlscyBhcmUgYSBt
YXRjaCwgc2tpcCB0aGUgZG93bmxvYWQNCiAgICA+ICAgIHByb2Nlc3MuDQogICAgPiANCiAgICA+
ICAgIFNpZ25lZC1vZmYtYnk6IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6
QGludGVsLmNvbT4NCiAgICA+ICAgIC0tLQ0KICAgID4gICAgdjI6IEFkZCBwYXRjaCB0aGF0IG1v
dmVyIGNoZWNrcyBmb3Igb3BlcmF0aW9uYWwgbW9kZSBhZnRlciB0aGUgdmVyc2lvbg0KICAgID4g
ICAgY2hlY2tpbmcuDQogICAgPiAgICB2MzogRml4IG5vdCBjaGVja2luZyBmb3Igb3BlcmF0aW9u
IG1vZGUgYmVmb3JlIHVzaW5nIGJ0aW50ZWxfcmVhZF9ib290X3BhcmFtcw0KICAgID4gICAgc2lu
Y2Ugc29tZSBtb2RlbHMgZGVwZW5kIG9uIHRoYXQgdG8gY29udHJ1Y3QgdGhlIGZ3IGZpbGVuYW1l
LiBBbHNvIGF0dGVtcHQgdG8NCiAgICA+ICAgIGNsZWFudXAgZHVwbGljYXRlZCBjb2RlLg0KICAg
ID4gICAgdjQ6IEZpeCBmb3J3YXJkaW5nIC1FQUxSRUFEWSB3aGVuIGZpcm13YXJlIGhhcyBhbHJl
YWR5IGJlZW4gbG9hZGVkLg0KICAgID4gICAgdjU6IEZpeCBub3QgYWR2YW5jaW5nIGZ3X3B0ci4N
CiAgICA+ICAgIHY2OiBGaXggYnR1c2Jfc2V0dXBfaW50ZWxfbmV3X2dldF9md19uYW1lIGVycm9y
IGNoZWNraW5nIGZvciBkZGMuDQogICAgPiAgICB2NzogRGlzYWJsZSB2ZXJzaW9uIGNoZWNraW5n
IGZvciBXc1AvU2ZQLg0KICAgID4gICAgdjg6IFJlYWxseSBkaXNhYmxlcyB2ZXJzaW9uIGNoZWNr
aW5nIGZvciBXc1AvU2ZQLg0KICAgID4gICAgdjk6IFJlaW50cm9kdWNlIGJvb3Rsb2FkZXIgY2hl
Y2tzIGFuZCBhZGQgd29ya2Fyb3VuZCBmb3IgdmVyc2lvbiBjaGVja2luZyB3aGVuDQogICAgPiAg
ICBvcGVyYXRpb24gYW5kIHZlcnNpb24gY2Fubm90IGJlIHJlYWQuDQogICAgPiAgICB2MTA6IEZp
eCBidWlsZCBlcnJvciB3aGVuIEJUX0NPTkZJR19JTlRFTCBpcyBub3Qgc2V0Lg0KICAgID4gDQog
ICAgPiAgICAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jICAgfCAxMDYgKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLQ0KICAgID4gICAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50
ZWwuaCAgIHwgICA1ICstDQogICAgPiAgICAgZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyAgICAg
fCAgMTggKysrKystDQogICAgPiAgICAgZHJpdmVycy9ibHVldG9vdGgvaGNpX2ludGVsLmMgfCAg
IDcgKystDQogICAgPiAgICAgNCBmaWxlcyBjaGFuZ2VkLCAxMDkgaW5zZXJ0aW9ucygrKSwgMjcg
ZGVsZXRpb25zKC0pDQogICAgPiANCiAgICA+IEkgZGlkIGEgcXVpY2sgY2hlY2sgd2l0aCB2MTAg
YW5kIGFsbCB0ZXN0cyBwYXNzZWQvZXhwZWN0ZWQuDQogICAgPiANCiAgICA+IFRlc3QgU2NlbmFy
aW9zOg0KICAgID4gQ29sZCBib290OiBFeHBlY3QgdG8gZG93bmxvYWQgZmlybXdhcmUNCiAgICA+
IFJlYm9vdDogRXhwZWN0IG5vIGZpcm13YXJlIGRvd25sb2FkaW5nIA0KICAgID4gRlcgdXBncmFk
ZTogRXhwZWN0IHRvIGRldGVjdCBmaXJtd2FyZSBjaGFuZ2UgYW5kIGRvd25sb2FkIG5ldyBmaXJt
d2FyZS4NCiAgICA+IA0KICAgID4gVGhQLCBUeVA6IEFsbCAzIHRlc3RzIHBhc3NlZA0KICAgID4g
V3NQLCBTZlA6IENvbGQgYm9vdCwgUmVib290IHBhc3NlZC4gRlcgdXBncmFkZSBkaWRuJ3Qgd29y
ayBkdWUgdG8ga25vd24gaXNzdWUuDQogICAgPiANCiAgICA+IFRlc3RlZC1ieTogVGVkZCBIby1K
ZW9uZyBBbiA8dGVkZC5hbkBpbnRlbC5jb20+DQoNCiAgICBzbyB0aGUgdmVyZGljdCBpcyB0aGF0
IHdlIHNob3VsZCBnbyBhaGVhZCBhbmQgYXBwbHkgdGhpcyBzZXQ/DQoNClllcywgaXQgaXMgZ29v
ZCB0byBnby4gDQoNCkkgYW0gc29ycnkgdGhhdCBJIHNob3VsZCBiZSBtb3JlIGNsZWFyIGluIG15
IGxhc3QgcmVwb3J0LiBUaGUgYmVoYXZpb3Igb2YgV3NQIGFuZCBTZlANCnJlbWFpbnMgdGhlIHNh
bWUgd2l0aCBvciB3aXRob3V0IHRoaXMgc2V0LiBXc1AgYW5kIFNmUCB3aWxsIGJlIHVwZGF0ZWQg
dG8gbmV3DQpmaXJtd2FyZSBvbmx5IGFmdGVyIHRoZSBkZXZpY2UgcmVzZXQgdG8gdGhlIGJvb3Rs
b2FkZXIgbGlrZSBhIGNvbGQgYm9vdC4NCkZvciB0aGUgbmV3ZXIgZGV2aWNlcywgdGhpcyBzZXQg
d2lsbCBkb3dubG9hZMKgdGhlIG5ldyBmaXJtd2FyZSBldmVuIHdpdGggYSBub3JtYWwgcmVib290
Lg0KDQpJbiBjYXNlIG9mIFdzUCBhbmQgU2ZQLCB0aGUgY3VycmVudCBmaXJtd2FyZSBmaWxlcyBm
b3IgdGhvc2UgdHdvIGRldmljZXMgZG9uJ3QgaGF2ZQ0KdGhlIGNvcnJlY3QgZmlybXdhcmUgZmls
ZSB2ZXJzaW9uIGFuZCB0aGVyZSBpcyBubyB3YXkgdG8gdGVsbCB0aGUgZGlmZmVyZW5jZSBiZXR3
ZWVuDQp0aGUgZmlybXdhcmUgbG9hZGVkIGluIHRoZSBkZXZpY2UgYW5kIGluIHRoZSBmaWxlLiBT
bywgdGhpcyBzZXQgZXhwbGljaXRsecKgZXhjbHVkZXMgdGhvc2UNCnR3byBkZXZpY2VzwqBmcm9t
IHRoZSBmaXJtd2FyZSB1cGdyYWRlLg0KDQoNCiAgICBSZWdhcmRzDQoNCiAgICBNYXJjZWwNCg0K
DQo=
