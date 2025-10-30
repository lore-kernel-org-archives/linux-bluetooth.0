Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF64218AAF
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832046; cv=fail; b=uq64c1Rds2sU2tsQxF3Sk7ReFS0p1idLH4OwGJm7NB3QysLryRA7RY7DZrlHRQ1+FTEPYBRCmQyr4KWunfpiNnS98w23jNmr+Ygr9vDBROsxfVl/goRIhN8vuy4ku1n8P61aJv1+CQIELTOSe4axwDZl+shOEXrwRfwvy+tDQWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832046; c=relaxed/simple;
	bh=jiGg/Bv1ai4Eh+tn2A8JDKe3Wpf4kmhLk6wo8FXVAKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pA5jtEfx52lMVVsXlwxZcVJuA5MPmXwLfSjIKmEKXYLyj7TZBl4vbclFZqADG5YNN9NZU2m46z4jrCHfPWGHRuJ4G59RtvoJ/eYi8LHQYclAM1NeBh2BSXspCiNggKKKnmXfDzqRjjsFAhMtkYKxdSpxtrcqdWJL++nMf+mNnnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jx5OZXAN; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jx5OZXAN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0++b/FNxBHjWOy8xkXnb6yEfkYviLmaUfcsiLMbuvFLpT4KBdFXnjMsWR0XZdExRGo7fBFNHch31sh8JUzT3xo2gTsHDrgnt/9hlO9c/xWndLYKc9YlrwRozRZzYupfOh4IbIDyXu3XvXZDt3Zy/1vE0Ez7omb+8BkCIPlUutddhLpbt6EeX37rC9SLpJK+xqI6phnyTTOL2E/7guBOvytdw/JwKE+KqGhOPQ4I5SwFQIN35UL1Usy/khbBoOSV0SgMZ3yfIfhAZw8vp+guH4mqcivcMtUh33L8omoMjvra6k6R3dX8VIoKA8/gOoJDvR9ma2x3dIlKlHFKuzB+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQy7HPDGLWw0LnY549JAR/VYgSfQ9K7E0SvI/uz70yk=;
 b=UT5Bh2Eety5S6eNJ4BJUgZSoW2TOrOOHtKRbbD+Pp2JmYJRrNyRwGOuNTyw9O/bEXM9V0sZ6eQdPNGBxjFCwptmDeCzTtUpw8AhOg2fmuHglVZ9uFVvdOaC9P72UwMs6FeEnnmYO2CZgqXRcH6D3bmNylrNCD24XACeQC1gSTFN83to5OlqVRiPNRw0MIrFW7eV4318rx0btYZ+4sufmTSQtdW/8in+EIfJCiceWPqfA6t8w+vgxbXSijf8HEYgHj90cD+Hohd2e8k5ysyAI8gxN1JE1ZtEYCxmvbRKZiKPyPvoVJ0uLOpyWtxnemc1jATrbD2pUrMbUlowVKfi9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQy7HPDGLWw0LnY549JAR/VYgSfQ9K7E0SvI/uz70yk=;
 b=Jx5OZXANxZ+W12T5cIZKif/Yfdy99kPTffwdax+lvC8+BceEIPsm+WgZK73e2e7/v3l5IHXv6BEWDOnqtMDq1hyZqAlTZYrgBCEgQoed4KnvFv8vPi1zcGIW2cYeldWtkzB/QcmG+fZCBEvaPLm+F4ADprpsl43fbYCFKXPa05G3hMnOAA4wIKQaMdVaBrKR104OG6YmA2IZLhS/4JFclgDuWKqWrwcVN3RFo1PN/06VPI4vFTXKfBl1kmOhlBNKvZb0bqSXhUauy//4GqfBNwJX6AYPbKJLB86GfeIKq/TTlSPaI0mik9k2BfcBwKQPKljQCSnB/M5GCpNDX9nvPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by VI0PR04MB11866.eurprd04.prod.outlook.com (2603:10a6:800:2f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 13:47:21 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2%7]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 13:47:21 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 1/1]     When Connect request for eSco is received, if enhanced synchronous connection command is supported it will go for     'Enhanced Accept Synchronous Connection Request command' else it will go for  legacy command['Accept Synchronous Connection Request comand']
Date: Thu, 30 Oct 2025 19:18:56 +0530
Message-Id: <20251030134856.2726882-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030134856.2726882-1-mahesh.talewad@nxp.com>
References: <20251030134856.2726882-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|VI0PR04MB11866:EE_
X-MS-Office365-Filtering-Correlation-Id: 464e0c33-71c4-4bf7-fff6-08de17bad961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXBmwuhj+015nn3C2ZPVwYdRKF8AHuT+O9Qv7zJpGsCIPbzTR3X6wu6U5FAK?=
 =?us-ascii?Q?BhpALcaL/AftAdDv/5J393RRM92gwMIuxc2cqtGPOZ44L8ctBaClVvnvzikw?=
 =?us-ascii?Q?UnD6b0y7nJzWaf++6ECttlB+4pOhbnayOmmmrmBVDqGcD2Llg5vtXhiDaf6U?=
 =?us-ascii?Q?xtZnZnQltoLTspFSEhRYPK2ZlviiUTAUTehsgmLBa34Mai731d6iuSmbmE2p?=
 =?us-ascii?Q?WfC6dnL1Rc/akkLAqZMsGcERqP/E8eTcU0uCoBMcpxW9Z/4ZHZXnWPGfFn5f?=
 =?us-ascii?Q?aBadibvVDh0GdSbaQRAJnsmRHUMfm8PTomrYKCZDfQwQ1MbEd7e3Hh6sfutF?=
 =?us-ascii?Q?O/ZPuqo/ABFZsHXZDS1fpesGVWY17CYwqdyI88n63hSzELYPCqvszNZrnbHd?=
 =?us-ascii?Q?I7VkikFT0h/1rlbIVcauV2r70t9qsrf7/xAvKJli6ohHnLI5pHwhWcV+ujXj?=
 =?us-ascii?Q?NxYetQU+GtKcY6hi7UaR0oRBTYrUXaNPOqwXbu0wjWP9NmmO6qJnRiSxE64j?=
 =?us-ascii?Q?slkU/13m0ycjRY0FJgwhwu6u3D+p0lo+5g9YQqdJC/JqnWv0unYnFsgBw4oy?=
 =?us-ascii?Q?maeYxu/dXoRVNl3u474IjrVIV0Cai9V3eMOPVozoOXUqDhDAsEz4BlgbYwg4?=
 =?us-ascii?Q?kPa6gqGJcvqG+f/usp0NQCuO+hA/AOWp+/oAtNqSK99PALSCNQwVRpRn7rnm?=
 =?us-ascii?Q?BWjfU8HhC9M5u/Sy6QMqy/+EbxhMLxEdNLynpNgHICmCiJzc8ZbnBnpTHsjx?=
 =?us-ascii?Q?X/yJUMfouCUR5KkRp4G/f8Dxs0MxgK9yyLwVz4TNIAUJwWWIZKijCJtWxkDB?=
 =?us-ascii?Q?3hAHPxjzmsmWxOJpyKvHGH1kfnasg/CAj7zvFXY2h0f2bA9EwOR/D7hFs85z?=
 =?us-ascii?Q?eVkjYJ22H4q+0XsXY8VQBMPLokjFaKzhLNMoze+MpcbsfXzOgj5gZbKvGQWW?=
 =?us-ascii?Q?dch5us4Z9EPzvPw/2MmSu1zHCpHoT6r4BOTijpAoI7sAjuW3QVuc7PpNUGte?=
 =?us-ascii?Q?/Oqx49istlTzBEAG5W4ZlFOo/9GfkyIK11EhIX+gnytmrhsCNTxLCYfXCHHJ?=
 =?us-ascii?Q?ZxsaV0KLQSx4uhBpgU2nOBjZHVumx9a0i1U/NvcO1Q5ktZuaB5XzTnzvbhAB?=
 =?us-ascii?Q?N+je+8jF2xHZ5X9DTE80iEpSTCLMRJxBotgMlmI77PUhIpu5tOYyS2QmctJA?=
 =?us-ascii?Q?mDa3aVEgfCFB++oNGhxG0j0DzVFO0DLKq6RrYycmrfro6cJjXA7N2pVHb1um?=
 =?us-ascii?Q?ie/lyMTMicBsztPUwkF+aKQk8qDJdwZo8d1JMOCnYXDCJezf1AuCymYdzeLg?=
 =?us-ascii?Q?QtRzq19oVvbtK/SJsKSE9ti+Wslh5SXeIS6OXTDIbW4mnkFZQOdZFt3maFMA?=
 =?us-ascii?Q?uKAFO66xqDikCUb88YF0vDrjgqkXkxdVVK/YOog/hzaYoFUV7EIEOWyjmbk4?=
 =?us-ascii?Q?Jvc8KtEM+e5fFmV51xNFpkuRvXY+WAHg7cWgak0TBbYWKoAg3wCH+hVjfuc7?=
 =?us-ascii?Q?ojpkA5LcsoIKbtgXaIyvoh0Vr+zm6+wuzg1Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l9TOaWjtttyGJuHW/TK3lKl92JOvstozqjSJOdNZ4lqp+d97NMbSTNtwzikt?=
 =?us-ascii?Q?sn7fzakHgnBPABrRVb5HLv3B5TA+PvSu0dT0s5uBUgcxxRvAT/OERhOALg+4?=
 =?us-ascii?Q?Zneg42NBsm1suYicqZwHIme15dTqA/ddoUkx9IldXAHzPKijUJQSARvrf2u2?=
 =?us-ascii?Q?McWhWKQ7Vus1EJhH3WpL0uzQDZzkfyfBKyZdxZEl/nc76C/OefdDR4OfTehH?=
 =?us-ascii?Q?0xoElvDppyoNTML7YB0JfPgXg9PTAB2KGsOC1WDPbaWaJousTKkxv7n62fQj?=
 =?us-ascii?Q?VflVWrEw2Z8qU2QXLd5oo03E0chK7JP7nX7yDrMPrku7pKhiKSRhNk5WqeSs?=
 =?us-ascii?Q?lCBXqzcOVdj+P5NSjjQCQpIb+laT+T9PFeoQPUuH3VQpZZkDzkarE4QYe6A+?=
 =?us-ascii?Q?wgiWZT3KTfoWsar949uj/9LAg4OkUViDJpZgay2Rm6dcanGgYWjEpiLF9z+O?=
 =?us-ascii?Q?cq+sT2iSiQ63y+DLOX0MLR8G/r95+cKp5o2Y/vsB7kWQ+iDmtuVP1HS62hCK?=
 =?us-ascii?Q?dPABqopndrUHPpPPlGKY+h3h2UKX9509dOFAbnfKqa/qKKHC55015mrGKXrD?=
 =?us-ascii?Q?tYx3QAJVZF0iMLa/9Se7/HT3JG6SES/pf3Wcj0NHqRdxh/YIrfHMUqSb2hP4?=
 =?us-ascii?Q?uIyfBJpv9dQ9m+wb6xHYZ5pFEM15oznyOWLQJvIoEAdBxEnAEBJYKGdKHS8p?=
 =?us-ascii?Q?0BBKhvysSOzC1ledVC1F0pRG1Da4ZJ4f/zGUa4xSDO234RAsUiEtV48nHMrR?=
 =?us-ascii?Q?gyNnDlo/2Hck4+xKi95ctPyQkL6rMd5Z+bc3oI09BheeYp/0w866jkNDNgnf?=
 =?us-ascii?Q?uR8mVxzqSbdzbvY1UToqPT/3lzttdH1f71EURrs8mFfkGn5KQq3VIjj4ZghQ?=
 =?us-ascii?Q?qxu92YjCigaYQgOhWmu7BT7HFz3Otd9njmLufwIH21UiFfcAma7dyBtyku4x?=
 =?us-ascii?Q?i3iOlkZwcwbsFVBNqZUufIfuXZ0khmmsGHQESSxfk4L3+qnRlxK8QI+uSbPR?=
 =?us-ascii?Q?PxINbARIBq0eAOC1NShUOv28qNjgoZsQfj5UPMTuF9tnuie0rcLbyBum32ck?=
 =?us-ascii?Q?xOqpn2CsPCCQTlGfs7tEnFkkPS2hCI6HXemZTNlY4JrClf3cD+r/g0XFdNWy?=
 =?us-ascii?Q?kpuPF7+uE9xndzNHdxKnJqstNPjLvmE5+aQm8lbuD7oEua4+cFhMUC+xZ0Wx?=
 =?us-ascii?Q?Aw1DvH7XVudUF6L1oRS4FU3AkSiCvUc5FoOCdiJR7X7aztzHkwZ0/umnkTLW?=
 =?us-ascii?Q?wAlytfoDkc/fqmj81qUNB1snWqvzNJYnaTqo2DQQ/y8LeuKBOHtQNnswkDq8?=
 =?us-ascii?Q?qSec8efzUS+/F3dLIJF1+WrdfLpWVZuKexKGe5ngm8PG8LT/MxkdjMHfRWdu?=
 =?us-ascii?Q?I3BdHbYOtxqaldqtSzaqJWdCNilxNEDEHXxcS7RCVewsKAF0n70OftzX60vg?=
 =?us-ascii?Q?n2FdGy7cYCUIej2zNVC88QA5AfupQm07f2aOU561kH8DjPxLkJpm6cghkDzi?=
 =?us-ascii?Q?b5h/pzTPBu4UHxlNEUxQnsmelVR4uBZO6jJjKvCrSQsxtLZMZyASXlhVKLEw?=
 =?us-ascii?Q?P814jKLXwqAI4lVznhw+FWEtKcBdamu24HuAbMN7YuwNOllyS67OU+KjrDIE?=
 =?us-ascii?Q?tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464e0c33-71c4-4bf7-fff6-08de17bad961
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:47:21.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XfNzR0QM9TUQuglIuiJo+Uizi2rJuGpCB/DRUSiVGqIux2teDw9u6E4+RRYNNyq6C8dMwoQ+Ekt8gwmC/Hv6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11866

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 include/net/bluetooth/hci.h |  34 ++++++++++++
 net/bluetooth/sco.c         | 103 ++++++++++++++++++++++++++----------
 2 files changed, 109 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 40fce4193cc1..4f1a38e8f276 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -914,6 +914,40 @@ struct hci_cp_accept_sync_conn_req {
 	__le16   pkt_type;
 } __packed;
 
+#define	HCI_OP_ENHANCED_ACCEPT_SYNC_CONN_REQ	0x043E
+struct hci_coding_format_en_accpt_sync {
+	__u8    id;
+	__le16  cid;
+	__le16  vid;
+} __packed;
+
+struct hci_cp_enhanced_accept_sync_conn_req {
+	bdaddr_t bdaddr;
+	__le32	tx_bandwidth;
+	__le32	rx_bandwidth;
+	struct	hci_coding_format_en_accpt_sync tx_coding_format;
+	struct	hci_coding_format_en_accpt_sync rx_coding_format;
+	__le16	tx_codec_frame_size;
+	__le16	rx_codec_frame_size;
+	__le32	in_bandwidth;
+	__le32	out_bandwidth;
+	struct	hci_coding_format_en_accpt_sync in_coding_format;
+	struct	hci_coding_format_en_accpt_sync out_coding_format;
+	__le16	in_coded_data_size;
+	__le16	out_coded_data_size;
+	__u8	in_pcm_data_format;
+	__u8	out_pcm_data_format;
+	__u8	in_pcm_sample_payload_msb_pos;
+	__u8	out_pcm_sample_payload_msb_pos;
+	__u8	in_data_path;
+	__u8	out_data_path;
+	__u8	in_transport_unit_size;
+	__u8	out_transport_unit_size;
+	__le16	max_latency;
+	__le16	pkt_type;
+	__u8	retrans_effort;
+} __packed;
+
 #define HCI_OP_REJECT_SYNC_CONN_REQ	0x042a
 struct hci_cp_reject_sync_conn_req {
 	bdaddr_t bdaddr;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index b872a2ca3ff3..42ffb31839f2 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -762,6 +762,17 @@ static int sco_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+struct esco_param {
+	u16 pkt_type;
+	u16 max_latency;
+	u8  retrans_effort;
+};
+
+static const struct esco_param esco_param_msbc[] = {
+	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000d,	0x02 }, /* T2 */
+	{ EDR_ESCO_MASK | ESCO_EV3,   0x0008,	0x02 }, /* T1 */
+};
+
 static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -778,36 +789,72 @@ static void sco_conn_defer_accept(struct hci_conn *conn, u16 setting)
 
 		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
 	} else {
-		struct hci_cp_accept_sync_conn_req cp;
-
-		bacpy(&cp.bdaddr, &conn->dst);
-		cp.pkt_type = cpu_to_le16(conn->pkt_type);
-
-		cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
-		cp.content_format = cpu_to_le16(setting);
+		if (!enhanced_sync_conn_capable(hdev)) {
+			struct hci_cp_accept_sync_conn_req cp;
+
+			bacpy(&cp.bdaddr, &conn->dst);
+			cp.pkt_type = cpu_to_le16(conn->pkt_type);
+
+			cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+			cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+			cp.content_format = cpu_to_le16(setting);
+
+			switch (setting & SCO_AIRMODE_MASK) {
+			case SCO_AIRMODE_TRANSP:
+				if (conn->pkt_type & ESCO_2EV3)
+					cp.max_latency = cpu_to_le16(0x0008);
+				else
+					cp.max_latency = cpu_to_le16(0x000D);
+				cp.retrans_effort = 0x02;
+				break;
+			case SCO_AIRMODE_CVSD:
+				cp.max_latency = cpu_to_le16(0xffff);
+				cp.retrans_effort = 0xff;
+				break;
+			default:
+				/* use CVSD settings as fallback */
+				cp.max_latency = cpu_to_le16(0xffff);
+				cp.retrans_effort = 0xff;
+				break;
+			}
 
-		switch (setting & SCO_AIRMODE_MASK) {
-		case SCO_AIRMODE_TRANSP:
-			if (conn->pkt_type & ESCO_2EV3)
-				cp.max_latency = cpu_to_le16(0x0008);
-			else
-				cp.max_latency = cpu_to_le16(0x000D);
-			cp.retrans_effort = 0x02;
-			break;
-		case SCO_AIRMODE_CVSD:
-			cp.max_latency = cpu_to_le16(0xffff);
-			cp.retrans_effort = 0xff;
-			break;
-		default:
-			/* use CVSD settings as fallback */
-			cp.max_latency = cpu_to_le16(0xffff);
-			cp.retrans_effort = 0xff;
-			break;
+			hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
+		} else {
+			struct hci_cp_enhanced_accept_sync_conn_req cp;
+			const struct esco_param *param;
+
+			memset(&cp, 0x00, sizeof(cp));
+
+			bacpy(&cp.bdaddr, &conn->dst);
+			cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+			cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+			cp.tx_coding_format.id = 0x05;
+			cp.rx_coding_format.id = 0x05;
+			cp.tx_codec_frame_size = __cpu_to_le16(60);
+			cp.rx_codec_frame_size = __cpu_to_le16(60);
+			cp.in_bandwidth = __cpu_to_le32(32000);
+			cp.out_bandwidth = __cpu_to_le32(32000);
+			cp.in_coding_format.id = 0x04;
+			cp.out_coding_format.id = 0x04;
+			cp.in_coded_data_size = __cpu_to_le16(16);
+			cp.out_coded_data_size = __cpu_to_le16(16);
+			cp.in_pcm_data_format = 2;
+			cp.out_pcm_data_format = 2;
+			cp.in_pcm_sample_payload_msb_pos = 0;
+			cp.out_pcm_sample_payload_msb_pos = 0;
+			cp.in_data_path = conn->codec.data_path;
+			cp.out_data_path = conn->codec.data_path;
+			cp.in_transport_unit_size = 1;
+			cp.out_transport_unit_size = 1;
+
+			param = &esco_param_msbc[conn->attempt];
+
+			cp.max_latency = __cpu_to_le16(param->max_latency);
+			cp.pkt_type = __cpu_to_le16(param->pkt_type);
+			cp.retrans_effort = param->retrans_effort;
+
+			hci_send_cmd(hdev, HCI_OP_ENHANCED_ACCEPT_SYNC_CONN_REQ, sizeof(cp), &cp);
 		}
-
-		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
-			     sizeof(cp), &cp);
 	}
 }
 
-- 
2.34.1

