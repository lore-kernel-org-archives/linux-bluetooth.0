Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561C1B0F1D
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627211; cv=none; b=XO6PZ+GbS4u8L3tS25HMNJklppRJiIozl90AtJArXd10YgsiNKbAr1riK3js0tZkcH0fJ4lflFM90taiTTDgTDLfJ60XrabvOYN7tKnEhKRMeYc6/4xmLatpuYIhVuu8GAP64igMgW3lk0F9uAp5WNuvkkMJlE83AV2nfVtAf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627211; c=relaxed/simple;
	bh=gprTeoy7X/Wjqtvvoz0adWqYsbyBH37Bx0rOKOG0ctk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AjRN5HAJ1FpYsGTT/J+PbDfRghtW5dNqEIf8BsXzVHUAk9f1oQFQohNauoHzGu8qnqo9fUbTCVqlUUwQ1uHs0XkSuHBCJKkdpn4dTtdyI83ZzsxbqDZe/C6olUj27tDe/EoYG74/KFv5OzYsEfhk6CHIgeM2J4DnG5tjCR2raw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=FAXhaIW3; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="FAXhaIW3"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKs-005ygM-7t; Fri, 15 Nov 2024 00:33:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=plGZttL9jrxvU+XUBlrhk9Z1MsQem1Esym1JxdfFUxc=; b=FAXhaIW3c0kMy3LBRtxUgOxc26
	Q9WlvN8bnoW7bhdwiFh84UhK/tlJYTrcwEXBX/VWVoSrOloZ/Kn73hx1gJGpe2/Pka4QfUr3AP9AP
	oSKF6pRkodXY2175GJO0DfjYzinsRe7j4Gnh8TONLjtgpTiFbMhs/C/EjTS6UoBEFwsTib3XEWJOv
	cPaQMz6/lFO8UNSP8utL88izM8gfGHVNgp+T4269YSFKBJh59GhSVG2FQejjaEi2vgL2ZK3i4Zz8o
	Y7UxjMchVZIk+sA3EhcNTklow+Wb3+HhOuU40CntbeL7jZgcQRM6Dj0OLiofJLw+Dio/XVYYtYP1M
	4eBAwUzw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBjKr-0005mr-RE; Fri, 15 Nov 2024 00:33:14 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBjKR-008nXm-Lo; Fri, 15 Nov 2024 00:32:47 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 00:27:27 +0100
Subject: [PATCH net 4/4] net: Comment copy_from_sockptr() explaining its
 behaviour
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v1-4-d183c87fcbd5@rbox.co>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
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

copy_from_sockptr() has a history of misuse. Add a comment explaining that
the function follows API of copy_from_user(), i.e. returns 0 for success,
or number of bytes not copied on error.

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 include/linux/sockptr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
index 195debe2b1dbc5abf768aa806eb6c73b99421e27..3e6c8e9d67aef66e8ac5a4e474c278ac08244163 100644
--- a/include/linux/sockptr.h
+++ b/include/linux/sockptr.h
@@ -53,6 +53,8 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
 /* Deprecated.
  * This is unsafe, unless caller checked user provided optlen.
  * Prefer copy_safe_from_sockptr() instead.
+ *
+ * Returns 0 for success, or number of bytes not copied on error.
  */
 static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
 {

-- 
2.46.2

