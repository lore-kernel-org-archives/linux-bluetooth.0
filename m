Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F71991DB
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336841; cv=fail; b=JfHMUoZJtJdKjrkhyklV9JbeFmFQHdwZIaGeicxteHxm0740Awo9Wdv2AGbAsCHiSSp2k73PRIVI0Uh3JVmvn4tpWAZsGt1a42ObSwhbcKbaV5mJFOS+sDbKCkjIkXtmEvrk53eqEgfY/TrvSPXscT5rGfFDDvZdWDkXMtPSlT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336841; c=relaxed/simple;
	bh=Z7LX9XM2Amtl+uR4HYCOgsS/xgxyJD7PiV9dN5s3XWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jUp4qxd+9uRwEzNLwGOeeD/0mgXK8e9vdAE5xQJgif2zscBrkqC8JUZlrR8bGgw2LAJ+BsiD7ctRdb4CDMmdikZemCoY68mUqQjym3GMTX6LQWRktwixUtXQGirDNvFbiQfpdrx7DPySsJLzFnwzIg/mByl0VkfhOnKEA4i4y9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aBxH7apE; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aBxH7apE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+vs2fyj3+oMkb1KwdvSHj8LgyRIeTjZRpg1VmyBh7tuw7v/XwptpfjxyV4lWW9Q61jdUbnR3rvufR0Oj5YJ9ZIyCzNg1s2RVG59WbhTxvi8obnLbsA1ZWH1ah72aJJALB4eS8EaW8b2WLnICH+5lEaibbw8FeQ7SBmeDRY6ohs/NsYcTa7Am/nlxX464upTzyuFvk/ywcAKB0Tjy82OG8aGg9BwzSLy/nWmFkmlISViS/2ckicLoUZXO28rMLgQsbs+5JO/RdEBu/1PV5aWf3thYosgzibzTgCXlyswop2NOuRBWOrDsZf9s5/WfCsRoK1l+520f2ygaRF0ybA8tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nnU9cuP1EYfbYCP2gx3b1ZGbqSXP4oI4fOsHemwom0=;
 b=sGRy4U+JCzLi92bWJ7sahaEMf8Gz4X/MFDgxLia+Byy+R4zHECVtgF5mQxT23hE6rZygaMzjxiUzehiI0io2dRQJ7cJ9N77lyVlDLmIC9UQ9yEEcjybD2Xh8q5+Toh/ZM5/inqzPP+sTOkSl/COirTzqnqW7wjRUl6uuKC4Cfyv0S0KEH+uD4OdIKs7ltb+EwNyjjgXJK3WmJ1EajppjOJplM2FZkIKkn8B3nI8fw88fngfKmG10pNfUmykavRLr7O9fgy76B2q8rJPTJXFAFhhVn64558pqDLvOP8ZFckoog4yGlg6NAsHHw8W9jhTNmJaY6dcg36MSVUMC7FQwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nnU9cuP1EYfbYCP2gx3b1ZGbqSXP4oI4fOsHemwom0=;
 b=aBxH7apEpjI8ZUX20FMIlJzlhNy+AXA2iyC4TDo+16MpovA95ScrPGn6GQ9rH9jEoyz/uObDOp+GUHSydPgSC6ntMeuTPaAN+228F7odQ7wfDl1QoqoFp1QsOKm+I2qu8KrPN66yDwK5N0zT2oKAK9vQx3x0KoMLL4t99H9/ac0+dMOIaYlOTbQmZNpGiy1OatJfw/1mL+KL3CT1c0RwxhlHH77UdDfSw0OB/Zo53BvwTsPb/dbKMTMph4rWTIAIIctad8eB2n54jvqzNl/+RNYiX4EzXlCNdf01c/peBz/bSel3+VuD8SbzVeUR27hIJBr/sJHzgEwmTzTegYDLyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:53:52 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:53:52 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 5/8] transport: Broadcast sink: wait for user to select transport
Date: Tue, 30 Jul 2024 13:53:10 +0300
Message-Id: <20240730105313.403238-6-vlad.pruteanu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: c80669ac-c628-4b47-a51f-08dcb085de8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RPc5C+CvXTA6jGthoXW1vIUI/dh0kp+PE7wH9cJEuVU2q77hmdNgWAuqHWZD?=
 =?us-ascii?Q?M65fxQd9Z/iv1j2g5fLK6mUZ1rpz85da/Q9AjT8pQvyE/HuVMZsCE3R2K2Se?=
 =?us-ascii?Q?XspFjuLf0tWs6x33k8oQsu9RYd7iOylqnxZmzL54uLLUM/GsRTDu2AHP8gql?=
 =?us-ascii?Q?Lfc0QOILJqjb9dst47X9WPt9HKeXyv0HBmrYED7A6kpURnm7AGntp72hQHSQ?=
 =?us-ascii?Q?bFVyqvz4NMBAZ5dvBc1/ySuuQ9TWL5OM0q5dQXhxknId7S3FZpCP1vlJPPzb?=
 =?us-ascii?Q?K4SfKjNKeBrC5KBg7Zi+TZ4nqy/BXBYrVe3J+rFQNv804MnLZ9JVO1CVYv8p?=
 =?us-ascii?Q?NJPoTU/q1uHwcXuMKOReLfV+3iyTgHDt57sDTFcCwybmItN5kgOTND34VxGF?=
 =?us-ascii?Q?Bv5QlTcoMELeel02XOw1/jIt8KjM2W9zHBD7NM9kMB2D5ooSEPCy1cRVFxeg?=
 =?us-ascii?Q?uPncXHOVd7E6cZUvVZpgN8LtUAkIngZgD5OL0AyK46MpoWPidtfdZJSJW+JG?=
 =?us-ascii?Q?wWL1IbspVDEHbMZmNlgelL20sOPsQi1u5paC+YqjBV96I7k3Q/u5vKt5Uh0f?=
 =?us-ascii?Q?6tFI5IKYGUFW4oNfN+wd7GfA5GIDCRw/IFTyAu3MVapN+jaTLUvYZz1QA2X6?=
 =?us-ascii?Q?o2VKULP1Zs7YQvAqIrmYVCv4SrMpVu+mQ8gxCaEc6RcXwTnPeRirqjVhlx+g?=
 =?us-ascii?Q?HvxoaLctWRE2dR1lXqQcabyif4X3jDpg3o1DdD12Dh3HpT4dAsqDGCqbJcnO?=
 =?us-ascii?Q?AJkhyr+fmB2U3LsydQEozJeiYCMu+L1qL/gOpHzDYWDBYN1StY4Ye3oHbccb?=
 =?us-ascii?Q?OMa5TLAUTrQE6p0wXOeQmmdwuscBWWzkFaIgZuhqHNLyCpJJYEMlZFzQBXJB?=
 =?us-ascii?Q?BXlHiUK3birNNkLj9lrqsipg8esN6VJPTXmUlUyrcFouUNAcfB06UaawneAY?=
 =?us-ascii?Q?l2JGlh6FaqM7V7aGHmXRPpNs8F+wJrAjKSmfvvBXm9bFA6FPocKMsR6YF2ZJ?=
 =?us-ascii?Q?+szFHKYq3g3NhaYbxh6PWPb/9seNkVp1ZbWWY3J37WVnbrqgUqLkJ8SEs0JY?=
 =?us-ascii?Q?hM7bBY2gKnsaKuOxj8VH+XdQfJ+KPiKtf++kkgD5lV92/ygcxUsQ0LMyKFcs?=
 =?us-ascii?Q?Ph/TUBT2/KUVe1Lqdhu1+c88G0kHD2nNkARLV2uDazimr3WuAy6hS2twFCF1?=
 =?us-ascii?Q?yDPleEMn069d7mDoCCTNmJ9hQRJ2HPZYg8qatK5MlDG8CcSs13mFKR+s7EWl?=
 =?us-ascii?Q?KhOVL/rxsRowYy+9AcA7TttbgodMAAo5qpYghdSzld8bD12AJkwFbLOqt6CT?=
 =?us-ascii?Q?hvb3egyNsqgjDVqSdCycmo4Vr8X7m87S27rTDf5b3gdp/wEVBqHedbgv73yC?=
 =?us-ascii?Q?naWR3i/qBH2MOOvEfqbpCaWVsDsVZIyEvnkAc0yRYvpq8cn/HQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G/LJ4p4P8Ykj36VXkJg1UlkKbWOKYVeP+rnav4KwtAPDMLqFSAM4t5QrLhSs?=
 =?us-ascii?Q?tFfUT/czRavluUbX21WYP4X/+UWylvKKRmSEypHsYrIvXF9l5lcKfVZfL2iF?=
 =?us-ascii?Q?hOVdeZ40LNVsWRz/sYtJqi5/WEZ5yTUI4fO8ljyQiaxplUGl1Z68rwd24FEh?=
 =?us-ascii?Q?0yZnBSfot5ELtfejqHCS9vFocoww8lIQ450rTpgNztndY5/TFc3UDL001bzp?=
 =?us-ascii?Q?wOMfUKyseQ9jSI0QIkuoDZGlRvIr/fFNgpwR6H1wxisIR24+xcagTxdACHsP?=
 =?us-ascii?Q?ShX3XoFRMOpzMLodSO8nUqaBHN2ZY+B++XsJZWvLTvkyDLITGcgkCX8blaOW?=
 =?us-ascii?Q?9OXK9WzXwLXK7rTUlflvpVGoYEdawzCyZ9g98dgSWvdc8mRQe6lztx+30xZE?=
 =?us-ascii?Q?Igwv5iPVUH/LFppQQ41G0ou/dcvc91WiACnVDs5ir9ymN+3ltJtlPFslop3o?=
 =?us-ascii?Q?xiWd4tfndLgrzYarm1lzRYOI9ySgaa4UeCpK3igyXattfry3BQOd6+wLxe+u?=
 =?us-ascii?Q?rdEv/EGlRDhxceKQTZW1OqxURHnm8gOSLc6iDUepX0yNegEhDnq1mO2ZnGb9?=
 =?us-ascii?Q?7ksTYIvX5ngjVyOCzb4z8HGDNkQCLPmJpODmqP1BpzyFnUikTZpP+Jn7nYg9?=
 =?us-ascii?Q?y3qjXIrXCUllv790PQVA9vuT5cvynJkoXEA875Q22EDIM8cR5Rxf83ZZFj3/?=
 =?us-ascii?Q?sORG1MD+RORwHTnk6ftxvGFuH+nLUhcc1eZvhOSXsGkc2in8y8u7o8inTrds?=
 =?us-ascii?Q?whHQ/8DEUeJCs4XRQBQe59N7aAME2yDPXMV5BLQ8IeI75ojW+tNYqzCR/+K1?=
 =?us-ascii?Q?ywH9U+89TUrkpT6syBzsmu3n+Y2Sno1LLp89SHS5A3PaWv91Dz0Uwu5XItap?=
 =?us-ascii?Q?WhH22vS0YOkX9sqcFjkhjfZ+vM+cQtBzR7QDkNjYh6plzk5P61hei5uveFp3?=
 =?us-ascii?Q?2juDny5hcZHyo+f3A6tcQ3aNFGcLXQhr1wecxeHQG2yybORNWXke+TPvjuUu?=
 =?us-ascii?Q?DAIYbJKpQ5apS3jTeq1DpEfqNH3L768dOvN6D4XqECwTwqhgvok1gkcRr269?=
 =?us-ascii?Q?HeVfrVM64g+oHdyNhbEWKFeD/gmu1VUzYj52639fvQVtQ9sU7pFNWnEiI4JN?=
 =?us-ascii?Q?JwJiFUebb4ITLWrQPrW6dNlwwnQeSgYH5KY6FEPBgAeRapKKPZ/BLFYAN07v?=
 =?us-ascii?Q?khZtjNty6vEwqRAa3QMby52TZnEPGF7CV03yu5wtQfCaipSQ1sflT2jftzP4?=
 =?us-ascii?Q?edlEvvBG6Nc2bDBrlbO4zBoPGh+jbZ+1Rf5OVpcgnHD07UVS3eW3l0K3zUzA?=
 =?us-ascii?Q?MuVA+u6nu7yOUi01sfuJdfvLhbjk1roFHUHk+OVfZG2ra7FU6tAbfJwERLes?=
 =?us-ascii?Q?HsgiOajFIcKsMQweTfNtS/NWsoL/cGrttjFe1SeTnTaEjSd+AHQUjv0b/3tT?=
 =?us-ascii?Q?5hAH7Ipe7Vd4lXYvi/3snXCgrYDFK55XYrJEPV5q3rgcZyxX6at9esvAy+vR?=
 =?us-ascii?Q?ZJRt31zDJhQuxwsru6YauLf3XzuYF+XeryvV9+pKDD1VvPr4/Jo5IqyIlLV2?=
 =?us-ascii?Q?Y+659r0pLybd319f7hezw056mImvta7KIIOKVUGu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80669ac-c628-4b47-a51f-08dcb085de8e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:39.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvcF/BWjavZaBuJk5HaPhpPI2A9t51ok1IjnHU8DPixWahKpU2KPObNTl01IoBVA1bxf+grwGQQ5gLUTDjOAtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

This changes the flow for transports created on broadcast sink side.
Transports are not automatically changed to pending anymore, instead
the user must first run transport.select on them which updates the
state to 'broadcasting'. This allows for the selection of the desired
stream when running the setup with PipeWire, which acquires any transport
that is broadcasting.
---
 profiles/audio/transport.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bf2215a0f..80e4f564c 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1303,8 +1303,14 @@ static void transport_update_playing(struct media_transport *transport,
 			if (transport->owner != NULL)
 				media_transport_remove_owner(transport);
 		}
-	} else if (transport->state == TRANSPORT_STATE_IDLE)
-		transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	} else if (transport->state == TRANSPORT_STATE_IDLE) {
+		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID))
+			transport_set_state(transport,
+						TRANSPORT_STATE_BROADCASTING);
+		else
+			transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	}
 }
 
 static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
@@ -1686,10 +1692,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			transport_update_playing(transport, TRUE);
-		else
-			transport_update_playing(transport, FALSE);
+		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
-- 
2.40.1

