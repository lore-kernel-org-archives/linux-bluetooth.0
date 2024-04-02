Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2130.outbound.protection.outlook.com [40.107.15.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B504664AB
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 11:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057983; cv=fail; b=VOfIPW856NZO4JoX4p3xtr0hv4p6wDLikR5ZoseS2NST3Q3x6PDjwi3hAk1hmF3hXmwGiAGeVfPI8XwEhO5vSuAGh9L5YY7s15jwJXYKjYS+I/OCJ0EZ/EX5zJGHYdL5Q2VllCcSWBznXFT5mbnys+LjXWIzLAoxLPJuxsL4uPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057983; c=relaxed/simple;
	bh=2IISJDpkK87ecuzCWj0cl9mAm1mqU3+MZJ87lnUvRoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dg25JsD8g6fJc2L84Dw6FvsPNNgdlOxqUs17S0q98rbbyHpeY+vFvSEiP/GRpSBtrRecOb446Ppmtp2vlZmOMg5WYc5WTcSCKTE+/DTKnwsXfdLkLvnJf375Fi1MnOlYOUVdlClpTXYPMPSfz/sRH3kDtUUyYQgUdgDM4YDc92M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OZarOvQq; arc=fail smtp.client-ip=40.107.15.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OZarOvQq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnY7WYnDeowfResWcx6XG3NUINSAa5PDsIQQKEBI16qyjKTfWn09tkSP1F2NJM+s+QpvXTPcZLrLcr5Rs8ac/4ugCU27e43ivDj3WBW2JXz2eih4gMNMkJZc89UZoi8Mg393KQANSKJ8/g/OmpnpiKIQb4t145eBRNCFvSJurq6kuQv2giDgCBMHmsTDsZFC73M3UHUWFJ9Ag1msN5HiSCEPUHsfEQuetxiMBGsOT/eggwPXIL6SE3BeqiVlcayIibJwIxI4DRxzfklF6FG3thPvGLSxl/7s2IhdZQyfzpB5pefyTk+ZlJtq47nNpwKpKuuR3szs5GtkcqMkUNlddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TXuCU/YKZXwJFNg8+HR6dg8AWXw4CSVjwMkWrWocQk=;
 b=LrR8PE5gOKmAY7BSvQnPxZ4VVWwbMh9bhGPLxuXBZUyTUGththMCu+jkazM0z7An34/yjcvBS4G9J9y7vvORKjCvF+xGoSjQ6XC1K2gj8bWH2TpLm4sda4vMEeA5nzyjq+3c1Wstw35Pqbm1e7LdOrTRE6V+24KoVEZTUyKqJn0zR0uthPcvS8o0fVMp7DOlj7P85/35/Oid79EKp+J5nog8qtqa7cMWJGXBHpaAta215ZPBrcpUbUih+o8ZXgVePyIAQXXKn9UArqFA0Aago1G9tXtDl/+QyRE706JauwLWN/Fl24Wn4NxwIZ7z6wicccU3ixdrjTze4O17mvMNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TXuCU/YKZXwJFNg8+HR6dg8AWXw4CSVjwMkWrWocQk=;
 b=OZarOvQqL+j/H0lD2npw/lkwNvK838kNaBZJS/AsJ87m8/eP6nU1jRjgHuwL34fMOEqo4BHs4VY1PsD/X7NnVfT4e6eniuE36pnNTo59PaqsWZDEopvyStC2mmxaLpKRo4revAj5WcQqouxxvRX2oQEF0kVSBzpaViu7JmWa42I=
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:39:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:39:39 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/2] Bluetooth: ISO: Make iso_get_sock_listen generic
Date: Tue,  2 Apr 2024 14:39:30 +0300
Message-Id: <20240402113931.3164-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402113931.3164-1-iulia.tanasescu@nxp.com>
References: <20240402113931.3164-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kFcXkH6niat5k4jcXBAotE6K/AiwbQ7SLmYhilk/MoodGfzrOV7LEdBMA2bvEDVncd0ygn1Irsm2wcb8Z2s/HzrgKfKf2vq32Rp2QOXCdVzNb9bUKgQdkGY1GoK0yUCTpcrUu8F3NItAzgOTHKVGGMWc8ObF0PkbVaz0I/OEDpJKwBGBOL9MDYLFj7l18b0TmoqNyOWVtZ623XZTt/Vq2T51dySisppjzy58JdZ7sEJ5BVb3pjmfvdceP0jy/wgAkQDVr85VSZgm31/bNFIbaclZ0E3trQhHJfsqdzMWNMWA3X1zTOeWB9fe9hQc01sfhhSxfWoMBzIML0KbJu3AIBhksOAS3e4Ny4hIWvw3+BZBt4tklhZlQzmLWJ9+vshso9vWBtuKyybX3C21WX/WWXcwPeFW6cm7u3ohX80cVhqVj1A0nNX7ug3mqUiLjepDR6xfEsS9nRK/OBqaxyd//l74c9dTZDyo7DZ062YIPfGWTfylQO1TQm8GWLF3VkAocXcl91rsvTODOQKOsSef6aTnfl9J2qoM2+3MrLPmnzFc31vu0yd3lRHjELOOBhKaS9ktS+I4dFjipg29xicehqnxVcDRZBWQy7EME+vS1Lo/MFT35cRqO0o3kdgl8pj19jkE9ODYNkQz0QnEiKL+r+vp7Laor994hromMiHZmwM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OQAdN/j4h4W3oOofHPM/DJmhHj700ZUi3TsbrPhKLuLGCiLtVI/I356f7MKd?=
 =?us-ascii?Q?oXqCUUA7/xM35GvnvVdKXzoZZKWliOCpHDk0NryX2ZAuTumY/gMmxX70p3JE?=
 =?us-ascii?Q?rI2+XlEkEu9c+7V+VE+JhijgmJg/sAn8COTFqfWXqFs49gdC1041p1rzpUty?=
 =?us-ascii?Q?G4tVsXDPKXDkuLhMsXMRedqdCKS4CmR02NqyDSY82PMPhf799tQo+riEtymL?=
 =?us-ascii?Q?SXlEo9iQajpm+6+gupG51Bke6HDdRf9ID1EaTicAYnN+UNUCRgJPgTk4HVfF?=
 =?us-ascii?Q?lqh3pueWx3cwZu/e3NFTDWnPvc9pM88T3leAIC7T+zpRVlHBFnV2Fp0eAN+O?=
 =?us-ascii?Q?Pdpj4bbCkwoLp70Gs89KMHC036097mhoLtiazC5ZE2S3fhwea8y/tayYiAMz?=
 =?us-ascii?Q?Xvu1mBAvQsaiqB7GxM3KaF0cLOXS7WFtDPdsV0gstL/ITPKYARvQdCXUDFrj?=
 =?us-ascii?Q?qVwyLtJq/HgWG0ZdQjVgQ8T87J3N368i8osZtj0oxJkCj5D03e2bt4ixap50?=
 =?us-ascii?Q?5KHuaDx0FmEvUrUu/han9IqNrJOtlqVSQJ1xupBqwJQ52eR0hRxkL4SE/AAh?=
 =?us-ascii?Q?NsSi+MMfhmzr4xcA7Ny8a+fdWIvxzatDzgN8gf6CmDvzTImlIc9uJvKdBv8o?=
 =?us-ascii?Q?TuMpLXBfHsAYcucIgsvYbMRUR4G3jpPVlMmKr508gpeoDECH8GQL28EOk5Or?=
 =?us-ascii?Q?x++w8K0WIKnXXzh7q8NdqNX7yghBsop1g+WD9H/ZhmU8Uxroyr+GsRDmm8XJ?=
 =?us-ascii?Q?PNihZfpLSnhcRDjW3idTY/LRhCQEUVJNiWHd0wFLgZ+s8lOGb+xB6w5SzMOo?=
 =?us-ascii?Q?sCSvq76wkIg/Ei9XwnWXn8G+RCfoPwt7pCWHp7bbTysAE3hGDJl+Od/VS17b?=
 =?us-ascii?Q?vGjgbeN7nr34RzHMQDthASkUyx+t3U8nW+PUso+ztC3aGO+8CI0TLXPEHRXe?=
 =?us-ascii?Q?M3DUKpGWaAJZq4syeqwrVKNAl3DnkClFOodGJa6mJdoHwmLr49tfgNaR/+G/?=
 =?us-ascii?Q?l3iGY4eR+1slJc6W3IhgYVFTHRy+zDT6l/WpRsYtN+Hb20VnaJC5QIH0yObQ?=
 =?us-ascii?Q?QCRwN2Z9Cw/awgKxIdhS1jHE0S5HeKMn6y//C+zDmrMILu0E2k0RONUEEWJb?=
 =?us-ascii?Q?eoQiDMoCV7ngnyaWWh5QErXmQzGAI9xXHoPO/r9EUxk2wX8bycxyf3VAhQxE?=
 =?us-ascii?Q?w2WRqFPDtxiEwOmE+ZdvTrPieX/zxXLLcT6TdbDOZ+/o1t8VAn7oqFd7IBDg?=
 =?us-ascii?Q?hDdL+EiMiKtKvsrMUXxwRNPshdiUJEDP9gy49A00+dFRfrEXrKvmk+WaoC6y?=
 =?us-ascii?Q?Lu+bVbN/bgMveyikHNWC4YAB8X3nIU7Mpl32LVG+L/OhV13KPbGti23gxXUO?=
 =?us-ascii?Q?iQ+MmItCax3Y3GqD/MLVRkhTv+ttJb1jrFcVyzHy8AwUEU7V8WtVn6UbExHx?=
 =?us-ascii?Q?VBnUqR9H5ukn8SOP3UKvLaamN/cr8BnGi4IDIp1Xn9lihqisDpuUcqU8swMV?=
 =?us-ascii?Q?416iogfT1vTCUNuosf+wC7bB8AI2kGawosJ8wnIYcKswyBCeGNrgHjFDUBs3?=
 =?us-ascii?Q?dIt2MUgJ60rZPQpMpblFblwgQo5FHDvIrveipAHPFCRDupe0PbmTPpHyDC8a?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04904f23-8e5b-4ca7-c71d-08dc53099468
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:39:39.0615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9rO4wE7l5Bof9c12CLhj7GVyJzkJucmX/6mKCsFnTdZ+2k0gOYymhP3pjBtZ36c0a6XTnai1kLeacpHWkXiPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

This makes iso_get_sock_listen more generic, to return matching socket
in the state provided as argument.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 75 +++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 42b4495e019e..3fcaef506bde 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -85,8 +85,9 @@ static void iso_sock_disconn(struct sock *sk);
 
 typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
 
-static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
-					iso_sock_match_t match, void *data);
+static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
+				 unsigned char state,
+				 iso_sock_match_t match, void *data);
 
 /* ---- ISO timers ---- */
 #define ISO_CONN_TIMEOUT	(HZ * 40)
@@ -233,10 +234,11 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 		 * terminated are not processed anymore.
 		 */
 		if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
-			parent = iso_get_sock_listen(&hcon->src,
-						     &hcon->dst,
-						     iso_match_conn_sync_handle,
-						     hcon);
+			parent = iso_get_sock(&hcon->src,
+					      &hcon->dst,
+					      BT_LISTEN,
+					      iso_match_conn_sync_handle,
+					      hcon);
 
 			if (parent) {
 				set_bit(BT_SK_PA_SYNC_TERM,
@@ -584,22 +586,23 @@ static struct sock *__iso_get_sock_listen_by_sid(bdaddr_t *ba, bdaddr_t *bc,
 	return NULL;
 }
 
-/* Find socket listening:
+/* Find socket in given state:
  * source bdaddr (Unicast)
  * destination bdaddr (Broadcast only)
  * match func - pass NULL to ignore
  * match func data - pass -1 to ignore
  * Returns closest match.
  */
-static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
-					iso_sock_match_t match, void *data)
+static struct sock *iso_get_sock(bdaddr_t *src, bdaddr_t *dst,
+				 unsigned char state,
+				 iso_sock_match_t match, void *data)
 {
 	struct sock *sk = NULL, *sk1 = NULL;
 
 	read_lock(&iso_sk_list.lock);
 
 	sk_for_each(sk, &iso_sk_list.head) {
-		if (sk->sk_state != BT_LISTEN)
+		if (sk->sk_state != state)
 			continue;
 
 		/* Match Broadcast destination */
@@ -1805,32 +1808,37 @@ static void iso_conn_ready(struct iso_conn *conn)
 						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
 
 			/* Get reference to PA sync parent socket, if it exists */
-			parent = iso_get_sock_listen(&hcon->src,
-						     &hcon->dst,
-						     iso_match_pa_sync_flag, NULL);
+			parent = iso_get_sock(&hcon->src, &hcon->dst,
+					      BT_LISTEN,
+					      iso_match_pa_sync_flag,
+					      NULL);
 			if (!parent && ev)
-				parent = iso_get_sock_listen(&hcon->src,
-							     &hcon->dst,
-							     iso_match_big, ev);
+				parent = iso_get_sock(&hcon->src,
+						      &hcon->dst,
+						      BT_LISTEN,
+						      iso_match_big, ev);
 		} else if (test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
 			ev2 = hci_recv_event_data(hcon->hdev,
 						  HCI_EV_LE_PA_SYNC_ESTABLISHED);
 			if (ev2)
-				parent = iso_get_sock_listen(&hcon->src,
-							     &hcon->dst,
-							     iso_match_sid, ev2);
+				parent = iso_get_sock(&hcon->src,
+						      &hcon->dst,
+						      BT_LISTEN,
+						      iso_match_sid, ev2);
 		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
 			ev3 = hci_recv_event_data(hcon->hdev,
 						  HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 			if (ev3)
-				parent = iso_get_sock_listen(&hcon->src,
-							     &hcon->dst,
-							     iso_match_sync_handle, ev3);
+				parent = iso_get_sock(&hcon->src,
+						      &hcon->dst,
+						      BT_LISTEN,
+						      iso_match_sync_handle,
+						      ev3);
 		}
 
 		if (!parent)
-			parent = iso_get_sock_listen(&hcon->src,
-							BDADDR_ANY, NULL, NULL);
+			parent = iso_get_sock(&hcon->src, BDADDR_ANY,
+					      BT_LISTEN, NULL, NULL);
 
 		if (!parent)
 			return;
@@ -1951,8 +1959,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	 */
 	ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
 	if (ev1) {
-		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
-					 ev1);
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+				  iso_match_sid, ev1);
 		if (sk && !ev1->status)
 			iso_pi(sk)->sync_handle = le16_to_cpu(ev1->handle);
 
@@ -1962,12 +1970,12 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
 		/* Try to get PA sync listening socket, if it exists */
-		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-						iso_match_pa_sync_flag, NULL);
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+				  iso_match_pa_sync_flag, NULL);
 
 		if (!sk) {
-			sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-						 iso_match_sync_handle, ev2);
+			sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+					  iso_match_sync_handle, ev2);
 
 			/* If PA Sync is in process of terminating,
 			 * do not handle any more BIGInfo adv reports.
@@ -2007,8 +2015,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		u8 *base;
 		struct hci_conn *hcon;
 
-		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
-					 iso_match_sync_handle_pa_report, ev3);
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
+				  iso_match_sync_handle_pa_report, ev3);
 		if (!sk)
 			goto done;
 
@@ -2057,7 +2065,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 			hcon->le_per_adv_data_len = 0;
 		}
 	} else {
-		sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL, NULL);
+		sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
+				  BT_LISTEN, NULL, NULL);
 	}
 
 done:
-- 
2.39.2

