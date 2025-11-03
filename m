Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8060313273;
	Mon,  3 Nov 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762194610; cv=pass; b=u+exBAh8E83kq4g4A+2Xm3G/3ToxwDsef1YJnEyt2waFDWjuW5WSasyTXKQ87yvRV/ghDEnflk/6Bi2/Bf8F3ia749+uL37ek9hmAnnr35hQuKZsq2HMkND1SvkGU4NJnbb252RbRbxc4o7DLiklIH6/vOJwq82q+/buVt97lEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762194610; c=relaxed/simple;
	bh=QTG6iTxWk9iqGN74zmypSbdoxtvzTIf2unDeptRwDIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCrCbsM6yAlyIIXeova6f0qYL0WLFa84n0WGFOM2XUXdSv+JaZcvOaJlznWCk6unEb9ajLOsT2Rt4GvfB1OahJNGLvSh9Xhu5RUUWKTsj3okjsCuSYaTpEaVt/HV+jbOVXr09d1A7riYOdlu07ntWbWsRmGKPHIjflr7ZlAa4ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jZHALlds; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jZHALlds"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d0g9f609qz103S;
	Mon,  3 Nov 2025 20:29:58 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762194599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9ZrqihpjeJ9Pyk5LJmyFE0Dwy1K8an/oF9kHw7ZBZ0=;
	b=jZHALldsmE4f1iVmmaRtXuhSgyAzvX6ZiwH57g5Y8RuZZhRnDSWmJ8yB9ZhHdCQDdMAG8j
	ynf++1d3uoXPcLf3qpvKMxoPIm7urxKQpLAsWxfvJnwxYhcTpEjsBNRzeuFTavkYOWSTED
	cUZu44+u9PGgse/TROZ7YQEaEPN/MRE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762194599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P9ZrqihpjeJ9Pyk5LJmyFE0Dwy1K8an/oF9kHw7ZBZ0=;
	b=qlkfTh0CnLxYo1xjGtS9VS9bJzQ7W93/JAprvks9JiRsyOGisvAHihjeyh2mtEJ+DFj/ma
	GLD/eDLZ+uhIsHySCx1bkLhxEHdAKUihfzMTipa8EDLu7RYyq+dKan07jyGVrQDhbvVGn8
	TfEPxUI1uEc7aqcb/b03Mdt1k5/YpBo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762194599; a=rsa-sha256; cv=none;
	b=GgPLx7yBKlDcLvn+f2gNwtFS/0nR+HycTz4aMwGZcLHTLRNTYTJAv0JK8poA3blO77X1Aw
	DUoAbxBGJIQuAxvFTEYB8UxTo09JLUB38k1hD97C+E+879pIEeSDr4oRVCX26azrcCX2xs
	f8ucYKMfz5Jb651JbjaOMlQW6YRp2DI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] Bluetooth: L2CAP: export l2cap_chan_hold for modules
Date: Mon,  3 Nov 2025 20:29:48 +0200
Message-ID: <79a6190fd55c2ac425450e1dac0fc7d8cd20b6c5.1762194056.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
References: <467024bf1ba60184bff304d23de33abb0ed2384f.1762194056.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2cap_chan_put() is exported, so export also l2cap_chan_hold() for
modules.

l2cap_chan_hold() has use case in net/bluetooth/6lowpan.c

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - New patch for v2
    - Used for build fix with CONFIG_BT_6LOWPAN=m

 net/bluetooth/l2cap_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d08320380ad6..35c57657bcf4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -497,6 +497,7 @@ void l2cap_chan_hold(struct l2cap_chan *c)
 
 	kref_get(&c->kref);
 }
+EXPORT_SYMBOL_GPL(l2cap_chan_hold);
 
 struct l2cap_chan *l2cap_chan_hold_unless_zero(struct l2cap_chan *c)
 {
-- 
2.51.1

