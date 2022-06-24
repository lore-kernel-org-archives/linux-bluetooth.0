Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C119C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 22:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiFXWqe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 18:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXWqd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 18:46:33 -0400
Received: from mail2.multitech.com (spx.multitech.com [65.126.90.11])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A15F988958
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 15:46:32 -0700 (PDT)
Received: from mail2.multitech.com (localhost.localdomain [127.0.0.1])
        by localhost (Email Security Appliance) with SMTP id 2A42A585635_2B63EC8B;
        Fri, 24 Jun 2022 22:46:32 +0000 (GMT)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by mail2.multitech.com (Sophos Email Appliance) with ESMTPS id 071FB5854B6_2B63EC7F;
        Fri, 24 Jun 2022 22:46:31 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4A67Fk8DBWfMxMKITQbUkXGuBg7IH0iUlMeXABUW0pqCfliM/v9TNpvs1pKD3vdEJ6k0lYO+ly3jGeIyZkaiUADDHwDfZUT07dwk/cfEXmXo4eN1BR6zG55xxRwJFg4Z/kG/w2s3dYlPH1s/LPGIUEIwXY1ZjhKW0tjGxxr6SFESmpE9c2vBvl2ajTWcCc4YkKgHFn/TvfbmgGS4Ge8fG68DYC9TYYdmDqMm8TaqaxnZHok/vnUD9t1h5hEMI1MUdC80kM21OF7AAzwwVmY9q+x/ZrueHUh/3sMXLQWK1W0OlA8FNb2rOfkuTUBYiwd8evmxmcFv/QezpDFUGQjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEXaoJ1r+GWn3wjKrmdE1+IThM7F4B9l1ATfgBuVHcM=;
 b=eMNyOZVWrQFRxck3gOBkn6DT7zO6Jnf2pnT/bZEvut69iEQmioPYKuCOQeSSy4aIydx/Hq/Lq5tZcgO1dTehBIXSv+sTcZV7rzvOfRP/tJStjiTJmCwAIskPTvfnxkhFR2clFUDCrl50Id19+TaqGOCPstoEkSbiaXwuPFViniKawpZVqgQJ7ON9dr00TIMeZo6fzkLA9QY3XcT0Jk5pjidxmob7aBAhAJ3fc93B8QiwbcWR8sxXs8/S/eIsudF8Ty7aazcci/6dzhlfaQlNAo1YrB4HzEa4zB7YL4rzlOs3dJYklqC9dCoymrFYZV43auyQJIXlRgk7PxP/rFn2EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=multitech.com; dmarc=pass action=none
 header.from=multitech.com; dkim=pass header.d=multitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=multitechsystems.onmicrosoft.com;
 s=selector1-multitechsystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEXaoJ1r+GWn3wjKrmdE1+IThM7F4B9l1ATfgBuVHcM=;
 b=FmWowKTuhXa8Ms8SFARtPDO5C0WBjvHAuxWJ0+ESPO3wUb+AFuqI5yxQdDBdUmQe1niAjtrdJq9rWrwwk5+lRTk6GIzZ0CZncdSQRvQ82qG1trVKbU0bA8ZX9H50K4ppdHweTSQ67zMCcauXbckQ9S7LAF8Ed55afTdNMz73Efg=
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com (2603:10b6:a03:40e::15)
 by BYAPR13MB4534.namprd13.prod.outlook.com (2603:10b6:a03:9e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.13; Fri, 24 Jun
 2022 22:46:27 +0000
Received: from SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2]) by SJ0PR13MB5755.namprd13.prod.outlook.com
 ([fe80::980d:52c2:2f5d:f4b2%4]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 22:46:27 +0000
From:   John Klug <John.Klug@multitech.com>
To:     Linux-Bluetooth MailingList <linux-bluetooth@vger.kernel.org>
CC:     =?iso-8859-1?Q?S=F6nke_Huster?= <soenke.huster@eknoes.de>
Subject: Linux v5.4.199: Bluetooth: hci_event: Ignore multiple conn complete
 events
Thread-Topic: Linux v5.4.199: Bluetooth: hci_event: Ignore multiple conn
 complete events
Thread-Index: AQHYiBu/lxBEj9TcTUq0dO24+qwP/Q==
Date:   Fri, 24 Jun 2022 22:46:27 +0000
Message-ID: <SJ0PR13MB575532A88E75738299CB1636FEB49@SJ0PR13MB5755.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 79368306-afd7-3df4-d1e2-36c550309f2f
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=multitech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f46a3a1b-7edd-4499-b368-08da56335f88
x-ms-traffictypediagnostic: BYAPR13MB4534:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qpaEnXR1oxoB7UVogotREsRyZYTm3e9wE+d2gRMa7958bNCiKlVu/zOgHVf/zmbPfT0paKU6kzrjzlolFRmibXID/pWQvFwCidbKc5i0SAVMbi8ExB1ejgVVGtgRTMxY+KpM/skJpEjY8sXq3s7ifzILrEp0lB29P2kKwC3nu/BktJZSviwaTzwu2Yu/BDJdE2YmHJRYn3foyDDfd0uzwloaVvFDCv5x0VS1YNKdO0VQLEr45mGszEiqGO7Lro3u/SLle/odoRu/Q9Df0JAvAU8iA4okf5iEPW91jecAZdsUuDmSA/TDj12jsDgZoHXOB9OY890Sty4k/2MuB93amjsFZmy3gZhLXDUsRVTRmmy/qPZFcKli6Gqydr86m4rMKYW3przgpj9oItDgxWuhfJiFYYeVU8+4+qFWVq27/teSxF5cniLVntMttvkxxMyjQXxsOSIxdi2cyHCukHx+6s1xTDCOkV/GnLSyFunplkYhIV+olgZbwVJhUxPzu6RiDKoi06ZANGPFWPoAOJsCXCPNiBVwiZcqH/JRVNmPC5QpshMIEolFr5JEsvLU2n0fQRqZu9q0vkb8dyXgz5FMijT6D+wX0zkk88OqwldLtxDXHML6/U3HLO/PI/MMyL1hAW9HqdrR6E5luemn4fGX8o5bqJsBa+96LsmkBu/gHiLzbDslBgHz9ImPSNn5+OROrD9XY49z/qI98Ee+gWTsuusopjCSiP5f0GVhpATQls7qw70W6cpaprQJYFnCKEw5vod/Zo216B89gzjWHz0Sy0r5Ul6aUkDxJtGdjlghmGbYlkpboH6Zfam/BO899o+QGMLlTwy42m79FQwCAgdRucwiD/QqR752o1XxfIqhhM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR13MB5755.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39840400004)(346002)(396003)(136003)(376002)(478600001)(26005)(38100700002)(66556008)(86362001)(9686003)(33656002)(8936002)(91956017)(7696005)(5660300002)(52536014)(55016003)(6916009)(83380400001)(2906002)(186003)(8676002)(76116006)(4326008)(66476007)(38070700005)(71200400001)(53546011)(6506007)(66946007)(41300700001)(64756008)(66446008)(316002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Igw9KZ8bb0qBzkOHr+KcRbNkoJ4i73cEEfXIiKWhx0TFwWhqrq62zCArLl?=
 =?iso-8859-1?Q?RhvoiSzKzlgs4q3Lgir3kiM7BrCWvkhc38vDowv9Q2jrVNDBK52f4yZa9V?=
 =?iso-8859-1?Q?1+2hK/RImYxZWJpCw5uck3tRZ4R4YlSOp7tU9ENw1//NCTrFUGaE2LEqvt?=
 =?iso-8859-1?Q?Tg2mR6j1telJm6aZsgfjQTkLP+gXGepSxnUbiv1cmAPug0+1+G0Jh8/BoY?=
 =?iso-8859-1?Q?RpXt7h54T/hPILZ6BjwLqyNyfbSwZRiGg9MsIadDGLzTbepLRSgWEp0hgC?=
 =?iso-8859-1?Q?EvaHccEp7hnJ87L75KXEze6OqGFd5x08BIXAv7azI2MMjdGE9wWO2meyaC?=
 =?iso-8859-1?Q?UBYd/R7sScZb6r4ByOrp4s+xv4ERAGzqYNYCYCDWS7r/CHKkGNSSQZiwYe?=
 =?iso-8859-1?Q?ay8OQR8xWkpslCcrMp6dwn+/9ZgHVVkJnDPaOdImIbWxE1xg4luw/LzwGE?=
 =?iso-8859-1?Q?Jbm0EIHoyFvOrRi7ubyTT0rPkksH9arOGmxmvMU+pDHQJT3cm1CVQnk52D?=
 =?iso-8859-1?Q?V6pxRJ9mYvbsj1jHWvzVE0gWm1hpx9e4o6lXOkf78KhUeFn2r3Kl2FWDrH?=
 =?iso-8859-1?Q?Gn+HiVnoBueIWrjg1UVt98FtJQDPNjmKLGJ/16SSO2YKxGBvRivyFMOoyA?=
 =?iso-8859-1?Q?HjaOkTizZlREPMk+sonnESRWZ8BadtUo7HNdw8sX/ctCi1rgyaViznrqHa?=
 =?iso-8859-1?Q?uBHcMa8MMAn4oMEaCkVOn//3fRjm//Lchr0tBRH/KjaebEB6Q6uvPaymLa?=
 =?iso-8859-1?Q?vlcQbcvHpx+80HFGDmT2ZeROzinhnYGWyjEXYonddPzyz0X6N+YC4uQxxd?=
 =?iso-8859-1?Q?ss18yV+WPEXYPIrSlIhrvHGVgiDeRnUzjALnvdTGsm0o11To2ucDPWhNlj?=
 =?iso-8859-1?Q?doELnZMWn4XGHZJrjz728BEiy84SwmCvDbZ6cwZ5PxcAnIHhNuEguI7N16?=
 =?iso-8859-1?Q?Rd/MPsv4KrPEHkq6ITdbqGA0+5LOsz21zduY6e5TpwWOPs/xUynUzjMdx/?=
 =?iso-8859-1?Q?0kNWKAqcT3kNuTJ3VqtIakQv/DosoC55OiQugnmsjmbL9V4MBUfFyOvqEg?=
 =?iso-8859-1?Q?4eGFBTQ8jqeFEUIY6wnx8aEHt7ldyUkp9ywgjz0pdZNRUHPZnuTdMFls63?=
 =?iso-8859-1?Q?UrIxeoJTBL1vxZonL6OKWOfC75fIIr5stoFA+IW8/W6ZkvrrvjBEl5feop?=
 =?iso-8859-1?Q?7P8ItvGZ/cSV4dVGCtZltbHKgzWjDU/84QggvZRaULFqk+wTQSbHePM+My?=
 =?iso-8859-1?Q?SrhNyDeVpjPqEFaFmQhksQwOZTsdEr8SAqiw06iLtvGEU3otTUgHr203IQ?=
 =?iso-8859-1?Q?fYPndjLMWllY4AY0uQ6vH+uN6ZIMABO+MtemN+nZTA64GhUXt2Zn2CdnfU?=
 =?iso-8859-1?Q?FCM2wTPzfe2Gt1tzXLEtvc2hjx6oWGFroETqi99DPefihWevUfSSnOnRCf?=
 =?iso-8859-1?Q?ptBGNXsJ7tva2he9VzAGwsBJinb8KtCuuD7cuucAUEcd2MJRiiL17YT+in?=
 =?iso-8859-1?Q?hmRjhetwjJM/gIzrhFU+ICdmc0e4KjHMlDt/skHJ4fLDnXbqQaB4U212iO?=
 =?iso-8859-1?Q?NvzrtRzREhgQmPGroUHpEsZNiqJ7tmCOp2OdjX4MFSnidJ8+qtleLvQ7lv?=
 =?iso-8859-1?Q?I825Cs+u337xQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: multitech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5755.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46a3a1b-7edd-4499-b368-08da56335f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 22:46:27.1836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f802e804-804f-4d1e-b625-870b4d57fd00
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sO6QHDYRiA6+5Yhh6+lWtdU2ujxqQZLetACClarVvCi4UZPzYVeVzDk3InQcD/LxTdlLTb9cSdryQtNT1EA2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB4534
X-SASI-RCODE: 200
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch updated for the 5.4.199 kernel on Friday, 24 June 2022 by=0A=
John Klug <john.klug@multitech.com>=0A=
=0A=
From: Soenke Huster <soenke.huster@eknoes.de>=0A=
Date: Sun, 23 Jan 2022 15:06:24 +0100=0A=
Subject: Bluetooth: hci_event: Ignore multiple conn complete events=0A=
=0A=
When one of the three connection complete events is received multiple=0A=
times for the same handle, the device is registered multiple times which=0A=
leads to memory corruptions. Therefore, consequent events for a single=0A=
connection are ignored.=0A=
=0A=
The conn->state can hold different values, therefore HCI_CONN_HANDLE_UNSET=
=0A=
is introduced to identify new connections. To make sure the events do not=
=0A=
contain this or another invalid handle HCI_CONN_HANDLE_MAX and checks=0A=
are introduced.=0A=
=0A=
---=0A=
=A0include/net/bluetooth/hci_core.h | =A03 ++=0A=
=A0net/bluetooth/hci_conn.c =A0 =A0 =A0 =A0 | =A01 +=0A=
=A0net/bluetooth/hci_event.c =A0 =A0 =A0 =A0| 63 ++++++++++++++++++++++++++=
++++----------=0A=
=A03 files changed, 52 insertions(+), 15 deletions(-)=0A=
=0A=
diff -Naru a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_c=
ore.h=0A=
--- a/include/net/bluetooth/hci_core.h	2022-06-24 09:07:33.521766338 -0500=
=0A=
+++ b/include/net/bluetooth/hci_core.h	2022-06-24 09:16:20.317754010 -0500=
=0A=
@@ -193,6 +193,9 @@=0A=
=A0=0A=
=A0#define HCI_MAX_SHORT_NAME_LENGTH	10=0A=
=A0=0A=
+#define HCI_CONN_HANDLE_UNSET		0xffff=0A=
+#define HCI_CONN_HANDLE_MAX		0x0eff=0A=
+=0A=
=A0/* Min encryption key size to match with SMP */=0A=
=A0#define HCI_MIN_ENC_KEY_SIZE		7=0A=
=A0=0A=
diff -Naru a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c=0A=
--- a/net/bluetooth/hci_conn.c	2022-06-24 09:08:47.105764616 -0500=0A=
+++ b/net/bluetooth/hci_conn.c	2022-06-24 09:16:20.317754010 -0500=0A=
@@ -504,6 +504,7 @@=0A=
=A0=0A=
=A0	bacpy(&conn->dst, dst);=0A=
=A0	bacpy(&conn->src, &hdev->bdaddr);=0A=
+	conn->handle =3D HCI_CONN_HANDLE_UNSET;=0A=
=A0	conn->hdev =A0=3D hdev;=0A=
=A0	conn->type =A0=3D type;=0A=
=A0	conn->role =A0=3D role;=0A=
diff -Naru a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c=0A=
--- a/net/bluetooth/hci_event.c	2022-06-24 09:09:10.825764061 -0500=0A=
+++ b/net/bluetooth/hci_event.c	2022-06-24 09:19:52.017749056 -0500=0A=
@@ -2494,6 +2494,11 @@=0A=
=A0	struct hci_ev_conn_complete *ev =3D (void *) skb->data;=0A=
=A0	struct hci_conn *conn;=0A=
=A0=0A=
+	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {=0A=
+		BT_DBG("Ignoring HCI_Connection_Complete for invalid handle");=0A=
+		return;=0A=
+	}=0A=
+ =A0 =A0 =A0 =A0=0A=
=A0	BT_DBG("%s", hdev->name);=0A=
=A0=0A=
=A0	hci_dev_lock(hdev);=0A=
@@ -2510,6 +2515,17 @@=0A=
=A0		conn->type =3D SCO_LINK;=0A=
=A0	}=0A=
=A0=0A=
+	/* The HCI_Connection_Complete event is only sent once per connection.=0A=
+	 * Processing it more than once per connection can corrupt kernel memory.=
=0A=
+	 *=0A=
+	 * As the connection handle is set here for the first time, it indicates=
=0A=
+	 * whether the connection is already set up.=0A=
+	 */=0A=
+	if (conn->handle !=3D HCI_CONN_HANDLE_UNSET) {=0A=
+		BT_DBG("Ignoring HCI_Connection_Complete for existing connection");=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
=A0	if (!ev->status) {=0A=
=A0		conn->handle =3D __le16_to_cpu(ev->handle);=0A=
=A0=0A=
@@ -4177,6 +4193,11 @@=0A=
=A0	struct hci_ev_sync_conn_complete *ev =3D (void *) skb->data;=0A=
=A0	struct hci_conn *conn;=0A=
=A0=0A=
+	if (__le16_to_cpu(ev->handle) > HCI_CONN_HANDLE_MAX) {=0A=
+		BT_DBG("Ignoring HCI_Sync_Conn_Complete event for invalid handle");=0A=
+		return;=0A=
+	}=0A=
+=0A=
=A0	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);=0A=
=A0=0A=
=A0	hci_dev_lock(hdev);=0A=
@@ -4200,23 +4221,19 @@=0A=
=A0			goto unlock;=0A=
=A0	}=0A=
=A0=0A=
+	/* The HCI_Synchronous_Connection_Complete event is only sent once per co=
nnection.=0A=
+	 * Processing it more than once per connection can corrupt kernel memory.=
=0A=
+	 *=0A=
+	 * As the connection handle is set here for the first time, it indicates=
=0A=
+	 * whether the connection is already set up.=0A=
+	 */=0A=
+	if (conn->handle !=3D HCI_CONN_HANDLE_UNSET) {=0A=
+	 =A0 =A0BT_DBG("Ignoring HCI_Sync_Conn_Complete event for existing connec=
tion");=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
=A0	switch (ev->status) {=0A=
=A0	case 0x00:=0A=
-		/* The synchronous connection complete event should only be=0A=
-		 * sent once per new connection. Receiving a successful=0A=
-		 * complete event when the connection status is already=0A=
-		 * BT_CONNECTED means that the device is misbehaving and sent=0A=
-		 * multiple complete event packets for the same new connection.=0A=
-		 *=0A=
-		 * Registering the device more than once can corrupt kernel=0A=
-		 * memory, hence upon detecting this invalid event, we report=0A=
-		 * an error and ignore the packet.=0A=
-		 */=0A=
-		if (conn->state =3D=3D BT_CONNECTED) {=0A=
-			bt_dev_err(hdev, "Ignoring connect complete event for existing connecti=
on");=0A=
-			goto unlock;=0A=
-		}=0A=
-=0A=
=A0		conn->handle =3D __le16_to_cpu(ev->handle);=0A=
=A0		conn->state =A0=3D BT_CONNECTED;=0A=
=A0		conn->type =A0 =3D ev->link_type;=0A=
@@ -4985,6 +5002,11 @@=0A=
=A0	struct smp_irk *irk;=0A=
=A0	u8 addr_type;=0A=
=A0=0A=
+	if (handle > HCI_CONN_HANDLE_MAX) {=0A=
+		BT_DBG("Ignoring HCI_LE_Connection_Complete for invalid handle");=0A=
+		return;=0A=
+	}=0A=
+=0A=
=A0	hci_dev_lock(hdev);=0A=
=A0=0A=
=A0	/* All controllers implicitly stop advertising in the event of a=0A=
@@ -5026,6 +5048,17 @@=0A=
=A0		cancel_delayed_work(&conn->le_conn_timeout);=0A=
=A0	}=0A=
=A0=0A=
+	/* The HCI_LE_Connection_Complete event is only sent once per connection.=
=0A=
+	 * Processing it more than once per connection can corrupt kernel memory.=
=0A=
+	 *=0A=
+	 * As the connection handle is set here for the first time, it indicates=
=0A=
+	 * whether the connection is already set up.=0A=
+	 */=0A=
+	if (conn->handle !=3D HCI_CONN_HANDLE_UNSET) {=0A=
+		BT_DBG("Ignoring HCI_Connection_Complete for existing connection");=0A=
+		goto unlock;=0A=
+	}=0A=
+=0A=
=A0	le_conn_update_addr(conn, bdaddr, bdaddr_type, local_rpa);=0A=
=A0=0A=
=A0	/* Lookup the identity address from the stored connection=0A=
