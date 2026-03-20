Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CEE369201
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041082; cv=pass; b=KiPtwQLbSKkI/tH0cR2Vg1OUSXXWzM16btIVKc8SrmkFQdkQXEZ4khH4fSW5o2ni7vdLFVu6yYxg+kp4zLa/ccKIVouFu+QvHyb28yJ53caWC6qmN3iridvpoc50WOtjXGiDVy+aUnq/KRrjQ0S8JSQR0TsLWYYTjGigo+yMk/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041082; c=relaxed/simple;
	bh=oZdY4I3l6Eft1UrkvARddHl6Q3vrsowIJNSfH7U7N9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcAB17/PXb7nl7xISsnIGuMKMgxh46hPzRYjhAgQojTZVDPUmmBkGtaA2/Dxw+quunUaRPTLQHB64pWG/rywnO5qe6vyyQyzvty0xExhXhbCOPXGPa4jgxHK32BEBVo1UseAvvzjBnTu8ET/fya5rclYPSzAJy7W97LXxSll0xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=eqALyB5d; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="eqALyB5d"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGY5NMbz1054;
	Fri, 20 Mar 2026 23:11:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwoyNtcIj0iD6Cp9EXbxWYAiDu3cF2W2Gv8+zFdwr9o=;
	b=eqALyB5dPKSws78dWc5A+Ug9VKA1COiWcpo0HkeZ+VaGrBBd4rP7pvyg97lZeF8PA0U5Kv
	rgu0mjh8xKk8kQnyfxI/cLpt0sZFe/aqc+1t4j2XcQ1Xa81C46nihV1xtMrMiLJED5UsLf
	p5/9PJJdchcoHEsJI8Vb30iI5+nygnw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041078;
	b=NMHsvhLe0fUSCsdZ7LVjtv+WL9yDXfMpDXb6RUtakF/Cb+LYgbEB3xgwzWdlCsElAexccJ
	yevJv6oUod0k8nqFK3sYv/UGaIOW/hZXDI63s7nty4x5C1FkrAcx38lm1IOQ0ibMAtzI8O
	k+wZOLd80+qDZlhx+BGnd3WWWcuRL54=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwoyNtcIj0iD6Cp9EXbxWYAiDu3cF2W2Gv8+zFdwr9o=;
	b=lCZ0E8ACuQ0ePipfKAwxvU5IVJJYIJA4/xE1utUKtTpRJdErLOYNdIzFLHNqmU3wPNIUhL
	Fv9WNOlWc74fGEo+bLbjSCXoPSz7OiteDaKc1vPk96X1mrDy9qSP3DRsQ9o6KDZq1SmpcS
	kJDyyn25MThNPJHSh9vlO2ANbu8Ak64=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 10/20] doc: enable KVM paravirtualization & clock support in tester kernel config
Date: Fri, 20 Mar 2026 23:10:54 +0200
Message-ID: <9d6e9c36914e02c0793999df293e5575741cd1fd.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable KVM guest and PTP options in tester kernel config.

This allows synchronizing tester VM guest with host clock, needed for
testers that want to compare timestamps outside the VM guest.
---
 doc/ci.config       |  8 ++++++++
 doc/test-runner.rst | 16 ++++++++++++++++
 doc/tester.config   |  8 ++++++++
 3 files changed, 32 insertions(+)

diff --git a/doc/ci.config b/doc/ci.config
index a48c1af9d..bb3cb221f 100644
--- a/doc/ci.config
+++ b/doc/ci.config
@@ -8,6 +8,14 @@ CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_CONSOLE=y
 
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_KVM_GUEST=y
+
+CONFIG_PTP_1588_CLOCK=y
+CONFIG_PTP_1588_CLOCK_KVM=y
+CONFIG_PTP_1588_CLOCK_VMCLOCK=y
+
 CONFIG_NET=y
 CONFIG_INET=y
 
diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index d030787a4..60f18683c 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -122,6 +122,22 @@ options may be useful:
 	CONFIG_DEBUG_MUTEXES=y
 	CONFIG_KASAN=y
 
+Other
+-----
+
+For tests requiring accurate time inside the VM, possible with KVM:
+
+.. code-block::
+
+	CONFIG_HYPERVISOR_GUEST=y
+	CONFIG_PARAVIRT=y
+	CONFIG_KVM_GUEST=y
+
+	CONFIG_PTP_1588_CLOCK=y
+	CONFIG_PTP_1588_CLOCK_KVM=y
+	CONFIG_PTP_1588_CLOCK_VMCLOCK=y
+
+
 EXAMPLES
 ========
 
diff --git a/doc/tester.config b/doc/tester.config
index 015e7cc1a..0cf5e2723 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -3,6 +3,14 @@ CONFIG_VIRTIO=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_CONSOLE=y
 
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_KVM_GUEST=y
+
+CONFIG_PTP_1588_CLOCK=y
+CONFIG_PTP_1588_CLOCK_KVM=y
+CONFIG_PTP_1588_CLOCK_VMCLOCK=y
+
 CONFIG_NET=y
 CONFIG_INET=y
 
-- 
2.53.0

