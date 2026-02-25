Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013013.outbound.protection.outlook.com [40.107.159.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECC43D646B;
	Wed, 25 Feb 2026 17:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039312; cv=fail; b=Ns11/+i9i3IEBeqQzMLsPvZXyw+br2L4cGwdlXfXgageXEkPzCGt/GMl4s4nPX5A/2SMSxR0q8+QyT0f9rznL3njLpoIit+eGWm8HDqH4ipACIXa1HQNCY+MLbEopDouVu+pIOuLJ/FxYAlgVorMwIGSAZVvxpOPkNos00shhsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039312; c=relaxed/simple;
	bh=INSxnBghFi64KwSdyWilPJXq6rQEkJlTN6ZWPLv5+sE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1+xGwG5RfUL7EfohQpeIl98vfpKUyNgESoM5tAR1QoCuIyLCbb6UmJJZIMIXyRlP8aA5in/fr9OhHbKinZjndEUIXW+t1xUvGUTnTGAR4gMC78AN36Vav0hyeNNIQY3Izbo6TMLJgOd+uw0hj7ULTMsGbtwk7rTfmbpfU4FPgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=cmr3eHZx; arc=fail smtp.client-ip=40.107.159.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="cmr3eHZx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JbruQ8knDjMMLL5D7wMj1NKMaSM8BNgkgHrMVyjD7dWC9wRSbBiUdplKrJoEZAlSZWukX/SYp9YORW562a3x3MlBE2b+L8VbRhi+jUS7StPC0ENVdhqywe3U1tISezIve5ZjIng5k+AVkWN9r8Gmqt05E6XxzC5nel9xhF139R4jiSEZv3b0lICTEWg+fQEw2m758XZDW2kUqieDUi0QApdSXoW7kC6H4ezJs9nQHpN1AjACJILk8qywDxqqRrOrxO5BVrkTHQx4G5+59gvlFprSrp+TH5kTuEVh/CTo9ZH87esQetaI5z87N4n5pxqPwXHoje4uf32511Eb7TER8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYBGgqn4D7m0Bdfw9Fl5wQABvV0qnhvWBjXkq9fEs7g=;
 b=DwQUyVkpaajKKds1E8BhAeip4E0/T3FOYrdz6uP+GOPSS5pOw55MhyV6DhGdKPLu2w5GFiXHWOUxHu4IE9s7eKBhzsWqIi9RCgAWJTFEuSXOjVQzw3/QSSzvuOKiRnd6xGM4xN1Fjpn7YQznepbX3TMwsBWRN+06iJNRkA64VEWiNP0kVYecvgiOb9GWOQG3hJjrcdX/K0Dqh0Gdj/aVysCn2zepiww+Z9WfY+SbWY6IBnjBEfrzgTpU06uw/M4gvgBJ743QBAvYpmUQX4enpDzLiUFiSlOuoYHE3wNn/0en9hXZwFJ2ctfOwj131xQeJF2ZXHj/UhFAzqbWMf3Miw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=holtmann.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYBGgqn4D7m0Bdfw9Fl5wQABvV0qnhvWBjXkq9fEs7g=;
 b=cmr3eHZx+JttC7y15MOCQTY03DY9wHjceBmlcQNJS1fdVhtOtXsjyrDE1EOILzWLJnJ1DHpall1714k+ms5BFNdVxfFmBk7rHchVMLuDou95x1wfBeY0VC6mM564q4bjj9Inzrqx+yceqI/5rbXYMKLGUFSU4EtMxfTCNGjG0+Y=
Received: from AS4P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::6)
 by AS8PR03MB7430.eurprd03.prod.outlook.com (2603:10a6:20b:2ef::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 17:08:27 +0000
Received: from AMS0EPF000001A3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::8a) by AS4P191CA0002.outlook.office365.com
 (2603:10a6:20b:5d5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 17:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001A3.mail.protection.outlook.com (10.167.16.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 17:08:25 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 18:08:25 +0100
From: Christian Eggers <ceggers@arri.de>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Christian Eggers <ceggers@arri.de>
Subject: [PATCH 4/4] Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy
Date: Wed, 25 Feb 2026 18:07:28 +0100
Message-ID: <20260225170728.30327-4-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225170728.30327-1-ceggers@arri.de>
References: <20260225170728.30327-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A3:EE_|AS8PR03MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab0769d-aa12-4ee9-334e-08de74907d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	akNA+soz8mgz8Qcm5LP3MoBkbqPnE13865GPQlk8bo05BXHCVjMvu+JryLKAFKwVlEDA+jTSkb2tvXBcMhOJ0ptaRiKdlXp1zdr3K2FNtLQ6REx4QabFHW1Wyj10vcsNSahHb0U6Q/IjJv2KIxjYIx83U16XOW3Ek//we2so7uj6d6DtToa2JRfB8Qya55H48oZqk4e7boyTkVKMhwqDumC0WgH2l1KuV7VzXZ4c3oAtVkBC28YIn29aCNOIWe15lsfCk2OdSM3Sk/PbiE0OCUsZdgucyaAIxemrfhtpGkepFQYus1nqGTDTsM4whPvW0mYWw9qfoUbyrxw7CntVHd8vIFFxO/E1KvJcvdBdwQ/QSHpZRK+zB2cY+Aj8WYNcd01uWtEsCelUfxSPOBM1OSJXCvgSYEl9wjjwyxOZbaVNJK37589Y6x2WdYgpbUQ2xzpMIsR+NRzSqs6nayXvp2RXm6e+I4X/PpAeQIotUv+4moitja3+HcwBSu0XBM0xz3YnfMSKF2zF773FyuWHgk1cS2WHTCtBwl96/AnxWpByrJexSdNS5IHYh3c5Kh8MMdt6RGQf++xmtZ7NI6QFXpX61fKb3B46s0M+cit0hoYW1PSD4Ypv9aMgSOrtpGAIADUZ+aMmlcK0GwLyVC/BYlU11UEa4dp75k+lc+viBP/ufo03jdYCXgLWHntFF44nSL6dcX1GkrZYYQuR1zU0yFr8c0Lvc1ZxMmUJZVuBNpG/5kyCEGbFpgC2OW124zzgrE16Saq02XzRtinOSTsv6wM8P2Rx7Nx0rBkAelG74nTF1Gwk01y2gjg+uzej35TV4l43GWqOwndqILwKTLaDXg==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yrlFaIkrguOcKKyFOO89QuptU3CLlngYFf1UdxY6o6lfsLD9WQaRtVtSeMbMr638WtAcCFNJSKJu4UscuLBvkvDXVhyNEHocKXet+sL7213fPzLZgLNKsofX2xI+FoDWJJz8oy28RbAykGdpHt+QrhcOfreTADIs4nvZlEdzAeiGS1IPqM7j0QC4K4yvEwnT8AErrDJ7vGwejSijL5N6+kGauevY6x3mx0hrhOGYxi1VCzGH6shN1NOy+4NIUhYEDWYd2/ERboFF7fGrsse6qfif4H4x6/O36hQSqpeYhT9trjQbyUyYq+F07dW1mQIb/1gkPZhVL41Jhqm0T9QsDLv8scvRcYc4lFK5zbLVObU3gM9h7YCLz4m+PUm83S5xrRA5mnz2BtTTnuATOJYnj2b0a9duorZdpJLXgS/LPMuAKPjhntYHxY1sh6MIgfj1
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 17:08:25.6856
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab0769d-aa12-4ee9-334e-08de74907d2b
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7430

The last test step ("Test with Invalid public key X and Y, all set to
0") expects to get an "DHKEY check failed" instead of "unspecified".

Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index bf61e8841535..6b35645e0996 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2743,7 +2743,7 @@ static int smp_cmd_public_key(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (!test_bit(SMP_FLAG_DEBUG_KEY, &smp->flags) &&
 	    !crypto_memneq(key, smp->local_pk, 64)) {
 		bt_dev_err(hdev, "Remote and local public keys are identical");
-		return SMP_UNSPECIFIED;
+		return SMP_DHKEY_CHECK_FAILED;
 	}
 
 	memcpy(smp->remote_pk, key, 64);
-- 
2.44.4

