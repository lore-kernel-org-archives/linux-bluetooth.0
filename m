Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C66A468F
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311194; cv=fail; b=Va1pafiLHaVfCRtE3RVmw42j2xo3mSH0zayTg8hz54F6WaaPb1av8L4x1vKsFr3rDCaNjpNpTkceVmsebTI+zBI4vYVg6gobnageMXvXeCh8WtFytGjfXK5yjI0Ghrh5JmWkgDxnjW0OZbbAlUZZsjzwsTuhDkbWarbsVZM108k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311194; c=relaxed/simple;
	bh=ZdjhRIEaLltJcOhw+ZAM984pr4ZPY485rX17YQ3sS9I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Dnnmsn2utSkULdvKMHbUmBNLBoUy2fji+V7ih/eyImZhQLDGb8r1MuIZ7WyohXAg1VGtsKNSvBOHQLPdgwxjr2YmF1TvGZWhuICMRz90akBDA8Gd2yw31hYb4Wrry0eddY/5m82vgdvHyE8uDFV8ODg+4IvQbKVqAJ1CZuEC0Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IrVY+uVW; arc=fail smtp.client-ip=40.107.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IrVY+uVW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJdE80LJ3xV7Gc5LdZeGZSI6B+e9dxBhV/2e9yPGQcLW3UraoxG2rPULDuiLpuUrjdebqBI9l42n3QQ3tAHN91ESaYrInUyGMzOeaFoj/FRCSgCI54zKnvCQ4MDaV4o0h0jG3yysgCQM4En+UHOo6afvGGBHi7D0Y5irYz6h4wzGOItwpkY2ElcpQWogVDWjGaI1lEiCxNlqXtFBCePvME9zWdFmpICQMz0VCeFlG0HUa/tYCOqFpJZWIoS1p2bHTK8qYOG8vUDasoxnSchc7T69re06LYshL0BQPEF5BJ0KxGJQGgEAEOAY7OooKPXNB75+P/C3czVeWw2hyohYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUMwXmIKmfYaRIh/Tiz8jbhrSOfAvtqacxugsVRLQ+g=;
 b=ir02SArrEvP8DJK6qAOuf9Ea0Y5SfXViUjKk1PDy/6AM5hzuna51Q4YR+qq9jgSW0QXzF1kighD8Aun8cxTxGElP60/WyjEGwbJW5Rmi5/Qs3x1iGdUwXP5IrX+OeNKRUwRkTkEIo1ieSp0e96o4dL3DcQThBWQUozIeMOtglZ9TyR8P/FIbU4HkO2rbd+Pm8Mdl0FlNP2UxfbeiWzdbhh8pQJoiNQwvLF23KX6KGSNvgiPl0awQnSKSlKXFIzgKbn+OxrMU/hwwe7yfUYnrvQqqMOUI3WEwnXm9t+0WH21uDi1MA7Y0c5rTFIP/IB0UE/fTkqzFf1nN5ep0v/9t3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUMwXmIKmfYaRIh/Tiz8jbhrSOfAvtqacxugsVRLQ+g=;
 b=IrVY+uVW5y5jqppYbYeF1YbdpsM/3TXnu7uhrqvY6XS279ReeZ2yjdWfAh1SOpLvD5KcbGb7NylwEZculZ2E5ZauaiIP/YA8cghZNYnIo/sLPbXYukgqlchDjWUj+EKCLtfx6VqDsHT/SRYWeP6n18ahBWQ1E7Liz10u2RqXPj0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:39:49 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 16:39:49 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 0/1] Add command to create local endpoint in bluetoothctl
Date: Fri,  1 Mar 2024 18:39:45 +0200
Message-Id: <20240301163946.5484-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0041.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::15) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DB8PR04MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccac9c3-b81c-4d34-fcd9-08dc3a0e3623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KK6+w2tY4sagV4drlqPHaUaeoioWe5a1MKE1MAiLlBTcozqSgE5vJwW806hTazrIKt7QtY8mlQxxH2tgq+HGFbvJeqvt2Hke010/qjfRt0NX/hR2ZaV7IqMpAT/HdEEbE1FkaddzKbSjN/XJM16T8sdQ+F70fAA+1mYJS8/iTKTBY/JdWA/IZzn7/iyl2z6qo7q25vZ44XHT01aVRzfwEvaF5qq1JobA5Zzx+iPqGoHz8WTsKAT79daGWv6OuxWT12v9HC20Xw9szun7XP+HU8c2hJXYmQYW62uTZgimZLUho1hMqgtxZat8+ZSWadf14OmhagjZT14heWdpoatptW5JbsvYkpWZwUuoJXAPV5AwqVZ2MXgoc9MzJyyEK60iW34OcDd0XoL09cLXo5V79CWhyBQ/IxJOAx6HXuwGYktI07yKoB9StC+Drrek8qKNJo3DAkMvTwovs+Gv+vYdydk2HQcFDEHrzol/fupZ3Na83TonTKwZdw9/X1JLfaTbHZrPzor+VitcfH1wKYa6NsHbDdqr4mDKN1NqZfdMNOJC7VOLaeYZ3vUHlYPkwAckz/cQWQbHM3HtCrI7JQRlsVzdHG1/X6O0YM0b6cio60t/klPt2DRpW9dp4QTghK53Fb3Eg+R5d+JAaTq4KuCypQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/C5bOMYomGGizf0MLZbjyxOJ4ba5HIQJFJi9TKBUuHFbXcZJNW7zwzEMY0/X?=
 =?us-ascii?Q?sxMca60/Q7ZSUlm38hf3l1t4id5UIhfm9hpawf7W3BxLhG5id9Lf5AI39Qzx?=
 =?us-ascii?Q?lzzlxPQjvnC2SvVKxAbQmve60WYMSlpvwSlUBW9Q8T6Z1dwE5d6baAFDCw2M?=
 =?us-ascii?Q?0ameYK+tHGjIbu150BxJyki3mFg2ImXpza2cXDDkvmS6mdMSZr+XWdFV+9G0?=
 =?us-ascii?Q?izpjAFpGtRAG9oKuJ/8Z7uSOZcHqKpcMTD5aY1Dv7yOf2syxZ7RhRHfSSibJ?=
 =?us-ascii?Q?KQEkogNwztusP1oQZiElMT+NbJ9WVK4D+Ey4MAzXlfDaOrCRs5nfNijCa21k?=
 =?us-ascii?Q?C0JIU2KsCTX3xTs2EMYonnljycImA+15m4d53FxYS4qIabOMEw0h2/hg6lQp?=
 =?us-ascii?Q?b25dHcVdRxt7N7NJM0/Uoi/dshbhcgfwTKM8ewYwEUWUVS8J+Dbvrpp2WGQW?=
 =?us-ascii?Q?sdStWp8xWUi15IfMETUf59vSJD1tQKG5XCfnKaT9KciafhUG7yXUjbQGdpKk?=
 =?us-ascii?Q?/g7k03KRBnxmnGm0e33TXYeNpy4h5iCa01gHk9KPVbahg7NSScIliaVoUkB0?=
 =?us-ascii?Q?HTz+ZFAUpRY1+oJg8xYHpm5IJ2a4lR4lb/YIVUyBhSn5Y8WteceEOvFIBYQS?=
 =?us-ascii?Q?YcVgOnQLAnsVPzbVfYu90hY2Q60kmwVF2U/C+viWO4N09kl2zmCO01IXeBFj?=
 =?us-ascii?Q?oGwE/lPGuF6Ruja+KmfXm9HyUwrqCcgi3Ut1xwvIdfy+9G3Fu1QMXvp7e0Os?=
 =?us-ascii?Q?2q95sEdyTplkgb+zIjbZBdf/qv2i2n6jvSReLAak8IaFj8GSrtmZ+CUy9orA?=
 =?us-ascii?Q?A+msjdJ1vhpC2kbPmzRduvxgmVTepqN824065JSUBT/kXeGiEfFD/zWIv/2t?=
 =?us-ascii?Q?e06KU685N5kzyerL/lkX13LLE/j29cvSuA2oF5ibRgiPofDBEdUYeETxPXgW?=
 =?us-ascii?Q?KUBYNKKC027m3e+m9SUSTXmAYrBcXVm+L1egG1OPNd8mbPGxux9JjPyE0lRS?=
 =?us-ascii?Q?tV9lxwnrSCbVyNxutbOTY9NdDiOJlJZrk+O+fN8oMwtsXplywGLlneZTYzfP?=
 =?us-ascii?Q?gYWRlv2Ur6WW460NTnSOWOBMXRhKp3crNmY3iKn8CVEiGf8xoJOihb1VhFYk?=
 =?us-ascii?Q?zH9dtU5GBMkhDj3DOSSO1PSkc1LQYUZhYgCHblCrpdtAT1Zn23/izzIuuszF?=
 =?us-ascii?Q?6Y1dgN7JABcSmHLgud6pgNi1z9LsR7yPGd4J17dPZFZDQzSlsIrfJkonuYFn?=
 =?us-ascii?Q?5W645jznC1z0hafm18xSYa6OM9l14WsdVjjAT9J8xsB+cc5LnpGZyNOo+Fac?=
 =?us-ascii?Q?eYd7bQI+/MryyuC9ShnxZI0rm1vGROP46wczQt8e+jsE4BRYfJXNYQzvNEDI?=
 =?us-ascii?Q?g3R3LaUaXTXqwaE7tAQmd0aapgekYkyVieUVrK1wsaKu0S7E5riNJxssD1Vz?=
 =?us-ascii?Q?bkIR3Zp9MJXG9exJAZdYmPkY3X6lFSDOeN0SkXfFPWuGr1kTPxeu1+NbEImd?=
 =?us-ascii?Q?SKvwV/jrgpYNJ1kMKMoQfPmLMd4zccghf17e52RY09KF27W7lXxCYZSuk0Og?=
 =?us-ascii?Q?A3hhtYiauQD3JHSKXKUiYAwRfCWEIQmoG8a7e8SYnadi5K4T8tFUTUbFYevN?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccac9c3-b81c-4d34-fcd9-08dc3a0e3623
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:39:49.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpqn8SFB8hCB3sdfUziqTbmGvpBr86Nfn6FJgCFwP2biaK/NfPO6V64YSGBqk9T88bXw3/nIwkdGaqmI5WPIvhE/N7jNB6uVP0sF1BaJSEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179

In the case of using BlueZ with Pipewire to start a BAP broadcast 
source, Pipewire will do the register endpoint but bluetoothctl is 
still required to configure the broadcast streams, but no local 
broadcast endpoint is defined in bluetoothctl.
To resolve this problem I added the new_local_ep that will create 
a local endpoint that can be used to configure the Bap broadcast 
source\sink.
Example how to configure a BAP broadcast source:

endpoint.new_local_ep 00001852-0000-1000-8000-00805f9b34fb 0x06
Endpoint /local/endpoint/bcaa/lc3 registered
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/bcaa/lc3 48_4_1

Silviu Florian Barbulescu (1):
  Add command to create local endpoint in bluetoothctl

 client/player.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)


base-commit: 44d3f67277f83983e1e9697eda7b9aeb40ca231d
-- 
2.39.2

