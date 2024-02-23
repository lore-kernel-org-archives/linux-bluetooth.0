Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2697E798
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694126; cv=fail; b=L5OkK9n5Upi67n6ZL8ZoFiyqKj43uURI7ck54qLoAi/6vEuENu7aiSh59L6OXygVEMaNfzs5KGM/bzuXMqUhsBXw9LdHCNkwA4sirK8D3BNS6rF4QU7Y49n3wi/+TRFUBNgj+uyOHSMKboDzv40aZrdsAue5ubnDnyx93Jbqd0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694126; c=relaxed/simple;
	bh=RAdmzwjn9OMMcmmpSLYXsmwzAaxtgXbJYylxMFjRU94=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bT1Gh4F9p2yZInPZQrpaCdAAdgRHuxFfQFe356uwig8kqibPPmbRuQnsUEyThiIIngmW6FpGm0vTKEwkuGldyVjFPaE/IWR3IcBX7Xy6+OjnDJ1zQwfyru9YDWPYOR1jMZaWE28jX4ehvqdhKI2hz4KRfNK3wwmDAqTuD4f+0ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UnDMPuHa; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UnDMPuHa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzl4avLv4VrDg3NRjMPZbxLCVglBtNeV7orL3utzjEzSZRaoIiNBGKRlDrFlQ0KhWTKeEH0ypjpbSulFycVg72pnmmqvd2x1pDEv7+oJlCfwhbY7/rVtFnfs7mTJvO4R4nwNdzH9T7oVf8VHYo4mlRvb0zKDLMPdhepaJJCusIVMAih6jKTauoJLZ7rAX6n1luIIzUB6CtwWscOx7vPvAgz1OeMnQUkv/zodX3wvRl4Bc0S5sljr1es89UJB3rqefK2BVCcSTH/uah3PSzvxLmmYzDtwPkvxhUecnjzUKpQBhH41t8XSUogkE67AoCJp4R+S4vRAYfzs1yA6qfuCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jn58fB0nxIzHaPppMd8FkarXKtQTbkxdwFI5q4x7qI=;
 b=c1So7S8xlsZlnESGkOtiEXxWSPXjcOqLAvanpVzh5cEbS+xDgHcIMu79FQac3zGbPiBjSixvys/fbp+58wxnddawwsr8hxfSKWUhOlCQFICETSStEuQuc5wl+GZiOnmuUObWdTgq15XzZ7NHenCxowuiKwcGMf6XrSpJb4fUcNfJZbXtI9xnrDdcs5yadqO7EDAYjp19qlIf2ToohJn3LdQ74bQPW2Fi9NXQ2g8YKEfBgTkTQkmLmLTKcwW51UexOmoGiWt8X4Qt++i2MaTcD5vAu3sI8gLTzyEGXsRF8vMJsWTP4bqAL/P2Sv/02r4PWBUzbfXfv3WIBZ4u7XE+dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jn58fB0nxIzHaPppMd8FkarXKtQTbkxdwFI5q4x7qI=;
 b=UnDMPuHa7GyQlpBl7A1aKlkrmC/KhlgSP3AJpEzdwEjV+ELK7rn+JyZ1qzLG36Z6z3PFVcX1N8JuZcICxQcgYvy3C887sis7/oDvDh49UJMwg4xlITlulGKMrF2Z4jd5yDmXyP5dDq0RT0WH3FuyV8BB5HeF8lScq6wje5YzwnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 13:15:21 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7292.029; Fri, 23 Feb 2024
 13:15:21 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [2/2] Bluetooth: ISO: Reassemble PA data for bcast sink
Date: Fri, 23 Feb 2024 15:14:42 +0200
Message-Id: <20240223131442.3077-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223131442.3077-1-iulia.tanasescu@nxp.com>
References: <20240223131442.3077-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0014.eurprd08.prod.outlook.com
 (2603:10a6:803:104::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b74f341-9dfc-4459-d9c2-08dc34717d31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g0pOtIA/D9CcpD5wcx4bs655kA5bebFyhB9AR3KHHCl2s2TxFa6Ad36EMvF30axR7pxVOAL0HyT56qrKiCXn/e18mNLkBcpIdYaJglYPInqfM7Xz3u8TqO/y3qgAMbPv1ZXIVSSvyPTEecMJXhmKvlHmjXZlc/rDq04K2ty0ehGmPgPUxwdLuhFyz/ix2okeD6m7SMZDgM0Jwprq88mV2npwMFN6c07QtIQaMJnEUguObA3flwl5lCP1aYOCYF4wojNxbvo+COo0436XsgsNfycysgyfBYKQwIFBi9d/sMtLE84YEe65QNCZT4Y/ch4Fzfs9BBecmcH9ZGBh04TJO6MsnLbPv40JeocYHBp6JrhovkSLP2T/ubWHugm6HXrfW2WIYJd4kOLUwWFXogdOQw6X5GK3hHoVzP0DvTW4a4GPYhoHhaz3sGUbCgqj1IACWW4OGn0LSoA5Md+448adQcErrar8r7Boam/CnXFSeCfFWAJFB4YjZFOEgdysCdaElnhvbFSf4igqX+OoEkgvN/CdRpbb13Oy8WiVD1P/Mg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zg7Da8mE3Ilj0miHKQX4/r6+ssR7fnrU9lX3xR9FQtGgaeq3fGHCL+uAYdy2?=
 =?us-ascii?Q?434qlp0c9vZHT6srHFeie4D+1ooi7PqoZmLNxdWqB5kLpfCJdpH0lyGo/u45?=
 =?us-ascii?Q?eWh98xwIpGdINlANOwOjoUsV4aNsetjka6tvl8BSnMvu9OWNQyRp3vSSGy/E?=
 =?us-ascii?Q?lFMzxlZgIDPiQtqgXJ7n5Gl4YmBycap9cMHPKTwGJm3n20AxJE7zxELGzQM8?=
 =?us-ascii?Q?EGkob3Y+IwZ4QJaANcgL11+gcCka1Kh0yrLzcsPNIHb6cIePML0KgOGI6nri?=
 =?us-ascii?Q?c83mHxI8ImPlDNEVOaFpcAecqqqR79KBxiL0T+silentUwBAN/HoWuUwb9c+?=
 =?us-ascii?Q?aGlYps8Vk54E1V1TtYFfob5StKDYdctbmSWnHY5WpSWD/J0yMpHOixLoj6Ry?=
 =?us-ascii?Q?nFsGA7OqlkAs/ztQ96Du6cf4XxBciU85lGFU2Kgz6C3iAlqaCTks5y4+qfW7?=
 =?us-ascii?Q?R86RYw/aD/o5lfJ01kIeHgMJEYrmUQ2HBb8KLTex09v9YNVX21tZyVRE8pQt?=
 =?us-ascii?Q?r7GgoJ7KA1a3plrLzDZcWaCaognynfhScxHkm6LKiI6bb8+RGuPNKRcOBHXI?=
 =?us-ascii?Q?XHKw1n+8Cv/guOAR3OiQ3LnH2LeVtMtls+ZVXTPRdo7+ktmWdbwIWeIN8IuY?=
 =?us-ascii?Q?/GyAZE1RBoZNW4Qp1ll+G+9GudJCFfX9IXUeZUqyS+oopp53uGX6hKyHETog?=
 =?us-ascii?Q?sQj40N9es79yjdTlF3bXuC+9OiUqhElW5+a9f+OHgwgs0ucT+2uFzcnym0Xg?=
 =?us-ascii?Q?bSXPMUIiMIS2BLLTu62Pkpmii3UIzS0dlILJEsHF6DPlPGhuZ/pAyK/OWQUE?=
 =?us-ascii?Q?W72Bgi+WMz89esMVBySZ3ynTcZF2r0nj1e9XZv0aYOuSTRGZXcWUGycVWwpz?=
 =?us-ascii?Q?b34PgKeKe1nUPyvGwlb5HceQdcPJxSO08NwGi9tTBt09GoofT3By8JDPBfdo?=
 =?us-ascii?Q?SoiRBR9CRZoXuOksTAgDR1Rj9fdCbfbrepliy4+3eq8tGs+HK/wUeWp2IoRS?=
 =?us-ascii?Q?jmxp2EslyP/zD+yv7Dr8BiWDKVG2UM3UUwK2g9TcpfTFd8wd3MLtN+Nd5r4p?=
 =?us-ascii?Q?glUs/JXNTCt8AIGNb6QvsIwlSJqmiyIFNuk8kS9nj6eCXzbG63RWqcXcpjIN?=
 =?us-ascii?Q?A70EU/4tn47FuRIw6inFh/U5X/m2I8wSv01/y478DV49c1Rj5MNRPkKiPkjT?=
 =?us-ascii?Q?ClCRM7w0xaF7GrSUd171cUqRE9aDx9Ug2uhe71MlEKrb4GZC8WfTakb0qt9I?=
 =?us-ascii?Q?hO3wMORWmwqDEwdWZIS6n3KlQO7g1VU1nMb6ZPexrkNr/QGfywyT94Snr2t6?=
 =?us-ascii?Q?7B3TBgdfXBFJ+7xqxMEGLOJGuZZk4zTIsGGRSuvuuNTBK3TSbH3nphiJ3Kx7?=
 =?us-ascii?Q?vHDTOGgc3xXUF+2LISoEF5hmHXzHU9VdS0Olxpg03+7mWXlbqZnonT/vQSfD?=
 =?us-ascii?Q?oaviSmZbrC40mPDlgkXse9a185jxaMB2k0K1UukzHZD5UxJjpZNOkOV94urb?=
 =?us-ascii?Q?kbxA8vtdEHa1WbnT8/k/JhKGSt2yM0S/Gjk7n31LXDDlMtX/W/Isk7V6ASML?=
 =?us-ascii?Q?ws1697KmGHDwR8no0XVPAvgErs2V1rrVzhfHf4J3dMPC3y2qNqG8fS/7AArV?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b74f341-9dfc-4459-d9c2-08dc34717d31
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 13:15:21.7324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8FqYhghuXnljca96sOZvritGrXwZigKHmpaaR8dJgsYUt33jNUWHqnM3ARbVyF4Va6lCnwSN3toQoUh4KNSMPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447

This adds support to reassemble PA data for a Broadcast Sink
listening socket. This is needed in case the BASE is received
fragmented in multiple PA reports.

PA data is first reassembled inside the hcon, before the BASE
is extracted and stored inside the socket. The length of the
le_per_adv_data hcon array has been raised to 1650, to accommodate
the maximum PA data length that can come fragmented, according to
spec.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci.h      |  5 ++++
 include/net/bluetooth/hci_core.h |  5 ++--
 net/bluetooth/iso.c              | 50 +++++++++++++++++++++++++++++---
 3 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 08cb5cb249a4..21099bd3c8bc 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2037,6 +2037,7 @@ struct hci_cp_le_set_per_adv_params {
 } __packed;
 
 #define HCI_MAX_PER_AD_LENGTH	252
+#define HCI_MAX_PER_AD_TOT_LEN	1650
 
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
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 199a9f81cf50..da6aa6549b81 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -734,8 +734,9 @@ struct hci_conn {
 	__u16		le_supv_timeout;
 	__u8		le_adv_data[HCI_MAX_EXT_AD_LENGTH];
 	__u8		le_adv_data_len;
-	__u8		le_per_adv_data[HCI_MAX_PER_AD_LENGTH];
-	__u8		le_per_adv_data_len;
+	__u8		le_per_adv_data[HCI_MAX_PER_AD_TOT_LEN];
+	__u16		le_per_adv_data_len;
+	__u16		le_per_adv_data_offset;
 	__u8		le_tx_phy;
 	__u8		le_rx_phy;
 	__s8		rssi;
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d9ee69fa1384..30c777c469f9 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1982,16 +1982,58 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
 	if (ev3) {
-		size_t base_len = ev3->length;
+		size_t base_len = 0;
 		u8 *base;
+		struct hci_conn *hcon;
 
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 					 iso_match_sync_handle_pa_report, ev3);
-		base = eir_get_service_data(ev3->data, ev3->length,
-					    EIR_BAA_SERVICE_UUID, &base_len);
-		if (base && sk && base_len <= sizeof(iso_pi(sk)->base)) {
+		if (!sk)
+			goto done;
+
+		hcon = iso_pi(sk)->conn->hcon;
+		if (!hcon)
+			goto done;
+
+		if (ev3->data_status == LE_PA_DATA_TRUNCATED) {
+			/* The controller was unable to retrieve PA data. */
+			memset(hcon->le_per_adv_data, 0,
+			       HCI_MAX_PER_AD_TOT_LEN);
+			hcon->le_per_adv_data_len = 0;
+			hcon->le_per_adv_data_offset = 0;
+			goto done;
+		}
+
+		if (hcon->le_per_adv_data_offset + ev3->length >
+		    HCI_MAX_PER_AD_TOT_LEN)
+			goto done;
+
+		memcpy(hcon->le_per_adv_data + hcon->le_per_adv_data_offset,
+		       ev3->data, ev3->length);
+		hcon->le_per_adv_data_offset += ev3->length;
+
+		if (ev3->data_status == LE_PA_DATA_COMPLETE) {
+			/* All PA data has been received. */
+			hcon->le_per_adv_data_len =
+				hcon->le_per_adv_data_offset;
+			hcon->le_per_adv_data_offset = 0;
+
+			/* Extract BASE */
+			base = eir_get_service_data(hcon->le_per_adv_data,
+						    hcon->le_per_adv_data_len,
+						    EIR_BAA_SERVICE_UUID,
+						    &base_len);
+
+			if (!base || base_len > BASE_MAX_LENGTH)
+				goto done;
+
 			memcpy(iso_pi(sk)->base, base, base_len);
 			iso_pi(sk)->base_len = base_len;
+		} else {
+			/* This is a PA data fragment. Keep pa_data_len set to 0
+			 * until all data has been reassembled.
+			 */
+			hcon->le_per_adv_data_len = 0;
 		}
 	} else {
 		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
-- 
2.39.2

