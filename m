Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A615E1EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967704; cv=fail; b=kFMw06omgHxMIuNCJgTczlDPlY6o/CKXR1tY8cplKcjX3bWqg7KjN2L8iTDEeqx/VMLrguyKKWBNmdedVx5RENTs8Ol3/6gGWdVxwkqxRPaURjLl/bJHXVQzlILqkibZoRG3bbq8cW+bhQy+e3ux3kUL4gJsvH4jm0PfxPHevaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967704; c=relaxed/simple;
	bh=H6l6yphTpbBr1Cy3bMU3zlxBSN2pI5Psj62hi0RwWuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KHStgpqyQmvdnGJzZgyt/Q6Fv9axljkxGlVcuDF8IsbSXZaRvU7nkaGnDdbp8yMGvBo4tExfKcERmWUO31GsaHLxKq5eqTkikcElcdskiutTsH+rW7v8F7CRF4s0XlqcuaOuzosY4p2HvAtncaH5ovP4TnTwc/qE7q75t8gRiYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oqbgWqcO; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oqbgWqcO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sva3kkBaxuFvCMiWjoDqyNaMFmVH+pHfwLoec0UWhCs4Wp6024Qz1b3sTmu9335M2s1Js4qH5rp5o88nr5FuilXrpNt92av6HMD4syjlLlGC6j9ireitVxgQbrA7GOSfUwpMJuGO4AbOoVSbyMK8icTCuIFwzy80qmGiYqUaGu8QHrIr5GxY6/WJHg7An0cO+6SKOYvhX2ob6FijMI+PCEqX62z6maMoW2iViTmShWO3SvB6MpKqz04E2eiPcliVfxRumy1s5e1RJGn+fJ8W6ThB/uiIWJ7BOEWqr/ExtyXv5cZUNilCtzrYEqwi0/e5w/4UkCXqIaA2RxRL0tf8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH+3gCTsxHN2VZwc3IucOef1nAfRk3hkcBArv6SwSno=;
 b=jriCj5HeJK1yerddhdHLi2XCBkFBkFH4uamYYFJYh/Ff2Ju0JSrQfzqjYVMfFkZHw5Za1Kp2Z7lvyObfC9i6CBZuxwHEZwXqPlr31APmfrJI4l45cfuJ6cJfz0SIH4SSf7MnjTED23nfD8nurkCMeWks9gsV6OKhVQsf1Cz2l6dO24TfykzRmUIrGFsFlt+gu1I4Ns+J2jI7xv/xsf0KgG6BqSDQvBS698t0etDUTkIL34lX+/9Rccf2qfiIaZcqEw9IfqG4me4ECMt8g5ZYqVzi1ZYryBeHRg+qgA1yvePB6yxc5P/yYj+U05zPTN9KYJ7hbHbHaONbo0o7TrbXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH+3gCTsxHN2VZwc3IucOef1nAfRk3hkcBArv6SwSno=;
 b=oqbgWqcOtkT0ossnR8xFCfOl8hpgCkAGv4091hVXdn0XdHwueUwnJSi1TDn4GCtXs3+xdVD0Oq0WfVmUekooWD15rUlxN+5BxIY8Um/ykPaA/qkNRKUJGsVJZlhHxC3B94Nxg/998CZCerYgPghKaLaGvH44qxGRNnt3H26oK/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:08:18 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:08:18 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 4/4] bap: Remove deleted devices from pa_req queue
Date: Wed, 24 Apr 2024 17:07:41 +0300
Message-Id: <20240424140741.73899-5-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
References: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::9) To AM6PR04MB5384.eurprd04.prod.outlook.com
 (2603:10a6:20b:2b::17)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5384:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 53041280-a41e-47b3-dfea-08dc6467fe16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ArLuB8y4VDBfxkf+IjxB3lxdcm0pHxOvHCq29DQel2+ktCWSMQCYxCHNyE7e?=
 =?us-ascii?Q?hjTwS+yMjTUR4ri/S62LaXmO7anXdMO/k2YiLEnmNkuUMeR4/60Sd3jGih/i?=
 =?us-ascii?Q?IoPHN6rFqXZFfgOQOEtLOVcdrJdlL8ffFF5322G2UQ4dEU8O4cWIyTlv1ZXs?=
 =?us-ascii?Q?ZS6R+wYQjMqklAKviIS7/PsQUkSZLC9HG+FYas2oDHq9OpHy0hsEEENK026m?=
 =?us-ascii?Q?KLAtMThsUFa1FsGmBLWkaIiPlfNLVrKXWY/tlkPief3kJnkGySC9dApRjxu9?=
 =?us-ascii?Q?lPn/ndjFXncGVxr3QpJcizvz08mO3CwPa9TAXaiCkui2tZAqoL830ORmjzzt?=
 =?us-ascii?Q?VbYAnoaLLN+S+UUpTv/XfWRYys3l+Bh/bJZailNgSkj/ZuQfLNxCcl5UBm+2?=
 =?us-ascii?Q?H+7k5mrY+Cb0TtuF3Xqz7US8J3fewHr1a0P929HUv35KG1IMRIobCkr8NRtL?=
 =?us-ascii?Q?2d3yyAanWS/63T3f9l/gylmIkGQA7RElaLnItjOz4Q1jWkexKSTXNDwoT+51?=
 =?us-ascii?Q?eupLUyL23ttkhVVbZR+38X9DunUy3AKGxmp/24k0d5iysJZLvthpXY2ocHTs?=
 =?us-ascii?Q?AHqJ7t3Vm6vME4buD8xLFOVZ/rLG17VPgHm1LajdeQajbNk0uI3ucwqsO5Ig?=
 =?us-ascii?Q?UxrLVJipZLajGgPFyE6hEJO4VIzB5p5J3fVCiaS3WH1Ddsqw0+CTSnvs1PPy?=
 =?us-ascii?Q?VFBqZpDebBkZNVXv7hq8Vvss+/BnQ2p42bkQ1mPpUZEfO1o7MCAEinnerD8h?=
 =?us-ascii?Q?LP7CSK0x/UeRuCgHzEtuDE+5ChEKmPCrsy7uGOxNRzYSxOD2m4yxDnxRzRv7?=
 =?us-ascii?Q?i3ryA4FYQ0UhG0WtUK5HhuQw2tthZx+zR8ECnGIzcd2Tr3/Q2VAyFZzerGDz?=
 =?us-ascii?Q?ffwwdzG+H3v5MVJpvq1ohF1kf7PYW5XbykxjU3yvwP50Uhohomuo8EkCGOrT?=
 =?us-ascii?Q?h7sGjCuxtolgvNeLiFunUhyBCqSunc0yxNx5cmlWkJ5aeus3uKVX7MBxwBvb?=
 =?us-ascii?Q?rxpCAQKcaXW7Lrd4wfC72wDk1/261+ZbN74VYlj9EOtdOvA8atKFbtU+X91M?=
 =?us-ascii?Q?GG3y4pqMVoR8lob6trOEk/QtVK9m4lq/MY/3a/zbrgrvg44qOJl0nqgBsNxC?=
 =?us-ascii?Q?HRyRq6KOebIMG2vqoSJLkh9b8NlQoMMYGosMlphROA6SmkM6pbYK4DF9vTAV?=
 =?us-ascii?Q?N/lVYpjZe5Iim0DOl1ws9htbtAp34EOoPtDAuTmkOUEYCkLlj8bUOPtRaG1S?=
 =?us-ascii?Q?2uOcDxH8wRW/9/wUfZ0VY043WisUeLBzObPdy6wD7yv7ALlJ55onBT1/kn2M?=
 =?us-ascii?Q?Wby6KFcZ9QABKVKrjl2MLZwRx/vngZbQ0unJaSgt9WzEBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AB9oavMXoUUBJNxX0tqh75WzwFcEME3hmnnY0a3ih+8xq1UpTS9PIGq34/79?=
 =?us-ascii?Q?v+0JmPmrwLo2mTAp2q+0tfIqzmLB2u4Bk9ifmUJP1J2WbOIMndVi9Io0Chfr?=
 =?us-ascii?Q?2xRLKdb61UXpM4mvpgL0QGp1K4Tt9mIqhxmXQe2l4r/K7x/2f37Z9CMfcSA/?=
 =?us-ascii?Q?5OLldY+9iSPNotafjmwVSJj2HGlwc7ZDbBAhp7xK/0mz7JkIkMwpUTpJhCBF?=
 =?us-ascii?Q?wLO5SrcAq89Hnu+syjFmDSV142j8QpoDcZZFT+5VYws/NFTCOXotXsAoEWg0?=
 =?us-ascii?Q?jJ7Smq90RDLmOiPlU+aIPfpIjDKKDWZhhJk92G92NeyxU6vIfZRWbBkFBIFD?=
 =?us-ascii?Q?gIIe1VoWhHIhmwhA6TRo17l2GKxO7JTGLO0jkaI/NZAW3xu95AdjO2gF4oLX?=
 =?us-ascii?Q?vfwvWu6FdsHdIZP2n3ss3uJIvsaQUMhHfGdiigKWDFeRVc8i/7DWhCiBiqqY?=
 =?us-ascii?Q?DDF8IAAnhjPVr7VtYedqFs0NklmYJtbOm6XPVgdiX6Q2tMStzETwRDk6IN1g?=
 =?us-ascii?Q?Re6mYBbhn+M/tq78vdRQ4rSkBZuluw72ELUxgelL7sarV3wvp+PKMHR2F/WK?=
 =?us-ascii?Q?3KVGAgeeSGVDXrIQhfyUY+DLVFUkXvM80cj/9MEeRv/YbSREkIhlvHFKH1g2?=
 =?us-ascii?Q?hu8A+l2SAQH3ixOO9BzAgR+sv1G/wPlpFimMv6iyXKSmp5s/BAS16F1pSDJM?=
 =?us-ascii?Q?SW4pAHaU1mCenjSRH0sIP0Cut53GDPTZRkK0Mds3jldfVo45Y29f7X8M053D?=
 =?us-ascii?Q?mP8HjlYftkDeeEUHAhHbq/eUK75g01c1NWJcSPbgEY9qHuxa7g/Bgj2qHxqp?=
 =?us-ascii?Q?g+2qwxUryRZu+lV8l3LxVR7NONsqbwzul+K/VjpidXQNir4+gYT3l9GA6NI0?=
 =?us-ascii?Q?xUMFef8r9rPpoJBRF1wxoEzYF3SXwuyMjoE2x58NQjpFOfdr4BZobsHkBY8b?=
 =?us-ascii?Q?yE90C4cliC3Mykr5+I3CLK0c/vlGnITmXIfER7OuejYP8opggbCezcAgT+3e?=
 =?us-ascii?Q?UAft54Q2ht2GBMqzg2PNgPZX7ftk7PrM8My4NQZGc4Yh4lxURhP3mt4LL9o5?=
 =?us-ascii?Q?yYgwyw7U9KTtCevBztHWSTLfQpeeKqXa5NyaORkm+1fvbZ3Yg/RTSVE0oAkU?=
 =?us-ascii?Q?AoJ0lT7vaEP6MRylKdv+Y0pPSAlBzs7UlmKAmgkfaHFrXy/rr1mbPEZqajso?=
 =?us-ascii?Q?VRt0dRBIQHVMNhtqwBhF51heoBkdktpewNmPkfZlZO2If1nCLogb2ofZFSS2?=
 =?us-ascii?Q?vNKF4r091awM1jdTgy1/VjuHtWw3M8KekvkqEhTLo8dadjSDl4VrE/8svnJ3?=
 =?us-ascii?Q?RzVaOeW/aC487WHyMXDKVjtnRp8eQrfB9kb/Lhs0RXzF6pt/AdiS6lUNlQOT?=
 =?us-ascii?Q?mz9iTgupgOwmSrmUtP6TmZ2SdNf8+4m8rELKG5v1VB3TMF0PnFR17ffqIja2?=
 =?us-ascii?Q?Z/M2Az2LhFB67v7YBu4ddfbJQkReovv0XEdURRjMAsn63sI0ns57zaChG6ZS?=
 =?us-ascii?Q?s9YZW7T5cXMwbXEbbzBAgCTC5hgABQSDDP+Tmt8wlhCMcwKK1Zrw726QUWKi?=
 =?us-ascii?Q?waDEEN5TsWsJRHvi1vi7+k3mux7y16AdSdlJlEvk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53041280-a41e-47b3-dfea-08dc6467fe16
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:08:18.8473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SQ4FrFGypDAoB0t0IS130gv4gkKJaKXcEe2IXZvKfOsKuvK0EIYEoEG7McU3ocTJvtpneV12+4/9/rxU1CKqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582

The bap_bcast_remove function has been updated to remove from the
pa_req queue entries of devices that were freed. pa_req that are already
in progress are treated by the bap_data_free function.

The lookup in bap_bcast_remove was necessary. The entry corresponding to
the calling service must be removed from the pa_req queue. There is no
other way to get a refference to this entry other than to search in the
queue.

This patch fixes a crash that occurs when a device is freed before the
pa_idle_timer handles it's entry in the pa_req queue. The following log
was obtained while running an Unicast setup:

==105052==ERROR: AddressSanitizer: heap-use-after-free on address
0x60400001c418 at pc 0x55775caf1846 bp 0x7ffc83d9fb90 sp 0x7ffc83d9fb80
READ of size 8 at 0x60400001c418 thread T0
0 0x55775caf1845 in btd_service_get_device src/service.c:325
1 0x55775ca03da2 in short_lived_pa_sync profiles/audio/bap.c:2693
2 0x55775ca03da2 in pa_idle_timer profiles/audio/bap.c:1996
---
 profiles/audio/bap.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ab0b96222..2b1ed501b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2981,10 +2981,20 @@ static int bap_bcast_probe(struct btd_service *service)
 	return 0;
 }
 
+static bool match_service(const void *data, const void *match_data)
+{
+	struct bap_bcast_pa_req *pa_req = (struct bap_bcast_pa_req *)data;
+
+	if (pa_req->data.service == match_data)
+		return true;
+	return false;
+}
+
 static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct bap_data *data;
+	struct bap_bcast_pa_req *pa_req;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
@@ -2995,6 +3005,14 @@ static void bap_bcast_remove(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return;
 	}
+	/* Remove the corresponding entry from the pa_req queue. Any pa_req that
+	 * are in progress will be stopped by bap_data_remove which calls
+	 * bap_data_free.
+	 */
+	pa_req = queue_remove_if(data->bap_adapter->bcast_pa_requests,
+						match_service, service);
+	if (pa_req)
+		free(pa_req);
 
 	bap_data_remove(data);
 }
-- 
2.40.1

