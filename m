Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D998C6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 08:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiIUIkm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 04:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbiIUIkj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 04:40:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075044.outbound.protection.outlook.com [40.92.75.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FCE67465
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 01:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK5zdVYvQBjpsrfMFPMKsCPKfIShYA4i8WrvksoFcbA9OJmk+oU6xXAEYegKo5rqv1GYf3uuSjpXLnQ1vsthUf4ZQepX9MaMHzdH8KiMQ9isffPfnzNFw3pIkbHveBf5Df+uHIY+C44ndZblN5tpmLTbX22KJ6FxiqPqmVz/oNho2aa692gEYAtKDVueQuQDXf0O8cpiY0qv8uEjH0XXJHgCob9ff0I7k30A6+rkdgt/o+qiRIX5T5Y0Fpm03Mc7wcGSk/yHpRPvo3aFs28iIcNmNECZHrL5fel8O3wvNxy1QL4EXp1mh97ourQyhAkAvP929z0B2x45oLoJJQtPJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VIr6BOpjtw6XqA5OXgagef97VCTzltc8YjKGmXE9do=;
 b=Z09Ra79k/VrZDxxEy2aiVQTY4DDSfiqBtOS6iaiVWiVms+OKJKMcMV1iaEGoL6powWg8hZMfI/OAslSZ85dPughpYYHcO0ipwVKmBXr3SOgi7UFVYTuq406y+ykIJaaGI9TA1eLd4DZEie8vLsypSVwIz2iHlzw8ZhlwbVaRoq/uGL5dENL3yg2posS+7TVaGcBXe5DsUFS8nV6TEQYGc7VZmHRmPH8y1xcjd5S6F+kJBmnclxrFkxXFcU3bNnH6UHYNfGSqUu9Li9M4j0OAHwKpRb1q0Vh1COJEUG/GyaLIWc5DC4RmzsPe7JF2XjzSlwCPLcp4mX06I7sYDcHayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VIr6BOpjtw6XqA5OXgagef97VCTzltc8YjKGmXE9do=;
 b=aUoK9SCkwa/s5v9iSSi7GdyKXXaodr3SuM2iilI+i/qvDa6CQd0AcxvpG8fO/4YYY2KXJBfggh9OS2DjAbJKeZmoXYAxyeoMMoTDJzwTrvqWBaA3KfLkHoxq41hyB38ydv5wrDEfsCtrRDl6ThhS6CasTrYssIqvLOStZfipHRiS80P/AceTJndk17qAvYjUaUfXN0O0vkooP4TxI/AWGz+W2BFfJMieUwQMMxNR85KSXxgBWbWNrNqoZjv3RGKavAnJHyg//gIHdxkKtc6yDGcsv8M0+/NbQIc09esuDb5YOWmdPDkgQ1wM6ZBYhMQ0Sj2zpj2ACyYSNpy2zNFCvw==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by GV1PR09MB5852.eurprd09.prod.outlook.com (2603:10a6:150:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.15; Wed, 21 Sep
 2022 08:40:35 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 08:40:35 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ 3/3] mesh: Remove RFU check for publication set
Date:   Wed, 21 Sep 2022 10:39:41 +0200
Message-ID: <VI1PR09MB42397A9333F0143CEF4B6BF7E34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220921083941.8461-1-isak.westin@hotmail.com>
References: <20220921083941.8461-1-isak.westin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [hn5stooQwgq9HoNADnQE42YsH1g2lRVa]
X-ClientProxiedBy: ZRAP278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::18) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220921083941.8461-4-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB4239:EE_|GV1PR09MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: dd20e6b1-bbc0-4f61-7e68-08da9bacf3a2
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3lUkjXuSDdeTQka1McTh6g46PSikGHYEgqsTerpiurlgHQ/M5M2g92DIV4wslRrh99EwJR6/apgtv1hnMxIe7eJoI1maazFLvEUcuNRJf74R2UJ7EhiFViRFoc9USgUxVSNwmcWQP9fngMB5fppkH+44FruRBpe1yWlg0OyYxmlYgNj53tAKCiQy8OqVtv3FgJoSb2UG8GqhNMgM0i7m7ZdJerSARA28b/nI/lnqX8/ExDE+6ekBf4IwpOJevpwkW8ReurFPQDrrr+KujOPewR8Tu1SooGx+WNfABxSqOP+0b081U5VGC2vlX7Gdgr3fpG6BPDGvyOkXuhUSciJvDpuAdAi2k8qG83ihesU7pDOLwqY3whecwMYDzdCGFHogsZ/s4m5ARYk/CnFfgkr+peiBwzuWVkyGp1QM6j/neangguxmMgjRyX+XtAHzmx0j7eB16VtXBa70u1OGGgeKMTl6i0GMGLV2H1Fl+U0QhT+IbCCn3BX6JsGuzexrC6MRpfqSptOXFDP9v7Uf8Us9G8H3SGL+NNzjH95KYL35d9D6xfZqalYdQBYLXfgiTk2LQYs/K9DyKyOn+G7jJPMFlEPdBFFfzbDEPsQk9/VK2U1MvFu7gRnBPcrPSTTPBWA6jpmbdrfYG3pGaX6lz21UUo6loHobBNWauO5x+obnR5UGUC8k2gTPx131jhfRcdUBYo8dhYAE5uK5FRh0MRSEam7hz/dzOr/ZUOZXGonJzbjwfGjWxWcknf/KRENfv8YjoBdrd9wpCk0qXD4TRn6Rril
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPaJWge0s+j4xvjK7yegjzGdYyd8DjzNv/F85hbXK77upPpmGBOYeoaoXEurOy/AiFOyh/yzg6ldD2mbxF4ilrwPGYqeEw/leDp8gvp/DdEhfnjxzBbfS3iNP2LdYOr+5VFgve0uOD0pIHvQOWEuG7gFBeT+mbiuLS9T7kmWygJ9NZ+Gsugh0Xhz/hSDKfbm1LsoKCgtJks12w0fAg0UhDNoaV8migF++VWwQbFDj9SwEme5vwVqExUzj+5oD6w8lcjjyTkq6255GW5Jq1GOLcODkL8YfTybQc2vgoBhhmF7iMtlHnzIymJRiQJlmvvlNP6fQhS4ZNQUqpI091zcae6ynmG1o8wprxA07xALrLcCmgrDcMROIrwBrO9Kj4BD8F4pD8wI79cbkO35vxaf95JttbSokKQj6vhHEbF4TJlnazu5hkANZGX9eabH9E9kfm4oGljxXJzfNLoCKbuYuFV21/Dn6TBZZSQe3c/XY3vs4s7vcTsRppwEI8moQKH2JU37qDud94VyRdC1zgc5v4Nidb+kPdom5ZuUv9FT0XcfotI/kV7YTHtiD8yPLzvRV92vpUCxjLUArIYZq2n6zxXTtatKVCR5YkgfB/keTEJux8JguuAF+zxV0g2XdsKN82sHn4GK48dctmtyQKAvyQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XuxbqUnwX5hGOWOx0n82Zhf8G+NFiyDKVLILYaDzxlDE/HXNex7hoVcxZBN9?=
 =?us-ascii?Q?Kb/JIYgUzV/HVvIrwP3zBF+SOythbNyrHsD16EHWLqtcATAhIZgfrbbat7JQ?=
 =?us-ascii?Q?AHh5scYgnRnsExnsjtCIYfu8zaams9qyVWpFh5LrTi4YgTohxaQO0TazRm4a?=
 =?us-ascii?Q?AvHig7eSneONQlbmXhOPIy6yiDzTTNvj/W6VDMStGNtrBqrcWV0c4DgY5ls3?=
 =?us-ascii?Q?SIXsD8BHQGIZuuFRFEwkkrBkgMTVvmYikw0BsrEqRucOGzXJyXrS4n+mpIPE?=
 =?us-ascii?Q?iMMCVEMqhKudMSBibIDn5D3rXkf5g7qAtzFfvr4goy9dlTq1ShttMhTIyjJH?=
 =?us-ascii?Q?mmiPdmk56XZIwjGmS66rGQy25ECn8pFi050tirLJVbUCGZiSyMM3Qz7LMiqe?=
 =?us-ascii?Q?DStfrf2phEIK/VpodL4H1RS2TiU4DL7hWXsZcxk4dbTL9LqM9Zr31C+Bt2Gs?=
 =?us-ascii?Q?w3KbWtMW5JDyvyA1JvBiKX0hqK7Leadz+5Da1kiI8UJSheTHvUcCg/kA2VH+?=
 =?us-ascii?Q?TvzIHi48ePsbuad4+8DcRWapqNSU2zf/3kjfc05VjuK6AcBy42seJCOguVIF?=
 =?us-ascii?Q?WFMElRB/YXhDQCSxQjVCGxPlM3lUlx/1X0m7joHMWwgRO4oo2flKOuElmye3?=
 =?us-ascii?Q?RBGxo3ygmJwX2dxwM0gqMMB68xK1U2x8V0mPzwdItJMJw/8M3l8M/ZxP3KN2?=
 =?us-ascii?Q?hc9cnSoom8qNL0DsiZQgVLdh9MdmrRs9c2a+ijI84mTzh6pM4WtlRqn5N2NZ?=
 =?us-ascii?Q?BY1/yE/B8m8viTDgZeJhOkrmj3opndGTNHL+qYBxqkjbTCoehPNVRvNqfeKH?=
 =?us-ascii?Q?ZX6BHGa/d7fLY4nJlNw+Sz9/ACRu4D5ZHaDGHzJZ8L473WI2tO9aMXXfzT3y?=
 =?us-ascii?Q?OIhFKL0lO6CEP5Ly1IHiSt0Opvrr9vYMLtFiIg7ynmabXLvOwudNFRF1/Pc0?=
 =?us-ascii?Q?vfH562wfnKF2kss6Pom+9Sa5kG5G+uav0khHFWPfXE5Hn+29HC9bEFDl/U8g?=
 =?us-ascii?Q?t3q5rnt3VboR0PQv4HCoS8N7pqoio+gYhyCyYAfIiSgC8e/YMX9I+ppu3j+d?=
 =?us-ascii?Q?HMi0fKh7MpUbyLijDkELXddL64OzLT3d9FatQVRLStd89FwPRATyGf8fJZIQ?=
 =?us-ascii?Q?6t6fNs+M7PLDvQiHzWgkVrrZ6bpj1Xy8hIJQtqmazf9QL80Ncd2jZAFj4wEk?=
 =?us-ascii?Q?FPVYfmkyh5OjH3Wrr7pK2K5wcMfV7XURPaSWM2UngTQjnzExyMagqOmPGgDe?=
 =?us-ascii?Q?+vnx5brjM0UbB/l274YhLZ0QqKXkkwyaLrjuwlrdBg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dd20e6b1-bbc0-4f61-7e68-08da9bacf3a2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:40:35.2726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR09MB5852
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is not stated in the mesh profile that the RFU bits in a Model
Publication Set message have to be zero. In fact, PTS test
MESH/NODE/CFG/MP/BV-01-C is sending that command with non-zero RFU and
expects a reply.
---
 mesh/cfgmod-server.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mesh/cfgmod-server.c b/mesh/cfgmod-server.c
index 5eefedc4d..c1e1faa6a 100644
--- a/mesh/cfgmod-server.c
+++ b/mesh/cfgmod-server.c
@@ -110,8 +110,6 @@ static uint16_t config_pub_set(struct mesh_node *node, const uint8_t *pkt,
 	pkt += (virt ? 14 : 0);
 
 	idx = l_get_le16(pkt + 4);
-	if (idx > CREDFLAG_MASK)
-		return 0;
 
 	cred_flag = !!(CREDFLAG_MASK & idx);
 	idx &= APP_IDX_MASK;
-- 
2.20.1

