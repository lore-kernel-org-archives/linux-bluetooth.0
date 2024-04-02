Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2130.outbound.protection.outlook.com [40.107.15.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69F92032C
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057980; cv=fail; b=eNGSA7EwZxqhf88kSOsxuycLmpansXj1zAdvUe4DhJ7HFSoekZ5XD9LwiOpRLRupef+4FsarlLGpYI0lDnY6HUsB7MW3SUxw0Tm+81rCbjuUi9Dcy5IwcvZXfsKtDO4W/+QkCC2MxTPZNLNHIOCSWSgvxEtg813InnXx4iL2fJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057980; c=relaxed/simple;
	bh=yJpcmKfRPXtlslRBc3JNzbbLuUaB/Cpb/BQk1Lx+HL8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PAmmfIhuqJEGhnQA9d7P4s7GiQaSr2WeN7gInf/3UDxQG10KTdH5Rx1V6O7c9PcGn5pjNqYgbCMHSG04TfXWkAjdG64SCQmrS4bqyuelHF+s0KESRADmomQZ4XctZXHRRfVjuYkPMUh86N8nn+VjgaK+E8A6o4niXqvWDYeELlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fjIrGUdz; arc=fail smtp.client-ip=40.107.15.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fjIrGUdz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFtLs0E0LIQMe6lsFbwvU9CBg/BOECiXi0dxuu+V2dOCtWE16nP7pGvOdMNu0h59yc0EbSpgSzqX0e8NCT2XI6r0XglxQwN3jSEJazHSC7IFq8one3kmdrtISVUkBanNlw/DdJmL4xF4pbccOBUZqody5cHhWsdrVOpON8CU2BEe0K7iIvehbEy8vrUSgpzmYblb72YqYApTet8TeWFENho3g2q3XYmunL7CCpX8RDfpdti36por0NmXumMNkE7yrEOB4vNRiwj3xZaBOZyMpCG6ndxuUHRnFLAyDTU53gUhMAG3tGCrvNBCaMWiob+bYkIR681aA7Y2C44Adwtehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kxp22Y3XVN/yRQI979HmJEQ3CJ5mI4dG8gWU98e02yA=;
 b=CCWblpN3aIBrbtu3g4ezDMjgVc/Gex1igd4Vgj5RI5wJ7SXXiMAo1yib2MS0LB+WtzrR5WbBS3CwOq77VpaWsZbUu0UQGqtv+9s6GQq3Ogth47LkxK2GwJ7us+rlyHywAs/HIUpK0iiCcbZFp+EihOJUFf0mUksujreEaPJo6nLAk5mXECB2NzkGl3utKokwh1A3eMg/Ks4rF8InoLGdorDV/3gptO98A1jkUvkmQCO3jHaf/mW5CjyG6IY10jaMGbFGXf59YXWajtVG+dFNPh8oHegYmsWIsZ5wvObSRtgGaOsw+ikwqMfxj5cEwPFYlZOxcESM35Ae4/gJw3kHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kxp22Y3XVN/yRQI979HmJEQ3CJ5mI4dG8gWU98e02yA=;
 b=fjIrGUdzyv3sklaHVleLVQMNnPuaZBoKay1ukt+Q44duG4+doPoZqMV0Apoo+q6/E9a86gbc4urUu2P9GGSmcc3AvBvr06r8kfgds3AyZ5Gydb6lDy2OVQI2oQRaVt66SJuAG/La57hr6ISNEgVhv090r/8yO72lYJkWlf/VIAc=
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:39:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:39:35 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/2] Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated
Date: Tue,  2 Apr 2024 14:39:29 +0300
Message-Id: <20240402113931.3164-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0051.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hePBPghjaZQ/ebd1Oe9K3F5+Wqxxs1wJ8ukEybn6yfaa6WLiasZLpTELY0mdAeiodzc+cG7tU1xvVH/kPmcVTFZQJPLB9kYQApCxDtnb/TVuEcuqJa/0UR4JnMJyclRTix9Q6QU80dbkU4iJISFb9YI+g6ipMjkhnbeH0OCriIglnlZxm44YcNQjuwPzCNd0Px6VM1OjvNUCeAyueLt27ThldbOqrqmObR3X4Yl93ovfdW/lhMspuow8EdLiztFqVM0QdeVRnupe0hkbXY9RzanphgIfWSn/aKAoyOaSjRIt7u8erlD1+OX4Y249JyN7IdhARIeJoWrdiJzfet44XqiLpx5pOuzYkvO+oMALSGQEyrIQTRc6j4anZnSdItHXtf6pBClb2LW00mRbaxsB0Y1nS3xcYsRXAPpOkEaW8Csi+3YEzWyYHEnOtLXDmKqeQu6Jl6p8H8pVA5ioMkVCpQP1OITCNsVxXk/I4opv4pSbWwKVSbzztBZTk9sQDYVSYOuvMc4Z5hXXT6JxxW7p35Nh96CQ6RiDlsN1rGSa98J2RVZvSK668jcWV/EMEeYlBh7P/RHWXXPHLtIQJIRKp5XkBhFJP0t56l8gx+AkI5boeizhHQ5RWjH+WMiohW8ISFh+4m/mkRaHwBuA+gPxWlBtqC0ibRa6zYkPA1w1fpg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sHP7uX1Gi9OF2bHjIe89OKNvGr0L3KOwysppwaToAj497LsTbnOf7BWp5DnY?=
 =?us-ascii?Q?BYkyDsn0DUzzwLf7MnbWjbK5wLIbEiLfjxjJl2NJ5nNwnpONMwUFJRpxqU0B?=
 =?us-ascii?Q?uBglGAwiwa2GA7CdYKiChLdcvCI4mILz1YW2eR3urF/ByzxpfPtOf/CfpjNv?=
 =?us-ascii?Q?4qIjkNMfdIIAYq3mT43yp48TNB4eoYyrJelVrIoj4Q/IMmcuYzhsJiOn4E/q?=
 =?us-ascii?Q?SaSTBi575t/pG0Yj5X9FNe5cIaGhIZumydBHngP/E86pa80eGdCTHPmdE3tN?=
 =?us-ascii?Q?t7kKZ2vQOzvhOflQT19B3L5BEmoB2VCsqA9HKULrBc10kNFb1HgqHHy3WI0W?=
 =?us-ascii?Q?7K89aioWSRFNgGBvp1TKU5nNDR1dgxhlBDhCExD2cuuV+slw745iN37WRAUd?=
 =?us-ascii?Q?viNIxxwUyaR7bLNa7I1+AYD6j7IjFNrEMi8E1Kna6922Joq6Jbmm+MM+9Jrm?=
 =?us-ascii?Q?epIb2c0Fr+0I9DYsKsZXLdfAHchuirB0ykUBDrX0BdivV/cN2PeCKpD8pcB0?=
 =?us-ascii?Q?yfk927LkICK+zCflVjb4M1WhpJ4xYq4R/2FJTejqMXxGIhJO8e3M7jAMDSbh?=
 =?us-ascii?Q?XYcl4CGCtYPXXT2wRjMwNDB0aRY17XtfwBJ9N6y0k2Ga3pIfBpUxcEUofUIM?=
 =?us-ascii?Q?5Gw4ZqurOuF5C8EW9jpQnRC/9iZu6hc3BkVbB/ToJjFAskk8LGoNf8nmROtR?=
 =?us-ascii?Q?Vv4bXHsRcIYrHVPZUkOVOhkPNypVkGOZ54vQTxCzBTWbldx9ONKkU5XZ4V+8?=
 =?us-ascii?Q?myw1Plho8RFmj73g5SJC25vTRh/gqMqhBAOP/mb3SgkqUU7ozHHIAfIq2Ywd?=
 =?us-ascii?Q?AMweK8u2o5JZ83TQBghyJVWXo93R6OgisEzJzgyWkxGZ6s3ByFF6Uhd+WLJU?=
 =?us-ascii?Q?CATMA2EvAvU7nHYVrnd57CrIX2kZghN6sKMt/5niFY0EAk5ZMUAgrJi7NgM4?=
 =?us-ascii?Q?pYZb8LxfDZzrjrClJT9ScYElSz2XQgOwdgFW+KMYqUdT6vtJvQZlwU4njEmG?=
 =?us-ascii?Q?33K70VFhi4ErDOdSqey5F7JpzYpOFGpKQFUPf24X+PI8tUD5R5E4+cR8a6+i?=
 =?us-ascii?Q?lbUYxMXGCZ/LVQAgOKBUNbd36eR7C5Svj5ce238q/u1hKm/djx1Y8rkg9J53?=
 =?us-ascii?Q?XlO5RmcdQnmRn9Gd2Ium3IpXGgT2dQl1ITVMHL05kLCuxtWOO1J6R7E38JD7?=
 =?us-ascii?Q?GZbLXBzsniQzjnTXfxgTXUMOs/gSJJ10sJj8Y6JxbgSFmV/jOXNzhzBsV5HF?=
 =?us-ascii?Q?Yfy34itpyL6EPqgtk6ahPpex5tviq4maJaicS/tLcZDhM5BPf806uqwQxhwt?=
 =?us-ascii?Q?XlJOg6/2vaENqP7Yr0bL7ONykS7R/YnJixm9bHmcfRL7A139MQYr3sdlTzzZ?=
 =?us-ascii?Q?VswPM4xmxNUkBWf0SynSjzgH+T6E52u+c4OHjZvEFo+WYvN0DOxvmGvoDSh+?=
 =?us-ascii?Q?NAP8IC9/DwR3DdmGPjVPpL4/iS13vmD+I940DdsGZu9gQ3GQjL/TLsPBHtER?=
 =?us-ascii?Q?1jxnYPC9aKmteFhcIF1Sik+jlvQQivbYLFqBFa1PAeRwCjuLBgaO+PTcaUWh?=
 =?us-ascii?Q?yYRu3pFIe0W9dwwAFOqS6grqu82hKhvjSrAW6KSz8u5Ka4MY5l7+2C6enwci?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeeccf3-b512-47aa-d213-08dc53099277
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:39:35.7914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rw/gOvHoz9LJ5p57Ou23QHQESZeq1stkwFnC1mMIq2ap0Ku0wQrrgWUf4ARcZuL1UumbcXjw6Yso+hc5hW50iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

In case of a Broadcast Source that has PA enabled but no active BIG,
a Broadcast Sink needs to establish PA sync and parse BASE from PA
reports.

This commit moves the allocation of a PA sync hcon from the BIGInfo
advertising report event to the PA sync established event. After the
first complete PA report, the hcon is notified to the ISO layer. A
child socket is allocated and enqueued in the parent's accept queue.

BIGInfo reports also need to be processed, to extract the encryption
field and inform userspace. After the first BIGInfo report is received,
the PA sync hcon is notified again to the ISO layer. Since a socket will
be found this time, the socket state will transition to BT_CONNECTED and
the userspace will be woken up using sk_state_change.

Iulia Tanasescu (2):
  Bluetooth: ISO: Make iso_get_sock_listen generic
  Bluetooth: ISO: Handle PA sync when no BIGInfo reports are generated

 include/net/bluetooth/hci_core.h |   3 +-
 net/bluetooth/hci_event.c        |  58 ++++++------
 net/bluetooth/iso.c              | 149 +++++++++++++++----------------
 3 files changed, 106 insertions(+), 104 deletions(-)


base-commit: 2216e1eabc7ca013eb1e8007846253dee72dcb76
-- 
2.39.2

