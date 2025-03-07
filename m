Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FD21D58C
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362331; cv=fail; b=gz4qrscs0A57HmA7Es/Oqxz6/hJVMqfwcKuThWynHS2eGn52kBCHZj4y2tGgJWdqcF0CvR8EfbHL+ashnrUNjArXI4EUCqLzY/+m9Umz749Fp8u6pwMhmk0WEiFRixEGi0q9uCrsJMQZtHjOOd/f0HBWu6PEDVKQcSd9vECJkyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362331; c=relaxed/simple;
	bh=HIPqziQ8qlFgoZTLx9P8+jQRLqpiKJGlG7WkjCW9FRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QHAGYP5L28mkeVoAcLSIRcfQM/COL2wpwqzYBIdlLw5BcKIrt7V+54kO0C2F98W3qHqGwlQmj/Jj+kWm5BqBSGl/cMgWstB+a6R+oHL8i/ZEkykib8q8wUEmby7OGEdJIZgNjm9sbJXAVj25Guj6Og+KVtVS3AKVnJVH3BrHKg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fjvIPLOk; arc=fail smtp.client-ip=40.107.103.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fjvIPLOk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISUjfDlKf+4BIVhIDYfk2q+S+KTPNNYSDx8VcAgfprqdZ53tZmyk1itwsqoTqWaKTgz8CgsAXSChdX7v6alJCKqeAmpMypPpl10WLCaGZunU85GDiuIqZslGFheSOS+UqAGfCHxGqhpt91NLPs9HT9OzyWiMG6DMkokzA4CRIwSW0b4t0Npc/wInWdpHyzNw6UJy0hLW9gOMHtutM7GV+S+vdh6DQaAcfRV54VaVFCznka+dfpvy8sf8xOL/zmgeT8X4rk/IcE5TTZ7WAojMncw/T/OZKupHR21uy0SeSycv9mFCF+chVfmLjWxTx0JUd5CAW7qs2/YufHwvr1Ovxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sw5nJcV/Qj4rYvZjXxQEsiv0BUgoESCtR2fefkpOqpo=;
 b=VyyPQFNPU5EzC7Infi1ISeSIJLyOnxfgF/Xux2jdijEzJRmARvlLeMuJeWzvBlMn1lfalEPdxHQcrS/FvLv8EW+h1mSY7YCO8Ks/YwxUWJNylfd/gcoLM1E/LNZT2fsdW2tkxr+M/E4CSpS59gLb6zQtGd1URPWjd/DFCD+tTQphKsohMmLMp0T/0j4hYBzDJmy+mtHvN2agj+cMtGq+YMSzmKbGSbkfSdN2UiXdZp7NHmYy0HRx6CY1sCM1DrhXQvONP5QCkUM1ONd9VBd6GV1Ctx+ICyhygvGMKM3NVYGq/TFYQgHDzTXr9W7Ul2rCQBU2frDC8YbKnQMc3Ujikg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sw5nJcV/Qj4rYvZjXxQEsiv0BUgoESCtR2fefkpOqpo=;
 b=fjvIPLOkQl1NDueNNIw98b830dsmSSuaba0d+RdPgVJq6jKh2j5KeuOeUEOuHdRm0l+cqDTfBiv4eM26gY+pkfIF/0Vw0vt/nj3xfKrD9PrBuXrzY8qFBvkA8ohg4JrwuzsnnQv7BGzE6p/+eKlotuush04vCuy4kz9zdngTvMEDNSm+xnelEqJooT82frOOFxzqKOOveok0LcQMIa4nnSdsllWyTz6dfOIOomhPemVAukYhOk88WIdn0KXIZhmrcyixomCpNbULD0S9uYqYSK+75jjL93q3cMJ+rWOU3Z+z4H8smZLujYOgM1PXzV73LCo1Y5g26EfmFSAw4FurWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:45:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 15:45:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/6] bap: Move default qos to shared/bap
Date: Fri,  7 Mar 2025 17:44:54 +0200
Message-ID: <20250307154457.85751-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
References: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0124.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: bb830ecb-f45b-411a-2e7d-08dd5d8f13a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?auEiFt/Pnndg4/T5ZnkWPz4Jx9goMkSEudoMdQ1NiMT8B4MMdSNWuo6tVaG0?=
 =?us-ascii?Q?jy9MKNdKVf9PlGPLQ6aE8gygjP7hUZdYAGia1LXdOrTObk023YZRrpXNCEJl?=
 =?us-ascii?Q?GbGrNGmLqP1B4qoEWAd4viFn1bPwQ5+vhGJrT38P8+na/dVsU9y8ET/Te8m2?=
 =?us-ascii?Q?m5NEA84fP4jZt40wcZW6kfb7bRXiS0TuW9C55CdPkLqwZ9QwO45PwLtjdmDJ?=
 =?us-ascii?Q?giCbjqe+p2JAKCzzLrNWFUTohTDYL3tRA0dKzXEuCrbAxJk0OANq/lWhtpYI?=
 =?us-ascii?Q?KQ/RG+Mne9sHmzCde/0P3FOnIXGvB3i2er8ELJVdpFHibdSfGTClVIszwy4d?=
 =?us-ascii?Q?JYBdPyIE/VWImTlHDxVA7xqT/S8vuTP50Yj5YiqrrWTbS0AUMOsqUHLDOpAl?=
 =?us-ascii?Q?YqCxDY+66uQpVRhxB0HmMwzL8KWf7qpmKHhLUYtct1PwwLVOP2w5240a3h/l?=
 =?us-ascii?Q?F62/0GUjayXFoJXD+nHDomU5l6ZC4D8y/5JG9P4TwTtvOBHKpcfPMjoVenyh?=
 =?us-ascii?Q?DdiQ5EhCKdUHdtBg/urpyPd3y2NrmciAGnnooXMfH9GswPrQt67jukbeb+xd?=
 =?us-ascii?Q?xFjAJI9cMVRVDYofFXBgWL+Isr3mWnXsU/v6vMoPAfWlda5PNanINtgheLq5?=
 =?us-ascii?Q?AWCb7W8IPOMcbo/2yK5ShxHWMGfiD/xdfcTN68YUJVPPIgk+JKXPmzMnxaWN?=
 =?us-ascii?Q?2G9qRE0cl/Tm9KwjgagQQWSJDPQEVocBLK2P8XSaBHdQcNtyTLh0vpZr0j96?=
 =?us-ascii?Q?TkI6K8wPNO297qrCU4Pdu+Z3tYvjmSuSmCTJqrehrW4zwLvKgVyqArx9TxAI?=
 =?us-ascii?Q?DHlfoVjuYudyIbgX72IVjJxNu1s4BW8sURg0Ma2Hdt9Yi9jKQwRmFFJcrVc6?=
 =?us-ascii?Q?Kas+vJkTcwlg82rcqr36DrC/Ez7XsgsC+agYe7Js6YQoieei7o2yICXHJItQ?=
 =?us-ascii?Q?10LXRU+poQADfyzdK1sjpwNNfkYNI23OxzidZ2wIm4+XD/tCDwnSOJqdva9w?=
 =?us-ascii?Q?bLUTa64WTY8R44vtUNdgSJQ4cP0WQvl82uXapMtb1dfZJng9XB09sklTKV22?=
 =?us-ascii?Q?7zBBHvpRbp6bFJz7UH3pb+dwhrkZsK1AP+ASTxdEpyW95Ijj5MyM4mRFesOn?=
 =?us-ascii?Q?e3WYLJffJWU8CkxA5lYgjjg5VgV+UXvYVcKEdr6UVbsqLjq5TxTsudRoR9RL?=
 =?us-ascii?Q?LlMSKvnOgSkhFcO9cq19IyYS0j/JjaglYqpXTT+7RKqBVqaPR1e9y4faXkx2?=
 =?us-ascii?Q?XnBwevy7QLNfdO81CKHFD/SBuBY/LpYWQx4kOoXo6zlDHBv/QbwulsHlKMXd?=
 =?us-ascii?Q?6ypxbtPQFwFey8sumL0L7U1n+IwyXODut86PHxktgzr/xegB/UDRme4XSEhW?=
 =?us-ascii?Q?bNFn1Uu7pbPs1QzJIbeDgNd7akeT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OOktwMaMWoKxwBS1OVA041QvxjUR92YOyUNE2N69IAu9hhCWoRMUjGaKfL0P?=
 =?us-ascii?Q?zgGmXwqvjJDIvoLDGE0bzTgVb09A4TNywuF63u5M4TtYU3Hz17QQk3S/eow6?=
 =?us-ascii?Q?ZAbO/WiHlsr4N7QHe7p0pqJqDw1BESVgUk1vfZQjRb59rTrvZktQiciD22hq?=
 =?us-ascii?Q?O8cxpPnZgfWzURVjLNSAZAgL6UL0gasAzCn3wv0jV50pC6DZIiYQi9ojY/Ew?=
 =?us-ascii?Q?1kb4RQY7+UFECTRei4VTasX3W3MCR4g3mXmMOZFeLVvFuHT6kx0CH8wRWm/+?=
 =?us-ascii?Q?oOIdTLO8QJ9srbD4GnH7rq1SG6VTb59E4gQlm6WahcklVkI8+f5np36emGcM?=
 =?us-ascii?Q?vAbv525oUyU0baqdXlroYS89mNNn0NaXMMSYNZHr7GPje3pK4q44rWO3SG6a?=
 =?us-ascii?Q?4ZF2jabZFIo1DCcmuMCnr/Zc7hiGgzLPbQjLQF7uRNDjaXKBTukvd1menko/?=
 =?us-ascii?Q?feps4FuB7slcz9+zDDf7iYjtGr3ipUDPxD4VJ3J4DRLe1Smd+Nb8nM5qXMa3?=
 =?us-ascii?Q?mbIaGv8/BJ2XVLqnFAcOYshahRKVq015Ut/oFuLrGgpuLp5tOokYUEelhFUp?=
 =?us-ascii?Q?dZpQEGKJbS2JlO2+8kC1Ezu4fEScn6vOzTPvJwA8/KmI9gSoo10qT8SmtLvg?=
 =?us-ascii?Q?e9hHc8xsA3PlnJ9JYkU/T7/BrI3yCaFQoWgW6rORtQyofiKurw7Tq+CsIFu/?=
 =?us-ascii?Q?axk0C2tAF9HrMeoRQJyvP7UlFgYgizH95Pqlib09A/wvtviZodkwO1Mmy5Ho?=
 =?us-ascii?Q?8XDrHHxOF1pKj1SqBi2FiyJy4KY0YJ3PvhjGBSdjdXLEl+gbON3QE/DDa48m?=
 =?us-ascii?Q?1W5fw0A6RssBTVl3rUNr4gE+535hW087qtOn6FMoNhBswMhAL/KvPXYSZtb1?=
 =?us-ascii?Q?qIoo9hSQ+6nt/0aEkedCkgXnLouKWhirENY4HD6zhd3KIxYY5WMuMYXnTASP?=
 =?us-ascii?Q?AUsShAfnwM5vUOWBDqGNdM7vbFqXLZ9eEHnlNrMH2hfRzSoTF7nnNzijnWiV?=
 =?us-ascii?Q?Be7r6fvj97TKIcVouRINa8SULH11vcl6r4ZlvkUAd37D1hBA8VgWElT1/OIi?=
 =?us-ascii?Q?KpH7ck9M2Bi40lCfNpLKlXWFhNexBE8+4GuOgtmuubtfPiecaaIwYHG+cwM3?=
 =?us-ascii?Q?/HCko4HETtIU7CDG7Rh4qzUOTmm1+yYOGKOtVLQMHG/UlsvJ3CmhdQgekJ+3?=
 =?us-ascii?Q?6ifjkU+Mml8H8qP4/6WgbUKeXYv8q0bpr6LpkzJ17RsxYo46tNy3Pqju+MRz?=
 =?us-ascii?Q?9N+tcJOZfdi408HYghqvkrmTiF71ox205Qn16wLU8HXOuOz9CyMdwlz8whrV?=
 =?us-ascii?Q?VyeuwfCAujyBsjWM9IN7uzvne5m9XUrHl9UpTF2fZ/lfJq2EseDN+BzH0MFT?=
 =?us-ascii?Q?EJV9Upfh2dnxpju6rjbdRmS8NpRZ6miyGPimKPztfI9tPKm7sm9/TRJ1/i0t?=
 =?us-ascii?Q?hFPl/2lGjrmQdAWXLF3cAKG/9B43BYeAp3mHQf7Jd2nQT85XK1JmOqyUZReg?=
 =?us-ascii?Q?Sn3QIXKL/gN9XTVjZN08qfa69yW7X6R82Z4tRor7XmqN+0mpMOy+a/WORkKA?=
 =?us-ascii?Q?gq+lgV4T/QErusGa0kz40dr3P4nODjdTBPfyd4sObUaeXJRsSwMj4e5yNbqP?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb830ecb-f45b-411a-2e7d-08dd5d8f13a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:45:24.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbJnt0Z1nv4Dmtj25O2h2xGS3lZvNfIl+w5va4gEkBEOOnHsLSusx0ybZX0gbifIIQ38H2FJ5ZJLdDrAZpd23A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

This moves the default BAP QoS structure to shared/bap, to be accessible
from other plugins without involving the BAP plugin.
---
 profiles/audio/bap.c | 39 ---------------------------------------
 profiles/audio/bap.h |  2 --
 src/shared/bap.c     | 39 +++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h     |  2 ++
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 0dc5b4004..1889e1a1e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -115,45 +115,6 @@ struct bap_data {
 
 static struct queue *sessions;
 
-/* Structure holding the parameters for Periodic Advertisement create sync.
- * The full QOS is populated at the time the user selects and endpoint and
- * configures it using SetConfiguration.
- */
-struct bt_iso_qos bap_sink_pa_qos = {
-	.bcast = {
-		.options		= 0x00,
-		.skip			= 0x0000,
-		.sync_timeout		= BT_ISO_SYNC_TIMEOUT,
-		.sync_cte_type	= 0x00,
-		/* TODO: The following parameters are not needed for PA Sync.
-		 * They will be removed when the kernel checks will be removed.
-		 */
-		.big			= BT_ISO_QOS_BIG_UNSET,
-		.bis			= BT_ISO_QOS_BIS_UNSET,
-		.encryption		= 0x00,
-		.bcode			= {0x00},
-		.mse			= 0x00,
-		.timeout		= BT_ISO_SYNC_TIMEOUT,
-		.sync_factor		= 0x07,
-		.packing		= 0x00,
-		.framing		= 0x00,
-		.in = {
-			.interval	= 10000,
-			.latency	= 10,
-			.sdu		= 40,
-			.phy		= 0x02,
-			.rtn		= 2,
-		},
-		.out = {
-			.interval	= 10000,
-			.latency	= 10,
-			.sdu		= 40,
-			.phy		= 0x02,
-			.rtn		= 2,
-		}
-	}
-};
-
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
 	if (!data)
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index 554670d4a..2bf93dd93 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -7,8 +7,6 @@
  *
  */
 
-extern struct bt_iso_qos bap_sink_pa_qos;
-
 void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
 				struct bt_bap_qos *bap_qos);
 void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 63c4c05c7..ce579e171 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -349,6 +349,45 @@ static struct queue *bap_db;
 static struct queue *bap_cbs;
 static struct queue *sessions;
 
+/* Structure holding the parameters for Periodic Advertisement create sync.
+ * The full QOS is populated at the time the user selects and endpoint and
+ * configures it using SetConfiguration.
+ */
+struct bt_iso_qos bap_sink_pa_qos = {
+	.bcast = {
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout		= BT_ISO_SYNC_TIMEOUT,
+		.sync_cte_type	= 0x00,
+		/* TODO: The following parameters are not needed for PA Sync.
+		 * They will be removed when the kernel checks will be removed.
+		 */
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.mse			= 0x00,
+		.timeout		= BT_ISO_SYNC_TIMEOUT,
+		.sync_factor		= 0x07,
+		.packing		= 0x00,
+		.framing		= 0x00,
+		.in = {
+			.interval	= 10000,
+			.latency	= 10,
+			.sdu		= 40,
+			.phy		= 0x02,
+			.rtn		= 2,
+		},
+		.out = {
+			.interval	= 10000,
+			.latency	= 10,
+			.sdu		= 40,
+			.phy		= 0x02,
+			.rtn		= 2,
+		}
+	}
+};
+
 static void bap_stream_set_io(void *data, void *user_data);
 static void stream_find_io(void *data, void *user_data);
 static void bap_stream_get_dir(void *data, void *user_data);
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 198ae50c5..248871b12 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -50,6 +50,8 @@ typedef void (*bt_bap_bcode_func_t)(struct bt_bap_stream *stream,
 				bt_bap_bcode_reply_t reply, void *reply_data,
 				void *user_data);
 
+extern struct bt_iso_qos bap_sink_pa_qos;
+
 /* Local PAC related functions */
 struct bt_bap_pac_qos {
 	uint8_t  framing;
-- 
2.43.0

