Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E79C32774
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 17:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiHVR5J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbiHVR5G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 13:57:06 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B836345F42
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 10:57:03 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 2E10B826CB_303C36FB;
        Mon, 22 Aug 2022 17:57:03 +0000 (GMT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id AF5A4826C5_303C36EF;
        Mon, 22 Aug 2022 17:57:02 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5GOeMKTZj1rIoM15l/BZFftGCIr6ADR3mryjUPwfqv8kZfCtH3G7x9sukyPi2J6y1dEnBJVHZOHaudpEENSa9bE3WChsdzWH/Wf62OJ8Fr0mCl3OAf4MDBckGiar+P7aExiGs91Jjkag2s/9aSjFb9LVYZSpvRrOgkgg5AOCuGDpYxygFl8Vz3ZjFgxBcCpz4Q2eRL+VYKaRwKYpH9JET0YbhPw+zsiPLG2GJggG1F2J9iYSmNBI5jThIewPO3NV80ugItpSvznOqHRU13+Vx0GdOyNQ450JYuEwEb/4dHFOVgBm+iTSCeIvvYKeuZrPiLBvZDjX98TOY3DPKadYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hgh/4Ne+wlz1Zgx2nwCdhnW1aBVsFJNI5tS2mJrqw/k=;
 b=bx3mJAzERcWSttZ1X7MBKCP71/kwGqsILNLWIkDPhgsJDjYEu/ex5JXE5DnqX/tCb1CUNh2wX1hssYTQsannODlpsFkmNNGaIYtT6yTqP83e20Qz21tYvwxj61nShhmxYR5G8zLdKN/7VOyDoQTrkcFY/1n/t0Oyy/+0C/3wZKVo4XdC0SoSEe2oFqaIsWmwYaJiQHrlrhVW8CmXnNtQxtXgkE8pF63OMMLCJfsHDfVqXLIuHL2mVvGPcRlWUAFhyo2Ge9Pf8QNXVkASod5RElaSALZO21ORpYYFYDXO/d5ev8XQbkZLLqmgbyI7cVD4fiTwImzM1YApjgT7o/Af+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hgh/4Ne+wlz1Zgx2nwCdhnW1aBVsFJNI5tS2mJrqw/k=;
 b=afwiLN6/ehslgbE9I/Bsy3dlF61esReQ9IZCOGHq/UR0j3p3IMZrUh5Tf+taMqPhEr4eiTVCuL3BedzDJTR8YWKvDgLde1cx5D9MJFTzGAgB47DG0pRn1J9CnuMl/KLFnfy2B/ndDi3OJWzuOfas6GyXXhzE3wVHqeUS2EiI44E=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by DM6PR13MB3370.namprd13.prod.outlook.com (2603:10b6:5:1c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 22 Aug
 2022 17:57:00 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::d91e:2377:f4fe:6909]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::d91e:2377:f4fe:6909%2]) with mapi id 15.20.5566.013; Mon, 22 Aug 2022
 17:57:00 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: Can BlueZ D-BUS API identify local Bluetooth hardware version?
Thread-Topic: Can BlueZ D-BUS API identify local Bluetooth hardware version?
Thread-Index: AQHYtk9+XwYJLOn910G8HVFoQ4+IRa27M258
Date:   Mon, 22 Aug 2022 17:57:00 +0000
Message-ID: <SJ0PR13MB5755B59D0F772BDB0A88B867FE719@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755759CD2C40AE2F350A556FE719@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <CABBYNZ+KRZSBYJiFo2X5CXE-SuYyARScephbJq-nvN9oCH_iXQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+KRZSBYJiFo2X5CXE-SuYyARScephbJq-nvN9oCH_iXQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f04526c-66db-4a02-a049-08da8467b688
x-ms-traffictypediagnostic: DM6PR13MB3370:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ayqrd74MoQ8uVLB0GuZpBpCzkcSqjBHEUmZaMdUjSm1PBT+ixLFV7iOdcS+oXMJGXVvMokNLFuQzSLV/JzI/1KxtokM2Tv4O32ZabPExjhAbCCsZOl3YAAgsE7x3Tqb4Gyicv7KLrFwHepV8D6EltoByY1Fskze/PNu0A3bxEJh8SR5a3EJ+vH2mWOnoi59yFralwtYFVvZ7EAuD1jqAl2JFzRNmrlJ1koTk8KL3Y97Dx7Y5VBpWifqQp+Pj1R4/W8s9bzJ8B45Q5aYF3iacikfEcfFogCgGlWXrNWNXgHfOyjUqOC72Adt6jTEYT5SWblJkZLt156rqmb4Q0IbTA4n9lr6HmEWPK9rRbsIGkfbSYRmxoG2RbStQFA7mOAUmdzbYuUkUErsaviPorW+nc50XbwAiQTJqUks5ELbNhUXgr8CDTPCfRo9i6WbFUFvxqrYJB/b7E6KESMjPEMxbRbg0caKYksJcGKXuso9PCnNXDnliIOXZRT+HyH26lzLvfV0rfRYbqCbKsvim2J05mnckwwcgvCM0HUkSSsnu9TNct1fHqWEQnm9nop2+K1Os3X9xn1WKo1a/NMxQMqlSeUKtIwzfFb3RA66ioy/F6y1atCh0SkGkKLlzQbPBcyi0hxbm2JZ/Ob3wENaz/YBzmUutA5kHcOhUma75gVhuzQJ2fHP4Q54tog/qtsd8m6MZEa4WVAwBswPKzwJGM/7NBAcgygkvYMTgQWVEnDrF9NzJab/c+jejGf9Y+Ev2YdQ50L/R05E/8ErWKqFXD7ZhJmCx1ZKjZHXM4vFMAaR7jLj9kfoHp3Sj2wq0CNQmdIz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(346002)(376002)(396003)(39840400004)(41300700001)(38070700005)(7696005)(6506007)(558084003)(86362001)(33656002)(478600001)(9686003)(26005)(71200400001)(186003)(66946007)(76116006)(55016003)(64756008)(8676002)(66446008)(6916009)(91956017)(66556008)(316002)(4326008)(38100700002)(122000001)(8936002)(5660300002)(2906002)(52536014)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4LObWiIoJlNENDYsEKR8XWFgDLexJxZfbQgyIjHP2yCrBx8gtBaFztbKr6?=
 =?iso-8859-1?Q?iaXAn9s+Sq4KwrSdYZJ2uh93Le6hJgjupCT8IlELYdNDoSvk4ebQXNzzCl?=
 =?iso-8859-1?Q?oWeuxD/IJOJjqjrwMHJiMQpyi1fOmQGM5l3bF5gtbz+Oy13dCZRFW4mOf2?=
 =?iso-8859-1?Q?Uaize67R6JZ9iIkV7Y9dh74mIoWTi9tHxJcq5sbvuY2nwRBvKKBAF1bvOi?=
 =?iso-8859-1?Q?6pIf90i2YbIYq3KPsnExTk+dYVNMHuNxPqMP1Hb0fzH+kzGnia2TYUN5gj?=
 =?iso-8859-1?Q?GZOnUUAj6RIN8wPX18SLjmm2CbUuXzeRUyXTJa3Q/HhrVi2XCBzGTIM+Ip?=
 =?iso-8859-1?Q?VXYHQanV6t/fRb+hyvRd45H034Y/3TQvsOPn5rpQQpI/gIgNJ928jM4FlN?=
 =?iso-8859-1?Q?h8chxJS2rFelxk9g6HH+PWpn3LDt8TnicMaEQWeG+Ga09TaMB7i8QXoNQK?=
 =?iso-8859-1?Q?N8VPcfX0qCHAWKXAO0OoDZzYFxrwS1yEhaUJ3H3VbeLrkZOCkfMKlX+W2q?=
 =?iso-8859-1?Q?y6WDYxyW8LrMwqvKY8zUsddrog51YFB6hM8ji4WWLkhKVO4jkUspTyhR6j?=
 =?iso-8859-1?Q?IEJMNU1R5WjlRsqOtweVeMgFoIS+af2ApBLm9EBIHCQ4Prvuar2trtLl1D?=
 =?iso-8859-1?Q?vDUZRfFkLnFaI89cPcWsEOEnKl/ewGyxtjwWjGquPXHrBb88nuEhAJ18d9?=
 =?iso-8859-1?Q?TN9qGBz4o8l+dHplxWMYtCZYHPVj+ChnWvZ64ma2wl9lFkEWLYla9+EqA5?=
 =?iso-8859-1?Q?iuqQiJlgU+tq1q9FpTKE6Dv6BWM28IxeewF98IFbbwkVKFAH7Eyk9S4war?=
 =?iso-8859-1?Q?xgYR62dww/A4Go21pX6kMSbRm8MijqXKr1oXNJc5bpNW6oJ1E7ZRo7HFlA?=
 =?iso-8859-1?Q?G1owjxayKUC7siXOR6QXfj14wGSnCkE+suUFq2cXPk/RQ3L4/mDEWN2ZVO?=
 =?iso-8859-1?Q?CZNEQnUQtj8ZEcu6EhE3n5w50kPt2ThuCn5isnqpfLr4uexV9QNIfwgH4/?=
 =?iso-8859-1?Q?p4f3/3u/yOqt76wMPU3vvl0Tf/xee0tJ3o0ePRwyVn3tkMkuf5cKb/ANn+?=
 =?iso-8859-1?Q?8WvwuBFPYn70l4CAivG25PjKqjt2YWCl8MuqyJ1Tkkfm2Dmk+l6tKBpCTn?=
 =?iso-8859-1?Q?GYveP/0zVE37yzanq5rVl0beAcXH7dYqooDOpD+7i/00dklbGNKx+yPpWa?=
 =?iso-8859-1?Q?etqYSriqwNZySqBNpQJ/8wKVg5TxWqpTCIaiTKFs5B02FazVJUOoJArr/N?=
 =?iso-8859-1?Q?BiFOAzFIfd9hK6y9sEREiAibSUZlto6pnf4rurytwcs1C2vS8jImjdbSmC?=
 =?iso-8859-1?Q?ioIUxVeN8kznntaAp0Dd0AB+Sd9Z0xZMJvUKvL115i9MS4oiDdqltXPHQ7?=
 =?iso-8859-1?Q?AvJ5602DFpQY2YTjcU8AmZNmDcdz2yozpEpAz9JD7OjRkyI1NAQchdGSla?=
 =?iso-8859-1?Q?LPX75TkxUwtVSCBpD22QDO7mCYdFeaBu0tPjOIQGJkWvcMvhBEgsoBy1Fp?=
 =?iso-8859-1?Q?Z89PM+iIYawadO7MO3zzIqYgk0tBRZqXX8P+siPgj1+y13o32QpQ0bnXu9?=
 =?iso-8859-1?Q?bnMSXv0X1zufW5HuNFY3hnhIsHQaVTW8wnapB3vMrxA9j/ojSUyfHg1O+P?=
 =?iso-8859-1?Q?miegJ05nSBTqs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f04526c-66db-4a02-a049-08da8467b688
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 17:57:00.4782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDv+GbZy0yuTCemszUYVfiKNi+M+ysvJzye2dMblniWmY9gSi9VnSEZUPzVD/xKmwE3xat7e4sJkCfA6038DkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3370
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

No.=A0 I want the hardware version of the device as specified by Bluetooth =
SIG.=0A=
=0A=
Or at least the manufacturer and model of the local device.=0A=
=0A=
Not the bluez version.=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
John Klug=0A=
