Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAA53ACEEA;
	Sat, 29 Aug 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788013397; cv=pass; b=oAhLjpWf5dZeqndPp2DQjSruLfvzxZsspy1HcQX/RJNBLa8TTuCBIH+BxpyU7qJOqx6Rjahut02oNlCC+mjYrYOCC+Em21u40BFvavNSrcWOL+HSWVWk89Yrw7CULLGVGz92C7Fsme30snpXeVi6KQjN0vGHMQ19OV1t14rHvB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788013397; c=relaxed/simple;
	bh=DglAwIBDAOZtI7fLjCYTm3hxn4xxQs2GY6xnNw09kqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCWGwfDcR/xADcFxfI1WDbMU+R5QoFb5V541nN19PGbhsRM6ODaxwgt6+rWgkbNKTRw/rVNb/04O0EbjXDglSgnpWZ4AoTsiG8FW/PR/WzTvATNSCkQiUDf/UbTu92E8231Yo8z1P/rhrflspZusi18X8oMB4GFOEndVWU4ZmqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=wEnbTAIu; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="wEnbTAIu"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXHXq6Sglzyvj;
	Sat, 29 Aug 2026 17:23:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788013388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJOLdi5PhAwA5XQVJ1o6Hxg+qLS/nkP9SPXADUScm+s=;
	b=wEnbTAIu9YZUg0V5gA7+y09Ik/FP7Y0HWZMLTBck+qlnLjCmfaU5RreBKNFd44IkwS5oEi
	YIIQp9DgSDTzvFi+AxA9PGqHZGRnijYogUICqKsfH3IK1Y5ND5YJtHUtUicJzZbIlTCz6/
	7hbYJPCav8HFuSinYxTbN5Sj69S8hsc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788013388;
	b=kw32CZ5FPGZ5f1pK6lbMIjfGDLehBEtEJnNTgr71WfM3ltWPXp9go7SpXHQ7+QnCxXPi7+
	nPKKL9C5jRCkYWFCUaWx/gtxvfJ1aznV/XCsDUaVq+XJlfwTmURp9VsH64i46lfY6s6OV9
	OEjFiFRbsJj4W3v5D6Smdm6NoS6PHts=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788013388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJOLdi5PhAwA5XQVJ1o6Hxg+qLS/nkP9SPXADUScm+s=;
	b=TB8vvLZ8AMNXBJOMSBewW4j5zfa19XK1Jbnv6PK0572dfvzgaD2zonqE9MTEEHCQ8xz7Yj
	QpJTU5/r5seZZTbLqPb/dmwJK5NkNgireIX2GcoTC09+il4VfDZdyCsMr7qxhIIc8521CM
	unP7832JXQf/PAw32JmmpUZ/oQgUDgM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	oss@fourdim.xyz,
	error27@gmail.com,
	elver@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] Bluetooth: L2CAP: remove conditional locking from l2cap_connect()
Date: Sat, 29 Aug 2026 17:20:10 +0300
Message-ID: <7d3474153c2b1f3f820c75ff98148ca5238706c3.1788013041.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788013041.git.pav@iki.fi>
References: <cover.1788013041.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Context analysis does not understand conditional locking.

Restructure l2cap_connect() by removing conditional locking at the cost
of some code duplication, so that static analysis can see its content.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ff9529f2eb15..a4299bc10c2f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4233,7 +4233,6 @@ static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *conn,
 static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 			  u8 *data, u8 rsp_code)
 	__must_hold(&conn->lock)
-	__context_unsafe(/* conditional locking */)
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
@@ -4250,7 +4249,13 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 					 &conn->hcon->dst, ACL_LINK);
 	if (!pchan) {
 		result = L2CAP_CR_BAD_PSM;
-		goto response;
+
+		rsp.scid   = cpu_to_le16(scid);
+		rsp.dcid   = cpu_to_le16(dcid);
+		rsp.result = cpu_to_le16(result);
+		rsp.status = cpu_to_le16(status);
+		l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
+		return;
 	}
 
 	l2cap_chan_lock(pchan);
@@ -4332,9 +4337,6 @@ static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
 	rsp.status = cpu_to_le16(status);
 	l2cap_send_cmd(conn, cmd->ident, rsp_code, sizeof(rsp), &rsp);
 
-	if (!pchan)
-		return;
-
 	if (result == L2CAP_CR_PEND && status == L2CAP_CS_NO_INFO) {
 		struct l2cap_info_req info;
 		info.type = cpu_to_le16(L2CAP_IT_FEAT_MASK);
-- 
2.55.0

