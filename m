Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB261EF389;
	Fri, 28 Feb 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756458; cv=fail; b=ijo+aGZmU+1sJbXRR7es44C//WiKUKxdIIW36q1hCymB8cPKSKkHYe8aQzMwzi9F/pkGA6EPyQSP2zDUwDDBNug9EhvVdpI7Ot5ZS4C+FxbQ8/+wV1JyehaxtL/W11Jmxspk7/lkOvFdSJW8dD1mjN3DX27ydrCAxdfXKBDqItI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756458; c=relaxed/simple;
	bh=QKilRpM1GOK0/1eazCteUzILU5562UmYG8xApcNXkRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=o3TJZKo7PM6R12lHFX4pFUWGUFy3YqqcfRAd7eWYMWmogNDC2JmEp6lskA9qr8Y76ffQxmpczJ0HsW1ov75Yhb0q7ADy7FlVrJxUevcpruy7iNptvogjwQtocc4uR8zaa+3XZEbjQvK+FxZI//aNxTHBc2YiyQh1H94fwzsyFtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MYMC757w; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MYMC757w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6ty6DqxZ2cXM0S5TZe+G+NbMRsnOkfNeh13AoQ9r72TBxr1bEmtzwXmewptz+DCYaPhI8MdL3IZ0V+k7TqPsM8w7nA7hnTrH0ZEE/EKFa0oGaB1GDuF8GGSOuO4WaX4MggneB/ZIhlmshw05/j20nHUvNrW9W1PMOdcluwaFk6+Nj7VR9aAkj1p9zZd/OLXuogjCUKnea03ERszWzNlYaP0TL/XmlmXGefZEacZz/8nGeeJpDacSFwmClBjm5DKRmcW7UV3zsdXtqxOziRIJ3gNLWfkmj/QMmXtugnUeQJDLsMhvS88OjRrxK+VDdRdABho+rbMXooRU7qzOgyG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=238kcuI9VnEgk+SX0WJmEK10qL4LdeTDe5BiGl/SIVU=;
 b=SeXoyoZgiPdkS88FHc22hwRRNCoosr1N0sVIKFmfWBEeHluB6DIV57E5IuKwqa/OW4xZeaI1sPzWaI0VZqpXET3bzDSgBOrXskqxLJMVEnxTWdsJbhI76JX039FcmLwhAJRYbGcNqO/LQJI8Whc+BJYsN5jziyQWwJbM8zy06ivLqrxYzGgyODUlzWOK2b1xm/RQX15bJULYFKnwX3SFwtbMNAxXofdKhi8GbJ4y5ielgSnUM3QbglHWZVNuspBRpI8+GTJ9NNMdPRNlag9vv7Rv+xNwOtxQf+ESL+hFB8D/Grv2ZEv3Rk2GbFdz9UutbgKFGgQ73wwkbPiMi1ijYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=238kcuI9VnEgk+SX0WJmEK10qL4LdeTDe5BiGl/SIVU=;
 b=MYMC757w3ZB+qXEBpE01r/F1Qgmw6CKYJBPS101eIttXpjmiyVaZUlR3w0mdMfbP5lDKFNsEIDsT55GHfHAnXtYf32Xg6DLdAivyRsVzJIGh3nxeg6+jqcDyNxWHE/57NOCL6y+KZGYck4kLc647coVRd/VRAWYfBUvg6NrC3/7PklEc91+jEaxvpa56xZdPQLRTyyKFyyewyhfM9K60nn284uSf46zv5CLll0rUsIOfZCgCZLgWsqS6dLAxi51U9r6KXk9XHOV6IyM3SuDDPiFqha7LyJna+BkJDb1xjy1iW1jfZUkH5XaIZtSFtIQG/OjVojvYC6UdsaPkMP8pyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI2PR04MB10810.eurprd04.prod.outlook.com (2603:10a6:800:27e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 15:27:31 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:27:31 +0000
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
Subject: [PATCH v6 1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
Date: Fri, 28 Feb 2025 20:59:16 +0530
Message-Id: <20250228152917.5432-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|VI2PR04MB10810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d46ab97-4cd6-4aad-55aa-08dd580c6ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aE7B9FDBPcp8V03I4yWuVAIvnnm9qrFmLCr26ar3TcLqGBGWHPcUHsZoOwx8?=
 =?us-ascii?Q?W1WMHOKDd25n/mmYzw0ENYnndtqjXJ4iWf+9SacKqlchx6WV9F31S3KtLYBU?=
 =?us-ascii?Q?Y1ROvdW3w7yuq3MOiXyCNkVPJtOFWDh+B+Bo9XixNrUQnjriSRHzGHTNktr2?=
 =?us-ascii?Q?MXMaH0S0wrqwCFbiZwQsS8bsSlay9Q15IdY5gVzvqGpiBrkx966Hkw4XViVR?=
 =?us-ascii?Q?hdugs1j5n9m3juvSBBIturI/ZqxV5wVXsBbbHmL1Ya0U4zBJ4boQWarNJ35v?=
 =?us-ascii?Q?7B0ZMFB/K0u/BBUJqNoJ7OieitQ9DdRbkdT8r6dsd4hN//dlCufav7dcAYXy?=
 =?us-ascii?Q?7KlBtWWR9zW4gEbGeoLhXqIDEc3Zt8RpadmlhcLnHk4H7AE36bAFKbApGjmU?=
 =?us-ascii?Q?r9q1EKCRjomBE08FHka3xQztejHE/SsRF51rRq5xHKwfLZVZVOC/t+twRaza?=
 =?us-ascii?Q?zEUxGVCV6Hw/laaHBeMfNH3+W4cG0qmdQNtn0FLIVXjJsqSlpWBGg5lghWOj?=
 =?us-ascii?Q?s9M+099MoOQREKRhVzvrKOzHuXp6AEWRi8X6fPEqUHs+Se+WsvEoCRlcINUp?=
 =?us-ascii?Q?487tXU4ZGxEOkDmiCeL1jXKd+qDtphLIz2kutdE1us19je+A1NCtGvsUhqcy?=
 =?us-ascii?Q?UAuOVECogKU1kr/OnYhwnDNU6eP3Es28TOLc2TskHNeTSeoAm0J8RxiBR+li?=
 =?us-ascii?Q?UZf9EI2C4gECxzlBceVB40dxvMNwyP4QZq34u8/G8Km1OTuV6rTg9VzZy/7B?=
 =?us-ascii?Q?vrhCdojc8Ivap+H+hsiwjOtuIGcd1l4iV+FjJwBsQdaNrYGD+Px9JOpfRgYn?=
 =?us-ascii?Q?3/Xp+OpdB8fz78F8C7EUj6umYn2EPbGkpQpOAK1Xslgubc4MWDDG1wrkVxZt?=
 =?us-ascii?Q?dCsNAT5aHIer4OJmMCZpDVM8XOW1g0+ec/foBLf3+60cAWLNH3L/nozr4Alw?=
 =?us-ascii?Q?mtl82TdccGw1O3ewPNEEQ7eJPWpPWJsK1F89K0AQG+P8t9yOea6Q+uHTfqmE?=
 =?us-ascii?Q?cAk/tCqDs9x1t5VJo3E4qRP4MmOFMuXyY0iqGHOao8Xjr0gGp/iaIn9yhXYD?=
 =?us-ascii?Q?sTaN5hxMBgTQ9Gwl3WZ865qiGWn80qH8/r43f+R7kMgOV2F1zLDy5JJi/Sy1?=
 =?us-ascii?Q?8fWmvMMK0MwMYBYodSNPjF9/4rPAkDHQ4k0zIXJetkR/XECj78ZPJ7kJ5HIq?=
 =?us-ascii?Q?IQcbrWfiePwXSIO+Be/C+I3moV53/MNnkwqyiVhEW379P/18e23qR7ZICvTz?=
 =?us-ascii?Q?NrajN/YnVU0UV01xahh9cQRw7xhiONVTur0QrgbubV9BXmKh/H42WWwAFMG+?=
 =?us-ascii?Q?dnvN3B/0yEb0gUUWyK0CjYGGIsbIrmTd4VSVPdWMaF2XFt/hSCv0hZbqyBNX?=
 =?us-ascii?Q?4oI6/hNWaJELXOTMrT/KhgwimeoOHTxRcT7Kk8LYffWNjwqhpMjQNPAE6oni?=
 =?us-ascii?Q?8QWRsGWp7XDJpoE6yLTQ87HRIRoPphiI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/5MpedWgkom4+mu+uP9xjAHLDZTsgNiQs0HE6edxxN0abUxCOu7pwG4bzGE?=
 =?us-ascii?Q?aFJw66MhkJFd8n3ms5s5DBlmqqmwgf/0JJQ/JeTNjueemcgCqkgbvm6Ndhnt?=
 =?us-ascii?Q?zTsWZLTQqDIwC29IeE+pbEl6xZ5dfu8rKazy25LjDCKdSj5SXIPMVb9BlbO/?=
 =?us-ascii?Q?9u4xu7eoP7LiXcWkgAExqr2+xE6qTU8+h/SFe4yxTmEMxjqZVgiHDqYIZAFB?=
 =?us-ascii?Q?5MneFHPZwRFf0Q7QMwSgG4hDB/n5Fjl+TntzF6Jp7LXzFeDs3LcP+P1gXSCI?=
 =?us-ascii?Q?ZXGHt+Cdvqm2dpOeZ9AtKlySqI4dwP9EJaE1T0XI/0mrSeYf+eH4qUWSCVi2?=
 =?us-ascii?Q?5ZRj6Z0/5jLzhkaHqcdaHQLzu2zZUBih2azQ9zPpbjZd/+9tO3pX3vGS3jVH?=
 =?us-ascii?Q?IvQrhnfd7rPhD66Mu6aDUyB47Bxy5ynA+jnDODYgfJCdRKP2YU9UhQW+b9f0?=
 =?us-ascii?Q?4HbaSEuLKfBcTou2fSS/8nhQeu19Oi3av7D+ujWR1+XrMn1n9usWJIDyJOej?=
 =?us-ascii?Q?DWMzCb+Yo+HCvt3SG5sxfP+ajGg6p+rrLjgGY76zuFt7XPcLO78P1Jt2ch8k?=
 =?us-ascii?Q?lkqUiItlUf9D98FNnf6IGHvoWH3jN+a/cnNDHUkErQDVriaIUjP/xd/YFV0Y?=
 =?us-ascii?Q?h19FJYZjPTWm8DBIvoA/qVZouyhVSuSWRoHugfyF8OT7lQ+VCExEeWRDDCoP?=
 =?us-ascii?Q?3qzMGxDiOFsgbVBpmMsR1IR1nT4pP2gz2s2lO2rbIkS62G8APkgdTq15dD9J?=
 =?us-ascii?Q?hxhlgu+b3t8TXZ+yC61hCRlzFFGMXzU5kfl6mQ3t06slSL2sG2l0WMqGFkr7?=
 =?us-ascii?Q?TB9/EeIiRqrLN+0g3uHmoE9RMI4x1/6rbxy04681cglOCfYXWEn5I9m/sbDI?=
 =?us-ascii?Q?MErrSb/7CrN3M2+8HkYGk+qum9LdiadqW0eebRy0zik2U8uXajZf9Zzom4mq?=
 =?us-ascii?Q?x122/N9wqAMXF56GtYCZxcngcIgK/NPOHWGcHlg27/l9SaZuNX+TSg3n6LDZ?=
 =?us-ascii?Q?89cR8kPe/VZSGv8IsY2QeyWxLia+mooB/Q6IB2EznE0OH0XghG1X1bk2/tZQ?=
 =?us-ascii?Q?vKboT0JDA4HR2lYtrJK1fDYFJZNxQhWcEXNbrbgV5onvmFLSqQE4HIezTHpG?=
 =?us-ascii?Q?OWOD1cWnEVwmhXd2ZipKURYlcKDfnXUZXNK50XAdIiJ0LVjJ0QAqIQrEsH4F?=
 =?us-ascii?Q?rOmp4vT4XS3POd+tQ8erODo+y9KGXaWK9sLOo3kRne7shf3piuZknzrSFnz6?=
 =?us-ascii?Q?aNH3E3Y1qJyxTbmJQvvdgWkBHMeIGFh1qlba1o+qK5+Fps07MWT0QuU5WVu2?=
 =?us-ascii?Q?PmrAQDTII6HUSytQGT4SM3rPY97itpSiSl/f87248SVmh3CwEGDft8ti93kg?=
 =?us-ascii?Q?foxs7LVfuaMRlLLrNlKwDWmCu6I3FQhbFs82GAkmGtLMePZ+5lUHUPJRlDlh?=
 =?us-ascii?Q?bJMFP+XBJRoOQozUNUF9w9aKExsN409oc7bGKaZ7B6hH6b08gt0mNcp/Rzqn?=
 =?us-ascii?Q?wAAs1AXdFvG7/EDdg46XS5YlNyjZ43qIVzh3huwgzGiHlXisZs+sHvzYdfn+?=
 =?us-ascii?Q?MpUA97Spg2y6bvt0DepqqiISgDxzBkV1DUkOlGaZHotpLkiN/1ZM6XemtxUC?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d46ab97-4cd6-4aad-55aa-08dd580c6ad6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:27:31.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+mbXd96iqoTggwIzL8KflpqknZPLwAPBB1rVIi1aKSt2a9hQsrRleueK+IG4M21zJKJPu/GNHR56DCsJOsjPDzKGpwGJgLf6fVI36DVvVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10810

Allow user to set custom BD address for NXP chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: Add allOf and unevaluatedProperties: false (Krzysztof)
v3: Drop local-bd-address: true (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 0a2d7baf5db3..a84c1c21b024 100644
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
+            local-bd-address = [66 55 44 33 22 11];
         };
     };
-- 
2.25.1

