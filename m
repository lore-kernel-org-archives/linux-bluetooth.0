Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102BBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 13:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C72208DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 13:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="L3h2MFp4";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="GLas4y/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbgE0NQS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 09:16:18 -0400
Received: from alln-iport-7.cisco.com ([173.37.142.94]:56869 "EHLO
        alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387942AbgE0NQQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 09:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=670; q=dns/txt; s=iport;
  t=1590585375; x=1591794975;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=tLi3OHrZoLIcQuaSbubUblMykSd5i/ly4ZgY7EcTKXo=;
  b=L3h2MFp4hR+wBfrckrzIWiueDOzvf4wi87/ng8QHOCxc8egYnHZKkp+5
   6Tyuope2fKvdRRSTTDUmplyklRvtQRqYz8HV+HTHpN3UjHfJ3IiAq+5fL
   qg/TeqehwKl2bslj7lKixcVZvZtouonIA78nPb20UjBm3IfCGHh20RU/a
   4=;
IronPort-PHdr: =?us-ascii?q?9a23=3ADuUdtRwaEOtj4oLXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5ZRaBt+tigUWPXojB7f9Aze3MvPOoVW8B5MOHt3YPONxJWg?=
 =?us-ascii?q?QegMob1wonHIaeCEL9IfKrCk5yHMlLWFJ/uX3uN09TFZXgaFDI5H6/9zgfHl?=
 =?us-ascii?q?P4LwUmbujwE5TZ2sKw0e368pbPYgJO0Ty6Z746LBi/oQjL8McMho43IacqwR?=
 =?us-ascii?q?yPqXxNKOk=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D8EABdZ85e/49dJa1mHQEBKwEJAQY?=
 =?us-ascii?q?BBQUBIoFMgU5SB29YLywKhBuDRAIDpgCCUgNVCwEBAQwBAScGAgQBAYRdgX0?=
 =?us-ascii?q?CJDgTAgMBAQsBAQUBAQECAQYEbYVXAQuGCxERDAEBOBEBIgImAgQwFRIENYM?=
 =?us-ascii?q?EAYJLAy4BDqJ6AoE5iGF2gTKDAQEBBYJJgngYgg4DBoEOKgGCY4cUgkwagUE?=
 =?us-ascii?q?/gREnHIptM4ItkWehTAqCVJhgHYJTmzWQUp1pAgQCBAUCDgEBBYFqIoFWcBV?=
 =?us-ascii?q?lAYIKAQEyUBgNlDKKVnQNKgIGAQcBAQMJfIsrAYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.73,441,1583193600"; 
   d="scan'208";a="485806088"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 27 May 2020 13:16:15 +0000
Received: from XCH-ALN-004.cisco.com (xch-aln-004.cisco.com [173.36.7.14])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 04RDGEiC020159
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 13:16:15 GMT
Received: from xhs-aln-003.cisco.com (173.37.135.120) by XCH-ALN-004.cisco.com
 (173.36.7.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 May
 2020 08:16:14 -0500
Received: from xhs-aln-002.cisco.com (173.37.135.119) by xhs-aln-003.cisco.com
 (173.37.135.120) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 27 May
 2020 08:16:13 -0500
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-002.cisco.com (173.37.135.119) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 27 May 2020 08:16:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIrWTr+oDp9rwnWkuZlliv8e+G53XNpdH9Bgg1iRl3Xu1V3wPVYCdB7vF6rCKYvwW4t0Q8zXx0b1o75EN9pMM7YtNCjFdTkmCVuEKKYIpd9MU3/v+urzzFEU8UiOBEryWX9eB0Oqznt2/ZR1GhgpydTL5Zx67I4Fn8WlL/RNOabWupfDtrJtAhMbtx+J0OKzwXIdxKvjPBYha1sp+FVWmrzR4gf2s3wTufEu/OKrdEZ4rVbtKDdkeQAd1Yc1thYO6GGEpGOLb2Vs3D42mLSbSSqdcEAbcIz4EUHztrHgK41ZlzKpHU8cX3O0VZF4y8fTfkkqTx91WsXXDSHCxZGR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLi3OHrZoLIcQuaSbubUblMykSd5i/ly4ZgY7EcTKXo=;
 b=D8G07cugjk/jQBKy5JR9MyxYD8hHsO4daQNxRWmM5fyxny4NhYa4mJ4HvZa0NAP72NidS1grhKRa1zav6SgJaaVISI8FQjp/uy0KNkdwl8uz1yotqmLD+toxpXTc8ZZhua9ary6fTwz6/Tap4GNHCOOJsfmnxsIAcgaK87WNodKUaDm29gZj1fjuMpgLxQSVKbFdP4O8tHRnFAfHCeq6gmWpC0Xn3sfnlxHmYSkf1AJv5c6cHxrkiR185tPrSxmRYX4y1Xf921jIoGYR2aMU9sZ2UWNzwucZpoHzyZpVAaJZ9dx+0LG/o5c/Y5lqc9JZfOdDJJuUAnCk7FCqFpwggA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLi3OHrZoLIcQuaSbubUblMykSd5i/ly4ZgY7EcTKXo=;
 b=GLas4y/zwcjIjw008OLAJXwiCFVruACCIhmyUsfmKLwkYjEPd5cC8lE9KF5faSOf17b6w+wQs8hroHPObrdRKHNcmYK2RmeqEBtVLXR3CwPLDOkTlk1UuISOX/yV/HCrtrCGtOiVtUnZ5EKk30mWnzRF+UkjQcKyB9i5VmXUsPQ=
Received: from BN6PR11MB4082.namprd11.prod.outlook.com (2603:10b6:405:7d::20)
 by BN6PR11MB4129.namprd11.prod.outlook.com (2603:10b6:405:83::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 13:16:12 +0000
Received: from BN6PR11MB4082.namprd11.prod.outlook.com
 ([fe80::1802:999e:c0a0:6ee5]) by BN6PR11MB4082.namprd11.prod.outlook.com
 ([fe80::1802:999e:c0a0:6ee5%7]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 13:16:12 +0000
From:   "Per Waago (pwaago)" <pwaago@cisco.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: BIAS Security Vulnerability
Thread-Topic: BIAS Security Vulnerability
Thread-Index: AQHWNCj+Qc6Oaz6U/U6hhBEQ3P/S7g==
Date:   Wed, 27 May 2020 13:16:12 +0000
Message-ID: <8606B9A9-1EEE-419C-9D23-7EFAF226C8AF@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.220.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85f50adc-982c-4e29-24fc-08d802402106
x-ms-traffictypediagnostic: BN6PR11MB4129:
x-microsoft-antispam-prvs: <BN6PR11MB4129667F102FDB55B34EDE9ECFB10@BN6PR11MB4129.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Al1L51WIEkw9ItBqdDEX0NvPnLcok+F/DlFPaihqfP5x8Ci1N5V/G3OZrRTFVNoKWrFWkPAdP09r9SPIF5QT5iyVcqtqtjyK1N5lAevomsTXaeQ3qLqd5hywTYuwRVPRgktJEiHU7MuBKG84YtqzOGv8j7JbLyTd5NTbNyggXLr8ruUr1PrOX8efRdL93cryRU/KQbh3iCi5l24M26aMIr9vaOkjVT9Bztj1u4AM9u4vAymP3vrEE3hYiv5+SW8fSckH4HXCsUDna7fCcMtLiPnAgtSqrn9CJpVwPpRBPu+x3FMgIRPEQLVdtaWlvkM3F2OEbBdERptlvO91i3faOyub/5NAkmDUhCCh70F9jembquCWu3PrrKbfvh5/lYPSj9P7vBDpJ/ufi/aiaGKmcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4082.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(2616005)(36756003)(6486002)(478600001)(186003)(83380400001)(3480700007)(86362001)(26005)(7116003)(8936002)(966005)(6506007)(8676002)(71200400001)(6916009)(66446008)(66946007)(64756008)(66556008)(66476007)(15650500001)(91956017)(316002)(76116006)(6512007)(33656002)(5660300002)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: iBcf3awd5aDpYqDosWcbZxz/YrlodjKqNtrMazNbLTiMjveH7Ht3V/cdTXSyeW5n24aPFG4M7mWd1keC8MWXohWOqm4PA+yA64CkeJt7tgGxn039VB1IHY4erVWcCULekguaamxwMjTeqqdzocyOm6S1ZQT3N0HLhQRMSlPDwLpjbVO4+L0PqgAPBakDWbLeULPnyFYqEizY4Uk/A1GIzgLph+q+Hn7iEoG2N/uYB6uJCeOndsAw8KAoOEv4R/SojQ2ys4lKVun6JTebTOmv9PLbBCvhpYhU/xFvlXnfYpqstpOWCbp7DH1TSNODckG1mZKACIWfzVipcmE4H2xCkMvDYHDUDUOsnGWBfylpL0KSi8aA54R8T0cV3q7YNZwhiBlcJewgaCyRHftdiQtyEFgx0IO1hllCHqbNdG7RFjdZimMax1+X4ErpYt0F0qt4y0aagjQQKND2Qotx0yGO4DjbOqZGcNct51fnNsTzCkw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <15B3B12DBA5233479E333EDCC0C112D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f50adc-982c-4e29-24fc-08d802402106
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 13:16:12.7418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWn0g9M0TPn0KqIz5/4JMzzs0KJZhyPdwBLiBuAut/JClH+i52aOPJcEV2QCqxIdwvnD2L8vaA/4pZhdyc5nnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4129
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.14, xch-aln-004.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhlIEJsdWV0b290aCBJbXBlcnNvbmF0aW9uIEF0dGFja3MgKEJJQVMpIFNlY3VyaXR5IHZ1bG5l
cmFiaWxpdHkgc2VlbXMgdG8gYmUgYWZmZWN0aW5nIG1vc3Qgc3RhbmRhcmRzIGNvbXBsaWFudCBi
bHVldG9vdGggZGV2aWNlcy4gQmx1ZXRvb3RoIFNJRyBoYXMgYSBmZXcgcmVjb21tZW5kYXRpb25z
IG9uIHdoYXQgdG8gZG8gaGVyZToNCmh0dHBzOi8vd3d3LmJsdWV0b290aC5jb20vbGVhcm4tYWJv
dXQtYmx1ZXRvb3RoL2JsdWV0b290aC10ZWNobm9sb2d5L2JsdWV0b290aC1zZWN1cml0eS9iaWFz
LXZ1bG5lcmFiaWxpdHkvDQoNCkFzIGZhciBhcyBJIHVuZGVyc3RhbmQsIHRoZSBrZXJuZWwgaXMg
bm90IHZ1bG5lcmFibGUgdG8gdGhlIEtleSBOZWdvdGlhdGlvbi1hdHRhY2suIEJ1dCBhcmUgYW55
IG9mIHRoZSBvdGhlciByZWNvbW1lbmRhdGlvbnMgdGhhdCBhcmUgbGlzdGVkIGltcGxlbWVudGVk
IGluIGJsdWV6Pw0KDQpUaGFua3MsDQpQZXIgV2FhZ8O4
