Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D512EB859;
	Tue, 13 Jan 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290422; cv=fail; b=Hr0rhBajRT3nRAcjyTCPYfO2e8maDpG6/ltWb4Si5PIn7WakYzjU36N6y0mGLeo/1WFO8Zj1SEiIy2hNzjD4y8RJTyJPKjTdy63kkNtTJGtZZaVTpWwEjcP4dSY12TO3zgk3SAGofWj17PzdGM2qDTI6CV/v1UDaoLFI3/T7eyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290422; c=relaxed/simple;
	bh=ApzEgVOqSCAomKHfljdpSEfKHeKoAocR4OcABaAZT58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRQCWUj/URhWYhpFSiCCPJO17v0o6bXL7cOgMEEyOybnDZ9tzUGgyC2fk7exKdjH6OouqjTJKYbS2uoTdBnpqEV/yyYNIcH9s5LpKF8Yaounqp4iIDDRHQmVoZjgkNpEGVRa7eFsT/LxyQlHL0qqKdHu/E0iFVJ0qnTSkqTD24M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WVuCXWbQ; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WVuCXWbQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhFBIuDlCIRkoOsaH1hM+ZZpGmY0eXefL/88KPDNvvE8hllzLgwymm2UricEPiNEsTYzXcoPoq8tCgsXzdXggH4Et+c6X9Nz6OQhNJQ+queSWdaOlBRvUmWMMgYIhtJqcuzjvHjJGZyUVDjF96AKdJm0QjGVPGPQTVw/A5go4f/ZquBtUfmBW29mKVdHTbQ4sK675HZKAAX0iKp7TlZl2vMe2DnBdhJuaw+zbqjJdHJOl9q6LmnreUntYxDU1qkHRCAQGjPqSRq7HaKWrjBXQgLMHSA+tFjjuoQK7a5i+YhzUKpnANPiD5NxwyYQOtHZNKB0mGgplKv1WbKo5kCf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H57CLjJxcYbsxsHvSk6V6Q3ZtgYOSMNIPE0Y/lelWY=;
 b=FkMK+95f1YP72ocPik6UfrhgLticLgcpC5TzdgSPfgnvOX30G+pci7TS9zxQqosaMhw2OCBt3vNwBConOMKD+XfnH+/SvRQac/H9A27pE+ZaHQ0X4QDHs5KADTL7cS41FtPD7PBZXH6pbBEXsiMGIOLPKXqiA6knNJY+QvSppcSrENdcuuWW3vbyw7yU+WF67eUjnXhoMJCm3iIcrvJZzaRv6/h2zxEO6UwiYItMbPQRYB95YsLUClUWnd5o4L4JlFqxkNgKUpsU0e5yq4CeR2UWYCrGYDO6IOJRi4+lzE63cWaK/hjNKSj+8VshkJZ+bEB7H76g61D83WwKq8pboA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H57CLjJxcYbsxsHvSk6V6Q3ZtgYOSMNIPE0Y/lelWY=;
 b=WVuCXWbQcpne5t1Kz3oPnuPEmPnpzR/kRWCbF5wHfevOElkXrODtjrhvJA+DEAlcaDcciL2UM6aPf8Dn84SU5pFNnK1ndwdgmKHvqh9N6NrEjLNNBhGbxhQlbc9sCexolT36NWb4+5sd6kRv/Z2UbmIeCc+sfkCPAss6JZsRw/KktbJlz4sThlAl/ae7hRVxi8dzqYVN7Nsq30F0JBp2mqCsZV6Iae7B3Yy0i+FFl21XTStafiwbxvK38H6zttoVPdeC0iJdxLMhCAdTjHjSsrCROu0OwlgiuKlnRHwqz6nE9XVaS13u52/NxW6sGSJiC7fmw+739bbEwsdKnd6Q+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:46:55 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:46:55 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] Bluetooth: btnxpuart: Add secure interface TLS authentication support
Date: Tue, 13 Jan 2026 13:17:10 +0530
Message-ID: <20260113074718.2384043-4-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 60757808-70b7-4531-6f51-08de5277ec4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4la6oz6w8znH1uHXLa66YNNMUddz6b+qZjm7wI4AsUtz6jaL8YqNByWPYVSp?=
 =?us-ascii?Q?mYefOfieLvGBnAzyJZt+meWETLHeCtAPBiNAuKmRHG0sVJmCZVuu+nMQxkBr?=
 =?us-ascii?Q?dclbeBdnydAZqt4xrvK3Wy+7mWA01BQVh+ZHxdy/gdVjyxtDfZU6zATkiuMx?=
 =?us-ascii?Q?qty41gq9wF5+rqfYF1vN4gfjTBC4LtF3WKt8btyky1ALlFhWgw9WPr+DzfSz?=
 =?us-ascii?Q?cN2GINjbcKvMdwwEm1b3HqH79yITapjOhv9CZCLycKr/QaO8G/T3QCKfg3Nh?=
 =?us-ascii?Q?ilKAapyBfZkttiY6TqXfs+YCK1GGCghCkFw2dmftiAbMVKZmemYTmCTJ8mBs?=
 =?us-ascii?Q?Cmpf3tXMS1wjQBjuz7vbVrCQoFQnXmFwjgclD6yzOzUhMYbw+ucICjo18wUU?=
 =?us-ascii?Q?WdBQiv+4tW73e+cpYKOzdh6nibHeu7cG5mJ8XAAmqT3f4A8qP4G50oqYPnH9?=
 =?us-ascii?Q?D2omnR+V+ky8l8xtI0vs7YrF0vEFPZT2sGQG6a6dnc6FXy9F51tYEUjXlOF8?=
 =?us-ascii?Q?WKLCF74JhBD8FnVkIw3XiL3Ivsdo0mhehRGObVLd2PEg0JljAdR3t+fY0FmS?=
 =?us-ascii?Q?bU6cXDOIzkGOR4mTvL7+bzLuIUs04KeW28mDRlz/xZIvDIVp8TlhkQNz8yds?=
 =?us-ascii?Q?HeqBVcVjldtwSoM3eznZKbgx6iDJpaf1zNhBpgevmg4sBn2bi2V0EV+Cu7Nf?=
 =?us-ascii?Q?dlyl3eAVSGxYXARKcX8mUU0MIshJ8o44RPFfiJnGQDJYK7TX54uGCWFR7u/P?=
 =?us-ascii?Q?3LqyKuxAfH/F0y2Y84wriLQSXZgEyePY1LmVJ7l7FwROWWIJkABiJFNkxL8w?=
 =?us-ascii?Q?2WOXsthpOtfRrewkB5RdN50e4a13IdvFgPwtPYr1nAJrqAPbeGHgsZR7e7Qh?=
 =?us-ascii?Q?zvr/o1DZGD2hUd8D/Fngn0w7O+40ln1m6Lt/dLzfiX7E7Rww4e8IRC08FtBz?=
 =?us-ascii?Q?8mmwMdo3Wgfm2KphSQgNeha+YhKYZqZrIR9l+v8s/Rn13wsc5bsGPrc2RYyK?=
 =?us-ascii?Q?YFH7DRsvAvJhwXvhjYhpRvSdJWFjp0MqzBf4l+tP/egmAHhJsnanVkZHdqtN?=
 =?us-ascii?Q?PgZ9f/DkP64zFZw0/r7OC1s/ZjskMjX26naKxITDaBRnUG6Jhv5t711fmyrw?=
 =?us-ascii?Q?0Q9MSPnebVMyjaV2u11LtBABnr0e7Pkc70A3yeI6qtvcosUhEtsZSPTgYnSP?=
 =?us-ascii?Q?AwxJRCLkAaOTfju9Ol3PnUbGWae19QYpnwEgp6KWjLQMchfgBYz3g2ywERuk?=
 =?us-ascii?Q?N2U9TEIZq1CFDR6D50xO0hK7rsE/iWX0KWqf9JULydLNxJyXVv7tThPZyaRd?=
 =?us-ascii?Q?suuNh+Cz9x6Xz8pb3vjSg/oVvPaqQqeC9SSN62rH2MzUL/IPn8AgYWPYCPYW?=
 =?us-ascii?Q?fZgSGj7DuxaSo3C7qULD4OsGlEIqOIq+YJCVuS70atvJ1NqqWvfnVzUKL1+U?=
 =?us-ascii?Q?7PbZUZA8t4olFtSLUinzKax0x5qlHG1n7GSuFCFnYssLWUOyYOJAG0qUtD2O?=
 =?us-ascii?Q?EtncM0XoK3/9k9vfVS8724PoyAnXBkrF72vG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wUZ7EVXDzgFgNcMPOJF5ilZ30Xu7E+FE9lZQt1Nu6j5R4T/+Uh0lUGw9GC+M?=
 =?us-ascii?Q?KZWbTgLZvEi//rtz5bn6h2ZLUfjnqKOcqSwfdFtGMMVc+OkCTskWZuEBG36N?=
 =?us-ascii?Q?iRIfjvmuqmT7d80gM/YrIPwlY/SYF53VFDsu/8yJwislVvXTXoao+MG7qK/V?=
 =?us-ascii?Q?bC52k6N9tIik1Y3e0RR2k0CY4oAHSX3UK6A8ezbUYeYNUYFq+bnRJZjSWrHS?=
 =?us-ascii?Q?zMhzp7gr8/X1xMNhfXGCnnj4qEN0A82mImA6cdDtSCldIfiHCSfFuFefngI0?=
 =?us-ascii?Q?3Qs/Qo9p//Uyxk+L6R6XIxK7xX2IDKsLFLp6Jcpwp0Rrhz5avyiWylAiI3DH?=
 =?us-ascii?Q?yZ/uRf68mjNIfW2u+GpAJaCYjNAXLu6E5UhpQRxJMwbmt34i1zqwxdeV1YaP?=
 =?us-ascii?Q?qfR0HOrAHK9rggQpJuAklE1nxjU1ccPIwGHoPPHLDyUWaoZ9Pbu4Pb0+NdLi?=
 =?us-ascii?Q?a9rJ0Vk1PEjLq2HsilKRUUXML16waBgnZbtDALTXTJHbBFNJxjP1RSIb5/8R?=
 =?us-ascii?Q?/3+EmLqJyaxaxY3wV4KTzLBbvNxp66E5g2sSO85Xir8R9VHkDR9q628PWzPu?=
 =?us-ascii?Q?ya2KF9CvfR2O5rYNdP5L4vBxfE/vGLTYMUVdNIOpRBAkmHuxYHgqmZufiRzO?=
 =?us-ascii?Q?Uv5MaKmmpSH3mXI1p4BGkiqX2RIu+++x18jMqULBSfVPsxTbaSc+pvH37DbM?=
 =?us-ascii?Q?LBfZD5Q0rCSibuOrKH0v5yUtgBSoU8n8mHxTvdb2r4OkQG7voEcFDsLcL+ip?=
 =?us-ascii?Q?qvoww3nsMv2+XjZy5aJLnpDZgo8NtYY46cpe5ZmvNVpMqXgj2WwIl/ueW4cW?=
 =?us-ascii?Q?Uk0lbdlX+dD8YkjUcBeXqYwXZxN+ix/r8M/8i/jARinrhpPCrhO8EtYionSy?=
 =?us-ascii?Q?M4KOHxERnDwR7YGpxCp7tA0nunTlxZXv4LSfYZM95LrWdDAwzwJAQveFNeW6?=
 =?us-ascii?Q?xKn213WhwPH4MrBuS88uoh9fLe/FLUwO+erGYG+4BxvcJvI+Z9kmr9OuyQMa?=
 =?us-ascii?Q?BofmtlRcrlBV71/oa5zWmmY9D+CGHza6LxZ07F4XaWZGCAMbEJLdf6BLgwnz?=
 =?us-ascii?Q?uvyQ7IsdD2zUIIlx1ekSq8h7fqCkRDyzmHxUBf81TPhFPkL0ppmhdzfrnCtI?=
 =?us-ascii?Q?0YT8yehIkmRAUgRcevgSzJGjhOmPJzmQbwjN/GqYrDfjyNze4xqQEZ3oytxO?=
 =?us-ascii?Q?bXZaVUtbAL2pfN6mUBEM4iEfDJTBPnFRZjZ0q8TWXFo0oFtdbOxCpixQGwli?=
 =?us-ascii?Q?JePwpAhwZcdl7xGDoVfZcA05biYeUPDxZx0/78NE6U1LYXEvbuCo+wJmMUp4?=
 =?us-ascii?Q?WlMZiwytmSIVRMqRgrI2sX5XU5sAtLkmLpJA3K0f/gUChcm8nMm6OBpiMu1J?=
 =?us-ascii?Q?lf8ep9eA9Chk94Hh6osXE3j+pcSuhes/kf6wlK+/wrmZKDdyKZkRvLNquwJo?=
 =?us-ascii?Q?jqGvNuCsbC0hvovrOrs9nIB/9P6kE0EpNdkw1Fixbam7BRvFaVWTbsVvo2EH?=
 =?us-ascii?Q?5GqbDcFsxGo4qz0f+v2/XZ+W+h9xGgiNkJU5XX06MiwNWEZim39XwMV1bvgy?=
 =?us-ascii?Q?Nph0g1fOwb6+mX+IabwNSiYkHvEC3SMU2nTv6Kc1BWrmTxgV6v0arf2Wd0Fq?=
 =?us-ascii?Q?DjhUPdRMWOTuykvT3i/kUf3Bhd6XUiM2DrwTJY8Q25imVkZswHQt5qZMeEEX?=
 =?us-ascii?Q?WNulb2pi2+r/4ESsd/nT6NaK9QlNNrBS2pV/0LPrjFovBogP+nIEgZdAP9Pk?=
 =?us-ascii?Q?75vXp7b0WO+rrLRfgVyYmNKD+rAgz38=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60757808-70b7-4531-6f51-08de5277ec4e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:46:55.4794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CA4dgVOHpZs0Rf95im17mjz2KVCosSHFy+3F0PvI3Yr6JdKhsH4+GM0HifPepzK365tXJw7C7ZDKI6D/7NaJ8pGkZj6BZtW7i0GCSFITxXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

This includes a placeholder nxp_authenticate_device() function if the
chip supports secure interface feature.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index d2c79c462ebb..3455460d30f5 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1598,6 +1598,23 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 	kfree_skb(skb);
 }
 
+/* Secure Interface */
+static int nxp_authenticate_device(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	int ret = 0;
+
+	/* TODO: Implement actual TLS handshake protocol
+	 * This will include:
+	 * 1. Crypto allocation (SHA256, ECDH-P256)
+	 * 2. Host/Device hello message exchange
+	 * 3. Master secret and traffic key derivation
+	 * 4. Proper error handling and cleanup
+	 */
+
+	return ret;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1629,6 +1646,12 @@ static int nxp_setup(struct hci_dev *hdev)
 
 	nxp_get_fw_version(hdev);
 
+	if (nxpdev->secure_interface) {
+		err = nxp_authenticate_device(hdev);
+		if (err)
+			return -EACCES;
+	}
+
 	ps_init(hdev);
 
 	if (test_and_clear_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
-- 
2.43.0

