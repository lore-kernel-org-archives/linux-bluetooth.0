Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TKTFS0rK"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2063.outbound.protection.outlook.com [40.107.105.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D110F0
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 08:28:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpeRMNhhUc/YGPmyMB54cKlAxt/1w4Rv7KU6k1XEgNcbXINlpfvUyAgf69m7HsJBXK2JEn84/7Ii3hyRKKX9vXM0fpyyuC8iNRlijwoID3KLNvf+e2TAgDnq7LrBUSkTRaUMWQ0doaDAVIFzzHykYBMvuy0ifyvgBNPpeq/4BERskeCEg4V2P2JftA3KB0NRE95z6KIf5buLTmIGlQDj5WvvI4g5dGwRuJx9RFxn1vz/Qvw8ZjKu5SY4OEjmNlbkuc4/p3RqVgca8p6vKLuj8si6VZYJl3/FU6zeLAwNH2hs2NBReQz8JDcot6+FY+lsLp+9JDEl0xZR6NrvUsOZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNLGdbTspPRAW1F1Cw03ocwZSAnMmYV89wz+DKF2rrs=;
 b=jL46Mgsb1/Ukn1vipHQ2trGSAk22AgVnDYbZCWj/WdUO2nb5SJ4zAZriHyFz0STc0q2o1Ea46PumhRaF2USatpIYzN0jQVuDrxQV1wG5JvW2p3RAFDimUL17LABvbyKKKGfeUc0C4wHVJrsqLYggp2+e5IQA1CrK3Y/Dgg24yHixgKL6v3NuoUiSMB2wIMBY2LAry7VJ0HEyVaMiC6/YZawaLtwSuvkeQZ67iQnXc4jaIqD5wnqN3ecIRCAgRVGjfAfnjBKT9+TjXARBTEgLzTyHAhin6GQ+Lm7CWezOfF88LMaTc8p3C5Og+9Y9lgqwGg/vb2Q7H0Z5ID/QweGmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNLGdbTspPRAW1F1Cw03ocwZSAnMmYV89wz+DKF2rrs=;
 b=TKTFS0rKtJo3EqAc279eNPCveV6BTBFMAV1WNBRa6vR5azU6AZzW0S5DGzQJmFkSuaHR55mC6JCFDh6NdjTDHWAQ/dMVKMwmHpdjVTv+RZTRDC3PmGYNZqEJx6RzQMyc5k7QxK48jjyI+rfuFsubINDJgagFLFJI574bpdoOOkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB8302.eurprd04.prod.outlook.com (2603:10a6:102:1ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 16:28:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 16:28:49 +0000
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
Date: Wed, 29 Nov 2023 18:28:42 +0200
Message-Id: <20231129162842.3596-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231129162842.3596-1-iulia.tanasescu@nxp.com>
References: <20231129162842.3596-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 11875220-7470-46c4-c1a7-08dbf0f8447c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6qgE4AHAYwOGWueJrGQpjnhLTfcJlVh1+rfI3mwna7C274zeXC9qi8LgFgd5ZbE25424QVR0vFKlQBxjksycepkMRPpfw5+4R3qt88UiigYavdvkBClXn7CKTnyIAj55cnClPstHSDAKJFthkfKpxARehtyGQc1vIbwFBBpqbUXI5S/7lEevAtWyglK7PUvl+XXMq3xN1iVS3OajrMVNbhE+NaG6GAhtzWTgpyBDjX5SE3ODkB4IzACqghWBGlJWjN9iAp104ZJfcv9HyQF2VtceNfZ4OxsCqxQUNghf8LCg/WToF5DUtsRePUvq9ksTYd6HE1jGPwhjId7uC0YGaWJGWL7qeyZF2E+Ve3CUc0M7gafzeihKmy/VFs6kmgzqzrXl58QiTj14h4ZVFfBFAd9irxbUGy7sC8eLyPguV75ic43Tg8s4GH5+MddCYQF+FN7cl2DxZ193nY7a3NzGJ3coqM9jn+XF3k9VWa8JAHivf3J/8eGmltuuCXQg5qC/kVeLIVwXtcOV1apiaLdevUEB+0mDWhMhzudykp38lUYdfcyHA1liuPSQgOr8fD/K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(44832011)(6666004)(6506007)(86362001)(2906002)(6512007)(36756003)(478600001)(6486002)(5660300002)(41300700001)(83380400001)(38100700002)(2616005)(1076003)(26005)(66556008)(66946007)(6916009)(316002)(66476007)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+NBRgOA5pEWMzmhK/FOLR/pBbyjc7pWslVnGoeCNzFdFfrKlkdG0/I0i3p2B?=
 =?us-ascii?Q?ZxseshEVJ73GfKAbnislTX/iuingWMnQ5AiUvbD1ABnkQ7AGXE/rNZcIhgmq?=
 =?us-ascii?Q?Npsvik0V5+l/RKfEt9ylfFjoOy2K6YS/R2RDcXOnMPK3dhSQzDM+xwwJZ/fa?=
 =?us-ascii?Q?W8+shJ1BVwDT2qWigyculVk/HZWeaBKHvxFKNe3pQ2WYWyBGpFy4NRIvRl3F?=
 =?us-ascii?Q?xl8KCjqQ+iNdyLCuRx0TgyVfqxWxa5AXfYoOryqfnD7Ov7PZ1cP8T3i8BHUs?=
 =?us-ascii?Q?YW0etERMiQ/e1kMf+EskOsOERxwtdcrcnzAVVOC4EtVSrc9sTubxLel3Krqy?=
 =?us-ascii?Q?huBxUHB5mlBEjagOZwnizy6Q3UT0WW/S4b3A4WuJXAqEXFFeDPSru0axxEvG?=
 =?us-ascii?Q?moIoAEhyJmU2520/bemZejOpvSysNs+PoYQr5/9GM5oCZwzVoh6/s9S+g+J9?=
 =?us-ascii?Q?A0S0lHTgJNSM7QR3Cukh8T/cuA6rUBt+GpnAclcrUc9Hlbk5IXVmA5QgbIAo?=
 =?us-ascii?Q?BGkIH1tNnh/DgalfFMo8yTwdy8RXeTYb5+kCxpqU7kSmJFtBbM3SEKUoq6aY?=
 =?us-ascii?Q?bBzAIKZkpBqhuFgew36jx2dBDLMSdcgbaJMLO1U+mLON0FKUfd2P0Dl+nruf?=
 =?us-ascii?Q?ZC0anN+KxKkk1Z0stSwJZ6BeKsLhSNBskFscl+sjrlHmjIaiqYGF486bn8gy?=
 =?us-ascii?Q?dC7RYFXwU9tQborQVGbZvH5O49rZkkazNEDJ329RwtrocXYbSncKzF2D4lLB?=
 =?us-ascii?Q?hpjNGnZgP1NeZehUFcx59qMzKOE9Q9sWnIyUqEkUfohhDcd+Gv8z4C4UUx0U?=
 =?us-ascii?Q?uYPglJOfrQWwhE6xvvKIyLU5WC66+TkNexDjmR8TTEnpaxCTFDS7/QsaAmwh?=
 =?us-ascii?Q?4OnWlkAX8BozU1Eh3aHaCiKzMz+HoLmkStmw7V5fcJ5IpI72qeY+1FqXqMAb?=
 =?us-ascii?Q?WAory1h1muEBaE667XAiFN2LrfF9yhcBqPcijfKCBdYAUdw5r6TqWc2hSeY3?=
 =?us-ascii?Q?1OU7hSnIoo2qkjNmqjrj0Op01Vz3Bil9iDOrkhM4YNgicCJupdZ7TSrSDy6Q?=
 =?us-ascii?Q?oXFs3zRAo1nnwWGxTldr19vqB8zirN6tLiIJFM/SjyPrWQbgxFGbWRad+s2O?=
 =?us-ascii?Q?l2U1m3cjJwsfdJF3tlNUwM4BO7AfydegHhDF++g8bvXVta77yQTrUBg3+HAi?=
 =?us-ascii?Q?t/LU9Nl3RnOZMvSc6n4NASgHtllUSfFciW4h9xIqcCGUqTYnzTbk4wfiADMN?=
 =?us-ascii?Q?3OzZb937dCAiiS9qI+cyJFAE631V/xcDH4TDSwByQ6Ui8i1KC6Kv/wMIx88D?=
 =?us-ascii?Q?6b5qcrwtNNQF2l+9lAuPSO/Q7lGt15qqcAbhT/IIx1VnIJSELydbk4xNKMOL?=
 =?us-ascii?Q?iOdpoaXrot8H8zI4SMo73MBYDgf3biFwG4YndjW21GL7oKMJHwpJ/sYaeKja?=
 =?us-ascii?Q?0eAHx9wnL+WMHrobGmqAd5rt2PbHNpAPNtWzRJgbuD72DYQiWvR7noC+6bw3?=
 =?us-ascii?Q?3pZzGHp+ddwx13xqjtJQ+aTQq8W2Cw8vGmJa6qZEJSR1KrAM0TmXv8jJ6jqo?=
 =?us-ascii?Q?jiTI1x3S+7sedB5CkXpICSZBg1D3jMl0xmKt00/DlGQAhU49F8NBOQX94ENN?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11875220-7470-46c4-c1a7-08dbf0f8447c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 16:28:49.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fPuoKzBZxQWpXlrm4+XuuNxUc3jul6+JK/BuP+J39W7pne90OzzGyJcy9x1FEo+56POICxvSm2G1HI1rpeWIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8302

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

