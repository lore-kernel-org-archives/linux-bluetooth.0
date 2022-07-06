Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29C6C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jul 2022 22:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiGFWXp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jul 2022 18:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiGFWXo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jul 2022 18:23:44 -0400
Received: from mail2.multitech.com (mail2.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C68C4248C3
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jul 2022 15:23:42 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id E8C32585F2F_2C60B6DB
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jul 2022 22:23:41 +0000 (GMT)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 09F09585F05_2C60B6DF
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jul 2022 22:23:41 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcmEnFcWZ+Fy7QYgcieqiYWrJZ8UDb18o5FkoNOvwJQu4oC/YjF5Cwmi1Mon9fIECSg+zmfqTYD3iBwpS9R8SmgjAue02VzB3Y6Y1Ik2Jdbyo3XhhlYw4P1v1HDsUQMecaKpfPjiuL9XsWVBku5tkUmqstY5C44wxdK/kQIrb03LcowyY4zA62jYCHT4XkkZozPfEcuIF+XiOW0rEvIP4F2EvkA0GEqiLHBXEPp8byY5YrT0eh0a9RtdEJLsa0FiegMdwyxoLHb1nV00Um9jDcifk3eu7nU1h+k1YWSJ5YrOWAFwQkgZb/xshi+gi9gvQz5P37TD1kKfV3b+sOeSWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoOiYjO+rGFTyq+P6mTzaWj/WlDs/m9esisDkq4g7wk=;
 b=FYPzjac8BeElmVEEaxT8hETRy+xJiGmK21dt850/ZvFMIYou4OWMFZUPjlTBXDuGACfcgqzEiVcmwz1Ol75C68QGe90FphnXeI+KuDYNTULvLQOLXkfZhbx0rs8m8/c8kRd7yBuOzS6tCS2PAtYPEpLIb7QfFODSo3OdvAkAnYg0umqpVv0sB8083fMXEoHNkRc7yRUzFOB8v6oPs1BSCuvq96+jCocxpOere2MIdb074p+xtmXGT2Sbi0hv51kExtXUvXXlYg5IUqMjlQ2oBUx0C5ulWSKgwP6Uh6HFkOsGncPccZr6qVm1zJ2yQTaiMWrO7uI0RsoBtxhzzvqJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoOiYjO+rGFTyq+P6mTzaWj/WlDs/m9esisDkq4g7wk=;
 b=AVFDFMbr/lh34NOsla4+PHXPOOylAuTJu0/vKApCZpP0/eklZbncogPDFlE4HYdnXCHpDjr08J9hvrw1DhhNfFaoHtykg8VpTaOGdLTT2gm/9cqJpc9ACcyJqpU0y/oVpTuHsi1d4OSoywtXn965lQqg75TuExqKaOGBtdZo3Ew=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by CH0PR13MB5219.namprd13.prod.outlook.com (2603:10b6:610:fb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8; Wed, 6 Jul
 2022 22:23:38 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%5]) with mapi id 15.20.5417.013; Wed, 6 Jul 2022
 22:23:38 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
Subject: [BUG] Extended Scan Hangs
Thread-Topic: [BUG] Extended Scan Hangs
Thread-Index: AQHYkYPWWftWQokBQUOT5vMZZwl4BA==
Date:   Wed, 6 Jul 2022 22:23:38 +0000
Message-ID: <SJ0PR13MB5755B252BAE811BDFE22E3F7FE809@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 3be51df3-c9b3-279f-f8d3-f09679a870a8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d903a57-8655-4ca2-3777-08da5f9e2c98
x-ms-traffictypediagnostic: CH0PR13MB5219:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 329h39Qf4KXAe/2FFlJC2L2yxasX0NwGNU1ZMROU1DseUpGr8p9qi9pVPvzFudTw2q68CYBQLe3sANhSnPtQki+pCYH7vs8YRsGYvXc25QOKlTzkrTrXbqlWXqWi5v5gKT3R8rttc7gphrpttd+g4+AzHqpL9GUgJBFAewyGhbvNU3CE/ntH5YMG5mVH7ckmIArNIJf3oD51SLtB/4sE+LjyXSWp6heJLaniy6VldlEYB4WvLqXqQwNWMS1laNPtsHfQqtSWHYieaGdS2mQaDGBena76OvYPwm4FnygKy7MNe7MFXh+uMhacBQtB/iBcZ66Grdhcchb2S0rsvBI9J7jJvM81OHan9lDuY/WLpn4dJFCDn+jwi/GQ/Nm43Ri88WsiWO2HEhyf/unRBROLdszEpR1irVPHS8eHP42YIJ18gwG85yuzt0ioen1d+Mjkk6TeaTkr6Qr7mu+8H7JG58rNxDgtx19VNFxiDUWt+ftVqgiOKvbQ5xB09QtreGWjW5XS1uR4YEp9bjOsfEcQCk1ZlHW4NPPtIx7+rD1YlrWmMoIqsJ4YDCED42fYJ6EEIM8WP24VZ1f1YvhLbHzWVFtaoGbNOK2l7VapA4hYVUvn3oxHE9husAJ8ZPZBW3tOTmGEHT0ecleALu9iqZDWT7l9qPELwZZXqCFICg52klIZ9H/9wfTxD3Vj3ofF8tYQbOwQAuBsqKJTDMWAzLqehdsVuomisGtC9eCMJkEfEDnCAs6Yll6PnddMyLA5DCw6LZRYG2vLl4NSqmschxurtgOxGfwA8KMk9uZCKlpPx89OvCFAvb69N2CC+boPs37s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39850400004)(136003)(346002)(41300700001)(2906002)(316002)(33656002)(38100700002)(8676002)(122000001)(66946007)(38070700005)(5660300002)(66476007)(66556008)(71200400001)(66446008)(186003)(55016003)(52536014)(26005)(7696005)(6506007)(9686003)(6916009)(8936002)(76116006)(91956017)(478600001)(86362001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/vh5ZAWaCJHcT5bblPd2oqB+jUIKnCx23hmysFFNe+2QxLI0buMrileHNg?=
 =?iso-8859-1?Q?mwamV9pcxS/449FpOoXed/tGS0vCYozOcKuylMx5LQV83PWx0xcj/B2H2o?=
 =?iso-8859-1?Q?LAPmeOHrgOMEPT92Z9FluBWiAZq1K1vj8uI2vh/hfVRJYcjuUBs0jVcJjO?=
 =?iso-8859-1?Q?J8viRG8vkSSTQkiFyFO1JR/UPV6EELaqw1RAt0/zFTgYwA53/mdpr9hjrR?=
 =?iso-8859-1?Q?TzgIvsPwLouov8x1kWzuh2vaNmA19pcognNSdkeR32/rFaXJtQRHmeFMo2?=
 =?iso-8859-1?Q?sddH1vFmAEbSaOdKpjp0mWl/Raty6wOsg/DuqSRRDRf+zi2rNSTT3b78E4?=
 =?iso-8859-1?Q?mz9wg6pT9wjoeK7OX0M8RHxlBgs03lMmXyUXj7RJUpduwAoC1I6pPl1zxh?=
 =?iso-8859-1?Q?dvx1ETRAPv9m9jPM3euAWWnH7oILP20N9IIvVynJAZH1v9YDuqtwHfY71C?=
 =?iso-8859-1?Q?VnGpWBlvd5x2FgEy2co45XLzy3QuMGlSzHMyZTaNHeWGmhW42RPwKyobz/?=
 =?iso-8859-1?Q?99caC1G2mm837/Fk3zFtTzOIazbm7BtMDtXgCYthpkIIhLPT+LoJdBo8mO?=
 =?iso-8859-1?Q?/0Jub0WtTpf5RgLOR7kdsaBolJj0nWtkQBkivrlo3m/JFQxO3u/Gqdom8o?=
 =?iso-8859-1?Q?cioqFq7H8ruJcN8xqHjGT1e3JD/G0o/TfpuAjzo6FNiW9q3vuJsQCum2FN?=
 =?iso-8859-1?Q?lu+62kqq+o/taQ/cv5342rqMl1vLKpYapXcUap1R5SBT11SnQTxeql2hPs?=
 =?iso-8859-1?Q?Vj7NEoAk0MIJMyQ6ZeibXM7aU8QCLbAjZ6O/TCGVVfnyD1FMJiRlttLq/r?=
 =?iso-8859-1?Q?CKTfVSnXWKiStghKQuYIfGyQXKhNtzkN5Ia67tnofnGm3SeKUumGFSk47s?=
 =?iso-8859-1?Q?uQWSllQWtUYVj03MKUbi3hOXIjWd9adC4uHFWdSxF0ZcvH7h7CwbNwY5Om?=
 =?iso-8859-1?Q?z5GH2RW07zXuWkv7dYlOMaJoxugrFaftuWsGuGEGPVp+LH23dcvTx+4oBO?=
 =?iso-8859-1?Q?AoPjnaTxghYV03hCEl67xWWiHjpLA2Kv0hFaiYRaGmQxeIKK5jwMYkhPsA?=
 =?iso-8859-1?Q?eQUjQEZJBQWiT9aNCFN0Nfb8DPeRCR5UTKmcmGiK5Ij34XhxpPsD44nmso?=
 =?iso-8859-1?Q?qEGFJGbu/W425uQeEa5cutz3qdLoKAv6VOjEr+blfLvFUSswkrckXRbtVo?=
 =?iso-8859-1?Q?PFLMuh+ePGo37UDcvrx+rZ5dODkE04NtgPt6TPrUoQQX9pnBYw8dIluI/B?=
 =?iso-8859-1?Q?qEP9f8TYtWNkz88oDZ+k4DGMVo/fuKfLQA2ZstdjZQReFB4JpFTZVFarXa?=
 =?iso-8859-1?Q?G3FGnPdXoxmwlg2fNLt3KFdEdCJ1PrSlJ+6Ye1BX0ZTA5lTDN9wLhn77h0?=
 =?iso-8859-1?Q?Js0SEQhN6mwstq+S0U8kSWt3DgLl6iWTEtm82kaw+aMkbGp1cX9Hu8ls+r?=
 =?iso-8859-1?Q?lJnSPU1bZ1sND4b0ke55mwlfk4l+9RnMR7l0rsAxWYpG+8/LGHxypjRTvk?=
 =?iso-8859-1?Q?k/TfxIXsPuVVK+quCx0gnA8YlIF8boFzZATfomz9yoF/Qno0GPUXdVqFyX?=
 =?iso-8859-1?Q?EgobjHMNrXqL4ENax2ZTCGrfGuLCjy9JClM7/2eyWD3hWqUBAQo6JtvvDf?=
 =?iso-8859-1?Q?K+sSyCmXXvwRE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d903a57-8655-4ca2-3777-08da5f9e2c98
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 22:23:38.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R68WcfB/Wpo7FX5gCOy8wck61Fk6ubDoNVv7gAJunubyZci3Z+JpJmMgAXBjSdMwnehM6OHlpDXH7YinyXp55g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5219
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Bluez5 from master on 27 June 2022=0A=
1d6cfb8e625a944010956714c1802bc1e1fc6c4f=0A=
monitor: Fix crash when using RTT backend=0A=
=0A=
=0A=
Kernel:=0A=
5.4.199=0A=
=0A=
After turning scan on, after a short time it hangs.=A0 Here are the packets=
 to start discovery:=0A=
=0A=
< HCI Command: LE Set Exte.. (0x08|0x0042) plen 6 =A0#1777 [hci0] 11:06:02.=
731748=0A=
=A0 =A0 =A0 =A0 Extended scan: Enabled (0x01)=0A=
=A0 =A0 =A0 =A0 Filter duplicates: Enabled (0x01)=0A=
=A0 =A0 =A0 =A0 Duration: 0 msec (0x0000)=0A=
=A0 =A0 =A0 =A0 Period: 0.00 sec (0x0000)=0A=
> HCI Event: Command Complete (0x0e) plen 4 =A0 =A0 =A0 =A0#1778 [hci0] 11:=
06:02.741529=0A=
=A0 =A0 =A0 LE Set Extended Scan Enable (0x08|0x0042) ncmd 1=0A=
=A0 =A0 =A0 =A0 Status: Success (0x00)=0A=
@ MGMT Event: Command Complete (0x0001) plen 4 =A0{0x0001} [hci0] 11:06:02.=
741819=0A=
=A0 =A0 =A0 Start Discovery (0x0023) plen 1=0A=
=A0 =A0 =A0 =A0 Status: Success (0x00)=0A=
=A0 =A0 =A0 =A0 Address type: 0x06=0A=
=A0 =A0 =A0 =A0 =A0 LE Public=0A=
=A0 =A0 =A0 =A0 =A0 LE Random=0A=
@ MGMT Event: Discovering (0x0013) plen 2 =A0 =A0 =A0 {0x0001} [hci0] 11:06=
:02.741899=0A=
=A0 =A0 =A0 =A0 Address type: 0x06=0A=
=A0 =A0 =A0 =A0 =A0 LE Public=0A=
=A0 =A0 =A0 =A0 =A0 LE Random=0A=
=A0 =A0 =A0 =A0 Discovery: Enabled (0x01)=0A=
=0A=
=0A=
After a short time and 1215 devices found (0x0012), no commands may be exec=
uted:=0A=
=0A=
bluetooth]# scan off=0A=
Failed to stop discovery: org.bluez.Error.InProgress=0A=
=0A=
btmon output looks stuck.=A0 Often the output stops in the middle of an eve=
nt:=0A=
=0A=
> HCI Event: LE Meta Event (0x3e) plen 41 =A0 =A0 =A0 =A0 =A0#3484 [hci0] 1=
1:06:13.493567=0A=
=A0 =A0 =A0 LE Extended Advertising Report (0x0d)=0A=
=A0 =A0 =A0 =A0 Num reports: 1=0A=
=A0 =A0 =A0 =A0 Entry 0=0A=
=A0 =A0 =A0 =A0 =A0 Event type: 0x0010=0A=
=A0 =A0 =A0 =A0 =A0 =A0 Props: 0x0010=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 Use legacy advertising PDUs=0A=
=A0 =A0 =A0 =A0 =A0 =A0 Data status: ^[[0;32mComplete^[[0m=0A=
=A0 =A0 =A0 =A0 =A0 Legacy PDU Type: ADV_NONCONN_IND (0x0010)=0A=
=A0 =A0 =A0 =A0 =A0 Address type: Random (0x01)=0A=
=A0 =A0 =A0 =A0 =A0 Address: 0C:7D:02:DB:5A:57 (Non-Resolvable)=0A=
=A0 =A0 =A0 =A0 =A0 Prima=0A=
=0A=
Note that "Primary PHY" is incomplete.=0A=
=0A=
The hang during scan happens 100% of the time.=0A=
=0A=
=0A=
=0A=
John Klug=0A=
=0A=
