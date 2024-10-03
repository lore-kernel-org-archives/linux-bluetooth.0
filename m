Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8221A3AA7;
	Thu,  3 Oct 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970260; cv=fail; b=hjyMPw7fzacihlQlHBWqgN1wCibW//Wp/D2CBQzb8/HsNPI3IgxpQq4RSlJHKZ14hLL8+qR/rmUUiNOwKy+0Zvb2OwOs4peQRop+5j+YfOMkxHkUk5fkpU+dPr/S0e5E6Yq/EoomYWHVvEv0PD5wu/fWDYg9Bw9eQxYhOlIeshc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970260; c=relaxed/simple;
	bh=nr0YUaw6osCxBu2G6zEx7EIccSaapA5eX9ZlztpZz0s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FnBpbUQc2HHvZMFH/QjywKdmCgOhJ1HNtwVytyqshFQwbV8Tdx3EeItFAuFLYnuYJGCzUVfTf0s579/nR9U8U2eSceeJGwxq3+CBqDQm129wtoEPnQp7sGelbGIBMTUYSFpvO29mrdDmbLu+Yp/em5kRoe3DyIBWMYIZQUtTeMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CTJBMDdg; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTJBMDdg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJN768EHxYrv3hwIP8ZhkBe2ItWJBC3dvRdlwosIif2DEB6IEb9J4INqfpLtF45M8qFhkUkf0woNbG1gxHZzrjODF86xPc4l1bTCeK62IyC/i/FbRvB1VD+HsI3xkyKTbC/f6OTpYQaEDO6CCo4VJ4nyXIrKXICLmsxtTHB3OxaatJfnQRlV9rnM0iI52JSLmP+7w2BJbYPMjtw5+UPMgkoBtf5L1scIKPycDFQyGJ2Qw1avh2dqta2aBE2jNzBh1oSfikb07V7EZnpRzhUXWRWjXFXr/nl0F/KioS9Vk3W+uL7b8vSldudWWeeSELDC9f2zTFMpLI0AKMV94qgwWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/LXxqhUs4JR6IYtNZy6jYoY8+gknRoM1EjTjqg5+5c=;
 b=HRnJO3+p4hefhx6RqKjwtmC+Th105bwcH+Oh6r2Wiu0dTWVoGMk4JHOdbGwxzkDP+HtvXNxAUUfB/0rakY4bz1XoGKQKNUB66YOIZQ1jzM5CfwfPoo83dCKTqgYAVJqcnUe6rn1xuIl6oWo/NMRodWc8kiiTXO6QVCSvoOg8qap4F46HzWKWFkJqqznYUz6gl5XmZszX2R2gUnd7IuJEkJkIMFlXIAY7mtxr/dbR54chv/xUZNaDbsyQeo6IzxDoU4kJn1/Xgv19ZIcCRUD5X8b3GwMu4kB6z0/pGmrfOgICeJkP/rh11xmb/CK/Ee9sSVOMswLTMCJ5jSfA8Qc05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/LXxqhUs4JR6IYtNZy6jYoY8+gknRoM1EjTjqg5+5c=;
 b=CTJBMDdgiwrDW2XwdWjaXUtdrGOdxndw5SsgXVhtqGiatj/x2yexUTbnSsMJxlyMlFIwwVxsfz879GmWCNoQdxZV/CgWHbBgjA5zE6wJx792X4AT2Y16bQnLx/vUfxX5hPcoZzfSI+i/ONoLpq0OuURza6LV6x8Nbu5kWrNgO28SMnFMPPMmNfLXxVV7GqXO0SR/CF1unzezG15bHu4/rdlG1U4UepQECGBmq0zLu8yP+ZmQVF3IOIKGEzairUL4msGyN52Tz+MeALjbDS3znT+KRl+LD26g9HfB2gDMMJ3jYEI8/jZc2DoaFFFCS56jeXmVrGP0sFKH301dMrqnWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Thu, 3 Oct
 2024 15:44:13 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:44:12 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v2 0/2] Bluetooth: btnxpuart: Add GPIO mechanism to
Date: Thu,  3 Oct 2024 21:15:05 +0530
Message-Id: <20241003154507.537363-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:208:14::27) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f0b224-a4b2-4bfa-6f48-08dce3c23a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymXEQ6BzYUPGHvEQlcjICEnoLxk843GO1ZCPO/e/S1xIgwlp1e96xvyqFx5p?=
 =?us-ascii?Q?Ad8vEVNIKfQM17AgK1InrvUFZMO3W8Vp/Q8QYnagsV7RJPn1yGDt4ds8+zGM?=
 =?us-ascii?Q?p9EYX/CJ0HsO/b1MUIkpppnQsMJJWWid17o/03IPE0ah8vfP9HS68xmClOUp?=
 =?us-ascii?Q?mQuETL+9O+BkCf3LekYT2oGOL0DRDWOgqZmFVQT+cH5Rv1/x8mRq7y+Fj+ar?=
 =?us-ascii?Q?5O+rOtTcbEgEC+LKevHbx3y/2CAGLsX0SbctJQ3b2muBAPVnu/OUUcqZJBlQ?=
 =?us-ascii?Q?fWzRJCEbI993q4TZzNcrSKU+jj3pSKRFx2I0fGysf3XN1TEm4RxD0fqPw8Ev?=
 =?us-ascii?Q?6G7F8DexsiGrHupiDn+ZohXpkOB6QJEE4XZWNVHJN7zv2QQI12AS339Wap/V?=
 =?us-ascii?Q?I4ZvzovgGy5hkubLCIZjFYWOvXdq4n6mDvAGImHawk2J9E0mg05C8uELF8Mb?=
 =?us-ascii?Q?WGRUi0gF+EYr1CbJTea2IXI8J6ZPWgbwFEXTjC0IUFukVSBELdY8YyqRU3o+?=
 =?us-ascii?Q?kx14+NuocgmQWVc54IB6AAJmPRz83WN+iFq9fJgS0mFCvWFNpQnlvVRmEUXN?=
 =?us-ascii?Q?948ComrvcVcl4+iPCJd3s+xy+/AE0E6oSvDeXSKk9/IxU8sSZFnZIKw8NQTm?=
 =?us-ascii?Q?Cdt/14RdghxD/W6xsKp1ELKutbPw0OAJ5sePHq1X5vvIed1MEd+ipETlNJY5?=
 =?us-ascii?Q?hTSD2RDCv6Az9H1dwY+rDVyFjVEkUffzvEUb0+HllXMeM9E2pMZmd/tbsJjg?=
 =?us-ascii?Q?EeptHyVJh8wR3zHHOrPMBVnTtH4OArT8HkMgKsw9T6diQZyrp3oeJVysollE?=
 =?us-ascii?Q?LQ1BMga9KoSFcyantkdmZ29MYYqsULVzgkFYp57kBnb8IIZyFUiKBlw0FeQG?=
 =?us-ascii?Q?a3loYM9Ss9klCddNKc3YfSQP8a96ft2geH/E9QpTvgi8DiNwSkPLEH3sRPNy?=
 =?us-ascii?Q?fbcb3iIve/k7obuKwYXDk2Hg6M+YWk07kP576EJa7ogpVTWxJTNJW45SdDTV?=
 =?us-ascii?Q?cyjJMMOlMix9NNfFpJqQu4nmT/KvZgx6f46YknggjXY6ujWl+jHVYODHTA6c?=
 =?us-ascii?Q?hGW6CwUPEp5VgQQpFiuymlMWZ9Yt0u98HBNjON4mS966J9kDOkV+dh8DmIXa?=
 =?us-ascii?Q?r/etL7GZj+LbPVHEJF+KzdomYT+LcObZ60BuYhY2iBYJWCGe0hMh758CTuj6?=
 =?us-ascii?Q?R6Rgff1VPK+JzasfmZmT0cvYj6GUeIKO+tsrMmvhau8Y5TcolGxvEOEJbA3Y?=
 =?us-ascii?Q?8Vx/s1RDGKL5esH0vQ2ing0wPVTgFlTL9P0AA6fAsfkNusmMHQ3VugnP0ZFj?=
 =?us-ascii?Q?33iihZdVCni8+FIglsK9Qn9GlmnLosBJ0WuR8qGUpbdQ8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L9XIzNXnMKnUkjQt6NNeR2fY/64U+1C3JmIgTOos84z4n7iRm08DYr9B+Upq?=
 =?us-ascii?Q?HYoStNw0G+yYIwpIWDdmuHVtWbfZUG3B6EfsjxZjhaiyylLlJ1FJrtHmDisv?=
 =?us-ascii?Q?rMB4SNJK/Kia1I+rcHAELHhW9k96ageMIq4BwNKzwDkDXNt4jNCN0+nd8cKq?=
 =?us-ascii?Q?Nv3eNhgG5fCbHI7lwEb9+1shyvSbd8pS/aYG8kX4CpF62gfE3XLAT8q6RDcW?=
 =?us-ascii?Q?eH/aabvomVmaDdBuubpCp3yXiO0AHVvurzrN/qNsty3qlCxQcmXX1AUEI+4G?=
 =?us-ascii?Q?ufanJ0AmNtQ7OAudvLxWrGW4f1rT0SCoPMCejVitliLPS2dErK5UBEXCCeNr?=
 =?us-ascii?Q?pSrPIlZj2bour3v+G1iFk3t1rZB8X1J1ld+d2Xfz28nKTA7mhGSMj33FRlhR?=
 =?us-ascii?Q?qdhg1vZUDOVl40JZquThAeKX+d3WlSpYinO1Rny4/a+OHQqWieOgUKwbcYz4?=
 =?us-ascii?Q?sD7Dvcx777nZhGS3jEDtG1JFZXow3GHz3n2QpSzd3CL+iEn+Jz8nq/LI8TCt?=
 =?us-ascii?Q?SFkaZzR7HDA5pTAOf/lWVxdkMQJ28MxsaaKr5dygmuVYUuoQWxRWWNLfU2p7?=
 =?us-ascii?Q?6cVHLvwH7GgLLnu+H1jPCg012eDxtlREryDvpoOjF4qgIz38FqT3UyjeBen1?=
 =?us-ascii?Q?y8XSifhBK1+qRNSWsf+Kh9mku7wREO7pHodxRHJ++2+fHTxznwFQx8NNe+i3?=
 =?us-ascii?Q?OvhV0Z8KXQ1I2/b9Goe+860BmHkSt/CoXLdQyh6baDb3aXmGenHWB5D1ewIQ?=
 =?us-ascii?Q?U7Hrjw7I13EcQY1A5nTsl8qWBc1ZzCJFWS7yfxF5Xl7ZZyPuH6Z1JNKlGpmE?=
 =?us-ascii?Q?De723l1fxUJvqX042dY0bNQGK0WKFSATXOJIGyoIofEMtAhgm9rGbdbXsJ63?=
 =?us-ascii?Q?rmHhQdM2Y2FehWvUT1VPeW8iIOEI5YW3r5p+0ONVB68cv6eKYZPHLxm1es9n?=
 =?us-ascii?Q?TFnv1aRpQoQgu+6QWjYtlPOTPOn4CNclfAVEhcZaLNhYSjdB6UvVwmzGfsiZ?=
 =?us-ascii?Q?mM83Vz2TpS7UJNmlF/ISB9/N7Q1mrBIFwI/zSQoqEvCv6T7LhWvI1P5H2low?=
 =?us-ascii?Q?VQ+QgjHnXIL5SmoCvxpeZkmewLU5jsGEQ8bfCea8ibEdFBK0DMDwbJwJTbi2?=
 =?us-ascii?Q?4jfCcJeOUSc74TIMKwf3yLjhi9jYmDaY0UQQL5sYhsW/ZwO3JKJZ6wyk51z5?=
 =?us-ascii?Q?cyiTL5t2yQB7PEZ/yQ6RhpKW2/VDpfOH3U521gm4dwvNgAnns2Lvfe3bsidx?=
 =?us-ascii?Q?3vDz9wcCRKTaCdHvMRs5/yRINuSv47/Z6MKfF+Uooy78B/FXRaGu28wuNEEv?=
 =?us-ascii?Q?Jk2jXrJ7EHXGzY0WNslOTHeEmIyk+mApNN7V6UgFzDJZKkaECm3cwL826Cnz?=
 =?us-ascii?Q?KAULUQghLfiX7/GQ2u+xs6bqgskg0Y235FDPHhlZUv45tOOjYD9THVyMFlbn?=
 =?us-ascii?Q?tBI7XTIfNco0Pt8XHlfOmh76ZeXqFq7Lqh0kRyZvErezGxs/zHl4pmbk6/+U?=
 =?us-ascii?Q?H9iNYbhPY0IQS7bercsqpFtsHfE3mdVSI5BeTcdDmIDunA+D+WWqnCRW0lMN?=
 =?us-ascii?Q?ienDdFND3hSDcozt5qLcUHPUbjPyMBLiPi9MA2sc0+2BYr2uAxMp5lW+WmIM?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f0b224-a4b2-4bfa-6f48-08dce3c23a9b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:44:12.9163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWfWO/0G/8SI2Oycyd/2DQDZ8QKu1k78Xa9I77XZQZosU+2w8MgTyzJWRiU9PUQr+Cj8gjCeKEb/a/dPkmKXcAwN3bctTc8wsgAqDaAWaAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558

This patch series introduces a new optional device tree property
h2c-ps-gpios, which specifies the GPIO connected to BT_WAKE_IN pin of
the NXP chipset.

If this property is defined, the BTNXPUART driver uses this GPIO to put
the BT controller into sleep or wake it up, instead of the default UART
break mechanism.

The vendor command parameters HCI_NXP_WAKEUP_METHOD are configured to
use GPIO method instead of UART-break signal, to inform the chip about
this new mechanism.

Once power save feature is enabled, the driver puts the chip into power
save state by driving the GPIO high, and wakes it up by driving the GPIO
low.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Neeraj Sanjay Kale (2):
  dt-bindings: net: bluetooth: nxp: Add support for power save feature
    using GPIO
  Bluetooth: btnxpuart: Add GPIO support to power save feature

 .../net/bluetooth/nxp,88w8987-bt.yaml         |  8 +++++
 drivers/bluetooth/btnxpuart.c                 | 36 +++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.25.1

