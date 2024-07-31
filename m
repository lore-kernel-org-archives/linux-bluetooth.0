Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165B16CD3C
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406665; cv=fail; b=JirXrOfD9HYaUTjARVov51orkK4+1M7KInIAP1aNSgHkfQwFb2o0zwWjpBo6uPYQ5w0sR6E7Ml4XThPfOmKmoEF1zlRu2Sp0NpPxijTgYO3hqDLw/R0FgVdYLAHYaks6GpEE3t6Y5+JmZTGAYe9XwYwx+LtYfLxRqZQID3HPy6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406665; c=relaxed/simple;
	bh=i2kfQu2WQ5PRBBveggzg3EcZH+RBAj+3dkOCROMyBF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gWNyCSGxz+afb5+/8jcSbIdyKZYj5jMlTT3r/qofv3EqZJsJSpTgWXB3nNBDDmXtrwGuM3BH+5gQt2eJLzJBYD7Vp5XE0vx6vq8/tjbLTOeGuqrK5sH+a+Dz0ubG9JWNY5EpUm2UI+agBOcx8g55EbO0Rh9Fa2dE9ZQzSvABp4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=klq678qA; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="klq678qA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0rS0dCyHZUx2g1Nm4h+iO6liXuAKJmT2S0LVJri5Lj+Wh/5kPHNKoYYgZ6Re8uW53H0z+AuSutXsPGcOTceFIbz4/TkO9ExKs8ZVl/d5v+de+QRjRIk7T3LamK5xN4CyonQScbZqKsmEvwDfvf55KDL6l9sWOkKK0e9UvHSUc16oPSwjIT4jZFGBX5kM/uPCHUi7tCkz3gZTH2r7c7UPAsN72A0t+ww+y4vfwfl86Oq68lZXWzkxWtq2PxL/hWMP/TwB14Vjx5SagEOxFhztGZG0RgaQ8HNtQqzpws18ZiQDABSLq/GFWMcL0cWSkxUZwkE9YnjA8+0lO9nGTANwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHo47cYsqTfi/qxTNYbgk5ewcAuabXPbWlg8EUQbAtc=;
 b=kGbCKimeCqZY2VJLa3Ix76lKYdHHkEQShHTkQAyJXV/AUhMcWQT/+1ePtzm19r0JC6ppPbIRDXV/W12F+mfNDU7aXrHJJl8AvBuxTijn5JQpqiCdEegOt3wqWdnfUM7y25zuk5QNRdSuyUlBVSoRfziy5bgumnhkTuIQ/iivZbZDWjKZYnthFIgTIa5tCOvFmY7jBZzHyJVw3lJ6QLYlsH4NHtgrsbm3ltL0vjSjHHHVyc6LK2TdmHQ2ypx+NdTxp13qYixqdpMnVZOf1uml/XxCMgZ8n3wLcBaIt2VVG/P6PkxFe5bgQw+aBXoSAKJk9vJqIZk+PCy4PdcNQ7Z/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHo47cYsqTfi/qxTNYbgk5ewcAuabXPbWlg8EUQbAtc=;
 b=klq678qA9i9bROER68U7ZE27Qow3OncdM2opI6NbpQsxjP224Z/vmMxvgyn11Yl4dM3ouxDGUYPhBpwO4L17P5JOhmIOBClG+gP+uZaeEAXRN1j/WS4dmn0az46dOsuA4XCmgXmci08jH3eY69Tnn41D6c/SxzTVucBn2JObeUCfSxnKaAdEkSoDuzpOXPhcl9WuZ7KfGJQAyQpM8QpQuuAFexT4k2FnFdcVf15pZ1lJqY10/Ud2yGyQpupL3lg7V057kas1XZPCpQDaujUELPKIKtl5OytQRdsqfmp9h3Xve3jW8SUNgVLwtK09X26EgcWJEWN2ymg8kcGj1uldpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:35 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:35 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 3/8] transport: Add 'Select' method
Date: Wed, 31 Jul 2024 09:17:08 +0300
Message-Id: <20240731061713.435586-4-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
References: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fc453f-ffd3-4aed-f908-08dcb128785d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eO7gLGiEE0oQ5ctaoLVPUEJBC6o/j63yEaOIloNpgUrrxxN2wyW3HUQ49Hcx?=
 =?us-ascii?Q?pL2O2WbLNKwkUie/4FuRi6sibaN2RgVbOWL2XgpsqPkwq9fUoPmdvQi6assy?=
 =?us-ascii?Q?iSgMX5uITnHud/i44SGOgAZXCkgdWefRvz5+C0wKbkzqo9bPAc+VDzzn5ubB?=
 =?us-ascii?Q?XUHMApys/IGPpigrh29b3aiGlW0egPe2Tywt8oThsVxyyt1yv08Xh9JCLktJ?=
 =?us-ascii?Q?hdrbiOsDtRlPUbWGZGKOVOWES7Boq2eIlm8wy7ZnSjM0CjPtWegfmk+Fiwdu?=
 =?us-ascii?Q?QhxIYFXUeg8GOGW1zL45yEzfufMNfWTi3jr88xCX9tFH/yVnMS+GJIdKmx50?=
 =?us-ascii?Q?rJgW6WnM/RSQpsiNSD1VnseTR7xQcXrOazHPyd3aj5mh2Ew+Lw0wJdkrXKM1?=
 =?us-ascii?Q?4xejSgGZXz+2NF7TzFx8jqvopbMepj1Ek5Pd2vXqLkb7eR/Zhel6f3TVd8Do?=
 =?us-ascii?Q?k7FZMhqEQVehMg8eYlP2ShYeOIY8ErYkQKlr77yrAps7HMduIhu0aZKWB9gg?=
 =?us-ascii?Q?Hoj+4QvETNnldUTTDaMbf/GzUAImHFPMSvEPLhqk7OKxe55DclaHgc3gW6ET?=
 =?us-ascii?Q?SAD7a30twEyOOFiyO64DHR5gMDyXJ8q+KNOuqDGVASp26JXsvMsObdCZzWka?=
 =?us-ascii?Q?2Tkf/WJROGACjMABSNd9Ps7Xrwb6DxTgNFzZuV8ouszQ07Bi06Qm7rDOc8Nk?=
 =?us-ascii?Q?Cy+KU3ypelf2ZzC/5r8X9qTdpkCPz7lZ3holIegUy7Tons4hdHx5iLNxymX4?=
 =?us-ascii?Q?X+p42N+xpAhZCpyJGUhpMcvJ8eBz/ihxe4vObZEFXoktYiG8RFHCsSi3fltc?=
 =?us-ascii?Q?lIcmGokvlygB/Y7ptaBjA1JAn3bDmgjBOQlJXQ6Llp5geSqyXqm2+q5/8DDy?=
 =?us-ascii?Q?THP5B0F5lrSgkJINFe4FBxBVO6NkbZStFaO2k0Sv6MBz4T4gduF4a4h8PAQp?=
 =?us-ascii?Q?yokoKWNWrNfomrg5c975PxD0yZ0kdPNzaDaYmjZhfikiEkSrPmP6SnyRG00k?=
 =?us-ascii?Q?qc8Yu7bl3WzHeCpAfC1Kk10kdaZ/35AeMnWtFkt3Sw32lMhbFnCkssRMNlYp?=
 =?us-ascii?Q?zwKVvfKMz6gAqtgOrxkwaJ/ddyd9/TkvGSc1QxR2W40jJsbMCyWqDTsZYlk5?=
 =?us-ascii?Q?11o5Pn0rLhhSmghX/3m4dqNvUOjzo6a4SDIEtgCAR+6EKOmhIDIc92SL1Fl0?=
 =?us-ascii?Q?+0/vrOZ/ZTbN1SQ3dYyzMi1OjkMNndYHbUUrv9kpnu0yUKU7VFTXM0THbt62?=
 =?us-ascii?Q?f4XKVFnsr3Ip0arizD3oKNd5GzVWsi3sbwdOd0aoAPwLGDe6kXavC8DnihVd?=
 =?us-ascii?Q?INk97dNkZItWrQ61Udw+nC+y57vQPLLBcDbsOOsYWK2Dm4BTGScmv+R7v1wD?=
 =?us-ascii?Q?rEAizy+p955z4dMeL/DF8VG9w90ek/2RtbhHbmprrvFeMw6Gvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kKRB2shXyFlH9cORajmSAxumvaP9LRkA1JL32moK+kWS4z068lXvtIj0VD82?=
 =?us-ascii?Q?BA4yntH4B6H8Nm5usyli+ELOsN+DDQtkTz81CDkgipmKPHIF9ixuTq2/rHGv?=
 =?us-ascii?Q?5rGONBQ7IVxoXXskOJjs/daU9aRS8Z82Ltoc4foG2fk8rXpVK0YMChsVxFDR?=
 =?us-ascii?Q?q85vOYMLgf7wmhP7eauk05BAzegmIYWK9jotaMn8sYTjMYqGIZXGv9IJNgB6?=
 =?us-ascii?Q?OhxPhDiuPevUUakXn57789Y59TftwNHb1FKKbsPtCd9OEk/9QhyCqJNkP05B?=
 =?us-ascii?Q?CI5MvG4xa24t79S/f8yvsf7t94jArcXhkBcbfXJUun+VgTPYqV0EH0eFeCtn?=
 =?us-ascii?Q?RuNG+GXSS9MewXy/wGxf4jAYQ4WHX7wRGbAgvmS3wqlrX3d+tyVksWk3SdX+?=
 =?us-ascii?Q?jO+S97xOFDmELPLXghmrEAWCuzcgmL0OgtOOA+UpkpN71QTC6TECL0KF/+KM?=
 =?us-ascii?Q?f9Tonc7vrGXPwtDXuCpc2P39Ze6z25q6KWt31cphwlF4hBsYcfJvYY5bY/pQ?=
 =?us-ascii?Q?hIvYh03eJIKV+siFqHaxz5AU6LNjY70LskyPvU9i/ThEPp7bII8nOOusLQ3x?=
 =?us-ascii?Q?MVDOiDGr65nQmhh9nILThBfRfTL+RsoRvfDwiZLFl7EZwYuKVNemN3nWEP+b?=
 =?us-ascii?Q?JgoNHrYoGmBMD3zAXfLJQv6HGvDAp5QOwjO6GrqWQel/uWB4kjkqVg7pIJ5Q?=
 =?us-ascii?Q?aSN1WRfPjTYxg51gLuholT9VsKfWxOuyxGk5cQmj6vfeFdMXjUwBxDK1xAjQ?=
 =?us-ascii?Q?JasVMI6lm+lK606taIfe8SIRhicgV4he3qf2QN1NRKJQgkBsIt0YSCwkouWr?=
 =?us-ascii?Q?deqT7ot5dx+386dXze5dpnBRyNvrv3HdzoiGyLW4papJjeN1CkhlGtCpBeTE?=
 =?us-ascii?Q?aMsuckYKJQLX0XoQAir8StjJVCOqFeNAPtUP5yPxIEY3HPXW3EKFBJVGJBAB?=
 =?us-ascii?Q?i4No9UaJc61ej8HHcraq6u1D0IUVp3ADI5dLlDaR08fxHdD1dcNh+k+jXO3y?=
 =?us-ascii?Q?/heYGzX38p1Dykj0W79V+ychOSKSvY3q39/wexvhoHV2+2L/Kwy5d5d18szN?=
 =?us-ascii?Q?SXg29+0F+Hd8mQ0Pf/P+ROftlEoSNH/4lkhOmJeCK070S/x/+TNP2ej2rrV1?=
 =?us-ascii?Q?mr2Z+4T688tZA8zDwjvcEKBT0Mj6abugaTq50BXDWQ1EbQJl0bA3lkaWAMAW?=
 =?us-ascii?Q?uZSNsPgsseaaEXu/hXHEqqjR6VPKTQ+grEwmLaXnlDjEp8NbjqGZwcpWH4c+?=
 =?us-ascii?Q?Aow/0CleXnXUifIP2nI13xFgR8jHrBXx9ZkQmoKOxFbN+MjjELPY/Q9ix9Ik?=
 =?us-ascii?Q?SUs6q2YgrC7jed5ZmMbE/czwXqOBeNZgqsoNSWQ//eXo23fEJAUCbg6EEAdT?=
 =?us-ascii?Q?LqDtsnDP3A540D+kZEIq9AeD1OPM3jDfM6jg1fB8P14FdrXhmUBQE9pBIst4?=
 =?us-ascii?Q?LIsl39V/Fh72s7b1uMfSTMYygptFKnqxNcJ+6cK0S+o+vL+2a1BGYKnCwL3z?=
 =?us-ascii?Q?6+qXgIrZAfdrS83c8pXqTNrwDjYGYQwrDDQPB3KW7jbUf5MTx6uCqk/0WyUw?=
 =?us-ascii?Q?j/LuTJOXEWM9OzTS6bJm3EqTF4Uwa15IVcmzRvtR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fc453f-ffd3-4aed-f908-08dcb128785d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:35.7576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piw+4FMIQqYeMdj9bxkXVURz5OZtpHSpUePSq5kwRJqNu+Pdh//H/srJLQFonLqfLrUATMQvUfHWBYTSWLfLjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

This adds the 'Select' method for Broadcast transports. It's role
is to change the transport's state from idle to broadcasting. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is broadcasting.
---
 profiles/audio/transport.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0a890c0ac..bf2215a0f 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -972,6 +972,9 @@ static gboolean get_endpoint(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data);
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -984,6 +987,8 @@ static const GDBusMethodTable transport_methods[] = {
 							{ "mtu_w", "q" }),
 			try_acquire) },
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
+	{ GDBUS_ASYNC_METHOD("Select",
+			NULL, NULL, select_transport) },
 	{ },
 };
 
@@ -1302,6 +1307,25 @@ static void transport_update_playing(struct media_transport *transport,
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+
+	if (transport->owner != NULL)
+		return btd_error_not_authorized(msg);
+
+	if (transport->state >= TRANSPORT_STATE_REQUESTING)
+		return btd_error_not_authorized(msg);
+
+	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)) {
+		transport_update_playing(transport, TRUE);
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

