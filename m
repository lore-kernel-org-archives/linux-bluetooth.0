Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847F13AA35
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 19:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732129599; cv=fail; b=dmHpFpJevuHvsy7H9zwJTIdR/NaXw+8b470gvWDg4XjpBRPgJcjrmvrj45c7i2+HMJQwnUomzQbU/QHChDviK3o01JORSCzJ7gRyMSTzeLJptl+vh2d0NqiJVJEG/436NoMdxdeNe/6XNaASrbpjSfum9+XMuP4H3iamuhBZXag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732129599; c=relaxed/simple;
	bh=mtX1jhOHBWSDhhdFcEB0fwEt9kdDMESsFCAHR404rek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DUsNRRcNUixFJqNfxdT1nZIuC3fHEgIzGp68jA5vBQeMa7+UbwdfxaUh4aRu/TamOFph17STr5jMlFBG1y7Zb6qIig4aMP1mndBGObmfWexVmq6Ok6Cs//RrR7UPL00BcDSRuagv9axl0q3Cv1wqs0awsTmZ2d7VO8bbV6pLTx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=pK0mtJAR; arc=fail smtp.client-ip=40.107.247.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="pK0mtJAR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnSY9zrMj8leB3UDLFuHkUvNI162yLrn4TxFcpozqdSyD1TpDZZ4qplt6wKtROeBipk4XsoNMRQns3kGlbe1jn2JqCLUI6/wapm95B7hwJL79EUmlt3/MBJnyO4RGMuZwj3f83IaaVlLOyQirU09TdJBnVGmkcxEU+KlGyqhh/oJTkTPWjyxKw+tBD2B7R8mwqCwHD7S/+gyEmds1HysSJ/5AOXZspdGAw8HLhLMG5W8K2k84uUDd/LpO++fX3SNCj9B/XhsU/WE3+J1D39Wiu1yV2JgSdBb4Lv2dfM7keXCySGeMPCa4+1IRttJjrWT63W1fcVw+tXfM0vi9FTC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5IHSbJJnQV0plzRkgPxJsY/TQD98H+Ays0YgubQB+c=;
 b=C1KJOQKJ9g+5AbKSmJtcWd+y2wEQNKOOgZjOJ2o/jCnzza3IERTZWRHUN583xw2tT4PIQZUrrzgM62EzYMTWCn68xN+hDGtcbS72lF/XHKacEPJM/TM/CExnGEzFXCRHf7xTUrZtCejdO1WGg+0E1McHOLlFMZrfxzXPEwGdoo22cJdjVIxFT8BF40StfgTY1A64nssTsH9Kww8JFP6Pj098bMiSIUSjCS2f6l4j1xAI8wu9uyjSBMAt/si4GkNu0dn5FTKnSyZfJreANimocoaTQO20a7C2o480Zr6FGac/MidEtAXo6i1zDMEoDkfIz0/cRcHtl4PvkACTQp2rLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5IHSbJJnQV0plzRkgPxJsY/TQD98H+Ays0YgubQB+c=;
 b=pK0mtJARckA64RxTs4nzbRCvwwFNvOGPS9GxXjwqvGLOS9T+LiMmzdpkW3j1UPcUKEW2RCdQyzhyRy7NzrEttQJzcizlL76KfCj4/FRnUwuiVxyV83+7ftNOGQhsLb9/Etx8R2qbOwktfRxSki6mDtH713ltHhgAQl57vBbIwQ4=
Received: from AS4PR09CA0014.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::17)
 by AM7PR07MB6438.eurprd07.prod.outlook.com (2603:10a6:20b:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Wed, 20 Nov
 2024 19:06:29 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::a) by AS4PR09CA0014.outlook.office365.com
 (2603:10a6:20b:5e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Wed, 20 Nov 2024 19:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 19:06:29 +0000
Received: from n9w6sw14.localnet (192.168.54.22) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 20 Nov
 2024 20:06:28 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
Subject: Problems with LE advertising when powering off
Date: Wed, 20 Nov 2024 20:06:28 +0100
Message-ID: <2260310.hkbZ0PkbqX@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|AM7PR07MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad14e75-cf43-4b99-2518-08dd09967061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDYgWzJw9AXnyYq0NhmK6qMEb+NFne+WD5fVe/sLkU4fWsqbYcxMMCbvlQAC?=
 =?us-ascii?Q?yrdNbWfXEmStvKq6FMsWAZIcmTBl4Jhambg881K8ECSsmSuyuCOKbawriAlT?=
 =?us-ascii?Q?WaciEaq+LI0mpL0Q8pCuuMI2L4hh0PDSZNueR224kWbqY/AgJrDoP/yt/7oY?=
 =?us-ascii?Q?PpYhZoMsYu6HlJe61jaqZkxpyEji/dNBDF8M7EIK4j7iIFf99kTGaH+mxskG?=
 =?us-ascii?Q?16RQ37wjJIC6Lc25ClVRAG/cLRc+fzJzmT40+97KTVEHkf/CWdTNtgG9fF9c?=
 =?us-ascii?Q?qzJDHGw6lJX7yv5GqOpPV6xxIRFsUBNncXNoKc/qvymRfNmlxIqioAjo8bjm?=
 =?us-ascii?Q?JFCo1Ony0ThC/Rg0utai+bIOn+WyV+acPtVw7/oJppoN/uLwHiF3IrFEgH2S?=
 =?us-ascii?Q?l7Ut5+/cNLLjURmBBv3O5Zk/tnCl7gVryP3oEr+/DBDWrQK8mU/Zjh72+SEH?=
 =?us-ascii?Q?ToesgBTt7mq/XwzqiE5rZytJzyZsn3W5Qalw5JNKYf2AKekbnw/sebKmqdh+?=
 =?us-ascii?Q?iMlbGLoVPu4dHRvpGAwU7T96Xg30nBYubi++6OF3MDJt8MD6jCFBpELEc7Wp?=
 =?us-ascii?Q?b9j4bvNsCZk2XdJz5KCwCds5JBS87YkrZ0JY3RXkL5tUq7duM64NbWk+/m6F?=
 =?us-ascii?Q?zgtFVaGjRHroLyPKrV+RBy65lwIOMo2zVU6Qzqj5fbpfn8K6yIpdtRkE+h5u?=
 =?us-ascii?Q?ib+g0oUNkZzf4jwZD9UOhvlv+PKXrSKgPDe2Rch5DRXaijNkP3bB+2nHY8KF?=
 =?us-ascii?Q?Zydvt81nWGBpsrAeZSB6uKjEslJ4KbxCMMj/GHHPVFzlBASG4wpXxJckhUKv?=
 =?us-ascii?Q?WbmGgJxA39QQjD2oko9q9xMW+y9n0Q8nNBriFOJqzWNYDW+8/l/SpvBu7eul?=
 =?us-ascii?Q?LjhK3XgBhpmt2rHtxLIZ4Cu1zfU87vgcNCi6DvdqoSeuyX9NLsZFDHsGUVwz?=
 =?us-ascii?Q?3dtiHVDSad2yJr8YDDM6++9+vJHu/bAXnfkkpdlC1SSWSEo6TzFe9IEsEj9v?=
 =?us-ascii?Q?rnxMAIDUA1izz/j7LppRh3HvFAdOaBRA9vexslJaeJoYtNsdU3Mm+R+w2YcU?=
 =?us-ascii?Q?fyiRvN1sGEMhPFngrgxILytqrBZyr02Fr+wsUpjvuO3aMgtSrWCAUJjliU/G?=
 =?us-ascii?Q?SB8YoZcWgbvv6YiBwK7XhpQRuBW4rUTL+55n75c3NayKSCnyHnxc1S/nsC4q?=
 =?us-ascii?Q?YNZ10IsU0OC2URMbnRUPKWDA+QxR2t6x2EnIMMzydid1CrhMCkbRBQ83MrUn?=
 =?us-ascii?Q?LF7aFM/f25tXxNGfXt9g1ROhbUz+ItlAuyIPLT7grZCCE3Xi4a+J1WfEpu77?=
 =?us-ascii?Q?kco0M41PG+USGpHLJ2ZBVlWO5xZlrrR40N3AMx2BuJXl9nwYmPc7cM7aq3cS?=
 =?us-ascii?Q?zi4zbyGBZo6+eWr6/V+/VNx6Jg00S/uWr7vFqscIvdDl1H+LFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 19:06:29.1168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad14e75-cf43-4b99-2518-08dd09967061
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6438

I have a regression with my LE advertising after updating the kernel
from 5.15.x to 6.6.x.

At some time in the past I came to the conclusion that my Bluetooth adapter
(TP-Link UB500 with Realtek RTL8761BU) "forgets" all LE advertising when
powered off (e.g. by "rfkill block ...").  Due to this thinking I registered
a D-Bus signal handler on "org.freedesktop.DBus.Properties.PropertiesChanged"
and called "org.bluez.LEAdvertisingManager1.RegisterAdvertisement" (or
"UnregisterAdvertisement") after the "Powered" property of my "org.bluez.Adapter1"
got updated.

With Linux-5.15, there was no problem removing the advertising instance
after the HCI was powered down.  In remove_advertising(), the call of 
hci_req_clear_adv_instance() (and then hci_remove_adv_instance())
successfully removed the instance from struct hci_dev.  As the
HCI was already powered down, no attempt was made to remove it
from the controller hardware itself.

With Linux-6.6, remove_advertising() calls hci_cmd_sync_queue(), which
checks for HCI_RUNNING and returns -ENETDOWN.  So the advertising instance
is neither removed from the controller nor from struct hci_dev.

When I power up the HCI again (by "rfkill unblock ..."), the BT stack
tries to "update" the advertising (hci_powered_updat_adv_sync(), called
from hci_power_on_sync()).  This fails then in hci_disable_ext_adv_instance_sync(),
I get the following output in btmon:

< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6                                                                               #257 [hci0] 55.116038
        Extended advertising: Disabled (0x00)
        Number of sets: 1 (0x01)
        Entry 0
          Handle: 0x01
          Duration: 0 ms (0x00)
          Max ext adv events: 0
> HCI Event: Command Complete (0x0e) plen 4                                                                                                          #258 [hci0] 55.117040
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
        Status: Unknown Advertising Identifier (0x42)

The kernel log shows "Bluetooth: hci0: Opcode 0x2039 failed: -38".

When my application then tries to (re-)register its advertising,
I get the following btmon output:

bluetoothd[408]: @ MGMT Command: Add Extended Advertising Parameters (0x0054) plen 18                                                            {0x0001} [hci0] 55.260267
        Instance: 1
        Flags: 0x00010003
          Switch into Connectable mode
          Advertise as Discoverable
          Contain Scan Response Data
        Duration: 0
        Timeout: 0
        Min advertising interval: 0.000 msec (0x0000)
        Max advertising interval: 0.000 msec (0x0000)
        TX power: 0 dbm (0x00)
< HCI Command: LE Set Extended Advertising Enable (0x08|0x0039) plen 6                                                                               #261 [hci0] 55.311447
        Extended advertising: Disabled (0x00)
        Number of sets: 1 (0x01)
        Entry 0
          Handle: 0x01
          Duration: 0 ms (0x00)
          Max ext adv events: 0
> HCI Event: Command Complete (0x0e) plen 4                                                                                                          #262 [hci0] 55.313950
      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
        Status: Unknown Advertising Identifier (0x42)
@ MGMT Event: Command Status (0x0002) plen 3                                                                                                     {0x0001} [hci0] 55.325430
      Add Extended Advertising Parameters (0x0054)
        Status: Failed (0x03)
bluetoothd[408]: = /usr/src/debug/bluez5/5.72/src/advertising.c:add_client_complete() Failed to add advertisement: Failed (0x03)                                 55.329010


I guess that all this happens because the controller has forgotten its advertising
during power down and now there is a mismatch between the entries in struct hci_dev
and the controller. 

Is it normal that a controller clears its advertising entries when powered down?
Who (kernel / application) would be responsible for "restoring" the advertising
after the controller had a power cycle?

regards,
Christian



