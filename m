Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCF1E894
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801325; cv=fail; b=sPJXJKC6cDz6lDQrbtHFti8fKENf5/gnYGsJUgKd97gzkK7eTFRMnG9tXx31vWCximT04nkXJxqiH+2+mLr6fzgChIvkjnlPjalpLvkXMXftFn886ZZRqkKygMxRmpo/pV9WuzyQJ03fMIDh7lgRAiUdRgZ+QtSXWyfAuoW/Azo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801325; c=relaxed/simple;
	bh=JxKYLd0QL7PUCoSlPHPxLSq2stR1xxudZqK+aWeRp5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ECfLKsJwth7W8otbKQMQjSwMqeaSOH4VII3jOC+e2ZIKuU5XpvV+/6avYtje5xtT8W90vBSxQD6FgWRz2oDxARN9VBOk6UpZpalUnpQjygSHjC+sdGnpdq3CDwsTM5bYcU3nF/Drxybrcvm5/2Ep0OVN5c+LmxKWBH9ZQ8UyRU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZj+Walw; arc=fail smtp.client-ip=40.107.6.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZj+Walw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7hGsCl1tvRufBfC3HdzS3ZUojFlLxf7NIVgL42bhJRakkXWS8ez+I+YgWCv/knmqvGdv9FP65CSk6wSg3x/5vX5h/HiGcKT/BRPAQgcyKfHqp6NhFwy4u//G9qIjBm7TWExgAf4eP3sMIdiwYhEf1b7FDzIRckbhw1wlCteGD1vL0+hT0QOZ/J91wEK2vAR/THRipgWOLyGo3W8JwyBmKmVCuyl0V5SRveLUGF1PfmVv+Y9QcT8ZWKYn5IHDvYwMBFu1thVt+7F1zoSiPtxT9ir4AFj8atGjzMqicPhx8yUGZjdEEhC1eFyKBo4TOCBFAXvssH3C8DiDlWDOx4N6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrViA/sWYUIgreLg8qm5JqYNRfiSnTpjX0TG3E/0VvI=;
 b=Peno0UCMiVc6cQIQpeXO89E1BolL+qtWufZMQUKqnDNM3Y9BG0djhfguQgRfmiOwHASKGGrq0KfJLxFlvgKvejeN8JMiX0HnrsiHvlul0Ezkv3yqBxOFkmW9rEm1mf2E2yo84hjCxS+NCeMJ+DHzFh///MC80T53C/4wsQGQzzZUyhNqV5bVAEIwBjQxxOSOGyoD+0ZuGuOTODJX9b2V5Osh1GCYqzUv1s7GGU27sJoGWVuachBknjio5D0GNfE5i8GMWFyWXoCQDh4+GvnOINiJk7Oim/liOcthR5sFm2oMqPHoEztHgBHiptTrWlkSqVtEkyYlmoZ3hXh0WaMEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrViA/sWYUIgreLg8qm5JqYNRfiSnTpjX0TG3E/0VvI=;
 b=mZj+WalwwubAym9uQ+WrfEqlL/1RQzNfvXXxNbOEHLu30zxRn6Qqj36VgaHkQmQlQ+BE25WlFcAeTeBvrcOlBk5V4hQedfgTkencss0wmw2pytLZ+FO10/LboThYOBB4/l7j1ZcY9bit4B4yWegGuIBYOE++wV6GyGhEy39TkZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 15:28:40 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 15:28:40 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/7] bap: Remove set lpac user data at bcast ep register
Date: Thu,  1 Feb 2024 17:28:29 +0200
Message-Id: <20240201152835.196617-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
References: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0024.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::16) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 488cbb3c-7d89-4e28-4728-08dc233a77d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+awZPKhShu8rXK76PuEpjW6MdJZS+WwC7cJZZPVm3ytsD08640HSfWq53CX4KVPiq9hXshfghMbSXGfJY98QKwkld/pLlJGdvxtWaJZ1NBSGgrcrHxyzLhZlxt41kmlLj4iH4eH1NZf9snZSkxnVZSKqWxPLYzZd4NIzLUMgvlAgeYI6Q3DYSFrch980cMaUqZ4LsNNJyq+3gHRjoGUzrS77AJJs+XF7EsFDhob7MY4PqLoma5GyHkPeBmcNFYxXi1lGtLkzdfqSo7YWfWImEuaxEg3mSzxTkM4NMfxxSAtCjX1Zr+UFgw6SL2HUrEGmKgCAGKrm2boYzGUMkezv9cWm7HHnabYX/KvY20X6hPUnmNoFSmjmqdFYC7mYyjBbEnYBOkM3XZKHcEJZij7Q9E79rCEQuGadudc4rbZTUe0FjCzrwx4EkYO5bFQE4ZG2LTsHOaxcw+lU9ylqtSIgllLcUCfempDMtaeXENY9hvxe+hL9+jPu8OPIAsJH76qulPsooG4SNgYxVZ9Fhgo60S111gC8ghs65VTWcK/xR+mvLuSaG2MGLndxmBRdJ/Ql
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66556008)(66476007)(5660300002)(2906002)(4744005)(316002)(86362001)(8936002)(4326008)(6916009)(8676002)(66946007)(478600001)(41300700001)(36756003)(38100700002)(6486002)(26005)(6666004)(6512007)(1076003)(83380400001)(6506007)(55236004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pJPsZK4w+r3d4gAvRmyfHsA9Kea6E78KI4GFm736MDMsQnx77XTumGGgq4ka?=
 =?us-ascii?Q?uIWQxTF+cCS31O4KXt1QSeMTkwnUAxGEZgSVHC5DvqN1eNZVaRKHXeo8xcNb?=
 =?us-ascii?Q?2PyN5HL2m1sevSc8fkR4gRrzRXgJ/GcSC2yM5AIdAL0nGIV2mT2uHiuLM2XL?=
 =?us-ascii?Q?elQjF2xg+zi672wc9mqwEIIpI3B7LR7YuFxrs+vVY5K44Ds+T7loO09eBBX6?=
 =?us-ascii?Q?/ibyXZSbNu1e+oYjZDjxhNU/yAHEAbm5/zEUEIMIPD5+pN0Mw+NuFpYjGNAU?=
 =?us-ascii?Q?u++KxjRoTb8TJX534MaJFY9/lxU76JboYpVt6NACkGfEWQshlV1lHrjJrG//?=
 =?us-ascii?Q?Z7mQB5I2c7zwEZn8J3+LwiFAhbP4tLTLIR89M9ndZMyMpq9sYWdExWPPx9sm?=
 =?us-ascii?Q?7axoSySbP4PeUneKhXO7SklUY2H9XgTOgSJ/oylIT745iZ+KWk0hP3u8YJDl?=
 =?us-ascii?Q?MQyOCbJpPkIG7+Dza1pzpZIB6RF60lgCty76uye0p5eIHBQcy0sk6oqYWMbB?=
 =?us-ascii?Q?8lSV4aejQ1hD2F27oXx5RqRmGDdJfhIIEEG/PNgb6wdMsnsKWiDTf9AcGjWQ?=
 =?us-ascii?Q?oUkLlkTt+cel7v5uKjlJXCNiZsxIPdiuclrR1ynypFf+jqRYkZU6ZRxNb8bO?=
 =?us-ascii?Q?3Zdps6I6umS3yiMV/Lqdi47Ecj6SxB9X2i/9uZm2YvKSm3Zgj/Q5n8NcTSLs?=
 =?us-ascii?Q?zDqntzUr4XVbcVs1CtpcWqMLDMs9WWsG+z0q607tK08KU9FyrZmP1Bvmwpb6?=
 =?us-ascii?Q?XxaIuRNj36T4F+I8eKmgvfP0cI+69yTp044pgmx0/JaqRp1HlKTymvdOrFl/?=
 =?us-ascii?Q?weW/uKvJZUCwoieRkTR83qU1fJJO8csMaHo32SuBZhg/dlD/vPXwUgE+rBhJ?=
 =?us-ascii?Q?h1OnTZ0Sv2aoYEZOIjK8riLHZk+YAqvmHK2038ccZqn7q9cPnAGNCgbhAwZN?=
 =?us-ascii?Q?gJK7mHBQ5pHey6bcARxXtTFZDyF4L7QjQzixot+Jcd+OMvpNsYTug3Kz78iv?=
 =?us-ascii?Q?uTkNTpVE8UsYUMX3Eygpz4B3af4BEgOpnQTude0KSek1C3Q5bgF1Ei8yiUDL?=
 =?us-ascii?Q?T6kx8HrKntomoi6dgx31paIc5YzLhQi2RY0uxWq6cyCDQu4RJ8/HEDVoDq6b?=
 =?us-ascii?Q?43Zd38rt+u0FiqXiyynci/gndp3VGSmt87U7s8FwgQ5TbMWidoScby/75EE3?=
 =?us-ascii?Q?cOTh5727uk21n7tLyMkZttC+kKWSVTuNKWpzUo4UHAnKlz7vZcbtyJXsOm6q?=
 =?us-ascii?Q?2Ruyx+chmfQHRIQQWoOgGAOo28+NKreXpxQFOR2q6XYj6UvRkJFYgkstrbPS?=
 =?us-ascii?Q?dNwQfoDWh1sSgy4HqId6WeItroE//IzMyXo0AmyY7yofDP8rA+SX+9B9innU?=
 =?us-ascii?Q?cPA6G29YPaJGqUc34bOJw1lZ7629e7NfwKak8ANE455uAmNRXCZRTo7haXyG?=
 =?us-ascii?Q?6POOzAxvQMO5Qa3OQZ+QRe7ycu/3ZssClIbGRLitvtm/+PEYE3E0SQID6IHe?=
 =?us-ascii?Q?EVPQQg2nt8+HXT42TFaHFn8NwfkxfRxAUheWp1wfevsC6OQP6AnzyC4wu7Rb?=
 =?us-ascii?Q?d5Uj4uTUw9UG2zCDslZOGlfWH8UnvZ1aIOkdc92nXX+NqAMnRmMcqn8Q49Ix?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488cbb3c-7d89-4e28-4728-08dc233a77d1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:28:40.5998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELJ7HtDCw26rz1HWu0ezlgCO4xNAkGSnw36A3/g+UkVM0UNVAotFuvA5wWrEf0MADaSeeM/vMjLSohBuekW0x0ffjJ/DdSHDhrE6XwWjbxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Fix a wrongful set of user data with endpoint pat for the local PAC.
Local pac user data is set endpoint_init_pac form media.c
with the media_endpoint

---
 profiles/audio/bap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 7faa6be7f..209f21471 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1195,8 +1195,6 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	 */
 	if (rpac)
 		bt_bap_pac_set_user_data(rpac, ep->path);
-	else
-		bt_bap_pac_set_user_data(lpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
 
-- 
2.39.2

