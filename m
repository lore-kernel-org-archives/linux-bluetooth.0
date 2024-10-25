Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AC2003BC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858963; cv=fail; b=jCE71BZFEgKEXRLqAwBQt0XUXWGMfcxJHkbfean5+PcDezJh27PWy6l4GkyFJMrjhNJ9UIx1/v8jhs34Cy1I0jB4bVrP/hcnqq2f8mHxLyQj/2VBX6NQq6BM6w/4R9oPZudEpBMGG/RKC5WWnqFkm5PJAm02wXJZ7VWe2MBgwLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858963; c=relaxed/simple;
	bh=aptpSCqH6pxjKOB/xIFyw1qsWYabgNFS7EDrumA7kxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gLCWVxOJw0phsc76ZPwLEuhN1ZmRUj17mWTOnYUJnlL4DVj7Z/3ao9JxXRzIM7CzoSO9xmY2cI6fPqq2d+vpbIbDckS9N7fY2NB7bE+stZMZ6jlGrITjvOxL6ZzyQuWiga8QxEgDlvPn+T0Jd3aPxLDNObqFdVUkZf4hHvGvhpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bKEor026; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bKEor026"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsTjzfVha+6n7BPay/2F6O8NdhAcJit25BqSWrF9k8vZWa6kvXh0tWT9b9J0rvaIZrhBee4/WpdTqPa/JR0TXfHoaU75gJaZ7rl9nbpWflHCAYC70b10yQvGnaFzJ3QDZK95tnMXmq42v9CoEX0e0f+WB/aXctUoq40BT9tWXmDEv3UXoExHckov5RXOunBnAsqT/mexHBiuOEqwsk/E2PeXU3utz/5AOBDt8/A8qW7rgY2Eh49rsbkKvwG6vl837nu5M8a00+1Zz+R79KvZJiKU9fK3VCvo+9VajPWkHGKgOSra5qOPCiFX0RgyNw90HNBWvoyu36IKCxlpxJXtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2aUKoPzRSyH7ntYn26/cxnlFeEcu2EtfFfDD2XBHlQ=;
 b=wW+ONM6gOQ++irCr0ljg6olrSBe790oSiOxBTD4KO/h4wVD+EeRYQlIG3Ubg9u5WXka6piAIlGNCYv20Mcy7Qmcr5PoXkz5gYeXj6+ouX2P1/8X6zy8q05kE/lmRrp0cIY35MUKqkehwXfzN0D3Tl+QL1TiR7ow8EwFhBdBCW8ZxUfdlixdyrYa46e4f/ClYaJ3hP8MLNvmhCtCLg4mTtKtDGFoOcp79j/1pfoNSzl9OWczN1ORV4cBm76I5NsxaWpGOgX90A37/YB4DacBGeRy7M2CysIwTTLBLCiMH6aUB/VAKtLFtfrW7KR0NTmnGE59ykCnJIDH82enkm3Rs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2aUKoPzRSyH7ntYn26/cxnlFeEcu2EtfFfDD2XBHlQ=;
 b=bKEor026tK0TFkwZ5L5Pn8rmea7iTyC9I2EBHzZc+OXZMS/Js9m61op9N99H9JXZY1Q++taC+XdoS5FsDRHS9hdMQQHhi05mXrHADgi0Y1XUjfg2699oKe5Lwd+NSLjI0MuWtMJcZUxitYXl+N7H28wKdVjlXTruCsfUjdepEZAHJjRpXRSpDBM+YM02sI8or6POrrNly4BBrVb6m1nqq3q/npDya5HUoyOLhLxqiGjYV1sz/EESKtCtkI8EstdSYCtdEHsPx1B7t9t3gY3DntYajcLlJgewzmvP3xw5GUKtI429JdbL/AowOwLRiz5pSs1bDRuOeDnZsVc5UEzQlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA1PR04MB10843.eurprd04.prod.outlook.com (2603:10a6:102:480::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:38 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:38 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 14/14] transport: Unlink broadcast transport at release
Date: Fri, 25 Oct 2024 15:21:46 +0300
Message-ID: <20241025122146.17925-15-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA1PR04MB10843:EE_
X-MS-Office365-Filtering-Correlation-Id: b9aa9ac9-c265-46c3-0787-08dcf4efb6c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gghg6ewZqO7W3Ik7WgMDU8lIIEeRxEQey3zdcDz385Lfybfhr/qDJX/5pOjh?=
 =?us-ascii?Q?z9CLFe2GA12idkI4KpMqvFW18Ee+OKDi1RoCqApreO9KQZGcf3F3h0ScEM/w?=
 =?us-ascii?Q?oeSjRIj7pIfpyha6j6h3i1KFi6URhfjoIZ0abZAN84RQQo2cc0X2lF6Bol3J?=
 =?us-ascii?Q?Mu8GBojAE5R/D2TYoxwT3dPCSoKm93yR6mQsEWARy0WpmT5yhdyIJE6vBlIJ?=
 =?us-ascii?Q?o6xMo2k7fLfzsQ/8mE6yLB5FSuEk50ThvqKufw5kxevOqLY4/wr+2JT4CJJR?=
 =?us-ascii?Q?8yQHZe3ojJSCR5p6CNutedc+8KNSDdrBhN/tal+u8AbWHPOiumHNgBQMGpuu?=
 =?us-ascii?Q?unLi0GvjgcUgOX+t6AEw7g4J3ZAltUVA9bBYWIGWT5Ie9m15KQW1Dts9qUOy?=
 =?us-ascii?Q?8HV7GkQkhKKlhd/Tgrcfk7ectQyFKIU4unP8xONfCeQaCS0grhqnweDiFHtZ?=
 =?us-ascii?Q?uLRsKnEzi4ZCkQs2pb0DIX2mtTdmqi08/iI9sW7+0/P08M8VA1SO0gqnGBm8?=
 =?us-ascii?Q?JNt2ax0vvyZkxfIchRmTHuEP0+aUt25IPDddCrb59oj3TIts9ssqfKMQecvl?=
 =?us-ascii?Q?7yzgMMutdWkOPGT6m93++6fIBf1werCLz/5ixAhs3rBQlefl7HQx+wdWgsW3?=
 =?us-ascii?Q?5t8+P82GJzBEU6klfZaoW9E3CLny1t7fGdbGG5zOo6/8Hg7JXSZO56VxB+hE?=
 =?us-ascii?Q?bYDwEHReZ+fY6bypCmkKlW3QyOqhmUrOZdQjIRyK4Bt5caVmomCWxgMznPFx?=
 =?us-ascii?Q?6oj7+PlUoq8GyJ8BZsTxdcPxQ5Pky9aDcvIdGMWLZHH+KBSlNNdtz4cEHMC1?=
 =?us-ascii?Q?URWDZu/jXLCEBpsiFFfexCfbML41DcVbB5/gIWIKmowEDcyIoNy84JzrlFdI?=
 =?us-ascii?Q?9IVVi7DglffkB3Ml6ce0moyjQgUiibY6GewFtEj9iMI0nJyBsLYFcSst5Q1Z?=
 =?us-ascii?Q?kBtfhYyOMNLtbgJrpXcN2oKU1DUPXKfVsC4WeVD0wHTkO8SGUtz21jDmoFeL?=
 =?us-ascii?Q?5sZxv3jZmW9NxDNzvVKjy92QRQvBhoKAjJl1iqkmVV532C0b0xRmxF9CXwCG?=
 =?us-ascii?Q?V9Lud7t+HWC1QkvFLLTKbrAaz3mTkvE94/heV1/V2KrkQADYHCFa0UGR0GVP?=
 =?us-ascii?Q?TAgCPWx/2homEwDVfkSrBorFjR+IsJIuSKY8SAtMMcJB6Lns00RM/MF6r+S1?=
 =?us-ascii?Q?Osby7PPv+vz0TN51k0NZcbh5XtG/Oct2q1mwbWoS+Q2sppPY+oMwGm+6/qe1?=
 =?us-ascii?Q?QGPdgFcxxI5MTYv6C0mwArFhJkgZbY9AIe1uY37gqRdYOg31VCapbMhL0OIL?=
 =?us-ascii?Q?x9MtPsTSrVR41gBos6nKM9XDSGGhXJwqA8qt11Tfzqenvyu5pzl0Xka3N1U+?=
 =?us-ascii?Q?05PLVIs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CzrFZ0jr46IPeERYCT5B9FQchkCm/rc6Oaaru1esZjCUxPhGiWIG7QGIXkel?=
 =?us-ascii?Q?Fn6FJIpDtzXrIaJKv+gpStRgBbIIfcFmAYgRkSRH8twgpYDZBZ4uw4saq1k1?=
 =?us-ascii?Q?WvH0mn5TsoU7/Gm3WZkfHtakckYX5SQ/PobftOt5BAfaYCnR8NsWJzh/BjEG?=
 =?us-ascii?Q?bdjN9OWyrHggF3jnM349Oh19bVV2nfGW87KmTs2h2HIj5chfps9zieDsGKUR?=
 =?us-ascii?Q?FDFX4+FWfeao5ryuU3qqP8NPxm2AzliidL+3aCoLBq6EHHZTt/001BrvqBMi?=
 =?us-ascii?Q?r5w86r0iKLGfFumzMf5je0T9gG3rqXX1VcVnc9jRQRWIknbKBCKP7bBce/T3?=
 =?us-ascii?Q?Ve5qs6DqlliLgQmq1axGrIphKfz07Z6iFvXkpSOfLxhvghpj2AHycB5HtLzj?=
 =?us-ascii?Q?RScMo+SjXJ6kgz8iUKZy8bEijeLIHs20WFuZ+ADcEgSxSk9I3+BLmos2399+?=
 =?us-ascii?Q?KDySS1YQy+de4hn8J/nfE5vkBToN573maHmRCscO+mMywXKhLnlLSLoqz7Jx?=
 =?us-ascii?Q?PttmxmRANP8aV+1pmohcxt0Qg2xpzy1bXfPFKyyvsLumtvqBTCXRRHxvYyvy?=
 =?us-ascii?Q?eRQs9BpUmXITkBNvbJUs1+1+DtTsA0AvaDb3eBhtF2Ux9ns0M7MRWHbnORFw?=
 =?us-ascii?Q?mtwisz82it7juB5SI2MKyuDAnHUAyQyVlHEmMFYTvixruj2bMFEH16fdoRFj?=
 =?us-ascii?Q?mPscJ7e/WGYFW0xxxBDuliL0WQ3pR68g9x0K9meNG3LzwFBdh4FfLkUI3V0H?=
 =?us-ascii?Q?VRn8Cf+UUNWRgDZdfNQWbyY1XDYSjduiBW6urtnBWp0KicRq7x1vCyuW1+FH?=
 =?us-ascii?Q?+Xts7tGPtp3MmKmJ+bwR81WGlZ5nuKq0y1gmJGjUDEcfd4/e7lM7wn22R8ph?=
 =?us-ascii?Q?Mrk0JAoSIJHq9zYx4LI/E7z+pkm1Ha0BQXdvHegPzCJvxAk/opU9Z2hUDrLl?=
 =?us-ascii?Q?EjaOx+3FnhEvSsQB1KIsTHwrGEaESTUx5t0cwTKtzjisEXS6vmkk6Tk5OAWs?=
 =?us-ascii?Q?7r2gw0N1ppmV3xJ0MkSBATquPbJB1HWBeM21xwlWwuyHJEolAQ8woD4LT+uM?=
 =?us-ascii?Q?U28mvr6xAPg4ePdsyb2vME961jC1pWF+jM++lGH+AfpCp3YPpS1U4aZmCW+s?=
 =?us-ascii?Q?TFaMdszVCAQ1RDo8XUOMO+3FpOtntSHin9ONrh9G0B/Y72uTt8Sa3iolUMnM?=
 =?us-ascii?Q?L4kIxnGeoJ0H2/dh6S3aE89S3IKc2mkews4DJ8xiU1YLC5JkW2Nko93wUJ3D?=
 =?us-ascii?Q?KqJTHNhp3hV+1UxU1tRpqWGvo7o3uoP0plJ9Y0jHpmIpRSogsacFEmbeIE1X?=
 =?us-ascii?Q?UxX9UoiwsCcfqeTKa08Vj6qo9ckPQ2mpkzFRCqDv0MoPQVl7lR0XVkCdAgjr?=
 =?us-ascii?Q?iI9KsQ78OjggsSL9b4t/Eb4OiTwn6HBnDOhd7alagkVEZ6cIfWmwoIL+nVsf?=
 =?us-ascii?Q?4iHyEs5TZ3dsQrV/03UCkAH+qGHTWoohLejfPdwZL21yBqovJxIaUAoliRGP?=
 =?us-ascii?Q?ljgnooHQY+zTLgPSgXoofariWCldjDx0FOnCqY6u+vzg5ARO0Fdc17OsIOT1?=
 =?us-ascii?Q?kYp+K0VUf0Y6Wgc+9qwk/U6dJ2/CiAnLAj0kZqSvBoqu4T6S1zL7vJDCRYom?=
 =?us-ascii?Q?dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9aa9ac9-c265-46c3-0787-08dcf4efb6c4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:38.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+GnzZO2Cakqs1Wj13WXv80PLB4VIGWT802772a+sTtZ/yBFyhDna8jdQIuUlw9qonmgvUfTThkaB54+TKZWhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10843

This updates broadcast transport release to unlink stream from all its
links.
---
 profiles/audio/transport.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bb2ce8a4a..5646b2004 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1779,10 +1779,45 @@ static guint transport_bap_resume(struct media_transport *transport,
 	return id;
 }
 
+static void update_links(void *data, void *user_data)
+{
+	struct bt_bap_stream *link = data;
+	struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(link);
+	if (!transport) {
+		error("Unable to find transport");
+		return;
+	}
+
+	bap_update_links(transport);
+}
+
+static void transport_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *link = data;
+	struct bt_bap_stream *stream = user_data;
+	struct media_transport *transport;
+
+	transport = find_transport_by_bap_stream(link);
+	if (!transport) {
+		error("Unable to find transport");
+		return;
+	}
+
+	bt_bap_stream_io_unlink(link, stream);
+
+	bap_update_links(transport);
+
+	/* Emit property changed for all remaining links */
+	queue_foreach(bt_bap_stream_io_get_links(link), update_links, NULL);
+}
+
 static guint transport_bap_suspend(struct media_transport *transport,
 				struct media_owner *owner)
 {
 	struct bap_transport *bap = transport->data;
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
 	bt_bap_stream_func_t func = NULL;
 	guint id;
 
@@ -1794,6 +1829,10 @@ static guint transport_bap_suspend(struct media_transport *transport,
 	else
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 
+	if (bt_bap_stream_get_type(bap->stream) == BT_BAP_STREAM_TYPE_BCAST)
+		/* Unlink stream from all its links */
+		queue_foreach(links, transport_unlink, bap->stream);
+
 	bap_update_links(transport);
 
 	id = bt_bap_stream_disable(bap->stream, bap->linked, func, owner);
-- 
2.43.0

