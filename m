Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB8ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 17:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiHaRxm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiHaRxK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 13:53:10 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CF770E68B3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 10:52:46 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 28BE182777_30F9FDCB;
        Wed, 31 Aug 2022 17:52:28 +0000 (GMT)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id D4B2482672_30F9FDBF;
        Wed, 31 Aug 2022 17:52:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsN/+g6Hw+9hwEF8D39bqssBbhZ/aZU1zOaaIB60x2rmkR4jRnykM6pYuqREH1cbjeDwLT3hth7nv0yo+uuFmOGlEjI5Ebn6q6GVAvoZ7wZXcHsHrx8nDAisO7/mVz4eqmmRKyDPDeqAllgyqRWEt/V3479p/d4KWRSfYNJPAj+lp16YYulg0QPaYjBOrafHRIH4QLInOPcP0pYp7Yedbh/4ccevKXUgbwpXgEt/t24/pUREXqGRzxD7PWjvNQ3AMj4Wf288SZ0/W/hYzjk2piUnm39xfZKPH7p6iXeqRJ5NbDsGksexaeVagaaz9yZyuVuvIUgYlvuBvbpiMILKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik7lNFInlu1i8O8plH4HRVUJ27UIO3YZ7L3OwabvoIg=;
 b=bAnLnMU6h51Kn2L5zVc1/7WWT22HZHomHlOWOpQvDK+GNVH0NFGM99ZRSVYlfk3xBzlFbdFDpH7QCi+1q24tmD2sEAWvhACsOD4Y7Da655copFmFrzMq08g+KxxWboCyFwVHJJmBiWkCDqMrKgLFzxTX+2L71Lw1/3pgOFi05F3LS51zTJUFQ0TtkYxU30ogKqIU1jKkVeu/6NT1Mtv8UOx+AJlnjL0b7nDATFGGP4VWRlr4yJRWVmnbAdi8LDSVm4t3vAulAUZjMaTTJ8QB0fWRQLxHi5lZbNbhxjWZ9E24ArP/quW9NirtPjwyjOUVpaRoZ/zeJMYTbKPdZdtJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik7lNFInlu1i8O8plH4HRVUJ27UIO3YZ7L3OwabvoIg=;
 b=HmAMdIXBbN00H9KX1n3gFsZ19okTkyXvJCqHBYZAxg4LtM5kwwR9M9S4qZdcHGaW7LYtFqBXGBqsf/2h2zXsfjAExU7oidcaqvr3GGEwYFxiMxlsUMCmW43oPC1078wPPYONG+H2utBrt4V9Gh43KeDl99Z95rDF0FzGDWtRA58=
Received: from DM8PR13MB5111.namprd13.prod.outlook.com (2603:10b6:8:10::21) by
 DS7PR13MB4701.namprd13.prod.outlook.com (2603:10b6:5:3aa::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Wed, 31 Aug 2022 17:52:26 +0000
Received: from DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::1d9e:1cc5:e9a1:95dd]) by DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::1d9e:1cc5:e9a1:95dd%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 17:52:25 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Topic: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Index: AQHYtzw8aX+AMqMTVUq2gGKcakou3K3ByjGRgAPgiYCAAfM/WIAAWqcSgAAYkwCAABiTE4ABKUss
Date:   Wed, 31 Aug 2022 17:52:25 +0000
Message-ID: <DM8PR13MB5111D5B5A27A530E3391C774FE789@DM8PR13MB5111.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755C6DDC8E269258C410586FE709@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <SJ0PR13MB5755709642FB995921E6F68CFE759@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <3dd715a9d8b30ccb6dce4d4e1e034cf8d0458d44.camel@hadess.net>
 <DM8PR13MB5111064C283B3B2F2E8C3681FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
 <DM8PR13MB511149D1CDA49915538C8FC5FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
 <CABBYNZJNdQeXwVcnjsukMaPvn9s0zHWN2_i_T8Hidyj0WcGM=Q@mail.gmail.com>
 <DM8PR13MB51110AA89369F0759192EDF6FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
In-Reply-To: <DM8PR13MB51110AA89369F0759192EDF6FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7838dc46-6b35-405d-a232-08da8b79908b
x-ms-traffictypediagnostic: DS7PR13MB4701:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uO/enHO1lGcdXzUQvx9Lh8e30Q0z2d5U+2hDH+TNobF3J9nvUxToo35Qoq85DDr5OBxsOf95868nbUVCKGIHJdwD+AZaWzd8fgivw0j3/m8VH+yv6otndvA+IHp6pN/nAhvPTpPq3Oc1Tbdtah9UsxklJTn9fwMi/uu8H5BSdYWFRgNnQhdTxdvZB6fRuFdvIMbzNAO8HmFpMELEnHHI8pvdKQizUK7y081O0mtdsZ5CRlAZ1vPhrOKxT/3ZKgwMoc5Up/Ev9YNmQxy5EqFKvzKQ0+jcwWGwss7p10PUof/9/R5l/are9IdrnYCeQ9k5dqx5mbUu2B43CnkJIv5eo/P9QffU++nqkTCXd2Us5vnWAnYHwThO9mEF7DHphzuYw1HT4ZVg6N2ZVmijvAn1FuIyX3jsF+n6N+irNCgCUoD2OG+3JMjCpJx/18WyaIZIihmAF8zDeH/27Ujz7QVtQRAHSrp2X1MaCOc2CyE+AUEcriHBd0Uzu5gBWfDSLOpF+Y9zskH1K+bdH5M8Urfx9ZMzYLroAEgoxqqdF9vYimuPcmUy2adOS8juhGz0hs3yMhxDvQ9hOyQrofySSlSfJvVNGalv1kzYTIj+d3LmMFFtpAQErkKmn+1IX8zdU2AeqdXv/0OZe69mp+U6EsbVR+LziS9RxaRAa/gzEGgi7ianQlMv2OGiYpnzE4iX+cA+xr9A9IWTt5tiZCnlRDF7IelIlZjL1rR5G3IKdmnlVV5RDaTRg9oAVlLmTN+G6MrnxqgqfTYLllG4DwyjP3GuzImORoHr0G/uh55UYhYaoKe/fYfmCFUVdEp0NilDVJOz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5111.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39840400004)(396003)(346002)(366004)(136003)(9686003)(6916009)(55016003)(38070700005)(8936002)(83380400001)(66946007)(5660300002)(8676002)(66476007)(4326008)(76116006)(66556008)(64756008)(186003)(52536014)(33656002)(2906002)(71200400001)(316002)(478600001)(7696005)(41300700001)(66446008)(6506007)(86362001)(26005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0QXfLEoukxMgStjCqg0wU84g9WUAoyaSQFrvgFnsxfn1XBenwQ2eySsaQu?=
 =?iso-8859-1?Q?5YBh91b/iZBgxUT8pDGxJCU5/D0N0qnPBuZIetyEmHQY5XQql7wIZV2yQ6?=
 =?iso-8859-1?Q?/K0pMOnSRPBhc5OZ1KPs+3a3wiXhBoajE7MdCPKZRgyRJKgu+F9E4zmYF9?=
 =?iso-8859-1?Q?qz9mZiwWI62alYZ+4gNtA2qQ7u/Gu6Ewmv1KYCUnWdgQllyjoijRSgxBN+?=
 =?iso-8859-1?Q?rsFPFdM7wBnot7Q1ql4LJ/aoab7Q5LO+FjW08STJ42epG+yyzzdXxrrzwE?=
 =?iso-8859-1?Q?FZ15EC+J1t6MxNq8p0ar+5KCNX3mCHez6okm2ZPMjD2n1I7HRJTbKtdjdK?=
 =?iso-8859-1?Q?sGEl1eViRdsvOijBsaNafbmVq6HVEDMaGDOCZQDc+ijObJtjeFgwUz2kQ7?=
 =?iso-8859-1?Q?3tqiCP2suv6QqZisVF8gBxVmaKTr0Zgm1Pb7I2fPMSB/Ptyr4vAeSCw1+3?=
 =?iso-8859-1?Q?NcgR9nzgJcbLm0E3VumHpNiIZq9MjwXxnRy5FxuVN7Dh8uopiQfWHSj3tc?=
 =?iso-8859-1?Q?t9UpLpfTLnbm0LwHbVTA1DJkmapfa7ARbG0HgvJy4UoLGyXaqqb5yazQjC?=
 =?iso-8859-1?Q?IDEwD9mhOff4hvJutJslJhO2meZeicZdH9VnHNHB3Fvz0783IFLZB/hwJj?=
 =?iso-8859-1?Q?AEosFtXKnsvkgOKpEjhmy/hVqmxVyC4+dQ/UBcKQv9X9GpYORJMbbbss95?=
 =?iso-8859-1?Q?o5UX6O4fDhTgqRKDx1C97cNzS4+lnGnolqlWAWKDdZ3zvVNA1O+WaBHpub?=
 =?iso-8859-1?Q?4p/iMB1LI/ju2z93QD2McRYATUjhAH4ZyCcpT0m9OWen6H8cBeRGR2MfgX?=
 =?iso-8859-1?Q?rhJlW7DYPflwBGVMKvLblf65QkS9y/AmFt4xFlLw76TK2imCfxzIhZldZ/?=
 =?iso-8859-1?Q?3yL26R+seQsHQC5hEc2+eee+IoguSYZkmducweJK0ZbX4sognlaonCo3oC?=
 =?iso-8859-1?Q?XuHzCv6Umabukbm+YP48c2K14FaReii2CUfvdG2NWBUO+XIjB3NqQl3UUf?=
 =?iso-8859-1?Q?wMTCA7c1Nk3etuicUf/Fy46ri2jzc6j+PiEvcwTlsuS8+dIL/ONSXsZgfl?=
 =?iso-8859-1?Q?8SGguFhcFiyFbGd27nqyQ54Mjt2YBzna5FF1WzOwnI2anaekCnhlNhkMCD?=
 =?iso-8859-1?Q?QDJSviOZ/kA7NIHQUHrX8Pe5R7Dj7JX6CEVMXAtl7eAetVtd/kFiCyyFl7?=
 =?iso-8859-1?Q?k0sR5pztiWugKdAvATJ3Cj1+zeBZo1muqWHw0mQjBOOsKJVDWj7SpRqMZe?=
 =?iso-8859-1?Q?BbPEROu0rNwuZ6spz6915SmBximkO50JmfpkBOWP3QRrGzncmsi1VPtv8Q?=
 =?iso-8859-1?Q?LmEGUMoAhgKM6y2UuGQeff+7TjR2BFeWC+vn+IekbuvdYfGI1TtldBAuAJ?=
 =?iso-8859-1?Q?jhRCvx/lwhLZHnaLpAtUq8TKbYTVQHYdOU1pgROPs0wC4rhpuScOZz+biE?=
 =?iso-8859-1?Q?fYjsR+RqMFTZTufwwMJpZQkgtYnAP7QUnu4hByK+YILdYx+ZjfaOgT8OXi?=
 =?iso-8859-1?Q?dOsOX2iwmo/+25td1kiubz9umDqzcYyxP9obwFBK0kbx3ne+OQND4mMHBF?=
 =?iso-8859-1?Q?PilXM8y28WpsCM2R7xZio++w/NcsES8qlSO8N7pPrfzfJC0QPjFHWmkQUr?=
 =?iso-8859-1?Q?j1S7TuA1HKL/U=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR13MB4701
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am finally in business in Linux 5.10.=0A=
=0A=
I built the old bt-agent, and started it with the NoInputNoOutput agent whi=
le running dbus-monitor.=0A=
=0A=
I saw:=0A=
=0A=
method call time=3D1661900193.562288 sender=3D:1.1182 -> destination=3D:1.1=
171 serial=3D23 path=3D/org/bluez; interface=3Dorg.bluez.AgentManager1; mem=
ber=3DRegisterAgent=0A=
   object path "/org/blueztools"=0A=
   string "NoInputNoOutput"=0A=
method call time=3D1661900193.562697 sender=3D:1.1182 -> destination=3D:1.1=
171 serial=3D24 path=3D/org/bluez; interface=3Dorg.bluez.AgentManager1; mem=
ber=3DRequestDefaultAgent=0A=
   object path "/org/blueztools"=0A=
=0A=
I wrote this code in GTK:=0A=
=0A=
#include <gio/gio.h>=0A=
const gchar *AM1 =3D "org.bluez.AgentManager1";=0A=
const gchar *AGENT_PATH =3D "/org/bluez/agent";=0A=
GDBusConnection *con;=0A=
=0A=
void bluez_register_agent(){=0A=
=A0 =A0 GVariant *result;=0A=
=A0 =A0 GError *error =3D NULL;=0A=
=A0 =A0 result =3D g_dbus_connection_call_sync(con,=0A=
=A0 =A0 =A0 =A0 "org.bluez",=0A=
=A0 =A0 =A0 =A0 "/org/bluez",=0A=
=A0 =A0 =A0 =A0 AM1,=0A=
=A0 =A0 =A0 =A0 "RegisterAgent",=0A=
=A0 =A0 =A0 =A0 g_variant_new("(os)",AGENT_PATH,"NoInputNoOutput"),=0A=
=A0 =A0 =A0 =A0 NULL,=0A=
=A0 =A0 =A0 =A0 G_DBUS_SIGNAL_FLAGS_NONE,=0A=
=A0 =A0 =A0 =A0 -1,=0A=
=A0 =A0 =A0 =A0 NULL,=0A=
=A0 =A0 =A0 =A0 &error=0A=
=A0 =A0 );=0A=
=A0 =A0 if (error) {=0A=
=A0 =A0 =A0 =A0 print_error(error);=0A=
=A0 =A0 =A0 =A0 g_error_free(error);=0A=
=A0 =A0 =A0 =A0 g_abort();=0A=
=A0 =A0 =A0 =A0 error =3D NULL;=0A=
=A0 =A0 }=0A=
=A0 =A0 if (result) {=0A=
#ifdef VERBOSE_DEBUG=0A=
=A0 =A0 =A0 =A0 gchar *result_text;=0A=
=A0 =A0 =A0 =A0 result_text =3D g_variant_print(result,TRUE);=0A=
=A0 =A0 =A0 =A0 g_print("%s\n",result_text);=0A=
=A0 =A0 =A0 =A0 g_free(result_text);=0A=
#endif=0A=
=A0 =A0 =A0 =A0 g_variant_unref(result);=0A=
=A0 =A0 }=0A=
=0A=
=A0 =A0 result =3D g_dbus_connection_call_sync(con,=0A=
=A0 =A0 "org.bluez",=0A=
=A0 =A0 "/org/bluez",=0A=
=A0 =A0 AM1,=0A=
=A0 =A0 "RequestDefaultAgent",=0A=
=A0 =A0 g_variant_new("(o)",AGENT_PATH),=0A=
=A0 =A0 NULL,=0A=
=A0 =A0 G_DBUS_SIGNAL_FLAGS_NONE,=0A=
=A0 =A0 -1,=0A=
=A0 =A0 NULL,=0A=
=A0 =A0 &error=0A=
=A0 =A0 );=0A=
=A0 =A0 if (error) {=0A=
=A0 =A0 =A0 =A0 print_error(error);=0A=
=A0 =A0 =A0 =A0 g_error_free(error);=0A=
=A0 =A0 =A0 =A0 g_abort();=0A=
=A0 =A0 }=0A=
=A0 =A0 if (result) {=0A=
#ifdef VERBOSE_DEBUG=0A=
=A0 =A0 =A0 =A0 gchar *result_text;=0A=
=A0 =A0 =A0 =A0 result_text =3D g_variant_print(result,TRUE);=0A=
=A0 =A0 =A0 =A0 g_print("%s\n",result_text);=0A=
=A0 =A0 =A0 =A0 g_free(result_text);=0A=
#endif=0A=
=A0 =A0 =A0 =A0 g_variant_unref(result);=0A=
=A0 =A0 }=0A=
}=0A=
=0A=
Thanks for the help.=0A=
=0A=
=0A=
John Klug=0A=
