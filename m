Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064C1EC012
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374598; cv=fail; b=gAyC4ZCemwpPZzuP2JXfMPqYLS3MrZAyiHh5iOU1yOk8ngnGPAjwgjZ8r8ngn8Yji1Et3Fn2J2Y2YrAwz0Iq8PSlyuh5J2bRCVsFR6l78F8viVvHbbsWDTz9YmbF5zCEe2MLCjPzRO0glHq570UucSRLnlk26limGD7WgaG8zto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374598; c=relaxed/simple;
	bh=ZTWkXRre487V2evaunVJGVLJt4DZs9IM6jyx8nvMkus=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dial+2b4ZF7mFe20Dc/9fUlzBsG3Pr8LLV5IIlqZtd9DLXc/dJJG2VrJkCTmy47tA2EHxjB7vi7Xo1i7GNuDaIsY5ykuqPkQn8X24wI71cfZudy4Sk899v7iTV3N4HKscm6G6yB1qX4O3qxFhEl2zu6mSp6P3e6BWnnmgb6e7wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X5OwKef+; arc=fail smtp.client-ip=52.101.70.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X5OwKef+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nurRF4Q/VPS9+iNS9CWCMl83tGgJxYjBHB9OC2aT/kWq7+uZT9nVCZWBXtpvsUa+OKrRYuxtG03558emqJzhTxNUh89XLq44jRceKWNDza+v+UrIqk47sPr2+J5dH0FFAtzXue69+7DgWUFrTrCwtr0Bswfpq8zggfubypm4jFrFFydFXQEjTnvt6xC5mMVPp/P3M2GeqUPOjrHCKB8Vf3aDBxA0tn47o+o5TK6Ub92UeKVXUS/M81l5lwuYSFQ03bgTfDEU76epB7QfzASIHjkGRtlpOCZ+/28AFECNxe8SAVZe+iNRqTnwVdL1kAVn1CIzHoCr8OC6aQXsCcZvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYMvRASM5rA3vpdmh6Egcul8iTEk3pyRj2cHeDe+XZU=;
 b=fDx/sfizplLSszHxqoGKU4Xu1MILIvY2JR4F9GL7BJ+sYsQKXl8OenjEP2ULFqHsLnXY0897gId8nHjoMOwk/l1RnI10YTvRfSS+4be2NEcEZ6Jb/sFtk/Vz8Vt1Fvphuqhu/7x6PVKXu/qizqNSPHHZa08Nk/8fmCNu4N+O4xw0XfhsHzBb9uNvvT6zR35vd8pTwfkWpD/ZU/HvR/hCQzTSVlGxqz8bnLL5draM4QEl6Obl0HGJ/1MbNm0VX8+RjktM3baRXlaO7+qVcNiJOVwQH/O+Cj8eO36b4hHYjR2y6IDTreSzeS9t9yQOVpN4he7PlO2enQVBcvNA5HdWRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYMvRASM5rA3vpdmh6Egcul8iTEk3pyRj2cHeDe+XZU=;
 b=X5OwKef+WLd4l9N2zfsPDB1h8EfYz2NISnNl+wzT+k+SIydy9c2gwxSvD4+/WXK6eqF+NWy8RbdqLew3N+RuO++mkLx8cV28pAjBlvzdfsdYVzoU3rN5fD/ovhyMT3jcPI/TigQjzI9ipjE70g9hEH5u0rIKryFv9BypFRjMGq0samveEeBxk9CR52GV+QD5luu7KAj3pN6o7KYwBPWHkDT5hylCLkHvjC02Gi3KmCAMXtXOh9ZEahbNMClDIKJGCsGIYxeWn+uSy6FGEbx6E+OmjcY5RiMKGcNuYwtvVogQPPRRUKvk0+5OHEAKpFg+mbm7+9yChKjl3bL2fvHZkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PR3PR04MB7388.eurprd04.prod.outlook.com (2603:10a6:102:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 08:01:47 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:01:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/7] Add Scan Delegator support for Set Broadcast Code op
Date: Tue,  8 Oct 2024 11:01:19 +0300
Message-ID: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-Office365-Filtering-Correlation-Id: 26094052-ef61-44b7-ac06-08dce76f74c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DjInoxThf8PDV6aEUR8MXCIMLmVjWOHDhOWdkuTfI2bh1xbPOlzZ3AKmdkCk?=
 =?us-ascii?Q?WA5buSzdp5meGdtClGCVE6yTr0MLfTfPWqJ5XXc3/vjByd5TCIBaEPBqPkwK?=
 =?us-ascii?Q?xk92RnAuN/FD5LjAOZIcUOw/RXrSFjDK+dvo+akGgHaHEqAVz4eqSF1aevoX?=
 =?us-ascii?Q?pvXtwHPq4T6RZ5AeWfbB9TX1ZH2h5KxIpYubyFmuH4GUTbeB4bG8YyL2m+BM?=
 =?us-ascii?Q?mJUP1KrXB/PqbUtF64sbyzFm/gzNcdPbVcvGLNWgxD4yF843AeX7tTcqa6qi?=
 =?us-ascii?Q?kww2lu6EsbQ4Enis9k3ioKV72h6TwlRvLromccoSH+zxkNukk7Rg/BA5QO+Y?=
 =?us-ascii?Q?WAhr9isaZ+bhNL4JiQL9sY7P4GnOyqicSDkyyZ+w4XCxOG37TV+aw8CsJpU8?=
 =?us-ascii?Q?U4ip7UIAUlfLDwg87MVCsLhNE+HK8E02llPzFYWTEBEgiG4gw8z8pNpfDY1n?=
 =?us-ascii?Q?sNTADBaOUGHRCUiW+Jr37ZIYHiatAHCgKNoEPLZ0RMjhsFurhpxnVMsrPCiQ?=
 =?us-ascii?Q?64laq57DuQ+UZ2WtY8rKR4RmQrjOq2v4yOg/1SOb3xEb+kqgAdZ5NnmM5Xre?=
 =?us-ascii?Q?hqukIUx0d9r+p5TrfsJxVYIbsXEKkgNMxwYS3di2tOvCeFTYjZibZ6sWe010?=
 =?us-ascii?Q?SsmGM05XPXAvDVeNu/ww0Uh3PnUjH4p6w5/CvcXgQk23mL489YZZ3lTspNpv?=
 =?us-ascii?Q?YSv7syTkYXyZlKTKclBiw4wPY5SltuMumXQ1YNPozEVg3R92vsWaBRtRLIhm?=
 =?us-ascii?Q?HAoZ1XDQHiEWe5Ube0TbALJR/HlCEabhnPCiLrh1CKQD7olh5KthBA1Dp79h?=
 =?us-ascii?Q?nfO/HsFG56ztDiAwir6QFet9xENXy7Sli7EqnIyTGy6v7QuLnUA+wc2/cJYJ?=
 =?us-ascii?Q?/2V+wJ1aZEK5nms98Ug3gOFyPQUePP8eLm796UbNk2IOSCZ4ezxNKzw14WEu?=
 =?us-ascii?Q?jbaLTQpd5cD8OP3pwCyjDHyRb/0zZ1eNKBsYeqeopzPsujwotXlpVpj5RsuU?=
 =?us-ascii?Q?YmZF6WAuGzgwUYsh2w2i0FSehJyNFSu5klhq6+Xe7mK1MuIGzaGyScPnZkPz?=
 =?us-ascii?Q?jZEA+BETdVgq5ORzD40UDDGZBU5f0KSpbWhhTNidbDZZIfMm07nVLX8QnjJw?=
 =?us-ascii?Q?LxkwtYYajEh5TCeKAKhRlFceSnk36ldXLT8lASdjp7qSBGri8AgUhWcXk0RL?=
 =?us-ascii?Q?b9naMjP1YY0GisjGnO4+yokNNn+Hi0b7TaxaYpVYldyuCxsibUbOUaeSMti9?=
 =?us-ascii?Q?+bHVNUEdEvZ72J/AmWrAxxycXR0SQ1cxwpP6+IxfLbmLwts0ZD+M6qhYWMpW?=
 =?us-ascii?Q?UjpgzPusC9c6QeMpdxFzzqtv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aEH4UEK/p4TksRwo8jGsn+BLHcHY+Yx9QTBz92BUUM6CPiecmtpmtnLAOR4m?=
 =?us-ascii?Q?ZByrVvHKq37htdFleLO98MIaLX7Q2S+sgAxar57PVGqWdd758EvpE8u9p7/i?=
 =?us-ascii?Q?GTKV8JytacswC35z+Sb89MWLFLWYz7WT1VjzJN+qO1kcCe9jB4wWn7TraPOA?=
 =?us-ascii?Q?9XmVTIcc0gL+eSEPeYYoJUagHghgBi+W+vIpmdBy/QzIQvzbhzBzfQamvoP/?=
 =?us-ascii?Q?IkN1t/6vnk4nIGtnZjBdcY3rHFk1PF/TKo4nZ3q0CeaGBJSbL2VbsbDQMlDk?=
 =?us-ascii?Q?9iZSrZZrAtqIw29DEg5Zpxw9fLgsMx2pbKxfITODFQhWdp3UDoH9/EaKZ7Xo?=
 =?us-ascii?Q?hMmO6c0994YdwRPMttt5c7i4gT4HETbrFtcLrnHd8EKG+e1SHzQ9VzrAW39U?=
 =?us-ascii?Q?0NmHmmyaCCBUOy1m3SVeCZSkn4O5kidABptN9J4Ejdd0fXgE1u+VmDVQT5z/?=
 =?us-ascii?Q?d0UtsWfmFUHBkypI4xnf7XQcdFQKdfonafA09QjfbU4FIlyg+GTBFbPgHmGq?=
 =?us-ascii?Q?hpvbFwcIJ89AeoXo6T0TRbUKlpeOq+E6Icwhy+yri+UQI5jwye/tv+xiQWIm?=
 =?us-ascii?Q?6Vt3i6unfd3k6bJPt8QZvJLBPg/kmD3jdTSPrdUOMCk2039MvlyO3SswsTLJ?=
 =?us-ascii?Q?QtAx80fyWKMVnqrCADfBlmJ216hZr5D0YMGre/jbPDSqhhntgMW6Hbz56AmU?=
 =?us-ascii?Q?2KL/bz+yeEkcMlPruObQUbhZqkcp520YHVvFxJd+6jRPvpB79UjiLOIkiUCk?=
 =?us-ascii?Q?FGRX7CorDYaN18XXeMnGNhLJOFvQLhCYzXelqW80lfYVb7zaqKIWuclyy5OD?=
 =?us-ascii?Q?qDmNCf3dflJ+A4R1RF52bYTxY9UZMLnlm/9NHdQ/TzJ+Wz480x9TtL78aLne?=
 =?us-ascii?Q?0uo7Hvu8ZSBhglWRXoMehSS0GSHDqb+uoy3VH8s+urHA3BiDULBxuXMurCpU?=
 =?us-ascii?Q?2gxvkKm6BZqx2XZbX3vDuLcdpIa8yg7YwfU+y3SEEU03OPCzsbubdVUan92z?=
 =?us-ascii?Q?CoFJasZxsUr+wxjVlNQKzCnS54kUmgA4Fs503akbjkzpfIRRV0M0uOIwkXw5?=
 =?us-ascii?Q?1GeNYlY8BkgA2+1nhrpkTzQx3Fg7tasRLj6g4B2sqDGDAvR5WXkItvwwtVD/?=
 =?us-ascii?Q?I35Z8KSZF+aXXrUnWLlG14zD/n6CBIT+4TOo4M1oIbqzUmBNlskVS/b0tHkJ?=
 =?us-ascii?Q?u2RcaRId1W47fRTWCErknyaWCAmkoiNbYOm4ZLm+HUStZ+ens/BjLSstCfn3?=
 =?us-ascii?Q?lpvn1xpUCmHKmYFaXGX4j5W4Z4wtGURxx75bcdykQ9a05SMcbnHUGztAbWVR?=
 =?us-ascii?Q?oUczLdBP1obiU6bQkeZo9P+HdYD2WeKhfBOfNzeyp21MVBnToNxkksPG+pCR?=
 =?us-ascii?Q?m/uqIeONwxw3Cavmv1VTH1RENJwdQ0NYmnRliiL74hRjCZZHvQZsH8V3RR44?=
 =?us-ascii?Q?+9GUv2rx4vXk7bBm9q6Jy0qvvQgCSGnQIWbu7xrcIaOUglyP4+uO6WYhSgzU?=
 =?us-ascii?Q?NOpyv/ezZAs2Utx2HpH28DwXl6XzqwpZJ1fwenbEiy/jkhzFdcJx8WJLU4Rh?=
 =?us-ascii?Q?j8qrwlVMFBMilxsA7mKXJEyuJdRYkVpuGvJas/9h9cptajT+HFaa54zzX06M?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26094052-ef61-44b7-ac06-08dce76f74c8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:01:46.7690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0t/0DwaEPp7of9YGjxOF7UZc1Av4ZxoWdYyIzENX5cNFvjpYeiavJlXcY6APB9+5ttEfm4+RDvecPmFMXpo4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7388

This patch adds Scan Delegator support to request the Broadcast Code from
connected Broadcast Assistants.

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
            Codec Specific Configuration: Sampling Frequency: 16 Khz(0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left(0x00000001)
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

Iulia Tanasescu (7):
  client/player: Add support to set empty bcode
  shared/bass: Add API to set BIG enc state
  bass: Add support to request bcode
  shared/bass: Call cp handler for the Set Broadcast Code op
  shared/bass: Set correct BIG enc state after sync
  transport: Add support to request bcode from Assistant
  client: Update scripts to include encrypted stream scenario

 client/player.c                       |  13 ++-
 client/scripts/broadcast-assistant.bt |   5 +-
 client/scripts/scan-delegator.bt      |  17 +++-
 profiles/audio/bass.c                 | 141 ++++++++++++++++++++++++++
 profiles/audio/bass.h                 |   6 ++
 profiles/audio/transport.c            |  32 ++++++
 src/shared/bass.c                     |  43 +++++++-
 src/shared/bass.h                     |   1 +
 8 files changed, 253 insertions(+), 5 deletions(-)


base-commit: 31e5b8f206791f0f96c20d9ea358208b88e44dfe
-- 
2.43.0

