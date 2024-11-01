Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2042.outbound.protection.outlook.com [40.107.247.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738C156C76
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449451; cv=fail; b=pouJgTp3N0VYvWXqccX0eSkamrKfKgt4ac2rsGvGMK4mTmQh3k1hJvvquvuPaEn4lcNfCCHIRajsqEQ0/IQVNGJEH9gQwqDifamZgzVEWCeyaSyxdG/xLXJWRdCf7egrMaDmsOlZI2SRPsAHeiiaaYmojEpo0duBwVzgVjU5Fbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449451; c=relaxed/simple;
	bh=wyiwqHmXv/DD2LyGbzxWNdQTggJJRkA4M8xNs2AIpNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m67WY7RcDiTsXDGf97Qw+FcLys09+lyxGjrwaq6dBEp7vMjjddP5TTF7rwpinhIK5fIzIWJS5FCbfSOeRindn+cJxcbJayHNsUNvh5GifpN/AbQpSjpp8iGFJlP7FT72ji8fSUIO6CbkW9RaSd5rujY6XyHT0al6bPXYkEEOmL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mTEvCG/t; arc=fail smtp.client-ip=40.107.247.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mTEvCG/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kf33n76H6Mf4F0APHfCnp8uDjlKqu1AwYl3xlKE8MEIhsMmsEJqzpSzE9IXrVV8MXCLR+jcrkXg2Ab4lSGF52EUbVZw7bwcH9QxfRhxfczWNEPFi910WPJHJc6WY0W4OfrIfFAOufHAPjGTUOzS0eZGEY4uPdeJL+YgJSYRHq4fgSR5gMpP2aBAzdDjOqvUeNGtVRt75gH8fhexmDHG7uI7Jay419gsnyara/0P+lX6dPH3P77IqiGtt8CG6qsyfdrtsYCa160i73kxNO0JYXQXHsl2N0p2wjyCbPd/arHzfxxCJdD8cOUZ2qCIE3wGAkajt0OcF4UJuh8oXz9IyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUfmV/m13OP02gDNwYKJTs22lUcCvXpe9sBkaea0wfE=;
 b=QSyXrNP17kePuU73Dw6zLbrX8KNaQTWiGhGumo2JS6vYAJBYUdVxRBZQCECDbzA0SVc7TnRIzrbYt+Ctz+Sr6fLfTE67knLXQ3gqaXoo/rvM4Rn6rBYWcIzRYjAuAonnoFUnTahnVxFyRoh0JtEnc/4KKQh0jhD5FG6EYnh2B0xoOwc3qrjnmx40+FE03pCoLohlALSgC+GBzB5V1EQCZY0RFM+MX/gqqz46cxpD28ZnzRi6rnkgSLPotoZRkpOzFoXUT/BPH53v4RaiqN2rUPaV/8rMaxyVlcAaSzE569sEg3z1Di5raKNsbOY7oNUmPhzWnDOYNIwfRe4QKnKZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUfmV/m13OP02gDNwYKJTs22lUcCvXpe9sBkaea0wfE=;
 b=mTEvCG/t6BGkRxl+05221nQtca+ovTjl7M5OVhfmIJz3nkVry42v8xUVdTMWuTu3ftqSP+/ljbWEY5miMISGK9wtMVRYcca3XF9N4YS/q/M99g/RzvTLSVADvGAxL6ovrx4SClmtSlgwbzH8AsTzWZ6JqSTEsytzFEY0eUbTaM7N9Qe27aqOXgKb/c2MrvUrOzlcY/ZLAZmEnZXOHLYmwo7ViPL8zxYG4nTPwwShMUXrwsIAv64zzLGt3gRf3bipH2n7tuUufv++O5a6lul1BsOmUqveL5yZZKDCKJzpEPwZd9K4AEZYyW1bU00EDAdWgoP7oO+aqjR0ESZu3yoAtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7921.eurprd04.prod.outlook.com (2603:10a6:20b:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 08:24:03 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 08:24:03 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 4/4] Bluetooth: ISO: Update hci_conn_hash_lookup_big for Broadcast slave
Date: Fri,  1 Nov 2024 10:23:39 +0200
Message-ID: <20241101082339.4278-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
References: <20241101082339.4278-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0669ff-5d5c-42b9-c5ef-08dcfa4e8b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iGK5JSpqAeyvPJCvLcEijJzL1eIkpdVaJXxYIGFnAf/2D8lPLw2inwXbmUM4?=
 =?us-ascii?Q?bgnFoEurNNe3c3MQZmx3AOjKS6jzpsTbl0ORAfvlgr1r/CFvR3k2HsGoU8CX?=
 =?us-ascii?Q?drOWnMYnMWlWNFYo2INYj/ZNtZi1captfG3Df0mogDVKbLHXxKiKEOs1Hh0E?=
 =?us-ascii?Q?Z9G/RK1noUS66Tf+m11AdxqIH0nq1wNkW5SGjHnj9ky5a3bblpClCdAtlK2B?=
 =?us-ascii?Q?qYoZazxm0SDBPdIs8450EO3Qhb3RysgcCxT5Y1SU7MgFPJUsfG2SSlGrlE4J?=
 =?us-ascii?Q?olN5LEjLoGcAFvpNYVGqT42e+JHBxEHcF3EgJrXra4XmqkeG+CO0O2k6w4qW?=
 =?us-ascii?Q?RnTp1qm+niGOkjdE2BTyR2NYowNwTiarwwLsq3A9JyX/NScMh1BEtbWVRgUN?=
 =?us-ascii?Q?S2Qp0OLratwMVV5+6zc9F7jpsWHcvIz+yFZ0Pydl8fmc07yuqzvOvif6NO9Z?=
 =?us-ascii?Q?r9gTGJNci4wSs2Y6rMF4tjiGlmZpYBrCa7iPBQuAuy6dad4TAmqg2K/e0u94?=
 =?us-ascii?Q?5m6fgNjPFI8jJnl9eG+K7UMudjxzvVWTLtg8dDY4YyIKZ7ecqxvhN+3u9Sau?=
 =?us-ascii?Q?W0CWqK3/FBrs6zwN3I0KtcXpjmTDbUzVJZJOCEZbJHmTUdsqKIukfj9RX0XO?=
 =?us-ascii?Q?r5HD6T0WH4WGPbgl1NIavwtk/ZzbvzocDunIFcHuio3HBIXxwwpkKsKSqW2d?=
 =?us-ascii?Q?iJuVNmhNQU9PaTV41h0DO1mp/0wWW8P8odu+dH6OT8+oKuVmwmOw8Z4YYjms?=
 =?us-ascii?Q?jSAzAKJLOsGQ7pkSrAW5opmn5N5KBCrAKE2UX3BZ8JSkNATSxBzImdLLz+en?=
 =?us-ascii?Q?z1rCgk02ZcoRzzV97Gawhhn822dpVCE8rPi4KPGC49r24pVFTEiyxwW++/Jd?=
 =?us-ascii?Q?y06XACw5fNBSYBugMjRRQouN3y36ATzDdmvQQbycUTRFFeSb/rB8wxGd1rty?=
 =?us-ascii?Q?gNEvTilVWx7uM9/v4GGFfp52CnbtNLA0QdJLU4JmN+vWmjM1YAtYp1aDev2o?=
 =?us-ascii?Q?583brXvg4Hc2QonIRwVIOG+QLyNu0HnK9q9At3O3z3aFQQp7XojAbMxBCirf?=
 =?us-ascii?Q?1dl5ji48F1TlczYwZWpsC8ct98XDSeXQFVLzkZZsJP8H4FBdI6hLRToNUYLD?=
 =?us-ascii?Q?/B6uSLuKa5UW63JSwziZImoplKxq3o4voRAGes4G35aXHN3bF3wZHE0RuJ3L?=
 =?us-ascii?Q?RZXXapZvBfvk7pWljHFkVzh3REb7Ez5w4PaPWWsAe4om9LiMiK2g61+OYDbQ?=
 =?us-ascii?Q?v6CX8Kvf+C1mZ0h3keNhUUEJ9asCENZXh9/YG27GGeiFk77OY2xs5Y1W+vjW?=
 =?us-ascii?Q?ibRuhCK5jolJVT8nsrNWcb7lMpcKPZ+cw0Ib9dmIaOBY82CI83SyW6bPP0XV?=
 =?us-ascii?Q?M2N3iLc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5FQXA6TTWSQ8O+ifW0iiNs+fAoI323I7M+IVjdzKmmpeIrQc7zFiq4WsAwIX?=
 =?us-ascii?Q?flcVMTMHn0KKDVR03JHuEqAvhvvl1201gxJ2nR+xhoL+gKGPM9HLeIqzyQud?=
 =?us-ascii?Q?LQuoGMBu84AoSpzhURQLuS1kt4zFM0kHz0yaoys2D7cz0vF2JcHlidbX9f3Y?=
 =?us-ascii?Q?801iQqonJJI9Fe2Z6d2ok7aGnUdMkGu0XxxBU2mV89lImmzASj5HvgWkirKX?=
 =?us-ascii?Q?bPAZujez0W+eJjLglBWCmC2uSG7oAWiXgWxC9ocGVSYZ11RijSdv2wciLYdu?=
 =?us-ascii?Q?HBq7JkbGOxpJbmzmc9RWJtOdV9/Gk1UEHNGz2q+2jEYP14Kq+xH9SaIXEUSC?=
 =?us-ascii?Q?1FSzg9nV7zGKUN/FvgQXuEOBbNY6PhTqJBltuNBqfHyY5rzt3hMwrWqhuxW+?=
 =?us-ascii?Q?Leoz9EXYFv6lHWh9+mqWEG2cMUJNCE4EqJxPcgza9z3JWFVD1WGPg/sOjTQ5?=
 =?us-ascii?Q?5+cyMSA0L1nml64/Jrtvyimsl7CS1YHlUfbjAmIt8ZsefKVliq1iTNaeYV1o?=
 =?us-ascii?Q?CuJ+MQNSQ7CCzwgqiJF/sVojtV6pWjK4tuBw6i/qeaw/qxXUIhIIeQakcTQ1?=
 =?us-ascii?Q?KXF/aHRVkGI5ur3SOfifNQDO08IP52/ecT/Y2kUpcopTR6FCTjigRQjALPmN?=
 =?us-ascii?Q?yyiu8iBkbbe7BJn6gaDzDAcxE+mhviQ3cMvN4gBJsGrKTAn6ncjPCX3lDtua?=
 =?us-ascii?Q?nmVpZ6Hpz4NpatzMRKu+ybfiUpsj6z84c/+sPZMoocaevUQgluHMRS8JgO5X?=
 =?us-ascii?Q?o/Zi4S8oEwZq7zfHJdvR+AH9yql/V5dzonxPRENChH1KX2+kax8gy4OfcCbW?=
 =?us-ascii?Q?XzskebRY25cfHjmzKydf8HXb3wT0Iq4oh1mH55y6pmPjul8OiaVRanWWXWAh?=
 =?us-ascii?Q?e3dLw3PieeHOnreVDMfOSwgltWzScM+SoFRUZuAxpJM6viQ6b4TUy/00jrN6?=
 =?us-ascii?Q?b7THuHaJvDEcj6pjY3/Ldqke7TJfmmNuljwuY9xGk8qNlrNbioxXaNVRTag6?=
 =?us-ascii?Q?qfiODLjbWvduyKCnmbNjQ47+o+n32UT3zZalog0QCKPV3pgaE3+IRC/HpXU5?=
 =?us-ascii?Q?kbRcfKjvEkKcr3ScKqnsW281AvjzZWXTF30FRoVhnGGC917iX0O9p4wSJa+0?=
 =?us-ascii?Q?QQf9If5+WCgftgIrfRB3K/+pTqbzUK0EUuCzQuMuDJoKVniuIawLEsJT4Vo/?=
 =?us-ascii?Q?eUOMG3zMILrN9ORP14YrNs+GfIbtSB/kBeXDz0G4DgK9UAbNF3f8B7mbG4rX?=
 =?us-ascii?Q?BAfdpTpImBEbP8h2mMsjxy6nr8/cZ6CZ0I9RVfJHcodddFAF0vLGevCph7+h?=
 =?us-ascii?Q?bc8da/S7bXw8EBZeTQ/ovifzPNTLYWqebZMSx2w9fqci6HIQBTepRAld9dyk?=
 =?us-ascii?Q?AByXcGCCAAM7w91sxXyaPuw0xXDxPtlgimRmW11FO50H85tDX91uREV+Kkq1?=
 =?us-ascii?Q?XFHAh9XlI0QHBzAJLndzWBbfZFFg49p2+xeg5aOk00q8IWiTPeVBTcmo3b4t?=
 =?us-ascii?Q?gbOmDDP91dRH23z5hQC3SAH6MvJgZLS17gZvVdwkuIUY/PK/Rch/QakuONxQ?=
 =?us-ascii?Q?fjCpd29tSfatZH5X7O+5Ym+/Jw81Mdj9vfOqhk8nwqEEEQBBKGNhpk0+hAsC?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0669ff-5d5c-42b9-c5ef-08dcfa4e8b6e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 08:24:03.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoYeLqqmpac2kLugGmN83AY19JmgSKP12CGuVIUo5Gj0m8zOiTsr8z6NEKN0Z1sVj6t9i8p2fdv1EQqmsn2PUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7921

Currently, hci_conn_hash_lookup_big only checks for BIS master connections,
by filtering out connections with the destination address set. This commit
updates this function to also consider BIS slave connections, since it is
also used for a Broadcast Receiver to set an available BIG handle before
issuing the LE BIG Create Sync command.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 include/net/bluetooth/hci_core.h | 12 +++++++++++-
 net/bluetooth/hci_event.c        |  1 +
 net/bluetooth/iso.c              |  1 -
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c95f7e6ba255..ea798f07c5a2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1285,7 +1285,17 @@ static inline struct hci_conn *hci_conn_hash_lookup_big(struct hci_dev *hdev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (bacmp(&c->dst, BDADDR_ANY) || c->type != ISO_LINK)
+		if (c->type != ISO_LINK)
+			continue;
+
+		/* An ISO_LINK hcon with BDADDR_ANY as destination
+		 * address is a Broadcast connection. A Broadcast
+		 * slave connection is associated with a PA train,
+		 * so the sync_handle can be used to differentiate
+		 * from unicast.
+		 */
+		if (bacmp(&c->dst, BDADDR_ANY) &&
+		    c->sync_handle == HCI_SYNC_HANDLE_INVALID)
 			continue;
 
 		if (handle == c->iso_qos.bcast.big) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2b5ba8acd1d8..aca121408369 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6965,6 +6965,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			/* Mark PA sync as established */
 			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
 
+		bis->sync_handle = conn->sync_handle;
 		bis->iso_qos.bcast.big = ev->handle;
 		memset(&interval, 0, sizeof(interval));
 		memcpy(&interval, ev->latency, sizeof(ev->latency));
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 9499ddfd25e7..9e119da43147 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1839,7 +1839,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 		if (!bacmp(&hcon->dst, BDADDR_ANY)) {
 			bacpy(&hcon->dst, &iso_pi(parent)->dst);
 			hcon->dst_type = iso_pi(parent)->dst_type;
-			hcon->sync_handle = iso_pi(parent)->sync_handle;
 		}
 
 		if (ev3) {
-- 
2.43.0

