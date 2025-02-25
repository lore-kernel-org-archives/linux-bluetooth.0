Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CDD260A51
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473076; cv=fail; b=o+vv53vzAGRZTi5w7MM9RVi5Si53AyUbkb8w0DOAmOp9az1DGODcyTQOQr8/YReoIbTDLafbHusWXnClvFzMgbh16pg2+qMRxZSQWzeNaVIYmL9hMsIZlbaoaXfsBu4xdlJnLC+ONrY76wQJJ23aK2tTHnf/rUJ4ua0iX2DD3o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473076; c=relaxed/simple;
	bh=6Q9blRxzuQRFXjbVRxdCmJFh/F2xutGGU40wxV29BH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqHQ12YFejqGD7+7rpAuOHsYbPYRYhY8slVRzyUPPtNg6uIM9WJoZn8vXTeIdgsqyOqYLbwJP03eMq6wr25+Rhzb4xf9UAOWfNxdLnZzxwW4b34LpCJG+Me+M3AV1Mft64xvM2QX2tjZVknkyVAYsdNIByoHNFe3kg7dY6ZdcwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iAEviy6k; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iAEviy6k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVlsSo3afHNvT+f8PPDcZ3SHudq7Nn9sx5dV6eYvCvlqMDSKV9g9TukbyVXmlKZk+03MbWMTz2YXmTPB4Cz6SHJ5RdCJZR+AscbL1khXp1ZX0zNTBLe9lXndJZB57EvSw4zaTIOei9AXc7hxx07Dq+zVzj/s4K5MwtGl82cNb1w4HM/hjHA7j5J/QqAKazZzr8BlMbkKMLGEiB6+XeDZ0i4FRr6DPOko/0pkmuKC9TEOlDUhn65zWw6TnhPxK/CuHAR+vAoGGNXIouqaE21+1KAzDTHucv0bV9mXnu+pQeM8cinXxPOpFloCHiEOBqAcUnHI7rPtU7/95IXfUbRLzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ0AVM8JKUpqNCYOX5iNTUY+EgTXp85NrrBoIVJ97z4=;
 b=fuw/lGezrnM7oD4rBTEfulctbHEPh4n8pddH2VmhteAjFZbTO4aqselgJ3+AKDhG2ixH/UngpWOxalatORjBKWJ9DvDUULZdOdN+XO14OqNEIppG5whRErXnUc+gvoVzMn8v5kOgXwXhmNRJLHxQBiOkUcpwhcjczr1obZQUoyUTFkN4UWDwTzOk0lvloVbSp74DC7U92AAOaeLk/KHEhGwtsEqiLy1dpl6bj1JcEGYIsEipfb7uDqnGqkCRPGmCDsib2R6fXAOxhuhyC6dCsn9IDwcX/aq6LQDFynvmbXYmoQwQE9/x8xLbmmzhs92jwm/h/4YqCJIwiH+Sggq/1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ0AVM8JKUpqNCYOX5iNTUY+EgTXp85NrrBoIVJ97z4=;
 b=iAEviy6kmXdDJkv01NbSTf07NlXJlMWX9DZPp9dpVwYmdz1bsJ9av8h2Kp1BIdeU9NXAKMRTyxVs3n862McW6NcmLVEpnkFZ43tazOJJFyPOOT3geOsxT0U5r7KhUhaUyE5kue8fdnjDRvJYgQOOwx8aFmpUYIk9bOHwmrsbh+cWKJfjDBOEvV4g4WV9If8IwWI7hOL3/0aSot1CwgaW7Y0yohudDbjHcI8C3T3PbYQfxvYHe0HA841+hiw5/LTHLXKlg6ROpEjb0d6t0Qlx9R+8vlD87COPTu7S5TvYA+wYpOnlXTHdb90OHe/taVDFWwmeNXFEjT9HIwoGriaNCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9570.eurprd04.prod.outlook.com (2603:10a6:102:24d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 08:44:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 08:44:31 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] bass: Create BASS session with Broadcasters
Date: Tue, 25 Feb 2025 10:44:13 +0200
Message-ID: <20250225084414.28677-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225084414.28677-1-iulia.tanasescu@nxp.com>
References: <20250225084414.28677-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: d3200dc2-1844-4e7a-f0dd-08dd55789f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p5BTY6let+nC7s2f8gavcnin8aqtf6iHXElyyXcY8oIWPgU/A/pp7XZao8Ze?=
 =?us-ascii?Q?rNzvcCGeOgn8qDcIq4StxoSnmLpteOHcXVj8VJPlnR6zdtq62yOjYgVNcKkk?=
 =?us-ascii?Q?e8RFO2CKzL9eHTBmlSt6YP4jtEpA1dcCNUoyntgQg6pg7P6ZViX6lrhR3s1T?=
 =?us-ascii?Q?qyEmSd0LQiMaYOAd8SFK+FIpZTWw2z9/fzs0jltpqJ4QCcnp+L3hsLYrf+kI?=
 =?us-ascii?Q?ctSAQwtNQx4yKb+AT6kFoRXgaiI6Qd7ufNB7qprBatZpgVPlXj6+I78Mgrnp?=
 =?us-ascii?Q?WisR2mjvBXLAdYlgKpf/cJq/l8JI5yenKJDUmGWTgd2HcAVh7pysimMJ5MO9?=
 =?us-ascii?Q?cCwuTDs0/f21SX09j+1c4qpbSSFg0tyeTf1PJOF+XQs9RBkHFu7Q3fyJFKJT?=
 =?us-ascii?Q?vv9c+mEV4V/g+6MU7nVUHY1UYK3iWkw3yNXX9iP7VNNqp8IRHluecDai5drB?=
 =?us-ascii?Q?oRZT23azHe3+u5aaBnC9MVWXwQ0+PZ2hyfj6T0hDkTqPh3a+3s9ZlMZT+sC8?=
 =?us-ascii?Q?JoxsY9BqNc3yGOIR8NUUjl4aEb4U/jTDiYGhmLA+PBrJIp5G3Dwe+fHzg6hM?=
 =?us-ascii?Q?+qQ48uV3gQKac0IckVR5ap9zfAHnRhpYCN9uC2aRpgEAm6xiv14eSR8tPsBE?=
 =?us-ascii?Q?DoEhKzbgSDSJw/LB66kliIh3jCo//x0zRBtAfDT9PSRkNHhP21z8YnMF5j9r?=
 =?us-ascii?Q?vk3F47Gmf4Lus6szQsUHQL5UgKFqS1Tv62CyA/jS9kYXvNwojXZShidzqwlw?=
 =?us-ascii?Q?YAX02rjLSfpNXJ0R+hNH7VheAvGJpRF+Hh7MCpql2VXb2hsFvsple/MiBZvj?=
 =?us-ascii?Q?WdqF/2Yxd+LUPGJQQGS9o7KJzZf9FKRo94o9bS3wLkx2zAl5USzVJfw9DGX6?=
 =?us-ascii?Q?pzq4cnOg6RpNzgVHPL6f3G04rs3FA7/p9UY+G83Gfsgo/0QPzjYX2MinmRCm?=
 =?us-ascii?Q?uSFo1D3GzI/f6EshlAsiAuGcefR/uGetDSSJkKKLl1v/0orKyqZRQB99QgZ0?=
 =?us-ascii?Q?1iN+ElxgVx6tphQjZ80Kl7yLcZarflvaW67Lo5U9YjMIyOlTr8wBnDEgTE7A?=
 =?us-ascii?Q?kAElWp6k/G0cJ+p8Rqb76MEzCHACSqFBrHI5jPRpsYy42Ft2i2uh7bF34D/h?=
 =?us-ascii?Q?Wt+zw6s7H/u9lnFt1NPe5gF23RV/dkjgds3XCTLIMIx0dfmQ8JVP3/OnfPPc?=
 =?us-ascii?Q?ufHxhk9jgr1D8RGEZx5X1mQr6yWuLnH3B4BOHCFYp6zICc4VTFFqWYqKOvud?=
 =?us-ascii?Q?4uxngt0uYBOOr1Ftn6hTlE5Sj6eOPpUVdHL/E1VCggPAWmRhxaMdp9PzTlFV?=
 =?us-ascii?Q?i4p6XShaUnytWVhjBS5XM3FlaxV7YAJbw9ZtH5OD8dr6bRRMaG/X4P6MAGlr?=
 =?us-ascii?Q?swYEaOP68PCRuHOldFH1vZhMrhd8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ihuYRepolIWnHCF9dqCHKNEYkuVd0EmfeRR+igSEfV3ASAivKBloM8IUg68N?=
 =?us-ascii?Q?2BCGj1a/vQ0paaSpsRo3kEbzLTr2wgpFFLV5bN+V2xUe4B5hik2EMS5MP9sI?=
 =?us-ascii?Q?8LVPbhHFqmYW/yp1KmCgMEFDtd6Cad6TyvAstt6+P+o/njy0la9EnlTk8tYz?=
 =?us-ascii?Q?HTyaALd8BX5Obu73Lv/sOEE3m7A8hmKK2+p9esK3GzCw8ns09BbksOG0Ck0K?=
 =?us-ascii?Q?MvotDqzXKd/gfVaC0o/UyMMR0waWjJrnSB0guky5bk5PfoHf9jpEfTRMocxT?=
 =?us-ascii?Q?3ZuSowMLUHu2POlmh4t+SylT6dcxnjwIRIZ0QMucI91+/af+dDVuhpsR61o1?=
 =?us-ascii?Q?pZVK6ZLk0qEz57huhcA7qXdTzjWXTlHoIR/SmmJMRDLyPDrIXCAa5jEIUE9U?=
 =?us-ascii?Q?zO0pYGnwIT/+8Bk0vFsoS1XqhzDm2ahZvqoaa+4Sl5mdG5Ys9lP0GC5/MG8k?=
 =?us-ascii?Q?ZWKoTi6p1xKPxhmZbtnTHQVLF+DrFRIKzW0BvxURiK+mOpfURzE4Ks8DU5Z3?=
 =?us-ascii?Q?810RGrCm3drPZPvN4dNZMNjNqOYDjfLzFCwxTM8Phj6mTiF4UDpf0ZdzEIiM?=
 =?us-ascii?Q?SKXbaxBWs7oMLuQQGq+sOflgG6RP2rCPPU3c0u0us9e2kTHxxezPz14dTOK6?=
 =?us-ascii?Q?RaysU/n/Oqq6m2WN7R7lmUgMP2VaDOPHpA7XjRwjQlDgatoSrRGiq6SRHfk0?=
 =?us-ascii?Q?jfCTol+XG0+Hn7hBHPWx7ux/X1fwIBRgJHk16ctO/JheTImtR4DGfyypSgw8?=
 =?us-ascii?Q?tNAnyYckVFw8Tb6hBEzCpcvQmQChdxBVhH9WTNiC8pccY6LFN5k17iVcFcNg?=
 =?us-ascii?Q?JUWFBhH2Po7CR8JAfH+O8mizctNVp16MoD/BHAr+t+SU9RicLpCdmXWgVA5o?=
 =?us-ascii?Q?zSOWLopflrlI7jaueEBySSE5CNlM4AA0TO2FBhTxQtbdzlhSU5q65REYidVz?=
 =?us-ascii?Q?dYBrIj7DfJ9Lq2Z5n8WZ+Qf6E1lk48zpblJLF4zQSmegvNSCw3Rzgy8TqL3a?=
 =?us-ascii?Q?MPCDVz6Hd6uJyijCGOuVUZC3rKvoVfFvh5eSon/9XZNItWX53FfkJMbUJ+2k?=
 =?us-ascii?Q?soQ7+d+wQhe5RSAbOGoKrlOz+PfETf8LpW+w0bLYUv3ZNJAuYQCAdXmYKvoV?=
 =?us-ascii?Q?IlwX3zCNFWH/W7IIAiC2NRuf7Z1yUTZaTFwnAkDYc+E2p8giY0TzeD+WXAvt?=
 =?us-ascii?Q?e1uK7QVp/3s+EzbWMKHRU2Bjjc+JpGB4/MJGO4HDfF778ynn7omkZ8kKbbD7?=
 =?us-ascii?Q?G/+BcCQZ+N4VFNtTSbVIYXxPSrERXmpjsG5ts67yu1lDwhm9zwKX5xniAMuG?=
 =?us-ascii?Q?K/ZQiSy8VODZJ/LpvBURPWLXZ/YLtL2ca/PBpD76tSHTIz8Zwm9WQC1NM516?=
 =?us-ascii?Q?GINIqsdT+MJmhmFgZS4rv3yijpmkNd3uPMrwKHT/eIGa9tK1rZMfLKSu/fTh?=
 =?us-ascii?Q?o09HDaUdN6oePbbQRSToNWOB21mI2ySmmNog8SYyjgz/7QKRsslvK1eP5lOj?=
 =?us-ascii?Q?5YnCEEThwWWx5+HEn1TLy4HuTOyb4lK2vy+ve1F9+bFg915o9Z+UKBKnTvq2?=
 =?us-ascii?Q?nkjiVkd4iNuluUjcthan2rmg4RCy7BHEW1R07sCiX51hJhax9C0x6Lz2Y/Vk?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3200dc2-1844-4e7a-f0dd-08dd55789f3b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:44:31.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nafsD83zn0jGcTUCc+WFp48Onz2n6UijrmkyDpEViRF1lL2JYQwFx/ZZtpTNaLkkpEXYWjnYQ8Jbq5ZsNQm8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9570

In the BASS plugin, BAP sessions created with scanned Broadcasters are
notified in the bap attached callback. This creates BASS data for these
devices as well, to internally keep information about the sessions.
---
 profiles/audio/bass.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 67ee847b8..96e767744 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -137,6 +137,10 @@ static struct queue *delegators;
 
 static const char *state2str(enum assistant_state state);
 
+static struct bass_data *bass_data_new(struct btd_device *device);
+static void bass_data_add(struct bass_data *data);
+static void bass_data_remove(struct bass_data *data);
+
 static void bass_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
@@ -560,9 +564,11 @@ static void confirm_cb(GIOChannel *io, void *user_data)
 static void bap_attached(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service;
+	struct btd_profile *p;
 	struct btd_device *device;
 	struct btd_adapter *adapter;
 	struct bass_delegator *dg;
+	struct bass_data *data;
 	GError *err = NULL;
 
 	DBG("%p", bap);
@@ -571,9 +577,22 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 	if (!service)
 		return;
 
+	p = btd_service_get_profile(service);
+	if (!p)
+		return;
+
+	/* Only handle sessions with Broadcast Sources */
+	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
+		return;
+
 	device = btd_service_get_device(service);
 	adapter = device_get_adapter(device);
 
+	/* Create BASS session with the Broadcast Source */
+	data = bass_data_new(device);
+
+	bass_data_add(data);
+
 	dg = queue_find(delegators, delegator_match_device, device);
 	if (!dg)
 		/* Only probe devices added via Broadcast Assistants */
@@ -625,11 +644,21 @@ static void setup_free(void *data)
 	bt_bass_clear_bis_sync(setup->dg->src, setup->bis);
 }
 
+static bool match_device(const void *data, const void *match_data)
+{
+	const struct bass_data *bdata = data;
+	const struct btd_device *device = match_data;
+
+	return bdata->device == device;
+}
+
 static void bap_detached(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service;
+	struct btd_profile *p;
 	struct btd_device *device;
 	struct bass_delegator *dg;
+	struct bass_data *data;
 
 	DBG("%p", bap);
 
@@ -637,8 +666,21 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	if (!service)
 		return;
 
+	p = btd_service_get_profile(service);
+	if (!p)
+		return;
+
+	/* Only handle sessions with Broadcast Sources */
+	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
+		return;
+
 	device = btd_service_get_device(service);
 
+	/* Remove BASS session with the Broadcast Source device */
+	data = queue_find(sessions, match_device, device);
+	if (data)
+		bass_data_remove(data);
+
 	dg = queue_remove_if(delegators, delegator_match_device, device);
 	if (!dg)
 		return;
-- 
2.43.0

