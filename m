Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E9331A5B
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432834; cv=pass; b=hKLQBvXEvytgKFV2hujnyEhPl/VJmIWVD8e7g4Larh6TgUb4nKAWFb9+NnUb8G2DGzAQr9Ti/SyvcWQygO9dwWLHtEJHej1wtNCQw6kK+KJhgkH7ERTpOolni3DoCoGjTOuUQeYDYVQo8tnnklQBQG5S0nxEbDuPnVvUCyXwYio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432834; c=relaxed/simple;
	bh=dzF1tqbh5nlnp6Yy7Sm35+aq7QNVtfaIjxBZOfF7AH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR9HdMPoN0wb4WiQbrIOLPlZGJtdUoxcgEA21jJ+IBfip0mz/jGf8DL+7dBY+QZGbc6fDXZ5zqNnjRfDa5C12uLxsrO8eGRjOeeYZcHC0aBpN0oRIXY9kl5zYHJZWKDaPVe8Nz67yoGNLzwigQTO2LdYvKQ3eiarAFH2441Uecw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=T3rkYbVx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="T3rkYbVx"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gdTvf0k09z1067;
	Sun, 14 Jun 2026 13:27:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781432830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrJGaFplf6FbxNsy+a3YiOp6QX/hU5sfH08j/7jrDJs=;
	b=T3rkYbVxdSurbSiJHp93hSucRZLHkR3H1L3bWDoRGdjg+erVWNGY7Gdb8u3yWoXZy00inE
	zDbXjuJnblitZfW4yOj6tBWMP9ixVorxopxJQ1vyYiwVhji8tIDzrXZ0Ohb6bOHFY6VXqo
	omjSXAoUyMqmV6xj5rhW1dhAA5WdyQ4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781432830;
	b=OfxlrZTcs4pBYl2b2v8bazh1L80h/5L08qtmGLlhn2RE2UiQnYOl/dN1X8uiETqoWGjkkG
	GTSnGQRqCVmFxT72NuCC2aOAt8sKToWKG9SYzqN8WxQiudJPrq9p+/+vH127FPGFMmf+m1
	xNT3CFg2+Louca3velCk4Tf09LPHBng=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781432830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrJGaFplf6FbxNsy+a3YiOp6QX/hU5sfH08j/7jrDJs=;
	b=pZ3DWm1eozl1zZdhubAcXLCr/Ql6FWB7h1zwmx/rFDBH8bsS74/2Wa+UVsIvaKmiPPbq6E
	9TZMpPElP3p8wb9Ha0iQHU9D0xggbC93oSDFyg5tI8koQzCoVd914chIjoqiJyRUbzS5AJ
	k7msoFQYp2i89Iozy/CslNmTw8wDW1o=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 2/5] Bluetooth: hci_core: Add minimal context analysis annotations
Date: Sun, 14 Jun 2026 13:27:03 +0300
Message-ID: <703fba3011512b53b8ceb731157603c0f1d98cd6.1781432726.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781432726.git.pav@iki.fi>
References: <cover.1781432726.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal compiler context analysis annotations, required for
compilation to pass.

compiler-context-analysis.h doesn't have tools to deal with the
conditional SRCU locking on return value used here, so just disable the
analysis in places instead of refactoring, in order to not make code
changes here.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5ba9fe8261ec..d1e78ae7728e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -62,6 +62,7 @@ static DEFINE_IDA(hci_index_ida);
 /* Get HCI device by index.
  * Device is held on return. */
 static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
+	__context_unsafe(/* conditional locking */)
 {
 	struct hci_dev *hdev = NULL, *d;
 
@@ -89,11 +90,13 @@ struct hci_dev *hci_dev_get(int index)
 }
 
 static struct hci_dev *hci_dev_get_srcu(int index, int *srcu_index)
+	__context_unsafe(/* conditional locking vs return */)
 {
 	return __hci_dev_get(index, srcu_index);
 }
 
 static void hci_dev_put_srcu(struct hci_dev *hdev, int srcu_index)
+	__context_unsafe(/* conditional locking vs return */)
 {
 	srcu_read_unlock(&hdev->srcu, srcu_index);
 	hci_dev_put(hdev);
-- 
2.54.0

