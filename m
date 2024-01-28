Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE381EB22
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706438448; cv=none; b=pyZkIdm4RQOYKlsmLWQttjv7dqcpTkpyGMYQjSt2gtnV1kVoOjXklek1fcTI4s8tczL+AHaw/4sgEu7AmVioiLhBxVw5Xmg4UO4n9S5rrNMDvsH+fW+tEDvJ/9jDx8g++LQSNucXDL5C7BGRM6zwqLQYjAg1EXCH6CUvoha3egA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706438448; c=relaxed/simple;
	bh=rpGt/LPI12OZ1viIdRczhBOX/7PlNqQehkjos+G74vM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YrQoz7WVVySHCEJ+dKd8C8J8x7tylQn/dxPAAefdVrZoHWg/PmipbVUmlE5uRDNdfrWmPyH8egRdMN3OOHy0jGVSc6ra6oBFQ06hvsllRAdo1jQJGuL3yfLQ3VpwoKReO5INRsjn4Y6wr4Y1P8zdNN2PSFr86KmwdZN2W8KxIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iJnjK+dQ; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iJnjK+dQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706438446; x=1737974446;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ccAIL/gRYzL25KkWnaG6pAwwlZ+/OS7VAqi1cfgfw50=;
  b=iJnjK+dQQftcL75/s4YuzOnXveH+xsDeBE4U0/fYqHcRuCPTEYCX6HiG
   ay1fTQmLI9fH7ktKbbQMBJhbb+mRTEyld/xAIpswqxIYEBJylxFnVol0C
   cqcHmameLtCAeotWt6qEjSn7zw+7vQz/xzFHE5gHTn3PivEX2R/XsYzNG
   E=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="61740909"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 10:40:44 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 84EEB4B05B;
	Sun, 28 Jan 2024 10:40:42 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:48459]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.50:2525] with esmtp (Farcaster)
 id b064ec7b-6ed5-4bbe-b948-e2b5be8a92c7; Sun, 28 Jan 2024 10:40:42 +0000 (UTC)
X-Farcaster-Flow-ID: b064ec7b-6ed5-4bbe-b948-e2b5be8a92c7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 10:40:41 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 10:40:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <linux-bluetooth@vger.kernel.org>
Subject: [PATCH v1 net-next] af_bluetooth: Don't hold sk_peer_lock in bt_sock_alloc().
Date: Sun, 28 Jan 2024 02:40:27 -0800
Message-ID: <20240128104027.18868-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

In bt_sock_alloc(), we need not lock sk_peer_lock because sk has
not been published to anywhere.

Let's not hold sk_peer_lock in bt_sock_alloc().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/bluetooth/af_bluetooth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index b93464ac3517..6588654429ae 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -159,10 +159,8 @@ struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
 
 	/* Init peer information so it can be properly monitored */
 	if (!kern) {
-		spin_lock(&sk->sk_peer_lock);
 		sk->sk_peer_pid  = get_pid(task_tgid(current));
 		sk->sk_peer_cred = get_current_cred();
-		spin_unlock(&sk->sk_peer_lock);
 	}
 
 	return sk;
-- 
2.30.2

