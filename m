Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1903F20E5
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773180046; cv=none; b=cUqZP2Yb+NY5dOmXLvLA+ZYny+t7zxHLIdjdEuKPV4AoALtUL9C48I9hK9OpJpSwANKr29DQOJCs+VBGdKEeevwDrCEgqe6QyVzRN9uwuLk/kNx68vSKVXgm3ISUgPuWKWyZNX9Eh7d10sKiWRPCO3p/2bYo/e356VWDaKp9mIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773180046; c=relaxed/simple;
	bh=Vu8s7jUwMOvlyEwIzaoSMQ+wQNXgnXVAF0jZnj55++4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fxKpJfTjvriM9HDJfQT3bJYOxVlggNFRkZd5K0IFDkHePJtyUnd/ZfP5SyxeFE7PLsv4p158v+gi+wBO/ujwAaEc8FLXNqg5CAdTCz9CVSRnZ6TxdDdoDcHdDLfsCD9VwqTRWM6v9hN48zk1OOlyXSFdxL6eguU9FGs/07+Qjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev; spf=fail smtp.mailfrom=johannes-moeller.dev; dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b=ot9Q50H+; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=johannes-moeller.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johannes-moeller.dev header.i=@johannes-moeller.dev header.b="ot9Q50H+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=johannes-moeller.dev; s=protonmail; t=1773180034; x=1773439234;
	bh=Ejdg6l7b/i4f0KmxGuMk1g7CgiSer0a95DBCWcHIAss=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ot9Q50H+wXeyoT+d80eVg0z87DsxbnTf9aO1/V6DOyY6Lgb9D6qmb9vmo/P+09zVU
	 EJmK06/RBlaHddkG12kwS8TuggUXdgl8zmf6+oY/5ugkyfougNQNQThzCpad0EjceR
	 sNuSOskQqQhoXzIGxFqW4tfXzhNh5YNv3goR0EkQQxcL+GuUYKPpFMWYp9WDcd06AG
	 Dit4HSVcUG4WCWU4TvfBVYLqFN9gkrjUJ3US2uVSAPNaSm/FSPEEKIu9fEGOBOuy9W
	 ID1YPvoMWcvKSxTeZSjnr3KZ+86lS2UsWW9CxZ+SiIWaa7J1ESak2nTrPQJuscTY+V
	 S3X3uaViwQXUQ==
X-Pm-Submission-Id: 4fVnqx3Xvtz1DDL4
From: =?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	=?UTF-8?q?Lukas=20Johannes=20M=C3=B6ller?= <research@johannes-moeller.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
Date: Tue, 10 Mar 2026 21:59:46 +0000
Message-ID: <20260310215947.35756-1-research@johannes-moeller.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

l2cap_ecred_reconf_rsp() casts the incoming data to struct
l2cap_ecred_conn_rsp (the ECRED *connection* response, 8 bytes with
result at offset 6) instead of struct l2cap_ecred_reconf_rsp (2 bytes
with result at offset 0).

This causes two problems:

 - The sizeof(*rsp) length check requires 8 bytes instead of the
   correct 2, so valid L2CAP_ECRED_RECONF_RSP packets are rejected
   with -EPROTO.

 - rsp->result reads from offset 6 instead of offset 0, returning
   wrong data when the packet is large enough to pass the check.

Fix by using the correct type.  Also pass the already byte-swapped
result variable to BT_DBG instead of the raw __le16 field.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Cc: stable@vger.kernel.org
Signed-off-by: Lukas Johannes Möller <research@johannes-moeller.dev>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ad98db9632fd..f8ed03095592 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5424,7 +5424,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 					 u8 *data)
 {
 	struct l2cap_chan *chan, *tmp;
-	struct l2cap_ecred_conn_rsp *rsp = (void *) data;
+	struct l2cap_ecred_reconf_rsp *rsp = (void *) data;
 	u16 result;
 
 	if (cmd_len < sizeof(*rsp))
@@ -5432,7 +5432,7 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	result = __le16_to_cpu(rsp->result);
 
-	BT_DBG("result 0x%4.4x", rsp->result);
+	BT_DBG("result 0x%4.4x", result);
 
 	if (!result)
 		return 0;
-- 
2.43.0

