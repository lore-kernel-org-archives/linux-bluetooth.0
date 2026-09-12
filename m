Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916AA3939B1
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237124; cv=pass; b=BpKJcC6vsW2fEqBIh/s+rs46ooV22o/JwSprpvIwsAqLQClCTo+eYp1l+iUKpwX9d4aC0NZEhITM0iIAG0U9Z3m+PygBFjCmKGhqhDFFx9msBmR06jCaHF2HPNbMeEWFwW45ois+Mz9d6udtnJ7DecxcUEEc1YKChb4NmVfla/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237124; c=relaxed/simple;
	bh=m3PprfanUR8UlJtUTr45iL1v4Tf6sfZCnVu3eGKU9x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYoCuSCSwe9V+SpuwnHVT4w0+DBAGmSGYrLTE2ldTF6jOhyORzcGQ22SEZlvx51tkfLQsxAxvIF37DD3DBcx69GcC18eqPYjdGt1WNkrLNcysFDnXLGtQ8EpS/zbY//vuk47A8Nq421QQN3oNECL5EdITQ+XEMdW66yF+OZot8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=E/i7YqFY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="E/i7YqFY"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:5:f011:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hj0641BHKz11Dd;
	Sat, 12 Sep 2026 21:18:36 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789237116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ2d2onxtytb7Oois33NbQkOz2uVzc2MMXcFKygJnGc=;
	b=E/i7YqFYl9TYKqUtO9exeBo17Td7kE3DTIN7mfwwdgBdBLkboUBHJ9C4rpEthAtJrZy0Jb
	TvcNWplHH7fs37YkLwiB1z59tNIuYyB0T9eZyHhy/k9fxeGD4eXCf1uMnORmiLzO2nskwu
	ydsc3UAAuCPb3bEgdAWKKAmad6CSSFs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789237116;
	b=hX8fiJwBrvpLof67p26GhltO7B6gMxgRtr4pOD65alwMMn2eUoP8m+KEqgA7tBwOLW0o03
	SslpSM21/kV/ZrAqMhLyxljfD7NP7j4yNFEGUYXaHVzU1/rU01DrfpF4nFcDqsKAezfqrh
	YdT3U6uf4wv2Huc2xXyBgi62YKfrS/8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789237116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ2d2onxtytb7Oois33NbQkOz2uVzc2MMXcFKygJnGc=;
	b=Dp4PChLTTT5tHPfRQwiDrhRm4cvO9MEPsBworGsgUj8kgNWuX30bXF/xUpoxBb2khGK499
	7PR6ouEIM+pOS7vS+bjDyD8oqIBVDCs1lqKItd7sTr7oTTCbbItOaOwM5v+3NlOzbsGeGu
	5FoGTUBb4BTqN9ub01iP5VyDpW/t+mU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 2/4] doc: enable virtio-fs in tester kernel configs
Date: Sat, 12 Sep 2026 21:18:21 +0300
Message-ID: <981f387d877f511df53d54b1211126b1a6be695c.1789237077.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789237077.git.pav@iki.fi>
References: <cover.1789237077.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for virtio-fs in tester configs.
---
 doc/ci.config     | 2 ++
 doc/tester.config | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/doc/ci.config b/doc/ci.config
index 2da3e14c4..99d59c5d3 100644
--- a/doc/ci.config
+++ b/doc/ci.config
@@ -7,6 +7,8 @@
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_FS=y
+CONFIG_FUSE_FS=y
 
 CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
diff --git a/doc/tester.config b/doc/tester.config
index b9c5f34bc..e68740dc0 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -2,6 +2,8 @@ CONFIG_PCI=y
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_FS=y
+CONFIG_FUSE_FS=y
 
 CONFIG_HYPERVISOR_GUEST=y
 CONFIG_PARAVIRT=y
-- 
2.55.0

