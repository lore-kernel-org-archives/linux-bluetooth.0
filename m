Return-Path: <SRS0=XOEH=UT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B06C43613
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jun 2019 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D595F2083B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Jun 2019 09:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=victronenergy.com header.i=@victronenergy.com header.b="4pFrSY1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfFTJvR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:51:17 -0400
Received: from mail-eopbgr40101.outbound.protection.outlook.com ([40.107.4.101]:21916
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbfFTJvR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Jun 2019 05:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7MZ0wQyxpiMp01XMnma07M7vxKLLsPrOQLed5/lZ4M=;
 b=4pFrSY1oY6sLsULJKGe5PwlbG0fsa9HBnAMpEhYpUPmlY9c7vNyK9O2seguIvq2qjYe3kX90SmYHM11TWU5yD459BCvraNv5Vj8F+SwsVwVEtZ6YtdyNoxuxq+R1y9uXf5rGsp85Zxe49l+Pg5okjRncJ8Qq3QOnKCKW9RCwY44=
Received: from AM2PR07MB1026.eurprd07.prod.outlook.com (10.162.37.23) by
 AM2PR07MB0513.eurprd07.prod.outlook.com (10.160.31.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.6; Thu, 20 Jun 2019 09:51:13 +0000
Received: from AM2PR07MB1026.eurprd07.prod.outlook.com
 ([fe80::80e:354b:1bed:582e]) by AM2PR07MB1026.eurprd07.prod.outlook.com
 ([fe80::80e:354b:1bed:582e%3]) with mapi id 15.20.2008.007; Thu, 20 Jun 2019
 09:51:13 +0000
From:   Thiemo van Engelen <tvanengelen@victronenergy.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Double flags field in LE advertising data
Thread-Topic: Double flags field in LE advertising data
Thread-Index: AQHVJ02ytds3IauAUkSSoqJluLqqpA==
Date:   Thu, 20 Jun 2019 09:51:13 +0000
Message-ID: <ac86be65a0d4e042a6d2a5b51ff7e56fcbaf38a8.camel@victronenergy.com>
Accept-Language: en-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tvanengelen@victronenergy.com; 
x-originating-ip: [213.126.8.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e0b7a0b-a83d-4de4-b11c-08d6f564d4ce
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:AM2PR07MB0513;
x-ms-traffictypediagnostic: AM2PR07MB0513:
x-microsoft-antispam-prvs: <AM2PR07MB05130DA22E001CD5C1601DE7AFE40@AM2PR07MB0513.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39840400004)(189003)(199004)(71190400001)(6116002)(102836004)(25786009)(3846002)(14444005)(8936002)(476003)(36756003)(2616005)(14454004)(73956011)(76116006)(68736007)(256004)(66066001)(305945005)(486006)(8676002)(5640700003)(2906002)(66946007)(118296001)(7736002)(6512007)(26005)(66556008)(64756008)(478600001)(81166006)(66476007)(66446008)(86362001)(6486002)(6506007)(186003)(5660300002)(53936002)(71200400001)(99286004)(316002)(81156014)(6436002)(6916009)(2351001)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM2PR07MB0513;H:AM2PR07MB1026.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: victronenergy.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DIwd1vzDMnntTIfjK6V6caIiKzdC3fP4YXlzhx/X5Afd1U1/4gyFfbR92liymvcbfGbaCN2CBXnAXaW8sUq0BaElVvKV1e1aGDzqAfgFZEmVm4IyWlXXF8e8byMa02PFXb7WrOvcpk9P9akmzFLoYQeKGPgE4hbc4URNufZsXDG1Oy63A2TbzOYou2Ox6Q3NpB0mxZ7mwi+FphPDm81DrzphdsCgSl+RC+UBY0RjCcaJhscclyDf+/vViXCjHe5F9RJPIrR+Y3HSyWjO+vPbil7fOK6TQDmJ6bMwPBaaJlpnwWbixxDYbyDCo1LDFKMxuBj6IubS4fXHPQEy8OmIOQMK+jTw07IMOEFGyIUm6OB01jjnfv4slNRFIah1fxEp7PZr6vGVozZDCBDGfz2Bn7kwdwF5uWb1aF5ostILoaY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A1CBB1856886343AD9C117A93BE24C5@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0b7a0b-a83d-4de4-b11c-08d6f564d4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 09:51:13.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tvanengelen@victronenergy.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR07MB0513
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCldlIGhhdmUgYW4gZW1iZWRkZWQgZGV2aWNlIHdpdGggQmx1ZXogNS41MCwga2VybmVs
IDQuMTkgYW5kIGEgYmx1ZXRvb3RoDQpjb250cm9sbGVyIHdoZXJlIHdlIGRpc2FibGUgYnIvZWRy
Lg0KV2hlbiB3ZSBzdGFydCBhbiBMRSBhZHZlcnRpc2VtZW50IGFuZCBzZXQgdGhlIERpc2NvdmVy
YWJsZSBwcm9wZXJ0eSAob2YNCnRoZSBhZHZlcnRpc21lbnQsIG5vdCB0aGUgYWRhcHRlcikgdG8g
VHJ1ZSwgdGhlIGFkdmVydGlzZWQgcGFja2V0DQpjb250YWlucyAyIGZsYWcgZmllbGRzLCBjb250
YWluaW5nIGRpZmZlcmVudCB2YWx1ZXMuIFNlZSB0aGUgZm9sbG93aW5nDQpidG1vbiBsb2cgb2Yg
dGhlIGRldmljZToNCg0KPCBIQ0kgQ29tbWFuZDogTEUgU2V0IEFkdmVydGlzaW5nIERhdGEgKDB4
MDh8MHgwMDA4KSBwbGVuDQozMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAg
ICAgICAjMjExIFtoY2kwXSAxNjU2LjU2MTkwOA0KICAgICAgICBMZW5ndGg6IDI0DQogICAgICAg
IEZsYWdzOiAweDA0DQogICAgICAgICAgQlIvRURSIE5vdCBTdXBwb3J0ZWQNCiAgICAgICAgMTI4
LWJpdCBTZXJ2aWNlIFVVSURzIChjb21wbGV0ZSk6IDEgZW50cnkNCiAgICAgICAgICBWZW5kb3Ig
c3BlY2lmaWMgKGNkNTRjMDAxLTg4MGItNDI1Yi1iMTY3LTgxZWQ2YTE1ZTkxMykNCiAgICAgICAg
RmxhZ3M6IDB4MDYNCiAgICAgICAgICBMRSBHZW5lcmFsIERpc2NvdmVyYWJsZSBNb2RlDQogICAg
ICAgICAgQlIvRURSIE5vdCBTdXBwb3J0ZWQNCg0KVGhpcyBpcyBub3QgYWxsb3dlZCBhY2NvcmRp
bmcgdG8gdGhlICJTdXBwbGVtZW50IHRvIEJsdWV0b290aCBDb3JlDQpTcGVjaWZpY2F0aW9uIiBh
bmQgdGhlIGZhY3QgdGhhdCBib3RoIGZpZWxkcyBhcmUgZGlmZmVyZW50IHNlZW1zIHRvDQpjb25m
dXNlIG90aGVyIGRldmljZXMuDQoNClRoZSBmbGFncyBhcmUgYWRkZWQgdHdpY2UgYmVjYXVzZSBi
bHVldG9vdGhkIGFwcGVuZHMgYSBmbGFncyBmaWVsZCBpbg0KdGhlIHBhcnNlX2Rpc2NvdmVyYWJs
ZSAvIHNldF9mbGFncyBmdW5jdGlvbnMgKHNpbmNlIGNvbW1pdCBlY2E1OWFjMjcpLA0KYnV0IHRo
ZSBrZXJuZWwgYWxzbyBhZGRzIGEgZmxhZ3MgZmllbGQgaW4gdGhlIGZ1bmN0aW9uDQpjcmVhdGVf
aW5zdGFuY2VfYWR2X2RhdGEgd2hlbiBCUkVEUiBpcyBkaXNhYmxlZC4gDQoNClBlcmhhcHMgdGhl
IHdheSB0byBzb2x2ZSB0aGlzIGlzIGJ5IG5vdCBhZGRpbmcgdGhlIGZsYWdzIGZpZWxkIHRvIHRo
ZQ0KYWR2ZXJ0aXNlbWVudCBkYXRhLCBidXQgY2hhbmdpbmcgY2xpZW50LT5mbGFncyBpbiBhY2Nv
cmRhbmNlIHdpdGggdGhlDQpEaXNjb3ZlcmFibGUgcHJvcGVydHkgYW5kIHBhc3NpbmcgdGhhdCB0
byB0aGUga2VybmVsIHVzaW5nIHRoZQ0KbWdtdF9jcF9hZGRfYWR2ZXJ0aXNpbmcgc3RydWN0ICh3
aGljaCBpcyBhbHJlYWR5IGRvbmUpLiBUaGUga2VybmVsIGlzDQp0aGVuIHNvbGVseSByZXNwb25z
aWJsZSBmb3IgZmxhZ3MuIEkgaG93ZXZlciBoYXZlIG5vIGlkZWEgaWYgdGhlIGZsYWdzDQpwYXNz
ZWQgdGhpcyB3YXkgYXJlIGFsc28gdXNlZCB1c2VkIGZvciBCUkVEUiBhZHZlcnRpc2luZyBvciBu
b3QuDQoNCktpbmQgUmVnYXJkcywNCg0KVGhpZW1vIHZhbiBFbmdlbGVuDQoNCg==
