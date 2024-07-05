Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DFD1465AE
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169988; cv=none; b=ZMNSRzSuh22ZZxbXSAVGvnKjYu2rKb4vdYTA6QlCkHi0oeZ7EEBxyHhen7ce9BFDMagjt4kFcwN6+gaEqhOlNikm5H4C2PtXIZs0u6PD3PaBLun+Wm6frD71TfDfL9AdvLk9FuLJuLWJ1blwuAp9We4skSJ5cL4RadL6MmgOVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169988; c=relaxed/simple;
	bh=fRriLEuynZ4IQ9BNM3Bvu0fzJ1hoSPesVZtSGdTcsFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4G0CiOZl/sTXPlbMhJFc7tzCg5IWuaCXa3ODPn1NporxCMh7iT4lTbMKA1No/KRMRFGA/FuwDZWsDjUDxSnS/AmYxGQmN/ZKFx7oKJ6XDb5HfvTbHZNTFHrbWu8HnhrQkB1ye9vMVMGuEH07g3TvMHtanwPAH7CCFAZsfk/1OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 146D560015;
	Fri,  5 Jul 2024 08:59:38 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ v2 11/11] unit/ringbuf: Fix ineffective guard due to signedness
Date: Fri,  5 Jul 2024 10:57:39 +0200
Message-ID: <20240705085935.1255725-12-hadess@hadess.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705085935.1255725-1-hadess@hadess.net>
References: <20240705085935.1255725-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

"len - end > 0" can never be false because "end" is unsigned, so the
whole left handside of the expression is unsigned, so always positive.

Error: INTEGER_OVERFLOW (CWE-190): [#def22] [important]
bluez-5.76/src/shared/ringbuf.c:240:2: ineffective_check: The check "len - end > 0UL", which appears to be a guard against integer overflow, is not a useful guard because it is either always true, or never true. This taints "len".
bluez-5.76/src/shared/ringbuf.c:242:3: overflow: The expression "len - end" might be negative, but is used in a context that treats it as unsigned.
bluez-5.76/src/shared/ringbuf.c:242:3: overflow_sink: "len - end", which might be negative, is passed to "memcpy(ringbuf->buffer, str + end, len - end)". [Note: The source code implementation of the function has been overridden by a builtin model.]
240|	if (len - end > 0) {
241|		/* Put the remainder of string at the beginning */
242|->		memcpy(ringbuf->buffer, str + end, len - end);
243|
244|		if (ringbuf->in_tracing)
---
 src/shared/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/ringbuf.c b/src/shared/ringbuf.c
index 3dc7ed71b2b2..1b7adbb4f513 100644
--- a/src/shared/ringbuf.c
+++ b/src/shared/ringbuf.c
@@ -237,7 +237,7 @@ int ringbuf_vprintf(struct ringbuf *ringbuf, const char *format, va_list ap)
 		ringbuf->in_tracing(ringbuf->buffer + offset, end,
 							ringbuf->in_data);
 
-	if (len - end > 0) {
+	if ((size_t) len > end) {
 		/* Put the remainder of string at the beginning */
 		memcpy(ringbuf->buffer, str + end, len - end);
 
-- 
2.45.2

