Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876CA2163B1
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705093; cv=fail; b=cPe6Zl8Wqc4kRFiEnfDEqdkp1qMSlSDrMQjnCCU4uzbqNSY9Xo2l7wgFyUmoOZfb5OuinJX3AKV9vhoeJZi3efHIH0i2GToMbDvRpFc1egFE72IPGN1bepjQ1Mo4B7lLSGIrmzeO4LlEPnd5ZCV9hZv8FxRxuCaiv4S+VXGokSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705093; c=relaxed/simple;
	bh=6bGbmdndhgMa1+5hKEOB7UMU+uuiLEsBUAlGMNej7eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXJ9y/RF2GM/s7KkcmHWjVsr1anFJ9qDuq2Navpx2Zww3O5LrGGox4CMa9IMCVFDGyxTWl6+kpMJwLS+cEQx31Expr3SSM12jAVElusmmS0FqmXR8z//eUSpXZcYuxrXUJqnpyHf4nDgDO3yDNUIV3LBp0m2pDyPrWPOq9Oyq28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jcHnWyH7; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jcHnWyH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn7NUd5Q/KT2TCc7GqIVK50o+8TFXdDLh1LI3Ee+VPINAwqIMjWBygTD4OfMB9RkSiDtrBn1rKJllOrnJEvsH8y8foTu6mP6ZgZl/wRwY+Uq/AcG6uDEONZIOgkfiZjWONcPhQCA8NwVOH99+E+q4sbnIFWvDbEFvvb5aX4mL1Rz3AEooPp8LnLPGk0b2Ev3x2fsTRDCvLcUayPBps1hUHz+zC/lvIokOPz3Z7J5fKQm+bfxkMOguBsf3ld69KOTP+mRDig5HW++IFT0qrm9ObdrQNW0tt5Ytlwdvdc9fJLfS2jZGfz+gHASVELLGVJenuFuKGqf4x5qkz51kXNtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxSdTcTz0+Jy0gniPUNOpiw56t0+B0r2odZhshetd7M=;
 b=gsIhI/GIS4K891f4LY48FI8UeX1tZZkWJft501OEJ9QpwVgQkbK4DviBKBjbOFuy+sHgzRuWMA58loyDOIAIAHGynQJmFl0ltfONHS1BmlTF9A5S8PwLf6VBblXQ1mPf1SZ97ipa+JT/OZdQbqxV+vO285oCbt8PuKd8BAUd9fc8HJZk1eu2sytrZSah3YpONuIopPy2Jmjdur/zgSR1zUFvAnWmietBWW3RyH7QXmxiT8NLzs4cipeTLIupLxu4DZbLIZjhj6S4npj6N4E2PztZxVey3Cm+Ez7/m8QXOKmUs5iC//fhaeAnlEYVA1mQ8oJkx5MaB0JwcfskhP5fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxSdTcTz0+Jy0gniPUNOpiw56t0+B0r2odZhshetd7M=;
 b=jcHnWyH77r9TfTchUcck8ILJMrerkamEtcpA1XMa+WRew8Xb/QP831v4Dk5sz4u76Ht1GucKCcb9TOQPQddMAWaOXgGfBWEUf3ewCrjQTOF7pBr6HwZ+3MWFXzFkXPPofH1ETvI2xQ+YBKu1IcLYs5dHmxf8iV1G075WeTd2rZ3ROZCRENoN4bBdvfA6OQ0io7o7beYnuQxjcACMeXlviJAMpVB5Z23+vjGAVganBYiZWBs0fm+zeJZKh2/pbOEhbB3juaqn6JFHy1Ohd8IhxaBAuY8R03sSc3Nqb9SEn6x2CRyitRWaLMDKNDiKLs/rN8gz6a3ntVS1xSQ3GErMpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 14:31:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:31:26 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/6] shared/bass: Add API to set sync state
Date: Fri, 20 Dec 2024 16:31:02 +0200
Message-ID: <20241220143106.27443-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
References: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0048.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 76278102-cfa8-40ed-6585-08dd2102fc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6WC/CiPl6oZ/qA/AgHW9kUdnau65frP+3cM+RznDh02IIS58kxmE9biwYlEo?=
 =?us-ascii?Q?rQ+Sa7u6+YY1g9qkB7U1Mv2bw9iKApynN4IzXcNkOa8lCCgntytKdXD19nNK?=
 =?us-ascii?Q?kigWXDtNCxaeKEg3T8JiWwf9mEZXAk0DAGpBmAd/uh6P5hvOHekJBvQmWJbE?=
 =?us-ascii?Q?OTNGlGVqyocstul+FpznzPK2xj6uOcVTUFstxVmtP5sv5yUXoV4BimiGZsaV?=
 =?us-ascii?Q?B741HpXPxhJiDJKazX9NqSbbc2ttE0sRPCry9Bu+CUTScVQPLdFjcJcNR1Ld?=
 =?us-ascii?Q?ANe5RRL7MOS8zz6q/b49NNRqjZ7+IVPfNM+WU/QBHh+J1HYuZsRVQjWJEn+6?=
 =?us-ascii?Q?3Lo6V5yhVsTlrrQA2CPzOPsuGAiIDW1MZ1Xg396p97zXVQgZUWfArS1SFyc2?=
 =?us-ascii?Q?ONkoI3uh8dvWVca6jIBZPzys1GyDnyGHaZ5vZr1RkRjw/aZ8lMpx5Nu0jf0Y?=
 =?us-ascii?Q?fPKUkwVqUC69PCzUoSzdufK0MisnHsF78JWKOjkClz7eJD3gHzJIHyc0m3/5?=
 =?us-ascii?Q?Wj8mxY37EcFeMu/5LNs82jYC90b00ZnnaB44VLcd9iZjLTgPWXKeXdkdio6a?=
 =?us-ascii?Q?zHpQw1EKJ7Hp8fWGHdhHKqw9g+VzjSxvBkb0Rh0fWoQ9RT2lp9ofB0CNosZD?=
 =?us-ascii?Q?2UbcArxMgttBMZM9EKX6agqGneF5cMZzGTHE/adZ5HqYT09CcLfssnFWjbks?=
 =?us-ascii?Q?ISCfaj7QisUYgXQM38g6WdQ1GayGU+3jUrZ8x40+Y6VDCyWhTcUgESGp9LcN?=
 =?us-ascii?Q?d9nZKB9DJgRWhoVHu9Dj6wJl6IcHiwGw9SgJctA/V8mS7f2tV0Wlct+M6uqT?=
 =?us-ascii?Q?Bdf80jCKdVoyy4HO4KpCh+G2LQTi24rgrtBii2WAQa1cfUj6KwrZnJNtEK4R?=
 =?us-ascii?Q?eqeFUsJhkL9zvbWQpkbf8e4W/j+JAxAWJgnmMA2TCuqMOW+oGzKPs0VELj1r?=
 =?us-ascii?Q?LjSenvR+qviiffXHQ2hF6pWN0OLNM8WAMqmTmAxkjzanJ4mmhgDd8oYZOjuj?=
 =?us-ascii?Q?NSV02nyZMWCNtFYmg59UDQlrTT+21a0sgwq8lAvfzK5qEwAsSvGWYV4V62h4?=
 =?us-ascii?Q?SHHNzbN1B9XLpt36s9SA9pqKBEySHgMJg0ffSPymLWr7dMOe3nY4xDKR81DQ?=
 =?us-ascii?Q?5PMBQllipKvqEDINcFy3CkXsOQ8NnqZ6sIb2gUhYWjoVEJJ7mNaWNcfRI0Dy?=
 =?us-ascii?Q?PVXz17OWbEpuNBWJphl2M5V5Ln0uR1m2ymTBZvIK3I7Pgpr0YiaPCr5zqlOU?=
 =?us-ascii?Q?cMsa+Ms9nm5UNrbXQ9EPnL2vLOozquNbd+5tCxygYUU8aK8Yg1xxiGlThJl2?=
 =?us-ascii?Q?BBOFD/qzDAhMd5vdXoD2+xYwjVYBfLFJg7+sa6XinsjKfotAtzJVKe8zfcCj?=
 =?us-ascii?Q?cSZWwENmZq6C5hI7MTXuRZkEyNND?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E/JaaV94vuVM4BNi3qNbkViTY7nTF85XkRbK0wmtZSyzHYRkBX9sDQnRRRuc?=
 =?us-ascii?Q?WyLPVNq5+AmZPsfXjhm4LuwOEQecB1Tf7O5n3mSs8ntW9L522sQ6AZ8xd0cU?=
 =?us-ascii?Q?jGaa0en4jVzIkucQZ0fHZ6+bFaPZdQax1bXpyAMYffpfT6MiBdpZe1Gq2rSS?=
 =?us-ascii?Q?G0W4zuCj18bMPcnpbfl7G2CBmixZSYD9Y2bUsDIwSQUtjhpzjNGQjLuEkLi8?=
 =?us-ascii?Q?fMYNHwDviiOd2f1H/a9FewCDTZErOfMM2yAr7PjOiNF+bJvWxVKjnyjcuQTY?=
 =?us-ascii?Q?48eib8KtD0lQVKnoVbalpc5PftBFdT7apQwTDuHS2Py3e48ROqV87x5GY2ab?=
 =?us-ascii?Q?lVh9ouBCLpX6iE2NQ0MJT5ops8rAehEuxBws2nxQ7J9YTLYX1YSdpDbtcyWB?=
 =?us-ascii?Q?uSug+ECYIcw+EBj+zzjUemHvwiev4Y/kEceVNv128a5c3PmIJY/Ua8JK6qs8?=
 =?us-ascii?Q?Ncogi51ah8pFaREkulbc9OrHngA0hyKQa4cN2xAdJyI9uEvHv9bNkMUOALwM?=
 =?us-ascii?Q?bNzE3U5M7aOxhshzZ2gEDJP5u11VvC66UdF9fceGddLFg0Xk+A1/lQ0qDpQ6?=
 =?us-ascii?Q?WA5Chr/ZrLpZQuH+HVS6J7PsW1ZmrIGmIW+FXURiQhgyNircOzo9npLCrQhb?=
 =?us-ascii?Q?bvNpV5SftZtpxVfdD91xn4hrdNboC/wCdbEJBckb7iPfPomhBNkFwQqShZfm?=
 =?us-ascii?Q?CUGm6n9zvplRbe2Dd2zYMS/BonQAFkMhjm7Civ7zvLFT2o/Db9ZHmPy0Wy6y?=
 =?us-ascii?Q?vu4AtLaQbh3eFbMKmcwEqL6I18HwNzYLOBKmjiAYvYIowg2wQ5bsRtxfA7c3?=
 =?us-ascii?Q?dr86mtaMMnrZ60wogeVa6csOCI06Zw572tZYigaiW/JqpGuopAv8h1OLlmiv?=
 =?us-ascii?Q?rEBL3HBZacBV6d2DSLy/YzyXfwvUpqVn4/77cws3GpCFQS9o0zJbfqsF/sbG?=
 =?us-ascii?Q?lKzk4AeRQ1MfctawZamIt9qcYASEhs0kwnu0hKGTmsdMUSuFsu9rlQMQ/+rv?=
 =?us-ascii?Q?0EJB2NYn8qnm0gMDSYGl9KbgCtl9YoqjJxcxlvk9QONJS3/66FGv9XkOOGi7?=
 =?us-ascii?Q?6UPoL13ANtmVtAk+0c5gPBVhkjp9iFd2YxnKF17s2SFsQxThWeK0b9PrdLed?=
 =?us-ascii?Q?PI8jEY+/db2wffiIqNAHM7NPWzCiEqAPkIeFy6uoSR5z7nj07Mfg1nM1cEIr?=
 =?us-ascii?Q?kGQyNebQDUGXWbgQI0fl8Y3p6k69lT33iuVTBYkYbzyRwK+QCGJp78aP+GaL?=
 =?us-ascii?Q?BBv0I/qsH5gzXMcL+LGIfq7Pwqe/V8b1DzwIlM2MGdEofdxntJoBSu7iQSu4?=
 =?us-ascii?Q?IEK0xLijGjxVsWhcJxufjAW9YjD+EC2pmrw4kKJ+yG4Pl07lwJNPyMlpLQmi?=
 =?us-ascii?Q?W7iNarsJN3ccbrjPQWoVLKHLwJOJPThOq03pa1yz08eum+9ZIurNo9W9Mh1/?=
 =?us-ascii?Q?99sRY8xrVotsUndH3oDymN2auX8i5gUakz0bBmx31hyW1/YFQFBsWA1IXeqJ?=
 =?us-ascii?Q?bT+tSDJgJsvK1bVsCRGPfRMEVZhw4NuuBKwHpcB2cCuFFeL/o/IZ7EegNhLx?=
 =?us-ascii?Q?jpYGFG0/fjHjUKkeUh6PrpgJscjmQC4HKdyfKbbBcJJYQ05tnG2cslXxsK7v?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76278102-cfa8-40ed-6585-08dd2102fc63
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:31:26.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELc2mXNZkdtAAWeoBessHal3DV0+DUqvnFNvFRigvijTNECYlrB8TSo9Jma4yOmylPNtN9PMcJl38+yL7CFbUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105

This adds an API to set the PA sync state of o Broadcast Receive State
characteristic.
---
 src/shared/bass.c | 10 ++++++++++
 src/shared/bass.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 1ab1a0a44..0651f9a40 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1781,6 +1781,16 @@ int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state)
 	return 0;
 }
 
+int bt_bass_get_pa_sync(struct bt_bcast_src *bcast_src, uint8_t *sync_state)
+{
+	if (!bcast_src)
+		return -EINVAL;
+
+	*sync_state = bcast_src->sync_state;
+
+	return 0;
+}
+
 int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
 {
 	struct iovec *iov;
diff --git a/src/shared/bass.h b/src/shared/bass.h
index d256b920d..f39ed7dad 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -130,6 +130,7 @@ unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
 bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
 				unsigned int id);
 int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state);
+int bt_bass_get_pa_sync(struct bt_bcast_src *bcast_src, uint8_t *sync_state);
 int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
 int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
 bool bt_bass_check_bis(struct bt_bcast_src *bcast_src, uint8_t bis);
-- 
2.43.0

