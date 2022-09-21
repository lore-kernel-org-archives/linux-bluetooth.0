Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1943FECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 08:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiIUIkk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 04:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiIUIki (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 04:40:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2034.outbound.protection.outlook.com [40.92.89.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062735C361
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 01:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCk7Nk5cmSvDjYqPm2ctL0Adl+D/tMFJPOrkTIGZkMTPsJ3er29VkYqSER478ANvbzmwvjzVOQEhO7CXJ6JDRJp8DXzUOrmtxpYz0JPh3mnUDLk8uGdq9Q6/u3174NIXwVqcbNqdNp6ZQKOhalhXr7mKtwS02nMIO2+z+r5aJtQNkzdsFoGt35V9y/H0m1/Er0ghz2Lelr2MBcHiwaALWpotv1aQObLGoL0cnkp5C06DNo6m98mM+WSR3ZE+QmUzWGyusU4cMgFvUZ3ru5tFqkFzrRVeBic6nQ96lBMgvmzrb1mKKsjKp5gkJuhroDgLLZpDObie2LU47GP8WU+Guw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5uXjaZQyRXarP7Y9PMiCenglPfrhPY5jGIkOCQa1Sw=;
 b=nSO+djKVtU0D4gSk6Zg1pN95livmz0qX95SBlG1jEydIZW5Lrr3XRSR3dfBeJ9ggOG7d/YQSbmobBDbVYEPneUzH5vRlDEQahn3zNaFYgnzzDp7fhOd5WYy4SZk+F7Z+HXLXlwLtuPGmT8coKFj6zX47ZW6x0nSsfyyQlohsLN73EfrM1Q/5WqDy9Hmm/yU22yHexkokgNtXH8tmbLeY01QlyjlBMs9Stl8dy6AYkhr/MYaOAACpMFMipug5xkxV0DFhS5nWBiQn65vKeKmybhvTeTJOBE3EBGJ+oreXM7Y0loQv8LaHNBTMfGFCy5SjtP0vbIdE0MycWgJad6BueA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5uXjaZQyRXarP7Y9PMiCenglPfrhPY5jGIkOCQa1Sw=;
 b=rr6KhmxWocalCSDd+LEzxiWXs//rdu9VSGJC9Ifv7S3ZgPBo6u8rn4iiwgFk1r6bIqcrs4NQwOMfLsrKsYSRFF33nudaOXqVnk/D4cWIJdIBlSE1XYxoZqr+ewqlteEwYg2zeTK/uEgzf07aGAGQSmSL0sOQWBOqOsN436ZneveuCq+aOJ1kmWRwk/l/WLHqSnBl3IttZfVppPeGXBfISnlNvP7KgRMeHNhrXOn7pkPVVR6+mV+GxxdSGQ5ZWp7WCsCeTOirw75FCDJB7Sel/EQicnjRK6ZusN1W8A0goqek3p1XG5+R3YBdkwmtfY1hRHGwQbuixSE3jv1u1//WFQ==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by DU0PR09MB5693.eurprd09.prod.outlook.com (2603:10a6:10:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 08:40:33 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 08:40:33 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ 2/3] mesh: Do not accept publication for unbound appkey
Date:   Wed, 21 Sep 2022 10:39:40 +0200
Message-ID: <VI1PR09MB423909FF18D8749A57DA443FE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921083941.8461-1-isak.westin@hotmail.com>
References: <20220921083941.8461-1-isak.westin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [KaF+parQ2TQjhVyNfNH0rXyHutcJhi+K]
X-ClientProxiedBy: ZRAP278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::18) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220921083941.8461-3-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB4239:EE_|DU0PR09MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cc7ee8-d28b-4714-63d7-08da9bacf27d
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3lUkjXuSDdeTQka1McTh6g4uhRitKZOWH7RZPMTNYfuYHzfo8yhypC+gnyecp/34vCveu7mx3G/5X43Reui07lZuyTEPtvPjyd52ZDcstIurPvlfvD2GQTXu+tF0aI2rcz9NJVcd0SKyw5OfyMMrstRIaZLThQ1GnBTch/GCc9IIxpPHZTm12yDhegIgTxOUBZZlp7X019G6vc9DzUpkFWvRkrPvN1QXAmMv+cD/t8Gg4GpV5c3yPUgPF8c/JLWj6vO3kPCikgeZCXFXNEDFCKZPeaCDQgbK0eTmUeqlwBYNxxjWXQqf/aUhE+w0DWYSTtFMjR1c22CjzipApY0zCmk9Q3ukjYww6A8flpviTLtp5tN4PzQQkZR5WSYmsxvjaqakt3oQDY7ux4+IgWBk8deZ7BKvx6c7ea/Hc4mVKXgHr+Pu0h0WJe4EtpGIcwDqep4dYdWzHW+bdimxWkBdWl+BAlBylKfDJ0R3qjv/P9SLv+ESul2w/ZKn+m2y1krnYstQgHEKicMjkFvhOf27rQS1UF2jK/fLs5NKbS71qEJgaEBk9Mi2WqjrNVQG0n2lT2+KwueHz3LRRlVz1suXoLA2cmHUTxQeflxfpJsXr7YDAmkX2OGQc89vqoreEDyD8Yox6wscvTumTMrZP2oZpeDnmvnYs9Tdz1WiJ8edlUdJuaMMRxahPcLbtcn+9P0c+RJ/aTKbehZOsltUXfEUhWNWnD0L+JkfAEoJ785Iv6P7wSIXWvrXz/1Mk1rTuwsHIezUc2fM7/WD8BTeVCj5CAu
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G5Db6SPM0SbRoNXXgkQylvc5JfvULprLl8ON22G43RzTi/qRRDfaU7byvl5On1JdLLutKGGmwTqHrZJdYltPJAisEyg5RTov5sGnoGj1Z9Z8OVIP+sEWfoAmYBABScDS5PmgyqZplE/Q1ftm/dyvNYuLpu4WMDsdlXu0mDjsMfyeJ1VBomguJWVF19Aqf1F8p+AW7mO5GbudS4prHtiYOmXyd31ihcpWmA4+yDSOSgtx10EGND5MJSoKCRqQ/SHJEa/eRXBw8laqZqlkfZTc/NwnQP2zCIoBOpXsjMPDLFnyR0OS0meXp7C9mk3uhbLgMCOpezEKQTH2T39DswYQ3FeSNfbI+QIfRw3oWUevO0h52QT/0RYi1hi2ayQngF+efknUpmY65cug+cghIZ5DzQJ+u740iqq2RK15YxnS9ilcJ3PJqmK420pxJh2KIY9jEaGHNPJlZoEn6C6YzIZ4eDRYKhADncMPc1rknyyH0EgHRmVbg7ZDedufzsLe6HovFWYiC4lZYJ3kV3haLFr+iczzwFtPfm8q2qmoK0+MS2HsAr9Tf8iAOnvGHVyRbPxZeX8PMcwG6aAf6ErGuccSs7jugmu05jyDIDRjcyMAKTOcmskIn8UU4pdYE+2pT/pd7IQTpUC8l1edzY6vIuxfDw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s7C/uLqNWLfPL3/QM4TrGZRy9TPWki8kGXGrSx3d3HXshuTgeIM7YeHCrjxd?=
 =?us-ascii?Q?ljmMKBaUjW5B4ootv+sbxw4Rivwzg9lJ+qcd/NV6fCdfoyPl7ra+JGaCAOdI?=
 =?us-ascii?Q?K7F5WAh5MxZ+Ybx2XKLhcTe9QkgsFkHmvwhX9tvd9NN0+LgEJHgzcA0hkaDl?=
 =?us-ascii?Q?etDNxeiGSYDmG0K5wY1LivYa7q6jK82BLf+vyySvg9FMxxQ3pJCZXmERsx3j?=
 =?us-ascii?Q?iA2KWt5w1LpD1O3OUvzkDTPnrY5S/N2/aQzmJQg7SeyatFltHTXgj0YeDmhU?=
 =?us-ascii?Q?HCmkGJf4gnmrjx/OZBvgJIkfBM7BAd8zQixYxhye1rBYk5xRbRg9fL75422b?=
 =?us-ascii?Q?i6524zpTRsYp9xddV8ypcmBMb4SLXHeWBktfnpUxvItFKR+Md4MiLR3Swa5W?=
 =?us-ascii?Q?9mVHunccDPEJWELzaxMDZTt5tMmCh36/4M6Nm6YlFxug9VJLZQTS0SP2+3Yt?=
 =?us-ascii?Q?mTLSC3ojlZ9MdShCbtKXnKoS3hku0+iwTJTubXNOoaxhRKDb/ry6Onw9JU1J?=
 =?us-ascii?Q?bPzOTYTyGMJLMm0Oc27q3xM8cLp8/F+UnJ4c+O4lI9NAf1g4CFiiDqymidp4?=
 =?us-ascii?Q?+wn52W1PM+asmuolvc6l+dRjvSObNzDVrl64uIxDqwaxVUkEkd44vffXDxcS?=
 =?us-ascii?Q?hlTUrsFK7xUHNZqACzzwk9Y2mLYnYBHeb58gB1zKq+cpuNHEpwvRNIzARM29?=
 =?us-ascii?Q?Mms4eptex1//d1DN/5FQOKSDbQxMISWjLw2T6Rqhl+pvUV2aH5UeksJDGV7e?=
 =?us-ascii?Q?ekLyJyQrTFdv4S/PJBtab8IfyxqAuETFLBvIm43WUa338q7G2K0Af8PDj0EA?=
 =?us-ascii?Q?UJStPVVmbC9+I5lb1FDEjE7Tp652JE1/wl5OTf/Yu4aps21gaRbV+KJmOHgD?=
 =?us-ascii?Q?JeO7BbVPH9t0n6PVvALb1JHNAGPALJXplkKR9t4nMf6oSjfVEdgzK4B+xeA0?=
 =?us-ascii?Q?JIV7h2i6gfXgSoZJa2MHm8JI+uXXwXLpagaZ1NWWNBc7BcIDfVwbBEPuECbc?=
 =?us-ascii?Q?EPhHvi2Xz4XcRIa6F7nfAkkcienWROKbKWiT1bfuyHgknW/GwfibafAzxs4h?=
 =?us-ascii?Q?grXmZtyg1+6q63L0VTekh65oRMB7K0LAkXBqM7gSGn9Qld4VgoR7TYGUGonN?=
 =?us-ascii?Q?gGq/oQxwkHpD0D8uoCK9e8DYC9jHTc/ipsBOWhrhoj5M/KXViPfwXIIFoWAB?=
 =?us-ascii?Q?rTbeeqrYUEntu3EGPfH1MSwa5ekxOAZEUivHCwCFJuqWSgKE3yvAIfXxwZnZ?=
 =?us-ascii?Q?GzwAKj7kTBe45p4UoUOrePpZoX6d1/+GSQ2uheucxg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cc7ee8-d28b-4714-63d7-08da9bacf27d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:40:33.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB5693
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a user tries to configure publication of a model with an appkey that
is not bound to that model, an error should be returned.
---
 mesh/model.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mesh/model.c b/mesh/model.c
index 82078ed85..46ead30ac 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -1063,7 +1063,8 @@ int mesh_model_pub_set(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod->pub_enabled || (mod->cbs && !(mod->cbs->pub)))
 		return MESH_STATUS_INVALID_PUB_PARAM;
 
-	if (!appkey_have_key(node_get_net(node), idx))
+	if (!appkey_have_key(node_get_net(node), idx) ||
+											!has_binding(mod->bindings, idx))
 		return MESH_STATUS_INVALID_APPKEY;
 
 	/*
-- 
2.20.1

