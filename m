Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013032.outbound.protection.outlook.com [52.101.83.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A044BC8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208166; cv=fail; b=GDi67BkHuglO3xs6Pf5sD0cPVRltAObboE44+aDBYRAYZtNGj3HyYU/y0O3MuoXZHmbrRjE3yMgwBF2w86r/0BNErcXvVFZus7ZrbJFncp/VRgSeJO1zTUi14eJ6s4KSEnzWkH9WIsJLnq8hmOAFCm4Aox0J4tem58yziV8bZEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208166; c=relaxed/simple;
	bh=9uHMzB0I+3zxTo5aL5o56ILGXiMFs0HgNqsCaH/ceuI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIbDl9F645FI8RA6V4DeDywf+SP4DzjPh4IAUCozw9gswD02iQ/BWQLmAxAvpkPVMLrbE9kVEFi0/WZMa0Dy4mNauwKgneIm8Dbi2ZoNs56qTegEpcp6rsMbpw5EI0rwRj8wAZJioQcEZX7Pt8+vbh2SP2yYL+8u2N/mjz6/DyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=e36H3O1W; arc=fail smtp.client-ip=52.101.83.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="e36H3O1W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtgo02QFE+bjSVbWmVwLUPIt1H47W3Mt+QZlSFrWmKs1eui4g08zPQRPaxl4TXHl19gmx0t7qI4yVYsNX2ztwgFkxPDFFsqH2OdQzk4PlWztHo4mzAjORKbzq/m8hy2jpJCIIckDAzd7dRb97W4jaRtOA4ZymMDj/TZSAbV+6CPJpI3hUNr0ihasDd3gw391Ge0Ff5RsHQqgTiYJyA2FqneGtZ1Qah/RLZO+p773XPti1FHw9Zy8ceXYInO5MkOvoCLEK0cEWeYFEZzCeO1KFUezK8p1sknKt1myMXVMvQuHJ+EUHgB00P79TelBEMwsp41K/KwA5YwcQ1/USt06uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbjmQ1kHBEzbvkIbO2fI5nBTuahxbmGLbCr+P65A/lw=;
 b=mPg4HnTGi0JKh8B7Z8FEy0Jo+fBSR1JulbXTtF9OYv2e6Xo9z0qas3cd0cdHmki/IhcabGI6wxyolKdYJqDaGKXW8b8Sfq9rlUhlwKw33foLPF7lq0wp/i10badFiy77HG1lOV61zhb+4rJTpPkM7cdEEZ11J6pBjJBK1S4Lnje/Sw8djGflMvjz0UejDAh9jMif3Zs3X7lnVSr0pHm1SbrI7VZ+45mt/WmP9pHGCQ9unbqDeRDEg5CPawGHYEdnZyXVNAFnKV8MHPInVA013L4ImO+U49p7g8hA9DkptBpbiA0/8i7B+0xVjTHm1XRGGf4hlhnQTLzy9axgJa5eGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbjmQ1kHBEzbvkIbO2fI5nBTuahxbmGLbCr+P65A/lw=;
 b=e36H3O1WSIJtZ5GVk5r3lRfWeAilno/UtIxwkD3wWNF3A0FgNDUbWBCxzDibZeoC3iaeOI3CCV0Q8qhJY03YRb7LxIPj9N0lRorSencvafCjW+WMHMRHJ4LQFfRnBbCEz2ijwHphTCq4bjT9va/b8XUeXgwOaT5LuIqShLpexd8=
Received: from DU6P191CA0071.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::28)
 by GVXPR03MB10732.eurprd03.prod.outlook.com (2603:10a6:150:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:02:39 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::76) by DU6P191CA0071.outlook.office365.com
 (2603:10a6:10:53e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 16:02:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:02:39 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:02:38 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 05/15] doc/qualification: sm-pts: fix SM/PER/PKE/BI-03-C and BV-02-C tests
Date: Fri, 27 Feb 2026 16:53:51 +0100
Message-ID: <20260227160022.21462-6-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8F:EE_|GVXPR03MB10732:EE_
X-MS-Office365-Filtering-Correlation-Id: cb6d2826-5e63-4e57-554e-08de7619a1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	/hrtl2YShitLm/cpVmL86djDdVPtVBp/pk3NIzUUhnxnRS+uOpJEjzV4TGVKDxgv0fGnH3wcvqxHBt5bcufkFwR5apC4lFBJOLBkQP+r9RlonV+zXeLf6QOdCVyNMfeUCknC5y5Ga/0KpeWL6otMBOAWUhid6GiOkwoDrWIN1825g/7WB4xTv0f2JZsPFzmpK7CyyidU0ncdsuKt/cuMulvhWI/p7QxR+RtANUAG3YK/RMMJXJ6tfmP1wwmbSn905lSshz7VC2vtISCWspJENuT3TvPkpC0EwGjDxdEFwuvkbuqUdhu7AnrrPfhK7G4GkeamFBNpZP7WrWJfC/vsxj368ZdQHzs62prlc4l5rzPNn09sKDlEo4UY4+/+6n71EwE7Wm/jDG1mL9DKN4eTG3f2Df2qcRO1IRX5/o1uXEN07Y42zE4lgRUbEPYIW5GbieRHcFsOaqPM16jQwTTZMjmQiqFtJUeKSLcOJQcNnpu/n96xV4LibcOc9TBfbtp10bsJ8EOEksiD0pHbUYbYazaMEnubZKnjRGTXqTIGzXYXD6jK6XYtfyz5kxLyZZmDvqxY3U9zvLEwqJhRJBfAKP8Q8JuiHPF/6pekNPch3ycHa+j5ULdjnDHcIYwLvB/BsyfUPymH8fRFSgpm+ewj5UBIi1kXuUYtuDgH5UH6+DeCsJ7tcKIO3GjiKBRjEjZxvOzkAsXXmi4BR8ohWA31nTvPM5RG5vfwtj33ERtR+paOaXfTIp8PyDwz6/JXgJn30plnDE108JS3JXNzwE3K2M+AGDjJ8P9HO5Je7n2DEIkdk25E3sYA6bNFoOP2u1pX5tTX6+B7KAor2wkP66HFlQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NNTOeTuARzYhZWk0dvoJyk4m4Xfxf/NcOoeyLl/t4m6qwbulkZg+kUxh3qk4+hCK7k/FZhqbDPc6zAYQN8VAE0OicyUn0HS+u2n+q6dioBRuKLvjIfazi3gtQ5nuP6swGP4Gk9GG781RAxkKlEpQcW37uEKUn5oRSHD/qdMdJNPmTUp5bL3UsHFubKU3+LLMQ+juqv7HoYBi0etdxtjz1OKZPyIrD3XuX9kNC1t1S19hb2f19RX7VMY/DV//YrcTGsTtg62Qgy2x9gWGCQ5+q9jlO0xcZiYH3AuJhHKzK6yPqIymOP4f71s6yjbDDj2Q+1pHElMS0UtVRgPFx+PEIZGe15WO2a7+o1+gqUdTWsNNK9pbGT8hVk2bhs10P9mc6XveGH65i9WMwW4NEd02hyvP6Otf23sPJ7f7HqjGs4TDQgdkCU9M39iTichsztI+
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:02:39.0422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb6d2826-5e63-4e57-554e-08de7619a1a1
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10732

Running 'btmgmt' is not required, passkey in shown in bluetoothctl.
---
 doc/qualification/sm-pts.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/doc/qualification/sm-pts.rst b/doc/qualification/sm-pts.rst
index 87fb0d7b623b..f961a2613d2b 100644
--- a/doc/qualification/sm-pts.rst
+++ b/doc/qualification/sm-pts.rst
@@ -355,10 +355,6 @@ for which we know the test passed.
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
@@ -393,10 +389,6 @@ for which we know the test passed.
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

