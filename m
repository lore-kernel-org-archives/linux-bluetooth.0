Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB701EC009
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374594; cv=fail; b=UnBrLIefZNSgE8IeBQIpulkew9unml8dFjPWyGad3/1DLmMCCnb8AxwlF3evpOOg+BT44I7g8PJKnIAaeixwWlxgD7zxs+bQ0sJX1i3X/uj80BgH6JLQn7I9hdR6QzOUSJgkFSm5t9GPiXjci4+TYvE8tGamKGRSq0qAIUsi/uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374594; c=relaxed/simple;
	bh=RUyi19NGnu5Qjw27bvdXpLu8ASEfs7JLSiJn6G0/x8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F+Opr6Cu1WgHUOrrdkrDcKZ+NaseFFEwYcCxkFYXW6W80DO9fdZ79Y54zqmFhMOTMQPiW40uDeEv9kW9pUaxg3oQ7O14YRx22DRhCzFE5nSFrscIhkLnCiMzViIQnHD/kj10VQSLQWsnLyxDC6BKfH7QK4ToEF+5mSocpkRUFqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f2aNgCKx; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f2aNgCKx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dhlzr346lCHsx2UQ349rqD4wJ/ggr1YtSoLBJsDWoBxnwZ0PDsqnq2Nmlyv34qlepntlRM7Yiiof+z1vGPgzsfiET8cr2e5yno8HHTI8hiTx5HfVWzyKGs0/CG1VKkucfXUvbqdpMHvJ03nBV4Jnh0rCTaLYEzO+VQ3iBfDDZnetiPKqpwtNT95OgvbDkYjqU5vPzI2YLCveuYF//rubRDUqR1TvRq86kvGjBCObOI2dslxgAME+v1mL1NhI5Iot0bJ0bkWkk6JFO8Bv+nh+7gTht2KdL2br/5tfde4tlHIwNktnaHlV8Bqx4TwNnZhW1J3q6iaC0qj102C1KznqAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEJhkRaP5FFu636AxbzzKERfllyO0lYpiH1M8urg1hY=;
 b=s2y5nEv7He9/SKxznypuAt2ox9TcPhzdneBc/vGzgKTU7ITKAp3XAfn74qBtKcWASi9obICRZm5Id9SvKu2UINrIrY6rKYbimzqv12Fo7zTJksh6dYP0ODfBdMY0mlqP99/JNgSfydTB+WUkt/GkTHFIwpi5oGnBrU8KQkxeKWeKGwIeJb8Nqd46sjPI3xiok2i9yATDmXr7ugJftWz3mqH62HsX7pibAsHUHwNJ6acU5kVcOvoNaws3LG46iNo4uKWCNQZRfQY6PcA00Hr2FCUSt/PoVjuxEnc2zivV+kU2CprJ1mlLAwWc37czJmtbWfUpc31QAFr0pGgQKp+beQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEJhkRaP5FFu636AxbzzKERfllyO0lYpiH1M8urg1hY=;
 b=f2aNgCKxYrxvXabxi2m8XVERR8i5upgh9KBhmks4fiHpqzWB6kPDLpl5/HejCGwbRIXuQeRs6UOhfnNJjZtkcf6TzHtu46d6JcoDGzJGBgf7BlPyer8Usgh0G3sna0Ha3BvETN3B3JRvvtvXnu8JQfTzaw+7B7yWy5D+L1N/cesHs5TdYTrrdG+1tLHDd2VAxkR/jDxxg80RIe1tAbV6dBGNETF6qe4gmZgTE9B9Pfam+g9A4Bpx2tkQzV7UGmoXDNcAju/ChoUTV/YBG45dKoQG0hLGnL2qtJNR8n/oDg2SXaCe6mHPR5uFZxP4JpGdK5HeNAe1sMpqKTben+uBsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 08:02:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:02:02 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 6/7] transport: Add support to request bcode from Assistant
Date: Tue,  8 Oct 2024 11:01:25 +0300
Message-ID: <20241008080126.48703-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
References: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PR3PR04MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e0f4a0-aafa-4801-49c2-08dce76f7dfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJ1kyAXMm00UnsD3JcK4EDAwp2TMiN5991+7Yo4jHF+tSUSgbce9MlMw6LW1?=
 =?us-ascii?Q?wm/ZtV+5MzWub0u9DVvNaG/W4/e5QfA1AYk8Aa18/BKGyF8sFxkHC7S6P6MJ?=
 =?us-ascii?Q?hFg4+/rjXAcvUkXi5kzr2ZBEZUx47p6aLLFftlnxghDLmD7sdFrQhZnapu1s?=
 =?us-ascii?Q?JNOriZZ0hx87gR40jVLuvmP32dMdQVN7ok89KJFWAsm2o4Wur9o4T7YzUYja?=
 =?us-ascii?Q?hrzfKoeiAi4sgO2G/A2+mUfADJmV1CEj45sH18AvpPvcJM9FlY47le3Q7oIh?=
 =?us-ascii?Q?9i+ZFXWpdyNDnvu1Mfpqv4Tvw9gwaQ2dABuDezsb3QAEJ4tKLwc2TFMtB9xT?=
 =?us-ascii?Q?+as9CAGssZYjHAXEnP0520TyIZJsokgeNFPeNRJfpfuyWd299tL54mHL9a2c?=
 =?us-ascii?Q?4N8ATeiSn73sm59THrmKt1g/9EEcH/ITZxk9YuTSfqrRFPMyJNPOwtzQ0Zv5?=
 =?us-ascii?Q?LAbuz+33ZNvmAZ4dyvrIw2XNBaOL3f4Aed5V/gzNEYaPNM6NUnAOasPQ4JJl?=
 =?us-ascii?Q?tcG4QVlAeCp9QrAZS5wsBZeHDVtGKYE0Gauj/ynJs2aRc/xkKQlN9BgPp0tj?=
 =?us-ascii?Q?klTo+oZN9y8+i+V4PlcQ7O5MrGB/WP+RtZD2QmadG/BfiIDVvc9KPoGJSetS?=
 =?us-ascii?Q?Wyad8FXVoNH9Q34l8S1KmhO+sxgGkXcr51yx3LfebBEKHY0trDjBp+r7/Ocy?=
 =?us-ascii?Q?bXGjnSYQFb5+sT5DKBnC2+RIkhy632o9J+Gji4OvjkbwfTHUpdOVTeCPb6ie?=
 =?us-ascii?Q?W+ustU8oiXDrz5Fu9AiXK/u8ztDATu3Lyrl/BTG7h2Y9KOb0729wen9GNWAM?=
 =?us-ascii?Q?WNx1r1xeXWB82ztVelpA6MMVTOsniSu0DvZjZOd1uW9xScmU+5w8U4CkJ0c8?=
 =?us-ascii?Q?RmhNk6cifihpOSIYWjqH77btu+lJWKcKMzR/HiQT6Aj0kE0y7uaQRTAFL3nW?=
 =?us-ascii?Q?uyiN7RJQd0BuanvR4d3/YTgD6fiPV/+eKwWaRx7KXo3v2tgDVC7Hp1eonOsb?=
 =?us-ascii?Q?UDRkXxZnDLGDCpgAcIFotddg/nXpWF8Q4zL4m/5qnTo1L0WcYdK8bEHMjXyW?=
 =?us-ascii?Q?YTDfsCyz/NtIN53+qc8eDzoAQLElVJq4tVe6hH1ddo33pW4u71F//odARyXz?=
 =?us-ascii?Q?kHjID4d3vChBylWcVJIuzUe09uaU4wIX/417zjZoDTT9fynp4TNMhHROiuAB?=
 =?us-ascii?Q?0po8x/NGnZjO7nPomcqf3kk4VmSAncQhaTFANBsCb9mCRU9UNhEUfNz/AH2L?=
 =?us-ascii?Q?2rkcFJp0HGnxPTiTFJIlD25p4oSJmAC0alJqxgE99+UxkUsdQDAjNvJgSEON?=
 =?us-ascii?Q?ivyVpqKz6N1ugcGJ+NWGkehgFsKHr9+kd0KLzemR33Zahw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JG9nEacamW6ug9by+yCK+pWzGZm2Np3H2DNBe2dQ6O0tH0m8brt+k7qdk26O?=
 =?us-ascii?Q?m3wHTc+k3QIcys7Oii02OxUZmLzJqm60kr+NedRsjNIFYPBwH+6uKYeVYEzX?=
 =?us-ascii?Q?F/i8X31bwE0npwTc42ITIQ5m7+NRrxpzOVXeUUw0Zw8ke/yRD+bNZOS1H5Pu?=
 =?us-ascii?Q?TlLC4B5gU0u1kJ9RbC5VlrVSLEfNkqbBTbJEhucAeOTbJ+uZlB6m8+SHGh7S?=
 =?us-ascii?Q?Q7QUYbnzoqRyLgm1FvaArTe0VxltE74YVGSKwwCzCcfjNh/uAbpyBpUztpqy?=
 =?us-ascii?Q?3VKQaVnQcLRhdOXVQF9LjrTBKw+64TPCNgFjQW78F68AfWQJD/dh4vFLQpPP?=
 =?us-ascii?Q?n5jM7D6na9sn25icTErPnZqiwD0L6g00utyQCNqvcwjtuJqYvpTaoTg1zT57?=
 =?us-ascii?Q?ZvdoVmHFYm2JGv6ShLqPuwqZhfuVNhTYSM1ysFrgk9DLZQoGD6FMpVHIZY01?=
 =?us-ascii?Q?C8ksKcc9x84B5N3xxAO27+QtMnhi/dCX6318YWBGK8Cs5gC1S4ZwfPtISLQ7?=
 =?us-ascii?Q?fsRp8iupZuU+iHwGP7JzfTDqzsgvF/e+nUEg6Qa43wH//dX7dDy0ShVMK0uF?=
 =?us-ascii?Q?iU+UBfw8dmSRJGvlmFPzDoFvekcMdT0Ky1+M7Fk7ykcnBozTdzUE8V7I492d?=
 =?us-ascii?Q?ubDW2hmhj1Bb2RIPxAacyDjVTC5kd9zpaZDE7Lzn8VJXn0PiFe4cdXy1iUlA?=
 =?us-ascii?Q?HyMJ1aoQtRMFJlMeAwWjbGrXlIap6YdnCvkLpDIzpjO4DtV724PAIInXOFnG?=
 =?us-ascii?Q?B5ryH+mow6ZQXXsEYJQeMT+KmVC5d1lWiLXx7YCp2CLF010v154/n1QWX0o1?=
 =?us-ascii?Q?cXgu9xOtDNx8NuAALmuoMiI5qBYKj7GsvxOcAnJJSmL6+IaSIwusczc8oSGm?=
 =?us-ascii?Q?zc0hSmI2YbtRijbDRX/Ds8j7Am/3vMBlQQjGKXm4NmFYzUZvsUAXM5sHY6zw?=
 =?us-ascii?Q?8SkTck7oc4IQUma0eij/aA8+Yw80pL+b0eUe/fKEXTbcb52Tq2l8RGbwoHsU?=
 =?us-ascii?Q?1L0lCoHthy2D7MWT+s+QOnYcz6Qx6/rNUsNo8mHvvEokp3fIAmC7wtACVVE6?=
 =?us-ascii?Q?yIkiH7VMxMGcayJ3EP9NnX+ECEdA77C5bQKVFEcT5phofXi5CnBtBtySwhRc?=
 =?us-ascii?Q?2U2WSqyUHLY4uDw2mjcE5LTVrtGljki/bj+JznJOVQdu1VlJ+jkEDZVc4Jt9?=
 =?us-ascii?Q?ACKfn4+/ndOaWd3GDNWqTZII0o5WA9VQyKpw8jivvx0L7zJdISiwTUNY025H?=
 =?us-ascii?Q?FgRxhq7WUDM8uWI9RSj98RVRKnzE4b63MHkdNAp1xjmTrt/q69V63HIuj4mz?=
 =?us-ascii?Q?iaiF5SmiQWWYgfaPt5RyGPVtt3qPlFLK0UTd0vZRnKAlZx2Su/EKQAyweYfW?=
 =?us-ascii?Q?r8ok0QnOS2qO3B/8OytKp8xXYOscPH9/phTEc0l5oMPXExy8oHls1gqr0TmX?=
 =?us-ascii?Q?M4vQ4KlgoTW3utqdm7blDRMyqLWjwB8B+pPq4ijIPwjPb6DFRdvUO5NhpFbi?=
 =?us-ascii?Q?X/QtGffs3pBrsKmdXPvKs3JVNhOVs4DOXpWZNKCx/NssQgT6YQ//acPvZVIh?=
 =?us-ascii?Q?Jo2RYVb5oCKvpvv/pvf8jVL2vYworIDpiasF5RqdmGf0+DjAo93jYRBYz2rv?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e0f4a0-aafa-4801-49c2-08dce76f7dfa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:02:02.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKPJsx0VELCzx9eUXBfWmg0VPjSOWB5wTu65Ne93rSSFngE7f7cId1lwYhXPhjgsVx9A1dT+EhX9Nlx73l/3EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

A Broadcast Sink might scan an encrypted stream, but the user might
not know the Broadacst Code to decrypt it. However, if the Broadcast
Sink is acting as a Scan Delegator, it can request the Code from
Broadcast Assistants.

This adds support to ask for the Broadcast Code through BASS, if an
empty Code was entered by the user at transport select.

The bluetoothctl log below shows a Scan Delegator creating a media
transport for an encrypted BIS added by a Broadcast Assistant through
the Add Source operation. The user is asked to enter the Broadcast Code
at transport.select, and the "no" option is chosen, since the Code is
unknown. However, the Code is received from the Broadcast Assistant and
the transport is successfully acquired.

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[00-60-37-31-7E-3F]# [NEW] Device 23:E1:A6:85:D9:11 23-E1-A6-85-D9-11
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0
[00-60-37-31-7E-3F]# transport.select
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0
[] Enter brocast code[value/no]: no
[00-60-37-31-7E-3F]# Setting broadcast code succeeded
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0 State: broadcasting
[00-60-37-31-7E-3F]# transport.acquire
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0 acquiring complete
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0 State: active

The btmon log shows the BASS GATT write commands and notifications
exchanged between the Scan Delegator and the Broadcast Assistant:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 020111d985a6e12300f9bb8502ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 23:E1:A6:85:D9:11
            Source_Adv_SID: 0
            Broadcast_ID: 0x85bbf9
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 23:E1:A6:85:D9:11 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 23:E1:A6:85:D9:11 (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x07
> HCI Event: LE Meta Event (0x3e) plen 42
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -57 dBm (0xc7)
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
            Codec Specific Configuration: Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left (0x00000001)
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
        Encryption: 0x01
bluetoothd[5431]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 010111d985a6e12300f9bb850200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 23:E1:A6:85:D9:11
          Source_Adv_SID: 0
          Broadcast_ID: 0x85bbf9
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
bluetoothd[5431]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 010111d985a6e12300f9bb850201010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 23:E1:A6:85:D9:11
          Source_Adv_SID: 0
          Broadcast_ID: 0x85bbf9
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
> ACL Data RX: Handle 0 flags 0x02 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[18]: 040161616100000000000000000000000000
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code[16]: 61616100000000000000000000000000
< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Encrypted (0x01)
        Broadcast Code[16]: 61616100000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 1
        BIS ID: 0x01
> HCI Event: LE Meta Event (0x3e) plen 17
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 960 us (0x0003c0)
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
bluetoothd[5431]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 010111d985a6e12300f9bb850202010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 23:E1:A6:85:D9:11
          Source_Adv_SID: 0
          Broadcast_ID: 0x85bbf9
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
---
 profiles/audio/transport.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index caa7287db..6b6365289 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -35,6 +35,7 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/bap.h"
+#include "src/shared/bass.h"
 #include "src/shared/io.h"
 
 #include "asha.h"
@@ -45,6 +46,7 @@
 #include "sink.h"
 #include "source.h"
 #include "avrcp.h"
+#include "bass.h"
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
 
@@ -1208,6 +1210,18 @@ static gboolean qos_bcast_exists(const GDBusPropertyTable *property, void *data)
 	return bap->qos.bcast.io_qos.phy != 0x00;
 }
 
+static void bcast_qos_set(void *user_data, int err)
+{
+	GDBusPendingPropertySet id = GPOINTER_TO_UINT(user_data);
+
+	if (!err)
+		g_dbus_pending_property_success(id);
+	else
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".Failed",
+					"Failed to set Broadcast Code");
+}
+
 static void set_bcast_qos(const GDBusPropertyTable *property,
 			DBusMessageIter *dict, GDBusPendingPropertySet id,
 			void *data)
@@ -1230,10 +1244,28 @@ static void set_bcast_qos(const GDBusPropertyTable *property,
 		uint8_t *val;
 		int len;
 		DBusMessageIter array;
+		uint8_t empty_bcode[BT_BASS_BCAST_CODE_SIZE] = {0};
 
 		dbus_message_iter_recurse(&value, &array);
 		dbus_message_iter_get_fixed_array(&array, &val, &len);
 
+		if (len > BT_BASS_BCAST_CODE_SIZE) {
+			g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+			return;
+		}
+
+		if (!memcmp(val, empty_bcode, len)) {
+			/* If the user did not provide a Broadcast Code
+			 * for the encrypted stream, request the code from
+			 * Broadcast Assistants, if any are available.
+			 */
+			bass_req_bcode(bap->stream, bcast_qos_set,
+						GUINT_TO_POINTER(id));
+			return;
+		}
+
 		bap_qos->bcast.bcode = util_iov_new(val, len);
 	}
 
-- 
2.43.0

