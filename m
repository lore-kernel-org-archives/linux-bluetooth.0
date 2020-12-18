Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A1C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 13:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C0F23AC0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 13:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgLRNdW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 08:33:22 -0500
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77]:31201
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgLRNdW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 08:33:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+WBVvCzvJZsSUYRJNRFJpp9x+p7yfdPFbPkidWV0/MjMBY7+2nuinCVGTHXq3ijC9Rs0oW4WcDtDf1PK+64vyxAMdSvyidCcVB733wYrP24ZY9F0TkKEwwFWV7dxcTkn62HizMAjURuwjaXxfNQDCiwRvAhVnrGkVFKPjyhS6tGu8qtLw74kKMaM2niKG6+Ra/5XV8MIhjoxSnOJ24ryqhRbmYsQnFzgqVq+zaynhB0520DoLfPwfZ8uT3Bt99h06JDjIb0SNImD0Sl/0ns4GpD+m6806Mo3/iSKULLuvIMiJtR5tHORDxHia+641HmFmYOebDuQTJS3xq60Y6V8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmV847ncJgg3FD3Cf7Wl77Upp70Znjqtov+p1si9W3w=;
 b=T4vRSQxwbJCe/hN1WFwN/wRqX6sRy1dRxbfZkl6S9oKiJykLUSvPm+zqhjhwQE4mO57IJ5rWw0v4fG3CInu2h2jwA3n8GnNQT46GZEiW+JisIszi3UngCgJMp8u0xCZyHb1zC+X92u5CFOnsFUoxhLB02v8L7fnlleXdyc1m+6wNxpbgyR2rMQ63Cu4G0d11xy+ExMpYcK3oqsNXLYCspRxHOzmMefuKfXw1Zr3OlLBIACtFcTs6I6+7lUzQZDcpEKfgTrBHlf9w7w+e/zncfXUokQakgdsv4u6/jGgaIHeStqfYOIjMWcD+ikMnAr7+9NiletohTMgoNiG7iD9Tkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmV847ncJgg3FD3Cf7Wl77Upp70Znjqtov+p1si9W3w=;
 b=D/TntERZQXiAv6Y3pTbjI58gpVZ6Tj5Y2XnCLr8d6RhyxZ57CY/dzC90QPo4RwHIWOxOAkpmmDF3Di8SnOb4KLmE68v4vmt9GrQZZ1GIqXPylbAC8YKNSK8f4VpozuGX6DMBMbHGt59WBPqThImK+BobRLzK/nuqzdmh6PXpEvc=
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) by CY4PR10MB1319.namprd10.prod.outlook.com
 (2603:10b6:903:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Fri, 18 Dec
 2020 13:32:29 +0000
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7]) by CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7%7]) with mapi id 15.20.3654.024; Fri, 18 Dec 2020
 13:32:29 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Default to HW mSBC on capable controllers ?
Thread-Topic: Default to HW mSBC on capable controllers ?
Thread-Index: AQHW1UH1ZbjENPecx0GN2Ly2GQ87MQ==
Date:   Fri, 18 Dec 2020 13:32:29 +0000
Message-ID: <CY4PR1001MB2389075CC44E480B446535E5F4C30@CY4PR1001MB2389.namprd10.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [178.174.231.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38f6db69-10db-4343-1337-08d8a3595e18
x-ms-traffictypediagnostic: CY4PR10MB1319:
x-microsoft-antispam-prvs: <CY4PR10MB1319641891EA7CCE67BB990EF4C30@CY4PR10MB1319.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INNqDLA6DHxzOmfh+GPhz3IkUtUCyvPKnYIfhYPV2Y8lUxdLR3947VZhcB/l57sQa2DWj8QDRE0aaGOaRRR2f2YA4Dhuiv/+QhwBFVW7jrOJ0M59tPFoOg3vFQuU6XNh0ARoMuIefLBcPzyhatu3w+fQqth53ibSt6QgcOedkDHR5Yib9NJt5hwQV6xaV2VFL52K7QMQmy2ngt3J8XTP6d0BHyrL3Cs/gujS+CrECG1h9qGrRQ7R8Q9wHQW8yiYbzT8qQ+j6PSnMwxEsVTuSrMc5YUaNn4UEdNmv2JGIumjK7kt1iglzOTb2TsLVOyWv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(558084003)(55016002)(66476007)(86362001)(71200400001)(26005)(9686003)(64756008)(33656002)(2906002)(91956017)(52536014)(66446008)(186003)(66946007)(7696005)(8936002)(76116006)(66556008)(6916009)(6506007)(316002)(8676002)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?dEVENITyC/axeo2zVhdWAlksljhWbJIUOX4knQxt0LzTIUBcJTLAiIbBHG?=
 =?iso-8859-1?Q?s8BlxUlNgLzvY/789ivg1H6tWwfeLUIKGtVRI10ZTWEJls7oGuTknDqS3/?=
 =?iso-8859-1?Q?KahJmBNhPJmuuUW11/TmKAavrx9tsbkvcxHuTV9LUNZOIJ2cv+zl8rIt4u?=
 =?iso-8859-1?Q?LFseF6vVkeA0Xr/VKEk4RjaR7AOmbp88wj7H3dOiroHwr074oAT9EKgJ9l?=
 =?iso-8859-1?Q?SUxUtYjm8Al0KrMbS6iEUGlGUKQV5I2lc4lC5NPbNuTvq/CV1cCCMfwO4R?=
 =?iso-8859-1?Q?3GKMUz3W3ofUwVOQ1or1LxUM2TIFkOVk8fgxOT9prxBKsyPIf3cuX1VE9p?=
 =?iso-8859-1?Q?HjE+ERnvfwe7xYjFT9nGQpnR3JT5qfzbSCCvlK8egv1PyREQRW7QL+7y2P?=
 =?iso-8859-1?Q?V2lew0eTTI8rWtFrf/4kkZlwEUXB/8WlT0gcwc0054nZD+BGlOpSXLyzEd?=
 =?iso-8859-1?Q?pMz+5+DdPUbAjshpUpEA9sUrux7Jcme+4lFst7Mz6HeGASXLZgTT26+41e?=
 =?iso-8859-1?Q?5N/cQP9YJgmfwa/7cIiV+tWsdVLXKlAZXChGyWtMajsFQptKFFGCLBupPT?=
 =?iso-8859-1?Q?VMg/m/NiJygJ71II8oOHIjSKfkzaVq6bOMjkDTEAITRxnlGrfU4TiIZ2O2?=
 =?iso-8859-1?Q?W+VqVQhgju6IknUguS1RDw1DQuGEsppYNildTZSDu9OKpWBcmZSp3HKq4o?=
 =?iso-8859-1?Q?0hbMeoDLwqkvOHIX0pJEaPT4qz6tZI8T9loHw8JXPadfa7ahMii43w/qwM?=
 =?iso-8859-1?Q?35kGsD6oqtOxnO03BLpAvyvnv5WDIi2UvIUSeEvCklPaS1IcmGYuvMy/IQ?=
 =?iso-8859-1?Q?Gezh58PA5RydAXuzn0rZqQ4N/8vj297d6W5OPybZYPl/Q+kUefiR8J3i3K?=
 =?iso-8859-1?Q?haIk9ODh59GxaO3U3thdOWT+xrJkurrDNNEHHwC++HJJS6lVZp2OHIqRG8?=
 =?iso-8859-1?Q?4nDWbl7oHGvHCZGmCg6jYUg4YHO3VZDuMJGda4b6xYeSMxLvB4zubNet6v?=
 =?iso-8859-1?Q?JLi9UaEzvXePihIoo=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f6db69-10db-4343-1337-08d8a3595e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2020 13:32:29.7978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbFfB/JIm00J5gGK4ION9C5qCPRKpcNtQXgT/vu67XaB1SaRQWb7ut/Gy8CbDgLwkzHMLLxX0byQiZWTW/HWIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1319
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There seems to be quite a few USB controllers gaining the BTUSB_WIDEBAND_SP=
EECH which I guess means HW mSBC but currently there is no way to select th=
is mode.=0A=
Any idea if one could patch the kernel to default to HW mSBC and user apps =
like bluealsa/pulseaudio would just use it automatically?=
