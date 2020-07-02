Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37159C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 13:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD712088E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 13:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bFnEP9/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgGBNZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:25:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:44070 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbgGBNZ4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 09:25:56 -0400
IronPort-SDR: hX2QD1jNcMPx+Ez3JbKOFUDdZhFaYhA7iVRpF6SDLJ6xxZOdK375HJVK9t4qO5KXQE/2fpqt/l
 r6z25Fz4On6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="135180168"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="135180168"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 06:25:55 -0700
IronPort-SDR: o4Z7CBesEydbAQVIdPS5kijTD+yOzvFosrre8Isuj2jQVa0iAyttaUNxA/JVuV4VIPwKiV/aQm
 qPCQN/Rx+/cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="265699912"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 02 Jul 2020 06:25:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 2 Jul 2020 06:25:54 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 2 Jul 2020 06:25:53 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 2 Jul 2020 06:25:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 2 Jul 2020 06:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+yXvT4pm716mcPp+NvOl2IWva5XTRFaTLACvISIDjx2qGuFweyxDgJyr3qSIZnlcapNOUPbRaqB8SrnLnhsJcH30q51asMhq1BsEpqvD88BkuOBMBhTpRDJ1pOW0EtHSnR42xmHnRMpxR6aJH1uof4g1PgNDAshNvGdPtnbJWpqqTaXCqNEhcugPgw6AYokOy/mdaK3QAmqv/s9ebx2cdJhoA7g1NcwyMrY9xKB4jqUfRBNvNmlcnuJ8J3nxm3ifyMJ86m2+hi1r5Ed67fle+rLNrBbXMTqmnPh6B7QZ8ysivMav2ZLwMQaYtI8/AryKzBYnaRRB8liDSo1UzpR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5/M6aGMgJh51Br7ePVw8oEdbj8G4S2JRwGtqPPAIcg=;
 b=eP69sEtk2yEPgxQ5w9WHrtxSCDrwOfzzmbr25fltXNuje0kWCn7942yutgFHW4pcGSdqICIuen+yd1M+6JX+gsAFBWDRE3xanC9P/CrQnyzzHAtN81wpptSp71msQ6IJgTdYr6ro7m3pbSGckCJ4dJm4NMoylDHYuES9ISIqAwMPSwnxCgoF7xoQDP5cm0Xe1QstV79vRACk/RCoTDUDzYlgee+1lyl7ybGNcPQCDHQ9DZiDBzAMm4yrbh1WNWYRAYo5oDpjM0tDRGmTkBjmBi3l22KU3Bxs0jHID4wPLOarfm9+w+5pl6Thnv+56NGql8lZyv4v2tLirsSkrdn08Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5/M6aGMgJh51Br7ePVw8oEdbj8G4S2JRwGtqPPAIcg=;
 b=bFnEP9/69xpL9YfUhqfao2eCq0rTMOK5ElwFQQoXnGvCsP76lmRbSPUGUclLRf5hrryEWd5SGVnej4Op6BeMzpWv2PsO50T7SySMo3mAgPEpXLigVRwyDaJk30vfpZ8J3owbo2cqrTdMKfT7UWj91DcYnzI46/38vP8IRHSx4Os=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BY5PR11MB4372.namprd11.prod.outlook.com (2603:10b6:a03:1bb::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 13:25:50 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::9ce5:c8f4:581b:9d9f%5]) with mapi id 15.20.3131.028; Thu, 2 Jul 2020
 13:25:50 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "kiraank@gmail.com" <kiraank@gmail.com>
Subject: RE: [PATCH 0/4] Add support for new generation Intel controllers
Thread-Topic: [PATCH 0/4] Add support for new generation Intel controllers
Thread-Index: AQHWP+W9IdC9GwaE7UKfsfbct+pb7qj0Z8NA
Date:   Thu, 2 Jul 2020 13:25:50 +0000
Message-ID: <BYAPR11MB3141A1910C50E5E0315D1D99F56D0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <20200611114526.13594-1-kiran.k@intel.com>
In-Reply-To: <20200611114526.13594-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.79.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5695206e-a214-4d23-6190-08d81e8b703d
x-ms-traffictypediagnostic: BY5PR11MB4372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4372C5FC277CE2B6685D53F2F56D0@BY5PR11MB4372.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9CZhUJ+tSQP8c9YlgLO2qGbF5qIgxNWWGFSsiLKSqbQYEyfDw4DoUY0oodfmt+j7sIxRW+N8aiLdcJMKyyOROvh1+FQDY499skIOLqR16fo0DLgnBF2Suv0j9GyY5/qVY8PJPmND+goT2DTlB6ML0luaO7byPTNev1y1346eKvI2B8wUmdrg8aftchfFW8j7L7iRGfD2FpdChyS9ltLfzTFYAuyRp73K7RJMqr0DEBkrrb984+O4sJahdJXgCDkKJl79VaYnzZi6+Vu3lHPvY+hDFirZ04cUsXK0P/+McelOoPbosjdryFwLy7GjqlPZ+UW7x26nd7Og8PDH5T5J0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(4326008)(478600001)(66556008)(66946007)(76116006)(8676002)(52536014)(2906002)(8936002)(66476007)(5660300002)(54906003)(71200400001)(6916009)(86362001)(316002)(186003)(4744005)(66446008)(64756008)(33656002)(83380400001)(6506007)(53546011)(55016002)(9686003)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lFnor3wzWMUFh46fYrzj51Vx78YOfwopF3ZX95gJtXVb1297xFsWEO6vSqlnRQKAIvb5CIsOMctOUiFcVvebeb4/WGzWpWaO+TBuPiVfjsmTAqxmDEtUhkiiTNsAaqcI5SEYzO4i6fRGKuvTW7eyveBkjOjgzI6Bihs2npecSBSqIMG76E31w92ueQ/COiql5o7rBDOPxIzqNHf+RDWAWprcfow2hM0D0uwUlpdZBK965o18LPA91dqNDJ2bE7sILVpNrnou8JQQxW6rf8f2JAl1eSdTxAsCdmktfT+33JfF2VKMg1PlQ4D3W0fAb6UIvcZC3p8+BC9ZGHl6yKeGGvbzx7DpZTNkF9ZLBIv2cH9b8ZEfpfrijD9bfTbDW5IO3eLPIxyhtOAGuAwx4eNTq2MgEl+4trPZ/kopbJlmFyegdg03mrFkWBb1NIKLHI1M5fEFpRY8Nj2ZClObCDB6FF8sqq7+3ttN8loUTRmsikk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5695206e-a214-4d23-6190-08d81e8b703d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 13:25:50.3644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxUKQiPWpRB3b98ThB7/vO4M2JaqQSO4a6JlJII1bZ5Te+YwzqpkJoTScmkafSKUF1ESzf8wwczit0RCdx1rKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4372
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Please ignore this patchset. I started uploading newer patches with  smalle=
r changes and more refactoring.

> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Thursday, June 11, 2020 5:15 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>;
> kiraank@gmail.com; K, Kiran <kiran.k@intel.com>
> Subject: [PATCH 0/4] Add support for new generation Intel controllers
>=20
> Hi All,
> This patchset series defines a structure and few helper functions require=
d to
> enable new generation Intel controllers
>=20
> Raghuram Hegde (4):
>   Bluetooth: btintel: Define tlv structure to enable firmware download
>   Bluetooth: btintel: Add helper functions to dump boot/firmware info
>   Bluetooth: btintel: Add helper functions to parse firmware name
>   Bluetooth: btintel: Add helper function to help controller type
>=20
>  drivers/bluetooth/btintel.c | 173 ++++++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel.h |  49 ++++++++++
>  2 files changed, 222 insertions(+)
>=20
> --
> 2.17.1

