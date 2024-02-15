Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F08813B795
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032249; cv=fail; b=ZpE0Z7TDgpqqSU95FQmjwyjE5PUDFrOhspnDGdUm2/N6FfAr87E3B5Nl5C/gQVQlWRIqRxwQIZjbpXFJpmdlznYZ34cMwudS/UViJAE8WML3IXHGKQE35UQioom8KRcwJIXsdlvSftfd+LVBdoG0aexxAaUJZP4rfB0+COdwBBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032249; c=relaxed/simple;
	bh=lTvzkHmay4ezFcGed9SwVOk9UoDF0/sLXZwak8s4cPY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDPcKiauvvR9UUehh/VLUYMqMQA06nc1XJvIFlcMQHzwFGL40udBh5rovwRw/e2pKuy0xE7//yI1baH2n6II/VsVru7pVkDNfXXUhjB9+3SN3ktBc5xP1hAkZSEe38c/iKIHPvHlfIXXWRfrDcXT7TsXeVHCPNfbyQ6bfykr58Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cRcltspj; arc=fail smtp.client-ip=40.107.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cRcltspj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPmgIsa17s8zARsDz7pd3FKY8Qlpq5MX7Unxor7lx4mh9+Hbv/04jP2Pubwo4rmjcbtC56geQKOuSndIXbGCjp9z01dGp6DURQYaJ6wSkWWAlqmnW7TPd4EXUldQbKiZsQeCAlGWNb7h8xtRpZORHubFbxCdYAYCsnT7/0EEaJvYUQXWuNCvTthdJl0Ug5/1vkW6Ty1xYdMoP8AqlW3Sr2IDc6sk/mkILkj3q8CzqwaPE4KhwT6+tN64iN0zNackmDSk8+kHNh4AWSP1S2yMRaKuUPznbEWPBUaCIeaG6lPrfpqp9mFd3G89IFExcuM6I1KSlhlw0JqGYBnZ11xjqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nI01aqCMJjs5mzkKiS8NKIHgcatfVUO3Mb82+IgBiag=;
 b=TZiaTjo/UdnxZXqd0E5NmdrkbSkjQydi8uWG+cy1YUgOkNdpkMTEMOtiMX1NDXuhzZ6q9HT/zbQRVRzbO01ocnOTBLppvybU8YfrIPD6OAGnx1s9RMntzfFoGWNgoUJdV6hb1y8syTYn9ZDq04uQTES+aTpykcpmJ/4BFJGybMowgxElFJV58T+JxTd6Fex93Gfh0TxXb762NgxNTA8MqDQ+SIYpqNvt26TuzTbT+/2YGc0tZogSNl9/xwBQkLEwOJTjGCJpR+ljKevE71U5hVeBc8i8TdpFZ4HePQXQA9l5XlV+poilTWboOAVN0LR2wwy82gctmuMsSKGIvO3Zvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nI01aqCMJjs5mzkKiS8NKIHgcatfVUO3Mb82+IgBiag=;
 b=cRcltspjUYx3u2amZ7kFLk+RYocPhwz08fq+HuBUDltk6x98Nou97aq/gcByaoUXc10LyzzVhYV8mnieNH0mJzeY7W90D18kxd/m+gW7zte9eV3jMz+5k8aDb9uA19F331yBmzZB3xjiz8muDWTpes8b3rsEBu24Ze2gkn+7AuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 21:24:04 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:24:04 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 1/7] bap: Remove set lpac user data at bcast ep register
Date: Thu, 15 Feb 2024 23:23:50 +0200
Message-Id: <20240215212356.310301-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0029.eurprd03.prod.outlook.com
 (2603:10a6:208:14::42) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: d55a41c3-7982-429b-3223-08dc2e6c6f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oU6bcTYYjgoPuFTruILPM3qxRVhZyThd2PhE9/pnLcm6XRSzMxE7LTlXiOwlVewjp2yW6V+NMcfR1PjP8NfOcKYMeHKRkIvcx9p1gnE3o7PQcGGpAL2QDamM9YHjnJhA1RfxuKf433T2JT+JqnUmLdywH6HB2bdq/Z485eenXFZSDu/Ng7PCFbpPNwzfC7raLF6vXN30hsDjlMsi94VMOhyKA6LZDvBIYAssYrfAIiZrXgJpX6HfYR6vQGjvI7MYxyubLL6cPkk5WE7ZIDGX8niHVmv8xKR5JzTEZnXGofnCBZnLJ2wBcQp6A+fbKMhdjz/qrJzIU/FWypt/w4cdj21mlJI3dpK3tgR4iwbZ3IZuX5JfNGEXxostSrHYv58E5KJM07Hz9LecwJ9/OWRoen1mT82v11iP2E7+9SqjvqMynYwpzY+3mlnoP6PX+uaS0g5NeNqsHyxPJ5NmRwyHa5AqQ6JjHDMUwXKiKcadH6TgVhQItO9wrTx+tj79N7T8RC2Yef5ZTz9OiTrqxs8Vm5WeX2IaqHjG2zzLd5sMx22ynm6opkWouf6MtpPTMGsN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(316002)(66946007)(4744005)(2906002)(5660300002)(66556008)(4326008)(66476007)(86362001)(478600001)(41300700001)(8936002)(6916009)(8676002)(6512007)(6506007)(6486002)(26005)(1076003)(36756003)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5XPQtgJwA8R3sGW6UiySLaOhbJdh5cub97y1ec4P244j70pNy9ucExslp3CK?=
 =?us-ascii?Q?Bzid7FRb+py0mjMhn7Fo1cub5u/snj3L3z9k+qi5HAgZXzSlHE5ptyMG0KlB?=
 =?us-ascii?Q?M9c3/TGOZ22XdCh3KC71qPBqhEAz+7a5LkZ7XD1swq4Ljsp+4djvJkvCiMH2?=
 =?us-ascii?Q?Om2/K5BUU+0rnaEmbFfSirFkr0Z+irkVjOT3wrpg+i5m115tPJHCt/ZEC3Qk?=
 =?us-ascii?Q?novHoRq309psYPEkFgwhICh1R1aQ28Aq5I67Ogv/zF91zZT2BqThz9hKXOys?=
 =?us-ascii?Q?UUV7XA/HNGFpx+elrV7iR3RlvMl5xcR4bQ6WRb7Auf74CRDCdvm/nhjNbeAs?=
 =?us-ascii?Q?6q68V2ACZMl+5JWTzxhsbsci3Gv5zrkdVKHUHBRgKUyDEuBD/vqu2CTT9oe2?=
 =?us-ascii?Q?7UPoE3E9PYFevtQcF4sA1HPoRnuzpafPtAVp7vvxLDSsd1JuD8vEIGeMkwDZ?=
 =?us-ascii?Q?RHoDwlYM++U65SbnJFskcmPT/lAUcXKol0p3NB5aGp79f1FORIP6kACSMW2+?=
 =?us-ascii?Q?AgjlAU01lnlet6ohqS0wn05PgdijMAvdgJy9/ooHBE+7XCd92Z1zJkLHS/02?=
 =?us-ascii?Q?H44Dj/UTwzf1vl5RFENnx7fLCPlSHFv53pEONVq7n/aj2n794P9tSy3fw75/?=
 =?us-ascii?Q?4QV/juuC0PDDEfLHYbUEV4yIcCXKAvhWuKdFFAi6O38KFRCMF4OMyqlx2Sez?=
 =?us-ascii?Q?UHw/3DJhtiRO+GVKqGR86RSlK8DH7HIUfayhQrrShoYAnMq3z+EgXD2Cyfrw?=
 =?us-ascii?Q?K+NzMMTdpLC1aZ8SxgOtkyCPrkPHjG2EzEV9GholHD+/O9KbdRDzMhjXxfkO?=
 =?us-ascii?Q?OEUggjhy2rMoABrz4Ak7pr7ywm0GPEW3qgPVpFlkxg78Ib6UeBBhkqMzj6Q7?=
 =?us-ascii?Q?WroBFi9fdiIeHnHOTHIfrO8olB4928qi6LnakBYX+HfoQ9apT8uccPUiVbjZ?=
 =?us-ascii?Q?qh3kVIorq2kABKJ5Cb3I47v6RBRgPNSVw2zgSC2jexwz0h7FpobmVrFJQ08T?=
 =?us-ascii?Q?0reryYgWFfDmexayunyjvefdCLV0hvk8rbCUrXFKOypizcN+zraZEDOLL4wi?=
 =?us-ascii?Q?5wJI8jU8SWOXdjhBrRWNjkA01xOCb4FNW3YMApXQ4evpMzJD249ftBnU16fA?=
 =?us-ascii?Q?7Ls237ilGD01tKEJ8F6uJsrxB4dataUmuDi8k4uwZPaRSsfQciPuheW8f2vB?=
 =?us-ascii?Q?eI4SD1fINONlbwIlatmnHeoXNf0s+PXWavQzjo4Lt5zNPEzaaip6/YmyYNAN?=
 =?us-ascii?Q?evMybhx/56Qx/Y9ine23HlebcvTLCe3kgoFhvho8JfXBTn7hnNcN3kMl+kpo?=
 =?us-ascii?Q?dqoXcbDF3NYfO1AWP1tvOT40nPV5hooUgSDUp5m3RXjGNUEzVnTXByHpzmVu?=
 =?us-ascii?Q?BO+K6iOrTeXco4QLee13y1KAGmyEcLwNtu+hRzDnORg72ThDEmG3vlSCUdUq?=
 =?us-ascii?Q?x5QD2LqvF5XrbzHU/bl7iaMZSe/jF+nrpqMCyEXRAu2+uh2ZrWIH5tPX9Jb+?=
 =?us-ascii?Q?1HRzfbKJ7HpFc1X/wUqC4KZGTycdBc2DQhrfoWYvGVrOgqD+amKL8ieE7TCV?=
 =?us-ascii?Q?jAArT4wG03iehBictcl6IYbi+SB8C5NTOmnwfassA/dK1pFPuHrQGu/DFCit?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55a41c3-7982-429b-3223-08dc2e6c6f7b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:04.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGZ16uskdB4NklxdT7s0CvXNo6ePdTdwn+Qf8ta6/M8JkWIuHt808fkf3pLBjpXcTWPuxqXwCASlRyZuBL9f95x5/O/0CTMSTiB+faLsTgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128

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

