Return-Path: <SRS0=eb2H=PR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E073DC43612
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 15:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE302070B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Jan 2019 15:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cPP3OnnP";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Q5wXqVKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfAIPEC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Jan 2019 10:04:02 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54766 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731751AbfAIPEB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Jan 2019 10:04:01 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x09EkNCF025646
        for <linux-bluetooth@vger.kernel.org>; Wed, 9 Jan 2019 07:04:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=C166CZFA7mRQpsWEVuPMFieJPliLj6377Y/zM0KADbc=;
 b=cPP3OnnPTCMU+ljdNT8ClvTwDDT74h467LrxTDQhL90VaKY0H6lriFv5bkFHrfXbiv9g
 OwfI4nyV2R2QFhgf6CYITCXxUo+Zd9ioLco3ppUO1eXNfcW2A1JQL0IZWopd1t2xZ5qv
 +PXf0SHAwXW/2WhZAuSbvC8sXEg6NcVM86WeGyciSTGMRPdeWxkWPUPygEiZnq2bNmxJ
 zqenXffAgmtUG0+Tk/8YV4m45btP44RT1aaRd3tcf7eZSrf9VhlVGQKtbzfiDdb4eyQc
 0gligW5pkbxzpIItFifbhtTE+kPLzs6YHK2Axr2RKvu70CCRrrhdunJ0Nw+jgNxxJA13 Xw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2pvwjq5m7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jan 2019 07:04:00 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 9 Jan
 2019 07:03:59 -0800
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.57) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 9 Jan 2019 07:03:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C166CZFA7mRQpsWEVuPMFieJPliLj6377Y/zM0KADbc=;
 b=Q5wXqVKy7NUBZcMyQgHUmf+gXYvCFlbJ0Q59oylzXs60VFsifjhRJvZhmu30NtGlwBn/QRdP2IgzKaevezkec7uBBST0Gmtcy3e5lPfOi7yKPeL4ncJI5G1MjtrR73cpwoBQOYD3jdWaH8BzLOBgjMumEJwQ6WQCpJDdrFdEShQ=
Received: from CY4PR18MB1237.namprd18.prod.outlook.com (10.172.176.7) by
 CY4PR18MB1061.namprd18.prod.outlook.com (10.173.183.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 9 Jan 2019 15:03:58 +0000
Received: from CY4PR18MB1237.namprd18.prod.outlook.com
 ([fe80::95d4:8a68:81d7:87c5]) by CY4PR18MB1237.namprd18.prod.outlook.com
 ([fe80::95d4:8a68:81d7:87c5%8]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 15:03:57 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Rahul Tank <rahult@marvell.com>
Subject: [PATCH] bluetooth: btmrvl_sdio: add support for sd8977 chipset
Thread-Topic: [PATCH] bluetooth: btmrvl_sdio: add support for sd8977 chipset
Thread-Index: AdSoLIisF52s4F6bS8yE2vNp34CzNA==
Date:   Wed, 9 Jan 2019 15:03:57 +0000
Message-ID: <CY4PR18MB1237FAFE56DFCADE0DB09FC1A08B0@CY4PR18MB1237.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.17.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR18MB1061;20:zm25rBN9UbGDUQY2gbSWmXnfU5tlD/6qKrDfVqyJr8/xoHOjYnkAxMO03UXXVFMW911G/JPc3VAWVq+cb7kbBFl8AhtpgGOUj+07FXo1SSztV6G0Uqr04MsBGJTcjmEnVARc4cj+D9dmu+KSkQixPjFHvukBQP1huLoGgr/E3Z8=
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(39860400002)(136003)(189003)(199004)(7736002)(78486014)(7696005)(305945005)(26005)(71190400001)(71200400001)(6916009)(316002)(54906003)(99286004)(8676002)(81156014)(81166006)(8936002)(476003)(86362001)(575784001)(2501003)(74316002)(6116002)(5660300001)(33656002)(3846002)(106356001)(5640700003)(14454004)(2906002)(102836004)(186003)(25786009)(68736007)(105586002)(486006)(2351001)(55016002)(478600001)(66066001)(55236004)(6506007)(4326008)(256004)(53936002)(107886003)(97736004)(6436002)(9686003)(16843485002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR18MB1061;H:CY4PR18MB1237.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: f2cf3ceb-b579-4c5f-5165-08d67643ae08
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:CY4PR18MB1061;
x-ms-traffictypediagnostic: CY4PR18MB1061:
x-microsoft-antispam-prvs: <CY4PR18MB1061B6CD26F121FF00386589A08B0@CY4PR18MB1061.namprd18.prod.outlook.com>
x-forefront-prvs: 0912297777
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JXqmM3B+3XCIdC2Ct3zjOo3C+0oqY0LGj/W/kc3ME2RiNPmNjjM4c6GAHhPv3LuAtWea6plehgXrwxYDdufJlCLMwRnzPz1+YIaphUZE6KnB0YYMuuvRyODGOcaHjysmDIEQKxSPcJlqpA3k/R/E7E7BA+4VMxhpEj58Jbw3Ea9+YTYWtwRBW1FSxQPLfphMLh4ch1a1wJFoINr08Vc7VDbCBK7u8UEBmfGvZenUFOI/YAtB1sF/QwbQitgwc/9HlNQx3V2H3KlerdEpTGEOjITzhGkzSySb8HkQNyEPfr/c/BkEEpX1+iUAAokwWOTc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cf3ceb-b579-4c5f-5165-08d67643ae08
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 15:03:57.3233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1061
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090125
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From 6591fb4e6bbac53a9b3b852a2a4160c8de315d97 Mon Sep 17 00:00:00 2001
From: Hemantkumar Suthar <shemant@marvell.com>

This patch adds support for 8977 chipset to mwifiex with SDIO
interface. Register offsets and supported feature flags are
updated. Firmware image used will be mrvl/sd8977_uapsta.bin.

Signed-off-by: Hemantkumar Suthar <shemant@marvell.com>
Signed-off-by: Rakesh Parmar <rakeshp@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 drivers/bluetooth/Kconfig       |  4 ++--
 drivers/bluetooth/btmrvl_sdio.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 845b031..7b2e76e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -336,7 +336,7 @@ config BT_MRVL
 	  The core driver to support Marvell Bluetooth devices.
=20
 	  This driver is required if you want to support
-	  Marvell Bluetooth devices, such as 8688/8787/8797/8887/8897/8997.
+	  Marvell Bluetooth devices, such as 8688/8787/8797/8887/8897/8977/8997.
=20
 	  Say Y here to compile Marvell Bluetooth driver
 	  into the kernel or say M to compile it as module.
@@ -350,7 +350,7 @@ config BT_MRVL_SDIO
 	  The driver for Marvell Bluetooth chipsets with SDIO interface.
=20
 	  This driver is required if you want to use Marvell Bluetooth
-	  devices with SDIO interface. Currently SD8688/SD8787/SD8797/SD8887/SD88=
97/SD8997
+	  devices with SDIO interface. Currently SD8688/SD8787/SD8797/SD8887/SD88=
97/SD8977/SD8997
 	  chipsets are supported.
=20
 	  Say Y here to compile support for Marvell BT-over-SDIO driver
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdi=
o.c
index fb3d039..b2712a5 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -211,6 +211,29 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 	.fw_dump_end =3D 0xea,
 };
=20
+static const struct btmrvl_sdio_card_reg btmrvl_reg_8977 =3D {
+	.cfg =3D 0x00,
+	.host_int_mask =3D 0x08,
+	.host_intstatus =3D 0x0c,
+	.card_status =3D 0x5c,
+	.sq_read_base_addr_a0 =3D 0xf8,
+	.sq_read_base_addr_a1 =3D 0xf9,
+	.card_revision =3D 0xc8,
+	.card_fw_status0 =3D 0xe8,
+	.card_fw_status1 =3D 0xe9,
+	.card_rx_len =3D 0xea,
+	.card_rx_unit =3D 0xeb,
+	.io_port_0 =3D 0xe4,
+	.io_port_1 =3D 0xe5,
+	.io_port_2 =3D 0xe6,
+	.int_read_to_clear =3D true,
+	.host_int_rsr =3D 0x04,
+	.card_misc_cfg =3D 0xD8,
+	.fw_dump_ctrl =3D 0xf0,
+	.fw_dump_start =3D 0xf1,
+	.fw_dump_end =3D 0xf8,
+};
+
 static const struct btmrvl_sdio_card_reg btmrvl_reg_8997 =3D {
 	.cfg =3D 0x00,
 	.host_int_mask =3D 0x08,
@@ -279,6 +302,15 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 	.supports_fw_dump =3D true,
 };
=20
+static const struct btmrvl_sdio_device btmrvl_sdio_sd8977 =3D {
+	.helper         =3D NULL,
+	.firmware       =3D "mrvl/sd8977_uapsta.bin",
+	.reg            =3D &btmrvl_reg_8977,
+	.support_pscan_win_report =3D true,
+	.sd_blksz_fw_dl =3D 256,
+	.supports_fw_dump =3D true,
+};
+
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8997 =3D {
 	.helper         =3D NULL,
 	.firmware       =3D "mrvl/sd8997_uapsta.bin",
@@ -307,6 +339,9 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 	/* Marvell SD8897 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912E),
 			.driver_data =3D (unsigned long)&btmrvl_sdio_sd8897 },
+	/* Marvell SD8977 Bluetooth device */
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9146),
+			.driver_data =3D (unsigned long)&btmrvl_sdio_sd8977 },
 	/* Marvell SD8997 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9142),
 			.driver_data =3D (unsigned long)&btmrvl_sdio_sd8997 },
@@ -1760,4 +1795,5 @@ static void __exit btmrvl_sdio_exit_module(void)
 MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8887_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
+MODULE_FIRMWARE("mrvl/sd8977_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8997_uapsta.bin");
--=20
1.9.1

