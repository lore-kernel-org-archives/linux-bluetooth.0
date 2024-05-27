Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2268F2E636
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796495; cv=fail; b=TaJkQUFCxHqpE6RzDxJxkMPaMekbT3rQ8nZ3QIisB84+GzaJEH/m++IaiWFAQXriTFmj3UOC8p2OsWHpjQG+ZtIGl0oivNoNREt48fNn8fikA84J1pY27tvjxFJmECkUSu0CSlrYItliU4NgPp3AeXm+HRSEeqHlGZez3hSb0dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796495; c=relaxed/simple;
	bh=uF3dVtg2xbratddzgTVurKfcLNrlWqZm2sipYdVHitg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ct7aua3Her5d4MBsTOJLvlFqhlX+XcWf6hW5a6W3JP4i/fxzOvt596pVmHi7uEyYkFqMwWpPZMwDA+Fdln1AEV0wpy8L39bFNsd9HgVH+jPjenEDj/lbiZxTU5URVCJOqkeciRvHnEdMKYQo/of/VAcNp7jdoYk+i9Kc1JZv/Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P/J844Vc; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P/J844Vc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrtRx7iF6Ro0M0PYestoHESvq5n/1NLxMpTB7aDsiHu1lUg6Y8JjBpx7NRyYqHJpE5vZXPys9Sc/H+G7v9540l9Ywza7kpyZu7FllWRYcwL1/FZrLTLjivxT0qZmjA8MbsazzeyyCnHPUg6XdBRUPQYa3XnBaKevO0pGuBQKlo4NhbMPzATTBpufWj268tXzf+NyYjSzPA5l0hjkIiU/ESGR0SsGROsp8bwXxxdP1Zfl0D40vu/rLWgm41Eb6eR2QOHCcGfqr77QYd9/RwrfShkZAj5GujAQKbmOwZN+EhGyYmyqgzYAtWnId3i4zESKYcdRB5oLzFdn0muKA6Us5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtFtycgseYDZtaGFkkzlb0ASvHE9l9o2b/SlFw8qKqQ=;
 b=LXL5EGmuRESzdynQ+VcjsMnAsJLn1glsoLMZPfrWryiEJLFviFYT0Wcf5ZNBxZlX6nJJf6gLJYrSgl5iSrtxl+b99niQfuGsKxTHcS+e5iVYEqjWCxVw16SArTIeV0eO5yY7P0RigrylIQpEcHfYn4C3qznx2lSO6fUGB1lcDGxLQ7/RaKmaJ5LymB523wa5zpz56M0VrUCfbrWp/g7/0odWzYHTa6BUuA0rvxnHG0PRE0Lus92zmozCLBOKJO9rEVwAHqPyeeI7PNMWk/WBouyJkm6/M1lb7VC5WU+Ybjlb0yWydqPI+BGcuw2cI7xVC74r2V7hi4bJm764KHOiDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtFtycgseYDZtaGFkkzlb0ASvHE9l9o2b/SlFw8qKqQ=;
 b=P/J844Vceq2EQPX6VcbNkZtNTHjBFWF2HgGCw2nFjvKHNjqojl2tfbCHRmsvGAMUbUMopw3RrNxM3SOQpOEtrx327+vW9rppEKdeECr8+0LJ217xEAx6KyD3Qa3LYlgYv10Sx11i/oisvYYnf2s++Caq2+fbcB+DgzvEcpvt+cQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7836.eurprd04.prod.outlook.com (2603:10a6:10:1f3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Mon, 27 May
 2024 07:54:51 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:54:51 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 6/6] test-bap: Add Broadcast Source Release test
Date: Mon, 27 May 2024 10:54:22 +0300
Message-Id: <20240527075422.18953-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
References: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0028.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c10ad66-0d0e-4db3-2cf6-08dc7e2249f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rqf7PdcHHCksiVX3imePr1qeiHq43zMxEdjSn6FHGdKtTFWX6mWwtTmblieY?=
 =?us-ascii?Q?RuXFrNTN9+QNlarSa2UlKQkSjgqP1yS8SLdGY5WcRHQybcpIIKD32DdAcewm?=
 =?us-ascii?Q?VEZtH3UvHquNtc/AuijQ1qT6qD93UGj0hGQdF17HVIQuW2/ZEdOpXk3EXX+Y?=
 =?us-ascii?Q?RiUkP97FBJZsLpADH3U2j+wrTY+4acokPu3nah/yQUwc3TA3UyxIkROhdaZT?=
 =?us-ascii?Q?8eZZ2Oape25tJZX/NHpv32GtNpaszZnYe2TsryhrYRS1AkZG5YGQPbZ6oIcv?=
 =?us-ascii?Q?o7e3jFuWplR8WVbbJ6vR3uJKH+58ZBUs0dgglocTmAiZI1M6mW9lW2vM4rpB?=
 =?us-ascii?Q?m+MAdr3CGrHzYRZ8XrCgYw8AWLUQUcMk9mu/vbKPT/H3sF+IGT/3bEeA/HEV?=
 =?us-ascii?Q?XlCKn1XfvFxWkcbeEfNQNZBJhIf2SUNnImaVPI2Bmd92upIBuwmeyqA1JCal?=
 =?us-ascii?Q?feQVSLi6P9WO5fOki9l+GuM6pKpCqAyruktyih0yPF1W/aUa3nDXG+H3Iqex?=
 =?us-ascii?Q?r2V+6Pdn45MI8KZDwnvs1Q7cJOnlok6Y6F+/+zfkF7sG1+IqWajSpUec1xM4?=
 =?us-ascii?Q?yp8gIlmC9uauB+O+hfzDKtJE4jurgPUPOQstGt1G+eK+5611Ej02fzo8c1x2?=
 =?us-ascii?Q?dIT8RascggQqqPIWJy8pLsd7ogbKxEwxSglyGXae57bY4YOb1BQ3xEIxmXMx?=
 =?us-ascii?Q?SiGUtUrwfhSHsMaiKscazp1Vs2CbvZ1YUv+ORRizdQKeIxElHK3ZfAA7b/IO?=
 =?us-ascii?Q?7hzphBDgIzCYlYIqDvq0UAbyFnPlrNBn+b1ttGbYDJ9m2BoPYahuGcKVH3RV?=
 =?us-ascii?Q?jKajUJ/G0Fn4hVwnHjqL7CTRa1XIO/c2MCklqrXgJwF8XVD+fDiD/BZONAuZ?=
 =?us-ascii?Q?oYw8oABArE1ioKal+nEawjgA1YOzUxPoKCSYl99g2H1ZQt/eudx++rEkhlFm?=
 =?us-ascii?Q?33bdeTLofBWD9UTPr39raxCCaXk0fmowoHsSQSa4fKFGUrEOhCn8UQSDgYEM?=
 =?us-ascii?Q?cnOecqAEnrY3rG5cAeekv9M+hhZlPCfw18QM4/wjGfDJRj66VEpkmOr5sLOX?=
 =?us-ascii?Q?jF7/dPBzxQEJUmIQSZ3J+W3EnzAgT19ktmTCve/lOLa2JEsaQlrNy6IjKlaW?=
 =?us-ascii?Q?34grs2XZ+TOaIKEm41bDSBZAiEMO00ALsdfs0vHyR5EYj19pRMxYQ5P1C9y8?=
 =?us-ascii?Q?41KMiLvk9cKvb1KRBRj+V/YSyHY4Odnqfb0j+nwPABv3mFYAWhoJMK7wt+85?=
 =?us-ascii?Q?q/D7wWt6264+Vtf/nayI0GYeqH4YPMoGkyYJBbdh9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JI64FgS/uyJpemh3qYQCJBp84sqEv7G6Vs5XndmDFhLTAwFTgn/9YYuxJnpk?=
 =?us-ascii?Q?ZwNSMr047KCANmz4x7FjGrXFWvvAeEOoeYr3dqoyheyBng+NMTys64kCAGAp?=
 =?us-ascii?Q?riYsfi86sSnIjvo9P+tC7+eU/GnQvyrP8WUv7jcEgzOa0QABNf9R9xMd0w1U?=
 =?us-ascii?Q?94h3oWA+ksBBch48ilV14Kds14xmSSumYqx69zONvd0X3u1vFXK+ljspV1KH?=
 =?us-ascii?Q?S/wWEAHqOFZyAWD+cnAcECCWS8fuCQQgIKJB3hygS/9OvB23UP83PUWh689s?=
 =?us-ascii?Q?HEjQGB3GsDeQVyfSnTMZQEvm1lAZ9E2T64bvjNOuoYdHHyc7T3bSqugaU1ad?=
 =?us-ascii?Q?G1alv7C+u8qdCKpNRYm8cqoq+9AfnNJqB2xS1SyFeR1kq0U22TIsbPEUuo4E?=
 =?us-ascii?Q?UitKUK+HQCXFtZ0HVXCTaX4W2WT9O23iksHP7zcSQD/SJdjNjj8vnyAx5jYo?=
 =?us-ascii?Q?fxkdBah6/1727pdFYUIL9rFwzthfj6Smn6ypgh/09hiPWXMV1er5ObktrStJ?=
 =?us-ascii?Q?+mBDqTbDnlyHDVkluPOqK9Wz4zBWN6E4V9Ey/dDybR6pb4Y3D39XRB8eUhh4?=
 =?us-ascii?Q?HIbX537wCEX0agRgkay5ZUMnuO/Pq3emd17U29FDWmPh6jpt5dNcd4JR7cPD?=
 =?us-ascii?Q?KFH6DyRehclTxziF5vUnFT/NuM1Q3MSwbnvwX8sq1hwNseyTqTOXRNOIwbkY?=
 =?us-ascii?Q?3SN6eD60Q/Fb41QlCES5LZTtZfR9lYevc729SeREfSz7WGzxsilhCGkFkklZ?=
 =?us-ascii?Q?uiiDYaLrbKei1pYtD2OLO75XWIgDXOUEZ4+iZRubQ6yJaQdWjQGsBSYpCoL4?=
 =?us-ascii?Q?Hp/YDzrhp3CHGOwtvCGyu06ThgNM52iXC4fMbRRQRgBvFk1AwUwLFRTA4yfi?=
 =?us-ascii?Q?UZ/IWliTeM9OtNJAw1GLTMS8nIMLRqf54YNtaRJ/isuKh+kS2ZZ6SVh98K+O?=
 =?us-ascii?Q?TVq7cK0IyEKBgbHG1IlcH2TR4uVG3tQ4pirLxZfk0y98eAMJC3f8gWf4o1ki?=
 =?us-ascii?Q?RxUOPuSHJMUJfH3x2pUNIlKTl0et6DNJJuzd5nE9NuTyQBxjGMD2tHYx434I?=
 =?us-ascii?Q?IFgllpZSeSlTAuveE+x9JRwVD75rUTIF3kbyGIRm0ka+FxBthEJS6EVLlL2p?=
 =?us-ascii?Q?gOOBUwvwY56h9ebHbfTqgmLGl8I+X3aX9Ie7vK0dhQ0SME1mBulBe53R+j5a?=
 =?us-ascii?Q?aiwJH2+sGdrcgjSQJpz+IOZdhPkeoZqC6DeAY+SwcSavUKEz+uktDjPZ3HhY?=
 =?us-ascii?Q?W9s7kimSmHLDpmdMdi4IYN972gDkvRKP3DcaVXEceiaaivUSktoRiKKbZ1t+?=
 =?us-ascii?Q?yfJoQcvJVOvb/Is33h2ItVHrhWw3chYz2pY5vES3TPMw7NpOpWJW7zjDQmHL?=
 =?us-ascii?Q?uqq4s6ySxb+yJ34AcYMzfy/zd3uGvfabZdzfO/WgRMr3CyLogX+iNJpKtJIQ?=
 =?us-ascii?Q?HPu4tpNoPBWQbbAyRKjwh2mbFIdV+kKJwfCT2iPNwLtSUWqfE0q3x7FvBnX4?=
 =?us-ascii?Q?nth0awjH4l/hwVgsPRWMmiytYriKPBE6GOyWgh7bpcJM8ysQTXHpyI6joi/a?=
 =?us-ascii?Q?Kr0WeJ9U8g2wGsSfYsCoKXG4gOcBasR6AnADXywkSvj5lkJS4ieMU8ZAcWsH?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c10ad66-0d0e-4db3-2cf6-08dc7e2249f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:54:51.6052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slzUbHCqPorOuqwwPGA6m65nJF1+PZgcVvcNPFPTThaF4ZlJmLNcdc3xEX3Q3M2pzVoamYByD6VH4E+twzb0gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7836

BAP/BSRC/SCC/BV-37-C [Releases Broadcast] (page 176):

    Test Purpose:
    Verify that a Broadcast Source IUT can release a broadcast
    Audio Stream and transition from Configured state to Idle
    state.

    Pass verdict:
    The IUT stops transmitting periodic advertising.

Test Summary
------------
BAP/BSRC/SCC/BV-37-C [Releases Broadcast]            Passed
---
 unit/test-bap.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 3fc3b5f02..47a19b8c3 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6211,11 +6211,58 @@ static void test_bsrc_scc_disable(void)
 		NULL, test_bcast, &cfg_bsrc_8_1_1_disable, IOV_NULL);
 }
 
+static void bsrc_state_release(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (old_state == BT_BAP_STREAM_STATE_IDLE)
+			bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+		else if (old_state == BT_BAP_STREAM_STATE_STREAMING)
+			bt_bap_stream_release(stream, NULL, NULL);
+		else
+			/* Other transitions to CONFIG state are invalid. */
+			tester_test_failed();
+		break;
+	case BT_BAP_STREAM_STATE_ENABLING:
+		bt_bap_stream_start(stream, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_STREAMING:
+		bt_bap_stream_disable(stream, true, NULL, NULL);
+		break;
+	case BT_BAP_STREAM_STATE_IDLE:
+		tester_test_passed();
+		break;
+	}
+}
+
+static struct test_config cfg_bsrc_8_1_1_release = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = LC3_QOS_8_1_1_B,
+	.src = true,
+	.state_func = bsrc_state_release,
+};
+
+/* Test Purpose:
+ * Verify that a Broadcast Source IUT can release a broadcast
+ * Audio Stream and transition from Configured state to Idle
+ * state.
+ *
+ * Pass verdict:
+ * The IUT stops transmitting periodic advertising.
+ */
+static void test_bsrc_scc_release(void)
+{
+	define_test("BAP/BSRC/SCC/BV-37-C [Releases Broadcast]",
+		NULL, test_bcast, &cfg_bsrc_8_1_1_release, IOV_NULL);
+}
+
 static void test_bsrc_scc(void)
 {
 	test_bsrc_scc_config();
 	test_bsrc_scc_estab();
 	test_bsrc_scc_disable();
+	test_bsrc_scc_release();
 }
 
 static struct test_config cfg_bsnk_8_1 = {
-- 
2.39.2

