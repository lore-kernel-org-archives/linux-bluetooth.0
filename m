Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534D374178
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772010461; cv=fail; b=g2IwMnn4qsYdYsB0dnzt83GqAlDxdBtGS/mBSzOf5bb5XtFYlnyZz6SowJ/+NxnGrc43N116MixOkW3ezQBmDpXdSwCmIGUExBf7os5GIWS7JzVsqYlbHWDnyQjP2irwZU/wedMKMzccuOHUqaRPwtMH5ccT3WptSqMQY9t/QVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772010461; c=relaxed/simple;
	bh=NMc3wsfmaXks259AIrh/qt+NzAq8XfIJ83dSG9RxWEo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HDGWd0knqdUDdZXTJNCFpbAm00z5yrp0qiKmufaDmczajCHLXxaNSFKI7hGHbZSjCdplplurXjuNVhvsFVUWA+YcCVWcQVk6+HbgzlJ+9mBWSQw1c8thJK1Uo4v7gpbBtUxRRt4GU7SZ0kuWMjCOXwjWoLHPM6nm5LTkesV6j6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=volvo.com; spf=fail smtp.mailfrom=volvo.com; dkim=pass (1024-bit key) header.d=volvo.com header.i=@volvo.com header.b=GIiJrYHu; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=volvo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=volvo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=volvo.com header.i=@volvo.com header.b="GIiJrYHu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v41q3DTECXWWzdYfT6ZBQy8eqaH/rk41J6ydgpBrLCLAmi3vEtwUS1qClwxXRNecx4Aw9TmLR+yTYxHZ/yQvJu3+ZSXHuRi9UF1/GWZpIQTJKwWIref7MQfoG3MTGvlETQbvWKo6PTX1VpImDxdoWE4OVGkJOSuZdnM6BK/lizhyP1NwZ+aGtB/wtDGaZzrewUjpjOqXdbkmW0q/jnrX9ZdvRMAlDFp4jsA4pU8FhAgUTUS2tBTj6EFWRxOQyAfhvV8VwRlPPhCunNa0dvm5tqpjtrJmDCChi4IOBS9oLu7CxZItu06nfGv+LqIc+VpHU4pzrskdo83aNhCm8iJ1cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5IbKJ1vLxavwURP2aZxhUg6WK7CUmUo8R9bzXEaquw=;
 b=poolwUCg/9zhoNl3D6539GH3fqRToQN/F9pSGFD9uLAif5wEF6BEe8zn0ES+vap2EO+OxcWZ+L+ByncsrclYAOW/Az2LIIoQr1yFZt4HlmreY6XDVUajy4zEbPlLaDM7XCN2gQoWlc/Ld4MARQOIGOhEFKB1M2NKAef1V/81ymuuTuqg5bm4zbt2yv7fUF1H+GvWViu14q2kPR2Z7lTd+zstYdNc6/Txdt6O4iKvm+4Z+D6N2qeA4onjLP+ZGnHTQr61ipmg+eKp6vy/1djIdFX6wZ2XDI5F+00lOgPhCwRp9hEyWsBSmKGXJJtzcbGG84Oo2XSccT7yZ14n+n/D6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volvo.com; dmarc=pass action=none header.from=volvo.com;
 dkim=pass header.d=volvo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=volvo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5IbKJ1vLxavwURP2aZxhUg6WK7CUmUo8R9bzXEaquw=;
 b=GIiJrYHuSpfUPjOF0J5q/03tOp44YRJWM7zMrdYNeRg5mPX224Pgt+zjP1PXW1AappyL95XAxaHQakohR2GoNj4BuChcrYMutN4lMiXadUoeg7sW4JITwwmzSggWV+mwdMVI2GTl4ZXBwuoi57WDD9QJ3J1BRlRZ/7dADMlDgG8=
Received: from AM7PR05MB6790.eurprd05.prod.outlook.com (2603:10a6:20b:13f::20)
 by AS4PR05MB9669.eurprd05.prod.outlook.com (2603:10a6:20b:4cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 09:07:32 +0000
Received: from AM7PR05MB6790.eurprd05.prod.outlook.com
 ([fe80::37f7:d824:94d1:cdf2]) by AM7PR05MB6790.eurprd05.prod.outlook.com
 ([fe80::37f7:d824:94d1:cdf2%2]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:07:32 +0000
From: Dajid Morel <dajid.morel@volvo.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Increase LE connection timeout for industrial
 sensors
Thread-Topic: [PATCH] Bluetooth: Increase LE connection timeout for industrial
 sensors
Thread-Index: AQHcpjXVT+W9IbPTN0aOERCOoK0qUA==
Date: Wed, 25 Feb 2026 09:07:32 +0000
Message-ID:
 <AM7PR05MB679030C679B87FCDEF903CAAEC75A@AM7PR05MB6790.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_Enabled=True;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_SiteId=f25493ae-1c98-41d7-8a33-0be75f5fe603;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_SetDate=2026-02-25T09:07:32.101Z;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_Name=Open;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_ContentBits=1;MSIP_Label_bd2ff15f-6ce8-47f3-93ce-f81f88196d24_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volvo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR05MB6790:EE_|AS4PR05MB9669:EE_
x-ms-office365-filtering-correlation-id: efc2c7c3-1b34-4ffb-00cd-08de744d4f40
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 IRa84tEzrK/LKrKPlgvrhSekdg+G/R/5qWKhYakASp9DhJsgso2u7YgRrGpxo3tz4fUlDy/Q8KGpnAhE0xWYWj8qSuuXtoAcGdw+Zwssbu8twOAPHM0fh+G2MaIW0JeDMu/L+ykv3yYzFiSVAMVtcgC2iDGbaAhHQicj/MrWNbib9E5tmwP0kPgxek5b0AgujUMwPgr8NiiiDAiH2uU3fPWGlTV1dB4arOJYvGrjthMMJp6vdVWRiDKn0YVpqq2oECT9uMLZOVsJpWJaoFkKXKQZ7yFYJ/t7+xrxsWpjnF5NOn9AzosCWhH/6Tf0/093FdppKQSVy28SDXw7gaew9RoiiXFnEvxdE7YfmOhCiaudKE9S61Nx+zRP/gfV4vdJyRd8W34+ZUzmQN5sZ/IO5WuZQ4PTlLGc5GxvNkGY7u7lrSvOBLPO5EwF6ahogpl30JU2glJ4x5zGiFb7AFp3WssHS5sTDoA3ePEMRArvTG/YlaCW6FD0l0dAEu5AJgsqx73kUANcdALfLT3bxcW17MVjg45Htt0SZJTY9Lsm8AWaX8IY+WdRoEbOtZoZyLo+SPG8blWL6d9PuaKYYfBdHtvil/0m8BDmzV5NnFnOvJIftOlpctREIcRbXnLeU4ql30DufKpmEg1nZcsXcoPZneyp21r7XRPlB0xr9KfPuovyN2Fv55UPyXnDtglHKt95CgV/ZsuUwyQkT12kQb92foYu1L0Bx833AoCph4ZlDGJlTvOZJB2aEQ7DW+mAJN9PpWkME9+fHhWff2eVTcR7P0k3HzGKeMC4JKYRlfnwdXM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6790.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ys++EB2wKBYO0SecoHb1HmPJd7ikSgjDzXslfc311euBXUdKwgbWf4p1Bv?=
 =?iso-8859-1?Q?vKG41orjN3X3jv/a4EZwfEscd/8sOUvMtdUU5YJqQ2PMVJ+T10abxUhDIu?=
 =?iso-8859-1?Q?4mCRvT0lfX33HoqKAoaKKsfHGQGi7lyM/iFTrFsNZxuQSHdqVLgrDr9W0i?=
 =?iso-8859-1?Q?Bjl01LRbBDRo7jjnzOq99Fc5pgmyJfpwDPKLSpysjtdH07z8O0GEdMORKV?=
 =?iso-8859-1?Q?Fgfj5JmNUL2g4Bwyy5WsZMv2/ncG7V2RxDYWZazLtFXhnokcw+ZcnOb7h9?=
 =?iso-8859-1?Q?PmT9vpwKhibtRm/ntdIMKubfc77ELjG5eal0sGDq9SljSPWpLQpjR9hHUj?=
 =?iso-8859-1?Q?qmrO0A2PFvlKs9zwa8wzpk3Pi3a+ce++Ecbtiddx0LOm6cOzO1uv34ehs/?=
 =?iso-8859-1?Q?wVaiaHkh9ElrlSXQ9CA6Dw8/zaPh2/v9pwCirrfBp6m+6zqIHIv3YZxeLC?=
 =?iso-8859-1?Q?sR7pq0yYrji0DaejR8iFtZkYGZF5e6hYdk4ZNfCKp5XXxHLTVbth4J/+Nq?=
 =?iso-8859-1?Q?JNPzj6Z3ra3IKFTpSU0R11Mde8PosgGRTN1J18JqakQohcNkXPhxRl4GE+?=
 =?iso-8859-1?Q?eFbvwEE+tYSx8JM4x3w/DBHheEyl+p62SkzuFGj6E5WWqh1NSZSXakEzxw?=
 =?iso-8859-1?Q?29wGNYkxyse/FZzL0I6NfPwRf1F8gfBnqgrfdTCxzFd2HcBF/QCfYtqNIu?=
 =?iso-8859-1?Q?OFWSTZAlTwVbPFt05Sspf5KYFAqXtaYNZxPhA0itdDQIe/OiP9L6AfYJwE?=
 =?iso-8859-1?Q?X6UrmX+brx1QM4S5zz2F5W699LlsthlOurzmuhTL2JBBEStHrjHnU7mLDP?=
 =?iso-8859-1?Q?JUOxQoIBhx4wFPTlwk3W/Pi+hBXpVFSLvqjZ/TF72P0s2dX/FvxedJLYmW?=
 =?iso-8859-1?Q?e5k/88qRSDbJA9a5e7GXRXYoyjPYiovtsRfIbqsdz9uZChjJJovm6AhX9L?=
 =?iso-8859-1?Q?vBy3b2Z2odiJR+aS5tIls0HWwIZHK5BelHMp30KDm/vWaiNT9ByOJruhDK?=
 =?iso-8859-1?Q?oEB9Bp14xCHgW/jIet7PtUZaLMdSvDjSk+kYPh8TjVP+6ZX42FhhF4Tpoh?=
 =?iso-8859-1?Q?xIcA2jwrAKMQ2oYlHCja4fgFvo5x/aeU4H1ZoxBs6H1rJIGS4DFgsPU12I?=
 =?iso-8859-1?Q?0PnvK5V5ZlaLM4r3s4rr3W0CPtjdTTUfk5a6lm3O3dEWqa2cnM01auICbR?=
 =?iso-8859-1?Q?SdKiFRxfTLIsw8Jx8s00IW/oaHDUoZH5gYePSgskgMk7smuAKih5mmyTOj?=
 =?iso-8859-1?Q?Y19tkxz7I77PCbgAP36cuFlmSNe62wi0V/mkHqHfiPW5FIbl+RiICQLFKs?=
 =?iso-8859-1?Q?v419qhMKOyqn7Ae04kZWuWmpMC3PpvqXdA7CjHNrmlbwZ0y24t7Ziu1fRK?=
 =?iso-8859-1?Q?Y0BM0jklXleLPE5ZECaLBGAQssbkjILg7cC6R5r2F0DEZS//2udOS1MF9S?=
 =?iso-8859-1?Q?nyq+UvOtu+ynTf76Nmtxdue55ExtyiwAiAqanKQMU6fuJVpUUO9sob4Wmr?=
 =?iso-8859-1?Q?1JosxWYVgVBV/hK+6KZYLLaCWB5Csl2lsCExOQDrJO3hRg4MbQUD1Eeud1?=
 =?iso-8859-1?Q?uJhC/nTsx9z7MNQe3KESoGZOkrMadj57l0vbrIwajeWxW9m3MHmM1IHGFV?=
 =?iso-8859-1?Q?8S3XyV+pmnj1Na3W5wsLr21n14x+8ugYrHccf3EO0xxEQWMLNi++tW0udg?=
 =?iso-8859-1?Q?1sI2gyrC2W1gSigYkD/JNDm+snhhhAh2M5/b+w2lz0OMoQUHmjYyjkdXDQ?=
 =?iso-8859-1?Q?GwNI+6WTugobdrWHJrO23N1qKxldHe1UGOKiPp4crG7Vi3gd2vlCqJY9sN?=
 =?iso-8859-1?Q?Ft1T1Xk+1g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: volvo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR05MB6790.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc2c7c3-1b34-4ffb-00cd-08de744d4f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 09:07:32.3904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f25493ae-1c98-41d7-8a33-0be75f5fe603
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8edw4Hiv5wNmcDNBmBgR0zJiOkHj3iJtEMqerx0rwWPPSma4NARg4e5dYLU5oEwVGH1UkbXmOlLciLfs3750Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR05MB9669

From 7945e077525b9ddcbbfd2d4f7251c6f669f7cccb Mon Sep 17 00:00:00 2001

From: Dajid Morel <dajid.morel@volvo.com>

Date: Tue, 24 Feb 2026 22:10:35 +0100

Subject: [PATCH] Bluetooth: Increase LE connection timeout for industrial

 sensors



Signed-off-by: Dajid Morel <dajid.morel@volvo.com>

---

 net/bluetooth/hci_conn.c | 4 ++--

 1 file changed, 2 insertions(+), 2 deletions(-)



diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c

index d177b7f49..8aeed0962 100644

--- a/net/bluetooth/hci_conn.c

+++ b/net/bluetooth/hci_conn.c

@@ -1131,7 +1131,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev,=
 bdaddr_t *dst,



  conn->dst_type =3D dst_type;

  conn->sec_level =3D BT_SECURITY_LOW;

- conn->conn_timeout =3D conn_timeout;

+ conn->conn_timeout =3D msecs_to_jiffies(20000);



  hci_req_init(&req, hdev);



@@ -1301,7 +1301,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *=
hdev, bdaddr_t *dst,

  conn->dst_type =3D dst_type;

  conn->sec_level =3D BT_SECURITY_LOW;

  conn->pending_sec_level =3D sec_level;

- conn->conn_timeout =3D conn_timeout;

+ conn->conn_timeout =3D msecs_to_jiffies(20000);

  conn->conn_reason =3D conn_reason;



  hci_update_background_scan(hdev);

--

2.34.1

This email message (including its attachments) is confidential and may cont=
ain privileged information and is intended solely for the use of the indivi=
dual and/or entity to whom it is addressed. If you are not the intended rec=
ipient of this e-mail you may not disseminate, distribute or copy this e-ma=
il (including its attachments), or any part thereof. If this e-mail is rece=
ived in error, please notify the sender immediately by return e-mail and ma=
ke sure that this e-mail (including its attachments), and all copies thereo=
f, are immediately deleted from your system. Please further note that when =
you communicate with us via email or visit our website we process your pers=
onal data. See our privacy policy for more information about how we process=
 it: https://www.volvogroup.com/en-en/privacy.html
