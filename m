Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4EBECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 22:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiH3WNs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 18:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiH3WNk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 18:13:40 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 380555E56D
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 15:13:38 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id B18AA82837_30E8B91B
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 22:13:37 +0000 (GMT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id 2742D82696_30E8B91F
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 22:13:37 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTDc3q0EuM5CiCB4O79Y0O7B9PzMzcNny7XcYCDYCMJd+ynVhiOaNnNkBwVUvAXme8XIASpr1EPb6BWsDlktpT5/rQeWEh6EIvc1N3qc7jfLZVI33hM3Q4JtXPmM+EjO/HG/VuLe4rpeGHcj47RzIhtP9KWeJZBPL0lgknhRM1xdDnKhxBkw8Hvp0+q+RPC+PI50Pj0/2LdmkucmVydTjsdfQdRTlziVP4xGbzD9/OJzcyYm9x9yewBaAN+liCiuGHlpZVAgFLklSNb6wYIFFpVDM68/3FtO8hzW2OFbZ+qhN43kZpjLHeQPKqTT2q8G5veAgWeA4zm+C4dlR6dtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pDwpaKepyHYZe6oYHuqUVfSyJ8D8QKkTnCOU6y/ITc=;
 b=UHBzlLxH85jLU76DWrT9pIOCwh/fxqlKbmN74+DsyOACKbQGgBvp4+9Cu9NaBJ7W+Ge0L58BlcbaY1GQbLuhn/HNqPVmKbHKKAaGl3FiOrd02s83bFMWeVAHnyvASZCiOBxaPqc4o8r9hfn5SUPeJztGSkkCxc/z63RAcB8Ses3zLV6jON7e1uBm6s3ncrMlfzDqD9DtRvpos3R97IPiq3Um1kertwrd1ytvRHQ5kaeARc/Thl04TET38V9Q+xgMs8JQEHse7LTpnC4k1jCP/zY6RWlhzphFm3Dsd0eHV+V/K7gww1M0c++/C++DJl3nHWosgV+QNpGFiulV1YzLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pDwpaKepyHYZe6oYHuqUVfSyJ8D8QKkTnCOU6y/ITc=;
 b=GgJ8EZw/V1C8Yzq/QPAbB16ppy4DexS+XVrwgkxbAunTVtfZChOGyIFCJD8lqDnVtKgHmIwhurEcvNajUYzJ7Q8aAvQMAnDESWuasNn6LCf8E+SN3Gy+WLP2NiMNeXxWA8Cnnb0nmjsULjno3AVD4yz/jWenDZDtlc2g8lJ3Ob0=
Received: from DM8PR13MB5111.namprd13.prod.outlook.com (2603:10b6:8:10::21) by
 MW4PR13MB5991.namprd13.prod.outlook.com (2603:10b6:303:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 22:13:35 +0000
Received: from DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::1d9e:1cc5:e9a1:95dd]) by DM8PR13MB5111.namprd13.prod.outlook.com
 ([fe80::1d9e:1cc5:e9a1:95dd%8]) with mapi id 15.20.5588.010; Tue, 30 Aug 2022
 22:13:34 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Topic: What could cause pairing to fail when bluetoothctl is not
 running?
Thread-Index: AQHYtzw8aX+AMqMTVUq2gGKcakou3K3ByjGRgAPgiYCAAfM/WIAAWqcS
Date:   Tue, 30 Aug 2022 22:13:34 +0000
Message-ID: <DM8PR13MB511149D1CDA49915538C8FC5FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755C6DDC8E269258C410586FE709@SJ0PR13MB5755.namprd13.prod.outlook.com>
         <SJ0PR13MB5755709642FB995921E6F68CFE759@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <3dd715a9d8b30ccb6dce4d4e1e034cf8d0458d44.camel@hadess.net>
 <DM8PR13MB5111064C283B3B2F2E8C3681FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
In-Reply-To: <DM8PR13MB5111064C283B3B2F2E8C3681FE799@DM8PR13MB5111.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cc35941-6929-452e-7a3c-08da8ad4e195
x-ms-traffictypediagnostic: MW4PR13MB5991:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LCfCny4sdpiMSP2wO1aejVSaqEzEyR6INBjqMyibEs4JxJeTg/XM8zqTkCFlB/YLkLCliq7t5Ym/kEUT7f7xvRG6Vj49QSK+Wn9AvCAy9CFQ+lqNCSGgEPwNbUJoPKDUZvUTCikUgrluQmWjKa4t97YJu9gbBZExp7l5idbBC/ku2RgbiS7K+dofARz9Y3PVGh8kCDRB9Efj5ATn6MQNXzy3GqTOA4Vql6wIYOAJsQpCaRzb5oW1SC4E+uIWjX+25aC/xxvwn8S82mHvJwh29a8Y1YHEXQ6jlCvaCCp0/sdkbauIp0frm6ibZNcqcNuNm1sJSooyLnioWeyaZhLw9pusmU1mPRORq96GjJE/cE42N+kYsZlM1EIpx6BU1O/bXILWRutDtIWikdBANXcXlQNzDSUTS3RRB8BtsZjAbAlGR4q1iGu0gIU4qdOF0zEzLz/a1b5V5/c5PzjYRjpMYnTzKCf41iJYByzTXHc5ehlPc+sUJNXQkGqlZgEB4FtHLUp7+q1KxRiOGNybFLRuxIWLhXqw3ltJMy6WgGCK8prhX6bnVT2rz0BtxbaGI/vztdJXge9AFa0vlO92QNYcwZRwJa2BbLH6G4MKoAKYFcvaYmQXufZiOygr2S8SJ5LWeOHjnkrZuHXa/ZLWTR4/zxLbYjhv/7hnPVzLEKyr89roKPdlCJUXqnQn5o5jGaSBkBNTy0dErm5O02cZMv2DmccDJnrGRDEYdHDchAojaKEccHYiBVf2mr52nP8JzPz7vlFYqyWJsHlDUVkNmi4fteLpOFXqA6SrR6ucidcmKehJ4bCS0V6SYB96key2k882
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5111.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(366004)(39840400004)(376002)(346002)(33656002)(52536014)(2906002)(5660300002)(7696005)(86362001)(6506007)(478600001)(76116006)(66946007)(186003)(66446008)(66476007)(8936002)(66556008)(8676002)(83380400001)(64756008)(41300700001)(55016003)(9686003)(2940100002)(38070700005)(38100700002)(26005)(122000001)(71200400001)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jJUxC6JzN0ytHQjqD0jpRCOHAiIywHGbFrUcpuMytOze6yMJqZTfuEzJgZ?=
 =?iso-8859-1?Q?ax1cxfJz+c+FnBv4wLD8prIA4vCHisfpiNqd6NnF+AQSFzeJHijlUxN+6Y?=
 =?iso-8859-1?Q?UMNIDoe6QnsFuSUCjEFLCMzs5I+vpHhLjOLzzuP5bmUuRhv9xmnv/k7xUp?=
 =?iso-8859-1?Q?NqfSUZxcV8U3yD10XQATgPCkY4kAsEr29mPSgyHLWFXu0KWopZ4zDywWXV?=
 =?iso-8859-1?Q?fOUVAZJx8Dn1JE5ZRBKO7LPBeYIv3dyCTx1FnyyWeuDYlph4O5k/HHPQjn?=
 =?iso-8859-1?Q?D6LFN5zdvDlW8AOA6osWXxQBJ8Wy+Vn8vSBOUyU0KejQqGDGPlYocrvx93?=
 =?iso-8859-1?Q?+NX07mquORAPbclWsJG77ilsmuI8JnbtYXfhAUBUdxJoSUzIap+ioya/yA?=
 =?iso-8859-1?Q?tvvDX5mmrtoObxxYXcG8mq/IWKRU/asn48pC5NQ5fMaz1ykV5OlmwPRhvw?=
 =?iso-8859-1?Q?CLrnX970mFhe+2QhOLfdFR9VJYqV0TIeAMGVJ5LHNIqTlvGmbakqo/AbW/?=
 =?iso-8859-1?Q?0tBHhr0ezSt4fs6RWZPbBFpYN9Uv2yfy08yajwowBeZu4MvJowJTsS7Sms?=
 =?iso-8859-1?Q?h2HUbbfAFklDkw/rg/W7JHpph+GgznlqHX+kecBkULMf2dohWKO5EU+gxh?=
 =?iso-8859-1?Q?2HrsBbYpElpa+Ret+7aQj/VsH+YdwkNThgFW+FZ5n5nw5xuy3OP8fJBpTF?=
 =?iso-8859-1?Q?2DjdlD/6Lhk/7O6CdwtiPorkLcPu1tco4mH1pXKhdwlYzOCDoJZYhoUwUX?=
 =?iso-8859-1?Q?O792RKfyIfb6xFCqAsFgz55g9Ln5ZUqm70yP8QO18kpgL3/FDTqGYwWFs8?=
 =?iso-8859-1?Q?vU/h0DET8KMHCwGr9Mcale4eJE0WCDrPEB0PBWw/Ut97gwfDqOEwk6KQ9T?=
 =?iso-8859-1?Q?eSntnlcft41puGHq/lP9PuU9HWxKj4DpuHmdwoXdLD3xFmf7Zy5qKBRmFp?=
 =?iso-8859-1?Q?3E6T1IL/uqBdRzGyV6OmFUxYTpTAbBGb6VR79sag/BHMNlRTwdnJQUIYbC?=
 =?iso-8859-1?Q?aTTRUuGf4uVHKHB/fDS59DRiYC2xLiqSVakiABF6ETnRjZVXMp0kqVU1jL?=
 =?iso-8859-1?Q?Uu3db0AhHAMXRjqlh7zH7pAD9Zgh7puQxgD6q4R7M0r6ce6z0O+IhclkD3?=
 =?iso-8859-1?Q?3odvqCNGXBT0qsZMAcCIo6iL6kPPaHDJTxFayQMmXB12bGW/lQ6l3+dogg?=
 =?iso-8859-1?Q?zHnBYTtYJJ1aXjoDQUYUcO45uvOCoU+43iEMRyMCFuldQtD9RWwlJYgft5?=
 =?iso-8859-1?Q?aFAPD8NpRfT6EUnojIPakMA0piz7Hj9LNw5Pk0x2PqTqCvX1SldqNSASFM?=
 =?iso-8859-1?Q?O06iR4ysnhrh7x+KJBJzOHPllC526fJW8+ZOkLCYa1Ks2fbYNEGiuqE8LD?=
 =?iso-8859-1?Q?Qkg8uIPXbHiF5tVnnSL1o1oaWNC/t1FIhJ0+an0FIEMEu0c4f6itVjBPhS?=
 =?iso-8859-1?Q?uJ4ZC/ecQWJk6TeX7WN+fCTsKRnHe1A7+dsXBfteEYTRO0dOXJkrmiNlWx?=
 =?iso-8859-1?Q?mj4d55OHWKh1jptPAA4A460ghtFsy3JxKIzOUj2Tj8OH2J2lrr15IprH4Z?=
 =?iso-8859-1?Q?OfDcI0Xb9KuODVPHl3BHvmJfWrROyNsHOG5VEZsy5xavs6XVZxxaVRSCdK?=
 =?iso-8859-1?Q?OkIrF9HUYl1Bg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5111.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc35941-6929-452e-7a3c-08da8ad4e195
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 22:13:34.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1KoUbSwgKjfvoHlmqwN3ogrZGreL89IXLta6jg+Jf4dLCC9qa7V9jc1bZXemIwiPBzu5KeBJ8D7aNYjYRMPMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5991
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I am now looking at what is going on with a sniffer.=A0 For some reason in =
5.10, the AuthReq always comes from the slave (BlueZ is the master, GATT cl=
ient):=0A=
=0A=
5.10 kernel which fails, leaving out empty PDU, L2CAP Fragments, etc.  This=
 sequence is reproducible.=0A=
=0A=
Sent slave CONNECT_IND=0A=
Rcvd Security Request: AuthReq: Bonding, SecureConnection=0A=
Sent Pairing Failed: Pairing not Supported=0A=
Sent Pairing Failed: Pairing not Supported=0A=
Rcvd Exchange MTU Response ...=0A=
Sent Pairing Request: AuthReq: No Bonding, SecureConnection | Initiator Key=
(s): <none> | Responder key(s) IRK=0A=
Sent Control Opcode LL_LENGTH_RSP=0A=
Rcvd Pairing Response: AuthReq: No Bonding, SecureConnection | Initiator Ke=
y(s): <none> | Responder key(s) =0A=
Sent Pairing Public Key=0A=
Sent Read By Type Request, Sever Supported Features, Handles: ...=0A=
Recvd Pairing Public Key=0A=
Rcvd Pairing Confirm=0A=
Rcvd Error Response - Attribute Not Found, Handle: 0x0001 (Unknown)=0A=
Sent Pairing Random=0A=
Sent Read by Group Type Request, Gatt ...=0A=
Rcvd Pairing Random=0A=
Send Pairing Failed: Numeric Comparison Failed=0A=
=0A=
The 5.4 kernel always works, but BlueZ/Linux sends the first AuthReq:=0A=
=0A=
Sent Slave CONNECT_IND=0A=
Sent Pairing Request: AuthReq: No Bonding, SecureConnection | Initiator Key=
(s): <none> | Responder key(s) =0A=
Rcvd Pairing Response: AuthReq: No Bonding, SecureConnection | Initiator Ke=
y(s): <none> | Responder key(s)=0A=
Sent Read By Type Request, Sever Supported Features, Handles: ...=0A=
Rcvd Pairing Response: AuthReq: No Bonding, SecureConnection | Initiator Ke=
y(s): <none> | Responder =0A=
Sent Read by Group Type Request, Gatt ..=0A=
Rcvd Pairing Confirm=0A=
Rcvd Read by Group Type Response, Attribute ..=0A=
Sent Pairing Random=0A=
Sent Read by Group Type Request, Gatt ..=0A=
Rcvd Pairing Random=0A=
Sent Pairing DHKey Check=0A=
=0A=
Should the program be sending a Pair using the Device API?  Is there someth=
ing else to cause the public key exchange?  In the 5.4 case, the "Paired" p=
roperty is always being set by the Device API.=0A=
=0A=
