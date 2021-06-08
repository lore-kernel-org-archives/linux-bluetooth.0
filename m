Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413F7C47082
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2959861003
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhFHMIy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:08:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:61357 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232294AbhFHMIx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 08:08:53 -0400
IronPort-SDR: kXCFAM14ZObdy6haxGSRXc7ExHMjQ2Xcd5+0xxVp8GYKtAOyf5FYFENXRiRLERh9nQZXGwG9nd
 G1ACtx9CAQaw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="226172982"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="226172982"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 05:07:01 -0700
IronPort-SDR: LXHAcPV9ZHcM3hYZzEF1KjS1tZwgYawxBnS42K6/E0OFATuHxz04S/a9kmzL4u4wEhDi8ggvhq
 1rL9vNu/kKDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619280271"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 05:06:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 05:06:59 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 8 Jun 2021 05:06:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 8 Jun 2021 05:06:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 8 Jun 2021 05:06:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vee/xh2PHTZwb5Syy//8wlpHfhKeOy5p62UZLE5g0/toyZC+DqKeBy/+qguyP1ugWHQh9vWd/WPoV+mCEb1tpKIlzUqWQjhGshyIRB/8MlzslwHUtrjdCcxWqyU6ZHo6sg8AKviQjCcW1YLX5BetAfdR2iFrFtxfM4DQg2rxvQcw9e9qWmb8TFltZnXPa7ctLXCqS6GYsbGOh8aMFDoyC+c3+UCrXehadhnfWLC8b+accZzeCf1p8cLUD0CWNh41F0/y1AXXlzqk60BKh2FGetWTl8SgEsSQYDuVUeePVzigdkfGOLa+YkFYZKEH1qOvtRlTwQ2Tphg0odoiTAm8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWGNw0MZRjp1TzOWjpxxHaFox18bqH9onypxunO/Lgw=;
 b=W3flCO0b9qcNMdUhOGKBcVSQ/6peLYYpQE+4gqwoeSAX+mI3ev01t1Fj2JC4fUsAUSvSSqht/eDjX0y4xw+b9M2kkaHdTRoVOx7wnLYNhJYXUMJtgcVhICpfRpUIax4QVWAJnbh5GNPwCBYV9CJlKwebjHsDUinObi4tbAT1OHWuOve1Ip0bxUjP4kM2uqPDkvyTgeIbg5qf+mABHR4Q1HC27zRV2rKCDSTl+pI/KhaUQl2S3xnrXsdQGrwHcl/4+LNG9cwqpke6pg8YUIc8mpLRoooE4Jw/gvqWh565kbWhwo7J1QYfjkftcafRHbRc5jlZQMYcd1iy2SWlXQ2v1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWGNw0MZRjp1TzOWjpxxHaFox18bqH9onypxunO/Lgw=;
 b=CU1J0EBfmgN3EsC5fnD2msEceWmZsRq3/FCUMlUsLLAgAUkSHpxdX6QImpsmqVdWumEBF/cmwzt3EeEHgVrHS/TSV/YFn9y8WrE6IS0X2gtyOsWA+VOImskpWCGfNUVLVJCI48ZgRkRi9T+9As12xWNQLlyxTsoIPGfJvjUTQtU=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Tue, 8 Jun 2021 12:06:44 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 12:06:44 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v8 8/9] Bluetooth: Add support for
 HCI_Enhanced_Setup_Synchronous_Connection command
Thread-Topic: [PATCH v8 8/9] Bluetooth: Add support for
 HCI_Enhanced_Setup_Synchronous_Connection command
Thread-Index: AQHXS9IK3hV1Sk93tk6Tqnl6Ulpd9asCdPWAgAewGGA=
Date:   Tue, 8 Jun 2021 12:06:44 +0000
Message-ID: <DM8PR11MB5573C2583F106F1EFC8EC445F5379@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
 <20210518104232.5431-8-kiran.k@intel.com>
 <0141E444-5FE4-416D-BE10-DEE305EA0826@holtmann.org>
In-Reply-To: <0141E444-5FE4-416D-BE10-DEE305EA0826@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.169.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c7ee78f-927d-4a56-7c37-08d92a75e241
x-ms-traffictypediagnostic: DM8PR11MB5592:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB55928D298387277E0AB8D073F5379@DM8PR11MB5592.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vRGoGZKAGt2HUWOrklMUC4C1uc6WBHG2D87qQMCQzdrMJGu6g8hJnzOEBs8MMnJ2Mcn3fZf3Q7dfffztOcObqXrOtQgpeFga8IlEA6Jaqqv+25lysboPm+Szf3s9/9/6ZjyMqi5PkTjZO7Ow0lyVpRJQYbFSD+I8BeP3vEQ1Swa7yvIzBGBKCd0lUeDJsfSIoBMhnVSt78W+iMEfHiKwWBZXvL9sAAzelUzWs7yf86sVWVWNjE1PnT7xBQNwOp1+4w/4o/hNyq0pdT60UNnsvb5C+JOJHkGNyzHW24gU3eBjjw/aAMTsIEZdM5Hvs+zOGSRYoos9WNbWMBQB2bAkqJv8BIlgUQ/x16AmS2fxw0zpsaLoBUVhqupGoMD5lf4RAkJSRIsdTSTJxnyXFTkrA71rzw2ucT3tgXQ3n73Q/QgaviH3Rgk3gJgokUi4PVljI4rikluiMU5XXDX1xrn6V4rv0KP0TOzE8I2fhp9xNczkXh0lyzEJJoSzOhTvPZChaPa88Xc9lhGkFbCyUwTs6uPBfbbreyrSgnYUbgG53VmEoK94BwjaShLOpa4HRb3vUvoaC5d1PKrQTu1v/N2L85iykeYSIaAhSIDHkZQNl/8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(39860400002)(396003)(366004)(6916009)(107886003)(55016002)(122000001)(9686003)(52536014)(83380400001)(478600001)(38100700002)(6506007)(86362001)(5660300002)(66946007)(66476007)(64756008)(76116006)(66556008)(66446008)(186003)(71200400001)(26005)(7696005)(8676002)(316002)(4326008)(8936002)(54906003)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZV4Kb434gO4SF1JsXSrLFKe2eheUAcpDy8fek46H+gDVlI+Vo5lxe8KZocOT?=
 =?us-ascii?Q?spiMzfpl1oqFvJ45OZiG0+38vZkig5b3OgkY/jFkIH62fKPQmzVv/kZ+EMEL?=
 =?us-ascii?Q?dGXe5Ppz2LCPEmMqLKwJdCGa3quhy8Qb1C+lQt4gOYl3T5YQxmS13CkRJ5Lo?=
 =?us-ascii?Q?WY77a7MDggBzqP2XicGZwAT3G6FaZEoM5I5XT7qXD5xrnWR4TRNW3MlW+1/A?=
 =?us-ascii?Q?GKk1GcaAslssdaTI1W+ZDNa8GyZEIju5sXNOVOyaaGoiavIAo9DZSFjHev0J?=
 =?us-ascii?Q?Xhh9Txp+5YQu+/hE/z4AiYeiOx17vU/dOtTCyd5z+Y09SMNxVhgrNxDfGHKD?=
 =?us-ascii?Q?XdKZ/SbgCKyf2bOLQOmccckoeKO433Y3vYul2rV/8LZVFKfDBPjSso/UnhG/?=
 =?us-ascii?Q?ocrPLebQH/hr6zKcdO6AocWtc223av/RYNJQlZhlpuvUcSedR1v2o3qHe7J1?=
 =?us-ascii?Q?DsM4n+8/UzHRoqRMcNgenV2fE42+71H2VMPzF5JoY79AUTO5eXzZC8QfI26s?=
 =?us-ascii?Q?g5ZGHV+nd0L4DwfJJ56xmpIPDiHh6ha+KwiStKa+7dexkWXp5KFhpEauT/FY?=
 =?us-ascii?Q?4PdK5mRUQjqJtb6WUz9dNRn8uf88qD1rJdyr7A8Tlf2LXVoG6wcz922ojY1J?=
 =?us-ascii?Q?cbZS8svp2go9WHlRpTVvMtrG5X8qJVG4hpisQntllQl0glU0TDy6W5vfwiLg?=
 =?us-ascii?Q?vz8WaKBNn8iJcMcVjxRGan9TRRGLqbL70TLTUbwd1cPsr/DOqU6vVqY8rCiL?=
 =?us-ascii?Q?JE4uYQLbGv1/4uFyqDBX1qwDHYANSnshcAeHKxlTCgwj1hZs3PnX0W5y7kGe?=
 =?us-ascii?Q?gGn+drGj2iqszvDaL7hrmFeWlgpFMflOYcm0aX03uC+zvYt4HHbMmPVD4lQ+?=
 =?us-ascii?Q?/0TzEd6S7FI3FVYjY5IJgozMv9JPqgbpML9NvDdyBvU65HYtts1BwBLZqDSp?=
 =?us-ascii?Q?ejoRiEkHDlTW8aY0FjX1sUwGrRXu5ScAD/dGgcZhxZSiOASZdzaQ0VYjgKBH?=
 =?us-ascii?Q?DkG/kPyfZfnx8aKmMSUQiaJ+BU/5T6zmVmrVv0z+AK+e6fcRX5B/bMvuMlby?=
 =?us-ascii?Q?sW2kWPNN7XdOjjOa7xd6Ddv1IdT5h8DifDF0FkmxoBaEUepikFmcz/bLC62o?=
 =?us-ascii?Q?wKwnkcOHqt1fYNPm+8ea2F0aUWUk5UyEb2uGmw+NH0kXKgnKo6b0VnTOWQ1R?=
 =?us-ascii?Q?yYc8uMjcJ0zi/WH+JvE7M75cfJrazKksTzhBbYst2B3NtwFrkV0tqadM8gMy?=
 =?us-ascii?Q?q/8V6BiL4XUN0164x6NFygMpiQsZyIXslL39F2kREf27TpKhGn24KAMaK6g7?=
 =?us-ascii?Q?lY4kUUdl6Esp67V7FqLTNtDp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7ee78f-927d-4a56-7c37-08d92a75e241
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 12:06:44.4600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8iMpuTIurFEotd2wcp8hT/rhQpCkEFmJRanX+ieF6FgzgU6JuJt+aFeoN8kRPDN4EgwTt/it2PATRqRWbPSHQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5592
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

> > bool hci_setup_sync(struct hci_conn *conn, __u16 handle) {
> > 	struct hci_dev *hdev =3D conn->hdev;
> > @@ -424,8 +514,12 @@ void hci_sco_setup(struct hci_conn *conn, __u8
> status)
> > 	BT_DBG("hcon %p", conn);
> >
> > 	if (!status) {
> > -		if (lmp_esco_capable(conn->hdev))
> > -			hci_setup_sync(sco, conn->handle);
> > +		if (lmp_esco_capable(conn->hdev)) {
> > +			if (use_enhanced_sco_conn(conn->hdev))
> > +				hci_enhanced_setup_sync(sco, conn-
> >handle);
> > +			else
> > +				hci_setup_sync(sco, conn->handle);
> > +		}
> > 		else
> > 			hci_add_sco(sco, conn->handle);
>=20
> you have coding style mistake here.

Ack.

>=20
>=20
> > +static void hci_cs_enhanced_setup_sync_conn(struct hci_dev *hdev,
> > +__u8 status) {
> > +	struct hci_cp_enhanced_setup_sync_conn *cp;
> > +	struct hci_conn *acl, *sco;
> > +	__u16 handle;
> > +
> > +	bt_dev_dbg(hdev, "status 0x%2.2x", status);
> > +
> > +	if (!status)
> > +		return;
> > +
> > +	cp =3D hci_sent_cmd_data(hdev,
> HCI_OP_ENHANCED_SETUP_SYNC_CONN);
> > +	if (!cp)
> > +		return;
> > +
> > +	handle =3D __le16_to_cpu(cp->handle);
> > +
> > +	BT_DBG("%s handle 0x%4.4x", hdev->name, handle);
>=20
> Please start using bt_dev_dbg.

Ack.

Thanks,
Kiran

