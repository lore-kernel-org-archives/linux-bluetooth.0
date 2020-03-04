Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E9AC3F2D1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FA121744
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 10:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=RFPros.onmicrosoft.com header.i=@RFPros.onmicrosoft.com header.b="8Sas7oEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbgCDKzP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:55:15 -0500
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:9547
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387761AbgCDKzP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 05:55:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtLIcqeMflHXGvvtgKK0BKLkn+DG6HViVdxXc7cRJWbCJHWC+ZpiOsd8FprjI9TmKEQ3UGWlDxyV3+FskbB12BS54lfi7+M7l9GOK8tJU0+HP1b8XeVv0wc0Mmhy4ixn4xaixtw9il/tvfobTGJ0aqjbTUDicpVfc8QxxAx3XkJZiVVcjbYiAa6/oPrTNfxbAyk8oRdiQXgJyWhmINhChkJQKRlxmPlJc8uguNKqwJ7BBEbKmGvgkrdx2wLmqc+QHe4jrmkzMBqcfMudHtz34guA5axwet6xFxdQGPKUmKzMMrBtKG5tuAwaTW+1wd92Tq1n9h9jyMvNFzsUcD7Esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRqGU3CAPLtRw7ochTJTkSBWRMw+q+FGknE+mOwYrDo=;
 b=NvcTzwd8PJM4R19lz5OBhBnQ6Jj+HJP1SHU+YeqTSJdAQ4vInQVYIP5/OKsPnN+fivIi2PnAqSmvbqUYTrZKdRK19ZRXMzuthwa1qXCP/+hWaPcgltmt+U7C9f7TOgsoYbs+reFv6HxY7dR6dQbItIuLW29tju7i9FS1fodGGoBIzzLlgdVVUcVVEXyI2lCOUqtofTa+LR2S/DhZc3DFJVgzvU/cq+/AF6d9kQq0Khl/51BIve0g8bIj6d5QQ8TIQbzXqWJZ5p5+X0yVWfpeLkax9A9sGz91LzZ7MSUC5rRFI8hTv6odI0e12XrB1+i++oun6XUueTsH8dt4UvtIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=RFPros.onmicrosoft.com; s=selector1-RFPros-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRqGU3CAPLtRw7ochTJTkSBWRMw+q+FGknE+mOwYrDo=;
 b=8Sas7oEyXKBNGQU4hFTIvucKgwqVS/VvqRRbotEO+EJXw3xH4nZ+AWjYy2Wph4L2yC0hQFAeJqNbp1MUA/1nl1C8vWAQsg616WUZYzluXAgLL8Oyq+2LpzXwimT3tf/NAPrQCA1igQyKbvm5lo/MKIw+rCmC/gLSlnrggEWu9vg=
Received: from CH2PR14MB3658.namprd14.prod.outlook.com (2603:10b6:610:66::17)
 by CH2PR14MB4024.namprd14.prod.outlook.com (2603:10b6:610:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Wed, 4 Mar
 2020 10:55:12 +0000
Received: from CH2PR14MB3658.namprd14.prod.outlook.com
 ([fe80::c0a8:25f2:ae1a:305f]) by CH2PR14MB3658.namprd14.prod.outlook.com
 ([fe80::c0a8:25f2:ae1a:305f%4]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 10:55:11 +0000
From:   Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
To:     Emil Lenngren <emil.lenngren@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Subject: RE: Get negotiated ATT MTU?
Thread-Topic: Get negotiated ATT MTU?
Thread-Index: AQHV7uiLGbdNB1rz30Cys7RZOb4DBqgzTIgAgADRWgCABClXMA==
Date:   Wed, 4 Mar 2020 10:55:11 +0000
Message-ID: <CH2PR14MB3658759A2701FB52A2D6573BE6E50@CH2PR14MB3658.namprd14.prod.outlook.com>
References: <CAO1O6sdGJeAKTHBVyDSUa7-Hp_ULYmfOHJEbb6=-B6xuPHvffQ@mail.gmail.com>
 <CABBYNZKtxPmTUn2fw9-dy1V9M_Pb996O6VmHkg4NrAr-=t+-4A@mail.gmail.com>
 <CAO1O6sdke-2J=eYHS2SoG83v-hMJDBu-gasufJYDyHK+1R+w5g@mail.gmail.com>
In-Reply-To: <CAO1O6sdke-2J=eYHS2SoG83v-hMJDBu-gasufJYDyHK+1R+w5g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jamie.Mccrae@lairdconnect.com; 
x-originating-ip: [81.148.167.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea449e8b-23b9-49df-6df0-08d7c02a833c
x-ms-traffictypediagnostic: CH2PR14MB4024:
x-microsoft-antispam-prvs: <CH2PR14MB402415468D4CAA4D153AF9E6E6E50@CH2PR14MB4024.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(376002)(396003)(366004)(136003)(189003)(199004)(55016002)(81166006)(81156014)(9686003)(5660300002)(33656002)(76116006)(8676002)(66476007)(66946007)(4326008)(66446008)(86362001)(64756008)(66556008)(8936002)(3480700007)(7696005)(71200400001)(6506007)(52536014)(26005)(478600001)(2906002)(186003)(316002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR14MB4024;H:CH2PR14MB3658.namprd14.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lairdconnect.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M00ee1JZ5d0PMmhL0aml5hRQwjoafMdivICqt7qfTBynUejFh8zW8MgDZHQG+qcHBSREj3AzuCpsX8i/DqcVh0KvHjUaHAdZbUF8An4UAh5BsDBIWJBqzu3UopXSg7IdKG3ezLW/o1w8dpK6b8w1VSURy7+RxVwO8LA5PkyaXET74cu10ieM/y0FRt5D1xnLjaoxjxal3glcAD6d5a7X8XsLH7ogr1ce2nSTteawoC3tYXl5/8JjzwRbsPYQUwsXFqwfeQO3hkoi0TUXEQT3MU7jkic6lRzefX3la0ibFDNwbzfdvUJ2Txs1OVIY7LQsqxjR5jgtCr/RAQWq/eqvmN1kjkryO4Qft+uk2X293AjkhsVxGM0xcaxAJ8GXRqaILTRGrzGEBYjcLvOr/3wDgGc+1htqz9iKZbzDZwYbMC1BOaS5Q0IO8868sRZdyJdN
x-ms-exchange-antispam-messagedata: GT0yfIxzIOFu59bV3kJ9oFxbV+CTenm7mbK+qfC2oUFdWFvuPfOtwCdj9hqcgk/0dM6fdl8E8JZqxLV3MNdqVn0nPWcMm0zBISi9NHQe8hx+6q1pV3V2xArIyKt5canQIr2UvMCGADLleSCTzxyqcw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea449e8b-23b9-49df-6df0-08d7c02a833c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 10:55:11.8024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7YPliUqiJXpVjJLnDTRW3pygn4eCD9YOiIm7TcqDC2fdkiqq3SWKV0wlQujn/g0s2f296eHH6sUmxMfatIXVBXrtf7luqGgvERYE4vg7MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR14MB4024
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQo+IEl0IHNob3VsZCBiZSBmaW5lIGFsc28gaWYgdGhlIHJlbW90ZSBlbmQgc2VuZHMgYW4g
RXhjaGFuZ2UgTVRVIHJlcXVlc3QNCj4gYXQgdGhlIGJlZ2lubmluZyBvZiB0aGUgY29ubmVjdGlv
biBzaW5jZSB3ZSBjYW4gdGhlbiBpbW1lZGlhdGVseSBzZW5kDQo+IGEgcmVzcG9uc2UgYW5kIGFz
c2lnbiB0aGUgTVRVIHByb3BlcnR5IHdpdGhvdXQgd2FpdGluZyBmb3IgdGhlDQo+IEV4Y2hhbmdl
IE1UVSByZXNwb25zZSAodGhhdCBjb3JyZXNwb25kcyB0byBvdXIgcmVxdWVzdCkuDQo+DQo+IExl
dCBtZSBrbm93IGlmIHlvdSB0aGluayBJJ3ZlIG1pc3NlZCBzb21lIGVkZ2UgY2FzZS4uLg0KDQpJ
biB0aGUgY29yZSBzcGVjaWZpY2F0aW9uIDUuMiB2b2x1bWUgMyBwYXJ0IEEsIHRoZXJlIGlzIGEg
Y29tbWFuZCwgTDJDQVBfQ1JFRElUX0JBU0VEX1JFQ09ORklHVVJFX1JFUSwgd2hpY2ggYWxsb3dz
IGZvciB0aGUgTVRVIHRvIGJlIGNoYW5nZWQgYWZ0ZXIgaXQgaGFzIGJlZW4gZXN0YWJsaXNoZWQu
IFRoaXMgcmVxdWlyZXMgYW4gZW5oYW5jZWQgQVRUIHNlcnZpY2UgaG93ZXZlciwgYnV0IGl0IG1l
YW5zIHRoYXQgdGhlIGluaXRpYWwgTVRVIGlzIHN1YmplY3QgdG8gY2hhbmdlLg0KVGhhbmtzLA0K
SmFtaWUNCg0KDQpUSElTIE1FU1NBR0UsIEFOWSBBVFRBQ0hNRU5UKFMpLCBBTkQgVEhFIElORk9S
TUFUSU9OIENPTlRBSU5FRCBIRVJFSU4gTUFZIEJFIFBST1BSSUVUQVJZIFRPIExBSVJEIENPTk5F
Q1RJVklUWSwgSU5DLiBBTkQvT1IgQU5PVEhFUiBQQVJUWSwgQU5EIE1BWSBGVVJUSEVSIEJFIElO
VEVOREVEIFRPIEJFIEtFUFQgQ09ORklERU5USUFMLiBJRiBZT1UgQVJFIE5PVCBUSEUgSU5URU5E
RUQgUkVDSVBJRU5ULCBQTEVBU0UgREVMRVRFIFRIRSBFTUFJTCBBTkQgQU5ZIEFUVEFDSE1FTlRT
LCBBTkQgSU1NRURJQVRFTFkgTk9USUZZIFRIRSBTRU5ERVIgQlkgUkVUVVJOIEVNQUlMLiBUSElT
IE1FU1NBR0UgQU5EIElUUyBDT05URU5UUyBBUkUgVEhFIFBST1BFUlRZIE9GIExBSVJEIENPTk5F
Q1RJVklUWSwgSU5DLiBBTkQgTUFZIE5PVCBCRSBSRVBST0RVQ0VEIE9SIFVTRUQgV0lUSE9VVCBU
SEUgRVhQUkVTUyBXUklUVEVOIENPTlNFTlQgT0YgTEFJUkQgQ09OTkVDVElWSVRZLCBJTkMuDQo=
