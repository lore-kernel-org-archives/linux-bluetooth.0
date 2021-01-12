Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC757C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB93E223C8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Jan 2021 12:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388013AbhALMhR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:37:17 -0500
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:31296
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387979AbhALMhQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jan 2021 07:37:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+URLEwrKvk31trGRD3styZKBZa4ieHM9j0F3abJLHx03Eyh/LBs6jAhK/bOmDBaFqeacrTs4fp1hbnQwX1p35KK+3fYe2OWc3ZycgvbOvsUN7XR3jFldhWlry4ig5fcbJ7g8hsthqkiijLdSeYidaOLIfndMu470+byyVwb3XhpiDbJc47kFNkv1nYzT2ooBInrSPyhJGr2HyWQGKVxrHd2UZmgu09qvS5oke4ni6zPNUmX7fh9zo8ndqnD/+D35KHEqPSHULs2eNPen4bCvZrmEH3sLIrEnx+VEfvsuVmKQoamLacuDSxLhcd36v0rKt+vz5cpqLyRXhhjUNpOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVShjDyMBSvck8+zqzg7nX8Q5qS0vOokJOyn4kZs6i4=;
 b=FYyBxkW9thyDtQDgoFSQO/8DlmwoO64q6wQpTebagT74lAHrZw1kN467XhNOcU2B2B0KzYHFUcO759/XMfKlUM2hq5KyjApSWdwj4DVJkH5fRKKNUjFKbHCaV5gxUZZHZqPISDZ0wZryBE1IjrVgG6JNrRpRlJw5kHTvaeSGtJfTA82RaJy+foWmZcGs6dtyYbLPsSis6xyCz1mnJSf/FYuzGdw9EnpS5+zIiOni5BDyAkCCYVPAtWg+7STvP4KZxxjARFo1bNDYOKDIDVOTEem767Awy+mpi8H1B/0M74F8ZJqpnfbXVIKjTYUC7ICJbugry/GVtOI971Ryd+1EoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVShjDyMBSvck8+zqzg7nX8Q5qS0vOokJOyn4kZs6i4=;
 b=FIe/Ewh1Z4Vyyh0JSQJBPcaCWe0ZywavjLenG/k+5sjdvfTn5W9ZR6l/vvX5XLe5esK8RLlSr8oTwIY9BjH8AbmjJqzXRpCa+UJ67T2BD0ZGpAENzB7dIMnPv3aevih8+IQjqbr5YTiHdSZqsKU8+fvK4HzVunO8XnXjbEH4ZBg=
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 (2603:10b6:910:45::21) by CY4PR1001MB2087.namprd10.prod.outlook.com
 (2603:10b6:910:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Tue, 12 Jan
 2021 12:36:23 +0000
Received: from CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7]) by CY4PR1001MB2389.namprd10.prod.outlook.com
 ([fe80::e83b:f5de:35:9fa7%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 12:36:23 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: "Always fallback to alt 1 for WBS" patch stuck in next
Thread-Topic: "Always fallback to alt 1 for WBS" patch stuck in next
Thread-Index: AQHW6N8BpH0r+KzrDk+El0CQviQHvA==
Date:   Tue, 12 Jan 2021 12:36:23 +0000
Message-ID: <CY4PR1001MB238904840D698F5F6D80FF6AF4AA0@CY4PR1001MB2389.namprd10.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [178.174.231.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 26d9c4ff-0b6b-49c2-e85c-08d8b6f6abee
x-ms-traffictypediagnostic: CY4PR1001MB2087:
x-microsoft-antispam-prvs: <CY4PR1001MB2087542E4DEAEC55399B8010F4AA0@CY4PR1001MB2087.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:546;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1IVzODSc0bWwGW+VipP7GzG79qbX3bT+kxcAGEjF5sgKuCY4OD6cJt0GiqSlGbaLZ6P1YM/GpqWJC+SL5zoxYgC+pfSoc05MPtxAbW9jR1abz7rgqX4NEyTaFHp9lgucWgVxlPF49qgoNtthmmiZcOz/8nA9aN+YR0VS2f8/N9zz0TSy0gCczk6OoxftXEQsOziphNlMjBy2Fx3T8AwXWQTGLSRcJam49U8+3YLMKH1eROoHOydllapcIPyiQ+mvT4hs+h7xI8eDACw87HYRGx+qBkiIJ9cgo/u20zH+5tjwcuE/zcUHIiLlDJ0do1MBz39cIj1UWfqav3mnjXdWOEsDurwMVKNvS/o3fsIWEgC/V41hpOE6dgc+S2FjWHc9EYXVc0YrWd4oVFfEJZWL8x4G5rhI2KCqEOi3UOPXyrdrQVqbAhbmGcaKexA5/GVaZKu5q0VYu1c1VmMGciqUjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39830400003)(366004)(376002)(396003)(4744005)(52536014)(5660300002)(966005)(33656002)(9686003)(86362001)(66476007)(66556008)(6916009)(55016002)(64756008)(8936002)(26005)(71200400001)(6506007)(66946007)(66446008)(2906002)(186003)(91956017)(76116006)(478600001)(316002)(7696005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?UeW6oLuLCLON/zU90VwFsYKnT18dsQ1YHPVRE0vNniQl5ebuqTu8lR5tB2?=
 =?iso-8859-1?Q?GdNhKj5h16n/wnzDomMrBuhSl++2PQ9AoSpJ4uXG3K2vP2r+y4BIowIpEY?=
 =?iso-8859-1?Q?d/vwdz/rJJ8SeV8kZ2rgVF3mKBqUKFBHqiyZH/lVGgTPQwg0T/CPs4T2vf?=
 =?iso-8859-1?Q?H+8Wg6RfFIcj+6cbPSKrwkt2VMr1aQi3XJ6J0MEekvuYAF5vFlZ0Fp0tYB?=
 =?iso-8859-1?Q?9MTrxm4EC7GibvBUIbjgc/s4EppbbBUfomxP2k7h2d2NMbx5jfba+PXzgX?=
 =?iso-8859-1?Q?E7YJJNwmH44cLjly/HPzucmjf94qqEZXB1bdRfZkvYIEeMgIKnJPUlFHX1?=
 =?iso-8859-1?Q?1dEDnoG5DjQ0YJeImdQAdRMTVE9TKns7LhJ/wH6VOn5gtdcIDOlrN3G0gY?=
 =?iso-8859-1?Q?AZUJTRVyJrF4lBG4gTAmDXisJUF7uWeLZFcVagjyxoThC9f0Y8W6fd5xwv?=
 =?iso-8859-1?Q?gh4zNDjmQoe/SNBUfvjsg0n61aCE/xTeZhKMG3LY+2NTjAlD3BsbZpXbnA?=
 =?iso-8859-1?Q?8mgSpSkkBdKOLC8ivDHZ0HglSILDnduAOgoesM7+InYdOQouV0Ox5T+9df?=
 =?iso-8859-1?Q?5LSEmVBJZbrqaLuHVjY2zpO+LWgoPWmiOWYLTydikS8ZtrNPMo04fWoZd2?=
 =?iso-8859-1?Q?HHndM+AgDwL4KpETz87jqix54AXG31HMwCcISv+d0YHK+dx2ipan+rUg/p?=
 =?iso-8859-1?Q?VvMtVZV35ZXg3kkfbwPFKk7oWEPMNjWvz6mPealS7kzqOdnXtdiKmP5l18?=
 =?iso-8859-1?Q?AaW3CibOFY7QdqP6auEXgSu0UCjwMpHJO/8jrKlDbzmJ9/uGsDnmiWBcsI?=
 =?iso-8859-1?Q?VXBWbzhtrJ9ZpveTzoMdOOPr5aSNrCew4olJzN3WVg1eQTZuh/4mi9kzDS?=
 =?iso-8859-1?Q?X/AqsFlARNPs60YdS7f0ZCt1+8Ws72nvnsxvVeQ6LvsL5o7N8oZgz0UD6W?=
 =?iso-8859-1?Q?559BXgRK31TXy77ZUkmUN0JNGluYk01tsQ/1cjGAmUa1IajmsPAEX+aHQE?=
 =?iso-8859-1?Q?ICjTPcQiTTiVw1ONY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d9c4ff-0b6b-49c2-e85c-08d8b6f6abee
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 12:36:23.4626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWOewCwhb0hU/GS/oZz6bJBC8NDUazQ/QhXmGX/MSvz8R6zhftIki6Qsrek29kFG2lzbdB0/LFX8zRV3B9ilEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2087
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch(Bluetooth: btusb: Always fallback to alt 1 for WBS) https://git.=
kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=
=3D517b693351a2d04f3af1fc0e506ac7e1346094de is stuck in blutooth next=A0 bu=
t the patch fixes a regression.=0A=
=0A=
Should it not go directly to Linus (and stable) ?=0A=
=0A=
=A0Jocke=
