Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E13BC32793
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 22:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiHWWJr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 18:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiHWWJn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 18:09:43 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 91616726B3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 15:09:38 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 834CC82982_3055021B
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 22:09:37 +0000 (GMT)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id 4D00D82698_3055021F
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Aug 2022 22:09:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFG+jJ+tFOuUJeJTrFPUuDw8pkRQnXGI1PIEmDBHZtoZphsja1agiYUtwhXgXcxaQ2IJdm9HCLZ0mzCZtsaW4ZVXVqZria1xwpFZJJPDhiQIsUHTkw87kcG6ERRIYUffO13XGuNduKVSyOdhGFDLxQPo3hh4pspohOpGMWLaiKdnIuElKkzhXlA8vDj/JX1DLZhX4TPGII9ni/6umzN2zOmTSJFpFdIxNInUIAZKzrG9x8KF/2rn0TNcb4Waxz0RMwQg2vvtGngm27MYTOzd37ZUOrtxLlJZBPfS9eelr7ESWCfW2583+BGC5jYOW9VBACGJchrm8aQos07wQUUj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0Ij0wE2z7kpttO0Nku0y8VUfKMlgI7dtznYu/UqqvA=;
 b=Wd0lctSDyWTPd/OXY+A88LfC1nKwV0/anZQOkBGMZav3ZNWIl6iMCx7eu5LbaodZ0+ryGBpD09uXYUxK9LKwWixDEbN361FeKvf5BmwI7fTGYIk7HCx7YZq+qJ8aI3Qc/OJzpw8HT/t18EpJWmL8kgB8uF3Vl36DgWzxHHTxyN5YXpmNQ7ABzChbYhFAUwJ3JfaRpch3eEJfVJJqsOGF9kzCJglJcq3CGbKK4NOeCsoV3OvoIk3I0F3kBAh1hpKqSOzLDeDi6Sx7MRbH1eQIaC/KSUJV+eDnEmiWDqBJbpntIQscMBMzwXm83jku91re7iKgHRHzIoCfdjJx8XKbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0Ij0wE2z7kpttO0Nku0y8VUfKMlgI7dtznYu/UqqvA=;
 b=UYguZs/G8wHbS67VN2sVUZlpgaYbdFzWMxZT1M9fM6hNFhtyP+8NevfPmxmzSJ2YcUw1UoigRq8mXXBcLi0mFhvG8YeuGtP3NZYSe4konYYbfdYWc9yZzPcKX+BLxwcKtxGq50Ozes6ZVVMHCqSu1NSllY3lOj7+Do9Q7d59FIk=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BN6PR13MB1537.namprd13.prod.outlook.com (2603:10b6:404:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 23 Aug
 2022 22:09:34 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::d91e:2377:f4fe:6909]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::d91e:2377:f4fe:6909%2]) with mapi id 15.20.5566.013; Tue, 23 Aug 2022
 22:09:34 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: What could cause pairing to fail when bluetoothctl is not running?
Thread-Topic: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Index: AQHYtzw8aX+AMqMTVUq2gGKcakou3A==
Date:   Tue, 23 Aug 2022 22:09:34 +0000
Message-ID: <SJ0PR13MB5755C6DDC8E269258C410586FE709@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5dfc343-f06a-412c-29fb-08da85542977
x-ms-traffictypediagnostic: BN6PR13MB1537:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oHUXfd0W492jk6BRElSG3mCKkTzeBP8dLPA/wyLekWz6y541WJ+j6NkMmkcefqbyEgAinTePalIetDASPCraT4FJx7G+/yZ+kU7XlyjpfbxdlOX8pC8R9AJUkM02WozG+bDRVbLIOEs/kRay4o2InzxxkMjo4Hb34+FmmyZv2ZDXDkaR6OoCl+qkoDSlwtOdUyV00CTUgseBh7NcYT/tY8CkbV95oAzWKzbyjw9HWCyX7G56CA/6GEhDWloVhZQqcrEW20gYCihExBvYCuDZmH81vp7zntEGl23UIb/W4lR6OA9bIvBBWhkGzrFXm7fEQxuTFfR8dNbxId61pY1GUU14CJtZp9/5Qo9S0qphTnaat7Kgnf5tNjAXph9b6llNPTqAZe3Nv/EojHgyT+xAtmQh/2o6/mljdDYGqRnGeMe7trOwDTJvz1kpTtAD3bTsN3TtsulRr9UyWT600q2uuS2Qx8Tanmvcn7tIO2iZosgn4Dqv1inWX/NVkEqxLuFI7tY/08uDS/TDHwdnMC6z65qau6kWJXBv1jLvMKEozbKC50VZmd6D/q5hYG31KQgz0DsinBgi0s7Til2JV2orvP6ekfBEgJ6Zvah/BpnRYWnoP3IBrjOMyXhAo6dCfejllKl1lQTkTev9zcOjOp6UqzF5Pt77ros2PNZk3mnUvneHQRzqFIOA+CxAPShcqPyjtGezqfP7vo0C0NHV/+QeG7UfA1pZHO6fcUIQXo/JdOX8xmR1rFkmkub4vTYScc3i1m9rmjbcGoIBZPqQDRmXDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(346002)(396003)(376002)(136003)(366004)(55016003)(8676002)(66946007)(2906002)(91956017)(6916009)(76116006)(6506007)(66446008)(64756008)(66556008)(66476007)(7696005)(186003)(316002)(38100700002)(33656002)(9686003)(122000001)(26005)(38070700005)(86362001)(8936002)(5660300002)(478600001)(52536014)(71200400001)(41300700001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R6kNedtDCjH+TKkP7lQanWXCJdQ2DYSCHYsG0NURejAxKcRTCbGw3us9R2?=
 =?iso-8859-1?Q?Yfb/d2Jf1J7T8EAIDS6A7dxDZk6bWpTG0krOmjM6lgSrrw0i1HxkErzGi5?=
 =?iso-8859-1?Q?HdVzjTXnvE66ZMDyAxGsJaMR1n8vcbyBtmXbS+bh71yqBk3vmYSBnXJgKW?=
 =?iso-8859-1?Q?wGaAzEJDBA3yotxtulkOzshHq0DH4hP1KnWCTpvRzSXwOC1rLSzaaHz5BX?=
 =?iso-8859-1?Q?ykRFU8GXMz9WVu2DqExiiTlcKYAXc57s+uJ/hUzbN6MVblActkO4T6iTK2?=
 =?iso-8859-1?Q?PrDMTc0TROZptb4RazfuHcDemwpEQ34q/Be5N5x0IICc39xoegBQUleBlm?=
 =?iso-8859-1?Q?ZNYdpC/W0j3YsE8StHVaRUuPH5dHZUkxGLbbuICo3YQvTXn09cIEnvolWH?=
 =?iso-8859-1?Q?TWIGi69evQB3qnccyYnN3bSyFzViJgNEaL0oYkst2KXobMylGPLQ3gv6RB?=
 =?iso-8859-1?Q?ni06cik3tWxaqgHGhbdjn8FumZQpUkqv8ol1lhMpNdI+MJ0xi7Ij1OdrS1?=
 =?iso-8859-1?Q?xI/g3zrETDf2BYapOyGbn8gGWNG/7Vo2i6tcTp+zqiVzFWL4qgpYl4XeuP?=
 =?iso-8859-1?Q?yT+wHH3hJ0hoU/tL9Iy8CnOMwhcANzB1i5Fk/TZ5Hvpd98umKh4Ds6rSL0?=
 =?iso-8859-1?Q?CSTn2AB26FswVnyIktYcUJMVg+dQk5BYpB6nzwHwHSHuJkGYVTzNV83ehf?=
 =?iso-8859-1?Q?+mcZHWizNiZE3k4cqz0J5QMigMSs1OgHIA5OSPd0ECJhV4a+ZWGcTCjaXi?=
 =?iso-8859-1?Q?9wjSH65d0KMrqjkFVoOb+jxiEpiqro2PSRjeeK7tEZgkYAovttH38euayA?=
 =?iso-8859-1?Q?NsJCRGIe8MCF8TKZcLEa7QMYZGnxlRBfe8+Kd84F376Wtv10ZL6kk1714D?=
 =?iso-8859-1?Q?hW7YFLqbSJ48DxPWaGlcfE5a1+BZJliT5DMo23tiY6Jf0Fsz9Toz9+mY6x?=
 =?iso-8859-1?Q?WNKWxVxY9qzT14JVWfqo+/rT5KFMakxCHyPoxA+CY4HxlmFog6vMbC5+w8?=
 =?iso-8859-1?Q?vpG7Vej/Sf7ZwojCCsHFpfXwp7f1XjOrv0CN8HFFuACMMpnQZ7orMsNJBp?=
 =?iso-8859-1?Q?rVTVwcL11oMLpsOAyULdqk9H3RDUSLoX0NBG+TTbdRLHwK8CocHIermjjO?=
 =?iso-8859-1?Q?f1s9Ojn9OJvbMS9vcZxJG1JYkL9rwzc//V+yNl9Xil8Cf84ekmBXAyNBtB?=
 =?iso-8859-1?Q?zXsZIIrFqpICVQOJR2i4zsYkHA3sjmjH23rdlFQ1go8iGiwXPRrUKVYrYn?=
 =?iso-8859-1?Q?Nyy3OD+Z/4b1s+haE88ZWi98PFUN0jvMve/VkbTsgv9seoXCKyA7O+RiSD?=
 =?iso-8859-1?Q?qpz5QTCXcSxc/F1renwETILy8UsR9b58gPHbiiuGGyYh1HswNM4jpAW0oG?=
 =?iso-8859-1?Q?ez6Ppy+NTUmkCjiF+EB1J7YRd7R57GR/Q70MWIAXhYqlvYNn6HMTW5PsxY?=
 =?iso-8859-1?Q?stpN8vOplRDi8kF/UhZ40c0YsexR6ahPYJCdR2Nfr/8+BrgU3s5IXFDrB5?=
 =?iso-8859-1?Q?GmfQ56F77P5pfxrxZCxZxrTAaQ3bKF5pDfvvcqHHSjRxNbvUHIfIcHmaUN?=
 =?iso-8859-1?Q?NggSZ2yZLa98O023ruV696p1TwAa8zulFubc4fc5TDRe1G/8xG38W7G6uy?=
 =?iso-8859-1?Q?GsSdOquy4k4xM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dfc343-f06a-412c-29fb-08da85542977
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 22:09:34.5300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pWvc41rmeK/aov7r8vVq61hQE9GDOg4ABjbljpbDHa7kocNlNIw/+1q7HfC2uRKruJ89hIT24S/3b6SIItwZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1537
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have two different hosts on two different kernels with the same applicati=
on written by me.=0A=
=0A=
I tried to make BlueZ exactly the same, 5.64.=0A=
=0A=
I see no difference in configuration.=0A=
=0A=
The application sets trusted to true before pairing.=0A=
=0A=
On one host, bluetoothctl must be running, even though there is no promptin=
g to pair in bluetoothctl.=0A=
=0A=
On the other host, pairing occurs without bluetoothctl running.=0A=
=0A=
kernels are 5.4.199 versus 5.10.120.=A0 5.10.120 has the issue with a bluet=
oothctl requirement.=0A=
=0A=
=0A=
=0A=
John Klug=0A=
=0A=
=0A=
