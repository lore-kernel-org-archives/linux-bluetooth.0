Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.32.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792692104;
	b=xtb+PTWG2AKv2yFDXX5Qr0UrGEzOFHGwJP2X1rL82anbKhMkFR6HPsy6+yX+J4vn51Ps
	 kfk1jyv/hYuQfxplXrYPZHDXjeEVSfncD18MqYMJtLOq1oJAqjc3KXWgYbwV5IGOD6NSX
	 OrH1tiK9XxPqMYMY4Kn+iPlCkyDEQqw8T7zuO65/FFbLYl4zfG8033qvI6NGfm8gAdEOC
	 ytO48lTJUgtDD44pCLc5RFbjJZQSnoZpPmC2m3JFlVTGkYLwXSQ8Fid+PsYX9CS6iEUPm
	 ftr5zvaRFlViZIknxwwy5afsueahY/3P7jKE7CIUh1bEkhP/f5APvjysNcpRAaPOhWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692104;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=qbQMboKqo8lS5xurYEBHMJWMiSychXTxcMJ5zoT629Q=;
	b=c61aziW0i4E9tHhHKSyTb+nn83swb1rUGDk122M+BGx1SiQVB4fMCixEFZNfCeQfmLBC
	 4dDJTcTHY9zKimLMQvK/OQGsNRnWFv4MO+QrSHhlvQAuTn2CaV+ehbh5IkCiv7P9MUtFE
	 BRD+c4us4IueiZsIE3PEAmGLGOR9pqiMVupF7h6VImCGakJtCZ3tMY+Ysjpe5YjR6KRQk
	 gPCMEGSAcSGdZHre0KZnk7+loRqbDRc0B+om6zlma6Bke4KHDmQi7wDSnptiKdDWuc7eb
	 cEVQYPRInAGjpLRovNUydJwH5IgwcvQjSuInBMBCHSX49OYCvyItA5Co5WMvIx5sCEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hotmail.fr;
	spf=pass smtp.mailfrom=hotmail.fr;
	dkim=pass header.d=HOTMAIL.FR header.i=@HOTMAIL.FR header.a=rsa-sha256 header.s=selector1 header.b=NOdxtOtX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.32.17
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010017.outbound.protection.outlook.com [52.103.32.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1266606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 18:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1266606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=HOTMAIL.FR header.i=@HOTMAIL.FR header.a=rsa-sha256 header.s=selector1 header.b=NOdxtOtX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iigh1dRYf+ungiP3zdBE8+agj06YIBh7eEMEzrDu9Fy49LRg9x/8vO9TT1UxPFdSQlmyJ7UAGjho05N3e3QjmxDr/3zz8d6AOf8Gj0KrbWH34O/RYmYSSoclKfBqIyUp4bJHlCGG727/iT8EMjHX9hTiSgMyCU/w6ZP3wugR1Gu0uV3fc+aCaOSHQ/measg5lTg820X8TVurGKGBDzJU2i+j6e6idK0o6xpv91gEszDlqu74vzHDYvZIbyLXmn4KxhWOt5IOPEzJqenyktWs/oj6+RBB7ZRdsp8DbTai6diBbflxre6ytvppC2W+b6Cb45wQhjELqefaWB8UWIaB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbQMboKqo8lS5xurYEBHMJWMiSychXTxcMJ5zoT629Q=;
 b=oh+7Myy2Ph0j/waaptosukdwcMuth90yUoZv1o7YHNCfQ7yfxHZWh8E+2+b8K6ve34dYniCBzHNZ8Pz1ImiDf9/AkJ1xICUvcTiginoBpuWdqvD0O3azC3UAODLXKbCUB7zpuIJMTl3hGpO99uwa+ZEguqk2PHeRbebNS28G4Wo6BWqkLQzeke+BatQLpcww3Eg4xx0pTi8fqthDVFhqO0C2HC/HgCOR4lMdFL8NSS+PSkqLwUKOIDy+ecvL2YIoh/A0sjwHbvntwTON59sh/ozGc+XfPIPk+NROAAbPMLWBxRPxtpeH55DyJymRrdpspSUabuHgltLVxLYne24b8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbQMboKqo8lS5xurYEBHMJWMiSychXTxcMJ5zoT629Q=;
 b=NOdxtOtXLSHdiRoScM8KDf4V+xVbYd3fa5UgsQhEkO8gY+E+DeXlClafryuG1G13LLHwjjO14FnfKQaD/TsAsqnH+eGGIHokNqNbpV2eqXLHgEsFOLcvYu3SAuYFueqcLw5offiykCo0GalMKbalvR96EdRlqbw8zcm+OJKt8DsvTtzkaxGx2N6XWhCVOrZyVhadyzrYkJdNMIuDHqdIdVG3dGLXX71MwIUHtJquf4bdKK+rzX7YWM9SG7h6y0SGhx4BC985aCbWWbTTFxcBFvYLOESIki0D12hwpOX7w5Rfe3UwlLfeXpgy+cNca2RaiU8T7JJyC+Q24LKSUpznvA==
Received: from AM5P250MB422204.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:80d::21) by AM0P250MB780948.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:806::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 18:01:41 +0000
Received: from AM5P250MB422204.EURP250.PROD.OUTLOOK.COM
 ([fe80::fab3:4855:b3fa:baba]) by AM5P250MB422204.EURP250.PROD.OUTLOOK.COM
 ([fe80::fab3:4855:b3fa:baba%7]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 18:01:41 +0000
From: =?UTF-8?q?Aur=C3=A9lien=20Rivet?= <aurelienrivet@hotmail.fr>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Aur=C3=A9lien=20Rivet?= <aurelienrivet@hotmail.fr>
Subject: [PATCH BlueZ] mesh: Fix Command Disallowed on random address change in generic IO
Date: Thu, 22 Oct 2026 18:01:26 +0000
Message-ID:
 <AM5P250MB4222047E08E92211215A496AACCB652@AM5P250MB422204.EURP250.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P191CA0029.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::34) To AM5P250MB422204.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:80d::21)
X-Microsoft-Original-Message-ID:
 <20261022180126.2086979-1-aurelienrivet@hotmail.fr>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5P250MB422204:EE_|AM0P250MB780948:EE_
X-MS-Office365-Filtering-Correlation-Id: 37374617-41e9-4e26-fd8c-08df306686ad
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|25031999004|51005399006|41001999006|15080799012|19110799012|8060799015|24021099003|25010399006|260925184616899003|4140399003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uKFUK9sVDtPMv+4nz+oQsFedN2Vw33PaGMl3PAZVOz7HrdEcOUXaBnCefsAB?=
 =?us-ascii?Q?yHZlomq3wawRCdAGUc2DxXEkg5phnkpMzf7xPNAAqE3xi0pBmdB9xiXIiDZ3?=
 =?us-ascii?Q?sSE6XiiM2I6Y7rAU/l6JxPlhF6wbrfQvsCruRGBGGn6lNpFWHR3YffVkypq9?=
 =?us-ascii?Q?1jzUkP74hPADRpanG6SE12uBhB8XghkOhqUIeDALYiadTWIfPE678ZBoAjwi?=
 =?us-ascii?Q?uhOa2enKl9w7I8QI8093J0c63rTs6wrF1Qx4BEwPrP6UdFPo5UvpUHGbC/14?=
 =?us-ascii?Q?HUPlHvl2jr2BKErC9Jc77g9HUB5J3eoJ7f/QU1xp5Y3odD2pgsmYXFroyylS?=
 =?us-ascii?Q?ucEQBfPkBIAoHyGISjCf3GOsBNgPu82RPriKpdnhj6wJDvneHKaEB1Xamub9?=
 =?us-ascii?Q?0WwfLGA/aWvutWX+HaTYxsSbdO0UEBRyy0JqLQha+66CfEb/n0cnAnsen4Bh?=
 =?us-ascii?Q?yvx7mdBwIcyw8EpSGpL6JwYIPA4GJBxpPuRlu2LnNVHYnYhUJwiEyExjmJne?=
 =?us-ascii?Q?x45qEQNdkwXdNpVoCXU4yHu1inmMU3SmcxHzXDWGX/Or1923zhaVd6lHtgUo?=
 =?us-ascii?Q?ZKM3MU95jCFHOcyD5DEaWEp9kycW2kTqzWiFNeK0a9yewObNO+QtZKfuQ7U4?=
 =?us-ascii?Q?OCJsgnomzzlULMg7sH9/i/Lj84DZEtWSZnKHquBUryXxW7Ov4S6N8u0+z5hw?=
 =?us-ascii?Q?M91nxjdAyyeXYlxW4kK2CPPHFQahnV0NSuWZlXE6ooCER+btahi8dGw7QsHF?=
 =?us-ascii?Q?Fy/yNfaotGeaXS+lzAbc8SAyjhF4p1g+PE10XPBxWlcryCpqyzKcEbsIM8be?=
 =?us-ascii?Q?dGCDR60oDrOUkk9N4J1McLNPDIa3fBYfUFbpTQHzCnt0fUhGZQ8YGX4lct0A?=
 =?us-ascii?Q?UTYPpKXF+p2MK2r2N9oxR1gwi4IVkPkAz5uSKCPgREDO2Vw2O9UQHrKHjw3G?=
 =?us-ascii?Q?Y7HtIVb80TziNCOK5cGlumywgFmhwFjfGnKrjRpRWc49NVPELEZyLcuZF5mS?=
 =?us-ascii?Q?2MTASZHEjbUzzyT5VcBWujX1YTih8SXBGSn9yGP8NPza5xk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aTKXyfmsXSPk1Japu22367pvogH9GCusLCOLWBMxcP8foMywi3cybyFv9R5N?=
 =?us-ascii?Q?9VtXs4g8MppOmwcGkCHYnKJ4PLpy91CWQ2uXIVinOvzUrJwiW0j8/V68moo4?=
 =?us-ascii?Q?D8Wr9rDV16OV9JJTuBVbf//uERAczDO0/D9yXCh8IXxiIOeqwzwao1cKf1VE?=
 =?us-ascii?Q?D87tzkmAazGoRsST7o6DoEm/dVGIBcpXmXHPFt0sZkBlE6+iqOemqY2jIC9Z?=
 =?us-ascii?Q?mFA2QTLPeH+XrmdXIbBq0HukJjVDqr8JNzaN3wVZD1w/64tY7wDKaPOMPg9a?=
 =?us-ascii?Q?yoQOLmU7hIx3yN2iA6VLqjTqUt/YOYJXpr2BG4A9bjtz7HEZR7apFS36rscV?=
 =?us-ascii?Q?WiHf566gZ31yVfIuesx2b2hed8Tb2VTUO8fClnnUu4E3Gxe8lZScgN+ZUsyR?=
 =?us-ascii?Q?Jgvqd7DScewfEeXpcqCWgXd1JPKHh5YqcsJFJh2z0WwYMSZMheEuzQQN7F8f?=
 =?us-ascii?Q?OfsjXReKcB3RZ4wIWZc5eR/TyjqLhyRhoXzP4tnL9nJk/9TriL6/SZyPoh8+?=
 =?us-ascii?Q?ljEySKTrpnrxrKpm9Chs1s1xUlMAky1biKFFcALkAU+aYHycgNk6fk1+pU+G?=
 =?us-ascii?Q?0zPJiHhU3BgVV7sBzxIGnamBTz5HppRLrWYam4S5WhbpUxqgU5Jz+23OywRB?=
 =?us-ascii?Q?Hifqz7Z2lmEtPPqEdMrt0t/5ls0YPA5oF205jOn1wnNGIXKuYzVSYnO/2dyy?=
 =?us-ascii?Q?7zME8/24Vzx0c9J4MD1uRfhe3UUi3nDkvAPUxcE6c/DiLpw0a/cABbdo7zAu?=
 =?us-ascii?Q?QH26LimcTGVgQgazWPfJZKSTD81IgroHFQHHssb9DJsC/xciLs8qp6jrRCEv?=
 =?us-ascii?Q?3Fx0zF53zKt7pKXrXhfT55bERHjUmnWf3J/1G76wYlBdjIWEplT9ieNq2Raz?=
 =?us-ascii?Q?8+iJB/9kzJBjEs9tq78PCFMjqXHK/aXenoJxjufVlMv6a0T7lCiVzjX4iDse?=
 =?us-ascii?Q?w1Wfyq8IrZaJIVfIXsKm7KL8gfa95tMgXZ8zbj0o8/ug6/8qmEVM/svHlTaA?=
 =?us-ascii?Q?yfpACQ23N34PPLe1nZamMUS2UblVArG3R519JWLyZkKPS68g6ufPKZP3nO7U?=
 =?us-ascii?Q?i1X9M+XUfDZ5oWPOzSdngl50uKI1ThV31SzRgGJRa5poKhGQYla+yRxKYkY7?=
 =?us-ascii?Q?+9GcyA6hmPT6c7maLtiKvcFwkTNrzZZnZN0wPeosTLmY2fUNDK1B9oMf4BTD?=
 =?us-ascii?Q?8Y0H0cZRMwAc2SRBGNyx11BoCJXPwlxtviWPp5hP3k1WMHTQ/1i+juuSi7hs?=
 =?us-ascii?Q?NAiDR4gW92izG0Y7LPfXJ5VKHbuFjr/e+PQiXle1YqxxZowv37I2V0gf6iJV?=
 =?us-ascii?Q?STpMOfQBNpxtul2wNWwwKq5gwiGMy6Dh7d4tZ9Q37DvWIZN0J9XG1jLkjFgB?=
 =?us-ascii?Q?ISUpImt+OpWUfaJPr8oNRPHavNeBn/qkeowatkL2dAlyyQgimXCgDfCR5VRM?=
 =?us-ascii?Q?znmgIMVCTJ0=3D?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-6108c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 37374617-41e9-4e26-fd8c-08df306686ad
X-MS-Exchange-CrossTenant-AuthSource: AM5P250MB422204.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 18:01:41.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P250MB780948

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

Third submission. The first two (2026-09-14, 2026-09-30) were archived
by the CI bot after two weeks with no review. Both were sent without
the [PATCH BlueZ] subject prefix required by HACKING rule 6, which may
be why they were missed; this one carries it.

The patch itself is unchanged, rebased onto current master.
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
2.56.0

