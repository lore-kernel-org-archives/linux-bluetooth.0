Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021093.outbound.protection.outlook.com [52.101.70.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926B82080FD
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664223; cv=fail; b=RX6U8w13TU+kHRbMXgZj853+ev2/zYxFYjs9itEvHiFPjVsQM2yDWB6JGag4hj0XsDhG8DN23VM1DQ/LHv+IB6Zbo9U7jMfdyGtCEMipHQzM5nqofy6ZJjNMMXf7a9RDkFEWmyHD4N8sc5A1R4YwWSRrDMqQA8vArHZolIa83fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664223; c=relaxed/simple;
	bh=b2Lav0haFWTOY/jM0ZSAeCEgswlZvmdF90sC8vIa7H0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tNg9C1j9LetcqVd8/ugjej58CszsfqjogPzNgersbLRsuhlKzZHNbeBDiMBdJ6fndFiLVx2/hDLMUeBp445I2ijaqKzzK28Pfo0OUpDMwxw4wyRnU5GeVGOI4E7AGkOsq776CZNDDMC0IPCzvL+UprkkEkUbdHmSl5tn4vsUoeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shsconsultores.es; spf=pass smtp.mailfrom=shsconsultores.es; dkim=pass (1024-bit key) header.d=acshsconsultores.onmicrosoft.com header.i=@acshsconsultores.onmicrosoft.com header.b=GFQ4foNP; arc=fail smtp.client-ip=52.101.70.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shsconsultores.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shsconsultores.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=acshsconsultores.onmicrosoft.com header.i=@acshsconsultores.onmicrosoft.com header.b="GFQ4foNP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgTrRl3Ku7sT1VTB53QQ+cKRxcXMzgM8i1d/TcZ2ntNiBW0+RwbKKMtRzdbQwCzhJGC2mH21G8lMPwyH1+XHF898DiyTn+kyA+3qCI85NEIS6kRJibBWt3WsY/4y8C62KRF2yiudz2uSbV1rEFB0iPx8dcVci5O13lOQ3+YlOpUhHMRdGLhuHbXVZpVOSw94ssZbu0vKVJBR2foY2s4X0zvth1Yy7v+FWg2PVZ2Fe7r91ZSLfl8LdpSjRm00b1cZFImHKtsgTNt6u20NkfeTKlP7JqtotuUD+vXbAA6r0fPTZpxPxUOS9BgeMU93h9q2ZODIrDPduMeZqZ4oaFJaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0uZhnOyIWh1z7eBa6WM9/Eqk+bbfBFzL4aw+F/zjYQ=;
 b=LW+uAOTiPl7iP1N0vM+ZBOKSl8CQdHQ0YHBtZBmHCTRFH0lMw9xU8iorKpQai3Xm2QAEIdg4U+0IDkgaPzMw2SXu7/gL2VQ+/3o9qFh7nZMoJgFVZI/oAFoGbNcfxUO1yMCYIMmvH76/aHRrZCF4r8zQ1/uni9DE2hFN+so0ocs2EhuyR28UMEZRvH83Cm0Queh2SVUeEPhC4ogCictR/norep8bwCfp2UHFPQlBRTjLbU88TZGRcvDT9Wrd8xswPKYeUVs9BjDm0lpU3odFxXCl38hVce9pBVSjY89pti+mnrfbOThzeqeXB+f92lEerTuJUAEZXWo8bjcWejocwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=shsconsultores.es; dmarc=pass action=none
 header.from=shsconsultores.es; dkim=pass header.d=shsconsultores.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=acshsconsultores.onmicrosoft.com;
 s=selector2-acshsconsultores-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0uZhnOyIWh1z7eBa6WM9/Eqk+bbfBFzL4aw+F/zjYQ=;
 b=GFQ4foNPq2OKWX2EaLVdbWDNRsmU8WFktDbbJvMbLcN5GXQuJPnfIwu4c5BQICUYCYi5AI2G/omsrIdXf33UeSXRwDZ/nM0aI0jL9m0wn0jgRAQ3AEJpO4tzbGAjdyx8BAHurb4zwZMs9lCHakZluH9JwbE2k0g9TZAWt2cyoXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=shsconsultores.es;
Received: from AS4PR08MB7653.eurprd08.prod.outlook.com (2603:10a6:20b:4cf::5)
 by PA4PR08MB6240.eurprd08.prod.outlook.com (2603:10a6:102:ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 10:16:56 +0000
Received: from AS4PR08MB7653.eurprd08.prod.outlook.com
 ([fe80::fbf2:7802:4c0c:8197]) by AS4PR08MB7653.eurprd08.prod.outlook.com
 ([fe80::fbf2:7802:4c0c:8197%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 10:16:56 +0000
From: Pablo Montes <pmontes@shsconsultores.es>
To: linux-bluetooth@vger.kernel.org
Cc: Pablo Montes <pmontes@shsconsultores.es>
Subject: [PATCH BlueZ 1/2] emulator: Fix Werror=stringop-overflow
Date: Tue,  4 Feb 2025 11:16:11 +0100
Message-ID: <20250204101612.66823-2-pmontes@shsconsultores.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204101612.66823-1-pmontes@shsconsultores.es>
References: <20250204101612.66823-1-pmontes@shsconsultores.es>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::13) To AS4PR08MB7653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4cf::5)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR08MB7653:EE_|PA4PR08MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c747be3-333d-467c-2249-08dd45050d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V1DMhxosRVSVELrmhJ09c+WrVLmi4yL7sCqALHHTZFYa7e2ydRTxgMwpbivi?=
 =?us-ascii?Q?Jv0bP4h1ArzNAGz8ZzFzLdfANlt1ObrVQBPMwuD8yybSKjWNXsIHwc1PQC7l?=
 =?us-ascii?Q?TtLvCjnfW6GtQ91MvY+4sICNC916fmBaokiFa2UyF+42UbvfiRraS9b85jkx?=
 =?us-ascii?Q?HodRm1+LXyvzJ2xVqQ29fXPbr9F4PjKOxG3z2ounCYyNBj9x45gDUTPFK6gI?=
 =?us-ascii?Q?T1zQtA/clmKUjFo2W/eusmcFBKLydpvUtNlUN8APKkW5CRrFohhSXy8LpGVW?=
 =?us-ascii?Q?wyviq1zpR7v4Ut4IEIzw8JN3B+pOYS9UwJHL/vl0HltHQhqbVEaLIFoA557O?=
 =?us-ascii?Q?0WUhVnErtXkvaVXQYHo9IoSrbSbrZrQSroQsRKQuoa4qufyz0RmwCOHc3EDA?=
 =?us-ascii?Q?UPE6A4Te+Y2jil4MSieJxtSq9DolnQSpmMW0gHGHeQp6agH45vY3ItDigH2S?=
 =?us-ascii?Q?+l2lzS1vd9RdEfe9/jsyCf315ViC1HwX/2vlnwj9HkkNAlmshiqTgV8SJNHp?=
 =?us-ascii?Q?i5vbJcNW8vKvu1+kixxuGZU9odwgW/ZwRgZIxAR3FjcOm9WsnAiy5sWIHb2W?=
 =?us-ascii?Q?N2r3L6ZfMQLgyi+2JXM9GEP+t7qIBrNK3KRR0D1qeLMWax8uhHGDhXzILRN9?=
 =?us-ascii?Q?eZ4f8E85LRBXAOXojY9iLvIk2dmriRXjG/3qysE4lg8sKv1BbxgqSRZB5xCR?=
 =?us-ascii?Q?WImwm0Rsw5CV6/cgxzYlOI3JnDKP6x3sPGQ2QDUxdvyJKk1xGgONaAld3+1z?=
 =?us-ascii?Q?qe3nqr78+wYhaH6Js9rJ9m6lxx7Sb3PPrAf9/QiNiE3+sts2zuF5HsT1Tch+?=
 =?us-ascii?Q?sn9+MEF0NPuPdQ9dueG+aERMfd5od4s8EQU541IACRbzADRcTXXiPZ877N6Q?=
 =?us-ascii?Q?QUjND8FkLMpwXXxzzrbQYsyNmfdrT0cAIJKRYxoA2wk947YFtqNO58SvQ53N?=
 =?us-ascii?Q?dYHuCT00bVOXQ+Pw5/f7/lDye3OJb1/Ku2paGzNRC5UCIKcbXlIsGb+gGWzF?=
 =?us-ascii?Q?sg2pNA6JlaCh7jf9XV4eMmmh/snsyX91xiCqjWop1XaExzG8Q9MBLMdrATT+?=
 =?us-ascii?Q?k3sRtcyW6y0tiBY9tt5qho1gL4vhFFjZMbIOVRzB1hL3YaliVeu3NfTEpsKW?=
 =?us-ascii?Q?oWTmeatGyTOcdgwa44uWz00h8P7bn9y+X0nAy7EN6YwJbdXzC/LvP0UQDPxP?=
 =?us-ascii?Q?tVEod2G6dJtQczqVrs2zb9FUPulhblvWyGjcncPo6Y7bZ04PswCFmi1t/Cg6?=
 =?us-ascii?Q?GfRKbpDv/3uMCHCTSd/TQm8Qf8Ri+C41hunMh91x8yoSPQWOgX+KVw9uhl1d?=
 =?us-ascii?Q?Kmhe/wvV9em2kS7X72etPmoKm5st73TSNcqtOwMRB3BdEEP1iS8Tjf2Ar+Xi?=
 =?us-ascii?Q?+Nrcax5YNPtQwD2bamxC+mS932h8re0Y84S9xUT69WdxSaUAkC0PE5HXtQRY?=
 =?us-ascii?Q?DQ/KVOLRNcZxe7cLTDjtsYpoYatU91ci?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S5SxABjUoluBePZ2cgf8TSsnYcL85NAHNLvGoyMoldBdyCjkMb1VBnrdrb6l?=
 =?us-ascii?Q?+vdak1RvKEDh0pYMp3YstFIJBhMTYdikq6x/+lD5d7XSm16Uh+c5cbeSouI4?=
 =?us-ascii?Q?GRRZTh4q5hUq0xFzoEBkWDSHtmoIuviAKfXvsbX2XrwhTJFkHBkcIkR3NQL3?=
 =?us-ascii?Q?g9J4EzI7kCta/+K+30CX/ufkTkfgr6D8zvOwEOwup5p4l/zlWvUCcIEtmAc3?=
 =?us-ascii?Q?DQTm3TZ/SZeNjn58Nt0pSMXpuKIKNU8MKbKIB28e8GCsrCGrjVOfLddAyaGS?=
 =?us-ascii?Q?OXzql4ZvVxrH7tNYNqCt6vAZw6vR/Q8GnphqqNEFHi5PwR5YdY5aWBzbfKj2?=
 =?us-ascii?Q?HdgNwqj2xafZ4EpNLeEqxh9E5i6OZU7RL43KzA9XCSt9bFuouq0sH2VaPTMH?=
 =?us-ascii?Q?uTdSKUYlqpDZSWU8ZL8xSbGWzgzC7ZzKgxgZtmgYQ5qa3RKgZVtoiq/Lxir4?=
 =?us-ascii?Q?DRDhtHOHHKje5x+sTl9XO7jxxIXpd5CgYDhSl/91wds7jtrpGEjINyR/SiMK?=
 =?us-ascii?Q?3w5fpWyWkXfxfkFzqihuN5+AlPYPAXorIwCbmhRj+C/3fWcABveINhMmW41P?=
 =?us-ascii?Q?rOnNwDVA+9tD11bgvyZMyzejqV2WHPM2SgtZ6fq1MustkrqikC8K5GdT8Na0?=
 =?us-ascii?Q?muQUJ4YzkdK32TZrRUbFsYI+5DhEmhNxUm43BIlXN98ETviLzA4CmC0EO2LK?=
 =?us-ascii?Q?sZi6KeZ963Xi5pbEvbg0a2T8uAR0V8A4W8kKaWZlrgZlw3g3hdwxIeaZEjkP?=
 =?us-ascii?Q?E3BKk8ie4sUJsD98xbrHa7zzhDGDWzfy0W4HuA6HRr1+kkbKYZlfZ6Qk0Isj?=
 =?us-ascii?Q?iqiXGLzVB2Km81f2mMckn7g6dFunJHFeVaRzdy7ACoFUPpKsrDsyNQL9vKP8?=
 =?us-ascii?Q?uv4gPFZBI4Y6abA+yCTTNAa9pIwjQZXPWSbyz368xZqnsuc6F3q6odTRU5If?=
 =?us-ascii?Q?DDN+Or7OmNXQX7jt3NqAVSDrGmD6f++KVcDMVBQKLAzRHxzt8ElEk65jxTyA?=
 =?us-ascii?Q?P825ghPT8lHIt4iup1+o3g8tw2XwY+xSblNtc98OFxgLS/06SYlsyTMVtefo?=
 =?us-ascii?Q?Aprs8ZMXlJXahloLBE6b/spSPUOLW9QQLXPsOvqzysgCjWbVmDypZRyR71g8?=
 =?us-ascii?Q?KZ5dQSriHRMAWOcUDfSNZJm4ZH0QD8f23I2u0H3TYoIh+54MeLF5pNiuNreY?=
 =?us-ascii?Q?SExuq2CWClKwUPZRhHXOCvgy99mo/c9KyBpV7DK2rteQ+yWPEhbqxBeFBLJn?=
 =?us-ascii?Q?wyLQYkYAkEcCp5qZWUb/XVparWPrZ5r2874WArn+J0GnuRLeCdY3PSixcOH2?=
 =?us-ascii?Q?e06Lof1Rj2a4WuTVmyNMJwBfBBrKQ2Ui+FqmNSnv8eiosAq0kOAaC0RViuJ1?=
 =?us-ascii?Q?TT71eSUhGJ57wneEfLULrtODCXWvPu84DRIh040QDvtb8T5xhL8vs2r+FmYN?=
 =?us-ascii?Q?nb+dPhuMCRlPdqJpPpUzqA0zqAMXixkQfa5YqsEsuE2+vTEvpdoeceOZFCUD?=
 =?us-ascii?Q?VBywZqGRng+SRoNbO8tZkSq8EjgBScVYSyUG4cRtCxoQINOLpEPEELr2CaT/?=
 =?us-ascii?Q?jVIX+MjpygBmcht2PePVusOF32UAx8cYi4BGpGcbK8NzryFKPn9XiH1oEQIt?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: shsconsultores.es
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c747be3-333d-467c-2249-08dd45050d7b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB7653.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:16:56.1386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: daf9f132-b852-43ef-bd93-64da5b8621ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r2uckrXE9w4nFidAp1h0ULDc9Gtzj1t3ikut2B1++l8DmlmN4TyfnEpSMWQSffJjZY8+TWhFQYVAqXJw41cRhvR6A7lGsv0Fl7lIMOrVzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6240

Warning on read for a possible packet offset
greater than buffer size is treated as error.

I suggest using ssize_t so it is always positive.
Returning if packet offset makes no sense might
not discard the whole packet and start again

---
 emulator/serial.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/emulator/serial.c b/emulator/serial.c
index b74556b13..13b844033 100644
--- a/emulator/serial.c
+++ b/emulator/serial.c
@@ -79,6 +79,7 @@ static void serial_read_callback(int fd, uint32_t events, void *user_data)
 	uint8_t *ptr = buf;
 	ssize_t len;
 	uint16_t count;
+	ssize_t available;
 
 	if (events & (EPOLLERR | EPOLLHUP)) {
 		mainloop_remove_fd(serial->fd);
@@ -87,8 +88,16 @@ static void serial_read_callback(int fd, uint32_t events, void *user_data)
 	}
 
 again:
+
+	if(serial->pkt_offset > sizeof(buf)) {
+		printf("packet offset overflow\n");
+		serial->pkt_offset = 0;
+		return;
+	}
+	
+	available = sizeof(buf) - serial->pkt_offset;
 	len = read(serial->fd, buf + serial->pkt_offset,
-			sizeof(buf) - serial->pkt_offset);
+			available);
 	if (len < 0) {
 		if (errno == EAGAIN)
 			goto again;
-- 
2.43.0

