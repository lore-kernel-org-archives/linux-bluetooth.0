Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D6BECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 11:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIULRm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 07:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIULRl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 07:17:41 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-oln040092069091.outbound.protection.outlook.com [40.92.69.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810EB7756F
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 04:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/3RaeG63tDBtl3jlHV0B1B6eW9Xzdr6PSiczvkjCc1RMRrEH0ITfgrmVDr7dXH4w5kKwOvpez4Ndwjfq8H/2oAkUcexRMc607UeOeIAzMi5sTGQpxeh8ysFdXJQtm56oJ6IQVI3NAxzkjKF25XicT8Des2BwvUn0cGKzV+CKXsXz0xqaq6QYRiZykK5rE7Cgu5lyksSmDJyvjZy7rgEwbgB6UjXSxG+mpQhkGby1pQMFLWmOf7lGJJwYN4KjCzOw5ErznG6rCSjmxYtHpZ9Vk/SGwpD9GNXqJ+1hrX07BlBxu90UrSnV65MJS+ozoDX7AW3X5wEkG6flvhyi1u3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr9l7AIIPCk+EeoqyB01vF9Fi1ucpPBAGwWASqexoE8=;
 b=cXvf5moIWla3hFe02a8MCGufVasW4/Md+gJqzmDRljpMiI9+LFQZk68n3sJqVPNtDfkuvs+PrLrw6GpegIN7ce+cCh1121iamMRrc84fWOCRvHzrf+cmTMTJXj085W/jn0bckCV/YTR/wsLn2t4pSHwMpbXdqir6GlD2qCMhsUHvbRXZ8vOWUv8aXm1/ggUrzem8aBo07QX7XRf6bRHLAYHc/w8SRHvDYE//U++f9TNqFHxGSz5YX4JWU9UMYGiTlcyRHISfuEXc0KRG4q7FBZc7Tb8YAua73NRZfCuXld7iSPxUE2VUM6tq8DzS31czicODYRE+FjG1tnNtfDk6aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr9l7AIIPCk+EeoqyB01vF9Fi1ucpPBAGwWASqexoE8=;
 b=qhYK+KhwEU83ZpWCgeWApzWciMJsTJGiKszKaFPGy4DZaMbzm9FyaEK8aKFX5+3RdrCclTA/ixEFA8Df+hf7d8stjOGPwmry1mY11rwLtJtTkDuZQPVBgBPSYYMUWb94m/XSD/sdrohkOAhHtFWgfxudLwdXpFIm0/EHnws1EPWq+TW6v00zGf9iAj9CL4cjNOqjpKS/BQUYngzuUoGTjU3JfMniXWHuomk9Vr+1pZ0b29fDRB5eBgGq9WKdoEZz7sTurd6EjiGwF8JztASJ1eKgxiRmv0l0Yu+BAsl3qTzPd37yBO+m1rtbrYbinWk5tu7wbx2XUCQFjxrUIAaXXA==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by AS2PR09MB6342.eurprd09.prod.outlook.com (2603:10a6:20b:579::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 11:17:38 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 11:17:38 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ v2 2/3] mesh: Do not accept publication for unbound appkey
Date:   Wed, 21 Sep 2022 13:16:29 +0200
Message-ID: <VI1PR09MB42398AED3429C6F2EFEB5F1BE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921111630.23589-1-isak.westin@hotmail.com>
References: <20220921111630.23589-1-isak.westin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [nTm4Bam/qFbLim2/3u2CkZN9GoEB92Xu]
X-ClientProxiedBy: ZRAP278CA0017.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::27) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220921111630.23589-2-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB4239:EE_|AS2PR09MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e742cf7-d1b3-498f-73e1-08da9bc2e420
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3lUkjXuSDdeTQka1McTh6g4fbbaNHcFdNnzsfNEqlJinPcbRlCG85P9V7MKfdaLCQ41HWzHgKgtwl2cz9+gnaedJ27vaFF9XlXc4LhClvqDs0C5jMwC93QFG9xf/td+q+bQNnu+ab7sPGll0Wk9ozNeM5nthjIja8knVcmoj6K/7PPzUouI4WdjuXS63gYJnQjn69/wiFvluB4Hyci3zzWEhDcm0QXQHN4toeY/ek7viseA3gXYMFYKlGuJKHYVjRcH7fSMkmtuOSzrn8wvluFJhkXy0lZpFXpPKGU6Wp1pq+HYv1DGcCQ2vCzOXBtPGiXxuxOjpv9CHt+nWJck/GMqOa1R1tPyQzgSO/74UYXPdM4kWLT2hYS3xwgmoKyMGw4jFKl8ffty9tjtev9sTY/Ka3LZnfzmuZU2hi1DtSBdZuWBG7rUKH0q9i5F9jswaWYol0NyPPkBx2lr5Wh2WcbhA3iqqQvN9+UiTMVrJNF6tnzkCkkcaU4oFXXJHu3nHl7gJiKO2IQnJk/vpUsqPnwfeieHjC4a510u2uRJz0QfM3sJe+HZTNb0U65j54PWfXZdnNLGPUw3u3eUKXLQlyFnsmRmyNzYu2ACkBeKMBlgb+VaXgXX7a+jIbaESrIY4v2xFJl1mXHE4mUiQ1SUn1CVOiKp/oGcxDCbijrDEgj9yICbd3PPk7WXc10TOk4QpwmI+KdEObigjqJ7LY8H7UjFkbYBrwBR6I6Y/C3Nh6Cs9lq7KYRR7aQv4wOheTLZHCAwqIrA+VTvkRYNyC8YVWhS
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/uMosWyFhVaDBQGFuhC7D+zuMd7wbb4iWdzfMMyNr1pjeV744IrIBvItDQNuEWc0S9WxEkOB9KmH2Gnn/6hNWs9/zGHu1jMqgu3OdvIGcsLkH3eDmZJBPMUEXIs0B4LJ/P2tAdiUqwrGZraDXTeSGwSIsJY8ruKPS/XifuqKGNgOkPGE2USXMs7c6+8cJN25o6b33cFpVGKWEIVw6z4Us37nLsTLn3A/zUlT+oUfJGlIBQa/bFcYQakWGStJm1jkgNUEoCO78C404PyCco4Zc3zpRl0zCmRpOT4ffzbReTvznWvoWM8LVl3ZDtYw7PLJOzwjdj8zEdjRyj7EtqSfoQbG37gIhDEgdQkvbcg4nJwmihifGGoBySn93TMoMkmwOgVCE7Q410ukmous3f3FEa0g5Zvca3kcXpCjXxARzrVdLMcgOJwSV6OW5/94V9a78Jo1bpzFvfiivgj9kevmvaKb4dNfyeJCRxhJisAnz3XP38BpYwyI8E37uV6oZCj4TGY/HwoyKqwQyHp7FZQRNWBEXGXSJRS6m6LDxHhca3MKyAHk2QxfvaozfkWLZOZ5QxrnVSYK5PoEjuB6WkwB6BHN4kjSnAkWxyIkZ8kzNNamgJZRGwA89ZLZ8qx140luPwXiPJtZZpc9PPF082ljQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qrcpwzCcMKU7zeaO7cWw8mk2t30tuAxLChobL9t750PI1agSKUpl4XMlnIq1?=
 =?us-ascii?Q?884xY0PoDB+nBbAiqsPMPF9K55sG9e4fLfDjR2qgPOSolIjF3GAoYwU1FuMe?=
 =?us-ascii?Q?I6PHV+av+qm9v9lg2ArAc6bghwgnLjTnHiIFW45UlP1+bVWQZ7ldVsRs5wgu?=
 =?us-ascii?Q?OSl6NU4IhvsoL0+xAjp6EtuR0YqTwh9kaJR1MM9o5YLroFVYW+/YPbCF9A30?=
 =?us-ascii?Q?PnZ18NkH2KfxXm7cDkxdPB5cMuS3ehOM+93x+0tLpemfMsdIrlIUWCQq4lh+?=
 =?us-ascii?Q?TYHN5jsLahSANrLgESmynXw3FJjrts3owKobk1uAuMLdLQBbZ5pjOWR5C/qZ?=
 =?us-ascii?Q?F84cXzJnGvfWIYupcGYaJDZLafq3oXb2e1/nwgNvGGoIuhaqXslpbxatVRUr?=
 =?us-ascii?Q?uDsgKqmMiOMRM4R5qpPbnmZ4qKPCQHr4F99uAkRNt7koYIf4j53Dj8qtasiI?=
 =?us-ascii?Q?crMmj/dSZwIHrbyZcMHMHIKhFDmQfFBxnDVl178daC+2RHO2uwfTy5JZ/M6X?=
 =?us-ascii?Q?JfVU6rNJaiA6zIMPggkmuYkDoejxhWbZtmoWXsqJkKnNT7N/r+JtucIazSku?=
 =?us-ascii?Q?81osJHzv2w8z7Vb89QcBDk3Opehd8OaOL+xne80HzrdQyKIE7c3/qJ3avM/8?=
 =?us-ascii?Q?l43icG5wX78TLmfB5uBDSE6a1Hm2eSy7T4H1XdyFs4DuchO68KyUZXVUnjRe?=
 =?us-ascii?Q?zXVLoI0RsEDFgDygXgDLEbFgKwUmGajBo3Lo+KsxIov5tHqVo49YVQ/Y432+?=
 =?us-ascii?Q?VszNNzwXvKKfZWs+Ht8GGWdDWL/O9BK9yzgumRvas1xawn8Gy7tUFBulhkAa?=
 =?us-ascii?Q?r05SGprFMybexAxzjQKk2cDRk0rsnSodebmjaHc0FtgFMcpGmym9r/g4L38E?=
 =?us-ascii?Q?+wJZjeAZv+tzhh1YJS6GEdqcwQRKFFejPul8l3cR9zLsh9CTxymL0JwaOaI0?=
 =?us-ascii?Q?M1ZODAPWhTw1INrJLDFwL1sSvrEAd7xi1Ss84poHRE1Fyu/5DeIa2L2SUTtK?=
 =?us-ascii?Q?Bv7iMBqpwLvBZSYEIsB8SxnBImD4nIwT70QHSDQGgydSQ3fSqjcu+d0ykXQY?=
 =?us-ascii?Q?MuEJZpxC/ZunHqVTba9ObERngYpqtLwcwcxWnLgr8Kv8yxuxtJPgPYteSEWF?=
 =?us-ascii?Q?NW9nyVHeOCcuNRhaIe4Tia/YQpitYV+3ovIDfoAEfvw9RlirWh6FnBv0F//h?=
 =?us-ascii?Q?jHsTtW6BWVlz1snhTHU8B2/xdYLUHzCuWN9573tue0N5pN3aGnx2CXsZmgMk?=
 =?us-ascii?Q?lzY4HmHASJRiUSpJu0PA3kAdkK0nUS3N3Nnfoqvv2g=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e742cf7-d1b3-498f-73e1-08da9bc2e420
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 11:17:38.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR09MB6342
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a user tries to configure publication of a model with an appkey that
is not bound to that model, an error should be returned.
---
 mesh/model.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index 82078ed85..d48e6ef12 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1063,7 +1063,8 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod->pub_enabled || (mod->cbs && !(mod->cbs->pub)))
 		return MESH_STATUS_INVALID_PUB_PARAM;
 
-	if (!appkey_have_key(node_get_net(node), idx))
+	if (!appkey_have_key(node_get_net(node), idx) ||
+			!has_binding(mod->bindings, idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
 	/*
-- 
2.20.1

