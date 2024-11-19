Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998001CCED8
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Nov 2024 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023140; cv=none; b=qOJJ444X/qS2XPgULfMWBUIXRlFsXFjti4OjC/0i41EoUt6P7o4nDRLjbqS3L7DYv27a2nYZPmPr2yET+Xom+ra1j6pnfrWoGCXM9pK5k1zcWZqSejWRxPQO7HFMi35quO5frgDCAJFqAJubiO6q8geRfgsG/xmXng/T7ME0dHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023140; c=relaxed/simple;
	bh=3FZhTixGFlKzETB2uD8Jt3rmw9+e9MKTuA5DdipdB30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7yb3d1J9/m8bAXjHbCt9xFUST+E+Lr73PvRUS3dXJLFOMC1fdRC0bNdkyIIu4lKMNW5WrzK7dxCiQlNQIMGqs0CySQPGj6zZl/fSdgKGgaUHSgP1a2y156Ez2ytAtRoGarSvSAb2nKJrxz4ceT6hn7uxnteacUvp281HbP4TKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Pl1qGRa/; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Pl1qGRa/"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tDOKx-0024Ru-6z; Tue, 19 Nov 2024 14:32:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=WwMNnwCXYhI10qw9jwJCWBCgMmUcanPFTj9yT0i2CI8=; b=Pl1qGRa/SAnTudIDkhpJBZm1xS
	Xk2gxNttPdLjN5eELjbJPMq4Z4lcTa9JN6y3y8u9BW3EMUmW/LQwVPS5Zibuglc0/cO2XMpLPw1Uk
	+4wBXxeY3LoY+DObhaHAyojorQkUVx9C98GBoZo6CYpQSVYYEDjNG76u88QBZhT2G9iAP/KAcwGRm
	s4S01uiw82BBIDnoAAWzjGD3NgTXPuxap0zC8QNHaFqXqDpRX2aO2kBkfuWVmiPmA6GdNCZT8Z2N1
	qCkk6/Nd1k2ieSIOa0FFRVKvdiAaQ2VSuT4CQUqJ1f6+ZHF+YWSXr7XLb7c0WGyM3gg/mokXRCNWU
	DN0P/z5Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tDOKw-0006NG-Av; Tue, 19 Nov 2024 14:32:10 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tDOKl-000XIx-7d; Tue, 19 Nov 2024 14:31:59 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 19 Nov 2024 14:31:42 +0100
Subject: [PATCH net v3 3/4] rxrpc: Improve setsockopt() handling of
 malformed user input
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-sockptr-copy-fixes-v3-3-d752cac4be8e@rbox.co>
References: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
In-Reply-To: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

copy_from_sockptr() does not return negative value on error; instead, it
reports the number of bytes that failed to copy. Since it's deprecated,
switch to copy_safe_from_sockptr().

Note: Keeping the `optlen != sizeof(unsigned int)` check as
copy_safe_from_sockptr() by itself would also accept
optlen > sizeof(unsigned int). Which would allow a more lenient handling
of inputs.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/rxrpc/af_rxrpc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index f4844683e12039d636253cb06f622468593487eb..9d8bd0b37e41da9f99e2661ae4a29569f5eab650 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -707,9 +707,10 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			ret = -EISCONN;
 			if (rx->sk.sk_state != RXRPC_UNBOUND)
 				goto error;
-			ret = copy_from_sockptr(&min_sec_level, optval,
-				       sizeof(unsigned int));
-			if (ret < 0)
+			ret = copy_safe_from_sockptr(&min_sec_level,
+						     sizeof(min_sec_level),
+						     optval, optlen);
+			if (ret)
 				goto error;
 			ret = -EINVAL;
 			if (min_sec_level > RXRPC_SECURITY_MAX)

-- 
2.46.2

