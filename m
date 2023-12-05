Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sW7AF5eO"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF68194
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Dec 2023 08:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9DQ8Q8G86k+tBOsRF3P+0g1PVrxlAxu6ICepHLVf2cx9zUlYDQ4lOPmVMjzHZD6KQ/5OKMsf8+GK9nq9p2G1o3t4dAz1+624pWa7HcONRZAsBYUCNrQruQzo8ymb12Huu/pm8HKfsbg//6Fb04P7VtlNew/EogToXtfQ9AQtGu+cdJaLL3HAXKSBwGAO1gZZrxxI9J0yu0E1+pykTC5+55hgLZ2kUaPX83Mvf4fXJyO7qUkj1TA2JNxSGAbCKQeOFTb0A3vcf3G16y5HXNSJ3gUpp8/4QpSO/mEX4ZtL82EqLAYUURv5u7u+waAZ8FSvD4eibSPzC1KB0hYx9lIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNLGdbTspPRAW1F1Cw03ocwZSAnMmYV89wz+DKF2rrs=;
 b=kHxBgGaO640B67ROQLY14C71BDKiMCfx+OfQlTHP7BoV9riJnSXhLr1+e+NnJkhnzN2FseAHJKNKl3U3MRgxSXVFVVtgwuHhVaZ3vzTo9zZbiIM8MTGlUwofHJhdPmhHGVC3CrtIu0R2cYBVp8yLPeucpiKxlJgls1yST/UPTDG8ji9otM5J1WsVjtqiVSiSyP5s4xep22pfmB38AvAmFDRVOdZ+J3manb6uVxMofbBXEcLxyMImDrkmisuwNLLRqSn+BkbeOh8LbLbolipHLvjFrbzvvtwysV6+sZ7jmuuKe+uxEEy2Jzx5qhYQMUnj9nTxFUxB4a+T8yhWgbXehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNLGdbTspPRAW1F1Cw03ocwZSAnMmYV89wz+DKF2rrs=;
 b=sW7AF5eO1jVTz9ygFZSmpUo0CQ+rDquxBgHJF1fSs8DAsnH/Sl0vV6m7O4rMiva6mZQwYoamo4iyc4nJYqZhvS1kODWyW8yN20kpjI+MwQQKf921GkSqR8UhVhfgb+yPTfTVtIWktkGuBoiUpIZ0gexFzVIzxzhdqE71DnoMZuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB8287.eurprd04.prod.outlook.com (2603:10a6:102:1c4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Tue, 5 Dec
 2023 16:11:53 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7068.022; Tue, 5 Dec 2023
 16:11:53 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Avoid creating child socket if PA sync is terminating
Date: Tue,  5 Dec 2023 18:11:40 +0200
Message-Id: <20231205161140.2855-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205161140.2855-1-iulia.tanasescu@nxp.com>
References: <20231205161140.2855-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0096.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::49) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB8287:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a6e98b-5fe7-48d0-0583-08dbf5ace564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VKt6va5FiyUMxrJOMnLj66TVjwrAFpE+iyCwdXZ18kjCFNo8zuY4Or7YX/b6G7vnihwM8rliWCm1izKFELq3Mw1Yqqcc90Ihsve/8BhOxm3kV9TTxr06DNlPv8cTomAqjG785Ph2Z/04a3IDdxkhFyUPV4ygXpPKcPfIDsE1WdiiCc2s8ORKKA3VgThaOXAP5VmfBUYjtwfuvcfGvnF2lFrBp3aFlmukZYJV2Kyx4iY0patZMMsRwrMVLj9NoVs4C+EiaPVtQG+EoT/XLl+29v4ekQr5Z0xSEjE85X8peqJ1oHFr+gyBRZUObo2e8QvCZD2Sggylg1XxkYNDvKLZPW02zAiINAuQdZkzy3zovoOqtmNlAxtQXD4QS/PFmO9WZZMs0+VP6nH6UYbElu0ZDCuePkJzvFugf3PeS7BxRn8UO+XPZNL1bctbaEoMfSlREw84/++kcwnFLch8T+EX6anFYN2u57B44xgdDHQEuNbwSqE070Yr5jqDjAqxzneOSNNWFobJR5VWvzuy21ay4b//NeB8AVwC+h4cAK/222tsLfp5NpFTxzlQ+cktKgV0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(2616005)(6666004)(36756003)(1076003)(6506007)(26005)(6512007)(478600001)(6486002)(44832011)(66946007)(66476007)(6916009)(66556008)(316002)(86362001)(38100700002)(2906002)(5660300002)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7eQBLlzM2DZiG+oqy/gxUg0BG3+hK2vZw/JOr+pJsv0oO7+dYspwtBuAd9e?=
 =?us-ascii?Q?3+dYHfKgkgKEDUdjzwyF/rFk6CzMYNoEnOEKr75EPdtP5u178cfQQKc5Yx8O?=
 =?us-ascii?Q?99qGu4ybWgOZa24iOUFwzLQN/AbuhRFn524bT4/WgzWWYhAaSuXw0cld+4Py?=
 =?us-ascii?Q?iF2odI687WxPsjwjRVzNMwP7JQdmtw6DSh6tEF9iuJAT59+T+mkrwN5DumhU?=
 =?us-ascii?Q?wO2ah3csJukEVrqmB+DuZwsW6WkWS342WEOiAyPG9an1SPcJB4GCVpaCbNAl?=
 =?us-ascii?Q?a6oyjd1qf0QZKdwyYJYH5aydPJyXNlsc+XrGYMjdgQ8GsdVYqz73rDK01FrL?=
 =?us-ascii?Q?yiyd/Kn57Z+sNLS6rEJ20+jf82baBtWaaHEmg5ZvmfydJkXH36BOkK2ETcuz?=
 =?us-ascii?Q?6GmDxu3SHKH+zWnRnJFWHFMoe96Pab8t1vBIBInMQiaRJkyhWr9iTNKzNaFb?=
 =?us-ascii?Q?6rLSf7ZBegPRa/ereIY0ZEC1SdwaiAZ4Bgls6mSS9L8NyS6R8N/KCcJa/dD9?=
 =?us-ascii?Q?UFltIB58psDrqba6FkKwLUE2zeD6CrIBwRa4obuMPgtY315wxY/mnRjKksh4?=
 =?us-ascii?Q?6Wv5Tctsc5Eug0BAZBiCZ1NmXYUcVRTGgZkw/0Sk4csh/fKoYUDRv8MKQaS0?=
 =?us-ascii?Q?b2pUdUYhowHPpo7Ky0oEIUiwnI+PsKhr0bETRBKqRv4u7r2SsYO6q2zQLQIq?=
 =?us-ascii?Q?4GwlhzxEmFMyDQ4bCkwAI/aPMdQ5Xg9AxnwlQ2P9KcdOYwrd4GmL1f5ph3Bd?=
 =?us-ascii?Q?fHtV0qAIVpJVU8hNeinSSTiwWmv9GUoewqV/x0Xfyu1l0PwlVfN3LpEVG+Mv?=
 =?us-ascii?Q?K3jDGMVLfKEDlf+N8xGwt6G5x6FnRS8KHwixsx2vN88B4Cz+mZzYva5WcyWc?=
 =?us-ascii?Q?DtsxRZims7fUmjYJmNpJ9WUDjcZbZ3Fo0A2MGIgIoIaeoUZPsur/+Jn26So7?=
 =?us-ascii?Q?svGhi8gRxaaM6Q+bhqzbgR6uxVevAM7MoMeOuDdCLVAHZu/50DBJCr+yQrVu?=
 =?us-ascii?Q?tob39uHu+eXzttykub92vqt4eE8RMu6uO285L3F5FYHKwuPvyZ/tdG+Ofgki?=
 =?us-ascii?Q?xmGvXnoSX/r8/LJwuUghIza4E+C6LECg8W5Wf+O/nyzZjyMbs4ZMcZH2MSBW?=
 =?us-ascii?Q?iwYIC+RUlcSTnqBDWyixSvWQDtJViDZLwun7/N8PTUVIF9VAJPJorqg1CvFK?=
 =?us-ascii?Q?z6/1G1uBXLEodcU0BUmUhUbLc4vwqoBBKvaxNYvaq9eDYY2zP+ZMtzqts35r?=
 =?us-ascii?Q?enhVWV80opPiCa+ZFjGLINwY6jVSXZ5aZ7enxe7T3dJYanK1fH6ux6NPOs/f?=
 =?us-ascii?Q?6pNKZSZygZxfzkxXayJ0aDlr3Ad9dpCKxzffzyBc28uP+WHXIW/jAhKO3b63?=
 =?us-ascii?Q?CIjOBE+3n9ReBsAaKDRo+pBEyKo7BNrTQDnWS0X+X7EefPaT6zkbRODmNmc7?=
 =?us-ascii?Q?qb1FIyDDEsznbKA9x2erAQdkXI7cgEEeqeAn8wQHSisZSXfYzg31WOy6kykQ?=
 =?us-ascii?Q?Kndw8BZTL4uHb2Fj67e1hLJNN+WfbLykv3Rn8VpOxhNTEAEItUaELPMZVMtF?=
 =?us-ascii?Q?p3SrbDY0s7SBoM0nxtKg5uD9os1mzMMEaKTlnPZ7QRH031D2dxVlH692QGao?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a6e98b-5fe7-48d0-0583-08dbf5ace564
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 16:11:53.5714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C14oFNVEslBYmjWUzsR479ZFJkUWzb1+imWg5Xbpt+mlW4X2wRcgZC8bXN6T4z0sY8Pz13i6C7qvQzlTqTmlWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8287

When a PA sync socket is closed, the associated hcon is also unlinked
and cleaned up. If there are no other hcons marked with the
HCI_CONN_PA_SYNC flag, HCI_OP_LE_PA_TERM_SYNC is sent to controller.

Between the time of the command and the moment PA sync is terminated
in controller, residual BIGInfo reports might continue to come.
This causes a new PA sync hcon to be added, and a new socket to be
notified to user space.

This commit fixs this by adding a flag on a Broadcast listening
socket to mark when the PA sync child has been closed.

This flag is checked when BIGInfo reports are indicated in
iso_connect_ind, to avoid recreating a hcon and socket if
residual reports arrive before PA sync is terminated.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 51 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e49f00e8a6a6..04f6572d35f1 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -54,6 +54,7 @@ static void iso_sock_kill(struct sock *sk);
 enum {
 	BT_SK_BIG_SYNC,
 	BT_SK_PA_SYNC,
+	BT_SK_PA_SYNC_TERM,
 };
 
 struct iso_pinfo {
@@ -82,6 +83,11 @@ static bool iso_match_sid(struct sock *sk, void *data);
 static bool iso_match_sync_handle(struct sock *sk, void *data);
 static void iso_sock_disconn(struct sock *sk);
 
+typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
+
+static struct sock *iso_get_sock_listen(bdaddr_t *src, bdaddr_t *dst,
+					iso_sock_match_t match, void *data);
+
 /* ---- ISO timers ---- */
 #define ISO_CONN_TIMEOUT	(HZ * 40)
 #define ISO_DISCONN_TIMEOUT	(HZ * 2)
@@ -190,10 +196,21 @@ static void iso_chan_del(struct sock *sk, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 }
 
+static bool iso_match_conn_sync_handle(struct sock *sk, void *data)
+{
+	struct hci_conn *hcon = data;
+
+	if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
+		return false;
+
+	return hcon->sync_handle == iso_pi(sk)->sync_handle;
+}
+
 static void iso_conn_del(struct hci_conn *hcon, int err)
 {
 	struct iso_conn *conn = hcon->iso_data;
 	struct sock *sk;
+	struct sock *parent;
 
 	if (!conn)
 		return;
@@ -209,6 +226,25 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 
 	if (sk) {
 		lock_sock(sk);
+
+		/* While a PA sync hcon is in the process of closing,
+		 * mark parent socket with a flag, so that any residual
+		 * BIGInfo adv reports that arrive before PA sync is
+		 * terminated are not processed anymore.
+		 */
+		if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+			parent = iso_get_sock_listen(&hcon->src,
+						     &hcon->dst,
+						     iso_match_conn_sync_handle,
+						     hcon);
+
+			if (parent) {
+				set_bit(BT_SK_PA_SYNC_TERM,
+					&iso_pi(parent)->flags);
+				sock_put(parent);
+			}
+		}
+
 		iso_sock_clear_timer(sk);
 		iso_chan_del(sk, err);
 		release_sock(sk);
@@ -545,8 +581,6 @@ static struct sock *__iso_get_sock_listen_by_sid(bdaddr_t *ba, bdaddr_t *bc,
 	return NULL;
 }
 
-typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
-
 /* Find socket listening:
  * source bdaddr (Unicast)
  * destination bdaddr (Broadcast only)
@@ -1888,9 +1922,20 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 		/* Try to get PA sync listening socket, if it exists */
 		sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 						iso_match_pa_sync_flag, NULL);
-		if (!sk)
+
+		if (!sk) {
 			sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
 						 iso_match_sync_handle, ev2);
+
+			/* If PA Sync is in process of terminating,
+			 * do not handle any more BIGInfo adv reports.
+			 */
+
+			if (sk && test_bit(BT_SK_PA_SYNC_TERM,
+					   &iso_pi(sk)->flags))
+				return lm;
+		}
+
 		if (sk) {
 			int err;
 
-- 
2.39.2

