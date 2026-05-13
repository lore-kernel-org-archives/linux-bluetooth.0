Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCA30BF4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689126; cv=pass; b=ZAuUqkEvpZB9zzUXRAy3hRqdV/I2C0xrmIQd+qIiDJC8gKF47vPwsAe57W/UjiZ14mkp/qrG5pgCHWv8duK5OgnNpgciHN9nGytfBL/HLyimGV6YRnJQSgN7X0A44pspyFgJ57I/LXF7cROPmqUKpm/C5WNILc3NPsdkrGwsZIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689126; c=relaxed/simple;
	bh=VNf8R022Ig1cRBNM8J3cmgsT1xIgKyr2oqWH+SdEPrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzJ3b0bN9+XBeMZPun84Q5WCf2wrcGCa5/x0k1xuQx6o21d3VU5eAOdOteuYQd1YAYp4WstBWV1zH8irox6tHNamca0BVnTkffm75+IFA9bvTjcuIp6NlGqjwPQ3hVpTFHE9wP5APSCu8d7YPBfJH/GzziC9+3qGIFsFkH0c+Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=yJK1BeyM; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="yJK1BeyM"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzD31MtdzyQK;
	Wed, 13 May 2026 19:18:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkLb+GQfbLfAn66pmbN4/qiOo7Ol9OBX3y7p3zg+XoA=;
	b=yJK1BeyMDLP9/vTJbxhyaOlisXHC/RSx5G8MerJxZ6RcCqIWk0NuxE6syFSHR+OVU3Qej0
	aFkOa6u3AmczXOveQ53Qs7T5VFLbRScbL4cnKtGanHUepVmGFlPwtT53aU9FA/GynPLRtY
	R3gHnBtpIKHmPMtnmLQV1lMgv2lr0CU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689123;
	b=drjB2mzMGVld7xgwKSbhYmEPuWpTuMvmzF0gJrm7LLtM5v95UHUsIdsA9XD4oTBXWXEEYx
	ZK1j4J5mtqJXJDQdC7m0Amo5RAsCd4kgphRuBIe+HU4nPfUpCijhglFk+gWNrq0uSDNygK
	qp6FRb7u2mqpADEFxws4WB/8DV1uqOg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkLb+GQfbLfAn66pmbN4/qiOo7Ol9OBX3y7p3zg+XoA=;
	b=BmVqNEq2fXFz00GX1W4cOBTcB+dGLRfgtfNVmBwD9vXRWGwp9CzRyN2Xo5yXandHvTBXM/
	MuTEdhAH3wbtYqRrtWiT0H+Hhaq11XEBMB3GS9jeKOF2iAcIs5ezpNt4azeGpiq3WGRoT+
	jOcvjS/z1uwjeoVj+D3NFicHrbaNUHM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 10/16] doc: enable KVM paravirtualization & clock support in tester kernel config
Date: Wed, 13 May 2026 19:17:27 +0300
Message-ID: <38fa92f4cf7a01e50442b89044f1417129551ffd.1778688966.git.pav@iki.fi>
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
2.54.0

