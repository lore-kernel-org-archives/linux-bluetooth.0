Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6C21598F6
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076195; cv=pass; b=HWyzyFJSvgNiKodq9n2X7u++TXCyElI1t9FgWWQmfu1DmbLa2qm7LooqpDh87BwxVUnWZRWYvVkCLcbH/FpP2GQnTbsNRX5gQMLd/kPYpQTg1cog8x4DTremyz05xvzA0j/JTm9/TN7WlEfQdWSUsWmf270MCxmp945mu/cqk8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076195; c=relaxed/simple;
	bh=K+u0oLtWLd+fmilQfy2XV5Q9USzIQs1tly6O35BIZ+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZJQNxIts+BEMDQ+F0EB5HeIOtCSs7uW9JTBcZEY8om2v+sWfowIWonbCvUgqdWeacgNYJBVbq2iTl6v2piTrcKWaSX/cVtfxpQP2xAFw1suRtJANfaTWaX5B5RQfzG22A3Q3FLGrX5nhOykZjcxTDzVcS6T1H3gbCQstonJlGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LOeC8Pew; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LOeC8Pew"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V8DG71z0Jz101L;
	Tue,  2 Apr 2024 19:43:11 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712076191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbJSH9ORtrrC1U4ANhQMwZfXmtBmrQ/6M2eokaZ+tVM=;
	b=LOeC8PewNHfphmeMxvNRUSwEAPLfXdZvUjQV4aEGH4rwSuTT4DNV59Muv8ZZ3CLuNwrXWz
	ms22Tb+GsR48qR1Y/+Ymwd0Qezkx67hqalyD/0OG2yu+1AWXhf8fHi6IrcNUpNfl5JRS5/
	xvKoqNEh3iWi2EONrROyPtrLA4WtJTw=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712076191; a=rsa-sha256; cv=none;
	b=bUigidJlRMmoVZytkSk5z6YoDE68lsesZSWxh7ZCpK6p9LgI3DRQULFbFn6BSdlNuwqzHQ
	wNlHPkoh1jZxhC8I6wH2Rzzs+duRw/PLfjo62iIv85IyVr+/sjV5t5+e4iwNFcmDxpC8k1
	JUyw7ifeMX7HBaX878w5RpnkMqkW82c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712076191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HbJSH9ORtrrC1U4ANhQMwZfXmtBmrQ/6M2eokaZ+tVM=;
	b=Z0IO+NdmSzgA8EvNTraxeyHfKWASgH9JIqRR/uA8xrNRx/FLeZl5Xhdl/z05m1tDeBDIPk
	ppJPKS749LxrE45umFU1CpuQxFzO8x287zoPmTnsoJqeMvFNniBp6LPXyNYTh/1FxBVfi7
	rGt/+c/XdoF5z/Z7msXvihMQ/2v5uMY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 1/8] lib: add BT_SCM_ERROR and BT_NO_ERRQUEUE_POLL
Date: Tue,  2 Apr 2024 19:42:58 +0300
Message-ID: <dfac82dfbb128c79c0c62c72a75ccd1da67ec99d.1712076170.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712076170.git.pav@iki.fi>
References: <cover.1712076170.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new CMSG type used in new kernel TX timestamping support.

Add new socket option.
---
 lib/bluetooth.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 75dc960c8..7c310a69b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -141,6 +141,7 @@ struct bt_voice {
 #define BT_PKT_STATUS		16
 
 #define BT_SCM_PKT_STATUS	0x03
+#define BT_SCM_ERROR		0x04
 
 #define BT_ISO_QOS		17
 
@@ -239,6 +240,8 @@ enum {
 
 #define BT_ISO_BASE		20
 
+#define BT_NO_ERRQUEUE_POLL	21
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
-- 
2.44.0

