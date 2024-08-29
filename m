Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED871B011D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935798; cv=fail; b=Yw1b8o0w2pIsKlIdvReIcLGPBn6Hg9OazVVsHlQu99yxRk/GZwPwb/aa3cK1XJ296o+hDTCAgRTAOzkeQz1bKeHsyiRxcBxDqf9jCR3Mp08RI5FPek6/2lMpTPKfdleP9e6HFdoZNusrYv4hb1cCq2fnQ3wMQUMnEj/tHdZuWk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935798; c=relaxed/simple;
	bh=QD6rJvLNp34+FiD+ldTLzVsAHSi6Ovh1GYVuN2gZQK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ghMxrQ75Wkv7UjnzPjJPHFU+Hfu0lpbjihjdwLtxPtP16/ojUaV6dKbxy5oc6uVTYsMvj6JvvMoIsJudMcnt6zmHadDNxkI9MrouvIJG6Nmi24u9m7ifGhJ5BjLuaQQyj1IZIGWJO0OuKtA2lsi9LUI8qbDn6YAQKGRgsbzPiBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nUg2gP2f; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nUg2gP2f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y67Pw3xTRDUrz2zGkhuBsx4+sIhcuwQXDJv01Q0vgYo7YVNHx4Di2igh53xFIjdJgvV+mca2arzqSJ7Z5ppbaCxbtiqn3o3ZqsJldaWgifj0MSYXO5CcaXzv7PVj+yHt3phnVr2bH112vsDVmcYZTpCA9L3PovAY1BNO5PvsVZnBE2tCviGQZefXXcTjagdq5/64HQy/Nlfc3G2+x+x3sWIlnzWol+eai7ldnAGa6X5sr5FzDK7p4IioePdolWzQEy/C3WouOza5miXRbQu7Cngz5SR40wsUjTjIXLwMB5F45j00hGWbLXo1KP5f1x6TEWhkjDFYDPuZX/6rV5D/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8xm51Zv3fTzx8IYIA8sWH8c6BtjiH/CweslYX+XuTg=;
 b=EG5K05kFz5b29sC2RQGVSbdZXhHNkQIaDWXK7sZVRhsw8k8LGky+8c5197E8czlA2sk+ryA1zP2SlAnYGt56U7A3ReMhJxRBPT193YbD5WWDwb2e1Zk628AO3mdMClgUpNViM5MiBIIKoktciBCQ14F9s39UDlUWEOlp07sj0SM/kJpapNH6nUcDxfrHydCdOgl+ojBGF3zdESOKitqWCLYe/w/HOsVPeA0bLm14LBanpPn5xLViW9n9GneouRhpPWmTE3LLMdXqy1GjgsWyiibyUPI0Bp8Sczdo2YieVsOyvtmUs71CPrPhiW0/IXx+QBcJhjDNmHYzfsvoIOHozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8xm51Zv3fTzx8IYIA8sWH8c6BtjiH/CweslYX+XuTg=;
 b=nUg2gP2fmiN3l7Hx8ZxY7iXRQOr1OH817IekJPb/zckahnbXlitJcZCSSNDiUgZ+NacrVRiG4Ltf6AM1RTlyCVnUEsgubDXWcXgPyTwN/UXsO8A8lahuaLvU8d8hLM/fdovyPMxWZ1mF4eDuQ6xVXNX1vgBoDJEofTwy8xCHhcPgN7Y47L2SBbtJqPYkIoK2H5qoLSri/99Va7OJaIFkpEe9BTSC2xfZB8oE6CaVM9Tzz3l+7OiNaHGopIyyjvcCZ+Uqk2hGxvFgwBkVEwS+XfoNc6+d6SSr54SY4i3cKhT1sstg9XtLuZFPU1TroWKrkpbt0OksLDtgZ/J2BVK82Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:49:53 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:53 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 10/16] bass: Add APIs to probe/remove Broadcasters
Date: Thu, 29 Aug 2024 15:49:12 +0300
Message-Id: <20240829124918.84809-11-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c1fbbb-30a7-4edf-3ad3-08dcc8291414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KglrqCcNKjeP0+R685i6/NhOO6Hi85OT0+D+rbTJHqgCDJIdBexQ6/6C2cQx?=
 =?us-ascii?Q?Yj3lOJgGkYewabIPoCN22zC46mudS3CjeQ4FRN6dAUxScAlQnz6jUCj2CTnW?=
 =?us-ascii?Q?tFKGlMWKm4H8fWxREYCu78GhHYDA/ybqiUBSXKh+HHs2vgs7XuYbklhJQc3A?=
 =?us-ascii?Q?WapmHWRUxfJopqcWOk2LvW6OkD2ScjcK6nHXLF94wjmJwh1EvBze0+mHColk?=
 =?us-ascii?Q?7RsAzoi03PR7o41X1lt8vMZlFQgFd8ZkSCbbLKWJ7d8IsGfy4V1q6YxymRrG?=
 =?us-ascii?Q?gt2V9nfoPYHff4yGmEXMINsZOV2QVcftK7eVd+sny67KFLQxHTlDxdTVAOo1?=
 =?us-ascii?Q?QHEMGmIYhHY9Q4OifEcA5J+KAoM2fKmzlZtdfNv9SjqRnqiFe5w0SigL2xY6?=
 =?us-ascii?Q?8n4C3hZgYEN12//SGPCRu7T8dwcSCFm/IcFO6+pViF2U3R3Ce7q2igp27Pc6?=
 =?us-ascii?Q?vOCEI/NB2TVEa5M4WAXhLvqK1vmYU9o1tvq6wv/TV1m9LBn5yGmRHoCwIB08?=
 =?us-ascii?Q?FwqVak6Ijyi6P4KQa5QSuNT58gU8q+A4S4iP5LCM9h0MWJMWJ1dP5kE4Yuzf?=
 =?us-ascii?Q?kHTmrCWjWpsRJYuFX/mLylu3M56yeRFoEjqnWb7Hw/GXP9+Cn/OeasoOugPK?=
 =?us-ascii?Q?5MxQO0FCElaqC6IwaBhKiO+2/ypLM38RJYY6sBye6Y3Hug3pJ2oJYqAsPRkc?=
 =?us-ascii?Q?sWvhBpdrGnxiXvwQOjcR+bRo2LErFSF3aXIquKwucw/XI1CBPgxhlOmt2mZt?=
 =?us-ascii?Q?feyKC0KRJvj29ClpcwgQQ0/efGgaW043A0/UqZGCkC3RuX2Rco43+7/A3Qkg?=
 =?us-ascii?Q?C1TwYNqncg8l+lgWSNpLareSR93gIAkNTecRgTIz1gp3qXPCuGyi81PBzQLR?=
 =?us-ascii?Q?PDZkm5ThLDK7/TTuwOJYDVkStzV3vRhnXDmi3KkFCgCK7JRfGmNr/4/tYp8D?=
 =?us-ascii?Q?6KX2gtmvL7F/C6mQBp5ColERGu7o0/WXVfiunPbUhysJEZBVU/t/qC8FI3Zj?=
 =?us-ascii?Q?vqfCJOKYKNcerMbjI6IrdlmiYqY5BfOfXSN1GAqnahyNWZM4GePejx9mrvFz?=
 =?us-ascii?Q?afRH7c5v84O//+gdAJS5JP2KvyfQS6+67gH9hOLF+F/q9TO9WWDnLzwPEUP8?=
 =?us-ascii?Q?uhmbkxwptLEdr1nS7MH4wrXc2xOK+O+XsfNWNURo3XbZj2dM9Sn72g3WgiwD?=
 =?us-ascii?Q?NxKyaxu76Qhea/XDwYUif8ReCIk4TY7E6mvfdbgZFk7u9T2+MJnWlMhEzpUF?=
 =?us-ascii?Q?lKW9+ZXnp5V8qczjFzEMeIIq8tDczH0or++qG5aNjTL3qtsZ2Ah9vSebyYYp?=
 =?us-ascii?Q?7qVPekov84N8ADieM9WTrUviOwADX00nBW3IUNZ52XwZtQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UOo0Tfy0bcsbiiodfcqX5esODo4b9MJZoZggwzWMPsWHDKhvvnadjMWG4p34?=
 =?us-ascii?Q?GmU0b5YyW2WlaWivlB1zpLTCxRZHim4OE9ioMq/+cFQwPTzV7EMjlFGkLtP7?=
 =?us-ascii?Q?AtDaRfE0a3ivRCVkMc0qFIwUPfwuCSOvxUzJqB/3M+sCoWDqpqhJ4vvNgNGT?=
 =?us-ascii?Q?pM2bcZUtca+aLgNZuueuubXysLBqQ4prLAvv0Xqr/XEJDrqkxRa1Tu+NgGUF?=
 =?us-ascii?Q?fTqkupNJSMi3gn+mX/5Bwm2kOTbarz3Jdut6bnTRamDXmVrqkTL4kFjZW2VG?=
 =?us-ascii?Q?y0WsLPID4BjOadjD+bf/iuT54yhhuLw12Ka3T9nc9R51+FnI53mbFgnNzFOF?=
 =?us-ascii?Q?cqmG3+DGAw29cBwU3u8Wr+o+gYJoGbBkagUxxKwQcdZkirU281TvBjuo18mw?=
 =?us-ascii?Q?6sOao8eNYD5KTod15uqsz8z/PVM02gA0hjQRB3aZoBKt90vEH7pUVbLkwj49?=
 =?us-ascii?Q?Ll1rITmSGEeXHjjuCFgPU4NUKVmEoPoxLcvouSpcor0Sk1Rqvfd30OfzZs8F?=
 =?us-ascii?Q?JZppdjIapE4eSJd3Rr22AR2gokYD9msWGRVsliD1wVvM+ARqcMxMVJm7cOSY?=
 =?us-ascii?Q?hwZcuVnph2z0jWTrgSHXiN4KnpOnYHPLK2Zb441Rde6YDmCIINFAb2HNGCKj?=
 =?us-ascii?Q?gEX/rj5D9R37F0efyYAzSh9ft8jrxnmdtJZ+AZ0Y+yW3EH/skBDh15AO594m?=
 =?us-ascii?Q?VLcvePIly1dkbnMwrOjg4sCZgwYoSmibmfgK75oGXyeGyuGRxyjFalnb2hRB?=
 =?us-ascii?Q?6YiX2frvnCt0JabWzfHSuN55dBzWdeDZD8e1Ials25etlNhlfiSzwanUWLOO?=
 =?us-ascii?Q?AAz/x+4yO7xjIEUEEETn9WbOcajFbi1dvNRpellcsCnLtpqRVKFZh989ih5f?=
 =?us-ascii?Q?/6fqVIMW3p0CGVjqeezxsVMkmaurpsDitjbajmN6MzbhFuviSnFGNRDLiS4h?=
 =?us-ascii?Q?5CiAiZxD0GpEMX/w/wHXs2BNdNbmAVsg1fKW8ZUYgKA54cXiE9VVzryzPhRI?=
 =?us-ascii?Q?ZDAwSQ7dbggPHN5VNeFE8NkTRfiS0JUBj/DGwEThVFfk4FmrOMw7yV2y8WoR?=
 =?us-ascii?Q?/Y2R/ZaljqLD8Ig3rnkGZMWuVEkOWctFBSmbsZ+Ae/COzaK0d6ArX0ezzG/J?=
 =?us-ascii?Q?7IasYF33cVHYuEd2pv0oPs/SCL7Fu4MU2rtTkMbiRfaqsmDnIEadVB/MwZuE?=
 =?us-ascii?Q?RFUoYlxqp9cvldEItqgHRMq86+XOqY0wjspWRoNaz3RkZPgV3EVJ4gdnJNbH?=
 =?us-ascii?Q?GQPJIl0DI1frGJgB4flQRwMo0sTt7jyEU14OqrshcNVhTeoL10o7SFFo8fmv?=
 =?us-ascii?Q?CjAElRjZ+itOiYhAMaoxn2ZyaHdT9icIxknAzN/Z5H0QtANX++GTnwN5Fjoc?=
 =?us-ascii?Q?qL22NpHw/lIlYZsrngJiImbTODM/mV5/V7YHQ6G1wjk0D/fM9q3lMMmpwcd2?=
 =?us-ascii?Q?F9Ung88JMSp9EQJf/AFNiZ7xRN7ExfGHfENDVng4GS/+pmaObdpQ9Cuv9Ceq?=
 =?us-ascii?Q?Sq75AskbvEODYkX0NbNvFfP7HnNjzFIrsDh+Dc8gvYQ56lHCIp//vJptUycB?=
 =?us-ascii?Q?fnWTRWFAPas6b+QLXfok4D3YGJGyvcselq/dTvBXBAQB0HCBK6/3Umv46fgq?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c1fbbb-30a7-4edf-3ad3-08dcc8291414
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:53.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5WfB3cOKXjySa+ERcUFjWwwZPviIYcF+Vz7xf8AVc/X6PMygXirS41LLYDc5r96XEEFsvyVSqoXQ1SwwsldeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939

This adds BASS APIs to probe/remove Broadcasters probed by BAP.

The BAP plugin might probe Broadcasters that were either scanned
autonomously, or that were added by a Broadcast Assistant through
BASS.

After performing long-lived PA sync with a Broadcaster added by a
Broadcast Assistant, the BAP plugin will call the BASS probe API,
to inform BASS that PA has been established with the Broadcast Source
and to provide a reference to the created bt_bap session. Once a
Broadcaster has been probed, BASS will update the PA sync state inside
the corresponding Broadcast Receive State characteristic and
the peer Broadcast Assistant will be notified about the update.

Once the BAP session with a Broadcaster is deleted, the BASS remove
API will be called, to inform BASS that the Source is no longer active.
The BASS plugin will update the PA sync field of the corresponding
Broadcast Receive State characteristic and it will notify the peer
Broadcast Assistant that PA sync is no longer established with the
Source.
---
 profiles/audio/bass.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/bass.h |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index ee378e141..933eecabd 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -102,6 +102,7 @@ struct bass_assistant {
 struct bass_delegator {
 	struct btd_device *device;	/* Broadcast source device */
 	struct bt_bcast_src *src;
+	struct bt_bap *bap;
 };
 
 static struct queue *sessions;
@@ -115,6 +116,56 @@ static void bass_debug(const char *str, void *user_data)
 	DBG_IDX(0xffff, "%s", str);
 }
 
+static bool delegator_match_device(const void *data, const void *match_data)
+{
+	const struct bass_delegator *dg = data;
+	const struct btd_device *device = match_data;
+
+	return dg->device == device;
+}
+
+bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
+{
+	struct bass_delegator *dg;
+
+	dg = queue_find(delegators, delegator_match_device, device);
+	if (!dg)
+		return false;
+
+	DBG("%p", dg);
+
+	dg->bap = bap;
+
+	/* Update Broadcast Receive State characteristic value and notify
+	 * peers.
+	 */
+	if (bt_bass_set_pa_sync(dg->src, BT_BASS_SYNCHRONIZED_TO_PA))
+		DBG("Failed to update Broadcast Receive State characteristic");
+
+	return true;
+}
+
+bool bass_bcast_remove(struct btd_device *device)
+{
+	struct bass_delegator *dg;
+
+	dg = queue_remove_if(delegators, delegator_match_device, device);
+	if (!dg)
+		return false;
+
+	DBG("%p", dg);
+
+	/* Update Broadcast Receive State characteristic value and notify
+	 * peers.
+	 */
+	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
+		DBG("Failed to update Broadcast Receive State characteristic");
+
+	free(dg);
+
+	return true;
+}
+
 static void assistant_set_state(struct bass_assistant *assistant,
 					enum assistant_state state)
 {
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 5bef92946..7e20385e5 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -11,3 +11,6 @@ void bass_add_stream(struct btd_device *device, struct iovec *meta,
 			struct iovec *caps, struct bt_iso_qos *qos,
 			uint8_t sgrp, uint8_t bis);
 void bass_remove_stream(struct btd_device *device);
+
+bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap);
+bool bass_bcast_remove(struct btd_device *device);
-- 
2.39.2

