Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462BBC25B08
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 23:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbiHDXHR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 19:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbiHDXHP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 19:07:15 -0400
Received: from mail2.multitech.com (mail2.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D9AE4101F9
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 16:07:14 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 74840587F24_2EC5122B
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 23:07:14 +0000 (GMT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 96A92587F0C_2EC5121F
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Aug 2022 23:07:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi5ifnqPqbwb4aRCH/fHQNKQon2SKtIFIkody5LY1OhfC1IQtbAzsd60InWgPHT8hKgNDiHxQbUVMJ9asdVcGx4g+4HrgbrAUduOhYcdwgYuJHGn8f1IeX/75K7+WKWV6LOVuov5/iKiiNl3NliUySCrq++7lYZuMYGQeWXV5js76Nb0vqUSf9hHHEqWNPcOz/8FARpw156F5vV6BfNyL5uYlvIhcQWss+yMorYIO2T74FsSf9XXpZNcknH3PDm657LiUEnKjS1tjDvlTTq3hpHGgwFb65Ipy0y1PVpBkvW9GBIiEEgw8EdFn37G7jEqMMjOGz8kCYpEQ7Q/ZQm0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHfQ4vLgiiBPNM3hI2PdKaLi050V6A9D/L81cNQI95s=;
 b=h0mhVxGs/zwxPL6A4jo44RZEPRFErwR1Yy590a88ywL3GHZJRrnR0MaGigtaPEIcbBHr0P5bEKiJp1ZcZeiRE8zyngCB1TRyOFWyBX7ID4KtNQnwn0svyuhVKwGg3d7p/9gKye/DhwO36e07HG2kZa5jDJuhL7qqN7PfI0wpSdywiG8ZvRZP1qHWI/UVOq3gcSLN8qcL4E1A8J/G1PxpguDO2lsVC3xS7x+xQvolpJL59z2J7fSYOZ4nbArstDgQ90Mkp376TDnORhEA2hoV49EsIS6lj9J7Od8NqTLs6tXp93neV831KCiaDSxIDsor2061q52TzyjgoHiMdSoYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHfQ4vLgiiBPNM3hI2PdKaLi050V6A9D/L81cNQI95s=;
 b=WeR++Gk18VF8pRtlGk7RZRiYyIltWo1DJYoKXWSw/aQUzyostTtBmnjH/CzT/oTT+ffnP2mYJcllhTMGV1jUMx5KdCJBRH16UyEATmY5g5H8199JT1aH7P7QO92Smfjo+CnVQljVyNnBOQrGA7SLdBmixUyilJxEjwGvZVSAjjk=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by MN2PR13MB3976.namprd13.prod.outlook.com (2603:10b6:208:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.13; Thu, 4 Aug
 2022 23:07:11 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.020; Thu, 4 Aug 2022
 23:07:11 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Apparent State Problem between Pair method of Device1 and Paired
 property
Thread-Topic: Apparent State Problem between Pair method of Device1 and Paired
 property
Thread-Index: AQHYqE1gO1hWH8Ao10mCvrwbAba/Jw==
Date:   Thu, 4 Aug 2022 23:07:11 +0000
Message-ID: <SJ0PR13MB575516333D0BDD6E31BAA3CDFE9F9@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2014f73-abea-4b2b-ca6b-08da766e1030
x-ms-traffictypediagnostic: MN2PR13MB3976:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bMSWygIuUSARc3Pmc1Zoqz4UJ36M3S2DJlB1d7j9qKl0zJQAIZncvBJ9unw5cEJ44iVIsU02knHJPb9tdWvrQ0ygZoR0xc6FUsElWbnDctidIZ1Yn5Y9uO2SqJRPJcps7IzApc12jN4FeGwS+ifTpttcJUiEz9s0u6603Cngvn95a060XLv/L8fF5NjCdcfEg3rQdlmfzEMs0gi/BBOJsnhhFPkL0hqjnsWh++RK/WORVgKOo7YnvH6BpmJ8/Np4b3cmRmT1NLruvwdXtxLQzIeKNkD5I+shMGyC48zvrS9NDoMrhjkncjyDApXSJt5Sbq5iDnjtk+SWVfnzmuLGPoH+5Lbh2TNHrw0Op63luHgV99OvemEUH45YRkjLpqC+qNfLwttnhMDejzdlZHMltDIfJuo/eiCkQY9PYdKdopPmBp03So67DbaK4Vf9CYZMwWe1UUBUr9IkHMMZBAMZdk2JkLeGwT0Zqjp5BWShFXqGaZxKU7zWNg22yMjebwUzGzaw9Xl8/zfq/Yck2eS5aNbQ8qtDQNVT+tuZgtckOg2wyVuYTMAliXTvD/swKW/o+wjOah4/5BG8DtGLUydx64xXfeSkJxCSaR0wrb3IjnEy/tm+k4YXxbt+/n4cVS8JxvYcwiWYQgOjnighAkwHhbwmwI90rkN6SlQbrf3Iji5+rljrbNMUlLIoag9GHn76FrXMDtooL1NAOQqvetfDxquZ79Z634FJNeAJ5nLMesUkji23pglfhqfRQZ7PeatmwiASlickEcyPI/1SDNKeTDYAhjMwsEoX5RymycyZwr0LBfzCCL64XlFXIxoS11IZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(366004)(136003)(396003)(39840400004)(8676002)(91956017)(66946007)(64756008)(66476007)(66446008)(86362001)(76116006)(316002)(9686003)(66556008)(38100700002)(38070700005)(122000001)(478600001)(41300700001)(6506007)(7696005)(186003)(83380400001)(6916009)(55016003)(71200400001)(8936002)(52536014)(33656002)(26005)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ltul5iaKOlyudXhxnLvX4p/wjj0SHVNyRNp5mS/V1X3dlhoY8Gpd08il9B?=
 =?iso-8859-1?Q?gOMoT90NMOgVJyMo3c3ACmm+sXgKCDTCkNpoUqGTqqPWMZsDV8CETxtgxt?=
 =?iso-8859-1?Q?m5NdYWKRs88LhRczbLrZWUldVUordUOQQaD39o52RFjyAyMjjEdCYSTCQ2?=
 =?iso-8859-1?Q?/SOOBSRS9hmO11FWi4L0l2YmQigPxaw+lKRll5xFDL46UvNxd2ij4hU2PH?=
 =?iso-8859-1?Q?vRVCtp2HzWDfR2U3HiBN4LX39K0qOEO4AeKv3EeCAqylozEn1MvIOxp6ur?=
 =?iso-8859-1?Q?x58T1Gdh9JqTX143Pi8lw0HroKSNDJs1/NeV7wzmFlNImTe0QVTHd7bo77?=
 =?iso-8859-1?Q?zwy7+7S7iprhy8sa/MF+lnAZex4aRtSqwgLV4m9G79HQ3caioW17pMK0V3?=
 =?iso-8859-1?Q?DyC3ong2cLocir2en7GWF8md83OnKOY1LneA0PnfnKW8+T+w5Ay8+6IwNr?=
 =?iso-8859-1?Q?qG0nd35YKkSXi/R4rCB7gqUEgTTYgU3fzdoABV5zmyi7CBHrXOwzWsNTaG?=
 =?iso-8859-1?Q?bPcufgFGrFX2EHpHqFTmDYCMBQLNNoeLdU7+ewZX/0zfOHTFidG52yzwAa?=
 =?iso-8859-1?Q?uTgLEyXce050yoW0suu5jqwAad2+wEZlv5qlbtOEeWlgsp0ZhkA+7ccvL7?=
 =?iso-8859-1?Q?HlR0cgO9rNNmEKU9Eslmp3sSEl1H1yxH1BPGpUptyfl9fGgKJOptKqj3gw?=
 =?iso-8859-1?Q?UADbnNNsGYDOkSpUUb/iBQDQ/0LXCLnhjeFdihUyLgpnRiG85NCZJyBqO5?=
 =?iso-8859-1?Q?4IucRy4qGkLVCQsP6g/BAxluETxWJYC9m+Zc5AjYhvQk2MFhoM58/8M1xH?=
 =?iso-8859-1?Q?l5TkM0v/WaNafkUG6eA0ltiQT48ZLnsDmF3w64nNLHqZHMo6EVHd8S8FzX?=
 =?iso-8859-1?Q?oi1TH8AnlPUsuRukiDDTtR9VNmq1LVDgD1lrvtlh+HZ0fFsodhsXLOI8Bp?=
 =?iso-8859-1?Q?B8jF1lx2QE0hRsebYSwpAmUgQpBWCmDzVVbJb4kg7Cabr9gVB4mDRkbllb?=
 =?iso-8859-1?Q?bVz+zV5A6+w5YmAnU/6LVf0tUcSNeFJEkLjFe8sFD1FtiwKXfI8BzwE0aS?=
 =?iso-8859-1?Q?AFZV5vxvECvh81RW0E8rT42ukKBPtL6x6VC+5iH3vgzJ/qxzA3v2OGxCXb?=
 =?iso-8859-1?Q?8XyjS9wJB4fFRh4SZ7sPIx+5EQawD7gXwTLmKdRzKkr9bvNx4wxIxZ8iRt?=
 =?iso-8859-1?Q?D/GHQoGmYhnaRxpFJ5OHNMd95QHXWgAxiJaNgMf9wBx/HddxU7v/VRUwrK?=
 =?iso-8859-1?Q?dV7TFCnTES2To+tYXGdtNPbt2MiOOaOtGGxwqd2djHKaNq9OF/V/We9l4R?=
 =?iso-8859-1?Q?SdbAvR/Iy++rdsfS7zbfEsGykLOqoUA+7/4TZHd8Oqn3b1OEo7gr2g64If?=
 =?iso-8859-1?Q?3lO+nQE4oZGQHkm+x0OSWGNlmdrRa7VaG3lLtlPZaUtFPtlz4qdU4OmuLh?=
 =?iso-8859-1?Q?0P4ca6qp+qHKxzdrpmWSnfN3/ShICV3p+7sMzNQWVlO/nVHSC1qlCCJTxT?=
 =?iso-8859-1?Q?MHQA8zS4e3jWJRsJwiZGQqT0Hlmdkcj6Jkronkp4FtODzoWqt/QN3J45pR?=
 =?iso-8859-1?Q?KZ/x0hZcVKzX64LuQ6wKjKk0A0utyLDhKpA3MJGXDwmpbwGxBql4dtmPqv?=
 =?iso-8859-1?Q?oI8tPBEAk1sh8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2014f73-abea-4b2b-ca6b-08da766e1030
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 23:07:11.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 540WCLUlxcBk1Xj9GiMwllyHVc9weJTFdfMDCkUKAsgM6w4v0DWQh95el6x8A2462ErdewKmPFM1ZLg2PUsA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3976
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BlueZ 5.64=0A=
DBus Monitor output=0A=
=0A=
If I understand this log correctly, member=3DPair gets an error reply of "e=
rror_name=3Dorg.bluez.Error.AlreadyExists", "Already Paired", even though t=
he "Paired"=A0 property is false, and never gets a "PropertiesChanged" memb=
er message.=0A=
=0A=
This problem went away after rebooting, but happened over and over again, e=
very time I ran my program.=0A=
=0A=
If I understand this log correctly, member=3DPair gets an error reply of "e=
rror_name=3Dorg.bluez.Error.AlreadyExists", "Already Paired", even though t=
he "Paired"  property is false, and never gets a "PropertiesChanged" member=
 message.=0A=
=0A=
Is this a problem in my program, or a bug?  Because I was getting this issu=
e, I put a loop in my program to Pair multiple times, waiting a second betw=
een attempts, and always check the get results of the Paired property which=
 was always false.  Each time I attempted the pair, I got the error that it=
 was already paired.=0A=
=0A=
signal time=3D1659650136.651160 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D2676 path=3D/; interface=3Dorg.freedesktop.DBus.ObjectManag=
er; member=3DInterfacesAdded                                               =
=0A=
   object path "/org/bluez/hci0/dev_CC_F9_57_89_8C_2D"=0A=
  ...=0A=
          dict entry(                                                      =
                                                                           =
                                                           =0A=
               string "Paired"                                             =
                                                                           =
                                                             =0A=
               variant                   boolean false                     =
                                                                           =
                                                          =0A=
            )                    =0A=
...=0A=
method call time=3D1659650137.811326 sender=3D:1.96 -> destination=3Dorg.bl=
uez serial=3D9 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8C_2D; interface=3Dor=
g.freedesktop.DBus.Properties; member=3DGet                                =
=0A=
   string "org.bluez.Device1"                                              =
                                                                           =
                                                             =0A=
   string "Paired"                                                         =
                                                                           =
                                                             =0A=
method return time=3D1659650137.816719 sender=3D:1.0 -> destination=3D:1.96=
 serial=3D2680 reply_serial=3D9                                            =
                                                                       =0A=
   variant       boolean false=0A=
method call time=3D1659650137.840411 sender=3D:1.96 -> destination=3Dorg.bl=
uez serial=3D10 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8C_2D; interface=3Do=
rg.freedesktop.DBus.Properties; member=3DSet                               =
=0A=
   string "org.bluez.Device1"                                              =
                                                                           =
                                                             =0A=
   string "Trusted"                                                        =
                                                                           =
                                                             =0A=
   variant       boolean true                                              =
                                                                           =
                                                             =0A=
signal time=3D1659650137.843321 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D2681 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8C_2D; interfac=
e=3Dorg.freedesktop.DBus.Properties; member=3DPropertiesChanged            =
=0A=
   string "org.bluez.Device1"                                              =
                                                                           =
                                                             =0A=
   array [                                                                 =
                                                                           =
                                                             =0A=
      dict entry(                                                          =
                                                                           =
                                                             =0A=
         string "Trusted"                                                  =
                                                                           =
                                                             =0A=
         variant             boolean true                                  =
                                                                           =
                                                             =0A=
      )                                                                    =
                                                                           =
                                                             =0A=
   ]                                                                       =
                                                                           =
                                                             =0A=
   array [                                                                 =
                                                                           =
                                                             =0A=
   ]     =0A=
...=0A=
method return time=3D1659650137.846560 sender=3D:1.0 -> destination=3D:1.96=
 serial=3D2682 reply_serial=3D10                                           =
                                                                       =0A=
method call time=3D1659650137.864578 sender=3D:1.96 -> destination=3Dorg.bl=
uez serial=3D11 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8C_2D; interface=3Do=
rg.bluez.Device1; member=3DPair                                            =
=0A=
error time=3D1659650137.876352 sender=3D:1.0 -> destination=3D:1.96 error_n=
ame=3Dorg.bluez.Error.AlreadyExists reply_serial=3D11                      =
                                       =0A=
   string "Already Paired"    ***Says Already Paired?  How is that possible=
?***                                                                       =
                                                                           =
                              =0A=
method call time=3D1659650137.894983 sender=3D:1.96 -> destination=3Dorg.bl=
uez serial=3D12 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8C_2D; interface=3Do=
rg.freedesktop.DBus.Properties; member=3DGet                               =
=0A=
   string "org.bluez.Device1"                                              =
                                                                           =
                                                             =0A=
   string "Paired"                                                         =
                                         =0A=
method return time=3D1659650138.950032 sender=3D:1.0 -> destination=3D:1.96=
 serial=3D2686 reply_serial=3D14                                           =
                                                                       =0A=
   variant       boolean false=0A=
=0A=
signal time=3D1659650139.690503 sender=3D:1.0 -> destination=3D(null destin=
ation) serial=3D2687 path=3D/; interface=3Dorg.freedesktop.DBus.ObjectManag=
er; member=3DInterfacesAdded                                               =
=0A=
   object path "/org/bluez/hci0/dev_CC_F9_57_89_8C_2D/service000a"         =
                                                                           =
                                                             =0A=
   array [                                                                 =
                                                                           =
                                                             =0A=
      dict entry(                                                          =
                                                                           =
                                                             =0A=
         string "org.freedesktop.DBus.Introspectable"=0A=
       ...=0A=
=0A=
=0A=
=0A=
I then tried again after rebooting:=0A=
=0A=
method call time=3D1659652894.256912 sender=3D:1.13 -> destination=3Dorg.bl=
uez serial=3D11 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8C_2D; interface=3Do=
rg.bluez.Device1; member=3DPair=0A=
signal time=3D1659652896.898455 sender=3D:1.11 -> destination=3D(null desti=
nation) serial=3D72 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8C_2D; interface=
=3Dorg.freedesktop.DBus.Properties; member=3DPropertiesChanged=0A=
   string "org.bluez.Device1"=0A=
   array [=0A=
      dict entry(=0A=
         string "UUIDs"=0A=
         variant             array [=0A=
               string "00001800-0000-1000-8000-00805f9b34fb"=0A=
               string "00001801-0000-1000-8000-00805f9b34fb"=0A=
               string "0000180a-0000-1000-8000-00805f9b34fb"=0A=
               string "0000fe59-0000-1000-8000-00805f9b34fb"=0A=
               string "edf50000-681e-4b92-999c-e16b3a8bc046"=0A=
               string "edf50000-681e-4b92-999c-e16b3a8bc047"=0A=
            ]=0A=
      )=0A=
      dict entry(=0A=
         string "ServicesResolved"=0A=
         variant             boolean true=0A=
      )=0A=
      dict entry(=0A=
         string "Paired"=0A=
         variant             boolean true=0A=
      )=0A=
   ]=0A=
   array [=0A=
   ]=0A=
method call time=3D1659652904.269624 sender=3D:1.13 -> destination=3Dorg.bl=
uez serial=3D12 path=3D/org/bluez/hci0/dev_CC_F9_57_89_8C_2D; interface=3Do=
rg.freedesktop.DBus.Properties; member=3DGet=0A=
   string "org.bluez.Device1"=0A=
   string "Paired"=0A=
method return time=3D1659652904.280169 sender=3D:1.11 -> destination=3D:1.1=
3 serial=3D73 reply_serial=3D12=0A=
   variant       boolean true=0A=
=0A=
=0A=
=0A=
John Klug=0A=
