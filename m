Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E352AECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 22:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344999AbiHZWnt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 18:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiHZWns (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 18:43:48 -0400
Received: from mail2.multitech.com (mail2.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 651CBE86BB
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 15:43:45 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id DAE0B5866AF_3094CA0B
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 22:43:44 +0000 (GMT)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id A9A805851A6_3094C9FF
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 22:43:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgAeuocJkSyiZrTPtckwoBnaTmfSs5TW8+mex2QAR6Q3DIAnlxKRGUgnTqq+6SCdxhjSTfp7GUgX0v0UvR1k4lX04ELLeWcSY1/QGhqUkRmkNMzQwJVbxKO3WNzcaDUf05ll0FsjP60DP8eMsBKPMJ8AVtD3uyUv+LOuC7pGoGb3wzGKpLf+kARmq7Kn+H4NVBwqfN8et0maemr7kqHVyn3uzhxHwPHyOTgoZnOBH26G2MSdU//88xwuxK7AKzrq6wgdDRQMXOu/2zjla/SrcZ9m4O1a+Rp47QIxXla5Kwt6XiBdBvOX47TakQ0+bw7DszI12pFzob+nhnYdMS6tMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoMK9CmLRxdnBtqNahDaHolpwyc/TS8eWekpviDJ+gw=;
 b=hErVzAuE6klLzGcHzMpfEKQPGn3P/syrsiDqUS4RyjyqNQjv1RXc7g3G0ddSySzY8sixEX053fJRqLLbRpuTY8j9YYx853i+UFsjqv5NB2bKVG/YxdbTS5JdPuBjbL8K8B3pHX5Kytt8/02rv4BUNjYSZ51oM8nFJrMnj83OrL7EOkJtovj50ag791Ik5hVyDQLQACMTm/6FPtEdRpw/d1TZelg4Fd7GjsbE/gaqn7W3AxFHew7WHIWey4cPBJAbXKFqCwkemSkXgPmxL3H2pdOjLaBhhu+eBp6SWXLHi430sqJEDD0o32G253eh8D1aVT4H7RyjCcKju/3h0zLikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoMK9CmLRxdnBtqNahDaHolpwyc/TS8eWekpviDJ+gw=;
 b=Pgo1OlVd1nWuB5ZqHYIw7BSILUXsl7TTxJy7OUOolk/5flIwLrVxL7QESXhnlyNLQGTszHtL1OHo0+LLs8M/OgEbm/iGuVFYpy4eyoA2nmBVLYv4cAqVwzl5izYnsYOdImQAC5MpGgpM8KWpL++lnEFN4lY5TiMFIMRNxRxk+XQ=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BY5PR13MB3713.namprd13.prod.outlook.com (2603:10b6:a03:220::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Fri, 26 Aug
 2022 22:43:40 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::9135:a6:dcc1:eb59]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::9135:a6:dcc1:eb59%6]) with mapi id 15.20.5588.004; Fri, 26 Aug 2022
 22:43:40 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Topic: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Index: AQHYtzw8aX+AMqMTVUq2gGKcakou3K3ByjGR
Date:   Fri, 26 Aug 2022 22:43:40 +0000
Message-ID: <SJ0PR13MB5755709642FB995921E6F68CFE759@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755C6DDC8E269258C410586FE709@SJ0PR13MB5755.namprd13.prod.outlook.com>
In-Reply-To: <SJ0PR13MB5755C6DDC8E269258C410586FE709@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53991f91-0712-457c-3454-08da87b46c2b
x-ms-traffictypediagnostic: BY5PR13MB3713:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: df9lFGrcKtoikwTYBa4Ux/HSILVVWTcM7ZkHAnzSpzYt+Dpmju/4t1KqSpfpN76K4Py/FQ8j1kz4HRGE2A9DtzaxRCSMmrkfqMdnmUXNPyTPLnOgK6jWF8ocoCftENCIE/CggfTcCcV+gGrCLJ0qSgZ6CPHngkNpcU6zmsI1Xpk25T/TOlURSvR/cc/TpzlHLOvJznB3CmPmCYxVGOK2soO+s4b7F8RIATw3AkH2ADVfhr67KO7xvZkOhllH8HFBINUe6HgFe09M9i+bo55WHF12PAuwGfc0TYzW9fUzu5qEww8MGnqNQ4drpoXXGkA36IZPpeJ2cewxwhi+bopUk+kiLd5gwpNYf1oK52a5aZt785tc/+zQKKfUNfWOlv9DPHb5/FBvd2FsmTsrjwEJysxRsB/zoj6UqU72/Oi7jLGVOLRvCuBvhEX2pvV97q0ZNCvhFrHcYBJ5WH4TXaQ0yG/KMXOu7EfXFyXZAnjRuEaGOEd6iA/nq8GnawfH5F68Cbp2m67yDqIqqGsyP0AuSo7qmD46yUS80FbHBwqnGLlFeh6FvV1eJyz5ryVx/PiM/6m7faiB5QR6bfiOtTsGVqnD9t5aHDTjy4wReIeYptr1WYu49xmBXdAG/a5t/nWLAIM48iwTrMUQa1UdKQ58EIJJ1yCVv5khuyb+GaUNBE8qqjntp/wDYv7fiH1vNcxSD6eniTYT7Ze10RRtGOQSMq8Cr6xqrYHj32dJOBAM1uC434fbZBxIYIErsdWzSagLt01O/PD879Au3MtehVDvtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(136003)(346002)(39840400004)(8676002)(66476007)(66446008)(316002)(91956017)(55016003)(6916009)(76116006)(8936002)(66556008)(64756008)(66946007)(5660300002)(2906002)(38100700002)(4744005)(71200400001)(122000001)(86362001)(33656002)(38070700005)(478600001)(9686003)(41300700001)(26005)(7696005)(52536014)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AkYI5EVDj/u+RD1ZQR9dO+4mUQ4sVkprnBUvPQZKuv6OuZqdRhmWPWzoTM?=
 =?iso-8859-1?Q?oMeRxAwbmGUPYhqWEPsRRPd82aLUMNVZGiPh285ZpEoOTVU964W90iFng0?=
 =?iso-8859-1?Q?ehncjw22vh3gbdmYLqW/ck6A0wq0vWqLMYC9dJL0TGnegKV4q4DKdw44lt?=
 =?iso-8859-1?Q?dJXV0yjLWaBeiBfXsTUARUFuspHVpL+PbX6qYeeVZ7Fk4JRhhKiCvzdFrv?=
 =?iso-8859-1?Q?Jpv+uOSdysC4YkLn2up4eRzq8NCeZS9bvG5ZBIYnFg6FXkYQzSpVDMqHTq?=
 =?iso-8859-1?Q?xu1bFygG8NDOxdC0l3CvGj6hJrmvsVbmuJdFKce/ogLUfjl+Jpx+DTcd3s?=
 =?iso-8859-1?Q?xle2eD5vz2TuUSakPirViwKz+i1tgVDSN/23rRdSa+g6R9ggQYUwVhu67+?=
 =?iso-8859-1?Q?bQzQJ2F9/Y/2fdO05K/E2qhwlXWzbPOqU9ZR1r0t5F/+4LD+VAeKfzzUMx?=
 =?iso-8859-1?Q?LMGlEuzzvLObUofL/FVts8eNpxHgWYikOmCi6DPZ8uEpxSIfcAKY2V6QbG?=
 =?iso-8859-1?Q?KK3O6Z+B/MSscBkue3V1n6EnyJ/4J+H4p12g9cAiwfsiYcXCGoUewvBDBQ?=
 =?iso-8859-1?Q?ZEzNhmhyyBZAxT9MHrShDQ2e8oBgADyoNZkMWo8gDDTGCnMtgw/aHZleDE?=
 =?iso-8859-1?Q?Eqzgw8DQVHhhT1OCP0MaJKCRgOZtL2/MwQgo8eiyWlDRULTkZfMLpNvqVI?=
 =?iso-8859-1?Q?ZYZQNKgUXqsL3fQ8ShsRUae2u5wjqdBM2KbBEGSXM8iftdhSYeOr5s/+Mi?=
 =?iso-8859-1?Q?kaWZ89qsNqAG5w0Y+tASkRECwqkVKVPsb9OiC9tRF7XJOh/dWZnovSC62c?=
 =?iso-8859-1?Q?/C/4om+Ordo1jjH1g6vQgzegwzMaSpNuBJ34bnbNY6oARAhzvz56PQC4RQ?=
 =?iso-8859-1?Q?Cs24Ps+NSFMvWy+241YvH37igUhX5GQCJY/uleNUWP0ARtPW/HZDwyvQiQ?=
 =?iso-8859-1?Q?XGyJf+ajpki7QfCSKoFzXz1uf24bwMBteRbDJ+2uGKUy5IZvFm6dSGequZ?=
 =?iso-8859-1?Q?EPs1A5zq4nNpPLBnGXxe6AEzgEvwMmI1YmC8K91J3U1ExkGEt64RUJ3ijT?=
 =?iso-8859-1?Q?vd/Ersnccf5BqDF1NOmFsQtRzYq9DLL3syIsCFkncn7NAMjyem+1s3/yFQ?=
 =?iso-8859-1?Q?NC21F4RGIXLcGihWc8GfCsuX27umf8B34urmr1KtW/fQeL9KVhVERZNyfs?=
 =?iso-8859-1?Q?bXRcVuRpcO/H0sIulskitvTIPGspmFTQMQ+T7WYNe4rkODYDl/py4ptLHv?=
 =?iso-8859-1?Q?7s8FyJQW1f6mGS+2ffOm2rgg3JvtyNJZZdGlnq6QPeTYcVHU+2V7jD69mb?=
 =?iso-8859-1?Q?CIv9ywOHCOKlok90QIqssGnGZ6rqmspf30L7SYRxsRLYbhfvjFsXpfK+dp?=
 =?iso-8859-1?Q?wXtbCjT/YIFlw1oY4ffVnfwVC552n3vAv05jQhH9sz0Grutd5SFV9R9Vf3?=
 =?iso-8859-1?Q?a9EqkkuDUV/1P0EywoA0v/FrHpf0ZJJNNxVGw8sdsS/+T6PPEYb9ZVMKRm?=
 =?iso-8859-1?Q?xYb3Y50VdhFRy1481eOZ8OyDUwJr6e0TmdBH8NH6JfS8X36EKOwFiADKRb?=
 =?iso-8859-1?Q?m8XEzGNBKiVdU47FofLFkGiRd68uRRbg1ewdTvrSMUay7X/rz43NaG1jnb?=
 =?iso-8859-1?Q?hOJtt6rwDoUQU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53991f91-0712-457c-3454-08da87b46c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 22:43:40.4824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6gNjghmRdWJpIZAG+X+M39DimznaqPz7DrVip7TaEm7py1viQn401qUM3fE3BN/TksfvIFpCk3kK9cHjBNG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3713
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Maybe I need to create a pairing AgentManager, even though I don't use one?=
=0A=
=0A=
I see that bluetoothctl causes some D-Bus transactions that may be relevant=
:=0A=
=0A=
signal time=3D1661551309.565274 sender=3D:1.49 -> destination=3D(null desti=
nation) serial=3D27 path=3D/; interface=3Dorg.freedesktop.DBus.ObjectManage=
r; member=3DInterfacesAdded=0A=
=A0 =A0object path "/org/bluez/agent"=0A=
=A0 =A0array [=0A=
=A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0string "org.freedesktop.DBus.Introspectable"=0A=
=A0 =A0 =A0 =A0 =A0array [=0A=
=A0 =A0 =A0 =A0 =A0]=0A=
=A0 =A0 =A0 )=0A=
=A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0string "org.bluez.Agent1"=0A=
=A0 =A0 =A0 =A0 =A0array [=0A=
=A0 =A0 =A0 =A0 =A0]=0A=
=A0 =A0 =A0 )=0A=
=A0 =A0]=0A=
=0A=
method call time=3D1661551309.566053 sender=3D:1.49 -> destination=3Dorg.bl=
uez serial=3D28 path=3D/org/bluez; interface=3Dorg.bluez.AgentManager1; mem=
ber=3DRegisterAgent=0A=
=A0 =A0object path "/org/bluez/agent"=0A=
=A0 =A0string ""=0A=
=0A=
method return time=3D1661551309.587789 sender=3D:1.49 -> destination=3D:1.1=
 serial=3D30 reply_serial=3D1096=0A=
=A0 =A0array [=0A=
=A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0object path "/org/bluez/agent"=0A=
=A0 =A0 =A0 =A0 =A0array [=0A=
=A0 =A0 =A0 =A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0string "org.freedesktop.DBus.Introspectable"=
=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0array [=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 )=0A=
=A0 =A0 =A0 =A0 =A0 =A0 dict entry(=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0string "org.bluez.Agent1"=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0array [=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0]=0A=
=A0 =A0 =A0 =A0 =A0 =A0 )=0A=
=A0 =A0 =A0 =A0 =A0]=0A=
=A0 =A0 =A0 )=0A=
=A0 =A0]=0A=
=0A=
John Klug=0A=
=0A=
