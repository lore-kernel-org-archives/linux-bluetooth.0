Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E450FC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 10:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913472068D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 10:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgKLKrP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 05:47:15 -0500
Received: from mail-oln040092075067.outbound.protection.outlook.com ([40.92.75.67]:44526
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725902AbgKLKrO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 05:47:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPLMfUycmhWTgjAJRvMSqrmbuoRcGmjfIWEoGTKm0R7Zor8+fwnePaYMis5pPOaZ428N04SVf8mSQBuR/+qGpJQNI7IKETTWF+fLFP85rDn+WpPW1Th7DGN6uoAn+pOH7jJAzl4Zh/ST77rWOdUASC+uriQalinHc4CdIFHm9Bxxus4kQkX4HVmh9H038usxwsfjXrBNBeGLgB1rnuyWDbcZWqa8Cqz8oX2tBbaiYUaWWiDwe7DWhYPRPfeoh+c7FFPfe2Bap3QfiMGWny+e/3dJFzKktD34tGHiHIkkHy5CqBFHR7hVBwV9s++dzFnUaaQ/ZnGjFTPy88lqu4TgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB6p84Wa9ezXcftkVo5HRBDMtpa0WD633T+O6YYo+iE=;
 b=GVy+wYWE5IYf5pmuSqUSfFCPiY7bH2KU1LtpUkCbark26jTDT/X3NBg0ixQgu44gxFyLbi2zZsolj42VbuUx2HzVpWXgwkidDwCUi83aVix0Z7RKN8g3rHArwo0dXChyMOHwt7Ipxv1I/tT8F7p5C1U3m0RAj7r3v/BkcsPgMyxD8TGJkFswyxvAWdDBRAgcYxB5GI2jUiR3diNn+yfdfjZv7BMJV+zpe55LtC1j9oDh6yN3SvO1NSKZPSKFl1+A6igxJmSPAULYbY5CG9JNTGWvJRiqA/nAh/3aoateOEaEOUTJZGNJhsaAWEj8Gcb/dumAVDXnO/3617nlKmVucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VI1EUR04FT007.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::53) by
 VI1EUR04HT206.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::131)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.22; Thu, 12 Nov
 2020 10:47:12 +0000
Received: from DB7PR05MB5004.eurprd05.prod.outlook.com
 (2a01:111:e400:7e0e::4b) by VI1EUR04FT007.mail.protection.outlook.com
 (2a01:111:e400:7e0e::229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.22 via Frontend
 Transport; Thu, 12 Nov 2020 10:47:12 +0000
Received: from DB7PR05MB5004.eurprd05.prod.outlook.com
 ([fe80::4426:477d:a0d9:a7a3]) by DB7PR05MB5004.eurprd05.prod.outlook.com
 ([fe80::4426:477d:a0d9:a7a3%5]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 10:47:12 +0000
From:   outlook user <Pingo-Power@hotmail.fr>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: No bluetooth since kernel update
Thread-Topic: No bluetooth since kernel update
Thread-Index: AQHWuOAtjXA+qdcFFEWirxk3jn6h5qnEUCCw
Date:   Thu, 12 Nov 2020 10:47:12 +0000
Message-ID: <DB7PR05MB5004932F78C3BDA44135B22297E70@DB7PR05MB5004.eurprd05.prod.outlook.com>
References: <DB7PR05MB5004BB28E5F856A38AB9980897E70@DB7PR05MB5004.eurprd05.prod.outlook.com>
In-Reply-To: <DB7PR05MB5004BB28E5F856A38AB9980897E70@DB7PR05MB5004.eurprd05.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:D86676B35D5ECFB6C7D884DE6E13584672A7B681411E610085BA20A2A106D36D;UpperCasedChecksum:4D9196FA84CC04373F9CA64838D29F44DC63C346F8CD90A23C4C3FF40DB31D74;SizeAsReceived:6862;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [7//Is/s6D8QRi09cmVcZR6pMe9N23L75]
x-ms-publictraffictype: Email
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 8bb6d7bb-f80d-48ef-8068-08d886f84fd5
x-ms-traffictypediagnostic: VI1EUR04HT206:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JtRt04zqijYo/HfkXLT0YRq6xa0cjTQS5tBApYiAt2czJ46aYCof3Km8vaIUCfgT+GuATWDArW6JX11ppqyx3/lSWmgk51k+NENKEnFAzg7Kf7lVmXp8cyCxyaGHVRDLmft4CsMKkd7h76jbfzA1TRbRnOsUfTayd8ugZZvFDFC6LAc1Xnc4ZRjtzmtSM/eNVyf5EyrmVFEzhZDxt0vSJQ==
x-ms-exchange-antispam-messagedata: V7y1A1DSU0HjFtcAksoaXID5ONlwnHDEFekgnj/PSzLZD4k9XrpoYoywya8Np4YYYlWV2EnKGHBw4i7tHDiZXJFqr8PTkAJYWp9juPbpO1HhhPxf4+SOHsNH6qhX3wLUNV/Eau+ji3OqbB46/4ur7Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR04FT007.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb6d7bb-f80d-48ef-8068-08d886f84fd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 10:47:12.1149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT206
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On a Zenbook, at each reboot it's either "Condition check resulted in Bluetooth service being skipped." either "parse_controller_config() Key file does not have key" "rfcomm_bind: Address already in use"

Either way it doesn't work at all

Normal Linux forums redirect me to kernel mailing list because a normal workaround willn't work considering it's a kernel <=> hardware communication problem
