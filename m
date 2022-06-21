Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2535C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 23:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354971AbiFUXC0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 19:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiFUXCZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 19:02:25 -0400
Received: from mail2.multitech.com (mail2.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 06DB11E3F1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 16:02:24 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 9CDC9587EF9_2B24E00B
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 23:02:24 +0000 (GMT)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 341D458725D_2B24E00F
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 23:02:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgY8gFyFZ6cr63yEYw0+4uaaqZt1fM9DVfaLCQbKohRbwhJa//LhS2x+pdL9k8elhBwbpYhFoBPqrYoK4DFoW94YALtpadh9kCfcovK4pDbaCgLl6aDkUf3WxoBJOZ0fK4rwQgM199IkKPudq6kOmjoNtCvyHEMMlTgc06FOLFVLKKKLI9jHr+XoYKgREj4wU+6Mwt+aPjZdM1WB/YyqHg0CQMSmgo6YAxaFZ9N6chFqkXQoeGtaiq8fNnzYJMbOfz8uIJb2c1IDb2Z4tMXHEOGezzJAVlj8XWwdkyqMKv6FmCUSGwRe6FXy0hG+d4Xu1q8l8GLJ0KOUvHtgCamp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dgt7RORWG4R9OgOSbE3nRkg1SUBX9ZhI0X9RjhHQbtw=;
 b=J92VMrAXp3w+7dMDqwA+I1y1RHsxkyzlrJcSJ0NMRnBzL7zaxWmO4bangN5aM2t/ftY6lu1FypWiL/m6sxJ/GT+qVe4CPfuHgb8wbMpwa/scvEEOPM3cG9PjaZJrp96RNmX/Q2mD0A1CIjXOFvfGX3zPBDQfWqMypa9kLkPFDLyNCNTYMHoZxm2jjO9TZtpUbSP0XKtxSg15Hqf9FWmao59BIPVWTFF0Sq/vRgA1A7zMfmSv0PgyZiBI6e0qQcJ/KC7kt27jfKgYBVTTl4XnlS8OjGtvmK7UxLva2uQOpzW4qbuB1g09Cq1WEP8ph54C6smLnSKR+3tDhuPeGBsWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgt7RORWG4R9OgOSbE3nRkg1SUBX9ZhI0X9RjhHQbtw=;
 b=Cqu5wL1Zm9M0lpzQdUAxK853m63aq/meAntt+tVfJ9oQ/KHa64YrM7H7vwTCH6BdUXHJGApqvhkl/BobJBycW+vwcnOtyVNDo4fx+BFkX8yUKjFfYz04GxWQMs9jyaWLukSC+He/TMr0vu5Cqj0CrCp9vtwZrlb7SWfsjpnxJ4k=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BN7PR13MB2290.namprd13.prod.outlook.com (2603:10b6:406:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 21 Jun
 2022 23:02:21 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%4]) with mapi id 15.20.5373.009; Tue, 21 Jun 2022
 23:02:21 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Is there an attribute for the name field in bluetoothctl?
Thread-Topic: Is there an attribute for the name field in bluetoothctl?
Thread-Index: AQHYhb2zHja7qealAUSxpq1rsMtkZA==
Date:   Tue, 21 Jun 2022 23:02:21 +0000
Message-ID: <SJ0PR13MB5755B778B99B396FF0FF6E55FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: bc6a442d-f68b-f710-1b9d-e640bf407adf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc3cb4fe-ff89-49b4-7ef1-08da53da18e2
x-ms-traffictypediagnostic: BN7PR13MB2290:EE_
x-microsoft-antispam-prvs: <BN7PR13MB2290209A989847752445A4A1FEB39@BN7PR13MB2290.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xX2c32lTNEXW7TD89pLvrN8+ktFEZJw74qF2yTt9DKz7einAe34beQvZtl6TNQbt0v4+2JQZFUTn0oQQVWKHlP6bHvTZUSmBlyznN7eQpC7m9JEf1pqXTl0pEkI7vfboeRKEhBm7EQwOQqAyBJ2neQsCfODilUy0oGtpCTG4MvEKvcjWyGx5vipKLWEnER3sQa6bqe6J/235C5S99GYzYNJstmtvRvnt/wnELCFqtCppgzdqz9IHwSUZ9DhqtF3Y13bXnA+TyOSGW5LbzuCOs7xqR0v/gdRZDX9s/UVzPi1tlcYPO3adr9VaMBd0UOdtR1sMQ1Oz3RnPNXDKyUvaq7QeURMM+PJw0iIH48ckVRwwyGPFqhD0EVgsRY5RShfI2SR4uA0ZtHMgFeYkMC9HdrRhizSY9HyvuzioOy4X+UBzDbrLaLs93JDtcy1QIwo1hVDL1J6mlUhI8yStUeUg8E3QFCPBNpk8S5QgcRlTFxu0JWdrs9DoX9RiDzpaWWLJLweF7+IYYZ1LCn+WP4LpuXWwKwDk1E2HCdDtTC0ryEfDVPXdKPia8c6RmgLVz8qevXAOxy/OrtHFXodX3OugIDYbL1h4QLpwesMiRseaPeVzckeHKr8fCV15RlJ4xUN0fMEWTXam7r2Hjyat1VoP5m9KXsoZLTKxzXId+7baehqxVCi/WmCGEu9d4ykBw0bpP8Ws/EQCSumpQOAY01BMRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(376002)(39840400004)(346002)(366004)(186003)(33656002)(55016003)(122000001)(41300700001)(38070700005)(38100700002)(7696005)(6916009)(64756008)(66476007)(86362001)(8936002)(5660300002)(52536014)(2906002)(26005)(9686003)(316002)(71200400001)(8676002)(66446008)(4744005)(66556008)(66946007)(76116006)(91956017)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Cg+Ifb1VkHkEXRrqTXH8YbEgDMKg6Sy/RTVlUkGGx0fmkE7sK+fuzdv2sn?=
 =?iso-8859-1?Q?GnK8/6UTIHCU91PNMr9rwuZFSsGKpZmIg4vDGC6zXz4k8EfnfJbf4mDEMW?=
 =?iso-8859-1?Q?hIWK8kW1qdQwT6ZFBOTIXB3MXeRDEi7f086hgT2mg8foRlZpwsXC6/EnYZ?=
 =?iso-8859-1?Q?jXVyWUfLRZzV6K3ShUlLrYeXmK5uD4WewnOt7o/+gVNNWXaEHUSSazQDXd?=
 =?iso-8859-1?Q?3lFAUffZxblqd7kvMZOAalLx5toCH0kScuFoCVSYUffetzlU0q7qcNUKJU?=
 =?iso-8859-1?Q?ngmsxOvr+bKQUtjANYU+0boCGOlsdMrX6H3gTt7PgLN5snd1xJecA8ykI1?=
 =?iso-8859-1?Q?4/s5bHnkh+1c0ktMYv2BCnM4MP6/G71iRRDCDrASTC3eDc+Qiran7voFhj?=
 =?iso-8859-1?Q?Gs8bR4iS8wzFabtYUTRTCHRNE2Ke8LXrrjVdNGVtWdEZsley4CvD3vzgp1?=
 =?iso-8859-1?Q?kKfkWUmUOaHNEi5RiPTjitbfXe7IVrydINkZ9e5g/wQlPjaqb9fO2EzNLN?=
 =?iso-8859-1?Q?ZzMerXLt1+pYPWjG5DR2FiMbs6hQbVvJOn1c41Gl0OlqtceZoh0s8EbSSO?=
 =?iso-8859-1?Q?ni97/fx+Lsdh9/SD5TyRwQ9VcZ+3XdWNt/gqLaONuPcC5e93ze6WcDMYdH?=
 =?iso-8859-1?Q?m7Np1DD2hi9hiB9cF/86dwogAVbINR7OljdEKZpkbWijQK3BumKQmVehLf?=
 =?iso-8859-1?Q?9mzNZWeboBRyM1cqsO53gah7RoR0LnotM3fgNjdxD958THr4PIV88ygyT9?=
 =?iso-8859-1?Q?Ss57KXXVjLMwsetSzFvYQq3BWlrkTYKSiHBI1O/J0zzQ+xuKg417RVdMjm?=
 =?iso-8859-1?Q?3bG7PQM2BthktBVs2yR8BupHWC6kSOxD8cG2uemVlJ8kDsk/xl/E5newEN?=
 =?iso-8859-1?Q?/m1kbQQKgV3oFZcME6/rVZ+2Ro9KIiGmimTYpMfNlVzvn327nb0gai0Gq9?=
 =?iso-8859-1?Q?MuH0j6zvSfL4xtKagLoCeBreHWvrREhutMGNoYe9Xa6DQzy+mejjM8Yev5?=
 =?iso-8859-1?Q?chc4Z8NLrnnKz9w4ojf5iPc7faNCv8Ky61BpM9Al/TIkIvLs9qF4LtQrLD?=
 =?iso-8859-1?Q?OjvSZ6jPiWcGVJGcF139f6RBG9kf3N2yu8TdBChTqsZupWwoMVrPlmGMh4?=
 =?iso-8859-1?Q?VTnfbocm01uj8tvT6RBOlbdAGkZwFTKTgFcxXNv9Li+oOhPy+2iY/1Zx+8?=
 =?iso-8859-1?Q?sWqxnQBuo5aoypuiyHoDcichIfhRdloODlif7r8Dv4yG3BwCU51hQ953tG?=
 =?iso-8859-1?Q?+/GJNjS+433EKV1ZrIJDR9PkWguQE8zR1GR3X8jfMEPoK60b7faZR622Hy?=
 =?iso-8859-1?Q?Qhk1vvRsjq0vfC6zWOuT5SuhYi0YZgKBB0PQcDOtnNN8jXdG1x6AgxOmfc?=
 =?iso-8859-1?Q?+HCzfyf2NmbhCAgGb69Cm8tgUz4oHIGh5/Hs8dK8FdkLByOwKHDy1D3Ofk?=
 =?iso-8859-1?Q?OM+QLFQiwcxXmd2Hrxt9cP8Zpaw++iJkhUuH63AmsjOcpz2fJbAtpI1CyO?=
 =?iso-8859-1?Q?WTBQPldFZ/KaSR4ztaqNR1QtMtmkbUTOZay+EV5438vAk9w8qaF1xPzthW?=
 =?iso-8859-1?Q?+SBiA5RkbFSDnOZmUQm7y9x9cZMzAY+Sg9Aq6gc8i3SX6/9ySn2B6tT6Sb?=
 =?iso-8859-1?Q?mlC9nDr8H/5iVw3pWhAC4G+EtXfxhPkowWZDtRY6f9vD5JsogWPR06BHK1?=
 =?iso-8859-1?Q?2JNYaRIvYo104ZAuuV/xI+khlHdzHRg8mtNF7e1/YiRmuBPHyYaDP6yEPg?=
 =?iso-8859-1?Q?iXdmF0Y82b8GCCqr0wH+eAd6epoK5UbYHN0ai61czh0BGhcxywMsiyU2ON?=
 =?iso-8859-1?Q?Eo+ZEGBaXw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3cb4fe-ff89-49b4-7ef1-08da53da18e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 23:02:21.1590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q99B+11HWvzxOajoF0XhKDomjxjSvWFygcD5RqDYPEwSFFMCRGN7LuNEJyHotnPKSgyoVcti3A9xAbjNbiyqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR13MB2290
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Gatttool Example:=0A=
=0A=
 =A0 [CC:78:AB:7E:87:07][LE]> char-read-uuid 2a00=0A=
 =A0 handle: 0x0003 =A0 value: 53 65 6e 73 6f 72 54 61 67 20 32 2e 30=0A=
 =A0 [CC:78:AB:7E:87:07][LE]> char-read-uuid 00002a00-0000-1000-8000-00805f=
9b34fb=0A=
=A0 =A0handle: 0x0003 =A0 value: 53 65 6e 73 6f 72 54 61 67 20 32 2e 30 =0A=
=A0=0A=
From Bluetoothctl:=0A=
=0A=
=A0 [CC2650 SensorTag]# attribute-info 2a00=0A=
=A0 Attribute 2a00 not available=0A=
=A0 [CC2650 SensorTag]# attribute-info 00002a00-0000-1000-8000-00805f9b34fb=
=0A=
=A0 Attribute 00002a00-0000-1000-8000-00805f9b34fb not available=0A=
=0A=
John Klug=0A=
