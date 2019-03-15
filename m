Return-Path: <SRS0=yo6A=RS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C3AC10F06
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Mar 2019 03:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EB721873
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Mar 2019 03:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BkeDYU8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCODRd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:17:33 -0400
Received: from mail-eopbgr50054.outbound.protection.outlook.com ([40.107.5.54]:44547
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfCODRd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Mar 2019 23:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KloDH9AmzpNITSB1stLZjk/AoMxCSYhJfSZU9MPw0X8=;
 b=BkeDYU8b+alq3XsYUL2uVDZshOrDEmGTkVTsz7QN4PiSvLZwWNlrrWHDDRbY1IyAmHPSaf4Q1O7fcLgUEWuvVWx8frixYr/nnsI5ATn6F8+nu+befvCdDU1VKHO7O6Q6+iLFyPqonrcat39maLLPKaGDvlLpOeQwqJjDl4BMwKs=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3534.eurprd04.prod.outlook.com (52.134.4.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 15 Mar 2019 03:17:29 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::d572:5bb9:4021:1f69]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::d572:5bb9:4021:1f69%4]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 03:17:28 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
Subject: [PATCH Bluetooth 1/1] Bluetooth: L2CAP: add return check for security
 level set
Thread-Topic: [PATCH Bluetooth 1/1] Bluetooth: L2CAP: add return check for
 security level set
Thread-Index: AQHU2t2ee6mCq6YSV0OHq3p6ZHO+bA==
Date:   Fri, 15 Mar 2019 03:17:28 +0000
Message-ID: <1552619793-29992-1-git-send-email-fugang.duan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:36::24) To VI1PR0402MB3600.eurprd04.prod.outlook.com
 (2603:10a6:803:a::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8409844e-cbb3-477f-3ba0-08d6a8f4c108
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3534;
x-ms-traffictypediagnostic: VI1PR0402MB3534:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3534;23:HtKZejHiRnosM79pRp+nwr3VhRhrI0c+Rwmis?=
 =?iso-8859-1?Q?ec7Xl8lfdt/qvAhoEPD6wUjQ06ZKIWTPUGvfJokGEu6g9H6cOUH8vlc0/F?=
 =?iso-8859-1?Q?oSkPbIzymmDIzoGe1fxVDv1jtv6utF1J4LvBLE74n4PyP8PvdIF+WGrbqj?=
 =?iso-8859-1?Q?4cfY1pOj1EAiKrjdzYT3Ew2lkmFDVBZUqXrOXOy9b9tuHNoj0BFdnixiJM?=
 =?iso-8859-1?Q?sL1gEZ+IPjSM7FgcSOn2u83wC3hKgE/IQw4vLh6FfyU39WZ8HADwlg+B7g?=
 =?iso-8859-1?Q?mUsNAHIeuCC1J6Os68RG4yOjVsG37ghMlfiogi88+4+UvMUs3wzM385Xqe?=
 =?iso-8859-1?Q?HBtN3Xcq7b5Ab/1HWtXRpOIJaG2baQIgYDdZ0Ebpgo2VBG7ET4EIpAxVw8?=
 =?iso-8859-1?Q?PUWSgagB55BpeyRuuD3r+xxO2cSwua0J+rcVKTvBZDBC2TMJ03P2Mk3oMn?=
 =?iso-8859-1?Q?M+YSvb9g4WJC2B3fur+UAwKystzxroEg+rfG82k7AxQ6grcdzG47nL5dRJ?=
 =?iso-8859-1?Q?WKWdiwzmMa8V251YJ7a4hnqT0E7QytIx7c/bxL6eDRC9lAWb6Ng56laNwM?=
 =?iso-8859-1?Q?6txc2HU9sX37g4xwAEQIqmAWU+G0BLe9h3FMAsjIiac6PEKenGHMBSDS4Y?=
 =?iso-8859-1?Q?oG4yH6IAbLOlXcY49ivktDI5foVZrWREIsb7NNDgU5tvy1SMrxdLJ/QEbO?=
 =?iso-8859-1?Q?2i570C7dydp5GzEPPMrb5R34OirCs6Ve0boPSAnn7n34xrVbHauy+Hq458?=
 =?iso-8859-1?Q?Rjh1IKPdL3iqrXEVUZhDLVZpM1+kHQbB/YKJouRWn/Eo35k9xHSm1zOX+n?=
 =?iso-8859-1?Q?z9jXPMahlKPSgf5w76EFF+ozoSTGvSDgGkR9H2driJFM+4qUJDPm8aKjIU?=
 =?iso-8859-1?Q?whgkVOd1fR4iZUcLinoFsVhwD4AFOIbLspWlKbE0vyh47FPT2UGlVxF67U?=
 =?iso-8859-1?Q?7O0ry8cE3WHkbN4ficS6Qb/hKOhQRr1SAkK7NM6b2jdkvCpZiemjH3NGqc?=
 =?iso-8859-1?Q?DtH/1aXgK4o2LBm+vvWr1NelCTIFJnvtup/vbhM6M18xrbh6iXPlixXAt3?=
 =?iso-8859-1?Q?pK8LtdbZ04YNRLZGxfLiKYemwbX6y2VlFw5uiMVztnZ6JmE5NTKMd2O/WC?=
 =?iso-8859-1?Q?GullyNfw4K+J3Z57OcDfYJDbL45FQ/mAkDeI+GfiQVHj8dM5Q/CzSs2mzC?=
 =?iso-8859-1?Q?383ezdbX0M8o4fc1ZJw5TT6HhIKvGvoWAQSd24Ia+at9VDlh4rSfa0I5Fl?=
 =?iso-8859-1?Q?uOBS1UKeI8KXwKA1sEf?=
x-microsoft-antispam-prvs: <VI1PR0402MB3534A9BF923B63F72F9FB7EDFF440@VI1PR0402MB3534.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(39860400002)(376002)(136003)(189003)(199004)(7736002)(52116002)(50226002)(6486002)(8936002)(2616005)(26005)(186003)(6512007)(102836004)(6506007)(14444005)(68736007)(97736004)(53936002)(386003)(81156014)(486006)(2501003)(6436002)(110136005)(54906003)(316002)(81166006)(4326008)(476003)(99286004)(5660300002)(66066001)(478600001)(3846002)(105586002)(256004)(14454004)(6116002)(25786009)(2906002)(305945005)(86362001)(71200400001)(8676002)(4744005)(36756003)(106356001)(15650500001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3534;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +3ItiC9bsEO23cUXH++fe4v5MN8RI8w+/QGS+MXyHHFu1H/Rr1bLS/DUCjY0TnK/46qZA+ligXXTVokI0PgxLeO+mZOfLpaLbMMOOsX3bBUQZ8fOuEeCNGqWV0oT3sxZH8LOPIun2GnVcC3fj9ypZZwnPSqG0TF++Iz/Uv0KKTaMD3FfCfSp1zyGWHGjJiv5Rl/KCz9i+AkHNVK8+1WpU/GrHPuG7TQAevCekLm+iaEq3PYm089CYamvpZpM6wnRbZE36slzO6Jx8J7snoO+f55uiIVbNMxweK83tYkqY7KXPlwTM4u+EjhvTRZ6xbhigggKzmKJajZ8xS9d862Mk6fHEoEkH5unhAXxfh3z66O2mzRn59tJ6Kxkia/0jWVz3/yawrhz2oPM8TdiSwWudOI+bNhsJuwGCl9SwiUphTk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8409844e-cbb3-477f-3ba0-08d6a8f4c108
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 03:17:28.8806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3534
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Fugang Duan" <fugang.duan@nxp.com>

Add return check for security level set for socket interface since
stack will check the return value.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 net/bluetooth/l2cap_sock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a3a2cd5..c71b97f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -793,8 +793,11 @@ static int l2cap_sock_setsockopt(struct socket *sock, =
int level, int optname,
=20
 		/*change security for LE channels */
 		if (chan->scid =3D=3D L2CAP_CID_ATT) {
-			if (smp_conn_security(conn->hcon, sec.level))
+			if (smp_conn_security(conn->hcon, sec.level)) {
+				err =3D -EINVAL;
 				break;
+			}
+
 			set_bit(FLAG_PENDING_SECURITY, &chan->flags);
 			sk->sk_state =3D BT_CONFIG;
 			chan->state =3D BT_CONFIG;
--=20
2.7.4

