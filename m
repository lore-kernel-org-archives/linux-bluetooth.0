Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8D73E8C52;
	Wed, 25 Feb 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039272; cv=fail; b=QelPErJrpY+F+TmfMV88DXxlnMJ9TdIBtCyTLN71qvuQzkzvC3NO3+mx9wmbj74+3GgpkyAzRylsa/ZJq821+nCRcYG6iEr4Wcfd9mgNivYzHr/KLUEV8+otFCRe5V8mBX3VewdNauWmXHU1gcQGRmSZLGgbHppGKKk1KfwFPWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039272; c=relaxed/simple;
	bh=qIuwu/GIZ9in673qf2eh1UNr4FaX+cFan7ZFlhLyDDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQL34FFFDGeZKxgUXoqij9DfI8MJmD+Lp90zWpqGAsahmLkX+7JGuuJH6trTi8w3ioWA/w3eGEKB3VLO+Cw4HpSN5tEGoa7d/TE9U3ynEoAkaVrSWH2qYgnKD5et7EFN3p3LnxaEPNd0jjfCgPlXVXsS7OkruGuJGrDxBeIjJTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=KEvDV1wk; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="KEvDV1wk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKJsdyX8wssMHNHtKbaDPmtJ1q8SQrnpuuQqRR0Sx6rKlju8/fSmCljXsBzvKjrVqxk1i7stPvNEsMsVmrS7z5bIreOnbJCrWIZx45on5jlneRCCfyAGR3auprBn/q12tQc6iv17coeazpg8NOKFSdKKNrj7GvSwG7AZEQXvy8r9GKiUSrnBMFmMXH4WwrRTNCLURPgBuxYsQ5b5tj51jqTWGnLf1CZ0kxShi0Fxvfp0gVX7dvf4XO+y4oOOms/bE5d6lr+FN42nHVnELaklAUQYfb9i3QL7/SJh1j/1YUsSMufCjh+mwpf2BiZp3fFM1GaxB+nU8Pz1+TtYnQ5L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Z9FDrM2R2oO5m5XU1AYnQvnk+1dCzm+Z/yMNqGuDuw=;
 b=NyCIzZgDGF+G9ZNhwxyVg+sAO7lmn7PGpo9anjJ6dguPqg4N4bOALdKOnp/rZVXwQvKjOt4tXo6lxFunftxwyK8ds9JaVrdBJWkT1wkvsjYlrPdmuMrNHNjV4V192lLtBfthzv4wfrPJahU831us0zoxj4uTUacauP90eEPkgncU4MRgNebY1XHu79r9NgNaaPhLnw41HjwxR9GrzI/E4uwaNglE/hVTaLA2wwijL/c2gkxSRsJjor/0tSX93xJn6yFf1FK8AkmgfOrFxbuSOm0G3pqmX3gEd5heWBzVhnt+tOdJ4DaCrT7Z+4i8Z4pCAuDQM1JwQuGnAExIkMAwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Z9FDrM2R2oO5m5XU1AYnQvnk+1dCzm+Z/yMNqGuDuw=;
 b=KEvDV1wkOrSdNB1nbiA1Fa5irJCYxA6PofM4PM2770tX+3rHiN0A+R4EUF+9KxsQ7pd0ST5WBhXpSh9oGCKWUS8yeYPH9vDQf7MHLW3jhpcgHCHo1hMUgfmHk4M+8BZtD42/YqZXFkmBVjKYwVHvct3UdlFJv/A2jVOXplQS0PA=
Received: from AM8P190CA0001.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::6)
 by PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 17:07:46 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::41) by AM8P190CA0001.outlook.office365.com
 (2603:10a6:20b:219::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 17:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 17:07:46 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 18:07:46 +0100
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Christian Eggers <ceggers@arri.de>
Subject: [PATCH 1/4] Bluetooth: L2CAP: CoC: Disconnect if received packet's SDU exceeds IMTU
Date: Wed, 25 Feb 2026 18:07:25 +0100
Message-ID: <20260225170728.30327-1-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|PAXPR03MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: fe325d4d-1cd9-4879-2efa-08de749065bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	1ND337VHhkrsEhv2G/nX4f45yOzZEDsve2fNM5J11/GRMn4EsuAoYJlDRuA+ocBY8rjEYIUDFGodQrB2+Cs5ee6x41mr7Zw52HnE/NMWVEiBd6akpplaUcBMo1qoNnKw4d9QjVobygKtMMZ/JSsFXv1beVqJ1m2ppbyvYwRJNSnstsd+IS0o6dlPKF3JvZsFfYOWjI6gCbNMTzzRE8qHG0/FLfr0Q3eQF3w9m1rv+0g17bD9iQb6ZIr4ezqV+YjEK0lGOnKYsVzMeG7ec2NAT/8x8L94S5vvppBY7U9uRk3VtK7wpZmUUIOal1eJEq8X14JV4rS0JCZysMEBKlmU2pqQ0BFGS9vibAgQQF+EG6RjeE/sLlTQWZsbEw3zPHJRkIpJtNSTsR3QBl359pUI8xsO4NbvTmSukCTrpYk79e8jCLX4Ep6XrrIcIu1zLnGz2lRbnbZAaLHjnUMfX25DbyTzqdT3oAfIIVf5YirkcPbbP1FEBSWT6ydbjur0EujXIEpvz2OmENSb5dLvoNQ+jAYIVruujKWippjBEXPvsUKBCknDLUTfl1uL0Pm5UtZh5UNAb5IZfFcqVzh3byG6or7ATk9sWg0gXbnxNWWLjT6G6WIlgDfW47yapdVzMwuQ2mMJrXr+6Rhb4Bk79yt51IYJFOUxDtJYTjAtpT0CUmzMVwDwcjgqdQY8Oob8XzeAsP9SIy3PbpKBAHbwR53s2FYvPd+805fqYnYZ8E26vO3FEaMh9+193ok5wvklsvTe0gFhLOpLfUOLWdVRBiOepNmMjOE63/sBMMfTXoptZ1IKcFmFtaMwE1OBlvpa1zCYu67D0ISN3HxCuZAITbb9PA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GtUxOwHC5DI3PTO9BIbYpg809wo5Sgx7hVmFrWWSas77smXUhdJIct/6y2B0AC6iJVnvLqf42RfgbpxOM/o/6BKY1vhXKeR35H1u7lU/PVaVwXFseY68/OfiuvVsX4+7QNa5s1iJHPsdI07dCDdVM7oBTfF8d1hIrmz2Vv18JnfEmV6YvE7Rl3wl9MGrtJU6BlKlESkz5kFkqZbMc+oEDl67Bgh7iElExoBvlajzxJE7ZTDUcnS4k45QgeoOBQSOouoYDraP64K6sbxTNynwfXLSjQgtrKm7vgO0+fmKalwzu7mq2sC2NnAv8FbA5syUHO/lmkclAzAD7W1N4Y01PyzjxxP0+pXZ7lvZfcv/gm69EaOlZT4+MFSuYQyrMQW76EG5yS5NfCUrnU8ASS8S6USZGsNNYBP5rXeI9NSxiXiyRCtIkowJbN3hA2hzFSg5
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:07:46.3894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe325d4d-1cd9-4879-2efa-08de749065bf
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7856

Core 6.0, Vol 3, Part A, 3.4.3:
"If the SDU length field value exceeds the receiver's MTU, the receiver
shall disconnect the channel..."

This fixes L2CAP/LE/CFC/BV-26-C (running together with 'l2test -r -P
0x0027 -V le_public -I 100').

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 net/bluetooth/l2cap_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2dcc5bb907b8..ddac5b9270bf 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6664,6 +6664,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	if (chan->imtu < skb->len) {
 		BT_ERR("Too big LE L2CAP PDU");
+		l2cap_send_disconn_req(chan, ECONNRESET);
 		return -ENOBUFS;
 	}
 
@@ -6690,6 +6691,7 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 
 		if (sdu_len > chan->imtu) {
 			BT_ERR("Too big LE L2CAP SDU length received");
+			l2cap_send_disconn_req(chan, ECONNRESET);
 			err = -EMSGSIZE;
 			goto failed;
 		}
-- 
2.44.4

