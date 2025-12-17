Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023094.outbound.protection.outlook.com [40.107.201.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7D29B766
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 07:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043701; cv=fail; b=gIZ09Ugj/uEPrLrygph3zfx1aqzrYpUtMghFX+UCwL3LSX1Qp3nPETWHIbKnS10sdTNwQoPAGIhqG3XWUZ7qa9YpaVU3ZGCKDSTbU63GWyvidttrVT6cdfzA7zXBZHpQRSUsH8IiS6lGMfPXPju0Wimco+XLI2kRJa234oMdCPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043701; c=relaxed/simple;
	bh=dXKpAeI1Y22zBVu+ijMGYXmY/seiUBaYKcaIC4UWomE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OCyqL0vdXVeLd9qQAUedC/MChxBZABA0QvuK3BEqsd/sZGGyH9FbL2UA8l753+mMLGukOHuqApqtPlrL+xycuv6zFMyUfVsgKpWNFBWeqfkME/SM046jXaxkTBGUzw5rAJPIjQp8MGsgdvb7zh6AuquV03X9MPF/twSmbdn5b/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=Dirp37YS; arc=fail smtp.client-ip=40.107.201.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="Dirp37YS"
Received: from PH7PR01MB8665.prod.exchangelabs.com (2603:10b6:510:30d::20) by
 DS0PR01MB7940.prod.exchangelabs.com (2603:10b6:8:143::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Thu, 18 Dec 2025 03:06:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG4LOEnySk+KjMEJH2ivMl1LVraH7XUTilVfL90qxFZIwhBoJuh+l/QxUdivHChB0OCAvEg+QYuGXOcIM4wX8UGMsKkBzEXJm6gjPJMgcWGgMVt3wl7XrjwukVRlX9Vi7EXh+LLeLzoJjk7Nc0r4I6JE/I1PafKNNyDOigTUR3o2Babcuq5KNxmAeUCDJqm00523uWHODUI3qubusZiFvKksQZQv2KOoagNm8Juay2MBV9W1ct5DyWRo1PsK+xhZsjF8Dkqd1k+QK5eZ8sPn55kwxZRXYL8NX9GS8kiMKEonsxhyD/FqOoQTwvB5VocvgtvswUXRZBFb/kRbnPp45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYDB6rWqzJ1sBUfs6A7T6WSLtu7iGDyrOJGCoZJdYeQ=;
 b=RN8aAtwWZNBTBYWE7KuzGBmdBZDBUnjTP5CH4fistHEjxRSSdu6ZV4ClqgZU3AJJZyKY/YX63ig4LODX2t4PODU2ce9uJ5BYNlgN1jCFMo6lHcXOvQ1AARyxUAC+5lJYXsU8KJiFLIJ6W92Dq9FgLK9SOobQAnKDzD8v5N/hO59xhwV7DS99k8VOS8X0EgkMIMcz5mYYX4zTzbGEyrJ3Obv7CxeYPsfQxGwsOUymkefeH2me6WjXhsdDul7BvQ/Jt57pARd08F+QKF+XAPi5ZPyssFIKunii6E7SVN3ywg/CBT05oH0H0CrczqZ7ltD9fvEuASUxDsQlip2DSUpA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYDB6rWqzJ1sBUfs6A7T6WSLtu7iGDyrOJGCoZJdYeQ=;
 b=Dirp37YSrFNKtIx98ubJU8GS8BDktVaskLrRDxuCl4yH/p+DL6EC7pWNLy+wSvHqAp4yW6QaMAsC/AAGbXKkbphR1vT7RZ6u3810MMtmooB/oqFfXv3iPyBUwJPekZNCh67Frwl3oKcLtgfx+qxJx1PvDuePXOEUwOA3xOIMr67xbpNUJaVgnneyOsg0PNEsYCIB5ugILKxNGo8L+oFfxADbiBc+9X7/CEyDpgMGP35HMggSwiQVooRi+CKKIUfQDJO9/s5fdKsLDZobhLsPt840EOB+EPfNIKcHR5qc+KLi62sXqiF0xpr3qI+7VRfwCKtZ+DbyJHgRjb0Cy5V3KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 PH7PR01MB8665.prod.exchangelabs.com (2603:10b6:510:30d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:03:43 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:03:43 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH BlueZ 4/4] main: Add BR.IdleTimeout option
Date: Wed, 17 Dec 2025 17:02:56 +0100
Message-ID: <20251217160256.441737-5-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217160256.441737-1-ssorensen@roku.com>
References: <20251217160256.441737-1-ssorensen@roku.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:408:e9::6) To SJ2PR01MB8282.prod.exchangelabs.com
 (2603:10b6:a03:540::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
 SJ2PR01MB8282:EE_|PH7PR01MB8665:EE_|DS0PR01MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a649d5-431c-4cf6-0fcd-08de3d85da38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Vr6eowjljsvB/t6lS5/IHumJvq0QFjFVz4yuGtRyhO/C9Kgm4hu4XmkuzTf5?=
 =?us-ascii?Q?IAOwzSD0+rGpYGbhCbDdM8IBQjcFMyfkZFo9PPLz0Zq2CWwrvQ2IxvTevl0z?=
 =?us-ascii?Q?7+rR0baok7Pf4pYDwf+H5Jr5fwKrX3J/3tSI5Jo/EFYJ34xK4QTDToNcgED+?=
 =?us-ascii?Q?qq+h6d0rQuRzxWxwJ/mF31f1w9JEUeDw0qKkxVl3U/4wLbYJCtWgQAJpdcw8?=
 =?us-ascii?Q?X6fG8CU4UMp0sO76EZoOFL70THiucrmJCoJBz1/eSdGANjC75N3oOYcyx3CU?=
 =?us-ascii?Q?yP191etVivaL9qKN28fdk/aUeX1U1E58G01d8WZd4CxI3t4OQ02CBpzPmaQw?=
 =?us-ascii?Q?QYeW5pKV2ZopdmSEoNSZ22AMNG4o2jLYThpdCnzIjxgghjzRwrYg1D/fS0cl?=
 =?us-ascii?Q?aQAwKahmKAJn4msP7NEquDJLDuN6UZkUcIT0U9RfyD1YNC33dQTMBZdNMspw?=
 =?us-ascii?Q?hFu+DcqE9KF+8d3+kBU8lgqqu0J/t/zk1sEg8UsqOcbzsDqB2odO/8HzYEIG?=
 =?us-ascii?Q?8qyb3nZ8RXtdTUuq/OeiFSkwSZU9NTvwmBRE6udRxIX9ic/i3CAc2cf4Hy+K?=
 =?us-ascii?Q?OWx84EWkA4i0dSHMCBwCDsam8dzTZVWh2sKifCt7zOpuvnM2wg8zHtIesnQz?=
 =?us-ascii?Q?4dyhVuZnYirhu9QW7vfmEheCrE0v0gj4roC0F2xLnOfmDbn0B4Un6Ppn010+?=
 =?us-ascii?Q?cOL+JFkwNnaLfY8FlCt63hIPWbdA7nvd2AiEnUQw2wZG4DPMZ+Vk8rQAwsEQ?=
 =?us-ascii?Q?cVgyH6xHuVXaAc3HJAUJegdg4+BNP3IfK00jLiie/vXtFwFN7q1w+N593YT7?=
 =?us-ascii?Q?J7S/XgWZKiStFZmJmd4oVZUuZ8qaR061U40Vr4EZjw4We0DKe1Nj7acJ5W3y?=
 =?us-ascii?Q?jwd9FaAecqeMvUvH+aLq2x5/P1T+1cO+wgQgVit8Elq3iHaTGzDiteTRgj9s?=
 =?us-ascii?Q?5m429MAAfAg+17gj09L3ow8WUkhsXLutmmc68CNtbAbcTa7xgVlbixljmC9F?=
 =?us-ascii?Q?lFjI2FtmqDOH8OYBi6PoJrkTVfJJlPeFyq7Dh+Jsjm/mFETzh0ci6BOiRVYK?=
 =?us-ascii?Q?vOsjnIUcvk8XuCt9/XT5zx2qypwsSC/8H1qftRroIyDy9wKU2hK38lNJ1VlF?=
 =?us-ascii?Q?OD3fRre5s0U90jjMjIjrP4SqB7ADx0T2N4E/0Rkl8cewLA5GNUbV524mhBho?=
 =?us-ascii?Q?HFoBVuEMxuuTpm1WrQzHkhPzGas1fN5Y2pAHa+oON5R4nhIC5eaW5fc1lSR4?=
 =?us-ascii?Q?hWkNqKeRDV7QCYQ+bLolQ3g/1RoTZDmRP6eD+c/wA6IT3H278YupLd95e193?=
 =?us-ascii?Q?oPZO1EPoo5juwtKB6YLf101yBIvFYIZyn0hqYGXq8FKx62XXv0d/zddUbA/H?=
 =?us-ascii?Q?dXm2sm5TozEXuglapgoqnZ+DnX11TwAOJlRchJDk9TDKV8IKjGPfSWWV8z0v?=
 =?us-ascii?Q?mtTdjdIdgPCyP9VEbAWyM9rXoaPf/Dya?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?rfF9W7YXPH+tnKgl6MFO5RkqNfg0MkcnUrqVgrAKLskuTlMNqceqGl4cIV+V?=
 =?us-ascii?Q?onHnU5Kr74qkovNDbJ6x/vXjQth7qit+cfz/tppi0gRrafXbIeP2hy73XbEd?=
 =?us-ascii?Q?zumfUP02zYd/D9EtZooe0b239WW8vo4p5iKlqtwhYI/QdC7yPFdtIXucfMxv?=
 =?us-ascii?Q?RYXKVhA2qvcE7bq+HkCkaBlVkN1QHmN9Kq87z+q/SnNd7Hr0LWJ574/Iy3Co?=
 =?us-ascii?Q?98YtTho/DZ8juzUzo67IMQ6+CBOP89fifjb3W637XCJlsHslgwIyBk/3CDF1?=
 =?us-ascii?Q?J0gOKIknZNddbEd+22gybcUW4W2/+wR42gINqTXzszZrnIFFxGoOE7EmuYYA?=
 =?us-ascii?Q?rW8Q5aOvB2U4L5hI73ha4tnOy0DkixqXZfnIR7oWhF6JUrBY9a5peOjpNf3D?=
 =?us-ascii?Q?x+Ux+YNJCJ1fqUbxouopRH4PhnomtxOQGTtGDE5seq7MqzuoIVuBtvAEZ/00?=
 =?us-ascii?Q?8b9M3ipIX2u3g/7cyomApKgZIwTJpntOTzYLl3CgVKr194QnVll+ZIPDMbb0?=
 =?us-ascii?Q?+oq1k9ifhg+52M1ZzVxe7q7KWuxtG8KG47kDSPSXACwmh4Z7WnbYSMg/Yv2j?=
 =?us-ascii?Q?+Y1OFyrCdq21uCcN5cPzaNLnugS8W4cktoiCcN7RQh/f0WznmNiT1QD7Z31f?=
 =?us-ascii?Q?+4GaVEIV2hEOCn9FNcyKHNI+aPKBE4BYH/mbnTPiPpug9jv4SiT03ldoB2KG?=
 =?us-ascii?Q?NiNVhw1OOYojO3qAlX1VcPFBIekK6OxujpORjcysUVm5c2YtySYpyeBYabA6?=
 =?us-ascii?Q?v+freKSmEpOyPAZsSBygr5NfU7HDnd3oybcHDC+G9+ddJi2cqEfpnpFnYihO?=
 =?us-ascii?Q?PRnl6LsAg8o9BM05k24DgDTC0WMMxR1a6x5H8BPGRVNZFo0DwYkcVqUCNZfk?=
 =?us-ascii?Q?Qz05GdXMpU0qRpXgA9opPzJQRmfVTkTIuhByKdgbFbh6Fauo/SyxXod9/U5H?=
 =?us-ascii?Q?CKFulGpWv0GhBRDDNhp/WMeU+oJn8ez3OYMtsbqFXssPfMF6w4Xaqt5JYc6N?=
 =?us-ascii?Q?/AOq92tYXszRCDQ3fd+fyJUTpzj1+0X96i4xR5ujoEGeI1NCxXlPr8/EMBP9?=
 =?us-ascii?Q?OPjmnwR6UGrS89cwKYkC56+LhlmK5bR3MTfeSO7kbJs4uHCi587GeH4T9hBJ?=
 =?us-ascii?Q?eJeeGHBTPkVa3buxFT3SgFmwlLi123P5XqxzBgNglrXJDthmn3QHAcSc1/VE?=
 =?us-ascii?Q?YpNpaQaZg7OXmtFw3wxF6R7TuITYAPXcYBWs/Pyrbrw6jBNWzmacJ6b8jHry?=
 =?us-ascii?Q?OkW8+yHaRVONr9a6Zhe+qMc2LSDDuaiiBbXewnVk+nd4YKepTRVOdBDF9UDJ?=
 =?us-ascii?Q?oL9L2gzVpC+zmXqhx4BbUfkSWJZFQyvK3Mczm7VIsCJVeOmCVDT1fGinhUml?=
 =?us-ascii?Q?ZEcWfeqbVxuv1vxGW5WCZ+KQnlRDMBHgCjRIl7FCv1Ih3jSm90VVBcB7t1ce?=
 =?us-ascii?Q?9jFO6MUxdd6BuI+i8bAlZEHS2gEJ9jmt3Irj3zq6f8Ec0FPHN9w9vEvSzp7C?=
 =?us-ascii?Q?IO5bq30NwiK2h0EaeyRMnd7dtHurcO2roC74BIkiNKHnnkJelZAGWWmy910s?=
 =?us-ascii?Q?RK5DzLtI63OpIAVdo+3ePi2HoGqk9ars0AAuVQFz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a649d5-431c-4cf6-0fcd-08de3d85da38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:03:43.6432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoNtYKYwLB6L3fbkvUX1xzr2wHMUj3hRdKj5bHlMpJDhsV31AIYpuyLjvrDdEig4c9AFQCPfI99FHSmIJkIbOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8665
X-OriginatorOrg: roku.com

This option sets the idle timeout for BR/EDR connections, allowing
them to switch into SNIFF mode after a period with no data traffic.
---
 doc/mgmt.rst     |  1 +
 monitor/packet.c |  1 +
 src/adapter.c    |  6 ++++++
 src/btd.h        |  1 +
 src/main.c       | 10 ++++++++--
 src/main.conf    |  3 +++
 6 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/doc/mgmt.rst b/doc/mgmt.rst
index fec9ce5af..35446dd97 100644
--- a/doc/mgmt.rst
+++ b/doc/mgmt.rst
@@ -3447,6 +3447,7 @@ Currently defined Parameter_Type values are:
 	0x001d, LE Allow List Scanning Duration for adv monitoring
 	0x001e, LE No Filter Scanning Duration for adv monitoring
 	0x001f, LE Enable Interleave Scan for adv monitoring
+	0x0020, BR/EDR Connection Idle Timeout
 
 This command can be used at any time and will return a list of supported default
 parameters as well as their current value.
diff --git a/monitor/packet.c b/monitor/packet.c
index bd316d842..5e546ad95 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -16027,6 +16027,7 @@ static const struct {
 	{0x001d, "LE Allow List Scanning Duration for adv monitoring" },
 	{0x001e, "LE No Filter Scanning Duration for adv monitoring"  },
 	{0x001f, "LE Enable Interleave Scan for adv monitoring"       },
+	{0x0020, "BR/EDR Connection Idle Timeout"                     },
 	{ }
 };
 
diff --git a/src/adapter.c b/src/adapter.c
index 924cddf3b..a5de7cee1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4801,6 +4801,12 @@ static bool load_bredr_defaults(struct btd_adapter *adapter,
 			return false;
 	}
 
+	if (defaults->idle_timeout) {
+		if (!mgmt_tlv_add_fixed(list, 0x0020,
+					&defaults->idle_timeout))
+			return false;
+	}
+
 	return true;
 }
 
diff --git a/src/btd.h b/src/btd.h
index 5c952bf17..1b521706d 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -62,6 +62,7 @@ struct btd_br_defaults {
 
 	uint16_t	min_sniff_interval;
 	uint16_t	max_sniff_interval;
+	uint32_t	idle_timeout;
 };
 
 struct btd_le_defaults {
diff --git a/src/main.c b/src/main.c
index 61e5ef983..59df0ad4c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -104,6 +104,7 @@ static const char *br_options[] = {
 	"InquiryScanWindow",
 	"LinkSupervisionTimeout",
 	"PageTimeout",
+	"IdleTimeout",
 	"MinSniffInterval",
 	"MaxSniffInterval",
 	NULL
@@ -494,8 +495,8 @@ struct config_param {
 	const char * const val_name;
 	void * const val;
 	const size_t size;
-	const uint16_t min;
-	const uint16_t max;
+	const uint32_t min;
+	const uint32_t max;
 };
 
 static void parse_mode_config(GKeyFile *config, const char *group,
@@ -573,6 +574,11 @@ static void parse_br_config(GKeyFile *config)
 		  sizeof(btd_opts.defaults.br.max_sniff_interval),
 		  0x0001,
 		  0xFFFE},
+		{ "IdleTimeout",
+		  &btd_opts.defaults.br.idle_timeout,
+		  sizeof(btd_opts.defaults.br.idle_timeout),
+		  500,
+		  3600000},
 	};
 
 	if (btd_opts.mode == BT_MODE_LE)
diff --git a/src/main.conf b/src/main.conf
index fa94cf97d..724c4b44f 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -182,6 +182,9 @@
 # BR/EDR Page Timeout
 #PageTimeout=
 
+# BR/EDR Connection Idle Timeout
+#IdleTimeout=
+
 # BR/EDR Sniff Intervals
 #MinSniffInterval=
 #MaxSniffInterval=
-- 
2.52.0

