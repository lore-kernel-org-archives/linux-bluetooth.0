Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18094ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 00:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiHaALg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiHaALe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 20:11:34 -0400
Received: from mail2.multitech.com (mail2.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 2EE2695699
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 17:11:33 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id C578A586930_30EA734B;
        Wed, 31 Aug 2022 00:11:32 +0000 (GMT)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 8F5F2585DC8_30EA733F;
        Wed, 31 Aug 2022 00:11:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1CHthHhcveQEuJAGmPHHSD37/yhHjHbdAfLwic97+d47DpzgLewOlsXcZmwijZjJ04YsDG7QzavWnIb/TqzTc0/+NXxjFy55PVhJclQMfn1XpjaPx+ZWHr6t36e6FtBDafCh/zbeQEApO/VT0TzVhFOp+NCvKLZkx/6+7CgkWbGan1iICrGaeRQvE/jg3QUVICy6aOZPecAU/GiDq0h0eo6MY1zvSrlcNBtTM/r9PcJYKCEgFjcB7imNCpRKYppwg+KLKxCS4rWiFHnE3ZE2gu4sPYCygjUOANun/rlt6e/7loh9N+hJqk9BV7q0ruHMih0qyrmi1zHofrHWe5VBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGBn+2EnBGGIEAxB46fHyJFPBYmWw9cQHFwNFIRpNqw=;
 b=noPWmF+/e9KfIsZAEATZ/lgK//FQd25OIarasGDElUu/BjYo7eihAy9Cir7hmu+BltvNqa3yr8ct3Js/Fh6NRzhbvRn1udy+0CmMd1bi2t9OoIXyVk6U0EI3oZTQ+J6Ud9Tdp8sAkuDATmKjj+dylAklWej8yAkwqkt/RdUm4DMiEb1+M9iKJQ5zpqnxhfwAXujJ8AvGDZbKroUp9xR7KEDL3e0aNIUnlmdJucWWKjMlE1Kql6fymR/5W8n28Hu5lo7yOaVY7mrxjxg31q0QSKZpZUZIFn884Q3b3uTPIY3CzwduFSJ5Sun8DtSFRRcvH4VCgEQBNfOl6Kl46tqCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGBn+2EnBGGIEAxB46fHyJFPBYmWw9cQHFwNFIRpNqw=;
 b=E9dTd88rWt54HldDASJ5S2CN4+gvyrD9oDR8HOe83UbEeRK+OnhDAbwOVdRYBMaQyQ5KVn93eH/Kejl+WTrfptVF4x1AllfjIjoLf4+OGwcbKs+UGYTPQkhizdKAk2PsuSYQjEE9KTTX67tRuFg5rDHLgh/s4F8ahEz91UfyekM=
Received: from DM8PR13MB5111.namprd13.prod.outlook.com (2603:10b6:8:10::21) by
 BL0PR13MB4420.namprd13.prod.outlook.com (2603:10b6:208:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 00:11:29 +0000
Received: from DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::1d9e:1cc5:e9a1:95dd]) by DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::1d9e:1cc5:e9a1:95dd%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 00:11:29 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Topic: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Index: AQHYtzw8aX+AMqMTVUq2gGKcakou3K3ByjGRgAPgiYCAAfM/WIAAWqcSgAAYkwCAABiTEw==
Date:   Wed, 31 Aug 2022 00:11:29 +0000
Message-ID: <DM8PR13MB51110AA89369F0759192EDF6FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755C6DDC8E269258C410586FE709@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <SJ0PR13MB5755709642FB995921E6F68CFE759@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <3dd715a9d8b30ccb6dce4d4e1e034cf8d0458d44.camel@hadess.net>
 <DM8PR13MB5111064C283B3B2F2E8C3681FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
 <DM8PR13MB511149D1CDA49915538C8FC5FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
 <CABBYNZJNdQeXwVcnjsukMaPvn9s0zHWN2_i_T8Hidyj0WcGM=Q@mail.gmail.com>
In-Reply-To: <CABBYNZJNdQeXwVcnjsukMaPvn9s0zHWN2_i_T8Hidyj0WcGM=Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d506e8dd-119e-481b-12f6-08da8ae55a6e
x-ms-traffictypediagnostic: BL0PR13MB4420:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G4Y+uyjTFhkUsE1UEwTPYZd6cmAUW5UpvPWJqPEw/B9Bl3gyvZwysLL+60g+s1MtDciNyGc+O2yTreZXSBoLkaXdeNm8RFP6vRVUdfGo/6Q8SFzniKGgt/3CS1xLYBR4EgLiv2nzfwHIwjaVyDtdkh5eAzoWdTJabyUIg5gPu7DpKBJHteq6jBF6qI7+UvceWCiI2YfBQEwhtNmP29db8a9l1lpfc8/Vup3RgdFKyJvX9b08CuDinH2K5QmNJBe18gfAlbdO36ukg5vI39n/mHj3+prN7PK8HX1aF6n93zBtqiZTqb7RaZHboAbxnf0lcC9OPFZwBupHEam564B0X5GWZYNycrbpYQdZMx42ORnG2WX8eyMkBZb4Yi7EdfqbMni4LE/3qqhgLXsC22exEynNFGkxKZYwFW+1P/Fb5DXozxXo1uWMFdWgfIhwDhriFaJ1sb1nkwxnK0yIvocIlbMheNIRtDzC6tc1z+8TvPcvTa+sba/fOuaWPQLdxSJ2aS0GR9VIZtXQn+0H98r1LnGaMlEEhd5vao90LgHbSeG315TpNOgeuRwtmAjqw+eX4/OqGGqVP1FD3DYV1yc7UzQAenfE0bZb7ZpyPBSd9ge17AcZgMfs9rQ1ShIb92qJnBU4QsvTFgUNmuBh/4akQDhVFx9Wkon41oaO+apVOKZ8lkGNlysXyzUr//eLy91dEmaRjr/602DB6nsbYO7GWmaxklBUOwwlcQUKOhMrVtzXzacCobyu1q7cRZKCgpai2UHxUuqY0X7bZ+XoA+fcpIKa0+7CV6mPwlpFvTTvK+nepLLqLTpB7wCk9oBISWyCs7APiDd6QPuALbQCEVSGIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5111.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(39840400004)(346002)(41300700001)(6506007)(53546011)(86362001)(7696005)(316002)(71200400001)(478600001)(966005)(26005)(122000001)(38100700002)(6916009)(38070700005)(9686003)(83380400001)(186003)(52536014)(66476007)(33656002)(2906002)(66446008)(5660300002)(64756008)(66556008)(76116006)(4326008)(8676002)(8936002)(55016003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4ksQRrvvFOWgNyr0S0MGcHQSYDqdtipA341erU3v6ilidnNG+4vES0zq/m?=
 =?iso-8859-1?Q?tKw80LhdIn8iotLw/L91FJ8yvxq5AoIWmJetiqrPWvgDVemnsbaaqtQq6C?=
 =?iso-8859-1?Q?qtq7MrZtf/oANs6J2THptKAvDDUVQwJD928ffgDOWQJgMcvQa3g19joDhZ?=
 =?iso-8859-1?Q?x8VcQFXBaikggQnZs8E/YoIRBnqaE+T04Xab79puWydiDyzI/QnbNGEY2S?=
 =?iso-8859-1?Q?kscKW6idVhcJLWp5lbBKbdZrzsfW70tOZpr+FOVRWzB1wxfJBE54rRywYS?=
 =?iso-8859-1?Q?WBRFYzufrRgR+UqXLtDMKMcoluT7I6kP8klGdJOv2gUtfGk7O5yPG4GZVU?=
 =?iso-8859-1?Q?g2qmNz6SCNHi4E7pIILGq61sr435u+WRXb5UwbE4XQNu42bZHxYCByOYzD?=
 =?iso-8859-1?Q?rW15Qv+G3P5/JMCU68Pnl2pcfEkvFf8hokb1JHG89pxHkeVeI0jEhkI01h?=
 =?iso-8859-1?Q?m0UiQaCbrXtzCMfHmXftvUzJatKlp+5uHlqdBitr9hAYpck3E/yEM3J9LU?=
 =?iso-8859-1?Q?f3FrZmuJcV5Fi8g7c3GyLsspIVOgSkgJX3AEfin6tlaPw8Gj+cm8Tbk8KJ?=
 =?iso-8859-1?Q?iBT37P7gkxlg8og1yFl4m7H5BkEGxH+iz2+uPe2wXCUcqIKn7NT4FICQ/d?=
 =?iso-8859-1?Q?TFyJi/F6AjPUvb/A8NrX9xLEEXHxGQXApOXB59MvLwrV5KoOCgfk/yZh5S?=
 =?iso-8859-1?Q?/8ncx27EZiRClZ+0Bv40Ki3JUPNpxD34qo7udCVkwO7JTdgrOUOBAKpe3X?=
 =?iso-8859-1?Q?YD7R3FRqdGnTPxIC5NBtRFpsk8/+jSeT4vadlgXP1foNJlsFQE+yk38GVW?=
 =?iso-8859-1?Q?6DoPINIJtzqMZnvVhLwIRJboEGJTxFuPFYuZd63Dcj0ixWaYM198T7KbKH?=
 =?iso-8859-1?Q?oLm8/yD/BbsYaREDh/xiUMOQ0jkBPIDusgAWUgi7OezyC5VoczcTYW5CMG?=
 =?iso-8859-1?Q?bpOE9NDj236TQoGEMCe1NwCqNoU98pmKXAK3XkQs/GtLvstFQkPNsB304X?=
 =?iso-8859-1?Q?Lvcux1Se3shMxQYqkVVN/EMuZTW9dCbT+4l2/XXUAX7V+2iX8eCVjHsAnh?=
 =?iso-8859-1?Q?ONgIN77Ev8IsWF7k4h7FV5f8c1q4BZXUuU8BTRmbtq3rWsqBoySKaMLqER?=
 =?iso-8859-1?Q?AEF3zhJxcxHCUpQ0tiM9BZ0TPvtnL6+Kjpimb0igUWuU2V4vJ066iKoJzK?=
 =?iso-8859-1?Q?yQ4QBet0C53uHuy86VnnlauKlLMSNW2XjiGdI+kb+BHERtrxvDAmmQzErz?=
 =?iso-8859-1?Q?My3t0yJR3OUAVyeXTwbr7FG9CKYGtkz5by14/62jkhrKpRKY6fi4yM3VlY?=
 =?iso-8859-1?Q?FkbzVPny8+V9HA0qL2T3Uwzt04DbUUJNu26N6TpVTOZ3nUTzsUNnMNlpv0?=
 =?iso-8859-1?Q?NCi26RP1OUyndocnoxPU3bHK1gz23nufWJcwmrvl2W12M5k78zj+ZFbtfo?=
 =?iso-8859-1?Q?ZGLfga3ChzZxy1GIKfq7Ocsl8S5fF4H9bsB95NzK08AAWHIk1U3cvxqyew?=
 =?iso-8859-1?Q?xMEdcBPfWRzHn5L8/Xa8e4bjDmIDxmevIlMBg7lhrNGaDLIshRlKVNi3Ey?=
 =?iso-8859-1?Q?Xqz2wdAstAPtWJlWSRZDYmbISudf5/hXGJ558L0KZZLio+UIkkiVns4+I6?=
 =?iso-8859-1?Q?A/sKf9TlNEmUM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5111.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d506e8dd-119e-481b-12f6-08da8ae55a6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 00:11:29.5029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJK1V/sqorKKUDoXFCpKJ+ri4teuUUmUcjEToOVJ11lvq5iNtVyfrVxpW1s/r0oRZFSERZ8hMvcJ6MQTNp4z5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR13MB4420
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Luiz Augusto von Dentz Wrote:=0A=
>have you tried=0A=
>just running bluetoothctl to see if that makes it work?=0A=
=0A=
Yes that was the point of my title.=A0 In 5.4 Linux I do not need bluetooth=
ctl running, but in 5.10 I do.=A0 This is a BLE GATT Client.=A0 I do not sa=
ve anything  involving credentials, there are none for me to save. I always=
 remove the device on disconnect because there are too many devices.=A0 Con=
nections are short lived. There is nothing to do for pairing except to exch=
ange public keys.=0A=
=0A=
I cannot let bluetoothctl run because I have an embedded device, and scans =
by bluetoothctl add to the CPU load, and I cannot turn scan off because I n=
eed to know when a new BLE device advertises.  Devices are not advertising =
when there is nothing for me to do.  I have a filter, but bluetoothctl igno=
res the filter, but my application works fine with the filter.=0A=
=0A=
So if this is a new requirement in 5.10 Linux, I need to add an agent to my=
 application.=0A=
=0A=
Looking at the agent documentation:=0A=
=0A=
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/agent-api.txt=
=0A=
=0A=
Agent-api.txt says:=0A=
>It is not required by an application to register=0A=
>an agent. If an application does chooses to not=0A=
>register an agent, the default agent is used. This=0A=
>is on most cases a good idea. Only application=0A=
>like a pairing wizard should register their own=0A=
>agent.=0A=
=0A=
Is this documentation obsolete as of 5.10?=0A=
=0A=
When I run bluetoothctl, nothing happens in bluetoothctl during pairing (wh=
ich is what I would expect). It just makes things work.  If I create an age=
nt, it should be a trivial one with NoInputNoOutput set.  There is no pin. =
 There is nothing to do.=0A=
=0A=
Right now I am trying to determine what exactly needs to be done.=0A=
=0A=
=0A=
<html><head>=0A=
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8"></=
head><body><div style=3D"font-family:Arial,Helvetica,sans-serif; font-size:=
12pt; color:rgb(0,0,0)"><br></div><hr tabindex=3D"-1" style=3D"display:inli=
ne-block; width:98%"><div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Ca=
libri, sans-serif" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> =
Luiz Augusto von Dentz &lt;luiz.dentz@gmail.com&gt;<br><b>Sent:</b> Tuesday=
, August 30, 2022 5:28 PM<br><b>To:</b> John Klug &lt;John.Klug@multitech.c=
om&gt;<br><b>Cc:</b> Linux-Bluetooth MailingList &lt;linux-bluetooth@vger.k=
ernel.org&gt;<br><b>Subject:</b> Re: What could cause pairing to fail when =
bluetoothctl is not running?</font> <div>&nbsp;</div></div><div class=3D"Bo=
dyFragment"><font size=3D"2"><span style=3D"font-size:11pt"><div class=3D"P=
lainText">Hi John,<br><br>On Tue, Aug 30, 2022 at 3:22 PM John Klug &lt;Joh=
n.Klug@multitech.com&gt; wrote:<br>&gt;<br>&gt; I am now looking at what is=
 going on with a sniffer.&nbsp; For some reason in 5.10, the AuthReq always=
 comes from the slave (BlueZ is the master, GATT client):<br>&gt;<br>&gt; 5=
.10 kernel which fails, leaving out empty PDU, L2CAP Fragments, etc.&nbsp; =
This sequence is reproducible.<br>&gt;<br>&gt; Sent slave CONNECT_IND<br>&g=
t; Rcvd Security Request: AuthReq: Bonding, SecureConnection<br>&gt; Sent P=
airing Failed: Pairing not Supported<br>&gt; Sent Pairing Failed: Pairing n=
ot Supported<br>&gt; Rcvd Exchange MTU Response ...<br>&gt; Sent Pairing Re=
quest: AuthReq: No Bonding, SecureConnection | Initiator Key(s): &lt;none&g=
t; | Responder key(s) IRK<br>&gt; Sent Control Opcode LL_LENGTH_RSP<br>&gt;=
 Rcvd Pairing Response: AuthReq: No Bonding, SecureConnection | Initiator K=
ey(s): &lt;none&gt; | Responder key(s)<br>&gt; Sent Pairing Public Key<br>&=
gt; Sent Read By Type Request, Sever Supported Features, Handles: ...<br>&g=
t; Recvd Pairing Public Key<br>&gt; Rcvd Pairing Confirm<br>&gt; Rcvd Error=
 Response - Attribute Not Found, Handle: 0x0001 (Unknown)<br>&gt; Sent Pair=
ing Random<br>&gt; Sent Read by Group Type Request, Gatt ...<br>&gt; Rcvd P=
airing Random<br>&gt; Send Pairing Failed: Numeric Comparison Failed<br>&gt=
;<br>&gt; The 5.4 kernel always works, but BlueZ/Linux sends the first Auth=
Req:<br>&gt;<br>&gt; Sent Slave CONNECT_IND<br>&gt; Sent Pairing Request: A=
uthReq: No Bonding, SecureConnection | Initiator Key(s): &lt;none&gt; | Res=
ponder key(s)<br>&gt; Rcvd Pairing Response: AuthReq: No Bonding, SecureCon=
nection | Initiator Key(s): &lt;none&gt; | Responder key(s)<br>&gt; Sent Re=
ad By Type Request, Sever Supported Features, Handles: ...<br>&gt; Rcvd Pai=
ring Response: AuthReq: No Bonding, SecureConnection | Initiator Key(s): &l=
t;none&gt; | Responder<br>&gt; Sent Read by Group Type Request, Gatt ..<br>=
&gt; Rcvd Pairing Confirm<br>&gt; Rcvd Read by Group Type Response, Attribu=
te ..<br>&gt; Sent Pairing Random<br>&gt; Sent Read by Group Type Request, =
Gatt ..<br>&gt; Rcvd Pairing Random<br>&gt; Sent Pairing DHKey Check<br>&gt=
;<br>&gt; Should the program be sending a Pair using the Device API?&nbsp; =
Is there something else to cause the public key exchange?&nbsp; In the 5.4 =
case, the &quot;Paired&quot; property is always being set by the Device API=
.<br><br>Either way you need a pairing agent in case the device for some re=
ason<br>removes its link key and then you need to repair, besides the agent=
<br>also does authorization when the device is not trusted, have you tried<=
br>just running bluetoothctl to see if that makes it work?<br><br>-- <br>Lu=
iz Augusto von Dentz<br></div></span></font></div></body></html>=
