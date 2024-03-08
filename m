Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B8568A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916764; cv=fail; b=Kj4cwfvCPMNKlNwV4MRlLY7x2vGZJpC7K6KDxdE7RBWBs00etgeYFaaRi09crgABQTEDkbspMTfxJlqoSONho4HJ2abdY4FyL3j00cMs24FkCzYLGGlX1T1hJXaeQkttmEU/ONrccUD3+aU09wCYOiB1RG80x5iFjHFHuZ+UsSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916764; c=relaxed/simple;
	bh=6H91+ell7QxG0iU0eeQr9ilKxRPMiYvwfka/xCcJQF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICf769tsC86iZE/vh98eLQL7DAPPThSbcximSUvhEEoOlP9Zp1YKRUvVov4TsNaxbzKEpp2bKLVa+tfpSw7XdQGzorqWPp1IemsmWLVd+R3BD9BSJTX1gfbGdmysvYeVSDDHrdKwMfKd15xgnBl9F5w1NyOuBVKy+vVcZ40y7SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HWvXidBY; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HWvXidBY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGFXd7oVE5MUEDJUAZYu8Es18Bp56P1ZbcLrNRlWTqOLG7iETOxy2toqIWNUtZcz/RGrODTljoLD5tvlcEoUs6AuhI83GZW22NZyCOtFGbw9dlhjhX06386H2mdFILo2knWpIaU0hZftbOUTEhgTgYpS2L0AwEdTEEIOBfimJtzSkROGm0eqDxF4BJZQjOOK59K8BHYyvhtubhwiaJRXUFqA+Ls+dRXY7Lf5O4nL9XtcN0fFzVR93z+ddFrwq1DMNqB1ou9/7qO1mhYDJBjd5d/6vsGYuiQdcXWc6WGb94SoBKf4jh1ZvayDrLhP3OgOnr9yc09C65fyQTxrvp/Blw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcCedravAhcWHXbfrjz/VpIr8z/dBR1tEBbH2gkNNa8=;
 b=bcIPUwZHxo40OeS184sVMWZe84av6NzVKpZI8m+JklYWofIeEctajJB2XrkfjB57M3Exy1xNyMGhOwhAerc1QEsJ/uC2KWs4gNPiNZs/GPvW+FWkI4M+MF4KeLEYIju3+BLMhB/WTOy7k+ygovB0X7ryWp3L4NPz6LkcoENjuxaqVB5h0iQQI3xYGFXEM9jGc5MScxIoJguobl/wC5gvfhMU6oJTCBqCiz5XilK/v4j/wbrJd034i69y8SEG0mzOkJ6PLosaSkv0qLV6QFBAgJYo2C72i6SlHqVtnEB0Xgl32l9oPTdOjEoM8boQbC2ZSmxXmeW1vN9JFB1hTi/tLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcCedravAhcWHXbfrjz/VpIr8z/dBR1tEBbH2gkNNa8=;
 b=HWvXidBYyHo+vkrnfR0YikHTnV8/it1gDdDl3ZfvkkvFjuH0Uzh4Ouol+uxxAb+vRTpOgYt075STh2o0crYUc8SdMtUA+zMbxWfuAqBF2Ffhc+IQBKr2WCSozpojsBiQVG/P7utDLfpeA+nYmQLU6J0YMR5j39oswgsT7DWeh6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB7572.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 16:52:40 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 16:52:40 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 2/3] transport: Add support to update the transport configuration
Date: Fri,  8 Mar 2024 18:52:31 +0200
Message-Id: <20240308165232.53906-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308165232.53906-1-silviu.barbulescu@nxp.com>
References: <20240308165232.53906-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0036.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::7) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 7447db6d-563e-404a-1a7f-08dc3f902a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CxPd+vsFu50o5lMeQ7zzMyWMfwtApsSPVzhYzEuCUgGFEGBitRZ597aRj6OASWeDmTBpoZx8VvckABWgY2CFtTCcq37gqTlm5cs6+OntLuWYnqt+/TZy8eLaQAwMPsVC/IQxPA0r2m3d3iRiuiIstR306xWkVPvA3l09sGs68zuxeK0XleiReguJgdtvcdOWoVXayPgBdqMMX5PeOa8idQ79nZhsSeU+mWLfotLP3ClfR3HwissZp85AliCkP9SLKpViiBqpbOLkIvmRnXd0/5MBPPSOsvE+SC6DpViYC7R4cR7SjRqag2lsXE1zQvXGPGKl+pdRMLSmNvAiMB3YT8fLIoysohnpQphCLr/tr064lMdmwAy2rIkhet0uGX3nBmNR7Se9aColkwEFCVIbckHCfZR3W2YuAEgkJLxoywIJ7bosT12/qVFO29y0dtLmhlo9op2JAvXo64SjWy6Beri6FeprBGfOV1JbtAJF5me0s7dri9nBa3Wq0aDyT3ImUaNGLhWUKsl+2UkRCOJJk3aHt8E5ViaDALVF2gZQpwP9ZIPaotwtUwdRZn2/rHlfOxvnJ2qpIn5w+kqB4XftwyBga5gNqnf1HPPto+013+DWJkBNN3/6b63XvzpVepVT6bGfxZJ4FTshtj8Dvs06rXi0SLNHgSFRT8dLp9tIrFY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XujY1236kilvIei2CEZ7heEy7jsfGi6O4wXdt+IJRTmIB+cW8EiKnwGfNAS?=
 =?us-ascii?Q?NLaBNaCUxP8tuWhMRtoLEy+iA7fTZGukjslM3jtHluqfkkGaVDUByASdeXSw?=
 =?us-ascii?Q?P05xJyWQtQRabmIlSvBjTwnQAoSiwOLIi/R1lgotkFaGaSJMG6IICE2ATMqZ?=
 =?us-ascii?Q?Vc9WIP9UHlZE4UT6DXjwQbPX2ekIM8DMADkDkiMmneIZcibffoQai30lmnoJ?=
 =?us-ascii?Q?hfq9P86wfvgMQ4rvxayR5fpetg5iRX4c8udGV9r0E+otkIpygJwLHVH3WxXc?=
 =?us-ascii?Q?IkTCoHzCbI5hlzqq6z1uu8CjhbAS0wKZiKlQZ5bgdfTvKKGH5Rrt5+Ubc3mO?=
 =?us-ascii?Q?JvpTVIOoGbBhPA8zOw0vlwNcbvZNz9AnfDoIMLqjfkdjpvAL8931O89w7cyR?=
 =?us-ascii?Q?W9DTSE3MykplH/v7fAZ7kQP8xvqTgdC5Y0HMF4CW/N2VTNiHq5nvJPqJppcG?=
 =?us-ascii?Q?QvLCbbeTN7ExDn/8Q2SO8tDxFspFv/wcSVyX2Sitjj1/b8fCqLVL+lfMT0dN?=
 =?us-ascii?Q?utZFNzK2tM+sS9S2gSA0FtGFQN+ddT+1mnqIkqQyU87z8HoUGGtZJeQ5iu8t?=
 =?us-ascii?Q?v7rR3v3X4kWM8gzFR3vLHH7SJxzpokuOqPolg+9ScJ1vi/JNMGqgNtqYWoqB?=
 =?us-ascii?Q?vbxi63znxSgPLytNbR3JCpj5I5Pxnrd6I/CctHAAgmQ4eEvAVgULtGiHM9dm?=
 =?us-ascii?Q?qIJl55aYaADiLIwTtSkG8kRc0q292rbGjgrgVK9luLsLy6DQhz0g4IZdJ726?=
 =?us-ascii?Q?WSV8np6BS/St7xsb/txsY6sENoVE4VBUuCRHiBu9IP4Js26IRkgwscUFIrYD?=
 =?us-ascii?Q?394USpHdi/bWxLNZ8DUXBHg0uTJyC6+JhtjmBTPRpQAlzNqPKeycL+HoD+ti?=
 =?us-ascii?Q?076KSfyU2p1gmAU0x4dGDhT3N8vtyZzdg6N4fG52ouxGj+vL0jt+P8MW3LfB?=
 =?us-ascii?Q?TpZT1N6+4izB1QJ+UbGjDXezY18be0Ab+/Qyvr8DPHVi6TD00ojdUmaXZW2L?=
 =?us-ascii?Q?GrJmCeLwRojGF86MmeN+KwUZu5a579t4AMdkUGXz4hVswy1stE+U+SaR4Kvi?=
 =?us-ascii?Q?qfXHRMxQctM5/NznJ29dtPUyJX3Mb0zSz5cGuHPe3D07MuZShFmdpM4Ctmte?=
 =?us-ascii?Q?DYBU0BpJtTP3Fg4t5qA1cldfBmWysdGmf5hKm+pYlmt8r2ARdDHhKRCg//PW?=
 =?us-ascii?Q?WreKF+BvHeEzehmwQYCbfkanrxhml8Ke/jCoT1UIv2noAana86fkxu9L9HAc?=
 =?us-ascii?Q?tk8CaZnwOEZarQoVjKoxzksWIcnfJyDQoqQGSL6/Z2aNihvK9e0KCzElzNgO?=
 =?us-ascii?Q?B0oEEseA0ds8P3jcaOJkN4EmHXrNtSXKf3xJueNjzws+L9LxHJOS4idaNRnj?=
 =?us-ascii?Q?5mPvLYDMfMT9CnlBEXj7Ife60PXqiMyZ6jcPeHsDhcPxIL9SiZIEa+BPIdH9?=
 =?us-ascii?Q?ca1QcxF4J5F5WtX+IXIj+FXhE+QI01/PxWDe/BXRJeNC3FBq6qdlCp5MczGE?=
 =?us-ascii?Q?X/LJCdIUtB2DVl0nZ4b2wv+qlcwdjxcQOl1m3HR5/Dc3P++xO/2Ibu+uv3G1?=
 =?us-ascii?Q?0whHLc8QSLNPQTwnZ8JV4rUD8jkP0TYXQHmaPSwCqPV52uF3mOaucORVNXDl?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7447db6d-563e-404a-1a7f-08dc3f902a84
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:52:40.1918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZ7USMPVrNNLwgi3s8c8EZSLncZq1+CmKYX/Fqw+M8A2rUSUXRC6Y/jt5fAWRu42n4Q7ulHjrJahhZ3Dj0pc+ZqUIddp04u4kCjKu3JQuzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7572

Add support to update the transport configuration

---
 profiles/audio/transport.c | 23 +++++++++++++++++++++++
 profiles/audio/transport.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 159fbd575..c8492d4a1 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1483,6 +1483,29 @@ static void bap_update_bcast_qos(const struct media_transport *transport)
 			"Configuration");
 }
 
+void bap_update_bcast_config(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct iovec *cc;
+
+	cc = bt_bap_stream_get_config(bap->stream);
+
+	if (((int)cc->iov_len != transport->size) ||
+		(memcmp(cc->iov_base, transport->configuration,
+			transport->size) != 0)) {
+		free(transport->configuration);
+		transport->configuration = util_memdup(cc->iov_base,
+							cc->iov_len);
+		transport->size = cc->iov_len;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Configuration");
+	}
+
+	bap_update_bcast_qos(transport);
+}
+
 static guint transport_bap_resume(struct media_transport *transport,
 				struct media_owner *owner)
 {
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index b46bc8025..6df419a67 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -16,6 +16,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 						uint8_t *configuration,
 						size_t size, void *data,
 						void *stream);
+void bap_update_bcast_config(struct media_transport *transport);
 
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
-- 
2.39.2

