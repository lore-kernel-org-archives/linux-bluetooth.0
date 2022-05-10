Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8F5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 May 2022 09:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbiEJJvQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 May 2022 05:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbiEJJvN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 May 2022 05:51:13 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150087.outbound.protection.outlook.com [40.107.15.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700392370D7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 May 2022 02:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OeaWsY6NMah7I58NXxYqQe7l0sP8Ew5YZ7CprWqfORQ5TcS7sTdXwv+YzO0lhJoitSWp6MgkxaETZQgqMtYqHoxD1fJ9ivlVAVuWZYAT1IvXl8iOif6/ZDqtU6hFyC45DcbgTXZBCwAH3F84f3FaP+FSAQ2Zfdrvp946M/Rr8HSjCS+GTowqT8fG/AhpgLrDyZ929BzDiTtVrfTml9GlPNs/m3lcBXl02XyuJ0St6it/N/Djeyp2miisYbe+3C74raAMykRpO8/j/NVdsrWqHz3FV362klUXBJ6hsMURm70Q8b4N9zLWP8beBZjJiRKaoCMCTKfRgBY2wbt5gJl7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHLFy5nTP2LOSKHg/n5RLqpn6jw8ToMf1Ec36DPH0ss=;
 b=V1vzWpO+kxYarVnl8DH/Tys/n71cq68/oy8hTi2PF64dmhYKXz+Vu3u8PWmzAQeHPgxJVtdcXuBvk02y5fOczy+6qjUx+O/w8nGJB8/XJSFI6xFzVcG8rIlFwtrfksBmqEW+SMvpl9rYmSzJagKLh50d9owa1nUqWQC47U1c1oB99QotFqADYxVaA0oKrKm0ftjmegRPaav0BAf9b78/vLDVS5fPulpia+0bawny828dPbhLZnROoh7oCVciJ60p+0Cr9UWtfDIN4dVXtGhy5R+BGnYiBBqVc5vRZcD9c8itboH315I8Mh5ImcDRLHupATEgZvdeQAyJaFU8AJVSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHLFy5nTP2LOSKHg/n5RLqpn6jw8ToMf1Ec36DPH0ss=;
 b=rlz4UMzfPZCS8dxmnACLkNIOStJ8kKXxOkcdARWmPhXA+V36253WkNhIvEIq9JbZ2jAejar97Xf/O3L/7dVgAJKcN/KXtUkNjIcMAyFOMdqTOg4bhFHypmL+gjkfdID8JWED0P3Nvjaxi29f41dkFiE2iEDFfDe3ymN9w86peek=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 09:47:14 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::881e:9703:7584:80d5]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::881e:9703:7584:80d5%6]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 09:47:14 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: observe the kernel panic (use-after-free in hci_le_conn_failed) when
 connect the BLE device failed on L5.17.0-rc8 
Thread-Topic: observe the kernel panic (use-after-free in hci_le_conn_failed)
 when connect the BLE device failed on L5.17.0-rc8 
Thread-Index: AdhkUtoL7lAi/117QumjYlgpO3ds9A==
Date:   Tue, 10 May 2022 09:47:13 +0000
Message-ID: <AS8PR04MB8404AB7E63BB4533852BB4C992C99@AS8PR04MB8404.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3eed8089-6a5f-48db-c66b-08da326a0fdb
x-ms-traffictypediagnostic: DU2PR04MB8549:EE_
x-microsoft-antispam-prvs: <DU2PR04MB854996A51A69220B27DA23C892C99@DU2PR04MB8549.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vAsh6hoRwUngMDW40LToQE7UHIG+Kf5ju8CN++JbLJpZkVcVI6EWINHXfK0SKkIRekkxse4/ap02JNShfb5sw+fvmbX6xr2f2bFVcs5L5UqAZSKntxV1MTkCALkFfYdLGYipvgbRQlL9JGUZz/e07ntTQ6vnhTijab6cFNEqEHIohNJhM0V8hnR0M0owGplkx3NLwricwD9CF5lBXPJeTCve1St2lxT0RGtLTyC7SWhZALev+XicE0C03InuOJByGOWmqshjO+uLwfOG4pteyFbJf0sALHAPO4YXMqt66Q3G4Bak0AOVPBOyCC0ZdDf+cvkPzjtLRLZWMKFlVofjw/nyFZHuynNUE4Swpe4tIyTMgj0AyAYWvkJR1RVW60Gs7QhvNpnNOOKoU936U4Se1KqPs3F7yOpGy/Y3YFy4By7T2ix4Ik3yafKEd+vWxLCAWSr0IytRs2GEbRyKvNmVHXIMTxwxTAyGejeESFCv+mSaVUsu94wccU5AugaJZ+owLkA+Z2U9Sxwc/8/5qivtgDekSXoGfIwLtp50rb16vBFPoP/0iFlaClRLyGo+IP/kazig81ZMIVp6n0zkIWlQIv7yY1qx4+TVG7/mMZ2kR6jqP7QeJ8hZTMFEY1fD1k4y2kSMT0n3D6Shx1i9LchsTs2ENJV6CDP4+bmAP30T33A8wTWQJelhp9XRpcSjF+gqCK1V9ERCdjlsC3EJoP48DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(2906002)(44832011)(52536014)(8936002)(55016003)(38070700005)(38100700002)(5660300002)(83380400001)(508600001)(4326008)(45080400002)(33656002)(186003)(66946007)(76116006)(66446008)(64756008)(66476007)(66556008)(8676002)(316002)(54906003)(6916009)(7696005)(6506007)(9686003)(26005)(4743002)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6oqNz+vicPu0c2+eeTsi81HzTo4GVF6hy7tQvsb3bA3WYWGLkc5B6GfExZEv?=
 =?us-ascii?Q?0hLkRmIc+ETBo+6grtZpZieZC1zlvWCpnZUaqsS4OE9QPH4Bbb+LfzhMYPXK?=
 =?us-ascii?Q?2f86cwiAaSmwZe7w9gOVfmvM1So/xGACmRl+ISxVb/Nv/JhhChbVkkVy2FA1?=
 =?us-ascii?Q?CoE0qm9x84U4h+s/6fTzeN7hHAH2ie2rBEK0pqXYCwzIWF20xTY7KyGwnaK3?=
 =?us-ascii?Q?oBGILHyxhrTDJkHn4DqI+Ox+0XzEsJObvH2SQPfvMQN1pbypPKg3gwupcsVr?=
 =?us-ascii?Q?1WD7netAaWSk9oqkdssr1VHKqcn3PVRfHXnVDluKeDEa0KoVplTLfEE0ukue?=
 =?us-ascii?Q?rUVeA7l2Ho44AduGW1/WamxfU++p+vP0kiYiL9AGqQl0ixteS6BKmnVBhJDe?=
 =?us-ascii?Q?jxDKo5Duid/pUX/vbsw6FiQ0JSK3qR5rmR8C+TWdZfkjO+1px+AzNGeBihOu?=
 =?us-ascii?Q?PjBniYXSc8Fd+bZscYSjFJ0jPn0/NbfALSSgHLjNxWkwI/Xu0rhP1IxpeAdZ?=
 =?us-ascii?Q?J4Ljwzv1T0bBTbEcgWfMOBmk5LWOdxl9V984AGX+T32SNFlK53XFhauhojDR?=
 =?us-ascii?Q?c43C+TlxZ3F9SuiJl+kja7ThoBctrnEyRQLS0Nw5tqMmjeQpgZZ6z12Ab2uq?=
 =?us-ascii?Q?u2vrw6l4LtxNUBT5NZcCLDUGa9oalyqQJuO+KnA9sfBHLvXNwD2Ev6XzeoDJ?=
 =?us-ascii?Q?hOk9DE31Z0d9f3qTnpvstFXvicfWb6g4nzOUxu5tXlzVN9XUU/2bA6g6wcEu?=
 =?us-ascii?Q?8W6hDyYrIwzo/ml/OUtb/+b5v9sdTHfRTddmIlPA0OW958uiXK555YOXYrDb?=
 =?us-ascii?Q?gkkyTqf4F3iq745NvFldqTOAqdtdoTYdMdMMaWHp76VIoeobZ5y1PU6+cEh6?=
 =?us-ascii?Q?pJmRJ/SpJq/wKS2DYugtSLiEx31H3bSaO/u5G1xZsXArl36zQz4T7U2WZR5X?=
 =?us-ascii?Q?M9ejxV+PgrtfukZKEi3T936dtwg+gJyLUb6mVscBkUjAsNA47PMGglUMJX1v?=
 =?us-ascii?Q?KDH7NZArOgAqeb55f/Stt0w8FlmqfIE7CgLFUM3sO0tRSLTJTXnVGw4SbncM?=
 =?us-ascii?Q?kbHoKAsNEM9YXBiyHTlblIA9swoKFEvOdOdN6CaE1krp5rtegWQBiAZjlqE8?=
 =?us-ascii?Q?r8VPVCecCAwe2EfsDQPRWT2ICv61sV+CesoxKVLQeiSAELDvy10p0Rj/Omph?=
 =?us-ascii?Q?Wjx959yNUVbRG4ZUfvzhzyqznTR0r5BL0dUolheJXXuv9yuNUo4/CnCU0S7R?=
 =?us-ascii?Q?XnGjQxb+bnCJnmIwmaGU+jMUnb+hjnUjCkHDwzxzvE+3N94kS4SXaG0GKqgP?=
 =?us-ascii?Q?jefsgRnPFF84oBaidvzVho7+oV5AFq5M2VZqX6591Dsqwp/Yk8LSgogBgcqJ?=
 =?us-ascii?Q?/aCgkIkEVJg25sGcI8MsxhhjklOZRoTgJFb8+scU9k5rFoW7Nb+RheMxNVh/?=
 =?us-ascii?Q?eop6DSs9A371DWfmBNx/NyjVNYA2rR69e4VsH88rBIV1/zIqE5BT6nThlY3C?=
 =?us-ascii?Q?Nn3u42u57IHzT8HNhxEknogZNMOyxC1/KAWHtcZ6JFAQ/F+yYcGHYCRpBKG3?=
 =?us-ascii?Q?qEtaVECokP1Ls17SiFMD3s26/eWmA74lKRnKM89z83Wtn0xbkeLJcljIb+Wf?=
 =?us-ascii?Q?qjfWqKoPPvDmH8Quj5Dv36iK0OlEnfc6K1wdUvkfk8Lf7nosKbaf7p5TSgaY?=
 =?us-ascii?Q?i3jeYzwjlXTHW6YC30535+Lmm5PfRfo68OLKZ2RIvaW2p1HachmdP3rxPwRh?=
 =?us-ascii?Q?eCu3oaJh4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eed8089-6a5f-48db-c66b-08da326a0fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 09:47:13.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4qHYku9CA+8eN/M0BVgxD22M577wVtFNxcq12v6gtkTtGceC6nUve+erxeOoPE6XKNZYQY9sf4k98JohhddVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi, Bluetooth community:

When I try to connect the BLE device to i.MX8mm platform on L5.17.0-rc8 ker=
nel, sometimes BLE connection may fail, at which point I can observe an ker=
nel panic (Unable to handle kernel paging request at virtual address 000780=
24e000003b), then I enabled the KASAN, found there is a use-after-free issu=
e in hci_le_conn_failed(), check the following error logs for details.
There is no such issue with the L5.15 kernel. Has anyone observed the simil=
ar issue on L5.17.0-rc8 kernel? Or have any idea regarding this issue? Many=
 thanks.

Error logs:
[bluetooth]# connect E3:BD:5B:22:90:68
Attempting to connect to E3:BD:5B:22:90:68
[bluetooth]# [  552.446716] Bluetooth: hci0: Opcode 0x200d failed: -110
Failed to connect: org.bluez.Error.Failed=20
[  552.467725] Bluetooth: hci0: request failed to create LE connection: err=
 -110
[  552.481726] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  552.488966] BUG: KASAN: use-after-free in hci_le_conn_failed+0x4b0/0x5a0
[  552.495695] Read of size 8 at addr ffff0000126da570 by task kworker/u9:0=
/73
[  552.502667]
[  552.504169] CPU: 2 PID: 73 Comm: kworker/u9:0 Tainted: G           O    =
  5.17.0-rc8-next-20220315-00001-g7c4f5ebecd82-dirty #245
[  552.515834] Hardware name: FSL i.MX8MM EVK board (DT)
[  552.520894] Workqueue: hci0 hci_cmd_sync_work
[  552.525275] Call trace:
[  552.527727]  dump_backtrace.part.0+0x210/0x220
[  552.532190]  show_stack+0x18/0x6c
[  552.535518]  dump_stack_lvl+0x68/0x84
[  552.539199]  print_report+0x160/0x5bc
[  552.542878]  kasan_report+0xa4/0xf0
[  552.546378]  __asan_report_load8_noabort+0x3c/0x50
[  552.551185]  hci_le_conn_failed+0x4b0/0x5a0
[  552.555378]  create_le_conn_complete+0x60/0xb0
[  552.559836]  hci_cmd_sync_work+0x128/0x210
[  552.563945]  process_one_work+0x60c/0xf04
[  552.567971]  worker_thread+0x3bc/0xe1c
[  552.571731]  kthread+0x278/0x2e0
[  552.574976]  ret_from_fork+0x10/0x20
[  552.578568]
[  552.580065] Allocated by task 518:
[  552.583474]  kasan_save_stack+0x2c/0x54
[  552.587323]  __kasan_kmalloc+0x90/0xbc
[  552.591086]  hci_conn_add+0x70/0xe50
[  552.594670]  hci_connect_le_scan+0x23c/0x71c
[  552.598952]  l2cap_chan_connect+0xbe8/0x11ec
[  552.603238]  l2cap_sock_connect+0x298/0x57c
[  552.607434]  __sys_connect+0x1e4/0x240
[  552.611198]  __arm64_sys_connect+0x6c/0xa0
[  552.615306]  invoke_syscall+0x6c/0x260
[  552.619073]  el0_svc_common.constprop.0+0x17c/0x280
[  552.623962]  do_el0_svc+0xa0/0xd0
[  552.627292]  el0_svc+0x4c/0x8c
[  552.630360]  el0t_64_sync_handler+0xa4/0x130
[  552.634649]  el0t_64_sync+0x18c/0x190
[  552.638325]
[  552.639821] Freed by task 476:
[  552.642882]  kasan_save_stack+0x2c/0x54
[  552.646731]  kasan_set_track+0x2c/0x40
[  552.650494]  kasan_set_free_info+0x28/0x50
[  552.654603]  __kasan_slab_free+0xec/0x13c
[  552.658625]  kfree+0xd4/0x280
[  552.661605]  bt_link_release+0x2c/0x3c
[  552.665366]  device_release+0xe4/0x1f0
[  552.669131]  kobject_put+0x130/0x244
[  552.672722]  put_device+0x18/0x30
[  552.676049]  hci_conn_cleanup+0x230/0x4d4
[  552.680068]  hci_conn_del+0x46c/0x4a4
[  552.683740]  hci_le_conn_failed+0x318/0x5a0
[  552.687935]  le_conn_complete_evt.part.0+0x778/0x15a0
[  552.693008]  hci_le_enh_conn_complete_evt+0x224/0x330
[  552.698075]  hci_le_meta_evt+0x1cc/0x40c
[  552.702011]  hci_event_packet+0x3e0/0x165c
[  552.706123]  hci_rx_work+0x2e0/0x580
[  552.709715]  process_one_work+0x60c/0xf04
[  552.713735]  worker_thread+0x3bc/0xe1c
[  552.717495]  kthread+0x278/0x2e0
[  552.720739]  ret_from_fork+0x10/0x20
[  552.724330]
[  552.725824] Last potentially related work creation:
[  552.730708]  kasan_save_stack+0x2c/0x54
[  552.734557]  __kasan_record_aux_stack+0xa0/0xd0
[  552.739100]  kasan_record_aux_stack_noalloc+0x14/0x20
[  552.744168]  __queue_work+0x428/0xd14
[  552.747846]  __queue_delayed_work+0x144/0x220
[  552.752216]  queue_delayed_work_on+0xa0/0xe0
[  552.756498]  l2cap_chan_del+0x4b8/0xb50
[  552.760343]  l2cap_conn_del+0x254/0x694
[  552.764187]  l2cap_connect_cfm+0x698/0xb10
[  552.768299]  hci_le_conn_failed+0x2c4/0x5a0
[  552.772494]  le_conn_complete_evt.part.0+0x778/0x15a0
[  552.777565]  hci_le_enh_conn_complete_evt+0x224/0x330
[  552.782630]  hci_le_meta_evt+0x1cc/0x40c
[  552.786567]  hci_event_packet+0x3e0/0x165c
[  552.790680]  hci_rx_work+0x2e0/0x580
[  552.794273]  process_one_work+0x60c/0xf04
[  552.798292]  worker_thread+0x3bc/0xe1c
[  552.802056]  kthread+0x278/0x2e0
[  552.805295]  ret_from_fork+0x10/0x20
[  552.808883]
[  552.810380] Second to last potentially related work creation:
[  552.816133]  kasan_save_stack+0x2c/0x54
[  552.819984]  __kasan_record_aux_stack+0xa0/0xd0
[  552.824526]  kasan_record_aux_stack_noalloc+0x14/0x20
[  552.829592]  __queue_work+0x428/0xd14
[  552.833264]  delayed_work_timer_fn+0x68/0xa0
[  552.837546]  call_timer_fn.constprop.0+0x54/0x15c
[  552.842269]  __run_timers.part.0+0x3f4/0x604
[  552.846553]  run_timer_softirq+0x78/0x110
[  552.850580]  _stext+0x29c/0x7d8
[  552.853734]
[  552.855229] The buggy address belongs to the object at ffff0000126da000
[  552.855229]  which belongs to the cache kmalloc-2k of size 2048
[  552.867759] The buggy address is located 1392 bytes inside of
[  552.867759]  2048-byte region [ffff0000126da000, ffff0000126da800)
[  552.879683]
[  552.881180] The buggy address belongs to the physical page:
[  552.886761] page:00000000bc19f159 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x526d8
[  552.896083] head:00000000bc19f159 order:3 compound_mapcount:0 compound_p=
incount:0
[  552.903576] flags: 0x3fffc0000010200(slab|head|node=3D0|zone=3D0|lastcpu=
pid=3D0xffff)
[  552.910910] raw: 03fffc0000010200 dead000000000100 dead000000000122 ffff=
000008002900
[  552.918663] raw: 0000000000000000 0000000080080008 00000001ffffffff 0000=
000000000000
[  552.926413] page dumped because: kasan: bad access detected
[  552.931989]
[  552.933486] Memory state around the buggy address:
[  552.938285]  ffff0000126da400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  552.945518]  ffff0000126da480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  552.952752] >ffff0000126da500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  552.959980]                                                             =
 ^
[  552.966862]  ffff0000126da580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  552.974093]  ffff0000126da600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  552.981323] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  552.988700] Disabling lock debugging due to kernel taint
[  552.994223] hci0 hcon 00000000c12ea080 handle 65535
[  552.994267] Unable to handle kernel paging request at virtual address 00=
078024e000003b
[  553.007176] Mem abort info:
[  553.009986]   ESR =3D 0x96000004
[  553.013078]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  553.018460]   SET =3D 0, FnV =3D 0
[  553.021615]   EA =3D 0, S1PTW =3D 0
[  553.024845]   FSC =3D 0x04: level 0 translation fault
[  553.029772] Data abort info:
[  553.032726]   ISV =3D 0, ISS =3D 0x00000004
[  553.036617]   CM =3D 0, WnR =3D 0
[  553.039651] [00078024e000003b] address between user and kernel address r=
anges
[  553.046850] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  553.052450] Modules linked in: moal(O) mlan(O)
[  553.056948] CPU: 3 PID: 73 Comm: kworker/u9:0 Tainted: G    B      O    =
  5.17.0-rc8-next-20220315-00001-g7c4f5ebecd82-dirty #245
[  553.056965] Hardware name: FSL i.MX8MM EVK board (DT)
[  553.056974] Workqueue: hci0 hci_cmd_sync_work
[  553.073677] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  553.085004] pc : hci_conn_cleanup+0x128/0x4d4
[  553.085019] lr : hci_conn_cleanup+0x42c/0x4d4
[  553.093734] sp : ffff80000d797ae0
[  553.093740] x29: ffff80000d797ae0 x28: ffff00000e85f938 x27: 00000000000=
00002
[  553.104206] x26: 1fffe00001d0bf27 x25: ffff000010a78000 x24: ffff000010a=
78000
[  553.104227] x23: dfff800000000000 x22: ffff0000126da0e8 x21: ffff00000f9=
8d000
[  553.104249] x20: ffff0000126da000 x19: a0400127000001dc x18: 00000000000=
00000
[  553.118534] x17: ffff80000ac1f008 x16: ffff80000ac1ed74 x15: 00000000000=
00007
[  553.132821] x14: 0000000000000000 x13: 0000000000000007 x12: ffff6000024=
db41d
[  553.139981] x11: 1fffe000024db41c x10: ffff6000024db41c x9 : dfff8000000=
00000
[  553.140000] x8 : ffff0000126da0e4 x7 : 0000000000000001 x6 : 00000000000=
00004
[  553.154287] x5 : ffff0000126da0e4 x4 : 0000000000000000 x3 : ffff80000ab=
714cc
[  553.154318] x2 : 0000000000000001 x1 : 14080024e000003b x0 : dfff8000000=
00000
[  553.168614] Call trace:
[  553.168625]  hci_conn_cleanup+0x128/0x4d4
[  553.175094]  hci_conn_del+0x46c/0x4a4
[  553.178775]  hci_le_conn_failed+0x318/0x5a0
[  553.182970]  create_le_conn_complete+0x60/0xb0
[  553.187425]  hci_cmd_sync_work+0x128/0x210

Message from syslogd@  at Fri Nov 19 17:28:03 2021 ...
: Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  553.201344]  process_one_work+0x60c/0xf04
[  553.205379]  worker_thread+0x3bc/0xe1c
[  553.209137]  kthread+0x278/0x2e0
[  553.212378]  ret_from_fork+0x10/0x20
[  553.215973] Code: d343fe61 d2d00000 f2fbffe0 f90006b3 (38e06820)
[  553.222079] ---[ end trace 0000000000000000 ]---

Message from syslogd@  at Fri Nov 19 17:28:03 2021 ...
: Code: d343fe61 d2d00000 f2fbffe0 f90006b3 (38e06820)

Best regards
Sherry

