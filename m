Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DC53C464
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514933; cv=fail; b=eoBWJxxThS7OWsl2ucqxZ+IHKmeI2rilnoo5+QtykjQmzd3caJnh4AuFFhoBtZ89PGoD/0WUDLn4xQ+MWd8cdjeJyXCGgGCxFlBo/8JjMYrOBQKI64dl6NrzD2RmsaR+JnNqJIUWQ2WRElQJDu6PJK8oS5fb5dq0xDOmGRSBp7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514933; c=relaxed/simple;
	bh=9gi5K1xQgcmOvmwAXK7Ymm6q2jMIsICcl91pyjLuuwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nvaWLR/NrMk2HicLB5INlvC+GIB8dTNDfxQvuyjsGVZhbmzlYRDku8aCKWdJjVr75XNUwSfSOz/KwkpmGTurdQtBmfbNlrVwvZz3wfryH3Q1trS/aC0morXAm2fp5gX2zBZb/hfqMOhCefnrCL+A1MXTGrImF+6oIcfDBarXPPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iw3Rwf9o; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iw3Rwf9o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLCpygrRaykhTFQnhu1CCaVsWirm/X0EW4wgceNTDupqdDljwb7nF+m6e0nE7/TEr4/razAKAbd5r5TBiJ6RzNpmaRXSB2Wf3iz3yQsjxgUZKfssWWrjsTXOE5z6QwXdauuensdKuEpN+ZBYQUqqhIYOsp/NNMTG/eIasMiezfMy0J2PniXtfO9d8P4Tnk06BPlrrq8JIJRn2qA3erEeMERKMbIee3z1XBcO6yBk5lifWRvneI8HOTFDsW8bZSOV75pVX10mNgoaMR6XtUfb02l/Tkp2U7MLyZIJLk0HhVKQBOs646vbJ3q+Fx0K6XcGStruw74nplJn7uv8m/mxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6ud/X5bnIW/fTMwgvE+Ojp9GmqfeJMIOE+iYE1iHsA=;
 b=BOlVZwvUqpXsv4B9z+LGxethSd+cH5zfm0NGWCY9mvh/1FU9FxMN+eOtbqfHSzic/3HXsiQO5T/fDZJYsI31KX/foUtTDM0hpN9XE5EcdDxwvlLzzn8tIAWUgCaXAXTOLqt8UshnZCrEN65dNhG04hxKGoZdic8WuTahb7scK1WzUOXsjnT0erW3Wc14k4nC4wh8Wf/fm7MEh1ZLcEEPPO0C++8L4UHFSKdN8PYXGFzkuRPa4MjCKezyAyZIsQ/02zpMnXjaa+rHoBmt42W6iMxkSmQoYmCv3TbdYF+RxMGw0gAkt1M1IbkLM1iyjK056+I6YReLSAoCpyFWhxfWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6ud/X5bnIW/fTMwgvE+Ojp9GmqfeJMIOE+iYE1iHsA=;
 b=Iw3Rwf9opCLLZBHRL/XHuE8xkE5KtKoNKh2nAXaTsyyEJtifW71XW6zoTNFily6WU8I73ng4S9XtRIabtuDaKu4iJzfguTOy3Ialz1zeV7kHOC0M85Xn0ylFpMOKyrpsZKGR4oCtqWMKPhn5UJUDzpUbPRIQ1qrCHHbenJ9s8IQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 15:02:09 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 15:02:08 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 1/5] player: Add reconfiguration prompt for broadcast source
Date: Fri, 15 Mar 2024 17:01:54 +0200
Message-Id: <20240315150158.79715-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
References: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0054.eurprd03.prod.outlook.com (2603:10a6:208::31)
 To VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb88492-4a8c-449b-b82d-08dc4500e2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KGi+reKFRZbsIaQCqobk/2XWIIMuDhFbstJ9rmvyJd/uOMowsazrRF4fpGCszenoZqB0HwLCuqGo0K2NhrtyOpZ7t+RyLE6WvHrY5X9oTN+nF7Gc6+DUlfcjXtjrbtOn30UGb2Vs8mesDS60L1Ok8Hu63Jmwi64b+JUDv/SdL+MklhNBn5oXdCdfeKmsTEoJpM3sQbbZZcZjpFsJGutsW2D/Ur0f84Z/8B9xmgFSAKNycy1B5M3+KvkMJ3fI5rrbsNvzwy+/hQKebauzQd7iYDzBPcaRfdOEIAxikICGYl8+7rrKscS9ZYt5gwXVaXGKnqZmFnnrO+UN9pJtWtuhu6M/tgsVTSFMgRqx5HfETUYsTnUeYQRdi8T6CZNMKVx817T+xyq3BSVA8hEb6EthhQ1EjAmh7wxJYSCFcjaT7affqiJgS8hkxPQxKB2k9fEXEyiD7AK9h0Sth680BCW23gPUomwdD2vSd64us6knHuDHV4385lIAX25T5M+bhQmlNL4CqNduB0+W1R2mm4WuQmN1Kunbxddf0Qqdfx1JQzYomCret/WtGmGicsp4SphrLbc4JoKRxvvqBebQoYSvv5A37cANkizwO5RaLbfAAO/fucTffX1TiY87vR/jTHi/elSHqRt8NScbpmqct/0zCfy41rrPUUkAok7CG85QCrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jZ9OWkKkQ8aHC3tB+3VjuORD6ozT1nTtmEBc4B13Cdp5d+/IqVPe9f0FPvmZ?=
 =?us-ascii?Q?h4MT6F/jZSUABLtSUjvYIhYbiUr6614Zv2YbJbMY+diLID3Rqk20h4gs1LRM?=
 =?us-ascii?Q?ibauANSMx2qb+cdWlmyRRORDfaMBXcwNvQ98JMdDcBWH7hfdxi5IcVQ7EM9b?=
 =?us-ascii?Q?4XH8yUwsa9G8zNW2pG4ALQVgj2MOfKAyG2ZanVEuYfq4nLPxrh68XDV9eLh3?=
 =?us-ascii?Q?l3eBcDUbexkdCua6+wpEYWCvJykWUp1hfPZtduXmnxfwG2A3sjJgXXaAz9uZ?=
 =?us-ascii?Q?qYuc5me+odhM7BwRN7exsHVEt0hHzyKTjVJIFDUPJOIinxDik2c9NWX7tlsJ?=
 =?us-ascii?Q?IbqLHt3HJPaF7zMBNxuWs+g2AemE3qZwTo8ymhv05hQ7xfhH4c80IraHPikl?=
 =?us-ascii?Q?uWsv3HPvBWSwDP7ipwxlvKDDrO8rML22QM6xO290j6JaLObl/8fmQ6NNzCYO?=
 =?us-ascii?Q?X7AMFmwccXQmdj0yytFfIMogQplXYWKDUHNO2B/MLMbWp5pWiRxoc+3eCVB8?=
 =?us-ascii?Q?paANf1CUMZw4tTb4kh2KjNju1iNKZl6pen5qEUftQUlsHNTDlP2WQ7hX2t4R?=
 =?us-ascii?Q?0WYCh27Rnka+nXlvLGN9Onn5tJv8A93MLcvpMABx51wNXgAqD+UQkByGix8T?=
 =?us-ascii?Q?l/3p42+e8kr+1t24/e4lKvQj+Muk/J4LIpqE6ujLAqe3F77haIgW+cPBEJ10?=
 =?us-ascii?Q?tMGgHT2wA62awkhRo37ji0gf3CBFQsTf/mOPNu6Nw8q2kMPJIBLBOrp7aV/b?=
 =?us-ascii?Q?S9rExM4y6OzTUTFWvVuXMbJ2tGlUAveHMZMgFpSm3+juX5O551UhdvMXBjiP?=
 =?us-ascii?Q?g2wmkjJAQ6lwaadgmtqz32MEkKI0eNELn5n8QnrCHn2i4VLdTN5icOTy1KHp?=
 =?us-ascii?Q?CnrfMI97LnzIhulpg3ZKbRJ0hmxH32knSQnXP7Xhx6p4udR24GTo0dpwSzGR?=
 =?us-ascii?Q?zh/Cyxyc6xn9LUkltaSOlFdQMxtWBV1JowsD3JilH+TE7KRPkefBe7xBsog6?=
 =?us-ascii?Q?esavULhbt/f6ok/Y5bwphD568hkiVV8jiQ+b2B2K3q4eacd21Jrucyzs3QUZ?=
 =?us-ascii?Q?tz8800jKJOKXFlYQmrOF8B3FLczYngC8yZMIB7eRIDZtfomd+bjCIkHcyufa?=
 =?us-ascii?Q?mdOMCsx7FDqgt5JvItSxj14fEg7te+ARc1qNC8Wu2f8zyL/Po0pa6HuqwAcr?=
 =?us-ascii?Q?4LLSXy4XGRE0ATYeFVqixoMuQwk8IoBjk+CM+WaAr8sdHBZ0J3kZDBcB4lni?=
 =?us-ascii?Q?pjlc1ktjvy2x2OQlavSKxMBK25z7XSmICSq/UILQQCYR9FW+w7PTn5T9WPaf?=
 =?us-ascii?Q?eww8xnhX2eneNjwUyQ2bGV/1y63TxfO4kle9j8Ic2fig5SN3y/vjKNWKar7c?=
 =?us-ascii?Q?iZj5owSiWZjMCg1QvpZ9jEolOFftTm/I2ePv8aCEz7f/kLgJ7F5I8cE2pgMe?=
 =?us-ascii?Q?xGbnVWsLtDmdJJ4R8M3xNzKmPT6kRWhtoWBrmpfxb5VEsi1zjmixtHnbodBJ?=
 =?us-ascii?Q?ou+NaFzU9juOfcx+ygVtw2lguwNWf1PRnfjkKHjo8irz1jBKpjmCFWmndTAx?=
 =?us-ascii?Q?wXj7SkqUf1RS8X2vZ2AjTivxNbkQ7/lEKCWH+ed96puOia/j0V0NrioiPucd?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb88492-4a8c-449b-b82d-08dc4500e2d4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 15:02:08.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fHM4qkQo/fg46JWfAaxl9oVfjJqwm7PGWFVqF1McGWeo+84RbkaUm3QVXfoRpF6IgiURgIAkThCm9OpS6C6JzScEv5qNXrpIIoKZrstc1Ho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIS Index for reconfiguration? (value(1-31)/no): n
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): n
---
 client/player.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 8081ddc13..c754af33d 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3659,6 +3659,35 @@ static void config_endpoint_iso_group(const char *input, void *user_data)
 	}
 }
 
+static void endpoint_is_reconfigure_cfg(const char *input, void *user_data)
+{
+	struct endpoint_config *cfg = user_data;
+	int value;
+	char *endptr = NULL;
+
+	if (!strcasecmp(input, "n") || !strcasecmp(input, "no")) {
+		cfg->ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
+		goto done;
+	} else {
+		value = strtol(input, &endptr, 0);
+
+		if (!endptr || *endptr != '\0' || value > UINT8_MAX) {
+			bt_shell_printf("Invalid argument: %s\n", input);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		if (value == 0x0)
+			cfg->ep->iso_stream = BT_ISO_QOS_STREAM_UNSET;
+		else
+			cfg->ep->iso_stream = value;
+	}
+
+done:
+	bt_shell_prompt_input(cfg->ep->path,
+		"BIG (auto/value):",
+		config_endpoint_iso_group, cfg);
+}
+
 static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 {
 	cfg->ep->bcode = g_new0(struct iovec, 1);
@@ -3674,8 +3703,8 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 	}
 
 	bt_shell_prompt_input(cfg->ep->path,
-		"BIG (auto/value):",
-		config_endpoint_iso_group, cfg);
+		"BIS Index for reconfiguration? (value(1-31)/no):",
+		endpoint_is_reconfigure_cfg, cfg);
 }
 
 static void cmd_config_endpoint(int argc, char *argv[])
-- 
2.39.2

