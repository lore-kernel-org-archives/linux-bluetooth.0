Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazon11021094.outbound.protection.outlook.com [40.107.39.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210F233A9FD
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Feb 2026 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.39.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770464660; cv=fail; b=g+JliNPYLct5dGXzj1Sh3uj5Eb1oYlkFwr4yoMvKwhYjEX4Lq/25yCvMPGvgy+QJc9BrMxJeodR+b8h+SJ+wdZH25vcxh+19p/CmJ5XfgDp4sjdBHdUVwAeq3umnh1RPVOa4C17Dx8Bmqvgd1fa+nD1DdiBJ5HlfHipyixECYAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770464660; c=relaxed/simple;
	bh=z2RRyOsltrQ6kdUIlU80PLAVoWbp92NxuHIyfmw10aE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eapXx1L5q1pvtAoWgs8vGv40um8A9LWTj+qzN7etXkFBKFxsOyhxFom+shwnoetG3xJljpKMbu9O5htyMOEJBpU/WHMF1B3COkyTFvq/vB+tvQ5Z0RoEvRM8xRXbwlhPsO8AzU1POq+umeKzL8Ni9lJ/FZTKcrqB9ZIJXzAbfHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; arc=fail smtp.client-ip=40.107.39.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqLtwJZFNbCSLE6yoYUmTZaoPZQk/Ox7bSkKUOX1wCTRyghEAXpDXX+JMiOmNA7EViCreGLdhUXnWzu5Crb5O/7+KeGEu64/m7di6y3XoGngDFV/OUFGrXjYRVGweRWbD1OfSL/xAWSCEO8p6at4vyLb2CO1/XzKfmbhjoCOFCgyvsvy6m+T3tmODUjp2GdoFk/0T8TAFigYAZmuMVHIg8cpxk8wJbI4mMoYDliiDtZSDzTcIHsb3s6TM8qTn1pCXhpbmCUckJ8s6p88BpggDJzDnGq+FFZKakGYHW4AE7PnIPBUpdJTEcYQPw1c1I4pSvEf3NThyZcuWMUqycl2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=496FMYlXQk/vGbVoX5nWgLFQbcQDykdisoqfcUOqSZ4=;
 b=kFsIZXmTfHryHy2RNjsmoa9uzcJm4NplctiML55/jy4PVvyeuYmxVy/TBTU4AedWXi0f3nh6ywAwIZNCTmPu5CifaHEXaBa/W52FQZpsxlk61Vne+vfRvafwYwu5spjaku6oLJ8I2wx+EJ4KsNKlks6LOeSi1F+7GWCF4w3fie6LZsdF9IfXUVU64uqHurXK/4HafJ9vSOPLV9YC+XQBInQ4xkXGMwEV2IW9uCP2YsBmHWoc08RJtVvhfchCNGc8DXwgeWjxsn43vQNN9l5VHThSuBCXz7d8ZZ6OMoU/f+RjjnQbcU5IaVQuP6kus93HLKWn3N5xGQ7/m8RPvrIiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:73::13) by
 SYYP282MB1885.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:dd::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.17; Sat, 7 Feb 2026 11:44:15 +0000
Received: from SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f]) by SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7340:fb70:eaa2:ee1f%4]) with mapi id 15.20.9587.013; Sat, 7 Feb 2026
 11:44:14 +0000
Date: Sat, 7 Feb 2026 11:44:00 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: linux-bluetooth@vger.kernel.org
Cc: rudi@heitbaum.com
Subject: [PATCH] src: retain const qualifier from pointer
Message-ID: <aYclgBGSNj0peBdM@f3de6192b473>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEWP282CA0082.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1e1::16) To SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:73::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB0960:EE_|SYYP282MB1885:EE_
X-MS-Office365-Filtering-Correlation-Id: 747a44dc-ab23-4b61-019e-08de663e3799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wK2gcatc4tFXnZSkx0S27W3KQ7D+Cch4+I1Mto+Jn7z/VnBwzPwO0ocfljo5?=
 =?us-ascii?Q?W5iK1MdyDU4sGq6B0h3pYusXXTZ3t8cR0RpbylYJTsq0NADSdmJCpazOc6fy?=
 =?us-ascii?Q?weY7H9ISQ519H+cjGILntSKmySFF6C9xqXka3/I99E5jfN0uHIIbOWHRzLSh?=
 =?us-ascii?Q?lZYGgGs3xC2LnsOqtxIu87Z5IwLMwweq4TdLqBNKHBtldwwCLPMV1GCZRcqX?=
 =?us-ascii?Q?aGyVlVzpFAv2DGeVOpKGxoNWerCCAoBuU2bFduBTHzBUUZwCgr5IljulkRzX?=
 =?us-ascii?Q?Th0g9rQDe/yUE0IncFmKYMoVKclecws5kLq+ZMxCPV3CZ5qLgmAU3W7Z8rO0?=
 =?us-ascii?Q?h9JcUIgnRnXKaSPEhYGaEiShQVUa8IuE0uKXCK8Fm4OgScuJhhhacgv6ynlc?=
 =?us-ascii?Q?nHUc5USB0w01PsEq5yJSuPtBnM7jTEnfqOtqDVaQdw8W57s0xONzRQ6wpugg?=
 =?us-ascii?Q?CoO19tUG+KMIkHEeibvVflDVxiJUmvJ3FwZLzroNLrN+7TPy66iM/6allT8d?=
 =?us-ascii?Q?X1mxbwk5m82H4yJPg1vveXRqzIGA1sEoMIj4HEE66YU2gfPyFkFo3SHi7d9Y?=
 =?us-ascii?Q?jSMRCzBXW/W4Fwor5d0MQldp92R+72cwrMzb5a5XplEbZyhn8OMvyQunL11i?=
 =?us-ascii?Q?/ikBDBgFHpo6ZZK3EPJ/iy1bqqMfYjL5UhuX51/JpYZDfbv54E5ffl3i48DX?=
 =?us-ascii?Q?3jVbGrNs6y5oQh4b1Rzsw/j9D/w4gnJrRA8WHh1cxHNKXP9TI1AsQsKrvTNo?=
 =?us-ascii?Q?uhO6+M/sZvtQCUHyaZWrMf8gcMCRXeNx2mvE39dDPF3TL7/699DM2Bkvcih/?=
 =?us-ascii?Q?uUJrZyvdGtR6DJxFqPOHJQnUpbZTH0Ou2sFtGEjoQ+pYOMxasrHExamQ7ZDX?=
 =?us-ascii?Q?xRXEAuS4khTthpFy9stwKsSp6xk6Y4fMokGNGLSNSJzpII45ifmAZ8mv6Hpj?=
 =?us-ascii?Q?6ARuvFPX2YX2oMhv/+0C00DjzPgDJoucF/fF9D+ahAsI5MI1w2+nttorLVk8?=
 =?us-ascii?Q?OfdjTY8d5mQVJPt+wjl2PsnYNfV39EDF9iVmu0eLsdNCFYL4hCnah71OSLJI?=
 =?us-ascii?Q?xSmL3jnCz4NFI6ib9r06sWmhoCiSPDXaLULQnqpeAUWAleLs7Lr/pMenvPVK?=
 =?us-ascii?Q?SG0lwK2yaeLhA5Oy+S3oNrzSWrRi4mPvkKRvXcgRimd0a6EVIHj1Ymh8HPxH?=
 =?us-ascii?Q?lB/70PVhexGA/6X+NTovQMyylCiBAo3s3SoTy8V4Qk6epHeonzDPbLrpl6Vr?=
 =?us-ascii?Q?xSBBJLHyoxQQ0IEUyheCMgC0KGQs6gfzZnlVmfMPml3wvkNFoKd0TdSVStao?=
 =?us-ascii?Q?BRH7DwCWJJd8Vm6lddkQLmV76nkLI8ZkByVbpbW0ntwNNpsd2xqXpbdIFZhh?=
 =?us-ascii?Q?PxO2rYhugj+mLFb+zaM+2ZDygSG7dYFUdvIYLFncw5fjmkeh8Dj8KVFXgNBK?=
 =?us-ascii?Q?sQaGmKXnUUT1qXawAAYQSkRa/EkkJSIbHp5SzWJd/SNuf+Fl1zWe5kHIFm+a?=
 =?us-ascii?Q?h1C04Nh2Y3H9pzi73E8npgM/JYYYSHik8dm9t4nct8HzGWxWdsjEiZ4QsZnr?=
 =?us-ascii?Q?DDmus7HHHcG1Wgja9/E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PWEl6jAIWtIcB1/Mc0Af1gkNI5yRkXNVYqv+wwZkjNh04AZlrtQrynOV2j7?=
 =?us-ascii?Q?0U83CVq15qsIC5JuXpZ2E/BXNi0ySI3M+IapEkppO1tXKusikB6pVNLcovhQ?=
 =?us-ascii?Q?GOEV/t0yCQZSfit3nGlV1NYilV3LBnlJLRWUZaWwL9j5v+GIl0JwRF5gIUO8?=
 =?us-ascii?Q?aG99OnqPtAwU2LvQxv/o/Kx707mqj95UVNJKYGKl9osQwrJTIIznLyjCXc1z?=
 =?us-ascii?Q?HIuvZ/k0eAHKko6TrlFLH6ZSeM2JEY12oRX/i9zARG00sHiRsi6+cyjjftGu?=
 =?us-ascii?Q?G8Y0/lJE0MD7aCyE/CSGwKepdKexyllY1aaFaru8uWqYDttOa0NTrHVvjk25?=
 =?us-ascii?Q?1WsUodrTuDu/I9BXpSZFjwRLBaLHlgwPTSWHu43/vB2pWrCjJ6jK3ko8rJUc?=
 =?us-ascii?Q?cdug2ksm5X6D4n48wMny1aWtdAfhi/vciOil0s8COIieG7hsmeiOdQQQt3R1?=
 =?us-ascii?Q?WJDGV5mlc6eYG8LJB8Mk+Xsh4wRiYFMMdwLJSR/JaKgQAp1IMcHKHQzmpe07?=
 =?us-ascii?Q?EvMQfjGnbD9wSdX2KHBWuTRZ9GE0+r+kThCHvGED9C7fSWd3sJyHD2+WyJMo?=
 =?us-ascii?Q?kD9wcAFtSjEEQEFRcQ+4zNlxmoEHoUYanJaHb5/fgbsWWtJLhbA0lgd+fL9n?=
 =?us-ascii?Q?5r2tFB16HWBAbRBKi6ZqSIN/e7JnYDH5IoZGNu+Pmp4pxInlMxL2zqS0t95w?=
 =?us-ascii?Q?knpE+PWIze3jFjFlS+Va3EyzRzs3lxn8auN2/uAB7q8NlADI+GKsA2WHmqM0?=
 =?us-ascii?Q?ssPAj3+RM6uFaIaRY+n0Eqqry0NLtAflZYYHs4vBDccoHuH3ryKZvZNpeV33?=
 =?us-ascii?Q?ohjTw1WlZ54UbOpXjcEQxa+liiIo8WXm7EPP9xLgCt4QrPnXWdbq5VpR/Lwm?=
 =?us-ascii?Q?UQ1HjUWX52ICr+ZBq7d3JY2z6lu00WkE9K/HhXh4CqIx2DiiogKYfVzBfL40?=
 =?us-ascii?Q?QDwt4/PDAi6ytwLEtEIuKHPnLu4+7VWFF3jbnZZnvqN1d4ukESm6eMaNxLjK?=
 =?us-ascii?Q?V24KGialZ/61yuc+xK0f0jslg7u4YX3w+ui4hkhAoYlqtqWpe8M99vh5yeg+?=
 =?us-ascii?Q?y5k0EtM5QcXZLLm++toFvhl+e7Vizd0w72NLVr5aFHyWpu1GGy/9Qpj5MqVn?=
 =?us-ascii?Q?T5N+4iK7L5CALOZSrza17m3QfY2bR+JqzyjBg2wDIkYKFmZvOaZsGaVJg39D?=
 =?us-ascii?Q?BbtUH/3ECKQXVPp0coQMEa0V89bh922kcrKjhHBA+9xWqq9TQk6bgRLwN+k0?=
 =?us-ascii?Q?n1UT6ZeS/KTZ9EkFHsD4J72ZKIr0B7pSO5oMZvrTozQE7VeV7PDOsSWB65h1?=
 =?us-ascii?Q?VuC9lnKeIy6A/yBbv8B9zI0ViZ5Td9Fo0p3ENOpuPQFjPcfJOQyWW2mTouWG?=
 =?us-ascii?Q?UkF0FaGn6z3YQuzGSGhAQ2Va/HdhZpqYmLLHErd0elslTOewh9F1I6DRp7Hj?=
 =?us-ascii?Q?oXoBdyHKOdgX9Z/ZcTdQh5jSrDakG2C/noINJ8GmHtUgPmGb5KkMHJQgHYXQ?=
 =?us-ascii?Q?Wp2NDYktli/ArP7N+AE/G52mEvM2KTMIxQ/W/LcPMrToqnH7rjz5ybbsG06f?=
 =?us-ascii?Q?k8T6oRnCztwYIAv8J+ReadFRPbO9CYe1Yot4LsgIw4PxTL8QZwow23IKsb3X?=
 =?us-ascii?Q?u0R96o8gKQTGsRiwcXcwrxjuBmRB/pqH84aLzlczyy3FFUdHQO0KKSnP8iCa?=
 =?us-ascii?Q?oqDo1X8Kcp/ZlLI2yI0/KU4SEPsf3T8lbRty3cQ6xD3YJTY9?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747a44dc-ab23-4b61-019e-08de663e3799
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB0960.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 11:44:14.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lwFAECVNvnmsuCbQs4Q7Y+sL0NfJHl2tyXPwjxAizjQpiOFn6VC5gMtaF7KaCUwB4/Wkw3yiWrHYg4Iji3EuYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1885

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return
pointers into their input arrays now have definitions as macros that
return a pointer to a const-qualified type when the in put argument
is a pointer to a const-qualified type.

https://lists.gnu.org/archive/html/info-gnu/2026-01/msg00005.html

fixes:
- warning: assignment discards 'const' qualifier from pointer target
    type [-Wdiscarded-qualifiers]
---
 src/shared/shell.c      | 20 +++++++++++---------
 src/textfile.c          |  3 ++-
 tools/hciattach_ath3k.c |  2 +-
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index f014d8f7c..78d58c513 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -525,6 +525,7 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	wordexp_t w;
 	size_t len;
 	char *man, *opt;
+	const char *man2, *opt2;
 	int flags = WRDE_NOCMD;
 	bool optargs = false;
 
@@ -547,24 +548,24 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	}
 
 	/* Find last mandatory arguments */
-	man = strrchr(entry->arg, '>');
-	if (!man) {
+	man2 = strrchr(entry->arg, '>');
+	if (!man2) {
 		opt = strdup(entry->arg);
 		goto optional;
 	}
 
-	len = man - entry->arg;
+	len = man2 - entry->arg;
 	if (entry->arg[0] == '<')
 		man = strndup(entry->arg, len + 1);
 	else {
 		/* Find where mandatory arguments start */
-		opt = strrchr(entry->arg, '<');
+		opt2 = strrchr(entry->arg, '<');
 		/* Skip if mandatory arguments are not in the right format */
-		if (!opt || opt > man) {
+		if (!opt2 || opt2 > man2) {
 			opt = strdup(entry->arg);
 			goto optional;
 		}
-		man = strndup(opt, man - opt + 1);
+		man = strndup(opt2, man2 - opt2 + 1);
 		optargs = true;
 	}
 
@@ -972,6 +973,7 @@ static char *cmd_generator(const char *text, int state)
 	static bool default_menu_enabled, menu_enabled, submenu_enabled;
 	static const struct bt_shell_menu *menu;
 	char *cmd;
+	const char *cmd2;
 
 	if (!state) {
 		index = 0;
@@ -1009,11 +1011,11 @@ static char *cmd_generator(const char *text, int state)
 		if (cmd || menu != data.main)
 			return cmd;
 
-		cmd = strrchr(text, '.');
-		if (!cmd)
+		cmd2 = strrchr(text, '.');
+		if (!cmd2)
 			return NULL;
 
-		menu = find_menu(text, cmd - text, NULL);
+		menu = find_menu(text, cmd2 - text, NULL);
 		if (!menu)
 			return NULL;
 
diff --git a/src/textfile.c b/src/textfile.c
index 8188d2ebe..a83f40c4d 100644
--- a/src/textfile.c
+++ b/src/textfile.c
@@ -68,7 +68,8 @@ int create_filename(char *str, size_t size, const char *fmt, ...)
 static int create_dirs(const char *filename, const mode_t mode)
 {
 	struct stat st;
-	char dir[PATH_MAX + 1], *prev, *next;
+	char dir[PATH_MAX + 1];
+	const char *prev, *next;
 	int err;
 
 	err = stat(filename, &st);
diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 0e4bbf04b..5dcee2e87 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -303,7 +303,7 @@ struct tag_info {
 
 static inline int update_char_count(const char *buf)
 {
-	char *end_ptr;
+	const char *end_ptr;
 
 	if (strstr(buf, "[") == buf) {
 		end_ptr = strstr(buf, "]");
-- 
2.51.0

