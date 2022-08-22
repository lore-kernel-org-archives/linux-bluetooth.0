Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA8AC28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 16:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235834AbiHVQMu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 12:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbiHVQMp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 12:12:45 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 23EFD3C151
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 09:12:44 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id F25AA826FE_303AAF9B
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 16:12:41 +0000 (GMT)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id 64925826C5_303AAF9F
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 16:12:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wtjk0DSvfEmpVuBNE+Jeuo8k4GXwhYhdMmpxm5SKWmGm9MIGa1lwA1gSq//3TvRMuA5OUiny2UDaSyYeF8p1IP8aa8IqM3XQ5e1d109/GAXTG8hfRziyh1Hg/GQE/FHATKc/xx9veW059m4NOnngW3RjV0owYXVzIGFoTi/fh+JW3mYPupuzpKiLaK5NYlNAMxEsfo7hQE9hWSR+dIiC3QTgN41yOmnr1k251lRBuayw36v0q7isaTEkTI99wkCh+w4ENAvjQ/iZgKwJy+1pLqUeGrRKyc8l7HCTD/ao3jhGKhSP4FUM4KZ54VzoYMRzCuwcRUD2p1C9JyUAaMZqew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2IW9hjXcywMU/FgQsxih7CSGnj3PfySxQDeFxnhE3hc=;
 b=iy1MASAKl8fE4wLeaFuX4cEdV5vLbI0yER9wnZA1I7ut9BMbWj5GHRQDCMpT6kCFmkplHV1qhor2duXRd4Dwo/RG16IB8LVcFiNILxi3LqwDLXlbn8mI4+/D318RQv5sIpPQRzew1OVkS65cEKznoiixEpLHilYjJTnAozY7RZd/HCPvS+F0L4O7o7tHP9f4cPK077rbFwRUAnulLRtjRJUKHzRqtVt7OoYke6MOdxLKln/1oDS+DIR9bX3BRbMDXRgecwL3dClrphGyu7VCqmK0ERFYLteGr8zHP0rzqjYE850ku+/cpMn4B5/xQN/NGbe0JLUDYaGn1HorIPDDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2IW9hjXcywMU/FgQsxih7CSGnj3PfySxQDeFxnhE3hc=;
 b=ceT1HMQTF/shC/U/jgr5eoUsFyQAQkGkBYExXX4gzKDnsvM6AfC8BfqyaXeWMgEmZgYy0zP4mrPxjkKeDwtX3kk7eEeRVYNxze/A2lnwNnnkeeRHRKtHEcEy9Di86v45m0MBMVJ5rMl24k6cmYNfrovBRf6aquO17yH0af+A+LM=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by MWHPR13MB1485.namprd13.prod.outlook.com (2603:10b6:300:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 22 Aug
 2022 16:12:37 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::d91e:2377:f4fe:6909]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::d91e:2377:f4fe:6909%2]) with mapi id 15.20.5566.013; Mon, 22 Aug 2022
 16:12:37 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Can  BlueZ D-BUS API identify local Bluetooth hardware version?
Thread-Topic: Can  BlueZ D-BUS API identify local Bluetooth hardware version?
Thread-Index: AQHYtkDZ85xlFh0YTUCbg6q+8uUcvg==
Date:   Mon, 22 Aug 2022 16:12:37 +0000
Message-ID: <SJ0PR13MB5755759CD2C40AE2F350A556FE719@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8025d980-b902-4454-4523-08da84592181
x-ms-traffictypediagnostic: MWHPR13MB1485:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P+IUta6sY/DgiOaHzsW6i5tV8syEIrg/qjT8Mp+2tyrl63gXdJVGnYD/NUVf1t9uzwRf8gfCyL3usvNX6XJXFdMVtO9mUtp0wpOx8+6HOMV9/Z3et6Z7ilviSs6DxBRxiRzrBPEH/2Z3exIIGJlXqXh0Z1W/J9oIiBbPob9hJ1TnN9ufzrxNY/SmM8XleNEkzV918ZmUd1DnaKh/c6OuE3yOCRjX8VeU3ov4SQWieQwk8QIO8lzb3oo20M3N9DNUfuuoWftPvzf8hiwkOFCvYbccvxqE3N1sgF+mqkyBMp5lLFwJwv/VOYpcwlstmaU7Afjzwa70zXfEiocdHMXkdEAeNjyLfWmKSUgOZ9BOMkkmgVK/8IAPIQJRFeAJqLe22mTy9Jn3AJMIV9WHogT78MW9O+WDYNrheYkcv1izjv9xniPCd6LYvPC9FLN4F0kWmV3v4Ksf+9iCHwCaVp4luNcBui+IMjVUjQphBuU99UH/NN49e8SV6E/YZy1iJ2XS3QNisX9FpsNGyFpMrtN5dtP7jnTTUer71okTjaWzRbYM+2LzwNCWV0ElCmKUd+PPANMrbv0KCh/A0yM1JBG9l0zdwOXj8F4c+R2XSgs0DejRHJKFjvXEa4FoOukZOKhthPz3lnobBhxcpclaCeWK+vEuGwI904nwyX4thvfdcdp0uhdUCR/ku5vuhJrIaOe9DL12P2XMf4PZezC+NnG8xrIqEecrZELqaYoFKjMOnYGnJZVwvsXX9N30qwGpPRKu2uAEKhDtLIsnPDRKVMUMpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(346002)(396003)(366004)(136003)(376002)(122000001)(38100700002)(2906002)(38070700005)(71200400001)(52536014)(478600001)(8936002)(8676002)(66556008)(76116006)(66476007)(66446008)(66946007)(64756008)(6916009)(316002)(55016003)(186003)(41300700001)(5660300002)(9686003)(86362001)(26005)(6506007)(91956017)(7696005)(558084003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AZ2X4j6sQruw6R4DaSoU+5c1OTFH8MySuF/dYlkeOJfFQ7JUQ4n8wTHVOW?=
 =?iso-8859-1?Q?jTDaVsrIcIecxRPyPacYZFM6UTrxVIDCDz68MIF9kHv2rdVZz3Ap5/nRbj?=
 =?iso-8859-1?Q?9fXA3A6LZyOKnnJy4XqaM1OvuG1V0FxaoJwl4cSzL8r4/DvEvzn9ActLLb?=
 =?iso-8859-1?Q?15aSNNFqv+kl/5WYn/P/5qye6zTfxXauvzzvZyWKeBU9P2donug0uVmFAm?=
 =?iso-8859-1?Q?ZC5+C9kl1xtU4CXw7X1EA94Og217J1TKQ0z9xfDua6RAceDVHRJp4kgEMz?=
 =?iso-8859-1?Q?HKtOGgh28Hjj76Ki0PvKErg2vwiZq6VYy5NnaniYAG9p6JfHIhiRnLcW1G?=
 =?iso-8859-1?Q?WQap2POe+sLdwWWEbD0jShNyMg0783FN7r1gmma1iiC6VPdH2QRAaF2aO8?=
 =?iso-8859-1?Q?80/ml7zK2AcCyJQJRXdQ8ecQFpvEmqREc+2HFXlkYSFUkbm3whGsqTpLxe?=
 =?iso-8859-1?Q?Tue7RXsB3nWGnaRsaiE/6etyLAONNCZAT+I2my7fvkPC5hODTwErsXpzRR?=
 =?iso-8859-1?Q?J6nD8PmB12+WTC4KmH4yMO56/D2rzlKZb6vYSW7s6Ns1K4ZKnoHNUcLFMF?=
 =?iso-8859-1?Q?VFstah67dyzeATnDZBN6RM4rNv5IzZVHh6QT9ht50fKjLSLovaE6oUWzIW?=
 =?iso-8859-1?Q?G7iPYAEmtw4r85zjGBaVeMgvuwLBEafKeQJKDVXHN/9tdbCuJUDrjVELh2?=
 =?iso-8859-1?Q?ykK3+ncQ19HwW5oNx9QMRnhSdHoflu6Z6clrnTyNqJBUJed0sbK7abJvRM?=
 =?iso-8859-1?Q?kmzV4GxRhvLW7/NdwJM/1cSOPgl/dZUoPurZ05Et48otYHG9aL2+emaVtd?=
 =?iso-8859-1?Q?Q7CGt7l48au663FQ1TYmt4zv7dUXn3vKEBEqNt6QntqJueKLqiHXbMl2Hk?=
 =?iso-8859-1?Q?g/rPcmGCmYdx0H/QqQqkf1+aOgkFcRc95ovYwEyoVKTYMvhgpjo3qh5FBh?=
 =?iso-8859-1?Q?N/l35VkaPuBYw0HvIdGA2sPIVoYDNZG9NXzmjUNyFxUiAH2TOMCVvCjCO7?=
 =?iso-8859-1?Q?6N0CDw+wbGTP/vnH+sXK0GPY7KFDv8M0pbBfQ/tBcpWOEU5bmwliDgrygF?=
 =?iso-8859-1?Q?BVzFIkmKyW2GfHlQPOssFKHQOLWq9C1dDhQbXQMqfTOLMK5L4HDjhtSHA9?=
 =?iso-8859-1?Q?F++7bsOISepLz+Er/eMoPG2vj88Xd/WJKUR47E6c4vb8WNfKNRe9mgYzxJ?=
 =?iso-8859-1?Q?iaglfUhxeEIe68oA03Ivlew/f6TiqS2vBW/+kxQpQYZ+jYfuHU0rFXXz36?=
 =?iso-8859-1?Q?f57AqdWyd/Vq2CGbGvPP4qjQITcCekFab/+z8KeHS9PZ5IkDZHlvLmpMgm?=
 =?iso-8859-1?Q?Ati9Rmxcf55KxNCa7JTFMFSx3JFAzBv25cBckFTCYvlYD1YpH5FyrTXjS2?=
 =?iso-8859-1?Q?8LEElYMS92Pjw4u7NVfeTD8SnCkJBxPXeORHutnTRvxO5OLGPVnkfFWK5L?=
 =?iso-8859-1?Q?o4WmUXZWH9txwTlq2MqxPzmg1H+oWH6JoTfYIlJW8hOsUgnCX/p2DrDBCD?=
 =?iso-8859-1?Q?OjF1WW5VDLj9vdHlXg0k7q0hFGow3t/LOFSCNlAPnBvn7KpMIBQcdE9NFc?=
 =?iso-8859-1?Q?rPF7FP9hFAqGoRaOa3jumurG4XBYbg33Wt7lu9/0Pfmi7MYOeZpGu8WhLP?=
 =?iso-8859-1?Q?uQIgGHVIi9ews=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8025d980-b902-4454-4523-08da84592181
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 16:12:37.4953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8vUIL9OyZA5F2AGp95mG8VF9VYgG3rHDhNdAcc8lABnBx1GFkrW0A3R/MRakzq4KPe2R1DJRR1BGw7UreT0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1485
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I did a diff of "bluetoothctl show [addr]" between Bluetooth 4.0 and 5.1.=
=0A=
=0A=
Address was random for 5.1 (will that always be the case)?=0A=
=0A=
SupportedIncludes: tx-power was additional for 5.1.=0A=
=0A=
What other API's could be used in a program to discern this?=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
John Klug=0A=
=0A=
=0A=
