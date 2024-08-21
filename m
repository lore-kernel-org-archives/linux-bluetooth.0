Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8F1B2504
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252176; cv=fail; b=PFWE5AInXEnrjYBBRsoJBfXYCO2eA+FlHrF+rOkmoYaZUB6i9nAsofomI98w1q7TkPZt5RkbCYrDJKhVtrxjrSTzzzKmjVJAihJxQdlDkl5wXKYal96rjMqiV2jUkgig1sRsOHQBmPdcUyjelacu+XXxxB0havLCekQB1n4ZzVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252176; c=relaxed/simple;
	bh=ufPLe3sD6zPfkih9rSql6Owe7cEY4dzInVVUxmE/Thg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Hv8P4Hu+lGvFxU1HfIvcxCRUFSJ5XCWigqrZsi8LqMwXpFXyr+vtGMWKb7f3wnZqSQtLHxaFSmPtRCSWqy9OtOGfXj7gPyyy+rZj7O4FOu4CiLhbkjqVq705wKLVPC1ftOYLg5mGneCUO5ZLmiVpe/3n3DZDtzuIcSm810ZYC2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VJDWbFzy; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VJDWbFzy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DO6boIrzd4pwmgQhplAkj77lCo0bOyfQKp9K5/OXuZ1yHIlNyfB/50rbmXGO1FK13p5y9fKugGKjyg3HlWGMQ2CQFjKbTfmOD+FUEZwtEyi2/uTV9MRlQx6N8XXIkyMJCIa4wzRA5RTsfKcs4V3tb8pOXzaWrdujReBquQNBpqMcb4/07aC8DFYPChlQmmgbD0SPRuHp2PSWlQpzw/s3Ldpu7I1gP8XKCrAFWRhRHArsWEsp5XetFprSYppOxSAwhVwySape5Lz5elgKOYDjdQQW5GCF1sBLR+OVQyZKRomyaY49rIZnryQ+/JrVHMmKrIGdSLrBuHGCIu5diiTKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUe9EL3vfhB7Fl8ab43m1bRLqR0Glc5vg+no5vRg08U=;
 b=AgimscW4GH8+7QZo1qvq4g0zVqUqvU5XwUEd6mopitHw9fA4vJSMs25AsYwfwjGQh6XYl5k9ttcvIcTTpQ4YxRj30ujlQtiAR6OcA1zY9Ftpfkn6aHBIQkSpZP4VfcI/UqPnkzAjLtUvUTXpAVUivuCcTYnWs0aBKLR3GgbxuQkQbfstBeZfa7FQvrFdBlsVa9H/m6c1m+un+Owru9z8anjQ1Nx8OmfMJ+IdmzV8L6GwjP9SN04oljaQI9IH1YBPNKImJRxkNfukS4lQ6sGo/0VrlHkKntKjHpFIRLZxfWds2XzVXxo4IdtEvRsEqq5KQtIr+yawib5NEyycmOXMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUe9EL3vfhB7Fl8ab43m1bRLqR0Glc5vg+no5vRg08U=;
 b=VJDWbFzyNNJlWm8aDG/jyIerCRcOjyaqRwumyD4y8k7JWZC/WTHUoyP5a5Z3FMeh5/7OxYwqWCxC57TK8qk5cXmpUuvo/EhG9u5Vblz2LePHwNVQqU5Thx7UFbYa05mA1fbQ+s4DMRWhp/DYyY7F+auhGFU5APz2NxrQt/IhNT7dIAqsKS0Ba9N9YfB+z+CmPzyFTFy1Goi70gRnJRIkclg+iRWk/INKwjzujxbyQUzBxoV+rpjFc2deTZ1V341mbV2dHPcyLz7uSCzgpIQyKPJkZ0BoGMyZru3oT9ovwBxIzdqmn2D1nmkdo9RjHLQ+8XX/hx8EKXDeTHBzEPEaRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:11 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:11 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 00/14] Add Scan Delegator support for Add Source op
Date: Wed, 21 Aug 2024 17:55:48 +0300
Message-Id: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b2783dc-8b63-4775-2011-08dcc1f16564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l4qN10LU1yAUGYbwSxcTS5b+S6mLuNuY1tr9gn+rGh1NfdQ33tvgtBR171+N?=
 =?us-ascii?Q?cjG5k7U2riL4nwSiBdQidpSA26MSUJs+W0JJWFfSxMZwu1jrpJvV096dyI87?=
 =?us-ascii?Q?Baiu0ZdMC624PSyg3AH4s/uyzyTum+SzTxSFytkW79xy2dCSaiWAfr1zaNxi?=
 =?us-ascii?Q?klDS5+fdP+PTy27tkyMSI/xRJyPXHudFHHeSFfXivXngfvlSodpRG/Hm3XGh?=
 =?us-ascii?Q?oUWo3khQmRYX2AQNwCLAHftYADTvRyFA4WCXgx1F6z9SILdx2IAqwEJujdd6?=
 =?us-ascii?Q?Sr2GAw83/wrHxLqcGT2id5ux2YcuRMlYtYKAard8KtDM7Fq9EBRix2CXfQYE?=
 =?us-ascii?Q?1yTI0tjGhK4pz3OxwpyeZdCY1yUeKBYQFYCXWNtJ9fMv55eX9/ZAr/OsvAld?=
 =?us-ascii?Q?uBNAqJs6G9DTQztqqHSTcsNYI7zQGSDKm+hB9Y0Q80ZY4WV7NJg0Wbgkbnlw?=
 =?us-ascii?Q?VYZOHDxjUkRrLsVe9TvnyHn7vKIkVORJu7ldux9cy6CNghOaiF3GrucTCQgz?=
 =?us-ascii?Q?A5i9FTIdUcCUpdGkTDYqNG83WAzjXL+OiNbanGmx+fI2wxG74RNvzjJfCzkK?=
 =?us-ascii?Q?L02Pm0KirVfacyF7zeMNELIGXNk3BViVAqA2pmx/cbK8q4kFrZVRrUZpSV7B?=
 =?us-ascii?Q?jhT/GX7JcXEOxHR3ACDvh1XxdeJcZjjcxCUj7hZInP+5XOCIKEgBkZ0Wn1fb?=
 =?us-ascii?Q?9+WmswzNuJhfFuwAEThRub3FgXzcvVm4Pgsm0aEXzcyQoU+aM1xCL/yCNYv/?=
 =?us-ascii?Q?VzBMzjmvx6I4vwjhqRjhbwqI8PJJDxEQguPwO16R/pqrAJj46gO+Y0eznGpG?=
 =?us-ascii?Q?BJB/qSjJ64ojbq+eOF4iMUPLs8kY+ofU5ZnlpDEkI2ttG0a1i7SpAE5mWP+/?=
 =?us-ascii?Q?g9KZ4Sre5jYzO9plPlO6ovyTZE/CLALCa/FTjgLtWUDp3EA3goufiC4pTwIP?=
 =?us-ascii?Q?vd1+EQw/E/aCOgw4VY6TtI9debSovl0ppsWfb2EFfI7G2tADuMJtTXa1orG6?=
 =?us-ascii?Q?vK3DY8cc8Bw50PEYujbPcK1H2wcqEXfUK6avLyP2eqnijz2ium6VLP/fyWYs?=
 =?us-ascii?Q?8EVs2QwnHxLF7C0COBEKjT52pkWcVVuoN5jMIg8B+1RM5fOPshY1I3c3BnxQ?=
 =?us-ascii?Q?hb+7Qr7uQmixF/9Gxp4jYFOl9fzgtB1AQGTxWky1XssYZysrlc+H09xndw2E?=
 =?us-ascii?Q?FbD+BN6U2Nqav3e/gjY0etlSsxsbKBD/BAPOyEuLruHvVmvmFy0TMGIuCvjt?=
 =?us-ascii?Q?bHm/rTLObeAgkw0iOmmMkJt/eQeafcjkm/eoFilD7l12T0VcgxewTYSJjEMI?=
 =?us-ascii?Q?zXCWk6HMQzmdFQypZwV2diow5lwh1Z6i0z8w9RiHFxjbMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7bwxAZeOlR/QInduLANf9wlVl42kWPaevh8PcFxtwjWl/+/gNmqd5gqHhcVm?=
 =?us-ascii?Q?L3uWxN2mTbhvy+nFVWaR84cIbqWK12kUJD6aT+1UH/xCU5H1Vy6+HgO7HjmP?=
 =?us-ascii?Q?2He5S7HxdC58qTFhauEkllsGn7SYcRNGMUTT155U2nmQYljBkWbA2sKQWNcB?=
 =?us-ascii?Q?2lfyg7vUPwJxcZD6AxPAAsLoi4NdYVb6UC0/5ylaW8UY7AYJajPjMD2nL6js?=
 =?us-ascii?Q?4vMCMDOnKSspKBvgPjAW595r2qSNF0QP2X5Lhb/HqiOheP/cMtarrAxwdwMV?=
 =?us-ascii?Q?Ana2axrfm2yTQyIFV64lfJ5b+POrKWOel8cE3HLv7azUGyZ9B8DQKulZ7fef?=
 =?us-ascii?Q?mvXwNkkns9+Z1f/GPoiAmotzJkW0iNn5Rm/ze1kyJamnKwYJe4QFeikierE8?=
 =?us-ascii?Q?OqkHfm8r4mfUK4yKn3fQLd1hD7kLqndshrNBApuwiGDUUyL8MKercXAHlFX8?=
 =?us-ascii?Q?nERC8m6t0hZUEAXmwnY1GpdBCELLMvTEgLVGORUv5JnJwZgFJYgxwmm4rRR2?=
 =?us-ascii?Q?xxNlpnZ37ubrMqBIIvJM0XkbhuvWlUbsTqnSV/UCqFxhddI4v5w7tlff+oR7?=
 =?us-ascii?Q?aKcM+qR9A8sE5PDbxTCZeL+kI4g3RBRx7n9H/Z5Uv3HY0z7yiZ0aHM2YesR6?=
 =?us-ascii?Q?qQectdS45ZhVeAkySHKkgX1oA0z0ltJhbiyf21B5cHq1UUGDhsTV1dqJ42Tn?=
 =?us-ascii?Q?PWAmDKWXyTh6ZGXBxCXko8iIyoORMHjg+i3m1s08iZSx0WMwxHPwHprhDpyN?=
 =?us-ascii?Q?MkWcw/s7Pv522yesjpG8YhLIRumTwcR8J1a2WkAh16GTIWHlxvmS2c0fuhdb?=
 =?us-ascii?Q?XQhBQoHfDAlCtOWbSbjTXoDCUGVZ07OSJbt/JiPq+ZC2y/qSUHEyls2mnu2W?=
 =?us-ascii?Q?djqPmsNGl0BoKiu9R+xejkHWXAWjlppg9omX9OsZaP8IcO82Q1Rb8c36haiK?=
 =?us-ascii?Q?Rf5r+aDomOPb1QT+057YFY716LYKvvBO9IiWhgr6ugJilVCbGq71javed+7Z?=
 =?us-ascii?Q?RhNm2nqvSdeLjfd3+WVcrByS7tWUhIEGAn4bPW0bBt/LQBIRdphHO4Uret7k?=
 =?us-ascii?Q?kSAJ7CFgV8WCVtr/jIM5YCheaamqPDbNkb0xRPB4f6c30hDREHuhl3sK5g0I?=
 =?us-ascii?Q?8S9RIXayP+TmhOWZQHy+z/rsl7mKzW480Dy6n1GUWuFnISa5LMuJmb9mBaKA?=
 =?us-ascii?Q?heeaDJr1JLarFRU4NRdV6leb0+rYFcQ/ytJkW56sZrRmXfT68HroyUyjWWWO?=
 =?us-ascii?Q?5uow/jCWb8GufThdK4bDSsuY/hzm5tbfGDSEVGMtzxJwcUF+bnTSg7LyyyyQ?=
 =?us-ascii?Q?WOZC9iAsJRGmeainGwRkgRbIQlU+rvPLWRMgIlhhhliNQugBPOhWGtWMC72m?=
 =?us-ascii?Q?vapexgDZwwDMR6TBnmHXeqVlybatNZ42m1YwYRoPLnnn3/fQE4xWwwPsHF0N?=
 =?us-ascii?Q?DTVBJ+3u0SoP89kGaN8F9Lr/20T5qeIkcWPfJohO1oPMzVNzROlnuRKFUkRi?=
 =?us-ascii?Q?MKp/84sehmMNeL5X1dSoapH6vBvyw8qvkxW/4tvCof+/Zcnnh0U5ceCiTLk7?=
 =?us-ascii?Q?5C8xE9JO9A5tSzRFYlkI5S6FhpqErsYkXXr4hHUw73p5qmwywAAfO6tumbM4?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2783dc-8b63-4775-2011-08dcc1f16564
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:11.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qc8PvX3v3WXEpFAJaykaRzy0hz44sbG/PFjsWWpWLY5SvxHh2uh8zaFznwfcO1XjFzGXDj8HIWMwVEh5RiC9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

This adds support for the BAP Scan Delegator role to handle the
Add Source command received from a Broadcast Assistant.

The Broadcast Assistant informs a Scan Delegator about a Broadcaster
by sending a GATT write command for the BASS Broadcast Audio Scan
Control Point characteristic with the "Add Source" opcode. Using
the parameters received through GATT, the Scan Delegator creates
a device for the Broadcaster and adds the BCAA service UUID, so the
device will be probed by BAP as if the Delegator scanned the Broadcaster
autonomously. The BAP plugin will then perform PA sync and it will
create streams for each BIS required by the Assistant. The transports
can then be acquired/released, and the Assistant will be notified
about each change in the state of the streams.

The bluetoothctl and btmon logs below show an example of this scenario:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[00-60-37-31-7E-3F]# [NEW] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Endpoint: SetConfiguration
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Properties.Device:
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA
[00-60-37-31-7E-3F]# Auto Accepting...
[00-60-37-31-7E-3F]# transport.select
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: broadcasting
[00-60-37-31-7E-3F]# transport.acquire
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
auto acquiring...
Transport /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 acquiring
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 acquiring complete
[00-60-37-31-7E-3F]# Acquire successful: fd 8 MTU 40:0
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: active
[00-60-37-31-7E-3F]# transport.release
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Transport fd disconnected
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: idle
[00-60-37-31-7E-3F]# Release successful

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 0201da5711c0e203001a2d5602ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 03:E2:C0:11:57:DA
            Source_Adv_SID: 0
            Broadcast_ID: 0x562d1a
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044)
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x07
> HCI Event: LE Meta Event (0x3e) plen 42
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -64 dBm (0xc0)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x22
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left
              BIS #0:
              Index: 1
> HCI Event: LE Meta Event (0x3e) plen 20
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0000
        Number BIS: 1
        NSE: 3
        ISO Interval: 10.00 msec (0x0008)
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        SDU Interval: 10000 us (0x002710)
        Maximum SDU: 40
        PHY: LE 2M (0x02)
        Framing: Unframed (0x00)
        Encryption: 0x00
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 1
        BIS ID: 0x01
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00
> HCI Event: LE Meta Event (0x3e) plen 17
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 912 us (0x000390)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 10
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c)
        BIG Handle: 0x00
> HCI Event: Command Complete (0x0e) plen 5
      LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c) ncmd 1
        Status: Success (0x00)

Iulia Tanasescu (14):
  shared/bass: Register ATT disconnect cb
  shared/bass: Make bt_bcast_src private
  shared/bass: Remove io handling
  shared/bass: Add support to register cp handlers
  shared/bass: Call cp handler for the Add Source op
  bass: Register cp handler for Add Source cmd
  shared/bass: Add API to set PA sync state
  bass: Add APIs to probe/remove Broadcasters
  bap: Probe Broadcasters with BASS
  shared/bass: Add APIs to set/clear BIS sync bits
  bass: Register BAP state changed cb
  shared/bass: Add API to check BIS required for sync
  bass: Add API to check BIS required for sync
  bap: Create streams for required BISes

 profiles/audio/bap.c  | 137 +++++++---
 profiles/audio/bass.c | 204 +++++++++++++++
 profiles/audio/bass.h |   5 +
 src/shared/bass.c     | 587 +++++++++++++++++++-----------------------
 src/shared/bass.h     |  43 +---
 5 files changed, 594 insertions(+), 382 deletions(-)


base-commit: 2f3f63467d72a19b4414907a1ce5dbb870e4e2f2
-- 
2.39.2

