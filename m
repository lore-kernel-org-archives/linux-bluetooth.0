Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093EE1E48F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446945; cv=fail; b=MI//kH+TtUF3HVuwJJ9roSKOrX1mv063Gez6vcoZjVX6+xvp1GjllEpUiY8Q3Rg+K8L7OLtkpnAUI/KPewIZvK3RmNgYq/lBvO1R/08vRNyY8lFw9WatgEyzl+C5r1kQN/Xs1jmhqzFbZfwroF3koNlytXJdf1oR9h/XF6gzUUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446945; c=relaxed/simple;
	bh=pHtphUKhakUBwl7tMbgGt8xZ9rzdOMi4KKYcABf2qtk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Jt9F3OIC+fuEo2k448VhWV8PfKJHnMY0yQFWGxyzxbHYAlqerp5QRaXXbtO/9LRVzvsnJXBMlH9fz+fmiqebgFrVkrq38NawO+B5T/Ux/Q43W9ud4PwXSBUi/yCBpwnxny6woZVVvB6KyfQE0WanStALJHgf3/QFkmwDNcmE1Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MbhhcJvk; arc=fail smtp.client-ip=40.107.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MbhhcJvk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlKT/J6oxWDIvHRICMj95fR9JkMTHKoty3clG8SnEI+3PnSFbp0+TH/JjGbbfKtACeZk1vY6eRA8Xn44CrpLnBpMd81VHBfrEkV2hMPDurfGLc1CQ07ZTsHzQ3+pKcQDJd7UG3obxIOH7ddlX/PMDqY7pwamdmvXT8cXiEb94okrqWFT4eypNvJrHLJr8rqJwkihq15ITkxMYYdS6uYGePkov1z4CCDcdzn/87mwdm3VBBb8TaySx6SoPNWQFzCml4EqHdlunJNyIFFfa3QploYfXS0cMF1cYVjlgjVCo+9FK/Q7e7CTBl7EO0K5NWxpTcHvzoLObuWtNj5TEjTheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gufB6O3w1wBLSZiYUfbhS5gbHtU4j4VXQ2nu0h6iZU=;
 b=ErFUxPP8Lh78kOqKLzGnfhS9PLv7CMVyy7H0Kwn4aZUdQA35XDTSLn0frnNGhyFfrsZ9qDPv9m3FVC4ITzS8oNDaEv/ZVcEIiU8yNTIMg9T7s84SIdbtxEJkX6FCr7vI8vLthlJ2S7+YVfJcJB9/H5Q9zcPgJyOgS2hIfTcx6sp5cbdpAAO53BkfTJLFDG7/NhXLqN4EXjyB1kWLgIACyYL/T4de98b6sL0E/xXQ+ptW97hQK8q3LAIQrvVbJydD/qIKYf1dLB7Mwg60OGC66zsLmNcuiq/DAsTpAEKUx0RbozcR4BY8n1DebYM3cj081/3XjcmudY6w6DyUlANsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gufB6O3w1wBLSZiYUfbhS5gbHtU4j4VXQ2nu0h6iZU=;
 b=MbhhcJvkYCsZsiRs4VZR/CCpLF2JSbz688Wt29S1EJPnPMNeOEjtVHzApUyS/UWxfatG7x1aWI4g2thU0JjwFiOVU7BP9dI2dNTxuCtWOxoSq96lpQYXfFrh/cp+utwOpudCacY95C1FgFDXEzwRcBr+gR+MPKsiY3hn6KJuNog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9433.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:35:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7292.029; Tue, 20 Feb 2024
 16:35:40 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [RFC] Bluetooth: ISO: Reassemble fragmented BASE
Date: Tue, 20 Feb 2024 18:35:31 +0200
Message-Id: <20240220163531.2900-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0002.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::9)
 To AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9433:EE_
X-MS-Office365-Filtering-Correlation-Id: e7255bc9-81f7-467a-6deb-08dc3231f983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RYOi1YNQjyrDhmoAouF94uF5+sgHe6zNL0YkRgVSPZWNSoUtA0Uhs0O6D2okeU4RJm9k3rKa2L0pSR49KtGccv0VBBsD5Lid61e6XkN/xNkABNeHoLo3c+BGXTtkeECrVOuN8U0d8CpjBzKr7YuGNuFFTR6+oPYhxbZifIX/W/dwYgqrcsG7MRy5U9cs0at81WUgbVMTJPZECjOQXikGPsaPJ5OP4+yC4ZMu07ZWghMETXRfghEHh3/1Xt24WmoyTxJwLnRX4Lw7I+BIhLAtKq8yTNwuqs7EruAT6ftn+sUw+tweunO/ADlxTwDcA3YQx4T/PWwmCqCljFzw4urLk4lI+eAFVdNseIeXvx9NiXsYvKC4l0fsLx+0KyALq2S60FkNut4zP0nKLZ9ydwPLTxviKW1xwOoAA7Tf5xlqlLgm2cxu9Jl+1RuZqpFLATR2+nBK9y43Y7Q/jDY6NK0RWYTE/KUPOWMff5g/MjqACj6tYL2bJMl/vjCulYzrHpiz3GQ/HEtMPf3jz4mq5UJTHfSWiEvDzYsHDsfPJ8kItws=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VVEoIhTU5oV89yQ31QHBOw2/bf6+EiCCSojmusYxvCBAaQRl1km5xBhePzk3?=
 =?us-ascii?Q?DGLPAF+9zdszT7/n+CoFs7nye3VA8iEsDIR+Kb8zoG+rNirQPI27x+QJZCBX?=
 =?us-ascii?Q?f/elqefkpw81DcqWS6V0t/DZX0CKW8zp3G/wIheGv0hMxD+svcNi/tLsyWJd?=
 =?us-ascii?Q?CjBEfRuW7lBW+IFtVaxkSo6X1fvLt65IBc7Teru3dlwtvoTUgHsAw0mzfbIy?=
 =?us-ascii?Q?kbQkD1oXFF2prdCDDflf1ts+siKynaQbf8DB4mqRUKFRmujpSLE9+KO46PoX?=
 =?us-ascii?Q?g9ORknq3jpqzO6gGIoi8GrXmGf6Bm9L0qqB1jvzlN/HBLmf7A74yF9MP3/i+?=
 =?us-ascii?Q?fY1HNv0CcOOdm8+p/jEziGzB0BdV1BZoDJtMfgXIbFq1pxJm+/WuDHqEPOST?=
 =?us-ascii?Q?jtCMnuqm+qKoLLutVYRk28w9dX0Fe7kdYZVRGSeoHh2qW704CNIGxdL8HDBG?=
 =?us-ascii?Q?+6O97a1wBBA5NSOpgOaDthELYEb9dxdQ4yfU0CCWe4bd44yZ1WmpiQKe0Mmv?=
 =?us-ascii?Q?zVvzJrbHEwg+2VPP5uC0T319VltoaNKbgcbuAY58D7EGqtZ45GXAsTJpv3g1?=
 =?us-ascii?Q?9u1z3ee22Fzu0451+IWfh+hrcOB+yk/rtuS+srxDAx+C1AjSH0/QgrM8GFSo?=
 =?us-ascii?Q?wQ5XORuuN1Kou9hoiZV8Hl1grJqhVmS8jJM4F9XMYpyF6mJGjq7NH2qQPH3B?=
 =?us-ascii?Q?2VnD2yQ9rZTSvMqUSzCoPualgltAZzL0BiYvRKjQbkp6t3FFlDTHocXGOBeg?=
 =?us-ascii?Q?05I/lM+7AzptbB6bjQNwskyQNgrkDFRyC3gFIuBYpJnplQlfjEUzALHkBsVL?=
 =?us-ascii?Q?2A66uQYJeBmB61I2jcZWDpZnT+lXq0HEyb7QcMi7OXpc63enNkOU2OdFxjGO?=
 =?us-ascii?Q?DhVQxyfk+ppUdbc4em9vv9DARRcQFAT5t+odHit1bVuw14c0KCNnnYu515O1?=
 =?us-ascii?Q?mmg4LewJ4TTVcuoHbI5th+AFvEJQTDPl5x4wlqgEeicbs6yfjJgy8j4P47eA?=
 =?us-ascii?Q?tt8CFEkbctS6G3QHWD+MvFcW/m/LBjsnPHnl3ynrUse5CpL7CqzJ9q51oi/f?=
 =?us-ascii?Q?OyiOgjKUxc7kMCSQP1Y75KTUzqeWZohbiIpskdTGLV1ekWDjdDny9imBve7x?=
 =?us-ascii?Q?hwj3PaJnOxfux5/E9KdCdtjJHYIJdiaJ263W4jgKohJoVuWNu3zk1GS+L2gV?=
 =?us-ascii?Q?jy4SrXjB/ohwVWDSNg5Fc0j1JblXDO6xFbvNnH5YDQIzm7NaiJNqac3R3Lnq?=
 =?us-ascii?Q?2UaImoY8oqPjRa216FzHltdQFfNzyNyCGB4l5Fg6LeVACsLJXMv1ke6FQJ/y?=
 =?us-ascii?Q?Oy0v22Y+jd4Vd80xr1WwMpgn7kE5beFX2UGjI9W2WcKW2Z4YQ5IcrNvqnknI?=
 =?us-ascii?Q?F12yaE7ObNp/IoYw5MVxiB9duWje5juPPMCUx9WhY+Bd8Q+O/vUxWCcgZPet?=
 =?us-ascii?Q?J0pMxoM/qOrrcaAPpUOAGZy+8+ftpsy0bs5h9Lc0J3VnK8bc9Y6XToCJCu4E?=
 =?us-ascii?Q?ZUqZENeTWPsADOItwcNGELpuBZoc0jUa757qOVdwRgXTDrEn4RYmdvwRYQ6q?=
 =?us-ascii?Q?KRK6A+n/RdlgG0aQSJCPmRgch8g3NAoqxj2+oX2m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7255bc9-81f7-467a-6deb-08dc3231f983
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:35:40.1512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qP+VuWrvCSDbkMaGVWufp91gHuVauCeSQPIxesErSzAU5N+QJdn3vGXnQCDRUySRF+eg8CqhQVRlZcNh1EC7Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9433

For a Broadcast Sink, this adds support for reassembling fragmented PA
data. This is needed if the BASE comes fragmented in multiple PA reports.
After all PA fragments have been reassembled, the BASE can be retrieved
by the user via getsockopt.

PA fragments could be reassembled inside hci_event.c and a complete PA
report could be indicated to iso.c, or like it is currently, if PA
fragments are indicated separately, reassembly would need to be done in
iso.c.

For a Broadcast Source, the user sets the BASE via setsockopt. The full
PA data is built at bis bind, inside conn->le_per_adv_data. This array
would be fit to hold the reassembled PA data on the Sink side as well,
but a listening socket does not have an associated hcon...Currently for
the Broadcast Sink, a hcon is created only after the first BIGInfo report,
which arrives after the PA sync established event and all initial PA
reports. The hcon is notified to iso.c, a child socket is created and it
is notified to userspace, to mark the PA sync step as completed.

I see 2 possibilities:

1. Keep a pa_data array inside the iso sock struct, use it to reassemble
PA fragments, and extract BASE from it when needed.

2. Instead of creating the hcon after the first BIGInfo report, the hcon
could be created when the PA sync established event is received. The
le_per_adv_data can be used to reassemble the PA fragments, and the hcon
will be notified to iso.c after the first BIGInfo report, when all
information necessary to create and populate the child socket is
available.

In this patch I am showing the first idea, but I think the second one
may provide a design more in line with the broadcast source scenario,
when handling PA data and BASE.

Are there any opinions about this?

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci.h |  7 +++-
 net/bluetooth/iso.c         | 79 +++++++++++++++++++++++++++----------
 2 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 08cb5cb249a4..a856e88719d2 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1,7 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
-   Copyright 2023 NXP
+   Copyright 2023-2024 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -2037,6 +2037,7 @@ struct hci_cp_le_set_per_adv_params {
 } __packed;
 
 #define HCI_MAX_PER_AD_LENGTH	252
+#define HCI_MAX_PER_AD_TOT_LENGTH	1650
 
 #define HCI_OP_LE_SET_PER_ADV_DATA		0x203f
 struct hci_cp_le_set_per_adv_data {
@@ -2797,6 +2798,10 @@ struct hci_ev_le_per_adv_report {
 	__u8     data[];
 } __packed;
 
+#define LE_PA_DATA_COMPLETE	0x00
+#define LE_PA_DATA_MORE_TO_COME	0x01
+#define LE_PA_DATA_TRUNCATED	0x02
+
 #define HCI_EV_LE_EXT_ADV_SET_TERM	0x12
 struct hci_evt_le_ext_adv_set_term {
 	__u8	status;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 04f6572d35f1..e9a3b4f74e2f 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -3,7 +3,7 @@
  * BlueZ - Bluetooth protocol stack for Linux
  *
  * Copyright (C) 2022 Intel Corporation
- * Copyright 2023 NXP
+ * Copyright 2023-2024 NXP
  */
 
 #include <linux/module.h>
@@ -70,8 +70,15 @@ struct iso_pinfo {
 	unsigned long		flags;
 	struct bt_iso_qos	qos;
 	bool			qos_user_set;
-	__u8			base_len;
-	__u8			base[BASE_MAX_LENGTH];
+	union {
+		__u8		base_len;
+		__u16		pa_data_len;
+	};
+	union {
+		__u8		base[BASE_MAX_LENGTH];
+		__u8		pa_data[HCI_MAX_PER_AD_TOT_LENGTH];
+	};
+	__u16			pa_data_offset;
 	struct iso_conn		*conn;
 };
 
@@ -1573,7 +1580,7 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	int len, err = 0;
 	struct bt_iso_qos *qos;
-	u8 base_len;
+	size_t base_len;
 	u8 *base;
 
 	BT_DBG("sk %p", sk);
@@ -1612,13 +1619,20 @@ static int iso_sock_getsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_ISO_BASE:
-		if (sk->sk_state == BT_CONNECTED &&
-		    !bacmp(&iso_pi(sk)->dst, BDADDR_ANY)) {
-			base_len = iso_pi(sk)->conn->hcon->le_per_adv_data_len;
-			base = iso_pi(sk)->conn->hcon->le_per_adv_data;
-		} else {
+		if (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY)) {
+			/* For a Broadcast Source, the BASE was stored
+			 * in iso_pi(sk)->base.
+			 */
 			base_len = iso_pi(sk)->base_len;
 			base = iso_pi(sk)->base;
+		} else {
+			/* For a Broadcast Sink, the complete data received in
+			 * PA reports is stored. Extract BASE from there.
+			 */
+			base = eir_get_service_data(iso_pi(sk)->pa_data,
+						    iso_pi(sk)->pa_data_len,
+						    EIR_BAA_SERVICE_UUID,
+						    &base_len);
 		}
 
 		len = min_t(unsigned int, len, base_len);
@@ -1834,8 +1848,9 @@ static void iso_conn_ready(struct iso_conn *conn)
 		bacpy(&iso_pi(sk)->dst, &hcon->dst);
 		iso_pi(sk)->dst_type = hcon->dst_type;
 		iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
-		memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)->base_len);
-		iso_pi(sk)->base_len = iso_pi(parent)->base_len;
+		memcpy(iso_pi(sk)->pa_data, iso_pi(parent)->pa_data,
+		       iso_pi(parent)->pa_data_len);
+		iso_pi(sk)->pa_data_len = iso_pi(parent)->pa_data_len;
 
 		hci_conn_hold(hcon);
 		iso_chan_add(conn, sk, parent);
@@ -1904,8 +1919,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 * a BIG Info it attempts to check if there any listening socket with
 	 * the same sync_handle and if it does then attempt to create a sync.
 	 * 3. HCI_EV_LE_PER_ADV_REPORT: When a PA report is received, it is stored
-	 * in iso_pi(sk)->base so it can be passed up to user, in the case of a
-	 * broadcast sink.
+	 * in iso_pi(sk)->pa_data so the BASE can later be passed up to user, in
+	 * the case of a broadcast sink.
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
@@ -1961,16 +1976,38 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
-		size_t base_len = ev3->length;
-		u8 *base;
-
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-		base = eir_get_service_data(ev3->data, ev3->length,
-					    EIR_BAA_SERVICE_UUID, &base_len);
-		if (base && sk && base_len <= sizeof(iso_pi(sk)->base)) {
-			memcpy(iso_pi(sk)->base, base, base_len);
-			iso_pi(sk)->base_len = base_len;
+
+		if (!sk)
+			goto done;
+
+		if (ev3->data_status == LE_PA_DATA_TRUNCATED) {
+			/* The controller was unable to retrieve PA data. */
+			memset(iso_pi(sk)->pa_data, 0,
+			       HCI_MAX_PER_AD_TOT_LENGTH);
+			iso_pi(sk)->pa_data_len = 0;
+			iso_pi(sk)->pa_data_offset = 0;
+			return lm;
+		}
+
+		if (iso_pi(sk)->pa_data_offset + ev3->length >
+		    HCI_MAX_PER_AD_TOT_LENGTH)
+			goto done;
+
+		memcpy(iso_pi(sk)->pa_data + iso_pi(sk)->pa_data_offset,
+		       ev3->data, ev3->length);
+		iso_pi(sk)->pa_data_offset += ev3->length;
+
+		if (ev3->data_status == LE_PA_DATA_COMPLETE) {
+			/* All PA data has been received. */
+			iso_pi(sk)->pa_data_len = iso_pi(sk)->pa_data_offset;
+			iso_pi(sk)->pa_data_offset = 0;
+		} else {
+			/* This is a PA data fragment. Keep pa_data_len set to 0
+			 * until all data has been reassembled.
+			 */
+			iso_pi(sk)->pa_data_len  = 0;
 		}
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
-- 
2.39.2

