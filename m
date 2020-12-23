Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22D8C4360C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92164233FA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Dec 2020 15:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbgLWPl5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:41:57 -0500
Received: from mail-bn8nam08on2082.outbound.protection.outlook.com ([40.107.100.82]:31200
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729279AbgLWPlz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Dec 2020 10:41:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn7ykjKw40V8J9pcEv7hfZCZ+4SG1oLnycMlCO14aWyBgU1k0vCdlnNwWBXNKRVVRHujVrVtodUwHZT6DfxRHyaI3ok+XLoP3lanQpMNGZbbC+TQ3Vg+CtYTsaBiSjz7VtvozqL8ZXYVSLADraGjF7QLKTyKQb8ZcL84AKqVVfMPxKCbwNz9pWbd2XRfquryI94CSL6E21/KLxjHocWLxu7NBO4SJhPLkQl+TrZEU3Rq7oCyQnYpFOpZIDjD/KD68BfZEqbUiwc+bUx7Z79k6AhG9sq8Wt6VEN1wJEHKqBI7kUdJrLDJtma41Y14y4xTQs9qUJumn4fSnpD9Smx8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRCtUmAFxcpcdREd+zS/+wdn7ksFg6T+zkmTanCZPrc=;
 b=hiHCzUBqnvN6KEVyOq0WSavSbauWsQY/nuUorK4IC8GjvfKTQZcXWZmRSuuEpNUStA81OsmlS/8cUL4ViYhvSHGsa/4JpxZGlcmHO7F/ksApIyTAXei9BrLYiWAxSb+WoIANuieEKLtaYC2F1jgRSlVQf6mYhHefHnLxY05chgVo4OCZ5fUizlb7btOGaXEKEK72s2DFGkOhEbhPvF0nIoPYzdQhXnOWGw2AXx12Tw4OlziBMAmRMzbkJwdZfsqrQnvKMlnLaHNj/GtJdiNp4I4P4P+e1Pu0Zv0oelcFDjGc1XFi3oOe2CYnHXcOLtY5/Yk6LmV8DG+aLAY4WNpAOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRCtUmAFxcpcdREd+zS/+wdn7ksFg6T+zkmTanCZPrc=;
 b=WDUG3CbF1EekF1nJmsJ3M6PDQGGsvLo3WAoak9QTRf2Uejv8fU5AS+MBdEPjNASeqE5oYmmLJOpZHAX2+z0gzmyCNVdESBvb+3jjpFjLM5pQuHORJZ/4bpUc+fKi4L4m2JeK+ABbdjOKTpCvVlI9QpQije/2STCV+c5PBq8Q2Bo=
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) by CY4PR10MB1559.namprd10.prod.outlook.com
 (2603:10b6:903:2c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Wed, 23 Dec
 2020 15:41:01 +0000
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7]) by CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7%7]) with mapi id 15.20.3700.026; Wed, 23 Dec 2020
 15:41:01 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "pali@kernel.org" <pali@kernel.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Default to HW mSBC on capable controllers ?
Thread-Topic: Default to HW mSBC on capable controllers ?
Thread-Index: AQHW1UH1ZbjENPecx0GN2Ly2GQ87MaoCD/aAgALJi4A=
Date:   Wed, 23 Dec 2020 15:41:01 +0000
Message-ID: <26db80417b43d919b6e33a4ee56c0e44a2f42a5c.camel@infinera.com>
References: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
         <20201221210707.evrdeyiki45pivux@pali>
In-Reply-To: <20201221210707.evrdeyiki45pivux@pali>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2210d13-3a8b-4c16-b320-08d8a7592678
x-ms-traffictypediagnostic: CY4PR10MB1559:
x-microsoft-antispam-prvs: <CY4PR10MB1559240F11D61E49E40BB510F4DE0@CY4PR10MB1559.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oBHHOAIzwPAlDFDuVqk6qgNri8bQvm5LA3cYcU843rZdKbYtiiEa+1qw4QfMPDZ7jUhdexcBWJb6KUrU5N1caW6Jgcn0/1BWFwbhZkh32F3hBT4LdtHTyyrjx8W1VklyvdqMMQPdfkh7EF4NCcY53HxPL7IV5TPfNcXqnHUxXqUaxfucgszHG280gqhGdSm1d6Uvz2TGVRa6c31wqLbaXAG1DH4wfWIpCeomYbGo2gV+5L9hLmym8r7aDqac9ZPLsNtkBL9WE3HHOYFqPxYdUfMsdOaB0W82F6zqZ+2cTngS8y2sFEHFYHcnS5jELLQbfUEQVRwvGMaUFtU78qip8eKEaIji0IRN4MKmU0+OvU/lx2vVCO54eM28VnUBb7PGa01yMR+r66DUIq0se+FYmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(2616005)(5660300002)(2906002)(66476007)(6486002)(8676002)(66946007)(66556008)(478600001)(64756008)(4326008)(8936002)(91956017)(4744005)(6916009)(66446008)(26005)(6506007)(71200400001)(186003)(316002)(4001150100001)(6512007)(86362001)(36756003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WDZYSWRqMmNyYm03NVJFMkMyWHNKbmtlaDU1M3J0RUw1Njd6VU5EYkdCMXhO?=
 =?utf-8?B?alJjd3QyOHJmWHBrTUFkdnpaTDVoeEg0MDZiWisxbG1XeElIcjYwVkZuV255?=
 =?utf-8?B?YzFVY05hRmxPZWt0dVJESForZjdTWkRyWk9DWVdkSmFyY1U0Q3ZBL2lOSGJH?=
 =?utf-8?B?QmVlQXdDWVBteUROcWptaTA5dk1BQXczSVYvTGNyUDVuK3NtdUNZajZpYlo1?=
 =?utf-8?B?UkU0K3AxbndmRTc3bllGS01VZTg0aWZkWEdna2VnMWp0V0k5MWovc2FrR3pj?=
 =?utf-8?B?Y1lGWk9WT0tiY3ZHRkUxNlp4Zk5FenU3MHcvRGt3QVBsYm5PZXVsY3B0OU9D?=
 =?utf-8?B?dFFwOEVlUHFxVStkYm9wOVFkVHZKVlNLY1hvNnF3dDE4RC9jZy9kMlNFa0xV?=
 =?utf-8?B?M1pJY3BqREdCV1puSHFLMGNlKzhQcExEVk13OS9VQllna0V2SUtubDQzR1JM?=
 =?utf-8?B?ODZIK0dHK21SNDNhdHp5NFdIWWNWMDJGalFvbjExSkVKQVdTcFhSNUtKSTZm?=
 =?utf-8?B?TnlGSExDWnBkQi9uRXFDQ2RGb3lhVXJNSUZxUnZuVGJrNUxPTGZJRTNyaGpV?=
 =?utf-8?B?VVhmOUtIc0hod0V1NWE1V2IyUHdmNzNTeFphYm1tbVR0MkJTS0tGRFZkWGo3?=
 =?utf-8?B?Rk8zYzE3RzZwb25zeU1iUG1qQkhnd2JLK3EzRUFWczBSc3BVSE90MmoyQU9I?=
 =?utf-8?B?OUcwN0dMa3BDL2VhTXkyTnAwZDZ6L0JhVUllM25sbyt4YXEraXh1WG00aHdY?=
 =?utf-8?B?U21zM2NvNElQWHNyMXdRbTBXb0N1OWl4NnRtZEVrRU1Hc1hhSlBJRWQ2TnBv?=
 =?utf-8?B?ZHhBT3A5TC9RRkVVT1BObXljaktla3ozQlBjNUE3YzhsYWlnV3NvL1pPVUox?=
 =?utf-8?B?MDZKU0JqSUpjMHJ2R1E4S0pUVGhBN1JOWVhkaEpPOUpXMWwyR1FZSktSSk11?=
 =?utf-8?B?c0kxQisrakU1RGw2OGRvWlk5c0JLaXd4YmcyNHVrUXZQSGZoTjdDUXBBbzlU?=
 =?utf-8?B?dEZXeGxkS29udS9ZVisrZEl3TWg4T245NnZ6bFdhS1J0N29HV3FZYXl3TnIy?=
 =?utf-8?B?TVc4bFNvYjl0VXM4ZTNzRXc3MUJGSnE5eXF5NVc3M0d6TmZFa202RHMraWVr?=
 =?utf-8?B?Sm4yU3dFOXBJVFg4eWprcm41TGo4Tm55ekdWSU9janY5TWJTeU5oQmZqTkxw?=
 =?utf-8?B?ekx3MkpkU3p2NDAvRGxBZ1VYUitNVlh6dm12QVpxMWZTdU9vR0cxWVkyRkhi?=
 =?utf-8?B?eVY1N2VtQUtZaThvM3VaNGR2YWlTelJDKzU2RlNrRzN2MXc5QTNqd3ZzQ2Y0?=
 =?utf-8?Q?m6QR21LzReyDNVK10K7RvHnYywJIZqdYkM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <14FC82BCEC6ED644A24E4D3309230A0F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2210d13-3a8b-4c16-b320-08d8a7592678
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 15:41:01.1637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgJVqzkyJipYVAAtD34QHXiJnPzAzcB1DqqZ1J8C2zBCKEBnFD5UPBM3OBZaaMs5nYPeeHiF++Erz1GzZt6mSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1559
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gTW9uLCAyMDIwLTEyLTIxIGF0IDIyOjA3ICswMTAwLCBQYWxpIFJvaMOhciB3cm90ZToNCj4g
T24gRnJpZGF5IDE4IERlY2VtYmVyIDIwMjAgMTM6MzI6MjkgSm9ha2ltIFRqZXJubHVuZCB3cm90
ZToNCj4gPiBUaGVyZSBzZWVtcyB0byBiZSBxdWl0ZSBhIGZldyBVU0IgY29udHJvbGxlcnMgZ2Fp
bmluZyB0aGUgQlRVU0JfV0lERUJBTkRfU1BFRUNIIHdoaWNoIEkgZ3Vlc3MgbWVhbnMgSFcgbVNC
Qw0KPiANCj4gTm8sIGl0IGRvZXMgbm90IG1lYW4gbVNCQy4NCj4gDQoNCkkgZm9yZ290LCBpZiBC
VFVTQl9XSURFQkFORF9TUEVFQ0ggZG9lcyBub3QgbWVhbiBjYXBhYmxlIG9mIEhXIG1TQkMsIHdo
YXQgZG9lcyBpdCBtZWFuPw0KDQogSm9ja2UNCg==
