Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476AF153BF8
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449443; cv=fail; b=pf8nooEEri2vNBKOycjQidk0VUYOMurjbDwmaP1or67OTaR3ulhlybxGxlRloJczqiGV7sNTi6fhT3uKOdnVuTUc+prZw/wYa14SR3lvzGyiYGyItOpUGfRr3XNjBSqswqOccCgMtxpVp8aX3CQHezMmOrawau6M9iOgmA8PcDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449443; c=relaxed/simple;
	bh=xdnHcskDSRtF7JGz+wvqYnnhu6RhK87msODMPxvpfdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ViCTNw/yicnZSwpkeFTE3atQBtwwMAu6TAuIkCAfc2DLBZtZFF54dLmZ0dLlAsiVDphNDWfMm3rCZ3baigU4NjXlJajDKihSh1/Sk7bE8QlG6Rt9ubMnNqL5rVr16GQpJhwVzp8F2sWn+M2FUsynY12UDhi07Mnpxdh/8k8XQPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Eqz4OhU6; arc=fail smtp.client-ip=40.107.247.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Eqz4OhU6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrIsmvq75+zJPiCxVNa4X/+5RDy+Q+wE9VTPe+xkq6lhPYKeA0Kx4Dg2HM70JFp7gNmoRe+kf06QJQsd9gtcQ0+7/deIZJhN3QVOK64UsY0LtH5g87q2fLLI4vkegyGP3Z6vWBTUvGLb5816UtRYAuy3n5q9GJve5DxetRPaPPimFeygl34JF43taHmyfpcd6bn3Z4hHkqa+eURSvD9kyxayL9W40n2Egol/E936GSV+cVvHvFWRoPjcgGycMDtnqN05rFHZy2Q6OZc+MYM+uZk2JjDtSbyVNALfxbLlpUc4V42NvUQXS4O5J7bGwdldGduRAwxDGzddFhqrhliOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T06WRNmvqWSSqCfw3nsNb1mw+Md6bEQ4+8ugsc1STpg=;
 b=bTaqW9I4GXVD3xyhuTKcSfjhfiNt5q4pSsR0acYChVOGWNyYGeF7tulJ1y5229UoM0RLkrhf7V5p+DIFfToHADpy9tCTJ1z39WjzSylYVWBTJIxXdV6EjMG42V/jouRhq4ozLA2aWG6r9psosfoAVDkRJMinz2D4rUSs4Cpb1bLxSPGYCu60gdvqaPc82vhCy9RvYCz3yR2HwI51WvXfwbsOCxNCCNoAe0xMTNJUCrggzk9bSnI+h7FpZVaqKQAUe3/wiu1gvGoKQAQtGPiRR8cQ8o2yxezSHYFszY6CXp9We/kVSuxucR87kgqB5K04LnR4cqg1kdK2LEDhVq87Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T06WRNmvqWSSqCfw3nsNb1mw+Md6bEQ4+8ugsc1STpg=;
 b=Eqz4OhU6dS2jkGRwEhhYkuit6gKEYB7Yharpn5WfLPHI4jfO7jfmo5RdfZSYg6SZYLRzr60mwUS/Qwddi3VpGDmjd85f8CryN9L4bIrvKLMz/LY5Wxxvbizh6sDXikLiNVDWOLUerFfcRdzVVRqduZsESkVaSKSBG06a42oVY90IuGAJBEMXTbRz2e2/tfiPrlI5g4FZ3CzPxZcpDTeje7IDL+dOipDU6fUeirCxv7bAxdgClvvJuNV92JSuqmwFK9uivHF1eTzM7GlK5mXoAgcmIoRHkQ/33n/guRvNhLedmcxb5VtSgMaSNYD2MAKGC9IheEmCK0NWT0kT/ew7pQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 08:23:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:23:58 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/4] Bluetooth: ISO: Do not emit LE PA Create Sync if previous is pending
Date: Fri,  1 Nov 2024 10:23:36 +0200
Message-ID: <20241101082339.4278-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
References: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3df6dd10-4315-4b14-63f1-08dcfa4e8897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEzBZfvixDxi6CaoJkFLNGZEFmII75BN/NEs218n3Je9BkYXWNCz3kLMSFfJ?=
 =?us-ascii?Q?XfweOUJ2v4WGWbPX7n/0BCtfl//Zgj07uSb6YaYKsuL9852/sZQ3xfDLwcfQ?=
 =?us-ascii?Q?911nYXBo3aC5ysH0EZqbEqjZLCTudzHOllSRW6cPq5L51AX2bUFvsgQ5DdNy?=
 =?us-ascii?Q?A+UwYgkYUlT3KIohxvfRZZqzyy+F3dJvOInhU/wKQ9UoT+bjxcocL4bG+IBp?=
 =?us-ascii?Q?Xc2+C5MK6BGwxUid4fF+nOH41u+nUy7Dy6z+d0zjBodymTXvaewCb07gDZDn?=
 =?us-ascii?Q?PpbIk/GfXfHMYh4rDXe2lLpPQstQOEHYMtrRNY9iHVnl9Y8DBno3IJ7lIbvy?=
 =?us-ascii?Q?qO8yl0hG/VS20Pfbn/rUvCGTTGEvSXPFi5gPz6ccZI0B99XkoxOowspBOimu?=
 =?us-ascii?Q?Pg8VVe594LmtRXaiOT8Cyx0B4ju5DMKQKYd5b7+W4mYORXdQCDPwQYyoeMrW?=
 =?us-ascii?Q?aocOP8AxTW0ECpOHuVR5/CpTxOt9uhhq14gXloBRtGb5two2gRkrJ230jKZB?=
 =?us-ascii?Q?tMzQCvGjyyzeftaqFxSoyEwFZXqAVoc9EWrBnMmgQ/9dpLqWz5cLv1SChEUc?=
 =?us-ascii?Q?fCqaR3TH++N2Xcw6UvMImaXbfVwE5WypYruUl8uzKAy8LEmFYy59n168pmjN?=
 =?us-ascii?Q?5jpmdTBB5KGbcfzuRb4E6bIMa3c+mUx82NEQ1nlZ5FXfwwtyIAUTftBsfnyU?=
 =?us-ascii?Q?DnXR5dd5TzkMCNOZ799KgPbnbswRINvGRr9/Iz2UYI4SMZmFsPL7SKUdaTHe?=
 =?us-ascii?Q?9gO/OgfAVR+6m4gNh7XE/ptzA4io0jTtRqzobcmkeHc5V0M6QrGlLmI4OdhD?=
 =?us-ascii?Q?wFkvD5dfLQUoXOHQvo6MI/zJ6auljUR1GddjTBunBpNKQAPhjOVxS1XXs+Zu?=
 =?us-ascii?Q?txkbWPKQjuwmpH20Ji3nMi/VfDL0onS9E9Neu5ezuI7GMCKEyEM+766OMyXp?=
 =?us-ascii?Q?xoFUZEbukEVjtDw634k6ac99cW+IpdBIdpJ5ndZJ+FOGXEV2DcbQpylfTw1b?=
 =?us-ascii?Q?5dTuyn2xXph84ogR3olHNRubJz34EEfLTGXd5IhwvN02QSJSE9ctKanxSa7+?=
 =?us-ascii?Q?NivCQn9kGcvJ3dkt9eTOJnN/xE1tGyuurDdD/nJUSK/mjpfXNyOh1g2ku3EQ?=
 =?us-ascii?Q?iOiWMPEpiUAfxuibkeLGZPjHC6olbMgGDVA1rs/+PpelfT7L2je0JnJCWst0?=
 =?us-ascii?Q?+pOIeEuw3Ad/shV8SrXkgDEdoIHMo4y60ylq4t2VzH2ZqSbTYPGiXMSD/Sem?=
 =?us-ascii?Q?klJidVzFmarvyc6/aNAORGK5pZwdkCZAdi/7PFZgIFDgQcs3AO86lWGz282l?=
 =?us-ascii?Q?1gXb0wOF/fGuzd0ndsq5h9QfSSzz019t884EUU+iD+JXVN05E5s10gOl9V/N?=
 =?us-ascii?Q?Gfak2As=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+LSnuydf1Axtxbrmiz+IjGVLCwzDbDGM8jRhKNgpvKDJt4EbQHeIw51GBvA?=
 =?us-ascii?Q?TUctwva0dn7+7XOvDO/naCVYZ9cZKGpGcIlnFWXWwdHUIjRXqIGkmhyp8PC8?=
 =?us-ascii?Q?cPRqfrKifNdaaTfsckYg37FDgl5UUx785b1q7i6IthyRcdGcSFTeITL72/qY?=
 =?us-ascii?Q?QfPaEtCftcr9rDRSLEnsPEzhDP5VSg8n7WMHM9pdfZa6HV+H3Yg5RJ8ARM5m?=
 =?us-ascii?Q?1cHKSCFBT7rwu60nu0q6JnogH59k0JXoejliKKCCKCDI2D/NIInh/rv5zfgV?=
 =?us-ascii?Q?1jmpxG1ZJpo9usxlaBwG+RHiUfwtRRGWSDYer8UoQWQ66cdARMT4Y1BrSVXJ?=
 =?us-ascii?Q?j74R3nYPEJNMwwMxh7s6CFSb0+aANnmquUCsp7ts9D6mU6ShnuLrx60v0xqX?=
 =?us-ascii?Q?O+I4atRjVNhn1P7Tc+Jc1VX1pa4HZ3AJcjBo5wUuaTYIbiOXRlq1xT+KIODH?=
 =?us-ascii?Q?43RbBiqBxaGkey+h3ovdOsZoTRr024hBH/NVf2HW7z6fsZFxaFWxE3w5g3/9?=
 =?us-ascii?Q?Xpvz0fByefXW2X14v9H/Ou370cSiwL47RRqrWmtYL3xnKKkigvAL+39EC0U4?=
 =?us-ascii?Q?IZ2ggBW+GUeI4xtnjL+YnUM0/Z7TRER2WH0Ak8N/61Drh58IsBwhMvxrlMIu?=
 =?us-ascii?Q?kZPD3GXAqJ9gmvQpmsmrk+2i8xU9OXuLzrMynpracfXgDOw9oHWRYxyodNlc?=
 =?us-ascii?Q?WxM85Q4k0RbL2chfoEN3nGIgVtjwV6Lhmluzz+H8Q3yL1d34oiSZ3/z/Xofc?=
 =?us-ascii?Q?f0OQUU24vMEPCXcBJnTAaGNMJXZKKsUerMR/s1Kp2uh7IYzhrHhy2pWKEpPI?=
 =?us-ascii?Q?CMj+r6mBlEVtUuTYnl94JbftruMNN81R03mDlA7nDyVb3atXC4YLiswzNaI4?=
 =?us-ascii?Q?wVZRsoUa4wOZQgfnM6teCI2+mkfjIoblAHhLCJbtg3kYpnXPSPTFB9UMLBzi?=
 =?us-ascii?Q?gsjb0CNAj9naUClACC1i/gpeg1noYcYIRCduPKZTLRVcYliC/0s/YrtYdGbY?=
 =?us-ascii?Q?vyNYpsUIOkSWMkN873btpkps6iNKi/R4pjb7JihTryKdw+jPpxU7wLCZgf7B?=
 =?us-ascii?Q?+KytG2fHuJVSEdivEb8OGH2MXcy4nO5peDWar5hhPRHHdiIbC1Cc27o4Cdlz?=
 =?us-ascii?Q?S+6Jtcpdtp6rCbceh4GaqOcDFbMVd5WnV/M/YLAEiSpnsBh3dqaVofodJ8tQ?=
 =?us-ascii?Q?GTo9L0duU5HGGK6C+JN254Qbl5UlTMYCcdP2q8l8D/LhTeOKJgxz402jZNtD?=
 =?us-ascii?Q?3w2VmjNIq938WT2B7J/zdoHylMJqpll4+KRni9wUXgqIoJkXGJCZfWTd+Aa9?=
 =?us-ascii?Q?aNLKL2akjAuLLvMlE9c2tnjEr7DGBHdjiVacGV6FEjsh5QkJ6uCn2MbxRjl6?=
 =?us-ascii?Q?2oxXlbvZmXd9kqwMBZD+JiPX+V3wscbnEMAV60meXTktO0vOQ0je6bd+icYK?=
 =?us-ascii?Q?je8Q5KofGd5iNZtJ8KoSYXbpS6F1gvglDjWxOgR71TxnG/ej5NflBPvrOF+C?=
 =?us-ascii?Q?n4bIdMRaYc4cf3wz/RaIRVRLRMaKCdidVUccaqg02P/nwd5c70xPT0BPlrgq?=
 =?us-ascii?Q?WEMjbEhytk6YN3+ntiYo5ioCb3Pbfe1QE3u/SmUgARF+pcEACGNbE6ej05E2?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3df6dd10-4315-4b14-63f1-08dcfa4e8897
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:23:58.6777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fhxZiOv0V7q6+WZW8Zv9tJu06VhDYpPwU+atfoHLK2xqTdem4PE7AA874d3WKKxon5odgwnGKoFRZ50EIgKXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

The Bluetooth Core spec does not allow a LE PA Create sync command to be
sent to Controller if another one is pending (Vol 4, Part E, page 2493).

In order to avoid this issue, the HCI_CONN_CREATE_PA_SYNC was added
to mark that the LE PA Create Sync command has been sent for a hcon.
Once the PA Sync Established event is received, the hcon flag is
erased and the next pending hcon is handled.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci.h      |   3 +-
 include/net/bluetooth/hci_core.h |  34 +++++++++
 net/bluetooth/hci_conn.c         | 123 +++++++++++++++++++++----------
 net/bluetooth/hci_event.c        |  19 ++++-
 4 files changed, 139 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 4f64066915be..4becf201b063 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1,7 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
-   Copyright 2023 NXP
+   Copyright 2023-2024 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -697,6 +697,7 @@ enum {
 #define HCI_RSSI_INVALID	127
 
 #define HCI_SYNC_HANDLE_INVALID	0xffff
+#define HCI_SID_INVALID		0xff
 
 #define HCI_ROLE_MASTER		0x00
 #define HCI_ROLE_SLAVE		0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 94ddc8684973..43474b751a50 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -668,6 +668,7 @@ struct hci_conn {
 	__u8		adv_instance;
 	__u16		handle;
 	__u16		sync_handle;
+	__u8		sid;
 	__u16		state;
 	__u16		mtu;
 	__u8		mode;
@@ -947,6 +948,7 @@ enum {
 	HCI_CONN_CREATE_CIS,
 	HCI_CONN_BIG_SYNC,
 	HCI_CONN_BIG_SYNC_FAILED,
+	HCI_CONN_CREATE_PA_SYNC,
 	HCI_CONN_PA_SYNC,
 	HCI_CONN_PA_SYNC_FAILED,
 };
@@ -1099,6 +1101,30 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_sid(struct hci_dev *hdev,
+							__u8 sid,
+							bdaddr_t *dst,
+							__u8 dst_type)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type != ISO_LINK  || bacmp(&c->dst, dst) ||
+		    c->dst_type != dst_type || c->sid != sid)
+			continue;
+
+		rcu_read_unlock();
+		return c;
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 static inline struct hci_conn *
 hci_conn_hash_lookup_per_adv_bis(struct hci_dev *hdev,
 				 bdaddr_t *ba,
@@ -1328,6 +1354,13 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 		if (c->type != ISO_LINK)
 			continue;
 
+		/* Ignore the listen hcon, we are looking
+		 * for the child hcon that was created as
+		 * a result of the PA sync established event.
+		 */
+		if (c->state == BT_LISTEN)
+			continue;
+
 		if (c->sync_handle == sync_handle) {
 			rcu_read_unlock();
 			return c;
@@ -1445,6 +1478,7 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 bool hci_iso_setup_path(struct hci_conn *conn);
 int hci_le_create_cis_pending(struct hci_dev *hdev);
+int hci_pa_create_sync_pending(struct hci_dev *hdev);
 int hci_conn_check_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 40c4a36d2be3..f9da12339db8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -952,6 +952,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t
 	conn->tx_power = HCI_TX_POWER_INVALID;
 	conn->max_tx_power = HCI_TX_POWER_INVALID;
 	conn->sync_handle = HCI_SYNC_HANDLE_INVALID;
+	conn->sid = HCI_SID_INVALID;
 
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
@@ -2062,73 +2063,119 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 
 static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 {
-	struct hci_cp_le_pa_create_sync *cp = data;
-
 	bt_dev_dbg(hdev, "");
 
 	if (err)
 		bt_dev_err(hdev, "Unable to create PA: %d", err);
+}
+
+static bool hci_conn_check_create_pa_sync(struct hci_conn *conn)
+{
+	if (conn->type != ISO_LINK || conn->sid == HCI_SID_INVALID)
+		return false;
 
-	kfree(cp);
+	return true;
 }
 
 static int create_pa_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_cp_le_pa_create_sync *cp = data;
-	int err;
+	struct hci_cp_le_pa_create_sync *cp = NULL;
+	struct hci_conn *conn;
+	int err = 0;
 
-	err = __hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC,
-				    sizeof(*cp), cp, HCI_CMD_TIMEOUT);
-	if (err) {
-		hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-		return err;
+	hci_dev_lock(hdev);
+
+	rcu_read_lock();
+
+	/* The spec allows only one pending LE Periodic Advertising Create
+	 * Sync command at a time. If the command is pending now, don't do
+	 * anything. We check for pending connections after each PA Sync
+	 * Established event.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2493:
+	 *
+	 * If the Host issues this command when another HCI_LE_Periodic_
+	 * Advertising_Create_Sync command is pending, the Controller shall
+	 * return the error code Command Disallowed (0x0C).
+	 */
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (test_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags))
+			goto unlock;
 	}
 
-	return hci_update_passive_scan_sync(hdev);
+	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
+		if (hci_conn_check_create_pa_sync(conn)) {
+			struct bt_iso_qos *qos = &conn->iso_qos;
+
+			cp = kzalloc(sizeof(*cp), GFP_KERNEL);
+			if (!cp) {
+				err = -ENOMEM;
+				goto unlock;
+			}
+
+			cp->options = qos->bcast.options;
+			cp->sid = conn->sid;
+			cp->addr_type = conn->dst_type;
+			bacpy(&cp->addr, &conn->dst);
+			cp->skip = cpu_to_le16(qos->bcast.skip);
+			cp->sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
+			cp->sync_cte_type = qos->bcast.sync_cte_type;
+
+			break;
+		}
+	}
+
+unlock:
+	rcu_read_unlock();
+
+	hci_dev_unlock(hdev);
+
+	if (cp) {
+		hci_dev_set_flag(hdev, HCI_PA_SYNC);
+		set_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
+
+		err = __hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC,
+					    sizeof(*cp), cp, HCI_CMD_TIMEOUT);
+		if (!err)
+			err = hci_update_passive_scan_sync(hdev);
+
+		kfree(cp);
+
+		if (err) {
+			hci_dev_clear_flag(hdev, HCI_PA_SYNC);
+			clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
+		}
+	}
+
+	return err;
+}
+
+int hci_pa_create_sync_pending(struct hci_dev *hdev)
+{
+	/* Queue start pa_create_sync and scan */
+	return hci_cmd_sync_queue(hdev, create_pa_sync,
+				  NULL, create_pa_complete);
 }
 
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 				    __u8 dst_type, __u8 sid,
 				    struct bt_iso_qos *qos)
 {
-	struct hci_cp_le_pa_create_sync *cp;
 	struct hci_conn *conn;
-	int err;
-
-	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
-		return ERR_PTR(-EBUSY);
 
 	conn = hci_conn_add_unset(hdev, ISO_LINK, dst, HCI_ROLE_SLAVE);
 	if (IS_ERR(conn))
 		return conn;
 
 	conn->iso_qos = *qos;
+	conn->dst_type = dst_type;
+	conn->sid = sid;
 	conn->state = BT_LISTEN;
 
 	hci_conn_hold(conn);
 
-	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
-	if (!cp) {
-		hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-		hci_conn_drop(conn);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	cp->options = qos->bcast.options;
-	cp->sid = sid;
-	cp->addr_type = dst_type;
-	bacpy(&cp->addr, dst);
-	cp->skip = cpu_to_le16(qos->bcast.skip);
-	cp->sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
-	cp->sync_cte_type = qos->bcast.sync_cte_type;
-
-	/* Queue start pa_create_sync and scan */
-	err = hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_complete);
-	if (err < 0) {
-		hci_conn_drop(conn);
-		kfree(cp);
-		return ERR_PTR(err);
-	}
+	hci_pa_create_sync_pending(hdev);
 
 	return conn;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 65f5ed2ded70..fd269fcabc2e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6352,7 +6352,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_le_pa_sync_established *ev = data;
 	int mask = hdev->link_mode;
 	__u8 flags = 0;
-	struct hci_conn *pa_sync;
+	struct hci_conn *pa_sync, *conn;
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
@@ -6360,6 +6360,20 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
+	conn = hci_conn_hash_lookup_sid(hdev, ev->sid, &ev->bdaddr,
+					ev->bdaddr_type);
+	if (!conn) {
+		bt_dev_err(hdev,
+			   "Unable to find connection for dst %pMR sid 0x%2.2x",
+			   &ev->bdaddr, ev->sid);
+		goto unlock;
+	}
+
+	clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
+
+	conn->sync_handle = le16_to_cpu(ev->handle);
+	conn->sid = HCI_SID_INVALID;
+
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ISO_LINK, &flags);
 	if (!(mask & HCI_LM_ACCEPT)) {
 		hci_le_pa_term_sync(hdev, ev->handle);
@@ -6386,6 +6400,9 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	}
 
 unlock:
+	/* Handle any other pending PA sync command */
+	hci_pa_create_sync_pending(hdev);
+
 	hci_dev_unlock(hdev);
 }
 
-- 
2.43.0

