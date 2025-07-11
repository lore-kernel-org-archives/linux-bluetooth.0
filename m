Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B8128395
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271262; cv=fail; b=ZeJxsgs35tR9C/9T3cgPMzI61LR9hQtrMguqbfpjtl/GdFnYkDf6j6aYLi9NLlwq4svUTVVl8B8Z0iCjVuPKBxX7jTD33JrWsLS13TkQI20dajKSCr6onaIEKm6BXFKoo15amNc+7RqYS6O9smo9NxeZ7Zy/3SwdOzanSMmT4fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271262; c=relaxed/simple;
	bh=TS5wHOnGE/8KCm+sndY4MovtuTFdIfrUN9Q5BbDxWTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clJ1G1aZ2WTzZNUM3ygtk4S6aFwpqEOqyi+PxTlJJNEAr4FSqfN8P39Fhw9AsHixiJnvfWbD0yeu5xHnhuhLWjM2QxM7BhytjAuBlQm+zMZFBYL6gfRf+DSMYn1iIL4jcyJRtYGOciik/usZD8dsQ+yPRSyN9v5vFmqiZV4qLLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=iGrrGuhR; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="iGrrGuhR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APt2j1x4OMwYxB3X9Lq1qBtGMmPuPYBBtltqeteFFDQU6wRvho46IsURFptKN1a2y06UuTPzK23Juxps5RtU64B0iLRBb71xEtBHD6M2c/Z58/AoI+F1EHYHlwGdQ6sxYt/98tLi8jz8XKo3LdkUdEhZFrry0E/8sFJsCiw+iygEr37SIgBf8WMPxOgtIex8VA4BXG+CIuJShCYGie9ngulBsWWcTUoDhv3xDLpdd5tV/8o3ApF4nZ60ywtXpPnecH6RpZLNh4E00ZYSVse3TVQoMv5xxZBwXfzvd/ZWR4eo+DhOopqwdXZlTJrn8zK1G11xjOf3KZp41rynGDWsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmV0K+gA/VWKjqRGNjUQRTDayHHEdaVrKmk6fQu/CGQ=;
 b=CBUmWc5WiCS9gNAPobDY6gd0DZqKg/ivhzomUpNiVeEWfG0cdolCMpgdGJjr+J7MNuSkkC6BUi0tj2LgHzQIUyBwLodUzGpaOBRwOKD43xQFAMUdwxRMhUPT9Yv6T3GHih9Om8Gd/X8aGkHG07b8IkW1yzRlzvWPgvoJPRPPoDaEj4tUvEiVUf5giwhbcBbREEPyaFykAhIDFI/MdcmAB6LfYChoqKdoP3Kz8pQGe9OGgY4karImEatD1FiARGBuHd71qHhIhWUs7NfExheyhDU4L+zUCIrTv3XXm0/whhiuSrhMh52Uxjf6HcdZw4RniJt7zSkOCfU+dhOp7/Q/xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmV0K+gA/VWKjqRGNjUQRTDayHHEdaVrKmk6fQu/CGQ=;
 b=iGrrGuhR4UpeRVKk6qZpeD8HdAp3mHi3+VnQoi1BzPRBxyRCO1UYw4gKw4mELB5UFbet2fS/p4RNTzb/Qo+ZHDsUWo+Ws/NVtSbyJqNQ+PwLIPyOaRteDaLH4fg7UyscWykOWqwGZhr/8Vyhi8H6H5toLNeaRAMYNZipdHhxuFI=
Received: from DU7PR01CA0010.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::23) by PR3PR03MB6364.eurprd03.prod.outlook.com
 (2603:10a6:102:73::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 22:00:51 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::2d) by DU7PR01CA0010.outlook.office365.com
 (2603:10a6:10:50f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:00:50 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:00:49 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH Bluez v2 0/9] mesh: cleanups and a bugfix for relay packets
Date: Fri, 11 Jul 2025 23:57:12 +0200
Message-ID: <20250711220035.10065-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|PR3PR03MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7c44ee-be5d-4196-476a-08ddc0c6662f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lz9DqxU8EbErBPkj8l6h8cj94963AQQN7KxEuKve7FdrhS4llcMgqL/Nbtln?=
 =?us-ascii?Q?bl+jI3ol3S66M6X9BE1+WmI9ixDTcpPOZCgpNmhQnkvxLMMHCjmNiEJcUq/6?=
 =?us-ascii?Q?QqutdNmm6hfp6VIik8qYe39iu6iIFLC/Zlc7dhzTeQ2nmXi7JqMVuq0UWp7E?=
 =?us-ascii?Q?LWD7YHPaVlo/0LiUazv+JJl4IcLAaYhoiD5/j7q9oLrIxyRSQEaJyF/AS54A?=
 =?us-ascii?Q?8CP6lvLdWTd9uUY0vq63iFqaeCHTfstXxOWJ5nccrhCxjlp7Br27h3EZMoNl?=
 =?us-ascii?Q?TjJKUykDG3nV8NtXPqgj+SoecQlHhDyth7gURd5qVbZmsViJepiecYJpoLtC?=
 =?us-ascii?Q?CFjLnxT+Wko8LvN9FEMwotfRUO3HwdS+3GdmzJcqtydiUFO+TqobzN3OWBGl?=
 =?us-ascii?Q?GWczr4WBO7OIAO9D0+Ntf4+8l2UqEiZf/t6nmyZchyOFdoGysIaI50mPR88d?=
 =?us-ascii?Q?Q95fgtFx+y8Y/TQmC9l8V2YzsDl9vQwowhh4Br/ngMzUpTAasXst1qvdDAHW?=
 =?us-ascii?Q?pPTc1UlnR9P8lPu7MPJjFC+Q/K/9b8+Drm2+hN6kgtf2gxs7dyoxx5aLlOzS?=
 =?us-ascii?Q?TeQTS+fOlgVwiG4YhlVbze/w5iQlikv2WNuP5NY+263JYgrwNMp9kcdDtZBA?=
 =?us-ascii?Q?zRwXeR2Z99tp9fUxwsOViMuKJDftDqY9GmOlPC+oek2j3cxiMzzzjY1wntpX?=
 =?us-ascii?Q?xah8FU0Mvl0YfimBXIZayu6UG95VDCwfSmw9Bf8txRwCwk1UbaCC3eutuY5Q?=
 =?us-ascii?Q?G/Gsyy1QCSEsIUSSddtVZdL5xlKFeIzyNziY1v/s5bq+gbmIMJmF8lFiygzp?=
 =?us-ascii?Q?Vh4wRjGIKidU2trqjBgptn5P8EUEb9EMkqXlVOv4umrFQ7RxK+3AG1gJGEd+?=
 =?us-ascii?Q?L7eGi9/KGm/Kn8xCTEudE7KGc6YLg+wffdr/vTFu7aQ2L6w1wSS2YevSB/m5?=
 =?us-ascii?Q?6NJ3hycafNPztWPydELgHShqhedKwLh9m+oO3vt5RxLW8dsowtLLdnh6ahWq?=
 =?us-ascii?Q?lX8UVFKnl5HmK2ACQqcFGTJolYS4tUyYtaA2ytdICheV69BBMsy0PbsEMajd?=
 =?us-ascii?Q?G70kuRRRJ3OI4Gw5qr4qXEJxgl83kDEmjvIOXEs6gKmdu41SOCgkBqitM6iY?=
 =?us-ascii?Q?sMhLY34tvRHjdbDXYEIHzmMLDsVS2HzWmgOTNH+1C7PO0SgXxuTJc3cuImsB?=
 =?us-ascii?Q?v8PoUTo0Zh9Vo7lJnM3VIr0tAEHVzzdL/LQ7DCeeOqmCuv5XdAnj4Yp3JFmn?=
 =?us-ascii?Q?NbtTh50W4ZX9mioyo1/B3ELbTVzlZrmjc9K8PuH1laW/cjKPc538psxalRtp?=
 =?us-ascii?Q?vxiIEJadboPOzdIVZQuxNqKODklIlXAqT/1f7whqhDmDhNtZy0ffl/LP2lzu?=
 =?us-ascii?Q?EU7QBe/95L0jx9xM73oDaoZWvc9NhtSrPIBNHbAdOkdPhtjoGdvLOeTITCtF?=
 =?us-ascii?Q?Fb/QMFaOIDmfBm5m4UjXSQOgZuGbd9euBjwScvA8838JPVehHQT6rI+kSttm?=
 =?us-ascii?Q?hLeHW2uFjeK1rYdjkaFhGjNNT/nRXnlGaWsc?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:00:50.5353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7c44ee-be5d-4196-476a-08ddc0c6662f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6364

The first 3 patches replace further magic numbers by preprocessor 
defines (no functional changes). Patch 4 tries to improve readabilty,
while 5 and 6 are only cleanups (these patches have already been
submitted in my previous series, but were not merged without any
notice).

Patch 7 and 8 are further simplifications/cleanups, while the last patch
fixes a serious bug which causes corruption in all relayed packets. Maybe
this NEVER worked correctly, although this is a major feature of 
Bluetooth Mesh. At leat this one should get reviewied by a Mesh expert.

v2:
- Fix declaration after statement error in patch 9

