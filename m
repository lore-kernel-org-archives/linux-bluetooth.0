Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277793451A6
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392820; cv=pass; b=UkbCU5ha387HNgVZDnfQcFkPAnmIippZQ52/ZzPF4jmYXfRuAoMIWhFjXzP9jwa+10nY7dPIK7BJk1NfL7bNqqfZNZAEQLoGp5e4zSgX2mCF2pzjaS9Uev7EAS+2uVvTg2Mthh8bIrEtTsyOjx0vq32svplBtZx7+PoFWJOMdAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392820; c=relaxed/simple;
	bh=ISKrlIYuEWro/9lX/ytK0xZCWwSiuJ6gpEn5YXD2Bho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwvWZp3S1pmRHg36OF67wmzGnFE+pBBmh4cWfrob1Ztf1gamOm7gmrcYZGBLJEGCCee6BRaO8J4GC1F3k2fHqvvkdNSDB4FXBL1psN6fSiK80cyXI96BSmRjVeer0zd6qtflN3oOaLBsn+GXef+b/efuBxQf9Bc3QWUBLv61Qow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=I7kjAfKN; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="I7kjAfKN"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpX9Q14Vpz104n;
	Sun, 05 Apr 2026 15:40:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QFAKJpmbOODJkGZVG9u64BvaO3fOqu7Q+0F65XvjIM=;
	b=I7kjAfKNyJszNJz2Nz2CNubZNl+/bc6hT/UCKj4Gdq7dhEzc0vJXGRb3hhx2KQtTl9b9t7
	Y2FYxjPKpPFmstCN2hqkmtliXhtELYK0Lo/EXb2qTI4I8CfXPIINbf942Uh8WCMbf47cWP
	fmZO9jtQ5NYb2JzKSIA4FD+UGDLruT4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3QFAKJpmbOODJkGZVG9u64BvaO3fOqu7Q+0F65XvjIM=;
	b=WhWjHlUVcctWJ8ZRSUcbLg8xyYobXpAjO9zxSUIa9HIymAMs/32HeKuYVmhuMsELNq4IK+
	IuFLuKZMl5cVwB5HZkjRJ/hanXGmUND0PvVZ4mN6Im3DTog8piFBKqVLVLRPStf5nCmswB
	7HuXEFahqmsBvtxBj4XpcL6drXOOpfo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392810;
	b=p4oz/3G6KwJOSecA52djezFMXqZXKQc1bRZ8rc7ivN/G/qKBMTKk9bdRV6fYkqJ64iy4pa
	nra/r0k6RUbLqqdysUX2MFoCzgjF0YQ4h7Y217HFVZMs3Lsdo5Fsb3d4OzzP6ftRr9zWiX
	cXt/+GGtb7WWw4Zne7wcR9jl8UkAPUk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 08/20] doc: enable CONFIG_VIRTIO_CONSOLE in tester config
Date: Sun,  5 Apr 2026 15:39:49 +0300
Message-ID: <bd6e370babbd3311cca65ea8fd36fb23caa8c3b2.1775392680.git.pav@iki.fi>
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
2.53.0

