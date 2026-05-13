Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8214CA28D
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689071; cv=pass; b=YyEf369AaMB4jDYl+6YRc/8GpHkPSp1aBYiBKkHb5bjL/QPrOqoDgfpjikfJkAv3jBj/gCS1cg6W9ZydhmGd30xvBNryUkwT5TdZVB4ge5dCq9MP1Q7TW6RYrbynZNXzb84xbQDy2zOi/xKnkAyds62XDsUJ3Z0gDRUnt9LMV0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689071; c=relaxed/simple;
	bh=IAwYdLttuOfuKWfu8Cj6bZEhw+lCsFMD5n9rFwTrW+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPMxmPM3bUDhuX6Y5menS7Ad8I/SzOInk7g05VSupdvU+e3tv2kAKeYjALK057G2VOw5DDQarA+ZG9t9dqypIzLYsTl463BozJV9udZDw4cWnj0TUN3R3zHgdOnct9JISniGX6ijCMiKLAtDo7MarTxwSi+oA9ltH+qOcHqXiC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=m8RYMS27; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="m8RYMS27"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzBr0FGWz10PX;
	Wed, 13 May 2026 19:17:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lm0lDyjXW8vurJFcSxywW1W9dv2sHO0ptOCwsOTqVlI=;
	b=m8RYMS277aOAwm5tXdnnWksqxNBmDiDib2OJEp/J0O+dSSDuRczcV63OfbRxqXEYPx5Pml
	hszQj3CE4exR2jDC3Nc/kataZyBz4gQPyvid9TkPUOzJHnYgxtObAGi9RQXEEv9KgH8g2n
	k6UmkL3z5YVQtLRHLeEuSRpyvA5JQSQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689060;
	b=wVbr4QM36or/tKBp0M0UULPOZN/gMSFfPL/1/odpQAyhkLbkN+kS3I84LzepDwUdOQZOjG
	tW6XHszf1Ar3LWf1guvlve9LCRY18TDq8r8uV3FZCqYfZdLiXwPxyyhFYDxfl/IssxT6QL
	8PuTJyQWJSncm6PpRmAlIhIzivtFvNA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lm0lDyjXW8vurJFcSxywW1W9dv2sHO0ptOCwsOTqVlI=;
	b=ylTMN9dn7hcTS+75STTsT/UD+4y6hWC5yRZtEFXdg935qJTP73GSNGHL4tlP6/mXGn4WJT
	bZSLsGoPSCwEmunHqUnY68dsuVYK0lrrE+TAZO0sB6JXWV7yc21v1Wv2bsIVsdhGBLxEC/
	y4FoWBHUh14UKukg5R5o6fhZxtanFEk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 09/16] doc: enable CONFIG_VIRTIO_CONSOLE in tester config
Date: Wed, 13 May 2026 19:17:26 +0300
Message-ID: <77f24a0728594f68257860f6f84aa874013f98ca.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable kernel option that allows using -device virtserialport in qemu.
This is easier to make work reliably than pci-serial channel.
---
 doc/ci.config       | 1 +
 doc/test-runner.rst | 1 +
 doc/tester.config   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/doc/ci.config b/doc/ci.config
index 31e49ba96..a48c1af9d 100644
--- a/doc/ci.config
+++ b/doc/ci.config
@@ -6,6 +6,7 @@
 
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_CONSOLE=y
 
 CONFIG_NET=y
 CONFIG_INET=y
diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 64715e2e7..d030787a4 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -45,6 +45,7 @@ option (like the Bluetooth subsystem) can be enabled on top of this.
 
 	CONFIG_VIRTIO=y
 	CONFIG_VIRTIO_PCI=y
+	CONFIG_VIRTIO_CONSOLE=y
 
 	CONFIG_NET=y
 	CONFIG_INET=y
diff --git a/doc/tester.config b/doc/tester.config
index 4ee306405..015e7cc1a 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -1,6 +1,7 @@
 CONFIG_PCI=y
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_CONSOLE=y
 
 CONFIG_NET=y
 CONFIG_INET=y
-- 
2.54.0

