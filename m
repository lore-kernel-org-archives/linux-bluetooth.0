Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EFAC6FD18
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Apr 2023 13:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjDSNog (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Apr 2023 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjDSNof (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Apr 2023 09:44:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321EA146EA
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Apr 2023 06:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daRRAaV6Xse/7his3Ql1l38jZsXAtXyvct5DyT5f/RcV8pQLqKeA2wzHVI3qZwqsEytHCFRZk9JxfLTW4/XuaSiLw8o88BIoLkZm0LcICkZUnPCFgbb5ZoxMoQX5lkEgJi1KL8ahalFRHU15fqO36KaDslKLz3PPP1QWrXZG5pilBnpEVbkX58XvOGKqOLZZ8kCGQV38G8UpKOd2OzCcKVG86j1wr/quyNEtAenRzoHdctRshMZtKeUF/zrEEBEGbddKA6e/P18+vzZ95M0SMqtWtaZ1sHLpL+xYZpzvBTK7p5hNp0WT3i0MYFHjTXpGJCpZXWFSkOPdEktKZA8HXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGfSR+5aleoX+xmO+9gLqypfaJI04DkWc1J3dWm226I=;
 b=J7cZQf3YhBl7mcitTG8OSEVaMj6H0GxHrDzLFOGkuBynnyYzEIk2gPGSz5PVA0SSx14sjzxoaKv1CyNYOvc5JBm6JKNtEtaB+MEFkBudIoiuQJmUyVBEqJUqJZz/Fwmpj66PA61GaZgNwkbOiBYfzo/aktCsudgW85cp4SYsIOCPF+gdQYd56ycNWVVX0dPWIhChk9In6YQ9QIJQmT2ybmbYwE8BSGQ66nyZtwOgcHRbOQTMo2T/JPV6/1DO7CvJEPA2iigWr34eGRT59PtvUYftcGj5/rhhO2qYBY9YsiT7w+dgXpsShMdE4GKH8kgv0bl98Dwr9ihTac+J06KLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGfSR+5aleoX+xmO+9gLqypfaJI04DkWc1J3dWm226I=;
 b=QA9qDDTFU0Dtykn9V3vWvAjzvJfg6vHvM0zoQljyvC/DI+a3USAhwHGfcPGyirhG4xfNlvLTNYs42lqZYHwPgfTBvpBoQqOATkPP76ZaZXR7xc6I7MVlA1bS18pFYofezA6TdMP3Qlu7IZRYWvyHGatUV6RPVrivlCjbTILFSGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB7004.eurprd04.prod.outlook.com (2603:10a6:10:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 13:44:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6319.021; Wed, 19 Apr 2023
 13:44:29 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] tools/isotest: Add BIG encryption options
Date:   Wed, 19 Apr 2023 16:43:53 +0300
Message-Id: <20230419134354.61950-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
References: <20230419134354.61950-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0119.eurprd05.prod.outlook.com
 (2603:10a6:207:2::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: d64a05cf-f897-40b2-65f7-08db40dc3320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IFRBsOFKYb37tQ2s/rDVLhXHKM+zATIo/iXPGvwtBOGFRnYnujkjXt/hnajY6Tpzq6dzhDUOdBA1eKF0TdVU18/Iln2puJFVI90hPmj9YjUbEB7kmIkN59SS11Q8mp3uREYC18g8MgvrMpNQ5w0YkWs+5kStUX0LIX9LDrBOBvzalWcdGjov/F17DRdOWhkqkpIbjProKLugvpNMwwxR1SeELoZJl6Sbgx2qfgLw27udA40yAq7kYg8UvpVaTMwCjQNLP3oW8uIhl1PIG3Qzh5URAVx+wbHG2v83e6zsjMwwDJTaAkm2TNkk4Y1BGZYSfJn0tJz+al9xr7gdWspoVsMNg89+stlZSQ1dSz3nvtPwscPtkV3RFR8Emq/6q6Y4rVSdZsBUsLRzai1mS+lhXnnuohBmyTuh673jd3/P40Kw7tYEgtWj0E/FkEw8ZdoRXeJiyFbi8hhvDVpQ2tWWTJhCFnF8KPPmg4FnFl9wKy+D8lRkEIEB7Fgb0StHZtNzmjTLr5fzp0EJpVAWqzLHXYQ+at9+oK4yyLy+l/tusDZULaPdpFxUwtt478eWm7u8hJ2O9USAHrdbJorwB2Qk2mVOy6dU2iJ56xFsUKUaFlHf6Vhjo1vJCs8PYhDyrqGO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(36756003)(4326008)(316002)(6916009)(66946007)(66556008)(66476007)(52116002)(6486002)(41300700001)(478600001)(6666004)(5660300002)(8936002)(8676002)(2906002)(44832011)(86362001)(38100700002)(2616005)(38350700002)(6506007)(1076003)(55236004)(26005)(83380400001)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OFbGJfpwlY6lpmJNniAwCCPE5rULfNs/tRjqH54Jz1F6E7QQYPTWn+Vh8LhN?=
 =?us-ascii?Q?JkIcFzrvwvE27C+qEp9Q5QB4ey5yNn5vwJxQz+RqPTu21fwtpBUUe2MQs6tz?=
 =?us-ascii?Q?BFT2iOcUAGRoQ++gNdhXzhvaXtjebZ1wRrkNKIG0YD5/WVm9Ucq6N9LsyaOD?=
 =?us-ascii?Q?TIJZAQZfzQ4R+7vIDCPT2IzipvANddd+vntc5F1zYo3HaduhwdqEe7WsuhXs?=
 =?us-ascii?Q?n8iHIHvrsXqbWCd2GVqY5138M+TQ5iec+xUthlG6ciIH1Lt5Lk0nJ8239H48?=
 =?us-ascii?Q?LnAYRXpPQvji+04gV6b/vxR5a+EPEEPgBsue6OUIhMCwHxpext0fqQLrSIvq?=
 =?us-ascii?Q?jfqkaWI00Q/9zYtvvX5JqoCYLZIUdchHBVllmsLI17WIyVf0HJOzi3nLeFuS?=
 =?us-ascii?Q?lYWIqu49l2ZYvPbfJO+NXR4hReXVNTo/0xGOkIhirZZmOUFCbn7Q64Xej7G3?=
 =?us-ascii?Q?nNM1Uztu5SqCqkTx9IbzK9s2mv6VT7TJK32BYEs3S2OHh0LgkUshWu1XqhdB?=
 =?us-ascii?Q?AAJdOVSmgNWDqz/k3DYHiUkclsBzgdi8GMiqaIOKgf6f6MVMitnIuuEajvuD?=
 =?us-ascii?Q?5rfJG3LaHDpjaLGwww+bO1mfuj/jEZdGRDEQtOnsM1ou0VnNLAISL1EevStC?=
 =?us-ascii?Q?EhVlSScp3ucfKUwGuhHlB3m57M29Jl5BmhU4jFwE5brRtz559l4yeVBaSqC/?=
 =?us-ascii?Q?/85zlD491OTklvhwe4RXyn+qvkv6569EVemf/OxKSfLis/4K7gGc5cOMQI/d?=
 =?us-ascii?Q?HbHlLYmro7tB8/NGAdRBmJByClPqz0lw6s71b2S6h7ht0BuLiEhO9wy2MyRF?=
 =?us-ascii?Q?5guXfwf2UdIw4lkXQUDPtDXOgQr4bzMmsn3EQUUH5m5ExSqjxhDHLdseShK4?=
 =?us-ascii?Q?bnpXXP4EiwRzctDDL8V/S1dHVoETJdDLMR0n+dNiyO7Bb+VUN/ucb+S8vz0U?=
 =?us-ascii?Q?CRIbSP8fd2hk5rMTVpk11wZt129dP+2X9nBrTkdn+jM2458BW7bR4yk01lLR?=
 =?us-ascii?Q?hDS++nlhZDpgakUmHzdE7bTMfp9mPS+rC9mqkkpk8G3bBvefdpX4owIXbC9j?=
 =?us-ascii?Q?L/Q0PKTvJGhNf0XXtqEahZjHEPu14FmouilClak8nfi3LOQSZML2ApwBSXUU?=
 =?us-ascii?Q?CY7kH2aIQRHe1c9VOkS0+Yc0Y/DXdwB4MuqpW/delUbx5xc4bQrCIXCEY0JE?=
 =?us-ascii?Q?JVGIe5Z4a5OXR48Kt9HR9EvBG4piIVb8UKxjkOqPqk3h2Drwgd0wA5nQ5iuW?=
 =?us-ascii?Q?KtlnRBLEDbIccaJrPCH+ytKk2ursBsljYbXTOKc6NKXJQQPnzngFpVnEyVQr?=
 =?us-ascii?Q?N3HL7JoiwxdjJE8akzzN43JeIPIr0/uW4sTy89cIEtNSj5NqPQDnsdidvvVC?=
 =?us-ascii?Q?yWucp75WKuwqhGLvwiZpoB2WchXNeBektekoPnKkeB5/wvx0w5qQNHriu5vs?=
 =?us-ascii?Q?EeXbGF/jnnSMNZcsTNWiyL/Hhbrlm5qVlQQ3OKN5tYdizc8aYowzk3G+/dBg?=
 =?us-ascii?Q?p1Pv1xmuvWqMhzy8mRS5/BEkyqEy+omTbNHPkdOrqVgZgoNjxyQferwgcW6g?=
 =?us-ascii?Q?cI7LsLJFyx2z/fGreY8PCV5ace4bEjOGZWXWalAkPMwjbwrYb/FS6icPIk1D?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a05cf-f897-40b2-65f7-08db40dc3320
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 13:44:29.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrCLdodALumzg9j4mMu1PrXhCWLASSAFh5H04Klrxph4v4yrlHt1aIjR+56c1SMeq4lwJZC8VBsHuB6RWdZR6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7004
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add command line options for BIG encryption and broadcast code.

---
 tools/isotest.c   | 101 +++++++++++++++++++++++++++++++++-------------
 tools/isotest.rst |  19 +++++++++
 2 files changed, 91 insertions(+), 29 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index cd7094b1c..caa711b2e 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -285,9 +285,20 @@ static void print_bcast_qos(int sk)
 		return;
 	}
 
-	syslog(LOG_INFO, "QoS BIG 0x%02x BIS 0x%02x Packing 0x%02x "
-		"Framing 0x%02x]", qos.bcast.big, qos.bcast.bis,
-		qos.bcast.packing, qos.bcast.framing);
+	syslog(LOG_INFO, "QoS [BIG 0x%02x BIS 0x%02x Packing 0x%02x "
+		"Framing 0x%02x Encryption 0x%02x]", qos.bcast.big,
+		qos.bcast.bis, qos.bcast.packing, qos.bcast.framing,
+		qos.bcast.encryption);
+
+	if (qos.bcast.encryption == 0x01)
+		syslog(LOG_INFO, "Broadcast Code 0x%02x 0x%02x 0x%02x 0x%02x "
+		"0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
+		"0x%02x 0x%02x 0x%02x 0x%02x", qos.bcast.bcode[0],
+		qos.bcast.bcode[1], qos.bcast.bcode[2], qos.bcast.bcode[3],
+		qos.bcast.bcode[4], qos.bcast.bcode[5], qos.bcast.bcode[6],
+		qos.bcast.bcode[7], qos.bcast.bcode[8], qos.bcast.bcode[9],
+		qos.bcast.bcode[10], qos.bcast.bcode[11], qos.bcast.bcode[12],
+		qos.bcast.bcode[13], qos.bcast.bcode[14], qos.bcast.bcode[15]);
 
 	syslog(LOG_INFO, "Input QoS [Interval %u us Latency %u "
 		"ms SDU %u PHY 0x%02x RTN %u]", qos.bcast.in.interval,
@@ -300,20 +311,6 @@ static void print_bcast_qos(int sk)
 		qos.bcast.out.phy, qos.bcast.out.rtn);
 }
 
-static void convert_ucast_qos_to_bcast(struct bt_iso_qos *qos)
-{
-	iso_qos->bcast.in.phy = 0x00;
-	iso_qos->bcast.in.sdu = 0;
-	qos->bcast.encryption = 0x00;
-	memset(qos->bcast.bcode, 0, sizeof(qos->bcast.bcode));
-	qos->bcast.options = 0x00;
-	qos->bcast.skip = 0x0000;
-	qos->bcast.sync_timeout = 0x4000;
-	qos->bcast.sync_cte_type = 0x00;
-	qos->bcast.mse = 0x00;
-	qos->bcast.timeout = 0x4000;
-}
-
 static int do_connect(char *peer)
 {
 	struct sockaddr_iso addr;
@@ -344,13 +341,9 @@ static int do_connect(char *peer)
 
 	/* Set QoS if available */
 	if (iso_qos) {
-		if (!strcmp(peer, "00:00:00:00:00:00")) {
-			convert_ucast_qos_to_bcast(iso_qos);
-		} else {
-			if (!inout) {
-				iso_qos->ucast.in.phy = 0x00;
-				iso_qos->ucast.in.sdu = 0;
-			}
+		if (!inout || !strcmp(peer, "00:00:00:00:00:00")) {
+			iso_qos->ucast.in.phy = 0x00;
+			iso_qos->ucast.in.sdu = 0;
 		}
 
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, iso_qos,
@@ -457,6 +450,16 @@ static void do_listen(char *filename, void (*handler)(int fd, int sk),
 		goto error;
 	}
 
+	/* Set QoS if available */
+	if (iso_qos) {
+		if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, iso_qos,
+					sizeof(*iso_qos)) < 0) {
+			syslog(LOG_ERR, "Can't set QoS socket option: "
+					"%s (%d)", strerror(errno), errno);
+			goto error;
+		}
+	}
+
 	/* Listen for connections */
 	if (listen(sk, 10)) {
 		syslog(LOG_ERR, "Can not listen on the socket: %s (%d)",
@@ -885,13 +888,21 @@ static void multy_connect_mode(char *peer)
 
 #define QOS(_interval, _latency, _sdu, _phy, _rtn) \
 { \
-	.ucast = { \
-		.cig = BT_ISO_QOS_CIG_UNSET, \
-		.cis = BT_ISO_QOS_CIS_UNSET, \
-		.sca = 0x07, \
+	.bcast = { \
+		.big = BT_ISO_QOS_BIG_UNSET, \
+		.bis = BT_ISO_QOS_BIS_UNSET, \
+		.sync_interval = 0x07, \
 		.packing = 0x00, \
 		.framing = 0x00, \
 		.out = QOS_IO(_interval, _latency, _sdu, _phy, _rtn), \
+		.encryption = 0x00, \
+		.bcode = {0}, \
+		.options = 0x00, \
+		.skip = 0x0000, \
+		.sync_timeout = 0x4000, \
+		.sync_cte_type = 0x00, \
+		.mse = 0x00, \
+		.timeout = 0x4000, \
 	}, \
 }
 
@@ -1011,6 +1022,25 @@ static const struct option main_options[] = {
 	{}
 };
 
+static bool str2hex(const char *str, uint16_t in_len, uint8_t *out,
+		uint16_t out_len)
+{
+	uint16_t i;
+
+	if (in_len < out_len * 2)
+		return false;
+
+	if (!strncasecmp(str, "0x", 2))
+		str += 2;
+
+	for (i = 0; i < out_len; i++) {
+		if (sscanf(&str[i * 2], "%02hhx", &out[i]) != 1)
+			return false;
+	}
+
+	return true;
+}
+
 int main(int argc, char *argv[])
 {
 	struct sigaction sa;
@@ -1028,7 +1058,7 @@ int main(int argc, char *argv[])
 		int opt;
 
 		opt = getopt_long(argc, argv,
-			"d::cmr::s::nb:i:j:hqt:CV:W:M:S:P:F:I:L:Y:R:B:G:T:",
+			"d::cmr::s::nb:i:j:hqt:CV:W:M:S:P:F:I:L:Y:R:B:G:T:e:k:",
 			main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1181,6 +1211,19 @@ int main(int argc, char *argv[])
 				iso_qos->ucast.cis = atoi(optarg);
 			break;
 
+		case 'e':
+			if (optarg)
+				iso_qos->bcast.encryption =
+					strtol(optarg, NULL, 16);
+			break;
+
+		case 'k':
+			if (optarg)
+				if (!str2hex(optarg, strlen(optarg),
+						iso_qos->bcast.bcode, 16))
+					exit(1);
+			break;
+
 		/* fall through */
 		default:
 			usage();
diff --git a/tools/isotest.rst b/tools/isotest.rst
index b2f4e4b38..124dc71ab 100644
--- a/tools/isotest.rst
+++ b/tools/isotest.rst
@@ -153,6 +153,25 @@ OPTIONS
    * - **le_random**
      - LE Random Address
 
+-e, --enc=<ENCRYPTION>  Socket QoS BIG Encryption
+
+.. list-table::
+   :header-rows: 1
+   :widths: auto
+   :stub-columns: 1
+   :align: left
+
+   * - *ENCRYPTION*
+     - Description
+
+   * - **0x00**
+     - BIG unencrypted
+
+   * - **0x01**
+     - BIG encrypted
+
+-k, --bcode=<BCODE>  Socket QoS Broadcast Code
+
 EXAMPLES
 ========
 
-- 
2.34.1

