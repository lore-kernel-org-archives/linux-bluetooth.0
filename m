Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27797346FB3
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107565; cv=none; b=pNi4646xPUhxY5s06rioNNmoVNdfmCLzd1veRBuHGXyYUxn5gJ5SYGeaObc+AU4Z55oPgdIeTBna/1Pzdf3dt1T49EbtoiVyO4l5VkFIgtezcfbpsonXZRxzId/FMrnrCpFQpFmp91M6g5gyDbptcppaZTTEf3u1eHcOsgx4v9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107565; c=relaxed/simple;
	bh=xll+zQBRt7rsfHb8Jkq21yOblpXfl3YCI/v6M+vzAvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX9Vi+OHKKITOALXHFRyI6uAt52A2lvuEIwWgsV2hndqI6vivVR6+ac8WthUUOFzN7UXOzJ873TlxGIYxTTaco8X7gl+zWTYP6lpNBUAo5cczw5WAAGZ577tXMtRVIR1wCfm2tpjC1DrrQ57DTFeQxMCn1I8PShp+WQ6hHsJaaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJpbbr0E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJpbbr0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786107552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6hdW7g3Ya8i9Nu/IIIEE9pizj4AfF82eIRYCUasgO8=;
	b=IJpbbr0EVO220ZzGTlG8EZTYnuejwH50sV1anGnt9xVulv8j183xF2QgiMZYopiYRHjCPH
	+g8M/zXQMXC9G+pIOsieFP8ZEg/ew8fSELJ3cL+SqRkpQXvae6KuHP087xQvvUUzJXriER
	GlmYVdMSjl+z7UTFt0fjoT48OAwruT8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-OfXcrwZXOEemRMILt9Qq4A-1; Fri,
 07 Aug 2026 08:59:09 -0400
X-MC-Unique: OfXcrwZXOEemRMILt9Qq4A-1
X-Mimecast-MFC-AGG-ID: OfXcrwZXOEemRMILt9Qq4A_1786107547
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE9F21955DB0;
	Fri,  7 Aug 2026 12:59:07 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11E9430001A2;
	Fri,  7 Aug 2026 12:59:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <smfrench@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] Bluetooth: SMP: clear the aes_cmac_key when done
Date: Fri,  7 Aug 2026 14:58:41 +0200
Message-ID: <20260807125845.1477067-5-thuth@redhat.com>
In-Reply-To: <20260807125845.1477067-1-thuth@redhat.com>
References: <20260807125845.1477067-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Thomas Huth <thuth@redhat.com>

Clear the local aes_cmac_key structure via __cleanup() function
when we're done with it to avoid that sensitive data could leak on
the stack.

While we're at it, also clear the tmp[] array here that is populated
with a raw version of the original key and thus would leak the same
information via the stack otherwise.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/bluetooth/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index c4470958b0d57..4a32e4f80b48a 100644
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
@@ -178,6 +178,7 @@ static int smp_aes_cmac(const u8 k[16], const u8 *m, size_t len, u8 mac[16])
 	SMP_DBG("key %16phN", k);
 
 	err = aes_cmac_preparekey(&key, tmp, 16);
+	memzero_explicit(tmp, sizeof(tmp));
 	if (WARN_ON_ONCE(err)) /* Should never happen, as 16 is valid keylen */
 		return err;
 	aes_cmac(&key, msg_msb, len, mac_msb);
-- 
2.55.0

