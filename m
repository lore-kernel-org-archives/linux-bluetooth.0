Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20937194A73
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336837; cv=fail; b=kE4whcPLGCzgEgDuutid/YaKQDunZ4ejTP83COlcgD2TyS4w430S+Hs+9g9kbRNLPtrYDE8pxf5sRF/KXb7e9XNDmH1K1loiUPdrMm7qE7ZiGPvTx52yHdHuf7gtXu9w4sWrx9AWrrMtSUgViw9NcCP9xYPS0mSAxMDa2oomg7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336837; c=relaxed/simple;
	bh=czaSDfnJVKCrrkGXMQAvEltIA7s3kIsEDsFBSbxx2B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mhwgm5Quh6H2TrZsLiMysVdVBsfvW/Un/n5QkNG1y+zaNGpDcilK/ro1MoKZVDYahBro8cPb7xHqujZsjen5bgd/szyBErL1m2J7YwrEvacTZf/GtutavxphDn+H6ze2l2/wS+WSCqIdlgqNZYq4j64iodQmQa8UMshOdHICtLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i/irDez4; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i/irDez4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0bjNJgbN+bp94Ub2ljEK0R9+Rrz2JvMniVpqS09Faz0LlQtpsKK+1ZiX2OCsbmne+hPKSow9UbK4DF9fEeBtEbP7Z/cEZytXfA2Cc8wV3rqkiGGp1L1cqkYsxv63RsVzugGBGeLsDi/e/NVTAOKlMgXJaG5fP+NgIymjevd0s70nhEyWDGBWPU8Wij4AaQ9sOfKIe2aCr0HKBtOTJaWb2F00OxgiAVEezwIxcJVQBHTwQ3Cv5lZZAYWnw1FW5scyOX6mkCVqLtnAkkw2V8Rp+yJe/aXyKHsXR2yfl+uZ9Neqn8Iynq5rAtcGpAfQLwCf1T1gGJqVo+bjlp8gtRmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzzAhPYXwU0UJNjZ/EMvu71JfpR/pRsC1GViYxA2wdI=;
 b=lBiqzTyDnR+Xdd2d3uy9AY624EKw1mF/h88akmfbLo1rDGLN0kbG174yWa5/vNjNG6FLvfmYYocFR4GMrW9S4nQcDWsyPwUkpK5HBPCO0LKTcdmwtF+3wxG3RNfNjLS+zqkc5WnjtYMQqO4ulwgakRSuTvJvA00r6GeP/jW6Mn0GcylTWwBzBdVmwyrq7tULWFODEN2QsQluCLAsxM016UVg5YTKkSqBZ4hJhz29D6XIgAdUGvNr05ZW1e4M5L6kp3u24SN4/nE9j73HDvKUGzj1yIDxRfRRS1g3TTMSCa2+NAG85ux7Chg8cG3zjWPVpuJE0tsGugG/YuBWAY/uEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzzAhPYXwU0UJNjZ/EMvu71JfpR/pRsC1GViYxA2wdI=;
 b=i/irDez4YW81CwP2jSVNrmGsHko9EdPGWbOzlJOBLB37AbOiiyFkHOEYC+u2gKM9TTwwkw9EHI9dHqkbSOBwoMkP9MIZ8NQeSTzT79SMHUrwW4PcC47swYb82XgnJQn4+zri0Ka0PmL5TDz/VTlmBlBbyKxTl9T6b5wHMm1rSubRmrTNnk5CzmLyMmucvQ/jH9HMpYNqeW7QOZiUW4vtT3NW+Z8H6OyzqOOjfyOqAvFZnp0J2K/jV2MXjhkQcBLZ6W8pU9TWmQl5TP8qytxj4aRZ2vL+5PKF30RSQyXgGRKw3dpDx7/7Pz1rA7INT2Tscyjwz2SUiF8gQ37usEup4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:53:50 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:53:50 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 2/8] transport: Add 'broadcasting' state
Date: Tue, 30 Jul 2024 13:53:07 +0300
Message-Id: <20240730105313.403238-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
References: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0212.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::27) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e8268a-3508-496b-2323-08dcb085dbb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wjxYgQM2Z2zwGHVitaN1nkn0pdNIuDzPDZ+MZp6VlmrBndMNoKBgACQFazcp?=
 =?us-ascii?Q?c1RoqXx3Zb/JC2S5xefifwIaZQ2Su9PTnX9KcHVcuoaKNdOPutaVbpx7SxwA?=
 =?us-ascii?Q?Wwi1C25QrLFTBfrrPc85l1byO4wnv8+VLkl1ZWwdggtSbl5RYka+qDT52ykS?=
 =?us-ascii?Q?FIX7ske/3VXfEvx6SF589HRYe+0ODKAG8qcnm4eaGbubY8J+LctteCZgfkTu?=
 =?us-ascii?Q?XGen1TYPpBw7poQ5sB/5hi7cDHhhvdTgpcu96c1hCZ4UDAnsz1f/1Z254VGG?=
 =?us-ascii?Q?6cyAY53n9mWQ1YtwCPYC4a635GIOD9I+c96WGPDPIm2dBPA56+EcJBqKJzMP?=
 =?us-ascii?Q?tVTzMMH9V6vel/Y8nAOS3WqA4Zk1jEdZ2xxleR+6U5lWfGUzzhRWft3wOGJx?=
 =?us-ascii?Q?t9o6hJsZGzipLqzKjy3Wwi6V6g9SruCo2X96QYolMspbLCd2mApZRXu5mA4Q?=
 =?us-ascii?Q?74IXvqPDOR/kEGhefzmHluzqCfnFmuNhKHyVzuzw/A8/qHY1at+nOUnpjHCM?=
 =?us-ascii?Q?HKlMwZFzgUQGaZSB9cNL394gRhAiib0EoiWLoKi7aIEm1NL2OLMOpKrr5X84?=
 =?us-ascii?Q?/M1j66gVO0eFg4UqaDmmBWmdgOVyUnvh+fgCtmOPdzoSfAgIIPJnmM8xBWTl?=
 =?us-ascii?Q?esK/nhybHFrLMg4zAqyUtawHJcz5/szEOgcl5PoeJJhKCjHbKfUjo8yAX9pg?=
 =?us-ascii?Q?pQYhs1KjTVc6NOa/o6YqYpRwazcfV2EZ7ZTXS3/MWYKmp9BvDUx5RQEDLyc6?=
 =?us-ascii?Q?EXkOu1+XuY4Kj5ATSQ+vilehUnyONOEjvUiM7DQ8JNSBFXlnZbfF0mA9MhG9?=
 =?us-ascii?Q?cWi10nTdrAao0JxWSfU1bQAL0nyuqqqbXUy3vaw2zvsLObX2SCLZzBMOFNor?=
 =?us-ascii?Q?lePY/OzzwugfitWIg2/RBwjtL4IYTrDS7tT3twont3BQ2VzTv5Nnvu3fK7JM?=
 =?us-ascii?Q?nc8i5esTuvEa56SigTNw3TXtsEb3cCfh9b3yUt6MBXBUtZaZwAR/WoNx+137?=
 =?us-ascii?Q?K7zUOfdSER0QmkNWyqZb4A5MO0nE0PHekK1+8OTLj/6mkKW0ccwHHLjl59sf?=
 =?us-ascii?Q?qwt7vgmAaPFSH08wTRxf/rcP/U/fZANKmfeg3JiDR6FA51RDGDq+MKkpB6vu?=
 =?us-ascii?Q?x45Loyh9yaoXgzGiuJzFqLp+lhgzZlk3QAlKoM6l3JnSzsxlqUWioKaatMyw?=
 =?us-ascii?Q?dGo9uUO/Zof07fPESXHAHHOCxqa42hpYXv1wgCB0FxDsOacIFOsE4x7Ecb0v?=
 =?us-ascii?Q?7pyyfivMVD0N50fpTuVHu98nlxbewjwDZqisvMEuxiKEpJ4Q7R+CMlYZNocm?=
 =?us-ascii?Q?TXeXuRAcY7VByg+VZEUI2xSS8weZuKRtGLG1dZbPRQugYzvJ7RBP3PVgTEjo?=
 =?us-ascii?Q?dHSdy9iCwC32QADuZ3WD9fZ69GClORHoMh6M1bCcweSyRKl7CQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3dKKeO6kKgvwaeRmWhZHm4HTCeKBGYhLWDnkMDpnbiJ2i64TJ8aksWDGrLyB?=
 =?us-ascii?Q?uXWikKeQgvQDoCBs44wp6JkE8pHzTgg5sb56XMjIeFq/Zp6by9Pg5NuZtyUn?=
 =?us-ascii?Q?2PMGrN54YCJ71J28/m1OUSn4ToVsLOxXvCy1kOe4I/6KSiW6AKGp5GuNwg0K?=
 =?us-ascii?Q?0+v5Qhixll2s+Jcnm+NUSbpXCVBc63C5jETKr1kikdnxZLuEHfXNAcHfPEIG?=
 =?us-ascii?Q?u4u3a6PJWqTUAifmVhWu+OfUZY8n4UyQZtIVDGZYXQkioSRm4jHWkfxfd2o4?=
 =?us-ascii?Q?/wTPeWhH6wWBsSJWCtXSTez1XfWVhBQ7ALFWbrVm5OHCl+eVtzfL7wsFpLM3?=
 =?us-ascii?Q?Hz3XYT88eBbOIqQQbSeFRhNO7Jao+/Kv1MDT1fAkCn0hyY6lJtYH3qGGIhZc?=
 =?us-ascii?Q?VWbfeTs4fSa4aQ1DRXMCrlLd7d/iHt7qePAL/VbgCwAvf+z3VNVUl0CswrAT?=
 =?us-ascii?Q?5cWFu7FAzbqPscw3pxRLLysll0ykaygWHhMe2uAU51w7Xehk2iREvGUGd7sz?=
 =?us-ascii?Q?OOX5LSOE487Lwf9DYAo/N6OUOlsY+Zd2d0TljOVRjOBwkQiFV4eOTD7egaIo?=
 =?us-ascii?Q?+YmCm3IL5lf5ElzzcJiC6DdZyqqR7iEVloIxy73W12oTBtEW1iUzFNIVdqga?=
 =?us-ascii?Q?odbgPfZxqLiAbFE/ID3ZOhRC2TFI0r8jWE3oba5Mmw50PNidMvH3BqdyZ8FF?=
 =?us-ascii?Q?NGeT7R29N+pSB+iSlE2TAtZnWNfGqJsxh1VhuKSHpgYaWbcHN/Qr1SaZP45l?=
 =?us-ascii?Q?qoxSfMxla2rO3tdqT4+N1+Qx7o3o3D+c6fjQYOz63HXsus+j7vRegiiJkqll?=
 =?us-ascii?Q?6hKmZrXRUWiw/r423gHDKj0mVQs/9QThK9v3a1kowrfaVq+kajVn31tw52BW?=
 =?us-ascii?Q?dpGjzfguPAgFcrSR88DQKLXJ8dD/uVLOn3TpzOmQk8aeQ7gs29QSXhXNzc7c?=
 =?us-ascii?Q?KqaUaW9pekS8Tz107rhLXQB8x8CaWgaWhboTll+0XW9gEtHFYBadXHSNaRb2?=
 =?us-ascii?Q?UTncbaKClieNv57NyBVGz0aUuOExZSWVuJIi2dRYWgPnrJZ/G5dcHUpNJXeG?=
 =?us-ascii?Q?04j100C4LBBGZlPOtBYH1J0LWrIvtRJfZc+IAnFRGMuZcbxsDa9eBG/wlrXp?=
 =?us-ascii?Q?cgSu0zqePdZ8ohY238xGsjVA7Gh4n4yz+f3HuaBCtLYOq+MyengxXMI7gt5h?=
 =?us-ascii?Q?b4D4K4NsYHR/md/40ymADoS5UME61Pg2FG1xOQR4VHxAKaLvfNcbz1FJZU7X?=
 =?us-ascii?Q?YB4yBovxZs+Ay3vEwPImaSVQQOg6dD8Z4myle38KV43GmVkDoRe75apKkuDv?=
 =?us-ascii?Q?8J0ThW1o58+jhvlE0B8B+CI9hF+jgbkqAaUU8BHqX4jx9md+Qqp7wBHmKdAG?=
 =?us-ascii?Q?ZR1xcODIftisCTylv42byvy5yEbns1ZNMxkPC22sHZp31Yh9fvhlmPDvDmuq?=
 =?us-ascii?Q?RkimmdDTIRYY/QOhPmln34ltaOSm+PtZjq8HRPulcAqK38o4GMSOkiOdHWH2?=
 =?us-ascii?Q?vaRIwEr0TvduZMpQGYhMOzAliwT3ecaoF6pKzbaTz03xnjaIbMO5J6ZWrKob?=
 =?us-ascii?Q?/fvyR3QfdIpwm2EYLt2hSHq2N5QUSIM9drJpEkFc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e8268a-3508-496b-2323-08dcb085dbb5
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:34.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkLw0buC2YfLJxLrEUijY10UBJPe4TbLRc5Bcj5n+JTjqcUcAMZvqcgSTSXzOD3nQPPnvCus7JRdaNddaAOYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

This adds a new state for transports created by the Broadcast
Sink device as a result of scanning a Broadcast Source. Such
transports will remain  in the 'idle' state until the user
selects them using 'transport.select', at which point they will
be moved to 'broadcasting'.
---
 profiles/audio/transport.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 922911cf3..0a890c0ac 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -51,6 +51,10 @@
 typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
+	/* Playing but not acquired, applicable only for transports
+	 * created by a broadcast sink
+	 */
+	TRANSPORT_STATE_BROADCASTING,
 	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
 	TRANSPORT_STATE_ACTIVE,		/* Acquired and playing */
 	TRANSPORT_STATE_SUSPENDING,     /* Release in progress */
@@ -59,6 +63,7 @@ typedef enum {
 static const char *str_state[] = {
 	"TRANSPORT_STATE_IDLE",
 	"TRANSPORT_STATE_PENDING",
+	"TRANSPORT_STATE_BROADCASTING",
 	"TRANSPORT_STATE_REQUESTING",
 	"TRANSPORT_STATE_ACTIVE",
 	"TRANSPORT_STATE_SUSPENDING",
@@ -139,6 +144,8 @@ static const char *state2str(transport_state_t state)
 		return "idle";
 	case TRANSPORT_STATE_PENDING:
 		return "pending";
+	case TRANSPORT_STATE_BROADCASTING:
+		return "broadcasting";
 	case TRANSPORT_STATE_ACTIVE:
 	case TRANSPORT_STATE_SUSPENDING:
 		return "active";
@@ -152,6 +159,7 @@ static gboolean state_in_use(transport_state_t state)
 	switch (state) {
 	case TRANSPORT_STATE_IDLE:
 	case TRANSPORT_STATE_PENDING:
+	case TRANSPORT_STATE_BROADCASTING:
 		return FALSE;
 	case TRANSPORT_STATE_REQUESTING:
 	case TRANSPORT_STATE_ACTIVE:
@@ -679,7 +687,8 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 	if (transport->state >= TRANSPORT_STATE_REQUESTING)
 		return btd_error_not_authorized(msg);
 
-	if (transport->state != TRANSPORT_STATE_PENDING)
+	if ((transport->state != TRANSPORT_STATE_PENDING) &&
+		(transport->state != TRANSPORT_STATE_BROADCASTING))
 		return btd_error_not_available(msg);
 
 	owner = media_owner_create(msg);
@@ -1281,7 +1290,8 @@ static void transport_update_playing(struct media_transport *transport,
 					str_state[transport->state], playing);
 
 	if (playing == FALSE) {
-		if (transport->state == TRANSPORT_STATE_PENDING)
+		if ((transport->state == TRANSPORT_STATE_PENDING) ||
+			(transport->state == TRANSPORT_STATE_BROADCASTING))
 			transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
 			/* Remove owner */
-- 
2.40.1

