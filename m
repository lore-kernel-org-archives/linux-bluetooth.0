Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011024.outbound.protection.outlook.com [52.101.65.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4181D12EB
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252210; cv=fail; b=O/48l60mDt8ICnhES7HlBLV0l8BzsKsikJXud9NeUBo7GoA2E4pkTBOIPov9gSbZgZwSKGqaIjqiGl1kSHd7Pd+Uo9qDGS7kqr+rO9NvYS+019OqUWam8xxwpjfWdB1CKC7LTgzaUwJQhjVEGn1qqHoLdDNBEEwnpedZbl4fDxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252210; c=relaxed/simple;
	bh=IC1oWMCYEocMFeyC9UVvz0B9LLezz87vOOSKz+83drE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=su6qAgTb4vIUVUnEHrsIKEBmAzbQBhy+f4A/uXl5M05dQ0SGMIqa0hqZJtNbwfoTToLel2/haiFlI2AK2LI3YODvsDbNEXr2aLSB9KSJ5M23hSyMi/arIkIkDiQYe5qK//XiL8fLRWbDwq01GBEG38blkmIbjc5qShQ8Ipee8kM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bNVRSVK8; arc=fail smtp.client-ip=52.101.65.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bNVRSVK8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFoVGRBet9hJy9SLfBVwMOvj9Uc3gEpa5bfSancXE/Krq2govhmeTgS7pkdtPjbaskbV598KrNaOwFs9aCJNoIUSCzjxv1sEq4zW5zVdZhJSJrmjfNxgmguRmgdG3Vk1DNOiTfSQnk8B6oMIfQLaFamWCAByoFtTWUiG5mrH/dJa4pUt+d8TPdNp6cUyeptXeYGQ401/zztwVQD5QYqsJyHCJG7316Tnw6xKZSqF/7FI31hv4N0jzM3wh0zZAuDr/64rADa7S/Kk8gxfaoCSyVxB19NpIsi+GS1XYJyD8+QrCRu99UYvH4E09kffiMjyojxb6lKXgq2d2Q9cK6wQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7P4ED93GOtTYJowAKOm/VNEvBpUJqYc0Dqp2K3/VEU=;
 b=idmPawdPsH+wz3Howuf2/aptf2WPmhk0gOO58R+73GIcRh6R9gr+Np8NzvlQhyVYPWz1+/RmLAlS+2F+EPCd9TYNTx6bFG5BVLMQstIVTA+i2uYxPdCJE/ScqRR3ybKOlo/z5a1jp2Jfqv8GAclj7yNLElnLooRFUIbIw5MlWXELvlMojghTXyE+10z5Xq/dooHdeZSYZgYPAFfsNcj1cvvvHrXNQ2/JFtFN/c7yf68zinTTE8/TjDwBxhXTEW6XNPvIrZeP8zgNkOdWqVbYb1JPCV09OtqSgxIuAT44pxBGIzeT3eT1+emOFW7e2bU1DQd9acfdIu8/EH5+bQWYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7P4ED93GOtTYJowAKOm/VNEvBpUJqYc0Dqp2K3/VEU=;
 b=bNVRSVK8yvdA558YlNeHAmXwYljIoAv3GS3t7EpKNDpf/0rE2OY12/NztG5h8ZTNcwts6qIv2mMgI0Pq5gxmRrkiyKpyjW2wiJUuvkloBvKCMvKsRQd3iiwak6DfyeerN/C7GkkHf3zC4DGKWus8T+DOJAHZN9VoQRrfBMz+OH3AdjKMyJ9LiJBByaPTpofBujIaOEPAWbx5R3ZOJ3vwLVnZJGyHPK+KdwcY0OCHpGBlvCwkvDcb0SwxFDhlyFdCgA+diHjOmNa12UBYsq2C1bZ3TXDvc0ybTGy4yYNu40P9cXEVtwqbjsZ8oUgL0o94pi0HxLNUEFXfJor23Rf0FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 14:56:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 11/14] bass: Register BAP state changed cb
Date: Wed, 21 Aug 2024 17:55:59 +0300
Message-Id: <20240821145602.92083-12-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 98073ec7-5b31-47d3-c60a-08dcc1f179d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xNJY04kDaaitWeZrDHvS9zoB9PlVbVxeYbHMSu0n5ZUHzIdLKiQvEAxj9+V0?=
 =?us-ascii?Q?tCIOrJcdL/4QZf4eJBl4iWawi245rhPZ5UDgCmKTdBZZJ99364XxlrLbr90w?=
 =?us-ascii?Q?H3VnQDAsdCLqJYhqzkZ1FNKMM8GfT1kRUN+2WFXLLInFqDwu/0KeL0/KWGsp?=
 =?us-ascii?Q?uIiBmCcrxz/YHrLRpyf+1zcLs3ir1NOBMgcD1pg2IJBePZib9tyYf0SWPbpu?=
 =?us-ascii?Q?5u5I7+gNuhCSTNfTBlCftq/f0CK9qaoI3JKcpgGqZejodN0CnuHHIYGIodvA?=
 =?us-ascii?Q?D7SXLkGOIF8dDMZ/ZwVt76rOuPBN16T6CqAWGfLpbzlbsYkac5eoDBiZItfZ?=
 =?us-ascii?Q?44rSBV0zDdkas3R6dd2qSoks+rkZspswYhUvAhTVQh06FuFqp+t+OJLQVEG6?=
 =?us-ascii?Q?QiqvwgohBZVj9qeyaaAC7mKg8ru0uCyUNxsMCd+IqRi9xDEt+ca7ZuQBX+ZF?=
 =?us-ascii?Q?oyqDOh55o2IR5YVvL3x3iWAQnaIRAMU2oCHFmqd0SQrdfWRzUhRVAXWCSMgB?=
 =?us-ascii?Q?DSoYhPvBqBaRnHdue/2P3dFUup19v+f+Bg/4aJ9pGYYUcPXYkIBFOvFVBTkf?=
 =?us-ascii?Q?6g2oscAaIxFAuXYFZ2za0IOK7fArwc0bWGXkG/13twvyZdKlp/MML96LE/vv?=
 =?us-ascii?Q?WI6lR/ZB60GOqktAABx1OzDWL0HX+zHrsYFbqhyVmG+xN0Qz3tadms9IDVqG?=
 =?us-ascii?Q?X8MAwvnRQGXze6dLgFMl042DrPpIvcbcCSRkqguGZ7t5ZcQ8gx36yyc6tdUZ?=
 =?us-ascii?Q?z4fEMNyyeau06nLZiBY016OVYojt+8KuPf16cQzAab4wDZswViGSHzeuO7RC?=
 =?us-ascii?Q?f7M4u0Sd1T7FRxINaB/lIzmAgYiiiVQTep4351/15J2CxOtONpoCtGWppq0f?=
 =?us-ascii?Q?sl1Pib5Q7JXVydXz7kag93WHN1GcS99uuGbVT8EV/31hXa38meLcRtNNvXPJ?=
 =?us-ascii?Q?QFCjoNmd/23RnUHtG+x3jxzzYjTb7r2DCzp/Ww+Hs3Q7MNVPDccIExwggaZk?=
 =?us-ascii?Q?ovpd02i73kU2l8otRjVcUc6YYojtbC1k8A/NF1yGAtHWEeU53dh/DePiU7+l?=
 =?us-ascii?Q?xxuzW+XsjOtXDSOMttcsoce+e4MPQmWNTFTNiyNuF4rYf4/3Dztfr1CcYGW+?=
 =?us-ascii?Q?4PIxgi3yvfG4mog/rDTgLjgzUPj48/fWbYtnPEa1qpQyMmD+a8agKkOxgBOV?=
 =?us-ascii?Q?jEQlNrh2/ulxcjuEhLoifDeaof9jqA5UY7LKZRV7R0bnJ/l4zh3W4FJCdpQF?=
 =?us-ascii?Q?qLLFYFeudVyR7++EduZsyUwoVRZiBbE3yFjp0gLrOs3a/bp2HHY01+1nnfIy?=
 =?us-ascii?Q?5DQdC/0k4BeTKeSHv61drMJ+DMSY+zVTNjFuvrCUwQRRnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wK+rHNXgfBqR5TnDd+h2ZAYH4QqhZ8xULPlUL3gswQy6MyX3TpqAnuaUjE+h?=
 =?us-ascii?Q?abF17OdI93XYoGnG6QokohtAbI9oOIOVt3BLDn0pJmz+bxzlmJybZwkJggUi?=
 =?us-ascii?Q?PCCMD55J4uUbV8nhXU64RbH0IwREdjFbP/gE9a+WGGTjCpHa9PjTUdj8lGcu?=
 =?us-ascii?Q?IiZyv5nvwFLXFitEqTT8YPaiBM1iqFqVFrQ3x4kFaGwWOjhtvUKQyqITZOzy?=
 =?us-ascii?Q?gtrqYgk9mdNBlvB69o2wjlFZ6u1KfNcjJ40laaj7DEiITm+1xddYKU9r7AaH?=
 =?us-ascii?Q?Gl5xiibaVhMmRs9PN92wbnId8uDRk0kL2Myz9eRiZTGPoWSiigCYs8z86DuI?=
 =?us-ascii?Q?i/H19ck3zQ4/KF/U12vIpjqdWKRMYfJN206enk6HFcl9fyTr1RJ7vkQKtsp9?=
 =?us-ascii?Q?HjrXhZgGieovbjy6sax0rIWo11m2XTO07wd9uYdoDxCf+77SPV/YzThz7ooV?=
 =?us-ascii?Q?oMwIFUzWcarGUlxkMD+uAP2cJQVLmsoIckfeMcclYTVR3/TvVhh8QhmeIiqL?=
 =?us-ascii?Q?x3eqp81yiWwZm1GrEjPihg9mRBaWNa2IXmn9L9Ou+9K+UuhOgpWplu+hXI1f?=
 =?us-ascii?Q?tPWheS/ncx4DHegazVscwRsXS8g5w7az3NX8K1dMFKkpQqFDUyFnWRm+ONEV?=
 =?us-ascii?Q?LflvXukY2+ue+nisW6InouG6fyn1jL0NiwB9jPyudovX/nz8aJ+xqz8EhRch?=
 =?us-ascii?Q?2o0ikMDNI3L8LgmCpGQm45Su2mfOS/xBaw56yzkFx+0CzZ+7azwgUoziC6/o?=
 =?us-ascii?Q?OqlQwJRkIQ6I2PvuzC8NsCXHNNC89xjPqH14XdgVATFR03sKeKWaib/PEt9c?=
 =?us-ascii?Q?Uz+VrxT7kZQIGxaxwLwqoyN8anDabHD/paOlIswNZUeE1BShb+4FQ4kzugnm?=
 =?us-ascii?Q?eyaggPH/r84ROrbsG93k2tEb/JCoDDxiE3QugbGuVUSruo3OB8af9VNqTLxn?=
 =?us-ascii?Q?ziX1dJ5ZCdAo2Kh42LgtdJtfuiuZQoprjI1feaov2OKP9F3GPAklvzbmMOa+?=
 =?us-ascii?Q?a3gOUmhOTNFJaPbhc4auyK0JjZgRs2Furt8LlipWKqtxMvlGnsEbt6RF+jrt?=
 =?us-ascii?Q?YHlt81K1aX0hFG0qu7QZwZV7HXYEpKcU/RWVYM6+0E0sOK1MNRuWv73ZyHCv?=
 =?us-ascii?Q?xqDyrOlrEXQrlY1i4vI7tOqyNuRGsjMR4v/xXGZQZ/v53OlrXLWi/BNuIMAE?=
 =?us-ascii?Q?6KBfQVHxMaEDugtZrKLlsi0vMqnLOUmQfSpSQSnqVsPJMX0+latnL+SbaUr+?=
 =?us-ascii?Q?1IiHehfJp21wudoJPYsPzFbopF1fP88Yq9ltkhPChyg+y/OJDFJB305JjxVq?=
 =?us-ascii?Q?S4yXQ90zcBpbZHuyHABxp7ZCah7UCp2OCP13kaMIYn1AVm/Un+p8aDuv/GO7?=
 =?us-ascii?Q?NF2+Q1OuXtJD5b8ZV66ngMwcRP0dju8Xh88kXrQWX2YzS2I1tBvI+GLLU1em?=
 =?us-ascii?Q?t73nlrcGTuQf0Y8ZDSvWThvDGn7fpM9/r2j2cvKe2Ntlxtul4wy5ACsBSgVF?=
 =?us-ascii?Q?ylBpA7j9Xrp213GraVoqtAye/bl0adPfsdVofTe3EIqabIKhscYFeD/Lvldh?=
 =?us-ascii?Q?KkARdZHP5S25cSHnueZdJjpL1ZvsL9Br/er8wO/rya1NRvU2OQOi/TPmnayM?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98073ec7-5b31-47d3-c60a-08dcc1f179d7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:45.7206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esyqgptL5yGwWka2gVd5Q6WlpnzoOZx1TTYjWQDEEsDD/J4tIgS09wJ7KvQILHWNc01RUYmP1q0pmuqrYwuAvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753

This registers a BAP stream state changed callback inside BASS, to monitor
the state of BAP streams created by the Scan Delegator and to notify
the peer Broadcast Assistants about updates.

The bluetoothctl log below shows a Scan Delegator creating a media
transport for a BIS added by a Broadcast Assistant through the
Add Source operation. The transport is then acquired and then
released:

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

The btmon log below shows the Scan Delegator notifying the
peer each time the state of the stream changes:

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
---
 profiles/audio/bass.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 22e8d1c9b..47445b4b5 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -103,6 +103,7 @@ struct bass_delegator {
 	struct btd_device *device;	/* Broadcast source device */
 	struct bt_bcast_src *src;
 	struct bt_bap *bap;
+	unsigned int state_id;
 };
 
 static struct queue *sessions;
@@ -124,6 +125,54 @@ static bool delegator_match_device(const void *data, const void *match_data)
 	return dg->device == device;
 }
 
+static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
+				uint8_t new_state, void *user_data)
+{
+	struct bass_delegator *dg = user_data;
+	int bis;
+	char *path = bt_bap_stream_get_user_data(stream);
+	struct bt_bap *bap = bt_bap_stream_get_session(stream);
+	const char *strbis;
+	int err;
+
+	if (dg->bap != bap)
+		return;
+
+	strbis = strstr(path, "/bis");
+	if (strbis == NULL) {
+		DBG("bis index cannot be found");
+		return;
+	}
+
+	err = sscanf(strbis, "/bis%d", &bis);
+	if (err < 0) {
+		DBG("sscanf error");
+		return;
+	}
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_STREAMING:
+		/* BAP stream was started. Mark BIS index as synced inside the
+		 * Broadcast Receive State characteristic and notify peers about
+		 * the update.
+		 */
+		bt_bass_set_bis_sync(dg->src, bis);
+		break;
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (old_state == BT_BAP_STREAM_STATE_STREAMING)
+			/* BAP stream was disabled. Clear BIS index from the
+			 * bitmask inside the Broadcast Receive State
+			 * characteristic and notify peers about the update.
+			 */
+			bt_bass_clear_bis_sync(dg->src, bis);
+		break;
+	}
+}
+
 bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
 {
 	struct bass_delegator *dg;
@@ -142,6 +191,12 @@ bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap)
 	if (bt_bass_set_pa_sync(dg->src, BT_BASS_SYNCHRONIZED_TO_PA))
 		DBG("Failed to update Broadcast Receive State characteristic");
 
+	/* Register BAP stream state changed callback, to keep up to
+	 * date with BIG/PA sync state.
+	 */
+	dg->state_id = bt_bap_state_register(bap, bap_state_changed,
+			NULL, dg, NULL);
+
 	return true;
 }
 
@@ -161,6 +216,9 @@ bool bass_bcast_remove(struct btd_device *device)
 	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
 		DBG("Failed to update Broadcast Receive State characteristic");
 
+	/* Unregister BAP stream state changed callback. */
+	bt_bap_state_unregister(dg->bap, dg->state_id);
+
 	free(dg);
 
 	return true;
-- 
2.39.2

