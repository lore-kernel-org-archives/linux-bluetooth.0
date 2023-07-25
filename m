Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93BDC001DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jul 2023 13:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjGYNsU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjGYNsM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jul 2023 09:48:12 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E58DE0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jul 2023 06:48:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJiaKDfG6JVGVY6fn4/VfcSoKXtKfOrcyC/wG1UWYeXHYNaEzQ7cWC2kyH8nL1OjNnTP8PJkMkV2SHdPcb9Ni5lWqKWQQygqqmks9nXucM+CMncj9J2v+xEbuP2l3AGgFBrnqvNMpfQMGPSFBZrYl8ytPgPk3oWDEpbLmeEI7da56R6VKwduNmHCTtgMKECWqOtQ0dr4vlnnetiVPMEWNOyYnll4natFnDOCioIRikCgGMUdVchj58abjWDFOZT1HPA/MOBZoDeOA0uOJTmLQAMppVLrdJJ9B8q8HfmBj828eiwP+LP31TvvKHr78zGkC9Rc4uYEXeM/LoNGt+R/zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5uPLcb3lBZSZoQkNE1JLZCYriiHEbzyU2LLLOzjBOY=;
 b=gbQ60vTUD9rnEBwhWOhphr0J5248h53/DRY83rVPcPQWY4KKJ30D3atHPs3IF4XnNZIWePQWPMZJq/OtHwBJblfjinI3ugWvBGHm21nbwYfLEtJe5Wcr3JFd9MYctFqrxhSIXmvmX7++E7eKDqXnmVmCv3VUOjm+VHE7VywDf0ZBjxDKGtA2thMy/lKGiYw1kLGkekpCUh9D8MLq5IipbTnIw3PCgKCA1/LJxGD1qt0wPFlZKGQ5mr2V9rG1NBeK2twwF9bAvG1ZJaovn0QHcguLHPOi4TfsP5tONJqmCb1HowdReW5wyVODZYo0Og9pcXMJzwaLSXEqcUfaoac+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5uPLcb3lBZSZoQkNE1JLZCYriiHEbzyU2LLLOzjBOY=;
 b=CrDxtKEJ5SyMs8a6aLqOxM9YbN3aS3J7UsYaMOk/CLpcZcibJ3nYQO3O0VP29eGaQ65g/VVaMUnr5DDFDdmDsew0A/QN55e39R3le0zr6/2F7s8Yq/MBfsvytQEBe57T3UBSVpoq3Rz9voVen5xX5/nkhT7LtqIcDqlu3R29Afo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 13:48:08 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 13:48:08 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v4 2/3] shared/vcp: Fix issues of audio location and descriptor
Date:   Tue, 25 Jul 2023 16:47:41 +0300
Message-Id: <20230725134742.51651-3-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230725134742.51651-1-nitin.jadhav@nxp.com>
References: <20230725134742.51651-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0037.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::8) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: e28c3f0a-9f80-4b84-db35-08db8d15c7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /faB8oXdVDg/tFwn/N92ukWpPBdOcXhABtT1eULObB8RBlnsOkoR1JIno4yzf6G8FA5oRel2aea5n/ZOaNnoaCnD06XKoQtO8dSP8cFs4J5LKEfgMeZMpELB6FPw5GO/2ZD7HsFXWCaUfyllLhnnLKMeter/PCOFkGqMygf/n5Ydy+7wFY8/ILI6nl2vGxbj/f8kZz+593Rrw+Jmtr62CDgVhUl3bqI/qvqFBbJf/1fR9tZBsbXCEnYAdAhYThdMUz2xfwYsEAd60tevuE27hwyMh4Xxo1DnRLz5HawtfkrdAd9sS8Vgn5iUiMhXGibKGDRdzG2ggRc173AAAUSEKaQCbwagEjUepd+WdYxfJY6h29qIy/uzII5IxRKgyoaZEH4RETjn6ccvfXb/8qoxwL4kn6L58kLC/vdtHClkvAaOdRGu1UGYkrzkS6nSYkO7cY1kPFZfB0hp9wfh2ynVLxUd8N4GKcPsa+A7XiEI5tQP1AAKtZ03L5sbVWMF0/eTesOdfa1gSc0azZmbuYTP0gfN++xTO91MDGIeRqF+C/NOmVlD+/Ce/4SQ8Y8yq/IA3xeq8Zr9iNRosaydwvY5PxeE3vQ8nKEvzgk7t44sFdAskwc7IL6BTgELna9HcvQt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(36756003)(86362001)(2906002)(52116002)(478600001)(38100700002)(38350700002)(186003)(1076003)(26005)(2616005)(6506007)(55236004)(5660300002)(8676002)(41300700001)(6666004)(6512007)(44832011)(66946007)(6486002)(66476007)(4326008)(83380400001)(316002)(66556008)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VW0avO5IPglbChi8KxnZKAmK5cH4cMupA483fqdWW2pXHYxIlsJFchQ1d7Nd?=
 =?us-ascii?Q?iha2ped0sllX7N/M/Ar/i68DcPy7XaZorP5L1xXl347d2R0u1XRKSxWEl+qj?=
 =?us-ascii?Q?Qt0SvDOoacqp/rdBcxpMwpFa8Ei/jsTev1J5duwQ+8izj4SxyQp6dsTJVLqI?=
 =?us-ascii?Q?zYoJtQcq8oUpl18snsDNDh02F2uW8BHin/BZrjqr62XxbXP3pjZiqC/jlwjo?=
 =?us-ascii?Q?qQLnDpqiN51PPTwhQW6kptJOdQ8uw6TKEQULpMmncaD1bNUw+1peJPFHkMPh?=
 =?us-ascii?Q?sOechY/X3FvNHhVVqX/I6Q38SZ3LnGO7AmhFa8jUiQ+4EdvDaY40eejbket4?=
 =?us-ascii?Q?+QhZwLltDmqU5NkWC5LQMQ2I6PfvpBCNK3EfvZhXv/G8iA0r9l2j20sZJe10?=
 =?us-ascii?Q?9rqODf69E3UvmdtZDmxJXxecOEuvSy8f5cuvCL3thWRsZGUInjmzVUDIFJ5Z?=
 =?us-ascii?Q?IQ96g4rqKkbzSaRG79DXAEvFzhlhmEzehk/eaS7GAKYxL+iYMAK415yz8Dj/?=
 =?us-ascii?Q?f4Pz7GXwQkZql7QcUpdeujOUZR09Y8RhH77BdN7MMrUmUYJtHK13hEsAKYv1?=
 =?us-ascii?Q?y4mLWIxZQSn/cQ4+Lf6jn0GeuDPorcIbQlP+r292uQatJxxZR+4/7I7YA45s?=
 =?us-ascii?Q?jM3qggGo5n2vhSak7os8TA0SYZNPUfsBvSrVT1kcEysoUbTHTGs45NslY41D?=
 =?us-ascii?Q?AE/TR+Rm05cMB0BlKZjLODY165suplgrnS76CXRVMk2yi6yF2ZPbAQxfjgeS?=
 =?us-ascii?Q?Wh5KQIhjxUR+LYlmL5zIgKGbMqkT8PaPtJP0JjKki+RUIWciAKD7T61DrAqU?=
 =?us-ascii?Q?Cawec4YsMEEYM1JsOWnTadpmOpotm+ejXJ2MZptYhWh8vTocYgz3mB/6EdeQ?=
 =?us-ascii?Q?3KzXV4wvZ5bimehX9QuT7yafRqtWLFuJoz5JPXlB/E3jNZ3XAVtBa/hlUI+O?=
 =?us-ascii?Q?cd7TEuGyrfObI9lBIkpKNTv3LZsJRlyPFLTiZIpApDFUPRfixy7orEObAzHV?=
 =?us-ascii?Q?gUmgw0UeE6RS/MrS/vayn415niBZWTEX1n95fMTsoKcqo5OkDkmX0B8aYV+C?=
 =?us-ascii?Q?UOu9SFdd64RSehhukBnC8n30IuqW/6p2tPcaHjIuGF6yVTiXopDRikJZ6+Sc?=
 =?us-ascii?Q?HwHxryhIHHt3QSn+DDK6tFUa8gw8oiCogLV5v1SkmNcVukP+nS7N9nEgorqE?=
 =?us-ascii?Q?F9dnnhpvDo5OlQrHW7KEYTwCOFsDCrVGFnX/Vob+jq9aQ34hDfaTq4Vhn2GU?=
 =?us-ascii?Q?57j6n7vdAIeO+zjV8fQoXmwxQdyYbNRYWvDH7f8AHcwy/aLhlbkfimUhwsqq?=
 =?us-ascii?Q?Zx/9nkpH7Iolo31IltTbIiPcDeYcoCtZuTpGgCdZu4oBDQmvF/wCdmEAYgva?=
 =?us-ascii?Q?ZS+fRt1wvrtUqFAJDsoBZg81Z9BWEylA+ox9bEet98IZFTOGDwmdsAXEn89O?=
 =?us-ascii?Q?lMy5RFeDnQI3bx02xNXWwx1pCjuIZlKmFrFo6IIQNbwlQ0OhDuf9FmsroF5N?=
 =?us-ascii?Q?o++jFLeT1FJC2N95RFIE5r/PyMWus0iF88dVv2w6vFnIp+LTbChFOTjymJfk?=
 =?us-ascii?Q?2xT/4Zi57wrw1wXU9c2b8P524CCp5KHei6l12W/A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28c3f0a-9f80-4b84-db35-08db8d15c7ae
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 13:48:08.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhMPz0D+kN5oNEaKQEwbdJEatsEMwGLX8+TES9SzKxZ3/FlLKd3RBfbljxbx3lPYlsWtB6VBBmvOsd0lCQPlCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Issues
- Audio output descriptor & location read functions requires code
correction.
- During reading audio location descriptor value was checked
instead of the pointer. DBG statement wrongly accessed value
to print the log that caused the crash.

Fix
- Corrected audio output descriptor read variable
- Corrected the audio location debug printing function
- Allocated the memory as a char pointer to the audio descriptor variable.
- Corrected the audio descriptor pointer checking condition
---
 src/shared/vcp.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 314618664..0408531b2 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -973,7 +973,7 @@ static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
 	struct bt_vocs *vocs = user_data;
 	struct iovec iov;
 
-	iov.iov_base = &vocs->vocs_ao_dec;
+	iov.iov_base = vocs->vocs_ao_dec;
 	iov.iov_len = strlen(vocs->vocs_ao_dec);
 
 	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
@@ -1385,11 +1385,12 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 				     const uint8_t *value, uint16_t length,
 				     void *user_data)
 {
-	uint32_t *vocs_audio_loc;
-	struct iovec iov = {
-		.iov_base = (void *) value,
-		.iov_len = length,
-	};
+	uint32_t vocs_audio_loc;
+
+	if (!value) {
+		DBG(vcp, "Unable to get VOCS Audio Location");
+		return;
+	}
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02x",
@@ -1397,13 +1398,9 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_audio_loc = iov_pull_mem(&iov, sizeof(uint32_t));
-	if (!*vocs_audio_loc) {
-		DBG(vcp, "Unable to get VOCS Audio Location");
-		return;
-	}
+	memcpy(&vocs_audio_loc, value, length);
 
-	DBG(vcp, "VOCS Audio Loc:%x", *vocs_audio_loc);
+	DBG(vcp, "VOCS Audio Loc: %x", vocs_audio_loc);
 }
 
 
@@ -1413,10 +1410,11 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 				       void *user_data)
 {
 	char *vocs_ao_dec_r;
-	struct iovec iov = {
-		.iov_base = (void *) value,
-		.iov_len = length,
-	};
+
+	if (!value) {
+		DBG(vcp, "Unable to get VOCS Audio Location");
+		return;
+	}
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x",
@@ -1424,13 +1422,18 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_ao_dec_r = iov_pull_mem(&iov, length);
-	if (!*vocs_ao_dec_r) {
+	vocs_ao_dec_r = malloc(length+1);
+	memset(vocs_ao_dec_r, 0, length+1);
+	memcpy(vocs_ao_dec_r, value, length);
+
+	if (!vocs_ao_dec_r) {
 		DBG(vcp, "Unable to get VOCS Audio Descriptor");
 		return;
 	}
 
-	DBG(vcp, "VOCS Audio Descriptor:%s", *vocs_ao_dec_r);
+	DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec_r);
+	free(vocs_ao_dec_r);
+	vocs_ao_dec_r = NULL;
 }
 
 static void vcp_pending_destroy(void *data)
-- 
2.34.1

