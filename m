Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E1EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 15:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiFWPuz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbiFWPuy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 11:50:54 -0400
Received: from mail3.multitech.com (mail3.multitech.com [65.126.90.13])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 96A1F443DC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 08:50:51 -0700 (PDT)
Received: from mail3.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 16BDD826D3_2B48BDBB;
        Thu, 23 Jun 2022 15:50:51 +0000 (GMT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail3.multitech.com (Sophos Email Appliance) with ESMTPS id 5592782648_2B48BDAF;
        Thu, 23 Jun 2022 15:50:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFUpfrNIzfacgG1eQK/C17IWUNV5q42in7HcBBt9XzCQDiWA0j2ELAGz9vuuqBk5Fh1+2OZeTLxjlEtL3HaqEmwL+qvJCsIeuxII73yDwW15HqLpSi4pWxApCJTrV9DkU2IdstYEb3uGMsPaLYH9/SmwxjsAS2YZ5pu4sNg7aoGJXV8cq1yVrwPOXxaUqXW9Q8p4VKQ2xTxHCeQYbu9ldXBZnSdgUo+br9jOquUSPAGPoUaoZ/IdQ6JW5u53D0EthxmuBP/6dZc2quRuKVW0IGU1t0uaF0P7jrQ7k8HpXiiCofaok22/NW9r3MOnSTJH0uUj1v5xJUmZ0PJIj6faAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLiu00EL4VD2hFihuw8xlehIvM9buDVVpt5RLOidawI=;
 b=CqmBqUSozbo4UjFi3pyCboVl5Tc2hu9f5Xnb+NmZttCn9Bgh7iUqytYsDqgw8wNB4fJgqwJLMZUO8E00FO5Kr2eIbh/Fc4m/8ofrV+Sml5NKa36YcIlNtlHziEBKB7/LXdbqExCM4XhVWHlivNGsBEVGHyaipO4AlRtwy3ocY2zq/jntnUoxD4L6WTL7UAc84szBqirm5KSvJXIUtMxsFBw+RbvK45r7gc7Vczpi0MgUgvzROe6f+V89DaH0yg+1Dpk76mJwgOrLtjbhvES3tVJpNHc1xPYKhTt7JW/1stYD3sLYZYCU/Vm1omtCXGyj1seUtYM75rcC0//SB34raA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLiu00EL4VD2hFihuw8xlehIvM9buDVVpt5RLOidawI=;
 b=dmSKw+ngHQYmcrvau5AKQERQoXH6wUluIedydezN8S66zqv8vzMp8lFYgTXzVyIDLU/HbpsSe2KZb8UitNo211/TulQcR7vzBdZWrd/Sr/oQNxLE1jZQItkjja/NoPdtQtUUv9PUK5EWiLY+C4kcRxtf7U59wQ+bgv28fu9i7pk=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by DM6PR13MB2585.namprd13.prod.outlook.com (2603:10b6:5:143::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.10; Thu, 23 Jun
 2022 15:50:48 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%4]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 15:50:48 +0000
From:   John Klug <John.Klug@multitech.com>
To:     =?iso-8859-1?Q?S=F6nke_Huster?= <soenke.huster@eknoes.de>,
        Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Re: Unexplained calls to hci_conn_add_sysfs()
Thread-Topic: Unexplained calls to hci_conn_add_sysfs()
Thread-Index: AQHYhpAkLIryYMk5BUe8xs3VZ7TRca1ckZYAgACScUw=
Date:   Thu, 23 Jun 2022 15:50:47 +0000
Message-ID: <SJ0PR13MB575508F45B35B6ABA0DDDB1AFEB59@SJ0PR13MB5755.namprd13.prod.outlook.com>
References: <SJ0PR13MB5755C82B210AF2FFC96C2A1AFEB29@SJ0PR13MB5755.namprd13.prod.outlook.com>
 <ac96406e-9c99-510e-4e59-9d700d913446@eknoes.de>
In-Reply-To: <ac96406e-9c99-510e-4e59-9d700d913446@eknoes.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 83c12d63-04ff-a55f-ae9a-f03d18a4690c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d37bb01-e374-40b9-a6b0-08da553023e2
x-ms-traffictypediagnostic: DM6PR13MB2585:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8AweuJBjhcgP3P5Z/FFgzsLiUiKqWvDIbVKkIvYYhYe4e1ikqLBCqnkcnBQM+MQE2d5vErCf113WwJFf6kROSa+Bzw3VrLyQPSoaW7Xhe5p6qRKSVZh76OM4saEH5cWk3oROkXRa39Oz6plCMZruy3nGBVrF5Ik32lXz1Hb5yytoRXD1Tpd+o/7wwawuIPB+FrTj1wyE0W+/7U7tHVvw6iSBCBksMDWiRiHWhRQK9x9KKQib0eaG8VySu1TfwNE9w9MZs9N6V+EC/OkL0O8b/Fvyc1t6PdbCyO4X7i7cSYeEuoMKTWZFmriQsS9/ttdUY/L71oON1QSrPujZ9mlFGsOIbrvHh2Cl9bAsJ8csrVKpEQoVVW3qvb3a3WIJki+jCvS4NDKGUiX2+GJ9ojJ916pqm1jlpyHlhysJcQ1uziusdYYccHDIO5/xHQsGWvS+nZFoZG0o+fNT7TBwX+hinqoh5Hy49HI0YoqMnr9luUX27OHwk6K02cx1GoVPl3x51Qsv/elMJBlpi0V0O971liSBg1AQbMWIrolNdB56/4QFsuSNVOBAjvNYwMLKtQruvkQ3tA8dLeWcgRSJKl6HJoIwJCCyQjhPz98/W0zZj8hU660/g+3jSc/OZQf/4nx57y6Z/cEpmvEyc3/oflUgG53iBEnsk2hqXgEmMZWQPKio5iOtRF6sE7pO8fJp8OckxoQWWwkh+QBCSvtOhzCRxWBF/IPVKviGPow2Z+qDqUyfAj6mhA6DaohPCDgHtPVzg7Cucb/GZcW1cxwpAaCQajuDuNUrZ6QpY568YI5GEFRBLglCnE3kIk64GszHRuAax2gGm8/7sUAz3dgG7m5gZUrrzs5W00j6M/TOXYOWzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(396003)(346002)(136003)(366004)(376002)(279900001)(2906002)(38070700005)(33656002)(76116006)(66946007)(66574015)(66556008)(91956017)(64756008)(66476007)(186003)(316002)(38100700002)(110136005)(8676002)(5660300002)(478600001)(66446008)(122000001)(8936002)(52536014)(41300700001)(71200400001)(55016003)(6506007)(83380400001)(86362001)(966005)(7696005)(9686003)(26005)(53546011)(13032635005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oZoAsDz9VxQ0tYEvrZJCd2IQL0/+cEUYZ0+xKxQv6SbSUBusLJevCatAGy?=
 =?iso-8859-1?Q?Plu6lBFAgrN6B/4yRJApZLWHwVaUKk/lRpQ69eN3tpQcN8RePqOployhD6?=
 =?iso-8859-1?Q?wcneqThdjo4P1dgD+V2RjbZqJ2SDRT/8/cjouWpD1jmNB9Wm33AwT5pjZP?=
 =?iso-8859-1?Q?T5e+epkei/xIyqTEIm41aSmy3BtddBTKOqOMXUl/PUqu3g4fNfsadB+UOk?=
 =?iso-8859-1?Q?8DYJ5Nr3H84BBU5pKC3p3Sp12vDCZZuz/m+oD3laNgqGkxV4ELQLZvKIRb?=
 =?iso-8859-1?Q?7gVF/NoGOs76/ppVVu1g0L2swmHQ1fPr9HdxSWRCUNdupJRlD030PnqX4s?=
 =?iso-8859-1?Q?CxbL/C3dqtVh9yZCMaCuKwors7S7sqknf26q0xUIdJVMFK08Zy3i91NGDa?=
 =?iso-8859-1?Q?dUc39oewg0wz5SHcnGICko3g7N514wmwKYR9nuCQy/ncNbVKGbG2KJWiCd?=
 =?iso-8859-1?Q?tKDkOeiF3PhQdt7C7c8g/Enlh3wePfa0EIs3kwzX6escH81GJsfaOTYLUG?=
 =?iso-8859-1?Q?OdwDLvLUsAzZtXpI5MzSACGwTi7N8XrGm2ADzsv6JQGAsl3ILedG4il/t9?=
 =?iso-8859-1?Q?RZIfYgdbgB36/E0ly5N6ADGvNelflifKmzn8xDH3+DuIZlECXKgp2GSxu+?=
 =?iso-8859-1?Q?uzABODaVkmjHYW37nXwQlt4etGQsxudUu/+OHU3C1aeD2958mRWR5zW+Lk?=
 =?iso-8859-1?Q?pNVUVoc5o6ERmPlpFYgc3/mA3bmzHLA1Ijj4hGHtu51klj8OJBqqzMzFOH?=
 =?iso-8859-1?Q?kLkN+wjTiztEe2SeXbVJMY9gtHHgQVoRTHuqjDASOJFgdd89hAfvRuNEMH?=
 =?iso-8859-1?Q?DhVyCVS40F5H1s8XvpUJcwRGfIBXZ2hwpcm4TvcPbaGBgYrNNOqgtujB1t?=
 =?iso-8859-1?Q?s5/qS7rq/tJOqb9Qk+OnsJXSf5Q7Ec91w0uuWYd0Bhzq79awYXFdZf11J4?=
 =?iso-8859-1?Q?GbYEjzcj83H9c6OrHuL7gvMrGKzIJLR1+secxvI2SMLFzuE+vBoZhp7D+Q?=
 =?iso-8859-1?Q?fUs2Y7yzmBh/VKCXuTzy1Lon8OxiEreGGzm14bSOgEZg5by24ZRODeEFfL?=
 =?iso-8859-1?Q?OkxuFu0FUda/oWcnwF7aEXRg+6+cyobdOPKaWuI5pYSLC4NLzLxRcl7zQ+?=
 =?iso-8859-1?Q?4NjmjASyVyeibSkVH5PI+SPtKfzluWmIFHrPm+/9Fq+m+7SnsoG8o3AsnU?=
 =?iso-8859-1?Q?2R1NRwrXUWVMKf2tnNfl3kAg1D8m5asnNr8CnekAa+mX820KrwAw5iGy6a?=
 =?iso-8859-1?Q?l2t7H39zlIjQ4GjxrNxIS1ArTefRHV+m4hEazKz7PEuY+AJO92+r4PI1zL?=
 =?iso-8859-1?Q?/5rWDZpwbrJIxQXpgQVC2Fn2woz8Yh2roDWmJyoXHa+mpSshlZ1BiDn2Oz?=
 =?iso-8859-1?Q?6mDL702NPGFWuyQiuKTqlB1W+JMjLfD6YIN+IiItm0JNmIEj/hVNJlslyH?=
 =?iso-8859-1?Q?VMmquQQVjhD2qXZKf1cyBVPwbLgMQOUvFPMx3A4znYVHC19YtECv85rmhm?=
 =?iso-8859-1?Q?AxPqJmI1GUHTPzLaRxm9m8U/faWktlnC/tdbYe/WWf1wqHvi2davTavHlx?=
 =?iso-8859-1?Q?DpRrY5gtOEvkJpr3sE1w3pSt4PzrdGh65FEcyTR+xWv5PXVILb75EbDHqa?=
 =?iso-8859-1?Q?zB2WvYvnkpQHg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d37bb01-e374-40b9-a6b0-08da553023e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 15:50:47.4569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oRdMnCokRffYdE3quDN4zNttpmydB7F3bLA7xbx905a+wnwOcqA4snLLiLwxADvOk8O1Ed9RZJKyof+My/lJeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2585
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Unfortunately this fix is now out of date.=0A=
=0A=
I will fix it, but hci_event.c has apparently changed.=0A=
=0A=
BT_DBG replaced bt_dev_dbg=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net=
/bluetooth/hci_event.c?h=3Dv5.4#n2474=0A=
=0A=
and=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net=
/bluetooth/hci_event.c?h=3Dv5.4#n4684=0A=
=0A=
=0A=
From: S=F6nke Huster <soenke.huster@eknoes.de>=0A=
Sent: Thursday, June 23, 2022 2:03 AM=0A=
To: John Klug <John.Klug@multitech.com>; Linux-Bluetooth MailingList <linux=
-bluetooth@vger.kernel.org>=0A=
Subject: Re: Unexplained calls to hci_conn_add_sysfs() =0A=
=A0=0A=
Hi John,=0A=
=0A=
On 23.06.22 01:39, John Klug wrote:=0A=
> Kernel v5.4.199, Bluez 5.64.=0A=
> =0A=
> We are using btattach.=A0 We are not seeing btattach going away, nor are =
we seeing a new one added (we would not expect this to happen).=0A=
> =0A=
> But we are seeing periodic messages:=0A=
> =0A=
> Jun 22 18:26:14 ecc8 user.err kernel: debugfs: Directory '0' with parent =
'hci0' already present!=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: sysfs: cannot create duplicate fil=
ename '/devices/platform/ahb/700000.ehci/usb1/1-2/1-2.4/1-2.4:1.0/tty/ttyAC=
M0/hci0/hci0:0'=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: CPU: 0 PID: 67 Comm: kworker/u3:0 =
Tainted: G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 O=A0=A0=A0=A0=A0 5.4.199 #1 =0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: Hardware name: Atmel AT91SAM9=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: Workqueue: hci0 hci_rx_work [bluet=
ooth]=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c000f9e4>] (unwind_backtrace) fr=
om [<c000d3a0>] (show_stack+0x10/0x14)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c000d3a0>] (show_stack) from [<c=
014132c>] (sysfs_warn_dup+0x4c/0x60)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c014132c>] (sysfs_warn_dup) from=
 [<c0141430>] (sysfs_create_dir_ns+0xb4/0xc4)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c0141430>] (sysfs_create_dir_ns)=
 from [<c058d790>] (kobject_add_internal+0x148/0x338)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c058d790>] (kobject_add_internal=
) from [<c058d9fc>] (kobject_add+0x7c/0x8c)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c058d9fc>] (kobject_add) from [<=
c0334630>] (device_add+0x140/0x590)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c0334630>] (device_add) from [<b=
f103178>] (hci_conn_add_sysfs+0x50/0xb0 [bluetooth])=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf103178>] (hci_conn_add_sysfs [=
bluetooth]) from [<bf0edf94>] (le_conn_complete_evt+0x33c/0x3fc [bluetooth]=
)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0edf94>] (le_conn_complete_evt=
 [bluetooth]) from [<bf0f158c>] (hci_le_meta_evt+0x118/0xb10 [bluetooth])=
=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0f158c>] (hci_le_meta_evt [blu=
etooth]) from [<bf0f41b0>] (hci_event_packet+0x222c/0x2854 [bluetooth])=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0f41b0>] (hci_event_packet [bl=
uetooth]) from [<bf0e4d94>] (hci_rx_work+0x1bc/0x348 [bluetooth])=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0e4d94>] (hci_rx_work [bluetoo=
th]) from [<c002c024>] (process_one_work+0x180/0x220)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c002c024>] (process_one_work) fr=
om [<c002ca58>] (worker_thread+0x27c/0x348)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c002ca58>] (worker_thread) from =
[<c0031acc>] (kthread+0x130/0x13c)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: [<c0031acc>] (kthread) from [<c000=
90e0>] (ret_from_fork+0x14/0x34)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: Exception stack(0xc6075fb0 to 0xc6=
075ff8)=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: 5fa0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000 00000000 00000000 0000=
0000=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: 5fc0: 00000000 00000000 00000000 0=
0000000 00000000 00000000 00000000 00000000=0A=
> Jun 22 18:26:14 ecc8 user.warn kernel: 5fe0: 00000000 00000000 00000000 0=
0000000 00000013 00000000=0A=
> =0A=
> Is this to be expected?=A0 If not, how can I track this one down?=0A=
=0A=
I submitted a patch to fix this (?) and similar issues some months ago, can=
 you check whether applying it helps?=0A=
It seems it is currently not in the stable 5.4 release.=0A=
http://mail2.multitech.com:32224/?dmVyPTEuMDAxJiZmMmQ5YmI5ODM2ODk2YWY5Zj02M=
kI0MTA1MV8yMDQ2OV8xNDU2N18xJiZjZDBiZjA2NzZiMGQ5Mzc9MjMzMyYmdXJsPWh0dHBzJTNB=
JTJGJTJGZ2l0JTJFa2VybmVsJTJFb3JnJTJGcHViJTJGc2NtJTJGbGludXglMkZrZXJuZWwlMkZ=
naXQlMkZ0b3J2YWxkcyUyRmxpbnV4JTJFZ2l0JTJGY29tbWl0JTJGJTNGaWQlM0RkNWViYWE3Yz=
VmNmY2ODg5NTllOGQ0MDg0MGIyMjQ5ZWRlNjNiOGVk=
