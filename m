Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A6723EA83
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770992842; cv=fail; b=LGbWAmfSZiIlzH1Q+aS+09O7SO99AN8ArzKHUBVJCPklboeRUaMc2yK5J7xtbCuXiLTNKk0FBGq5dpiMDt56tiNtJNQ43UdKkcDQ0gtgff6j1BYrtg/gMvWNZbYY8f+bNZDN09NDhQUVs9rLM6pmLBuVwfjWoe6Kzoq6bGsKT3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770992842; c=relaxed/simple;
	bh=9RG4FSO1KZkA/hYvA83SFy+UFmZ6vCzstn/BCurtKGM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPm4+bzKIMhmu0Jl6m3amNlC4RqJ5Mf9D+jcmfoO0+kwCYckI2zwsMVfSpu9VHx/nGUfySci7Fxi9XMCKZioKbqp0eGvI0utjZEE8DUKQTnOZwuAqur4tGsiYixGCvhrF8f0ULvOSBVqceiCTA0RgAFa1IyWz1YqOSS3WrVbidc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=gAVK1IDw; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="gAVK1IDw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AH/W5xhJPF/88HveyBapu7d1BPZQ2h/VheAGnYzJ+wLzKGvbM1c2sbBi6IWoBt7sRStv6Swdvat3dZmeVtmDnjdH0Qkhlq/b3b1dXhIxdHEYA73Wyw4WljeRWZpRRUtUwMYaAsECWfPaujvqzdiwlZ3roJaF/80Do3iervPA9WoPUcvUQct/LjsovA4dyHTfw93GnPSLtlrDHh8MyHUX+JyspbYhX0y+e6LrKiaX/y3nIK+0myFNynbkXil+wilznk0wXrsWTmh1MxaCkn7vj7MYd8Uq4tW1qUx3hoeLWAQ9Rnh4u8qT4dr9hzD6r307dDVDBUdaP2umMRuQ3W8rrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuiapvs4r0lCFzNpVVGr9fdEfGgtos1rac41gj9/7D0=;
 b=wnPe7moupgab1Kw74aEzN8ybQUnA/3jPo9X6eTJUSXugbjPRU5wxe8oQ/jFweXUK1Sf/qZSOHiTCglSeBujlr/+q8HAXDFemj0nAgjjdhy2DRIhDGO7dIu9Ztl7alMBJSbuZe7/lXczffHjKhhRlNAW6tzfFC39NdrmiIIhwNsCNOb20l+Nwhd3YXuM/8e93C7rdIXTt20ONc0vixdHv9wrowHsLOK+BtUV3ywydcTeB2cAz/8Yfpxl/WwJe6sfYdwmdp+JRGade3VG5SLPnjuyXtWlWYtVd372lV7sR3hCVt7lXPLPss43wXzhhHFVGbog55+MoiGfuf4XhLUL+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=intel.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuiapvs4r0lCFzNpVVGr9fdEfGgtos1rac41gj9/7D0=;
 b=gAVK1IDwynpKrQap+uCDj/pmLGnFKZzONxazoYfpfZRDjYFr7vxKpC2vj/Jy9M4w7PeloG/2NZPoxVq+M7W9+rUkRMkksbHz0GNcQoKF7yD1YyTP5vp0Pj33y9hYUaT8AyCpnBjSmpme9I8wwgO7yvdcJgob84soIn7zf44qxw8=
Received: from AM0PR10CA0028.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::38)
 by PA4PR03MB7022.eurprd03.prod.outlook.com (2603:10a6:102:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 14:27:15 +0000
Received: from AMS1EPF0000004B.eurprd04.prod.outlook.com
 (2603:10a6:208:17c:cafe::85) by AM0PR10CA0028.outlook.office365.com
 (2603:10a6:208:17c::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend Transport; Fri,
 13 Feb 2026 14:26:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000004B.mail.protection.outlook.com (10.167.16.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 14:27:14 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 13 Feb
 2026 15:27:13 +0100
From: Christian Eggers <ceggers@arri.de>
To: <luiz.von.dentz@intel.com>, <frederic.danis@collabora.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: SIG-Qualification: Problems with setting TSPC_L2CAP_4_3
Date: Fri, 13 Feb 2026 15:27:13 +0100
Message-ID: <5782243.rdbgypaU67@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004B:EE_|PA4PR03MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: b9fac2f2-e449-4a16-a7b5-08de6b0bfbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?iVRGaqStK3YU331G+7oYd+c+qZAS3wiuAVxMebv00IGZMnyjZshGi1eOzI?=
 =?iso-8859-1?Q?ZIUp8XooFJu2CWyOtO9rmyrvMDGDATMJ0SniDtFQrapRBMz6z3xd/8yepO?=
 =?iso-8859-1?Q?jnWnLD+E9xgtEE03x4cumQWU/NR7P9RsGv7pUk0depRH1BhF6pRyZ1gDfG?=
 =?iso-8859-1?Q?7Ns9/UXVs1vQOYN52MFpt2m31Mtp1J6kE/vg0615rrn3xQ2OTtvapTlizI?=
 =?iso-8859-1?Q?hm128Es5bl/3dJe7BaiOZrYd8wZGkCxcITVvI8AG9ou1zOglguEwcSzXCn?=
 =?iso-8859-1?Q?UD0BFCEkVGLEqnA/upUdszb9aEIfHrdD4fiHUqFpQ4jsX+TuSoE2TSn/mL?=
 =?iso-8859-1?Q?lg2QIk3ildVwOGGG1kHFD/z81E3w4QFdsWYW7pwCjthItPl0HUJ1+HxRb+?=
 =?iso-8859-1?Q?+8HwNGUgtFPGqZiQVGdw4PN/ENA7k9hnQ/LqoE1Z3q1ddV3XOZvmD/gVx8?=
 =?iso-8859-1?Q?FG3v+YaVjX+/wOnlpMcTiM7C12+P442ujjWd45MRwQ5wcHBXaJKrJv72OK?=
 =?iso-8859-1?Q?WILO1uLWluJZoft6b0igtE0iM82i7CUIurMf0lZrBr03Xd+j6akz0y7qWO?=
 =?iso-8859-1?Q?Z5gbUy7l0eA6qCyxi3r0Xlxj87kA5PW1qmaBr/t5j/la+43U5q2EpkFBu/?=
 =?iso-8859-1?Q?dGpEsj704AKbFfh7ZQiQKpcnhXaAU9mjXth6ZAPb8UD5HMmLEpYDABSvUI?=
 =?iso-8859-1?Q?V7xwBoBeNT3tkwjVnqbZLZ0Oj06B9Y0TutJtRxKUvV+fjUKYWkdbGtEVQ3?=
 =?iso-8859-1?Q?xErmZJ+6xt6gkPkVgXKQLwPIR2nGLKqNDn91XyEMUpaa2hxdFIn698E8Kx?=
 =?iso-8859-1?Q?+CBjW+rGWN22Ly8EUIoCyPqsR+FS0y2pcV/Ex0stHNTQEhvrlkBYsSC1J3?=
 =?iso-8859-1?Q?Pp3yn0iIV8HdTVs2Jz+JB6bq+0ZOPrWH1YxxZJJ+BmrEFsH0hhFIPWWei/?=
 =?iso-8859-1?Q?CNOHF5m9qfPGUNxF+kRHgsdQxTSDOtO4l3PIBxbbUl2iEX2Bm3z3e32atP?=
 =?iso-8859-1?Q?yQV7zIvbJaGNnyUft+kgNH6yomxjUM0crvbUDYlB2Ex7kjKuOJy97a9FRz?=
 =?iso-8859-1?Q?BDbmpXspRWkgl44C7wRG+fp//M1CVSlmPfdnrhe7qWgUuPoGFcpy65A7gX?=
 =?iso-8859-1?Q?0f/LL5VtdbljdU/rtzaNodTIwql6+GnCbrhb43ap3PS0jXKrVVdeOhAn94?=
 =?iso-8859-1?Q?eE+0jICh0VZSfXYgjBpgTnHKUx7RqECPgEWjufCtuJDOguiGovuG90Di0w?=
 =?iso-8859-1?Q?GwUIPPtTAfrQrKS+xZm5paEA3jrbOv1gS64fTZ0Q7PWXz62i+uKSyxI7Dt?=
 =?iso-8859-1?Q?e3xCBXGA0ieeOZlOqnVol4MCyTFAmIUcL9wz4hox0ByXChU0xsoC4tY6xl?=
 =?iso-8859-1?Q?t2h/jKBCREZKGccIXmesq1fBsTu1kb4Qi/flK6NwTvYivMK9BYKEk1NEUf?=
 =?iso-8859-1?Q?h2rP+NQYQ1KBnCz0dWIbvnU55E26MCofTcybE6d7QeqOPBYf0wErtmbYKb?=
 =?iso-8859-1?Q?VkTgUEIq+i5/hyhxCLtnUE9Vc7Oj/C5oQJDhkWQdWM8uKnh0nYQPhz265Z?=
 =?iso-8859-1?Q?ETbLAeynpLNT/x7IePBA6pEnBFhziDN97Ei/aZFAZUdrzdtrk4sZ82FUBM?=
 =?iso-8859-1?Q?EYvs0KDOK7rvzXA+5dyJ+jthtOiTJIpHDZt1cKN4O64NIT+Uci0J0pYu22?=
 =?iso-8859-1?Q?mDQs4mdI8PB41yXYmymp0YnH8fkQ+MKPRda+YhkM/GsiCWKYkizQMhXJbG?=
 =?iso-8859-1?Q?ZEFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yl7VyDo2sFHtTlXlfRcIkOiqWIXAYkAbRBqnkzKcrztHvt86CE0kGIxDReuN3HWACMUQrJZgphaRvzSgpB3bNFoxFlA85O7KIv6Pp408pU7dsEAjuHmyL0ivdypsK8syOeNRgnwump+PALFP3iU6U03TRGxPokdRVJNw2+7BJ1S7Hs0obHz5jxrKfDp/lK5GykuhYSHVpz0TbxudMIyWkZKRqIFbdzWNd31IRJUrttaChqnVTeBduNT6FuEJWHN4Zh+5aWFNVzY7NB+etswl/zRHhzq7kna1c1d2ll6gDKFKrDQmb7nPGZTt/UeF1vFoiRMm6j8rEs0IZhREmZwPYJAuhnOXmrqUzXRtf+Wsr+XwAhanwUaidgaTdS3XYVOWFKCVeUA92eqi62HXt5oZMYmFaTvU73Mc7hnQUu6+2GBH+A+c6sCQHpFNROIzOS7i
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 14:27:14.3745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fac2f2-e449-4a16-a7b5-08de6b0bfbe7
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB7022

Hi Fr=E9d=E9ric, hi Luiz,

if I check TSPC_L2CAP_4_3 (as recommended in [1]), this enables PTS test=20
L2CAP/LE/CFC/BV-15-C ("Security - Insufficient Encryption Key Size - Respon=
der"),
which is currently not documented in l2cap-pts.rst.

This test checks whether the size of the encryption key is greater or equal=
 to
a specified length, there are already several similar tests for GATT (but n=
ot
for L2CAP yet).  The test case expects, that the L2CAP connection request is
answered with L2CAP_CR_LE_BAD_KEY_SIZE, which is currently not used anywhere
in the kernel.

=46or GATT, it seems that the length of the encryption key is solely checked
in user space (bluetoothd), while for L2CAP, such check would be required
within the kernel.

Would it be possible, to add such a check for L2CAP in the kernel? Is the
length of the encryption key available there?

regards,
Christian

P.S I'll be unavailable until end of next week.

[1] https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/qualificati=
on/l2cap-pics.rst#n320



