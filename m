Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330A7C48BDF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 02:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02D2061166
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Jun 2021 02:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhFPC61 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jun 2021 22:58:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:28825 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231949AbhFPC61 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jun 2021 22:58:27 -0400
IronPort-SDR: yJAT/GBojZkFePYMRd0zpeCjXiETh11mfr0JZPyTtkQEj7kNfQF0T0MpXtY5qWUP0A39V+wxYH
 upDwPnIIJ5XQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291736216"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="291736216"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 19:56:21 -0700
IronPort-SDR: O6zLNGyeshCltPp9DUDlAK1QICWT+kzkqPuKHFtCbML3Kxnin/YXWb7uqfbaYjYM7q7aEjPBno
 aCCEsuxBeoYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="554652157"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jun 2021 19:56:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 19:56:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 15 Jun 2021 19:56:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 15 Jun 2021 19:56:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 15 Jun 2021 19:56:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3cZrCosICGNLy+/DLdhto3w1ZcyIT5MJ8VSwWUZZYlxDu+5BbsdTr4757jXADNsfhvSUY7aJYN6pj2WYpGzzXgcBORvBDR+KQWnY6H+gxoUyQtR7BEs/EfJO78ootNTVtT74zwyS4UA9vYDkIgQY/hMEMK7h9lbyZfUd9TLxPxVZkJhghJQ8ZEpi2Ce37VfIx7kDPyPif4WnoVYJ4cspM+SfFjIyiDsXuLgnZ650gp9BGjz3vKEyJxD4SnXaex/ernC5m7oFr0luC7OVum5tTvT+X/VS9fRy6xWvvKSTgvqs3/WpaJUcjOllQO+IXkKgtUYzwn1CvZuab402px0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP1yoVuw8XQ70IU1WxVe3X6jhFlMxIYaGTkBqM4LwUk=;
 b=WOCufBZzhjfQlyGlW905wTduFQUbZgi+MTXRdILQOjC62IwsxnBKP73N44u6J50ZbP8KYviLlS55S1JxFJVqFJ/2Ol/dH2qZXRgSCvMduN1IMHi0GuCG8QzZzBxRz/BJlrGB3EH1BLzmcDHBNcOsqOB9MvSXNe0HQPpsYMqja2edFohUoS5TUtV4Vs/9NsZbsbX/cWvFEVrKs9kZ5foUDAGoz6juRoJRxPbcCV005MIgo2kHfCyfUGBvKQRKeKOIrERl7OEO7sMfJ2hn7ItemRPaK0Xi7m3YcYb7NZr4PCAE+Q8+Ua52hKJsLaTaZ3UW66VXk6BXlLu1uQtgrL0uaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RP1yoVuw8XQ70IU1WxVe3X6jhFlMxIYaGTkBqM4LwUk=;
 b=jRKZA75gc8bc5VtuM1430gyZ4+n171vWMs780bOW13kKqkMBPzd1v9Cg0u5wfmZuwV5wMLnHXDHRH5KEWqWvEKMXGFHrIaV0mjMQyzi2CSMVEdpTswIFnbCgBwZsZIsTf8yFDWxBYetHswIfIKSy1A4hvv/5dA2xakEcmQx/408=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5654.namprd11.prod.outlook.com (2603:10b6:8:33::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Wed, 16 Jun 2021 02:56:20 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::d813:3260:1526:b63c%7]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 02:56:19 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v9 03/10] Bluetooth: Add a callback function to retireve
 data path
Thread-Topic: [PATCH v9 03/10] Bluetooth: Add a callback function to retireve
 data path
Thread-Index: AQHXXGC/FBHcd05YhkOQyLQlV08FGKsVf/AAgAB8wNA=
Date:   Wed, 16 Jun 2021 02:56:19 +0000
Message-ID: <DM8PR11MB55738B34B77C3B03B305D607F50F9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
 <20210608122455.19583-3-kiran.k@intel.com>
 <3C9F25C0-3122-4208-938A-3C3094E018BA@holtmann.org>
In-Reply-To: <3C9F25C0-3122-4208-938A-3C3094E018BA@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.181.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cc294ea-9b51-476b-02d6-08d930725164
x-ms-traffictypediagnostic: DM8PR11MB5654:
x-microsoft-antispam-prvs: <DM8PR11MB5654219C07B34396EDA45A6EF50F9@DM8PR11MB5654.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E5/F4HlKBQ5BVL4KmDvQab97SriLrrtUN2XrWWqgLtTnn+BGbTp6+s33yupjcx5c52ck7bgM6NZ7bKZ+hC6scW1XjWPbWyQg9IPweXQdGAXIVbXGhk/0YzLuip6yvLvShRe1SK8CAupN2mrkyepsP/8pf1a1SlQaGuBK8Oa/2u1+csvT3hzocEOeF27l027eRHuxVpjXXNmd26etZ+wqWM9JL4VHBf/DoUSAQtYMsJQuOxRKz+B2TK2oAQsTsiHEY6rZomQCxE0SjMyp+3FmLDuBjKj3n2Ve1PdFQI9FQ/0t1BUCQpPS4M3b7unCuJzjkbyJFtVhIUUhzc0gPmZ9X0W8MShIxlQItVmydQAqWbJ/L10BW9m8YWgusIlzNPbsAcP/rLXs4X6Yzmh3+0La6ns1qxH2JvY8yCLCDuVWVEwTzVfdgcx+xyy7H8IbIfr9cKqrPKhShXCs4lqwERN5EmYNEQtw6IfWR+OF05pjDuZeEJ/SFTFHFZPCkz2liIxHZDT/zXHBhgPA16I8jC3KBYWCmjt+I0zrKHcHt3ZY7z2C9cEXCakFIZ5iWKODU4gFfZjgT4i+ByH1mPOsD+DMetfA9EI1uElndQEBtDXYN2I8F4mHa2gOMU9Fda2ozJFg3VibTHeJtx/R49QF2RYSOmB9eheIKocnyysnY40s//BG35v2oUSnwBQqfqBTBE3wOSG4PXNHntB5U1AdKqtI988502J63V3eQZgid3z41DE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(376002)(136003)(33656002)(6506007)(8936002)(86362001)(6916009)(8676002)(9686003)(478600001)(122000001)(38100700002)(966005)(4326008)(66556008)(26005)(66946007)(55016002)(2906002)(316002)(186003)(52536014)(66476007)(64756008)(66446008)(5660300002)(7696005)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SCcJkOGZZCvUVOl0vDMbGMjJulyg2m0s/IZ/94UWRE5/RFOJR4MBV6rCSAnA?=
 =?us-ascii?Q?dk8V1a8V4TFbaBu9aeVXfXpds5rliScWD93siNsSBc8Xhdn72cU+GZCQvk+R?=
 =?us-ascii?Q?fFyNMy0wvw3FW5qB3GbEoPZBeAXbYeA78sHlJUjEC+yuxwjsXgDbEuXb+/LH?=
 =?us-ascii?Q?8fpBESVBWl8277iFKrJkVhuhhXG8sXyf1Y+CozDb1Wd41xxQoHp2vJDIna+W?=
 =?us-ascii?Q?beBx3Ax6iahoSgUmI00HalA55AwVJYlyums1V2CSvanhJF4LUjUGLeE/RV0A?=
 =?us-ascii?Q?r5IhBPfZKqdPjAThOEHISdRgFHiawCaf5a5H0BWVyYpButtcHdpxawAYoP31?=
 =?us-ascii?Q?Q49j4V/ey5IftgtFsXV0P7X8oUmjQuLoJWOhIyD+IU0eiukGYdqul6/89ime?=
 =?us-ascii?Q?Wi6UHS54GPh+s/Ji21YzcvmK/9KA4imhDWnG88ab68Fb3LeDS98VWCOwkG22?=
 =?us-ascii?Q?vTdxOxWmudXvcpfCYbyCbNzdIMiXggz+cH07b7qhfNDwT9+x41qaSkQrN6+i?=
 =?us-ascii?Q?+dtjUIHX/1hD5fqgd24YbKsB7oylFXAnfsblU591OJzWm+Scviw8dXe+gthq?=
 =?us-ascii?Q?q3QhmnS/sWhEfeFoOrcSEan3I+WMN07J2qKtZfGfa2J4yM+mz4ZxmP/aJzrX?=
 =?us-ascii?Q?2ttwcphrsCtFvyNkhHxKh5sKvMdA8QHaOPrqiry9C9baayTxNnrEAziYFSKK?=
 =?us-ascii?Q?CekNywmwxMdrSZfAwhBAF08GQDpemqd3t30pXOiN2zGABENtNcyk2fzLoq32?=
 =?us-ascii?Q?TyO/g7B93xHw6kdsYJH+c1g+rycekl9hX9LkLp750kP7RidEvNpE3znSBXhI?=
 =?us-ascii?Q?jY3e56xmIEVHe1YWsMwGG/B+DGNL+dOTp+fJZxsez+AuHl9ztWGrgpmQBVkM?=
 =?us-ascii?Q?Ny4hdVxJ+jOliBmKIKPyoDPL4CesqjWUwABieFPEpCNS4SmsYa83eDe/waVO?=
 =?us-ascii?Q?IdlbM6s/iaq90iBw50tAiUYW3Ue7xXMr62dCjJggA4WySbq0JrKDnDhy3lXV?=
 =?us-ascii?Q?RmDRkdnKCzKYQYOhbnanBFTgv7sHhQ5pA5Im6Z4A1x4pH9EyPTvxxc0V1loA?=
 =?us-ascii?Q?0mto33we4A8hmjnGd4wKfNpqaIqt/6VZ426ls9RrZieXa+XW+iExfl8eiQFe?=
 =?us-ascii?Q?iAG6ZKBxd543eyVHb4vfjjiN75P6tg6+RdyRk2CXpghn6lji59a2U3Bf12IM?=
 =?us-ascii?Q?AFZaO1GwlNpj5D9UrN9n1YCBONCNA4JRTIgTTh/gDef0mzl0ta4+yfG7Y5Vu?=
 =?us-ascii?Q?QaM6tuMYW+s2kS/bRfT3TIy9ZzyD5vNrv88kra51Yr1hw6pp9ogTZUT3z/a9?=
 =?us-ascii?Q?TfFn2n7QeCceIghuRdEkp7Me?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc294ea-9b51-476b-02d6-08d930725164
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2021 02:56:19.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imAYezrzot/6mbr4BTdVY5gWzIw1FvYRSx+ofgD8sW+64CHNQHbVcEoPbvY+EjZxoJZxqTtL2GPQd9+rEKYiSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5654
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> Hi Kiran,
>=20
> > There is no standard HCI command to retrieve data path for transport.
> > Add a new callback function to retrieve data path which is used in
> > offload usecase. This needs to be set at setup stage if controller
> > supports offload codecs
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > * changes in v9:
> >  - define a separate patch for core changes
> >
> > include/net/bluetooth/hci_core.h | 1 +
> > 1 file changed, 1 insertion(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 3284044c3dd7..641477396da3 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -617,6 +617,7 @@ struct hci_dev {
> > 	int (*set_bdaddr)(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> > 	void (*cmd_timeout)(struct hci_dev *hdev);
> > 	bool (*prevent_wake)(struct hci_dev *hdev);
> > +	int (*get_data_path)(struct hci_dev *hdev);
> > };
>=20
> and where is the code using hdev->get_data_path. That code needs to be in
> this patch.

In the previous patchset, there was a comment to separate out driver and co=
re changes. Let me know if I am missing something here.
https://patchwork.kernel.org/project/bluetooth/patch/20210518104232.5431-3-=
kiran.k@intel.com/

>=20
> Regards
>=20
> Marcel

Regards,
Kiran


