Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1949C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 23:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiFVXjj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiFVXji (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 19:39:38 -0400
Received: from mail2.multitech.com (mail2.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C017E2A73D
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 16:39:36 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 4E189586C1E_2B3A838B
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 23:39:36 +0000 (GMT)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id A1273586C0A_2B3A837F
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 23:39:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arZSp5idKlxVHK2eBsbNmDOjGA6dEC/dNK2EGWdkFpToazFqWBhV1CZTZapiSm04YTDSzQmHnFDogWRUQyiCFkCV2g1bAq2/IfxhT4nsg7rAylJ4c6SWuyqry9Zb0fcYNZsAHUpwgjfddRQXTRSlZezz9+oeAX9yZ2h16BoaKjxLIiU1purYeF8gj32VdoJbkEDJpluC12AOJd9U2eigjlZLiRHGTpZmGN2Qo6i52sEzCU6A1nu2/AUVckOfMZohUtecn209xRPcZ/VsVuVNeHk4Zqq7Gdwe30D49qmeYAVSngcjZ27EH6nYa8t2uUZQ6+RZ0tpuk1DOubQpXVPEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmrxU5HRuoeloiRl74b7fnq8DnL32K+I0aXGfaND0oY=;
 b=k/XI49XlHdZtkzaYVefsuCNjYHDzy7gv0BYa34MB0kpD24KuiaQMGNL0gNvkmkdJzZi+NIMru+VnidEHu27aoPAZQ0v9ZbqcMc0n84UZbV5aGWApnX7y3z2kIT++jx63FolTm3OOmgWX/jP9ec9TxPRyG9wznOVvLThPh3vqLV1/5tANM8e4d7vVn4HJ5yDx3jqfh4M7LxCJHWOwdnfn5HnSETJDcdmpHa5zciZqpW29JwSVnsYElP/qIf4cR/z9Tr9jIaHOpt4GL6hRGUAFGEV6v0tXbdhapR9nmr1aXMbpV4mrFZ7KdaFU0PVNf8LlI9dPTJc2aDXyVMNGyg4oSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmrxU5HRuoeloiRl74b7fnq8DnL32K+I0aXGfaND0oY=;
 b=Vpd/JxKVc5nEd63daUMWs3CrrDvRVal6BRNgiOPnnwNzYxJcXKd6inbFE+Utq8CeyVpTXPDm0q2ki3xO+mVNf2wzLKPmF+VfK6YvYIHXy0yJ62NSit3C0u/eKffqKMmJkGWDIj2xpBLUM8LKVY+Xe1Z8sgmHEGLhDDu9qWVRYkM=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BYAPR13MB2488.namprd13.prod.outlook.com (2603:10b6:a02:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.13; Wed, 22 Jun
 2022 23:39:33 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%4]) with mapi id 15.20.5373.009; Wed, 22 Jun 2022
 23:39:26 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: Unexplained calls to hci_conn_add_sysfs()
Thread-Topic: Unexplained calls to hci_conn_add_sysfs()
Thread-Index: AQHYhpAkLIryYMk5BUe8xs3VZ7TRcQ==
Date:   Wed, 22 Jun 2022 23:39:26 +0000
Message-ID: <SJ0PR13MB5755C82B210AF2FFC96C2A1AFEB29@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 73384b57-502c-edcd-1510-b5c8fbf4a95c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80ed4a8e-b6f3-4a78-7258-08da54a871d1
x-ms-traffictypediagnostic: BYAPR13MB2488:EE_
x-microsoft-antispam-prvs: <BYAPR13MB2488EB0B339B9541A4CF3515FEB29@BYAPR13MB2488.namprd13.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ox31M+bxg4xWcAnDk/NCE++k4/1vrzwlf6yedyPXzhHvHWsLzna+oTTaK76k9mm+7o3hp+Z2HczkbHy1o+uwIlZ3JHgRgWG6A3Zociqiyf010USrsPEHGBM6pjqzt7iZBj6mpq29oM4aEeCcDVVWpLdOD7FojHwILfAJLYQfazqs7m1Jx0yQkdNYQMwM2OPGMNNOpUxCcvYmp81081rbF1xIiMYAag7kixJkVZ1wI3SCkj3X4AXkb5c6Hm11cqFdzn7wG6PcOse1VM8G2/ZJfiW0zDC7N3ghaAGjn537l00kLRuazLnfXjz9lzHdnjTmnZeAM+Jbj3v0vX7Lyi9UKzt27j5Y04CyBMIboTuezlxakCK1IQVR9XvdxxQQ/PyjFq+NiT6nk135poPhegYtKTwSQwMP9zMVTXSoLw/7pNa3UkrnsinF2auE5JT/cyU16U4QsclSyttwKm7dpTE1ox0aD9iTLUlmBhUT66sezVT37fyGKvUTUplqmxJDPmDrkJX3gKHrKXX751eosOJU7trPDbZEgRpY027SC8yl/qly//6XvJSNgC2XgkY0oBYvElLulN8F9bXzRjb1y3iFezgxh93ZeW8Co5ix5y8wFhQ69b8B2e8aNi7ZZXa/5frXhfdKMa7CmUmpwm/uZkCHrHXTnP8lUAp1pO+OCjNtcEmvainHYMnYx8I05XAjME+fa9bHC3THbsJuDxKYInxq9UiU/GZtl6Ot0O8MwZ6qXMksj+hDkezcSU20uZtlAA80F5UQCDAu4+Dg9YNzCcFLPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(366004)(346002)(39840400004)(33656002)(55016003)(52536014)(122000001)(5660300002)(76116006)(66946007)(71200400001)(8936002)(64756008)(8676002)(66476007)(91956017)(66446008)(66556008)(2906002)(316002)(6916009)(478600001)(38070700005)(6506007)(41300700001)(7696005)(9686003)(186003)(26005)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oa4/6GKbGkME7hnR5Zt+GhZ2/BPpwLhBTZv5k6qPqA1OHNk+mpZEXssZuQ?=
 =?iso-8859-1?Q?4ekalXyGaTWotoserdsALAabV1rF6LSm4AJe3HqDszEBTbSCxuvRKTsab5?=
 =?iso-8859-1?Q?iyylU3NbwwB3aTgURdl568MRQENeu5krf4nlgZlquUYtuEHxIUfi4cYqj5?=
 =?iso-8859-1?Q?z8HRRgccusanRYe4i887k+QQQadvUbZP3Rl5ZDK3VFS3f1ugAv2e901+C1?=
 =?iso-8859-1?Q?IP0ubEuVoaNUwFiMKxQmAAz4OWaRIsoWwS9bSqp+j34bNTUTd+D5eZApxj?=
 =?iso-8859-1?Q?Vp4rT/F+B1/DpRm5WLCgMB75bvTEcZ06xm5KKaCXvZYkGGuYxs8hx7/6oT?=
 =?iso-8859-1?Q?USTLB7iHKFiw7Ml01S3kCqlSRUUcGYpt6FNkwRt0L7FWZuF2B1DV9W+RkJ?=
 =?iso-8859-1?Q?kbMZTfaubLxxUzP1B36lJr1Aj7Puch0x0BkdpDee0t4Ae6zHJxLkcPEClK?=
 =?iso-8859-1?Q?6qQi60n0WWafa3pVnGQ4Tiakpwyxqi8zVE01cpgz3P8OMdM6Zz7/YzUHj0?=
 =?iso-8859-1?Q?I5fez2vJB6JDlFWtF1a/lYUlDe0usNe16vYnHn4YOjTBmQVrlRtv4acWuu?=
 =?iso-8859-1?Q?MbWs1k6eutkfVMz1xYo0tAQsMn3Rs1V0QaMGFe8dirBq/uWXtzIIdR4bYp?=
 =?iso-8859-1?Q?+ahnqixZDE8lPyynVgLxeMTuivMjnlnNoqKMtQ4qF0zC1Ke0s2MdDBCB6J?=
 =?iso-8859-1?Q?896hCWYcvkH7oIsweJNSfnvKCbuNM9Fel1HMInlOHhSFbi+Jf7NFNagZpY?=
 =?iso-8859-1?Q?0WksKh7mpY4UwV+mZUi46i27Man/DqP/mqk7P/6bmurOFcKhX3J3JwHXmq?=
 =?iso-8859-1?Q?/F/HrlRu5LR1bw6vOliseOx/6k18W7Bx+apI13bFzmqDZZaTJZ2jKa2xWB?=
 =?iso-8859-1?Q?MK27/TyoN6tntH0dWysTd/ujAZ4bXpCWEmBZA7w5dB0Oql02kgOaHq0UO5?=
 =?iso-8859-1?Q?ipf0nxIBaxvpvAg4n6v0UOJjYGnsBlkB/e7XCRc9hznL104hRzJ46WngKR?=
 =?iso-8859-1?Q?gCJy8GrlVVOWmX5jlNTm/NkqzyEz2LwzBamcEXpg2Fh7jltwI8mmTaH00M?=
 =?iso-8859-1?Q?IDB8rz+LGI4kyrNAlErALrcVv7/YvsVrqsLpf6pyRrxUe96oLpc4vj/sBB?=
 =?iso-8859-1?Q?G5RFB2T0H8Cmmn4hUEhiSgC2RlpdtvMznTE6lN+I0cgcFdQwo3HBN5Y1O/?=
 =?iso-8859-1?Q?zalnRMQEcHyCoiQ8zMtvkYf6diFEynNtbvN4377VaodRzXXNln8OChTX/l?=
 =?iso-8859-1?Q?4fgMITT/hL3OhNqPUZvS4vkJwDnwv+5hPhNkBUfpJK3vthVhrpL9+KfEpU?=
 =?iso-8859-1?Q?Xxk47et8z62izbmMsmg7gg8qG8XbVNBzN9G/TeoWMlKOYcmiP3LKjxwC7S?=
 =?iso-8859-1?Q?nXTllvMUSXhHPpC4WGwGka9wR8KlYZkiDmMG9a1pteDwFSQsCXbp8kg1Op?=
 =?iso-8859-1?Q?+3JhwYGoucV7jPx3B4X4IBVaFOq/6WaC/hTWRaH8T70O8DRoiJS5s8P/wI?=
 =?iso-8859-1?Q?QrcpNzOfLHCfr8K6tlUn/izvvHFnp6dGzTJ0cT+kQss/Dl88cMBRRVtgYp?=
 =?iso-8859-1?Q?j3sbTTIXqY6VCZb9bQkn6/u3PzO84KvGGz0YzahWTvuJvDil+FeY9vX3sK?=
 =?iso-8859-1?Q?i0j/aoY6ZN92Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ed4a8e-b6f3-4a78-7258-08da54a871d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 23:39:26.6668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nkJoX93V1SBJuS5QeMLDkMCftLiWrQ9rYwCQVBzz4G51yjudn5hMBBENLg938kPlnh7d8cx9c+QvJTQXWfDNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2488
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Kernel v5.4.199, Bluez 5.64.=0A=
=0A=
We are using btattach.=A0 We are not seeing btattach going away, nor are we=
 seeing a new one added (we would not expect this to happen).=0A=
=0A=
But we are seeing periodic messages:=0A=
=0A=
Jun 22 18:26:14 ecc8 user.err kernel: debugfs: Directory '0' with parent 'h=
ci0' already present!=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: sysfs: cannot create duplicate filen=
ame '/devices/platform/ahb/700000.ehci/usb1/1-2/1-2.4/1-2.4:1.0/tty/ttyACM0=
/hci0/hci0:0'=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: CPU: 0 PID: 67 Comm: kworker/u3:0 Ta=
inted: G           O      5.4.199 #1 =0A=
Jun 22 18:26:14 ecc8 user.warn kernel: Hardware name: Atmel AT91SAM9=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: Workqueue: hci0 hci_rx_work [bluetoo=
th]=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c000f9e4>] (unwind_backtrace) from=
 [<c000d3a0>] (show_stack+0x10/0x14)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c000d3a0>] (show_stack) from [<c01=
4132c>] (sysfs_warn_dup+0x4c/0x60)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c014132c>] (sysfs_warn_dup) from [=
<c0141430>] (sysfs_create_dir_ns+0xb4/0xc4)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c0141430>] (sysfs_create_dir_ns) f=
rom [<c058d790>] (kobject_add_internal+0x148/0x338)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c058d790>] (kobject_add_internal) =
from [<c058d9fc>] (kobject_add+0x7c/0x8c)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c058d9fc>] (kobject_add) from [<c0=
334630>] (device_add+0x140/0x590)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c0334630>] (device_add) from [<bf1=
03178>] (hci_conn_add_sysfs+0x50/0xb0 [bluetooth])=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<bf103178>] (hci_conn_add_sysfs [bl=
uetooth]) from [<bf0edf94>] (le_conn_complete_evt+0x33c/0x3fc [bluetooth])=
=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0edf94>] (le_conn_complete_evt [=
bluetooth]) from [<bf0f158c>] (hci_le_meta_evt+0x118/0xb10 [bluetooth])=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0f158c>] (hci_le_meta_evt [bluet=
ooth]) from [<bf0f41b0>] (hci_event_packet+0x222c/0x2854 [bluetooth])=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0f41b0>] (hci_event_packet [blue=
tooth]) from [<bf0e4d94>] (hci_rx_work+0x1bc/0x348 [bluetooth])=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<bf0e4d94>] (hci_rx_work [bluetooth=
]) from [<c002c024>] (process_one_work+0x180/0x220)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c002c024>] (process_one_work) from=
 [<c002ca58>] (worker_thread+0x27c/0x348)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c002ca58>] (worker_thread) from [<=
c0031acc>] (kthread+0x130/0x13c)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: [<c0031acc>] (kthread) from [<c00090=
e0>] (ret_from_fork+0x14/0x34)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: Exception stack(0xc6075fb0 to 0xc607=
5ff8)=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: 5fa0: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 00000000 00000000 00000000 0000=
0000=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: 5fc0: 00000000 00000000 00000000 000=
00000 00000000 00000000 00000000 00000000=0A=
Jun 22 18:26:14 ecc8 user.warn kernel: 5fe0: 00000000 00000000 00000000 000=
00000 00000013 00000000=0A=
=0A=
Is this to be expected?=A0 If not, how can I track this one down?=0A=
