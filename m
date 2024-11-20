Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A288219E98A
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098399; cv=fail; b=h9/PVFmImvsK65ek+ShmP+4+oF5s5aSvrWbnOXExxiIxOPbjA168/+nNfJaqFdwJdrzUJj3fy6mJi1cpQiZixRKMq4JJ+qQZa7KIn7NOSlM2fYFAOkE54N/2ApXUvh/mwr4be+RfxNZL74Q6yx9s+ac+HJSfwKrUwx8VdXmxGwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098399; c=relaxed/simple;
	bh=/qtdb8Jj+FeNXQkzsoW4XXimA5WwS1bg1uZ9qbs9z0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S7+uy7PUH0JtwdlB0PxTK4eDEKakC+qSx/WTaZKMP08zR7UjAergeVpmPKRQQoS9XkYUZtMRfoZzRCzcfHNWhlokilSvGVzsnu5ryk9jk9yISbf9NNprE+ZVb5b58iG4eWd6BQSSLAwQH4OasLb13tui17k2c0/CZH9I+L/SgSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CvBp3p7m; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CvBp3p7m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWU8oJUy1AjDAhs6B+B7Tg1bOxKHa5e8n+c0HRAi6pY6scpeamtwjUUUFMLmzXOj/qWYXyuYEbMV+TVnlhikzjOIkpu8wJqfEtgLVlu8GLEptSe6deEPkoDRNR3PLaXFXq7KrBy2jSO4yVe/DTXZs0cI3EWPKP2pdbWwkMni4oKTrLovDn/+ywhfx/Wb7yhqsLKYVZQvk/10hUtBcl2k6HIZEpNitzpOAU7gTVkVL0dIkKotQ4/oID1N4VklC7prNqHaUXEJGbijT2i5xhb9doCHccfPHwWQG8HAkmbCwRV46WZybSybLyvuzBhZ/hRZRgF2KVT9jeTV+9Tl78J0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SE9WXiwQiItu8YcH8Gj04h82IGMYG4+RXgf35ae022I=;
 b=wqRq32TGp3EgCR1mU01XBxOykGUFTj/ynkVANhd6Gue6kW5ALrGtA338tGd4sCw4xzELkAsmD7hqivX28uEb3I1qqpbIPpiNIA4v5+zjW/Q5zc0jmwV+M0/oUEMEWFc6iU25CMS0Celno1eF1sucPVdbbYj/5zAazuhOObEfOge3QKbi5i57BB3qJxf+RbwAwLzVSjS8NKiTr0+RU2vaXNVD7Rda6QtvqKCnwnBLETS4XJ/qsTLZnNsNGpUnIfDsUzBaBYdvqdYSxVx9USFHzD1Cw8VaQ07mOXo8K3RbwhrSoOGLhrny/n12JPLY36I2JunKDrmaKOxj6nN8lABQbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SE9WXiwQiItu8YcH8Gj04h82IGMYG4+RXgf35ae022I=;
 b=CvBp3p7mC1sr2bpDrkfkqbUbzhkCs1NXDbi9m79pvLY+7UhPmYIjc4TANNe0TGyw6NDDa4kL+vmyrGXGaCcDrBwW+pv0W0kz2G7ISd67Nilq556DvOOcrAVCCjwFk/be4/OrsBk0Gq+uxhbNbVP+71XQDZ7AeCS5qo+uyOFP7e63svpeEkwzhZgUyR48M5fGw30KhyWDIwl2NRmQvc1U2VwbNbtOlSIeo5cqT/FqZHv5tMe4igvJD5QkHkyYP4GwWfyVbbd+lFwSHhZJTdvbkYz2zBr1MmT3t9tSs4vMJ9RVak4NHUnoGGjK+Sz7MOTr+52ybVqMRUR65qSMAX7eag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10389.eurprd04.prod.outlook.com (2603:10a6:800:217::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 10:26:34 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:26:34 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 7/7] bap: Remove PA idle timer logic
Date: Wed, 20 Nov 2024 12:26:01 +0200
Message-ID: <20241120102601.38415-8-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
References: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10389:EE_
X-MS-Office365-Filtering-Correlation-Id: 441f4d00-e4b3-432f-c7cc-08dd094dce98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VRRJXkpi/q9Jh0AoncUKZGeJMHhMs6hSCZZ8L6sVUG6yt9uJcz1p+AFJd/eI?=
 =?us-ascii?Q?GYr3lLagxU3QkSNERfwFmXO4Tv6ZsEmkJQ1RHVtbixVZzDUyaP1T1/e6n+V4?=
 =?us-ascii?Q?8Cf6zPM1jTUFBhglEQWgDs+o3bqjysygp08Y5M1O9jnB+lkHMnv7ZF6Ibnac?=
 =?us-ascii?Q?J53Tn6h6kJyJkkqFDtBVji6+IVFiE14t7Z/jgXHj/XKAXnbGyAoxMBO8RRUw?=
 =?us-ascii?Q?SGwc7YImyv+IMXMcd//SbDJFsvOr1laNE8Uehbu9VuC2IRQ0K7Pmroy/Xad/?=
 =?us-ascii?Q?BQVcqMXMU+7IiT8FjymvG2PqasRHjdt0FU7dzU3JgQWz5aua3QvK8nxprKRc?=
 =?us-ascii?Q?HyPzoQzmKeH6m7mcDRvNQn1I7YS2Eq0hlUcUD+V5/XeKPnFfpIcmCKH4meED?=
 =?us-ascii?Q?PS7khq1Ndjfl4HWn5BIpSJUaibujhv5AFptjFi1L707GrrNGnhurdFpTzXHq?=
 =?us-ascii?Q?3ySoObwLPXpgEYpBvwPvsYaEpNuaST6rTZed+MzNDI63s+N454Zmv3eFRM0P?=
 =?us-ascii?Q?FpYSKSRcefx0g2V8JCALtzGdkhBk5qNxVW85zFnwYCN2zUORRZ0h7PqtLV2R?=
 =?us-ascii?Q?KB1NyON9Ip2YzwgLapeSNs+lGK55eDlqBocy2ttdW/2Vggiyk8fjbXt7bvdF?=
 =?us-ascii?Q?H4Tq4og+oOrm2dRRiKLQtXWRvh4YHBtGAsAQ1/PdugW6TAPAVM6ItS7n+eIU?=
 =?us-ascii?Q?x1ZrB4dBb4lg6sXW8tucjhF/uj9rvxf7dY2v3YpRlgQ4MF8IhiMRwv6zfJqJ?=
 =?us-ascii?Q?bZJUHvmTPXUJNIoxwUuqEXsP94uJGFBsz9f/6BlkDW+CndJGkP2Xwfh8fYtj?=
 =?us-ascii?Q?5TG9UcpMZbCkfNOANt/e7o17rhc+uW0FERk0pwXHLtzUu9kDtLfHyfMMqgNF?=
 =?us-ascii?Q?Czn0NFZdtKTM7TGuyAT+WbCNkuzkjumzO4VbfH15X5w94odee46ofFohdw6I?=
 =?us-ascii?Q?MHiM8bVRZSiU5y37nFt/BuQWqRgf9XiHypTPYOVEgpN33juBKfkeSyOOh+HT?=
 =?us-ascii?Q?7rR9nhDxx9TjoB+wfCW0VJzb28HZgr8n0sLSuG/JYItH7TeveH3jjrUVHAoM?=
 =?us-ascii?Q?QA+z8ri/0DwmBVcQuvuKqQ9ZSuSRxcwmhyGpepDd50ivo3eMo3zXf0uBW/Ab?=
 =?us-ascii?Q?vMjWR8/1jkzvOFA7TmGMlP4til3F8DbuU8jaHsmvMKPGsFmqD+8orjWrTVyj?=
 =?us-ascii?Q?PGMG1J5/3dl/mZCwxH9z1FT5UrvnHOqzUxaoDW0/fxPp9TIWykwyUX+hjL5j?=
 =?us-ascii?Q?So/MBs4hhD1TZwDMKqv55Qx2RXgeCgYAFAVRN7uGVF/uqgli5tXe8L6ckSNA?=
 =?us-ascii?Q?27LK3O1AYWX9E7ZbXM1BrmZh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LnSDJrxQNY+ZM5qznpjVFE4+EJMsS8V1d/KLGJYxNsZr8Q/JBvmTiv5CyfJe?=
 =?us-ascii?Q?dCuemML8g8UAkBKgRLp5jUamb08JsMrPDhcqWalTjJFJCQYGe9cuaWIK/dKZ?=
 =?us-ascii?Q?/tYPxsLi7b+JUBvAKLbXVhjznP5FyK32bJtWE5hl4OrMo1naHitQ6NuGKr61?=
 =?us-ascii?Q?Vb7ZiFcNFxK0HywaJ3Ccq9Das/sEHAFZDH9METdPV9Q1NTYs7zShD/1cslBN?=
 =?us-ascii?Q?MYdzP6nin4fYkSfk3LJpyp8pB4zozzSAUGsOBbN3lz/3LJ10LHOctSMtR1N1?=
 =?us-ascii?Q?4sz7I75euYkCovpqUniKWoEom1QmI65CQZfDVs+LNpcxlHDm0s7+2pO0U0th?=
 =?us-ascii?Q?t+7fp3zwPHrs4/rgsyVKsBRiAvmHmn9NHE9QZG2n8rKgJzct5pei/7n7N23s?=
 =?us-ascii?Q?GMmSrl+Fu4qsFjo7Pb34PI2CYqdRKrROZDJIJ2zQ7KMn7AyLOd5fWYZ1K7xP?=
 =?us-ascii?Q?rZ63yvAOWWpwZpDFOHnZuKmlAbJw8ImAjo0dFptdYk1Uacco0lV6126t6weS?=
 =?us-ascii?Q?7mcrk1CXEdFt1emCP0vw0C5eCo64zMS/RaIHotp3U2ojlcbI53IaWvyK7Qn1?=
 =?us-ascii?Q?Bz8ZMHFauEZWrD3q47xQYjia2sEtqch0hx8p2t9O81gGo8m7pfFPTjpPSrJ+?=
 =?us-ascii?Q?aNtC3mFioa0aQkDOP7XYy6vHmUINbbjvOznfSoKOgONhm9Yb1YfIuFO8dO5Y?=
 =?us-ascii?Q?6DajaMFTGERRkc8iwjaNMbT8c1Q5fEAbk3kIshZ4jy0xRN1m8W0dEEf1Nr9M?=
 =?us-ascii?Q?thCwiwKpD+iAfj+vIpjVW86cyvMPcPyABzVfr8eGzI3/Pdq3QdQsNSp0o3pE?=
 =?us-ascii?Q?VXaWUZ5SUYjUVs8tbQn1N2EXh1zuWVe/LFNvxH9R4AY1QHWhJFa/rwbLBNCk?=
 =?us-ascii?Q?LstMSkx6iuhMrnAQFqhLeNCTvhHGTxb9MjWY+gpl85sCajY7E0IQYk4RIpgw?=
 =?us-ascii?Q?67i858fat9Qpj+RYm5DS3IzCWO7MM4oFNdCc+3t6/kCUMGa8eFfucDRpoNXr?=
 =?us-ascii?Q?dua0IIZGsj/r4anXKK+HH5rVWVq7ygmZUKnzuFoVACP2yb5oL7gjkfTROYLq?=
 =?us-ascii?Q?inafuxLqW5JvsWTsnZRZZx+kDIrAKHpSoAr/KpuMPXcATfjUpynVSsfMC29Z?=
 =?us-ascii?Q?2wdsrpzFW0jZK0dBZA067yUMCbeBJYtMvYJaPR6rWPk1z6Zy6J325LQzsjPx?=
 =?us-ascii?Q?OHXQy+SOgRKz6rsmieM4OxzrXbhxUOA2/cHrjhqhLOd8ewKjPIF78+ycLvkO?=
 =?us-ascii?Q?mnVTZotKV8D0BC8sU62TArVD7Hy9MRvVDB3IC9ktF8gojMeOjfoq+7exRGj/?=
 =?us-ascii?Q?k8AAilgW6kQXa4AZFyuYetF/85QZyZNAlzpwOgimTePs5o6+kaIAgk2RJgHK?=
 =?us-ascii?Q?KsIApAD3kHBpR4PNJWaVGTTtM1ZIT6RwS1Vh4fMTbgqqLKvy2QlMHNElxo/8?=
 =?us-ascii?Q?IHb/MNylF2qCgjnF6FvfZcLrP6Ag1WQxkG9Oa03HjZgu2dtP++Mic7oBkslg?=
 =?us-ascii?Q?GvA61IR/SlqiwxTJjLFFjmeBZyhmyy7B9qLfTw09t9aVZHC3R1RU1h4Qo1/B?=
 =?us-ascii?Q?lLpFFx83NSwKr1Kj6T8pvDad9B/ZdEG4XlTaHPG0UawS1VZFTxoe5bM2Hkla?=
 =?us-ascii?Q?EQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 441f4d00-e4b3-432f-c7cc-08dd094dce98
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:26:34.2856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fG+3dWkUZkW189ZpGvOymNRZ23Q2X8ZYMafoznPP+I9FKQu/5my4ajpOdMfA1M1ws2LEJd1GchD6A0eah79MIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10389

This removes BAP support for long-lived PA sync (added for Scan Delegator
support), since it is now handled inside the BASS plugin. This also
removes the PA idle timer logic, since PA/BIG sync requests are now
ordered inside the kernel.
---
 profiles/audio/bap.c | 369 ++++++++++---------------------------------
 1 file changed, 81 insertions(+), 288 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c1111b625..a561c446a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -65,15 +65,9 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_INTERFACE "org.bluez.Media1"
 
-/* Periodic advertisments are performed by an idle timer, which,
- * at every tick, checks a queue for pending PA requests.
- * When there is no pending requests, an item is popped from the
- * queue, marked as pending and then it gets processed.
- */
-#define PA_IDLE_TIMEOUT 2
-
 struct bap_setup {
 	struct bap_ep *ep;
+	struct bap_data *data;
 	struct bt_bap_stream *stream;
 	struct bt_bap_qos qos;
 	int (*qos_parser)(struct bap_setup *setup, const char *key, int var,
@@ -101,15 +95,9 @@ struct bap_ep {
 	struct queue *setups;
 };
 
-struct bap_adapter {
-	struct btd_adapter *adapter;
-	unsigned int pa_timer_id;
-	struct queue *bcast_pa_requests;
-};
-
 struct bap_data {
 	struct btd_device *device;
-	struct bap_adapter *adapter;
+	struct btd_adapter *adapter;
 	struct btd_service *service;
 	struct bt_bap *bap;
 	unsigned int ready_id;
@@ -121,30 +109,12 @@ struct bap_data {
 	struct queue *bcast_snks;
 	struct queue *streams;
 	GIOChannel *listen_io;
+	unsigned int io_id;
 	int selecting;
 	void *user_data;
 };
 
-enum {
-	BAP_PA_SHORT_REQ = 0,	/* Request for short PA sync */
-	BAP_PA_LONG_REQ,	/* Request for long PA sync */
-	BAP_PA_BIG_SYNC_REQ,	/* Request for PA Sync and BIG Sync */
-};
-
-struct bap_bcast_pa_req {
-	uint8_t type;
-	bool in_progress;
-	struct bap_data *bap_data;
-	union {
-		struct btd_service *service;
-		struct queue *setups;
-	} data;
-	unsigned int io_id;	/* io_id for BIG Info watch */
-	GIOChannel *io;
-};
-
 static struct queue *sessions;
-static struct queue *adapters;
 
 /* Structure holding the parameters for Periodic Advertisement create sync.
  * The full QOS is populated at the time the user selects and endpoint and
@@ -219,6 +189,9 @@ static void bap_data_free(struct bap_data *data)
 		g_io_channel_unref(data->listen_io);
 	}
 
+	if (data->io_id)
+		g_source_remove(data->io_id);
+
 	if (data->service) {
 		btd_service_set_user_data(data->service, NULL);
 		bt_bap_set_user_data(data->bap, NULL);
@@ -382,7 +355,7 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	const char *path;
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		path = adapter_get_path(ep->data->adapter->adapter);
+		path = adapter_get_path(ep->data->adapter);
 	else
 		path = device_get_path(ep->data->device);
 
@@ -996,12 +969,19 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static bool stream_io_unset(const void *data, const void *user_data)
+{
+	struct bt_bap_stream *stream = (struct bt_bap_stream *)data;
+
+	return !bt_bap_stream_get_io(stream);
+}
+
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
-	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup;
+	struct bap_setup *setup = user_data;
+	struct bt_bap_stream *stream = setup->stream;
 	int fd;
-	struct bap_data *bap_data = req->bap_data;
+	struct bap_data *bap_data = setup->data;
 
 	DBG("BIG Sync completed");
 
@@ -1009,28 +989,23 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	 * to the order of the BISes that were enqueued before
 	 * calling bt_io_bcast_accept.
 	 */
-	setup = queue_pop_head(req->data.setups);
-
-	if (queue_isempty(req->data.setups)) {
-		/* All fds have been notified. Mark service as connected. */
-		btd_service_connecting_complete(bap_data->service, 0);
-
-		if (req->io) {
-			g_io_channel_unref(req->io);
-			g_io_channel_shutdown(req->io, TRUE, NULL);
-			req->io = NULL;
-		}
-
-		queue_remove(bap_data->adapter->bcast_pa_requests, req);
-		queue_destroy(req->data.setups, NULL);
-		free(req);
-	}
+	if (bt_bap_stream_get_io(stream))
+		stream = queue_find(bt_bap_stream_io_get_links(stream),
+				stream_io_unset, NULL);
 
 	fd = g_io_channel_unix_get_fd(io);
 
-	if (bt_bap_stream_set_io(setup->stream, fd)) {
+	if (bt_bap_stream_set_io(stream, fd))
 		g_io_channel_set_close_on_unref(io, FALSE);
-		return;
+
+	if (!queue_find(bt_bap_stream_io_get_links(stream),
+				stream_io_unset, NULL)) {
+		/* All fds have been notified. Mark service as connected. */
+		btd_service_connecting_complete(bap_data->service, 0);
+
+		g_io_channel_unref(bap_data->listen_io);
+		g_io_channel_shutdown(bap_data->listen_io, TRUE, NULL);
+		bap_data->listen_io = NULL;
 	}
 }
 
@@ -1097,6 +1072,8 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 	/* Create an internal copy for bcode */
 	setup->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
 
+	setup->data = bap_data;
+
 	queue_push_tail(bap_data->bcast_snks, setup);
 
 	/* Create and configure stream */
@@ -1139,8 +1116,7 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	GError *err = NULL;
-	struct bap_bcast_pa_req *req = user_data;
-	struct bap_data *data = btd_service_get_user_data(req->data.service);
+	struct bap_data *data = user_data;
 	struct bt_iso_base base;
 	struct bt_iso_qos qos;
 	struct iovec iov;
@@ -1156,7 +1132,7 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 		error("%s", err->message);
 		g_error_free(err);
 		g_io_channel_shutdown(io, TRUE, NULL);
-		req->io_id = 0;
+		data->io_id = 0;
 		return FALSE;
 	}
 
@@ -1165,18 +1141,10 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	g_io_channel_unref(data->listen_io);
 	data->listen_io = NULL;
 
-	if (req->type == BAP_PA_LONG_REQ) {
-		/* If long-lived PA sync was requested, keep a reference
-		 * to the PA sync io to keep the sync active.
-		 */
-		data->listen_io = io;
-		g_io_channel_ref(io);
-	} else {
-		/* For short-lived PA, the sync is no longer needed at
-		 * this point, so the io can be closed.
-		 */
-		g_io_channel_shutdown(io, TRUE, NULL);
-	}
+	/* For short-lived PA, the sync is no longer needed at
+	 * this point, so the io can be closed.
+	 */
+	g_io_channel_shutdown(io, TRUE, NULL);
 
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
@@ -1191,23 +1159,21 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 
 	util_iov_free(bap_qos.bcast.bcode, 1);
 
-	service_set_connecting(req->data.service);
+	service_set_connecting(data->service);
 
-	queue_remove(data->adapter->bcast_pa_requests, req);
-	req->io_id = 0;
-	free(req);
+	data->io_id = 0;
 
 	return FALSE;
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 {
-	struct bap_bcast_pa_req *req = user_data;
+	struct bap_data *data = user_data;
 	/* PA Sync was established, wait for BIG Info report so that the
 	 * encryption flag is also available.
 	 */
 	DBG("PA Sync done");
-	req->io_id = g_io_add_watch(io, G_IO_OUT, big_info_report_cb,
+	data->io_id = g_io_add_watch(io, G_IO_OUT, big_info_report_cb,
 								user_data);
 }
 
@@ -1262,7 +1228,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac)
 {
-	struct btd_adapter *adapter = data->adapter->adapter;
+	struct btd_adapter *adapter = data->adapter;
 	struct btd_device *device = data->device;
 	struct bap_ep *ep;
 	struct queue *queue;
@@ -2109,95 +2075,13 @@ static void setup_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 	data->listen_io = io;
 }
 
-static void check_pa_req_in_progress(void *data, void *user_data)
-{
-	struct bap_bcast_pa_req *req = data;
-
-	if (req->in_progress == TRUE)
-		*((bool *)user_data) = TRUE;
-}
-
-static int pa_sync(struct bap_bcast_pa_req *req);
-static void pa_and_big_sync(struct bap_bcast_pa_req *req);
-
-static gboolean pa_idle_timer(gpointer user_data)
-{
-	struct bap_adapter *adapter = user_data;
-	struct bap_bcast_pa_req *req;
-	bool in_progress = FALSE;
-
-	/* Handle timer if no request is in progress */
-	queue_foreach(adapter->bcast_pa_requests, check_pa_req_in_progress,
-			&in_progress);
-	if (in_progress == FALSE) {
-		req = queue_peek_head(adapter->bcast_pa_requests);
-		if (req != NULL)
-			switch (req->type) {
-			case BAP_PA_SHORT_REQ:
-				DBG("do short lived PA Sync");
-				pa_sync(req);
-				break;
-			case BAP_PA_LONG_REQ:
-				DBG("do long lived PA Sync");
-				pa_sync(req);
-				break;
-			case BAP_PA_BIG_SYNC_REQ:
-				DBG("do PA Sync and BIG Sync");
-				pa_and_big_sync(req);
-				break;
-			}
-		else {
-			/* pa_req queue is empty, stop the timer by returning
-			 * FALSE and set the pa_timer_id to 0. This will later
-			 * be used to check if the timer is active.
-			 */
-			adapter->pa_timer_id = 0;
-			return FALSE;
-		}
-	}
-
-	return TRUE;
-}
+static int pa_sync(struct bap_data *data);
+static void pa_and_big_sync(struct bap_setup *setup);
 
 static void setup_accept_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup)
 {
-	struct bap_bcast_pa_req *req = new0(struct bap_bcast_pa_req, 1);
-	struct bap_adapter *adapter = data->adapter;
-	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
-	const struct queue_entry *entry;
-
-	/* Timer could be stopped if all other requests were treated.
-	 * Check the state of the timer and turn it on so that this request
-	 * can also be treated.
-	 */
-	if (adapter->pa_timer_id == 0)
-		adapter->pa_timer_id = g_timeout_add_seconds(PA_IDLE_TIMEOUT,
-								pa_idle_timer,
-								adapter);
-
-	/* Add this request to the PA queue.
-	 * We don't need to check the queue here, as we cannot have
-	 * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
-	 */
-	req->type = BAP_PA_BIG_SYNC_REQ;
-	req->in_progress = FALSE;
-	req->bap_data = data;
-
-	req->data.setups = queue_new();
-
-	/* Enqueue all linked setups to the request */
-	queue_push_tail(req->data.setups, setup);
-
-	for (entry = queue_get_entries(links); entry;
-							entry = entry->next) {
-		struct bt_bap_stream *stream = entry->data;
-
-		queue_push_tail(req->data.setups,
-				bap_find_setup_by_stream(data, stream));
-	}
-
-	queue_push_tail(adapter->bcast_pa_requests, req);
+	pa_and_big_sync(setup);
 }
 
 static void setup_create_ucast_io(struct bap_data *data,
@@ -2952,10 +2836,8 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	bap_data_remove(data);
 }
 
-static int pa_sync(struct bap_bcast_pa_req *req)
+static int pa_sync(struct bap_data *data)
 {
-	struct btd_service *service = req->data.service;
-	struct bap_data *data = btd_service_get_user_data(service);
 	GError *err = NULL;
 
 	if (data->listen_io) {
@@ -2964,13 +2846,13 @@ static int pa_sync(struct bap_bcast_pa_req *req)
 	}
 
 	DBG("Create PA sync with this source");
-	req->in_progress = TRUE;
-	data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, req,
+
+	data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data,
 		NULL, &err,
 		BT_IO_OPT_SOURCE_BDADDR,
-		btd_adapter_get_address(data->adapter->adapter),
+		btd_adapter_get_address(data->adapter),
 		BT_IO_OPT_SOURCE_TYPE,
-		btd_adapter_get_address_type(data->adapter->adapter),
+		btd_adapter_get_address_type(data->adapter),
 		BT_IO_OPT_DEST_BDADDR,
 		device_get_address(data->device),
 		BT_IO_OPT_DEST_TYPE,
@@ -2988,9 +2870,9 @@ static int pa_sync(struct bap_bcast_pa_req *req)
 
 static void append_setup(void *data, void *user_data)
 {
-	struct bap_setup *setup = data;
+	struct bt_bap_stream *stream = data;
 	struct sockaddr_iso_bc *addr = user_data;
-	char *path = bt_bap_stream_get_user_data(setup->stream);
+	char *path = bt_bap_stream_get_user_data(stream);
 	int bis = 1;
 	int s_err;
 	const char *strbis = NULL;
@@ -3015,39 +2897,36 @@ static void append_setup(void *data, void *user_data)
 
 static void setup_refresh_qos(void *data, void *user_data)
 {
-	struct bap_setup *setup = data;
+	struct bt_bap_stream *stream = data;
+	struct bap_data *bap_data = user_data;
+	struct bap_setup *setup = bap_find_setup_by_stream(bap_data, stream);
 
-	setup->qos = *bt_bap_stream_get_qos(setup->stream);
+	setup->qos = *bt_bap_stream_get_qos(stream);
 }
 
 static void iso_do_big_sync(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
-	struct bap_bcast_pa_req *req = user_data;
-	struct queue *setups = req->data.setups;
-	struct bap_setup *setup = queue_peek_head(setups);
-	struct bap_data *data = req->bap_data;
+	struct bap_setup *setup = user_data;
+	struct bap_data *data = setup->data;
 	struct sockaddr_iso_bc iso_bc_addr = {0};
 	struct bt_iso_qos qos;
+	struct queue *links = bt_bap_stream_io_get_links(setup->stream);
 
 	DBG("PA Sync done");
 
-	if (req->io) {
-		g_io_channel_unref(req->io);
-		g_io_channel_shutdown(req->io, TRUE, NULL);
-		req->io = io;
-		g_io_channel_ref(req->io);
-	}
-
-	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
-	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
-			sizeof(bdaddr_t));
+	g_io_channel_unref(data->listen_io);
+	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+	data->listen_io = io;
+	g_io_channel_ref(data->listen_io);
 
 	/* Append each linked BIS to the BIG sync request */
-	queue_foreach(setups, append_setup, &iso_bc_addr);
+	append_setup(setup->stream, &iso_bc_addr);
+	queue_foreach(links, append_setup, &iso_bc_addr);
 
 	/* Refresh qos stored in setups */
-	queue_foreach(setups, setup_refresh_qos, NULL);
+	setup->qos = *bt_bap_stream_get_qos(setup->stream);
+	queue_foreach(links, setup_refresh_qos, data);
 
 	/* Set the user requested QOS */
 	bap_qos_to_iso_qos(&setup->qos, &qos);
@@ -3061,7 +2940,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 
 	if (!bt_io_bcast_accept(io,
 			iso_bcast_confirm_cb,
-			req, NULL, &err,
+			setup, NULL, &err,
 			BT_IO_OPT_ISO_BC_NUM_BIS,
 			iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
 			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
@@ -3070,28 +2949,16 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	}
 }
 
-static void pa_and_big_sync(struct bap_bcast_pa_req *req)
+static void pa_and_big_sync(struct bap_setup *setup)
 {
 	GError *err = NULL;
-	struct bap_data *bap_data = req->bap_data;
-
-	req->in_progress = TRUE;
-
-	if (bap_data->listen_io) {
-		/* If there is an active listen io for the BAP session
-		 * with the Broadcast Source, it means that PA sync is
-		 * already established. Go straight to establishing BIG
-		 * sync.
-		 */
-		iso_do_big_sync(bap_data->listen_io, req);
-		return;
-	}
+	struct bap_data *bap_data = setup->data;
 
 	DBG("Create PA sync with this source");
-	req->io = bt_io_listen(NULL, iso_do_big_sync, req,
+	bap_data->listen_io = bt_io_listen(NULL, iso_do_big_sync, setup,
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(bap_data->adapter->adapter),
+			btd_adapter_get_address(bap_data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
 			device_get_address(bap_data->device),
 			BT_IO_OPT_DEST_TYPE,
@@ -3099,26 +2966,17 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, &bap_sink_pa_qos,
 			BT_IO_OPT_INVALID);
-	if (!req->io) {
+	if (!bap_data->listen_io) {
 		error("%s", err->message);
 		g_error_free(err);
 	}
 }
 
-static bool match_bap_adapter(const void *data, const void *match_data)
-{
-	struct bap_adapter *adapter = (struct bap_adapter *)data;
-
-	return adapter->adapter == match_data;
-}
-
 static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
-	struct bap_bcast_pa_req *req;
-	uint8_t type = BAP_PA_LONG_REQ;
 	struct bap_data *data;
 	int ret = 0;
 
@@ -3127,27 +2985,10 @@ static int bap_bcast_probe(struct btd_service *service)
 		return -ENOTSUP;
 	}
 
-	data = queue_find(sessions, match_device, device);
-	if (data && data->service) {
-		error("Profile probed twice for the same device!");
-		return -EINVAL;
-	}
-
-	if (!data) {
-		data = bap_data_new(device);
-		data->device = device;
-		bap_data_add(data);
-
-		/* The Broadcaster was scanned autonomously,
-		 * so it should be probed short-lived.
-		 */
-		type = BAP_PA_SHORT_REQ;
-	}
-
+	data = bap_data_new(device);
 	data->service = service;
-	btd_service_set_user_data(service, data);
-
-	data->adapter = queue_find(adapters, match_bap_adapter, adapter);
+	data->adapter = adapter;
+	data->device = device;
 	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
 			btd_gatt_database_get_db(database));
 	if (!data->bap) {
@@ -3155,9 +2996,6 @@ static int bap_bcast_probe(struct btd_service *service)
 		free(data);
 		return -EINVAL;
 	}
-
-	bt_bap_set_debug(data->bap, bap_debug, NULL, NULL);
-
 	data->bcast_snks = queue_new();
 
 	if (!bt_bap_attach(data->bap, NULL)) {
@@ -3165,6 +3003,8 @@ static int bap_bcast_probe(struct btd_service *service)
 		return -EINVAL;
 	}
 
+	bap_data_add(data);
+
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
 								NULL);
 	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_sink,
@@ -3178,36 +3018,15 @@ static int bap_bcast_probe(struct btd_service *service)
 		/* Return if probed device was handled inside BASS. */
 		return ret;
 
-	/* Start the PA timer if it hasn't been started yet */
-	if (data->adapter->pa_timer_id == 0)
-		data->adapter->pa_timer_id = g_timeout_add_seconds(
-							PA_IDLE_TIMEOUT,
-							pa_idle_timer,
-							data->adapter);
-
-	/* Enqueue this device advertisement so that we can create PA sync. */
-	DBG("enqueue service: %p", service);
-	req = new0(struct bap_bcast_pa_req, 1);
-	req->type = type;
-	req->in_progress = FALSE;
-	req->data.service = service;
-	queue_push_tail(data->adapter->bcast_pa_requests, req);
+	pa_sync(data);
 
 	return 0;
 }
 
-static bool match_service(const void *data, const void *match_data)
-{
-	struct bap_bcast_pa_req *req = (struct bap_bcast_pa_req *)data;
-
-	return req->data.service == match_data;
-}
-
 static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct bap_data *data;
-	struct bap_bcast_pa_req *req;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
@@ -3218,17 +3037,6 @@ static void bap_bcast_remove(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return;
 	}
-	/* Remove the corresponding entry from the pa_req queue. Any pa_req that
-	 * are in progress will be stopped by bap_data_remove which calls
-	 * bap_data_free.
-	 */
-	req = queue_remove_if(data->adapter->bcast_pa_requests,
-						match_service, service);
-	if (req && req->io_id) {
-		g_source_remove(req->io_id);
-		req->io_id = 0;
-	}
-	free(req);
 
 	/* Notify the BASS plugin about the removed session. */
 	bass_bcast_remove(device);
@@ -3370,13 +3178,7 @@ static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	bt_bap_set_user_data(data->bap, adapter);
 	bap_data_set_user_data(data, adapter);
 
-	data->adapter = new0(struct bap_adapter, 1);
-	data->adapter->adapter = adapter;
-
-	if (adapters == NULL)
-		adapters = queue_new();
-	data->adapter->bcast_pa_requests = queue_new();
-	queue_push_tail(adapters, data->adapter);
+	data->adapter = adapter;
 
 	return 0;
 }
@@ -3391,15 +3193,6 @@ static void bap_adapter_remove(struct btd_profile *p,
 	ba2str(btd_adapter_get_address(adapter), addr);
 	DBG("%s", addr);
 
-	queue_destroy(data->adapter->bcast_pa_requests, free);
-	queue_remove(adapters, data->adapter);
-	free(data->adapter);
-
-	if (queue_isempty(adapters)) {
-		queue_destroy(adapters, NULL);
-		adapters = NULL;
-	}
-
 	if (!data) {
 		error("BAP service not handled by profile");
 		return;
-- 
2.43.0

