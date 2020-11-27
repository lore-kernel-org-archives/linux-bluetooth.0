Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB807C63777
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF7A221FF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Nov 2020 08:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgK0Inc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Nov 2020 03:43:32 -0500
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:18432
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbgK0Inb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Nov 2020 03:43:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AM+M9wAHQNyclQ5U91l4Awm3PST2XXUPIqCAhBcSl9cKovPf1dku6pKcPvBZa4eOu9M6y2p0Yq/Jm5lFsxi4cSroWdTUANWz3qi4jb01BGR/wMlfovGafg3k3VeHnSjxR2az7B1I96UckqqcskKwKmn6KQSKqPpFrqHvx1N8YuBGenAdR37r8hmx3UdD+h5hQE7n+vrhFaq00EZOSjsn56feSNuS/p7ux+QioWoarDASj2NBJqrVuQUmxWFi2w+vtwmaoflUUqF5gNR83R0iu4hcGQhnXHNO8x30kbQ0eKU8KipnYHXVRiiJVnczqjgWmocISU5rxBaHI+ix4TeK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOtgDaPjzEMhNsPAAMCRTlOW+fMh3gYATttTk9mxkKA=;
 b=lhBfESJhO67ReBUha9KhkLHeD7UHUvYxxU1v15RvB1EjJfeT9SnRsPPTD6oUMpbTXPhwmSkxNhtEYnzLWozeLX1iJ5Rcx9FVrUm9Gm9+tEDo2ozY+xoJ09yc0L1X1WzYSqH269SYIjWuMsTy+5TnN+gfxQr7QawXltnNRaeKOZ7YZvQBeyCCfWR3m/8BLH9Z+663zsoYt2Vr8j5BaTSR7KpxOvanFc4INYzGdWyV/ZXEl/EimO2QY1O25rooMIuN0hazxlMKvrqcNS9WGjVYmPNVmCzvNKf0Pb8rXhebxb7RXCkwRrek/vh+l2WylTWvKXhNNmz8MqXMYQ0GsL4EOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lairdconnect.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOtgDaPjzEMhNsPAAMCRTlOW+fMh3gYATttTk9mxkKA=;
 b=3C/ya1BbXLPmsO+IH72yx6So9u0wLKv8fj14L85an9MJyzndudXZphpmETE8/jBbEXNhGMU6YdhWUAyZkVeDkjPnshaA3kRUCtTLyx5O9uP9qIHKpDvfl41A2wGbryW5SA1eenhcnVIHUCtJcnlJzcXpBlOx45g6xWWNdMEqNKG5EnEJv5Z4ISeSuwNANw4Cei106Y9bQi56S21c7OUdIR67/EgksGzvuJqZKp6dyEN8T9rPfzZ/O0tkv5tBx1YaLBT+cjkJnZxn16EqeH3jPKEzCkqfJRWsi88abg+WlnYg2mH2czuE2mdar1qlh5guCFiDYjwkLL40KzMQ5zaHlQ==
Received: from BYAPR14MB2887.namprd14.prod.outlook.com (2603:10b6:a03:15c::18)
 by BYAPR14MB2311.namprd14.prod.outlook.com (2603:10b6:a02:b5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Fri, 27 Nov
 2020 08:43:26 +0000
Received: from BYAPR14MB2887.namprd14.prod.outlook.com
 ([fe80::9c28:3dfc:a99d:f617]) by BYAPR14MB2887.namprd14.prod.outlook.com
 ([fe80::9c28:3dfc:a99d:f617%7]) with mapi id 15.20.3589.022; Fri, 27 Nov 2020
 08:43:26 +0000
From:   Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
To:     C K <choongbeom@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: =?utf-8?B?UkU6IEJsdWVaIOKAnFBpbiBvciBLZXkgbWlzc2luZ+KAnSBvY2N1cnJlZCBl?=
 =?utf-8?Q?ven_though_it_has_already_been_paired?=
Thread-Topic: =?utf-8?B?Qmx1ZVog4oCcUGluIG9yIEtleSBtaXNzaW5n4oCdIG9jY3VycmVkIGV2ZW4g?=
 =?utf-8?Q?though_it_has_already_been_paired?=
Thread-Index: AQHWxIk3oVNErZUxnEGPD0fyOyGHVqnbqKoQ
Date:   Fri, 27 Nov 2020 08:43:26 +0000
Message-ID: <BYAPR14MB288775932E88E9B5CDF3A653E6F80@BYAPR14MB2887.namprd14.prod.outlook.com>
References: <CAO9gXyRLOk75wdTWO_cAu1e=w82H1b_fWB=hLpHcJYcv2MHQDg@mail.gmail.com>
In-Reply-To: <CAO9gXyRLOk75wdTWO_cAu1e=w82H1b_fWB=hLpHcJYcv2MHQDg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=lairdconnect.com;
x-originating-ip: [81.139.205.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99292d0b-c532-4021-93ba-08d892b081b7
x-ms-traffictypediagnostic: BYAPR14MB2311:
x-microsoft-antispam-prvs: <BYAPR14MB2311987FE0E0BA69D38B39A6E6F80@BYAPR14MB2311.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y3Pgj2kdAspLUTbmmyy6mouasPLGmkXgBFkbOIrtbwAkKPQ0dUDpB1IC9rJU5wZLdeOVXhZio3iz3pGcEh3YVT/2cZxqh4lj9ffJ9nDjkKuhy856SsR+4W5YQSQbl+4Wrcs/nscXHaQYjE6eSMEn6fVxzXOPtf4Q8FRL8LeaC59NYDfEFJ0rztYJ6TvNCSjuCKgiAeBdPJGlZw1vxQInGKoYNpzCqKHxBGQfWhU7qt3WVZvxCiJhmTSK2kba21vUKdAzszfkA8UPJIB67ukzu8S5Jn7vRlyJ/tu1WPcJjf0OocYyTMuzZhfblL51wL0bT9LsF6RG2r0KCXM+c0Ddaz8LYN/2LC8D2B0qF/8NHSTPtzbd4iBQWhRu5hW6XrFfD3o22LuRikb38CWo2VjbTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR14MB2887.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(376002)(136003)(366004)(66556008)(316002)(6506007)(66476007)(64756008)(66446008)(7696005)(110136005)(76116006)(33656002)(53546011)(966005)(478600001)(8936002)(66946007)(26005)(2906002)(83380400001)(9686003)(5660300002)(55016002)(52536014)(71200400001)(86362001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OGVkTlZVNTIzV1NPYlQ0Y0ZHYjhuUTBqRW5ZcWN6cHZyV1FIUWVuSXdLbmRm?=
 =?utf-8?B?N05vaTBLRE5pRTI2UzVRN2xTcStxTzZuRmo0K08xbHdrTnA4L2E0QStnMVVa?=
 =?utf-8?B?RDBweUVDMVh1NElNVHNna2VQdlA4VXU5MTlqNVdTc1hOR0ZRWnV3Q1lldUJD?=
 =?utf-8?B?YnBPbjZHSDI1SDZFSjNCeC9acU1xU2QyL1JHakVnTks0K3V6RlhNTzVmZzJ0?=
 =?utf-8?B?Wlg1SmxrUjBibXBPWjBoNFhGdDhKekdHWjJOWEtVL3ZzYUtmZTg5ZmFvSlhX?=
 =?utf-8?B?SHBvMmhxVHh6VDlxZ25aUnh2OUxjay81Z3VyTThJb21oUittQzYyZzBSekwv?=
 =?utf-8?B?VldvdnVzUHE1UFBrZjVLYVg5YXMwbmlsdUlTY1JMSGt1SmNUOU9ZVW9EaTA2?=
 =?utf-8?B?a0xneS9jb0hwaWUzbEVNYUg1VmUxTWxPUldPYnllV2lxMEFpbWZtQXZoYTUv?=
 =?utf-8?B?NTBNOTJyaU1QZWl3ajcrUmU3L2dvUEltWWYzTDhHaDJXTXp1dW9DSXN0eG9k?=
 =?utf-8?B?eEUrWkZ6aWFUSVloa2E5M3k3MjU1SFo3WG10ckc0Szd3UVBBTVFOQmF6N3RC?=
 =?utf-8?B?Ty9yblNvU1NtY1gyKy8vbUlyMVd1L2VYS2IzNDUrOXVDdDZKemVJSksyU2ZQ?=
 =?utf-8?B?UzVFS1hRb1BGZElhcWtrVWlKZS9HV2VPRHBZWU94dU56emd3RmtUK2F2M3pq?=
 =?utf-8?B?SjRET3MwU3AzeTE4WHRqK0M0M3d0UVFRd3RlUVh3cnZUdDV6ZlVSVGlHZ29E?=
 =?utf-8?B?ZjZubStVc0RlMm85QXo3U0lWaUxMdGtiSFFKclJVSDU0N25WZjdWRmVSeWtC?=
 =?utf-8?B?aVdtQS9DMi82a2lzbEJ3WVh2aTBGSTJhcURaQzJqUVk2TFNxRVhnODBBTitQ?=
 =?utf-8?B?QzMvVVp5NXZBR2dTSUxhSDRFMVFWTWx5djluS0UwQVlUcEpvVkk1VDI4alMr?=
 =?utf-8?B?aFZ6bkh0YkRwNkdxdDg0VTRNdStJWE5iOU5sQnhDcUhmeUo1a2JZK3FpbjNN?=
 =?utf-8?B?OWNzLzRkZnFSSEFOTVJtUmg1a1lZcWRRYUlxZ0MwUEZaRW5OU3NCSU9oRTFO?=
 =?utf-8?B?VytDYUtJOHp3bmtha1d0elN4L3ZsOG5YV0F5NHZJeTk4TER2VkwwVVJzSmNR?=
 =?utf-8?B?eWkvNG5vM2ZWSHEva0hBc3MwYmwzbVBpVkMwcEJtRGREY3crZjk1L2p6ZGRE?=
 =?utf-8?B?c01ESEEwY3l2MkV0TVFUbzg1M0t6b09TK3FSR21SYjg0QzJVVURTRDB3QzI4?=
 =?utf-8?B?b2UyTXYxRDBWblloK2ZaS0VDVTBBUXNrYjNvR3BhUGlPZ0RzSElIK2s2V25D?=
 =?utf-8?Q?JzdZM44++Ts68=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR14MB2887.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99292d0b-c532-4021-93ba-08d892b081b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 08:43:26.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNKzN9UaIJJJz6Dmn8XszQ1mapMqOVYNGGLfVAvoVzQe98FD8j1IJJT6UZOMAOElAaBJO7n4r4N0saBRekkAARe5cuHQXUaaOhRwb9k9cHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR14MB2311
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQ2FsdmluLA0KV2hhdCB0eXBlIG9mIGFkZHJlc3MgaXMgaXQ/IElmIHRoZSBkZXZpY2UgaGFz
IGEgcmFuZG9tIHJlc29sdmFibGUgYWRkcmVzcyB0aGVuIHRoaXMgbWVhbnMgb25jZSB0aGUgZGV2
aWNlIGhhcyBwYWlyZWQgYW5kIGV4Y2hhbmdlZCBJUksgdGhhdCByZWdhcmRsZXNzIG9mIHdoYXQg
cmFuZG9tIHJlc29sdmFibGUgYWRkcmVzcyB0aGUgZGV2aWNlIHVzZXMsIHRoZSBvdGhlciBkZXZp
Y2Ugd2lsbCBhbHdheXMga25vdyB3aGF0IHRoZSBkZXZpY2UncyB0cnVlIGFkZHJlc3MgaXMgYW5k
IHdpbGwgdXNlIHRoZSBjb3JyZWN0IGVuY3J5cHRpb24ga2V5cyBhbmQgZGV0YWlscy4gSWYgdGhl
IGRldmljZSBoYXMgYSBkaWZmZXJlbnQgcmFuZG9tIG5vbi1yZXNvbHZhYmxlIGFkZHJlc3Mgb3Ig
cmFuZG9tIHN0YXRpYyBhZGRyZXNzIHdoaWNoIGNoYW5nZXMgdGhlbiB5b3UgY2Fubm90IG1hdGNo
IHRoZXNlIGFnYWluc3QgYSBwYWlyaW5nLg0KVGhhbmtzLA0KSmFtaWUNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEMgSyA8Y2hvb25nYmVvbUBnbWFpbC5jb20+DQpTZW50OiAy
NyBOb3ZlbWJlciAyMDIwIDA2OjQ2DQpUbzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9y
Zw0KU3ViamVjdDogQmx1ZVog4oCcUGluIG9yIEtleSBtaXNzaW5n4oCdIG9jY3VycmVkIGV2ZW4g
dGhvdWdoIGl0IGhhcyBhbHJlYWR5IGJlZW4gcGFpcmVkDQoNCkVYVEVSTkFMIEVNQUlMOiBCZSBj
YXJlZnVsIHdpdGggYXR0YWNobWVudHMgYW5kIGxpbmtzLg0KDQpIZWxsbywNCkkgaGF2ZSBhbiBp
c3N1ZSB3aXRoIG15IGJsdWV6IGRldmljZS4NCkkgZXhwbGFpbmVkIGl0IG9uIHN0YWNrb3ZlciBm
bG93Lg0KSGVscCBtZSBhYm91dCB0aGlzIHBsZWFzZS4NCg0KaHR0cHM6Ly9zdGFja292ZXJmbG93
LmNvbS9xdWVzdGlvbnMvNjUwMDE4OTEvYmx1ZXotcGluLW9yLWtleS1taXNzaW5nLW9jY3VycmVk
LWV2ZW4tdGhvdWdoLWl0LWhhcy1hbHJlYWR5LWJlZW4tcGFpcmVkDQoNCg0KVGhhbmtzLA0KQ2Fs
dmluDQpUSElTIE1FU1NBR0UsIEFOWSBBVFRBQ0hNRU5UKFMpLCBBTkQgVEhFIElORk9STUFUSU9O
IENPTlRBSU5FRCBIRVJFSU4gTUFZIEJFIFBST1BSSUVUQVJZIFRPIExBSVJEIENPTk5FQ1RJVklU
WSwgSU5DLiBBTkQvT1IgQU5PVEhFUiBQQVJUWSwgQU5EIE1BWSBGVVJUSEVSIEJFIElOVEVOREVE
IFRPIEJFIEtFUFQgQ09ORklERU5USUFMLiBJRiBZT1UgQVJFIE5PVCBUSEUgSU5URU5ERUQgUkVD
SVBJRU5ULCBQTEVBU0UgREVMRVRFIFRIRSBFTUFJTCBBTkQgQU5ZIEFUVEFDSE1FTlRTLCBBTkQg
SU1NRURJQVRFTFkgTk9USUZZIFRIRSBTRU5ERVIgQlkgUkVUVVJOIEVNQUlMLiBUSElTIE1FU1NB
R0UgQU5EIElUUyBDT05URU5UUyBBUkUgVEhFIFBST1BFUlRZIE9GIExBSVJEIENPTk5FQ1RJVklU
WSwgSU5DLiBBTkQgTUFZIE5PVCBCRSBSRVBST0RVQ0VEIE9SIFVTRUQgV0lUSE9VVCBUSEUgRVhQ
UkVTUyBXUklUVEVOIENPTlNFTlQgT0YgTEFJUkQgQ09OTkVDVElWSVRZLCBJTkMuDQo=
