Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BFAC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 May 2022 04:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiEQEMi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 May 2022 00:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbiEQEMe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 May 2022 00:12:34 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D742A28
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 21:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+Ud24Ayd924vqzFlkzYnwsG0+AhXVLqfV4aQG1ezsMnJwsr/sFpJBb07oN17Oe4i2JIQ8ZcurWFwTJm5HnbwlZHdDh4ccoI3YqjFwa3qwglB1h3+65sgO9lbNtlZLz/Lrd5TBSCgX3XF8eU8bZ/7MrCS0KOm2tmzl5XZtpZzGcqWC/ph+d1ZYJQQCSYblJIamjulOobRuOFGwXebew7PBYywd+VH7CQ0+Mxf1xEEvFCcxiH2Y/phvi2i9+Rkywl/7zyWOwcxpu0048lhF/yDeI0U1IUIgK+LL8wHCl+c0RTdgCCrrIBRvcChZSq2nQu+wu0ZYfLATZ8Laj0EH4F5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GA2xLNJE17EuCx0uHxtXjTQjXXbKaNlcoIAPtyCe6pA=;
 b=gQCdQK5cr1kNS5ZTSqUrZmvIMfbsrXKyFWOGWDlh43cxmKcXFAFEEbZ6G4zTe2KwtgQSiJPGmaUNv2gUtEsbGNdgNbTEbnwLAEZ9kGcnZ7peWXkiPC9UBjortSnG6PTOKmayaKS/ce4++fCLKNUs15agSPC9dS1j2rvB/FJS8fz4N+IJxW+12tXqrGWJHbXuBGqKFzivb6aeK+2wbxsT0wspXnXlpiK5TQXD0/q+dA5UFsg0DSz+AbKpQnJiimiPYu3an4/ySwfJ+I1AELIXaNqmgdQHVuuGdMqNWswoUVMiImnFbG+uMWgYe5U58mHpbysmaOqnGXr+AWlX9yHG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA2xLNJE17EuCx0uHxtXjTQjXXbKaNlcoIAPtyCe6pA=;
 b=Mr1PsVBpUZqmO8IDZa+Yc/cb9rFYAFGZbRoLirxUC3SVyQ/Qss/H485HHC0rWXyn8odB89JPlxc0yF7Z9H1/Utukn8ioqDJg+5hYLrv7Ef/pybEwE2rUTKrU7Arf0fUEkqEQTdw3CcuCbbHyWbR8PtN85eTX+fgAvbpuDDW9/hs=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM9PR04MB7523.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 04:12:26 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::881e:9703:7584:80d5]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::881e:9703:7584:80d5%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 04:12:26 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: observe the kernel panic (use-after-free in hci_le_conn_failed)
 when connect the BLE device failed on L5.17.0-rc8
Thread-Topic: observe the kernel panic (use-after-free in hci_le_conn_failed)
 when connect the BLE device failed on L5.17.0-rc8
Thread-Index: AdhkUtoL7lAi/117QumjYlgpO3ds9AAShVAAARyb5qAADMfsAAAWWQEQ
Date:   Tue, 17 May 2022 04:12:26 +0000
Message-ID: <AS8PR04MB840492F660642A13D069021692CE9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <AS8PR04MB8404AB7E63BB4533852BB4C992C99@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <CABBYNZJFJN42XgTKG9ZFv9Eyen7kypcpmEaf+9ztjz1rzray7w@mail.gmail.com>
 <AS8PR04MB8404468D3D28B3E38B2D9DA592CF9@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <CABBYNZKURLwhtsPx00+AMBJ_qGXWMib+1x=7mojsK-7rTU4qaw@mail.gmail.com>
In-Reply-To: <CABBYNZKURLwhtsPx00+AMBJ_qGXWMib+1x=7mojsK-7rTU4qaw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c304517-ccc9-4029-4d22-08da37bb73bf
x-ms-traffictypediagnostic: AM9PR04MB7523:EE_
x-microsoft-antispam-prvs: <AM9PR04MB75236F647616EB8C959F24B492CE9@AM9PR04MB7523.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KC2og58Bbi5Tls+Syq8oGSI85YOxjvRd2Jngwx5okB4wrrW0NvhuHX818JorN27QemqbCreyVYfGSFXFS4CQyozYz2G7JIU9CjjfwlYQ6g6ohy+XfPtXs4WzwNtc6XW7Fu29L7lh9AEHwJPzDIXqeO5HDFhIEH0xYPHGPatWMjSTg+7Gppcpp66HmKNxGAeB9ENIHvSsP/C69kyoGmWPUjAwcuDOXnqQobaGTOFSCp4gC1jTEojSzAccGSIBaEz0Ffre8UePV8ZE6uXnNH+lKeblVpCG/egIAUoXQRrKP/v3Vn62tDZ9TZ2Onv+PllLbuQhlXA/cU/7g1du7VNDaoqsr95T5EZ4cr9wPO1oCppT8wOXrl63XwKXadzB5clc3VjGoYhMqMpWaOaMcaji2YYKghoXCQ7kvJdI1I4aOr864UV/ZQv+v/jMKfqfxLwsyGvDkx8iEab+FUs+ahw1SVkH5T4+YhMfX7fK1aN7urXYM5PcXsM6T1EmQJSIt3yLhPava/K6QwiDN6GQJ9cYNRenSaTaPl4In5EFJdQmggEAVAfiXOcKQewWendndDpJgE+c+F7sFtjl9n40jPzecVKnZUL4DYWSeOqFH6ZI53zCjbwHHzVbY7ntFLDB0Gw1RGRqBwGE6Su7mKEWlXOHRx8ZERkv3htiMTW8YAkdRXThEFaFzjRusKTGKXZfLoxQH9qRNTCKY5T8EsWau2VMktegRxFKA7ktZR0EXOZ31WFaNt0SsEYLAjpfTqQGr6y56eMg7YnWqGc2Pr+DxrMKwJXSYO7iJahwjPdWWfVCIoAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(44832011)(86362001)(6506007)(66946007)(5660300002)(30864003)(66446008)(66476007)(8676002)(64756008)(55016003)(76116006)(122000001)(7696005)(26005)(52536014)(83380400001)(8936002)(9686003)(66556008)(2906002)(38100700002)(966005)(45080400002)(316002)(186003)(508600001)(33656002)(38070700005)(54906003)(4326008)(71200400001)(6916009)(4001150100001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F8n+snC8XkmtFly5fPAwLUMHdXktmp6r6+fuWiAccVGP90w93XW52ZC1FRba?=
 =?us-ascii?Q?ZTZyqU22jjild8T/G2+BOy/m0lRxA44W9GUa/Avx76zp3v1mQiOGNGzBO0Z0?=
 =?us-ascii?Q?GWluNaeEI0YGZJWTugLL6pCZgcExLDNwD8Dlb/bMLyePxQZ7upxntZ2jK0Sj?=
 =?us-ascii?Q?bXPDnBReVmGWiyd70Mx8dbnIWHiE482OkRAVQs+ZF1o0wgwmyIvEvniLmF21?=
 =?us-ascii?Q?173Rp2mTBEiyVXpNamEuiyGWv6Mul3cJUhjntcS0P+ecVXBjbfi1KfBtMAU9?=
 =?us-ascii?Q?e74vbgu2f4eKUSjmvimmKpGVpGgWWuzs1ZP/ZtNAeo+TunvQwIpV8N6MOKYc?=
 =?us-ascii?Q?uOD4mb2GZF041jiIx7G9+FaNYSSo4A9jJl6ljJL7sRptGTpM6ZiLRnTpPiCN?=
 =?us-ascii?Q?vl/S/u7aDyd8JZnexaZtgk5Zm+1EhvH23bnnzAG8RDIziGElbun2D62oEV0B?=
 =?us-ascii?Q?4ZRbm7J7tnSpxdNp9n93hoJuNgjLpICRa1k+ehmsuJcYR6rDr1G1C3e01bQ9?=
 =?us-ascii?Q?SiVD1Vi0SLDc2Nf57OCa+E/Ll1iQfr38DGel6MaeVVjH9A/GLYoPc21oZgn+?=
 =?us-ascii?Q?y7X6AgCD5vTy5nI4ZGI8bgLEOx80xSszgFPX+LToHPoagCthAAW2GmVzKsc2?=
 =?us-ascii?Q?1dZ8G6k8mUl7iUKypiFP6OeiazdmEO7g8XlmJ+Ub7iYdYJcGeMj6s/FDJn0a?=
 =?us-ascii?Q?cw/9Oy1hGR2Ei0qF1Y73j3DOrdKqErjJt79gNwkj2A5K9lbEjVyJWhoBOsDU?=
 =?us-ascii?Q?t2diN2KcudTofnrCPXwJW0EyXpJNroLr/RfxjJ82wD9+ygxGQmBB91xfEgB0?=
 =?us-ascii?Q?Mct7SgrJg/dvyIAzJhpou1yB2UbhSOmRS7w0m+VeHuO4DYsHjnC9ZDFGKmDs?=
 =?us-ascii?Q?JpZfpXSzX8ZGNwRyj2pnS8bPmk8b9knjInEDKcHUDiQjfKk8A3pzzx7CQ84l?=
 =?us-ascii?Q?DkR7y4A0fYDJGREwFWL9GHRsQgnPfaQkiyRZIGQBrEqReV3Ml8On4AarL5Rb?=
 =?us-ascii?Q?ox6fHXl5o9KPkHNQSXBU1lrmROZ8fUQYlokBgb2fiH+sFtglDSiNLcCfjBYD?=
 =?us-ascii?Q?R2DZJBh/R/MjULN0EQ5CvOMylnp/+ZLBfeutNmEKs3GqlXdBGvxnaXS7UpUM?=
 =?us-ascii?Q?hn96Ci059jw0Ff17g36Soq+M2MBQQqvYfeHZrxMwoRz0JdWGLVtT9A338YfA?=
 =?us-ascii?Q?q0RYzBnE0plADsk5NWqhSY8NLpC+53N2izAVlTccAQW8e1dCEl0hBjMyANF9?=
 =?us-ascii?Q?IVLFTSxldKvo1k5FihiT8qP0KQeFIMLlEwqHLe7lBqS+QjCUHPiKK5t2s0cv?=
 =?us-ascii?Q?bl22tHUlGetj+rYLSafweJDT0EpuzzynVKDsB85a0UzsAmEdLi1WcjYb9tJn?=
 =?us-ascii?Q?+avmRovEmGLsSFOrlm1+8Nm+gKL4I7N7tDvseM1sRfzFBV4nmNkGOgcJ8Nd6?=
 =?us-ascii?Q?ocA96JAC1Mcs1ESnXZ0BEDecPZykge8fNHIgULJDTFXtXRA8TooB5PjT78w8?=
 =?us-ascii?Q?zKsu9zI4aGPaOVYYkqX+PP8P0tv7DQrQm2omEYbCkw6rxWg0z4s0e92zHKpu?=
 =?us-ascii?Q?imsILzHEIWa5prWDHB9uAdxoD2kkXHnxoIQpCkmcvITwsZFgmS70lrYv4N4h?=
 =?us-ascii?Q?9/KQ31BMNMeoTN9S5VF+PwXVQCWSpBogxyUMYWmGPHe8r4RK+y/s4i70q/7t?=
 =?us-ascii?Q?TfQeyQp0x0g7cabaxjuu0BCelhWFAWz6kEi9RLB+piNmUei9H95dd/iio8rv?=
 =?us-ascii?Q?UQ+lpaT+mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c304517-ccc9-4029-4d22-08da37bb73bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 04:12:26.6519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1NqI2h9To0n3BV/1SUSXz4OllEjf9qFFlpSJepS7cHWil1lawqJJKYKWK7MxoCZiO5/n4yhWZEwl4DDLCOIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7523
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> > > > When I try to connect the BLE device to i.MX8mm platform on
> > > > L5.17.0-rc8
> > > kernel, sometimes BLE connection may fail, at which point I can
> > > observe an kernel panic (Unable to handle kernel paging request at
> > > virtual address 00078024e000003b), then I enabled the KASAN, found
> > > there is a use-after- free issue in hci_le_conn_failed(), check the f=
ollowing
> error logs for details.
> > > > There is no such issue with the L5.15 kernel. Has anyone observed
> > > > the
> > > similar issue on L5.17.0-rc8 kernel? Or have any idea regarding this =
issue?
> > > Many thanks.
> > >
> > > Interesting, this might be a problem with the controller generating
> > > a different event than expected:
> > >
> > > /* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2261=
:
> > > *
> > > * If this event is unmasked and the HCI_LE_Connection_Complete event
> > > * is unmasked, only the HCI_LE_Enhanced_Connection_Complete event is
> > > * sent when a new connection has been created.
> > > */
> > > err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CONN,
> > >        sizeof(cp), &cp,
> > >        use_enhanced_conn_complete(hdev) ?
> > >        HCI_EV_LE_ENHANCED_CONN_COMPLETE :
> > >        HCI_EV_LE_CONN_COMPLETE,
> > >        conn->conn_timeout, NULL);
> > >
> > > So if the event is different than expected the event would be
> > > processed _before_ create_le_conn_complete which would likely
> > > timeout, so perhaps we need a special handling to match multiple
> > > events instead of just one, though it worth checking if this is allow=
ed by
> the spec given that:
> > >
> > > /* BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 1789=
:
> > >  *
> > >  * C24: Mandatory if the LE Controller supports Connection State and
> > > either
> > >  * LE Feature (LL Privacy) or LE Feature (Extended Advertising) is
> > > supported */ #define use_enhanced_conn_complete(dev)
> > > (ll_privacy_capable(dev) || \
> > > ext_adv_capable(dev))
> > >
> > > Perhaps this is not enough since it appears we are getting the
> > > enhanced version even if this evaluates to false so perhaps we
> > > should test something else, that said we also do:
> > >
> > > /* If the controller supports LL Privacy feature or LE Extended Adv,
> > > * enable the corresponding event.
> > > */
> > > if (use_enhanced_conn_complete(hdev))
> > > events[1] |=3D 0x02; /* LE Enhanced Connection Complete */
> > >
> > > So it looks like the controller is generating LE Enhanced Connection
> > > Complete even when the host has not unmasked it.
> >
> > I have checked that use_enhanced_conn_complete(hdev) is true for my
> host, so the controller generate LE Enhanced Connection Complete is the
> expected behavior.
> > BTW, I have cherry-picked your patch 9b3628d79b46(Bluetooth: hci_sync:
> Cleanup hci_conn if it cannot be aborted) to L5.17, found this can avoid =
the
> kernel panic(Unable to handle kernel paging request at virtual address
> dead000000000122), maybe because you removed the hci_conn_del() from
> hci_le_conn_failed(), but KASAN still reported the same use-after-free
> issue(BUG: KASAN: use-after-free in hci_le_conn_failed+0x3c8/0x480).
> >
> > I checked the btmon log, seems there is an LE Create Connection Cancel =
HCI
> command which cause the LE Enhanced Connection Complete fail, I have no
> idea how this command is triggered, but with your patch, as there is no
> kernel panic, the hci_connect_le() is still trying to create the LE conne=
ction,
> and 2 seconds later, the connection has been auto created successfully, a=
nd
> LE Enhanced Connection Complete also show the success status.
> > So the use-after-free issue reported by KASAN maybe caused by the LE
> Create Connection Cancel command before LE Enhanced Connection
> Complete return, which cause hci_le_enh_conn_complete_evt() return error
> status and free the hci_conn struct.
>=20
> Could you try with the following change as well:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Fbluetooth%2Flist%2F%3Fseries%3D641604&a
> mp;data=3D05%7C01%7Csherry.sun%40nxp.com%7C5d6cd26998df4826bd6408
> da3759a957%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637883
> 155479041975%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&am
> p;sdata=3DiTkBekL9vcvxlYjP83jaAAbWiHnbNIyrvTP2T22o2n8%3D&amp;reserve
> d=3D0

I have tried your patch set(Bluetooth: Add bt_status), it works for me, KAS=
AN won't report the use-after-free issue anymore. Thanks for the fix.

Best regards
Sherry

>=20
> > btmon logs:
> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
> #1241 2021-11-19 17:24:36.276592
> >         Scanning: Disabled (0x00)
> >         Filter duplicates: Disabled (0x00)
> > > HCI Event: Command Complete (0x0e) plen 4
> #1242 2021-11-19 17:24:36.277450
> >       LE Set Scan Enable (0x08|0x000c) ncmd 1
> >         Status: Success (0x00)
> > < HCI Command: LE Create Connection (0x08|0x000d) plen 25
> #1243 2021-11-19 17:24:36.285151
> >         Scan interval: 60.000 msec (0x0060)
> >         Scan window: 60.000 msec (0x0060)
> >         Filter policy: White list is not used (0x00)
> >         Peer address type: Random (0x01)
> >         Peer address: E3:BD:5B:22:90:68 (Static)
> >         Own address type: Public (0x00)
> >         Min connection interval: 400.00 msec (0x0140)
> >         Max connection interval: 480.00 msec (0x0180)
> >         Connection latency: 2 (0x0002)
> >         Supervision timeout: 6000 msec (0x0258)
> >         Min connection length: 0.000 msec (0x0000)
> >         Max connection length: 0.000 msec (0x0000)
> > > HCI Event: Command Status (0x0f) plen 4
> #1244 2021-11-19 17:24:36.286326
> >       LE Create Connection (0x08|0x000d) ncmd 1
> >         Status: Success (0x00)
> > < HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
> #1245 2021-11-19 17:24:40.413907
> > > HCI Event: Command Complete (0x0e) plen 4
> #1246 2021-11-19 17:24:40.414858
> >       LE Create Connection Cancel (0x08|0x000e) ncmd 1
> >         Status: Success (0x00)
> > > HCI Event: LE Meta Event (0x3e) plen 31
> #1247 2021-11-19 17:24:40.415118
> >       LE Enhanced Connection Complete (0x0a)
> >         Status: Unknown Connection Identifier (0x02)
> >         Handle: 0
> >         Role: Master (0x00)
> >         Peer address type: Random (0x01)
> >         Peer address: E3:BD:5B:22:90:68 (Static)
> >         Local resolvable private address: 00:00:00:00:00:00 (Non-Resolv=
able)
> >         Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolva=
ble)
> >         Connection interval: 480.00 msec (0x0180)
> >         Connection latency: 2 (0x0002)
> >         Supervision timeout: 6000 msec (0x0258)
> >         Master clock accuracy: 0x00
> > @ MGMT Event: Connect Failed (0x000d) plen 8
> {0x0001} 2021-11-19 17:24:40.415190
> >         LE Address: E3:BD:5B:22:90:68 (Static)
> >         Status: Not Connected (0x02)
> > @ MGMT Event: Connect Failed (0x000d) plen 8
> {0x0001} 2021-11-19 17:24:41.006451
> >         LE Address: E3:BD:5B:22:90:68 (Static)
> >         Status: Failed (0x03)
> >
> > ...(two seconds later)
> >
> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
> #1366 2021-11-19 17:24:43.998501
> >         Scanning: Disabled (0x00)
> >         Filter duplicates: Disabled (0x00)
> > > HCI Event: Command Complete (0x0e) plen 4
> #1367 2021-11-19 17:24:43.999293
> >       LE Set Scan Enable (0x08|0x000c) ncmd 1
> >         Status: Success (0x00)
> > < HCI Command: LE Create Connection (0x08|0x000d) plen 25
> #1368 2021-11-19 17:24:44.007019
> >         Scan interval: 60.000 msec (0x0060)
> >         Scan window: 60.000 msec (0x0060)
> >         Filter policy: White list is not used (0x00)
> >         Peer address type: Random (0x01)
> >         Peer address: E3:BD:5B:22:90:68 (Static)
> >         Own address type: Public (0x00)
> >         Min connection interval: 400.00 msec (0x0140)
> >         Max connection interval: 480.00 msec (0x0180)
> >         Connection latency: 2 (0x0002)
> >         Supervision timeout: 6000 msec (0x0258)
> >         Min connection length: 0.000 msec (0x0000)
> >         Max connection length: 0.000 msec (0x0000)
> > > HCI Event: Command Status (0x0f) plen 4
> #1369 2021-11-19 17:24:44.008290
> >       LE Create Connection (0x08|0x000d) ncmd 1
> >         Status: Success (0x00)
> > > HCI Event: LE Meta Event (0x3e) plen 31
> #1370 2021-11-19 17:24:47.843529
> >       LE Enhanced Connection Complete (0x0a)
> >         Status: Success (0x00)
> >         Handle: 128
> >         Role: Master (0x00)
> >         Peer address type: Random (0x01)
> >         Peer address: E3:BD:5B:22:90:68 (Static)
> >         Local resolvable private address: 00:00:00:00:00:00 (Non-Resolv=
able)
> >         Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolva=
ble)
> >         Connection interval: 480.00 msec (0x0180)
> >         Connection latency: 2 (0x0002)
> >         Supervision timeout: 6000 msec (0x0258)
> >         Master clock accuracy: 0x01
> > @ MGMT Event: Device Connected (0x000b) plen 41
> {0x0001} 2021-11-19 17:24:47.843647
> >         LE Address: E3:BD:5B:22:90:68 (Static)
> >         Flags: 0x00000008
> >           Connection Locally Initiated
> >         Data length: 28
> >         Name (complete): nut
> >         Flags: 0x06
> >           LE General Discoverable Mode
> >           BR/EDR Not Supported
> >         16-bit Service UUIDs (complete): 1 entry
> >           Link Loss (0x1803)
> >         Company: Nordic Semiconductor ASA (89)
> >           Data: 0010
> >         Service Data (UUID 0x180a): e3bd5b229068
> >
> > Best regards
> > Sherry
> >
> > >
> > > > Error logs:
> > > > [bluetooth]# connect E3:BD:5B:22:90:68 Attempting to connect to
> > > > E3:BD:5B:22:90:68 [bluetooth]# [  552.446716] Bluetooth: hci0:
> > > > Opcode 0x200d failed: -110 Failed to connect:
> > > > org.bluez.Error.Failed [ 552.467725] Bluetooth: hci0: request faile=
d to
> create LE connection:
> > > > err -110 [  552.481726]
> > > >
> > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =3D=3D
> > > > [  552.488966] BUG: KASAN: use-after-free in
> > > > hci_le_conn_failed+0x4b0/0x5a0 [  552.495695] Read of size 8 at
> > > > addr
> > > > ffff0000126da570 by task kworker/u9:0/73 [  552.502667]
> > > > [  552.504169] CPU: 2 PID: 73 Comm: kworker/u9:0 Tainted: G        =
   O
> > > 5.17.0-rc8-next-20220315-00001-g7c4f5ebecd82-dirty #245
> > > > [  552.515834] Hardware name: FSL i.MX8MM EVK board (DT) [
> > > > 552.520894] Workqueue: hci0 hci_cmd_sync_work [  552.525275] Call
> > > > trace:
> > > > [  552.527727]  dump_backtrace.part.0+0x210/0x220 [  552.532190]
> > > > show_stack+0x18/0x6c [  552.535518]  dump_stack_lvl+0x68/0x84 [
> > > > 552.539199]  print_report+0x160/0x5bc [  552.542878]
> > > > kasan_report+0xa4/0xf0 [  552.546378]
> > > > __asan_report_load8_noabort+0x3c/0x50
> > > > [  552.551185]  hci_le_conn_failed+0x4b0/0x5a0 [  552.555378]
> > > > create_le_conn_complete+0x60/0xb0 [  552.559836]
> > > > hci_cmd_sync_work+0x128/0x210 [  552.563945]
> > > > process_one_work+0x60c/0xf04 [  552.567971]
> > > worker_thread+0x3bc/0xe1c
> > > > [  552.571731]  kthread+0x278/0x2e0 [  552.574976]
> > > > ret_from_fork+0x10/0x20 [  552.578568] [  552.580065] Allocated by
> > > > task 518:
> > > > [  552.583474]  kasan_save_stack+0x2c/0x54 [  552.587323]
> > > > __kasan_kmalloc+0x90/0xbc [  552.591086]  hci_conn_add+0x70/0xe50
> > > > [ 552.594670]  hci_connect_le_scan+0x23c/0x71c [  552.598952]
> > > > l2cap_chan_connect+0xbe8/0x11ec [  552.603238]
> > > > l2cap_sock_connect+0x298/0x57c [  552.607434]
> > > > __sys_connect+0x1e4/0x240 [  552.611198]
> > > > __arm64_sys_connect+0x6c/0xa0 [  552.615306]
> > > > invoke_syscall+0x6c/0x260 [  552.619073]
> > > > el0_svc_common.constprop.0+0x17c/0x280
> > > > [  552.623962]  do_el0_svc+0xa0/0xd0 [  552.627292]
> > > > el0_svc+0x4c/0x8c [  552.630360]  el0t_64_sync_handler+0xa4/0x130
> > > > [  552.634649]
> > > > el0t_64_sync+0x18c/0x190 [  552.638325] [  552.639821] Freed by
> > > > task
> > > > 476:
> > > > [  552.642882]  kasan_save_stack+0x2c/0x54 [  552.646731]
> > > > kasan_set_track+0x2c/0x40 [  552.650494]
> > > > kasan_set_free_info+0x28/0x50 [  552.654603]
> > > > __kasan_slab_free+0xec/0x13c [  552.658625]  kfree+0xd4/0x280 [
> > > > 552.661605]  bt_link_release+0x2c/0x3c [  552.665366]
> > > > device_release+0xe4/0x1f0 [  552.669131]  kobject_put+0x130/0x244
> > > > [ 552.672722]  put_device+0x18/0x30 [  552.676049]
> > > > hci_conn_cleanup+0x230/0x4d4 [  552.680068]
> > > > hci_conn_del+0x46c/0x4a4 [  552.683740]
> > > > hci_le_conn_failed+0x318/0x5a0 [  552.687935]
> > > > le_conn_complete_evt.part.0+0x778/0x15a0
> > > > [  552.693008]  hci_le_enh_conn_complete_evt+0x224/0x330
> > > > [  552.698075]  hci_le_meta_evt+0x1cc/0x40c [  552.702011]
> > > > hci_event_packet+0x3e0/0x165c [  552.706123]
> > > > hci_rx_work+0x2e0/0x580 [  552.709715]
> > > > process_one_work+0x60c/0xf04 [  552.713735]
> > > > worker_thread+0x3bc/0xe1c [  552.717495]  kthread+0x278/0x2e0 [
> > > > 552.720739]  ret_from_fork+0x10/0x20 [  552.724330] [  552.725824]
> Last potentially related work creation:
> > > > [  552.730708]  kasan_save_stack+0x2c/0x54 [  552.734557]
> > > > __kasan_record_aux_stack+0xa0/0xd0
> > > > [  552.739100]  kasan_record_aux_stack_noalloc+0x14/0x20
> > > > [  552.744168]  __queue_work+0x428/0xd14 [  552.747846]
> > > > __queue_delayed_work+0x144/0x220 [  552.752216]
> > > > queue_delayed_work_on+0xa0/0xe0 [  552.756498]
> > > > l2cap_chan_del+0x4b8/0xb50 [  552.760343]
> > > > l2cap_conn_del+0x254/0x694 [  552.764187]
> > > > l2cap_connect_cfm+0x698/0xb10 [  552.768299]
> > > > hci_le_conn_failed+0x2c4/0x5a0 [  552.772494]
> > > > le_conn_complete_evt.part.0+0x778/0x15a0
> > > > [  552.777565]  hci_le_enh_conn_complete_evt+0x224/0x330
> > > > [  552.782630]  hci_le_meta_evt+0x1cc/0x40c [  552.786567]
> > > > hci_event_packet+0x3e0/0x165c [  552.790680]
> > > > hci_rx_work+0x2e0/0x580 [  552.794273]
> > > > process_one_work+0x60c/0xf04 [  552.798292]
> > > > worker_thread+0x3bc/0xe1c [  552.802056]  kthread+0x278/0x2e0 [
> > > > 552.805295]  ret_from_fork+0x10/0x20 [  552.808883] [  552.810380]
> Second to last potentially related work creation:
> > > > [  552.816133]  kasan_save_stack+0x2c/0x54 [  552.819984]
> > > > __kasan_record_aux_stack+0xa0/0xd0
> > > > [  552.824526]  kasan_record_aux_stack_noalloc+0x14/0x20
> > > > [  552.829592]  __queue_work+0x428/0xd14 [  552.833264]
> > > > delayed_work_timer_fn+0x68/0xa0 [  552.837546]
> > > > call_timer_fn.constprop.0+0x54/0x15c
> > > > [  552.842269]  __run_timers.part.0+0x3f4/0x604 [  552.846553]
> > > > run_timer_softirq+0x78/0x110 [  552.850580]  _stext+0x29c/0x7d8 [
> > > > 552.853734] [  552.855229] The buggy address belongs to the object
> > > > at
> > > > ffff0000126da000 [  552.855229]  which belongs to the cache
> > > > kmalloc-2k of size 2048 [  552.867759] The buggy address is
> > > > located 1392 bytes inside of [  552.867759]  2048-byte region
> > > > [ffff0000126da000,
> > > > ffff0000126da800) [  552.879683] [  552.881180] The buggy address
> > > > belongs to the physical page:
> > > > [  552.886761] page:00000000bc19f159 refcount:1 mapcount:0
> > > > mapping:0000000000000000 index:0x0 pfn:0x526d8 [  552.896083]
> > > > head:00000000bc19f159 order:3 compound_mapcount:0
> > > compound_pincount:0
> > > > [  552.903576] flags:
> > > > 0x3fffc0000010200(slab|head|node=3D0|zone=3D0|lastcpupid=3D0xffff)
> > > > [  552.910910] raw: 03fffc0000010200 dead000000000100
> > > dead000000000122
> > > > ffff000008002900 [  552.918663] raw: 0000000000000000
> > > 0000000080080008
> > > > 00000001ffffffff 0000000000000000 [  552.926413] page dumped
> because:
> > > > kasan: bad access detected [  552.931989] [  552.933486] Memory
> > > > state around the buggy address:
> > > > [  552.938285]  ffff0000126da400: fb fb fb fb fb fb fb fb fb fb fb
> > > > fb fb fb fb fb [  552.945518]  ffff0000126da480: fb fb fb fb fb fb
> > > > fb fb fb fb fb fb fb fb fb fb [  552.952752] >ffff0000126da500: fb
> > > > fb fb fb fb fb fb
> > > fb fb fb fb fb fb fb fb fb
> > > > [  552.959980]                                                     =
         ^
> > > > [  552.966862]  ffff0000126da580: fb fb fb fb fb fb fb fb fb fb fb
> > > > fb fb fb fb fb [  552.974093]  ffff0000126da600: fb fb fb fb fb fb
> > > > fb fb fb fb fb fb fb fb fb fb [  552.981323]
> > > >
> > >
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =3D=3D
> > > > [  552.988700] Disabling lock debugging due to kernel taint [
> > > > 552.994223] hci0 hcon 00000000c12ea080 handle 65535 [  552.994267]
> > > > Unable to handle kernel paging request at virtual address
> > > > 00078024e000003b [  553.007176] Mem abort info:
> > > > [  553.009986]   ESR =3D 0x96000004
> > > > [  553.013078]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > > [  553.018460]   SET =3D 0, FnV =3D 0
> > > > [  553.021615]   EA =3D 0, S1PTW =3D 0
> > > > [  553.024845]   FSC =3D 0x04: level 0 translation fault
> > > > [  553.029772] Data abort info:
> > > > [  553.032726]   ISV =3D 0, ISS =3D 0x00000004
> > > > [  553.036617]   CM =3D 0, WnR =3D 0
> > > > [  553.039651] [00078024e000003b] address between user and kernel
> > > > address ranges [  553.046850] Internal error: Oops: 96000004 [#1]
> > > > PREEMPT SMP [  553.052450] Modules linked in: moal(O) mlan(O)
> > > > [  553.056948] CPU: 3 PID: 73 Comm: kworker/u9:0 Tainted: G    B   =
   O
> > > 5.17.0-rc8-next-20220315-00001-g7c4f5ebecd82-dirty #245
> > > > [  553.056965] Hardware name: FSL i.MX8MM EVK board (DT) [
> > > > 553.056974] Workqueue: hci0 hci_cmd_sync_work [  553.073677]
> pstate:
> > > > 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--) [
> > > > 553.085004] pc : hci_conn_cleanup+0x128/0x4d4 [  553.085019] lr :
> > > > hci_conn_cleanup+0x42c/0x4d4 [  553.093734] sp : ffff80000d797ae0
> > > > [ 553.093740] x29: ffff80000d797ae0 x28: ffff00000e85f938 x27:
> > > > 0000000000000002 [  553.104206] x26: 1fffe00001d0bf27 x25:
> > > > ffff000010a78000 x24: ffff000010a78000 [  553.104227] x23:
> > > > dfff800000000000 x22: ffff0000126da0e8 x21: ffff00000f98d000 [
> > > > 553.104249] x20: ffff0000126da000 x19: a0400127000001dc x18:
> > > > 0000000000000000 [  553.118534] x17: ffff80000ac1f008 x16:
> > > > ffff80000ac1ed74 x15: 0000000000000007 [  553.132821] x14:
> > > > 0000000000000000 x13: 0000000000000007 x12: ffff6000024db41d [
> > > > 553.139981] x11: 1fffe000024db41c x10: ffff6000024db41c x9 :
> > > > dfff800000000000 [  553.140000] x8 : ffff0000126da0e4 x7 :
> > > > 0000000000000001 x6 : 0000000000000004 [  553.154287] x5 :
> > > ffff0000126da0e4 x4 : 0000000000000000 x3 : ffff80000ab714cc [
> > > 553.154318]
> > > x2 : 0000000000000001 x1 : 14080024e000003b x0 : dfff800000000000 [
> > > 553.168614] Call trace:
> > > > [  553.168625]  hci_conn_cleanup+0x128/0x4d4 [  553.175094]
> > > > hci_conn_del+0x46c/0x4a4 [  553.178775]
> > > > hci_le_conn_failed+0x318/0x5a0 [  553.182970]
> > > > create_le_conn_complete+0x60/0xb0 [  553.187425]
> > > > hci_cmd_sync_work+0x128/0x210
> > > >
> > > > Message from syslogd@  at Fri Nov 19 17:28:03 2021 ...
> > > > : Internal error: Oops: 96000004 [#1] PREEMPT SMP [  553.201344]
> > > > process_one_work+0x60c/0xf04 [  553.205379]
> > > worker_thread+0x3bc/0xe1c
> > > > [  553.209137]  kthread+0x278/0x2e0 [  553.212378]
> > > > ret_from_fork+0x10/0x20 [  553.215973] Code: d343fe61 d2d00000
> > > > f2fbffe0 f90006b3 (38e06820) [  553.222079] ---[ end trace
> > > > 0000000000000000 ]---
> > > >
> > > > Message from syslogd@  at Fri Nov 19 17:28:03 2021 ...
> > > > : Code: d343fe61 d2d00000 f2fbffe0 f90006b3 (38e06820)
> > > >
> > > > Best regards
> > > > Sherry
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>=20
>=20
>=20
> --
> Luiz Augusto von Dentz
