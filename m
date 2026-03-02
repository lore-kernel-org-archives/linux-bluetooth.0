Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926DF430BA2
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459297; cv=fail; b=s9J22u9ffv8wPASV5rNue804m2JoAa2pYo/0l5ZCMMbzL9GJs2d+6SmiEXkVt/KbbdHYeY4nFLj6teagkSMlyVrE4XDYy3HIEwSRW4QGVBaAwkcv5yLJpSGid/kq4Az6eLqwLWpW7aNJwUjjSJyFJiUVlgpF0QQVFIAeCZxwc8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459297; c=relaxed/simple;
	bh=R9fj/18V+QYFC4btnyUuUqVH+siCLv/WovMSQqaJGlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJL6stzAxHSvU81chKu9tJmP6ZnZFVZqNgXMaaFWYKQvppzAsHo0T1J5AQyIvgX+uNc5jhQZ4YIEOjxWhXNoQOPNK84ODOCUEmYDA9pQudXJWeft/VBGt15rKjk7eVFquZAQUVUGE4nt1PG3ry9monGXcDu26/5XezQRDg+IaCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=pwwNJbD+; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="pwwNJbD+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwIbpoTxPraP8rz3OR4zcmNajpV1XP/5feUecH9pdfcMCPECtGt5IuROEnLQ3uwXT6O3sxpphTR/YEPwaSFP0yWXOC/1gso3A5e031/GYWi9VZ5qN0IF4N2sRcB7v1KeGox8ajQjoiIRBm85l6ZD9g5eLiTgZP6oq8lqVbk65YOpbR12i8xw9UxmvrZlJoFAdIDHuE+gnXEENeVcNyjvNjB9IU4LHAsyEiZGBnQ7D6lifXNYWMS/7Bff8PHfXx6pNZAPrBZYKQvnlcDAkoTfNigezTXT4PZsimtrvbhuxtg7LyDSNQE2gedeyx5GrAqDIZeQQIGVXOiS5f3vfsRGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKxEVtnzTvf8O51MAV7jObRwz26WsACRkemaWRQLgK0=;
 b=g+aS1mtEHl6NRZ0ItIx5JWLGETG+e0DgDtO32h+K0Q9xZKgbFV6vYO82HSbodn49U3C765Fnhe85JaDfG4kQTjC2uqtjLktUyTHdFYF1y9bjnnCOke+MxW4GMEeh75Ix25kQdeVj3ZYoIO9ziLHMgupU0rW+pLPODXzxZvVaxQ/PW/rqHGsL2+SArlpFRAtAkYx9ZAmJBMY8t/6sOgni20f7GYzPzxY9ZSXh/iW7oBfpTo4ChcuF3pgO8+yMOC5w17JRo50IlhptIejo1UrrW7JwQsCsmsL4FQsKvdi4/QbREtZPnOztKBI5iy1wSPUvAuo+ZYyyBwf5qQGYsq8dxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKxEVtnzTvf8O51MAV7jObRwz26WsACRkemaWRQLgK0=;
 b=pwwNJbD+wqgdE2jpu6scqO7J1wvnBbGhvA1z3QfdAXroH8fwiwwJttHoSgt4Qd4Ygl3QBiNkEXGTGFaIPAn3dR2nnIlHYR5RPila6Edne3WICOfDJ8iXFn5t+7jN1vZVaOjaPDOXgXg+zcAN5tTBeNFF9M/1h+6ePP+0/ZO5bvs=
Received: from DB3PR06CA0020.eurprd06.prod.outlook.com (2603:10a6:8:1::33) by
 DB5PR03MB11290.eurprd03.prod.outlook.com (2603:10a6:10:64a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 13:48:13 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::8e) by DB3PR06CA0020.outlook.office365.com
 (2603:10a6:8:1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 13:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:48:13 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:48:12 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 06/15] doc/qualification: sm-pts: fix SM/PER/SCPK/BI-03-C test
Date: Mon, 2 Mar 2026 14:30:34 +0100
Message-ID: <20260302134540.25540-7-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302134540.25540-1-ceggers@arri.de>
References: <20260302134540.25540-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039232:EE_|DB5PR03MB11290:EE_
X-MS-Office365-Filtering-Correlation-Id: a2268832-9200-4bc5-c697-08de78625943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	uuROH2nJgaEa5YtJREbj4fefqdZNWqf3onCexCW3XR5B6kJ5xD4pCWIo0096QHKYh+/iWbQhAdQYnb5As50vkMtIfcKj0tLYtyxF5B4L17EdAWM7+03nx8xYFpgaQvaOJ4tvQzecGIzXvs8do7WhHZWo8BFdvDNUfFYzlbEz5GCZKEDt3E3gUF7eGoBUn/j6+WAGhAEsGXqS0ywyvHYc9KrkR2LpcQE3GqUjjlmDegj/0krB1VDAQh4HniMifHUTXhfq4fPPIGkqMCY2XCIcpl4ZIJdjHA43AM5zp778IXNtx1UsnNqJmx2HhmELkZqj01pcy2daWwINf6R+Ohwydf5t32p50yIPNgUA1EyMyY5iMGMIWoJsBiH4x9KEIFbhotNXsgJBlRtwetcVr9TOQbcANIT7TeA9slC70PWEwlNlcohaBTdu00/N0kB2kls997br/6k2+OkiF3aP79zFNy2DzjI91AjMWQKClBaPFLVoBElMQqrnRvbmDdcO6tKE05IDKTIqVUmdUbjp2GTWRzosdDQHYzcyQhjbjYMO79NSg5I0iYjt3gtGllEeQ+JPf5qyhVY+a9fR0smJKWSJYoLPZjHO6Vut227v/xblDrmKLzvJt3EirqakhfK+V1hE2IQ8R2XyHSqdzB0MOXbinK6LSCutU4w/dKRv/lr6ElvNeJXP11La224Ao0k0B6KqyaZKyAipoySoMwswaLSvokDfTdg8+uzfZ0C5xP9GSgm4NW/2KVklYAHAlyKLSc9zw6aZAhhiu/yUEloOOjJeNodG6ko2v5oEZ9mWuswocsP2RBOclk+kwx/uZDmUNi8M+bV+MRe++y+WDf4BIsEL+Q==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3ZXpwS5jvJ2Cc0KRMnKXvX8VGaDnt7OH+bID2eCRIAdaf483AcwX99mYppA8tGKqcSr3tJ8Eq4ibJs7pxymz1w5XD9GRuxXisiKMz3X1ZJRyi7VPaJtKc6sr2z3yMUynOgTwiPqgWBxp9UJfiD1nEBVH5zeR4gvU2UBbkqKOJEx+vBw5J3QRaL3BbGEoQe4DsE2aeZ+C+ZQhwtwtDHMeQ2cc+8tva0NkFkG6NEipmVVhSAyZxCu7ssX3XCBUce/eJEWCcicroSi06jZwPpP9Ovth0yfPB+ShSB/Fdxfsu15xTKXewgec1l0c3HlXmoHMDKrYQfEVVyk+8nrQWCPcAq1J2ETRxh6xjWMIZrekV7SzhShxVwKQmrHlju/EJO4z5v9AF/cadpwRER5CxdiPNmj9y0G0nk1QWAtncgiYHXytSphedhMcFXj8HfWIislV
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:48:13.2135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2268832-9200-4bc5-c697-08de78625943
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR03MB11290

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.
---
 doc/qualification/sm-pts.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
index f961a2613d2b..0fa37fcb0a7f 100644
--- a/doc/qualification/sm-pts.rst
+++ b/doc/qualification/sm-pts.rst
@@ -767,10 +767,6 @@ for which we know the test passed.
 |                      |          |         |       |   - bluetoothctl advertise.discoverable on                              |
 |                      |          |         |       |                                                                         |
 |                      |          |         |       |   - bluetoothctl advertise on                                           |
-|                      |          |         |       |                                                                         |
-|                      |          |         |       | - In a second terminal run to be able to see the requested passkey:     |
-|                      |          |         |       |                                                                         |
-|                      |          |         |       |   - sudo btmgmt                                                         |
 |                      |          |         |       +-------------------------------------------------------------------------+
 |                      |          |         |       | Post-condition:                                                         |
 |                      |          |         |       |                                                                         |
-- 
2.51.0

