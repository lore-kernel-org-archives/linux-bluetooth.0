Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0FAC5519F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 10:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F08522255
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 10:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgKTK5V convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 05:57:21 -0500
Received: from mail-oln040092074101.outbound.protection.outlook.com ([40.92.74.101]:49294
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbgKTK5V (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 05:57:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IA5XvsjEhS+IwMJ6UA6R6A0aMCmi/jiQb4CwFi/go5Z72h1mwnDX2bJJW15bPqVLyWHV2Ntlyjy5b1jT3g5yBRBPx1NU44X76PfPhYKuIGWlk6zMYnuqpf8rnwAKIvn42YJHO0RcxdaAJi0HKd0b8w3jgWVjWD5cI79CWoDwyebw0B7m+l4xA7jo9hdKGEdFwZFVVx0XRtmnMw2aZhX8lqOlDQC8pkw/QPPsl/YcnecuN5xf0N9aLBolYLURJFo+B5RHr7qNv/7lcc0E8muWyd23LYQqaxmtE7Gf2gUACgwifjIpvdRk73oBTJAhgzhv6wA65l4Nq4a7SIj6PU8Hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+nTs6GJ6tciw1byFE5POqwyV3ximf7GuSxBY5LXdiU=;
 b=DABQwfuAIuYtVsDRgKs5dxUXlvMkjVjC/P8PjtMcZyh7mk/wXtlT37IBConJd4OAC+porQmGzLtEm/cdv5Yn9/XD0LIGieDLJGUjGjTwA0HhIPVoWIcmqiiKrBWjmb33QBBSThpYqCyAxx1WThCQ/SsByBMFb6HgoDle9mIPjDWWvDET4UyGT0D3091qoqDCjFxPmWc7mzYlb0wC6oOYC7kJMS3KsEM3evBydjieGxUpXNRomwSpTlCwwxImeKwpYLByup//sk2x1l7YnoGasTcsQxqnTmm9E+dPfbaUDGtS5NnaB/wJwkIVECaTbsFLcO9Krq5tc1rgpnNrO02x7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HE1EUR04FT059.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::4b) by
 HE1EUR04HT120.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::360)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 10:57:18 +0000
Received: from DB7PR05MB5004.eurprd05.prod.outlook.com
 (2a01:111:e400:7e0d::4c) by HE1EUR04FT059.mail.protection.outlook.com
 (2a01:111:e400:7e0d::304) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 10:57:18 +0000
Received: from DB7PR05MB5004.eurprd05.prod.outlook.com
 ([fe80::7c98:692a:918f:6392]) by DB7PR05MB5004.eurprd05.prod.outlook.com
 ([fe80::7c98:692a:918f:6392%3]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 10:57:18 +0000
From:   outlook user <Pingo-Power@hotmail.fr>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: No bluetooth since kernel update
Thread-Topic: No bluetooth since kernel update
Thread-Index: AQHWuOAtjXA+qdcFFEWirxk3jn6h5qnEUCCwgAyVsqk=
Date:   Fri, 20 Nov 2020 10:57:18 +0000
Message-ID: <DB7PR05MB50041A16E6543CCEBE170A9D97FF0@DB7PR05MB5004.eurprd05.prod.outlook.com>
References: <DB7PR05MB5004BB28E5F856A38AB9980897E70@DB7PR05MB5004.eurprd05.prod.outlook.com>,<DB7PR05MB5004932F78C3BDA44135B22297E70@DB7PR05MB5004.eurprd05.prod.outlook.com>
In-Reply-To: <DB7PR05MB5004932F78C3BDA44135B22297E70@DB7PR05MB5004.eurprd05.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:96C4BA71AB6018561B8056B561009B377C3BF9886665CA0CB1D8BEACC9D89258;UpperCasedChecksum:1D32E653C655FC6ACDADB5B1A72CC643760DA1AAF5322D6AD247361259B31029;SizeAsReceived:6962;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [FNq3R0Xh7pwPPF1R7oNttct8gO4L1uzd]
x-ms-publictraffictype: Email
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c98c19b8-ab13-4b6c-65e4-08d88d430c7c
x-ms-traffictypediagnostic: HE1EUR04HT120:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtFbnhMtsWKg46OwXlHXKN/hwn5r9Ux8sacjpc/M9C02QQnMrMmc8o/Jgy+JJQv5voiqA5Xjf0ngYi6QtEkHGXjzV2t5SK+/GNnuzMxMla1bV/tg/DmdYoMwp7Y8ffAj2LWpwiaRO+orzr5PPmcII9PBhZISvNt1WZTLAiKZu/z11irFX5ZDaKMsRdFA2akPZVj/65G9INnyAqU/mbCf/Q==
x-ms-exchange-antispam-messagedata: wMx3v7Vc+7as63dZ+FjpQph7Ebfhd8fjuvq3vKXwcHPjfxOcwcrmDXP+teIN1lirkoafNqiSxB5BhZz2+IMWGeDeJhNnnxOjANu+k83oAccGN/NlMc0wdnC/W0emiUMOqYZ//Nllrk9UKI/4GiIOAw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR04FT059.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c98c19b8-ab13-4b6c-65e4-08d88d430c7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 10:57:18.4129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT120
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

up


De : outlook user <Pingo-Power@hotmail.fr>
Envoyé : jeudi 12 novembre 2020 11:47
À : linux-bluetooth@vger.kernel.org <linux-bluetooth@vger.kernel.org>
Objet : No bluetooth since kernel update 
 
On a Zenbook, at each reboot it's either "Condition check resulted in Bluetooth service being skipped." either "parse_controller_config() Key file does not have key" "rfcomm_bind: Address already in use"

Either way it doesn't work at all

Normal Linux forums redirect me to kernel mailing list because a normal workaround willn't work considering it's a kernel <=> hardware communication problem
