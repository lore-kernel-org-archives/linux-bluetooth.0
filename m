Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AB2F7454
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708491; cv=pass; b=a5oprma5Yq1KZiVTfgY/AD19bp8BYUdzzF/sRnerczB3MEET+o0T0Vy9cUjcmNiO91Mm6iBoPxc0ZwhOS0V9tPP3TjJjA++7aa6DM0oCqfx65r+T/yoKbO455lX03+EFk1NymxBSvpphHV8xD7Oo51EZG+hSPXCJDck9IRTRArs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708491; c=relaxed/simple;
	bh=eDmzJ9fw7qDoGhErWQSD1ib00mBfpU4PuOCZiBWIFCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZducWGNvbrWciPAiVjofNMqMN2/lQO5dQPDaE114wnHw9MXKntUMMmcBsWa6hUAXqrQnDaDO4yJF+HUG3BcpV2FsXIZiq7ko9i7+iOJkaCYzfphWpFMeIFuevICLHTvJUDtwfeLLD6ANGPmyxNDAyVcVz2svYSc8YtZ6KWeuLFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=dhbgMsUz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="dhbgMsUz"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dLXsS0m1Rz10MB;
	Tue,  2 Dec 2025 22:47:56 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764708476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1DoRPan02uSW3bx+ysjBjMx03RNuux2mB2xKuvTw0Q=;
	b=dhbgMsUzaLnGxdl7GMqYXNxvYCAHpEaLm1dkJKKPi2GuQw5EViAvbkytxwkJ5NjvwXc94J
	MUItKuS5g+ia06I9c7WTEYABM/XsVec87QDFbgMl4w/PQlmVlClciRMEDKtcT8Dxxd3zQc
	xWY2hEzwTemhOSa5n2Cqr3QJkeyzQEQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764708476;
	b=lpax63OdBRG64IqpJn1QDSPv/1I9Q3oeBsjGsFUYIlNQOk/9xSQMfImFq0hrW1CqZ/Et9L
	jcU4QbN3gZLWLFmXAXtcvZCvQLRmNIzmHkylwfkXkhIvOpMVHBuCTsTYXMNWVzOuQJvVgf
	VJZfgkhdpimNz+5Ze28bb1di0WPUqSc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764708476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w1DoRPan02uSW3bx+ysjBjMx03RNuux2mB2xKuvTw0Q=;
	b=gJThzFnfSLPhGgckl/J2EMzO6hakixmComyafWpTd7KrbF5VjZfscadXQp4/WUnRMPEBaS
	X14a82nJwsFSpIjGsnJzH+e65sjaqLiQcwFGGABrImrBkP2R4QQfby8gXVS2pB7OEv71my
	jR++47ot9iZ/wZyXktQfSITNKLaZAYY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 7/7] vcp: wait until client ready before marking profile connected
Date: Tue,  2 Dec 2025 22:47:52 +0200
Message-ID: <ede9e43cf2971a7037d4772fc7a3f5f5f0a258e5.1764708372.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764708372.git.pav@iki.fi>
References: <cover.1764708372.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark vcp profile connected only when VCP client is ready, so that
dependent profiles do not try to use it when it is not yet initialized.
---

Notes:
    v3:
    - new commit

 profiles/audio/vcp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/vcp.c b/profiles/audio/vcp.c
index 8949c7185..b2c9d1b32 100644
--- a/profiles/audio/vcp.c
+++ b/profiles/audio/vcp.c
@@ -282,6 +282,13 @@ static void vcp_remove(struct btd_service *service)
 	vcp_data_remove(data);
 }
 
+static void vcp_ready(struct bt_vcp *vcp, void *user_data)
+{
+	struct btd_service *service = user_data;
+
+	btd_service_connecting_complete(service, 0);
+}
+
 static int vcp_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -297,13 +304,11 @@ static int vcp_accept(struct btd_service *service)
 		return -EINVAL;
 	}
 
-	if (!bt_vcp_attach(data->vcp, client)) {
+	if (!bt_vcp_attach(data->vcp, client, vcp_ready, service)) {
 		error("VCP unable to attach");
 		return -EINVAL;
 	}
 
-	btd_service_connecting_complete(service, 0);
-
 	return 0;
 }
 
-- 
2.51.1

