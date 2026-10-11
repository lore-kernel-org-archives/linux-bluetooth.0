Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18044F56C
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751238; cv=pass; b=EBDkv9U1f7mF/hbjSG95j78l1G6k3q2A7diwEbHJWpmElZXMtjgRc2kadWf0gZ0NDECKf+6FKwl4QcZFZERoPeGbchhi4J6ev8k0AjaOH4uI+0DnxxBuMevu9/NKfiNy9hNiO2eT/dM3lKSDWdgLPUiJYIAwbXK8Zzx0g/U7Raw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751238; c=relaxed/simple;
	bh=U/FrEyJM/pVoo6n+LViBflSSg4g8p64htfJKN31w1hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TlRhEtzpi3y3LqljoF+r9VrVUinx5f8NO8KeloJsUXiOjKobA98ap+puQ5+kUAqCzraKGj9LJVFFSm0MMQ+rKLvZ9I8KDX1mBq5S2kdW0Qswbw1m8KtjaZvzGkAse72CMpaQK6/CWRviy9FnoAsYM76zmeaR/4GQDSxswwjUfU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Zi0DFXC1; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Zi0DFXC1"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4j2stQ5rdzzyw3;
	Sun, 11 Oct 2026 23:40:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1791751231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0XYqRh6Aqm5/UJKNM2rJTluKty+nlQOKZLRFzPgvaw=;
	b=Zi0DFXC1zjs42IeZw82XxSpMwbxW3cepnwJbuunt2KtsmoGYz0Kd15p7YH8xgXfBYf7XbV
	15vD3VXaJSkTb7ssTwCZU28nrSj/IPuowABbMlqH0MaLpjI1QG/c8wAc/0r4G1drRk+IN/
	Hgf5P5J/v/l1K4jpu4MYSk0D3whgWLE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1791751231;
	b=l5DDEy5m8860MTEwM2aVWRdwXLuoaGzxVRACXFOAJ6Ri5zeSEQhlG3aNnLmaje0roo6lS6
	Ut6Eh/t2O16NJ05QXMi4XLjBlEFpqNPpYAviOuY7OJKMLEfdy08uwNy4VjD/n2wt+ErDXv
	Bvmm2Pjr/flWRu6n4IKSK0Wg977lSwY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1791751231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0XYqRh6Aqm5/UJKNM2rJTluKty+nlQOKZLRFzPgvaw=;
	b=Nl7lBi2+WXK23Akd1uufXf4+qo1kfzwWctd58TbRuOoh/M1CR5bFooEebknBQS3vx6ULXV
	/yMyYgbW776svyOQPLhiKKOxvOTvoeSvV47wGNkoYTNgafUJX/ltl16kDxQnHeBm5kZfkO
	Z6c5v02AIfj6syaO6i/ZKO5bC3YC6f0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/5] lib: add BT_ISO_PAST_POLLOUT socket option
Date: Sun, 11 Oct 2026 23:40:16 +0300
Message-ID: <afe26e58f02b6fee0f34d38df817c002cc63d0f6.1791750393.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791750393.git.pav@iki.fi>
References: <cover.1791750393.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel uAPI definition for PAST listener readiness option.

Assisted-by: opencode:qwen3.8-flash-next
---
 lib/bluetooth/bluetooth.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bluetooth/bluetooth.h b/lib/bluetooth/bluetooth.h
index f9f22c3f7..a0f7405d5 100644
--- a/lib/bluetooth/bluetooth.h
+++ b/lib/bluetooth/bluetooth.h
@@ -257,6 +257,8 @@ enum {
 
 #define BT_SCM_PKT_SEQNUM	0x05
 
+#define BT_ISO_PAST_POLLOUT	23
+
 /* Byte order conversions */
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define htobs(d)  (d)
-- 
2.56.0

