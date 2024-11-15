Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E11BE87C
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676995; cv=none; b=oHmrOyMBHTPULzzLjC03vZJWxJmrbr+KFzXM0ehJbpfv4A//TLTI1ZgtszL7++Q/1SobykRs1RPf29NjBmANXhtIaKcCJVuHZoXbX2/Md6JuH+Wdo9a/+H4mWiTJtzXZ29NrRpEGt7+NL7vJ1kET3hzHjpHPZUqxcROw1nTr2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676995; c=relaxed/simple;
	bh=gprTeoy7X/Wjqtvvoz0adWqYsbyBH37Bx0rOKOG0ctk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KqLj2XIMfzlTIGJ6IEmeSFCBtf/5ymxMkz6RLcnjmKGaYE73bqHKuz5aifpP6/8hyDvq3xC+OjqazNGdYU39YswcfKdmqV3WoloXpxcsNi+fy+eZvJ1jTk5ZVhuS3VUW6luDZwqgFzp0oJdO3KQi/6YPPKa8ZbD7y2Y61NiCz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=a5yDSYvQ; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="a5yDSYvQ"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHv-007sXw-Ff; Fri, 15 Nov 2024 14:23:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=plGZttL9jrxvU+XUBlrhk9Z1MsQem1Esym1JxdfFUxc=; b=a5yDSYvQKVW8cC/mBaiUNbmcYR
	Xoj378dDHZHcYRfxKdSTPhiXywRmb9C/2uAg5bQw9Aqiykg+d2E1W+bYVofxGtpsRatBpu7Ndnouj
	GzcKWuBfR6oob7RmFjuuI+PhQm1gBanKL7Qnci7b6hgX/lliAFJJB/hlb42fw0upMf9B8avcwQj0C
	5YvkfOJPyPo1PbqA8mxJl3CzcRshQduebvZJ32PmQeyvHYliGLxUiVZsM36CsAnRI+wlEd2BtSFPN
	tVkh/bo8KQfq92A7znz8NAgjmGgzMthP11KPNXXy0tZtCuC17Tne6dqcAcOlpYw9y1FU5PHbX5ZKf
	HPEQam8Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBwHv-0001of-4z; Fri, 15 Nov 2024 14:23:03 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBwHk-00BIK5-8y; Fri, 15 Nov 2024 14:22:52 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Fri, 15 Nov 2024 14:21:43 +0100
Subject: [PATCH net v2 4/4] net: Comment copy_from_sockptr() explaining its
 behaviour
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-sockptr-copy-fixes-v2-4-9b1254c18b7a@rbox.co>
References: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co>
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

