Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83A3A1B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514936; cv=fail; b=PrkvW1T3ZVNqzfhlQMJ/pEHYAhgZYLdMCKyIccf4DipJujXhUn8UlbWxInL+xd6BslsAsOw2QiS03ck3sMtFlV/piICAJDQMSNZDWrRwp9ESRTF0b9xpFXiWjGr724eRbj2Tq9JJ9NxEC3MMpiitBHLAW2W6bfsqP57C7fDt8ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514936; c=relaxed/simple;
	bh=0dRFxR0jNHmTqolxKejhwi7qMMg123Zb7P9CbwTAVrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=koYL3BVqmN78pZ7XCesvJIUArjLFJZ4rMLrQW9x6ost7GRakAj5mDplQB3TEBRmChGCn3vod/rh00oaNDX31/BXIyieSmH7M4k9RecKbC5QJHWSLzAtzZFYg8rbrT5+VnuA6MPzntGqeMctHMbUgs214VUPygP+kmXBLdt3DsWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hrAIU3tj; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hrAIU3tj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvlvvpWI6ULRA5IAVv1C23vDl1oZdnJuRau55NttL6tMxMN0RrlQaz8LpkZztSfx9fimtxcXmEWyEB130A4JqWK1I2ht+unLu3GrrJ+hpI+X9jztpKS1NWAqKaJx6UrkTaRXQ6mpA6DrJUDMLVU5vuNwuqJJz3K5VDj1/uvmyvLfACk5jfFPRUefQ1WSvJ4P6yZdSeWUGULq7gO0MPJsDT/Dz50yKG9MGe+q7s9sArnazKCLvM2hXMJfXJGAjoEISHpbgIZqvknyTljvyGBHfPRBDzK5+Z0c0+Alp+IFU6hAAhtn1IEnCOnj70ITtHeKkiQJ5rm2B5x6/JsBVqcN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UYUph4A2tuOEUiY5ABfQI102bIvYPhwc10RJ5GtO5Q=;
 b=YIWUwuhkqpOfYmcJk7baRPq/EGZFau/KiuMQMKpqZVuZnPpa41FWTsyAVmALunwDX/ZNzh5ItGX5kLp64+sICABWRSx4mo/RbcazXnaZDLli4T3njiVulMxi0ELlVI5gkYHrWo3JihMBNsUVeG5fw381V8dCyBQPqQ+H3Wy1RrPcsTIzUIQn5msVnpPhiQybZyI5pm5sIPzLHPiWAweS/u55EoM2xkr3aGU9XkT3tSdHN1bf7P87kRQXyukomP+uxTNHa1rKuL191Z+Vwtf6774bylQDeW7sxQkL7TFoAYgVf1vRjWUbFp9wiu3Qi+Hvacx5X+xsZjtuZyJp9R2G0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UYUph4A2tuOEUiY5ABfQI102bIvYPhwc10RJ5GtO5Q=;
 b=hrAIU3tj4C56Q79S52vCbEhvDGKnPwFm0fxHgbNWwN0CxuwjcUqbN4MpTw3Ey/6dAWtlg46ZIuSxrxRvvG4YdNnjMOZ025esyZtDhVngRXHFWBX1VujlU7vMikpIcBpQlKhHL0FYj4GLQdC07S+hkdikxh/+t8BH3Ydsj/hXvF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 15:02:11 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 15:02:11 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 2/5] transport: Add support to update the transport config
Date: Fri, 15 Mar 2024 17:01:55 +0200
Message-Id: <20240315150158.79715-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
References: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::10) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a67734-bd78-4459-c526-08dc4500e42c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pWDC0iDBgy4dCQ/ReziEIL/jFf3WT638yIe85tL5He8U6wnEiakN7YRGA/7hpvX/MYfyl+uOEl7czPY2qdThhSjfq73vaNe7M0/RGYdp8kG7+irfDrsRCcjDNUK1+n1Mb9yNEzDnoSR3hzrSt3XJFjQmqRseU+z2uRS2Cbvm+bq6uHDcxXNDRKhFFIderHFA7x6u+t+lCyJ2K3p4HvvbPsh8DBEiSwN0F/fIs/aUrDA1pPrlurIiszwQKEQRdSKouWMbpOpnSJBuCuSLDwnsa7JP9Bv6sTWVJcde2uXYhzQTLd4HYhzTLjfpUWZCgUWx1AEXLC7xSvCf+BSA34O1LdpySQp0xjnXnkxRhl0n7uHNggpjiDp/5qIvx6aJHmpW+QM6NXnpC4a0j0b0/la83gsMURd/8ksAmwq4MMh3trrTwLCtt9t3jXyTzx9Db+cyC94vU1GZPmfc6Jff8CjtSPoLU6kxa4YwphQxRaCxUGefiYaqSR1l5+VUiz/zqua7FqDCj5NJq4OHeTFELLOwceO9RuYF9+7gcdKXAjXW9kvt8gRtz8DiXJRj+uV4KjEFAM6vMP6hfeF5MJY+oCCCNyx91sZt08FC03/EdyKnXO76Y4NbjuHn6iqhZJoDV3vS5I9pI5FUJZir/MQb4oYnTi2L7Swb0iplqhM0JkctIhY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrXYSil2K3zHZbt5GxW6i1UbQEPaH4Rn6CVqPvZvD/uzVqajoD4/tId6qQYx?=
 =?us-ascii?Q?hhpJNgpaaIc44LxJp/BCB5AcLjHnR9+UEHAoVAvT2AIAEXDLiqIAeMx9P1QW?=
 =?us-ascii?Q?v21BD37l/xxXZGNCDRIT9hZaLRlssVaQDdnJj4pzgEhhFiHFbZhw17t6OVMp?=
 =?us-ascii?Q?BXZAWlNGbH2GLD5N1eJJI8T9mO38Ytg/kaAsKJucPAgUW7M8ltf2JGF3Ey7M?=
 =?us-ascii?Q?ZmVcAdpt63uh36RLchj/8y7CuwKrVs1KfcPLkoAdGz0/SqTjbKbyiuhvHGvY?=
 =?us-ascii?Q?QhIsGyZY2ybOrhrmE5Tr0z+UMfilcP1oa0G5AMc48Ft2LvdRjdWeZIpm0cbe?=
 =?us-ascii?Q?Zc5VBCy74TAtpLni24mIXmVcaCvQq2KmLsN4a0qsY7qq3mtMCE9F6zU5K9E1?=
 =?us-ascii?Q?jyCfcKFlyVS4RtG9cnSwx/xc7LZRKBWibcl1QpNJH7v+tBsgmr1zxxDXx5M7?=
 =?us-ascii?Q?jRUi3/hxOzMvMD8NBrO1EtGdqqzGr6HSIGCFeFp+0dDungCe5INYwvDJcXQR?=
 =?us-ascii?Q?zFBfOgj3FRUR4tQJ6qws4QzXpgYNI8sewLctUyV2W06JV+HCI1IFZHvHHPmf?=
 =?us-ascii?Q?9bLKeriTCV8MzqOOdY4BJGNoi5doh7U79KAJclCRcWk1l498QUtnydzPbdba?=
 =?us-ascii?Q?7amU27BJ5q1IVwUZ2svZ9kwkDeF0f+ArriVEO4E418dXdXmCnA76B6UfvNOx?=
 =?us-ascii?Q?oO/rfpUuijxf9PrWMX/qqkiDr0H28tRPMYf3GmkkGkZA6iNug/OoKum5foZU?=
 =?us-ascii?Q?kMM4Ht2Wm+mgKtho5lntQE6kaigXfsj0v1xZbvr1EWdzO+cBr7b+nkvmHL3n?=
 =?us-ascii?Q?W6T7d5Jgy9lI7ce9ybHi9KymMOY4a3ePdww6i5j69SN3GQSuDzrqPtGYSClB?=
 =?us-ascii?Q?aZZt6sJE3NYKC7fN0ucHg98F1d5JJKkzeVy8ajqqVassfwXYJ/L6on6K9kCg?=
 =?us-ascii?Q?o6biEQaG/evRDei5CZfMjVL1YL9eIKFvcuHKP+HKLv+ds1LRSK7y/p5Hd9hE?=
 =?us-ascii?Q?JWNf6t5lVajn56AcMKpsYFMCOb1QXDd/o+Vsg/C41ABIC7TJPXv6aMcqwOO+?=
 =?us-ascii?Q?BEyM99KfUBKE4Q2rEW7DAMfJARnh9LbjOfyx+NDM0x8AkZt+IA1FuptettPM?=
 =?us-ascii?Q?MA64Rtd4P4eeePZpM1GRY4790FSJDKHLtdpPx5O4rYOxE0Q+5cF6pNeLqlIu?=
 =?us-ascii?Q?IO168/Ce7USKm5Aw/j2iQkgIEftMK6U9KjxOkl0C5NbekYUIZAE5J4EpQ8UQ?=
 =?us-ascii?Q?X2FqUnrGM2yYL6uRn1nqe+83ss77T1AVJTZEgYk9v4+7jzWluXN4n/1ni5xp?=
 =?us-ascii?Q?WUFrv4k3Ou7c56pA2+BSiR61JTan8OGdC20KH+qUYPlb9GfUcLVnqUvReIgH?=
 =?us-ascii?Q?HgB2ERmUJeDFYhV9BvBeXEhThbG4bL0MRgAJUgPzuufGv3Naj30yHqU32R5F?=
 =?us-ascii?Q?O799PhlG6Y1aW0ecKFoaqjRgiTeIPzMnVOS9s+SAsWkQQxyL++jKHgpstgic?=
 =?us-ascii?Q?Q6qkKsfePhdnFmjC8IgE8FxxSIwbjI7WQ09YI8vrH2tOkGVbUmSvFKRTTyE3?=
 =?us-ascii?Q?JyOp37oE5hiGm9lHAr0t00K6dI+Z0ndj773nUjloAJQRQ++ZtLMZ4gBwtkXb?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a67734-bd78-4459-c526-08dc4500e42c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 15:02:11.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6vxaPzBmJV7OzH4oWOQd0++Zo5uh2IkZyhGZxIs5PynJY7yQkvSL5M9Clwn6YQj8wDmwp08oJSjqC+VdIlL2OUSfvQGpcnpv5P6AxU0NaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

Add support to update the transport configuration

---
 profiles/audio/transport.c | 21 +++++++++++++++++++++
 profiles/audio/transport.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 159fbd575..122c3339e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1483,6 +1483,27 @@ static void bap_update_bcast_qos(const struct media_transport *transport)
 			"Configuration");
 }
 
+void bap_update_bcast_config(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct iovec *cc;
+
+	cc = bt_bap_stream_get_config(bap->stream);
+
+	if (((int)cc->iov_len != transport->size) ||
+		(memcmp(cc->iov_base, transport->configuration,
+			transport->size) != 0)) {
+		free(transport->configuration);
+		transport->configuration = util_memdup(cc->iov_base,
+							cc->iov_len);
+		transport->size = cc->iov_len;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Configuration");
+	}
+}
+
 static guint transport_bap_resume(struct media_transport *transport,
 				struct media_owner *owner)
 {
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index b46bc8025..6df419a67 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -16,6 +16,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 						uint8_t *configuration,
 						size_t size, void *data,
 						void *stream);
+void bap_update_bcast_config(struct media_transport *transport);
 
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
-- 
2.39.2

