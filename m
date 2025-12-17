Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020078.outbound.protection.outlook.com [52.101.201.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580492EFDA6
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 19:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766000232; cv=fail; b=oIv3i7pPaJJX67J88GHCk+WQpeYYN9HZAyHW0/tOKagV4IWOkmgGt/W9Bztujb88g9ThWhtgY+VeI/CO9LRJgtJoxAWE1+6vRb8ZrcY7NcPYMdKFlUcS9aORZ8CUmWPF+NbJ6wumqKTcOLRSVfryKtos+qEXSdNvBxNMX/TWePk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766000232; c=relaxed/simple;
	bh=EmK3lCxD9/EjRsFLDxDBjnq3zV9Qfp+opl9RfBQ0pyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SZiMnVU0BKCYRgwHqty1Xd+Tqum/BpeAdSUB4A+PgUQvFRY671AXOvVD0WdoT7pqvnBYgiriuf7iiGzhiZli1QIP2slTCD0RC9JAHeTlYhv9krPmDE2vZWFg3/2ZK3xhgEH9ExsKOXtq2bAkhcjJToauj1jLHuMD/1z7Abkl+Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=l4bV/TKe; arc=fail smtp.client-ip=52.101.201.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="l4bV/TKe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMKvxuYArMfEBuueL9XyrYWaXXFvMElk6l+JC1F7lf0+uBM6si1FOSwuuA75wGv9iCpC1DCTJw0RfzXlgwTVG+xtNxSYD2fXvwKRjLamIGcilXKkb/duik+L0qFEEFWtoqn7PZDSuKSdD/GQQL3sPD+T4Op7MWLVzxpqzkYsin8lk2WFGIzTYoVMxzKGEI0AO/JjVQhb29YpTUlSQfEiTJR/cujerkqvq/z1GfGHNV8eJP5tc1leBywiKP/f+I6vefp9kFjaB6QFdi7C/EajjJ1zJMsIwb3lDtdtOuri8m7aaltl0SxxKQSTkJelfGDJFIFgiHwjujzYoZ00rcDrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zazp2WK6j8EvKZoDEb5NvCe8nTBrH9bXGVFKY7zD4Kk=;
 b=O4TUwRm1nkhVro70XAR2WEJcBTshnQYwAqqjGNnilzlVnwxPPZ5PSv0CvlfJovlSbeB7hj9QqAgyROlh0Zml+fmygcM7EXTGe/HK+R8wZop17RwgoX1th+5cJ1EfMCUJlU5Vxxn5MQFBuHTjkohRr4XYlD2IYz0SRXp8+eoNx5Vm722NI/1cV47yw4+llGbRlAfgyZ2CNJGBHvtAVJWYU2MnmJ3+PH3JH0/gqA8O7CfOhKL9wcRgDTbVsNKuDzHAygm6RBllH1C5TzZZucLR0W1UDU/FLBfIqxNHnGle8SgKWXQ9pZcLJ2CGLX/iAjCfUuO9K3Pux362JF/X1DgVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zazp2WK6j8EvKZoDEb5NvCe8nTBrH9bXGVFKY7zD4Kk=;
 b=l4bV/TKeSnYR6bS8c6e5Hcr8JC4y278NjOivqSMA2nfsh9r4pvX/A5qMNw/vklwZwPb5TPr294aX9bmqIhYqwfeufqeTggu0OD2fziiiizhkEPNl3XZE2nf3+GOpAri9ovvye2hNdYMSE9V7NNwkz77u6yQMhAwuxxX/DWMuTL8Tp2tE3oRbOaaCGqumHNSAQyn/Okr77OUMMsFU9A7tBaUtVGVqwJ5p0/BS16w9FNl0i8TPnJv7Sjx0sudNBrcQZ0SHwRjBUwr1kKJTY7ve/ZODZ4JRMzDtK5o02pee9Fnzxvx2ta8/DoNZkVHLuMm6a6OCGffTfE+98idLlfsUqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 PH7PR01MB8665.prod.exchangelabs.com (2603:10b6:510:30d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:03:36 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:03:36 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH BlueZ 1/4] doc: Sync default system parameter list with kernel
Date: Wed, 17 Dec 2025 17:02:53 +0100
Message-ID: <20251217160256.441737-2-ssorensen@roku.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8282:EE_|PH7PR01MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: f21ce6aa-83ea-4cdb-91cd-08de3d85d5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UL67nkmwIFJj1KdRvtb5laqTNChuYeVGxghhXQbjfK1v7H6KDJd74tY21c3Y?=
 =?us-ascii?Q?x6Y8Hf7Afum22+GiioHMpi0wGJN+RlppLurrYjvbrjjn7ShJxsOAsNU6Ke2f?=
 =?us-ascii?Q?cusYs6EEe5hAVZ/G/N/lFfwhpP2+RUV27eW1c0Q/WAo8S3gmSFOUEHe3obAq?=
 =?us-ascii?Q?rPVUJvh9f5kqypA5cc00RycTBRJcgT7dkeBruhlKp+/yoVVxxef8Nz5SOlvf?=
 =?us-ascii?Q?WhhY8zfbHfqXGOTp2okqBtPfVmsKz2FK0uv+YcXS/kyDOt8kX6MvqObCfvWg?=
 =?us-ascii?Q?gx8qhJAJ0GHITPMM8hT1dcv0MgtQVP+M7hk4vi3qBxx4AEYKZlWOQoLLWa5Z?=
 =?us-ascii?Q?3UarzGWwC/4Y0mg1Go2cEdPociCzg0XLkHkmQOKQuO3e5o3ppmCcCOxiArfJ?=
 =?us-ascii?Q?beT7QkRJI7AwP3cUYVeWb/hvpolw+CHheVVskkmmjno7JHxQFeykl+kHFHdS?=
 =?us-ascii?Q?p+Fjy8HSvCnMPOW9JLALnR+TfLLNV4D2rhfymCKHQPI1yil2xMyxujV0ms1g?=
 =?us-ascii?Q?rLfTrbBTPfYp+5dfQfMLHT1dphnx/Gp+jJ7Pdvrg9ZU5vutKVO2zDxvebHRT?=
 =?us-ascii?Q?2kqoaxe/d0Ocbp0jJWlONcMNIp9Pf7lKpCN8qTDj2FZsoAzEYX9H29CRWHmW?=
 =?us-ascii?Q?CHLH8brv5sS62aGV9+axmL6eGKoVMbGcOAzbjtHCFbc24LyKmX9FDKG/l7oF?=
 =?us-ascii?Q?IoycleX6TGJ89xyq1EKbauTExXQXArYC3YwmvQ7OAOLohWC+O4t9xm8uHdNM?=
 =?us-ascii?Q?lKMJP4CRh13laSPKtgA4JE9Vp0eXgP1Rz/2Bz5g/2SCGdYg8Hl8b406n80lV?=
 =?us-ascii?Q?IV6kxZaAfxsKYEgZ5pTD+m50LPIV0UWTgDz5IktAYuK1BqTRPJx5ALn5N+s6?=
 =?us-ascii?Q?XF9FHPVXWuNskkPQ8EWFTMYrg9jDH3ZKIzLtXJ0QE+mgl0qUpXwnYxC1Qk+X?=
 =?us-ascii?Q?in3/bMBCLMWhPiWkFd+AOIdKrUZCXxbL6BfSjzhdMHP2VSus3y428/akL/Md?=
 =?us-ascii?Q?iHng8OmNkoriLbUBaT8FcvhEN/BQlEMvNN+pL09iaY7ZdyRiDjj24eE+Aqyj?=
 =?us-ascii?Q?k6pl+hfQqG7RWfNjNpV8y7gvla4KxJtvP5UsjFhUwogAIy4Knpe5DHcn1/Dd?=
 =?us-ascii?Q?b8JJ7SXdV+o/9NW25+KGWEIks+rgHvUsY5sJ8iQPI6wSTHkvathaoUdQ9elT?=
 =?us-ascii?Q?hd8V1fS0vx/WaVMV4uFmJwn5+JLBwcP7C9WHGtvMDnjzfw5OeuY/Z7mTvfEP?=
 =?us-ascii?Q?xgyXekoxMQNzdlGk8qgPm++Qk9KBBfLfokxfTejtKkmgreC0maFU/XZof6rL?=
 =?us-ascii?Q?4ixW04b99GAZmgOamYLHqJBxpdHvfBJJ3McpZo0xANe3xj2AOwk42+A3Wg1E?=
 =?us-ascii?Q?1cX6yoepzJ//mONciaKj/KtBPFwsQPmBv1A3knLHi4i4xygs8k40+3XaUbGX?=
 =?us-ascii?Q?PGNVj9ERBK1XlIm40nn6+5h1tks7o6M+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+FpLBLm3vfzJDWTOWZKwfgo6yehK5VwKTuGenB1BWbqIg+Rd70HxjDzxGZd5?=
 =?us-ascii?Q?xAf59cshIqpHoWwttv5LYlylhMuV3d/KytD2mHeCDYIaomDAfF6L1+3FenW/?=
 =?us-ascii?Q?XxIL4s7zxJ5x8psFLgu1S3uuFW7tSVcA9rXkq1eprEfSOeDWViqc7LzMhLV+?=
 =?us-ascii?Q?T0qVGNOJr9/DirVoZPnCxIwxkDXzOlZnN0I8yfN8LCpemjsBLXYqtrT9wCv4?=
 =?us-ascii?Q?gxSEJ1lcPrKBQUYW2CWpnp+33ZROBXMuoG2FLIyFXVoXE65mD+Wgc8DZaoQ0?=
 =?us-ascii?Q?Lf/JQAPKKVTPPE4lR+zCh+0S2bE6/RAtle+p6AbompTVxbSJFNXlLdzx42HM?=
 =?us-ascii?Q?rpMLojNWkAXqtIfvanZ7HLfBkz4VeQbnD6J0IC9ywYRTRCIuYNnk7Nq6ccod?=
 =?us-ascii?Q?Jc3837cDtY978F0kICjvXILYWtKTrsSW5sIlT0qFFMITqrcCkf3JIUIbb8dv?=
 =?us-ascii?Q?J9tUL1qzD4ewyAMUZKlwozsW0QPzkuxkJcV96HqnlIHacg5Ssy0zgF+jltXa?=
 =?us-ascii?Q?HFaXPwnWExNcZXzVpMOpNgO2zKnsE8ihloxSYsdlLF6SmdfKT1HU0A0vtN2p?=
 =?us-ascii?Q?/FDvPb991pi6y+zoO3WuXzL5lAzMlmHdk+wismqbm8Nk6E0VygO9MwU5Qhqo?=
 =?us-ascii?Q?5K5MM0u8+/P54JpskBvulU9jhvZ+DlMx+2CD3lBCuBNR9tkhgbC6UpZ3A6gw?=
 =?us-ascii?Q?821sxbfDd8s/08bMceHij3lMQFjBiTLsjNHJE0hI3ERZYakxYQdzMzVwFKPb?=
 =?us-ascii?Q?gsu+PE9W/gOg/d1jij46NTBrEGvA3eABPmsKle+OZh56knnues7rCy/M2S6m?=
 =?us-ascii?Q?4NJiYAoIPVoR87swqmHWSf72H208Iyvv5LOzcQTkwEONqbWmiGWtvNi3LtLU?=
 =?us-ascii?Q?aVd6Bff25SOjadPjgQwFwZbin63alWGaLOaO/1GPIlR4Hr+eQewIb0EIg3n3?=
 =?us-ascii?Q?TnDqEqqi0V4NULBrdVpsQHqMVhjsbXUDthcmV47i6hIR9XyKcp7Xvzf8JRJ6?=
 =?us-ascii?Q?H06i3USFqMtICjFa8KZIYBpi0OFK2FgRHuC7oRA6e+e4dgKn1zLRoi/tKi7t?=
 =?us-ascii?Q?gMpyMjaXiFOOXgn7njk78J6+R91CpLqsgaqQ0jnkgEp7Da9+XSqMum9mQUHS?=
 =?us-ascii?Q?JP4dvKmICQTt6rFXrUU9N+LHZwhIXG1nxxFnL3mkPILKi/f7UEUKIh+NOxkd?=
 =?us-ascii?Q?T/j9xUCwz8LyxpDVr3C8QcFN3qXA09e9oN/cZaXwCtZ/JtEGo/+uMk3Cbwl7?=
 =?us-ascii?Q?DmjUYqFMEwvC+X3NMo30sGqpW5khYgP3fp9YXfZYR/IJauTMaUX0yKStPMR4?=
 =?us-ascii?Q?+6z+PD9melpdQWDst1C7M3qdSxyvTuJMeFAD0xuPzxm6ukcft5e4msNQteu9?=
 =?us-ascii?Q?z/B6B7zbwpU/SzLqko9v2uf2KQTyQow10D9AlpkyfgZcYqpLqVZSk9uh/LS4?=
 =?us-ascii?Q?OjA0qUxqL0FLpi9xFVK/Wx8bknYIoBb75UUuuirI0BERa0GYkV5+XP3MsW3h?=
 =?us-ascii?Q?3VdhXounmD/Un0fRGVNcpika4PynfzRdV+G+F0LgIqdnRkZsxLwFd/xOKpSP?=
 =?us-ascii?Q?Q0CjEOGFhyLiVzoLAoQVD1Lx6w+YjXX7jFZKQ/sh?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21ce6aa-83ea-4cdb-91cd-08de3d85d5b1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:03:36.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CijvnT79mSAEbkK979DD9EF5Wtj0jYsXIL0617HG6R9jN7wKXTQ+dUVo/eajh4M7j67NtidUDPVNS8RfZ0W0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8665

Add the LE interleave scan default system parameters that were never
added to the documentation.
---
 doc/mgmt.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/mgmt.rst b/doc/mgmt.rst
index 3fca69ed0..fec9ce5af 100644
--- a/doc/mgmt.rst
+++ b/doc/mgmt.rst
@@ -3444,6 +3444,9 @@ Currently defined Parameter_Type values are:
 	0x0019, LE Connection Latency
 	0x001a, LE Connection Supervision Timeout
 	0x001b, LE Autoconnect Timeout
+	0x001d, LE Allow List Scanning Duration for adv monitoring
+	0x001e, LE No Filter Scanning Duration for adv monitoring
+	0x001f, LE Enable Interleave Scan for adv monitoring
 
 This command can be used at any time and will return a list of supported default
 parameters as well as their current value.
-- 
2.52.0

