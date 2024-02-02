Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980DE77654
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883047; cv=fail; b=djavFBihrgX1W935/k+4iY+B5/e+VoFBppJeyLVb5WRmJGjcdZkOOt0mBNe6nRIydSg52o5UE83kstU+YwBxiBKKzAjH9RTj0hqWU0zlMW0/n21IV7n/FLiI4vgqvSXTarEmjC437I1au8QSvV+12ZxwQDTU1geIH/rYOZjD5Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883047; c=relaxed/simple;
	bh=9VH1ZZ0zfipd6Xcl5teHhE9OhWwM4a46z4l6qOCrT50=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=B/G4ypf3xOc9aTENo7fbabfKezDctic8z/oXNIJWDUobr5qwxS26oPbYa3j6YrwQnZCHd0IG5LHSB2G/9rL+9rn4FUqdp7iZ/3iBKiw6eP/2qCcJOwQk3S9Gwzf2VZjTUkTPoH/hWQmE8JNka+NW3BSaK9APEfA6Pf7mXm4zgHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J8CaIRLG; arc=fail smtp.client-ip=40.107.7.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J8CaIRLG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RutD5KNSlOjxhzYtX81rE8sDyeepRIf4Z8sWb4HKSSgUBXXIQ4GqMRRZSBSKE/lGDMMAupLL+qY5fXhlZwXzGOrzTTxjfh8yQsJwBrnvfw5iMQ75HJ21qZvBs6pasjgXySSKwSisb+spSxvVUe8XAbPmS/oCbXEMNBX9gJjh9lW32yOOeTF1jGRwHKoBQXIDGl/Xezzh6Tod3t3H9kxyLt9TB2WKJZJ4q/ykxVvxUhHgDVJ+D9vKt2RIjcVdzhvK4t9TF78Bhct1SCgE2tijkOzyDUprBogVCI1Y13mwQvXvxStnsY5SQvwjFFU+HE7++LC1+dAND1gg3OjOTJpa4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtoWKFSw7eGqvihCz8zjgOBwBFIbLR89pyGWgOhbtwA=;
 b=eYE+c3FDRqsET6FkovQP+KdlXudVY90t2o+NM/UKnuNqOpUleUybkqcXP0zslu6bHa5EVHzCeMLvV+bgBWRRW05THqo5PwCBBslqRM2VxvxZr5mTqEabVtyGeLkVZMw0cwSw2eqbzlYIRvOFS9OzHx8xu2c2+1EhSuvfNtRnPtlpNGatv+wBpGFT8avD8cXV3sDHIfa8JMV/2ZLEuG4Y/EyCCkTr+qtIV7tO0WZqqasylDFVqFbA9sHMy3IE8i5vCa/Ts9jKX8XGlHtoeR+TyZFf8QaMULAmigrqCID7QumN9KqH1SM6dLYD4PW0vGoB/BfrZYmfQA4kN0GfNwcQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtoWKFSw7eGqvihCz8zjgOBwBFIbLR89pyGWgOhbtwA=;
 b=J8CaIRLGEcC2u+bq/NAKNLUm9mPHwC7//W8zCITlkB1y5KhpTEA0XcFgmegpBODtTZVr9jwxdTOsIsnTBX83OaTKDIft2ltdBhNHFo5TXcfMvTG/BwQNjUpi/E+aWdUDtHnmqcRfL2HvC70gJv28T9sFtJlj3bPoApUVEzHPwlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7999.eurprd04.prod.outlook.com (2603:10a6:102:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:10:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:10:42 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] BAP fixes
Date: Fri,  2 Feb 2024 16:10:33 +0200
Message-Id: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d15b58b-5255-48e6-e819-08dc23f8bde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pEq52QqMNJe5ji016qlRhlpKtmjfRaWixG5cyjq4+UmDoZ/gsPSbU9Dd/4eFvuBKdCH9cwK0tK2CMiCTVkj1c4//DLnt9KP6KPULrIdtamlrwzcOLy59I6BTHw7aErgZ/kT5n/op5TgoZkA6pCpet/a+H3SFG/sJA49JTGVsCF4f9jhea+z83FBw4Eu674pSJa1fLzv7OSAcVtAMCGmq4XyWCrdOtMFuwRL/Y2eqhA6LLkywUjydvdldWtxJ3gR/1HjfGiEu7tE00WeWjCYSJfvyrFgyjRrPOFa7M6Tm0UG6vv6L8K6W9O7L1ayIT809o3eWAAwMuDq68dSe66O88q4HffFmAjblK9WCKk/bwozy6RHtlLc2haEo9B5aIvg5GIPHqgakadaVHil9B+wBTvf7c2AN+lfA2G+z5ENWb91/aGikC1GxtUxet5jqGFBAMuNuNetocUIu1kN4aeFtbHCMI63ZvTzmFAldW3WorYLF3PLQtYn3Xa9PBclpiNpw0yv6SkTLRLKkqPYiv/g1S3Ji9LIQv/99J11PUeSNYXHWEqIUVPcCiqQsGctwoqlC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(1076003)(2616005)(6512007)(26005)(38100700002)(44832011)(5660300002)(4744005)(4326008)(8936002)(8676002)(66556008)(2906002)(478600001)(6506007)(6486002)(6666004)(66476007)(6916009)(316002)(66946007)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MbzSJElH37QJcgy6yptPidzIvzLwJXQRQua8+VUUJvTBCNXcMNhb5VvvXX2e?=
 =?us-ascii?Q?jOG3cvcEh3HOv8zQe3Wfm6pcRsdaiuyFo/jFYLbZD1KNUG6fdyqekd2m+AAd?=
 =?us-ascii?Q?yAFN8w0ugYY2idVy7WrjrV0gHr2ZNuCgEqCtlTpbds7gLmPVPc39DSrhtn36?=
 =?us-ascii?Q?w6B1rDDz052YlvoPaeD57P1/kALg9Bme5qL4mbnFJ+16TgT4/q6QGiScjjcu?=
 =?us-ascii?Q?Idkrn/K4sHIQlNgJTqsz7U4Ulx0Ox27liCmDOTbuYSizogzv276lgfuyoUGA?=
 =?us-ascii?Q?gWXox2keyoodnQaoxjANhYkS6t3JtcJukirBnA+8XI7YEIGFzXNEF08maRI8?=
 =?us-ascii?Q?8ji4QYiZWnTxmXyX7gEyDtBj+QryLyYMro1qBdEYJbniyPdHkGLQHZqgiY5V?=
 =?us-ascii?Q?N/sm8WaPgorzlLoQvyRQMMagQWmbMDruYeBdNmJMRhJcdFkhgxVCyOmFi/8D?=
 =?us-ascii?Q?yPqWFEL6hWVZHG+ugJuTouZs+u9QRGeYwV3DYwpLNw89UNqBCaWUT6K21qwn?=
 =?us-ascii?Q?EljL3vAtGfGiKiMyZ6QtGzkSGhPnDt81rv6TJtlzGUxpOfM8rFlswWuJWVu6?=
 =?us-ascii?Q?xmo/DzYh2bfSiB8MvnLlBQtDHk9G0ItpjNrFhocjQf4Fad37K7VwOpvxHrei?=
 =?us-ascii?Q?ztnjx515cm/Z1AfmoiYQ8HKhcS8pgLkl8Fo7xfERuOJiec2Dzcn6Ofkc3KO6?=
 =?us-ascii?Q?M0WD0RFx63Nj7xqKV+tKBQV7R2p0HZBtB7ftbnoWIo+mE/TWJ7ZOVO0M939T?=
 =?us-ascii?Q?ko6YUj4HipcbCjO+vBQCQVope6RCxRe31CU1ICFBci96/ATVzfR2WwqEwz/n?=
 =?us-ascii?Q?ESiV+R+k2rnYtJ4mlVxpmucy4nEsJHygBmGlo1znxtN8x5yutMzGxhuEYSlq?=
 =?us-ascii?Q?7QtcfYmjR6ELjRXb8yRsJBQPEo/15VhuX5b7x6rYOmjQbw4Z6CiFphZGsDqb?=
 =?us-ascii?Q?+zxzrjlhqIKj4n1t/FXK2Ti2ag97r/M+W/fbpnqa1IJGoN0FjhhY5Bw3HoxP?=
 =?us-ascii?Q?hZZQni8n0hM+9mKSs1EkiZoh9LtgS0ezCkA20ijoTxPgxAwfcc1m1a+yiK3S?=
 =?us-ascii?Q?6h+PHUDpXjWfX2fPb6sgz/BnAyzG44MsecjJpF86ez66oI0EoFLsyt6M64WL?=
 =?us-ascii?Q?WLrqRUn0U2KNr88Yooopp7801rg/Zs61zhPMDU/h19VGX07ycO+T+MMiUOgc?=
 =?us-ascii?Q?QPCf+20vtuTBXLqfm7E5DdMFE3LSastFtl2yZSM1PgaHAQNEgcb1dpqXfRwd?=
 =?us-ascii?Q?K+MEcr+Rd1S0nCLna48vZ1ajS/XM4gmVV9CST/RM2pMg0VABizpOdxtzQTk1?=
 =?us-ascii?Q?vTM/h2vb4jTnB/aTLTwHqOGVGZNu0UkdR9nXaB04w2cI6WAtWkvbO6Ppjy9p?=
 =?us-ascii?Q?9NiN0RTD44mMT4CinEO+f/PZKdHVYPaR1QaNv+6WYHfzlPGbNEvahH9QyBZx?=
 =?us-ascii?Q?47HcnrWHSJzH0X3GsFawNCB2e5/pY1lm381/dSTIW2OBh2JM87PYj3o0EiRn?=
 =?us-ascii?Q?x2LfoCE00rZXPLmg0A+ZWF67B2PiL4tV4jgbBfgWVnY4S56iHvMG7FuoSc0W?=
 =?us-ascii?Q?HrQN6m+5Xw5lqO4JgS3FUl7JKR4p7qD+kdtKkLsn5vpR1aydIVLRtbVk1iTV?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d15b58b-5255-48e6-e819-08dc23f8bde4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:10:42.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pK6jMD1mb72V8kRQ76RN3nKWo43CWHZRnkGd0muDL2KkT0UdvYoPcrvZM56Hf0Lm2omgCHEu6B+C+7NWxiovkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7999

This patch fixes crashes at Broadcast Sink cleanup.

I reproduced the crashes with the following setup:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06

[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/ pac_bcast0

[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0 /local/endpoint/ep0
16_2_1
[NEW] Transport /org/bluez/hci12/dev_XX_XX_XX_XX_XX_XX/pac_bcast0/fd0
...
[CHG] Transport /org/bluez/hci12/dev_XX_XX_XX_XX_XX_XX/pac_bcast0/fd0
State: active

[bluetooth]# scan off

Iulia Tanasescu (3):
  shared/bap: Properly cleanup bap remote endpoints
  bap: Fix incorrect parsing of caps and meta in parse_base
  bap: Remove incorrect assignment of listen io

 profiles/audio/bap.c | 41 +++++++++++++++++++++++++----------------
 src/shared/bap.c     | 12 +++++++++++-
 2 files changed, 36 insertions(+), 17 deletions(-)


base-commit: a692cc44dc8735b9303f8893f784306b4d2654fe
-- 
2.39.2

