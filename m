Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96AF3C092
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751953; cv=fail; b=tE4oGKxn9vU3b3yfPdUxwYtU6SGnUy6YeUCMaXpuEYYqUHAFSdMXabg+3H5rAh4YywAyEvxqWkYopkB/LKx9l7nAvPU9LmLR75rgQ5EydeyOxiGv8LyUevJjMyvDFnlBRqO7bunB9GfvZB5GLFZ0p7nnC14CPMLBHUwpfQG8Bgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751953; c=relaxed/simple;
	bh=lTvzkHmay4ezFcGed9SwVOk9UoDF0/sLXZwak8s4cPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DBSyMSb3oDAwqtfJ1H9sPD29rNsy8mVT+x8ICKC0sDgIX4tqP/XNUNJtlvTkiK1AVuM46R9AZsqER0ltXwKnQraTwLunNNpF5cpX9Y3lT8qw+2nUa5DDVlDaULjBymUI9K/sWyYzdAIomH3wuFx6gzQlV3FP7IRrzrEkldpMT84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l832cEKY; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l832cEKY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8SzjZXBFemX2jywRsSwKSPJHC0vhemq6F5Xxaiw6yT4b0Gb/E9eYwt98T8RFK8+kwydt1zBaLA00f1qE0yR5q5EXyMl10vZFIhE6ZY1F/NnSTYy47MeTdhjIn1LFBC570RIAmcmoHJ6BI2UL8qcXNdb2bLmJoSzzno+nth2TjGQ1h6zoExhs/cj/zhdYKsFdwCpsvfn0jsDYDgZNrAx2DDxhrVf9coIOjeOwgY74Hl4j8/8LHutQZj05+UkSfsMMAnoY4YGYZ3Ww2U3WZWYkVo6OJWqflk5CUcMWWRpAzGsKoJF7QcRmWHHW7qfdXsCQoKQaFCliX9UoR2y2xe78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI01aqCMJjs5mzkKiS8NKIHgcatfVUO3Mb82+IgBiag=;
 b=lyA51wT0TUqZ95iwgtT2tDgZHEizV90MzSM2fgXrb3dJns/u8+gi0P5NnqQB07M3up62nYR1LwUbkGcuI+FsYFUVNicx/ca0XsLJBJ5mF0WHyCwNPUYWH30urQkDE86ToyRpkUz6pbep0PW2ZITEo1HOBB/3b2WILPUpSDak8ZXLY2tMrub4XQTpKgFWn9Em54t654FGAXNfW8CHrpWIPyI0krCGpv1VcbgQ0nfxzwDLUc4Rgm7vEo177njIOm/xQzU4ggZQwToBxMldhHhvY0igOm71uxu1Ch7d3vFl6B3ttUQ4YFjc5arp4MSkR7P2yXeIvT4kCmdIuHItC7F5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI01aqCMJjs5mzkKiS8NKIHgcatfVUO3Mb82+IgBiag=;
 b=l832cEKYAHtQNsdm3Blc4jN0DiXFU9u2wzKZsyYTNkr7e0MjJUuwOcdk0HcrtmAdsTWX1CAwLgF1smbJiu2oHPRQOSLWsgP3pT6AjJTNNEhE5ZzOAnUePv6ROsP253ZKl/c3x5vjjKXOD9Ju1d2XPBIfbrOV+kTKGfc23NxwYlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VE1PR04MB7439.eurprd04.prod.outlook.com (2603:10a6:800:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Mon, 12 Feb
 2024 15:32:28 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.025; Mon, 12 Feb 2024
 15:32:28 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 1/7] bap: Remove set lpac user data at bcast ep register
Date: Mon, 12 Feb 2024 17:32:16 +0200
Message-Id: <20240212153222.8191-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
References: <20240212153222.8191-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0030.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::17) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VE1PR04MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 07200f1e-6255-45bb-d48e-08dc2bdfd267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qkUtUuAUSz7Y3CqdBLpHBYP1SKBkCsCQ+M4dgwa2DkSRM/9Yerw9QMZHP9tCPdCHBlvYKwZ+YmMvf6dPbkgeeL3o8K7oDBiG1/SSAxr6lXPzurp/rxRVO+Ik+ng/1qSR8iMF+RPS21OR8ituKJ2TeAnJAJJTF4tzcD0qLJ936QACB1QRdyyfKCVwrbFKOl4OgrkNXHbHOvhfIjL8YIb3iqSpcX3GNxavrs7s9T3eoyaVBBZtb/WK6wKGX101C0/ZX9td0LX8Su+0W9Sa/wX5eP0Lc+vOL2UkkflV6qRN6/5DqNqveoiGtRJysgzOZDtygVSS6NAjXZvqXutvWq64R8ZzZCraskmkZmjTzzHjAIUuY+fbQ0vozULdM91g1yVw5mETck55vrQZeMB8VCOhR20Bzy0hKYEPCm5ADHbtRrqCVjjnJdqqQRftUpT8V14dlvVIhXsQZplEgLizduHtFCN5fv8SS32O/ZIje//BAEOBfwMwJ/rjoJVd6suiyBUCxXVhiO/e/jWocZ1lelDUqmB0aIGS0W2nF3k4sYnRnuSwuMdM2HCEHGEGHMrkhGxX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(478600001)(83380400001)(6666004)(2616005)(316002)(1076003)(2906002)(4744005)(6512007)(6916009)(26005)(66476007)(66556008)(4326008)(66946007)(8676002)(38100700002)(8936002)(36756003)(5660300002)(86362001)(6506007)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ULBcuJTokloAZ8I5c/LFAJehds0V9OyH4fN96nWPLEGg8WhS9YSvTk/vqTM?=
 =?us-ascii?Q?GRK2uTsztRlvZ8D5JzCzFlW9a8Yz1hV/PGSwt2/UqQnzIiDdmt47P100+AuJ?=
 =?us-ascii?Q?T757qEZYaepnjE3qd/U46zqtjnrDedA5Y9l9X+Ue34Q1jD0IoWGnhb8Abf4m?=
 =?us-ascii?Q?4Hoss/bDG/4JHK45O6TeVl3VWEjoZC0lfPoECjVO19SCa2QQjHp1gAuaohbZ?=
 =?us-ascii?Q?G5sCu8Y1pxdijJ5fUeOO2nKHRUh3NYqQofPsLKmM8qwmpV5LZbA/1jfsl4vw?=
 =?us-ascii?Q?ZjEYZQQQPRwZBHB+/anExxgeUOTbhFNLTmyzaCE11t/5soewmWS2KhCl/rix?=
 =?us-ascii?Q?A7FyPCOKMkQteGXbZZYpsM8KZz3Qk0hJshBkGTol0Nitbo/Mu3nAj7fUZjmZ?=
 =?us-ascii?Q?FQZMoSxzkXcEAkqUDj2h81aWejGEZKhRayC4iy0VZ+oBDpZx2BAqqzZeiJAO?=
 =?us-ascii?Q?J/3kwFiWDfCZx8+cnuKBQNXPBasPjdE19uBGqgTypkkFLgBfJw1SLw3fQwJV?=
 =?us-ascii?Q?19aHxe/jDTF+QWWYTzW7mPAvUrUauoTJlFhog1ae7pR1uuHeb36et4r8QIPK?=
 =?us-ascii?Q?TLihaEVXlldzlei2ReHqxKGQwXRgYS2bCCHZzyRuYTSbe6GxK02k5COEfseL?=
 =?us-ascii?Q?aT5ow/Pkxc4YOo/kdxXdzK8zC00Oolr+75fDXPo2I8Q5wRMwvK+suftQnQLu?=
 =?us-ascii?Q?g9dTdlMCKN2bP7f54gJZId9Ms1w+UYu31RFgsZavQ4z4V5eCSjYjov2xVhTd?=
 =?us-ascii?Q?nszho4YvQSXyWw1eMFWcPG2e1CpYm3eqPALoPXWrm9f3AA4R4vUgniVgq9Je?=
 =?us-ascii?Q?MYeh8Awezc4feikkU7P98dTrthkOWLiT4JV2pho7UkGPeKYePjBHK7eTnIJI?=
 =?us-ascii?Q?oWtmI7TBmBMajs1VFSeL+cGldr8CWA8DsSOyW8hCOtgu6TNqLGbbRpAknLaF?=
 =?us-ascii?Q?LTXyWWth1OXg9tuQkXMXsqdkFH3L2C1ciTb/m8AMo1PGQ0eS5p6nNQoMfWYt?=
 =?us-ascii?Q?lT4M2ESWAMH72bKvd+IxUkegHomaWlRt5iz/jRtyBC4y2QLeEG0JO5OH43VJ?=
 =?us-ascii?Q?ygclau1RuhRJeRJbq8HwKirlYIlCLr6m0dGL42lMI5+68s1ATijlCuiwFL4L?=
 =?us-ascii?Q?UBtIQNSgPR2knsWLnYM5rJM1rO/zce7D4uWQ1MyLvD3TOZ14SF4f+5s5LxRf?=
 =?us-ascii?Q?/+2TQXAhOKTFZVZmMyKfNdQlb5cjKWBlWGgGLonqhK0vqjUUF2dPbetsEx+2?=
 =?us-ascii?Q?g9WJCuabscyH9ghXZ5b092al3ZAs20r9cq7UFDHC/Cs3PSTouht7qGvaU36/?=
 =?us-ascii?Q?uHk+p0h+qKTTjF/cYDch+Yfk4vcex0ievDedTbZHfRwwq2nX5e95RwiuLAl9?=
 =?us-ascii?Q?GtdxMvmwyzJKoo5JZExhUq6NA394d+3//o6Hhb+0p3bl86iFbWMlHLEnWpCW?=
 =?us-ascii?Q?zOeERku3a/b3YCa8r8Xf0XBKTFVv8QrV3ZzS1LbZM32uYc0SuNLdaaqw7ZH5?=
 =?us-ascii?Q?3It7z0ZAmxzhjsJdVBzQvsj6zkDtntJ1ui+kBeRVMqztRq3t5ggsaxL8Vadc?=
 =?us-ascii?Q?dJspdPv7Ge50XvhpMDS2duwI3YxlOWEZJSxq5yXo3BbwK4q55gRoqMN6stKW?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07200f1e-6255-45bb-d48e-08dc2bdfd267
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:32:28.8561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7c9xvoCu3BkuYdby3n9GniTFQL9LTRHwQx5rQI9ATzUL43hozLwAZAHkyeWQ66q/qVmJKWJt5Tdr6+14WjhrmvWwhk1DxidVVpIVeYHf7hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7439

Remove set lpac user data at bcast ep register

---
 profiles/audio/bap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 88c93127b..38ee42894 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1207,8 +1207,6 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	 */
 	if (rpac)
 		bt_bap_pac_set_user_data(rpac, ep->path);
-	else
-		bt_bap_pac_set_user_data(lpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
 
-- 
2.39.2

