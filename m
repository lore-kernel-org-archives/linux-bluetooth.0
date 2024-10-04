Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4C1D2B22
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045352; cv=fail; b=mPp53PGIj2H1nvL/L7+l8+kGLQSkiu1nufmhAhpwO4wKviwEOmZNGT88bCRx0ubXEBORskCSGQ41pWHW75v/QV/Qf63EEaxAk8D2iLeL2Dv6Pu7+/Zwb1HCrOv3CBwUEIGWhJoi5B15MY8PS9L6QtwFoRc5pyoEMCKiFTM00lQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045352; c=relaxed/simple;
	bh=7jSc/3FVSBbpsGVGOVD14OVNfVOjko91YLAQKrGAMR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pr7l31G4/gGKHsl6MmAaJTYGtK3femdYNQuV/zWT1n67MIDXLSbJe7urV6QwCChOZbTouLrBZ5cVQd4NkkXK1xU6O5ITgwVJNFBt/Xbxs3iPzDgcLHbOAkpLYzyy073o+EJrKq3RfOsn3YsIapETj4H8+GaeEHpp/F0mef0DTWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mthZ5wLO; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mthZ5wLO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrH2sf+pSPjPLKaLwIFmm55/QGzRRp7Be+Yv4DETEswZ8uHKR3eXpPhkeVp1NWgPaceiEo6TQENVMo9OK6juI3spRWoWh51gdAk6kmbJ+cNv1UiHoBmvhZNjgUo8N2Mr7bN8STlHk7/kFI+iF4eOPqE0lNwQX60C2IfBHW33sQL4eLO7qtb3Ry4pxGCuwz5SllM9mQzUzN0xLIB/nd4/0Cm+5lXgzigEO+54CgxB0MRYvRLid7G3+Xaxn7IqT6IOZbh9QUTqbNMfanaQQszhumpkpxjuPPZYAAiwj8y0tExMS4Sa6/zTjma5Iq1CHV0BUIs36ofIIKj+5fGSy20iGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIK5Q+hdHIP7pjacgsO5QQJxsXYqOVJjY0tpNDftS1I=;
 b=rEIbsXXJYpmgaGb6EbdV/sgMczuQoakbzRkkjdImIk3JbWscay06HQgzIuRwEH0ZMfW+eCvbZVjbNAjtbuw7IT9Myc/7aGSjvR1+deSKijGmcM0l8UlF6hK2V7QHSTpVLxuU0ptCHtHl7n6eeoP1t8YU88dVp+A7P/q12zce1phao6NowhwAXLdNkQNBIU1hA/cVtw3upO/+OlBKJ1DVkmLjDEcG83/FKz+Qzjc2dLPZJKKhjJpl5I8EcootLc574R9Jrgn7MtJHcEKhiVR1ho96FqNlNQOgTBDqx2/RqNhdooM0fIB+whqQmecBFdTKhV/yKkJYcP7QQNax7U1JWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIK5Q+hdHIP7pjacgsO5QQJxsXYqOVJjY0tpNDftS1I=;
 b=mthZ5wLOJiVoZCKOchq2wp6nGNUBJvHeQValQAr/GIxci4gb9FcZWHS22o41rbgfpezWFob2ZuvRsaiDxosTWyKzBME0JwtsErOn2gvSXQW4wAK16o06Vk072XjWfv9Un/LWTLWePyVOuI/YXZ9A4ydFwqrZHuXBZTDqVCBxGLDv/l3p2QoVXVb8ivX3WxOG6ow3hOv6xryF6DfLXJlEF7wYbGHlsBneUbajhdah1sR2HOJvpWDa30PUwRY9GwZyXPia0c5frUHky7dkVHtQ/yytef1wNBhIxYkakRQaE4vDsVyaxpDzDuAb3E3x4rIA+Sz/XyCLihLvs3KwXevQXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB9PR04MB9963.eurprd04.prod.outlook.com (2603:10a6:10:4ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:46 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:46 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 4/9] transport: Trigger transport release when syncing to multiple BISes
Date: Fri,  4 Oct 2024 15:35:18 +0300
Message-Id: <20241004123523.1012743-5-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
References: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB9PR04MB9963:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb85129-5571-4a7d-30f9-08dce47111d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BNetteA3KgEOZBtJjkn1QgpteL5n6O9ia/s8UQvHGNibvxuNz3HYH9yuhpAl?=
 =?us-ascii?Q?TNHbFgcACcdf0wXKzWeTo9CNYmdMpQjsodt2fd30VSXVOtiufn0LuZtmseDp?=
 =?us-ascii?Q?yKriuVg+lIj7ETyWBgwYtDBPLV1YKhMcrboE3bbeQtNkvWwLV/YorcWGVGYn?=
 =?us-ascii?Q?EckYllp3dGV7WUw3lD19xYyqu4tKEvwLwz6OGojQ1OPMmO03drUFBkjgr3lF?=
 =?us-ascii?Q?iiBI9GUZYnCC+HlxQgW/ppXWiiMsWD02uqHNsT25HiDPGSwEfJu8oL/5XXLG?=
 =?us-ascii?Q?Xx111brsSYsun+TWpcBnKXlANIAwxcwWg3HWBOFYIsLhyge3BWZ7VWq5Aksq?=
 =?us-ascii?Q?be03l/Dug4Bgo2x/cTwlq1VePsTBXqz7gjSMU6S+tVebeaEAeEtw492wb/3p?=
 =?us-ascii?Q?YAEj1FjA/OIZ7HMFOMbA/W7Z8oU7cphyB2obo8z0DNtG8wQtWJLlaOZTO9E6?=
 =?us-ascii?Q?yNLTJahrbmoxKy2xCfHXlAmpzbYv9EiP8mCRI02/H765SHU90ExWVRGPvb4w?=
 =?us-ascii?Q?jYe8XDR88K4aIGjPttJ65YVWeEbWPme53v0sqII6l3oRJFq93nvI/kHs6j1e?=
 =?us-ascii?Q?Ny/owzs41CCz0vwtMaSuJq75lzmbzoBwxDSt1g2V2JqlCtNlcm6TTk+SkNNZ?=
 =?us-ascii?Q?eBJoWHjIM/O1PyTt1SZTDKheoO+uQNu5gEU+9m7olpZOJHNS1D7MxNHiMk1S?=
 =?us-ascii?Q?rOVL/0wKg+EK3U5eMRS4k3uwQ72IQ44A84HPClJCFYKZltNUO2ZhY7a5OI9X?=
 =?us-ascii?Q?tWWZfUepm0zkeDvcHTsBAy5qKA5deAvu67l8Vhz1nBFY2bvFizuzKxusd481?=
 =?us-ascii?Q?T8Uij6nhaHybuP/5o4c/prJ9PTONzHuJL9K319AaWlDhkSxKQqJ/iyyII4rv?=
 =?us-ascii?Q?NVlDJf31C6aBx3h8i8/qA40qAMrXSU0umEBjcPvcJknnhLRWwVJWY5qWAFTf?=
 =?us-ascii?Q?RzayJ2qnFTqOLUf/LB1yIzdY7zHpMzy2BJcvhGZPmobRpAZEXS0zAYS6xDli?=
 =?us-ascii?Q?mb1Om3IoNc7q7OyEcONzyOgBAgAmhfri8txqMthNsZ0E1F0uQnpaJheQzxKK?=
 =?us-ascii?Q?aNPuwEtKmkL2O6ACcwjYNuGl6PhJnvisNudcJlUgQ/ZtWhWVgnQiOLNg5yhK?=
 =?us-ascii?Q?2QXxlFnJLePrjyNVK4Mkbu+vckW7/WLd4wRqR764vrJrWoDksLca6Nqlg10A?=
 =?us-ascii?Q?DZ3EfA40T8fdOGL0iNrpPOBGvdPvX8o9IYz+nEJ/R9kY3Ox27fSynnO7z2ga?=
 =?us-ascii?Q?fjf0bTukidGTawJ5cxR+/vzXHT2MVcN/6BMdUUHJtWzczAiWRVs/gC3kcBFe?=
 =?us-ascii?Q?yRJW9eLMEm2H/VzXk4mKixEwj5R+PdyE5yLri76ICjjUPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ls3sHp6e8U/S2ccy5x+TXUbNcGwdkVejIFobquYVRgNjS9FR855qNuWLnIs1?=
 =?us-ascii?Q?WBrH+bohbKPEyjECZuccW9YyhfLhu9iixcDdwOgTi0Jdfca0xYjci4phlwPE?=
 =?us-ascii?Q?K50jeLEoAmPFXluy9eGjix3oTx6LFDMvPr6dBPgPcJOEMCaqRaz21gAeMA4W?=
 =?us-ascii?Q?KaObZX8jMQMhN8UjpXknKBpaMt+VaQfIJLOephC1RKQzpKc4Gy3Nii2x2Ju3?=
 =?us-ascii?Q?3YkGttbuRcLPfMdk4ROUemy19WPWTo7b4yqGtCU1qm+C/uy+TZ25KKxMVhUa?=
 =?us-ascii?Q?UyM0fTM++cxciSB9bjFkM9XuJX3acBu12r7FUJ+9exSKFhKiZtf8LSdFpS8/?=
 =?us-ascii?Q?djnwLP8dXYxg437glaAws+18J4hl3AUq/Om6pyMxfWzPiNGv1yFVuH7fSJXF?=
 =?us-ascii?Q?QnFe/dRONR0CiUxlXAb7LTaCo9g3OY99cesV+exdLq2DSx90xa4871LcQ+mk?=
 =?us-ascii?Q?iaQ/gtBQRmaEgjOYpdcYKYjGOl2uQe6Zpy2sIovxb8peZk0I89fR0CQ4g9JU?=
 =?us-ascii?Q?LN3inrAR5+7NpydYKkElMBlXt5m+nq2k32RHUn4tTt/tYBEmcWNdYVi9grOz?=
 =?us-ascii?Q?06n+VAdLEbehDEFTmAL+CdTiwYRZqqswymDEEQ9Ak5U1rLltq7LHc+GCAWFo?=
 =?us-ascii?Q?fQWgOJ/kM4sZJeRTpkSIgMxk1KAmr1JgECImrHsdQw0zVBitl4QuTpcnUkvq?=
 =?us-ascii?Q?RBVIN2FE4w8oNg7awOmtTMyNWxff6iGxIhLDFDCbkcSwV2btSB45KyUySTmV?=
 =?us-ascii?Q?FBR4NhBvU0/9l+T/Wnio//P77oCs2hgfYDleQu0jjVWReFTVJmSk0G+6/OX2?=
 =?us-ascii?Q?ldm4xnS6ltAh6WmPJa4elnqUOY8zMx12W6kebfWXp21qXE1QZEYxI0tBcZJ0?=
 =?us-ascii?Q?VG+3lfUca69DBHmR0zQL0fz8QI1WTxLTMUShoi47e/lP1TsDyPXQ8VhcMhZM?=
 =?us-ascii?Q?L1MROGovdt3xYBe1rjAwTY9vYTk51rz8Am+OiLIcuecjQ1VDIGTSA9TEGmPT?=
 =?us-ascii?Q?DD8+iF6FXaseoW9CmRIVudHiKEmLm7cb/5SLO3vHhUPw+fIBGVxzhiKSNdq5?=
 =?us-ascii?Q?pZTxfUMYWqpOzh+AQlkCixEVfjm1g5FNBZ7U22LChMtDaNDQ0EgIU52EVxbu?=
 =?us-ascii?Q?zAtFvyurYTVEDHFDGWXQC+HWpBrUqQgLim/fbTW5eFDc3RKGhMhpx3VYM+Qq?=
 =?us-ascii?Q?mTchO/7DLrRpt7AMbWJRD8w1CQKgmzWQ8CDxLPlUA2pQ3uP94D2oibqn2tLg?=
 =?us-ascii?Q?QVSf+Jtkc+6XNQFjzhxLiNW8KCO7kAfkk8PfZbdwxm6OjudeGL72T+P3b+YJ?=
 =?us-ascii?Q?swvvJSLYgyaQ04YDb12swOPT7InJHAk+nd8kbD4+5RBhD440WbuWBKSEK+yT?=
 =?us-ascii?Q?pGdLlZ1l7lTVdsiHXTGX+73zWfPGIbZJRu7TrTy2+9R5d0UQ+spcPyQKuBcM?=
 =?us-ascii?Q?VcOtpqOW/Dxs01IdpA/+31DKzQgrfl2nIBRsnsxWQAR7NgWCii2rt6Rj3g3J?=
 =?us-ascii?Q?WkqHIdxTFcXjTIyZh+ibBLA81BjX8b+yQ2p/3G8Ddrh8zEUoEl7zh7URPX9Q?=
 =?us-ascii?Q?JDJ2BGt2qwAU/c8+aFcaJOTnnMngAPCo3sVfwwCS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb85129-5571-4a7d-30f9-08dce47111d6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:46.3252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoHr74sTr0YsGlcsilIWVHa6IdEiDQlePPtswokD7k6plvjiaDouenEXp0ufBjbOyD2t7RVaF/BvkqVUtzIU9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9963

In order to sync to multiple BISes from the same BIG, the existing
sync must be destroyed and a new one created. This is accomplished
by prompting the audio server to release the existing, active,
transports (by moving them to the IDLE state). They will later be
identified by the RELEASING state of their streams and the process
for reacquirement (along with the new transport) will begin.
---
 profiles/audio/transport.c | 41 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index caa7287db..e68695c39 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1366,6 +1366,7 @@ static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	struct media_transport *transport = data;
+	GSList *l;
 
 	if (transport->owner != NULL)
 		return btd_error_not_authorized(msg);
@@ -1375,6 +1376,29 @@ static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
 
 	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
 						BAA_SERVICE_UUID)) {
+		/* Check if there are any ACTIVE transports, from the same
+		 * device. If there are, it means that this is a request to add
+		 * a new BIS to the active BIG sync. This is done by releasing
+		 * the ACTIVE transports, and then reaquiring them along with
+		 * the new transport that needs to be added to the sync. To
+		 * release the transports, bt_bap_stream_release is called,
+		 * which will set the stream's state to
+		 * BT_BAP_STREAM_STATE_RELEASING. On bap_state_changed, this
+		 * will be detected and transport_update_playing will be called,
+		 * with playing set to FALSE. This will move the transport to
+		 * IDLE, prompting the audio server to release it.
+		 */
+		for (l = transports; l; l = g_slist_next(l)) {
+			struct media_transport *tr = l->data;
+			struct bap_transport *bap_temp = tr->data;
+
+			if (tr->device == transport->device &&
+					tr->state == TRANSPORT_STATE_ACTIVE) {
+				bt_bap_stream_release(bap_temp->stream,
+								NULL, NULL);
+			}
+		}
+
 		transport_update_playing(transport, TRUE);
 	}
 
@@ -1385,9 +1409,22 @@ static DBusMessage *unselect_transport(DBusConnection *conn, DBusMessage *msg,
 					void *data)
 {
 	struct media_transport *transport = data;
+	GSList *l;
 
 	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
 						BAA_SERVICE_UUID)) {
+		for (l = transports; l; l = g_slist_next(l)) {
+			struct media_transport *tr = l->data;
+			struct bap_transport *bap_temp = tr->data;
+
+			if (tr->device == transport->device &&
+					tr->state == TRANSPORT_STATE_ACTIVE  &&
+				tr != transport) {
+				bt_bap_stream_release(bap_temp->stream,
+								NULL, NULL);
+			}
+		}
+
 		transport_update_playing(transport, FALSE);
 	}
 
@@ -1768,6 +1805,10 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_bcast_qos(transport);
 		break;
 	case BT_BAP_STREAM_STATE_RELEASING:
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE) {
+			transport_update_playing(transport, FALSE);
+			return;
+		}
 		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
 			return;
 		break;
-- 
2.40.1

