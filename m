Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A92FA0C7
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215029; cv=pass; b=uX5C60w62nv8Vird/iYwcmiTEk+s09ZPl/jF0UG8KPBj6ZDO5kaHARENCpJcr7Tit4WyjJDCo6un4crqmX+6fTLc+B7Clem56DeAJKv9AH/CnK5Qe8g54TjuW3DDlOVI8cQAvKhWXB3Peum1ZGJzlH/AiP7WKG4aueqU8X9P4vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215029; c=relaxed/simple;
	bh=oZdY4I3l6Eft1UrkvARddHl6Q3vrsowIJNSfH7U7N9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lm2sHuvVI+S/XLmD2ct5ajX7J5YxbMMezIAGrJF/t1DwF8V7a8hwhoRlmh/vY2gMkzunOEhOqFkP8bV24iVK/e+Rrrpy83eixg6E74PpEb1KkFX4On99PdDebrx8tPGs7aRZ7pmxNd4eniQBU/OEO321O3lD7FECkFUXwSQF3hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HK4Vv7db; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HK4Vv7db"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8bk47zQzyR6;
	Sun, 22 Mar 2026 23:30:26 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwoyNtcIj0iD6Cp9EXbxWYAiDu3cF2W2Gv8+zFdwr9o=;
	b=HK4Vv7dbv4yM9QVpDYrqCV/PFGWTZaWL8ojLg6GLazylH7hZEdGzjsiJ9prMQE3HmipymI
	yVuRdnjuN+719g8hbqvVPGnEhx/Sv/M+akeWaoutmX1iRLc25RH86Y6YhfcCKZxoUHC/8U
	S9yN4/ErwgjMs7cK0P2T/u71XSgG2N0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215026;
	b=Z1lOoMcn2d9HtJHJnMhYVZ3DVe8bRsjBzaUd5wU/g4R83yUczisjdx6ElS40lzUiZWuUs4
	A53Isu0KwMqeTue/9fW6DhhXx0PU5TE3eChMwshiHPfOLGNSA6R7xZhFF+zoDBqf9KFaJ3
	UEoKV2m2b+nSxlRcBpnkMcS5G4Fhtf4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwoyNtcIj0iD6Cp9EXbxWYAiDu3cF2W2Gv8+zFdwr9o=;
	b=fgsOkuU2slICNDF3kcUzG48TDYctNuq8WvcjIOTlFfmeMn9lBi9aEPHqNvQtXTtJiGi2qk
	nEleeaMeXM+JmZpcgvb/X4FR7W7Nak0FkmxRGwG0AmS7n9QyipnS7hTL4OgKQZuvRZm8SE
	k6KHk0xKYvC8U+MosQ+hZVGM2m/DqDU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 10/20] doc: enable KVM paravirtualization & clock support in tester kernel config
Date: Sun, 22 Mar 2026 23:29:59 +0200
Message-ID: <130e3add442facc7f4ba348f5d970d3b6e90b3a6.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
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

