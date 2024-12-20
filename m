Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1179EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705919; cv=fail; b=MNMTfHFefeBQ60SQ5rxNQcRAt+BXH3shy/KyGe0Zo5Vbaa+ArBYFc+V+ctcmTcvH+nXzqyAve6gNBBUC0NeLoJ+upwfqzldtn3oAGO5CBeLD/hat0Eh4P5bM37yUQ/3vY41Bq5nV4ya4Yctl9fQpy51NrbaM7RoF41auoDy9Pa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705919; c=relaxed/simple;
	bh=aVCUdXcX6Sv8AxaHguaCY7lNyx0kHjRV/9K7hMYFjfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lxVIHGGJGOQJD4eg2l1bz3UznL9N+vFzXivz6Jn/m9OkYDdDmuqcOMnui5ZDzGVrXCskwoM0lqFe6ym8Zr1fkhDWdFDOdrdu2ServB+JIkA4H4M+4LHA9cBhDdzKBFewAVpcWLOh2We+bGnsSwDnDt0/lgYroJObVkIcYGyZICw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MBGELe3n; arc=fail smtp.client-ip=40.107.241.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MBGELe3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihMIdYIaRJNBM98Cq5xQ4uG8rdvqbAHoxOO0PHMpRfK6ttqaA7YkJckfgz+aDqIVx3HqCdplnEpbd31YJp5zeie1iCxQD8RbV420cqpJxnC65oBsufyQuHa2sI5dvuQ3J21lr1KJIoLGFzAzibKVWrQoeWq+6hNR1Ej0RqbWoRjTElPvhf067TgPUH7LGPLILfjI4VZldLuKBetJMwhRy0xC/54NrmnekNBhVz8prVRd3YAodGwYczhWpzaz4sUUujX6iTSpqBgvE6lwUNobJ17oGVzsUMBq2/6kgLZgk7fdXsB+Or3Ze4dBpiLxT6AkDxGku6UxXICP71nHndqdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOWUHo6OKQ+CT6j9Jj7kvJYKzY/+r7ou5SFVW/gUByc=;
 b=VdPC4kPpeVKmGbJGQm3ENmGk82YqC2HsRIGG4FxoNDri9yvoyc9nyxennKpQfEmMenWeeh/rQ+daHg+56b1WTyqFq8wussvuRkGJLPiOjwTKEX05JU594BHiyOOP1MsbBO9AKm3mQGAkRARpl4G2V9YGPAJz8DMIgxAQ+tYagks63XTjwaRozT19vq2UFWEhJsXnUvBTKGHHjHapmHSMcYTEgxlyN4gRD9cMTZea2NRTM4eLHoxu4zvqXGBOd1OrWcOYTHhegL38jvxF6qO7r4mpDxVnDf5H7XGQxWJ2/k3tdJZ7FCEBJwzpHVbnkZPbD7ziAWJOs8E0RWp4ykkHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOWUHo6OKQ+CT6j9Jj7kvJYKzY/+r7ou5SFVW/gUByc=;
 b=MBGELe3nKZQjTrcNWDWx++Jza0KOzDH7K6aybo4WnPDC/qrCWT8TflDVqmTKpmiGj346tbzK2rzOJnGBhSDt6KYi+nVZ5/pyh5R9cO4lT4a6zpTlwmFzoXg11ASdhnoMDOXPDWN5NSotvlQRvC9M05JojRHjsbvf1Jutkrcvfzf9InnsAFTqnmWEVIzka2xWsHCyJR1Glbk7LuxUhhEIWlcXaGa/0HsMwzDt2ADjAfUgvWhn7Vp0NF8KZ9ufX16qkFNgB7den/tNjNJbuV1NoaOGneuOSXOzDzYc1yOuSfhsIaFaPfs5H2wYdSyDl6xPkBOQ9r8ctzJD+w2/4qHAaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS5PR04MB10059.eurprd04.prod.outlook.com (2603:10a6:20b:680::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 14:45:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:45:12 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Rework transport select for encrypted streams
Date: Fri, 20 Dec 2024 16:44:58 +0200
Message-ID: <20241220144458.27739-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220144458.27739-1-iulia.tanasescu@nxp.com>
References: <20241220144458.27739-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS5PR04MB10059:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f1ceda2-350f-4169-0227-08dd2104e886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GAb53wwz8NRdWAyyAdECsb3M1Qpmvi7mh8q3Trdg7s/vEuV/FtqDY0fi6T/4?=
 =?us-ascii?Q?SgdoZmxSjiIAXOM9YiEnv0VK6nNk0ZS7/jvGXMliOb+50CRX4o3Ye0ZsgFVO?=
 =?us-ascii?Q?oRmpKCOtahg3lsNak738CMsRDcD5e7SrH8VgcRSZvae+qux/4ZYx0v2WX3KP?=
 =?us-ascii?Q?4EwJzKsBE9d+6PGHtjG7/rG2hKW6mqCqKQHaoUo7Px0TGfibmCUXsOMQRvCq?=
 =?us-ascii?Q?X4tmMi1XhFAEPySaWPv154GiCuSKzdFmCZ/P/B+PZ/gOnJaRkWnUNeL2L2t4?=
 =?us-ascii?Q?Gw3mB4TN5/PG245WNkVuW7qmQqzARDS6P0XSSOziqx37IC8gxpiPxXtMMmi8?=
 =?us-ascii?Q?31g7TSdcJQuFLR/xYwZVaFOI2hJQWFwP6HKbGtRxDY28dfQ5rzwzfvW2S3pl?=
 =?us-ascii?Q?CecCTt0eF70dNWGyMPF/fWWd3GrRaNVm+tusDN4KyYDKPHz6bdo7JA0pWJrG?=
 =?us-ascii?Q?KiTWrVgygtkpkqUs7hf0EOAh95FPo2DAC+hGhWU08iSIOA8Vr74Zez63UeEc?=
 =?us-ascii?Q?69GvDdrYJ7d97elOIgh9dLY8LF1y/NkW6dhFR1J2PGKf0EVo+K2lTLTswnZj?=
 =?us-ascii?Q?zT20gCHp0A8GxcZVBaoNbyBBWYKe3ucyKyzEH421FxVvHOo5Lu+xVqe2kNR9?=
 =?us-ascii?Q?D/ubmpePeWLVOrTYSGy/4kBvtKzPi+7XXfTvHx5n3MdWywUAKKyOuZcD/rp0?=
 =?us-ascii?Q?viG/WisD3C7BdZetg7vWEjOJfUuS/uZWqTfOXEE5a0T3ju78u6G32B/iYCRr?=
 =?us-ascii?Q?2y+JTXSduJ4GoVV+XVH1qyLnlxTsWdqE2dTT2jsf78jFcMuQSCnuLh/GpQj5?=
 =?us-ascii?Q?MdClhQ6QaJk2GD64fROGVSHfaW/xAKSmLWLC+QahhzIVhr3QspOMIRFQshWn?=
 =?us-ascii?Q?qRzztxswhsFcgcFLhWsDlTpifVbu17GDHgMGKi5eK/IEk5QeBNgr4mo5jBbL?=
 =?us-ascii?Q?Q+KUTGAmhN+8PnxNW/aILukJAjP1y1Fr0skcXP59Vjf2MQNPzGrRCTn97BVI?=
 =?us-ascii?Q?5UPnXL1RPWZj5M5FaL8cDI3cKsA2egFyISJoTJcxoTwoV+2Oqiy1sIxgNOkq?=
 =?us-ascii?Q?s8DnaeEyV9lG8G47xNqnLlh5ukH6qAGWKSx/i1ZnVaZOWFwHpQ+s6r6kiQVE?=
 =?us-ascii?Q?EkWgPmnP5NtaRoLfNYuBkWjQKzPmgLYbt4jms5NvN3VMcdXdniKRAYQukHld?=
 =?us-ascii?Q?LNZ/dTGpQTaFGp1vbvL9qhQnsbeGkCGhsMfzc1BnLvIfbXiqkgZ3ZwkK+esX?=
 =?us-ascii?Q?8cX0bCrSXcy3CxMJmtzBTlwF4m/bKkP4fX42aO4TjE8PItZ+4MgiBwcZujTL?=
 =?us-ascii?Q?WX5Uuc154Ov3H4MfYcDPsc9V3zH5BRJ5+ELJ4dEJztaBxOSJT0kal2RB1CYi?=
 =?us-ascii?Q?nwaJkO4nwRHNFeDvvZcO3bCCEtkg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V8TD792SJ2JPibLZOwWgEYdtjp1p7FiaQgzmD7JnoLpcivvtSeme6vmBswv0?=
 =?us-ascii?Q?7wZyGsln7oqd2QYyTN5rl4MOjF0zrHlAnmAkY4dMEqo9F7AQTFWyk5f+htbA?=
 =?us-ascii?Q?4BEhP0OhOZ3DxkABWKKjhQWYTqc3uP19IieqMJrSVQutTLBGDytTBZR4CCVR?=
 =?us-ascii?Q?r9XbM4k3QV67rFNavubKzmXw4tXzS7qCLndKbM9i9Z7cqZOUa9MDeAEqX5jc?=
 =?us-ascii?Q?cr2uRiO0av2ODfseEQHbUH1lQgAOFxe8Nadn873rvpRNhiKRWITd+Hc3ctQu?=
 =?us-ascii?Q?y2a5hk0PCkUkUmNPVcwMRQF0ZgEzjlLnOpPW6A9Z0fJvtp29Q4blW/ZuHAkT?=
 =?us-ascii?Q?9bjI+y5dk3xzP06jv0RVOMvuYOpOGcdOk2b7yEgYoJVBjt5CbvBYrbJ00ado?=
 =?us-ascii?Q?Cu6/0RSiYMELIXu8Q38Rn5qMct1zfAfskJJwD5o0b7UHFLodsiYQBMRNGnSO?=
 =?us-ascii?Q?tz6eXM4woveXAUZLMADdyWFQ4CpQXFNMMo96f3sN7G0yHUn4NO0sxHdKWmdS?=
 =?us-ascii?Q?tNeQUOhPizjTcw2sNDlLPPqO+BvmSjQqwaNDiFbYKl8yRxtRJa1v+16MPrCU?=
 =?us-ascii?Q?UA0MFhT54qvdgETqY/zss2EBdTUm/mDeuJzuGOnd773XBJpURM8Ddmq3bLeA?=
 =?us-ascii?Q?Ht7QJexDzBTvrFeatKO9z+96VwIwNMdGeTByJOyCwN/Wt4z1mW31X6DHau0b?=
 =?us-ascii?Q?hsk2K8hB9htFjWcU18FxPDxuwGqmrjMAUog19iEP2/entstdVw+KdOPnHslq?=
 =?us-ascii?Q?20mxbDS6KO2iwXPHnTQCnCYjzoLJFysTEQQAZjl8Bxe6i9rit5b21tFRY9uU?=
 =?us-ascii?Q?Hut5PlCWC6KqJRMnWIRLh5vyOD0/MFm/FOK5xq+skecaaFhpqjbtAKnL8Vmj?=
 =?us-ascii?Q?doL68gXBsvSpZl+Svvv7qwuDJRzMg5c0mK1AabnPxREj7BUyTvqb8ywEaBP/?=
 =?us-ascii?Q?Ga89MRGctsg06o8uabJuwy9rACG7C7L4b/ULvR3f2SnTT0tH3UTuTRNutE1o?=
 =?us-ascii?Q?GNhVU4ppeo0dfoJa2EWMB3GUzP18j2KWgTtbmL0r1oXqRFbPrGLJYKlp/Rly?=
 =?us-ascii?Q?oA5PoX8wY8N5OJIke1q3ru1HZbC7ULp+R3ngylzylFh4qH/4lWuwF58iYceQ?=
 =?us-ascii?Q?hgNdyDFSAWfV42oEv5kJOrIszvtCdK04PdZBq4cyIUWvRgTkmzl629raMKXS?=
 =?us-ascii?Q?GmPGzCfG/SHeXC6jUmknhdlyGtYziBst27sIYthP1ExjcI4MWrqZeOxV74yp?=
 =?us-ascii?Q?Cbi24J0NPemZ53xoruOiqKKZ3eMWngfT/PiQ7RFTeNLH4a+wt8sEDXw5t0ua?=
 =?us-ascii?Q?hJVen2ONS2PxeZp37P6CSBzaldKa0gkEUfZyK07ej+ZExnuKZt44fURHpyfu?=
 =?us-ascii?Q?aTafKI6DP+QmQOorgFMK+O52DjpkVPic4aO+4fnWbK6EDQzYfam3taXtaUfP?=
 =?us-ascii?Q?wdztbf7jfAN+fR1uKMnx7hjn5Iq1VfXXIDzlXLv+uBOROCSJ9/HVJOg++bf8?=
 =?us-ascii?Q?Kfzcqt+pvbpLHVhCuuj9MqTS4pW/uwG3xaPXCOsbisDrr6cQdgtVU+sxxdf5?=
 =?us-ascii?Q?PmZZ/eWWnoekoR4Hf3w+0d3snQz0oCk5+yChpEeFUxeU9iFxo2fKLOL2rMQS?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1ceda2-350f-4169-0227-08dd2104e886
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:45:12.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6EJbnv/JORREsR0FC0n44zadXUsB8/UJ07K+fyzWwBCyG655wOnVGaE/76loCIO3JoM0IUVHx/lZnh5bU+vNXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10059

This fixes the transport select flow in bluetoothctl: If the user tries
to select multiple encrypted transports, the prompts for the Broadcast
Code overlap, causing the UI to be distorted:

[11-AE-0A-C1-F4-30]# transport.select
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Borne House
(null)Setting broadcast code succeeded
(null)[CHG] Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     State: broadcasting
(null)Select successful
(null)

This commit updates the transport select command handler to first
link all transports before setting the Broadcast Code only on the
primary link (the Broadcast Code is common for all BISes in the BIG).
After the Broadcast Code is successfully set, each link is selected
one by one. The bluetoothctl log below shows the updated output:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 11:16:BD:36:58:3F 11-16-BD-36-58-3F
[11-16-BD-36-58-3F]# [CHG] Device 11:16:BD:36:58:3F Connected: yes
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-16-BD-36-58-3F]# transport.select
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-AE-0A-C1-F4-30]# Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
[] Enter brocast code[value/no]: Borne House
[11-AE-0A-C1-F4-30]# Setting broadcast code succeeded
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# transport.acquire
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2 acquiring
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3 acquiring
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 11 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: active
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 7 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: active

The BIG Create Sync command is sent with the correct Broadcast Code,
for the 2 acquired BISes:

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Encrypted (0x01)
        Broadcast Code[16]: 426f726e6520486f7573650000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02
> HCI Event: Command Status (0x0f)
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00)
---
 client/player.c | 159 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 127 insertions(+), 32 deletions(-)

diff --git a/client/player.c b/client/player.c
index f93c9d908..464a9cc14 100644
--- a/client/player.c
+++ b/client/player.c
@@ -115,6 +115,8 @@ struct endpoint {
 	uint8_t iso_group;
 	uint8_t iso_stream;
 	struct queue *acquiring;
+	struct queue *links;
+	struct queue *selecting;
 	struct queue *transports;
 	DBusMessage *msg;
 	struct preset *preset;
@@ -148,6 +150,9 @@ struct transport {
 	int num;
 };
 
+static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy);
+static void transport_select(GDBusProxy *proxy);
+
 static void endpoint_unregister(void *data)
 {
 	struct endpoint *ep = data;
@@ -2918,6 +2923,8 @@ static void endpoint_free(void *data)
 		free(ep->preset);
 
 	queue_destroy(ep->acquiring, NULL);
+	queue_destroy(ep->links, NULL);
+	queue_destroy(ep->selecting, NULL);
 	queue_destroy(ep->transports, free);
 
 	g_free(ep->path);
@@ -4887,6 +4894,7 @@ static void acquire_reply(DBusMessage *message, void *user_data)
 static void select_reply(DBusMessage *message, void *user_data)
 {
 	DBusError error;
+	struct endpoint *ep = user_data;
 
 	dbus_error_init(&error);
 
@@ -4898,7 +4906,13 @@ static void select_reply(DBusMessage *message, void *user_data)
 
 	bt_shell_printf("Select successful\n");
 
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	if (queue_isempty(ep->selecting)) {
+		/* All links have been selected */
+		queue_destroy(ep->selecting, NULL);
+		ep->selecting = NULL;
+
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
 }
 
 static void unselect_reply(DBusMessage *message, void *user_data)
@@ -5170,9 +5184,7 @@ static void set_bcode_cb(const DBusError *error, void *user_data)
 
 	bt_shell_printf("Setting broadcast code succeeded\n");
 
-	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
-				select_reply, proxy, NULL))
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	transport_select(proxy);
 }
 
 static void set_bcode(const char *input, void *user_data)
@@ -5197,15 +5209,35 @@ static void set_bcode(const char *input, void *user_data)
 	g_free(bcode);
 }
 
-static void transport_select(void *data, void *user_data)
+static void transport_select(GDBusProxy *proxy)
+{
+	struct endpoint *ep;
+	GDBusProxy *link;
+
+	ep = find_ep_by_transport(g_dbus_proxy_get_path(proxy));
+	if (!ep)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
+					select_reply, ep, NULL)) {
+		bt_shell_printf("Failed select transport\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* Select next link */
+	link = queue_pop_head(ep->selecting);
+	if (link)
+		transport_select(link);
+}
+
+static void transport_set_bcode(GDBusProxy *proxy)
 {
-	GDBusProxy *proxy = data;
 	DBusMessageIter iter, array, entry, value;
 	unsigned char encryption;
 	const char *key;
 
 	if (g_dbus_proxy_get_property(proxy, "QoS", &iter) == FALSE)
-		return;
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
 	dbus_message_iter_recurse(&iter, &array);
 
@@ -5229,11 +5261,10 @@ static void transport_select(void *data, void *user_data)
 		dbus_message_iter_next(&array);
 	}
 
-	if (!g_dbus_proxy_method_call(proxy, "Select", NULL,
-					select_reply, proxy, NULL)) {
-		bt_shell_printf("Failed select transport\n");
-		return;
-	}
+	/* Go straight to selecting transport, if Broadcast Code
+	 * is not required.
+	 */
+	transport_select(proxy);
 }
 
 static void transport_unselect(GDBusProxy *proxy, bool prompt)
@@ -5247,7 +5278,23 @@ static void transport_unselect(GDBusProxy *proxy, bool prompt)
 
 static void set_links_cb(const DBusError *error, void *user_data)
 {
-	GDBusProxy *link = user_data;
+	GDBusProxy *proxy = user_data;
+	const char *path = g_dbus_proxy_get_path(proxy);
+	struct endpoint *ep;
+	GDBusProxy *link;
+
+	ep = find_ep_by_transport(path);
+	if (!ep) {
+		bt_shell_printf("Local endpoint not found\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	link = queue_pop_head(ep->links);
+
+	if (queue_isempty(ep->links)) {
+		queue_destroy(ep->links, NULL);
+		ep->links = NULL;
+	}
 
 	if (dbus_error_is_set(error)) {
 		bt_shell_printf("Failed to set link %s: %s\n",
@@ -5258,13 +5305,60 @@ static void set_links_cb(const DBusError *error, void *user_data)
 
 	bt_shell_printf("Successfully linked transport %s\n",
 						g_dbus_proxy_get_path(link));
+
+	if (!ep->selecting)
+		ep->selecting = queue_new();
+
+	/* Enqueue link to mark that it is ready to be selected */
+	queue_push_tail(ep->selecting, link);
+
+	/* Continue setting the remanining links */
+	transport_set_links(ep, proxy);
+}
+
+static void transport_set_links(struct endpoint *ep, GDBusProxy *proxy)
+{
+	GDBusProxy *link;
+	const char *path;
+
+	link = queue_peek_head(ep->links);
+	if (link) {
+		path = g_dbus_proxy_get_path(link);
+
+		if (g_dbus_proxy_set_property_array(proxy, "Links",
+					DBUS_TYPE_OBJECT_PATH,
+					&path, 1, set_links_cb,
+					proxy, NULL) == FALSE) {
+			bt_shell_printf("Linking transport %s failed\n", path);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+
+		return;
+	}
+
+	/* If all links have been set, check is transport requires the
+	 * user to provide a Broadcast Code.
+	 */
+	transport_set_bcode(proxy);
+}
+
+static void endpoint_set_links(struct endpoint *ep)
+{
+	GDBusProxy *proxy = queue_pop_head(ep->links);
+
+	if (!proxy) {
+		bt_shell_printf("No transport to set links for\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	transport_set_links(ep, proxy);
 }
 
 static void cmd_select_transport(int argc, char *argv[])
 {
-	GDBusProxy *proxy = NULL, *link;
+	GDBusProxy *link = NULL;
 	struct queue *links = queue_new();
-	const char *path;
+	struct endpoint *ep;
 	int i;
 
 	for (i = 1; i < argc; i++) {
@@ -5272,35 +5366,36 @@ static void cmd_select_transport(int argc, char *argv[])
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
 		if (!link) {
 			bt_shell_printf("Transport %s not found\n", argv[i]);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			goto fail;
 		}
 
 		if (find_transport(link)) {
 			bt_shell_printf("Transport %s already acquired\n",
 					argv[i]);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+			goto fail;
 		}
 
+		/* Enqueue all links */
 		queue_push_tail(links, link);
+	}
 
-		if (!proxy) {
-			proxy = link;
-			continue;
-		}
+	/* Get reference to local endpoint */
+	ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
+	if (!ep) {
+		bt_shell_printf("Local endpoint not found\n");
+		goto fail;
+	}
 
-		path = g_dbus_proxy_get_path(link);
+	ep->links = links;
 
-		if (g_dbus_proxy_set_property_array(proxy, "Links",
-					DBUS_TYPE_OBJECT_PATH,
-					&path, 1, set_links_cb,
-					link, NULL) == FALSE) {
-			bt_shell_printf("Linking transport %s failed\n",
-								argv[i]);
-			return bt_shell_noninteractive_quit(EXIT_FAILURE);
-		}
-	}
+	/* Link streams before selecting one by one */
+	endpoint_set_links(ep);
+
+	return;
 
-	queue_foreach(links, transport_select, NULL);
+fail:
+	queue_destroy(links, NULL);
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
 static void cmd_unselect_transport(int argc, char *argv[])
-- 
2.43.0

