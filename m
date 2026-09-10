Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2351FCD1
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058915; cv=pass; b=fGsMQtOsLGHoUtwu/ayfBxoq8IRQss7XrIkpHfkqtVnsisi8EVPV0bvrtz4dmPcRnx8Y8vMXSXNfLBcNPqlnL0DplQr8vJga7XXBge7BQFq+SLOSvBWTAq2LF3OTs97kaxjQjioVV/YrOOZwYeQwozjvfngY1gaiGO2KDxFfODw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058915; c=relaxed/simple;
	bh=m3PprfanUR8UlJtUTr45iL1v4Tf6sfZCnVu3eGKU9x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMpy2hDwwmPv2EQ2LYx21AiAxGqQ4VCq28R2Bsjc0PGvBcHHbRYsoXY8wRdyfYH26Tvb+zu21U48C7ZUzQzFAN1yxXY4TXu4AnXAORKYcMfE4xcGilMV6aA2kfhxey+jYMTbvGiT4z6urL/d2qHHT8kpdNfL6HvlxaQjoIjHPrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=PqIs9U+4; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="PqIs9U+4"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hgkBm29v2z10Gf;
	Thu, 10 Sep 2026 19:48:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789058896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ2d2onxtytb7Oois33NbQkOz2uVzc2MMXcFKygJnGc=;
	b=PqIs9U+4LNbts/SofBnfnxipxP5nkEYj6gv6n6E7TRB/bMcEu6zAmHXt78MiIdwOsGztqk
	MVANqYOFWjTO9DKWQmFlDrdqjgBL/dfrUhjaEeX+FJv7Nns1qmcrmbq7iWHbPBEybZbKOa
	y3hy5enolZ0gqspNKN9GaBy2piyja8I=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789058896;
	b=TC6jqs2L6s8GU8eCGEymztX5zznSkNPhpVATGRraYaqxK90dCHLPsQpW0WUbKNibHBFSCo
	rScY4Ut3WK0501fq6/S8s+pn7RrQlCS3cptiOoRu43JxLt6G/h1ihI3Rrm88+vBvBufk/N
	/jlaKfUyQl8jgoHfYx19l/D31Z3DXYs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789058896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JJ2d2onxtytb7Oois33NbQkOz2uVzc2MMXcFKygJnGc=;
	b=kZ5qKvq+CDdxsf9Z0M1HGTnOC9lVG/6WQR4f0OU0WAntGZs2els5M1j1gxSP42ypFiIHck
	F7A9Ql9T+HHCMd3wNjvKCbOG+3WYh0ZlkoDfOlEzzlb8s/AqT9Qm2KENgYJP4K6GKjmfpf
	2xG9DILN2bNTffrHo/ytQj4FYZNpCR0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] doc: enable virtio-fs in tester kernel configs
Date: Thu, 10 Sep 2026 19:48:06 +0300
Message-ID: <05bba57a2d407b44212415591ffd7f4dcce4098b.1789058875.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789058875.git.pav@iki.fi>
References: <cover.1789058875.git.pav@iki.fi>
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

