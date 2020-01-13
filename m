Return-Path: <SRS0=UJar=3C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE6CC33CAE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jan 2020 07:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12302207FF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jan 2020 07:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=RFPros.onmicrosoft.com header.i=@RFPros.onmicrosoft.com header.b="1JHqPNCp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAMHah (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:30:37 -0500
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:7584
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728646AbgAMHah (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jan 2020 02:30:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcVh1DZsg+IKKdQQikotAV2qXkUs8y0UXJ05BzlXbQRGaTRZn82OESTLO0b4QMoEdp45z4OSN+eGHqYy+e4ctUTil/YYwm4yJhglBNOr2KSotQtR0VJdmjOQB0U5QVlTv8RV5UECzHvWLcau3o9THhgiw8z+CnPSXCx4a5wjbpZvLZZBAgxSwUGv8fG/52W5xSdSwXOIE43QFaWoGE1i42Xmg5lRCE9eexmITz3PvZNhqhzd1aK1RieJsoy70U55GHuRH8qlYMQKSIPGs6hhq3UebMqyqC2roZFvCJfFrIaIsulwvBUkYoOvZ3HzIfuwTUT1coUyHhPaPi9Mdg6PBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZRzac1ck+cTS1P8PRB0yGftanhSik+Lt1zFcQSyMLY=;
 b=gnIDkTN/zd1UfhN8ZcrBqFSxeq7HqK2zKiqAnNYRDwzvfH7hXhrwLlpUgFZSKe+B9JrHcoQgmkZYR9mjNt8TyCkNmIT5FU2HU+KIJaTCL3QU2I1gB17DSzqZS0YCyyqq5iqhZAOum/G+ll9BAKgBFHMM/SHbnifkQwme421BjW963XRdmTQjuCbMv/KQbmZLXVDZemOIhzUWVjnXfAh4o6EDyogqnLf4edLIMU/vOdruuGslGzO6nNaXajZpauLaCZY/GtwbSXRob3B9ElrHBLnLH7X+Sq1JekJJIvOHM16TQgRag5uYpcW7371QfGjYYE4Z1W6+rZ6tWjFvzXaHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=RFPros.onmicrosoft.com; s=selector1-RFPros-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZRzac1ck+cTS1P8PRB0yGftanhSik+Lt1zFcQSyMLY=;
 b=1JHqPNCpGQGTM72BjrOY6GGTFROwF5B0MAfyGmUx/Ezm1iZfmhZFEtIG4IkRETWW1K0wOC6NGyg3WUyHDv58ZDSAeFEd2RWAvMOAI9SqCq8tnn+aaKAelp3ZBK6R/nVxqPf5oe23w8vEtWYVA8c0q8h46SUk3w3lZKYyUemdxH4=
Received: from DM5PR14MB1385.namprd14.prod.outlook.com (10.173.223.13) by
 DM5PR14MB1483.namprd14.prod.outlook.com (10.173.221.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 07:30:35 +0000
Received: from DM5PR14MB1385.namprd14.prod.outlook.com
 ([fe80::95a:5934:c7a4:d915]) by DM5PR14MB1385.namprd14.prod.outlook.com
 ([fe80::95a:5934:c7a4:d915%6]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 07:30:35 +0000
From:   Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
To:     Steve Brown <sbrown@ewol.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: mesh: scan params specify random address, but no random address
 set
Thread-Topic: mesh: scan params specify random address, but no random address
 set
Thread-Index: AQHVyIjVzdx6hBoAnEeOv2t0j3oKb6foNUog
Date:   Mon, 13 Jan 2020 07:30:35 +0000
Message-ID: <DM5PR14MB1385927CD0D2A8B1D0ADBB15E6350@DM5PR14MB1385.namprd14.prod.outlook.com>
References: <988d501619da548fff95f1f1afaa6456e18e6dfe.camel@ewol.com>
In-Reply-To: <988d501619da548fff95f1f1afaa6456e18e6dfe.camel@ewol.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jamie.Mccrae@lairdconnect.com; 
x-originating-ip: [81.148.167.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb126b4e-d6f9-4d05-711f-08d797fa7af5
x-ms-traffictypediagnostic: DM5PR14MB1483:
x-microsoft-antispam-prvs: <DM5PR14MB1483AB8C1BA2E09066F78E4CE6350@DM5PR14MB1483.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(396003)(39840400004)(189003)(199004)(33656002)(8676002)(316002)(81156014)(110136005)(8936002)(81166006)(52536014)(2906002)(4744005)(71200400001)(86362001)(7696005)(5660300002)(9686003)(66946007)(76116006)(66556008)(66476007)(64756008)(66446008)(478600001)(186003)(55016002)(26005)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR14MB1483;H:DM5PR14MB1385.namprd14.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lairdconnect.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sdi9ufRRGCPMZsA+7gNRPL4j/rkKjqLitDOK3UedMto2EofXkwWzX43jBtT5YmwX+W4rgu82V/54P1XI+ZtHtNrMuu9JsEA8Q9Srjaw0BwlceQzTge3LjEteQtkfvU29leDxXYaXFj+WDwOMKVU67Oeo4+7ak9unN8mApepgqqaoI+NK8nRxoT8zeUwXRph4PtvOf9BvFCSYlzhSpm/T5YfEfhbAeMxCZRyOFXpAwG1dSTEThwktd2d2If4P0DZRhRGQGC4Mv7UcqJB9lxAuhJWzPeC6P8gpx5GbJfR6dxbLCH90x7foiU+JQgOR3JlHOEXbQLJvEDWUPHwmxjeFbm0wGtLMgXovRAR15xWqWQZhzAwA5d0Ebwe/YocB5yOYp/ewlG0FraaQR7v8Fjr24QSXKWBwbMcb9gRnJ9etGIB54KPLS5fEmhYsghVIOLr+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb126b4e-d6f9-4d05-711f-08d797fa7af5
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 07:30:35.5378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cp/SHMoHsR0EyBLe6pHvCh1xj4TDUXMrk3FfD6xyhjeeR2McX7Vkc1eH3M9x+phHhGdZ/SOU5Ewf7BpvwxO23fnhgfiUDmb1tPC4YjX1TFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR14MB1483
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

PiBJJ20gdXNpbmcgdGhlIFplcGh5ciBoY2kgaW1wbGVtZW50YXRpb24gb24gYSBidCBkb25nbGUu
IEl0IGNvbXBsYWlucw0KPiB0aGF0IG5vIHJhbmRvbSBhZGRyZXNzIGlzIHNldCB3aGVuIHNjYW4g
ZW5hYmxlIGlzIHNlbnQuDQo+DQo+IE15IFJQaSBkb2Vzbid0IGNhcmUgaWYgYSByYW5kb20gYWRk
cmVzcyBpcyBzZXQgb3Igbm90Lg0KPg0KPiBTdGV2ZQ0KDQpIaSBTdGV2ZSwNCllvdSBuZWVkIGFu
IGFkZHJlc3Mgc2V0IGJlY2F1c2Ugb2YgZGlyZWN0ZWQgYWR2ZXJ0aXNpbmcuIFlvdSBuZWVkIHRv
IHVwZGF0ZSB5b3VyIHplcGh5ciBwcm9qZWN0IHRvIGluY2x1ZGUgYSByYW5kb20sIGFkZHJlc3Ms
IHRoaXMgaXMgY292ZXJlZCBxdWl0ZSBleHRlbnNpdmVseSBvbiB0aGUgemVwaHlyIGRvY3VtZW50
YXRpb24gYW5kIGRpc2N1c3Npb25zIGZvciBOb3JkaWMgY2hpcHNldHMuDQpUaGFua3MsDQpKYW1p
ZQ0KVEhJUyBNRVNTQUdFLCBBTlkgQVRUQUNITUVOVChTKSwgQU5EIFRIRSBJTkZPUk1BVElPTiBD
T05UQUlORUQgSEVSRUlOIE1BWSBCRSBQUk9QUklFVEFSWSBUTyBMQUlSRCBDT05ORUNUSVZJVFks
IElOQy4gQU5EL09SIEFOT1RIRVIgUEFSVFksIEFORCBNQVkgRlVSVEhFUiBCRSBJTlRFTkRFRCBU
TyBCRSBLRVBUIENPTkZJREVOVElBTC4gSUYgWU9VIEFSRSBOT1QgVEhFIElOVEVOREVEIFJFQ0lQ
SUVOVCwgUExFQVNFIERFTEVURSBUSEUgRU1BSUwgQU5EIEFOWSBBVFRBQ0hNRU5UUywgQU5EIElN
TUVESUFURUxZIE5PVElGWSBUSEUgU0VOREVSIEJZIFJFVFVSTiBFTUFJTC4gVEhJUyBNRVNTQUdF
IEFORCBJVFMgQ09OVEVOVFMgQVJFIFRIRSBQUk9QRVJUWSBPRiBMQUlSRCBDT05ORUNUSVZJVFks
IElOQy4gQU5EIE1BWSBOT1QgQkUgUkVQUk9EVUNFRCBPUiBVU0VEIFdJVEhPVVQgVEhFIEVYUFJF
U1MgV1JJVFRFTiBDT05TRU5UIE9GIExBSVJEIENPTk5FQ1RJVklUWSwgSU5DLg0K
