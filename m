Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E5C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Sep 2022 23:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiIIXiI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Sep 2022 19:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIIXiH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Sep 2022 19:38:07 -0400
Received: from mail2.multitech.com (spx.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5C926AA3DB
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 16:38:05 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id D49C958649E_31BCE5CB
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 23:38:04 +0000 (GMT)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 519C05860A4_31BCE5CF
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Sep 2022 23:38:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7XJmebQynTKUsKW1wR+gwMVku5Kibz+0E6Mf0wcsIrEv8hFSlI53uVUdn1lEwNlzbjXzCRQ+SUNSXi0CGLNRp4/DhROvrECeF0Zf73ajlgddVLO+r6rNP8H5+fMoCuCfLFUOWDNj8cyDTYmaPZ2AeIU4YaJ15y78tzOV/vkD9a+iwwMx2kcJ5joB4KlwLnYhqklTbi0wNwGVgDwVbUcC5d4G4LPf8jfjzeO37OdZHjIXH19xN7qIiEPkMs8y27xgd6U8yT3v0TP9y1Svur/WNlCNkZOCWBExponNhwdUs3UbmZWBOTekt+/eEgAGXOKPiaUEqtgVADo9XudfUajwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQJ/PoymKkra4L4dLQFrT+jnwyxYOMy2y3haBGoYUbg=;
 b=jAFy1l1RsvkYNrtpOhmzO5R77pHU0zWpR57qvrrIi1Y4rQbz4SsK0XaQ07UAIqrIETI6G5AjSYiZrtfa/RGOzcwmcWFidJtUzVgFb/e8BKJ5p2Q1GIMOM74gBpn/xlrRbQXxg8rBJLd30NTZjMlfMTdUsxHrDuuPMJMCqKkM6aV4d8YA04t8dKwlhXPx9w/TpUzZTj/W3htIWEbwgvFSsi4qkSz8IJYqEAYIFyl7BXs40AVZpHPB9igDkyJl7t6XiCTlvJDr5kzNz1LZpBbM7yl3nQATZy6fuolRhWn5I+fhvtYK42ygFnPv3d+mQWv/yx6Wi5TbWLbErv73zyheXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQJ/PoymKkra4L4dLQFrT+jnwyxYOMy2y3haBGoYUbg=;
 b=GRkQxXSWhF2RdgKIfQxgbuuOryeB1uQc7A1MwxHgv8Xfqh+89zi1YO/tkvJamWzo67WI43ArxhhBvG+mZnl45/ImUVvdF0BOKIiWUybVudkeK9Q1A0uxbjUB0UThN8wgoW5/uVvjwVpsQuszx4y8z4LLrFi7t+YJAL54Oo/CrJA=
Received: from DM8PR13MB5111.namprd13.prod.outlook.com (2603:10b6:8:10::21) by
 DM6PR13MB3900.namprd13.prod.outlook.com (2603:10b6:5:24c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Fri, 9 Sep 2022 23:38:02 +0000
Received: from DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::1d9e:1cc5:e9a1:95dd]) by DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::1d9e:1cc5:e9a1:95dd%8]) with mapi id 15.20.5632.004; Fri, 9 Sep 2022
 23:38:02 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: How to get multiple BD-ADDR org.bluez.Adapter1 SetDiscoveryFilter
 Pattern-s
Thread-Topic: How to get multiple BD-ADDR org.bluez.Adapter1
 SetDiscoveryFilter Pattern-s
Thread-Index: AQHYxKN6Rr57YFCZH0Ge+Q1Dm6cR4g==
Date:   Fri, 9 Sep 2022 23:38:02 +0000
Message-ID: <DM8PR13MB5111A8B0001E7CBBC2C844AFFE439@DM8PR13MB5111.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5111:EE_|DM6PR13MB3900:EE_
x-ms-office365-filtering-correlation-id: 11f46fd0-6eec-400d-d8a4-08da92bc5645
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AHmJldNjbqeo72Mj4LETAG1WJDcp+watIkB1kprxaAtCQSp2nse5AM7GHar0c7X5PtYu0Mo9C0mujwS32/JNXaDMrW12QOo5xwgFp2ps004Chiud1Ex0Fw7w9vcMUGkJ1UUEliRDjtttWEiKc7f1dGApMLrf0UDQjPvO1HUAj5X6Mpcoedi18mQHdwy2Xux9jb8bZhsru+8wFy3Dq2uCxavno1uqfZCHJdrGk6sStFKaOtkvyWF6PsHvCYPgEPpEl+jEMlEOe948rSsRrewStHvNOQUjQlspcBY8ztzThNWSnedpJen8CZgrTEGNfPNCoI2JIqwI/gYrYIe0zN89YTsM/jVmj0pjpg2c56j5bBsRrTHd44p5eXtqxfMoYSCPViD8cwgf28J8kV9YI2bgUSc244GDy1VMBCX15Neh4MbuRdo1QXUJ621VSMQ4uqKcIHmtCnpKdWu39cx8eA3BI7lF2Kcz8XbBliqDvQRUbcfO02pUdb/chaxpd8LoNfSYRmuBUhyXyWcwCsb9n9YfCsXuCje8VwmkuHXa7Bq+aQud0osLQ98fVxaqbLz3eWJarUIkSiDJZmEJwlcL4FPEp+M3Y4u173q/JUclCioJCUci4NfOW3oAI/S2XPRQ+qOMkYTOYQWGPXLo6uS+O+YNhYTGDnaQsSC89mM8oV6QmZQmB8rA/aawdSYp/EaOoyssD2R9pj97furdav7iihuC3IDhaAAhAskGLD4T9aOuK0khb45IroYD6GP3jurRbtyiVnCaHmDkzrTiUu03EO6gtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5111.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(376002)(136003)(39840400004)(38070700005)(186003)(38100700002)(122000001)(86362001)(8676002)(8936002)(6916009)(52536014)(4744005)(71200400001)(7696005)(76116006)(66446008)(64756008)(55016003)(316002)(66476007)(66556008)(66946007)(5660300002)(26005)(2906002)(478600001)(33656002)(9686003)(6506007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F6AYqqOOPwyAOhS5iZkp0U6havYr3sZOpVtzdNI4goORTE7OL+kfhVSsHo?=
 =?iso-8859-1?Q?158vHjmn0a3bd5rdChgBEwdvEjyIAVqFTCvYflKZxwUBNCkaQH3FeVwwAs?=
 =?iso-8859-1?Q?pczO5ievzh1G12tmSI/5lX8iEHnikct43d8vuW04xqXGTEnP/Ev5VLi2ZK?=
 =?iso-8859-1?Q?unbY5Bb0WzK8RQj9Q5LFMDC2n83oLJjjKPfLDvJFBobJ1lZKwRqMsmUXVg?=
 =?iso-8859-1?Q?tmP99B2X0SvxzlYI9flUXLG7vc+KoGyYHcCTkwutcuuuRv7OMoTrN+YbaS?=
 =?iso-8859-1?Q?eVYvQxXBwNsshS8nO3TSC0CuHPj0usn12f+hKmVX318GBedSvyph0PGJH4?=
 =?iso-8859-1?Q?IB6A6lXIcm9zUtj9nVH5ppRe1+HEHVJHgDscJgj9qREAcvUbxITB7rakQt?=
 =?iso-8859-1?Q?AsuGQYP1Ru7ZhHQToS+c5n/++mN59O4cVSCc+9pKcG/QPEIvZhtBS6/uZX?=
 =?iso-8859-1?Q?LwhG0GuyeVIcY5PsDla6lD/4iouZW0PK/yYiTVvMNBHP9zmpB4ZbuiIuCc?=
 =?iso-8859-1?Q?j3qFPsRa3SIts5hssMbujODl5yl+l1p99Pr175wixJqvIzpAFBKsQPjiNV?=
 =?iso-8859-1?Q?dmU2xGoM1gOhy4u4EYhk5wE8YFMSgjG1AMH8sUr6U73TmHApcA9/CaB2sq?=
 =?iso-8859-1?Q?0Qpcay6nAq9KuOEBaCT4xir9LeqKI5x28Igq/qfkxz6rYXiuREDgTXvzRv?=
 =?iso-8859-1?Q?kqM/p3TqOZeKgcSiOdCRCTBHMQToO78g8xytdVALQlLfL8rLXIBq9cl+v1?=
 =?iso-8859-1?Q?BdnBcUDIXKDBZGwoAXN5oM2fsh6JYOf9CNKuonJygMqwD5CadwZxfwHFgZ?=
 =?iso-8859-1?Q?jHfpcfRYShhm4FMtxddXuD7+ud3NFpQxztxqf+cW3HdGEPqNIKrtHy9rNR?=
 =?iso-8859-1?Q?FMCJRJnNPmAeY6wl8QJmF8oMKkUEE7F64wzMeWtWaNfJjYsP68MUMAsYrA?=
 =?iso-8859-1?Q?sCfPqBVGpZ3MeErUhmbcRYhKD3uM1TyEvKX6lx1KSXAv+yVlgxflijf4zg?=
 =?iso-8859-1?Q?pq+Vmg7FhQ46FoNgw8roraKsnVVNSDNRCnrjZGQ5Wqt/eMNIZXHe2KN1Eu?=
 =?iso-8859-1?Q?bPvNq4bD/adUNqi46+TVsNvHSPUXE7lHdh2jn/sasUt3dJWC5rAGDjSXZp?=
 =?iso-8859-1?Q?ORMXwX+TO8zuthmcaeVooCBwIm/n6J8JM+V3+k+7LutQRHB5hFSpnrsjn7?=
 =?iso-8859-1?Q?Xz7RqD1YDkQq/bq8/JMKyHs+/15jXheeF8O1bkfLSRIFgi2ed5CoDHVPan?=
 =?iso-8859-1?Q?YC0/Lw71YOEB64h6viNSpTvWqseMStuIDuf9MhVi2QqTPmTRL7uGUlrR9L?=
 =?iso-8859-1?Q?Rqr00MBEM5TE/WtA+9qGBV9k+6GlbeWPPwzMJ+Ea0OU6GMl+mt/9lAngE4?=
 =?iso-8859-1?Q?fS47MhsheLIrM6lzVDFkqaavkpawes0vO4tXs5uEPzwjYuHd1VE3OcGKE3?=
 =?iso-8859-1?Q?bpPhK1O67nbH4eQNqnhinnK8GG6RrvJlgxFW1YPyBcIp2q/F1wU6zjh4aF?=
 =?iso-8859-1?Q?6MNllFyeU5WJK/ANmlGingpxgOyuptsvO0VEBAU3a1vJqWCWEDOsozghdB?=
 =?iso-8859-1?Q?bB7QkHZKT6CThFdPX5PqW5DdzjvlKQ0ZfIIRJE4MNw/ytOopK4okaKiXIX?=
 =?iso-8859-1?Q?lrxd1Fk8l201Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3900
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Let us say that I have two different pattern requirements.=0A=
=0A=
From adapter-api.txt:=0A=
=0A=
>Note: The pattern matching is ignored if there=0A=
>are other client that don't set any pattern as=0A=
>it work as a logical OR, also setting empty=0A=
>string "" pattern will match any device found.=0A=
=0A=
For two completely different BD-ADDR values=0A=
(prefixes do not match), I need two clients?=0A=
=0A=
So what defines a client? A D-BUS connection?  So the same program would ne=
ed two D-BUS connections to have two different BD-ADDR values in the patter=
n?=0A=
=0A=
Or do they need to be in a separate Linux processes.=0A=
=0A=
I assume it is not possible to have an array of BD-ADDR values as the patte=
rn?=0A=
=0A=
I am using GTK GIO if that helps.=0A=
=0A=
=0A=
=0A=
John Klug=
