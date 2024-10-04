Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CD81D417D
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045360; cv=fail; b=onqRoDWka1yYkpTZ5879BrhyCJWN0nYgxgIsz3nU3MTmZsiyhxhlAIChTQb82itZyFPS0P3cNH9zXOWa/oyLISNAVIzgVyOdq694upVnfXioY3MEC9eZy1IxOTqrwG+79wXgU/JbXdXBe+SktfJoErpttvAWLqAKDGHKInLmgDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045360; c=relaxed/simple;
	bh=6wNahkMbVA2UziGnvNJTEsLL6VUUfg/+tluezrQvQKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gM7nGYsw6oQ4Vi3FpKEdlRK6g6t1TWIkh7SeNCcPfB6UFjfZ6estcq2f2jYqesSkkZXWypTIxFt+oxOm0D368Jb33M+8DKmxnxIsFRaWT6deEIZO2LWHL6k5DiIF7DQVJ0/hEXmwPa0lKIGgLirfRwc2q+yVPhOR+3KD56sy5f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CdLKRoCg; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CdLKRoCg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXsihAMO8SekLX6UpqO+B84uEpRDjO7Z0D0I9/Pt9IFc8IWgipaWkvDnc1I0JvJz0iokXC8wQOM0ZiJo4hOeGFRJ1hBNOJ7NDyYGqX6yfpsdIVjKkZXFdcnaVTnzOIsjv3+odJO46w6R4SjDKpVrtWX1nHCg4SXhjjDQamYDbsMlWCFoKUdj9sI4Kambto/g7Lf7GD3mu835/aAs/R/fHbrtFNya1ySMWVwJoPrFLOoymgIR6U77yP1dHOFPN+JXv5Dd1sFflAuELScvYgcdoFlS+b0BRzXpraNArW3YuEX57/K1SIntmw/ksJT4vo4yTAbX1REwlk2ijPfKTdNqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUHE+BCh71xxaLeIiI/5JbvF1U5vTxWAMD9djvotLEw=;
 b=iaSTuhvy3WT1v3QzsqJevmD1EUfLzgVo2PDSvDmtiVKjfwC6D+4tz+WUTiXwzOSn0CkcPSvEtIX/ce9INgos2SCip1ZPXikiIw1rPQwQzRGCyWk8DL1SN8cmr/ZkGiLTcV+hYbgnbziTcjv95LU2gc1ukxdbxnM/G/dUg809vIec/47vmOSQxG17xJHAKeSGK4RgOqesPvA8ZP6w8xFR58IxGNRpGAI9AdwKvnJmOdTNcHyOIhOYG1QUIt6zJPT453vCp2vCzeBbXo2rIrNmNFVVKQvi9d/NHtTmd/05AL3CF5f3qppeOBvT77mt/HqHd3UEN9yxRGsMa5p0FH+wdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUHE+BCh71xxaLeIiI/5JbvF1U5vTxWAMD9djvotLEw=;
 b=CdLKRoCgyXUl9ZEh2IQRWMQgvifTxKlYAMBs8t0F6/pG5ykLazn8GzARZJDff78A6TxMycFlnbJfETmrBKaA8ymXygKvYoooLVzs7HLlaKyNSAauVeq5f6iqdQjIlABd5JsvKqiAmVb5eMY7j5XdQI6VdiSpTxWolOER0+sHrLAVH93aysQlWrpw7DczW0riwH+c4Lblz29vAkB8ZBzEx0fmAYl3X51UsSL+iehDZlnqwVjPZj7oBd4mGDHLGVOnwKUpflvjRa40TW0NE55jEOaqMkhQ2U/BkBeX39Gjgz3N8n2Aqv4yHfv98N6dTI5/f1P8UaI186w2UH76gW0ZxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI2PR04MB11075.eurprd04.prod.outlook.com (2603:10a6:800:27a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:54 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:54 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 9/9] transport: Trigger transport reacquire for multiple BISes sync
Date: Fri,  4 Oct 2024 15:35:23 +0300
Message-Id: <20241004123523.1012743-10-vlad.pruteanu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI2PR04MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: 677f9396-b07b-47ab-9a07-08dce4711684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Mt7pX9nXaeDRDFbcaf+sUd3pZaQV7mzRx59TVG1IOMg55HbtvjT/SD1wymJ?=
 =?us-ascii?Q?MPybaqTt97/tHTCPJ3CHDrym+FoyfaD4OFbodP+6IHeuOn8bHqFkHkV/WjsO?=
 =?us-ascii?Q?DDi77ue17DfU6/GNkw0VkfFwS/x4YKvdooZJFwQVLA0TbSRxSBiCwabfEwhO?=
 =?us-ascii?Q?ULZ5rLZ0xKrpnHr7l/SkPdRYtQyoCzmjf4Qfvp3qgkfwl5PeCWKBnvNLt5cu?=
 =?us-ascii?Q?9y3y7B9X/VH+su3IwbxKxNoj/yFiaK2drKBqkkMdOt5GOMT+29VW2IbZFN0g?=
 =?us-ascii?Q?90eE6Aj2MqXvDfAgQVGUy0O3fYG7VpOo0md2qu18oX3AD87fjSXQtuOM3U2p?=
 =?us-ascii?Q?dvbxPHzS/ySvMr8vXeHiXPXm1zD4IxrTAN0wh5s1bKQBHjxCJ1aYd/ul6eoF?=
 =?us-ascii?Q?Dd7atAkvylzEk2znaYaL4JNnjaXncahmNQI6We1c9Bhv79CzoE9T+qOXL6+Y?=
 =?us-ascii?Q?Ss8segCnvvcxEsqdfbosRnMmJlYBcig+Ms4kmKw+Q/0yXx82ul7TTiFMaMT+?=
 =?us-ascii?Q?1G9VyrTbt6SbJtiSJbBEN3JlGruJuxW8zIR84IVS3laQq6v5wkJ6IvEoQ5Y5?=
 =?us-ascii?Q?xHthhtGHh2orSs8m8PaHFLGZvlWt8ncrGp8gAWDqlwKcqpMUxkUZfUwFdDrt?=
 =?us-ascii?Q?QSfRN4GP9hxpTbKC20uXoMvSuOJBZajx3EWQ5aaHlXjHhqnp+pmWD/5m0rW9?=
 =?us-ascii?Q?Yh60/JAU14ikwA6t4cT1oj7/ce+Ffw1rXKQQLRvjyKP5keejDrrC8iIHh2rk?=
 =?us-ascii?Q?WNdmRu6ufhuKdyAk59838SJCra79FiWOV4CHVbNCxEecJqwkVsCfdYNWF2il?=
 =?us-ascii?Q?/96L65XuO/QZxQl2QRJGTpHTuP/ELsmsw+2fWIWxnHGTdx/0lrQ5bDI/+RIV?=
 =?us-ascii?Q?TRi6wGX4W0pOzEYciacS3tsl9P9b6bxuABnHuDJZQa1t1bpiXIJYLW64RKob?=
 =?us-ascii?Q?9lWTeEJP9WIMbAFOxwf+ZBHmBC6O2yGg8h1sQ0y2z9HIzCAxB4iXkPer0t+d?=
 =?us-ascii?Q?Sb2TAGYcIfT4DFkOTHkUgmM7ORFofSm0CaV3qp1aoZW9HPRDI/VCMWzEb6i0?=
 =?us-ascii?Q?W17W7ryL5pBYl2jum1e57KERBoZQEcANR4hYIkG1unlH5wKFFE48isJo9Iug?=
 =?us-ascii?Q?U0bGZvgUlM1wvI4otCJNaDOqT5YVBP7FhBJUuitmRCYdMJ/8ozrjv7ty/aFJ?=
 =?us-ascii?Q?+fmcNBgYqL16kVbfmk0c/9Z+xd+lgDK6uoVJn4ML60qpAWX/ongJgPVT752Y?=
 =?us-ascii?Q?epCP6Wgz+nqfrKiiSv2HOMPNDQ5ECDQ6+HZPEzCE6BhaQFYumNpWiee1f389?=
 =?us-ascii?Q?SWhL6mjr0HieRKaXrDkENJHxrOa14dD64C4cBBswJ96vrQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MKkI+rOjUmM2Npi/yPJrWJ7oG7G+vCi7aVaT6eL29trXoYmfl7aUuGokCa0O?=
 =?us-ascii?Q?iwXlxDplScrbAViTFLxT3TqOvEqsmN/QXoT15JMt8rTRhd4937eQxGucW50B?=
 =?us-ascii?Q?ANT9vEQB8rQ6O5FLessZ3MTROIGx7Kk6KOnhhB1I0pnThCCxMp85fCpA0rD2?=
 =?us-ascii?Q?XZLLBYGIljconFmpgWY1sc1mRuRFgVlYzBY17DAYOr2W57IsnUQrqiIHFAQ3?=
 =?us-ascii?Q?j5ecCkXkKG41Q8w/+/ALclZ6Y/4xNOS2s74eL9v8MG5xBiAIWAa4Q2h+4AUZ?=
 =?us-ascii?Q?hbjudAKe4YTtmjkBm0St/OUCGfeZxZe6zcZ5ZW0rSF4CHQ1onMUoGqHNsF9R?=
 =?us-ascii?Q?jkFD77BoM8GZd4NG2PqXAuvDyKw9iTECGUZEF0kK7nZE5fZMDSiOg5RQdOIL?=
 =?us-ascii?Q?bSSDEz0kVI8pwf/nSwGqRKn+kQVyAtzrwlnXHRj6YxuCIowwCWo3W+0GTNuv?=
 =?us-ascii?Q?Y2aQowfYF1akDD7JH2mAVRKUHAEJ3VCu4YpdGZU7Y1u5wSNlLvm9KbyJd9Ld?=
 =?us-ascii?Q?NSUCY7fUOa0NNbe63SlSBTYwM2n7vjxPJluxeVvVe5XNyg/g9g5dGQhE3hEf?=
 =?us-ascii?Q?ce3Nv3kWMadmK7gVyNLLj7ceteLU+WyrMHN7fNrX8tnkUsH7+TUcguFskrC1?=
 =?us-ascii?Q?o+en4+IKKWh7aHXTWTfLRq/tpKc0LGOyq9i0rnaHrsWCF1WXkMdj5xbmNWGf?=
 =?us-ascii?Q?9ebsveKBJfINAJ6/C22MAfhf62AXjAr/skokRBvMJaD2upHrPhxlBou7dkHE?=
 =?us-ascii?Q?vGH9oBGat6yCBh7RgYJ75BXz0GLSqPc0xH7kPz3S3+jgLo99yv9Z9O1k+9pR?=
 =?us-ascii?Q?k5/gUbZSg7MDhbdDRV+oYaYNcNeyAHGvnprkRTUnUHqMHDSf8rwuRc+cC4r3?=
 =?us-ascii?Q?hn0++3Fgd6dr1dalPXoGmJUBtYMdv9YMWZc4DuCzhKOqgQASxNmQ8C5mH+yK?=
 =?us-ascii?Q?1qpe7q0rkzbP7Qfg5nigPO9B1DT20Pk0JRXcYy42aJukQGmuiR+enZysf8il?=
 =?us-ascii?Q?UMFZn8ThbrmtXbwnvXZFwVW5MygoxdDqh6uJ02JVM14lWAugLExDU+/ToJCB?=
 =?us-ascii?Q?6IXfJ4tIlhNA5ETR/XB135kFS+nFE03zuqQpthVQ78/hczib8hpoLgj/5Uht?=
 =?us-ascii?Q?VjEmVLO8Odo7QXbPTxe6c1pT5RwniyWGGV++Oato7liPxkXIZMzMm/GipV2H?=
 =?us-ascii?Q?VcUc7iwdfKRcQohT4pwtzM1lBRNuKHYZw/ijsxAMWbZsVtlGEqLDts4kNl+c?=
 =?us-ascii?Q?s5qthqPMRorLY09MBfWHvFzzvlhCElvuWUnkmzNqV2s8HyjMf72bG1lm5h0b?=
 =?us-ascii?Q?xda7HRaXowypgzZzoICB62EjlyOj2YjY9xG4Cn+tWD0j+P4Oj91D/fmTj6l6?=
 =?us-ascii?Q?4a26zOPOXbjZ+FAovvqXdIOxhRWGcUiVT0eaYy6O+L242n0UN1taDLLN7fzm?=
 =?us-ascii?Q?16OR1+fGnt4N6gOGwrG0wpKhCIfcnF/49aY9twvZtF3bK7IZ8YsmrKGJyYHu?=
 =?us-ascii?Q?acovTu3r2YxQ/HkMvFeNtNFIpJOl7FejR4EIthzZWc6ywxgwpVeQqpd2udeO?=
 =?us-ascii?Q?KNucbzuCjNNf9FH7fdpcpoJ1r1P0JI0RMRAHDsRw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677f9396-b07b-47ab-9a07-08dce4711684
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:54.1444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFChdTvEhbsoOkH6dw6ZroyuLo/FR/rzeUNkkcmwXXTMnBM+ooK90pYXsfPXZtqCgiRdvlB9/wyC5WETtqL9Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11075

Once the transport is release, bap_stop_complete is called. If the
transport is part of a sync with multiple BISes, it needs to be
reacquired. Such a transport will have it's stream in the
BT_BAP_STREAM_STATE_PENDING state. Thus, transport_update_playing
with playing set to TRUE must be called. This will set the transport
state to BROADCASTING, so that the audio server will automatically
acquire it.
---
 profiles/audio/transport.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e68695c39..4ea793a27 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -705,13 +705,16 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static void transport_update_playing(struct media_transport *transport,
+							gboolean playing);
+
 static void bap_stop_complete(struct bt_bap_stream *stream,
 					uint8_t code, uint8_t reason,
 					void *user_data)
 {
-	struct media_owner *owner = user_data;
 	struct media_request *req;
-	struct media_transport *transport;
+	struct media_transport *transport = user_data;
+	struct media_owner *owner = transport->owner;
 
 	if (!owner)
 		return;
@@ -731,6 +734,11 @@ static void bap_stop_complete(struct bt_bap_stream *stream,
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		media_transport_remove_owner(transport);
 	}
+	if (bt_bap_stream_get_state(stream) == BT_BAP_STREAM_STATE_PENDING)
+		/* Transports with streams in this state should be reaquired as
+		 * part of a multiple BIS sync.
+		 */
+		transport_update_playing(transport, TRUE);
 }
 
 static void bap_disable_complete(struct bt_bap_stream *stream,
@@ -1707,7 +1715,8 @@ static guint transport_bap_suspend(struct media_transport *transport,
 
 	if (bt_bap_stream_get_type(bap->stream) == BT_BAP_STREAM_TYPE_BCAST) {
 		if (transport->owner == owner)
-			bap_disable_complete(bap->stream, 0x00, 0x00, owner);
+			bap_disable_complete(bap->stream, 0x00, 0x00,
+				transport);
 		return 0;
 	}
 
-- 
2.40.1

