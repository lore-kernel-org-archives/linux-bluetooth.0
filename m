Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010022.outbound.protection.outlook.com [52.103.32.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD1B503BF7
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778093; cv=fail; b=rmjQJiXvTmgeHp0g7YnsfO8KvntI46GYEL4IXCOgTimGS7QDKKph7ZRXG8sww7zmwmq74qYS/1oWqgPXVCSYz3Ns80oIub+62+C/PulZOkFHJsJnutAja+NYg9mq5y3nUPjldxW4aIRjtMpSPiXgmSgT3bantI+lN/ThUkyEWd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778093; c=relaxed/simple;
	bh=eN3Vaoy1odARuS1bAqcpYS/WIqAycYb+1naa0xjsOsc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pH+SWw7s5UGkVGdqGVI0jz7eRHueCo+oIGHUU+0xAl+f+LqZ/OQhGzQw08uebid7YmbePFG7NXIWmMU0krOB8+CxzGa6ahW7v9MzFUg8YxadrTMfGxLqC4UP8+0y2xr9l0mj33NtIRduglsLWghhE+osDOU3AHEByvZiBo7VWtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.fr; spf=pass smtp.mailfrom=hotmail.fr; dkim=pass (2048-bit key) header.d=HOTMAIL.FR header.i=@HOTMAIL.FR header.b=VCvOSab+; arc=fail smtp.client-ip=52.103.32.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.FR header.i=@HOTMAIL.FR header.b="VCvOSab+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deyV3HF0Jos+yJ+SwzfWjjbb1o6tBGq9TOtuGaVIpjtfgdTgnleYbZACqshbVQyp+Y5pyw1Ej2i98czX61rpsJ/xgz2QJU9zkYbqmH0WEETQdna/Ygdq9bAw0//8iFRTPf3J8IZ+rONtgX2Zvs+rpAYJTq0VYaBjnRm2u2k0hMbKCx7SYbLhWvudrD8h45dTJv+xYFwdifskYx+YdvDsmuH/7Enb6Pf4aTIwxbwOd2cQRuGQFTdfgjCYKFjFtwxmKBM34uz1Mhg5DGzQ1Vps2srsZmQDi/6++iebLOyVenAYWInbgSD1fanE6UqbnKqjqWKmPW6cSbc1ZaLm+gi0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aAJ5SiDcDeUUEqj3Re1O5mwLfqV0nxFiMuFV2QYvCLc=;
 b=anHDnBwIEW+kuPP1jwmUaiJ/hatMjh5hsLg9BHaaw78zIZP90UWdNVM8Sf+cBX2mVlTdXN4nGZonHGPXpMHjY7SvG5DQA0bVJAMNu0kP/zT3sbFHm4nI+Sh9rPDhP/2xdKNaUG+D2KVMDuIHSqHQGmW2IjRKFUxoDCLEM9yAIuJTBCqtVfOstVB2ZOqQ7pTKZAcu4RNsUr7fn1MBK6XCCUi6Rk1IZqIwdSqnuVNBo1SGPMR444abRKMA1Z5insbdUmaiwpLd59rFWMwUzHX8K00a+/p8jkJUCSUlOP28t7mU4ZQyroJckm4pcshYpM74Gm/XjBmMaKqldISNCy30Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAJ5SiDcDeUUEqj3Re1O5mwLfqV0nxFiMuFV2QYvCLc=;
 b=VCvOSab+bz50+LRuoQT3m5ciMVWWfKRG5al3BKGQg5U3pIkAQx/BRs4+gPTzY7clkGRfjsBbYTKtDSaAVqPJaMfOv0oduXPdPfjsFWN0vTeeFasCfo5BL+ddVD0/5nLBLXJG7juWKn661wVmQ2R2qsb2TFYAED0ckcliIcsjhDr3WoLU6gZTENuiVz+T/gRg6ROB/KGBg+DP1s0PsZ/zrLF7u50TIswM217Kp03I8Hg1AQNHxgI6aUpNOXI07t00FZKckG+0br1IZC6JIMzPqvHQL9x5jts6ak/MZIU7t/qgHa7M9skS8TFRYD3pdbp1iDnlCLU+8IKyT9Oe1fZBUQ==
Received: from PAXP250MB0544.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:274::10)
 by AM8P250MB0073.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:36c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 14:21:19 +0000
Received: from PAXP250MB0544.EURP250.PROD.OUTLOOK.COM
 ([fe80::60d:7c5a:41e3:14fb]) by PAXP250MB0544.EURP250.PROD.OUTLOOK.COM
 ([fe80::60d:7c5a:41e3:14fb%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 14:21:19 +0000
From: =?UTF-8?q?Aur=C3=A9lien=20Rivet?= <aurelienrivet@hotmail.fr>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Aur=C3=A9lien=20Rivet?= <aurelienrivet@hotmail.fr>
Subject: [PATCH] mesh: Fix Command Disallowed on random address change in generic IO
Date: Wed, 30 Sep 2026 14:21:04 +0000
Message-ID:
 <PAXP250MB0544C1A2B8FE7294B7757FEECB8B2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::6) To PAXP250MB0544.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:274::10)
X-Microsoft-Original-Message-ID:
 <20260930142104.310897-1-aurelienrivet@hotmail.fr>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP250MB0544:EE_|AM8P250MB0073:EE_
X-MS-Office365-Filtering-Correlation-Id: 946bf761-0e0e-48be-8ea2-08df1efe1846
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|260925184616899003|5062599005|15080799012|23021999003|41001999006|24021099003|4140399003|25010399006|19110799012|8060799015|25031999004|440099028|3412199025|4302099013|1602099012|52005399003|40105399003|2607281247196008|10035399007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BSWdxWSdXv7X268lv+qLjAi1nH8lU8m710EBVVQQdzC4ElJNoHyRo27L4Z4V?=
 =?us-ascii?Q?5R3EnDsM8BBWuaEilKJ8j1moHxxw9OrdBmwwYlD0yEg/5pVewbz4TvahDWzA?=
 =?us-ascii?Q?6tAmo2Y3Q8pvJ/0dZQs4gOKIrYiLL8W9YnxlwxbI4rNdSwNxXuwdYwpfZrYZ?=
 =?us-ascii?Q?/h1xEvpPBFcMyUmWbi/k87m9/gWInTgyzFcZa6vW1MHX4EQZH9mNgwp7VNUZ?=
 =?us-ascii?Q?XeU1zbm53cY1cg+K3jRHZLShz7RK0xThkNYZXJraT0hyTSukZBNfotehl94q?=
 =?us-ascii?Q?K35jz1rnNfTNmSugtt03CjxeYFzGUnngDEtea8M7LvF7wmeNyY4lRFSC0Ntz?=
 =?us-ascii?Q?yjF0ugK0xeJrI5BmIMsYqu46r8ydzTqiGA2k6X8c4RobpHqbSKx7zANkBId5?=
 =?us-ascii?Q?tqFK4SCV/xVxfTRzUR1TTMm7BOjtrOtfCIdwKBmc8U9mhBMznhIYJNwpHG+Z?=
 =?us-ascii?Q?daMC0+95xJnTQrbNYXl0xPzcgPaEoMzXDKjaf/JKnYYm+jxDjjl5VU+052sK?=
 =?us-ascii?Q?Vr81+mmAw8xOmLOePx0AetNkcP8YkVGP1wtVDOnJMFvc89MeV8HZrqTDb9xo?=
 =?us-ascii?Q?3PAh8ylQaYIkxz/0vWh/XAHDeg1gKL8si3wz139xZo9PYbzV1wqY2Y74KM51?=
 =?us-ascii?Q?u5iJQQWEmsA5+TPdG9k9m+q3CSfnDdlWNXqwG1pAKtgCizhxBZX5AsPR+KRv?=
 =?us-ascii?Q?C46gwjzWrmNx/uc0aJ6j7/Vf4uoe7pjf6YhULRPU7ziLRWbKS6Z7PEaiKBV+?=
 =?us-ascii?Q?qosZmDCdyCKvYb4RZcSNmPt8h7MKpFm4GjVjz9kE40ZqXFSQKF9CF4VuZK1N?=
 =?us-ascii?Q?x3cmVWB7+qstLQRbttP6FqWQAcCN1i5xjW6miZIgMk1sZgtjLzSqkKk2a0lp?=
 =?us-ascii?Q?oHqr4AH7spVH7YJcGUef+qYWcb+slDG2Cv/8u/y8vsOPvmBNgNTUTXWXK17v?=
 =?us-ascii?Q?efr2edWSz9SojliZ1phCgEQYb5gls4zpSKSPeMmaJ/vc+eDh3nXUlEZPpW6+?=
 =?us-ascii?Q?YSzi66QyqN3/SsB/FGeKDTkNjpqKb/Z11JX7b7yb0KTdwxoPwbdBHA40E1mR?=
 =?us-ascii?Q?ksrANhoQPqtHn8zhn76rx+Bf86cZTKUQl4CCyfQ/hk0ljO6cUF8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l2vS6UOtN5tu0l2hH1CW/8c+9ZaRO/T1zEQuhL/HFxqE1kpB7XwHPXo7OoEJ?=
 =?us-ascii?Q?1BC2MHiEyDMD43c3iI/c6fIMWsondTqE4whNdS6S4s4IuxDbdHhUKIoyQ5aj?=
 =?us-ascii?Q?nM+X8dNoPBx/6rf5M0fcavmofpqSizGqrs2F40ByMHh5PQMDQXM5E34zC8zi?=
 =?us-ascii?Q?M4GermHOjB3O0TCnqctG+DXwfZzMPU3vqeoJBx0itTrjiD0Kp2V/5xf8qena?=
 =?us-ascii?Q?aTTYGjbgSyc2Fvmr+DP5xfRbARsnShE/0gYWtAr0aUyZvEuDWkBZOvCxukK6?=
 =?us-ascii?Q?93FgsVOwlNlhpDhEn1gPKeaePwSSEun89DXNCz5eikUZJ6XaDR94Ue9InEKQ?=
 =?us-ascii?Q?QmggJxZT38md3Jzzik93hKzXHF2Qz19Mg2xLPDsRJ0MC6aOgKZ1l1o/5Z7w/?=
 =?us-ascii?Q?Ed8tcE6yMHHvrg8kRZsJ1Ij3JL0NnXuOtSO4F4UHfi93cFiaB/xjlfymgEsd?=
 =?us-ascii?Q?o2asnTZCSG8Cf/KuSMKg6PQaJO7Moz9dYdHgtiQoyfD3IBFw5MS1iq6Fmmig?=
 =?us-ascii?Q?sLK+MyOkk6EURFRqsv0J1L6K00bmsH7ncDyKu4pctkum9EFxevTu8L/lMdDm?=
 =?us-ascii?Q?aOmUsoHyG3sFyIVJSyWHxaXcm2rJgmyQsS487fUuUuGsswUi6YkrxP8n9oNd?=
 =?us-ascii?Q?aWIaGf0MxkFVFVy6bF+cUlfipG0VeqnENemmfaIMRPD7VJ1lWEx3FzvO3wg+?=
 =?us-ascii?Q?pfxSjsljg5h0CIMdbYhbN81bb8dBdtpPBdChMN1WeXj7acKJFmcbRz25j9lg?=
 =?us-ascii?Q?6P9A8PxxfF2t846sJvQXzLezuwUqw3RRD0JqoPP+O0ih5PVNMnlJvTp6wncR?=
 =?us-ascii?Q?37HGAzCJhH5BFUvGJCKGRabqlpCqNS5zpbmZy7XWktMxPHYgd8TxLQCpzytF?=
 =?us-ascii?Q?IyaJT0NRrHAJdAAKi5XHSk0jzA9jqx2Gp5tvnOT/QE13tJ/FZgoRqNAWCnA/?=
 =?us-ascii?Q?dUIWgpnss6kmI7sMC4u7DhYmow5LymLwT3J7OvZto9PsJsNjwtuCZM19Nqu8?=
 =?us-ascii?Q?WBq3qg1E5SJ0y6vECdUtwAAB681Uum0H1+aJ8dsHvq5J9/UkcI7DygRS4UQj?=
 =?us-ascii?Q?A/bO8mEfm0xvoZQyZsdAzJ/91OXJM1cjs3fxzj9KcAoqqRL9EqRMnnl7HH2z?=
 =?us-ascii?Q?RYj/9bMg8Hd4jLmJCGp75dC3YLpGpmlez9x7T3tEztrSud7vOLPU2iZVGuh7?=
 =?us-ascii?Q?ATzvCjzhIMPrDvOt+VQQ0kP21b6aa3lcxTMZsPKTTFcm4OF63xXv+r8H+Q6p?=
 =?us-ascii?Q?cS1+dwRnKKrbQlIvK7T0JFOiVTvWsNXHjIwqiX2gF+q9ReMDXVPwOEkUBvJD?=
 =?us-ascii?Q?Fw58a4EAzIuMYT0fe4UHxxXDAstK/9cH9O7R/Fpy/3uZ8GCAiNqNryojFReK?=
 =?us-ascii?Q?WFP2naexYBhsTk405+OdB28ghxyK9FxNksYm0DBHmbFQzUKrWw=3D=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-6108c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 946bf761-0e0e-48be-8ea2-08df1efe1846
X-MS-Exchange-CrossTenant-AuthSource: PAXP250MB0544.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 14:21:19.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P250MB0073

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

Resend: the original submission was archived by the CI bot after two
weeks without review, per the automated notice on the thread. The
patch is unchanged, rebased onto current master.

Original thread:
https://lore.kernel.org/linux-bluetooth/PAXP250MB0544B307EB9802855B711F71CBBB2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM/
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

