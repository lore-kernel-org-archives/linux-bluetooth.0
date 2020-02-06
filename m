Return-Path: <SRS0=lv0E=32=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE6AC352A2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 15:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883C2214AF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 15:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=softwaredesignsolutions.com header.i=@softwaredesignsolutions.com header.b="sE7aE/FI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgBFPrk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:47:40 -0500
Received: from mail-bn8nam12on2122.outbound.protection.outlook.com ([40.107.237.122]:51713
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727563AbgBFPrj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Feb 2020 10:47:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwQeLgkSzirz2Upb9RFvdW+718EOX6+XWp1XYoG27kCc6TCpejiQ/jTk9hsNiEHTSsNrb1qb0NacmPS5HRv1ZreIEf+W3PdiemsOdIzpuJR8pcyfngUP9rvna2ZL5hW/ZKJhnDYEgIUiaPfH0tTHmyKN4+6up5el6ih4w/8SCdiKNucrkHBtSVdyO00JRV++7fOVtanUpOoq9+vKwDBxHV5aLQlqhVjw31JDX8sCmqnAEj9sh1BZi8sVwRG/Jjz8o4MuJPRU/aCNCGxwLjsEQ40goeKtfxQ7+AlSLr84WI4RRtwndArS/GL3xgW3ldQetX2Zag9z4jDpUHvMAujDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRcsJkvmTy3a4I5rci/G1d47+quwgFOIKIZa+cG2ilE=;
 b=i1FL2U9psNpq1cBLICp6AemNFnsPimljloQYsXdxzv4PfLGB8VIcMh5oqJLJJCFwNkOOGX6a5yoVhqnrJGSkISqmYEwHZeLU/UI83nQNQHB/q8jrhYlsDbflskVkC6xwKrgriFtKjY/t0NGC9Wcrv+RJKyQju/be+CoDpLeDDohrQ93V8Z3LIzFyWX8d9SdP5+fiygA+kFetSFgYiibXoc1VehpT1J5EXjXYtzDcS+WClCz5ePbvEAW5L53ICElw0Le7TcrljlmLGkymJBxmUt9OcgBc0qh7+lC/nkVOgZ8roOLlodj7oKtOBZtKxZ65krwv/9+BGRtgelWuIZjArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softwaredesignsolutions.com; dmarc=pass action=none
 header.from=softwaredesignsolutions.com; dkim=pass
 header.d=softwaredesignsolutions.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softwaredesignsolutions.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRcsJkvmTy3a4I5rci/G1d47+quwgFOIKIZa+cG2ilE=;
 b=sE7aE/FIsloOqU+Q789RP48prHSXBysDL2yTW1UQdYT6Nz3H+J9o7gq6/y9KGe9eQ7igTPHVIw9CmPB1yQREuWT51TpgVbcnb+fsTaD7n+hS+VYpY1mhWIUh7ZQgb5tNmT+9I1hCiXdht86oP01uegDcqG2+83K2VacPdoWK0m8=
Received: from MN2PR14MB4109.namprd14.prod.outlook.com (52.135.51.141) by
 MN2PR14MB4096.namprd14.prod.outlook.com (10.255.125.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 15:47:36 +0000
Received: from MN2PR14MB4109.namprd14.prod.outlook.com
 ([fe80::bd62:d69a:66fb:ae96]) by MN2PR14MB4109.namprd14.prod.outlook.com
 ([fe80::bd62:d69a:66fb:ae96%5]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 15:47:36 +0000
From:   Alex Vallo <avallo@softwaredesignsolutions.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: LE Set Extended Scan Enable command
Thread-Topic: LE Set Extended Scan Enable command
Thread-Index: AdXdAw9814We5ayXQ+2XFE9grQIAJQ==
Date:   Thu, 6 Feb 2020 15:47:35 +0000
Message-ID: <MN2PR14MB4109F100D9DD9B34D30C3BCBDB1D0@MN2PR14MB4109.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=avallo@softwaredesignsolutions.com; 
x-originating-ip: [72.95.129.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bae4c529-bedf-45cb-d2bb-08d7ab1be344
x-ms-traffictypediagnostic: MN2PR14MB4096:
x-microsoft-antispam-prvs: <MN2PR14MB40962F1FD5E22A164C793750DB1D0@MN2PR14MB4096.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(366004)(136003)(39830400003)(376002)(189003)(199004)(5660300002)(52536014)(7696005)(186003)(86362001)(6506007)(71200400001)(6916009)(4744005)(55016002)(26005)(66946007)(76116006)(2906002)(66476007)(81166006)(81156014)(66446008)(64756008)(66556008)(33656002)(9686003)(8936002)(508600001)(8676002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR14MB4096;H:MN2PR14MB4109.namprd14.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: softwaredesignsolutions.com does
 not designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AMG0M229JtR9fet/dToCXTZ9/HZ/vw1gD9EvhF2KR2QE6L/dNDZixQ4p/F/sr8aEX+YXNChTRWDymN7RYaP8XbXxSDhGm9d6uorNWrxnBX+E9TiurjsI6TEhkmnnF+C65z1VBRyysxbGvE74O+24NW/oxymt0tS1hSqQGsnWJ82liT7feZZAzG6107ti5Rt79ugY/x+2Pqx8XYq3cqEmPgfK4iBUPUYeujepAwLGoD6NgFeP8aVnvhti+X67iWHB1Dr9AQuVgKjES8gHXjrbuOarOx0CI0mWAyX7KuGQxXaC3cdma6lrjwVEQKrSakB0dDPcgBg+uyzvf6qyrtH95C9UCtdS3aEgYKtZK/GqrdFH+PreFNci0Cl1snLaLjXfOE/8lgblRmcQ4iKwin/B2K+FwUr7GsQyxvqhHWcOhG9JIsXTcviZEc1iEdcewOEd
x-ms-exchange-antispam-messagedata: 9YL5PKUL8eke0m43cVTvnm01uFy6To0jCbkQfW/GFndRjjb9mg3wZPkk6d8OspondzAW46pC1I5dIo+IOKWkq7hDq6xBA3kLzxL90jUuybym7otjI5Y5GsMkF9G+k57hSr3DdfCxreQG8doqm3kjkA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: softwaredesignsolutions.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bae4c529-bedf-45cb-d2bb-08d7ab1be344
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:47:35.9917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e4c002f1-a7ff-457a-ae57-9dd3d869a6af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: myDAJnqb6dYyTiegPuAfgqmIlSWieCprGGQP8F0t5xF5E+a0tJcrVGYOQcbqLpr6nnsSV0EIENoFe2AuvjSLG410eOsB6BZx3hAO7ZqAWtYZ6d5vql4SKK2QxySg45eO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR14MB4096
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

Does Bluez have a function hci_le_set_ext_scan_enable() similar to hci_le_s=
et_scan_enable()?
If not, is there a particular reason why not?

hci_le_set_scan_enable(int dev_id, uint8_t enable, uint8_t filter_dup, int =
to);
// LE Set Scan Enable -- Bluetooth Core Spec v5.2, Vol 4, Part E, Section 7=
.8.11 (page 2496)
hci_send_cmd(device_handle, 0x08, 0x0C, 0x02, &param)
hci_send_cmd(device_handle, OGF_LE_CTL, OCF_LE_SET_SCAN_ENABLE, LE_SET_SCAN=
_ENABLE_CP_SIZE, &param)


hci_le_set_ext_scan_enable(...)
// LE Set Extended Scan Enable -- Bluetooth Core Spec v5.2, Vol 4, Part E, =
Section 7.8.65 (page 2613)
hci_send_cmd(device_handle, 0x08, 0x42, 0x06, &param);


Thank you,
Alex Vallo
