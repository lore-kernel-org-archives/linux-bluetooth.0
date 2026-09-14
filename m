Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazolkn19012042.outbound.protection.outlook.com [52.103.32.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA2B2C15AC
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789377336; cv=fail; b=QKgMae3cDHhIXw3mKg5Qdace4VcP/0SnhfVq7szlj1R92x0rn9HbbF7ngx6nTPhykDQRbfG+Z5McaCL/Dt04d69FJdjPBzNdWD5G7p2SwLmQHF0ZDtwGauw4uhQTOU3SOfKzTsnPOqNs1fBeXKG3elXSgcc1V3FJxbxXh/EhQRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789377336; c=relaxed/simple;
	bh=1em2uW6ZZ7uh1Iw/AC7tGhItPo2hykE4noGDhHDnF5U=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oB+8j744p4eXBJzXeCkTkec4xzyn/X546mu9VKD+P0mbFTQq2VjM5iDoJHJ1R6hWsK5wT+/WlfBCPwuOfurD/3Mko35lcwLhmN5luH89KbxocKbpxv2ajXQTWraRFq7yqgOYAqNGqpNtlW5MDqGXNZECyqHi/Z8svTb24v2zfRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.fr; spf=pass smtp.mailfrom=hotmail.fr; dkim=pass (2048-bit key) header.d=HOTMAIL.FR header.i=@HOTMAIL.FR header.b=nIawAPOl; arc=fail smtp.client-ip=52.103.32.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.FR header.i=@HOTMAIL.FR header.b="nIawAPOl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+SIvlyxq8izym29n9G2GrLt5LOJKcXYCRJSv0ik3Jyzhw+lz0+iXpUX2TsY9E39627bfRkA9UKyM77Xn6c+5Iz+LAV1Y40XAqdgS74LblHN2XhlHjVOALCjmXoCSrqX9oxxdtp10tqcaSfqS1lNUSQ9kJ6quBCdUN0AtCiulOdnd9eAx/Vnrp222w+AUcKuC8vp5RMz8jMAjGVXW9ccXo0uA/7tJ4ii6KnF1Y+0gbFXAEF/RUxSHCquM/daPgKE/JgMWnAa45nBk9hcttS9oepbWzItiPCtQVGmepw7pASBw9XTZJybyM9s7G2JzrVMFxrzr8/PONBX+5hh6+Ur2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QU50o4qNVFjKun/e8C7aTc+AHWrXIsJiPIkxOxf//7s=;
 b=sa5BWlz7xNPEN8c/n52qoeQa7GiQDHqfdL/q8pAgCjp4qLUd/XNBY3vlr6BAeWhr4qZ9AOvgk9mMdP3nxzRi//qvikEMXqcWTx6moERLz+G2mr4rtNcC6XysdxBnZ/8twIYdweqouqDaY9LriyLesPNEpUPDpAnjDnTtyhZAYqYc346GYl9FNe5vEWXJEsSyU3N8oAmNkCfg9tC+T2RuE3K9f4ncsPrVKrV9EjLiLh+Al/6s4VxKQCgWtnquGBf9l9dtZMW75RNYxNqdxM/fLCPQ+Gx92qW436qIX9gdCuCFg8SlU9SKqSItiQyfUfB4GsxESkhItPg8GJdX0Y+6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QU50o4qNVFjKun/e8C7aTc+AHWrXIsJiPIkxOxf//7s=;
 b=nIawAPOlkUMfU+vVqyUM97m2ZNzsqoXmoo20eODNA3WJL5VBtwJjj8cPoCeTx2THOlYTneocZ2/92jyRXbaGoxzXapMMIcYTaATjvbp+dyCohDBzVZis7x+5L1ZOnN9Tvb3hx2vj9UOyYJ/PPc55qE2CzOQntCXfJ9IL8b042YJePGcgQaJ+Qdy+6sbAXTMyLkaFTLpvDqCXR/Yb+ZKjzP/CUfIdP1eU3gPmC94Uf23UND9zVNk8GJ+YJDRBlvs8zAwx3msvUI8Av/g7JOxkMACgg642Qr7XnndTlhNcFzfRpSIt5ZAGG501skeB2b9Vnv2OoBeFdFuqmJsTTvEJPw==
Received: from PAXP250MB0544.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:274::10)
 by AS4P250MB0749.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:575::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:15:32 +0000
Received: from PAXP250MB0544.EURP250.PROD.OUTLOOK.COM
 ([fe80::60d:7c5a:41e3:14fb]) by PAXP250MB0544.EURP250.PROD.OUTLOOK.COM
 ([fe80::60d:7c5a:41e3:14fb%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 09:15:32 +0000
From: =?UTF-8?q?Aur=C3=A9lien=20Rivet?= <aurelienrivet@hotmail.fr>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] mesh: Fix Command Disallowed on random address change in generic IO
Date: Mon, 14 Sep 2026 09:15:17 +0000
Message-ID:
 <PAXP250MB0544B307EB9802855B711F71CBBB2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0011.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::16) To PAXP250MB0544.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:274::10)
X-Microsoft-Original-Message-ID:
 <20260914091517.66764-1-aurelienrivet@hotmail.fr>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP250MB0544:EE_|AS4P250MB0749:EE_
X-MS-Office365-Filtering-Correlation-Id: ccc2ab9e-af33-4cda-69f2-08df1240ba13
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|24021099003|19110799012|5072599009|8060799015|39105399006|4140399003|15080799012|23021999003|25031999004|24071999003|25010399006|20031999006|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E3Chx4/utGijEqFvHLCfPaY9wxrym+TCOtSvk6/xghIuxOjgDqVoejiapsBU?=
 =?us-ascii?Q?7YQi5gqSu15K4wPuH+YFmZLY2d2Uu6yvJeFV1glYgazuYeOVICXF9I8z27Hg?=
 =?us-ascii?Q?6T///WW1rvdqImg/YL0DhyFm2F3XTxledpsbRzJ4fQH6vbH44Kv3FZHYgrRd?=
 =?us-ascii?Q?t6P4gngPETAB11mfJoQqNShOa8wG0OVmGrtY8Axj51iuQ/O17aJu4fyigcLq?=
 =?us-ascii?Q?BOMfmGLqQorEpr8sETbYBoLZ0GFdDikKhe5zd4vHfhPSUpC4zvUl+GULrVc1?=
 =?us-ascii?Q?lFWnUswBwWKNj1IA1K5cEeGVH0PEqPtwZuswNDe8bCRJV5rp5/dwtnvX5QMr?=
 =?us-ascii?Q?y853BHotVVa1vaFEqCSTlHCb/VogTR+PLjajZ2KF+W0N2zQsLjU6aIHYxMU+?=
 =?us-ascii?Q?kRmnKK78tkb/idyoaH9U00xsICUQ7D+E4W2+d/6wIy3cMP2vGP2a/38CdYyX?=
 =?us-ascii?Q?Pxe6Hg6RLby2/p9pdOjSO5sRYzbNlOK7MpRXENq25gDKuGwimD+N8pmullqb?=
 =?us-ascii?Q?Hk+qTCqFDNRmtXpcCJNReE1xqQsbbbze69DPRrc2F7aYW+E6B02vUJYcEhVh?=
 =?us-ascii?Q?Canrl4B8j8iDyJXM1WUyS/K8UgJfq0ISZKoS3QG/AQEjKra6sHaYlowCwbQz?=
 =?us-ascii?Q?CiNxLqSlLk0uitob4vd8pJl7KvOPncssvm9ql+GqxGtB5Ty4H4uLBoMx8rsb?=
 =?us-ascii?Q?Inyvv8jffkLilmJ1BRFzouS8ATlHf+x8d9j18uPa05wZaXMSt8WdbNepOJP9?=
 =?us-ascii?Q?EcSnPhZGeaZGPesXtEELEgPQVa4luPrIlV8bAVEsBt77mtcl2ssKHu0MFScR?=
 =?us-ascii?Q?WkSAtfYS65euwiDiAWaUVTCuH+jqjWJsp2GdsdqyiDZJTzbuHH0o+QIjszJm?=
 =?us-ascii?Q?Vw9OkTjBl3qdLJYFBD6wUo1ahsvOeYMXkTUDehUehdP9jhQzN46Tf6vAbbiz?=
 =?us-ascii?Q?99aB7fL+x+TE1sfl14dMgVG/2pRxVKmSiSU4n1FyLMKLPSqVlWo5IGhg2dnq?=
 =?us-ascii?Q?qDEJ13f+eg/T3Hy97lRn6D+NP1I9Wm65H3yF5phSuanubL5vkdKL6Y0t3DBz?=
 =?us-ascii?Q?95fwv4QC?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RUEAff9lRpMbNXVPX/0/auIUn+2BeTPYlPQUXSjg5yvKOajBrecdm8lOaArk?=
 =?us-ascii?Q?pLRRrlhanFb02kSU3zanolewzp3l8ojk/MXoBWzVQSM7nA3GXddBpcsN0aFr?=
 =?us-ascii?Q?IDaS6v764dqogC7T0OjGoLYMkwRUG7jrx+ZWenQFbY72UWb8KhvMF7qln1es?=
 =?us-ascii?Q?uqrl1VbgUxyOETzF4npoCEjPacvXu/P+lUN5Px0N8Z4jjAbSFd46FlI/kiMi?=
 =?us-ascii?Q?SuXTrbh4RmjAhvfXcbrNwV4Fb6VODiT2tRd9vkHTowdVTKMDYzGIRVPHU6O8?=
 =?us-ascii?Q?0RsrZAKGn1nh7EU+zUFQzxxRiAzMi8irAZny45bl/bewZzMwCjbaq4+am4Sa?=
 =?us-ascii?Q?6VW9qUDwWUC/J4dHADmA/FDaGDh214pFbNx859ybqSopOFGtzDsmHgXYwz8x?=
 =?us-ascii?Q?E3OZlm7GwJMawUtZBzqSAHEXX3gAsDbEIgcRORXouau+GCYdbWW5gGI3oogp?=
 =?us-ascii?Q?DzsbDqhLYs7yXUG86beFuT13eVcB1jkbPEF2ixMwo4UbCb3gneXRRgkwniXy?=
 =?us-ascii?Q?yRIQJ3YjpKYoWJl9QGGf1nNwN8ZaYfwDyVfxFUrDwi0MsAH2Jj1bHhg9Vamr?=
 =?us-ascii?Q?RIkRH4zwlxWDmZ+hYoIXRP1lBrSyBPrglAtElorKQHONFarE9vlZjL9K5Rdy?=
 =?us-ascii?Q?DTsYpO6b8w+t6DQ+w1ABor+aug3tE8C/SxBTchYigqzN2iDYriXLHAqA+1vY?=
 =?us-ascii?Q?KAlDDaaZibIOqFZQpWtu0pKu2fiFQ03OgzeX3G6i5FmQ3DjFDoT8dGb+iR9g?=
 =?us-ascii?Q?KBtG+xo56aunuKVRTh7mExS5LN67i5g5qmg0bR3M0FpVjfpm29RR+r+UybZ8?=
 =?us-ascii?Q?LneB1PPmyEM7u+a+n1WJAhL1W0bNmmCBnBAfdxc5R+FITwVV04XjwZ0C+1c/?=
 =?us-ascii?Q?Fwo4yJdJdX6zuoKRjHnAovNTQKCHz08d/tesyF3ApA9mNspj8YBu/HYrLLX+?=
 =?us-ascii?Q?kz2pU41HtoVCuwhGJfNC/2GuXxim0PSXhZOanchJgG4jC1W8UT5g4RAWOZCJ?=
 =?us-ascii?Q?lnWXoxUvlLt7/rexM+2mS5/6L9uD+EmSRZV14n+aXkWDCXpc+1tMwuRkfta1?=
 =?us-ascii?Q?PYsT+SYn7D/N9p0RIQBLbkET9RyMsL8+6Ciiy5gb9SrUZveaEeMzhgSCwd7h?=
 =?us-ascii?Q?Gy9NF2ssez9I7m1unHyc8giJRETb3oap4UC7ywrw6xJQY+kYsbj4KmZ4saln?=
 =?us-ascii?Q?Y9lWxVummERb6F8Kg4YSGt0aT8J/P4ARCTapU8TtW3CO3wvAvfcy3ZrtrN67?=
 =?us-ascii?Q?u+uEcJJMXAb75DyEmB4FiAsqZzdRtP1+hqXZI/+UO8696mMRSSj3Csq9xoVX?=
 =?us-ascii?Q?CDrNH2Qr3xjkaHeeYoY5uSIM91LZa4Ahdhmkgj66wYbKx2LS/6nfsKHAjBgs?=
 =?us-ascii?Q?2VdWuxCptKjbMFfcdqVMJq4xzfzulAefi6V/WbHQQfNLHYJC/g=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-6108c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc2ab9e-af33-4cda-69f2-08df1240ba13
X-MS-Exchange-CrossTenant-AuthSource: PAXP250MB0544.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 09:15:32.2554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P250MB0749

send_cancel_done() issues LE Set Random Address at the end of every
burst of ADVs. The controller rejects that command with Command
Disallowed (0x0c) while scanning is enabled, per Core Spec, Vol 4,
Part E, Section 7.8.4, so the address never rotates as long as any
scan is registered, such as a provisioner discovering unprovisioned
devices.

Pause scanning around the address change and resume it afterwards,
mirroring the disable/re-enable sequence restart_scan() already uses.
When no scan is registered there is nothing to pause, so the address
change is issued directly.

Confirmed with btmon on a Raspberry Pi built-in controller: over a
60 s capture, 12 rotations about 5 s apart, each one LE Set Scan
Enable(disable) -> LE Set Random Address -> LE Set Scan
Enable(enable), every command completing with Success and every
rotation programming a distinct address. No Command Disallowed
anywhere in the capture, where the address change previously failed
on every attempt. Scanning is suspended for 1.2 ms to 2.6 ms per
rotation, which mesh retransmissions absorb.

Assisted-by: Claude:claude-sonnet-5
Assisted-by: Claude:claude-opus-5
---
 mesh/mesh-io-generic.c | 68 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index df1450ebe..7f65ec4f2 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -39,6 +39,7 @@ struct mesh_io_private {
 	struct tx_pkt *tx;
 	uint16_t interval;
 	bool sending;
+	bool scan_paused;
 	bool active;
 };
 
@@ -454,22 +455,77 @@ static bool dev_caps(struct mesh_io *io, struct mesh_io_caps *caps)
 	return true;
 }
 
-static void send_cancel_done(const void *buf, uint8_t size,
+static void set_random_address_rsp(const void *buf, uint8_t size,
 							void *user_data)
 {
 	struct mesh_io_private *pvt = user_data;
-	struct bt_hci_cmd_le_set_random_address cmd;
+	uint8_t status = *((uint8_t *) buf);
 
-	if (!pvt)
+	if (status)
+		l_error("LE Set Random Address failed (0x%02x)", status);
+
+	if (!pvt->scan_paused)
 		return;
 
-	pvt->sending = false;
+	pvt->scan_paused = false;
+
+	/* Only resume if a scan is still wanted: recv_deregister() may have
+	 * stopped it while the address change was in flight.
+	 */
+	if (!l_queue_isempty(pvt->io->rx_regs))
+		set_recv_scan_enable(NULL, 0, pvt);
+}
+
+static void send_set_random_address(struct mesh_io_private *pvt)
+{
+	struct bt_hci_cmd_le_set_random_address cmd;
 
-	/* At end of any burst of ADVs, change random address */
 	l_getrandom(cmd.addr, 6);
 	cmd.addr[5] |= 0xc0;
 	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_RANDOM_ADDRESS,
-				&cmd, sizeof(cmd), NULL, NULL, NULL);
+				&cmd, sizeof(cmd), set_random_address_rsp,
+				pvt, NULL);
+}
+
+static void scan_disable_for_addr_change_rsp(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	uint8_t status = *((uint8_t *) buf);
+
+	if (status)
+		l_error("LE Scan disable failed (0x%02x)", status);
+
+	send_set_random_address(pvt);
+}
+
+static void send_cancel_done(const void *buf, uint8_t size,
+							void *user_data)
+{
+	struct mesh_io_private *pvt = user_data;
+	struct bt_hci_cmd_le_set_scan_enable cmd;
+
+	if (!pvt)
+		return;
+
+	pvt->sending = false;
+
+	/* At end of any burst of ADVs, change random address. The controller
+	 * rejects LE Set Random Address with Command Disallowed while
+	 * scanning is enabled (Core Spec, Vol 4, Part E, Section 7.8.4).
+	 */
+	pvt->scan_paused = !l_queue_isempty(pvt->io->rx_regs);
+
+	if (!pvt->scan_paused) {
+		send_set_random_address(pvt);
+		return;
+	}
+
+	cmd.enable = 0x00;	/* Disable scanning */
+	cmd.filter_dup = 0x00;	/* Report duplicates */
+	bt_hci_send(pvt->hci, BT_HCI_CMD_LE_SET_SCAN_ENABLE,
+				&cmd, sizeof(cmd),
+				scan_disable_for_addr_change_rsp, pvt, NULL);
 }
 
 static void send_cancel(struct mesh_io_private *pvt)
-- 
2.55.0

