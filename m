Return-Path: <SRS0=PQ2f=6Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D44C47255
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE5C2070B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 May 2020 17:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=targetsg.onmicrosoft.com header.i=@targetsg.onmicrosoft.com header.b="e6dTurJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgEKRdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 May 2020 13:33:09 -0400
Received: from mail-eopbgr80108.outbound.protection.outlook.com ([40.107.8.108]:37797
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728556AbgEKRdJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 May 2020 13:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUsMgU/O8cYH+LxRfASY0rekLEQ2VJeC+655AeZm2SVgqohWUBc9WgbCElCDhWcAR1NsGY7Efj9bp9AgGBf3uLIQS3V2SoJYbiscCIR+DP7w0T56dvKkMGHhbA+CyPCNL+2v7qarRAJ+lEQR/uPpWCjcWsPTDDJepk4jR42Zyp9yLrUstP/8AK+Q7MaC1x40icSk0tcevAg8M8NvZCBPaJ1t48O0SbdfS3jwPtODjZM233ll5j3aG8qw9SngbDQjmdSldSlUWDaFmTmXjTxGl0vCn8a5aR7q1usB7zEgYqkSPqIf7tGIr4qhqBOOYfchpWRJwg5sFxeUsacO1lKw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZSYcEI7v51Pt7Svjb4Jpc9ctd9swL09g09Ixr5j9CQ=;
 b=DiixKPV/Cztrz0FyNSsFAyd7+Mujn0+Sp6JCLoTYwfKqN6iROrM5r4YSCL6VjqQVBI1hqqAI8loAFDjypafwaK/0Run12VFynH08BtOZZqvH22EPx8/Z6e5gehK1++eLjheQ4Et1RXJyu21qEzTx4WPNviqybLpU5a+Ki3BDLsynY3nZUxy2QCufJwz8q0qvvf155cgXKTwclM+P+ox0Z7mbsPeBNrCFsxrY990dUqS7iuPDhDhQoqe9xN6CkY7posPA4isdNMpBSyO0RBNRb7nTFW2x56pWu2AI0Ba8jBw0o5CF8rxFt4jhw+Pbx8Sv2yOyrCNucOcVpOLVHU2Lzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=target-sg.com; dmarc=pass action=none
 header.from=target-sg.com; dkim=pass header.d=target-sg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=targetsg.onmicrosoft.com; s=selector2-targetsg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZSYcEI7v51Pt7Svjb4Jpc9ctd9swL09g09Ixr5j9CQ=;
 b=e6dTurJ2amg1bT0xWD8UsWLigOKmNn0nm/Y/7ZB+tJun7qxUstmxz/fvIjwG8Kf6S79yrTcdgtK1lRLw5SXfMv6FipyCJ1PiAk9TnTANIaSLMUSFQzXtHsGoXSFoi1lFu/NsycUg8RdtbAQLj6mfoiJFLgfGwp1Ao9tas2fEucE=
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com (2603:10a6:208:4f::30)
 by AM0PR02MB4209.eurprd02.prod.outlook.com (2603:10a6:208:d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Mon, 11 May
 2020 17:33:05 +0000
Received: from AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::59fb:b91b:4f30:f64c]) by AM0PR02MB3841.eurprd02.prod.outlook.com
 ([fe80::59fb:b91b:4f30:f64c%6]) with mapi id 15.20.2979.033; Mon, 11 May 2020
 17:33:05 +0000
From:   Kai Ruhnau <kai.ruhnau@target-sg.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: The org.bluez.Network1 dbus interface does not emit PropertiesChanged
 signals on Disconnect 
Thread-Topic: The org.bluez.Network1 dbus interface does not emit
 PropertiesChanged signals on Disconnect 
Thread-Index: AdYnugzFNiPiZSWnT+CoKgkVhG0biQ==
Date:   Mon, 11 May 2020 17:33:05 +0000
Message-ID: <AM0PR02MB3841E4C1CCA1B6ED919DB3B5C5A10@AM0PR02MB3841.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=target-sg.com;
x-originating-ip: [2003:c5:170e:9b00:c069:64e4:399c:cf8a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 946ee217-00cc-4075-8f57-08d7f5d15cf6
x-ms-traffictypediagnostic: AM0PR02MB4209:
x-microsoft-antispam-prvs: <AM0PR02MB42099CDEC217252AB302A235C5A10@AM0PR02MB4209.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04004D94E2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPfsYTA9BZ0zQTyb6iKVf1lVjpYoOa2y5hNeHwfBnGQ8tqdQUSvcKDoK6gzql2W7RN3awSTsPFkSGcN80lam/Pj8tkk/J6XAbdm51iMYpDqGfdZVO/5x7ziHEKgRkJ0cmx54wWLH2BAUSY894JOLgjUsfGBw+1J5UhCVKr939LiF6ieZ1itP5FLsL7Xy23mcb+dbiaia1UynxCtEt6NxrfT9cgM8Sjwvr8fJjp2El5+BCczeZOFMQRcVlYAlQETtzCz+IBQiNdn1+TA5zeQ51lSNxqAfe2/jnvJgBwO2t+kPAXyenJgbPXGE73yoGN8FUYN/tW/Y1vduAni8nyIWH84St2Rx0EC6ndXZDGJUjzJ8GBJ42f+OGepTzTk6H7qL4UMM9hAvCFxqL8m6wExF07tITLMLWYHtGE4zSfCkIjbNjRFVvozlurJWHUm5G3w3G/CEDw5dne6yphPrN04aYlXCHSbiEdfxSJ1apTM6vH1drWqeXtuuhkmCdPZ8YslPaxlKZlxbhY2jObejNQqBgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3841.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(136003)(39830400003)(396003)(33430700001)(7696005)(66946007)(64756008)(66446008)(66476007)(66556008)(5660300002)(9686003)(33440700001)(8936002)(8676002)(2906002)(76116006)(55016002)(33656002)(4743002)(44832011)(52536014)(86362001)(6916009)(316002)(186003)(71200400001)(508600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: L5QLAHKLI+hDxnxX5K8YyDxFxQKTg7GdfckGBzTxGqIzWxd2gD7wpD4gHJfyqGA5SLiFUU58unct+rrOMNW+xu5rrjeKA9qlfAmr183XDxnScEcMSmR1VxGMAxLWCa1oitHMpXze9hzf0BmOUeITpXIpJsZTw34mGNqmFrK51JOYH17fsOqRv0MOMgXcG8UzjJ5W+5ZTnow4FB09Clt+drELttBlW6MAdZDYnr7yu/KE6rN83BmuJnD6lTF8VtohCDUgiFug6PvfpyXl1S8s6j4c2ZPbeXNDS+InStHVBA0hivtZuip81GtxzoRXRa6UZzTJZCmYeE5gfs9IqUnCEvDNLyN6Tg14rkiWhvnTb334gQUdJrsfELXQazdKEoAo2y23l/EP0czvwMrMQ5wbzTMKoRe3kKiEn/k84wNFIiUyA3uw0E1tmaepEliPzrGK/4DmSUPHfFKjyr10iUd7sE1k/zuOEcv7BHS9OMynreXILb5X18rGETTfGL5olusq6fX0SIQ3DT9X6DJiCrbor402lcacTybRD2lK3q7wihqPI9j7+VuDff4gBEvP8Ki7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: target-sg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946ee217-00cc-4075-8f57-08d7f5d15cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2020 17:33:05.2007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 52a4fe2f-f30a-452d-90b1-03ecc8ab0c0d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxCGuhtUX3ya58Pg3tM4BeA+SUv/xrEYmGIPQoKvBzeyqNdSjQ22X9C7TxXaczCoRa8+1ty+wCIH+0lX0yoqb5bk56xFS4qZfyaa88peZpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4209
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I'm using the dbus interface to connect to an iPhone Personal Hotspot using
Bluez 5.54 / Linux 5.4.32. When connecting, Bluez emits PropertiesChanged=20
signals for the org.bluez.Network1 interface of the device informing me of
the Connected (true), Interface (bnep0) and UUID (00001116-...). However,
when disconnecting, no such signal is emitted. Querying the properties
shows, however, that the values reverted to the unconnected values.

When I disconnect by disabling the hotspot on the iPhone, the signal
is emitted.

To reproduce, run `busctl monitor org.bluez` on one console and issue

# busctl call org.bluez /org/bluez/hci0/dev_? org.bluez.Network1 Connect s =
00001116-0000-1000-8000-00805f9b34fb

resulting in
- method_call
- signal PropertiesChanged for org.bluez.Device1 (Connected true)
- method_return
- signal PropertiesChanged for org.bluez.Network1 (Connected true)

and then

# busctl call org.bluez /org/bluez/hci0/dev_? org.bluez.Network1 Disconnect

resulting in
- method_call
- method_return
- signal PropertiesChanged for org.bluez.Device1 (Connected false)

but no PropertiesChanged for org.bluez.Network1 (Connected false).

Thanks and Cheers,
Kai
