Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C569C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 14:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiFVOp5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiFVOpz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 10:45:55 -0400
Received: from mail2.multitech.com (spx.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 154A23C4B0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 07:45:54 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 9CEEA585439_2B32B22B;
        Wed, 22 Jun 2022 14:45:54 +0000 (GMT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 371985853B2_2B32B22F;
        Wed, 22 Jun 2022 14:45:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkEtroHars1GKijKwC3T8hbyNnBVBtwIXH6eugqzofutJes4C/ThLLKmT9DknYyEa72AVZnjVTBa7E64GjvNi/wUQkZGINe3/Krxc+jjHHzIXJCB1EKmbhk7OhnGqFp00u6u0MulJRo1KRxFiUfXnrOD2wsAB2HhUpZ2HL4haIzYdrWDtr8Q1CZSkdeCV5K98MJN/A2VpfW2WrScC2De5/9pe417lvYJL81mFmYSsgS93TXRGYZ+O7rQMzrMGBgmsq78CHiPevZMdh4uSJY2lvecxAIpXGkxWSxSt13+IJMVUiHla7CX3kOhTjuZR4RASVMEXY6TMl+Z+fA3vYui3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdhQvUc47O+iL8dZeGPN5Q0olunc7TFycmkoS8R4coU=;
 b=hxxfd9EyFPH4xEwe6K18oqcMw2VJF75IcbYPxtvqaVN62yoQgXX7zlDcg0nqVzrzICMR7hQeAKra8BRuAXl2O7stmFStLc9Rnj81DqLdpYswHZG4aL9hLPE+qQsWo5wB8X8tk55NhgDOgOv3Ooj1F4ojWfDrj2hK9ZP9ZNLyd9Tm90rD/kFt8IYWfxLrnM5tudjwJUihUmsIuSifbdsdSybmdSDIIenclReJG4LhzvvNdPXLaigjAGJLdE5flRL1BaCxrFnOCY4AYvfLZHa49Ba6+gnE2mZYZTksu8XLGXluN34hYR0PsaHnWPVfnjKK+v6jBBtR9RcNBJWmzKiQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdhQvUc47O+iL8dZeGPN5Q0olunc7TFycmkoS8R4coU=;
 b=cMcimZDN67PDUx/YV8MqAhxQSZHTIBM+/ox5kUuxvPCkIVLJP/2dhBL0qbFksVeeMcsAocorFqairGScWiCiWXZzQN64jXLDC+OszepUl/lV5ery7RnMu0FOQ+EWpsmaCJrdS1VkyR3CGPUUTuItx1Ja/Bam2EIciGdbTb5NBHc=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by PH0PR13MB5897.namprd13.prod.outlook.com (2603:10b6:510:164::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9; Wed, 22 Jun
 2022 14:45:51 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%4]) with mapi id 15.20.5373.009; Wed, 22 Jun 2022
 14:45:51 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: Is there an attribute for the name field in bluetoothctl?
Thread-Topic: Is there an attribute for the name field in bluetoothctl?
Thread-Index: AQHYhb2zHja7qealAUSxpq1rsMtkZK1ahSeAgAADEf2AAGqqAIAAjQ2M
Date:   Wed, 22 Jun 2022 14:45:51 +0000
Message-ID: <SJ0PR13MB575503F5C2DE6B229D7DFE40FEB29@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755B778B99B396FF0FF6E55FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZL=kGNjpR-E94tuTtU23PYn0d4qyxoDkc-O_EuxS6eZMA@mail.gmail.com>
 <SJ0PR13MB57552921E32DE0017E2584E7FEB39@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZJ3_U8jdT+Xqp-DuBj8vHq9UAu9Us=kqR66v=4VBfp5ww@mail.gmail.com>
In-Reply-To: <CABBYNZJ3_U8jdT+Xqp-DuBj8vHq9UAu9Us=kqR66v=4VBfp5ww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: c89e7d9f-cdba-878b-2114-8a269d9fd8ad
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54ee2cf2-626d-4f1b-19b2-08da545de750
x-ms-traffictypediagnostic: PH0PR13MB5897:EE_
x-microsoft-antispam-prvs: <PH0PR13MB5897D20573EF2857B41DE13AFEB29@PH0PR13MB5897.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2uS8JjZ0sGNYtaUy2BOMYy10KpyqWkoLZnrP40N4Tn6PPgqdzgYrhHCXIvhCpGJlIGmpp3vBQCWzhlkJ3ioxpWfsJA+NU0wMWB1evoNaBHfHWcDIqSKnQK5XNd9YNwHy2Hb+eQ1Iqv3gCMZ3Qpc7YRf36StMZwHLOz9h+0owbelJM6BKZz/bz/Qc5npUeDGF1hpou7X+uFen4eAbtLYLasY2fHXkOyQTkFmEFXhn7hpg3F6GInAwJRJXLbcKRBd3HASD7IsEii1yVqQl87KAdzi0yzBiMVVO6YztMq8/zhSEApXtQSf+p5OJMlc6WopwRrpfAaNNEHf7AQYd/V3JxApbr1lewt/aBnAlzTWRP3DBbozGFG/KK9SHLZOJrmza0UjrCuj6xbWu326NE2lAjisPm1gK0gJyOtArznY9Nfb3D2iUVcPt8CxsVgwQo5t20UCqYfbPbk2IuPBrdrEabGJ3wnAkAtkst3EWolRaU0y2mXcrU3XfXcllEatLHjn24hxXuhVdiMEM7ExhBF8JGN/DQr7inZ0XibI8OUNUvSsqJWxpdOvPRSFQx1tJHz1UHG7+a8JqKZhocic+t1ha9m5wz++7QGJpTm75C2iIYFycjOClzcVZqe0/3CLykng1Vz4Pax003UikKQF1psqn4aDlbuMHxhkXQVJ1ij60Nh7543YOfY/bgJmjnmVdS4HQBqRFdYuIkWYNM+Y8/XQehBvOEP6VHwEHayHZLKWHSFGH+Bstrcb7OYRNpfYOJp0+joM5EjlZSCLGExLSYUpDbukjMy2qMK6sqxgp04QyhfNC7XOLbZJ5L4fjwuNe+89X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39840400004)(366004)(136003)(26005)(76116006)(2906002)(8676002)(6506007)(66946007)(7696005)(38070700005)(316002)(91956017)(66446008)(66556008)(64756008)(6916009)(4326008)(41300700001)(38100700002)(8936002)(66476007)(5660300002)(55016003)(186003)(86362001)(52536014)(478600001)(83380400001)(9686003)(558084003)(122000001)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ybNCHdBEfi8UPioCXxFOrxx3F0bOHajmoecTqZDACpG3x0K/aHxsNrIZgz?=
 =?iso-8859-1?Q?a2w4SRx3D/m4N3BEIP3B863SI+SMpJE5ipw+zCgcRqFy9GvdrUJg4fGi9G?=
 =?iso-8859-1?Q?u7Ita4NpGpzqg8lQpcIbLaTB3ut9vbwnE3QuV28BC++J8yaOOxKuVgBx/R?=
 =?iso-8859-1?Q?W1qA0WaNxQit4h4cCjo3I+sj1wdC9FS7raNiDDh9Z/k3bkvPOzkYX8OTfL?=
 =?iso-8859-1?Q?QAKZZcun3svPWICqYmjY6JHqgPtN3ITecLqYRbzMx0Or4wDFgXY9VQPNzi?=
 =?iso-8859-1?Q?lP9rvxkeOq8oFHwpUm0ZUccu6eez+Kz4vetWHq5yIJ6THeV0sGz0EiQsob?=
 =?iso-8859-1?Q?RyzkHRmNtD2gP3rNf4h2fK+NFozf0m48mvdE6NE5cQOKGD19OXPXpOPyDZ?=
 =?iso-8859-1?Q?aGsleak8Pva+/4LxaPVFKw0Mcqu8MQtEP4O1D3xiPXxm+nCKktC5TZiSyB?=
 =?iso-8859-1?Q?G8UhZNW8MX3hUND7cUFPsjYKCe5R3cdl812+2slm25d9KP6gqp233/iNzG?=
 =?iso-8859-1?Q?rJHl9DWOZNSOWlzi96iy1ZbwvRGEBIKAr6dcmkEa9RaTzUES9bEPIu5BZC?=
 =?iso-8859-1?Q?tXnw6PkBjbN0FLqyoiksU7iTQKxkipuINDPegyvRtI7LTLy8K0rut7WjOL?=
 =?iso-8859-1?Q?O0+GoI4xg6jnq0LebFyf7A3aL34mTVHqBPVCBjBVWM+aAmXfs3Hb/9jOti?=
 =?iso-8859-1?Q?zeAWdfGUn881bENZNPlc4VjBNrDnBLOgghxKTDLjx3u7t95GtYYR3ie12D?=
 =?iso-8859-1?Q?Gwex/N1mnNMgK4sIRXA3+msLur2j1AOIq556/HXtYHvLwnjxha569FTQJW?=
 =?iso-8859-1?Q?+IvIZ4ORfbpfGnBLHRLCqHOtUkfvpFZ+4EDQpRWYQImaoFGqdsnWDZBbRs?=
 =?iso-8859-1?Q?sL8vxXL5xcuxyyX+VazAXCTTFUDrqn+OIp+F9Gz8KKi1PcL7dKGlMWgQqb?=
 =?iso-8859-1?Q?VqLkdlsuuT1s6sgG9IJkRXJ19lpl03y0twhtUOMcc5N6uz63Cl0WrlMpOA?=
 =?iso-8859-1?Q?dLZJMqUdke18KK6dHoYTXEkrFgUhc20K27xPP3AaGR8ouor4xi4Nl9fggY?=
 =?iso-8859-1?Q?c6H1faejyggsHu/S8FcLXPOTOJD51Gtx5LRHUQm/BxchnRsg6ePV48xCOs?=
 =?iso-8859-1?Q?D/iKLmgwWbZCxvDCHBBJUA3l2tBC+Dm3Y6/2B08lJW7UefSQ1rZN2+WSKj?=
 =?iso-8859-1?Q?yukbJNHO6wke61rQSv7w5JQv4uvnIqPiI0zezQFP2LIh2iQWmdtdsHBjoG?=
 =?iso-8859-1?Q?3kJXhQKK7OvnBbUgNOMo3ctOoRIDTtTF/MZDeUGbtT2yUtCV/p0ID1ulgR?=
 =?iso-8859-1?Q?f068k/MK7oo5hGCOLOAXNlRQX1ETvyN6wkrY2XONdTWUn6FCl4DeL18QaG?=
 =?iso-8859-1?Q?caKxAjrS4GNdm1NXpJQgg7+OqhS+dP7dKwWXOUgqngp6FbYXQ6CTI1UePH?=
 =?iso-8859-1?Q?uOjcUUabkSRsNyxGJZS1/VTX+2dZMet0vb/tOQEy2oiLBE5Zz9g44nfb6/?=
 =?iso-8859-1?Q?w0gDsjFj3C/92ZvcoaebhRaadytGiSLWjSRljbcGAhBd2e3ciuoendITZi?=
 =?iso-8859-1?Q?NbA2W+f1PxBRTveVri4KfrvDVH0WmbyZE2s0Tb6nEop83USyXRpT59fRFC?=
 =?iso-8859-1?Q?y44eKIzwuWJ9M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ee2cf2-626d-4f1b-19b2-08da545de750
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 14:45:51.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ya6mllIIfXAVptlP5dsYAs/Mi0rsRJCQmIuVnukkpEyvqOwJONIkxZCT56bJQ6R9hKgoXp6U4YpujpscGSk7rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR13MB5897
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thank you Luiz:=0A=
>Anyway,=0A=
>bluetoothd will read the name and update it on device information e.g.=0A=
>info <address>=0A=
=0A=
info <address> does produce the correct result for the name:=0A=
=0A=
=A0 Name: SensorTag 2.0=0A=
=0A=
Thank you for answering my question.=0A=
