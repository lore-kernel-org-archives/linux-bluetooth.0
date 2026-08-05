Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE1238DC65
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940613; cv=none; b=rRBwN0B682sRmHy6W6a35ElZJAm1xOr8UpWqv5EhPSZIULr4lSX18l4vhRUQbgZhP3F0awr/J11vKU+4UhyQypr2E2EVHrxRBKUE9Nt1ad3L9mGEh/xUODrrymwfiTpsqaYixBpMtWDvBYi9amLjLROXDsiI0LRjy9yrm/2y21I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940613; c=relaxed/simple;
	bh=GWQOgUmGaCnW/7J1hwEvhzsgx1F8Z9pgSpV7rwx1RuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q50MDdPa1IgDQNyZoRwDzEwZHK/eWQcvaTxPluwCdDmf/hatRG4tH9dd7OAe7rEtwuwfRDhB7ZuyQXXWHoM1YUo1W2mXrmpH5cnBAwnistVC1L4xHu4zWJond9K8ioTu9EsJdo5s/JO3J1Du9OWcsd3zimVDr+rpsFwVNqb1pcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kv7+1Wfn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kv7+1Wfn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785940600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQdZ/4Ujf8RSEA8hIdmgFuDrtIelJbLig2Mv6B2/+tw=;
	b=Kv7+1WfnuzDxAqsqK8tig9ABMwDZTr/uCEd2dhOUKtyERHvkvZjtiq0K4MebCAb7Dza5Kk
	MjrQb3stOa3rt/CToSxRw6XGqUqlC0C2nkeFObA0uND2/4NRDuMgBnTwSoT1Y/e66L2Ghx
	3rA/1cm3uoVGy1Rts+kCfp8Vphwv/A4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-JfPA_c8AOhe6fu5NQ65d_Q-1; Wed,
 05 Aug 2026 10:36:33 -0400
X-MC-Unique: JfPA_c8AOhe6fu5NQ65d_Q-1
X-Mimecast-MFC-AGG-ID: JfPA_c8AOhe6fu5NQ65d_Q_1785940592
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 062081800115;
	Wed,  5 Aug 2026 14:36:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.209])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 467BE180049F;
	Wed,  5 Aug 2026 14:36:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Biggers <ebiggers@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: SMP: clear the aes_cmac_key when done
Date: Wed,  5 Aug 2026 16:36:07 +0200
Message-ID: <20260805143611.818559-5-thuth@redhat.com>
In-Reply-To: <20260805143611.818559-1-thuth@redhat.com>
References: <20260805143611.818559-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Thomas Huth <thuth@redhat.com>

Clear the local aes_cmac_key structure via __cleanup() function
when we're done with it to avoid that sensitive data could leak on
the stack.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 031d3022cb1e5..ed30ca0d773f1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -164,7 +164,7 @@ static inline void swap_buf(const u8 *src, u8 *dst, size_t len)
 static int smp_aes_cmac(const u8 k[16], const u8 *m, size_t len, u8 mac[16])
 {
 	uint8_t tmp[16], mac_msb[16], msg_msb[CMAC_MSG_MAX];
-	struct aes_cmac_key key;
+	struct aes_cmac_key key __cleanup(aes_cmac_zeroize_key);
 	int err;
 
 	if (len > CMAC_MSG_MAX)
-- 
2.55.0

