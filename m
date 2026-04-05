Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B42749ED
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392877; cv=pass; b=d3uqcW62K2BbcXIIq0WmVllhr+ZL9BTtUtaMVVRjjVQ0K5WoBqE1SMP1G0fm/YRxjdTMvVMJfe+Zxym6JYL7ErWRSDhjCueTRdP5DDeu8N46QubahX2HIM3dZtJQ4OZ+ZZWli4SrVD5AcKcHS+VL0U74s9D9+xo3Klm8nTTZXgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392877; c=relaxed/simple;
	bh=oZdY4I3l6Eft1UrkvARddHl6Q3vrsowIJNSfH7U7N9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYtelVg+uZrhXrPEGZe2a6kCJ+PtMd/cGXF/btUqlBRJ/dvmZeTypyoVKJOASL3mYiP7bTh19hzFKKjL9vdK5tS1ULBmX93awYHxId4bdbOozPPYuttgew4VEvHQy68700BS3oBADpO4ktK2WPIDDxbttBTFBjpg2LVfiA+C154=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cv8iaYwI; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cv8iaYwI"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpXBd6jg0zyQH;
	Sun, 05 Apr 2026 15:41:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwoyNtcIj0iD6Cp9EXbxWYAiDu3cF2W2Gv8+zFdwr9o=;
	b=cv8iaYwII5QQFpfuKef4fr2BHp9/kn60Uygn7CKElKgUHOoQFVOA+4g39sbWGo2dg2w3RQ
	mqsNIl22Mo8Jbv0fyt4CWiG2HHvwsq6yurPij8wdC0iWJbN7PV3Do3esNy1hBma7mpP+Pz
	V+JYa6H81JkzVti6nweONCTOreaxdtg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwoyNtcIj0iD6Cp9EXbxWYAiDu3cF2W2Gv8+zFdwr9o=;
	b=F7uRmk49jf0tfe/mcENpeMixD6u/M1OYtWNocGTRd5VANbb8rdG89nqS0o7k8AfbHLyitX
	tHdnIxBiRmcV4P5xHHgVhQomiK70PcwfGP2NOhKmn7v1rm8OHgzSkGJiZbrYmXacft7j5E
	U5sRzFvH9Decl2E1rq/ORYQVDscKveg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392874;
	b=TyBQyOTB4h4y5FuE/n9ACyljfEeFiqkVRBU9nNfAyeAv2qeqhbUJ73rKfK0wMJwv2KYesD
	0RqIUY37N+86W9NdUmAAZN8FEwjDaXgxc5/TiFW3XdLZmfKZLbCrX+SW4B1KDBPnqvxFUu
	lgqoyNbsMp2Gu0twULj+U+GuBMja9pY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 10/20] doc: enable KVM paravirtualization & clock support in tester kernel config
Date: Sun,  5 Apr 2026 15:39:51 +0300
Message-ID: <a3b41980fa769224bf6aa7f00c8fe28917384048.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
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

