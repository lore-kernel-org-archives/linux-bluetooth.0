Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CD2381C7
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 07:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796488; cv=fail; b=tx5sqjzbyHAsqWFEleKK17yxGOEtU7D7JaIDOK/7ETNpl2CpE/B9QSO+r/BfvXor928aICl3cwVE+8FhZ0fzvi0JonwW9A61aM/NudFW8qG5MJbDjr2aQEYj187JFnRP5swjkeiu2PHisQYk4f7V/L5R1Ju7deDt7E3q9VMo4Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796488; c=relaxed/simple;
	bh=D5X6+l9KJxJnYEPYv/8q8VXyM3QN7mBAltpooAsDSug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ch+D2ndtzftligYWVznh2mpKrDmgMXXvEcclkY533Q2sdCldD8MalnUhgX9IGzxBSSV9C/G4Dy1PzHc9Pc4sk+mQ8mmBllgyNJ8+kPTmTypWLgF4YZHojEyZ1D8BM5sybuAlMOCMmOlSWgL1HztDayPj9A8FsDcIdjGL7K7OSpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GjxhZliP; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GjxhZliP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWvgB8/Ej7ZO2abt+Px4CRec0wowVNeljvsLsD2cDYxCkUartR8vqQ8jFnqwyIVgOjqJWddVapuleaouWmDIK/zlwRUInQUfthuvk0JtQVIuFurNvShb+vxLkTOiIoYkKn4LUTZHN2ZQV9GS/qBjkM+o19D/z5MSoaneorHo1Nd/cYSIXOB7lixJStcbU7IRBUFwNUeXR+p4q83zY+8LvIxHQrsuz8ABxdQ3CUHxPGCUesymKnZd3Q4AKDp8ajjE1rbm5J6zduvxJ/BPMKKceBRgCwH7DEH8P2NB5jRY89WOJSUec5LWwqLsm46L5sk7F9IrvNI5GqC1li2KL9MfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEbmjwckAdgsx/Mi6bzehewNIASH8ahNLE6WytM+6Oc=;
 b=JOGCWM6WlXhXcYNGudQ/PMOgcOtiZKEZ5+loa0BGKP6oT8QJx2bkvEeUmCjfIjk/O7hFkZhxChw9nsOU7jDcO7gEdOcAI3DtbKFWHCoVmahk+QBk0vunuDoQDhzC4cO16bNi52wmTUGCXmBeX5a7XUDCz0H4KrmzvEksMBLYla51oRPYALkykpBeQkdpi/IkBU8OOIMl19qfd09p6g5/z5AwXH96Q8o8rBUp3wKJVnJWmoSXA9e7gfrqglfzeRVK601QNycOXvwyPzxRma2430Dxf+CpGt0l0P698DKTOWooywxtt/jLZBhwzyw7pQucrNs/ZcOzXFLjhP4VeWksqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEbmjwckAdgsx/Mi6bzehewNIASH8ahNLE6WytM+6Oc=;
 b=GjxhZliPz1heiCa86l3NObDx1k3UNqwSAmQz4tIABAb3XubLowlW6wQPp4gTrT/CcjUNvKEPkqiMkujypX810pE6golbFDO1DgvdkE7Sbd9BkouD6uP6HMyVsBj97zQrEcZXofvRYtZp6SoF0NqQPb4QmKzEcYDyFbFuv5PjOQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Mon, 27 May
 2024 07:54:45 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:54:45 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/6] test-bap: Add Broadcast Source Establish test
Date: Mon, 27 May 2024 10:54:20 +0300
Message-Id: <20240527075422.18953-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
References: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::8) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 160d25f6-caa7-416b-a1e6-08dc7e224613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FDr2lrTUQAwYIrhAjEZLKnexXAz07R2m8mKD+kKEZgZ/vcnTJxzibihrEqXT?=
 =?us-ascii?Q?vImj0FHR/FdyYHElFOBw8KhRbO2N57C+n4vzrhQ63eEcyilxdwdgJdbMJiGB?=
 =?us-ascii?Q?PqKnzKHa3rLf4rbJK5cAqYQcJpTTIleasF2U7dCe2hSWOofX5F9PBZcfahSY?=
 =?us-ascii?Q?NdwbDi32cp61+bej6Sys4Y6TKQQFBsrqanFC+/wGTofw/BpJNSrwlT0qzQAW?=
 =?us-ascii?Q?tlRRoMK3v3mXE/ZPbZKhuwQLyQ0oJZxv/dzs9+HELKy0Cqk+HU7YFT5U93Tz?=
 =?us-ascii?Q?g9OKE0/qEn70lgbOjUb7qXTKJDvZVACK+HaZd88/Hr5sHFfWPvsZuPr6S6uw?=
 =?us-ascii?Q?jZSgatl7MvYnwoKEsqeOqOVfDDz+NwamtpVJVdEL5nokrjUgmIwZZE5AR0Iz?=
 =?us-ascii?Q?K+u4S363iyRw3ZXmPbg0Fla0e6P7raXrTSH2kC4XMSRHmFsFKuMZtpuIZECT?=
 =?us-ascii?Q?gSf26rUTAc6AN/vouPLUdEe+HMLfWxMo4WKhOaGNKWXRMSSmoJCobm2iYFnC?=
 =?us-ascii?Q?Va1ePjYbNl0LAB84ZGr9fCfC5reA4pMJ1lpLSYhWKxHyz/GGlUTucuuKDlmj?=
 =?us-ascii?Q?4PN6w3zFSplh+tuHen8lzfTbvIfLRA7OOIyOT4mqFse3QM5kuHXhw9MUQrvK?=
 =?us-ascii?Q?abdvGs8rVifOTZ2E+ekJAOP9Q0BsvqvcuByfSpKITnbU4CKqnk0dtMz6CUYO?=
 =?us-ascii?Q?s+3BCn1Z+dGl2dg6xP+7VpLEbiR6FXB68mbhDFtjUG5+0x9dnMhptIR4cRMP?=
 =?us-ascii?Q?BW6obr5kLdpnG//RyK0MeYF4ua9uqdjeHSbk5EFjyUIoUNBTySW7zyu+Ax5e?=
 =?us-ascii?Q?o56P6VYjYuKhvhX19i/KCuISu3iDKSIaq9cS1i3Sj/+bx65vqhg3U/clXIyl?=
 =?us-ascii?Q?XEGGjBfYbp6cVQLNv0fgznL5d2gdbWIhV7HD/emIZ5uMGGpQRDKU4PqPu563?=
 =?us-ascii?Q?ZvizyVP0/cV+B1GIMXGgLenirMG6IK41Lm3xHaIeVV05aoDdG91tjWKT99E1?=
 =?us-ascii?Q?Z1VV8wkLO9L6I01XBrVKsAz8refEsa7wxflXtkns78BSVmN/Ucoe60K4fhcy?=
 =?us-ascii?Q?AlEtUvHPQtp2wn2Ek0UIDQwfr4UC+Qf+aGpN8PbgfPVVLyWKJI3cDSddGBbI?=
 =?us-ascii?Q?L5MkI3ywEvLQQcFy8LoY+fpSzeAURdhpilMz/R1g58BzO8vm+Ug2j+NLXV7L?=
 =?us-ascii?Q?Y8u+FGJ05MIz+0cNcDZzm+b9ybAlTGCP7mBx3HmDzmaqbZKURhD8BKD7qRff?=
 =?us-ascii?Q?M/Zf6NOjlgHho0Tx6lytyQb32YOvODAra4TOFXbNCA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KTLrGB/KnpZ+tJJJ3YHE+Y0Vy4NZZT27hBM1CYhsIhxL2AzaweeDVY3gVfmj?=
 =?us-ascii?Q?bom9EG1kWtfUQNeYKV0rTiYImh0/dekFSgpvqrGaooxw6kF8txI6KuQI2wL9?=
 =?us-ascii?Q?UUpHGNxYkTRkHCIsP394Oj6hfapFHVn8H08K0uonShThJ/J52o+mbwBJpfkn?=
 =?us-ascii?Q?fazA5AP13Q05Ww5scOmvHcp20itcSf7df1Qy5YbdK11EChPRUzJxX3SUM0Dj?=
 =?us-ascii?Q?HUXQJ8c2kzhDcADgJtyPiKiAVFFbu0Qf0jRCO+A+2z5yUPnpMmqXtymHSK5f?=
 =?us-ascii?Q?+iY6lbf0KIdA4RKQtlQMFi7AXLmylG/2MDHs3kRrAOXZVcWbMCcAKyIf7kEg?=
 =?us-ascii?Q?rh4CinhU/OD6KGDoSKTj+FF9/H4BEfrLgIYIFTPNauxBR+x61fj62UDoPcXX?=
 =?us-ascii?Q?aqlo++ACixcvH4imibSnbm+GgTY+bwPzmPUxQYAPcqbLKs0ZjyDRhIhQv6Oj?=
 =?us-ascii?Q?V7QiXMNH9d4vfGT42BePAGk3sMFdStKB/UCB7p9LvAnh4mqgtglBymrlJk2m?=
 =?us-ascii?Q?m1gDV+7LJZEVFx3gKQVW7xW9+fnByZlz5/XiWbZhekgATaFlWfXBgQSb09BQ?=
 =?us-ascii?Q?F2eDKWh1UiOPoEF7Wfgrw8pLdRLmD8IPoLeRfVYr+5/OW0TuiJl+h7zI72m9?=
 =?us-ascii?Q?BYpjzd4rLomPGNK6icqj3sZTKUfm9b0GZTBK/USP4Xph2GzoUOzPLO7dnIex?=
 =?us-ascii?Q?LQRGQQCZdqiAjAE6qK9vlvydL2kGR9lRwIquhwFHrSmf8QccJJDJV3abnQg8?=
 =?us-ascii?Q?CpZfkWEz32W+YEGoShxcNBmsVJPUyiybBAiMZNS23WCihWB/cztG6RSqMpXi?=
 =?us-ascii?Q?2+knP3ttzlP2EMzgpdd1iK00T8/AbxmJbXNm4FEaXxoBhYA9UAIYVdskH0+n?=
 =?us-ascii?Q?cVpXIWYV3zVcg5q6VBHIESk/RzbHnmY/1ENsw1/Ez1uM02sWhvUP9fNSdris?=
 =?us-ascii?Q?WCRMb6eQlG/94YVinbB8E6sAPdXrZbxFeDvNWG8DZeJ1CjBjk+QV1yW2eGad?=
 =?us-ascii?Q?zIjA2mG4yE1cimICRxsQW++6f7QkZKkUA82KPCglmCrjiDItVjmcWeuFYaYw?=
 =?us-ascii?Q?Y119b8liNnTzX7cBxxdtqaorM0RgIEnKgnhFV8uOvxk3jqdaRS8WjL8VTkxt?=
 =?us-ascii?Q?7piJXGspATZ0ZPwRkizlEUO5VduCn6mbL1YRovp3GHkzmkNDBEikpfME5Pf3?=
 =?us-ascii?Q?MhAlDnxntkQJWBkOsNnru/Q+yQwjERAItA2BzuNo+aLjvJrJTcgVcgiWCQAU?=
 =?us-ascii?Q?q2lFxLXnbHQq6V0cvaEmt0IbYi1efzSP2LCDGSfHQu9cNbNkVgsu/Ixpb7Ws?=
 =?us-ascii?Q?xXgl2SlqgGUcX9rlN/VOKflkkSeAeif1FSuE4P9VJwSpJKLPoH44MwZirt8p?=
 =?us-ascii?Q?52AJPdKCJ7ymtULoR/IkBEL3/mboOrey60sAxTMv1WOxdN2wkMMRuAQuPQ9Z?=
 =?us-ascii?Q?RdtxGRIMjUXI52icyIGW4csjnk7FC33uDaDKNoKFfwa1zZCeQ8NDjwB+LwJD?=
 =?us-ascii?Q?Q2ORwLTv8UA+fq0YI3nVs1MPWGB7GFpfV6tEQssgYu/z/mKZKQ+6JYBUIgt5?=
 =?us-ascii?Q?8+vdLn0HoHML9WulhO/8gEQYTM0W9TKtMvamw5OKcqbJpB7JauD3xGQX+8iX?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160d25f6-caa7-416b-a1e6-08dc7e224613
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:54:45.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhyAY5JXKtZb8+2Jx3AkFtZgm3/UxQq4NOGZhD/tMsIs4ffCAuGHSSDa8sgjd2A/fQmqJeeKRBBVrcmgjcfcSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

BAP/BSRC/SCC/BV-35-C [Establishes Broadcast] (page 175):

    Test Purpose:
    Verify that a Broadcast Source IUT can establish a broadcast
    Audio Stream.

    Pass verdict:
    The IUT sends AUX_SYNC_IND PDUs with an Extended Header
    containing BIGInfo in the ACAD field.

    The IUT sends BIS Data PDUs over the broadcast Audio
    Stream.

Test Summary
------------
BAP/BSRC/SCC/BV-35-C [Establishes Broadcast]         Passed
---
 unit/test-bap.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 9cb4ae8d8..59e056e05 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6029,7 +6029,7 @@ static struct test_config cfg_bsrc_vs = {
  * Each value included in the Codec_Specific_Configuration is formatted in
  * an LTV structure with the length, type, and value specified in Table 4.74.
  */
-static void test_bsrc_scc(void)
+static void test_bsrc_scc_config(void)
 {
 	define_test("BAP/BSRC/SCC/BV-01-C [Config Broadcast, LC3 8_1_1]",
 		NULL, test_bcast, &cfg_bsrc_8_1_1, IOV_NULL);
@@ -6131,6 +6131,50 @@ static void test_bsrc_scc(void)
 		NULL, test_bcast, &cfg_bsrc_vs, IOV_NULL);
 }
 
+static void bsrc_state_estab(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_CONFIG:
+		bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		bt_bap_stream_start(stream, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		tester_test_passed();
+		break;
+	}
+}
+
+static struct test_config cfg_bsrc_8_1_1_estab = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = LC3_QOS_8_1_1_B,
+	.src = true,
+	.state_func = bsrc_state_estab,
+};
+
+/* Test Purpose:
+ * Verify that a Broadcast Source IUT can establish a broadcast
+ * Audio Stream.
+ *
+ * Pass verdict:
+ * The IUT sends AUX_SYNC_IND PDUs with an Extended Header
+ * containing BIGInfo in the ACAD field. The IUT sends BIS Data
+ * PDUs over the broadcast Audio Stream.
+ */
+static void test_bsrc_scc_estab(void)
+{
+	define_test("BAP/BSRC/SCC/BV-35-C [Establishes Broadcast]",
+		NULL, test_bcast, &cfg_bsrc_8_1_1_estab, IOV_NULL);
+}
+
+static void test_bsrc_scc(void)
+{
+	test_bsrc_scc_config();
+	test_bsrc_scc_estab();
+}
+
 static struct test_config cfg_bsnk_8_1 = {
 	.cc = LC3_CONFIG_8_1,
 	.qos = QOS_BCAST,
-- 
2.39.2

