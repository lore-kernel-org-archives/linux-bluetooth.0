Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D521D4142
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045353; cv=fail; b=Su+uGjM4CDKBd8uLuHBFaCh+MiuZyeYgBn8CDl9+RZGuW/ytiyg1ILanb2utdpafoCHNgG7X6pRZSUVR3AqtBTu0EmdG1c96URO5Yn74uOtROGBh7rEBZ4nc+KnVEZKoB32ojliCEGfdAK1RaR+Kg+N1OvOyTUlJ1QBzL6T3WvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045353; c=relaxed/simple;
	bh=WVDio6iGCi0OiqsZ9MPP1bJkXBkYa2+eLsFk+B2shcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTAVf7ZllXl+uTxduwyIT5Va5SXUsJsPo6zQls/FXqzuUFDhCretrLoM+epgNffP5I9lEmW9HNk7LwH3XeZa2Fjz4H8dSu0A7mWy0hkWo0cDjUjxilpowrsHsBB+uQjzRI205LaBrhcHaNuTFQogFTblHen9d6uZHCH0RrFTFXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HlXbPk89; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HlXbPk89"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4uz7Ub4ArWD4yaOB97KXmHj4Q2jyrvYbLXA+waAzYI8RQzYgvpy9qDnBW89YOpTmstUVTAhthTZIpliNw3GqcDFHR/+yxxxWjW1bwPZ3pSZwwlIBUbZ97Jbpmtx9nTw/c1K4hmSsKXNr0TUpN/oKNfFGzqK3WPyTEIfEiXn+1ksdfP8NFo+9e4P32QKUoUk6FMFr7cJKQOqFE9v3vaYEhZg2HuZsEuwkv9sLLSq3MM3Nf3XFJTlTZsp7UaywdxVdT6pYhm04T2uzjiPmeRy5ohkSQXHus1XOwJb3UOLEpPAMCl6+nlF/vcFLGNtCbFKiEUYDh5cQ8NN1i2J1grnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0clqFoTmEpC9f+GG62Hv6DMAh1H5CzoA1IJRXyaQ1g=;
 b=U+Vk7dB4yO02BkEJnUvglu4fuuZS9LQFfQHOZdWDtfOGv+WbPvtfOw5HqLKCKLVT7kZ2/+2Br76WBzxCwRWyNAlBrEZv60AKLscbSmwSFj5/pn3n4Hlj9nRTeQ1beBAceg+vo2rOzcDR57BibD6jCTTOrCG8KYvoNy5U5xoibmjo/fshreYmbpaev3f63r9Cm2xcpOBwEncYq9zMfMctK/Khznk+NCt1SwE/QaoJgEashwVaTkfbwuw8MqHvHPYw73cj+cSsG2Y2WoOBV0UhvfnesRWvIZhhmA6jVHdjMKmW6tUjsTXquTypdCZXXPPH0DN70hqkpAYv6+A3UHu69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0clqFoTmEpC9f+GG62Hv6DMAh1H5CzoA1IJRXyaQ1g=;
 b=HlXbPk89AbafzRHG9w3+9vmp+Ud5qi03n0jDN4gZYDIY8wLmKXgs+moiEe2RrqZCvc9iGNn4dl1nksCccRCRfPMkDwCD8yd5+YNBvRgGpYDx62n2D9GqhsSN8JNSPCcu+U0s8NXV+WLGaqePdOMUupcPbQjDeqQLnp+qz0Hp1wFMixf3LgH//XsCKHJGtatjkw3YbmaWBa1K3G/c8IOOf8I6kbA6531QmKq1R7B6DD8DrnXZTIf8U79kSCd+68zXS51nh+mrFySr5BJFS34/B6dLqJhqDXJW0Sw/ivEExYSabt29ikg/eF73f6bXxaWGIMyOnybhaNGFAEgPcdu+Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI2PR04MB11075.eurprd04.prod.outlook.com (2603:10a6:800:27a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:49 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:49 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 6/9] shared/bap: Add PENDING state for streams
Date: Fri,  4 Oct 2024 15:35:20 +0300
Message-Id: <20241004123523.1012743-7-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b50e79b2-e336-4d5a-190e-08dce47113ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6V1hRWlOSBbeb1Ekq2ADiOlsyyGNw5ej2fT9L1S0eIatlc0mPghf5FEGqjgp?=
 =?us-ascii?Q?02peqnbosJD1G8oq+59GIaReggO2uaIrkY/bB+VgeJdJnUzT+FPwb1jH7x9T?=
 =?us-ascii?Q?NJL0w3us8WT55ASrAEBbB8m68OWsnUJht7Jj52iJKYd2aVpffO18a9B/+isg?=
 =?us-ascii?Q?StBxsztB3TbxZhNyEyDFSKUkdd4JiE9+8Wyi80B7ioBt9HKaBkyXh35cPm4s?=
 =?us-ascii?Q?hCZp/rSwXaj3C/EUQdNEpy26VEVqZWXWcUHnwldxlG+wPlybJcE6QnhQW8A2?=
 =?us-ascii?Q?OEIbdZsJFufCWvzQGvGU6BYF0D5DSzQdgUZJjd3CtCPwADrup6Rs0mB2Amw9?=
 =?us-ascii?Q?Jfm9lmqdb3/OBk0N2fak9JwSj6fdiSoLkpYTME0NluYvOs+llhJaWgQESMiU?=
 =?us-ascii?Q?q3NRYW1UM96AF6XdWzjOeLqX+DU/VG4XPtnrj9TdhKr2GLidJdoU8cG7YUlA?=
 =?us-ascii?Q?48EBIM8d5Ni8wieo1cA2p7luMUHR2IESYfmFRpaY4tzzd/pa200Pru+R+Jnz?=
 =?us-ascii?Q?iIA+KfTS4+2zBittRAms5C4Bu8jkOxx4s4gMrSpaMVY57XmeQP90dPjohCSz?=
 =?us-ascii?Q?2PvCw43jehJgncq5gu/vuPpeavOuNPgmSeGI9TxTRlG+sQHMvB6btbduomtK?=
 =?us-ascii?Q?Fd1ktqtE8XJ3VlSpqXhfjbi3nKPWB5LfIJjxJA3kgk3ysOlqEw6ZcLG87AWt?=
 =?us-ascii?Q?qzgevVNjYfl6RAkw9IUpa0WBu8kQHzNDEbI6mEEjHSsdg83QSrF3QxJosO7p?=
 =?us-ascii?Q?X3DbLifPzTVHlMCJ8CXEktLnwat+l1SAGdNKTVd9alP2yfQLExC/E2lB23ep?=
 =?us-ascii?Q?mNaMKIU4puMlFH4FLJTHmh4rHoEVmCCPGknFR+1nErfbSKbq/OLH3to/zL2F?=
 =?us-ascii?Q?q0IaRacYM96idNnkNWe5Qv6bDt+XqcMvve54KiBte+KUytJArJblSA7FqHiT?=
 =?us-ascii?Q?EzSar69+sCL57fR0zDsIJ08C0vDy4lnDUh9cDJuYpeIV7MXMnfsouK+pcMuo?=
 =?us-ascii?Q?Q7lMG73e18/tEbp8SSJc0Ldh76ynNe5WeEDhD+HPQmDBMSLkaLzzxBhmolNU?=
 =?us-ascii?Q?pWx1M9JkhA8V5U8fNya7FpccmDQac/Fv3CiWPONRuc3wE6U9jf+v3SaCj2EM?=
 =?us-ascii?Q?YplGat+0ZkzXIhkyQKWO3yfKfdXX5n7kw+MY/TfU3oHaMbjtk5nQufP0djcD?=
 =?us-ascii?Q?twSzt3DlQktHaXF+jIaa0mOxqsGhNRMzow+lN5FeSRmNox6UOVwKUHIn7zhv?=
 =?us-ascii?Q?igPk7F/RZh6GczAcsa6n72cwnR3QXR6mw2oMARkibOJqwJ8QqHr7ilWoVfN9?=
 =?us-ascii?Q?a0ZkON0fzBqyJTQ8FkwYUpy1ZV1kghsuVTYxF0kvAWCwbQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NksZJhMtWWGxSfu9xrCiJoJBw4r5fpluMzPwGs92vQeJcgtj+7PQ/DZRi7IG?=
 =?us-ascii?Q?ndlJA294axhUWBNygJFfKEp+Hm/0hCln3mvdhZmporZJFQj77DAEF3HJK2E+?=
 =?us-ascii?Q?fxllZM5JPPrO/Osq7wzlVktGGM1SJz5AMPHsWEc80BBSf++3LUG50aCPa2G6?=
 =?us-ascii?Q?sMTRZXQ9eIL8e7zy0fEEq46JHXduZq95HG5C8uyrWbgpx6kOYPtz1OFZ35j6?=
 =?us-ascii?Q?opPF/S2jXtgyk67mhwZ4p0UcQX4L2FCDoC4E9zduWFccOITbiniqo2rKszSS?=
 =?us-ascii?Q?KSygdGbtynC3GhKVakm14ufXYd/YzcXqPVVc/c61Ww76JvdspicMIksJ+Oe1?=
 =?us-ascii?Q?4n3pa5qDnqzY3V+kGV7CG7yUI/Ad5F1a2cgn/vZndnOSnkJGeadqt0LEag9i?=
 =?us-ascii?Q?rADpLghMsJ9R3kWW9wf3QQXwvNRwWeYPCQjeYA3cdm7ISaOfCGpGsKrsL3Xr?=
 =?us-ascii?Q?iKruoFwd+8/tGv0yxTkj26A+LBGskqVoJg+Z25DoqWdayVX5HpGVBbuh8aFn?=
 =?us-ascii?Q?6YLD3WCBouGwS9IrvCpNBF5Kn3wjzXVBRKV5guH8iEApMB8Tzbj1QPrm659Z?=
 =?us-ascii?Q?DkFZVwRcMdLWVwQpDwSGTO0HjegKWkgG3ocxgoCaq29Nvs8if3argwn6ysC0?=
 =?us-ascii?Q?JyfGnmSBiR1tkxl0j1dCclPcNaw/JU+fQzGIVu4jYNPLlQAup2RAYznJv3Kr?=
 =?us-ascii?Q?NdqJDu1tAOTJLLAtWpgJqsq85jviphu5SbzDEoHgVo6/JHZfSfpZneHhQRZZ?=
 =?us-ascii?Q?u6IZDMTSenM/CkI20TwpSaoWt2kVQ3ZHbyzrvVcSaqANMM9p4gzgMN0JDR9h?=
 =?us-ascii?Q?CNnI6GZvIZa/9ez5zPTxsmeCROpGR1TJLLnNdGjJqHOFfHKGDzlqpghfYVeX?=
 =?us-ascii?Q?rzrmPkDntuS2hH1NX83bLZLKszRqLmW1oyqsVmnxUnF2yGTOkCeNs6NJPWFa?=
 =?us-ascii?Q?KOj69cXZWGmy/1kj2+ti9CKyyFuvEwU/Q366GQVZvNDk/r8mlg8fDbtZylui?=
 =?us-ascii?Q?yuK7fWlKbIpPM06GmVAzYU1jY8FzCbdTj642Wtf0jVhQqLwxRzmRo3Uhw8bn?=
 =?us-ascii?Q?9G0wnwJyIEkxjoVaSQgVhz0S6kQ21RT/rroeumdeX23XVkUa7eDhNI15quic?=
 =?us-ascii?Q?efwT6VmLt7bdhFUqBxyc8hJXqOn5gl2f/Trdb1Kq6AsH7hMEh4v8+9VOlstJ?=
 =?us-ascii?Q?xRwZmSCyMiuhP2TsyX+0CzvWAqKNleSHpaUdY+4BJQu1HdKRPfw5+7suJKJe?=
 =?us-ascii?Q?M0Wu0Q3BZZsTG4aHYlOe8OKlhI01tFlPgUh+Ml5XqqJWQE6TsWXRF6IflcVQ?=
 =?us-ascii?Q?xnY9Y749wS+WwjcKl+7rdIWammca37iuOaPhuz7vgv+nyAT+uwPuLwsoo3To?=
 =?us-ascii?Q?6j4duGHh20HrC/5wuuHdq6pVTfL0Xez0CVWbH20L1LmfgV5K/w+NYZP4K7zb?=
 =?us-ascii?Q?Xfht6E0B4Hh7YldsoWD0N+57XSoNpqziYvDRd0VyOBvHnWeOSdgwQgbaJQWA?=
 =?us-ascii?Q?/a9MobmxI5VqlUUa1dfbCiwc4CLs2lkI6IkLgHVMVFftODQ7nUHVgsijUJJi?=
 =?us-ascii?Q?UyWRtJd5ME2XwSZWLH67W7vSspeUo58gtuo7hfZc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50e79b2-e336-4d5a-190e-08dce47113ba
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:49.4700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgPjnIdhtRR3TxR3Arn4I/IanN6udOca43aKXFvQVw+zem60scjqYZV+5pa9KmssJ5/tYdTnnJKwc9Oo+NFrXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11075

This adds the PENDING state for streams, which will be used to
signal that the stream is part of a multiple BISes sync and that
it needs to be reacquired. bap_bcast_sink_enable has also been
updated so that the stream ca go from PENDING to ENABLING.
---
 src/shared/bap-defs.h |  1 +
 src/shared/bap.c      | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap-defs.h b/src/shared/bap-defs.h
index 27fefa34f..eba98d0e6 100644
--- a/src/shared/bap-defs.h
+++ b/src/shared/bap-defs.h
@@ -30,6 +30,7 @@
 #define BT_BAP_STREAM_STATE_STREAMING	0x04
 #define BT_BAP_STREAM_STATE_DISABLING	0x05
 #define BT_BAP_STREAM_STATE_RELEASING	0x06
+#define BT_BAP_STREAM_STATE_PENDING		0x07
 
 #define BT_BAP_CONFIG_LATENCY_LOW	0x01
 #define BT_BAP_CONFIG_LATENCY_BALANCED	0x02
diff --git a/src/shared/bap.c b/src/shared/bap.c
index c69c9bf6c..122f72665 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2146,7 +2146,13 @@ static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
 					void *user_data)
 {
 	bap_stream_io_detach(stream);
-	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+	if (bt_bap_stream_get_state(stream) == BT_BAP_STREAM_STATE_RELEASING)
+		/* Change state to PENDING, signifying that the transport for
+		 * this stream should be reacquired.
+		 */
+		stream_set_state(stream, BT_BAP_STREAM_STATE_PENDING);
+	else
+		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
 
 	return 1;
 }
@@ -5200,6 +5206,8 @@ const char *bt_bap_stream_statestr(uint8_t state)
 		return "disabling";
 	case BT_BAP_STREAM_STATE_RELEASING:
 		return "releasing";
+	case BT_BAP_STREAM_STATE_PENDING:
+		return "pending";
 	}
 
 	return "unknown";
-- 
2.40.1

