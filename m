Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013027.outbound.protection.outlook.com [40.107.159.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1339A079;
	Wed, 16 Sep 2026 02:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524458; cv=fail; b=tzmb1IbKSx9xxn/BJMrPAp6yEh1oijOAfv+Ycxu4gTn0QkxP/Zt/7UuiifRrqdX+QEDpuo97vrZdlkuJV1wzaWS4uR8KnxrK4Wydm/jvcNFpv/OHWMeBE23WWz8h/vPmOdnRtnDDQ8JwMF8uwTwD3wByzazwfSnM9yAfTDaoS6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524458; c=relaxed/simple;
	bh=jywnkDp5ZopKBC/WF8RVvpbOCOYP/kfpmHsB72HHvvk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k/pBq772ytc95ypP4Ov4u6gawj+X+OQTjVRD7DAu8u1EirQEkxxZZpyuiK0kFP5gVHqBRrWu9Bo/oFg9Cjj7fQ2kwd563fe+cUNp/SC7DcFEKRjyvsHJYsSFfg7G60HkKZ2CFmJETFz+hoLDJPzhLzFRhS6odzgnt1UYfoPLjB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Wr8YgL09; arc=fail smtp.client-ip=40.107.159.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Wr8YgL09"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdDlt8aWEKnVwVfcq/rEcVc050UknYCRYbuztE+6/E31un8mmnwq9Yqv5pyY82vMJs3Wz7Yh19ee2Ffjrv53v/PjQrD5xQuVsHDKS/oPnT7KllZKPbnmO6mnaMqsNwi+1ZCs/cXKizqBbnI0rGkIV9krO0umULGOphTo34WcQZYity17WKhLoaxQi5r6VGeIOUi+6iP5/lIQduynG7GbcK20m6SFT7GXlllLI3yXuOgNucTMYkviA3iUUJsJuMbuAT5LAM+M+MZh9LvGQDZ4E68fdV61BZ3GacuJhYTExjmE+yqldr8OboKXHFGN++5hbxJ0e8kJ0VUfFpX6hOO8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NQaDS1a8RBjWujTaGVEt4IqNitcubBB19s3bEjVl9c=;
 b=uhiBBE7Mvqy5fsYtBDG0aykzlcWcBTMvkM0sYMze2jUruW8kcZk29g4hJa54qrVo4WTQuo1phndSqegdt0pLFPp83jzFFMmWf0HURNCA9pN9SyhQtpe44KL5ZpPnY4R0KuS7mQQ9ziVSAmVBDv92LnR3v2QQZ3cqyno53ZCkp2KIywIQ3WIlfI6EKX5kDGjDkllvkhoFyaJjvs6Gofxna45UzZXm6B5fRdgB+KO6B4j/g49pq/l3mme3cg9lhpnk8MzB9wpsGc1JnMCA/DMcTCXjps3pQvZVmIziMmkNuy54BIhqWmrnOu7bFlGgYbyr9m4kyom1bXPRpWiz7UDCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NQaDS1a8RBjWujTaGVEt4IqNitcubBB19s3bEjVl9c=;
 b=Wr8YgL09/F6X9Z/Csd7lZesoFJYI6WwlNNMbwR8D9C910d2ZzF3425z+mRpr+DAcyXumINsfYaUaG4DvJdXrHCXhYK0T/QDkKZOTpvp+yNkqIWPsXV9PHqITT0lQHBN2Z7YHn6du0bvm1G1DoIcazTnEtj1JNptFX2pHO6deA01EQTLBNN7ALrfgd79f/6HKl/u6fzpCvdChu7kwaCEjw5Z8mknQcrpvPeNYXhi3oELVhMxfuIR9DeKKbHda0Rv0QMRQ0786nfj7npndO1weR0ayPltGx/7rL3O3P2AfXCSMnPXqWZ2mfmNTjhGyzN28JtoxXQj7vrEMwF7z7XTeAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBAPR04MB7335.eurprd04.prod.outlook.com (2603:10a6:10:1b1::22)
 by AS5PR04MB9943.eurprd04.prod.outlook.com (2603:10a6:20b:67f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Wed, 16 Sep
 2026 02:07:23 +0000
Received: from DBAPR04MB7335.eurprd04.prod.outlook.com
 ([fe80::b593:638:1155:c067]) by DBAPR04MB7335.eurprd04.prod.outlook.com
 ([fe80::b593:638:1155:c067%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 02:07:23 +0000
From: alex.zhou@oss.nxp.com
To: linux-kernel@vger.kernel.org,
	luiz.von.dentz@intel.com,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	neeraj.sanjaykale@nxp.com,
	song.xue_1@nxp.com,
	alex.zhou@nxp.com
Subject: [PATCH v1] MAINTAINERS: add entry for NXP wireless Bluetooth driver
Date: Wed, 16 Sep 2026 04:07:19 +0200
Message-Id: <20260916020719.61981-1-alex.zhou@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To DBAPR04MB7335.eurprd04.prod.outlook.com
 (2603:10a6:10:1b1::22)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBAPR04MB7335:EE_|AS5PR04MB9943:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d5a8a1d-541a-4101-cbd1-08df13973ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	PLiONGXYmZrKAAJEvDgXXWxoh/gtrqAFIAkegg0tLyrjBs+kaXetWnV4vzUhcHb8dG1fFy8kCM8ou6UqXOg8kI5KD6Z62tv2KAmPiG36HzcQCen7by6IXtnHIaBamzpFbba40khbTb/1RBTtnQgu7BnRdxFVPWmXbh1T/ieQBztdz/jNoIi0h/Je5dr1vKBQj8xJ1fzz3mbWWMDgN6YC+9NsrRntssvuJpZKaSptfJYRcaFgjco1ikfX0oXX5fqXBRqoflhSqNf2s9U4PGd7WAhEaqWcXfHvanwGgghNmDxUiBeaUEUskh9iXzGkBP7d9MfQ7AnfnvWQ5eKHkJNiGy97z7dZa55bUKc+U2UD2n8ILUTONM/v+atJmCA+y90Z/4ILq8Udkp0kU3JP9NI37OVKZyL0gEs6nFTMQg5iErOJ5+4cVmsCDfqCiUeCd5hiCBecYvjb/a4iukSMgXdyQt6CID601Rhb87Ew77nUMnWIeaXvKI1xl0kzsOgk5YBgiPqr9kK3mh30TAc86KsuRKiRzmDfeIXJanWftmunZ/BMDjCqgdyko33DaZn1vOANHHBIbXa/DBpYVEB+dPhn/21zUHGnbsyirfHa2cgjKtfAcy8wREKQI8bzx6svqwCbzEqHniy4CpKQQCpWFnVa8vXALe6e96gbV+LY1EIvkuo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR04MB7335.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJ627+jeNTZZVRbzprUXvek/ofwe80fUvdQQUs9U38iJb6SvJX7vYFdsz383?=
 =?us-ascii?Q?wPJt1VfaTmgu7qXq5CTscYsLQRlL/UKLUmuMP90/P7FlgXp0UlcX0DJkCEun?=
 =?us-ascii?Q?RUKiRvWCu9gAi3aFy6KkphswikHkxGQKj/Om7YzKCb8JOli2wGgU7JfGtbXT?=
 =?us-ascii?Q?gkSy4qE74t0CNCqUA8FmQIzRtCUbUpGcmsI/cegU7CzqTbKkUOLO2suhmOow?=
 =?us-ascii?Q?1myef6V3G0SBDzJZwsCIpmEGoWfWhiZ2HHyOeOwmGddf9iKbT5dj+MKEv9qG?=
 =?us-ascii?Q?CLGZvyh4OM3cdRwlqrrWw8vOYodbNNaLrr48LAXO2OCyqzcZ3d4VJ1UMJXo3?=
 =?us-ascii?Q?8kqjdI6OCwcr3p255kSQkzP9ahudFfTMRJE4XfA+mklfChBZY+4oyyFkPtoa?=
 =?us-ascii?Q?9r8SJD3rolxw1a+vciF7ZiLqbNg4z0bYXTI+wrhn4ou+laY/n0QoqAzhh52E?=
 =?us-ascii?Q?9co5Pi8xKhqXYYVe3JIbeAOcI5D27EhdEg5b5g59yjvp2O8DeSZSjwagmS4T?=
 =?us-ascii?Q?J5UWkByp1OQZgFmbgYAyDvuES0D27/qISgtm2xqHDdpN530ftPvQdPPVIkrO?=
 =?us-ascii?Q?Q+JufyszE6+sR2xubTATiDKkWtGF+zjjJHYi5vI/WfqIz+oFWXMqB8APFNA0?=
 =?us-ascii?Q?4sEUSxlmU9e5bp4qKpSZH5GRs5Ij8Jw+dhCjq7NQc0lKeVN2KQyCLep3NX/u?=
 =?us-ascii?Q?e93XAGU+wp3MW68EjRF4R6uL7CUIBy6axDYSUOHgflrZmo/pNvbud4qHuN4R?=
 =?us-ascii?Q?NZ58CWguKLZGdkE3bs+Jgn1hJF/ZOx/wQJSZpAKA0SQSXUYum4bMkbTdnDV5?=
 =?us-ascii?Q?GbLtRr/Qr+Y9e1Y1acSkXgrSvgdyQSwiUbvAeylnTvZwO2qiHmyfyorphsx9?=
 =?us-ascii?Q?937UNRqr5HYLYsLFcrDBVTu/JUIC9YWN0jEzdFhGGJ1vsPim/BrnH5QZfUDz?=
 =?us-ascii?Q?f23yQ51Ype1DAMnJiUGlKHKuin7aqVT8gMDbfTZ1Vd3j7EYAaBE5tZmIpycf?=
 =?us-ascii?Q?BWlSfo0jZ2coMd38iFM6ZZZEMsUVLnR7vhs1xzKuKAyxw4LKk2oyNrVd54ee?=
 =?us-ascii?Q?FDuVbLBQ3YRqiQUXSKdX4tL/nlpBDAfKswG/uqXsE3xwICWadj/4nAq/m7j4?=
 =?us-ascii?Q?wvJF/++XRpGvE54Wybgx4ztKhLFeP5XY0VKiFu+jaJlgw4nPwbp+Q+DsnzbZ?=
 =?us-ascii?Q?QzZUGN46kPomvJvYS1UBCRk6D3AUL0BX5uCVv/LVqZ3f2nllqxT41vv5B0RB?=
 =?us-ascii?Q?87pzLZVnu9HEuzEe0+gsif/IXCKzEeaaMb0Lby+CRp01EZrLPzuCl1g6jlKw?=
 =?us-ascii?Q?crCyw+cev4QecEGwxnq1horKGEjgWeaWp9rVnvvjHI2IoUtDDu+UPHHIllZ5?=
 =?us-ascii?Q?4I3uKmIgJb2C/2sIfTp1xJaz2StUKup466TJBMSPDWJn+uAt9s1iH/3/0QZ2?=
 =?us-ascii?Q?2xOcC0ivM0vR4GF/5AYEC8X79lBnj1gccjjFk4utHoxWpm4SkV5s/VE2+Ovu?=
 =?us-ascii?Q?M/gR1l4td4AMROIjfayTb0N/lofImzPb92GLeN6sPa6hXWoXJh0+oMNUIABh?=
 =?us-ascii?Q?QGqm5DcqpwIxe0cIb6/y7OkmwCw4QGnSExahxW1W0AgCHPSDIwv301lrvL3p?=
 =?us-ascii?Q?pFunhdZZuwPOwbcPsTBkAe4kzUbCot48kVWLzq3DbCD/XVA0kbwSZrnoRbF6?=
 =?us-ascii?Q?c9jRWGYo9TogV57HJm24zTEYhFXbwTfypBztG3ygIxvZJ10lKiE/5iX/UC+B?=
 =?us-ascii?Q?hlt+gaB/+wvdoT8Tl6eDMEyB/y2lZaticqzVq055L5r1Xs3DEwNs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5a8a1d-541a-4101-cbd1-08df13973ed3
X-MS-Exchange-CrossTenant-AuthSource: DBAPR04MB7335.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 02:07:22.9955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5Bc8iFIMaY70/74vEkqByuSmhBJ8jp5sVM1zfdZmKOX6WqqKa32LE3OfL/CB+ZaUe5B31C+NgPJSFO7U4Bjc1ps95dsVdKlSwT1GDWvvAPAgP5vznSxgp7Gg8eynJju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9943

From: Alex Zhou <alex.zhou@nxp.com>

Add Song Xue and Alex Zhou as maintainers for the NXP wireless
Bluetooth driver.

Signed-off-by: Alex Zhou <alex.zhou@nxp.com>
Acked-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 891c064a881b..56e246710fa7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19439,6 +19439,8 @@ F:	include/linux/nvmem-consumer.h
 F:	include/linux/nvmem-provider.h
 
 NXP BLUETOOTH WIRELESS DRIVERS
+M:	Song Xue <song.xue_1@nxp.com>
+M:	Alex Zhou <alex.zhou@nxp.com>
 M:	Amitkumar Karwar <amitkumar.karwar@nxp.com>
 M:	Neeraj Kale <neeraj.sanjaykale@nxp.com>
 S:	Maintained
-- 
2.34.1

