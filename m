Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A474C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 May 2022 20:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350587AbiE0Unp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 May 2022 16:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbiE0Uno (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 May 2022 16:43:44 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC51339E1
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 May 2022 13:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpCXqr/F/OHxfvA9Q/U3CHFzZBVnbuduh1AEatgg2tpTGEQY2qT9REH+0m32QGMaYjrJqQReaV2+f65oVvNvgze2ESCb5ZI447hjma9FyXO6q0TvsmHb5No+6dAN3rH6BvqNnCC2EGliStHqftAov0hnYVRR+GUqknHJ+F0WQwFE21cj16jevFFr6VdefLiV6cLSJy40V7L/rolCMoOd1RhueE0bAfAFbBuGkZW944OHDcDjnvbmKRmF+ErMfAkGzl7fUcHJ5hrM7KJ7DuSwoaEU64MS9cRrnu02Qo3AT6tc56iJbgIKsiFiRp2Ry5TXWh7sWzwSndPszKOlm9xbvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X51AtabdGYUwtuFJPqAIz82AQd3DcvjutsyGXTRnfk=;
 b=YAZBuAldFdF0hZ74zHGjDLNBY1S5XUyIukURPQS5AyemUoz729EnbMmJwcQD5YefPwGFfXkw+9CQcH1gLHw1uM5YL7cauktduGdmIzSmTaHawkxmK7ZmCg+s06z1W07uThR7zQgO/NSHmWj8Fj/LrCViB0ljP0DoVcf5uAVrBicmAy7o9IwWkrao8URIzFS3x8G5lVAopIlhzgEIPEKBV2mD+X28qXLHjUdkZnCKRkxEaaqz/+oBcX8a05pUUzjtkDVsZMwbU9FYjPuZTL/15UQ+SBa2zscP2bkUzo0c0XeORfuJ7V5n9VNK/ILBSugS9HjCyjJxmrE99b2/r+4Xzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=verifone.com; dmarc=pass action=none header.from=verifone.com;
 dkim=pass header.d=verifone.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verifone.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X51AtabdGYUwtuFJPqAIz82AQd3DcvjutsyGXTRnfk=;
 b=jDDXl+gCv0cgGfnuaUQbDImLo9voGxTbjb4G3qM+AC042H8/bS+//KLkDFo0ke/FA8hrlcuLJvOKoy72fKOQwFEtr0nR/VFHbH2RZ4JyJlDGqAD+TiqCpJv/ue0y/KUCaKVpBpq6IMmiSZ1dV3MMDPgiGGSOL1kG/3kJx5Ngoik=
Received: from BYAPR03MB3701.namprd03.prod.outlook.com (2603:10b6:a02:ab::24)
 by MN2PR03MB5294.namprd03.prod.outlook.com (2603:10b6:208:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 20:43:42 +0000
Received: from BYAPR03MB3701.namprd03.prod.outlook.com
 ([fe80::7d5d:2b55:d7b7:62b8]) by BYAPR03MB3701.namprd03.prod.outlook.com
 ([fe80::7d5d:2b55:d7b7:62b8%6]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 20:43:41 +0000
From:   Tom Unbehau <Tom.Unbehau@VERIFONE.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH-stable] Bluetooth: eir: Fix using strlen with
 hdev->{dev_name,short_name}
Thread-Topic: [PATCH-stable] Bluetooth: eir: Fix using strlen with
 hdev->{dev_name,short_name}
Thread-Index: AQHYcHNRf+RytFOnm0aotWe3QvGozq0xoN9HgAAz8ACAAVrWNA==
Date:   Fri, 27 May 2022 20:43:41 +0000
Message-ID: <BYAPR03MB37011A2F648110EF96BD1CB487D89@BYAPR03MB3701.namprd03.prod.outlook.com>
References: <20220524202630.3569412-1-luiz.dentz@gmail.com>
 <CABBYNZKZajJyuenwyv+1T6Gt1SYyLz39yMJF9_LYdTubk+e_rw@mail.gmail.com>
 <20220524142128.01acb75a@hermes.local>
 <CABBYNZLs-1Pkf=qKwt7t5b6_wxiZiF4Xzr+K2jMFr_WEDpfaQw@mail.gmail.com>
 <CABBYNZ+gQf-YfT5Kiq6GRFsjhyyF7k0vtEc=Zzkc1O-_dExFVg@mail.gmail.com>
 <BYAPR03MB3701F946C27811EB60E8502F87D99@BYAPR03MB3701.namprd03.prod.outlook.com>
 <CABBYNZKnA8qfd+V5Wb6GZ65FVnL2mVz2aifZTS6UmeJ5EUKhfQ@mail.gmail.com>
In-Reply-To: <CABBYNZKnA8qfd+V5Wb6GZ65FVnL2mVz2aifZTS6UmeJ5EUKhfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 96cfac8d-5047-fc31-2e65-b89b8b2874f9
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=VERIFONE.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae2e5b09-f7b8-4b62-7ead-08da402195c4
x-ms-traffictypediagnostic: MN2PR03MB5294:EE_
x-microsoft-antispam-prvs: <MN2PR03MB5294517EF6081E710EC7827487D89@MN2PR03MB5294.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmZppZC7cRxoUwcVfmCQr/50vJmdmrtAH0+QtyPZjGbZJed2ZPWtgxiogXYHkwFVxCFNaBLv4CenhVPXiC/KT6a/GwcNODApqDZwtNvi07Z9cpjc12IPrrnJ789Z1fK+f9ZxPh61liYssKsDayUygZ1BgHH4uLxjfN2zGBbuNP8LbO4CZoB+pLqwEA/l7n2Hs7nipN22+ZYFtbmGVXYJ6IMk6aTsrN2IQtNLUY0lLeesrlQiIHk9hprZ1n6LOKieID1FGNKwmJet/vlFKAGgIOijnJ1pkAunaZPKwL/+fUUdKNEetshaLwgjVyxEcoKGcLhUDJRq82JrdbilLU280i8VP32bNXj2ZNYroJTdYtRayBLmPalGev6qJ27s0hXsWtVo+++a0fqmzyKdBqQDAZ3KuDhoyCXhbBSzNlIyJd/wwCZUDSuFXVawpDqYNJYKYb7be7L9a3F39lapY8jVjFyTcDX7TyH4FUpgxWlAXvzdfnRecFyG45C6m01/6vhLQ3hAiKq3N4x95LWt95Hp243uPN/nzov8K5lqoQ1ztkGPyhHbe2rzxr0/EAKKS0MbESGmNb6KaPpCXuHiQfhw+dsDpg6BQWo5IraZns5Digu3nxC3Ho+yOjWlbws+ubRT5putZvIfHOhXUG+rrebeaipDKWrqumJulrWg0+dn+JNCx0qd489MSagcC+ogCypu4Tkle43YRzRxIHJk2gVLYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3701.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(71200400001)(558084003)(38070700005)(508600001)(33656002)(8936002)(5660300002)(52536014)(186003)(2906002)(38100700002)(26005)(9686003)(86362001)(7696005)(6506007)(91956017)(8676002)(4326008)(66476007)(66946007)(122000001)(76116006)(66446008)(66556008)(64756008)(55016003)(6916009)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qMJ+WEvc6M6JS+9HIvlhTRk2AWlwi8jdusSqBYyU58rTEIDB5PyNb8NWJu?=
 =?iso-8859-1?Q?LcWlfp3tJ/apXma4GpdRrQ6IP5vRQxI1t/Bsp569nu1m3eliMh4Zr3147f?=
 =?iso-8859-1?Q?ZQ8oMOTaSgoCaW2GMuWSqZfoUUGGPnSd157F1nvlcRrwLfUUJ9eOU1U2Rc?=
 =?iso-8859-1?Q?xNOyjMthQbShp1cp6V2FLgs6YR6DMIgON+0c6Nyz0skD12bu5w0QfcVMLN?=
 =?iso-8859-1?Q?RonRSf1HB/l8hO3kT2poLZwbJQe5bJ9LKZyIN2t/uuXMxvF+s6RKNGvVG5?=
 =?iso-8859-1?Q?y8Vsyj3646Ay6czV4VZ+aaouht4J7FbTGJrgjYoEafj0b9WMvZgQVRmuvY?=
 =?iso-8859-1?Q?mLzX5ULvgqw/+ktmgGFNdbQom4+xOLESIAIoxVzYDjTATnu9k4Sn2AG1hJ?=
 =?iso-8859-1?Q?RA7pGDTwpOJDtmBtVUkxBnx+JySj8iGyZnXC7Gc/22jQcwIHFfX7LmvJYZ?=
 =?iso-8859-1?Q?I1HmvfApGw6oQn8zmdmE/mBPDrPLgX+y0iumTwAv9+uIcIeGjzTWKk0EoS?=
 =?iso-8859-1?Q?VKv4rqIUAuTS0B4TmjeqhK0HLDgkPD5PR4DHF3pxMPDeO11T2tvJ9FJvRJ?=
 =?iso-8859-1?Q?NNgf+YnBUzq4hu7tY0o+8cB4ibZ9LDsXaCUEU700vt2XWSzCjRvJ0ZWw9u?=
 =?iso-8859-1?Q?QJZMkNT1eLU5Y0GmGvtITgDQBuWgQ9a24pRwr9ACiDhVJ3UnnELJ8YAPrK?=
 =?iso-8859-1?Q?ZuPxo6G54hLdVQhSLbv75hJxONejkaKZcUnHSJwT+6m2Wdq53hFsMdwgJH?=
 =?iso-8859-1?Q?Xmc5qRhYaPoDJRYairnTBCXFn5bCllyyunNPZZMNURYUTAJr95Uq3nCMKm?=
 =?iso-8859-1?Q?ecAMl/w19a5Uu5tr3kvk5fjtVsnN7lLHBBbmgY6U2JuzyWwKfxf7ThbOtg?=
 =?iso-8859-1?Q?fYD3HLNIvqs3ow4O39vmYxLfffYyyDoMEKtMOJLMqgdhfQ4wVR9mteA0t5?=
 =?iso-8859-1?Q?h0UAp5NYlCZMFpFl+8UJatzI6ygglM4N4+b9cMqQkIR0Vv+McmkXCqbriS?=
 =?iso-8859-1?Q?YsmEgtkOKHn0Jff/Tb8Ak0F5z7tFpMrLf/oTH07i80Tg5goR9W4U5OrcJl?=
 =?iso-8859-1?Q?KKB8c2Ro5gFwPl+qc7C9hv9b/W8GzJuHZki0GFFJ6eRdn2KBSvSAM0vrh5?=
 =?iso-8859-1?Q?qrw8l3aK/JBy7slAaLpOfwLoVCwkYoR0KiugAqm6dmbHEEdRAyWyqOwQVy?=
 =?iso-8859-1?Q?lkJxSuSdfGuf4Bs623nnpZNg/vhmscFBUz686IQ6tNotyXwo0KTb2pdIAd?=
 =?iso-8859-1?Q?ciaL/E9Sy06AAq5WCaN7dLig+jj7lbKHbbJPME/rvxaoaZJX98/7evSvDD?=
 =?iso-8859-1?Q?cjKLzMng5TVHBrLD2tDxSKXA8WUIkqjIbn1I6Hv72RlRwNTPiL6LgpPKyp?=
 =?iso-8859-1?Q?WpwCD3aWxVzd7zrjdd6UxNLLJC4jGE9Ika8SoOr1Fn9IEyxsKrvhKE1QBS?=
 =?iso-8859-1?Q?X9Nqg9LmkfRtoawtXcnmTBAS4rC2tOvg270sDjyM52SIaFWqSlHPBvuw9u?=
 =?iso-8859-1?Q?UEuV5Cw24vwresTWuVILH715kRU4emFY9C5y5Dp3lJ03xVWnUjjCkEJntu?=
 =?iso-8859-1?Q?FdoJ6KXPj0tHdYxMz/xlv9fNa0IPXWXwappUVpJ7Tt1Pp9+WD32WH8Rpv/?=
 =?iso-8859-1?Q?HD+BZRs5eT5e3eSCpyE6NdVFmyM8UmzC+lcYNjUkvan4jPmjDxw8IXh9uj?=
 =?iso-8859-1?Q?3R+Hr5cIkujLcsB9Y+HDdeXgIZt0909XZFxs4obZ7y8fvaqYfIb7SKlA+O?=
 =?iso-8859-1?Q?jYFZvl5Y4EQ62mOKe5KnJhsdWdV2L8ZCNug/2n/Llhqc9+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: verifone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3701.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2e5b09-f7b8-4b62-7ead-08da402195c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 20:43:41.6815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 611a22d6-8c40-4958-84e3-ce47d8205d98
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wnw4tEaj4/2eVLhiB5lkP9FpewAVXpF6Hi5a7wthgOfky9RYpU+QLkeVdrxiJsK+JBVfLNyk9Y4lhIbyGS1VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5294
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,=0A=
=0A=
I agree with you 100%. I think a look needs to be taken at any place where =
the dev_name/short_name fields of the =0A=
hci_dev structure are used. =0A=
Perhaps there are even other places which assume these names are NUL termin=
ated, but which are not as=0A=
obvious as using strlen on them.=0A=
=0A=
Regards,=0A=
Tom=
