Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACE3130A50
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547395; cv=fail; b=jnYy/9Enm5UJwh/ah0vLLqTGEPvU2MTh6Q8xtMtoburP4X8XMK+QqRmLRm4ae4hPgYf2WYd9JkwJ1457bilcoOCWa13AFV/KaX8AzxaXzKS2HoEBUmqzvhgaLC6EeLLYjh7wvhinrOMkSCfwquqOgBzi5NqO6Bf7xfJgluQxJFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547395; c=relaxed/simple;
	bh=SCmJRJOuQ74wRHMPV2ZnCabATMCXEpfR6dsS8POKxjM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=utP/BuYY0h1LL+MYErmuG4SLpZRwewcv85U7KsxEQYlFmGmLX+YzT8YroHHJYuu5zC/yd+Fj65W1OkR9ZJ2ziHVorL2FPfJUI7ctA18uudQLYup+bnb40b2aaUkHVHWr9gEYxFPAxEpERGu+WIZW3t8Lh/nzhDJV4P6zx8qFByo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b4oGwOu5; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b4oGwOu5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkbXs0RWxmuC2LAAj5KcuXB26nqRwG3tu5KaoqIK09kdEpm4P2QOyfllSoga83jely2Ml+JJJ21IaAWKLa0uyZhE/D4Z1/gACP98xbYzVrF61+Y6sGdFNRhOHhy5LLhLFik7o8R2o2/6hrB9CrFM4tYaIncTRq8qCU9z1hS6a7H9yq1itMjbJw8tYcX51U8W/JJl7VkHLcRrhv68jD/1FhbdJTjVoq9ZdwooKxxxCqT60mi9vRCQxx+bbhI/FUJ1gA4DsbPke87SUc8aY0VEwK81lbO+nwT8T2KJq9vOkMzVLKq3NRbHTeN7kW6ZulfINahOlGEDTL7BsbaL5Vm8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HCQt9xyfhgbZr2yyrh0pF9ddeSrEUFSKfxaRp9uXDw=;
 b=SFfWlSPeb7peXRnPgquevryYtEmRIpCbsJgXPiVmxYMgDOWEaH6UbPlaikAtJCM5DppBF1si8rbe8RwHozef/MeeewqIQU1QHZQAk18ykPboEAteN4I2ik+9lRkEvVJGzj6drBRNNQUzyu9gHjD7pvnR8b7aX/kg55ccDPyK/84ynKY2oVHDPQlcH15Tk8EBn/L7xw/1HYaZ58TwdsCo7ZJy/408KmiKsIVFej0+cG8T/jPSrACLQVslK/g7/+i1MeLy7K6QeonzQ86+U71q46IphnP6uzi0qNKlDhRe/G1ZELGU93TEPf8DA6RQaT570PHkVDi0/OCjqfwe59KapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HCQt9xyfhgbZr2yyrh0pF9ddeSrEUFSKfxaRp9uXDw=;
 b=b4oGwOu5EM42seJRCOmEUpSWkkd5nydYkQCf1AFRFXD2Bz4oFhJntXS9qt2yDphRJDZiuWxlALUfkkNnVnSjT+U2wDWiBd6lPjR8y+96Roje7F8PZU36Umx5dwBIMsHxMsQzQANTgfF7bUcTR20WjkVvpGmRzBmF8qcl4eg4XlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PAWPR04MB9959.eurprd04.prod.outlook.com (2603:10a6:102:387::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 13:49:50 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 13:49:50 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Fix MediaEndpoint prop codec for bcast src endpoint
Date: Wed, 27 Mar 2024 15:49:46 +0200
Message-Id: <20240327134947.40229-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0082.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::16) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PAWPR04MB9959:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c649066-fa60-471e-1039-08dc4e64c5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4V83cJBk3FhbMhcNDBwQpYrtRhWMPr4t6HT1OrBxpHzCfM6p+2svUzTs5BuR46rBHbmS1RB9+8Jq9Ear6B8iCHAHtMvyLzcFoTNoDRZUtDiUkrYx8yqtLngYviVD8aCNCNEi1qbf+ReIb1ZlNU0w4ldgKYFfgf8s6e7e43dHvVbLGDPLuP+EoPFOUFPIx/OAMqhoEf0aL8dfH+65bQ2WzyzyVcYwPU1uRxFJ3cH6vTXtXwDEof9elk9sY0EYDB5zFT5Kd+XwS+Yh4nI7OZDB86R7qTSfUz1czmThkRJanCWF0d2Hg0WxhdZRHTWF+TjIfs8PeWmUNPo//HvG/LKA8LXgZZffhze1O0/UypyOxonGq/19WOoiqGEUzquWO/Pls3w5Veyn+rZIU5jfF8ZkqLwB2G0TXFsnUk7PzdYvyAUBaklaCCVK1FWcTtI2rZvBJSe4nGlHMcWWmkZAZDThYZbqetkZOGRE1ww87Jyrj6Wrvq5HdAKEBM9KrxstLe7hLlZW792cdKFwnYmyMwPWiaF41qd739VBSY7Buqyl+xXU839ZeTObZIjfGr8IsG/9MkPbt62Skn8OFi3a8ejPJ9HeqSpW1z0SvfxVqn6iA2hFulvz9ZULR3tQoBMDAIMtxq3TL9J2Fw5RLUEAtwXENg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UFcXJ/PbeU7/4OD0wKWalvLA6XU1tkat4GpodkoN2FvNH0HKg0fHwRYkHhVd?=
 =?us-ascii?Q?7qqplu5U4YKII/98Jq4HGta8PO5xlh4Mo1YtzGPYlMph0QQBnCHp4ntNuSwh?=
 =?us-ascii?Q?icwSZZ0z/OWOf8DCl+GorsObN3kxagnca2sxY9oXVoAsX/JIT+2l9MUNvMOi?=
 =?us-ascii?Q?5x2Mmhu+8lGkrao1rbRtR7ZwXdEUdCxVBaf/YVR3EwNHyK+on31fi6yfk7R4?=
 =?us-ascii?Q?n5x0DX6V3zFXuPPG10OArIOFSBs+iFLfR92Gt9H2jya1Nl1qTZkkyItI0XSS?=
 =?us-ascii?Q?NV8TvYO5RkzjECrNL2LuDFSK2ZCP31e29oM/4uoonIHnt77GRnyqnGDaacQ9?=
 =?us-ascii?Q?1LDx1lRifVzpb8Q5i6Tj8JgFDZ3HDc9747uUJfQDKGcK5nqnZelLxdH9EtbX?=
 =?us-ascii?Q?dr/2Jrx2x4r0aErBhgg+Jtjj2R9QVSKn25VG5qS13Grx4utWEX4HfNTaia3k?=
 =?us-ascii?Q?Gwd5Hf9VoeH0VNzXrLBFRJpp+zqTuSlttR56Erx+55q412syNlk+kRawkGfB?=
 =?us-ascii?Q?O3O4d6zD9AwuRE53XS5+/wof7sUgCqsQw5NVM4ZbmyoLTjrI/kgheap6rTSR?=
 =?us-ascii?Q?U2i7Hom3RiRkQLMpE0vR3UM7d2yBSKTkXas29SpHHeNt35dobi+TY4I2ndad?=
 =?us-ascii?Q?6xwiUJN1qTJoSbAVqmuLIEoubvXEIVptL/mZejy2Fga81kyMAX0Z6I0nIawG?=
 =?us-ascii?Q?jcqzxlumUpceLgmJNa6ySsJbednpAficT6RFWJ/sBaoMx4IbzVegKybhyjD5?=
 =?us-ascii?Q?dbbPBOUJBywHpqiRV7ctpE2qYiG8Mv8WUR9Pkkuoc/Snh5TOA8EeenhM86DZ?=
 =?us-ascii?Q?iYEYyB7jqBczfyUUFysUPKnjhkie4H3TgxQWcTovQk8wpK82izj1mHW5JYIj?=
 =?us-ascii?Q?uYrQAGL8gp2lw/PeMg24c3fWpvszEbmCG2rX0j365Yu8CO2yVC/2Gdo6xi0a?=
 =?us-ascii?Q?VeDDPziQQQ/3ygxTkwBIIVuC0xZDWNqSoSjWMgYJeLsg4QNEP8mPKP9Pw4nf?=
 =?us-ascii?Q?846ADXqVR1ujMBFgDU3MXFZgcIdDkQVhuXdiKR5DWEwdeXCM4eL+Nj+X5KyE?=
 =?us-ascii?Q?nVAHOutmvT8gGBsJVrnTbr3HSxvOOAUw6Zm01E7lAGgsq0qUMPhQbKaA+RwO?=
 =?us-ascii?Q?+Ju8KLbdexrwtq0K2Qd1P1TOrSKA44o81L096CU66PG3yn47IoU5j3nbx5Be?=
 =?us-ascii?Q?lV9nHRmC1snd4nKk52HeSzZaIaPfpCo3xkEcgDIDA6pcTFw2W2nOngtqLAwn?=
 =?us-ascii?Q?TZHzgIxn6PRIUn/VFAV7EGbkadG5XAcb/1FstRAi3MV4vw6pGgpVynmZrpHV?=
 =?us-ascii?Q?c/2oxoUtAGQR7fB0gHsPiylXl7+ToWHFbD9bNEVntq4Rr4QFVsVMtgFTX0tc?=
 =?us-ascii?Q?ERLJIb/r5DfTyLAFD+pZ1ffNdquLzReIifo0kUadjamdjK+STDsB/lYnxJDw?=
 =?us-ascii?Q?r6wrmGnxvBP6eRsAsnvhHqTBDX1TO0/YvZNowj2YgHlkmO6+ch9WgZJzwcQ5?=
 =?us-ascii?Q?+ozt0M9ShHNCzfk3hdJBrlltBJgAEOONEH5CvxXqOw2HFBnUH5cW9VZvbBuv?=
 =?us-ascii?Q?Pzem7mzc7o+bhWB0sEaovVQEp7DgDi3wrTC+HJX2ZDQZm+oGPsTPOUBX0NaI?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c649066-fa60-471e-1039-08dc4e64c5c5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:49:50.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z0yIkvMzTc/qI55USbAjMfvqKhzduKhdj3Z+uSaSamO90cPjJKid63tk1lBPF9hyrOPPBSW03KArdIQr57pKGa5yrEmNMuaerZh0XY4XDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9959

Fix MediaEndpoint prop codec returns 0 for bcast src endpoint

before:
gdbus introspect --system --dest org.bluez --object-path
 /org/bluez/hci0/pac_bcast0
node /org/bluez/hci0/pac_bcast0 {
  ......
  interface org.bluez.MediaEndpoint1 {
  ......
    properties:
      readonly s UUID = '00001851-0000-1000-8000-00805f9b34fb';
      readonly y Codec = 0x00;
  .......
  };
  .......
};

after:
gdbus introspect --system --dest org.bluez --object-path
 /org/bluez/hci0/pac_bcast0
node /org/bluez/hci0/pac_bcast0 {
  ......
  interface org.bluez.MediaEndpoint1 {
  ......
    properties:
      readonly s UUID = '00001851-0000-1000-8000-00805f9b34fb';
      readonly y Codec = 0x06;
  .......
  };
  .......
};

Silviu Florian Barbulescu (1):
  bap: Fix MediaEndpoint prop codec returns 0 for bcast src endpoint

 profiles/audio/bap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)


base-commit: 41d6c4e1c92fc6e0757b0f71ca5062671ff55235
-- 
2.39.2

