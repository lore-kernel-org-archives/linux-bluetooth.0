Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876CDC25B48
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 11:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjJXLEq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjJXLEp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 07:04:45 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A42123
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 04:04:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0s5+gMYnXoFziaeOdsqFHvBfDiYR1THzdA03goF6HHavAlavODtoCHfcsscKZcHurvfbfQ7jEGsDZuHh9CQfkbVEN2g+v1J2JLrtH9gOSn7B4a8ba7eL2nPcCKnGq1XpyGfSE/sgkgRMJFKyFsUJrq/c0VfIliETOESWVhfDdvxlFpUkEL457T8c3kbUl9/dlIOqk2AqFfnskcjPTYgE2nziiEb/lw887nVLHTrcw5yxivYB1nbbXR4K2pqaX49TH72hOWXjBfcGq2SrCy8FbhrXSbSoci1a56gLyTRD3n1TJ2t/lHTeZktOE0YuJJJiFkaqZGAJVufcw5IuGacuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dx7B4EKMOTK+EX0UpL1IhF1E+EOXLjFNSug0xsRLozw=;
 b=oQEO3GlFjU1OPSQav3fqKB74EAuq9BmgzteVkQQn2+QisAPiP5n8Yra/eGovDh/cNcLYQrqf2IV9c2lGybiXy9UlEA4QxzM6mVjPuklb40Ji7pz8Xu+UoWHvxNU11jz3Gpepb+S4mBjzHo7sITPJ1qkIuZSgW3p07aDyKxBvsYqTC+a0uKytipi4H7TB6NEXojqdwd3z/Vb1XL06bMIw4MFMGsZdHdGOpOQgWTTBmlo/aydvDTicoKp8fp7KbXMWUfWNCBum7ViYHxPF7unzx0BmvRRsZAxQ9A0QjuiOdqERUBU0eoxegV9PlH3BlcRa0NCuatXDs0XkupFaxcCfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dx7B4EKMOTK+EX0UpL1IhF1E+EOXLjFNSug0xsRLozw=;
 b=QEx3FfwxkH389Ge6C97ajeWcwaXydFbCGRI1Oy1AgdcgsgB61c22eoj9pFyHxX7XOtOmJsEXR6nhBBGd2C9qxPqmHiNeW2EGMaR7VkJP1VCKVfQ79HJpUL3d78uZRkw7q7Dr349ji/eFH2Tfk42YUU4q7AKcCJozEmVpbrABfH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 24 Oct
 2023 11:04:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Tue, 24 Oct 2023
 11:04:40 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] btio: Allow binding a bcast listener before accept
Date:   Tue, 24 Oct 2023 14:04:30 +0300
Message-Id: <20231024110430.3323-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024110430.3323-1-iulia.tanasescu@nxp.com>
References: <20231024110430.3323-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0094.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::47) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b39b99b-672b-415b-9092-08dbd481053f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05X1Znt6QjnUhVbkktNTJZULtVURX87PAJwTn62DCamI5y7qZHXotIdUjvB27WRKdrr3NBKKckWdj62YmEvBx6Nec0QLUuKQCr2koAxcIfZBoH0e9nPxx80egYggNeW7U1BU1A5BlJWM6uSIl4ry/ewtx9PSsOum+hd6E9v9HSVQsEfifSnhCyrIcD2CpH+7QN1WXbHZI/WGFQpg0mYo1ZEwx3+n9VJuGCAzbySDj/lMnUn4HMmiKdBYR4UEA5t0UwUU29DSrx3towcdFI8vQRDA08aVDl3kVQP1/F2s0g8oEj9QDC6JjJYNJ3vKaUwhjs2TF+DUqD7W03aTPDswnTxt/M0ducGcMOWVSDLTfKmZyQYPA237OLn6hZpOJeE/JuX8jNFcw1t7MIPrYB5SRjlTzTg0wNbDk6zo+JbrSmU1US/qnJVh5imvZ8iiv1jaZWWo1Lsb+JQDDkg4/PjWOaoAh5O+h2frdt5gE4UMX2V6oR2YKUlwf+BsG4waIGdXzP+Y1rd2koBzFv+JY3k4bsCijTOH74eISgskbI05WPyEzck1MekZVgzBMf231DSSY+KFwNrCS4OtxfaO2OucH8GiubMQCgd8AtcaenGNPrEnHQnX1Y3QsytzO6mUyu79
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(36756003)(316002)(6916009)(66946007)(66556008)(66476007)(86362001)(38100700002)(2013699003)(26005)(83380400001)(8936002)(2616005)(1076003)(6512007)(6666004)(8676002)(6506007)(6486002)(2906002)(478600001)(44832011)(5660300002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+rSs5+6a/s/VMtAxs0TQn5kLmJdD5DVPSjMp6XbNGmHtLn09u5A8BeFfFuuC?=
 =?us-ascii?Q?M2Djbl4oyUdjS+SpvFf30OwL0oamQ69cX4CcCaKwoEp7pqCNPpaIFg8nmDYO?=
 =?us-ascii?Q?LlYr3M52tGz9MIC6bLEbCHfZZ3Vp0SH7z7pHxT6aKX1ys5GCJ6aNd9KYt5Ma?=
 =?us-ascii?Q?Oo/gQJDbWc5+0LYcpSxzFexiq8xMNF8UewRm/+ikCRxvYokcBIAIOTflwbur?=
 =?us-ascii?Q?6C+Yj+iFE3jSwpZ4a+DRVBahc/6ppa8CLp4hJVgaRYiwnKGh5HUjx99O3irA?=
 =?us-ascii?Q?Ym2Qp5rB9peXo8vMSZvuzN5HZ0kd5L+xdat2HXpC9wSEf/CEfMBGkiRxL+sB?=
 =?us-ascii?Q?A7EhcXZn1Iq36fDvcLPtnDRtdoDtNtZMIDjbgUPrWnpSxnxWVaPTBgaTGm3U?=
 =?us-ascii?Q?zX8TKgfkuubgXXoaUgK11HEdGyKSBdj1T6dFQWA7HZaNNmJckwC1Z1A+/z57?=
 =?us-ascii?Q?affiiWCZ++Onu5hkbHL+UcCQtIjr1odR5986VZ9zi8MPAR0kE4AYvAom/mTu?=
 =?us-ascii?Q?mGGcUmCq1/9/JzRC8l/DeCPBTv7ZvXYtrodio31mOJPhDY87I774S2p1xvL3?=
 =?us-ascii?Q?UglJffsyw6mYFdsEQHZov1vz81xun+iUdnnpB12UhWznGYVILNTJV+5/52h+?=
 =?us-ascii?Q?wL2OxEslITHlfQRGA3ybi+jV7kOfBY59xS+v9exa3h7qsk5Xt6kGwGO+yKyq?=
 =?us-ascii?Q?P1BpvNIVD2vT0Q5G8EWK8KD4rBngxpUOlOxxw7prvawZwYwPuOcDeuneAo1f?=
 =?us-ascii?Q?g9Rfr0tPAoa2duR2iYbksGe9fkLHO3fEB3gVDotcjCv2yFrA3GlGWDbrqZBY?=
 =?us-ascii?Q?8f735Vie2iCSKoeNueZGUpQTpnt9BxSNN4cgpF2X4Jn8JKQYnuC/4rbOVaUt?=
 =?us-ascii?Q?WmKLZ44TMsLWKL3iSZzogknmL5YkSZtvrM5QDj5egsXtNBu7gxdxk2pf/eUn?=
 =?us-ascii?Q?EtVPjiZIcumErfKaIR+56DSsssjn0/wz7pG5JQrD7WswXVSttCxEZpHVsMgw?=
 =?us-ascii?Q?cdWhkOSh4XtdeVjNtpph0QaPhvyq8NXE8k5NY0fox7/gh8ZUxYUJhs2MLYpx?=
 =?us-ascii?Q?GkvToDPfDLMhJyffAoNOtrUyZiHlhi2DGqSTjsOZDs6qqCsHA9Eg2yHhgUIk?=
 =?us-ascii?Q?iLWquzvGXZUYs5jfSOA+pdbVCvtDnpyJX1bszEWWmf97oYFDmcaWh2k/sWgB?=
 =?us-ascii?Q?fdHKwCXt1yPRdsp7pn0bgKQ2AM2OW1pxWNj11pKkoJQUWAL8/xQooy2s79Uf?=
 =?us-ascii?Q?WCea1in2wijH+dIdGzwTzC15yDRW5E/2DCuW13SDsFKd9XtSfNiwI9gNdTwb?=
 =?us-ascii?Q?T/+XcZdPCxZ67AH5D8lYANFuVtCPy1baeVuqklr4GbT6s9hGH8Y2l9AZ4Poe?=
 =?us-ascii?Q?TouFQKjiAPZJiYUKjPn1Ag5+myt/vDaSUT6xGxk3hMDHD9OzJQJhrBWNji4w?=
 =?us-ascii?Q?Y4SLCpfNU6aPIVpdmiwFyXRH/tfbH+8VGsosPxfseniprkCktB5tgf64E0De?=
 =?us-ascii?Q?fCX1FSy38hP+UNrkhzIiRtbCMhqi8fhwsXPpA+t691EI4uuj3VYluiRbrh1/?=
 =?us-ascii?Q?4ejO4Fv4XoX1yeP3JSgEIk+s1Y3E1i7a91pKR8zvps3mkZJRPJfwL9DFi/Ou?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b39b99b-672b-415b-9092-08dbd481053f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:04:40.8063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XphZKg4Hs4J7cuA+8KcVoXAPsW16zhHyiKtFzNFnRPg8yjX8l8H4YQ4xJdvE7TXxTVLCd61WIadkI0qxNv16gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds btio support for binding a PA sync io to a number of BISes,
before proceeding with BIG Create Sync.
---
 btio/btio.c          | 55 +++++++++++++++++++++++++++++++++++++++++++-
 btio/btio.h          |  2 +-
 profiles/audio/bap.c |  2 +-
 src/shared/bass.c    |  9 ++++----
 4 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index d45b8240d..d30cfcac7 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1796,14 +1796,67 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 
 gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
 				gpointer user_data, GDestroyNotify destroy,
-				GError * *err)
+				GError * *err, BtIOOption opt1, ...)
 {
 	int sock;
 	char c;
 	struct pollfd pfd;
+	va_list args;
+	struct sockaddr_iso *addr = NULL;
+	uint8_t bc_num_bis = 0;
+	uint8_t bc_bis[ISO_MAX_NUM_BIS] = {0};
+	BtIOOption opt = opt1;
+
+	va_start(args, opt1);
+
+	while (opt != BT_IO_OPT_INVALID) {
+		if (opt == BT_IO_OPT_ISO_BC_NUM_BIS)  {
+			bc_num_bis = va_arg(args, int);
+		} else if (opt == BT_IO_OPT_ISO_BC_BIS) {
+			memcpy(bc_bis, va_arg(args, uint8_t *),
+					bc_num_bis);
+		} else {
+			g_set_error(err, BT_IO_ERROR, EINVAL,
+					"Invalid option %d", opt);
+			break;
+		}
+
+		opt = va_arg(args, int);
+	}
+
+	va_end(args);
+
+	if (*err)
+		return FALSE;
 
 	sock = g_io_channel_unix_get_fd(io);
 
+	if (bc_num_bis) {
+		addr = malloc(sizeof(*addr) + sizeof(*addr->iso_bc));
+
+		if (!addr) {
+			ERROR_FAILED(err, "poll", ENOMEM);
+			return FALSE;
+		}
+
+		memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
+		addr->iso_family = AF_BLUETOOTH;
+
+		addr->iso_bc->bc_num_bis = bc_num_bis;
+		memcpy(addr->iso_bc->bc_bis, bc_bis,
+			addr->iso_bc->bc_num_bis);
+
+		if (bind(sock, (struct sockaddr *)addr,
+			sizeof(*addr) + sizeof(*addr->iso_bc)) < 0) {
+			ERROR_FAILED(err, "bind", errno);
+		}
+
+		free(addr);
+
+		if (*err)
+			return FALSE;
+	}
+
 	memset(&pfd, 0, sizeof(pfd));
 	pfd.fd = sock;
 	pfd.events = POLLOUT;
diff --git a/btio/btio.h b/btio/btio.h
index 3169bebf3..3e69092b1 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -77,7 +77,7 @@ gboolean bt_io_accept(GIOChannel *io, BtIOConnect connect, gpointer user_data,
 
 gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
 				gpointer user_data, GDestroyNotify destroy,
-				GError **err);
+				GError **err, BtIOOption opt1, ...);
 
 gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...);
 
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index fa5cf1f54..b74498c4c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -981,7 +981,7 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	GError *err = NULL;
 
 	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err)) {
+				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
 		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
 		g_io_channel_shutdown(io, TRUE, NULL);
diff --git a/src/shared/bass.c b/src/shared/bass.c
index 0ee3187d1..ce8b239f3 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -743,8 +743,9 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 
 		if (bass_trigger_big_sync(bcast_src)) {
 			if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
-				connect_cb, bcast_src, NULL, &gerr)) {
-				DBG(bcast_src->bass, "bt_io_accept: %s",
+				connect_cb, bcast_src, NULL, &gerr,
+				BT_IO_OPT_INVALID)) {
+				DBG(bcast_src->bass, "bt_io_bcast_accept: %s",
 				gerr->message);
 				g_error_free(gerr);
 			}
@@ -1129,8 +1130,8 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	}
 
 	if (!bt_io_bcast_accept(bcast_src->pa_sync_io, connect_cb,
-		bcast_src, NULL, &gerr)) {
-		DBG(bcast_src->bass, "bt_io_accept: %s", gerr->message);
+		bcast_src, NULL, &gerr,  BT_IO_OPT_INVALID)) {
+		DBG(bcast_src->bass, "bt_io_bcast_accept: %s", gerr->message);
 		g_error_free(gerr);
 	}
 }
-- 
2.39.2

