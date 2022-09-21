Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3409EC32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Sep 2022 08:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiIUIkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 04:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiIUIkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 04:40:19 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2056.outbound.protection.outlook.com [40.92.91.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2DF48CA4
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 01:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRLoXTCSKO38vK1t/xv6+/0fyVMgJx7kvBqTaBPnBphcM66X9Dib+H40wToinEENQ21/LQjjKiqfRmsjBp41WVWhXMuSct0Dqy+ywGSvOPod5mJFyccLmt7plGc53/GYctA83y2AzQ/gV6Vw0GMPDfhu/WdeGY1DEWeGk1mv4Ht3BaYK3A2ANzeekRldehWLbEqTl0QlF3Ox5ZWzKBPKDQdvqavQBMgir6HiCLrc14C8DowaOw0sUCvg+Nag5+uTLS0Tbbtk1BoqaMLEsIF2tWw92vUn6AtonMak+E8vfi+deoj0TQr8JVbJXrzxy/+n9RwUYST2SBA/A+nMEeX/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejh0zbsST1yj9JW1PyWZNWnIbtEZ5CFuA12JTvcCFfk=;
 b=SJQVpDSj2BFjxVVLylND6QaRc5DOcAxwPiM7JQ8otK7IG04A1jVduWYDYv46G5ECFio0QOXKg0Qmb3QJ9ksHc0TeyKHpTp1quOPnQ1vusGtD2i61JxsExXmuNoqtKjM5NURXJo/6tHeyJIRBRlGgcsgO7YJOj/zeFKKlQ0LU8KMi0yTZabIbQxT8Uhs0uFvhhjiAcBeGQmrwkKFcMyCNsHixRTvjwB64iu0RhmVg2V1ZoW57m10IAbikExIvr3Y62/J/mQKU0LvPK8U3kbAnMJVi0OsyazPD1wyqSz0/Tn8pGC5b82WygbDyJKCM/dRmp24fugNO1VxyrJgPe5vQAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejh0zbsST1yj9JW1PyWZNWnIbtEZ5CFuA12JTvcCFfk=;
 b=XrP2ok8Dj83mmD9savj/S71NjLXEgz2N7naY1vCrXLyK80NQvosGPZKfV1Ix0OJNHJAFvclijHA0CKiHB7S6hWScbBi7kaIYCM5d7fStUmL/naPBmu5pPhG7CJsJEenVbKr3zxsM+aEY4F4c8duE8byUnD8VH11rcbmQw0Sp0qd9VSFIpAD2tRLhaL1Bx7b65bG6nCQYHl9W6Ih7yAgT2mAodKqrWYmf9YdiByLsGCD4eU1rg+gJ/1v7o3c7CaWgNuI00qtgCy65w1++2DFeAh8Lpfb9uLkWAxLGU/aR8akLbQ8PQCMV/MATELF7sb7XCXbs0hN+lsn4OZDKtlZJcQ==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by DU0PR09MB5693.eurprd09.prod.outlook.com (2603:10a6:10:31e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Wed, 21 Sep
 2022 08:40:15 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::adeb:7a9b:9960:27bf%2]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 08:40:15 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ 0/3] Mesh model publication fixes according to mesh profile
Date:   Wed, 21 Sep 2022 10:39:38 +0200
Message-ID: <VI1PR09MB42396AFF2009109A4318E51AE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [yVTJqAprGHKBO1W5HqRC2pL6s+IwQyV/]
X-ClientProxiedBy: ZRAP278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::18) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220921083941.8461-1-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB4239:EE_|DU0PR09MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: bb18276d-af20-437d-6d28-08da9bace783
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3lUkjXuSDdeTQka1McTh6g4HkjOOwmClooTD68GhebhQW1VACKWqo28426JGqHOdbJ8pLWSmZe6rWjUCaDD8wGfd4lLzRhPmT2bSfqU8nIuz01lt42tA8dL9baxwGyBm8Rx21pMVZ16+tphB2ftF0R+ve12BlgWzIUfUhJ+7rOwwOPvzpXv5cIEb2Qz1OdPB1sh+N7aGM5Z58gs8HYj/3sdZ00Rl//m4vudqokE2zplHeTBN1fG03PFDGS9XvE1X7GIcJhEA5xgVQEAHZOyAaUGcH5LULWHaNiDqXJ6P/keqdDkyrbwYc0mOfRMMziucNlPxX6wDVSD5WHg8GItu3BkpjY1DSrsegVq82j9Ql9IlAMN4o65cSzOClRApxyRF2OOvIM5hDFw2EEE13oFh4f3YjdUpKpPkH90lB5ZCPSm0oRrtDNpuBNFIM2xNUSSBQpUxdQA1dThoqetAtbX86K/aIn0801TfORmQSUrEBC8oB4zD9D+wIyipiHAw5vGDfXGUvOeLo4DGGWImnrBZXJ1Sq3zlEwis3BCIMHwRqyRvw/XQPb4rrZod2YRjOyVlmrMVAZWDpkJ9gJIMnRhgMeB6Obpd9/Pemfun2Je8/j+PMwDDJgoRE/AR4Jrqdu2aG/bGoht3uSsK0e7stvluyT+H9wc79ZWpU5sMxscAR5QgvzWLUHDlc51/ZZ36jcgZeasl4bgJAr5XLiynUoQ1RmhPR6jAFPOy6Ixjn7B+03lBxec0OkE3C3R3JUmbzfThrhO63ThCBaEBfxn5rOEyPP3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wocc2fGHmJHEf1yvXooI83Ovkvu+NH1DdTxd/lHmWgxhGhg9LppkKuAu2zMJvhdijUDZw6JZpJeFQ4UEyS+IsMExw6cBSS9Pl4OALQVArfCBZb8KbTc+UujtWz7+DELxBMHcGSpSBa4qL/QV6Q7jXWSXPQu+nYIQjEG9ElettdOvUR0sd1fT9PXFl7MpcOZ1+sr8fIhvalR8zrqQnSkgAtIgB2GNJMT8SNHIB5S/x0btfATSrtYVRlR7xoHlPa3czjVo0DYt1z/3qjkGTnw1thMk9qkNrZCJtospvC1HmXnmSC31AYL/VsRVMg2bcE+DfkTI4vcei4Zp0VjswYjPW3Wiag6nMRBSEvOyB21CBvRzNDGRqbTbl8j976az4fOx1uN5wWpiqiVzQRsfrqnL7v9Aypqp0UBjwRIkOyQNvisiu7vctUxsrtAqEDjHSoweEtuKxf979ou7yT4rJfWIhAz3p1kxJfry5kvBypsxwJBUKbq/9wSmgIDwGwj08vICX+a38xsllTxSJtkBoVm3dXoPMtxcVIRNQKVxaXDQFSPXR5MGI80jRySrh6L2Y+/IwDk0fT2NBLLl+uw0BvVY8YdyVOdiOY5NlQo1hXqxRvh6wX9BHE04jKT7Rm5payX1EUaAKpOmfAoRXq2Kkwjt9Q==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?euG3vQoZjo7Jrrl/qflhs7ZBryecfFPwlxKc7hOs3/D5vUmsLWA4EUpkSleN?=
 =?us-ascii?Q?dgvdVYiU39K4xP3FBacqMCr8mBFQZQJJzsPiN8BZIX19gzs96t+J9BpOR9jH?=
 =?us-ascii?Q?rzN9NbzxHHVUTgD92nf94FV821+UWJ0Ju/zaMNUCRMrUVs5W53UviSUcuglw?=
 =?us-ascii?Q?Vs1hYGgeF1EJNiGAXZ3I2yPdJL0QAz9xO8Ywdp3EjnPCG3hxbNjKfLiKoa8j?=
 =?us-ascii?Q?Wt7tonydiIgwyjdfSswle69cEjyZGJ2WKWtjyEzSeV2NGu1rU27PBjB5hmHy?=
 =?us-ascii?Q?SXgxvtKqPoLZXJkU/pihoW6yMAEC/rn/gMx0+LbgHHuvn7Te9LrtpKJvIuVg?=
 =?us-ascii?Q?oODGAQ4UlsKJ8vOlHJl5SiOgeSoT93PEMaeShe13VVciVlDwBo5C19hq/VSe?=
 =?us-ascii?Q?1MHNPVXD/S84lQb3vsAnonqXLp9/bXDvmi4z7MVteWh3HSDCPRU39xRIQAmf?=
 =?us-ascii?Q?f/V/epQfKhhKGV798ZSQ6veQhhIp5wMJRxWylEEGOhDcU39yiAOfhKYTtxA5?=
 =?us-ascii?Q?578HF6b3u9AvFhNe5dphCgYOSrTCHBl2rLiIDZNTJdZYE3zIuOoXP3hnem4u?=
 =?us-ascii?Q?FksXbhevHjx2Ec9Um1u58fKAdRlnncySEwgdzaPy11McAsKvpBHkrL06+rTw?=
 =?us-ascii?Q?XZcOLNvoV/HAtpBzWsTRFouuKqxFf8PPG7EpiOV6wMA2MavUboSkS2A5zVH2?=
 =?us-ascii?Q?B/xnjH1ZzCBB9qYtOdVrKyBv2jL7ArPyPZaskhDHaNOHAJ0SY5Ha45Rl2Blb?=
 =?us-ascii?Q?yO2P+rAwrz1CBiL+qvnWwVXFVyieeAsFgrB2EqYpylU7i3s7oUOFQ7n9PIRA?=
 =?us-ascii?Q?NTO4nf4o9ZxDnFiCuhLtDnc1din3A0RgGdClP5jm4QhvuNX9RtTB1G6bQRn/?=
 =?us-ascii?Q?65SDC+3T47smpavjXcZuk0WE631DWHSTWF509puUjxcSncFzkGQRL0rBUqQL?=
 =?us-ascii?Q?523MbjQpLEC59qV4NhaD3XpvDFgeaYNin3H9DrpvmHMZoMEg4zefl2ejDXtj?=
 =?us-ascii?Q?FJtwrvDLYuYumJeQClcjkiSQGt94dsZIeeHqbT5c4FoP8gHkFTQuwQOz9wW9?=
 =?us-ascii?Q?6On/elnIKcYS7YHT5Kd+wn4yPUYihMqA/69jv4M57tep2JqMvCyJONL9LvS0?=
 =?us-ascii?Q?4epEEC0XUyzvcvP3sAq5XzH7QqgK244pjhIJkgLAU+zZIyLJeMgkgpX9WJQB?=
 =?us-ascii?Q?XF3335yFHyTX/WDwjoWmSOsc8ryaDNl6gfZAAhe0PucDEu5KT4+f07JB0GPl?=
 =?us-ascii?Q?VQErtZ8lU5motgIP30KV6E3ESZkhterV5KhLEgPNWw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bb18276d-af20-437d-6d28-08da9bace783
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:40:15.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR09MB5693
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

I am testing the BlueZ Mesh stack with PTS (MESH and MMDL layers) and
there are some parts of the mesh stack that are not behaving according
to the mesh profile. Here are fixes to a few of them I encountered
when testing the model publication procedures (MESH/NODE/CFG/MP).

I am happy for any feedback.

Best regards,
Isak

Isak Westin (3):
  mesh: Add interface output filter
  mesh: Do not accept publication for unbound appkey
  mesh: Remove RFU check for publication set

 mesh/cfgmod-server.c |  2 --
 mesh/model.c         |  3 ++-
 mesh/net.c           | 28 ++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.20.1

