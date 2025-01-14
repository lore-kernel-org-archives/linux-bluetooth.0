Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE5232454;
	Tue, 14 Jan 2025 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736864284; cv=fail; b=Y1QPvINLKA44Ypyq55xKEGU7L4N4oLUQLcNYw3l5MSgJ6LSDtOPYIMWfx5g3phGpvGfktzX1NLx5adi4npOi5j6tufzf9vhu1p/cXv4m2h05wfHNbrH0V8z+ots6fVHpd0hO7mw3nwdxiEBahObt/DVy8cLnsQrnfGDDxt6cP3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736864284; c=relaxed/simple;
	bh=1dYxVfjEUIc8VhF8aGr6qt0qmx+WvQTgDg5c/X4SBt8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S73JDIiDTSr4cyRaJOE6q1vhsyuh6RXZ/SeqM6CbFxD6UtiRdHyQBAykmnoZNO8GdqwM+HZY3cz0ll6Ra0mw8xGT/SiKJB0udgGmT3rU/XpkZJUTclPzxiOYCS6SCg+VLepz6DaeX1WYUHYXgZEldVpVv8HFmyAJZF3bD7jctI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wft++RcK; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wft++RcK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ6Qhd8Oqc4X24JFUI6U9cq3COTcTKcB7RBsxUaXuvzfTb7bKWdYecwH+NZpHS6eYpLiN4Sd3lvftvcYcMsyhLbnncltccWCLAaRBBnSXivr94DtwZ4F8KF2uitpA36QEbA4C5YO36a/RqPojiYJZeo1prR01+FaA1v7D+s+4C0KVA17DLwKEDfow71PMgbmPLxtOB/jTe2ksJvsfMkr28bzrD6y37WOJZN3gYbRK7fQBWMUr87erf7Z9/0gjBoD8lURsM/ksxoU/zH0Wq7hX522KrvIjL4wvv/+dTtjHY+xD3cLAQX0t1af7hnTiKuNxK4AMty+yH9K+6qiHsOhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX6/rdb99FL5ntpQHR0dOfvcCe1/97B/d5Nw+rpI5Ys=;
 b=oeJQnU2NPPSadrNxnDlBmWVkAA38ep+Qzxts7g+z0nqZl52iE20a2veZEMMc7UUGhZ0aBjw2z09vZs1Kdu3ZwSV+ubzFWkCkli4PCGjTWOepShlsr5vMN2d/ifKJFTmEa7rIM+wBllGgn9FuUdegCxmJpQbZWKXOEE7BC24jDlZgm3+7hoEEsvzpD+04ANJuobQnYON9mS4vwZJf9If6ufk7WuLlPtIiB5TZ5b3PZ1kW7zHv5RzK1TEdLV8zLY1Tc30ObpB/18JoMpH6V2/XDcZST1YO7D4G9cOuHygY5ED4HIXHySQF9PZRR/lx4MzIIFMnftaxahNiM5t+V3CTcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX6/rdb99FL5ntpQHR0dOfvcCe1/97B/d5Nw+rpI5Ys=;
 b=Wft++RcKh10ZwTbb9nBH9WqgHjwsGqS9Y0kAAZvPILd+jfdk2GAdzSp6gCyoetlqU2qV5BLW3KTXZK9/4jLsEURqSeusbGHrjLyEsQBMO2S/BGvWweFAGxbFtK3LK00vyJvjehb/JyzZXL4n4CIducTgMleRXpdBA6x+OhqqqRTLGikwuLzdd4bIx3fjxiw441MYufvrgq8dnwE1Fn2wvaqvKySA5BFm2Zs6sRToZ+S4jMXES6auSoP0hhplxwy9OTF5wqBIN3nGdHc0SCY6ZcVR60bKIQphQiv57ASLhQ1rnKXr+dDgnvX7erf2WNnVwsESJEkAKYRz0JmJB/JkYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by DB8PR04MB6812.eurprd04.prod.outlook.com (2603:10a6:10:f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 14:17:58 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%5]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 14:17:58 +0000
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
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	johan.korsnes@remarkable.no,
	kristian.krohn@remarkable.no,
	manjeet.gupta@nxp.com
Subject: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
Date: Tue, 14 Jan 2025 19:49:11 +0530
Message-Id: <20250114141912.2363131-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To PA4PR04MB9687.eurprd04.prod.outlook.com
 (2603:10a6:102:270::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|DB8PR04MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac4054b-1250-4f9a-5adb-08dd34a63f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qoIE7Y9pJBxewAI2eaVWEG9YmM4mth82Z7dfnfBo2jbhfH4BD3yIdiFGD3A/?=
 =?us-ascii?Q?KLDhSCcwa5T60MiOTMFSbK5fQH8UM87hjhh8iFUdrMKv72pLNpE9VEDgHR4K?=
 =?us-ascii?Q?70heUIdJqlka++Xqbtsc+ss1pGqrMLLvdAE8Yqt8kYQP6gwH3X2t02B1ve56?=
 =?us-ascii?Q?l8sOjXJDo3MB+gjqcbSou8ndvDmPHlQ9YWJeP7VlPpa1a4LYZm643CedfPHd?=
 =?us-ascii?Q?51yj7Eqf6Ai9P37v/mYeL51YNnQ1au6EtouROMft2u5GrZuXihJ/KFeHfZtO?=
 =?us-ascii?Q?24r/byTdTFEVGjOd+yZ7y4rg3Bqxam4dOeZTL6vXMHcXhaFCuu+GNlh9jJD+?=
 =?us-ascii?Q?6qSEsTfRCNLTQVnuVvT7my/eLEhwn2UAeeDkdDGmrViYkgCrUeiP8ivTLGVB?=
 =?us-ascii?Q?AqoId65R2pD0ecJYALm5cSO47B0cAWExfKkK3/l4679RAqhd1XW20ThfG2Wq?=
 =?us-ascii?Q?F1MkF0QDRzZmUyQCpCm4imh3b9tMeUvoXEYYlJ/Bg7sFgwuSWNqBV7t+alBd?=
 =?us-ascii?Q?vyJt0+9ZyFVSDVXtaNa9Z7SEJgVlHAog9k1SFtH1h0gnTtn4z4QKg4b/GN0L?=
 =?us-ascii?Q?njdMjYVyKYrno9F11sWfOEMdtynAtGA5M4qDeZVd6DZ/4BqfkdZa9+HZzIbn?=
 =?us-ascii?Q?3AiG77Oj1cX5r0dTVp0JG4BX8yhoUsC05Eiw87IUjyvEtA7Vd0vpIsNIP/Aq?=
 =?us-ascii?Q?aZB2F/XICCzGCXoa1lc+N4IGoiUNNdRy1UNSbjrw3NhEY1oZTridDiAw2XpO?=
 =?us-ascii?Q?yhf54LOZ6/16c5gxDF2Y0GA1h2RirQKIqYpAoQG1XWlELkamYkhDEULG2GSd?=
 =?us-ascii?Q?/esdGlsArZbL1VP1qcMsyGAnDROe+GqXANdnenhVdnodQVuqt42/Hjis6lAi?=
 =?us-ascii?Q?q9fBdKSe7vZs+LxcB/zuuffCsj0R6OnUqs0DMUUClz1wgOknf8va6zGo3W9l?=
 =?us-ascii?Q?b/GaorrBqEYRbQq5GCTqtxxzvQ5gcCKUfDDoScvIt3zvGz1q9MrbwpzA/RKM?=
 =?us-ascii?Q?qgSc4MIIY/Ec0Q4tt8yaKN+9ZIwEuSuA+PejOJExtucQIEhI0WQ9+NL13Zlf?=
 =?us-ascii?Q?FLgT/fZ3XH/HAvj3wMFi1D05zJWeuM2YFowSmzWFtAsDG8MSvT3vkVwd5iWO?=
 =?us-ascii?Q?DRVWnTg/1CDF/LzRBi8pxAJxtnXj+GVeYClq2pC9hJD+B3YX00SHL6cXAFp9?=
 =?us-ascii?Q?ZX+gYHTgRpjUVjyhgt7NiLzf1FiGaysVseidavjdD5a4YWb1yhnbKPC9a4Lu?=
 =?us-ascii?Q?r2ESU4Meynf4BfU6QQA0sBuQ+SFnzV7HbVp+cdwo3+/n4ESBhZeJpcvhg2x+?=
 =?us-ascii?Q?GsfhMtKgpu6YDTQG8LFXrhfBeTklme7bsvLfiN7Nj0DIv40CWYoeiQrzrOMa?=
 =?us-ascii?Q?tR9kX320NgJ9uDZqrQh0VOqPzHdpNKOZ3xIik4ESKW+ItvlMVGcB0UYIK/l1?=
 =?us-ascii?Q?jGv+VViPjbk7A5NlGAx7pfd6lgsVWtCP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YEEr8QO9DgWZUtYKP37R7nYOWMa6EANYfhYwHYcc/txZBkoV9QPYUe/lNXx3?=
 =?us-ascii?Q?OOEGVfz05+u3/yOok49HlmE+t+DuLPTjzNi3KWEIAwDAiYcwZnGaPS8MCH9z?=
 =?us-ascii?Q?j/653o3BUqzoihblVh2LyS9XUgIM3VHM81jrhdJb7M05B+wHuy+b2ErznwBv?=
 =?us-ascii?Q?AGg00N2/cWHe/LXuYRP/yQfXOuy3rBrVhD7LGJiWB4UML5UEWCOMSCWrXoQI?=
 =?us-ascii?Q?TtsxbeC+u2qc95R9KhH9rtQwpWD7LR5a295ju1x8DN/3LO56maPq2w/ukVEO?=
 =?us-ascii?Q?xi6vLiEncDTs7hzm4KhAoPbcvEVnZWXSqJpjbyFPXO/kOAuL7HkctO6knBwl?=
 =?us-ascii?Q?4l+KFeyZK3cd/+CL7MZfwX7UErUacqklDAF+RRbwfb9D117gP/CX/OtTQ6J4?=
 =?us-ascii?Q?gIAro8i1vhthKP4DSq41SG4W1kOYmuF4XLCxoDYyMgZzcRp4OW7kqyOYipWF?=
 =?us-ascii?Q?p2n16Qhen0QiaoonXlYR+OTVKdk+zUsNsuBTfIcDyoRIirdZ9wVzFOGbxgsh?=
 =?us-ascii?Q?iZ6+6sR9miIrnCANoeTri5jjCIqy3/HsBdL8uaOrlIwiJf9/rr+h3sdQ0BOo?=
 =?us-ascii?Q?XRVPbqZXZW1Ig1g3apQvbX6DBmYQVsovCegaPlp/E68kJvQB1KGAMNVwwIrL?=
 =?us-ascii?Q?m7YuXm26iAz73zddlpLI/FVyZ2R6axvpoPntnoDDt6oKvMGACNaZYlycXvpV?=
 =?us-ascii?Q?G4Vnj9kLbneNaWqOa5BodhlLynLiAqufS0B2YXxb/IsnVYzCbHgDRZn0baH5?=
 =?us-ascii?Q?APIm32DKI22Fp+yo5sO3W8vfi9NGgbBhSlOV62QITe4HmSHi8P0K/wCyV4tB?=
 =?us-ascii?Q?5nIUSLAnclz9KtQETFbW4Pcg6tXLwqIpwfdZEHIpLXEOpPp9KPYp/yCdAdBK?=
 =?us-ascii?Q?1+0498TJVs0uE/DME/iCNJMa3VeFI0s/7lJ1eLMeLq07e2vlBR4het02JMuC?=
 =?us-ascii?Q?qWnooGL5SE5ipHbUB08JIa20hJaD0zdDXLeUk4JehZQXSJpm4AYjUslMcfnD?=
 =?us-ascii?Q?nclwyVcNJ1QN/5/BMWWkWAR7zUTo3HLGC6uhXTfKE2pkGgBdMcOTwz2tnEBQ?=
 =?us-ascii?Q?yg5MM4vUtZCg3qI3r2KMsMHvJKJEeOKJGOjnUfi4oC0Scq/nbe0qJxx3xl/W?=
 =?us-ascii?Q?yFFJHxaAkj5R+h6C6W3fcGEfYhlTb1TMM9gnvX6VfDgI7PNgXHMeqAhvrhnL?=
 =?us-ascii?Q?PkHfpp8JshfWQ82GDhgSkmEDEcUIYb4YewKNG61zamxSJYqehcsTyY50ybQV?=
 =?us-ascii?Q?P0XkahwhSxnDGD9X7L6JyvyvYCFBA6jFSQXTeLaribuwRGnexmXz/zJUIBOs?=
 =?us-ascii?Q?UMIMe/fN822zeif2g7x9+5QtWc1qM9p4bj1/X5Rf6hI5kQSh0cB0+YgqJiLE?=
 =?us-ascii?Q?vQtTlMy8n7Y9JHAZahAhKNYHD5/0QM8MijUMb03PhvZsIrdjDBXYQ5yxqMwe?=
 =?us-ascii?Q?cIDja74C/MdLVoHJLMvJFzRd0vAbPqD68T7BgFc28zEjZDbcNUhJXkf4jq16?=
 =?us-ascii?Q?8Rb+lLjwSY7pXmw7PU83KUxYWhbQy425plqThsIM489sqNJ5hN1yzBJHzvhV?=
 =?us-ascii?Q?zWqtDa1jYn/VHZzMw6P3Z3vwTGjsFuIUR0zZ6P8uCLb6UmEnXYLVtBDZQVQR?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac4054b-1250-4f9a-5adb-08dd34a63f27
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 14:17:58.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HuMbL2pR2R7tmHQyiRJct3UwJ85rq9O5olJq9fOZW+Ku0bMJE4IXO4sc3Lfn7mjBTEI1Ev56MZMafxKykM1Ox+d0nGdDzUy1ZzSnbCX42bc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6812

Allow user to set custom BD address for NXP chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Add allOf and unevaluatedProperties: false (Krzysztof)
v3: Drop local-bd-address: true (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 0a2d7baf5db3..499c816071ec 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -17,6 +17,9 @@ description:
 maintainers:
   - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
 
+allOf:
+  - $ref: bluetooth-controller.yaml#
+
 properties:
   compatible:
     enum:
@@ -43,7 +46,7 @@ properties:
 required:
   - compatible
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -54,5 +57,6 @@ examples:
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+            local-bd-address = [11 22 33 44 55 66];
         };
     };
-- 
2.25.1

