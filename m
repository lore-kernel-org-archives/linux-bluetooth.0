Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020117.outbound.protection.outlook.com [52.101.61.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998AF4A0F19;
	Thu,  3 Sep 2026 12:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788437921; cv=fail; b=Hc7AnWOgtSqhUdXl70UdlSqIQzB6afgDoRYvZCqh77IPOvsu3fX+d1QV7pKlRhjX/xsEscASr5cqQz8wTiExKwSP2Qd3voaV5oEiQCi5w9HPt2aFKswJ2VIluNl5RFsBnKvuhcaI9I4eo3YDkatBRcCDDB5go8DwL1VERP4fHrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788437921; c=relaxed/simple;
	bh=5nPbflbon6eoBieovDO1WI43jxJDUP0NRHxE9+wGuhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ROCU17RBnSyFoMpbFLoG0N18EveHl9lnytsHGGgZTsDfUPYCL93ZpUTDv2eQ3r6rLmmcMe6rpxFlnAC7LIDXlwfeLl0wJ1GutOqzvRWMJ+B24fXsfG7uYW07spwQrVwS0nd6bbXiARAyJ3p3ua+YHaYzP/pBV+O12mTuBZSejtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synaptics.com; spf=pass smtp.mailfrom=synaptics.com; dkim=pass (2048-bit key) header.d=synaptics.com header.i=@synaptics.com header.b=JkaF6e/9; arc=fail smtp.client-ip=52.101.61.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="JkaF6e/9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oaNvle5ZexT1VjE0ImkxgTc6/GGrU+6SN7AOQI6dP3CdrqD7cm6BEPof/YcZ3aDi1E8UTn4xyyR+c8/HFInHauRgV3CNx+OFEwtLnAJw4m3G29jmMsWoRzq59+4hg+PI7vm1Ne6iFb5RsaVg80tqkGW8AVs1qYCLr4ZWIkPLRebTYAQ+C8lfQQC9svhF1d9PjYlZkX0bnFrDe8PcqrF8qwno6Yqm4HS6zSlfkimEI0W3vw1Eg8m0oaLyVhI+LIUchyAg+PjzNr11IZFl7toIQWFEWwyEFGvcDdnQSiMV94N9I71i0RXdjTXwqxQXdgNXGydeVk9VduXZRm1mNtpbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dk5+4L8uXOwqJaW//f65GLpQ0pNP2hiValVvUVaujA=;
 b=gVxfMceZH0IFAeDt63ZQoqjIFc5D6OqKc3aOAH9dHhTOJtMFbrX7vQpxLYvyZMpx78dkmKgN5E0oaTBAU51cML6yFZncR4WT3KHJ2YQ04RlFzESswUIaroUwzqk9GstwVZ5r6ZF6yaf1NWWMe7bCWwhYNoOupROSOvZTqVL+vclVJW8DQXk0Z2WexHPzL7uIkDDLOwQ5ePlg+WK8pOGzdYuzIXOb48x+K/eqyG1dzZ/jsh+tBZL8mvM3AwZFVMcT4gt7Gk9mSZCNPPXn9dxKHq2VzAStHa1tIp6AjOs0W3dDPR1ORmylqdlHr5JZoJL8ycUgyti4nZ5zmj8wUpiK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 59.124.75.172) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=synaptics.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=synaptics.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dk5+4L8uXOwqJaW//f65GLpQ0pNP2hiValVvUVaujA=;
 b=JkaF6e/9A92XMR38N9WldkPyILPpDWbawdU4eCzbYb2TkEbWHhroPTD+WbcjzWzLygj3YWF/g3sCtc1F65zorXY8blzXq+dhCBiyAKVt0tF7X5EpBfzgO/YsfvHn12dbUuaT0+Y/sWrlhy+ahWOIgcCnYBIX1g7cs9r+DsPvUDusMxlJvw0M7PbzbM1njTay1WYMgy6CKP3JJy9NpHtQKrckxO0iNlAupl0xXsPrvxf7bWrG+nXTh/i/6glLlAHxU3TKK/81C93iOyXlLMFKgOjjJplm8w0TtdqMz2+C68fmDq7F6d2Pu2vf+CZdtgKgZJr4yiawt/NQCiDtQLBXXA==
Received: from SJ0PR05CA0182.namprd05.prod.outlook.com (2603:10b6:a03:330::7)
 by SN4PR03MB989339.namprd03.prod.outlook.com (2603:10b6:806:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 12:18:31 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::55) by SJ0PR05CA0182.outlook.office365.com
 (2603:10b6:a03:330::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu, 3
 Sep 2026 12:18:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 59.124.75.172)
 smtp.mailfrom=synaptics.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=synaptics.com;
Received-SPF: Fail (protection.outlook.com: domain of synaptics.com does not
 designate 59.124.75.172 as permitted sender) receiver=protection.outlook.com;
 client-ip=59.124.75.172; helo=bt-tpe-server.synaptics-inc.local;
Received: from bt-tpe-server.synaptics-inc.local (59.124.75.172) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 12:18:27 +0000
From: Andy Chang <Andy.Chang@synaptics.com>
To: linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Chang <Andy.Chang@synaptics.com>
Subject: [PATCH v4 0/2] Add support for the Synaptics BCM4384 Bluetooth controller
Date: Thu,  3 Sep 2026 20:18:22 +0800
Message-Id: <20260903121824.3080796-1-Andy.Chang@synaptics.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
References: <20260901023300.1382808-1-andy.chang@synaptics.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|SN4PR03MB989339:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e06015fa-7864-481d-2cc6-08df09b576a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QVvdvhixeag/ruDaqnqqY/4pAxTF5DFJ3nuSo3wumBCOscKa+B/w3ZGEiknUNzjQh5UtCTjHNAQwhfWB+CEO3DRC5/N+idcDceyLNJuDXAn9FvI81hpNC3yeKB8tS/QhNMeQTwYTr8iYT/ebizBPN4jH30j/zh5HcuE9GaDlwy9QmKLtSLgP+7zu4w9fnYdK93ZhS8QQX8/w1G5Hr86+O5EbU90+rncG3o5EPRqwcEz+pJ9S14CWMhDJN33Lt5fRDfP9R2p4umNXuLTqQye3kPK/t69ntGEku7IfIuCJ5eXYu+I+k9XC1QHGBFLBvf+5Pjmc6aofTb6FANJes8XgPO/VCdhKMgbGf/x5RmkPssoN8+5L0bx59APcBkuOFKRoDoWHHqbkvZh+hoaSlEaOpS5PiWaTFiJclvvpo943yNqzc+91Ehs/Wa+A3w0f7S9bM6kDWQXJkksvavna94UNmhcIhSuN+RCyc9zNpa3fBo1uXAUCOhkYTBANkdbkYQAXNVjOEpAF+FnshV/lrySCEt3tSJbL/QqtEkFovT9hnqZiyKoRPbUfxppwfJhu+cvuBWIZnqTJNi+Gy7/1yZJpTj32PdwJX6q3hnq8tscMYR6CZ++AKTO6xYuzRxybKbscMZY0WGPundaYHQ/xakdOTnwd2IrifhkP1bP0u/mbmykWDQhl2Fas7tWwKBvPk4EW9tmCC7ktC++bfNHw0HeGuQ==
X-Forefront-Antispam-Report:
	CIP:59.124.75.172;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:bt-tpe-server.synaptics-inc.local;PTR:59-124-75-172.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+GiaBDGlqDJmQVwc7yF0vb2UdRU/Fc4SAhJGmM2ElDZYnaNGnZDe08MiQ94PIm8MJpIxCJMMBLHmnRzHonb7CY2ywGGJwUIB/xi4BvylhN9VsxYHXmGwg21/SjWyWitoZ0sxg1LlaL4HvrFi+jlJEc2+6PeU3dt4mCsWD3zaPg637CXtHetUyZ4r1c+f/kNIC1tOB9I2hwMQDnKPESuEg/iYvYi8+Uupo0EAkbqJ29R5V55uJpwQ016A9LN4a5g5tt3UEwzE2JgsQ5Na50LTPRBdjDTjb5QNax6Df1whwNfynCKKqdxgGF+vKuTvgtSsnuO7Wbh3FA3iMVTRf/lvmPjrm0crZzuiw8NfiB35cdImoj9JWwnBELZyEHwSxpWddWjAUMYSVHGwLvd/Fk2YvX3p2aU+ZjjQRLM67H1BTyIR4h84X1xDlPXpC7ypX9bz
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 12:18:27.7466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06015fa-7864-481d-2cc6-08df09b576a5
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=335d1fbc-2124-4173-9863-17e7051a2a0e;Ip=[59.124.75.172];Helo=[bt-tpe-server.synaptics-inc.local]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR03MB989339

The first patch adds the BCM4384 Device Tree compatible string.

The second patch adds the controller support to the Broadcom
Bluetooth driver

Changes in v4:
 - Patch 1: Rephrase commit message to be OS-agnostic regarding firmware
   selection as suggested by Linus Walleij.
 - Patch 2: Add test log into commit message.

Andy Chang (2):
  Bluetooth: dt-bindings: net: bluetooth: add BCM4384
  Bluetooth: btbcm: Add Synaptics 4384 chip support

 .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml   | 1 +
 drivers/bluetooth/btbcm.c                                   | 6 +++++-
 drivers/bluetooth/hci_bcm.c                                 | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

-- 
2.25.1

