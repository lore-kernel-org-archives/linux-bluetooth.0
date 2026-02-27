Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011047.outbound.protection.outlook.com [52.101.70.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8021772A
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208268; cv=fail; b=CwuwktNzF7zO4FgkOFBYzPgG+jGPNTx6e6Z+YBt179gS5Z9hGzOv4PEV+HtpuN6GEfvcvpt3YdgghGUgwE2uVzH3Nyas4jWUFCPXagvZRn6EINrDOKFdp4K6tayZSIK61WM69m6Nx/+Mow5uAecOaL5tWT37n8E3sKNiuKMxyfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208268; c=relaxed/simple;
	bh=MkRx35YqN+5wg20LMCr1bsxZQpGU8nnwR3QMbgiISU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lwcmaw1juSeh8mb/mgaAJP2MepHgzfNM+7OB3UbdZgvZBKm4IcGycPBwhliAN90gLiClyVTUX3zL5NTKtfyBbuuwx565KsDdgRmFBmNKxWCZmutoHI0bgRHnA5EGv6VabEUCJuWKFsCgmchMDQV7plV41ygTPia7Tnrz+rDbgZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=OGqmqB8s; arc=fail smtp.client-ip=52.101.70.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="OGqmqB8s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rhElr4n0owlbolrvNdgMiKUjuSkMIooAY9kQ4laQaVN49jgQs46hIeCVlSnWCNn8lCRoOB84z1jDcy5rfonTkif2PYQWPDMG06TDG3YFc98yR01MHmoQxr/2PsFWYWJeRZNTgY2yQjaM6tHmjZY/ZwuJ+wjX0aVmMi6ThJp4/weby+peFirdjRzJPXJf8ZnoEtfEiMQudIWeMoegANwU+orIb9D56AtKVTdIp6tWvdVYpbSGsxAGstdUVC4fof88lgOZnlBLUfHwpKSFuaOhOqQK3zrBL6rdj450S76NoVt7y+3gfOWf5Dv4MEHfDGoP3BbD5Hv+qRFr9XHoPJLeDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCOqEUvW9WWAdpvx+aHAf71yI7QMbT07+wv0BHg34GA=;
 b=K5TYM0mhi3H4lknnHG/idJ27sgVSzRJoC2MQcjzfVcG0LEbt76Dvmje/JENnbG6ORBT7yz5Bq2oyMU6PhefdT77JuRkad5Vy+KDRuhskzY0sduK/aggf6Nt7LTBQKTTSKXi7HIty606sWktWA6dBVCbDVE7MzKlGTBJGDupRI1coDwqAQgXc9akLDwvT93dSRefT45VqbK3+7nZHf3r3RXxKaR9UY6OEaXTbNGnO/nyNzBusR+zcWGhsi0q1Ytc8QV6/lAEtauPdQZQyPWRkZ+HEMk3ZBHbO/nIbRQeb4DXRyQJxthl3sF14aO7fduHMSwK/NJ/SwYOFOlFM5aM0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCOqEUvW9WWAdpvx+aHAf71yI7QMbT07+wv0BHg34GA=;
 b=OGqmqB8sLv1cCAPkFe1yPPzqMqNSy7/90sBwbUDcg2ua/jES7n2XExHHUfd+kP/sJwkQWmks6q2r5GA8bdZBwrNWgpKX089Y3pQObByBtxd1AmR3lasJqJGC5/U0N7BlKWI6pmo8hl0QPf7e7z/QNSbyR1nrmM5SrDpFNYHN4PI=
Received: from DB8PR04CA0006.eurprd04.prod.outlook.com (2603:10a6:10:110::16)
 by DBBPR03MB6714.eurprd03.prod.outlook.com (2603:10a6:10:209::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:04:23 +0000
Received: from DB5PEPF00014B8D.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::e7) by DB8PR04CA0006.outlook.office365.com
 (2603:10a6:10:110::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8D.mail.protection.outlook.com (10.167.8.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:04:23 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:04:22 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 10/15] doc/qualification: gatt-pts: update description for GATT/SR/GAN/BV-01-C
Date: Fri, 27 Feb 2026 16:53:56 +0100
Message-ID: <20260227160022.21462-11-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227160022.21462-1-ceggers@arri.de>
References: <20260227160022.21462-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8D:EE_|DBBPR03MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c657ef1-af36-49dd-f7be-08de7619dfc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	8Tkxryokp4qDWDy82ZcLtId7WctK6tK5uwd+KoYXrJe5bPuz+2uK4UzFv5j9ilu3wSu3kZLPtQOlnPrMvrsIHFzoChWlIdeknt2eNOduEaWfr37S+n921/b1kyWEYcczcSivTjS+BXi5MTZ0HnOR9aPzmA7xqKZbLFjoauxu79hYIE8dL0FFr5u9jBpMTTLE/1zw/oJLB36dAkk7piS2wvew9cLVcriRVeBiYTh+eGZUL2XbPdbzNLHCAdEOlsnDRkkYgIGCR5WLSalNVDsVWyKErlRDtULBkf6L1tUkDuIkZvvaeiw2XdjMDIhUt2l6mTvnyRVN3Tg0X8CaZUsiavknln05KP/uPhuRPUiTSE5GIIXamLORdRFo96gbm1xr58dr0N47QXpnSrNPdVDHZuVfMIZgXsnO4Gh11hljss89e4cqunLChkjNnFfwV6xjezzeGT5dZJIXT8koMy60ukx7hYwIMzZZ1pLDUJgPg1tVPEHhoDpoJA+h6J6t+10zyixQhUnQNXBAzvxtDrscW0v4wMtLjxDk+8bTXmHEVlZuPJYR5fbrJEhYNAPkTzPyBc40aGd+nyj5ADCwvdZFQaJhMLDyh0byiGKyV+snayuAhgBi7WoFtAytrzqGcjAomvke7YzusekBP+R9I/nLIlWRnnU3SadImsddqcNhgD8Fhp6OlNfp69rpJWFFbt+GCukOB9vsrfoofuvsPMD7/ryExcwCS5TEi4ek/07K07fIdCQyAjUorF1ML+HAuGkALFzdNAnmJIZ9DayeC7iaBdt68ft6GOSuV06ETaP2x/rsN+KohG8R37Nujrg0cnbrjR9nwSucE2OcCGmYHhePAg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kF2q17CtZ93ETuhKiDRUp6zByN0wSX08DC+Jl/DJI4APOhFNfQwkyfbVeFMSfQaXv58lEgNh49u1ETEFuLgInZYHrB6fWucJgq9DGLut2SMaD8n0HUXCrfAE+jbqFta315XrPrWy4PikzssZ81gutPpWVLh8llXpfiiH1NsasvY0D8ZsV02fTuyV/2IJe1N5kgdPM1RyZVml6IDX7wx3jUAYstS/qifGvconP+4cGZUrY3r3VhDqj519OWtbr80xqp5sZ4wUfWPKtTK/UFBF/WYB2ltz+sPUE+gxfB3PHe2+sxGqREUv4WJefluhix4rrWTFUs1Y0QAzKVJQRfi1IsiffQFIrP9nj1TlOfV/+Qw43DVbaMhnb69APbYJJnDxKKfcj+D22KQQ0T88e4M0Gm3UTZFtDZIJ7ZaFVFCNGNoI5068rLKpNpMUvVv7qnSG
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:04:23.2885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c657ef1-af36-49dd-f7be-08de7619dfc3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6714

'btgatt-server' exits after PTS disconnects and is not available when
PTS reconnects. Starting btgatt-server again would solve the problem,
but we should prefer testing with the real GATT daemon instead of using
debugging containers. Additionally, this solution also works for
GATT/SR/GAN/BV-03-C (next commit).
---
 doc/qualification/gatt-pts.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index 239d7c154da7..7a2f28257338 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1116,9 +1116,25 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | Enter '2' when asked for handle size                                    |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
-| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl advertise on'                                         |
+| GATT/SR/GAN/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
 |                        |          |         |       |                                                                         |
-|                        |          |         |       | Run 'btgatt-server -r'                                                  |
+|                        |          |         |       | - [bluetooth]# advertise on                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-service 0xFFFF                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - *yes* when asked if primary service                                 |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-characteristic 0xAAAA write,notify         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - enter '1' when prompted                                             |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.select-attribute local 0xAAAA                       |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Wait until PTS prompts for sending a notification                     |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.write 2                                             |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAI/BV-01-C    | PASS     |     6.1 | 5.69  | Run 'bluetoothctl':                                                     |
 |                        |          |         |       |                                                                         |
-- 
2.51.0

