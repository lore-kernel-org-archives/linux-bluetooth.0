Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82425CC7A
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018904; cv=pass; b=feUfOYH0Defxx0JyTedW+HBas4w4Oym3Lk7ku+WkWMvWnjAqiQdLjLIZmqF2rp7J9D++NCTlT8AYBxaTOBOizGcl6nb2WatLP8dEjGTM4v/m9e89k7/Qo3yJ+4F/gUvpa3SRqjaYKpDk765s84eblA+tnzIJdnIttWoLfYknRMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018904; c=relaxed/simple;
	bh=owHAc1A7rj1hHdc+AIh8uez4wxOfu/va/ksUHS2s350=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIMCdGyb3g7i/lBDTyfmVW8kkWExmT1VjZIrpQ8j5Q3L2LYKSmkUzhUZLd/vNrEbP8AGYb88kX+AHIXmEfyNvenc/q6L6ArlTEkLl8Jnv0zJ9nQ36XnVCWcki928kcodgoJ1OfTsNptPCFhmF8NSTuvZZMf8CG3u1kggIZkFDhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NYojmin2; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NYojmin2"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlg22BzFzyW9;
	Sat,  6 Dec 2025 13:01:34 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLK1CjEbucuW2MMkH974FnWramo+ozs/4y9F5HknZkY=;
	b=NYojmin2MHUySVUUPkgbHBBSySOFcelJcOAgfT89OQlHLDSVmWeh9zgbgB9raLKanNTx/N
	9Y8o0z0iDEKSWRaYYAX40mx/9quUkJ25VFGtoz0hSAONNy6UyEgvmnxKgCDxmuh84Tn+BQ
	BKFq8lXzPfpIEvp7GTDDd0lbazOJAtE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018894;
	b=RIok2SwKS8hI46ccNuoWsSvlaYksui1yl0e8loAynwuEFiWGCFRRuDHBk1oMnqPmIz+Uxx
	iLUe9B4mNqArS4IZz2v6bWT2AF2dqP3KwLf0Ko+z/29iF5GeDglZKTalvVo3G10vWXPXQ8
	JWa6EiMZb4DoUoAx/ckg0By+XIEsYLE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qLK1CjEbucuW2MMkH974FnWramo+ozs/4y9F5HknZkY=;
	b=ed+sRQc9yxYQ2uvCpQgwTsB0iwgPLLe9ZUNxHkjuqwacmnKMMrWRsv0HWyCAJIYlit8ddL
	Y5jjC5TqH93WohSnJbVnxhJvJmjkr9UaQYQJa47p12Wv67AehafQYf+vUaXZC6jsBNorAa
	BYFc5xh5vG3f4G7uD8fSxwRxr9GTUy4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 02/11] shared/tester: check size before trying debug print
Date: Sat,  6 Dec 2025 13:01:18 +0200
Message-ID: <475a3be7c4dab70d162d58b27f21d02218e81bfd.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/shared/tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 1f59322bc..7a0145b46 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -983,7 +983,7 @@ static bool test_io_recv(struct io *io, void *user_data)
 	if (test->iovcnt && !iov->iov_base)
 		iov = test_get_iov(test);
 
-	if (memcmp(buf, iov->iov_base, len) || (size_t)len != iov->iov_len)
+	if ((size_t)len != iov->iov_len || memcmp(buf, iov->iov_base, len))
 		tester_monitor('!', 0x0004, 0x0000, iov->iov_base,
 							iov->iov_len);
 
-- 
2.51.1

