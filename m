Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478016A93D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718644321; cv=pass; b=id5CJWyZgef8nXYuyDztrRH7obs9tmNTolMc+e19Y/u4THcLjQVPIixIQvLf310wVXa6CAwO7d0HJyjopYtt4cFLt+Lx1fpYp/IK5gYdeSygmZ8X+AJTzRRzZMwEUelMF3vtabAwUVzYWlypab3GDGUA2GblPnlwJ5YAjhbXLjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718644321; c=relaxed/simple;
	bh=B+Ccst78SC9JGCU7eJ1QXYvCy7AfN2tXvM02ihU8hjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM+VXCd+kSe1GvaaP1CiHaGZjeuU7Qz/y5iQZ3FIJKwoADbTXXiO8IX8Ll9ZtApm+2KC1DBJeiTnCDERS+/8XVDWY8/IWnkXBGg1PdojiKDR0ddVTBq+Ftg9fndIYlNz4iJEv5g9AvmXHfNr6qagqi87sgGai44iowGfMN2MH5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XevCgcaR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XevCgcaR"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4W2xJD4wvKzyS6;
	Mon, 17 Jun 2024 20:11:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1718644317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kavpnbwg9Rz7IwjOzIRyFE+xqzhGs427j0LdVSM7deo=;
	b=XevCgcaRTwKKFZoHkKFcToCqnL30nClhrfclc8b88qwC/b5rtf8UCkjoCijVyZjM9ASo96
	ftwuVwetA0TiJ/pkOL5w8ZSGwAC3f5bLNfdCly9A/dX+aZv50ussKZmybshQW+0xKq2maZ
	pOIGg5i6xfBol1e3JDv32p3C+3/1/jY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1718644317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kavpnbwg9Rz7IwjOzIRyFE+xqzhGs427j0LdVSM7deo=;
	b=GCh25QlobMle2qOQdPYbr4SBZNEUjv/c9oxnbcSaJmn79YQXYlM+iu0oPtVurHc04m6hRE
	r1RjzGkYEibIdx27PIUKCLxFi2yhdVbsAqhYPSyP/eDbqO/U42IxFAyMZd9pqqBEIFvFjR
	I9/xVAcDBMzUs4Lc4PfR8K/2RdBxqdA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1718644317; a=rsa-sha256; cv=none;
	b=Yvf9vzair7L7wy4QfKIGKT8uIa6rl3Gv4EeWyiRXnApQUBKTgvT7ARzFRDkFhE+6vuEK1p
	44u9pvXAP+WYRtN6UlpDN8my4d79famiaBn7jjraEKfD7oOFi9oJaEM6MrXWg2U5drZbLa
	5COSbHES48YqgrzhmswQV6SRST7VMUQ=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] transport: fix crash when freeing transport
Date: Mon, 17 Jun 2024 20:11:53 +0300
Message-ID: <ee5b81f6306bb9ac014b02c028d159295acc469a.1718644267.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix UAF by freeing transport->remote_endpoint in media_transport_free,
which also frees the struct (not in destroy after the struct is freed).

ERROR: AddressSanitizer: heap-use-after-free
READ of size 8 at 0x508000022ab8 thread T0
    #0 0x493624 in media_transport_destroy profiles/audio/transport.c:223
...
freed by thread T0 here:
    #1 0x7fb057d10294 in g_free (/lib64/libglib-2.0.so.0+0x5d294)
    #2 0x49dd2d in media_transport_free profiles/audio/transport.c:1276
    #3 0x7e0e99 in remove_interface gdbus/object.c:682
    #4 0x7e8f40 in g_dbus_unregister_interface gdbus/object.c:1430
    #5 0x4935a2 in media_transport_destroy profiles/audio/transport.c:220
---
 profiles/audio/transport.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 0ce94bae3..922911cf3 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -220,9 +220,6 @@ void media_transport_destroy(struct media_transport *transport)
 	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 						MEDIA_TRANSPORT_INTERFACE);
 
-	if (transport->remote_endpoint)
-		g_free(transport->remote_endpoint);
-
 	g_free(path);
 }
 
@@ -1271,6 +1268,7 @@ static void media_transport_free(void *data)
 	if (transport->ops && transport->ops->destroy)
 		transport->ops->destroy(transport->data);
 
+	g_free(transport->remote_endpoint);
 	g_free(transport->configuration);
 	g_free(transport->path);
 	g_free(transport);
-- 
2.45.2

