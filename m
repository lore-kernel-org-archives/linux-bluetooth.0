Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BBBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A69611CB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 14:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbhHFOom (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 10:44:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:50260 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232160AbhHFOok (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 10:44:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="236361806"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="236361806"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 07:44:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="569768429"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2021 07:44:23 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 6 Aug 2021 07:44:22 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 6 Aug 2021 07:44:22 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Fri, 6 Aug 2021 07:44:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Fri, 6 Aug 2021 07:44:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IafEh5vjrcEEN5FqwzbIHhGcK8AwPhNgMdixF9td2PkSyfMx4oB8MFfptVNW1YBkEEAzZho/3FPr+3UNVLjwebt7vlpXu4gCgHPMP9lTcD5iYvGq3NaMhfzWZHbyFHKxa6p8/0+HxvQHDs6o0ChW9cVDLE2Zj9P8L9j07soBu9Jm1XJxEjzOH61Qq0SbPu0V59TGf6jx0SQA3OF1Jy0/yWQR+bykTurQSBhfRY1ImXaCAjyZdd5F4ZCLK0YH/luQ7H/irUiZEbDiaXHwAHlWpc6Rd00YrQZmuojJXDHwpDWejUe+loZwX6Q5yvy1/atESQmqM1aQbi+2zxKyEJJDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPyQ6AxppKfqUZ8bXcvJ8alpx7YsysdxC3yguDF4RXY=;
 b=nByZKftQLEZyDcAiFIgEQbjifXQdwY52nPVeizcLV6JT96Qk81ua1EM+4IESwDzKiKWMaqmE+lxKo9loTZXvc6L2/+YVI5b1lw8/TYz4x0MOxsmbjMN9He+P8lS39BlxW6o0EON8nun+1tQLJL1f2r0DwNr8AINoJ+Sa1TEXmnsbQ0v4FQnswnyYGhiUx0rBwwiqmRImTdw7dUWXmQ+xE9a+orTak3XqbsuT92zRpf5tYtC1YuWHbV86KRhvdFQaSml7ugTNxwkaE4mukqHR0XKkpIO+RKsC+X2C2VbEq/W13QEs4gNFFPm+Gsv+LPxcU53CWY7P1D0CebmSeuu4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPyQ6AxppKfqUZ8bXcvJ8alpx7YsysdxC3yguDF4RXY=;
 b=PZGwKSaBmb+qnHMLYbo5NpGPJQ7wWNG7CcA9RUw2wagphrWG4orNapkh1OaAQfruLeTJXUjIJnkpJR7GbHQMUrv1VKUKOJoxSoxKIBWSrd+kqBS6KLphDczA5wZfnQXaZyA2QlkaruYVHfz+s4TMPHMiZ8e3/QDHnhUUQ0+gtx8=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.20; Fri, 6 Aug 2021 14:44:21 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10%9]) with mapi id 15.20.4373.027; Fri, 6 Aug 2021
 14:44:21 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     BlueZ <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
Thread-Topic: [PATCH v1] Bluetooth: Fix race condition in handling NOP command
Thread-Index: AQHXiVcmy61Y/5HvckOI5dFZpf8b3qtk5AYAgAGqIMA=
Date:   Fri, 6 Aug 2021 14:44:21 +0000
Message-ID: <DM8PR11MB55738B15758672E2982D748AF5F39@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210804173939.25496-1-kiran.k@intel.com>
 <CB7F6AB9-E997-4C77-B19D-D018F8044001@holtmann.org>
In-Reply-To: <CB7F6AB9-E997-4C77-B19D-D018F8044001@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c17f5088-5ab6-4b47-8210-08d958e8ad40
x-ms-traffictypediagnostic: DM8PR11MB5670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5670702559EC6EF8B8E1FE98F5F39@DM8PR11MB5670.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TFU4PpKIMzraSpB3mlo3DxPXN5hXeHjHjZurifqx5y8TyFGfijL4v+WuOpx47isbs4RMKdWh08/9NQVOwsXcOPbdOZCAqDRiQuU/rLJ6lXYLRsDOfSqH3pySRTbLCL/FvEhSSH/mcG8KDdAoKF5rMiKaKkeOlmJXstoLGTq93ONA7uIi+4C2HcyYG8k9ZttHLMENRuUGTyaIsbFwjzrynAJkaIK34PAsk70np9C5vN25WGHMzL6IJYYX/PNaX6lyRJ7AsggcLim++4Rv30+AXvYFCwoEp/WAQ4AFLtHsxb7gim4Au/bcuctr7A6T1+FDs7qjWNyfFgo6csjyPpG7QFac9ARX1qseQWtHwEcIldNVwXi4FAiZj00aMvDCsiLU5VC4bRPHirOctplaOb8+BHJKAnv6wm92dt2PiKuOaHIxTHlbl658+UibqMFUbxo5UdRXqTmuqe0S3RE1eQZCgVHPaeoS/noAnsl10wc0bO4Vcw1vYs0ovSs1twVMe0mOeTLjFEnOl9+y4JIydKWOSxfxvYJSR2iMj+VT0+du2brPKcQ5DsO0axf9p08UqLHF86PpuXs51tBbC5bAXefzvIOa79ElY3lGNJn+DL5mJX7Hp9oZoYTb3g+nHhWfoEEBtlPcr5CYQ76DpSYsAWNBobGCA3z/PUFjInzA33lN0KvDCNPvFKCyRp6S4G4fb25GOzlDp+K40KRzCGlwfc27JQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(53546011)(122000001)(6506007)(38070700005)(76116006)(33656002)(2906002)(478600001)(186003)(26005)(71200400001)(38100700002)(66476007)(66946007)(66556008)(66446008)(7696005)(64756008)(4326008)(6916009)(316002)(54906003)(107886003)(86362001)(55016002)(83380400001)(9686003)(52536014)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H6jkXjnZT8xb5ZLC749uZ5l0f/vbCRZNXUSZKpx3k6/lEX+e9xZzt+n2/FJb?=
 =?us-ascii?Q?Qs/JlFNecTfQXLY3//C8/NBXZ3GelO8ixSws6gSi/fHvkteFDsZGHjw+Phlv?=
 =?us-ascii?Q?OWeJxPsVh5rjACygy/+Yu4s0lqcP+/cEckXY4NvFkHhf0VbFCd62vUBXbW/F?=
 =?us-ascii?Q?xzQJ0+nfcYWORNEvz0+eU6s/fc2lXmnN4ddSDogsqOYjNrSOznDlxEZCl//g?=
 =?us-ascii?Q?s7/AeO7W42ZDk9lUPC4xKcgeIO4bqbUIg3dmxw2zWoEdh5ce+w+dE+ewwwO0?=
 =?us-ascii?Q?iuuF8dK4tYSlMZnpuz2BYMEbcskpRbpy0pKEhP04yP+A1WjJeK/WyAYTVnrI?=
 =?us-ascii?Q?HPrs2cykNRpHxSqC85qGmYdkgGgFdZT8sMA8nGEaIenDCjr/4JrA9bPDblz4?=
 =?us-ascii?Q?dxVTW8oEqgD4383Z3J/LSUn88v2Y9nrZDsFf72OJmQ3YfIpOa512vIfcsnn/?=
 =?us-ascii?Q?gF70MUYw89/ql6xP5uXKysIpj5OFepa7+4uyMX80XyMwF1IOGP0imZM11hmP?=
 =?us-ascii?Q?ial6Wo9EhSxroPh/8Ot0Q7ZqCZVB+5i9fkFXiba3e2V3wwG29zsmtUXf+tN1?=
 =?us-ascii?Q?j3agr/pIRvU1E4N/L5TfknHN6daaCwHpglPyUXIOzf0u1kgjIVuYbKK8pFRx?=
 =?us-ascii?Q?uwb02hgn6vyi13MwzF+O+2097Nf3g8+tpvMQ+msJiNWkKbjTEsBwTsaakwH+?=
 =?us-ascii?Q?wqPinAn57mA8ejNewmrcIRcPWuvr/iPMI9T7rGkeJJWREWnNeG5rrGsLJwhV?=
 =?us-ascii?Q?T49E88HEutaSumZvgjerDa+GDkq8yXAQjiG4q8Mp/eIGUl4V2suR63q9bZls?=
 =?us-ascii?Q?D6UikRBO0mdpAM22bGiyTOG4awlWMSAgQAUmnw3Me/vuoqtOJ9e+MUr7B4Yh?=
 =?us-ascii?Q?4js9iUBvNbCYh+YNAMGoO4TEFWgMTG0Mxb+grz152xSUJrL/il7C95p0N737?=
 =?us-ascii?Q?xZdRA7XwvvHjJLtTQjt2sxuS6bsSvXHoXhZkBt2Gk02Ziw28ea8pkR6pDSyZ?=
 =?us-ascii?Q?ZFiSLesCLSern22mMT6qGsqhL6dBkSWveDO7CBrjeCNmzChh4KqbrZN0DhXI?=
 =?us-ascii?Q?4JrcV8VbSURtPJ0OyeCUPNx/pLqoSvTEi4M5xHl0Rnesgws232oeVzUTK952?=
 =?us-ascii?Q?8pV/GcRl9LamBYPQC6RdaaQnsD1TBNlRrWsABV/lN7y1oBrFN4umRbDh0wPl?=
 =?us-ascii?Q?5g3au0PP5tqEB2NLt6HSvwLJ5ahLZNE7863921Fqswxy3jn+dNMemCix0bUd?=
 =?us-ascii?Q?5yyKRnEsB5Gr33blLnP+dPxJlK9UXD0crrLdvsQvQXK4tmuNSYveG18TVpBZ?=
 =?us-ascii?Q?X2iThsm4SxpzRdfhN8twrzl5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c17f5088-5ab6-4b47-8210-08d958e8ad40
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2021 14:44:21.0903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAoyVKiYIFTY8dl9WO9Ak35vSoNUjiNqxfmgCU3mfn61+RnvUHFRaNZR5dJShVTaPShhloP1+FyT2dw9WbK2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Thursday, August 5, 2021 6:41 PM
> To: K, Kiran <kiran.k@intel.com>
> Cc: BlueZ <linux-bluetooth@vger.kernel.org>; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; Tumkur Narayan, Chethan
> <chethan.tumkur.narayan@intel.com>
> Subject: Re: [PATCH v1] Bluetooth: Fix race condition in handling NOP
> command
>=20
> Hi Kiran,
>=20
> > For NOP command, need to cancel work scheduled on cmd_timer, on
> > receiving command status or commmand complete event.
> >
> > Below use case might lead to race condition multiple when NOP commands
> > are queued sequentially:
> >
> > hci_cmd_work() {
> >   if (atomic_read(&hdev->cmd_cnt) {
> >            .
> >            .
> >            .
> >      atomic_dec(&hdev->cmd_cnt);
> >      hci_send_frame(hdev,...);
> >      schedule_delayed_work(&hdev->cmd_timer,...);
> >   }
> > }
> >
> > On receiving event for first NOP, the work scheduled on
> > hdev->cmd_timer is not cancelled and  second NOP is dequeued and sent
> to controller.
> >
> > While waiting for an event for second NOP command, work scheduled on
> > cmd_timer for first NOP can get scheduled, resulting in sending third
> > NOP command not waiting for an event for second NOP. This might cause
> > issues at controller side (like memory overrun, controller going
> > unresponsive) resulting in hci tx timeouts, hardware errors etc.
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > net/bluetooth/hci_event.c | 3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index ea7fc09478be..14dfbdc8b81b 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3271,8 +3271,7 @@ static void hci_remote_features_evt(struct
> > hci_dev *hdev, static inline void handle_cmd_cnt_and_timer(struct hci_d=
ev
> *hdev,
> > 					    u16 opcode, u8 ncmd)
> > {
> > -	if (opcode !=3D HCI_OP_NOP)
> > -		cancel_delayed_work(&hdev->cmd_timer);
> > +	cancel_delayed_work(&hdev->cmd_timer);
> >
> > 	if (!test_bit(HCI_RESET, &hdev->flags)) {
> > 		if (ncmd) {
>=20
> so this is conflicting with the patch introducing the ncmd timeout handli=
ng.
>=20
My patch specifically addresses the issue observed in case of NOP command. =
It prevents the issue by handling NOP same as any other SIG command.

It looks commit de75cd0d9b2f3250d5f25846bb5632ccce6275f4 tries to recover w=
hen controller goes bad.
 =20
> commit de75cd0d9b2f3250d5f25846bb5632ccce6275f4
> Author: Manish Mandlik <mmandlik@google.com>
> Date:   Thu Apr 29 10:24:22 2021 -0700
>=20
>     Bluetooth: Add ncmd=3D0 recovery handling
>=20
>     During command status or command complete event, the controller may
> set
>     ncmd=3D0 indicating that it is not accepting any more commands. In su=
ch a
>     case, host holds off sending any more commands to the controller. If =
the
>     controller doesn't recover from such condition, host will wait foreve=
r,
>     until the user decides that the Bluetooth is broken and may power cyc=
les
>     the Bluetooth.
>=20
>     This patch triggers the hardware error to reset the controller and
>     driver when it gets into such state as there is no other wat out.
>=20
> Nowhere in your commit description you are addressing why is this the rig=
ht
> to do.
>

Will fix it in the next version if you are OK with the current fix. Please =
let me know.

> Regards
>=20
> Marcel

Thanks,
Kiran

