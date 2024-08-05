Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA1156F48
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859495; cv=fail; b=FP8LnfVHw8IiQOpt8h/3Goax3h5JTXEZH8t5nQOc1/Y2irQJTVDkujIV1cayYiiBBODkH6abnTds4nad4bsASAQ5sgWZOIWaBkM8r1hn8q6YqSO/JmEe0p/wl6TjCWpcHP5QdjL2f3nLYh4f9Zud6/fqiinQ02sVOcpCTUW3+bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859495; c=relaxed/simple;
	bh=j6gvTI+bJ7k28rh2d+w6H3NeCpw1RdhIy3vtUIiMYgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZMdrN7FfS2jR+D5JWUSwbdsQlFhZY/Zf90G0eng4PdEZLNjLziOrIpVr4Wwo11HsYk2PIgQS+MG8rFTgRL1xVlVqAwgWNoAJwuG5hEl5fMVLDNSlo6oTZl59T9U8424eXlZ3aGk5XBE3SNI+ssvJ7fY+r4H9L3Acez1IGdwgYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TdyHKZfs; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TdyHKZfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hVDrLpRKZhWyPOCt/6+vv4E/MOI86WCl9iQZkF1RY49tyQPPY8byzF9q0HhnRpIE7xMvNhYQuBb8UbIl5BZPptOSOAFqGiQOeQoDsmxFXMWcMXCCtL/t4PtUbKoNIs/TCm3/lg9uSK+h40opLcmfBcW59wAyAxwBWRzgp44T7L3K2nMZ8S2Z3li5RtzGTDPTL+QUuVzeWgcylG9o61+St2jks1GNAVN0lD+T2Qmjh/u0jlQzZMFlz4EWjlK0eXb8fbpFV8PLnBEzmeCbfWbo9BRJqOyE2B1xt3zJ1wIHaTnHTpzbpjXmBrLDrF9jF2volJhJBGaFqwQJwOUkpOQqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zrpot0YDEBBZnfYFkguLklbCwu1oOwLX8hRdLNVMRKk=;
 b=MYEztRpdyR+KRMcZUWKLa2/rax+mBlCWmZhn93DDW6/Ql9tz1eh2Xa6H+AiX+irLwv36xKidGaSUR5LDh9jDXMEPyHwqsvkGWtc3OvzHmtO5uLIpPUuXOYGSwVPGtuoZcXw10H9V6WIV0ijV/yeNAjh7gJ1D3vXI21egdNVPADjNPLxyiDkcbJe5+LXY2IfJFPw5FC3E+6flno8iUGinc/sderIh0JFs8xZGNAYvz6qBwN62h+kB3PalIVhLCMfjtRUu+/1T98sx91nlsG65hXATt+a7OMBp+aef9+0VI+EABm/fFXUF3SxPguSjbIbcsEmcSw3kxlM1rrdLdIDFvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zrpot0YDEBBZnfYFkguLklbCwu1oOwLX8hRdLNVMRKk=;
 b=TdyHKZfsltFWNh5nbl+6ZtxUlhYqRCZ71a5fq2cR2aQWovbNfAcWMEqHFa3nkijPZwNgtEHkxX+EIrHF9qSogLu07dTrjtqbQGlpD7UCHpanBRdUIKOqxhBVuPbnlEBiqnsYaQzxwOBBQw0OrJJEhikb2u7IVdzaXVkC8Q9TPlX5mn0NZBNRxghT70d97myaqwHCloYfeYnuic/PDokyBoAGOe2mGn6/y9llHFORcyOVvLKZLlW7DRP5VtABLEcdjq/As55CRcq7jbNpigeth9f4L1iRQxgMWlp0PKgk0SyCFtldBfaKQRmQY6wAHav4ECJkasGWkb9Xjdd3QWDb5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:04:51 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:04:51 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 6/7] bass: Implement MediaAssistant Push method
Date: Mon,  5 Aug 2024 15:04:28 +0300
Message-Id: <20240805120429.67606-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
References: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::8) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: ff44e418-7bdc-48e6-29dc-08dcb546cfa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RmaCiGLDhvFzZ4YzBpSa/+jFHNF1JmnJszYlxK+KfVUlKxheMhEXYNVs+Qkp?=
 =?us-ascii?Q?CoNalOohvg60v9c8LPaFnaKupdZUYtyOVGWeGVzkeEHxs+Vq5TskjE6ddyOQ?=
 =?us-ascii?Q?dbXKmhLnKhUFSKwCGotRVVoEUAxTIBk8EuRqzggkJtVPGRhCUe2CYnmUEHTC?=
 =?us-ascii?Q?o2IniSVhHn3oVACrRnBzZS8VG3mEcze4AVenHTSiyS53KpRvH16bRiL1ytM6?=
 =?us-ascii?Q?/+UdbGfDMk2Fm0+BL0rBOSfjFBYYCrlmZPPrux4namlQ/O8FcWTXT04VJ3ZO?=
 =?us-ascii?Q?uD2Z/taLqmzwivKkIRL54L2s0iGCme+TXJCl0S+zMwoPq5OP5JqKN+p7ncz3?=
 =?us-ascii?Q?l1MDV9ANrUu1yg6I8620MBmVRBPjfeicaHhLNCUXAfV8pz6S7W5B3yb4unFp?=
 =?us-ascii?Q?eYWxVdTbmqRZ8Ur2unmi2SvWAUK3vJnUI0FVCsMm4Vabsx0eUWTQi8pqDyFf?=
 =?us-ascii?Q?NS1ScXxICwErohY81Lz2FnLisIaYKhHNIqr2n45jcBsZ1gduqzs3WyBytvTt?=
 =?us-ascii?Q?jKOtdfmARbOJ33pULPSnPV34ReEl3IqbS5HifWYGIRgk+Al/O9aj1b2b9sID?=
 =?us-ascii?Q?pP7p3dSnQRmVBtpXSCX6eN4MdUXsgl6dAUc6QayiTZLq2b7vUdT4HNp7zUoZ?=
 =?us-ascii?Q?8N25yaIDBJ8NQYatlnvB0sgErViSR/DYO2txy3nNslssj1No6wAXhBwBU4eM?=
 =?us-ascii?Q?njMdC+OyY2D3xtOTSM/FMcm2sRqMNoGmQBuOxjjE0MEVuQQwsPhYPsaWqMXP?=
 =?us-ascii?Q?5TQmIQ+VJFbk3/qlY4yP7yMm6OQFpN3rL8l4McDPnzUfH/AuZSff1v/s4rof?=
 =?us-ascii?Q?2UTRmvbzY4o9ZFjZJypsBbfc6tLOXI8tqATFih7yaSkb5tGX6FwAOilMVAK9?=
 =?us-ascii?Q?TMVpTjbdyA4o3y62maRzhFVoQiGA/rBG60UxQxwPdVHGcblKJV0/Hs7uFdGa?=
 =?us-ascii?Q?z3p9B+ZkmsntpfY85kaBZWx/1ZjRxDEiPQ5IaCOHglwDwMXF9swFij7hcKmT?=
 =?us-ascii?Q?ej1gnXHxvcwagg8KfI8RnvylZPOVvgX5CU3ajtCDBZyP9dmaupEJx9Wan2Tt?=
 =?us-ascii?Q?52hxMidrHnS4SgzqMeMWgswVIWF4F9YqnCl6A0nDbYrZRv/c8vqCQTyPz49N?=
 =?us-ascii?Q?XEm8E96FvZnHqSk1LG78JrAFcy/w4DL50EDTXtVZMBoKB/RUH1y+vVxTFwFH?=
 =?us-ascii?Q?sOsfLj+2bfC0bZink+yT1cWXN0Tvg7aZPxx5mv+ILO1RbCf0eEKCXuD/CXqb?=
 =?us-ascii?Q?78PHsQBcebwppce3oF1hdXS66AIFFb/s68KOQi3nPr0GU9qB1XwveKA7ayah?=
 =?us-ascii?Q?WK5oC1Cfv0Gx7oqvpfgWP6TQD3nW4N8D2B0EolJUDfRlsg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2eAINssomf6409Wpc9cufOVdGe+XgoO2DeH4ODAS6UPRTygKmg0hdoKbcWej?=
 =?us-ascii?Q?qQtiEt7ZVRbmKvX6lFrNnb1KSCHrddbbv6T3cziNstbTMT3FuejvZj1hdTfe?=
 =?us-ascii?Q?JgqV84Y1iNsQ8SLCOWzt0fMTAKad0fAPTdWxK5iJ+8S4tAg0mvAp+h8kS1Dq?=
 =?us-ascii?Q?iiKrnDKYeth0fJw1t/0eVL9ur03Nje/mrey+YhSXU83pqxmZAJ/AC09p1PlQ?=
 =?us-ascii?Q?7dhXIACO/RyAK8TyTdvHp2mniK7Y3hqcilC9lAf5hz24sv8Hqi0n2WpWONiK?=
 =?us-ascii?Q?4jT4kpTJL2G8J8YGCdHCY32h29xtUKV9TVs1sABep0asOWsK/mpGyw9guJMj?=
 =?us-ascii?Q?nMgYgaZw6Ee+9fW+bOtUuxifs/94EQAxH+LBfe6/afXTX/6sNIp6KunfPBgP?=
 =?us-ascii?Q?7SW6Y+uUFrFk++NxVxNKT7zc1ABiThgiCeK0hBYyUCFOIsbZdTcjGV378xFQ?=
 =?us-ascii?Q?k9DQmVzzhOiJdx+/wOpxPL+HDSyDkF41ADJUnIXkF7vPiAQUY1iXlXLAKzhj?=
 =?us-ascii?Q?KHu7VP8c2acL5ZwyvoL86PQInALG1YnK4HWRfEX/EUuZilMYHSN0vvBu2PqW?=
 =?us-ascii?Q?h8XJ+0ft3FkGesCfrMahKWiGHT04uXYji5tN42++FDVgXhjZHW7GHUCVsU+U?=
 =?us-ascii?Q?9Npvrx+FdX1G2gtn32PWPD5wPwONWRIm5gB22Akt7wuRsMcFUMC+EdSxFunL?=
 =?us-ascii?Q?/6baPNRJMVH3Cs30OPprxzimL9F2l/lH6sI5XnWpdLd9b68yb1l5cKgW4euc?=
 =?us-ascii?Q?RR4vlPEjCFmRlCSDhDtXU6FjVrSed8KQ5t+lOpaq4yXbohkmYNe5SrmnuICr?=
 =?us-ascii?Q?spqEmrhq+0m4Yz9kXZlZaSQTQuu9SXlJmC5srV2e2uX4PFL0z8FbqZwH+gQR?=
 =?us-ascii?Q?hFM409F5b7goQ8Ch/csnb9YL5+c2DHswUuPEagGEgj+PlkNrL5uDMmgoIpqX?=
 =?us-ascii?Q?Z3IYP62Ssnfc9UYzFWplpy01NRroDLiMdCQdjds8CLFtWxhcc0i1cam/UOXp?=
 =?us-ascii?Q?S/G9RXNkEHLOUUNG1rwyhC4ZfxGT+MlWtKWcPwMuKK2e1exPmCeMq61eLoj2?=
 =?us-ascii?Q?DMLloS/M21lTTiMhVXyNzd3jQy2IbrIAuN0RnHVd6PQGt93s/dFYbebLsCfb?=
 =?us-ascii?Q?9BB4hxpdmYSZFuwgOIaItYLtiPZpN0LL/OPPYXtr2jtCdi/GoOfIUZa6KVVf?=
 =?us-ascii?Q?tKGKqjtU5zYLgu4CD8OhGvIU50F1wMYKs+FJIx94TY/ikNGrpMnRkroWLujx?=
 =?us-ascii?Q?YE6ZFb0xxpex9rCI/XeORTHzta+VjAFzNuczcpf73S9RdVffdRI5z6OE/lsZ?=
 =?us-ascii?Q?4TDa/pBAj06B0YdBtEUME+SE6jXWzaPlNuLYnXXVcB6IAAl93e7tnY4ZRJh1?=
 =?us-ascii?Q?yr76TmRopiOaABwaK1VNQ8cEtgRIgHzOKae6bJxx96r385zkjvq6eyV7qY7P?=
 =?us-ascii?Q?XQG8VUhWZOa6EGSxjRaQ4xbM7tm9UFira/nSPGD//KU9yfOpW/ws7mylcHLG?=
 =?us-ascii?Q?sM3R0qDB81GGhakBcLHfABH3ZZICZaAXVrnmV5tryr449UcSjmSukpBMDnnQ?=
 =?us-ascii?Q?8R7TkhfkfhbQV4MsUrDPFK0KTTTNV0iO7di94uvSuLOdXPsbb8iyKigpCghN?=
 =?us-ascii?Q?PA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff44e418-7bdc-48e6-29dc-08dcb546cfa1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:04:51.7022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gJ9qN6/V5iqsHkMk2MKBJzsvYRyZyhRLS+EbY0QPamBenIn2R9DDOVejbI73mMXuZx488g9WeqxDwsSYJtb0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

This implements the MediaAssistant "Push" method, which sends a GATT
write command for the Broadcast Audio Scan Control Point characteristic
with the "Add Source" opcode.

This also registers a callback with shared/bass, to handle GATT
notifications from the peer. A MediaAssistant object transitions
to different states, depending on information received in the
callback. The callback is also useful to check if the peer requires
a Broadcast Code to decrypt the stream - in this case, the Assistant
uses the "Set Broadcast_Code" operation to provide the code.
---
 profiles/audio/bass.c | 295 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 295 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 795b4b80a..b3740f64e 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -70,10 +70,18 @@ enum assistant_state {
 					 */
 };
 
+static const char *const str_state[] = {
+	"ASSISTANT_STATE_IDLE",
+	"ASSISTANT_STATE_PENDING",
+	"ASSISTANT_STATE_REQUESTING",
+	"ASSISTANT_STATE_ACTIVE",
+};
+
 struct bass_data {
 	struct btd_device *device;
 	struct btd_service *service;
 	struct bt_bass *bass;
+	unsigned int src_id;
 };
 
 struct bass_assistant {
@@ -92,14 +100,206 @@ struct bass_assistant {
 static struct queue *sessions;
 static struct queue *assistants;
 
+static const char *state2str(enum assistant_state state);
+
 static void bass_debug(const char *str, void *user_data)
 {
 	DBG_IDX(0xffff, "%s", str);
 }
 
+static void assistant_set_state(struct bass_assistant *assistant,
+					enum assistant_state state)
+{
+	enum assistant_state old_state = assistant->state;
+	const char *str;
+
+	if (old_state == state)
+		return;
+
+	assistant->state = state;
+
+	DBG("State changed %s: %s -> %s", assistant->path, str_state[old_state],
+							str_state[state]);
+
+	str = state2str(state);
+
+	if (g_strcmp0(str, state2str(old_state)) != 0)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						assistant->path,
+						MEDIA_ASSISTANT_INTERFACE,
+						"State");
+}
+
+static int assistant_parse_qos(struct bass_assistant *assistant,
+						DBusMessageIter *iter)
+{
+	DBusMessageIter dict;
+	const char *key;
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	while (dbus_message_iter_get_arg_type(&dict) == DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+
+		if (!strcasecmp(key, "BCode")) {
+			DBusMessageIter array;
+			struct iovec iov = {0};
+
+			if (var != DBUS_TYPE_ARRAY)
+				return -EINVAL;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array,
+							&iov.iov_base,
+							(int *)&iov.iov_len);
+
+			if (iov.iov_len != BT_BASS_BCAST_CODE_SIZE) {
+				error("Invalid size for BCode: %zu != 16",
+								iov.iov_len);
+				return -EINVAL;
+			}
+
+			memcpy(assistant->qos.bcast.bcode, iov.iov_base,
+								iov.iov_len);
+
+			return 0;
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+	return 0;
+}
+
+static int assistant_parse_props(struct bass_assistant *assistant,
+					DBusMessageIter *props)
+{
+	DBusMessageIter value, entry, array;
+	const char *key;
+
+	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
+		dbus_message_iter_recurse(props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		if (!strcasecmp(key, "Metadata")) {
+			struct iovec iov;
+
+			if (dbus_message_iter_get_arg_type(&value) !=
+							DBUS_TYPE_ARRAY)
+				goto fail;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array,
+							&iov.iov_base,
+							(int *)&iov.iov_len);
+
+			util_iov_free(assistant->meta, 1);
+			assistant->meta = util_iov_dup(&iov, 1);
+			DBG("Parsed Metadata");
+		} else if (!strcasecmp(key, "QoS")) {
+			if (dbus_message_iter_get_arg_type(&value) !=
+							DBUS_TYPE_ARRAY)
+				goto fail;
+
+			if (assistant_parse_qos(assistant, &value))
+				goto fail;
+
+			DBG("Parsed QoS");
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return 0;
+
+fail:
+	DBG("Failed parsing %s", key);
+
+	return -EINVAL;
+}
+
 static DBusMessage *push(DBusConnection *conn, DBusMessage *msg,
 							  void *user_data)
 {
+	struct bass_assistant *assistant = user_data;
+	struct bt_bass_bcast_audio_scan_cp_hdr hdr;
+	struct bt_bass_add_src_params params;
+	struct iovec iov = {0};
+	uint32_t bis_sync = 0;
+	uint8_t meta_len = 0;
+	int err;
+	DBusMessageIter props, dict;
+
+	DBG("");
+
+	dbus_message_iter_init(msg, &props);
+
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_ARRAY) {
+		DBG("Unable to parse properties");
+		return btd_error_invalid_args(msg);
+	}
+
+	dbus_message_iter_recurse(&props, &dict);
+
+	if (assistant_parse_props(assistant, &dict)) {
+		DBG("Unable to parse properties");
+		return btd_error_invalid_args(msg);
+	}
+
+	hdr.op = BT_BASS_ADD_SRC;
+
+	if (device_get_le_address_type(assistant->device) == BDADDR_LE_PUBLIC)
+		params.addr_type = BT_BASS_ADDR_PUBLIC;
+	else
+		params.addr_type = BT_BASS_ADDR_RANDOM;
+
+	bacpy(&params.addr, device_get_address(assistant->device));
+	put_le24(assistant->bid, params.bid);
+	params.pa_sync = PA_SYNC_NO_PAST;
+	params.pa_interval = PA_INTERVAL_UNKNOWN;
+	params.num_subgroups = assistant->sgrp + 1;
+
+	util_iov_append(&iov, &params, sizeof(params));
+
+	/* Metadata and the BIS index associated with the MediaAssistant
+	 * object will be set in the subgroup they belong to. For the other
+	 * subgroups, no metadata and no BIS index will be provided.
+	 */
+	for (uint8_t sgrp = 0; sgrp < assistant->sgrp; sgrp++) {
+		util_iov_append(&iov, &bis_sync, sizeof(bis_sync));
+		util_iov_append(&iov, &meta_len, sizeof(meta_len));
+	}
+
+	bis_sync = (1 << (assistant->bis - 1));
+	meta_len = assistant->meta->iov_len;
+
+	util_iov_append(&iov, &bis_sync, sizeof(bis_sync));
+	util_iov_append(&iov, &meta_len, sizeof(meta_len));
+	util_iov_append(&iov, assistant->meta->iov_base,
+				assistant->meta->iov_len);
+
+	err = bt_bass_send(assistant->data->bass, &hdr, &iov);
+	if (err) {
+		DBG("Unable to send BASS Write Command");
+		return btd_error_failed(msg, strerror(-err));
+	}
+
+	free(iov.iov_base);
+
+	assistant_set_state(assistant, ASSISTANT_STATE_PENDING);
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
@@ -381,6 +581,8 @@ static void bass_data_free(struct bass_data *data)
 		bt_bass_set_user_data(data->bass, NULL);
 	}
 
+	bt_bass_src_unregister(data->bass, data->src_id);
+
 	bt_bass_unref(data->bass);
 
 	queue_remove_all(assistants, assistant_match_data,
@@ -453,6 +655,93 @@ static void bass_attached(struct bt_bass *bass, void *user_data)
 	bass_data_add(data);
 }
 
+static void bass_handle_bcode_req(struct bass_assistant *assistant, int id)
+{
+	struct bt_bass_bcast_audio_scan_cp_hdr hdr;
+	struct bt_bass_set_bcast_code_params params;
+	struct iovec iov = {0};
+	int err;
+
+	assistant_set_state(assistant, ASSISTANT_STATE_REQUESTING);
+
+	hdr.op = BT_BASS_SET_BCAST_CODE;
+
+	params.id = id;
+	memcpy(params.bcast_code, assistant->qos.bcast.bcode,
+					BT_BASS_BCAST_CODE_SIZE);
+
+	iov.iov_base = malloc0(sizeof(params));
+	if (!iov.iov_base)
+		return;
+
+	util_iov_push_mem(&iov, sizeof(params), &params);
+
+	err = bt_bass_send(assistant->data->bass, &hdr, &iov);
+	if (err) {
+		DBG("Unable to send BASS Write Command");
+		return;
+	}
+
+	free(iov.iov_base);
+}
+
+static void bass_src_changed(uint8_t id, uint32_t bid, uint8_t enc,
+					uint32_t bis_sync, void *user_data)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(assistants); entry;
+						entry = entry->next) {
+		struct bass_assistant *assistant = entry->data;
+		uint32_t bis = 1 << (assistant->bis - 1);
+
+		if (assistant->bid != bid)
+			/* Only handle assistant objects
+			 * that match the source
+			 */
+			continue;
+
+		switch (enc) {
+		case BT_BASS_BIG_ENC_STATE_BCODE_REQ:
+			if (assistant->state != ASSISTANT_STATE_PENDING)
+				/* Only handle assistant objects that
+				 * have been pushed by the user
+				 */
+				break;
+
+			/* Provide Broadcast Code to peer */
+			bass_handle_bcode_req(assistant, id);
+			break;
+		case BT_BASS_BIG_ENC_STATE_NO_ENC:
+			if (assistant->state != ASSISTANT_STATE_PENDING)
+				/* Only handle assistant objects that
+				 * have been pushed by the user
+				 */
+				break;
+
+			/* Match BIS index */
+			if (bis & bis_sync)
+				assistant_set_state(assistant,
+						ASSISTANT_STATE_ACTIVE);
+			break;
+		case BT_BASS_BIG_ENC_STATE_DEC:
+			/* Only handle assistant objects that
+			 * have requested a Broadcast Code
+			 */
+			if (assistant->state != ASSISTANT_STATE_REQUESTING)
+				break;
+
+			/* Match BIS index */
+			if (bis & bis_sync)
+				assistant_set_state(assistant,
+						ASSISTANT_STATE_ACTIVE);
+			break;
+		default:
+			continue;
+		}
+	}
+}
+
 static int bass_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -485,6 +774,12 @@ static int bass_probe(struct btd_service *service)
 	bass_data_add(data);
 	bt_bass_set_user_data(data->bass, service);
 
+	/* Register callback to be called when notifications for
+	 * Broadcast Receive State characteristics are received.
+	 */
+	data->src_id = bt_bass_src_register(data->bass, bass_src_changed,
+						data, NULL);
+
 	return 0;
 }
 
-- 
2.39.2

