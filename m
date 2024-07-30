Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013056.outbound.protection.outlook.com [52.101.67.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F5197555
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336839; cv=fail; b=dM578i30fwjX6Nf79Xd0dOTjBkpc3tNJFewvKPLsLQeytf0RqH1q4vzvQ7jGw46BjjOJzcmbjC7puoS7hefLy+T4vbeV7LwDZthUDZdU/5ISrvKJNGaxowx0L/cz5UyExtNVvPY15Nl9qeNjQqv30NDz9SEbWU9kJsuu9UMne0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336839; c=relaxed/simple;
	bh=8T8yI4uS81JTh8OojwU3eX7+Fi4f8/nPHQCU/zEVqU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h56zStd3+4/zQ4OJRoFTzQD1wotremgEMPrGfvvEotmc4h6OfU4wktutB2LrqFUX34dw2GBQkFlygxg3egG5X4Oc+/PadUPUzh0h8mZ63yNL7D2L8OqUx3NBDyOEDL3gKTbaHdTlLYdD5YTO1KQ0JegkxywDTwcKoVvo1EbTBKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f9VtFSzm; arc=fail smtp.client-ip=52.101.67.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f9VtFSzm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrampbiIAAjBWPQCFKH3q41G5OpexWruCy0Qv3WAYfEmT8agOrdAhxwh00ITghx97kzQIzJU2tCN7QXqhW9mIJPoOOnNVKeJnP4KWeat6iEQmxJXjeNmWIGWFHQ3REo42NNAptnXqcT9nqtN8aT6ws/055vlBPObuVA5/zoCWGm+JF6BL43rDw7KW8WHSdNY6XPbI4nNkaeDUCv4vxSl3SvpRYBafQzyNGso0BrU3k6nCOd8UrcQ0DEuPNE2YzJDcs3SQn3gDpir2ti6J9qd17HzDS6m06EUAeFA3uFnksyxfIfh+osQaVuPScFlYctz/1G+gUNkp4Q4tXH0PPhPdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcjMaOO6euH+vV2m5AvNknGUhOfxSXyCI+D/4nN4jsc=;
 b=YzjRbwOBpYQYqTh9E/6JogxMup4gHhe0lJVJ3lld5s+o1Cy3X1VLTo1jW2b0aNftr/dEgk7yHRn8+rG6QjEX8QR2Krn/YugwMxTEAEDlm7nooCGXIAd0tuZ1MsKf62fpRtKb4/L60guOV8oyQ0L9fo5+L1eFfLl8HveWt+Vf4l6PK7Zr3e18OWW9LzSTU1EOBee4VyJyr3fVHLnprHZEOC9KQyfHzSM12PjrHsy5GPTXl9J0Mx7E+HycLSIr6+0rJDwP+NWPigUKKOjF7jG9N8ck63OGa8Uu80CGC2Q51qBc69TbbT3ebAVl9vMe85hyw/8xyxtOjobgk5yG1hAXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcjMaOO6euH+vV2m5AvNknGUhOfxSXyCI+D/4nN4jsc=;
 b=f9VtFSzmL4amMUr8475ySFK/3lK7wpVfsOe7ve4h8LBs4zp/NgaFDvqV7mxCiLbsca4jU4gigfZ6A1YritZfRZN2RJnLAJqeKyBgB7F9dWuguIBp/ka3gbKKQu5zC+bmbTOcEN/2MgsekSSXJFlwkFhuencDn+4uTJXBHekY+KIzAlza5duM3rJZtNPaneWCmPKhRJiMENKqFHp+esvO35joFEzRkdayVfVDnPHQgGO5vElqmkVyVKEOFvkdh7sR8nn40PY0S9q5SnGEpTrpxf4uEKsfS0c7NwdNXojaDzoc/Lv1BAQqcX3GNTICDu6a9GE3EAoi9guyXui0Z8oWzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB9PR04MB8447.eurprd04.prod.outlook.com (2603:10a6:10:2be::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Tue, 30 Jul
 2024 10:53:53 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:53:53 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 7/8] transport: Add "unselect" method
Date: Tue, 30 Jul 2024 13:53:12 +0300
Message-Id: <20240730105313.403238-8-vlad.pruteanu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB9PR04MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 316bd00f-65aa-48e1-ebe4-08dcb085e056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VJFpleXXk43A/cWL1AXziTrY+ulkUQQEWBZqeXvRK56npZQRuWaqXqBHJ2I3?=
 =?us-ascii?Q?X7P7EpIIJsdEdtuwCoMdaDHFUy5y3tdiSXQSzhSLuHDNf/HLk70M6YZIL0Fu?=
 =?us-ascii?Q?DZBf/6IcMBEreEMOTKPLJzYe72ixNjrh2tmA6hLwGsuXEnJt9frlTvhXFE7h?=
 =?us-ascii?Q?qdeoYs4hm7KZNjz0uye3QDHklHR3f0TyyeH4cSuH35Spw+SJfpCcDjLHaN/R?=
 =?us-ascii?Q?wyT+bV3XGVQbG5Hwh67vX9oaZBYAkR/KvXfizunQRDOpt0Un+uDHl6NCOTVF?=
 =?us-ascii?Q?GkisUq8tRYTUosj1jUG/WO+LCh8dw1oF39WeIJznqQOBVxMLUyt8C/qrWvE6?=
 =?us-ascii?Q?b6jdiY/WgAWSKtkgNu5NnhMa2ZZMl02jCmilv+DVa1iKLMZuw678wp6Y9zDJ?=
 =?us-ascii?Q?He0LY8p883q+O6exM9BkCQETEtFtRsu09oBUlUkim+NmT3YY+/teVhaJcoW1?=
 =?us-ascii?Q?WpLrZugqHIOHXcGF4ARXGiR+VmM5PtIfVQNb5fvLAiop4Lnltv6NHCVILBix?=
 =?us-ascii?Q?qZPzLuYpNZsUZ862Xj1jb5vBEmc5Hv5Cas/f4opKxDc43grKeSEoP7oEhFwj?=
 =?us-ascii?Q?wrK6LR9uRHHSn6N3t1bqS2gcCb7xBaYch5fSubWTn6r0MJP2K2zEkpJH3evz?=
 =?us-ascii?Q?GgVDqjkmVsocf97ZJIwYHjfgZqup8C3JpuyeyNkL5g0fHhrRDdgx64de7puS?=
 =?us-ascii?Q?lXnRYDUFMShV+Sn9JWCVInsNbvUe4BjvTLSGy/22/ieONGWnBahX77A9ey7E?=
 =?us-ascii?Q?UN0tufUuNzDZtJSOwFFlNw7KiOI7GVpS7qYdaBAY7wD6NniHAaQ8A5Vmq6sU?=
 =?us-ascii?Q?1WTGZ6Pcq0Tl6bURdmvVdv4T8r4LIOjAHnuXhpSr1xvCb9TMF/gUeI+ocHZh?=
 =?us-ascii?Q?RgPJGotNy+mXdmeQ+u204QzhAGfse+MSBWYYFUVd1ZR0hbW/NVGtDmfOr6bj?=
 =?us-ascii?Q?Cs91WgV12mHY3EtSb2TjumRs3DRzP7xwI/21tUir09QxF9TAveAawk1PvdPa?=
 =?us-ascii?Q?V3xwzRBVg9lBlT5jGvoWHPWcQo2ZTRd0tB2gpnV7MtASSUQ6iAKAWkBI1mT6?=
 =?us-ascii?Q?a6EijOkNoKzw+PlUWJ3wqUbK/b9aCQ98dD3wMMLhlAA7huNl3U0R8SH2vgrI?=
 =?us-ascii?Q?vh+Y29wYyX54O2aT9bd99F3yvpKBbLQXgqAz2YkiglRRXVj4to29QrLH4DME?=
 =?us-ascii?Q?gbSYWOG2b9xwxxcCutPwzVjnMFhve7eqEpqqiQgTPUIil7fv0Cecz1migbmD?=
 =?us-ascii?Q?EAqgvP334pzB7Cxqb6pS1SNsgDRCjkbmlH2ilqxta1CzaK8bphNno/+Ujv4R?=
 =?us-ascii?Q?Da6WpoCVLAFbOnED+R8ynxbBgh809KvHhuIouQKywLD7LqJZiRRRhEjPtRuc?=
 =?us-ascii?Q?APT4chzguysTOCP/6QWcgXy6RdFtujb93EeohEcwTOkZQ4htCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aYEQlw0sI3HbbUNLxRB4pO1+a0ZPuiKuCm+4nPD4ghN1NYAcGFbF9LWsQN0m?=
 =?us-ascii?Q?MD2drQvVPp0CWmEdO/eippEH7b3SIhkH8s6zv8balGoEZVTRpSf0EWTb090L?=
 =?us-ascii?Q?52XgmkDsqx0io6NByU8NYHdoZbR6/XWXUAehLcU7JzXPp3demVflGgTk7jlY?=
 =?us-ascii?Q?7a0gElRs2KbH6r08JhrLuuqjDGlxlsJb1dKrT97in9GkCzrjSE1TgjICxsPO?=
 =?us-ascii?Q?9TTp1P5M4o2aGyX2dgIeFdcW+/7qfdisqOgcwxmG1vu/SlDIXoN8exeMzg/P?=
 =?us-ascii?Q?JmO3CyRojkE4Ul18iwc70T0ZzasQlihrQXkbRXbrJ16Tng3Rt9Zfez1rChxf?=
 =?us-ascii?Q?sGOUtH72drq94JPXCNuPeNY3OL5/ztOmUygLvo44k3uzRrjpiRei67vTZcls?=
 =?us-ascii?Q?lhLfD2DYwMWJG78Qj6b4+oWNRUv2dC2CqFLrvCp9TqiXHiig1xWKTlcUU3yx?=
 =?us-ascii?Q?Ps2nsFZkIjGdIDbv1YGvDh9BxnBrfwhdG3x5oriC9a0jfc2TEglFN07Ql1UF?=
 =?us-ascii?Q?vwX2yZUYiovnGcRuoJ7RnJqp7TELTf4iKiWpDZYsQJO091gUMLOH1E33gW1N?=
 =?us-ascii?Q?dnqWocFZpylN9yNGTd5TwOPwn+Bse3KMJ42yjPMB0ix7k0VwEtQ7VzEwBMvU?=
 =?us-ascii?Q?XFGUAop3zXKbdRJP/C1XDx2EXpitYglP6WNxFQPcBTXnYul5vXEieZqufWGD?=
 =?us-ascii?Q?annFjy9jiGQQhO71wOJuDY44Zxah+uS8iXZ7+3Y7JRCLHv3c8scl5cXTbjmx?=
 =?us-ascii?Q?29YLgLEmvzSe4rwKD3pj4QHkDE9+/vTbfok3vkfJygf8OzaXzW+JY168eaRe?=
 =?us-ascii?Q?HGTV+gwI1ChpCj7Qgq1vULuF/m6H3sb6/Wa3HuB8qvg/nqHgYQCzh2SoeSXN?=
 =?us-ascii?Q?ya4wMloMn7iqxFVJliVopSS3+eVejqR/9UQe7o9kubT86U+KQ21/7IRagNvO?=
 =?us-ascii?Q?ZAMlMpOIQt5YBkAqz0IQ6tqEbwjXJ7qCGVMUbB0OMn0psjThrPe82eHDX87S?=
 =?us-ascii?Q?90djVU9GCHdbDzgxHLLtG5XzHTaT4FfNDjGOKhbHUHr+mTYQQCEKNVzvfE06?=
 =?us-ascii?Q?SiA4xNUqOXZtRgAydjNQH/S29B11uM9+83x6B/+uzLuOW8UqhNR8CI/fUMV2?=
 =?us-ascii?Q?e5mxOOvKyUpE+zTrMCoVl1NzPupqb262C0ESFe9fu3hrOH8gSesX86rNLW/L?=
 =?us-ascii?Q?fiNL6LS++YLp97Ok13DR8Sgf/WJa8OsFvjJ/bC4EOSyipX63snUmFi8GLuon?=
 =?us-ascii?Q?j12X6wcmjJ3sZ32OteJ6lzhyCdNjjV/nKPskYjlQe+Qur2Nb37YDDJTbS5/x?=
 =?us-ascii?Q?T5iFO6UZVamPiT22sgcwkXKRy/51K2OWGqVWNzfJNrJgza9JguO8gBvnxIyC?=
 =?us-ascii?Q?nlTgrTVDEgbqPAe7sahfd2n2UCyPwBbSf/8uxy7UGWDnvgVMc+FGjTjEVM+d?=
 =?us-ascii?Q?7Zsd0IraPQvAYyYV2FP/wOhVEaqnPXBVlY5JSzJj0ipu9I1cfl53x/AvTvH/?=
 =?us-ascii?Q?2NXRN7+KmZcCj6atzK3Th/SqAvewWp/nzwrydjOOSAfZjZXJ5A97JG/WQpJl?=
 =?us-ascii?Q?L+Df19e8BXWylke+fY5rsvlysRmoIwKfO1r1ZFhW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316bd00f-65aa-48e1-ebe4-08dcb085e056
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:42.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IMeDVY5FwtUeepe6yRafl5KFr7w/QsJf86yC25dbXSxWHwouQs7DOb08QbwZ0VK9W84+C+u8jS7QuB+F2VcDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8447

This adds a new method, exclusive to transports created by the Broadcast
Sink. It allows the user to terminate the sync to a BIS, via a 2 step
process. The first step is the call to this method, which changes the
transport's state to idle, with the second step being done by the audio
server which detects this change and releases the transport.
---
 profiles/audio/transport.c | 41 +++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 80e4f564c..300145794 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -975,6 +975,9 @@ static gboolean get_endpoint(const GDBusPropertyTable *property,
 static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
 					void *data);
 
+static DBusMessage *unselect_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data);
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -989,6 +992,8 @@ static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
 	{ GDBUS_ASYNC_METHOD("Select",
 			NULL, NULL, select_transport) },
+	{ GDBUS_ASYNC_METHOD("Unselect",
+			NULL, NULL, unselect_transport) },
 	{ },
 };
 
@@ -1295,13 +1300,22 @@ static void transport_update_playing(struct media_transport *transport,
 					str_state[transport->state], playing);
 
 	if (playing == FALSE) {
-		if ((transport->state == TRANSPORT_STATE_PENDING) ||
-			(transport->state == TRANSPORT_STATE_BROADCASTING))
-			transport_set_state(transport, TRANSPORT_STATE_IDLE);
-		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
-			/* Remove owner */
-			if (transport->owner != NULL)
-				media_transport_remove_owner(transport);
+		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BCAA_SERVICE_UUID)) {
+			if ((transport->state ==
+				TRANSPORT_STATE_BROADCASTING) ||
+				(transport->state == TRANSPORT_STATE_ACTIVE))
+				transport_set_state(transport,
+						TRANSPORT_STATE_IDLE);
+		} else {
+			if (transport->state == TRANSPORT_STATE_PENDING)
+				transport_set_state(transport,
+						TRANSPORT_STATE_IDLE);
+			else if (transport->state == TRANSPORT_STATE_ACTIVE) {
+				/* Remove owner */
+				if (transport->owner != NULL)
+					media_transport_remove_owner(transport);
+			}
 		}
 	} else if (transport->state == TRANSPORT_STATE_IDLE) {
 		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
@@ -1332,6 +1346,19 @@ static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *unselect_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+
+	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)) {
+		transport_update_playing(transport, FALSE);
+	}
+
+	return NULL;
+}
+
 static void sink_state_changed(struct btd_service *service,
 						sink_state_t old_state,
 						sink_state_t new_state,
-- 
2.40.1

